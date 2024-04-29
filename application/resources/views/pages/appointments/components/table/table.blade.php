<div class="card count-{{ @count($appointments ?? []) }}" id="appointments-view-wrapper">
    <div class="card-body">
        <div class="table-responsive list-table-wrapper">
            @if (@count($appointments ?? []) > 0)
            <table id="appointments-list-table" class="table m-t-0 m-b-0 table-hover no-wrap contact-list" data-page-size="10"
                data-url="{{ url('/') }}/appointments/timer-poll/" data-type="form" data-ajax-type="post"
                data-form-id="appointments-list-table">
                <thead>
                    <tr>
                        <th class="appointments_col_title">
                            <a class="js-ajax-ux-request js-list-sorting" id="sort_appointment_title" href="javascript:void(0)"
                                data-url="{{ urlResource('/appointments?action=sort&orderby=appointment_title&sortorder=asc') }}">{{ cleanLang(__('lang.title')) }}<span
                                    class="sorting-icons"><i class="ti-arrows-vertical"></i></span></a>
                        </th>
                        @if(config('visibility.appointments_col_project'))
                        <th class="appointments_col_title">
                            <a class="js-ajax-ux-request js-list-sorting" id="sort_appointment_project" href="javascript:void(0)"
                                data-url="{{ urlResource('/appointments?action=sort&orderby=appointment_project&sortorder=asc') }}">{{ cleanLang(__('lang.project')) }}<span
                                    class="sorting-icons"><i class="ti-arrows-vertical"></i></span></a>
                        </th>
                        @endif
                        @if(config('visibility.appointments_col_milestone'))
                        <th class="appointments_col_milestone">
                            <a class="js-ajax-ux-request js-list-sorting" id="sort_milestone" href="javascript:void(0)"
                                data-url="{{ urlResource('/appointments?action=sort&orderby=milestone&sortorder=asc') }}">{{ cleanLang(__('lang.milestone')) }}<span
                                    class="sorting-icons"><i class="ti-arrows-vertical"></i></span></a>
                        </th>
                        @endif
                        @if(config('visibility.appointments_col_date'))
                        <th class="appointments_col_added">
                            <a class="js-ajax-ux-request js-list-sorting" id="sort_appointment_date" href="javascript:void(0)"
                                data-url="{{ urlResource('/appointments?action=sort&orderby=appointment_date&sortorder=asc') }}">{{ cleanLang(__('lang.created')) }}<span
                                    class="sorting-icons"><i class="ti-arrows-vertical"></i></span></a>
                        </th>
                        @endif
                        <th class="appointments_col_deadline">
                            <a class="js-ajax-ux-request js-list-sorting" id="sort_appointment_date_due"
                                href="javascript:void(0)"
                                data-url="{{ urlResource('/appointments?action=sort&orderby=appointment_date_due&sortorder=asc') }}">{{ cleanLang(__('lang.deadline')) }}<span
                                    class="sorting-icons"><i class="ti-arrows-vertical"></i></span></a>
                        </th>
                        @if(config('visibility.appointments_col_assigned'))
                        <th class="appointments_col_assigned"><a href="javascript:void(0)">{{ cleanLang(__('lang.assigned')) }}</a></th>
                        @endif
                        @if(config('visibility.appointments_col_all_time'))
                        <th class="appointments_col_all_time"><a class="js-ajax-ux-request js-list-sorting" id="sort_mytime"
                                href="javascript:void(0)"
                                data-url="{{ urlResource('/appointments?action=sort&orderby=mytime&sortorder=asc') }}">{{ cleanLang(__('lang.all_time')) }}<span
                                    class="sorting-icons"><i class="ti-arrows-vertical"></i></span></a></th>
                        @endif
                        @if(config('visibility.appointments_col_mytime'))
                        <th class="appointments_col_my_time"><a class="js-ajax-ux-request js-list-sorting" id="sort_mytime"
                                href="javascript:void(0)"
                                data-url="{{ urlResource('/appointments?action=sort&orderby=mytime&sortorder=asc') }}">{{ cleanLang(__('lang.my_time')) }}<span class="sorting-icons"><i class="ti-arrows-vertical"></i></span></a></th>
                        @endif
                        @if(config('visibility.appointments_col_priority'))
                        <th class="appointments_col_priority">
                            <a class="js-ajax-ux-request js-list-sorting" id="sort_appointment_priority"
                                href="javascript:void(0)"
                                data-url="{{ urlResource('/appointments?action=sort&orderby=appointment_priority&sortorder=asc') }}">{{ cleanLang(__('lang.priority')) }}#<span
                                    class="sorting-icons"><i class="ti-arrows-vertical"></i></span></a>
                        </th>
                        @endif
                        @if(config('visibility.appointments_col_tags'))
                        <th class="appointments_col_tags"><a href="javascript:void(0)">{{ cleanLang(__('lang.tags')) }}</a></th>
                        @endif
                        <th class="appointments_col_status">
                            <a class="js-ajax-ux-request js-list-sorting" id="sort_appointment_status"
                                href="javascript:void(0)"
                                data-url="{{ urlResource('/appointments?action=sort&orderby=appointment_status&sortorder=asc') }}">{{ cleanLang(__('lang.status')) }}<span
                                    class="sorting-icons"><i class="ti-arrows-vertical"></i></span></a>
                        </th>
                        <th class="appointments_col_action"><a href="javascript:void(0)">{{ cleanLang(__('lang.action')) }}</a></th>
                    </tr>
                </thead>
                <tbody id="appointments-td-container">
                    <!--ajax content here-->
                    @include('pages.appointments.components.table.ajax')
                    <!--ajax content here-->
                </tbody>
                <tfoot>
                    <tr>
                        <td colspan="20">
                            <!--load more button-->
                            @include('misc.load-more-button')
                            <!--load more button-->
                        </td>
                    </tr>
                </tfoot>
            </table>
            @endif
            @if (@count($appointments ?? []) == 0)
            <!--nothing found-->
            @include('notifications.no-results-found')
            <!--nothing found-->
            @endif
        </div>
    </div>
</div>