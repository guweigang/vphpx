import rt

struct Class_WC_Payment_Gateways {
	rt.PhpObjectBase
pub mut:
	payment_gateways rt.PhpVal = rt.new_array()
}

fn init_static_wc_payment_gateways() {
	rt.init_static_prop('WC_Payment_Gateways', '_instance', rt.new_null())
}

fn Class_WC_Payment_Gateways.instance() rt.PhpVal {
	if rt.is_true(rt.new_bool(rt.get_static_prop('WC_Payment_Gateways', '_instance').is_null())) {
		rt.set_static_prop('WC_Payment_Gateways', '_instance', rt.new_object('WC_Payment_Gateways',
			[]string{}, create_wc_payment_gateways()))
	}
	return rt.get_static_prop('WC_Payment_Gateways', '_instance')
}

fn (mut this Class_WC_Payment_Gateways) magic_clone() {
	rt.call_function('wc_doing_it_wrong', [rt.new_string(@FN),
		rt.call_function('__', [rt.new_string('Cloning is forbidden.'),
			rt.new_string('woocommerce')]),
		rt.new_string('2.1')])
}

fn (mut this Class_WC_Payment_Gateways) magic_wakeup() {
	rt.call_function('wc_doing_it_wrong', [rt.new_string(@FN),
		rt.call_function('__', [
			rt.new_string('Unserializing instances of this class is forbidden.'),
			rt.new_string('woocommerce'),
		]),
		rt.new_string('2.1')])
}

fn (mut this Class_WC_Payment_Gateways) construct() {
	this.init()
}

fn (mut this Class_WC_Payment_Gateways) init() {
	mut var_load_gateways := rt.create_array([
		rt.ArrayItem{ key: none, val: 'WC_Gateway_BACS' },
		rt.ArrayItem{ key: none, val: 'WC_Gateway_Cheque' },
		rt.ArrayItem{ key: none, val: 'WC_Gateway_COD' },
		rt.ArrayItem{ key: none, val: 'WC_Gateway_Paypal' },
	])
	var_load_gateways = rt.call_function('apply_filters', [
		rt.new_string('woocommerce_payment_gateways'),
		var_load_gateways.clone(),
	])
	mut var_ordering := rt.cast_array(rt.call_function('get_option', [
		rt.new_string('woocommerce_gateway_order'),
	]))
	mut var_order_end := rt.new_int(999)
	mut iter_1 := var_load_gateways.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_gateway := item_1.val
		if var_gateway.clone().is_string()
			&& rt.is_true(rt.call_function('class_exists', [var_gateway.clone()])) {
			var_gateway = rt.create_object_dynamically(var_gateway, []rt.PhpVal{})
		}
		if rt.is_true(rt.call_function('is_a', [var_gateway.clone(),
			rt.new_string('WC_Gateway_Paypal')]))
		{
			mut iife_temp_0 := Class_WC_Gateway_Paypal{}
			mut iife_result_0 := iife_temp_0.set_instance(var_gateway.clone())
			if rt.is_true(rt.new_bool(!(rt.is_true(this.should_load_paypal_standard())))) {
				continue
			}
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_a', [
			var_gateway.clone(), rt.new_string('WC_Payment_Gateway')])))))
		{
			continue
		}
		if var_ordering.array_isset(rt.get_property(var_gateway, 'id'))
			&& var_ordering.array_get(rt.get_property(var_gateway, 'id')).is_long()
			|| var_ordering.array_get(rt.get_property(var_gateway, 'id')).is_double() {
			this.payment_gateways.array_set(var_ordering.array_get(rt.get_property(var_gateway,
				'id')), var_gateway.clone())
		} else {
			this.payment_gateways.array_set(var_order_end, var_gateway.clone())
			rt.pre_inc(var_order_end)
		}
	}
	rt.call_function('ksort', [this.payment_gateways])
	rt.call_function('add_action', [rt.new_string('wc_payment_gateways_initialized'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Payment_Gateways', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'on_payment_gateways_initialized' },
		])])
	rt.call_function('do_action', [rt.new_string('wc_payment_gateways_initialized'),
		rt.new_object('WC_Payment_Gateways', []string{}, &this)])
}

fn (mut this Class_WC_Payment_Gateways) on_payment_gateways_initialized(mut var_wc_payment_gateways Class_WC_Payment_Gateways) {
	mut iter_2 := this.payment_gateways.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_gateway := item_2.val
		mut var_option_key := rt.call_method(var_gateway, 'get_option_key', []rt.PhpVal{})
		closure_2_fn := fn [var_gateway] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_option := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			mut var_value := if args.len > 1 { args[1].clone() } else { rt.new_null() }
			this.payment_gateway_settings_option_changed(var_gateway.clone(), var_value.clone(),
				var_option.clone(), rt.new_null())
			return rt.new_null()
		}
		rt.call_function('add_action', [
			rt.new_string('add_option_' + var_option_key.str()),
			rt.new_closure(closure_2_fn),
			rt.new_int(10),
			rt.new_int(2),
		])
		closure_3_fn := fn [var_gateway] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_old_value := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			mut var_value := if args.len > 1 { args[1].clone() } else { rt.new_null() }
			mut var_option := if args.len > 2 { args[2].clone() } else { rt.new_null() }
			this.payment_gateway_settings_option_changed(var_gateway.clone(), var_value.clone(),
				var_option.clone(), var_old_value.clone())
			return rt.new_null()
		}
		rt.call_function('add_action', [
			rt.new_string('update_option_' + var_option_key.str()),
			rt.new_closure(closure_3_fn),
			rt.new_int(10),
			rt.new_int(3),
		])
	}
}

fn (mut this Class_WC_Payment_Gateways) payment_gateway_settings_option_changed(var_gateway rt.PhpVal, var_value rt.PhpVal, var_option rt.PhpVal, var_old_value rt.PhpVal) {
	mut var_gateway_mutated := var_gateway
	if this.was_gateway_enabled(var_value.clone(), var_old_value.clone()) {
		mut var_logger := rt.call_method(rt.call_method(rt.call_function('wc_get_container',
			[]rt.PhpVal{}), 'get', [
			Class_Automattic_WooCommerce_Proxies_LegacyProxy.class(),
		]), 'call_function', [rt.new_string('wc_get_logger')])
		rt.call_method(var_logger, 'info', [
			rt.call_function('sprintf', [rt.new_string('Payment gateway enabled: "%s"'),
				rt.call_method(var_gateway_mutated, 'get_method_title', []rt.PhpVal{})]),
		])
		rt.call_function('do_action', [
			rt.new_string('woocommerce_payment_gateway_enabled'),
			var_gateway_mutated.clone(),
		])
		this.record_gateway_event('enable', var_gateway_mutated.clone())
	}
	if this.was_gateway_disabled(var_value.clone(), var_old_value.clone()) {
		this.record_gateway_event('disable', var_gateway_mutated.clone())
	}
}

fn (mut this Class_WC_Payment_Gateways) was_gateway_enabled(var_value rt.PhpVal, var_old_value rt.PhpVal) bool {
	if rt.is_true(rt.identical(rt.new_null(), var_old_value)) {
		if !(!rt.is_true(var_value)) && var_value.clone().is_array()
			&& var_value.array_isset(rt.new_string('enabled'))
			&& rt.is_true(rt.identical(rt.new_string('yes'), var_value.array_get(rt.new_string('enabled'))))
			&& var_value.array_isset(rt.new_string('title')) {
			return true
		}
		return false
	}
	mut iife_temp_3 := Class_Automattic_WooCommerce_Utilities_ArrayUtil{}
	mut iife_result_3 := iife_temp_3.get_value_or_default(var_value.clone(),
		rt.new_string('enabled'))
	mut iife_temp_4 := Class_Automattic_WooCommerce_Utilities_ArrayUtil{}
	mut iife_result_4 := iife_temp_4.get_value_or_default(var_old_value.clone(),
		rt.new_string('enabled'))
	if rt.is_true(rt.identical(iife_result_3, rt.new_string('yes')))
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(iife_result_4, rt.new_string('yes'))))) {
		return true
	}
	return false
}

fn (mut this Class_WC_Payment_Gateways) was_gateway_disabled(var_value rt.PhpVal, var_old_value rt.PhpVal) bool {
	if rt.is_true(rt.identical(rt.new_null(), var_old_value)) {
		return false
	}
	mut iife_temp_5 := Class_Automattic_WooCommerce_Utilities_ArrayUtil{}
	mut iife_result_5 := iife_temp_5.get_value_or_default(var_value.clone(),
		rt.new_string('enabled'))
	mut iife_temp_6 := Class_Automattic_WooCommerce_Utilities_ArrayUtil{}
	mut iife_result_6 := iife_temp_6.get_value_or_default(var_old_value.clone(),
		rt.new_string('enabled'))
	if rt.is_true(rt.identical(iife_result_5, rt.new_string('no')))
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(iife_result_6, rt.new_string('no'))))) {
		return true
	}
	return false
}

fn (mut this Class_WC_Payment_Gateways) payment_gateways() rt.PhpVal {
	mut var__available_gateways := rt.new_array()
	if this.payment_gateways.array_count() > 0 {
		mut iter_3 := this.payment_gateways.iterator()
		for {
			item_3 := iter_3.next() or { break }
			mut var_gateway := item_3.val
			var__available_gateways.array_set(rt.get_property(var_gateway, 'id'),
				var_gateway.clone())
		}
	}
	return var__available_gateways.clone()
}

fn (mut this Class_WC_Payment_Gateways) get_payment_gateway_name_by_id(payment_gateway_id string) string {
	mut var_payment_gateways := this.payment_gateways()
	if var_payment_gateways.array_isset(rt.new_string(payment_gateway_id)) {
		mut var_gateway := var_payment_gateways.array_get(rt.new_string(payment_gateway_id))
		if var_gateway.clone().is_object()
			&& rt.is_true(rt.call_function('method_exists', [var_gateway.clone(), rt.new_string('get_title')])) {
			return (rt.call_method(var_gateway, 'get_title', []rt.PhpVal{})).str()
		} else if var_gateway.clone().is_object()
			&& !(rt.get_property(var_gateway, 'title')).is_null() {
			return (rt.get_property(var_gateway, 'title')).str()
		}
	}
	return payment_gateway_id
}

fn (mut this Class_WC_Payment_Gateways) get_payment_gateway_ids() rt.PhpVal {
	return rt.call_function('wp_list_pluck', [this.payment_gateways, rt.new_string('id')])
}

fn (mut this Class_WC_Payment_Gateways) get_available_payment_gateways() rt.PhpVal {
	mut var__available_gateways := rt.new_array()
	mut iter_4 := this.payment_gateways.iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_gateway := item_4.val
		if rt.is_true(rt.call_method(var_gateway, 'is_available', []rt.PhpVal{})) {
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_add_payment_method_page',
				[]rt.PhpVal{})))))
			{
				var__available_gateways.array_set(rt.get_property(var_gateway, 'id'),
					var_gateway.clone())
			} else if
				rt.is_true(rt.call_method(var_gateway, 'supports', [Class_Automattic_WooCommerce_Enums_PaymentGatewayFeature.add_payment_method()]))
				|| rt.is_true(rt.call_method(var_gateway, 'supports', [Class_Automattic_WooCommerce_Enums_PaymentGatewayFeature.tokenization()])) {
				var__available_gateways.array_set(rt.get_property(var_gateway, 'id'),
					var_gateway.clone())
			}
		}
	}
	return rt.call_function('array_filter', [
		rt.cast_array(rt.call_function('apply_filters', [
			rt.new_string('woocommerce_available_payment_gateways'),
			var__available_gateways.clone(),
		])),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Payment_Gateways', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'filter_valid_gateway_class' },
		]),
	])
}

fn (mut this Class_WC_Payment_Gateways) filter_valid_gateway_class(var_gateway rt.PhpVal) bool {
	mut var_gateway_mutated := var_gateway
	return rt.is_true(var_gateway_mutated)
		&& rt.is_true(rt.call_function('is_a', [var_gateway_mutated.clone(), rt.new_string('WC_Payment_Gateway')]))
}

fn (mut this Class_WC_Payment_Gateways) set_current_gateway(var_gateways rt.PhpVal) {
	if !(var_gateways.clone().is_array()) || !rt.is_true(var_gateways) {
		return
	}
	mut var_current_gateway := rt.new_bool(false)
	if rt.is_true(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'session')) {
		mut var_current := rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}),
			'session'), 'get', [rt.new_string('chosen_payment_method')])
		if rt.is_true(var_current) && var_gateways.array_isset(var_current) {
			var_current_gateway = var_gateways.array_get(var_current)
		}
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_current_gateway)))) {
		var_current_gateway = rt.call_function('current', [var_gateways.clone()])
	}
	if rt.is_true(var_current_gateway)
		&& rt.call_function('is_callable', [rt.create_array([rt.ArrayItem{
		key: none
		val: var_current_gateway
	}, rt.ArrayItem{ key: none, val: 'set_current' }])]) {
		rt.call_method(var_current_gateway, 'set_current', []rt.PhpVal{})
	}
}

fn (mut this Class_WC_Payment_Gateways) process_admin_options() {
	mut var_gateway_order := if rt.get_superglobal('_POST').array_isset(rt.new_string('gateway_order')) { rt.call_function('wc_clean', [
			rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get(rt.new_string('gateway_order'))]),
		]) } else { rt.new_string('') }
	mut var_order := rt.new_array()
	if var_gateway_order.clone().is_array() && var_gateway_order.clone().array_count() > 0 {
		mut var_loop := rt.new_int(0)
		mut iter_5 := var_gateway_order.iterator()
		for {
			item_5 := iter_5.next() or { break }
			mut var_gateway_id := item_5.val
			var_order.array_set(rt.call_function('esc_attr', [
				var_gateway_id.clone()]), var_loop.clone())
			rt.pre_inc(var_loop)
		}
	}
	rt.call_function('update_option', [rt.new_string('woocommerce_gateway_order'),
		var_order.clone()])
}

fn (mut this Class_WC_Payment_Gateways) should_load_paypal_standard() rt.PhpVal {
	mut iife_temp_7 := Class_WC_Gateway_Paypal{}
	mut iife_result_7 := iife_temp_7.get_instance()
	mut var_paypal := iife_result_7
	return rt.call_method(var_paypal, 'should_load', []rt.PhpVal{})
}

fn (mut this Class_WC_Payment_Gateways) record_gateway_event(name string, var_gateway rt.PhpVal) {
	mut name_mutated := name
	mut var_gateway_mutated := var_gateway
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('wc_admin_record_tracks_event'),
	])))))
	{
		return
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_a', [
		var_gateway_mutated.clone(), rt.new_string('WC_Payment_Gateway')])))))
	{
		return
	}
	if name_mutated == '' {
		return
	}
	mut var_prefix := rt.new_string(
		(Class_Automattic_WooCommerce_Internal_Admin_Settings_Payments.event_prefix()).str() + 'provider_')
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('str_starts_with', [
		rt.new_string(name_mutated).clone(),
		var_prefix.clone(),
	])))))
	{
		name_mutated = var_prefix.str() + name_mutated
	}
	mut var_properties := {
		'provider_id':      rt.get_property(var_gateway_mutated, 'id')
		'business_country': rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}),
			'countries'), 'get_base_country', []rt.PhpVal{})
	}
	mut var_settings_payments_service := rt.call_method(rt.call_function('wc_get_container',
		[]rt.PhpVal{}), 'get', [
		Class_Automattic_WooCommerce_Internal_Admin_Settings_Payments.class(),
	])
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	var_properties['business_country'] = rt.call_method(var_settings_payments_service,
		'get_country', []rt.PhpVal{})
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	mut var_payments_providers_service := rt.call_method(rt.call_function('wc_get_container',
		[]rt.PhpVal{}), 'get', [
		Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders.class(),
	])
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	mut var_gateway_details := rt.call_method(var_payments_providers_service,
		'get_payment_gateway_details', [var_gateway_mutated.clone(),
		rt.new_int(0), var_properties['business_country']])
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	if !(!rt.is_true(var_gateway_details.array_get(rt.new_string('_suggestion_id')))) {
		var_properties['suggestion_id'] =
			var_gateway_details.array_get(rt.new_string('_suggestion_id'))
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
	if !(!rt.is_true(var_gateway_details.array_get(rt.new_string('plugin')).array_get(rt.new_string('slug')))) {
		var_properties['provider_extension_slug'] =
			var_gateway_details.array_get(rt.new_string('plugin')).array_get(rt.new_string('slug'))
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
	if rt.instance_of(var_e_1, 'Throwable') {
		mut var_e := var_e_1.clone()
		mut iife_temp_8 := Class_Automattic_WooCommerce_Internal_Logging_SafeGlobalFunctionProxy{}
		mut iife_result_8 := iife_temp_8.wc_get_logger()
		rt.call_method(iife_result_8, 'debug', [
			rt.new_string('Failed to gather provider-specific details for gateway: ' +
				(rt.call_method(var_e, 'getMessage', []rt.PhpVal{})).str()),
			rt.create_array([
				rt.ArrayItem{ key: 'gateway', val: rt.get_property(var_gateway_mutated, 'id') },
				rt.ArrayItem{ key: 'source', val: 'settings-payments' },
				rt.ArrayItem{ key: 'exception', val: var_e },
			]),
		])
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
	rt.call_function('wc_admin_record_tracks_event', [rt.new_string(name_mutated).clone(),
		rt.create_array_from_native_map(var_properties)])
}

struct Class_WC_Gateway_Paypal {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Utilities_ArrayUtil {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Logging_SafeGlobalFunctionProxy {
	rt.PhpObjectBase
}

fn create_wc_payment_gateways() &Class_WC_Payment_Gateways {
	mut obj := &Class_WC_Payment_Gateways{
		PhpObjectBase:    rt.PhpObjectBase{}
		payment_gateways: rt.new_array()
	}
	obj.construct()
	return obj
}

fn create_wc_gateway_paypal(_args ...rt.PhpVal) &Class_WC_Gateway_Paypal {
	mut obj := &Class_WC_Gateway_Paypal{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_utilities_arrayutil(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Utilities_ArrayUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_ArrayUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_logging_safeglobalfunctionproxy(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Logging_SafeGlobalFunctionProxy {
	mut obj := &Class_Automattic_WooCommerce_Internal_Logging_SafeGlobalFunctionProxy{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Payment_Gateways) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'instance' {
			return Class_WC_Payment_Gateways.instance()
		}
		'__clone' {
			this.magic_clone()
			return rt.new_null()
		}
		'__wakeup' {
			this.magic_wakeup()
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
		'on_payment_gateways_initialized' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Payment_Gateways](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.on_payment_gateways_initialized(mut dispatch_arg_0)
			return rt.new_null()
		}
		'payment_gateway_settings_option_changed' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			this.payment_gateway_settings_option_changed(dispatch_arg_0, dispatch_arg_1,
				dispatch_arg_2, dispatch_arg_3)
			return rt.new_null()
		}
		'was_gateway_enabled' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(this.was_gateway_enabled(dispatch_arg_0, dispatch_arg_1))
		}
		'was_gateway_disabled' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(this.was_gateway_disabled(dispatch_arg_0, dispatch_arg_1))
		}
		'payment_gateways' {
			return this.payment_gateways()
		}
		'get_payment_gateway_name_by_id' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(this.get_payment_gateway_name_by_id(dispatch_arg_0))
		}
		'get_payment_gateway_ids' {
			return this.get_payment_gateway_ids()
		}
		'get_available_payment_gateways' {
			return this.get_available_payment_gateways()
		}
		'filter_valid_gateway_class' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.filter_valid_gateway_class(dispatch_arg_0))
		}
		'set_current_gateway' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_current_gateway(dispatch_arg_0)
			return rt.new_null()
		}
		'process_admin_options' {
			this.process_admin_options()
			return rt.new_null()
		}
		'should_load_paypal_standard' {
			return this.should_load_paypal_standard()
		}
		'record_gateway_event' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.record_gateway_event(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_Payment_Gateways) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'payment_gateways' { return this.payment_gateways }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_Payment_Gateways) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'payment_gateways' {
			this.payment_gateways = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_WC_Gateway_Paypal) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Gateway_Paypal) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Gateway_Paypal) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_ArrayUtil) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Utilities_ArrayUtil) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_ArrayUtil) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Logging_SafeGlobalFunctionProxy) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Logging_SafeGlobalFunctionProxy) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Logging_SafeGlobalFunctionProxy) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn init_registry() {
	rt.register_class_factory('WC_Payment_Gateways', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_wc_payment_gateways()
		return rt.new_object('WC_Payment_Gateways', []string{}, obj)
	})
	rt.register_class_factory('WC_Gateway_Paypal', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_wc_gateway_paypal()
		return rt.new_object('WC_Gateway_Paypal', []string{}, obj)
	})
	rt.register_class_factory('Automattic_WooCommerce_Utilities_ArrayUtil', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_utilities_arrayutil()
		return rt.new_object('Automattic_WooCommerce_Utilities_ArrayUtil', []string{}, obj)
	})
	rt.register_class_factory('Automattic_WooCommerce_Internal_Logging_SafeGlobalFunctionProxy', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_internal_logging_safeglobalfunctionproxy()
		return rt.new_object('Automattic_WooCommerce_Internal_Logging_SafeGlobalFunctionProxy',
			[]string{}, obj)
	})
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
