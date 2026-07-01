import rt

struct Class_WC_Customer {
	rt.PhpObjectBase
pub mut:
		data rt.PhpVal = rt.new_array()
		password rt.PhpVal = rt.new_string('')
		is_vat_exempt rt.PhpVal = rt.new_bool(false)
		calculated_shipping rt.PhpVal = rt.new_bool(false)
		object_type rt.PhpVal = rt.new_string('customer')
}

fn (mut this Class_WC_Customer) construct(data i64, is_session bool)  {
	this.Class_WC_Legacy_Customer.construct(rt.new_int(data))
	if rt.is_true(rt.new_bool(rt.instance_of(rt.new_int(data), 'WC_Customer'))) {
		this.set_id(rt.call_function('absint', [rt.call_method(rt.new_int(data), 'get_id', []rt.PhpVal{})]))
	} else if rt.is_true(rt.new_bool(rt.new_int(data).is_long() || rt.new_int(data).is_double())) {
		this.set_id(rt.new_int(data))
	}
	this.dispatch_set_prop('data_store', fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Data_Store{}; return temp.load(arg_0) }(rt.new_string('customer')))
	if rt.is_true(this.get_id()) {
		rt.call_method(rt.get_property(rt.new_object('WC_Customer', ['WC_Legacy_Customer'], &this), 'data_store'), 'read', [rt.new_object('WC_Customer', ['WC_Legacy_Customer'], &this)])
		if rt.has_exception() { unsafe { goto catch_label_1 } }
		unsafe { goto end_label_1 }

catch_label_1:
		mut var_e_1 := rt.get_and_clear_exception()
		if rt.instance_of(var_e_1, 'Exception') {
			mut var_e := var_e_1.dup()
			this.set_id(rt.new_int(0))
			this.set_object_read(rt.new_bool(true))
			unsafe { goto end_label_1 }
		}
		else {
			rt.throw_exception(var_e_1)
			unsafe { goto end_label_1 }
		}

end_label_1:
	} else {
		this.set_object_read(rt.new_bool(true))
	}
	if var_is_session && !(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'session')).is_null() {
		this.dispatch_set_prop('data_store', fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Data_Store{}; return temp.load(arg_0) }(rt.new_string('customer-session')))
		rt.call_method(rt.get_property(rt.new_object('WC_Customer', ['WC_Legacy_Customer'], &this), 'data_store'), 'read', [rt.new_object('WC_Customer', ['WC_Legacy_Customer'], &this)])
	}
}

fn (mut this Class_WC_Customer) delete_and_reassign(var_reassign rt.PhpVal) bool {
	if rt.is_true(rt.get_property(rt.new_object('WC_Customer', ['WC_Legacy_Customer'], &this), 'data_store')) {
		rt.call_method(rt.get_property(rt.new_object('WC_Customer', ['WC_Legacy_Customer'], &this), 'data_store'), 'delete', [rt.new_object('WC_Customer', ['WC_Legacy_Customer'], &this), rt.create_array([rt.ArrayItem{ key: 'force_delete', val: true }, rt.ArrayItem{ key: 'reassign', val: var_reassign }])])
		this.set_id(rt.new_int(0))
		return true
	}
	return false
}

fn (mut this Class_WC_Customer) is_customer_outside_base() bool {
	mut var_country := rt.new_null()
	mut var_state := rt.new_null()
	// unsupported assign target: Expr_List
	if rt.is_true(var_country) {
		mut var_default := rt.call_function('wc_get_base_location', []rt.PhpVal{})
		if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
			return true
		}
		if rt.is_true(rt.new_bool(rt.is_true(var_default.array_get('state')) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
			return true
		}
	}
	return false
}

fn (mut this Class_WC_Customer) get_avatar_url() rt.PhpVal {
	return rt.call_function('get_avatar_url', [this.get_email('')])
}

fn (mut this Class_WC_Customer) get_taxable_address() rt.PhpVal {
	mut var_tax_based_on := rt.call_function('get_option', [rt.new_string('woocommerce_tax_based_on')])
	if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_bool(true), rt.call_function('apply_filters', [rt.new_string('woocommerce_apply_base_tax_for_local_pickup'), rt.new_bool(true)]))) && rt.call_function('array_intersect', [rt.call_function('wc_get_chosen_shipping_method_ids', []rt.PhpVal{}), rt.call_function('apply_filters', [rt.new_string('woocommerce_local_pickup_methods'), rt.create_array([rt.ArrayItem{ key: none, val: 'legacy_local_pickup' }, rt.ArrayItem{ key: none, val: 'local_pickup' }])])]).array_count() > 0)) {
		var_tax_based_on = Class_Automattic_WooCommerce_Enums_TaxBasedOn.base()
	}
	if rt.is_true(rt.identical(Class_Automattic_WooCommerce_Enums_TaxBasedOn.base(), var_tax_based_on)) {
		mut var_country := rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'countries'), 'get_base_country', []rt.PhpVal{})
		mut var_state := rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'countries'), 'get_base_state', []rt.PhpVal{})
		mut var_postcode := rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'countries'), 'get_base_postcode', []rt.PhpVal{})
		mut var_city := rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'countries'), 'get_base_city', []rt.PhpVal{})
	} else if rt.is_true(rt.identical(Class_Automattic_WooCommerce_Enums_TaxBasedOn.billing(), var_tax_based_on)) {
		var_country = this.get_billing_country('')
		var_state = this.get_billing_state('')
		var_postcode = this.get_billing_postcode('')
		var_city = this.get_billing_city('')
	} else {
		var_country = this.get_shipping_country('')
		var_state = this.get_shipping_state('')
		var_postcode = this.get_shipping_postcode('')
		var_city = this.get_shipping_city('')
	}
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_customer_taxable_address'), rt.create_array([rt.ArrayItem{ key: none, val: var_country }, rt.ArrayItem{ key: none, val: var_state }, rt.ArrayItem{ key: none, val: var_postcode }, rt.ArrayItem{ key: none, val: var_city }]), rt.new_object('WC_Customer', ['WC_Legacy_Customer'], &this)])
}

fn (mut this Class_WC_Customer) get_downloadable_products() rt.PhpVal {
	mut var_downloads := rt.new_array()
	if rt.is_true(this.get_id()) {
		var_downloads = rt.call_function('wc_get_customer_available_downloads', [this.get_id()])
	}
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_customer_get_downloadable_products'), var_downloads.dup()])
}

fn (mut this Class_WC_Customer) is_vat_exempt() rt.PhpVal {
	return this.get_is_vat_exempt()
}

fn (mut this Class_WC_Customer) has_calculated_shipping() rt.PhpVal {
	return this.get_calculated_shipping()
}

fn (mut this Class_WC_Customer) has_shipping_address() bool {
	{
		mut iter_1 := this.get_shipping('').iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_address_field := item_1.val
			if var_address_field.dup().to_string().trim_space().len > 0 {
				return true
			}
		}
	}
	return false
}

fn (mut this Class_WC_Customer) has_full_shipping_address() bool {
	mut var_shipping_address := { 'country': this.get_shipping_country(''), 'city': this.get_shipping_city(''), 'state': this.get_shipping_state(''), 'postcode': this.get_shipping_postcode('') }
	mut var_address_fields := rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'countries'), 'get_country_locale', []rt.PhpVal{})
	mut var_locale_key := if rt.is_true(rt.new_bool(!(!rt.is_true(var_shipping_address.array_get('country'))) && rt.is_true(rt.new_bool(var_address_fields.dup().array_isset(var_shipping_address.array_get('country')))))) { var_shipping_address.array_get('country') } else { rt.new_string('default') }
	mut var_default_locale := var_address_fields.array_get('default')
	mut var_country_locale := if !(var_address_fields.array_get(var_locale_key)).is_null() { var_address_fields.array_get(var_locale_key) } else { rt.new_array() }
	for var_key, var_value in var_shipping_address {
		if !(!rt.is_true(var_value)) {
			continue
		}
		if rt.is_true(rt.new_bool(var_country_locale.array_get(key).array_isset(rt.new_string('hidden')) && rt.is_true(rt.identical(rt.new_bool(true), rt.call_function('wc_string_to_bool', [var_country_locale.array_get(key).array_get('hidden')]))))) {
			continue
		}
		if rt.is_true(rt.new_bool(var_default_locale.array_get(key).array_isset(rt.new_string('hidden')) && rt.is_true(rt.identical(rt.new_bool(true), rt.call_function('wc_string_to_bool', [var_default_locale.array_get(key).array_get('hidden')]))))) {
			continue
		}
		mut var_locale_to_check := if var_country_locale.array_get(key).array_isset(rt.new_string('required')) { var_country_locale } else { var_default_locale }
		if rt.is_true(rt.new_bool(var_locale_to_check.array_get(key).array_isset(rt.new_string('required')) && rt.is_true(rt.identical(rt.new_bool(true), rt.call_function('wc_string_to_bool', [var_locale_to_check.array_get(key).array_get('required')]))))) {
			return false
		}
	}
	return true
}

fn (mut this Class_WC_Customer) get_is_vat_exempt() rt.PhpVal {
	return this.is_vat_exempt
}

fn (mut this Class_WC_Customer) get_password() rt.PhpVal {
	return this.password
}

fn (mut this Class_WC_Customer) get_calculated_shipping() rt.PhpVal {
	return this.calculated_shipping
}

fn (mut this Class_WC_Customer) set_is_vat_exempt(var_is_vat_exempt rt.PhpVal)  {
	this.is_vat_exempt = rt.call_function('wc_string_to_bool', [var_is_vat_exempt.dup()])
}

fn (mut this Class_WC_Customer) set_calculated_shipping(calculated bool)  {
	this.calculated_shipping = rt.call_function('wc_string_to_bool', [rt.new_bool(calculated)])
}

fn (mut this Class_WC_Customer) set_password(var_password rt.PhpVal)  {
	this.password = var_password.dup()
}

fn (mut this Class_WC_Customer) get_last_order() rt.PhpVal {
	return rt.call_method(rt.get_property(rt.new_object('WC_Customer', ['WC_Legacy_Customer'], &this), 'data_store'), 'get_last_order', [rt.new_object('WC_Customer', ['WC_Legacy_Customer'], &this)])
}

fn (mut this Class_WC_Customer) get_order_count() rt.PhpVal {
	return rt.call_method(rt.get_property(rt.new_object('WC_Customer', ['WC_Legacy_Customer'], &this), 'data_store'), 'get_order_count', [rt.new_object('WC_Customer', ['WC_Legacy_Customer'], &this)])
}

fn (mut this Class_WC_Customer) get_total_spent() rt.PhpVal {
	return rt.call_method(rt.get_property(rt.new_object('WC_Customer', ['WC_Legacy_Customer'], &this), 'data_store'), 'get_total_spent', [rt.new_object('WC_Customer', ['WC_Legacy_Customer'], &this)])
}

fn (mut this Class_WC_Customer) get_username(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('username'), rt.new_string(context))
}

fn (mut this Class_WC_Customer) get_email(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('email'), rt.new_string(context))
}

fn (mut this Class_WC_Customer) get_first_name(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('first_name'), rt.new_string(context))
}

fn (mut this Class_WC_Customer) get_last_name(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('last_name'), rt.new_string(context))
}

fn (mut this Class_WC_Customer) get_display_name(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('display_name'), rt.new_string(context))
}

fn (mut this Class_WC_Customer) get_role(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('role'), rt.new_string(context))
}

fn (mut this Class_WC_Customer) get_date_created(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('date_created'), rt.new_string(context))
}

fn (mut this Class_WC_Customer) get_date_modified(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('date_modified'), rt.new_string(context))
}

fn (mut this Class_WC_Customer) get_address_prop(var_prop rt.PhpVal, address_type string, context string) rt.PhpVal {
	mut var_prop_mutated := var_prop
	mut var_value := rt.new_null()
	if rt.is_true(rt.new_bool(this.data.array_get(address_type).array_isset(var_prop_mutated.dup()))) {
		var_value = if rt.get_property(rt.new_object('WC_Customer', ['WC_Legacy_Customer'], &this), 'changes').array_get(address_type).array_isset(var_prop_mutated) { rt.get_property(rt.new_object('WC_Customer', ['WC_Legacy_Customer'], &this), 'changes').array_get(address_type).array_get(var_prop_mutated) } else { this.data.array_get(address_type).array_get(var_prop_mutated) }
		if rt.is_true(rt.identical(rt.new_string('view'), rt.new_string(context))) {
			var_value = rt.call_function('apply_filters', [(this.get_hook_prefix()).str() + address_type + '_' + (var_prop_mutated).str(), var_value.dup(), rt.new_object('WC_Customer', ['WC_Legacy_Customer'], &this)])
		}
	}
	return var_value.dup()
}

fn (mut this Class_WC_Customer) get_billing(context string) rt.PhpVal {
	mut var_value := rt.new_null()
	mut var_prop := rt.new_string(rt.new_string('billing'))
	if rt.is_true(rt.new_bool(this.data.array_isset(var_prop.dup()))) {
		mut var_changes := if rt.is_true(rt.new_bool(rt.get_property(rt.new_object('WC_Customer', ['WC_Legacy_Customer'], &this), 'changes').array_isset(var_prop.dup()))) { rt.get_property(rt.new_object('WC_Customer', ['WC_Legacy_Customer'], &this), 'changes').array_get(var_prop) } else { rt.new_array() }
		var_value = rt.call_function('array_merge', [this.data.array_get(var_prop), var_changes.dup()])
		if rt.is_true(rt.identical(rt.new_string('view'), rt.new_string(context))) {
			var_value = rt.call_function('apply_filters', [rt.concat(this.get_hook_prefix(), var_prop), var_value.dup(), rt.new_object('WC_Customer', ['WC_Legacy_Customer'], &this)])
		}
	}
	return var_value.dup()
}

fn (mut this Class_WC_Customer) get_billing_first_name(context string) rt.PhpVal {
	return this.get_address_prop(rt.new_string('first_name'), 'billing', context)
}

fn (mut this Class_WC_Customer) get_billing_last_name(context string) rt.PhpVal {
	return this.get_address_prop(rt.new_string('last_name'), 'billing', context)
}

fn (mut this Class_WC_Customer) get_billing_company(context string) rt.PhpVal {
	return this.get_address_prop(rt.new_string('company'), 'billing', context)
}

fn (mut this Class_WC_Customer) get_billing_address(context string) rt.PhpVal {
	return this.get_billing_address_1(context)
}

fn (mut this Class_WC_Customer) get_billing_address_1(context string) rt.PhpVal {
	return this.get_address_prop(rt.new_string('address_1'), 'billing', context)
}

fn (mut this Class_WC_Customer) get_billing_address_2(context string) rt.PhpVal {
	return this.get_address_prop(rt.new_string('address_2'), 'billing', context)
}

fn (mut this Class_WC_Customer) get_billing_city(context string) rt.PhpVal {
	return this.get_address_prop(rt.new_string('city'), 'billing', context)
}

fn (mut this Class_WC_Customer) get_billing_state(context string) rt.PhpVal {
	return this.get_address_prop(rt.new_string('state'), 'billing', context)
}

fn (mut this Class_WC_Customer) get_billing_postcode(context string) rt.PhpVal {
	return this.get_address_prop(rt.new_string('postcode'), 'billing', context)
}

fn (mut this Class_WC_Customer) get_billing_country(context string) rt.PhpVal {
	return this.get_address_prop(rt.new_string('country'), 'billing', context)
}

fn (mut this Class_WC_Customer) get_billing_email(context string) rt.PhpVal {
	return this.get_address_prop(rt.new_string('email'), 'billing', context)
}

fn (mut this Class_WC_Customer) get_billing_phone(context string) rt.PhpVal {
	return this.get_address_prop(rt.new_string(), , )
}

fn (mut this Class_WC_Customer) get_shipping(context string) rt.PhpVal {
	
}

fn (mut this Class_WC_Customer) get_shipping_first_name(context string) rt.PhpVal {
}

fn (mut this Class_WC_Customer) get_shipping_last_name(context string) rt.PhpVal {
}

fn (mut this Class_WC_Customer) get_shipping_company(context string) rt.PhpVal {
}

fn (mut this Class_WC_Customer) get_shipping_address(context string) rt.PhpVal {
}

fn (mut this Class_WC_Customer) get_shipping_address_1(context string) rt.PhpVal {
}

fn (mut this Class_WC_Customer) get_shipping_address_2(context string) rt.PhpVal {
}

fn (mut this Class_WC_Customer) get_shipping_city(context string) rt.PhpVal {
}

fn (mut this Class_WC_Customer) get_shipping_state(context string) rt.PhpVal {
}

fn (mut this Class_WC_Customer) get_shipping_postcode(context string) rt.PhpVal {
}

fn (mut this Class_WC_Customer) get_shipping_country(context string) rt.PhpVal {
}

fn (mut this Class_WC_Customer) get_shipping_phone(context string) rt.PhpVal {
}

fn (mut this Class_WC_Customer) get_is_paying_customer(context string) rt.PhpVal {
}

fn (mut this Class_WC_Customer) set_username(var_username rt.PhpVal)  {
}

fn (mut this Class_WC_Customer) set_email(var_value rt.PhpVal)  {
	mut var_value_mutated := var_value
}

fn (mut this Class_WC_Customer) set_first_name(var_first_name rt.PhpVal)  {
}

fn (mut this Class_WC_Customer) set_last_name(var_last_name rt.PhpVal)  {
}

fn (mut this Class_WC_Customer) set_display_name(var_display_name rt.PhpVal)  {
}

fn (mut this Class_WC_Customer) set_role(var_role rt.PhpVal)  {
	mut var_wp_roles := rt.new_null()
}

fn (mut this Class_WC_Customer) set_date_created(var_date rt.PhpVal)  {
}

fn (mut this Class_WC_Customer) set_date_modified(var_date rt.PhpVal)  {
}

fn (mut this Class_WC_Customer) set_billing_address_to_base()  {
}

fn (mut this Class_WC_Customer) set_shipping_address_to_base()  {
}

fn (mut this Class_WC_Customer) set_billing_location(var_country rt.PhpVal, state string, postcode string, city string)  {
	mut var_country_mutated := var_country
	mut state_mutated := state
	mut postcode_mutated := postcode
	mut city_mutated := city
}

fn (mut this Class_WC_Customer) set_shipping_location(var_country rt.PhpVal, state string, postcode string, city string)  {
	mut var_country_mutated := var_country
	mut state_mutated := state
	mut postcode_mutated := postcode
	mut city_mutated := city
}

fn (mut this Class_WC_Customer) set_address_prop(var_prop rt.PhpVal, var_address_type rt.PhpVal, var_value rt.PhpVal)  {
	mut var_prop_mutated := var_prop
	mut var_value_mutated := var_value
}

fn (mut this Class_WC_Customer) set_billing_first_name(var_value rt.PhpVal)  {
	mut var_value_mutated := var_value
}

fn (mut this Class_WC_Customer) set_billing_last_name(var_value rt.PhpVal)  {
	mut var_value_mutated := var_value
}

fn (mut this Class_WC_Customer) set_billing_company(var_value rt.PhpVal)  {
	mut var_value_mutated := var_value
}

fn (mut this Class_WC_Customer) set_billing_address(var_value rt.PhpVal)  {
	mut var_value_mutated := var_value
}

fn (mut this Class_WC_Customer) set_billing_address_1(var_value rt.PhpVal)  {
	mut var_value_mutated := var_value
}

fn (mut this Class_WC_Customer) set_billing_address_2(var_value rt.PhpVal)  {
	mut var_value_mutated := var_value
}

fn (mut this Class_WC_Customer) set_billing_city(var_value rt.PhpVal)  {
	mut var_value_mutated := var_value
}

fn (mut this Class_WC_Customer) set_billing_state(var_value rt.PhpVal)  {
	mut var_value_mutated := var_value
}

fn (mut this Class_WC_Customer) set_billing_postcode(var_value rt.PhpVal)  {
	mut var_value_mutated := var_value
}

fn (mut this Class_WC_Customer) set_billing_country(var_value rt.PhpVal)  {
	mut var_value_mutated := var_value
}

fn (mut this Class_WC_Customer) set_billing_email(var_value rt.PhpVal)  {
	mut var_value_mutated := var_value
}

fn (mut this Class_WC_Customer) set_billing_phone(var_value rt.PhpVal)  {
	mut var_value_mutated := var_value
}

fn (mut this Class_WC_Customer) set_shipping_first_name(var_value rt.PhpVal)  {
	mut var_value_mutated := var_value
}

fn (mut this Class_WC_Customer) set_shipping_last_name(var_value rt.PhpVal)  {
	mut var_value_mutated := var_value
}

fn (mut this Class_WC_Customer) set_shipping_company(var_value rt.PhpVal)  {
	mut var_value_mutated := var_value
}

fn (mut this Class_WC_Customer) set_shipping_address(var_value rt.PhpVal)  {
	mut var_value_mutated := var_value
}

fn (mut this Class_WC_Customer) set_shipping_address_1(var_value rt.PhpVal)  {
	mut var_value_mutated := var_value
}

fn (mut this Class_WC_Customer) set_shipping_address_2(var_value rt.PhpVal)  {
	mut var_value_mutated := var_value
}

fn (mut this Class_WC_Customer) set_shipping_city(var_value rt.PhpVal)  {
	mut var_value_mutated := var_value
}

fn (mut this Class_WC_Customer) set_shipping_state(var_value rt.PhpVal)  {
	mut var_value_mutated := var_value
}

fn (mut this Class_WC_Customer) set_shipping_postcode(var_value rt.PhpVal)  {
	mut var_value_mutated := var_value
}

fn (mut this Class_WC_Customer) set_shipping_country(var_value rt.PhpVal)  {
	mut var_value_mutated := var_value
}

fn (mut this Class_WC_Customer) set_shipping_phone(var_value rt.PhpVal)  {
	mut var_value_mutated := var_value
}

fn (mut this Class_WC_Customer) set_is_paying_customer(var_is_paying_customer rt.PhpVal)  {
}

struct Class_WC_Legacy_Customer {
	rt.PhpObjectBase
}

struct Class_WC_Data_Store {
	rt.PhpObjectBase
}

fn create_wc_customer(data i64, is_session bool) &Class_WC_Customer {
	mut obj := &Class_WC_Customer{
		PhpObjectBase: rt.PhpObjectBase{}
		data: rt.new_array()
		password: rt.new_string('')
		is_vat_exempt: rt.new_bool(false)
		calculated_shipping: rt.new_bool(false)
		object_type: rt.new_string('customer')
	}
	obj.construct(data, is_session)
	return obj
}

fn create_wc_legacy_customer() &Class_WC_Legacy_Customer {
	mut obj := &Class_WC_Legacy_Customer{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_data_store() &Class_WC_Data_Store {
	mut obj := &Class_WC_Data_Store{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Customer) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			this.construct(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'delete_and_reassign' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.delete_and_reassign(dispatch_arg_0))
		}
		'is_customer_outside_base' {
			return rt.new_bool(this.is_customer_outside_base())
		}
		'get_avatar_url' {
			return this.get_avatar_url()
		}
		'get_taxable_address' {
			return this.get_taxable_address()
		}
		'get_downloadable_products' {
			return this.get_downloadable_products()
		}
		'is_vat_exempt' {
			return this.is_vat_exempt()
		}
		'has_calculated_shipping' {
			return this.has_calculated_shipping()
		}
		'has_shipping_address' {
			return rt.new_bool(this.has_shipping_address())
		}
		'has_full_shipping_address' {
			return rt.new_bool(this.has_full_shipping_address())
		}
		'get_is_vat_exempt' {
			return this.get_is_vat_exempt()
		}
		'get_password' {
			return this.get_password()
		}
		'get_calculated_shipping' {
			return this.get_calculated_shipping()
		}
		'set_is_vat_exempt' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_is_vat_exempt(dispatch_arg_0)
			return rt.new_null()
		}
		'set_calculated_shipping' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			this.set_calculated_shipping(dispatch_arg_0)
			return rt.new_null()
		}
		'set_password' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_password(dispatch_arg_0)
			return rt.new_null()
		}
		'get_last_order' {
			return this.get_last_order()
		}
		'get_order_count' {
			return this.get_order_count()
		}
		'get_total_spent' {
			return this.get_total_spent()
		}
		'get_username' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_username(dispatch_arg_0)
		}
		'get_email' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_email(dispatch_arg_0)
		}
		'get_first_name' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_first_name(dispatch_arg_0)
		}
		'get_last_name' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_last_name(dispatch_arg_0)
		}
		'get_display_name' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_display_name(dispatch_arg_0)
		}
		'get_role' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_role(dispatch_arg_0)
		}
		'get_date_created' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_date_created(dispatch_arg_0)
		}
		'get_date_modified' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_date_modified(dispatch_arg_0)
		}
		'get_address_prop' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			return this.get_address_prop(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'get_billing' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_billing(dispatch_arg_0)
		}
		'get_billing_first_name' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_billing_first_name(dispatch_arg_0)
		}
		'get_billing_last_name' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_billing_last_name(dispatch_arg_0)
		}
		'get_billing_company' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_billing_company(dispatch_arg_0)
		}
		'get_billing_address' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_billing_address(dispatch_arg_0)
		}
		'get_billing_address_1' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_billing_address_1(dispatch_arg_0)
		}
		'get_billing_address_2' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_billing_address_2(dispatch_arg_0)
		}
		'get_billing_city' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_billing_city(dispatch_arg_0)
		}
		'get_billing_state' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_billing_state(dispatch_arg_0)
		}
		'get_billing_postcode' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_billing_postcode(dispatch_arg_0)
		}
		'get_billing_country' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_billing_country(dispatch_arg_0)
		}
		'get_billing_email' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_billing_email(dispatch_arg_0)
		}
		'get_billing_phone' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_billing_phone(dispatch_arg_0)
		}
		'get_shipping' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_shipping(dispatch_arg_0)
		}
		'get_shipping_first_name' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_shipping_first_name(dispatch_arg_0)
		}
		'get_shipping_last_name' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_shipping_last_name(dispatch_arg_0)
		}
		'get_shipping_company' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_shipping_company(dispatch_arg_0)
		}
		'get_shipping_address' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_shipping_address(dispatch_arg_0)
		}
		'get_shipping_address_1' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_shipping_address_1(dispatch_arg_0)
		}
		'get_shipping_address_2' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_shipping_address_2(dispatch_arg_0)
		}
		'get_shipping_city' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_shipping_city(dispatch_arg_0)
		}
		'get_shipping_state' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_shipping_state(dispatch_arg_0)
		}
		'get_shipping_postcode' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_shipping_postcode(dispatch_arg_0)
		}
		'get_shipping_country' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_shipping_country(dispatch_arg_0)
		}
		'get_shipping_phone' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_shipping_phone(dispatch_arg_0)
		}
		'get_is_paying_customer' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_is_paying_customer(dispatch_arg_0)
		}
		'set_username' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_username(dispatch_arg_0)
			return rt.new_null()
		}
		'set_email' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_email(dispatch_arg_0)
			return rt.new_null()
		}
		'set_first_name' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_first_name(dispatch_arg_0)
			return rt.new_null()
		}
		'set_last_name' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_last_name(dispatch_arg_0)
			return rt.new_null()
		}
		'set_display_name' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_display_name(dispatch_arg_0)
			return rt.new_null()
		}
		'set_role' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_role(dispatch_arg_0)
			return rt.new_null()
		}
		'set_date_created' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_date_created(dispatch_arg_0)
			return rt.new_null()
		}
		'set_date_modified' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_date_modified(dispatch_arg_0)
			return rt.new_null()
		}
		'set_billing_address_to_base' {
			this.set_billing_address_to_base()
			return rt.new_null()
		}
		'set_shipping_address_to_base' {
			this.set_shipping_address_to_base()
			return rt.new_null()
		}
		'set_billing_location' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).str()
			this.set_billing_location(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
			return rt.new_null()
		}
		'set_shipping_location' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).str()
			this.set_shipping_location(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
			return rt.new_null()
		}
		'set_address_prop' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			this.set_address_prop(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'set_billing_first_name' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_billing_first_name(dispatch_arg_0)
			return rt.new_null()
		}
		'set_billing_last_name' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_billing_last_name(dispatch_arg_0)
			return rt.new_null()
		}
		'set_billing_company' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_billing_company(dispatch_arg_0)
			return rt.new_null()
		}
		'set_billing_address' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_billing_address(dispatch_arg_0)
			return rt.new_null()
		}
		'set_billing_address_1' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_billing_address_1(dispatch_arg_0)
			return rt.new_null()
		}
		'set_billing_address_2' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_billing_address_2(dispatch_arg_0)
			return rt.new_null()
		}
		'set_billing_city' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_billing_city(dispatch_arg_0)
			return rt.new_null()
		}
		'set_billing_state' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_billing_state(dispatch_arg_0)
			return rt.new_null()
		}
		'set_billing_postcode' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_billing_postcode(dispatch_arg_0)
			return rt.new_null()
		}
		'set_billing_country' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_billing_country(dispatch_arg_0)
			return rt.new_null()
		}
		'set_billing_email' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_billing_email(dispatch_arg_0)
			return rt.new_null()
		}
		'set_billing_phone' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_billing_phone(dispatch_arg_0)
			return rt.new_null()
		}
		'set_shipping_first_name' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_shipping_first_name(dispatch_arg_0)
			return rt.new_null()
		}
		'set_shipping_last_name' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_shipping_last_name(dispatch_arg_0)
			return rt.new_null()
		}
		'set_shipping_company' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_shipping_company(dispatch_arg_0)
			return rt.new_null()
		}
		'set_shipping_address' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_shipping_address(dispatch_arg_0)
			return rt.new_null()
		}
		'set_shipping_address_1' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_shipping_address_1(dispatch_arg_0)
			return rt.new_null()
		}
		'set_shipping_address_2' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_shipping_address_2(dispatch_arg_0)
			return rt.new_null()
		}
		'set_shipping_city' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_shipping_city(dispatch_arg_0)
			return rt.new_null()
		}
		'set_shipping_state' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_shipping_state(dispatch_arg_0)
			return rt.new_null()
		}
		'set_shipping_postcode' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_shipping_postcode(dispatch_arg_0)
			return rt.new_null()
		}
		'set_shipping_country' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_shipping_country(dispatch_arg_0)
			return rt.new_null()
		}
		'set_shipping_phone' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_shipping_phone(dispatch_arg_0)
			return rt.new_null()
		}
		'set_is_paying_customer' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_is_paying_customer(dispatch_arg_0)
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_WC_Customer) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'data' { return this.data }
		'password' { return this.password }
		'is_vat_exempt' { return this.is_vat_exempt }
		'calculated_shipping' { return this.calculated_shipping }
		'object_type' { return this.object_type }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_Customer) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'data' { this.data = val; return true }
		'password' { this.password = val; return true }
		'is_vat_exempt' { this.is_vat_exempt = val; return true }
		'calculated_shipping' { this.calculated_shipping = val; return true }
		'object_type' { this.object_type = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_WC_Legacy_Customer) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Legacy_Customer) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Legacy_Customer) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_Data_Store) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Data_Store) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Data_Store) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_includes_class_wc_customer_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
	rt.include_file(@DIR + '/legacy/class-wc-legacy-customer.php', '4')
}
