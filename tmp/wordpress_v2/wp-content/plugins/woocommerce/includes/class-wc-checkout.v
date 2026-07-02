import rt

struct Class_WC_Checkout {
	rt.PhpObjectBase
pub mut:
	fields             rt.PhpVal = rt.new_null()
	legacy_posted_data rt.PhpVal = rt.new_array()
	logged_in_customer rt.PhpVal = rt.new_null()
}

fn init_static_wc_checkout() {
	rt.init_static_prop('WC_Checkout', 'instance', rt.new_null())
}

fn Class_WC_Checkout.instance() rt.PhpVal {
	if rt.is_true(rt.new_bool(rt.get_static_prop('WC_Checkout', 'instance').is_null())) {
		rt.set_static_prop('WC_Checkout', 'instance', rt.new_object('WC_Checkout', []string{},
			create_wc_checkout()))
		rt.call_function('add_action', [rt.new_string('woocommerce_checkout_billing'),
			rt.create_array([
				rt.ArrayItem{ key: none, val: rt.get_static_prop('WC_Checkout', 'instance') },
				rt.ArrayItem{ key: none, val: 'checkout_form_billing' },
			])])
		rt.call_function('add_action', [rt.new_string('woocommerce_checkout_shipping'),
			rt.create_array([
				rt.ArrayItem{ key: none, val: rt.get_static_prop('WC_Checkout', 'instance') },
				rt.ArrayItem{ key: none, val: 'checkout_form_shipping' },
			])])
		rt.call_function('do_action', [rt.new_string('woocommerce_checkout_init'),
			rt.get_static_prop('WC_Checkout', 'instance')])
	}
	return rt.get_static_prop('WC_Checkout', 'instance')
}

fn (mut this Class_WC_Checkout) magic_isset(var_key rt.PhpVal) rt.PhpVal {
	return rt.call_function('in_array', [var_key.clone(),
		rt.create_array([rt.ArrayItem{ key: none, val: 'enable_signup' },
			rt.ArrayItem{ key: none, val: 'enable_guest_checkout' },
			rt.ArrayItem{ key: none, val: 'must_create_account' },
			rt.ArrayItem{ key: none, val: 'checkout_fields' },
			rt.ArrayItem{ key: none, val: 'posted' }, rt.ArrayItem{
				key: none
				val: 'shipping_method'
			}, rt.ArrayItem{ key: none, val: 'payment_method' },
			rt.ArrayItem{ key: none, val: 'customer_id' }, rt.ArrayItem{
				key: none
				val: 'shipping_methods'
			}]),
		rt.new_bool(true)])
}

fn (mut this Class_WC_Checkout) magic_set(var_key rt.PhpVal, var_value rt.PhpVal) {
	mut var_value_mutated := var_value
	mut switch_val_1 := var_key
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('enable_signup'))) {
		mut var_bool_value := rt.call_function('wc_string_to_bool', [
			var_value_mutated.clone()])
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_bool_value,
			this.is_registration_enabled()))))
		{
			rt.call_function('remove_filter', [
				rt.new_string('woocommerce_checkout_registration_enabled'),
				rt.new_string('__return_true'),
				rt.new_int(0),
			])
			rt.call_function('remove_filter', [
				rt.new_string('woocommerce_checkout_registration_enabled'),
				rt.new_string('__return_false'),
				rt.new_int(0),
			])
			rt.call_function('add_filter', [
				rt.new_string('woocommerce_checkout_registration_enabled'),
				rt.new_string((if rt.is_true(var_bool_value) {
					'__return_true'
				} else {
					'__return_false'
				}).str()),
				rt.new_int(0),
			])
		}
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('enable_guest_checkout'))) {
		var_bool_value = rt.call_function('wc_string_to_bool', [
			var_value_mutated.clone()])
		if rt.is_true(rt.identical(var_bool_value, this.is_registration_required())) {
			rt.call_function('remove_filter', [
				rt.new_string('woocommerce_checkout_registration_required'),
				rt.new_string('__return_true'),
				rt.new_int(0),
			])
			rt.call_function('remove_filter', [
				rt.new_string('woocommerce_checkout_registration_required'),
				rt.new_string('__return_false'),
				rt.new_int(0),
			])
			rt.call_function('add_filter', [
				rt.new_string('woocommerce_checkout_registration_required'),
				rt.new_string((if rt.is_true(var_bool_value) {
					'__return_false'
				} else {
					'__return_true'
				}).str()),
				rt.new_int(0),
			])
		}
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('checkout_fields'))) {
		this.fields = var_value_mutated.clone()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('shipping_methods'))) {
		rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'session'), 'set', [
			rt.new_string('chosen_shipping_methods'),
			var_value_mutated.clone(),
		])
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('posted'))) {
		this.legacy_posted_data = var_value_mutated.clone()
	}
}

fn (mut this Class_WC_Checkout) magic_get(var_key rt.PhpVal) bool {
	if rt.is_true(rt.call_function('in_array', [var_key.clone(), rt.create_array([rt.ArrayItem{
		key: none
		val: 'posted'
	}, rt.ArrayItem{ key: none, val: 'shipping_method' }, rt.ArrayItem{
		key: none
		val: 'payment_method'
	}]), rt.new_bool(true)]))
		&& !rt.is_true(this.legacy_posted_data) {
		this.legacy_posted_data = this.get_posted_data()
	}
	mut switch_val_2 := var_key
	if rt.is_true(rt.equal(switch_val_2, rt.new_string('enable_signup'))) {
		return (this.is_registration_enabled()).to_bool()
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('enable_guest_checkout'))) {
		return !(rt.is_true(this.is_registration_required()))
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('must_create_account'))) {
		return rt.is_true(this.is_registration_required())
			&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_user_logged_in', []rt.PhpVal{})))))
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('checkout_fields'))) {
		return (this.get_checkout_fields('')).to_bool()
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('posted'))) {
		rt.call_function('wc_doing_it_wrong', [rt.new_string('WC_Checkout->posted'),
			rt.new_string('Use $_POST directly.'), rt.new_string('3.0.0')])
		return (this.legacy_posted_data).to_bool()
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('shipping_method'))) {
		return (this.legacy_posted_data.array_get(rt.new_string('shipping_method'))).to_bool()
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('payment_method'))) {
		return (this.legacy_posted_data.array_get(rt.new_string('payment_method'))).to_bool()
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('customer_id'))) {
		return (rt.call_function('apply_filters', [
			rt.new_string('woocommerce_checkout_customer_id'),
			rt.call_function('get_current_user_id', []rt.PhpVal{}),
		])).to_bool()
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('shipping_methods'))) {
		return (rt.cast_array(rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}),
			'session'), 'get', [rt.new_string('chosen_shipping_methods')]))).to_bool()
	}
	return false
}

fn (mut this Class_WC_Checkout) magic_clone() {
	rt.call_function('wc_doing_it_wrong', [rt.new_string(@FN),
		rt.call_function('__', [rt.new_string('Cloning is forbidden.'),
			rt.new_string('woocommerce')]),
		rt.new_string('2.1')])
}

fn (mut this Class_WC_Checkout) magic_wakeup() {
	rt.call_function('wc_doing_it_wrong', [rt.new_string(@FN),
		rt.call_function('__', [
			rt.new_string('Unserializing instances of this class is forbidden.'),
			rt.new_string('woocommerce'),
		]),
		rt.new_string('2.1')])
}

fn (mut this Class_WC_Checkout) is_registration_required() rt.PhpVal {
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_checkout_registration_required'),
		rt.new_bool(!rt.is_true(rt.identical(rt.new_string('yes'), rt.call_function('get_option', [
			rt.new_string('woocommerce_enable_guest_checkout'),
		])))),
	])
}

fn (mut this Class_WC_Checkout) is_registration_enabled() rt.PhpVal {
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_checkout_registration_enabled'),
		rt.identical(rt.new_string('yes'), rt.call_function('get_option', [
			rt.new_string('woocommerce_enable_signup_and_login_from_checkout'),
		])),
	])
}

fn (mut this Class_WC_Checkout) initialize_checkout_fields() {
	mut var_billing_country := this.get_value(rt.new_string('billing_country'))
	var_billing_country = if !rt.is_true(var_billing_country) {
		rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'countries'),
			'get_base_country', []rt.PhpVal{})
	} else {
		var_billing_country
	}
	mut var_allowed_countries := rt.call_method(rt.get_property(rt.call_function('WC',
		[]rt.PhpVal{}), 'countries'), 'get_allowed_countries', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_allowed_countries.clone().array_isset(var_billing_country.clone())))))) {
		var_billing_country = rt.call_function('current', [
			rt.func_array_keys(var_allowed_countries.clone()),
		])
	}
	mut var_shipping_country := this.get_value(rt.new_string('shipping_country'))
	var_shipping_country = if !rt.is_true(var_shipping_country) {
		rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'countries'),
			'get_base_country', []rt.PhpVal{})
	} else {
		var_shipping_country
	}
	var_allowed_countries = rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}),
		'countries'), 'get_shipping_countries', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_allowed_countries.clone().array_isset(var_shipping_country.clone())))))) {
		var_shipping_country = rt.call_function('current', [
			rt.func_array_keys(var_allowed_countries.clone()),
		])
	}
	this.fields = rt.create_array([
		rt.ArrayItem{ key: 'billing', val: rt.call_method(rt.get_property(rt.call_function('WC',
			[]rt.PhpVal{}), 'countries'), 'get_address_fields', [
			var_billing_country.clone(), rt.new_string('billing_')]) },
		rt.ArrayItem{ key: 'shipping', val: rt.call_method(rt.get_property(rt.call_function('WC',
			[]rt.PhpVal{}), 'countries'), 'get_address_fields', [
			var_shipping_country.clone(), rt.new_string('shipping_')]) },
		rt.ArrayItem{ key: 'account', val: rt.new_array() },
		rt.ArrayItem{ key: 'order', val: rt.create_array([rt.ArrayItem{ key: 'order_comments', val: rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'textarea' },
			rt.ArrayItem{ key: 'class', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'notes' },
			]) },
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('Order notes'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'placeholder', val: rt.call_function('esc_attr__', [
				rt.new_string('Notes about your order, e.g. special notes for delivery.'),
				rt.new_string('woocommerce'),
			]) },
		]) }]) },
	])
	if rt.is_true(rt.identical(rt.new_string('no'), rt.call_function('get_option', [
		rt.new_string('woocommerce_registration_generate_username'),
	])))
	{
		this.fields.array_get_mut('account').array_set('account_username', rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'text' },
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('Account username'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'required', val: true },
			rt.ArrayItem{ key: 'placeholder', val: rt.call_function('esc_attr__', [
				rt.new_string('Username'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'autocomplete', val: 'username' },
		]))
	}
	if rt.is_true(rt.identical(rt.new_string('no'), rt.call_function('get_option', [
		rt.new_string('woocommerce_registration_generate_password'),
	])))
	{
		this.fields.array_get_mut('account').array_set('account_password', rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'password' },
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('Create account password'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'required', val: true },
			rt.ArrayItem{ key: 'placeholder', val: rt.call_function('esc_attr__', [
				rt.new_string('Password'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'autocomplete', val: 'new-password' },
		]))
	}
	this.fields = rt.call_function('apply_filters', [
		rt.new_string('woocommerce_checkout_fields'),
		this.fields,
	])
	mut iter_1 := this.fields.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_fields := item_1.val
		mut var_field_type := item_1.key
		rt.call_function('uasort', [this.fields.array_get(var_field_type),
			rt.new_string('wc_checkout_fields_uasort_comparison')])
		mut iter_2 := var_fields.iterator()
		for {
			item_2 := iter_2.next() or { break }
			mut var_field := item_2.val
			mut var_single_field_type := item_2.key
			if !rt.is_true(var_field.array_get(rt.new_string('label')))
				&& !(!rt.is_true(var_field.array_get(rt.new_string('placeholder')))) {
				this.fields.array_get_mut(var_field_type).array_get_mut(var_single_field_type).array_set('label',
					var_field.array_get(rt.new_string('placeholder')))
				this.fields.array_get_mut(var_field_type).array_get_mut(var_single_field_type).array_set('label_class', rt.create_array([
					rt.ArrayItem{ key: none, val: 'screen-reader-text' },
				]))
			}
		}
	}
}

fn (mut this Class_WC_Checkout) get_checkout_fields(fieldset string) rt.PhpVal {
	if rt.is_true(rt.new_bool(this.fields.is_null())) {
		this.initialize_checkout_fields()
	}
	if var_fieldset.len > 0 && var_fieldset != '0' {
		return if !(this.fields.array_get(rt.new_string(fieldset))).is_null() {
			this.fields.array_get(rt.new_string(fieldset))
		} else {
			rt.new_array()
		}
	}
	return this.fields
}

fn (mut this Class_WC_Checkout) check_cart_items() {
	rt.call_function('do_action', [rt.new_string('woocommerce_check_cart_items')])
}

fn (mut this Class_WC_Checkout) checkout_form_billing() {
	rt.call_function('wc_get_template', [rt.new_string('checkout/form-billing.php'),
		rt.create_array([
			rt.ArrayItem{ key: 'checkout', val: rt.new_object('WC_Checkout', []string{}, &this) },
		])])
}

fn (mut this Class_WC_Checkout) checkout_form_shipping() {
	rt.call_function('wc_get_template', [rt.new_string('checkout/form-shipping.php'),
		rt.create_array([
			rt.ArrayItem{ key: 'checkout', val: rt.new_object('WC_Checkout', []string{}, &this) },
		])])
}

fn (mut this Class_WC_Checkout) create_order(var_data rt.PhpVal) rt.PhpVal {
	mut var_data_mutated := var_data
	mut var_order_id := rt.call_function('apply_filters', [
		rt.new_string('woocommerce_create_order'),
		rt.new_null(),
		rt.new_object('WC_Checkout', []string{}, &this),
	])
	if rt.is_true(var_order_id) {
		return var_order_id.clone()
	}
	var_order_id = rt.call_function('absint', [
		rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'session'), 'get', [
			rt.new_string('order_awaiting_payment'),
		]),
	])
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	mut var_cart_hash := rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}),
		'cart'), 'get_cart_hash', []rt.PhpVal{})
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	mut var_available_gateways := rt.call_method(rt.get_property(rt.call_function('WC',
		[]rt.PhpVal{}), 'payment_gateways'), 'get_available_payment_gateways', []rt.PhpVal{})
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	mut var_order := if rt.is_true(var_order_id) { rt.call_function('wc_get_order', [
			var_order_id.clone(),
		]) } else { rt.new_null() }
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	if rt.is_true(var_order)
		&& rt.is_true(rt.call_method(var_order, 'has_cart_hash', [var_cart_hash.clone()]))
		&& rt.is_true(rt.call_method(var_order, 'has_status', [rt.create_array([rt.ArrayItem{
		key: none
		val: Class_Automattic_WooCommerce_Enums_OrderStatus.pending()
	}, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_OrderStatus.failed() }])])) {
		rt.call_function('do_action', [rt.new_string('woocommerce_resume_order'),
			var_order_id.clone()])
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
		rt.call_method(var_order, 'remove_order_items', []rt.PhpVal{})
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
	} else {
		var_order = create_wc_order()
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
	mut var_fields_prefix := rt.create_array([rt.ArrayItem{ key: 'shipping', val: true },
		rt.ArrayItem{ key: 'billing', val: true }])
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	mut var_shipping_fields := rt.create_array([
		rt.ArrayItem{ key: 'shipping_method', val: true },
		rt.ArrayItem{ key: 'shipping_total', val: true },
		rt.ArrayItem{ key: 'shipping_tax', val: true },
	])
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	mut iter_3 := var_data_mutated.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_value := item_3.val
		mut var_key := item_3.key
		if rt.is_true(rt.call_function('is_callable', [
			rt.create_array([rt.ArrayItem{ key: none, val: var_order },
				rt.ArrayItem{ key: none, val: 'set_${var_key.to_string()}' }]),
		]))
		{
			rt.call_method(var_order, 'set_${var_key.to_string()}', [
				var_value.clone()])
			if rt.has_exception() {
				unsafe {
					goto catch_label_1
				}
			}
			if rt.has_exception() {
				unsafe {
					goto catch_label_1
				}
			}
		} else if var_fields_prefix.array_isset(rt.call_function('current', [
			rt.call_function('explode', [rt.new_string('_'), var_key.clone()]),
		]))
		{
			if !(var_shipping_fields.array_isset(var_key)) {
				rt.call_method(var_order, 'update_meta_data', [
					rt.new_string('_' + var_key.str()),
					var_value.clone(),
				])
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
		}
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
	if var_data_mutated.array_isset(rt.new_string('billing_email')) {
		rt.call_method(var_order, 'hold_applied_coupons', [
			var_data_mutated.array_get(rt.new_string('billing_email')),
		])
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
	rt.call_method(var_order, 'set_created_via', [rt.new_string('checkout')])
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	rt.call_method(var_order, 'set_cart_hash', [var_cart_hash.clone()])
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	rt.call_method(var_order, 'set_customer_id', [
		rt.call_function('apply_filters', [
			rt.new_string('woocommerce_checkout_customer_id'),
			rt.call_function('get_current_user_id', []rt.PhpVal{}),
		]),
	])
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	rt.call_method(var_order, 'set_currency', [
		rt.call_function('get_woocommerce_currency', []rt.PhpVal{}),
	])
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	rt.call_method(var_order, 'set_prices_include_tax', [
		rt.identical(rt.new_string('yes'), rt.call_function('get_option', [
			rt.new_string('woocommerce_prices_include_tax'),
		])),
	])
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	mut iife_temp_0 := Class_WC_Geolocation{}
	mut iife_result_0 := iife_temp_0.get_ip_address()
	rt.call_method(var_order, 'set_customer_ip_address', [iife_result_0])
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	rt.call_method(var_order, 'set_customer_user_agent', [
		rt.call_function('wc_get_user_agent', []rt.PhpVal{}),
	])
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	rt.call_method(var_order, 'set_customer_note', [if var_data_mutated.array_isset(rt.new_string('order_comments')) {
		var_data_mutated.array_get(rt.new_string('order_comments'))
	} else {
		rt.new_string('')
	}])
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	rt.call_method(var_order, 'set_payment_method', [if var_available_gateways.array_isset(var_data_mutated.array_get(rt.new_string('payment_method'))) {
		var_available_gateways.array_get(var_data_mutated.array_get(rt.new_string('payment_method')))
	} else {
		var_data_mutated.array_get(rt.new_string('payment_method'))
	}])
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	this.set_data_from_cart(var_order.clone())
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	if rt.is_true(rt.call_method(var_order, 'has_cogs', []rt.PhpVal{}))
		&& rt.is_true(this.cogs_is_enabled()) {
		rt.call_method(var_order, 'calculate_cogs_total_value', []rt.PhpVal{})
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
	rt.call_function('do_action', [rt.new_string('woocommerce_checkout_create_order'),
		var_order.clone(), var_data_mutated.clone()])
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	var_order_id = rt.call_method(var_order, 'save', []rt.PhpVal{})
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	rt.call_function('do_action', [
		rt.new_string('woocommerce_checkout_update_order_meta'),
		var_order_id.clone(),
		var_data_mutated.clone(),
	])
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	rt.call_function('do_action', [rt.new_string('woocommerce_checkout_order_created'),
		var_order.clone()])
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	return var_order_id.clone()
	unsafe {
		goto end_label_1
	}
	catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'Exception') {
		mut var_e := var_e_1.clone()
		if rt.is_true(var_order) && rt.is_true(rt.new_bool(rt.instance_of(var_order, 'WC_Order'))) {
			rt.call_function('wc_release_coupons_for_order', [
				var_order.clone()])
			rt.call_function('do_action', [
				rt.new_string('woocommerce_checkout_order_exception'),
				var_order.clone(),
			])
		}
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('checkout-error'), rt.call_method(var_e,
			'getMessage', []rt.PhpVal{})))
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
	return rt.new_null()
}

fn (mut this Class_WC_Checkout) set_data_from_cart(var_order rt.PhpVal) {
	mut var_order_mutated := var_order
	mut var_order_vat_exempt := rt.new_string((if rt.is_true(rt.call_method(rt.call_method(rt.get_property(rt.call_function('WC',
		[]rt.PhpVal{}), 'cart'), 'get_customer', []rt.PhpVal{}), 'get_is_vat_exempt', []rt.PhpVal{}))
	{
		'yes'
	} else {
		'no'
	}).str())
	rt.call_method(var_order_mutated, 'add_meta_data', [rt.new_string('is_vat_exempt'),
		var_order_vat_exempt.clone(), rt.new_bool(true)])
	rt.call_method(var_order_mutated, 'set_shipping_total', [
		rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'cart'),
			'get_shipping_total', []rt.PhpVal{}),
	])
	rt.call_method(var_order_mutated, 'set_discount_total', [
		rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'cart'),
			'get_discount_total', []rt.PhpVal{}),
	])
	rt.call_method(var_order_mutated, 'set_discount_tax', [
		rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'cart'),
			'get_discount_tax', []rt.PhpVal{}),
	])
	rt.call_method(var_order_mutated, 'set_cart_tax', [
		rt.add(rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'cart'),
			'get_cart_contents_tax', []rt.PhpVal{}), rt.call_method(rt.get_property(rt.call_function('WC',
			[]rt.PhpVal{}), 'cart'), 'get_fee_tax', []rt.PhpVal{})),
	])
	rt.call_method(var_order_mutated, 'set_shipping_tax', [
		rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'cart'),
			'get_shipping_tax', []rt.PhpVal{}),
	])
	rt.call_method(var_order_mutated, 'set_total', [
		rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'cart'), 'get_total', [
			rt.new_string('edit'),
		]),
	])
	this.create_order_line_items(var_order_mutated.clone(), rt.get_property(rt.call_function('WC',
		[]rt.PhpVal{}), 'cart'))
	this.create_order_fee_lines(var_order_mutated.clone(), rt.get_property(rt.call_function('WC',
		[]rt.PhpVal{}), 'cart'))
	this.create_order_shipping_lines(var_order_mutated.clone(), rt.call_method(rt.get_property(rt.call_function('WC',
		[]rt.PhpVal{}), 'session'), 'get', [rt.new_string('chosen_shipping_methods')]), rt.call_method(rt.call_method(rt.call_function('WC',
		[]rt.PhpVal{}), 'shipping', []rt.PhpVal{}), 'get_packages', []rt.PhpVal{}))
	this.create_order_tax_lines(var_order_mutated.clone(), rt.get_property(rt.call_function('WC',
		[]rt.PhpVal{}), 'cart'))
	this.create_order_coupon_lines(var_order_mutated.clone(), rt.get_property(rt.call_function('WC',
		[]rt.PhpVal{}), 'cart'))
}

fn (mut this Class_WC_Checkout) create_order_line_items(var_order rt.PhpVal, var_cart rt.PhpVal) {
	mut var_order_mutated := var_order
	mut iter_4 := rt.call_method(var_cart, 'get_cart', []rt.PhpVal{}).iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_values := item_4.val
		mut var_cart_item_key := item_4.key
		mut var_item := rt.call_function('apply_filters', [
			rt.new_string('woocommerce_checkout_create_order_line_item_object'),
			create_wc_order_item_product(),
			var_cart_item_key.clone(),
			var_values.clone(),
			var_order_mutated.clone(),
		])
		mut var_product := var_values.array_get(rt.new_string('data'))
		rt.set_property(var_item, 'legacy_values', var_values.clone())
		rt.set_property(var_item, 'legacy_cart_item_key', var_cart_item_key.clone())
		rt.call_method(var_item, 'set_props', [
			rt.create_array([
				rt.ArrayItem{ key: 'quantity', val: var_values.array_get(rt.new_string('quantity')) },
				rt.ArrayItem{
					key: 'variation'
					val: var_values.array_get(rt.new_string('variation'))
				},
				rt.ArrayItem{
					key: 'subtotal'
					val: var_values.array_get(rt.new_string('line_subtotal'))
				},
				rt.ArrayItem{ key: 'total', val: var_values.array_get(rt.new_string('line_total')) },
				rt.ArrayItem{
					key: 'subtotal_tax'
					val: var_values.array_get(rt.new_string('line_subtotal_tax'))
				},
				rt.ArrayItem{ key: 'total_tax', val: var_values.array_get(rt.new_string('line_tax')) },
				rt.ArrayItem{
					key: 'taxes'
					val: var_values.array_get(rt.new_string('line_tax_data'))
				},
			]),
		])
		if rt.is_true(var_product) {
			rt.call_method(var_item, 'set_props', [
				rt.create_array([
					rt.ArrayItem{ key: 'name', val: rt.call_method(var_product, 'get_name',
						[]rt.PhpVal{}) },
					rt.ArrayItem{ key: 'tax_class', val: rt.call_method(var_product,
						'get_tax_class', []rt.PhpVal{}) },
					rt.ArrayItem{
						key: 'product_id'
						val: if rt.is_true(rt.call_method(var_product, 'is_type', [
							Class_Automattic_WooCommerce_Enums_ProductType.variation(),
						]))
						{
							rt.call_method(var_product, 'get_parent_id', []rt.PhpVal{})
						} else {
							rt.call_method(var_product, 'get_id', []rt.PhpVal{})
						}
					},
					rt.ArrayItem{
						key: 'variation_id'
						val: if rt.is_true(rt.call_method(var_product, 'is_type', [
							Class_Automattic_WooCommerce_Enums_ProductType.variation(),
						]))
						{
							rt.call_method(var_product, 'get_id', []rt.PhpVal{})
						} else {
							rt.new_int(0)
						}
					},
				]),
			])
		}
		rt.call_method(var_item, 'set_backorder_meta', []rt.PhpVal{})
		rt.call_function('do_action', [
			rt.new_string('woocommerce_checkout_create_order_line_item'),
			var_item.clone(),
			var_cart_item_key.clone(),
			var_values.clone(),
			var_order_mutated.clone(),
		])
		rt.call_method(var_order_mutated, 'add_item', [var_item.clone()])
	}
}

fn (mut this Class_WC_Checkout) create_order_fee_lines(var_order rt.PhpVal, var_cart rt.PhpVal) {
	mut var_order_mutated := var_order
	mut iter_5 := rt.call_method(var_cart, 'get_fees', []rt.PhpVal{}).iterator()
	for {
		item_5 := iter_5.next() or { break }
		mut var_fee := item_5.val
		mut var_fee_key := item_5.key
		mut var_item := create_wc_order_item_fee()
		rt.set_property(var_item, 'legacy_fee', var_fee.clone())
		rt.set_property(var_item, 'legacy_fee_key', var_fee_key.clone())
		rt.call_method(var_item, 'set_props', [
			rt.create_array([
				rt.ArrayItem{ key: 'name', val: rt.get_property(var_fee, 'name') },
				rt.ArrayItem{
					key: 'tax_class'
					val: if rt.is_true(rt.get_property(var_fee, 'taxable')) {
						rt.get_property(var_fee, 'tax_class')
					} else {
						rt.new_int(0)
					}
				},
				rt.ArrayItem{ key: 'amount', val: rt.get_property(var_fee, 'amount') },
				rt.ArrayItem{ key: 'total', val: rt.get_property(var_fee, 'total') },
				rt.ArrayItem{ key: 'total_tax', val: rt.get_property(var_fee, 'tax') },
				rt.ArrayItem{ key: 'taxes', val: rt.create_array([
					rt.ArrayItem{ key: 'total', val: rt.get_property(var_fee, 'tax_data') },
				]) },
			]),
		])
		rt.call_function('do_action', [
			rt.new_string('woocommerce_checkout_create_order_fee_item'),
			var_item.clone(),
			var_fee_key.clone(),
			var_fee.clone(),
			var_order_mutated.clone(),
		])
		rt.call_method(var_order_mutated, 'add_item', [var_item.clone()])
	}
}

fn (mut this Class_WC_Checkout) create_order_shipping_lines(var_order rt.PhpVal, var_chosen_shipping_methods rt.PhpVal, var_packages rt.PhpVal) {
	mut var_order_mutated := var_order
	mut var_chosen_shipping_methods_mutated := var_chosen_shipping_methods
	mut iter_6 := var_packages.iterator()
	for {
		item_6 := iter_6.next() or { break }
		mut var_package := item_6.val
		mut var_package_key := item_6.key
		if var_chosen_shipping_methods_mutated.array_isset(var_package_key)
			&& var_package.array_get(rt.new_string('rates')).array_isset(var_chosen_shipping_methods_mutated.array_get(var_package_key)) {
			mut var_shipping_rate :=
				var_package.array_get(rt.new_string('rates')).array_get(var_chosen_shipping_methods_mutated.array_get(var_package_key))
			mut var_item := create_wc_order_item_shipping()
			rt.set_property(var_item, 'legacy_package_key', var_package_key.clone())
			rt.call_method(var_item, 'set_props', [
				rt.create_array([
					rt.ArrayItem{ key: 'method_title', val: rt.get_property(var_shipping_rate,
						'label') },
					rt.ArrayItem{ key: 'method_id', val: rt.get_property(var_shipping_rate,
						'method_id') },
					rt.ArrayItem{ key: 'instance_id', val: rt.get_property(var_shipping_rate,
						'instance_id') },
					rt.ArrayItem{ key: 'total', val: rt.call_function('wc_format_decimal', [
						rt.get_property(var_shipping_rate, 'cost'),
					]) },
					rt.ArrayItem{ key: 'taxes', val: rt.create_array([
						rt.ArrayItem{ key: 'total', val: rt.get_property(var_shipping_rate, 'taxes') },
					]) },
					rt.ArrayItem{ key: 'tax_status', val: rt.get_property(var_shipping_rate,
						'tax_status') },
				]),
			])
			mut iter_7 :=
				rt.call_method(var_shipping_rate, 'get_meta_data', []rt.PhpVal{}).iterator()
			for {
				item_7 := iter_7.next() or { break }
				mut var_value := item_7.val
				mut var_key := item_7.key
				rt.call_method(var_item, 'add_meta_data', [var_key.clone(),
					var_value.clone(), rt.new_bool(true)])
			}
			rt.call_function('do_action', [
				rt.new_string('woocommerce_checkout_create_order_shipping_item'),
				var_item.clone(),
				var_package_key.clone(),
				var_package.clone(),
				var_order_mutated.clone(),
			])
			rt.call_method(var_order_mutated, 'add_item', [var_item.clone()])
		}
	}
}

fn (mut this Class_WC_Checkout) create_order_tax_lines(var_order rt.PhpVal, var_cart rt.PhpVal) {
	mut var_order_mutated := var_order
	mut iter_8 := rt.func_array_keys(rt.add(rt.add(rt.call_method(var_cart,
		'get_cart_contents_taxes', []rt.PhpVal{}), rt.call_method(var_cart, 'get_shipping_taxes',
		[]rt.PhpVal{})), rt.call_method(var_cart, 'get_fee_taxes', []rt.PhpVal{}))).iterator()
	for {
		item_8 := iter_8.next() or { break }
		mut var_tax_rate_id := item_8.val
		if rt.is_true(var_tax_rate_id)
			&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('apply_filters', [rt.new_string('woocommerce_cart_remove_taxes_zero_rate_id'), rt.new_string('zero-rated')]), var_tax_rate_id)))) {
			mut var_item := create_wc_order_item_tax()
			mut iife_temp_1 := Class_WC_Tax{}
			mut iife_result_1 := iife_temp_1.get_rate_code(var_tax_rate_id.clone())
			mut iife_temp_2 := Class_WC_Tax{}
			mut iife_result_2 := iife_temp_2.get_rate_label(var_tax_rate_id.clone())
			mut iife_temp_3 := Class_WC_Tax{}
			mut iife_result_3 := iife_temp_3.is_compound(var_tax_rate_id.clone())
			mut iife_temp_4 := Class_WC_Tax{}
			mut iife_result_4 := iife_temp_4.get_rate_percent_value(var_tax_rate_id.clone())
			rt.call_method(var_item, 'set_props', [
				rt.create_array([rt.ArrayItem{ key: 'rate_id', val: var_tax_rate_id },
					rt.ArrayItem{ key: 'tax_total', val: rt.call_method(var_cart, 'get_tax_amount', [
						var_tax_rate_id.clone(),
					]) }, rt.ArrayItem{ key: 'shipping_tax_total', val: rt.call_method(var_cart,
						'get_shipping_tax_amount', [
						var_tax_rate_id.clone(),
					]) }, rt.ArrayItem{ key: 'rate_code', val: iife_result_1 },
					rt.ArrayItem{ key: 'label', val: iife_result_2 },
					rt.ArrayItem{ key: 'compound', val: iife_result_3 },
					rt.ArrayItem{ key: 'rate_percent', val: iife_result_4 }]),
			])
			rt.call_function('do_action', [
				rt.new_string('woocommerce_checkout_create_order_tax_item'),
				var_item.clone(),
				var_tax_rate_id.clone(),
				var_order_mutated.clone(),
			])
			rt.call_method(var_order_mutated, 'add_item', [var_item.clone()])
		}
	}
}

fn (mut this Class_WC_Checkout) create_order_coupon_lines(var_order rt.PhpVal, var_cart rt.PhpVal) {
	mut var_order_mutated := var_order
	mut iter_9 := rt.call_method(var_cart, 'get_coupons', []rt.PhpVal{}).iterator()
	for {
		item_9 := iter_9.next() or { break }
		mut var_coupon := item_9.val
		mut var_code := item_9.key
		mut var_item := create_wc_order_item_coupon()
		rt.call_method(var_item, 'set_props', [
			rt.create_array([rt.ArrayItem{ key: 'code', val: var_code },
				rt.ArrayItem{ key: 'discount', val: rt.call_method(var_cart,
					'get_coupon_discount_amount', [var_code.clone()]) },
				rt.ArrayItem{ key: 'discount_tax', val: rt.call_method(var_cart,
					'get_coupon_discount_tax_amount', [var_code.clone()]) }]),
		])
		mut var_coupon_info := rt.call_method(var_coupon, 'get_short_info', []rt.PhpVal{})
		rt.call_method(var_item, 'add_meta_data', [rt.new_string('coupon_info'),
			var_coupon_info.clone()])
		rt.call_function('do_action', [
			rt.new_string('woocommerce_checkout_create_order_coupon_item'),
			var_item.clone(),
			var_code.clone(),
			var_coupon.clone(),
			var_order_mutated.clone(),
		])
		rt.call_method(var_order_mutated, 'add_item', [var_item.clone()])
	}
}

fn (mut this Class_WC_Checkout) maybe_skip_fieldset(var_fieldset_key rt.PhpVal, var_data rt.PhpVal) bool {
	mut var_data_mutated := var_data
	if rt.is_true(rt.identical(rt.new_string('shipping'), var_fieldset_key))
		&& rt.is_true(rt.new_bool(!(rt.is_true(var_data_mutated.array_get(rt.new_string('ship_to_different_address'))))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'cart'), 'needs_shipping_address', []rt.PhpVal{}))))) {
		return true
	}
	if rt.is_true(rt.identical(rt.new_string('account'), var_fieldset_key))
		&& rt.is_true(rt.call_function('is_user_logged_in', []rt.PhpVal{}))
		|| (rt.is_true(rt.new_bool(!(rt.is_true(this.is_registration_required()))))
		&& !rt.is_true(var_data_mutated.array_get(rt.new_string('createaccount')))) {
		return true
	}
	return false
}

fn (mut this Class_WC_Checkout) get_posted_data() rt.PhpVal {
	mut var_data := rt.create_array([
		rt.ArrayItem{
			key: 'terms'
			val: rt.new_int((rt.new_bool(rt.get_superglobal('_POST').array_isset(rt.new_string('terms')))).to_i64())
		},
		rt.ArrayItem{
			key: 'terms-field'
			val: rt.new_int((rt.new_bool(rt.get_superglobal('_POST').array_isset(rt.new_string('terms-field')))).to_i64())
		},
		rt.ArrayItem{ key: 'createaccount', val: i64(if rt.is_true(this.is_registration_enabled()) {
			!(!rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('createaccount'))))
		} else {
			false
		}) },
		rt.ArrayItem{
			key: 'payment_method'
			val: if rt.get_superglobal('_POST').array_isset(rt.new_string('payment_method')) { rt.call_function('wc_clean', [
					rt.call_function('wp_unslash', [
						rt.get_superglobal('_POST').array_get(rt.new_string('payment_method')),
					]),
				]) } else { rt.new_string('') }
		},
		rt.ArrayItem{
			key: 'shipping_method'
			val: if rt.get_superglobal('_POST').array_isset(rt.new_string('shipping_method')) { rt.call_function('wc_clean', [
					rt.call_function('wp_unslash', [
						rt.get_superglobal('_POST').array_get(rt.new_string('shipping_method')),
					]),
				]) } else { rt.new_string('') }
		},
		rt.ArrayItem{
			key: 'ship_to_different_address'
			val:
				!(!rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('ship_to_different_address'))))
				&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_ship_to_billing_address_only', []rt.PhpVal{})))))
		},
		rt.ArrayItem{
			key: 'woocommerce_checkout_update_totals'
			val: rt.new_bool(rt.get_superglobal('_POST').array_isset(rt.new_string('woocommerce_checkout_update_totals')))
		},
	])
	mut var_skipped := rt.new_array()
	mut var_form_was_shown :=
		rt.new_bool(rt.get_superglobal('_POST').array_isset(rt.new_string('woocommerce-process-checkout-nonce')))
	mut iter_10 := this.get_checkout_fields('').iterator()
	for {
		item_10 := iter_10.next() or { break }
		mut var_fieldset := item_10.val
		mut var_fieldset_key := item_10.key
		if this.maybe_skip_fieldset(var_fieldset_key.clone(), var_data.clone()) {
			var_skipped << var_fieldset_key.clone()
			continue
		}
		mut iter_11 := var_fieldset.iterator()
		for {
			item_11 := iter_11.next() or { break }
			mut var_field := item_11.val
			mut var_key := item_11.key
			mut var_type := rt.call_function('sanitize_title', [if var_field.array_isset(rt.new_string('type')) {
				var_field.array_get(rt.new_string('type'))
			} else {
				rt.new_string('text')
			}])
			if rt.get_superglobal('_POST').array_isset(var_key)
				&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), rt.get_superglobal('_POST').array_get(var_key))))) {
				mut var_value := rt.call_function('wp_unslash', [
					rt.get_superglobal('_POST').array_get(var_key)])
			} else if var_field.array_isset(rt.new_string('default'))
				&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('checkbox'), var_type))))
				&& rt.is_true(rt.new_bool(!(rt.is_true(var_form_was_shown)))) {
				var_value = var_field.array_get(rt.new_string('default'))
			} else {
				var_value = rt.new_string('')
			}
			if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), var_value)))) {
				mut switch_val_3 := var_type
				if rt.is_true(rt.equal(switch_val_3, rt.new_string('checkbox'))) {
					var_value = rt.new_int(1)
				} else if rt.is_true(rt.equal(switch_val_3, rt.new_string('multiselect'))) {
					var_value = rt.call_function('implode', [
						rt.new_string(', '), rt.call_function('wc_clean', [
							var_value.clone()])])
				} else if rt.is_true(rt.equal(switch_val_3, rt.new_string('textarea'))) {
					var_value = rt.call_function('wc_sanitize_textarea', [
						var_value.clone()])
				} else if rt.is_true(rt.equal(switch_val_3, rt.new_string('password'))) {
					if rt.is_true(var_data.array_get(rt.new_string('createaccount')))
						&& rt.is_true(rt.identical(rt.new_string('account_password'), var_key)) {
						var_value = rt.call_function('wp_slash', [
							var_value.clone()])
					}
				} else {
					var_value = rt.call_function('wc_clean', [
						var_value.clone()])
				}
			}
			var_data.array_set(var_key, rt.call_function('apply_filters', [
				rt.new_string('woocommerce_process_checkout_' + var_type.str() + '_field'),
				rt.call_function('apply_filters', [
					rt.new_string('woocommerce_process_checkout_field_' + var_key.str()),
					var_value.clone(),
				]),
			]))
		}
	}
	if rt.is_true(rt.call_function('in_array', [rt.new_string('shipping'), rt.create_array_from_list(var_skipped), rt.new_bool(true)]))
		&& rt.is_true(rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'cart'), 'needs_shipping_address', []rt.PhpVal{}))
		|| rt.is_true(rt.call_function('wc_ship_to_billing_address_only', []rt.PhpVal{})) {
		mut iter_12 := this.get_checkout_fields('shipping').iterator()
		for {
			item_12 := iter_12.next() or { break }
			mut var_field := item_12.val
			mut var_key := item_12.key
			var_data.array_set(var_key, if var_data.array_isset('billing_' +
				(rt.call_function('substr', [var_key.clone(), rt.new_int(9)])).str())
			{
				var_data.array_get(rt.new_string('billing_' +
					(rt.call_function('substr', [var_key.clone(), rt.new_int(9)])).str()))
			} else {
				rt.new_string('')
			})
		}
	}
	this.legacy_posted_data = var_data.clone()
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_checkout_posted_data'),
		var_data.clone(),
	])
}

fn (mut this Class_WC_Checkout) validate_posted_data(var_data rt.PhpVal, var_errors rt.PhpVal) {
	mut var_data_mutated := var_data
	mut var_errors_mutated := var_errors
	mut iter_13 := this.get_checkout_fields('').iterator()
	for {
		item_13 := iter_13.next() or { break }
		mut var_fieldset := item_13.val
		mut var_fieldset_key := item_13.key
		mut var_validate_fieldset := rt.new_bool(true)
		if this.maybe_skip_fieldset(var_fieldset_key.clone(), var_data_mutated.clone()) {
			var_validate_fieldset = rt.new_bool(false)
		}
		mut iter_14 := var_fieldset.iterator()
		for {
			item_14 := iter_14.next() or { break }
			mut var_field := item_14.val
			mut var_key := item_14.key
			if !(var_data_mutated.array_isset(var_key)) {
				continue
			}
			mut var_required :=
				rt.new_bool(!(!rt.is_true(var_field.array_get(rt.new_string('required')))))
			mut var_format := rt.call_function('array_filter', [if var_field.array_isset(rt.new_string('validate')) {
				rt.cast_array(var_field.array_get(rt.new_string('validate')))
			} else {
				rt.new_array()
			}])
			mut var_field_label := if var_field.array_isset(rt.new_string('label')) {
				var_field.array_get(rt.new_string('label'))
			} else {
				rt.new_string('')
			}
			if rt.is_true(var_validate_fieldset) && var_field.array_isset(rt.new_string('type'))
				&& rt.is_true(rt.identical(rt.new_string('country'), var_field.array_get(rt.new_string('type'))))
				&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), var_data_mutated.array_get(var_key)))))
				&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'countries'), 'country_exists', [var_data_mutated.array_get(var_key)]))))) {
				var_errors_mutated.add(rt.new_string(var_key.str() + '_validation'), rt.call_function('sprintf', [
					rt.call_function('__', [
						rt.new_string("'%s' is not a valid country code."),
						rt.new_string('woocommerce'),
					]),
					var_data_mutated.array_get(var_key),
				]))
			}
			mut switch_val_4 := var_fieldset_key
			if rt.is_true(rt.equal(switch_val_4, rt.new_string('shipping'))) {
				var_field_label = rt.call_function('sprintf', [
					rt.call_function('_x', [rt.new_string('Shipping %s'),
						rt.new_string('checkout-validation'),
						rt.new_string('woocommerce')]),
					var_field_label.clone(),
				])
			} else if rt.is_true(rt.equal(switch_val_4, rt.new_string('billing'))) {
				var_field_label = rt.call_function('sprintf', [
					rt.call_function('_x', [rt.new_string('Billing %s'),
						rt.new_string('checkout-validation'),
						rt.new_string('woocommerce')]),
					var_field_label.clone(),
				])
			}
			if rt.is_true(rt.call_function('in_array', [rt.new_string('postcode'),
				var_format.clone(), rt.new_bool(true)]))
			{
				mut var_country := if var_data_mutated.array_isset(var_fieldset_key.str() +
					'_country')
				{
					var_data_mutated.array_get(rt.new_string(var_fieldset_key.str() + '_country'))
				} else {
					rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}),
						'customer'), 'get_${var_fieldset_key.to_string()}_country', []rt.PhpVal{})
				}
				var_data_mutated.array_set(var_key, rt.call_function('wc_format_postcode', [
					var_data_mutated.array_get(var_key),
					var_country.clone(),
				]))
				mut iife_temp_5 := Class_WC_Validation{}
				mut iife_result_5 := iife_temp_5.is_postcode(var_data_mutated.array_get(var_key),
					var_country.clone())
				if rt.is_true(var_validate_fieldset)
					&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), var_data_mutated.array_get(var_key)))))
					&& rt.is_true(rt.new_bool(!(rt.is_true(iife_result_5)))) {
					mut switch_val_5 := var_country
					if rt.is_true(rt.equal(switch_val_5, rt.new_string('IE'))) {
						mut var_postcode_validation_notice := rt.call_function('sprintf', [
							rt.call_function('__', [
								rt.new_string('%1$s is not valid. You can look up the correct Eircode <a target="_blank" href="%2$s">here</a>.'),
								rt.new_string('woocommerce'),
							]),
							rt.new_string('<strong>' +
								(rt.call_function('esc_html', [var_field_label.clone()])).str() +
								'</strong>'),
							rt.new_string('https://finder.eircode.ie'),
						])
					} else {
						var_postcode_validation_notice = rt.call_function('sprintf', [
							rt.call_function('__', [
								rt.new_string('%s is not a valid postcode / ZIP.'),
								rt.new_string('woocommerce'),
							]),
							rt.new_string('<strong>' +
								(rt.call_function('esc_html', [var_field_label.clone()])).str() +
								'</strong>'),
						])
					}
					var_errors_mutated.add(rt.new_string(var_key.str() + '_validation'), rt.call_function('apply_filters', [
						rt.new_string('woocommerce_checkout_postcode_validation_notice'),
						var_postcode_validation_notice.clone(),
						var_country.clone(),
						var_data_mutated.array_get(var_key),
					]), rt.create_array([rt.ArrayItem{ key: 'id', val: var_key }]))
				}
			}
			if rt.is_true(rt.call_function('in_array', [rt.new_string('phone'),
				var_format.clone(), rt.new_bool(true)]))
			{
				var_data_mutated.array_set(var_key, rt.call_function('wc_remove_non_displayable_chars', [
					var_data_mutated.array_get(var_key),
				]))
				mut iife_temp_6 := Class_WC_Validation{}
				mut iife_result_6 := iife_temp_6.is_phone(var_data_mutated.array_get(var_key))
				if rt.is_true(var_validate_fieldset)
					&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), var_data_mutated.array_get(var_key)))))
					&& rt.is_true(rt.new_bool(!(rt.is_true(iife_result_6)))) {
					var_errors_mutated.add(rt.new_string(var_key.str() + '_validation'), rt.call_function('sprintf', [
						rt.call_function('__', [
							rt.new_string('%s is not a valid phone number.'),
							rt.new_string('woocommerce'),
						]),
						rt.new_string('<strong>' +
							(rt.call_function('esc_html', [var_field_label.clone()])).str() +
							'</strong>'),
					]), rt.create_array([rt.ArrayItem{ key: 'id', val: var_key }]))
				}
			}
			if rt.is_true(rt.call_function('in_array', [rt.new_string('email'), var_format.clone(), rt.new_bool(true)]))
				&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), var_data_mutated.array_get(var_key))))) {
				mut var_email_is_valid := rt.call_function('is_email', [
					var_data_mutated.array_get(var_key),
				])
				var_data_mutated.array_set(var_key, rt.call_function('sanitize_email', [
					var_data_mutated.array_get(var_key),
				]))
				if rt.is_true(var_validate_fieldset)
					&& rt.is_true(rt.new_bool(!(rt.is_true(var_email_is_valid)))) {
					var_errors_mutated.add(rt.new_string(var_key.str() + '_validation'), rt.call_function('sprintf', [
						rt.call_function('__', [
							rt.new_string('%s is not a valid email address.'),
							rt.new_string('woocommerce'),
						]),
						rt.new_string('<strong>' +
							(rt.call_function('esc_html', [var_field_label.clone()])).str() +
							'</strong>'),
					]), rt.create_array([rt.ArrayItem{ key: 'id', val: var_key }]))
					continue
				}
			}
			if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), var_data_mutated.array_get(var_key)))))
				&& rt.is_true(rt.call_function('in_array', [rt.new_string('state'), var_format.clone(), rt.new_bool(true)])) {
				var_country = if var_data_mutated.array_isset(var_fieldset_key.str() + '_country') {
					var_data_mutated.array_get(rt.new_string(var_fieldset_key.str() + '_country'))
				} else {
					rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}),
						'customer'), 'get_${var_fieldset_key.to_string()}_country', []rt.PhpVal{})
				}
				mut var_valid_states := rt.call_method(rt.get_property(rt.call_function('WC',
					[]rt.PhpVal{}), 'countries'), 'get_states', [
					var_country.clone()])
				if !(!rt.is_true(var_valid_states)) && var_valid_states.clone().is_array()
					&& var_valid_states.clone().array_count() > 0 {
					mut var_valid_state_values := rt.call_function('array_map', [
						rt.new_string('wc_strtoupper'),
						rt.call_function('array_flip', [
							rt.call_function('array_map', [
								rt.new_string('wc_strtoupper'),
								var_valid_states.clone(),
							]),
						]),
					])
					var_data_mutated.array_set(var_key, rt.call_function('wc_strtoupper', [
						var_data_mutated.array_get(var_key),
					]))
					if var_valid_state_values.array_isset(var_data_mutated.array_get(var_key)) {
						var_data_mutated.array_set(var_key,
							var_valid_state_values.array_get(var_data_mutated.array_get(var_key)))
					}
					if rt.is_true(var_validate_fieldset)
						&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_data_mutated.array_get(var_key), var_valid_state_values.clone(), rt.new_bool(true)]))))) {
						var_errors_mutated.add(rt.new_string(var_key.str() + '_validation'), rt.call_function('sprintf', [
							rt.call_function('__', [
								rt.new_string('%1$s is not valid. Please enter one of the following: %2$s'),
								rt.new_string('woocommerce'),
							]),
							rt.new_string('<strong>' +
								(rt.call_function('esc_html', [var_field_label.clone()])).str() +
								'</strong>'),
							rt.call_function('implode', [
								rt.new_string(', '),
								var_valid_states.clone(),
							]),
						]), rt.create_array([rt.ArrayItem{ key: 'id', val: var_key }]))
					}
				}
			}
			if rt.is_true(var_validate_fieldset) && rt.is_true(var_required)
				&& rt.is_true(rt.identical(rt.new_string(''), var_data_mutated.array_get(var_key))) {
				var_errors_mutated.add(rt.new_string(var_key.str() + '_required'), rt.call_function('apply_filters', [
					rt.new_string('woocommerce_checkout_required_field_notice'),
					rt.call_function('sprintf', [
						rt.call_function('__', [rt.new_string('%s is a required field.'),
							rt.new_string('woocommerce')]),
						rt.new_string('<strong>' +
							(rt.call_function('esc_html', [var_field_label.clone()])).str() +
							'</strong>'),
					]),
					var_field_label.clone(),
					var_key.clone(),
				]), rt.create_array([rt.ArrayItem{ key: 'id', val: var_key }]))
			}
		}
	}
}

fn (mut this Class_WC_Checkout) validate_checkout(var_data rt.PhpVal, var_errors rt.PhpVal) {
	mut var_data_mutated := var_data
	mut var_errors_mutated := var_errors
	this.validate_posted_data(var_data_mutated.clone(), var_errors_mutated.clone())
	this.check_cart_items()
	if !rt.is_true(var_data_mutated.array_get(rt.new_string('woocommerce_checkout_update_totals')))
		&& !rt.is_true(var_data_mutated.array_get(rt.new_string('terms')))
		&& !(!rt.is_true(var_data_mutated.array_get(rt.new_string('terms-field')))) {
		var_errors_mutated.add(rt.new_string('terms'), rt.call_function('__', [
			rt.new_string('Please read and accept the terms and conditions to proceed with your order.'),
			rt.new_string('woocommerce'),
		]), rt.create_array([rt.ArrayItem{ key: 'id', val: 'terms' }]))
	}
	if rt.is_true(rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'cart'),
		'needs_shipping', []rt.PhpVal{}))
	{
		mut var_shipping_country := if var_data_mutated.array_isset(rt.new_string('shipping_country')) {
			var_data_mutated.array_get(rt.new_string('shipping_country'))
		} else {
			rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'customer'),
				'get_shipping_country', []rt.PhpVal{})
		}
		if !rt.is_true(var_shipping_country)
			&& rt.is_true(rt.new_bool(!(rt.is_true(var_errors_mutated.get_error_data(rt.new_string('billing_country_required')))))) {
			var_errors_mutated.add(rt.new_string('shipping'), rt.call_function('__', [
				rt.new_string('Please enter an address to continue.'),
				rt.new_string('woocommerce'),
			]))
		} else if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
			var_shipping_country.clone(),
			rt.func_array_keys(rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}),
				'countries'), 'get_shipping_countries', []rt.PhpVal{})),
			rt.new_bool(true),
		])))))
		{
			if rt.is_true(rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}),
				'countries'), 'country_exists', [var_shipping_country.clone()]))
			{
				mut var_countries := rt.call_method(rt.get_property(rt.call_function('WC',
					[]rt.PhpVal{}), 'countries'), 'get_countries', []rt.PhpVal{})
				mut var_shipping_country_name := if !(var_countries.array_get(var_shipping_country)).is_null() {
					var_countries.array_get(var_shipping_country)
				} else {
					var_shipping_country
				}
				var_errors_mutated.add(rt.new_string('shipping'), rt.call_function('sprintf', [
					rt.call_function('__', [
						rt.new_string('Unfortunately, <strong>we do not ship %1$s %2$s</strong>. Please enter an alternative shipping address.'),
						rt.new_string('woocommerce'),
					]),
					rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}),
						'countries'), 'shipping_to_prefix', [
						var_shipping_country.clone(),
					]),
					var_shipping_country_name.clone(),
				]))
			}
		} else {
			mut var_chosen_shipping_methods := rt.call_method(rt.get_property(rt.call_function('WC',
				[]rt.PhpVal{}), 'session'), 'get', [
				rt.new_string('chosen_shipping_methods'),
			])
			mut iter_15 := rt.call_method(rt.call_method(rt.call_function('WC', []rt.PhpVal{}),
				'shipping', []rt.PhpVal{}), 'get_packages', []rt.PhpVal{}).iterator()
			for {
				item_15 := iter_15.next() or { break }
				mut var_package := item_15.val
				mut var_i := item_15.key
				if !(var_chosen_shipping_methods.array_isset(var_i)
					&& var_package.array_get(rt.new_string('rates')).array_isset(var_chosen_shipping_methods.array_get(var_i))) {
					var_errors_mutated.add(rt.new_string('shipping'), rt.call_function('__', [
						rt.new_string('No shipping method has been selected. Please double check your address, or contact us if you need any help.'),
						rt.new_string('woocommerce'),
					]))
				}
			}
		}
	}
	if rt.is_true(rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'cart'),
		'needs_payment', []rt.PhpVal{}))
	{
		mut var_available_gateways := rt.call_method(rt.get_property(rt.call_function('WC',
			[]rt.PhpVal{}), 'payment_gateways'), 'get_available_payment_gateways', []rt.PhpVal{})
		if !(var_available_gateways.array_isset(var_data_mutated.array_get(rt.new_string('payment_method')))) {
			var_errors_mutated.add(rt.new_string('payment'), rt.call_function('__', [
				rt.new_string('Invalid payment method.'),
				rt.new_string('woocommerce'),
			]))
		} else {
			rt.call_method(var_available_gateways.array_get(var_data_mutated.array_get(rt.new_string('payment_method'))),
				'validate_fields', []rt.PhpVal{})
		}
	}
	rt.call_function('do_action', [
		rt.new_string('woocommerce_after_checkout_validation'),
		var_data_mutated.clone(),
		var_errors_mutated.clone(),
	])
}

fn (mut this Class_WC_Checkout) set_customer_address_fields(var_field rt.PhpVal, var_key rt.PhpVal, var_data rt.PhpVal) {
	mut var_data_mutated := var_data
	mut var_billing_value := rt.new_null()
	mut var_shipping_value := rt.new_null()
	if var_data_mutated.array_isset(rt.new_string('billing_${var_field.to_string()}'))
		&& rt.call_function('is_callable', [rt.create_array([rt.ArrayItem{
		key: none
		val: rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'customer')
	}, rt.ArrayItem{ key: none, val: 'set_billing_${var_field.to_string()}' }])]) {
		var_billing_value =
			var_data_mutated.array_get(rt.new_string('billing_${var_field.to_string()}'))
		var_shipping_value =
			var_data_mutated.array_get(rt.new_string('billing_${var_field.to_string()}'))
	}
	if var_data_mutated.array_isset(rt.new_string('shipping_${var_field.to_string()}'))
		&& rt.call_function('is_callable', [rt.create_array([rt.ArrayItem{
		key: none
		val: rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'customer')
	}, rt.ArrayItem{ key: none, val: 'set_shipping_${var_field.to_string()}' }])]) {
		var_shipping_value =
			var_data_mutated.array_get(rt.new_string('shipping_${var_field.to_string()}'))
	}
	if !(var_billing_value.clone().is_null())
		&& rt.call_function('is_callable', [rt.create_array([rt.ArrayItem{
		key: none
		val: rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'customer')
	}, rt.ArrayItem{ key: none, val: 'set_billing_${var_field.to_string()}' }])]) {
		rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'customer'),
			'set_billing_${var_field.to_string()}', [var_billing_value.clone()])
	}
	if !(var_shipping_value.clone().is_null())
		&& rt.call_function('is_callable', [rt.create_array([rt.ArrayItem{
		key: none
		val: rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'customer')
	}, rt.ArrayItem{ key: none, val: 'set_shipping_${var_field.to_string()}' }])]) {
		rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'customer'),
			'set_shipping_${var_field.to_string()}', [var_shipping_value.clone()])
	}
}

fn (mut this Class_WC_Checkout) update_session(var_data rt.PhpVal) {
	mut var_data_mutated := var_data
	mut var_address_fields := ['first_name', 'last_name', 'company', 'email', 'phone', 'address_1',
		'address_2', 'city', 'postcode', 'state', 'country']
	rt.call_function('array_walk', [rt.create_array_from_list(var_address_fields),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Checkout', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'set_customer_address_fields' },
		]),
		var_data_mutated.clone()])
	rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'customer'), 'save',
		[]rt.PhpVal{})
	mut var_chosen_shipping_methods := rt.call_method(rt.get_property(rt.call_function('WC',
		[]rt.PhpVal{}), 'session'), 'get', [rt.new_string('chosen_shipping_methods')])
	if rt.is_true(rt.new_bool(var_data_mutated.array_get(rt.new_string('shipping_method')).is_array())) {
		mut iter_16 := var_data_mutated.array_get(rt.new_string('shipping_method')).iterator()
		for {
			item_16 := iter_16.next() or { break }
			mut var_value := item_16.val
			mut var_i := item_16.key
			if !(var_value.clone().is_string()) {
				continue
			}
			var_chosen_shipping_methods.array_set(var_i, var_value.clone())
		}
	}
	rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'session'), 'set', [
		rt.new_string('chosen_shipping_methods'),
		var_chosen_shipping_methods.clone(),
	])
	rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'session'), 'set', [
		rt.new_string('chosen_payment_method'),
		var_data_mutated.array_get(rt.new_string('payment_method')),
	])
	rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'cart'),
		'calculate_totals', []rt.PhpVal{})
}

fn (mut this Class_WC_Checkout) process_order_payment(var_order_id rt.PhpVal, var_payment_method rt.PhpVal) {
	mut var_order_id_mutated := var_order_id
	mut var_available_gateways := rt.call_method(rt.get_property(rt.call_function('WC',
		[]rt.PhpVal{}), 'payment_gateways'), 'get_available_payment_gateways', []rt.PhpVal{})
	if !(var_available_gateways.array_isset(var_payment_method)) {
		return
	}
	rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'session'), 'set', [
		rt.new_string('order_awaiting_payment'),
		var_order_id_mutated.clone(),
	])
	rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'session'), 'save_data',
		[]rt.PhpVal{})
	mut var_result := rt.call_method(var_available_gateways.array_get(var_payment_method),
		'process_payment', [var_order_id_mutated.clone()])
	if var_result.array_isset(rt.new_string('result'))
		&& rt.is_true(rt.identical(rt.new_string('success'), var_result.array_get(rt.new_string('result')))) {
		var_result.array_set('order_id', var_order_id_mutated.clone())
		var_result = rt.call_function('apply_filters', [
			rt.new_string('woocommerce_payment_successful_result'),
			var_result.clone(),
			var_order_id_mutated.clone(),
		])
		rt.call_function('wc_log_order_step', [
			rt.new_string('[Shortcode #6A] Order payment processed successfully'),
			rt.create_array([rt.ArrayItem{ key: 'order_id', val: var_order_id_mutated },
				rt.ArrayItem{ key: 'payment_method', val: var_payment_method },
				rt.ArrayItem{
					key: 'redirected'
					val: if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_doing_ajax',
						[]rt.PhpVal{})))))
					{
						'yes'
					} else {
						'no'
					}
				}]),
			rt.new_bool(true),
		])
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_doing_ajax', []rt.PhpVal{}))))) {
			rt.call_function('wp_redirect', [var_result.array_get(rt.new_string('redirect'))])
			exit(0)
		}
		rt.call_function('wp_send_json', [var_result.clone()])
	}
}

fn (mut this Class_WC_Checkout) process_order_without_payment(var_order_id rt.PhpVal) {
	mut var_order_id_mutated := var_order_id
	mut var_order := rt.call_function('wc_get_order', [var_order_id_mutated.clone()])
	rt.call_method(var_order, 'payment_complete', []rt.PhpVal{})
	rt.call_function('wc_empty_cart', []rt.PhpVal{})
	rt.call_function('wc_log_order_step', [
		rt.new_string('[Shortcode #6B] Order processed without payment'),
		rt.create_array([rt.ArrayItem{ key: 'order_object', val: var_order },
			rt.ArrayItem{
				key: 'redirected'
				val: if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_doing_ajax',
					[]rt.PhpVal{})))))
				{
					'yes'
				} else {
					'no'
				}
			}]),
		rt.new_bool(true),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_doing_ajax', []rt.PhpVal{}))))) {
		rt.call_function('wp_safe_redirect', [
			rt.call_function('apply_filters', [
				rt.new_string('woocommerce_checkout_no_payment_needed_redirect'),
				rt.call_method(var_order, 'get_checkout_order_received_url', []rt.PhpVal{}),
				var_order.clone(),
			]),
		])
		exit(0)
	}
	rt.call_function('wp_send_json', [
		rt.create_array([rt.ArrayItem{ key: 'result', val: 'success' },
			rt.ArrayItem{ key: 'redirect', val: rt.call_function('apply_filters', [
				rt.new_string('woocommerce_checkout_no_payment_needed_redirect'),
				rt.call_method(var_order, 'get_checkout_order_received_url', []rt.PhpVal{}),
				var_order.clone(),
			]) }]),
	])
}

fn (mut this Class_WC_Checkout) process_customer(var_data rt.PhpVal) {
	mut var_data_mutated := var_data
	mut var_customer_id := rt.call_function('apply_filters', [
		rt.new_string('woocommerce_checkout_customer_id'),
		rt.call_function('get_current_user_id', []rt.PhpVal{}),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_user_logged_in', []rt.PhpVal{})))))
		&& rt.is_true(this.is_registration_required())
		|| !(!rt.is_true(var_data_mutated.array_get(rt.new_string('createaccount')))) {
		mut var_username := if !(!rt.is_true(var_data_mutated.array_get(rt.new_string('account_username')))) {
			var_data_mutated.array_get(rt.new_string('account_username'))
		} else {
			rt.new_string('')
		}
		mut var_password := if !(!rt.is_true(var_data_mutated.array_get(rt.new_string('account_password')))) {
			var_data_mutated.array_get(rt.new_string('account_password'))
		} else {
			rt.new_string('')
		}
		var_customer_id = rt.call_function('wc_create_new_customer', [
			var_data_mutated.array_get(rt.new_string('billing_email')),
			var_username.clone(),
			var_password.clone(),
			rt.create_array([
				rt.ArrayItem{
					key: 'first_name'
					val: if !(!rt.is_true(var_data_mutated.array_get(rt.new_string('billing_first_name')))) {
						var_data_mutated.array_get(rt.new_string('billing_first_name'))
					} else {
						rt.new_string('')
					}
				},
				rt.ArrayItem{
					key: 'last_name'
					val: if !(!rt.is_true(var_data_mutated.array_get(rt.new_string('billing_last_name')))) {
						var_data_mutated.array_get(rt.new_string('billing_last_name'))
					} else {
						rt.new_string('')
					}
				},
			]),
		])
		if rt.is_true(rt.call_function('is_wp_error', [var_customer_id.clone()])) {
			if rt.is_true(rt.identical(rt.new_string('registration-error-email-exists'), rt.call_method(var_customer_id,
				'get_error_code', []rt.PhpVal{})))
			{
				rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.call_function('apply_filters', [
					rt.new_string('woocommerce_registration_error_email_exists'),
					rt.call_function('__', [
						rt.new_string('An account is already registered with your email address. <a href="#" class="showlogin">Please log in.</a>'),
						rt.new_string('woocommerce'),
					]),
					var_data_mutated.array_get(rt.new_string('billing_email')),
				]))))
			}
			rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.call_method(var_customer_id,
				'get_error_message', []rt.PhpVal{}))))
		}
		rt.call_function('wc_set_customer_auth_cookie', [var_customer_id.clone()])
		rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'session'), 'set', [
			rt.new_string('reload_checkout'),
			rt.new_bool(true),
		])
		rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'cart'),
			'calculate_totals', []rt.PhpVal{})
	}
	if rt.is_true(var_customer_id) && rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{}))
		&& rt.is_true(rt.call_function('is_user_logged_in', []rt.PhpVal{}))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_user_member_of_blog', []rt.PhpVal{}))))) {
		rt.call_function('add_user_to_blog', [
			rt.call_function('get_current_blog_id', []rt.PhpVal{}),
			var_customer_id.clone(),
			rt.new_string('customer'),
		])
	}
	if rt.is_true(var_customer_id)
		&& rt.is_true(rt.call_function('apply_filters', [rt.new_string('woocommerce_checkout_update_customer_data'), rt.new_bool(true), rt.new_object('WC_Checkout', []string{}, &this)])) {
		mut var_customer := create_wc_customer(var_customer_id.clone())
		if !(!rt.is_true(var_data_mutated.array_get(rt.new_string('billing_first_name'))))
			&& rt.is_true(rt.identical(rt.new_string(''), var_customer.get_first_name())) {
			var_customer.set_first_name(var_data_mutated.array_get(rt.new_string('billing_first_name')))
		}
		if !(!rt.is_true(var_data_mutated.array_get(rt.new_string('billing_last_name'))))
			&& rt.is_true(rt.identical(rt.new_string(''), var_customer.get_last_name())) {
			var_customer.set_last_name(var_data_mutated.array_get(rt.new_string('billing_last_name')))
		}
		if rt.is_true(rt.call_function('is_email', [var_customer.get_display_name()])) {
			var_customer.set_display_name(rt.new_string(
				(var_customer.get_first_name()).str() + ' ' + (var_customer.get_last_name()).str()))
		}
		mut iter_17 := var_data_mutated.iterator()
		for {
			item_17 := iter_17.next() or { break }
			mut var_value := item_17.val
			mut var_key := item_17.key
			if rt.is_true(rt.call_function('is_callable', [
				rt.create_array([rt.ArrayItem{ key: none, val: var_customer },
					rt.ArrayItem{ key: none, val: 'set_${var_key.to_string()}' }]),
			]))
			{
				rt.call_method(var_customer, 'set_${var_key.to_string()}', [
					var_value.clone()])
			} else if
				rt.is_true(rt.identical(rt.new_int(0), rt.call_function('stripos', [var_key.clone(), rt.new_string('billing_')])))
				|| rt.is_true(rt.identical(rt.new_int(0), rt.call_function('stripos', [var_key.clone(), rt.new_string('shipping_')]))) {
				var_customer.update_meta_data(var_key.clone(), var_value.clone())
			}
		}
		rt.call_function('do_action', [
			rt.new_string('woocommerce_checkout_update_customer'),
			var_customer,
			var_data_mutated.clone(),
		])
		var_customer.save()
	}
	rt.call_function('do_action', [
		rt.new_string('woocommerce_checkout_update_user_meta'),
		var_customer_id.clone(),
		var_data_mutated.clone(),
	])
}

fn (mut this Class_WC_Checkout) send_ajax_failure_response() {
	if rt.is_true(rt.call_function('wp_doing_ajax', []rt.PhpVal{})) {
		if !(!(rt.get_property(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'session'),
			'reload_checkout')).is_null()) {
			mut var_messages := rt.call_function('wc_print_notices', [
				rt.new_bool(true)])
		}
		mut var_response := {
			'result':   rt.new_string('failure')
			'messages': if !var_messages.is_null() { var_messages } else { rt.new_string('') }
			'refresh':  rt.new_bool(!(rt.get_property(rt.get_property(rt.call_function('WC',
				[]rt.PhpVal{}), 'session'), 'refresh_totals')).is_null())
			'reload':   rt.new_bool(!(rt.get_property(rt.get_property(rt.call_function('WC',
				[]rt.PhpVal{}), 'session'), 'reload_checkout')).is_null())
		}
		rt.get_property(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'session'),
			'refresh_totals') = rt.new_null()
		rt.get_property(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'session'),
			'reload_checkout') = rt.new_null()
		rt.call_function('wp_send_json', [rt.create_array_from_native_map(var_response)])
	}
}

fn (mut this Class_WC_Checkout) process_checkout() {
	mut var_nonce_value := rt.call_function('wc_get_var', [
		rt.get_superglobal('_REQUEST').array_get(rt.new_string('woocommerce-process-checkout-nonce')),
		rt.call_function('wc_get_var', [rt.get_superglobal('_REQUEST').array_get(rt.new_string('_wpnonce')),
			rt.new_string('')]),
	])
	if rt.has_exception() {
		unsafe {
			goto catch_label_2
		}
	}
	mut var_expiry_message := rt.call_function('sprintf', [
		rt.call_function('__', [
			rt.new_string('Sorry, your session has expired. <a href="%s" class="wc-backward">Return to shop</a>'),
			rt.new_string('woocommerce'),
		]),
		rt.call_function('esc_url', [
			rt.call_function('wc_get_page_permalink', [rt.new_string('shop')]),
		]),
	])
	if rt.has_exception() {
		unsafe {
			goto catch_label_2
		}
	}
	if !rt.is_true(var_nonce_value)
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_verify_nonce', [var_nonce_value.clone(), rt.new_string('woocommerce-process_checkout')]))))) {
		if rt.is_true(rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'cart'),
			'is_empty', []rt.PhpVal{}))
		{
			rt.throw_exception(rt.new_object('Exception', []string{},
				create_exception(var_expiry_message.clone())))
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
		rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'session'), 'set', [
			rt.new_string('refresh_totals'),
			rt.new_bool(true),
		])
		if rt.has_exception() {
			unsafe {
				goto catch_label_2
			}
		}
		rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.call_function('__', [
			rt.new_string('We were unable to process your order, please try again.'),
			rt.new_string('woocommerce'),
		]))))
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
	rt.call_function('wc_maybe_define_constant', [rt.new_string('WOOCOMMERCE_CHECKOUT'),
		rt.new_bool(true)])
	if rt.has_exception() {
		unsafe {
			goto catch_label_2
		}
	}
	rt.call_function('wc_set_time_limit', [rt.new_int(0)])
	if rt.has_exception() {
		unsafe {
			goto catch_label_2
		}
	}
	rt.call_function('do_action', [rt.new_string('woocommerce_before_checkout_process')])
	if rt.has_exception() {
		unsafe {
			goto catch_label_2
		}
	}
	if rt.is_true(rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'cart'),
		'is_empty', []rt.PhpVal{}))
	{
		rt.throw_exception(rt.new_object('Exception', []string{},
			create_exception(var_expiry_message.clone())))
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
	rt.call_function('wc_log_order_step', [
		rt.new_string('[Shortcode #1] Place Order flow initiated'),
		rt.new_null(),
		rt.new_bool(false),
		rt.new_bool(true),
	])
	if rt.has_exception() {
		unsafe {
			goto catch_label_2
		}
	}
	rt.call_function('do_action', [rt.new_string('woocommerce_checkout_process')])
	if rt.has_exception() {
		unsafe {
			goto catch_label_2
		}
	}
	mut var_errors := create_wp_error()
	if rt.has_exception() {
		unsafe {
			goto catch_label_2
		}
	}
	mut var_posted_data := this.get_posted_data()
	if rt.has_exception() {
		unsafe {
			goto catch_label_2
		}
	}
	this.update_session(var_posted_data.clone())
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
	if rt.instance_of(var_e_3, 'WC_Data_Exception') {
		mut var_e := var_e_3.clone()
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('customer_invalid_billing_email'), rt.call_method(var_e,
			'getErrorCode', []rt.PhpVal{})))))
		{
			rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.call_method(var_e,
				'getMessage', []rt.PhpVal{}), rt.call_method(var_e, 'getCode', []rt.PhpVal{}), rt.call_method(var_e,
				'getPrevious', []rt.PhpVal{}))))
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
	rt.call_function('wc_log_order_step', [
		rt.new_string('[Shortcode #2] Session updated with checkout data and totals calculated'),
	])
	if rt.has_exception() {
		unsafe {
			goto catch_label_2
		}
	}
	this.validate_checkout(var_posted_data.clone(), rt.new_object('WP_Error', []string{},
		var_errors))
	if rt.has_exception() {
		unsafe {
			goto catch_label_2
		}
	}
	if !rt.is_true(rt.get_property(var_errors, 'errors')) {
		rt.call_function('wc_log_order_step', [
			rt.new_string('[Shortcode #3] Checkout posted data validated'),
			rt.create_array([
				rt.ArrayItem{
					key: 'payment_method'
					val: var_posted_data.array_get(rt.new_string('payment_method'))
				},
			]),
		])
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
	mut iter_18 := rt.get_property(var_errors, 'errors').iterator()
	for {
		item_18 := iter_18.next() or { break }
		mut var_messages := item_18.val
		mut var_code := item_18.key
		mut var_data := var_errors.get_error_data(var_code.clone())
		if rt.has_exception() {
			unsafe {
				goto catch_label_2
			}
		}
		mut iter_19 := var_messages.iterator()
		for {
			item_19 := iter_19.next() or { break }
			mut var_message := item_19.val
			rt.call_function('wc_add_notice', [var_message.clone(),
				rt.new_string('error'), var_data.clone()])
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
	}
	if rt.has_exception() {
		unsafe {
			goto catch_label_2
		}
	}
	if !rt.is_true(var_posted_data.array_get(rt.new_string('woocommerce_checkout_update_totals')))
		&& rt.is_true(rt.identical(rt.new_int(0), rt.call_function('wc_notice_count', [rt.new_string('error')]))) {
		this.process_customer(var_posted_data.clone())
		if rt.has_exception() {
			unsafe {
				goto catch_label_2
			}
		}
		mut var_order_id := this.create_order(var_posted_data.clone())
		if rt.has_exception() {
			unsafe {
				goto catch_label_2
			}
		}
		mut var_order := rt.call_function('wc_get_order', [var_order_id.clone()])
		if rt.has_exception() {
			unsafe {
				goto catch_label_2
			}
		}
		if rt.is_true(rt.call_function('is_wp_error', [var_order_id.clone()])) {
			rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.call_method(var_order_id,
				'get_error_message', []rt.PhpVal{}))))
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
		if rt.is_true(rt.new_bool(!(rt.is_true(var_order)))) {
			rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.call_function('__', [
				rt.new_string('Unable to create order.'),
				rt.new_string('woocommerce'),
			]))))
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
		rt.call_function('wc_log_order_step', [
			rt.new_string('[Shortcode #4] Validated/Created customer and created order object'),
			rt.create_array([rt.ArrayItem{ key: 'order_object', val: var_order }]),
		])
		if rt.has_exception() {
			unsafe {
				goto catch_label_2
			}
		}
		rt.call_function('do_action', [
			rt.new_string('woocommerce_checkout_order_processed'),
			var_order_id.clone(),
			var_posted_data.clone(),
			var_order.clone(),
		])
		if rt.has_exception() {
			unsafe {
				goto catch_label_2
			}
		}
		rt.call_function('wc_log_order_step', [
			rt.new_string('[Shortcode #5] woocommerce_checkout_order_processed hook ran successfully'),
			rt.create_array([rt.ArrayItem{ key: 'order_object', val: var_order }]),
		])
		if rt.has_exception() {
			unsafe {
				goto catch_label_2
			}
		}
		if rt.is_true(rt.call_function('apply_filters', [
			rt.new_string('woocommerce_cart_needs_payment'),
			rt.call_method(var_order, 'needs_payment', []rt.PhpVal{}),
			rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'cart'),
		]))
		{
			this.process_order_payment(var_order_id.clone(),
				var_posted_data.array_get(rt.new_string('payment_method')))
			if rt.has_exception() {
				unsafe {
					goto catch_label_2
				}
			}
		} else {
			this.process_order_without_payment(var_order_id.clone())
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
	}
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
	if rt.instance_of(var_e_2, 'Exception') {
		var_e = var_e_2.clone()
		rt.call_function('wc_log_order_step', [
			rt.new_string('[Shortcode #EXPECTEDFAIL] ' +
				(rt.call_method(var_e, 'getMessage', []rt.PhpVal{})).str()),
			rt.create_array([
				rt.ArrayItem{ key: 'error_code', val: rt.call_method(var_e, 'getCode',
					[]rt.PhpVal{}) },
			]),
			rt.new_bool(true),
		])
		rt.call_function('wc_add_notice', [
			rt.call_method(var_e, 'getMessage', []rt.PhpVal{}),
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
	this.send_ajax_failure_response()
}

fn (mut this Class_WC_Checkout) get_posted_address_data(var_key rt.PhpVal, type string) rt.PhpVal {
	mut type_mutated := type
	if rt.is_true(rt.identical(rt.new_string('billing'), rt.new_string(type_mutated)))
		|| rt.is_true(rt.identical(rt.new_bool(false), this.legacy_posted_data.array_get(rt.new_string('ship_to_different_address')))) {
		mut var_return := if this.legacy_posted_data.array_isset('billing_' + var_key.str()) {
			this.legacy_posted_data.array_get(rt.new_string('billing_' + var_key.str()))
		} else {
			rt.new_string('')
		}
	} else {
		var_return = if this.legacy_posted_data.array_isset('shipping_' + var_key.str()) {
			this.legacy_posted_data.array_get(rt.new_string('shipping_' + var_key.str()))
		} else {
			rt.new_string('')
		}
	}
	return var_return.clone()
}

fn (mut this Class_WC_Checkout) get_value(var_input rt.PhpVal) rt.PhpVal {
	if !(!rt.is_true(rt.get_superglobal('_POST').array_get(var_input))) {
		return rt.call_function('wc_clean', [
			rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get(var_input)]),
		])
	}
	mut var_value := rt.call_function('apply_filters', [
		rt.new_string('woocommerce_checkout_get_value'),
		rt.new_null(),
		var_input.clone(),
	])
	if !(var_value.clone().is_null()) {
		return var_value.clone()
	}
	mut var_customer_object := rt.new_bool(false)
	if rt.is_true(rt.call_function('is_user_logged_in', []rt.PhpVal{})) {
		if rt.is_true(rt.new_bool(this.logged_in_customer.is_null())) {
			this.logged_in_customer = create_wc_customer(rt.call_function('get_current_user_id',
				[]rt.PhpVal{}), rt.new_bool(true))
		}
		var_customer_object = this.logged_in_customer
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_customer_object)))) {
		var_customer_object = rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'customer')
	}
	if rt.is_true(rt.call_function('is_callable', [
		rt.create_array([rt.ArrayItem{ key: none, val: var_customer_object },
			rt.ArrayItem{ key: none, val: 'get_${var_input.to_string()}' }]),
	]))
	{
		var_value = rt.call_method(var_customer_object, 'get_${var_input.to_string()}',
			[]rt.PhpVal{})
	} else if
		rt.call_function('is_callable', [rt.create_array([rt.ArrayItem{
		key: none
		val: var_customer_object
	}, rt.ArrayItem{ key: none, val: 'meta_exists' }])])
		&& rt.is_true(rt.call_method(var_customer_object, 'meta_exists', [var_input.clone()])) {
		var_value = rt.call_method(var_customer_object, 'get_meta', [
			var_input.clone(), rt.new_bool(true)])
	}
	if rt.is_true(rt.identical(rt.new_string(''), var_value)) {
		var_value = rt.new_null()
	}
	return rt.call_function('apply_filters', [
		rt.new_string('default_checkout_' + var_input.str()),
		var_value.clone(),
		var_input.clone(),
	])
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

struct Class_WC_Order_Item_Product {
	rt.PhpObjectBase
}

struct Class_WC_Order_Item_Fee {
	rt.PhpObjectBase
}

struct Class_WC_Order_Item_Shipping {
	rt.PhpObjectBase
}

struct Class_WC_Order_Item_Tax {
	rt.PhpObjectBase
}

struct Class_WC_Tax {
	rt.PhpObjectBase
}

struct Class_WC_Order_Item_Coupon {
	rt.PhpObjectBase
}

struct Class_WC_Validation {
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

struct Class_WC_Customer {
	rt.PhpObjectBase
}

fn create_wc_checkout(_args ...rt.PhpVal) &Class_WC_Checkout {
	mut obj := &Class_WC_Checkout{
		PhpObjectBase:      rt.PhpObjectBase{}
		fields:             rt.new_null()
		legacy_posted_data: rt.new_array()
		logged_in_customer: rt.new_null()
	}
	return obj
}

fn create_wc_order(_args ...rt.PhpVal) &Class_WC_Order {
	mut obj := &Class_WC_Order{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_geolocation(_args ...rt.PhpVal) &Class_WC_Geolocation {
	mut obj := &Class_WC_Geolocation{
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

fn create_wc_order_item_product(_args ...rt.PhpVal) &Class_WC_Order_Item_Product {
	mut obj := &Class_WC_Order_Item_Product{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_order_item_fee(_args ...rt.PhpVal) &Class_WC_Order_Item_Fee {
	mut obj := &Class_WC_Order_Item_Fee{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_order_item_shipping(_args ...rt.PhpVal) &Class_WC_Order_Item_Shipping {
	mut obj := &Class_WC_Order_Item_Shipping{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_order_item_tax(_args ...rt.PhpVal) &Class_WC_Order_Item_Tax {
	mut obj := &Class_WC_Order_Item_Tax{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_tax(_args ...rt.PhpVal) &Class_WC_Tax {
	mut obj := &Class_WC_Tax{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_order_item_coupon(_args ...rt.PhpVal) &Class_WC_Order_Item_Coupon {
	mut obj := &Class_WC_Order_Item_Coupon{
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

fn create_wc_customer(_args ...rt.PhpVal) &Class_WC_Customer {
	mut obj := &Class_WC_Customer{
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
			return rt.new_bool(this.magic_get(dispatch_arg_0))
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
		else {
			return none
		}
	}
}

fn (this &Class_WC_Checkout) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'fields' { return this.fields }
		'legacy_posted_data' { return this.legacy_posted_data }
		'logged_in_customer' { return this.logged_in_customer }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_Checkout) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'fields' {
			this.fields = val
			return true
		}
		'legacy_posted_data' {
			this.legacy_posted_data = val
			return true
		}
		'logged_in_customer' {
			this.logged_in_customer = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
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

fn (mut this Class_WC_Order_Item_Product) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Order_Item_Product) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Order_Item_Product) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_Order_Item_Fee) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Order_Item_Fee) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Order_Item_Fee) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_Order_Item_Shipping) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Order_Item_Shipping) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Order_Item_Shipping) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_Order_Item_Tax) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Order_Item_Tax) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Order_Item_Tax) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_Tax) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Tax) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Tax) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_Order_Item_Coupon) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Order_Item_Coupon) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Order_Item_Coupon) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_WC_Customer) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Customer) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Customer) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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
}
