import rt

struct Class_WC_Order_Item_Shipping {
	rt.PhpObjectBase
pub mut:
		extra_data rt.PhpVal = rt.new_array()
}

fn (mut this Class_WC_Order_Item_Shipping) calculate_taxes(var_calculate_tax_for rt.PhpVal) bool {
	if !(var_calculate_tax_for.array_isset(rt.new_string('country')) && var_calculate_tax_for.array_isset(rt.new_string('state')) && var_calculate_tax_for.array_isset(rt.new_string('postcode')) && var_calculate_tax_for.array_isset(rt.new_string('city')) && var_calculate_tax_for.array_isset(rt.new_string('tax_class'))) {
		return false
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('wc_tax_enabled', []rt.PhpVal{})) && rt.is_true(rt.identical(Class_Automattic_WooCommerce_Enums_ProductTaxStatus.taxable(), this.get_tax_status(''))))) {
		mut var_tax_rates := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Tax{}; return temp.find_shipping_rates(arg_0) }(var_calculate_tax_for.dup())
		mut var_taxes := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Tax{}; return temp.calc_tax(arg_0, arg_1, arg_2) }(this.get_total(''), var_tax_rates.dup(), rt.new_bool(false))
		this.set_taxes(rt.create_array([rt.ArrayItem{ key: 'total', val: var_taxes }]))
	} else {
		this.set_taxes(rt.new_bool(false))
	}
	rt.call_function('do_action', [rt.new_string('woocommerce_order_item_shipping_after_calculate_taxes'), rt.new_object('WC_Order_Item_Shipping', ['WC_Order_Item'], &this), var_calculate_tax_for.dup()])
	return true
}

fn (mut this Class_WC_Order_Item_Shipping) set_name(var_value rt.PhpVal)  {
	this.set_method_title(var_value.dup())
}

fn (mut this Class_WC_Order_Item_Shipping) set_method_title(var_value rt.PhpVal)  {
	this.set_prop(rt.new_string('name'), rt.call_function('wc_clean', [var_value.dup()]))
	this.set_prop(rt.new_string('method_title'), rt.call_function('wc_clean', [var_value.dup()]))
}

fn (mut this Class_WC_Order_Item_Shipping) set_method_id(var_value rt.PhpVal)  {
	this.set_prop(rt.new_string('method_id'), rt.call_function('wc_clean', [var_value.dup()]))
}

fn (mut this Class_WC_Order_Item_Shipping) set_instance_id(var_value rt.PhpVal)  {
	this.set_prop(rt.new_string('instance_id'), rt.call_function('wc_clean', [var_value.dup()]))
}

fn (mut this Class_WC_Order_Item_Shipping) set_total(var_value rt.PhpVal)  {
	this.set_prop(rt.new_string('total'), rt.call_function('wc_format_decimal', [var_value.dup()]))
}

fn (mut this Class_WC_Order_Item_Shipping) set_total_tax(var_value rt.PhpVal)  {
	this.set_prop(rt.new_string('total_tax'), rt.call_function('wc_format_decimal', [var_value.dup()]))
}

fn (mut this Class_WC_Order_Item_Shipping) set_taxes(var_raw_tax_data rt.PhpVal)  {
	mut var_raw_tax_data_mutated := var_raw_tax_data
	var_raw_tax_data_mutated = rt.call_function('maybe_unserialize', [var_raw_tax_data_mutated.dup()])
	mut var_tax_data := { 'total': map[string]rt.PhpVal{} }
	if var_raw_tax_data_mutated.array_isset(rt.new_string('total')) {
		mut var_total := var_raw_tax_data_mutated.array_get('total')
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_total.dup().is_array()))))) {
			mut var_order := this.get_order()
			var_total = this.convert_legacy_tax_value_to_array(var_total.dup(), var_order.dup())
			rt.call_method(rt.call_function('wc_get_logger', []rt.PhpVal{}), 'warning', [rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Order item #%d contains legacy tax data format. Tax rate ID information is unavailable.'), rt.new_string('woocommerce')]), this.get_id()]), rt.create_array([rt.ArrayItem{ key: 'source', val: 'woocommerce-order-item-shipping' }, rt.ArrayItem{ key: 'order_item_id', val: this.get_id() }, rt.ArrayItem{ key: 'order_id', val: if rt.is_true(var_order) { rt.call_method(var_order, 'get_id', []rt.PhpVal{}) } else { rt.new_int(0) } }])])
		}
		var_tax_data['total'] = rt.call_function('array_map', [rt.new_string('wc_format_decimal'), var_total.dup()])
	} else if rt.is_true(rt.new_bool(!(!rt.is_true(var_raw_tax_data_mutated)) && rt.is_true(rt.new_bool(var_raw_tax_data_mutated.dup().is_array())))) {
		var_tax_data['total'] = rt.call_function('array_map', [rt.new_string('wc_format_decimal'), var_raw_tax_data_mutated.dup()])
	}
	this.set_prop(rt.new_string('taxes'), var_tax_data.dup())
	if rt.is_true(rt.identical(rt.new_string('yes'), rt.call_function('get_option', [rt.new_string('woocommerce_tax_round_at_subtotal')]))) {
		this.set_total_tax(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Utilities_NumberUtil{}; return temp.array_sum(arg_0) }(var_tax_data.array_get('total')))
	} else {
		this.set_total_tax(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Utilities_NumberUtil{}; return temp.array_sum(arg_0) }(rt.call_function('array_map', [rt.new_string('wc_round_tax_total'), var_tax_data.array_get('total')])))
	}
}

fn (mut this Class_WC_Order_Item_Shipping) set_tax_status(var_value rt.PhpVal)  {
}

fn (mut this Class_WC_Order_Item_Shipping) set_shipping_rate(var_shipping_rate rt.PhpVal)  {
	this.set_method_title(rt.call_method(var_shipping_rate, 'get_label', []rt.PhpVal{}))
	this.set_method_id(rt.call_method(var_shipping_rate, 'get_method_id', []rt.PhpVal{}))
	this.set_instance_id(rt.call_method(var_shipping_rate, 'get_instance_id', []rt.PhpVal{}))
	this.set_total(rt.call_method(var_shipping_rate, 'get_cost', []rt.PhpVal{}))
	this.set_taxes(rt.call_method(var_shipping_rate, 'get_taxes', []rt.PhpVal{}))
	this.set_meta_data(rt.call_method(var_shipping_rate, 'get_meta_data', []rt.PhpVal{}))
}

fn (mut this Class_WC_Order_Item_Shipping) get_type() string {
	return 'shipping'
}

fn (mut this Class_WC_Order_Item_Shipping) get_name(context string) rt.PhpVal {
	return this.get_method_title(context)
}

fn (mut this Class_WC_Order_Item_Shipping) get_method_title(context string) rt.PhpVal {
	mut var_method_title := this.get_prop(rt.new_string('method_title'), rt.new_string(context))
	if rt.is_true(rt.identical(rt.new_string('view'), rt.new_string(context))) {
		return if rt.is_true(var_method_title) { var_method_title } else { rt.call_function('__', [rt.new_string('Shipping'), rt.new_string('woocommerce')]) }
	} else {
		return var_method_title.dup()
	}
	return rt.new_null()
}

fn (mut this Class_WC_Order_Item_Shipping) get_method_id(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('method_id'), rt.new_string(context))
}

fn (mut this Class_WC_Order_Item_Shipping) get_instance_id(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('instance_id'), rt.new_string(context))
}

fn (mut this Class_WC_Order_Item_Shipping) get_total(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('total'), rt.new_string(context))
}

fn (mut this Class_WC_Order_Item_Shipping) get_total_tax(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('total_tax'), rt.new_string(context))
}

fn (mut this Class_WC_Order_Item_Shipping) get_taxes(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('taxes'), rt.new_string(context))
}

fn (mut this Class_WC_Order_Item_Shipping) get_tax_class(context string) rt.PhpVal {
	return rt.call_function('get_option', [rt.new_string('woocommerce_shipping_tax_class')])
}

fn (mut this Class_WC_Order_Item_Shipping) get_tax_status(context string) rt.PhpVal {
	mut var_shipping_method := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Shipping_Zones{}; return temp.get_shipping_method(arg_0) }(this.get_instance_id(''))
	return if rt.is_true(rt.new_bool(rt.instance_of(var_shipping_method, 'WC_Shipping_Method'))) { rt.get_property(var_shipping_method, 'tax_status') } else { Class_Automattic_WooCommerce_Enums_ProductTaxStatus.taxable() }
}

fn (mut this Class_WC_Order_Item_Shipping) offsetget(var_offset rt.PhpVal) rt.PhpVal {
	mut var_offset_mutated := var_offset
	if rt.is_true(rt.identical(rt.new_string('cost'), var_offset_mutated)) {
		var_offset_mutated = rt.new_string(rt.new_string('total'))
	}
	return this.Class_WC_Order_Item.offsetget(var_offset_mutated.dup())
}

fn (mut this Class_WC_Order_Item_Shipping) offsetset(var_offset rt.PhpVal, var_value rt.PhpVal)  {
	mut var_offset_mutated := var_offset
	rt.call_function('wc_deprecated_function', [rt.new_string('WC_Order_Item_Shipping::offsetSet'), rt.new_string('4.4.0'), rt.new_string('')])
	if rt.is_true(rt.identical(rt.new_string('cost'), var_offset_mutated)) {
		var_offset_mutated = rt.new_string(rt.new_string('total'))
	}
	this.Class_WC_Order_Item.offsetset(var_offset_mutated.dup(), var_value.dup())
}

fn (mut this Class_WC_Order_Item_Shipping) offsetexists(var_offset rt.PhpVal) bool {
	mut var_offset_mutated := var_offset
	if rt.is_true(rt.call_function('in_array', [var_offset_mutated.dup(), rt.create_array([rt.ArrayItem{ key: none, val: 'cost' }]), rt.new_bool(true)])) {
		return true
	}
	return (this.Class_WC_Order_Item.offsetexists(var_offset_mutated.dup())).to_bool()
}

struct Class_WC_Order_Item {
	rt.PhpObjectBase
}

struct Class_WC_Tax {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Utilities_NumberUtil {
	rt.PhpObjectBase
}

struct Class_WC_Shipping_Zones {
	rt.PhpObjectBase
}

fn create_wc_order_item_shipping() &Class_WC_Order_Item_Shipping {
	mut obj := &Class_WC_Order_Item_Shipping{
		PhpObjectBase: rt.PhpObjectBase{}
		extra_data: rt.new_array()
	}
	return obj
}

fn create_wc_order_item() &Class_WC_Order_Item {
	mut obj := &Class_WC_Order_Item{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_tax() &Class_WC_Tax {
	mut obj := &Class_WC_Tax{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_utilities_numberutil() &Class_Automattic_WooCommerce_Utilities_NumberUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_NumberUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_shipping_zones() &Class_WC_Shipping_Zones {
	mut obj := &Class_WC_Shipping_Zones{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Order_Item_Shipping) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'calculate_taxes' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.calculate_taxes(dispatch_arg_0))
		}
		'set_name' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_name(dispatch_arg_0)
			return rt.new_null()
		}
		'set_method_title' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_method_title(dispatch_arg_0)
			return rt.new_null()
		}
		'set_method_id' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_method_id(dispatch_arg_0)
			return rt.new_null()
		}
		'set_instance_id' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_instance_id(dispatch_arg_0)
			return rt.new_null()
		}
		'set_total' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_total(dispatch_arg_0)
			return rt.new_null()
		}
		'set_total_tax' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_total_tax(dispatch_arg_0)
			return rt.new_null()
		}
		'set_taxes' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_taxes(dispatch_arg_0)
			return rt.new_null()
		}
		'set_tax_status' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_tax_status(dispatch_arg_0)
			return rt.new_null()
		}
		'set_shipping_rate' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_shipping_rate(dispatch_arg_0)
			return rt.new_null()
		}
		'get_type' {
			return rt.new_string(this.get_type())
		}
		'get_name' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_name(dispatch_arg_0)
		}
		'get_method_title' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_method_title(dispatch_arg_0)
		}
		'get_method_id' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_method_id(dispatch_arg_0)
		}
		'get_instance_id' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_instance_id(dispatch_arg_0)
		}
		'get_total' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_total(dispatch_arg_0)
		}
		'get_total_tax' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_total_tax(dispatch_arg_0)
		}
		'get_taxes' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_taxes(dispatch_arg_0)
		}
		'get_tax_class' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_tax_class(dispatch_arg_0)
		}
		'get_tax_status' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_tax_status(dispatch_arg_0)
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
		else { return none }
	}
}

fn (this &Class_WC_Order_Item_Shipping) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'extra_data' { return this.extra_data }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_Order_Item_Shipping) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'extra_data' { this.extra_data = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
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


fn (mut this Class_Automattic_WooCommerce_Utilities_NumberUtil) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Utilities_NumberUtil) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_NumberUtil) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_Shipping_Zones) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Shipping_Zones) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Shipping_Zones) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_includes_class_wc_order_item_shipping_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
