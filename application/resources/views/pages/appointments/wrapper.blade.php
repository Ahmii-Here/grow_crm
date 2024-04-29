@extends('layout.wrapper') @section('content')
<!-- main content -->
<div class="container-fluid">

    <!--page heading-->
    <div class="row page-titles">

        <!-- Page Title & Bread Crumbs -->
        @include('misc.heading-crumbs')
        <!--Page Title & Bread Crumbs -->


        <!-- action buttons -->
        @include('pages.appointments.components.misc.list-page-actions')
        <!-- action buttons -->

    </div>
    <!--page heading-->

    <!--stats panel-->
    @if(auth()->user()->is_team)
    <div class="stats-wrapper " id="appointments-stats-wrapper">
        @include('pages.appointments.components.misc.list-pages-stats')
    </div>
    @endif
    <!--stats panel-->


    <!-- page content -->
    <div class="row kanban-wrapper">
        <div class="col-12" id="appointments-layout-wrapper">
            @if(auth()->user()->pref_view_appointments_layout == 'kanban')
            @include('pages.appointments.components.kanban.wrapper')
            @else
            <!--appointments table-->
            @include('pages.appointments.components.table.wrapper')
            <!--appointments table-->
            @endif
            <!--filter-->
            @if(auth()->user()->is_team)
            @include('pages.appointments.components.misc.filter-appointments')
            @endif
            <!--filter-->
        </div>
    </div>
    <!--page content -->

</div>
<!--main content -->

<!--appointment modal-->
@include('pages.appointment.modal')

<!--dynamic load appointment appointment (dynamic_trigger_dom)-->
@if(config('visibility.dynamic_load_modal'))
<a href="javascript:void(0)" id="dynamic-appointment-content"
    class="show-modal-button reset-card-modal-form js-ajax-ux-request js-ajax-ux-request" data-toggle="modal"
    data-target="#cardModal" data-url="{{ url('/appointments/'.request()->route('appointment').'?ref=list') }}"
    data-loading-target="main-top-nav-bar"></a>
@endif

@endsection