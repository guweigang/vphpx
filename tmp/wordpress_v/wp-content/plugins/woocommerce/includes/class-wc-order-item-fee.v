import rt

struct Class_WC_Order_Item_Fee {
	rt.PhpObjectBase
pub mut:
		legacy_fee rt.PhpVal = rt.new_string('')
		legacy_fee_key rt.PhpVal = rt.new_string('')
		extra_data rt.PhpVal = rt.new_array()
}

fn (mut this Class_WC_Order_Item_Fee) get_tax_class_costs(var_order rt.PhpVal) rt.PhpVal {
	mut var_order_mutated := var_order
	mut var_order_item_tax_classes := rt.call_method(var_order_mutated, 'get_items_tax_classes', []rt.PhpVal{})
	mut var_costs := rt.call_function('array_fill_keys', [var_order_item_tax_classes.dup(), rt.new_int(0)])
	var_costs.array_set('non-taxable', 0)
	{
		mut iter_1 := rt.call_method(var_order_mutated, 'get_items', [rt.create_array([rt.ArrayItem{ key: none, val: 'line_item' }, rt.ArrayItem{ key: none, val: 'fee' }, rt.ArrayItem{ key: none, val: 'shipping' }])]).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_item := item_1.val
			if rt.is_true(rt.greater(rt.new_int(0), rt.call_method(var_item, 'get_total', []rt.PhpVal{}))) {
				continue
			}
			if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
				// unsupported expression: Expr_AssignOp_Plus
			} else if rt.is_true(rt.identical(rt.new_string('inherit'), rt.call_method(var_item, 'get_tax_class', []rt.PhpVal{}))) {
				mut var_inherit_class := rt.call_function('reset', [var_order_item_tax_classes.dup()])
				// unsupported expression: Expr_AssignOp_Plus
			} else {
				// unsupported expression: Expr_AssignOp_Plus
			}
		}
	}
	return rt.call_function('array_filter', [var_costs.dup()])
}

fn (mut this Class_WC_Order_Item_Fee) calculate_taxes(var_calculate_tax_for rt.PhpVal) bool {
	mut var_calculate_tax_for_mutated := var_calculate_tax_for
	if !(var_calculate_tax_for_mutated.array_isset(rt.new_string('country')) && var_calculate_tax_for_mutated.array_isset(rt.new_string('state')) && var_calculate_tax_for_mutated.array_isset(rt.new_string('postcode')) && var_calculate_tax_for_mutated.array_isset(rt.new_string('city'))) {
		return false
	}
	if rt.is_true(rt.less_equal(rt.new_int(0), this.get_total(''))) {
		return (this.Class_WC_Order_Item.calculate_taxes(var_calculate_tax_for_mutated.dup())).to_bool()
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('wc_tax_enabled', []rt.PhpVal{})) && rt.is_true(this.get_order()))) {
		mut var_order := this.get_order()
		mut var_tax_class_costs := this.get_tax_class_costs(var_order.dup())
		mut var_total_costs := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Utilities_NumberUtil{}; return temp.array_sum(arg_0) }(var_tax_class_costs.dup())
		mut var_discount_taxes := rt.new_array()
		if rt.is_true(var_total_costs) {
			{
				mut iter_1 := var_tax_class_costs.iterator()
				for {
					item_1 := iter_1.next() or { break }
					mut var_tax_class_cost := item_1.val
					mut var_tax_class := item_1.key
					if rt.is_true(rt.identical(rt.new_string('non-taxable'), var_tax_class)) {
						continue
					}
					mut var_proportion := rt.div(var_tax_class_cost, var_total_costs)
					mut var_cart_discount_proportion := rt.mul(this.get_total(''), var_proportion)
					var_calculate_tax_for_mutated.array_set('tax_class', var_tax_class.dup())
					mut var_tax_rates := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Tax{}; return temp.find_rates(arg_0) }(var_calculate_tax_for_mutated.dup())
					var_discount_taxes = rt.call_function('wc_array_merge_recursive_numeric', [var_discount_taxes.dup(), fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Tax{}; return temp.calc_tax(arg_0, arg_1) }(var_cart_discount_proportion.dup(), var_tax_rates.dup())])
				}
			}
		}
		this.set_taxes(rt.create_array([rt.ArrayItem{ key: 'total', val: var_discount_taxes }]))
	} else {
		this.set_taxes(rt.new_bool(false))
	}
	rt.call_function('do_action', [rt.new_string('woocommerce_order_item_fee_after_calculate_taxes'), rt.new_object('WC_Order_Item_Fee', ['WC_Order_Item'], &this), var_calculate_tax_for_mutated.dup()])
	return true
}

fn (mut this Class_WC_Order_Item_Fee) set_amount(var_value rt.PhpVal)  {
	this.set_prop(rt.new_string('amount'), rt.call_function('wc_format_decimal', [var_value.dup()]))
}

fn (mut this Class_WC_Order_Item_Fee) set_tax_class(var_value rt.PhpVal)  {
	if rt.is_true(rt.new_bool(rt.is_true(var_value) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_value.dup(), fn () rt.PhpVal { mut temp := Class_WC_Tax{}; return temp.get_tax_class_slugs() }(), rt.new_bool(true)]))))))) {
		this.error(rt.new_string('order_item_fee_invalid_tax_class'), rt.call_function('__', [rt.new_string('Invalid tax class'), rt.new_string('woocommerce')]))
	}
	this.set_prop(rt.new_string('tax_class'), var_value.dup())
}

fn (mut this Class_WC_Order_Item_Fee) set_tax_status(var_value rt.PhpVal)  {
	if rt.is_true(rt.call_function('in_array', [var_value.dup(), rt.create_array([rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_ProductTaxStatus.taxable() }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_ProductTaxStatus.none() }]), rt.new_bool(true)])) {
		this.set_prop(rt.new_string('tax_status'), var_value.dup())
	} else {
		this.set_prop(rt.new_string('tax_status'), Class_Automattic_WooCommerce_Enums_ProductTaxStatus.taxable())
	}
}

fn (mut this Class_WC_Order_Item_Fee) set_total(var_amount rt.PhpVal)  {
	this.set_prop(rt.new_string('total'), rt.call_function('wc_format_decimal', [var_amount.dup()]))
}

fn (mut this Class_WC_Order_Item_Fee) set_total_tax(var_amount rt.PhpVal)  {
	this.set_prop(rt.new_string('total_tax'), rt.call_function('wc_format_decimal', [var_amount.dup()]))
}

fn (mut this Class_WC_Order_Item_Fee) set_taxes(var_raw_tax_data rt.PhpVal)  {
	mut var_raw_tax_data_mutated := var_raw_tax_data
	var_raw_tax_data_mutated = rt.call_function('maybe_unserialize', [var_raw_tax_data_mutated.dup()])
	mut var_tax_data := { 'total': rt.new_array() }
	if !(!rt.is_true(var_raw_tax_data_mutated.array_get('total'))) {
		mut var_total := var_raw_tax_data_mutated.array_get('total')
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_total.dup().is_array()))))) {
			mut var_order := this.get_order()
			var_total = this.convert_legacy_tax_value_to_array(var_total.dup(), var_order.dup())
			rt.call_method(rt.call_function('wc_get_logger', []rt.PhpVal{}), 'warning', [rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Order item #%d contains legacy tax data format. Tax rate ID information is unavailable.'), rt.new_string('woocommerce')]), this.get_id()]), rt.create_array([rt.ArrayItem{ key: 'source', val: 'woocommerce-order-item-fee' }, rt.ArrayItem{ key: 'order_item_id', val: this.get_id() }, rt.ArrayItem{ key: 'order_id', val: if rt.is_true(var_order) { rt.call_method(var_order, 'get_id', []rt.PhpVal{}) } else { rt.new_int(0) } }])])
		}
		var_tax_data['total'] = rt.call_function('array_map', [rt.new_string('wc_format_decimal'), var_total.dup()])
	}
	this.set_prop(rt.new_string('taxes'), var_tax_data.dup())
	if rt.is_true(rt.identical(rt.new_string('yes'), rt.call_function('get_option', [rt.new_string('woocommerce_tax_round_at_subtotal')]))) {
		this.set_total_tax(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Utilities_NumberUtil{}; return temp.array_sum(arg_0) }(var_tax_data.array_get('total')))
	} else {
		this.set_total_tax(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Utilities_NumberUtil{}; return temp.array_sum(arg_0) }(rt.call_function('array_map', [rt.new_string('wc_round_tax_total'), var_tax_data.array_get('total')])))
	}
}

fn (mut this Class_WC_Order_Item_Fee) get_amount(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('amount'), rt.new_string(context))
}

fn (mut this Class_WC_Order_Item_Fee) get_name(context string) rt.PhpVal {
	mut var_name := this.get_prop(rt.new_string('name'), rt.new_string(context))
	if rt.is_true(rt.identical(rt.new_string('view'), rt.new_string(context))) {
		return if rt.is_true(var_name) { var_name } else { rt.call_function('__', [rt.new_string('Fee'), rt.new_string('woocommerce')]) }
	} else {
		return var_name.dup()
	}
	return rt.new_null()
}

fn (mut this Class_WC_Order_Item_Fee) get_type() string {
	return 'fee'
}

fn (mut this Class_WC_Order_Item_Fee) get_tax_class(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('tax_class'), rt.new_string(context))
}

fn (mut this Class_WC_Order_Item_Fee) get_tax_status(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('tax_status'), rt.new_string(context))
}

fn (mut this Class_WC_Order_Item_Fee) get_total(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('total'), rt.new_string(context))
}

fn (mut this Class_WC_Order_Item_Fee) get_total_tax(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('total_tax'), rt.new_string(context))
}

fn (mut this Class_WC_Order_Item_Fee) get_taxes(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('taxes'), rt.new_string(context))
}

fn (mut this Class_WC_Order_Item_Fee) offsetget(var_offset rt.PhpVal) rt.PhpVal {
	mut var_offset_mutated := var_offset
	if rt.is_true(rt.identical(rt.new_string('line_total'), var_offset_mutated)) {
		var_offset_mutated = rt.new_string(rt.new_string('total'))
	} else if rt.is_true(rt.identical(rt.new_string('line_tax'), var_offset_mutated)) {
		var_offset_mutated = rt.new_string(rt.new_string('total_tax'))
	} else if rt.is_true(rt.identical(rt.new_string('line_tax_data'), var_offset_mutated)) {
		var_offset_mutated = rt.new_string(rt.new_string('taxes'))
	}
	return this.Class_WC_Order_Item.offsetget(var_offset_mutated.dup())
}

fn (mut this Class_WC_Order_Item_Fee) offsetset(var_offset rt.PhpVal, var_value rt.PhpVal)  {
	mut var_offset_mutated := var_offset
	rt.call_function('wc_deprecated_function', [rt.new_string('WC_Order_Item_Fee::offsetSet'), rt.new_string('4.4.0'), rt.new_string('')])
	if rt.is_true(rt.identical(rt.new_string('line_total'), var_offset_mutated)) {
		var_offset_mutated = rt.new_string(rt.new_string('total'))
	} else if rt.is_true(rt.identical(rt.new_string('line_tax'), var_offset_mutated)) {
		var_offset_mutated = rt.new_string(rt.new_string('total_tax'))
	} else if rt.is_true(rt.identical(rt.new_string('line_tax_data'), var_offset_mutated)) {
		var_offset_mutated = rt.new_string(rt.new_string('taxes'))
	}
	this.Class_WC_Order_Item.offsetset(var_offset_mutated.dup(), var_value.dup())
}

fn (mut this Class_WC_Order_Item_Fee) offsetexists(var_offset rt.PhpVal) bool {
	mut var_offset_mutated := var_offset
	if rt.is_true(rt.call_function('in_array', [var_offset_mutated.dup(), rt.create_array([rt.ArrayItem{ key: none, val: 'line_total' }, rt.ArrayItem{ key: none, val: 'line_tax' }, rt.ArrayItem{ key: none, val: 'line_tax_data' }]), rt.new_bool(true)])) {
		return true
	}
	return (this.Class_WC_Order_Item.offsetexists(var_offset_mutated.dup())).to_bool()
}

struct Class_WC_Order_Item {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Utilities_NumberUtil {
	rt.PhpObjectBase
}

struct Class_WC_Tax {
	rt.PhpObjectBase
}

fn create_wc_order_item_fee() &Class_WC_Order_Item_Fee {
	mut obj := &Class_WC_Order_Item_Fee{
		PhpObjectBase: rt.PhpObjectBase{}
		legacy_fee: rt.new_string('')
		legacy_fee_key: rt.new_string('')
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

fn create_automattic_woocommerce_utilities_numberutil() &Class_Automattic_WooCommerce_Utilities_NumberUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_NumberUtil{
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

fn (mut this Class_WC_Order_Item_Fee) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_tax_class_costs' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_tax_class_costs(dispatch_arg_0)
		}
		'calculate_taxes' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.calculate_taxes(dispatch_arg_0))
		}
		'set_amount' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_amount(dispatch_arg_0)
			return rt.new_null()
		}
		'set_tax_class' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_tax_class(dispatch_arg_0)
			return rt.new_null()
		}
		'set_tax_status' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_tax_status(dispatch_arg_0)
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
		'get_amount' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_amount(dispatch_arg_0)
		}
		'get_name' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_name(dispatch_arg_0)
		}
		'get_type' {
			return rt.new_string(this.get_type())
		}
		'get_tax_class' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_tax_class(dispatch_arg_0)
		}
		'get_tax_status' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_tax_status(dispatch_arg_0)
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

fn (this &Class_WC_Order_Item_Fee) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'legacy_fee' { return this.legacy_fee }
		'legacy_fee_key' { return this.legacy_fee_key }
		'extra_data' { return this.extra_data }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_Order_Item_Fee) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'legacy_fee' { this.legacy_fee = val; return true }
		'legacy_fee_key' { this.legacy_fee_key = val; return true }
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


fn (mut this Class_Automattic_WooCommerce_Utilities_NumberUtil) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Utilities_NumberUtil) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_NumberUtil) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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




pub fn init_wp_content_plugins_woocommerce_includes_class_wc_order_item_fee_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
