module compiler

import compiler.repr

enum StructClosureBindingKind {
	params_struct
	variadic
}

struct StructClosureBinding {
	unique            string
	alias             string
	bridge            string
	wrap              string
	arg_type          string
	ret_type          string
	fields            []repr.PhpParamsField
	kind              StructClosureBindingKind
	variadic_arg_type string
}

fn StructClosureBinding.new(unique string, return_type string, params_structs map[string]repr.PhpParamsStruct) ?StructClosureBinding {
	if !return_type.starts_with('fn (') || !return_type.contains(')') {
		return none
	}
	param_text := return_type.all_after('fn (').all_before(')').trim_space()
	ret_type := if return_type.contains(') ') {
		return_type.all_after(') ').trim_space()
	} else {
		'void'
	}
	if param_text == '' || param_text.contains(',') || ret_type == '' {
		return none
	}
	alias_name := pascal_struct_closure_name(sanitize_struct_closure_token(unique))
	safe := sanitize_struct_closure_token(unique).to_lower()
	if param_text.starts_with('...') {
		variadic_arg_type := normalize_struct_closure_type(param_text[3..])
		if is_supported_variadic_closure_arg(variadic_arg_type) {
			return StructClosureBinding{
				unique:            safe
				alias:             'VPhpVariadicClosure${alias_name}'
				bridge:            'vphp_variadic_closure_bridge_${safe}'
				wrap:              'vphp_wrap_variadic_closure_${safe}'
				arg_type:          variadic_arg_type
				ret_type:          ret_type
				kind:              .variadic
				variadic_arg_type: variadic_arg_type
			}
		}
		return none
	}
	arg_type := normalize_struct_closure_type(param_text)
	if params_struct := params_structs[arg_type] {
		return StructClosureBinding{
			unique:   safe
			alias:    'VPhpStructClosure${alias_name}'
			bridge:   'vphp_struct_closure_bridge_${safe}'
			wrap:     'vphp_wrap_struct_closure_${safe}'
			arg_type: arg_type
			ret_type: ret_type
			fields:   params_struct.fields
			kind:     .params_struct
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
	return type_name in ['PhpValue', 'vphp.PhpValue', 'ZVal', 'vphp.ZVal', 'RequestBorrowedZBox',
		'vphp.RequestBorrowedZBox', 'VScalarValue', 'vphp.VScalarValue']
}

fn (binding StructClosureBinding) render_helper_lines() []string {
	if binding.kind == .variadic {
		return binding.render_variadic_helper_lines()
	}
	mut lines := []string{}
	struct_signature := if binding.ret_type == 'void' {
		'fn (${binding.arg_type})'
	} else {
		'fn (${binding.arg_type}) ${binding.ret_type}'
	}
	lines << '__global C.${binding.arginfo_symbol()} voidptr'
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
	if binding.fields.len > 0 {
		lines << '        arg_count := ctx.num_args()'
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
		if i < required {
			lines << binding.render_field_read(field, i, 'field_${i}', '        ')
			continue
		}
		has_arg := if field.has_computed_default() {
			'arg_count > ${i} && !ctx.arg_val(${i}).is_undef()'
		} else {
			'arg_count > ${i}'
		}
		lines << '        field_${i} := if ${has_arg} {'
		lines << binding.render_field_read(field, i, 'provided_${i}', '            ')
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
	lines << binding.render_struct_call('        ')
	lines << '    }'
	lines << '}'
	lines << ''
	lines << 'fn ${binding.wrap}(ctx vphp.Context, cb ${binding.alias}) {'
	lines << '    ctx.create_saved_closure_with_arginfo[${binding.alias}](cb, voidptr(${binding.bridge}), ${binding.fields.len}, ${required}, C.${binding.arginfo_symbol()})'
	lines << '}'
	lines << ''
	return lines
}

fn (binding StructClosureBinding) render_variadic_helper_lines() []string {
	mut lines := []string{}
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
	if binding.ret_type == 'void' {
		lines << '        ctx.forward_variadic_closure_void[${binding.variadic_arg_type}](cb)'
	} else {
		lines << '        ctx.forward_variadic_closure[${binding.variadic_arg_type}, ${binding.ret_type}](cb)'
	}
	lines << '    }'
	lines << '}'
	lines << ''
	lines << 'fn ${binding.wrap}(ctx vphp.Context, cb ${binding.alias}) {'
	lines << '    ctx.create_saved_variadic_closure[${binding.alias}](cb, voidptr(${binding.bridge}))'
	lines << '}'
	lines << ''
	return lines
}

fn (binding StructClosureBinding) bridge_signature() string {
	return 'fn ${binding.bridge}(v_ptr voidptr, ex &C.zend_execute_data, ret &C.zval) {'
}

fn (binding StructClosureBinding) arginfo_symbol() string {
	return 'struct_closure_arginfo_${binding.unique}'
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

fn (binding StructClosureBinding) render_struct_call(indent string) []string {
	mut lines := ['${indent}args := ${binding.arg_type}{']
	for i, field in binding.fields {
		lines << '${indent}    ${field.name}: field_${i}'
	}
	lines << '${indent}}'
	if binding.ret_type == 'void' {
		lines << '${indent}ctx.forward_struct_closure_void[${binding.arg_type}](cb, args)'
	} else {
		lines << '${indent}ctx.forward_struct_closure[${binding.arg_type}, ${binding.ret_type}](cb, args)'
	}
	return lines
}

fn (binding StructClosureBinding) render_field_read(field repr.PhpParamsField, index int, variable string, indent string) []string {
	if field.v_type.starts_with('?') {
		inner := field.v_type[1..]
		mut lines := ['${indent}mut ${variable} := ${field.v_type}(none)']
		lines << '${indent}if !ctx.arg_val(${index}).is_null() {'
		if expr := php_context_arg_direct_expr(inner, index) {
			lines << '${indent}    ${variable} = ${expr}'
		} else {
			lines << '${indent}    ${variable} = ctx.arg_val(${index}).to_v[${inner}]() or {'
			lines << binding.render_field_type_error(field, index, indent + '        ')
			lines << '${indent}    }'
		}
		lines << '${indent}}'
		return lines
	}
	if expr := php_context_arg_direct_expr(field.v_type, index) {
		return ['${indent}${variable} := ${expr}']
	}
	mut lines := ['${indent}${variable} := ctx.arg_val(${index}).to_v[${field.v_type}]() or {']
	lines << binding.render_field_type_error(field, index, indent + '    ')
	lines << '${indent}}'
	return lines
}

fn (binding StructClosureBinding) render_field_type_error(field repr.PhpParamsField, index int, indent string) []string {
	return [
		"${indent}vphp.PhpException.raise_class('TypeError', 'argument ${index + 1} (${field.name}): \${err.msg()}', 0)",
		'${indent}return',
	]
}
