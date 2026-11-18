module appx

import registrationx
import configx as cfgx
import containerx
import routex
import testingx
import validationx
import vphp

@[vphp.PhpArgName(v_name: 'base_path', php_name: 'basePath')]
@[vphp.PhpExportMethod(name: 'setBasePath')]
pub fn (mut app VSlimApp) set_base_path(base_path string) &VSlimApp {
	app.track_view_settings()
	app.base_path = routex.normalize_base_path(base_path)
	return app
}

@[vphp.PhpExportMethod(name: 'hasContainer')]
pub fn (app &VSlimApp) has_container() bool {
	return app.container_ref != unsafe { nil }
}

pub fn (app &VSlimApp) watch_service_state() &registrationx.RegistrationStateContext {
	return registrationx.watch_registration_state(fn [app] (mut scope registrationx.RegistrationScope) {
		if app.container_ref != unsafe { nil } {
			app.container_ref.snapshot_services(mut scope)
		}
	})
}

@[vphp.PhpExportMethod(name: 'setContainer')]
pub fn (mut app VSlimApp) set_container(container &containerx.VSlimContainer) &VSlimApp {
	app.track_container_replacement()
	app.container_ref = container
	app.sync_standard_services_to_container()
	return app
}

@[vphp.PhpExportMethod(name: '')]
pub fn (mut app VSlimApp) container() &containerx.VSlimContainer {
	if app.container_ref == unsafe { nil } {
		app.track_container_replacement()
		app.container_ref = containerx.VSlimContainer.new()
	}
	app.sync_standard_services_to_container()
	return app.container_ref
}

@[vphp.PhpExportMethod(name: 'hasConfig')]
pub fn (app &VSlimApp) has_config() bool {
	return app.config_ref != unsafe { nil }
}

@[vphp.PhpExportMethod(name: 'setConfig')]
pub fn (mut app VSlimApp) set_config(config &cfgx.VSlimConfig) &VSlimApp {
	app.track_config_binding()
	app.config_ref = config
	app.configure_default_auth_settings(app.config_ref)
	app.sync_standard_services_to_container()
	return app
}

@[vphp.PhpExportMethod(name: '')]
pub fn (mut app VSlimApp) config() &cfgx.VSlimConfig {
	if app.config_ref == unsafe { nil } {
		app.track_config_binding()
		app.config_ref = cfgx.VSlimConfig.new_default()
		app.configure_default_auth_settings(app.config_ref)
		app.sync_standard_services_to_container()
	}
	return app.config_ref
}

@[vphp.PhpExportMethod(name: 'loadConfig')]
pub fn (mut app VSlimApp) load_config(path string) &VSlimApp {
	mut cfg := app.config()
	cfg.load(path)
	app.configure_default_auth_settings(app.config_ref)
	app.sync_standard_services_to_container()
	return app
}

@[vphp.PhpExportMethod(name: 'loadConfigText')]
pub fn (mut app VSlimApp) load_config_text(text string) &VSlimApp {
	mut cfg := app.config()
	cfg.load_text(text)
	app.configure_default_auth_settings(app.config_ref)
	app.sync_standard_services_to_container()
	return app
}

@[vphp.PhpExportMethod(name: 'mergeConfig')]
pub fn (mut app VSlimApp) merge_config(path string) &VSlimApp {
	mut cfg := app.config()
	cfg.merge_file(path)
	app.configure_default_auth_settings(app.config_ref)
	app.sync_standard_services_to_container()
	return app
}

@[vphp.PhpExportMethod(name: 'mergeConfigText')]
pub fn (mut app VSlimApp) merge_config_text(text string) &VSlimApp {
	mut cfg := app.config()
	cfg.merge_text(text)
	app.configure_default_auth_settings(app.config_ref)
	app.sync_standard_services_to_container()
	return app
}

@[vphp.PhpExportMethod(name: '')]
pub fn (mut app VSlimApp) validate(data vphp.PhpValue, rules vphp.PhpArray) &validationx.VSlimValidator {
	mut validator := validationx.VSlimValidator.make(data, rules)
	validator.validate()
	return validator
}

@[vphp.PhpExportMethod(name: '')]
pub fn (app &VSlimApp) testing() &testingx.VSlimTestingHarness {
	unsafe {
		mut mutable_app := &VSlimApp(app)
		mut harness := testingx.VSlimTestingHarness.from_container(mutable_app.container())
		mut app_value := app.self_value()
		defer {
			app_value.release()
		}
		if app_object := app_value.as_object() {
			harness.set_app(app_object)
		}
		return harness
	}
}
