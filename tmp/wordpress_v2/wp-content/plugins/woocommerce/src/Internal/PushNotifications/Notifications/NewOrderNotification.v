import rt

pub fn Class_Automattic_WooCommerce_Internal_PushNotifications_Notifications_NewOrderNotification.type() string {
	return 'store_order'
}
pub fn Class_Automattic_WooCommerce_Internal_PushNotifications_Notifications_NewOrderNotification.icon() string {
	return 'https://s.wp.com/wp-content/mu-plugins/notes/images/update-payment-2x.png'
}
pub fn Class_Automattic_WooCommerce_Internal_PushNotifications_Notifications_NewOrderNotification.emoji_list() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: none, val: '🎉' }, rt.ArrayItem{ key: none, val: '🎊' }, rt.ArrayItem{ key: none, val: '🥳' }, rt.ArrayItem{ key: none, val: '👏' }, rt.ArrayItem{ key: none, val: '🙌' }])
}
struct Class_Automattic_WooCommerce_Internal_PushNotifications_Notifications_NewOrderNotification {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Internal_PushNotifications_Notifications_NewOrderNotification) get_type() string {
	return (Class_Automattic_WooCommerce_Internal_PushNotifications_Notifications_Automattic_WooCommerce_Internal_PushNotifications_Notifications_NewOrderNotification.type()).str()
}

fn (mut this Class_Automattic_WooCommerce_Internal_PushNotifications_Notifications_NewOrderNotification) to_payload() rt.PhpVal {
	mut var_order := rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'call_function', [rt.new_string('wc_get_order'), this.get_resource_id()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_order)))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_order, 'WC_Order')))))) {
		return rt.new_null()
	}
	return rt.create_array([rt.ArrayItem{ key: 'type', val: this.get_type() }, rt.ArrayItem{ key: 'icon', val: Class_Automattic_WooCommerce_Internal_PushNotifications_Notifications_Automattic_WooCommerce_Internal_PushNotifications_Notifications_NewOrderNotification.icon() }, rt.ArrayItem{ key: 'timestamp', val: rt.call_function('gmdate', [rt.new_string('c')]) }, rt.ArrayItem{ key: 'resource_id', val: this.get_resource_id() }, rt.ArrayItem{ key: 'title', val: rt.create_array([rt.ArrayItem{ key: 'format', val: 'You have a new order! %1$s' }, rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Internal_PushNotifications_Notifications_Automattic_WooCommerce_Internal_PushNotifications_Notifications_NewOrderNotification.emoji_list().array_get(rt.call_function('wp_rand', [rt.new_int(0), rt.new_int(Class_Automattic_WooCommerce_Internal_PushNotifications_Notifications_Automattic_WooCommerce_Internal_PushNotifications_Notifications_NewOrderNotification.emoji_list().array_count() - 1)])) }]) }]) }, rt.ArrayItem{ key: 'message', val: rt.create_array([rt.ArrayItem{ key: 'format', val: 'New order for %1$s on %2$s' }, rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.call_function('wp_strip_all_tags', [rt.call_method(var_order, 'get_formatted_order_total', []rt.PhpVal{})]) }, rt.ArrayItem{ key: none, val: rt.call_function('wp_strip_all_tags', [rt.call_function('get_bloginfo', [rt.new_string('name')])]) }]) }]) }, rt.ArrayItem{ key: 'meta', val: rt.create_array([rt.ArrayItem{ key: 'order_id', val: this.get_resource_id() }]) }])
}

fn (mut this Class_Automattic_WooCommerce_Internal_PushNotifications_Notifications_NewOrderNotification) has_meta(key string) bool {
	mut var_order := rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'call_function', [rt.new_string('wc_get_order'), this.get_resource_id()])
	return rt.is_true(rt.new_bool(rt.instance_of(var_order, 'WC_Order'))) && rt.is_true(rt.call_method(var_order, 'meta_exists', [rt.new_string(key)]))
}

fn (mut this Class_Automattic_WooCommerce_Internal_PushNotifications_Notifications_NewOrderNotification) write_meta(key string) {
	mut var_order := rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'call_function', [rt.new_string('wc_get_order'), this.get_resource_id()])
	if rt.is_true(rt.new_bool(rt.instance_of(var_order, 'WC_Order'))) {
		rt.call_method(var_order, 'update_meta_data', [rt.new_string(key), rt.new_string((rt.call_function('time', []rt.PhpVal{})).str())])
		rt.call_method(var_order, 'save_meta_data', []rt.PhpVal{})
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_PushNotifications_Notifications_NewOrderNotification) delete_meta(key string) {
	mut var_order := rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'call_function', [rt.new_string('wc_get_order'), this.get_resource_id()])
	if rt.is_true(rt.new_bool(rt.instance_of(var_order, 'WC_Order'))) {
		rt.call_method(var_order, 'delete_meta_data', [rt.new_string(key)])
		rt.call_method(var_order, 'save_meta_data', []rt.PhpVal{})
	}
}

struct Class_Automattic_WooCommerce_Internal_PushNotifications_Notifications_Notification {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_pushnotifications_notifications_newordernotification(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_PushNotifications_Notifications_NewOrderNotification {
	mut obj := &Class_Automattic_WooCommerce_Internal_PushNotifications_Notifications_NewOrderNotification{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_pushnotifications_notifications_notification(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_PushNotifications_Notifications_Notification {
	mut obj := &Class_Automattic_WooCommerce_Internal_PushNotifications_Notifications_Notification{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_PushNotifications_Notifications_NewOrderNotification) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_type' {
			return rt.new_string(this.get_type())
		}
		'to_payload' {
			return this.to_payload()
		}
		'has_meta' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(this.has_meta(dispatch_arg_0))
		}
		'write_meta' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			this.write_meta(dispatch_arg_0)
			return rt.new_null()
		}
		'delete_meta' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			this.delete_meta(dispatch_arg_0)
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_PushNotifications_Notifications_NewOrderNotification) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_PushNotifications_Notifications_NewOrderNotification) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Internal_PushNotifications_Notifications_Notification) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_PushNotifications_Notifications_Notification) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_PushNotifications_Notifications_Notification) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}



fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(exit(0)))
}
