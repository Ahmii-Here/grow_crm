<?php

/** --------------------------------------------------------------------------------
 * This repository class manages all the data absctration for appointment priorityes
 *
 * @package    Grow CRM
 * @author     NextLoop
 *----------------------------------------------------------------------------------*/

namespace App\Repositories;

use App\Models\AppointmentPriority;
use Log;

class AppointmentPriorityRepository {

    /**
     * The appointments repository instance.
     */
    protected $priority;

    /**
     * Inject dependecies
     */
    public function __construct(AppointmentPriority $priority) {
        $this->priority = $priority;
    }

    /**
     * Search model
     * @param int $id optional for getting a single, specified record
     * @return object appointment priority collection
     */
    public function search($id = '') {

        $priority = $this->priority->newQuery();

        //joins
        $priority->leftJoin('users', 'users.id', '=', 'appointments_priority.appointmentpriority_creatorid');

        // all client fields
        $priority->selectRaw('*');

        //count appointments
        $priority->selectRaw('(SELECT COUNT(*)
                                      FROM appointments
                                      WHERE appointment_priority = appointments_priority.appointmentpriority_id)
                                      AS count_appointments');
        if (is_numeric($id)) {
            $priority->where('appointmentpriority_id', $id);
        }

        //default sorting
        $priority->orderBy('appointmentpriority_position', 'asc');

        // Get the results and return them.
        return $priority->paginate(10000);
    }

    /**
     * update a record
     * @param int $id record id
     * @return mixed bool or id of record
     */
    public function update($id) {

        //get the record
        if (!$priority = $this->priority->find($id)) {
            return false;
        }

        //general
        $priority->appointmentpriority_title = preg_replace('%[\[\'"\/\?\\\{}\]]%', '', request('appointmentpriority_title'));
        $priority->appointmentpriority_color = request('appointmentpriority_color');

        //save
        if ($priority->save()) {
            return $priority->appointmentpriority_id;
        } else {
            Log::error("record could not be updated - database error", ['process' => '[AppointmentPriorityRepository]', config('app.debug_ref'), 'function' => __function__, 'file' => basename(__FILE__), 'line' => __line__, 'path' => __file__]);
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
            Log::error("error creating a new appointment priority record in DB - (position) value is invalid", ['process' => '[create()]', config('app.debug_ref'), 'function' => __function__, 'file' => basename(__FILE__), 'line' => __line__, 'path' => __file__]);
            return false;
        }

        //save
        $priority = new $this->priority;

        //data
        $priority->appointmentpriority_title = preg_replace('%[\[\'"\/\?\\\{}\]]%', '', request('appointmentpriority_title'));
        $priority->appointmentpriority_color = request('appointmentpriority_color');
        $priority->appointmentpriority_creatorid = auth()->id();
        $priority->appointmentpriority_position = $position;

        //save and return id
        if ($priority->save()) {
            return $priority->appointmentpriority_id;
        } else {
            Log::error("record could not be updated - database error", ['process' => '[AppointmentPriorityRepository]', config('app.debug_ref'), 'function' => __function__, 'file' => basename(__FILE__), 'line' => __line__, 'path' => __file__]);
            return false;
        }
    }
    

}