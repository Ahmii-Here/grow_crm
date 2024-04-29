    <!--[dependency][lock-1] start-->
    @if(config('visibility.appointment_is_open'))
    <!----------Assigned----------->
    @if(config('visibility.appointments_card_assigned'))
    <div class="x-section">
        <div class="x-title">
            <h6>{{ cleanLang(__('lang.assigned_users')) }}</h6>
        </div>
        <span id="appointment-assigned-container" class="">
            @include('pages.appointment.components.assigned')
        </span>
        <!--user-->
        @if($appointment->permission_assign_users)
        <span class="x-assigned-user x-assign-new js-card-settings-button-static card-appointment-assigned text-info"
            data-container=".card-modal" tabindex="0" data-popover-content="card-appointment-team"
            data-title="{{ cleanLang(__('lang.assign_users')) }}"><i class="mdi mdi-plus"></i></span>
        @endif
    </div>
    @else
    <!--spacer-->
    <div class="p-b-40"></div>
    @endif


    <!--show timer-->
    <div id="appointment-timer-container">
        @include('pages.appointment.components.timer')
    </div>


    <!----------settings----------->
    <div class="x-section">
        <div class="x-title">
            <h6>{{ cleanLang(__('lang.settings')) }}</h6>
        </div>
        <!--start date-->
        @if(config('visibility.appointments_standard_features'))
        <div class="x-element" id="appointment-start-date"><i class="mdi mdi-calendar-plus"></i>
            <span>{{ cleanLang(__('lang.start_date')) }}:</span>
            @if($appointment->permission_edit_appointment)
            <span class="x-highlight x-editable card-pickadate"
                data-url="{{ urlResource('/appointments/'.$appointment->appointment_id.'/update-start-date/') }}" data-type="form"
                data-progress-bar='hidden' data-form-id="appointment-start-date" data-hidden-field="appointment_date_start"
                data-container="appointment-start-date-container" data-ajax-type="post"
                id="appointment-start-date-container">{{ runtimeDate($appointment->appointment_date_start) }}</span></span>
            <input type="hidden" name="appointment_date_start" id="appointment_date_start">
            @else
            <span class="x-highlight">{{ runtimeDate($appointment->appointment_date_start) }}</span>
            @endif
        </div>
        @endif
        <!--due date-->
        @if(config('visibility.appointments_standard_features'))
        <div class="x-element" id="appointment-due-date"><i class="mdi mdi-calendar-clock"></i>
            <span>{{ cleanLang(__('lang.due_date')) }}:</span>
            @if($appointment->permission_edit_appointment)
            <span class="x-highlight x-editable card-pickadate"
                data-url="{{ urlResource('/appointments/'.$appointment->appointment_id.'/update-due-date/') }}" data-type="form"
                data-progress-bar='hidden' data-form-id="appointment-due-date" data-hidden-field="appointment_date_due"
                data-container="appointment-due-date-container" data-ajax-type="post"
                id="appointment-due-date-container">{{ runtimeDate($appointment->appointment_date_due) }}</span></span>
            <input type="hidden" name="appointment_date_due" id="appointment_date_due">
            @else
            <span class="x-highlight">{{ runtimeDate($appointment->appointment_date_due) }}</span>
            @endif
        </div>
        @endif
        <!--status-->
        <div class="x-element" id="card-appointment-status"><i class="mdi mdi-flag"></i>
            <span>{{ cleanLang(__('lang.status')) }}: </span>
            @if($appointment->permission_edit_appointment)
            <span class="x-highlight x-editable js-card-settings-button-static" data-container=".card-modal"
                id="card-appointment-status-text" tabindex="0" data-popover-content="card-appointment-statuses" data-offset="0 25%"
                data-status-id="{{ $appointment->appointmentstatus_id }}"
                data-title="{{ cleanLang(__('lang.status')) }}">{{ runtimeLang($appointment->appointmentstatus_title) }}</strong></span>
            @else
            <span class="x-highlight">{{ runtimeLang($appointment->appointmentstatus_title) }}</span>
            @endif
        </div>

        <!--priority-->
        <div class="x-element" id="card-appointment-priority"><i class="mdi mdi-flag"></i>
            <span>{{ cleanLang(__('lang.priority')) }}: </span>
            @if($appointment->permission_edit_appointment)
            <span class="x-highlight x-editable js-card-settings-button-static" data-container=".card-modal"
                id="card-appointment-priority-text" tabindex="0" data-popover-content="card-appointment-priorities"
                data-offset="0 25%" data-status-id="{{ $appointment->appointmentpriority_id }}"
                data-title="{{ cleanLang(__('lang.priority')) }}">{{ runtimeLang($appointment->appointmentpriority_title) }}</strong></span>
            @else
            <span class="x-highlight">{{ runtimeLang($appointment->appointmentpriority_title) }}</span>
            @endif
        </div>

        <!--client visibility-->
        @if(auth()->user()->type =='team')
        <div class="x-element" id="card-appointment-client-visibility"><i class="mdi mdi-eye"></i>
            <span>{{ cleanLang(__('lang.client')) }}:</span>
            @if($appointment->permission_edit_appointment)
            <span class="x-highlight x-editable js-card-settings-button-static" data-container=".card-modal"
                id="card-appointment-client-visibility-text" tabindex="0" data-popover-content="card-appointment-visibility"
                data-title="{{ cleanLang(__('lang.client_visibility')) }}">{{ runtimeDBlang($appointment->appointment_client_visibility, 'appointment_client_visibility') }}</strong></span>
            <input type="hidden" name="appointment_client_visibility" id="appointment_client_visibility">
            @else
            <span
                class="x-highlight">{{ runtimeDBlang($appointment->appointment_client_visibility, 'appointment_client_visibility') }}</span>
            @endif

        </div>
        @endif

        <!--reminder-->
        @if(config('visibility.modules.reminders') && $appointment->project_type == 'project')
        <div class="card-reminders-container" id="card-reminders-container">
            @include('pages.reminders.cards.wrapper')
        </div>
        @endif


    </div>

    <!----------tags----------->
    <div class="card-tags-container" id="card-tags-container">
        @include('pages.appointment.components.tags')
    </div>
    @endif
    <!--[dependency][lock-1] end-->

    <!--[dependency][lock-2] start-->
    @if(config('visibility.appointment_is_locked'))
    <!--spacer-->
    <div class="p-t-15"></div>
    @endif
    <!--[dependency][lock-2] end-->


    <!--dependencies-->
    <div class="x-section">
        <div class="x-title">
            <h6>{{ cleanLang(__('lang.dependencies')) }}</h6>
        </div>
        @include('pages.appointment.dependency.wrapper')
    </div>


    <!--[dependency][lock-3] start-->
    @if(config('visibility.appointment_is_open'))

    <!----------actions----------->
    <div class="x-section">
        <div class="x-title">
            <h6>{{ cleanLang(__('lang.actions')) }}</h6>
        </div>

        <!--track if we have any actions-->
        @php $count_action = 0 ; @endphp

        <!--change milestone-->
        @if($appointment->permission_edit_appointment && auth()->user()->type =='team')
        <div class="x-element x-action js-card-settings-button-static" data-container=".card-modal"
            id="card-appointment-milestone" tabindex="0" data-popover-content="card-appointment-milestones"
            data-title="{{ cleanLang(__('lang.milestone')) }}"><i class="mdi mdi-redo-variant"></i>
            <span class="x-highlight">{{ cleanLang(__('lang.change_milestone')) }}</strong></span>
        </div>
        @php $count_action ++ ; @endphp
        @endif

        <!--stop all timer-->
        @if($appointment->permission_super_user && config('visibility.appointments_standard_features'))
        <div class="x-element x-action confirm-action-danger"
            data-confirm-title="{{ cleanLang(__('lang.stop_all_timers')) }}"
            data-confirm-text="{{ cleanLang(__('lang.are_you_sure')) }}"
            data-url="{{ url('/') }}/appointments/timer/{{ $appointment->appointment_id }}/stopall?source=card"><i
                class="mdi mdi-timer-off"></i>
            <span class="x-highlight" id="appointment-start-date">{{ cleanLang(__('lang.stop_all_timers')) }}</span></span>
        </div>
        @php $count_action ++ ; @endphp
        @endif


        <!--archive-->
        @if($appointment->permission_edit_appointment && config('visibility.appointments_standard_features'))
        <div class="x-element x-action confirm-action-info  {{ runtimeActivateOrAchive('archive-button', $appointment->appointment_active_state) }} card_archive_button_{{ $appointment->appointment_id }}"
            id="card_archive_button_{{ $appointment->appointment_id }}" data-confirm-title="{{ cleanLang(__('lang.archive_appointment')) }}"
            data-confirm-text="{{ cleanLang(__('lang.are_you_sure')) }}" data-ajax-type="PUT"
            data-url="{{ url('/') }}/appointments/{{ $appointment->appointment_id }}/archive"><i class="mdi mdi-archive"></i> <span
                class="x-highlight" id="appointment-start-date">{{ cleanLang(__('lang.archive')) }}</span></span></div>
        @php $count_action ++ ; @endphp
        @endif

        <!--restore-->
        @if($appointment->permission_edit_appointment && runtimeArchivingOptions())
        <div class="x-element x-action confirm-action-info  {{ runtimeActivateOrAchive('activate-button', $appointment->appointment_active_state) }} card_restore_button_{{ $appointment->appointment_id }}"
            id="card_restore_button_{{ $appointment->appointment_id }}" data-confirm-title="{{ cleanLang(__('lang.restore_appointment')) }}"
            data-confirm-text="{{ cleanLang(__('lang.are_you_sure')) }}" data-ajax-type="PUT"
            data-url="{{ url('/') }}/appointments/{{ $appointment->appointment_id }}/activate"><i class="mdi mdi-archive"></i> <span
                class="x-highlight" id="appointment-start-date">{{ cleanLang(__('lang.restore')) }}</span></span></div>
        @php $count_action ++ ; @endphp
        @endif

        <!--delete-->
        @if($appointment->permission_delete_appointment && runtimeArchivingOptions())
        <div class="x-element x-action confirm-action-danger"
            data-confirm-title="{{ cleanLang(__('lang.delete_item')) }}"
            data-confirm-text="{{ cleanLang(__('lang.are_you_sure')) }}" data-ajax-type="DELETE"
            data-url="{{ urlResource('/') }}/appointments/{{ $appointment->appointment_id }}"><i class="mdi mdi-delete"></i> <span
                class="x-highlight" id="appointment-start-date">{{ cleanLang(__('lang.delete')) }}</span></span></div>
        @php $count_action ++ ; @endphp
        @endif


        <!--no action available-->
        @if($count_action == 0)
        <div class="x-element">
            {{ cleanLang(__('lang.no_actions_available')) }}
        </div>
        @endif

    </div>

    <!----------meta infor----------->
    <div class="x-section">
        <div class="x-title">
            <h6>{{ cleanLang(__('lang.information')) }}</h6>
        </div>
        <div class="x-element x-action">
            <table class="table table-bordered table-sm">
                <tbody>
                    <tr>
                        <td>{{ cleanLang(__('lang.appointment_id')) }}</td>
                        <td><strong>#{{ $appointment->appointment_id }}</strong></td>
                    </tr>
                    <tr>
                        <td>{{ cleanLang(__('lang.created_by')) }}</td>
                        <td><strong>{{ $appointment->first_name }} {{ $appointment->last_name }}</strong></td>
                    </tr>
                    <tr>
                        <td>{{ cleanLang(__('lang.date_created')) }}</td>
                        <td><strong>{{ runtimeDate($appointment->appointment_created) }}</strong></td>
                    </tr>
                    @if(auth()->user()->is_team)
                    <tr>
                        <td>{{ cleanLang(__('lang.total_time')) }}</td>
                        <td><strong><span id="appointment_timer_all_card_{{ $appointment->appointment_id }}">{!!
                                    clean(runtimeSecondsHumanReadable($appointment->sum_all_time, false))
                                    !!}</span></strong>
                        </td>
                    </tr>
                    <tr>
                        <td>{{ cleanLang(__('lang.time_invoiced')) }}</td>
                        <td><strong><span id="appointment_timer_all_card_{{ $appointment->appointment_id }}">{!!
                                    clean(runtimeSecondsHumanReadable($appointment->sum_invoiced_time, false))
                                    !!}</span></strong>
                        </td>
                    </tr>
                    <tr>
                        <td>{{ cleanLang(__('lang.project')) }}</td>
                        <td><strong><a href="{{ urlResource('/projects/'.$appointment->appointment_projectid) }}"
                                    target="_blank">#{{ $appointment->project_id }}</a></strong>
                        </td>
                    </tr>
                    @endif
                </tbody>
            </table>
        </div>
    </div>
    @else

    <!--just a spacer for dependencied-->
    <div class="p-b-100 p-t-100"></div>

    @endif
    <!--[dependency][lock-3] end-->




    <!-----------------------------popover dropdown elements------------------------------------>

    <!--appointment statuses - popover -->
    @if($appointment->permission_participate)
    <div class="hidden" id="card-appointment-statuses">
        <ul class="list">
            @foreach(config('appointment_statuses') as $appointment_status)
            <li class="card-appointments-update-status-link" data-button-text="card-appointment-status-text"
                data-progress-bar='hidden' data-url="{{ urlResource('/appointments/'.$appointment->appointment_id.'/update-status') }}"
                data-type="form" data-value="{{ $appointment_status->appointmentstatus_id }}" data-form-id="--set-dynamically--"
                data-ajax-type="post">
                {{ runtimeLang($appointment_status->appointmentstatus_title) }}</li>
            @endforeach
        </ul>
        <input type="hidden" name="appointment_status" id="appointment_status">
        <input type="hidden" name="current_appointment_status_text" id="current_appointment_status_text">
    </div>
    @endif


    <!--appointment priorities - popover -->
    @if($appointment->permission_participate)
    <div class="hidden" id="card-appointment-priorities">
        <ul class="list">
            @foreach(config('appointment_priorities') as $priority)
            <li class="card-appointments-update-priority-link" data-button-text="card-appointment-priority-text"
                data-progress-bar='hidden' data-url="{{ urlResource('/appointments/'.$appointment->appointment_id.'/update-priority') }}"
                data-type="form" data-value="{{ $priority->appointmentpriority_id }}" data-form-id="--set-dynamically--"
                data-ajax-type="post">
                {{ runtimeLang($priority->appointmentpriority_title) }}</li>
            @endforeach
        </ul>
        <input type="hidden" name="appointment_priority" id="appointment_priority">
        <input type="hidden" name="current_appointment_priority_text" id="current_appointment_priority_text">
    </div>
    @endif


    <!--appointment priority - popover-->
    @if($appointment->permission_participate)
    <div class="hidden" id="card-appointment-priorities">
        <ul class="list">
            @foreach(config('settings.appointment_priority') as $key => $value)
            <li class="card-appointments-update-priority-link" data-button-text="card-appointment-priority-text"
                data-progress-bar='hidden' data-url="{{ urlResource('/appointments/'.$appointment->appointment_id.'/update-priority') }}"
                data-type="form" data-value="{{ $key }}" data-form-id="--set-dynamically--" data-ajax-type="post">
                {{ runtimeLang($key) }}</li>
            @endforeach
        </ul>
        <input type="hidden" name="appointment_priority" id="appointment_priority">
        <input type="hidden" name="current_appointment_priority_text" id="current_appointment_priority_text">
    </div>
    @endif

    <!--client visibility - popover-->
    @if($appointment->permission_edit_appointment)
    <div class="hidden" id="card-appointment-visibility">
        <ul class="list">
            <li class="card-appointments-update-visibility-link" data-button-text="card-appointment-client-visibility-text"
                data-progress-bar='hidden' data-url="{{ urlResource('/appointments/'.$appointment->appointment_id.'/update-visibility') }}"
                data-type="form" data-value="no" data-text="{{ cleanLang(__('lang.hidden')) }}"
                data-form-id="card-appointment-client-visibility" data-ajax-type="post">
                {{ cleanLang(__('lang.hidden')) }}
            </li>
            <li class="card-appointments-update-visibility-link" data-button-text="card-appointment-client-visibility-text"
                data-progress-bar='hidden' data-url="{{ urlResource('/appointments/'.$appointment->appointment_id.'/update-visibility') }}"
                data-type="form" data-value="yes" data-text="{{ cleanLang(__('lang.visible')) }}"
                data-form-id="card-appointment-client-visibility" data-ajax-type="post">
                {{ cleanLang(__('lang.visible')) }}
            </li>
        </ul>
        <input type="hidden" name="appointment_client_visibility" id="appointment_client_visibility">
        <input type="hidden" name="current_appointment_client_visibility_text" id="current_appointment_client_visibility_text">
    </div>
    @endif

    <!--milestone - popover -->
    @if($appointment->permission_edit_appointment)
    <div class="hidden" id="card-appointment-milestones">
        <div class="form-group m-t-10">
            <select class="custom-select col-12 form-control form-control-sm" id="appointment_milestoneid"
                name="appointment_milestoneid">
                @if(isset($milestones))
                @foreach($milestones as $milestone)
                <option value="{{ $milestone->milestone_id }}">
                    {{ runtimeLang($milestone->milestone_title, 'appointment_milestone') }}</option>
                @endforeach
                @endif
            </select>
        </div>
        <div class="form-group text-right">
            <button type="button" class="btn btn-danger btn-sm" id="card-appointments-update-milestone-button"
                data-progress-bar='hidden' data-url="{{ urlResource('/appointments/'.$appointment->appointment_id.'/update-milestone') }}"
                data-type="form" data-ajax-type="post" data-form-id="popover-body">
                {{ cleanLang(__('lang.update')) }}
            </button>
        </div>
    </div>
    @endif


    <!--assign user-->
    <div class="hidden" id="card-appointment-team">
        <div class="card-assigned-popover-content">
            <div class="alert alert-info">Only users assigned to the project are shown in this list</div>
            <div class="line"></div>

            <!--staff users-->
            <h5>@lang('lang.team_members')</h5>
            @foreach($project_assigned as $staff)
            <div class="form-check m-b-15">
                <label class="custom-control custom-checkbox">
                    <input type="checkbox" name="assigned[{{ $staff->id }}]"
                        class="custom-control-input assigned_user_{{ $staff->id }}">
                    <span class="custom-control-indicator"></span>
                    <span class="custom-control-description"><img
                            src="{{ getUsersAvatar($staff->avatar_directory, $staff->avatar_filename) }}"
                            class="img-circle avatar-xsmall"> {{ $staff->first_name }}
                        {{ $staff->last_name }}</span>
                </label>
            </div>
            @endforeach

            <div class="line"></div>

            <!--client users-->
            <h5>@lang('lang.client_users')</h5>
            @foreach($client_users as $staff)
            <div class="form-check m-b-15">
                <label class="custom-control custom-checkbox">
                    <input type="checkbox" name="assigned[{{ $staff->id }}]"
                        class="custom-control-input assigned_user_{{ $staff->id }}">
                    <span class="custom-control-indicator"></span>
                    <span class="custom-control-description"><img
                            src="{{ getUsersAvatar($staff->avatar_directory, $staff->avatar_filename) }}"
                            class="img-circle avatar-xsmall"> {{ $staff->first_name }}
                        {{ $staff->last_name }}</span>
                </label>
            </div>
            @endforeach

            <div class="form-group text-right">
                <button type="button" class="btn btn-danger btn-sm" id="card-appointments-update-assigned"
                    data-progress-bar='hidden' data-url="{{ urlResource('/appointments/'.$appointment->appointment_id.'/update-assigned') }}"
                    data-type="form" data-ajax-type="post" data-form-id="popover-body">
                    {{ cleanLang(__('lang.update')) }}
                </button>
            </div>
        </div>
    </div>