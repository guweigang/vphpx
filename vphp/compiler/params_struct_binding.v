module compiler

import compiler.repr

struct ParamsStructBinding {
	var_name    string
	params_type string
	fields      []repr.PhpArgRepr
	php_index   int
}

struct ParamsStructFieldBinding {
	arg      repr.PhpArgRepr
	var_name string
	index    int
}

struct ComputedParamsField {
	name   string
	v_type string
}

fn ParamsStructBinding.new(var_name string, params_type string, fields []repr.PhpArgRepr, php_index int) ParamsStructBinding {
	return ParamsStructBinding{
		var_name:    var_name
		params_type: params_type
		fields:      fields
		php_index:   php_index
	}
}

fn (binding ParamsStructBinding) call_name() string {
	return binding.var_name
}

fn (binding ParamsStructBinding) render_lines(returns_voidptr bool) []string {
	mut lines := []string{}
	mut field_vars := []string{}
	computed := binding.fields.filter(it.source.params_computed_default).map(ComputedParamsField{
		name:   it.source.params_field
		v_type: it.v_type
	})
	for offset, field_arg in binding.fields {
		php_index := binding.php_index + offset
		field_var := '${binding.var_name}_${field_arg.source.params_field}'
		field_binding := ParamsStructFieldBinding.new(field_arg, field_var, php_index)
		field_vars << field_var
		default_expr := if field_arg.source.params_computed_default && !field_arg.use_php_default {
			render_computed_params_default(binding.params_type, field_arg.source.params_field,
				computed, '', 'vphp.has_exception()', arg_return_stmt(returns_voidptr)).join('\n        ')
		} else {
			field_arg.source.params_v_default
		}
		lines << field_binding.render_lines(default_expr, returns_voidptr)
	}
	lines << '    ${binding.var_name} := ${binding.params_type}{'
	for offset, field_arg in binding.fields {
		lines << '        ${field_arg.source.params_field}: ${field_vars[offset]}'
	}
	lines << '    }'
	return lines
}

fn render_computed_params_default(params_type string, field string, computed []ComputedParamsField, indent string, exception_check string, return_stmt string) []string {
	mut lines := ['${indent}defaults := ${params_type}{']
	// Leave this field alone so V evaluates its initializer. Suppress computed
	// siblings so evaluating one omitted field has no effect on any other.
	for sibling in computed {
		if sibling.name != field {
			lines << '${indent}    ${sibling.name}: ${params_default_placeholder(sibling.v_type)}'
		}
	}
	lines << '${indent}}'
	lines << '${indent}if ${exception_check} {'
	lines << '${indent}    ${return_stmt}'
	lines << '${indent}}'
	lines << '${indent}defaults.${field}'
	return lines
}

fn params_default_placeholder(v_type string) string {
	if v_type.starts_with('?') {
		return 'none'
	}
	return match v_type {
		'bool' { 'false' }
		'string' { "''" }
		'int', 'i8', 'i16', 'i32', 'i64', 'isize', 'u8', 'u16', 'u32', 'u64', 'usize', 'f32', 'f64' {
			'${v_type}(0)'
		}
		else { 'vphp.struct_closure_default_placeholder[${v_type}]()' }
	}
}

fn ParamsStructFieldBinding.new(arg repr.PhpArgRepr, var_name string, index int) ParamsStructFieldBinding {
	return ParamsStructFieldBinding{
		arg:      arg
		var_name: var_name
		index:    index
	}
}

fn (binding ParamsStructFieldBinding) render_lines(default_expr string, returns_voidptr bool) []string {
	read := binding.read()
	value_expr := read.direct_expr() or { read.v_expr() }
	if binding.arg.use_php_default {
		return read.semantic_lines(binding.var_name, returns_voidptr) or {
			['    ${binding.var_name} := ${value_expr}']
		}
	}
	if semantic_lines := read.semantic_or_default_lines(binding.var_name, default_expr,
		returns_voidptr)
	{
		return semantic_lines
	}
	if binding.arg.source.params_computed_default {
		return [
			'    ${binding.var_name} := if ${read.has_arg_expr()} {',
			'        ${value_expr}',
			'    } else {',
			'        ${default_expr}',
			'    }',
		]
	}
	return [
		'    ${binding.var_name} := if ${read.has_arg_expr()} { ${value_expr} } else { ${default_expr} }',
	]
}

fn (binding ParamsStructFieldBinding) read() PhpArgRead {
	return PhpArgRead.new(binding.arg, binding.index)
}
