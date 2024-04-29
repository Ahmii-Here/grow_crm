<?php

/** --------------------------------------------------------------------------------
 * This classes renders the response for the [update status] process for the appointments
 * controller
 * @package    Grow CRM
 * @author     NextLoop
 *----------------------------------------------------------------------------------*/

namespace App\Http\Responses\Appointments;
use Illuminate\Contracts\Support\Responsable;

class UpdateStatusResponse implements Responsable {

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

        //card
        $board['appointments'] = $appointments;
        $html = view('pages/appointments/components/kanban/card', compact('board'))->render();

        //update kanban card completely
        if ($old_status == $new_status) {
            $jsondata['dom_html'][] = array(
                'selector' => "#card_appointment_" . $appointments->first()->appointment_id,
                'action' => 'replace-with',
                'value' => $html);
        }

        //move card to new board
        if ($old_status != $new_status) {
            //remove from current board
            $jsondata['dom_visibility'][] = [
                'selector' => '#card_appointment_' . $appointments->first()->appointment_id,
                'action' => 'hide-remove',
            ];
            //add to new board
            $jsondata['dom_html_end'][] = [
                'selector' => '#kanban-board-wrapper-' . $new_status,
                'action' => 'prepend',
                'value' => $html,
            ];

            //replace the row of this record
            $html = view('pages/appointments/components/table/ajax', compact('appointments'))->render();
            $jsondata['dom_html'][] = array(
                'selector' => "#appointment_" . $appointments->first()->appointment_id,
                'action' => 'replace-with',
                'value' => $html);

            //reload stats widget
            $html = view('misc/list-pages-stats', compact('stats'))->render();
            $jsondata['dom_html'][] = array(
                'selector' => '#list-pages-stats-widget',
                'action' => 'replace-with',
                'value' => $html);
            //stats visibility of reload
            if (auth()->user()->stats_panel_position == 'open') {
                $jsondata['dom_visibility'][] = [
                    'selector' => '#list-pages-stats-widget',
                    'action' => 'show-flex',
                ];
            }

        }

        //update display text
        $jsondata['dom_html'][] = [
            'selector' => '#card-appointment-status-text',
            'action' => 'replace',
            'value' => runtimeLang($appointments->first()->appointmentstatus_title),
        ];

        //remove loading
        $jsondata['dom_classes'][] = array(
            'selector' => '#card-appointment-status-text',
            'action' => 'remove',
            'value' => 'loading');

        //response
        return response()->json($jsondata);

    }

}
