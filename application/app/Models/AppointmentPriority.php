<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class AppointmentPriority extends Model {

    /**
     * @primaryKey string - primry key column.
     * @dateFormat string - date storage format
     * @guarded string - allow mass assignment except specified
     * @CREATED_AT string - creation date column
     * @UPDATED_AT string - updated date column
     */
    protected $table = 'appointments_priority';
    protected $primaryKey = 'appointmentpriority_id';
    protected $guarded = ['appointmentpriority_id'];
    protected $dateFormat = 'Y-m-d H:i:s';
    const CREATED_AT = 'appointmentpriority_created';
    const UPDATED_AT = 'appointmentpriority_updated';

    /**
     * relatioship business rules:
     *         - the Appointment Status can have many Appointments
     *         - the Appointment belongs to one Appointment Status
     */
    public function appointments() {
        return $this->hasMany('App\Models\Appointment', 'appointment_priority', 'appointmentpriority_id');
    }

}
