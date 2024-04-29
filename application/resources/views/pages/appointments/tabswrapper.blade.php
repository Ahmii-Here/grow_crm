<!-- action buttons -->
@include('pages.appointments.components.misc.list-page-actions')
<!-- action buttons -->

<!--stats panel-->
@if(auth()->user()->is_team)
<div id="appointments-stats-wrapper" class="stats-wrapper card-embed-fix">
    @if (@count($appointments ?? []) > 0) @include('misc.list-pages-stats') @endif
</div>
@endif
<!--stats panel-->

<!--appointments and kanban layouts-->
@if(auth()->user()->pref_view_appointments_layout =='list')
<div class="card-embed-fix  kanban-wrapper">
    @include('pages.appointments.components.table.wrapper')
</div>
@else
<div class="card-embed-fix  kanban-wrapper">
    @include('pages.appointments.components.kanban.wrapper')
</div>
@endif
<!--/#appointments and kanban layouts-->

<!--filter-->
@if(auth()->user()->is_team)
@include('pages.appointments.components.misc.filter-appointments')
@endif
<!--filter-->

<!--appointment modal-->
@include('pages.appointment.modal')
