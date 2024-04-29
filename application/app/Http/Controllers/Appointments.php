<?php

/** --------------------------------------------------------------------------------
 * This controller manages all the business logic for appointments
 *
 * @package    Grow CRM
 * @author     NextLoop
 *----------------------------------------------------------------------------------*/

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use App\Http\Requests\Appointments\AppointmentRecurrringSettings;
use App\Http\Requests\Appointments\AppointmentStoreUpdate;
use App\Http\Responses\Appointments\ActivateResponse;
use App\Http\Responses\Appointments\ArchiveResponse;
use App\Http\Responses\Appointments\AttachFilesResponse;
use App\Http\Responses\Appointments\ChecklistResponse;
use App\Http\Responses\Appointments\CloneResponse;
use App\Http\Responses\Appointments\CloneStoreResponse;
use App\Http\Responses\Appointments\contentResponse;
use App\Http\Responses\Appointments\CreateResponse;
use App\Http\Responses\Appointments\DeleteAppointmentDependencyResponse;
use App\Http\Responses\Appointments\DestroyResponse;
use App\Http\Responses\Appointments\IndexKanbanResponse;
use App\Http\Responses\Appointments\IndexListResponse;
use App\Http\Responses\Appointments\RecurringSettingsResponse;
use App\Http\Responses\Appointments\ShowResponse;
use App\Http\Responses\Appointments\StoreChecklistResponse;
use App\Http\Responses\Appointments\StoreCommentResponse;
use App\Http\Responses\Appointments\StoreResponse;
use App\Http\Responses\Appointments\StoreAppointmentDependencyResponse;
use App\Http\Responses\Appointments\TimerStartResponse;
use App\Http\Responses\Appointments\TimerStopResponse;
use App\Http\Responses\Appointments\UpdateChecklistResponse;
use App\Http\Responses\Appointments\UpdateErrorResponse;
use App\Http\Responses\Appointments\UpdateLockedResponse;
use App\Http\Responses\Appointments\UpdateResponse;
use App\Http\Responses\Appointments\UpdateStatusLockedResponse;
use App\Http\Responses\Appointments\UpdateStatusResponse;
use App\Http\Responses\Appointments\UpdateTagsResponse;
use App\Mail\AppointmentStatusChanged;
use App\Models\Checklist;
use App\Models\Comment;
use App\Models\Appointment;
use App\Models\Timer;
use App\Permissions\AttachmentPermissions;
use App\Permissions\ChecklistPermissions;
use App\Permissions\CommentPermissions;
use App\Permissions\ProjectPermissions;
use App\Permissions\AppointmentPermissions;
use App\Repositories\AttachmentRepository;
use App\Repositories\CategoryRepository;
use App\Repositories\ChecklistRepository;
use App\Repositories\CommentRepository;
use App\Repositories\CustomFieldsRepository;
use App\Repositories\DestroyRepository;
use App\Repositories\EmailerRepository;
use App\Repositories\EventRepository;
use App\Repositories\EventTrackingRepository;
use App\Repositories\ProjectAssignedRepository;
use App\Repositories\ProjectRepository;
use App\Repositories\TagRepository;
use App\Repositories\AppointmentAssignedRepository;
use App\Repositories\AppointmentDependencyRepository;
use App\Repositories\AppointmentRepository;
use App\Repositories\AppointmentStatusRepository;
use App\Repositories\TimerRepository;
use App\Repositories\UserRepository;
use App\Rules\CheckBox;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Mail;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Str;
use Image;
use Intervention\Image\Exception\NotReadableException;
use Validator;

class Appointments extends Controller {

    protected $appointmentrepo;
    protected $tagrepo;
    protected $userrepo;
    protected $timerrepo;
    protected $appointmentmodel;
    protected $commentpermissions;
    protected $attachmentpermissions;
    protected $checklistpermissions;
    protected $appointmentpermissions;
    protected $eventrepo;
    protected $trackingrepo;
    protected $emailerrepo;
    protected $customrepo;
    protected $projectpermission;
    protected $dependencyrepo;

    public function __construct(
        AppointmentRepository $appointmentrepo,
        TagRepository $tagrepo,
        UserRepository $userrepo,
        TimerRepository $timerrepo,
        AppointmentPermissions $appointmentpermissions,
        CommentPermissions $commentpermissions,
        AttachmentPermissions $attachmentpermissions,
        ChecklistPermissions $checklistpermissions,
        EventRepository $eventrepo,
        EventTrackingRepository $trackingrepo,
        EmailerRepository $emailerrepo,
        Appointment $appointmentmodel,
        CustomFieldsRepository $customrepo,
        AppointmentStatusRepository $statusrepo,
        ProjectPermissions $projectpermission,
        AppointmentDependencyRepository $dependencyrepo
    ) {

        //core controller instantation
        parent::__construct();

        $this->appointmentrepo = $appointmentrepo;
        $this->tagrepo = $tagrepo;
        $this->userrepo = $userrepo;
        $this->appointmentpermissions = $appointmentpermissions;
        $this->appointmentmodel = $appointmentmodel;
        $this->commentpermissions = $commentpermissions;
        $this->attachmentpermissions = $attachmentpermissions;
        $this->checklistpermissions = $checklistpermissions;
        $this->timerrepo = $timerrepo;
        $this->eventrepo = $eventrepo;
        $this->trackingrepo = $trackingrepo;
        $this->emailerrepo = $emailerrepo;
        $this->customrepo = $customrepo;
        $this->projectpermission = $projectpermission;
        $this->dependencyrepo = $dependencyrepo;

        //authenticated
        $this->middleware('auth');

        //route middleware
        $this->middleware('appointmentsMiddlewareTimer')->only([
            'timerStart',
            'timerStop',
            'timerStopAll',
        ]);

        //Permissions on methods
        $this->middleware('appointmentsMiddlewareIndex')->only([
            'index',
            'update',
            'toggleStatus',
            'store',
            'updateStartDate',
            'updateDueDate',
            'updateStatus',
            'updatePriority',
            'updateVisibility',
            'updateMilestone',
            'updateAssigned',
            'timerStart',
            'timerStop',
            'timerStopAll',
            'archive',
            'activate',
            'cloneStore',
            'recurringSettingsUpdate',
            'stopRecurring',
            'storeDependency',
            'deleteDependency',
        ]);

        $this->middleware('appointmentsMiddlewareCreate')->only([
            'create',
            'store',
        ]);

        $this->middleware('appointmentsMiddlewareShow')->only([
            'show',
            'showCustomFields',
            'updateCustomFields',
            'showMyNotes',
            'createMyNotes',
            'editMyNotes',
            'deleteMyNotes',
        ]);

        $this->middleware('appointmentsMiddlewareEdit')->only([
            'updateDescription',
            'updateTitle',
            'updateStartDate',
            'updateDueDate',
            'updateVisibility',
            'updateMilestone',
            'updateAssigned',
            'storeChecklist',
            'archive',
            'activate',
            'editCustomFields',
            'updateCustomFields',
            'updateTags',
            'recurringSettings',
            'recurringSettingsUpdate',
        ]);

        $this->middleware('appointmentsMiddlewareParticipate')->only([
            'storeComment',
            'attachFiles',
            'updateStatus',
            'updatePriority',
        ]);

        $this->middleware('appointmentsMiddlewareDeleteAttachment')->only([
            'deleteAttachment',
        ]);

        $this->middleware('appointmentsMiddlewareDownloadAttachment')->only([
            'downloadAttachment',
        ]);

        $this->middleware('appointmentsMiddlewareDeleteComment')->only([
            'deleteComment',
        ]);

        $this->middleware('appointmentsMiddlewareEditDeleteChecklist')->only([
            'updateChecklist',
            'deleteChecklist',
            'toggleChecklistStatus',
        ]);

        $this->middleware('appointmentsMiddlewareDestroy')->only([
            'destroy',
        ]);

        $this->middleware('appointmentsMiddlewareAssign')->only([
            'updateAssigned',
        ]);

        $this->middleware('appointmentsMiddlewareCloning')->only([
            'cloneAppointment',
            'cloneStore',
        ]);

        $this->middleware('appointmentsMiddlewareManageDependencies')->only([
            'storeDependency',
            'deleteDependency',
        ]);
    }

    /**
     * Display a listing of appointments
     * @return \Illuminate\Http\Response
     */

    public function index() {
        if (auth()->user()->pref_view_appointments_layout == 'list') {
            $payload = $this->indexList();
            return new IndexListResponse($payload);
        } else {
            $payload = $this->indexKanban();
            // echo "<pre>";print_r($payload);die;
            return new IndexKanbanResponse($payload);
        }
    }

    /**
     * Display a listing of appointments
     * @return \Illuminate\Http\Response
     */
    public function indexList() {

        //defaults
        $milestones = [];

        //get stats before other filters has been applied
        $stats = $this->statsWidget();

        //get appointments
        $appointments = $this->appointmentrepo->search();

        //count rows
        $count = $appointments->total();

        //process for timers
        $this->processAppointments($appointments);

        //apply some permissions
        if ($appointments) {
            foreach ($appointments as $appointment) {
                $this->applyPermissions($appointment);
            }
        }

        //basic page settings
        $page = $this->pageSettings('appointments', ['count' => $count]);

        //page setting for embedded view
        if (request('source') == 'ext') {
            $page = $this->pageSettings('ext', ['count' => $count]);
        }

        //get all tags (type: lead) - for filter panel
        $tags = $this->tagrepo->getByType('appointment');

        //all available lead statuses
        $statuses = \App\Models\AppointmentStatus::all();

        //get all milestones if viewing from project page (for use in filter panel)
        if (request()->filled('appointmentresource_id') && request('appointmentresource_type') == 'project') {
            $milestones = \App\Models\Milestone::Where('milestone_projectid', request('appointmentresource_id'))->get();
        }

        $priorities = \App\Models\AppointmentPriority::orderBy('appointmentpriority_position', 'asc')->get();

        //reponse payload
        $payload = [
            'page' => $page,
            'milestones' => $milestones,
            'appointments' => $appointments,
            'stats' => $stats,
            'tags' => $tags,
            'statuses' => $statuses,
            'priorities' => $priorities,
            'fields' => $this->getCustomFields(),
        ];

        //show the view
        return $payload;
    }

    /**
     * Display a listing of appointments
     * @return \Illuminate\Http\Response
     */
    public function indexKanban() {

        //defaults
        $milestones = [];

        //get stats before other filters has been applied
        $stats = $this->statsWidget();

        $boards = $this->appointmentBoards();

        //basic page settings
        $page = $this->pageSettings('appointments', []);

        //page setting for embedded view
        if (request('source') == 'ext') {
            $page = $this->pageSettings('ext', []);
        }

        //get all tags (type: lead) - for filter panel
        $tags = $this->tagrepo->getByType('appointment');

        //all available lead statuses
        $statuses = \App\Models\AppointmentStatus::all();

        //get all milestones if viewing from project page (for use in filter panel)
        if (request()->filled('appointmentresource_id') && request('appointmentresource_type') == 'project') {
            $milestones = \App\Models\Milestone::Where('milestone_projectid', request('appointmentresource_id'))->get();
        }

        //check if the user has participation rights on the appointment
        if (auth()->user()->is_client) {
            if (request()->filled('appointmentresource_id') && request('appointmentresource_type') == 'project') {
                if ($this->projectpermission->check('appointments-participate', request('appointmentresource_id'))) {
                    config(['visibility.appointments_participate' => true]);
                }
            }
        }

        $priorities = \App\Models\AppointmentPriority::orderBy('appointmentpriority_position', 'asc')->get();

        //reponse payload
        $payload = [
            'page' => $page,
            'boards' => $boards,
            'milestones' => $milestones,
            'stats' => $stats,
            'tags' => $tags,
            'statuses' => $statuses,
            'priorities' => $priorities,
            'fields' => $this->getCustomFields(),
        ];

        //show the view
        return $payload;
    }

    /**
     * process/group appointments into boards
     * @return object
     */
    private function appointmentBoards() {

        $statuses = \App\Models\AppointmentStatus::orderBy('appointmentstatus_position', 'asc')->get();

        foreach ($statuses as $status) {
            request()->merge([
                'filter_single_appointment_status' => $status->appointmentstatus_id,
                'query_type' => 'kanban',
            ]);

            //get appointments
            $appointments = $this->appointmentrepo->search();

            //count rows
            $count = $appointments->total();

            //process for timers
            $this->processAppointments($appointments);

            //apply some permissions
            if ($appointments) {
                foreach ($appointments as $appointment) {
                    $this->applyPermissions($appointment);
                }
            }

            //apply custom fields
            if ($appointments) {
                foreach ($appointments as $appointment) {
                    $appointment->fields = $this->getCustomFields($appointment);
                }
            }

            //initial loadmore button
            if ($appointments->currentPage() < $appointments->lastPage()) {
                $boards[$status->appointmentstatus_id]['load_more'] = '';
                $boards[$status->appointmentstatus_id]['load_more_url'] = loadMoreButtonUrl($appointments->currentPage() + 1, $status->appointmentstatus_id);
            } else {
                $boards[$status->appointmentstatus_id]['load_more'] = 'hidden';
                $boards[$status->appointmentstatus_id]['load_more_url'] = '';
            }

            $boards[$status->appointmentstatus_id]['name'] = $status->appointmentstatus_title;
            $boards[$status->appointmentstatus_id]['id'] = $status->appointmentstatus_id;
            $boards[$status->appointmentstatus_id]['appointments'] = $appointments;
            $boards[$status->appointmentstatus_id]['color'] = $status->appointmentstatus_color;

        }

        return $boards;
    }

    /**
     * Show the form for creating a new appointment
     * @param object CategoryRepository instance of the repository
     * @return \Illuminate\Http\Response
     */
    public function create(CategoryRepository $categoryrepo) {

        //default
        $milestones = [];

        //page settings
        $page = $this->pageSettings('create');

        //get tags
        $tags = $this->tagrepo->getByType('appointment');

        $statuses = \App\Models\AppointmentStatus::orderBy('appointmentstatus_position', 'asc')->get();

        $priorities = \App\Models\AppointmentPriority::orderBy('appointmentpriority_position', 'asc')->get();

        $leads = \App\Models\Lead::get();

        //milestones
        if (request()->filled('appointmentresource_id') && request('appointmentresource_type') == 'project') {
            $milestones = \App\Models\Milestone::Where('milestone_projectid', request('appointmentresource_id'))->get();
        }

        //get customfields
        request()->merge([
            'filter_show_standard_form_status' => 'enabled',
            'filter_field_status' => 'enabled',
            'sort_by' => 'customfields_position',
        ]);
        $fields = $this->getCustomFields();

        //reponse payload
        $payload = [
            'page' => $page,
            'tags' => $tags,
            'milestones' => $milestones,
            'stats' => $this->statsWidget(),
            'fields' => $fields,
            'statuses' => $statuses,
            'priorities' => $priorities,
            'leads' => $leads,
        ];

        //show the form
        return new CreateResponse($payload);
    }

    /**
     * get all custom fields for clients
     *   - if they are being used in the 'edit' modal form, also get the current data
     *     from the cliet record. Store this temporarily in '$field->customfields_name'
     *     this will then be used to prefill data in the custom fields
     * @param model client model - only when showing the edit modal form
     * @return collection
     */
    public function getCustomFields($obj = '') {

        //set typs
        request()->merge([
            'customfields_type' => 'appointments',
        ]);

        //show all fields
        config(['settings.custom_fields_display_limit' => 1000]);

        //get fields
        $fields = $this->customrepo->search();

        //when in editing view - get current value that is stored for this custom field
        if ($obj instanceof \App\Models\Appointment) {
            foreach ($fields as $field) {
                $field->current_value = $obj[$field->customfields_name];
            }
        }

        return $fields;
    }

    /**
     * Store a newly created appointment in storage.
     * @param object AppointmentStoreUpdate instance of the request validation object
     * @param object AppointmentAssignedRepository instance of the repository
     * @return \Illuminate\Http\Response
     */
    public function store(AppointmentStoreUpdate $request, AppointmentAssignedRepository $assignedrepo) {

        //defaults
        $assigned_users = [];

        //get client id of attached project (if this is a project appointment)
        if (1==2) {        
            $project = \App\Models\Project::find(request('appointment_projectid'));
            $client_id = $project->project_clientid;
            request()->merge([
                'appointment_clientid' => $project->project_clientid,
            ]);
        }


        //custom field validation
        if ($messages = $this->customFieldValidationFailed()) {
            abort(409, $messages);
        }


        //validate milestone id
        if (request()->filled('appointment_milestoneid') && 1==2) {
            if (!\App\Models\Milestone::where('milestone_id', request('appointment_milestoneid'))
                ->where('milestone_projectid', request('appointment_projectid'))->first()) {
                abort(409, __('lang.item_not_found'));
            }

            
        }

        //no milestone provided - get default milestone
        if (!request()->filled('appointment_milestoneid') && 1==2) {
            if ($milestone = \App\Models\Milestone::where('milestone_type', 'uncategorised')
                ->where('milestone_projectid', request('appointment_projectid'))->first()) {
                request()->merge([
                    'appointment_milestoneid' => $milestone->milestone_id,
                ]);
            } else {
                abort(409, __('lang.milestone_not_found'));
                Log::critical("add appointment - default milestone could not be found", ['process' => '[appointments]', config('app.debug_ref'), 'function' => __function__, 'file' => basename(__FILE__), 'line' => __line__, 'path' => __file__, 'project_id' => request('appointment_projectid')]);
            }
        }

        //get the last row (order by position - desc)
        if ($last = $this->appointmentmodel::orderBy('appointment_position', 'desc')->first()) {
            $position = $last->appointment_position + config('settings.db_position_increment');
        } else {
            //default position increment
            $position = config('settings.db_position_increment');
        }

        //create new record
        if (!$appointment_id = $this->appointmentrepo->create($position)) {
            abort(409);
        }

        //add tags
        $this->tagrepo->add('appointment', $appointment_id);

        /**
         * [client added appointment]
         *     - appointment will remain un-assigned
         * [team added appointment - with no assigning permission]
         *     - assigned to the user adding the appointment
         * [team added appointment - with assigning permission]
         *     - assign as per posted list (or none)
         * */
        if (auth()->user()->is_team) {
            if (auth()->user()->role->role_assign_appointments == 'no') {
                $assigned_users = $assignedrepo->add($appointment_id, auth()->id());
            } else {
                $assigned_users = $assignedrepo->add($appointment_id, '');
            }
        }

        //get the appointment object (friendly for rendering in blade template)
        $appointments = $this->appointmentrepo->search($appointment_id, ['apply_filters' => false]);
        $appointment = $appointments->first();

        //process appointment (timers)
        $this->processAppointment($appointment);

        //apply permissions
        $this->applyPermissions($appointment);

        //custom fields
        $appointment->fields = $this->getCustomFields($appointment);

        /** ----------------------------------------------
         * record assignment events and send emails
         * ----------------------------------------------*/
        foreach ($assigned_users as $assigned_user_id) {
            if ($assigned_user = \App\Models\User::Where('id', $assigned_user_id)->first()) {

                $data = [
                    'event_creatorid' => auth()->id(),
                    'event_item' => 'assigned',
                    'event_item_id' => '',
                    'event_item_lang' => 'event_assigned_user_to_a_appointment',
                    'event_item_lang_alt' => 'event_assigned_user_to_a_appointment_alt',
                    'event_item_content' => __('lang.assigned'),
                    'event_item_content2' => $assigned_user_id,
                    'event_item_content3' => $assigned_user->first_name,
                    'event_parent_type' => 'appointment',
                    'event_parent_id' => $appointment->appointment_id,
                    'event_parent_title' => $appointment->appointment_title,
                    'event_show_item' => 'yes',
                    'event_show_in_timeline' => 'yes',
                    'event_clientid' => $appointment->appointment_clientid,
                    'eventresource_type' => 'project',
                    'eventresource_id' => $appointment->appointment_projectid,
                    'event_notification_category' => 'notifications_new_assignement',
                ];
                //record event
                if ($event_id = $this->eventrepo->create($data)) {
                    //record notification (skip the user creating this event)
                    if ($assigned_user_id != auth()->id()) {
                        $emailusers = $this->trackingrepo->recordEvent($data, [$assigned_user_id], $event_id);
                    }
                }

                /** ----------------------------------------------
                 * send email [assignment]
                 * ----------------------------------------------*/
                if ($assigned_user_id != auth()->id()) {
                    if ($assigned_user->notifications_new_assignement == 'yes_email') {
                        $mail = new \App\Mail\AppointmentAssignment($assigned_user, $data, $appointment);
                        $mail->build();
                    }
                }
            }
        }

        //counting rows
        $rows = $this->appointmentrepo->search();
        $count = $rows->total();

        //reponse payload
        $payload = [
            'appointments' => $appointments,
            'appointment' => $appointment,
            'count' => $count,
            'stats' => $this->statsWidget(),
        ];

        //card view response
        if (auth()->user()->pref_view_appointments_layout == 'kanban') {
            request()->merge([
                'filter_appointment_status' => request('appointment_status'),
            ]);
            if (request()->filled('appointmentresource_id')) {
                request()->merge([
                    'filter_appointment_projectid' => request('appointment_projectid'),
                ]);
            }
            //counting rows
            $rows = $this->appointmentrepo->search();
            //payload
            $board['appointments'] = $appointments;
            $payload['board'] = $board;
            $payload['count'] = $rows->total();
        }

        //process reponse
        return new StoreResponse($payload);

    }

    /**
     * Returns false when all is ok
     * @return \Illuminate\Http\Response
     */
    public function customFieldValidationFailed() {

        //custom field validation
        $fields = \App\Models\CustomField::Where('customfields_type', 'appointments')->get();
        $errors = '';
        foreach ($fields as $field) {
            if ($field->customfields_status == 'enabled' && $field->customfields_standard_form_status == 'enabled' && $field->customfields_required == 'yes') {
                if (request($field->customfields_name) == '') {
                    $errors .= '<li>' . $field->customfields_title . ' - ' . __('lang.is_required') . '</li>';
                }
            }
        }
        //return
        if ($errors != '') {
            return $errors;
        } else {
            return false;
        }
    }

    /**
     * Display the specified appointment
     * @param object AppointmentAssignedRepository instance of the repository
     * @param object ProjectAssignedRepository instance of the repository
     * @param object CommentRepository instance of the repository
     * @param object AttachmentRepository instance of the repository
     * @param object ChecklistRepository instance of the repository
     * @param int $id appointment id
     * @return \Illuminate\Http\Response
     */
    public function show(
        AppointmentAssignedRepository $assignedrepo,
        ProjectAssignedRepository $projectassignedrepo,
        CommentRepository $commentrepo,
        AttachmentRepository $attachmentrepo,
        ChecklistRepository $checklistrepo, $id) {

        //get the appointment
        $appointments = $this->appointmentrepo->search($id);

        //appointment
        $appointment = $appointments->first();

        //[fix] -if appointment has an invalid appointment status
        if ($appointment->appointment_status == 0 || $appointment->appointment_status == null) {
            $appointment->appointment_status = 1;
            $appointment->save();
        }

        //apply permissions
        $this->applyPermissions($appointment);

        //process appointment
        $this->processAppointment($appointment);

        //get tags
        $tags_resource = $this->tagrepo->getByResource('appointment', $id);
        $tags_system = $this->tagrepo->getByType('appointment');
        $tags = $tags_resource->merge($tags_system);
        $tags = $tags->unique('tag_title');

        //get assigned users
        $assigned = $assignedrepo->getAssigned($id);

        //get team members who are assigned to this appointments project
        $project_assigned = $projectassignedrepo->getAssigned($appointment->appointment_projectid);

        //get clients users
        $client_users = \App\Models\User::Where('clientid', $appointment->appointment_clientid)->orderBy('first_name', 'asc')->get();

        //comments
        request()->merge([
            'commentresource_type' => 'appointment',
            'commentresource_id' => $id,
        ]);
        $comments = $commentrepo->search();
        foreach ($comments as $comment) {
            $this->applyCommentPermissions($comment);
        }

        //attachments
        request()->merge([
            'attachmentresource_type' => 'appointment',
            'attachmentresource_id' => $id,
        ]);
        $attachments = $attachmentrepo->search();
        foreach ($attachments as $attachment) {
            $this->applyAttachmentPermissions($attachment);
        }

        //checklists
        request()->merge([
            'checklistresource_type' => 'appointment',
            'checklistresource_id' => $id,
        ]);
        $checklists = $checklistrepo->search();
        foreach ($checklists as $checklist) {
            $this->applyChecklistPermissions($checklist);
        }

        //milestone
        $milestones = \App\Models\Milestone::Where('milestone_projectid', $appointment->appointment_projectid)->get();

        //page settings
        $page = $this->pageSettings('appointment', $appointment);

        //mark events as read
        \App\Models\EventTracking::where('parent_id', $id)
            ->where('parent_type', 'appointment')
            ->where('eventtracking_userid', auth()->id())
            ->update(['eventtracking_status' => 'read']);

        //get users reminders
        if ($reminder = \App\Models\Reminder::Where('reminderresource_type', 'appointment')
            ->Where('reminderresource_id', $id)
            ->Where('reminder_userid', auth()->id())->first()) {
            $has_reminder = true;
        } else {
            $reminder = [];
            $has_reminder = false;
        }

        //get all appointments is same project (for appointment dependencies)
        $project_appointments = \App\Models\Appointment::Where('appointment_projectid', $appointment->appointment_projectid)->orderBy('appointment_title', 'ASC')->get();

        //all dependecies
        $dependecies_all = $this->dependencyrepo->search($appointment->appointment_id);

        //all dependecies
        request()->merge([
            'filter_currently_blocking' => true,
        ]);
        $dependecies_blocking = $this->dependencyrepo->search($appointment->appointment_id);

        //reponse payload
        $payload = [
            'page' => $page,
            'appointment' => $appointment,
            'id' => $id,
            'tags' => $tags,
            'current_tags' => $appointment->tags,
            'assigned' => $assigned,
            'project_assigned' => $project_assigned,
            'comments' => $comments,
            'attachments' => $attachments,
            'checklists' => $checklists,
            'milestones' => $milestones,
            'reminder' => $reminder,
            'resource_type' => 'appointment',
            'resource_id' => $id,
            'has_reminder' => $has_reminder,
            'progress' => $this->checklistProgress($checklists),
            'client_users' => $client_users,
            'project_appointments' => $project_appointments,
            'dependecies_all' => $dependecies_all,
            'dependecies_blocking' => $dependecies_blocking,
        ];

        //showing just the tab
        if (request('show') == 'tab') {
            $payload['type'] = 'show-main';
            return new contentResponse($payload);
        }

        //response
        return new ShowResponse($payload);
    }

    /**
     * Update the specified appointment in storage.
     * @param int $id appointment id
     * @return \Illuminate\Http\Response
     */
    public function update($id) {

        //reponse payload
        $payload = [
            'stats' => $this->statsWidget(),
        ];

        //process reponse
        return new UpdateResponse($payload);
    }

    /**
     * Remove the specified appointment from storage.
     * @param object DestroyRepository instance of the repository
     * @return \Illuminate\Http\Response
     */
    public function destroy(DestroyRepository $destroyrepo) {

        //delete each record in the array
        $allrows = array();
        foreach (request('ids') as $id => $value) {

            //only checked items
            if ($value == 'on') {

                //delete the appointment and associated items
                $destroyrepo->destroyAppointment($id);

                //add to array
                $allrows[] = $id;
            }
        }

        //reponse payload
        $payload = [
            'allrows' => $allrows,
            'stats' => $this->statsWidget(),
        ];

        //generate a response
        return new DestroyResponse($payload);
    }

    /**
     * Start a users timer for a given appointment
     * @param int $id appointment id
     * @return \Illuminate\Http\Response
     */
    public function timerStart($id) {

        $action = 'start';

        //get the appointment and apply permissions
        $appointments = $this->appointmentrepo->search($id);
        $appointment = $appointments->first();
        $this->applyPermissions($appointment);

        //stop running timer for this user
        $this->timerrepo->stopRunningTimers([
            'timer_creatorid' => auth()->id(),
        ]);

        //create a new timer for this user
        if (!$this->timerrepo->createTimer($appointment)) {
            $action = 'failed';
        }

        //needed by the topnav timer dropdown
        request()->merge([
            'users_running_timer_appointment_id' => $appointment->appointment_id,
            'users_running_timer_title' => $appointment->appointment_title,
            'users_running_timer_appointment_title' => str_slug($appointment->appointment_title),
        ]);

        $payload = [
            'appointment' => $appointment,
        ];

        //process reponse
        return new TimerStartResponse($payload);
    }

    /**
     * Start a users timer for a given appointment
     * @param int $id appointment id
     * @return \Illuminate\Http\Response
     */
    public function timerStartTopnav() {

        //get the appointment and apply permissions
        $appointments = $this->appointmentrepo->search($id);
        $appointment = $appointments->first();
        $this->applyPermissions($appointment);

        //stop running timer for this user
        $this->timerrepo->stopRunningTimers([
            'timer_creatorid' => auth()->id(),
        ]);

        //create a new timer for this user
        if (!$this->timerrepo->createTimer($appointment)) {

        }

        $payload = [];

        //process reponse
        return new TimerStartResponse($payload);
    }

    /**
     * Stop a users timer for a given appointment
     * @param int $id appointment id
     * @return \Illuminate\Http\Response
     */
    public function timerStop($id) {

        //get the appointment and apply permissions
        $appointments = $this->appointmentrepo->search($id);
        $appointment = $appointments->first();
        $this->applyPermissions($appointment);

        //stop running timer for this user
        $this->timerrepo->stopRunningTimers([
            'timer_creatorid' => auth()->id(),
        ]);

        $payload = [
            'appointment_id' => $id,
        ];

        //process reponse
        return new TimerStopResponse($payload);
    }

    /**
     * Stop a users timer for a given appointment
     * @param int $id appointment id
     * @return \Illuminate\Http\Response
     */
    public function timerStopUser() {

        //stop running timer for this user
        $this->timerrepo->stopRunningTimers([
            'timer_creatorid' => auth()->id(),
        ]);

        //process reponse
        return new TimerStopResponse([]);
    }

    /**
     * Stop a users timer for a given appointment
     * @param int $id appointment id
     * @return \Illuminate\Http\Response
     */
    public function timerStopAll($id) {

        //get the appointment and apply permissions
        $appointments = $this->appointmentrepo->search($id);
        $appointment = $appointments->first();
        $this->applyPermissions($appointment);

        //stop all running timers for this appointment
        $this->timerrepo->stopRunningTimers([
            'appointment_id' => $id,
        ]);

        $payload = [
            'appointment_id' => $id,
        ];

        //process reponse
        return new TimerStopResponse($payload);
    }

    /**
     * send each appointment for processing
     * @return null
     */
    private function processAppointments($appointments = '') {
        //sanity - make sure this is a valid appointments object
        if ($appointments instanceof \Illuminate\Pagination\LengthAwarePaginator) {
            foreach ($appointments as $appointment) {
                $this->processAppointment($appointment);
            }
        }
    }

    /**
     * check the appointment for the following:
     *    1. Check if appointment is assigned to me - add 'assigned_to_me' (yes/no) attribute
     *    2. check if there are any running timers on the appointments - add 'running_timer' (yes/no)
     * @param object appointment instance of the appointment model object
     * @return object
     */
    private function processAppointment($appointment = '') {

        //sanity - make sure this is a valid appointment object
        if ($appointment instanceof \App\Models\Appointment) {

            //default values
            $appointment->assigned_to_me = false;
            $appointment->running_timers = false;
            $appointment->timer_current_status = false;
            $appointment->has_attachments = false;
            $appointment->has_comments = false;
            $appointment->has_checklist = false;

            //check if the appointment is assigned to me
            foreach ($appointment->assigned as $user) {
                if ($user->id == auth()->id()) {
                    //its assigned to me
                    $appointment->assigned_to_me = true;
                }
            }

            $appointment->has_attachments = ($appointment->attachments_count > 0) ? true : false;
            $appointment->has_comments = ($appointment->comments_count > 0) ? true : false;
            $appointment->has_checklist = ($appointment->checklists_count > 0) ? true : false;

            //check if there are any running timers
            foreach ($appointment->timers as $timer) {
                if ($timer->timer_status == 'running') {
                    //its has a running timer
                    $appointment->running_timers = true;
                    if ($timer->timer_creatorid == auth()->id()) {
                        $appointment->timer_current_status = true;
                    }
                }
            }

            //get users current/refreshed time for the appointment (if applcable)
            $appointment->my_time = $this->timerrepo->sumTimers($appointment->appointment_id, auth()->id());

            //custom fields
            $appointment->fields = $this->getCustomFields($appointment);
        }
    }

    /**
     * update appointment description
     * @param int $id appointment id
     * @return object
     */
    public function updateDescription($id) {

        $appointment = $this->appointmentmodel::find($id);
        $appointment->appointment_description = request('appointment_description');
        $appointment->save();

        //update card description
        $jsondata['dom_html'][] = [
            'selector' => '#card-description-container',
            'action' => 'replace',
            'value' => clean($appointment->appointment_description),
        ];
        $jsondata['dom_visibility'][] = [
            'selector' => '#card-description-container',
            'action' => 'show',
        ];
        return response()->json($jsondata);
    }

    /**
     * update resource
     * @param int $id appointment id
     * @return null
     */
    public function updateStartDate($id) {

        //get the appointment
        $appointments = $this->appointmentrepo->search($id);
        $appointment = $appointments->first();

        //save appointment_date_due to request so can access it n validation
        request()->merge(['appointment_date_due' => $appointment->appointment_date_due]);

        //validate
        $validator = Validator::make(request()->all(), [
            'appointment_date_start' => [
                'bail',
                'required',
                'date',
                function ($attribute, $value, $fail) {
                    if (request('appointment_date_due') != '') {
                        if (strtotime($value) > strtotime(request('appointment_date_due'))) {
                            return $fail(__('lang.start_date_must_be_before_due_date'));
                        }
                    }
                },
            ],
        ]);

        //validation errors
        if ($validator->fails()) {
            $errors = $validator->errors();
            $messages = '';
            foreach ($errors->all() as $message) {
                $messages .= "<li>$message</li>";
            }
            return new UpdateErrorResponse([
                'reset_target' => '#appointment-start-date-container',
                'reset_value' => runtimeDate($appointment->appointment_date_start),
                'error_message' => $messages,
            ]);
        }

        //update
        $appointment->appointment_date_start = request('appointment_date_start');
        $appointment->save();

        //update and apply permissions
        $this->processAppointment($appointment);
        $this->applyPermissions($appointment);

        //reponse payload
        $payload = [
            'appointments' => $appointments,
            'stats' => $this->statsWidget(),
        ];

        //process reponse
        return new UpdateResponse($payload);
    }

    /**
     * update resource
     * @param int $id appointment id
     * @return null
     */
    public function updateDueDate($id) {

        //get the appointment
        $appointments = $this->appointmentrepo->search($id);
        $appointment = $appointments->first();

        //save appointment_date_start to request so can access it in validation
        request()->merge(['appointment_date_start' => $appointment->appointment_date_start]);

        //validate
        $validator = Validator::make(request()->all(), [
            'appointment_date_due' => [
                'bail',
                'required',
                'date',
                function ($attribute, $value, $fail) {
                    if (request('appointment_date_due') != '') {
                        if (strtotime($value) < strtotime(request('appointment_date_start'))) {
                            return $fail(__('lang.due_date_must_be_after_start_date'));
                        }
                    }
                },
            ],
        ]);

        //validation errors
        if ($validator->fails()) {
            $errors = $validator->errors();
            $messages = '';
            foreach ($errors->all() as $message) {
                $messages .= "<li>$message</li>";
            }
            return new UpdateErrorResponse([
                'reset_target' => '#appointment-due-date-container',
                'reset_value' => runtimeDate($appointment->appointment_date_due),
                'error_message' => $messages,
            ]);
        }

        //update
        $appointment->appointment_date_due = request('appointment_date_due');
        $appointment->save();

        //process and apply permissions
        $this->processAppointment($appointment);
        $this->applyPermissions($appointment);

        //reponse payload
        $payload = [
            'appointments' => $appointments,
            'stats' => $this->statsWidget(),
        ];

        //process reponse
        return new UpdateResponse($payload);
    }

    /**
     * update appointment status
     * @param object ProjectPermissions instance of the repository
     * @param int $id appointment id
     * @return \Illuminate\Http\Response
     */
    public function updateStatus(ProjectPermissions $projectpermissions, $id) {

        //get the appointment
        $appointments = $this->appointmentrepo->search($id);
        $appointment = $appointments->first();

        //old status
        $old_status = $appointment->appointment_status;

        //check users permission to change appointment status
        if (!$this->appointmentpermissions->check('edit', $appointment)) {
            $this->processAppointments($appointments);
            $payload = [
                'appointment' => $appointments->first(),
                'appointments' => $appointments,
            ];
            return new UpdateLockedResponse($payload);
        }

        //check dependency locks - for attempt to mark appointment as completed
        if ($appointment->count_dependency_cannot_complete > 0) {
            if (request('appointment_status') == 2 || request('status') == 2) {
                $this->processAppointments($appointments);
                $payload = [
                    'appointment' => $appointments->first(),
                    'appointments' => $appointments,
                ];
                return new UpdateStatusLockedResponse($payload);
            }
        }

        //validate
        $validator = Validator::make(request()->all(), [
            'appointment_status' => [
                'required',
                function ($attribute, $value, $fail) {
                    if (\App\Models\AppointmentStatus::Where('appointmentstatus_id', $value)->doesntExist()) {
                        return $fail(__('lang.invalid_status'));
                    }
                },
            ],
        ]);

        //validation errors
        if ($validator->fails()) {
            $errors = $validator->errors();
            $messages = '';
            foreach ($errors->all() as $message) {
                $messages .= "<li>$message</li>";
            }
            return new UpdateErrorResponse([
                'reset_target' => '#card-appointment-status-text',
                'reset_value' => safestr(request('current_appointment_status_text')),
                'error_message' => $messages,
            ]);
        }

        //we are moving appointment to a new board - update its position to top of the new list
        if ($old_status != request('appointment_status')) {
            if ($first_appointment = \App\Models\Appointment::Where('appointment_status', request('appointment_status'))->orderBy('appointment_position', 'ASC')->first()) {
                $appointment->appointment_position = $first_appointment->appointment_position / 2;
            }
        }

        //update
        $appointment->appointment_status = request('appointment_status');
        $appointment->save();

        //get refreshed
        $appointments = $this->appointmentrepo->search($id);
        $appointment = $appointments->first();

        //process and apply permissions
        $this->processAppointment($appointment);
        $this->applyPermissions($appointment);

        /** ----------------------------------------------
         * record event [status]
         * ----------------------------------------------*/
        $data = [
            'event_creatorid' => auth()->id(),
            'event_item' => 'status',
            'event_item_id' => '',
            'event_item_lang' => 'event_changed_appointment_status',
            'event_item_content' => $appointment->appointment_status,
            'event_item_content2' => '',
            'event_parent_type' => 'appointment',
            'event_parent_id' => $appointment->appointment_id,
            'event_parent_title' => $appointment->appointment_title,
            'event_show_item' => 'yes',
            'event_show_in_timeline' => 'no',
            'event_clientid' => $appointment->appointment_clientid,
            'eventresource_type' => 'project',
            'eventresource_id' => $appointment->appointment_projectid,
            'event_notification_category' => 'notifications_appointments_activity',
        ];
        //record event
        if ($old_status != request('appointment_status')) {
            if ($event_id = $this->eventrepo->create($data)) {
                //get users
                $users = $projectpermissions->check('users', $appointment);
                //record notification
                $emailusers = $this->trackingrepo->recordEvent($data, $users, $event_id);
            }
        }
        /** ----------------------------------------------
         * send email [status]
         * ----------------------------------------------*/
        if (isset($emailusers) && is_array($emailusers)) {
            $data = [];
            //send to users
            if ($users = \App\Models\User::WhereIn('id', $emailusers)->get()) {
                foreach ($users as $user) {
                    $mail = new \App\Mail\AppointmentStatusChanged($user, $data, $appointment);
                    $mail->build();
                }
            }
        }

        //refresh dependecies
        $this->refreshDependencies($appointment);

        //reponse payload
        $payload = [
            'appointments' => $appointments,
            'stats' => $this->statsWidget(),
            'old_status' => $old_status,
            'new_status' => request('appointment_status'),
            'display_status' => runtimeLang(request('appointment_status')),
        ];

        //process reponse
        return new UpdateStatusResponse($payload);
    }

    /**
     * update appointment priority
     * @param int $id appointment id
     * @return \Illuminate\Http\Response
     */
    public function updatePriority($id) {

        //get the appointment
        $appointments = $this->appointmentrepo->search($id);
        $appointment = $appointments->first();

        //validate
        $validator = Validator::make(request()->all(), [
            'appointment_priority' => [
                'required',
            ],
        ]);

        //validation errors
        if ($validator->fails()) {
            $errors = $validator->errors();
            $messages = '';
            foreach ($errors->all() as $message) {
                $messages .= "<li>$message</li>";
            }
            return new UpdateErrorResponse([
                'reset_target' => '#card-appointment-priority-text',
                'reset_value' => safestr(request('current_appointment_priority_text')),
                'error_message' => $messages,
            ]);
        }

        //get the priority
        $priority = \App\Models\AppointmentPriority::Where('appointmentpriority_id', request('appointment_priority'))->first();

        //save
        $appointment->appointment_priority = request('appointment_priority');
        $appointment->save();

        //process and permissions
        $this->processAppointment($appointment);
        $this->applyPermissions($appointment);

        //reponse payload
        $payload = [
            'type' => 'update-priority',
            'appointments' => $appointments,
            'stats' => $this->statsWidget(),
            'display_priority' => $priority->appointmentpriority_title,

        ];

        //process reponse
        return new UpdateResponse($payload);
    }

    /**
     * update appointment visibility
     * @param int $id appointment id
     * @return \Illuminate\Http\Response
     */
    public function updateVisibility($id) {

        //get the appointment
        $appointments = $this->appointmentrepo->search($id);
        $appointment = $appointments->first();

        //validate
        $validator = Validator::make(request()->all(), [
            'appointment_client_visibility' => [
                'required',
                function ($attribute, $value, $fail) {
                    if (!in_array($value, ['yes', 'no'])) {
                        return $fail(__('lang.client_visibility_invalid'));
                    }
                },
            ],
        ]);

        //validation errors
        if ($validator->fails()) {
            $errors = $validator->errors();
            $messages = '';
            foreach ($errors->all() as $message) {
                $messages .= "<li>$message</li>";
            }
            return new UpdateErrorResponse([
                'error_message' => $messages,
            ]);
        }

        //validate
        $appointment->appointment_client_visibility = request('appointment_client_visibility');
        $appointment->save();

        //process and apply permissions
        $this->processAppointment($appointment);
        $this->applyPermissions($appointment);

        //reponse payload
        $payload = [
            'type' => 'update-vivibility',
            'appointments' => $appointments,
            'stats' => $this->statsWidget(),
            'display_text' => ($appointment->appointment_client_visibility == 'yes') ? __('lang.visible') : __('lang.hidden'),
        ];

        //process reponse
        return new UpdateResponse($payload);
    }

    /**
     * update appointment milestone
     * @param int $id appointment id
     * @return \Illuminate\Http\Response
     */
    public function updateMilestone($id) {

        //get the appointment
        $appointments = $this->appointmentrepo->search($id);
        $appointment = $appointments->first();

        //validate
        if (!\App\Models\Milestone::Where('milestone_id', request('appointment_milestoneid'))->where('milestone_projectid', $appointment->appointment_projectid)->exists()) {
            //show error and reset values
            $payload = [
                'reset_target' => '',
                'reset_value' => '',
                'error_message' => __('lang.invalid_or_missing_data'),
            ];
            //process reponse
            return new UpdateErrorResponse($payload);
        }

        //validate
        $appointment->appointment_milestoneid = request('appointment_milestoneid');
        $appointment->save();

        //get refreshed
        $appointments = $this->appointmentrepo->search($id);
        $appointment = $appointments->first();

        //process
        $this->processAppointment($appointment);
        $this->applyPermissions($appointment);

        //reponse payload
        $payload = [
            'appointments' => $appointments,
            'stats' => $this->statsWidget(),
        ];

        //process reponse
        return new UpdateResponse($payload);
    }

    /**
     * update appointment title
     * @param int $id appointment id
     * @return \Illuminate\Http\Response
     */
    public function updateTitle($id) {

        //get the appointment
        $appointment = $this->appointmentmodel::find($id);

        //validation
        if (hasHTML(request('appointment_title'))) {
            //[type options] error|success
            $jsondata['notification'] = [
                'type' => 'error',
                'value' => __('lang.title') . ' ' . __('lang.must_not_contain_any_html'),
            ];

            //update back the title
            $jsondata['dom_html'][] = [
                'selector' => '#card-title-editable',
                'action' => 'replace',
                'value' => safestr($appointment->appointment_title),
            ];
            return response()->json($jsondata);
        }

        //validation
        if (!request()->filled('appointment_title')) {

            //[type options] error|success
            $jsondata['notification'] = [
                'type' => 'error',
                'value' => __('lang.title_is_required'),
            ];

            //update back the title
            $jsondata['dom_html'][] = [
                'selector' => '#card-title-editable',
                'action' => 'replace',
                'value' => safestr($appointment->appointment_title),
            ];

            return response()->json($jsondata);

        } else {
            $appointment->appointment_title = request('appointment_title');
            $appointment->save();

            //get refreshed & reprocess
            $appointments = $this->appointmentrepo->search($id);
            $this->processAppointment($appointments->first());

            //update table row
            $jsondata['dom_html'][] = [
                'selector' => "#table_appointment_title_$id",
                'action' => 'replace',
                'value' => str_limit(safestr($appointment->appointment_title), 25),
            ];
            //update kanban card title
            $jsondata['dom_html'][] = [
                'selector' => "#kanban_appointment_title_$id",
                'action' => 'replace',
                'value' => str_limit(safestr($appointment->appointment_title), 45),
            ];
            //update card
            $jsondata['dom_html'][] = [
                'selector' => '#card-title-editable',
                'action' => 'replace',
                'value' => safestr($appointment->appointment_title),
            ];

            return response()->json($jsondata);
        }
    }

    /**
     * update appointment assigned users
     * @param object AppointmentAssignedRepository instance of the repository
     * @param int $id appointment id
     * @return \Illuminate\Http\Response
     */
    public function updateAssigned(AppointmentAssignedRepository $assignedrepo, $id) {

        //fix - remove own appointments filter- so that a user with "assign appointments" role can use this method
        $data = [
            'apply_filters' => false,
        ];

        //get the appointment
        $appointments = $this->appointmentrepo->search($id);
        $appointment = $appointments->first();

        //currently assigned
        $currently_assigned = $appointment->assigned->pluck('id')->toArray();

        //milestone
        $milestones = \App\Models\Milestone::Where('milestone_projectid', $appointment->appointment_projectid)->get();

        //validation - data type
        if (request()->filled('assigned') && !is_array(request('assigned'))) {
            return new UpdateResponse([
                'type' => 'update-assigned',
                'appointments' => $appointments,
                'appointment' => $appointment,
                'assigned' => $assignedrepo->getAssigned($id),
                'milestones' => $milestones,
                'error' => true,
                'message' => __('lang.request_is_invalid'),
            ]);
        }

        //validate users exist
        if (request()->filled('assigned')) {
            foreach (request('assigned') as $user_id => $value) {
                if ($value == 'on') {
                    //validate user exists
                    if (\App\Models\User::Where('id', $user_id)->doesntExist()) {
                        return new UpdateResponse([
                            'type' => 'update-assigned',
                            'appointments' => $appointments,
                            'appointment' => $appointment,
                            'assigned' => $assignedrepo->getAssigned($id),
                            'milestones' => $milestones,
                            'error' => true,
                            'message' => __('lang.assiged_user_not_found'),
                        ]);
                    }

                }
            }
        }

        //delete all assigned
        $assignedrepo->delete($id);

        //add each user
        $newly_signed_users = [];
        if (request()->filled('assigned')) {
            foreach (request('assigned') as $user_id => $value) {
                if ($value == 'on') {
                    $assigned_users = $assignedrepo->add($id, $user_id);
                    if (!in_array($user_id, $currently_assigned)) {
                        $newly_signed_users[] = $user_id;
                    }
                }
            }
        }

        //stop timers of recently un-assigned users
        foreach ($currently_assigned as $current_user) {
            if (!in_array($current_user, $newly_signed_users)) {
                //reset existing account owner
                \App\Models\Timer::where('timer_appointmentid', $id)->where('timer_creatorid', $current_user)
                    ->update(['timer_status' => 'stopped']);
            }
        }

        /** ----------------------------------------------
         * record assignment events and send emails
         * ----------------------------------------------*/
        foreach ($newly_signed_users as $assigned_user_id) {
            if ($assigned_user = \App\Models\User::Where('id', $assigned_user_id)->first()) {

                $data = [
                    'event_creatorid' => auth()->id(),
                    'event_item' => 'assigned',
                    'event_item_id' => '',
                    'event_item_lang' => 'event_assigned_user_to_a_appointment',
                    'event_item_lang_alt' => 'event_assigned_user_to_a_appointment_alt',
                    'event_item_content' => __('lang.assigned'),
                    'event_item_content2' => $assigned_user_id,
                    'event_item_content3' => $assigned_user->first_name,
                    'event_parent_type' => 'appointment',
                    'event_parent_id' => $appointment->appointment_id,
                    'event_parent_title' => $appointment->appointment_title,
                    'event_show_item' => 'yes',
                    'event_show_in_timeline' => 'yes',
                    'event_clientid' => $appointment->appointment_clientid,
                    'eventresource_type' => 'project',
                    'eventresource_id' => $appointment->appointment_projectid,
                    'event_notification_category' => 'notifications_new_assignement',
                ];
                //record event
                if ($event_id = $this->eventrepo->create($data)) {
                    //record notification (skip the user creating this event)
                    if ($assigned_user_id != auth()->id()) {
                        $emailusers = $this->trackingrepo->recordEvent($data, [$assigned_user_id], $event_id);
                    }
                }

                /** ----------------------------------------------
                 * send email [assignment]
                 * ----------------------------------------------*/
                if ($assigned_user_id != auth()->id()) {
                    if ($assigned_user->notifications_new_assignement == 'yes_email') {
                        $mail = new \App\Mail\AppointmentAssignment($assigned_user, $data, $appointment);
                        $mail->build();
                    }
                }
            }
        }

        //get refereshed
        $appointments = $this->appointmentrepo->search($id);
        $appointment = $appointments->first();

        //process and apply permissions
        $this->processAppointment($appointment);
        $this->applyPermissions($appointment);

        //get assigned
        $assigned = $assignedrepo->getAssigned($id);

        //reponse payload
        $payload = [
            'type' => 'update-assigned',
            'appointments' => $appointments,
            'appointment' => $appointment,
            'assigned' => $assigned,
            'milestones' => $milestones,
        ];

        //process reponse
        return new UpdateResponse($payload);
    }

    /**
     * update appointment priority
     * @param int $id appointment id
     * @return \Illuminate\Http\Response
     */
    public function updateTags($id) {

        //delete & update tags
        $this->tagrepo->delete('appointment', $id);
        $this->tagrepo->add('appointment', $id);

        //get tags
        $tags_resource = $this->tagrepo->getByResource('appointment', $id);
        $tags_system = $this->tagrepo->getByType('appointment');
        $tags = $tags_resource->merge($tags_system);
        $tags = $tags->unique('tag_title');

        //get refreshed appointment
        $appointments = $this->appointmentrepo->search($id);
        $appointment = $appointments->first();

        //apply permissions
        $this->applyPermissions($appointment);

        //process
        $this->processAppointment($appointment);

        //custom fields
        $appointment->fields = $this->getCustomFields($appointment);

        //reponse payload
        $payload = [
            'appointment' => $appointment,
            'appointments' => $appointments,
            'tags' => $tags,
            'current_tags' => $appointment->tags,
        ];

        //process reponse
        return new UpdateTagsResponse($payload);
    }

    /**
     * save appointment comment
     * @param object CommentRepository instance of the repository
     * @return \Illuminate\Http\Response
     */
    public function storeComment(CommentRepository $commentrepo, $id) {

        //validate
        $validator = Validator::make(request()->all(), [
            'comment_text' => [
                'required',
            ],
        ]);

        //validation errors
        if ($validator->fails()) {
            $errors = $validator->errors();
            $messages = '';
            foreach ($errors->all() as $message) {
                $messages .= "<li>$message</li>";
            }
            abort(409, $messages);
        }

        request()->merge([
            'commentresource_type' => 'appointment',
            'commentresource_id' => $id,
            'comment_text' => request('comment_text'),
        ]);
        $comment_id = $commentrepo->create();

        //get complete comment
        $comments = $commentrepo->search($comment_id);
        $comment = $comments->first();
        $this->applyCommentPermissions($comment);

        //get appointment
        $appointments = $this->appointmentrepo->search($id);
        $appointment = $appointments->first();
        $this->processAppointment($appointment);

        /** ----------------------------------------------
         * record event [coment]
         * ----------------------------------------------*/
        $data = [
            'event_creatorid' => auth()->id(),
            'event_item' => 'comment',
            'event_item_id' => $comment->comment_id,
            'event_item_lang' => 'event_posted_a_comment',
            'event_item_content' => $comment->comment_text,
            'event_item_content2' => '',
            'event_parent_type' => 'appointment',
            'event_parent_id' => $appointment->appointment_id,
            'event_parent_title' => $appointment->appointment_title,
            'event_show_item' => 'yes',
            'event_show_in_timeline' => 'no',
            'event_clientid' => $appointment->appointment_clientid,
            'eventresource_type' => 'project',
            'eventresource_id' => $appointment->appointment_projectid,
            'event_notification_category' => 'notifications_appointments_activity',
        ];
        //record event
        if ($event_id = $this->eventrepo->create($data)) {
            //get users
            $users = $this->appointmentpermissions->check('users', $appointment);
            //record notification
            $emailusers = $this->trackingrepo->recordEvent($data, $users, $event_id);
        }

        /** ----------------------------------------------
         * send email [comment]
         * ----------------------------------------------*/
        if (isset($emailusers) && is_array($emailusers)) {
            //the comment
            $data = $comment->toArray();
            //send to users
            if ($users = \App\Models\User::WhereIn('id', $emailusers)->get()) {
                foreach ($users as $user) {
                    $mail = new \App\Mail\AppointmentComment($user, $data, $appointment);
                    $mail->build();
                }
            }
        }

        //reponse payload
        $payload = [
            'comments' => $comments,
            'appointments' => $appointments,
        ];

        //show the form
        return new StoreCommentResponse($payload);
    }

    /**
     * store checklist
     * @param object ChecklistRepository instance of the repository
     * @return object
     */
    public function StoreChecklist(ChecklistRepository $checklistrepo, $id) {

        //validate
        $validator = Validator::make(request()->all(), [
            'checklist_text' => [
                'required',
            ],
        ]);

        //validation errors
        if ($validator->fails()) {
            $errors = $validator->errors();
            $messages = '';
            foreach ($errors->all() as $message) {
                $messages .= "<li>$message</li>";
            }
            return new UpdateErrorResponse([
                'type' => 'store-checklist',
                'error_message' => $messages,
            ]);
        }

        //we are creating a new list
        request()->merge([
            'checklistresource_type' => 'appointment',
            'checklistresource_id' => $id,
            'checklist_text' => request('checklist_text'),
        ]);

        //get next position
        if ($last = \App\Models\Checklist::Where('checklistresource_type', 'appointment')
            ->Where('checklistresource_id', $id)
            ->orderBy('checklist_position', 'desc')
            ->first()) {
            $position = $last->checklist_position + 1;
        } else {
            //default position
            $position = 1;
        }
        //save checklist
        $checklist_id = $checklistrepo->create($position);

        //get complete checklist
        $checklists = $checklistrepo->search($checklist_id);
        $this->applyChecklistPermissions($checklists->first());

        //get appointment
        $appointments = $this->appointmentrepo->search($id);
        $this->processAppointment($appointments->first());

        //reponse payload
        $payload = [
            'checklists' => $checklists,
            'progress' => $this->checklistProgress($checklistrepo->search()),
            'appointments' => $appointments,
        ];

        //show the form
        return new StoreChecklistResponse($payload);
    }

    /**
     * update a appointment checklist
     * @param object ChecklistRepository instance of the repository
     * @param int $id appointment id
     * @return \Illuminate\Http\Response
     */
    public function UpdateChecklist(ChecklistRepository $checklistrepo, $id) {

        //validate
        $validator = Validator::make(request()->all(), [
            'checklist_text' => [
                'required',
            ],
        ]);

        //validation errors
        if ($validator->fails()) {
            $errors = $validator->errors();
            $messages = '';
            foreach ($errors->all() as $message) {
                $messages .= "<li>$message</li>";
            }
            return new UpdateErrorResponse([
                'type' => 'store-checklist',
                'error_message' => $messages,
            ]);
        }

        //update checklist
        $checklist = \App\Models\Checklist::Where('checklist_id', $id)->first();
        $checklist->checklist_text = request('checklist_text');
        $checklist->save();

        //get refreshed
        $checklists = $checklistrepo->search($id);
        $this->applyChecklistPermissions($checklists->first());

        //reponse payload
        $payload = [
            'checklist' => $checklist,
            'checklists' => $checklists,
        ];

        //show the form
        return new UpdateChecklistResponse($payload);
    }

    /**
     * change appointment status using the checkbox
     * @return \Illuminate\Http\Response
     */
    public function toggleStatus() {

        //get the appointment
        $appointments = $this->appointmentrepo->search(request()->route('appointment'));
        $appointment = $appointments->first();

        //check dependency locks - for attempt to mark appointment as completed
        if ($appointment->count_dependency_cannot_complete > 0) {
            if (request('appointment_status') == 2 || request('status') == 2) {
                $this->processAppointments($appointments);
                $payload = [
                    'appointment' => $appointments->first(),
                    'appointments' => $appointments,
                ];
                return new UpdateStatusLockedResponse($payload);
            }
        }

        //update the appointment
        if (request('toggle_appointment_status') == 'on') {
            $appointment->appointment_previous_status = $appointment->appointment_status;
            $appointment->appointment_status = 2;
            $appointment->save();
        } else {
            $appointment->appointment_status = $appointment->appointment_previous_status;
            $appointment->save();
        }

        //stop all running timers
        if ($appointment->appointment_status == 2) {
            $this->timerrepo->stopRunningTimers([
                'appointment_id' => request()->route('appointment'),
            ]);

        }

        //get refreshed appointment
        $appointments = $this->appointmentrepo->search(request()->route('appointment'));
        $appointment = $appointments->first();

        //apply permissions
        $this->applyPermissions($appointment);

        //process
        $this->processAppointment($appointment);

        //record event (appointment completed)
        if ($appointment->appointment_status == 2) {

            /** ----------------------------------------------
             * record event [comment]
             * see database table to details of each key
             * ----------------------------------------------*/
            $data = [
                'event_creatorid' => auth()->id(),
                'event_item' => 'appointment',
                'event_item_id' => $appointment->appointment_id,
                'event_item_lang' => 'event_changed_appointment_status_completed',
                'event_item_content' => $appointment->appointment_title,
                'event_item_content2' => '',
                'event_clientid' => $appointment->appointment_clientid,
                'event_parent_type' => 'project',
                'event_parent_id' => $appointment->appointment_projectid,
                'event_parent_title' => $appointment->project_title,
                'event_show_item' => 'yes',
                'event_show_in_timeline' => 'yes',
                'eventresource_type' => 'project',
                'eventresource_id' => $appointment->appointment_projectid,
                'event_notification_category' => 'notifications_appointments_activity',
            ];
            //record event
            if ($event_id = $this->eventrepo->create($data)) {
                //get users
                $users = $this->appointmentpermissions->check('users', $appointment);
                //record notification
                $emailusers = $this->trackingrepo->recordEvent($data, $users, $event_id);
            }

            /** ----------------------------------------------
             * send email [comment
             * ----------------------------------------------*/
            if (isset($emailusers) && is_array($emailusers)) {
                //additional data
                $data = [];
                //send to users
                if ($users = \App\Models\User::WhereIn('id', $emailusers)->get()) {
                    foreach ($users as $user) {
                        $mail = new \App\Mail\AppointmentStatusChanged($user, $data, $appointment);
                        $mail->build();
                    }
                }
            }

        }

        //refresh dependecies
        $this->refreshDependencies($appointment);

        //reponse payload
        $payload = [
            'appointments' => $appointments,
            'appointment_id' => request()->route('appointment'),
            'stats' => $this->statsWidget(),
        ];

        //show the form
        return new UpdateResponse($payload);
    }

    /**
     * save an uploaded file
     * @param object Request instance of the request object
     * @param object AttachmentRepository instance of the repository
     * @param int $id appointment id
     */
    public function attachFiles(Request $request, AttachmentRepository $attachmentrepo, $id) {

        //validate the appointment exists
        $appointment = $this->appointmentmodel::find($id);

        //save the file in its own folder in the temp folder
        if ($file = $request->file('file')) {

            //defaults
            $file_type = 'file';

            //unique file id & directory name
            $uniqueid = Str::random(40);
            $directory = $uniqueid;

            //original file name
            $filename = $file->getClientOriginalName();

            //filepath
            $file_path = BASE_DIR . "/storage/files/$directory/$filename";

            //extension
            $extension = pathinfo($file_path, PATHINFO_EXTENSION);

            //thumb path
            $thumb_name = generateThumbnailName($filename);
            $thumb_path = BASE_DIR . "/storage/files/$directory/$thumb_name";

            //create directory
            Storage::makeDirectory("files/$directory");

            //save file to directory
            Storage::putFileAs("files/$directory", $file, $filename);

            //if the file type is an image, create a thumb by default
            if (is_array(@getimagesize($file_path))) {
                $file_type = 'image';
                try {
                    $img = Image::make($file_path)->resize(null, 90, function ($constraint) {
                        $constraint->aspectRatio();
                        $constraint->upsize();
                    });
                    $img->save($thumb_path);
                } catch (NotReadableException $e) {
                    $message = $e->getMessage();
                    Log::error("[Image Library] failed to create uplaoded image thumbnail. Image type is not supported on this server", ['process' => '[permissions]', config('app.debug_ref'), 'function' => __function__, 'file' => basename(__FILE__), 'line' => __line__, 'path' => __file__, 'error_message' => $message]);
                    abort(409, __('lang.image_file_type_not_supported'));
                }
            }

            //save files
            $data = [
                'attachment_clientid' => $appointment->appointment_clientid,
                'attachment_uniqiueid' => $uniqueid,
                'attachment_directory' => $directory,
                'attachment_filename' => $filename,
                'attachment_extension' => $extension,
                'attachment_type' => $file_type,
                'attachment_size' => humanFileSize(filesize($file_path)),
                'attachment_thumbname' => $thumb_name,
                'attachmentresource_type' => 'appointment',
                'attachmentresource_id' => $id,
            ];
            $attachment_id = $attachmentrepo->create($data);

            //get refreshed attachment
            $attachments = $attachmentrepo->search($attachment_id);
            $attachment = $attachments->first();
            //apply permissions
            $this->applyAttachmentPermissions($attachment);

            //get appointment
            $appointments = $this->appointmentrepo->search($id);
            $appointment = $appointments->first();
            $this->processAppointment($appointment);

            /** ----------------------------------------------
             * record event [attachment]
             * ----------------------------------------------*/
            $data = [
                'event_creatorid' => auth()->id(),
                'event_item' => 'attachment',
                'event_item_id' => $attachment_id,
                'event_item_lang' => 'event_attached_a_file',
                'event_item_content' => $filename,
                'event_item_content2' => "appointments/download-attachment/$uniqueid",
                'event_parent_type' => 'appointment',
                'event_parent_id' => $appointment->appointment_id,
                'event_parent_title' => $appointment->appointment_title,
                'event_show_item' => 'yes',
                'event_show_in_timeline' => 'no',
                'event_clientid' => $appointment->appointment_clientid,
                'eventresource_type' => 'project',
                'eventresource_id' => $appointment->appointment_projectid,
                'event_notification_category' => 'notifications_appointments_activity',
            ];
            //record event
            if ($event_id = $this->eventrepo->create($data)) {
                //get users
                $users = $this->appointmentpermissions->check('users', $appointment);
                //record notification
                $emailusers = $this->trackingrepo->recordEvent($data, $users, $event_id);
            }

            /** ----------------------------------------------
             * send email [attachment]
             * ----------------------------------------------*/
            if (isset($emailusers) && is_array($emailusers)) {
                $data = $attachment->toArray();
                //send to users
                if ($users = \App\Models\User::WhereIn('id', $emailusers)->get()) {
                    foreach ($users as $user) {
                        $mail = new \App\Mail\AppointmentFileUploaded($user, $data, $appointment);
                        $mail->build();
                    }
                }
            }

            //reponse payload
            $payload = [
                'attachments' => $attachments,
                'appointments' => $appointments,
            ];

            //show the form
            return new AttachFilesResponse($payload);
        }
    }

    /**
     * delete appointment attachment
     * @param int $id appointment id
     * @return \Illuminate\Http\Response
     */
    public function deleteAttachment() {

        //check if file exists in the database
        $attachment = \App\Models\Attachment::Where('attachment_uniqiueid', request()->route('uniqueid'))->first();

        //confirm thumb exists
        if ($attachment->attachment_directory != '') {
            if (Storage::exists("files/$attachment->attachment_directory")) {
                Storage::deleteDirectory("files/$attachment->attachment_directory");
            }
        }

        $attachment->delete();

        //hide and remove row
        $jsondata['dom_visibility'][] = array(
            'selector' => '#card_attachment_' . $attachment->attachment_uniqiueid,
            'action' => 'slideup-slow-remove',
        );

        //response
        return response()->json($jsondata);
    }

    /**
     * download appointment attachment
     * @param int $id appointment id
     * @return \Illuminate\Http\Response
     */
    public function downloadAttachment() {

        //check if file exists in the database
        $attachment = \App\Models\Attachment::Where('attachment_uniqiueid', request()->route('uniqueid'))->first();

        //confirm thumb exists
        if ($attachment->attachment_filename != '') {
            $file_path = "files/$attachment->attachment_directory/$attachment->attachment_filename";
            if (Storage::exists($file_path)) {
                return Storage::download($file_path);
            }
        }
        abort(404, __('lang.file_not_found'));
    }

    /**
     * delete a appointment comment
     * @param object DestroyRepository instance of the repository
     * @param object Comment instance of the comment model object
     * @param int $id appointment id
     * @return \Illuminate\Http\Response
     */
    public function deleteComment(DestroyRepository $destroyrepo, Comment $comment, $id) {

        //delete comment
        $destroyrepo->destroyComment($id);

        //hide and remove row
        $jsondata['dom_visibility'][] = array(
            'selector' => '#card_comment_' . $comment->comment_id,
            'action' => 'slideup-slow-remove',
        );

        //response
        return response()->json($jsondata);
    }

    /**
     * delete checklist
     * @param object Checklist instance of the request object
     * @param object ChecklistRepository instance of the repository
     * @param int $id appointment id
     * @return \Illuminate\Http\Response
     */
    public function deleteChecklist(Checklist $checklist, ChecklistRepository $checklistrepo) {

        //check if file exists in the database
        $checklist = $checklist::find(request()->route('checklistid'));

        //some data
        $resource_id = $checklist->checklistresource_id;
        $checklist_id = $checklist->checklist_id;

        //delete
        $checklist->delete();

        //checklists
        request()->merge([
            'checklistresource_type' => 'appointment',
            'checklistresource_id' => $resource_id,
        ]);
        $checklists = $checklistrepo->search();

        //reponse payload
        $payload = [
            'progress' => $this->checklistProgress($checklists),
            'action' => 'delete',
            'checklistid' => $checklist_id,
        ];

        //show the form
        return new ChecklistResponse($payload);
    }

    /**
     * delete checklist
     * @param object Checklist instance of the request validation object
     * @param object ChecklistRepository instance of the repository
     * @param int $id appointment id
     * @return \Illuminate\Http\Response
     */
    public function toggleChecklistStatus(Checklist $checklist, ChecklistRepository $checklistrepo) {

        //check if file exists in the database
        $checklist = $checklist::find(request()->route('checklistid'));

        if (request('card_checklist') == 'on') {
            $checklist->checklist_status = 'completed';
        } else {
            $checklist->checklist_status = 'pending';
        }

        //save
        $checklist->save();

        //checklists
        request()->merge([
            'checklistresource_type' => 'appointment',
            'checklistresource_id' => $checklist->checklistresource_id,
        ]);
        $checklists = $checklistrepo->search();

        //reponse payload
        $payload = [
            'progress' => $this->checklistProgress($checklists),
        ];

        //show the form
        return new ChecklistResponse($payload);
    }

    /**
     * create the checklists progress bar data
     * @param object checklists instance of the checklists model object
     * @return object
     */
    private function checklistProgress($checklists) {

        $progress['bar'] = 'w-0'; //css width %
        $progress['completed'] = '---';

        //sanity - make sure this is a valid appointments object
        if ($checklists instanceof \Illuminate\Pagination\LengthAwarePaginator) {
            $count = 0;
            $completed = 0;
            foreach ($checklists as $checklist) {
                if ($checklist->checklist_status == 'completed') {
                    $completed++;
                }
                $count++;
            }
            //finial
            $progress['completed'] = "$completed/$count";
            if ($count > 0) {
                $percentage = round(($completed / $count) * 100);
                $progress['bar'] = "w-$percentage";
            }
        }

        return $progress;
    }

    /**
     * apply permissions.
     * @param object $appointment instance of the appointment model object
     * @return object
     */
    private function applyPermissions($appointment = '') {

        //sanity - make sure this is a valid appointment object
        if ($appointment instanceof \App\Models\Appointment) {

            //[sql optimisation]
            $project = $appointment->project()->first();
            // $assigned_users = $appointment->assigned->pluck('id');
            // $assigned_project_users = $project->assigned->pluck('id');
            $project_managers = $appointment->projectmanagers->pluck('id');

            // //project appointments
            // if ($appointment->appointment_projectid > 0) {
            //     //edit permissions
            //     $appointment->permission_edit_appointment = $this->appointmentpermissions->check('edit', $appointment, $project, $assigned_users, $assigned_project_users, $project_managers);
            //     //delete permissions
            //     $appointment->permission_delete_appointment = $this->appointmentpermissions->check('delete', $appointment, $project, $assigned_users, $assigned_project_users, $project_managers);
            //     //delete participate
            //     $appointment->permission_participate = $this->appointmentpermissions->check('participate', $appointment, $project, $assigned_users, $assigned_project_users, $project_managers);
            //     //super user
            //     $appointment->permission_assign_users = $this->appointmentpermissions->check('assign-users', $appointment, $project, $assigned_users, $assigned_project_users, $project_managers);
            //     //super user
            //     $appointment->permission_super_user = $this->appointmentpermissions->check('super-user', $appointment, $project, $assigned_users, $assigned_project_users, $project_managers);
            //     //manage dependencies
            //     $appointment->permission_manage_dependencies = $this->appointmentpermissions->check('manage-dependencies', $appointment, $project, $assigned_users, $assigned_project_users, $project_managers);
            // }
            //template appointments
            if ($appointment->appointment_projectid < 0) {
                //edit permissions
                $appointment->permission_edit_appointment = (auth()->user()->role->role_templates_projects >= 2) ? true : false;
                //delete permissions
                $appointment->permission_delete_appointment = (auth()->user()->role->role_templates_projects >= 2) ? true : false;
                //delete participate
                $appointment->permission_participate = (auth()->user()->role->role_templates_projects >= 2) ? true : false;
                //super user
                $appointment->permission_assign_users = false;
                //super user
                $appointment->permission_super_user = false;
            }
        }
    }

    /**
     * apply permissions to each comment
     * @param object $comment instance of the comment model object
     * @return object
     */
    private function applyCommentPermissions($comment = '') {

        //sanity - make sure this is a valid object
        if ($comment instanceof \App\Models\Comment) {
            //delete permissions
            $comment->permission_delete_comment = $this->commentpermissions->check('delete', $comment);
        }
    }

    /**
     * apply permissions to each attachment
     * @param object $attachment instance of the attachment model object
     * @return object
     */
    private function applyAttachmentPermissions($attachment = '') {

        //sanity - make sure this is a valid object
        if ($attachment instanceof \App\Models\Attachment) {
            //delete permissions
            $attachment->permission_delete_attachment = $this->attachmentpermissions->check('delete', $attachment);
        }
    }

    /**
     * apply permissions to each checklist
     * @param object $checklist instance of the checklist model object
     * @return object
     */
    private function applyChecklistPermissions($checklist = '') {

        //sanity - make sure this is a valid object
        if ($checklist instanceof \App\Models\Checklist) {
            //delete permissions
            $checklist->permission_edit_delete_checklist = $this->checklistpermissions->check('edit-delete', $checklist);
        }
    }

    /**
     * update a cards position (kanban drag & drop)
     * @return null
     */
    public function updatePosition() {

        //validation
        if (!request()->filled('status')) {
            abort(409, __('lang.error_request_could_not_be_completed'));
        }
        if (\App\Models\AppointmentStatus::Where('appointmentstatus_id', request('status'))->doesntExist()) {
            abort(409, __('lang.error_request_could_not_be_completed'));
        }
        if (!$appointment = $this->appointmentmodel::find(request('appointment_id'))) {
            abort(409, __('lang.error_request_could_not_be_completed'));
        }

        //get the appointment
        $appointments = $this->appointmentrepo->search(request('appointment_id'));
        $appointment = $appointments->first();

        //check users permission to change appointment status
        if (!$this->appointmentpermissions->check('edit', $appointment)) {
            $this->processAppointments($appointments);
            $payload = [
                'appointment' => $appointments->first(),
                'appointments' => $appointments,
            ];
            return new UpdateLockedResponse($payload);
        }

        //check dependency locks - for attempt to mark appointment as completed
        if ($appointment->count_dependency_cannot_complete > 0) {
            if (request('appointment_status') == 2 || request('status') == 2) {
                $this->processAppointments($appointments);
                $payload = [
                    'appointment' => $appointments->first(),
                    'appointments' => $appointments,
                ];
                return new UpdateStatusLockedResponse($payload);
            }
        }

        //old status
        $old_status = $appointment->appointment_status;

        //(scenario - 1) card is placed in between 2 other cards
        if (is_numeric(request('previous_appointment_id')) && is_numeric(request('next_appointment_id'))) {
            //get previous appointment
            if (!$previous_appointment = $this->appointmentmodel::find(request('previous_appointment_id'))) {
                abort(409, __('lang.error_request_could_not_be_completed'));
            }
            //get next appointment
            if (!$next_appointment = $this->appointmentmodel::find(request('next_appointment_id'))) {
                abort(409, __('lang.error_request_could_not_be_completed'));
            }
            //calculate this appointments new position & update it
            $new_position = ($previous_appointment->appointment_position + $next_appointment->appointment_position) / 2;
            $appointment->appointment_position = $new_position;
            $appointment->appointment_status = request('status');
            $appointment->save();
        }

        //(scenario - 2) card is placed at the end of a list
        if (is_numeric(request('previous_appointment_id')) && !request()->filled('next_appointment_id')) {
            //get previous appointment
            if (!$previous_appointment = $this->appointmentmodel::find(request('previous_appointment_id'))) {
                abort(409, __('lang.error_request_could_not_be_completed'));
            }
            //calculate this appointments new position & update it
            $new_position = $previous_appointment->appointment_position + config('settings.db_position_increment');
            $appointment->appointment_position = $new_position;
            $appointment->appointment_status = request('status');
            $appointment->save();
        }

        //(scenario - 3) card is placed at the start of a list
        if (is_numeric(request('next_appointment_id')) && !request()->filled('previous_appointment_id')) {
            //get next appointment
            if (!$next_appointment = $this->appointmentmodel::find(request('next_appointment_id'))) {
                abort(409, __('lang.error_request_could_not_be_completed'));
            }
            //calculate this appointments new position & update it
            $new_position = $next_appointment->appointment_position / 2;
            $appointment->appointment_position = $new_position;
            $appointment->appointment_status = request('status');
            $appointment->save();
        }

        //(scenario - 4) card is placed on an empty board
        if (!request()->filled('previous_appointment_id') && !request()->filled('next_appointment_id')) {
            //update only status
            $appointment->appointment_status = request('status');
            $appointment->save();
        }

        //status was changed - record event
        if ($old_status != $appointment->appointment_status) {
            //get refreshed appointment
            $appointments = $this->appointmentrepo->search(request('appointment_id'));
            $appointment = $appointments->first();

            /** ----------------------------------------------
             * record event [status]
             * ----------------------------------------------*/
            $data = [
                'event_creatorid' => auth()->id(),
                'event_item' => 'status',
                'event_item_id' => '',
                'event_item_lang' => 'event_changed_appointment_status',
                'event_item_content' => $appointment->appointment_status,
                'event_item_content2' => '',
                'event_parent_type' => 'appointment',
                'event_parent_id' => $appointment->appointment_id,
                'event_parent_title' => $appointment->appointment_title,
                'event_show_item' => 'yes',
                'event_show_in_timeline' => 'no',
                'event_clientid' => $appointment->appointment_clientid,
                'eventresource_type' => 'project',
                'eventresource_id' => $appointment->appointment_projectid,
                'event_notification_category' => 'notifications_appointments_activity',
            ];
            //record event
            if ($event_id = $this->eventrepo->create($data)) {
                //get users
                $users = $this->appointmentpermissions->check('users', $appointment);
                //record notification
                $emailusers = $this->trackingrepo->recordEvent($data, $users, $event_id);
            }

            /** ----------------------------------------------
             * send email [status]
             * ----------------------------------------------*/
            if (isset($emailusers) && is_array($emailusers)) {
                $data = [];
                //send to users
                if ($users = \App\Models\User::WhereIn('id', $emailusers)->get()) {
                    foreach ($users as $user) {
                        $mail = new \App\Mail\AppointmentStatusChanged($user, $data, $appointment);
                        $mail->build();
                    }
                }
            }
        }

        //refresh dependecies
        $this->refreshDependencies($appointment);

        //reponse payload
        $payload = [
            'stats' => $this->statsWidget(),
        ];
    }

    /**
     * Archive a appointment
     * @param object TimerRepository instance of the repository
     * @param int $id appointment id
     * @return \Illuminate\Http\Response
     */
    public function archive($id) {

        //get appointment and update status
        $appointment = \App\Models\Appointment::Where('appointment_id', $id)->first();
        $appointment->appointment_active_state = 'archived';
        $appointment->save();

        //get refreshed appointment
        $appointments = $this->appointmentrepo->search($id);
        $appointment = $appointments->first();

        //apply permissions
        $this->applyPermissions($appointment);

        //reponse payload
        $payload = [
            'appointments' => $appointments,
            'action' => 'archive',
        ];

        //show the form
        return new ArchiveResponse($payload);
    }

    /**
     * Activate a appointment
     * @param object TimerRepository instance of the repository
     * @param int $id appointment id
     * @return \Illuminate\Http\Response
     */
    public function activate($id) {

        //get appointment and update status
        $appointment = \App\Models\Appointment::Where('appointment_id', $id)->first();
        $appointment->appointment_active_state = 'active';
        $appointment->save();

        //get refreshed appointment
        $appointments = $this->appointmentrepo->search($id);
        $appointment = $appointments->first();

        //apply permissions
        $this->applyPermissions($appointment);

        //reponse payload
        $payload = [
            'appointments' => $appointments,
            'action' => 'archive',
        ];

        //show the form
        return new ActivateResponse($payload);
    }

    /**
     * show custom fields data
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function showCustomFields($id) {

        //get appointments
        $appointments = $this->appointmentrepo->search($id);
        $appointment = $appointments->first();

        //get customfields
        request()->merge([
            'sort_by' => 'customfields_position',
            'filter_field_status' => 'enabled',
        ]);
        $fields = $this->getCustomFields($appointment);

        //package to send to response
        $payload = [
            'type' => 'show-custom-fields',
            'appointment' => $appointment,
            'fields' => $fields,
        ];

        //show the form
        return new contentResponse($payload);

    }

    /**
     * show custom fields data
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function editCustomFields($id) {

        //get appointments
        $appointments = $this->appointmentrepo->search($id);
        $appointment = $appointments->first();

        //get customfields
        request()->merge([
            'sort_by' => 'customfields_position',
            'filter_field_status' => 'enabled',
        ]);
        $fields = $this->getCustomFields($appointment);

        //package to send to response
        $payload = [
            'type' => 'edit-custom-fields',
            'appointment' => $appointment,
            'fields' => $fields,
        ];

        //show the form
        return new contentResponse($payload);

    }

    /**
     * show custom fields data
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function updateCustomFields($id) {

        //get appointments
        $appointments = $this->appointmentrepo->search($id);
        $appointment = $appointments->first();

        //get customfields
        request()->merge([
            'sort_by' => 'customfields_position',
            'filter_field_status' => 'enabled',
        ]);
        $fields = $this->getCustomFields($appointment);

        //update
        foreach ($fields as $field) {
            \App\Models\Appointment::where('appointment_id', $id)
                ->update([
                    $field->customfields_name => $_POST[$field->customfields_name],
                ]);
        }

        //refeshed data
        $appointments = $this->appointmentrepo->search($id);
        $appointment = $appointments->first();
        $fields = $this->getCustomFields($appointment);

        //package to send to response
        $payload = [
            'type' => 'show-custom-fields',
            'appointment' => $appointment,
            'fields' => $fields,
        ];

        //show the form
        return new contentResponse($payload);

    }

    /**
     * show my notes data
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function showMyNotes($id) {

        //get appointments
        if ($note = \App\Models\Note::Where('noteresource_type', 'appointment')
            ->Where('noteresource_id', $id)
            ->Where('note_creatorid', auth()->id())->first()) {
            $has_note = true;
        } else {
            $note = [];
            $has_note = false;
        }

        //refeshed data
        $appointments = $this->appointmentrepo->search($id);
        $appointment = $appointments->first();

        //package to send to response
        $payload = [
            'type' => 'show-notes',
            'note' => $note,
            'appointment' => $appointment,
            'has_note' => $has_note,
        ];

        //show the form
        return new contentResponse($payload);
    }

    /**
     * show my notes data
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function editMyNotes($id) {

        //get appointments
        $note = \App\Models\Note::Where('noteresource_type', 'appointment')
            ->Where('noteresource_id', $id)
            ->Where('note_creatorid', auth()->id())->first();

        //refeshed data
        $appointments = $this->appointmentrepo->search($id);
        $appointment = $appointments->first();

        //package to send to response
        $payload = [
            'type' => 'edit-notes',
            'note' => $note,
            'appointment' => $appointment,
        ];

        //show the form
        return new contentResponse($payload);
    }

    /**
     * delete note
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function deleteMyNotes($id) {

        //delete all notes by this user
        \App\Models\Note::Where('noteresource_type', 'appointment')
            ->where('noteresource_id', $id)
            ->where('note_creatorid', auth()->id())->delete();

        //refeshed data
        $appointments = $this->appointmentrepo->search($id);
        $appointment = $appointments->first();

        $payload = [
            'type' => 'show-notes',
            'note' => [],
            'appointment' => $appointment,
            'has_note' => false,
        ];

        //show the form
        return new contentResponse($payload);
    }

    /**
     * show text editor
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function createMyNotes($id) {

        //delete all notes by this user
        \App\Models\Note::Where('noteresource_type', 'appointment')
            ->where('noteresource_id', $id)
            ->where('note_creatorid', auth()->id())->delete();

        //refeshed data
        $appointments = $this->appointmentrepo->search($id);
        $appointment = $appointments->first();

        $payload = [
            'type' => 'create-notes',
            'note' => [],
            'appointment' => $appointment,
        ];

        //show the form
        return new contentResponse($payload);
    }

    /**
     * update notes
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function updateMyNotes($id) {

        //validation
        if (!request()->filled('appointment_mynotes')) {
            abort(409, __('lang.fill_in_all_required_fields'));
        }

        //delete all notes by this user
        \App\Models\Note::Where('noteresource_type', 'appointment')
            ->where('noteresource_id', $id)
            ->where('note_creatorid', auth()->id())->delete();

        //create note
        $note = new \App\Models\Note();
        $note->noteresource_type = 'appointment';
        $note->noteresource_id = $id;
        $note->note_creatorid = auth()->id();
        $note->note_description = request('appointment_mynotes');
        $note->note_visibility = 'private';
        $note->save();

        //refeshed data
        $appointments = $this->appointmentrepo->search($id);
        $appointment = $appointments->first();

        //package to send to response
        $payload = [
            'type' => 'show-notes',
            'note' => $note,
            'appointment' => $appointment,
            'has_note' => true,
        ];

        //show the form
        return new contentResponse($payload);
    }

    /**
     * show form for cloning appointments
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function cloneAppointment($id) {

        //get appointment
        $appointments = $this->appointmentrepo->search($id);
        $appointment = $appointments->first();

        //payload
        $payload = [
            'appointment' => $appointment,
        ];

        //show the view
        return new CloneResponse($payload);

    }

    /**
     * show form for cloning appointments
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function cloneStore(ProjectRepository $projectrepo, ProjectPermissions $projectpermissions, AppointmentAssignedRepository $assignedrepo, $id) {

        //validate appointment and milestones
        if (!request()->filled('appointment_milestoneid') || !request()->filled('project_id')) {
            abort(409, __('lang.fill_in_all_required_fields'));
        }

        //project exists
        if (\App\Models\Project::Where('project_id', request('project_id'))->doesntExist()) {
            abort(409, __('lang.project') . ' - ' . __('lang.is_invalid'));
        }

        //project exists
        if (\App\Models\Milestone::Where('milestone_id', request('appointment_milestoneid'))->where('milestone_projectid', request('project_id'))->doesntExist()) {
            abort(409, __('lang.milestone') . ' - ' . __('lang.is_invalid'));
        }

        //get users projects
        if (auth()->user()->is_team) {
            if (auth()->user()->is_admin) {
                $projects = \App\Models\Project::Where('project_type', 'project')->get();
                $project_list = [];
                foreach ($projects as $project) {
                    $project_list[] = $project->project_id;
                }
            } else {
                $project_list = $projectrepo->usersAssignedAndManageProjects(auth()->id(), 'list');
            }
        } else {
            $project_list = $rojectrepo->clientsProjects(auth()->user()->clientid, 'list');
        }

        //validate the project is valid for this user
        if (!in_array(request('project_id'), $project_list)) {
            abort(409, __('lang.invalid_permissions_for_project'));
        }

        //appointment
        $appointment = \App\Models\Appointment::Where('appointment_id', $id)->first();

        //project
        $project = \App\Models\Project::Where('project_id', request('project_id'))->first();

        //clone the appointment
        $data = [
            'appointment_title' => request('appointment_title'),
            'appointment_status' => request('appointment_status'),
            'appointment_milestoneid' => request('appointment_milestoneid'),
            'copy_checklist' => (request('copy_checklist') == 'on') ? true : false,
            'copy_files' => (request('copy_files') == 'on') ? true : false,
        ];
        $new_appointment = $this->appointmentrepo->cloneAppointment($appointment, $project, $data);

        //assign the appointment to self, for none admin users
        if (auth()->user()->is_team) {
            if (!$projectpermissions->check('super-user', $project)) {
                $assigned_users = $assignedrepo->add($new_appointment->appointment_id, auth()->id());
            }
        }

        //get table friendly collection
        $appointments = $this->appointmentrepo->search($new_appointment->appointment_id);

        //process for timers
        $this->processAppointments($appointments);

        //apply some permissions
        if ($appointments) {
            foreach ($appointments as $appointment) {
                $this->applyPermissions($appointment);
            }
        }

        //apply custom fields
        if ($appointments) {
            foreach ($appointments as $appointment) {
                $appointment->fields = $this->getCustomFields($appointment);
            }
        }

        Log::info("foo appointment", ['appointment' => $appointments->first()]);

        //payload
        $payload = [
            'appointment' => $appointments->first(),
            'appointments' => $appointments,
        ];

        //show the view
        return new CloneStoreResponse($payload);

    }

    /**
     * Show the form for editing the specified appointment
     * @param  int  $appointment appointment id
     * @return \Illuminate\Http\Response
     */
    public function recurringSettings($id) {

        //get the project
        $appointment = \App\Models\Appointment::Where('appointment_id', $id)->first();

        //reponse payload
        $payload = [
            'page' => $this->pageSettings('edit'),
            'appointment' => $appointment,
        ];

        //modal request
        if (request('source') == 'modal') {
            $html = view('pages/appointment/components/recurring', compact('appointment'))->render();
            $jsondata['dom_html'][] = [
                'selector' => '#card-left-panel',
                'action' => 'replace',
                'value' => $html,
            ];
            //ajax response
            return response()->json($jsondata);
        }

        //response
        return new RecurringSettingsResponse($payload);
    }

    /**
     * Update recurring settings
     * @param object AppointmentRecurrringSettings instance of the request validation object
     * @param  int  $appointment appointment id
     * @return \Illuminate\Http\Response
     */
    public function recurringSettingsUpdate(AppointmentRecurrringSettings $request, $id) {

        //get project
        $appointments = $this->appointmentrepo->search($id);
        $appointment = $appointments->first();

        //update
        $appointment->appointment_recurring = 'yes';
        $appointment->appointment_recurring_duration = request('appointment_recurring_duration');
        $appointment->appointment_recurring_period = request('appointment_recurring_period');
        $appointment->appointment_recurring_cycles = request('appointment_recurring_cycles');
        $appointment->appointment_recurring_next = request('appointment_recurring_next');
        $appointment->appointment_recurring_copy_checklists = (request('appointment_recurring_copy_checklists') == 'on') ? 'yes' : 'no';
        $appointment->appointment_recurring_copy_files = (request('appointment_recurring_copy_files') == 'on') ? 'yes' : 'no';
        $appointment->appointment_recurring_automatically_assign = (request('appointment_recurring_automatically_assign') == 'on') ? 'yes' : 'no';
        $appointment->save();

        //reset for infinite appointments (incase it had previously been set to finished)
        if ($appointment->appointment_recurring_cycles == 0) {
            $appointment->appointment_recurring_finished = 'no';
            $appointment->save();
        }

        //get refreshed
        $appointments = $this->appointmentrepo->search($id);
        $appointment = $appointments->first();

        //apply permissions
        $this->applyPermissions($appointment);

        //process
        $this->processAppointment($appointment);

        //reponse payload
        $payload = [
            'type' => 'update-recurring',
            'action' => 'update',
            'page' => $this->pageSettings('edit'),
            'appointments' => $appointments,
            'appointment' => $appointment,
        ];

        //response
        return new UpdateResponse($payload);
    }

    /**
     * stop an appointment from recurring
     * @return \Illuminate\Http\Response
     */
    public function stopRecurring() {

        //get the appointment
        $appointment = \App\Models\Appointment::Where('appointment_id', request()->route('appointment'))->first();

        //update the appointment
        $appointment->appointment_recurring = 'no';
        $appointment->appointment_recurring_duration = null;
        $appointment->appointment_recurring_period = null;
        $appointment->appointment_recurring_cycles = null;
        $appointment->appointment_recurring_next = null;
        $appointment->save();

        //get refreshed
        $appointments = $this->appointmentrepo->search(request()->route('appointment'));
        $appointment = $appointments->first();

        //apply permissions
        $this->applyPermissions($appointment);

        //process
        $this->processAppointment($appointment);

        //reponse payload
        $payload = [
            'type' => 'update-recurring',
            'action' => 'stop',
            'page' => $this->pageSettings('edit'),
            'appointments' => $appointments,
            'appointment' => $appointment,
        ];

        //show the form
        return new UpdateResponse($payload);
    }

    /**
     * store a appointment dependency
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function storeDependency(AppointmentDependencyRepository $dependencyrepo, $id) {

        //get the appointment
        $appointment = \App\Models\Appointment::Where('appointment_id', $id)->first();

        //get the blocking appointment
        if (!$blocking_appointment = \App\Models\Appointment::Where('appointment_id', request('appointmentsdependency_blockerid'))->first()) {
            abort(409, __('lang.blocking_appointment') . ' - ' . __('lang.could_not_be_found'));
        }

        //validation
        if (!request()->filled('appointmentsdependency_blockerid')) {
            abort(409, __('lang.blocking_appointment') . ' - ' . __('lang.is_required'));
        }

        //validation
        if ($blocking_appointment->appointment_status == 2) {
            abort(409, __('lang.blocking_appointment_is_already_completed'));
        }

        //check we do not already have this dependency
        if (\App\Models\AppointmentDependency::Where('appointmentsdependency_appointmentid', $id)
            ->Where('appointmentsdependency_blockerid', request('appointmentsdependency_blockerid'))
            ->Where('appointmentsdependency_type', request('appointmentsdependency_type'))
            ->exists()) {
            abort(409, __('lang.appointment_dependency_already_exists'));
        }

        $dependency = new \App\Models\AppointmentDependency();
        $dependency->appointmentsdependency_creatorid = auth()->id();
        $dependency->appointmentsdependency_projectid = $appointment->appointment_projectid;
        $dependency->appointmentsdependency_clientid = $appointment->appointment_clientid;
        $dependency->appointmentsdependency_appointmentid = $id;
        $dependency->appointmentsdependency_blockerid = request('appointmentsdependency_blockerid');
        $dependency->appointmentsdependency_type = request('appointmentsdependency_type');
        $dependency->save();

        //get all dependencies
        $dependecies_all = $dependencyrepo->search($id);

        //get refreshed
        $appointments = $this->appointmentrepo->search($id);
        $appointment = $appointments->first();

        //process and apply permissions
        $this->processAppointment($appointment);
        $this->applyPermissions($appointment);

        //reponse payload
        $payload = [
            'dependecies_all' => $dependecies_all,
            'appointment' => $appointment,
            'appointments' => $appointments,
        ];

        //show the form
        return new StoreAppointmentDependencyResponse($payload);

    }

    /**
     * A appointment's status has changed.
     *   If its completed - marke dependecies as 'fullfiled'
     *   If its not 'completed' mark dependecies as 'active'
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function refreshDependencies($appointment) {

        //if appointment is completed
        if ($appointment->appointment_status == 2) {
            \App\Models\AppointmentDependency::where('appointmentsdependency_blockerid', $appointment->appointment_id)
                ->update(['appointmentsdependency_status' => 'fulfilled']);
        } else {
            \App\Models\AppointmentDependency::where('appointmentsdependency_blockerid', $appointment->appointment_id)
                ->update(['appointmentsdependency_status' => 'active']);
        }

    }

    /**
     * delete appointment dependency
     * @param int $id appointment id
     * @return \Illuminate\Http\Response
     */
    public function deleteDependency($id) {

        //delete record
        \App\Models\AppointmentDependency::Where('appointmentsdependency_appointmentid', $id)->where('appointmentsdependency_id', request('dependency_id'))->delete();

        //get refreshed
        $appointments = $this->appointmentrepo->search($id);
        $appointment = $appointments->first();

        //process and apply permissions
        $this->processAppointment($appointment);
        $this->applyPermissions($appointment);

        //reponse payload
        $payload = [
            'appointments' => $appointments,
        ];

        //show the form
        return new DeleteAppointmentDependencyResponse($payload);

    }

    /**
     * basic page setting for this section of the app
     * @param string $section page section (optional)
     * @param array $data any other data (optional)
     * @return array
     */
    private function pageSettings($section = '', $data = []) {

        //common settings
        $page = [
            'crumbs' => [
                __('lang.appointments'),
            ],
            'crumbs_special_class' => 'list-pages-crumbs',
            'page' => 'appointments',
            'no_results_message' => __('lang.no_results_found'),
            'mainmenu_appointments' => 'active',
            'sidepanel_id' => 'sidepanel-filter-appointments',
            'dynamic_search_url' => url('appointments/search?action=search&appointmentresource_id=' . request('appointmentresource_id') . '&appointmentresource_type=' . request('appointmentresource_type')),
            'add_button_classes' => '',
            'load_more_button_route' => 'appointments',
            'source' => 'list',
        ];

        //default modal settings (modify for sepecif sections)
        $page += [
            'add_modal_title' => __('lang.add_appointment'),
            'add_modal_create_url' => url('appointments/create?appointmentresource_id=' . request('appointmentresource_id') . '&appointmentresource_type=' . request('appointmentresource_type')),
            'add_modal_action_url' => url('appointments?appointmentresource_id=' . request('appointmentresource_id') . '&appointmentresource_type=' . request('appointmentresource_type') . '&count=' . ($data['count'] ?? '')),
            'add_modal_action_ajax_class' => '',
            'add_modal_action_ajax_loading_target' => 'commonModalBody',
            'add_modal_action_method' => 'POST',
        ];

        //appointments list page
        if ($section == 'appointments') {
            $page += [
                'meta_title' => __('lang.appointments'),
                'heading' => __('lang.appointments'),
                'mainmenu_appointments' => 'active',
            ];
            return $page;
        }

        //appointment page
        if ($section == 'appointment') {
            //adjust
            $page['page'] = 'appointment';
            //add
            $page += [
            ];
            return $page;
        }

        //ext page settings
        if ($section == 'ext') {

            $page += [
                'list_page_actions_size' => 'col-lg-12',
            ];
            return $page;
        }

        //create new resource
        if ($section == 'create') {
            $page += [
                'section' => 'create',
            ];
            return $page;
        }

        //edit new resource
        if ($section == 'edit') {
            $page += [
                'section' => 'edit',
            ];
            return $page;
        }

        //return
        return $page;
    }

    /**
     * data for the stats widget
     * @return array
     */
    private function statsWidget($data = array()) {

        //default values
        $stats = [];

        foreach (config('appointment_statuses') as $status) {
            $stat = [
                'value' => \App\Models\Appointment::where('appointment_status', $status->appointmentstatus_id)->count(),
                'title' => runtimeLang($status->appointmentstatus_title),
                'percentage' => '100%',
                'color' => 'bg-' . $status->appointmentstatus_color,
            ];
            array_push($stats, $stat);
        }

        //return
        return $stats;
    }
}