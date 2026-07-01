import rt

struct Class_WC_Report_Taxes_By_Date {
	rt.PhpObjectBase
}

fn (mut this Class_WC_Report_Taxes_By_Date) get_chart_legend() rt.PhpVal {
	return rt.new_array()
}

fn (mut this Class_WC_Report_Taxes_By_Date) get_export_button()  {
	mut var_current_range := if !(!rt.is_true(rt.get_superglobal('_GET').array_get('range'))) { rt.call_function('sanitize_text_field', [rt.get_superglobal('_GET').array_get('range')]) } else { rt.new_string('last_month') }
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_current_range.dup()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('date_i18n', [rt.new_string('Y-m-d'), rt.call_function('current_time', [rt.new_string('timestamp')])]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Export CSV'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
}

fn (mut this Class_WC_Report_Taxes_By_Date) output_report()  {
	mut var_ranges := { 'year': rt.call_function('__', [rt.new_string('Year'), rt.new_string('woocommerce')]), 'last_month': rt.call_function('__', [rt.new_string('Last month'), rt.new_string('woocommerce')]), 'month': rt.call_function('__', [rt.new_string('This month'), rt.new_string('woocommerce')]) }
	mut var_current_range := if !(!rt.is_true(rt.get_superglobal('_GET').array_get('range'))) { rt.call_function('sanitize_text_field', [rt.get_superglobal('_GET').array_get('range')]) } else { rt.new_string('last_month') }
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_current_range.dup(), rt.create_array([rt.ArrayItem{ key: none, val: 'custom' }, rt.ArrayItem{ key: none, val: 'year' }, rt.ArrayItem{ key: none, val: 'last_month' }, rt.ArrayItem{ key: none, val: 'month' }, rt.ArrayItem{ key: none, val: '7day' }])]))))) {
		var_current_range = rt.new_string(rt.new_string('last_month'))
	}
	this.check_current_range_nonce(var_current_range.dup())
	this.calculate_current_range(var_current_range.dup())
	mut var_hide_sidebar := rt.new_bool(rt.new_bool(true))
	rt.include_file((rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'plugin_path', []rt.PhpVal{})).str() + '/includes/admin/views/html-report-by-date.php', '1')
}

fn (mut this Class_WC_Report_Taxes_By_Date) get_main_chart()  {
	mut var_query_data := { '_order_tax': { 'type': rt.new_string('meta'), 'function': rt.new_string('SUM'), 'name': rt.new_string('tax_amount') }, '_order_shipping_tax': { 'type': rt.new_string('meta'), 'function': rt.new_string('SUM'), 'name': rt.new_string('shipping_tax_amount') }, '_order_total': { 'type': rt.new_string('meta'), 'function': rt.new_string('SUM'), 'name': rt.new_string('total_sales') }, '_order_shipping': { 'type': rt.new_string('meta'), 'function': rt.new_string('SUM'), 'name': rt.new_string('total_shipping') }, 'ID': { 'type': rt.new_string('post_data'), 'function': rt.new_string('COUNT'), 'name': rt.new_string('total_orders'), 'distinct': rt.new_bool(true) }, 'post_date': { 'type': rt.new_string('post_data'), 'function': rt.new_string(''), 'name': rt.new_string('post_date') } }
	mut var_tax_rows_orders := this.get_order_report_data(rt.create_array([rt.ArrayItem{ key: 'data', val: var_query_data }, rt.ArrayItem{ key: 'group_by', val: rt.get_property(rt.new_object('WC_Report_Taxes_By_Date', ['WC_Admin_Report'], &this), 'group_by_query') }, rt.ArrayItem{ key: 'order_by', val: 'post_date ASC' }, rt.ArrayItem{ key: 'query_type', val: 'get_results' }, rt.ArrayItem{ key: 'filter_range', val: true }, rt.ArrayItem{ key: 'order_types', val: rt.call_function('wc_get_order_types', [rt.new_string('sales-reports')]) }, rt.ArrayItem{ key: 'order_status', val: rt.create_array([rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_OrderStatus.completed() }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_OrderStatus.processing() }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_OrderStatus.refunded() }]) }]))
	mut var_tax_rows_full_refunds := this.get_order_report_data(rt.create_array([rt.ArrayItem{ key: 'data', val: rt.create_array([rt.ArrayItem{ key: 'ID', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'post_data' }, rt.ArrayItem{ key: 'distinct', val: true }, rt.ArrayItem{ key: 'function', val: '' }, rt.ArrayItem{ key: 'name', val: 'ID' }]) }, rt.ArrayItem{ key: 'post_parent', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'post_data' }, rt.ArrayItem{ key: 'function', val: '' }, rt.ArrayItem{ key: 'name', val: 'post_parent' }]) }, rt.ArrayItem{ key: 'post_date', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'post_data' }, rt.ArrayItem{ key: 'function', val: '' }, rt.ArrayItem{ key: 'name', val: 'post_date' }]) }]) }, rt.ArrayItem{ key: 'query_type', val: 'get_results' }, rt.ArrayItem{ key: 'filter_range', val: true }, rt.ArrayItem{ key: 'order_types', val: rt.create_array([rt.ArrayItem{ key: none, val: 'shop_order_refund' }]) }, rt.ArrayItem{ key: 'parent_order_status', val: rt.create_array([rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_OrderStatus.refunded() }]) }]))
	mut var_tax_rows_partial_refunds := this.get_order_report_data(rt.create_array([rt.ArrayItem{ key: 'data', val: var_query_data }, rt.ArrayItem{ key: 'group_by', val: rt.get_property(rt.new_object('WC_Report_Taxes_By_Date', ['WC_Admin_Report'], &this), 'group_by_query') }, rt.ArrayItem{ key: 'order_by', val: 'post_date ASC' }, rt.ArrayItem{ key: 'query_type', val: 'get_results' }, rt.ArrayItem{ key: 'filter_range', val: true }, rt.ArrayItem{ key: 'order_types', val: rt.create_array([rt.ArrayItem{ key: none, val: 'shop_order_refund' }]) }, rt.ArrayItem{ key: 'parent_order_status', val: rt.create_array([rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_OrderStatus.completed() }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_OrderStatus.processing() }]) }]))
	mut var_tax_rows := rt.new_array()
	{
		mut iter_1 := rt.add(var_tax_rows_orders, var_tax_rows_partial_refunds).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_tax_row := item_1.val
			mut var_key := rt.call_function('date', [if rt.is_true(rt.identical(rt.new_string('month'), rt.get_property(rt.new_object('WC_Report_Taxes_By_Date', ['WC_Admin_Report'], &this), 'chart_groupby'))) { rt.new_string('Ym') } else { rt.new_string('Ymd') }, rt.call_function('strtotime', [rt.get_property(var_tax_row, 'post_date')])])
			var_tax_rows.array_set(var_key, if var_tax_rows.array_isset(var_key) { var_tax_rows.array_get(var_key) } else { // unsupported expression: Expr_Cast_Object })
		}
	}
	{
		mut iter_1 := var_tax_rows_orders.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_tax_row := item_1.val
			mut var_key := rt.call_function('date', [if rt.is_true(rt.identical(rt.new_string('month'), rt.get_property(rt.new_object('WC_Report_Taxes_By_Date', ['WC_Admin_Report'], &this), 'chart_groupby'))) { rt.new_string('Ym') } else { rt.new_string('Ymd') }, rt.call_function('strtotime', [rt.get_property(var_tax_row, 'post_date')])])
			// unsupported expression: Expr_AssignOp_Plus
			// unsupported expression: Expr_AssignOp_Plus
			// unsupported expression: Expr_AssignOp_Plus
			// unsupported expression: Expr_AssignOp_Plus
			// unsupported expression: Expr_AssignOp_Plus
		}
	}
	{
		mut iter_1 := var_tax_rows_partial_refunds.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_tax_row := item_1.val
			mut var_key := rt.call_function('date', [if rt.is_true(rt.identical(rt.new_string('month'), rt.get_property(rt.new_object('WC_Report_Taxes_By_Date', ['WC_Admin_Report'], &this), 'chart_groupby'))) { rt.new_string('Ym') } else { rt.new_string('Ymd') }, rt.call_function('strtotime', [rt.get_property(var_tax_row, 'post_date')])])
			// unsupported expression: Expr_AssignOp_Plus
			// unsupported expression: Expr_AssignOp_Plus
			// unsupported expression: Expr_AssignOp_Plus
			// unsupported expression: Expr_AssignOp_Plus
		}
	}
	{
		mut iter_1 := var_tax_rows_full_refunds.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_tax_row := item_1.val
			mut var_key := rt.call_function('date', [if rt.is_true(rt.identical(rt.new_string('month'), rt.get_property(rt.new_object('WC_Report_Taxes_By_Date', ['WC_Admin_Report'], &this), 'chart_groupby'))) { rt.new_string('Ym') } else { rt.new_string('Ymd') }, rt.call_function('strtotime', [rt.get_property(var_tax_row, 'post_date')])])
			var_tax_rows.array_set(var_key, if var_tax_rows.array_isset(var_key) { var_tax_rows.array_get(var_key) } else { // unsupported expression: Expr_Cast_Object })
			mut var_parent_order := rt.call_function('wc_get_order', [rt.get_property(var_tax_row, 'post_parent')])
			if rt.is_true(var_parent_order) {
				// unsupported expression: Expr_AssignOp_Plus
				// unsupported expression: Expr_AssignOp_Plus
				// unsupported expression: Expr_AssignOp_Plus
				// unsupported expression: Expr_AssignOp_Plus
			}
		}
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Period'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Number of orders'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Total sales'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wc_help_tip', [rt.call_function('__', [rt.new_string('This is the sum of the \'Order total\' field within your orders.'), rt.new_string('woocommerce')])]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Total shipping'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wc_help_tip', [rt.call_function('__', [rt.new_string('This is the sum of the \'Shipping total\' field within your orders.'), rt.new_string('woocommerce')])]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Total tax'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wc_help_tip', [rt.call_function('__', [rt.new_string('This is the total tax for the rate (shipping tax + product tax).'), rt.new_string('woocommerce')])]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Net profit'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wc_help_tip', [rt.call_function('__', [rt.new_string('Total sales minus shipping and tax.'), rt.new_string('woocommerce')])]))
	// unsupported statement: Stmt_InlineHTML
	if !(!rt.is_true(var_tax_rows)) {
		// unsupported statement: Stmt_InlineHTML
		{
			mut iter_1 := var_tax_rows.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_tax_row := item_1.val
				mut var_date := item_1.key
				mut var_gross := rt.sub(rt.get_property(var_tax_row, 'total_sales'), rt.get_property(var_tax_row, 'total_shipping'))
				mut var_total_tax := rt.add(rt.get_property(var_tax_row, 'tax_amount'), rt.get_property(var_tax_row, 'shipping_tax_amount'))
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(if rt.is_true(rt.identical(rt.new_string('month'), rt.get_property(rt.new_object('WC_Report_Taxes_By_Date', ['WC_Admin_Report'], &this), 'chart_groupby'))) { rt.call_function('date_i18n', [rt.new_string('F'), rt.call_function('strtotime', [(var_date).str() + '01'])]) } else { rt.call_function('date_i18n', [rt.call_function('get_option', [rt.new_string('date_format')]), rt.call_function('strtotime', [var_date.dup()])]) })
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.get_property(var_tax_row, 'total_orders'))
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('wc_price', [var_gross.dup()]))
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('wc_price', [rt.get_property(var_tax_row, 'total_shipping')]))
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('wc_price', [var_total_tax.dup()]))
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('wc_price', [rt.sub(var_gross, var_total_tax)]))
				// unsupported statement: Stmt_InlineHTML
			}
		}
		// unsupported statement: Stmt_InlineHTML
		mut var_gross := rt.sub(rt.call_function('array_sum', [rt.call_function('wp_list_pluck', [rt.cast_array(var_tax_rows), rt.new_string('total_sales')])]), rt.call_function('array_sum', [rt.call_function('wp_list_pluck', [rt.cast_array(var_tax_rows), rt.new_string('total_shipping')])]))
		mut var_total_tax := rt.add(rt.call_function('array_sum', [rt.call_function('wp_list_pluck', [rt.cast_array(var_tax_rows), rt.new_string('tax_amount')])]), rt.call_function('array_sum', [rt.call_function('wp_list_pluck', [rt.cast_array(var_tax_rows), rt.new_string('shipping_tax_amount')])]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Totals'), rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('array_sum', [rt.call_function('wp_list_pluck', [rt.cast_array(var_tax_rows), rt.new_string('total_orders')])]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('wc_price', [var_gross.dup()]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('wc_price', []))
		// unsupported statement: Stmt_InlineHTML
	} else {
	}
	// unsupported statement: Stmt_InlineHTML
}

struct Class_WC_Admin_Report {
	rt.PhpObjectBase
}

fn create_wc_report_taxes_by_date() &Class_WC_Report_Taxes_By_Date {
	mut obj := &Class_WC_Report_Taxes_By_Date{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_admin_report() &Class_WC_Admin_Report {
	mut obj := &Class_WC_Admin_Report{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Report_Taxes_By_Date) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
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
		else { return none }
	}
}

fn (this &Class_WC_Report_Taxes_By_Date) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Report_Taxes_By_Date) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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




pub fn init_wp_content_plugins_woocommerce_includes_admin_reports_class_wc_report_taxes_by_date_php() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))))) {
		// unsupported expression: Expr_Exit
		// unsupported statement: Stmt_Nop
	}
}
