import rt

struct Class_Automattic_WooCommerce_Internal_Orders_MobileMessagingHandler {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_orders_mobilemessaginghandler() &Class_Automattic_WooCommerce_Internal_Orders_MobileMessagingHandler {
	mut obj := &Class_Automattic_WooCommerce_Internal_Orders_MobileMessagingHandler{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_Orders_MobileMessagingHandler) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Orders_MobileMessagingHandler) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Orders_MobileMessagingHandler) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_content_plugins_woocommerce_templates_emails_email_mobile_messaging_php() {
	mut var_order := rt.new_null()
	mut var_blog_id := rt.new_null()
	mut var_now := rt.new_null()
	mut var_domain := rt.new_null()
	rt.echo_val(rt.call_function('wp_kses_post', [fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal, arg_3 rt.PhpVal) rt.PhpVal {
		mut temp := Class_Automattic_WooCommerce_Internal_Orders_MobileMessagingHandler{}
		return temp.prepare_mobile_message(arg_0, arg_1, arg_2, arg_3)
	}(var_order.dup(), var_blog_id.dup(), var_now.dup(), var_domain.dup())]))
}
