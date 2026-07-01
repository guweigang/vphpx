import rt

pub fn Class_Automattic_WooCommerce_Internal_PushNotifications_Dispatchers_WpcomNotificationDispatcher.wpcom_api_version() string {
	return '2'
}
pub fn Class_Automattic_WooCommerce_Internal_PushNotifications_Dispatchers_WpcomNotificationDispatcher.send_endpoint() string {
	return 'push-notifications'
}
pub fn Class_Automattic_WooCommerce_Internal_PushNotifications_Dispatchers_WpcomNotificationDispatcher.request_timeout() i64 {
	return 15
}
struct Class_Automattic_WooCommerce_Internal_PushNotifications_Dispatchers_WpcomNotificationDispatcher {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Internal_PushNotifications_Dispatchers_WpcomNotificationDispatcher) dispatch(mut var_notification Class_Automattic_WooCommerce_Internal_PushNotifications_Notifications_Notification, mut var_tokens Class_Automattic_WooCommerce_Internal_PushNotifications_Dispatchers_array) rt.PhpVal {
	mut var_site_id := if rt.is_true(rt.call_function('class_exists', [Class_Jetpack_Options.class()])) { fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Jetpack_Options{}; return temp.get_option(arg_0) }(rt.new_string('id')) } else { rt.new_null() }
	if !rt.is_true(var_site_id) {
		rt.call_method(rt.call_function('wc_get_logger', []rt.PhpVal{}), 'error', [rt.new_string('Cannot send push notifications: Jetpack site ID unavailable.'), rt.create_array([rt.ArrayItem{ key: 'source', val: Class_Automattic_WooCommerce_Internal_PushNotifications_PushNotifications.feature_name() }])])
		return rt.create_array([rt.ArrayItem{ key: 'success', val: false }, rt.ArrayItem{ key: 'retry_after', val: rt.new_null() }])
	}
	mut var_payload := var_notification.to_payload()
	if rt.is_true(rt.identical(rt.new_null(), var_payload)) {
		rt.call_method(rt.call_function('wc_get_logger', []rt.PhpVal{}), 'error', [rt.call_function('sprintf', [rt.new_string('Cannot send push notification: resource no longer exists (type=%s, resource_id=%d).'), var_notification.get_type(), var_notification.get_resource_id()]), rt.create_array([rt.ArrayItem{ key: 'source', val: Class_Automattic_WooCommerce_Internal_PushNotifications_PushNotifications.feature_name() }])])
		return rt.create_array([rt.ArrayItem{ key: 'success', val: false }, rt.ArrayItem{ key: 'retry_after', val: rt.new_null() }])
	}
	mut var_response := this.make_request((var_site_id).to_i64(), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_PushNotifications_Dispatchers_array](var_payload), mut var_tokens)
	if rt.is_true(rt.call_function('is_wp_error', [var_response.dup()])) {
		rt.call_method(rt.call_function('wc_get_logger', []rt.PhpVal{}), 'error', [rt.call_function('sprintf', [rt.new_string('Push notification request failed: %s'), rt.call_method(var_response, 'get_error_message', []rt.PhpVal{})]), rt.create_array([rt.ArrayItem{ key: 'source', val: Class_Automattic_WooCommerce_Internal_PushNotifications_PushNotifications.feature_name() }])])
		return rt.create_array([rt.ArrayItem{ key: 'success', val: false }, rt.ArrayItem{ key: 'retry_after', val: rt.new_null() }])
	}
	mut var_status_code := // unsupported expression: Expr_Cast_Int
	if rt.is_true(rt.identical(Class_WP_Http.ok(), var_status_code)) {
		return rt.create_array([rt.ArrayItem{ key: 'success', val: true }, rt.ArrayItem{ key: 'retry_after', val: rt.new_null() }])
	}
	mut var_retry_after := rt.call_function('wp_remote_retrieve_header', [var_response.dup(), rt.new_string('retry-after')])
	rt.call_method(rt.call_function('wc_get_logger', []rt.PhpVal{}), 'error', [rt.call_function('sprintf', [rt.new_string('Push notification request returned HTTP %d.'), var_status_code.dup()]), rt.create_array([rt.ArrayItem{ key: 'source', val: Class_Automattic_WooCommerce_Internal_PushNotifications_PushNotifications.feature_name() }])])
	return rt.create_array([rt.ArrayItem{ key: 'success', val: false }, rt.ArrayItem{ key: 'retry_after', val: if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) { // unsupported expression: Expr_Cast_Int } else { rt.new_null() } }])
}

fn (mut this Class_Automattic_WooCommerce_Internal_PushNotifications_Dispatchers_WpcomNotificationDispatcher) make_request(site_id i64, mut var_payload Class_Automattic_WooCommerce_Internal_PushNotifications_Dispatchers_array, mut var_tokens Class_Automattic_WooCommerce_Internal_PushNotifications_Dispatchers_array) rt.PhpVal {
	mut var_token := rt.new_null()
	mut site_id_mutated := site_id
	mut var_payload_mutated := var_payload
	closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_token := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return rt.call_method(var_token, 'to_wpcom_format', []rt.PhpVal{})
	}
	mut var_token := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return rt.call_method(var_token, 'to_wpcom_format', []rt.PhpVal{})
	}
	mut var_body := rt.call_function('wp_json_encode', [rt.call_function('array_merge', [var_payload_mutated.dup(), rt.create_array([rt.ArrayItem{ key: 'tokens', val: rt.call_function('array_map', [rt.new_closure(closure_1_fn), var_tokens]) }])])])
	if rt.is_true(rt.identical(rt.new_bool(false), var_body)) {
		return create_wp_error(rt.new_string('json_encode_failed'), rt.new_string('Failed to encode push notification payload.'))
	}
	return fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal, arg_3 rt.PhpVal, arg_4 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_Jetpack_Connection_Client{}; return temp.wpcom_json_api_request_as_blog(arg_0, arg_1, arg_2, arg_3, arg_4) }(rt.call_function('sprintf', [rt.new_string('/sites/%d/%s'), rt.new_int(site_id_mutated).dup(), Class_Automattic_WooCommerce_Internal_PushNotifications_Dispatchers_Automattic_WooCommerce_Internal_PushNotifications_Dispatchers_WpcomNotificationDispatcher.send_endpoint()]), Class_Automattic_WooCommerce_Internal_PushNotifications_Dispatchers_Automattic_WooCommerce_Internal_PushNotifications_Dispatchers_WpcomNotificationDispatcher.wpcom_api_version(), rt.create_array([rt.ArrayItem{ key: 'headers', val: rt.create_array([rt.ArrayItem{ key: 'Content-Type', val: 'application/json' }]) }, rt.ArrayItem{ key: 'method', val: 'POST' }, rt.ArrayItem{ key: 'timeout', val: Class_Automattic_WooCommerce_Internal_PushNotifications_Dispatchers_Automattic_WooCommerce_Internal_PushNotifications_Dispatchers_WpcomNotificationDispatcher.request_timeout() }]), var_body.dup(), rt.new_string('wpcom'))
}

struct Class_Jetpack_Options {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

struct Class_Automattic_Jetpack_Connection_Client {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_pushnotifications_dispatchers_wpcomnotificationdispatcher() &Class_Automattic_WooCommerce_Internal_PushNotifications_Dispatchers_WpcomNotificationDispatcher {
	mut obj := &Class_Automattic_WooCommerce_Internal_PushNotifications_Dispatchers_WpcomNotificationDispatcher{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_jetpack_options() &Class_Jetpack_Options {
	mut obj := &Class_Jetpack_Options{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_error() &Class_WP_Error {
	mut obj := &Class_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_jetpack_connection_client() &Class_Automattic_Jetpack_Connection_Client {
	mut obj := &Class_Automattic_Jetpack_Connection_Client{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_PushNotifications_Dispatchers_WpcomNotificationDispatcher) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'dispatch' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_PushNotifications_Notifications_Notification](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_PushNotifications_Dispatchers_array](if args.len > 1 { args[1] } else { rt.new_null() })
			return this.dispatch(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		'make_request' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_PushNotifications_Dispatchers_array](if args.len > 1 { args[1] } else { rt.new_null() })
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_PushNotifications_Dispatchers_array](if args.len > 2 { args[2] } else { rt.new_null() })
			return this.make_request(dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2)
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_PushNotifications_Dispatchers_WpcomNotificationDispatcher) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_PushNotifications_Dispatchers_WpcomNotificationDispatcher) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Jetpack_Options) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Jetpack_Options) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Jetpack_Options) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_Error) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Error) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Error) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_Jetpack_Connection_Client) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_Jetpack_Connection_Client) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_Jetpack_Connection_Client) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_internal_pushnotifications_dispatchers_wpcomnotificationdispatcher_php() {
	// unsupported statement: Stmt_Declare
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
