import rt

struct Class_WC_Order_Refund {
	rt.PhpObjectBase
pub mut:
	data_store_name        rt.PhpVal = rt.new_string('order-refund')
	object_type            rt.PhpVal = rt.new_string('order_refund')
	extra_data             rt.PhpVal = rt.new_array()
	legacy_datastore_props rt.PhpVal = rt.new_array()
}

fn (mut this Class_WC_Order_Refund) get_type() string {
	return 'shop_order_refund'
}

fn (mut this Class_WC_Order_Refund) get_status(context string) rt.PhpVal {
	return Class_Automattic_WooCommerce_Enums_OrderStatus.completed()
}

fn (mut this Class_WC_Order_Refund) get_post_title() rt.PhpVal {
	return rt.call_function('sprintf', [
		rt.call_function('__', [rt.new_string('Refund &ndash; %s'),
			rt.new_string('woocommerce')]),
		rt.call_method(create_datetime(rt.new_string('now')), 'format', [
			rt.call_function('_x', [rt.new_string('M d, Y @ h:i A'),
				rt.new_string('Order date parsed by DateTime::format'),
				rt.new_string('woocommerce')])]),
	])
	return rt.new_null()
}

fn (mut this Class_WC_Order_Refund) get_amount(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('amount'), rt.new_string(context))
}

fn (mut this Class_WC_Order_Refund) get_reason(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('reason'), rt.new_string(context))
}

fn (mut this Class_WC_Order_Refund) get_refunded_by(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('refunded_by'), rt.new_string(context))
}

fn (mut this Class_WC_Order_Refund) get_refunded_payment(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('refunded_payment'), rt.new_string(context))
}

fn (mut this Class_WC_Order_Refund) get_formatted_refund_amount() rt.PhpVal {
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_formatted_refund_amount'),
		rt.call_function('wc_price', [this.get_amount(''),
			rt.create_array([rt.ArrayItem{ key: 'currency', val: this.get_currency() }])]),
		rt.new_object('WC_Order_Refund', ['WC_Abstract_Order'], &this),
	])
}

fn (mut this Class_WC_Order_Refund) set_amount(var_value rt.PhpVal) {
	this.set_prop(rt.new_string('amount'), rt.call_function('wc_format_decimal', [
		var_value.clone(),
	]))
}

fn (mut this Class_WC_Order_Refund) set_reason(var_value rt.PhpVal) {
	this.set_prop(rt.new_string('reason'), var_value.clone())
}

fn (mut this Class_WC_Order_Refund) set_refunded_by(var_value rt.PhpVal) {
	this.set_prop(rt.new_string('refunded_by'), rt.call_function('absint', [
		var_value.clone()]))
}

fn (mut this Class_WC_Order_Refund) set_refunded_payment(var_value rt.PhpVal) {
	this.set_prop(rt.new_string('refunded_payment'), rt.new_bool(var_value.to_bool()))
}

fn (mut this Class_WC_Order_Refund) magic_get(var_key rt.PhpVal) rt.PhpVal {
	rt.call_function('wc_doing_it_wrong', [var_key.clone(),
		rt.new_string('Refund properties should not be accessed directly.'),
		rt.new_string('3.0')])
	if rt.is_true(rt.identical(rt.new_string('reason'), var_key)) {
		return this.get_reason('')
	} else if rt.is_true(rt.identical(rt.new_string('refund_amount'), var_key)) {
		return this.get_amount('')
	}
	return this.Class_WC_Abstract_Order.magic_get(var_key.clone())
}

fn (mut this Class_WC_Order_Refund) get_refund(id i64) bool {
	rt.call_function('wc_deprecated_function', [rt.new_string('get_refund'),
		rt.new_string('3.0'), rt.new_string('read')])
	if !(var_id != 0) {
		return false
	}
	mut var_result := rt.call_function('wc_get_order', [rt.new_int(id)])
	if rt.is_true(var_result) {
		this.populate(var_result.clone())
		return true
	}
	return false
}

fn (mut this Class_WC_Order_Refund) get_refund_amount() rt.PhpVal {
	rt.call_function('wc_deprecated_function', [rt.new_string('get_refund_amount'),
		rt.new_string('3.0'), rt.new_string('get_amount')])
	return this.get_amount('')
}

fn (mut this Class_WC_Order_Refund) get_refund_reason() rt.PhpVal {
	rt.call_function('wc_deprecated_function', [rt.new_string('get_refund_reason'),
		rt.new_string('3.0'), rt.new_string('get_reason')])
	return this.get_reason('')
}

fn (mut this Class_WC_Order_Refund) has_cogs() bool {
	return true
}

struct Class_WC_Abstract_Order {
	rt.PhpObjectBase
}

struct Class_DateTime {
	rt.PhpObjectBase
}

fn create_wc_order_refund(_args ...rt.PhpVal) &Class_WC_Order_Refund {
	mut obj := &Class_WC_Order_Refund{
		PhpObjectBase:          rt.PhpObjectBase{}
		data_store_name:        rt.new_string('order-refund')
		object_type:            rt.new_string('order_refund')
		extra_data:             rt.new_array()
		legacy_datastore_props: rt.new_array()
	}
	return obj
}

fn create_wc_abstract_order(_args ...rt.PhpVal) &Class_WC_Abstract_Order {
	mut obj := &Class_WC_Abstract_Order{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_datetime(_args ...rt.PhpVal) &Class_DateTime {
	mut obj := &Class_DateTime{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Order_Refund) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_type' {
			return rt.new_string(this.get_type())
		}
		'get_status' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_status(dispatch_arg_0)
		}
		'get_post_title' {
			return this.get_post_title()
		}
		'get_amount' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_amount(dispatch_arg_0)
		}
		'get_reason' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_reason(dispatch_arg_0)
		}
		'get_refunded_by' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_refunded_by(dispatch_arg_0)
		}
		'get_refunded_payment' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_refunded_payment(dispatch_arg_0)
		}
		'get_formatted_refund_amount' {
			return this.get_formatted_refund_amount()
		}
		'set_amount' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_amount(dispatch_arg_0)
			return rt.new_null()
		}
		'set_reason' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_reason(dispatch_arg_0)
			return rt.new_null()
		}
		'set_refunded_by' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_refunded_by(dispatch_arg_0)
			return rt.new_null()
		}
		'set_refunded_payment' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_refunded_payment(dispatch_arg_0)
			return rt.new_null()
		}
		'__get' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.magic_get(dispatch_arg_0)
		}
		'get_refund' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			return rt.new_bool(this.get_refund(dispatch_arg_0))
		}
		'get_refund_amount' {
			return this.get_refund_amount()
		}
		'get_refund_reason' {
			return this.get_refund_reason()
		}
		'has_cogs' {
			return rt.new_bool(this.has_cogs())
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_Order_Refund) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'data_store_name' { return this.data_store_name }
		'object_type' { return this.object_type }
		'extra_data' { return this.extra_data }
		'legacy_datastore_props' { return this.legacy_datastore_props }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_Order_Refund) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'data_store_name' {
			this.data_store_name = val
			return true
		}
		'object_type' {
			this.object_type = val
			return true
		}
		'extra_data' {
			this.extra_data = val
			return true
		}
		'legacy_datastore_props' {
			this.legacy_datastore_props = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_WC_Abstract_Order) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Abstract_Order) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Abstract_Order) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_DateTime) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_DateTime) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_DateTime) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}
