import rt

struct Class_Automattic_WooCommerce_Internal_StockNotifications_Factory {
	rt.PhpObjectBase
}

fn Class_Automattic_WooCommerce_Internal_StockNotifications_Factory.get_notification(notification_id i64) rt.PhpVal {
	if !(var_notification_id != 0) {
		return rt.new_bool(false)
	}
	mut var_notification := create_automattic_woocommerce_internal_stocknotifications_notification(rt.new_int(notification_id).dup())
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	return rt.new_object('Automattic_WooCommerce_Internal_StockNotifications_Notification', []string{}, var_notification)
	unsafe { goto end_label_1 }

catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'Automattic_WooCommerce_Internal_StockNotifications_Exception') {
		mut var_e := var_e_1.dup()
		rt.call_function('wc_caught_exception', [var_e.dup(), rt.new_string(@FN), rt.create_array([rt.ArrayItem{ key: none, val: notification_id }])])
		return rt.new_bool(false)
		unsafe { goto end_label_1 }
	}
	else {
		rt.throw_exception(var_e_1)
		unsafe { goto end_label_1 }
	}

end_label_1:
	return rt.new_null()
}

fn Class_Automattic_WooCommerce_Internal_StockNotifications_Factory.create_dummy_notification() rt.PhpVal {
	mut var_notification := create_automattic_woocommerce_internal_stocknotifications_notification()
	mut var_product := create_automattic_woocommerce_internal_stocknotifications_wc_product()
	var_product.set_name(rt.call_function('__', [rt.new_string('Dummy Product'), rt.new_string('woocommerce')]))
	var_product.set_price(rt.new_int(25))
	var_product.set_image_id(rt.call_function('get_option', [rt.new_string('woocommerce_placeholder_image'), rt.new_int(0)]))
	var_notification.set_product_id(var_product.get_id())
	var_notification.set_user_email(rt.new_string('preview@example.com'))
	rt.set_property(var_notification, 'product', var_product.dup())
	return mut var_notification
}

struct Class_Automattic_WooCommerce_Internal_StockNotifications_Notification {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_StockNotifications_WC_Product {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_stocknotifications_factory() &Class_Automattic_WooCommerce_Internal_StockNotifications_Factory {
	mut obj := &Class_Automattic_WooCommerce_Internal_StockNotifications_Factory{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_stocknotifications_notification() &Class_Automattic_WooCommerce_Internal_StockNotifications_Notification {
	mut obj := &Class_Automattic_WooCommerce_Internal_StockNotifications_Notification{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_stocknotifications_wc_product() &Class_Automattic_WooCommerce_Internal_StockNotifications_WC_Product {
	mut obj := &Class_Automattic_WooCommerce_Internal_StockNotifications_WC_Product{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Factory) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_notification' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			return Class_Automattic_WooCommerce_Internal_StockNotifications_Factory.get_notification(dispatch_arg_0)
		}
		'create_dummy_notification' {
			return Class_Automattic_WooCommerce_Internal_StockNotifications_Factory.create_dummy_notification()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_StockNotifications_Factory) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Factory) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Notification) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_StockNotifications_Notification) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Notification) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_WC_Product) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_StockNotifications_WC_Product) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_WC_Product) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_internal_stocknotifications_factory_php() {
	// unsupported statement: Stmt_Declare
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
