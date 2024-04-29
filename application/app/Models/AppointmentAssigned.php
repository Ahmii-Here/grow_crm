<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class AppointmentAssigned extends Model {

    /**
     * @primaryKey string - primry key column.
     * @dateFormat string - date storage format
     * @guarded string - allow mass assignment except specified
     * @CREATED_AT string - creation date column
     * @UPDATED_AT string - updated date column
     */
    protected $table = 'appointments_assigned';
    protected $primaryKey = 'appointmentsassigned_id';
    protected $dateFormat = 'Y-m-d H:i:s';
    protected $guarded = ['appointmentsassigned_id'];
    const CREATED_AT = 'appointmentsassigned_created';
    const UPDATED_AT = 'appointmentsassigned_updated';
}
