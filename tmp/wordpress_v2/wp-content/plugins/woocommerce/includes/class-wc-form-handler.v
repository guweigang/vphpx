import rt

struct Class_WC_Form_Handler {
	rt.PhpObjectBase
}

fn Class_WC_Form_Handler.init() {
	rt.call_function('add_action', [rt.new_string('template_redirect'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'redirect_reset_password_link' }])])
	rt.call_function('add_action', [rt.new_string('template_redirect'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'save_address' }])])
	rt.call_function('add_action', [rt.new_string('template_redirect'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'save_account_details' }])])
	rt.call_function('add_action', [rt.new_string('wp_loaded'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'checkout_action' }]),
		rt.new_int(20)])
	rt.call_function('add_action', [rt.new_string('wp_loaded'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'process_login' }]),
		rt.new_int(20)])
	rt.call_function('add_action', [rt.new_string('wp_loaded'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'process_registration' }]),
		rt.new_int(20)])
	rt.call_function('add_action', [rt.new_string('wp_loaded'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'process_lost_password' }]),
		rt.new_int(20)])
	rt.call_function('add_action', [rt.new_string('wp_loaded'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'process_reset_password' }]),
		rt.new_int(20)])
	rt.call_function('add_action', [rt.new_string('wp_loaded'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'cancel_order' }]),
		rt.new_int(20)])
	rt.call_function('add_action', [rt.new_string('wp_loaded'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'update_cart_action' }]),
		rt.new_int(20)])
	rt.call_function('add_action', [rt.new_string('wp_loaded'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'add_to_cart_action' }]),
		rt.new_int(20)])
	rt.call_function('add_action', [rt.new_string('wp'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'pay_action' }]),
		rt.new_int(20)])
	rt.call_function('add_action', [rt.new_string('wp'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'add_payment_method_action' }]),
		rt.new_int(20)])
	rt.call_function('add_action', [rt.new_string('wp'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'delete_payment_method_action' }]),
		rt.new_int(20)])
	rt.call_function('add_action', [rt.new_string('wp'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'set_default_payment_method_action' }]),
		rt.new_int(20)])
}

fn Class_WC_Form_Handler.redirect_reset_password_link() {
	if rt.is_true(rt.call_function('is_account_page', []rt.PhpVal{}))
		&& rt.get_superglobal('_GET').array_isset(rt.new_string('key'))
		&& rt.get_superglobal('_GET').array_isset(rt.new_string('id'))
		|| rt.get_superglobal('_GET').array_isset(rt.new_string('login')) {
		if rt.get_superglobal('_GET').array_isset(rt.new_string('login')) {
			mut var_user := rt.call_function('get_user_by', [
				rt.new_string('login'),
				rt.call_function('sanitize_user', [
					rt.call_function('wp_unslash',
						[rt.get_superglobal('_GET').array_get(rt.new_string('login'))]),
				])])
			mut var_user_id := if rt.is_true(var_user) {
				rt.get_property(var_user, 'ID')
			} else {
				rt.new_int(0)
			}
		} else {
			var_user_id = rt.call_function('absint',
				[rt.get_superglobal('_GET').array_get(rt.new_string('id'))])
		}
		mut var_logged_in_user_id := rt.call_function('get_current_user_id', []rt.PhpVal{})
		if rt.is_true(var_logged_in_user_id)
			&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_logged_in_user_id, var_user_id)))) {
			rt.call_function('wc_add_notice', [
				rt.call_function('__', [
					rt.new_string('This password reset key is for a different user account. Please log out and try again.'),
					rt.new_string('woocommerce'),
				]),
				rt.new_string('error'),
			])
			return
		}
		mut var_action := if rt.get_superglobal('_GET').array_isset(rt.new_string('action')) { rt.call_function('sanitize_text_field', [
				rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get(rt.new_string('action'))]),
			]) } else { rt.new_string('') }
		mut var_value := rt.call_function('sprintf', [rt.new_string('%d:%s'),
			var_user_id.clone(),
			rt.call_function('wp_unslash', [
				rt.get_superglobal('_GET').array_get(rt.new_string('key')),
			])])
		mut iife_temp_0 := Class_WC_Shortcode_My_Account{}
		mut iife_result_0 := iife_temp_0.set_reset_password_cookie(var_value.clone())
		rt.call_function('wp_safe_redirect', [
			rt.call_function('add_query_arg', [
				rt.create_array([rt.ArrayItem{ key: 'show-reset-form', val: 'true' },
					rt.ArrayItem{ key: 'action', val: var_action }]),
				rt.call_function('wc_lostpassword_url', []rt.PhpVal{}),
			]),
		])
		exit(0)
	}
}

fn Class_WC_Form_Handler.save_address() {
	mut var_wp := rt.new_null()
	mut var_nonce_value := rt.call_function('wc_get_var', [
		rt.get_superglobal('_REQUEST').array_get(rt.new_string('woocommerce-edit-address-nonce')),
		rt.call_function('wc_get_var', [rt.get_superglobal('_REQUEST').array_get(rt.new_string('_wpnonce')),
			rt.new_string('')]),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_verify_nonce', [
		var_nonce_value.clone(),
		rt.new_string('woocommerce-edit_address'),
	])))))
	{
		return
	}
	if !rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('action')))
		|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('edit_address'), rt.get_superglobal('_POST').array_get(rt.new_string('action')))))) {
		return
	}
	rt.call_function('wc_nocache_headers', []rt.PhpVal{})
	mut var_user_id := rt.call_function('get_current_user_id', []rt.PhpVal{})
	if rt.is_true(rt.less_equal(var_user_id, rt.new_int(0))) {
		return
	}
	mut var_customer := create_wc_customer(var_user_id.clone())
	if rt.is_true(rt.new_bool(!(rt.is_true(var_customer)))) {
		return
	}
	mut var_address_type := if rt.get_property(var_wp, 'query_vars').array_isset(rt.new_string('edit-address')) { rt.call_function('wc_edit_address_i18n', [
			rt.call_function('sanitize_title', [
				rt.get_property(var_wp, 'query_vars').array_get(rt.new_string('edit-address')),
			]),
			rt.new_bool(true),
		]) } else { rt.new_string('billing') }
	if !(rt.get_superglobal('_POST').array_isset(var_address_type.str() + '_country')) {
		return
	}
	mut var_address := rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}),
		'countries'), 'get_address_fields', [
		rt.call_function('wc_clean', [
			rt.call_function('wp_unslash', [
				rt.get_superglobal('_POST').array_get(rt.new_string(var_address_type.str() +
					'_country')),
			]),
		]),
		rt.new_string(var_address_type.str() + '_'),
	])
	mut iter_1 := var_address.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_field := item_1.val
		mut var_key := item_1.key
		if !(var_field.array_isset(rt.new_string('type'))) {
			var_field.array_set('type', 'text')
		}
		if rt.is_true(rt.identical(rt.new_string('checkbox'),
			var_field.array_get(rt.new_string('type'))))
		{
			mut var_value :=
				rt.new_int((rt.new_bool(rt.get_superglobal('_POST').array_isset(var_key))).to_i64())
		} else {
			var_value = if rt.get_superglobal('_POST').array_isset(var_key) { rt.call_function('wc_clean', [
					rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get(var_key)]),
				]) } else { rt.new_string('') }
		}
		var_value = rt.call_function('apply_filters', [
			rt.new_string('woocommerce_process_myaccount_field_' + var_key.str()),
			var_value.clone(),
		])
		if !(!rt.is_true(var_field.array_get(rt.new_string('required')))) && !rt.is_true(var_value) {
			rt.call_function('wc_add_notice', [
				rt.call_function('sprintf', [
					rt.call_function('__', [rt.new_string('%s is a required field.'),
						rt.new_string('woocommerce')]),
					var_field.array_get(rt.new_string('label')),
				]),
				rt.new_string('error'),
				rt.create_array([
					rt.ArrayItem{ key: 'id', val: var_key },
				]),
			])
		}
		if !(!rt.is_true(var_value)) {
			if !(!rt.is_true(var_field.array_get(rt.new_string('validate'))))
				&& var_field.array_get(rt.new_string('validate')).is_array() {
				mut iter_2 := var_field.array_get(rt.new_string('validate')).iterator()
				for {
					item_2 := iter_2.next() or { break }
					mut var_rule := item_2.val
					mut switch_val_1 := var_rule
					if rt.is_true(rt.equal(switch_val_1, rt.new_string('postcode'))) {
						mut var_country := rt.call_function('wc_clean', [
							rt.call_function('wp_unslash', [
								rt.get_superglobal('_POST').array_get(rt.new_string(
									var_address_type.str() + '_country')),
							]),
						])
						var_value = rt.call_function('wc_format_postcode', [
							var_value.clone(), var_country.clone()])
						mut iife_temp_1 := Class_WC_Validation{}
						mut iife_result_1 := iife_temp_1.is_postcode(var_value.clone(),
							var_country.clone())
						if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), var_value))))
							&& rt.is_true(rt.new_bool(!(rt.is_true(iife_result_1)))) {
							mut switch_val_2 := var_country
							if rt.is_true(rt.equal(switch_val_2, rt.new_string('IE'))) {
								mut var_postcode_validation_notice := rt.call_function('__', [
									rt.new_string('Please enter a valid Eircode.'),
									rt.new_string('woocommerce'),
								])
							} else {
								var_postcode_validation_notice = rt.call_function('__', [
									rt.new_string('Please enter a valid postcode / ZIP.'),
									rt.new_string('woocommerce'),
								])
							}
							rt.call_function('wc_add_notice', [
								var_postcode_validation_notice.clone(),
								rt.new_string('error')])
						}
					} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('phone'))) {
						mut iife_temp_2 := Class_WC_Validation{}
						mut iife_result_2 := iife_temp_2.is_phone(var_value.clone())
						if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), var_value))))
							&& rt.is_true(rt.new_bool(!(rt.is_true(iife_result_2)))) {
							rt.call_function('wc_add_notice', [
								rt.call_function('sprintf', [
									rt.call_function('__', [
										rt.new_string('%s is not a valid phone number.'),
										rt.new_string('woocommerce'),
									]),
									rt.new_string('<strong>' +
										(var_field.array_get(rt.new_string('label'))).str() + '</strong>'),
								]),
								rt.new_string('error'),
							])
						}
					} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('email'))) {
						var_value = rt.new_string(var_value.clone().to_string().to_lower())
						if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_email', [
							var_value.clone(),
						])))))
						{
							rt.call_function('wc_add_notice', [
								rt.call_function('sprintf', [
									rt.call_function('__', [
										rt.new_string('%s is not a valid email address.'),
										rt.new_string('woocommerce'),
									]),
									rt.new_string('<strong>' +
										(var_field.array_get(rt.new_string('label'))).str() + '</strong>'),
								]),
								rt.new_string('error'),
							])
						}
					}
				}
			}
		}
		if rt.is_true(rt.call_function('is_callable', [
			rt.create_array([rt.ArrayItem{ key: none, val: var_customer },
				rt.ArrayItem{ key: none, val: 'set_${var_key.to_string()}' }]),
		]))
		{
			rt.call_method(var_customer, 'set_${var_key.to_string()}', [
				var_value.clone()])
			if rt.has_exception() {
				unsafe {
					goto catch_label_1
				}
			}
		} else {
			var_customer.update_meta_data(var_key.clone(), var_value.clone())
			if rt.has_exception() {
				unsafe {
					goto catch_label_1
				}
			}
		}
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
		if rt.instance_of(var_e_1, 'WC_Data_Exception') {
			mut var_e := var_e_1.clone()
			if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('customer_invalid_billing_email'), rt.call_method(var_e,
				'getErrorCode', []rt.PhpVal{})))))
			{
				rt.call_function('wc_add_notice', [
					rt.call_method(var_e, 'getMessage', []rt.PhpVal{}),
					rt.new_string('error'),
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
	rt.call_function('do_action', [
		rt.new_string('woocommerce_after_save_address_validation'),
		var_user_id.clone(),
		var_address_type.clone(),
		var_address.clone(),
		var_customer,
	])
	if rt.is_true(rt.less(rt.new_int(0), rt.call_function('wc_notice_count', [
		rt.new_string('error'),
	])))
	{
		return
	}
	var_customer.save()
	rt.call_function('do_action', [rt.new_string('woocommerce_customer_save_address'),
		var_user_id.clone(), var_address_type.clone(), var_address.clone(), var_customer])
	if rt.is_true(rt.less(rt.new_int(0), rt.call_function('wc_notice_count', [
		rt.new_string('error'),
	])))
	{
		return
	}
	rt.call_function('wc_add_notice', [
		rt.call_function('__', [rt.new_string('Address changed successfully.'),
			rt.new_string('woocommerce')]),
	])
	rt.call_function('wp_safe_redirect', [
		rt.call_function('wc_get_endpoint_url', [rt.new_string('edit-address'),
			rt.new_string(''), rt.call_function('wc_get_page_permalink', [
				rt.new_string('myaccount'),
			])]),
	])
	exit(0)
}

fn Class_WC_Form_Handler.save_account_details() {
	mut var_nonce_value := rt.call_function('wc_get_var', [
		rt.get_superglobal('_REQUEST').array_get(rt.new_string('save-account-details-nonce')),
		rt.call_function('wc_get_var', [rt.get_superglobal('_REQUEST').array_get(rt.new_string('_wpnonce')),
			rt.new_string('')]),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_verify_nonce', [
		var_nonce_value.clone(),
		rt.new_string('save_account_details'),
	])))))
	{
		return
	}
	if !rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('action')))
		|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('save_account_details'), rt.get_superglobal('_POST').array_get(rt.new_string('action')))))) {
		return
	}
	rt.call_function('wc_nocache_headers', []rt.PhpVal{})
	mut var_user_id := rt.call_function('get_current_user_id', []rt.PhpVal{})
	if rt.is_true(rt.less_equal(var_user_id, rt.new_int(0))) {
		return
	}
	mut var_account_first_name := if !(!rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('account_first_name')))) { rt.call_function('wc_clean', [
			rt.call_function('wp_unslash', [
				rt.get_superglobal('_POST').array_get(rt.new_string('account_first_name')),
			]),
		]) } else { rt.new_string('') }
	mut var_account_last_name := if !(!rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('account_last_name')))) { rt.call_function('wc_clean', [
			rt.call_function('wp_unslash', [
				rt.get_superglobal('_POST').array_get(rt.new_string('account_last_name')),
			]),
		]) } else { rt.new_string('') }
	mut var_account_display_name := if !(!rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('account_display_name')))) { rt.call_function('wc_clean', [
			rt.call_function('wp_unslash', [
				rt.get_superglobal('_POST').array_get(rt.new_string('account_display_name')),
			]),
		]) } else { rt.new_string('') }
	mut var_account_email := if !(!rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('account_email')))) { rt.call_function('wc_clean', [
			rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get(rt.new_string('account_email'))]),
		]) } else { rt.new_string('') }
	mut var_pass_cur := if !(!rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('password_current')))) {
		rt.get_superglobal('_POST').array_get(rt.new_string('password_current'))
	} else {
		rt.new_string('')
	}
	mut var_pass1 := if !(!rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('password_1')))) {
		rt.get_superglobal('_POST').array_get(rt.new_string('password_1'))
	} else {
		rt.new_string('')
	}
	mut var_pass2 := if !(!rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('password_2')))) {
		rt.get_superglobal('_POST').array_get(rt.new_string('password_2'))
	} else {
		rt.new_string('')
	}
	mut var_save_pass := rt.new_bool(true)
	mut var_current_user := rt.call_function('get_user_by', [
		rt.new_string('id'), var_user_id.clone()])
	mut var_current_first_name := rt.get_property(var_current_user, 'first_name')
	mut var_current_last_name := rt.get_property(var_current_user, 'last_name')
	mut var_current_email := rt.get_property(var_current_user, 'user_email')
	mut var_user := create_stdclass()
	rt.set_property(var_user, 'ID', var_user_id.clone())
	rt.set_property(var_user, 'first_name', var_account_first_name.clone())
	rt.set_property(var_user, 'last_name', var_account_last_name.clone())
	rt.set_property(var_user, 'display_name', var_account_display_name.clone())
	if rt.is_true(rt.call_function('is_email', [var_account_display_name.clone()])) {
		rt.call_function('wc_add_notice', [
			rt.call_function('__', [
				rt.new_string('Display name cannot be changed to email address due to privacy concern.'),
				rt.new_string('woocommerce'),
			]),
			rt.new_string('error'),
		])
	}
	mut var_required_fields := rt.call_function('apply_filters', [
		rt.new_string('woocommerce_save_account_details_required_fields'),
		rt.create_array([
			rt.ArrayItem{ key: 'account_first_name', val: rt.call_function('__', [
				rt.new_string('First name'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'account_last_name', val: rt.call_function('__', [
				rt.new_string('Last name'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'account_display_name', val: rt.call_function('__', [
				rt.new_string('Display name'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'account_email', val: rt.call_function('__', [
				rt.new_string('Email address'),
				rt.new_string('woocommerce'),
			]) },
		]),
	])
	mut iter_3 := var_required_fields.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_field_name := item_3.val
		mut var_field_key := item_3.key
		if !rt.is_true(rt.get_superglobal('_POST').array_get(var_field_key)) {
			rt.call_function('wc_add_notice', [
				rt.call_function('sprintf', [
					rt.call_function('__', [rt.new_string('%s is a required field.'),
						rt.new_string('woocommerce')]),
					rt.new_string('<strong>' +
						(rt.call_function('esc_html', [var_field_name.clone()])).str() + '</strong>'),
				]),
				rt.new_string('error'),
				rt.create_array([
					rt.ArrayItem{ key: 'id', val: var_field_key },
				]),
			])
		}
	}
	if rt.is_true(var_account_email) {
		var_account_email = rt.call_function('sanitize_email', [
			var_account_email.clone()])
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_email', [
			var_account_email.clone()])))))
		{
			rt.call_function('wc_add_notice', [
				rt.call_function('__', [
					rt.new_string('Please provide a valid email address.'),
					rt.new_string('woocommerce'),
				]),
				rt.new_string('error'),
			])
		} else if rt.is_true(rt.call_function('email_exists', [var_account_email.clone()]))
			&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_account_email, rt.get_property(var_current_user, 'user_email'))))) {
			rt.call_function('wc_add_notice', [
				rt.call_function('__', [
					rt.new_string('This email address is already registered.'),
					rt.new_string('woocommerce'),
				]),
				rt.new_string('error'),
			])
		}
		rt.set_property(var_user, 'user_email', var_account_email.clone())
	}
	if !(!rt.is_true(var_pass_cur)) && !rt.is_true(var_pass1) && !rt.is_true(var_pass2) {
		rt.call_function('wc_add_notice', [
			rt.call_function('__', [
				rt.new_string('Please fill out all password fields.'),
				rt.new_string('woocommerce'),
			]),
			rt.new_string('error'),
		])
		var_save_pass = rt.new_bool(false)
	} else if !(!rt.is_true(var_pass1)) && !rt.is_true(var_pass_cur) {
		rt.call_function('wc_add_notice', [
			rt.call_function('__', [rt.new_string('Please enter your current password.'),
				rt.new_string('woocommerce')]),
			rt.new_string('error'),
		])
		var_save_pass = rt.new_bool(false)
	} else if !(!rt.is_true(var_pass1)) && !rt.is_true(var_pass2) {
		rt.call_function('wc_add_notice', [
			rt.call_function('__', [rt.new_string('Please re-enter your password.'),
				rt.new_string('woocommerce')]),
			rt.new_string('error'),
		])
		var_save_pass = rt.new_bool(false)
	} else if !(!rt.is_true(var_pass1)) || !(!rt.is_true(var_pass2))
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_pass1, var_pass2)))) {
		rt.call_function('wc_add_notice', [
			rt.call_function('__', [rt.new_string('New passwords do not match.'),
				rt.new_string('woocommerce')]),
			rt.new_string('error'),
		])
		var_save_pass = rt.new_bool(false)
	} else if !(!rt.is_true(var_pass1))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_check_password', [var_pass_cur.clone(), rt.get_property(var_current_user, 'user_pass'), rt.get_property(var_current_user, 'ID')]))))) {
		rt.call_function('wc_add_notice', [
			rt.call_function('__', [rt.new_string('Your current password is incorrect.'),
				rt.new_string('woocommerce')]),
			rt.new_string('error'),
		])
		var_save_pass = rt.new_bool(false)
	}
	if rt.is_true(var_pass1) && rt.is_true(var_save_pass) {
		rt.set_property(var_user, 'user_pass', var_pass1.clone())
	}
	mut var_errors := create_wp_error()
	rt.call_function('do_action_ref_array', [
		rt.new_string('woocommerce_save_account_details_errors'),
		rt.create_array([rt.ArrayItem{ key: none, val: var_errors },
			rt.ArrayItem{ key: none, val: var_user }]),
	])
	if rt.is_true(var_errors.get_error_messages()) {
		mut iter_4 := var_errors.get_error_messages().iterator()
		for {
			item_4 := iter_4.next() or { break }
			mut var_error := item_4.val
			rt.call_function('wc_add_notice', [var_error.clone(),
				rt.new_string('error')])
		}
	}
	if rt.is_true(rt.identical(rt.call_function('wc_notice_count', [
		rt.new_string('error'),
	]), rt.new_int(0)))
	{
		rt.call_function('wp_update_user', [var_user.clone()])
		mut var_customer := create_wc_customer(rt.get_property(var_user, 'ID'))
		if rt.has_exception() {
			unsafe {
				goto catch_label_2
			}
		}
		if !(rt.get_property(var_user, 'user_email')).is_null()
			&& rt.is_true(rt.call_function('is_email', [rt.get_property(var_user, 'user_email')]))
			&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_current_email, rt.get_property(var_user, 'user_email'))))) {
			var_customer.set_billing_email(rt.get_property(var_user, 'user_email'))
			if rt.has_exception() {
				unsafe {
					goto catch_label_2
				}
			}
		}
		if rt.has_exception() {
			unsafe {
				goto catch_label_2
			}
		}
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_current_first_name, rt.get_property(var_user,
			'first_name')))))
		{
			var_customer.set_billing_first_name(rt.get_property(var_user, 'first_name'))
			if rt.has_exception() {
				unsafe {
					goto catch_label_2
				}
			}
		}
		if rt.has_exception() {
			unsafe {
				goto catch_label_2
			}
		}
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_current_last_name, rt.get_property(var_user,
			'last_name')))))
		{
			var_customer.set_billing_last_name(rt.get_property(var_user, 'last_name'))
			if rt.has_exception() {
				unsafe {
					goto catch_label_2
				}
			}
		}
		if rt.has_exception() {
			unsafe {
				goto catch_label_2
			}
		}
		var_customer.save()
		if rt.has_exception() {
			unsafe {
				goto catch_label_2
			}
		}
		unsafe {
			goto end_label_2
		}
		catch_label_2:
		mut var_e_2 := rt.get_and_clear_exception()
		if rt.instance_of(var_e_2, 'WC_Data_Exception') {
			mut var_e := var_e_2.clone()
			rt.call_function('wc_add_notice', [
				rt.call_method(var_e, 'getMessage', []rt.PhpVal{}),
				rt.new_string('error'),
			])
			unsafe {
				goto end_label_2
			}
		} else if rt.instance_of(var_e_2, 'Exception') {
			var_e = var_e_2.clone()
			rt.call_function('wc_add_notice', [
				rt.call_function('sprintf', [
					rt.call_function('__', [
						rt.new_string('An error occurred while saving account details: %s'),
						rt.new_string('woocommerce'),
					]),
					rt.call_function('esc_html', [
						rt.call_method(var_e, 'getMessage', []rt.PhpVal{}),
					]),
				]),
				rt.new_string('error'),
			])
			unsafe {
				goto end_label_2
			}
		} else {
			rt.throw_exception(var_e_2)
			unsafe {
				goto end_label_2
			}
		}

		end_label_2:
		rt.call_function('do_action', [rt.new_string('woocommerce_save_account_details'),
			rt.get_property(var_user, 'ID')])
		if rt.is_true(rt.identical(rt.new_int(0), rt.call_function('wc_notice_count', [
			rt.new_string('error'),
		])))
		{
			rt.call_function('wc_add_notice', [
				rt.call_function('__', [
					rt.new_string('Account details changed successfully.'),
					rt.new_string('woocommerce'),
				]),
			])
			rt.call_function('wp_safe_redirect', [
				rt.call_function('wc_get_endpoint_url', [rt.new_string('edit-account'),
					rt.new_string(''),
					rt.call_function('wc_get_page_permalink', [
						rt.new_string('myaccount'),
					])]),
			])
			exit(0)
		}
	}
}

fn Class_WC_Form_Handler.checkout_action() {
	if rt.get_superglobal('_POST').array_isset(rt.new_string('woocommerce_checkout_place_order'))
		|| rt.get_superglobal('_POST').array_isset(rt.new_string('woocommerce_checkout_update_totals')) {
		rt.call_function('wc_nocache_headers', []rt.PhpVal{})
		if rt.is_true(rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'cart'),
			'is_empty', []rt.PhpVal{}))
		{
			rt.call_function('wp_safe_redirect', [
				rt.call_function('wc_get_cart_url', []rt.PhpVal{}),
			])
			exit(0)
		}
		rt.call_function('wc_maybe_define_constant', [
			rt.new_string('WOOCOMMERCE_CHECKOUT'),
			rt.new_bool(true),
		])
		rt.call_method(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'checkout',
			[]rt.PhpVal{}), 'process_checkout', []rt.PhpVal{})
	}
}

fn Class_WC_Form_Handler.pay_action() {
	mut var_wp := rt.new_null()
	if rt.get_superglobal('_POST').array_isset(rt.new_string('woocommerce_pay'))
		&& rt.get_superglobal('_GET').array_isset(rt.new_string('key')) {
		rt.call_function('wc_nocache_headers', []rt.PhpVal{})
		mut var_nonce_value := rt.call_function('wc_get_var', [
			rt.get_superglobal('_REQUEST').array_get(rt.new_string('woocommerce-pay-nonce')),
			rt.call_function('wc_get_var', [rt.get_superglobal('_REQUEST').array_get(rt.new_string('_wpnonce')),
				rt.new_string('')]),
		])
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_verify_nonce', [
			var_nonce_value.clone(),
			rt.new_string('woocommerce-pay'),
		])))))
		{
			return
		}
		rt.call_function('ob_start', []rt.PhpVal{})
		mut var_order_key := rt.call_function('wp_unslash', [
			rt.get_superglobal('_GET').array_get(rt.new_string('key')),
		])
		mut var_order_id := rt.call_function('absint', [
			rt.get_property(var_wp, 'query_vars').array_get(rt.new_string('order-pay')),
		])
		mut var_order := rt.call_function('wc_get_order', [var_order_id.clone()])
		if rt.is_true(rt.identical(var_order_id, rt.call_method(var_order, 'get_id', []rt.PhpVal{})))
			&& rt.is_true(rt.call_function('hash_equals', [rt.call_method(var_order, 'get_order_key', []rt.PhpVal{}), var_order_key.clone()]))
			&& rt.is_true(rt.call_method(var_order, 'needs_payment', []rt.PhpVal{})) {
			rt.call_function('do_action', [
				rt.new_string('woocommerce_before_pay_action'),
				var_order.clone(),
			])
			rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'customer'),
				'set_props', [
				rt.create_array([
					rt.ArrayItem{
						key: 'billing_country'
						val: if rt.is_true(rt.call_method(var_order, 'get_billing_country',
							[]rt.PhpVal{}))
						{
							rt.call_method(var_order, 'get_billing_country', []rt.PhpVal{})
						} else {
							rt.new_null()
						}
					},
					rt.ArrayItem{
						key: 'billing_state'
						val: if rt.is_true(rt.call_method(var_order, 'get_billing_state',
							[]rt.PhpVal{}))
						{
							rt.call_method(var_order, 'get_billing_state', []rt.PhpVal{})
						} else {
							rt.new_null()
						}
					},
					rt.ArrayItem{
						key: 'billing_postcode'
						val: if rt.is_true(rt.call_method(var_order, 'get_billing_postcode',
							[]rt.PhpVal{}))
						{
							rt.call_method(var_order, 'get_billing_postcode', []rt.PhpVal{})
						} else {
							rt.new_null()
						}
					},
					rt.ArrayItem{
						key: 'billing_city'
						val: if rt.is_true(rt.call_method(var_order, 'get_billing_city',
							[]rt.PhpVal{}))
						{
							rt.call_method(var_order, 'get_billing_city', []rt.PhpVal{})
						} else {
							rt.new_null()
						}
					},
				]),
			])
			rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'customer'),
				'save', []rt.PhpVal{})
			if !(!rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('terms-field'))))
				&& !rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('terms'))) {
				rt.call_function('wc_add_notice', [
					rt.call_function('__', [
						rt.new_string('Please read and accept the terms and conditions to proceed with your order.'),
						rt.new_string('woocommerce'),
					]),
					rt.new_string('error'),
				])
				return
			}
			if rt.is_true(rt.call_method(var_order, 'needs_payment', []rt.PhpVal{})) {
				mut var_payment_method_id := if rt.get_superglobal('_POST').array_isset(rt.new_string('payment_method')) { rt.call_function('wc_clean', [
						rt.call_function('wp_unslash', [
							rt.get_superglobal('_POST').array_get(rt.new_string('payment_method')),
						]),
					]) } else { rt.new_bool(false) }
				if rt.has_exception() {
					unsafe {
						goto catch_label_3
					}
				}
				if rt.is_true(rt.new_bool(!(rt.is_true(var_payment_method_id)))) {
					rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.call_function('__', [
						rt.new_string('Invalid payment method.'),
						rt.new_string('woocommerce'),
					]))))
					if rt.has_exception() {
						unsafe {
							goto catch_label_3
						}
					}
				}
				if rt.has_exception() {
					unsafe {
						goto catch_label_3
					}
				}
				mut var_available_gateways := rt.call_method(rt.get_property(rt.call_function('WC',
					[]rt.PhpVal{}), 'payment_gateways'), 'get_available_payment_gateways',
					[]rt.PhpVal{})
				if rt.has_exception() {
					unsafe {
						goto catch_label_3
					}
				}
				mut var_payment_method := if var_available_gateways.array_isset(var_payment_method_id) {
					var_available_gateways.array_get(var_payment_method_id)
				} else {
					rt.new_bool(false)
				}
				if rt.has_exception() {
					unsafe {
						goto catch_label_3
					}
				}
				if rt.is_true(rt.new_bool(!(rt.is_true(var_payment_method)))) {
					rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.call_function('__', [
						rt.new_string('Invalid payment method.'),
						rt.new_string('woocommerce'),
					]))))
					if rt.has_exception() {
						unsafe {
							goto catch_label_3
						}
					}
				}
				if rt.has_exception() {
					unsafe {
						goto catch_label_3
					}
				}
				rt.call_method(var_order, 'set_payment_method', [
					var_payment_method.clone()])
				if rt.has_exception() {
					unsafe {
						goto catch_label_3
					}
				}
				rt.call_method(var_order, 'save', []rt.PhpVal{})
				if rt.has_exception() {
					unsafe {
						goto catch_label_3
					}
				}
				rt.call_method(var_payment_method, 'validate_fields', []rt.PhpVal{})
				if rt.has_exception() {
					unsafe {
						goto catch_label_3
					}
				}
				if rt.is_true(rt.identical(rt.new_int(0), rt.call_function('wc_notice_count', [
					rt.new_string('error'),
				])))
				{
					mut var_result := rt.call_method(var_payment_method, 'process_payment', [
						var_order_id.clone(),
					])
					if rt.has_exception() {
						unsafe {
							goto catch_label_3
						}
					}
					if var_result.array_isset(rt.new_string('result'))
						&& rt.is_true(rt.identical(rt.new_string('success'), var_result.array_get(rt.new_string('result')))) {
						var_result.array_set('order_id', var_order_id.clone())
						if rt.has_exception() {
							unsafe {
								goto catch_label_3
							}
						}
						var_result = rt.call_function('apply_filters', [
							rt.new_string('woocommerce_payment_successful_result'),
							var_result.clone(),
							var_order_id.clone(),
						])
						if rt.has_exception() {
							unsafe {
								goto catch_label_3
							}
						}
						rt.call_function('wp_redirect', [
							var_result.array_get(rt.new_string('redirect')),
						])
						if rt.has_exception() {
							unsafe {
								goto catch_label_3
							}
						}
						exit(0)
						if rt.has_exception() {
							unsafe {
								goto catch_label_3
							}
						}
					}
					if rt.has_exception() {
						unsafe {
							goto catch_label_3
						}
					}
				}
				if rt.has_exception() {
					unsafe {
						goto catch_label_3
					}
				}
				unsafe {
					goto end_label_3
				}
				catch_label_3:
				mut var_e_3 := rt.get_and_clear_exception()
				if rt.instance_of(var_e_3, 'Exception') {
					mut var_e := var_e_3.clone()
					rt.call_function('wc_add_notice', [
						rt.call_method(var_e, 'getMessage', []rt.PhpVal{}),
						rt.new_string('error'),
					])
					unsafe {
						goto end_label_3
					}
				} else {
					rt.throw_exception(var_e_3)
					unsafe {
						goto end_label_3
					}
				}

				end_label_3:
			} else {
				rt.call_method(var_order, 'payment_complete', []rt.PhpVal{})
				rt.call_function('wp_safe_redirect', [
					rt.call_method(var_order, 'get_checkout_order_received_url', []rt.PhpVal{}),
				])
				exit(0)
			}
			rt.call_function('do_action', [rt.new_string('woocommerce_after_pay_action'),
				var_order.clone()])
		}
	}
}

fn Class_WC_Form_Handler.add_payment_method_action() {
	if rt.get_superglobal('_POST').array_isset(rt.new_string('woocommerce_add_payment_method'))
		&& rt.get_superglobal('_POST').array_isset(rt.new_string('payment_method')) {
		rt.call_function('wc_nocache_headers', []rt.PhpVal{})
		mut var_nonce_value := rt.call_function('wc_get_var', [
			rt.get_superglobal('_REQUEST').array_get(rt.new_string('woocommerce-add-payment-method-nonce')),
			rt.call_function('wc_get_var', [rt.get_superglobal('_REQUEST').array_get(rt.new_string('_wpnonce')),
				rt.new_string('')]),
		])
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_verify_nonce', [
			var_nonce_value.clone(),
			rt.new_string('woocommerce-add-payment-method'),
		])))))
		{
			return
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('apply_filters', [
			rt.new_string('woocommerce_add_payment_method_form_is_valid'),
			rt.new_bool(true),
		])))))
		{
			return
		}
		mut var_current_user_id := rt.call_function('get_current_user_id', []rt.PhpVal{})
		mut var_rate_limit_id := rt.new_string('add_payment_method_' + var_current_user_id.str())
		mut var_delay := rt.new_int((rt.call_function('apply_filters', [
			rt.new_string('woocommerce_payment_gateway_add_payment_method_delay'),
			rt.new_int(20),
		])).to_i64())
		mut iife_temp_3 := Class_WC_Rate_Limiter{}
		mut iife_result_3 := iife_temp_3.retried_too_soon(var_rate_limit_id.clone())
		if rt.is_true(iife_result_3) {
			rt.call_function('wc_add_notice', [
				rt.call_function('sprintf', [
					rt.call_function('_n', [
						rt.new_string('You cannot add a new payment method so soon after the previous one. Please wait for %d second.'),
						rt.new_string('You cannot add a new payment method so soon after the previous one. Please wait for %d seconds.'),
						var_delay.clone(),
						rt.new_string('woocommerce'),
					]),
					var_delay.clone(),
				]),
				rt.new_string('error'),
			])
			return
		}
		mut iife_temp_4 := Class_WC_Rate_Limiter{}
		mut iife_result_4 := iife_temp_4.set_rate_limit(var_rate_limit_id.clone(),
			var_delay.clone())
		rt.call_function('ob_start', []rt.PhpVal{})
		mut var_payment_method_id := rt.call_function('wc_clean', [
			rt.call_function('wp_unslash', [
				rt.get_superglobal('_POST').array_get(rt.new_string('payment_method')),
			]),
		])
		mut var_available_gateways := rt.call_method(rt.get_property(rt.call_function('WC',
			[]rt.PhpVal{}), 'payment_gateways'), 'get_available_payment_gateways', []rt.PhpVal{})
		if var_available_gateways.array_isset(var_payment_method_id) {
			mut var_gateway := var_available_gateways.array_get(var_payment_method_id)
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_gateway, 'supports', [Class_Automattic_WooCommerce_Enums_PaymentGatewayFeature.add_payment_method()])))))
				&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_gateway, 'supports', [Class_Automattic_WooCommerce_Enums_PaymentGatewayFeature.tokenization()]))))) {
				rt.call_function('wc_add_notice', [
					rt.call_function('__', [rt.new_string('Invalid payment gateway.'),
						rt.new_string('woocommerce')]),
					rt.new_string('error'),
				])
				return
			}
			rt.call_method(var_gateway, 'validate_fields', []rt.PhpVal{})
			if rt.is_true(rt.greater(rt.call_function('wc_notice_count', [
				rt.new_string('error'),
			]), rt.new_int(0)))
			{
				return
			}
			mut var_result := rt.call_method(var_gateway, 'add_payment_method', []rt.PhpVal{})
			if rt.is_true(rt.identical(rt.new_string('success'),
				var_result.array_get(rt.new_string('result'))))
			{
				rt.call_function('wc_add_notice', [
					rt.call_function('__', [
						rt.new_string('Payment method successfully added.'),
						rt.new_string('woocommerce'),
					]),
				])
			}
			if rt.is_true(rt.identical(rt.new_string('failure'),
				var_result.array_get(rt.new_string('result'))))
			{
				rt.call_function('wc_add_notice', [
					rt.call_function('__', [
						rt.new_string('Unable to add payment method to your account.'),
						rt.new_string('woocommerce'),
					]),
					rt.new_string('error'),
				])
			}
			if !(!rt.is_true(var_result.array_get(rt.new_string('redirect')))) {
				rt.call_function('wp_redirect', [var_result.array_get(rt.new_string('redirect'))])
				exit(0)
			}
		}
	}
}

fn Class_WC_Form_Handler.delete_payment_method_action() {
	mut var_wp := rt.new_null()
	if rt.get_property(var_wp, 'query_vars').array_isset(rt.new_string('delete-payment-method')) {
		rt.call_function('wc_nocache_headers', []rt.PhpVal{})
		mut var_token_id := rt.call_function('absint', [
			rt.get_property(var_wp, 'query_vars').array_get(rt.new_string('delete-payment-method')),
		])
		mut iife_temp_5 := Class_WC_Payment_Tokens{}
		mut iife_result_5 := iife_temp_5.get(var_token_id.clone())
		mut var_token := iife_result_5
		if var_token.clone().is_null()
			|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('get_current_user_id', []rt.PhpVal{}), rt.call_method(var_token, 'get_user_id', []rt.PhpVal{})))))
			|| !(rt.get_superglobal('_REQUEST').array_isset(rt.new_string('_wpnonce')))
			|| rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('wp_verify_nonce', [rt.call_function('wp_unslash', [rt.get_superglobal('_REQUEST').array_get(rt.new_string('_wpnonce'))]), rt.new_string('delete-payment-method-' + var_token_id.str())]))) {
			rt.call_function('wc_add_notice', [
				rt.call_function('__', [rt.new_string('Invalid payment method.'),
					rt.new_string('woocommerce')]),
				rt.new_string('error'),
			])
		} else {
			mut iife_temp_6 := Class_WC_Payment_Tokens{}
			mut iife_result_6 := iife_temp_6.delete(var_token_id.clone())
			rt.call_function('wc_add_notice', [
				rt.call_function('__', [rt.new_string('Payment method deleted.'),
					rt.new_string('woocommerce')]),
			])
		}
		rt.call_function('wp_safe_redirect', [
			rt.call_function('wc_get_account_endpoint_url', [
				rt.new_string('payment-methods'),
			]),
		])
		exit(0)
	}
}

fn Class_WC_Form_Handler.set_default_payment_method_action() {
	mut var_wp := rt.new_null()
	if rt.get_property(var_wp, 'query_vars').array_isset(rt.new_string('set-default-payment-method')) {
		rt.call_function('wc_nocache_headers', []rt.PhpVal{})
		mut var_token_id := rt.call_function('absint', [
			rt.get_property(var_wp, 'query_vars').array_get(rt.new_string('set-default-payment-method')),
		])
		mut iife_temp_7 := Class_WC_Payment_Tokens{}
		mut iife_result_7 := iife_temp_7.get(var_token_id.clone())
		mut var_token := iife_result_7
		if var_token.clone().is_null()
			|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('get_current_user_id', []rt.PhpVal{}), rt.call_method(var_token, 'get_user_id', []rt.PhpVal{})))))
			|| !(rt.get_superglobal('_REQUEST').array_isset(rt.new_string('_wpnonce')))
			|| rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('wp_verify_nonce', [rt.call_function('wp_unslash', [rt.get_superglobal('_REQUEST').array_get(rt.new_string('_wpnonce'))]), rt.new_string('set-default-payment-method-' + var_token_id.str())]))) {
			rt.call_function('wc_add_notice', [
				rt.call_function('__', [rt.new_string('Invalid payment method.'),
					rt.new_string('woocommerce')]),
				rt.new_string('error'),
			])
		} else {
			mut iife_temp_8 := Class_WC_Payment_Tokens{}
			mut iife_result_8 := iife_temp_8.set_users_default(rt.call_method(var_token,
				'get_user_id', []rt.PhpVal{}), rt.new_int(var_token_id.clone().to_i64()))
			rt.call_function('wc_add_notice', [
				rt.call_function('__', [
					rt.new_string('This payment method was successfully set as your default.'),
					rt.new_string('woocommerce'),
				]),
			])
		}
		rt.call_function('wp_safe_redirect', [
			rt.call_function('wc_get_account_endpoint_url', [
				rt.new_string('payment-methods'),
			]),
		])
		exit(0)
	}
}

fn Class_WC_Form_Handler.update_cart_action() {
	if !(rt.get_superglobal('_REQUEST').array_isset(rt.new_string('apply_coupon'))
		|| rt.get_superglobal('_REQUEST').array_isset(rt.new_string('remove_coupon'))
		|| rt.get_superglobal('_REQUEST').array_isset(rt.new_string('remove_item'))
		|| rt.get_superglobal('_REQUEST').array_isset(rt.new_string('undo_item'))
		|| rt.get_superglobal('_REQUEST').array_isset(rt.new_string('update_cart'))
		|| rt.get_superglobal('_REQUEST').array_isset(rt.new_string('proceed'))) {
		return
	}
	rt.call_function('wc_maybe_define_constant', [rt.new_string('WOOCOMMERCE_CART'),
		rt.new_bool(true)])
	rt.call_function('wc_nocache_headers', []rt.PhpVal{})
	mut var_nonce_value := rt.call_function('wc_get_var', [
		rt.get_superglobal('_REQUEST').array_get(rt.new_string('woocommerce-cart-nonce')),
		rt.call_function('wc_get_var', [rt.get_superglobal('_REQUEST').array_get(rt.new_string('_wpnonce')),
			rt.new_string('')]),
	])
	if !(!rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('apply_coupon'))))
		&& !(!rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('coupon_code')))) {
		rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'cart'),
			'add_discount', [
			rt.call_function('wc_format_coupon_code', [
				rt.call_function('wp_unslash', [
					rt.get_superglobal('_POST').array_get(rt.new_string('coupon_code')),
				]),
			]),
		])
	} else if rt.get_superglobal('_GET').array_isset(rt.new_string('remove_coupon')) {
		rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'cart'),
			'remove_coupon', [
			rt.call_function('wc_format_coupon_code', [
				rt.call_function('urldecode', [
					rt.call_function('wp_unslash', [
						rt.get_superglobal('_GET').array_get(rt.new_string('remove_coupon')),
					]),
				]),
			]),
		])
	} else if !(!rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('remove_item'))))
		&& rt.is_true(rt.call_function('wp_verify_nonce', [var_nonce_value.clone(), rt.new_string('woocommerce-cart')])) {
		mut var_cart_item_key := rt.call_function('sanitize_text_field', [
			rt.call_function('wp_unslash',
				[rt.get_superglobal('_GET').array_get(rt.new_string('remove_item'))]),
		])
		mut var_cart_item := rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}),
			'cart'), 'get_cart_item', [var_cart_item_key.clone()])
		if rt.is_true(var_cart_item) {
			mut var_removed := rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}),
				'cart'), 'remove_cart_item', [var_cart_item_key.clone()])
			if rt.is_true(var_removed) {
				rt.call_function('do_action', [
					rt.new_string('internal_woocommerce_cart_item_removed_from_user_request'),
					var_cart_item_key.clone(),
					rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'cart'),
				])
			}
			mut var_product := rt.call_function('wc_get_product', [
				var_cart_item.array_get(rt.new_string('product_id')),
			])
			mut var_item_removed_title := rt.call_function('apply_filters', [
				rt.new_string('woocommerce_cart_item_removed_title'),
				if rt.is_true(var_product) { rt.call_function('sprintf', [
						rt.call_function('_x', [rt.new_string('&ldquo;%s&rdquo;'),
							rt.new_string('Item name in quotes'),
							rt.new_string('woocommerce')]),
						rt.call_method(var_product, 'get_name', []rt.PhpVal{}),
					]) } else { rt.call_function('__', [
						rt.new_string('Item'),
						rt.new_string('woocommerce'),
					]) },
				var_cart_item.clone(),
			])
			if rt.is_true(var_product)
				&& rt.is_true(rt.call_method(var_product, 'is_in_stock', []rt.PhpVal{}))
				&& rt.is_true(rt.call_method(var_product, 'has_enough_stock', [var_cart_item.array_get(rt.new_string('quantity'))])) {
				mut var_removed_notice := rt.call_function('sprintf', [
					rt.call_function('__', [rt.new_string('%s removed.'),
						rt.new_string('woocommerce')]),
					var_item_removed_title.clone(),
				])
				var_removed_notice = rt.concat(var_removed_notice, rt.new_string(' <a href="' +
					(rt.call_function('esc_url', [rt.call_function('wc_get_cart_undo_url', [var_cart_item_key.clone()])])).str() +
					'" class="restore-item">' +
					(rt.call_function('__', [rt.new_string('Undo?'), rt.new_string('woocommerce')])).str() +
					'</a>'))
			} else {
				var_removed_notice = rt.call_function('sprintf', [
					rt.call_function('__', [rt.new_string('%s removed.'),
						rt.new_string('woocommerce')]),
					var_item_removed_title.clone(),
				])
			}
			rt.call_function('wc_add_notice', [var_removed_notice.clone(),
				rt.call_function('apply_filters', [
					rt.new_string('woocommerce_cart_item_removed_notice_type'),
					rt.new_string('success'),
				])])
		}
		if rt.is_true(rt.call_function('wp_get_referer', []rt.PhpVal{})) {
			rt.call_function('wp_safe_redirect', [
				rt.call_function('remove_query_arg', [
					rt.create_array([rt.ArrayItem{ key: none, val: 'remove_item' },
						rt.ArrayItem{ key: none, val: 'add-to-cart' },
						rt.ArrayItem{ key: none, val: 'added-to-cart' },
						rt.ArrayItem{ key: none, val: 'order_again' },
						rt.ArrayItem{ key: none, val: '_wpnonce' }]),
					rt.call_function('add_query_arg', [rt.new_string('removed_item'),
						rt.new_string('1'), rt.call_function('wp_get_referer', []rt.PhpVal{})]),
				]),
			])
			exit(0)
		}
	} else if !(!rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('undo_item'))))
		&& rt.get_superglobal('_GET').array_isset(rt.new_string('_wpnonce'))
		&& rt.is_true(rt.call_function('wp_verify_nonce', [var_nonce_value.clone(), rt.new_string('woocommerce-cart')])) {
		var_cart_item_key = rt.call_function('sanitize_text_field', [
			rt.call_function('wp_unslash',
				[rt.get_superglobal('_GET').array_get(rt.new_string('undo_item'))]),
		])
		rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'cart'),
			'restore_cart_item', [var_cart_item_key.clone()])
		if rt.is_true(rt.call_function('wp_get_referer', []rt.PhpVal{})) {
			rt.call_function('wp_safe_redirect', [
				rt.call_function('remove_query_arg', [
					rt.create_array([rt.ArrayItem{ key: none, val: 'undo_item' },
						rt.ArrayItem{ key: none, val: '_wpnonce' }]),
					rt.call_function('wp_get_referer', []rt.PhpVal{}),
				]),
			])
			exit(0)
		}
	}
	if !(!rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('apply_coupon'))))
		|| !(!rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('update_cart'))))
		|| !(!rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('proceed'))))
		&& rt.is_true(rt.call_function('wp_verify_nonce', [var_nonce_value.clone(), rt.new_string('woocommerce-cart')])) {
		mut var_cart_updated := rt.new_bool(false)
		mut var_cart_totals := if rt.get_superglobal('_POST').array_isset(rt.new_string('cart')) { rt.call_function('wp_unslash', [
				rt.get_superglobal('_POST').array_get(rt.new_string('cart')),
			]) } else { rt.new_string('') }
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'cart'), 'is_empty', []rt.PhpVal{})))))
			&& var_cart_totals.clone().is_array() {
			mut iter_5 := rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}),
				'cart'), 'get_cart', []rt.PhpVal{}).iterator()
			for {
				item_5 := iter_5.next() or { break }
				mut var_values := item_5.val
				mut var_cart_item_key_shadow := item_5.key
				mut var__product := var_values.array_get(rt.new_string('data'))
				if !(var_cart_totals.array_isset(var_cart_item_key_shadow))
					|| !(var_cart_totals.array_get(var_cart_item_key_shadow).array_isset(rt.new_string('qty'))) {
					continue
				}
				mut var_quantity := rt.call_function('apply_filters', [
					rt.new_string('woocommerce_stock_amount_cart_item'),
					rt.call_function('wc_stock_amount', [
						rt.call_function('preg_replace', [rt.new_string('/[^0-9\\.]/'),
							rt.new_string(''), var_cart_totals.array_get(var_cart_item_key_shadow).array_get(rt.new_string('qty'))]),
					]),
					var_cart_item_key_shadow.clone(),
				])
				if rt.is_true(rt.identical(rt.new_string(''), var_quantity))
					|| rt.is_true(rt.identical(var_quantity, var_values.array_get(rt.new_string('quantity')))) {
					continue
				}
				mut var_passed_validation := rt.call_function('apply_filters', [
					rt.new_string('woocommerce_update_cart_validation'),
					rt.new_bool(true),
					var_cart_item_key_shadow.clone(),
					var_values.clone(),
					var_quantity.clone(),
				])
				if rt.is_true(rt.call_method(var__product, 'is_sold_individually', []rt.PhpVal{}))
					&& rt.is_true(rt.greater(var_quantity, rt.new_int(1))) {
					rt.call_function('wc_add_notice', [
						rt.call_function('sprintf', [
							rt.call_function('__', [
								rt.new_string('You can only have 1 %s in your cart.'),
								rt.new_string('woocommerce'),
							]),
							rt.call_method(var__product, 'get_name', []rt.PhpVal{}),
						]),
						rt.new_string('error'),
					])
					var_passed_validation = rt.new_bool(false)
				}
				if rt.is_true(var_passed_validation) {
					mut var_old_quantity := var_values.array_get(rt.new_string('quantity'))
					rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'cart'),
						'set_quantity', [var_cart_item_key_shadow.clone(),
						var_quantity.clone(), rt.new_bool(false)])
					var_cart_updated = rt.new_bool(true)
					rt.call_function('do_action', [
						rt.new_string('internal_woocommerce_cart_item_updated_from_user_request'),
						var_cart_item_key_shadow.clone(),
						var_quantity.clone(),
						var_old_quantity.clone(),
						rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'cart'),
					])
				}
			}
		}
		var_cart_updated = rt.call_function('apply_filters', [
			rt.new_string('woocommerce_update_cart_action_cart_updated'),
			var_cart_updated.clone(),
		])
		if rt.is_true(var_cart_updated) {
			rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'cart'),
				'calculate_totals', []rt.PhpVal{})
		}
		if !(!rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('proceed')))) {
			rt.call_function('wp_safe_redirect', [
				rt.call_function('wc_get_checkout_url', []rt.PhpVal{}),
			])
			exit(0)
		} else if rt.is_true(var_cart_updated) {
			rt.call_function('wc_add_notice', [
				rt.call_function('__', [rt.new_string('Cart updated.'),
					rt.new_string('woocommerce')]),
				rt.call_function('apply_filters', [
					rt.new_string('woocommerce_cart_updated_notice_type'),
					rt.new_string('success'),
				]),
			])
			if rt.is_true(rt.call_function('wp_get_referer', []rt.PhpVal{})) {
				rt.call_function('wp_safe_redirect', [
					rt.call_function('remove_query_arg', [
						rt.create_array([rt.ArrayItem{ key: none, val: 'remove_coupon' },
							rt.ArrayItem{ key: none, val: 'add-to-cart' }]),
						rt.call_function('wp_get_referer', []rt.PhpVal{}),
					]),
				])
				exit(0)
			}
		}
	}
}

fn Class_WC_Form_Handler.order_again() {
	rt.call_function('wc_deprecated_function', [
		rt.new_string('WC_Form_Handler::order_again'),
		rt.new_string('3.5'),
		rt.new_string('This method should not be called manually.'),
	])
}

fn Class_WC_Form_Handler.cancel_order() {
	if rt.get_superglobal('_GET').array_isset(rt.new_string('cancel_order'))
		&& rt.get_superglobal('_GET').array_isset(rt.new_string('order'))
		&& rt.get_superglobal('_GET').array_isset(rt.new_string('order_id'))
		&& rt.get_superglobal('_GET').array_isset(rt.new_string('_wpnonce'))
		&& rt.is_true(rt.call_function('wp_verify_nonce', [rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get(rt.new_string('_wpnonce'))]), rt.new_string('woocommerce-cancel_order')])) {
		rt.call_function('wc_nocache_headers', []rt.PhpVal{})
		mut var_order_key := rt.call_function('wp_unslash', [
			rt.get_superglobal('_GET').array_get(rt.new_string('order')),
		])
		mut var_order_id := rt.call_function('absint', [
			rt.get_superglobal('_GET').array_get(rt.new_string('order_id')),
		])
		mut var_order := rt.call_function('wc_get_order', [var_order_id.clone()])
		mut var_valid_statuses := rt.call_function('apply_filters', [
			rt.new_string('woocommerce_valid_order_statuses_for_cancel'),
			rt.create_array([
				rt.ArrayItem{
					key: none
					val: Class_Automattic_WooCommerce_Enums_OrderStatus.pending()
				},
				rt.ArrayItem{
					key: none
					val: Class_Automattic_WooCommerce_Enums_OrderStatus.failed()
				},
			]),
			var_order.clone(),
		])
		mut var_user_can_cancel := rt.call_function('current_user_can', [
			rt.new_string('cancel_order'),
			var_order_id.clone(),
		])
		mut var_order_can_cancel := rt.call_method(var_order, 'has_status', [
			var_valid_statuses.clone()])
		mut var_redirect := if rt.get_superglobal('_GET').array_isset(rt.new_string('redirect')) { rt.call_function('wp_unslash', [
				rt.get_superglobal('_GET').array_get(rt.new_string('redirect')),
			]) } else { rt.new_string('') }
		if rt.is_true(var_user_can_cancel) && rt.is_true(var_order_can_cancel)
			&& rt.is_true(rt.identical(rt.call_method(var_order, 'get_id', []rt.PhpVal{}), var_order_id))
			&& rt.is_true(rt.call_function('hash_equals', [rt.call_method(var_order, 'get_order_key', []rt.PhpVal{}), var_order_key.clone()])) {
			rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'session'),
				'set', [rt.new_string('order_awaiting_payment'),
				rt.new_bool(false)])
			rt.call_method(var_order, 'update_status', [
				Class_Automattic_WooCommerce_Enums_OrderStatus.cancelled(),
				rt.call_function('__', [rt.new_string('Order cancelled by customer.'),
					rt.new_string('woocommerce')]),
			])
			rt.call_function('wc_add_notice', [
				rt.call_function('apply_filters', [
					rt.new_string('woocommerce_order_cancelled_notice'),
					rt.call_function('__', [rt.new_string('Your order was cancelled.'),
						rt.new_string('woocommerce')]),
				]),
				rt.call_function('apply_filters', [
					rt.new_string('woocommerce_order_cancelled_notice_type'),
					rt.new_string('notice'),
				]),
			])
			rt.call_function('do_action', [rt.new_string('woocommerce_cancelled_order'),
				rt.call_method(var_order, 'get_id', []rt.PhpVal{})])
		} else if rt.is_true(var_user_can_cancel)
			&& rt.is_true(rt.new_bool(!(rt.is_true(var_order_can_cancel)))) {
			rt.call_function('wc_add_notice', [
				rt.call_function('__', [
					rt.new_string('Your order can no longer be cancelled. Please contact us if you need assistance.'),
					rt.new_string('woocommerce'),
				]),
				rt.new_string('error'),
			])
		} else {
			rt.call_function('wc_add_notice', [
				rt.call_function('__', [rt.new_string('Invalid order.'),
					rt.new_string('woocommerce')]),
				rt.new_string('error'),
			])
		}
		if rt.is_true(var_redirect) {
			rt.call_function('wp_safe_redirect', [var_redirect.clone()])
			exit(0)
		}
	}
}

fn Class_WC_Form_Handler.add_to_cart_action(url bool) {
	mut url_mutated := url
	if !(rt.get_superglobal('_REQUEST').array_isset(rt.new_string('add-to-cart')))
		|| !(rt.call_function('wp_unslash', [rt.get_superglobal('_REQUEST').array_get(rt.new_string('add-to-cart'))]).is_long()
		|| rt.call_function('wp_unslash', [rt.get_superglobal('_REQUEST').array_get(rt.new_string('add-to-cart'))]).is_double()) {
		return
	}
	rt.call_function('wc_nocache_headers', []rt.PhpVal{})
	mut var_product_id := rt.call_function('apply_filters', [
		rt.new_string('woocommerce_add_to_cart_product_id'),
		rt.call_function('absint', [
			rt.call_function('wp_unslash',
				[rt.get_superglobal('_REQUEST').array_get(rt.new_string('add-to-cart'))]),
		]),
	])
	mut var_was_added_to_cart := rt.new_bool(false)
	mut var_adding_to_cart := rt.call_function('wc_get_product', [
		var_product_id.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_adding_to_cart)))) {
		return
	}
	mut var_add_to_cart_handler := rt.call_function('apply_filters', [
		rt.new_string('woocommerce_add_to_cart_handler'),
		rt.call_method(var_adding_to_cart, 'get_type', []rt.PhpVal{}),
		var_adding_to_cart.clone(),
	])
	if rt.is_true(rt.identical(Class_Automattic_WooCommerce_Enums_ProductType.variable(), var_add_to_cart_handler))
		|| rt.is_true(rt.identical(Class_Automattic_WooCommerce_Enums_ProductType.variation(), var_add_to_cart_handler)) {
		var_was_added_to_cart =
			Class_WC_Form_Handler.add_to_cart_handler_variable(var_product_id.clone())
		var_product_id = if !(!rt.is_true(rt.get_superglobal('_REQUEST').array_get(rt.new_string('variation_id')))) { rt.call_function('absint', [
				rt.call_function('wp_unslash', [
					rt.get_superglobal('_REQUEST').array_get(rt.new_string('variation_id')),
				]),
			]) } else { var_product_id }
	} else if rt.is_true(rt.identical(Class_Automattic_WooCommerce_Enums_ProductType.grouped(),
		var_add_to_cart_handler))
	{
		var_was_added_to_cart =
			Class_WC_Form_Handler.add_to_cart_handler_grouped(var_product_id.clone())
	} else if rt.is_true(rt.call_function('has_action', [
		rt.new_string('woocommerce_add_to_cart_handler_' + var_add_to_cart_handler.str()),
	]))
	{
		rt.call_function('do_action', [
			rt.new_string('woocommerce_add_to_cart_handler_' + var_add_to_cart_handler.str()),
			rt.new_bool(url_mutated).clone(),
		])
	} else {
		var_was_added_to_cart =
			Class_WC_Form_Handler.add_to_cart_handler_simple(var_product_id.clone())
	}
	if rt.is_true(var_was_added_to_cart)
		&& rt.is_true(rt.identical(rt.new_int(0), rt.call_function('wc_notice_count', [rt.new_string('error')]))) {
		mut var_quantity := if !rt.is_true(rt.get_superglobal('_REQUEST').array_get(rt.new_string('quantity'))) { rt.new_int(1) } else { rt.call_function('wc_stock_amount', [
				rt.call_function('wp_unslash', [rt.get_superglobal('_REQUEST').array_get(rt.new_string('quantity'))]),
			]) }
		rt.call_function('do_action', [
			rt.new_string('internal_woocommerce_cart_item_added_from_user_request'),
			var_product_id.clone(),
			var_quantity.clone(),
		])
		url_mutated = (rt.call_function('apply_filters', [
			rt.new_string('woocommerce_add_to_cart_redirect'),
			rt.new_bool(url_mutated).clone(),
			var_adding_to_cart.clone(),
		])).to_bool()
		if rt.is_true(rt.new_bool(url_mutated)) {
			rt.call_function('wp_safe_redirect', [rt.new_bool(url_mutated).clone()])
			exit(0)
		} else if rt.is_true(rt.identical(rt.new_string('yes'), rt.call_function('get_option', [
			rt.new_string('woocommerce_cart_redirect_after_add'),
		])))
		{
			rt.call_function('wp_safe_redirect', [
				rt.call_function('wc_get_cart_url', []rt.PhpVal{}),
			])
			exit(0)
		}
	}
}

fn Class_WC_Form_Handler.add_to_cart_handler_simple(var_product_id rt.PhpVal) bool {
	mut var_product_id_mutated := var_product_id
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.get_property(rt.call_function('WC', []rt.PhpVal{}),
		'cart')))))
	{
		rt.call_function('wc_doing_it_wrong', [rt.new_string(@FN),
			rt.new_string('Cart is not initialized.'), rt.new_string('10.5.0')])
		return false
	}
	mut var_quantity := if !rt.is_true(rt.get_superglobal('_REQUEST').array_get(rt.new_string('quantity'))) { rt.new_int(1) } else { rt.call_function('wc_stock_amount', [
			rt.call_function('wp_unslash', [rt.get_superglobal('_REQUEST').array_get(rt.new_string('quantity'))]),
		]) }
	mut var_passed_validation := rt.call_function('apply_filters', [
		rt.new_string('woocommerce_add_to_cart_validation'),
		rt.new_bool(true),
		var_product_id_mutated.clone(),
		var_quantity.clone(),
	])
	if rt.is_true(var_passed_validation)
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'cart'), 'add_to_cart', [var_product_id_mutated.clone(), var_quantity.clone()]))))) {
		rt.call_function('wc_add_to_cart_message', [
			rt.create_array([
				rt.ArrayItem{ key: var_product_id_mutated, val: var_quantity },
			]),
			rt.new_bool(true),
		])
		return true
	}
	return false
}

fn Class_WC_Form_Handler.add_to_cart_handler_grouped(var_product_id rt.PhpVal) bool {
	mut var_product_id_mutated := var_product_id
	mut var_was_added_to_cart := rt.new_bool(false)
	mut var_added_to_cart := rt.new_array()
	mut var_items := if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('quantity')) && rt.get_superglobal('_REQUEST').array_get(rt.new_string('quantity')).is_array() { rt.call_function('wp_unslash', [
			rt.get_superglobal('_REQUEST').array_get(rt.new_string('quantity')),
		]) } else { rt.new_array() }
	if !(!rt.is_true(var_items)) {
		mut var_quantity_set := rt.new_bool(false)
		mut iter_6 := var_items.iterator()
		for {
			item_6 := iter_6.next() or { break }
			mut var_quantity := item_6.val
			mut var_item := item_6.key
			var_quantity = rt.call_function('wc_stock_amount', [
				var_quantity.clone()])
			if rt.is_true(rt.less_equal(var_quantity, rt.new_int(0))) {
				continue
			}
			var_quantity_set = rt.new_bool(true)
			mut var_passed_validation := rt.call_function('apply_filters', [
				rt.new_string('woocommerce_add_to_cart_validation'),
				rt.new_bool(true),
				var_item.clone(),
				var_quantity.clone(),
			])
			rt.call_function('remove_action', [rt.new_string('woocommerce_add_to_cart'),
				rt.create_array([
					rt.ArrayItem{ key: none, val: rt.get_property(rt.call_function('WC',
						[]rt.PhpVal{}), 'cart') },
					rt.ArrayItem{ key: none, val: 'calculate_totals' },
				]),
				rt.new_int(20), rt.new_int(0)])
			if rt.is_true(var_passed_validation)
				&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'cart'), 'add_to_cart', [var_item.clone(), var_quantity.clone()]))))) {
				var_was_added_to_cart = rt.new_bool(true)
				var_added_to_cart.array_set(var_item, var_quantity.clone())
			}
			rt.call_function('add_action', [rt.new_string('woocommerce_add_to_cart'),
				rt.create_array([
					rt.ArrayItem{ key: none, val: rt.get_property(rt.call_function('WC',
						[]rt.PhpVal{}), 'cart') },
					rt.ArrayItem{ key: none, val: 'calculate_totals' },
				]),
				rt.new_int(20), rt.new_int(0)])
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(var_was_added_to_cart))))
			&& rt.is_true(rt.new_bool(!(rt.is_true(var_quantity_set)))) {
			rt.call_function('wc_add_notice', [
				rt.call_function('__', [
					rt.new_string('Please choose the quantity of items you wish to add to your cart&hellip;'),
					rt.new_string('woocommerce'),
				]),
				rt.new_string('error'),
			])
		} else if rt.is_true(var_was_added_to_cart) {
			rt.call_function('wc_add_to_cart_message', [var_added_to_cart.clone()])
			rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'cart'),
				'calculate_totals', []rt.PhpVal{})
			return true
		}
	} else if rt.is_true(var_product_id_mutated) {
		rt.call_function('wc_add_notice', [
			rt.call_function('__', [
				rt.new_string('Please choose a product to add to your cart&hellip;'),
				rt.new_string('woocommerce'),
			]),
			rt.new_string('error'),
		])
	}
	return false
}

fn Class_WC_Form_Handler.add_to_cart_handler_variable(var_product_id rt.PhpVal) bool {
	mut var_product_id_mutated := var_product_id
	mut var_variation_id := if !rt.is_true(rt.get_superglobal('_REQUEST').array_get(rt.new_string('variation_id'))) { rt.new_string('') } else { rt.call_function('absint', [
			rt.call_function('wp_unslash', [rt.get_superglobal('_REQUEST').array_get(rt.new_string('variation_id'))]),
		]) }
	mut var_quantity := if !rt.is_true(rt.get_superglobal('_REQUEST').array_get(rt.new_string('quantity'))) { rt.new_int(1) } else { rt.call_function('wc_stock_amount', [
			rt.call_function('wp_unslash', [rt.get_superglobal('_REQUEST').array_get(rt.new_string('quantity'))]),
		]) }
	mut var_variations := rt.new_array()
	mut var_product := rt.call_function('wc_get_product', [var_product_id_mutated.clone()])
	mut iter_7 := rt.get_superglobal('_REQUEST').iterator()
	for {
		item_7 := iter_7.next() or { break }
		mut var_value := item_7.val
		mut var_key := item_7.key
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('attribute_'), rt.call_function('substr', [
			var_key.clone(),
			rt.new_int(0),
			rt.new_int(10),
		])))))
		{
			continue
		}
		var_variations.array_set(rt.call_function('sanitize_title', [
			rt.call_function('wp_unslash', [var_key.clone()]),
		]), rt.call_function('wp_unslash', [var_value.clone()]))
	}
	mut var_passed_validation := rt.call_function('apply_filters', [
		rt.new_string('woocommerce_add_to_cart_validation'),
		rt.new_bool(true),
		var_product_id_mutated.clone(),
		var_quantity.clone(),
		var_variation_id.clone(),
		var_variations.clone(),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_passed_validation)))) {
		return false
	}
	if !rt.is_true(var_variation_id) && rt.is_true(var_product)
		&& rt.is_true(rt.call_method(var_product, 'is_type', [Class_Automattic_WooCommerce_Enums_ProductType.variable()])) {
		mut var_current_url := if rt.get_superglobal('_SERVER').array_isset(rt.new_string('REQUEST_URI')) { rt.call_function('wp_parse_url', [
				rt.call_function('sanitize_text_field', [
					rt.call_function('wp_unslash', [
						rt.get_superglobal('_SERVER').array_get(rt.new_string('REQUEST_URI')),
					]),
				]),
				rt.get_constant('PHP_URL_PATH'),
			]) } else { rt.new_string('') }
		mut var_product_url := rt.call_function('wp_parse_url', [
			rt.call_function('get_permalink', [var_product_id_mutated.clone()]),
			rt.get_constant('PHP_URL_PATH'),
		])
		mut var_is_in_product_page := rt.new_bool(rt.is_true(var_current_url)
			&& rt.is_true(var_product_url)
			&& rt.is_true(rt.identical(rt.call_function('untrailingslashit', [var_current_url.clone()]), rt.call_function('untrailingslashit', [var_product_url.clone()]))))
		if rt.is_true(var_is_in_product_page) {
			mut var_error_message := rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('Please choose product options for %1$s.'),
					rt.new_string('woocommerce'),
				]),
				rt.call_function('esc_html', [
					rt.call_method(var_product, 'get_name', []rt.PhpVal{}),
				]),
			])
		} else {
			var_error_message = rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('Please choose product options by visiting <a href="%1$s" title="%2$s">%2$s</a>.'),
					rt.new_string('woocommerce'),
				]),
				rt.call_function('esc_url', [
					rt.call_function('get_permalink', [var_product_id_mutated.clone()]),
				]),
				rt.call_function('esc_html', [
					rt.call_method(var_product, 'get_name', []rt.PhpVal{}),
				]),
			])
		}
		rt.call_function('wc_add_notice', [var_error_message.clone(),
			rt.new_string('error')])
		return false
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), rt.call_method(rt.get_property(rt.call_function('WC',
		[]rt.PhpVal{}), 'cart'), 'add_to_cart', [var_product_id_mutated.clone(),
		var_quantity.clone(), var_variation_id.clone(), var_variations.clone()])))))
	{
		rt.call_function('wc_add_to_cart_message', [
			rt.create_array([
				rt.ArrayItem{ key: var_product_id_mutated, val: var_quantity },
			]),
			rt.new_bool(true),
		])
		return true
	}
	return false
}

fn Class_WC_Form_Handler.process_login() {
	mut var_valid_nonce := rt.new_null()
	if rt.is_true(rt.identical(rt.new_null(), var_valid_nonce)) {
		mut var_nonce_value := rt.call_function('wc_get_var', [
			rt.get_superglobal('_REQUEST').array_get(rt.new_string('woocommerce-login-nonce')),
			rt.call_function('wc_get_var', [rt.get_superglobal('_REQUEST').array_get(rt.new_string('_wpnonce')),
				rt.new_string('')]),
		])
		var_valid_nonce = rt.call_function('wp_verify_nonce', [
			var_nonce_value.clone(), rt.new_string('woocommerce-login')])
	}
	if rt.get_superglobal('_POST').array_isset(rt.new_string('login'))
		&& rt.get_superglobal('_POST').array_isset(rt.new_string('username'))
		&& rt.get_superglobal('_POST').array_isset(rt.new_string('password'))
		&& rt.get_superglobal('_POST').array_get(rt.new_string('username')).is_string()
		&& rt.get_superglobal('_POST').array_get(rt.new_string('password')).is_string()
		&& rt.is_true(var_valid_nonce) {
		mut var_creds := rt.create_array([
			rt.ArrayItem{ key: 'user_login', val: rt.call_function('wp_unslash', [
				rt.get_superglobal('_POST').array_get(rt.new_string('username')),
			]).to_string().trim_space() },
			rt.ArrayItem{
				key: 'user_password'
				val: rt.get_superglobal('_POST').array_get(rt.new_string('password'))
			},
			rt.ArrayItem{
				key: 'remember'
				val: rt.new_bool(rt.get_superglobal('_POST').array_isset(rt.new_string('rememberme')))
			},
		])
		if rt.has_exception() {
			unsafe {
				goto catch_label_4
			}
		}
		mut var_validation_error := create_wp_error()
		if rt.has_exception() {
			unsafe {
				goto catch_label_4
			}
		}
		var_validation_error = rt.call_function('apply_filters', [
			rt.new_string('woocommerce_process_login_errors'),
			var_validation_error.clone(),
			var_creds.array_get(rt.new_string('user_login')),
			var_creds.array_get(rt.new_string('user_password')),
		])
		if rt.has_exception() {
			unsafe {
				goto catch_label_4
			}
		}
		if rt.is_true(rt.call_method(var_validation_error, 'get_error_code', []rt.PhpVal{})) {
			rt.throw_exception(rt.new_object('Exception', []string{}, create_exception('<strong>' +
				(rt.call_function('__', [rt.new_string('Error:'), rt.new_string('woocommerce')])).str() +
				'</strong> ' +
				(rt.call_method(var_validation_error, 'get_error_message', []rt.PhpVal{})).str())))
			if rt.has_exception() {
				unsafe {
					goto catch_label_4
				}
			}
		}
		if rt.has_exception() {
			unsafe {
				goto catch_label_4
			}
		}
		if !rt.is_true(var_creds.array_get(rt.new_string('user_login'))) {
			rt.throw_exception(rt.new_object('Exception', []string{}, create_exception('<strong>' +
				(rt.call_function('__', [rt.new_string('Error:'), rt.new_string('woocommerce')])).str() +
				'</strong> ' +(rt.call_function('__', [rt.new_string('Username is required.'), rt.new_string('woocommerce')])).str())))
			if rt.has_exception() {
				unsafe {
					goto catch_label_4
				}
			}
		}
		if rt.has_exception() {
			unsafe {
				goto catch_label_4
			}
		}
		if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) {
			mut var_user_data := rt.call_function('get_user_by', [
				rt.new_string((if rt.is_true(rt.call_function('is_email', [
					var_creds.array_get(rt.new_string('user_login')),
				]))
				{ 'email' } else { 'login' }).str()),
				var_creds.array_get(rt.new_string('user_login')),
			])
			if rt.has_exception() {
				unsafe {
					goto catch_label_4
				}
			}
			if rt.is_true(var_user_data)
				&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_user_member_of_blog', [rt.get_property(var_user_data, 'ID'), rt.call_function('get_current_blog_id', []rt.PhpVal{})]))))) {
				rt.call_function('add_user_to_blog', [
					rt.call_function('get_current_blog_id', []rt.PhpVal{}),
					rt.get_property(var_user_data, 'ID'),
					rt.new_string('customer'),
				])
				if rt.has_exception() {
					unsafe {
						goto catch_label_4
					}
				}
			}
			if rt.has_exception() {
				unsafe {
					goto catch_label_4
				}
			}
		}
		if rt.has_exception() {
			unsafe {
				goto catch_label_4
			}
		}
		mut var_user := rt.call_function('wp_signon', [
			rt.call_function('apply_filters', [
				rt.new_string('woocommerce_login_credentials'),
				var_creds.clone(),
			]),
			rt.call_function('is_ssl', []rt.PhpVal{}),
		])
		if rt.has_exception() {
			unsafe {
				goto catch_label_4
			}
		}
		if rt.is_true(rt.call_function('is_wp_error', [var_user.clone()])) {
			rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.call_method(var_user,
				'get_error_message', []rt.PhpVal{}))))
			if rt.has_exception() {
				unsafe {
					goto catch_label_4
				}
			}
		} else {
			if !(!rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('redirect')))) {
				mut var_redirect := rt.call_function('wp_unslash', [
					rt.get_superglobal('_POST').array_get(rt.new_string('redirect')),
				])
				if rt.has_exception() {
					unsafe {
						goto catch_label_4
					}
				}
				if rt.has_exception() {
					unsafe {
						goto catch_label_4
					}
				}
			} else if rt.is_true(rt.call_function('wc_get_raw_referer', []rt.PhpVal{})) {
				var_redirect = rt.call_function('wc_get_raw_referer', []rt.PhpVal{})
				if rt.has_exception() {
					unsafe {
						goto catch_label_4
					}
				}
			} else {
				var_redirect = rt.call_function('wc_get_page_permalink', [
					rt.new_string('myaccount'),
				])
				if rt.has_exception() {
					unsafe {
						goto catch_label_4
					}
				}
			}
			if rt.has_exception() {
				unsafe {
					goto catch_label_4
				}
			}
			var_redirect = rt.call_function('remove_query_arg', [
				rt.create_array([rt.ArrayItem{ key: none, val: 'wc_error' },
					rt.ArrayItem{ key: none, val: 'password-reset' }]),
				var_redirect.clone(),
			])
			if rt.has_exception() {
				unsafe {
					goto catch_label_4
				}
			}
			rt.call_function('wp_redirect', [
				rt.call_function('wp_validate_redirect', [
					rt.call_function('apply_filters', [
						rt.new_string('woocommerce_login_redirect'),
						var_redirect.clone(),
						var_user.clone(),
					]),
					rt.call_function('wc_get_page_permalink', [
						rt.new_string('myaccount'),
					]),
				]),
			])
			if rt.has_exception() {
				unsafe {
					goto catch_label_4
				}
			}
			exit(0)
			if rt.has_exception() {
				unsafe {
					goto catch_label_4
				}
			}
		}
		if rt.has_exception() {
			unsafe {
				goto catch_label_4
			}
		}
		unsafe {
			goto end_label_4
		}
		catch_label_4:
		mut var_e_4 := rt.get_and_clear_exception()
		if rt.instance_of(var_e_4, 'Exception') {
			mut var_e := var_e_4.clone()
			rt.call_function('wc_add_notice', [
				rt.call_function('apply_filters', [rt.new_string('login_errors'),
					rt.call_method(var_e, 'getMessage', []rt.PhpVal{})]),
				rt.new_string('error'),
			])
			rt.call_function('do_action', [rt.new_string('woocommerce_login_failed')])
			unsafe {
				goto end_label_4
			}
		} else {
			rt.throw_exception(var_e_4)
			unsafe {
				goto end_label_4
			}
		}

		end_label_4:
	}
}

fn Class_WC_Form_Handler.process_lost_password() {
	if rt.get_superglobal('_POST').array_isset(rt.new_string('wc_reset_password'))
		&& rt.get_superglobal('_POST').array_isset(rt.new_string('user_login')) {
		mut var_nonce_value := rt.call_function('wc_get_var', [
			rt.get_superglobal('_REQUEST').array_get(rt.new_string('woocommerce-lost-password-nonce')),
			rt.call_function('wc_get_var', [rt.get_superglobal('_REQUEST').array_get(rt.new_string('_wpnonce')),
				rt.new_string('')]),
		])
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_verify_nonce', [
			var_nonce_value.clone(),
			rt.new_string('lost_password'),
		])))))
		{
			return
		}
		mut iife_temp_9 := Class_WC_Shortcode_My_Account{}
		mut iife_result_9 := iife_temp_9.retrieve_password()
		mut var_success := iife_result_9
		if rt.is_true(var_success) {
			rt.call_function('wp_safe_redirect', [
				rt.call_function('add_query_arg', [rt.new_string('reset-link-sent'),
					rt.new_string('true'),
					rt.call_function('wc_get_account_endpoint_url', [
						rt.new_string('lost-password'),
					])]),
			])
			exit(0)
		}
	}
}

fn Class_WC_Form_Handler.process_reset_password() {
	mut var_nonce_value := rt.call_function('wc_get_var', [
		rt.get_superglobal('_REQUEST').array_get(rt.new_string('woocommerce-reset-password-nonce')),
		rt.call_function('wc_get_var', [rt.get_superglobal('_REQUEST').array_get(rt.new_string('_wpnonce')),
			rt.new_string('')]),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_verify_nonce', [
		var_nonce_value.clone(),
		rt.new_string('reset_password'),
	])))))
	{
		return
	}
	mut var_posted_fields := rt.create_array([
		rt.ArrayItem{ key: none, val: 'wc_reset_password' },
		rt.ArrayItem{ key: none, val: 'password_1' },
		rt.ArrayItem{ key: none, val: 'password_2' },
		rt.ArrayItem{ key: none, val: 'reset_key' },
		rt.ArrayItem{ key: none, val: 'reset_login' },
	])
	mut iter_8 := var_posted_fields.iterator()
	for {
		item_8 := iter_8.next() or { break }
		mut var_field := item_8.val
		if !(rt.get_superglobal('_POST').array_isset(var_field)) {
			return
		}
		if rt.is_true(rt.call_function('in_array', [var_field.clone(),
			rt.create_array([rt.ArrayItem{ key: none, val: 'password_1' },
				rt.ArrayItem{ key: none, val: 'password_2' }]),
			rt.new_bool(true)]))
		{
			var_posted_fields.array_set(var_field, rt.get_superglobal('_POST').array_get(var_field))
		} else {
			var_posted_fields.array_set(var_field, rt.call_function('wp_unslash', [
				rt.get_superglobal('_POST').array_get(var_field),
			]))
		}
	}
	mut iife_temp_10 := Class_WC_Shortcode_My_Account{}
	mut iife_result_10 := iife_temp_10.check_password_reset_key(var_posted_fields.array_get(rt.new_string('reset_key')),
		var_posted_fields.array_get(rt.new_string('reset_login')))
	mut var_user := iife_result_10
	if rt.is_true(rt.new_bool(rt.instance_of(var_user, 'WP_User'))) {
		if !rt.is_true(var_posted_fields.array_get(rt.new_string('password_1'))) {
			rt.call_function('wc_add_notice', [
				rt.call_function('__', [rt.new_string('Please enter your password.'),
					rt.new_string('woocommerce')]),
				rt.new_string('error'),
			])
		}
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_posted_fields.array_get(rt.new_string('password_1')),
			var_posted_fields.array_get(rt.new_string('password_2'))))))
		{
			rt.call_function('wc_add_notice', [
				rt.call_function('__', [rt.new_string('Passwords do not match.'),
					rt.new_string('woocommerce')]),
				rt.new_string('error'),
			])
		}
		mut var_errors := create_wp_error()
		rt.call_function('do_action', [rt.new_string('validate_password_reset'), var_errors,
			var_user.clone()])
		rt.call_function('wc_add_wp_error_notices', [var_errors])
		if rt.is_true(rt.identical(rt.new_int(0), rt.call_function('wc_notice_count', [
			rt.new_string('error'),
		])))
		{
			mut iife_temp_11 := Class_WC_Shortcode_My_Account{}
			mut iife_result_11 := iife_temp_11.reset_password(var_user.clone(),
				var_posted_fields.array_get(rt.new_string('password_1')))
			rt.call_function('do_action', [
				rt.new_string('woocommerce_customer_reset_password'),
				var_user.clone(),
			])
			rt.call_function('wp_safe_redirect', [
				rt.call_function('add_query_arg', [rt.new_string('password-reset'),
					rt.new_string('true'),
					rt.call_function('wc_get_page_permalink', [
						rt.new_string('myaccount'),
					])]),
			])
			exit(0)
		}
	}
}

fn Class_WC_Form_Handler.process_registration() {
	mut var_nonce_value := if rt.get_superglobal('_POST').array_isset(rt.new_string('_wpnonce')) { rt.call_function('wp_unslash', [
			rt.get_superglobal('_POST').array_get(rt.new_string('_wpnonce')),
		]) } else { rt.new_string('') }
	var_nonce_value = if rt.get_superglobal('_POST').array_isset(rt.new_string('woocommerce-register-nonce')) { rt.call_function('wp_unslash', [
			rt.get_superglobal('_POST').array_get(rt.new_string('woocommerce-register-nonce')),
		]) } else { var_nonce_value }
	if rt.get_superglobal('_POST').array_isset(rt.new_string('register'))
		&& rt.get_superglobal('_POST').array_isset(rt.new_string('email'))
		&& rt.is_true(rt.call_function('wp_verify_nonce', [var_nonce_value.clone(), rt.new_string('woocommerce-register')])) {
		mut var_username := if rt.is_true(rt.identical(rt.new_string('no'), rt.call_function('get_option', [rt.new_string('woocommerce_registration_generate_username')]))) && rt.get_superglobal('_POST').array_isset(rt.new_string('username')) { rt.call_function('wp_unslash', [
				rt.get_superglobal('_POST').array_get(rt.new_string('username')),
			]) } else { rt.new_string('') }
		mut var_password := if
			rt.is_true(rt.identical(rt.new_string('no'), rt.call_function('get_option', [rt.new_string('woocommerce_registration_generate_password')])))
			&& rt.get_superglobal('_POST').array_isset(rt.new_string('password')) {
			rt.get_superglobal('_POST').array_get(rt.new_string('password'))
		} else {
			rt.new_string('')
		}
		mut var_email := rt.call_function('wp_unslash', [
			rt.get_superglobal('_POST').array_get(rt.new_string('email')),
		])
		mut var_validation_error := create_wp_error()
		if rt.has_exception() {
			unsafe {
				goto catch_label_5
			}
		}
		var_validation_error = rt.call_function('apply_filters', [
			rt.new_string('woocommerce_process_registration_errors'),
			var_validation_error.clone(),
			var_username.clone(),
			var_password.clone(),
			var_email.clone(),
		])
		if rt.has_exception() {
			unsafe {
				goto catch_label_5
			}
		}
		mut var_validation_errors := rt.call_method(var_validation_error, 'get_error_messages',
			[]rt.PhpVal{})
		if rt.has_exception() {
			unsafe {
				goto catch_label_5
			}
		}
		if 1 == var_validation_errors.clone().array_count() {
			rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.call_method(var_validation_error,
				'get_error_message', []rt.PhpVal{}))))
			if rt.has_exception() {
				unsafe {
					goto catch_label_5
				}
			}
		} else if rt.is_true(var_validation_errors) {
			mut iter_9 := var_validation_errors.iterator()
			for {
				item_9 := iter_9.next() or { break }
				mut var_message := item_9.val
				rt.call_function('wc_add_notice', [
					rt.new_string('<strong>' +
						(rt.call_function('__', [rt.new_string('Error:'), rt.new_string('woocommerce')])).str() +
						'</strong> ' + var_message.str()),
					rt.new_string('error'),
				])
				if rt.has_exception() {
					unsafe {
						goto catch_label_5
					}
				}
			}
			if rt.has_exception() {
				unsafe {
					goto catch_label_5
				}
			}
			rt.throw_exception(rt.new_object('Exception', []string{}, create_exception()))
			if rt.has_exception() {
				unsafe {
					goto catch_label_5
				}
			}
		}
		if rt.has_exception() {
			unsafe {
				goto catch_label_5
			}
		}
		mut var_new_customer := rt.call_function('wc_create_new_customer', [
			rt.call_function('sanitize_email', [var_email.clone()]),
			rt.call_function('wc_clean', [var_username.clone()]),
			var_password.clone(),
		])
		if rt.has_exception() {
			unsafe {
				goto catch_label_5
			}
		}
		if rt.is_true(rt.call_function('is_wp_error', [var_new_customer.clone()])) {
			rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.call_method(var_new_customer,
				'get_error_message', []rt.PhpVal{}))))
			if rt.has_exception() {
				unsafe {
					goto catch_label_5
				}
			}
		}
		if rt.has_exception() {
			unsafe {
				goto catch_label_5
			}
		}
		if rt.is_true(rt.identical(rt.new_string('yes'), rt.call_function('get_option', [
			rt.new_string('woocommerce_registration_generate_password'),
		])))
		{
			rt.call_function('wc_add_notice', [
				rt.call_function('__', [
					rt.new_string('Your account was created successfully and a password has been sent to your email address.'),
					rt.new_string('woocommerce'),
				]),
			])
			if rt.has_exception() {
				unsafe {
					goto catch_label_5
				}
			}
		} else {
			rt.call_function('wc_add_notice', [
				rt.call_function('__', [
					rt.new_string('Your account was created successfully. Your login details have been sent to your email address.'),
					rt.new_string('woocommerce'),
				]),
			])
			if rt.has_exception() {
				unsafe {
					goto catch_label_5
				}
			}
		}
		if rt.has_exception() {
			unsafe {
				goto catch_label_5
			}
		}
		if rt.is_true(rt.call_function('apply_filters', [
			rt.new_string('woocommerce_registration_auth_new_customer'),
			rt.new_bool(true),
			var_new_customer.clone(),
		]))
		{
			rt.call_function('wc_set_customer_auth_cookie', [
				var_new_customer.clone()])
			if rt.has_exception() {
				unsafe {
					goto catch_label_5
				}
			}
			if !(!rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('redirect')))) {
				mut var_redirect := rt.call_function('wp_sanitize_redirect', [
					rt.call_function('wp_unslash', [
						rt.get_superglobal('_POST').array_get(rt.new_string('redirect')),
					]),
				])
				if rt.has_exception() {
					unsafe {
						goto catch_label_5
					}
				}
				if rt.has_exception() {
					unsafe {
						goto catch_label_5
					}
				}
			} else if rt.is_true(rt.call_function('wc_get_raw_referer', []rt.PhpVal{})) {
				var_redirect = rt.call_function('wc_get_raw_referer', []rt.PhpVal{})
				if rt.has_exception() {
					unsafe {
						goto catch_label_5
					}
				}
			} else {
				var_redirect = rt.call_function('wc_get_page_permalink', [
					rt.new_string('myaccount'),
				])
				if rt.has_exception() {
					unsafe {
						goto catch_label_5
					}
				}
			}
			if rt.has_exception() {
				unsafe {
					goto catch_label_5
				}
			}
			rt.call_function('wp_redirect', [
				rt.call_function('wp_validate_redirect', [
					rt.call_function('apply_filters', [
						rt.new_string('woocommerce_registration_redirect'),
						var_redirect.clone(),
					]),
					rt.call_function('wc_get_page_permalink', [
						rt.new_string('myaccount'),
					]),
				]),
			])
			if rt.has_exception() {
				unsafe {
					goto catch_label_5
				}
			}
			exit(0)
			if rt.has_exception() {
				unsafe {
					goto catch_label_5
				}
			}
		}
		if rt.has_exception() {
			unsafe {
				goto catch_label_5
			}
		}
		unsafe {
			goto end_label_5
		}
		catch_label_5:
		mut var_e_5 := rt.get_and_clear_exception()
		if rt.instance_of(var_e_5, 'Exception') {
			mut var_e := var_e_5.clone()
			if rt.is_true(rt.call_method(var_e, 'getMessage', []rt.PhpVal{})) {
				rt.call_function('wc_add_notice', [
					rt.new_string('<strong>' +
						(rt.call_function('__', [rt.new_string('Error:'), rt.new_string('woocommerce')])).str() +
						'</strong> ' + (rt.call_method(var_e, 'getMessage', []rt.PhpVal{})).str()),
					rt.new_string('error'),
				])
			}
			unsafe {
				goto end_label_5
			}
		} else {
			rt.throw_exception(var_e_5)
			unsafe {
				goto end_label_5
			}
		}

		end_label_5:
	}
}

struct Class_WC_Shortcode_My_Account {
	rt.PhpObjectBase
}

struct Class_WC_Customer {
	rt.PhpObjectBase
}

struct Class_WC_Validation {
	rt.PhpObjectBase
}

struct Class_stdClass {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

struct Class_Exception {
	rt.PhpObjectBase
pub mut:
	message string
	code    i64
	file    string
	line    i64
}

fn (mut this Class_Exception) construct(var_message rt.PhpVal) {
	this.message = var_message.to_string()
}

fn (mut this Class_Exception) getmessage() string {
	return this.message
}

struct Class_WC_Rate_Limiter {
	rt.PhpObjectBase
}

struct Class_WC_Payment_Tokens {
	rt.PhpObjectBase
}

fn create_wc_form_handler(_args ...rt.PhpVal) &Class_WC_Form_Handler {
	mut obj := &Class_WC_Form_Handler{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_shortcode_my_account(_args ...rt.PhpVal) &Class_WC_Shortcode_My_Account {
	mut obj := &Class_WC_Shortcode_My_Account{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_customer(_args ...rt.PhpVal) &Class_WC_Customer {
	mut obj := &Class_WC_Customer{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_validation(_args ...rt.PhpVal) &Class_WC_Validation {
	mut obj := &Class_WC_Validation{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_stdclass(_args ...rt.PhpVal) &Class_stdClass {
	mut obj := &Class_stdClass{
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

fn create_exception(arg_0 rt.PhpVal) &Class_Exception {
	mut obj := &Class_Exception{
		PhpObjectBase: rt.PhpObjectBase{}
		message:       ''
		code:          i64(0)
		file:          ''
		line:          i64(0)
	}
	obj.construct(arg_0)
	return obj
}

fn create_wc_rate_limiter(_args ...rt.PhpVal) &Class_WC_Rate_Limiter {
	mut obj := &Class_WC_Rate_Limiter{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_payment_tokens(_args ...rt.PhpVal) &Class_WC_Payment_Tokens {
	mut obj := &Class_WC_Payment_Tokens{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Form_Handler) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'init' {
			Class_WC_Form_Handler.init()
			return rt.new_null()
		}
		'redirect_reset_password_link' {
			Class_WC_Form_Handler.redirect_reset_password_link()
			return rt.new_null()
		}
		'save_address' {
			Class_WC_Form_Handler.save_address()
			return rt.new_null()
		}
		'save_account_details' {
			Class_WC_Form_Handler.save_account_details()
			return rt.new_null()
		}
		'checkout_action' {
			Class_WC_Form_Handler.checkout_action()
			return rt.new_null()
		}
		'pay_action' {
			Class_WC_Form_Handler.pay_action()
			return rt.new_null()
		}
		'add_payment_method_action' {
			Class_WC_Form_Handler.add_payment_method_action()
			return rt.new_null()
		}
		'delete_payment_method_action' {
			Class_WC_Form_Handler.delete_payment_method_action()
			return rt.new_null()
		}
		'set_default_payment_method_action' {
			Class_WC_Form_Handler.set_default_payment_method_action()
			return rt.new_null()
		}
		'update_cart_action' {
			Class_WC_Form_Handler.update_cart_action()
			return rt.new_null()
		}
		'order_again' {
			Class_WC_Form_Handler.order_again()
			return rt.new_null()
		}
		'cancel_order' {
			Class_WC_Form_Handler.cancel_order()
			return rt.new_null()
		}
		'add_to_cart_action' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			Class_WC_Form_Handler.add_to_cart_action(dispatch_arg_0)
			return rt.new_null()
		}
		'add_to_cart_handler_simple' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(Class_WC_Form_Handler.add_to_cart_handler_simple(dispatch_arg_0))
		}
		'add_to_cart_handler_grouped' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(Class_WC_Form_Handler.add_to_cart_handler_grouped(dispatch_arg_0))
		}
		'add_to_cart_handler_variable' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(Class_WC_Form_Handler.add_to_cart_handler_variable(dispatch_arg_0))
		}
		'process_login' {
			Class_WC_Form_Handler.process_login()
			return rt.new_null()
		}
		'process_lost_password' {
			Class_WC_Form_Handler.process_lost_password()
			return rt.new_null()
		}
		'process_reset_password' {
			Class_WC_Form_Handler.process_reset_password()
			return rt.new_null()
		}
		'process_registration' {
			Class_WC_Form_Handler.process_registration()
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_Form_Handler) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Form_Handler) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_Shortcode_My_Account) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Shortcode_My_Account) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Shortcode_My_Account) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_Customer) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Customer) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Customer) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_Validation) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Validation) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Validation) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_stdClass) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_stdClass) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_stdClass) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_Exception) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'getMessage' {
			return rt.new_string(this.getmessage())
		}
		else {
			return none
		}
	}
}

fn (this &Class_Exception) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'message' { return rt.new_string(this.message) }
		'code' { return rt.new_int(this.code) }
		'file' { return rt.new_string(this.file) }
		'line' { return rt.new_int(this.line) }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Exception) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'message' {
			this.message = val.str()
			return true
		}
		'code' {
			this.code = val.to_i64()
			return true
		}
		'file' {
			this.file = val.str()
			return true
		}
		'line' {
			this.line = val.to_i64()
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_WC_Rate_Limiter) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Rate_Limiter) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Rate_Limiter) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_Payment_Tokens) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Payment_Tokens) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Payment_Tokens) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn init_registry() {
}

fn init() {
	init_registry()
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
	Class_WC_Form_Handler.init()
}
