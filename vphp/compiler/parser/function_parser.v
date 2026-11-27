module parser

import compiler.syntax as ast
import compiler.repr
import compiler.php_types

pub fn parse_function_decl(stmt ast.Stmt, table &ast.Table, params_structs map[string]repr.PhpParamsStruct) ?&repr.PhpFuncRepr {
	if stmt is ast.FnDecl {
		attrs := parse_callable_attrs(stmt.attrs, 'php_function', '')
		return parse_function_with_attrs(stmt, attrs, table, params_structs)
	}
	return none
}

fn parse_function_with_attrs(fn_decl ast.FnDecl, attrs ParsedCallableAttrs, table &ast.Table, params_structs map[string]repr.PhpParamsStruct) ?&repr.PhpFuncRepr {
	if fn_decl.attrs.any(it.name == 'php_ignore') {
		return none
	}
	mut func := repr.new_func_repr()
	if fn_decl.is_method {
		return none
	}

	if !attrs.has_php_callable {
		return none
	}
	php_name := attrs.php_name.trim_string_left('\\')
	if !php_name.contains('\\') && (php_name.starts_with('vphp_') || php_name.starts_with('zm_')) {
		return none
	}

	func.name = if attrs.php_name != '' { php_name } else { fn_decl.name.all_after_last('.') }
	func.module_name = fn_decl.module_name
	func.original_name = fn_decl.name.all_after_last('.')
	func.attributes = attrs.php_attributes
	func.args = build_php_args(fn_decl.params, fn_decl.module_name, table, 0, fn_decl.is_variadic,
		attrs, params_structs)
	ret_type := strip_module(table.type_to_str(fn_decl.return_type))
	v_return_type := if is_context_type(ret_type) || ret_type == '' || ret_type == 'void' {
		'void'
	} else {
		ret_type
	}
	mut php_return_type := attrs.php_return_type
	if fn_decl.is_noreturn && php_return_type == '' {
		php_return_type = 'never'
	}
	func.return_spec = repr.new_return_repr(v_return_type, php_return_type)
	func.uses_context = func.args.len == 1 && is_context_type(func.args[0].v_type)
		&& !php_types.is_reference_return(v_return_type)
	func.has_export = attrs.has_export
	func.borrowed_return = attrs.borrowed_return

	return func
}
