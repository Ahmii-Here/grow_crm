<!--heading-->
<div class="x-heading p-t-10 x-heading p-t-10 py-3"><i class="mdi mdi-file-document-box"></i>{{ cleanLang(__('lang.tasks')) }} 
            <a href="javascript:void(0)"
            class="edit-add-modal-button js-ajax-ux-request reset-target-modal-form btn btn-outline-primary float-right"
            data-toggle="modal" data-target="#commonModal"
            data-url="{{ url('/tasks/create?ref=quickadd&lead='.$lead->id) }}" data-loading-target="commonModalBody"
            data-modal-title="{{ cleanLang(__('lang.add_task')) }}"
            data-action-url="{{url('/tasks?ref=quickadd') }}" data-action-method="POST"
            data-action-ajax-loading-target="commonModalBody" data-save-button-class=""
            data-project-progress="0">
            <i class="ti-plus"></i></a></div>



<!--Form Data-->
<div class="card-show-form-data " id="card-lead-tasks">

    @if($has_task)
    @foreach ($tasks as $task)
        <div class="p-t-10 small">
            {!! _clean($task->task_title) !!}
        </div>
        <div class="form-data-row-buttons pt-0">
            <p style="color: brown;" class="small"><strong>({{ $task->creator->first_name ?? 'Anon' }})</strong> {{ date('d-M-Y h:i A', strtotime($task->task_created)) }}</p>
        </div>
    @endforeach

    @else
    <div class="x-no-result">
        <img src="{{ url('/') }}/public/images/no-download-avialble.png" alt="404 - Not found" /> 
        <div class="p-t-20"><h4>{{ cleanLang(__('lang.you_do_not_have_tasks')) }}</h4></div>
    </div>
    @endif

</div>