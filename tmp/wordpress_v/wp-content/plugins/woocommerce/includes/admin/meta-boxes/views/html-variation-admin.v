import rt



pub fn init_wp_content_plugins_woocommerce_includes_admin_meta_boxes_views_html_variation_admin_php() {
	mut var_variation_id := rt.new_null()
	mut var_variation_object := rt.new_null()
	mut var_product_object := rt.new_null()
	mut var_loop := rt.new_null()
	mut var_variation := rt.new_null()
	mut var_variation_data := rt.new_null()
	mut var_base_cost := rt.new_null()
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Edit'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_variation_id.dup()]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Remove'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('Drag and drop, or click to set admin variation order'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_variation_id.dup()]))
	// unsupported statement: Stmt_InlineHTML
	mut var_attribute_values := rt.call_method(var_variation_object, 'get_attributes', [rt.new_string('edit')])
	{
		mut iter_1 := rt.call_method(var_product_object, 'get_attributes', [rt.new_string('edit')]).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_attribute := item_1.val
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_attribute, 'get_variation', []rt.PhpVal{}))))) {
				continue
			}
			mut var_selected_value := if var_attribute_values.array_isset(rt.call_function('sanitize_title', [rt.call_method(var_attribute, 'get_name', []rt.PhpVal{})])) { var_attribute_values.array_get(rt.call_function('sanitize_title', [rt.call_method(var_attribute, 'get_name', []rt.PhpVal{})])) } else { rt.new_string('') }
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [(rt.call_function('sanitize_title', [rt.call_method(var_attribute, 'get_name', []rt.PhpVal{})])).str() + "[${var_loop.to_string()}]"]))
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('printf', [rt.call_function('esc_html__', [rt.new_string('Any %s&hellip;'), rt.new_string('woocommerce')]), rt.call_function('wc_attribute_label', [rt.call_method(var_attribute, 'get_name', []rt.PhpVal{})])])
			// unsupported statement: Stmt_Nop
			// unsupported statement: Stmt_InlineHTML
			if rt.is_true(rt.call_method(var_attribute, 'is_taxonomy', []rt.PhpVal{})) {
				// unsupported statement: Stmt_InlineHTML
				{
					mut iter_2 := rt.call_method(var_attribute, 'get_terms', []rt.PhpVal{}).iterator()
					for {
						item_2 := iter_2.next() or { break }
						mut var_option := item_2.val
						// unsupported statement: Stmt_InlineHTML
						// unsupported statement: Stmt_Nop
						// unsupported statement: Stmt_InlineHTML
						rt.call_function('selected', [var_selected_value.dup(), rt.get_property(var_option, 'slug')])
						// unsupported statement: Stmt_InlineHTML
						rt.echo_val(rt.call_function('esc_attr', [rt.get_property(var_option, 'slug')]))
						// unsupported statement: Stmt_InlineHTML
						rt.echo_val(rt.call_function('esc_html', [rt.call_function('apply_filters', [rt.new_string('woocommerce_variation_option_name'), rt.get_property(var_option, 'name'), var_option.dup(), rt.call_method(var_attribute, 'get_name', []rt.PhpVal{}), var_product_object.dup()])]))
						// unsupported statement: Stmt_InlineHTML
						// unsupported statement: Stmt_Nop
						// unsupported statement: Stmt_InlineHTML
					}
				}
				// unsupported statement: Stmt_InlineHTML
			} else {
				// unsupported statement: Stmt_InlineHTML
				{
					mut iter_2 := rt.call_method(var_attribute, 'get_options', []rt.PhpVal{}).iterator()
					for {
						item_2 := iter_2.next() or { break }
						mut var_option := item_2.val
						// unsupported statement: Stmt_InlineHTML
						// unsupported statement: Stmt_Nop
						// unsupported statement: Stmt_InlineHTML
						rt.call_function('selected', [var_selected_value.dup(), var_option.dup()])
						// unsupported statement: Stmt_InlineHTML
						rt.echo_val(rt.call_function('esc_attr', [var_option.dup()]))
						// unsupported statement: Stmt_InlineHTML
						rt.echo_val(rt.call_function('esc_html', [rt.call_function('apply_filters', [rt.new_string('woocommerce_variation_option_name'), var_option.dup(), rt.new_null(), rt.call_method(var_attribute, 'get_name', []rt.PhpVal{}), var_product_object.dup()])]))
						// unsupported statement: Stmt_InlineHTML
						// unsupported statement: Stmt_Nop
						// unsupported statement: Stmt_InlineHTML
					}
				}
				// unsupported statement: Stmt_InlineHTML
			}
			// unsupported statement: Stmt_InlineHTML
		}
	}
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_loop.dup()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_variation_id.dup()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_loop.dup()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [rt.call_method(var_variation_object, 'get_menu_order', [rt.new_string('edit')])]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string('woocommerce_variation_header'), var_variation.dup(), var_loop.dup()])
	// unsupported statement: Stmt_InlineHTML
	print(if rt.is_true(rt.call_method(var_variation_object, 'get_image_id', [rt.new_string('edit')])) { 'remove' } else { '' })
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(if rt.is_true(rt.call_method(var_variation_object, 'get_image_id', [rt.new_string('edit')])) { rt.call_function('esc_attr__', [rt.new_string('Remove this image'), rt.new_string('woocommerce')]) } else { rt.call_function('esc_attr__', [rt.new_string('Upload an image'), rt.new_string('woocommerce')]) })
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_variation_id.dup()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(if rt.is_true(rt.call_method(var_variation_object, 'get_image_id', [rt.new_string('edit')])) { rt.call_function('esc_url', [rt.call_function('wp_get_attachment_thumb_url', [rt.call_method(var_variation_object, 'get_image_id', [rt.new_string('edit')])])]) } else { rt.call_function('esc_url', [rt.call_function('wc_placeholder_img_src', []rt.PhpVal{})]) })
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_loop.dup()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [rt.call_method(var_variation_object, 'get_image_id', [rt.new_string('edit')])]))
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.call_function('wc_product_sku_enabled', []rt.PhpVal{})) {
		rt.call_function('woocommerce_wp_text_input', [rt.create_array([rt.ArrayItem{ key: 'id', val: "variable_sku${var_loop.to_string()}" }, rt.ArrayItem{ key: 'name', val: "variable_sku[${var_loop.to_string()}]" }, rt.ArrayItem{ key: 'value', val: rt.call_method(var_variation_object, 'get_sku', [rt.new_string('edit')]) }, rt.ArrayItem{ key: 'placeholder', val: rt.call_method(var_variation_object, 'get_sku', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'label', val: '<abbr title="' + (rt.call_function('esc_attr__', [rt.new_string('Stock Keeping Unit'), rt.new_string('woocommerce')])).str() + '">' + (rt.call_function('esc_html__', [rt.new_string('SKU'), rt.new_string('woocommerce')])).str() + '</abbr>' }, rt.ArrayItem{ key: 'desc_tip', val: true }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('SKU refers to a Stock-keeping unit, a unique identifier for each distinct product and service that can be purchased.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'wrapper_class', val: 'form-row' }])])
	}
	rt.call_function('woocommerce_wp_text_input', [rt.create_array([rt.ArrayItem{ key: 'id', val: "variable_global_unique_id${var_loop.to_string()}" }, rt.ArrayItem{ key: 'name', val: "variable_global_unique_id[${var_loop.to_string()}]" }, rt.ArrayItem{ key: 'value', val: rt.call_method(var_variation_object, 'get_global_unique_id', [rt.new_string('edit')]) }, rt.ArrayItem{ key: 'placeholder', val: rt.call_method(var_variation_object, 'get_global_unique_id', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'label', val: rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('%1$s, %2$s, %3$s, or %4$s'), rt.new_string('woocommerce')]), '<abbr title="' + (rt.call_function('esc_attr__', [rt.new_string('Global Trade Item Number'), rt.new_string('woocommerce')])).str() + '">' + (rt.call_function('esc_html__', [rt.new_string('GTIN'), rt.new_string('woocommerce')])).str() + '</abbr>', '<abbr title="' + (rt.call_function('esc_attr__', [rt.new_string('Universal Product Code'), rt.new_string('woocommerce')])).str() + '">' + (rt.call_function('esc_html__', [rt.new_string('UPC'), rt.new_string('woocommerce')])).str() + '</abbr>', '<abbr title="' + (rt.call_function('esc_attr__', [rt.new_string('European Article Number'), rt.new_string('woocommerce')])).str() + '">' + (rt.call_function('esc_html__', [rt.new_string('EAN'), rt.new_string('woocommerce')])).str() + '</abbr>', '<abbr title="' + (rt.call_function('esc_attr__', [rt.new_string('International Standard Book Number'), rt.new_string('woocommerce')])).str() + '">' + (rt.call_function('esc_html__', [rt.new_string('ISBN'), rt.new_string('woocommerce')])).str() + '</abbr>']) }, rt.ArrayItem{ key: 'desc_tip', val: true }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Enter a barcode or any other identifier unique to this product. It can help you list this product on other channels or marketplaces.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'wrapper_class', val: 'form-row' }])])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Enabled'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_loop.dup()]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('checked', [rt.call_function('in_array', [rt.call_method(var_variation_object, 'get_status', [rt.new_string('edit')]), rt.create_array([rt.ArrayItem{ key: none, val: 'publish' }, rt.ArrayItem{ key: none, val: false }]), rt.new_bool(true)]), rt.new_bool(true)])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('Enable this option if access is given to a downloadable file upon purchase of a product'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Downloadable'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_loop.dup()]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('checked', [rt.call_method(var_variation_object, 'get_downloadable', [rt.new_string('edit')]), rt.new_bool(true)])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('Enable this option if a product is not shipped or there is no shipping cost'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Virtual'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_loop.dup()]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('checked', [, ])
	// unsupported statement: Stmt_InlineHTML
}
