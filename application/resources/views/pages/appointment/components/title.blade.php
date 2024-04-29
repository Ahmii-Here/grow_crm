<div class="card-title m-b-0">
    <span id="{{ runtimePermissions('appointment-edit-title', $appointment->permission_edit_appointment) }}"> {{ $appointment->appointment_title }}
    </span>
</div>
<!--buttons: edit-->
@if($appointment->permission_edit_appointment)
<div id="card-title-edit" class="card-title-edit hidden">
    <input type="text" class="form-control form-control-sm card-title-input" id="appointment_title" name="appointment_title">
    <!--button: subit & cancel-->
    <div id="card-title-submit" class="p-t-10 text-right">
        <button type="button" class="btn waves-effect waves-light btn-xs btn-default"
            id="card-title-button-cancel">{{ cleanLang(__('lang.cancel')) }}</button>
        <button type="button" class="btn waves-effect waves-light btn-xs btn-danger"
            data-url="{{ urlResource('/appointments/'.$appointment->appointment_id.'/update-title') }}" data-progress-bar='hidden'
            data-type="form" data-form-id="card-title-edit" data-ajax-type="post"
            id="card-title-button-save">{{ cleanLang(__('lang.save')) }}</button>
    </div>
</div>
@endif
<div class=""><small><strong>@lang('lang.lead'): </strong></small><small><a target="_blank" 
href="{{ url("/leads/v/" . $appointment->lead->lead_id . "/" . str_slug($appointment->lead->lead_title)) }}">{{ ($appointment->lead->lead_firstname ?? '') . ' ' . ($appointment->lead->lead_lastname ?? '') }}</a></small></div>
{{-- <div class=""><small><strong>@lang('lang.project'): </strong></small><small id="card-appointment-milestone-title"><a
            href="{{ url('projects/'.$appointment->project_id ?? '') }}">{{ $appointment->project_title ?? '---' }}</a></small></div>
<div class="m-b-15"><small><strong>@lang('lang.milestone'): </strong></small><small
        id="card-appointment-milestone-title">{{ runtimeLang($appointment->milestone_title, 'appointment_milestone') }}</small></div> --}}

<!--this item is archived notice-->
@if(runtimeArchivingOptions())
<div id="card_archived_notice_{{ $appointment->appointment_id }}"
    class="alert alert-warning p-t-7 p-b-7 {{ runtimeActivateOrAchive('archived-notice', $appointment->appointment_active_state) }}">
    <i class="mdi mdi-archive"></i> @lang('lang.this_appointment_is_archived')
</div>
@endif