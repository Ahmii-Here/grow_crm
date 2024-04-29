<?php

/** --------------------------------------------------------------------------------
 * This repository class manages all the data absctration for templates
 *
 * @package    Grow CRM
 * @author     NextLoop
 *----------------------------------------------------------------------------------*/

namespace App\Repositories;

use App\Models\AppointmentDependency;
use Illuminate\Http\Request;

class AppointmentDependencyRepository {

    /**
     * The appointmentdependency repository instance.
     */
    protected $appointmentdependency;

    /**
     * Inject dependecies
     */
    public function __construct(AppointmentDependency $appointmentdependency) {
        $this->appointmentdependency = $appointmentdependency;
    }

    /**
     * Search model
     * @param int $id optional for getting a single, specified record
     * @return object appointmentdependencys collection
     */
    public function search($id = '') {

        $appointmentdependencys = $this->appointmentdependency->newQuery();

        // all client fields
        $appointmentdependencys->selectRaw('*');

        //joins
        $appointmentdependencys->leftJoin('appointments', 'appointments.appointment_id', '=', 'appointments_dependencies.appointmentsdependency_blockerid');

        //default where
        $appointmentdependencys->whereRaw("1 = 1");

        //appointment id
        if(is_numeric($id)){
            $appointmentdependencys->Where('appointmentsdependency_appointmentid', $id);
        }

        //filter: currently blocking
        if (request('filter_currently_blocking')) {
            $appointmentdependencys->Where('appointment_status', '!=', 'completed');
        }

        //sorting
        $appointmentdependencys->orderBy('appointment_title', 'asc');

        // Get the results and return them.
        return $appointmentdependencys->paginate(1000);
    }
}