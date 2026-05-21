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

fn normalize_service_provider_class(raw_class_name string) !vphp.PhpValue {
	return supportx.class_instance_value(raw_class_name, 'provider')
}

fn (mut app VSlimApp) register_service_provider_value(provider vphp.PhpValue) ! {
	app.ensure_provider_registry()
	mut app_value := (&app).self_value()
	class_key := supportx.class_key(provider)
	if class_key == '' {
		return error('provider class name must not be empty')
	}
	if class_key in app.provider_classes {
		return
	}
	supportx.bind_to_app(provider, app_value)
	supportx.call_lifecycle(provider, 'register', app_value)!
	provider_obj := provider.as_object() or {
		return error('provider "${class_key}" could not be retained')
	}
	app.providers << provider_obj.retain()
	app.provider_classes[class_key] = true
	if app.booted {
		supportx.call_lifecycle(provider, 'boot', app_value)!
	}
}

fn (mut app VSlimApp) register_service_provider_class(class_name string) ! {
	mut provider := normalize_service_provider_class(class_name)!
	defer {
		provider.release()
	}
	app.register_service_provider_value(provider)!
}

fn (mut app VSlimApp) ensure_booted() {
	if app.booted {
		return
	}
	app.boot()
}

fn (mut app VSlimApp) register_service_provider_values(providers vphp.PhpIterable) ! {
	mut normalized := providers.to_array()!
	defer {
		normalized.release()
	}
	for item in normalized.value_items() {
		mut provider := supportx.input_value(item, 'provider')!
		defer {
			provider.release()
		}
		app.register_service_provider_value(provider)!
	}
}

@[php_method]
pub fn (mut app VSlimApp) register(provider vphp.PhpValue) &VSlimApp {
	mut provider_value := supportx.input_value(provider, 'provider') or {
		vphp.PhpException.raise_class('InvalidArgumentException', err.msg(), 0)
		return &app
	}
	defer {
		provider_value.release()
	}
	app.register_service_provider_value(provider_value) or {
		vphp.PhpException.raise_class('RuntimeException', err.msg(), 0)
		return &app
	}
	return &app
}

@[php_method: 'registerMany']
pub fn (mut app VSlimApp) register_many(providers vphp.PhpIterable) &VSlimApp {
	app.register_service_provider_values(providers) or {
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
	app.ensure_provider_registry()
	app.ensure_module_registry()
	mut app_value := (&app).self_value()
	for provider in app.providers {
		ok := provider.with_object(fn [app_value] (provider vphp.PhpObject) bool {
			provider_value := provider.to_value()
			supportx.bind_to_app(provider_value, app_value)
			supportx.call_lifecycle(provider_value, 'boot', app_value) or {
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
			app.boot_module_value(module_value) or {
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
