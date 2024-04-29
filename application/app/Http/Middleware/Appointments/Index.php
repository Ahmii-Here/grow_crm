<?php

/** --------------------------------------------------------------------------------
 * This middleware class handles [index] precheck processes for appointments
 *
 * @package    Grow CRM
 * @author     NextLoop
 *----------------------------------------------------------------------------------*/

namespace App\Http\Middleware\Appointments;

use App\Models\Appointment;
use App\Permissions\ProjectPermissions;
use App\Permissions\AppointmentPermissions;
use Closure;
use Log;

class Index {

    /**
     * The project permisson repository instance.
     */
    protected $projectpermissons;

    /**
     * The permisson repository instance.
     */
    protected $appointmentpermissions;

    /**
     * Inject any dependencies here
     *
     */
    public function __construct(ProjectPermissions $projectpermissons, AppointmentPermissions $appointmentpermissions) {

        $this->projectpermissons = $projectpermissons;

        $this->appointmentpermissions = $appointmentpermissions;
    }

    /**
     * This middleware does the following
     *   2. checks users permissions to [view] appointments
     *   3. modifies the request object as needed
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \Closure  $next
     * @return mixed
     */
    public function handle($request, Closure $next) {

        //validate module status
        if (!config('visibility.modules.appointments')) {
            abort(404, __('lang.the_requested_service_not_found'));
            return $next($request);
        }

        //various frontend and visibility settings
        $this->fronteEnd();

        //default - show only project appointments (and not template) - do not apply this filter when in project page
        if (!request()->filled('appointmentresource_type')) {
            if (request('filter_pt') == 'template') {
                //do nothing
            } else {
                request()->merge([
                    'filter_project_type' => 'project',
                ]);
            }
        }

        //toggle layout
        $this->toggleKanbanView();

        //[limit] - for users with only local level scope
        if (auth()->user()->is_team) {
            if (auth()->user()->role->role_appointments_scope == 'own') {
                request()->merge(['filter_my_appointments' => array(auth()->id())]);
            }
        }

        //first check - if this is a dynamic appointment url
        if (is_numeric(request()->route('appointment')) && request()->segment(2) == 'v') {
            if ($this->appointmentpermissions->check('view', request()->route('appointment'))) {
                config([
                    'visibility.dynamic_load_modal' => true,
                    'settings.dynamic_trigger_dom' => '#dynamic-appointment-content',
                ]);
                //return $next($request);
            } else {
                abort(404);
            }
        }

        //team user permission
        if (auth()->user()->is_team) {

            //viewing from projetc page
            if (request()->filled('appointmentresource_type') == 'project' && request()->filled('appointmentresource_id')) {
                if ($project = \App\Models\Project::Where('project_id', request('appointmentresource_id'))->first()) {
                    //template project
                    if ($project->project_type == 'template' && auth()->user()->role->role_templates_projects >= 2) {
                        request()->merge(['filter_my_appointments' => null]);
                        return $next($request);
                    }
                    //if user is a super user on the project - show all appointments
                    if ($this->projectpermissons->check('super-user', request('appointmentresource_id'))) {
                        request()->merge(['filter_my_appointments' => null]);
                        //toggle 'my appointments' button opntions
                        $this->toggleOwnFilter();
                        return $next($request);
                    }
                }
            }

            //generally
            if (auth()->user()->role->role_appointments >= 1) {
                //toggle 'my appointments' button opntions
                $this->toggleOwnFilter();
                return $next($request);
            }

        }

        //client - view appointments lists only when requested via an ajax call from projects page
        if (auth()->user()->is_client) {
            request()->merge([
                'filter_appointment_client_visibility' => 'yes',
                'filter_as_per_project_permissions' => 'yes',
                'filter_appointment_clientid' => auth()->user()->clientid,
            ]);
            return $next($request);
        }
        echo "<pre>";print_r(1);die;
        //permission denied
        Log::error("permission denied", ['process' => '[permissions][appointments][index]', 'ref' => config('app.debug_ref'), 'function' => __function__, 'file' => basename(__FILE__), 'line' => __line__, 'path' => __file__]);
        abort(403);
    }

    /*
     * various frontend and visibility settings
     */
    private function fronteEnd() {

        //defaults
        config([
            'visibility.appointments_col_project' => true,
            'visibility.appointments_col_priority' => true,
            'visibility.appointments_kanban_actions' => true,
            'visibility.appointments_col_project' => true,
            'visibility.appointments_col_milestone' => false,
            'visibility.appointments_col_priority' => false,
        ]);

        /**
         * shorten resource type and id (for easy appending in blade templates)
         * [usage]
         *   replace the usual url('appointment') with urlResource('appointment'), in blade templated
         * */
        if (request('appointmentresource_type') != '' || is_numeric(request('appointmentresource_id'))) {
            request()->merge([
                'resource_query' => 'ref=list&appointmentresource_type=' . request('appointmentresource_type') . '&appointmentresource_id=' . request('appointmentresource_id'),
            ]);
        } else {
            request()->merge([
                'resource_query' => 'ref=list',
            ]);
        }

        //permissions -viewing
        if (auth()->user()->role->role_appointments >= 1) {
            if (auth()->user()->is_team) {
                config([
                    'visibility.appointments_col_assigned' => true,
                    'visibility.list_page_actions_filter_button' => true,
                    'visibility.list_page_actions_search' => true,
                    'visibility.stats_toggle_button' => true,
                    'visibility.appointments_checkbox' => true,
                    'visibility.appointments_col_mytime' => true,
                ]);
                if (auth()->user()->role_id == 1) {
                    config([
                        'visibility.appointments_col_all_time' => false,
                    ]);
                }
            }
            if (auth()->user()->is_client) {
                config([
                    //visibility
                    'visibility.list_page_actions_search' => true,
                    'visibility.appointments_col_project' => false,
                    'visibility.appointments_nocheckbox' => true,
                ]);
                if (config('system.settings_projects_clientperm_assigned_view') == 'yes') {
                    config([
                        'visibility.appointments_col_assigned' => true,
                    ]);
                }
            }
        }

        //permissions -adding geeral appointments
        if (request('appointmentresource_type') == '' || request('appointmentresource_type') == 'client') {
            //team member with global permissions
            if (auth()->user()->is_team) {
                if (auth()->user()->role->role_appointments >= 2 && auth()->user()->role->role_appointments_scope == 'gobal') {
                    config([
                        //visibility
                        'visibility.list_page_actions_add_button' => true,
                        'visibility.appointments_col_checkboxes' => true,
                    ]);
                }
            }
        }

        //columns visibility
        if (request('appointmentresource_type') == 'client') {
            config([
                //visibility
                'visibility.appointments_col_client' => false,
                'visibility.filter_panel_client_appointment' => false,
                'visibility.appointments_col_category' => false,
            ]);
        }

        //visibility of 'filter assigned" in filter panel
        if (auth()->user()->is_team) {
            if (auth()->user()->role->role_appointments_scope == 'global') {
                config([
                    //visibility
                    'visibility.filter_panel_assigned' => true,
                ]);
            }
        }

        //team users, show more important columns
        if (auth()->user()->is_team) {
            if (!auth()->user()->is_admin) {
                config([
                    'visibility.appointments_col_assigned' => false,
                    'visibility.appointments_col_priority' => true,
                ]);
            }
        }

        //visibility from project page
        if (request()->filled('appointmentresource_id') && request('appointmentresource_type') == 'project') {
            config([
                'visibility.appointments_filter_milestone' => true,
                'visibility.appointments_col_project' => false,
            ]);

            //with permission to add appointments (team or client)
            if ($this->projectpermissons->check('appointments-add', request('appointmentresource_id'))) {
                config([
                    'visibility.list_page_actions_add_button' => true,
                ]);

                //for team members, allow to add on any board/stage
                if (auth()->user()->is_team) {
                    config([
                        'visibility.kanban_board_add_buttons' => true,
                    ]);
                }
            }

            //hide items when viewing [template] appointments
            if (request('filter_pt') == 'template') {
                config([
                    'visibility.list_page_actions_filter_button' => false,
                    'visibility.stats_toggle_button' => false,
                ]);

                if (auth()->user()->role->role_templates_projects >= 2) {
                    config([
                        'visibility.list_page_actions_add_button' => true,
                    ]);

                }
            }

        }

    }

    function toggleOwnFilter() {

        //visibility of 'my appointment(s" button - only users with globa scope need this button
        if (auth()->user()->role->role_appointments_scope == 'global') {
            config([
                //visibility
                'visibility.own_appointments_toggle_button' => true,
            ]);
        }

        //show toggle archived appointments button
        if (auth()->user()->is_team) {
            config([
                'visibility.archived_appointments_toggle_button' => true,
            ]);
        }

        //hide items when viewing [template] appointments
        if (request('filter_pt') == 'template') {
            config([
                'visibility.own_appointments_toggle_button' => false,
                'visibility.archived_appointments_toggle_button' => false,
            ]);
        }

        //update 'own appointments filter'
        if (request('toggle') == 'pref_filter_own_appointments') {
            //toggle database settings
            auth()->user()->pref_filter_own_appointments = (auth()->user()->pref_filter_own_appointments == 'yes') ? 'no' : 'yes';
            auth()->user()->save();
        }

        //update 'hide completed appointments filter'
        if (request('toggle') == 'pref_hide_completed_appointments') {
            //toggle database settings
            auth()->user()->pref_hide_completed_appointments = (auth()->user()->pref_hide_completed_appointments == 'yes') ? 'no' : 'yes';
            auth()->user()->save();
        }

        //update show archived appointments
        if (request('toggle') == 'pref_filter_show_archived_appointments') {
            //toggle database settings
            auth()->user()->pref_filter_show_archived_appointments = (auth()->user()->pref_filter_show_archived_appointments == 'yes') ? 'no' : 'yes';
            auth()->user()->save();
        }

        //a filter panel search has been done with assigned - so reset 'my appointments' to 'no'
        if (request()->filled('filter_assigned')) {
            if (auth()->user()->pref_filter_own_appointments == 'yes') {
                auth()->user()->pref_filter_own_appointments = 'no';
                auth()->user()->save();
            }
        }

        //set
        if (auth()->user()->pref_filter_own_appointments == 'yes') {
            request()->merge(['filter_my_appointments' => auth()->id()]);
        }

        //set
        if (auth()->user()->pref_filter_show_archived_appointments == 'yes') {
            request()->merge(['filter_show_archived_appointments' => 'yes']);
        }

        //set
        if (auth()->user()->pref_hide_completed_appointments == 'yes') {
            request()->merge(['filter_hide_completed_appointments' => 'yes']);
        }

    }

    function toggleKanbanView() {
        //update 'own appointments filter'
        if (request('toggle') == 'layout') {
            //toggle database settings
            auth()->user()->pref_view_appointments_layout = (auth()->user()->pref_view_appointments_layout == 'kanban') ? 'list' : 'kanban';
            auth()->user()->save();
        }

        //css setting for body
        if (auth()->user()->pref_view_appointments_layout == 'kanban') {
            config([
                'settings.css_kanban' => 'kanban',
                'visibility.kanban_appointments_sorting' => true,
            ]);
        }
    }

}