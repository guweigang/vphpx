import rt

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_product_object := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		exit(0)
	}
	// unsupported statement: Stmt_InlineHTML
	mut var_info_img_url := rt.new_string(
		(rt.get_constant('WC_ADMIN_IMAGES_FOLDER_URL')).str() + '/icons/info.svg')
	if rt.is_true(rt.call_function('wc_product_sku_enabled', []rt.PhpVal{})) {
		rt.call_function('woocommerce_wp_text_input', [
			rt.create_array([rt.ArrayItem{ key: 'id', val: '_sku' },
				rt.ArrayItem{ key: 'value', val: rt.call_method(var_product_object, 'get_sku', [
					rt.new_string('edit'),
				]) }, rt.ArrayItem{ key: 'label', val: '<abbr title="' +
					(rt.call_function('esc_attr__', [rt.new_string('Stock Keeping Unit'), rt.new_string('woocommerce')])).str() +
					'">' +
					(rt.call_function('esc_html__', [rt.new_string('SKU'), rt.new_string('woocommerce')])).str() +
					'</abbr>' }, rt.ArrayItem{ key: 'desc_tip', val: true },
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('SKU refers to a Stock-keeping unit, a unique identifier for each distinct product and service that can be purchased.'),
					rt.new_string('woocommerce'),
				]) }]),
		])
	}
	rt.call_function('do_action', [rt.new_string('woocommerce_product_options_sku')])
	rt.call_function('woocommerce_wp_text_input', [
		rt.create_array([rt.ArrayItem{ key: 'id', val: '_global_unique_id' },
			rt.ArrayItem{ key: 'value', val: rt.call_method(var_product_object,
				'get_global_unique_id', [rt.new_string('edit')]) },
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
			}, rt.ArrayItem{ key: 'desc_tip', val: true }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Enter a barcode or any other identifier unique to this product. It can help you list this product on other channels or marketplaces.'),
				rt.new_string('woocommerce'),
			]) }]),
	])
	rt.call_function('do_action', [
		rt.new_string('woocommerce_product_options_global_unique_id'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [var_info_img_url.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [
		rt.new_string('Settings below apply to all variations without manual stock management enabled. '),
		rt.new_string('woocommerce'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Learn more'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.identical(rt.new_string('yes'), rt.call_function('get_option', [
		rt.new_string('woocommerce_manage_stock'),
	])))
	{
		rt.call_function('woocommerce_wp_checkbox', [
			rt.create_array([rt.ArrayItem{ key: 'id', val: '_manage_stock' },
				rt.ArrayItem{
					key: 'value'
					val: if rt.is_true(rt.call_method(var_product_object, 'get_manage_stock', [
						rt.new_string('edit'),
					]))
					{ 'yes' } else { 'no' }
				}, rt.ArrayItem{ key: 'wrapper_class', val: 'show_if_simple show_if_variable' },
				rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
					rt.new_string('Stock management'),
					rt.new_string('woocommerce'),
				]) }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Track stock quantity for this product'),
					rt.new_string('woocommerce'),
				]) }]),
		])
		rt.call_function('do_action', [
			rt.new_string('woocommerce_product_options_stock'),
		])
		print('<div class="stock_fields show_if_simple show_if_variable">')
		mut var_default_stock_amount := rt.call_function('apply_filters', [
			rt.new_string('woocommerce_product_stock_default_amount'),
			rt.new_int(1),
		])
		rt.call_function('woocommerce_wp_text_input', [
			rt.create_array([rt.ArrayItem{ key: 'id', val: '_stock' },
				rt.ArrayItem{ key: 'value', val: rt.call_function('wc_stock_amount', [
					if !(rt.call_method(var_product_object, 'get_stock_quantity', [
						rt.new_string('edit'),
					])).is_null() { rt.call_method(var_product_object, 'get_stock_quantity', [
							rt.new_string('edit'),
						]) } else { var_default_stock_amount },
				]) }, rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
					rt.new_string('Quantity'),
					rt.new_string('woocommerce'),
				]) }, rt.ArrayItem{ key: 'desc_tip', val: true },
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Stock quantity. If this is a variable product this value will be used to control stock for all variations, unless you define stock at variation level.'),
					rt.new_string('woocommerce'),
				]) }, rt.ArrayItem{ key: 'type', val: 'number' },
				rt.ArrayItem{ key: 'custom_attributes', val: rt.create_array([
					rt.ArrayItem{ key: 'step', val: 'any' },
				]) }, rt.ArrayItem{ key: 'data_type', val: 'stock' }]),
		])
		print('<input type="hidden" name="_original_stock" value="' +
			(rt.call_function('esc_attr', [rt.call_function('wc_stock_amount', [rt.call_method(var_product_object, 'get_stock_quantity', [rt.new_string('edit')])])])).str() +
			'" />')
		mut var_backorder_args := {
			'id':      rt.new_string('_backorders')
			'value':   rt.call_method(var_product_object, 'get_backorders', [
				rt.new_string('edit'),
			])
			'label':   rt.call_function('__', [rt.new_string('Allow backorders?'),
				rt.new_string('woocommerce')])
			'options': rt.call_function('wc_get_product_backorder_options', []rt.PhpVal{})
		}
		if rt.is_true(rt.call_function('apply_filters', [
			rt.new_string('woocommerce_product_allow_backorder_use_radio'),
			rt.new_bool(true),
		]))
		{
			rt.call_function('woocommerce_wp_radio', [
				rt.create_array_from_native_map(var_backorder_args),
			])
		} else {
			rt.call_function('woocommerce_wp_select', [
				rt.create_array_from_native_map(var_backorder_args),
			])
		}
		rt.call_function('woocommerce_wp_text_input', [
			rt.create_array([rt.ArrayItem{ key: 'id', val: '_low_stock_amount' },
				rt.ArrayItem{ key: 'value', val: rt.call_method(var_product_object,
					'get_low_stock_amount', [rt.new_string('edit')]) },
				rt.ArrayItem{
					key: 'placeholder'
					val: rt.call_function('sprintf', [
						rt.call_function('esc_attr__', [
							rt.new_string('Store-wide threshold (%d)'),
							rt.new_string('woocommerce'),
						]),
						rt.call_function('esc_attr', [
							rt.call_function('get_option', [
								rt.new_string('woocommerce_notify_low_stock_amount'),
							]),
						]),
					])
				}, rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
					rt.new_string('Low stock threshold'),
					rt.new_string('woocommerce'),
				]) }, rt.ArrayItem{ key: 'desc_tip', val: true },
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('When product stock reaches this amount you will be notified by email. It is possible to define different values for each variation individually. The shop default value can be set in Settings > Products > Inventory.'),
					rt.new_string('woocommerce'),
				]) }, rt.ArrayItem{ key: 'type', val: 'number' },
				rt.ArrayItem{ key: 'custom_attributes', val: rt.create_array([
					rt.ArrayItem{ key: 'step', val: 'any' },
				]) }]),
		])
		rt.call_function('do_action', [
			rt.new_string('woocommerce_product_options_stock_fields'),
		])
		print('</div>')
	} else {
		rt.call_function('woocommerce_wp_note', [
			rt.create_array([rt.ArrayItem{ key: 'id', val: '_manage_stock_disabled' },
				rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
					rt.new_string('Stock management'),
					rt.new_string('woocommerce'),
				]) }, rt.ArrayItem{ key: 'label-aria-label', val: rt.call_function('__', [
					rt.new_string('Stock management disabled in store settings'),
					rt.new_string('woocommerce'),
				]) }, rt.ArrayItem{ key: 'message', val: rt.call_function('sprintf', [
					rt.call_function('__', [
						rt.new_string('Disabled in <a href="%s" aria-label="stock management store settings">store settings</a>.'),
						rt.new_string('woocommerce'),
					]),
					rt.call_function('esc_url', [
						rt.new_string('admin.php?page=wc-settings&tab=products&section=inventory'),
					]),
				]) }, rt.ArrayItem{ key: 'wrapper_class', val: 'show_if_simple show_if_variable' }]),
		])
	}
	mut var_stock_status_options := rt.call_function('wc_get_product_stock_status_options',
		[]rt.PhpVal{})
	mut var_stock_status_count := var_stock_status_options.clone().array_count()
	mut var_stock_status_args := {
		'id':            rt.new_string('_stock_status')
		'value':         rt.call_method(var_product_object, 'get_stock_status', [
			rt.new_string('edit'),
		])
		'wrapper_class': rt.new_string('stock_status_field hide_if_variable hide_if_external hide_if_grouped')
		'label':         rt.call_function('__', [rt.new_string('Stock status'),
			rt.new_string('woocommerce')])
		'options':       var_stock_status_options
		'desc_tip':      rt.new_bool(true)
		'description':   rt.call_function('__', [
			rt.new_string('Controls whether or not the product is listed as "in stock" or "out of stock" on the frontend.'),
			rt.new_string('woocommerce'),
		])
	}
	if rt.is_true(rt.call_function('apply_filters', [
		rt.new_string('woocommerce_product_stock_status_use_radio'),
		rt.new_bool(var_stock_status_count <= 3 && var_stock_status_count >= 1),
	]))
	{
		rt.call_function('woocommerce_wp_radio', [
			rt.create_array_from_native_map(var_stock_status_args),
		])
	} else {
		rt.call_function('woocommerce_wp_select', [
			rt.create_array_from_native_map(var_stock_status_args),
		])
	}
	rt.call_function('do_action', [
		rt.new_string('woocommerce_product_options_stock_status'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('woocommerce_wp_checkbox', [
		rt.create_array([rt.ArrayItem{ key: 'id', val: '_sold_individually' },
			rt.ArrayItem{
				key: 'value'
				val: if rt.is_true(rt.call_method(var_product_object, 'get_sold_individually', [
					rt.new_string('edit'),
				]))
				{ 'yes' } else { 'no' }
			}, rt.ArrayItem{ key: 'wrapper_class', val: 'show_if_simple show_if_variable' },
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('Sold individually'),
				rt.new_string('woocommerce'),
			]) }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Limit purchases to 1 item per order'),
				rt.new_string('woocommerce'),
			]) }]),
	])
	rt.echo_val(rt.call_function('wc_help_tip', [
		rt.call_function('__', [
			rt.new_string('Check to let customers to purchase only 1 item in a single order. This is particularly useful for items that have limited quantity, for example art or handmade goods.'),
			rt.new_string('woocommerce'),
		]),
	]))
	rt.call_function('do_action', [
		rt.new_string('woocommerce_product_options_sold_individually'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [
		rt.new_string('woocommerce_product_options_inventory_product_data'),
	])
	// unsupported statement: Stmt_InlineHTML
}
