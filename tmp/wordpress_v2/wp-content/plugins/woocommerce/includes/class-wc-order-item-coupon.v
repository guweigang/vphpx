import rt

struct Class_WC_Order_Item_Coupon {
	rt.PhpObjectBase
pub mut:
	extra_data rt.PhpVal = rt.new_array()
}

fn (mut this Class_WC_Order_Item_Coupon) set_name(var_value rt.PhpVal) rt.PhpVal {
	this.set_code(var_value.clone())
	return rt.new_null()
}

fn (mut this Class_WC_Order_Item_Coupon) set_code(var_value rt.PhpVal) {
	this.set_prop(rt.new_string('code'), rt.call_function('wc_format_coupon_code', [
		var_value.clone(),
	]))
}

fn (mut this Class_WC_Order_Item_Coupon) set_discount(var_value rt.PhpVal) {
	this.set_prop(rt.new_string('discount'), rt.call_function('wc_format_decimal', [
		var_value.clone(),
	]))
}

fn (mut this Class_WC_Order_Item_Coupon) set_discount_tax(var_value rt.PhpVal) {
	this.set_prop(rt.new_string('discount_tax'), rt.call_function('wc_format_decimal', [
		var_value.clone(),
	]))
}

fn (mut this Class_WC_Order_Item_Coupon) get_type() string {
	return 'coupon'
}

fn (mut this Class_WC_Order_Item_Coupon) get_name(context string) rt.PhpVal {
	return this.get_code(context)
}

fn (mut this Class_WC_Order_Item_Coupon) get_code(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('code'), rt.new_string(context))
}

fn (mut this Class_WC_Order_Item_Coupon) get_discount(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('discount'), rt.new_string(context))
}

fn (mut this Class_WC_Order_Item_Coupon) get_discount_tax(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('discount_tax'), rt.new_string(context))
}

fn (mut this Class_WC_Order_Item_Coupon) offsetget(var_offset rt.PhpVal) rt.PhpVal {
	mut var_offset_mutated := var_offset
	rt.call_function('wc_deprecated_function', [
		rt.new_string('WC_Order_Item_Coupon::offsetGet'),
		rt.new_string('4.4.0'),
		rt.new_string(''),
	])
	if rt.is_true(rt.identical(rt.new_string('discount_amount'), var_offset_mutated)) {
		var_offset_mutated = rt.new_string('discount')
	} else if rt.is_true(rt.identical(rt.new_string('discount_amount_tax'), var_offset_mutated)) {
		var_offset_mutated = rt.new_string('discount_tax')
	}
	return this.Class_WC_Order_Item.offsetget(var_offset_mutated.clone())
}

fn (mut this Class_WC_Order_Item_Coupon) offsetset(var_offset rt.PhpVal, var_value rt.PhpVal) {
	mut var_offset_mutated := var_offset
	rt.call_function('wc_deprecated_function', [
		rt.new_string('WC_Order_Item_Coupon::offsetSet'),
		rt.new_string('4.4.0'),
		rt.new_string(''),
	])
	if rt.is_true(rt.identical(rt.new_string('discount_amount'), var_offset_mutated)) {
		var_offset_mutated = rt.new_string('discount')
	} else if rt.is_true(rt.identical(rt.new_string('discount_amount_tax'), var_offset_mutated)) {
		var_offset_mutated = rt.new_string('discount_tax')
	}
	this.Class_WC_Order_Item.offsetset(var_offset_mutated.clone(), var_value.clone())
}

fn (mut this Class_WC_Order_Item_Coupon) offsetexists(var_offset rt.PhpVal) bool {
	mut var_offset_mutated := var_offset
	if rt.is_true(rt.call_function('in_array', [var_offset_mutated.clone(),
		rt.create_array([rt.ArrayItem{ key: none, val: 'discount_amount' },
			rt.ArrayItem{ key: none, val: 'discount_amount_tax' }]),
		rt.new_bool(true)]))
	{
		return true
	}
	return (this.Class_WC_Order_Item.offsetexists(var_offset_mutated.clone())).to_bool()
}

struct Class_WC_Order_Item {
	rt.PhpObjectBase
}

fn create_wc_order_item_coupon(_args ...rt.PhpVal) &Class_WC_Order_Item_Coupon {
	mut obj := &Class_WC_Order_Item_Coupon{
		PhpObjectBase: rt.PhpObjectBase{}
		extra_data:    rt.new_array()
	}
	return obj
}

fn create_wc_order_item(_args ...rt.PhpVal) &Class_WC_Order_Item {
	mut obj := &Class_WC_Order_Item{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Order_Item_Coupon) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'set_name' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.set_name(dispatch_arg_0)
		}
		'set_code' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_code(dispatch_arg_0)
			return rt.new_null()
		}
		'set_discount' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_discount(dispatch_arg_0)
			return rt.new_null()
		}
		'set_discount_tax' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_discount_tax(dispatch_arg_0)
			return rt.new_null()
		}
		'get_type' {
			return rt.new_string(this.get_type())
		}
		'get_name' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_name(dispatch_arg_0)
		}
		'get_code' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_code(dispatch_arg_0)
		}
		'get_discount' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_discount(dispatch_arg_0)
		}
		'get_discount_tax' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_discount_tax(dispatch_arg_0)
		}
		'offsetGet' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.offsetget(dispatch_arg_0)
		}
		'offsetSet' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.offsetset(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'offsetExists' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.offsetexists(dispatch_arg_0))
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_Order_Item_Coupon) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'extra_data' { return this.extra_data }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_Order_Item_Coupon) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'extra_data' {
			this.extra_data = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_WC_Order_Item) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Order_Item) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Order_Item) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}
