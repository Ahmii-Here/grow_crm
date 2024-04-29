<!--heading-->
<div class="x-heading"><i class="mdi mdi-file-document-box"></i>{{ cleanLang(__('lang.custom_fields')) }}</div>

<!--Form Data-->
@if(count($fields ?? []) > 0)
<div class="card-show-form-data " id="card-appoinment-organisation">

    <!--render the form-->
    @include('misc.customfields')

    <div class="form-group text-right">
        <button type="button" class="btn waves-effect waves-light btn-xs btn-default ajax-request"
        data-url="{{ url('appoinments/content/'.$appoinment->appoinment_id.'/show-customfields') }}"
        data-loading-class="loading-before-centre" data-loading-target="card-appoinments-left-panel">@lang('lang.cancel')</button>
        <button type="button" class="btn btn-danger btn-xs ajax-request"
            data-loading-target="card-appoinments-left-panel"
            data-loading-class="loading-before-centre"
            data-url="{{ url('/appoinments/content/'.$appoinment->appoinment_id.'/edit-customfields') }}" data-type="form" data-ajax-type="post"
            data-form-id="card-appoinment-organisation">
            {{ cleanLang(__('lang.update')) }}
        </button>
    </div>
</div>
@else

nothng here

@endif