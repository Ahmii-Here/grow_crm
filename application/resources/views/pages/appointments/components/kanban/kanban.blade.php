<div class="boards count-{{ @count($appointments ?? []) }}" id="appointments-view-wrapper">
    <!--each board-->
    @foreach($boards as $board)
    <!--board-->
    @include('pages.appointments.components.kanban.board')
    @endforeach
</div>
<!--ajax element-->
<span class="hidden" data-url=""></span>

<!--filter-->
@if(auth()->user()->is_team)
@include('pages.appointments.components.misc.filter-appointments')
@endif
<!--filter-->