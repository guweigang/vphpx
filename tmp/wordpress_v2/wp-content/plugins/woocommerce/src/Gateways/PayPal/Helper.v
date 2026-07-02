import rt

struct Class_Automattic_WooCommerce_Gateways_PayPal_Helper {
	rt.PhpObjectBase
}

fn Class_Automattic_WooCommerce_Gateways_PayPal_Helper.is_country_supported_by_paypal(country_code string) bool {
	return Class_Automattic_WooCommerce_Gateways_PayPal_Constants.supported_countries().array_isset(rt.new_string(country_code))
}

fn Class_Automattic_WooCommerce_Gateways_PayPal_Helper.is_paypal_gateway_available() bool {
	mut var_settings := rt.call_function('get_option', [rt.new_string('woocommerce_paypal_settings'), rt.new_array()])
	mut var_enabled := rt.new_bool(var_settings.array_isset(rt.new_string('enabled')) && rt.is_true(rt.identical(rt.new_string('yes'), var_settings.array_get(rt.new_string('enabled')))))
	mut var_should_load := rt.new_bool(var_settings.array_isset(rt.new_string('_should_load')) && rt.is_true(rt.identical(rt.new_string('yes'), var_settings.array_get(rt.new_string('_should_load')))))
	return rt.is_true(var_enabled) && rt.is_true(var_should_load)
}

fn Class_Automattic_WooCommerce_Gateways_PayPal_Helper.is_orders_v2_migration_eligible() bool {
	mut var_settings := rt.call_function('get_option', [rt.new_string('woocommerce_paypal_settings'), rt.new_array()])
	mut var_is_test_mode := rt.new_bool(var_settings.array_isset(rt.new_string('testmode')) && rt.is_true(rt.identical(rt.new_string('yes'), var_settings.array_get(rt.new_string('testmode')))))
	mut var_api_username := if rt.is_true(var_is_test_mode) { if !(var_settings.array_get(rt.new_string('sandbox_api_username'))).is_null() { var_settings.array_get(rt.new_string('sandbox_api_username')) } else { rt.new_null() } } else { if !(var_settings.array_get(rt.new_string('api_username'))).is_null() { var_settings.array_get(rt.new_string('api_username')) } else { rt.new_null() } }
	mut var_api_password := if rt.is_true(var_is_test_mode) { if !(var_settings.array_get(rt.new_string('sandbox_api_password'))).is_null() { var_settings.array_get(rt.new_string('sandbox_api_password')) } else { rt.new_null() } } else { if !(var_settings.array_get(rt.new_string('api_password'))).is_null() { var_settings.array_get(rt.new_string('api_password')) } else { rt.new_null() } }
	mut var_api_signature := if rt.is_true(var_is_test_mode) { if !(var_settings.array_get(rt.new_string('sandbox_api_signature'))).is_null() { var_settings.array_get(rt.new_string('sandbox_api_signature')) } else { rt.new_null() } } else { if !(var_settings.array_get(rt.new_string('api_signature'))).is_null() { var_settings.array_get(rt.new_string('api_signature')) } else { rt.new_null() } }
	return !rt.is_true(var_api_username) && !rt.is_true(var_api_password) && !rt.is_true(var_api_signature)
}

fn Class_Automattic_WooCommerce_Gateways_PayPal_Helper.get_wc_order_from_paypal_custom_id(custom_id string) rt.PhpVal {
	if rt.is_true(rt.identical(rt.new_string(''), rt.new_string(custom_id))) {
		return rt.new_null()
	}
	mut var_data := rt.call_function('json_decode', [rt.new_string(custom_id), rt.new_bool(true)])
	if !(var_data.clone().is_array()) {
		return rt.new_null()
	}
	mut var_order_id := if !(var_data.array_get(rt.new_string('order_id'))).is_null() { var_data.array_get(rt.new_string('order_id')) } else { rt.new_null() }
	if rt.is_true(rt.new_bool(!(rt.is_true(var_order_id)))) {
		return rt.new_null()
	}
	mut var_order := rt.call_function('wc_get_order', [var_order_id.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_order, 'WC_Order')))))) {
		return rt.new_null()
	}
	mut var_order_key := if !(var_data.array_get(rt.new_string('order_key'))).is_null() { var_data.array_get(rt.new_string('order_key')) } else { rt.new_null() }
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_order_key, rt.call_method(var_order, 'get_order_key', []rt.PhpVal{}))))) {
		return rt.new_null()
	}
	return var_order.clone()
}

fn Class_Automattic_WooCommerce_Gateways_PayPal_Helper.redact_data(var_data rt.PhpVal) rt.PhpVal {
	mut var_data_mutated := var_data
	if !(var_data_mutated.clone().is_array()) {
		return var_data_mutated.clone()
	}
	mut var_redacted_data := rt.new_array()
	mut iter_1 := var_data_mutated.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_value := item_1.val
		mut var_key := item_1.key
		if rt.is_true(rt.identical(rt.new_string('payee'), var_key)) {
			var_redacted_data.array_set(var_key, var_value.clone())
			continue
		}
		if rt.is_true(rt.identical(rt.new_string('email_address'), var_key)) || rt.is_true(rt.identical(rt.new_string('email'), var_key)) {
			var_redacted_data.array_set(var_key, Class_Automattic_WooCommerce_Gateways_PayPal_Helper.mask_email((var_value).str()))
			continue
		}
		if rt.is_true(rt.new_bool(var_value.clone().is_array())) {
			var_redacted_data.array_set(var_key, Class_Automattic_WooCommerce_Gateways_PayPal_Helper.redact_data(var_value.clone()))
		} else if rt.is_true(rt.call_function('in_array', [var_key.clone(), Class_Automattic_WooCommerce_Gateways_PayPal_Constants.fields_to_redact(), rt.new_bool(true)])) {
			var_redacted_data.array_set(var_key, '[redacted]')
		} else {
			var_redacted_data.array_set(var_key, var_value.clone())
		}
	}
	return var_redacted_data.clone()
}

fn Class_Automattic_WooCommerce_Gateways_PayPal_Helper.mask_email(email string) string {
	mut var_local := rt.new_null()
	mut var_domain := rt.new_null()
	mut email_mutated := email
	if email_mutated == '' {
		return email_mutated
	}
	mut var_parts := rt.call_function('explode', [rt.new_string('@'), rt.new_string(email_mutated).clone(), rt.new_int(2)])
	if rt.is_true(rt.new_bool(var_parts.clone().array_count() != 2)) || !rt.is_true(var_parts.array_get(rt.new_int(0))) || !rt.is_true(var_parts.array_get(rt.new_int(1))) {
		return email_mutated
	}
	mut list_tmp_1 := var_parts
	var_local = (list_tmp_1).array_get(0)
	var_domain = (list_tmp_1).array_get(1)
	if var_local.clone().to_string().len <= 3 {
	mut var_masked_local := rt.call_function('str_repeat', [rt.new_string('*'), rt.new_int(var_local.clone().to_string().len)])
	} else {
	var_masked_local = rt.new_string((rt.call_function('substr', [var_local.clone(), rt.new_int(0), rt.new_int(2)])).str() + (rt.call_function('str_repeat', [rt.new_string('*'), rt.call_function('max', [rt.new_int(1), rt.new_int(var_local.clone().to_string().len - 3)])])).str() + (rt.call_function('substr', [var_local.clone(), rt.new_int(-1)])).str())
	}
	return (var_masked_local).str() + '@' + (var_domain).str()
}

fn Class_Automattic_WooCommerce_Gateways_PayPal_Helper.update_addresses_in_order(mut var_order Class_Automattic_WooCommerce_Gateways_PayPal_?WC_Order, mut var_paypal_order_details Class_Automattic_WooCommerce_Gateways_PayPal_array) {
	mut var_order_mutated := var_order
	if !rt.is_true(var_order_mutated) || !rt.is_true(var_paypal_order_details) {
		return
	}
	if rt.is_true(rt.identical(rt.new_string('yes'), rt.call_method(var_order_mutated, 'get_meta', [Class_Automattic_WooCommerce_Gateways_PayPal_Constants.paypal_order_meta_addresses_updated(), rt.new_bool(true)]))) {
		return
	}
	mut var_full_name := if !(var_paypal_order_details.array_get(rt.new_string('purchase_units')).array_get(rt.new_int(0)).array_get(rt.new_string('shipping')).array_get(rt.new_string('name')).array_get(rt.new_string('full_name'))).is_null() { var_paypal_order_details.array_get(rt.new_string('purchase_units')).array_get(rt.new_int(0)).array_get(rt.new_string('shipping')).array_get(rt.new_string('name')).array_get(rt.new_string('full_name')) } else { rt.new_string('') }
	if !(!rt.is_true(var_full_name)) {
		mut var_name_parts := rt.call_function('explode', [rt.new_string(' '), var_full_name.clone(), rt.new_int(2)])
		mut var_approximate_first_name := if !(var_name_parts.array_get(rt.new_int(0))).is_null() { var_name_parts.array_get(rt.new_int(0)) } else { rt.new_string('') }
		mut var_approximate_last_name := if var_name_parts.array_isset(rt.new_int(1)) { var_name_parts.array_get(rt.new_int(1)) } else { rt.new_string('') }
		rt.call_method(var_order_mutated, 'set_shipping_first_name', [var_approximate_first_name.clone()])
		rt.call_method(var_order_mutated, 'set_shipping_last_name', [var_approximate_last_name.clone()])
	}
	mut var_shipping_address := if !(var_paypal_order_details.array_get(rt.new_string('purchase_units')).array_get(rt.new_int(0)).array_get(rt.new_string('shipping')).array_get(rt.new_string('address'))).is_null() { var_paypal_order_details.array_get(rt.new_string('purchase_units')).array_get(rt.new_int(0)).array_get(rt.new_string('shipping')).array_get(rt.new_string('address')) } else { rt.new_array() }
	if !(!rt.is_true(var_shipping_address)) {
		rt.call_method(var_order_mutated, 'set_shipping_country', [if !(var_shipping_address.array_get(rt.new_string('country_code'))).is_null() { var_shipping_address.array_get(rt.new_string('country_code')) } else { rt.new_string('') }])
		rt.call_method(var_order_mutated, 'set_shipping_postcode', [if !(var_shipping_address.array_get(rt.new_string('postal_code'))).is_null() { var_shipping_address.array_get(rt.new_string('postal_code')) } else { rt.new_string('') }])
		rt.call_method(var_order_mutated, 'set_shipping_state', [if !(var_shipping_address.array_get(rt.new_string('admin_area_1'))).is_null() { var_shipping_address.array_get(rt.new_string('admin_area_1')) } else { rt.new_string('') }])
		rt.call_method(var_order_mutated, 'set_shipping_city', [if !(var_shipping_address.array_get(rt.new_string('admin_area_2'))).is_null() { var_shipping_address.array_get(rt.new_string('admin_area_2')) } else { rt.new_string('') }])
		rt.call_method(var_order_mutated, 'set_shipping_address_1', [if !(var_shipping_address.array_get(rt.new_string('address_line_1'))).is_null() { var_shipping_address.array_get(rt.new_string('address_line_1')) } else { rt.new_string('') }])
		rt.call_method(var_order_mutated, 'set_shipping_address_2', [if !(var_shipping_address.array_get(rt.new_string('address_line_2'))).is_null() { var_shipping_address.array_get(rt.new_string('address_line_2')) } else { rt.new_string('') }])
	}
	var_full_name = if !(var_paypal_order_details.array_get(rt.new_string('payer')).array_get(rt.new_string('name'))).is_null() { var_paypal_order_details.array_get(rt.new_string('payer')).array_get(rt.new_string('name')) } else { rt.new_array() }
	mut var_email := if !(var_paypal_order_details.array_get(rt.new_string('payer')).array_get(rt.new_string('email_address'))).is_null() { var_paypal_order_details.array_get(rt.new_string('payer')).array_get(rt.new_string('email_address')) } else { rt.new_string('') }
	if !(!rt.is_true(var_full_name)) {
		rt.call_method(var_order_mutated, 'set_billing_first_name', [if !(var_full_name.array_get(rt.new_string('given_name'))).is_null() { var_full_name.array_get(rt.new_string('given_name')) } else { rt.new_string('') }])
		rt.call_method(var_order_mutated, 'set_billing_last_name', [if !(var_full_name.array_get(rt.new_string('surname'))).is_null() { var_full_name.array_get(rt.new_string('surname')) } else { rt.new_string('') }])
		rt.call_method(var_order_mutated, 'set_billing_email', [var_email.clone()])
	}
	mut var_billing_address := if !(var_paypal_order_details.array_get(rt.new_string('payer')).array_get(rt.new_string('address'))).is_null() { var_paypal_order_details.array_get(rt.new_string('payer')).array_get(rt.new_string('address')) } else { rt.new_array() }
	if !(!rt.is_true(var_billing_address)) {
		rt.call_method(var_order_mutated, 'set_billing_country', [if !(var_billing_address.array_get(rt.new_string('country_code'))).is_null() { var_billing_address.array_get(rt.new_string('country_code')) } else { rt.new_string('') }])
		rt.call_method(var_order_mutated, 'set_billing_postcode', [if !(var_billing_address.array_get(rt.new_string('postal_code'))).is_null() { var_billing_address.array_get(rt.new_string('postal_code')) } else { rt.new_string('') }])
		rt.call_method(var_order_mutated, 'set_billing_state', [if !(var_billing_address.array_get(rt.new_string('admin_area_1'))).is_null() { var_billing_address.array_get(rt.new_string('admin_area_1')) } else { rt.new_string('') }])
		rt.call_method(var_order_mutated, 'set_billing_city', [if !(var_billing_address.array_get(rt.new_string('admin_area_2'))).is_null() { var_billing_address.array_get(rt.new_string('admin_area_2')) } else { rt.new_string('') }])
		rt.call_method(var_order_mutated, 'set_billing_address_1', [if !(var_billing_address.array_get(rt.new_string('address_line_1'))).is_null() { var_billing_address.array_get(rt.new_string('address_line_1')) } else { rt.new_string('') }])
		rt.call_method(var_order_mutated, 'set_billing_address_2', [if !(var_billing_address.array_get(rt.new_string('address_line_2'))).is_null() { var_billing_address.array_get(rt.new_string('address_line_2')) } else { rt.new_string('') }])
	}
	rt.call_method(var_order_mutated, 'update_meta_data', [Class_Automattic_WooCommerce_Gateways_PayPal_Constants.paypal_order_meta_addresses_updated(), rt.new_string('yes')])
	rt.call_method(var_order_mutated, 'save', []rt.PhpVal{})
}

fn create_automattic_woocommerce_gateways_paypal_helper(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Gateways_PayPal_Helper {
	mut obj := &Class_Automattic_WooCommerce_Gateways_PayPal_Helper{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Gateways_PayPal_Helper) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'is_country_supported_by_paypal' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(Class_Automattic_WooCommerce_Gateways_PayPal_Helper.is_country_supported_by_paypal(dispatch_arg_0))
		}
		'is_paypal_gateway_available' {
			return rt.new_bool(Class_Automattic_WooCommerce_Gateways_PayPal_Helper.is_paypal_gateway_available())
		}
		'is_orders_v2_migration_eligible' {
			return rt.new_bool(Class_Automattic_WooCommerce_Gateways_PayPal_Helper.is_orders_v2_migration_eligible())
		}
		'get_wc_order_from_paypal_custom_id' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return Class_Automattic_WooCommerce_Gateways_PayPal_Helper.get_wc_order_from_paypal_custom_id(dispatch_arg_0)
		}
		'redact_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Gateways_PayPal_Helper.redact_data(dispatch_arg_0)
		}
		'mask_email' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(Class_Automattic_WooCommerce_Gateways_PayPal_Helper.mask_email(dispatch_arg_0))
		}
		'update_addresses_in_order' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Gateways_PayPal_?WC_Order](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Gateways_PayPal_array](if args.len > 1 { args[1] } else { rt.new_null() })
			Class_Automattic_WooCommerce_Gateways_PayPal_Helper.update_addresses_in_order(mut dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Gateways_PayPal_Helper) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Gateways_PayPal_Helper) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}



fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(exit(0)))
}
