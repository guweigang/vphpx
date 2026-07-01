import rt

struct Class_Automattic_WooCommerce_Blocks_Templates_AbstractTemplateWithFallback {
	rt.PhpObjectBase
pub mut:
		fallback_template rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Templates_AbstractTemplateWithFallback) init()  {
	rt.call_function('add_filter', [rt.new_string('taxonomy_template_hierarchy'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_Templates_AbstractTemplateWithFallback', ['Automattic_WooCommerce_Blocks_Templates_AbstractTemplate'], &this) }, rt.ArrayItem{ key: none, val: 'template_hierarchy' }]), rt.new_int(1)])
	rt.call_function('add_action', [rt.new_string('template_redirect'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_Templates_AbstractTemplateWithFallback', ['Automattic_WooCommerce_Blocks_Templates_AbstractTemplate'], &this) }, rt.ArrayItem{ key: none, val: 'render_block_template' }])])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Templates_AbstractTemplateWithFallback) template_hierarchy(var_templates rt.PhpVal) rt.PhpVal {
	mut var_index := rt.call_function('array_search', [Class_Automattic_WooCommerce_Blocks_Templates_static.slug(), var_templates.dup(), rt.new_bool(true)])
	if rt.is_true(rt.identical(rt.new_bool(false), var_index)) {
		var_index = rt.call_function('array_search', [(Class_Automattic_WooCommerce_Blocks_Templates_static.slug()).str() + '.php', var_templates.dup(), rt.new_bool(true)])
	}
	if rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) && rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_templates.dup().array_isset(rt.add(var_index, rt.new_int(1)))))))) || rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))))) {
		rt.call_function('array_splice', [var_templates.dup(), rt.add(var_index, rt.new_int(1)), rt.new_int(0), this.fallback_template])
	}
	return var_templates.dup()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Templates_AbstractTemplateWithFallback) render_block_template()  {
}

struct Class_Automattic_WooCommerce_Blocks_Templates_AbstractTemplate {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blocks_templates_abstracttemplatewithfallback() &Class_Automattic_WooCommerce_Blocks_Templates_AbstractTemplateWithFallback {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Templates_AbstractTemplateWithFallback{
		PhpObjectBase: rt.PhpObjectBase{}
		fallback_template: rt.new_null()
	}
	return obj
}

fn create_automattic_woocommerce_blocks_templates_abstracttemplate() &Class_Automattic_WooCommerce_Blocks_Templates_AbstractTemplate {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Templates_AbstractTemplate{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Templates_AbstractTemplateWithFallback) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'init' {
			this.init()
			return rt.new_null()
		}
		'template_hierarchy' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.template_hierarchy(dispatch_arg_0)
		}
		'render_block_template' {
			this.render_block_template()
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Blocks_Templates_AbstractTemplateWithFallback) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'fallback_template' { return this.fallback_template }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Templates_AbstractTemplateWithFallback) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'fallback_template' { this.fallback_template = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_WooCommerce_Blocks_Templates_AbstractTemplate) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_Templates_AbstractTemplate) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Templates_AbstractTemplate) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_blocks_templates_abstracttemplatewithfallback_php() {
	// unsupported statement: Stmt_Declare
}
