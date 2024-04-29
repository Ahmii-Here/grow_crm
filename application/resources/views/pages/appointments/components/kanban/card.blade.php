@foreach($board['appointments'] as $appointment)
<!--each card-->
<div class="kanban-card kanban-board-element show-modal-button reset-card-modal-form js-ajax-ux-request"
    data-toggle="modal" data-target="#cardModal" data-url="{{ urlResource('/appointments/'.$appointment->appointment_id) }}"
    data-appointment-id="{{ $appointment->appointment_id }}" data-loading-target="main-top-nav-bar" id="card_appointment_{{ $appointment->appointment_id }}">
    <div class="x-title wordwrap" id="kanban_appointment_title_{{ $appointment->appointment_id }}">{{ $appointment->appointment_title }}
        <span class="x-action-button" id="card-action-button-{{ $appointment->appointment_id }}" data-toggle="dropdown"
            aria-haspopup="true" aria-expanded="false"><i class="mdi mdi-dots-vertical"></i></span>
        <div class="dropdown-menu dropdown-menu-small dropdown-menu-right js-stop-propagation"
            aria-labelledby="card-action-button-{{ $appointment->appointment_id }}">
            @php $count_actions = 0 ; @endphp
            <!--delete-->
            @if($appointment->permission_delete_appointment)
            <a class="dropdown-item confirm-action-danger  js-stop-propagation"
                data-confirm-title="{{ cleanLang(__('lang.delete_item')) }}"
                data-confirm-text="{{ cleanLang(__('lang.are_you_sure')) }}" data-ajax-type="DELETE"
                data-url="{{ url('/') }}/appointments/{{ $appointment->appointment_id }}">{{ cleanLang(__('lang.delete')) }}</a>
            @php $count_actions ++ ; @endphp
            @endif

            <!--clone appointment (team only)-->
            @if(auth()->user()->is_team && $appointment->permission_edit_appointment)
            <a class="dropdown-item edit-add-modal-button js-ajax-ux-request reset-target-modal-form"
                data-toggle="modal" data-target="#commonModal" data-modal-title="@lang('lang.clone_appointment')"
                data-url="{{ urlResource('/appointments/'.$appointment->appointment_id.'/clone') }}"
                data-action-url="{{ urlResource('/appointments/'.$appointment->appointment_id.'/clone') }}" data-modal-size="modal-lg"
                data-loading-target="commonModalBody" data-action-method="POST" aria-expanded="false">
                @lang('lang.clone_appointment')
            </a>
            @php $count_actions ++ ; @endphp
            @endif

            <!--record time-->
            @if($appointment->assigned_to_me)
            <a class="dropdown-item edit-add-modal-button js-ajax-ux-request reset-target-modal-form"
                data-confirm-title="{{ cleanLang(__('lang.archive_appointment')) }}" data-toggle="modal"
                data-target="#commonModal" data-modal-title="@lang('lang.record_your_work_time')"
                data-url="{{ url('/timesheets/create?appointment_id='.$appointment->appointment_id) }}"
                data-action-url="{{ urlResource('/timesheets') }}" data-modal-size="modal-sm"
                data-loading-target="commonModalBody" data-action-method="POST" aria-expanded="false">
                {{ cleanLang(__('lang.record_time')) }}
            </a>
            @php $count_actions ++ ; @endphp
            @endif

            <!--stop my timer-->
            @if($appointment->timer_current_status)
            <a class="dropdown-item confirm-action-danger js-stop-propagation"
                data-confirm-title="{{ cleanLang(__('lang.stop_my_timer')) }}"
                data-confirm-text="{{ cleanLang(__('lang.are_you_sure')) }}" data-ajax-type="GET"
                data-url="{{ url('/') }}/appointments/timer/{{ $appointment->appointment_id }}/stop">{{ cleanLang(__('lang.stop_my_timer')) }}</a>
            @php $count_actions ++ ; @endphp
            @endif
            <!--stop all timers-->
            @if(auth()->user()->is_team && $appointment->permission_super_user)
            <a class="dropdown-item confirm-action-danger js-stop-propagation"
                data-confirm-title="{{ cleanLang(__('lang.stop_all_timers')) }}"
                data-confirm-text="{{ cleanLang(__('lang.are_you_sure')) }}" data-ajax-type="GET"
                data-url="{{ url('/') }}/appointments/timer/{{ $appointment->appointment_id }}/stopall?source=list">{{ cleanLang(__('lang.stop_all_timers')) }}</a>
            @php $count_actions ++ ; @endphp
            @endif


            @if(auth()->user()->is_team && $appointment->permission_edit_appointment)
            <!--recurring settings-->
            <a class="dropdown-item edit-add-modal-button js-ajax-ux-request reset-target-modal-form"
                href="javascript:void(0)" data-toggle="modal" data-target="#commonModal"
                data-url="{{ urlResource('/appointments/'.$appointment->appointment_id.'/recurring-settings?source=list') }}"
                data-loading-target="commonModalBody" data-modal-title="{{ cleanLang(__('lang.recurring_settings')) }}"
                data-action-url="{{ urlResource('/appointments/'.$appointment->appointment_id.'/recurring-settings?source=list') }}"
                data-action-method="POST"
                data-action-ajax-loading-target="appointments-td-container">{{ cleanLang(__('lang.recurring_settings')) }}</a>
            <!--stop recurring -->
            @if($appointment->appointment_recurring == 'yes')
            <a class="dropdown-item confirm-action-info" href="javascript:void(0)"
                data-confirm-title="{{ cleanLang(__('lang.stop_recurring')) }}"
                data-confirm-text="{{ cleanLang(__('lang.are_you_sure')) }}"
                data-url="{{ urlResource('/appointments/'.$appointment->appointment_id.'/stop-recurring?source=list') }}">
                {{ cleanLang(__('lang.stop_recurring')) }}</a>
            @endif
            @endif

            <!--archive-->
            @if($appointment->permission_super_user && runtimeArchivingOptions())
            <a class="dropdown-item confirm-action-info {{ runtimeActivateOrAchive('archive-button', $appointment->appointment_active_state) }} card_archive_button_{{ $appointment->appointment_id }}"
                id="card_archive_button_{{ $appointment->appointment_id }}"
                data-confirm-title="{{ cleanLang(__('lang.archive_appointment')) }}"
                data-confirm-text="{{ cleanLang(__('lang.are_you_sure')) }}" data-ajax-type="PUT"
                data-url="{{ urlResource('/appointments/'.$appointment->appointment_id.'/archive') }}">
                {{ cleanLang(__('lang.archive')) }}
            </a>
            @php $count_actions ++ ; @endphp
            @endif

            <!--activate-->
            @if($appointment->permission_super_user && runtimeArchivingOptions())
            <a class="dropdown-item confirm-action-info {{ runtimeActivateOrAchive('activate-button', $appointment->appointment_active_state) }} card_restore_button_{{ $appointment->appointment_id }}"
                id="card_restore_button_{{ $appointment->appointment_id }}"
                data-confirm-title="{{ cleanLang(__('lang.restore_appointment')) }}"
                data-confirm-text="{{ cleanLang(__('lang.are_you_sure')) }}" data-ajax-type="PUT"
                data-url="{{ urlResource('/appointments/'.$appointment->appointment_id.'/activate') }}">
                {{ cleanLang(__('lang.restore')) }}
            </a>
            @php $count_actions ++ ; @endphp
            @endif

            <!--no actions-->
            @if($count_actions == 0)
            <a class="dropdown-item js-stop-propagation"
                href="javascript:void(0);">{{ cleanLang(__('lang.no_actions_available')) }}</a>
            @endif
        </div>
    </div>
    <div class="x-meta">
        <!--milestone-->
        @if(config('system.settings_appointments_kanban_milestone') == 'show')
        <div>
            <label class="label label-{{ $appointment->milestone_color ?? 'default' }} p-t-3 p-b-3 p-l-8 p-r-8"
                data-toggle="tooltip" title="@lang('lang.milestone')">{{ $appointment->milestone_title }}</label>
        </div>
        @endif
        <!--priority-->
        @if(config('system.settings_appointments_kanban_priority') == 'show')
        <label class="label label-{{ $appointment->appointmentpriority_color }} p-t-3 p-b-3 p-l-8 p-r-8" data-toggle="tooltip"
            title="@lang('lang.priority')">{{ $appointment->appointmentpriority_title }}</label>
        @endif
        <!--tags-->
        @if(config('system.settings_appointments_kanban_tags') == 'show')
        <div class="wrap-words">
            @foreach($appointment->tags as $appointment_tag)
            <label class="label label-light-primary p-t-3 p-b-3 p-r-8 p-l-8">{{ $appointment_tag->tag_title }}</label>
            @endforeach
        </div>
        @endif
        <!--lead-->
        <span title="{{ ($appointment->lead->lead_firstname ?? '') . ' ' . ($appointment->lead->lead_lastname ?? '')  }}"><strong>{{ cleanLang(__('lang.lead')) }}:</strong>
            {{ str_limit(($appointment->lead->lead_firstname ?? '') . ' ' . ($appointment->lead->lead_lastname ?? '') , 68) }}</span>
        <!--project-->
        @if(1==2 && config('system.settings_appointments_kanban_project_title') == 'show')
        <span title="{{ $appointment->project_title ?? '---' }}"><strong>{{ cleanLang(__('lang.project')) }}:</strong>
            {{ str_limit($appointment->project_title ??'---', 68) }}</span>
        @endif
        <!--client-->
        @if(1==2 && config('system.settings_appointments_kanban_client_name') == 'show')
        <span title="{{ $appointment->client_company_name ?? '---' }}"><strong>{{ cleanLang(__('lang.client')) }}:</strong>
            {{ str_limit($appointment->client_company_name ??'---', 68) }}</span>
        @endif
        <!--date created-->
        @if(config('system.settings_appointments_kanban_date_created') == 'show')
        <span><strong>{{ cleanLang(__('lang.created')) }}:</strong> {{ runtimeDate($appointment->appointment_created) }}</span>
        @endif
        <!--start date-->
        @if(config('system.settings_appointments_kanban_date_start') == 'show')
        <span><strong>{{ cleanLang(__('lang.start_date')) }}:</strong>: {{ runtimeDate($appointment->appointment_date_start) }}</span>
        @endif
        <!--due date-->
        @if(config('system.settings_appointments_kanban_date_due') == 'show')
        <span><strong>{{ cleanLang(__('lang.due')) }}:</strong>: {{ runtimeDate($appointment->appointment_date_due) }}</span>
        @endif

        <!--show enabled custom fields-->
        @if(isset($appointment->fields))
        @foreach($appointment->fields as $field)
        @if($field->customfields_show_appointment_summary == 'yes')
        <span><strong>{{ $field->customfields_title }}:</strong>:
            {{ strip_tags(customFieldValue($field->customfields_name, $appointment, $field->customfields_datatype)) }}</span>
        @endif
        @endforeach
        @endif

        <!--reminder-->
        @if(config('system.settings_appointments_kanban_reminder') == 'show')
        <div class="wrap-words" id="reminder_card_view_container_{{ $appointment->appointment_id ?? '' }}">
            @foreach($appointment->reminders as $reminder)
            <!--only show current users reminders-->
            @if($reminder->reminder_userid == auth()->user()->id)
            @include('pages.reminders.cards.kanban')
            @endif
            @endforeach
        </div>
        @endif

    </div>
    <div class="x-footer row">
        <div class="col-6 x-icons">

            <!--various icons displayed next to title-->
            @include('pages.appointments.components.common.icons-1')

            <!--[icon] created by you-->
            @if($appointment->appointment_creatorid == auth()->user()->id)
            <span class="x-icon text-info display-inline-block vm p-t-2" data-toggle="tooltip"
                title="@lang('lang.you_created_this_appointment')" data-placement="top"><i
                    class="mdi mdi-account-circle"></i></span>
            @endif

            <!--[icon] archived-->
            @if(runtimeArchivingOptions())
            <span class="x-icon {{ runtimeActivateOrAchive('archived-icon', $appointment->appointment_active_state) }}"
                id="archived_icon_{{ $appointment->appointment_id }}" data-toggle="tooltip" title="@lang('lang.archived')"><i
                    class="ti-archive font-15"></i></span>
            @endif


            <!--[icon] client visibility-->
            @if(config('system.settings_appointments_kanban_client_visibility') == 'show' && auth()->user()->is_team)
            @if($appointment->appointment_client_visibility == 'no')
            <span class="x-icon display-inline-block vm " data-toggle="tooltip"
                title="{{ cleanLang(__('lang.client')) }} - {{ cleanLang(__('lang.hidden')) }}" data-placement="top"><i
                    class="mdi mdi-eye-outline-off"></i></span>
            @endif
            @endif

            <!--[icon] attachments-->
            @if($appointment->has_attachments)
            <span class="x-icon display-inline-block vm "><i class="mdi mdi-attachment"></i>
                @if($appointment->count_unread_attachments > 0)
                <span class="x-notification" id="card_notification_attachment_{{ $appointment->appointment_id }}"></span>
                @endif
            </span>
            @endif

            <!--[icon] comments-->
            @if($appointment->has_comments)
            <span class="x-icon display-inline-block vm p-t-3"><i class="mdi mdi-comment-text-outline"></i>
                @if($appointment->count_unread_comments > 0)
                <span class="x-notification" id="card_notification_comment_{{ $appointment->appointment_id }}"></span>
                @endif
            </span>
            @endif

            <!--timer running-->
            <span class="x-icon text-danger {{ runtimeCardMyRunningTimer($appointment->timer_current_status) }}"
                id="card-appointment-timer-{{ $appointment->appointment_id }}"><i class="mdi mdi-timer"></i></span>

        </div>
        <div class="col-6 x-assigned">
            @foreach($appointment->assigned as $user)
            <img src="{{ getUsersAvatar($user->avatar_directory, $user->avatar_filename) }}" data-toggle="tooltip"
                title="" data-placement="top" alt="{{ $user->first_name }}" class="img-circle avatar-xsmall"
                data-original-title="{{ $user->first_name }}">
            @endforeach
        </div>
    </div>
</div>
@endforeach