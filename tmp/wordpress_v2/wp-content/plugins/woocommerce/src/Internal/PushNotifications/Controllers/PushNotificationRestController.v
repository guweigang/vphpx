import rt

pub fn Class_Automattic_WooCommerce_Internal_PushNotifications_Controllers_PushNotificationRestController.route_namespace() string {
	return 'wc-push-notifications'
}

struct Class_Automattic_WooCommerce_Internal_PushNotifications_Controllers_PushNotificationRestController {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Internal_PushNotifications_Controllers_PushNotificationRestController) register() {
	rt.call_function('add_action', [rt.new_string('rest_api_init'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_PushNotifications_Controllers_PushNotificationRestController',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'register_routes' },
		])])
}

fn (mut this Class_Automattic_WooCommerce_Internal_PushNotifications_Controllers_PushNotificationRestController) register_routes() {
	rt.call_function('register_rest_route', [
		Class_Automattic_WooCommerce_Internal_PushNotifications_Controllers_Automattic_WooCommerce_Internal_PushNotifications_Controllers_PushNotificationRestController.route_namespace(),
		rt.new_string('send'),
		rt.create_array([
			rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.creatable() },
			rt.ArrayItem{ key: 'callback', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_PushNotifications_Controllers_PushNotificationRestController',
					[]string{}, &this) },
				rt.ArrayItem{ key: none, val: 'create' },
			]) },
			rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_PushNotifications_Controllers_PushNotificationRestController',
					[]string{}, &this) },
				rt.ArrayItem{ key: none, val: 'authorize' },
			]) },
		]),
	])
}

fn (mut this Class_Automattic_WooCommerce_Internal_PushNotifications_Controllers_PushNotificationRestController) create(mut var_request Class_WP_REST_Request) rt.PhpVal {
	rt.call_function('wc_set_time_limit', [rt.new_int(30)])
	mut var_body := rt.call_function('json_decode', [var_request.get_body(),
		rt.new_bool(true)])
	mut var_notifications := if var_body.clone().is_array() {
		if !(var_body.array_get(rt.new_string('notifications'))).is_null() {
			var_body.array_get(rt.new_string('notifications'))
		} else {
			rt.new_array()
		}
	} else {
		rt.new_array()
	}
	mut var_success_response := create_wp_rest_response(rt.create_array([
		rt.ArrayItem{ key: 'success', val: true },
	]), Class_WP_Http.ok())
	if !rt.is_true(var_notifications) || !(var_notifications.clone().is_array()) {
		rt.call_method(rt.call_function('wc_get_logger', []rt.PhpVal{}), 'warning', [
			rt.new_string('Loopback endpoint received empty or missing notifications array.'),
			rt.create_array([
				rt.ArrayItem{
					key: 'source'
					val: Class_Automattic_WooCommerce_Internal_PushNotifications_PushNotifications.feature_name()
				},
			]),
		])
		return mut var_success_response
	}
	mut var_processor := rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [
		Class_Automattic_WooCommerce_Internal_PushNotifications_Services_NotificationProcessor.class(),
	])
	mut iter_1 := var_notifications.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_data := item_1.val
		mut iife_temp_0 :=
			Class_Automattic_WooCommerce_Internal_PushNotifications_Notifications_Notification{}
		mut iife_result_0 := iife_temp_0.from_array(var_data.clone())
		mut var_notification := iife_result_0
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
		rt.call_method(var_processor, 'process', [var_notification.clone()])
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
		unsafe {
			goto end_label_1
		}
		catch_label_1:
		mut var_e_1 := rt.get_and_clear_exception()
		if rt.instance_of(var_e_1, 'Exception') {
			mut var_e := var_e_1.clone()
			rt.call_method(rt.call_function('wc_get_logger', []rt.PhpVal{}), 'error', [
				rt.call_function('sprintf', [
					rt.new_string('Failed to process notification: %s'),
					rt.call_method(var_e, 'getMessage', []rt.PhpVal{}),
				]),
				rt.create_array([
					rt.ArrayItem{
						key: 'source'
						val: Class_Automattic_WooCommerce_Internal_PushNotifications_PushNotifications.feature_name()
					},
				]),
			])
			unsafe {
				goto end_label_1
			}
		} else {
			rt.throw_exception(var_e_1)
			unsafe {
				goto end_label_1
			}
		}

		end_label_1:
	}
	return mut var_success_response
}

fn (mut this Class_Automattic_WooCommerce_Internal_PushNotifications_Controllers_PushNotificationRestController) authorize(mut var_request Class_WP_REST_Request) bool {
	mut var_header := var_request.get_header(rt.new_string('authorization'))
	if !rt.is_true(var_header) {
		return (create_wp_error(rt.new_string('woocommerce_rest_unauthorized'),
			rt.new_string('Missing authorization header.'), rt.create_array([
			rt.ArrayItem{ key: 'status', val: Class_WP_Http.unauthorized() },
		]))).to_bool()
	}
	mut var_token := rt.new_string((rt.call_function('preg_replace', [
		rt.new_string('/^\\s*Bearer\\s+/i'),
		rt.new_string(''),
		var_header.clone(),
	])).str())
	mut iife_temp_1 := Class_Automattic_WooCommerce_StoreApi_Utilities_JsonWebToken{}
	mut iife_result_1 := iife_temp_1.validate(var_token.clone(), rt.call_function('wp_salt', [
		rt.new_string('auth'),
	]))
	if rt.is_true(rt.new_bool(!(rt.is_true(iife_result_1)))) {
		return (create_wp_error(rt.new_string('woocommerce_rest_unauthorized'),
			rt.new_string('Invalid or expired token.'), rt.create_array([
			rt.ArrayItem{ key: 'status', val: Class_WP_Http.unauthorized() },
		]))).to_bool()
	}
	mut iife_temp_2 := Class_Automattic_WooCommerce_StoreApi_Utilities_JsonWebToken{}
	mut iife_result_2 := iife_temp_2.get_parts(var_token.clone())
	mut var_parts := iife_result_2
	if !(!(rt.get_property(rt.get_property(var_parts, 'payload'), 'iss')).is_null())
		|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('get_site_url', []rt.PhpVal{}), rt.get_property(rt.get_property(var_parts, 'payload'), 'iss'))))) {
		return (create_wp_error(rt.new_string('woocommerce_rest_unauthorized'),
			rt.new_string('Invalid token issuer.'), rt.create_array([
			rt.ArrayItem{ key: 'status', val: Class_WP_Http.unauthorized() },
		]))).to_bool()
	}
	mut var_body_hash := rt.call_function('hash', [rt.new_string('sha256'),
		var_request.get_body()])
	if !(!(rt.get_property(rt.get_property(var_parts, 'payload'), 'body_hash')).is_null())
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('hash_equals', [rt.new_string((rt.get_property(rt.get_property(var_parts, 'payload'), 'body_hash')).str()), var_body_hash.clone()]))))) {
		return (create_wp_error(rt.new_string('woocommerce_rest_unauthorized'),
			rt.new_string('Body hash mismatch.'), rt.create_array([
			rt.ArrayItem{ key: 'status', val: Class_WP_Http.unauthorized() },
		]))).to_bool()
	}
	return true
}

struct Class_WP_REST_Response {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_PushNotifications_Notifications_Notification {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_StoreApi_Utilities_JsonWebToken {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_pushnotifications_controllers_pushnotificationrestcontroller(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_PushNotifications_Controllers_PushNotificationRestController {
	mut obj := &Class_Automattic_WooCommerce_Internal_PushNotifications_Controllers_PushNotificationRestController{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_rest_response(_args ...rt.PhpVal) &Class_WP_REST_Response {
	mut obj := &Class_WP_REST_Response{
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

fn create_wp_error(_args ...rt.PhpVal) &Class_WP_Error {
	mut obj := &Class_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_storeapi_utilities_jsonwebtoken(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_StoreApi_Utilities_JsonWebToken {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Utilities_JsonWebToken{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_PushNotifications_Controllers_PushNotificationRestController) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'register' {
			this.register()
			return rt.new_null()
		}
		'register_routes' {
			this.register_routes()
			return rt.new_null()
		}
		'create' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WP_REST_Request](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.create(mut dispatch_arg_0)
		}
		'authorize' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WP_REST_Request](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return rt.new_bool(this.authorize(mut dispatch_arg_0))
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_PushNotifications_Controllers_PushNotificationRestController) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_PushNotifications_Controllers_PushNotificationRestController) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WP_REST_Response) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_REST_Response) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_REST_Response) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_WP_Error) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Error) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Error) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}
