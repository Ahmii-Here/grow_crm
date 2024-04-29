<?php

/** --------------------------------------------------------------------------------
 * This repository class manages all the data absctration for appointments
 *
 * @package    Grow CRM
 * @author     NextLoop
 *----------------------------------------------------------------------------------*/

namespace App\Repositories;

use App\Models\Appointment;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\File;
use Illuminate\Support\Facades\Schema;
use Illuminate\Support\Str;
use Log;

class AppointmentRepository {

    /**
     * The appointments repository instance.
     */
    protected $appointments;

    /**
     * Inject dependecies
     */
    public function __construct(Appointment $appointments) {
        $this->appointments = $appointments;
    }

    /**
     * Search model
     * @param int $id optional for getting a single, specified record
     * @return object appointment collection
     */
    public function search($id = '', $data = []) {

        $appointments = $this->appointments->newQuery();

        //default - always apply filters
        if (!isset($data['apply_filters'])) {
            $data['apply_filters'] = true;
        }

        //joins
        // $appointments->leftJoin('projects', 'projects.project_id', '=', 'appointments.appointment_projectid');
        // $appointments->leftJoin('milestones', 'milestones.milestone_id', '=', 'appointments.appointment_milestoneid');
        $appointments->leftJoin('users', 'users.id', '=', 'appointments.appointment_creatorid');
        // $appointments->leftJoin('clients', 'clients.client_id', '=', 'projects.project_clientid');
        $appointments->leftJoin('appointments_status', 'appointments_status.appointmentstatus_id', '=', 'appointments.appointment_status');
        $appointments->leftJoin('appointments_priority', 'appointments_priority.appointmentpriority_id', '=', 'appointments.appointment_priority');

        //join: users reminders - do not do this for cronjobs
        if (auth()->check()) {
            $appointments->leftJoin('reminders', function ($join) {
                $join->on('reminders.reminderresource_id', '=', 'appointments.appointment_id')
                    ->where('reminders.reminderresource_type', '=', 'appointment')
                    ->where('reminders.reminder_userid', '=', auth()->id());
            });
        }

        //my id
        $myid = auth()->id();

        // all client fields
        $appointments->selectRaw('*');

        //count unread notifications
        $appointments->selectRaw('(SELECT COUNT(*)
                                      FROM events_tracking
                                      LEFT JOIN events ON events.event_id = events_tracking.eventtracking_eventid
                                      WHERE eventtracking_userid = ' . auth()->id() . '
                                      AND events_tracking.eventtracking_status = "unread"
                                      AND events.event_parent_type = "appointment"
                                      AND events.event_parent_id = appointments.appointment_id
                                      AND events.event_item = "comment")
                                      AS count_unread_comments');

        //count unread notifications
        $appointments->selectRaw('(SELECT COUNT(*)
                                      FROM events_tracking
                                      LEFT JOIN events ON events.event_id = events_tracking.eventtracking_eventid
                                      WHERE eventtracking_userid = ' . auth()->id() . '
                                      AND events_tracking.eventtracking_status = "unread"
                                      AND events.event_parent_type = "appointment"
                                      AND events.event_parent_id = appointments.appointment_id
                                      AND events.event_item = "attachment")
                                      AS count_unread_attachments');

        //sum all timers for this appointment
        $appointments->selectRaw('(SELECT COALESCE(SUM(timer_time), 0)
                                           FROM timers WHERE timer_appointmentid = appointments.appointment_id)
                                           AS sum_all_time');

        //sum my timers for this appointment
        $appointments->selectRaw("(SELECT COALESCE(SUM(timer_time), 0)
                                           FROM timers WHERE timer_appointmentid = appointments.appointment_id
                                           AND timer_creatorid = $myid)
                                           AS sum_my_time");

        //sum invoiced time
        $appointments->selectRaw("(SELECT COALESCE(SUM(timer_time), 0)
                                           FROM timers WHERE timer_appointmentid = appointments.appointment_id
                                           AND timer_billing_status = 'invoiced')
                                           AS sum_invoiced_time");

        //sum not invoiced time
        $appointments->selectRaw("(SELECT COALESCE(SUM(timer_time), 0)
                                           FROM timers WHERE timer_appointmentid = appointments.appointment_id
                                           AND timer_billing_status = 'not_invoiced')
                                           AS sum_not_invoiced_time");

        //dependency - count blockings
        $appointments->selectRaw('(SELECT COUNT(*)
                                      FROM appointments_dependencies
                                      WHERE appointmentsdependency_appointmentid = appointments.appointment_id
                                      AND appointments_dependencies.appointmentsdependency_type = "cannot_start"
                                      AND appointments_dependencies.appointmentsdependency_status = "active")
                                      AS count_dependency_cannot_start');

        //dependency - count blockings
        $appointments->selectRaw('(SELECT COUNT(*)
                                      FROM appointments_dependencies
                                      WHERE appointmentsdependency_appointmentid = appointments.appointment_id
                                      AND appointments_dependencies.appointmentsdependency_type = "cannot_start"
                                      AND appointments_dependencies.appointmentsdependency_status = "fulfilled")
                                      AS count_dependency_cannot_start_fullfilled');

        $appointments->selectRaw('(SELECT COUNT(*)
                                      FROM appointments_dependencies
                                      WHERE appointmentsdependency_appointmentid = appointments.appointment_id
                                      AND appointments_dependencies.appointmentsdependency_type = "cannot_complete"
                                      AND appointments_dependencies.appointmentsdependency_status = "active")
                                      AS count_dependency_cannot_complete');

        $appointments->selectRaw('(SELECT COUNT(*)
                                      FROM appointments_dependencies
                                      WHERE appointmentsdependency_appointmentid = appointments.appointment_id
                                      AND appointments_dependencies.appointmentsdependency_type = "cannot_complete"
                                      AND appointments_dependencies.appointmentsdependency_status = "fulfilled")
                                      AS count_dependency_cannot_complete_fulfilled');
        //default where
        $appointments->whereRaw("1 = 1");

        //filter for active or archived (default to active) - do not use this when a appointment id has been specified
        if (!is_numeric($id)) {
            if (!request()->filled('filter_show_archived_appointments') && !request()->filled('filter_appointment_state')) {
                $appointments->where('appointment_active_state', 'active');
            }
        }

        //filters: id
        if (request()->filled('filter_appointment_id')) {
            $appointments->where('appointment_id', request('filter_appointment_id'));
        }
        if (is_numeric($id)) {
            $appointments->where('appointment_id', $id);
        }

        //do not show items that not yet ready (i.e exclude items in the process of being cloned that have status 'invisible')
        $appointments->where('appointment_visibility', 'visible');

        //by default, show only project appointments
        if (request('filter_project_type') == 'project') {
            // $appointments->where('appointment_projectid', '>', 0);
        }

        //apply filters
        if ($data['apply_filters']) {

            //filter archived appointments
            if (request()->filled('filter_appointment_state') && (request('filter_appointment_state') == 'active' || request('filter_appointment_state') == 'archived')) {
                $appointments->where('appointment_active_state', request('filter_appointment_state'));
            }

            //filter clients
            if (request()->filled('filter_appointment_clientid')) {
                $appointments->where('appointment_clientid', request('filter_appointment_clientid'));
            }

            //filter: added date (start)
            if (request()->filled('filter_appointment_date_start_start')) {
                $appointments->whereDate('appointment_date_start', '>=', request('filter_appointment_date_start_start'));
            }

            //filter: added date (end)
            if (request()->filled('filter_appointment_date_start_end')) {
                $appointments->whereDate('appointment_date_start', '<=', request('filter_appointment_date_start_end'));
            }

            //filter: due date (start)
            if (request()->filled('filter_appointment_date_due_start')) {
                $appointments->whereDate('appointment_date_due', '>=', request('filter_appointment_date_due_start'));
            }

            //filter: start date (end)
            if (request()->filled('filter_appointment_date_due_end')) {
                $appointments->whereDate('appointment_date_due', '<=', request('filter_appointment_date_due_end'));
            }

            //filter milestone id
            if (request()->filled('filter_appointment_milestoneid')) {
                $appointments->where('appointment_milestoneid', request('filter_appointment_milestoneid'));
            }

            //filter: only appointments visible to the client
            if (request()->filled('filter_appointment_client_visibility')) {
                $appointments->where('appointment_client_visibility', request('filter_appointment_client_visibility'));
            }

            //resource filtering
            if (request()->filled('appointmentresource_id')) {
                $appointments->where('appointment_projectid', request('appointmentresource_id'));
            }

            //filter single appointment status
            if (request()->filled('filter_single_appointment_status')) {
                $appointments->where('appointment_status', request('filter_single_appointment_status'));
            }

            //stats: - counting
            if (isset($data['stats']) && $data['stats'] == 'count-in-progress') {
                $appointments->where('appointment_status', 'in_progress');
            }

            //stats: - counting
            if (isset($data['stats']) && $data['stats'] == 'count-testing') {
                $appointments->where('appointment_status', 'testing');
            }

            //stats: - counting
            if (isset($data['stats']) && $data['stats'] == 'count-awaiting-feedback') {
                $appointments->where('appointment_status', 'awaiting_feedback');
            }

            //stats: - counting
            if (isset($data['stats']) && $data['stats'] == 'count-completed') {
                $appointments->where('appointment_status', 'completed');
            }

            //filter: only appointments visible to the client - as per project permissions
            if (request()->filled('filter_as_per_project_permissions')) {
                $appointments->where('clientperm_appointments_view', 'yes');
            }

            //filter: project
            if (request()->filled('filter_appointment_projectid')) {
                $appointments->where('appointment_projectid', request('filter_appointment_projectid'));
            }

            //filter status
            if (is_array(request('filter_appointments_status')) && !empty(array_filter(request('filter_appointments_status')))) {
                $appointments->whereIn('appointment_status', request('filter_appointments_status'));
            }

            //filter project
            if (is_array(request('filter_appointment_projectid'))) {
                $appointments->whereIn('appointment_projectid', request('filter_appointment_projectid'));
            }

            //filter priority
            if (is_array(request('filter_appointment_priority')) && !empty(array_filter(request('filter_appointment_priority')))) {
                $appointments->whereIn('appointment_priority', request('filter_appointment_priority'));
            }

            //filter: hide completed appointments
            if (request()->filled('filter_hide_completed_appointments') && request('filter_appointments_status') != 2) {
                $appointments->whereNotIn('appointment_status', [2]);
            }

            //filter assigned
            if (is_array(request('filter_assigned')) && !empty(array_filter(request('filter_assigned')))) {
                $appointments->whereHas('assigned', function ($query) {
                    $query->whereIn('appointmentsassigned_userid', request('filter_assigned'));
                });
            }

            //filter: tags
            if (is_array(request('filter_tags')) && !empty(array_filter(request('filter_tags')))) {
                $appointments->whereHas('tags', function ($query) {
                    $query->whereIn('tag_title', request('filter_tags'));
                });
            }

            //filter my appointments (using the actions button)
            if (request()->filled('filter_my_appointments')) {
                $appointments->whereHas('assigned', function ($query) {
                    $query->whereIn('appointmentsassigned_userid', [auth()->id()]);
                });
            }

            //filter my appointments
            if (request()->filled('lead')) {
                $appointments->where('lead_id', request('lead'));
            }
        }

        //custom fields filtering
        if (request('action') == 'search') {
            if ($fields = \App\Models\CustomField::Where('customfields_type', 'appointments')->Where('customfields_show_filter_panel', 'yes')->get()) {
                foreach ($fields as $field) {
                    //field name, as posted by the filter panel (e.g. filter_ticket_custom_field_70)
                    $field_name = 'filter_' . $field->customfields_name;
                    if ($field->customfields_name != '' && request()->filled($field_name)) {
                        if (in_array($field->customfields_datatype, ['number', 'decimal', 'dropdown', 'date', 'checkbox'])) {
                            $appointments->Where($field->customfields_name, request($field_name));
                        }
                        if (in_array($field->customfields_datatype, ['text', 'paragraph'])) {
                            $appointments->Where($field->customfields_name, 'LIKE', '%' . request($field_name) . '%');
                        }
                    }
                }
            }
        }

        //search: various client columns and relationships (where first, then wherehas)
        if (request()->filled('search_query') || request()->filled('query')) {
            $appointments->where(function ($query) {
                $query->Where('appointment_id', '=', request('search_query'));
                $query->orWhere('appointment_date_start', 'LIKE', '%' . date('Y-m-d', strtotime(request('search_query'))) . '%');
                $query->orWhere('appointment_date_due', 'LIKE', '%' . date('Y-m-d', strtotime(request('search_query'))) . '%');
                $query->orWhere('appointment_title', 'LIKE', '%' . request('search_query') . '%');
                $query->orWhere('appointment_priority', '=', request('search_query'));
                //$query->orWhereRaw("YEAR(appointment_date_start) = ?", [request('search_query')]); //example binding - buggy
                //$query->orWhereRaw("YEAR(appointment_date_due) = ?", [request('search_query')]); //example binding  - buggy

                $query->orWhere('appointmentstatus_title', '=', request('search_query'));
                $query->orWhereHas('tags', function ($q) {
                    $q->where('tag_title', 'LIKE', '%' . request('search_query') . '%');
                });
                $query->orWhereHas('assigned', function ($q) {
                    $q->where('first_name', '=', request('search_query'));
                    $q->where('last_name', '=', request('search_query'));
                });
            });
        }

        //sorting
        if (in_array(request('sortorder'), array('desc', 'asc')) && request('orderby') != '') {
            //direct column name
            if (Schema::hasColumn('appointments', request('orderby'))) {
                $appointments->orderBy(request('orderby'), request('sortorder'));
            }
            //others
            switch (request('orderby')) {
            case 'project':
                $appointments->orderBy('project_title', request('sortorder'));
                break;
            case 'time':
                $appointments->orderBy('timers_sum', request('sortorder'));
                break;
            }
        } else {
            //default sorting
            if (request('query_type') == 'kanban') {
                $appointments->orderBy('appointment_position', 'asc');
            } else {
                $appointments->orderBy('appointment_id', 'desc');
            }
        }

        //eager load
        $appointments->with([
            'tags',
            'timers',
            'assigned',
            'projectmanagers',
        ]);

        //count relationships
        $appointments->withCount([
            'tags',
            'comments',
            'attachments',
            'timers',
            'checklists',
        ]);

        //stats - count all
        if (isset($data['stats']) && in_array($data['stats'], [
            'count-in-progress',
            'count-testing',
            'count-awaiting-feedback',
            'count-completed',
        ])) {
            return $appointments->count();
        }

        // Get the results and return them.
        if (request('query_type') == 'kanban') {
            return $appointments->paginate(config('system.settings_system_kanban_pagination_limits'));
            //return $appointments->paginate(1000); //temporary solution until a better one
        } else {
            return $appointments->paginate(config('system.settings_system_pagination_limits'));
        }
    }

    /**
     * Create a new record
     * @param int $position new position of the record
     * @return mixed object|bool
     */
    public function create($position = '') {

        //validate
        if (!is_numeric($position)) {
            Log::error("validation error - invalid params", ['process' => '[AppointmentRepository]', config('app.debug_ref'), 'function' => __function__, 'file' => basename(__FILE__), 'line' => __line__, 'path' => __file__]);
            return false;
        }

        //save new user
        $appointment = new $this->appointments;

        //data
        $appointment->appointment_creatorid = auth()->id();
        $appointment->lead_id = request('lead_id');
        if (request('appointment_projectid')) {
            $appointment->appointment_projectid = request('appointment_projectid');
            $appointment->appointment_milestoneid = request('appointment_milestoneid');
            $appointment->appointment_clientid = request('appointment_clientid');
        }
        $appointment->appointment_date_due = (!request()->filled('appointment_date_due')) ? NULL : request('appointment_date_due');
        $appointment->appointment_title = request('appointment_title');
        $appointment->appointment_description = request('appointment_description');
        $appointment->appointment_client_visibility = (request('appointment_client_visibility') == 'on') ? 'yes' : 'no';
        $appointment->appointment_billable = (request('appointment_billable') == 'on') ? 'yes' : 'no';
        $appointment->appointment_status = request('appointment_status');
        $appointment->appointment_priority = request('appointment_priority');
        $appointment->appointment_position = $position;

        //save and return id
        if ($appointment->save()) {
            //apply custom fields data
            $this->applyCustomFields($appointment->appointment_id);
            return $appointment->appointment_id;
        } else {
            Log::error("record could not be saved - database error", ['process' => '[AppointmentRepository]', config('app.debug_ref'), 'function' => __function__, 'file' => basename(__FILE__), 'line' => __line__, 'path' => __file__]);
            return false;
        }
    }

    /**
     * update a record
     * @param int $id record id
     * @return mixed bool or id of record
     */
    public function timerStop($id) {

        //get the record
        if (!$item = $this->items->find($id)) {
            return false;
        }

        //general
        $item->item_categoryid = request('item_categoryid');
        $item->item_description = request('item_description');
        $item->item_unit = request('item_unit');
        $item->item_rate = request('item_rate');

        //save
        if ($item->save()) {
            return $item->item_id;
        } else {
            Log::error("record could not be updated - database error", ['process' => '[AppointmentRepository]', config('app.debug_ref'), 'function' => __function__, 'file' => basename(__FILE__), 'line' => __line__, 'path' => __file__]);
            return false;
        }
    }

    /**
     * update a record
     * @param int $id record id
     * @return mixed int|bool
     */
    public function update($id) {

        //get the record
        if (!$appointment = $this->appointments->find($id)) {
            Log::error("record could not be found", ['process' => '[LeadAssignedRepository]', config('app.debug_ref'), 'function' => __function__, 'file' => basename(__FILE__), 'line' => __line__, 'path' => __file__, 'appointment_id' => $id ?? '']);
            return false;
        }

        //save
        if ($appointment->save()) {

            //apply custom fields data
            $this->applyCustomFields($appointment->appointment_id);

            return $appointment->appointment_id;
        } else {
            return false;
        }
    }

    /**
     * update model wit custom fields data (where enabled)
     */
    public function applyCustomFields($id = '') {

        //custom fields
        $fields = \App\Models\CustomField::Where('customfields_type', 'appointments')->get();
        foreach ($fields as $field) {
            if ($field->customfields_standard_form_status == 'enabled') {
                $field_name = $field->customfields_name;
                \App\Models\Appointment::where('appointment_id', $id)
                    ->update([
                        "$field_name" => request($field_name),
                    ]);
            }
        }
    }

    /**
     * clone a appointments
     * @return bool
     */
    public function cloneAppointment($appointment = '', $project = '', $data = []) {

        //we are copying
        $new_appointment = $appointment->replicate();
        $new_appointment->appointment_created = now();
        $new_appointment->appointment_creatorid = (isset($data['recurring_cron']) && $data['recurring_cron']) ? $appointment->appointment_creatorid : auth()->id();
        $new_appointment->appointment_title = $data['appointment_title'];
        $new_appointment->appointment_status = $data['appointment_status'];
        $new_appointment->appointment_clientid = $project->project_clientid;
        $new_appointment->appointment_projectid = $project->project_id;
        $new_appointment->appointment_date_start = now();
        $new_appointment->appointment_date_due = $appointment->appointment_date_due;
        $new_appointment->appointment_active_state = 'active';
        $new_appointment->appointment_billable_status = 'not_invoiced';
        $new_appointment->appointment_billable_invoiceid = null;
        $new_appointment->appointment_billable_lineitemid = null;
        $new_appointment->appointment_milestoneid = $data['appointment_milestoneid'];

        //cleanup incase parent was a recurring appointment
        $new_appointment->appointment_recurring = 'no';
        $new_appointment->appointment_recurring_duration = null;
        $new_appointment->appointment_recurring_period = null;
        $new_appointment->appointment_recurring_cycles = 0;
        $new_appointment->appointment_recurring_cycles_counter = 0;
        $new_appointment->appointment_recurring_last = null;
        $new_appointment->appointment_recurring_next = null;
        $new_appointment->appointment_recurring_child = 'no';
        $new_appointment->appointment_recurring_parent_id = null;
        $new_appointment->appointment_recurring_copy_checklists = null;
        $new_appointment->appointment_recurring_copy_files = null;
        $new_appointment->appointment_recurring_automatically_assign = null;
        $new_appointment->appointment_recurring_finished = 'no';

        $new_appointment->save();

        //copy check list
        if ($data['copy_checklist']) {
            if ($checklists = \App\Models\Checklist::Where('checklistresource_type', 'appointment')->Where('checklistresource_id', $appointment->appointment_id)->get()) {
                foreach ($checklists as $checklist) {
                    $new_checklist = $checklist->replicate();
                    $new_checklist->checklist_created = now();
                    $new_checklist->checklist_creatorid = (isset($data['recurring_cron']) && $data['recurring_cron']) ? $checklist->checklist_creatorid : auth()->id();
                    $new_checklist->checklist_clientid = $new_appointment->appointment_clientid;
                    $new_checklist->checklist_status = 'pending';
                    $new_checklist->checklistresource_type = 'appointment';
                    $new_checklist->checklistresource_id = $new_appointment->appointment_id;
                    $new_checklist->save();
                }
            }
        }

        //copy attachements
        if ($data['copy_files']) {
            if ($attachments = \App\Models\Attachment::Where('attachmentresource_type', 'appointment')->Where('attachmentresource_id', $appointment->appointment_id)->get()) {
                foreach ($attachments as $attachment) {
                    //unique key
                    $unique_key = Str::random(50);
                    //directory
                    $directory = Str::random(40);
                    //paths
                    $source = BASE_DIR . "/storage/files/" . $attachment->attachment_directory;
                    $destination = BASE_DIR . "/storage/files/$directory";
                    //validate
                    if (is_dir($source)) {
                        //copy the database record
                        $new_attachment = $attachment->replicate();
                        $new_attachment->attachment_creatorid = (isset($data['recurring_cron']) && $data['recurring_cron']) ? $attachment->attachment_creatorid : auth()->id();
                        $new_attachment->attachment_created = now();
                        $new_attachment->attachmentresource_id = $appointment->appointment_id;
                        $new_attachment->attachment_clientid = $new_appointment->appointment_clientid;
                        $new_attachment->attachment_uniqiueid = $directory;
                        $new_attachment->attachment_directory = $directory;
                        $new_attachment->attachmentresource_type = 'appointment';
                        $new_attachment->attachmentresource_id = $new_appointment->appointment_id;
                        $new_attachment->save();
                        //copy folder
                        File::copyDirectory($source, $destination);
                    }
                }
            }
        }

        //all done
        return $new_appointment;
    }

}