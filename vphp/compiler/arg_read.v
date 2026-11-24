module compiler

import compiler.php_types
import compiler.repr
import compiler.syntax as ast

struct PhpArgRead {
	arg   repr.PhpArgRepr
	index int
}

fn PhpArgRead.new(arg repr.PhpArgRepr, index int) PhpArgRead {
	return PhpArgRead{
		arg:   arg
		index: index
	}
}

fn (read PhpArgRead) arg_expr() string {
	return 'php_args.at(${read.index})'
}

fn (read PhpArgRead) has_arg_expr() string {
	return 'php_args.has(${read.index})'
}

fn (read PhpArgRead) direct_expr() ?string {
	if read.arg.is_variadic {
		return none
	}
	return php_arg_direct_read_expr(read.arg_expr(), read.arg.v_type)
}

fn (read PhpArgRead) v_expr() string {
	if read.arg.is_variadic {
		mut inner_type := read.arg.v_type
		if inner_type.starts_with('[]') {
			inner_type = inner_type[2..]
		}
		return 'php_args.as_variadic_v[${inner_type}](${read.index})'
	}
	return php_arg_v_read_expr(read.arg_expr(), read.arg.v_type)
}

fn (read PhpArgRead) semantic_lines(var_name string, returns_voidptr bool) ?[]string {
	if read.arg.is_variadic {
		if php_types.accepts_named_variadic(read.arg.v_type, true) {
			return [
				'    ${var_name} := ctx.variadic_php_args(php_args, ${read.index}) or {',
				'        ${arg_return_stmt(returns_voidptr)}',
				'    }',
			]
		}
		if !php_types.is_reference_parameter(read.arg.v_type, true) {
			return read.variadic_wrapper_lines(var_name, returns_voidptr)
		}
		return [
			'    ${var_name} := php_args.variadic_references(${read.index}) or {',
			"        vphp.PhpException.raise_class('TypeError', err.msg(), 0)",
			'        ${arg_return_stmt(returns_voidptr)}',
			'    }',
		]
	}
	v_type := read.arg.v_type
	if v_type.starts_with('?') {
		inner := v_type[1..]
		spec := php_types.PhpTypeSpec.semantic_wrapper_for(inner) or { return none }
		if spec.is_total_arg {
			return [
				'    ${var_name} := if ${read.has_arg_expr()} { ?${inner}(${read.arg_expr()}.value) } else { none }',
			]
		}
		return [
			'    ${var_name} := ${read.arg_expr()}.${spec.arg_method}()',
		]
	}
	spec := php_types.PhpTypeSpec.semantic_wrapper_for(v_type) or { return none }
	if spec.is_total_arg {
		return ['    ${var_name} := ${read.arg_expr()}.value']
	}
	return [
		'    ${var_name} := ${read.arg_expr()}.${spec.arg_method}() or {',
		"        vphp.throw_exception('argument ${read.index} must be ${spec.arg_label}', 0)",
		'        ${arg_return_stmt(returns_voidptr)}',
		'    }',
	]
}

fn (read PhpArgRead) variadic_wrapper_lines(var_name string, returns_voidptr bool) ?[]string {
	element := read.arg.v_type.trim_string_left('[]')
	inner := element.trim_string_left('?')
	spec := php_types.PhpTypeSpec.semantic_wrapper_for(inner) or { return none }
	index := '${var_name}_index'
	arg := 'php_args.at(${index})'
	mut lines := [
		'    mut ${var_name} := []${element}{}',
		'    for ${index} in ${read.index} .. php_args.len() {',
	]
	if spec.is_total_arg {
		value := '${arg}.value'
		lines << '        ${var_name} << ${if element == inner {
			value
		} else {
			'${element}(${value})'
		}}'
	} else {
		if element != inner {
			lines << '        if ${arg}.zval().is_null() {'
			lines << '            ${var_name} << none'
			lines << '            continue'
			lines << '        }'
		}
		item := '${var_name}_item'
		lines << '        ${item} := ${arg}.${spec.arg_method}() or {'
		lines << "            vphp.PhpException.raise_class('TypeError', 'Argument #\${${index} + 1} must be ${spec.arg_label}', 0)"
		lines << '            ${arg_return_stmt(returns_voidptr)}'
		lines << '        }'
		lines << '        ${var_name} << ${if element == inner {
			item
		} else {
			'${element}(${item})'
		}}'
	}
	lines << '    }'
	return lines
}

fn (read PhpArgRead) semantic_or_default_lines(var_name string, default_expr string, returns_voidptr bool) ?[]string {
	if read.arg.is_variadic {
		return none
	}
	spec := php_types.PhpTypeSpec.semantic_wrapper_for(read.arg.v_type) or { return none }
	if spec.is_total_arg {
		return none
	}
	return [
		'    ${var_name} := if ${read.has_arg_expr()} {',
		'        ${read.arg_expr()}.${spec.arg_method}() or {',
		"            vphp.throw_exception('argument ${read.index} must be ${spec.arg_label}', 0)",
		'            ${arg_return_stmt(returns_voidptr)}',
		'        }',
		'    } else {',
		'        ${default_expr}',
		'    }',
	]
}

fn php_arg_direct_read_expr(arg_expr string, v_type string) ?string {
	return match v_type {
		'vphp.ZVal', 'ZVal', 'Callable', 'vphp.Callable' {
			'${arg_expr}.zval()'
		}
		'RequestBorrowedZBox', 'vphp.RequestBorrowedZBox' {
			'${arg_expr}.zbox()'
		}
		'RequestOwnedZBox', 'vphp.RequestOwnedZBox' {
			'${arg_expr}.request_owned_zbox()'
		}
		'PersistentOwnedZBox', 'vphp.PersistentOwnedZBox' {
			'${arg_expr}.persistent_owned_zbox()'
		}
		'?RequestBorrowedZBox', '?vphp.RequestBorrowedZBox' {
			'${arg_expr}.zbox_opt()'
		}
		else {
			none
		}
	}
}

fn php_arg_v_read_expr(arg_expr string, v_type string) string {
	if v_type.starts_with('?') {
		return '${arg_expr}.as_v_opt[${v_type[1..]}]()'
	}
	return '${arg_expr}.as_v[${v_type}]()'
}

fn php_context_arg_direct_expr(v_type string, index int) ?string {
	return match v_type {
		'ZVal', 'vphp.ZVal' {
			'ctx.arg_val(${index})'
		}
		'RequestBorrowedZBox', 'vphp.RequestBorrowedZBox' {
			'ctx.arg_borrowed_zbox(${index})'
		}
		'PhpValue', 'vphp.PhpValue' {
			'ctx.arg_value(${index})'
		}
		else {
			none
		}
	}
}

fn (read PhpArgRead) checked_object_lines(var_name string, fallback ?string, returns_voidptr bool, module_name string, table &ast.Table) ?[]string {
	v_type := if read.arg.is_variadic {
		read.arg.v_type.trim_string_left('[]')
	} else {
		read.arg.v_type
	}
	inner := v_type.trim_left('?')
	converter := if _, _ := interface_wrapper_target(v_type, module_name, table) {
		'zval().to_v[${inner}]()'
	} else {
		if table == unsafe { nil } || !inner.starts_with('&') {
			return none
		}
		sym := table.find_sym(inner[1..]) or { return none }
		if sym.kind != .struct_ {
			return none
		}
		'bound_v_object[${inner[1..]}]()'
	}

	if read.arg.is_variadic {
		items := '${var_name}_index'
		expr := checked_object_expr(v_type, 'php_args.at(${items})', converter, returns_voidptr)
		return [
			'    mut ${var_name} := []${v_type}{}',
			'    for ${items} in ${read.index} .. php_args.len() {',
			'        ${var_name}_item := ${expr.replace('\n', '\n        ')}',
			'        ${var_name} << ${var_name}_item',
			'    }',
		]
	}
	expr := checked_object_expr(v_type, read.arg_expr(), converter, returns_voidptr)
	if default_expr := fallback {
		return [
			'    ${var_name} := if !${read.has_arg_expr()} {',
			'        ${default_expr}',
			'    } else {',
			'        ${expr.replace('\n', '\n        ')}',
			'    }',
		]
	}
	return ['    ${var_name} := ${expr.replace('\n', '\n    ')}']
}

fn bound_object_expr(v_type string, inner string, arg_expr string, returns_voidptr bool) string {
	return checked_object_expr(v_type, arg_expr, 'bound_v_object[${inner}]()', returns_voidptr)
}

fn checked_object_expr(v_type string, arg_expr string, converter string, returns_voidptr bool) string {
	checked := [
		'${arg_expr}.${converter} or {',
		"    vphp.PhpException.raise_class('TypeError', err.msg(), 0)",
		'    ${arg_return_stmt(returns_voidptr)}',
		'}',
	].join('\n')
	if v_type.starts_with('?') {
		return [
			'if !${arg_expr}.is_present() || ${arg_expr}.zval().is_null() {',
			'    ${v_type}(none)',
			'} else {',
			'    bound_value := ${checked.replace('\n', '\n    ')}',
			'    ${v_type}(bound_value)',
			'}',
		].join('\n')
	}
	return checked
}
