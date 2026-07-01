import rt

struct Class_WC_Product_Variation {
	rt.PhpObjectBase
pub mut:
		post_type rt.PhpVal = rt.new_string('product_variation')
		parent_data rt.PhpVal = rt.new_array()
}

fn (mut this Class_WC_Product_Variation) construct(product i64)  {
	rt.get_property(rt.new_object('WC_Product_Variation', ['WC_Product_Simple'], &this), 'data').array_set('tax_class', 'parent')
	rt.get_property(rt.new_object('WC_Product_Variation', ['WC_Product_Simple'], &this), 'data').array_set('attribute_summary', '')
	rt.get_property(rt.new_object('WC_Product_Variation', ['WC_Product_Simple'], &this), 'data').array_set('cogs_value_is_additive', false)
	this.Class_WC_Product_Simple.construct(rt.new_int(product))
}

fn (mut this Class_WC_Product_Variation) get_hook_prefix() string {
	return 'woocommerce_product_variation_get_'
}

fn (mut this Class_WC_Product_Variation) get_type() rt.PhpVal {
	return Class_Automattic_WooCommerce_Enums_ProductType.variation()
}

fn (mut this Class_WC_Product_Variation) get_stock_managed_by_id() rt.PhpVal {
	return if rt.is_true(rt.identical(rt.new_string('parent'), this.get_manage_stock(''))) { this.get_parent_id() } else { this.get_id() }
}

fn (mut this Class_WC_Product_Variation) get_title() rt.PhpVal {
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_product_title'), this.parent_data.array_get('title'), rt.new_object('WC_Product_Variation', ['WC_Product_Simple'], &this)])
}

fn (mut this Class_WC_Product_Variation) get_formatted_name() string {
	if rt.is_true(this.get_sku('')) {
		mut var_identifier := this.get_sku('')
	} else {
		var_identifier = rt.new_string('#' + (this.get_id()).str())
	}
	mut var_formatted_variation_list := rt.call_function('wc_get_formatted_variation', [rt.new_object('WC_Product_Variation', ['WC_Product_Simple'], &this), rt.new_bool(true), rt.new_bool(true), rt.new_bool(true)])
	return (rt.call_function('sprintf', [rt.new_string('%2$s (%1$s)'), var_identifier.dup(), this.get_name()])).str() + '<span class="description">' + (var_formatted_variation_list).str() + '</span>'
}

fn (mut this Class_WC_Product_Variation) get_variation_attributes(with_prefix bool) rt.PhpVal {
	mut var_attributes := this.get_attributes()
	mut var_variation_attributes := map[string]rt.PhpVal{}
	mut var_prefix := rt.new_string(if var_with_prefix { rt.new_string('attribute_') } else { rt.new_string('') })
	{
		mut iter_1 := var_attributes.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_value := item_1.val
			mut var_key := item_1.key
			var_variation_attributes[(var_prefix).str() + (var_key).str()] = var_value.dup()
		}
	}
	return var_variation_attributes.dup()
}

fn (mut this Class_WC_Product_Variation) get_attribute(var_attribute rt.PhpVal) string {
	mut var_attribute_mutated := var_attribute
	mut var_attributes := this.get_attributes()
	var_attribute_mutated = rt.call_function('sanitize_title', [var_attribute_mutated.dup()])
	if var_attributes.array_isset(var_attribute_mutated) {
		mut var_value := var_attributes.array_get(var_attribute_mutated)
		mut var_term := if rt.is_true(rt.call_function('taxonomy_exists', [var_attribute_mutated.dup()])) { rt.call_function('get_term_by', [rt.new_string('slug'), var_value.dup(), var_attribute_mutated.dup()]) } else { rt.new_bool(false) }
		return (if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [var_term.dup()]))))) && rt.is_true(var_term))) { rt.get_property(var_term, 'name') } else { var_value }).str()
	}
	mut var_att_str := rt.new_string('pa_' + (var_attribute_mutated).str())
	if var_attributes.array_isset(var_att_str) {
		var_value = var_attributes.array_get(var_att_str)
		var_term = if rt.is_true(rt.call_function('taxonomy_exists', [var_att_str.dup()])) { rt.call_function('get_term_by', [rt.new_string('slug'), var_value.dup(), var_att_str.dup()]) } else { rt.new_bool(false) }
		return (if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [var_term.dup()]))))) && rt.is_true(var_term))) { rt.get_property(var_term, 'name') } else { var_value }).str()
	}
	return ''
}

fn (mut this Class_WC_Product_Variation) get_permalink(var_item_object rt.PhpVal) rt.PhpVal {
	mut var_url := rt.call_function('get_permalink', [this.get_parent_id()])
	if !(!rt.is_true(var_item_object.array_get('item_meta_array'))) {
		mut var_data_keys := rt.call_function('array_map', [rt.new_string('wc_variation_attribute_name'), rt.call_function('wp_list_pluck', [var_item_object.array_get('item_meta_array'), rt.new_string('key')])])
		mut var_data_values := rt.call_function('wp_list_pluck', [var_item_object.array_get('item_meta_array'), rt.new_string('value')])
		mut var_data := rt.call_function('array_intersect_key', [rt.call_function('array_combine', [var_data_keys.dup(), var_data_values.dup()]), this.get_variation_attributes(false)])
	} else if !(!rt.is_true(var_item_object.array_get('variation'))) {
		var_data = var_item_object.array_get('variation')
	} else {
		var_data = this.get_variation_attributes(false)
	}
	var_data = rt.call_function('array_filter', [var_data.dup(), rt.new_string('wc_array_filter_default_attributes')])
	if !rt.is_true(var_data) {
		return var_url.dup()
	}
	var_data = rt.call_function('array_map', [rt.new_string('urlencode'), var_data.dup()])
	mut var_keys := rt.call_function('array_map', [rt.new_string('urlencode'), rt.func_array_keys(var_data.dup())])
	return rt.call_function('add_query_arg', [rt.call_function('array_combine', [var_keys.dup(), var_data.dup()]), var_url.dup()])
}

fn (mut this Class_WC_Product_Variation) add_to_cart_url() rt.PhpVal {
	mut var_url := if rt.is_true(this.is_purchasable()) { rt.call_function('remove_query_arg', [rt.new_string('added-to-cart'), rt.call_function('add_query_arg', [rt.create_array([rt.ArrayItem{ key: 'variation_id', val: this.get_id() }, rt.ArrayItem{ key: 'add-to-cart', val: this.get_parent_id() }]), this.get_permalink(rt.new_null())])]) } else { this.get_permalink(rt.new_null()) }
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_product_add_to_cart_url'), var_url.dup(), rt.new_object('WC_Product_Variation', ['WC_Product_Simple'], &this)])
}

fn (mut this Class_WC_Product_Variation) get_sku(context string) rt.PhpVal {
	mut var_value := this.get_prop(rt.new_string('sku'), rt.new_string(context))
	if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('view'), rt.new_string(context))) && !rt.is_true(var_value))) {
		var_value = rt.call_function('apply_filters', [this.get_hook_prefix() + 'sku', this.parent_data.array_get('sku'), rt.new_object('WC_Product_Variation', ['WC_Product_Simple'], &this)])
	}
	return var_value.dup()
}

fn (mut this Class_WC_Product_Variation) get_weight(context string) rt.PhpVal {
	mut var_value := this.get_prop(rt.new_string('weight'), rt.new_string(context))
	if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('view'), rt.new_string(context))) && !rt.is_true(var_value))) {
		var_value = rt.call_function('apply_filters', [this.get_hook_prefix() + 'weight', this.parent_data.array_get('weight'), rt.new_object('WC_Product_Variation', ['WC_Product_Simple'], &this)])
	}
	return var_value.dup()
}

fn (mut this Class_WC_Product_Variation) get_length(context string) rt.PhpVal {
	mut var_value := this.get_prop(rt.new_string('length'), rt.new_string(context))
	if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('view'), rt.new_string(context))) && !rt.is_true(var_value))) {
		var_value = rt.call_function('apply_filters', [this.get_hook_prefix() + 'length', this.parent_data.array_get('length'), rt.new_object('WC_Product_Variation', ['WC_Product_Simple'], &this)])
	}
	return var_value.dup()
}

fn (mut this Class_WC_Product_Variation) get_width(context string) rt.PhpVal {
	mut var_value := this.get_prop(rt.new_string('width'), rt.new_string(context))
	if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('view'), rt.new_string(context))) && !rt.is_true(var_value))) {
		var_value = rt.call_function('apply_filters', [this.get_hook_prefix() + 'width', this.parent_data.array_get('width'), rt.new_object('WC_Product_Variation', ['WC_Product_Simple'], &this)])
	}
	return var_value.dup()
}

fn (mut this Class_WC_Product_Variation) get_height(context string) rt.PhpVal {
	mut var_value := this.get_prop(rt.new_string('height'), rt.new_string(context))
	if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('view'), rt.new_string(context))) && !rt.is_true(var_value))) {
		var_value = rt.call_function('apply_filters', [this.get_hook_prefix() + 'height', this.parent_data.array_get('height'), rt.new_object('WC_Product_Variation', ['WC_Product_Simple'], &this)])
	}
	return var_value.dup()
}

fn (mut this Class_WC_Product_Variation) get_tax_class(context string) rt.PhpVal {
	mut var_value := rt.new_null()
	if rt.is_true(rt.new_bool(rt.get_property(rt.new_object('WC_Product_Variation', ['WC_Product_Simple'], &this), 'data').array_isset(rt.new_string('tax_class')))) {
		var_value = if rt.is_true(rt.new_bool(rt.get_property(rt.new_object('WC_Product_Variation', ['WC_Product_Simple'], &this), 'changes').array_isset(rt.new_string('tax_class')))) { rt.get_property(rt.new_object('WC_Product_Variation', ['WC_Product_Simple'], &this), 'changes').array_get('tax_class') } else { rt.get_property(rt.new_object('WC_Product_Variation', ['WC_Product_Simple'], &this), 'data').array_get('tax_class') }
		if rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) && rt.is_true(rt.identical(rt.new_string('parent'), var_value)))) {
			var_value = this.parent_data.array_get('tax_class')
		}
		if rt.is_true(rt.identical(rt.new_string('view'), rt.new_string(context))) {
			var_value = rt.call_function('apply_filters', [this.get_hook_prefix() + 'tax_class', var_value.dup(), rt.new_object('WC_Product_Variation', ['WC_Product_Simple'], &this)])
		}
	}
	return var_value.dup()
}

fn (mut this Class_WC_Product_Variation) get_manage_stock(context string) rt.PhpVal {
	mut var_value := this.get_prop(rt.new_string('manage_stock'), rt.new_string(context))
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('view'), rt.new_string(context))) && rt.is_true(rt.identical(rt.new_bool(false), var_value)))) && rt.is_true(rt.identical(rt.new_bool(true), rt.call_function('wc_string_to_bool', [this.parent_data.array_get('manage_stock')]))))) {
		var_value = rt.new_string(rt.new_string('parent'))
	}
	return var_value.dup()
}

fn (mut this Class_WC_Product_Variation) get_stock_quantity(context string) rt.PhpVal {
	mut var_value := this.get_prop(rt.new_string('stock_quantity'), rt.new_string(context))
	if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('view'), rt.new_string(context))) && rt.is_true(rt.identical(rt.new_string('parent'), this.get_manage_stock(''))))) {
		var_value = rt.call_function('apply_filters', [this.get_hook_prefix() + 'stock_quantity', this.parent_data.array_get('stock_quantity'), rt.new_object('WC_Product_Variation', ['WC_Product_Simple'], &this)])
	}
	return var_value.dup()
}

fn (mut this Class_WC_Product_Variation) get_backorders(context string) rt.PhpVal {
	mut var_value := this.get_prop(rt.new_string('backorders'), rt.new_string(context))
	if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('view'), rt.new_string(context))) && rt.is_true(rt.identical(rt.new_string('parent'), this.get_manage_stock(''))))) {
		var_value = rt.call_function('apply_filters', [this.get_hook_prefix() + 'backorders', this.parent_data.array_get('backorders'), rt.new_object('WC_Product_Variation', ['WC_Product_Simple'], &this)])
	}
	return var_value.dup()
}

fn (mut this Class_WC_Product_Variation) get_image_id(context string) rt.PhpVal {
	mut var_image_id := this.get_prop(rt.new_string('image_id'), rt.new_string(context))
	if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('view'), rt.new_string(context))) && rt.is_true(rt.new_bool(!(rt.is_true(var_image_id)))))) {
		var_image_id = rt.call_function('apply_filters', [this.get_hook_prefix() + 'image_id', this.parent_data.array_get('image_id'), rt.new_object('WC_Product_Variation', ['WC_Product_Simple'], &this)])
	}
	return var_image_id.dup()
}

fn (mut this Class_WC_Product_Variation) get_purchase_note(context string) rt.PhpVal {
	mut var_value := this.get_prop(rt.new_string('purchase_note'), rt.new_string(context))
	if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('view'), rt.new_string(context))) && !rt.is_true(var_value))) {
		var_value = rt.call_function('apply_filters', [this.get_hook_prefix() + 'purchase_note', this.parent_data.array_get('purchase_note'), rt.new_object('WC_Product_Variation', ['WC_Product_Simple'], &this)])
	}
	return var_value.dup()
}

fn (mut this Class_WC_Product_Variation) get_shipping_class_id(context string) rt.PhpVal {
	mut var_shipping_class_id := this.get_prop(rt.new_string('shipping_class_id'), rt.new_string(context))
	if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('view'), rt.new_string(context))) && rt.is_true(rt.new_bool(!(rt.is_true(var_shipping_class_id)))))) {
		var_shipping_class_id = rt.call_function('apply_filters', [this.get_hook_prefix() + 'shipping_class_id', this.parent_data.array_get('shipping_class_id'), rt.new_object('WC_Product_Variation', ['WC_Product_Simple'], &this)])
	}
	return var_shipping_class_id.dup()
}

fn (mut this Class_WC_Product_Variation) get_catalog_visibility(context string) rt.PhpVal {
	return rt.call_function('apply_filters', [this.get_hook_prefix() + 'catalog_visibility', this.parent_data.array_get('catalog_visibility'), rt.new_object('WC_Product_Variation', ['WC_Product_Simple'], &this)])
}

fn (mut this Class_WC_Product_Variation) get_attribute_summary(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('attribute_summary'), rt.new_string(context))
}

fn (mut this Class_WC_Product_Variation) set_attribute_summary(var_attribute_summary rt.PhpVal)  {
	this.set_prop(rt.new_string('attribute_summary'), var_attribute_summary.dup())
}

fn (mut this Class_WC_Product_Variation) set_parent_data(var_parent_data rt.PhpVal)  {
	mut var_parent_data_mutated := var_parent_data
	var_parent_data_mutated = rt.call_function('wp_parse_args', [var_parent_data_mutated.dup(), rt.create_array([rt.ArrayItem{ key: 'title', val: '' }, rt.ArrayItem{ key: 'status', val: '' }, rt.ArrayItem{ key: 'sku', val: '' }, rt.ArrayItem{ key: 'manage_stock', val: 'no' }, rt.ArrayItem{ key: 'backorders', val: 'no' }, rt.ArrayItem{ key: 'stock_quantity', val: '' }, rt.ArrayItem{ key: 'weight', val: '' }, rt.ArrayItem{ key: 'length', val: '' }, rt.ArrayItem{ key: 'width', val: '' }, rt.ArrayItem{ key: 'height', val: '' }, rt.ArrayItem{ key: 'tax_class', val: '' }, rt.ArrayItem{ key: 'shipping_class_id', val: 0 }, rt.ArrayItem{ key: 'image_id', val: 0 }, rt.ArrayItem{ key: 'purchase_note', val: '' }, rt.ArrayItem{ key: 'catalog_visibility', val: Class_Automattic_WooCommerce_Enums_CatalogVisibility.visible() }])])
	var_parent_data_mutated.array_set('tax_class', rt.call_function('sanitize_title', [var_parent_data_mutated.array_get('tax_class')]))
	var_parent_data_mutated.array_set('tax_class', if rt.is_true(rt.identical(rt.new_string('standard'), var_parent_data_mutated.array_get('tax_class'))) { rt.new_string('') } else { var_parent_data_mutated.array_get('tax_class') })
	mut var_valid_classes := this.get_valid_tax_classes()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_parent_data_mutated.array_get('tax_class'), var_valid_classes.dup(), rt.new_bool(true)]))))) {
		var_parent_data_mutated.array_set('tax_class', '')
	}
	this.parent_data = var_parent_data_mutated.dup()
}

fn (mut this Class_WC_Product_Variation) get_parent_data() rt.PhpVal {
	return this.parent_data
}

fn (mut this Class_WC_Product_Variation) set_attributes(var_raw_attributes rt.PhpVal)  {
	mut var_raw_attributes_mutated := var_raw_attributes
	var_raw_attributes_mutated = rt.cast_array(var_raw_attributes_mutated)
	mut var_attributes := map[string]rt.PhpVal{}
	{
		mut iter_1 := var_raw_attributes_mutated.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_value := item_1.val
			mut var_key := item_1.key
			if rt.is_true(rt.identical(rt.new_int(0), rt.call_function('strpos', [.dup(), ]))) {
				var_key = 
			}
			.array_set(, .dup())
		}
	}
	
}

fn (mut this Class_WC_Product_Variation) has_attributes() bool {
}

fn (mut this Class_WC_Product_Variation) is_purchasable() rt.PhpVal {
}

fn (mut this Class_WC_Product_Variation) variation_is_active() rt.PhpVal {
}

fn (mut this Class_WC_Product_Variation) variation_is_visible() rt.PhpVal {
}

fn (mut this Class_WC_Product_Variation) get_valid_tax_classes() rt.PhpVal {
}

fn (mut this Class_WC_Product_Variation) get_cogs_value_is_additive() bool {
}

fn (mut this Class_WC_Product_Variation) set_cogs_value_is_additive(value bool)  {
	mut value_mutated := value
}

fn (mut this Class_WC_Product_Variation) adjust_cogs_value_before_set(mut var_value Class_?float) f64 {
	mut var_value_mutated := var_value
}

fn (mut this Class_WC_Product_Variation) get_cogs_total_value_core() f64 {
	return f64(0.0)
}

fn (mut this Class_WC_Product_Variation) get_parent_cogs_effective_value() f64 {
}

struct Class_WC_Product_Simple {
	rt.PhpObjectBase
}

fn create_wc_product_variation(product i64) &Class_WC_Product_Variation {
	mut obj := &Class_WC_Product_Variation{
		PhpObjectBase: rt.PhpObjectBase{}
		post_type: rt.new_string('product_variation')
		parent_data: rt.new_array()
	}
	obj.construct(product)
	return obj
}

fn create_wc_product_simple() &Class_WC_Product_Simple {
	mut obj := &Class_WC_Product_Simple{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Product_Variation) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'get_hook_prefix' {
			return rt.new_string(this.get_hook_prefix())
		}
		'get_type' {
			return this.get_type()
		}
		'get_stock_managed_by_id' {
			return this.get_stock_managed_by_id()
		}
		'get_title' {
			return this.get_title()
		}
		'get_formatted_name' {
			return rt.new_string(this.get_formatted_name())
		}
		'get_variation_attributes' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			return this.get_variation_attributes(dispatch_arg_0)
		}
		'get_attribute' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.get_attribute(dispatch_arg_0))
		}
		'get_permalink' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_permalink(dispatch_arg_0)
		}
		'add_to_cart_url' {
			return this.add_to_cart_url()
		}
		'get_sku' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_sku(dispatch_arg_0)
		}
		'get_weight' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_weight(dispatch_arg_0)
		}
		'get_length' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_length(dispatch_arg_0)
		}
		'get_width' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_width(dispatch_arg_0)
		}
		'get_height' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_height(dispatch_arg_0)
		}
		'get_tax_class' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_tax_class(dispatch_arg_0)
		}
		'get_manage_stock' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_manage_stock(dispatch_arg_0)
		}
		'get_stock_quantity' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_stock_quantity(dispatch_arg_0)
		}
		'get_backorders' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_backorders(dispatch_arg_0)
		}
		'get_image_id' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_image_id(dispatch_arg_0)
		}
		'get_purchase_note' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_purchase_note(dispatch_arg_0)
		}
		'get_shipping_class_id' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_shipping_class_id(dispatch_arg_0)
		}
		'get_catalog_visibility' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_catalog_visibility(dispatch_arg_0)
		}
		'get_attribute_summary' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_attribute_summary(dispatch_arg_0)
		}
		'set_attribute_summary' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_attribute_summary(dispatch_arg_0)
			return rt.new_null()
		}
		'set_parent_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_parent_data(dispatch_arg_0)
			return rt.new_null()
		}
		'get_parent_data' {
			return this.get_parent_data()
		}
		'set_attributes' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_attributes(dispatch_arg_0)
			return rt.new_null()
		}
		'has_attributes' {
			return rt.new_bool(this.has_attributes())
		}
		'is_purchasable' {
			return this.is_purchasable()
		}
		'variation_is_active' {
			return this.variation_is_active()
		}
		'variation_is_visible' {
			return this.variation_is_visible()
		}
		'get_valid_tax_classes' {
			return this.get_valid_tax_classes()
		}
		'get_cogs_value_is_additive' {
			return rt.new_bool(this.get_cogs_value_is_additive())
		}
		'set_cogs_value_is_additive' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			this.set_cogs_value_is_additive(dispatch_arg_0)
			return rt.new_null()
		}
		'adjust_cogs_value_before_set' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_?float](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_float(this.adjust_cogs_value_before_set(mut dispatch_arg_0))
		}
		'get_cogs_total_value_core' {
			return rt.new_float(this.get_cogs_total_value_core())
		}
		'get_parent_cogs_effective_value' {
			return rt.new_float(this.get_parent_cogs_effective_value())
		}
		else { return none }
	}
}

fn (this &Class_WC_Product_Variation) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'post_type' { return this.post_type }
		'parent_data' { return this.parent_data }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_Product_Variation) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'post_type' { this.post_type = val; return true }
		'parent_data' { this.parent_data = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_WC_Product_Simple) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Product_Simple) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Product_Simple) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_includes_class_wc_product_variation_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
