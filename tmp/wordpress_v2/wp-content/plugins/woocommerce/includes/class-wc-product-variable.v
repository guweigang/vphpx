import rt

struct Class_WC_Product_Variable {
	rt.PhpObjectBase
pub mut:
		children rt.PhpVal = rt.new_null()
		visible_children rt.PhpVal = rt.new_null()
		variation_attributes rt.PhpVal = rt.new_null()
}

fn (mut this Class_WC_Product_Variable) get_type() rt.PhpVal {
	return Class_Automattic_WooCommerce_Enums_ProductType.variable()
}

fn (mut this Class_WC_Product_Variable) add_to_cart_aria_describedby() rt.PhpVal {
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_product_add_to_cart_aria_describedby'), if rt.is_true(this.is_purchasable()) { rt.call_function('__', [rt.new_string('This product has multiple variants. The options may be chosen on the product page'), rt.new_string('woocommerce')]) } else { rt.new_string('') }, rt.new_object('WC_Product_Variable', ['WC_Product'], &this)])
}

fn (mut this Class_WC_Product_Variable) add_to_cart_text() rt.PhpVal {
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_product_add_to_cart_text'), if rt.is_true(this.is_purchasable()) { rt.call_function('__', [rt.new_string('Select options'), rt.new_string('woocommerce')]) } else { rt.call_function('__', [rt.new_string('Read more'), rt.new_string('woocommerce')]) }, rt.new_object('WC_Product_Variable', ['WC_Product'], &this)])
}

fn (mut this Class_WC_Product_Variable) add_to_cart_description() rt.PhpVal {
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_product_add_to_cart_description'), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Select options for &ldquo;%s&rdquo;'), rt.new_string('woocommerce')]), this.get_name()]), rt.new_object('WC_Product_Variable', ['WC_Product'], &this)])
}

fn (mut this Class_WC_Product_Variable) get_variation_prices(for_display bool) rt.PhpVal {
	mut var_prices := rt.call_method(rt.get_property(rt.new_object('WC_Product_Variable', ['WC_Product'], &this), 'data_store'), 'read_price_data', [rt.new_object('WC_Product_Variable', ['WC_Product'], &this), rt.new_bool(for_display)])
	mut iter_1 := var_prices.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_variation_prices := item_1.val
		mut var_price_key := item_1.key
		var_prices.array_set(var_price_key, this.sort_variation_prices(var_variation_prices.clone()))
	}
	return var_prices.clone()
}

fn (mut this Class_WC_Product_Variable) get_variation_regular_price(min_or_max string, for_display bool) rt.PhpVal {
	mut var_prices := this.get_variation_prices(for_display)
	mut var_price := if rt.is_true(rt.identical(rt.new_string('min'), rt.new_string(min_or_max))) { rt.call_function('current', [var_prices.array_get(rt.new_string('regular_price'))]) } else { rt.call_function('end', [var_prices.array_get(rt.new_string('regular_price'))]) }
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_get_variation_regular_price'), var_price.clone(), rt.new_object('WC_Product_Variable', ['WC_Product'], &this), rt.new_string(min_or_max), rt.new_bool(for_display)])
}

fn (mut this Class_WC_Product_Variable) get_variation_sale_price(min_or_max string, for_display bool) rt.PhpVal {
	mut var_prices := this.get_variation_prices(for_display)
	mut var_price := if rt.is_true(rt.identical(rt.new_string('min'), rt.new_string(min_or_max))) { rt.call_function('current', [var_prices.array_get(rt.new_string('sale_price'))]) } else { rt.call_function('end', [var_prices.array_get(rt.new_string('sale_price'))]) }
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_get_variation_sale_price'), var_price.clone(), rt.new_object('WC_Product_Variable', ['WC_Product'], &this), rt.new_string(min_or_max), rt.new_bool(for_display)])
}

fn (mut this Class_WC_Product_Variable) get_variation_price(min_or_max string, for_display bool) rt.PhpVal {
	mut var_prices := this.get_variation_prices(for_display)
	mut var_price := if rt.is_true(rt.identical(rt.new_string('min'), rt.new_string(min_or_max))) { rt.call_function('current', [var_prices.array_get(rt.new_string('price'))]) } else { rt.call_function('end', [var_prices.array_get(rt.new_string('price'))]) }
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_get_variation_price'), var_price.clone(), rt.new_object('WC_Product_Variable', ['WC_Product'], &this), rt.new_string(min_or_max), rt.new_bool(for_display)])
}

fn (mut this Class_WC_Product_Variable) get_price_html(price string) rt.PhpVal {
	mut price_mutated := price
	mut var_prices := this.get_variation_prices(true)
	if !rt.is_true(var_prices.array_get(rt.new_string('price'))) {
	price_mutated = (rt.call_function('apply_filters', [rt.new_string('woocommerce_variable_empty_price_html'), rt.new_string(''), rt.new_object('WC_Product_Variable', ['WC_Product'], &this)])).str()
	} else {
		mut var_min_price := rt.call_function('current', [var_prices.array_get(rt.new_string('price'))])
		mut var_max_price := rt.call_function('end', [var_prices.array_get(rt.new_string('price'))])
		mut var_min_reg_price := rt.call_function('current', [var_prices.array_get(rt.new_string('regular_price'))])
		mut var_max_reg_price := rt.call_function('end', [var_prices.array_get(rt.new_string('regular_price'))])
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_min_price, var_max_price)))) {
		price_mutated = (rt.call_function('wc_format_price_range', [var_min_price.clone(), var_max_price.clone()])).str()
		} else if rt.is_true(this.is_on_sale('')) && rt.is_true(rt.identical(var_min_reg_price, var_max_reg_price)) {
		price_mutated = (rt.call_function('wc_format_sale_price', [rt.call_function('wc_price', [var_max_reg_price.clone()]), rt.call_function('wc_price', [var_min_price.clone()])])).str()
		} else {
		price_mutated = (rt.call_function('wc_price', [var_min_price.clone()])).str()
		}
	price_mutated = (rt.call_function('apply_filters', [rt.new_string('woocommerce_variable_price_html'), rt.new_string(price_mutated + (this.get_price_suffix('', 0)).str()), rt.new_object('WC_Product_Variable', ['WC_Product'], &this)])).str()
	}
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_get_price_html'), rt.new_string(price_mutated).clone(), rt.new_object('WC_Product_Variable', ['WC_Product'], &this)])
}

fn (mut this Class_WC_Product_Variable) get_price_suffix(price string, qty i64) rt.PhpVal {
	mut price_mutated := price
	mut var_suffix := rt.call_function('get_option', [rt.new_string('woocommerce_price_display_suffix')])
	if rt.is_true(rt.call_function('strstr', [var_suffix.clone(), rt.new_string('{')])) {
		return rt.call_function('apply_filters', [rt.new_string('woocommerce_get_price_suffix'), rt.new_string(''), rt.new_object('WC_Product_Variable', ['WC_Product'], &this), rt.new_string(price_mutated).clone(), rt.new_int(qty)])
	} else {
		return this.Class_WC_Product.get_price_suffix(rt.new_string(price_mutated), rt.new_int(qty))
	}
	return rt.new_null()
}

fn (mut this Class_WC_Product_Variable) get_children(visible_only string) rt.PhpVal {
	if rt.is_true(rt.new_bool(rt.new_string(visible_only).is_bool())) {
		rt.call_function('wc_deprecated_argument', [rt.new_string('visible_only'), rt.new_string('3.0'), rt.new_string('WC_Product_Variable::get_visible_children')])
		return if var_visible_only.len > 0 && var_visible_only != '0' { this.get_visible_children() } else { this.get_children('') }
	}
	if rt.is_true(rt.identical(rt.new_null(), this.children)) {
		mut var_children := rt.call_method(rt.get_property(rt.new_object('WC_Product_Variable', ['WC_Product'], &this), 'data_store'), 'read_children', [rt.new_object('WC_Product_Variable', ['WC_Product'], &this)])
		this.set_children(var_children.array_get(rt.new_string('all')))
		this.set_visible_children(var_children.array_get(rt.new_string('visible')))
	}
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_get_children'), this.children, rt.new_object('WC_Product_Variable', ['WC_Product'], &this), rt.new_bool(false)])
}

fn (mut this Class_WC_Product_Variable) get_visible_children() rt.PhpVal {
	if rt.is_true(rt.identical(rt.new_null(), this.visible_children)) {
		mut var_children := rt.call_method(rt.get_property(rt.new_object('WC_Product_Variable', ['WC_Product'], &this), 'data_store'), 'read_children', [rt.new_object('WC_Product_Variable', ['WC_Product'], &this)])
		this.set_children(var_children.array_get(rt.new_string('all')))
		this.set_visible_children(var_children.array_get(rt.new_string('visible')))
	}
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_get_children'), this.visible_children, rt.new_object('WC_Product_Variable', ['WC_Product'], &this), rt.new_bool(true)])
}

fn (mut this Class_WC_Product_Variable) get_variation_attributes() rt.PhpVal {
	if rt.is_true(rt.identical(rt.new_null(), this.variation_attributes)) {
		this.variation_attributes = rt.call_method(rt.get_property(rt.new_object('WC_Product_Variable', ['WC_Product'], &this), 'data_store'), 'read_variation_attributes', [rt.new_object('WC_Product_Variable', ['WC_Product'], &this)])
	}
	return this.variation_attributes
}

fn (mut this Class_WC_Product_Variable) get_variation_default_attribute(var_attribute_name rt.PhpVal) rt.PhpVal {
	mut var_attribute_name_mutated := var_attribute_name
	mut var_defaults := this.get_default_attributes()
	var_attribute_name_mutated = rt.call_function('sanitize_title', [var_attribute_name_mutated.clone()])
	return if var_defaults.array_isset(var_attribute_name_mutated) { var_defaults.array_get(var_attribute_name_mutated) } else { rt.new_string('') }
}

fn (mut this Class_WC_Product_Variable) get_downloadable(context string) bool {
	return false
}

fn (mut this Class_WC_Product_Variable) get_virtual(context string) bool {
	return false
}

fn (mut this Class_WC_Product_Variable) get_available_variations(return string) rt.PhpVal {
	mut var_variation_ids := this.get_children('')
	mut var_hide_out_of_stock_items := rt.identical(rt.new_string('yes'), rt.call_function('get_option', [rt.new_string('woocommerce_hide_out_of_stock_items')]))
	mut var_available_variations := rt.new_array()
	if !(!rt.is_true(var_variation_ids)) {
		rt.call_function('_prime_post_caches', [var_variation_ids.clone()])
	}
	mut iter_2 := var_variation_ids.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_variation_id := item_2.val
		mut var_variation := rt.call_function('wc_get_product', [var_variation_id.clone()])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_variation)))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_variation, 'exists', []rt.PhpVal{}))))) || (rt.is_true(var_hide_out_of_stock_items) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_variation, 'is_in_stock', []rt.PhpVal{})))))) {
			continue
		}
		if rt.is_true(rt.call_function('apply_filters', [rt.new_string('woocommerce_hide_invisible_variations'), rt.new_bool(true), this.get_id(), var_variation.clone()])) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_variation, 'variation_is_visible', []rt.PhpVal{}))))) {
			continue
		}
		if rt.is_true(rt.identical(rt.new_string('array'), rt.new_string(return))) {
			var_available_variations.array_push(this.get_available_variation(var_variation.clone()))
		} else {
			var_available_variations.array_push(var_variation.clone())
		}
	}
	if rt.is_true(rt.identical(rt.new_string('array'), rt.new_string(return))) {
	var_available_variations = rt.call_function('array_values', [rt.call_function('array_filter', [var_available_variations.clone()])])
	}
	return var_available_variations.clone()
}

fn (mut this Class_WC_Product_Variable) has_purchasable_variations() bool {
	mut var_variation_ids := this.get_children('')
	if !(!rt.is_true(var_variation_ids)) {
		rt.call_function('_prime_post_caches', [var_variation_ids.clone()])
	}
	mut iter_3 := var_variation_ids.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_variation_id := item_3.val
		mut var_variation := rt.call_function('wc_get_product', [var_variation_id.clone()])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_variation)))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_variation, 'is_purchasable', []rt.PhpVal{}))))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_variation, 'is_in_stock', []rt.PhpVal{}))))) {
			continue
		}
		return true
	}
	return false
}

fn (mut this Class_WC_Product_Variable) get_available_variation(var_variation rt.PhpVal) bool {
	mut var_variation_mutated := var_variation
	if rt.is_true(rt.new_bool(var_variation_mutated.clone().is_long() || var_variation_mutated.clone().is_double())) {
	var_variation_mutated = rt.call_function('wc_get_product', [var_variation_mutated.clone()])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_variation_mutated, 'WC_Product_Variation')))))) {
		return false
	}
	mut var_show_variation_price := rt.call_function('apply_filters', [rt.new_string('woocommerce_show_variation_price'), rt.new_bool(rt.is_true(rt.identical(rt.call_method(var_variation_mutated, 'get_price', []rt.PhpVal{}), rt.new_string(''))) || rt.is_true(rt.new_bool(!rt.is_true(rt.identical(this.get_variation_sale_price('min', false), this.get_variation_sale_price('max', false))))) || rt.is_true(rt.new_bool(!rt.is_true(rt.identical(this.get_variation_regular_price('min', false), this.get_variation_regular_price('max', false)))))), rt.new_object('WC_Product_Variable', ['WC_Product'], &this), var_variation_mutated.clone()])
	return (rt.call_function('apply_filters', [rt.new_string('woocommerce_available_variation'), rt.create_array([rt.ArrayItem{ key: 'attributes', val: rt.call_method(var_variation_mutated, 'get_variation_attributes', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'availability_html', val: rt.call_function('wc_get_stock_html', [var_variation_mutated.clone()]) }, rt.ArrayItem{ key: 'backorders_allowed', val: rt.call_method(var_variation_mutated, 'backorders_allowed', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'dimensions', val: rt.call_method(var_variation_mutated, 'get_dimensions', [rt.new_bool(false)]) }, rt.ArrayItem{ key: 'dimensions_html', val: rt.call_function('wc_format_dimensions', [rt.call_method(var_variation_mutated, 'get_dimensions', [rt.new_bool(false)])]) }, rt.ArrayItem{ key: 'display_price', val: rt.call_function('wc_get_price_to_display', [var_variation_mutated.clone()]) }, rt.ArrayItem{ key: 'display_regular_price', val: rt.call_function('wc_get_price_to_display', [var_variation_mutated.clone(), rt.create_array([rt.ArrayItem{ key: 'price', val: rt.call_method(var_variation_mutated, 'get_regular_price', []rt.PhpVal{}) }])]) }, rt.ArrayItem{ key: 'image', val: rt.call_function('wc_get_product_attachment_props', [rt.call_method(var_variation_mutated, 'get_image_id', []rt.PhpVal{})]) }, rt.ArrayItem{ key: 'image_id', val: rt.call_method(var_variation_mutated, 'get_image_id', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'is_downloadable', val: rt.call_method(var_variation_mutated, 'is_downloadable', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'is_in_stock', val: rt.call_method(var_variation_mutated, 'is_in_stock', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'is_purchasable', val: rt.call_method(var_variation_mutated, 'is_purchasable', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'is_sold_individually', val: if rt.is_true(rt.call_method(var_variation_mutated, 'is_sold_individually', []rt.PhpVal{})) { 'yes' } else { 'no' } }, rt.ArrayItem{ key: 'is_virtual', val: rt.call_method(var_variation_mutated, 'is_virtual', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'max_qty', val: if rt.is_true(rt.less(rt.new_int(0), rt.call_method(var_variation_mutated, 'get_max_purchase_quantity', []rt.PhpVal{}))) { rt.call_method(var_variation_mutated, 'get_max_purchase_quantity', []rt.PhpVal{}) } else { rt.new_string('') } }, rt.ArrayItem{ key: 'min_qty', val: rt.call_method(var_variation_mutated, 'get_min_purchase_quantity', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'price_html', val: if rt.is_true(var_show_variation_price) { '<span class="price">' + (rt.call_method(var_variation_mutated, 'get_price_html', []rt.PhpVal{})).str() + '</span>' } else { '' } }, rt.ArrayItem{ key: 'sku', val: rt.call_method(var_variation_mutated, 'get_sku', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'variation_description', val: rt.call_function('wc_format_content', [rt.call_method(var_variation_mutated, 'get_description', []rt.PhpVal{})]) }, rt.ArrayItem{ key: 'variation_id', val: rt.call_method(var_variation_mutated, 'get_id', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'variation_is_active', val: rt.call_method(var_variation_mutated, 'variation_is_active', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'variation_is_visible', val: rt.call_method(var_variation_mutated, 'variation_is_visible', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'weight', val: rt.call_method(var_variation_mutated, 'get_weight', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'weight_html', val: rt.call_function('wc_format_weight', [rt.call_method(var_variation_mutated, 'get_weight', []rt.PhpVal{})]) }]), rt.new_object('WC_Product_Variable', ['WC_Product'], &this), var_variation_mutated.clone()])).to_bool()
}

fn (mut this Class_WC_Product_Variable) set_variation_attributes(var_variation_attributes rt.PhpVal) {
	this.variation_attributes = var_variation_attributes.clone()
}

fn (mut this Class_WC_Product_Variable) set_children(var_children rt.PhpVal) {
	mut var_children_mutated := var_children
	this.children = rt.call_function('array_filter', [rt.call_function('wp_parse_id_list', [rt.cast_array(var_children_mutated)])])
}

fn (mut this Class_WC_Product_Variable) set_visible_children(var_visible_children rt.PhpVal) {
	this.visible_children = rt.call_function('array_filter', [rt.call_function('wp_parse_id_list', [rt.cast_array(var_visible_children)])])
}

fn (mut this Class_WC_Product_Variable) validate_props() {
	this.Class_WC_Product.validate_props()
	if rt.is_true(rt.new_bool(!(rt.is_true(this.get_manage_stock())))) {
		rt.call_method(rt.get_property(rt.new_object('WC_Product_Variable', ['WC_Product'], &this), 'data_store'), 'sync_stock_status', [rt.new_object('WC_Product_Variable', ['WC_Product'], &this)])
	}
}

fn (mut this Class_WC_Product_Variable) before_data_store_save_or_update() rt.PhpVal {
	mut var_previous_name := rt.get_property(rt.new_object('WC_Product_Variable', ['WC_Product'], &this), 'data').array_get(rt.new_string('name'))
	mut var_new_name := this.get_name(rt.new_string('edit'))
	return rt.create_array([rt.ArrayItem{ key: 'previous_name', val: var_previous_name }, rt.ArrayItem{ key: 'new_name', val: var_new_name }])
}

fn (mut this Class_WC_Product_Variable) after_data_store_save_or_update(var_state rt.PhpVal) {
	rt.call_method(rt.get_property(rt.new_object('WC_Product_Variable', ['WC_Product'], &this), 'data_store'), 'sync_variation_names', [rt.new_object('WC_Product_Variable', ['WC_Product'], &this), var_state.array_get(rt.new_string('previous_name')), var_state.array_get(rt.new_string('new_name'))])
	rt.call_method(rt.get_property(rt.new_object('WC_Product_Variable', ['WC_Product'], &this), 'data_store'), 'sync_managed_variation_stock_status', [rt.new_object('WC_Product_Variable', ['WC_Product'], &this)])
}

fn (mut this Class_WC_Product_Variable) is_on_sale(context string) rt.PhpVal {
	mut var_prices := this.get_variation_prices(false)
	mut var_on_sale := rt.new_bool(rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_prices.array_get(rt.new_string('regular_price')), var_prices.array_get(rt.new_string('sale_price')))))) && rt.is_true(rt.identical(var_prices.array_get(rt.new_string('sale_price')), var_prices.array_get(rt.new_string('price')))))
	return if rt.is_true(rt.identical(rt.new_string('view'), rt.new_string(context))) { rt.call_function('apply_filters', [rt.new_string('woocommerce_product_is_on_sale'), var_on_sale.clone(), rt.new_object('WC_Product_Variable', ['WC_Product'], &this)]) } else { var_on_sale }
}

fn (mut this Class_WC_Product_Variable) child_is_in_stock() rt.PhpVal {
	return rt.call_method(rt.get_property(rt.new_object('WC_Product_Variable', ['WC_Product'], &this), 'data_store'), 'child_is_in_stock', [rt.new_object('WC_Product_Variable', ['WC_Product'], &this)])
}

fn (mut this Class_WC_Product_Variable) child_is_on_backorder() rt.PhpVal {
	return rt.call_method(rt.get_property(rt.new_object('WC_Product_Variable', ['WC_Product'], &this), 'data_store'), 'child_has_stock_status', [rt.new_object('WC_Product_Variable', ['WC_Product'], &this), Class_Automattic_WooCommerce_Enums_ProductStockStatus.on_backorder()])
}

fn (mut this Class_WC_Product_Variable) child_has_weight() bool {
	mut var_transient_name := rt.new_string('wc_child_has_weight_' + (this.get_id()).str())
	mut var_has_weight := rt.call_function('get_transient', [var_transient_name.clone()])
	if rt.is_true(rt.identical(rt.new_bool(false), var_has_weight)) {
		var_has_weight = rt.call_method(rt.get_property(rt.new_object('WC_Product_Variable', ['WC_Product'], &this), 'data_store'), 'child_has_weight', [rt.new_object('WC_Product_Variable', ['WC_Product'], &this)])
		rt.call_function('set_transient', [var_transient_name.clone(), rt.new_int((var_has_weight).to_i64()), rt.mul(rt.get_constant('DAY_IN_SECONDS'), rt.new_int(30))])
	}
	return (var_has_weight).to_bool()
}

fn (mut this Class_WC_Product_Variable) child_has_dimensions() bool {
	mut var_transient_name := rt.new_string('wc_child_has_dimensions_' + (this.get_id()).str())
	mut var_has_dimension := rt.call_function('get_transient', [var_transient_name.clone()])
	if rt.is_true(rt.identical(rt.new_bool(false), var_has_dimension)) {
		var_has_dimension = rt.call_method(rt.get_property(rt.new_object('WC_Product_Variable', ['WC_Product'], &this), 'data_store'), 'child_has_dimensions', [rt.new_object('WC_Product_Variable', ['WC_Product'], &this)])
		rt.call_function('set_transient', [var_transient_name.clone(), rt.new_int((var_has_dimension).to_i64()), rt.mul(rt.get_constant('DAY_IN_SECONDS'), rt.new_int(30))])
	}
	return (var_has_dimension).to_bool()
}

fn (mut this Class_WC_Product_Variable) has_dimensions() bool {
	return rt.is_true(this.Class_WC_Product.has_dimensions()) || this.child_has_dimensions()
}

fn (mut this Class_WC_Product_Variable) has_weight() bool {
	return rt.is_true(this.Class_WC_Product.has_weight()) || this.child_has_weight()
}

fn (mut this Class_WC_Product_Variable) has_options() rt.PhpVal {
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_product_has_options'), rt.new_bool(true), rt.new_object('WC_Product_Variable', ['WC_Product'], &this)])
}

fn Class_WC_Product_Variable.sync(var_product rt.PhpVal, save bool) rt.PhpVal {
	mut var_product_mutated := var_product
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_a', [var_product_mutated.clone(), rt.new_string('WC_Product')]))))) {
	var_product_mutated = rt.call_function('wc_get_product', [var_product_mutated.clone()])
	}
	if rt.is_true(rt.call_function('is_a', [var_product_mutated.clone(), rt.new_string('WC_Product_Variable')])) {
		mut iife_temp_0 := Class_WC_Data_Store{}
		mut iife_result_0 := iife_temp_0.load(rt.new_string('product-' + (rt.call_method(var_product_mutated, 'get_type', []rt.PhpVal{})).str()))
		mut var_data_store := iife_result_0
		rt.call_method(var_data_store, 'sync_price', [var_product_mutated.clone()])
		rt.call_method(var_data_store, 'sync_stock_status', [var_product_mutated.clone()])
		mut iife_temp_1 := Class_WC_Product_Variable{}
		mut iife_result_1 := iife_temp_1.sync_attributes(var_product_mutated.clone())
		rt.call_function('do_action', [rt.new_string('woocommerce_variable_product_sync_data'), var_product_mutated.clone()])
		if var_save {
			rt.call_method(var_product_mutated, 'save', []rt.PhpVal{})
		}
		rt.call_function('wc_do_deprecated_action', [rt.new_string('woocommerce_variable_product_sync'), rt.create_array([rt.ArrayItem{ key: none, val: rt.call_method(var_product_mutated, 'get_id', []rt.PhpVal{}) }, rt.ArrayItem{ key: none, val: rt.call_method(var_product_mutated, 'get_visible_children', []rt.PhpVal{}) }]), rt.new_string('3.0'), rt.new_string('woocommerce_variable_product_sync_data, woocommerce_new_product or woocommerce_update_product')])
	}
	return var_product_mutated.clone()
}

fn Class_WC_Product_Variable.sync_stock_status(var_product rt.PhpVal, save bool) rt.PhpVal {
	mut var_product_mutated := var_product
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_a', [var_product_mutated.clone(), rt.new_string('WC_Product')]))))) {
	var_product_mutated = rt.call_function('wc_get_product', [var_product_mutated.clone()])
	}
	if rt.is_true(rt.call_function('is_a', [var_product_mutated.clone(), rt.new_string('WC_Product_Variable')])) {
		mut iife_temp_2 := Class_WC_Data_Store{}
		mut iife_result_2 := iife_temp_2.load(rt.new_string('product-' + (rt.call_method(var_product_mutated, 'get_type', []rt.PhpVal{})).str()))
		mut var_data_store := iife_result_2
		rt.call_method(var_data_store, 'sync_stock_status', [var_product_mutated.clone()])
		if var_save {
			rt.call_method(var_product_mutated, 'save', []rt.PhpVal{})
		}
	}
	return var_product_mutated.clone()
}

fn (mut this Class_WC_Product_Variable) sort_variation_prices(var_prices rt.PhpVal) rt.PhpVal {
	mut var_prices_mutated := var_prices
	rt.call_function('asort', [var_prices_mutated.clone()])
	return var_prices_mutated.clone()
}

struct Class_WC_Product {
	rt.PhpObjectBase
}

struct Class_WC_Data_Store {
	rt.PhpObjectBase
}

fn create_wc_product_variable(_args ...rt.PhpVal) &Class_WC_Product_Variable {
	mut obj := &Class_WC_Product_Variable{
		PhpObjectBase: rt.PhpObjectBase{}
		children: rt.new_null()
		visible_children: rt.new_null()
		variation_attributes: rt.new_null()
	}
	return obj
}

fn create_wc_product(_args ...rt.PhpVal) &Class_WC_Product {
	mut obj := &Class_WC_Product{
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

fn (mut this Class_WC_Product_Variable) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_type' {
			return this.get_type()
		}
		'add_to_cart_aria_describedby' {
			return this.add_to_cart_aria_describedby()
		}
		'add_to_cart_text' {
			return this.add_to_cart_text()
		}
		'add_to_cart_description' {
			return this.add_to_cart_description()
		}
		'get_variation_prices' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			return this.get_variation_prices(dispatch_arg_0)
		}
		'get_variation_regular_price' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			return this.get_variation_regular_price(dispatch_arg_0, dispatch_arg_1)
		}
		'get_variation_sale_price' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			return this.get_variation_sale_price(dispatch_arg_0, dispatch_arg_1)
		}
		'get_variation_price' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			return this.get_variation_price(dispatch_arg_0, dispatch_arg_1)
		}
		'get_price_html' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_price_html(dispatch_arg_0)
		}
		'get_price_suffix' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			return this.get_price_suffix(dispatch_arg_0, dispatch_arg_1)
		}
		'get_children' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_children(dispatch_arg_0)
		}
		'get_visible_children' {
			return this.get_visible_children()
		}
		'get_variation_attributes' {
			return this.get_variation_attributes()
		}
		'get_variation_default_attribute' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_variation_default_attribute(dispatch_arg_0)
		}
		'get_downloadable' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(this.get_downloadable(dispatch_arg_0))
		}
		'get_virtual' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(this.get_virtual(dispatch_arg_0))
		}
		'get_available_variations' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_available_variations(dispatch_arg_0)
		}
		'has_purchasable_variations' {
			return rt.new_bool(this.has_purchasable_variations())
		}
		'get_available_variation' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.get_available_variation(dispatch_arg_0))
		}
		'set_variation_attributes' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_variation_attributes(dispatch_arg_0)
			return rt.new_null()
		}
		'set_children' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_children(dispatch_arg_0)
			return rt.new_null()
		}
		'set_visible_children' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_visible_children(dispatch_arg_0)
			return rt.new_null()
		}
		'validate_props' {
			this.validate_props()
			return rt.new_null()
		}
		'before_data_store_save_or_update' {
			return this.before_data_store_save_or_update()
		}
		'after_data_store_save_or_update' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.after_data_store_save_or_update(dispatch_arg_0)
			return rt.new_null()
		}
		'is_on_sale' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.is_on_sale(dispatch_arg_0)
		}
		'child_is_in_stock' {
			return this.child_is_in_stock()
		}
		'child_is_on_backorder' {
			return this.child_is_on_backorder()
		}
		'child_has_weight' {
			return rt.new_bool(this.child_has_weight())
		}
		'child_has_dimensions' {
			return rt.new_bool(this.child_has_dimensions())
		}
		'has_dimensions' {
			return rt.new_bool(this.has_dimensions())
		}
		'has_weight' {
			return rt.new_bool(this.has_weight())
		}
		'has_options' {
			return this.has_options()
		}
		'sync' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			return Class_WC_Product_Variable.sync(dispatch_arg_0, dispatch_arg_1)
		}
		'sync_stock_status' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			return Class_WC_Product_Variable.sync_stock_status(dispatch_arg_0, dispatch_arg_1)
		}
		'sort_variation_prices' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.sort_variation_prices(dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_WC_Product_Variable) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'children' { return this.children }
		'visible_children' { return this.visible_children }
		'variation_attributes' { return this.variation_attributes }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_Product_Variable) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'children' { this.children = val; return true }
		'visible_children' { this.visible_children = val; return true }
		'variation_attributes' { this.variation_attributes = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_WC_Product) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Product) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Product) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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



fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(exit(0)))
}
