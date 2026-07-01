import rt

pub fn Class_Automattic_WooCommerce_Internal_OrderReviews_Scheduler.action_hook() string {
	return 'woocommerce_send_review_request'
}
pub fn Class_Automattic_WooCommerce_Internal_OrderReviews_Scheduler.scheduled_meta_key() string {
	return '_wc_review_request_scheduled_at'
}
pub fn Class_Automattic_WooCommerce_Internal_OrderReviews_Scheduler.log_source() string {
	return 'review-request'
}
struct Class_Automattic_WooCommerce_Internal_OrderReviews_Scheduler {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Internal_OrderReviews_Scheduler) init()  {
	rt.call_function('add_action', [rt.new_string('woocommerce_order_status_completed'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_OrderReviews_Scheduler', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'handle_woocommerce_order_status_completed' }]), rt.new_int(10), rt.new_int(1)])
	rt.call_function('add_action', [rt.new_string('woocommerce_order_status_changed'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_OrderReviews_Scheduler', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'handle_status_changed' }]), rt.new_int(10), rt.new_int(3)])
	rt.call_function('add_action', [rt.new_string('woocommerce_trash_order'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_OrderReviews_Scheduler', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'handle_cancellation' }]), rt.new_int(10), rt.new_int(1)])
	rt.call_function('add_action', [rt.new_string('woocommerce_before_delete_order'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_OrderReviews_Scheduler', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'handle_cancellation' }]), rt.new_int(10), rt.new_int(1)])
}

fn (mut this Class_Automattic_WooCommerce_Internal_OrderReviews_Scheduler) handle_status_changed(order_id i64, old_status string, new_status string)  {
	mut var_order := rt.call_function('wc_get_order', [rt.new_int(order_id)])
	mut var_eligible_statuses := rt.cast_array(rt.call_function('apply_filters', [rt.new_string('woocommerce_review_order_eligible_statuses'), rt.create_array([rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_OrderStatus.completed() }]), if rt.is_true(rt.new_bool(rt.instance_of(var_order, 'WC_Order'))) { var_order } else { rt.new_null() }]))
	mut var_was_eligible := rt.call_function('in_array', [rt.new_string(old_status), var_eligible_statuses.dup(), rt.new_bool(true)])
	mut var_is_eligible := rt.call_function('in_array', [rt.new_string(new_status), var_eligible_statuses.dup(), rt.new_bool(true)])
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_was_eligible)))) || rt.is_true(var_is_eligible))) {
		return rt.new_null()
	}
	this.handle_cancellation(order_id)
}

fn (mut this Class_Automattic_WooCommerce_Internal_OrderReviews_Scheduler) handle_woocommerce_order_status_completed(order_id i64)  {
	mut var_order := rt.call_function('wc_get_order', [rt.new_int(order_id)])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_order, 'WC_Order')))))) {
		return rt.new_null()
	}
	mut var_email := this.get_email()
	if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_null(), var_email)) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_email, 'is_enabled', []rt.PhpVal{}))))))) {
		this.log_skip(order_id, 'email is disabled')
		return rt.new_null()
	}
	if rt.is_true(rt.call_method(var_order, 'get_meta', [Class_Automattic_WooCommerce_Internal_OrderReviews_Automattic_WooCommerce_Internal_OrderReviews_Scheduler.scheduled_meta_key()])) {
		this.log_skip(order_id, 'already scheduled')
		return rt.new_null()
	}
	mut var_should_send := // unsupported expression: Expr_Cast_Bool
	if rt.is_true(rt.new_bool(!(rt.is_true(var_should_send)))) {
		this.log_skip(order_id, 'opt-out filter returned false')
		return rt.new_null()
	}
	mut var_when := rt.add(rt.call_function('time', []rt.PhpVal{}), rt.call_method(var_email, 'get_delay_seconds', []rt.PhpVal{}))
	rt.call_function('as_schedule_single_action', [var_when.dup(), Class_Automattic_WooCommerce_Internal_OrderReviews_Automattic_WooCommerce_Internal_OrderReviews_Scheduler.action_hook(), rt.create_array([rt.ArrayItem{ key: none, val: order_id }])])
	rt.call_method(var_order, 'update_meta_data', [Class_Automattic_WooCommerce_Internal_OrderReviews_Automattic_WooCommerce_Internal_OrderReviews_Scheduler.scheduled_meta_key(), // unsupported expression: Expr_Cast_String])
	rt.call_method(var_order, 'save', []rt.PhpVal{})
}

fn (mut this Class_Automattic_WooCommerce_Internal_OrderReviews_Scheduler) handle_cancellation(order_id i64)  {
	rt.call_function('as_unschedule_action', [Class_Automattic_WooCommerce_Internal_OrderReviews_Automattic_WooCommerce_Internal_OrderReviews_Scheduler.action_hook(), rt.create_array([rt.ArrayItem{ key: none, val: order_id }])])
	mut var_order := rt.call_function('wc_get_order', [rt.new_int(order_id)])
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.instance_of(var_order, 'WC_Order'))) && rt.is_true(rt.call_method(var_order, 'get_meta', [Class_Automattic_WooCommerce_Internal_OrderReviews_Automattic_WooCommerce_Internal_OrderReviews_Scheduler.scheduled_meta_key()])))) {
		rt.call_method(var_order, 'delete_meta_data', [Class_Automattic_WooCommerce_Internal_OrderReviews_Automattic_WooCommerce_Internal_OrderReviews_Scheduler.scheduled_meta_key()])
		rt.call_method(var_order, 'save', []rt.PhpVal{})
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_OrderReviews_Scheduler) get_email() rt.PhpVal {
	mut var_mailer := rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'mailer', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(rt.is_true(var_mailer)))) {
		return rt.new_null()
	}
	mut var_emails := rt.call_method(var_mailer, 'get_emails', []rt.PhpVal{})
	mut var_email := if !(var_emails.array_get('WC_Email_Customer_Review_Request')).is_null() { var_emails.array_get('WC_Email_Customer_Review_Request') } else { rt.new_null() }
	return if rt.is_true(rt.new_bool(rt.instance_of(var_email, 'WC_Email_Customer_Review_Request'))) { var_email } else { rt.new_null() }
}

fn (mut this Class_Automattic_WooCommerce_Internal_OrderReviews_Scheduler) log_skip(order_id i64, reason string)  {
	rt.call_method(rt.call_function('wc_get_logger', []rt.PhpVal{}), 'info', [rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Skipped scheduling review-request email for order %1$d: %2$s.'), rt.new_string('woocommerce')]), rt.new_int(order_id), rt.new_string(reason)]), rt.create_array([rt.ArrayItem{ key: 'source', val: Class_Automattic_WooCommerce_Internal_OrderReviews_Automattic_WooCommerce_Internal_OrderReviews_Scheduler.log_source() }])])
}

fn create_automattic_woocommerce_internal_orderreviews_scheduler() &Class_Automattic_WooCommerce_Internal_OrderReviews_Scheduler {
	mut obj := &Class_Automattic_WooCommerce_Internal_OrderReviews_Scheduler{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_OrderReviews_Scheduler) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'init' {
			this.init()
			return rt.new_null()
		}
		'handle_status_changed' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			this.handle_status_changed(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'handle_woocommerce_order_status_completed' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			this.handle_woocommerce_order_status_completed(dispatch_arg_0)
			return rt.new_null()
		}
		'handle_cancellation' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			this.handle_cancellation(dispatch_arg_0)
			return rt.new_null()
		}
		'get_email' {
			return this.get_email()
		}
		'log_skip' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			this.log_skip(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_OrderReviews_Scheduler) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_OrderReviews_Scheduler) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_internal_orderreviews_scheduler_php() {
	// unsupported statement: Stmt_Declare
}
