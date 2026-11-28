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
	mut out := if key == '' {
		vphp.PhpArray.new()
	} else {
		value.with_array(fn (arr vphp.PhpArray) vphp.PhpArray {
			return arr.owned()
		}) or { vphp.PhpArray.new() }
	}
	if key != '' {
		out.set(key, child)
	}
	mut updated := out.take_value()
	defer {
		updated.release()
	}
	return updated.retain()
}

pub fn persistent_assoc_without_key(value vphp.PhpArray, key string) vphp.PhpArray {
	mut out := value.owned()
	defer {
		out.release()
	}
	out.remove(key)
	return out.retain()
}

pub fn persistent_value_assoc_without_key(value vphp.PhpValue, key string) vphp.PhpValue {
	mut request_value := value.to_request_owned()
	defer { request_value.release() }
	mut arr := request_value.as_array() or { return empty_persistent_array_value() }
	defer { arr.release() }
	mut out := persistent_assoc_without_key(arr, key)
	defer {
		out.release()
	}
	return out.to_value()
}

fn is_valid_psr7_parsed_body_value(value vphp.PhpValue) bool {
	if !value.is_valid() || value.is_null() || value.is_undef() {
		return true
	}
	return value.is_array() || value.is_object()
}
