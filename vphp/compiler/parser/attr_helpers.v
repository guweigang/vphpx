module parser

import os
import math
import strconv
import compiler.repr
import compiler.syntax as ast

pub struct MethodBorrowProfile {
pub:
	receiver_type           string
	method_name             string
	return_type             string
	direct_borrowed         bool
	delegated_target_type   string
	delegated_target_method string
}

fn compiler_notes_enabled() bool {
	flag := os.getenv('VPHP_COMPILER_NOTES').trim_space()
	return flag != '' && flag != '0' && flag.to_lower() != 'false'
}

fn normalize_attr_value(raw string) string {
	return raw.trim_space().trim('\'"')
}

fn export_min_php_version(attrs []ast.Attr, attr_name string, export_name string) !int {
	version := ast.find_attr_arg(attrs, attr_name, 'version') or { return 0 }
	return parse_min_php_version(version, export_name)
}

fn parse_min_php_version(version string, export_name string) !int {
	return match version.trim_left('.') {
		'php82' { 0 }
		'php83' { 80300 }
		'php84' { 80400 }
		'php85' { 80500 }
		'php86' { 80600 }
		else { return error('${export_name}: invalid minimum PHP version ${version}') }
	}
}

fn parse_attr_list(raw string) []string {
	mut out := []string{}
	for part in raw.split(',') {
		name := normalize_attr_value(part)
		if name != '' {
			out << name
		}
	}
	return out
}

fn parse_php_prop_map(raw string) map[string]string {
	mut out := map[string]string{}
	for part in raw.split(',') {
		entry := part.trim_space()
		if entry == '' {
			continue
		}
		if idx := entry.index('=') {
			v_field_name := entry[..idx].trim_space()
			php_prop_name := normalize_attr_value(entry[idx + 1..])
			if v_field_name != '' && php_prop_name != '' {
				out[v_field_name] = php_prop_name
			}
		}
	}
	return out
}

fn parse_php_prop_attr(raw string) ?repr.PhpClassPropRepr {
	value := normalize_attr_value(raw)
	if value == '' {
		return none
	}
	mut name := value
	mut php_type := 'mixed'
	if value.contains(':') {
		name = value.all_before(':').trim_space()
		php_type = value.all_after(':').trim_space()
	}
	return php_only_property(name, php_type, 'public', false)
}

fn parse_declared_property_attr(base ast.Attr) ?repr.PhpClassPropRepr {
	name := base.args['name']
	php_type := base.args['php_type']
	visibility := base.args['visibility'] or { 'public' }
	set_visibility := if value := base.args['set_visibility'] { ?string(value) } else { none }
	readonly := base.name == 'vphp.PhpDeclaredReadonlyProperty'
	is_static := base.name in ['vphp.PhpDeclaredStaticProperty',
		'vphp.PhpDeclaredStaticPropertyWithDefault', 'vphp.PhpDeclaredStaticPropertyWithSetVisibility',
		'vphp.PhpDeclaredStaticPropertyWithSetVisibilityAndDefault']
	declared := php_only_property(name.trim_space(), php_type.trim_space(), visibility, readonly) or {
		return none
	}
	property := repr.PhpClassPropRepr{
		...declared
		is_static:      is_static
		set_visibility: set_visibility
		explicit_mixed: php_type.trim_space().to_lower() == 'mixed'
	}
	if value := base.args['default_value'] {
		return property_with_default(property, value)
	}
	return property
}

fn property_with_default(property repr.PhpClassPropRepr, value string) repr.PhpClassPropRepr {
	parsed := parse_attr_value(value.trim_space(), '', true) or {
		return repr.PhpClassPropRepr{ ...property, default_error: err.msg() }
	}
	return repr.PhpClassPropRepr{ ...property, default_value: parsed }
}

fn php_only_property(name string, php_type string, visibility string, readonly bool) ?repr.PhpClassPropRepr {
	if name == '' {
		return none
	}
	return repr.PhpClassPropRepr{
		name:             name
		v_field_name:     name
		php_type:         if php_type == '' { 'mixed' } else { php_type }
		visibility:       visibility
		is_static:        false
		is_mut:           !readonly
		is_property_only: true
	}
}

fn parse_attr_args(raw string) ![]repr.PhpAttributeArg {
	mut args := []repr.PhpAttributeArg{}
	mut named := map[string]bool{}
	tokens := split_attr_parts(raw, ',', 'PHP attribute argument list')!
	for index, token in tokens {
		if token == '' {
			if index == tokens.len - 1 {
				break
			}
			return error('empty argument before comma in PHP attribute argument list')
		}
		arg := parse_attr_arg(token)!
		if arg.name != '' {
			if arg.name in named {
				return error('duplicate named argument `${arg.name}`')
			}
			named[arg.name] = true
		} else if named.len > 0 {
			return error('positional argument cannot follow a named argument')
		}
		args << arg
	}
	return args
}

fn decode_attr_string(raw string) string {
	body := raw[1..raw.len - 1]
	mut out := []u8{cap: body.len}
	mut i := 0
	for i < body.len {
		if body[i] != `\\` || i + 1 == body.len {
			out << body[i]
			i++
			continue
		}
		// The attribute grammar permits escaping either quote in either kind of string.
		escape := body[i + 1]
		decoded := strconv.unquote_char(body[i..], escape) or {
			// Preserve unknown escapes, including backslashes in PHP names and paths.
			out << body[i]
			i++
			continue
		}
		if decoded.multibyte {
			out << decoded.value.bytes()
		} else {
			out << u8(decoded.value)
		}
		i = body.len - decoded.tail.len
	}
	return out.bytestr()
}

fn is_attr_arg_name(value string) bool {
	if value == '' || value[0].is_digit() {
		return false
	}
	for ch in value {
		if ch < 0x80 && !ch.is_letter() && !ch.is_digit() && ch != `_` {
			return false
		}
	}
	return true
}

fn parse_attr_arg(token string) !repr.PhpAttributeArg {
	raw := token.trim_space()
	arrow_parts := split_attr_parts(raw, '=>', 'PHP attribute argument')!
	if arrow_parts.len > 1 {
		return error('`=>` is only allowed between a key and value in a PHP attribute array')
	}
	if reference := parse_attribute_class_reference(raw, '') {
		return reference
	}
	parts := split_attr_parts(raw, ':', 'PHP attribute argument')!
	if parts.len == 1 {
		return parse_attr_value(raw, '', false)
	}
	name := parts[0]
	if name == '' {
		return error('missing name before `:` in PHP attribute argument')
	}
	if !is_attr_arg_name(name) {
		return error('invalid named argument `${name}`')
	}
	if parts.len > 2 {
		offset := raw.index(':') or { 0 }
		if reference := parse_attribute_class_reference(raw[offset + 1..].trim_space(),
			name) {
			return reference
		}
		return error('unexpected extra `:` in PHP attribute argument `${name}`, expected a comma between PHP attribute values')
	}
	value := parts[1]
	if value == '' {
		return error('missing value for named argument `${name}`')
	}
	return parse_attr_value(value, name, false)
}

fn parse_attribute_class_reference(value string, name string) ?repr.PhpAttributeArg {
	separator := value.index('::') or { return none }
	raw_class := value[..separator].trim_space()
	class_name := raw_class.trim_string_left('\\')
	member := value[separator + 2..].trim_space()
	if class_name.split('\\').any(!is_attr_arg_name(it)) || !is_attr_arg_name(member) {
		return none
	}
	scope := class_name.to_lower()
	if scope == 'static' || (scope in ['self', 'parent'] && raw_class != class_name) {
		return none
	}
	if member.to_lower() == 'class' && scope !in ['self', 'parent'] {
		return repr.PhpAttributeArg{ kind: 'string', name: name, value: class_name }
	}
	return repr.PhpAttributeArg{
		kind:  'class_constant'
		name:  name
		value: '${class_name}::${member}'
	}
}

fn parse_attr_array(value string, require_literals bool) ![]repr.PhpAttributeArg {
	mut items := []repr.PhpAttributeArg{}
	mut max_index_used := false
	mut next_index_is_max := false
	entries := split_attr_parts(value[1..value.len - 1], ',', 'PHP attribute array')!
	for index, entry in entries {
		if entry == '' {
			if index == entries.len - 1 {
				break
			}
			return error('expected an element before comma in PHP attribute array')
		}
		parts := split_attr_parts(entry, '=>', 'PHP attribute array')!
		if parts.len > 2 {
			return error('expected at most one `=>` per PHP attribute array element')
		}
		if parts.len == 1 {
			if max_index_used {
				return error('cannot append after the maximum PHP attribute array index')
			}
			items << parse_attr_value(parts[0], '', require_literals)!
			max_index_used = next_index_is_max
			continue
		}
		if parts.any(it == '') {
			return error('expected a key and a value around `=>` in PHP attribute array')
		}
		key := parse_attr_value(parts[0], '', require_literals)!
		if key.kind !in ['int', 'string', 'class_constant'] {
			return error('PHP attribute array keys must be integers or strings, got `${parts[0]}`')
		}
		max_index_used = max_index_used || key.value == max_i64.str()
		next_index_is_max = next_index_is_max || key.value == (max_i64 - 1).str()
		item := parse_attr_value(parts[1], '', require_literals)!
		items << repr.PhpAttributeArg{ ...item, key_kind: key.kind, key: key.value }
	}
	return items
}

fn attr_literal_end(value string) !int {
	mut depth := 0
	mut quote := u8(0)
	mut escaped := false
	for index, ch in value {
		if quote != 0 {
			if escaped {
				escaped = false
			} else if ch == `\\` {
				escaped = true
			} else if ch == quote {
				quote = 0
				if depth == 0 {
					return index + 1
				}
			}
			continue
		}
		match ch {
			`'`, `"` { quote = ch }
			`[` { depth++ }
			`]` {
				depth--
				if depth == 0 {
					return index + 1
				}
			}
			else {}
		}
	}
	return error('unclosed PHP attribute literal')
}

fn integer_literal_radix(value string) int {
	magnitude := value.trim_left('+-').to_lower()
	return if magnitude.starts_with('0x') || magnitude.starts_with('0b')
		|| magnitude.starts_with('0o') {
		0
	} else {
		10
	}
}

fn parse_integer_literal(value string) !i64 {
	return strconv.common_parse_int(value, integer_literal_radix(value), 64, true, true)
}

fn parse_attr_value(value string, name string, require_literals bool) !repr.PhpAttributeArg {
	if value.len > 0 && value[0] in [`[`, `'`, `"`] {
		end := attr_literal_end(value)!
		if end != value.len {
			kind := if value[0] == `[` { 'array' } else { 'quoted string' }
			return error('expected a comma after PHP attribute ${kind}, found `${value[end..].trim_space()}`')
		}
		if value[0] == `[` {
			return repr.PhpAttributeArg{
				kind:  'array'
				name:  name
				items: parse_attr_array(value, require_literals)!
			}
		}
		return repr.PhpAttributeArg{ kind: 'string', name: name, value: decode_attr_string(value) }
	}
	if !require_literals {
		if reference := parse_attribute_class_reference(value, name) {
			return reference
		}
	}
	if value.contains('=>') {
		return error('unexpected unquoted `=>` in PHP attribute value `${value}`')
	}
	if value.contains('=') {
		return error('unexpected unquoted `=` in PHP attribute value `${value}`. Use `:` for named arguments or `=>` for array keys')
	}
	if value.contains_any(' \t\n\r\v\f"\'[]') {
		return error('expected a comma between PHP attribute values or quotes around text `${value}`')
	}
	if value.contains(':') {
		return error('unexpected unquoted `:` in PHP attribute array value or key `${value}`')
	}
	lower := value.to_lower()
	if lower == 'true' || lower == 'false' {
		return repr.PhpAttributeArg{
			kind:  'bool'
			name:  name
			value: lower
		}
	}
	if lower == 'null' {
		return repr.PhpAttributeArg{
			kind:  'null'
			name:  name
			value: ''
		}
	}
	if integer := parse_integer_literal(value) {
		return repr.PhpAttributeArg{
			kind:  'int'
			name:  name
			value: integer.str()
		}
	}
	if integer_literal_radix(value) == 10 && value.contains_any('.eE') {
		if float := strconv.atof64(value) {
			if math.is_finite(float) {
				return repr.PhpAttributeArg{
					kind:  'float'
					name:  name
					value: value.replace('_', '')
				}
			}
		}
	}
	if require_literals {
		return error('expected a quoted string, number, boolean, null, or array literal, got `${value}`')
	}
	return repr.PhpAttributeArg{
		kind:  'string'
		name:  name
		value: value
	}
}

fn parse_typed_php_attributes(attrs []ast.Attr, name string) []repr.PhpAttributeRepr {
	mut result := []repr.PhpAttributeRepr{}
	for attr in attrs {
		if attr.name == name {
			if attribute := parse_typed_php_attribute(attr) {
				result << attribute
			}
		}
	}
	return result
}

fn parse_php_type_attributes(attrs []ast.Attr, schema string) []repr.PhpAttributeRepr {
	mut result := []repr.PhpAttributeRepr{}
	for attr in attrs {
		if attr.name == 'php_attr' {
			if attribute := parse_php_attr(attr.arg) {
				result << attribute
			}
		} else if attr.name == schema {
			if attribute := parse_typed_php_attribute(attr) {
				result << attribute
			}
		}
	}
	return result
}

fn parse_typed_php_attribute(base ast.Attr) ?repr.PhpAttributeRepr {
	return php_attribute_from_parts(base.args['name'], base.args['args'])
}

fn php_attribute_from_parts(raw_name string, args string) ?repr.PhpAttributeRepr {
	name := raw_name.trim_space()
	if name == '' {
		return none
	}
	parsed := parse_attr_args(args) or {
		return repr.PhpAttributeRepr{ name: name, parse_error: err.msg() }
	}
	return repr.PhpAttributeRepr{ name: name, args: parsed }
}

fn parse_php_attr(raw string) ?repr.PhpAttributeRepr {
	normalized := normalize_attr_value(raw)
	if normalized == '' {
		return none
	}
	if !normalized.contains('(') {
		return php_attribute_from_parts(normalized, '')
	}
	open := normalized.index_after('(', 0) or { return none }
	if !normalized.ends_with(')') || open <= 0 {
		return none
	}
	return php_attribute_from_parts(normalized[..open], normalized[open + 1..normalized.len - 1])
}
