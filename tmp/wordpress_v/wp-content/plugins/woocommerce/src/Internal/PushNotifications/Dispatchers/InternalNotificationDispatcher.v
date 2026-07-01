import rt

pub fn Class_Automattic_WooCommerce_Internal_PushNotifications_Dispatchers_InternalNotificationDispatcher.send_endpoint() string {
	return 'wc-push-notifications/send'
}
pub fn Class_Automattic_WooCommerce_Internal_PushNotifications_Dispatchers_InternalNotificationDispatcher.jwt_expiry_seconds() i64 {
	return 30
}
struct Class_Automattic_WooCommerce_Internal_PushNotifications_Dispatchers_InternalNotificationDispatcher {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Internal_PushNotifications_Dispatchers_InternalNotificationDispatcher) dispatch(mut var_notifications Class_Automattic_WooCommerce_Internal_PushNotifications_Dispatchers_array)  {
	mut var_notification := rt.new_null()
	if !rt.is_true(var_notifications) {
		return rt.new_null()
	}
	closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_notification := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return rt.call_method(var_notification, 'to_array', []rt.PhpVal{})
	}
	mut var_notification := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return rt.call_method(var_notification, 'to_array', []rt.PhpVal{})
	}
	mut var_encoded := rt.call_function('array_map', [rt.new_closure(closure_1_fn), var_notifications])
	mut var_body := rt.call_function('wp_json_encode', [rt.create_array([rt.ArrayItem{ key: 'notifications', val: var_encoded }])])
	if rt.is_true(rt.identical(rt.new_bool(false), var_body)) {
		rt.call_method(rt.call_function('wc_get_logger', []rt.PhpVal{}), 'error', [rt.new_string('Failed to JSON-encode push notification payload.'), rt.create_array([rt.ArrayItem{ key: 'source', val: Class_Automattic_WooCommerce_Internal_PushNotifications_PushNotifications.feature_name() }])])
		return rt.new_null()
	}
	mut var_token := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_StoreApi_Utilities_JsonWebToken{}; return temp.create(arg_0, arg_1) }(rt.create_array([rt.ArrayItem{ key: 'iss', val: rt.call_function('get_site_url', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'exp', val: rt.add(rt.call_function('time', []rt.PhpVal{}), Class_Automattic_WooCommerce_Internal_PushNotifications_Dispatchers_Automattic_WooCommerce_Internal_PushNotifications_Dispatchers_InternalNotificationDispatcher.jwt_expiry_seconds()) }, rt.ArrayItem{ key: 'body_hash', val: rt.call_function('hash', [rt.new_string('sha256'), var_body.dup()]) }]), rt.call_function('wp_salt', [rt.new_string('auth')]))
	rt.call_function('wp_remote_post', [rt.call_function('rest_url', [Class_Automattic_WooCommerce_Internal_PushNotifications_Dispatchers_Automattic_WooCommerce_Internal_PushNotifications_Dispatchers_InternalNotificationDispatcher.send_endpoint()]), rt.create_array([rt.ArrayItem{ key: 'blocking', val: false }, rt.ArrayItem{ key: 'timeout', val: 1 }, rt.ArrayItem{ key: 'headers', val: rt.create_array([rt.ArrayItem{ key: 'Content-Type', val: 'application/json' }, rt.ArrayItem{ key: 'Authorization', val: 'Bearer ' + (var_token).str() }]) }, rt.ArrayItem{ key: 'body', val: var_body }])])
}

struct Class_Automattic_WooCommerce_StoreApi_Utilities_JsonWebToken {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_pushnotifications_dispatchers_internalnotificationdispatcher() &Class_Automattic_WooCommerce_Internal_PushNotifications_Dispatchers_InternalNotificationDispatcher {
	mut obj := &Class_Automattic_WooCommerce_Internal_PushNotifications_Dispatchers_InternalNotificationDispatcher{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_storeapi_utilities_jsonwebtoken() &Class_Automattic_WooCommerce_StoreApi_Utilities_JsonWebToken {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Utilities_JsonWebToken{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_PushNotifications_Dispatchers_InternalNotificationDispatcher) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'dispatch' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_PushNotifications_Dispatchers_array](if args.len > 0 { args[0] } else { rt.new_null() })
			this.dispatch(mut dispatch_arg_0)
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_PushNotifications_Dispatchers_InternalNotificationDispatcher) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_PushNotifications_Dispatchers_InternalNotificationDispatcher) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_JsonWebToken) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Utilities_JsonWebToken) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_JsonWebToken) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_internal_pushnotifications_dispatchers_internalnotificationdispatcher_php() {
	// unsupported statement: Stmt_Declare
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
