import rt

struct Class_WC_Order_Item_Tax {
	rt.PhpObjectBase
pub mut:
	extra_data rt.PhpVal = rt.new_array()
}

fn (mut this Class_WC_Order_Item_Tax) set_name(var_value rt.PhpVal) {
	this.set_rate_code(var_value.clone())
}

fn (mut this Class_WC_Order_Item_Tax) set_rate_code(var_value rt.PhpVal) {
	this.set_prop(rt.new_string('rate_code'), rt.call_function('wc_clean', [
		var_value.clone()]))
}

fn (mut this Class_WC_Order_Item_Tax) set_label(var_value rt.PhpVal) {
	this.set_prop(rt.new_string('label'), rt.call_function('wc_clean', [
		var_value.clone()]))
}

fn (mut this Class_WC_Order_Item_Tax) set_rate_id(var_value rt.PhpVal) {
	this.set_prop(rt.new_string('rate_id'), rt.call_function('absint', [
		var_value.clone()]))
}

fn (mut this Class_WC_Order_Item_Tax) set_tax_total(var_value rt.PhpVal) {
	this.set_prop(rt.new_string('tax_total'), if rt.is_true(var_value) { rt.call_function('wc_format_decimal', [
			var_value.clone(),
		]) } else { rt.new_int(0) })
}

fn (mut this Class_WC_Order_Item_Tax) set_shipping_tax_total(var_value rt.PhpVal) {
	this.set_prop(rt.new_string('shipping_tax_total'), if rt.is_true(var_value) { rt.call_function('wc_format_decimal', [
			var_value.clone(),
		]) } else { rt.new_int(0) })
}

fn (mut this Class_WC_Order_Item_Tax) set_compound(var_value rt.PhpVal) {
	this.set_prop(rt.new_string('compound'), rt.new_bool(var_value.to_bool()))
}

fn (mut this Class_WC_Order_Item_Tax) set_rate_percent(var_value rt.PhpVal) {
	this.set_prop(rt.new_string('rate_percent'), rt.new_float(var_value.to_f64()))
}

fn (mut this Class_WC_Order_Item_Tax) set_rate(var_tax_rate_id rt.PhpVal) {
	mut iife_temp_0 := Class_WC_Tax{}
	mut iife_result_0 := iife_temp_0._get_tax_rate(var_tax_rate_id.clone(),
		rt.get_constant('OBJECT'))
	mut var_tax_rate := iife_result_0
	this.set_rate_id(var_tax_rate_id.clone())
	mut iife_temp_1 := Class_WC_Tax{}
	mut iife_result_1 := iife_temp_1.get_rate_code(var_tax_rate.clone())
	this.set_rate_code(iife_result_1)
	mut iife_temp_2 := Class_WC_Tax{}
	mut iife_result_2 := iife_temp_2.get_rate_label(var_tax_rate.clone())
	this.set_label(iife_result_2)
	mut iife_temp_3 := Class_WC_Tax{}
	mut iife_result_3 := iife_temp_3.is_compound(var_tax_rate.clone())
	this.set_compound(iife_result_3)
	mut iife_temp_4 := Class_WC_Tax{}
	mut iife_result_4 := iife_temp_4.get_rate_percent_value(var_tax_rate.clone())
	this.set_rate_percent(iife_result_4)
}

fn (mut this Class_WC_Order_Item_Tax) get_type() string {
	return 'tax'
}

fn (mut this Class_WC_Order_Item_Tax) get_name(context string) rt.PhpVal {
	return this.get_rate_code(context)
}

fn (mut this Class_WC_Order_Item_Tax) get_rate_code(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('rate_code'), rt.new_string(context))
}

fn (mut this Class_WC_Order_Item_Tax) get_label(context string) rt.PhpVal {
	mut var_label := this.get_prop(rt.new_string('label'), rt.new_string(context))
	if rt.is_true(rt.identical(rt.new_string('view'), rt.new_string(context))) {
		return if rt.is_true(var_label) { var_label } else { rt.call_function('__', [
				rt.new_string('Tax'),
				rt.new_string('woocommerce'),
			]) }
	} else {
		return var_label.clone()
	}
	return rt.new_null()
}

fn (mut this Class_WC_Order_Item_Tax) get_rate_id(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('rate_id'), rt.new_string(context))
}

fn (mut this Class_WC_Order_Item_Tax) get_tax_total(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('tax_total'), rt.new_string(context))
}

fn (mut this Class_WC_Order_Item_Tax) get_shipping_tax_total(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('shipping_tax_total'), rt.new_string(context))
}

fn (mut this Class_WC_Order_Item_Tax) get_compound(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('compound'), rt.new_string(context))
}

fn (mut this Class_WC_Order_Item_Tax) is_compound() rt.PhpVal {
	return this.get_compound('')
}

fn (mut this Class_WC_Order_Item_Tax) get_rate_percent(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('rate_percent'), rt.new_string(context))
}

fn (mut this Class_WC_Order_Item_Tax) offsetget(var_offset rt.PhpVal) rt.PhpVal {
	mut var_offset_mutated := var_offset
	if rt.is_true(rt.identical(rt.new_string('tax_amount'), var_offset_mutated)) {
		var_offset_mutated = rt.new_string('tax_total')
	} else if rt.is_true(rt.identical(rt.new_string('shipping_tax_amount'), var_offset_mutated)) {
		var_offset_mutated = rt.new_string('shipping_tax_total')
	}
	return this.Class_WC_Order_Item.offsetget(var_offset_mutated.clone())
}

fn (mut this Class_WC_Order_Item_Tax) offsetset(var_offset rt.PhpVal, var_value rt.PhpVal) {
	mut var_offset_mutated := var_offset
	rt.call_function('wc_deprecated_function', [
		rt.new_string('WC_Order_Item_Tax::offsetSet'),
		rt.new_string('4.4.0'),
		rt.new_string(''),
	])
	if rt.is_true(rt.identical(rt.new_string('tax_amount'), var_offset_mutated)) {
		var_offset_mutated = rt.new_string('tax_total')
	} else if rt.is_true(rt.identical(rt.new_string('shipping_tax_amount'), var_offset_mutated)) {
		var_offset_mutated = rt.new_string('shipping_tax_total')
	}
	this.Class_WC_Order_Item.offsetset(var_offset_mutated.clone(), var_value.clone())
}

fn (mut this Class_WC_Order_Item_Tax) offsetexists(var_offset rt.PhpVal) bool {
	mut var_offset_mutated := var_offset
	if rt.is_true(rt.call_function('in_array', [var_offset_mutated.clone(),
		rt.create_array([rt.ArrayItem{ key: none, val: 'tax_amount' },
			rt.ArrayItem{ key: none, val: 'shipping_tax_amount' }]),
		rt.new_bool(true)]))
	{
		return true
	}
	return (this.Class_WC_Order_Item.offsetexists(var_offset_mutated.clone())).to_bool()
}

struct Class_WC_Order_Item {
	rt.PhpObjectBase
}

struct Class_WC_Tax {
	rt.PhpObjectBase
}

fn create_wc_order_item_tax(_args ...rt.PhpVal) &Class_WC_Order_Item_Tax {
	mut obj := &Class_WC_Order_Item_Tax{
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

fn create_wc_tax(_args ...rt.PhpVal) &Class_WC_Tax {
	mut obj := &Class_WC_Tax{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Order_Item_Tax) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'set_name' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_name(dispatch_arg_0)
			return rt.new_null()
		}
		'set_rate_code' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_rate_code(dispatch_arg_0)
			return rt.new_null()
		}
		'set_label' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_label(dispatch_arg_0)
			return rt.new_null()
		}
		'set_rate_id' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_rate_id(dispatch_arg_0)
			return rt.new_null()
		}
		'set_tax_total' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_tax_total(dispatch_arg_0)
			return rt.new_null()
		}
		'set_shipping_tax_total' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_shipping_tax_total(dispatch_arg_0)
			return rt.new_null()
		}
		'set_compound' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_compound(dispatch_arg_0)
			return rt.new_null()
		}
		'set_rate_percent' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_rate_percent(dispatch_arg_0)
			return rt.new_null()
		}
		'set_rate' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_rate(dispatch_arg_0)
			return rt.new_null()
		}
		'get_type' {
			return rt.new_string(this.get_type())
		}
		'get_name' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_name(dispatch_arg_0)
		}
		'get_rate_code' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_rate_code(dispatch_arg_0)
		}
		'get_label' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_label(dispatch_arg_0)
		}
		'get_rate_id' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_rate_id(dispatch_arg_0)
		}
		'get_tax_total' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_tax_total(dispatch_arg_0)
		}
		'get_shipping_tax_total' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_shipping_tax_total(dispatch_arg_0)
		}
		'get_compound' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_compound(dispatch_arg_0)
		}
		'is_compound' {
			return this.is_compound()
		}
		'get_rate_percent' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_rate_percent(dispatch_arg_0)
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

fn (this &Class_WC_Order_Item_Tax) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'extra_data' { return this.extra_data }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_Order_Item_Tax) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_WC_Tax) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Tax) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Tax) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}
