<!--heading-->
<div class="x-heading p-t-10"><i class="mdi mdi-file-document-box"></i>{{ cleanLang(__('lang.my_fields')) }}</div>



<!--Form Data-->
<div class="card-show-form-data " id="card-lead-myfields">
    <div class="x-fields-editor">
        <div class="form-group row">
            <div class="col-12">
                <label for="label" class="mb-1">
                    {{ cleanLang(__('lang.field_label')) }}
                </label>
                <input type="text" name="lead_myfield_label" value="{{ $field->label ?? '' }}" id="label" class="form-control mb-3">
                <label for="value" class="mb-1">
                    {{ cleanLang(__('lang.field_value')) }}
                </label>
                <input type="text" name="lead_myfield_value" value="{{ $field->value ?? '' }}" id="value" class="form-control mb-3">
            </div>
        </div>
    </div>

    <div class="form-group text-right">
        @if (($field->id ?? ''))
        <button type="button" class="btn btn-danger btn-xs ajax-request" data-loading-target="card-leads-left-panel"
            data-url="{{ url('/leads/content/'.$lead->lead_id.'/edit-myfields/'.($field->id ?? '')) }}" data-type="form"
            data-loading-class="loading-before-centre" data-ajax-type="post" data-form-id="card-lead-myfields">
            {{ cleanLang(__('lang.update')) }}
        </button>
        @else
        <button type="button" class="btn btn-danger btn-xs ajax-request" data-loading-target="card-leads-left-panel"
            data-url="{{ url('/leads/content/'.$lead->lead_id.'/edit-myfields/'.($field->id ?? '')) }}" data-type="form"
            data-loading-class="loading-before-centre" data-ajax-type="post" data-form-id="card-lead-myfields">
            {{ cleanLang(__('lang.add')) }}
        </button>
        @endif
    </div>
</div>