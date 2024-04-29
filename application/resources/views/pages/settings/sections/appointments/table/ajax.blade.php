@foreach($statuses as $status)
<!--each row-->
<tr id="status_{{ $status->appointmentstatus_id }}">
    <td class="status_col_date">
        <span class="mdi mdi-drag-vertical cursor-pointer"></span>
        <!--sorting data-->
        <input type="hidden" name="sort-stages[{{ $status->appointmentstatus_id }}]" value="{{ $status->appointmentstatus_id }}">
        {{ runtimeLang($status->appointmentstatus_title) }}
        <!--system initial stage-->
        @if($status->appointmentstatus_system_default == 'yes' && $status->appointmentstatus_id == 1)
        <span class="sl-icon-star text-warning p-l-5" data-toggle="tooltip"
            title="{{ cleanLang(__('lang.required_appointments_stage')) }}"></span>
        <span class="label label-light-info label-rounded">{{ cleanLang(__('lang.initial_stage')) }}</span>

        @endif
        <!--system initial stage-->
        @if($status->appointmentstatus_system_default == 'yes' && $status->appointmentstatus_id == 2)
        <span class="sl-icon-star text-warning p-l-5" data-toggle="tooltip"
            title="{{ cleanLang(__('lang.required_appointments_stage')) }}"></span>
        <span class="label label-light-info label-rounded">{{ cleanLang(__('lang.final_stage')) }}</span>
        @endif
    </td>
    <td class="status_col_count">{{ $status->count_appointments }}</td>
    <td class="status_col_color"><span class="bg-{{ $status->appointmentstatus_color }}" id="fx-settimgs-appointments-status">&nbsp;</span>
    </td>
    <td class="status_col_created_by">
        <img src="{{ getUsersAvatar($status->avatar_directory, $status->avatar_filename, $status->appointmentstatus_creatorid) }}" alt="user"
            class="img-circle avatar-xsmall">
            {{ checkUsersName($status->first_name, $status->appointmentstatus_creatorid)  }}
        </td>
    <td class="status_col_action actions_column">
        <!--action button-->
        <span class="list-table-action dropdown font-size-inherit" >
            <button type="button" title="{{ cleanLang(__('lang.edit')) }}"
                class="data-toggle-tooltip data-toggle-tooltip btn btn-outline-success btn-circle btn-sm edit-add-modal-button js-ajax-ux-request reset-target-modal-form"
                data-toggle="modal" data-target="#commonModal" title="{{ cleanLang(__('lang.edit')) }}"
                data-url="{{ url('/settings/appointments/statuses/'.$status->appointmentstatus_id.'/edit') }}"
                data-loading-target="commonModalBody" data-modal-title="{{ cleanLang(__('lang.edit_appointment_status')) }}"
                data-action-url="{{ url('/settings/appointments/statuses/'.$status->appointmentstatus_id) }}" data-action-method="PUT"
                data-action-ajax-class="" data-action-ajax-loading-target="status-td-container">
                <i class="sl-icon-note"></i>
            </button>
            <button type="button" title="{{ cleanLang(__('lang.move')) }}"
                class="data-toggle-tooltip data-toggle-tooltip btn btn-outline-warning btn-circle btn-sm edit-add-modal-button js-ajax-ux-request reset-target-modal-form"
                data-toggle="modal" data-target="#commonModal" title="{{ cleanLang(__('lang.move')) }}"
                data-url="{{ url('/settings/appointments/move/'.$status->appointmentstatus_id) }}"
                data-loading-target="commonModalBody" data-modal-title="@lang('lang.move_appointments')"
                data-action-url="{{ url('/settings/appointments/move/'.$status->appointmentstatus_id) }}" data-action-method="PUT"
                data-action-ajax-class="js-ajax-ux-request" data-action-ajax-loading-target="commonModalBody">
                <i class="sl-icon-share-alt"></i>
            </button>
            @if($status->appointmentstatus_system_default == 'no')
            <button type="button" title="{{ cleanLang(__('lang.delete')) }}" class="data-toggle-action-tooltip btn btn-outline-danger btn-circle btn-sm confirm-action-danger"
                data-confirm-title="{{ cleanLang(__('lang.delete_appointment_status')) }}" data-confirm-text="{{ cleanLang(__('lang.are_you_sure')) }}"
                data-ajax-type="DELETE" data-url="{{ url('/') }}/settings/appointments/statuses/{{ $status->appointmentstatus_id }}">
                <i class="sl-icon-trash"></i>
            </button>
            @else
            <!--optionally show disabled button?-->
            <span class="btn btn-outline-default btn-circle btn-sm disabled {{ runtimePlaceholdeActionsButtons() }}"
                data-toggle="tooltip" title="{{ cleanLang(__('lang.actions_not_available')) }}"><i class="sl-icon-trash"></i></span>
            @endif
        </span>
        <!--action button-->
    </td>
</tr>
@endforeach
<!--each row-->