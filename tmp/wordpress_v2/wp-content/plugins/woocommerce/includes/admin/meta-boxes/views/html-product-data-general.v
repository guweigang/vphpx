import rt


fn main() {
	defer {
		rt.shutdown()
	}

	mut var_product_object := rt.new_null()
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(exit(0)))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('woocommerce_wp_text_input', [rt.create_array([rt.ArrayItem{ key: 'id', val: '_product_url' }, rt.ArrayItem{ key: 'value', val: if rt.call_function('is_callable', [rt.create_array([rt.ArrayItem{ key: none, val: var_product_object }, rt.ArrayItem{ key: none, val: 'get_product_url' }])]) { rt.call_method(var_product_object, 'get_product_url', [rt.new_string('edit')]) } else { rt.new_string('') } }, rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('Product URL'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'placeholder', val: 'https://' }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Enter the external URL to the product.'), rt.new_string('woocommerce')]) }])])
	rt.call_function('woocommerce_wp_text_input', [rt.create_array([rt.ArrayItem{ key: 'id', val: '_button_text' }, rt.ArrayItem{ key: 'value', val: if rt.call_function('is_callable', [rt.create_array([rt.ArrayItem{ key: none, val: var_product_object }, rt.ArrayItem{ key: none, val: 'get_button_text' }])]) { rt.call_method(var_product_object, 'get_button_text', [rt.new_string('edit')]) } else { rt.new_string('') } }, rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('Button text'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'placeholder', val: rt.call_function('_x', [rt.new_string('Buy product'), rt.new_string('placeholder'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('This text will be shown on the button linking to the external product.'), rt.new_string('woocommerce')]) }])])
	rt.call_function('do_action', [rt.new_string('woocommerce_product_options_external')])
	// unsupported statement: Stmt_InlineHTML
	mut var_cogs_controller := rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Internal_CostOfGoodsSold_CostOfGoodsSoldController.class()])
	mut var_cogs_is_enabled := rt.call_method(var_cogs_controller, 'feature_is_enabled', []rt.PhpVal{})
	// unsupported statement: Stmt_InlineHTML
	print(if rt.is_true(var_cogs_is_enabled) { ' show_if_variable' } else { '' })
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(var_cogs_is_enabled) {
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	mut var_tax_label := rt.new_string('')
	if rt.is_true(rt.call_function('wc_tax_enabled', []rt.PhpVal{})) {
	mut var_tax_text := if rt.is_true(rt.call_function('wc_prices_include_tax', []rt.PhpVal{})) { rt.call_function('__', [rt.new_string('incl. tax'), rt.new_string('woocommerce')]) } else { rt.call_function('__', [rt.new_string('ex. tax'), rt.new_string('woocommerce')]) }
	var_tax_label = rt.new_string(' (' + (var_tax_text).str() + ')')
	}
	rt.call_function('woocommerce_wp_text_input', [rt.create_array([rt.ArrayItem{ key: 'id', val: '_regular_price' }, rt.ArrayItem{ key: 'value', val: rt.call_method(var_product_object, 'get_regular_price', [rt.new_string('edit')]) }, rt.ArrayItem{ key: 'label', val: (rt.call_function('__', [rt.new_string('Regular price'), rt.new_string('woocommerce')])).str() + ' (' + (rt.call_function('get_woocommerce_currency_symbol', []rt.PhpVal{})).str() + ')' + (var_tax_label).str() }, rt.ArrayItem{ key: 'data_type', val: 'price' }])])
	rt.call_function('woocommerce_wp_text_input', [rt.create_array([rt.ArrayItem{ key: 'id', val: '_sale_price' }, rt.ArrayItem{ key: 'value', val: rt.call_method(var_product_object, 'get_sale_price', [rt.new_string('edit')]) }, rt.ArrayItem{ key: 'data_type', val: 'price' }, rt.ArrayItem{ key: 'label', val: (rt.call_function('__', [rt.new_string('Sale price'), rt.new_string('woocommerce')])).str() + ' (' + (rt.call_function('get_woocommerce_currency_symbol', []rt.PhpVal{})).str() + ')' + (var_tax_label).str() }, rt.ArrayItem{ key: 'description', val: '<a href="#" class="sale_schedule">' + (rt.call_function('__', [rt.new_string('Schedule'), rt.new_string('woocommerce')])).str() + '</a>' }])])
	mut var_sale_price_dates_from_timestamp := if rt.is_true(rt.call_method(var_product_object, 'get_date_on_sale_from', [rt.new_string('edit')])) { rt.call_method(rt.call_method(var_product_object, 'get_date_on_sale_from', [rt.new_string('edit')]), 'getOffsetTimestamp', []rt.PhpVal{}) } else { rt.new_bool(false) }
	mut var_sale_price_dates_to_timestamp := if rt.is_true(rt.call_method(var_product_object, 'get_date_on_sale_to', [rt.new_string('edit')])) { rt.call_method(rt.call_method(var_product_object, 'get_date_on_sale_to', [rt.new_string('edit')]), 'getOffsetTimestamp', []rt.PhpVal{}) } else { rt.new_bool(false) }
	mut var_sale_price_dates_from := if rt.is_true(var_sale_price_dates_from_timestamp) { rt.call_function('date_i18n', [rt.new_string('Y-m-d'), var_sale_price_dates_from_timestamp.clone()]) } else { rt.new_string('') }
	mut var_sale_price_dates_to := if rt.is_true(var_sale_price_dates_to_timestamp) { rt.call_function('date_i18n', [rt.new_string('Y-m-d'), var_sale_price_dates_to_timestamp.clone()]) } else { rt.new_string('') }
	mut var_date_input_html_pattern := rt.call_function('apply_filters', [rt.new_string('woocommerce_date_input_html_pattern'), rt.new_string('[0-9]{4}-(0[1-9]|1[012])-(0[1-9]|1[0-9]|2[0-9]|3[01])')])
	print('<p class="form-field sale_price_dates_fields">\n\t\t\t\t\t<label for="_sale_price_dates_from">' + (rt.call_function('esc_html__', [rt.new_string('Sale price dates'), rt.new_string('woocommerce')])).str() + '</label>\n\t\t\t\t\t<input type="text" class="short" name="_sale_price_dates_from" id="_sale_price_dates_from" value="' + (rt.call_function('esc_attr', [var_sale_price_dates_from.clone()])).str() + '" placeholder="' + (rt.call_function('esc_html', [rt.call_function('_x', [rt.new_string('From&hellip;'), rt.new_string('placeholder'), rt.new_string('woocommerce')])])).str() + ' YYYY-MM-DD" maxlength="10" pattern="' + (rt.call_function('esc_attr', [var_date_input_html_pattern.clone()])).str() + '" />\n\t\t\t\t\t<input type="text" class="short" name="_sale_price_dates_to" id="_sale_price_dates_to" value="' + (rt.call_function('esc_attr', [var_sale_price_dates_to.clone()])).str() + '" placeholder="' + (rt.call_function('esc_html', [rt.call_function('_x', [rt.new_string('To&hellip;'), rt.new_string('placeholder'), rt.new_string('woocommerce')])])).str() + '  YYYY-MM-DD" maxlength="10" pattern="' + (rt.call_function('esc_attr', [var_date_input_html_pattern.clone()])).str() + '" />\n\t\t\t\t\t<a href="#" class="description cancel_sale_schedule">' + (rt.call_function('esc_html__', [rt.new_string('Cancel'), rt.new_string('woocommerce')])).str() + '</a>' + (rt.call_function('wc_help_tip', [rt.call_function('__', [rt.new_string('The sale will start at 00:00:00 of "From" date and end at 23:59:59 of "To" date.'), rt.new_string('woocommerce')])])).str() + '\n\t\t\t\t</p>')
	rt.call_function('do_action', [rt.new_string('woocommerce_product_options_pricing')])
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(var_cogs_is_enabled) {
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(var_cogs_is_enabled) {
		// unsupported statement: Stmt_InlineHTML
		mut var_is_variable := rt.new_bool(rt.instance_of(var_product_object, 'WC_Product_Variable'))
		rt.call_function('woocommerce_wp_text_input', [rt.create_array([rt.ArrayItem{ key: 'id', val: '_cogs_value' }, rt.ArrayItem{ key: 'value', val: if !(rt.call_method(var_product_object, 'get_cogs_value', []rt.PhpVal{})).is_null() { rt.call_method(var_product_object, 'get_cogs_value', []rt.PhpVal{}) } else { rt.new_string('') } }, rt.ArrayItem{ key: 'label', val: (rt.call_function('__', [rt.new_string('Cost of goods'), rt.new_string('woocommerce')])).str() + ' (' + (rt.call_function('get_woocommerce_currency_symbol', []rt.PhpVal{})).str() + ')' }, rt.ArrayItem{ key: 'data_type', val: 'price' }, rt.ArrayItem{ key: 'desc_tip', val: 'true' }, rt.ArrayItem{ key: 'placeholder', val: '0' }, rt.ArrayItem{ key: 'description', val: rt.call_method(var_cogs_controller, 'get_general_cost_edit_field_tooltip', [var_is_variable.clone()]) }])])
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Downloadable files'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Name'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wc_help_tip', [rt.call_function('__', [rt.new_string('This is the name of the download shown to the customer.'), rt.new_string('woocommerce')])]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('File URL'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wc_help_tip', [rt.call_function('__', [rt.new_string('This is the URL or absolute path to the file which customers will get access to. URLs entered here should already be encoded.'), rt.new_string('woocommerce')])]))
	// unsupported statement: Stmt_InlineHTML
	mut var_downloadable_files := rt.call_method(var_product_object, 'get_downloads', [rt.new_string('edit')])
	mut var_disabled_downloads_count := 0
	if rt.is_true(var_downloadable_files) {
		mut iter_1 := var_downloadable_files.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_file := item_1.val
			mut var_key := item_1.key
			mut var_disabled_download := var_file.array_isset(rt.new_string('enabled')) && rt.is_true(rt.identical(rt.new_bool(false), var_file.array_get(rt.new_string('enabled'))))
			var_disabled_downloads_count = var_disabled_downloads_count + i64(var_disabled_download)
			rt.include_file(@DIR + '/html-product-download.php', '1')
		}
	}
	// unsupported statement: Stmt_InlineHTML
	mut var_key := rt.new_string('')
	mut var_file := { 'file': '', 'name': '' }
	mut var_disabled_download := false
	rt.call_function('ob_start', []rt.PhpVal{})
	rt.include_file(@DIR + '/html-product-download.php', '3')
	rt.echo_val(rt.call_function('esc_attr', [rt.call_function('ob_get_clean', []rt.PhpVal{})]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Add File'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	if var_disabled_downloads_count != 0 {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('printf', [rt.call_function('esc_html__', [rt.new_string('The indicated downloads have been disabled (invalid location or filetype&mdash;%1$slearn more%2$s).'), rt.new_string('woocommerce')]), rt.new_string('<a href="https://woocommerce.com/document/approved-download-directories" target="_blank">'), rt.new_string('</a>')])
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('woocommerce_wp_text_input', [rt.create_array([rt.ArrayItem{ key: 'id', val: '_download_limit' }, rt.ArrayItem{ key: 'value', val: if rt.is_true(rt.identical(-1, rt.call_method(var_product_object, 'get_download_limit', [rt.new_string('edit')]))) { rt.new_string('') } else { rt.call_method(var_product_object, 'get_download_limit', [rt.new_string('edit')]) } }, rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('Download limit'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'placeholder', val: rt.call_function('__', [rt.new_string('Unlimited'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Leave blank for unlimited re-downloads.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'number' }, rt.ArrayItem{ key: 'custom_attributes', val: rt.create_array([rt.ArrayItem{ key: 'step', val: '1' }, rt.ArrayItem{ key: 'min', val: '0' }]) }])])
	rt.call_function('woocommerce_wp_text_input', [rt.create_array([rt.ArrayItem{ key: 'id', val: '_download_expiry' }, rt.ArrayItem{ key: 'value', val: if rt.is_true(rt.identical(-1, rt.call_method(var_product_object, 'get_download_expiry', [rt.new_string('edit')]))) { rt.new_string('') } else { rt.call_method(var_product_object, 'get_download_expiry', [rt.new_string('edit')]) } }, rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('Download expiry'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'placeholder', val: rt.call_function('__', [rt.new_string('Never'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Enter the number of days before a download link expires, or leave blank.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'number' }, rt.ArrayItem{ key: 'custom_attributes', val: rt.create_array([rt.ArrayItem{ key: 'step', val: '1' }, rt.ArrayItem{ key: 'min', val: '0' }]) }])])
	rt.call_function('do_action', [rt.new_string('woocommerce_product_options_downloads')])
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.call_function('wc_tax_enabled', []rt.PhpVal{})) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('woocommerce_wp_select', [rt.create_array([rt.ArrayItem{ key: 'id', val: '_tax_status' }, rt.ArrayItem{ key: 'value', val: rt.call_method(var_product_object, 'get_tax_status', [rt.new_string('edit')]) }, rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('Tax status'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'options', val: rt.create_array([rt.ArrayItem{ key: Class_Automattic_WooCommerce_Enums_ProductTaxStatus.taxable(), val: rt.call_function('__', [rt.new_string('Taxable'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: Class_Automattic_WooCommerce_Enums_ProductTaxStatus.shipping(), val: rt.call_function('__', [rt.new_string('Shipping only'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: Class_Automattic_WooCommerce_Enums_ProductTaxStatus.none(), val: rt.call_function('_x', [rt.new_string('None'), rt.new_string('Tax status'), rt.new_string('woocommerce')]) }]) }, rt.ArrayItem{ key: 'desc_tip', val: 'true' }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Define whether or not the entire product is taxable, or just the cost of shipping it.'), rt.new_string('woocommerce')]) }])])
		rt.call_function('woocommerce_wp_select', [rt.create_array([rt.ArrayItem{ key: 'id', val: '_tax_class' }, rt.ArrayItem{ key: 'value', val: rt.call_method(var_product_object, 'get_tax_class', [rt.new_string('edit')]) }, rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('Tax class'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'options', val: rt.call_function('wc_get_product_tax_class_options', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'desc_tip', val: 'true' }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Choose a tax class for this product. Tax classes are used to apply different tax rates specific to certain types of product.'), rt.new_string('woocommerce')]) }])])
		rt.call_function('do_action', [rt.new_string('woocommerce_product_options_tax')])
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string('woocommerce_product_options_general_product_data')])
	// unsupported statement: Stmt_InlineHTML
}
