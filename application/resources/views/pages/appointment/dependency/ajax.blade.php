@foreach($dependecies_all as $dependency)
<!--each dependency-->
<div id="appointment_dependency_appointment_{{ $dependency->appointmentsdependency_id }}"
    class="appointment-dependency-appointment {{ runtimeTaskDependencyColors($dependency->appointmentsdependency_type,  $dependency->appointmentsdependency_status)}}">
    <span><a href="{{ url('/appointments/v/'.$dependency->appointment_id) }}" target="_blank">{{ $dependency->appointment_title }}</a></span>

    <!--delete dependency-->
    @if(config('permission.manage_dependency'))
    <span class="appointment-dependency-delete-button ajax-request" id="appointment-dependency-delete-button" data-parent="appointment_dependency_appointment_{{ $dependency->appointmentsdependency_id }}"
        data-url="{{ urlResource('/appointments/'.$appointment->appointment_id.'/delete-dependency?dependency_id='.$dependency->appointmentsdependency_id) }}" data-ajax-type="DELETE"
        data-progress-bar="hidden">
        <i class="sl-icon-close"></i>
    </span>
    @endif

    <!--dependency fullfilled-->
    @if($dependency->appointmentsdependency_status == 'fulfilled')
    <span class="appointment-dependency-fulfilled-icon">
        <i class="mdi mdi-checkbox-marked-circle"></i>
    </span>
    @endif

</div>
@endforeach

<!--info panel-->
@if(count($dependecies_all ?? []) > 0)
<div class="p-l-1">
    <span class="bg-danger appointment-dependency-tooltip" data-toggle="tooltip" data-placement="top"
        title="@lang('lang.dependency_prevents_appointment_from_completing')">
    </span>
    <span class="bg-warning appointment-dependency-tooltip" data-toggle="tooltip" data-placement="top"
        title="@lang('lang.dependency_prevents_appointment_from_starting')">
    </span>
    <span class="bg-success appointment-dependency-tooltip" data-toggle="tooltip" data-placement="top"
        title="@lang('lang.dependency_has_been_fulfilled')">
    </span>
</div>
@endif