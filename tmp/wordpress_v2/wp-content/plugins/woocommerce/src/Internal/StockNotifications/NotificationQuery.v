import rt

struct Class_Automattic_WooCommerce_Internal_StockNotifications_NotificationQuery {
	rt.PhpObjectBase
}

fn Class_Automattic_WooCommerce_Internal_StockNotifications_NotificationQuery.get_notifications(mut var_args Class_Automattic_WooCommerce_Internal_StockNotifications_array) rt.PhpVal {
	mut iife_temp_0 := Class_Automattic_WooCommerce_Internal_StockNotifications_WC_Data_Store{}
	mut iife_result_0 := iife_temp_0.load(rt.new_string('stock_notification'))
	return rt.call_method(iife_result_0, 'query', [var_args])
}

fn Class_Automattic_WooCommerce_Internal_StockNotifications_NotificationQuery.product_has_active_notifications(mut var_product_ids Class_Automattic_WooCommerce_Internal_StockNotifications_array) bool {
	mut iife_temp_1 := Class_Automattic_WooCommerce_Internal_StockNotifications_WC_Data_Store{}
	mut iife_result_1 := iife_temp_1.load(rt.new_string('stock_notification'))
	return (rt.call_method(iife_result_1, 'product_has_active_notifications', [
		var_product_ids,
	])).to_bool()
}

fn Class_Automattic_WooCommerce_Internal_StockNotifications_NotificationQuery.notification_exists_by_email(product_id i64, email string) bool {
	mut iife_temp_2 := Class_Automattic_WooCommerce_Internal_StockNotifications_WC_Data_Store{}
	mut iife_result_2 := iife_temp_2.load(rt.new_string('stock_notification'))
	return (rt.call_method(iife_result_2, 'notification_exists_by_email', [
		rt.new_int(product_id),
		rt.new_string(email),
	])).to_bool()
}

fn Class_Automattic_WooCommerce_Internal_StockNotifications_NotificationQuery.notification_exists_by_user_id(product_id i64, user_id i64) bool {
	mut iife_temp_3 := Class_Automattic_WooCommerce_Internal_StockNotifications_WC_Data_Store{}
	mut iife_result_3 := iife_temp_3.load(rt.new_string('stock_notification'))
	return (rt.call_method(iife_result_3, 'notification_exists_by_user_id', [
		rt.new_int(product_id),
		rt.new_int(user_id),
	])).to_bool()
}

struct Class_Automattic_WooCommerce_Internal_StockNotifications_WC_Data_Store {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_stocknotifications_notificationquery(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_StockNotifications_NotificationQuery {
	mut obj := &Class_Automattic_WooCommerce_Internal_StockNotifications_NotificationQuery{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_stocknotifications_wc_data_store(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_StockNotifications_WC_Data_Store {
	mut obj := &Class_Automattic_WooCommerce_Internal_StockNotifications_WC_Data_Store{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_NotificationQuery) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_notifications' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_StockNotifications_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return Class_Automattic_WooCommerce_Internal_StockNotifications_NotificationQuery.get_notifications(mut dispatch_arg_0)
		}
		'product_has_active_notifications' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_StockNotifications_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return rt.new_bool(Class_Automattic_WooCommerce_Internal_StockNotifications_NotificationQuery.product_has_active_notifications(mut dispatch_arg_0))
		}
		'notification_exists_by_email' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return rt.new_bool(Class_Automattic_WooCommerce_Internal_StockNotifications_NotificationQuery.notification_exists_by_email(dispatch_arg_0,
				dispatch_arg_1))
		}
		'notification_exists_by_user_id' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			return rt.new_bool(Class_Automattic_WooCommerce_Internal_StockNotifications_NotificationQuery.notification_exists_by_user_id(dispatch_arg_0,
				dispatch_arg_1))
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_StockNotifications_NotificationQuery) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_NotificationQuery) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_WC_Data_Store) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_StockNotifications_WC_Data_Store) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_WC_Data_Store) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
