module appx

import configx as cfgx
import containerx
import routex
import testingx
import validationx
import vphp

@[php_arg_name: 'base_path=basePath']
@[php_method: 'setBasePath']
pub fn (mut app VSlimApp) set_base_path(base_path string) &VSlimApp {
	app.base_path = routex.normalize_base_path(base_path)
	return app
}

@[php_method: 'hasContainer']
pub fn (app &VSlimApp) has_container() bool {
	return app.container_ref != unsafe { nil }
}

@[php_method: 'setContainer']
pub fn (mut app VSlimApp) set_container(container &containerx.VSlimContainer) &VSlimApp {
	app.container_ref = container
	app.sync_standard_services_to_container()
	return app
}

@[php_method]
pub fn (mut app VSlimApp) container() &containerx.VSlimContainer {
	if app.container_ref == unsafe { nil } {
		app.container_ref = containerx.VSlimContainer.new()
	}
	app.sync_standard_services_to_container()
	return app.container_ref
}

@[php_method: 'hasConfig']
pub fn (app &VSlimApp) has_config() bool {
	return app.config_ref != unsafe { nil }
}

@[php_method: 'setConfig']
pub fn (mut app VSlimApp) set_config(config &cfgx.VSlimConfig) &VSlimApp {
	app.config_ref = config
	app.configure_default_auth_settings(app.config_ref)
	app.sync_standard_services_to_container()
	return app
}

@[php_method]
pub fn (mut app VSlimApp) config() &cfgx.VSlimConfig {
	if app.config_ref == unsafe { nil } {
		app.config_ref = cfgx.VSlimConfig.new_default()
		app.configure_default_auth_settings(app.config_ref)
		app.sync_standard_services_to_container()
	}
	return app.config_ref
}

@[php_method: 'loadConfig']
pub fn (mut app VSlimApp) load_config(path string) &VSlimApp {
	mut cfg := app.config()
	cfg.load(path)
	app.configure_default_auth_settings(app.config_ref)
	app.sync_standard_services_to_container()
	return app
}

@[php_method: 'loadConfigText']
pub fn (mut app VSlimApp) load_config_text(text string) &VSlimApp {
	mut cfg := app.config()
	cfg.load_text(text)
	app.configure_default_auth_settings(app.config_ref)
	app.sync_standard_services_to_container()
	return app
}

@[php_method: 'mergeConfig']
pub fn (mut app VSlimApp) merge_config(path string) &VSlimApp {
	mut cfg := app.config()
	cfg.merge_file(path)
	app.configure_default_auth_settings(app.config_ref)
	app.sync_standard_services_to_container()
	return app
}

@[php_method: 'mergeConfigText']
pub fn (mut app VSlimApp) merge_config_text(text string) &VSlimApp {
	mut cfg := app.config()
	cfg.merge_text(text)
	app.configure_default_auth_settings(app.config_ref)
	app.sync_standard_services_to_container()
	return app
}

@[php_method]
pub fn (mut app VSlimApp) validate(data vphp.PhpValue, rules vphp.PhpArray) &validationx.VSlimValidator {
	mut validator := validationx.VSlimValidator.make(data, rules)
	validator.validate()
	return validator
}

@[php_method]
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
