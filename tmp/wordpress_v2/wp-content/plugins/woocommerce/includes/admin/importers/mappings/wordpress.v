import rt

fn wc_importer_wordpress_mappings(var_mappings rt.PhpVal) rt.PhpVal {
	mut var_wp_mappings := map[string]rt.PhpVal{}
	var_wp_mappings = {
		'post_id':      'id'
		'post_title':   'name'
		'post_content': 'description'
		'post_excerpt': 'short_description'
		'post_parent':  'parent_id'
	}
	return rt.call_function('array_merge', [var_mappings.clone(),
		rt.create_array_from_native_map(var_wp_mappings)])
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
	rt.call_function('add_filter', [
		rt.new_string('woocommerce_csv_product_import_mapping_default_columns'),
		rt.new_string('wc_importer_wordpress_mappings'),
	])
}
