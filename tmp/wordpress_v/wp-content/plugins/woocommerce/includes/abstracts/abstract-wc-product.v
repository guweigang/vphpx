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

fn (mut this Class_WC_Product) construct(product i64)  {
	this.Class_WC_Abstract_Legacy_Product.construct(rt.new_int(product))
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.new_int(product).is_long() || rt.new_int(product).is_double())) && product > 0)) {
		this.set_id(rt.new_int(product))
	} else if rt.is_true(rt.new_bool(rt.instance_of(rt.new_int(product), 'self'))) {
		this.set_id(rt.call_function('absint', [rt.call_method(rt.new_int(product), 'get_id', []rt.PhpVal{})]))
	} else if !(!rt.is_true(rt.get_property(rt.new_int(product), 'ID'))) {
		this.set_id(rt.call_function('absint', [rt.get_property(rt.new_int(product), 'ID')]))
	} else {
		this.set_object_read(rt.new_bool(true))
	}
	this.dispatch_set_prop('data_store', fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Data_Store{}; return temp.load(arg_0) }(rt.new_string('product-' + (this.get_type()).str())))
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
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_attributes.dup().is_array()))))) {
		return rt.new_array()
	}
	return var_attributes.dup()
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

fn (mut this Class_WC_Product) set_name(var_name rt.PhpVal)  {
	this.set_prop(rt.new_string('name'), var_name.dup())
}

fn (mut this Class_WC_Product) set_slug(var_slug rt.PhpVal)  {
	this.set_prop(rt.new_string('slug'), var_slug.dup())
}

fn (mut this Class_WC_Product) set_date_created(var_date rt.PhpVal)  {
	this.set_date_prop(rt.new_string('date_created'), var_date.dup())
}

fn (mut this Class_WC_Product) set_date_modified(var_date rt.PhpVal)  {
	this.set_date_prop(rt.new_string('date_modified'), var_date.dup())
}

fn (mut this Class_WC_Product) set_status(var_status rt.PhpVal)  {
	mut var_status_mutated := var_status
	this.set_prop(rt.new_string('status'), var_status_mutated.dup())
}

fn (mut this Class_WC_Product) set_featured(var_featured rt.PhpVal)  {
	this.set_prop(rt.new_string('featured'), rt.call_function('wc_string_to_bool', [var_featured.dup()]))
}

fn (mut this Class_WC_Product) set_catalog_visibility(var_visibility rt.PhpVal)  {
	mut var_visibility_mutated := var_visibility
	mut var_options := rt.func_array_keys(rt.call_function('wc_get_product_visibility_options', []rt.PhpVal{}))
	var_visibility_mutated = if rt.is_true(rt.call_function('in_array', [var_visibility_mutated.dup(), var_options.dup(), rt.new_bool(true)])) { var_visibility_mutated } else { rt.new_string(var_visibility_mutated.dup().to_string().to_lower()) }
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_visibility_mutated.dup(), var_options.dup(), rt.new_bool(true)]))))) {
		this.error(rt.new_string('product_invalid_catalog_visibility'), rt.call_function('__', [rt.new_string('Invalid catalog visibility option.'), rt.new_string('woocommerce')]))
	}
	this.set_prop(rt.new_string('catalog_visibility'), var_visibility_mutated.dup())
}

fn (mut this Class_WC_Product) set_description(var_description rt.PhpVal)  {
	this.set_prop(rt.new_string('description'), var_description.dup())
}

fn (mut this Class_WC_Product) set_short_description(var_short_description rt.PhpVal)  {
	this.set_prop(rt.new_string('short_description'), var_short_description.dup())
}

fn (mut this Class_WC_Product) set_sku(var_sku rt.PhpVal)  {
	mut var_sku_mutated := var_sku
	var_sku_mutated = // unsupported expression: Expr_Cast_String
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(this.get_object_read()) && !(!rt.is_true(var_sku_mutated)))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_product_has_unique_sku', [this.get_id(), var_sku_mutated.dup()]))))))) {
		mut var_sku_found := rt.call_function('wc_get_product_id_by_sku', [var_sku_mutated.dup()])
		this.error(rt.new_string('product_invalid_sku'), rt.call_function('__', [rt.new_string('Invalid or duplicated SKU.'), rt.new_string('woocommerce')]), rt.new_int(400), rt.create_array([rt.ArrayItem{ key: 'resource_id', val: var_sku_found }, rt.ArrayItem{ key: 'unique_sku', val: rt.call_function('wc_product_generate_unique_sku', [this.get_id(), var_sku_mutated.dup()]) }]))
	}
	this.set_prop(rt.new_string('sku'), var_sku_mutated.dup())
}

fn (mut this Class_WC_Product) set_global_unique_id(var_global_unique_id rt.PhpVal)  {
	mut var_global_unique_id_mutated := var_global_unique_id
	var_global_unique_id_mutated = rt.call_function('preg_replace', [rt.new_string('/[^0-9\\-]/'), rt.new_string(''), // unsupported expression: Expr_Cast_String])
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(this.get_object_read()) && !(!rt.is_true(var_global_unique_id_mutated)))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_product_has_global_unique_id', [this.get_id(), var_global_unique_id_mutated.dup()]))))))) {
		mut var_global_unique_id_found := rt.call_function('wc_get_product_id_by_global_unique_id', [var_global_unique_id_mutated.dup()])
		this.error(rt.new_string('product_invalid_global_unique_id'), rt.call_function('__', [rt.new_string('Invalid or duplicated GTIN, UPC, EAN or ISBN.'), rt.new_string('woocommerce')]), rt.new_int(400), rt.create_array([rt.ArrayItem{ key: 'resource_id', val: var_global_unique_id_found }]))
	}
	this.set_prop(rt.new_string('global_unique_id'), var_global_unique_id_mutated.dup())
}

fn (mut this Class_WC_Product) set_price(var_price rt.PhpVal)  {
	mut var_price_mutated := var_price
	this.set_prop(rt.new_string('price'), rt.call_function('wc_format_decimal', [var_price_mutated.dup()]))
}

fn (mut this Class_WC_Product) set_regular_price(var_price rt.PhpVal)  {
	mut var_price_mutated := var_price
	this.set_prop(rt.new_string('regular_price'), rt.call_function('wc_format_decimal', [var_price_mutated.dup()]))
}

fn (mut this Class_WC_Product) set_sale_price(var_price rt.PhpVal)  {
	mut var_price_mutated := var_price
	this.set_prop(rt.new_string('sale_price'), rt.call_function('wc_format_decimal', [.dup()]))
}

fn (mut this Class_WC_Product) set_date_on_sale_from(var_date rt.PhpVal)  {
	this.set_date_prop(rt.new_string(), .dup())
}

fn (mut this Class_WC_Product) set_date_on_sale_to(var_date rt.PhpVal)  {
	
}

fn (mut this Class_WC_Product) set_total_sales(var_total rt.PhpVal)  {
}

fn (mut this Class_WC_Product) set_tax_status(var_status rt.PhpVal)  {
	mut var_status_mutated := var_status
}

fn (mut this Class_WC_Product) set_tax_class(var_class rt.PhpVal)  {
	mut var_class_mutated := var_class
}

fn (mut this Class_WC_Product) get_valid_tax_classes() rt.PhpVal {
}

fn (mut this Class_WC_Product) set_manage_stock(var_manage_stock rt.PhpVal)  {
}

fn (mut this Class_WC_Product) set_stock_quantity(var_quantity rt.PhpVal)  {
}

fn (mut this Class_WC_Product) set_stock_status(var_status rt.PhpVal)  {
	mut var_status_mutated := var_status
}

fn (mut this Class_WC_Product) set_backorders(var_backorders rt.PhpVal)  {
}

fn (mut this Class_WC_Product) set_low_stock_amount(var_amount rt.PhpVal)  {
}

fn (mut this Class_WC_Product) set_sold_individually(var_sold_individually rt.PhpVal)  {
}

fn (mut this Class_WC_Product) set_weight(var_weight rt.PhpVal)  {
}

fn (mut this Class_WC_Product) set_length(var_length rt.PhpVal)  {
}

fn (mut this Class_WC_Product) set_width(var_width rt.PhpVal)  {
}

fn (mut this Class_WC_Product) set_height(var_height rt.PhpVal)  {
}

fn (mut this Class_WC_Product) set_upsell_ids(var_upsell_ids rt.PhpVal)  {
}

fn (mut this Class_WC_Product) set_cross_sell_ids(var_cross_sell_ids rt.PhpVal)  {
}

fn (mut this Class_WC_Product) set_parent_id(var_parent_id rt.PhpVal)  {
	mut var_parent_id_mutated := var_parent_id
}

fn (mut this Class_WC_Product) set_reviews_allowed(var_reviews_allowed rt.PhpVal)  {
}

fn (mut this Class_WC_Product) set_purchase_note(var_purchase_note rt.PhpVal)  {
}

fn (mut this Class_WC_Product) set_attributes(var_raw_attributes rt.PhpVal)  {
}

fn (mut this Class_WC_Product) set_default_attributes(var_default_attributes rt.PhpVal)  {
}

fn (mut this Class_WC_Product) set_menu_order(var_menu_order rt.PhpVal)  {
}

fn (mut this Class_WC_Product) set_post_password(var_post_password rt.PhpVal)  {
}

fn (mut this Class_WC_Product) set_category_ids(var_term_ids rt.PhpVal)  {
}

fn (mut this Class_WC_Product) set_tag_ids(var_term_ids rt.PhpVal)  {
}

fn (mut this Class_WC_Product) set_brand_ids(var_term_ids rt.PhpVal)  {
}

fn (mut this Class_WC_Product) set_virtual(var_virtual rt.PhpVal)  {
}

fn (mut this Class_WC_Product) set_shipping_class_id(var_id rt.PhpVal)  {
}

fn (mut this Class_WC_Product) set_downloadable(var_downloadable rt.PhpVal)  {
}

fn (mut this Class_WC_Product) set_downloads(var_downloads_array rt.PhpVal)  {
	mut var_downloads_array_mutated := var_downloads_array
}

fn (mut this Class_WC_Product) build_downloads_map(mut var_downloads Class_array) rt.PhpVal {
	mut var_downloads_mutated := var_downloads
}

fn (mut this Class_WC_Product) set_download_limit(var_download_limit rt.PhpVal)  {
}

fn (mut this Class_WC_Product) set_download_expiry(var_download_expiry rt.PhpVal)  {
}

fn (mut this Class_WC_Product) set_gallery_image_ids(var_image_ids rt.PhpVal)  {
	mut var_image_ids_mutated := var_image_ids
}

fn (mut this Class_WC_Product) set_image_id(image_id string)  {
}

fn (mut this Class_WC_Product) set_rating_counts(var_counts rt.PhpVal)  {
	mut var_counts_mutated := var_counts
}

fn (mut this Class_WC_Product) set_average_rating(var_average rt.PhpVal)  {
}

fn (mut this Class_WC_Product) set_review_count(var_count rt.PhpVal)  {
}

fn (mut this Class_WC_Product) validate_props()  {
}

fn (mut this Class_WC_Product) save() rt.PhpVal {
}

fn (mut this Class_WC_Product) before_data_store_save_or_update() rt.PhpVal {
}

fn (mut this Class_WC_Product) after_data_store_save_or_update(var_state rt.PhpVal)  {
	mut var_state_mutated := var_state
}

fn (mut this Class_WC_Product) delete(force_delete bool) rt.PhpVal {
}

fn (mut this Class_WC_Product) maybe_defer_product_sync()  {
}

fn (mut this Class_WC_Product) supports(var_feature rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_WC_Product) exists() rt.PhpVal {
}

fn (mut this Class_WC_Product) is_type(var_type rt.PhpVal) bool {
}

fn (mut this Class_WC_Product) is_downloadable() rt.PhpVal {
}

fn (mut this Class_WC_Product) is_virtual() rt.PhpVal {
}

fn (mut this Class_WC_Product) is_featured() rt.PhpVal {
}

fn (mut this Class_WC_Product) is_sold_individually() rt.PhpVal {
}

fn (mut this Class_WC_Product) is_visible() rt.PhpVal {
}

fn (mut this Class_WC_Product) is_visible_core() rt.PhpVal {
}

fn (mut this Class_WC_Product) is_purchasable() rt.PhpVal {
}

fn (mut this Class_WC_Product) is_on_sale(context string) rt.PhpVal {
}

fn (mut this Class_WC_Product) has_dimensions() bool {
}

fn (mut this Class_WC_Product) has_weight() bool {
}

fn (mut this Class_WC_Product) is_in_stock() rt.PhpVal {
}

fn (mut this Class_WC_Product) needs_shipping() rt.PhpVal {
}

fn (mut this Class_WC_Product) is_taxable() rt.PhpVal {
}

fn (mut this Class_WC_Product) is_shipping_taxable() bool {
}

fn (mut this Class_WC_Product) managing_stock() bool {
}

fn (mut this Class_WC_Product) backorders_allowed() rt.PhpVal {
}

fn (mut this Class_WC_Product) backorders_require_notification() rt.PhpVal {
}

fn (mut this Class_WC_Product) is_on_backorder(qty_in_cart i64) bool {
}

fn (mut this Class_WC_Product) has_enough_stock(var_quantity rt.PhpVal) bool {
}

fn (mut this Class_WC_Product) has_attributes() bool {
}

fn (mut this Class_WC_Product) has_child() bool {
}

fn (mut this Class_WC_Product) child_has_dimensions() bool {
}

fn (mut this Class_WC_Product) child_has_weight() bool {
}

fn (mut this Class_WC_Product) has_file(download_id string) bool {
	mut download_id_mutated := download_id
}

fn (mut this Class_WC_Product) has_options() rt.PhpVal {
}

fn (mut this Class_WC_Product) get_title() rt.PhpVal {
}

fn (mut this Class_WC_Product) get_permalink() rt.PhpVal {
}

fn (mut this Class_WC_Product) get_children() rt.PhpVal {
}

fn (mut this Class_WC_Product) get_stock_managed_by_id() rt.PhpVal {
}

fn (mut this Class_WC_Product) get_price_html(deprecated string) rt.PhpVal {
}

fn (mut this Class_WC_Product) get_cogs_value_html() rt.PhpVal {
}

fn (mut this Class_WC_Product) get_formatted_name() rt.PhpVal {
}

fn (mut this Class_WC_Product) get_min_purchase_quantity() rt.PhpVal {
}

fn (mut this Class_WC_Product) get_max_purchase_quantity() rt.PhpVal {
}

fn (mut this Class_WC_Product) get_purchase_quantity_step() rt.PhpVal {
}

fn (mut this Class_WC_Product) add_to_cart_url() rt.PhpVal {
}

fn (mut this Class_WC_Product) single_add_to_cart_text() rt.PhpVal {
}

fn (mut this Class_WC_Product) add_to_cart_aria_describedby() rt.PhpVal {
}

fn (mut this Class_WC_Product) add_to_cart_text() rt.PhpVal {
}

fn (mut this Class_WC_Product) add_to_cart_description() rt.PhpVal {
}

fn (mut this Class_WC_Product) get_image(size string, var_attr rt.PhpVal, placeholder bool) rt.PhpVal {
	mut var_attr_mutated := var_attr
}

fn (mut this Class_WC_Product) get_shipping_class() string {
}

fn (mut this Class_WC_Product) get_attribute(var_attribute rt.PhpVal) string {
	mut var_attribute_mutated := var_attribute
}

fn (mut this Class_WC_Product) get_rating_count(var_value rt.PhpVal) i64 {
	mut var_value_mutated := var_value
	return i64(0)
}

fn (mut this Class_WC_Product) get_file(download_id string) rt.PhpVal {
	mut download_id_mutated := download_id
}

fn (mut this Class_WC_Product) get_file_download_path(var_download_id rt.PhpVal) rt.PhpVal {
	mut var_download_id_mutated := var_download_id
}

fn (mut this Class_WC_Product) get_price_suffix(price string, qty i64) rt.PhpVal {
	mut price_mutated := price
}

fn (mut this Class_WC_Product) get_availability() rt.PhpVal {
}

fn (mut this Class_WC_Product) get_availability_text() rt.PhpVal {
}

fn (mut this Class_WC_Product) get_availability_class() rt.PhpVal {
}

fn (mut this Class_WC_Product) set_cogs_value(mut var_value Class_?float)  {
	mut var_value_mutated := var_value
}

fn (mut this Class_WC_Product) adjust_cogs_value_before_set(mut var_value Class_?float) f64 {
	mut var_value_mutated := var_value
}

fn (mut this Class_WC_Product) get_cogs_value() f64 {
}

fn (mut this Class_WC_Product) get_cogs_effective_value() f64 {
}

fn (mut this Class_WC_Product) get_cogs_effective_value_core() f64 {
}

fn (mut this Class_WC_Product) get_cogs_total_value() f64 {
}

fn (mut this Class_WC_Product) get_cogs_total_value_core() f64 {
}

struct Class_WC_Abstract_Legacy_Product {
	rt.PhpObjectBase
}

struct Class_WC_Data_Store {
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

fn create_wc_abstract_legacy_product() &Class_WC_Abstract_Legacy_Product {
	mut obj := &Class_WC_Abstract_Legacy_Product{
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
			return this.exists()
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




pub fn init_wp_content_plugins_woocommerce_includes_abstracts_abstract_wc_product_php() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))))) {
		// unsupported expression: Expr_Exit
	}
	rt.include_file((rt.get_constant('WC_ABSPATH')).str() + 'includes/legacy/abstract-wc-legacy-product.php', '4')
}
