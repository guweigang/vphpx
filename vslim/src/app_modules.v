module main

import vphp

fn (mut app VSlimApp) ensure_module_registry() {
	if app.module_classes.len == 0 {
		app.module_classes = map[string]bool{}
	}
}

fn (subject PhpValueSubject) module_input() !vphp.PhpValue {
	raw := subject.value
	if raw.is_valid() && raw.is_object() {
		return raw.owned()
	}
	if raw.is_valid() && raw.is_string() {
		return normalize_module_class(raw.to_string())
	}
	return error('module must be an object or class-string')
}

fn normalize_module_class(raw_class_name string) !vphp.PhpValue {
	class_name := raw_class_name.trim_space()
	if class_name == '' {
		return error('module class name must not be empty')
	}
	mut class_arg := vphp.PhpString.of(class_name)
	mut autoload_arg := vphp.PhpBool.of(true)
	defer {
		class_arg.release()
		autoload_arg.release()
	}
	exists := vphp.PhpFunction.named('class_exists').result_bool(class_arg, autoload_arg)
	if !exists {
		log_bootstrap_class_visibility('module', class_name)
		return error('module class "${class_name}" does not exist')
	}
	mut mod_obj := vphp.PhpClass.named(class_name).construct() or {
		return error('module class "${class_name}" could not be constructed')
	}
	return mod_obj.take_value()
}

fn (subject PhpValueSubject) module_class_key() string {
	mod_value := subject.value
	return mod_value.class_name().trim_space()
}

fn (subject PhpValueSubject) bind_module_to_app(app_value vphp.PhpValue) {
	mod_value := subject.value
	if !mod_value.is_valid() || !mod_value.is_object() || !app_value.is_valid()
		|| !app_value.is_object() {
		return
	}
	if mod_value.method_exists('setApp') {
		mod_value.require_object() or { return }.with_method_result[vphp.PhpValue, bool]('setApp', fn (_ vphp.PhpValue) bool {
			return true
		}, app_value) or { false }
	}
}

fn object_method_required_params(obj vphp.PhpObject, method_name string) int {
	mut method_arg := vphp.PhpString.of(method_name)
	defer {
		method_arg.release()
	}
	ref := vphp.PhpClass.named('ReflectionMethod').construct(obj, method_arg) or {
		return 0
	}
	count := ref.method[vphp.PhpInt]('getNumberOfRequiredParameters') or { return 0 }
	return count.to_int()
}

fn (subject PhpValueSubject) call_module_lifecycle(method_name string, app_value vphp.PhpValue) ! {
	mod_value := subject.value
	if !mod_value.is_valid() || !mod_value.is_object() || !mod_value.method_exists(method_name) {
		return
	}
	obj := mod_value.require_object() or { return }
	if object_method_required_params(obj, method_name) > 0 && app_value.is_valid()
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

fn (subject PhpValueSubject) call_first_supported_module_lifecycle(method_names []string, app_value vphp.PhpValue) ! {
	mod_value := subject.value
	for method_name in method_names {
		if !mod_value.method_exists(method_name) {
			continue
		}
		subject.call_module_lifecycle(method_name, app_value)!
		return
	}
}

fn (mut app VSlimApp) register_module_values(modules vphp.PhpIterable) ! {
	mut normalized := modules.to_array()!
	defer {
		normalized.release()
	}
	for item in normalized.value_items() {
		mut module_value := value_subject(item).module_input()!
		defer {
			module_value.release()
		}
		app.register_module_value(module_value)!
	}
}

fn (mut app VSlimApp) register_module_providers(mod_value vphp.PhpValue, app_value vphp.PhpValue) ! {
	if !mod_value.is_valid() || !mod_value.is_object() || !mod_value.method_exists('providers') {
		return
	}
	mod_obj := mod_value.require_object() or { return }
	ok := if app_value.is_valid() && app_value.is_object() {
		mod_obj.with_method_result[vphp.PhpValue, bool]('providers', fn [mut app] (providers_raw vphp.PhpValue) bool {
			providers := providers_raw.as_iterable() or { return false }
			app.register_service_provider_values(providers) or { return false }
			return true
		}, app_value) or { false }
	} else {
		mod_obj.with_method_result[vphp.PhpValue, bool]('providers', fn [mut app] (providers_raw vphp.PhpValue) bool {
			providers := providers_raw.as_iterable() or { return false }
			app.register_service_provider_values(providers) or { return false }
			return true
		}) or { false }
	}
	if !ok {
		return error('failed to resolve module providers')
	}
}

fn (mut app VSlimApp) boot_module_value(mod_value vphp.PhpValue) ! {
	mut app_value := (&app).self_value()
	mod_subject := value_subject(mod_value)
	mod_subject.bind_module_to_app(app_value)
	mod_subject.call_first_supported_module_lifecycle(['middleware', 'middlewares'], app_value)!
	mod_subject.call_first_supported_module_lifecycle(['routes'], app_value)!
	mod_subject.call_module_lifecycle('boot', app_value)!
}

fn (mut app VSlimApp) register_module_value(module_value vphp.PhpValue) ! {
	app.ensure_module_registry()
	mut app_value := (&app).self_value()
	module_subject := value_subject(module_value)
	class_key := module_subject.module_class_key()
	if class_key == '' {
		return error('module class name must not be empty')
	}
	if class_key in app.module_classes {
		return
	}
	module_subject.bind_module_to_app(app_value)
	module_subject.call_module_lifecycle('register', app_value)!
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
	mut module_value := value_subject(mod_input).module_input() or {
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
