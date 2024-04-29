<?php

/** --------------------------------------------------------------------------------
 * This classes renders the [assign appointment] email and stores it in the queue
 * @package    Grow CRM
 * @author     NextLoop
 *----------------------------------------------------------------------------------*/

namespace App\Mail;

use Illuminate\Bus\Queueable;
use Illuminate\Mail\Mailable;

class AppointmentAssignment extends Mailable {
    use Queueable;

    /**
     * The data for merging into the email
     */
    public $data;

    /**
     * Model instance
     */
    public $obj;

    /**
     * Model instance
     */
    public $user;

    public $emailerrepo;

    /**
     * Create a new message instance.
     *
     * @return void
     */
    public function __construct($user = [], $data = [], $obj = []) {

        $this->data = $data;
        $this->user = $user;
        $this->obj = $obj;

    }

    /**
     * Build the message.
     *
     * @return $this
     */
    public function build() {

        //email template
        if (!$template = \App\Models\EmailTemplate::Where('emailtemplate_name', 'Appointment Assignment')->first()) {
            return false;
        }

        //validate
        if (!$this->obj instanceof \App\Models\Appointment || !$this->user instanceof \App\Models\User) {
            return false;
        }

        //only active templates
        if ($template->emailtemplate_status != 'enabled') {
            return false;
        }

        //check if clients emails are disabled
        if ($this->user->type == 'client' && config('system.settings_clients_disable_email_delivery') == 'enabled') {
            return;
        }

        //get the appointment status
        if ($appointment_status = \App\Models\AppointmentStatus::Where('appointmentstatus_id', $this->obj->appointment_status)->first()) {
            $status = $appointment_status->appointmentstatus_title;
        } else {
            $status = '---';
        }

        //get common email variables
        $payload = config('mail.data');

        //set template variables
        $payload += [
            'first_name' => $this->user->first_name,
            'last_name' => $this->user->last_name,
            'assigned_by_first_name' => auth()->user()->first_name,
            'assigned_by_last_name' => auth()->user()->last_name,
            'appointment_id' => $this->obj->appointment_id,
            'appointment_title' => $this->obj->appointment_title,
            'appointment_created_date' => runtimeDate($this->obj->appointment_created),
            'appointment_date_start' => runtimeDate($this->obj->appointment_date_start),
            'appointment_description' => $this->obj->appointment_description,
            'appointment_date_due' => runtimeDate($this->obj->appointment_date_due),
            'project_title' => $this->obj->project_title,
            'project_id' => $this->obj->project_id,
            'client_name' => $this->obj->client_company_name,
            'client_id' => $this->obj->appointment_clientid,
            'appointment_status' => $status,
            'appointment_milestone' => $this->obj->milestone_title,
            'appointment_url' => url('/appointments/v/' . $this->obj->appointment_id . '/view'),
        ];

        //save in the database queue
        $queue = new \App\Models\EmailQueue();
        $queue->emailqueue_to = $this->user->email;
        $queue->emailqueue_subject = $template->parse('subject', $payload);
        $queue->emailqueue_message = $template->parse('body', $payload);
        $queue->emailqueue_resourcetype = 'project';
        $queue->emailqueue_resourceid = $this->obj->project_id;
        $queue->save();
    }
}
