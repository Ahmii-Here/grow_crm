    <!--heading-->
<div class="x-heading p-t-10"><i class="mdi mdi-file-document-box"></i>{{ cleanLang(__('lang.my_fields')) }}</div>



<!--Form Data-->
<div class="card-show-form-data " id="card-lead-myfields">

    @if($has_field)
    @foreach ($fields as $field)
        <div class="p-t-10 row mb-2">
            <div class="col-8">
                <strong>{{  ($field->label) }}</strong>  {!! _clean($field->value) !!}
            </div>
            <div class="col-4">
                <div class="form-data-row-buttons">
                    <button type="button" class="btn btn-danger btn-xs d-none confirm-action-danger"
                        data-loading-target="card-leads-left-panel" data-confirm-title="@lang('lang.delete_item')"
                        data-confirm-text="@lang('lang.are_you_sure')"
                        data-url="{{ url('/leads/content/'.$lead->lead_id.'/delete-myfields/'. $field->id) }}" data-ajax-type="DELETE"
                        data-loading-class="loading-before-centre">
                        {{ cleanLang(__('lang.delete')) }}
                    </button>
                    <button type="button" class="btn waves-effect waves-light btn-xs btn-info ajax-request"
                        data-url="{{ url('leads/content/'.$lead->lead_id.'/edit-myfields/'. $field->id) }}"
                        data-loading-class="loading-before-centre"
                        data-loading-target="card-leads-left-panel">@lang('lang.edit')</button>
                </div>
            </div>
        </div>
    @endforeach

    @else
    <div class="x-no-result d-none">
        <img src="{{ url('/') }}/public/images/no-download-avialble.png" alt="404 - Not found" /> 
        <div class="p-t-20"><h4>{{ cleanLang(__('lang.you_do_not_have_fields')) }}</h4></div>
    </div>
    @endif
    <div class="p-t-10">
        <button class="btn btn-info btn-sm ajax-request"
        data-loading-class="loading-before-centre"
        data-loading-target="card-leads-left-panel"
        data-url="{{ url('/leads/content/'.$lead->lead_id.'/create-myfields') }}" >@lang('lang.add') <i class="fas fa-plus"></i></a>
    </div>

</div>