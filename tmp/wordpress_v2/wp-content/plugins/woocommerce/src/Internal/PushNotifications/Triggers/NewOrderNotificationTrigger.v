import rt

pub fn Class_Automattic_WooCommerce_Internal_PushNotifications_Triggers_NewOrderNotificationTrigger.notifiable_statuses() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: none, val: 'processing' },
		rt.ArrayItem{ key: none, val: 'on-hold' }, rt.ArrayItem{ key: none, val: 'completed' },
		rt.ArrayItem{ key: none, val: 'pre-order' }, rt.ArrayItem{ key: none, val: 'pre-ordered' },
		rt.ArrayItem{ key: none, val: 'partial-payment' }])
}

struct Class_Automattic_WooCommerce_Internal_PushNotifications_Triggers_NewOrderNotificationTrigger {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Internal_PushNotifications_Triggers_NewOrderNotificationTrigger) register() {
	rt.call_function('add_action', [rt.new_string('woocommerce_new_order'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_PushNotifications_Triggers_NewOrderNotificationTrigger',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'on_new_order' },
		]),
		rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_action', [rt.new_string('woocommerce_order_status_changed'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_PushNotifications_Triggers_NewOrderNotificationTrigger',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'on_order_status_changed' },
		]),
		rt.new_int(10), rt.new_int(4)])
}

fn (mut this Class_Automattic_WooCommerce_Internal_PushNotifications_Triggers_NewOrderNotificationTrigger) on_new_order(order_id i64, mut var_order Class_WC_Order) {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
		var_order.get_status(),
		Class_Automattic_WooCommerce_Internal_PushNotifications_Triggers_Automattic_WooCommerce_Internal_PushNotifications_Triggers_NewOrderNotificationTrigger.notifiable_statuses(),
		rt.new_bool(true)])))))
	{
		return
	}
	rt.call_method(rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [
		Class_Automattic_WooCommerce_Internal_PushNotifications_Services_PendingNotificationStore.class(),
	]), 'add', [
		create_automattic_woocommerce_internal_pushnotifications_notifications_newordernotification(rt.new_int(order_id)),
	])
}

fn (mut this Class_Automattic_WooCommerce_Internal_PushNotifications_Triggers_NewOrderNotificationTrigger) on_order_status_changed(order_id i64, previous_status string, next_status string, mut var_order Class_WC_Order) {
	if rt.is_true(rt.call_function('in_array', [rt.new_string(previous_status), Class_Automattic_WooCommerce_Internal_PushNotifications_Triggers_Automattic_WooCommerce_Internal_PushNotifications_Triggers_NewOrderNotificationTrigger.notifiable_statuses(), rt.new_bool(true)]))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [rt.new_string(next_status), Class_Automattic_WooCommerce_Internal_PushNotifications_Triggers_Automattic_WooCommerce_Internal_PushNotifications_Triggers_NewOrderNotificationTrigger.notifiable_statuses(), rt.new_bool(true)]))))) {
		return
	}
	rt.call_method(rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [
		Class_Automattic_WooCommerce_Internal_PushNotifications_Services_PendingNotificationStore.class(),
	]), 'add', [
		create_automattic_woocommerce_internal_pushnotifications_notifications_newordernotification(rt.new_int(order_id)),
	])
}

struct Class_Automattic_WooCommerce_Internal_PushNotifications_Notifications_NewOrderNotification {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_pushnotifications_triggers_newordernotificationtrigger(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_PushNotifications_Triggers_NewOrderNotificationTrigger {
	mut obj := &Class_Automattic_WooCommerce_Internal_PushNotifications_Triggers_NewOrderNotificationTrigger{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_pushnotifications_notifications_newordernotification(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_PushNotifications_Notifications_NewOrderNotification {
	mut obj := &Class_Automattic_WooCommerce_Internal_PushNotifications_Notifications_NewOrderNotification{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_PushNotifications_Triggers_NewOrderNotificationTrigger) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'register' {
			this.register()
			return rt.new_null()
		}
		'on_new_order' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_WC_Order](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			this.on_new_order(dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'on_order_status_changed' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			mut dispatch_arg_3 := rt.cast_object_ptr[Class_WC_Order](if args.len > 3 {
				args[3]
			} else {
				rt.new_null()
			})
			this.on_order_status_changed(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, mut
				dispatch_arg_3)
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_PushNotifications_Triggers_NewOrderNotificationTrigger) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_PushNotifications_Triggers_NewOrderNotificationTrigger) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Internal_PushNotifications_Notifications_NewOrderNotification) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_PushNotifications_Notifications_NewOrderNotification) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_PushNotifications_Notifications_NewOrderNotification) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}
