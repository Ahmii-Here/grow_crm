<?php

/** --------------------------------------------------------------------------------
 * This repository class manages all the data absctration for appointment statuses
 *
 * @package    Grow CRM
 * @author     NextLoop
 *----------------------------------------------------------------------------------*/

namespace App\Repositories;

use App\Models\AppointmentStatus;
use Log;

class AppointmentStatusRepository {

    /**
     * The appointments repository instance.
     */
    protected $status;

    /**
     * Inject dependecies
     */
    public function __construct(AppointmentStatus $status) {
        $this->status = $status;
    }

    /**
     * Search model
     * @param int $id optional for getting a single, specified record
     * @return object appointment status collection
     */
    public function search($id = '') {

        $status = $this->status->newQuery();

        //joins
        $status->leftJoin('users', 'users.id', '=', 'appointments_status.appointmentstatus_creatorid');

        // all client fields
        $status->selectRaw('*');

        //count appointments
        $status->selectRaw('(SELECT COUNT(*)
                                      FROM appointments
                                      WHERE appointment_status = appointments_status.appointmentstatus_id)
                                      AS count_appointments');
        if (is_numeric($id)) {
            $status->where('appointmentstatus_id', $id);
        }

        //default sorting
        $status->orderBy('appointmentstatus_position', 'asc');

        // Get the results and return them.
        return $status->paginate(10000);
    }

    /**
     * update a record
     * @param int $id record id
     * @return mixed bool or id of record
     */
    public function update($id) {

        //get the record
        if (!$status = $this->status->find($id)) {
            return false;
        }

        //general
        $status->appointmentstatus_title = preg_replace('%[\[\'"\/\?\\\{}\]]%', '', request('appointmentstatus_title'));
        $status->appointmentstatus_color = request('appointmentstatus_color');

        //save
        if ($status->save()) {
            return $status->appointmentstatus_id;
        } else {
            Log::error("record could not be updated - database error", ['process' => '[AppointmentStatusRepository]', config('app.debug_ref'), 'function' => __function__, 'file' => basename(__FILE__), 'line' => __line__, 'path' => __file__]);
            return false;
        }
    }

    /**
     * Create a new record
     * @param int $position position of new record
     * @return mixed object|bool
     */
    public function create($position = '') {
        //validate
        if (!is_numeric($position)) {
            Log::error("error creating a new appointment status record in DB - (position) value is invalid", ['process' => '[create()]', config('app.debug_ref'), 'function' => __function__, 'file' => basename(__FILE__), 'line' => __line__, 'path' => __file__]);
            return false;
        }

        //save
        $status = new $this->status;

        //data
        $status->appointmentstatus_title = preg_replace('%[\[\'"\/\?\\\{}\]]%', '', request('appointmentstatus_title'));
        $status->appointmentstatus_color = request('appointmentstatus_color');
        $status->appointmentstatus_creatorid = auth()->id();
        $status->appointmentstatus_position = $position;

        //save and return id
        if ($status->save()) {
            return $status->appointmentstatus_id;
        } else {
            Log::error("record could not be updated - database error", ['process' => '[AppointmentStatusRepository]', config('app.debug_ref'), 'function' => __function__, 'file' => basename(__FILE__), 'line' => __line__, 'path' => __file__]);
            return false;
        }
    }
    

}