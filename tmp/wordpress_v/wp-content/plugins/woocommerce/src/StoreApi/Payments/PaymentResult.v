import rt

struct Class_Automattic_WooCommerce_StoreApi_Payments_PaymentResult {
	rt.PhpObjectBase
pub mut:
		valid_statuses rt.PhpVal = rt.new_array()
		status rt.PhpVal = rt.new_string('')
		payment_details rt.PhpVal = rt.new_array()
		redirect_url rt.PhpVal = rt.new_string('')
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Payments_PaymentResult) construct(status string)  {
	if var_status.len > 0 && var_status != '0' {
		this.set_status(rt.new_string(status))
	}
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Payments_PaymentResult) magic_get(var_name rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.call_function('in_array', [var_name.dup(), rt.create_array([rt.ArrayItem{ key: none, val: 'status' }, rt.ArrayItem{ key: none, val: 'payment_details' }, rt.ArrayItem{ key: none, val: 'redirect_url' }]), rt.new_bool(true)])) {
		return rt.get_property(rt.new_object('Automattic_WooCommerce_StoreApi_Payments_PaymentResult', []string{}, &this), '{"nodeType":"Expr_Variable","line":54,"name":"name"}')
	}
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Payments_PaymentResult) get_status() string {
	return (this.status).str()
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Payments_PaymentResult) set_status(var_payment_status rt.PhpVal)  {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_payment_status.dup(), this.valid_statuses, rt.new_bool(true)]))))) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_StoreApi_Payments_Exception', []string{}, create_automattic_woocommerce_storeapi_payments_exception(rt.call_function('sprintf', [rt.new_string('Invalid payment status %s. Use one of %s'), var_payment_status.dup(), rt.call_function('implode', [rt.new_string(', '), this.valid_statuses])]))))
	}
	this.status = var_payment_status.dup()
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Payments_PaymentResult) set_payment_details(var_payment_details rt.PhpVal)  {
	this.payment_details = rt.new_array()
	{
		mut iter_1 := var_payment_details.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_value := item_1.val
			mut var_key := item_1.key
			this.payment_details.array_set(// unsupported expression: Expr_Cast_String, // unsupported expression: Expr_Cast_String)
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Payments_PaymentResult) set_redirect_url(var_redirect_url rt.PhpVal)  {
	this.redirect_url = rt.call_function('esc_url_raw', [var_redirect_url.dup()])
}

struct Class_Automattic_WooCommerce_StoreApi_Payments_Exception {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_storeapi_payments_paymentresult(status string) &Class_Automattic_WooCommerce_StoreApi_Payments_PaymentResult {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Payments_PaymentResult{
		PhpObjectBase: rt.PhpObjectBase{}
		valid_statuses: rt.new_array()
		status: rt.new_string('')
		payment_details: rt.new_array()
		redirect_url: rt.new_string('')
	}
	obj.construct(status)
	return obj
}

fn create_automattic_woocommerce_storeapi_payments_exception() &Class_Automattic_WooCommerce_StoreApi_Payments_Exception {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Payments_Exception{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Payments_PaymentResult) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'__get' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.magic_get(dispatch_arg_0)
		}
		'get_status' {
			return rt.new_string(this.get_status())
		}
		'set_status' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_status(dispatch_arg_0)
			return rt.new_null()
		}
		'set_payment_details' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_payment_details(dispatch_arg_0)
			return rt.new_null()
		}
		'set_redirect_url' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_redirect_url(dispatch_arg_0)
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Payments_PaymentResult) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'valid_statuses' { return this.valid_statuses }
		'status' { return this.status }
		'payment_details' { return this.payment_details }
		'redirect_url' { return this.redirect_url }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Payments_PaymentResult) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'valid_statuses' { this.valid_statuses = val; return true }
		'status' { this.status = val; return true }
		'payment_details' { this.payment_details = val; return true }
		'redirect_url' { this.redirect_url = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_WooCommerce_StoreApi_Payments_Exception) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Payments_Exception) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Payments_Exception) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_storeapi_payments_paymentresult_php() {
}
