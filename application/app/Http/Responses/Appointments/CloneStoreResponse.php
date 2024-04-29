<?php

/** --------------------------------------------------------------------------------
 * This classes renders the response for the [show] process for the appointments
 * controller
 *
 * [IMPORTANT] All Left Panel code must be reproduced in the file ContentResponse.php
 *
 * @package    Grow CRM
 * @author     NextLoop
 *----------------------------------------------------------------------------------*/

namespace App\Http\Responses\Appointments;
use Illuminate\Contracts\Support\Responsable;

class CloneStoreResponse implements Responsable {

    private $payload;

    public function __construct($payload = array()) {
        $this->payload = $payload;
    }

    /**
     * render the view
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

        //we are cloning to the same project that we are viewing or we are just on a general appointment list page
        if ((request('appointmentresource_id') == $appointment->appointment_projectid) || !request()->filled('appointmentresource_id')) {

            //kanban - add a new card
            $board['appointments'] = $appointments;
            $html = view('pages/appointments/components/kanban/card', compact('board'))->render();
            $jsondata['dom_html_end'][] = [
                'selector' => '#kanban-board-wrapper-' . $appointment->appointment_status,
                'action' => 'prepend',
                'value' => $html,
            ];

            //table - add a new row
            $html = view('pages/appointments/components/table/ajax', compact('appointments'))->render();
            $jsondata['dom_html'][] = array(
                'selector' => '#appointments-td-container',
                'action' => 'prepend',
                'value' => $html);
        }

        //close modal
        $jsondata['dom_visibility'][] = [
            'selector' => '#commonModal', 'action' => 'close-modal',
        ];

        //ajax response
        return response()->json($jsondata);

    }

}
