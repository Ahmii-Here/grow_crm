<?php

/** --------------------------------------------------------------------------------
 * This middleware class handles [edit] precheck processes for appointments
 *
 * @package    Grow CRM
 * @author     NextLoop
 *----------------------------------------------------------------------------------*/

namespace App\Http\Middleware\Appointments;
use App\Models\Appointment;
use App\Permissions\AppointmentPermissions;
use App\Repositories\ProjectRepository;
use Closure;
use Log;

class Cloning {

    /**
     * The permisson repository instance.
     */
    protected $appointmentpermissions;
    protected $projectrepo;

    /**
     * Inject any dependencies here
     *
     */
    public function __construct(AppointmentPermissions $appointmentpermissions) {

        //appointment permissions repo
        $this->appointmentpermissions = $appointmentpermissions;

    }

    /**
     * Check user permissions to edit a appointment
     * @param  \Illuminate\Http\Request  $request
     * @param  \Closure  $next
     * @return mixed
     */
    public function handle($request, Closure $next) {

        //appointment id
        $appointment_id = $request->route('appointment');

        //does the appointment exist
        if ($appointment_id == '' || !$appointment = \App\Models\Appointment::Where('appointment_id', $appointment_id)->first()) {
            Log::error("appointment could not be found", ['process' => '[permissions][appointments][cloning]', 'ref' => config('app.debug_ref'), 'function' => __function__, 'file' => basename(__FILE__), 'line' => __line__, 'path' => __file__, 'appointment id' => $appointment_id ?? '']);
            abort(409, __('lang.appointment_not_found'));
        }


        //permission for team members only (for now)
        if (auth()->user()->is_team) {
            if ($this->appointmentpermissions->check('view', $appointment_id)) {
                return $next($request);
            }
        }

        //no items were passed with this request
        Log::error("permission denied", ['process' => '[permissions][appointments][cloning]', 'ref' => config('app.debug_ref'), 'function' => __function__, 'file' => basename(__FILE__), 'line' => __line__, 'path' => __file__, 'appointment id' => $appointment_id ?? '']);
        abort(403);
    }
}
