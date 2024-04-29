<!--CRUMBS CONTAINER (RIGHT)-->
<div class="col-md-12  col-lg-7 p-b-9 align-self-center text-right {{ $page['list_page_actions_size'] ?? '' }} {{ $page['list_page_container_class'] ?? '' }}"
    id="list-page-actions-container">
    <div id="list-page-actions">
        <!--SEARCH BOX-->
        @if( config('visibility.list_page_actions_search'))
        <div class="header-search" id="header-search">
            <i class="sl-icon-magnifier"></i>
            <input type="text" class="form-control search-records list-actions-search"
                data-url="{{ $page['dynamic_search_url'] ?? '' }}" data-type="form" data-ajax-type="post"
                data-form-id="header-search" id="search_query" name="search_query"
                placeholder="{{ cleanLang(__('lang.search')) }}">
        </div>
        @endif

        <!--ARCHIVED appointmentS-->
        @if(config('visibility.archived_appointments_toggle_button'))
        <button type="button" data-toggle="tooltip" title="{{ cleanLang(__('lang.show_archive_appointments')) }}"
            id="pref_filter_show_archived_appointments"
            class="list-actions-button btn btn-page-actions waves-effect waves-dark js-ajax-ux-request {{ runtimeActive(auth()->user()->pref_filter_show_archived_appointments) }}"
            data-url="{{ urlResource('/appointments/search?action=search&toggle=pref_filter_show_archived_appointments') }}">
            <i class="ti-archive"></i>
        </button>
        @endif

        <!--SHOW OWN appointmentS-->
        @if(config('visibility.own_appointments_toggle_button'))
        <button type="button" data-toggle="tooltip" title="{{ cleanLang(__('lang.my_appointments')) }}"
            id="pref_filter_own_appointments"
            class="list-actions-button btn btn-page-actions waves-effect waves-dark js-ajax-ux-request {{ runtimeActive(auth()->user()->pref_filter_own_appointments) }}"
            data-url="{{ urlResource('/appointments/search?action=search&toggle=pref_filter_own_appointments') }}">
            <i class="sl-icon-user"></i>
        </button>
        @endif


        <!--HIDE COMPLETED appointmentS-->
        <button type="button" data-toggle="tooltip" title="{{ cleanLang(__('lang.hide_completed_appointments')) }}"
            id="pref_hide_completed_appointments"
            class="list-actions-button btn btn-page-actions waves-effect waves-dark js-ajax-ux-request {{ runtimeActive(auth()->user()->pref_hide_completed_appointments) }}"
            data-url="{{ urlResource('/appointments/search?action=search&toggle=pref_hide_completed_appointments') }}">
            <i class="ti-check-box"></i>
        </button>

        <!--TOGGLE STATS-->
        @if(config('visibility.stats_toggle_button'))
        <button type="button" data-toggle="tooltip" title="{{ cleanLang(__('lang.quick_stats')) }}"
            class="list-actions-button btn btn-page-actions waves-effect waves-dark js-toggle-stats-widget update-user-ux-preferences"
            data-type="statspanel" data-progress-bar="hidden"
            data-url-temp="{{ urlResource('/') }}/{{ auth()->user()->team_or_contact }}/updatepreferences" data-url=""
            data-target="list-pages-stats-widget">
            <i class="ti-stats-up"></i>
        </button>
        @endif


        <!--appointmentS - KANBAN VIEW & SORTING-->
        <button type="button" data-toggle="tooltip" title="{{ cleanLang(__('lang.kanban_view')) }}"
            class="list-actions-button btn btn-page-actions waves-effect waves-dark js-ajax-ux-request"
            data-url="{{ urlResource('/appointments/search?action=search&toggle=layout') }}">
            <i class="sl-icon-list"></i>
        </button>
        <!--kanban appointment sorting-->
        <div class="btn-group">
            <button type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"
                class="list-actions-button btn waves-effect waves-dark dropdown-toggle">
                <i class="mdi mdi-sort"></i></button>
            <div class="dropdown-menu dropdown-menu-right fx-kaban-sorting-dropdown">
                <div class="fx-kaban-sorting-dropdown-container">{{ cleanLang(__('lang.sort_by')) }}</div>
                <a class="dropdown-item js-ajax-ux-request" id="sort_kanban_appointment_created" href="javascript:void(0)"
                    data-url="{{ urlResource('/appointments?action=sort&orderby=appointment_created&sortorder=asc') }}">{{ cleanLang(__('lang.date_created')) }}</a>
                <a class="dropdown-item js-ajax-ux-request" id="sort_kanban_appointment_date_start" href="javascript:void(0)"
                    data-url="{{ urlResource('/appointments?action=sort&orderby=appointment_date_start&sortorder=asc') }}">{{ cleanLang(__('lang.start_date')) }}</a>
                <a class="dropdown-item js-ajax-ux-request" id="sort_kanban_appointment_date_due" href="javascript:void(0)"
                    data-url="{{ urlResource('/appointments?action=sort&orderby=appointment_date_due&sortorder=asc') }}">{{ cleanLang(__('lang.due_date')) }}</a>
                <a class="dropdown-item js-ajax-ux-request" id="sort_kanban_appointment_title" href="javascript:void(0)"
                    data-url="{{ urlResource('/appointments?action=sort&orderby=appointment_title&sortorder=asc') }}">{{ cleanLang(__('lang.title')) }}</a>
            </div>
        </div>


        <!--FILTERING-->
        @if(config('visibility.list_page_actions_filter_button'))
        <button type="button" data-toggle="tooltip" title="{{ cleanLang(__('lang.filter')) }}"
            class="list-actions-button btn btn-page-actions waves-effect waves-dark js-toggle-side-panel"
            data-target="{{ $page['sidepanel_id'] ?? '' }}">
            <i class="mdi mdi-filter-outline"></i>
        </button>
        @endif


        <!--ADD NEW ITEM-->
        @if(config('visibility.list_page_actions_add_button'))
        <button type="button"
            class="btn btn-danger btn-add-circle edit-add-modal-button js-ajax-ux-request reset-target-modal-form {{ $page['add_button_classes'] ?? '' }}"
            data-toggle="modal" data-target="#commonModal" data-url="{{ $page['add_modal_create_url'] ?? '' }}"
            data-loading-target="commonModalBody" data-modal-title="{{ $page['add_modal_title'] ?? '' }}"
            data-action-url="{{ $page['add_modal_action_url'] ?? '' }}"
            data-action-method="{{ $page['add_modal_action_method'] ?? '' }}"
            data-action-ajax-class="{{ $page['add_modal_action_ajax_class'] ?? '' }}"
            data-modal-size="{{ $page['add_modal_size'] ?? '' }}"
            data-action-ajax-loading-target="{{ $page['add_modal_action_ajax_loading_target'] ?? '' }}"
            data-save-button-class="{{ $page['add_modal_save_button_class'] ?? '' }}" data-project-progress="0">
            <i class="ti-plus"></i>
        </button>
        @endif

        <!--add new button (link)-->
        @if( config('visibility.list_page_actions_add_button_link'))
        <a id="fx-page-actions-add-button" type="button" class="btn btn-danger btn-add-circle edit-add-modal-button"
            href="{{ $page['add_button_link_url'] ?? '' }}">
            <i class="ti-plus"></i>
        </a>
        @endif
    </div>
</div>