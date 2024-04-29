<div class="row">
    <div class="col-lg-12">
        <!--title-->
        <div class="form-group row">
            <label
                class="col-12 text-left control-label col-form-label required">{{ cleanLang(__('lang.priority_name')) }}*</label>
            <div class="col-12">
                <input type="text" class="form-control form-control-sm" id="appointmentpriority_title"
                    name="appointmentpriority_title" value="{{ $priority->appointmentpriority_title ?? '' }}">
            </div>
        </div>
    </div>
    <div class="col-lg-12">
        <div class="form-group row">
            <div class="col-12">
                <input name="appointmentpriority_colors" type="radio" id="radio_default" value="default"
                    {{ $page['default_color'] ?? '' }}
                    {{ runtimePreChecked2('default', $priority->appointmentpriority_color ?? '') }}
                    class="with-gap radio-col-grey appointmentpriority_colors">
                <label for="radio_default"><span class="bg-default settings-appointments-modal-color-select">&nbsp;</span>
                </label>
            </div>
            <div class="col-12 p-b-5">
                <input name="appointmentpriority_colors" type="radio" id="radio_info" value="info"
                    {{ runtimePreChecked2('info', $priority->appointmentpriority_color ?? '') }}
                    class="with-gap radio-col-grey appointmentpriority_colors">
                <label for="radio_info"><span class="bg-info settings-appointments-modal-color-select">&nbsp;</span>
                </label>
            </div>
            <div class="col-12">
                <input name="appointmentpriority_colors" type="radio" id="radio_success" value="success"
                    {{ runtimePreChecked2('success', $priority->appointmentpriority_color ?? '') }}
                    class="with-gap radio-col-grey appointmentpriority_colors">
                <label for="radio_success"><span class="bg-success settings-appointments-modal-color-select">&nbsp;</span>
                </label>
            </div>
            <div class="col-12">
                <input name="appointmentpriority_colors" type="radio" id="radio_danger" value="danger"
                    {{ runtimePreChecked2('danger', $priority->appointmentpriority_color ?? '') }}
                    class="with-gap radio-col-grey appointmentpriority_colors">
                <label for="radio_danger"><span class="bg-danger settings-appointments-modal-color-select">&nbsp;</span>
                </label>
            </div>
            <div class="col-12">
                <input name="appointmentpriority_colors" type="radio" id="radio_warning" value="warning"
                    {{ runtimePreChecked2('warning', $priority->appointmentpriority_color ?? '') }}
                    class="with-gap radio-col-grey appointmentpriority_colors">
                <label for="radio_warning"><span class="bg-warning settings-appointments-modal-color-select">&nbsp;</span>
                </label>
            </div>
            <div class="col-12">
                <input name="appointmentpriority_colors" type="radio" id="radio_primary" value="primary"
                    {{ runtimePreChecked2('primary', $priority->appointmentpriority_color ?? '') }}
                    class="with-gap radio-col-grey appointmentpriority_colors">
                <label for="radio_primary"><span class="bg-primary settings-appointments-modal-color-select">&nbsp;</span>
                </label>
            </div>
            <div class="col-12">
                <input name="appointmentpriority_colors" type="radio" id="radio_lime" value="lime"
                    {{ runtimePreChecked2('lime', $priority->appointmentpriority_color ?? '') }}
                    class="with-gap radio-col-grey appointmentpriority_colors">
                <label for="radio_lime"><span class="bg-lime settings-appointments-modal-color-select">&nbsp;</span>
                </label>
            </div>
            <div class="col-12">
                <input name="appointmentpriority_colors" type="radio" id="radio_brown" value="brown"
                    {{ runtimePreChecked2('brown', $priority->appointmentpriority_color ?? '') }}
                    class="with-gap radio-col-grey appointmentpriority_colors">
                <label for="radio_brown"><span class="bg-brown settings-appointments-modal-color-select">&nbsp;</span>
                </label>
            </div>

            <!--hidden-->
            <input type="hidden" name="appointmentpriority_color" id="appointmentpriority_color" value="">

        </div>
    </div>
</div>