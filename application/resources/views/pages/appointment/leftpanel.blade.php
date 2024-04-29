<!--title-->
@include('pages.appointment.components.title')



<!--[dependency][lock-1] start-->
@if(config('visibility.appointment_is_locked'))
<div class="alert alert-warning">@lang('lang.appointment_dependency_info_cannot_be_started')</div>
@else


<!--description-->
@include('pages.appointment.components.description')


<!--checklist-->
@include('pages.appointment.components.checklists')



<!--attachments-->
@include('pages.appointment.components.attachments')

<!--comments-->
@if(config('visibility.appointments_standard_features'))
<div class="card-comments" id="card-comments">
    <div class="x-heading"><i class="mdi mdi-message-text"></i>Comments</div>
    <div class="x-content">
        @include('pages.appointment.components.post-comment')
        <!--comments-->
        <div id="card-comments-container">
            <!--dynamic content here-->
        </div>
    </div>
</div>
@endif
@endif
<!--[dependency][lock-1] end-->