import rt

struct Class_WC_Emails {
	rt.PhpObjectBase
pub mut:
	emails rt.PhpVal = rt.new_array()
}

fn init_static_wc_emails() {
	rt.init_static_prop('WC_Emails', 'instance', rt.new_null())
	rt.init_static_prop('WC_Emails', 'deferred_queue', rt.new_null())
}

fn Class_WC_Emails.instance() rt.PhpVal {
	if rt.is_true(rt.new_bool(rt.get_static_prop('WC_Emails', 'instance').is_null())) {
		rt.set_static_prop('WC_Emails', 'instance', rt.new_object('WC_Emails', []string{},
			create_wc_emails()))
	}
	return rt.get_static_prop('WC_Emails', 'instance')
}

fn (mut this Class_WC_Emails) magic_clone() {
	rt.call_function('wc_doing_it_wrong', [rt.new_string(@FN),
		rt.call_function('__', [rt.new_string('Cloning is forbidden.'),
			rt.new_string('woocommerce')]),
		rt.new_string('2.1')])
}

fn (mut this Class_WC_Emails) magic_wakeup() {
	rt.call_function('wc_doing_it_wrong', [rt.new_string(@FN),
		rt.call_function('__', [
			rt.new_string('Unserializing instances of this class is forbidden.'),
			rt.new_string('woocommerce'),
		]),
		rt.new_string('2.1')])
}

fn Class_WC_Emails.init_transactional_emails() {
	mut var_email_actions := rt.call_function('apply_filters', [
		rt.new_string('woocommerce_email_actions'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'woocommerce_low_stock' },
			rt.ArrayItem{ key: none, val: 'woocommerce_no_stock' },
			rt.ArrayItem{ key: none, val: 'woocommerce_product_on_backorder' },
			rt.ArrayItem{ key: none, val: 'woocommerce_order_status_pending_to_processing' },
			rt.ArrayItem{ key: none, val: 'woocommerce_order_status_pending_to_completed' },
			rt.ArrayItem{ key: none, val: 'woocommerce_order_status_processing_to_cancelled' },
			rt.ArrayItem{ key: none, val: 'woocommerce_order_status_pending_to_failed' },
			rt.ArrayItem{ key: none, val: 'woocommerce_order_status_pending_to_on-hold' },
			rt.ArrayItem{ key: none, val: 'woocommerce_order_status_failed_to_processing' },
			rt.ArrayItem{ key: none, val: 'woocommerce_order_status_failed_to_completed' },
			rt.ArrayItem{ key: none, val: 'woocommerce_order_status_failed_to_on-hold' },
			rt.ArrayItem{ key: none, val: 'woocommerce_order_status_cancelled_to_processing' },
			rt.ArrayItem{ key: none, val: 'woocommerce_order_status_cancelled_to_completed' },
			rt.ArrayItem{ key: none, val: 'woocommerce_order_status_cancelled_to_on-hold' },
			rt.ArrayItem{ key: none, val: 'woocommerce_order_status_on-hold_to_processing' },
			rt.ArrayItem{ key: none, val: 'woocommerce_order_status_on-hold_to_cancelled' },
			rt.ArrayItem{ key: none, val: 'woocommerce_order_status_on-hold_to_failed' },
			rt.ArrayItem{ key: none, val: 'woocommerce_order_status_completed' },
			rt.ArrayItem{ key: none, val: 'woocommerce_order_status_failed' },
			rt.ArrayItem{ key: none, val: 'woocommerce_order_fully_refunded' },
			rt.ArrayItem{ key: none, val: 'woocommerce_order_partially_refunded' },
			rt.ArrayItem{ key: none, val: 'woocommerce_send_review_request' },
			rt.ArrayItem{ key: none, val: 'woocommerce_new_customer_note' },
			rt.ArrayItem{ key: none, val: 'woocommerce_created_customer' },
			rt.ArrayItem{ key: none, val: 'woocommerce_payment_gateway_enabled' }]),
	])
	mut iife_temp_0 := Class_Automattic_WooCommerce_Utilities_FeaturesUtil{}
	mut iife_result_0 :=
		iife_temp_0.feature_is_enabled(rt.new_string('deferred_transactional_emails'))
	mut var_defer_default := iife_result_0
	if rt.is_true(rt.call_function('apply_filters', [
		rt.new_string('woocommerce_defer_transactional_emails'),
		var_defer_default.clone(),
	]))
	{
		rt.set_static_prop('WC_Emails', 'deferred_queue', rt.call_method(rt.call_function('wc_get_container',
			[]rt.PhpVal{}), 'get', [
			Class_Automattic_WooCommerce_Internal_Email_DeferredEmailQueue.class(),
		]))
		mut iter_1 := var_email_actions.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_action := item_1.val
			rt.call_function('add_action', [var_action.clone(),
				rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
					rt.ArrayItem{ key: none, val: 'queue_transactional_email' }]),
				rt.new_int(10), rt.new_int(10)])
		}
	} else {
		mut iter_2 := var_email_actions.iterator()
		for {
			item_2 := iter_2.next() or { break }
			mut var_action := item_2.val
			rt.call_function('add_action', [var_action.clone(),
				rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
					rt.ArrayItem{ key: none, val: 'send_transactional_email' }]),
				rt.new_int(10), rt.new_int(10)])
		}
	}
}

fn Class_WC_Emails.queue_transactional_email(var_args rt.PhpVal) {
	mut var_args_mutated := var_args
	if rt.is_true(rt.new_bool(rt.instance_of(rt.get_static_prop('WC_Emails', 'deferred_queue'),
		'Automattic_WooCommerce_Internal_Email_DeferredEmailQueue')))
	{
		rt.call_method(rt.get_static_prop('WC_Emails', 'deferred_queue'), 'push', [
			rt.call_function('current_filter', []rt.PhpVal{}),
			var_args_mutated.clone(),
		])
	} else {
		Class_WC_Emails.send_transactional_email(var_args_mutated.clone())
	}
}

fn Class_WC_Emails.send_queued_transactional_email(filter string, var_args rt.PhpVal) {
	mut var_args_mutated := var_args
	if rt.is_true(rt.call_function('apply_filters', [
		rt.new_string('woocommerce_allow_send_queued_transactional_email'),
		rt.new_bool(true),
		rt.new_string(filter),
		var_args_mutated.clone(),
	]))
	{
		Class_WC_Emails.instance()
		rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'payment_gateways', []rt.PhpVal{})
		rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'shipping', []rt.PhpVal{})
		rt.call_function('do_action_ref_array', [rt.new_string(filter + '_notification'),
			var_args_mutated.clone()])
	}
}

fn Class_WC_Emails.send_transactional_email(var_args rt.PhpVal) {
	mut var_args_mutated := var_args
	var_args_mutated = rt.call_function('func_get_args', []rt.PhpVal{})
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	Class_WC_Emails.instance()
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	rt.call_function('do_action_ref_array', [
		rt.new_string((rt.call_function('current_filter', []rt.PhpVal{})).str() + '_notification'),
		var_args_mutated.clone(),
	])
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
		mut var_error := rt.new_string('Transactional email triggered fatal error for callback ' +
			(rt.call_function('current_filter', []rt.PhpVal{})).str())
		mut var_logger := rt.call_function('wc_get_logger', []rt.PhpVal{})
		rt.call_method(var_logger, 'critical', [
			rt.new_string(var_error.str() + (rt.get_constant('PHP_EOL')).str()),
			rt.create_array([rt.ArrayItem{ key: 'source', val: 'transactional-emails' }]),
		])
		mut iife_temp_1 := Class_Automattic_Jetpack_Constants{}
		mut iife_result_1 := iife_temp_1.is_true(rt.new_string('WP_DEBUG'))
		if rt.is_true(iife_result_1) {
			rt.call_function('trigger_error', [
				rt.call_function('esc_html', [var_error.clone()]),
				rt.get_constant('E_USER_WARNING'),
			])
		}
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

fn (mut this Class_WC_Emails) construct() {
	this.init()
	rt.call_function('add_action', [rt.new_string('woocommerce_email_header'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Emails', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'email_header' },
		])])
	rt.call_function('add_action', [rt.new_string('woocommerce_email_footer'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Emails', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'email_footer' },
		])])
	rt.call_function('add_action', [rt.new_string('woocommerce_email_order_details'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Emails', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'order_downloads' },
		]),
		rt.new_int(10), rt.new_int(4)])
	rt.call_function('add_action', [rt.new_string('woocommerce_email_order_details'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Emails', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'order_details' },
		]),
		rt.new_int(10), rt.new_int(4)])
	rt.call_function('add_action', [rt.new_string('woocommerce_email_order_meta'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Emails', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'order_meta' },
		]),
		rt.new_int(10), rt.new_int(3)])
	rt.call_function('add_action', [rt.new_string('woocommerce_email_customer_details'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Emails', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'customer_details' },
		]),
		rt.new_int(10), rt.new_int(3)])
	rt.call_function('add_action', [rt.new_string('woocommerce_email_customer_details'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Emails', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'email_addresses' },
		]),
		rt.new_int(20), rt.new_int(3)])
	rt.call_function('add_action', [rt.new_string('woocommerce_email_customer_details'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Emails', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'additional_checkout_fields' },
		]),
		rt.new_int(30), rt.new_int(3)])
	rt.call_function('add_action', [
		rt.new_string('woocommerce_email_customer_address_section'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Emails', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'additional_address_fields' },
		]),
		rt.new_int(30),
		rt.new_int(4),
	])
	mut iife_temp_2 := Class_Automattic_WooCommerce_Utilities_FeaturesUtil{}
	mut iife_result_2 := iife_temp_2.feature_is_enabled(rt.new_string('fulfillments'))
	if rt.is_true(iife_result_2) {
		rt.call_function('add_action', [
			rt.new_string('woocommerce_email_fulfillment_details'),
			rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('WC_Emails', []string{}, &this) },
				rt.ArrayItem{ key: none, val: 'fulfillment_details' },
			]),
			rt.new_int(10),
			rt.new_int(5),
		])
		rt.call_function('add_action', [
			rt.new_string('woocommerce_email_fulfillment_meta'),
			rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('WC_Emails', []string{}, &this) },
				rt.ArrayItem{ key: none, val: 'fulfillment_meta' },
			]),
			rt.new_int(30),
			rt.new_int(4),
		])
	}
	rt.call_function('add_action', [rt.new_string('woocommerce_low_stock_notification'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Emails', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'low_stock' },
		])])
	rt.call_function('add_action', [rt.new_string('woocommerce_no_stock_notification'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Emails', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'no_stock' },
		])])
	rt.call_function('add_action', [
		rt.new_string('woocommerce_product_on_backorder_notification'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Emails', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'backorder' },
		]),
	])
	rt.call_function('add_action', [
		rt.new_string('woocommerce_created_customer_notification'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Emails', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'customer_new_account' },
		]),
		rt.new_int(10),
		rt.new_int(3),
	])
	rt.call_function('add_filter', [rt.new_string('woocommerce_email_footer_text'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Emails', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'replace_placeholders' },
		])])
	rt.call_function('do_action', [rt.new_string('woocommerce_email'),
		rt.new_object('WC_Emails', []string{}, &this)])
}

fn (mut this Class_WC_Emails) init() {
	mut var_class_name := rt.new_null()
	rt.include_file(@DIR + '/emails/class-wc-email.php', '2')
	mut var_emails := {
		'WC_Email_New_Order':                     @DIR + '/emails/class-wc-email-new-order.php'
		'WC_Email_Cancelled_Order':               @DIR +
			'/emails/class-wc-email-cancelled-order.php'
		'WC_Email_Customer_Cancelled_Order':      @DIR +
			'/emails/class-wc-email-customer-cancelled-order.php'
		'WC_Email_Failed_Order':                  @DIR + '/emails/class-wc-email-failed-order.php'
		'WC_Email_Customer_Failed_Order':         @DIR +
			'/emails/class-wc-email-customer-failed-order.php'
		'WC_Email_Customer_On_Hold_Order':        @DIR +
			'/emails/class-wc-email-customer-on-hold-order.php'
		'WC_Email_Customer_Processing_Order':     @DIR +
			'/emails/class-wc-email-customer-processing-order.php'
		'WC_Email_Customer_Completed_Order':      @DIR +
			'/emails/class-wc-email-customer-completed-order.php'
		'WC_Email_Customer_Refunded_Order':       @DIR +
			'/emails/class-wc-email-customer-refunded-order.php'
		'WC_Email_Customer_Invoice':              @DIR +
			'/emails/class-wc-email-customer-invoice.php'
		'WC_Email_Customer_Note':                 @DIR + '/emails/class-wc-email-customer-note.php'
		'WC_Email_Customer_Reset_Password':       @DIR +
			'/emails/class-wc-email-customer-reset-password.php'
		'WC_Email_Customer_New_Account':          @DIR +
			'/emails/class-wc-email-customer-new-account.php'
		'WC_Email_Admin_Payment_Gateway_Enabled': @DIR +
			'/emails/class-wc-email-admin-payment-gateway-enabled.php'
	}
	mut iife_temp_3 := Class_Automattic_WooCommerce_Utilities_FeaturesUtil{}
	mut iife_result_3 := iife_temp_3.feature_is_enabled(rt.new_string('point_of_sale'))
	if rt.is_true(iife_result_3) {
		var_emails['WC_Email_Customer_POS_Completed_Order'] = @DIR +
			'/emails/class-wc-email-customer-pos-completed-order.php'
		var_emails['WC_Email_Customer_POS_Refunded_Order'] = @DIR +
			'/emails/class-wc-email-customer-pos-refunded-order.php'
	}
	mut iife_temp_4 := Class_Automattic_WooCommerce_Utilities_FeaturesUtil{}
	mut iife_result_4 := iife_temp_4.feature_is_enabled(rt.new_string('fulfillments'))
	if rt.is_true(iife_result_4) {
		var_emails['WC_Email_Customer_Fulfillment_Created'] = @DIR +
			'/emails/class-wc-email-customer-fulfillment-created.php'
		var_emails['WC_Email_Customer_Fulfillment_Updated'] = @DIR +
			'/emails/class-wc-email-customer-fulfillment-updated.php'
		var_emails['WC_Email_Customer_Fulfillment_Deleted'] = @DIR +
			'/emails/class-wc-email-customer-fulfillment-deleted.php'
	}
	mut iife_temp_5 := Class_Automattic_WooCommerce_Utilities_FeaturesUtil{}
	mut iife_result_5 := iife_temp_5.feature_is_enabled(rt.new_string('customer_review_request'))
	if rt.is_true(iife_result_5) {
		var_emails['WC_Email_Customer_Review_Request'] = @DIR +
			'/emails/class-wc-email-customer-review-request.php'
	}
	closure_7_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_class_name := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.call_function('sprintf', [rt.new_string('woocommerce_%s_settings'),
			rt.new_string(rt.call_function('str_replace', [rt.new_string('WC_Email_'),
				rt.new_string(''), var_class_name.clone()]).to_string().to_lower())])
	}
	closure_8_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_class_name := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.call_function('sprintf', [rt.new_string('woocommerce_%s_settings'),
			rt.new_string(rt.call_function('str_replace', [rt.new_string('WC_Email_'),
				rt.new_string(''), var_class_name.clone()]).to_string().to_lower())])
	}
	closure_9_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_class_name := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.call_function('sprintf', [rt.new_string('woocommerce_%s_settings'),
			rt.new_string(rt.call_function('str_replace', [rt.new_string('WC_Email_'),
				rt.new_string(''), var_class_name.clone()]).to_string().to_lower())])
	}
	closure_10_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_class_name := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.call_function('sprintf', [rt.new_string('woocommerce_%s_settings'),
			rt.new_string(rt.call_function('str_replace', [rt.new_string('WC_Email_'),
				rt.new_string(''), var_class_name.clone()]).to_string().to_lower())])
	}
	rt.call_function('wp_prime_option_caches', [
		rt.call_function('array_map', [rt.new_closure(closure_7_fn),
			rt.func_array_keys(rt.create_array_from_native_map(var_emails))]),
	])
	for var_class, var_path in var_emails {
		this.emails.array_set(class, rt.include_file(path, '1'))
	}
	mut iife_temp_10 := Class_Automattic_WooCommerce_Utilities_FeaturesUtil{}
	mut iife_result_10 := iife_temp_10.feature_is_enabled(rt.new_string('block_email_editor'))
	if rt.is_true(iife_result_10) {
		this.emails.array_set('WC_Email_Customer_Partially_Refunded_Order', rt.include_file(@DIR +
			'/emails/class-wc-email-customer-partially-refunded-order.php', '1'))
	}
	this.emails = rt.call_function('apply_filters', [
		rt.new_string('woocommerce_email_classes'),
		this.emails,
	])
}

fn (mut this Class_WC_Emails) get_emails() rt.PhpVal {
	return this.emails
}

fn (mut this Class_WC_Emails) get_from_name() rt.PhpVal {
	mut var_default := rt.call_function('get_bloginfo', [rt.new_string('name'),
		rt.new_string('display')])
	return rt.call_function('wp_specialchars_decode', [
		rt.call_function('get_option', [rt.new_string('woocommerce_email_from_name'),
			var_default.clone()]),
		rt.get_constant('ENT_QUOTES'),
	])
}

fn (mut this Class_WC_Emails) get_from_address() rt.PhpVal {
	return rt.call_function('sanitize_email', [
		rt.call_function('get_option', [rt.new_string('woocommerce_email_from_address')]),
	])
}

fn (mut this Class_WC_Emails) email_header(var_email_heading rt.PhpVal) {
	rt.call_function('wc_get_template', [rt.new_string('emails/email-header.php'),
		rt.create_array([rt.ArrayItem{ key: 'email_heading', val: var_email_heading },
			rt.ArrayItem{ key: 'store_name', val: rt.call_function('get_bloginfo', [
				rt.new_string('name'),
				rt.new_string('display'),
			]) }])])
}

fn (mut this Class_WC_Emails) email_footer() {
	rt.call_function('wc_get_template', [rt.new_string('emails/email-footer.php')])
}

fn (mut this Class_WC_Emails) replace_placeholders(var_text rt.PhpVal) rt.PhpVal {
	mut var_text_mutated := var_text
	if !(var_text_mutated.clone().is_string()) {
		var_text_mutated = rt.new_string((if rt.is_true(rt.call_function('is_scalar', [
			var_text_mutated.clone(),
		]))
		{ var_text_mutated.str() } else { '' }).str())
	}
	mut var_domain := rt.call_function('wp_parse_url', [
		rt.call_function('home_url', []rt.PhpVal{}),
		rt.get_constant('PHP_URL_HOST'),
	])
	return rt.call_function('str_replace', [
		rt.create_array([rt.ArrayItem{ key: none, val: '{site_title}' },
			rt.ArrayItem{ key: none, val: '{site_address}' },
			rt.ArrayItem{ key: none, val: '{site_url}' }, rt.ArrayItem{
				key: none
				val: '{woocommerce}'
			}, rt.ArrayItem{ key: none, val: '{WooCommerce}' },
			rt.ArrayItem{ key: none, val: '{store_address}' },
			rt.ArrayItem{ key: none, val: '{store_email}' }]),
		rt.create_array([rt.ArrayItem{ key: none, val: this.get_blogname() },
			rt.ArrayItem{ key: none, val: var_domain }, rt.ArrayItem{ key: none, val: var_domain },
			rt.ArrayItem{ key: none, val: '<a href="https://woocommerce.com">WooCommerce</a>' },
			rt.ArrayItem{ key: none, val: '<a href="https://woocommerce.com">WooCommerce</a>' },
			rt.ArrayItem{ key: none, val: this.get_store_address() },
			rt.ArrayItem{ key: none, val: this.get_from_address() }]),
		var_text_mutated.clone(),
	])
}

fn (mut this Class_WC_Emails) email_footer_replace_site_title(var_text rt.PhpVal) rt.PhpVal {
	mut var_text_mutated := var_text
	rt.call_function('wc_deprecated_function', [
		rt.new_string('WC_Emails::email_footer_replace_site_title'),
		rt.new_string('3.7.0'),
		rt.new_string('WC_Emails::replace_placeholders'),
	])
	return this.replace_placeholders(var_text_mutated.clone())
}

fn (mut this Class_WC_Emails) wrap_message(var_email_heading rt.PhpVal, var_message rt.PhpVal, deprecated bool) rt.PhpVal {
	mut var_message_mutated := var_message
	if var_deprecated {
		rt.call_function('wc_deprecated_argument', [
			rt.new_string('WC_Emails::wrap_message'),
			rt.new_string('9.9.0'),
		])
	}
	rt.call_function('ob_start', []rt.PhpVal{})
	rt.call_function('do_action', [rt.new_string('woocommerce_email_header'),
		var_email_heading.clone(), rt.new_null()])
	rt.echo_val(rt.call_function('wp_kses_post', [
		rt.call_function('wpautop', [
			rt.call_function('wptexturize', [var_message_mutated.clone()]),
		]),
	]))
	rt.call_function('do_action', [rt.new_string('woocommerce_email_footer'),
		rt.new_null()])
	return rt.call_function('ob_get_clean', []rt.PhpVal{})
}

fn (mut this Class_WC_Emails) send(var_to rt.PhpVal, var_subject rt.PhpVal, var_message rt.PhpVal, headers string, attachments string) rt.PhpVal {
	mut var_subject_mutated := var_subject
	mut var_message_mutated := var_message
	mut var_email := create_wc_email()
	return rt.call_method(var_email, 'send', [var_to.clone(),
		var_subject_mutated.clone(), var_message_mutated.clone(),
		rt.new_string(headers), rt.new_string(attachments)])
}

fn (mut this Class_WC_Emails) customer_invoice(var_order rt.PhpVal) {
	mut var_order_mutated := var_order
	mut var_email := this.emails.array_get(rt.new_string('WC_Email_Customer_Invoice'))
	if !(var_order_mutated.clone().is_object()) {
		var_order_mutated = rt.call_function('wc_get_order', [
			rt.call_function('absint', [var_order_mutated.clone()]),
		])
	}
	rt.call_method(var_email, 'trigger', [
		rt.call_method(var_order_mutated, 'get_id', []rt.PhpVal{}),
		var_order_mutated.clone(),
	])
}

fn (mut this Class_WC_Emails) customer_new_account(var_customer_id rt.PhpVal, var_new_customer_data rt.PhpVal, password_generated bool) {
	if rt.is_true(rt.new_bool(!(rt.is_true(var_customer_id)))) {
		return
	}
	mut var_email := this.emails.array_get(rt.new_string('WC_Email_Customer_New_Account'))
	rt.call_method(var_email, 'trigger', [var_customer_id.clone(), if !(var_new_customer_data.array_get(rt.new_string('user_pass'))).is_null() {
		var_new_customer_data.array_get(rt.new_string('user_pass'))
	} else {
		rt.new_string('')
	}, rt.new_bool(password_generated)])
}

fn (mut this Class_WC_Emails) order_details(var_order rt.PhpVal, sent_to_admin bool, plain_text bool, email string) {
	mut var_order_mutated := var_order
	mut email_mutated := email
	if var_plain_text {
		rt.call_function('wc_get_template', [
			rt.new_string('emails/plain/email-order-details.php'),
			rt.create_array([rt.ArrayItem{ key: 'order', val: var_order_mutated },
				rt.ArrayItem{ key: 'sent_to_admin', val: sent_to_admin },
				rt.ArrayItem{ key: 'plain_text', val: plain_text },
				rt.ArrayItem{ key: 'email', val: email_mutated }]),
		])
	} else {
		rt.call_function('wc_get_template', [
			rt.new_string('emails/email-order-details.php'),
			rt.create_array([rt.ArrayItem{ key: 'order', val: var_order_mutated },
				rt.ArrayItem{ key: 'sent_to_admin', val: sent_to_admin },
				rt.ArrayItem{ key: 'plain_text', val: plain_text },
				rt.ArrayItem{ key: 'email', val: email_mutated }]),
		])
	}
}

fn (mut this Class_WC_Emails) order_downloads(var_order rt.PhpVal, sent_to_admin bool, plain_text bool, email string) {
	mut var_order_mutated := var_order
	mut email_mutated := email
	mut var_show_downloads := rt.new_bool(
		rt.is_true(rt.call_method(var_order_mutated, 'has_downloadable_item', []rt.PhpVal{}))
		&& rt.is_true(rt.call_method(var_order_mutated, 'is_download_permitted', []rt.PhpVal{}))
		&& !var_sent_to_admin
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_a', [rt.new_string(email_mutated).clone(), rt.new_string('WC_Email_Customer_Refunded_Order')]))))))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_show_downloads)))) {
		return
	}
	mut var_downloads := rt.call_method(var_order_mutated, 'get_downloadable_items', []rt.PhpVal{})
	mut var_columns := rt.call_function('apply_filters', [
		rt.new_string('woocommerce_email_downloads_columns'),
		rt.create_array([
			rt.ArrayItem{ key: 'download-product', val: rt.call_function('__', [
				rt.new_string('Product'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'download-expires', val: rt.call_function('__', [
				rt.new_string('Expires'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'download-file', val: rt.call_function('__', [
				rt.new_string('Download'),
				rt.new_string('woocommerce'),
			]) },
		]),
		var_order_mutated.clone(),
	])
	if var_plain_text {
		rt.call_function('wc_get_template', [
			rt.new_string('emails/plain/email-downloads.php'),
			rt.create_array([rt.ArrayItem{ key: 'order', val: var_order_mutated },
				rt.ArrayItem{ key: 'sent_to_admin', val: sent_to_admin },
				rt.ArrayItem{ key: 'plain_text', val: plain_text },
				rt.ArrayItem{ key: 'email', val: email_mutated },
				rt.ArrayItem{ key: 'downloads', val: var_downloads },
				rt.ArrayItem{ key: 'columns', val: var_columns }]),
		])
	} else {
		rt.call_function('wc_get_template', [rt.new_string('emails/email-downloads.php'),
			rt.create_array([rt.ArrayItem{ key: 'order', val: var_order_mutated },
				rt.ArrayItem{ key: 'sent_to_admin', val: sent_to_admin },
				rt.ArrayItem{ key: 'plain_text', val: plain_text },
				rt.ArrayItem{ key: 'email', val: email_mutated },
				rt.ArrayItem{ key: 'downloads', val: var_downloads },
				rt.ArrayItem{ key: 'columns', val: var_columns }])])
	}
}

fn (mut this Class_WC_Emails) order_meta(var_order rt.PhpVal, sent_to_admin bool, plain_text bool) {
	mut var_order_mutated := var_order
	mut var_fields := rt.call_function('apply_filters', [
		rt.new_string('woocommerce_email_order_meta_fields'),
		rt.new_array(),
		rt.new_bool(sent_to_admin),
		var_order_mutated.clone(),
	])
	mut var__fields := rt.call_function('apply_filters', [
		rt.new_string('woocommerce_email_order_meta_keys'),
		rt.new_array(),
		rt.new_bool(sent_to_admin),
	])
	if rt.is_true(var__fields) {
		mut iter_3 := var__fields.iterator()
		for {
			item_3 := iter_3.next() or { break }
			mut var_field := item_3.val
			mut var_key := item_3.key
			if rt.is_true(rt.new_bool(var_key.clone().is_long() || var_key.clone().is_double())) {
				var_key = var_field
			}
			var_fields.array_set(var_key, rt.create_array([
				rt.ArrayItem{ key: 'label', val: rt.call_function('wptexturize', [
					var_key.clone(),
				]) },
				rt.ArrayItem{ key: 'value', val: rt.call_function('wptexturize', [
					rt.call_method(var_order_mutated, 'get_meta', [
						var_field.clone()]),
				]) },
			]))
		}
	}
	if rt.is_true(var_fields) {
		if var_plain_text {
			mut iter_4 := var_fields.iterator()
			for {
				item_4 := iter_4.next() or { break }
				mut var_field := item_4.val
				if var_field.array_isset(rt.new_string('label'))
					&& var_field.array_isset(rt.new_string('value'))
					&& rt.is_true(var_field.array_get(rt.new_string('value'))) {
					print(
						(rt.call_function('wp_kses_post', [rt.new_string((var_field.array_get(rt.new_string('label'))).str() +
						': ' + (var_field.array_get(rt.new_string('value'))).str())])).str() + '\n')
				}
			}
		} else {
			mut iter_5 := var_fields.iterator()
			for {
				item_5 := iter_5.next() or { break }
				mut var_field := item_5.val
				if var_field.array_isset(rt.new_string('label'))
					&& var_field.array_isset(rt.new_string('value'))
					&& rt.is_true(var_field.array_get(rt.new_string('value'))) {
					print('<p><strong>' +
						(rt.call_function('wp_kses_post', [var_field.array_get(rt.new_string('label'))])).str() +
						':</strong> ' +
						(rt.call_function('wp_kses_post', [var_field.array_get(rt.new_string('value'))])).str() +
						'</p>')
				}
			}
		}
	}
}

fn (mut this Class_WC_Emails) fulfillment_details(var_order rt.PhpVal, var_fulfillment rt.PhpVal, sent_to_admin bool, plain_text bool, email string) {
	mut var_order_mutated := var_order
	mut email_mutated := email
	if var_plain_text {
		rt.call_function('wc_get_template', [
			rt.new_string('emails/plain/email-fulfillment-details.php'),
			rt.create_array([rt.ArrayItem{ key: 'order', val: var_order_mutated },
				rt.ArrayItem{ key: 'fulfillment', val: var_fulfillment },
				rt.ArrayItem{ key: 'sent_to_admin', val: sent_to_admin },
				rt.ArrayItem{ key: 'plain_text', val: plain_text },
				rt.ArrayItem{ key: 'email', val: email_mutated }]),
		])
	} else {
		rt.call_function('wc_get_template', [
			rt.new_string('emails/email-fulfillment-details.php'),
			rt.create_array([rt.ArrayItem{ key: 'order', val: var_order_mutated },
				rt.ArrayItem{ key: 'fulfillment', val: var_fulfillment },
				rt.ArrayItem{ key: 'sent_to_admin', val: sent_to_admin },
				rt.ArrayItem{ key: 'plain_text', val: plain_text },
				rt.ArrayItem{ key: 'email', val: email_mutated }]),
		])
	}
}

fn (mut this Class_WC_Emails) fulfillment_meta(var_order rt.PhpVal, var_fulfillment rt.PhpVal, sent_to_admin bool, plain_text bool) {
	mut var_order_mutated := var_order
	mut var_fields := rt.call_method(var_fulfillment, 'get_meta_data', []rt.PhpVal{})
	closure_12_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_field := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return
	}
	mut var_public_fields := rt.call_function('array_filter', [
		var_fields.clone(), rt.new_closure(closure_12_fn)])
	if 0 < var_public_fields.clone().array_count() {
		mut iter_6 := var_public_fields.iterator()
		for {
			item_6 := iter_6.next() or { break }
			mut var_field := item_6.val
			if !(rt.get_property(var_field, 'key')).is_null()
				&& !(rt.get_property(var_field, 'value')).is_null()
				&& rt.is_true(rt.get_property(var_field, 'value')) {
				mut var_meta_key_translation := rt.call_function('apply_filters', [
					rt.new_string('woocommerce_fulfillment_translate_meta_key'),
					rt.get_property(var_field, 'key'),
				])
				if var_plain_text {
					print(
						(rt.call_function('esc_attr', [var_meta_key_translation.clone()])).str() +
						': ' +
						(rt.call_function('esc_attr', [rt.get_property(var_field, 'value')])).str() +
						(rt.get_constant('PHP_EOL')).str())
				} else {
					print('<p><strong>' +
						(rt.call_function('esc_attr', [var_meta_key_translation.clone()])).str() +
						':</strong> ' +
						(rt.call_function('esc_attr', [rt.get_property(var_field, 'value')])).str() +
						'</p>')
				}
			}
		}
	}
}

fn (mut this Class_WC_Emails) customer_detail_field_is_valid(var_field rt.PhpVal) bool {
	return var_field.array_isset(rt.new_string('label'))
		&& !(!rt.is_true(var_field.array_get(rt.new_string('value'))))
}

fn (mut this Class_WC_Emails) customer_details(var_order rt.PhpVal, sent_to_admin bool, plain_text bool) {
	mut var_order_mutated := var_order
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_a', [
		var_order_mutated.clone(), rt.new_string('WC_Order')])))))
	{
		return
	}
	mut var_fields := rt.call_function('array_filter', [
		rt.call_function('apply_filters', [
			rt.new_string('woocommerce_email_customer_details_fields'),
			rt.new_array(),
			rt.new_bool(sent_to_admin),
			var_order_mutated.clone(),
		]),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Emails', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'customer_detail_field_is_valid' },
		]),
	])
	if !(!rt.is_true(var_fields)) {
		if var_plain_text {
			rt.call_function('wc_get_template', [
				rt.new_string('emails/plain/email-customer-details.php'),
				rt.create_array([rt.ArrayItem{ key: 'fields', val: var_fields }]),
			])
		} else {
			rt.call_function('wc_get_template', [
				rt.new_string('emails/email-customer-details.php'),
				rt.create_array([rt.ArrayItem{ key: 'fields', val: var_fields }]),
			])
		}
	}
}

fn (mut this Class_WC_Emails) email_addresses(var_order rt.PhpVal, sent_to_admin bool, plain_text bool) {
	mut var_order_mutated := var_order
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_a', [
		var_order_mutated.clone(), rt.new_string('WC_Order')])))))
	{
		return
	}
	if var_plain_text {
		rt.call_function('wc_get_template', [
			rt.new_string('emails/plain/email-addresses.php'),
			rt.create_array([rt.ArrayItem{ key: 'order', val: var_order_mutated },
				rt.ArrayItem{ key: 'sent_to_admin', val: sent_to_admin }]),
		])
	} else {
		rt.call_function('wc_get_template', [rt.new_string('emails/email-addresses.php'),
			rt.create_array([rt.ArrayItem{ key: 'order', val: var_order_mutated },
				rt.ArrayItem{ key: 'sent_to_admin', val: sent_to_admin }])])
	}
}

fn (mut this Class_WC_Emails) additional_checkout_fields(var_order rt.PhpVal, sent_to_admin bool, plain_text bool) {
	mut var_order_mutated := var_order
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_a', [
		var_order_mutated.clone(), rt.new_string('WC_Order')])))))
	{
		return
	}
	mut iife_temp_12 := Class_Automattic_WooCommerce_Blocks_Package{}
	mut iife_result_12 := iife_temp_12.container()
	mut var_checkout_fields := rt.call_method(iife_result_12, 'get', [
		Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFields.class(),
	])
	mut var_fields := rt.call_function('array_merge', [
		rt.call_method(var_checkout_fields, 'get_order_additional_fields_with_values', [
			var_order_mutated.clone(),
			rt.new_string('contact'),
			rt.new_string('other'),
			rt.new_string('view'),
		]),
		rt.call_method(var_checkout_fields, 'get_order_additional_fields_with_values', [
			var_order_mutated.clone(),
			rt.new_string('order'),
			rt.new_string('other'),
			rt.new_string('view'),
		]),
	])
	mut var_context := {
		'caller':        rt.new_string('WC_Email::additional_checkout_fields')
		'order':         var_order_mutated
		'sent_to_admin': rt.new_bool(sent_to_admin)
		'plain_text':    rt.new_bool(plain_text)
	}
	var_fields = rt.call_method(var_checkout_fields, 'filter_fields_for_order_confirmation', [
		var_fields.clone(),
		rt.create_array_from_native_map(var_context),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_fields)))) {
		return
	}
	if var_plain_text {
		print('\n' +
			(rt.call_function('esc_html', [rt.call_function('wc_strtoupper', [rt.call_function('__', [rt.new_string('Additional information'), rt.new_string('woocommerce')])])])).str() +
			'\n\n')
		mut iter_7 := var_fields.iterator()
		for {
			item_7 := iter_7.next() or { break }
			mut var_field := item_7.val
			rt.call_function('printf', [rt.new_string('%s: %s\n'),
				rt.call_function('wp_kses_post', [var_field.array_get(rt.new_string('label'))]),
				rt.call_function('wp_kses_post', [var_field.array_get(rt.new_string('value'))])])
		}
	} else {
		print('<h2>' +
			(rt.call_function('esc_html__', [rt.new_string('Additional information'), rt.new_string('woocommerce')])).str() +
			'</h2>')
		print('<ul class="additional-fields" style="margin-bottom: 40px;">')
		mut iter_8 := var_fields.iterator()
		for {
			item_8 := iter_8.next() or { break }
			mut var_field := item_8.val
			rt.call_function('printf', [
				rt.new_string('<li><strong>%s</strong>: %s</li>'),
				rt.call_function('wp_kses_post', [var_field.array_get(rt.new_string('label'))]),
				rt.call_function('wp_kses_post', [var_field.array_get(rt.new_string('value'))]),
			])
		}
		print('</ul>')
	}
}

fn (mut this Class_WC_Emails) additional_address_fields(var_address_type rt.PhpVal, var_order rt.PhpVal, sent_to_admin bool, plain_text bool) {
	mut var_order_mutated := var_order
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_a', [
		var_order_mutated.clone(), rt.new_string('WC_Order')])))))
	{
		return
	}
	mut iife_temp_13 := Class_Automattic_WooCommerce_Blocks_Package{}
	mut iife_result_13 := iife_temp_13.container()
	mut var_checkout_fields := rt.call_method(iife_result_13, 'get', [
		Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFields.class(),
	])
	mut var_fields := rt.call_method(var_checkout_fields,
		'get_order_additional_fields_with_values', [var_order_mutated.clone(),
		rt.new_string('address'), var_address_type.clone(), rt.new_string('view')])
	mut var_context := {
		'caller':        rt.new_string('WC_Email::additional_address_fields')
		'address_type':  var_address_type
		'order':         var_order_mutated
		'sent_to_admin': rt.new_bool(sent_to_admin)
		'plain_text':    rt.new_bool(plain_text)
	}
	var_fields = rt.call_method(var_checkout_fields, 'filter_fields_for_order_confirmation', [
		var_fields.clone(),
		rt.create_array_from_native_map(var_context),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_fields)))) {
		return
	}
	mut iter_9 := var_fields.iterator()
	for {
		item_9 := iter_9.next() or { break }
		mut var_field := item_9.val
		if var_plain_text {
			rt.call_function('printf', [rt.new_string('%s: %s\n'),
				rt.call_function('wp_kses_post', [var_field.array_get(rt.new_string('label'))]),
				rt.call_function('wp_kses_post', [var_field.array_get(rt.new_string('value'))])])
		} else {
			rt.call_function('printf', [rt.new_string('<br><strong>%s</strong>: %s'),
				rt.call_function('wp_kses_post', [var_field.array_get(rt.new_string('label'))]),
				rt.call_function('wp_kses_post', [var_field.array_get(rt.new_string('value'))])])
		}
	}
}

fn (mut this Class_WC_Emails) get_blogname() rt.PhpVal {
	return rt.call_function('wp_specialchars_decode', [
		rt.call_function('get_option', [rt.new_string('blogname')]),
		rt.get_constant('ENT_QUOTES'),
	])
}

fn (mut this Class_WC_Emails) get_store_address() rt.PhpVal {
	rt.call_function('add_filter', [
		rt.new_string('woocommerce_formatted_address_force_country_display'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Emails', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'get_store_address_force_country_display' },
		]),
		rt.new_int(5),
	])
	mut var_result := rt.call_function('wp_specialchars_decode', [
		rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'countries'),
			'get_formatted_address', [
			rt.create_array([
				rt.ArrayItem{ key: 'address_1', val: rt.call_method(rt.get_property(rt.call_function('WC',
					[]rt.PhpVal{}), 'countries'), 'get_base_address', []rt.PhpVal{}) },
				rt.ArrayItem{ key: 'address_2', val: rt.call_method(rt.get_property(rt.call_function('WC',
					[]rt.PhpVal{}), 'countries'), 'get_base_address_2', []rt.PhpVal{}) },
				rt.ArrayItem{ key: 'city', val: rt.call_method(rt.get_property(rt.call_function('WC',
					[]rt.PhpVal{}), 'countries'), 'get_base_city', []rt.PhpVal{}) },
				rt.ArrayItem{ key: 'state', val: rt.call_method(rt.get_property(rt.call_function('WC',
					[]rt.PhpVal{}), 'countries'), 'get_base_state', []rt.PhpVal{}) },
				rt.ArrayItem{ key: 'country', val: rt.call_method(rt.get_property(rt.call_function('WC',
					[]rt.PhpVal{}), 'countries'), 'get_base_country', []rt.PhpVal{}) },
				rt.ArrayItem{ key: 'postcode', val: rt.call_method(rt.get_property(rt.call_function('WC',
					[]rt.PhpVal{}), 'countries'), 'get_base_postcode', []rt.PhpVal{}) },
			]),
		]),
	])
	var_result = rt.call_function('preg_replace', [rt.new_string('/<br\\/?>/i'),
		rt.new_string(', '), var_result.clone()])
	rt.call_function('remove_filter', [
		rt.new_string('woocommerce_formatted_address_force_country_display'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Emails', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'get_store_address_force_country_display' },
		]),
	])
	return var_result.clone()
}

fn (mut this Class_WC_Emails) get_store_address_force_country_display() bool {
	return true
}

fn (mut this Class_WC_Emails) add_email_sender_filters() {
	rt.call_function('add_filter', [rt.new_string('wp_mail_from'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Emails', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'get_from_address' },
		])])
	rt.call_function('add_filter', [rt.new_string('wp_mail_from_name'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Emails', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'get_from_name' },
		])])
}

fn (mut this Class_WC_Emails) remove_email_sender_filters() {
	rt.call_function('remove_filter', [rt.new_string('wp_mail_from'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Emails', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'get_from_address' },
		])])
	rt.call_function('remove_filter', [rt.new_string('wp_mail_from_name'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Emails', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'get_from_name' },
		])])
}

fn (mut this Class_WC_Emails) low_stock(var_product rt.PhpVal) {
	mut var_product_mutated := var_product
	if rt.is_true(rt.identical(rt.new_string('no'), rt.call_function('get_option', [
		rt.new_string('woocommerce_notify_low_stock'),
		rt.new_string('yes'),
	])))
	{
		return
	}
	if rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('apply_filters', [
		rt.new_string('woocommerce_should_send_low_stock_notification'),
		rt.new_bool(true),
		rt.call_method(var_product_mutated, 'get_id', []rt.PhpVal{}),
	])))
	{
		return
	}
	if rt.is_true(rt.call_method(var_product_mutated, 'is_type', [rt.new_string('variation')]))
		&& rt.is_true(rt.identical(rt.new_string('parent'), rt.call_method(var_product_mutated, 'get_manage_stock', []rt.PhpVal{}))) {
		mut var_parent_product := rt.call_function('wc_get_product', [
			rt.call_method(var_product_mutated, 'get_parent_id', []rt.PhpVal{}),
		])
		if rt.is_true(var_parent_product) {
			var_product_mutated = var_parent_product.clone()
		}
	}
	mut var_subject := rt.call_function('sprintf', [rt.new_string('[%s] %s'),
		this.get_blogname(),
		rt.call_function('__', [
			rt.new_string('Product low in stock'),
			rt.new_string('woocommerce'),
		])])
	mut var_message := rt.call_function('sprintf', [
		rt.call_function('__', [
			rt.new_string('%1$s is low in stock. There are %2$d left.'),
			rt.new_string('woocommerce'),
		]),
		rt.call_function('html_entity_decode', [
			rt.call_function('wp_strip_all_tags', [
				rt.call_method(var_product_mutated, 'get_formatted_name', []rt.PhpVal{}),
			]),
			rt.get_constant('ENT_QUOTES'),
			rt.call_function('get_bloginfo', [
				rt.new_string('charset'),
			]),
		]),
		rt.call_function('html_entity_decode', [
			rt.call_function('wp_strip_all_tags', [
				rt.call_method(var_product_mutated, 'get_stock_quantity', []rt.PhpVal{}),
			]),
		]),
	])
	this.add_email_sender_filters()
	rt.call_function('wp_mail', [
		rt.call_function('apply_filters', [
			rt.new_string('woocommerce_email_recipient_low_stock'),
			rt.call_function('get_option', [
				rt.new_string('woocommerce_stock_email_recipient'),
			]),
			var_product_mutated.clone(),
			rt.new_null(),
		]),
		rt.call_function('apply_filters', [
			rt.new_string('woocommerce_email_subject_low_stock'),
			var_subject.clone(),
			var_product_mutated.clone(),
			rt.new_null(),
		]),
		rt.call_function('apply_filters', [
			rt.new_string('woocommerce_email_content_low_stock'),
			var_message.clone(),
			var_product_mutated.clone(),
		]),
		rt.call_function('apply_filters', [
			rt.new_string('woocommerce_email_headers'),
			rt.new_string(''),
			rt.new_string('low_stock'),
			var_product_mutated.clone(),
			rt.new_null(),
		]),
		rt.call_function('apply_filters', [
			rt.new_string('woocommerce_email_attachments'),
			rt.new_array(),
			rt.new_string('low_stock'),
			var_product_mutated.clone(),
			rt.new_null(),
		]),
	])
	this.remove_email_sender_filters()
}

fn (mut this Class_WC_Emails) no_stock(var_product rt.PhpVal) {
	mut var_product_mutated := var_product
	if rt.is_true(rt.identical(rt.new_string('no'), rt.call_function('get_option', [
		rt.new_string('woocommerce_notify_no_stock'),
		rt.new_string('yes'),
	])))
	{
		return
	}
	if rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('apply_filters', [
		rt.new_string('woocommerce_should_send_no_stock_notification'),
		rt.new_bool(true),
		rt.call_method(var_product_mutated, 'get_id', []rt.PhpVal{}),
	])))
	{
		return
	}
	if rt.is_true(rt.call_method(var_product_mutated, 'is_type', [Class_Automattic_WooCommerce_Enums_ProductType.variation()]))
		&& rt.is_true(rt.identical(rt.new_string('parent'), rt.call_method(var_product_mutated, 'get_manage_stock', []rt.PhpVal{}))) {
		mut var_parent_product := rt.call_function('wc_get_product', [
			rt.call_method(var_product_mutated, 'get_parent_id', []rt.PhpVal{}),
		])
		if rt.is_true(var_parent_product) {
			var_product_mutated = var_parent_product.clone()
		}
	}
	mut var_subject := rt.call_function('sprintf', [rt.new_string('[%s] %s'),
		this.get_blogname(),
		rt.call_function('__', [
			rt.new_string('Product out of stock'),
			rt.new_string('woocommerce'),
		])])
	mut var_message := rt.call_function('sprintf', [
		rt.call_function('__', [rt.new_string('%s is out of stock.'),
			rt.new_string('woocommerce')]),
		rt.call_function('html_entity_decode', [
			rt.call_function('wp_strip_all_tags', [
				rt.call_method(var_product_mutated, 'get_formatted_name', []rt.PhpVal{}),
			]),
			rt.get_constant('ENT_QUOTES'),
			rt.call_function('get_bloginfo', [
				rt.new_string('charset'),
			]),
		]),
	])
	this.add_email_sender_filters()
	rt.call_function('wp_mail', [
		rt.call_function('apply_filters', [
			rt.new_string('woocommerce_email_recipient_no_stock'),
			rt.call_function('get_option', [
				rt.new_string('woocommerce_stock_email_recipient'),
			]),
			var_product_mutated.clone(),
			rt.new_null(),
		]),
		rt.call_function('apply_filters', [
			rt.new_string('woocommerce_email_subject_no_stock'),
			var_subject.clone(),
			var_product_mutated.clone(),
			rt.new_null(),
		]),
		rt.call_function('apply_filters', [
			rt.new_string('woocommerce_email_content_no_stock'),
			var_message.clone(),
			var_product_mutated.clone(),
		]),
		rt.call_function('apply_filters', [
			rt.new_string('woocommerce_email_headers'),
			rt.new_string(''),
			rt.new_string('no_stock'),
			var_product_mutated.clone(),
			rt.new_null(),
		]),
		rt.call_function('apply_filters', [
			rt.new_string('woocommerce_email_attachments'),
			rt.new_array(),
			rt.new_string('no_stock'),
			var_product_mutated.clone(),
			rt.new_null(),
		]),
	])
	this.remove_email_sender_filters()
}

fn (mut this Class_WC_Emails) backorder(var_args rt.PhpVal) {
	mut var_args_mutated := var_args
	var_args_mutated = rt.call_function('wp_parse_args', [var_args_mutated.clone(),
		rt.create_array([rt.ArrayItem{ key: 'product', val: '' },
			rt.ArrayItem{ key: 'quantity', val: '' }, rt.ArrayItem{ key: 'order_id', val: '' }])])
	mut var_order := rt.call_function('wc_get_order', [
		var_args_mutated.array_get(rt.new_string('order_id')),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_args_mutated.array_get(rt.new_string('product'))))))
		|| !(var_args_mutated.array_get(rt.new_string('product')).is_object())
		|| rt.is_true(rt.new_bool(!(rt.is_true(var_args_mutated.array_get(rt.new_string('quantity'))))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(var_order)))) {
		return
	}
	mut var_stock_before := rt.add(var_args_mutated.array_get(rt.new_string('quantity')), rt.call_method(var_args_mutated.array_get(rt.new_string('product')),
		'get_stock_quantity', []rt.PhpVal{}))
	mut var_backordered_quantity := rt.sub(var_args_mutated.array_get(rt.new_string('quantity')), rt.call_function('max', [
		rt.new_int(0),
		var_stock_before.clone(),
	]))
	mut var_subject := rt.call_function('sprintf', [rt.new_string('[%s] %s'),
		this.get_blogname(),
		rt.call_function('__', [rt.new_string('Product backorder'),
			rt.new_string('woocommerce')])])
	mut var_message := rt.call_function('sprintf', [
		rt.call_function('__', [
			rt.new_string('%1$s units of %2$s have been backordered in order #%3$s.'),
			rt.new_string('woocommerce'),
		]),
		var_backordered_quantity.clone(),
		rt.call_function('html_entity_decode', [
			rt.call_function('wp_strip_all_tags', [
				rt.call_method(var_args_mutated.array_get(rt.new_string('product')),
					'get_formatted_name', []rt.PhpVal{}),
			]),
			rt.get_constant('ENT_QUOTES'),
			rt.call_function('get_bloginfo', [
				rt.new_string('charset'),
			]),
		]),
		rt.call_method(var_order, 'get_order_number', []rt.PhpVal{}),
	])
	this.add_email_sender_filters()
	rt.call_function('wp_mail', [
		rt.call_function('apply_filters', [
			rt.new_string('woocommerce_email_recipient_backorder'),
			rt.call_function('get_option', [
				rt.new_string('woocommerce_stock_email_recipient'),
			]),
			var_args_mutated.clone(),
			rt.new_null(),
		]),
		rt.call_function('apply_filters', [
			rt.new_string('woocommerce_email_subject_backorder'),
			var_subject.clone(),
			var_args_mutated.clone(),
			rt.new_null(),
		]),
		rt.call_function('apply_filters', [
			rt.new_string('woocommerce_email_content_backorder'),
			var_message.clone(),
			var_args_mutated.clone(),
		]),
		rt.call_function('apply_filters', [
			rt.new_string('woocommerce_email_headers'),
			rt.new_string(''),
			rt.new_string('backorder'),
			var_args_mutated.clone(),
			rt.new_null(),
		]),
		rt.call_function('apply_filters', [
			rt.new_string('woocommerce_email_attachments'),
			rt.new_array(),
			rt.new_string('backorder'),
			var_args_mutated.clone(),
			rt.new_null(),
		]),
	])
	this.remove_email_sender_filters()
}

fn (mut this Class_WC_Emails) order_schema_markup(var_order rt.PhpVal, sent_to_admin bool, plain_text bool) {
	mut var_order_mutated := var_order
	rt.call_function('wc_deprecated_function', [
		rt.new_string('WC_Emails::order_schema_markup'),
		rt.new_string('3.0'),
		rt.new_string('WC_Structured_Data::generate_order_data'),
	])
	rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'structured_data'),
		'generate_order_data', [var_order_mutated.clone(), rt.new_bool(sent_to_admin),
		rt.new_bool(plain_text)])
	rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'structured_data'),
		'output_structured_data', []rt.PhpVal{})
}

struct Class_Automattic_WooCommerce_Utilities_FeaturesUtil {
	rt.PhpObjectBase
}

struct Class_Automattic_Jetpack_Constants {
	rt.PhpObjectBase
}

struct Class_WC_Email {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_Package {
	rt.PhpObjectBase
}

fn create_wc_emails() &Class_WC_Emails {
	mut obj := &Class_WC_Emails{
		PhpObjectBase: rt.PhpObjectBase{}
		emails:        rt.new_array()
	}
	obj.construct()
	return obj
}

fn create_automattic_woocommerce_utilities_featuresutil(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Utilities_FeaturesUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_FeaturesUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_jetpack_constants(_args ...rt.PhpVal) &Class_Automattic_Jetpack_Constants {
	mut obj := &Class_Automattic_Jetpack_Constants{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_email(_args ...rt.PhpVal) &Class_WC_Email {
	mut obj := &Class_WC_Email{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_package(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_Package {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Package{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Emails) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'instance' {
			return Class_WC_Emails.instance()
		}
		'__clone' {
			this.magic_clone()
			return rt.new_null()
		}
		'__wakeup' {
			this.magic_wakeup()
			return rt.new_null()
		}
		'init_transactional_emails' {
			Class_WC_Emails.init_transactional_emails()
			return rt.new_null()
		}
		'queue_transactional_email' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			Class_WC_Emails.queue_transactional_email(dispatch_arg_0)
			return rt.new_null()
		}
		'send_queued_transactional_email' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			Class_WC_Emails.send_queued_transactional_email(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'send_transactional_email' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			Class_WC_Emails.send_transactional_email(dispatch_arg_0)
			return rt.new_null()
		}
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'init' {
			this.init()
			return rt.new_null()
		}
		'get_emails' {
			return this.get_emails()
		}
		'get_from_name' {
			return this.get_from_name()
		}
		'get_from_address' {
			return this.get_from_address()
		}
		'email_header' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.email_header(dispatch_arg_0)
			return rt.new_null()
		}
		'email_footer' {
			this.email_footer()
			return rt.new_null()
		}
		'replace_placeholders' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.replace_placeholders(dispatch_arg_0)
		}
		'email_footer_replace_site_title' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.email_footer_replace_site_title(dispatch_arg_0)
		}
		'wrap_message' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
			return this.wrap_message(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'send' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).str()
			dispatch_arg_4 := (if args.len > 4 { args[4] } else { rt.new_null() }).str()
			return this.send(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3,
				dispatch_arg_4)
		}
		'customer_invoice' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.customer_invoice(dispatch_arg_0)
			return rt.new_null()
		}
		'customer_new_account' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
			this.customer_new_account(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'order_details' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).str()
			this.order_details(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
			return rt.new_null()
		}
		'order_downloads' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).str()
			this.order_downloads(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
			return rt.new_null()
		}
		'order_meta' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
			this.order_meta(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'fulfillment_details' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).to_bool()
			dispatch_arg_4 := (if args.len > 4 { args[4] } else { rt.new_null() }).str()
			this.fulfillment_details(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2,
				dispatch_arg_3, dispatch_arg_4)
			return rt.new_null()
		}
		'fulfillment_meta' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).to_bool()
			this.fulfillment_meta(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
			return rt.new_null()
		}
		'customer_detail_field_is_valid' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.customer_detail_field_is_valid(dispatch_arg_0))
		}
		'customer_details' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
			this.customer_details(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'email_addresses' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
			this.email_addresses(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'additional_checkout_fields' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
			this.additional_checkout_fields(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'additional_address_fields' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).to_bool()
			this.additional_address_fields(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2,
				dispatch_arg_3)
			return rt.new_null()
		}
		'get_blogname' {
			return this.get_blogname()
		}
		'get_store_address' {
			return this.get_store_address()
		}
		'get_store_address_force_country_display' {
			return rt.new_bool(this.get_store_address_force_country_display())
		}
		'add_email_sender_filters' {
			this.add_email_sender_filters()
			return rt.new_null()
		}
		'remove_email_sender_filters' {
			this.remove_email_sender_filters()
			return rt.new_null()
		}
		'low_stock' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.low_stock(dispatch_arg_0)
			return rt.new_null()
		}
		'no_stock' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.no_stock(dispatch_arg_0)
			return rt.new_null()
		}
		'backorder' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.backorder(dispatch_arg_0)
			return rt.new_null()
		}
		'order_schema_markup' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
			this.order_schema_markup(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_Emails) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'emails' { return this.emails }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_Emails) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'emails' {
			this.emails = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Utilities_FeaturesUtil) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Utilities_FeaturesUtil) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_FeaturesUtil) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_Jetpack_Constants) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_Jetpack_Constants) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_Jetpack_Constants) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_Email) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Email) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Email) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Package) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_Package) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Package) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}
