module builder

import compiler.syntax as ast

pub struct FuncBuilder {
pub mut:
	php_name     string
	c_func       string
	return_spec  ReturnSpec
	args         []ClassMethodArg // reuse ClassMethodArg for function args
	attributes   []ClassAttribute
	uses_context bool
	table        &ast.Table = unsafe { nil } // SAFETY: nil literal in unsafe context
}

pub fn new_func_builder(php_name string, c_func string) &FuncBuilder {
	return &FuncBuilder{
		php_name:    php_name
		c_func:      c_func
		return_spec: new_return_spec('', '', '')
	}
}

pub fn new_func_builder_with_args(php_name string, c_func string, return_spec ReturnSpec, args []ClassMethodArg, uses_context bool) &FuncBuilder {
	return &FuncBuilder{
		php_name:     php_name
		c_func:       c_func
		return_spec:  return_spec
		args:         args
		uses_context: uses_context
	}
}

pub fn (b &FuncBuilder) render_fe() string {
	return '    PHP_FE(${b.php_name}, arginfo_${b.c_func})'
}

pub fn (b &FuncBuilder) render_declaration() string {
	return 'PHP_FUNCTION(${b.php_name});'
}

fn (b &FuncBuilder) compound_arginfo_setup() []string {
	if b.uses_context {
		return []
	}
	return compound_arginfo_setup(b.c_func, b.return_spec.resolved_type(), b.args, b.table)
}

pub fn (b &FuncBuilder) render_arginfo() string {
	if b.uses_context {
		return 'ZEND_BEGIN_ARG_INFO_EX(arginfo_${b.c_func}, 0, 0, 0)\nZEND_ARG_VARIADIC_TYPE_INFO(0, args, IS_MIXED, 0)\nZEND_END_ARG_INFO()'
	}
	mut res := []string{}
	resolved_return_type := b.return_spec.resolved_type()
	validate_php_return_type_or_panic(resolved_return_type, b.php_name)
	type_info := arg_type_info(resolved_return_type, b.table)
	required_args := required_arg_count(b.args)
	if b.compound_arginfo_setup().len > 0 {
		res << render_array_arginfo_header(b.c_func, required_args, resolved_return_type,
			b.return_spec.arginfo_obj_type(), type_info, true)
	} else {
		res << render_standard_arginfo_header(b.c_func, required_args, resolved_return_type,
			b.return_spec.arginfo_obj_type(), type_info)
	}
	for arg in b.args {
		res << arg.render_arginfo_line(b.php_name, b.table)
	}
	res << 'ZEND_END_ARG_INFO()'
	return res.join('\n')
}

pub fn (b FuncBuilder) render_attribute_minit_lines() []string {
	if b.attributes.len == 0 && b.args.all(it.attributes.len == 0) {
		return []
	}
	mut res := []string{}
	func_var := 'func_${b.c_func}'
	res << '{'
	res << '    zend_function *${func_var} = zend_hash_str_find_ptr_lc(CG(function_table), "${c_string_escape(b.php_name)}", sizeof("${c_string_escape(b.php_name)}")-1);'
	res << '    if (${func_var} != NULL) {'
	res << render_callable_attributes(func_var, b.c_func, b.attributes, b.args)
	res << '    }'
	res << '}'
	return res
}

pub fn (b FuncBuilder) export_fragments() ExportFragments {
	return ExportFragments{
		declarations:   [b.render_declaration()]
		minit_lines:    b.render_attribute_minit_lines()
		function_table: [b]
	}
}
