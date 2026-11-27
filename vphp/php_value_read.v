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
	return v.with_object[bool](fn [name] (obj PhpObject) bool {
		return obj.property_exists(name)
	}) or { false }
}

pub fn (v PhpValue) prop_value(name string) PhpValue {
	return v.with_object[PhpValue](fn [name] (obj PhpObject) PhpValue {
		return obj.prop_value(name)
	}) or { PhpValue.null() }
}

pub fn (v PhpValue) call_method(method string, args ...PhpArgInput) PhpValue {
	return v.with_object[PhpValue](fn [method, args] (obj PhpObject) PhpValue {
		return obj.call_method(method, ...args)
	}) or { PhpValue.null() }
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
