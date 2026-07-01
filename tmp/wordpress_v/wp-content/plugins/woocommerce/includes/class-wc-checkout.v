import rt

struct Class_WC_Checkout {
	rt.PhpObjectBase
pub mut:
		instance rt.PhpVal = rt.new_null()
		fields rt.PhpVal = rt.new_null()
		legacy_posted_data rt.PhpVal = rt.new_array()
		logged_in_customer rt.PhpVal = rt.new_null()
}

fn Class_WC_Checkout.instance() rt.PhpVal {
	if rt.is_true(rt.new_bool(// unsupported expression: Expr_StaticPropertyFetch.is_null())) {
		// unsupported assign target: Expr_StaticPropertyFetch
		rt.call_function('add_action', [rt.new_string('woocommerce_checkout_billing'), rt.create_array([rt.ArrayItem{ key: none, val: // unsupported expression: Expr_StaticPropertyFetch }, rt.ArrayItem{ key: none, val: 'checkout_form_billing' }])])
		rt.call_function('add_action', [rt.new_string('woocommerce_checkout_shipping'), rt.create_array([rt.ArrayItem{ key: none, val: // unsupported expression: Expr_StaticPropertyFetch }, rt.ArrayItem{ key: none, val: 'checkout_form_shipping' }])])
		rt.call_function('do_action', [rt.new_string('woocommerce_checkout_init'), // unsupported expression: Expr_StaticPropertyFetch])
	}
	return // unsupported expression: Expr_StaticPropertyFetch
}

fn (mut this Class_WC_Checkout) magic_isset(var_key rt.PhpVal) rt.PhpVal {
	return rt.call_function('in_array', [var_key.dup(), rt.create_array([rt.ArrayItem{ key: none, val: 'enable_signup' }, rt.ArrayItem{ key: none, val: 'enable_guest_checkout' }, rt.ArrayItem{ key: none, val: 'must_create_account' }, rt.ArrayItem{ key: none, val: 'checkout_fields' }, rt.ArrayItem{ key: none, val: 'posted' }, rt.ArrayItem{ key: none, val: 'shipping_method' }, rt.ArrayItem{ key: none, val: 'payment_method' }, rt.ArrayItem{ key: none, val: 'customer_id' }, rt.ArrayItem{ key: none, val: 'shipping_methods' }]), rt.new_bool(true)])
}

fn (mut this Class_WC_Checkout) magic_set(var_key rt.PhpVal, var_value rt.PhpVal)  {
	mut var_value_mutated := var_value
	mut switch_val_1 := var_key
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('enable_signup'))) {
		mut var_bool_value := rt.call_function('wc_string_to_bool', [var_value_mutated.dup()])
		if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
			rt.call_function('remove_filter', [rt.new_string('woocommerce_checkout_registration_enabled'), rt.new_string('__return_true'), rt.new_int(0)])
			rt.call_function('remove_filter', [rt.new_string('woocommerce_checkout_registration_enabled'), rt.new_string('__return_false'), rt.new_int(0)])
			rt.call_function('add_filter', [rt.new_string('woocommerce_checkout_registration_enabled'), if rt.is_true(var_bool_value) { rt.new_string('__return_true') } else { rt.new_string('__return_false') }, rt.new_int(0)])
		}
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('enable_guest_checkout'))) {
		var_bool_value = rt.call_function('wc_string_to_bool', [var_value_mutated.dup()])
		if rt.is_true(rt.identical(var_bool_value, this.is_registration_required())) {
			rt.call_function('remove_filter', [rt.new_string('woocommerce_checkout_registration_required'), rt.new_string('__return_true'), rt.new_int(0)])
			rt.call_function('remove_filter', [rt.new_string('woocommerce_checkout_registration_required'), rt.new_string('__return_false'), rt.new_int(0)])
			rt.call_function('add_filter', [rt.new_string('woocommerce_checkout_registration_required'), if rt.is_true(var_bool_value) { rt.new_string('__return_false') } else { rt.new_string('__return_true') }, rt.new_int(0)])
		}
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('checkout_fields'))) {
		this.fields = var_value_mutated.dup()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('shipping_methods'))) {
		rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'session'), 'set', [rt.new_string('chosen_shipping_methods'), var_value_mutated.dup()])
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('posted'))) {
		this.legacy_posted_data = var_value_mutated.dup()
	}
}

fn (mut this Class_WC_Checkout) magic_get(var_key rt.PhpVal)  {
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('in_array', [var_key.dup(), rt.create_array([rt.ArrayItem{ key: none, val: 'posted' }, rt.ArrayItem{ key: none, val: 'shipping_method' }, rt.ArrayItem{ key: none, val: 'payment_method' }]), rt.new_bool(true)])) && !rt.is_true(this.legacy_posted_data))) {
		this.legacy_posted_data = this.get_posted_data()
	}
	mut switch_val_2 := var_key
	if rt.is_true(rt.equal(switch_val_2, rt.new_string('enable_signup'))) {
		return this.is_registration_enabled()
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('enable_guest_checkout'))) {
		return rt.new_bool(!(rt.is_true(this.is_registration_required())))
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('must_create_account'))) {
		return rt.new_bool(rt.is_true(this.is_registration_required()) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_user_logged_in', []rt.PhpVal{}))))))
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('checkout_fields'))) {
		return this.get_checkout_fields('')
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('posted'))) {
		rt.call_function('wc_doing_it_wrong', [rt.new_string('WC_Checkout->posted'), rt.new_string('Use $_POST directly.'), rt.new_string('3.0.0')])
		return this.legacy_posted_data
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('shipping_method'))) {
		return this.legacy_posted_data.array_get('shipping_method')
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('payment_method'))) {
		return this.legacy_posted_data.array_get('payment_method')
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('customer_id'))) {
		return rt.call_function('apply_filters', [rt.new_string('woocommerce_checkout_customer_id'), rt.call_function('get_current_user_id', []rt.PhpVal{})])
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('shipping_methods'))) {
		return rt.cast_array(rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'session'), 'get', [rt.new_string('chosen_shipping_methods')]))
	}
}

fn (mut this Class_WC_Checkout) magic_clone()  {
	rt.call_function('wc_doing_it_wrong', [rt.new_string(@FN), rt.call_function('__', [rt.new_string('Cloning is forbidden.'), rt.new_string('woocommerce')]), rt.new_string('2.1')])
}

fn (mut this Class_WC_Checkout) magic_wakeup()  {
	rt.call_function('wc_doing_it_wrong', [rt.new_string(@FN), rt.call_function('__', [rt.new_string('Unserializing instances of this class is forbidden.'), rt.new_string('woocommerce')]), rt.new_string('2.1')])
}

fn (mut this Class_WC_Checkout) is_registration_required() rt.PhpVal {
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_checkout_registration_required'), // unsupported expression: Expr_BinaryOp_NotIdentical])
}

fn (mut this Class_WC_Checkout) is_registration_enabled() rt.PhpVal {
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_checkout_registration_enabled'), rt.identical(rt.new_string('yes'), rt.call_function('get_option', [rt.new_string('woocommerce_enable_signup_and_login_from_checkout')]))])
}

fn (mut this Class_WC_Checkout) initialize_checkout_fields()  {
	mut var_billing_country := this.get_value(rt.new_string('billing_country'))
	var_billing_country = if !rt.is_true(var_billing_country) { rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'countries'), 'get_base_country', []rt.PhpVal{}) } else { var_billing_country }
	mut var_allowed_countries := rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'countries'), 'get_allowed_countries', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_allowed_countries.dup().array_isset(var_billing_country.dup())))))) {
		var_billing_country = rt.call_function('current', [rt.func_array_keys(var_allowed_countries.dup())])
	}
	mut var_shipping_country := this.get_value(rt.new_string('shipping_country'))
	var_shipping_country = if !rt.is_true(var_shipping_country) { rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'countries'), 'get_base_country', []rt.PhpVal{}) } else { var_shipping_country }
	var_allowed_countries = rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'countries'), 'get_shipping_countries', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_allowed_countries.dup().array_isset(var_shipping_country.dup())))))) {
		var_shipping_country = rt.call_function('current', [rt.func_array_keys(var_allowed_countries.dup())])
	}
	this.fields = rt.create_array([rt.ArrayItem{ key: 'billing', val: rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'countries'), 'get_address_fields', [var_billing_country.dup(), rt.new_string('billing_')]) }, rt.ArrayItem{ key: 'shipping', val: rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'countries'), 'get_address_fields', [var_shipping_country.dup(), rt.new_string('shipping_')]) }, rt.ArrayItem{ key: 'account', val: rt.new_array() }, rt.ArrayItem{ key: 'order', val: rt.create_array([rt.ArrayItem{ key: 'order_comments', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'textarea' }, rt.ArrayItem{ key: 'class', val: rt.create_array([rt.ArrayItem{ key: none, val: 'notes' }]) }, rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('Order notes'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'placeholder', val: rt.call_function('esc_attr__', [rt.new_string('Notes about your order, e.g. special notes for delivery.'), rt.new_string('woocommerce')]) }]) }]) }])
	if rt.is_true(rt.identical(rt.new_string('no'), rt.call_function('get_option', [rt.new_string('woocommerce_registration_generate_username')]))) {
		this.fields.array_get_mut('account').array_set('account_username', rt.create_array([rt.ArrayItem{ key: 'type', val: 'text' }, rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('Account username'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'required', val: true }, rt.ArrayItem{ key: 'placeholder', val: rt.call_function('esc_attr__', [rt.new_string('Username'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'autocomplete', val: 'username' }]))
	}
	if rt.is_true(rt.identical(rt.new_string('no'), rt.call_function('get_option', [rt.new_string('woocommerce_registration_generate_password')]))) {
		this.fields.array_get_mut('account').array_set('account_password', rt.create_array([rt.ArrayItem{ key: 'type', val: 'password' }, rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('Create account password'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'required', val: true }, rt.ArrayItem{ key: 'placeholder', val: rt.call_function('esc_attr__', [rt.new_string('Password'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'autocomplete', val: 'new-password' }]))
	}
	this.fields = rt.call_function('apply_filters', [rt.new_string('woocommerce_checkout_fields'), this.fields])
	{
		mut iter_1 := this.fields.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_fields := item_1.val
			mut var_field_type := item_1.key
			rt.call_function('uasort', [this.fields.array_get(var_field_type), rt.new_string('wc_checkout_fields_uasort_comparison')])
			{
				mut iter_2 := var_fields.iterator()
				for {
					item_2 := iter_2.next() or { break }
					mut var_field := item_2.val
					mut var_single_field_type := item_2.key
					if !rt.is_true(var_field.array_get('label')) && !(!rt.is_true(var_field.array_get('placeholder'))) {
						this.fields.array_get_mut(var_field_type).array_get_mut(var_single_field_type).array_set('label', var_field.array_get('placeholder'))
						this.fields.array_get_mut(var_field_type).array_get_mut(var_single_field_type).array_set('label_class', rt.create_array([rt.ArrayItem{ key: none, val: 'screen-reader-text' }]))
					}
				}
			}
		}
	}
}

fn (mut this Class_WC_Checkout) get_checkout_fields(fieldset string) rt.PhpVal {
	if rt.is_true(rt.new_bool(this.fields.is_null())) {
		this.initialize_checkout_fields()
	}
	if var_fieldset.len > 0 && var_fieldset != '0' {
		return if !(this.fields.array_get(fieldset)).is_null() { this.fields.array_get(fieldset) } else { rt.new_array() }
	}
	return this.fields
}

fn (mut this Class_WC_Checkout) check_cart_items()  {
	rt.call_function('do_action', [rt.new_string('woocommerce_check_cart_items')])
}

fn (mut this Class_WC_Checkout) checkout_form_billing()  {
	rt.call_function('wc_get_template', [rt.new_string('checkout/form-billing.php'), rt.create_array([rt.ArrayItem{ key: 'checkout', val: rt.new_object('WC_Checkout', []string{}, &this) }])])
}

fn (mut this Class_WC_Checkout) checkout_form_shipping()  {
	rt.call_function('wc_get_template', [rt.new_string('checkout/form-shipping.php'), rt.create_array([rt.ArrayItem{ key: 'checkout', val: rt.new_object('WC_Checkout', []string{}, &this) }])])
}

fn (mut this Class_WC_Checkout) create_order(var_data rt.PhpVal) rt.PhpVal {
	mut var_data_mutated := var_data
	mut var_order_id := rt.call_function('apply_filters', [rt.new_string('woocommerce_create_order'), rt.new_null(), rt.new_object('WC_Checkout', []string{}, &this)])
	if rt.is_true(var_order_id) {
		return var_order_id.dup()
	}
	var_order_id = rt.call_function('absint', [rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'session'), 'get', [rt.new_string('order_awaiting_payment')])])
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	mut var_cart_hash := rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'cart'), 'get_cart_hash', []rt.PhpVal{})
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	mut var_available_gateways := rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'payment_gateways'), 'get_available_payment_gateways', []rt.PhpVal{})
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	mut var_order := if rt.is_true(var_order_id) { rt.call_function('wc_get_order', [var_order_id.dup()]) } else { rt.new_null() }
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(var_order) && rt.is_true(rt.call_method(var_order, 'has_cart_hash', [var_cart_hash.dup()])))) && rt.is_true(rt.call_method(var_order, 'has_status', [rt.create_array([rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_OrderStatus.pending() }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_OrderStatus.failed() }])])))) {
		rt.call_function('do_action', [rt.new_string('woocommerce_resume_order'), var_order_id.dup()])
		if rt.has_exception() { unsafe { goto catch_label_1 } }
		rt.call_method(var_order, 'remove_order_items', []rt.PhpVal{})
		if rt.has_exception() { unsafe { goto catch_label_1 } }
	} else {
		var_order = create_wc_order()
		if rt.has_exception() { unsafe { goto catch_label_1 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	mut var_fields_prefix := rt.create_array([rt.ArrayItem{ key: 'shipping', val: true }, rt.ArrayItem{ key: 'billing', val: true }])
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	mut var_shipping_fields := rt.create_array([rt.ArrayItem{ key: 'shipping_method', val: true }, rt.ArrayItem{ key: 'shipping_total', val: true }, rt.ArrayItem{ key: 'shipping_tax', val: true }])
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	{
		mut iter_1 := var_data_mutated.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_value := item_1.val
			mut var_key := item_1.key
			if rt.is_true(rt.call_function('is_callable', [rt.create_array([rt.ArrayItem{ key: none, val: var_order }, rt.ArrayItem{ key: none, val: "set_${var_key.to_string()}" }])])) {
				rt.call_method(var_order, "set_${var_key.to_string()}", [var_value.dup()])
				if rt.has_exception() { unsafe { goto catch_label_1 } }
				// unsupported statement: Stmt_Nop
				if rt.has_exception() { unsafe { goto catch_label_1 } }
			} else if var_fields_prefix.array_isset(rt.call_function('current', [rt.call_function('explode', [rt.new_string('_'), var_key.dup()])])) {
				if !(var_shipping_fields.array_isset(var_key)) {
					rt.call_method(var_order, 'update_meta_data', ['_' + (var_key).str(), var_value.dup()])
					if rt.has_exception() { unsafe { goto catch_label_1 } }
				}
				if rt.has_exception() { unsafe { goto catch_label_1 } }
			}
			if rt.has_exception() { unsafe { goto catch_label_1 } }
		}
	}
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	if var_data_mutated.array_isset(rt.new_string('billing_email')) {
		rt.call_method(var_order, 'hold_applied_coupons', [var_data_mutated.array_get('billing_email')])
		if rt.has_exception() { unsafe { goto catch_label_1 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	rt.call_method(var_order, 'set_created_via', [rt.new_string('checkout')])
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	rt.call_method(var_order, 'set_cart_hash', [var_cart_hash.dup()])
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	rt.call_method(var_order, 'set_customer_id', [rt.call_function('apply_filters', [rt.new_string('woocommerce_checkout_customer_id'), rt.call_function('get_current_user_id', []rt.PhpVal{})])])
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	rt.call_method(var_order, 'set_currency', [rt.call_function('get_woocommerce_currency', []rt.PhpVal{})])
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	rt.call_method(var_order, 'set_prices_include_tax', [rt.identical(rt.new_string('yes'), rt.call_function('get_option', [rt.new_string('woocommerce_prices_include_tax')]))])
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	rt.call_method(var_order, 'set_customer_ip_address', [fn () rt.PhpVal { mut temp := Class_WC_Geolocation{}; return temp.get_ip_address() }()])
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	rt.call_method(var_order, 'set_customer_user_agent', [rt.call_function('wc_get_user_agent', []rt.PhpVal{})])
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	rt.call_method(var_order, 'set_customer_note', [if var_data_mutated.array_isset(rt.new_string('order_comments')) { var_data_mutated.array_get('order_comments') } else { rt.new_string('') }])
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	rt.call_method(var_order, 'set_payment_method', [if var_available_gateways.array_isset(var_data_mutated.array_get('payment_method')) { var_available_gateways.array_get(var_data_mutated.array_get('payment_method')) } else { var_data_mutated.array_get('payment_method') }])
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	this.set_data_from_cart(var_order.dup())
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_method(var_order, 'has_cogs', []rt.PhpVal{})) && rt.is_true(this.cogs_is_enabled()))) {
		rt.call_method(var_order, 'calculate_cogs_total_value', []rt.PhpVal{})
		if rt.has_exception() { unsafe { goto catch_label_1 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	rt.call_function('do_action', [rt.new_string('woocommerce_checkout_create_order'), var_order.dup(), var_data_mutated.dup()])
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	var_order_id = rt.call_method(var_order, 'save', []rt.PhpVal{})
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	rt.call_function('do_action', [rt.new_string('woocommerce_checkout_update_order_meta'), var_order_id.dup(), var_data_mutated.dup()])
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	rt.call_function('do_action', [rt.new_string('woocommerce_checkout_order_created'), var_order.dup()])
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	return var_order_id.dup()
	unsafe { goto end_label_1 }

catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'Exception') {
		mut var_e := var_e_1.dup()
		if rt.is_true(rt.new_bool(rt.is_true(var_order) && rt.is_true(rt.new_bool(rt.instance_of(var_order, 'WC_Order'))))) {
			rt.call_function('wc_release_coupons_for_order', [var_order.dup()])
			rt.call_function('do_action', [rt.new_string('woocommerce_checkout_order_exception'), var_order.dup()])
		}
		return create_wp_error(rt.new_string('checkout-error'), rt.call_method(, 'getMessage', []rt.PhpVal{}))
		unsafe { goto end_label_1 }
	}
	else {
		rt.throw_exception(var_e_1)
		unsafe { goto end_label_1 }
	}

end_label_1:
	return rt.new_null()
}

fn (mut this Class_WC_Checkout) set_data_from_cart(var_order rt.PhpVal)  {
	mut var_order_mutated := var_order
	mut var_order_vat_exempt := rt.new_string()
	
}

fn (mut this Class_WC_Checkout) create_order_line_items(var_order rt.PhpVal, var_cart rt.PhpVal)  {
	mut var_order_mutated := var_order
}

fn (mut this Class_WC_Checkout) create_order_fee_lines(var_order rt.PhpVal, var_cart rt.PhpVal)  {
	mut var_order_mutated := var_order
}

fn (mut this Class_WC_Checkout) create_order_shipping_lines(var_order rt.PhpVal, var_chosen_shipping_methods rt.PhpVal, var_packages rt.PhpVal)  {
	mut var_order_mutated := var_order
	mut var_chosen_shipping_methods_mutated := var_chosen_shipping_methods
}

fn (mut this Class_WC_Checkout) create_order_tax_lines(var_order rt.PhpVal, var_cart rt.PhpVal)  {
	mut var_order_mutated := var_order
}

fn (mut this Class_WC_Checkout) create_order_coupon_lines(var_order rt.PhpVal, var_cart rt.PhpVal)  {
	mut var_order_mutated := var_order
}

fn (mut this Class_WC_Checkout) maybe_skip_fieldset(var_fieldset_key rt.PhpVal, var_data rt.PhpVal) bool {
	mut var_data_mutated := var_data
}

fn (mut this Class_WC_Checkout) get_posted_data() rt.PhpVal {
}

fn (mut this Class_WC_Checkout) validate_posted_data(var_data rt.PhpVal, var_errors rt.PhpVal)  {
	mut var_data_mutated := var_data
	mut var_errors_mutated := var_errors
}

fn (mut this Class_WC_Checkout) validate_checkout(var_data rt.PhpVal, var_errors rt.PhpVal)  {
	mut var_data_mutated := var_data
	mut var_errors_mutated := var_errors
}

fn (mut this Class_WC_Checkout) set_customer_address_fields(var_field rt.PhpVal, var_key rt.PhpVal, var_data rt.PhpVal)  {
	mut var_data_mutated := var_data
}

fn (mut this Class_WC_Checkout) update_session(var_data rt.PhpVal)  {
	mut var_data_mutated := var_data
}

fn (mut this Class_WC_Checkout) process_order_payment(var_order_id rt.PhpVal, var_payment_method rt.PhpVal)  {
	mut var_order_id_mutated := var_order_id
}

fn (mut this Class_WC_Checkout) process_order_without_payment(var_order_id rt.PhpVal)  {
	mut var_order_id_mutated := var_order_id
}

fn (mut this Class_WC_Checkout) process_customer(var_data rt.PhpVal)  {
	mut var_data_mutated := var_data
}

fn (mut this Class_WC_Checkout) send_ajax_failure_response()  {
}

fn (mut this Class_WC_Checkout) process_checkout()  {
}

fn (mut this Class_WC_Checkout) get_posted_address_data(var_key rt.PhpVal, type string) rt.PhpVal {
	mut type_mutated := type
}

fn (mut this Class_WC_Checkout) get_value(var_input rt.PhpVal) rt.PhpVal {
}

struct Class_WC_Order {
	rt.PhpObjectBase
}

struct Class_WC_Geolocation {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

fn create_wc_checkout() &Class_WC_Checkout {
	mut obj := &Class_WC_Checkout{
		PhpObjectBase: rt.PhpObjectBase{}
		instance: rt.new_null()
		fields: rt.new_null()
		legacy_posted_data: rt.new_array()
		logged_in_customer: rt.new_null()
	}
	return obj
}

fn create_wc_order() &Class_WC_Order {
	mut obj := &Class_WC_Order{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_geolocation() &Class_WC_Geolocation {
	mut obj := &Class_WC_Geolocation{
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

fn (mut this Class_WC_Checkout) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'instance' {
			return Class_WC_Checkout.instance()
		}
		'__isset' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.magic_isset(dispatch_arg_0)
		}
		'__set' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.magic_set(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'__get' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.magic_get(dispatch_arg_0)
			return rt.new_null()
		}
		'__clone' {
			this.magic_clone()
			return rt.new_null()
		}
		'__wakeup' {
			this.magic_wakeup()
			return rt.new_null()
		}
		'is_registration_required' {
			return this.is_registration_required()
		}
		'is_registration_enabled' {
			return this.is_registration_enabled()
		}
		'initialize_checkout_fields' {
			this.initialize_checkout_fields()
			return rt.new_null()
		}
		'get_checkout_fields' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_checkout_fields(dispatch_arg_0)
		}
		'check_cart_items' {
			this.check_cart_items()
			return rt.new_null()
		}
		'checkout_form_billing' {
			this.checkout_form_billing()
			return rt.new_null()
		}
		'checkout_form_shipping' {
			this.checkout_form_shipping()
			return rt.new_null()
		}
		'create_order' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.create_order(dispatch_arg_0)
		}
		'set_data_from_cart' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_data_from_cart(dispatch_arg_0)
			return rt.new_null()
		}
		'create_order_line_items' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.create_order_line_items(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'create_order_fee_lines' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.create_order_fee_lines(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'create_order_shipping_lines' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			this.create_order_shipping_lines(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'create_order_tax_lines' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.create_order_tax_lines(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'create_order_coupon_lines' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.create_order_coupon_lines(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'maybe_skip_fieldset' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(this.maybe_skip_fieldset(dispatch_arg_0, dispatch_arg_1))
		}
		'get_posted_data' {
			return this.get_posted_data()
		}
		'validate_posted_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.validate_posted_data(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'validate_checkout' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.validate_checkout(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'set_customer_address_fields' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			this.set_customer_address_fields(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'update_session' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.update_session(dispatch_arg_0)
			return rt.new_null()
		}
		'process_order_payment' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.process_order_payment(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'process_order_without_payment' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.process_order_without_payment(dispatch_arg_0)
			return rt.new_null()
		}
		'process_customer' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.process_customer(dispatch_arg_0)
			return rt.new_null()
		}
		'send_ajax_failure_response' {
			this.send_ajax_failure_response()
			return rt.new_null()
		}
		'process_checkout' {
			this.process_checkout()
			return rt.new_null()
		}
		'get_posted_address_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return this.get_posted_address_data(dispatch_arg_0, dispatch_arg_1)
		}
		'get_value' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_value(dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_WC_Checkout) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'instance' { return this.instance }
		'fields' { return this.fields }
		'legacy_posted_data' { return this.legacy_posted_data }
		'logged_in_customer' { return this.logged_in_customer }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_Checkout) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'instance' { this.instance = val; return true }
		'fields' { this.fields = val; return true }
		'legacy_posted_data' { this.legacy_posted_data = val; return true }
		'logged_in_customer' { this.logged_in_customer = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_WC_Order) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Order) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Order) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_Geolocation) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Geolocation) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Geolocation) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn init_registry() {
}

fn init() {
	init_registry()
}



pub fn init_wp_content_plugins_woocommerce_includes_class_wc_checkout_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
