@if(auth()->user()->is_team && $appointment->assigned_to_me && $appointment->permission_edit_appointment)
<div class="x-section x-timer m-t-10" id="appointment-users-appointment-timer">
    <div class="x-title  text-left p-b-5">
        <h6 class=" m-b-0">{{ cleanLang(__('lang.my_timer')) }}
            <!--info tooltip-->
            <span class="info-tooltip">
                <span class="align-middle text-info font-16" data-toggle="tooltip"
                    title="@lang('lang.this_is_total_logged_time_appointment')" data-placement="top">
                    <i class="ti-info-alt font-14"></i></span>
            </span></h6>
    </div>
    <span class="x-timer-time timers {{ runtimeTimerRunningStatus($appointment->timer_current_status) }}"
        id="appointment_timer_card_{{ $appointment->appointment_id }}">{!! clean(runtimeSecondsHumanReadable($appointment->my_time, false))
        !!}</span>
    @if($appointment->appointment_status != 'completed')
    <!--start a timer-->
    <span
        class="x-timer-button js-timer-button js-ajax-request timer-start-button hidden {{ runtimeTimerVisibility($appointment->timer_current_status, 'stopped') }}"
        id="timer_button_start_card_{{ $appointment->appointment_id }}" data-appointment-id="{{ $appointment->appointment_id }}" data-location="table"
        data-url="{{ url('/') }}/appointments/timer/{{ $appointment->appointment_id }}/start?source=card" data-form-id="appointments-list-table"
        data-type="form" data-progress-bar='hidden' data-ajax-type="POST">
        <span><i class="mdi mdi-play-circle"></i></span>
    </span>
    <!--stop a timer-->
    <span
        class="x-timer-button js-timer-button js-ajax-request timer-stop-button hidden {{ runtimeTimerVisibility($appointment->timer_current_status, 'running') }}"
        id="timer_button_stop_card_{{ $appointment->appointment_id }}" data-appointment-id="{{ $appointment->appointment_id }}" data-location="table"
        data-url="{{ url('/') }}/appointments/timer/{{ $appointment->appointment_id }}/stop?source=card" data-form-id="appointments-list-table"
        data-type="form" data-progress-bar='hidden' data-ajax-type="POST">
        <span><i class="mdi mdi-stop-circle"></i></span>
    </span>
    <!--timer updating-->
    <input type="hidden" name="timers[{{ $appointment->appointment_id }}]" value="">
    @endif

    <!--polling trigger-->
    <span class="hidden" id="timerTaskPollingTrigger" data-type="form" data-progress-bar='hidden'
        data-notifications="disabled" data-skip-checkboxes-reset="TRUE" data-form-id="appointment-users-appointment-timer"
        data-ajax-type="post" data-url="{{ url('/polling/timers?ref=appointment') }}"></span>
</div>
@endif