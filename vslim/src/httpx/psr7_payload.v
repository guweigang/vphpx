module httpx

import vphp

fn psr7_default_value_or_null(default_value ?vphp.PhpValue) vphp.PhpValue {
	if actual_default := default_value {
		return actual_default.to_request_owned()
	}
	return vphp.PhpValue.null()
}

pub fn clone_assoc_payload_ref(value vphp.PhpArray) vphp.PhpArray {
	if !value.is_valid() {
		return empty_persistent_array()
	}
	return value.retain()
}

pub fn clone_assoc_payload_value(value vphp.PhpValue) vphp.PhpValue {
	if !value.is_valid() || value.is_undef() || value.is_null() {
		return empty_persistent_array_value()
	}
	return value.retain()
}

pub fn clone_parsed_body_ref(value vphp.PhpValue) vphp.PhpValue {
	if !value.is_valid() || value.is_undef() || value.is_null() {
		return persistent_null_value()
	}
	return value.retain()
}

pub fn string_map_to_persistent_array(values map[string]string) vphp.PhpArray {
	mut out := vphp.PhpArray.empty()
	for key, value in values {
		out.string(key, value)
	}
	persistent := out.retain()
	out.release()
	return persistent
}

fn psr7_persistent_array(value vphp.PhpArray) vphp.PhpArray {
	if !value.is_valid() {
		return vphp.PhpArray.new()
	}
	return value.to_request_owned()
}

fn psr7_persistent_array_value(value vphp.PhpValue) vphp.PhpArray {
	if !value.is_valid() || value.is_null() || value.is_undef() || !value.is_array() {
		return vphp.PhpArray.new()
	}
	mut arr := value.as_array() or { return vphp.PhpArray.new() }
	out := arr.to_request_owned()
	arr.release()
	return out
}

pub fn persistent_array_to_string_map(value vphp.PhpArray) map[string]string {
	if !value.is_valid() {
		return map[string]string{}
	}
	return value.with_array(fn (arr vphp.PhpArray) map[string]string {
		return arr.to_string_map()
	})
}

pub fn empty_persistent_array() vphp.PhpArray {
	mut out := vphp.PhpArray.empty()
	persistent := out.retain()
	out.release()
	return persistent
}

pub fn empty_persistent_array_value() vphp.PhpValue {
	mut out := vphp.PhpArray.empty()
	persistent := out.retain().to_value()
	out.release()
	return persistent
}

pub fn persistent_null_value() vphp.PhpValue {
	return vphp.PhpValue.persistent_null()
}

pub fn persistent_array_value_owned(value vphp.PhpValue) vphp.PhpArray {
	if arr := value.as_array() {
		return arr.retain()
	}
	return empty_persistent_array()
}

pub fn persistent_value_assoc_with_value(value vphp.PhpValue, key string, child vphp.PhpArgInput) vphp.PhpValue {
	mut out := vphp.PhpArray.new()
	if key == '' {
		persistent := out.retain().to_value()
		out.release()
		return persistent
	}
	value.with_value(fn [mut out] (raw_value vphp.PhpValue) bool {
		if arr := raw_value.as_array() {
			arr.fold_values[[]int]([]int{}, fn [mut out] (entry_key vphp.PhpValue, entry_value vphp.PhpValue, mut _ []int) {
				out.set_value(entry_key.to_string(), entry_value)
			})
		}
		return true
	})
	out.set(key, child)
	persistent := out.retain().to_value()
	out.release()
	return persistent
}

pub fn persistent_assoc_without_key(value vphp.PhpArray, key string) vphp.PhpArray {
	mut out := vphp.PhpArray.new()
	if value.is_valid() {
		value.with_array(fn [mut out, key] (arr vphp.PhpArray) bool {
			arr.fold_values[[]int]([]int{}, fn [mut out, key] (entry_key vphp.PhpValue, entry_value vphp.PhpValue, mut _ []int) {
				name := entry_key.to_string()
				if name != key {
					out.set_value(name, entry_value)
				}
			})
			return true
		})
	}
	persistent := out.retain()
	out.release()
	return persistent
}

pub fn persistent_value_assoc_without_key(value vphp.PhpValue, key string) vphp.PhpValue {
	mut out := vphp.PhpArray.new()
	value.with_value(fn [mut out, key] (raw_value vphp.PhpValue) bool {
		if arr := raw_value.as_array() {
			arr.fold_values[[]int]([]int{}, fn [mut out, key] (entry_key vphp.PhpValue, entry_value vphp.PhpValue, mut _ []int) {
				name := entry_key.to_string()
				if name != key {
					out.set_value(name, entry_value)
				}
			})
		}
		return true
	})
	persistent := out.retain().to_value()
	out.release()
	return persistent
}

fn is_valid_psr7_parsed_body_value(value vphp.PhpValue) bool {
	if !value.is_valid() || value.is_null() || value.is_undef() {
		return true
	}
	return value.is_array() || value.is_object()
}
