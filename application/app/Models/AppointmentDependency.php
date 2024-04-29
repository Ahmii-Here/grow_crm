<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class AppointmentDependency extends Model {

    /**
     * @primaryKey string - primry key column.
     * @dateFormat string - date storage format
     * @guarded string - allow mass assignment except specified
     * @CREATED_AT string - creation date column
     * @UPDATED_AT string - updated date column
     */

    protected $table = 'appointments_dependencies';
    protected $primaryKey = 'appointmentsdependency_id';
    protected $dateFormat = 'Y-m-d H:i:s';
    protected $guarded = ['fooo_id'];
    const CREATED_AT = 'appointmentsdependency_created';
    const UPDATED_AT = 'appointmentsdependency_updated';

}
