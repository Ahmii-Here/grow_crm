<?php

/** --------------------------------------------------------------------------------
 * This classes renders the response for the [show] process for the appointments
 * controller
 * @package    Grow CRM
 * @author     NextLoop
 *----------------------------------------------------------------------------------*/

namespace App\Http\Responses\Appointments;
use Illuminate\Contracts\Support\Responsable;

class contentResponse implements Responsable {

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

        /** -------------------------------------------------------------------------
         * show main appointment tab (home)
         * -------------------------------------------------------------------------*/
        if ($type == 'show-main') {

            // LEFT PANEL - MAIN (code is copied from ShowResponse)
            $html = view('pages/appointment/leftpanel', compact('page', 'appointment', 'progress'))->render();
            $jsondata['dom_html'][] = array(
                'selector' => '#card-left-panel',
                'action' => 'replace',
                'value' => $html);

            // LEFT PANEL - COMMENTS (code is copied from ShowResponse)
            $html = view('pages/appointment/components/comment', compact('comments'))->render();
            $jsondata['dom_html'][] = array(
                'selector' => '#card-comments-container',
                'action' => 'replace',
                'value' => $html);

            // LEFT PANEL - CHECKLISTS (code is copied from ShowResponse)
            $html = view('pages/appointment/components/checklist', compact('checklists', 'progress'))->render();
            $jsondata['dom_html'][] = array(
                'selector' => '#card-checklists-container',
                'action' => 'replace',
                'value' => $html);

            // LEFT PANEL - CHECKLIST PROGRESS (code is copied from ShowResponse)
            $html = view('pages/appointment/components/progressbar', compact('progress'))->render();
            $jsondata['dom_html'][] = array(
                'selector' => '#card-checklist-progress-container',
                'action' => 'replace',
                'value' => $html);

            // LEFT PANEL - ATTACHMENTS (code is copied from ShowResponse)
            $html = view('pages/appointment/components/attachment', compact('attachments'))->render();
            $jsondata['dom_html'][] = array(
                'selector' => '#card-attachments-container',
                'action' => 'replace',
                'value' => $html);

            // POSTRUN FUNCTIONS------
            $jsondata['postrun_functions'][] = [
                'value' => 'NXAppointmentAttachFiles',
            ];

            // POSTRUN FUNCTIONS------
            $jsondata['postrun_functions'][] = [
                'value' => 'NXBootCards',
            ];

        }

        /** -------------------------------------------------------------------------
         * show custom fields tab
         * -------------------------------------------------------------------------*/
        if ($type == 'show-custom-fields') {
            $html = view('pages/appointment/content/customfields/show', compact('appointment', 'fields'))->render();
            $jsondata['dom_html'][] = [
                'selector' => '#card-left-panel',
                'action' => 'replace',
                'value' => $html,
            ];
        }

        /** -------------------------------------------------------------------------
         * edit custom fields tab
         * -------------------------------------------------------------------------*/
        if ($type == 'edit-custom-fields') {
            $html = view('pages/appointment/content/customfields/edit', compact('appointment', 'fields'))->render();
            $jsondata['dom_html'][] = [
                'selector' => '#card-left-panel',
                'action' => 'replace',
                'value' => $html,
            ];
        }

        /** -------------------------------------------------------------------------
         * show user notes
         * -------------------------------------------------------------------------*/
        if ($type == 'show-notes') {
            $html = view('pages/appointment/content/mynotes/show', compact('appointment', 'note', 'has_note'))->render();
            $jsondata['dom_html'][] = [
                'selector' => '#card-left-panel',
                'action' => 'replace',
                'value' => $html,
            ];
        }

        /** -------------------------------------------------------------------------
         * show user notes
         * -------------------------------------------------------------------------*/
        if ($type == 'edit-notes' || $type == 'create-notes') {
            $html = view('pages/appointment/content/mynotes/edit', compact('appointment', 'note'))->render();
            $jsondata['dom_html'][] = [
                'selector' => '#card-left-panel',
                'action' => 'replace',
                'value' => $html,
            ];
        }

        /** -------------------------------------------------------------------------
         * show appointment logs
         * -------------------------------------------------------------------------*/
        if ($type == 'show-logs') {
            $html = view('pages/appointment/content/log/show', compact('logs'))->render();
            $jsondata['dom_html'][] = [
                'selector' => '#card-left-panel',
                'action' => 'replace',
                'value' => $html,
            ];
        }

        //ajax response
        return response()->json($jsondata);

    }

}
