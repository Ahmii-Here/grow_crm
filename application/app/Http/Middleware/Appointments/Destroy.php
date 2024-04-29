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

class Destroy {

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

        //validate module status
        if (!config('visibility.modules.appointments')) {
            abort(404, __('lang.the_requested_service_not_found'));
            return $next($request);
        }

        //for a single item request - merge into an $ids[x] array and set as if checkox is selected (on)
        if (is_numeric($request->route('appointment'))) {
            $ids[$request->route('appointment')] = 'on';
            request()->merge([
                'ids' => $ids,
            ]);
        }

        //loop through each appointment and check permissions
        if (is_array(request('ids'))) {

            //validate each item in the list exists
            foreach (request('ids') as $id => $value) {
                //only checked items
                if ($value == 'on') {
                    //validate
                    if (!$appointment = \App\Models\Appointment::Where('appointment_id', $id)->first()) {
                        abort(409, __('lang.one_of_the_selected_items_nolonger_exists'));
                    }
                }
                //permission on each one
                if ($appointment->appointment_projectid > 0) {
                    //project appointment
                    if (!$this->appointmentpermissions->check('delete', $id)) {
                        abort(403, __('lang.permission_denied_for_this_item') . " - #$id");
                    }
                } else {
                    //template appointment
                    if (auth()->user()->role->role_templates_projects < 2) {
                        abort(403, __('lang.permission_denied_for_this_item') . " - #$id");
                    }
                }
            }
        } else {
            //no items were passed with this request
            Log::error("no items were sent with this request", ['process' => '[permissions][appointments][change-category]', 'ref' => config('app.debug_ref'), 'function' => __function__, 'file' => basename(__FILE__), 'line' => __line__, 'path' => __file__, 'appointment id' => $appointment_id ?? '']);
            abort(409);
        }

        //all is on - passed
        return $next($request);
    }
}
