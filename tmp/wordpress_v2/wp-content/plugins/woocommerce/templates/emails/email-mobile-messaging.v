import rt

struct Class_Automattic_WooCommerce_Internal_Orders_MobileMessagingHandler {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_orders_mobilemessaginghandler(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Orders_MobileMessagingHandler {
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

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_order := rt.new_null()
	mut var_blog_id := rt.new_null()
	mut var_now := rt.new_null()
	mut var_domain := rt.new_null()
	mut iife_temp_0 := Class_Automattic_WooCommerce_Internal_Orders_MobileMessagingHandler{}
	mut iife_result_0 := iife_temp_0.prepare_mobile_message(var_order.clone(), var_blog_id.clone(),
		var_now.clone(), var_domain.clone())
	mut iife_temp_1 := Class_Automattic_WooCommerce_Internal_Orders_MobileMessagingHandler{}
	mut iife_result_1 := iife_temp_1.prepare_mobile_message(var_order.clone(), var_blog_id.clone(),
		var_now.clone(), var_domain.clone())
	rt.echo_val(rt.call_function('wp_kses_post', [iife_result_0]))
}
