import rt

struct Class_WC_Cart_Fees {
	rt.PhpObjectBase
pub mut:
		fees rt.PhpVal = rt.new_array()
		default_fee_props rt.PhpVal = rt.new_array()
}

fn (mut this Class_WC_Cart_Fees) construct(var_deprecated rt.PhpVal)  {
	if !(var_deprecated).is_null() {
		rt.call_function('wc_doing_it_wrong', [rt.new_string('new WC_Cart_Fees'), rt.new_string('You don\'t need to pass a cart parameter to the WC_Cart_Fees constructor anymore'), rt.new_string('8.2.0')])
	}
}

fn (mut this Class_WC_Cart_Fees) init()  {
}

fn (mut this Class_WC_Cart_Fees) add_fee(var_args rt.PhpVal) rt.PhpVal {
	mut var_fee_props := // unsupported expression: Expr_Cast_Object
	rt.set_property(var_fee_props, 'name', if rt.is_true(rt.get_property(var_fee_props, 'name')) { rt.get_property(var_fee_props, 'name') } else { rt.call_function('__', [rt.new_string('Fee'), rt.new_string('woocommerce')]) })
	rt.set_property(var_fee_props, 'tax_class', if rt.is_true(rt.call_function('in_array', [rt.get_property(var_fee_props, 'tax_class'), rt.call_function('array_merge', [fn () rt.PhpVal { mut temp := Class_WC_Tax{}; return temp.get_tax_classes() }(), fn () rt.PhpVal { mut temp := Class_WC_Tax{}; return temp.get_tax_class_slugs() }()]), rt.new_bool(true)])) { rt.get_property(var_fee_props, 'tax_class') } else { rt.new_string('') })
	rt.set_property(var_fee_props, 'taxable', rt.call_function('wc_string_to_bool', [rt.get_property(var_fee_props, 'taxable')]))
	rt.set_property(var_fee_props, 'amount', rt.call_function('wc_format_decimal', [rt.get_property(var_fee_props, 'amount')]))
	if !rt.is_true(rt.get_property(var_fee_props, 'id')) {
		rt.set_property(var_fee_props, 'id', this.generate_id(var_fee_props.dup()))
	}
	if rt.is_true(rt.new_bool(this.fees.array_isset(rt.get_property(var_fee_props, 'id')))) {
		return create_wp_error(rt.new_string('fee_exists'), rt.call_function('__', [rt.new_string('Fee has already been added.'), rt.new_string('woocommerce')]))
	}
	this.fees.array_set(rt.get_property(var_fee_props, 'id'), var_fee_props.dup())
	return this.fees.array_get(rt.get_property(var_fee_props, 'id'))
}

fn (mut this Class_WC_Cart_Fees) get_fees() rt.PhpVal {
	rt.call_function('uasort', [this.fees, rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Cart_Fees', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'sort_fees_callback' }])])
	return this.fees
}

fn (mut this Class_WC_Cart_Fees) set_fees(var_raw_fees rt.PhpVal)  {
	this.fees = rt.new_array()
	{
		mut iter_1 := var_raw_fees.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_raw_fee := item_1.val
			this.add_fee(var_raw_fee.dup())
		}
	}
}

fn (mut this Class_WC_Cart_Fees) remove_all_fees()  {
	this.set_fees(rt.new_null())
}

fn (mut this Class_WC_Cart_Fees) sort_fees_callback(var_a rt.PhpVal, var_b rt.PhpVal) rt.PhpVal {
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_sort_fees_callback'), if rt.is_true(rt.greater(rt.get_property(var_a, 'amount'), rt.get_property(var_b, 'amount'))) { // unsupported expression: Expr_UnaryMinus } else { rt.new_int(1) }, var_a.dup(), var_b.dup()])
}

fn (mut this Class_WC_Cart_Fees) generate_id(var_fee rt.PhpVal) rt.PhpVal {
	return rt.call_function('sanitize_title', [rt.get_property(var_fee, 'name')])
}

struct Class_WC_Tax {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

fn create_wc_cart_fees(arg_0 rt.PhpVal) &Class_WC_Cart_Fees {
	mut obj := &Class_WC_Cart_Fees{
		PhpObjectBase: rt.PhpObjectBase{}
		fees: rt.new_array()
		default_fee_props: rt.new_array()
	}
	obj.construct(arg_0)
	return obj
}

fn create_wc_tax() &Class_WC_Tax {
	mut obj := &Class_WC_Tax{
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

fn (mut this Class_WC_Cart_Fees) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'init' {
			this.init()
			return rt.new_null()
		}
		'add_fee' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.add_fee(dispatch_arg_0)
		}
		'get_fees' {
			return this.get_fees()
		}
		'set_fees' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_fees(dispatch_arg_0)
			return rt.new_null()
		}
		'remove_all_fees' {
			this.remove_all_fees()
			return rt.new_null()
		}
		'sort_fees_callback' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.sort_fees_callback(dispatch_arg_0, dispatch_arg_1)
		}
		'generate_id' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.generate_id(dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_WC_Cart_Fees) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'fees' { return this.fees }
		'default_fee_props' { return this.default_fee_props }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_Cart_Fees) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'fees' { this.fees = val; return true }
		'default_fee_props' { this.default_fee_props = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
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


fn (mut this Class_WP_Error) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Error) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Error) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_includes_class_wc_cart_fees_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
