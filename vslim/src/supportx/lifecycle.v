module supportx

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
	mut class_arg := vphp.PhpString.of(class_name)
	mut autoload_arg := vphp.PhpBool.of(true)
	defer {
		class_arg.release()
		autoload_arg.release()
	}
	exists := vphp.PhpFunction.named('class_exists').result_bool(class_arg, autoload_arg)
	if !exists {
		log_class_visibility(kind, class_name)
		return error('${kind} class "${class_name}" does not exist')
	}
	mut object := vphp.PhpClass.named(class_name).construct() or {
		return error('${kind} class "${class_name}" could not be constructed')
	}
	return object.take_value()
}

pub fn class_key(value vphp.PhpValue) string {
	return value.class_name().trim_space()
}

pub fn bind_to_app(value vphp.PhpValue, app_value vphp.PhpValue) {
	if !value.is_valid() || !value.is_object() || !app_value.is_valid() || !app_value.is_object() {
		return
	}
	if value.method_exists('setApp') {
		value.require_object() or { return }.with_method_result[vphp.PhpValue, bool]('setApp', fn (_ vphp.PhpValue) bool {
			return true
		}, app_value) or { false }
	}
}

pub fn call_lifecycle(value vphp.PhpValue, method_name string, app_value vphp.PhpValue) ! {
	if !value.is_valid() || !value.is_object() || !value.method_exists(method_name) {
		return
	}
	obj := value.require_object() or { return }
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

pub fn call_first_supported_lifecycle(value vphp.PhpValue, method_names []string, app_value vphp.PhpValue) ! {
	for method_name in method_names {
		if !value.method_exists(method_name) {
			continue
		}
		call_lifecycle(value, method_name, app_value)!
		return
	}
}

pub fn call_value_method(value vphp.PhpValue, method_name string, app_value vphp.PhpValue) ?vphp.PhpValue {
	if !value.is_valid() || !value.is_object() || !value.method_exists(method_name) {
		return none
	}
	obj := value.require_object() or { return none }
	if app_value.is_valid() && app_value.is_object() {
		return obj.with_method_result[vphp.PhpValue, vphp.PhpValue](method_name, fn (result vphp.PhpValue) vphp.PhpValue {
			return result.owned()
		}, app_value) or { return none }
	}
	return obj.with_method_result[vphp.PhpValue, vphp.PhpValue](method_name, fn (result vphp.PhpValue) vphp.PhpValue {
		return result.owned()
	}) or { return none }
}

fn object_method_required_params(obj vphp.PhpObject, method_name string) int {
	mut method_arg := vphp.PhpString.of(method_name)
	defer {
		method_arg.release()
	}
	ref := vphp.PhpClass.named('ReflectionMethod').construct(obj, method_arg) or { return 0 }
	count := ref.method[vphp.PhpInt]('getNumberOfRequiredParameters') or { return 0 }
	return count.to_int()
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
