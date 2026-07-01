import rt

struct Class_Automattic_WooCommerce_Blocks_Templates_AbstractPageTemplate {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Templates_AbstractPageTemplate) init() {
	rt.call_function('add_filter', [rt.new_string('page_template_hierarchy'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_Templates_AbstractPageTemplate', [
				'Automattic_WooCommerce_Blocks_Templates_AbstractTemplate',
			], &this) },
			rt.ArrayItem{ key: none, val: 'page_template_hierarchy' },
		]),
		rt.new_int(1)])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Templates_AbstractPageTemplate) get_placeholder_page() {
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Templates_AbstractPageTemplate) is_active_template() {
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Templates_AbstractPageTemplate) page_template_hierarchy(var_templates rt.PhpVal) rt.PhpVal {
	if rt.is_true(this.is_active_template()) {
		rt.call_function('array_unshift', [var_templates.dup(),
			Class_Automattic_WooCommerce_Blocks_Templates_static.slug()])
	}
	return var_templates.dup()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Templates_AbstractPageTemplate) page_template_title(var_title rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.new_bool(rt.is_true(this.is_active_template())
		&& rt.is_true(this.get_template_title())))
	{
		return this.get_template_title()
	}
	return var_title.dup()
}

struct Class_Automattic_WooCommerce_Blocks_Templates_AbstractTemplate {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blocks_templates_abstractpagetemplate() &Class_Automattic_WooCommerce_Blocks_Templates_AbstractPageTemplate {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Templates_AbstractPageTemplate{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_templates_abstracttemplate() &Class_Automattic_WooCommerce_Blocks_Templates_AbstractTemplate {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Templates_AbstractTemplate{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Templates_AbstractPageTemplate) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'init' {
			this.init()
			return rt.new_null()
		}
		'get_placeholder_page' {
			this.get_placeholder_page()
			return rt.new_null()
		}
		'is_active_template' {
			this.is_active_template()
			return rt.new_null()
		}
		'page_template_hierarchy' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.page_template_hierarchy(dispatch_arg_0)
		}
		'page_template_title' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.page_template_title(dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Blocks_Templates_AbstractPageTemplate) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Templates_AbstractPageTemplate) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
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

pub fn init_wp_content_plugins_woocommerce_src_blocks_templates_abstractpagetemplate_php() {
}
