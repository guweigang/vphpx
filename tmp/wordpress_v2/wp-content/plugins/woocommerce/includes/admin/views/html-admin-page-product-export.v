import rt

struct Class_WC_Product_CSV_Exporter {
	rt.PhpObjectBase
}

struct Class_WC_Admin_Exporters {
	rt.PhpObjectBase
}

fn create_wc_product_csv_exporter(_args ...rt.PhpVal) &Class_WC_Product_CSV_Exporter {
	mut obj := &Class_WC_Product_CSV_Exporter{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_admin_exporters(_args ...rt.PhpVal) &Class_WC_Admin_Exporters {
	mut obj := &Class_WC_Admin_Exporters{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Product_CSV_Exporter) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Product_CSV_Exporter) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Product_CSV_Exporter) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_Admin_Exporters) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Admin_Exporters) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Admin_Exporters) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
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
	rt.call_function('wp_enqueue_script', [rt.new_string('wc-product-export')])
	mut var_exporter := create_wc_product_csv_exporter()
	mut var_product_ids_to_export := rt.new_array()
	mut var_is_exporting_product_ids := false
	if !(!rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('product_ids')))) {
		rt.call_function('check_admin_referer', [
			rt.new_string('export-selected-products'),
		])
		mut var_ids_raw := rt.call_function('explode', [rt.new_string(','),
			rt.call_function('sanitize_text_field', [
				rt.call_function('wp_unslash', [
					rt.get_superglobal('_GET').array_get(rt.new_string('product_ids')),
				]),
			])])
		var_product_ids_to_export = rt.call_function('array_filter', [
			rt.call_function('array_map', [rt.new_string('absint'),
				var_ids_raw.clone()]),
		])
		var_is_exporting_product_ids = if !(!rt.is_true(var_product_ids_to_export)) {
			true
		} else {
			false
		}
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Export Products'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	if var_is_exporting_product_ids {
		mut var_clear_url := rt.call_function('remove_query_arg', [
			rt.new_string('product_ids'),
		])
		mut var_count := var_product_ids_to_export.clone().array_count()
		mut var_notice := rt.call_function('sprintf', [
			rt.call_function('_n', [
				rt.new_string('You are about to export %1$d product. To export all products, <a href="%2$s">clear your selection</a>.'),
				rt.new_string('You are about to export %1$d products. To export all products, <a href="%2$s">clear your selection</a>.'),
				rt.new_int(var_count).clone(),
				rt.new_string('woocommerce'),
			]),
			rt.new_int(var_count).clone(),
			rt.call_function('esc_url', [
				var_clear_url.clone(),
			]),
		])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('wp_kses_post', [var_notice.clone()]))
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	if var_is_exporting_product_ids {
		print('<input type="hidden" name="product_ids" value="' +
			(rt.call_function('esc_attr', [rt.call_function('implode', [rt.new_string(','), var_product_ids_to_export.clone()])])).str() +
			'" />')
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Export products to a CSV file'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	if var_is_exporting_product_ids {
		rt.call_function('esc_html_e', [
			rt.new_string('This tool allows you to generate and download a CSV file containing the selected products.'),
			rt.new_string('woocommerce'),
		])
	} else {
		rt.call_function('esc_html_e', [
			rt.new_string('This tool allows you to generate and download a CSV file containing a list of all products.'),
			rt.new_string('woocommerce'),
		])
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Which columns should be exported?'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('Export all columns'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	mut iter_1 := var_exporter.get_default_column_names().iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_column_name := item_1.val
		mut var_column_id := item_1.key
		print('<option value="' + (rt.call_function('esc_attr', [var_column_id.clone()])).str() +
			'">' + (rt.call_function('esc_html', [var_column_name.clone()])).str() + '</option>')
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Downloads'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Attributes'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	if !var_is_exporting_product_ids {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [
			rt.new_string('Which product types should be exported?'),
			rt.new_string('woocommerce'),
		])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_attr_e', [rt.new_string('Export all products'),
			rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		mut iife_temp_0 := Class_WC_Admin_Exporters{}
		mut iife_result_0 := iife_temp_0.get_product_types()
		mut iter_2 := iife_result_0.iterator()
		for {
			item_2 := iter_2.next() or { break }
			mut var_label := item_2.val
			mut var_value := item_2.key
			print('<option value="' + (rt.call_function('esc_attr', [var_value.clone()])).str() +
				'">' + (rt.call_function('esc_html', [var_label.clone()])).str() + '</option>')
		}
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [
			rt.new_string('Which product category should be exported?'),
			rt.new_string('woocommerce'),
		])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_attr_e', [rt.new_string('Export all categories'),
			rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		mut var_categories := rt.call_function('get_categories', [
			rt.create_array([rt.ArrayItem{ key: 'taxonomy', val: 'product_cat' },
				rt.ArrayItem{ key: 'hide_empty', val: false }]),
		])
		mut iter_3 := var_categories.iterator()
		for {
			item_3 := iter_3.next() or { break }
			mut var_category := item_3.val
			print('<option value="' +
				(rt.call_function('esc_attr', [rt.get_property(var_category, 'slug')])).str() +
				'">' +
				(rt.call_function('esc_html', [rt.get_property(var_category, 'name')])).str() +
				'</option>')
		}
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Export custom meta?'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Yes, export all custom meta'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string('woocommerce_product_export_row')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('Generate CSV'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Generate CSV'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
}
