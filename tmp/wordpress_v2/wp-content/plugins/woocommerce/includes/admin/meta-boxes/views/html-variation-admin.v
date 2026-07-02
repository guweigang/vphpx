import rt

struct Class_Automattic_WooCommerce_Utilities_I18nUtil {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_utilities_i18nutil(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Utilities_I18nUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_I18nUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Utilities_I18nUtil) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Utilities_I18nUtil) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_I18nUtil) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_variation_id := rt.new_null()
	mut var_variation_object := rt.new_null()
	mut var_product_object := rt.new_null()
	mut var_loop := rt.new_null()
	mut var_variation := rt.new_null()
	mut var_variation_data := rt.new_null()
	mut var_base_cost := rt.new_null()
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Edit'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_variation_id.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Remove'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [
		rt.new_string('Drag and drop, or click to set admin variation order'),
		rt.new_string('woocommerce'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_variation_id.clone()]))
	// unsupported statement: Stmt_InlineHTML
	mut var_attribute_values := rt.call_method(var_variation_object, 'get_attributes', [
		rt.new_string('edit'),
	])
	mut iter_1 := rt.call_method(var_product_object, 'get_attributes', [
		rt.new_string('edit'),
	]).iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_attribute := item_1.val
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_attribute, 'get_variation',
			[]rt.PhpVal{})))))
		{
			continue
		}
		mut var_selected_value := if var_attribute_values.array_isset(rt.call_function('sanitize_title', [
			rt.call_method(var_attribute, 'get_name', []rt.PhpVal{}),
		]))
		{ var_attribute_values.array_get(rt.call_function('sanitize_title', [
				rt.call_method(var_attribute, 'get_name', []rt.PhpVal{}),
			])) } else { rt.new_string('') }
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [
			rt.new_string(
				(rt.call_function('sanitize_title', [rt.call_method(var_attribute, 'get_name', []rt.PhpVal{})])).str() +
				'[${var_loop.to_string()}]'),
		]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('printf', [
			rt.call_function('esc_html__', [rt.new_string('Any %s&hellip;'),
				rt.new_string('woocommerce')]),
			rt.call_function('wc_attribute_label', [
				rt.call_method(var_attribute, 'get_name', []rt.PhpVal{}),
			]),
		])
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(rt.call_method(var_attribute, 'is_taxonomy', []rt.PhpVal{})) {
			// unsupported statement: Stmt_InlineHTML
			mut iter_2 := rt.call_method(var_attribute, 'get_terms', []rt.PhpVal{}).iterator()
			for {
				item_2 := iter_2.next() or { break }
				mut var_option := item_2.val
				// unsupported statement: Stmt_InlineHTML
				// unsupported statement: Stmt_InlineHTML
				rt.call_function('selected', [var_selected_value.clone(),
					rt.get_property(var_option, 'slug')])
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_attr', [
					rt.get_property(var_option, 'slug'),
				]))
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_html', [
					rt.call_function('apply_filters', [
						rt.new_string('woocommerce_variation_option_name'),
						rt.get_property(var_option, 'name'),
						var_option.clone(),
						rt.call_method(var_attribute, 'get_name', []rt.PhpVal{}),
						var_product_object.clone(),
					]),
				]))
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
				rt.call_function('selected', [var_selected_value.clone(),
					var_option.clone()])
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_attr', [var_option.clone()]))
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_html', [
					rt.call_function('apply_filters', [
						rt.new_string('woocommerce_variation_option_name'),
						var_option.clone(),
						rt.new_null(),
						rt.call_method(var_attribute, 'get_name', []rt.PhpVal{}),
						var_product_object.clone(),
					]),
				]))
				// unsupported statement: Stmt_InlineHTML
				// unsupported statement: Stmt_InlineHTML
			}
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_loop.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_variation_id.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_loop.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [
		rt.call_method(var_variation_object, 'get_menu_order', [
			rt.new_string('edit')]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string('woocommerce_variation_header'),
		var_variation.clone(), var_loop.clone()])
	// unsupported statement: Stmt_InlineHTML
	print(if rt.is_true(rt.call_method(var_variation_object, 'get_image_id', [
		rt.new_string('edit'),
	]))
	{ 'remove' } else { '' })
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(if rt.is_true(rt.call_method(var_variation_object, 'get_image_id', [
		rt.new_string('edit'),
	]))
	{ rt.call_function('esc_attr__', [rt.new_string('Remove this image'),
			rt.new_string('woocommerce')]) } else { rt.call_function('esc_attr__', [
			rt.new_string('Upload an image'),
			rt.new_string('woocommerce'),
		]) })
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_variation_id.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(if rt.is_true(rt.call_method(var_variation_object, 'get_image_id', [
		rt.new_string('edit'),
	]))
	{ rt.call_function('esc_url', [
			rt.call_function('wp_get_attachment_thumb_url', [
				rt.call_method(var_variation_object, 'get_image_id', [
					rt.new_string('edit'),
				]),
			]),
		]) } else { rt.call_function('esc_url', [
			rt.call_function('wc_placeholder_img_src', []rt.PhpVal{}),
		]) })
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_loop.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [
		rt.call_method(var_variation_object, 'get_image_id', [
			rt.new_string('edit')]),
	]))
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.call_function('wc_product_sku_enabled', []rt.PhpVal{})) {
		rt.call_function('woocommerce_wp_text_input', [
			rt.create_array([
				rt.ArrayItem{ key: 'id', val: 'variable_sku${var_loop.to_string()}' },
				rt.ArrayItem{ key: 'name', val: 'variable_sku[${var_loop.to_string()}]' },
				rt.ArrayItem{ key: 'value', val: rt.call_method(var_variation_object, 'get_sku', [
					rt.new_string('edit'),
				]) },
				rt.ArrayItem{ key: 'placeholder', val: rt.call_method(var_variation_object,
					'get_sku', []rt.PhpVal{}) },
				rt.ArrayItem{ key: 'label', val: '<abbr title="' +
					(rt.call_function('esc_attr__', [rt.new_string('Stock Keeping Unit'), rt.new_string('woocommerce')])).str() +
					'">' +
					(rt.call_function('esc_html__', [rt.new_string('SKU'), rt.new_string('woocommerce')])).str() +
					'</abbr>' },
				rt.ArrayItem{ key: 'desc_tip', val: true },
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('SKU refers to a Stock-keeping unit, a unique identifier for each distinct product and service that can be purchased.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'wrapper_class', val: 'form-row' },
			]),
		])
	}
	rt.call_function('woocommerce_wp_text_input', [
		rt.create_array([
			rt.ArrayItem{ key: 'id', val: 'variable_global_unique_id${var_loop.to_string()}' },
			rt.ArrayItem{ key: 'name', val: 'variable_global_unique_id[${var_loop.to_string()}]' },
			rt.ArrayItem{ key: 'value', val: rt.call_method(var_variation_object,
				'get_global_unique_id', [rt.new_string('edit')]) },
			rt.ArrayItem{ key: 'placeholder', val: rt.call_method(var_variation_object,
				'get_global_unique_id', []rt.PhpVal{}) },
			rt.ArrayItem{
				key: 'label'
				val: rt.call_function('sprintf', [
					rt.call_function('__', [rt.new_string('%1$s, %2$s, %3$s, or %4$s'),
						rt.new_string('woocommerce')]),
					rt.new_string('<abbr title="' +
						(rt.call_function('esc_attr__', [rt.new_string('Global Trade Item Number'), rt.new_string('woocommerce')])).str() +
						'">' +
						(rt.call_function('esc_html__', [rt.new_string('GTIN'), rt.new_string('woocommerce')])).str() +
						'</abbr>'),
					rt.new_string('<abbr title="' +
						(rt.call_function('esc_attr__', [rt.new_string('Universal Product Code'), rt.new_string('woocommerce')])).str() +
						'">' +
						(rt.call_function('esc_html__', [rt.new_string('UPC'), rt.new_string('woocommerce')])).str() +
						'</abbr>'),
					rt.new_string('<abbr title="' +
						(rt.call_function('esc_attr__', [rt.new_string('European Article Number'), rt.new_string('woocommerce')])).str() +
						'">' +
						(rt.call_function('esc_html__', [rt.new_string('EAN'), rt.new_string('woocommerce')])).str() +
						'</abbr>'),
					rt.new_string('<abbr title="' +
						(rt.call_function('esc_attr__', [rt.new_string('International Standard Book Number'), rt.new_string('woocommerce')])).str() +
						'">' +
						(rt.call_function('esc_html__', [rt.new_string('ISBN'), rt.new_string('woocommerce')])).str() +
						'</abbr>'),
				])
			},
			rt.ArrayItem{ key: 'desc_tip', val: true },
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Enter a barcode or any other identifier unique to this product. It can help you list this product on other channels or marketplaces.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'wrapper_class', val: 'form-row' },
		]),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Enabled'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_loop.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('checked', [
		rt.call_function('in_array', [
			rt.call_method(var_variation_object, 'get_status', [
				rt.new_string('edit')]),
			rt.create_array([rt.ArrayItem{ key: none, val: 'publish' },
				rt.ArrayItem{ key: none, val: false }]),
			rt.new_bool(true),
		]),
		rt.new_bool(true),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [
		rt.new_string('Enable this option if access is given to a downloadable file upon purchase of a product'),
		rt.new_string('woocommerce'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Downloadable'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_loop.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('checked', [
		rt.call_method(var_variation_object, 'get_downloadable', [
			rt.new_string('edit')]),
		rt.new_bool(true),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [
		rt.new_string('Enable this option if a product is not shipped or there is no shipping cost'),
		rt.new_string('woocommerce'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Virtual'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_loop.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('checked', [
		rt.call_method(var_variation_object, 'get_virtual', [
			rt.new_string('edit')]),
		rt.new_bool(true),
	])
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.identical(rt.new_string('yes'), rt.call_function('get_option', [
		rt.new_string('woocommerce_manage_stock'),
	])))
	{
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_attr_e', [
			rt.new_string('Enable this option to enable stock management at variation level'),
			rt.new_string('woocommerce'),
		])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Manage stock?'),
			rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [var_loop.clone()]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('checked', [
			rt.call_method(var_variation_object, 'get_manage_stock', []rt.PhpVal{}),
			rt.new_bool(true),
		])
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string('woocommerce_variation_options'),
		var_loop.clone(), var_variation_data.clone(), var_variation.clone()])
	// unsupported statement: Stmt_InlineHTML
	// unsupported statement: Stmt_InlineHTML
	mut var_tax_label := rt.new_string('')
	if rt.is_true(rt.call_function('wc_tax_enabled', []rt.PhpVal{})) {
		mut var_tax_text := if rt.is_true(rt.call_function('wc_prices_include_tax', []rt.PhpVal{})) { rt.call_function('__', [
				rt.new_string('incl. tax'),
				rt.new_string('woocommerce'),
			]) } else { rt.call_function('__', [rt.new_string('ex. tax'),
				rt.new_string('woocommerce')]) }
		var_tax_label = rt.new_string(' (' + var_tax_text.str() + ')')
	}
	mut var_label := rt.call_function('sprintf', [
		rt.call_function('__', [rt.new_string('Regular price (%1$s%2$s)'),
			rt.new_string('woocommerce')]),
		rt.call_function('get_woocommerce_currency_symbol', []rt.PhpVal{}),
		rt.new_string((if rt.is_true(var_tax_label) { ' ' + var_tax_label.str() } else { '' }).str()),
	])
	rt.call_function('woocommerce_wp_text_input', [
		rt.create_array([
			rt.ArrayItem{ key: 'id', val: 'variable_regular_price_${var_loop.to_string()}' },
			rt.ArrayItem{ key: 'name', val: 'variable_regular_price[${var_loop.to_string()}]' },
			rt.ArrayItem{ key: 'value', val: rt.call_function('wc_format_localized_price', [
				rt.call_method(var_variation_object, 'get_regular_price', [
					rt.new_string('edit'),
				]),
			]) },
			rt.ArrayItem{ key: 'label', val: var_label },
			rt.ArrayItem{ key: 'data_type', val: 'price' },
			rt.ArrayItem{ key: 'wrapper_class', val: 'form-row form-row-first' },
			rt.ArrayItem{ key: 'placeholder', val: rt.call_function('__', [
				rt.new_string('Variation price (required)'),
				rt.new_string('woocommerce'),
			]) },
		]),
	])
	var_label = rt.call_function('sprintf', [
		rt.call_function('__', [rt.new_string('Sale price (%1$s%2$s)'),
			rt.new_string('woocommerce')]),
		rt.call_function('get_woocommerce_currency_symbol', []rt.PhpVal{}),
		rt.new_string((if rt.is_true(var_tax_label) { ' ' + var_tax_label.str() } else { '' }).str()),
	])
	rt.call_function('woocommerce_wp_text_input', [
		rt.create_array([
			rt.ArrayItem{ key: 'id', val: 'variable_sale_price${var_loop.to_string()}' },
			rt.ArrayItem{ key: 'name', val: 'variable_sale_price[${var_loop.to_string()}]' },
			rt.ArrayItem{ key: 'value', val: rt.call_function('wc_format_localized_price', [
				rt.call_method(var_variation_object, 'get_sale_price', [
					rt.new_string('edit'),
				]),
			]) },
			rt.ArrayItem{ key: 'data_type', val: 'price' },
			rt.ArrayItem{ key: 'label', val: var_label.str() +
				' <a href="#" class="sale_schedule">' +
				(rt.call_function('esc_html__', [rt.new_string('Schedule'), rt.new_string('woocommerce')])).str() +
				'</a><a href="#" class="cancel_sale_schedule hidden">' +
				(rt.call_function('esc_html__', [rt.new_string('Cancel schedule'), rt.new_string('woocommerce')])).str() +
				'</a>' },
			rt.ArrayItem{ key: 'wrapper_class', val: 'form-row form-row-last' },
		]),
	])
	mut var_sale_price_dates_from_timestamp := if rt.is_true(rt.call_method(var_variation_object, 'get_date_on_sale_from', [
		rt.new_string('edit'),
	]))
	{ rt.call_method(rt.call_method(var_variation_object, 'get_date_on_sale_from', [
			rt.new_string('edit'),
		]), 'getOffsetTimestamp', []rt.PhpVal{}) } else { rt.new_bool(false) }
	mut var_sale_price_dates_to_timestamp := if rt.is_true(rt.call_method(var_variation_object, 'get_date_on_sale_to', [
		rt.new_string('edit'),
	]))
	{ rt.call_method(rt.call_method(var_variation_object, 'get_date_on_sale_to', [
			rt.new_string('edit'),
		]), 'getOffsetTimestamp', []rt.PhpVal{}) } else { rt.new_bool(false) }
	mut var_sale_price_dates_from := if rt.is_true(var_sale_price_dates_from_timestamp) { rt.call_function('date_i18n', [
			rt.new_string('Y-m-d'),
			var_sale_price_dates_from_timestamp.clone(),
		]) } else { rt.new_string('') }
	mut var_sale_price_dates_to := if rt.is_true(var_sale_price_dates_to_timestamp) { rt.call_function('date_i18n', [
			rt.new_string('Y-m-d'),
			var_sale_price_dates_to_timestamp.clone(),
		]) } else { rt.new_string('') }
	print(
		'<div class="form-field sale_price_dates_fields hidden">\n\t\t\t\t\t<p class="form-row form-row-first">\n\t\t\t\t\t\t<label>' +
		(rt.call_function('esc_html__', [rt.new_string('Sale start date'), rt.new_string('woocommerce')])).str() +
		'</label>\n\t\t\t\t\t\t<input type="text" class="sale_price_dates_from" name="variable_sale_price_dates_from[' +
		(rt.call_function('esc_attr', [var_loop.clone()])).str() + ']" value="' +
		(rt.call_function('esc_attr', [var_sale_price_dates_from.clone()])).str() +
		'" placeholder="' +
		(rt.call_function('esc_attr_x', [rt.new_string('From&hellip;'), rt.new_string('placeholder'), rt.new_string('woocommerce')])).str() +
		' YYYY-MM-DD" maxlength="10" pattern="' +
		(rt.call_function('esc_attr', [rt.call_function('apply_filters', [rt.new_string('woocommerce_date_input_html_pattern'), rt.new_string('[0-9]{4}-(0[1-9]|1[012])-(0[1-9]|1[0-9]|2[0-9]|3[01])')])])).str() +
		'" />\n\t\t\t\t\t</p>\n\t\t\t\t\t<p class="form-row form-row-last">\n\t\t\t\t\t\t<label>' +
		(rt.call_function('esc_html__', [rt.new_string('Sale end date'), rt.new_string('woocommerce')])).str() +
		'</label>\n\t\t\t\t\t\t<input type="text" class="sale_price_dates_to" name="variable_sale_price_dates_to[' +
		(rt.call_function('esc_attr', [var_loop.clone()])).str() + ']" value="' +
		(rt.call_function('esc_attr', [var_sale_price_dates_to.clone()])).str() +
		'" placeholder="' +
		(rt.call_function('esc_attr_x', [rt.new_string('To&hellip;'), rt.new_string('placeholder'), rt.new_string('woocommerce')])).str() +
		'  YYYY-MM-DD" maxlength="10" pattern="' +
		(rt.call_function('esc_attr', [rt.call_function('apply_filters', [rt.new_string('woocommerce_date_input_html_pattern'), rt.new_string('[0-9]{4}-(0[1-9]|1[012])-(0[1-9]|1[0-9]|2[0-9]|3[01])')])])).str() +
		'" />\n\t\t\t\t\t</p>\n\t\t\t\t</div>')
	rt.call_function('do_action', [
		rt.new_string('woocommerce_variation_options_pricing'),
		var_loop.clone(),
		var_variation_data.clone(),
		var_variation.clone(),
	])
	// unsupported statement: Stmt_InlineHTML
	if !(var_base_cost.clone().is_null()) {
		// unsupported statement: Stmt_InlineHTML
		var_label = rt.call_function('sprintf', [
			rt.call_function('__', [rt.new_string('Cost (%s)'),
				rt.new_string('woocommerce')]),
			rt.call_function('get_woocommerce_currency_symbol', []rt.PhpVal{}),
		])
		mut var_variation_cogs := rt.call_method(var_variation_object, 'get_cogs_value',
			[]rt.PhpVal{})
		rt.call_function('woocommerce_wp_text_input', [
			rt.create_array([
				rt.ArrayItem{ key: 'id', val: 'variable_cost_value_${var_loop.to_string()}' },
				rt.ArrayItem{ key: 'name', val: 'variable_cost_value[${var_loop.to_string()}]' },
				rt.ArrayItem{
					key: 'value'
					val: if var_variation_cogs.clone().is_null() { rt.new_string('') } else { rt.call_function('wc_format_localized_price', [
							var_variation_cogs.clone(),
						]) }
				},
				rt.ArrayItem{ key: 'label', val: var_label },
				rt.ArrayItem{ key: 'data_type', val: 'price' },
				rt.ArrayItem{
					key: 'wrapper_class'
					val: 'form-row form-row-first variation-cost-field'
				},
				rt.ArrayItem{
					key: 'description_hidden'
					val: !(var_variation_cogs.clone().is_null())
				},
				rt.ArrayItem{ key: 'description', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.call_function('__', [
						rt.new_string('Add the amount it costs you to buy or make this product. Leave blank to use the default value from "General".'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: none, val: rt.call_function('__', [
						rt.new_string('You can specify a <a href="#" class="switch-to-general-tab">default value</a> for all variations'),
						rt.new_string('woocommerce'),
					]) },
				]) },
				rt.ArrayItem{ key: 'placeholder', val: rt.call_function('sprintf', [
					rt.call_function('__', [
						rt.new_string('%s (default)'),
						rt.new_string('woocommerce'),
					]),
					rt.call_function('wc_format_localized_price', [
						var_base_cost.clone(),
					]),
				]) },
			]),
		])
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.identical(rt.new_string('yes'), rt.call_function('get_option', [
		rt.new_string('woocommerce_manage_stock'),
	])))
	{
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('woocommerce_wp_text_input', [
			rt.create_array([
				rt.ArrayItem{ key: 'id', val: 'variable_stock${var_loop.to_string()}' },
				rt.ArrayItem{ key: 'name', val: 'variable_stock[${var_loop.to_string()}]' },
				rt.ArrayItem{ key: 'value', val: rt.call_function('wc_stock_amount', [
					rt.call_method(var_variation_object, 'get_stock_quantity', [
						rt.new_string('edit'),
					]),
				]) },
				rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
					rt.new_string('Stock quantity'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'desc_tip', val: true },
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string("Enter a number to set stock quantity at the variation level. Use a variation's 'Manage stock?' check box above to enable/disable stock management at the variation level."),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'number' },
				rt.ArrayItem{ key: 'custom_attributes', val: rt.create_array([
					rt.ArrayItem{ key: 'step', val: 'any' },
				]) },
				rt.ArrayItem{ key: 'data_type', val: 'stock' },
				rt.ArrayItem{ key: 'wrapper_class', val: 'form-row form-row-first' },
			]),
		])
		print('<input type="hidden" name="variable_original_stock[' +
			(rt.call_function('esc_attr', [var_loop.clone()])).str() + ']" value="' +
			(rt.call_function('esc_attr', [rt.call_function('wc_stock_amount', [rt.call_method(var_variation_object, 'get_stock_quantity', [rt.new_string('edit')])])])).str() +
			'" />')
		rt.call_function('woocommerce_wp_select', [
			rt.create_array([
				rt.ArrayItem{ key: 'id', val: 'variable_backorders${var_loop.to_string()}' },
				rt.ArrayItem{ key: 'name', val: 'variable_backorders[${var_loop.to_string()}]' },
				rt.ArrayItem{ key: 'value', val: rt.call_method(var_variation_object,
					'get_backorders', [rt.new_string('edit')]) },
				rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
					rt.new_string('Allow backorders?'), rt.new_string('woocommerce')]) },
				rt.ArrayItem{ key: 'options', val: rt.call_function('wc_get_product_backorder_options',
					[]rt.PhpVal{}) },
				rt.ArrayItem{ key: 'desc_tip', val: true },
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('If managing stock, this controls whether or not backorders are allowed. If enabled, stock quantity can go below 0.'),
					rt.new_string('woocommerce')]) },
				rt.ArrayItem{ key: 'wrapper_class', val: 'form-row form-row-last' },
			]),
		])
		mut var_low_stock_placeholder := if rt.is_true(rt.call_method(var_product_object, 'get_manage_stock', []rt.PhpVal{})) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), rt.call_method(var_product_object, 'get_low_stock_amount', []rt.PhpVal{}))))) { rt.call_function('sprintf', [
				rt.call_function('esc_attr__', [
					rt.new_string("Parent product's threshold (%d)"),
					rt.new_string('woocommerce'),
				]),
				rt.call_function('esc_attr', [
					rt.call_method(var_product_object, 'get_low_stock_amount', []rt.PhpVal{}),
				]),
			]) } else { rt.call_function('sprintf', [
				rt.call_function('esc_attr__', [
					rt.new_string('Store-wide threshold (%d)'),
					rt.new_string('woocommerce'),
				]),
				rt.call_function('esc_attr', [
					rt.call_function('get_option', [
						rt.new_string('woocommerce_notify_low_stock_amount'),
					]),
				]),
			]) }
		rt.call_function('woocommerce_wp_text_input', [
			rt.create_array([
				rt.ArrayItem{ key: 'id', val: 'variable_low_stock_amount${var_loop.to_string()}' },
				rt.ArrayItem{ key: 'name', val: 'variable_low_stock_amount[${var_loop.to_string()}]' },
				rt.ArrayItem{ key: 'value', val: rt.call_method(var_variation_object,
					'get_low_stock_amount', [rt.new_string('edit')]) },
				rt.ArrayItem{ key: 'placeholder', val: var_low_stock_placeholder },
				rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
					rt.new_string('Low stock threshold'), rt.new_string('woocommerce')]) },
				rt.ArrayItem{ key: 'desc_tip', val: true },
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('When variation stock reaches this amount you will be notified by email. The default value for all variations can be set in the product Inventory tab. The shop default value can be set in Settings > Products > Inventory.'),
					rt.new_string('woocommerce')]) },
				rt.ArrayItem{ key: 'type', val: 'number' },
				rt.ArrayItem{ key: 'custom_attributes', val: rt.create_array([
					rt.ArrayItem{ key: 'step', val: 'any' }]) },
				rt.ArrayItem{ key: 'wrapper_class', val: 'form-row' },
			]),
		])
		rt.call_function('do_action', [
			rt.new_string('woocommerce_variation_options_inventory'),
			var_loop.clone(),
			var_variation_data.clone(),
			var_variation.clone(),
		])
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('woocommerce_wp_select', [
		rt.create_array([
			rt.ArrayItem{ key: 'id', val: 'variable_stock_status${var_loop.to_string()}' },
			rt.ArrayItem{ key: 'name', val: 'variable_stock_status[${var_loop.to_string()}]' },
			rt.ArrayItem{ key: 'value', val: rt.call_method(var_variation_object,
				'get_stock_status', [rt.new_string('edit')]) },
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('Stock status'), rt.new_string('woocommerce')]) },
			rt.ArrayItem{ key: 'options', val: rt.call_function('wc_get_product_stock_status_options',
				[]rt.PhpVal{}) },
			rt.ArrayItem{ key: 'desc_tip', val: true },
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Controls whether or not the product is listed as "in stock" or "out of stock" on the frontend.'),
				rt.new_string('woocommerce')]) },
			rt.ArrayItem{ key: 'wrapper_class', val: 'form-row form-row-full variable_stock_status' },
		]),
	])
	if rt.is_true(rt.call_function('wc_product_weight_enabled', []rt.PhpVal{})) {
		mut iife_temp_0 := Class_Automattic_WooCommerce_Utilities_I18nUtil{}
		mut iife_result_0 := iife_temp_0.get_weight_unit_label(rt.call_function('get_option', [
			rt.new_string('woocommerce_weight_unit'),
			rt.new_string('kg'),
		]))
		var_label = rt.call_function('sprintf', [
			rt.call_function('__', [rt.new_string('Weight (%s)'),
				rt.new_string('woocommerce')]),
			iife_result_0,
		])
		rt.call_function('woocommerce_wp_text_input', [
			rt.create_array([
				rt.ArrayItem{ key: 'id', val: 'variable_weight${var_loop.to_string()}' },
				rt.ArrayItem{ key: 'name', val: 'variable_weight[${var_loop.to_string()}]' },
				rt.ArrayItem{ key: 'value', val: rt.call_function('wc_format_localized_decimal', [
					rt.call_method(var_variation_object, 'get_weight', [
						rt.new_string('edit'),
					]),
				]) },
				rt.ArrayItem{ key: 'placeholder', val: rt.call_function('wc_format_localized_decimal', [
					rt.call_method(var_product_object, 'get_weight', []rt.PhpVal{}),
				]) },
				rt.ArrayItem{ key: 'label', val: var_label },
				rt.ArrayItem{ key: 'desc_tip', val: true },
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Weight in decimal form'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'text' },
				rt.ArrayItem{ key: 'data_type', val: 'decimal' },
				rt.ArrayItem{
					key: 'wrapper_class'
					val: 'form-row form-row-first hide_if_variation_virtual'
				},
			]),
		])
	}
	if rt.is_true(rt.call_function('wc_product_dimensions_enabled', []rt.PhpVal{})) {
		mut var_parent_length := rt.call_function('wc_format_localized_decimal', [
			rt.call_method(var_product_object, 'get_length', []rt.PhpVal{}),
		])
		mut var_parent_width := rt.call_function('wc_format_localized_decimal', [
			rt.call_method(var_product_object, 'get_width', []rt.PhpVal{}),
		])
		mut var_parent_height := rt.call_function('wc_format_localized_decimal', [
			rt.call_method(var_product_object, 'get_height', []rt.PhpVal{}),
		])
		// unsupported statement: Stmt_InlineHTML
		mut iife_temp_1 := Class_Automattic_WooCommerce_Utilities_I18nUtil{}
		mut iife_result_1 := iife_temp_1.get_dimensions_unit_label(rt.call_function('get_option', [
			rt.new_string('woocommerce_dimension_unit'),
		]))
		mut iife_temp_2 := Class_Automattic_WooCommerce_Utilities_I18nUtil{}
		mut iife_result_2 := iife_temp_2.get_dimensions_unit_label(rt.call_function('get_option', [
			rt.new_string('woocommerce_dimension_unit'),
		]))
		rt.call_function('printf', [
			rt.call_function('esc_html__', [
				rt.new_string('Dimensions (L&times;W&times;H) (%s)'),
				rt.new_string('woocommerce'),
			]),
			rt.call_function('esc_html', [
				iife_result_1,
			]),
		])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('wc_help_tip', [
			rt.call_function('__', [
				rt.new_string('Length x width x height in decimal form'),
				rt.new_string('woocommerce'),
			]),
		]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(if rt.is_true(var_parent_length) { rt.call_function('esc_attr', [
				var_parent_length.clone(),
			]) } else { rt.call_function('esc_attr__', [rt.new_string('Length'),
				rt.new_string('woocommerce')]) })
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [var_loop.clone()]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [
			rt.call_function('wc_format_localized_decimal', [
				rt.call_method(var_variation_object, 'get_length', [
					rt.new_string('edit'),
				]),
			]),
		]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(if rt.is_true(var_parent_width) { rt.call_function('esc_attr', [
				var_parent_width.clone(),
			]) } else { rt.call_function('esc_attr__', [rt.new_string('Width'),
				rt.new_string('woocommerce')]) })
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [var_loop.clone()]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [
			rt.call_function('wc_format_localized_decimal', [
				rt.call_method(var_variation_object, 'get_width', [
					rt.new_string('edit')]),
			]),
		]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(if rt.is_true(var_parent_height) { rt.call_function('esc_attr', [
				var_parent_height.clone(),
			]) } else { rt.call_function('esc_attr__', [rt.new_string('Height'),
				rt.new_string('woocommerce')]) })
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [var_loop.clone()]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [
			rt.call_function('wc_format_localized_decimal', [
				rt.call_method(var_variation_object, 'get_height', [
					rt.new_string('edit'),
				]),
			]),
		]))
		// unsupported statement: Stmt_InlineHTML
	}
	rt.call_function('do_action', [
		rt.new_string('woocommerce_variation_options_dimensions'),
		var_loop.clone(),
		var_variation_data.clone(),
		var_variation.clone(),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Shipping class'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('wp_dropdown_categories', [
		rt.create_array([rt.ArrayItem{ key: 'taxonomy', val: 'product_shipping_class' },
			rt.ArrayItem{ key: 'hide_empty', val: 0 }, rt.ArrayItem{ key: 'show_option_none', val: rt.call_function('__', [
				rt.new_string('Same as parent'),
				rt.new_string('woocommerce'),
			]) }, rt.ArrayItem{ key: 'name', val: 'variable_shipping_class[' + var_loop.str() + ']' },
			rt.ArrayItem{ key: 'id', val: '' }, rt.ArrayItem{ key: 'selected', val: rt.call_method(var_variation_object,
				'get_shipping_class_id', [
				rt.new_string('edit'),
			]) }]),
	])
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.call_function('wc_tax_enabled', []rt.PhpVal{})) {
		rt.call_function('woocommerce_wp_select', [
			rt.create_array([
				rt.ArrayItem{ key: 'id', val: 'variable_tax_class${var_loop.to_string()}' },
				rt.ArrayItem{ key: 'name', val: 'variable_tax_class[${var_loop.to_string()}]' },
				rt.ArrayItem{ key: 'value', val: rt.call_method(var_variation_object,
					'get_tax_class', [rt.new_string('edit')]) },
				rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
					rt.new_string('Tax class'), rt.new_string('woocommerce')]) },
				rt.ArrayItem{ key: 'options', val: rt.add(rt.create_array([
					rt.ArrayItem{ key: 'parent', val: rt.call_function('__', [
						rt.new_string('Same as parent'),
						rt.new_string('woocommerce'),
					]) }]), rt.call_function('wc_get_product_tax_class_options', []rt.PhpVal{})) },
				rt.ArrayItem{ key: 'desc_tip', val: 'true' },
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Choose a tax class for this product. Tax classes are used to apply different tax rates specific to certain types of product.'),
					rt.new_string('woocommerce')]) },
				rt.ArrayItem{ key: 'wrapper_class', val: 'form-row form-row-full' },
			]),
		])
		rt.call_function('do_action', [
			rt.new_string('woocommerce_variation_options_tax'),
			var_loop.clone(),
			var_variation_data.clone(),
			var_variation.clone(),
		])
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('woocommerce_wp_textarea_input', [
		rt.create_array([
			rt.ArrayItem{ key: 'id', val: 'variable_description${var_loop.to_string()}' },
			rt.ArrayItem{ key: 'name', val: 'variable_description[${var_loop.to_string()}]' },
			rt.ArrayItem{ key: 'value', val: rt.call_method(var_variation_object,
				'get_description', [rt.new_string('edit')]) },
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('Description'), rt.new_string('woocommerce')]) },
			rt.ArrayItem{ key: 'desc_tip', val: true },
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Enter an optional description for this variation.'),
				rt.new_string('woocommerce')]) },
			rt.ArrayItem{ key: 'wrapper_class', val: 'form-row form-row-full' },
		]),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Downloadable files'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Name'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wc_help_tip', [
		rt.call_function('__', [
			rt.new_string('This is the name of the download shown to the customer.'),
			rt.new_string('woocommerce'),
		]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('File URL'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wc_help_tip', [
		rt.call_function('__', [
			rt.new_string('This is the URL or absolute path to the file which customers will get access to. URLs entered here should already be encoded.'),
			rt.new_string('woocommerce'),
		]),
	]))
	// unsupported statement: Stmt_InlineHTML
	mut var_downloadable_files := rt.call_method(var_variation_object, 'get_downloads', [
		rt.new_string('edit'),
	])
	mut var_disabled_downloads_count := 0
	if rt.is_true(var_downloadable_files) {
		mut iter_4 := var_downloadable_files.iterator()
		for {
			item_4 := iter_4.next() or { break }
			mut var_file := item_4.val
			mut var_key := item_4.key
			mut var_disabled_download := var_file.array_isset(rt.new_string('enabled'))
				&& rt.is_true(rt.identical(rt.new_bool(false), var_file.array_get(rt.new_string('enabled'))))
			var_disabled_downloads_count = var_disabled_downloads_count + i64(var_disabled_download)
			rt.include_file(@DIR + '/html-product-variation-download.php', '1')
		}
	}
	// unsupported statement: Stmt_InlineHTML
	mut var_key := rt.new_string('')
	mut var_file := {
		'file': ''
		'name': ''
	}
	mut var_disabled_download := false
	rt.call_function('ob_start', []rt.PhpVal{})
	rt.include_file(@DIR + '/html-product-variation-download.php', '3')
	rt.echo_val(rt.call_function('esc_attr', [
		rt.call_function('ob_get_clean', []rt.PhpVal{}),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Add file'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	if var_disabled_downloads_count != 0 {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('printf', [
			rt.call_function('esc_html__', [
				rt.new_string('The indicated downloads have been disabled (invalid location or filetype&mdash;%1$slearn more%2$s).'),
				rt.new_string('woocommerce'),
			]),
			rt.new_string('<a href="https://woocommerce.com/document/approved-download-directories" target="_blank">'),
			rt.new_string('</a>'),
		])
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('woocommerce_wp_text_input', [
		rt.create_array([
			rt.ArrayItem{ key: 'id', val: 'variable_download_limit${var_loop.to_string()}' },
			rt.ArrayItem{ key: 'name', val: 'variable_download_limit[${var_loop.to_string()}]' },
			rt.ArrayItem{
				key: 'value'
				val: if rt.is_true(rt.less(rt.call_method(var_variation_object, 'get_download_limit', [
					rt.new_string('edit'),
				]), rt.new_int(0)))
				{ rt.new_string('') } else { rt.call_method(var_variation_object, 'get_download_limit', [
						rt.new_string('edit'),
					]) }
			},
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('Download limit'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'placeholder', val: rt.call_function('__', [
				rt.new_string('Unlimited'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Leave blank for unlimited re-downloads.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'number' },
			rt.ArrayItem{ key: 'desc_tip', val: true },
			rt.ArrayItem{ key: 'custom_attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'step', val: '1' },
				rt.ArrayItem{ key: 'min', val: '0' },
			]) },
			rt.ArrayItem{ key: 'wrapper_class', val: 'form-row form-row-first' },
		]),
	])
	rt.call_function('woocommerce_wp_text_input', [
		rt.create_array([
			rt.ArrayItem{ key: 'id', val: 'variable_download_expiry${var_loop.to_string()}' },
			rt.ArrayItem{ key: 'name', val: 'variable_download_expiry[${var_loop.to_string()}]' },
			rt.ArrayItem{
				key: 'value'
				val: if rt.is_true(rt.less(rt.call_method(var_variation_object, 'get_download_expiry', [
					rt.new_string('edit'),
				]), rt.new_int(0)))
				{ rt.new_string('') } else { rt.call_method(var_variation_object, 'get_download_expiry', [
						rt.new_string('edit'),
					]) }
			},
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('Download expiry'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'placeholder', val: rt.call_function('__', [
				rt.new_string('Never'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Enter the number of days before a download link expires, or leave blank.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'number' },
			rt.ArrayItem{ key: 'desc_tip', val: true },
			rt.ArrayItem{ key: 'custom_attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'step', val: '1' },
				rt.ArrayItem{ key: 'min', val: '0' },
			]) },
			rt.ArrayItem{ key: 'wrapper_class', val: 'form-row form-row-last' },
		]),
	])
	rt.call_function('do_action', [
		rt.new_string('woocommerce_variation_options_download'),
		var_loop.clone(),
		var_variation_data.clone(),
		var_variation.clone(),
	])
	// unsupported statement: Stmt_InlineHTML
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [
		rt.new_string('woocommerce_product_after_variable_attributes'),
		var_loop.clone(),
		var_variation_data.clone(),
		var_variation.clone(),
	])
	// unsupported statement: Stmt_InlineHTML
	// unsupported statement: Stmt_InlineHTML
}
