import rt

struct Class_WC_Report_Sales_By_Product {
	rt.PhpObjectBase
pub mut:
	chart_colours      rt.PhpVal = rt.new_array()
	product_ids        rt.PhpVal = rt.new_array()
	product_ids_titles rt.PhpVal = rt.new_array()
}

fn (mut this Class_WC_Report_Sales_By_Product) construct() {
	if rt.get_superglobal('_GET').array_isset(rt.new_string('product_ids'))
		&& rt.get_superglobal('_GET').array_get(rt.new_string('product_ids')).is_array() {
		this.product_ids = rt.call_function('array_filter', [
			rt.call_function('array_map', [rt.new_string('absint'),
				rt.get_superglobal('_GET').array_get(rt.new_string('product_ids'))]),
		])
	} else if rt.get_superglobal('_GET').array_isset(rt.new_string('product_ids')) {
		this.product_ids = rt.call_function('array_filter', [
			rt.create_array([
				rt.ArrayItem{ key: none, val: rt.call_function('absint', [
					rt.get_superglobal('_GET').array_get(rt.new_string('product_ids')),
				]) },
			]),
		])
	}
}

fn (mut this Class_WC_Report_Sales_By_Product) get_chart_legend() rt.PhpVal {
	if !rt.is_true(this.product_ids) {
		return rt.new_array()
	}
	mut var_legend := rt.new_array()
	mut var_total_sales := this.get_order_report_data(rt.create_array([
		rt.ArrayItem{ key: 'data', val: rt.create_array([
			rt.ArrayItem{ key: '_line_total', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'order_item_meta' },
				rt.ArrayItem{ key: 'order_item_type', val: 'line_item' },
				rt.ArrayItem{ key: 'function', val: 'SUM' },
				rt.ArrayItem{ key: 'name', val: 'order_item_amount' },
			]) },
		]) },
		rt.ArrayItem{ key: 'where_meta', val: rt.create_array([
			rt.ArrayItem{ key: 'relation', val: 'OR' },
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'order_item_meta' },
				rt.ArrayItem{ key: 'meta_key', val: rt.create_array([
					rt.ArrayItem{ key: none, val: '_product_id' },
					rt.ArrayItem{ key: none, val: '_variation_id' },
				]) },
				rt.ArrayItem{ key: 'meta_value', val: this.product_ids },
				rt.ArrayItem{ key: 'operator', val: 'IN' },
			]) },
		]) },
		rt.ArrayItem{ key: 'query_type', val: 'get_var' },
		rt.ArrayItem{ key: 'filter_range', val: true },
		rt.ArrayItem{ key: 'order_status', val: rt.create_array([
			rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_OrderStatus.completed() },
			rt.ArrayItem{
				key: none
				val: Class_Automattic_WooCommerce_Enums_OrderStatus.processing()
			},
			rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_OrderStatus.on_hold() },
			rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_OrderStatus.refunded() },
		]) },
	]))
	mut var_total_items := rt.call_function('absint', [
		this.get_order_report_data(rt.create_array([
			rt.ArrayItem{ key: 'data', val: rt.create_array([
				rt.ArrayItem{ key: '_qty', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'order_item_meta' },
					rt.ArrayItem{ key: 'order_item_type', val: 'line_item' },
					rt.ArrayItem{ key: 'function', val: 'SUM' },
					rt.ArrayItem{ key: 'name', val: 'order_item_count' },
				]) },
			]) },
			rt.ArrayItem{ key: 'where_meta', val: rt.create_array([
				rt.ArrayItem{ key: 'relation', val: 'OR' },
				rt.ArrayItem{ key: none, val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'order_item_meta' },
					rt.ArrayItem{ key: 'meta_key', val: rt.create_array([
						rt.ArrayItem{ key: none, val: '_product_id' },
						rt.ArrayItem{ key: none, val: '_variation_id' },
					]) },
					rt.ArrayItem{ key: 'meta_value', val: this.product_ids },
					rt.ArrayItem{ key: 'operator', val: 'IN' },
				]) },
			]) },
			rt.ArrayItem{ key: 'query_type', val: 'get_var' },
			rt.ArrayItem{ key: 'filter_range', val: true },
			rt.ArrayItem{ key: 'order_status', val: rt.create_array([
				rt.ArrayItem{
					key: none
					val: Class_Automattic_WooCommerce_Enums_OrderStatus.completed()
				},
				rt.ArrayItem{
					key: none
					val: Class_Automattic_WooCommerce_Enums_OrderStatus.processing()
				},
				rt.ArrayItem{
					key: none
					val: Class_Automattic_WooCommerce_Enums_OrderStatus.on_hold()
				},
				rt.ArrayItem{
					key: none
					val: Class_Automattic_WooCommerce_Enums_OrderStatus.refunded()
				},
			]) },
		])),
	])
	var_legend << rt.create_array([
		rt.ArrayItem{ key: 'title', val: rt.call_function('sprintf', [
			rt.call_function('__', [rt.new_string('%s sales for the selected items'),
				rt.new_string('woocommerce')]),
			rt.new_string('<strong>' +
				(rt.call_function('wc_price', [var_total_sales.clone()])).str() + '</strong>'),
		]) },
		rt.ArrayItem{ key: 'color', val: this.chart_colours.array_get(rt.new_string('sales_amount')) },
		rt.ArrayItem{ key: 'highlight_series', val: 1 },
	])
	var_legend << rt.create_array([
		rt.ArrayItem{ key: 'title', val: rt.call_function('sprintf', [
			rt.call_function('__', [rt.new_string('%s purchases for the selected items'),
				rt.new_string('woocommerce')]),
			rt.new_string('<strong>' + var_total_items.str() + '</strong>'),
		]) },
		rt.ArrayItem{ key: 'color', val: this.chart_colours.array_get(rt.new_string('item_count')) },
		rt.ArrayItem{ key: 'highlight_series', val: 0 },
	])
	return var_legend.clone()
}

fn (mut this Class_WC_Report_Sales_By_Product) output_report() {
	mut var_ranges := {
		'year':       rt.call_function('__', [rt.new_string('Year'),
			rt.new_string('woocommerce')])
		'last_month': rt.call_function('__', [rt.new_string('Last month'),
			rt.new_string('woocommerce')])
		'month':      rt.call_function('__', [rt.new_string('This month'),
			rt.new_string('woocommerce')])
		'7day':       rt.call_function('__', [rt.new_string('Last 7 days'),
			rt.new_string('woocommerce')])
	}
	this.chart_colours = rt.create_array([
		rt.ArrayItem{ key: 'sales_amount', val: '#3498db' },
		rt.ArrayItem{ key: 'item_count', val: '#d4d9dc' },
	])
	mut var_current_range := if !(!rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('range')))) { rt.call_function('sanitize_text_field', [
			rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get(rt.new_string('range'))]),
		]) } else { rt.new_string('7day') }
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
		var_current_range.clone(),
		rt.create_array([
			rt.ArrayItem{ key: none, val: 'custom' },
			rt.ArrayItem{ key: none, val: 'year' },
			rt.ArrayItem{ key: none, val: 'last_month' },
			rt.ArrayItem{ key: none, val: 'month' },
			rt.ArrayItem{ key: none, val: '7day' },
		]),
		rt.new_bool(true)])))))
	{
		var_current_range = rt.new_string('7day')
	}
	this.check_current_range_nonce(var_current_range.clone())
	this.calculate_current_range(var_current_range.clone())
	rt.include_file(
		(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'plugin_path', []rt.PhpVal{})).str() +
		'/includes/admin/views/html-report-by-date.php', '1')
}

fn (mut this Class_WC_Report_Sales_By_Product) get_chart_widgets() rt.PhpVal {
	mut var_widgets := rt.new_array()
	if !(!rt.is_true(this.product_ids)) {
		var_widgets << rt.create_array([
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Showing reports for:'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'callback', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('WC_Report_Sales_By_Product', [
					'WC_Admin_Report',
				], &this) },
				rt.ArrayItem{ key: none, val: 'current_filters' },
			]) },
		])
	}
	var_widgets << rt.create_array([rt.ArrayItem{ key: 'title', val: '' },
		rt.ArrayItem{ key: 'callback', val: rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Report_Sales_By_Product', [
				'WC_Admin_Report',
			], &this) },
			rt.ArrayItem{ key: none, val: 'products_widget' },
		]) }])
	return var_widgets.clone()
}

fn (mut this Class_WC_Report_Sales_By_Product) current_filters() {
	this.product_ids_titles = rt.new_array()
	if !(!rt.is_true(this.product_ids)) {
		rt.call_function('_prime_post_caches', [this.product_ids])
	}
	mut iter_1 := this.product_ids.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_product_id := item_1.val
		mut var_product := rt.call_function('wc_get_product', [
			var_product_id.clone()])
		if rt.is_true(var_product) {
			this.product_ids_titles.array_push(rt.call_method(var_product, 'get_formatted_name',
				[]rt.PhpVal{}))
		} else {
			this.product_ids_titles.array_push('#' + var_product_id.str())
		}
	}
	print('<p><strong>' +
		(rt.call_function('wp_kses_post', [rt.call_function('implode', [rt.new_string(', '), this.product_ids_titles])])).str() +
		'</strong></p>')
	print('<p><a class="button" href="' +
		(rt.call_function('esc_url', [rt.call_function('remove_query_arg', [rt.new_string('product_ids')])])).str() +
		'">' +
		(rt.call_function('esc_html__', [rt.new_string('Reset'), rt.new_string('woocommerce')])).str() +
		'</a></p>')
}

fn (mut this Class_WC_Report_Sales_By_Product) products_widget() {
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Product search'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('Search for a product&hellip;'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('Show'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Show'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(if !(!rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('range')))) { rt.call_function('esc_attr', [
			rt.get_superglobal('_GET').array_get(rt.new_string('range')),
		]) } else { rt.new_string('') })
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(if !(!rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('start_date')))) { rt.call_function('esc_attr', [
			rt.get_superglobal('_GET').array_get(rt.new_string('start_date')),
		]) } else { rt.new_string('') })
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(if !(!rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('end_date')))) { rt.call_function('esc_attr', [
			rt.get_superglobal('_GET').array_get(rt.new_string('end_date')),
		]) } else { rt.new_string('') })
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(if !(!rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('page')))) { rt.call_function('esc_attr', [
			rt.get_superglobal('_GET').array_get(rt.new_string('page')),
		]) } else { rt.new_string('') })
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(if !(!rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('tab')))) { rt.call_function('esc_attr', [
			rt.get_superglobal('_GET').array_get(rt.new_string('tab')),
		]) } else { rt.new_string('') })
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(if !(!rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('report')))) { rt.call_function('esc_attr', [
			rt.get_superglobal('_GET').array_get(rt.new_string('report')),
		]) } else { rt.new_string('') })
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('wp_nonce_field', [rt.new_string('custom_range'),
		rt.new_string('wc_reports_nonce'), rt.new_bool(false)])
	// unsupported statement: Stmt_InlineHTML
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Top sellers'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	mut var_top_sellers := this.get_order_report_data(rt.create_array([
		rt.ArrayItem{ key: 'data', val: rt.create_array([
			rt.ArrayItem{ key: '_product_id', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'order_item_meta' },
				rt.ArrayItem{ key: 'order_item_type', val: 'line_item' },
				rt.ArrayItem{ key: 'function', val: '' },
				rt.ArrayItem{ key: 'name', val: 'product_id' },
			]) },
			rt.ArrayItem{ key: '_qty', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'order_item_meta' },
				rt.ArrayItem{ key: 'order_item_type', val: 'line_item' },
				rt.ArrayItem{ key: 'function', val: 'SUM' },
				rt.ArrayItem{ key: 'name', val: 'order_item_qty' },
			]) },
		]) },
		rt.ArrayItem{ key: 'order_by', val: 'order_item_qty DESC' },
		rt.ArrayItem{ key: 'group_by', val: 'product_id' },
		rt.ArrayItem{ key: 'limit', val: 12 },
		rt.ArrayItem{ key: 'query_type', val: 'get_results' },
		rt.ArrayItem{ key: 'filter_range', val: true },
		rt.ArrayItem{ key: 'order_status', val: rt.create_array([
			rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_OrderStatus.completed() },
			rt.ArrayItem{
				key: none
				val: Class_Automattic_WooCommerce_Enums_OrderStatus.processing()
			},
			rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_OrderStatus.on_hold() },
			rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_OrderStatus.refunded() },
		]) },
	]))
	if rt.is_true(var_top_sellers) {
		mut iter_2 := var_top_sellers.iterator()
		for {
			item_2 := iter_2.next() or { break }
			mut var_product := item_2.val
			print('<tr class="' +
				if rt.is_true(rt.call_function('in_array', [rt.get_property(var_product, 'product_id'), this.product_ids])) { 'active' } else { '' } +
				'">\n\t\t\t\t\t\t\t<td class="count">' +
				(rt.call_function('esc_html', [rt.get_property(var_product, 'order_item_qty')])).str() +
				'</td>\n\t\t\t\t\t\t\t<td class="name"><a href="' +
				(rt.call_function('esc_url', [rt.call_function('add_query_arg', [rt.new_string('product_ids'), rt.get_property(var_product, 'product_id')])])).str() +
				'">' +
				(rt.call_function('esc_html', [rt.call_function('get_the_title', [rt.get_property(var_product, 'product_id')])])).str() +
				'</a></td>\n\t\t\t\t\t\t\t<td class="sparkline">' +
				(this.sales_sparkline(rt.get_property(var_product, 'product_id'), rt.new_int(7), rt.new_string('count'))).str() +
				'</td>\n\t\t\t\t\t\t</tr>')
		}
	} else {
		print('<tr><td colspan="3">' +
			(rt.call_function('esc_html__', [rt.new_string('No products found in range'), rt.new_string('woocommerce')])).str() +
			'</td></tr>')
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Top freebies'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	mut var_top_freebies := this.get_order_report_data(rt.create_array([
		rt.ArrayItem{ key: 'data', val: rt.create_array([
			rt.ArrayItem{ key: '_product_id', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'order_item_meta' },
				rt.ArrayItem{ key: 'order_item_type', val: 'line_item' },
				rt.ArrayItem{ key: 'function', val: '' },
				rt.ArrayItem{ key: 'name', val: 'product_id' },
			]) },
			rt.ArrayItem{ key: '_qty', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'order_item_meta' },
				rt.ArrayItem{ key: 'order_item_type', val: 'line_item' },
				rt.ArrayItem{ key: 'function', val: 'SUM' },
				rt.ArrayItem{ key: 'name', val: 'order_item_qty' },
			]) },
		]) },
		rt.ArrayItem{ key: 'where_meta', val: rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'order_item_meta' },
				rt.ArrayItem{ key: 'meta_key', val: '_line_subtotal' },
				rt.ArrayItem{ key: 'meta_value', val: '0' },
				rt.ArrayItem{ key: 'operator', val: '=' },
			]) },
		]) },
		rt.ArrayItem{ key: 'order_by', val: 'order_item_qty DESC' },
		rt.ArrayItem{ key: 'group_by', val: 'product_id' },
		rt.ArrayItem{ key: 'limit', val: 12 },
		rt.ArrayItem{ key: 'query_type', val: 'get_results' },
		rt.ArrayItem{ key: 'filter_range', val: true },
	]))
	if rt.is_true(var_top_freebies) {
		mut iter_3 := var_top_freebies.iterator()
		for {
			item_3 := iter_3.next() or { break }
			mut var_product := item_3.val
			print('<tr class="' +
				if rt.is_true(rt.call_function('in_array', [rt.get_property(var_product, 'product_id'), this.product_ids])) { 'active' } else { '' } +
				'">\n\t\t\t\t\t\t\t<td class="count">' +
				(rt.call_function('esc_html', [rt.get_property(var_product, 'order_item_qty')])).str() +
				'</td>\n\t\t\t\t\t\t\t<td class="name"><a href="' +
				(rt.call_function('esc_url', [rt.call_function('add_query_arg', [rt.new_string('product_ids'), rt.get_property(var_product, 'product_id')])])).str() +
				'">' +
				(rt.call_function('esc_html', [rt.call_function('get_the_title', [rt.get_property(var_product, 'product_id')])])).str() +
				'</a></td>\n\t\t\t\t\t\t\t<td class="sparkline">' +
				(this.sales_sparkline(rt.get_property(var_product, 'product_id'), rt.new_int(7), rt.new_string('count'))).str() +
				'</td>\n\t\t\t\t\t\t</tr>')
		}
	} else {
		print('<tr><td colspan="3">' +
			(rt.call_function('esc_html__', [rt.new_string('No products found in range'), rt.new_string('woocommerce')])).str() +
			'</td></tr>')
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Top earners'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	mut var_top_earners := this.get_order_report_data(rt.create_array([
		rt.ArrayItem{ key: 'data', val: rt.create_array([
			rt.ArrayItem{ key: '_product_id', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'order_item_meta' },
				rt.ArrayItem{ key: 'order_item_type', val: 'line_item' },
				rt.ArrayItem{ key: 'function', val: '' },
				rt.ArrayItem{ key: 'name', val: 'product_id' },
			]) },
			rt.ArrayItem{ key: '_line_total', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'order_item_meta' },
				rt.ArrayItem{ key: 'order_item_type', val: 'line_item' },
				rt.ArrayItem{ key: 'function', val: 'SUM' },
				rt.ArrayItem{ key: 'name', val: 'order_item_total' },
			]) },
		]) },
		rt.ArrayItem{ key: 'order_by', val: 'order_item_total DESC' },
		rt.ArrayItem{ key: 'group_by', val: 'product_id' },
		rt.ArrayItem{ key: 'limit', val: 12 },
		rt.ArrayItem{ key: 'query_type', val: 'get_results' },
		rt.ArrayItem{ key: 'filter_range', val: true },
		rt.ArrayItem{ key: 'order_status', val: rt.create_array([
			rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_OrderStatus.completed() },
			rt.ArrayItem{
				key: none
				val: Class_Automattic_WooCommerce_Enums_OrderStatus.processing()
			},
			rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_OrderStatus.on_hold() },
			rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_OrderStatus.refunded() },
		]) },
	]))
	if rt.is_true(var_top_earners) {
		mut iter_4 := var_top_earners.iterator()
		for {
			item_4 := iter_4.next() or { break }
			mut var_product := item_4.val
			print('<tr class="' +
				if rt.is_true(rt.call_function('in_array', [rt.get_property(var_product, 'product_id'), this.product_ids])) { 'active' } else { '' } +
				'">\n\t\t\t\t\t\t\t<td class="count">' +
				(rt.call_function('wc_price', [rt.get_property(var_product, 'order_item_total')])).str() +
				'</td>\n\t\t\t\t\t\t\t<td class="name"><a href="' +
				(rt.call_function('esc_url', [rt.call_function('add_query_arg', [rt.new_string('product_ids'), rt.get_property(var_product, 'product_id')])])).str() +
				'">' +
				(rt.call_function('esc_html', [rt.call_function('get_the_title', [rt.get_property(var_product, 'product_id')])])).str() +
				'</a></td>\n\t\t\t\t\t\t\t<td class="sparkline">' +
				(this.sales_sparkline(rt.get_property(var_product, 'product_id'), rt.new_int(7), rt.new_string('sales'))).str() +
				'</td>\n\t\t\t\t\t\t</tr>')
		}
	} else {
		print('<tr><td colspan="3">' +
			(rt.call_function('esc_html__', [rt.new_string('No products found in range'), rt.new_string('woocommerce')])).str() +
			'</td></tr>')
	}
	// unsupported statement: Stmt_InlineHTML
	if !rt.is_true(this.product_ids) {
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
}

fn (mut this Class_WC_Report_Sales_By_Product) get_export_button() {
	mut var_current_range := if !(!rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('range')))) { rt.call_function('sanitize_text_field', [
			rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get(rt.new_string('range'))]),
		]) } else { rt.new_string('7day') }
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_current_range.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [
		rt.call_function('date_i18n', [rt.new_string('Y-m-d'),
			rt.call_function('current_time', [rt.new_string('timestamp')])]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('Date'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.get_property(rt.new_object('WC_Report_Sales_By_Product', [
		'WC_Admin_Report',
	], &this), 'chart_groupby'))
	// unsupported statement: Stmt_InlineHTML
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Export CSV'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
}

fn (mut this Class_WC_Report_Sales_By_Product) get_main_chart() {
	mut var_wp_locale := rt.new_null()
	if !rt.is_true(this.product_ids) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Choose a product to view stats'),
			rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
	} else {
		mut var_order_item_counts := this.get_order_report_data(rt.create_array([
			rt.ArrayItem{ key: 'data', val: rt.create_array([
				rt.ArrayItem{ key: '_qty', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'order_item_meta' },
					rt.ArrayItem{ key: 'order_item_type', val: 'line_item' },
					rt.ArrayItem{ key: 'function', val: 'SUM' },
					rt.ArrayItem{ key: 'name', val: 'order_item_count' },
				]) },
				rt.ArrayItem{ key: 'post_date', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'post_data' },
					rt.ArrayItem{ key: 'function', val: '' },
					rt.ArrayItem{ key: 'name', val: 'post_date' },
				]) },
				rt.ArrayItem{ key: '_product_id', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'order_item_meta' },
					rt.ArrayItem{ key: 'order_item_type', val: 'line_item' },
					rt.ArrayItem{ key: 'function', val: '' },
					rt.ArrayItem{ key: 'name', val: 'product_id' },
				]) },
			]) },
			rt.ArrayItem{ key: 'where_meta', val: rt.create_array([
				rt.ArrayItem{ key: 'relation', val: 'OR' },
				rt.ArrayItem{ key: none, val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'order_item_meta' },
					rt.ArrayItem{ key: 'meta_key', val: rt.create_array([
						rt.ArrayItem{ key: none, val: '_product_id' },
						rt.ArrayItem{ key: none, val: '_variation_id' },
					]) },
					rt.ArrayItem{ key: 'meta_value', val: this.product_ids },
					rt.ArrayItem{ key: 'operator', val: 'IN' },
				]) },
			]) },
			rt.ArrayItem{
				key: 'group_by'
				val: 'product_id,' +(rt.get_property(rt.new_object('WC_Report_Sales_By_Product', ['WC_Admin_Report'], &this), 'group_by_query')).str()
			},
			rt.ArrayItem{ key: 'order_by', val: 'post_date ASC' },
			rt.ArrayItem{ key: 'query_type', val: 'get_results' },
			rt.ArrayItem{ key: 'filter_range', val: true },
			rt.ArrayItem{ key: 'order_status', val: rt.create_array([
				rt.ArrayItem{
					key: none
					val: Class_Automattic_WooCommerce_Enums_OrderStatus.completed()
				},
				rt.ArrayItem{
					key: none
					val: Class_Automattic_WooCommerce_Enums_OrderStatus.processing()
				},
				rt.ArrayItem{
					key: none
					val: Class_Automattic_WooCommerce_Enums_OrderStatus.on_hold()
				},
				rt.ArrayItem{
					key: none
					val: Class_Automattic_WooCommerce_Enums_OrderStatus.refunded()
				},
			]) },
		]))
		mut var_order_item_amounts := this.get_order_report_data(rt.create_array([
			rt.ArrayItem{ key: 'data', val: rt.create_array([
				rt.ArrayItem{ key: '_line_total', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'order_item_meta' },
					rt.ArrayItem{ key: 'order_item_type', val: 'line_item' },
					rt.ArrayItem{ key: 'function', val: 'SUM' },
					rt.ArrayItem{ key: 'name', val: 'order_item_amount' },
				]) },
				rt.ArrayItem{ key: 'post_date', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'post_data' },
					rt.ArrayItem{ key: 'function', val: '' },
					rt.ArrayItem{ key: 'name', val: 'post_date' },
				]) },
				rt.ArrayItem{ key: '_product_id', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'order_item_meta' },
					rt.ArrayItem{ key: 'order_item_type', val: 'line_item' },
					rt.ArrayItem{ key: 'function', val: '' },
					rt.ArrayItem{ key: 'name', val: 'product_id' },
				]) },
			]) },
			rt.ArrayItem{ key: 'where_meta', val: rt.create_array([
				rt.ArrayItem{ key: 'relation', val: 'OR' },
				rt.ArrayItem{ key: none, val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'order_item_meta' },
					rt.ArrayItem{ key: 'meta_key', val: rt.create_array([
						rt.ArrayItem{ key: none, val: '_product_id' },
						rt.ArrayItem{ key: none, val: '_variation_id' },
					]) },
					rt.ArrayItem{ key: 'meta_value', val: this.product_ids },
					rt.ArrayItem{ key: 'operator', val: 'IN' },
				]) },
			]) },
			rt.ArrayItem{
				key: 'group_by'
				val: 'product_id, ' +(rt.get_property(rt.new_object('WC_Report_Sales_By_Product', ['WC_Admin_Report'], &this), 'group_by_query')).str()
			},
			rt.ArrayItem{ key: 'order_by', val: 'post_date ASC' },
			rt.ArrayItem{ key: 'query_type', val: 'get_results' },
			rt.ArrayItem{ key: 'filter_range', val: true },
			rt.ArrayItem{ key: 'order_status', val: rt.create_array([
				rt.ArrayItem{
					key: none
					val: Class_Automattic_WooCommerce_Enums_OrderStatus.completed()
				},
				rt.ArrayItem{
					key: none
					val: Class_Automattic_WooCommerce_Enums_OrderStatus.processing()
				},
				rt.ArrayItem{
					key: none
					val: Class_Automattic_WooCommerce_Enums_OrderStatus.on_hold()
				},
				rt.ArrayItem{
					key: none
					val: Class_Automattic_WooCommerce_Enums_OrderStatus.refunded()
				},
			]) },
		]))
		var_order_item_counts = this.prepare_chart_data(var_order_item_counts.clone(),
			rt.new_string('post_date'), rt.new_string('order_item_count'), rt.get_property(rt.new_object('WC_Report_Sales_By_Product', [
			'WC_Admin_Report',
		], &this), 'chart_interval'), rt.get_property(rt.new_object('WC_Report_Sales_By_Product', [
			'WC_Admin_Report',
		], &this), 'start_date'), rt.get_property(rt.new_object('WC_Report_Sales_By_Product', [
			'WC_Admin_Report',
		], &this), 'chart_groupby'))
		var_order_item_amounts = this.prepare_chart_data(var_order_item_amounts.clone(),
			rt.new_string('post_date'), rt.new_string('order_item_amount'), rt.get_property(rt.new_object('WC_Report_Sales_By_Product', [
			'WC_Admin_Report',
		], &this), 'chart_interval'), rt.get_property(rt.new_object('WC_Report_Sales_By_Product', [
			'WC_Admin_Report',
		], &this), 'start_date'), rt.get_property(rt.new_object('WC_Report_Sales_By_Product', [
			'WC_Admin_Report',
		], &this), 'chart_groupby'))
		mut var_chart_data := rt.call_function('wp_json_encode', [
			rt.create_array([
				rt.ArrayItem{ key: 'order_item_counts', val: rt.call_function('array_values', [
					var_order_item_counts.clone(),
				]) },
				rt.ArrayItem{ key: 'order_item_amounts', val: rt.call_function('array_values', [
					var_order_item_amounts.clone(),
				]) },
			]),
		])
		// unsupported statement: Stmt_InlineHTML
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('rawurlencode', [var_chart_data.clone()]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_js', [
			rt.call_function('__', [rt.new_string('Number of items sold'),
				rt.new_string('woocommerce')]),
		]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(this.chart_colours.array_get(rt.new_string('item_count')))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(this.chart_colours.array_get(rt.new_string('item_count')))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.get_property(rt.new_object('WC_Report_Sales_By_Product', [
			'WC_Admin_Report',
		], &this), 'barwidth'))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_js', [
			rt.call_function('__', [rt.new_string('Sales amount'),
				rt.new_string('woocommerce')]),
		]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(this.chart_colours.array_get(rt.new_string('sales_amount')))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(this.get_currency_tooltip())
		// unsupported statement: Stmt_InlineHTML
		print(if rt.is_true(rt.identical(rt.new_string('day'), rt.get_property(rt.new_object('WC_Report_Sales_By_Product', [
			'WC_Admin_Report',
		], &this), 'chart_groupby')))
		{ '%d %b' } else { '%b' })
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('rawurlencode', [
			rt.call_function('wp_json_encode', [
				rt.call_function('array_values', [
					rt.get_property(var_wp_locale, 'month_abbrev'),
				]),
			]),
		]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.get_property(rt.new_object('WC_Report_Sales_By_Product', [
			'WC_Admin_Report',
		], &this), 'chart_groupby'))
		// unsupported statement: Stmt_InlineHTML
	}
}

struct Class_WC_Admin_Report {
	rt.PhpObjectBase
}

fn create_wc_report_sales_by_product() &Class_WC_Report_Sales_By_Product {
	mut obj := &Class_WC_Report_Sales_By_Product{
		PhpObjectBase:      rt.PhpObjectBase{}
		chart_colours:      rt.new_array()
		product_ids:        rt.new_array()
		product_ids_titles: rt.new_array()
	}
	obj.construct()
	return obj
}

fn create_wc_admin_report(_args ...rt.PhpVal) &Class_WC_Admin_Report {
	mut obj := &Class_WC_Admin_Report{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Report_Sales_By_Product) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'get_chart_legend' {
			return this.get_chart_legend()
		}
		'output_report' {
			this.output_report()
			return rt.new_null()
		}
		'get_chart_widgets' {
			return this.get_chart_widgets()
		}
		'current_filters' {
			this.current_filters()
			return rt.new_null()
		}
		'products_widget' {
			this.products_widget()
			return rt.new_null()
		}
		'get_export_button' {
			this.get_export_button()
			return rt.new_null()
		}
		'get_main_chart' {
			this.get_main_chart()
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_Report_Sales_By_Product) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'chart_colours' { return this.chart_colours }
		'product_ids' { return this.product_ids }
		'product_ids_titles' { return this.product_ids_titles }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_Report_Sales_By_Product) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'chart_colours' {
			this.chart_colours = val
			return true
		}
		'product_ids' {
			this.product_ids = val
			return true
		}
		'product_ids_titles' {
			this.product_ids_titles = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_WC_Admin_Report) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Admin_Report) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Admin_Report) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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
}
