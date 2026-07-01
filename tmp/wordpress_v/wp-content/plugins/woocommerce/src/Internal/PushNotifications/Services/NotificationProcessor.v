import rt

pub fn Class_Automattic_WooCommerce_Internal_PushNotifications_Services_NotificationProcessor.action_scheduler_group() string {
	return 'wc-push-notifications'
}
pub fn Class_Automattic_WooCommerce_Internal_PushNotifications_Services_NotificationProcessor.safety_net_delay() i64 {
	return 60
}
pub fn Class_Automattic_WooCommerce_Internal_PushNotifications_Services_NotificationProcessor.safety_net_hook() string {
	return 'wc_push_notification_safety_net'
}
pub fn Class_Automattic_WooCommerce_Internal_PushNotifications_Services_NotificationProcessor.claimed_meta_key() string {
	return '_wc_push_notification_claimed'
}
pub fn Class_Automattic_WooCommerce_Internal_PushNotifications_Services_NotificationProcessor.sent_meta_key() string {
	return '_wc_push_notification_sent'
}
struct Class_Automattic_WooCommerce_Internal_PushNotifications_Services_NotificationProcessor {
	rt.PhpObjectBase
pub mut:
		dispatcher rt.PhpVal = rt.new_null()
		data_store rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_PushNotifications_Services_NotificationProcessor) init(mut var_dispatcher Class_Automattic_WooCommerce_Internal_PushNotifications_Dispatchers_WpcomNotificationDispatcher, mut var_data_store Class_Automattic_WooCommerce_Internal_PushNotifications_DataStores_PushTokensDataStore)  {
	this.dispatcher = var_dispatcher.dup()
	this.data_store = var_data_store.dup()
}

fn (mut this Class_Automattic_WooCommerce_Internal_PushNotifications_Services_NotificationProcessor) register()  {
	rt.call_function('add_action', [Class_Automattic_WooCommerce_Internal_PushNotifications_Services_Automattic_WooCommerce_Internal_PushNotifications_Services_NotificationProcessor.safety_net_hook(), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_PushNotifications_Services_NotificationProcessor', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'handle_safety_net' }]), rt.new_int(10), rt.new_int(2)])
}

fn (mut this Class_Automattic_WooCommerce_Internal_PushNotifications_Services_NotificationProcessor) process(mut var_notification Class_Automattic_WooCommerce_Internal_PushNotifications_Notifications_Notification, is_retry bool) bool {
	mut var_notification_mutated := var_notification
	if rt.is_true(rt.call_method(var_notification_mutated, 'has_meta', [Class_Automattic_WooCommerce_Internal_PushNotifications_Services_Automattic_WooCommerce_Internal_PushNotifications_Services_NotificationProcessor.sent_meta_key()])) {
		return true
	}
	if !(var_is_retry) {
		if rt.is_true(rt.call_method(var_notification_mutated, 'has_meta', [Class_Automattic_WooCommerce_Internal_PushNotifications_Services_Automattic_WooCommerce_Internal_PushNotifications_Services_NotificationProcessor.claimed_meta_key()])) {
			return true
		}
		rt.call_method(var_notification_mutated, 'write_meta', [Class_Automattic_WooCommerce_Internal_PushNotifications_Services_Automattic_WooCommerce_Internal_PushNotifications_Services_NotificationProcessor.claimed_meta_key()])
	}
	mut var_tokens := rt.call_method(this.data_store, 'get_tokens_for_roles', [Class_Automattic_WooCommerce_Internal_PushNotifications_PushNotifications.roles_with_push_notifications_enabled()])
	if !rt.is_true(var_tokens) {
		rt.call_method(var_notification_mutated, 'write_meta', [Class_Automattic_WooCommerce_Internal_PushNotifications_Services_Automattic_WooCommerce_Internal_PushNotifications_Services_NotificationProcessor.sent_meta_key()])
		return true
	}
	mut var_result := rt.call_method(this.dispatcher, 'dispatch', [var_notification_mutated.dup(), var_tokens.dup()])
	if !(!rt.is_true(var_result.array_get('success'))) {
		rt.call_method(var_notification_mutated, 'write_meta', [Class_Automattic_WooCommerce_Internal_PushNotifications_Services_Automattic_WooCommerce_Internal_PushNotifications_Services_NotificationProcessor.sent_meta_key()])
		rt.call_method(var_notification_mutated, 'delete_meta', [Class_Automattic_WooCommerce_Internal_PushNotifications_Services_Automattic_WooCommerce_Internal_PushNotifications_Services_NotificationProcessor.claimed_meta_key()])
		return true
	}
	return false
}

fn (mut this Class_Automattic_WooCommerce_Internal_PushNotifications_Services_NotificationProcessor) handle_safety_net(type string, resource_id i64)  {
	mut var_notification := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_PushNotifications_Notifications_Notification{}; return temp.from_array(arg_0) }(rt.create_array([rt.ArrayItem{ key: 'type', val: type }, rt.ArrayItem{ key: 'resource_id', val: resource_id }]))
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	this.process(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_PushNotifications_Notifications_Notification](var_notification), true)
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	unsafe { goto end_label_1 }

catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'Exception') {
		mut var_e := var_e_1.dup()
		rt.call_method(rt.call_function('wc_get_logger', []rt.PhpVal{}), 'error', [rt.call_function('sprintf', [rt.new_string('Safety net failed: %s'), rt.call_method(var_e, 'getMessage', []rt.PhpVal{})]), rt.create_array([rt.ArrayItem{ key: 'source', val: Class_Automattic_WooCommerce_Internal_PushNotifications_PushNotifications.feature_name() }])])
		unsafe { goto end_label_1 }
	}
	else {
		rt.throw_exception(var_e_1)
		unsafe { goto end_label_1 }
	}

end_label_1:
}

struct Class_Automattic_WooCommerce_Internal_PushNotifications_Notifications_Notification {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_pushnotifications_services_notificationprocessor() &Class_Automattic_WooCommerce_Internal_PushNotifications_Services_NotificationProcessor {
	mut obj := &Class_Automattic_WooCommerce_Internal_PushNotifications_Services_NotificationProcessor{
		PhpObjectBase: rt.PhpObjectBase{}
		dispatcher: rt.new_null()
		data_store: rt.new_null()
	}
	return obj
}

fn create_automattic_woocommerce_internal_pushnotifications_notifications_notification() &Class_Automattic_WooCommerce_Internal_PushNotifications_Notifications_Notification {
	mut obj := &Class_Automattic_WooCommerce_Internal_PushNotifications_Notifications_Notification{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_PushNotifications_Services_NotificationProcessor) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'init' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_PushNotifications_Dispatchers_WpcomNotificationDispatcher](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_PushNotifications_DataStores_PushTokensDataStore](if args.len > 1 { args[1] } else { rt.new_null() })
			this.init(mut dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'register' {
			this.register()
			return rt.new_null()
		}
		'process' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_PushNotifications_Notifications_Notification](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			return rt.new_bool(this.process(mut dispatch_arg_0, dispatch_arg_1))
		}
		'handle_safety_net' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			this.handle_safety_net(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_PushNotifications_Services_NotificationProcessor) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'dispatcher' { return this.dispatcher }
		'data_store' { return this.data_store }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_PushNotifications_Services_NotificationProcessor) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'dispatcher' { this.dispatcher = val; return true }
		'data_store' { this.data_store = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
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




pub fn init_wp_content_plugins_woocommerce_src_internal_pushnotifications_services_notificationprocessor_php() {
	// unsupported statement: Stmt_Declare
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
