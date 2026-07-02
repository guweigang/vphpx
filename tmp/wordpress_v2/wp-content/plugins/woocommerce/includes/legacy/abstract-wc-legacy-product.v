import rt

struct Class_WC_Abstract_Legacy_Product {
	rt.PhpObjectBase
}

fn (mut this Class_WC_Abstract_Legacy_Product) magic_isset(var_key rt.PhpVal) bool {
	mut var_valid := rt.create_array([rt.ArrayItem{ key: none, val: 'id' },
		rt.ArrayItem{ key: none, val: 'product_attributes' },
		rt.ArrayItem{ key: none, val: 'visibility' }, rt.ArrayItem{
			key: none
			val: 'sale_price_dates_from'
		}, rt.ArrayItem{ key: none, val: 'sale_price_dates_to' },
		rt.ArrayItem{ key: none, val: 'post' }, rt.ArrayItem{ key: none, val: 'download_type' },
		rt.ArrayItem{ key: none, val: 'product_image_gallery' },
		rt.ArrayItem{ key: none, val: 'variation_shipping_class' },
		rt.ArrayItem{ key: none, val: 'shipping_class' }, rt.ArrayItem{
			key: none
			val: 'total_stock'
		}, rt.ArrayItem{ key: none, val: 'crosssell_ids' }, rt.ArrayItem{ key: none, val: 'parent' }])
	if rt.is_true(this.is_type(Class_Automattic_WooCommerce_Enums_ProductType.variation())) {
		var_valid = rt.call_function('array_merge', [var_valid.clone(),
			rt.create_array([rt.ArrayItem{ key: none, val: 'variation_id' },
				rt.ArrayItem{ key: none, val: 'variation_data' },
				rt.ArrayItem{ key: none, val: 'variation_has_stock' },
				rt.ArrayItem{ key: none, val: 'variation_shipping_class_id' },
				rt.ArrayItem{ key: none, val: 'variation_has_sku' },
				rt.ArrayItem{ key: none, val: 'variation_has_length' },
				rt.ArrayItem{ key: none, val: 'variation_has_width' },
				rt.ArrayItem{ key: none, val: 'variation_has_height' },
				rt.ArrayItem{ key: none, val: 'variation_has_weight' },
				rt.ArrayItem{ key: none, val: 'variation_has_tax_class' },
				rt.ArrayItem{ key: none, val: 'variation_has_downloadable_files' }])])
	}
	return
		rt.is_true(rt.call_function('in_array', [var_key.clone(), rt.call_function('array_merge', [var_valid.clone(), rt.func_array_keys(rt.get_property(rt.new_object('WC_Abstract_Legacy_Product', ['WC_Data'], &this), 'data'))])]))
		|| rt.is_true(rt.call_function('metadata_exists', [rt.new_string('post'), this.get_id(), rt.new_string('_' + var_key.str())]))
		|| rt.is_true(rt.call_function('metadata_exists', [rt.new_string('post'), this.get_parent_id(), rt.new_string('_' + var_key.str())]))
}

fn (mut this Class_WC_Abstract_Legacy_Product) magic_get(var_key rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.identical(rt.new_string('post_type'), var_key)) {
		return rt.get_property(rt.new_object('WC_Abstract_Legacy_Product', ['WC_Data'], &this),
			'post_type')
	}
	rt.call_function('wc_doing_it_wrong', [var_key.clone(),
		rt.call_function('__', [
			rt.new_string('Product properties should not be accessed directly.'),
			rt.new_string('woocommerce'),
		]),
		rt.new_string('3.0')])
	mut switch_val_1 := var_key
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('id'))) {
		mut var_value := if rt.is_true(this.is_type(Class_Automattic_WooCommerce_Enums_ProductType.variation())) {
			this.get_parent_id()
		} else {
			this.get_id()
		}
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('product_type'))) {
		var_value = this.get_type()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('product_attributes'))) {
		var_value = if rt.get_property(rt.new_object('WC_Abstract_Legacy_Product', [
			'WC_Data',
		], &this), 'data').array_isset(rt.new_string('attributes'))
		{
			rt.get_property(rt.new_object('WC_Abstract_Legacy_Product', ['WC_Data'], &this), 'data').array_get(rt.new_string('attributes'))
		} else {
			rt.new_string('')
		}
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('visibility'))) {
		var_value = this.get_catalog_visibility()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('sale_price_dates_from'))) {
		return if rt.is_true(this.get_date_on_sale_from()) {
			rt.call_method(this.get_date_on_sale_from(), 'getTimestamp', []rt.PhpVal{})
		} else {
			rt.new_string('')
		}
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('sale_price_dates_to'))) {
		return if rt.is_true(this.get_date_on_sale_to()) {
			rt.call_method(this.get_date_on_sale_to(), 'getTimestamp', []rt.PhpVal{})
		} else {
			rt.new_string('')
		}
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('post'))) {
		var_value = rt.call_function('get_post', [this.get_id()])
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('download_type'))) {
		return rt.new_string('standard')
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('product_image_gallery'))) {
		var_value = this.get_gallery_image_ids()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('variation_shipping_class')))
		|| rt.is_true(rt.equal(switch_val_1, rt.new_string('shipping_class'))) {
		var_value = this.get_shipping_class()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('total_stock'))) {
		var_value = this.get_total_stock()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('downloadable')))
		|| rt.is_true(rt.equal(switch_val_1, rt.new_string('virtual')))
		|| rt.is_true(rt.equal(switch_val_1, rt.new_string('manage_stock')))
		|| rt.is_true(rt.equal(switch_val_1, rt.new_string('featured')))
		|| rt.is_true(rt.equal(switch_val_1, rt.new_string('sold_individually'))) {
		var_value = if rt.is_true(rt.call_method(rt.new_object('WC_Abstract_Legacy_Product', [
			'WC_Data',
		], &this), 'get_${var_key.to_string()}', []rt.PhpVal{}))
		{ 'yes' } else { 'no' }
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('crosssell_ids'))) {
		var_value = this.get_cross_sell_ids()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('upsell_ids'))) {
		var_value = this.get_upsell_ids()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('parent'))) {
		var_value = rt.call_function('wc_get_product', [this.get_parent_id()])
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('variation_id'))) {
		var_value = if rt.is_true(this.is_type(Class_Automattic_WooCommerce_Enums_ProductType.variation())) {
			this.get_id()
		} else {
			rt.new_string('')
		}
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('variation_data'))) {
		var_value = if rt.is_true(this.is_type(Class_Automattic_WooCommerce_Enums_ProductType.variation())) { rt.call_function('wc_get_product_variation_attributes', [
				this.get_id(),
			]) } else { rt.new_string('') }
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('variation_has_stock'))) {
		var_value = if rt.is_true(this.is_type(Class_Automattic_WooCommerce_Enums_ProductType.variation())) {
			this.managing_stock()
		} else {
			rt.new_string('')
		}
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('variation_shipping_class_id'))) {
		var_value = if rt.is_true(this.is_type(Class_Automattic_WooCommerce_Enums_ProductType.variation())) {
			this.get_shipping_class_id()
		} else {
			rt.new_string('')
		}
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('variation_has_sku')))
		|| rt.is_true(rt.equal(switch_val_1, rt.new_string('variation_has_length')))
		|| rt.is_true(rt.equal(switch_val_1, rt.new_string('variation_has_width')))
		|| rt.is_true(rt.equal(switch_val_1, rt.new_string('variation_has_height')))
		|| rt.is_true(rt.equal(switch_val_1, rt.new_string('variation_has_weight')))
		|| rt.is_true(rt.equal(switch_val_1, rt.new_string('variation_has_tax_class')))
		|| rt.is_true(rt.equal(switch_val_1, rt.new_string('variation_has_downloadable_files'))) {
		var_value = rt.new_bool(true)
	} else {
		if rt.is_true(rt.call_function('in_array', [var_key.clone(),
			rt.func_array_keys(rt.get_property(rt.new_object('WC_Abstract_Legacy_Product', [
				'WC_Data',
			], &this), 'data'))]))
		{
			var_value = rt.call_method(rt.new_object('WC_Abstract_Legacy_Product', [
				'WC_Data',
			], &this), 'get_${var_key.to_string()}', []rt.PhpVal{})
		} else {
			var_value = rt.call_function('get_post_meta', [
				rt.get_property(rt.new_object('WC_Abstract_Legacy_Product', [
					'WC_Data',
				], &this), 'id'),
				rt.new_string('_' + var_key.str()),
				rt.new_bool(true),
			])
		}
	}
	return var_value.clone()
}

fn (mut this Class_WC_Abstract_Legacy_Product) get_variation_default_attributes() rt.PhpVal {
	rt.call_function('wc_deprecated_function', [
		rt.new_string('WC_Product_Variable::get_variation_default_attributes'),
		rt.new_string('3.0'),
		rt.new_string('WC_Product::get_default_attributes'),
	])
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_product_default_attributes'),
		this.get_default_attributes(),
		rt.new_object('WC_Abstract_Legacy_Product', ['WC_Data'], &this),
	])
}

fn (mut this Class_WC_Abstract_Legacy_Product) get_gallery_attachment_ids() rt.PhpVal {
	rt.call_function('wc_deprecated_function', [
		rt.new_string('WC_Product::get_gallery_attachment_ids'),
		rt.new_string('3.0'),
		rt.new_string('WC_Product::get_gallery_image_ids'),
	])
	return this.get_gallery_image_ids()
}

fn (mut this Class_WC_Abstract_Legacy_Product) set_stock(var_amount rt.PhpVal, mode string) rt.PhpVal {
	rt.call_function('wc_deprecated_function', [rt.new_string('WC_Product::set_stock'),
		rt.new_string('3.0'), rt.new_string('wc_update_product_stock')])
	return rt.call_function('wc_update_product_stock', [
		rt.new_object('WC_Abstract_Legacy_Product', ['WC_Data'], &this),
		var_amount.clone(),
		rt.new_string(mode),
	])
}

fn (mut this Class_WC_Abstract_Legacy_Product) reduce_stock(amount i64) rt.PhpVal {
	rt.call_function('wc_deprecated_function', [
		rt.new_string('WC_Product::reduce_stock'),
		rt.new_string('3.0'),
		rt.new_string('wc_update_product_stock'),
	])
	return rt.call_function('wc_update_product_stock', [
		rt.new_object('WC_Abstract_Legacy_Product', ['WC_Data'], &this),
		rt.new_int(amount),
		rt.new_string('decrease'),
	])
}

fn (mut this Class_WC_Abstract_Legacy_Product) increase_stock(amount i64) rt.PhpVal {
	rt.call_function('wc_deprecated_function', [
		rt.new_string('WC_Product::increase_stock'),
		rt.new_string('3.0'),
		rt.new_string('wc_update_product_stock'),
	])
	return rt.call_function('wc_update_product_stock', [
		rt.new_object('WC_Abstract_Legacy_Product', ['WC_Data'], &this),
		rt.new_int(amount),
		rt.new_string('increase'),
	])
}

fn (mut this Class_WC_Abstract_Legacy_Product) check_stock_status() {
	rt.call_function('wc_deprecated_function', [
		rt.new_string('WC_Product::check_stock_status'),
		rt.new_string('3.0'),
	])
}

fn (mut this Class_WC_Abstract_Legacy_Product) get_related(limit i64) rt.PhpVal {
	rt.call_function('wc_deprecated_function', [rt.new_string('WC_Product::get_related'),
		rt.new_string('3.0'), rt.new_string('wc_get_related_products')])
	return rt.call_function('wc_get_related_products', [this.get_id(),
		rt.new_int(limit)])
}

fn (mut this Class_WC_Abstract_Legacy_Product) get_related_terms(var_term rt.PhpVal) rt.PhpVal {
	rt.call_function('wc_deprecated_function', [
		rt.new_string('WC_Product::get_related_terms'),
		rt.new_string('3.0'),
		rt.new_string('wc_get_product_term_ids'),
	])
	return rt.call_function('array_merge', [
		rt.create_array([rt.ArrayItem{ key: none, val: 0 }]),
		rt.call_function('wc_get_product_term_ids', [this.get_id(),
			var_term.clone()]),
	])
}

fn (mut this Class_WC_Abstract_Legacy_Product) build_related_query(var_cats_array rt.PhpVal, var_tags_array rt.PhpVal, var_exclude_ids rt.PhpVal, var_limit rt.PhpVal) rt.PhpVal {
	rt.call_function('wc_deprecated_function', [
		rt.new_string('WC_Product::build_related_query'),
		rt.new_string('3.0'),
		rt.new_string('Product Data Store get_related_products_query'),
	])
	mut iife_temp_0 := Class_WC_Data_Store{}
	mut iife_result_0 := iife_temp_0.load(rt.new_string('product'))
	mut var_data_store := iife_result_0
	return rt.call_method(var_data_store, 'get_related_products_query', [
		var_cats_array.clone(), var_tags_array.clone(), var_exclude_ids.clone(),
		var_limit.clone()])
}

fn (mut this Class_WC_Abstract_Legacy_Product) get_child(var_child_id rt.PhpVal) rt.PhpVal {
	rt.call_function('wc_deprecated_function', [rt.new_string('WC_Product::get_child'),
		rt.new_string('3.0'), rt.new_string('wc_get_product')])
	return rt.call_function('wc_get_product', [var_child_id.clone()])
}

fn (mut this Class_WC_Abstract_Legacy_Product) get_price_html_from_text() rt.PhpVal {
	rt.call_function('wc_deprecated_function', [
		rt.new_string('WC_Product::get_price_html_from_text'),
		rt.new_string('3.0'),
		rt.new_string('wc_get_price_html_from_text'),
	])
	return rt.call_function('wc_get_price_html_from_text', []rt.PhpVal{})
}

fn (mut this Class_WC_Abstract_Legacy_Product) get_price_html_from_to(var_from rt.PhpVal, var_to rt.PhpVal) rt.PhpVal {
	rt.call_function('wc_deprecated_function', [
		rt.new_string('WC_Product::get_price_html_from_to'),
		rt.new_string('3.0'),
		rt.new_string('wc_format_sale_price'),
	])
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_get_price_html_from_to'),
		rt.call_function('wc_format_sale_price', [var_from.clone(),
			var_to.clone()]),
		var_from.clone(),
		var_to.clone(),
		rt.new_object('WC_Abstract_Legacy_Product', ['WC_Data'], &this),
	])
}

fn (mut this Class_WC_Abstract_Legacy_Product) list_attributes() {
	rt.call_function('wc_deprecated_function', [
		rt.new_string('WC_Product::list_attributes'),
		rt.new_string('3.0'),
		rt.new_string('wc_display_product_attributes'),
	])
	rt.call_function('wc_display_product_attributes', [
		rt.new_object('WC_Abstract_Legacy_Product', ['WC_Data'], &this),
	])
}

fn (mut this Class_WC_Abstract_Legacy_Product) get_price_including_tax(qty i64, price string) rt.PhpVal {
	rt.call_function('wc_deprecated_function', [
		rt.new_string('WC_Product::get_price_including_tax'),
		rt.new_string('3.0'),
		rt.new_string('wc_get_price_including_tax'),
	])
	return rt.call_function('wc_get_price_including_tax', [
		rt.new_object('WC_Abstract_Legacy_Product', ['WC_Data'], &this),
		rt.create_array([rt.ArrayItem{ key: 'qty', val: qty },
			rt.ArrayItem{ key: 'price', val: price }]),
	])
}

fn (mut this Class_WC_Abstract_Legacy_Product) get_display_price(price string, qty i64) rt.PhpVal {
	rt.call_function('wc_deprecated_function', [
		rt.new_string('WC_Product::get_display_price'),
		rt.new_string('3.0'),
		rt.new_string('wc_get_price_to_display'),
	])
	return rt.call_function('wc_get_price_to_display', [
		rt.new_object('WC_Abstract_Legacy_Product', ['WC_Data'], &this),
		rt.create_array([rt.ArrayItem{ key: 'qty', val: qty },
			rt.ArrayItem{ key: 'price', val: price }]),
	])
}

fn (mut this Class_WC_Abstract_Legacy_Product) get_price_excluding_tax(qty i64, price string) rt.PhpVal {
	rt.call_function('wc_deprecated_function', [
		rt.new_string('WC_Product::get_price_excluding_tax'),
		rt.new_string('3.0'),
		rt.new_string('wc_get_price_excluding_tax'),
	])
	return rt.call_function('wc_get_price_excluding_tax', [
		rt.new_object('WC_Abstract_Legacy_Product', ['WC_Data'], &this),
		rt.create_array([rt.ArrayItem{ key: 'qty', val: qty },
			rt.ArrayItem{ key: 'price', val: price }]),
	])
}

fn (mut this Class_WC_Abstract_Legacy_Product) adjust_price(var_price rt.PhpVal) {
	rt.call_function('wc_deprecated_function', [
		rt.new_string('WC_Product::adjust_price'),
		rt.new_string('3.0'),
		rt.new_string('WC_Product::set_price / WC_Product::get_price'),
	])
	rt.get_property(rt.new_object('WC_Abstract_Legacy_Product', ['WC_Data'], &this), 'data').array_set('price', rt.add(rt.get_property(rt.new_object('WC_Abstract_Legacy_Product', [
		'WC_Data',
	], &this), 'data').array_get(rt.new_string('price')), var_price))
}

fn (mut this Class_WC_Abstract_Legacy_Product) get_categories(sep string, before string, after string) rt.PhpVal {
	rt.call_function('wc_deprecated_function', [
		rt.new_string('WC_Product::get_categories'),
		rt.new_string('3.0'),
		rt.new_string('wc_get_product_category_list'),
	])
	return rt.call_function('wc_get_product_category_list', [
		this.get_id(), rt.new_string(sep), rt.new_string(before),
		rt.new_string(after)])
}

fn (mut this Class_WC_Abstract_Legacy_Product) get_tags(sep string, before string, after string) rt.PhpVal {
	rt.call_function('wc_deprecated_function', [rt.new_string('WC_Product::get_tags'),
		rt.new_string('3.0'), rt.new_string('wc_get_product_tag_list')])
	return rt.call_function('wc_get_product_tag_list', [this.get_id(),
		rt.new_string(sep), rt.new_string(before), rt.new_string(after)])
}

fn (mut this Class_WC_Abstract_Legacy_Product) get_post_data() rt.PhpVal {
	rt.call_function('wc_deprecated_function', [
		rt.new_string('WC_Product::get_post_data'),
		rt.new_string('3.0'),
		rt.new_string('get_post'),
	])
	if rt.is_true(this.is_type(Class_Automattic_WooCommerce_Enums_ProductType.variation())) {
		mut var_post_data := rt.call_function('get_post', [this.get_parent_id()])
	} else {
		var_post_data = rt.call_function('get_post', [this.get_id()])
	}
	return var_post_data.clone()
}

fn (mut this Class_WC_Abstract_Legacy_Product) get_parent() rt.PhpVal {
	rt.call_function('wc_deprecated_function', [rt.new_string('WC_Product::get_parent'),
		rt.new_string('3.0'), rt.new_string('WC_Product::get_parent_id')])
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_product_parent'),
		rt.call_function('absint', [rt.get_property(this.get_post_data(), 'post_parent')]),
		rt.new_object('WC_Abstract_Legacy_Product', ['WC_Data'], &this),
	])
}

fn (mut this Class_WC_Abstract_Legacy_Product) get_upsells() rt.PhpVal {
	rt.call_function('wc_deprecated_function', [rt.new_string('WC_Product::get_upsells'),
		rt.new_string('3.0'), rt.new_string('WC_Product::get_upsell_ids')])
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_product_upsell_ids'),
		this.get_upsell_ids(),
		rt.new_object('WC_Abstract_Legacy_Product', ['WC_Data'], &this),
	])
}

fn (mut this Class_WC_Abstract_Legacy_Product) get_cross_sells() rt.PhpVal {
	rt.call_function('wc_deprecated_function', [
		rt.new_string('WC_Product::get_cross_sells'),
		rt.new_string('3.0'),
		rt.new_string('WC_Product::get_cross_sell_ids'),
	])
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_product_crosssell_ids'),
		this.get_cross_sell_ids(),
		rt.new_object('WC_Abstract_Legacy_Product', ['WC_Data'], &this),
	])
}

fn (mut this Class_WC_Abstract_Legacy_Product) has_default_attributes() bool {
	rt.call_function('wc_deprecated_function', [
		rt.new_string('WC_Product_Variable::has_default_attributes'),
		rt.new_string('3.0'),
		rt.new_string('a check against WC_Product::get_default_attributes directly'),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(this.get_default_attributes())))) {
		return true
	}
	return false
}

fn (mut this Class_WC_Abstract_Legacy_Product) get_variation_id() rt.PhpVal {
	rt.call_function('wc_deprecated_function', [
		rt.new_string('WC_Product::get_variation_id'),
		rt.new_string('3.0'),
		rt.new_string('WC_Product::get_id(). It will always be the variation ID if this is a variation.'),
	])
	return this.get_id()
}

fn (mut this Class_WC_Abstract_Legacy_Product) get_variation_description() rt.PhpVal {
	rt.call_function('wc_deprecated_function', [
		rt.new_string('WC_Product::get_variation_description'),
		rt.new_string('3.0'),
		rt.new_string('WC_Product::get_description()'),
	])
	return this.get_description()
}

fn (mut this Class_WC_Abstract_Legacy_Product) has_all_attributes_set() rt.PhpVal {
	rt.call_function('wc_deprecated_function', [
		rt.new_string('WC_Product::has_all_attributes_set'),
		rt.new_string('3.0'),
		rt.new_string('an array filter on get_variation_attributes for a quick solution.'),
	])
	mut var_set := rt.new_bool(true)
	mut iter_1 := this.get_variation_attributes().iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_att := item_1.val
		if rt.is_true(rt.new_bool(!(rt.is_true(var_att)))) {
			var_set = rt.new_bool(false)
			break
		}
	}
	return var_set.clone()
}

fn (mut this Class_WC_Abstract_Legacy_Product) parent_is_visible() rt.PhpVal {
	rt.call_function('wc_deprecated_function', [
		rt.new_string('WC_Product::parent_is_visible'),
		rt.new_string('3.0'),
	])
	return this.is_visible()
}

fn (mut this Class_WC_Abstract_Legacy_Product) get_total_stock() rt.PhpVal {
	rt.call_function('wc_deprecated_function', [
		rt.new_string('WC_Product::get_total_stock'),
		rt.new_string('3.0'),
		rt.new_string('get_stock_quantity on each child. Beware of performance issues in doing so.'),
	])
	if this.get_children().array_count() > 0 {
		mut var_total_stock := rt.call_function('max', [rt.new_int(0),
			this.get_stock_quantity()])
		mut iter_2 := this.get_children().iterator()
		for {
			item_2 := iter_2.next() or { break }
			mut var_child_id := item_2.val
			if rt.is_true(rt.identical(rt.new_string('yes'), rt.call_function('get_post_meta', [
				var_child_id.clone(),
				rt.new_string('_manage_stock'),
				rt.new_bool(true),
			])))
			{
				mut var_stock := rt.call_function('get_post_meta', [
					var_child_id.clone(), rt.new_string('_stock'),
					rt.new_bool(true)])
				var_total_stock = rt.add(var_total_stock, rt.call_function('max', [
					rt.new_int(0),
					rt.call_function('wc_stock_amount', [var_stock.clone()]),
				]))
			}
		}
	} else {
		var_total_stock = this.get_stock_quantity()
	}
	return rt.call_function('wc_stock_amount', [var_total_stock.clone()])
}

fn (mut this Class_WC_Abstract_Legacy_Product) get_formatted_variation_attributes(flat bool) rt.PhpVal {
	rt.call_function('wc_deprecated_function', [
		rt.new_string('WC_Product::get_formatted_variation_attributes'),
		rt.new_string('3.0'),
		rt.new_string('wc_get_formatted_variation'),
	])
	return rt.call_function('wc_get_formatted_variation', [
		rt.new_object('WC_Abstract_Legacy_Product', ['WC_Data'], &this),
		rt.new_bool(flat),
	])
}

fn (mut this Class_WC_Abstract_Legacy_Product) variable_product_sync(product_id i64) {
	mut product_id_mutated := product_id
	rt.call_function('wc_deprecated_function', [
		rt.new_string('WC_Product::variable_product_sync'),
		rt.new_string('3.0'),
	])
	if product_id_mutated == 0 {
		product_id_mutated = (this.get_id()).to_i64()
	}
	if rt.is_true(rt.call_function('is_callable', [
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'sync' }]),
	]))
	{
		mut iife_temp_1 := Class_WC_Abstract_Legacy_Product{}
		mut iife_result_1 := iife_temp_1.sync(rt.new_int(product_id_mutated))
	}
}

fn Class_WC_Abstract_Legacy_Product.sync_attributes(var_product rt.PhpVal, children bool) {
	mut var_product_mutated := var_product
	mut children_mutated := children
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_a', [
		var_product_mutated.clone(), rt.new_string('WC_Product')])))))
	{
		var_product_mutated = rt.call_function('wc_get_product', [
			var_product_mutated.clone()])
	}
	if rt.is_true(rt.call_function('version_compare', [
		rt.call_function('get_post_meta', [
			rt.call_method(var_product_mutated, 'get_id', []rt.PhpVal{}),
			rt.new_string('_product_version'),
			rt.new_bool(true),
		]),
		rt.new_string('2.4.0'),
		rt.new_string('<'),
	]))
	{
		mut var_parent_attributes := rt.call_function('array_filter', [
			rt.cast_array(rt.call_function('get_post_meta', [
				rt.call_method(var_product_mutated, 'get_id', []rt.PhpVal{}),
				rt.new_string('_product_attributes'),
				rt.new_bool(true),
			])),
		])
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(children_mutated))))) {
			children_mutated = (rt.call_method(var_product_mutated, 'get_children', [
				rt.new_string('edit'),
			])).to_bool()
		}
		mut iter_3 := rt.new_bool(children_mutated).iterator()
		for {
			item_3 := iter_3.next() or { break }
			mut var_child_id := item_3.val
			mut var_all_meta := rt.call_function('get_post_meta', [
				var_child_id.clone()])
			mut iter_4 := var_all_meta.iterator()
			for {
				item_4 := iter_4.next() or { break }
				mut var_value := item_4.val
				mut var_name := item_4.key
				if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int(0), rt.call_function('strpos', [
					var_name.clone(),
					rt.new_string('attribute_'),
				])))))
				{
					continue
				}
				if rt.is_true(rt.identical(rt.call_function('sanitize_title', [
					var_value.array_get(rt.new_int(0)),
				]), var_value.array_get(rt.new_int(0))))
				{
					mut iter_5 := var_parent_attributes.iterator()
					for {
						item_5 := iter_5.next() or { break }
						mut var_attribute := item_5.val
						if rt.is_true(rt.new_bool(!rt.is_true(rt.identical('attribute_' +(rt.call_function('sanitize_title', [var_attribute.array_get(rt.new_string('name'))])).str(),
							var_name))))
						{
							continue
						}
						mut var_text_attributes := rt.call_function('wc_get_text_attributes', [
							var_attribute.array_get(rt.new_string('value')),
						])
						mut iter_6 := var_text_attributes.iterator()
						for {
							item_6 := iter_6.next() or { break }
							mut var_text_attribute := item_6.val
							if rt.is_true(rt.identical(rt.call_function('sanitize_title', [
								var_text_attribute.clone(),
							]), var_value.array_get(rt.new_int(0))))
							{
								rt.call_function('update_post_meta', [
									var_child_id.clone(), var_name.clone(),
									var_text_attribute.clone()])
								break
							}
						}
					}
				}
			}
		}
	}
}

fn (mut this Class_WC_Abstract_Legacy_Product) get_matching_variation(var_match_attributes rt.PhpVal) rt.PhpVal {
	rt.call_function('wc_deprecated_function', [
		rt.new_string('WC_Product::get_matching_variation'),
		rt.new_string('3.0'),
		rt.new_string('Product data store find_matching_product_variation'),
	])
	mut iife_temp_2 := Class_WC_Data_Store{}
	mut iife_result_2 := iife_temp_2.load(rt.new_string('product'))
	mut var_data_store := iife_result_2
	return rt.call_method(var_data_store, 'find_matching_product_variation', [
		rt.new_object('WC_Abstract_Legacy_Product', ['WC_Data'], &this),
		var_match_attributes.clone(),
	])
}

fn (mut this Class_WC_Abstract_Legacy_Product) enable_dimensions_display() bool {
	rt.call_function('wc_deprecated_function', [
		rt.new_string('WC_Product::enable_dimensions_display'),
		rt.new_string('3.0'),
	])
	return
		rt.is_true(rt.call_function('apply_filters', [rt.new_string('wc_product_enable_dimensions_display'), rt.new_bool(true)]))
		&& rt.is_true(this.has_dimensions()) || rt.is_true(this.has_weight())
		|| rt.is_true(this.child_has_weight())
		|| rt.is_true(this.child_has_dimensions())
}

fn (mut this Class_WC_Abstract_Legacy_Product) get_rating_html(var_rating rt.PhpVal) rt.PhpVal {
	rt.call_function('wc_deprecated_function', [
		rt.new_string('WC_Product::get_rating_html'),
		rt.new_string('3.0'),
		rt.new_string('wc_get_rating_html'),
	])
	return rt.call_function('wc_get_rating_html', [var_rating.clone()])
}

fn Class_WC_Abstract_Legacy_Product.sync_average_rating(var_post_id rt.PhpVal) {
	rt.call_function('wc_deprecated_function', [
		rt.new_string('WC_Product::sync_average_rating'),
		rt.new_string('3.0'),
		rt.new_string('WC_Comments::get_average_rating_for_product or leave to CRUD.'),
	])
	Class_WC_Abstract_Legacy_Product.sync_rating_count(var_post_id.clone())
	mut iife_temp_3 := Class_WC_Comments{}
	mut iife_result_3 := iife_temp_3.get_average_rating_for_product(rt.call_function('wc_get_product', [
		var_post_id.clone(),
	]))
	mut var_average := iife_result_3
	rt.call_function('update_post_meta', [var_post_id.clone(),
		rt.new_string('_wc_average_rating'), var_average.clone()])
}

fn Class_WC_Abstract_Legacy_Product.sync_rating_count(var_post_id rt.PhpVal) {
	rt.call_function('wc_deprecated_function', [
		rt.new_string('WC_Product::sync_rating_count'),
		rt.new_string('3.0'),
		rt.new_string('WC_Comments::get_rating_counts_for_product or leave to CRUD.'),
	])
	mut iife_temp_4 := Class_WC_Comments{}
	mut iife_result_4 := iife_temp_4.get_rating_counts_for_product(rt.call_function('wc_get_product', [
		var_post_id.clone(),
	]))
	mut var_counts := iife_result_4
	rt.call_function('update_post_meta', [var_post_id.clone(),
		rt.new_string('_wc_rating_count'), var_counts.clone()])
}

fn (mut this Class_WC_Abstract_Legacy_Product) get_files() rt.PhpVal {
	rt.call_function('wc_deprecated_function', [rt.new_string('WC_Product::get_files'),
		rt.new_string('3.0'), rt.new_string('WC_Product::get_downloads')])
	return this.get_downloads()
}

fn (mut this Class_WC_Abstract_Legacy_Product) grouped_product_sync() {
	rt.call_function('wc_deprecated_function', [
		rt.new_string('WC_Product::grouped_product_sync'),
		rt.new_string('3.0'),
	])
}

struct Class_WC_Data {
	rt.PhpObjectBase
}

struct Class_WC_Data_Store {
	rt.PhpObjectBase
}

struct Class_WC_Comments {
	rt.PhpObjectBase
}

fn create_wc_abstract_legacy_product(_args ...rt.PhpVal) &Class_WC_Abstract_Legacy_Product {
	mut obj := &Class_WC_Abstract_Legacy_Product{
		PhpObjectBase: rt.PhpObjectBase{}
	}
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

fn create_wc_comments(_args ...rt.PhpVal) &Class_WC_Comments {
	mut obj := &Class_WC_Comments{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Abstract_Legacy_Product) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__isset' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.magic_isset(dispatch_arg_0))
		}
		'__get' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.magic_get(dispatch_arg_0)
		}
		'get_variation_default_attributes' {
			return this.get_variation_default_attributes()
		}
		'get_gallery_attachment_ids' {
			return this.get_gallery_attachment_ids()
		}
		'set_stock' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return this.set_stock(dispatch_arg_0, dispatch_arg_1)
		}
		'reduce_stock' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			return this.reduce_stock(dispatch_arg_0)
		}
		'increase_stock' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			return this.increase_stock(dispatch_arg_0)
		}
		'check_stock_status' {
			this.check_stock_status()
			return rt.new_null()
		}
		'get_related' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			return this.get_related(dispatch_arg_0)
		}
		'get_related_terms' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_related_terms(dispatch_arg_0)
		}
		'build_related_query' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			return this.build_related_query(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2,
				dispatch_arg_3)
		}
		'get_child' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_child(dispatch_arg_0)
		}
		'get_price_html_from_text' {
			return this.get_price_html_from_text()
		}
		'get_price_html_from_to' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.get_price_html_from_to(dispatch_arg_0, dispatch_arg_1)
		}
		'list_attributes' {
			this.list_attributes()
			return rt.new_null()
		}
		'get_price_including_tax' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return this.get_price_including_tax(dispatch_arg_0, dispatch_arg_1)
		}
		'get_display_price' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			return this.get_display_price(dispatch_arg_0, dispatch_arg_1)
		}
		'get_price_excluding_tax' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return this.get_price_excluding_tax(dispatch_arg_0, dispatch_arg_1)
		}
		'adjust_price' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.adjust_price(dispatch_arg_0)
			return rt.new_null()
		}
		'get_categories' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			return this.get_categories(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'get_tags' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			return this.get_tags(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'get_post_data' {
			return this.get_post_data()
		}
		'get_parent' {
			return this.get_parent()
		}
		'get_upsells' {
			return this.get_upsells()
		}
		'get_cross_sells' {
			return this.get_cross_sells()
		}
		'has_default_attributes' {
			return rt.new_bool(this.has_default_attributes())
		}
		'get_variation_id' {
			return this.get_variation_id()
		}
		'get_variation_description' {
			return this.get_variation_description()
		}
		'has_all_attributes_set' {
			return this.has_all_attributes_set()
		}
		'parent_is_visible' {
			return this.parent_is_visible()
		}
		'get_total_stock' {
			return this.get_total_stock()
		}
		'get_formatted_variation_attributes' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			return this.get_formatted_variation_attributes(dispatch_arg_0)
		}
		'variable_product_sync' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			this.variable_product_sync(dispatch_arg_0)
			return rt.new_null()
		}
		'sync_attributes' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			Class_WC_Abstract_Legacy_Product.sync_attributes(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'get_matching_variation' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_matching_variation(dispatch_arg_0)
		}
		'enable_dimensions_display' {
			return rt.new_bool(this.enable_dimensions_display())
		}
		'get_rating_html' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_rating_html(dispatch_arg_0)
		}
		'sync_average_rating' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			Class_WC_Abstract_Legacy_Product.sync_average_rating(dispatch_arg_0)
			return rt.new_null()
		}
		'sync_rating_count' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			Class_WC_Abstract_Legacy_Product.sync_rating_count(dispatch_arg_0)
			return rt.new_null()
		}
		'get_files' {
			return this.get_files()
		}
		'grouped_product_sync' {
			this.grouped_product_sync()
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_Abstract_Legacy_Product) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Abstract_Legacy_Product) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
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

fn (mut this Class_WC_Comments) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Comments) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Comments) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
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

	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		exit(0)
	}
}
