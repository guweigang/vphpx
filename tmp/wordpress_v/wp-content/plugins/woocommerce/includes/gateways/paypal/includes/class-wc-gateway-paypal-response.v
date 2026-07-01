import rt

struct Class_WC_Gateway_Paypal_Response {
	rt.PhpObjectBase
pub mut:
	sandbox rt.PhpVal = rt.new_bool(false)
}

fn (mut this Class_WC_Gateway_Paypal_Response) get_paypal_order(var_raw_custom rt.PhpVal) bool {
	mut var_custom := rt.call_function('json_decode', [var_raw_custom.dup()])
	if rt.is_true(rt.new_bool(rt.is_true(var_custom)
		&& rt.is_true(rt.new_bool(var_custom.dup().is_object()))))
	{
		mut var_order_id := rt.get_property(var_custom, 'order_id')
		mut var_order_key := rt.get_property(var_custom, 'order_key')
	} else {
		fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal {
			mut temp := Class_WC_Gateway_Paypal{}
			return temp.log(arg_0, arg_1)
		}(rt.new_string('Order ID and key were not found in "custom".'), rt.new_string('error'))
		return false
	}
	mut var_order := rt.call_function('wc_get_order', [var_order_id.dup()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_order)))) {
		var_order_id = rt.call_function('wc_get_order_id_by_order_key', [
			var_order_key.dup()])
		var_order = rt.call_function('wc_get_order', [var_order_id.dup()])
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_order))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('hash_equals', [rt.call_method(var_order, 'get_order_key', []rt.PhpVal{}), var_order_key.dup()])))))))
	{
		fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal {
			mut temp := Class_WC_Gateway_Paypal{}
			return temp.log(arg_0, arg_1)
		}(rt.new_string('Order Keys do not match.'), rt.new_string('error'))
		return false
	}
	return var_order.to_bool()
}

fn (mut this Class_WC_Gateway_Paypal_Response) payment_complete(var_order rt.PhpVal, txn_id string, note string) {
	mut var_order_mutated := var_order
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_order_mutated, 'has_status', [
		rt.create_array([
			rt.ArrayItem{
				key: none
				val: Class_Automattic_WooCommerce_Enums_OrderStatus.processing()
			},
			rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_OrderStatus.completed() },
		]),
	])))))
	{
		rt.call_method(var_order_mutated, 'add_order_note', [
			rt.new_string(note)])
		rt.call_method(var_order_mutated, 'payment_complete', [
			rt.new_string(txn_id)])
		if !(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'cart')).is_null() {
			rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'cart'),
				'empty_cart', []rt.PhpVal{})
		}
	}
}

fn (mut this Class_WC_Gateway_Paypal_Response) payment_on_hold(var_order rt.PhpVal, reason string) {
	mut var_order_mutated := var_order
	rt.call_method(var_order_mutated, 'update_status', [
		Class_Automattic_WooCommerce_Enums_OrderStatus.on_hold(),
		rt.new_string(reason),
	])
	if !(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'cart')).is_null() {
		rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'cart'),
			'empty_cart', []rt.PhpVal{})
	}
}

struct Class_WC_Gateway_Paypal {
	rt.PhpObjectBase
}

fn create_wc_gateway_paypal_response() &Class_WC_Gateway_Paypal_Response {
	mut obj := &Class_WC_Gateway_Paypal_Response{
		PhpObjectBase: rt.PhpObjectBase{}
		sandbox:       rt.new_bool(false)
	}
	return obj
}

fn create_wc_gateway_paypal() &Class_WC_Gateway_Paypal {
	mut obj := &Class_WC_Gateway_Paypal{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Gateway_Paypal_Response) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_paypal_order' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.get_paypal_order(dispatch_arg_0))
		}
		'payment_complete' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			this.payment_complete(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'payment_on_hold' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			this.payment_on_hold(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_Gateway_Paypal_Response) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'sandbox' { return this.sandbox }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_Gateway_Paypal_Response) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'sandbox' {
			this.sandbox = val
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

pub fn init_wp_content_plugins_woocommerce_includes_gateways_paypal_includes_class_wc_gateway_paypal_response_php() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		// unsupported expression: Expr_Exit
	}
}
