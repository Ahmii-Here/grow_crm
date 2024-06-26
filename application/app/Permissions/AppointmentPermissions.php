<?php

namespace App\Permissions;

use App\Repositories\LeadRepository;
use App\Repositories\ProjectRepository;
use App\Repositories\AppointmentRepository;
use Illuminate\Support\Facades\Log;

class AppointmentPermissions {

    /**
     * The appointment repository instance.
     */
    protected $appointmentrepo;

    /**
     * The project repository instance.
     */
    protected $projectrepo;

    /**
     * The lead repository instance.
     */
    protected $leadrepo;

    /**
     * Inject dependecies
     */
    public function __construct(
        AppointmentRepository $appointmentrepo,
        ProjectRepository $projectrepo,
        LeadRepository $leadrepo
    ) {

        $this->appointmentrepo = $appointmentrepo;
        $this->projectrepo = $projectrepo;
        $this->leadrepo = $leadrepo;

    }

    /**
     * The array of checks that are available.
     * NOTE: when a new check is added, you must also add it to this array
     * @return array
     */
    public function permissionChecksArray() {
        $checks = [
            'view',
            'edit',
            'delete',
            'participate',
            'show',
            'timers',
            'super-user',
            'assign-users',
            'users',
            'assigned',
            'manage-dependencies',
        ];
        return $checks;
    }

    /**
     * This method checks a users permissions for a particular, specified Appointment ONLY.
     *
     * [EXAMPLE USAGE]
     *          if (!$this->appointmentpermissons->check($appointment_id, 'delete')) {
     *                 abort(413)
     *          }
     *
     * @param numeric $appointment object or id of the resource
     * @param string $action [required] intended action on the resource se list above
     * @param object $project optional
     * @param object $assigned_users optional
     * @param object $assigned_project_users optional
     * @param object $project_managers optional
     * @return bool true if user has permission
     */
    public function check($action = '', $appointment = '', $project = '', $assigned_users = '', $assigned_project_users = '', $project_managers = '') {

        //VALIDATIOn
        if (!in_array($action, $this->permissionChecksArray())) {
            Log::error("the requested check is invalid", ['process' => '[permissions][appointment]', config('app.debug_ref'), 'function' => __function__, 'file' => basename(__FILE__), 'line' => __line__, 'path' => __file__, 'check' => $action ?? '']);
            return false;
        }

        //GET THE RESOURCE
        if (is_numeric($appointment)) {
            if (!$appointment = \App\Models\Appointment::Where('appointment_id', $appointment)->first()) {
                Log::error("the appointment coud not be found", ['process' => '[permissions][appointment]', config('app.debug_ref'), 'function' => __function__, 'file' => basename(__FILE__), 'line' => __line__, 'path' => __file__]);
            }
        }

        //[IMPORTANT]: any passed appointment object must from appointmentrepo->search() method, not the appointment model
        if ($appointment instanceof \App\Models\Appointment || $appointment instanceof \Illuminate\Pagination\LengthAwarePaginator) {
            //array of assigned users
            if (!isset($assigned_users) || $assigned_users == '') {
                $assigned_users = $appointment->assigned->pluck('id');
            }
            //array of project managers for parent project
            if (!isset($project_managers) || $project_managers == '') {
                $project_managers = $appointment->projectmanagers->pluck('id');
            }
            //the appointment project
            if (!isset($project) || $project == '') {
                $project = $appointment->project()->first();
            }
            if (!isset($assigned_project_users)) {
                $assigned_project_users = $project->assigned->pluck('id');
            }
        } else {
            Log::error("the appointment coud not be found", ['process' => '[permissions][appointment]', config('app.debug_ref'), 'function' => __function__, 'file' => basename(__FILE__), 'line' => __line__, 'path' => __file__]);
            return false;
        }

        /**
         * [ARRAY OF USERS (with view level permssions)]
         * [NOTES] this must have the same logic as $action == 'view' below
         */
        if ($action == 'users') {

            $list = [];
            $users = \App\Models\User::Where('status', 'active')->with('role')->get();

            foreach ($users as $user) {
                if ($user->id > 0) {
                    if ($user->type == 'team' && isset($user->role->role_appointments)) {
                        //assigned with editing permissions
                        if ($assigned_users->contains($user->id) && $user->role->role_appointments >= 2) {
                            $list[] = $user->id;
                            continue;
                        }
                        //user with global access
                        if ($user->role->role_appointments_scope == 'global' && $user->role->role_appointments >= 2) {
                            $list[] = $user->id;
                            continue;
                        }
                        //creator of the appointment
                        if ($appointment->appointment_creatorid == $user->id) {
                            $list[] = $user->id;
                            continue;
                        }
                        //project managers of parent project
                        if ($project_managers->contains($user->id)) {
                            $list[] = $user->id;
                            continue;
                        }
                    }
                    //client
                    if ($user->type == 'client') {
                        //project allows client participation
                        if ($project instanceof \App\Models\Project) {
                            if ($project->project_clientid == $user->clientid) {
                                if ($project->clientperm_appointments_view == 'yes' && $appointment->appointment_client_visibility == 'yes') {
                                    $list[] = $user->id;
                                    continue;
                                }
                            }
                        }
                    }

                }
            }
            return $list;
        }

        /**
         * [ADMIN]
         * Grant full permission for whatever request
         *
         */
        if (auth()->user()->role_id == 1) {
            return true;
        }

        /**
         * [ADMIN LEVEL USER]
         * Check if a user has super user/admin level permissions on the appointment
         *
         */
        if ($action == 'super-user') {
            //project managers of parent project
            if ($project_managers->contains(auth()->id())) {
                return true;
            }
            //admin user
            if (auth()->user()->role_id == 1) {
                return true;
            }
            //project templates
            if ($project->project_type = 'template' && auth()->user()->role->role_templates_projects >= 2) {
                return true;
            }
        }

        /**
         * Check is logged in user is assigned to this appointment
         */
        if ($action == 'assigned') {
            if ($assigned_users->contains(auth()->id())) {
                return true;
            }
        }

        /**
         * [ASSIGN USERS]
         * Check if a user has assigning permissions on the appointment
         *
         */
        if ($action == 'assign-users') {
            //project managers of parent project
            if ($project_managers->contains(auth()->id())) {
                return true;
            }
            //admin user
            if (auth()->user()->role_id == 1) {
                return true;
            }
            //generally allowed
            if (auth()->user()->role->role_assign_appointments == 'yes') {
                return true;
            }
        }

        /**
         * [EDITING A TASK]
         *   grant permissions as follows:
         *   - assigned appointment members [with] appointment editing permissions (from their user role)
         *   - team user with global appointment editing permissions
         *   - client/team user who created the appointment
         */
        if ($action == 'edit') {

            //team
            if (auth()->user()->is_team) {
                //assigned with editing permissions
                if ($assigned_users->contains(auth()->id()) && auth()->user()->role->role_appointments >= 2) {
                    return true;
                }
                //user with global access
                if (auth()->user()->role->role_appointments_scope == 'global' && auth()->user()->role->role_appointments >= 2) {
                    return true;
                }
                //creator of the appointment
                if ($appointment->appointment_creatorid == auth()->id()) {
                    return true;
                }
                //project managers of parent project
                if ($project_managers->contains(auth()->id())) {
                    return true;
                }
                //project templates
                if ($project->project_type = 'template' && auth()->user()->role->role_templates_projects >= 2) {
                    return true;
                }
            }

            //client
            if (auth()->user()->is_client) {
                //creator of the appointment
                if ($appointment->appointment_creatorid == auth()->id()) {
                    return true;
                }
                //assigned to the appointment
                if ($assigned_users->contains(auth()->id())) {
                    return true;
                }
            }
        }

        /**
         * [VIEW A TASK]
         *   grant permissions as follows:
         *   - assigned appointment members [with] appointment [viewing] permissions (from their user role)
         *   - team user with global appointment editing permissions
         *   - creator of the appointment
         *   - client [if] the appointment is visible and [if] the project permssions allow clients to view appointments
         */
        if ($action == 'view') {

            if (auth()->user()->is_team) {
                //assigned with editing permissions
                if ($assigned_users->contains(auth()->id())) {
                    return true;
                }
                //user with global access
                if (auth()->user()->role->role_appointments_scope == 'global' && auth()->user()->role->role_appointments >= 1) {
                    return true;
                }
                //creator of the appointment
                if ($appointment->appointment_creatorid == auth()->id()) {
                    return true;
                }
                //project managers of parent project
                if ($project_managers->contains(auth()->id())) {
                    return true;
                }
                //project allows appointment collaboration by other members of the project
                if ($project instanceof \App\Models\Project) {
                    if ($assigned_project_users->contains(auth()->id())) {
                        if ($project->assignedperm_appointments_collaborate == 'yes') {
                            return true;
                        }
                    }
                }
                //project templates
                if ($project->project_type = 'template' && auth()->user()->role->role_templates_projects >= 2) {
                    return true;
                }
            }

            //client
            if (auth()->user()->is_client) {
                //project allows client participation
                if ($project instanceof \App\Models\Project) {
                    if ($project->project_clientid == auth()->user()->clientid) {
                        if ($project->clientperm_appointments_view == 'yes' && $appointment->appointment_client_visibility == 'yes') {
                            return true;
                        }
                    }
                }
            }

        }

        /**
         * [DELETING A TASK]
         *   grant permissions as follows:
         *   - assigned appointment members [with] appointment [deleting] permissions (from their user role)
         *   - team user with global appointment deleteing permissions
         *   - appointment creator
         *   - client [if] they created the appointment
         */
        if ($action == 'delete') {

            //team
            if (auth()->user()->is_team) {
                if (auth()->user()->role->role_appointments >= 3) {
                    //global
                    if (auth()->user()->role->role_appointments_scope == 'global') {
                        return true;
                    }
                }
                //creator
                if ($appointment->appointment_creatorid == auth()->id()) {
                    return true;
                }
                //project managers of parent project
                if ($project_managers->contains(auth()->id())) {
                    return true;
                }
                //project templates
                if ($project->project_type = 'template' && auth()->user()->role->role_templates_projects >= 2) {
                    return true;
                }
            }

            //client
            if (auth()->user()->is_client) {
                //creator of the appointment
                if ($appointment->appointment_creatorid == auth()->id()) {
                    return true;
                }
            }
        }

        /**
         * [PARTICIPATE]
         *   grant permissions as follows:
         *   - assigned appointment members [with] appointment [editing] permissions (from their user role)
         *   - team user with global appointment deleteing permissions
         *   - other team assigned to the same project [if] team participation is enabled on the project
         *   - appointment creator
         *   - client [if] appointment collaboration is enabled on the project
         * 
         * [PARTICATION ACTIONS]
         * - comments, attach files, create checklists, etc
         */
        if ($action == 'participate') {

            if (auth()->user()->is_team) {
                //assigned
                if ($assigned_users->contains(auth()->id()) && auth()->user()->role->role_appointments > 1) {
                    return true;
                }
                //user with global access
                if (auth()->user()->role->role_appointments_scope == 'global' && auth()->user()->role->role_appointments >= 2) {
                    return true;
                }
                //creator
                if ($appointment->appointment_creatorid == auth()->id()) {
                    return true;
                }
                //project managers of parent project
                if ($project_managers->contains(auth()->id())) {
                    return true;
                }
                //project allows appointment collaboration by other members of the project
                if ($project instanceof \App\Models\Project) {
                    if ($assigned_project_users->contains(auth()->id())) {
                        if ($project->assignedperm_appointments_collaborate == 'yes') {
                            //use must still have more than just viewing permissions
                            if (auth()->user()->role->role_appointments > 1) {
                                return true;
                            }
                        }
                    }
                }
                //project templates
                if ($project->project_type = 'template' && auth()->user()->role->role_templates_projects >= 2) {
                    return true;
                }
            }

            //client
            if (auth()->user()->is_client) {
                //project allows appointment participation
                if ($project instanceof \App\Models\Project) {
                    if ($project->project_clientid == auth()->user()->clientid) {
                        if ($project->clientperm_appointments_collaborate == 'yes' && $appointment->appointment_client_visibility == 'yes') {
                            return true;
                        }
                    }
                }
            }

        }

        /**
         * [TIMERS]
         * - comments, attach files, create checklists, etc
         */
        if ($action == 'timers') {

            if (auth()->user()->is_team) {
                //assigned
                if ($assigned_users->contains(auth()->id()) && auth()->user()->role->role_appointments > 1) {
                    return true;
                }
            }
        }

        /**
         * [MANAGE DEPENDENCIES]
         * Check if a user can manage appointment dependencies
         *
         */
        if ($action == 'manage-dependencies') {

            //admin users ony
            if (config('system.settings2_appointments_manage_dependencies') == 'admin-users') {
                if (auth()->user()->is_admin) {
                    return true;
                }
            }

            //admin and project managers
            if (config('system.settings2_appointments_manage_dependencies') == 'super-users') {
                if (auth()->user()->is_admin || $project_managers->contains(auth()->id())) {
                    return true;
                }
            }

            //assigend users
            if (config('system.settings2_appointments_manage_dependencies') == 'all-appointment-users') {
                if (auth()->user()->is_admin || $project_managers->contains(auth()->id()) || $assigned_users->contains(auth()->id())) {
                    return true;
                }
            }

        }

        //failed
        Log::info("permissions denied on this appointment", ['process' => '[permissions][appointments]', config('app.debug_ref'), 'function' => __function__, 'file' => basename(__FILE__), 'line' => __line__, 'path' => __file__]);
        return false;
    }

}