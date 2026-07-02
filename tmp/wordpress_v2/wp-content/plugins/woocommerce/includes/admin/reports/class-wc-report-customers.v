import rt

struct Class_WC_Report_Customers {
	rt.PhpObjectBase
pub mut:
	chart_colours rt.PhpVal = rt.new_array()
	customers     rt.PhpVal = rt.new_array()
}

fn (mut this Class_WC_Report_Customers) get_chart_legend() rt.PhpVal {
	mut var_legend := []rt.PhpVal{}
	var_legend << rt.create_array([
		rt.ArrayItem{ key: 'title', val: rt.call_function('sprintf', [
			rt.call_function('__', [rt.new_string('%s signups in this period'),
				rt.new_string('woocommerce')]),
			rt.new_string('<strong>' + this.customers.array_count().str() + '</strong>'),
		]) },
		rt.ArrayItem{ key: 'color', val: this.chart_colours.array_get(rt.new_string('signups')) },
		rt.ArrayItem{ key: 'highlight_series', val: 2 },
	])
	return var_legend.clone()
}

fn (mut this Class_WC_Report_Customers) get_chart_widgets() rt.PhpVal {
	mut var_widgets := []rt.PhpVal{}
	var_widgets << rt.create_array([rt.ArrayItem{ key: 'title', val: '' },
		rt.ArrayItem{ key: 'callback', val: rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Report_Customers', [
				'WC_Admin_Report',
			], &this) },
			rt.ArrayItem{ key: none, val: 'customers_vs_guests' },
		]) }])
	return var_widgets.clone()
}

fn (mut this Class_WC_Report_Customers) customers_vs_guests() {
	mut var_customer_order_totals := this.get_order_report_data(rt.create_array([
		rt.ArrayItem{ key: 'data', val: rt.create_array([
			rt.ArrayItem{ key: 'ID', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'post_data' },
				rt.ArrayItem{ key: 'function', val: 'COUNT' },
				rt.ArrayItem{ key: 'name', val: 'total_orders' },
			]) },
		]) },
		rt.ArrayItem{ key: 'where_meta', val: rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'meta_key', val: '_customer_user' },
				rt.ArrayItem{ key: 'meta_value', val: '0' },
				rt.ArrayItem{ key: 'operator', val: '>' },
			]) },
		]) },
		rt.ArrayItem{ key: 'filter_range', val: true },
	]))
	mut var_guest_order_totals := this.get_order_report_data(rt.create_array([
		rt.ArrayItem{ key: 'data', val: rt.create_array([
			rt.ArrayItem{ key: 'ID', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'post_data' },
				rt.ArrayItem{ key: 'function', val: 'COUNT' },
				rt.ArrayItem{ key: 'name', val: 'total_orders' },
			]) },
		]) },
		rt.ArrayItem{ key: 'where_meta', val: rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'meta_key', val: '_customer_user' },
				rt.ArrayItem{ key: 'meta_value', val: '0' },
				rt.ArrayItem{ key: 'operator', val: '=' },
			]) },
		]) },
		rt.ArrayItem{ key: 'filter_range', val: true },
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr',
		[this.chart_colours.array_get(rt.new_string('customers'))]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Customer sales'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr',
		[this.chart_colours.array_get(rt.new_string('guests'))]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Guest sales'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Customer orders'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [
		rt.get_property(var_customer_order_totals, 'total_orders'),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html',
		[this.chart_colours.array_get(rt.new_string('customers'))]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Guest orders'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [
		rt.get_property(var_guest_order_totals, 'total_orders'),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html',
		[this.chart_colours.array_get(rt.new_string('guests'))]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [
		rt.new_string(' ' +
			(rt.call_function('__', [rt.new_string('orders'), rt.new_string('woocommerce')])).str()),
	]))
	// unsupported statement: Stmt_InlineHTML
}

fn (mut this Class_WC_Report_Customers) output_report() {
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
	this.chart_colours = rt.create_array([rt.ArrayItem{ key: 'signups', val: '#3498db' },
		rt.ArrayItem{ key: 'customers', val: '#1abc9c' }, rt.ArrayItem{
			key: 'guests'
			val: '#8fdece'
		}])
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
	mut var_privileged_users := create_wp_user_query(rt.create_array([
		rt.ArrayItem{ key: 'fields', val: 'ID' },
		rt.ArrayItem{ key: 'role__in', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'administrator' },
			rt.ArrayItem{ key: none, val: 'shop_manager' },
		]) },
	]))
	mut var_users_query := create_wp_user_query(rt.call_function('apply_filters', [
		rt.new_string('woocommerce_admin_report_customers_user_query_args'),
		rt.create_array([
			rt.ArrayItem{ key: 'fields', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'user_registered' },
			]) },
			rt.ArrayItem{ key: 'exclude', val: var_privileged_users.get_results() },
		]),
	]))
	this.customers = var_users_query.get_results()
	mut iter_1 := this.customers.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_customer := item_1.val
		mut var_key := item_1.key
		if rt.is_true(rt.less(rt.call_function('strtotime', [rt.get_property(var_customer, 'user_registered')]), rt.get_property(rt.new_object('WC_Report_Customers', ['WC_Admin_Report'], &this), 'start_date')))
			|| rt.is_true(rt.greater(rt.call_function('strtotime', [rt.get_property(var_customer, 'user_registered')]), rt.get_property(rt.new_object('WC_Report_Customers', ['WC_Admin_Report'], &this), 'end_date'))) {
			this.customers.array_unset(var_key)
		}
	}
	rt.include_file(
		(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'plugin_path', []rt.PhpVal{})).str() +
		'/includes/admin/views/html-report-by-date.php', '1')
}

fn (mut this Class_WC_Report_Customers) get_export_button() {
	mut var_current_range := if !(!rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('range')))) { rt.call_function('sanitize_text_field', [
			rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get(rt.new_string('range'))]),
		]) } else { rt.new_string('7day') }
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_current_range.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [
		rt.call_function('date_i18n', [rt.new_string('Y-m-d'),
			rt.call_function('current_time', [rt.new_string('timestamp')])]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('Date'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [
		rt.get_property(rt.new_object('WC_Report_Customers', ['WC_Admin_Report'], &this),
			'chart_groupby'),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Export CSV'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
}

fn (mut this Class_WC_Report_Customers) get_main_chart() {
	mut var_wp_locale := rt.new_null()
	mut var_customer_orders := this.get_order_report_data(rt.create_array([
		rt.ArrayItem{ key: 'data', val: rt.create_array([
			rt.ArrayItem{ key: 'ID', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'post_data' },
				rt.ArrayItem{ key: 'function', val: 'COUNT' },
				rt.ArrayItem{ key: 'name', val: 'total_orders' },
			]) },
			rt.ArrayItem{ key: 'post_date', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'post_data' },
				rt.ArrayItem{ key: 'function', val: '' },
				rt.ArrayItem{ key: 'name', val: 'post_date' },
			]) },
		]) },
		rt.ArrayItem{ key: 'where_meta', val: rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'meta_key', val: '_customer_user' },
				rt.ArrayItem{ key: 'meta_value', val: '0' },
				rt.ArrayItem{ key: 'operator', val: '>' },
			]) },
		]) },
		rt.ArrayItem{ key: 'group_by', val: rt.get_property(rt.new_object('WC_Report_Customers', [
			'WC_Admin_Report',
		], &this), 'group_by_query') },
		rt.ArrayItem{ key: 'order_by', val: 'post_date ASC' },
		rt.ArrayItem{ key: 'query_type', val: 'get_results' },
		rt.ArrayItem{ key: 'filter_range', val: true },
	]))
	mut var_guest_orders := this.get_order_report_data(rt.create_array([
		rt.ArrayItem{ key: 'data', val: rt.create_array([
			rt.ArrayItem{ key: 'ID', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'post_data' },
				rt.ArrayItem{ key: 'function', val: 'COUNT' },
				rt.ArrayItem{ key: 'name', val: 'total_orders' },
			]) },
			rt.ArrayItem{ key: 'post_date', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'post_data' },
				rt.ArrayItem{ key: 'function', val: '' },
				rt.ArrayItem{ key: 'name', val: 'post_date' },
			]) },
		]) },
		rt.ArrayItem{ key: 'where_meta', val: rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'meta_key', val: '_customer_user' },
				rt.ArrayItem{ key: 'meta_value', val: '0' },
				rt.ArrayItem{ key: 'operator', val: '=' },
			]) },
		]) },
		rt.ArrayItem{ key: 'group_by', val: rt.get_property(rt.new_object('WC_Report_Customers', [
			'WC_Admin_Report',
		], &this), 'group_by_query') },
		rt.ArrayItem{ key: 'order_by', val: 'post_date ASC' },
		rt.ArrayItem{ key: 'query_type', val: 'get_results' },
		rt.ArrayItem{ key: 'filter_range', val: true },
	]))
	mut var_signups := this.prepare_chart_data(this.customers, rt.new_string('user_registered'),
		rt.new_string(''), rt.get_property(rt.new_object('WC_Report_Customers', [
		'WC_Admin_Report',
	], &this), 'chart_interval'), rt.get_property(rt.new_object('WC_Report_Customers', [
		'WC_Admin_Report',
	], &this), 'start_date'), rt.get_property(rt.new_object('WC_Report_Customers', [
		'WC_Admin_Report',
	], &this), 'chart_groupby'))
	var_customer_orders = this.prepare_chart_data(var_customer_orders.clone(),
		rt.new_string('post_date'), rt.new_string('total_orders'), rt.get_property(rt.new_object('WC_Report_Customers', [
		'WC_Admin_Report',
	], &this), 'chart_interval'), rt.get_property(rt.new_object('WC_Report_Customers', [
		'WC_Admin_Report',
	], &this), 'start_date'), rt.get_property(rt.new_object('WC_Report_Customers', [
		'WC_Admin_Report',
	], &this), 'chart_groupby'))
	var_guest_orders = this.prepare_chart_data(var_guest_orders.clone(),
		rt.new_string('post_date'), rt.new_string('total_orders'), rt.get_property(rt.new_object('WC_Report_Customers', [
		'WC_Admin_Report',
	], &this), 'chart_interval'), rt.get_property(rt.new_object('WC_Report_Customers', [
		'WC_Admin_Report',
	], &this), 'start_date'), rt.get_property(rt.new_object('WC_Report_Customers', [
		'WC_Admin_Report',
	], &this), 'chart_groupby'))
	mut var_chart_data := rt.call_function('wp_json_encode', [
		rt.create_array([
			rt.ArrayItem{ key: 'signups', val: rt.call_function('array_values', [
				var_signups.clone(),
			]) },
			rt.ArrayItem{ key: 'customer_orders', val: rt.call_function('array_values', [
				var_customer_orders.clone(),
			]) },
			rt.ArrayItem{ key: 'guest_orders', val: rt.call_function('array_values', [
				var_guest_orders.clone(),
			]) },
		]),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('rawurlencode', [var_chart_data.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_js', [
		rt.call_function('__', [rt.new_string('Customer orders'),
			rt.new_string('woocommerce')]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html',
		[this.chart_colours.array_get(rt.new_string('customers'))]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html',
		[this.chart_colours.array_get(rt.new_string('customers'))]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [
		rt.get_property(rt.new_object('WC_Report_Customers', ['WC_Admin_Report'], &this),
			'barwidth'),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [
		rt.new_string(' ' +(rt.call_function('__', [rt.new_string('customer orders'), rt.new_string('woocommerce')])).str()),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_js', [
		rt.call_function('__', [rt.new_string('Guest orders'),
			rt.new_string('woocommerce')]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html',
		[this.chart_colours.array_get(rt.new_string('guests'))]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html',
		[this.chart_colours.array_get(rt.new_string('guests'))]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [
		rt.get_property(rt.new_object('WC_Report_Customers', ['WC_Admin_Report'], &this),
			'barwidth'),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [
		rt.new_string(' ' +(rt.call_function('__', [rt.new_string('guest orders'), rt.new_string('woocommerce')])).str()),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_js', [
		rt.call_function('__', [rt.new_string('Signups'), rt.new_string('woocommerce')]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html',
		[this.chart_colours.array_get(rt.new_string('signups'))]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [
		rt.new_string(' ' +(rt.call_function('__', [rt.new_string('new users'), rt.new_string('woocommerce')])).str()),
	]))
	// unsupported statement: Stmt_InlineHTML
	print(if rt.is_true(rt.identical(rt.new_string('day'), rt.get_property(rt.new_object('WC_Report_Customers', [
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
	rt.echo_val(rt.call_function('esc_html', [
		rt.get_property(rt.new_object('WC_Report_Customers', ['WC_Admin_Report'], &this),
			'chart_groupby'),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [
		rt.get_property(rt.new_object('WC_Report_Customers', ['WC_Admin_Report'], &this),
			'chart_groupby'),
	]))
	// unsupported statement: Stmt_InlineHTML
}

struct Class_WC_Admin_Report {
	rt.PhpObjectBase
}

struct Class_WP_User_Query {
	rt.PhpObjectBase
}

fn create_wc_report_customers(_args ...rt.PhpVal) &Class_WC_Report_Customers {
	mut obj := &Class_WC_Report_Customers{
		PhpObjectBase: rt.PhpObjectBase{}
		chart_colours: rt.new_array()
		customers:     rt.new_array()
	}
	return obj
}

fn create_wc_admin_report(_args ...rt.PhpVal) &Class_WC_Admin_Report {
	mut obj := &Class_WC_Admin_Report{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_user_query(_args ...rt.PhpVal) &Class_WP_User_Query {
	mut obj := &Class_WP_User_Query{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Report_Customers) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_chart_legend' {
			return this.get_chart_legend()
		}
		'get_chart_widgets' {
			return this.get_chart_widgets()
		}
		'customers_vs_guests' {
			this.customers_vs_guests()
			return rt.new_null()
		}
		'output_report' {
			this.output_report()
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

fn (this &Class_WC_Report_Customers) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'chart_colours' { return this.chart_colours }
		'customers' { return this.customers }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_Report_Customers) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'chart_colours' {
			this.chart_colours = val
			return true
		}
		'customers' {
			this.customers = val
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

fn (mut this Class_WP_User_Query) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_User_Query) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_User_Query) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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
