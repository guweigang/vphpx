module main

import vphp

#include "php_bridge.h"

fn ensure_provider_registry(mut app VSlimApp) {
	if app.provider_classes.len == 0 {
		app.provider_classes = map[string]bool{}
	}
}

fn wrap_runtime_app_zval(app &VSlimApp) vphp.ZVal {
	unsafe {
		if isnil(app) || C.vslim__app_ce == 0 {
			return vphp.ZVal.new_null()
		}
		mut payload := vphp.RequestOwnedZVal.new_null().to_zval()
		vphp.return_borrowed_object_raw(payload.raw, app, C.vslim__app_ce, &C.vphp_class_handlers(vslimapp_handlers()))
		return payload
	}
}

fn app_self_zval(app &VSlimApp) vphp.ZVal {
	self_z := vphp.current_this_owned_request()
	if self_z.is_valid() && self_z.is_object() && self_z.is_instance_of('VSlim\\App') {
		return self_z
	}
	return wrap_runtime_app_zval(app)
}

fn normalize_service_provider_input(raw vphp.ZVal) !vphp.ZVal {
	if raw.is_valid() && raw.is_object() {
		return raw
	}
	if raw.is_valid() && raw.is_string() {
		class_name := raw.to_string().trim_space()
		if class_name == '' {
			return error('provider class name must not be empty')
		}
		exists := vphp.call_php('class_exists', [
			vphp.RequestOwnedZVal.new_string(class_name).to_zval(),
			vphp.RequestOwnedZVal.new_bool(true).to_zval(),
		])
		if !exists.to_bool() {
			return error('provider class "${class_name}" does not exist')
		}
		provider := vphp.php_class(class_name).construct([])
		if !provider.is_valid() || !provider.is_object() {
			return error('provider class "${class_name}" could not be constructed')
		}
		return provider
	}
	return error('provider must be an object or class-string')
}

fn provider_class_key(provider vphp.ZVal) string {
	return provider.class_name().trim_space()
}

fn bind_provider_to_app(provider vphp.ZVal, app_z vphp.ZVal) {
	if !provider.is_valid() || !provider.is_object() || !app_z.is_valid() || !app_z.is_object() {
		return
	}
	if provider.method_exists('setApp') {
		_ = provider.method_owned_request('setApp', [app_z])
	}
}

fn call_provider_lifecycle(provider vphp.ZVal, method_name string, app_z vphp.ZVal) ! {
	if !provider.is_valid() || !provider.is_object() || !provider.method_exists(method_name) {
		return
	}
	if app_z.is_valid() && app_z.is_object() {
		_ = provider.method_owned_request(method_name, [app_z])
		return
	}
	_ = provider.method_owned_request(method_name, [])
}

fn register_service_provider_zval(mut app VSlimApp, provider_z vphp.ZVal) ! {
	ensure_provider_registry(mut app)
	app_z := app_self_zval(&app)
	class_key := provider_class_key(provider_z)
	if class_key == '' {
		return error('provider class name must not be empty')
	}
	if class_key in app.provider_classes {
		return
	}
	bind_provider_to_app(provider_z, app_z)
	call_provider_lifecycle(provider_z, 'register', app_z)!
	app.providers << vphp.PersistentOwnedZVal.from_zval(provider_z)
	app.provider_classes[class_key] = true
	if app.booted {
		call_provider_lifecycle(provider_z, 'boot', app_z)!
	}
}

fn ensure_app_booted(mut app VSlimApp) {
	if app.booted {
		return
	}
	app.boot()
}

fn bootstrap_provider_values(value vphp.ZVal) ![]vphp.ZVal {
	normalized := psr16_iterable_to_array(value)!
	return normalized.fold[[]vphp.ZVal]([]vphp.ZVal{}, fn (_ vphp.ZVal, item vphp.ZVal, mut acc []vphp.ZVal) {
		acc << item
	})
}

@[php_method]
pub fn (mut app VSlimApp) register(provider vphp.BorrowedValue) &VSlimApp {
	provider_z := normalize_service_provider_input(provider.to_zval()) or {
		vphp.throw_exception_class('InvalidArgumentException', err.msg(), 0)
		return &app
	}
	register_service_provider_zval(mut app, provider_z) or {
		vphp.throw_exception_class('RuntimeException', err.msg(), 0)
		return &app
	}
	return &app
}

@[php_arg_type: 'providers=iterable']
@[php_method: 'registerMany']
pub fn (mut app VSlimApp) register_many(providers vphp.BorrowedValue) &VSlimApp {
	items := bootstrap_provider_values(providers.to_zval()) or {
		vphp.throw_exception_class('InvalidArgumentException', 'providers must be iterable',
			0)
		return &app
	}
	for item in items {
		app.register(vphp.BorrowedValue.from_zval(item))
	}
	return &app
}

@[php_method]
pub fn (mut app VSlimApp) boot() &VSlimApp {
	if app.booted {
		return &app
	}
	ensure_provider_registry(mut app)
	ensure_module_registry(mut app)
	app_z := app_self_zval(&app)
	for provider in app.providers {
		provider_z := provider.clone_request_owned().to_zval()
		bind_provider_to_app(provider_z, app_z)
		call_provider_lifecycle(provider_z, 'boot', app_z) or {
			vphp.throw_exception_class('RuntimeException', err.msg(), 0)
			return &app
		}
	}
	for mod_ref in app.modules {
		module_z := mod_ref.clone_request_owned().to_zval()
		boot_module_zval(mut app, module_z) or {
			vphp.throw_exception_class('RuntimeException', err.msg(), 0)
			return &app
		}
	}
	app.booted = true
	return &app
}

@[php_method: 'booted']
pub fn (app &VSlimApp) is_booted() bool {
	return app.booted
}

@[php_method: 'providerCount']
pub fn (app &VSlimApp) provider_count() int {
	return app.providers.len
}

@[php_method: 'hasProvider']
pub fn (app &VSlimApp) has_provider(class_name string) bool {
	return class_name.trim_space() in app.provider_classes
}
