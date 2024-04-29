<?php

/** --------------------------------------------------------------------------------
 * This classes renders the response for the [update] process for the appointments
 * controller
 * @package    Grow CRM
 * @author     NextLoop
 *----------------------------------------------------------------------------------*/

namespace App\Http\Responses\Appointments;
use Illuminate\Contracts\Support\Responsable;

class UpdateTagsResponse implements Responsable {

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

        //full payload array
        $payload = $this->payload;

        $html = view('pages.appointment.components.tags', compact('tags', 'appointment', 'current_tags'))->render();
        $jsondata['dom_html'][] = [
            'selector' => '#card-tags-container',
            'action' => 'replace',
            'value' => $html,
        ];

        //update whole card (for kanban view)
        $board['appointments'] = $appointments;
        $html = view('pages/appointments/components/kanban/card', compact('board'))->render();
        $jsondata['dom_html'][] = array(
            'selector' => "#card_appointment_" . $appointment->appointment_id,
            'action' => 'replace-with',
            'value' => $html);

        //response
        return response()->json($jsondata);

    }

}
