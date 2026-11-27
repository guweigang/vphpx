module compiler

import compiler.repr
import compiler.php_types
import compiler.syntax as ast

enum StructClosureBindingKind {
	params_struct
	variadic
	fixed
}

struct StructClosureBinding {
	unique             string
	alias              string
	bridge             string
	wrap               string
	arg_type           string
	ret_type           string
	module_name        string
	fields             []repr.PhpParamsField
	kind               StructClosureBindingKind
	variadic_arg_type  string
	variadic_arg_name  string
	variadic_interface bool
}

fn StructClosureBinding.new(unique string, return_type string, module_name string, params_structs map[string]repr.PhpParamsStruct, table &ast.Table) ?StructClosureBinding {
	parts, ret_type := split_closure_signature(return_type)?
	mut params := parts.clone()
	mut variadic_arg_type := ''
	mut variadic_arg_name := 'args'
	mut variadic_interface := false
	if params.len > 0 {
		name, typ := closure_param_parts(params.last())
		if typ.starts_with('...') {
			variadic_arg_type = typ[3..]
			if _, _ := interface_wrapper_target(variadic_arg_type, module_name, table) {
				variadic_interface = true
			}
			if !variadic_interface && !is_supported_variadic_closure_arg(variadic_arg_type)
				&& !is_bound_variadic_closure_arg(variadic_arg_type, table) {
				return none
			}
			if name != '' {
				variadic_arg_name = name
			}
			params.pop()
		}
	}
	_, arg_type := closure_param_parts(if params.len == 1 { params[0] } else { '' })
	alias_name := pascal_struct_closure_name(sanitize_struct_closure_token(unique))
	safe := sanitize_struct_closure_token(unique).to_lower()
	if variadic_arg_type != '' && params.len == 0 {
		return StructClosureBinding{
			unique:             safe
			alias:              'VPhpVariadicClosure${alias_name}'
			bridge:             'vphp_variadic_closure_bridge_${safe}'
			wrap:               'vphp_wrap_variadic_closure_${safe}'
			arg_type:           variadic_arg_type
			ret_type:           ret_type
			module_name:        module_name
			kind:               .variadic
			variadic_arg_type:  variadic_arg_type
			variadic_arg_name:  variadic_arg_name
			variadic_interface: variadic_interface
		}
	}
	if params_struct := params_structs[repr.params_struct_key(module_name, arg_type)] {
		if variadic_arg_type == '' {
			return StructClosureBinding{
				unique:      safe
				alias:       'VPhpStructClosure${alias_name}'
				bridge:      'vphp_struct_closure_bridge_${safe}'
				wrap:        'vphp_wrap_struct_closure_${safe}'
				arg_type:    arg_type
				ret_type:    ret_type
				module_name: module_name
				fields:      params_struct.fields
				kind:        .params_struct
			}
		}
	}
	mut fields := []repr.PhpParamsField{cap: params.len}
	for param in params {
		name, v_type := closure_param_parts(param)
		if name in ['mut', 'shared'] || param.contains('fn (') || v_type.starts_with('...') {
			return none
		}
		nullable := v_type.starts_with('?')
		fields << repr.PhpParamsField{
			name:        name
			v_type:      v_type
			v_default:   if nullable { 'none' } else { '' }
			php_default: if nullable { 'null' } else { '' }
			has_default: nullable
		}
	}
	mut names := fields.map(it.name)
	if variadic_arg_type != '' {
		for (variadic_arg_name in names) {
			variadic_arg_name += '_'
		}
		names << variadic_arg_name
	}
	for i, mut field in fields {
		if field.name != '' {
			continue
		}
		mut name := 'arg${i + 1}'
		for (name in names) {
			name += '_'
		}
		field.name = name
		names << name
	}
	mut types := fields.map(it.v_type)
	if variadic_arg_type != '' {
		types << '...${variadic_arg_type}'
	}
	return StructClosureBinding{
		unique:             safe
		alias:              'VPhpFixedClosure${alias_name}'
		bridge:             'vphp_fixed_closure_bridge_${safe}'
		wrap:               'vphp_wrap_fixed_closure_${safe}'
		arg_type:           types.join(', ')
		ret_type:           ret_type
		module_name:        module_name
		fields:             fields
		kind:               .fixed
		variadic_arg_type:  variadic_arg_type
		variadic_arg_name:  variadic_arg_name
		variadic_interface: variadic_interface
	}
}

fn closure_param_parts(param string) (string, string) {
	first, rest := param.split_once(' ') or { return '', normalize_struct_closure_type(param) }
	return first.trim_string_left('@'), normalize_struct_closure_type(rest)
}

fn split_closure_signature(typ string) ?([]string, string) {
	prefix := 'fn ('
	if !typ.starts_with(prefix) {
		return none
	}
	mut params := []string{}
	mut depth := 0
	mut start := prefix.len
	for i in prefix.len .. typ.len {
		match typ[i] {
			`(`, `[` { depth++ }
			`)` {
				if depth == 0 {
					param := typ[start..i].trim_space()
					if param != '' {
						params << param
					}
					ret := typ[i + 1..].trim_space()
					return params, if ret == '' { 'void' } else { ret }
				}
				depth--
			}
			`]` { depth-- }
			`,` {
				if depth == 0 {
					params << typ[start..i].trim_space()
					start = i + 1
				}
			}
			else {}
		}
	}
	return none
}

fn normalize_struct_closure_type(type_name string) string {
	return type_name.trim_space().replace('main.', '')
}

fn sanitize_struct_closure_token(name string) string {
	mut out := []u8{cap: name.len}
	for ch in name {
		if (ch >= `a` && ch <= `z`) || (ch >= `A` && ch <= `Z`) || (ch >= `0` && ch <= `9`) {
			out << u8(ch)
		} else {
			out << `_`
		}
	}
	safe := out.bytestr().trim('_')
	if safe == '' {
		return 'closure'
	}
	return safe
}

fn pascal_struct_closure_name(name string) string {
	mut parts := []string{}
	for part in name.split('_') {
		if part == '' {
			continue
		}
		parts << part[0].ascii_str().to_upper() + part[1..]
	}
	return parts.join('')
}

fn is_supported_variadic_closure_arg(type_name string) bool {
	return php_types.accepts_named_variadic(type_name, true)
		|| is_scalar_variadic_closure_arg(type_name) || is_named_wrapper_variadic_closure_arg(type_name)
		|| type_name in ['PhpValue', 'vphp.PhpValue', 'ZVal', 'vphp.ZVal', 'RequestBorrowedZBox',
			'vphp.RequestBorrowedZBox', 'VScalarValue', 'vphp.VScalarValue', 'PhpReference',
			'vphp.PhpReference']
}

fn is_named_wrapper_variadic_closure_arg(type_name string) bool {
	if type_name.starts_with('?') || type_name.starts_with('&') {
		return false
	}
	spec := php_types.PhpTypeSpec.from_v_type(type_name) or { return false }
	return spec.php_class != ''
}

fn is_scalar_variadic_closure_arg(type_name string) bool {
	return type_name in ['int', 'i64', 'string', 'bool', 'f32', 'f64']
}

fn is_bound_variadic_closure_arg(type_name string, table &ast.Table) bool {
	ref_type := type_name.trim_left('?')
	if table == unsafe { nil } || !ref_type.starts_with('&') {
		return false
	}
	sym := table.find_sym(ref_type[1..]) or { return false }
	return sym.kind == .struct_
}

fn (binding StructClosureBinding) render_helper_lines(borrowed_return bool, table &ast.Table) []string {
	if binding.kind == .variadic {
		return binding.render_variadic_helper_lines(borrowed_return)
	}
	mut lines := []string{}
	struct_signature := if binding.ret_type == 'void' {
		'fn (${binding.arg_type})'
	} else {
		'fn (${binding.arg_type}) ${binding.ret_type}'
	}
	lines << '__global C.${binding.arginfo_symbol()} voidptr'
	if binding.fields.any(it.is_sensitive) {
		lines << '__global C.${binding.arginfo_symbol()}_attributes voidptr'
	}
	lines << ''
	lines << 'pub type ${binding.alias} = ${struct_signature}'
	lines << ''
	lines << binding.bridge_signature()
	computed_indices := binding.computed_default_indices()
	if computed_indices.len > 0 {
		lines << '    mut vphp_scope := vphp.PhpScope.once()'
		lines << '    defer { vphp_scope.close() }'
	}
	lines << '    unsafe {'
	lines << '        ctx := vphp.Context.from_ptr(ex, ret)'
	lines << '        cb := *(&${binding.alias}(v_ptr))'
	required := binding.required_fields()
	if binding.fields.len > 0 || binding.kind == .fixed {
		lines << '        arg_count := ctx.num_args()'
	}
	if binding.kind == .fixed && binding.variadic_arg_type == '' {
		lines << '        if arg_count > ${binding.fields.len} {'
		lines << "            vphp.PhpException.raise_class('ArgumentCountError', 'closure accepts at most ${binding.fields.len} arguments', 0)"
		lines << '            return'
		lines << '        }'
	}
	if required > 0 {
		word := if required == 1 { 'argument' } else { 'arguments' }
		lines << '        if arg_count < ${required} {'
		lines << "            vphp.PhpException.raise_class('ArgumentCountError', 'closure requires at least ${required} ${word}', 0)"
		lines << '            return'
		lines << '        }'
	}
	computed := binding.fields.filter(it.has_computed_default()).map(ComputedParamsField{
		name:   it.name
		v_type: it.v_type
	})
	for i, field in binding.fields {
		named := field.php_named_type != '' || (binding.kind == .fixed && is_closure_named_field(field.v_type, table))
		if i < required {
			lines << binding.render_field_read(field, i, 'field_${i}', '        ', named)
			continue
		}
		has_arg := if field.has_computed_default() {
			'arg_count > ${i} && !ctx.arg_val(${i}).is_undef()'
		} else {
			'arg_count > ${i}'
		}
		lines << '        field_${i} := if ${has_arg} {'
		lines << binding.render_field_read(field, i, 'provided_${i}', '            ', named)
		lines << '            provided_${i}'
		lines << '        } else {'
		if field.has_computed_default() {
			// A named gap stops immediately on failure. Trailing defaults are
			// evaluated in field order before the final exception check.
			lines << render_computed_params_default(binding.arg_type, field.name, computed,
				'            ', 'arg_count > ${i} && vphp.has_exception()', 'return')
		} else {
			lines << '            ${field.v_default}'
		}
		lines << '        }'
	}
	if computed_indices.len > 0 {
		lines << '        if arg_count <= ${computed_indices.last()} && vphp.has_exception() {'
		lines << '            return'
		lines << '        }'
	}
	if binding.kind == .fixed {
		mut args := []string{cap: binding.fields.len}
		for i in 0 .. binding.fields.len {
			args << 'field_${i}'
		}
		mut captures := ['cb']
		captures << args
		if binding.variadic_arg_type != '' {
			lines << binding.render_variadic_arguments(binding.fields.len)
			args << '...args'
			captures << 'args'
		}
		lines << binding.render_callback_call('cb(${args.join(', ')})', captures.join(', '),
			'        ', borrowed_return)
	} else {
		lines << binding.render_struct_call('        ', borrowed_return)
	}
	lines << '    }'
	lines << '}'
	lines << ''
	lines << 'fn ${binding.wrap}(ctx vphp.Context, cb ${binding.alias}) {'
	arity := binding.fields.len + if binding.variadic_arg_type != '' { 1 } else { 0 }
	lines << binding.render_closure_creation(arity, required)
	lines << '}'
	lines << ''
	return lines
}

fn is_closure_named_field(v_type string, table &ast.Table) bool {
	if table == unsafe { nil } {
		return false
	}
	sym := table.find_sym(table.get_type_name(v_type)) or { return false }
	return if v_type.trim_left('?').starts_with('&') {
		sym.kind == .struct_
	} else {
		sym.kind == .enum
	}
}

fn (binding StructClosureBinding) render_variadic_helper_lines(borrowed_return bool) []string {
	mut lines := []string{}
	lines << '__global C.${binding.arginfo_symbol()} voidptr'
	lines << ''
	variadic_signature := if binding.ret_type == 'void' {
		'fn (...${binding.variadic_arg_type})'
	} else {
		'fn (...${binding.variadic_arg_type}) ${binding.ret_type}'
	}
	lines << 'pub type ${binding.alias} = ${variadic_signature}'
	lines << ''
	lines << binding.bridge_signature()
	lines << '    unsafe {'
	lines << '        ctx := vphp.Context.from_ptr(ex, ret)'
	lines << '        cb := *(&${binding.alias}(v_ptr))'
	if binding.has_bound_variadic_args() || is_scalar_variadic_closure_arg(binding.variadic_arg_type)
		|| php_types.accepts_named_variadic(binding.variadic_arg_type, true)
		|| binding.variadic_interface || is_named_wrapper_variadic_closure_arg(binding.variadic_arg_type) {
		lines << binding.render_variadic_arguments(0)
		lines << binding.render_callback_call('cb(...args)', 'cb, args', '        ', borrowed_return)
	} else if binding.uses_checked_return() {
		lines << '        args := ctx.variadic_closure_args[${binding.variadic_arg_type}]() or {'
		lines << '            vphp.throw_exception(err.msg(), 0)'
		lines << '            return'
		lines << '        }'
		lines << binding.render_callback_call('cb(...args)', 'cb, args', '        ', borrowed_return)
	} else if binding.ret_type == 'void' {
		lines << '        ctx.forward_variadic_closure_void[${binding.variadic_arg_type}](cb)'
	} else if binding.returns_reference() && binding.ret_type.starts_with('!') {
		lines << '        ctx.forward_variadic_closure_result[${binding.variadic_arg_type}, ${binding.ret_type[1..]}](cb)'
	} else {
		lines << '        ctx.forward_variadic_closure[${binding.variadic_arg_type}, ${binding.ret_type}](cb)'
	}
	lines << '    }'
	lines << '}'
	lines << ''
	lines << 'fn ${binding.wrap}(ctx vphp.Context, cb ${binding.alias}) {'
	lines << binding.render_closure_creation(1, 0)
	lines << '}'
	lines << ''
	return lines
}

fn (binding StructClosureBinding) render_closure_creation(arity int, required int) string {
	if binding.fields.any(it.is_sensitive) {
		arginfo := binding.arginfo_symbol()
		return '    ctx.create_saved_closure_with_attributes[${binding.alias}](cb, ${binding.bridge}, ${arity}, ${required}, C.${arginfo}, C.${arginfo}_attributes)'
	}
	creator := if php_types.accepts_named_variadic(binding.variadic_arg_type, true) {
		'create_saved_named_variadic_closure'
	} else {
		'create_typed_saved_closure_with_arginfo'
	}
	return '    ctx.${creator}[${binding.alias}](cb, ${binding.bridge}, ${arity}, ${required}, C.${binding.arginfo_symbol()})'
}

fn (binding StructClosureBinding) render_variadic_arguments(start int) []string {
	mut lines := []string{}
	if binding.has_bound_variadic_args() {
		v_type := binding.variadic_arg_type
		inner := v_type.trim_left('?&')
		expr := bound_object_expr(v_type, inner, 'php_args.at(index)', false)
		lines << '        php_args := ctx.args()'
		lines << '        mut args := []${v_type}{}'
		lines << '        for index in ${start} .. php_args.len() {'
		lines << '            item := ${expr.replace('\n', '\n            ')}'
		lines << '            args << item'
		lines << '        }'
	} else {
		type_name := binding.variadic_arg_type
		mut read := 'ctx.variadic_closure_args_from[${type_name}](${start})'
		if type_name.starts_with('?') && binding.variadic_interface {
			read = 'ctx.nullable_interface_closure_args_from[${type_name[1..]}](${start})'
		}
		lines << '        args := ${read} or {'
		lines << "            if !vphp.has_exception() { vphp.PhpException.raise_class('TypeError', err.msg(), 0) }"
		lines << '            return'
		lines << '        }'
	}
	return lines
}

fn (binding StructClosureBinding) bridge_signature() string {
	return 'fn ${binding.bridge}(v_ptr voidptr, ex &C.zend_execute_data, ret &C.zval) {'
}

fn (binding StructClosureBinding) arginfo_symbol() string {
	return 'struct_closure_arginfo_${binding.unique}'
}

fn (binding StructClosureBinding) returns_reference() bool {
	return php_types.is_reference_return(binding.ret_type)
}

fn (binding StructClosureBinding) returns_object() bool {
	return binding.ret_type.trim_left('!?').starts_with('&')
}

fn (binding StructClosureBinding) uses_checked_return() bool {
	return !binding.returns_reference()
		&& (binding.returns_object() || binding.ret_type.starts_with('!') || binding.ret_type.starts_with('?'))
}

fn (binding StructClosureBinding) has_bound_variadic_args() bool {
	return binding.variadic_arg_type.trim_left('?').starts_with('&')
}

fn (binding StructClosureBinding) required_fields() int {
	mut required := binding.fields.len
	for required > 0 && binding.fields[required - 1].has_default {
		required--
	}
	return required
}

fn (binding StructClosureBinding) computed_default_indices() []int {
	mut result := []int{}
	for i in binding.required_fields() .. binding.fields.len {
		if binding.fields[i].has_computed_default() {
			result << i
		}
	}
	return result
}

fn (binding StructClosureBinding) render_struct_call(indent string, borrowed_return bool) []string {
	mut lines := ['${indent}args := ${binding.arg_type}{']
	for i, field in binding.fields {
		lines << '${indent}    ${field.name}: field_${i}'
	}
	lines << '${indent}}'
	if binding.uses_checked_return() {
		lines << binding.render_callback_call('cb(args)', 'cb, args', indent, borrowed_return)
	} else if binding.ret_type == 'void' {
		lines << '${indent}ctx.forward_struct_closure_void[${binding.arg_type}](cb, args)'
	} else if binding.returns_reference() && binding.ret_type.starts_with('!') {
		lines << '${indent}ctx.forward_struct_closure_result[${binding.arg_type}, ${binding.ret_type[1..]}](cb, args)'
	} else {
		lines << '${indent}ctx.forward_struct_closure[${binding.arg_type}, ${binding.ret_type}](cb, args)'
	}
	return lines
}

fn (binding StructClosureBinding) render_callback_call(call_expr string, captures string, indent string, borrowed_return bool) []string {
	return_binding := ReturnBinding.new(binding.ret_type, none, borrowed_return)
	lines := match return_binding.kind {
		.result, .option { return_binding.render_fallible_call_lines(call_expr, captures, []) }
		.void_ { ['    ${call_expr}', '    ctx.return().null()'] }
		else { return_binding.render_value_call_lines(call_expr) }
	}
	return lines.map(indent + it.trim_string_left('    '))
}

fn (binding StructClosureBinding) render_field_read(field repr.PhpParamsField, index int, variable string, indent string, named bool) []string {
	ref_type := field.v_type.trim_left('?')
	if named && ref_type.starts_with('&') {
		arg := '${variable}_arg'
		expr := bound_object_expr(field.v_type, ref_type[1..], arg, false)
		return [
			'${indent}${arg} := vphp.PhpArg.from_zval(${index}, ${v_single_quote(field.name)}, ctx.arg_val(${index}))',
			'${indent}${variable} := ${expr.replace('\n', '\n' + indent)}',
		]
	}
	if php_types.is_reference_parameter(field.v_type, false) {
		read := 'ctx.arg_reference(${index})'
		if field.v_type.starts_with('?') {
			return ['${indent}${variable} := ${read}']
		}
		return [
			'${indent}${variable} := ${read} or {',
			"${indent}    vphp.PhpException.raise_class('TypeError', 'argument ${index + 1} (${field.name}): expected reference', 0)",
			'${indent}    return',
			'${indent}}',
		]
	}
	if field.v_type.starts_with('?') {
		inner := field.v_type[1..]
		mut lines := ['${indent}mut ${variable} := ${field.v_type}(none)']
		lines << '${indent}if !ctx.arg_val(${index}).is_null() {'
		if expr := php_context_arg_direct_expr(inner, index) {
			lines << '${indent}    ${variable} = ${expr}'
		} else {
			lines << '${indent}    ${variable} = ${closure_field_conversion(inner, index, named)} or {'
			lines << binding.render_field_type_error(field, index, indent + '        ')
			lines << '${indent}    }'
		}
		lines << '${indent}}'
		return lines
	}
	if expr := php_context_arg_direct_expr(field.v_type, index) {
		return ['${indent}${variable} := ${expr}']
	}
	mut lines := ['${indent}${variable} := ${closure_field_conversion(field.v_type, index, named)} or {']
	lines << binding.render_field_type_error(field, index, indent + '    ')
	lines << '${indent}}'
	return lines
}

fn closure_field_conversion(v_type string, index int, is_enum bool) string {
	if is_enum {
		return 'vphp.ZendObject.from_zval(ctx.arg_val(${index})).enum_case_to_v[${v_type}]()'
	}
	if v_type in ['PhpArray', 'vphp.PhpArray'] {
		return 'ctx.arg_array(${index})'
	}
	return 'ctx.closure_arg_to_v[${v_type}](${index})'
}

fn (binding StructClosureBinding) render_field_type_error(field repr.PhpParamsField, index int, indent string) []string {
	detail := if field.v_type.trim_left('?') in ['PhpArray', 'vphp.PhpArray'] {
		'expected array'
	} else {
		'\${err.msg()}'
	}
	return [
		"${indent}if !vphp.has_exception() { vphp.PhpException.raise_class('TypeError', 'argument ${index + 1} (${field.name}): ${detail}', 0) }",
		'${indent}return',
	]
}
