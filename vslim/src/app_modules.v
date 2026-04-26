module main

import vphp

fn ensure_module_registry(mut app VSlimApp) {
	if app.module_classes.len == 0 {
		app.module_classes = map[string]bool{}
	}
}

fn normalize_module_input(raw vphp.ZVal) !vphp.ZVal {
	if raw.is_valid() && raw.is_object() {
		return raw
	}
	if raw.is_valid() && raw.is_string() {
		class_name := raw.to_string().trim_space()
		if class_name == '' {
			return error('module class name must not be empty')
		}
		exists := vphp.php_call_result_bool('class_exists', [
			vphp.RequestOwnedZBox.new_string(class_name).to_zval(),
			vphp.RequestOwnedZBox.new_bool(true).to_zval(),
		])
		if !exists {
			log_bootstrap_class_visibility('module', class_name)
			return error('module class "${class_name}" does not exist')
		}
		mod_z := vphp.php_class(class_name).construct([])
		if !mod_z.is_valid() || !mod_z.is_object() {
			return error('module class "${class_name}" could not be constructed')
		}
		return mod_z
	}
	return error('module must be an object or class-string')
}

fn module_class_key(mod_z vphp.ZVal) string {
	return mod_z.class_name().trim_space()
}

fn bind_module_to_app(mod_z vphp.ZVal, app_z vphp.ZVal) {
	if !mod_z.is_valid() || !mod_z.is_object() || !app_z.is_valid() || !app_z.is_object() {
		return
	}
	if mod_z.method_exists('setApp') {
		vphp.with_method_result_zval(mod_z, 'setApp', [app_z], fn (_ vphp.ZVal) bool {
			return true
		})
	}
}

fn call_module_lifecycle(mod_z vphp.ZVal, method_name string, app_z vphp.ZVal) ! {
	if !mod_z.is_valid() || !mod_z.is_object() || !mod_z.method_exists(method_name) {
		return
	}
	if app_z.is_valid() && app_z.is_object() {
		vphp.with_method_result_zval(mod_z, method_name, [app_z], fn (_ vphp.ZVal) bool {
			return true
		})
		return
	}
	vphp.with_method_result_zval(mod_z, method_name, []vphp.ZVal{}, fn (_ vphp.ZVal) bool {
		return true
	})
}

fn call_module_first_supported_lifecycle(mod_z vphp.ZVal, method_names []string, app_z vphp.ZVal) ! {
	for method_name in method_names {
		if !mod_z.method_exists(method_name) {
			continue
		}
		call_module_lifecycle(mod_z, method_name, app_z)!
		return
	}
}

fn bootstrap_module_values(value vphp.ZVal) ![]vphp.ZVal {
	normalized := psr16_iterable_to_array(value)!
	return normalized.fold[[]vphp.ZVal]([]vphp.ZVal{}, fn (_ vphp.ZVal, item vphp.ZVal, mut acc []vphp.ZVal) {
		acc << item
	})
}

fn register_module_providers(mut app VSlimApp, mod_z vphp.ZVal, app_z vphp.ZVal) ! {
	if !mod_z.is_valid() || !mod_z.is_object() || !mod_z.method_exists('providers') {
		return
	}
	ok := if app_z.is_valid() && app_z.is_object() {
		vphp.with_method_result_zval(mod_z, 'providers', [app_z], fn [mut app] (providers_raw vphp.ZVal) bool {
			items := bootstrap_provider_values(providers_raw) or { return false }
			for item in items {
				provider_z := normalize_service_provider_input(item) or { return false }
				register_service_provider_zval(mut app, provider_z) or { return false }
			}
			return true
		})
	} else {
		vphp.with_method_result_zval(mod_z, 'providers', []vphp.ZVal{}, fn [mut app] (providers_raw vphp.ZVal) bool {
			items := bootstrap_provider_values(providers_raw) or { return false }
			for item in items {
				provider_z := normalize_service_provider_input(item) or { return false }
				register_service_provider_zval(mut app, provider_z) or { return false }
			}
			return true
		})
	}
	if !ok {
		return error('failed to resolve module providers')
	}
}

fn boot_module_zval(mut app VSlimApp, mod_z vphp.ZVal) ! {
	app_z := app_self_zval(&app)
	bind_module_to_app(mod_z, app_z)
	call_module_first_supported_lifecycle(mod_z, ['middleware', 'middlewares'], app_z)!
	call_module_first_supported_lifecycle(mod_z, ['routes'], app_z)!
	call_module_lifecycle(mod_z, 'boot', app_z)!
}

fn register_module_zval(mut app VSlimApp, module_z vphp.ZVal) ! {
	ensure_module_registry(mut app)
	app_z := app_self_zval(&app)
	class_key := module_class_key(module_z)
	if class_key == '' {
		return error('module class name must not be empty')
	}
	if class_key in app.module_classes {
		return
	}
	bind_module_to_app(module_z, app_z)
	call_module_lifecycle(module_z, 'register', app_z)!
	register_module_providers(mut app, module_z, app_z)!
	retained := vphp.RetainedObject.from_zval(module_z) or {
		return error('module "${class_key}" could not be retained')
	}
	app.modules << retained
	app.module_classes[class_key] = true
	if app.booted {
		boot_module_zval(mut app, module_z)!
	}
}

@[php_arg_name: 'mod_input=modInput']
@[php_method: 'module']
pub fn (mut app VSlimApp) mount_module(mod_input vphp.RequestBorrowedZBox) &VSlimApp {
	module_z := normalize_module_input(mod_input.to_zval()) or {
		vphp.throw_exception_class('InvalidArgumentException', err.msg(), 0)
		return &app
	}
	register_module_zval(mut app, module_z) or {
		vphp.throw_exception_class('RuntimeException', err.msg(), 0)
		return &app
	}
	return &app
}

@[php_method: 'moduleMany']
pub fn (mut app VSlimApp) module_many(modules vphp.PhpIterable) &VSlimApp {
	items := bootstrap_module_values(modules.to_zval()) or {
		vphp.throw_exception_class('InvalidArgumentException', 'modules must be iterable',
			0)
		return &app
	}
	for item in items {
		module_z := normalize_module_input(item) or {
			vphp.throw_exception_class('InvalidArgumentException', err.msg(), 0)
			return &app
		}
		register_module_zval(mut app, module_z) or {
			vphp.throw_exception_class('RuntimeException', err.msg(), 0)
			return &app
		}
	}
	return &app
}

@[php_method: 'moduleCount']
pub fn (app &VSlimApp) module_count() int {
	return app.modules.len
}

@[php_arg_name: 'class_name=className']
@[php_method: 'hasModule']
pub fn (app &VSlimApp) has_module(class_name string) bool {
	return class_name.trim_space() in app.module_classes
}
