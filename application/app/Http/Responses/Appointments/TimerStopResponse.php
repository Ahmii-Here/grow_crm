<?php

/** --------------------------------------------------------------------------------
 * This classes renders the response for the [timer] process for the appointments
 * controller
 * @package    Grow CRM
 * @author     NextLoop
 *----------------------------------------------------------------------------------*/

namespace App\Http\Responses\Appointments;
use Illuminate\Contracts\Support\Responsable;

class TimerStopResponse implements Responsable {

    private $payload;

    public function __construct($payload = array()) {
        $this->payload = $payload;
    }

    /**
     * render the view for bars
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function toResponse($request) {

        //set all data to arrays
        foreach ($this->payload as $key => $value) {
            $$key = $value;
        }

        //default
        $jsondata = [];

        if (isset($appointment_id) && is_numeric($appointment_id)) {
            //hide top buttons
            $jsondata['dom_visibility'][] = [
                'selector' => '#timer_button_stop_table_' . $appointment_id,
                'action' => 'hide',
            ];
            $jsondata['dom_visibility'][] = [
                'selector' => '#timer_button_stop_card_' . $appointment_id,
                'action' => 'hide',
            ];

            //show start buttons
            $jsondata['dom_visibility'][] = [
                'selector' => '#timer_button_start_table_' . $appointment_id,
                'action' => 'show',
            ];
            $jsondata['dom_visibility'][] = [
                'selector' => '#timer_button_start_card_' . $appointment_id,
                'action' => 'show',
            ];

            //removing running timers
            $jsondata['dom_classes'][] = array(
                'selector' => '#appointment_timer_table_' . $appointment_id,
                'action' => 'remove',
                'value' => 'timer-running');
            $jsondata['dom_classes'][] = array(
                'selector' => '#appointment_timer_card_' . $appointment_id,
                'action' => 'remove',
                'value' => 'timer-running');
            $jsondata['dom_visibility'][] = [
                'selector' => '#card-appointment-timer-' . $appointment_id,
                'action' => 'hide',
            ];

        }

        //reset and hide top nav timer
        $jsondata['dom_visibility'][] = [
            'selector' => '#my-timer-container-topnav',
            'action' => 'hide',
        ];
        $jsondata['dom_html'][] = [
            'selector' => '#my-timer-time-topnav',
            'action' => 'replace',
            'value' => runtimeSecondsHumanReadable(0, false),
        ];
        //update the dropdown details
        $jsondata['dom_html'][] = [
            'selector' => '#active-timer-topnav-container',
            'action' => 'replace',
            'value' => '',
        ];

        //response
        return response()->json($jsondata);

    }

}
