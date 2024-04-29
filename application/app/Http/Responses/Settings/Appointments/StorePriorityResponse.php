<?php

/** --------------------------------------------------------------------------------
 * This classes renders the response for the [store] process for the appointments settings
 * controller
 * @package    Grow CRM
 * @author     NextLoop
 *----------------------------------------------------------------------------------*/

namespace App\Http\Responses\Settings\Appointments;
use Illuminate\Contracts\Support\Responsable;

class StorePriorityResponse implements Responsable {

    private $payload;

    public function __construct($payload = array()) {
        $this->payload = $payload;
    }


    /**
     * render the view for sources
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function toResponse($request) {

        //set all data to arrays
        foreach ($this->payload as $key => $value) {
            $$key = $value;
        }

        //prepend content on top of list
        $html = view('pages/settings/sections/appointments/priorities/ajax', compact('priorities'))->render();
        $jsondata['dom_html'][] = array(
            'selector' => '#priority-td-container',
            'action' => 'append',
            'value' => $html);

        //close modal
        $jsondata['dom_visibility'][] = array('selector' => '#commonModal', 'action' => 'close-modal');

        //notice
        $jsondata['notification'] = array('type' => 'success', 'value' => __('lang.request_has_been_completed'));

        //response
        return response()->json($jsondata);

    }

}
