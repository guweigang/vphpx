module appx

import supportx
import vphp

#include "php_bridge.h"

fn (mut app VSlimApp) ensure_provider_registry() {
	if app.provider_classes.len == 0 {
		app.provider_classes = map[string]bool{}
	}
}

pub fn (app &VSlimApp) wrap_runtime_value() vphp.PhpValue {
	unsafe {
		if isnil(app) {
			return vphp.PhpValue.null()
		}
		return vphp.bind_borrowed_object_value[VSlimApp](app)
	}
}

pub fn (app &VSlimApp) self_value() vphp.PhpValue {
	if self := vphp.PhpObject.current() {
		if self.is_valid() && self.is_instance_of('VSlim\\App') {
			return self.owned().to_value()
		}
	}
	return app.wrap_runtime_value()
}

fn raise_app_error(class_name string, err IError) {
	if !vphp.has_exception() {
		vphp.PhpException.raise_class(class_name, err.msg(), 0)
	}
}

@[php_method]
pub fn (mut app VSlimApp) register(provider vphp.PhpValue) &VSlimApp {
	mut provider_value := supportx.input_value(provider, 'provider') or {
		raise_app_error('InvalidArgumentException', err)
		return &app
	}
	defer {
		provider_value.release()
	}
	app.register_component(provider_value, .provider) or {
		raise_app_error('RuntimeException', err)
		return &app
	}
	return &app
}

@[php_method: 'registerMany']
pub fn (mut app VSlimApp) register_many(providers vphp.PhpIterable) &VSlimApp {
	app.register_component_batch(providers, .provider)
	return &app
}

@[php_method]
pub fn (mut app VSlimApp) boot() &VSlimApp {
	app.apply_boot() or { raise_app_error('RuntimeException', err) }
	return &app
}

pub fn (mut app VSlimApp) apply_boot() ! {
	if vphp.has_exception() {
		return error('application bootstrap failed')
	}
	if app.booted {
		return
	}
	if app.booting {
		return error('application boot is already in progress')
	}
	app.track_bootstrap_boot()
	app.booting = true
	state := app.watch_service_state()
	defer {
		state.close()
		app.booting = false
		app.settle_deferred_bootstrap()
	}
	app.ensure_provider_registry()
	app.ensure_module_registry()
	mut app_value := (&app).self_value()
	defer {
		app_value.release()
	}
	for {
		// A boot callback can register more components on the same app.
		if app.provider_boot.index < app.providers.len {
			provider := app.providers[app.provider_boot.index]
			boot_registered_component(provider, .provider, app_value, mut app.provider_boot)!
		} else if app.module_boot.index < app.modules.len {
			module_ref := app.modules[app.module_boot.index]
			boot_registered_component(module_ref, .module_, app_value, mut app.module_boot)!
		} else {
			break
		}
	}
	app.booted = true
}

fn boot_registered_component(component vphp.PhpObject, kind AppComponentKind, app_value vphp.PhpValue, mut progress ComponentBootProgress) ! {
	mut obj := component.owned()
	defer {
		obj.release()
	}
	boot_component(obj, kind, app_value, mut progress)!
	progress.index++
	progress.step = .bind
}

@[php_method: 'booted']
pub fn (app &VSlimApp) is_booted() bool {
	return app.booted
}

@[php_method: 'providerCount']
pub fn (app &VSlimApp) provider_count() int {
	return app.providers.len
}

@[php_arg_name: 'class_name=className']
@[php_method: 'hasProvider']
pub fn (app &VSlimApp) has_provider(class_name string) bool {
	return class_name.trim_space() in app.provider_classes
}
