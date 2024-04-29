@foreach($appointments as $appointment)
<!--each row-->
<tr id="appointment_{{ $appointment->appointment_id }}" class="{{ runtimeAppointmentCompletedStatus($appointment->appointment_status) }}">
    <td class="appointments_col_title td-edge">
        <!--for polling timers-->
        <input type="hidden" name="appointments[{{ $appointment->appointment_id }}]" value="{{ $appointment->assigned_to_me }}">
        <!--checkbox-->
        <span class="appointment_border td-edge-border bg-{{ $appointment->appointmentstatus_color }}"></span>
        @if(config('visibility.appointments_checkbox'))
        <span class="list-checkboxes m-l-0">
            <input type="checkbox" id="toggle_appointment_status_{{ $appointment->appointment_id }}" name="toggle_appointment_status"
                class="toggle_appointment_status filled-in chk-col-light-blue js-ajax-ux-request-default"
                data-url="{{ urlResource('/appointments/'.$appointment->appointment_id.'/toggle-status') }}" data-ajax-type="post"
                data-type="form" data-form-id="appointment_{{ $appointment->appointment_id }}" data-notifications="disabled"
                data-container="appointment_{{ $appointment->appointment_id }}" data-progress-bar="hidden" data-appointment-status="{{ $appointment->appointment_status }}"
                {{ runtimePrechecked($appointment->appointment_status) }} {{ runtimeAppointmentDependencyLock($appointment->count_dependency_cannot_complete) }}>

            <label for="toggle_appointment_status_{{ $appointment->appointment_id }}">
                <a class="show-modal-button reset-card-modal-form js-ajax-ux-request" href="javascript:void(0)"
                    data-toggle="modal" data-target="#cardModal" data-url="{{ urlResource('/appointments/'.$appointment->appointment_id) }}"
                    data-loading-target="main-top-nav-bar"><span class="x-strike-through"
                        id="table_appointment_title_{{ $appointment->appointment_id }}">
                        {{ str_limit($appointment->appointment_title ?? '---', 40) }}</span>                 
                  <!--various icons displayed next to title-->
                  @include('pages.appointments.components.common.icons-1')
                </a>
            </label>
        </span>
        @endif
        @if(config('visibility.appointments_nocheckbox'))
        <a class="show-modal-button reset-card-modal-form js-ajax-ux-request p-l-5" href="javascript:void(0)"
            data-toggle="modal" data-target="#cardModal" data-url="{{ urlResource('/appointments/'.$appointment->appointment_id) }}"
            data-loading-target="main-top-nav-bar"><span class="x-strike-through"
                id="table_appointment_title_{{ $appointment->appointment_id }}">
                {{ str_limit($appointment->appointment_title ?? '---', 45) }}</span>
            <!--recurring-->
            @if(auth()->user()->is_team && $appointment->appointment_recurring == 'yes')
            <span class="sl-icon-refresh text-danger p-l-5" data-toggle="tooltip"
                title="@lang('lang.recurring_appointment')"></span>
            @endif</a>
        @endif
    </td>
    @if(config('visibility.appointments_col_project'))
    <td class="appointments_col_project">
        <span class="x-strike-through"><a title=""
                href="{{ url('/projects/'.$appointment->project_id) }}">{{ str_limit($appointment->project_title ?? '---', 18) }}</a></span>
    </td>
    @endif
    @if(config('visibility.appointments_col_milestone'))
    <td class="appointments_col_milestone">
        <span class="x-strike-through">{{ str_limit($appointment->milestone_title ?? '---', 12) }}</span>
    </td>
    @endif
    @if(config('visibility.appointments_col_date'))
    <td class="appointments_col_created">{{ runtimeDate($appointment->appointment_date_start) }}</td>
    @endif
    <td class="appointments_col_deadline">{{ runtimeDate($appointment->appointment_date_due) }}</td>

    @if(config('visibility.appointments_col_assigned'))
    <td class="appointments_col_assigned" id="appointments_col_assigned_{{ $appointment->appointment_id }}">
        <!--assigned users-->
        @if(count($appointment->assigned ?? []) > 0)
        @foreach($appointment->assigned->take(2) as $user)
        <img src="{{ $user->avatar }}" data-toggle="tooltip" title="{{ $user->first_name }}" data-placement="top"
            alt="{{ $user->first_name }}" class="img-circle avatar-xsmall">
        @endforeach
        @else
        <span>---</span>
        @endif
        <!--assigned users-->
        <!--more users-->
        @if(count($appointment->assigned ?? []) > 2)
        @php $more_users_title = __('lang.assigned_users'); $users = $appointment->assigned; @endphp
        @include('misc.more-users')
        @endif
        <!--more users-->
    </td>
    @endif
    @if(config('visibility.appointments_col_all_time'))
    <td class="appointments_col_all_time">
        <span class="x-timer-time"
            id="appointment_timer_all_table_{{ $appointment->appointment_id }}">{{ runtimeSecondsHumanReadable($appointment->sum_all_time, true) }}</span>
    </td>
    @endif
    @if(config('visibility.appointments_col_mytime'))
    <td class="appointments_col_my_time">
        @if($appointment->assigned_to_me)
        <span class="x-timer-time timers {{ runtimeTimerRunningStatus($appointment->timer_current_status) }}"
            id="appointment_timer_table_{{ $appointment->appointment_id }}">{!! clean(runtimeSecondsHumanReadable($appointment->my_time, false))
            !!}</span>
        @if($appointment->appointment_status != 'completed')
        <!--start a timer-->
        <span
            class="x-timer-button js-timer-button js-ajax-request timer-start-button hidden {{ runtimeTimerVisibility($appointment->timer_current_status, 'stopped') }}"
            id="timer_button_start_table_{{ $appointment->appointment_id }}" data-appointment-id="{{ $appointment->appointment_id }}" data-location="table"
            data-url="{{ url('/') }}/appointments/timer/{{ $appointment->appointment_id }}/start?source=list" data-form-id="appointments-list-table"
            data-type="form" data-progress-bar='hidden' data-ajax-type="POST">
            <span><i class="mdi mdi-play-circle"></i></span>
        </span>
        <!--stop a timer-->
        <span
            class="x-timer-button js-timer-button js-ajax-request timer-stop-button hidden {{ runtimeTimerVisibility($appointment->timer_current_status, 'running') }}"
            id="timer_button_stop_table_{{ $appointment->appointment_id }}" data-appointment-id="{{ $appointment->appointment_id }}" data-location="table"
            data-url="{{ url('/') }}/appointments/timer/{{ $appointment->appointment_id }}/stop?source=list" data-form-id="appointments-list-table"
            data-type="form" data-progress-bar='hidden' data-ajax-type="POST">
            <span><i class="mdi mdi-stop-circle"></i></span>
        </span>
        <!--timer updating-->
        <input type="hidden" name="timers[{{ $appointment->appointment_id }}]" value="">
        @endif
        @else
        <span>---</span>
        @endif
    </td>
    @endif
    @if(config('visibility.appointments_col_priority'))
    <td class="appointments_col_priority">
        <span
            class="label {{ runtimeAppointmentPriorityColors($appointment->appointment_priority, 'label') }}">{{ runtimeLang($appointment->appointment_priority) }}</span>
    </td>
    @endif
    @if(config('visibility.appointments_col_tags'))
    <td class="appointments_col_tags">
        <!--tag-->
        @if(count($appointment->tags ?? []) > 0)
        @foreach($appointment->tags->take(2) as $tag)
        <span class="label label-outline-default">{{ str_limit($tag->tag_title, 15) }}</span>
        @endforeach
        @else
        <span>---</span>
        @endif
        <!--/#tag-->

        <!--more tags (greater than tags->take(x) number above -->
        @if(count($appointment->tags ?? []) > 1)
        @php $tags = $appointment->tags; @endphp
        @include('misc.more-tags')
        @endif
        <!--more tags-->
    </td>
    @endif
    <td class="appointments_col_status">
        <span class="label label-{{ $appointment->appointmentstatus_color }}">{{ runtimeLang($appointment->appointmentstatus_title) }}</span>
        <!--archived-->
        @if($appointment->appointment_active_state == 'archived' && runtimeArchivingOptions())
        <span class="label label-icons label-icons-default" data-toggle="tooltip" data-placement="top"
            title="@lang('lang.archived')"><i class="ti-archive"></i></span>
        @endif
    </td>
    <td class="appointments_col_action actions_column">
        <!--action button-->
        <span class="list-table-action dropdown font-size-inherit">

            <!--[delete]-->
            @if($appointment->permission_delete_appointment)
            <button type="button" title="{{ cleanLang(__('lang.delete')) }}"
                class="data-toggle-action-tooltip btn btn-outline-danger btn-circle btn-sm confirm-action-danger"
                data-confirm-title="{{ cleanLang(__('lang.delete_item')) }}"
                data-confirm-text="{{ cleanLang(__('lang.are_you_sure')) }}" data-ajax-type="DELETE"
                data-url="{{ url('/') }}/appointments/{{ $appointment->appointment_id }}">
                <i class="sl-icon-trash"></i>
            </button>
            @else
            <!--optionally show disabled button?-->
            <span class="btn btn-outline-default btn-circle btn-sm disabled  {{ runtimePlaceholdeActionsButtons() }}"
                data-toggle="tooltip" title="{{ cleanLang(__('lang.actions_not_available')) }}"><i
                    class="sl-icon-trash"></i></span>
            @endif

            <!--view-->
            <button type="button" title="{{ cleanLang(__('lang.view')) }}"
                class="data-toggle-action-tooltip btn btn-outline-success btn-circle btn-sm show-modal-button reset-card-modal-form js-ajax-ux-request"
                data-toggle="modal" data-target="#cardModal" data-url="{{ urlResource('/appointments/'.$appointment->appointment_id) }}"
                data-loading-target="main-top-nav-bar">
                <i class="ti-new-window"></i>
            </button>
        </span>

        <!--more button (team)-->
        @if(auth()->user()->is_team && $appointment->permission_super_user)
        <span class="list-table-action dropdown  font-size-inherit">
            <button type="button" id="listTableAction" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"
                title="{{ cleanLang(__('lang.more')) }}"
                class="data-toggle-action-tooltip btn btn-outline-default-light btn-circle btn-sm">
                <i class="ti-more"></i>
            </button>
            <div class="dropdown-menu" aria-labelledby="listTableAction">

                <!--clone appointment (team only)-->
                @if(auth()->user()->is_team && $appointment->permission_edit_appointment)
                <a class="dropdown-item edit-add-modal-button js-ajax-ux-request reset-target-modal-form"
                    data-toggle="modal" data-target="#commonModal" data-modal-title="@lang('lang.clone_appointment')"
                    data-url="{{ urlResource('/appointments/'.$appointment->appointment_id.'/clone') }}"
                    data-action-url="{{ urlResource('/appointments/'.$appointment->appointment_id.'/clone') }}" data-modal-size="modal-sm"
                    data-loading-target="commonModalBody" data-action-method="POST" aria-expanded="false">
                    @lang('lang.clone_appointment')
                </a>
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
                @endif
                <!--stop all timers-->
                <a class="dropdown-item confirm-action-danger"
                    data-confirm-title="{{ cleanLang(__('lang.stop_all_timers')) }}"
                    data-confirm-text="{{ cleanLang(__('lang.are_you_sure')) }}" data-ajax-type="PUT"
                    data-url="{{ url('/') }}/appointments/timer/{{ $appointment->appointment_id }}/stopall?source=list">
                    {{ cleanLang(__('lang.stop_all_timers')) }}
                </a>

                @if(auth()->user()->is_team && $appointment->permission_edit_appointment)
                <!--recurring settings-->
                <a class="dropdown-item edit-add-modal-button js-ajax-ux-request reset-target-modal-form"
                    href="javascript:void(0)" data-toggle="modal" data-target="#commonModal"
                    data-url="{{ urlResource('/appointments/'.$appointment->appointment_id.'/recurring-settings?source=list') }}"
                    data-loading-target="commonModalBody"
                    data-modal-title="{{ cleanLang(__('lang.recurring_settings')) }}"
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
                @if($appointment->appointment_active_state == 'active' && runtimeArchivingOptions())
                <a class="dropdown-item confirm-action-info"
                    data-confirm-title="{{ cleanLang(__('lang.archive_appointment')) }}"
                    data-confirm-text="{{ cleanLang(__('lang.are_you_sure')) }}" data-ajax-type="PUT"
                    data-url="{{ urlResource('/appointments/'.$appointment->appointment_id.'/archive') }}">
                    {{ cleanLang(__('lang.archive')) }}
                </a>
                @endif
                <!--activate-->
                @if($appointment->appointment_active_state == 'archived' && runtimeArchivingOptions())
                <a class="dropdown-item confirm-action-info"
                    data-confirm-title="{{ cleanLang(__('lang.restore_appointment')) }}"
                    data-confirm-text="{{ cleanLang(__('lang.are_you_sure')) }}" data-ajax-type="PUT"
                    data-url="{{ urlResource('/appointments/'.$appointment->appointment_id.'/activate') }}">
                    {{ cleanLang(__('lang.restore')) }}
                </a>
                @endif

            </div>
        </span>
        @endif
        <!--more button-->
        <!--action button-->
    </td>
</tr>
@endforeach
<!--each row-->