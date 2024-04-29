<!--main table view-->
@include('pages.appointments.components.kanban.kanban')

<!--Update Card Poistion (team only)-->
@if(auth()->user()->is_team || config('visibility.appointments_participate'))
<span id="js-appointments-kanban-wrapper" class="hidden" data-position="{{ url('appointments/update-position') }}">placeholder</script>
@endif