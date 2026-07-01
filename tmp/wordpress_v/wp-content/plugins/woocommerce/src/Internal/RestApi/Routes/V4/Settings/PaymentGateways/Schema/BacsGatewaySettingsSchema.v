import rt

struct Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_PaymentGateways_Schema_BacsGatewaySettingsSchema {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_PaymentGateways_Schema_BacsGatewaySettingsSchema) get_custom_groups_for_gateway(mut var_gateway Class_WC_Payment_Gateway) rt.PhpVal {
	mut var_core_field_overrides := rt.create_array([rt.ArrayItem{ key: 'enabled', val: rt.create_array([rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('Enable/Disable'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'checkbox' }, rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [rt.new_string('Enable Direct bank transfer at checkout'), rt.new_string('woocommerce')]) }]) }, rt.ArrayItem{ key: 'title', val: rt.create_array([rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('Checkout label'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'text' }, rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [rt.new_string('Shown to customers on the payment methods list at checkout.'), rt.new_string('woocommerce')]) }]) }, rt.ArrayItem{ key: 'description', val: rt.create_array([rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('Checkout instructions'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'text' }, rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [rt.new_string('Shown below the checkout label.'), rt.new_string('woocommerce')]) }]) }, rt.ArrayItem{ key: 'order', val: rt.create_array([rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('Order'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'number' }, rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [rt.new_string('Determines the display order of payment gateways during checkout.'), rt.new_string('woocommerce')]) }]) }, rt.ArrayItem{ key: 'instructions', val: rt.create_array([rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('Order confirmation instructions'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'text' }, rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [rt.new_string('Shown on the order confirmation page and in order emails.'), rt.new_string('woocommerce')]) }]) }])
	mut var_fields := this.build_fields_from_form_fields(rt.new_object('WC_Payment_Gateway', []string{}, var_gateway), var_core_field_overrides.dup(), rt.create_array([rt.ArrayItem{ key: none, val: 'account_details' }]))
	mut var_settings_group := rt.create_array([rt.ArrayItem{ key: 'title', val: rt.call_function('__', [rt.new_string('Direct bank transfer settings'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Manage how Direct bank transfer appears at checkout and in order emails.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'order', val: 1 }, rt.ArrayItem{ key: 'fields', val: var_fields }])
	mut var_field := if !(rt.get_property(var_gateway, 'form_fields').array_get('account_details')).is_null() { rt.get_property(var_gateway, 'form_fields').array_get('account_details') } else { rt.new_array() }
	mut var_account_details_group := rt.create_array([rt.ArrayItem{ key: 'title', val: rt.call_function('__', [rt.new_string('Bank account details'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Manage the bank accounts customers can use to pay by bank transfer.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'order', val: 2 }, rt.ArrayItem{ key: 'fields', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'id', val: 'account_details' }, rt.ArrayItem{ key: 'label', val: if !(var_field.array_get('title')).is_null() { var_field.array_get('title') } else { rt.call_function('__', [rt.new_string('Account details'), rt.new_string('woocommerce')]) } }, rt.ArrayItem{ key: 'type', val: 'array' }, rt.ArrayItem{ key: 'desc', val: if !(var_field.array_get('description')).is_null() { var_field.array_get('description') } else { rt.call_function('__', [rt.new_string('Bank account details for direct bank transfer.'), rt.new_string('woocommerce')]) } }]) }]) }])
	return rt.create_array([rt.ArrayItem{ key: 'settings', val: var_settings_group }, rt.ArrayItem{ key: 'account_details', val: var_account_details_group }])
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_PaymentGateways_Schema_BacsGatewaySettingsSchema) get_special_field_values(mut var_gateway Class_WC_Payment_Gateway) rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: 'account_details', val: rt.call_function('get_option', [rt.new_string('woocommerce_bacs_accounts'), rt.new_array()]) }])
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_PaymentGateways_Schema_BacsGatewaySettingsSchema) is_special_field(field_id string) bool {
	return (rt.identical(rt.new_string('account_details'), rt.new_string(field_id))).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_PaymentGateways_Schema_BacsGatewaySettingsSchema) validate_and_sanitize_special_fields(mut var_gateway Class_WC_Payment_Gateway, mut var_values Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_PaymentGateways_Schema_array) rt.PhpVal {
	mut var_validated := rt.new_array()
	{
		mut iter_1 := var_values.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_value := item_1.val
			mut var_field_id := item_1.key
			if rt.is_true(rt.identical(rt.new_string('account_details'), var_field_id)) {
				var_validated.array_set(var_field_id, this.validate_bacs_accounts(var_value.dup()))
				if rt.is_true(rt.call_function('is_wp_error', [var_validated.array_get(var_field_id)])) {
					return var_validated.array_get(var_field_id)
				}
			}
		}
	}
	return var_validated.dup()
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_PaymentGateways_Schema_BacsGatewaySettingsSchema) update_special_fields(mut var_gateway Class_WC_Payment_Gateway, mut var_values Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_PaymentGateways_Schema_array)  {
	{
		mut iter_1 := var_values.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_value := item_1.val
			mut var_field_id := item_1.key
			if rt.is_true(rt.identical(rt.new_string('account_details'), var_field_id)) {
				rt.call_function('update_option', [rt.new_string('woocommerce_bacs_accounts'), var_value.dup()])
			}
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_PaymentGateways_Schema_BacsGatewaySettingsSchema) validate_bacs_accounts(var_value rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_value.dup().is_array()))))) {
		return create_wp_error(rt.new_string('rest_invalid_param'), rt.call_function('__', [rt.new_string('Account details must be an array.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }]))
	}
	mut var_validated_accounts := rt.new_array()
	mut var_valid_fields := rt.create_array([rt.ArrayItem{ key: none, val: 'account_name' }, rt.ArrayItem{ key: none, val: 'account_number' }, rt.ArrayItem{ key: none, val: 'sort_code' }, rt.ArrayItem{ key: none, val: 'bank_name' }, rt.ArrayItem{ key: none, val: 'iban' }, rt.ArrayItem{ key: none, val: 'bic' }])
	{
		mut iter_1 := var_value.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_account := item_1.val
			mut var_index := item_1.key
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_account.dup().is_array()))))) {
				return create_wp_error(rt.new_string('rest_invalid_param'), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Account at index %d must be an object.'), rt.new_string('woocommerce')]), var_index.dup()]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }]))
			}
			mut var_validated_account := rt.new_array()
			{
				mut iter_2 := var_valid_fields.iterator()
				for {
					item_2 := iter_2.next() or { break }
					mut var_field := item_2.val
					var_validated_account.array_set(var_field, if var_account.array_isset(var_field) { rt.call_function('sanitize_text_field', [var_account.array_get(var_field)]) } else { rt.new_string('') })
				}
			}
			if rt.is_true(rt.call_function('array_filter', [var_validated_account.dup()])) {
				var_validated_accounts.array_push(var_validated_account.dup())
			}
		}
	}
	return var_validated_accounts.dup()
}

struct Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_PaymentGateways_Schema_AbstractPaymentGatewaySettingsSchema {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_restapi_routes_v4_settings_paymentgateways_schema_bacsgatewaysettingsschema() &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_PaymentGateways_Schema_BacsGatewaySettingsSchema {
	mut obj := &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_PaymentGateways_Schema_BacsGatewaySettingsSchema{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_restapi_routes_v4_settings_paymentgateways_schema_abstractpaymentgatewaysettingsschema() &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_PaymentGateways_Schema_AbstractPaymentGatewaySettingsSchema {
	mut obj := &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_PaymentGateways_Schema_AbstractPaymentGatewaySettingsSchema{
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

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_PaymentGateways_Schema_BacsGatewaySettingsSchema) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_custom_groups_for_gateway' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Payment_Gateway](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.get_custom_groups_for_gateway(mut dispatch_arg_0)
		}
		'get_special_field_values' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Payment_Gateway](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.get_special_field_values(mut dispatch_arg_0)
		}
		'is_special_field' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(this.is_special_field(dispatch_arg_0))
		}
		'validate_and_sanitize_special_fields' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Payment_Gateway](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_PaymentGateways_Schema_array](if args.len > 1 { args[1] } else { rt.new_null() })
			return this.validate_and_sanitize_special_fields(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		'update_special_fields' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Payment_Gateway](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_PaymentGateways_Schema_array](if args.len > 1 { args[1] } else { rt.new_null() })
			this.update_special_fields(mut dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'validate_bacs_accounts' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.validate_bacs_accounts(dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_PaymentGateways_Schema_BacsGatewaySettingsSchema) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_PaymentGateways_Schema_BacsGatewaySettingsSchema) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_PaymentGateways_Schema_AbstractPaymentGatewaySettingsSchema) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_PaymentGateways_Schema_AbstractPaymentGatewaySettingsSchema) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_PaymentGateways_Schema_AbstractPaymentGatewaySettingsSchema) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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




pub fn init_wp_content_plugins_woocommerce_src_internal_restapi_routes_v4_settings_paymentgateways_schema_bacsgatewaysettingsschema_php() {
	// unsupported statement: Stmt_Declare
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
