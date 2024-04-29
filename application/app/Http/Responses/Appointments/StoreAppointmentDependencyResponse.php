<?php

/** --------------------------------------------------------------------------------
 * This classes renders the response for the [store] process for the projects
 * controller
 * @author     NextLoop
 *----------------------------------------------------------------------------------*/

namespace App\Http\Responses\Appointments;
use Illuminate\Contracts\Support\Responsable;

class StoreAppointmentDependencyResponse implements Responsable {

    private $payload;

    public function __construct($payload = array()) {
        $this->payload = $payload;
    }

    /**
     * render the view for team members
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function toResponse($request) {

        //set all data to arrays
        foreach ($this->payload as $key => $value) {
            $$key = $value;
        }

        config([
            'permission.manage_dependency' => true,
        ]);

        $html = view('pages/appointment/dependency/ajax', compact('dependecies_all', 'appointment'))->render();
        $jsondata['dom_html'][] = [
            'selector' => '#appointment-dependency-list-container',
            'action' => 'replace',
            'value' => $html,
        ];

        //hide form
        $jsondata['dom_visibility'][] = [
            'selector' => '#appointment-dependency-create-container',
            'action' => 'hide',
        ];

        //show dependencies list
        $jsondata['dom_visibility'][] = [
            'selector' => '#appointment-dependency-list-container',
            'action' => 'show',
        ];

        //update the card
        $board['appointments'] = $appointments;
        $html = view('pages/appointments/components/kanban/card', compact('board'))->render();
        $jsondata['dom_html'][] = array(
            'selector' => "#card_appointment_" . $appointments->first()->appointment_id,
            'action' => 'replace-with',
            'value' => $html);

        //update the row
        $html = view('pages/appointments/components/table/ajax', compact('appointments'))->render();
        $jsondata['dom_html'][] = array(
            'selector' => "#appointment_" . $appointments->first()->appointment_id,
            'action' => 'replace-with',
            'value' => $html);

        //response
        return response()->json($jsondata);

    }

}