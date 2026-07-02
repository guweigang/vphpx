import rt

struct Class_WC_Report_Taxes_By_Code {
	rt.PhpObjectBase
}

fn (mut this Class_WC_Report_Taxes_By_Code) get_chart_legend() rt.PhpVal {
	return rt.new_array()
}

fn (mut this Class_WC_Report_Taxes_By_Code) get_export_button() {
	mut var_current_range := if !(!rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('range')))) { rt.call_function('sanitize_text_field', [
			rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get(rt.new_string('range'))]),
		]) } else { rt.new_string('last_month') }
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_current_range.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [
		rt.call_function('date_i18n', [rt.new_string('Y-m-d'),
			rt.call_function('current_time', [rt.new_string('timestamp')])]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Export CSV'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
}

fn (mut this Class_WC_Report_Taxes_By_Code) output_report() {
	mut var_ranges := {
		'year':       rt.call_function('__', [rt.new_string('Year'),
			rt.new_string('woocommerce')])
		'last_month': rt.call_function('__', [rt.new_string('Last month'),
			rt.new_string('woocommerce')])
		'month':      rt.call_function('__', [rt.new_string('This month'),
			rt.new_string('woocommerce')])
	}
	mut var_current_range := if !(!rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('range')))) { rt.call_function('sanitize_text_field', [
			rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get(rt.new_string('range'))]),
		]) } else { rt.new_string('last_month') }
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
		var_current_range.clone(),
		rt.create_array([
			rt.ArrayItem{ key: none, val: 'custom' },
			rt.ArrayItem{ key: none, val: 'year' },
			rt.ArrayItem{ key: none, val: 'last_month' },
			rt.ArrayItem{ key: none, val: 'month' },
			rt.ArrayItem{ key: none, val: '7day' },
		])])))))
	{
		var_current_range = rt.new_string('last_month')
	}
	this.check_current_range_nonce(var_current_range.clone())
	this.calculate_current_range(var_current_range.clone())
	mut var_hide_sidebar := rt.new_bool(true)
	rt.include_file(
		(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'plugin_path', []rt.PhpVal{})).str() +
		'/includes/admin/views/html-report-by-date.php', '1')
}

fn (mut this Class_WC_Report_Taxes_By_Code) get_main_chart() {
	mut var_wpdb := rt.new_null()
	mut var_query_data := {
		'order_item_name':     {
			'type':     rt.new_string('order_item')
			'function': rt.new_string('')
			'name':     rt.new_string('tax_rate')
		}
		'tax_amount':          {
			'type':            rt.new_string('order_item_meta')
			'order_item_type': rt.new_string('tax')
			'function':        rt.new_string('')
			'name':            rt.new_string('tax_amount')
		}
		'shipping_tax_amount': {
			'type':            rt.new_string('order_item_meta')
			'order_item_type': rt.new_string('tax')
			'function':        rt.new_string('')
			'name':            rt.new_string('shipping_tax_amount')
		}
		'rate_id':             {
			'type':            rt.new_string('order_item_meta')
			'order_item_type': rt.new_string('tax')
			'function':        rt.new_string('')
			'name':            rt.new_string('rate_id')
		}
		'ID':                  {
			'type':     rt.new_string('post_data')
			'function': rt.new_string('')
			'name':     rt.new_string('post_id')
		}
	}
	mut var_query_where := [
		[rt.new_string('order_item_type'), rt.new_string('tax'),
			rt.new_string('=')],
		[rt.new_string('order_item_name'), rt.new_string(''),
			rt.new_string('!=')],
	]
	mut var_tax_rows_orders := this.get_order_report_data(rt.create_array([
		rt.ArrayItem{ key: 'data', val: var_query_data },
		rt.ArrayItem{ key: 'where', val: var_query_where },
		rt.ArrayItem{ key: 'order_by', val: 'posts.post_date ASC' },
		rt.ArrayItem{ key: 'query_type', val: 'get_results' },
		rt.ArrayItem{ key: 'filter_range', val: true },
		rt.ArrayItem{ key: 'order_types', val: rt.call_function('wc_get_order_types', [
			rt.new_string('sales-reports'),
		]) },
		rt.ArrayItem{ key: 'order_status', val: rt.create_array([
			rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_OrderStatus.completed() },
			rt.ArrayItem{
				key: none
				val: Class_Automattic_WooCommerce_Enums_OrderStatus.processing()
			},
			rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_OrderStatus.refunded() },
		]) },
	]))
	mut var_tax_rows_partial_refunds := this.get_order_report_data(rt.create_array([
		rt.ArrayItem{ key: 'data', val: var_query_data },
		rt.ArrayItem{ key: 'where', val: var_query_where },
		rt.ArrayItem{ key: 'order_by', val: 'posts.post_date ASC' },
		rt.ArrayItem{ key: 'query_type', val: 'get_results' },
		rt.ArrayItem{ key: 'filter_range', val: true },
		rt.ArrayItem{ key: 'order_types', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'shop_order_refund' },
		]) },
		rt.ArrayItem{ key: 'parent_order_status', val: rt.create_array([
			rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_OrderStatus.completed() },
			rt.ArrayItem{
				key: none
				val: Class_Automattic_WooCommerce_Enums_OrderStatus.processing()
			},
		]) },
	]))
	mut var_tax_rows_full_refunds := this.get_order_report_data(rt.create_array([
		rt.ArrayItem{ key: 'data', val: var_query_data },
		rt.ArrayItem{ key: 'where', val: var_query_where },
		rt.ArrayItem{ key: 'order_by', val: 'posts.post_date ASC' },
		rt.ArrayItem{ key: 'query_type', val: 'get_results' },
		rt.ArrayItem{ key: 'filter_range', val: true },
		rt.ArrayItem{ key: 'order_types', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'shop_order_refund' },
		]) },
		rt.ArrayItem{ key: 'parent_order_status', val: rt.create_array([
			rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_OrderStatus.refunded() },
		]) },
	]))
	mut var_tax_rows := rt.new_array()
	mut var_unique_post_ids := rt.new_array()
	mut iter_1 := rt.add(var_tax_rows_orders, var_tax_rows_partial_refunds).iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_tax_row := item_1.val
		mut var_key := rt.get_property(var_tax_row, 'tax_rate')
		var_tax_rows.array_set(var_key, if var_tax_rows.array_isset(var_key) { var_tax_rows.array_get(var_key) } else { rt.array_to_object(rt.create_array([
				rt.ArrayItem{ key: 'tax_amount', val: 0 },
				rt.ArrayItem{ key: 'shipping_tax_amount', val: 0 },
				rt.ArrayItem{ key: 'total_orders', val: 0 },
			])) })
		rt.set_property(var_tax_rows.array_get(var_key), 'tax_rate', rt.get_property(var_tax_row,
			'tax_rate'))
		rt.get_property(var_tax_rows.array_get(var_key), 'tax_amount') = rt.add(rt.get_property(var_tax_rows.array_get(var_key),
			'tax_amount'), rt.call_function('wc_round_tax_total', [
			rt.get_property(var_tax_row, 'tax_amount'),
		]))
		rt.get_property(var_tax_rows.array_get(var_key), 'shipping_tax_amount') = rt.add(rt.get_property(var_tax_rows.array_get(var_key),
			'shipping_tax_amount'), rt.call_function('wc_round_tax_total', [
			rt.get_property(var_tax_row, 'shipping_tax_amount'),
		]))
		if !(var_unique_post_ids.array_isset(var_key))
			|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [rt.get_property(var_tax_row, 'post_id'), var_unique_post_ids.array_get(var_key), rt.new_bool(true)]))))) {
			var_unique_post_ids.array_set(var_key, if var_unique_post_ids.array_isset(var_key) {
				var_unique_post_ids.array_get(var_key)
			} else {
				rt.new_array()
			})
			var_unique_post_ids.array_get_mut(var_key).array_push(rt.get_property(var_tax_row,
				'post_id'))
			rt.get_property(var_tax_rows.array_get(var_key), 'total_orders') = rt.add(rt.get_property(var_tax_rows.array_get(var_key),
				'total_orders'), rt.new_int(1))
		}
	}
	mut iter_2 := var_tax_rows_full_refunds.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_tax_row := item_2.val
		mut var_key := rt.get_property(var_tax_row, 'tax_rate')
		var_tax_rows.array_set(var_key, if var_tax_rows.array_isset(var_key) { var_tax_rows.array_get(var_key) } else { rt.array_to_object(rt.create_array([
				rt.ArrayItem{ key: 'tax_amount', val: 0 },
				rt.ArrayItem{ key: 'shipping_tax_amount', val: 0 },
				rt.ArrayItem{ key: 'total_orders', val: 0 },
			])) })
		rt.set_property(var_tax_rows.array_get(var_key), 'tax_rate', rt.get_property(var_tax_row,
			'tax_rate'))
		rt.get_property(var_tax_rows.array_get(var_key), 'tax_amount') = rt.add(rt.get_property(var_tax_rows.array_get(var_key),
			'tax_amount'), rt.call_function('wc_round_tax_total', [
			rt.get_property(var_tax_row, 'tax_amount'),
		]))
		rt.get_property(var_tax_rows.array_get(var_key), 'shipping_tax_amount') = rt.add(rt.get_property(var_tax_rows.array_get(var_key),
			'shipping_tax_amount'), rt.call_function('wc_round_tax_total', [
			rt.get_property(var_tax_row, 'shipping_tax_amount'),
		]))
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Tax'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Rate'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Number of orders'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Tax amount'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wc_help_tip', [
		rt.call_function('__', [
			rt.new_string('This is the sum of the "Tax rows" tax amount within your orders.'),
			rt.new_string('woocommerce'),
		]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Shipping tax amount'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wc_help_tip', [
		rt.call_function('__', [
			rt.new_string('This is the sum of the "Tax rows" shipping tax amount within your orders.'),
			rt.new_string('woocommerce'),
		]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Total tax'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wc_help_tip', [
		rt.call_function('__', [
			rt.new_string('This is the total tax for the rate (shipping tax + product tax).'),
			rt.new_string('woocommerce'),
		]),
	]))
	// unsupported statement: Stmt_InlineHTML
	if !(!rt.is_true(var_tax_rows)) {
		// unsupported statement: Stmt_InlineHTML
		mut iter_3 := var_tax_rows.iterator()
		for {
			item_3 := iter_3.next() or { break }
			mut var_tax_row := item_3.val
			mut var_rate_id := item_3.key
			mut var_rate := rt.call_method(var_wpdb, 'get_var', [
				rt.call_method(var_wpdb, 'prepare', [
					rt.concat(rt.concat(rt.new_string('SELECT tax_rate FROM '), rt.get_property(var_wpdb,
						'prefix')), rt.new_string('woocommerce_tax_rates WHERE tax_rate_id = %d;')),
					var_rate_id.clone(),
				]),
			])
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('wp_kses_post', [
				rt.call_function('apply_filters', [
					rt.new_string('woocommerce_reports_taxes_tax_rate'),
					rt.get_property(var_tax_row, 'tax_rate'),
					var_rate_id.clone(),
					var_tax_row.clone(),
				]),
			]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('wp_kses_post', [
				rt.call_function('apply_filters', [
					rt.new_string('woocommerce_reports_taxes_rate'),
					var_rate.clone(),
					var_rate_id.clone(),
					var_tax_row.clone(),
				]),
			]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_html', [
				rt.get_property(var_tax_row, 'total_orders'),
			]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('wc_price', [
				rt.get_property(var_tax_row, 'tax_amount'),
			]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('wc_price', [
				rt.get_property(var_tax_row, 'shipping_tax_amount'),
			]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('wc_price', [
				rt.add(rt.get_property(var_tax_row, 'tax_amount'), rt.get_property(var_tax_row,
					'shipping_tax_amount')),
			]))
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Total'),
			rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('wc_price', [
			rt.call_function('wc_round_tax_total', [
				rt.call_function('array_sum', [
					rt.call_function('wp_list_pluck', [rt.cast_array(var_tax_rows),
						rt.new_string('tax_amount')]),
				]),
			]),
		]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('wc_price', [
			rt.call_function('wc_round_tax_total', [
				rt.call_function('array_sum', [
					rt.call_function('wp_list_pluck', [rt.cast_array(var_tax_rows),
						rt.new_string('shipping_tax_amount')]),
				]),
			]),
		]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('wc_price', [
			rt.call_function('wc_round_tax_total', [
				rt.add(rt.call_function('array_sum', [
					rt.call_function('wp_list_pluck', [rt.cast_array(var_tax_rows),
						rt.new_string('tax_amount')]),
				]), rt.call_function('array_sum', [
					rt.call_function('wp_list_pluck', [rt.cast_array(var_tax_rows),
						rt.new_string('shipping_tax_amount')]),
				])),
			]),
		]))
		// unsupported statement: Stmt_InlineHTML
	} else {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('No taxes found in this period'),
			rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
}

struct Class_WC_Admin_Report {
	rt.PhpObjectBase
}

fn create_wc_report_taxes_by_code(_args ...rt.PhpVal) &Class_WC_Report_Taxes_By_Code {
	mut obj := &Class_WC_Report_Taxes_By_Code{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_admin_report(_args ...rt.PhpVal) &Class_WC_Admin_Report {
	mut obj := &Class_WC_Admin_Report{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Report_Taxes_By_Code) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_chart_legend' {
			return this.get_chart_legend()
		}
		'get_export_button' {
			this.get_export_button()
			return rt.new_null()
		}
		'output_report' {
			this.output_report()
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

fn (this &Class_WC_Report_Taxes_By_Code) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Report_Taxes_By_Code) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
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
