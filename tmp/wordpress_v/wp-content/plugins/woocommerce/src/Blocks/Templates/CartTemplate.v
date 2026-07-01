import rt

pub fn Class_Automattic_WooCommerce_Blocks_Templates_CartTemplate.slug() string {
	return 'page-cart'
}
struct Class_Automattic_WooCommerce_Blocks_Templates_CartTemplate {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Templates_CartTemplate) get_template_title() rt.PhpVal {
	return rt.call_function('_x', [rt.new_string('Page: Cart'), rt.new_string('Template name'), rt.new_string('woocommerce')])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Templates_CartTemplate) get_template_description() rt.PhpVal {
	return rt.call_function('__', [rt.new_string('The Cart template displays the items selected by the user for purchase, including quantities, prices, and discounts. It allows users to review their choices before proceeding to checkout.'), rt.new_string('woocommerce')])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Templates_CartTemplate) get_placeholder_page() rt.PhpVal {
	mut var_page_id := rt.call_function('wc_get_page_id', [rt.new_string('cart')])
	return if rt.is_true(var_page_id) { rt.call_function('get_post', [var_page_id.dup()]) } else { rt.new_null() }
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Templates_CartTemplate) is_active_template() bool {
	mut var_post := rt.new_null()
	// unsupported statement: Stmt_Global
	mut var_placeholder := this.get_placeholder_page()
	return rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) && rt.is_true(rt.new_bool(rt.instance_of(var_post, 'Automattic_WooCommerce_Blocks_Templates_WP_Post'))))) && rt.is_true(rt.identical(rt.get_property(var_placeholder, 'post_name'), rt.get_property(var_post, 'post_name')))
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Templates_CartTemplate) page_template_hierarchy(var_templates rt.PhpVal) rt.PhpVal {
	if this.is_active_template() {
		rt.call_function('array_unshift', [var_templates.dup(), Class_Automattic_WooCommerce_Blocks_Templates_Automattic_WooCommerce_Blocks_Templates_CartTemplate.slug()])
		rt.call_function('array_unshift', [var_templates.dup(), rt.new_string('cart')])
	}
	return var_templates.dup()
}

struct Class_Automattic_WooCommerce_Blocks_Templates_AbstractPageTemplate {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blocks_templates_carttemplate() &Class_Automattic_WooCommerce_Blocks_Templates_CartTemplate {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Templates_CartTemplate{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_templates_abstractpagetemplate() &Class_Automattic_WooCommerce_Blocks_Templates_AbstractPageTemplate {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Templates_AbstractPageTemplate{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Templates_CartTemplate) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_template_title' {
			return this.get_template_title()
		}
		'get_template_description' {
			return this.get_template_description()
		}
		'get_placeholder_page' {
			return this.get_placeholder_page()
		}
		'is_active_template' {
			return rt.new_bool(this.is_active_template())
		}
		'page_template_hierarchy' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.page_template_hierarchy(dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Blocks_Templates_CartTemplate) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Templates_CartTemplate) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Blocks_Templates_AbstractPageTemplate) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_Templates_AbstractPageTemplate) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Templates_AbstractPageTemplate) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_blocks_templates_carttemplate_php() {
}
