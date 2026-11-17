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

fn (g CGenerator) signature_arg_type(arg repr.PhpArgRepr) string {
	if arg.php_type != '' {
		return arg.php_type
	}
	v_type := if arg.is_variadic && arg.v_type.starts_with('[]') {
		arg.v_type[2..]
	} else {
		arg.v_type
	}
	return g.named_sumtype_signature(v_type)
}

fn (g CGenerator) signature_return_type(return_type string, declared_type string, has_export bool) string {
	explicit := effective_export_php_return_type(return_type, declared_type, has_export)
	return if explicit != '' { explicit } else { g.named_sumtype_signature(return_type) }
}

fn (g CGenerator) named_sumtype_signature(v_type string) string {
	if g.table == unsafe { nil } {
		return ''
	}
	sym := g.table.find_sym(g.table.get_type_name(v_type)) or { return '' }
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
