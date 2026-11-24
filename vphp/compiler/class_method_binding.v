module compiler

import compiler.syntax as ast
import compiler.repr

struct ClassMethodGlue {
	glue_name    string
	helper_lines []string
	arg_setup    PhpArgSetup
	context      ClassMethodGlueContext
}

struct ClassMethodGlueContext {
	type_ref                string
	lower_name              string
	static_sync_prefix      string
	is_static               bool
	is_native_trait         bool
	is_enum                 bool
	uses_inherited_receiver bool
	returns_object          bool
	return_type             string
	call_expr               string
	arg_names               []string
	return_binding          ReturnBinding
}

fn ClassMethodGlue.new(r &repr.PhpClassRepr, lower_name string, uses_inherited_receiver bool, method repr.PhpMethodRepr, params_structs map[string]repr.PhpParamsStruct, type_ref string, table &ast.Table) ?ClassMethodGlue {
	if method.has_export || method.native_trait_source != '' {
		return none
	}
	glue_name := if method.v_name != '' { method.v_name } else { method.name }
	return_type := method.return_spec.effective_v_type()
	struct_closure := StructClosureBinding.new('${r.name}_${glue_name}', return_type,
		r.module_name, params_structs, table)
	mut helper_lines := []string{}
	if closure_binding := struct_closure {
		helper_lines << closure_binding.render_helper_lines(method.borrowed_return, table)
	}
	return_info := class_method_runtime_return_info(r, &method)
	return_binding := ReturnBinding.new(return_type, struct_closure, method.borrowed_return)
	returns_object := !method.is_constructor()
		&& return_info.kind in [.static_factory, .static_object, .instance_object]
	arg_setup := build_php_arg_setup(method.args, returns_object, true, r.module_name, table)
	arg_names := arg_setup.names
	call_expr := class_method_call_expr(type_ref, method, uses_inherited_receiver, arg_names)
	return ClassMethodGlue{
		glue_name:    glue_name
		helper_lines: helper_lines
		arg_setup:    arg_setup
		context:      ClassMethodGlueContext{
			type_ref:                type_ref
			lower_name:              lower_name
			static_sync_prefix:      if r.shadow_static_name != '' {
				class_static_state_name(r)
			} else {
				''
			}
			is_static:               method.is_static
			is_native_trait:         r.is_native_trait
			is_enum:                 r.is_enum
			uses_inherited_receiver: uses_inherited_receiver
			returns_object:          returns_object
			return_type:             return_type
			call_expr:               call_expr
			arg_names:               arg_names
			return_binding:          return_binding
		}
	}
}

fn class_method_call_expr(type_ref string, method repr.PhpMethodRepr, uses_inherited_receiver bool, arg_names []string) string {
	call_args := arg_names.join(', ')
	v_name := if method.v_name != '' { method.v_name } else { method.name }
	v_call_name := if is_v_keyword(v_name) { '@' + v_name } else { v_name }
	if method.is_static {
		receiver := if method.trait_static_receiver != '' {
			method.trait_static_receiver
		} else {
			type_ref
		}
		return '${receiver}.${v_call_name}(${call_args})'
	}
	if uses_inherited_receiver {
		return 'recv.${v_call_name}(${call_args})'
	}
	return 'recv.${v_call_name}(${call_args})'
}

fn (glue ClassMethodGlue) render_lines() []string {
	mut lines := []string{}
	lines << glue.helper_lines
	lines << glue.context.render_wrapper_start_lines(glue.glue_name)
	lines << glue.context.render_scope_lines()
	if glue.context.uses_inherited_receiver && !glue.context.is_static {
		lines << glue.context.render_receiver_lines()
	}
	lines << glue.arg_setup.lines
	lines << glue.context.render_static_sync_scope_lines()
	lines << glue.context.render_return_lines()
	lines << '}'
	return lines
}

fn (ctx ClassMethodGlueContext) capture_list() string {
	mut captures := ctx.arg_names.clone()
	if !ctx.is_static {
		if ctx.uses_inherited_receiver {
			captures << ['mut recv', 'this_obj', 'original_recv']
		} else {
			captures << 'recv'
		}
	}
	return ReturnBinding.capture_list(captures)
}

fn (ctx ClassMethodGlueContext) return_decl() string {
	return if ctx.returns_object { 'voidptr' } else { '' }
}

fn (ctx ClassMethodGlueContext) render_wrapper_start_lines(glue_name string) []string {
	mut lines := []string{}
	lines << "@[export: 'vphp_wrap_${ctx.lower_name}_${glue_name}']"
	if ctx.is_static || ctx.is_native_trait || ctx.is_enum {
		lines << 'pub fn vphp_wrap_${ctx.lower_name}_${glue_name}(ctx vphp.Context) ${ctx.return_decl()} {'
		if ctx.is_enum && !ctx.is_static {
			lines << '    recv := ctx.ex.this_zend_object().enum_case_to_v[${ctx.type_ref}]() or {'
			lines << '        vphp.throw_exception(err.msg(), 0)'
			lines << if ctx.returns_object {
				'        return unsafe { nil }'
			} else {
				'        return'
			}
			lines << '    }'
		} else if !ctx.is_static {
			lines << '    mut recv := ${ctx.type_ref}{}'
		}
	} else {
		lines << 'pub fn vphp_wrap_${ctx.lower_name}_${glue_name}(ptr voidptr, ctx vphp.Context) ${ctx.return_decl()} {'
		if !ctx.uses_inherited_receiver {
			lines << ctx.render_receiver_lines()
		}
	}
	return lines
}

fn (ctx ClassMethodGlueContext) render_receiver_lines() []string {
	if ctx.is_static {
		return []
	}
	if ctx.uses_inherited_receiver {
		return [
			'    this_obj := vphp.ZendObject.from_ptr(ptr)',
			'    mut recv := ${ctx.lower_name}_load_from_php(this_obj)',
			'    original_recv := ${ctx.lower_name}_snapshot(recv)',
		]
	}
	return ['    mut recv := unsafe { &${ctx.type_ref}(ptr) }']
}

fn (ctx ClassMethodGlueContext) render_scope_lines() []string {
	return [
		'    mut vphp_scope := vphp.PhpScope.once()',
		'    defer { vphp_scope.close() }',
	]
}

fn (ctx ClassMethodGlueContext) render_static_sync_scope_lines() []string {
	if ctx.static_sync_prefix == '' {
		return []
	}
	prefix := ctx.static_sync_prefix
	return [
		'    mut vphp_static_sync := vphp.begin_static_sync(ctx, ${prefix}_from_php, ${prefix}_to_php)',
		'    defer { vphp_static_sync.close() }',
	]
}

fn (ctx ClassMethodGlueContext) render_inherited_sync_to_php_lines() []string {
	if !ctx.uses_inherited_receiver || ctx.is_static {
		return []
	}
	return ['    ${ctx.lower_name}_sync_to_php(this_obj, original_recv, recv)']
}

fn (ctx ClassMethodGlueContext) render_object_return_lines() []string {
	if !ctx.returns_object {
		return []
	}
	if ctx.return_binding.kind != .void_ {
		return ['    return voidptr(res)']
	}
	if ctx.is_static {
		return ['    return voidptr(0)']
	}
	return ['    return ptr']
}

fn (ctx ClassMethodGlueContext) render_return_lines() []string {
	match ctx.return_binding.kind {
		.result, .option {
			setup := if ctx.uses_inherited_receiver && !ctx.is_static {
				['        defer { ${ctx.lower_name}_sync_to_php(this_obj, original_recv, recv) }']
			} else {
				[]string{}
			}
			return ctx.return_binding.render_fallible_call_lines(ctx.call_expr,
				ctx.capture_list(), setup)
		}
		.void_ {
			mut lines := ['    ${ctx.call_expr}']
			lines << ctx.render_inherited_sync_to_php_lines()
			lines << ctx.render_object_return_lines()
			return lines
		}
		.closure {
			mut lines := ['    res := ${ctx.call_expr}']
			lines << ctx.render_inherited_sync_to_php_lines()
			lines << ctx.return_binding.render_closure_value_lines(true)
			lines << ctx.render_object_return_lines()
			return lines
		}
		.value {
			mut lines := ['    res := ${ctx.call_expr}']
			lines << ctx.render_inherited_sync_to_php_lines()
			if !ctx.returns_object {
				lines << ctx.return_binding.render_value_result_line('res')
			}
			lines << ctx.render_object_return_lines()
			return lines
		}
	}
}
