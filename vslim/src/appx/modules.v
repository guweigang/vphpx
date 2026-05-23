module appx

import supportx
import vphp

fn (mut app VSlimApp) ensure_module_registry() {
	if app.module_classes.len == 0 {
		app.module_classes = map[string]bool{}
	}
}

fn normalize_module_class(raw_class_name string) !vphp.PhpValue {
	return supportx.class_instance_value(raw_class_name, 'module')
}

fn (mut app VSlimApp) register_module_values(modules vphp.PhpIterable) ! {
	mut normalized := modules.to_array()!
	defer {
		normalized.release()
	}
	for item in normalized.value_items() {
		mut module_value := supportx.input_value(item, 'module')!
		defer {
			module_value.release()
		}
		app.register_module_value(module_value)!
	}
}

fn (mut app VSlimApp) register_module_providers(mod_value vphp.PhpValue, app_value vphp.PhpValue) ! {
	mut providers_raw := supportx.call_value_method(mod_value, 'providers', app_value) or { return }
	defer {
		providers_raw.release()
	}
	providers := providers_raw.as_iterable() or {
		return error('failed to resolve module providers')
	}
	app.register_service_provider_values(providers)!
}

fn (mut app VSlimApp) boot_module_value(mod_value vphp.PhpValue) ! {
	mut app_value := (&app).self_value()
	supportx.bind_to_app(mod_value, app_value)
	supportx.call_first_supported_lifecycle(mod_value, ['middleware', 'middlewares'], app_value)!
	supportx.call_first_supported_lifecycle(mod_value, ['routes'], app_value)!
	supportx.call_lifecycle(mod_value, 'boot', app_value)!
}

fn (mut app VSlimApp) register_module_value(module_value vphp.PhpValue) ! {
	app.ensure_module_registry()
	mut app_value := (&app).self_value()
	class_key := supportx.class_key(module_value)
	if class_key == '' {
		return error('module class name must not be empty')
	}
	if class_key in app.module_classes {
		return
	}
	supportx.bind_to_app(module_value, app_value)
	supportx.call_lifecycle(module_value, 'register', app_value)!
	app.register_module_providers(module_value, app_value)!
	mod_obj := module_value.as_object() or {
		return error('module "${class_key}" could not be retained')
	}
	app.modules << mod_obj.retain()
	app.module_classes[class_key] = true
	if app.booted {
		app.boot_module_value(module_value)!
	}
}

fn (mut app VSlimApp) register_module_class(class_name string) ! {
	mut module_value := normalize_module_class(class_name)!
	defer {
		module_value.release()
	}
	app.register_module_value(module_value)!
}

@[php_arg_name: 'mod_input=modInput']
@[php_method: 'module']
pub fn (mut app VSlimApp) mount_module(mod_input vphp.PhpValue) &VSlimApp {
	mut module_value := supportx.input_value(mod_input, 'module') or {
		vphp.PhpException.raise_class('InvalidArgumentException', err.msg(), 0)
		return &app
	}
	defer {
		module_value.release()
	}
	app.register_module_value(module_value) or {
		vphp.PhpException.raise_class('RuntimeException', err.msg(), 0)
		return &app
	}
	return &app
}

@[php_method: 'moduleMany']
pub fn (mut app VSlimApp) module_many(modules vphp.PhpIterable) &VSlimApp {
	app.register_module_values(modules) or {
		vphp.PhpException.raise_class('InvalidArgumentException', 'modules must be iterable', 0)
		return &app
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
