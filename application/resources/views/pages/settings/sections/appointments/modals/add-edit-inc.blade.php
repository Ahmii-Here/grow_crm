<div class="row">
    <div class="col-lg-12">
        <!--title-->
        <div class="form-group row">
            <label class="col-12 text-left control-label col-form-label required">{{ cleanLang(__('lang.status_name')) }}*</label>
            <div class="col-12">
                <input type="text" class="form-control form-control-sm" id="appointmentstatus_title" name="appointmentstatus_title"
                    value="{{ $status->appointmentstatus_title ?? '' }}">
            </div>
        </div>
    </div>
    <div class="col-lg-12">
        <div class="form-group row">
            <div class="col-12">
                <input name="appointmentstatus_colors" type="radio" id="radio_default" value="default"
                    {{ $page['default_color'] ?? '' }} {{ runtimePreChecked2('default', $status->appointmentstatus_color ?? '') }}
                    class="with-gap radio-col-grey appointmentstatus_colors">
                <label for="radio_default"><span class="bg-default settings-appointments-modal-color-select"
                        >&nbsp;</span>
                </label>
            </div>
            <div class="col-12 p-b-5">
                <input name="appointmentstatus_colors" type="radio" id="radio_info" value="info"
                    {{ runtimePreChecked2('info', $status->appointmentstatus_color ?? '') }}
                    class="with-gap radio-col-grey appointmentstatus_colors">
                <label for="radio_info"><span class="bg-info settings-appointments-modal-color-select"
                        >&nbsp;</span>
                </label>
            </div>
            <div class="col-12">
                <input name="appointmentstatus_colors" type="radio" id="radio_success" value="success"
                    {{ runtimePreChecked2('success', $status->appointmentstatus_color ?? '') }}
                    class="with-gap radio-col-grey appointmentstatus_colors">
                <label for="radio_success"><span class="bg-success settings-appointments-modal-color-select"
                        >&nbsp;</span>
                </label>
            </div>
            <div class="col-12">
                <input name="appointmentstatus_colors" type="radio" id="radio_danger" value="danger"
                    {{ runtimePreChecked2('danger', $status->appointmentstatus_color ?? '') }}
                    class="with-gap radio-col-grey appointmentstatus_colors">
                <label for="radio_danger"><span class="bg-danger settings-appointments-modal-color-select"
                        >&nbsp;</span>
                </label>
            </div>
            <div class="col-12">
                <input name="appointmentstatus_colors" type="radio" id="radio_warning" value="warning"
                    {{ runtimePreChecked2('warning', $status->appointmentstatus_color ?? '') }}
                    class="with-gap radio-col-grey appointmentstatus_colors">
                <label for="radio_warning"><span class="bg-warning settings-appointments-modal-color-select"
                        >&nbsp;</span>
                </label>
            </div>
            <div class="col-12">
                <input name="appointmentstatus_colors" type="radio" id="radio_primary" value="primary"
                    {{ runtimePreChecked2('primary', $status->appointmentstatus_color ?? '') }}
                    class="with-gap radio-col-grey appointmentstatus_colors">
                <label for="radio_primary"><span class="bg-primary settings-appointments-modal-color-select"
                        >&nbsp;</span>
                </label>
            </div>
            <div class="col-12">
                <input name="appointmentstatus_colors" type="radio" id="radio_lime" value="lime"
                    {{ runtimePreChecked2('lime', $status->appointmentstatus_color ?? '') }}
                    class="with-gap radio-col-grey appointmentstatus_colors">
                <label for="radio_lime"><span class="bg-lime settings-appointments-modal-color-select"
                        >&nbsp;</span>
                </label>
            </div>
            <div class="col-12">
                <input name="appointmentstatus_colors" type="radio" id="radio_brown" value="brown"
                    {{ runtimePreChecked2('brown', $status->appointmentstatus_color ?? '') }}
                    class="with-gap radio-col-grey appointmentstatus_colors">
                <label for="radio_brown"><span class="bg-brown settings-appointments-modal-color-select"
                        >&nbsp;</span>
                </label>
            </div>

            <!--hidden-->
            <input type="hidden" name="appointmentstatus_color" id="appointmentstatus_color" value="">

        </div>
    </div>