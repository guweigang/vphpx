import rt

struct Class_Automattic_WooCommerce_StoreApi_Utilities_PaymentUtils {
	rt.PhpObjectBase
}

fn Class_Automattic_WooCommerce_StoreApi_Utilities_PaymentUtils.include_token_id_with_payment_methods(var_list_item rt.PhpVal, var_token rt.PhpVal) rt.PhpVal {
	mut var_list_item_mutated := var_list_item
	var_list_item_mutated.array_set('tokenId', rt.call_method(var_token, 'get_id', []rt.PhpVal{}))
	mut var_brand := rt.new_string(if !(!rt.is_true(var_list_item_mutated.array_get('method').array_get('brand'))) { rt.new_string(var_list_item_mutated.array_get('method').array_get('brand').to_string().to_lower()) } else { rt.new_string('') })
	if rt.is_true(rt.new_bool(!(!rt.is_true(var_brand)) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		var_list_item_mutated.array_get_mut('method').array_set('brand', rt.call_function('wc_get_credit_card_type_label', [var_brand.dup()]))
	}
	return var_list_item_mutated.dup()
}

fn Class_Automattic_WooCommerce_StoreApi_Utilities_PaymentUtils.get_enabled_payment_gateways() rt.PhpVal {
	mut var_payment_gateways := rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'payment_gateways'), 'payment_gateways', []rt.PhpVal{})
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_payment_gateway := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return rt.identical(rt.new_string('yes'), rt.get_property(var_payment_gateway, 'enabled'))
	}
	return rt.call_function('array_filter', [var_payment_gateways.dup(), rt.new_closure(closure_1_fn)])
}

fn Class_Automattic_WooCommerce_StoreApi_Utilities_PaymentUtils.get_saved_payment_methods() rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_user_logged_in', []rt.PhpVal{}))))) {
		return rt.new_null()
	}
	rt.call_function('add_filter', [rt.new_string('woocommerce_payment_methods_list_item'), rt.create_array([rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_StoreApi_Utilities_Automattic_WooCommerce_StoreApi_Utilities_PaymentUtils.class() }, rt.ArrayItem{ key: none, val: 'include_token_id_with_payment_methods' }]), rt.new_int(10), rt.new_int(2)])
	mut var_enabled_payment_gateways := Class_Automattic_WooCommerce_StoreApi_Utilities_PaymentUtils.get_enabled_payment_gateways()
	mut var_saved_payment_methods := rt.call_function('wc_get_customer_saved_methods_list', [rt.call_function('get_current_user_id', []rt.PhpVal{})])
	mut var_payment_methods := rt.create_array([rt.ArrayItem{ key: 'enabled', val: rt.new_array() }, rt.ArrayItem{ key: 'default', val: rt.new_null() }])
	{
		mut iter_1 := var_saved_payment_methods_shadow.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_saved_payment_methods_shadow := item_1.val
			mut var_payment_method_group := item_1.key
			closure_3_fn := fn [var_enabled_payment_gateways, mut var_payment_methods] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_2_fn := fn [var_enabled_payment_gateways, mut var_payment_methods] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_saved_payment_method := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_bool(true), var_saved_payment_method.array_get('is_default'))) && rt.is_true(rt.identical(rt.new_null(), var_payment_methods.array_get('default'))))) {
		var_payment_methods.array_set('default', var_saved_payment_method.dup())
	}
	return rt.call_function('in_array', [var_saved_payment_method.array_get('method').array_get('gateway'), rt.func_array_keys(var_enabled_payment_gateways.dup()), rt.new_bool(true)])
	}
	mut var_saved_payment_method := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_bool(true), var_saved_payment_method.array_get('is_default'))) && rt.is_true(rt.identical(rt.new_null(), var_payment_methods.array_get('default'))))) {
		var_payment_methods.array_set('default', var_saved_payment_method.dup())
	}
	return rt.call_function('in_array', [var_saved_payment_method.array_get('method').array_get('gateway'), rt.func_array_keys(var_enabled_payment_gateways.dup()), rt.new_bool(true)])
	}
			var_payment_methods.array_get_mut('enabled').array_set(var_payment_method_group, rt.call_function('array_values', [rt.call_function('array_filter', [var_saved_payment_methods_shadow.dup(), rt.new_closure(closure_2_fn)])]))
		}
	}
	rt.call_function('remove_filter', [rt.new_string('woocommerce_payment_methods_list_item'), rt.create_array([rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_StoreApi_Utilities_Automattic_WooCommerce_StoreApi_Utilities_PaymentUtils.class() }, rt.ArrayItem{ key: none, val: 'include_token_id_with_payment_methods' }]), rt.new_int(10), rt.new_int(2)])
	return var_payment_methods.dup()
}

fn Class_Automattic_WooCommerce_StoreApi_Utilities_PaymentUtils.get_default_payment_method() string {
	mut var_saved_payment_methods := Class_Automattic_WooCommerce_StoreApi_Utilities_PaymentUtils.get_saved_payment_methods()
	if rt.is_true(rt.new_bool(rt.is_true(var_saved_payment_methods) && !(!rt.is_true(var_saved_payment_methods.array_get('default'))))) {
		return (if !(var_saved_payment_methods.array_get('default').array_get('method').array_get('gateway')).is_null() { var_saved_payment_methods.array_get('default').array_get('method').array_get('gateway') } else { rt.new_string('') }).str()
	}
	mut var_chosen_payment_method := rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'session'), 'get', [rt.new_string('chosen_payment_method')])
	if rt.is_true(var_chosen_payment_method) {
		return (var_chosen_payment_method).str()
	}
	mut var_enabled_payment_gateways := Class_Automattic_WooCommerce_StoreApi_Utilities_PaymentUtils.get_enabled_payment_gateways()
	if !rt.is_true(var_enabled_payment_gateways) {
		return ''
	}
	mut var_first_key := rt.call_function('array_key_first', [var_enabled_payment_gateways.dup()])
	mut var_first_payment_method := var_enabled_payment_gateways.array_get(var_first_key)
	return (if !(rt.get_property(var_first_payment_method, 'id')).is_null() { rt.get_property(var_first_payment_method, 'id') } else { rt.new_string('') }).str()
}

fn create_automattic_woocommerce_storeapi_utilities_paymentutils() &Class_Automattic_WooCommerce_StoreApi_Utilities_PaymentUtils {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Utilities_PaymentUtils{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_PaymentUtils) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'include_token_id_with_payment_methods' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_StoreApi_Utilities_PaymentUtils.include_token_id_with_payment_methods(dispatch_arg_0, dispatch_arg_1)
		}
		'get_enabled_payment_gateways' {
			return Class_Automattic_WooCommerce_StoreApi_Utilities_PaymentUtils.get_enabled_payment_gateways()
		}
		'get_saved_payment_methods' {
			return Class_Automattic_WooCommerce_StoreApi_Utilities_PaymentUtils.get_saved_payment_methods()
		}
		'get_default_payment_method' {
			return rt.new_string(Class_Automattic_WooCommerce_StoreApi_Utilities_PaymentUtils.get_default_payment_method())
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Utilities_PaymentUtils) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_PaymentUtils) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_storeapi_utilities_paymentutils_php() {
	// unsupported statement: Stmt_Declare
}
