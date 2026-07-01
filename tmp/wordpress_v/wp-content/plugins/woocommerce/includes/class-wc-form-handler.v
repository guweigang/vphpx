import rt

struct Class_WC_Form_Handler {
	rt.PhpObjectBase
}

fn Class_WC_Form_Handler.init()  {
	rt.call_function('add_action', [rt.new_string('template_redirect'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'redirect_reset_password_link' }])])
	rt.call_function('add_action', [rt.new_string('template_redirect'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'save_address' }])])
	rt.call_function('add_action', [rt.new_string('template_redirect'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'save_account_details' }])])
	rt.call_function('add_action', [rt.new_string('wp_loaded'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'checkout_action' }]), rt.new_int(20)])
	rt.call_function('add_action', [rt.new_string('wp_loaded'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'process_login' }]), rt.new_int(20)])
	rt.call_function('add_action', [rt.new_string('wp_loaded'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'process_registration' }]), rt.new_int(20)])
	rt.call_function('add_action', [rt.new_string('wp_loaded'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'process_lost_password' }]), rt.new_int(20)])
	rt.call_function('add_action', [rt.new_string('wp_loaded'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'process_reset_password' }]), rt.new_int(20)])
	rt.call_function('add_action', [rt.new_string('wp_loaded'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'cancel_order' }]), rt.new_int(20)])
	rt.call_function('add_action', [rt.new_string('wp_loaded'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'update_cart_action' }]), rt.new_int(20)])
	rt.call_function('add_action', [rt.new_string('wp_loaded'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'add_to_cart_action' }]), rt.new_int(20)])
	rt.call_function('add_action', [rt.new_string('wp'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'pay_action' }]), rt.new_int(20)])
	rt.call_function('add_action', [rt.new_string('wp'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'add_payment_method_action' }]), rt.new_int(20)])
	rt.call_function('add_action', [rt.new_string('wp'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'delete_payment_method_action' }]), rt.new_int(20)])
	rt.call_function('add_action', [rt.new_string('wp'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'set_default_payment_method_action' }]), rt.new_int(20)])
}

fn Class_WC_Form_Handler.redirect_reset_password_link()  {
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.call_function('is_account_page', []rt.PhpVal{})) && rt.get_superglobal('_GET').array_isset(rt.new_string('key')))) && rt.get_superglobal('_GET').array_isset(rt.new_string('id')) || rt.get_superglobal('_GET').array_isset(rt.new_string('login')))) {
		if rt.get_superglobal('_GET').array_isset(rt.new_string('login')) {
			mut var_user := rt.call_function('get_user_by', [rt.new_string('login'), rt.call_function('sanitize_user', [rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get('login')])])])
			mut var_user_id := if rt.is_true(var_user) { rt.get_property(var_user, 'ID') } else { rt.new_int(0) }
		} else {
			var_user_id = rt.call_function('absint', [rt.get_superglobal('_GET').array_get('id')])
			// unsupported statement: Stmt_Nop
		}
		mut var_logged_in_user_id := rt.call_function('get_current_user_id', []rt.PhpVal{})
		if rt.is_true(rt.new_bool(rt.is_true(var_logged_in_user_id) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
			rt.call_function('wc_add_notice', [rt.call_function('__', [rt.new_string('This password reset key is for a different user account. Please log out and try again.'), rt.new_string('woocommerce')]), rt.new_string('error')])
			return rt.new_null()
		}
		mut var_action := if rt.get_superglobal('_GET').array_isset(rt.new_string('action')) { rt.call_function('sanitize_text_field', [rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get('action')])]) } else { rt.new_string('') }
		mut var_value := rt.call_function('sprintf', [rt.new_string('%d:%s'), var_user_id.dup(), rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get('key')])])
		fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Shortcode_My_Account{}; return temp.set_reset_password_cookie(arg_0) }(var_value.dup())
		rt.call_function('wp_safe_redirect', [rt.call_function('add_query_arg', [rt.create_array([rt.ArrayItem{ key: 'show-reset-form', val: 'true' }, rt.ArrayItem{ key: 'action', val: var_action }]), rt.call_function('wc_lostpassword_url', []rt.PhpVal{})])])
		// unsupported expression: Expr_Exit
	}
}

fn Class_WC_Form_Handler.save_address()  {
	mut var_wp := rt.new_null()
	// unsupported statement: Stmt_Global
	mut var_nonce_value := rt.call_function('wc_get_var', [rt.get_superglobal('_REQUEST').array_get('woocommerce-edit-address-nonce'), rt.call_function('wc_get_var', [rt.get_superglobal('_REQUEST').array_get('_wpnonce'), rt.new_string('')])])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_verify_nonce', [var_nonce_value.dup(), rt.new_string('woocommerce-edit_address')]))))) {
		return rt.new_null()
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.get_superglobal('_POST').array_get('action')) || rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		return rt.new_null()
	}
	rt.call_function('wc_nocache_headers', []rt.PhpVal{})
	mut var_user_id := rt.call_function('get_current_user_id', []rt.PhpVal{})
	if rt.is_true(rt.less_equal(var_user_id, rt.new_int(0))) {
		return rt.new_null()
	}
	mut var_customer := create_wc_customer(var_user_id.dup())
	if rt.is_true(rt.new_bool(!(rt.is_true(var_customer)))) {
		return rt.new_null()
	}
	mut var_address_type := if rt.get_property(var_wp, 'query_vars').array_isset(rt.new_string('edit-address')) { rt.call_function('wc_edit_address_i18n', [rt.call_function('sanitize_title', [rt.get_property(var_wp, 'query_vars').array_get('edit-address')]), rt.new_bool(true)]) } else { rt.new_string('billing') }
	if !(rt.get_superglobal('_POST').array_isset((var_address_type).str() + '_country')) {
		return rt.new_null()
	}
	mut var_address := rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'countries'), 'get_address_fields', [rt.call_function('wc_clean', [rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get((var_address_type).str() + '_country')])]), (var_address_type).str() + '_'])
	{
		mut iter_1 := var_address.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_field := item_1.val
			mut var_key := item_1.key
			if !(var_field.array_isset(rt.new_string('type'))) {
				var_field.array_set('type', 'text')
			}
			if rt.is_true(rt.identical(rt.new_string('checkbox'), var_field.array_get('type'))) {
				mut var_value := // unsupported expression: Expr_Cast_Int
			} else {
				var_value = if rt.get_superglobal('_POST').array_isset(var_key) { rt.call_function('wc_clean', [rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get(var_key)])]) } else { rt.new_string('') }
			}
			var_value = rt.call_function('apply_filters', ['woocommerce_process_myaccount_field_' + (var_key).str(), var_value.dup()])
			if !(!rt.is_true(var_field.array_get('required'))) && !rt.is_true(var_value) {
				rt.call_function('wc_add_notice', [rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('%s is a required field.'), rt.new_string('woocommerce')]), var_field.array_get('label')]), rt.new_string('error'), rt.create_array([rt.ArrayItem{ key: 'id', val: var_key }])])
			}
			if !(!rt.is_true(var_value)) {
				if rt.is_true(rt.new_bool(!(!rt.is_true(var_field.array_get('validate'))) && rt.is_true(rt.new_bool(var_field.array_get('validate').is_array())))) {
					{
						mut iter_2 := var_field.array_get('validate').iterator()
						for {
							item_2 := iter_2.next() or { break }
							mut var_rule := item_2.val
							mut switch_val_1 := var_rule
							if rt.is_true(rt.equal(switch_val_1, rt.new_string('postcode'))) {
								mut var_country := rt.call_function('wc_clean', [rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get((var_address_type).str() + '_country')])])
								var_value = rt.call_function('wc_format_postcode', [var_value.dup(), var_country.dup()])
								if rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) && rt.is_true(rt.new_bool(!(rt.is_true(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Validation{}; return temp.is_postcode(arg_0, arg_1) }(var_value.dup(), var_country.dup()))))))) {
									mut switch_val_2 := var_country
									if rt.is_true(rt.equal(switch_val_2, rt.new_string('IE'))) {
										mut var_postcode_validation_notice := rt.call_function('__', [rt.new_string('Please enter a valid Eircode.'), rt.new_string('woocommerce')])
									} else {
										var_postcode_validation_notice = rt.call_function('__', [rt.new_string('Please enter a valid postcode / ZIP.'), rt.new_string('woocommerce')])
									}
									rt.call_function('wc_add_notice', [var_postcode_validation_notice.dup(), rt.new_string('error')])
								}
							} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('phone'))) {
								if rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) && rt.is_true(rt.new_bool(!(rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Validation{}; return temp.is_phone(arg_0) }(var_value.dup()))))))) {
									rt.call_function('wc_add_notice', [rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('%s is not a valid phone number.'), rt.new_string('woocommerce')]), '<strong>' + (var_field.array_get('label')).str() + '</strong>']), rt.new_string('error')])
								}
							} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('email'))) {
								var_value = rt.new_string(rt.new_string(var_value.dup().to_string().to_lower()))
								if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_email', [var_value.dup()]))))) {
									rt.call_function('wc_add_notice', [rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('%s is not a valid email address.'), rt.new_string('woocommerce')]), '<strong>' + (var_field.array_get('label')).str() + '</strong>']), rt.new_string('error')])
								}
							}
						}
					}
				}
			}
			if rt.is_true(rt.call_function('is_callable', [rt.create_array([rt.ArrayItem{ key: none, val: var_customer }, rt.ArrayItem{ key: none, val: "set_${var_key.to_string()}" }])])) {
				rt.call_method(var_customer, "set_${var_key.to_string()}", [var_value.dup()])
				if rt.has_exception() { unsafe { goto catch_label_1 } }
			} else {
				var_customer.update_meta_data(var_key.dup(), var_value.dup())
				if rt.has_exception() { unsafe { goto catch_label_1 } }
			}
			if rt.has_exception() { unsafe { goto catch_label_1 } }
			unsafe { goto end_label_1 }

catch_label_1:
			mut var_e_1 := rt.get_and_clear_exception()
			if rt.instance_of(var_e_1, 'WC_Data_Exception') {
				mut var_e := var_e_1.dup()
				if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
					rt.call_function('wc_add_notice', [rt.call_method(var_e, 'getMessage', []rt.PhpVal{}), rt.new_string('error')])
				}
				unsafe { goto end_label_1 }
			}
			else {
				rt.throw_exception(var_e_1)
				unsafe { goto end_label_1 }
			}

end_label_1:
		}
	}
	rt.call_function('do_action', [rt.new_string('woocommerce_after_save_address_validation'), var_user_id.dup(), var_address_type.dup(), var_address.dup(), var_customer])
	if rt.is_true(rt.less(rt.new_int(0), rt.call_function('wc_notice_count', [rt.new_string('error')]))) {
		return rt.new_null()
	}
	var_customer.save()
	rt.call_function('do_action', [rt.new_string('woocommerce_customer_save_address'), var_user_id.dup(), var_address_type.dup(), var_address.dup(), var_customer])
	if rt.is_true(rt.less(rt.new_int(0), rt.call_function('wc_notice_count', [rt.new_string('error')]))) {
		return rt.new_null()
	}
	rt.call_function('wc_add_notice', [rt.call_function('__', [rt.new_string('Address changed successfully.'), rt.new_string('woocommerce')])])
	rt.call_function('wp_safe_redirect', [rt.call_function('wc_get_endpoint_url', [rt.new_string('edit-address'), rt.new_string(''), rt.call_function('wc_get_page_permalink', [rt.new_string('myaccount')])])])
	// unsupported expression: Expr_Exit
}

fn Class_WC_Form_Handler.save_account_details()  {
	mut var_nonce_value := rt.call_function('wc_get_var', [rt.get_superglobal('_REQUEST').array_get('save-account-details-nonce'), rt.call_function('wc_get_var', [rt.get_superglobal('_REQUEST').array_get('_wpnonce'), rt.new_string('')])])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_verify_nonce', [var_nonce_value.dup(), rt.new_string('save_account_details')]))))) {
		return rt.new_null()
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.get_superglobal('_POST').array_get('action')) || rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		return rt.new_null()
	}
	rt.call_function('wc_nocache_headers', []rt.PhpVal{})
	mut var_user_id := rt.call_function('get_current_user_id', []rt.PhpVal{})
	if rt.is_true(rt.less_equal(var_user_id, rt.new_int(0))) {
		return rt.new_null()
	}
	mut var_account_first_name := if !(!rt.is_true(rt.get_superglobal('_POST').array_get('account_first_name'))) { rt.call_function('wc_clean', [rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get('account_first_name')])]) } else { rt.new_string('') }
	mut var_account_last_name := if !(!rt.is_true(rt.get_superglobal('_POST').array_get('account_last_name'))) { rt.call_function('wc_clean', [rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get('account_last_name')])]) } else { rt.new_string('') }
	mut var_account_display_name := if !(!rt.is_true(rt.get_superglobal('_POST').array_get('account_display_name'))) { rt.call_function('wc_clean', [rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get('account_display_name')])]) } else { rt.new_string('') }
	mut var_account_email := if !(!rt.is_true(rt.get_superglobal('_POST').array_get('account_email'))) { rt.call_function('wc_clean', [rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get('account_email')])]) } else { rt.new_string('') }
	mut var_pass_cur := if !(!rt.is_true(rt.get_superglobal('_POST').array_get('password_current'))) { rt.get_superglobal('_POST').array_get('password_current') } else { rt.new_string('') }
	mut var_pass1 := if !(!rt.is_true(rt.get_superglobal('_POST').array_get('password_1'))) { rt.get_superglobal('_POST').array_get('password_1') } else { rt.new_string('') }
	mut var_pass2 := if !(!rt.is_true(rt.get_superglobal('_POST').array_get('password_2'))) { rt.get_superglobal('_POST').array_get('password_2') } else { rt.new_string('') }
	mut var_save_pass := rt.new_bool(rt.new_bool(true))
	mut var_current_user := rt.call_function('get_user_by', [rt.new_string('id'), var_user_id.dup()])
	mut var_current_first_name := rt.get_property(var_current_user, 'first_name')
	mut var_current_last_name := rt.get_property(var_current_user, 'last_name')
	mut var_current_email := rt.get_property(var_current_user, 'user_email')
	mut var_user := create_stdclass()
	rt.set_property(var_user, 'ID', var_user_id.dup())
	rt.set_property(var_user, 'first_name', var_account_first_name.dup())
	rt.set_property(var_user, 'last_name', var_account_last_name.dup())
	rt.set_property(var_user, 'display_name', var_account_display_name.dup())
	if rt.is_true(rt.call_function('is_email', [var_account_display_name.dup()])) {
		rt.call_function('wc_add_notice', [rt.call_function('__', [, ]), rt.new_string('error')])
	}
	mut var_required_fields := rt.call_function('apply_filters', [, ])
	{
		mut iter_1 := var_required_fields.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_field_name := item_1.val
			mut var_field_key := item_1.key
			if !rt.is_true() {
			}
		}
	}
	if rt.is_true() {
	}
	if !(!rt.is_true()) && !rt.is_true() && !rt.is_true() {
	} else if !(!rt.is_true()) && !rt.is_true() {
	} else if !(!rt.is_true()) && !rt.is_true() {
	} else if rt.is_true() {
	} else if rt.is_true() {
	}
	if rt.is_true() {
	}
	
}

fn Class_WC_Form_Handler.checkout_action()  {
}

fn Class_WC_Form_Handler.pay_action()  {
	mut var_wp := rt.new_null()
}

fn Class_WC_Form_Handler.add_payment_method_action()  {
}

fn Class_WC_Form_Handler.delete_payment_method_action()  {
	mut var_wp := rt.new_null()
}

fn Class_WC_Form_Handler.set_default_payment_method_action()  {
	mut var_wp := rt.new_null()
}

fn Class_WC_Form_Handler.update_cart_action()  {
}

fn Class_WC_Form_Handler.order_again()  {
}

fn Class_WC_Form_Handler.cancel_order()  {
}

fn Class_WC_Form_Handler.add_to_cart_action(url bool)  {
	mut url_mutated := url
}

fn Class_WC_Form_Handler.add_to_cart_handler_simple(var_product_id rt.PhpVal) bool {
	mut var_product_id_mutated := var_product_id
}

fn Class_WC_Form_Handler.add_to_cart_handler_grouped(var_product_id rt.PhpVal) bool {
	mut var_product_id_mutated := var_product_id
}

fn Class_WC_Form_Handler.add_to_cart_handler_variable(var_product_id rt.PhpVal) bool {
	mut var_product_id_mutated := var_product_id
}

fn Class_WC_Form_Handler.process_login()  {
}

fn Class_WC_Form_Handler.process_lost_password()  {
}

fn Class_WC_Form_Handler.process_reset_password()  {
}

fn Class_WC_Form_Handler.process_registration()  {
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

fn create_wc_form_handler() &Class_WC_Form_Handler {
	mut obj := &Class_WC_Form_Handler{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_shortcode_my_account() &Class_WC_Shortcode_My_Account {
	mut obj := &Class_WC_Shortcode_My_Account{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_customer() &Class_WC_Customer {
	mut obj := &Class_WC_Customer{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_validation() &Class_WC_Validation {
	mut obj := &Class_WC_Validation{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_stdclass() &Class_stdClass {
	mut obj := &Class_stdClass{
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
		else { return none }
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


fn init_registry() {
}

fn init() {
	init_registry()
}



pub fn init_wp_content_plugins_woocommerce_includes_class_wc_form_handler_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
