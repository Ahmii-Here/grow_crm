<?php

/** --------------------------------------------------------------------------------
 * This repository class manages all the data absctration for appointments
 *
 * @package    Grow CRM
 * @author     NextLoop
 *----------------------------------------------------------------------------------*/

namespace App\Repositories;

use App\Models\AppointmentAssigned;
use Illuminate\Http\Request;
use Log;

class AppointmentAssignedRepository {

    /**
     * The assigned repository instance.
     */
    protected $assigned;

    /**
     * Inject dependecies
     */
    public function __construct(AppointmentAssigned $assigned) {
        $this->assigned = $assigned;
    }

    /**
     * assigned new users to a appointment
     * @param int $appointment_id the id of the project
     * @param int $user_id if specified, only this user will be assigned
     * @return bool
     */
    public function add($appointment_id = '', $user_id = '') {

        $list = [];

        //validations
        if (!is_numeric($appointment_id)) {
            Log::error("validation error - invalid params", ['process' => '[AppointmentAssignedRepository]', config('app.debug_ref'), 'function' => __function__, 'file' => basename(__FILE__), 'line' => __line__, 'path' => __file__]);
            return $list;
        }

        //add only to the specified user
        if (is_numeric($user_id)) {
            $assigned = new $this->assigned;
            $assigned->appointmentsassigned_appointmentid = $appointment_id;
            $assigned->appointmentsassigned_userid = $user_id;
            $assigned->save();
            $list[] = $user_id;
            //return array of users
            return $list;
        }

        //[team] - add each user in the post request
        if (request()->filled('assigned')) {
            foreach (request('assigned') as $user) {
                $assigned = new $this->assigned;
                $assigned->appointmentsassigned_appointmentid = $appointment_id;
                $assigned->appointmentsassigned_userid = $user;
                $assigned->save();
                //save to list
                $list[] = $user;
            }
        }

        //[client] - add each user in the post request
        if (request()->filled('assigned-client')) {
            foreach (request('assigned-client') as $user) {
                $assigned = new $this->assigned;
                $assigned->appointmentsassigned_appointmentid = $appointment_id;
                $assigned->appointmentsassigned_userid = $user;
                $assigned->save();
                //save to list
                $list[] = $user;
            }
        }

        return $list;
    }

    /**
     * get all useers assigned to a appointment
     * @param int $id the id of the resource
     * @return object
     */
    public function getAssigned($id = '') {

        //validations
        if (!is_numeric($id)) {
            return [];
        }

        $query = $this->assigned->newQuery();
        $query->leftJoin('users', 'users.id', '=', 'appointments_assigned.appointmentsassigned_userid');
        $query->where('appointmentsassigned_appointmentid', $id);
        $query->orderBy('first_name', 'ASC');
        return $query->get();
    }

    /**
     * Bulk delete tags
     * @param string $ref_type type of tags. e.g. client|project etd
     * @param int $ref_id the id of the resource
     * @return bool
     */
    public function delete($appointment_id = '') {

        //validations
        if (!is_numeric($appointment_id)) {
            Log::error("record could not be found ", ['process' => '[AppointmentAssignedRepository]', config('app.debug_ref'), 'function' => __function__, 'file' => basename(__FILE__), 'line' => __line__, 'path' => __file__, 'appointment_id' => $appointment_id ?? '']);
            return false;
        }

        $assigned = $this->assigned->newQuery();
        $assigned->where('appointmentsassigned_appointmentid', $appointment_id);
        $assigned->delete();
    }

}