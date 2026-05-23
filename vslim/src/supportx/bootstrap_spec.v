module supportx

import vphp

pub fn bootstrap_file_return_error(path string) string {
	return 'bootstrap file "${path}" must return iterable spec, callable, or VSlim\\App'
}

pub fn iterable_array(raw vphp.PhpValue) !vphp.PhpArray {
	if !raw.is_valid() || raw.is_null() || raw.is_undef() {
		return error('value must be iterable')
	}
	iter := raw.as_iterable() or { return error('value must be iterable') }
	return iter.to_array()!
}

pub fn normalize_app_bootstrap_spec(raw vphp.PhpValue) !vphp.PhpArray {
	return iterable_array(raw) or { return error('bootstrap spec must be iterable') }
}

pub fn normalize_app_bootstrap_iterable(raw vphp.PhpIterable) !vphp.PhpArray {
	return raw.to_array() or { return error('bootstrap spec must be iterable') }
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

fn call_bootstrap_callable_item(value vphp.PhpValue, app_value vphp.PhpValue, label string) ! {
	callable := vphp.PhpCallable.from_value(value) or {
		return error('bootstrap ${label} entries must be callable')
	}
	callable.with_result[vphp.PhpValue, bool](fn (result vphp.PhpValue) bool {
		return result.is_valid()
	}, app_value) or { false }
}

fn call_bootstrap_callable_items(raw vphp.PhpValue, app_value vphp.PhpValue, label string) ! {
	if raw.is_valid() && raw.is_callable() {
		call_bootstrap_callable_item(raw, app_value, label)!
		return
	}
	iter := raw.as_iterable() or {
		return error('bootstrap ${label} must be callable or callable list')
	}
	mut normalized := iter.to_array()!
	defer {
		normalized.release()
	}
	for item in normalized.value_items() {
		call_bootstrap_callable_item(item, app_value, label)!
	}
}

pub fn (subject AppBootstrapSpec) call_hooks(keys []string, app_value vphp.PhpValue, label string) ! {
	raw := subject.lookup(keys) or { return }
	call_bootstrap_callable_items(raw, app_value, label)!
}
