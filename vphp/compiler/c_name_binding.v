module compiler

import compiler.php_types
import compiler.repr
import compiler.syntax as ast

fn (g CGenerator) ce_var_for_type(v_type string) string {
	key := php_types.normalize_export_type_key(v_type)
	if key in g.class_ce_by_type {
		return g.class_ce_by_type[key]
	}
	if key.contains('\\') {
		return '${key.replace('\\', '_').to_lower()}_ce'
	}
	return '${key.to_lower()}_ce'
}

fn (g CGenerator) php_name_for_type(v_type string) string {
	key := php_types.normalize_export_type_key(v_type)
	if key in g.class_ce_by_type {
		return g.class_php_by_type[key]
	}
	return ''
}

fn (g CGenerator) signature_arg_type(arg repr.PhpArgRepr, module_name string) string {
	if arg.php_type != '' {
		return arg.php_type
	}
	v_type := if arg.is_variadic && arg.v_type.starts_with('[]') {
		arg.v_type[2..]
	} else {
		arg.v_type
	}
	if php_type := g.interface_wrapper_signature(v_type, module_name) {
		return php_type
	}
	return g.named_type_signature(v_type, module_name, true)
}

fn (g CGenerator) signature_return_type(return_type string, declared_type string, has_export bool, module_name string) string {
	explicit := effective_export_php_return_type(return_type, declared_type, has_export)
	if explicit != '' {
		return explicit
	}
	if ReturnBinding.is_closure_type(return_type) {
		return 'Closure'
	}
	if php_type := g.interface_wrapper_signature(return_type, module_name) {
		return php_type
	}
	return g.named_type_signature(return_type, module_name, return_type.trim_left('!?').starts_with('&'))
}

fn (g CGenerator) named_type_signature(v_type string, module_name string, allow_struct bool) string {
	if g.table == unsafe { nil } {
		return ''
	}
	type_name := g.signature_v_type_name(v_type, module_name)
	sym := g.table.find_sym(type_name) or { return '' }
	if sym.kind == .enum || (allow_struct && sym.kind == .struct_) {
		php_name := g.class_php_by_type[type_name] or { return '' }
		return if v_type.starts_with('?') { '?${php_name}' } else { php_name }
	}
	if sym.info !is ast.SumType {
		return ''
	}
	sum := sym.info as ast.SumType
	mut members := []string{}
	mut has_named_member := false
	for variant in sum.variants {
		name := g.table.get_type_name(variant)
		if php_name := g.class_php_by_type[name] {
			members << php_name
			has_named_member = true
		} else if name in ['bool', 'int', 'i64', 'f64', 'float', 'string'] {
			members << name
		} else if name in ['[]string', '[]int', '[]i64', '[]f64', '[]bool', 'vphp.PhpArray'] {
			members << 'array'
		} else if name == 'none' {
			members << 'null'
		} else {
			return ''
		}
	}
	if v_type.starts_with('?') {
		members << 'null'
	}
	return if has_named_member { members.join('|') } else { '' }
}

fn (g CGenerator) signature_v_type_name(v_type string, module_name string) string {
	name := g.table.get_type_name(v_type)
	if module_name != '' && !name.contains('.') {
		qualified := '${module_name}.${name}'
		if _ := g.table.find_sym(qualified) {
			return qualified
		}
	}
	return name
}

fn (g CGenerator) named_interface_signature(v_type string, module_name string) ?string {
	value_type := v_type.trim_string_left('!')
	name := value_type.trim_string_left('?')
	key := if name.contains('.') { name } else { '${module_name}.${name}' }
	php_name := g.interface_php_by_type[key] or { return none }
	return if value_type.starts_with('?') { '?${php_name}' } else { php_name }
}

fn interface_wrapper_target(v_type string, module_name string, table &ast.Table) ?(string, string) {
	clean := v_type.trim_left('!?')
	resolved, origin := if table == unsafe { nil } {
		clean, module_name
	} else {
		table.resolve_type_alias(clean, module_name)
	}
	wrapper := resolved.trim_string_left('vphp.')
	if !wrapper.starts_with('PhpInterface[') || !wrapper.ends_with(']') {
		return none
	}
	return wrapper['PhpInterface['.len..wrapper.len - 1], origin
}

fn (g CGenerator) interface_wrapper_signature(v_type string, module_name string) ?string {
	target, origin := interface_wrapper_target(v_type, module_name, g.table)?
	php_name := g.named_interface_signature(target, origin)?
	return if v_type.starts_with('?') { '?${php_name}' } else { php_name }
}
