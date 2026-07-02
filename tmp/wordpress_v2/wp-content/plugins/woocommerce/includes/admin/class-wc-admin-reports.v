import rt

struct Class_WC_Admin_Reports {
	rt.PhpObjectBase
}

fn Class_WC_Admin_Reports.register_hook_handlers() {
	rt.call_function('add_filter', [
		rt.new_string('woocommerce_after_dashboard_status_widget_parameter'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'get_report_instance' }]),
	])
	rt.call_function('add_filter', [
		rt.new_string('woocommerce_dashboard_status_widget_reports'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'replace_dashboard_status_widget_reports' }]),
	])
}

fn Class_WC_Admin_Reports.register_orders_hook_handlers() {
	rt.call_function('add_action', [
		rt.new_string('woocommerce_delete_shop_order_transients'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'delete_legacy_reports_transients' }]),
		rt.new_int(10),
		rt.new_int(1),
	])
	rt.call_function('add_action', [
		rt.new_string('woocommerce_delete_legacy_report_transients'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'delete_legacy_reports_transients' }]),
		rt.new_int(10),
		rt.new_int(2),
	])
}

fn Class_WC_Admin_Reports.delete_legacy_reports_transients(order_id i64, defer bool) {
	if var_defer
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_using_ext_object_cache', []rt.PhpVal{}))))) {
		mut var_skip_consequent := rt.new_null()
		mut var_schedule := rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_skip_consequent))))
			&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('as_has_scheduled_action', [rt.new_string('woocommerce_delete_legacy_report_transients'), rt.new_null(), rt.new_string('woocommerce')]))))))
		if rt.is_true(var_schedule) {
			rt.call_function('as_schedule_single_action', [
				rt.add(rt.call_function('time', []rt.PhpVal{}),
					rt.get_constant('MINUTE_IN_SECONDS')),
				rt.new_string('woocommerce_delete_legacy_report_transients'),
				rt.create_array([rt.ArrayItem{ key: none, val: order_id },
					rt.ArrayItem{ key: none, val: false }]),
				rt.new_string('woocommerce'),
			])
		}
		var_skip_consequent = rt.new_bool(true)
		return
	}
	rt.call_function('delete_transient', [rt.new_string('wc_admin_report')])
	mut iter_1 := Class_WC_Admin_Reports.get_reports().iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_report_group := item_1.val
		mut iter_2 := var_report_group.array_get(rt.new_string('reports')).iterator()
		for {
			item_2 := iter_2.next() or { break }
			mut var_report := item_2.val
			mut var_report_key := item_2.key
			rt.call_function('delete_transient', [
				rt.new_string('wc_report_' + var_report_key.str()),
			])
		}
	}
}

fn Class_WC_Admin_Reports.get_report_instance() rt.PhpVal {
	rt.include_file(@DIR + '/reports/class-wc-admin-report.php', '2')
	return rt.new_object('WC_Admin_Report', []string{}, create_wc_admin_report())
}

fn Class_WC_Admin_Reports.replace_dashboard_status_widget_reports(var_status_widget_reports rt.PhpVal) rt.PhpVal {
	mut var_status_widget_reports_mutated := var_status_widget_reports
	mut var_report := Class_WC_Admin_Reports.get_report_instance()
	rt.include_file(@DIR + '/reports/class-wc-report-sales-by-date.php', '2')
	mut var_sales_by_date := create_wc_report_sales_by_date()
	rt.set_property(var_sales_by_date, 'start_date', rt.call_function('strtotime', [
		rt.call_function('gmdate', [rt.new_string('Y-m-01'),
			rt.call_function('current_time', [rt.new_string('timestamp')])]),
	]))
	rt.set_property(var_sales_by_date, 'end_date', rt.call_function('strtotime', [
		rt.call_function('gmdate', [rt.new_string('Y-m-d'),
			rt.call_function('current_time', [rt.new_string('timestamp')])]),
	]))
	rt.set_property(var_sales_by_date, 'chart_groupby', rt.new_string('day'))
	rt.set_property(var_sales_by_date, 'group_by_query',
		rt.new_string('YEAR(posts.post_date), MONTH(posts.post_date), DAY(posts.post_date)'))
	var_status_widget_reports_mutated.array_set('net_sales_link',
		'admin.php?page=wc-reports&tab=orders&range=month')
	var_status_widget_reports_mutated.array_set('top_seller_link',
		'admin.php?page=wc-reports&tab=orders&report=sales_by_product&range=month&product_ids=')
	var_status_widget_reports_mutated.array_set('lowstock_link',
		'admin.php?page=wc-reports&tab=stock&report=low_in_stock')
	var_status_widget_reports_mutated.array_set('outofstock_link',
		'admin.php?page=wc-reports&tab=stock&report=out_of_stock')
	var_status_widget_reports_mutated.array_set('report_data', var_sales_by_date.get_report_data())
	var_status_widget_reports_mutated.array_set('get_sales_sparkline', rt.create_array([
		rt.ArrayItem{ key: none, val: var_report },
		rt.ArrayItem{ key: none, val: 'get_sales_sparkline' },
	]))
	return var_status_widget_reports_mutated.clone()
}

fn Class_WC_Admin_Reports.output() {
	mut var_reports := Class_WC_Admin_Reports.get_reports()
	mut var_first_tab := rt.func_array_keys(var_reports.clone())
	mut var_current_tab := if !(!rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('tab')))) && rt.is_true(rt.new_bool(var_reports.clone().array_isset(rt.get_superglobal('_GET').array_get(rt.new_string('tab'))))) { rt.call_function('sanitize_title', [
			rt.get_superglobal('_GET').array_get(rt.new_string('tab')),
		]) } else { var_first_tab.array_get(rt.new_int(0)) }
	mut var_current_report := if rt.get_superglobal('_GET').array_isset(rt.new_string('report')) { rt.call_function('sanitize_title', [
			rt.get_superglobal('_GET').array_get(rt.new_string('report')),
		]) } else { rt.call_function('current', [
			rt.func_array_keys(var_reports.array_get(var_current_tab).array_get(rt.new_string('reports'))),
		]) }
	rt.include_file((rt.call_function('dirname', [rt.new_string(@FILE)])).str() +
		'/reports/class-wc-admin-report.php', '2')
	rt.include_file((rt.call_function('dirname', [rt.new_string(@FILE)])).str() +
		'/views/html-admin-page-reports.php', '2')
}

fn Class_WC_Admin_Reports.get_reports() rt.PhpVal {
	mut var_reports := rt.create_array([
		rt.ArrayItem{ key: 'orders', val: rt.create_array([
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Orders'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'reports', val: rt.create_array([
				rt.ArrayItem{ key: 'sales_by_date', val: rt.create_array([
					rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
						rt.new_string('Sales by date'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'description', val: '' },
					rt.ArrayItem{ key: 'hide_title', val: true },
					rt.ArrayItem{ key: 'callback', val: rt.create_array([
						rt.ArrayItem{ key: none, val: @STRUCT },
						rt.ArrayItem{ key: none, val: 'get_report' },
					]) },
				]) },
				rt.ArrayItem{ key: 'sales_by_product', val: rt.create_array([
					rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
						rt.new_string('Sales by product'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'description', val: '' },
					rt.ArrayItem{ key: 'hide_title', val: true },
					rt.ArrayItem{ key: 'callback', val: rt.create_array([
						rt.ArrayItem{ key: none, val: @STRUCT },
						rt.ArrayItem{ key: none, val: 'get_report' },
					]) },
				]) },
				rt.ArrayItem{ key: 'sales_by_category', val: rt.create_array([
					rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
						rt.new_string('Sales by category'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'description', val: '' },
					rt.ArrayItem{ key: 'hide_title', val: true },
					rt.ArrayItem{ key: 'callback', val: rt.create_array([
						rt.ArrayItem{ key: none, val: @STRUCT },
						rt.ArrayItem{ key: none, val: 'get_report' },
					]) },
				]) },
				rt.ArrayItem{ key: 'coupon_usage', val: rt.create_array([
					rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
						rt.new_string('Coupons by date'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'description', val: '' },
					rt.ArrayItem{ key: 'hide_title', val: true },
					rt.ArrayItem{ key: 'callback', val: rt.create_array([
						rt.ArrayItem{ key: none, val: @STRUCT },
						rt.ArrayItem{ key: none, val: 'get_report' },
					]) },
				]) },
				rt.ArrayItem{ key: 'downloads', val: rt.create_array([
					rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
						rt.new_string('Customer downloads'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'description', val: '' },
					rt.ArrayItem{ key: 'hide_title', val: true },
					rt.ArrayItem{ key: 'callback', val: rt.create_array([
						rt.ArrayItem{ key: none, val: @STRUCT },
						rt.ArrayItem{ key: none, val: 'get_report' },
					]) },
				]) },
			]) },
		]) },
		rt.ArrayItem{ key: 'customers', val: rt.create_array([
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Customers'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'reports', val: rt.create_array([
				rt.ArrayItem{ key: 'customers', val: rt.create_array([
					rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
						rt.new_string('Customers vs. guests'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'description', val: '' },
					rt.ArrayItem{ key: 'hide_title', val: true },
					rt.ArrayItem{ key: 'callback', val: rt.create_array([
						rt.ArrayItem{ key: none, val: @STRUCT },
						rt.ArrayItem{ key: none, val: 'get_report' },
					]) },
				]) },
				rt.ArrayItem{ key: 'customer_list', val: rt.create_array([
					rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
						rt.new_string('Customer list'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'description', val: '' },
					rt.ArrayItem{ key: 'hide_title', val: true },
					rt.ArrayItem{ key: 'callback', val: rt.create_array([
						rt.ArrayItem{ key: none, val: @STRUCT },
						rt.ArrayItem{ key: none, val: 'get_report' },
					]) },
				]) },
			]) },
		]) },
		rt.ArrayItem{ key: 'stock', val: rt.create_array([
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Stock'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'reports', val: rt.create_array([
				rt.ArrayItem{ key: 'low_in_stock', val: rt.create_array([
					rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
						rt.new_string('Low in stock'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'description', val: '' },
					rt.ArrayItem{ key: 'hide_title', val: true },
					rt.ArrayItem{ key: 'callback', val: rt.create_array([
						rt.ArrayItem{ key: none, val: @STRUCT },
						rt.ArrayItem{ key: none, val: 'get_report' },
					]) },
				]) },
				rt.ArrayItem{ key: 'out_of_stock', val: rt.create_array([
					rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
						rt.new_string('Out of stock'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'description', val: '' },
					rt.ArrayItem{ key: 'hide_title', val: true },
					rt.ArrayItem{ key: 'callback', val: rt.create_array([
						rt.ArrayItem{ key: none, val: @STRUCT },
						rt.ArrayItem{ key: none, val: 'get_report' },
					]) },
				]) },
				rt.ArrayItem{ key: 'most_stocked', val: rt.create_array([
					rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
						rt.new_string('Most stocked'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'description', val: '' },
					rt.ArrayItem{ key: 'hide_title', val: true },
					rt.ArrayItem{ key: 'callback', val: rt.create_array([
						rt.ArrayItem{ key: none, val: @STRUCT },
						rt.ArrayItem{ key: none, val: 'get_report' },
					]) },
				]) },
			]) },
		]) },
	])
	if rt.is_true(rt.call_function('wc_tax_enabled', []rt.PhpVal{})) {
		var_reports.array_set('taxes', rt.create_array([
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Taxes'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'reports', val: rt.create_array([
				rt.ArrayItem{ key: 'taxes_by_code', val: rt.create_array([
					rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
						rt.new_string('Taxes by code'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'description', val: '' },
					rt.ArrayItem{ key: 'hide_title', val: true },
					rt.ArrayItem{ key: 'callback', val: rt.create_array([
						rt.ArrayItem{ key: none, val: @STRUCT },
						rt.ArrayItem{ key: none, val: 'get_report' },
					]) },
				]) },
				rt.ArrayItem{ key: 'taxes_by_date', val: rt.create_array([
					rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
						rt.new_string('Taxes by date'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'description', val: '' },
					rt.ArrayItem{ key: 'hide_title', val: true },
					rt.ArrayItem{ key: 'callback', val: rt.create_array([
						rt.ArrayItem{ key: none, val: @STRUCT },
						rt.ArrayItem{ key: none, val: 'get_report' },
					]) },
				]) },
			]) },
		]))
	}
	var_reports = rt.call_function('apply_filters', [
		rt.new_string('woocommerce_admin_reports'),
		var_reports.clone(),
	])
	var_reports = rt.call_function('apply_filters', [
		rt.new_string('woocommerce_reports_charts'),
		var_reports.clone(),
	])
	mut iter_3 := var_reports.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_report_group := item_3.val
		mut var_key := item_3.key
		if var_report_group.array_isset(rt.new_string('charts')) {
			var_report_group.array_set('reports',
				var_report_group.array_get(rt.new_string('charts')))
		}
		if !(var_report_group.array_isset(rt.new_string('reports'))) {
			var_reports.array_unset(var_key)
			continue
		}
		mut iter_4 := var_report_group.array_get(rt.new_string('reports')).iterator()
		for {
			item_4 := iter_4.next() or { break }
			mut var_report := item_4.val
			if var_report.array_isset(rt.new_string('function')) {
				var_report.array_set('callback', var_report.array_get(rt.new_string('function')))
			}
		}
	}
	return var_reports.clone()
}

fn Class_WC_Admin_Reports.get_report(var_name rt.PhpVal) {
	mut var_name_mutated := var_name
	var_name_mutated = rt.call_function('sanitize_title', [
		rt.call_function('str_replace', [rt.new_string('_'), rt.new_string('-'),
			var_name_mutated.clone()]),
	])
	mut var_class :=
		rt.new_string('WC_Report_' +(rt.call_function('str_replace', [rt.new_string('-'), rt.new_string('_'), var_name_mutated.clone()])).str())
	rt.include_file((rt.call_function('apply_filters', [
		rt.new_string('wc_admin_reports_path'),
		rt.new_string('reports/class-wc-report-' + var_name_mutated.str() + '.php'),
		var_name_mutated.clone(),
		var_class.clone(),
	])).to_string(), '2')
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [
		var_class.clone()])))))
	{
		return
	}
	mut var_report := rt.create_object_dynamically(var_class, []rt.PhpVal{})
	rt.call_method(var_report, 'output_report', []rt.PhpVal{})
}

struct Class_WC_Admin_Report {
	rt.PhpObjectBase
}

struct Class_WC_Report_Sales_By_Date {
	rt.PhpObjectBase
}

fn create_wc_admin_reports(_args ...rt.PhpVal) &Class_WC_Admin_Reports {
	mut obj := &Class_WC_Admin_Reports{
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

fn create_wc_report_sales_by_date(_args ...rt.PhpVal) &Class_WC_Report_Sales_By_Date {
	mut obj := &Class_WC_Report_Sales_By_Date{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Admin_Reports) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'register_hook_handlers' {
			Class_WC_Admin_Reports.register_hook_handlers()
			return rt.new_null()
		}
		'register_orders_hook_handlers' {
			Class_WC_Admin_Reports.register_orders_hook_handlers()
			return rt.new_null()
		}
		'delete_legacy_reports_transients' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			Class_WC_Admin_Reports.delete_legacy_reports_transients(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'get_report_instance' {
			return Class_WC_Admin_Reports.get_report_instance()
		}
		'replace_dashboard_status_widget_reports' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WC_Admin_Reports.replace_dashboard_status_widget_reports(dispatch_arg_0)
		}
		'output' {
			Class_WC_Admin_Reports.output()
			return rt.new_null()
		}
		'get_reports' {
			return Class_WC_Admin_Reports.get_reports()
		}
		'get_report' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			Class_WC_Admin_Reports.get_report(dispatch_arg_0)
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_Admin_Reports) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Admin_Reports) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_WC_Report_Sales_By_Date) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Report_Sales_By_Date) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Report_Sales_By_Date) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn init_registry() {
	rt.register_class_factory('WC_Admin_Reports', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_wc_admin_reports()
		return rt.new_object('WC_Admin_Reports', []string{}, obj)
	})
	rt.register_class_factory('WC_Admin_Report', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_wc_admin_report()
		return rt.new_object('WC_Admin_Report', []string{}, obj)
	})
	rt.register_class_factory('WC_Report_Sales_By_Date', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_wc_report_sales_by_date()
		return rt.new_object('WC_Report_Sales_By_Date', []string{}, obj)
	})
}

fn init() {
	init_registry()
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
	if rt.is_true(rt.call_function('class_exists', [rt.new_string('WC_Admin_Reports'),
		rt.new_bool(false)]))
	{
		return rt.new_null()
	}
}
