import rt

struct Class_WC_Product {
	rt.PhpObjectBase
pub mut:
		object_type rt.PhpVal = rt.new_string('product')
		post_type rt.PhpVal = rt.new_string('product')
		cache_group rt.PhpVal = rt.new_string('products')
		data rt.PhpVal = rt.new_array()
		supports rt.PhpVal = rt.new_array()
}

fn (mut this Class_WC_Product) construct(product i64) {
	this.Class_WC_Abstract_Legacy_Product.construct(rt.new_int(product))
	if rt.new_int(product).is_long() || rt.new_int(product).is_double() && product > 0 {
		this.set_id(rt.new_int(product))
	} else if rt.is_true(rt.new_bool(rt.instance_of(rt.new_int(product), 'self'))) {
		this.set_id(rt.call_function('absint', [rt.call_method(rt.new_int(product), 'get_id', []rt.PhpVal{})]))
	} else if !(!rt.is_true(rt.get_property(rt.new_int(product), 'ID'))) {
		this.set_id(rt.call_function('absint', [rt.get_property(rt.new_int(product), 'ID')]))
	} else {
		this.set_object_read(rt.new_bool(true))
	}
	mut iife_temp_0 := Class_WC_Data_Store{}
	mut iife_result_0 := iife_temp_0.load(rt.new_string('product-' + (this.get_type()).str()))
	this.dispatch_set_prop('data_store', iife_result_0)
	if rt.is_true(rt.greater(this.get_id(), rt.new_int(0))) {
		rt.call_method(rt.get_property(rt.new_object('WC_Product', ['WC_Abstract_Legacy_Product'], &this), 'data_store'), 'read', [rt.new_object('WC_Product', ['WC_Abstract_Legacy_Product'], &this)])
	}
}

fn (mut this Class_WC_Product) get_type() rt.PhpVal {
	return if !(rt.get_property(rt.new_object('WC_Product', ['WC_Abstract_Legacy_Product'], &this), 'product_type')).is_null() { rt.get_property(rt.new_object('WC_Product', ['WC_Abstract_Legacy_Product'], &this), 'product_type') } else { Class_Automattic_WooCommerce_Enums_ProductType.simple() }
}

fn (mut this Class_WC_Product) get_name(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('name'), rt.new_string(context))
}

fn (mut this Class_WC_Product) get_slug(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('slug'), rt.new_string(context))
}

fn (mut this Class_WC_Product) get_date_created(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('date_created'), rt.new_string(context))
}

fn (mut this Class_WC_Product) get_date_modified(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('date_modified'), rt.new_string(context))
}

fn (mut this Class_WC_Product) get_status(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('status'), rt.new_string(context))
}

fn (mut this Class_WC_Product) get_featured(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('featured'), rt.new_string(context))
}

fn (mut this Class_WC_Product) get_catalog_visibility(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('catalog_visibility'), rt.new_string(context))
}

fn (mut this Class_WC_Product) get_description(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('description'), rt.new_string(context))
}

fn (mut this Class_WC_Product) get_short_description(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('short_description'), rt.new_string(context))
}

fn (mut this Class_WC_Product) get_sku(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('sku'), rt.new_string(context))
}

fn (mut this Class_WC_Product) get_global_unique_id(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('global_unique_id'), rt.new_string(context))
}

fn (mut this Class_WC_Product) get_price(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('price'), rt.new_string(context))
}

fn (mut this Class_WC_Product) get_regular_price(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('regular_price'), rt.new_string(context))
}

fn (mut this Class_WC_Product) get_sale_price(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('sale_price'), rt.new_string(context))
}

fn (mut this Class_WC_Product) get_date_on_sale_from(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('date_on_sale_from'), rt.new_string(context))
}

fn (mut this Class_WC_Product) get_date_on_sale_to(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('date_on_sale_to'), rt.new_string(context))
}

fn (mut this Class_WC_Product) get_total_sales(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('total_sales'), rt.new_string(context))
}

fn (mut this Class_WC_Product) get_tax_status(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('tax_status'), rt.new_string(context))
}

fn (mut this Class_WC_Product) get_tax_class(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('tax_class'), rt.new_string(context))
}

fn (mut this Class_WC_Product) get_manage_stock(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('manage_stock'), rt.new_string(context))
}

fn (mut this Class_WC_Product) get_stock_quantity(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('stock_quantity'), rt.new_string(context))
}

fn (mut this Class_WC_Product) get_stock_status(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('stock_status'), rt.new_string(context))
}

fn (mut this Class_WC_Product) get_backorders(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('backorders'), rt.new_string(context))
}

fn (mut this Class_WC_Product) get_low_stock_amount(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('low_stock_amount'), rt.new_string(context))
}

fn (mut this Class_WC_Product) get_sold_individually(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('sold_individually'), rt.new_string(context))
}

fn (mut this Class_WC_Product) get_weight(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('weight'), rt.new_string(context))
}

fn (mut this Class_WC_Product) get_length(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('length'), rt.new_string(context))
}

fn (mut this Class_WC_Product) get_width(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('width'), rt.new_string(context))
}

fn (mut this Class_WC_Product) get_height(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('height'), rt.new_string(context))
}

fn (mut this Class_WC_Product) get_dimensions(formatted bool) rt.PhpVal {
	if var_formatted {
		rt.call_function('wc_deprecated_argument', [rt.new_string('WC_Product::get_dimensions'), rt.new_string('3.0'), rt.new_string('By default, get_dimensions has an argument set to true so that HTML is returned. This is to support the legacy version of the method. To get HTML dimensions, instead use wc_format_dimensions() function. Pass false to this method to return an array of dimensions. This will be the new default behavior in future versions.')])
		return rt.call_function('apply_filters', [rt.new_string('woocommerce_product_dimensions'), rt.call_function('wc_format_dimensions', [this.get_dimensions(false)]), rt.new_object('WC_Product', ['WC_Abstract_Legacy_Product'], &this)])
	}
	return rt.create_array([rt.ArrayItem{ key: 'length', val: this.get_length('') }, rt.ArrayItem{ key: 'width', val: this.get_width('') }, rt.ArrayItem{ key: 'height', val: this.get_height('') }])
}

fn (mut this Class_WC_Product) get_upsell_ids(context string) rt.PhpVal {
	return rt.call_function('array_map', [rt.new_string('absint'), this.get_prop(rt.new_string('upsell_ids'), rt.new_string(context))])
}

fn (mut this Class_WC_Product) get_cross_sell_ids(context string) rt.PhpVal {
	return rt.call_function('array_map', [rt.new_string('absint'), this.get_prop(rt.new_string('cross_sell_ids'), rt.new_string(context))])
}

fn (mut this Class_WC_Product) get_parent_id(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('parent_id'), rt.new_string(context))
}

fn (mut this Class_WC_Product) get_reviews_allowed(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('reviews_allowed'), rt.new_string(context))
}

fn (mut this Class_WC_Product) get_purchase_note(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('purchase_note'), rt.new_string(context))
}

fn (mut this Class_WC_Product) get_attributes(context string) rt.PhpVal {
	mut var_attributes := this.get_prop(rt.new_string('attributes'), rt.new_string(context))
	if !(var_attributes.clone().is_array()) {
		return rt.new_array()
	}
	return var_attributes.clone()
}

fn (mut this Class_WC_Product) get_default_attributes(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('default_attributes'), rt.new_string(context))
}

fn (mut this Class_WC_Product) get_menu_order(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('menu_order'), rt.new_string(context))
}

fn (mut this Class_WC_Product) get_post_password(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('post_password'), rt.new_string(context))
}

fn (mut this Class_WC_Product) get_category_ids(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('category_ids'), rt.new_string(context))
}

fn (mut this Class_WC_Product) get_tag_ids(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('tag_ids'), rt.new_string(context))
}

fn (mut this Class_WC_Product) get_brand_ids(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('brand_ids'), rt.new_string(context))
}

fn (mut this Class_WC_Product) get_virtual(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('virtual'), rt.new_string(context))
}

fn (mut this Class_WC_Product) get_gallery_image_ids(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('gallery_image_ids'), rt.new_string(context))
}

fn (mut this Class_WC_Product) get_shipping_class_id(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('shipping_class_id'), rt.new_string(context))
}

fn (mut this Class_WC_Product) get_downloads(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('downloads'), rt.new_string(context))
}

fn (mut this Class_WC_Product) get_download_expiry(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('download_expiry'), rt.new_string(context))
}

fn (mut this Class_WC_Product) get_downloadable(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('downloadable'), rt.new_string(context))
}

fn (mut this Class_WC_Product) get_download_limit(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('download_limit'), rt.new_string(context))
}

fn (mut this Class_WC_Product) get_image_id(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('image_id'), rt.new_string(context))
}

fn (mut this Class_WC_Product) get_rating_counts(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('rating_counts'), rt.new_string(context))
}

fn (mut this Class_WC_Product) get_average_rating(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('average_rating'), rt.new_string(context))
}

fn (mut this Class_WC_Product) get_review_count(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('review_count'), rt.new_string(context))
}

fn (mut this Class_WC_Product) set_name(var_name rt.PhpVal) {
	this.set_prop(rt.new_string('name'), var_name.clone())
}

fn (mut this Class_WC_Product) set_slug(var_slug rt.PhpVal) {
	this.set_prop(rt.new_string('slug'), var_slug.clone())
}

fn (mut this Class_WC_Product) set_date_created(var_date rt.PhpVal) {
	this.set_date_prop(rt.new_string('date_created'), var_date.clone())
}

fn (mut this Class_WC_Product) set_date_modified(var_date rt.PhpVal) {
	this.set_date_prop(rt.new_string('date_modified'), var_date.clone())
}

fn (mut this Class_WC_Product) set_status(var_status rt.PhpVal) {
	mut var_status_mutated := var_status
	this.set_prop(rt.new_string('status'), var_status_mutated.clone())
}

fn (mut this Class_WC_Product) set_featured(var_featured rt.PhpVal) {
	this.set_prop(rt.new_string('featured'), rt.call_function('wc_string_to_bool', [var_featured.clone()]))
}

fn (mut this Class_WC_Product) set_catalog_visibility(var_visibility rt.PhpVal) {
	mut var_visibility_mutated := var_visibility
	mut var_options := rt.func_array_keys(rt.call_function('wc_get_product_visibility_options', []rt.PhpVal{}))
	var_visibility_mutated = if rt.is_true(rt.call_function('in_array', [var_visibility_mutated.clone(), var_options.clone(), rt.new_bool(true)])) { var_visibility_mutated } else { rt.new_string(var_visibility_mutated.clone().to_string().to_lower()) }
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_visibility_mutated.clone(), var_options.clone(), rt.new_bool(true)]))))) {
		this.error(rt.new_string('product_invalid_catalog_visibility'), rt.call_function('__', [rt.new_string('Invalid catalog visibility option.'), rt.new_string('woocommerce')]))
	}
	this.set_prop(rt.new_string('catalog_visibility'), var_visibility_mutated.clone())
}

fn (mut this Class_WC_Product) set_description(var_description rt.PhpVal) {
	this.set_prop(rt.new_string('description'), var_description.clone())
}

fn (mut this Class_WC_Product) set_short_description(var_short_description rt.PhpVal) {
	this.set_prop(rt.new_string('short_description'), var_short_description.clone())
}

fn (mut this Class_WC_Product) set_sku(var_sku rt.PhpVal) {
	mut var_sku_mutated := var_sku
	var_sku_mutated = rt.new_string((var_sku_mutated).str())
	if rt.is_true(this.get_object_read()) && !(!rt.is_true(var_sku_mutated)) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_product_has_unique_sku', [this.get_id(), var_sku_mutated.clone()]))))) {
		mut var_sku_found := rt.call_function('wc_get_product_id_by_sku', [var_sku_mutated.clone()])
		this.error(rt.new_string('product_invalid_sku'), rt.call_function('__', [rt.new_string('Invalid or duplicated SKU.'), rt.new_string('woocommerce')]), rt.new_int(400), rt.create_array([rt.ArrayItem{ key: 'resource_id', val: var_sku_found }, rt.ArrayItem{ key: 'unique_sku', val: rt.call_function('wc_product_generate_unique_sku', [this.get_id(), var_sku_mutated.clone()]) }]))
	}
	this.set_prop(rt.new_string('sku'), var_sku_mutated.clone())
}

fn (mut this Class_WC_Product) set_global_unique_id(var_global_unique_id rt.PhpVal) {
	mut var_global_unique_id_mutated := var_global_unique_id
	var_global_unique_id_mutated = rt.call_function('preg_replace', [rt.new_string('/[^0-9\\-]/'), rt.new_string(''), rt.new_string((var_global_unique_id_mutated).str())])
	if rt.is_true(this.get_object_read()) && !(!rt.is_true(var_global_unique_id_mutated)) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_product_has_global_unique_id', [this.get_id(), var_global_unique_id_mutated.clone()]))))) {
		mut var_global_unique_id_found := rt.call_function('wc_get_product_id_by_global_unique_id', [var_global_unique_id_mutated.clone()])
		this.error(rt.new_string('product_invalid_global_unique_id'), rt.call_function('__', [rt.new_string('Invalid or duplicated GTIN, UPC, EAN or ISBN.'), rt.new_string('woocommerce')]), rt.new_int(400), rt.create_array([rt.ArrayItem{ key: 'resource_id', val: var_global_unique_id_found }]))
	}
	this.set_prop(rt.new_string('global_unique_id'), var_global_unique_id_mutated.clone())
}

fn (mut this Class_WC_Product) set_price(var_price rt.PhpVal) {
	mut var_price_mutated := var_price
	this.set_prop(rt.new_string('price'), rt.call_function('wc_format_decimal', [var_price_mutated.clone()]))
}

fn (mut this Class_WC_Product) set_regular_price(var_price rt.PhpVal) {
	mut var_price_mutated := var_price
	this.set_prop(rt.new_string('regular_price'), rt.call_function('wc_format_decimal', [var_price_mutated.clone()]))
}

fn (mut this Class_WC_Product) set_sale_price(var_price rt.PhpVal) {
	mut var_price_mutated := var_price
	this.set_prop(rt.new_string('sale_price'), rt.call_function('wc_format_decimal', [var_price_mutated.clone()]))
}

fn (mut this Class_WC_Product) set_date_on_sale_from(var_date rt.PhpVal) {
	this.set_date_prop(rt.new_string('date_on_sale_from'), var_date.clone())
}

fn (mut this Class_WC_Product) set_date_on_sale_to(var_date rt.PhpVal) {
	this.set_date_prop(rt.new_string('date_on_sale_to'), var_date.clone())
}

fn (mut this Class_WC_Product) set_total_sales(var_total rt.PhpVal) {
	this.set_prop(rt.new_string('total_sales'), rt.call_function('absint', [var_total.clone()]))
}

fn (mut this Class_WC_Product) set_tax_status(var_status rt.PhpVal) {
	mut var_status_mutated := var_status
	mut var_options := rt.create_array([rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_ProductTaxStatus.taxable() }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_ProductTaxStatus.shipping() }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_ProductTaxStatus.none() }])
	if !rt.is_true(var_status_mutated) {
	var_status_mutated = Class_Automattic_WooCommerce_Enums_ProductTaxStatus.taxable()
	}
	var_status_mutated = rt.new_string(var_status_mutated.clone().to_string().to_lower())
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_status_mutated.clone(), var_options.clone(), rt.new_bool(true)]))))) {
		this.error(rt.new_string('product_invalid_tax_status'), rt.call_function('__', [rt.new_string('Invalid product tax status.'), rt.new_string('woocommerce')]))
	}
	this.set_prop(rt.new_string('tax_status'), var_status_mutated.clone())
}

fn (mut this Class_WC_Product) set_tax_class(var_class rt.PhpVal) {
	mut var_class_mutated := var_class
	var_class_mutated = rt.call_function('sanitize_title', [var_class_mutated.clone()])
	var_class_mutated = if rt.is_true(rt.identical(rt.new_string('standard'), var_class_mutated)) { rt.new_string('') } else { var_class_mutated }
	mut var_valid_classes := this.get_valid_tax_classes()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_class_mutated.clone(), var_valid_classes.clone(), rt.new_bool(true)]))))) {
	var_class_mutated = rt.new_string('')
	}
	this.set_prop(rt.new_string('tax_class'), var_class_mutated.clone())
}

fn (mut this Class_WC_Product) get_valid_tax_classes() rt.PhpVal {
	mut iife_temp_1 := Class_WC_Tax{}
	mut iife_result_1 := iife_temp_1.get_tax_class_slugs()
	return iife_result_1
}

fn (mut this Class_WC_Product) set_manage_stock(var_manage_stock rt.PhpVal) {
	this.set_prop(rt.new_string('manage_stock'), rt.call_function('wc_string_to_bool', [var_manage_stock.clone()]))
}

fn (mut this Class_WC_Product) set_stock_quantity(var_quantity rt.PhpVal) {
	this.set_prop(rt.new_string('stock_quantity'), if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), var_quantity)))) { rt.call_function('wc_stock_amount', [var_quantity.clone()]) } else { rt.new_null() })
}

fn (mut this Class_WC_Product) set_stock_status(var_status rt.PhpVal) {
	mut var_status_mutated := var_status
	mut var_valid_statuses := rt.call_function('wc_get_product_stock_status_options', []rt.PhpVal{})
	if var_valid_statuses.array_isset(var_status_mutated) {
		this.set_prop(rt.new_string('stock_status'), var_status_mutated.clone())
	} else {
		this.set_prop(rt.new_string('stock_status'), Class_Automattic_WooCommerce_Enums_ProductStockStatus.in_stock())
	}
}

fn (mut this Class_WC_Product) set_backorders(var_backorders rt.PhpVal) {
	this.set_prop(rt.new_string('backorders'), var_backorders.clone())
}

fn (mut this Class_WC_Product) set_low_stock_amount(var_amount rt.PhpVal) {
	this.set_prop(rt.new_string('low_stock_amount'), if rt.is_true(rt.identical(rt.new_string(''), var_amount)) { rt.new_string('') } else { rt.call_function('absint', [var_amount.clone()]) })
}

fn (mut this Class_WC_Product) set_sold_individually(var_sold_individually rt.PhpVal) {
	this.set_prop(rt.new_string('sold_individually'), rt.call_function('wc_string_to_bool', [var_sold_individually.clone()]))
}

fn (mut this Class_WC_Product) set_weight(var_weight rt.PhpVal) {
	this.set_prop(rt.new_string('weight'), if rt.is_true(rt.identical(rt.new_string(''), var_weight)) { rt.new_string('') } else { rt.call_function('wc_format_decimal', [var_weight.clone()]) })
}

fn (mut this Class_WC_Product) set_length(var_length rt.PhpVal) {
	this.set_prop(rt.new_string('length'), if rt.is_true(rt.identical(rt.new_string(''), var_length)) { rt.new_string('') } else { rt.call_function('wc_format_decimal', [var_length.clone()]) })
}

fn (mut this Class_WC_Product) set_width(var_width rt.PhpVal) {
	this.set_prop(rt.new_string('width'), if rt.is_true(rt.identical(rt.new_string(''), var_width)) { rt.new_string('') } else { rt.call_function('wc_format_decimal', [var_width.clone()]) })
}

fn (mut this Class_WC_Product) set_height(var_height rt.PhpVal) {
	this.set_prop(rt.new_string('height'), if rt.is_true(rt.identical(rt.new_string(''), var_height)) { rt.new_string('') } else { rt.call_function('wc_format_decimal', [var_height.clone()]) })
}

fn (mut this Class_WC_Product) set_upsell_ids(var_upsell_ids rt.PhpVal) {
	this.set_prop(rt.new_string('upsell_ids'), rt.call_function('array_filter', [rt.cast_array(var_upsell_ids)]))
}

fn (mut this Class_WC_Product) set_cross_sell_ids(var_cross_sell_ids rt.PhpVal) {
	this.set_prop(rt.new_string('cross_sell_ids'), rt.call_function('array_filter', [rt.cast_array(var_cross_sell_ids)]))
}

fn (mut this Class_WC_Product) set_parent_id(var_parent_id rt.PhpVal) {
	mut var_parent_id_mutated := var_parent_id
	this.set_prop(rt.new_string('parent_id'), rt.call_function('absint', [var_parent_id_mutated.clone()]))
}

fn (mut this Class_WC_Product) set_reviews_allowed(var_reviews_allowed rt.PhpVal) {
	this.set_prop(rt.new_string('reviews_allowed'), rt.call_function('wc_string_to_bool', [var_reviews_allowed.clone()]))
}

fn (mut this Class_WC_Product) set_purchase_note(var_purchase_note rt.PhpVal) {
	this.set_prop(rt.new_string('purchase_note'), var_purchase_note.clone())
}

fn (mut this Class_WC_Product) set_attributes(var_raw_attributes rt.PhpVal) {
	mut var_attributes := rt.call_function('array_fill_keys', [rt.func_array_keys(this.get_attributes('edit')), rt.new_null()])
	mut iter_1 := var_raw_attributes.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_attribute := item_1.val
		if rt.is_true(rt.call_function('is_a', [var_attribute.clone(), rt.new_string('WC_Product_Attribute')])) {
			var_attributes.array_set(rt.call_function('sanitize_title', [rt.call_method(var_attribute, 'get_name', []rt.PhpVal{})]), var_attribute.clone())
		}
	}
	rt.call_function('uasort', [var_attributes.clone(), rt.new_string('wc_product_attribute_uasort_comparison')])
	this.set_prop(rt.new_string('attributes'), var_attributes.clone())
}

fn (mut this Class_WC_Product) set_default_attributes(var_default_attributes rt.PhpVal) {
	this.set_prop(rt.new_string('default_attributes'), rt.call_function('array_map', [rt.new_string('strval'), rt.call_function('array_filter', [rt.cast_array(var_default_attributes), rt.new_string('wc_array_filter_default_attributes')])]))
}

fn (mut this Class_WC_Product) set_menu_order(var_menu_order rt.PhpVal) {
	this.set_prop(rt.new_string('menu_order'), rt.new_int(var_menu_order.clone().to_i64()))
}

fn (mut this Class_WC_Product) set_post_password(var_post_password rt.PhpVal) {
	this.set_prop(rt.new_string('post_password'), var_post_password.clone())
}

fn (mut this Class_WC_Product) set_category_ids(var_term_ids rt.PhpVal) {
	this.set_prop(rt.new_string('category_ids'), rt.call_function('array_unique', [rt.call_function('array_map', [rt.new_string('intval'), var_term_ids.clone()])]))
}

fn (mut this Class_WC_Product) set_tag_ids(var_term_ids rt.PhpVal) {
	this.set_prop(rt.new_string('tag_ids'), rt.call_function('array_unique', [rt.call_function('array_map', [rt.new_string('intval'), var_term_ids.clone()])]))
}

fn (mut this Class_WC_Product) set_brand_ids(var_term_ids rt.PhpVal) {
	this.set_prop(rt.new_string('brand_ids'), rt.call_function('array_unique', [rt.call_function('array_map', [rt.new_string('intval'), var_term_ids.clone()])]))
}

fn (mut this Class_WC_Product) set_virtual(var_virtual rt.PhpVal) {
	this.set_prop(rt.new_string('virtual'), rt.call_function('wc_string_to_bool', [var_virtual.clone()]))
}

fn (mut this Class_WC_Product) set_shipping_class_id(var_id rt.PhpVal) {
	this.set_prop(rt.new_string('shipping_class_id'), rt.call_function('absint', [var_id.clone()]))
}

fn (mut this Class_WC_Product) set_downloadable(var_downloadable rt.PhpVal) {
	this.set_prop(rt.new_string('downloadable'), rt.call_function('wc_string_to_bool', [var_downloadable.clone()]))
}

fn (mut this Class_WC_Product) set_downloads(var_downloads_array rt.PhpVal) {
	mut var_downloads_array_mutated := var_downloads_array
	mut var_existing_downloads := if rt.is_true(this.get_object_read()) { rt.cast_array(this.get_prop(rt.new_string('downloads'))) } else { var_downloads_array_mutated }
	mut var_downloads := rt.new_array()
	mut var_errors := rt.new_array()
	var_downloads_array_mutated = this.build_downloads_map(mut rt.cast_object_ptr[Class_array](var_downloads_array_mutated))
	var_existing_downloads = this.build_downloads_map(mut rt.cast_object_ptr[Class_array](var_existing_downloads))
	mut iter_2 := var_downloads_array_mutated.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_download := item_2.val
		mut var_download_id := rt.call_method(var_download, 'get_id', []rt.PhpVal{})
		mut var_is_new := rt.new_bool(!(var_existing_downloads.array_isset(var_download_id)))
		mut var_has_changed := rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_is_new)))) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_method(var_existing_downloads.array_get(var_download_id), 'get_file', []rt.PhpVal{}), rt.call_method(var_downloads_array_mutated.array_get(var_download_id), 'get_file', []rt.PhpVal{}))))))
		rt.call_method(var_download, 'check_is_valid', [this.get_object_read()])
		if rt.has_exception() { unsafe { goto catch_label_1 } }
		var_downloads.array_set(var_download_id, var_download.clone())
		if rt.has_exception() { unsafe { goto catch_label_1 } }
		unsafe { goto end_label_1 }

catch_label_1:
		mut var_e_1 := rt.get_and_clear_exception()
		if rt.instance_of(var_e_1, 'Exception') {
			mut var_e := var_e_1.clone()
			if rt.is_true(var_is_new) || rt.is_true(var_has_changed) {
				var_errors << rt.call_method(var_e, 'getMessage', []rt.PhpVal{})
			}
			if rt.is_true(rt.new_bool(!(rt.is_true(var_is_new)))) {
				rt.call_method(var_download, 'set_enabled', [rt.new_bool(false)])
				var_downloads.array_set(var_download_id, var_download.clone())
			}
			unsafe { goto end_label_1 }
		}
		else {
			rt.throw_exception(var_e_1)
			unsafe { goto end_label_1 }
		}

end_label_1:
	}
	this.set_prop(rt.new_string('downloads'), var_downloads.clone())
	if rt.is_true(var_errors) && rt.is_true(this.get_object_read()) {
		this.error(rt.new_string('product_invalid_download'), var_errors[0])
	}
}

fn (mut this Class_WC_Product) build_downloads_map(mut var_downloads Class_array) rt.PhpVal {
	mut var_downloads_mutated := var_downloads
	mut var_downloads_map := rt.new_array()
	mut iter_3 := var_downloads_mutated.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_download_data := item_3.val
		if rt.is_true(rt.call_function('is_a', [var_download_data.clone(), rt.new_string('WC_Product_Download')])) {
			var_downloads_map.array_set(rt.call_method(var_download_data, 'get_id', []rt.PhpVal{}), var_download_data.clone())
			continue
		}
		if !(var_download_data.clone().is_array()) {
			continue
		}
		mut var_download_object := create_wc_product_download()
		if !rt.is_true(var_download_data.array_get(rt.new_string('download_id'))) {
			var_download_data.array_set('download_id', rt.call_function('wp_generate_uuid4', []rt.PhpVal{}))
		}
		var_download_object.set_id(var_download_data.array_get(rt.new_string('download_id')))
		var_download_object.set_name(var_download_data.array_get(rt.new_string('name')))
		var_download_object.set_file(var_download_data.array_get(rt.new_string('file')))
		var_download_object.set_enabled(if var_download_data.array_isset(rt.new_string('enabled')) { var_download_data.array_get(rt.new_string('enabled')) } else { rt.new_bool(true) })
		var_downloads_map.array_set(var_download_object.get_id(), var_download_object)
	}
	return var_downloads_map.clone()
}

fn (mut this Class_WC_Product) set_download_limit(var_download_limit rt.PhpVal) {
	this.set_prop(rt.new_string('download_limit'), if -1 == rt.new_int((var_download_limit).to_i64()) || rt.is_true(rt.identical(rt.new_string(''), var_download_limit)) { -1 } else { rt.call_function('absint', [var_download_limit.clone()]) })
}

fn (mut this Class_WC_Product) set_download_expiry(var_download_expiry rt.PhpVal) {
	this.set_prop(rt.new_string('download_expiry'), if -1 == rt.new_int((var_download_expiry).to_i64()) || rt.is_true(rt.identical(rt.new_string(''), var_download_expiry)) { -1 } else { rt.call_function('absint', [var_download_expiry.clone()]) })
}

fn (mut this Class_WC_Product) set_gallery_image_ids(var_image_ids rt.PhpVal) {
	mut var_image_ids_mutated := var_image_ids
	var_image_ids_mutated = rt.call_function('wp_parse_id_list', [var_image_ids_mutated.clone()])
	this.set_prop(rt.new_string('gallery_image_ids'), var_image_ids_mutated.clone())
}

fn (mut this Class_WC_Product) set_image_id(image_id string) {
	this.set_prop(rt.new_string('image_id'), rt.new_string(image_id))
}

fn (mut this Class_WC_Product) set_rating_counts(var_counts rt.PhpVal) {
	mut var_counts_mutated := var_counts
	this.set_prop(rt.new_string('rating_counts'), rt.call_function('array_filter', [rt.call_function('array_map', [rt.new_string('absint'), rt.cast_array(var_counts_mutated)])]))
}

fn (mut this Class_WC_Product) set_average_rating(var_average rt.PhpVal) {
	this.set_prop(rt.new_string('average_rating'), rt.call_function('wc_format_decimal', [var_average.clone()]))
}

fn (mut this Class_WC_Product) set_review_count(var_count rt.PhpVal) {
	this.set_prop(rt.new_string('review_count'), rt.call_function('absint', [var_count.clone()]))
}

fn (mut this Class_WC_Product) validate_props() {
	if rt.is_true(rt.new_bool(!(rt.is_true(this.get_manage_stock(''))))) {
		this.set_stock_quantity(rt.new_string(''))
		this.set_backorders(rt.new_string('no'))
		this.set_low_stock_amount(rt.new_string(''))
		return
	}
	mut var_stock_is_above_notification_threshold := rt.greater(rt.new_int((this.get_stock_quantity('')).to_i64()), rt.call_function('absint', [rt.call_function('get_option', [rt.new_string('woocommerce_notify_no_stock_amount'), rt.new_int(0)])]))
	mut var_backorders_are_allowed := rt.new_bool(!rt.is_true(rt.identical(rt.new_string('no'), this.get_backorders(''))))
	if rt.is_true(var_stock_is_above_notification_threshold) {
	mut var_new_stock_status := Class_Automattic_WooCommerce_Enums_ProductStockStatus.in_stock()
	} else if rt.is_true(var_backorders_are_allowed) {
	var_new_stock_status = Class_Automattic_WooCommerce_Enums_ProductStockStatus.on_backorder()
	} else {
	var_new_stock_status = Class_Automattic_WooCommerce_Enums_ProductStockStatus.out_of_stock()
	}
	this.set_stock_status(var_new_stock_status.clone())
}

fn (mut this Class_WC_Product) save() rt.PhpVal {
	this.validate_props()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.get_property(rt.new_object('WC_Product', ['WC_Abstract_Legacy_Product'], &this), 'data_store'))))) {
		return this.get_id()
	}
	rt.call_function('do_action', [rt.new_string('woocommerce_before_' + (this.object_type).str() + '_object_save'), rt.new_object('WC_Product', ['WC_Abstract_Legacy_Product'], &this), rt.get_property(rt.new_object('WC_Product', ['WC_Abstract_Legacy_Product'], &this), 'data_store')])
	mut var_state := this.before_data_store_save_or_update()
	if rt.is_true(this.get_id()) {
		mut var_changeset := this.get_changes()
		rt.call_method(rt.get_property(rt.new_object('WC_Product', ['WC_Abstract_Legacy_Product'], &this), 'data_store'), 'update', [rt.new_object('WC_Product', ['WC_Abstract_Legacy_Product'], &this)])
	} else {
		var_changeset = rt.new_null()
		rt.call_method(rt.get_property(rt.new_object('WC_Product', ['WC_Abstract_Legacy_Product'], &this), 'data_store'), 'create', [rt.new_object('WC_Product', ['WC_Abstract_Legacy_Product'], &this)])
	}
	this.after_data_store_save_or_update(var_state.clone())
	if var_changeset.clone().is_null() || !(!rt.is_true(var_changeset)) {
		rt.call_method(rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_LookupDataStore.class()]), 'on_product_changed', [rt.new_object('WC_Product', ['WC_Abstract_Legacy_Product'], &this), var_changeset.clone()])
	}
	rt.call_function('do_action', [rt.new_string('woocommerce_after_' + (this.object_type).str() + '_object_save'), rt.new_object('WC_Product', ['WC_Abstract_Legacy_Product'], &this), rt.get_property(rt.new_object('WC_Product', ['WC_Abstract_Legacy_Product'], &this), 'data_store')])
	return this.get_id()
}

fn (mut this Class_WC_Product) before_data_store_save_or_update() rt.PhpVal {
	return rt.new_null()
}

fn (mut this Class_WC_Product) after_data_store_save_or_update(var_state rt.PhpVal) {
	mut var_state_mutated := var_state
	this.maybe_defer_product_sync()
}

fn (mut this Class_WC_Product) delete(force_delete bool) rt.PhpVal {
	mut var_product_id := this.get_id()
	mut var_deleted := this.Class_WC_Abstract_Legacy_Product.delete(rt.new_bool(force_delete))
	if rt.is_true(var_deleted) {
		this.maybe_defer_product_sync()
		rt.call_method(rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_LookupDataStore.class()]), 'on_product_deleted', [var_product_id.clone()])
	}
	return var_deleted.clone()
}

fn (mut this Class_WC_Product) maybe_defer_product_sync() {
	mut var_parent_id := this.get_parent_id('')
	if rt.is_true(var_parent_id) {
		rt.call_function('wc_deferred_product_sync', [var_parent_id.clone()])
	}
}

fn (mut this Class_WC_Product) supports(var_feature rt.PhpVal) rt.PhpVal {
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_product_supports'), rt.call_function('in_array', [var_feature.clone(), this.supports, rt.new_bool(true)]), var_feature.clone(), rt.new_object('WC_Product', ['WC_Abstract_Legacy_Product'], &this)])
}

fn (mut this Class_WC_Product) exists() bool {
	return rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), this.get_status(''))))
}

fn (mut this Class_WC_Product) is_type(var_type rt.PhpVal) bool {
	return rt.is_true(rt.identical(this.get_type(), var_type)) || var_type.clone().is_array() && rt.is_true(rt.call_function('in_array', [this.get_type(), var_type.clone(), rt.new_bool(true)]))
}

fn (mut this Class_WC_Product) is_downloadable() rt.PhpVal {
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_is_downloadable'), rt.identical(rt.new_bool(true), this.get_downloadable('')), rt.new_object('WC_Product', ['WC_Abstract_Legacy_Product'], &this)])
}

fn (mut this Class_WC_Product) is_virtual() rt.PhpVal {
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_is_virtual'), rt.identical(rt.new_bool(true), this.get_virtual('')), rt.new_object('WC_Product', ['WC_Abstract_Legacy_Product'], &this)])
}

fn (mut this Class_WC_Product) is_featured() rt.PhpVal {
	return rt.identical(rt.new_bool(true), this.get_featured(''))
}

fn (mut this Class_WC_Product) is_sold_individually() rt.PhpVal {
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_is_sold_individually'), rt.identical(rt.new_bool(true), this.get_sold_individually('')), rt.new_object('WC_Product', ['WC_Abstract_Legacy_Product'], &this)])
}

fn (mut this Class_WC_Product) is_visible() rt.PhpVal {
	mut var_visible := this.is_visible_core()
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_product_is_visible'), var_visible.clone(), this.get_id()])
}

fn (mut this Class_WC_Product) is_visible_core() rt.PhpVal {
	mut var_visible := rt.new_bool(rt.is_true(rt.identical(Class_Automattic_WooCommerce_Enums_CatalogVisibility.visible(), this.get_catalog_visibility(''))) || (rt.is_true(rt.call_function('is_search', []rt.PhpVal{})) && rt.is_true(rt.identical(Class_Automattic_WooCommerce_Enums_CatalogVisibility.search(), this.get_catalog_visibility('')))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_search', []rt.PhpVal{}))))) && rt.is_true(rt.identical(Class_Automattic_WooCommerce_Enums_CatalogVisibility.catalog(), this.get_catalog_visibility(''))))
	if rt.is_true(rt.identical(Class_Automattic_WooCommerce_Enums_ProductStatus.trash(), this.get_status(''))) {
	var_visible = rt.new_bool(false)
	} else if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(Class_Automattic_WooCommerce_Enums_ProductStatus.publish(), this.get_status(''))))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_post'), this.get_id()]))))) {
	var_visible = rt.new_bool(false)
	}
	if rt.is_true(this.get_parent_id('')) {
		mut var_parent_product := rt.call_function('wc_get_product', [this.get_parent_id('')])
		if rt.is_true(var_parent_product) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(Class_Automattic_WooCommerce_Enums_ProductStatus.publish(), rt.call_method(var_parent_product, 'get_status', []rt.PhpVal{}))))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_post'), rt.call_method(var_parent_product, 'get_id', []rt.PhpVal{})]))))) {
		var_visible = rt.new_bool(false)
		}
	}
	if rt.is_true(rt.identical(rt.new_string('yes'), rt.call_function('get_option', [rt.new_string('woocommerce_hide_out_of_stock_items')]))) && rt.is_true(rt.new_bool(!(rt.is_true(this.is_in_stock())))) {
	var_visible = rt.new_bool(false)
	}
	return var_visible.clone()
}

fn (mut this Class_WC_Product) is_purchasable() rt.PhpVal {
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_is_purchasable'), rt.new_bool(this.exists() && rt.is_true(rt.identical(Class_Automattic_WooCommerce_Enums_ProductStatus.publish(), this.get_status(''))) || rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_post'), this.get_id()])) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), this.get_price('')))))), rt.new_object('WC_Product', ['WC_Abstract_Legacy_Product'], &this)])
}

fn (mut this Class_WC_Product) is_on_sale(context string) rt.PhpVal {
	if rt.is_true(rt.new_bool('' != (this.get_sale_price(context)).str())) && rt.is_true(rt.greater(this.get_regular_price(context), this.get_sale_price(context))) {
		mut var_on_sale := rt.new_bool(true)
		if rt.is_true(this.get_date_on_sale_from(context)) && rt.is_true(rt.greater(rt.call_method(this.get_date_on_sale_from(context), 'getTimestamp', []rt.PhpVal{}), rt.call_function('time', []rt.PhpVal{}))) {
		var_on_sale = rt.new_bool(false)
		}
		if rt.is_true(this.get_date_on_sale_to(context)) && rt.is_true(rt.less(rt.call_method(this.get_date_on_sale_to(context), 'getTimestamp', []rt.PhpVal{}), rt.call_function('time', []rt.PhpVal{}))) {
		var_on_sale = rt.new_bool(false)
		}
	} else {
	var_on_sale = rt.new_bool(false)
	}
	return if rt.is_true(rt.identical(rt.new_string('view'), rt.new_string(context))) { rt.call_function('apply_filters', [rt.new_string('woocommerce_product_is_on_sale'), var_on_sale.clone(), rt.new_object('WC_Product', ['WC_Abstract_Legacy_Product'], &this)]) } else { var_on_sale }
}

fn (mut this Class_WC_Product) has_dimensions() bool {
	return rt.is_true(this.get_length('')) || rt.is_true(this.get_height('')) || rt.is_true(this.get_width('')) && rt.is_true(rt.new_bool(!(rt.is_true(this.get_virtual('')))))
}

fn (mut this Class_WC_Product) has_weight() bool {
	return rt.is_true(this.get_weight('')) && rt.is_true(rt.new_bool(!(rt.is_true(this.get_virtual('')))))
}

fn (mut this Class_WC_Product) is_in_stock() rt.PhpVal {
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_product_is_in_stock'), rt.new_bool(!rt.is_true(rt.identical(Class_Automattic_WooCommerce_Enums_ProductStockStatus.out_of_stock(), this.get_stock_status('')))), rt.new_object('WC_Product', ['WC_Abstract_Legacy_Product'], &this)])
}

fn (mut this Class_WC_Product) needs_shipping() rt.PhpVal {
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_product_needs_shipping'), rt.new_bool(!(rt.is_true(this.is_virtual()))), rt.new_object('WC_Product', ['WC_Abstract_Legacy_Product'], &this)])
}

fn (mut this Class_WC_Product) is_taxable() rt.PhpVal {
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_product_is_taxable'), rt.new_bool(rt.is_true(rt.identical(this.get_tax_status(''), Class_Automattic_WooCommerce_Enums_ProductTaxStatus.taxable())) && rt.is_true(rt.call_function('wc_tax_enabled', []rt.PhpVal{}))), rt.new_object('WC_Product', ['WC_Abstract_Legacy_Product'], &this)])
}

fn (mut this Class_WC_Product) is_shipping_taxable() bool {
	return rt.is_true(this.needs_shipping()) && rt.is_true(rt.identical(this.get_tax_status(''), Class_Automattic_WooCommerce_Enums_ProductTaxStatus.taxable())) || rt.is_true(rt.identical(this.get_tax_status(''), Class_Automattic_WooCommerce_Enums_ProductTaxStatus.shipping()))
}

fn (mut this Class_WC_Product) managing_stock() bool {
	if rt.is_true(rt.identical(rt.new_string('yes'), rt.call_function('get_option', [rt.new_string('woocommerce_manage_stock')]))) {
		return (this.get_manage_stock('')).to_bool()
	}
	return false
}

fn (mut this Class_WC_Product) backorders_allowed() rt.PhpVal {
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_product_backorders_allowed'), rt.new_bool(rt.is_true(rt.identical(rt.new_string('yes'), this.get_backorders(''))) || rt.is_true(rt.identical(rt.new_string('notify'), this.get_backorders('')))), this.get_id(), rt.new_object('WC_Product', ['WC_Abstract_Legacy_Product'], &this)])
}

fn (mut this Class_WC_Product) backorders_require_notification() rt.PhpVal {
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_product_backorders_require_notification'), rt.new_bool(this.managing_stock() && rt.is_true(rt.identical(rt.new_string('notify'), this.get_backorders('')))), rt.new_object('WC_Product', ['WC_Abstract_Legacy_Product'], &this)])
}

fn (mut this Class_WC_Product) is_on_backorder(qty_in_cart i64) bool {
	if rt.is_true(rt.identical(Class_Automattic_WooCommerce_Enums_ProductStockStatus.on_backorder(), this.get_stock_status(''))) {
		return true
	}
	return this.managing_stock() && rt.is_true(this.backorders_allowed()) && rt.is_true(rt.less(rt.sub(this.get_stock_quantity(''), rt.new_int(qty_in_cart)), rt.new_int(0)))
}

fn (mut this Class_WC_Product) has_enough_stock(var_quantity rt.PhpVal) bool {
	return !(this.managing_stock()) || rt.is_true(this.backorders_allowed()) || rt.is_true(rt.greater_equal(this.get_stock_quantity(''), var_quantity))
}

fn (mut this Class_WC_Product) has_attributes() bool {
	mut iter_4 := this.get_attributes('').iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_attribute := item_4.val
		if rt.is_true(rt.call_method(var_attribute, 'get_visible', []rt.PhpVal{})) {
			return true
		}
	}
	return false
}

fn (mut this Class_WC_Product) has_child() bool {
	return rt.new_bool(0 < this.get_children().array_count())
}

fn (mut this Class_WC_Product) child_has_dimensions() bool {
	return false
}

fn (mut this Class_WC_Product) child_has_weight() bool {
	return false
}

fn (mut this Class_WC_Product) has_file(download_id string) bool {
	mut download_id_mutated := download_id
	return rt.is_true(this.is_downloadable()) && rt.is_true(this.get_file(download_id_mutated))
}

fn (mut this Class_WC_Product) has_options() rt.PhpVal {
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_product_has_options'), rt.new_bool(false), rt.new_object('WC_Product', ['WC_Abstract_Legacy_Product'], &this)])
}

fn (mut this Class_WC_Product) get_title() rt.PhpVal {
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_product_title'), this.get_name(''), rt.new_object('WC_Product', ['WC_Abstract_Legacy_Product'], &this)])
}

fn (mut this Class_WC_Product) get_permalink() rt.PhpVal {
	return rt.call_function('get_permalink', [this.get_id()])
}

fn (mut this Class_WC_Product) get_children() rt.PhpVal {
	return rt.new_array()
}

fn (mut this Class_WC_Product) get_stock_managed_by_id() rt.PhpVal {
	return this.get_id()
}

fn (mut this Class_WC_Product) get_price_html(deprecated string) rt.PhpVal {
	if rt.is_true(rt.identical(rt.new_string(''), this.get_price(''))) {
	mut var_price := rt.call_function('apply_filters', [rt.new_string('woocommerce_empty_price_html'), rt.new_string(''), rt.new_object('WC_Product', ['WC_Abstract_Legacy_Product'], &this)])
	} else if rt.is_true(this.is_on_sale('')) {
	var_price = rt.new_string((rt.call_function('wc_format_sale_price', [rt.call_function('wc_get_price_to_display', [rt.new_object('WC_Product', ['WC_Abstract_Legacy_Product'], &this), rt.create_array([rt.ArrayItem{ key: 'price', val: this.get_regular_price('') }])]), rt.call_function('wc_get_price_to_display', [rt.new_object('WC_Product', ['WC_Abstract_Legacy_Product'], &this)])])).str() + (this.get_price_suffix('', 0)).str())
	} else {
	var_price = rt.new_string((rt.call_function('wc_price', [rt.call_function('wc_get_price_to_display', [rt.new_object('WC_Product', ['WC_Abstract_Legacy_Product'], &this)])])).str() + (this.get_price_suffix('', 0)).str())
	}
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_get_price_html'), var_price.clone(), rt.new_object('WC_Product', ['WC_Abstract_Legacy_Product'], &this)])
}

fn (mut this Class_WC_Product) get_cogs_value_html() rt.PhpVal {
	mut var_value := rt.new_float(this.get_cogs_total_value())
	if rt.is_true(rt.identical(rt.new_float(0), var_value)) {
	mut var_html := rt.call_function('apply_filters', [rt.new_string('woocommerce_product_empty_cogs_html'), rt.new_string(''), rt.new_object('WC_Product', ['WC_Abstract_Legacy_Product'], &this)])
	} else {
	var_html = rt.new_string((rt.call_function('wc_price', [var_value.clone()])).str() + (this.get_price_suffix('', 0)).str())
	}
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_product_get_cogs_html'), var_html.clone(), var_value.clone(), rt.new_object('WC_Product', ['WC_Abstract_Legacy_Product'], &this)])
}

fn (mut this Class_WC_Product) get_formatted_name() rt.PhpVal {
	if rt.is_true(this.get_sku('')) {
	mut var_identifier := this.get_sku('')
	} else {
	var_identifier = rt.new_string('#' + (this.get_id()).str())
	}
	return rt.call_function('sprintf', [rt.new_string('%2$s (%1$s)'), var_identifier.clone(), this.get_name('')])
}

fn (mut this Class_WC_Product) get_min_purchase_quantity() rt.PhpVal {
	return rt.call_function('wc_stock_amount', [rt.call_function('apply_filters', [rt.new_string('woocommerce_quantity_input_min'), rt.new_int(1), rt.new_object('WC_Product', ['WC_Abstract_Legacy_Product'], &this)])])
}

fn (mut this Class_WC_Product) get_max_purchase_quantity() rt.PhpVal {
	return rt.call_function('wc_stock_amount', [rt.call_function('apply_filters', [rt.new_string('woocommerce_quantity_input_max'), if rt.is_true(this.is_sold_individually()) { rt.new_int(1) } else { if rt.is_true(this.backorders_allowed()) || !(this.managing_stock()) { -1 } else { this.get_stock_quantity('') } }, rt.new_object('WC_Product', ['WC_Abstract_Legacy_Product'], &this)])])
}

fn (mut this Class_WC_Product) get_purchase_quantity_step() rt.PhpVal {
	return rt.call_function('wc_stock_amount', [rt.call_function('apply_filters', [rt.new_string('woocommerce_quantity_input_step'), rt.new_int(1), rt.new_object('WC_Product', ['WC_Abstract_Legacy_Product'], &this)])])
}

fn (mut this Class_WC_Product) add_to_cart_url() rt.PhpVal {
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_product_add_to_cart_url'), this.get_permalink(), rt.new_object('WC_Product', ['WC_Abstract_Legacy_Product'], &this)])
}

fn (mut this Class_WC_Product) single_add_to_cart_text() rt.PhpVal {
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_product_single_add_to_cart_text'), rt.call_function('__', [rt.new_string('Add to cart'), rt.new_string('woocommerce')]), rt.new_object('WC_Product', ['WC_Abstract_Legacy_Product'], &this)])
}

fn (mut this Class_WC_Product) add_to_cart_aria_describedby() rt.PhpVal {
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_product_add_to_cart_aria_describedby'), rt.new_string(''), rt.new_object('WC_Product', ['WC_Abstract_Legacy_Product'], &this)])
}

fn (mut this Class_WC_Product) add_to_cart_text() rt.PhpVal {
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_product_add_to_cart_text'), rt.call_function('__', [rt.new_string('Read more'), rt.new_string('woocommerce')]), rt.new_object('WC_Product', ['WC_Abstract_Legacy_Product'], &this)])
}

fn (mut this Class_WC_Product) add_to_cart_description() rt.PhpVal {
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_product_add_to_cart_description'), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Read more about &ldquo;%s&rdquo;'), rt.new_string('woocommerce')]), this.get_name('')]), rt.new_object('WC_Product', ['WC_Abstract_Legacy_Product'], &this)])
}

fn (mut this Class_WC_Product) get_image(size string, var_attr rt.PhpVal, placeholder bool) rt.PhpVal {
	mut var_attr_mutated := var_attr
	mut var_image := rt.new_string('')
	if rt.is_true(this.get_image_id('')) {
	mut var_image_alt := rt.call_function('get_post_meta', [this.get_image_id(''), rt.new_string('_wp_attachment_image_alt'), rt.new_bool(true)])
	var_attr_mutated = rt.call_function('wp_parse_args', [var_attr_mutated.clone(), rt.create_array([rt.ArrayItem{ key: 'alt', val: if rt.is_true(var_image_alt) { var_image_alt } else { this.get_name('') } }])])
	var_image = rt.call_function('wp_get_attachment_image', [this.get_image_id(''), rt.new_string(size), rt.new_bool(false), var_attr_mutated.clone()])
	} else if rt.is_true(this.get_parent_id('')) {
		mut var_parent_product := rt.call_function('wc_get_product', [this.get_parent_id('')])
		if rt.is_true(var_parent_product) {
		var_image = rt.call_method(var_parent_product, 'get_image', [rt.new_string(size), var_attr_mutated.clone(), rt.new_bool(placeholder)])
		}
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_image)))) && var_placeholder {
	var_image = rt.call_function('wc_placeholder_img', [rt.new_string(size), var_attr_mutated.clone()])
	}
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_product_get_image'), var_image.clone(), rt.new_object('WC_Product', ['WC_Abstract_Legacy_Product'], &this), rt.new_string(size), var_attr_mutated.clone(), rt.new_bool(placeholder), var_image.clone()])
}

fn (mut this Class_WC_Product) get_shipping_class() string {
	mut var_class_id := this.get_shipping_class_id('')
	if rt.is_true(var_class_id) {
		mut var_term := rt.call_function('get_term_by', [rt.new_string('id'), var_class_id.clone(), rt.new_string('product_shipping_class')])
		if rt.is_true(var_term) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [var_term.clone()]))))) {
			return (rt.get_property(var_term, 'slug')).str()
		}
	}
	return ''
}

fn (mut this Class_WC_Product) get_attribute(var_attribute rt.PhpVal) string {
	mut var_attribute_mutated := var_attribute
	mut var_attributes := this.get_attributes('')
	var_attribute_mutated = rt.call_function('sanitize_title', [var_attribute_mutated.clone()])
	if var_attributes.array_isset(var_attribute_mutated) {
	mut var_attribute_object := var_attributes.array_get(var_attribute_mutated)
	} else if var_attributes.array_isset('pa_' + (var_attribute_mutated).str()) {
	var_attribute_object = var_attributes.array_get(rt.new_string('pa_' + (var_attribute_mutated).str()))
	} else {
		return ''
	}
	return (if rt.is_true(rt.call_method(var_attribute_object, 'is_taxonomy', []rt.PhpVal{})) { rt.call_function('implode', [rt.new_string(', '), rt.call_function('wc_get_product_terms', [this.get_id(), rt.call_method(var_attribute_object, 'get_name', []rt.PhpVal{}), rt.create_array([rt.ArrayItem{ key: 'fields', val: 'names' }])])]) } else { rt.call_function('wc_implode_text_attributes', [rt.call_method(var_attribute_object, 'get_options', []rt.PhpVal{})]) }).str()
}

fn (mut this Class_WC_Product) get_rating_count(var_value rt.PhpVal) i64 {
	mut var_value_mutated := var_value
	mut var_counts := this.get_rating_counts('')
	if rt.is_true(rt.new_bool(var_value_mutated.clone().is_null())) {
		return (rt.call_function('array_sum', [var_counts.clone()])).to_i64()
	} else if var_counts.array_isset(var_value_mutated) {
		return (rt.call_function('absint', [var_counts.array_get(var_value_mutated)])).to_i64()
	} else {
		return 0
	}
	return i64(0)
}

fn (mut this Class_WC_Product) get_file(download_id string) rt.PhpVal {
	mut download_id_mutated := download_id
	mut var_files := this.get_downloads('')
	if rt.is_true(rt.identical(rt.new_string(''), rt.new_string(download_id_mutated))) {
	mut var_file := if rt.is_true(rt.new_int(var_files.clone().array_count())) { rt.call_function('current', [var_files.clone()]) } else { rt.new_bool(false) }
	} else if var_files.array_isset(rt.new_string(download_id_mutated)) {
	var_file = var_files.array_get(rt.new_string(download_id_mutated))
	} else {
	var_file = rt.new_bool(false)
	}
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_product_file'), var_file.clone(), rt.new_object('WC_Product', ['WC_Abstract_Legacy_Product'], &this), rt.new_string(download_id_mutated).clone()])
}

fn (mut this Class_WC_Product) get_file_download_path(var_download_id rt.PhpVal) rt.PhpVal {
	mut var_download_id_mutated := var_download_id
	mut var_files := this.get_downloads('')
	mut var_file_path := if var_files.array_isset(var_download_id_mutated) { rt.call_method(var_files.array_get(var_download_id_mutated), 'get_file', []rt.PhpVal{}) } else { rt.new_string('') }
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_product_file_download_path'), var_file_path.clone(), rt.new_object('WC_Product', ['WC_Abstract_Legacy_Product'], &this), var_download_id_mutated.clone()])
}

fn (mut this Class_WC_Product) get_price_suffix(price string, qty i64) rt.PhpVal {
	mut price_mutated := price
	mut var_html := rt.new_string('')
	mut var_suffix := rt.call_function('get_option', [rt.new_string('woocommerce_price_display_suffix')])
	if rt.is_true(var_suffix) && rt.is_true(rt.call_function('wc_tax_enabled', []rt.PhpVal{})) && rt.is_true(rt.identical(Class_Automattic_WooCommerce_Enums_ProductTaxStatus.taxable(), this.get_tax_status(''))) {
		if rt.is_true(rt.identical(rt.new_string(''), rt.new_string(price_mutated))) {
		price_mutated = (this.get_price('')).str()
		}
	mut var_replacements := { '{price_including_tax}': rt.call_function('wc_price', [rt.call_function('wc_get_price_including_tax', [rt.new_object('WC_Product', ['WC_Abstract_Legacy_Product'], &this), { 'qty': rt.new_int(qty), 'price': rt.new_string(price_mutated) }])]), '{price_excluding_tax}': rt.call_function('wc_price', [rt.call_function('wc_get_price_excluding_tax', [rt.new_object('WC_Product', ['WC_Abstract_Legacy_Product'], &this), { 'qty': rt.new_int(qty), 'price': rt.new_string(price_mutated) }])]) }
	var_html = rt.call_function('str_replace', [rt.func_array_keys(rt.create_array_from_native_map(var_replacements)), rt.call_function('array_values', [rt.create_array_from_native_map(var_replacements)]), rt.new_string(' <small class="woocommerce-price-suffix">' + (rt.call_function('wp_kses_post', [var_suffix.clone()])).str() + '</small>')])
	}
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_get_price_suffix'), var_html.clone(), rt.new_object('WC_Product', ['WC_Abstract_Legacy_Product'], &this), rt.new_string(price_mutated).clone(), rt.new_int(qty)])
}

fn (mut this Class_WC_Product) get_availability() rt.PhpVal {
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_get_availability'), rt.create_array([rt.ArrayItem{ key: 'availability', val: this.get_availability_text() }, rt.ArrayItem{ key: 'class', val: this.get_availability_class() }]), rt.new_object('WC_Product', ['WC_Abstract_Legacy_Product'], &this)])
}

fn (mut this Class_WC_Product) get_availability_text() rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(this.is_in_stock())))) {
	mut var_availability := rt.call_function('__', [rt.new_string('Out of stock'), rt.new_string('woocommerce')])
	} else if this.managing_stock() && this.is_on_backorder(1) {
	var_availability = if rt.is_true(this.backorders_require_notification()) { rt.call_function('__', [rt.new_string('Available on backorder'), rt.new_string('woocommerce')]) } else { rt.new_string('') }
	} else if !(this.managing_stock()) && this.is_on_backorder(1) {
	var_availability = rt.call_function('__', [rt.new_string('Available on backorder'), rt.new_string('woocommerce')])
	} else if this.managing_stock() {
	var_availability = rt.call_function('wc_format_stock_for_display', [rt.new_object('WC_Product', ['WC_Abstract_Legacy_Product'], &this)])
	} else {
	var_availability = rt.new_string('')
	}
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_get_availability_text'), var_availability.clone(), rt.new_object('WC_Product', ['WC_Abstract_Legacy_Product'], &this)])
}

fn (mut this Class_WC_Product) get_availability_class() rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(this.is_in_stock())))) {
	mut var_class := rt.new_string('out-of-stock')
	} else if (this.managing_stock() && this.is_on_backorder(1)) || (!(this.managing_stock()) && this.is_on_backorder(1)) {
	var_class = rt.new_string('available-on-backorder')
	} else {
	var_class = rt.new_string('in-stock')
	}
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_get_availability_class'), var_class.clone(), rt.new_object('WC_Product', ['WC_Abstract_Legacy_Product'], &this)])
}

fn (mut this Class_WC_Product) set_cogs_value(mut var_value Class_?float) {
	mut var_value_mutated := var_value
	if rt.is_true(this.cogs_is_enabled(rt.new_string(@METHOD))) {
		var_value_mutated = rt.new_float(this.adjust_cogs_value_before_set(mut var_value_mutated))
		this.set_prop(rt.new_string('cogs_value'), rt.new_object('?float', []string{}, var_value_mutated))
	}
}

fn (mut this Class_WC_Product) adjust_cogs_value_before_set(mut var_value Class_?float) f64 {
	mut var_value_mutated := var_value
	return (if rt.is_true(rt.identical(rt.new_float(0), var_value_mutated)) { rt.new_null() } else { var_value_mutated }).to_f64()
}

fn (mut this Class_WC_Product) get_cogs_value() f64 {
	if rt.is_true(rt.new_bool(!(rt.is_true(this.cogs_is_enabled(rt.new_string(@METHOD)))))) {
		return (rt.new_null()).to_f64()
	}
	mut var_value := this.get_prop(rt.new_string('cogs_value'))
	return (if var_value.clone().is_null() { rt.new_null() } else { rt.new_float((var_value).to_f64()) }).to_f64()
}

fn (mut this Class_WC_Product) get_cogs_effective_value() f64 {
	return (if rt.is_true(this.cogs_is_enabled(rt.new_string(@METHOD))) { this.get_cogs_effective_value_core() } else { rt.new_int(0) }).to_f64()
}

fn (mut this Class_WC_Product) get_cogs_effective_value_core() f64 {
	return (if !(this.get_cogs_value()).is_null() { this.get_cogs_value() } else { rt.new_int(0) }).to_f64()
}

fn (mut this Class_WC_Product) get_cogs_total_value() f64 {
	if rt.is_true(rt.new_bool(!(rt.is_true(this.cogs_is_enabled(rt.new_string(@METHOD)))))) {
		return 0
	}
	return (rt.call_function('apply_filters', [rt.new_string('woocommerce_get_product_cogs_total_value'), rt.new_float(this.get_cogs_total_value_core()), rt.new_object('WC_Product', ['WC_Abstract_Legacy_Product'], &this)])).to_f64()
}

fn (mut this Class_WC_Product) get_cogs_total_value_core() f64 {
	return this.get_cogs_effective_value()
}

struct Class_WC_Abstract_Legacy_Product {
	rt.PhpObjectBase
}

struct Class_WC_Data_Store {
	rt.PhpObjectBase
}

struct Class_WC_Tax {
	rt.PhpObjectBase
}

struct Class_WC_Product_Download {
	rt.PhpObjectBase
}

fn create_wc_product(product i64) &Class_WC_Product {
	mut obj := &Class_WC_Product{
		PhpObjectBase: rt.PhpObjectBase{}
		object_type: rt.new_string('product')
		post_type: rt.new_string('product')
		cache_group: rt.new_string('products')
		data: rt.new_array()
		supports: rt.new_array()
	}
	obj.construct(product)
	return obj
}

fn create_wc_abstract_legacy_product(_args ...rt.PhpVal) &Class_WC_Abstract_Legacy_Product {
	mut obj := &Class_WC_Abstract_Legacy_Product{
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

fn create_wc_product_download(_args ...rt.PhpVal) &Class_WC_Product_Download {
	mut obj := &Class_WC_Product_Download{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Product) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'get_type' {
			return this.get_type()
		}
		'get_name' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_name(dispatch_arg_0)
		}
		'get_slug' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_slug(dispatch_arg_0)
		}
		'get_date_created' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_date_created(dispatch_arg_0)
		}
		'get_date_modified' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_date_modified(dispatch_arg_0)
		}
		'get_status' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_status(dispatch_arg_0)
		}
		'get_featured' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_featured(dispatch_arg_0)
		}
		'get_catalog_visibility' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_catalog_visibility(dispatch_arg_0)
		}
		'get_description' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_description(dispatch_arg_0)
		}
		'get_short_description' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_short_description(dispatch_arg_0)
		}
		'get_sku' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_sku(dispatch_arg_0)
		}
		'get_global_unique_id' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_global_unique_id(dispatch_arg_0)
		}
		'get_price' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_price(dispatch_arg_0)
		}
		'get_regular_price' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_regular_price(dispatch_arg_0)
		}
		'get_sale_price' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_sale_price(dispatch_arg_0)
		}
		'get_date_on_sale_from' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_date_on_sale_from(dispatch_arg_0)
		}
		'get_date_on_sale_to' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_date_on_sale_to(dispatch_arg_0)
		}
		'get_total_sales' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_total_sales(dispatch_arg_0)
		}
		'get_tax_status' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_tax_status(dispatch_arg_0)
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
		'get_stock_status' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_stock_status(dispatch_arg_0)
		}
		'get_backorders' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_backorders(dispatch_arg_0)
		}
		'get_low_stock_amount' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_low_stock_amount(dispatch_arg_0)
		}
		'get_sold_individually' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_sold_individually(dispatch_arg_0)
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
		'get_dimensions' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			return this.get_dimensions(dispatch_arg_0)
		}
		'get_upsell_ids' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_upsell_ids(dispatch_arg_0)
		}
		'get_cross_sell_ids' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_cross_sell_ids(dispatch_arg_0)
		}
		'get_parent_id' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_parent_id(dispatch_arg_0)
		}
		'get_reviews_allowed' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_reviews_allowed(dispatch_arg_0)
		}
		'get_purchase_note' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_purchase_note(dispatch_arg_0)
		}
		'get_attributes' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_attributes(dispatch_arg_0)
		}
		'get_default_attributes' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_default_attributes(dispatch_arg_0)
		}
		'get_menu_order' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_menu_order(dispatch_arg_0)
		}
		'get_post_password' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_post_password(dispatch_arg_0)
		}
		'get_category_ids' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_category_ids(dispatch_arg_0)
		}
		'get_tag_ids' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_tag_ids(dispatch_arg_0)
		}
		'get_brand_ids' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_brand_ids(dispatch_arg_0)
		}
		'get_virtual' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_virtual(dispatch_arg_0)
		}
		'get_gallery_image_ids' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_gallery_image_ids(dispatch_arg_0)
		}
		'get_shipping_class_id' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_shipping_class_id(dispatch_arg_0)
		}
		'get_downloads' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_downloads(dispatch_arg_0)
		}
		'get_download_expiry' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_download_expiry(dispatch_arg_0)
		}
		'get_downloadable' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_downloadable(dispatch_arg_0)
		}
		'get_download_limit' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_download_limit(dispatch_arg_0)
		}
		'get_image_id' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_image_id(dispatch_arg_0)
		}
		'get_rating_counts' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_rating_counts(dispatch_arg_0)
		}
		'get_average_rating' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_average_rating(dispatch_arg_0)
		}
		'get_review_count' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_review_count(dispatch_arg_0)
		}
		'set_name' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_name(dispatch_arg_0)
			return rt.new_null()
		}
		'set_slug' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_slug(dispatch_arg_0)
			return rt.new_null()
		}
		'set_date_created' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_date_created(dispatch_arg_0)
			return rt.new_null()
		}
		'set_date_modified' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_date_modified(dispatch_arg_0)
			return rt.new_null()
		}
		'set_status' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_status(dispatch_arg_0)
			return rt.new_null()
		}
		'set_featured' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_featured(dispatch_arg_0)
			return rt.new_null()
		}
		'set_catalog_visibility' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_catalog_visibility(dispatch_arg_0)
			return rt.new_null()
		}
		'set_description' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_description(dispatch_arg_0)
			return rt.new_null()
		}
		'set_short_description' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_short_description(dispatch_arg_0)
			return rt.new_null()
		}
		'set_sku' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_sku(dispatch_arg_0)
			return rt.new_null()
		}
		'set_global_unique_id' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_global_unique_id(dispatch_arg_0)
			return rt.new_null()
		}
		'set_price' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_price(dispatch_arg_0)
			return rt.new_null()
		}
		'set_regular_price' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_regular_price(dispatch_arg_0)
			return rt.new_null()
		}
		'set_sale_price' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_sale_price(dispatch_arg_0)
			return rt.new_null()
		}
		'set_date_on_sale_from' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_date_on_sale_from(dispatch_arg_0)
			return rt.new_null()
		}
		'set_date_on_sale_to' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_date_on_sale_to(dispatch_arg_0)
			return rt.new_null()
		}
		'set_total_sales' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_total_sales(dispatch_arg_0)
			return rt.new_null()
		}
		'set_tax_status' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_tax_status(dispatch_arg_0)
			return rt.new_null()
		}
		'set_tax_class' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_tax_class(dispatch_arg_0)
			return rt.new_null()
		}
		'get_valid_tax_classes' {
			return this.get_valid_tax_classes()
		}
		'set_manage_stock' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_manage_stock(dispatch_arg_0)
			return rt.new_null()
		}
		'set_stock_quantity' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_stock_quantity(dispatch_arg_0)
			return rt.new_null()
		}
		'set_stock_status' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_stock_status(dispatch_arg_0)
			return rt.new_null()
		}
		'set_backorders' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_backorders(dispatch_arg_0)
			return rt.new_null()
		}
		'set_low_stock_amount' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_low_stock_amount(dispatch_arg_0)
			return rt.new_null()
		}
		'set_sold_individually' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_sold_individually(dispatch_arg_0)
			return rt.new_null()
		}
		'set_weight' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_weight(dispatch_arg_0)
			return rt.new_null()
		}
		'set_length' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_length(dispatch_arg_0)
			return rt.new_null()
		}
		'set_width' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_width(dispatch_arg_0)
			return rt.new_null()
		}
		'set_height' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_height(dispatch_arg_0)
			return rt.new_null()
		}
		'set_upsell_ids' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_upsell_ids(dispatch_arg_0)
			return rt.new_null()
		}
		'set_cross_sell_ids' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_cross_sell_ids(dispatch_arg_0)
			return rt.new_null()
		}
		'set_parent_id' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_parent_id(dispatch_arg_0)
			return rt.new_null()
		}
		'set_reviews_allowed' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_reviews_allowed(dispatch_arg_0)
			return rt.new_null()
		}
		'set_purchase_note' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_purchase_note(dispatch_arg_0)
			return rt.new_null()
		}
		'set_attributes' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_attributes(dispatch_arg_0)
			return rt.new_null()
		}
		'set_default_attributes' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_default_attributes(dispatch_arg_0)
			return rt.new_null()
		}
		'set_menu_order' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_menu_order(dispatch_arg_0)
			return rt.new_null()
		}
		'set_post_password' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_post_password(dispatch_arg_0)
			return rt.new_null()
		}
		'set_category_ids' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_category_ids(dispatch_arg_0)
			return rt.new_null()
		}
		'set_tag_ids' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_tag_ids(dispatch_arg_0)
			return rt.new_null()
		}
		'set_brand_ids' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_brand_ids(dispatch_arg_0)
			return rt.new_null()
		}
		'set_virtual' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_virtual(dispatch_arg_0)
			return rt.new_null()
		}
		'set_shipping_class_id' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_shipping_class_id(dispatch_arg_0)
			return rt.new_null()
		}
		'set_downloadable' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_downloadable(dispatch_arg_0)
			return rt.new_null()
		}
		'set_downloads' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_downloads(dispatch_arg_0)
			return rt.new_null()
		}
		'build_downloads_map' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.build_downloads_map(mut dispatch_arg_0)
		}
		'set_download_limit' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_download_limit(dispatch_arg_0)
			return rt.new_null()
		}
		'set_download_expiry' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_download_expiry(dispatch_arg_0)
			return rt.new_null()
		}
		'set_gallery_image_ids' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_gallery_image_ids(dispatch_arg_0)
			return rt.new_null()
		}
		'set_image_id' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			this.set_image_id(dispatch_arg_0)
			return rt.new_null()
		}
		'set_rating_counts' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_rating_counts(dispatch_arg_0)
			return rt.new_null()
		}
		'set_average_rating' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_average_rating(dispatch_arg_0)
			return rt.new_null()
		}
		'set_review_count' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_review_count(dispatch_arg_0)
			return rt.new_null()
		}
		'validate_props' {
			this.validate_props()
			return rt.new_null()
		}
		'save' {
			return this.save()
		}
		'before_data_store_save_or_update' {
			return this.before_data_store_save_or_update()
		}
		'after_data_store_save_or_update' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.after_data_store_save_or_update(dispatch_arg_0)
			return rt.new_null()
		}
		'delete' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			return this.delete(dispatch_arg_0)
		}
		'maybe_defer_product_sync' {
			this.maybe_defer_product_sync()
			return rt.new_null()
		}
		'supports' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.supports(dispatch_arg_0)
		}
		'exists' {
			return rt.new_bool(this.exists())
		}
		'is_type' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.is_type(dispatch_arg_0))
		}
		'is_downloadable' {
			return this.is_downloadable()
		}
		'is_virtual' {
			return this.is_virtual()
		}
		'is_featured' {
			return this.is_featured()
		}
		'is_sold_individually' {
			return this.is_sold_individually()
		}
		'is_visible' {
			return this.is_visible()
		}
		'is_visible_core' {
			return this.is_visible_core()
		}
		'is_purchasable' {
			return this.is_purchasable()
		}
		'is_on_sale' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.is_on_sale(dispatch_arg_0)
		}
		'has_dimensions' {
			return rt.new_bool(this.has_dimensions())
		}
		'has_weight' {
			return rt.new_bool(this.has_weight())
		}
		'is_in_stock' {
			return this.is_in_stock()
		}
		'needs_shipping' {
			return this.needs_shipping()
		}
		'is_taxable' {
			return this.is_taxable()
		}
		'is_shipping_taxable' {
			return rt.new_bool(this.is_shipping_taxable())
		}
		'managing_stock' {
			return rt.new_bool(this.managing_stock())
		}
		'backorders_allowed' {
			return this.backorders_allowed()
		}
		'backorders_require_notification' {
			return this.backorders_require_notification()
		}
		'is_on_backorder' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			return rt.new_bool(this.is_on_backorder(dispatch_arg_0))
		}
		'has_enough_stock' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.has_enough_stock(dispatch_arg_0))
		}
		'has_attributes' {
			return rt.new_bool(this.has_attributes())
		}
		'has_child' {
			return rt.new_bool(this.has_child())
		}
		'child_has_dimensions' {
			return rt.new_bool(this.child_has_dimensions())
		}
		'child_has_weight' {
			return rt.new_bool(this.child_has_weight())
		}
		'has_file' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(this.has_file(dispatch_arg_0))
		}
		'has_options' {
			return this.has_options()
		}
		'get_title' {
			return this.get_title()
		}
		'get_permalink' {
			return this.get_permalink()
		}
		'get_children' {
			return this.get_children()
		}
		'get_stock_managed_by_id' {
			return this.get_stock_managed_by_id()
		}
		'get_price_html' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_price_html(dispatch_arg_0)
		}
		'get_cogs_value_html' {
			return this.get_cogs_value_html()
		}
		'get_formatted_name' {
			return this.get_formatted_name()
		}
		'get_min_purchase_quantity' {
			return this.get_min_purchase_quantity()
		}
		'get_max_purchase_quantity' {
			return this.get_max_purchase_quantity()
		}
		'get_purchase_quantity_step' {
			return this.get_purchase_quantity_step()
		}
		'add_to_cart_url' {
			return this.add_to_cart_url()
		}
		'single_add_to_cart_text' {
			return this.single_add_to_cart_text()
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
		'get_image' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
			return this.get_image(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'get_shipping_class' {
			return rt.new_string(this.get_shipping_class())
		}
		'get_attribute' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.get_attribute(dispatch_arg_0))
		}
		'get_rating_count' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_int(this.get_rating_count(dispatch_arg_0))
		}
		'get_file' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_file(dispatch_arg_0)
		}
		'get_file_download_path' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_file_download_path(dispatch_arg_0)
		}
		'get_price_suffix' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			return this.get_price_suffix(dispatch_arg_0, dispatch_arg_1)
		}
		'get_availability' {
			return this.get_availability()
		}
		'get_availability_text' {
			return this.get_availability_text()
		}
		'get_availability_class' {
			return this.get_availability_class()
		}
		'set_cogs_value' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_?float](if args.len > 0 { args[0] } else { rt.new_null() })
			this.set_cogs_value(mut dispatch_arg_0)
			return rt.new_null()
		}
		'adjust_cogs_value_before_set' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_?float](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_float(this.adjust_cogs_value_before_set(mut dispatch_arg_0))
		}
		'get_cogs_value' {
			return rt.new_float(this.get_cogs_value())
		}
		'get_cogs_effective_value' {
			return rt.new_float(this.get_cogs_effective_value())
		}
		'get_cogs_effective_value_core' {
			return rt.new_float(this.get_cogs_effective_value_core())
		}
		'get_cogs_total_value' {
			return rt.new_float(this.get_cogs_total_value())
		}
		'get_cogs_total_value_core' {
			return rt.new_float(this.get_cogs_total_value_core())
		}
		else { return none }
	}
}

fn (this &Class_WC_Product) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'object_type' { return this.object_type }
		'post_type' { return this.post_type }
		'cache_group' { return this.cache_group }
		'data' { return this.data }
		'supports' { return this.supports }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_Product) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'object_type' { this.object_type = val; return true }
		'post_type' { this.post_type = val; return true }
		'cache_group' { this.cache_group = val; return true }
		'data' { this.data = val; return true }
		'supports' { this.supports = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_WC_Abstract_Legacy_Product) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Abstract_Legacy_Product) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Abstract_Legacy_Product) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_WC_Product_Download) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Product_Download) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Product_Download) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}



fn main() {
	defer {
		rt.shutdown()
	}

	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))))) {
		exit(0)
	}
	rt.include_file((rt.get_constant('WC_ABSPATH')).str() + 'includes/legacy/abstract-wc-legacy-product.php', '4')
}
