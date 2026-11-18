module supportx

import registrationx
import vphp

pub fn bootstrap_file_return_error(path string) string {
	return 'bootstrap file "${path}" must return iterable spec, callable, or VSlim\\App'
}

fn has_bootstrap_value(value vphp.PhpValue) bool {
	return value.is_valid() && !value.is_null() && !value.is_undef()
}

pub fn (mut progress BootstrapProgress) evaluate_file_spec(value vphp.PhpValue, receiver_class string, invalid_return string, receiver fn () vphp.PhpValue) !vphp.PhpValue {
	if saved := progress.value('file:result') {
		return saved
	}
	mut result := evaluate_bootstrap_file_value(value, receiver_class, invalid_return, receiver)!
	if vphp.has_exception() {
		result.release()
		return error('bootstrap callback failed')
	}
	if result.is_valid() {
		progress.remember('file:result', result)
	}
	return result
}

// Keep the file's value borrowed. A callable result is owned by the caller.
fn evaluate_bootstrap_file_value(value vphp.PhpValue, receiver_class string, invalid_return string, receiver fn () vphp.PhpValue) !vphp.PhpValue {
	if !has_bootstrap_value(value) {
		return error(invalid_return)
	}
	mut result := value.borrowed()
	if mut callable := value.as_callable() {
		mut scope := registrationx.begin_registration_scope()
		defer {
			scope.finish()
		}
		defer {
			callable.release()
		}
		mut app := receiver()
		defer {
			app.release()
		}
		result = callable.invoke(app)
	}
	if !has_bootstrap_value(result) || (result.is_object() && result.is_instance_of(receiver_class)) {
		result.release()
		return vphp.PhpValue.invalid()
	}
	return result
}

pub fn normalize_app_bootstrap_spec(raw vphp.PhpValue) !vphp.PhpArray {
	iter := raw.as_iterable() or { return error('bootstrap spec must be iterable') }
	return normalize_app_bootstrap_iterable(iter)
}

pub fn normalize_app_bootstrap_iterable(raw vphp.PhpIterable) !vphp.PhpArray {
	normalized, _ := evaluate_bootstrap_iterable(raw)!
	return normalized
}

fn evaluate_bootstrap_iterable(raw vphp.PhpIterable) !(vphp.PhpArray, bool) {
	mut scope := registrationx.begin_registration_scope()
	defer {
		scope.finish()
	}
	normalized := raw.to_array() or { return error('bootstrap spec must be iterable') }
	// A service snapshot may also cover a mutation made directly by PHP.
	return normalized, !scope.has_changes()
}

pub struct AppBootstrapSpec {
	spec vphp.PhpArray
}

pub fn app_bootstrap_spec(spec vphp.PhpArray) AppBootstrapSpec {
	return AppBootstrapSpec{
		spec: spec
	}
}

pub fn (subject AppBootstrapSpec) lookup(keys []string) ?vphp.PhpValue {
	for key in keys {
		if key.trim_space() == '' {
			continue
		}
		value := subject.spec.value(key) or { continue }
		if !value.is_valid() || value.is_undef() {
			continue
		}
		return value
	}
	return none
}

pub fn (subject AppBootstrapSpec) string(keys []string) ?string {
	value := subject.lookup(keys) or { return none }
	if value.is_null() || value.is_undef() {
		return none
	}
	text := value.to_string().trim_space()
	if text == '' {
		return none
	}
	return text
}

pub fn (subject AppBootstrapSpec) bool(keys []string) ?bool {
	value := subject.lookup(keys) or { return none }
	return bootstrap_bool(value)
}

pub struct BootstrapBootOption {
	value ?vphp.PhpValue
}

pub fn (subject AppBootstrapSpec) boot_option() BootstrapBootOption {
	return BootstrapBootOption{
		value: subject.lookup(['boot'])
	}
}

pub fn (option BootstrapBootOption) is_present() bool {
	return option.value != none
}

pub fn (option BootstrapBootOption) enabled() bool {
	value := option.value or { return false }
	return bootstrap_bool(value) or { false }
}

fn bootstrap_bool(value vphp.PhpValue) ?bool {
	if value.is_null() || value.is_undef() {
		return none
	}
	if value.is_bool() {
		return value.to_bool()
	}
	if value.is_long() {
		return value.to_i64() != 0
	}
	raw := value.to_string().trim_space().to_lower()
	if raw == '' {
		return none
	}
	return raw in ['1', 'true', 'yes', 'on']
}

pub fn require_native_bootstrap_object[T](value vphp.PhpValue, class_name string, label string) !&T {
	if !value.is_valid() || !value.is_object() || !value.is_instance_of(class_name) {
		return error('bootstrap ${label} must be ${class_name}')
	}
	obj := value.to_v_object[T]() or {
		return error('bootstrap ${label} must be a native ${class_name} object')
	}
	return obj
}

pub fn call_bootstrap_callable_item(value vphp.PhpValue, app_value vphp.PhpValue, label string) ! {
	mut scope := registrationx.begin_registration_scope()
	defer {
		scope.finish()
	}
	callable := vphp.PhpCallable.from_value(value) or {
		return error('bootstrap ${label} entries must be callable')
	}
	callable.with_result[vphp.PhpValue, bool](fn (result vphp.PhpValue) bool {
		return result.is_valid()
	}, app_value) or { false }
	if vphp.has_exception() {
		return error('bootstrap ${label} callback failed')
	}
}

fn call_bootstrap_callable_items(raw vphp.PhpValue, app_value vphp.PhpValue, label string, step string, mut progress BootstrapProgress) ! {
	if progress.done(step) {
		return
	}
	if raw.is_valid() && raw.is_callable() {
		call_bootstrap_callable_item(raw, app_value, label)!
		progress.complete(step)
		return
	}
	iter := raw.as_iterable() or {
		return error('bootstrap ${label} must be callable or callable list')
	}
	mut normalized := progress.normalize(step + ':list', iter)!
	defer {
		normalized.release()
	}
	if vphp.has_exception() {
		return error('bootstrap ${label} list evaluation failed')
	}
	for index, item in normalized.value_items() {
		item_step := '${step}:item:${index}'
		if progress.done(item_step) {
			continue
		}
		call_bootstrap_callable_item(item, app_value, label)!
		progress.complete(item_step)
	}
	progress.complete(step)
}

pub fn (subject AppBootstrapSpec) call_hooks(keys []string, app_value vphp.PhpValue, label string, step string, mut progress BootstrapProgress) ! {
	raw := subject.lookup(keys) or { return }
	call_bootstrap_callable_items(raw, app_value, label, step, mut progress)!
}
