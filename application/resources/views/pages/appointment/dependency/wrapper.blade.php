<!--add dependency button-->
@if(config('permission.manage_dependency'))
<div class="x-element x-action x-element-info m-b-15" id="card-dependency-create-button"><i
        class="sl-icon-shuffle m-t--4 p-r-6"></i>
    <span class="x-highlight"> @lang('lang.add_a_dependency')</span>
</div>
@endif

<!--add adependency-->
<div class="appointment-dependency-container hidden" id="appointment-dependency-create-container">
    <!--blocking_appointment-->
    <div class="form-group row">
        <label class="col-sm-12 text-left control-label col-form-label">@lang('lang.blocking_appointment') <span
                class="align-middle text-info font-16" data-toggle="tooltip" title="@lang('lang.appointment_blocking_info_2')"
                data-placement="top"><i class="ti-info-alt"></i></span></label>
        <div class="col-sm-12">
            <select class="select2-basic form-control form-control-sm" id="appointmentsdependency_blockerid"
                name="appointmentsdependency_blockerid">
                @foreach($project_appointments as $project_appointment)
                @if($project_appointment->appointment_id != $appointment->appointment_id)
                <option value="{{ $project_appointment->appointment_id }}">{{ $project_appointment->appointment_title }}</option>
                @endif
                @endforeach
            </select>
        </div>
    </div>
    <!--blocking_appointment-->
    <div class="form-group row">
        <label class="col-sm-12 text-left control-label col-form-label">@lang('lang.dependency_type') <span
                class="align-middle text-info font-16" data-toggle="tooltip" title="@lang('lang.appointment_blocking_info_1')"
                data-placement="top"><i class="ti-info-alt"></i></span></label>
        <div class="col-sm-12">
            <select class="select2-basic form-control form-control-sm" id="appointmentsdependency_type"
                name="appointmentsdependency_type">
                <option value="cannot_complete">@lang('lang.this_appointment') - @lang('lang.dependency_type_cannot_complete')</option>
                <option value="cannot_start">@lang('lang.this_appointment') - @lang('lang.dependency_type_cannot_start')</option>
            </select>
        </div>
    </div>

    <div class="buttons-block  p-b-0 p-t-0 text-right">
        <!--close button (appointment/lead cards only-->
        <button type="button" class="btn btn-rounded-x btn-default btn-xs ajax-request"
            id="card-appointment-dependency-close-button">@lang('lang.close')</button>
        <!--delete button-->
        <!--save button-->
        <button type="button" class="btn btn-rounded-x btn-info btn-xs js-ajax-ux-request" data-url="{{ urlResource('appointments/'.$appointment->appointment_id.'/add-dependency') }} "
            data-type="form" data-form-id="appointment-dependency-create-container" data-loading-class="loading-before"
            data-loading-target="appointment-dependency-create-container" data-ajax-type="post">@lang('lang.save')</button>
    </div>
</div>



<!--appointment dependencies list-->
<div class="appointment-dependency-list-container" id="appointment-dependency-list-container">
    @include('pages.appointment.dependency.ajax')
</div>