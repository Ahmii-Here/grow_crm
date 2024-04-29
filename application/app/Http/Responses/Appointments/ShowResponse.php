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

class ShowResponse implements Responsable {

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

        // RIGHT PANEL---
        $html = view('pages/appointment/rightpanel', compact(
            'page',
            'appointment',
            'assigned',
            'milestones',
            'project_assigned',
            'payload',
            'reminder',
            'tags',
            'current_tags',
            'client_users',
            'project_appointments',
            'dependecies_all',
            'dependecies_blocking'
        ))->render();
        $jsondata['dom_html'][] = array(
            'selector' => '#card-right-panel',
            'action' => 'replace',
            'value' => $html);

        // LEFT PANEL - MAIN (changes must be reproduced in contentResponse)
        $html = view('pages/appointment/leftpanel', compact('page', 'appointment', 'progress'))->render();
        $jsondata['dom_html'][] = array(
            'selector' => '#card-left-panel',
            'action' => 'replace',
            'value' => $html);

        // LEFT PANEL - COMMENTS (changes must be reproduced in contentResponse)
        $html = view('pages/appointment/components/comment', compact('comments'))->render();
        $jsondata['dom_html'][] = array(
            'selector' => '#card-comments-container',
            'action' => 'replace',
            'value' => $html);

        // LEFT PANEL -  CHECKLISTS (changes must be reproduced in contentResponse)
        $html = view('pages/appointment/components/checklist', compact('checklists', 'progress'))->render();
        $jsondata['dom_html'][] = array(
            'selector' => '#card-checklists-container',
            'action' => 'replace',
            'value' => $html);

        // LEFT PANEL - CHECKLIST PROGRESS (changes must be reproduced in contentResponse)
        $html = view('pages/appointment/components/progressbar', compact('progress'))->render();
        $jsondata['dom_html'][] = array(
            'selector' => '#card-checklist-progress-container',
            'action' => 'replace',
            'value' => $html);

        // LEFT PANEL - ATTACHMENTS (changes must be reproduced in contentResponse)
        $html = view('pages/appointment/components/attachment', compact('attachments'))->render();
        $jsondata['dom_html'][] = array(
            'selector' => '#card-attachments-container',
            'action' => 'replace',
            'value' => $html);

        //HIDE NOTIFICATION ICONS ON CARDS
        $jsondata['dom_visibility'][] = [
            'selector' => "#card_notification_attachment_$id",
            'action' => 'hide',
        ];
        $jsondata['dom_visibility'][] = [
            'selector' => "#card_notification_comment_$id",
            'action' => 'hide',
        ];

        // SHOW MODAL------
        $jsondata['dom_classes'][] = [
            'selector' => '#cardModalContent',
            'action' => 'remove',
            'value' => 'hidden',
        ];

        //update browser url
        $jsondata['dom_browser_url'] = [
            'title' => __('lang.appointment') . ' - ' . $appointment->appointment_title,
            'url' => url("/appointments/v/" . $appointment->appointment_id . "/" . str_slug($appointment->appointment_title)),
        ];

        //show tabs menu
        $html = view('pages/appointment/content/tabmenu', compact('appointment'))->render();
        $jsondata['dom_html'][] = [
            'selector' => '#cardModalTabMenu',
            'action' => 'replace',
            'value' => $html,
        ];

        //BOOT THE JAVASCRIPT FOR CARDS
        $jsondata['postrun_functions'][] = [
            'value' => 'NXBootCards',
        ];

        //ajax response
        return response()->json($jsondata);

    }

}
