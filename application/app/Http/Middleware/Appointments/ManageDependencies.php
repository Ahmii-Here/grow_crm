<?php

/** --------------------------------------------------------------------------------
 * This middleware class handles [destroy] precheck processes for appointments
 *
 * @package    Grow CRM
 * @author     NextLoop
 *----------------------------------------------------------------------------------*/

namespace App\Http\Middleware\Appointments;
use App\Models\Appointment;
use App\Permissions\AppointmentPermissions;
use Closure;
use Log;

class ManageDependencies {

    /**
     * The permisson repository instance.
     */
    protected $appointmentpermissions;

    /**
     * Inject any dependencies here
     *
     */
    public function __construct(AppointmentPermissions $appointmentpermissions, Appointment $appointment_model) {

        //appointment permissions repo
        $this->appointmentpermissions = $appointmentpermissions;

    }

    /**
     * Check user permissions to destroy a appointment
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \Closure  $next
     * @return mixed
     */
    public function handle($request, Closure $next) {

        //appointment id
        $appointment_id = $request->route('appointment');

        //does the appointment exist
        if ($appointment_id == '' || !$appointment = \App\Models\Appointment::Where('appointment_id', $appointment_id)->first()) {
            abort(409, __('lang.appointment_not_found'));
        }

        //permission on each one
        if ($this->appointmentpermissions->check('manage-dependencies', $appointment_id)) {
            return $next($request);
        }

        //no items were passed with this request
        abort(403);
    }
}
