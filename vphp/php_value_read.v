module vphp

pub fn (v PhpValue) value_at(key string) PhpValue {
	return PhpValue.from_zval(v.to_zval().value_at(key))
}

pub fn (v PhpValue) value(key string) !PhpValue {
	out := v.value_at(key)
	if !out.is_valid() || out.is_undef() {
		return error('key "${key}" not found')
	}
	return out
}

pub fn (v PhpValue) property_exists(name string) bool {
	mut copy := v.to_request_owned()
	defer { copy.release() }
	mut obj := copy.as_object() or { return false }
	defer { obj.release() }
	return obj.property_exists(name)
}

pub fn (v PhpValue) prop_value(name string) PhpValue {
	mut copy := v.to_request_owned()
	defer { copy.release() }
	mut obj := copy.as_object() or { return PhpValue.null() }
	defer { obj.release() }
	return obj.prop_value(name)
}

pub fn (v PhpValue) call_method(method string, args ...PhpArgInput) PhpValue {
	mut copy := v.to_request_owned()
	defer { copy.release() }
	mut obj := copy.as_object() or { return PhpValue.null() }
	defer { obj.release() }
	return obj.call_method(method, ...args)
}

pub fn (v PhpValue) [] (key string) PhpValue {
	return v.value_at(key)
}

pub fn (v PhpValue) string_at(key string, default_value string) string {
	return v.to_zval().string_at(key, default_value)
}

pub fn (v PhpValue) raw_string_at(key string, default_value string) string {
	return v.to_zval().raw_string_at(key, default_value)
}

pub fn (v PhpValue) int_at(key string, default_value int) int {
	return v.to_zval().int_at(key, default_value)
}

pub fn (v PhpValue) bool_at(key string, default_value bool) bool {
	return v.to_zval().bool_at(key, default_value)
}

pub fn (v PhpValue) count() int {
	if arr := v.as_array() {
		return arr.count()
	}
	return 0
}

pub fn (v PhpValue) index_value(index int) PhpValue {
	if arr := v.as_array() {
		return arr.index_value(index)
	}
	return PhpValue.null()
}

pub fn (v PhpValue) to_string_list() []string {
	if arr := v.as_array() {
		return arr.to_string_list()
	}
	return v.to_zval().to_string_list()
}

pub fn (v PhpValue) to_string_map() map[string]string {
	if arr := v.as_array() {
		return arr.to_string_map()
	}
	return v.to_zval().to_string_map()
}
