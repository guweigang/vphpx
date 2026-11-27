module compiler

import compiler.syntax as ast
import compiler.builder
import compiler.repr

pub struct CGenerator {
pub:
	ext_name              string
	class_ce_by_type      map[string]string
	class_php_by_type     map[string]string
	interface_php_by_type map[string]string
	table                 &ast.Table = unsafe { nil } // SAFETY: nil literal in unsafe context
}

fn (g CGenerator) build_func_export(f &repr.PhpFuncRepr) builder.ExportFragments {
	func_builder := g.build_func(f)
	mut fragments := func_builder.export_fragments()
	fragments.implementations = func_builder.for_php_version(g.gen_func_c(f))
	return fragments
}

fn (g CGenerator) build_interface_export(r &repr.PhpInterfaceRepr) builder.ExportFragments {
	return g.build_interface_type(r).export_fragments(g.gen_interface_c(r))
}

fn (g CGenerator) build_enum_export(r &repr.PhpEnumRepr) builder.ExportFragments {
	return g.build_enum_type(r).export_fragments(g.gen_enum_c(r))
}

fn (g CGenerator) build_class_export(r &repr.PhpClassRepr) builder.ExportFragments {
	has_init := r.methods.any(it.is_constructor())
	return g.build_class_type(r, has_init).export_fragments(g.gen_class_c(r))
}
