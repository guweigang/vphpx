import rt

struct Class_WC_Report_Sales_By_Category {
	rt.PhpObjectBase
pub mut:
		chart_colours rt.PhpVal = rt.new_array()
		show_categories rt.PhpVal = rt.new_array()
		item_sales rt.PhpVal = rt.new_array()
		item_sales_and_times rt.PhpVal = rt.new_array()
}

fn (mut this Class_WC_Report_Sales_By_Category) construct()  {
	if rt.get_superglobal('_GET').array_isset(rt.new_string('show_categories')) {
		this.show_categories = if rt.is_true(rt.new_bool(rt.get_superglobal('_GET').array_get('show_categories').is_array())) { rt.call_function('array_map', [rt.new_string('absint'), rt.get_superglobal('_GET').array_get('show_categories')]) } else { rt.create_array([rt.ArrayItem{ key: none, val: rt.call_function('absint', [rt.get_superglobal('_GET').array_get('show_categories')]) }]) }
	}
}

fn (mut this Class_WC_Report_Sales_By_Category) get_products_in_category(var_category_id rt.PhpVal) rt.PhpVal {
	mut var_term_ids := rt.call_function('get_term_children', [var_category_id.dup(), rt.new_string('product_cat')])
	var_term_ids.array_push(var_category_id.dup())
	mut var_product_ids := rt.call_function('get_objects_in_term', [var_term_ids.dup(), rt.new_string('product_cat')])
	return rt.call_function('array_unique', [rt.call_function('apply_filters', [rt.new_string('woocommerce_report_sales_by_category_get_products_in_category'), var_product_ids.dup(), var_category_id.dup()])])
}

fn (mut this Class_WC_Report_Sales_By_Category) get_chart_legend() rt.PhpVal {
	if !rt.is_true(this.show_categories) {
		return rt.new_array()
	}
	mut var_legend := rt.new_array()
	mut var_index := rt.new_int(rt.new_int(0))
	{
		mut iter_1 := this.show_categories.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_category := item_1.val
			var_category = rt.call_function('get_term', [var_category.dup(), rt.new_string('product_cat')])
			mut var_total := rt.new_int(rt.new_int(0))
			mut var_product_ids := this.get_products_in_category(rt.get_property(var_category, 'term_id'))
			{
				mut iter_2 := var_product_ids.iterator()
				for {
					item_2 := iter_2.next() or { break }
					mut var_id := item_2.val
					if this.item_sales.array_isset(var_id) {
						// unsupported expression: Expr_AssignOp_Plus
					}
				}
			}
			var_legend << rt.create_array([rt.ArrayItem{ key: 'title', val: rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('%1$s sales in %2$s'), rt.new_string('woocommerce')]), '<strong>' + (rt.call_function('wc_price', [var_total.dup()])).str() + '</strong>', rt.get_property(var_category, 'name')]) }, rt.ArrayItem{ key: 'color', val: if this.chart_colours.array_isset(var_index) { this.chart_colours.array_get(var_index) } else { this.chart_colours.array_get(0) } }, rt.ArrayItem{ key: 'highlight_series', val: var_index }])
			rt.post_inc(var_index)
		}
	}
	return var_legend.dup()
}

fn (mut this Class_WC_Report_Sales_By_Category) output_report()  {
	mut var_ranges := { 'year': rt.call_function('__', [rt.new_string('Year'), rt.new_string('woocommerce')]), 'last_month': rt.call_function('__', [rt.new_string('Last month'), rt.new_string('woocommerce')]), 'month': rt.call_function('__', [rt.new_string('This month'), rt.new_string('woocommerce')]), '7day': rt.call_function('__', [rt.new_string('Last 7 days'), rt.new_string('woocommerce')]) }
	this.chart_colours = rt.create_array([rt.ArrayItem{ key: none, val: '#3498db' }, rt.ArrayItem{ key: none, val: '#34495e' }, rt.ArrayItem{ key: none, val: '#1abc9c' }, rt.ArrayItem{ key: none, val: '#2ecc71' }, rt.ArrayItem{ key: none, val: '#f1c40f' }, rt.ArrayItem{ key: none, val: '#e67e22' }, rt.ArrayItem{ key: none, val: '#e74c3c' }, rt.ArrayItem{ key: none, val: '#2980b9' }, rt.ArrayItem{ key: none, val: '#8e44ad' }, rt.ArrayItem{ key: none, val: '#2c3e50' }, rt.ArrayItem{ key: none, val: '#16a085' }, rt.ArrayItem{ key: none, val: '#27ae60' }, rt.ArrayItem{ key: none, val: '#f39c12' }, rt.ArrayItem{ key: none, val: '#d35400' }, rt.ArrayItem{ key: none, val: '#c0392b' }])
	mut var_current_range := if !(!rt.is_true(rt.get_superglobal('_GET').array_get('range'))) { rt.call_function('sanitize_text_field', [rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get('range')])]) } else { rt.new_string('7day') }
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_current_range.dup(), rt.create_array([rt.ArrayItem{ key: none, val: 'custom' }, rt.ArrayItem{ key: none, val: 'year' }, rt.ArrayItem{ key: none, val: 'last_month' }, rt.ArrayItem{ key: none, val: 'month' }, rt.ArrayItem{ key: none, val: '7day' }])]))))) {
		var_current_range = rt.new_string(rt.new_string('7day'))
	}
	this.check_current_range_nonce(var_current_range.dup())
	this.calculate_current_range(var_current_range.dup())
	if !(!rt.is_true(this.show_categories)) {
		mut var_order_items := this.get_order_report_data(rt.create_array([rt.ArrayItem{ key: 'data', val: rt.create_array([rt.ArrayItem{ key: '_product_id', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'order_item_meta' }, rt.ArrayItem{ key: 'order_item_type', val: 'line_item' }, rt.ArrayItem{ key: 'function', val: '' }, rt.ArrayItem{ key: 'name', val: 'product_id' }]) }, rt.ArrayItem{ key: '_line_total', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'order_item_meta' }, rt.ArrayItem{ key: 'order_item_type', val: 'line_item' }, rt.ArrayItem{ key: 'function', val: 'SUM' }, rt.ArrayItem{ key: 'name', val: 'order_item_amount' }]) }, rt.ArrayItem{ key: 'post_date', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'post_data' }, rt.ArrayItem{ key: 'function', val: '' }, rt.ArrayItem{ key: 'name', val: 'post_date' }]) }]) }, rt.ArrayItem{ key: 'group_by', val: 'ID, product_id, post_date' }, rt.ArrayItem{ key: 'query_type', val: 'get_results' }, rt.ArrayItem{ key: 'filter_range', val: true }]))
		this.item_sales = rt.new_array()
		this.item_sales_and_times = rt.new_array()
		if rt.is_true(rt.new_bool(var_order_items.dup().is_array())) {
			{
				mut iter_1 := var_order_items.iterator()
				for {
					item_1 := iter_1.next() or { break }
					mut var_order_item := item_1.val
					mut switch_val_1 := rt.get_property(rt.new_object('WC_Report_Sales_By_Category', ['WC_Admin_Report'], &this), 'chart_groupby')
					if rt.is_true(rt.equal(switch_val_1, rt.new_string('day'))) {
						mut var_time := rt.mul(rt.call_function('strtotime', [rt.call_function('gmdate', [rt.new_string('Ymd'), rt.call_function('strtotime', [rt.get_property(var_order_item, 'post_date')])])]), rt.new_int(1000))
					} else {
						var_time = rt.mul(rt.call_function('strtotime', [(rt.call_function('gmdate', [rt.new_string('Ym'), rt.call_function('strtotime', [rt.get_property(var_order_item, 'post_date')])])).str() + '01']), rt.new_int(1000))
					}
					this.item_sales_and_times.array_get_mut(var_time).array_set(rt.get_property(var_order_item, 'product_id'), if this.item_sales_and_times.array_get(var_time).array_isset(rt.get_property(var_order_item, 'product_id')) { rt.add(this.item_sales_and_times.array_get(var_time).array_get(rt.get_property(var_order_item, 'product_id')), rt.get_property(var_order_item, 'order_item_amount')) } else { rt.get_property(var_order_item, 'order_item_amount') })
					this.item_sales.array_set(rt.get_property(var_order_item, 'product_id'), if this.item_sales.array_isset(rt.get_property(var_order_item, 'product_id')) { rt.add(this.item_sales.array_get(rt.get_property(var_order_item, 'product_id')), rt.get_property(var_order_item, 'order_item_amount')) } else { rt.get_property(var_order_item, 'order_item_amount') })
				}
			}
		}
	}
	rt.include_file((rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'plugin_path', []rt.PhpVal{})).str() + '/includes/admin/views/html-report-by-date.php', '1')
}

fn (mut this Class_WC_Report_Sales_By_Category) get_chart_widgets() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'title', val: rt.call_function('__', [rt.new_string('Categories'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Report_Sales_By_Category', ['WC_Admin_Report'], &this) }, rt.ArrayItem{ key: none, val: 'category_widget' }]) }]) }])
}

fn (mut this Class_WC_Report_Sales_By_Category) category_widget()  {
	mut var_categories := rt.call_function('get_terms', [rt.new_string('product_cat'), rt.create_array([rt.ArrayItem{ key: 'orderby', val: 'name' }])])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('Select categories&hellip;'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	mut var_r := rt.new_array()
	var_r['pad_counts'] = rt.new_int(1)
	var_r['hierarchical'] = rt.new_int(1)
	var_r['hide_empty'] = rt.new_int(1)
	var_r['value'] = rt.new_string('id')
	var_r['selected'] = this.show_categories
	rt.include_file((rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'plugin_path', []rt.PhpVal{})).str() + '/includes/walkers/class-wc-product-cat-dropdown-walker.php', '2')
	rt.echo_val(rt.call_function('wc_walk_category_dropdown_tree', [var_categories.dup(), rt.new_int(0), var_r.dup()]))
	// unsupported statement: Stmt_Nop
	// unsupported statement: Stmt_InlineHTML
	// unsupported statement: Stmt_Nop
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('None'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('All'), rt.new_string('woocommerce')])
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
}

fn (mut this Class_WC_Report_Sales_By_Category) get_export_button()  {
	mut var_current_range := if !(!rt.is_true(rt.get_superglobal('_GET').array_get('range'))) { rt.call_function('sanitize_text_field', [rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get('range')])]) } else { rt.new_string('7day') }
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_current_range.dup()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [rt.call_function('date_i18n', [rt.new_string('Y-m-d'), rt.call_function('current_time', [rt.new_string('timestamp')])])]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('Date'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [rt.get_property(rt.new_object('WC_Report_Sales_By_Category', ['WC_Admin_Report'], &this), 'chart_groupby')]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Export CSV'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
}

fn (mut this Class_WC_Report_Sales_By_Category) get_main_chart()  {
	mut var_wp_locale := rt.new_null()
	// unsupported statement: Stmt_Global
	if !rt.is_true(this.show_categories) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Choose a category to view stats'), rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
	} else {
		mut var_chart_data := rt.new_array()
		mut var_index := rt.new_int(rt.new_int(0))
		{
			mut iter_1 := this.show_categories.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_category := item_1.val
				var_category = rt.call_function('get_term', [var_category.dup(), rt.new_string('product_cat')])
				mut var_product_ids := this.get_products_in_category(rt.get_property(, 'term_id'))
				mut var_category_chart_data := rt.new_array()
				{
					mut var_i := rt.new_int()
					for {
						if !(rt.is_true(rt.less_equal(, ))) { break }
						
						
					}
				}
			}
		}
	}
}

struct Class_WC_Admin_Report {
	rt.PhpObjectBase
}

fn create_wc_report_sales_by_category() &Class_WC_Report_Sales_By_Category {
	mut obj := &Class_WC_Report_Sales_By_Category{
		PhpObjectBase: rt.PhpObjectBase{}
		chart_colours: rt.new_array()
		show_categories: rt.new_array()
		item_sales: rt.new_array()
		item_sales_and_times: rt.new_array()
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

fn (mut this Class_WC_Report_Sales_By_Category) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'get_products_in_category' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_products_in_category(dispatch_arg_0)
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
		'category_widget' {
			this.category_widget()
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

fn (this &Class_WC_Report_Sales_By_Category) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'chart_colours' { return this.chart_colours }
		'show_categories' { return this.show_categories }
		'item_sales' { return this.item_sales }
		'item_sales_and_times' { return this.item_sales_and_times }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_Report_Sales_By_Category) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'chart_colours' { this.chart_colours = val; return true }
		'show_categories' { this.show_categories = val; return true }
		'item_sales' { this.item_sales = val; return true }
		'item_sales_and_times' { this.item_sales_and_times = val; return true }
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




pub fn init_wp_content_plugins_woocommerce_includes_admin_reports_class_wc_report_sales_by_category_php() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))))) {
		// unsupported expression: Expr_Exit
		// unsupported statement: Stmt_Nop
	}
}
