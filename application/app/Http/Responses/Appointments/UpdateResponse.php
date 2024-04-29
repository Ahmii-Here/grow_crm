<?php

/** --------------------------------------------------------------------------------
 * This classes renders the response for the [update] process for the appointments
 * controller
 * @package    Grow CRM
 * @author     NextLoop
 *----------------------------------------------------------------------------------*/

namespace App\Http\Responses\Appointments;
use Illuminate\Contracts\Support\Responsable;

class UpdateResponse implements Responsable {

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

        //replace the row of this record
        $html = view('pages/appointments/components/table/ajax', compact('appointments'))->render();
        $jsondata['dom_html'][] = array(
            'selector' => "#appointment_" . $appointments->first()->appointment_id,
            'action' => 'replace-with',
            'value' => $html);

        //refresh stats
        if (isset($stats)) {
            $html = view('misc/list-pages-stats-content', compact('stats'))->render();
            $jsondata['dom_html'][] = [
                'selector' => '#list-pages-stats-widget',
                'action' => 'replace',
                'value' => $html,
            ];
        }

        //assigned update
        if (isset($type) && $type == 'update-assigned') {
            //new list of assigned users
            $html = view('pages/appointment/components/assigned', compact('appointment', 'assigned'))->render();
            $jsondata['dom_html'][] = array(
                'selector' => "#appointment-assigned-container",
                'action' => 'replace',
                'value' => $html);
            //update timer section
            $html = view('pages/appointment/components/timer', compact('appointment'))->render();
            $jsondata['dom_html'][] = array(
                'selector' => "#appointment-timer-container",
                'action' => 'replace',
                'value' => $html);
            //remove loading annimation
            $jsondata['dom_classes'][] = [
                'selector' => '#appointment-assigned-container',
                'action' => 'remove',
                'value' => 'loading-placeholder',
            ];
        }

        //update priority
        if (isset($type) && $type == 'update-priority') {
            //update display text
            $jsondata['dom_html'][] = [
                'selector' => '#card-appointment-priority-text',
                'action' => 'replace',
                'value' => $display_priority,
            ];

            //remove loading
            $jsondata['dom_classes'][] = array(
                'selector' => '#card-appointment-priority-text',
                'action' => 'remove',
                'value' => 'loading');
        }

        //update priority
        if (isset($type) && $type == 'update-vivibility') {
            //update display text
            $jsondata['dom_html'][] = [
                'selector' => '#card-appointment-client-visibility-text',
                'action' => 'replace',
                'value' => $display_text,
            ];

            //remove loading
            $jsondata['dom_classes'][] = array(
                'selector' => '#card-appointment-client-visibility-text',
                'action' => 'remove',
                'value' => 'loading');
        }

        //update tags
        if (isset($type) && $type == 'update-tags') {
            $html = view('pages.appointment.components.tags', compact('tags', 'appointment', 'current_tags'))->render();
            $jsondata['dom_html'][] = [
                'selector' => '#card-tags-container',
                'action' => 'replace',
                'value' => $html,
            ];
        }

        //update error
        if (isset($error) && isset($message)) {
            $jsondata['notification'] = [
                'type' => 'error',
                'value' => $message,
            ];
        }

        //update kanban card completely
        $board['appointments'] = $appointments;
        $html = view('pages/appointments/components/kanban/card', compact('board'))->render();
        $jsondata['dom_html'][] = array(
            'selector' => "#card_appointment_" . $appointments->first()->appointment_id,
            'action' => 'replace-with',
            'value' => $html);

        //updating recurring settings
        if (isset($type) && $type == 'update-recurring') {
            if (request('source') == 'modal') {
                $html = view('pages/appointment/components/recurring', compact('appointment'))->render();
                $jsondata['dom_html'][] = [
                    'selector' => '#card-left-panel',
                    'action' => 'replace',
                    'value' => $html,
                ];
                //show recurring icon
                $jsondata['dom_visibility'][] = [
                    'selector' => '#appointment-modal-menu-recurring-icon',
                    'action' => ($action == 'update') ? 'show' : 'hide',
                ];
                //ajax response
                return response()->json($jsondata);
            } else {
                $close_modal = true;
            }
        }

        //close modal
        if (isset($close_modal) && $close_modal) {
            $jsondata['dom_visibility'][] = [
                'selector' => '#commonModal', 'action' => 'close-modal',
            ];
        }

        //status update - move card

        //response
        return response()->json($jsondata);

    }

}
