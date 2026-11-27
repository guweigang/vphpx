module parser

import compiler.syntax as ast
import compiler.php_types
import compiler.repr

struct ParsedCallableAttrs {
mut:
	has_export        bool
	has_php_callable  bool
	php_name          string
	php_arg_types     map[string]string
	php_arg_names     map[string]string
	php_arg_defaults  map[string]string
	php_param_attrs   map[string][]repr.PhpAttributeRepr
	php_attributes    []repr.PhpAttributeRepr
	php_return_type   string
	php_arg_optional  map[string]bool
	explicit_optional map[string]bool
	borrowed_return   bool
	is_abstract       bool
	is_final          bool
	visibility        string
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
	for attr in attrs {
		if attr.name == 'php_ignore' {
			return ParsedCallableAttrs{
				php_name: default_name
			}
		}
		if attr.name == callable_attr_name || attr.name == typed_export {
			parsed.has_php_callable = true
			name := if attr.name == typed_export { attr.args['name'] } else { attr.arg }
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
			php_type := attr.args['php_type']
			if php_type.trim_space() != '' {
				parsed.php_return_type = php_type.trim_space()
			}
			continue
		}
		if attr.name in ['vphp.PhpStringParam', 'vphp.PhpBoolParam'] {
			apply_scalar_param_attr(attr, mut parsed)
			continue
		}
		if attr.name == 'vphp.PhpArgType' {
			if name, value := typed_arg_pair(attr, 'php_type') {
				parsed.php_arg_types[name] = value
			}
			continue
		}
		if attr.name == 'vphp.PhpArgName' {
			if name, value := typed_arg_pair(attr, 'php_name') {
				parsed.php_arg_names[name] = value
			}
			continue
		}
		if attr.name == 'vphp.PhpArgDefault' {
			if name, value := typed_arg_pair(attr, 'default_value') {
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
			if attribute := parse_typed_php_attribute(attr) {
				parsed.php_attributes << attribute
			}
			continue
		}
		if attr.name == 'vphp.PhpParameterAttribute' {
			apply_parameter_attribute(attr, mut parsed)
			continue
		}
		if attr.name == 'vphp.PhpSensitiveParameter' {
			name := attr.args['v_name']
			parsed.php_param_attrs[name.trim_space()] << repr.PhpAttributeRepr{ name: 'SensitiveParameter' }
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
		if attr.name == 'vphp.PhpArgOptional' {
			if name, value := typed_arg_pair(attr, 'optional') {
				parsed.explicit_optional[name] = value == 'true'
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
		if attr.name == 'vphp.PhpFinalMethod' {
			parsed.is_final = true
		}
		if attr.name == 'vphp.PhpMethodVisibility' {
			parsed.visibility = attr.args['visibility']
		}
	}
	return parsed
}

fn (attrs ParsedCallableAttrs) exported_method_visibility(is_pub bool) string {
	if attrs.visibility != '' {
		return attrs.visibility
	}
	return if is_pub { 'public' } else { 'protected' }
}

fn typed_arg_pair(attr ast.Attr, value_field string) ?(string, string) {
	v_name := attr.args['v_name'].trim_space()
	value := attr.args[value_field].trim_space()
	if v_name != '' && value != '' {
		return v_name, value
	}
	return none
}

fn apply_scalar_param_attr(attr ast.Attr, mut parsed ParsedCallableAttrs) {
	name := attr.args['v_name']
	if name == '' {
		return
	}
	php_name := attr.args['php_name']
	if php_name != '' {
		parsed.php_arg_names[name] = php_name
	}
	optional := attr.args['optional'] == 'true'
	if !optional {
		if attr.name == 'vphp.PhpBoolParam' {
			parsed.php_arg_optional.delete(name)
		} else {
			parsed.php_arg_optional[name] = false
		}
		parsed.php_arg_defaults.delete(name)
		return
	}
	parsed.php_arg_optional[name] = true
	default_value := attr.args['default_value']
	parsed.php_arg_defaults[name] = if attr.name == 'vphp.PhpStringParam' {
		quote_params_string(default_value, `"`)
	} else {
		default_value
	}
}

fn is_call_style_attr_arg(attr ast.Attr, call_name string) bool {
	return attr.call_name == call_name && attr.call_arg_name != '' && attr.has_arg
}

fn apply_parameter_attribute(base ast.Attr, mut parsed ParsedCallableAttrs) {
	v_name := base.args['v_name'].trim_space()
	if v_name != '' {
		if attr := parse_typed_php_attribute(base) {
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

fn build_php_args(params []ast.Param, module_name string, table &ast.Table, start_idx int, is_fn_variadic bool, attrs ParsedCallableAttrs, params_structs map[string]repr.PhpParamsStruct) []repr.PhpArgRepr {
	mut args := []repr.PhpArgRepr{}
	for i := start_idx; i < params.len; i++ {
		param := params[i]
		v_type := strip_module(table.type_to_str(param.typ))
		if i == params.len - 1 && !is_fn_variadic {
			if params_struct := params_structs[repr.params_struct_key(module_name, v_type)] {
				for mut field_arg in flatten_params_fields(param.name, params_struct) {
					field := field_arg.source.params_field
					field_arg.name = attrs.php_arg_names[field] or { field_arg.name }
					field_arg.php_type = attrs.php_arg_types[field] or { '' }
					declared := attrs.php_param_attrs[field]
					if declared.any(php_types.is_sensitive_parameter_attribute(it.name)) {
						field_arg.attributes = declared
					} else {
						field_arg.attributes = [...field_arg.attributes, ...declared]
					}
					if default_value := attrs.php_arg_defaults[field] {
						field_arg.php_default = default_value
						field_arg.use_php_default = default_value != ''
					}
					args << field_arg
				}
				continue
			}
		}
		inferred_optional := v_type.starts_with('?')
		has_php_default := attrs.php_arg_defaults[param.name] != ''
		is_optional := if explicit := attrs.explicit_optional[param.name] {
			explicit || has_php_default
		} else {
			inferred_optional || (attrs.php_arg_optional[param.name] or { has_php_default })
		}
		is_variadic := is_fn_variadic && i == params.len - 1
		args << repr.PhpArgRepr{
			name:            attrs.php_arg_names[param.name] or { snake_to_camel(param.name) }
			v_type:          v_type
			php_type:        attrs.php_arg_types[param.name] or { '' }
			is_optional:     is_optional
			is_variadic:     is_variadic
			use_php_default: is_optional && !is_variadic && has_php_default
			php_default:     attrs.php_arg_defaults[param.name] or {
				if inferred_optional && is_optional { 'null' } else { '' }
			}
			attributes:      attrs.php_param_attrs[param.name]
			source:          repr.PhpArgSource{
				kind:        .direct
				direct_name: param.name
			}
		}
	}
	return args
}

fn validate_parameter_attribute_targets(attrs ParsedCallableAttrs, args []repr.PhpArgRepr, owner string) ! {
	if attrs.php_param_attrs.len == 0 {
		return
	}
	for name in attrs.php_param_attrs.keys() {
		if name == '' || !args.any(!is_context_type(it.v_type)
			&& name in [it.source.direct_name, it.source.params_field]) {
			return error('PHP parameter attribute on ${owner}: `${name}` is not a PHP-visible V parameter')
		}
	}
}

fn flatten_params_fields(param_name string, params_struct repr.PhpParamsStruct) []repr.PhpArgRepr {
	return params_struct.fields.map(repr.PhpArgRepr{
		name:        snake_to_camel(it.name)
		v_type:      it.v_type
		is_optional: true
		php_default: it.php_default
		attributes:  if it.is_sensitive {
			[repr.PhpAttributeRepr{ name: 'SensitiveParameter' }]
		} else {
			[]
		}
		source:      repr.PhpArgSource{
			kind:                    .params_field
			params_arg_name:         param_name
			params_type:             params_struct.type_ref()
			params_field:            it.name
			params_v_default:        it.v_default
			params_computed_default: it.has_computed_default()
		}
	})
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
