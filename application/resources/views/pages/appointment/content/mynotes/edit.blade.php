<!--heading-->
<div class="x-heading p-t-10"><i class="mdi mdi-file-document-box"></i>{{ cleanLang(__('lang.my_notes')) }}</div>



<!--Form Data-->
<div class="card-show-form-data " id="card-appointment-mynotes">
    <div class="x-notes-editor">
        <div class="form-group row">
            <div class="col-12">
                <textarea class="form-control form-control-sm tinymce-textarea" name="appointment_mynotes"
                    id="appointment_mynotes">{!! _clean($note->note_description ?? '') !!}</textarea>
            </div>
        </div>
    </div>

    <div class="form-group text-right">
        <button type="button" class="btn btn-danger btn-xs ajax-request" data-loading-target="card-appointments-left-panel"
            data-url="{{ url('/appointments/content/'.$appointment->appointment_id.'/edit-mynotes') }}" data-type="form"
            data-loading-class="loading-before-centre" data-ajax-type="post" data-form-id="card-appointment-mynotes">
            {{ cleanLang(__('lang.update')) }}
        </button>
    </div>
</div>