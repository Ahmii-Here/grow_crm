<?php

/** --------------------------------------------------------------------------------
 * This classes renders the response for the [update status] process for the appointments
 * controller
 * @package    Grow CRM
 * @author     NextLoop
 *----------------------------------------------------------------------------------*/

namespace App\Http\Responses\Appointments;
use Illuminate\Contracts\Support\Responsable;

class UpdateStatusLockedResponse implements Responsable {

    private $payload;

    public function __construct($payload = array()) {
        $this->payload = $payload;
    }

    /**
     * render the view for appointments
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function toResponse($request) {

        //set all data to arrays
        foreach ($this->payload as $key => $value) {
            $$key = $value;
        }

        //notice error
        $jsondata['notification'] = [
            'type' => 'force-error',
            'value' => __('lang.appointment_dependency_info_cannot_be_completed'),
        ];

        //update display text
        $jsondata['dom_html'][] = [
            'selector' => '#card-appointment-status-text',
            'action' => 'replace',
            'value' => runtimeLang($appointment->appointmentstatus_title),
        ];

        //remove loading
        $jsondata['dom_classes'][] = array(
            'selector' => '#card-appointment-status-text',
            'action' => 'remove',
            'value' => 'loading');

        //kanban view (if we had dragged and dropped)

        if (auth()->user()->pref_view_appointments_layout == 'kanban') {
            
            //kanban - format
            $board['appointments'] = $appointments;
            $html = view('pages/appointments/components/kanban/card', compact('board'))->render();

            //remove from complated board
            $jsondata['dom_visibility'][] = [
                'selector' => '#card_appointment_' . $appointment->appointment_id,
                'action' => 'hide-remove',
            ];

            //return to original board
            $jsondata['dom_html_end'][] = [
                'selector' => '#kanban-board-wrapper-' . $appointment->appointment_status,
                'action' => 'prepend',
                'value' => $html,
            ];
        }

        //response
        return response()->json($jsondata);

    }

}
