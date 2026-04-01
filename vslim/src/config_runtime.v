module main

import strings
import toml
import vphp

@[php_method]
pub fn (mut c VSlimConfig) construct() &VSlimConfig {
	c.path = ''
	c.loaded = false
	c.root = toml.null
	return &c
}

@[php_method]
pub fn (mut c VSlimConfig) load(path string) &VSlimConfig {
	doc := toml.parse_file(path) or {
		vphp.throw_exception_class('InvalidArgumentException', 'config load failed: ${err.msg()}',
			0)
		return &c
	}
	c.path = path
	c.loaded = true
	c.root = doc.to_any()
	return &c
}

@[php_method]
pub fn (mut c VSlimConfig) load_text(text string) &VSlimConfig {
	doc := toml.parse_text(text) or {
		vphp.throw_exception_class('InvalidArgumentException', 'config parse failed: ${err.msg()}',
			0)
		return &c
	}
	c.path = ''
	c.loaded = true
	c.root = doc.to_any()
	return &c
}

@[php_method]
pub fn (c &VSlimConfig) is_loaded() bool {
	return c.loaded
}

@[php_method]
pub fn (c &VSlimConfig) path() string {
	return c.path
}

@[php_method]
pub fn (c &VSlimConfig) has(key string) bool {
	return c.value_opt(key) != none
}

@[php_optional_args: 'default_value']
@[php_method]
pub fn (c &VSlimConfig) get_string(key string, default_value string) string {
	value := c.value_opt(key) or { return default_value }
	return value.string()
}

@[php_optional_args: 'default_value']
@[php_method]
pub fn (c &VSlimConfig) get_int(key string, default_value int) int {
	value := c.value_opt(key) or { return default_value }
	return value.int()
}

@[php_optional_args: 'default_value']
@[php_method]
pub fn (c &VSlimConfig) get_bool(key string, default_value bool) bool {
	value := c.value_opt(key) or { return default_value }
	return value.bool()
}

@[php_optional_args: 'default_value']
@[php_method]
pub fn (c &VSlimConfig) get_float(key string, default_value f64) f64 {
	value := c.value_opt(key) or { return default_value }
	return value.f64()
}

@[php_method]
pub fn (c &VSlimConfig) get_string_list(key string) []string {
	value := c.value_opt(key) or { return []string{} }
	arr := value.array()
	return arr.as_strings()
}

@[php_optional_args: 'default_json']
@[php_method]
pub fn (c &VSlimConfig) get_json(key string, default_json string) string {
	value := c.value_opt(key) or { return default_json }
	return toml_any_to_json(value)
}

@[php_optional_args: 'default_value']
@[php_method]
pub fn (c &VSlimConfig) get(key string, default_value vphp.BorrowedValue) vphp.Value {
	raw_default := default_value.to_zval()
	value := c.value_opt(key) or {
		if raw_default.is_valid() {
			return vphp.Value.from_zval(raw_default)
		}
		return vphp.Value.new_null()
	}
	return vphp.Value.from_zval(toml_any_to_zval(value))
}

@[php_optional_args: 'default_value']
@[php_method]
pub fn (c &VSlimConfig) get_map(key string, default_value vphp.BorrowedValue) vphp.Value {
	raw_default := default_value.to_zval()
	value := c.value_opt(key) or { return vphp.Value.from_zval(default_or_empty(raw_default)) }
	match value {
		map[string]toml.Any {
			return vphp.Value.from_zval(toml_map_to_zval(value))
		}
		else {
			return vphp.Value.from_zval(default_or_empty(raw_default))
		}
	}
}

@[php_optional_args: 'default_value']
@[php_method]
pub fn (c &VSlimConfig) get_list(key string, default_value vphp.BorrowedValue) vphp.Value {
	raw_default := default_value.to_zval()
	value := c.value_opt(key) or { return vphp.Value.from_zval(default_or_empty(raw_default)) }
	match value {
		[]toml.Any {
			return vphp.Value.from_zval(toml_list_to_zval(value))
		}
		else {
			return vphp.Value.from_zval(default_or_empty(raw_default))
		}
	}
}

@[php_method]
pub fn (c &VSlimConfig) all_json() string {
	if !c.loaded {
		return '{}'
	}
	return toml_any_to_json(c.root)
}

fn (c &VSlimConfig) value_opt(key string) ?toml.Any {
	if !c.loaded {
		return none
	}
	trimmed := key.trim_space()
	if trimmed == '' {
		return c.root
	}
	value := c.root.value(trimmed)
	if value is toml.Null {
		return none
	}
	return value
}

fn toml_any_to_json(value toml.Any) string {
	match value {
		toml.Null {
			return 'null'
		}
		bool {
			return if value { 'true' } else { 'false' }
		}
		int {
			return '${value}'
		}
		i64 {
			return '${value}'
		}
		u64 {
			return '${value}'
		}
		f32 {
			return '${value}'
		}
		f64 {
			return '${value}'
		}
		string {
			return vphp.json_encode(vphp.RequestOwnedZVal.new_string(value).to_zval())
		}
		toml.Date {
			return vphp.json_encode(vphp.RequestOwnedZVal.new_string(value.str()).to_zval())
		}
		toml.Time {
			return vphp.json_encode(vphp.RequestOwnedZVal.new_string(value.str()).to_zval())
		}
		toml.DateTime {
			return vphp.json_encode(vphp.RequestOwnedZVal.new_string(value.str()).to_zval())
		}
		map[string]toml.Any {
			return toml_map_to_json(value)
		}
		[]toml.Any {
			return toml_list_to_json(value)
		}
	}
	return 'null'
}

fn toml_json_string(value string) string {
	return vphp.json_encode(vphp.RequestOwnedZVal.new_string(value).to_zval())
}

fn toml_map_to_json(input map[string]toml.Any) string {
	mut sb := strings.new_builder(64)
	sb.write_string('{')
	mut is_first := true
	for key, item in input {
		if !is_first {
			sb.write_string(',')
		}
		sb.write_string(toml_json_string(key))
		sb.write_string(':')
		sb.write_string(toml_any_to_json(item))
		is_first = false
	}
	sb.write_string('}')
	return sb.str()
}

fn toml_list_to_json(input []toml.Any) string {
	mut sb := strings.new_builder(64)
	sb.write_string('[')
	for i, item in input {
		if i > 0 {
			sb.write_string(',')
		}
		sb.write_string(toml_any_to_json(item))
	}
	sb.write_string(']')
	return sb.str()
}

fn empty_array_zval() vphp.ZVal {
	mut out := vphp.RequestOwnedZVal.new_null().to_zval()
	out.array_init()
	return out
}

fn default_or_empty(default_value vphp.ZVal) vphp.ZVal {
	if default_value.is_valid() && !default_value.is_null() {
		return default_value
	}
	return empty_array_zval()
}

fn toml_any_to_zval(value toml.Any) vphp.ZVal {
	match value {
		toml.Null {
			return vphp.RequestOwnedZVal.new_null().to_zval()
		}
		bool {
			return vphp.RequestOwnedZVal.new_bool(value).to_zval()
		}
		int {
			return vphp.RequestOwnedZVal.new_int(value).to_zval()
		}
		i64 {
			return vphp.RequestOwnedZVal.new_int(value).to_zval()
		}
		u64 {
			return vphp.RequestOwnedZVal.new_int(i64(value)).to_zval()
		}
		f32 {
			return vphp.RequestOwnedZVal.new_float(f64(value)).to_zval()
		}
		f64 {
			return vphp.RequestOwnedZVal.new_float(value).to_zval()
		}
		string {
			return vphp.RequestOwnedZVal.new_string(value).to_zval()
		}
		toml.Date {
			return vphp.RequestOwnedZVal.new_string(value.str()).to_zval()
		}
		toml.Time {
			return vphp.RequestOwnedZVal.new_string(value.str()).to_zval()
		}
		toml.DateTime {
			return vphp.RequestOwnedZVal.new_string(value.str()).to_zval()
		}
		map[string]toml.Any {
			return toml_map_to_zval(value)
		}
		[]toml.Any {
			return toml_list_to_zval(value)
		}
	}
	return vphp.RequestOwnedZVal.new_null().to_zval()
}

fn toml_map_to_zval(input map[string]toml.Any) vphp.ZVal {
	mut out := vphp.RequestOwnedZVal.new_null().to_zval()
	out.array_init()
	for key, item in input {
		child := toml_any_to_zval(item)
		unsafe { C.vphp_array_add_assoc_zval(out.raw, &char(key.str), child.raw) }
	}
	return out
}

fn toml_list_to_zval(input []toml.Any) vphp.ZVal {
	mut out := vphp.RequestOwnedZVal.new_null().to_zval()
	out.array_init()
	for item in input {
		out.add_next_val(toml_any_to_zval(item))
	}
	return out
}

fn (c &VSlimConfig) free() {
	unsafe {
		c.path.free()
	}
}
