import rt

struct Class_WC_Emails {
	rt.PhpObjectBase
pub mut:
		emails rt.PhpVal = rt.new_array()
		instance rt.PhpVal = rt.new_null()
		deferred_queue rt.PhpVal = rt.new_null()
}

fn Class_WC_Emails.instance() rt.PhpVal {
	if rt.is_true(rt.new_bool(// unsupported expression: Expr_StaticPropertyFetch.is_null())) {
		// unsupported assign target: Expr_StaticPropertyFetch
	}
	return // unsupported expression: Expr_StaticPropertyFetch
}

fn (mut this Class_WC_Emails) magic_clone()  {
	rt.call_function('wc_doing_it_wrong', [rt.new_string(@FN), rt.call_function('__', [rt.new_string('Cloning is forbidden.'), rt.new_string('woocommerce')]), rt.new_string('2.1')])
}

fn (mut this Class_WC_Emails) magic_wakeup()  {
	rt.call_function('wc_doing_it_wrong', [rt.new_string(@FN), rt.call_function('__', [rt.new_string('Unserializing instances of this class is forbidden.'), rt.new_string('woocommerce')]), rt.new_string('2.1')])
}

fn Class_WC_Emails.init_transactional_emails()  {
	mut var_email_actions := rt.call_function('apply_filters', [rt.new_string('woocommerce_email_actions'), rt.create_array([rt.ArrayItem{ key: none, val: 'woocommerce_low_stock' }, rt.ArrayItem{ key: none, val: 'woocommerce_no_stock' }, rt.ArrayItem{ key: none, val: 'woocommerce_product_on_backorder' }, rt.ArrayItem{ key: none, val: 'woocommerce_order_status_pending_to_processing' }, rt.ArrayItem{ key: none, val: 'woocommerce_order_status_pending_to_completed' }, rt.ArrayItem{ key: none, val: 'woocommerce_order_status_processing_to_cancelled' }, rt.ArrayItem{ key: none, val: 'woocommerce_order_status_pending_to_failed' }, rt.ArrayItem{ key: none, val: 'woocommerce_order_status_pending_to_on-hold' }, rt.ArrayItem{ key: none, val: 'woocommerce_order_status_failed_to_processing' }, rt.ArrayItem{ key: none, val: 'woocommerce_order_status_failed_to_completed' }, rt.ArrayItem{ key: none, val: 'woocommerce_order_status_failed_to_on-hold' }, rt.ArrayItem{ key: none, val: 'woocommerce_order_status_cancelled_to_processing' }, rt.ArrayItem{ key: none, val: 'woocommerce_order_status_cancelled_to_completed' }, rt.ArrayItem{ key: none, val: 'woocommerce_order_status_cancelled_to_on-hold' }, rt.ArrayItem{ key: none, val: 'woocommerce_order_status_on-hold_to_processing' }, rt.ArrayItem{ key: none, val: 'woocommerce_order_status_on-hold_to_cancelled' }, rt.ArrayItem{ key: none, val: 'woocommerce_order_status_on-hold_to_failed' }, rt.ArrayItem{ key: none, val: 'woocommerce_order_status_completed' }, rt.ArrayItem{ key: none, val: 'woocommerce_order_status_failed' }, rt.ArrayItem{ key: none, val: 'woocommerce_order_fully_refunded' }, rt.ArrayItem{ key: none, val: 'woocommerce_order_partially_refunded' }, rt.ArrayItem{ key: none, val: 'woocommerce_send_review_request' }, rt.ArrayItem{ key: none, val: 'woocommerce_new_customer_note' }, rt.ArrayItem{ key: none, val: 'woocommerce_created_customer' }, rt.ArrayItem{ key: none, val: 'woocommerce_payment_gateway_enabled' }])])
	mut var_defer_default := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Utilities_FeaturesUtil{}; return temp.feature_is_enabled(arg_0) }(rt.new_string('deferred_transactional_emails'))
	if rt.is_true(rt.call_function('apply_filters', [rt.new_string('woocommerce_defer_transactional_emails'), var_defer_default.dup()])) {
		// unsupported assign target: Expr_StaticPropertyFetch
		{
			mut iter_1 := var_email_actions.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_action := item_1.val
				rt.call_function('add_action', [var_action.dup(), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'queue_transactional_email' }]), rt.new_int(10), rt.new_int(10)])
			}
		}
	} else {
		{
			mut iter_1 := var_email_actions.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_action := item_1.val
				rt.call_function('add_action', [var_action.dup(), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'send_transactional_email' }]), rt.new_int(10), rt.new_int(10)])
			}
		}
	}
}

fn Class_WC_Emails.queue_transactional_email(var_args rt.PhpVal)  {
	mut var_args_mutated := var_args
	if rt.is_true(rt.new_bool(rt.instance_of(// unsupported expression: Expr_StaticPropertyFetch, 'Automattic_WooCommerce_Internal_Email_DeferredEmailQueue'))) {
		rt.call_method(// unsupported expression: Expr_StaticPropertyFetch, 'push', [rt.call_function('current_filter', []rt.PhpVal{}), var_args_mutated.dup()])
	} else {
		Class_WC_Emails.send_transactional_email(var_args_mutated.dup())
	}
}

fn Class_WC_Emails.send_queued_transactional_email(filter string, var_args rt.PhpVal)  {
	mut var_args_mutated := var_args
	if rt.is_true(rt.call_function('apply_filters', [rt.new_string('woocommerce_allow_send_queued_transactional_email'), rt.new_bool(true), rt.new_string(filter), var_args_mutated.dup()])) {
		Class_WC_Emails.instance()
		rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'payment_gateways', []rt.PhpVal{})
		rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'shipping', []rt.PhpVal{})
		rt.call_function('do_action_ref_array', [filter + '_notification', var_args_mutated.dup()])
	}
}

fn Class_WC_Emails.send_transactional_email(var_args rt.PhpVal)  {
	mut var_args_mutated := var_args
	var_args_mutated = rt.call_function('func_get_args', []rt.PhpVal{})
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	Class_WC_Emails.instance()
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	rt.call_function('do_action_ref_array', [(rt.call_function('current_filter', []rt.PhpVal{})).str() + '_notification', var_args_mutated.dup()])
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	unsafe { goto end_label_1 }

catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'Exception') {
		mut var_e := var_e_1.dup()
		mut var_error := rt.new_string('Transactional email triggered fatal error for callback ' + (rt.call_function('current_filter', []rt.PhpVal{})).str())
		mut var_logger := rt.call_function('wc_get_logger', []rt.PhpVal{})
		rt.call_method(var_logger, 'critical', [rt.concat(var_error, rt.get_constant('PHP_EOL')), rt.create_array([rt.ArrayItem{ key: 'source', val: 'transactional-emails' }])])
		if rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_Jetpack_Constants{}; return temp.is_true(arg_0) }(rt.new_string('WP_DEBUG'))) {
			rt.call_function('trigger_error', [rt.call_function('esc_html', [var_error.dup()]), rt.get_constant('E_USER_WARNING')])
			// unsupported statement: Stmt_Nop
		}
		unsafe { goto end_label_1 }
	}
	else {
		rt.throw_exception(var_e_1)
		unsafe { goto end_label_1 }
	}

end_label_1:
}

fn (mut this Class_WC_Emails) construct()  {
	this.init()
	rt.call_function('add_action', [rt.new_string('woocommerce_email_header'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Emails', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'email_header' }])])
	rt.call_function('add_action', [rt.new_string('woocommerce_email_footer'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Emails', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'email_footer' }])])
	rt.call_function('add_action', [rt.new_string('woocommerce_email_order_details'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Emails', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'order_downloads' }]), rt.new_int(10), rt.new_int(4)])
	rt.call_function('add_action', [rt.new_string('woocommerce_email_order_details'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Emails', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'order_details' }]), rt.new_int(10), rt.new_int(4)])
	rt.call_function('add_action', [rt.new_string('woocommerce_email_order_meta'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Emails', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'order_meta' }]), rt.new_int(10), rt.new_int(3)])
	rt.call_function('add_action', [rt.new_string('woocommerce_email_customer_details'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Emails', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'customer_details' }]), rt.new_int(10), rt.new_int(3)])
	rt.call_function('add_action', [rt.new_string('woocommerce_email_customer_details'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Emails', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'email_addresses' }]), rt.new_int(20), rt.new_int(3)])
	rt.call_function('add_action', [rt.new_string('woocommerce_email_customer_details'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Emails', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'additional_checkout_fields' }]), rt.new_int(30), rt.new_int(3)])
	rt.call_function('add_action', [rt.new_string('woocommerce_email_customer_address_section'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Emails', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'additional_address_fields' }]), rt.new_int(30), rt.new_int(4)])
	if rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Utilities_FeaturesUtil{}; return temp.feature_is_enabled(arg_0) }(rt.new_string('fulfillments'))) {
		rt.call_function('add_action', [rt.new_string('woocommerce_email_fulfillment_details'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Emails', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'fulfillment_details' }]), rt.new_int(10), rt.new_int(5)])
		rt.call_function('add_action', [rt.new_string('woocommerce_email_fulfillment_meta'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Emails', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'fulfillment_meta' }]), rt.new_int(30), rt.new_int(4)])
	}
	rt.call_function('add_action', [rt.new_string('woocommerce_low_stock_notification'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Emails', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'low_stock' }])])
	rt.call_function('add_action', [rt.new_string('woocommerce_no_stock_notification'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Emails', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'no_stock' }])])
	rt.call_function('add_action', [rt.new_string('woocommerce_product_on_backorder_notification'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Emails', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'backorder' }])])
	rt.call_function('add_action', [rt.new_string('woocommerce_created_customer_notification'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Emails', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'customer_new_account' }]), rt.new_int(10), rt.new_int(3)])
	rt.call_function('add_filter', [rt.new_string('woocommerce_email_footer_text'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Emails', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'replace_placeholders' }])])
	rt.call_function('do_action', [rt.new_string('woocommerce_email'), rt.new_object('WC_Emails', []string{}, &this)])
}

fn (mut this Class_WC_Emails) init()  {
	mut var_class_name := rt.new_null()
	rt.include_file(@DIR + '/emails/class-wc-email.php', '2')
	mut var_emails := { 'WC_Email_New_Order': @DIR + '/emails/class-wc-email-new-order.php', 'WC_Email_Cancelled_Order': @DIR + '/emails/class-wc-email-cancelled-order.php', 'WC_Email_Customer_Cancelled_Order': @DIR + '/emails/class-wc-email-customer-cancelled-order.php', 'WC_Email_Failed_Order': @DIR + '/emails/class-wc-email-failed-order.php', 'WC_Email_Customer_Failed_Order': @DIR + '/emails/class-wc-email-customer-failed-order.php', 'WC_Email_Customer_On_Hold_Order': @DIR + '/emails/class-wc-email-customer-on-hold-order.php', 'WC_Email_Customer_Processing_Order': @DIR + '/emails/class-wc-email-customer-processing-order.php', 'WC_Email_Customer_Completed_Order': @DIR + '/emails/class-wc-email-customer-completed-order.php', 'WC_Email_Customer_Refunded_Order': @DIR + '/emails/class-wc-email-customer-refunded-order.php', 'WC_Email_Customer_Invoice': @DIR + '/emails/class-wc-email-customer-invoice.php', 'WC_Email_Customer_Note': @DIR + '/emails/class-wc-email-customer-note.php', 'WC_Email_Customer_Reset_Password': @DIR + '/emails/class-wc-email-customer-reset-password.php', 'WC_Email_Customer_New_Account': @DIR + '/emails/class-wc-email-customer-new-account.php', 'WC_Email_Admin_Payment_Gateway_Enabled': @DIR + '/emails/class-wc-email-admin-payment-gateway-enabled.php' }
	if rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Utilities_FeaturesUtil{}; return temp.feature_is_enabled(arg_0) }(rt.new_string('point_of_sale'))) {
		var_emails['WC_Email_Customer_POS_Completed_Order'] = @DIR + '/emails/class-wc-email-customer-pos-completed-order.php'
		var_emails['WC_Email_Customer_POS_Refunded_Order'] = @DIR + '/emails/class-wc-email-customer-pos-refunded-order.php'
	}
	if rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Utilities_FeaturesUtil{}; return temp.feature_is_enabled(arg_0) }(rt.new_string('fulfillments'))) {
		var_emails['WC_Email_Customer_Fulfillment_Created'] = @DIR + '/emails/class-wc-email-customer-fulfillment-created.php'
		var_emails['WC_Email_Customer_Fulfillment_Updated'] = @DIR + '/emails/class-wc-email-customer-fulfillment-updated.php'
		var_emails['WC_Email_Customer_Fulfillment_Deleted'] = @DIR + '/emails/class-wc-email-customer-fulfillment-deleted.php'
	}
	if rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Utilities_FeaturesUtil{}; return temp.feature_is_enabled(arg_0) }(rt.new_string('customer_review_request'))) {
		var_emails['WC_Email_Customer_Review_Request'] = @DIR + '/emails/class-wc-email-customer-review-request.php'
	}
	closure_4_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_3_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_class_name := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return rt.call_function('sprintf', [rt.new_string('woocommerce_%s_settings'), rt.new_string(rt.call_function('str_replace', [rt.new_string('WC_Email_'), rt.new_string(''), var_class_name.dup()]).to_string().to_lower())])
	}
	mut var_class_name := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return rt.call_function('sprintf', [rt.new_string('woocommerce_%s_settings'), rt.new_string(rt.call_function('str_replace', [rt.new_string('WC_Email_'), rt.new_string(''), var_class_name.dup()]).to_string().to_lower())])
	}
	mut var_class_name := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return rt.call_function('sprintf', [rt.new_string('woocommerce_%s_settings'), rt.new_string(rt.call_function('str_replace', [rt.new_string('WC_Email_'), rt.new_string(''), var_class_name.dup()]).to_string().to_lower())])
	}
	mut var_class_name := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return rt.call_function('sprintf', [rt.new_string('woocommerce_%s_settings'), rt.new_string(rt.call_function('str_replace', [rt.new_string('WC_Email_'), rt.new_string(''), var_class_name.dup()]).to_string().to_lower())])
	}
	rt.call_function('wp_prime_option_caches', [rt.call_function('array_map', [rt.new_closure(closure_1_fn), rt.func_array_keys(var_emails.dup())])])
	for var_class, var_path in var_emails {
		this.emails.array_set(class, rt.include_file(path, '1'))
	}
	if rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Utilities_FeaturesUtil{}; return temp.feature_is_enabled(arg_0) }(rt.new_string('block_email_editor'))) {
		this.emails.array_set('WC_Email_Customer_Partially_Refunded_Order', rt.include_file(@DIR + '/emails/class-wc-email-customer-partially-refunded-order.php', '1'))
	}
	this.emails = rt.call_function('apply_filters', [rt.new_string('woocommerce_email_classes'), this.emails])
}

fn (mut this Class_WC_Emails) get_emails() rt.PhpVal {
	return this.emails
}

fn (mut this Class_WC_Emails) get_from_name() rt.PhpVal {
	mut var_default := rt.call_function('get_bloginfo', [rt.new_string('name'), rt.new_string('display')])
	return rt.call_function('wp_specialchars_decode', [rt.call_function('get_option', [rt.new_string('woocommerce_email_from_name'), var_default.dup()]), rt.get_constant('ENT_QUOTES')])
}

fn (mut this Class_WC_Emails) get_from_address() rt.PhpVal {
	return rt.call_function('sanitize_email', [rt.call_function('get_option', [rt.new_string('woocommerce_email_from_address')])])
}

fn (mut this Class_WC_Emails) email_header(var_email_heading rt.PhpVal)  {
	rt.call_function('wc_get_template', [rt.new_string('emails/email-header.php'), rt.create_array([rt.ArrayItem{ key: 'email_heading', val: var_email_heading }, rt.ArrayItem{ key: 'store_name', val: rt.call_function('get_bloginfo', [rt.new_string('name'), rt.new_string('display')]) }])])
}

fn (mut this Class_WC_Emails) email_footer()  {
	rt.call_function('wc_get_template', [rt.new_string('emails/email-footer.php')])
}

fn (mut this Class_WC_Emails) replace_placeholders(var_text rt.PhpVal) rt.PhpVal {
	mut var_text_mutated := var_text
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_text_mutated.dup().is_string()))))) {
		var_text_mutated = if rt.is_true(rt.call_function('is_scalar', [var_text_mutated.dup()])) { // unsupported expression: Expr_Cast_String } else { rt.new_string('') }
	}
	mut var_domain := rt.call_function('wp_parse_url', [rt.call_function('home_url', []rt.PhpVal{}), rt.get_constant('PHP_URL_HOST')])
	return rt.call_function('str_replace', [rt.create_array([rt.ArrayItem{ key: none, val: '{site_title}' }, rt.ArrayItem{ key: none, val: '{site_address}' }, rt.ArrayItem{ key: none, val: '{site_url}' }, rt.ArrayItem{ key: none, val: '{woocommerce}' }, rt.ArrayItem{ key: none, val: '{WooCommerce}' }, rt.ArrayItem{ key: none, val: '{store_address}' }, rt.ArrayItem{ key: none, val: '{store_email}' }]), rt.create_array([rt.ArrayItem{ key: none, val: this.get_blogname() }, rt.ArrayItem{ key: none, val: var_domain }, rt.ArrayItem{ key: none, val: var_domain }, rt.ArrayItem{ key: none, val: '<a href="https://woocommerce.com">WooCommerce</a>' }, rt.ArrayItem{ key: none, val: '<a href="https://woocommerce.com">WooCommerce</a>' }, rt.ArrayItem{ key: none, val: this.get_store_address() }, rt.ArrayItem{ key: none, val: this.get_from_address() }]), var_text_mutated.dup()])
}

fn (mut this Class_WC_Emails) email_footer_replace_site_title(var_text rt.PhpVal) rt.PhpVal {
	mut var_text_mutated := var_text
	rt.call_function('wc_deprecated_function', [rt.new_string('WC_Emails::email_footer_replace_site_title'), rt.new_string('3.7.0'), rt.new_string('WC_Emails::replace_placeholders')])
	return this.replace_placeholders(var_text_mutated.dup())
}

fn (mut this Class_WC_Emails) wrap_message(var_email_heading rt.PhpVal, var_message rt.PhpVal, deprecated bool) rt.PhpVal {
	mut var_message_mutated := var_message
	if var_deprecated {
		rt.call_function('wc_deprecated_argument', [rt.new_string('WC_Emails::wrap_message'), rt.new_string('9.9.0')])
	}
	rt.call_function('ob_start', []rt.PhpVal{})
	rt.call_function('do_action', [rt.new_string('woocommerce_email_header'), var_email_heading.dup(), rt.new_null()])
	rt.echo_val(rt.call_function('wp_kses_post', [rt.call_function('wpautop', [rt.call_function('wptexturize', [var_message_mutated.dup()])])]))
	rt.call_function('do_action', [rt.new_string('woocommerce_email_footer'), rt.new_null()])
	return rt.call_function('ob_get_clean', []rt.PhpVal{})
}

fn (mut this Class_WC_Emails) send(var_to rt.PhpVal, var_subject rt.PhpVal, var_message rt.PhpVal, headers string, attachments string) rt.PhpVal {
	mut var_subject_mutated := var_subject
	mut var_message_mutated := var_message
	mut var_email := create_wc_email()
	return rt.call_method(var_email, 'send', [var_to.dup(), var_subject_mutated.dup(), var_message_mutated.dup(), rt.new_string(headers), rt.new_string(attachments)])
}

fn (mut this Class_WC_Emails) customer_invoice(var_order rt.PhpVal)  {
	mut var_order_mutated := var_order
	mut var_email := this.emails.array_get('WC_Email_Customer_Invoice')
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_order_mutated.dup().is_object()))))) {
		var_order_mutated = rt.call_function('wc_get_order', [rt.call_function('absint', [var_order_mutated.dup()])])
	}
	rt.call_method(var_email, 'trigger', [rt.call_method(var_order_mutated, 'get_id', []rt.PhpVal{}), var_order_mutated.dup()])
}

fn (mut this Class_WC_Emails) customer_new_account(var_customer_id rt.PhpVal, var_new_customer_data rt.PhpVal, password_generated bool)  {
	if rt.is_true(rt.new_bool(!(rt.is_true(var_customer_id)))) {
		return rt.new_null()
	}
	mut var_email := this.emails.array_get('WC_Email_Customer_New_Account')
	rt.call_method(var_email, 'trigger', [var_customer_id.dup(), if !(var_new_customer_data.array_get('user_pass')).is_null() { var_new_customer_data.array_get('user_pass') } else { rt.new_string('') }, rt.new_bool(password_generated)])
}

fn (mut this Class_WC_Emails) order_details(var_order rt.PhpVal, sent_to_admin bool, plain_text bool, email string)  {
	mut var_order_mutated := var_order
	mut email_mutated := email
	if var_plain_text {
		rt.call_function('wc_get_template', [rt.new_string('emails/plain/email-order-details.php'), rt.create_array([rt.ArrayItem{ key: 'order', val: var_order_mutated }, rt.ArrayItem{ key: 'sent_to_admin', val: sent_to_admin }, rt.ArrayItem{ key: 'plain_text', val: plain_text }, rt.ArrayItem{ key: 'email', val: email_mutated }])])
	} else {
		rt.call_function('wc_get_template', [rt.new_string('emails/email-order-details.php'), rt.create_array([rt.ArrayItem{ key: 'order', val: var_order_mutated }, rt.ArrayItem{ key: 'sent_to_admin', val: sent_to_admin }, rt.ArrayItem{ key: 'plain_text', val: plain_text }, rt.ArrayItem{ key: 'email', val: email_mutated }])])
	}
}

fn (mut this Class_WC_Emails) order_downloads(var_order rt.PhpVal, sent_to_admin bool, plain_text bool, email string)  {
	mut var_order_mutated := var_order
	mut email_mutated := email
	mut var_show_downloads := rt.new_bool(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.call_method(, 'has_downloadable_item', []rt.PhpVal{})) && rt.is_true(rt.call_method(, 'is_download_permitted', []rt.PhpVal{})))) && !(var_sent_to_admin))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_a', [rt.new_string(email_mutated).dup(), rt.new_string('WC_Email_Customer_Refunded_Order')])))))))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_show_downloads)))) {
		return rt.new_null()
	}
	mut var_downloads := rt.call_method(var_order_mutated, 'get_downloadable_items', []rt.PhpVal{})
	mut var_columns := rt.call_function('apply_filters', [, , .dup()])
	if var_plain_text {
		
	} else {
	}
}

fn (mut this Class_WC_Emails) order_meta(var_order rt.PhpVal, sent_to_admin bool, plain_text bool)  {
	mut var_order_mutated := var_order
	
}

fn (mut this Class_WC_Emails) fulfillment_details(var_order rt.PhpVal, var_fulfillment rt.PhpVal, sent_to_admin bool, plain_text bool, email string)  {
	mut var_order_mutated := var_order
	mut email_mutated := email
}

fn (mut this Class_WC_Emails) fulfillment_meta(var_order rt.PhpVal, var_fulfillment rt.PhpVal, sent_to_admin bool, plain_text bool)  {
	mut var_order_mutated := var_order
}

fn (mut this Class_WC_Emails) customer_detail_field_is_valid(var_field rt.PhpVal) bool {
}

fn (mut this Class_WC_Emails) customer_details(var_order rt.PhpVal, sent_to_admin bool, plain_text bool)  {
	mut var_order_mutated := var_order
}

fn (mut this Class_WC_Emails) email_addresses(var_order rt.PhpVal, sent_to_admin bool, plain_text bool)  {
	mut var_order_mutated := var_order
}

fn (mut this Class_WC_Emails) additional_checkout_fields(var_order rt.PhpVal, sent_to_admin bool, plain_text bool)  {
	mut var_order_mutated := var_order
}

fn (mut this Class_WC_Emails) additional_address_fields(var_address_type rt.PhpVal, var_order rt.PhpVal, sent_to_admin bool, plain_text bool)  {
	mut var_order_mutated := var_order
}

fn (mut this Class_WC_Emails) get_blogname() rt.PhpVal {
}

fn (mut this Class_WC_Emails) get_store_address() rt.PhpVal {
}

fn (mut this Class_WC_Emails) get_store_address_force_country_display() bool {
}

fn (mut this Class_WC_Emails) add_email_sender_filters()  {
}

fn (mut this Class_WC_Emails) remove_email_sender_filters()  {
}

fn (mut this Class_WC_Emails) low_stock(var_product rt.PhpVal)  {
	mut var_product_mutated := var_product
}

fn (mut this Class_WC_Emails) no_stock(var_product rt.PhpVal)  {
	mut var_product_mutated := var_product
}

fn (mut this Class_WC_Emails) backorder(var_args rt.PhpVal)  {
	mut var_args_mutated := var_args
}

fn (mut this Class_WC_Emails) order_schema_markup(var_order rt.PhpVal, sent_to_admin bool, plain_text bool)  {
	mut var_order_mutated := var_order
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

fn create_wc_emails() &Class_WC_Emails {
	mut obj := &Class_WC_Emails{
		PhpObjectBase: rt.PhpObjectBase{}
		emails: rt.new_array()
		instance: rt.new_null()
		deferred_queue: rt.new_null()
	}
	obj.construct()
	return obj
}

fn create_automattic_woocommerce_utilities_featuresutil() &Class_Automattic_WooCommerce_Utilities_FeaturesUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_FeaturesUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_jetpack_constants() &Class_Automattic_Jetpack_Constants {
	mut obj := &Class_Automattic_Jetpack_Constants{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_email() &Class_WC_Email {
	mut obj := &Class_WC_Email{
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
			return this.send(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3, dispatch_arg_4)
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
			this.fulfillment_details(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3, dispatch_arg_4)
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
			this.additional_address_fields(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
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
		else { return none }
	}
}

fn (this &Class_WC_Emails) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'emails' { return this.emails }
		'instance' { return this.instance }
		'deferred_queue' { return this.deferred_queue }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_Emails) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'emails' { this.emails = val; return true }
		'instance' { this.instance = val; return true }
		'deferred_queue' { this.deferred_queue = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
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




pub fn init_wp_content_plugins_woocommerce_includes_class_wc_emails_php() {
	// unsupported statement: Stmt_Declare
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
