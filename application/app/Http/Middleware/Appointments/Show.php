<?php

/** --------------------------------------------------------------------------------
 * This middleware class handles [show] precheck processes for appointments
 *
 * @package    Grow CRM
 * @author     NextLoop
 *----------------------------------------------------------------------------------*/

namespace App\Http\Middleware\Appointments;
use App\Models\Appointment;
use App\Permissions\AppointmentPermissions;
use App\Repositories\AppointmentRepository;
use Closure;
use Log;

class Show {

    protected $appointmentpermissions;
    protected $appointmentrepo;

    /**
     * Inject any dependencies here
     *
     */
    public function __construct(AppointmentRepository $appointmentrepo, AppointmentPermissions $appointmentpermissions) {

        //appointment permissions repo
        $this->appointmentpermissions = $appointmentpermissions;
        $this->appointmentrepo = $appointmentrepo;

    }

    /**
     * Check user permissions to edit a appointment
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

        //appointment id
        $appointment_id = $request->route('appointment');

        //does the appointment exist
        if ($appointment_id == '' || !$appointment = \App\Models\Appointment::Where('appointment_id', $appointment_id)->first()) {
            Log::error("appointment could not be found", ['process' => '[permissions][appointments][edit]', 'ref' => config('app.debug_ref'), 'function' => __function__, 'file' => basename(__FILE__), 'line' => __line__, 'path' => __file__, 'appointment id' => $appointment_id ?? '']);
            abort(404);
        }

        //dependency
        $this->dependency($appointment_id);

        //fronend
        $this->fronteEnd($appointment);

        //permission on each one
        if ($this->appointmentpermissions->check('view', $appointment_id)) {
            return $next($request);
        }

        //no items were passed with this request
        Log::error("permission denied", ['process' => '[permissions][appointments][edit]', 'ref' => config('app.debug_ref'), 'function' => __function__, 'file' => basename(__FILE__), 'line' => __line__, 'path' => __file__, 'appointment id' => $appointment_id ?? '']);
        abort(403);
    }

    /*
     * various frontend and visibility settings
     */
    private function fronteEnd($appointment = '') {

        //default visibilities
        config([
            'visibility.appointments_card_assigned' => true,
            'visibility.appointments_standard_features' => true, //things to show for appointments linked to project (not templates)
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

        //show toggle archived appointments button
        if (auth()->user()->is_team) {
            config([
                'visibility.archived_appointments_toggle_button' => true,
            ]);
        }

        //permission on each one
        if ($this->appointmentpermissions->check('edit', $appointment)) {
            config([
                'visibility.appointment_editing_buttons' => true,
            ]);
        }

        //set
        if (auth()->user()->pref_filter_show_archived_appointments == 'yes') {
            request()->merge(['filter_show_archived_appointments' => 'yes']);
        }

        //hide elements for appointments linked to project templates
        if (is_numeric(request('appointmentresource_id')) && request('appointmentresource_id') < 0) {
            config([
                'visibility.appointments_standard_features' => false,
                'visibility.appointments_card_assigned' => false,
            ]);
        }

    }

    /*
     * various frontend and visibility settings
     */
    private function dependency($appointment_id = '') {

        //get the appointment with counts etc
        $appointments = $this->appointmentrepo->search($appointment_id);
        $appointment = $appointments->first();

        config([
            'visibility.appointment_is_locked' => false,
            'visibility.appointment_is_open' => true,
            'permission.manage_dependency' => false,
        ]);

        //appointment is locked from editing
        if ($appointment->count_dependency_cannot_start > 0) {
            config([
                'visibility.appointment_is_locked' => true,
                'visibility.appointment_is_open' => false,
            ]);
        }

        //permission to manage dependencies
        if ($this->appointmentpermissions->check('manage-dependencies', $appointment)) {
            config([
                'permission.manage_dependency' => true,
            ]);
        }

    }

}
