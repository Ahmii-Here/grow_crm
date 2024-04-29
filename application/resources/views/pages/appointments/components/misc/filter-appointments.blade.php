<!-- right-sidebar -->
<div class="right-sidebar" id="sidepanel-filter-appointments">
    <form>
        <div class="slimscrollright">
            <!--title-->
            <div class="rpanel-title">
                <i class="icon-Filter-2"></i>{{ cleanLang(__('lang.filter_appointments')) }}
                <span>
                    <i class="ti-close js-close-side-panels" data-target="sidepanel-filter-appointments"></i>
                </span>
            </div>
            <!--title-->
            <!--body-->
            <div class="r-panel-body">


                <!--project-->
                <div class="filter-block">
                    <div class="title">
                        {{ cleanLang(__('lang.project')) }}
                    </div>
                    <div class="fields">
                        <div class="row">
                            <div class="col-md-12">
                                <select name="filter_appointment_projectid" id="filter_appointment_projectid"
                                    class="form-control form-control-sm js-select2-basic-search select2-hidden-accessible"
                                    data-ajax--url="{{ url('/') }}/feed/projects?ref=general"></select>
                            </div>
                        </div>
                    </div>
                </div>

                <!--appointment type (when viewing a project)-->
                @if(config('visibility.appointments_filter_milestone'))
                <div class="filter-block">
                    <div class="title">
                        {{ cleanLang(__('lang.milestone')) }}
                    </div>
                    <div class="fields">
                        <div class="row">
                            <div class="col-md-12">
                                <select name="filter_appointment_milestoneid" id="filter_appointment_milestoneid"
                                    class="form-control  form-control-sm select2-basic select2-multiple select2-hidden-accessible"
                                    multiple="multiple" tabindex="-1" aria-hidden="true">
                                    @if(isset($milestones))
                                    @foreach($milestones as $milestone)
                                    <option value="{{ $milestone->milestone_id }}">
                                        {{ runtimeLang($milestone->milestone_title, 'appointment_milestone') }}</option>
                                    @endforeach
                                    @endif
                                </select>
                            </div>
                        </div>
                    </div>
                </div>
                @endif


                <!--assigned-->
                @if(config('visibility.filter_panel_assigned'))
                <div class="filter-block">
                    <div class="title">
                        {{ cleanLang(__('lang.assigned_to')) }}
                    </div>
                    <div class="fields">
                        <div class="row">
                            <div class="col-md-12">
                                <select name="filter_assigned" id="filter_assigned"
                                    class="form-control form-control-sm select2-basic select2-multiple select2-tags select2-hidden-accessible"
                                    multiple="multiple" tabindex="-1" aria-hidden="true">
                                    <!--users list-->
                                    @foreach(config('system.team_members') as $user)
                                    <option value="{{ $user->id }}">{{ $user->full_name }}</option>
                                    @endforeach
                                    <!--/#users list-->
                                </select>
                            </div>
                        </div>
                    </div>
                </div>
                @endif

                <!--date added-->
                <div class="filter-block">
                    <div class="title">
                        {{ cleanLang(__('lang.date_added')) }}
                    </div>
                    <div class="fields">
                        <div class="row">
                            <div class="col-md-6">
                                <input type="text" name="filter_appointment_date_start_start" autocomplete="off"
                                    class="form-control form-control-sm pickadate" placeholder="Start">
                                <input class="mysql-date" type="hidden" name="filter_appointment_date_start_start"
                                    id="filter_appointment_date_start_start" value="">
                            </div>
                            <div class="col-md-6">
                                <input type="text" name="filter_appointment_date_start_end" autocomplete="off"
                                    class="form-control form-control-sm pickadate" placeholder="End">
                                <input class="mysql-date" type="hidden" name="filter_appointment_date_start_end"
                                    id="filter_appointment_date_start_end" value="">
                            </div>
                        </div>
                    </div>
                </div>

                <!--date due-->
                <div class="filter-block">
                    <div class="title">
                        {{ cleanLang(__('lang.due_date')) }}
                    </div>
                    <div class="fields">
                        <div class="row">
                            <div class="col-md-6">
                                <input type="text" name="filter_appointment_date_due_start"
                                    class="form-control form-control-sm pickadate" autocomplete="off"
                                    placeholder="Start">
                                <input class="mysql-date" type="hidden" name="filter_appointment_date_due_start"
                                    id="filter_appointment_date_due_start" value="">
                            </div>
                            <div class="col-md-6">
                                <input type="text" name="filter_appointment_date_due_end"
                                    class="form-control form-control-sm pickadate" autocomplete="off" placeholder="End">
                                <input class="mysql-date" type="hidden" name="filter_appointment_date_due_end"
                                    id="filter_appointment_date_due_end" value="">
                            </div>
                        </div>
                    </div>
                </div>
                <!--filter item-->
                <!--tags-->
                <div class="filter-block">
                    <div class="title">
                        {{ cleanLang(__('lang.tags')) }}
                    </div>
                    <div class="fields">
                        <div class="row">
                            <div class="col-md-12">
                                <select name="filter_tags" id="filter_tags"
                                    class="form-control form-control-sm select2-multiple {{ runtimeAllowUserTags() }} select2-hidden-accessible"
                                    multiple="multiple" tabindex="-1" aria-hidden="true">
                                    @foreach($tags as $tag)
                                    <option value="{{ $tag->tag_title }}">
                                        {{ $tag->tag_title }}</option>
                                    @endforeach
                                </select>
                            </div>
                        </div>
                    </div>
                </div>
                <!--tags-->


                <!--priority-->
                <div class="filter-block">
                    <div class="title">
                        {{ cleanLang(__('lang.priority')) }}
                    </div>
                    <div class="fields">
                        <div class="row">
                            <div class="col-md-12">
                                <select name="filter_appointment_priority" id="filter_appointment_priority"
                                    class="form-control  form-control-sm select2-basic select2-multiple select2-hidden-accessible"
                                    multiple="multiple" tabindex="-1" aria-hidden="true">
                                    <option value=""></option>
                                    @foreach($priorities as $priority)
                                    <option value="{{ $priority->appointmentpriority_id }}">{{ $priority->appointmentpriority_title }}</option>
                                    @endforeach
                                </select>
                            </div>
                        </div>
                    </div>
                </div>

                <!--status-->
                <div class="filter-block">
                    <div class="title">
                        {{ cleanLang(__('lang.status')) }}
                    </div>
                    <div class="fields">
                        <div class="row">
                            <div class="col-md-12">
                                <select name="filter_appointments_status" id="filter_appointments_status"
                                    class="form-control  form-control-sm select2-basic select2-multiple select2-hidden-accessible"
                                    multiple="multiple" tabindex="-1" aria-hidden="true">
                                    <option value=""></option>
                                    @foreach(config('appointment_statuses') as $appointment_status)
                                    <option value="{{ $appointment_status->appointmentstatus_id }}">{{ runtimeLang($appointment_status->appointmentstatus_title) }}</option>
                                    @endforeach
                                </select>
                            </div>
                        </div>
                    </div>
                </div>

                
                <!--state-->
                <div class="filter-block">
                    <div class="title">
                        {{ cleanLang(__('lang.show')) }}
                    </div>
                    <div class="fields">
                        <div class="row">
                            <div class="col-md-12">
                                <select class="select2-basic form-control form-control-sm"
                                    id="filter_appointment_state" name="filter_appointment_state">
                                    <option value=""></option>
                                    <option value="active">@lang('lang.active_appointments')</option>
                                    <option value="archived">@lang('lang.archives_appointments')</option>
                                    <option value="all">@lang('lang.everything')</option>
                                </select>
                            </div>
                        </div>
                    </div>
                </div>
                <!--status -->

                <!--custom fields-->
                @include('misc.customfields-filters')

                <!--buttons-->
                <div class="buttons-block">
                    <button type="button" name="foo1"
                        class="btn btn-rounded-x btn-secondary js-reset-filter-side-panel">{{ cleanLang(__('lang.reset')) }}</button>
                    <input type="hidden" name="action" value="search">
                    <input type="hidden" name="source" value="{{ $page['source_for_filter_panels'] ?? '' }}">
                    <button type="button" class="btn btn-rounded-x btn-danger js-ajax-ux-request apply-filter-button"
                        data-url="{{ urlResource('/appointments/search?') }}" data-type="form"
                        data-ajax-type="GET">{{ cleanLang(__('lang.apply_filter')) }}</button>
                </div>

            </div>
            <!--body-->
        </div>
    </form>
</div>
<!--sidebar-->