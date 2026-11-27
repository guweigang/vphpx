module compiler

import compiler.builder
import compiler.repr

fn (g CGenerator) gen_interface_c(r &repr.PhpInterfaceRepr) []string {
	mut c := []string{}
	class_builder := g.build_interface_type(r)
	c << class_builder.render_impl_prelude()
	c << class_builder.render_impl_postlude()
	return c
}

fn (g CGenerator) gen_enum_c(r &repr.PhpEnumRepr) []string {
	mut c := []string{}
	class_builder := g.build_enum_type(r)

	c << class_builder.render_impl_prelude()
	owner := r.method_owner()
	for method in r.methods {
		plan := g.build_class_method_c_glue_plan(&owner, method, r.c_name(), false)
		c << builder.for_php_version_range(method.min_php_version, method.max_php_version_exclusive,
			g.render_class_method_c(plan))
	}
	c << class_builder.render_impl_postlude()

	return c
}
