module main

import vphp

#include "php_bridge.h"

fn ensure_provider_registry(mut app VSlimApp) {
	if app.provider_classes.len == 0 {
		app.provider_classes = map[string]bool{}
	}
}

fn wrap_runtime_app_value(app &VSlimApp) vphp.PhpValue {
	unsafe {
		if isnil(app) {
			return vphp.PhpValue.null()
		}
		return app.bind_php_object_value()
	}
}

fn app_self_value(app &VSlimApp) vphp.PhpValue {
	if self := vphp.PhpObject.current() {
		if self.is_valid() && self.is_instance_of('VSlim\\App') {
			return self.owned().to_value()
		}
	}
	return wrap_runtime_app_value(app)
}

fn bootstrap_debug_included_hits(class_name string) []string {
	class_stem := class_name.all_after_last('\\').trim_space().to_lower()
	return vphp.PhpFunction.named('get_included_files').with_result[vphp.PhpArray, []string](fn [class_stem] (files vphp.PhpArray) []string {
		mut hits := []string{}
		for idx := 0; idx < files.count(); idx++ {
			file := files.get_index(idx).to_string().trim_space()
			if file == '' {
				continue
			}
			lower := file.to_lower()
			if class_stem != '' && lower.contains(class_stem) {
				hits << file
				continue
			}
			if lower.contains('/app/providers/') || lower.contains('\\app\\providers\\')
				|| lower.contains('/app/modules/') || lower.contains('\\app\\modules\\') {
				hits << file
			}
		}
		return hits
	}) or { []string{} }
}

fn log_bootstrap_class_visibility(kind string, class_name string) {
	mut class_arg := vphp.PhpString.of(class_name)
	mut no_autoload_arg := vphp.PhpBool.of(false)
	mut autoload_arg := vphp.PhpBool.of(true)
	defer {
		class_arg.release()
		no_autoload_arg.release()
		autoload_arg.release()
	}
	exists_no_autoload := vphp.PhpFunction.named('class_exists').result_bool(class_arg,
		no_autoload_arg)
	exists_autoload := vphp.PhpFunction.named('class_exists').result_bool(class_arg, autoload_arg)
	included_hits := bootstrap_debug_included_hits(class_name)
	cli_debug_log('${kind}_class_visibility class="${class_name}" exists_no_autoload=${exists_no_autoload} exists_autoload=${exists_autoload} included_hits=${included_hits}')
}

fn normalize_service_provider_input(raw vphp.PhpValue) !vphp.PhpValue {
	if raw.is_valid() && raw.is_object() {
		return raw.owned()
	}
	if raw.is_valid() && raw.is_string() {
		return normalize_service_provider_class(raw.to_string())
	}
	return error('provider must be an object or class-string')
}

fn normalize_service_provider_class(raw_class_name string) !vphp.PhpValue {
	class_name := raw_class_name.trim_space()
	if class_name == '' {
		return error('provider class name must not be empty')
	}
	mut class_arg := vphp.PhpString.of(class_name)
	mut autoload_arg := vphp.PhpBool.of(true)
	defer {
		class_arg.release()
		autoload_arg.release()
	}
	exists := vphp.PhpFunction.named('class_exists').result_bool(class_arg, autoload_arg)
	if !exists {
		log_bootstrap_class_visibility('provider', class_name)
		return error('provider class "${class_name}" does not exist')
	}
	mut provider := vphp.PhpClass.named(class_name).construct() or {
		return error('provider class "${class_name}" could not be constructed')
	}
	return provider.take_value()
}

fn provider_class_key(provider vphp.PhpValue) string {
	return provider.class_name().trim_space()
}

fn bind_provider_to_app(provider vphp.PhpValue, app_value vphp.PhpValue) {
	if !provider.is_valid() || !provider.is_object() || !app_value.is_valid()
		|| !app_value.is_object() {
		return
	}
	if provider.method_exists('setApp') {
		provider.require_object() or { return }.with_method_result[vphp.PhpValue, bool]('setApp', fn (_ vphp.PhpValue) bool {
			return true
		}, app_value) or { false }
	}
}

fn call_provider_lifecycle(provider vphp.PhpValue, method_name string, app_value vphp.PhpValue) ! {
	if !provider.is_valid() || !provider.is_object() || !provider.method_exists(method_name) {
		return
	}
	obj := provider.require_object() or { return }
	if php_object_method_required_params(obj, method_name) > 0 && app_value.is_valid()
		&& app_value.is_object() {
		obj.with_method_result[vphp.PhpValue, bool](method_name, fn (_ vphp.PhpValue) bool {
			return true
		}, app_value) or { false }
		return
	}
	obj.with_method_result[vphp.PhpValue, bool](method_name, fn (_ vphp.PhpValue) bool {
		return true
	}) or { false }
}

fn register_service_provider_value(mut app VSlimApp, provider vphp.PhpValue) ! {
	ensure_provider_registry(mut app)
	mut app_value := app_self_value(&app)
	class_key := provider_class_key(provider)
	if class_key == '' {
		return error('provider class name must not be empty')
	}
	if class_key in app.provider_classes {
		return
	}
	bind_provider_to_app(provider, app_value)
	call_provider_lifecycle(provider, 'register', app_value)!
	provider_obj := provider.as_object() or {
		return error('provider "${class_key}" could not be retained')
	}
	app.providers << provider_obj.retain()
	app.provider_classes[class_key] = true
	if app.booted {
		call_provider_lifecycle(provider, 'boot', app_value)!
	}
}

fn register_service_provider_class(mut app VSlimApp, class_name string) ! {
	mut provider := normalize_service_provider_class(class_name)!
	defer {
		provider.release()
	}
	register_service_provider_value(mut app, provider)!
}

fn ensure_app_booted(mut app VSlimApp) {
	if app.booted {
		return
	}
	app.boot()
}

fn register_service_provider_values(mut app VSlimApp, providers vphp.PhpIterable) ! {
	mut normalized := providers.to_array()!
	defer {
		normalized.release()
	}
	for item in normalized.value_items() {
		mut provider := normalize_service_provider_input(item)!
		defer {
			provider.release()
		}
		register_service_provider_value(mut app, provider)!
	}
}

@[php_method]
pub fn (mut app VSlimApp) register(provider vphp.PhpValue) &VSlimApp {
	mut provider_value := normalize_service_provider_input(provider) or {
		vphp.PhpException.raise_class('InvalidArgumentException', err.msg(), 0)
		return &app
	}
	defer {
		provider_value.release()
	}
	register_service_provider_value(mut app, provider_value) or {
		vphp.PhpException.raise_class('RuntimeException', err.msg(), 0)
		return &app
	}
	return &app
}

@[php_method: 'registerMany']
pub fn (mut app VSlimApp) register_many(providers vphp.PhpIterable) &VSlimApp {
	register_service_provider_values(mut app, providers) or {
		vphp.PhpException.raise_class('InvalidArgumentException', 'providers must be iterable', 0)
		return &app
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
	mut app_value := app_self_value(&app)
	for provider in app.providers {
		ok := provider.with_object(fn [app_value] (provider vphp.PhpObject) bool {
			provider_value := provider.to_value()
			bind_provider_to_app(provider_value, app_value)
			call_provider_lifecycle(provider_value, 'boot', app_value) or {
				vphp.PhpException.raise_class('RuntimeException', err.msg(), 0)
				return false
			}
			return true
		})
		if !ok {
			app.booted = false
			return &app
		}
	}
	for mod_ref in app.modules {
		ok := mod_ref.with_object(fn [mut app] (mod_obj vphp.PhpObject) bool {
			module_value := mod_obj.to_value()
			boot_module_value(mut app, module_value) or {
				vphp.PhpException.raise_class('RuntimeException', err.msg(), 0)
				return false
			}
			return true
		})
		if !ok {
			app.booted = false
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

@[php_arg_name: 'class_name=className']
@[php_method: 'hasProvider']
pub fn (app &VSlimApp) has_provider(class_name string) bool {
	return class_name.trim_space() in app.provider_classes
}
