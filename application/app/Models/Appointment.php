<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Appointment extends Model {

    /**
     * @primaryKey string - primry key column.
     * @dateFormat string - date storage format
     * @guarded string - allow mass assignment except specified
     * @CREATED_AT string - creation date column
     * @UPDATED_AT string - updated date column
     */
    protected $primaryKey = 'appointment_id';
    protected $dateFormat = 'Y-m-d H:i:s';
    protected $guarded = ['appointment_id'];
    const CREATED_AT = 'appointment_created';
    const UPDATED_AT = 'appointment_updated';

    /**
     * relatioship business rules:
     *         - the Project can have many Appointment
     *         - the Appointment belongs to one Project
     */
    public function project() {
        return $this->belongsTo('App\Models\Project', 'appointment_projectid', 'project_id');
    }

    public function lead() {
        return $this->belongsTo('App\Models\Lead', 'lead_id', 'lead_id');
    }

    /**
     * relatioship business rules:
     *         - the Creator (user) can have many Appointments
     *         - the Appointment belongs to one Creator (user)
     */
    public function creator() {
        return $this->belongsTo('App\Models\User', 'appointment_creatorid', 'id');
    }

    /**
     * relatioship business rules:
     *         - the Appointment can have many Comments
     *         - the Comment belongs to one Appointment
     *         - other Comments can belong to other tables
     */
    public function comments() {
        return $this->morphMany('App\Models\Comment', 'commentresource');
    }

    /**
     * relatioship business rules:
     *         - the Appointment can have many Comments
     *         - the Checklist belongs to one Appointment
     */
    public function checklists() {
        return $this->morphMany('App\Models\Checklist', 'checklistresource');
    }

    /**
     * relatioship business rules:
     *         - the Appointment can have many Attachments
     *         - the Attachment belongs to one Appointment
     *         - other Attachments can belong to other tables
     */
    public function attachments() {
        return $this->morphMany('App\Models\Attachment', 'attachmentresource');
    }

    /**
     * relatioship business rules:
     *         - the Appointment can have many Tags
     *         - the Tags belongs to one Appointment
     *         - other tags can belong to other tables
     */
    public function tags() {
        return $this->morphMany('App\Models\Tag', 'tagresource');
    }

    /**
     * relatioship business rules:
     *         - the Client can have many Tickets
     *         - the Ticket belongs to one Client
     */
    public function timers() {
        return $this->hasMany('App\Models\Timer', 'timer_appointmentid', 'appointment_id');
    }

    /**
     * The Users that are assigned to the Appointment.
     */
    public function assigned() {
        return $this->belongsToMany('App\Models\User', 'appointments_assigned', 'appointmentsassigned_appointmentid', 'appointmentsassigned_userid');
    }

    /**
     * relatioship business rules:
     *         - the Milestone can have many Appointments
     *         - the Appointment belongs to one Milestone
     */
    public function milestone() {
        return $this->belongsTo('App\Models\Milestone', 'appointment_milestoneid', 'milestone_id');
    }

    /**
     * The Users that are managers for the Project that this appointment belongs to
     */
    public function projectmanagers() {
        return $this->hasMany('App\Models\ProjectManager', 'projectsmanager_projectid', 'appointment_projectid');
    }

    /**
     * The assigned users table records
     */
    public function assignedrecords() {
        return $this->hasMany('App\Models\AppointmentAssigned', 'appointmentsassigned_appointmentid', 'appointment_id');
    }

    /**
     * relatioship business rules:
     *         - the Appointment can have many Events
     *         - the Event belongs to one Appointment
     *         - other Event can belong to other tables (Leads, etc)
     */
    public function events() {
        return $this->morphMany('App\Models\Event', 'eventresource');
    }

    /**
     * relatioship business rules:
     *         - the Appointment can have many reminders
     *         - the reminder belongs to one Appointment
     *         - other reminders can belong to other resources
     */
    public function reminders() {
        return $this->morphMany('App\Models\Reminder', 'reminderresource');
    }
}
