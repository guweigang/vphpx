import rt

struct Class_Automattic_WooCommerce_StoreApi_Payments_PaymentContext {
	rt.PhpObjectBase
pub mut:
		payment_method rt.PhpVal = rt.new_string('')
		order rt.PhpVal = rt.new_null()
		payment_data rt.PhpVal = rt.new_array()
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Payments_PaymentContext) magic_get(var_name rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.call_function('in_array', [var_name.dup(), rt.create_array([rt.ArrayItem{ key: none, val: 'payment_method' }, rt.ArrayItem{ key: none, val: 'order' }, rt.ArrayItem{ key: none, val: 'payment_data' }]), rt.new_bool(true)])) {
		return rt.get_property(rt.new_object('Automattic_WooCommerce_StoreApi_Payments_PaymentContext', []string{}, &this), '{"nodeType":"Expr_Variable","line":36,"name":"name"}')
	}
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Payments_PaymentContext) set_payment_method(var_payment_method rt.PhpVal)  {
	this.payment_method = // unsupported expression: Expr_Cast_String
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Payments_PaymentContext) get_payment_method_instance() rt.PhpVal {
	mut var_available_gateways := rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'payment_gateways'), 'get_available_payment_gateways', []rt.PhpVal{})
	if !(var_available_gateways.array_isset(this.payment_method)) {
		return rt.new_null()
	}
	return var_available_gateways.array_get(this.payment_method)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Payments_PaymentContext) set_order(mut var_order Class_Automattic_WooCommerce_StoreApi_Payments_WC_Order)  {
	this.order = var_order.dup()
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Payments_PaymentContext) set_payment_data(var_payment_data rt.PhpVal)  {
	this.payment_data = rt.new_array()
	{
		mut iter_1 := var_payment_data.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_value := item_1.val
			mut var_key := item_1.key
			this.payment_data.array_set(// unsupported expression: Expr_Cast_String, // unsupported expression: Expr_Cast_String)
		}
	}
}

fn create_automattic_woocommerce_storeapi_payments_paymentcontext() &Class_Automattic_WooCommerce_StoreApi_Payments_PaymentContext {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Payments_PaymentContext{
		PhpObjectBase: rt.PhpObjectBase{}
		payment_method: rt.new_string('')
		order: rt.new_null()
		payment_data: rt.new_array()
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Payments_PaymentContext) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__get' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.magic_get(dispatch_arg_0)
		}
		'set_payment_method' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_payment_method(dispatch_arg_0)
			return rt.new_null()
		}
		'get_payment_method_instance' {
			return this.get_payment_method_instance()
		}
		'set_order' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Payments_WC_Order](if args.len > 0 { args[0] } else { rt.new_null() })
			this.set_order(mut dispatch_arg_0)
			return rt.new_null()
		}
		'set_payment_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_payment_data(dispatch_arg_0)
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Payments_PaymentContext) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'payment_method' { return this.payment_method }
		'order' { return this.order }
		'payment_data' { return this.payment_data }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Payments_PaymentContext) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'payment_method' { this.payment_method = val; return true }
		'order' { this.order = val; return true }
		'payment_data' { this.payment_data = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}




pub fn init_wp_content_plugins_woocommerce_src_storeapi_payments_paymentcontext_php() {
}
