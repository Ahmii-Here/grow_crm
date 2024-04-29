    <div class="col-lg-8  col-md-12">
        <div class="card">
            <div class="card-body">
                <h5 class="card-title m-b-0 align-self-center">{{ cleanLang(__('lang.project_dashboard')) }}</h5>
                <div class="row m-b-30">
                    @foreach (array_diff(config('app.default-checklist'), config('app.default-checklist-dashboard')) as $name)
                    <!-- Todays Payments -->
                    <div class="col-lg-3 col-md-6 click-url cursor-pointer"
                        data-url="{{ url('/leads?checklist='.$name) }}">
                        <div class="card">
                            <div class="card-body p-l-15 p-r-15">
                                <div class="d-flex p-10 no-block">
                                    <span class="align-slef-center">
                                        <h2 class="m-b-0">{{ ($payload['count_checklists'][$name]['count'] ?? 0) }}</h2>
                                        <h6 class="text-muted m-b-0">{{ cleanLang(__($name)) }}</h6>
                                    </span>
                                </div>
                            </div>
                            <div class="progress">
                                <div class="progress-bar bg-info w-100 h-px-3" role="progressbar" aria-valuenow="100" aria-valuemin="0"
                                    aria-valuemax="100"></div>
                            </div>
                        </div>
                    </div>
                    @endforeach
                </div>
            </div>
        </div>
    </div>