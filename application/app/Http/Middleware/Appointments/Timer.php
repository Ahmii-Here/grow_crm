<?php

/** --------------------------------------------------------------------------------
 * This middleware class handles [timer] precheck processes for appointments
 *
 * @package    Grow CRM
 * @author     NextLoop
 *----------------------------------------------------------------------------------*/

namespace App\Http\Middleware\Appointments;
use App\Permissions\ProjectPermissions;
use App\Permissions\AppointmentPermissions;
use Closure;
use Log;

class Timer {

    /**
     * The appointment permisson repository instance.
     */
    protected $appointment_permissions;

    /**
     * The project permisson repository instance.
     */
    protected $project_permissions;

    /**
     * Inject any dependencies here
     *
     */
    public function __construct(AppointmentPermissions $appointment_permissions, ProjectPermissions $project_permissions) {
        $this->appointment_permissions = $appointment_permissions;
        $this->project_permissions = $project_permissions;
    }

    /**
     * This middleware does the following
     *   1. validates that the appointment exists
     *   2. checks users permissions to stop or start [timers]
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \Closure  $next
     * @return mixed
     */
    public function handle($request, Closure $next) {

        //appointment id
        $appointment_id = $request->route('id');

        //action
        $action =  request()->segment(4);


        //validate
        if(!in_array($action, ['start','stop','stopall'])){
            Log::error("validation error - missing action", ['process' => '[permissions][appointment][timers]', 'ref' => config('app.debug_ref'), 'function' => __function__, 'file' => basename(__FILE__), 'line' => __line__, 'path' => __file__, 'appointment id' => $appointment_id ?? '', 'user_id' => auth()->id()]);
            abort(409);
        }

        //does the appointment exist
        if (!$appointment = \App\Models\Appointment::Where('appointment_id', $appointment_id)->first()) {
            Log::error("appointment could not be found", ['process' => '[permissions][appointment][timers]', 'ref' => config('app.debug_ref'), 'function' => __function__, 'file' => basename(__FILE__), 'line' => __line__, 'path' => __file__, 'appointment id' => $appointment_id ?? '', 'user_id' => auth()->id()]);
            abort(404);
        }

        //[team only]
        if (!auth()->user()->is_team) {
            Log::error("permission denied", ['process' => '[permissions][appointments][timers]', 'ref' => config('app.debug_ref'), 'function' => __function__, 'file' => basename(__FILE__), 'line' => __line__, 'path' => __file__, 'appointment id' => $appointment_id ?? '', 'user_id' => auth()->id()]);
            abort(403);
        }

        //[stop-all] all timers for a specific appointment
        if ($action == 'stopall') {
            if ($this->project_permissions->check('super-user', $appointment->appointment_projectid)) {
                return $next($request);
            } else {
                Log::error("permission denied", ['process' => '[permissions][appointments][timers]', 'ref' => config('app.debug_ref'), 'function' => __function__, 'file' => basename(__FILE__), 'line' => __line__, 'path' => __file__, 'appointment id' => $appointment_id ?? '', 'user_id' => auth()->id()]);
                abort(403);
            }
        }

        //[start][stop] a timer for a specific appointment
        if (in_array($action, ['start', 'stop'])) {
            if ($this->appointment_permissions->check('timers', $appointment_id)) {
                return $next($request);
            }
        }

        //permission denied
        Log::error("permission denied", ['process' => '[permissions][appointments][timers]', 'ref' => config('app.debug_ref'), 'function' => __function__, 'file' => basename(__FILE__), 'line' => __line__, 'path' => __file__, 'appointment id' => $appointment_id ?? '', 'user_id' => auth()->id()]);
        abort(403);
    }
}
