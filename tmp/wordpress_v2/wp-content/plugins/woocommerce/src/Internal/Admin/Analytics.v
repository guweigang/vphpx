import rt

pub fn Class_Automattic_WooCommerce_Internal_Admin_Analytics.toggle_option_name() string {
	return 'woocommerce_analytics_enabled'
}

pub fn Class_Automattic_WooCommerce_Internal_Admin_Analytics.cache_tool_id() string {
	return 'clear_woocommerce_analytics_cache'
}

struct Class_Automattic_WooCommerce_Internal_Admin_Analytics {
	rt.PhpObjectBase
}

fn init_static_automattic_woocommerce_internal_admin_analytics() {
	rt.init_static_prop('Automattic_WooCommerce_Internal_Admin_Analytics', 'instance',
		rt.new_null())
	rt.init_static_prop('Automattic_WooCommerce_Internal_Admin_Analytics', 'is_updated',
		rt.new_bool(false))
}

fn Class_Automattic_WooCommerce_Internal_Admin_Analytics.get_instance() rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.get_static_prop('Automattic_WooCommerce_Internal_Admin_Analytics',
		'instance')))))
	{
		rt.set_static_prop('Automattic_WooCommerce_Internal_Admin_Analytics', 'instance', rt.new_object('Automattic_WooCommerce_Internal_Admin_self',
			[]string{}, create_automattic_woocommerce_internal_admin_self()))
	}
	return rt.get_static_prop('Automattic_WooCommerce_Internal_Admin_Analytics', 'instance')
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Analytics) construct() {
	rt.call_function('add_action', [
		rt.new_string('update_option_' +(Class_Automattic_WooCommerce_Internal_Admin_Automattic_WooCommerce_Internal_Admin_Analytics.toggle_option_name()).str()),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_Analytics',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'reload_page_on_toggle' },
		]),
		rt.new_int(10),
		rt.new_int(2),
	])
	rt.call_function('add_action', [rt.new_string('woocommerce_settings_saved'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_Analytics',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'maybe_reload_page' },
		])])
	mut iife_temp_0 := Class_Automattic_WooCommerce_Admin_Features_Features{}
	mut iife_result_0 := iife_temp_0.is_enabled(rt.new_string('analytics'))
	if rt.is_true(rt.new_bool(!(rt.is_true(iife_result_0)))) {
		return
	}
	rt.call_function('add_filter', [
		rt.new_string('woocommerce_component_settings_preload_endpoints'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_Analytics',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'add_preload_endpoints' },
		]),
	])
	rt.call_function('add_filter', [
		rt.new_string('woocommerce_admin_get_user_data_fields'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_Analytics',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'add_user_data_fields' },
		]),
	])
	rt.call_function('add_action', [rt.new_string('admin_menu'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_Analytics',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'register_pages' },
		])])
	rt.call_function('add_filter', [rt.new_string('woocommerce_debug_tools'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_Analytics',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'register_cache_clear_tool' },
		])])
	rt.call_function('add_filter', [rt.new_string('woocommerce_debug_tools'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_Analytics',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'register_regenerate_order_fulfillment_status_tool' },
		]),
		rt.new_int(12)])
}

fn Class_Automattic_WooCommerce_Internal_Admin_Analytics.add_feature_toggle(var_features rt.PhpVal) rt.PhpVal {
	return var_features.clone()
}

fn Class_Automattic_WooCommerce_Internal_Admin_Analytics.reload_page_on_toggle(var_old_value rt.PhpVal, var_value rt.PhpVal) {
	if rt.is_true(rt.identical(var_old_value, var_value)) {
		return
	}
	rt.set_static_prop('Automattic_WooCommerce_Internal_Admin_Analytics', 'is_updated',
		rt.new_bool(true))
}

fn Class_Automattic_WooCommerce_Internal_Admin_Analytics.maybe_reload_page() {
	if !(rt.get_superglobal('_SERVER').array_isset(rt.new_string('REQUEST_URI')))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.get_static_prop('Automattic_WooCommerce_Internal_Admin_Analytics', 'is_updated'))))) {
		return
	}
	rt.call_function('wp_safe_redirect', [
		rt.call_function('wp_unslash',
			[rt.get_superglobal('_SERVER').array_get(rt.new_string('REQUEST_URI'))]),
	])
	exit(0)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Analytics) add_preload_endpoints(var_endpoints rt.PhpVal) rt.PhpVal {
	mut var_endpoints_mutated := var_endpoints
	mut var_screen_id := if
		rt.is_true(rt.call_function('function_exists', [rt.new_string('get_current_screen')]))
		&& rt.is_true(rt.call_function('get_current_screen', []rt.PhpVal{})) {
		rt.get_property(rt.call_function('get_current_screen', []rt.PhpVal{}), 'id')
	} else {
		rt.new_string('')
	}
	if rt.is_true(rt.identical(rt.new_string('woocommerce_page_wc-admin'), var_screen_id)) {
		var_endpoints_mutated.array_set('performanceIndicators',
			'/wc-analytics/reports/performance-indicators/allowed')
		var_endpoints_mutated.array_set('leaderboards', '/wc-analytics/leaderboards/allowed')
	}
	return var_endpoints_mutated.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Analytics) add_user_data_fields(var_user_data_fields rt.PhpVal) rt.PhpVal {
	return rt.call_function('array_merge', [var_user_data_fields.clone(),
		rt.create_array([rt.ArrayItem{ key: none, val: 'categories_report_columns' },
			rt.ArrayItem{ key: none, val: 'coupons_report_columns' },
			rt.ArrayItem{ key: none, val: 'customers_report_columns' },
			rt.ArrayItem{ key: none, val: 'orders_report_columns' },
			rt.ArrayItem{ key: none, val: 'products_report_columns' },
			rt.ArrayItem{ key: none, val: 'revenue_report_columns' },
			rt.ArrayItem{ key: none, val: 'taxes_report_columns' },
			rt.ArrayItem{ key: none, val: 'variations_report_columns' },
			rt.ArrayItem{ key: none, val: 'dashboard_sections' },
			rt.ArrayItem{ key: none, val: 'dashboard_chart_type' },
			rt.ArrayItem{ key: none, val: 'dashboard_chart_interval' },
			rt.ArrayItem{ key: none, val: 'dashboard_leaderboard_rows' },
			rt.ArrayItem{ key: none, val: 'order_attribution_install_banner_dismissed' },
			rt.ArrayItem{ key: none, val: 'scheduled_updates_promotion_notice_dismissed' }])])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Analytics) register_cache_clear_tool(var_debug_tools rt.PhpVal) rt.PhpVal {
	mut var_debug_tools_mutated := var_debug_tools
	mut var_settings_url := rt.call_function('add_query_arg', [
		rt.create_array([rt.ArrayItem{ key: 'page', val: 'wc-admin' },
			rt.ArrayItem{ key: 'path', val: '/analytics/settings' }]),
		rt.call_function('get_admin_url', [rt.new_null(), rt.new_string('admin.php')]),
	])
	var_debug_tools_mutated.array_set(Class_Automattic_WooCommerce_Internal_Admin_Automattic_WooCommerce_Internal_Admin_Analytics.cache_tool_id(), rt.create_array([
		rt.ArrayItem{ key: 'name', val: rt.call_function('__', [
			rt.new_string('Clear analytics cache'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'button', val: rt.call_function('__', [
			rt.new_string('Clear'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'desc', val: rt.call_function('sprintf', [
			rt.call_function('__', [
				rt.new_string('This tool will reset the cached values used in WooCommerce Analytics. If numbers still look off, try %1$sReimporting Historical Data%2$s.'),
				rt.new_string('woocommerce'),
			]),
			rt.new_string('<a href="' +
				(rt.call_function('esc_url', [var_settings_url.clone()])).str() + '">'),
			rt.new_string('</a>'),
		]) },
		rt.ArrayItem{ key: 'callback', val: rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_Analytics',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'run_clear_cache_tool' },
		]) },
	]))
	return var_debug_tools_mutated.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Analytics) register_regenerate_order_fulfillment_status_tool(var_debug_tools rt.PhpVal) rt.PhpVal {
	mut var_debug_tools_mutated := var_debug_tools
	mut var_container := rt.call_function('wc_get_container', []rt.PhpVal{})
	mut var_features_controller := rt.call_method(var_container, 'get', [
		Class_Automattic_WooCommerce_Internal_Features_FeaturesController.class(),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_features_controller,
		'feature_is_enabled', [rt.new_string('fulfillments')])))))
	{
		return var_debug_tools_mutated.clone()
	}
	if rt.is_true(rt.identical(rt.new_bool(true), (rt.call_function('get_option', [
		rt.new_string('woocommerce_analytics_order_fulfillment_status_regenerated'),
	])).to_bool()))
	{
		return var_debug_tools_mutated.clone()
	}
	var_debug_tools_mutated.array_set('regenerate_order_fulfillment_status', rt.create_array([
		rt.ArrayItem{ key: 'name', val: rt.call_function('__', [
			rt.new_string('Regenerate order fulfillment status for Analytics'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'button', val: rt.call_function('__', [
			rt.new_string('Regenerate'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [
			rt.new_string('This tool will regenerate the order fulfillment status for all orders and update the Analytics data using a direct SQL query.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'callback', val: rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_Analytics',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'run_regenerate_order_fulfillment_status_tool' },
		]) },
	]))
	return var_debug_tools_mutated.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Analytics) run_regenerate_order_fulfillment_status_tool() rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut iife_temp_1 := Class_Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_DataStore{}
	mut iife_result_1 := iife_temp_1.has_fulfillment_status_column()
	if rt.is_true(rt.new_bool(!(rt.is_true(iife_result_1)))) {
		mut iife_temp_2 := Class_Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_DataStore{}
		mut iife_result_2 := iife_temp_2.add_fulfillment_status_column()
		mut var_create_column_result := iife_result_2
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(true),
			var_create_column_result))))
		{
			return rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('Failed to create fulfillment status column: %s'),
					rt.new_string('woocommerce'),
				]),
				var_create_column_result.clone(),
			])
		}
	}
	mut var_order_stats_table := rt.new_string((rt.get_property(var_wpdb, 'prefix')).str() +
		'wc_order_stats')
	mut iife_temp_3 := Class_Automattic_WooCommerce_Utilities_OrderUtil{}
	mut iife_result_3 := iife_temp_3.custom_orders_table_usage_is_enabled()
	if rt.is_true(iife_result_3) {
		mut iife_temp_4 :=
			Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore{}
		mut iife_result_4 := iife_temp_4.get_meta_table_name()
		mut var_order_meta_table := iife_result_4
		mut var_order_meta_column := rt.new_string('order_id')
	} else {
		var_order_meta_table = rt.get_property(var_wpdb, 'postmeta')
		var_order_meta_column = rt.new_string('post_id')
	}
	mut var_updated := rt.call_method(var_wpdb, 'query', [
		rt.call_method(var_wpdb, 'prepare', [
			rt.new_string('UPDATE ${var_order_stats_table.to_string()} os INNER JOIN ${var_order_meta_table.to_string()} om ON os.order_id = om.${var_order_meta_column.to_string()}\n\t\t\t\tSET os.fulfillment_status = CASE\n\t\t\t\t\tWHEN om.meta_value = %s THEN NULL\n\t\t\t\t\tELSE om.meta_value\n\t\t\t\tEND\n\t\t\t\tWHERE om.meta_key = %s'),
			rt.new_string('no_fulfillments'),
			rt.new_string('_fulfillment_status'),
		]),
	])
	if rt.is_true(rt.identical(rt.new_bool(false), var_updated)) {
		return rt.call_function('__', [
			rt.new_string('Failed to update order fulfillment status. Please check the database logs for errors.'),
			rt.new_string('woocommerce'),
		])
	}
	rt.call_function('update_option', [
		rt.new_string('woocommerce_analytics_order_fulfillment_status_regenerated'),
		rt.new_bool(true),
		rt.new_bool(false),
	])
	return rt.call_function('sprintf', [
		rt.call_function('__', [
			rt.new_string('Successfully updated fulfillment status for %d orders.'),
			rt.new_string('woocommerce'),
		]),
		var_updated.clone(),
	])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Analytics) register_pages() {
	mut var_report_pages := Class_Automattic_WooCommerce_Internal_Admin_Analytics.get_report_pages()
	mut iter_1 := var_report_pages.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_report_page := item_1.val
		if !(var_report_page.clone().is_null()) {
			rt.call_function('wc_admin_register_page', [var_report_page.clone()])
		}
	}
}

fn Class_Automattic_WooCommerce_Internal_Admin_Analytics.get_report_pages() rt.PhpVal {
	mut var_overview_page := rt.create_array([
		rt.ArrayItem{ key: 'id', val: 'woocommerce-analytics' },
		rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
			rt.new_string('Analytics'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'path', val: '/analytics/overview' },
		rt.ArrayItem{ key: 'icon', val: 'dashicons-chart-bar' },
		rt.ArrayItem{ key: 'position', val: 57 },
	])
	mut var_report_pages := rt.create_array([
		rt.ArrayItem{ key: none, val: var_overview_page },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'id', val: 'woocommerce-analytics-overview' },
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Overview'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'parent', val: 'woocommerce-analytics' },
			rt.ArrayItem{ key: 'path', val: '/analytics/overview' },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'id', val: 'woocommerce-analytics-products' },
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Products'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'parent', val: 'woocommerce-analytics' },
			rt.ArrayItem{ key: 'path', val: '/analytics/products' },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'id', val: 'woocommerce-analytics-revenue' },
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Revenue'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'parent', val: 'woocommerce-analytics' },
			rt.ArrayItem{ key: 'path', val: '/analytics/revenue' },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'id', val: 'woocommerce-analytics-orders' },
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Orders'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'parent', val: 'woocommerce-analytics' },
			rt.ArrayItem{ key: 'path', val: '/analytics/orders' },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'id', val: 'woocommerce-analytics-variations' },
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Variations'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'parent', val: 'woocommerce-analytics' },
			rt.ArrayItem{ key: 'path', val: '/analytics/variations' },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'id', val: 'woocommerce-analytics-categories' },
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Categories'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'parent', val: 'woocommerce-analytics' },
			rt.ArrayItem{ key: 'path', val: '/analytics/categories' },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'id', val: 'woocommerce-analytics-coupons' },
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Coupons'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'parent', val: 'woocommerce-analytics' },
			rt.ArrayItem{ key: 'path', val: '/analytics/coupons' },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'id', val: 'woocommerce-analytics-taxes' },
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Taxes'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'parent', val: 'woocommerce-analytics' },
			rt.ArrayItem{ key: 'path', val: '/analytics/taxes' },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'id', val: 'woocommerce-analytics-downloads' },
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Downloads'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'parent', val: 'woocommerce-analytics' },
			rt.ArrayItem{ key: 'path', val: '/analytics/downloads' },
		]) },
		rt.ArrayItem{
			key: none
			val: if rt.is_true(rt.identical(rt.new_string('yes'), rt.call_function('get_option', [
				rt.new_string('woocommerce_manage_stock'),
			])))
			{ rt.create_array([
					rt.ArrayItem{ key: 'id', val: 'woocommerce-analytics-stock' },
					rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
						rt.new_string('Stock'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'parent', val: 'woocommerce-analytics' },
					rt.ArrayItem{ key: 'path', val: '/analytics/stock' },
				]) } else { rt.new_null() }
		},
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'id', val: 'woocommerce-analytics-customers' },
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Customers'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'parent', val: 'woocommerce' },
			rt.ArrayItem{ key: 'path', val: '/customers' },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'id', val: 'woocommerce-analytics-settings' },
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Settings'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'parent', val: 'woocommerce-analytics' },
			rt.ArrayItem{ key: 'path', val: '/analytics/settings' },
		]) },
	])
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_analytics_report_menu_items'),
		var_report_pages.clone(),
	])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Analytics) run_clear_cache_tool() rt.PhpVal {
	mut iife_temp_5 := Class_Automattic_WooCommerce_Admin_API_Reports_Cache{}
	mut iife_result_5 := iife_temp_5.invalidate()
	return rt.call_function('__', [rt.new_string('Analytics cache cleared.'),
		rt.new_string('woocommerce')])
}

struct Class_Automattic_WooCommerce_Internal_Admin_self {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_Features_Features {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_DataStore {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Utilities_OrderUtil {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_API_Reports_Cache {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_admin_analytics() &Class_Automattic_WooCommerce_Internal_Admin_Analytics {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Analytics{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	obj.construct()
	return obj
}

fn create_automattic_woocommerce_internal_admin_self(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_self {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_self{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_features_features(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Features_Features {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_Features{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_reports_orders_stats_datastore(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_DataStore {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_DataStore{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_utilities_orderutil(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Utilities_OrderUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_OrderUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_datastores_orders_orderstabledatastore(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore {
	mut obj := &Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_reports_cache(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_API_Reports_Cache {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_Cache{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Analytics) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_instance' {
			return Class_Automattic_WooCommerce_Internal_Admin_Analytics.get_instance()
		}
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'add_feature_toggle' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Internal_Admin_Analytics.add_feature_toggle(dispatch_arg_0)
		}
		'reload_page_on_toggle' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			Class_Automattic_WooCommerce_Internal_Admin_Analytics.reload_page_on_toggle(dispatch_arg_0,
				dispatch_arg_1)
			return rt.new_null()
		}
		'maybe_reload_page' {
			Class_Automattic_WooCommerce_Internal_Admin_Analytics.maybe_reload_page()
			return rt.new_null()
		}
		'add_preload_endpoints' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.add_preload_endpoints(dispatch_arg_0)
		}
		'add_user_data_fields' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.add_user_data_fields(dispatch_arg_0)
		}
		'register_cache_clear_tool' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.register_cache_clear_tool(dispatch_arg_0)
		}
		'register_regenerate_order_fulfillment_status_tool' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.register_regenerate_order_fulfillment_status_tool(dispatch_arg_0)
		}
		'run_regenerate_order_fulfillment_status_tool' {
			return this.run_regenerate_order_fulfillment_status_tool()
		}
		'register_pages' {
			this.register_pages()
			return rt.new_null()
		}
		'get_report_pages' {
			return Class_Automattic_WooCommerce_Internal_Admin_Analytics.get_report_pages()
		}
		'run_clear_cache_tool' {
			return this.run_clear_cache_tool()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Analytics) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Analytics) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_self) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_self) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_self) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Features) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_Features) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Features) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_DataStore) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_DataStore) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_DataStore) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_OrderUtil) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Utilities_OrderUtil) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_OrderUtil) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Cache) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_API_Reports_Cache) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Cache) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
