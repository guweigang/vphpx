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

fn (mut this Class_WC_Order_Item) construct(item i64) {
	if this.has_cogs() && rt.is_true(this.cogs_is_enabled()) {
		this.data.array_set('cogs_value', rt.new_null())
	}
	this.Class_WC_Data.construct(rt.new_int(item))
	if rt.is_true(rt.new_bool(rt.instance_of(rt.new_int(item), 'WC_Order_Item'))) {
		this.set_id(rt.call_method(rt.new_int(item), 'get_id', []rt.PhpVal{}))
	} else if rt.new_int(item).is_long() || rt.new_int(item).is_double() && item > 0 {
		this.set_id(rt.new_int(item))
	} else {
		this.set_object_read(rt.new_bool(true))
	}
	if rt.is_true(this.get_id()) && rt.is_true(rt.identical(rt.new_string(@STRUCT), rt.call_function('get_class', [rt.new_object('WC_Order_Item', ['WC_Data', 'ArrayAccess'], &this)]))) {
		rt.call_function('wc_doing_it_wrong', [rt.new_string(@METHOD), rt.new_string('WC_Order_Item should not be instantiated directly.'), rt.new_string('9.9.0')])
		return
	}
	mut var_type := rt.new_string((if rt.is_true(rt.identical(rt.new_string('line_item'), this.get_type())) { 'product' } else { this.get_type() }).str())
	mut iife_temp_0 := Class_WC_Data_Store{}
	mut iife_result_0 := iife_temp_0.load(rt.new_string('order-item-' + (var_type).str()))
	this.dispatch_set_prop('data_store', iife_result_0)
	if rt.is_true(rt.greater(this.get_id(), rt.new_int(0))) {
		rt.call_method(rt.get_property(rt.new_object('WC_Order_Item', ['WC_Data', 'ArrayAccess'], &this), 'data_store'), 'read', [rt.new_object('WC_Order_Item', ['WC_Data', 'ArrayAccess'], &this)])
	}
}

fn (mut this Class_WC_Order_Item) apply_changes() {
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

fn (mut this Class_WC_Order_Item) set_order_id(var_value rt.PhpVal) {
	mut var_value_mutated := var_value
	this.set_prop(rt.new_string('order_id'), rt.call_function('absint', [var_value_mutated.clone()]))
}

fn (mut this Class_WC_Order_Item) set_name(var_value rt.PhpVal) {
	mut var_value_mutated := var_value
	this.set_prop(rt.new_string('name'), rt.call_function('wp_check_invalid_utf8', [var_value_mutated.clone()]))
}

fn (mut this Class_WC_Order_Item) is_type(var_type rt.PhpVal) rt.PhpVal {
	mut var_type_mutated := var_type
	return if var_type_mutated.clone().is_array() { rt.call_function('in_array', [rt.new_string(this.get_type()), var_type_mutated.clone(), rt.new_bool(true)]) } else { rt.identical(var_type_mutated, this.get_type()) }
}

fn (mut this Class_WC_Order_Item) calculate_taxes(var_calculate_tax_for rt.PhpVal) bool {
	mut var_calculate_tax_for_mutated := var_calculate_tax_for
	if !(var_calculate_tax_for_mutated.array_isset(rt.new_string('country')) && var_calculate_tax_for_mutated.array_isset(rt.new_string('state')) && var_calculate_tax_for_mutated.array_isset(rt.new_string('postcode')) && var_calculate_tax_for_mutated.array_isset(rt.new_string('city'))) {
		return false
	}
	if rt.is_true(rt.new_bool('0' != this.get_tax_class())) && rt.is_true(rt.identical(Class_Automattic_WooCommerce_Enums_ProductTaxStatus.taxable(), this.get_tax_status())) && rt.is_true(rt.call_function('wc_tax_enabled', []rt.PhpVal{})) {
		var_calculate_tax_for_mutated.array_set('tax_class', this.get_tax_class())
		mut iife_temp_1 := Class_WC_Tax{}
		mut iife_result_1 := iife_temp_1.find_rates(var_calculate_tax_for_mutated.clone())
		mut var_tax_rates := iife_result_1
		mut iife_temp_2 := Class_WC_Tax{}
		mut iife_result_2 := iife_temp_2.calc_tax(this.get_total(), var_tax_rates.clone(), rt.new_bool(false))
		mut var_taxes := iife_result_2
		if rt.is_true(rt.call_function('method_exists', [rt.new_object('WC_Order_Item', ['WC_Data', 'ArrayAccess'], &this), rt.new_string('get_subtotal')])) {
			mut iife_temp_3 := Class_WC_Tax{}
			mut iife_result_3 := iife_temp_3.calc_tax(this.get_subtotal(), var_tax_rates.clone(), rt.new_bool(false))
			mut var_subtotal_taxes := iife_result_3
			this.set_taxes(rt.create_array([rt.ArrayItem{ key: 'total', val: var_taxes }, rt.ArrayItem{ key: 'subtotal', val: var_subtotal_taxes }]))
		} else {
			this.set_taxes(rt.create_array([rt.ArrayItem{ key: 'total', val: var_taxes }]))
		}
	} else {
		this.set_taxes(rt.new_bool(false))
	}
	rt.call_function('do_action', [rt.new_string('woocommerce_order_item_after_calculate_taxes'), rt.new_object('WC_Order_Item', ['WC_Data', 'ArrayAccess'], &this), var_calculate_tax_for_mutated.clone()])
	return true
}

fn (mut this Class_WC_Order_Item) get_all_formatted_meta_data(hideprefix string, include_all bool) rt.PhpVal {
	return this.get_formatted_meta_data(hideprefix, include_all)
}

fn (mut this Class_WC_Order_Item) get_formatted_meta_data(hideprefix string, include_all bool) rt.PhpVal {
	mut var_formatted_meta := rt.new_array()
	mut var_meta_data := this.get_meta_data()
	mut var_hideprefix_length := rt.new_int(if !(hideprefix == '') { hideprefix.len } else { 0 })
	mut var_product := if rt.call_function('is_callable', [rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Order_Item', ['WC_Data', 'ArrayAccess'], &this) }, rt.ArrayItem{ key: none, val: 'get_product' }])]) { this.get_product() } else { rt.new_bool(false) }
	mut var_order_item_name := this.get_name('')
	mut iter_1 := var_meta_data.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_meta := item_1.val
		if !rt.is_true(rt.get_property(var_meta, 'id')) || rt.is_true(rt.identical(rt.new_string(''), rt.get_property(var_meta, 'value'))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_scalar', [rt.get_property(var_meta, 'value')]))))) || (rt.is_true(var_hideprefix_length) && rt.is_true(rt.identical(rt.call_function('substr', [rt.get_property(var_meta, 'key'), rt.new_int(0), var_hideprefix_length.clone()]), rt.new_string(hideprefix)))) {
			continue
		}
		rt.set_property(var_meta, 'key', rt.call_function('rawurldecode', [rt.new_string((rt.get_property(var_meta, 'key')).str())]))
		rt.set_property(var_meta, 'value', rt.call_function('rawurldecode', [rt.new_string((rt.get_property(var_meta, 'value')).str())]))
		mut var_attribute_key := rt.call_function('str_replace', [rt.new_string('attribute_'), rt.new_string(''), rt.get_property(var_meta, 'key')])
		mut var_display_key := rt.call_function('wc_attribute_label', [var_attribute_key.clone(), var_product.clone()])
		mut var_display_value := rt.call_function('wp_kses_post', [rt.get_property(var_meta, 'value')])
		if rt.is_true(rt.call_function('taxonomy_exists', [var_attribute_key.clone()])) {
			mut var_term := rt.call_function('get_term_by', [rt.new_string('slug'), rt.get_property(var_meta, 'value'), var_attribute_key.clone()])
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [var_term.clone()]))))) && var_term.clone().is_object() && rt.is_true(rt.get_property(var_term, 'name')) {
			var_display_value = rt.get_property(var_term, 'name')
			}
		}
		if !(var_include_all) && rt.is_true(var_product) && rt.is_true(rt.call_method(var_product, 'is_type', [Class_Automattic_WooCommerce_Enums_ProductType.variation()])) && rt.is_true(rt.call_function('wc_is_attribute_in_product_name', [var_display_value.clone(), var_order_item_name.clone()])) {
			continue
		}
		var_formatted_meta.array_set(rt.get_property(var_meta, 'id'), rt.array_to_object(rt.create_array([rt.ArrayItem{ key: 'key', val: rt.get_property(var_meta, 'key') }, rt.ArrayItem{ key: 'value', val: rt.get_property(var_meta, 'value') }, rt.ArrayItem{ key: 'display_key', val: rt.call_function('apply_filters', [rt.new_string('woocommerce_order_item_display_meta_key'), var_display_key.clone(), var_meta.clone(), rt.new_object('WC_Order_Item', ['WC_Data', 'ArrayAccess'], &this)]) }, rt.ArrayItem{ key: 'display_value', val: rt.call_function('wpautop', [rt.call_function('make_clickable', [rt.call_function('apply_filters', [rt.new_string('woocommerce_order_item_display_meta_value'), var_display_value.clone(), var_meta.clone(), rt.new_object('WC_Order_Item', ['WC_Data', 'ArrayAccess'], &this)])])]) }])))
	}
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_order_item_get_formatted_meta_data'), var_formatted_meta.clone(), rt.new_object('WC_Order_Item', ['WC_Data', 'ArrayAccess'], &this)])
}

fn (mut this Class_WC_Order_Item) offsetset(var_offset rt.PhpVal, var_value rt.PhpVal) {
	mut var_value_mutated := var_value
	if rt.is_true(rt.identical(rt.new_string('item_meta_array'), var_offset)) {
		mut iter_2 := var_value_mutated.iterator()
		for {
			item_2 := iter_2.next() or { break }
			mut var_meta := item_2.val
			mut var_meta_id := item_2.key
			this.update_meta_data(rt.get_property(var_meta, 'key'), rt.get_property(var_meta, 'value'), var_meta_id.clone())
		}
		return
	}
	if rt.is_true(rt.new_bool(this.data.array_isset(var_offset.clone()))) {
		mut var_setter := rt.new_string("set_${var_offset.to_string()}")
		if rt.is_true(rt.call_function('is_callable', [rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Order_Item', ['WC_Data', 'ArrayAccess'], &this) }, rt.ArrayItem{ key: none, val: var_setter }])])) {
			rt.call_method(rt.new_object('WC_Order_Item', ['WC_Data', 'ArrayAccess'], &this), var_setter, [var_value_mutated.clone()])
		}
		return
	}
	this.update_meta_data(var_offset.clone(), var_value_mutated.clone())
}

fn (mut this Class_WC_Order_Item) offsetunset(var_offset rt.PhpVal) {
	this.maybe_read_meta_data()
	if rt.is_true(rt.identical(rt.new_string('item_meta_array'), var_offset)) || rt.is_true(rt.identical(rt.new_string('item_meta'), var_offset)) {
		this.dispatch_set_prop('meta_data', rt.new_array())
		return
	}
	if rt.is_true(rt.new_bool(this.data.array_isset(var_offset.clone()))) {
		this.data.array_unset(var_offset)
	}
	if rt.is_true(rt.new_bool(rt.get_property(rt.new_object('WC_Order_Item', ['WC_Data', 'ArrayAccess'], &this), 'changes').array_isset(var_offset.clone()))) {
		rt.get_property(rt.new_object('WC_Order_Item', ['WC_Data', 'ArrayAccess'], &this), 'changes').array_unset(var_offset)
	}
	this.delete_meta_data(var_offset.clone())
}

fn (mut this Class_WC_Order_Item) offsetexists(var_offset rt.PhpVal) bool {
	this.maybe_read_meta_data()
	if rt.is_true(rt.identical(rt.new_string('item_meta_array'), var_offset)) || rt.is_true(rt.identical(rt.new_string('item_meta'), var_offset)) || rt.is_true(rt.new_bool(this.data.array_isset(var_offset.clone()))) {
		return true
	}
	return rt.is_true(rt.new_bool(rt.call_function('wp_list_pluck', [rt.get_property(rt.new_object('WC_Order_Item', ['WC_Data', 'ArrayAccess'], &this), 'meta_data'), rt.new_string('value'), rt.new_string('key')]).array_isset(var_offset.clone()))) || rt.is_true(rt.new_bool(rt.call_function('wp_list_pluck', [rt.get_property(rt.new_object('WC_Order_Item', ['WC_Data', 'ArrayAccess'], &this), 'meta_data'), rt.new_string('value'), rt.new_string('key')]).array_isset(rt.new_string('_' + (var_offset).str()))))
}

fn (mut this Class_WC_Order_Item) offsetget(var_offset rt.PhpVal) rt.PhpVal {
	this.maybe_read_meta_data()
	if rt.is_true(rt.identical(rt.new_string('item_meta_array'), var_offset)) {
		mut var_return := rt.new_array()
		mut iter_3 := rt.get_property(rt.new_object('WC_Order_Item', ['WC_Data', 'ArrayAccess'], &this), 'meta_data').iterator()
		for {
			item_3 := iter_3.next() or { break }
			mut var_meta := item_3.val
			var_return.array_set(rt.get_property(var_meta, 'id'), var_meta.clone())
		}
		return var_return.clone()
	}
	mut var_meta_values := rt.call_function('wp_list_pluck', [rt.get_property(rt.new_object('WC_Order_Item', ['WC_Data', 'ArrayAccess'], &this), 'meta_data'), rt.new_string('value'), rt.new_string('key')])
	if rt.is_true(rt.identical(rt.new_string('item_meta'), var_offset)) {
		return var_meta_values.clone()
	} else if rt.is_true(rt.identical(rt.new_string('type'), var_offset)) {
		return rt.new_string(this.get_type())
	} else if rt.is_true(rt.new_bool(this.data.array_isset(var_offset.clone()))) {
		mut var_getter := rt.new_string("get_${var_offset.to_string()}")
		if rt.is_true(rt.call_function('is_callable', [rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Order_Item', ['WC_Data', 'ArrayAccess'], &this) }, rt.ArrayItem{ key: none, val: var_getter }])])) {
			return rt.call_method(rt.new_object('WC_Order_Item', ['WC_Data', 'ArrayAccess'], &this), var_getter, []rt.PhpVal{})
		}
	} else if rt.is_true(rt.new_bool(var_meta_values.clone().array_isset(rt.new_string('_' + (var_offset).str())))) {
		return var_meta_values.array_get(rt.new_string('_' + (var_offset).str()))
	} else if rt.is_true(rt.new_bool(var_meta_values.clone().array_isset(var_offset.clone()))) {
		return var_meta_values.array_get(var_offset)
	}
	return rt.new_null()
}

fn (mut this Class_WC_Order_Item) has_cogs() bool {
	return false
}

fn (mut this Class_WC_Order_Item) calculate_cogs_value() bool {
	if !(this.has_cogs()) || rt.is_true(rt.new_bool(!(rt.is_true(this.cogs_is_enabled(rt.new_string(@METHOD)))))) {
		return false
	}
	mut var_value := rt.new_float(this.calculate_cogs_value_core())
	var_value = rt.call_function('apply_filters', [rt.new_string('woocommerce_calculated_order_item_cogs_value'), var_value.clone(), rt.new_object('WC_Order_Item', ['WC_Data', 'ArrayAccess'], &this)])
	if rt.is_true(rt.new_bool(var_value.clone().is_null())) {
		return false
	}
	this.set_cogs_value(rt.new_float((var_value).to_f64()))
	return true
}

fn (mut this Class_WC_Order_Item) calculate_cogs_value_core() f64 {
	rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Method %1$s is not implemented. Classes overriding has_cogs must override this method too.'), rt.new_string('woocommerce')]), rt.new_string(@METHOD)]))))
	return f64(0.0)
}

fn (mut this Class_WC_Order_Item) get_cogs_value(context string) f64 {
	return rt.new_float((if this.has_cogs() && rt.is_true(this.cogs_is_enabled(rt.new_string(@METHOD))) { this.get_prop(rt.new_string('cogs_value'), rt.new_string(context)) } else { rt.new_int(0) }).to_f64())
}

fn (mut this Class_WC_Order_Item) set_cogs_value(value f64) {
	mut value_mutated := value
	if this.has_cogs() && rt.is_true(this.cogs_is_enabled(rt.new_string(@METHOD))) {
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
	mut var_cogs_value_html := rt.call_function('wc_price', [var_cogs_value.clone(), rt.create_array([rt.ArrayItem{ key: 'currency', val: rt.call_method(this.get_order(), 'get_currency', []rt.PhpVal{}) }])])
	return (rt.call_function('apply_filters', [rt.new_string('woocommerce_order_item_cogs_html'), var_cogs_value_html.clone(), var_cogs_value.clone(), rt.new_object('WC_Order_Item', ['WC_Data', 'ArrayAccess'], &this)])).str()
}

fn (mut this Class_WC_Order_Item) get_cogs_value_per_unit_tooltip_text() string {
	if rt.is_true(rt.new_bool(!(rt.is_true(this.cogs_is_enabled(rt.new_string(@METHOD)))))) || !(this.has_cogs()) {
		return ''
	}
	mut var_tooltip_text := rt.new_string('')
	mut var_quantity := rt.new_int(this.get_quantity())
	mut var_cogs_value := rt.new_float(this.get_cogs_value(''))
	mut var_cost_per_item := rt.new_int(0)
	mut var_formatted_cost_per_item := rt.new_string('')
	if rt.is_true(rt.greater(var_quantity, rt.new_int(0))) && rt.is_true(rt.greater(var_cogs_value, rt.new_int(0))) {
	var_cost_per_item = rt.div(var_cogs_value, var_quantity)
	var_formatted_cost_per_item = rt.call_function('wc_price', [var_cost_per_item.clone(), rt.create_array([rt.ArrayItem{ key: 'currency', val: rt.call_method(this.get_order(), 'get_currency', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'in_span', val: false }])])
	var_tooltip_text = rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Cost per unit: %s'), rt.new_string('woocommerce')]), var_formatted_cost_per_item.clone()])
	}
	return (rt.call_function('apply_filters', [rt.new_string('woocommerce_order_item_cogs_per_item_tooltip'), var_tooltip_text.clone(), var_cost_per_item.clone(), var_formatted_cost_per_item.clone(), rt.new_object('WC_Order_Item', ['WC_Data', 'ArrayAccess'], &this)])).str()
}

fn (mut this Class_WC_Order_Item) get_cogs_refund_value_html(refunded_cost f64, mut var_wc_price_arg Class_?array, mut var_order Class_?WC_Order) string {
	mut refunded_cost_mutated := refunded_cost
	if rt.is_true(rt.new_bool(!(rt.is_true(this.cogs_is_enabled(rt.new_string(@METHOD)))))) || !(this.has_cogs()) {
		return ''
	}
	if refunded_cost_mutated > 0 {
	refunded_cost_mutated = -refunded_cost_mutated
	}
	rt.new_null()
	mut var_html := rt.new_string((if rt.is_true(rt.new_float(refunded_cost_mutated)) { '<small class="refunded">' + (rt.call_function('wc_price', [rt.new_float(refunded_cost_mutated).clone(), if !(var_wc_price_arg).is_null() { var_wc_price_arg } else { rt.create_array([rt.ArrayItem{ key: 'currency', val: var_order.get_currency() }]) }])).str() + '</small>' } else { '' }).str())
	return (rt.call_function('apply_filters', [rt.new_string('woocommerce_order_item_cogs_refunded_html'), var_html.clone(), rt.new_float(refunded_cost_mutated).clone(), rt.new_object('WC_Order_Item', ['WC_Data', 'ArrayAccess'], &this), var_order])).str()
}

fn (mut this Class_WC_Order_Item) convert_legacy_tax_value_to_array(var_value rt.PhpVal, var_order rt.PhpVal) rt.PhpVal {
	mut var_value_mutated := var_value
	mut var_rate_id := rt.new_int(0)
	mut var_tax_items := if rt.is_true(var_order) { rt.call_method(var_order, 'get_taxes', []rt.PhpVal{}) } else { rt.new_array() }
	if !(!rt.is_true(var_tax_items)) {
		mut var_first_tax_item := rt.call_function('reset', [var_tax_items.clone()])
		if rt.is_true(var_first_tax_item) {
		var_rate_id = rt.call_method(var_first_tax_item, 'get_rate_id', []rt.PhpVal{})
		}
	}
	mut var_converted := rt.create_array([rt.ArrayItem{ key: var_rate_id, val: var_value_mutated }])
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_order_item_legacy_tax_conversion'), var_converted.clone(), var_value_mutated.clone(), rt.new_object('WC_Order_Item', ['WC_Data', 'ArrayAccess'], &this)])
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

fn create_wc_data(_args ...rt.PhpVal) &Class_WC_Data {
	mut obj := &Class_WC_Data{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_data_store(_args ...rt.PhpVal) &Class_WC_Data_Store {
	mut obj := &Class_WC_Data_Store{
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


fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(exit(0)))
}
