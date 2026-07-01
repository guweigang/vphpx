import rt

struct Class_Automattic_WooCommerce_StoreApi_Legacy {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Legacy) init() {
	rt.call_function('add_action', [
		rt.new_string('woocommerce_rest_checkout_process_payment_with_context'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_StoreApi_Legacy',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'process_legacy_payment' },
		]),
		rt.new_int(999),
		rt.new_int(2),
	])
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Legacy) process_legacy_payment(mut var_context Class_Automattic_WooCommerce_StoreApi_Payments_PaymentContext, mut var_result Class_Automattic_WooCommerce_StoreApi_Payments_PaymentResult) {
	if rt.is_true(rt.get_property(var_result, 'status')) {
		return rt.new_null()
	}
	mut var_post_data := rt.get_superglobal('_POST').dup()
	rt.call_function('wc_maybe_define_constant', [rt.new_string('WOOCOMMERCE_CHECKOUT'),
		rt.new_bool(true)])
	mut var__POST := rt.get_property(var_context, 'payment_data')
	mut var_payment_method_object := var_context.get_payment_method_instance()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_payment_method_object,
		'Automattic_WooCommerce_StoreApi_WC_Payment_Gateway'))))))
	{
		return rt.new_null()
	}
	rt.call_method(var_payment_method_object, 'validate_fields', []rt.PhpVal{})
	fn (arg_0 rt.PhpVal) rt.PhpVal {
		mut temp := Class_Automattic_WooCommerce_StoreApi_Utilities_NoticeHandler{}
		return temp.convert_notices_to_exceptions(arg_0)
	}(rt.new_string('woocommerce_rest_payment_error'))
	mut var_gateway_result := rt.call_method(var_payment_method_object, 'process_payment', [
		rt.call_method(rt.get_property(var_context, 'order'), 'get_id', []rt.PhpVal{}),
	])
	var__POST = var_post_data.dup()
	if rt.is_true(rt.new_bool(var_gateway_result.array_isset(rt.new_string('result'))
		&& rt.is_true(rt.identical(rt.new_string('failure'), var_gateway_result.array_get('result')))))
	{
		if var_gateway_result.array_isset(rt.new_string('message')) {
			rt.throw_exception(rt.new_object('Automattic_WooCommerce_StoreApi_Exceptions_RouteException',
				[]string{}, create_automattic_woocommerce_storeapi_exceptions_routeexception(rt.new_string('woocommerce_rest_payment_error'), rt.call_function('esc_html', [
				rt.call_function('wp_strip_all_tags', [var_gateway_result.array_get('message')]),
			]), rt.new_int(400))))
		} else {
			fn (arg_0 rt.PhpVal) rt.PhpVal {
				mut temp := Class_Automattic_WooCommerce_StoreApi_Utilities_NoticeHandler{}
				return temp.convert_notices_to_exceptions(arg_0)
			}(rt.new_string('woocommerce_rest_payment_error'))
		}
	}
	mut var_result_status := if !(var_gateway_result.array_get('result')).is_null() {
		var_gateway_result.array_get('result')
	} else {
		rt.new_string('failure')
	}
	mut var_valid_status := rt.create_array([rt.ArrayItem{ key: none, val: 'success' },
		rt.ArrayItem{ key: none, val: 'failure' }, rt.ArrayItem{ key: none, val: 'pending' },
		rt.ArrayItem{ key: none, val: 'error' }])
	var_result.set_status(if rt.is_true(rt.call_function('in_array', [
		var_result_status.dup(), var_valid_status.dup(), rt.new_bool(true)]))
	{ var_result_status } else { rt.new_string('failure') })
	rt.call_function('wc_clear_notices', []rt.PhpVal{})
	var_result.set_payment_details(rt.call_function('array_merge', [
		rt.get_property(var_result, 'payment_details'),
		var_gateway_result.dup(),
	]))
	var_result.set_redirect_url(if !(var_gateway_result.array_get('redirect')).is_null() {
		var_gateway_result.array_get('redirect')
	} else {
		rt.new_string('')
	})
}

struct Class_Automattic_WooCommerce_StoreApi_Utilities_NoticeHandler {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_StoreApi_Exceptions_RouteException {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_storeapi_legacy() &Class_Automattic_WooCommerce_StoreApi_Legacy {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Legacy{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_storeapi_utilities_noticehandler() &Class_Automattic_WooCommerce_StoreApi_Utilities_NoticeHandler {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Utilities_NoticeHandler{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_storeapi_exceptions_routeexception() &Class_Automattic_WooCommerce_StoreApi_Exceptions_RouteException {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Exceptions_RouteException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Legacy) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'init' {
			this.init()
			return rt.new_null()
		}
		'process_legacy_payment' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Payments_PaymentContext](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Payments_PaymentResult](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			this.process_legacy_payment(mut dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Legacy) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Legacy) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_NoticeHandler) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Utilities_NoticeHandler) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_NoticeHandler) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Exceptions_RouteException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Exceptions_RouteException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Exceptions_RouteException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_content_plugins_woocommerce_src_storeapi_legacy_php() {
}
