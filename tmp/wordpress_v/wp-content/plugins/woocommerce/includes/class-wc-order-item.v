import rt

struct Class_WC_Order_Item {
	rt.PhpObjectBase
pub mut:
		legacy_values rt.PhpVal = rt.new_null()
		legacy_cart_item_key rt.PhpVal = rt.new_null()
		data rt.PhpVal = rt.new_array()
		cache_group rt.PhpVal = rt.new_string('order-items')
		meta_type rt.PhpVal = rt.new_string('order_item')
		object_type rt.PhpVal = rt.new_string('order_item')
		legacy_package_key rt.PhpVal = rt.new_null()
}

fn (mut this Class_WC_Order_Item) construct(item i64)  {
	if rt.is_true(rt.new_bool(this.has_cogs() && rt.is_true(this.cogs_is_enabled()))) {
		this.data.array_set('cogs_value', rt.new_null())
	}
	this.Class_WC_Data.construct(rt.new_int(item))
	if rt.is_true(rt.new_bool(rt.instance_of(rt.new_int(item), 'WC_Order_Item'))) {
		this.set_id(rt.call_method(rt.new_int(item), 'get_id', []rt.PhpVal{}))
	} else if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.new_int(item).is_long() || rt.new_int(item).is_double())) && item > 0)) {
		this.set_id(rt.new_int(item))
	} else {
		this.set_object_read(rt.new_bool(true))
	}
	if rt.is_true(rt.new_bool(rt.is_true(this.get_id()) && rt.is_true(rt.identical(rt.new_string(@STRUCT), rt.call_function('get_class', [rt.new_object('WC_Order_Item', ['WC_Data', 'ArrayAccess'], &this)]))))) {
		rt.call_function('wc_doing_it_wrong', [rt.new_string(@METHOD), rt.new_string('WC_Order_Item should not be instantiated directly.'), rt.new_string('9.9.0')])
		return
	}
	mut var_type := rt.new_string(if rt.is_true(rt.identical(rt.new_string('line_item'), this.get_type())) { rt.new_string('product') } else { this.get_type() })
	this.dispatch_set_prop('data_store', fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Data_Store{}; return temp.load(arg_0) }(rt.new_string('order-item-' + (var_type).str())))
	if rt.is_true(rt.greater(this.get_id(), rt.new_int(0))) {
		rt.call_method(rt.get_property(rt.new_object('WC_Order_Item', ['WC_Data', 'ArrayAccess'], &this), 'data_store'), 'read', [rt.new_object('WC_Order_Item', ['WC_Data', 'ArrayAccess'], &this)])
	}
}

fn (mut this Class_WC_Order_Item) apply_changes()  {
	this.data = rt.call_function('array_replace', [this.data, rt.get_property(rt.new_object('WC_Order_Item', ['WC_Data', 'ArrayAccess'], &this), 'changes')])
	this.dispatch_set_prop('changes', rt.new_array())
}

fn (mut this Class_WC_Order_Item) get_order_id(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('order_id'), rt.new_string(context))
}

fn (mut this Class_WC_Order_Item) get_name(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('name'), rt.new_string(context))
}

fn (mut this Class_WC_Order_Item) get_type() string {
	return ''
}

fn (mut this Class_WC_Order_Item) get_quantity() i64 {
	return 1
}

fn (mut this Class_WC_Order_Item) get_tax_status() rt.PhpVal {
	return Class_Automattic_WooCommerce_Enums_ProductTaxStatus.taxable()
}

fn (mut this Class_WC_Order_Item) get_tax_class() string {
	return ''
}

fn (mut this Class_WC_Order_Item) get_order() rt.PhpVal {
	return rt.call_function('wc_get_order', [this.get_order_id('')])
}

fn (mut this Class_WC_Order_Item) set_order_id(var_value rt.PhpVal)  {
	mut var_value_mutated := var_value
	this.set_prop(rt.new_string('order_id'), rt.call_function('absint', [var_value_mutated.dup()]))
}

fn (mut this Class_WC_Order_Item) set_name(var_value rt.PhpVal)  {
	mut var_value_mutated := var_value
	this.set_prop(rt.new_string('name'), rt.call_function('wp_check_invalid_utf8', [var_value_mutated.dup()]))
}

fn (mut this Class_WC_Order_Item) is_type(var_type rt.PhpVal) rt.PhpVal {
	mut var_type_mutated := var_type
	return if rt.is_true(rt.new_bool(var_type_mutated.dup().is_array())) { rt.call_function('in_array', [this.get_type(), var_type_mutated.dup(), rt.new_bool(true)]) } else { rt.identical(var_type_mutated, this.get_type()) }
}

fn (mut this Class_WC_Order_Item) calculate_taxes(var_calculate_tax_for rt.PhpVal) bool {
	mut var_calculate_tax_for_mutated := var_calculate_tax_for
	if !(var_calculate_tax_for_mutated.array_isset(rt.new_string('country')) && var_calculate_tax_for_mutated.array_isset(rt.new_string('state')) && var_calculate_tax_for_mutated.array_isset(rt.new_string('postcode')) && var_calculate_tax_for_mutated.array_isset(rt.new_string('city'))) {
		return false
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) && rt.is_true(rt.identical(Class_Automattic_WooCommerce_Enums_ProductTaxStatus.taxable(), this.get_tax_status())))) && rt.is_true(rt.call_function('wc_tax_enabled', []rt.PhpVal{})))) {
		var_calculate_tax_for_mutated.array_set('tax_class', this.get_tax_class())
		mut var_tax_rates := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Tax{}; return temp.find_rates(arg_0) }(var_calculate_tax_for_mutated.dup())
		mut var_taxes := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Tax{}; return temp.calc_tax(arg_0, arg_1, arg_2) }(this.get_total(), var_tax_rates.dup(), rt.new_bool(false))
		if rt.is_true(rt.call_function('method_exists', [rt.new_object('WC_Order_Item', ['WC_Data', 'ArrayAccess'], &this), rt.new_string('get_subtotal')])) {
			mut var_subtotal_taxes := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Tax{}; return temp.calc_tax(arg_0, arg_1, arg_2) }(this.get_subtotal(), var_tax_rates.dup(), rt.new_bool(false))
			this.set_taxes(rt.create_array([rt.ArrayItem{ key: 'total', val: var_taxes }, rt.ArrayItem{ key: 'subtotal', val: var_subtotal_taxes }]))
		} else {
			this.set_taxes(rt.create_array([rt.ArrayItem{ key: 'total', val: var_taxes }]))
		}
	} else {
		this.set_taxes(rt.new_bool(false))
	}
	rt.call_function('do_action', [rt.new_string('woocommerce_order_item_after_calculate_taxes'), rt.new_object('WC_Order_Item', ['WC_Data', 'ArrayAccess'], &this), var_calculate_tax_for_mutated.dup()])
	return true
}

fn (mut this Class_WC_Order_Item) get_all_formatted_meta_data(hideprefix string, include_all bool) rt.PhpVal {
	return this.get_formatted_meta_data(hideprefix, include_all)
}

fn (mut this Class_WC_Order_Item) get_formatted_meta_data(hideprefix string, include_all bool) rt.PhpVal {
	mut var_formatted_meta := rt.new_array()
	mut var_meta_data := this.get_meta_data()
	mut var_hideprefix_length := rt.new_int(if !(hideprefix == '') { rt.new_int(hideprefix.len) } else { rt.new_int(0) })
	mut var_product := if rt.is_true(rt.call_function('is_callable', [rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Order_Item', ['WC_Data', 'ArrayAccess'], &this) }, rt.ArrayItem{ key: none, val: 'get_product' }])])) { this.get_product() } else { rt.new_bool(false) }
	mut var_order_item_name := this.get_name('')
	{
		mut iter_1 := var_meta_data.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_meta := item_1.val
			if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!rt.is_true(rt.get_property(var_meta, 'id')) || rt.is_true(rt.identical(rt.new_string(''), rt.get_property(var_meta, 'value'))))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_scalar', [rt.get_property(var_meta, 'value')]))))))) || rt.is_true(rt.new_bool(rt.is_true(var_hideprefix_length) && rt.is_true(rt.identical(rt.call_function('substr', [rt.get_property(var_meta, 'key'), rt.new_int(0), var_hideprefix_length.dup()]), rt.new_string(hideprefix))))))) {
				continue
			}
			rt.set_property(var_meta, 'key', rt.call_function('rawurldecode', [// unsupported expression: Expr_Cast_String]))
			rt.set_property(var_meta, 'value', rt.call_function('rawurldecode', [// unsupported expression: Expr_Cast_String]))
			mut var_attribute_key := rt.call_function('str_replace', [rt.new_string('attribute_'), rt.new_string(''), rt.get_property(var_meta, 'key')])
			mut var_display_key := rt.call_function('wc_attribute_label', [var_attribute_key.dup(), var_product.dup()])
			mut var_display_value := rt.call_function('wp_kses_post', [rt.get_property(var_meta, 'value')])
			if rt.is_true(rt.call_function('taxonomy_exists', [var_attribute_key.dup()])) {
				mut var_term := rt.call_function('get_term_by', [rt.new_string('slug'), rt.get_property(var_meta, 'value'), var_attribute_key.dup()])
				if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [var_term.dup()]))))) && rt.is_true(rt.new_bool(var_term.dup().is_object())))) && rt.is_true(rt.get_property(var_term, 'name')))) {
					var_display_value = rt.get_property(var_term, 'name')
				}
			}
			if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(var_include_all) && rt.is_true(var_product))) && rt.is_true(rt.call_method(var_product, 'is_type', [Class_Automattic_WooCommerce_Enums_ProductType.variation()])))) && rt.is_true(rt.call_function('wc_is_attribute_in_product_name', [var_display_value.dup(), var_order_item_name.dup()])))) {
				continue
			}
			var_formatted_meta.array_set(rt.get_property(var_meta, 'id'), // unsupported expression: Expr_Cast_Object)
		}
	}
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_order_item_get_formatted_meta_data'), var_formatted_meta.dup(), rt.new_object('WC_Order_Item', ['WC_Data', 'ArrayAccess'], &this)])
}

fn (mut this Class_WC_Order_Item) offsetset(var_offset rt.PhpVal, var_value rt.PhpVal)  {
	mut var_value_mutated := var_value
	if rt.is_true(rt.identical(rt.new_string('item_meta_array'), var_offset)) {
		{
			mut iter_1 := var_value_mutated.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_meta := item_1.val
				mut var_meta_id := item_1.key
				this.update_meta_data(rt.get_property(var_meta, 'key'), rt.get_property(var_meta, 'value'), var_meta_id.dup())
			}
		}
		return rt.new_null()
	}
	if rt.is_true(rt.new_bool(this.data.array_isset(var_offset.dup()))) {
		mut var_setter := rt.new_string(rt.new_string("set_${var_offset.to_string()}"))
		if rt.is_true(rt.call_function('is_callable', [rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Order_Item', ['WC_Data', 'ArrayAccess'], &this) }, rt.ArrayItem{ key: none, val: var_setter }])])) {
			rt.call_method(rt.new_object('WC_Order_Item', ['WC_Data', 'ArrayAccess'], &this), var_setter, [var_value_mutated.dup()])
		}
		return rt.new_null()
	}
	this.update_meta_data(var_offset.dup(), var_value_mutated.dup())
}

fn (mut this Class_WC_Order_Item) offsetunset(var_offset rt.PhpVal)  {
	this.maybe_read_meta_data()
	if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('item_meta_array'), var_offset)) || rt.is_true(rt.identical(rt.new_string('item_meta'), var_offset)))) {
		this.dispatch_set_prop('meta_data', rt.new_array())
		return rt.new_null()
	}
	if rt.is_true(rt.new_bool(this.data.array_isset(var_offset.dup()))) {
		this.data.array_unset(var_offset)
	}
	if rt.is_true(rt.new_bool(rt.get_property(rt.new_object('WC_Order_Item', ['WC_Data', 'ArrayAccess'], &this), 'changes').array_isset(var_offset.dup()))) {
		rt.get_property(rt.new_object('WC_Order_Item', ['WC_Data', 'ArrayAccess'], &this), 'changes').array_unset(var_offset)
	}
	this.delete_meta_data(var_offset.dup())
}

fn (mut this Class_WC_Order_Item) offsetexists(var_offset rt.PhpVal) bool {
	this.maybe_read_meta_data()
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('item_meta_array'), var_offset)) || rt.is_true(rt.identical(rt.new_string('item_meta'), var_offset)))) || rt.is_true(rt.new_bool(this.data.array_isset(var_offset.dup()))))) {
		return true
	}
	return rt.is_true(rt.new_bool(rt.call_function('wp_list_pluck', [rt.get_property(rt.new_object('WC_Order_Item', ['WC_Data', 'ArrayAccess'], &this), 'meta_data'), rt.new_string('value'), rt.new_string('key')]).array_isset(var_offset.dup()))) || rt.is_true(rt.new_bool(rt.call_function('wp_list_pluck', [rt.get_property(rt.new_object('WC_Order_Item', ['WC_Data', 'ArrayAccess'], &this), 'meta_data'), rt.new_string('value'), rt.new_string('key')]).array_isset('_' + (var_offset).str())))
}

fn (mut this Class_WC_Order_Item) offsetget(var_offset rt.PhpVal) rt.PhpVal {
	this.maybe_read_meta_data()
	if rt.is_true(rt.identical(rt.new_string('item_meta_array'), var_offset)) {
		mut var_return := rt.new_array()
		{
			mut iter_1 := rt.get_property(rt.new_object('WC_Order_Item', ['WC_Data', 'ArrayAccess'], &this), 'meta_data').iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_meta := item_1.val
				var_return.array_set(rt.get_property(var_meta, 'id'), var_meta.dup())
			}
		}
		return var_return.dup()
	}
	mut var_meta_values := rt.call_function('wp_list_pluck', [rt.get_property(rt.new_object('WC_Order_Item', ['WC_Data', 'ArrayAccess'], &this), 'meta_data'), rt.new_string('value'), rt.new_string('key')])
	if rt.is_true(rt.identical(rt.new_string('item_meta'), var_offset)) {
		return var_meta_values.dup()
	} else if rt.is_true(rt.identical(rt.new_string('type'), var_offset)) {
		return rt.new_string(this.get_type())
	} else if rt.is_true(rt.new_bool(this.data.array_isset(var_offset.dup()))) {
		mut var_getter := rt.new_string(rt.new_string("get_${var_offset.to_string()}"))
		if rt.is_true(rt.call_function('is_callable', [rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Order_Item', ['WC_Data', 'ArrayAccess'], &this) }, rt.ArrayItem{ key: none, val: var_getter }])])) {
			return rt.call_method(rt.new_object('WC_Order_Item', ['WC_Data', 'ArrayAccess'], &this), var_getter, []rt.PhpVal{})
		}
	} else if rt.is_true(rt.new_bool(var_meta_values.dup().array_isset('_' + (var_offset).str()))) {
		return var_meta_values.array_get('_' + (var_offset).str())
	} else if rt.is_true(rt.new_bool(var_meta_values.dup().array_isset(var_offset.dup()))) {
		return var_meta_values.array_get(var_offset)
	}
	return rt.new_null()
}

fn (mut this Class_WC_Order_Item) has_cogs() bool {
	return false
}

fn (mut this Class_WC_Order_Item) calculate_cogs_value() bool {
	if rt.is_true(rt.new_bool(!(this.has_cogs()) || rt.is_true(rt.new_bool(!(rt.is_true(this.cogs_is_enabled(rt.new_string(@METHOD)))))))) {
		return false
	}
	mut var_value := rt.new_float(this.calculate_cogs_value_core())
	var_value = rt.call_function('apply_filters', [rt.new_string('woocommerce_calculated_order_item_cogs_value'), var_value.dup(), rt.new_object('WC_Order_Item', ['WC_Data', 'ArrayAccess'], &this)])
	if rt.is_true(rt.new_bool(var_value.dup().is_null())) {
		return false
	}
	this.set_cogs_value((// unsupported expression: Expr_Cast_Double).to_f64())
	return true
}

fn (mut this Class_WC_Order_Item) calculate_cogs_value_core() f64 {
	rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Method %1$s is not implemented. Classes overriding has_cogs must override this method too.'), rt.new_string('woocommerce')]), rt.new_string(@METHOD)]))))
	// unsupported statement: Stmt_Nop
	return f64(0.0)
}

fn (mut this Class_WC_Order_Item) get_cogs_value(context string) f64 {
	return (// unsupported expression: Expr_Cast_Double).to_f64()
}

fn (mut this Class_WC_Order_Item) set_cogs_value(value f64)  {
	mut value_mutated := value
	if rt.is_true(rt.new_bool(this.has_cogs() && rt.is_true(this.cogs_is_enabled(rt.new_string(@METHOD))))) {
		this.set_prop(rt.new_string('cogs_value'), rt.new_float(value_mutated))
	}
}

fn (mut this Class_WC_Order_Item) get_cogs_value_html() string {
	if rt.is_true(rt.new_bool(!(rt.is_true(this.cogs_is_enabled(rt.new_string(@METHOD)))))) {
		return ''
	}
	if !(this.has_cogs()) {
		return (rt.call_function('apply_filters', [rt.new_string('woocommerce_order_item_no_cogs_html'), rt.new_string('<span class=\'na\'>&ndash;</span>'), rt.new_object('WC_Order_Item', ['WC_Data', 'ArrayAccess'], &this)])).str()
	}
	mut var_cogs_value := rt.new_float(this.get_cogs_value(''))
	mut var_cogs_value_html := 
	return ().str()
}

fn (mut this Class_WC_Order_Item) get_cogs_value_per_unit_tooltip_text() string {
}

fn (mut this Class_WC_Order_Item) get_cogs_refund_value_html(refunded_cost f64, mut var_wc_price_arg Class_?array, mut var_order Class_?WC_Order) string {
	mut refunded_cost_mutated := refunded_cost
}

fn (mut this Class_WC_Order_Item) convert_legacy_tax_value_to_array(var_value rt.PhpVal, var_order rt.PhpVal) rt.PhpVal {
	mut var_value_mutated := var_value
}

struct Class_WC_Data {
	rt.PhpObjectBase
}

struct Class_WC_Data_Store {
	rt.PhpObjectBase
}

struct Class_WC_Tax {
	rt.PhpObjectBase
}

struct Class_Exception {
	rt.PhpObjectBase
pub mut:
		message string
		code i64
		file string
		line i64
}

fn (mut this Class_Exception) construct(var_message rt.PhpVal) {
	this.message = var_message.to_string()
}

fn (mut this Class_Exception) getmessage() string {
	return this.message
}

fn create_wc_order_item(item i64) &Class_WC_Order_Item {
	mut obj := &Class_WC_Order_Item{
		PhpObjectBase: rt.PhpObjectBase{}
		legacy_values: rt.new_null()
		legacy_cart_item_key: rt.new_null()
		data: rt.new_array()
		cache_group: rt.new_string('order-items')
		meta_type: rt.new_string('order_item')
		object_type: rt.new_string('order_item')
		legacy_package_key: rt.new_null()
	}
	obj.construct(item)
	return obj
}

fn create_wc_data() &Class_WC_Data {
	mut obj := &Class_WC_Data{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_data_store() &Class_WC_Data_Store {
	mut obj := &Class_WC_Data_Store{
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

fn create_exception(arg_0 rt.PhpVal) &Class_Exception {
	mut obj := &Class_Exception{
		PhpObjectBase: rt.PhpObjectBase{}
		message: ''
		code: i64(0)
		file: ''
		line: i64(0)
	}
	obj.construct(arg_0)
	return obj
}

fn (mut this Class_WC_Order_Item) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'apply_changes' {
			this.apply_changes()
			return rt.new_null()
		}
		'get_order_id' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_order_id(dispatch_arg_0)
		}
		'get_name' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_name(dispatch_arg_0)
		}
		'get_type' {
			return rt.new_string(this.get_type())
		}
		'get_quantity' {
			return rt.new_int(this.get_quantity())
		}
		'get_tax_status' {
			return this.get_tax_status()
		}
		'get_tax_class' {
			return rt.new_string(this.get_tax_class())
		}
		'get_order' {
			return this.get_order()
		}
		'set_order_id' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_order_id(dispatch_arg_0)
			return rt.new_null()
		}
		'set_name' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_name(dispatch_arg_0)
			return rt.new_null()
		}
		'is_type' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.is_type(dispatch_arg_0)
		}
		'calculate_taxes' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.calculate_taxes(dispatch_arg_0))
		}
		'get_all_formatted_meta_data' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			return this.get_all_formatted_meta_data(dispatch_arg_0, dispatch_arg_1)
		}
		'get_formatted_meta_data' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			return this.get_formatted_meta_data(dispatch_arg_0, dispatch_arg_1)
		}
		'offsetSet' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.offsetset(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'offsetUnset' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.offsetunset(dispatch_arg_0)
			return rt.new_null()
		}
		'offsetExists' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.offsetexists(dispatch_arg_0))
		}
		'offsetGet' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.offsetget(dispatch_arg_0)
		}
		'has_cogs' {
			return rt.new_bool(this.has_cogs())
		}
		'calculate_cogs_value' {
			return rt.new_bool(this.calculate_cogs_value())
		}
		'calculate_cogs_value_core' {
			return rt.new_float(this.calculate_cogs_value_core())
		}
		'get_cogs_value' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_float(this.get_cogs_value(dispatch_arg_0))
		}
		'set_cogs_value' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_f64()
			this.set_cogs_value(dispatch_arg_0)
			return rt.new_null()
		}
		'get_cogs_value_html' {
			return rt.new_string(this.get_cogs_value_html())
		}
		'get_cogs_value_per_unit_tooltip_text' {
			return rt.new_string(this.get_cogs_value_per_unit_tooltip_text())
		}
		'get_cogs_refund_value_html' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_f64()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_?array](if args.len > 1 { args[1] } else { rt.new_null() })
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_?WC_Order](if args.len > 2 { args[2] } else { rt.new_null() })
			return rt.new_string(this.get_cogs_refund_value_html(dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2))
		}
		'convert_legacy_tax_value_to_array' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.convert_legacy_tax_value_to_array(dispatch_arg_0, dispatch_arg_1)
		}
		else { return none }
	}
}

fn (this &Class_WC_Order_Item) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'legacy_values' { return this.legacy_values }
		'legacy_cart_item_key' { return this.legacy_cart_item_key }
		'data' { return this.data }
		'cache_group' { return this.cache_group }
		'meta_type' { return this.meta_type }
		'object_type' { return this.object_type }
		'legacy_package_key' { return this.legacy_package_key }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_Order_Item) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'legacy_values' { this.legacy_values = val; return true }
		'legacy_cart_item_key' { this.legacy_cart_item_key = val; return true }
		'data' { this.data = val; return true }
		'cache_group' { this.cache_group = val; return true }
		'meta_type' { this.meta_type = val; return true }
		'object_type' { this.object_type = val; return true }
		'legacy_package_key' { this.legacy_package_key = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_WC_Data) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Data) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Data) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_Data_Store) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Data_Store) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Data_Store) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_Exception) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'getMessage' {
			return rt.new_string(this.getmessage())
		}
		else { return none }
	}
}

fn (this &Class_Exception) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'message' { return rt.new_string(this.message) }
		'code' { return rt.new_int(this.code) }
		'file' { return rt.new_string(this.file) }
		'line' { return rt.new_int(this.line) }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Exception) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'message' { this.message = (val).str(); return true }
		'code' { this.code = (val).to_i64(); return true }
		'file' { this.file = (val).str(); return true }
		'line' { this.line = (val).to_i64(); return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn init_registry() {
}

fn init() {
	init_registry()
}



pub fn init_wp_content_plugins_woocommerce_includes_class_wc_order_item_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
