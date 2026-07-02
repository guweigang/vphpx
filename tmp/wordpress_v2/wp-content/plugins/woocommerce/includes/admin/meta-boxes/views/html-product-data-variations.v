import rt


fn main() {
	defer {
		rt.shutdown()
	}

	mut var_variation_attributes := rt.new_null()
	mut var_default_attributes := rt.new_null()
	mut var_product_object := rt.new_null()
	mut var_variations_count := rt.new_null()
	mut var_variations_total_pages := rt.new_null()
	mut var_modal_title := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))))) {
		exit(0)
	}
	mut var_add_attributes_img_url := rt.new_string((rt.get_constant('WC_ADMIN_IMAGES_FOLDER_URL')).str() + '/icons/info.svg')
	mut var_background_img_url := rt.new_string((rt.get_constant('WC_ADMIN_IMAGES_FOLDER_URL')).str() + '/product_data/no-variation-background-image.svg')
	mut var_arrow_img_url := rt.new_string((rt.get_constant('WC_ADMIN_IMAGES_FOLDER_URL')).str() + '/product_data/no-variation-arrow.svg')
	// unsupported statement: Stmt_InlineHTML
	if !(!(var_variation_attributes).is_null()) || !(var_variation_attributes.clone().is_array()) || var_variation_attributes.clone().array_count() == 0 {
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_url', [var_add_attributes_img_url.clone()]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('wp_kses_post', [rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Add some attributes in the <a class="variations-add-attributes-link" href="%1$s">Attributes</a> tab to generate variations. Make sure to check the <b>Used for variations</b> box. <a class="variations-learn-more-link" href="%2$s" target="_blank" rel="noreferrer">Learn more</a>'), rt.new_string('woocommerce')]), rt.call_function('esc_url', [rt.new_string('#product_attributes')]), rt.call_function('esc_url', [rt.new_string('https://woocommerce.com/document/variable-product/')])])]))
		// unsupported statement: Stmt_InlineHTML
	} else {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Default Form Values'), rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('wc_help_tip', [rt.call_function('__', [rt.new_string('Choose a default form value if you want a certain variation already selected when a user visits the product page.'), rt.new_string('woocommerce')])]))
		// unsupported statement: Stmt_InlineHTML
		mut iter_1 := var_variation_attributes.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_attribute := item_1.val
			mut var_selected_value := if var_default_attributes.array_isset(rt.call_function('sanitize_title', [rt.call_method(var_attribute, 'get_name', []rt.PhpVal{})])) { var_default_attributes.array_get(rt.call_function('sanitize_title', [rt.call_method(var_attribute, 'get_name', []rt.PhpVal{})])) } else { rt.new_string('') }
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [rt.call_function('sanitize_title', [rt.call_method(var_attribute, 'get_name', []rt.PhpVal{})])]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [var_selected_value.clone()]))
			// unsupported statement: Stmt_InlineHTML
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_html', [rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('No default %s&hellip;'), rt.new_string('woocommerce')]), rt.call_function('wc_attribute_label', [rt.call_method(var_attribute, 'get_name', []rt.PhpVal{})])])]))
			// unsupported statement: Stmt_InlineHTML
			if rt.is_true(rt.call_method(var_attribute, 'is_taxonomy', []rt.PhpVal{})) {
				// unsupported statement: Stmt_InlineHTML
				mut iter_2 := rt.call_method(var_attribute, 'get_terms', []rt.PhpVal{}).iterator()
				for {
					item_2 := iter_2.next() or { break }
					mut var_option := item_2.val
					// unsupported statement: Stmt_InlineHTML
					// unsupported statement: Stmt_InlineHTML
					rt.call_function('selected', [var_selected_value.clone(), rt.get_property(var_option, 'slug')])
					// unsupported statement: Stmt_InlineHTML
					rt.echo_val(rt.call_function('esc_attr', [rt.get_property(var_option, 'slug')]))
					// unsupported statement: Stmt_InlineHTML
					rt.echo_val(rt.call_function('esc_html', [rt.call_function('apply_filters', [rt.new_string('woocommerce_variation_option_name'), rt.get_property(var_option, 'name'), var_option.clone(), rt.call_method(var_attribute, 'get_name', []rt.PhpVal{}), var_product_object.clone()])]))
					// unsupported statement: Stmt_InlineHTML
					// unsupported statement: Stmt_InlineHTML
				}
				// unsupported statement: Stmt_InlineHTML
			} else {
				// unsupported statement: Stmt_InlineHTML
				mut iter_3 := rt.call_method(var_attribute, 'get_options', []rt.PhpVal{}).iterator()
				for {
					item_3 := iter_3.next() or { break }
					mut var_option := item_3.val
					// unsupported statement: Stmt_InlineHTML
					// unsupported statement: Stmt_InlineHTML
					rt.call_function('selected', [var_selected_value.clone(), var_option.clone()])
					// unsupported statement: Stmt_InlineHTML
					rt.echo_val(rt.call_function('esc_attr', [var_option.clone()]))
					// unsupported statement: Stmt_InlineHTML
					rt.echo_val(rt.call_function('esc_html', [rt.call_function('apply_filters', [rt.new_string('woocommerce_variation_option_name'), var_option.clone(), rt.new_null(), rt.call_method(var_attribute, 'get_name', []rt.PhpVal{}), var_product_object.clone()])]))
					// unsupported statement: Stmt_InlineHTML
					// unsupported statement: Stmt_InlineHTML
				}
				// unsupported statement: Stmt_InlineHTML
			}
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('do_action', [rt.new_string('woocommerce_variable_product_before_variations')])
		// unsupported statement: Stmt_InlineHTML
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Generate variations'), rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Add manually'), rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Delete all variations'), rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_attr_e', [rt.new_string('Status'), rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Toggle &quot;Enabled&quot;'), rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Toggle &quot;Downloadable&quot;'), rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Toggle &quot;Virtual&quot;'), rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_attr_e', [rt.new_string('Pricing'), rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Set regular prices'), rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Increase regular prices (fixed amount or percentage)'), rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Decrease regular prices (fixed amount or percentage)'), rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Set sale prices'), rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Increase sale prices (fixed amount or percentage)'), rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Decrease sale prices (fixed amount or percentage)'), rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Set scheduled sale dates'), rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(rt.call_method(rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Internal_CostOfGoodsSold_CostOfGoodsSoldController.class()]), 'feature_is_enabled', []rt.PhpVal{})) {
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('esc_attr_e', [rt.new_string('Cost of goods'), rt.new_string('woocommerce')])
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('esc_html_e', [rt.new_string('Remove custom costs'), rt.new_string('woocommerce')])
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_attr_e', [rt.new_string('Inventory'), rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Toggle &quot;Manage stock&quot;'), rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Stock'), rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Set Status - In stock'), rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Set Status - Out of stock'), rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Set Status - On backorder'), rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Low stock threshold'), rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_attr_e', [rt.new_string('Shipping'), rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Length'), rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Width'), rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Height'), rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Weight'), rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_attr_e', [rt.new_string('Downloadable products'), rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Download limit'), rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Download expiry'), rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('do_action', [rt.new_string('woocommerce_variable_product_bulk_edit_actions')])
		// unsupported statement: Stmt_InlineHTML
		// unsupported statement: Stmt_InlineHTML
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_html', [rt.call_function('sprintf', [rt.call_function('_n', [rt.new_string('%s item'), rt.new_string('%s items'), var_variations_count.clone(), rt.new_string('woocommerce')]), var_variations_count.clone()])]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Expand'), rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Close'), rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_attr_e', [rt.new_string('Go to the first page'), rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_attr_e', [rt.new_string('Go to the previous page'), rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Select Page'), rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_attr_e', [rt.new_string('Current page'), rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		mut var_i := 1
		for {
			if !(rt.is_true(rt.less_equal(rt.new_int(var_i), var_variations_total_pages))) { break }
			// unsupported statement: Stmt_InlineHTML
			// unsupported statement: Stmt_InlineHTML
			print(var_i.str())
			// unsupported statement: Stmt_InlineHTML
			print(var_i.str())
			// unsupported statement: Stmt_InlineHTML
			// unsupported statement: Stmt_InlineHTML
			var_i += 1
		}
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_html_x', [rt.new_string('of'), rt.new_string('number of pages'), rt.new_string('woocommerce')]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_html', [var_variations_total_pages.clone()]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_attr_e', [rt.new_string('Go to the next page'), rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_attr_e', [rt.new_string('Go to the last page'), rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_url', [var_arrow_img_url.clone()]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_url', [var_background_img_url.clone()]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('No variations yet. Generate them from all added attributes or add a new variation manually.'), rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('wc_esc_json', [rt.call_function('wp_json_encode', [rt.call_function('wc_list_pluck', [var_variation_attributes.clone(), rt.new_string('get_data')])])]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [var_variations_count.clone()]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [var_variations_total_pages.clone()]))
		// unsupported statement: Stmt_InlineHTML
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Save changes'), rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Cancel'), rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_html', [rt.call_function('sprintf', [rt.call_function('_n', [rt.new_string('%s item'), rt.new_string('%s items'), var_variations_count.clone(), rt.new_string('woocommerce')]), var_variations_count.clone()])]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Expand'), rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Close'), rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_attr_e', [rt.new_string('Go to the first page'), rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_attr_e', [rt.new_string('Go to the previous page'), rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Select Page'), rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_attr_e', [rt.new_string('Current page'), rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		mut var_i := 1
		for {
			if !(rt.is_true(rt.less_equal(rt.new_int(var_i), var_variations_total_pages))) { break }
			// unsupported statement: Stmt_InlineHTML
			// unsupported statement: Stmt_InlineHTML
			print(var_i.str())
			// unsupported statement: Stmt_InlineHTML
			print(var_i.str())
			// unsupported statement: Stmt_InlineHTML
			// unsupported statement: Stmt_InlineHTML
			var_i += 1
		}
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_html_x', [rt.new_string('of'), rt.new_string('number of pages'), rt.new_string('woocommerce')]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_html', [var_variations_total_pages.clone()]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_attr_e', [rt.new_string('Go to the next page'), rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_attr_e', [rt.new_string('Go to the last page'), rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_modal_title.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Add price to all variations that don\'t have a price'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [rt.call_function('get_woocommerce_currency_symbol', []rt.PhpVal{})]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_textarea', [rt.call_function('get_woocommerce_currency', []rt.PhpVal{})]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Cancel'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Add prices'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
}
