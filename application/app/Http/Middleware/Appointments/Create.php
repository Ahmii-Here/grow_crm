<?php

/** --------------------------------------------------------------------------------
 * This middleware class handles [create] precheck processes for appointments
 *
 * @package    Grow CRM
 * @author     NextLoop
 *----------------------------------------------------------------------------------*/

namespace App\Http\Middleware\Appointments;
use App\Permissions\ProjectPermissions;
use App\Permissions\AppointmentPermissions;
use Closure;
use Log;

class Create {

    /**
     * The permisson repository instance.
     */
    protected $appointmentpermissions;

    /**
     * The permisson repository instance.
     */
    protected $projectpermissions;

    /**
     * Inject any dependencies here
     *
     */
    public function __construct(AppointmentPermissions $appointmentpermissions, ProjectPermissions $projectpermissions) {

        //permissions repos
        $this->appointmentpermissions = $appointmentpermissions;
        $this->projectpermissions = $projectpermissions;
    }

    /**
     * This middleware does the following:
     *   1. checks users permissions to [create] a new resource
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

        //frontend
        $this->fronteEnd();

        //team user - project appointment
        if (auth()->user()->is_team) {
            if (request()->filled('appointmentresource_id') && request()->filled('appointmentresource_type') == 'project') {
                if ($project = \App\Models\Project::Where('project_id', request('appointmentresource_id'))->first()) {
                    //assigned team users
                    config([
                        'project.assigned' => $project->assigned()->get(),
                        'visibility.projects_assigned_users' => true,
                    ]);
                    //client users (for use in assigining appointment to client)
                    $client_users = \App\Models\User::Where('clientid', $project->project_clientid)->orderBy('first_name', 'ASC')->get();
                    config([
                        'project.client_users' => $client_users,
                    ]);

                    if ($this->projectpermissions->check('appointments-add', $project)) {
                        return $next($request);
                    }
                    //project templates
                    if ($project->project_type = 'template' && auth()->user()->role->role_templates_projects >= 2) {
                        return $next($request);
                    }
                }
            }
        }

        //team appointments from list page
        if (auth()->user()->is_team) {
            if (auth()->user()->role->role_appointments >= 2) {
                return $next($request);
            }
        }

        //client user
        if (auth()->user()->is_client) {

            //prefill some data
            request()->merge([
                'appointment_billable' => null,
            ]);

            if (request()->filled('appointmentresource_id') && request()->filled('appointmentresource_type') == 'project') {
                if ($project = \App\Models\Project::Where('project_id', request('appointmentresource_id'))->first()) {
                    //view & add appointments
                    if ($project->clientperm_appointments_create == 'yes') {
                        return $next($request);
                    }
                }
            }
        }

        //permission denied
        Log::error("permission denied", ['process' => '[permissions][appointments][create]', 'ref' => config('app.debug_ref'), 'function' => __function__, 'file' => basename(__FILE__), 'line' => __line__, 'path' => __file__]);
        abort(403);
    }

    /*
     * various frontend and visibility settings
     */
    private function fronteEnd() {

        //defaults
        config([
            'visibility.appointment_modal_project_option' => true,
            'visibility.appointment_modal_additional_options' => true,
            'visibility.appointments_standard_features' => true, //things to show for appointments linked to project (not templates)
        ]);

        //show milestone dropdown only from project page
        if (request()->filled('appointmentresource_id') && request()->filled('appointmentresource_type') == 'project') {
            config([
                'visibility.appointment_modal_milestone_option' => true,
            ]);
        }

        //assigning a appointment and setting its manager
        if (request('appointmentresource_type') == 'team') {
            if (auth()->user()->role->role_assign_appointments == 'yes') {
                config(['visibility.appointment_modal_assign_fields' => true]);
            } else {
                //assign only to current user and also make manager
                request()->merge([
                    'assigned' => [auth()->id()],
                ]);
            }
        }

        //project is already specified
        if (request()->filled('appointmentresource_id')) {
            request()->merge([
                'appointment_projectid' => request('appointmentresource_id'),
            ]);
            config([
                'visibility.appointment_modal_project_option' => false,
            ]);
        }

        //client options
        if (auth()->user()->is_client) {
            request()->merge([
                'appointment_status' => (is_numeric(request('appointment_status'))) ? request('appointment_status') : 1,
                'appointment_billable' => 'yes',
                'appointment_priority' => 'normal',
                'appointment_client_visibility' => 'on',
            ]);
            config([
                'visibility.appointment_modal_additional_options' => false,
            ]);
        }

        //clicked from topnav 'add' button
        if (request('ref') == 'quickadd') {
            config([
                'visibility.appointment_show_appointment_option' => true,
                'visibility.appointment_modal_project_option' => true,
            ]);
        }

        //hide elements for appointments linked to project templates
        if (is_numeric(request('appointmentresource_id')) && request('appointmentresource_id') < 0) {
            config([
                'visibility.appointments_standard_features' => false,
                'visibility.appointments_card_assigned' => false,
            ]);
        }
    }
}
