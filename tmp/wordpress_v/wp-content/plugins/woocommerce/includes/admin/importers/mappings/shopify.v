import rt

fn wc_importer_shopify_mappings(var_mappings rt.PhpVal, var_raw_headers rt.PhpVal) rt.PhpVal {
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return var_mappings.dup()
	}
	mut var_shopify_mappings := { 'Variant SKU': 'sku', 'Title': 'name', 'Body (HTML)': 'description', 'Quantity': 'stock_quantity', 'Variant Inventory Qty': 'stock_quantity', 'Image Src': 'images', 'Variant Image': 'images', 'Variant SKU': 'sku', 'Variant Price': 'sale_price', 'Variant Compare At Price': 'regular_price', 'Type': 'category_ids', 'Tags': 'tag_ids_spaces', 'Variant Grams': 'weight', 'Variant Requires Shipping': 'meta:shopify_requires_shipping', 'Variant Taxable': 'tax_status' }
	return rt.call_function('array_merge', [var_mappings.dup(), var_shopify_mappings.dup()])
}

fn wc_importer_shopify_special_mappings(var_mappings rt.PhpVal, var_raw_headers rt.PhpVal) rt.PhpVal {
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return var_mappings.dup()
	}
	mut var_shopify_mappings := { 'Option%d Name': 'attributes:name', 'Option%d Value': 'attributes:value' }
	return rt.call_function('array_merge', [var_mappings.dup(), var_shopify_mappings.dup()])
}

fn wc_importer_shopify_expand_data(var_data rt.PhpVal) rt.PhpVal {
	if var_data.array_isset(rt.new_string('meta:shopify_requires_shipping')) {
		mut var_requires_shipping := rt.call_function('wc_string_to_bool', [var_data.array_get('meta:shopify_requires_shipping')])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_requires_shipping)))) {
			if var_data.array_isset(rt.new_string('type')) {
				var_data.array_get_mut('type').array_push('virtual')
			} else {
				var_data['type'] = rt.create_array([rt.ArrayItem{ key: none, val: 'virtual' }])
			}
		}
		var_data.delete('meta:shopify_requires_shipping')
	}
	return var_data.dup()
}



pub fn init_wp_content_plugins_woocommerce_includes_admin_importers_mappings_shopify_php() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))))) {
		// unsupported expression: Expr_Exit
	}
	rt.call_function('add_filter', [rt.new_string('woocommerce_csv_product_import_mapping_default_columns'), rt.new_string('wc_importer_shopify_mappings'), rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_filter', [rt.new_string('woocommerce_csv_product_import_mapping_special_columns'), rt.new_string('wc_importer_shopify_special_mappings'), rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_filter', [rt.new_string('woocommerce_product_importer_pre_expand_data'), rt.new_string('wc_importer_shopify_expand_data')])
}
