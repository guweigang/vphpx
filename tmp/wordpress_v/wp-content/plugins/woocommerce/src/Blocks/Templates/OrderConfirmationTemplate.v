import rt

pub fn Class_Automattic_WooCommerce_Blocks_Templates_OrderConfirmationTemplate.slug() string {
	return 'order-confirmation'
}

struct Class_Automattic_WooCommerce_Blocks_Templates_OrderConfirmationTemplate {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Templates_OrderConfirmationTemplate) init() {
	rt.call_function('add_action', [rt.new_string('wp_before_admin_bar_render'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_Templates_OrderConfirmationTemplate', [
				'Automattic_WooCommerce_Blocks_Templates_AbstractPageTemplate',
			], &this) },
			rt.ArrayItem{ key: none, val: 'remove_edit_page_link' },
		])])
	rt.call_function('add_filter', [rt.new_string('pre_get_document_title'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_Templates_OrderConfirmationTemplate', [
				'Automattic_WooCommerce_Blocks_Templates_AbstractPageTemplate',
			], &this) },
			rt.ArrayItem{ key: none, val: 'page_template_title' },
		])])
	this.Class_Automattic_WooCommerce_Blocks_Templates_AbstractPageTemplate.init()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Templates_OrderConfirmationTemplate) get_template_title() rt.PhpVal {
	return rt.call_function('_x', [rt.new_string('Order Confirmation'),
		rt.new_string('Template name'), rt.new_string('woocommerce')])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Templates_OrderConfirmationTemplate) get_template_description() rt.PhpVal {
	return rt.call_function('__', [
		rt.new_string('The Order Confirmation template serves as a receipt and confirmation of a successful purchase. It includes a summary of the ordered items, shipping, billing, and totals.'),
		rt.new_string('woocommerce'),
	])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Templates_OrderConfirmationTemplate) remove_edit_page_link() {
	mut var_wp_admin_bar := rt.new_null()
	if rt.is_true(this.is_active_template()) {
		// unsupported statement: Stmt_Global
		rt.call_method(var_wp_admin_bar, 'remove_menu', [rt.new_string('edit')])
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Templates_OrderConfirmationTemplate) get_placeholder_page() rt.PhpVal {
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Templates_OrderConfirmationTemplate) is_active_template() rt.PhpVal {
	return rt.call_function('is_wc_endpoint_url', [rt.new_string('order-received')])
}

struct Class_Automattic_WooCommerce_Blocks_Templates_AbstractPageTemplate {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blocks_templates_orderconfirmationtemplate() &Class_Automattic_WooCommerce_Blocks_Templates_OrderConfirmationTemplate {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Templates_OrderConfirmationTemplate{
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

fn (mut this Class_Automattic_WooCommerce_Blocks_Templates_OrderConfirmationTemplate) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'init' {
			this.init()
			return rt.new_null()
		}
		'get_template_title' {
			return this.get_template_title()
		}
		'get_template_description' {
			return this.get_template_description()
		}
		'remove_edit_page_link' {
			this.remove_edit_page_link()
			return rt.new_null()
		}
		'get_placeholder_page' {
			return this.get_placeholder_page()
		}
		'is_active_template' {
			return this.is_active_template()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Blocks_Templates_OrderConfirmationTemplate) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Templates_OrderConfirmationTemplate) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

pub fn init_wp_content_plugins_woocommerce_src_blocks_templates_orderconfirmationtemplate_php() {
}
