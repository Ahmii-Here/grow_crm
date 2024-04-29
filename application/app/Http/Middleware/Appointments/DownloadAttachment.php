<?php

/** --------------------------------------------------------------------------------
 * This middleware class handles [download attachment] precheck processes for appointments
 *
 * @package    Grow CRM
 * @author     NextLoop
 *----------------------------------------------------------------------------------*/

namespace App\Http\Middleware\Appointments;
use App\Models\Appointment;
use App\Permissions\AppointmentPermissions;
use Closure;
use Log;

class DownloadAttachment {

    /**
     * The permisson repository instance.
     */
    protected $appointmentpermissions;

    /**
     * Inject any dependencies here
     *
     */
    public function __construct(AppointmentPermissions $appointmentpermissions) {

        //permissions
        $this->appointmentpermissions = $appointmentpermissions;

    }

    /**
     * Check user permissions to edit a appointment
     * @param  \Illuminate\Http\Request  $request
     * @param  \Closure  $next
     * @return mixed
     */
    public function handle($request, Closure $next) {

        //attachement id
        $attachment_uniqueid = $request->route('uniqueid');

        //does the appointment exist
        if (!$attachment = \App\Models\Attachment::Where('attachment_uniqiueid', $attachment_uniqueid)->first()) {
            Log::error("attachment could not be found", ['process' => '[permissions][appointments][download-attachment]', 'ref' => config('app.debug_ref'), 'function' => __function__, 'file' => basename(__FILE__), 'line' => __line__, 'path' => __file__, 'attachment unique id' => $attachment_uniqueid ?? '']);
            abort(404);
        }

        //validate that its a project appointment
        if ($attachment->attachmentresource_type == 'appointment') {
            //get the appointment
            if ($appointment = \App\Models\Appointment::Where('appointment_id', $attachment->attachmentresource_id)->first()) {
                //view appointment permissions
                if ($this->appointmentpermissions->check('view', $appointment->appointment_id)) {
                    return $next($request);
                }
            }
        }

        //no items were passed with this request
        Log::error("permission denied", ['process' => '[permissions][appointments][download-attachment]', 'ref' => config('app.debug_ref'), 'function' => __function__, 'file' => basename(__FILE__), 'line' => __line__, 'path' => __file__, 'attachment unique id' => $attachment_uniqueid ?? '']);
        abort(403);
    }
}