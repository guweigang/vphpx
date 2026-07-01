import rt

fn wc_importer_generic_mappings(var_mappings rt.PhpVal) rt.PhpVal {
	mut var_generic_mappings := rt.create_array([
		rt.ArrayItem{ key: rt.call_function('__', [rt.new_string('Title'),
			rt.new_string('woocommerce')]), val: 'name' },
		rt.ArrayItem{ key: rt.call_function('__', [rt.new_string('Product Title'),
			rt.new_string('woocommerce')]), val: 'name' },
		rt.ArrayItem{ key: rt.call_function('__', [rt.new_string('Price'),
			rt.new_string('woocommerce')]), val: 'regular_price' },
		rt.ArrayItem{ key: rt.call_function('__', [rt.new_string('Parent SKU'),
			rt.new_string('woocommerce')]), val: 'parent_id' },
		rt.ArrayItem{ key: rt.call_function('__', [rt.new_string('Quantity'),
			rt.new_string('woocommerce')]), val: 'stock_quantity' },
		rt.ArrayItem{ key: rt.call_function('__', [rt.new_string('Menu order'),
			rt.new_string('woocommerce')]), val: 'menu_order' },
	])
	return rt.call_function('array_merge', [var_mappings.dup(),
		var_generic_mappings.dup()])
}

pub fn init_wp_content_plugins_woocommerce_includes_admin_importers_mappings_generic_php() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		// unsupported expression: Expr_Exit
	}
	rt.call_function('add_filter', [
		rt.new_string('woocommerce_csv_product_import_mapping_default_columns'),
		rt.new_string('wc_importer_generic_mappings'),
	])
}
