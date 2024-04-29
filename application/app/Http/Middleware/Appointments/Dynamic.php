<?php

/** --------------------------------------------------------------------------------
 * This middleware class handles [dynamic] precheck processes for appointments
 *
 * @package    Grow CRM
 * @author     NextLoop
 *----------------------------------------------------------------------------------*/

namespace App\Http\Middleware\Appointments;
use App\Models\Appointment;
use App\Permissions\AppointmentPermissions;
use Closure;
use Log;

class Dynamic {

    /**
     * The permisson repository instance.
     */
    protected $appointmentpermissions;

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
        
        //enable appointment to be loaded dynamically
        if (is_numeric(request()->route('appointment')) && request()->segment(2) == 'v') {
            config([
                'visibility.dynamic_load_modal' => true,
                'settings.dynamic_trigger_dom' => '#dynamic-appointment-content',
            ]);
        }
        

    }


}
