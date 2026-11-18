module parser

import compiler.syntax as ast
import compiler.repr

struct ParsedCallableAttrs {
mut:
	has_export       bool
	has_php_callable bool
	php_name         string
	php_arg_types    map[string]string
	php_arg_names    map[string]string
	php_arg_defaults map[string]string
	php_param_attrs  map[string][]repr.PhpAttributeRepr
	php_attributes   []repr.PhpAttributeRepr
	php_return_type  string
	php_arg_optional map[string]bool
	borrowed_return  bool
	is_abstract      bool
}

fn split_attr_entries(raw string) []string {
	parts := split_attr_parts(raw, ',', '') or { return [] }
	return parts.filter(it != '')
}

fn split_attr_parts(raw string, separator string, context string) ![]string {
	mut out := []string{}
	mut start := 0
	mut quote := u8(0)
	mut escaped := false
	mut closers := []u8{}
	for i, ch in raw {
		if escaped {
			escaped = false
			continue
		}
		if quote != 0 {
			if ch == `\\` {
				escaped = true
				continue
			}
			if ch == quote {
				quote = 0
			}
			continue
		}
		match ch {
			`'`, `"` {
				quote = ch
			}
			`[` {
				closers << `]`
			}
			`{` {
				closers << `}`
			}
			`(` {
				closers << `)`
			}
			`]`, `}`, `)` {
				if closers.len > 0 && closers.last() == ch {
					closers.pop()
				} else if context != '' {
					return error('unexpected `${ch.ascii_str()}` in ${context}')
				} else {
					index := closers.last_index(ch)
					if index >= 0 {
						closers.delete(index)
					}
				}
			}
			else {}
		}
		if i >= start && closers.len == 0
			&& ch == separator[0] && raw[i..].starts_with(separator) {
			out << raw[start..i].trim_space()
			start = i + separator.len
		}
	}
	if context != '' && quote != 0 {
		return error('unclosed quoted string in ${context}')
	}
	if context != '' && closers.len > 0 {
		return error('expected `${closers.last().ascii_str()}` in ${context}')
	}
	out << raw[start..].trim_space()
	return out
}

fn parse_callable_attrs(attrs []ast.Attr, callable_attr_name string, default_name string) ParsedCallableAttrs {
	mut parsed := ParsedCallableAttrs{
		php_name: default_name
	}
	typed_export := if callable_attr_name == 'php_method' {
		'vphp.PhpExportMethod'
	} else {
		'vphp.PhpExportFunction'
	}
	for index, attr in attrs {
		if attr.name == 'php_ignore' {
			return ParsedCallableAttrs{
				php_name: default_name
			}
		}
		if attr.name == callable_attr_name || attr.name == typed_export {
			parsed.has_php_callable = true
			mut name := attr.arg
			if attr.name == typed_export && index + 1 < attrs.len
				&& attrs[index + 1].name == '${typed_export}_name' {
				name = attrs[index + 1].arg
			}
			if name != '' {
				parsed.php_name = name
			}
			continue
		}
		if attr.name == 'export' && attr.arg != '' {
			parsed.has_export = true
			continue
		}
		if attr.name == 'php_return_type' && attr.arg != '' {
			parsed.php_return_type = normalize_attr_value(attr.arg)
			continue
		}
		if attr.name == 'vphp.PhpReturnType' {
			mut php_type := attr.arg
			if index + 1 < attrs.len && attrs[index + 1].name == 'vphp.PhpReturnType_php_type' {
				php_type = attrs[index + 1].arg
			}
			if php_type.trim_space() != '' {
				parsed.php_return_type = php_type.trim_space()
			}
			continue
		}
		if attr.name == 'vphp.PhpStringParam' {
			apply_string_param_attr(attr, attrs[index + 1..], mut parsed)
			continue
		}
		if attr.name == 'vphp.PhpBoolParam' {
			// The flat V AST stores named schema fields as separate attribute entries.
			v_name := ast.find_attr(attrs, 'vphp.PhpBoolParam_v_name') or { attr }
			if v_name.arg == '' {
				continue
			}
			if php_name := ast.find_attr(attrs, 'vphp.PhpBoolParam_php_name') {
				if php_name.arg != '' {
					parsed.php_arg_names[v_name.arg] = php_name.arg
				}
			}
			optional := ast.find_attr(attrs, 'vphp.PhpBoolParam_optional') or { ast.Attr{} }
			if optional.arg == 'true' {
				default_value := ast.find_attr(attrs, 'vphp.PhpBoolParam_default_value') or {
					ast.Attr{}
				}
				parsed.php_arg_optional[v_name.arg] = true
				parsed.php_arg_defaults[v_name.arg] = (default_value.arg == 'true').str()
			} else {
				parsed.php_arg_optional.delete(v_name.arg)
				parsed.php_arg_defaults.delete(v_name.arg)
			}
			continue
		}
		if attr.name == 'vphp.PhpArgType' {
			if name, value := typed_arg_pair(attr, attrs[index + 1..], 'php_type') {
				parsed.php_arg_types[name] = value
			}
			continue
		}
		if attr.name == 'vphp.PhpArgName' {
			if name, value := typed_arg_pair(attr, attrs[index + 1..], 'php_name') {
				parsed.php_arg_names[name] = value
			}
			continue
		}
		if attr.name == 'vphp.PhpArgDefault' {
			if name, value := typed_arg_pair(attr, attrs[index + 1..], 'default_value') {
				parsed.php_arg_defaults[name] = value
			}
			continue
		}
		if is_call_style_attr_arg(attr, 'php_arg_type') {
			parsed.php_arg_types[attr.call_arg_name] = normalize_attr_value(attr.arg)
			continue
		}
		if attr.name == 'php_arg_type' && attr.arg != '' {
			for arg_name, arg_type in parse_php_arg_name_values(attr.arg) {
				parsed.php_arg_types[arg_name] = arg_type
			}
			continue
		}
		if is_call_style_attr_arg(attr, 'php_arg_name') {
			parsed.php_arg_names[attr.call_arg_name] = normalize_attr_value(attr.arg)
			continue
		}
		if attr.name == 'php_arg_name' && attr.arg != '' {
			for arg_name, php_arg_name in parse_php_arg_name_values(attr.arg) {
				parsed.php_arg_names[arg_name] = normalize_attr_value(php_arg_name)
			}
			continue
		}
		if is_call_style_attr_arg(attr, 'php_arg_default') {
			parsed.php_arg_defaults[attr.call_arg_name] = attr.arg.trim_space()
			continue
		}
		if attr.name == 'php_arg_default' && attr.arg != '' {
			for arg_name, default_value in parse_php_arg_name_values(attr.arg) {
				parsed.php_arg_defaults[arg_name] = default_value
			}
			continue
		}
		if is_call_style_attr_arg(attr, 'php_arg_optional') {
			value := normalize_attr_value(attr.arg).to_lower()
			if value != 'false' && value != '0' {
				parsed.php_arg_optional[attr.call_arg_name] = true
			} else if attr.call_arg_name !in parsed.php_arg_optional {
				parsed.php_arg_optional[attr.call_arg_name] = false
			}
			continue
		}
		if attr.name == 'vphp.PhpCallableAttribute' {
			if attribute := parse_typed_php_attribute(attr, attrs[index + 1..]) {
				parsed.php_attributes << attribute
			}
			continue
		}
		if attr.name == 'vphp.PhpParameterAttribute' {
			apply_parameter_attribute(attr, attrs[index + 1..], mut parsed)
			continue
		}
		if is_call_style_attr_arg(attr, 'php_param_attr') {
			parsed.php_param_attrs[attr.call_arg_name] << parse_php_attr_list(attr.arg)
			continue
		}
		if attr.name == 'php_arg_optional' && attr.arg != '' {
			for arg_name in parse_attr_list(attr.arg) {
				parsed.php_arg_optional[arg_name] = true
			}
			continue
		}
		if attr.name in ['php_borrowed_return', 'vphp.PhpBorrowedReturn'] {
			parsed.borrowed_return = true
			continue
		}
		if attr.name in ['php_abstract', 'vphp.PhpAbstractMethod'] {
			parsed.is_abstract = true
		}
	}
	return parsed
}

fn typed_arg_pair(base ast.Attr, following []ast.Attr, value_field string) ?(string, string) {
	mut v_name := base.arg.trim_space()
	mut value := ''
	for field in following {
		match field.name {
			'${base.name}_v_name' { v_name = field.arg.trim_space() }
			'${base.name}_${value_field}', '${base.name}_1' { value = field.arg.trim_space() }
			else { break }
		}
	}
	if v_name != '' && value != '' {
		return v_name, value
	}
	return none
}

fn apply_string_param_attr(base ast.Attr, following []ast.Attr, mut parsed ParsedCallableAttrs) {
	mut name := base.arg
	mut php_name := ''
	mut default_value := ''
	mut optional := false
	for field in following {
		if !field.name.starts_with('vphp.PhpStringParam_') {
			break
		}
		match field.name {
			'vphp.PhpStringParam_v_name' { name = field.arg }
			'vphp.PhpStringParam_php_name' { php_name = field.arg }
			'vphp.PhpStringParam_default_value' { default_value = field.arg }
			'vphp.PhpStringParam_optional' { optional = field.arg == 'true' }
			else {}
		}
	}
	if name == '' {
		return
	}
	if php_name != '' {
		parsed.php_arg_names[name] = php_name
	}
	parsed.php_arg_optional[name] = optional
	if optional {
		parsed.php_arg_defaults[name] = quote_params_string(default_value, `"`)
	} else {
		parsed.php_arg_defaults.delete(name)
	}
}

fn is_call_style_attr_arg(attr ast.Attr, call_name string) bool {
	return attr.call_name == call_name && attr.call_arg_name != '' && attr.has_arg
}

fn apply_parameter_attribute(base ast.Attr, following []ast.Attr, mut parsed ParsedCallableAttrs) {
	mut v_name := base.arg
	mut name := ''
	mut args := ''
	for field in following {
		match field.name {
			'vphp.PhpParameterAttribute_v_name' { v_name = field.arg }
			'vphp.PhpParameterAttribute_name', 'vphp.PhpParameterAttribute_1' { name = field.arg }
			'vphp.PhpParameterAttribute_args', 'vphp.PhpParameterAttribute_2' { args = field.arg }
			else { break }
		}
	}
	v_name = v_name.trim_space()
	if v_name != '' {
		if attr := php_attribute_from_parts(name, args) {
			parsed.php_param_attrs[v_name] << attr
		}
	}
}

fn parse_php_attr_list(raw string) []repr.PhpAttributeRepr {
	mut out := []repr.PhpAttributeRepr{}
	for entry in split_attr_entries(raw) {
		if php_attr := parse_php_attr(entry) {
			out << php_attr
		}
	}
	return out
}

fn parse_php_arg_name_values(raw string) map[string]string {
	mut out := map[string]string{}
	for part in split_attr_entries(raw) {
		entry := part.trim_space()
		if entry == '' {
			continue
		}
		if idx := entry.index('=') {
			arg_name := entry[..idx].trim_space()
			arg_value := entry[idx + 1..].trim_space()
			if arg_name != '' && arg_value != '' {
				out[arg_name] = arg_value
			}
		}
	}
	return out
}

fn build_php_args(params []ast.Param, table &ast.Table, start_idx int, is_fn_variadic bool, overrides map[string]string, names map[string]string, optional map[string]bool, defaults map[string]string, param_attrs map[string][]repr.PhpAttributeRepr, params_structs map[string]repr.PhpParamsStruct) []repr.PhpArgRepr {
	mut args := []repr.PhpArgRepr{}
	for i := start_idx; i < params.len; i++ {
		param := params[i]
		v_type := strip_module(table.type_to_str(param.typ))
		if i == params.len - 1 {
			if params_struct := params_structs[v_type] {
				for field in params_struct.fields {
					args << repr.PhpArgRepr{
						name:            names[field.name] or { snake_to_camel(field.name) }
						v_type:          field.v_type
						php_type:        overrides[field.name] or { '' }
						is_optional:     true
						php_default:     defaults[field.name] or { field.php_default }
						use_php_default: defaults[field.name] != ''
						attributes:      param_attrs[field.name]
						source:          repr.PhpArgSource{
							kind:                    .params_field
							params_arg_name:         param.name
							params_type:             params_struct.type_ref()
							params_field:            field.name
							params_v_default:        field.v_default
							params_computed_default: field.has_computed_default()
						}
					}
				}
				continue
			}
		}
		inferred_optional := v_type.starts_with('?')
		has_php_default := defaults[param.name] != ''
		declared_optional := optional[param.name] or { has_php_default }
		is_optional := inferred_optional || declared_optional
		is_variadic := is_fn_variadic && i == params.len - 1
		args << repr.PhpArgRepr{
			name:            names[param.name] or { snake_to_camel(param.name) }
			v_type:          v_type
			php_type:        overrides[param.name] or { '' }
			is_optional:     is_optional
			is_variadic:     is_variadic
			use_php_default: is_optional && !is_variadic && has_php_default
			php_default:     defaults[param.name] or {
				if inferred_optional { 'null' } else { '' }
			}
			attributes:      param_attrs[param.name]
			source:          repr.PhpArgSource{
				kind:        .direct
				direct_name: param.name
			}
		}
	}
	return args
}

fn snake_to_camel(name string) string {
	parts := name.split('_')
	if parts.len <= 1 {
		return name
	}
	mut out := parts[0]
	for part in parts[1..] {
		if part == '' {
			continue
		}
		out += part[..1].to_upper() + part[1..]
	}
	return out
}
