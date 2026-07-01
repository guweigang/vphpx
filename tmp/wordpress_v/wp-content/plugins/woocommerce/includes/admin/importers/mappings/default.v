import rt

fn wc_importer_current_locale() rt.PhpVal {
	mut var_locale := rt.call_function('get_locale', []rt.PhpVal{})
	if rt.is_true(rt.call_function('function_exists', [rt.new_string('get_user_locale')])) {
		var_locale = rt.call_function('get_user_locale', []rt.PhpVal{})
	}
	return var_locale.dup()
}

fn wc_importer_default_english_mappings(var_mappings rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.new_bool(
		rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('en_US'), wc_importer_current_locale()))
		&& rt.is_true(rt.new_bool(var_mappings.dup().is_array()))))
		&& var_mappings.dup().array_count() > 0))
	{
		return var_mappings.dup()
	}
	mut var_weight_unit := rt.call_function('get_option', [
		rt.new_string('woocommerce_weight_unit'),
	])
	mut var_dimension_unit := rt.call_function('get_option', [
		rt.new_string('woocommerce_dimension_unit'),
	])
	mut var_new_mappings := rt.create_array([rt.ArrayItem{ key: 'ID', val: 'id' },
		rt.ArrayItem{ key: 'Type', val: 'type' }, rt.ArrayItem{ key: 'SKU', val: 'sku' },
		rt.ArrayItem{ key: 'Name', val: 'name' }, rt.ArrayItem{ key: 'Published', val: 'published' },
		rt.ArrayItem{ key: 'Is featured?', val: 'featured' },
		rt.ArrayItem{ key: 'Visibility in catalog', val: 'catalog_visibility' },
		rt.ArrayItem{ key: 'Short description', val: 'short_description' },
		rt.ArrayItem{ key: 'Description', val: 'description' },
		rt.ArrayItem{ key: 'Date sale price starts', val: 'date_on_sale_from' },
		rt.ArrayItem{ key: 'Date sale price ends', val: 'date_on_sale_to' },
		rt.ArrayItem{ key: 'Tax status', val: 'tax_status' },
		rt.ArrayItem{ key: 'Tax class', val: 'tax_class' }, rt.ArrayItem{
			key: 'In stock?'
			val: 'stock_status'
		}, rt.ArrayItem{ key: 'Stock', val: 'stock_quantity' },
		rt.ArrayItem{ key: 'Backorders allowed?', val: 'backorders' },
		rt.ArrayItem{ key: 'Low stock amount', val: 'low_stock_amount' },
		rt.ArrayItem{ key: 'Sold individually?', val: 'sold_individually' },
		rt.ArrayItem{ key: rt.call_function('sprintf', [rt.new_string('Weight (%s)'),
			var_weight_unit.dup()]), val: 'weight' }, rt.ArrayItem{ key: rt.call_function('sprintf', [
			rt.new_string('Length (%s)'), var_dimension_unit.dup()]), val: 'length' },
		rt.ArrayItem{ key: rt.call_function('sprintf', [rt.new_string('Width (%s)'),
			var_dimension_unit.dup()]), val: 'width' }, rt.ArrayItem{ key: rt.call_function('sprintf', [
			rt.new_string('Height (%s)'), var_dimension_unit.dup()]), val: 'height' },
		rt.ArrayItem{ key: 'Allow customer reviews?', val: 'reviews_allowed' },
		rt.ArrayItem{ key: 'Purchase note', val: 'purchase_note' },
		rt.ArrayItem{ key: 'Sale price', val: 'sale_price' },
		rt.ArrayItem{ key: 'Regular price', val: 'regular_price' },
		rt.ArrayItem{ key: 'Categories', val: 'category_ids' },
		rt.ArrayItem{ key: 'Tags', val: 'tag_ids' }, rt.ArrayItem{
			key: 'Shipping class'
			val: 'shipping_class_id'
		}, rt.ArrayItem{ key: 'Images', val: 'images' }, rt.ArrayItem{
			key: 'Download limit'
			val: 'download_limit'
		}, rt.ArrayItem{ key: 'Download expiry days', val: 'download_expiry' },
		rt.ArrayItem{ key: 'Parent', val: 'parent_id' }, rt.ArrayItem{
			key: 'Upsells'
			val: 'upsell_ids'
		}, rt.ArrayItem{ key: 'Cross-sells', val: 'cross_sell_ids' },
		rt.ArrayItem{ key: 'Grouped products', val: 'grouped_products' },
		rt.ArrayItem{ key: 'External URL', val: 'product_url' },
		rt.ArrayItem{ key: 'Button text', val: 'button_text' },
		rt.ArrayItem{ key: 'Position', val: 'menu_order' }])
	if rt.is_true(rt.call_method(rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}),
		'get', [
		Class_Automattic_WooCommerce_Internal_CostOfGoodsSold_CostOfGoodsSoldController.class(),
	]), 'feature_is_enabled', []rt.PhpVal{}))
	{
		var_new_mappings.array_set('Cost of goods', 'cogs_value')
	}
	return rt.call_function('array_merge', [var_mappings.dup(),
		var_new_mappings.dup()])
}

fn wc_importer_default_special_english_mappings(var_mappings rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.new_bool(
		rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('en_US'), wc_importer_current_locale()))
		&& rt.is_true(rt.new_bool(var_mappings.dup().is_array()))))
		&& var_mappings.dup().array_count() > 0))
	{
		return var_mappings.dup()
	}
	mut var_new_mappings := rt.create_array([
		rt.ArrayItem{ key: 'Attribute %d name', val: 'attributes:name' },
		rt.ArrayItem{ key: 'Attribute %d value(s)', val: 'attributes:value' },
		rt.ArrayItem{ key: 'Attribute %d visible', val: 'attributes:visible' },
		rt.ArrayItem{ key: 'Attribute %d global', val: 'attributes:taxonomy' },
		rt.ArrayItem{ key: 'Attribute %d default', val: 'attributes:default' },
		rt.ArrayItem{ key: 'Download %d ID', val: 'downloads:id' },
		rt.ArrayItem{ key: 'Download %d name', val: 'downloads:name' },
		rt.ArrayItem{ key: 'Download %d URL', val: 'downloads:url' },
		rt.ArrayItem{ key: 'Meta: %s', val: 'meta:' },
	])
	return rt.call_function('array_merge', [var_mappings.dup(),
		var_new_mappings.dup()])
}

pub fn init_wp_content_plugins_woocommerce_includes_admin_importers_mappings_default_php() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		// unsupported expression: Expr_Exit
	}
	rt.call_function('add_filter', [
		rt.new_string('woocommerce_csv_product_import_mapping_default_columns'),
		rt.new_string('wc_importer_default_english_mappings'),
		rt.new_int(100),
	])
	rt.call_function('add_filter', [
		rt.new_string('woocommerce_csv_product_import_mapping_special_columns'),
		rt.new_string('wc_importer_default_special_english_mappings'),
		rt.new_int(100),
	])
}
