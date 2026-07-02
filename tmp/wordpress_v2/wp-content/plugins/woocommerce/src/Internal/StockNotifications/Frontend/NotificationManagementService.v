import rt

struct Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_NotificationManagementService {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_NotificationManagementService) get_resend_verification_email_url(mut var_notification Class_Automattic_WooCommerce_Internal_StockNotifications_Notification) string {
	mut var_url := rt.call_function('add_query_arg', [
		rt.create_array([
			rt.ArrayItem{ key: 'wc_bis_resend_notification', val: var_notification.get_id() },
		]),
		var_notification.get_product_permalink(),
	])
	return (rt.call_function('wp_nonce_url', [var_url.clone(),
		rt.new_string('wc_bis_resend_verification_email_nonce')])).str()
}

fn create_automattic_woocommerce_internal_stocknotifications_frontend_notificationmanagementservice(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_NotificationManagementService {
	mut obj := &Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_NotificationManagementService{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_NotificationManagementService) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_resend_verification_email_url' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_StockNotifications_Notification](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return rt.new_string(this.get_resend_verification_email_url(mut dispatch_arg_0))
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_NotificationManagementService) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_NotificationManagementService) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
