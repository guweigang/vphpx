module main

import os
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
	if os.is_dir(path) {
		return c.load_dir(path)
	}
	doc := toml.parse_file(path) or {
		vphp.PhpException.raise_class('InvalidArgumentException', 'config load failed: ${err.msg()}',
			0)
		return &c
	}
	root := resolve_config_env_any(doc.to_any()) or {
		vphp.PhpException.raise_class('InvalidArgumentException',
			'config env resolve failed: ${err.msg()}', 0)
		return &c
	}
	c.path = path
	c.loaded = true
	c.root = root
	return &c
}

@[php_method: 'loadDir']
pub fn (mut c VSlimConfig) load_dir(path string) &VSlimConfig {
	files := config_dir_files(path) or {
		vphp.PhpException.raise_class('InvalidArgumentException', 'config load failed: ${err.msg()}',
			0)
		return &c
	}
	mut root := toml.Any(toml.null)
	for file in files {
		doc := toml.parse_file(file) or {
			vphp.PhpException.raise_class('InvalidArgumentException',
				'config load failed: ${err.msg()}', 0)
			return &c
		}
		resolved := resolve_config_env_any(doc.to_any()) or {
			vphp.PhpException.raise_class('InvalidArgumentException',
				'config env resolve failed: ${err.msg()}', 0)
			return &c
		}
		root = merge_config_any(root, resolved)
	}
	c.path = path
	c.loaded = true
	c.root = root
	return &c
}

@[php_method: 'loadText']
pub fn (mut c VSlimConfig) load_text(text string) &VSlimConfig {
	doc := toml.parse_text(text) or {
		vphp.PhpException.raise_class('InvalidArgumentException', 'config parse failed: ${err.msg()}',
			0)
		return &c
	}
	root := resolve_config_env_any(doc.to_any()) or {
		vphp.PhpException.raise_class('InvalidArgumentException',
			'config env resolve failed: ${err.msg()}', 0)
		return &c
	}
	c.path = ''
	c.loaded = true
	c.root = root
	return &c
}

@[php_method: 'mergeFile']
pub fn (mut c VSlimConfig) merge_file(path string) &VSlimConfig {
	if os.is_dir(path) {
		return c.merge_dir(path)
	}
	doc := toml.parse_file(path) or {
		vphp.PhpException.raise_class('InvalidArgumentException', 'config load failed: ${err.msg()}',
			0)
		return &c
	}
	resolved := resolve_config_env_any(doc.to_any()) or {
		vphp.PhpException.raise_class('InvalidArgumentException',
			'config env resolve failed: ${err.msg()}', 0)
		return &c
	}
	c.merge_root(resolved)
	return &c
}

@[php_method: 'mergeDir']
pub fn (mut c VSlimConfig) merge_dir(path string) &VSlimConfig {
	files := config_dir_files(path) or {
		vphp.PhpException.raise_class('InvalidArgumentException', 'config load failed: ${err.msg()}',
			0)
		return &c
	}
	for file in files {
		doc := toml.parse_file(file) or {
			vphp.PhpException.raise_class('InvalidArgumentException',
				'config load failed: ${err.msg()}', 0)
			return &c
		}
		resolved := resolve_config_env_any(doc.to_any()) or {
			vphp.PhpException.raise_class('InvalidArgumentException',
				'config env resolve failed: ${err.msg()}', 0)
			return &c
		}
		c.merge_root(resolved)
	}
	return &c
}

@[php_method: 'mergeText']
pub fn (mut c VSlimConfig) merge_text(text string) &VSlimConfig {
	doc := toml.parse_text(text) or {
		vphp.PhpException.raise_class('InvalidArgumentException', 'config parse failed: ${err.msg()}',
			0)
		return &c
	}
	resolved := resolve_config_env_any(doc.to_any()) or {
		vphp.PhpException.raise_class('InvalidArgumentException',
			'config env resolve failed: ${err.msg()}', 0)
		return &c
	}
	c.merge_root(resolved)
	return &c
}

@[php_method: 'isLoaded']
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

@[php_arg_name: 'default_value=defaultValue']
@[php_arg_default: 'default_value=""']
@[php_arg_optional: 'default_value']
@[php_method: 'getString']
pub fn (c &VSlimConfig) get_string(key string, default_value string) string {
	value := c.value_opt(key) or { return default_value }
	return value.string()
}

@[php_arg_name: 'default_value=defaultValue']
@[php_arg_default: 'default_value=0']
@[php_arg_optional: 'default_value']
@[php_method: 'getInt']
pub fn (c &VSlimConfig) get_int(key string, default_value int) int {
	value := c.value_opt(key) or { return default_value }
	return value.int()
}

@[php_arg_name: 'default_value=defaultValue']
@[php_arg_default: 'default_value=false']
@[php_arg_optional: 'default_value']
@[php_method: 'getBool']
pub fn (c &VSlimConfig) get_bool(key string, default_value bool) bool {
	value := c.value_opt(key) or { return default_value }
	return value.bool()
}

@[php_arg_name: 'default_value=defaultValue']
@[php_arg_default: 'default_value=0.0']
@[php_arg_optional: 'default_value']
@[php_method: 'getFloat']
pub fn (c &VSlimConfig) get_float(key string, default_value f64) f64 {
	value := c.value_opt(key) or { return default_value }
	return value.f64()
}

@[php_method: 'getStringList']
pub fn (c &VSlimConfig) get_string_list(key string) []string {
	value := c.value_opt(key) or { return []string{} }
	arr := value.array()
	return arr.as_strings()
}

@[php_arg_name: 'default_json=defaultJson']
@[php_arg_default: 'default_json=""']
@[php_arg_optional: 'default_json']
@[php_method: 'getJson']
pub fn (c &VSlimConfig) get_json(key string, default_json string) string {
	value := c.value_opt(key) or { return default_json }
	return toml_any_to_json(value)
}

@[php_arg_name: 'default_value=defaultValue']
@[php_arg_default: 'default_value=null']
@[php_arg_optional: 'default_value']
@[php_method]
pub fn (c &VSlimConfig) get(key string, default_value vphp.RequestBorrowedZBox) vphp.RequestOwnedZBox {
	raw_default := default_value.to_zval()
	value := c.value_opt(key) or {
		if raw_default.is_valid() {
			return vphp.RequestOwnedZBox.of(raw_default)
		}
		return vphp.RequestOwnedZBox.new_null()
	}
	return vphp.RequestOwnedZBox.of(toml_any_to_zval(value))
}

@[php_arg_name: 'default_value=defaultValue']
@[php_arg_default: 'default_value=[]']
@[php_arg_optional: 'default_value']
@[php_method: 'getMap']
pub fn (c &VSlimConfig) get_map(key string, default_value vphp.RequestBorrowedZBox) vphp.RequestOwnedZBox {
	raw_default := default_value.to_zval()
	value := c.value_opt(key) or {
		return vphp.RequestOwnedZBox.of(default_or_empty(raw_default))
	}
	match value {
		map[string]toml.Any {
			return vphp.RequestOwnedZBox.of(toml_map_to_zval(value))
		}
		else {
			return vphp.RequestOwnedZBox.of(default_or_empty(raw_default))
		}
	}
}

@[php_arg_name: 'default_value=defaultValue']
@[php_arg_default: 'default_value=[]']
@[php_arg_optional: 'default_value']
@[php_method: 'getList']
pub fn (c &VSlimConfig) get_list(key string, default_value vphp.RequestBorrowedZBox) vphp.RequestOwnedZBox {
	raw_default := default_value.to_zval()
	value := c.value_opt(key) or {
		return vphp.RequestOwnedZBox.of(default_or_empty(raw_default))
	}
	match value {
		[]toml.Any {
			return vphp.RequestOwnedZBox.of(toml_list_to_zval(value))
		}
		else {
			return vphp.RequestOwnedZBox.of(default_or_empty(raw_default))
		}
	}
}

@[php_method: 'allJson']
pub fn (c &VSlimConfig) all_json() string {
	if !c.loaded {
		return '{}'
	}
	return toml_any_to_json(c.root)
}

pub fn (mut c VSlimConfig) merge_root(root toml.Any) {
	if !c.loaded {
		c.root = root
		c.loaded = true
		if c.path == '' {
			c.path = '<merged>'
		}
		return
	}
	c.root = merge_config_any(c.root, root)
	c.loaded = true
	if c.path == '' {
		c.path = '<merged>'
	}
}

pub fn (c &VSlimConfig) value_opt(key string) ?toml.Any {
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
			return vphp.PhpJson.encode(vphp.RequestOwnedZBox.new_string(value).to_zval())
		}
		toml.Date {
			return vphp.PhpJson.encode(vphp.RequestOwnedZBox.new_string(value.str()).to_zval())
		}
		toml.Time {
			return vphp.PhpJson.encode(vphp.RequestOwnedZBox.new_string(value.str()).to_zval())
		}
		toml.DateTime {
			return vphp.PhpJson.encode(vphp.RequestOwnedZBox.new_string(value.str()).to_zval())
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
	return vphp.PhpJson.encode(vphp.RequestOwnedZBox.new_string(value).to_zval())
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
	mut out := vphp.RequestOwnedZBox.new_null().to_zval()
	out.array_init()
	return out
}

fn default_or_empty(default_value vphp.ZVal) vphp.ZVal {
	if default_value.is_valid() && !default_value.is_null() {
		return default_value
	}
	return empty_array_zval()
}

const config_file_priority = [
	'app.toml',
	'http.toml',
	'logging.toml',
	'cache.toml',
	'database.toml',
	'stream.toml',
	'vhttpd.toml',
]

fn config_dir_files(path string) ![]string {
	if !os.is_dir(path) {
		return error('config path "${path}" is not a directory')
	}
	entries := os.ls(path)!
	mut files := []string{}
	for name in entries {
		if !name.ends_with('.toml') {
			continue
		}
		full := os.join_path(path, name)
		if os.is_file(full) {
			files << full
		}
	}
	files.sort()
	mut ordered := []string{}
	for name in config_file_priority {
		full := os.join_path(path, name)
		idx := files.index(full)
		if idx >= 0 {
			ordered << full
			files.delete(idx)
		}
	}
	ordered << files
	return ordered
}

fn merge_config_any(base toml.Any, incoming toml.Any) toml.Any {
	match base {
		toml.Null {
			return incoming
		}
		map[string]toml.Any {
			match incoming {
				map[string]toml.Any {
					return merge_config_maps(base, incoming)
				}
				else {
					return incoming
				}
			}
		}
		else {
			return incoming
		}
	}
}

fn merge_config_maps(base map[string]toml.Any, incoming map[string]toml.Any) toml.Any {
	mut out := base.clone()
	for key, value in incoming {
		if key in out {
			out[key] = merge_config_any(out[key], value)
		} else {
			out[key] = value
		}
	}
	return out
}

fn resolve_config_env_any(value toml.Any) !toml.Any {
	return match value {
		string {
			resolve_config_env_string(value)!
		}
		map[string]toml.Any {
			mut out := map[string]toml.Any{}
			for key, item in value {
				out[key] = resolve_config_env_any(item)!
			}
			out
		}
		[]toml.Any {
			mut out := []toml.Any{cap: value.len}
			for item in value {
				out << resolve_config_env_any(item)!
			}
			out
		}
		else {
			value
		}
	}
}

fn resolve_config_env_string(raw string) !toml.Any {
	trimmed := raw.trim_space()
	if !trimmed.starts_with('\${') || !trimmed.ends_with('}') || trimmed.len < 7 {
		return raw
	}
	body := trimmed[2..trimmed.len - 1]
	if !body.starts_with('env.') || body.len <= 4 {
		return raw
	}
	spec := body[4..]
	default_value, has_default := split_env_placeholder_default(spec)
	key_spec := if has_default { spec[..spec.len - default_value.len - 2] } else { spec }
	env_type, env_key := parse_env_placeholder_key(key_spec)!
	env_value := os.getenv(env_key)
	if env_value == '' && has_default {
		return parse_env_placeholder_value(env_type, default_value)!
	}
	if env_value == '' {
		return toml.null
	}
	return parse_env_placeholder_value(env_type, env_value)!
}

fn split_env_placeholder_default(spec string) (string, bool) {
	idx := spec.index(':-') or { return '', false }
	return spec[idx + 2..], true
}

fn parse_env_placeholder_key(spec string) !(string, string) {
	parts := spec.split('.')
	if parts.len == 0 {
		return error('empty env placeholder')
	}
	if parts.len == 1 {
		key := parts[0].trim_space()
		if key == '' {
			return error('empty env key')
		}
		return 'string', key
	}
	type_name := parts[0].trim_space().to_lower()
	key := parts[1..].join('.').trim_space()
	if key == '' {
		return error('empty env key')
	}
	return match type_name {
		'str', 'string' { 'string', key }
		'bool', 'boolean' { 'bool', key }
		'int', 'integer' { 'int', key }
		'float', 'double' { 'float', key }
		else { 'string', spec.trim_space() }
	}
}

fn parse_env_placeholder_value(type_name string, raw string) !toml.Any {
	return match type_name {
		'bool' {
			parse_env_placeholder_bool(raw)!
		}
		'int' {
			clean := raw.trim_space()
			if clean == '' {
				return error('empty int env value')
			}
			clean.i64()
		}
		'float' {
			clean := raw.trim_space()
			if clean == '' {
				return error('empty float env value')
			}
			clean.f64()
		}
		else {
			raw
		}
	}
}

fn parse_env_placeholder_bool(raw string) !bool {
	return match raw.trim_space().to_lower() {
		'1', 'true', 'yes', 'on' { true }
		'0', 'false', 'no', 'off' { false }
		else { error('invalid bool env value "${raw}"') }
	}
}

fn toml_any_to_zval(value toml.Any) vphp.ZVal {
	match value {
		toml.Null {
			return vphp.RequestOwnedZBox.new_null().to_zval()
		}
		bool {
			return vphp.RequestOwnedZBox.new_bool(value).to_zval()
		}
		int {
			return vphp.RequestOwnedZBox.new_int(value).to_zval()
		}
		i64 {
			return vphp.RequestOwnedZBox.new_int(value).to_zval()
		}
		u64 {
			return vphp.RequestOwnedZBox.new_int(i64(value)).to_zval()
		}
		f32 {
			return vphp.RequestOwnedZBox.new_float(f64(value)).to_zval()
		}
		f64 {
			return vphp.RequestOwnedZBox.new_float(value).to_zval()
		}
		string {
			return vphp.RequestOwnedZBox.new_string(value).to_zval()
		}
		toml.Date {
			return vphp.RequestOwnedZBox.new_string(value.str()).to_zval()
		}
		toml.Time {
			return vphp.RequestOwnedZBox.new_string(value.str()).to_zval()
		}
		toml.DateTime {
			return vphp.RequestOwnedZBox.new_string(value.str()).to_zval()
		}
		map[string]toml.Any {
			return toml_map_to_zval(value)
		}
		[]toml.Any {
			return toml_list_to_zval(value)
		}
	}
	return vphp.RequestOwnedZBox.new_null().to_zval()
}

fn toml_map_to_zval(input map[string]toml.Any) vphp.ZVal {
	mut out := vphp.RequestOwnedZBox.new_null().to_zval()
	out.array_init()
	for key, item in input {
		child := toml_any_to_zval(item)
		unsafe { C.vphp_array_add_assoc_zval(out.raw, &char(key.str), child.raw) }
	}
	return out
}

fn toml_list_to_zval(input []toml.Any) vphp.ZVal {
	mut out := vphp.RequestOwnedZBox.new_null().to_zval()
	out.array_init()
	for item in input {
		out.add_next_val(toml_any_to_zval(item))
	}
	return out
}

pub fn (c &VSlimConfig) free() {
	unsafe {
		c.path.free()
	}
}
