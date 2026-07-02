import rt

struct Class_Automattic_WooCommerce_Internal_StockNotifications_Emails_EmailActionController {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Emails_EmailActionController) construct() {
	rt.call_function('add_action', [rt.new_string('template_redirect'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_StockNotifications_Emails_EmailActionController',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'maybe_process_email_action' },
		])])
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Emails_EmailActionController) maybe_process_email_action() {
	if !(rt.get_superglobal('_GET').array_isset(rt.new_string('notification_id')))
		|| !(rt.get_superglobal('_GET').array_isset(rt.new_string('email_link_action_key'))) {
		return
	}
	mut var_notification_id := rt.call_function('absint', [
		rt.call_function('wp_unslash',
			[rt.get_superglobal('_GET').array_get(rt.new_string('notification_id'))]),
	])
	mut var_action_key := rt.call_function('sanitize_text_field', [
		rt.call_function('wp_unslash', [
			rt.get_superglobal('_GET').array_get(rt.new_string('email_link_action_key')),
		]),
	])
	this.validate_and_maybe_process_request(var_notification_id.to_i64(), var_action_key.str())
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Emails_EmailActionController) validate_and_maybe_process_request(notification_id i64, email_link_action_key string) {
	mut notification_id_mutated := notification_id
	if email_link_action_key == '' || notification_id_mutated == 0 {
		return
	}
	mut var_notification :=
		rt.new_bool(this.get_notification_to_be_processed(notification_id_mutated))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_notification)))) {
		return
	}
	mut var_action_key := rt.call_method(var_notification, 'get_meta', [
		rt.new_string('email_link_action_key'),
	])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('strpos', [
		var_action_key.clone(),
		rt.new_string(':'),
	]), rt.new_bool(false)))))
	{
		this.process_verification_action(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_StockNotifications_Notification](var_notification),
			email_link_action_key)
	} else {
		this.process_unsubscribe_action(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_StockNotifications_Notification](var_notification),
			email_link_action_key)
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Emails_EmailActionController) process_verification_action(mut var_notification Class_Automattic_WooCommerce_Internal_StockNotifications_Notification, action_key string) {
	mut var_notification_mutated := var_notification
	mut action_key_mutated := action_key
	if rt.is_true(rt.call_method(var_notification_mutated, 'check_verification_key', [
		rt.new_string(action_key_mutated).clone(),
	]))
	{
		rt.call_method(var_notification_mutated, 'set_status', [
			Class_Automattic_WooCommerce_Internal_StockNotifications_Enums_NotificationStatus.active(),
		])
		rt.call_method(var_notification_mutated, 'set_date_confirmed', [
			rt.call_function('time', []rt.PhpVal{}),
		])
		rt.call_method(var_notification_mutated, 'save', []rt.PhpVal{})
		if rt.is_true(rt.new_bool(rt.instance_of(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'session'), 'Automattic_WooCommerce_Internal_StockNotifications_Emails_WC_Session_Handler')))
			&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'session'), 'has_session', []rt.PhpVal{}))))) {
			rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'session'),
				'set_customer_session_cookie', [rt.new_bool(true)])
		}
		mut var_product := rt.call_function('wc_get_product', [
			rt.call_method(var_notification_mutated, 'get_product_id', []rt.PhpVal{}),
		])
		mut var_notice_text := rt.call_function('sprintf', [
			rt.call_function('esc_html__', [
				rt.new_string('Successfully verified stock notifications for "%s".'),
				rt.new_string('woocommerce'),
			]),
			rt.call_method(var_product, 'get_name', []rt.PhpVal{}),
		])
		rt.call_function('wc_add_notice', [var_notice_text.clone()])
		mut var_url := rt.call_function('apply_filters', [
			rt.new_string('woocommerce_customer_stock_notification_verified_redirect_url'),
			rt.call_function('get_permalink', [
				rt.call_function('wc_get_page_id', [rt.new_string('shop')]),
			]),
		])
		rt.call_function('wp_safe_redirect', [var_url.clone()])
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Emails_EmailActionController) process_unsubscribe_action(mut var_notification Class_Automattic_WooCommerce_Internal_StockNotifications_Notification, action_key string) {
	mut var_notification_mutated := var_notification
	mut action_key_mutated := action_key
	if rt.is_true(rt.call_method(var_notification_mutated, 'check_unsubscribe_key', [
		rt.new_string(action_key_mutated).clone(),
	]))
	{
		rt.call_method(var_notification_mutated, 'set_status', [
			Class_Automattic_WooCommerce_Internal_StockNotifications_Enums_NotificationStatus.cancelled(),
		])
		rt.call_method(var_notification_mutated, 'set_cancellation_source', [
			Class_Automattic_WooCommerce_Internal_StockNotifications_Enums_NotificationCancellationSource.user(),
		])
		rt.call_method(var_notification_mutated, 'set_date_cancelled', [
			rt.call_function('time', []rt.PhpVal{}),
		])
		rt.call_method(var_notification_mutated, 'save', []rt.PhpVal{})
		if rt.is_true(rt.new_bool(rt.instance_of(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'session'), 'Automattic_WooCommerce_Internal_StockNotifications_Emails_WC_Session_Handler')))
			&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'session'), 'has_session', []rt.PhpVal{}))))) {
			rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'session'),
				'set_customer_session_cookie', [rt.new_bool(true)])
		}
		mut var_product := rt.call_function('wc_get_product', [
			rt.call_method(var_notification_mutated, 'get_product_id', []rt.PhpVal{}),
		])
		mut var_notice_text := rt.call_function('sprintf', [
			rt.call_function('esc_html__', [
				rt.new_string('Successfully unsubscribed %1$s. You will not receive a notification when "%2$s" becomes available.'),
				rt.new_string('woocommerce'),
			]),
			rt.call_method(var_notification_mutated, 'get_user_email', []rt.PhpVal{}),
			rt.call_method(var_product, 'get_name', []rt.PhpVal{}),
		])
		rt.call_function('wc_add_notice', [var_notice_text.clone()])
		mut var_url := rt.call_function('apply_filters', [
			rt.new_string('woocommerce_customer_stock_notification_unsubscribe_redirect_url'),
			rt.call_function('get_permalink', [
				rt.call_function('wc_get_page_id', [rt.new_string('shop')]),
			]),
		])
		rt.call_function('wp_safe_redirect', [var_url.clone()])
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Emails_EmailActionController) get_notification_to_be_processed(notification_id i64) bool {
	mut notification_id_mutated := notification_id
	mut iife_temp_0 := Class_Automattic_WooCommerce_Internal_StockNotifications_Factory{}
	mut iife_result_0 := iife_temp_0.get_notification(rt.new_int(notification_id_mutated))
	mut var_notification := iife_result_0
	if rt.is_true(rt.new_bool(!(rt.is_true(var_notification)))) {
		return false
	}
	if !rt.is_true(rt.call_method(var_notification, 'get_meta', [
		rt.new_string('email_link_action_key'),
	])) {
		return false
	}
	return var_notification.to_bool()
}

struct Class_Automattic_WooCommerce_Internal_StockNotifications_Factory {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_stocknotifications_emails_emailactioncontroller() &Class_Automattic_WooCommerce_Internal_StockNotifications_Emails_EmailActionController {
	mut obj := &Class_Automattic_WooCommerce_Internal_StockNotifications_Emails_EmailActionController{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	obj.construct()
	return obj
}

fn create_automattic_woocommerce_internal_stocknotifications_factory(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_StockNotifications_Factory {
	mut obj := &Class_Automattic_WooCommerce_Internal_StockNotifications_Factory{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Emails_EmailActionController) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'maybe_process_email_action' {
			this.maybe_process_email_action()
			return rt.new_null()
		}
		'validate_and_maybe_process_request' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			this.validate_and_maybe_process_request(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'process_verification_action' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_StockNotifications_Notification](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			this.process_verification_action(mut dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'process_unsubscribe_action' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_StockNotifications_Notification](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			this.process_unsubscribe_action(mut dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'get_notification_to_be_processed' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			return rt.new_bool(this.get_notification_to_be_processed(dispatch_arg_0))
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_StockNotifications_Emails_EmailActionController) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Emails_EmailActionController) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Factory) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_StockNotifications_Factory) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Factory) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
