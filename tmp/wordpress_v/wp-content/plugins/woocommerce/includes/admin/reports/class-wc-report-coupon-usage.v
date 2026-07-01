import rt

struct Class_WC_Report_Coupon_Usage {
	rt.PhpObjectBase
pub mut:
		chart_colours rt.PhpVal = rt.new_array()
		coupon_codes rt.PhpVal = rt.new_array()
}

fn (mut this Class_WC_Report_Coupon_Usage) construct()  {
	if rt.is_true(rt.new_bool(rt.get_superglobal('_GET').array_isset(rt.new_string('coupon_codes')) && rt.is_true(rt.new_bool(rt.get_superglobal('_GET').array_get('coupon_codes').is_array())))) {
		this.coupon_codes = rt.call_function('array_filter', [rt.call_function('array_map', [rt.new_string('sanitize_text_field'), rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get('coupon_codes')])])])
	} else if rt.get_superglobal('_GET').array_isset(rt.new_string('coupon_codes')) {
		this.coupon_codes = rt.call_function('array_filter', [rt.create_array([rt.ArrayItem{ key: none, val: rt.call_function('sanitize_text_field', [rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get('coupon_codes')])]) }])])
	}
}

fn (mut this Class_WC_Report_Coupon_Usage) get_chart_legend() rt.PhpVal {
	mut var_legend := []rt.PhpVal{}
	mut var_total_discount_query := { 'data': { 'discount_amount': { 'type': rt.new_string('order_item_meta'), 'order_item_type': rt.new_string('coupon'), 'function': rt.new_string('SUM'), 'name': rt.new_string('discount_amount') } }, 'where': map[string]rt.PhpVal{}, 'query_type': rt.new_string('get_var'), 'filter_range': rt.new_bool(true), 'order_types': rt.call_function('wc_get_order_types', [rt.new_string('order-count')]) }
	mut var_total_coupons_query := { 'data': { 'order_item_id': { 'type': rt.new_string('order_item'), 'order_item_type': rt.new_string('coupon'), 'function': rt.new_string('COUNT'), 'name': rt.new_string('order_coupon_count') } }, 'where': map[string]rt.PhpVal{}, 'query_type': rt.new_string('get_var'), 'filter_range': rt.new_bool(true), 'order_types': rt.call_function('wc_get_order_types', [rt.new_string('order-count')]) }
	if !(!rt.is_true(this.coupon_codes)) {
		mut var_coupon_code_query := { 'type': rt.new_string('order_item'), 'key': rt.new_string('order_item_name'), 'value': this.coupon_codes, 'operator': rt.new_string('IN') }
		var_total_discount_query.array_get_mut('where').array_push(var_coupon_code_query.dup())
		var_total_coupons_query.array_get_mut('where').array_push(var_coupon_code_query.dup())
	}
	mut var_total_discount := this.get_order_report_data(var_total_discount_query.dup())
	mut var_total_coupons := rt.call_function('absint', [this.get_order_report_data(var_total_coupons_query.dup())])
	var_legend << rt.create_array([rt.ArrayItem{ key: 'title', val: rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('%s discounts in total'), rt.new_string('woocommerce')]), '<strong>' + (rt.call_function('wc_price', [var_total_discount.dup()])).str() + '</strong>']) }, rt.ArrayItem{ key: 'color', val: this.chart_colours.array_get('discount_amount') }, rt.ArrayItem{ key: 'highlight_series', val: 1 }])
	var_legend << rt.create_array([rt.ArrayItem{ key: 'title', val: rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('%s coupons used in total'), rt.new_string('woocommerce')]), '<strong>' + (var_total_coupons).str() + '</strong>']) }, rt.ArrayItem{ key: 'color', val: this.chart_colours.array_get('coupon_count') }, rt.ArrayItem{ key: 'highlight_series', val: 0 }])
	return var_legend.dup()
}

fn (mut this Class_WC_Report_Coupon_Usage) output_report()  {
	mut var_ranges := { 'year': rt.call_function('__', [rt.new_string('Year'), rt.new_string('woocommerce')]), 'last_month': rt.call_function('__', [rt.new_string('Last month'), rt.new_string('woocommerce')]), 'month': rt.call_function('__', [rt.new_string('This month'), rt.new_string('woocommerce')]), '7day': rt.call_function('__', [rt.new_string('Last 7 days'), rt.new_string('woocommerce')]) }
	this.chart_colours = rt.create_array([rt.ArrayItem{ key: 'discount_amount', val: '#3498db' }, rt.ArrayItem{ key: 'coupon_count', val: '#d4d9dc' }])
	mut var_current_range := if !(!rt.is_true(rt.get_superglobal('_GET').array_get('range'))) { rt.call_function('sanitize_text_field', [rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get('range')])]) } else { rt.new_string('7day') }
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_current_range.dup(), rt.create_array([rt.ArrayItem{ key: none, val: 'custom' }, rt.ArrayItem{ key: none, val: 'year' }, rt.ArrayItem{ key: none, val: 'last_month' }, rt.ArrayItem{ key: none, val: 'month' }, rt.ArrayItem{ key: none, val: '7day' }])]))))) {
		var_current_range = rt.new_string(rt.new_string('7day'))
	}
	this.check_current_range_nonce(var_current_range.dup())
	this.calculate_current_range(var_current_range.dup())
	rt.include_file((rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'plugin_path', []rt.PhpVal{})).str() + '/includes/admin/views/html-report-by-date.php', '1')
}

fn (mut this Class_WC_Report_Coupon_Usage) get_chart_widgets() rt.PhpVal {
	mut var_widgets := []rt.PhpVal{}
	var_widgets << rt.create_array([rt.ArrayItem{ key: 'title', val: '' }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Report_Coupon_Usage', ['WC_Admin_Report'], &this) }, rt.ArrayItem{ key: none, val: 'coupons_widget' }]) }])
	return var_widgets.dup()
}

fn (mut this Class_WC_Report_Coupon_Usage) coupons_widget()  {
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Filter by coupon'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	mut var_used_coupons := this.get_order_report_data(rt.create_array([rt.ArrayItem{ key: 'data', val: rt.create_array([rt.ArrayItem{ key: 'order_item_name', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'order_item' }, rt.ArrayItem{ key: 'order_item_type', val: 'coupon' }, rt.ArrayItem{ key: 'function', val: '' }, rt.ArrayItem{ key: 'distinct', val: true }, rt.ArrayItem{ key: 'name', val: 'order_item_name' }]) }]) }, rt.ArrayItem{ key: 'where', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'key', val: 'order_item_type' }, rt.ArrayItem{ key: 'value', val: 'coupon' }, rt.ArrayItem{ key: 'operator', val: '=' }]) }]) }, rt.ArrayItem{ key: 'query_type', val: 'get_col' }, rt.ArrayItem{ key: 'filter_range', val: false }]))
	if rt.is_true(rt.new_bool(!(!rt.is_true(var_used_coupons)) && rt.is_true(rt.new_bool(var_used_coupons.dup().is_array())))) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_attr_e', [rt.new_string('Choose coupons&hellip;'), rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('All coupons'), rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		{
			mut iter_1 := var_used_coupons.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_coupon := item_1.val
				print('<option value="' + (rt.call_function('esc_attr', [var_coupon.dup()])).str() + '"' + (rt.call_function('wc_selected', [var_coupon.dup(), this.coupon_codes])).str() + '>' + (rt.call_function('esc_html', [var_coupon.dup()])).str() + '</option>')
			}
		}
		// unsupported statement: Stmt_InlineHTML
		// unsupported statement: Stmt_Nop
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_attr_e', [rt.new_string('Show'), rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Show'), rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(if !(!rt.is_true(rt.get_superglobal('_GET').array_get('range'))) { rt.call_function('esc_attr', [rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get('range')])]) } else { rt.new_string('') })
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(if !(!rt.is_true(rt.get_superglobal('_GET').array_get('start_date'))) { rt.call_function('esc_attr', [rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get('start_date')])]) } else { rt.new_string('') })
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(if !(!rt.is_true(rt.get_superglobal('_GET').array_get('end_date'))) { rt.call_function('esc_attr', [rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get('end_date')])]) } else { rt.new_string('') })
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(if !(!rt.is_true(rt.get_superglobal('_GET').array_get('page'))) { rt.call_function('esc_attr', [rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get('page')])]) } else { rt.new_string('') })
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(if !(!rt.is_true(rt.get_superglobal('_GET').array_get('tab'))) { rt.call_function('esc_attr', [rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get('tab')])]) } else { rt.new_string('') })
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(if !(!rt.is_true(rt.get_superglobal('_GET').array_get('report'))) { rt.call_function('esc_attr', [rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get('report')])]) } else { rt.new_string('') })
		// unsupported statement: Stmt_InlineHTML
		// unsupported statement: Stmt_Nop
		// unsupported statement: Stmt_InlineHTML
	} else {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('No used coupons found'), rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Most popular'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	mut var_most_popular := this.get_order_report_data(rt.create_array([rt.ArrayItem{ key: 'data', val: rt.create_array([rt.ArrayItem{ key: 'order_item_name', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'order_item' }, rt.ArrayItem{ key: 'order_item_type', val: 'coupon' }, rt.ArrayItem{ key: 'function', val: '' }, rt.ArrayItem{ key: 'name', val: 'coupon_code' }]) }, rt.ArrayItem{ key: 'order_item_id', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'order_item' }, rt.ArrayItem{ key: 'order_item_type', val: 'coupon' }, rt.ArrayItem{ key: 'function', val: 'COUNT' }, rt.ArrayItem{ key: 'name', val: 'coupon_count' }]) }]) }, rt.ArrayItem{ key: 'where', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'order_item' }, rt.ArrayItem{ key: 'key', val: 'order_item_type' }, rt.ArrayItem{ key: 'value', val: 'coupon' }, rt.ArrayItem{ key: 'operator', val: '=' }]) }]) }, rt.ArrayItem{ key: 'order_by', val: 'coupon_count DESC' }, rt.ArrayItem{ key: 'group_by', val: 'order_item_name' }, rt.ArrayItem{ key: 'limit', val: 12 }, rt.ArrayItem{ key: 'query_type', val: 'get_results' }, rt.ArrayItem{ key: 'filter_range', val: true }]))
	if rt.is_true(rt.new_bool(!(!rt.is_true(var_most_popular)) && rt.is_true(rt.new_bool(var_most_popular.dup().is_array())))) {
		{
			mut iter_1 := var_most_popular.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_coupon := item_1.val
				print('<tr class="' + if rt.is_true(rt.call_function('in_array', [rt.get_property(var_coupon, 'coupon_code'), this.coupon_codes])) { 'active' } else { '' } + '">\n\t\t\t\t\t\t\t<td class="count" width="1%">' + (rt.call_function('esc_html', [rt.get_property(var_coupon, 'coupon_count')])).str() + '</td>\n\t\t\t\t\t\t\t<td class="name"><a href="' + (rt.call_function('esc_url', [rt.call_function('add_query_arg', [rt.new_string('coupon_codes'), rt.get_property(var_coupon, 'coupon_code')])])).str() + '">' + (rt.call_function('esc_html', [rt.get_property(var_coupon, 'coupon_code')])).str() + '</a></td>\n\t\t\t\t\t\t</tr>')
			}
		}
	} else {
		print('<tr><td colspan="2">' + (rt.call_function('esc_html__', [rt.new_string('No coupons found in range'), rt.new_string('woocommerce')])).str() + '</td></tr>')
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Most discount'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	mut var_most_discount := this.get_order_report_data(rt.create_array([rt.ArrayItem{ key: 'data', val: rt.create_array([rt.ArrayItem{ key: 'order_item_name', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'order_item' }, rt.ArrayItem{ key: 'order_item_type', val: 'coupon' }, rt.ArrayItem{ key: 'function', val: '' }, rt.ArrayItem{ key: 'name', val: 'coupon_code' }]) }, rt.ArrayItem{ key: 'discount_amount', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'order_item_meta' }, rt.ArrayItem{ key: 'order_item_type', val: 'coupon' }, rt.ArrayItem{ key: 'function', val: 'SUM' }, rt.ArrayItem{ key: 'name', val: 'discount_amount' }]) }]) }, rt.ArrayItem{ key: 'where', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'order_item' }, rt.ArrayItem{ key: 'key', val: 'order_item_type' }, rt.ArrayItem{ key: 'value', val: 'coupon' }, rt.ArrayItem{ key: 'operator', val: '=' }]) }]) }, rt.ArrayItem{ key: 'order_by', val: 'discount_amount DESC' }, rt.ArrayItem{ key: 'group_by', val: 'order_item_name' }, rt.ArrayItem{ key: 'limit', val: 12 }, rt.ArrayItem{ key: 'query_type', val: 'get_results' }, rt.ArrayItem{ key: 'filter_range', val: true }]))
	if rt.is_true(rt.new_bool(!(!rt.is_true(var_most_discount)) && rt.is_true(rt.new_bool(var_most_discount.dup().is_array())))) {
		{
			mut iter_1 := var_most_discount.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_coupon := item_1.val
				print('<tr class="' + if rt.is_true(rt.call_function('in_array', [rt.get_property(var_coupon, 'coupon_code'), this.coupon_codes])) { 'active' } else { '' } + '">\n\t\t\t\t\t\t\t<td class="count" width="1%">' + (rt.call_function('wc_price', [rt.get_property(var_coupon, 'discount_amount')])).str() + '</td>\n\t\t\t\t\t\t\t<td class="name"><a href="' + (rt.call_function('esc_url', [rt.call_function('add_query_arg', [rt.new_string('coupon_codes'), rt.get_property(var_coupon, 'coupon_code')])])).str() + '">' + (rt.call_function('esc_html', [rt.get_property(var_coupon, 'coupon_code')])).str() + '</a></td>\n\t\t\t\t\t\t</tr>')
				// unsupported statement: Stmt_Nop
			}
		}
	} else {
		print('<tr><td colspan="3">' + (rt.call_function('esc_html__', [rt.new_string('No coupons found in range'), rt.new_string('woocommerce')])).str() + '</td></tr>')
	}
	// unsupported statement: Stmt_InlineHTML
	if !rt.is_true(this.coupon_codes) {
		// unsupported statement: Stmt_InlineHTML
	} else {
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
}

fn (mut this Class_WC_Report_Coupon_Usage) get_export_button()  {
	mut var_current_range := if !(!rt.is_true(rt.get_superglobal('_GET').array_get('range'))) { rt.call_function('sanitize_text_field', [rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get('range')])]) } else { rt.new_string('7day') }
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_current_range.dup()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [rt.call_function('date_i18n', [rt.new_string('Y-m-d'), rt.call_function('current_time', [rt.new_string('timestamp')])])]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('Date'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [rt.get_property(rt.new_object('WC_Report_Coupon_Usage', ['WC_Admin_Report'], &this), 'chart_groupby')]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Export CSV'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
}

fn (mut this Class_WC_Report_Coupon_Usage) get_main_chart()  {
	mut var_wp_locale := rt.new_null()
	// unsupported statement: Stmt_Global
	mut var_order_coupon_counts_query := { 'data': { 'order_item_name': { 'type': rt.new_string('order_item'), 'order_item_type': rt.new_string('coupon'), 'function': rt.new_string('COUNT'), 'name': rt.new_string('order_coupon_count') }, 'post_date': { 'type': rt.new_string('post_data'), 'function': rt.new_string(''), 'name': rt.new_string('post_date') } }, 'where': map[string]rt.PhpVal{}, 'group_by': rt.get_property(rt.new_object('WC_Report_Coupon_Usage', ['WC_Admin_Report'], &this), 'group_by_query'), 'order_by': rt.new_string('post_date ASC'), 'query_type': rt.new_string('get_results'), 'filter_range': rt.new_bool(true), 'order_types': rt.call_function('wc_get_order_types', [rt.new_string('order-count')]) }
	mut var_order_discount_amounts_query := { 'data': { 'discount_amount': { 'type': rt.new_string('order_item_meta'), 'order_item_type': rt.new_string('coupon'), 'function': rt.new_string('SUM'), 'name': rt.new_string('discount_amount') }, 'post_date': { 'type': rt.new_string('post_data'), 'function': rt.new_string(''), 'name': rt.new_string('post_date') } }, 'where': map[string]rt.PhpVal{}, 'group_by': (rt.get_property(rt.new_object('WC_Report_Coupon_Usage', ['WC_Admin_Report'], &this), 'group_by_query')).str() + ', order_item_name', 'order_by': rt.new_string('post_date ASC'), 'query_type': rt.new_string('get_results'), 'filter_range': rt.new_bool(true), 'order_types': rt.call_function('wc_get_order_types', [rt.new_string('order-count')]) }
	if !(!rt.is_true(this.coupon_codes)) {
		mut var_coupon_code_query := { 'type': rt.new_string('order_item'), 'key': rt.new_string('order_item_name'), 'value': this.coupon_codes, 'operator': rt.new_string('IN') }
		var_order_coupon_counts_query.array_get_mut('where').array_push(var_coupon_code_query.dup())
		.array_get_mut().array_push(.dup())
	}
	mut var_order_coupon_counts := 
	
}

struct Class_WC_Admin_Report {
	rt.PhpObjectBase
}

fn create_wc_report_coupon_usage() &Class_WC_Report_Coupon_Usage {
	mut obj := &Class_WC_Report_Coupon_Usage{
		PhpObjectBase: rt.PhpObjectBase{}
		chart_colours: rt.new_array()
		coupon_codes: rt.new_array()
	}
	obj.construct()
	return obj
}

fn create_wc_admin_report() &Class_WC_Admin_Report {
	mut obj := &Class_WC_Admin_Report{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Report_Coupon_Usage) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
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
		'coupons_widget' {
			this.coupons_widget()
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
		else { return none }
	}
}

fn (this &Class_WC_Report_Coupon_Usage) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'chart_colours' { return this.chart_colours }
		'coupon_codes' { return this.coupon_codes }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_Report_Coupon_Usage) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'chart_colours' { this.chart_colours = val; return true }
		'coupon_codes' { this.coupon_codes = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
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




pub fn init_wp_content_plugins_woocommerce_includes_admin_reports_class_wc_report_coupon_usage_php() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))))) {
		// unsupported expression: Expr_Exit
		// unsupported statement: Stmt_Nop
	}
}
