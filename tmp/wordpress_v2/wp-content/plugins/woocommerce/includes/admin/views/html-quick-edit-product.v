import rt

struct Class_WC_Tax {
	rt.PhpObjectBase
}

fn create_wc_tax(_args ...rt.PhpVal) &Class_WC_Tax {
	mut obj := &Class_WC_Tax{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
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



fn main() {
	defer {
		rt.shutdown()
	}

	mut var_shipping_class := rt.new_null()
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(exit(0)))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Product data'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string('woocommerce_product_quick_edit_start')])
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.call_function('wc_product_sku_enabled', []rt.PhpVal{})) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('SKU'), rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Price'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('Regular price'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Sale'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('Sale price'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.call_method(rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Internal_CostOfGoodsSold_CostOfGoodsSoldController.class()]), 'feature_is_enabled', []rt.PhpVal{})) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Cost'), rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_attr_e', [rt.new_string('Cost value'), rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.call_function('wc_tax_enabled', []rt.PhpVal{})) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Tax status'), rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		mut var_options := rt.create_array([rt.ArrayItem{ key: Class_Automattic_WooCommerce_Enums_ProductTaxStatus.taxable(), val: rt.call_function('__', [rt.new_string('Taxable'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: Class_Automattic_WooCommerce_Enums_ProductTaxStatus.shipping(), val: rt.call_function('__', [rt.new_string('Shipping only'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: Class_Automattic_WooCommerce_Enums_ProductTaxStatus.none(), val: rt.call_function('_x', [rt.new_string('None'), rt.new_string('Tax status'), rt.new_string('woocommerce')]) }])
		mut iter_1 := var_options.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_value := item_1.val
			mut var_key := item_1.key
			print('<option value="' + (rt.call_function('esc_attr', [var_key.clone()])).str() + '">' + (rt.call_function('esc_html', [var_value.clone()])).str() + '</option>')
		}
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Tax class'), rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		var_options = rt.create_array([rt.ArrayItem{ key: '', val: rt.call_function('__', [rt.new_string('Standard'), rt.new_string('woocommerce')]) }])
		mut iife_temp_0 := Class_WC_Tax{}
		mut iife_result_0 := iife_temp_0.get_tax_classes()
		mut var_tax_classes := iife_result_0
		if !(!rt.is_true(var_tax_classes)) {
			mut iter_2 := var_tax_classes.iterator()
			for {
				item_2 := iter_2.next() or { break }
				mut var_class := item_2.val
				var_options.array_set(rt.call_function('sanitize_title', [var_class.clone()]), rt.call_function('esc_html', [var_class.clone()]))
			}
		}
		mut iter_3 := var_options.iterator()
		for {
			item_3 := iter_3.next() or { break }
			mut var_value := item_3.val
			mut var_key := item_3.key
			print('<option value="' + (rt.call_function('esc_attr', [var_key.clone()])).str() + '">' + (rt.call_function('esc_html', [var_value.clone()])).str() + '</option>')
		}
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.call_function('wc_product_weight_enabled', []rt.PhpVal{})) || rt.is_true(rt.call_function('wc_product_dimensions_enabled', []rt.PhpVal{})) {
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(rt.call_function('wc_product_weight_enabled', []rt.PhpVal{})) {
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('esc_html_e', [rt.new_string('Weight'), rt.new_string('woocommerce')])
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [rt.call_function('wc_format_localized_decimal', [rt.new_int(0)])]))
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(rt.call_function('wc_product_dimensions_enabled', []rt.PhpVal{})) {
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('esc_html_e', [rt.new_string('L/W/H'), rt.new_string('woocommerce')])
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('esc_attr_e', [rt.new_string('Length'), rt.new_string('woocommerce')])
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('esc_attr_e', [rt.new_string('Width'), rt.new_string('woocommerce')])
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('esc_attr_e', [rt.new_string('Height'), rt.new_string('woocommerce')])
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Shipping class'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('No shipping class'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	mut iter_4 := var_shipping_class.iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_value := item_4.val
		mut var_key := item_4.key
		print('<option value="' + (rt.call_function('esc_attr', [rt.get_property(var_value, 'slug')])).str() + '">' + (rt.call_function('esc_html', [rt.get_property(var_value, 'name')])).str() + '</option>')
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Visibility'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	var_options = rt.call_function('apply_filters', [rt.new_string('woocommerce_product_visibility_options'), rt.create_array([rt.ArrayItem{ key: Class_Automattic_WooCommerce_Enums_CatalogVisibility.visible(), val: rt.call_function('__', [rt.new_string('Catalog &amp; search'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: Class_Automattic_WooCommerce_Enums_CatalogVisibility.catalog(), val: rt.call_function('__', [rt.new_string('Catalog'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: Class_Automattic_WooCommerce_Enums_CatalogVisibility.search(), val: rt.call_function('__', [rt.new_string('Search'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: Class_Automattic_WooCommerce_Enums_CatalogVisibility.hidden(), val: rt.call_function('__', [rt.new_string('Hidden'), rt.new_string('woocommerce')]) }])])
	mut iter_5 := var_options.iterator()
	for {
		item_5 := iter_5.next() or { break }
		mut var_value := item_5.val
		mut var_key := item_5.key
		print('<option value="' + (rt.call_function('esc_attr', [var_key.clone()])).str() + '">' + (rt.call_function('esc_html', [var_value.clone()])).str() + '</option>')
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Featured'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.identical(rt.call_function('get_option', [rt.new_string('woocommerce_manage_stock')]), rt.new_string('yes'))) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Manage stock?'), rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('In stock?'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	print('<option value="" id="stock_status_no_change">' + (rt.call_function('esc_html__', [rt.new_string('— No Change —'), rt.new_string('woocommerce')])).str() + '</option>')
	mut iter_6 := rt.call_function('wc_get_product_stock_status_options', []rt.PhpVal{}).iterator()
	for {
		item_6 := iter_6.next() or { break }
		mut var_value := item_6.val
		mut var_key := item_6.key
		print('<option value="' + (rt.call_function('esc_attr', [var_key.clone()])).str() + '">' + (rt.call_function('esc_html', [var_value.clone()])).str() + '</option>')
	}
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html__', [rt.new_string('This will change the stock status of all variations.'), rt.new_string('woocommerce')]))
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.identical(rt.call_function('get_option', [rt.new_string('woocommerce_manage_stock')]), rt.new_string('yes'))) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Stock qty'), rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Backorders?'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	mut iter_7 := rt.call_function('wc_get_product_backorder_options', []rt.PhpVal{}).iterator()
	for {
		item_7 := iter_7.next() or { break }
		mut var_value := item_7.val
		mut var_key := item_7.key
		print('<option value="' + (rt.call_function('esc_attr', [var_key.clone()])).str() + '">' + (rt.call_function('esc_html', [var_value.clone()])).str() + '</option>')
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string('woocommerce_product_quick_edit_end')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [rt.call_function('wp_create_nonce', [rt.new_string('woocommerce_quick_edit_nonce')])]))
	// unsupported statement: Stmt_InlineHTML
}
