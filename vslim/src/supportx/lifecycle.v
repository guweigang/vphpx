module supportx

import registrationx
import loggerx
import vphp

pub fn input_value(raw vphp.PhpValue, kind string) !vphp.PhpValue {
	if raw.is_valid() && raw.is_object() {
		return raw.owned()
	}
	if raw.is_valid() && raw.is_string() {
		return class_instance_value(raw.to_string(), kind)
	}
	return error('${kind} must be an object or class-string')
}

pub fn class_instance_value(raw_class_name string, kind string) !vphp.PhpValue {
	class_name := raw_class_name.trim_space()
	if class_name == '' {
		return error('${kind} class name must not be empty')
	}
	mut scope := registrationx.begin_registration_scope()
	defer {
		scope.finish()
	}
	mut class_arg := vphp.PhpString.of(class_name)
	mut autoload_arg := vphp.PhpBool.of(true)
	defer {
		class_arg.release()
		autoload_arg.release()
	}
	exists := vphp.PhpFunction.named('class_exists').result_bool(class_arg, autoload_arg)
	if vphp.has_exception() {
		return error('${kind} class lookup failed')
	}
	if !exists {
		log_class_visibility(kind, class_name)
		return error('${kind} class "${class_name}" does not exist')
	}
	mut object := vphp.PhpClass.named(class_name).construct() or {
		return error('${kind} class "${class_name}" could not be constructed')
	}
	if vphp.has_exception() {
		object.release()
		return error('${kind} constructor failed')
	}
	return object.take_value()
}

pub fn bind_to_app(value vphp.PhpValue, app_value vphp.PhpValue) {
	obj := value.require_object() or { return }
	bind_lifecycle_object(obj, app_value) or { return }
}

pub fn bind_lifecycle_object(obj vphp.PhpObject, app_value vphp.PhpValue) ! {
	if !app_value.is_valid() || !app_value.is_object() {
		return
	}
	if _ := obj.method_required_params('setApp') {
		mut scope := registrationx.begin_registration_scope()
		defer {
			scope.finish()
		}
		obj.with_method_result[vphp.PhpValue, bool]('setApp', ignore_lifecycle_result, app_value) or { false }
		if vphp.has_exception() {
			return error('setApp callback failed')
		}
	}
}

fn ignore_lifecycle_result(_ vphp.PhpValue) bool {
	return true
}

pub fn call_lifecycle_if_present(obj vphp.PhpObject, method_name string, app_value vphp.PhpValue) !bool {
	required := obj.method_required_params(method_name) or { return false }
	mut scope := registrationx.begin_registration_scope()
	defer {
		scope.finish()
	}
	mut args := []vphp.PhpArgInput{}
	if required > 0 && app_value.is_valid() && app_value.is_object() {
		args << app_value
	}
	obj.with_method_result[vphp.PhpValue, bool](method_name, ignore_lifecycle_result, ...args) or { false }
	if vphp.has_exception() {
		return error('${method_name} callback failed')
	}
	return true
}

pub fn module_provider_input(obj vphp.PhpObject, app_value vphp.PhpValue) !vphp.PhpValue {
	_ := obj.method_required_params('providers') or { return vphp.PhpValue.invalid() }
	mut args := []vphp.PhpArgInput{}
	if app_value.is_valid() && app_value.is_object() {
		args << app_value
	}
	mut scope := registrationx.begin_registration_scope()
	mut result := obj.with_method_result[vphp.PhpValue, vphp.PhpValue]('providers', fn (value vphp.PhpValue) vphp.PhpValue {
		return value.owned()
	}, ...args) or {
		scope.finish()
		if vphp.has_exception() {
			return err
		}
		return vphp.PhpValue.invalid()
	}
	// Settle the callback before App starts registering the returned providers.
	scope.finish()
	if vphp.has_exception() {
		result.release()
		return error('module providers callback failed')
	}
	if !result.is_valid() {
		return error('failed to resolve module providers')
	}
	return result
}

fn included_hits(class_name string) []string {
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

fn log_class_visibility(kind string, class_name string) {
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
	hits := included_hits(class_name)
	loggerx.cli_debug_log('${kind}_class_visibility class="${class_name}" exists_no_autoload=${exists_no_autoload} exists_autoload=${exists_autoload} included_hits=${hits}')
}
