import rt

struct Class_Automattic_WooCommerce_Admin_API_Reports_PerformanceIndicators_Controller {
	rt.PhpObjectBase
pub mut:
		rest_base rt.PhpVal = rt.new_string('reports/performance-indicators')
		endpoints rt.PhpVal = rt.new_array()
		active_jetpack_modules rt.PhpVal = rt.new_null()
		allowed_stats rt.PhpVal = rt.new_array()
		labels rt.PhpVal = rt.new_array()
		urls rt.PhpVal = rt.new_array()
		stats_data rt.PhpVal = rt.new_array()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_PerformanceIndicators_Controller) construct()  {
	rt.call_function('add_filter', [rt.new_string('woocommerce_rest_performance_indicators_data_value'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Reports_PerformanceIndicators_Controller', ['Automattic_WooCommerce_Admin_API_Reports_GenericController'], &this) }, rt.ArrayItem{ key: none, val: 'format_data_value' }]), rt.new_int(10), rt.new_int(5)])
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_PerformanceIndicators_Controller) register_routes()  {
	this.Class_Automattic_WooCommerce_Admin_API_Reports_GenericController.register_routes()
	rt.call_function('register_rest_route', [rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_PerformanceIndicators_Controller', ['Automattic_WooCommerce_Admin_API_Reports_GenericController'], &this), 'namespace'), '/' + (this.rest_base).str() + '/allowed', rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_Automattic_WooCommerce_Admin_API_Reports_PerformanceIndicators_WP_REST_Server.readable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Reports_PerformanceIndicators_Controller', ['Automattic_WooCommerce_Admin_API_Reports_GenericController'], &this) }, rt.ArrayItem{ key: none, val: 'get_allowed_items' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Reports_PerformanceIndicators_Controller', ['Automattic_WooCommerce_Admin_API_Reports_GenericController'], &this) }, rt.ArrayItem{ key: none, val: 'get_items_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: this.get_collection_params() }]) }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Reports_PerformanceIndicators_Controller', ['Automattic_WooCommerce_Admin_API_Reports_GenericController'], &this) }, rt.ArrayItem{ key: none, val: 'get_public_allowed_item_schema' }]) }])])
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_PerformanceIndicators_Controller) prepare_reports_query(var_request rt.PhpVal) rt.PhpVal {
	mut var_request_mutated := var_request
	mut var_args := rt.new_array()
	var_args.array_set('before', var_request_mutated.array_get('before'))
	var_args.array_set('after', var_request_mutated.array_get('after'))
	var_args.array_set('stats', var_request_mutated.array_get('stats'))
	return var_args.dup()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_PerformanceIndicators_Controller) get_analytics_report_data() rt.PhpVal {
	mut var_request := create_wp_rest_request(rt.new_string('GET'), rt.new_string('/wc-analytics/reports'))
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_response := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	if rt.is_true(rt.call_function('is_callable', [rt.create_array([rt.ArrayItem{ key: none, val: var_response }, rt.ArrayItem{ key: none, val: 'remove_link' }])])) {
		rt.call_method(var_response, 'remove_link', [rt.new_string('self')])
	}
	return var_response.dup()
	}
	mut var_remove_self_link_from_prepared_internal_response := rt.new_closure(closure_1_fn)
	rt.call_function('add_filter', [rt.new_string('woocommerce_rest_prepare_report'), var_remove_self_link_from_prepared_internal_response.dup()])
	mut var_response := rt.call_function('rest_do_request', [var_request])
	rt.call_function('remove_filter', [rt.new_string('woocommerce_rest_prepare_report'), var_remove_self_link_from_prepared_internal_response.dup()])
	if rt.is_true(rt.call_function('is_wp_error', [var_response.dup()])) {
		return var_response.dup()
	}
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return create_automattic_woocommerce_admin_api_reports_performanceindicators_wp_error(rt.new_string('woocommerce_analytics_performance_indicators_result_failed'), rt.call_function('__', [rt.new_string('Sorry, fetching performance indicators failed.'), rt.new_string('woocommerce')]))
	}
	mut var_endpoints := rt.call_method(var_response, 'get_data', []rt.PhpVal{})
	{
		mut iter_1 := var_endpoints.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_endpoint := item_1.val
			if rt.is_true(rt.identical(rt.new_string('/stats'), rt.call_function('substr', [var_endpoint.array_get('slug'), // unsupported expression: Expr_UnaryMinus]))) {
				var_request = create_wp_rest_request(rt.new_string('OPTIONS'), var_endpoint.array_get('path'))
				var_response = rt.call_function('rest_do_request', [var_request])
				if rt.is_true(rt.call_function('is_wp_error', [var_response.dup()])) {
					return var_response.dup()
				}
				mut var_data := rt.call_method(var_response, 'get_data', []rt.PhpVal{})
				mut var_prefix := rt.call_function('substr', [var_endpoint.array_get('slug'), rt.new_int(0), // unsupported expression: Expr_UnaryMinus])
				if !rt.is_true(var_data.array_get('schema').array_get('properties').array_get('totals').array_get('properties')) {
					continue
				}
				{
					mut iter_2 := var_data.array_get('schema').array_get('properties').array_get('totals').array_get('properties').iterator()
					for {
						item_2 := iter_2.next() or { break }
						mut var_schema_info := item_2.val
						mut var_property_key := item_2.key
						if rt.is_true(rt.new_bool(!rt.is_true(var_schema_info.array_get('indicator')) || rt.is_true(rt.new_bool(!(rt.is_true(var_schema_info.array_get('indicator'))))))) {
							continue
						}
						mut var_stat := rt.new_string((var_prefix).str() + '/' + (var_property_key).str())
						this.allowed_stats.array_push(var_stat.dup())
						mut var_stat_label := if !rt.is_true(var_schema_info.array_get('title')) { var_schema_info.array_get('description') } else { var_schema_info.array_get('title') }
						this.labels.array_set(var_stat, var_stat_label.dup().to_string().trim_space())
						rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_PerformanceIndicators_Controller', ['Automattic_WooCommerce_Admin_API_Reports_GenericController'], &this), 'formats').array_set(var_stat, if var_schema_info.array_isset(rt.new_string('format')) { var_schema_info.array_get('format') } else { rt.new_string('number') })
					}
				}
				this.endpoints.array_set(var_prefix, var_endpoint.array_get('path'))
				this.urls.array_set(var_prefix, var_endpoint.array_get('_links').array_get('report').array_get(0).array_get('href'))
			}
		}
	}
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_PerformanceIndicators_Controller) get_active_jetpack_modules() rt.PhpVal {
	if rt.is_true(rt.new_bool(this.active_jetpack_modules.is_null())) {
		if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('class_exists', [rt.new_string('\\Jetpack')])) && rt.is_true(rt.call_function('method_exists', [rt.new_string('\\Jetpack'), rt.new_string('get_active_modules')])))) {
			mut var_active_modules := fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_API_Reports_PerformanceIndicators_Jetpack{}; return temp.get_active_modules() }()
			this.active_jetpack_modules = if rt.is_true(rt.new_bool(var_active_modules.dup().is_array())) { var_active_modules } else { rt.new_array() }
		} else {
			this.active_jetpack_modules = rt.new_array()
		}
	}
	return this.active_jetpack_modules
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_PerformanceIndicators_Controller) set_active_jetpack_modules(var_modules rt.PhpVal)  {
	this.active_jetpack_modules = var_modules.dup()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_PerformanceIndicators_Controller) get_jetpack_modules_data()  {
	mut var_active_modules := this.get_active_jetpack_modules()
	if !rt.is_true(var_active_modules) {
		return rt.new_null()
	}
	mut var_items := rt.call_function('apply_filters', [rt.new_string('woocommerce_rest_performance_indicators_jetpack_items'), rt.create_array([rt.ArrayItem{ key: 'stats/visitors', val: rt.create_array([rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('Visitors'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'permission', val: 'view_stats' }, rt.ArrayItem{ key: 'format', val: 'number' }, rt.ArrayItem{ key: 'module', val: 'stats' }]) }, rt.ArrayItem{ key: 'stats/views', val: rt.create_array([rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('Views'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'permission', val: 'view_stats' }, rt.ArrayItem{ key: 'format', val: 'number' }, rt.ArrayItem{ key: 'module', val: 'stats' }]) }])])
	{
		mut iter_1 := var_items.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_item := item_1.val
			mut var_item_key := item_1.key
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_item.array_get('module'), var_active_modules.dup(), rt.new_bool(true)]))))) {
				return rt.new_null()
			}
			if rt.is_true(rt.new_bool(rt.is_true(var_item.array_get('permission')) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [var_item.array_get('permission')]))))))) {
				return rt.new_null()
			}
			mut var_stat := rt.new_string('jetpack/' + (var_item_key).str())
			mut var_endpoint := rt.new_string('jetpack/' + (var_item.array_get('module')).str())
			this.allowed_stats.array_push(var_stat.dup())
			this.labels.array_set(var_stat, var_item.array_get('label'))
			this.endpoints.array_set(var_endpoint, '/jetpack/v4/module/' + (var_item.array_get('module')).str() + '/data')
			rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_PerformanceIndicators_Controller', ['Automattic_WooCommerce_Admin_API_Reports_GenericController'], &this), 'formats').array_set(var_stat, var_item.array_get('format'))
		}
	}
	this.urls.array_set('jetpack/stats', '/jetpack')
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_PerformanceIndicators_Controller) get_indicator_data() bool {
	if !(!rt.is_true(this.endpoints)) && !(!rt.is_true(this.labels)) && !(!rt.is_true(this.allowed_stats)) {
		return true
	}
	this.get_analytics_report_data()
	this.get_jetpack_modules_data()
	return true
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_PerformanceIndicators_Controller) get_allowed_items(var_request rt.PhpVal) rt.PhpVal {
	mut var_request_mutated := var_request
	mut var_indicator_data := rt.new_bool(this.get_indicator_data())
	if rt.is_true(rt.call_function('is_wp_error', [var_indicator_data.dup()])) {
		return var_indicator_data.dup()
	}
	mut var_data := rt.new_array()
	{
		mut iter_1 := this.allowed_stats.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_stat := item_1.val
			mut var_pieces := this.get_stats_parts(var_stat.dup())
			mut var_report := var_pieces.array_get(0)
			mut var_chart := var_pieces.array_get(1)
			var_data.array_push(// unsupported expression: Expr_Cast_Object)
		}
	}
	rt.call_function('usort', [var_data.dup(), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Reports_PerformanceIndicators_Controller', ['Automattic_WooCommerce_Admin_API_Reports_GenericController'], &this) }, rt.ArrayItem{ key: none, val: 'sort' }])])
	mut var_objects := rt.new_array()
	{
		mut iter_1 := var_data.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_item := item_1.val
			mut var_prepared := this.prepare_item_for_response(var_item.dup(), var_request_mutated)
			var_objects.array_push(this.prepare_response_for_collection(var_prepared.dup()))
		}
	}
	return this.add_pagination_headers(var_request_mutated, var_objects.dup(), // unsupported expression: Expr_Cast_Int, rt.new_int(1), rt.new_int(1))
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_PerformanceIndicators_Controller) sort(var_a rt.PhpVal, var_b rt.PhpVal) i64 {
	mut var_a_mutated := var_a
	mut var_b_mutated := var_b
	mut var_stat_order := rt.call_function('apply_filters', [rt.new_string('woocommerce_rest_report_sort_performance_indicators'), rt.create_array([rt.ArrayItem{ key: none, val: 'revenue/total_sales' }, rt.ArrayItem{ key: none, val: 'revenue/net_revenue' }, rt.ArrayItem{ key: none, val: 'orders/orders_count' }, rt.ArrayItem{ key: none, val: 'orders/avg_order_value' }, rt.ArrayItem{ key: none, val: 'products/items_sold' }, rt.ArrayItem{ key: none, val: 'revenue/refunds' }, rt.ArrayItem{ key: none, val: 'coupons/orders_count' }, rt.ArrayItem{ key: none, val: 'coupons/amount' }, rt.ArrayItem{ key: none, val: 'taxes/total_tax' }, rt.ArrayItem{ key: none, val: 'taxes/order_tax' }, rt.ArrayItem{ key: none, val: 'taxes/shipping_tax' }, rt.ArrayItem{ key: none, val: 'revenue/shipping' }, rt.ArrayItem{ key: none, val: 'downloads/download_count' }])])
	var_a_mutated = rt.call_function('array_search', [rt.get_property(var_a_mutated, 'stat'), var_stat_order.dup(), rt.new_bool(true)])
	var_b_mutated = rt.call_function('array_search', [rt.get_property(var_b_mutated, 'stat'), var_stat_order.dup(), rt.new_bool(true)])
	if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_bool(false), var_a_mutated)) && rt.is_true(rt.identical(rt.new_bool(false), var_b_mutated)))) {
		return 0
	} else if rt.is_true(rt.identical(rt.new_bool(false), var_a_mutated)) {
		return 1
	} else if rt.is_true(rt.identical(rt.new_bool(false), var_b_mutated)) {
		return (// unsupported expression: Expr_UnaryMinus).to_i64()
	} else {
		return (rt.sub(var_a_mutated, var_b_mutated)).to_i64()
	}
	return i64(0)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_PerformanceIndicators_Controller) get_stats_data(var_report rt.PhpVal, var_query_args rt.PhpVal) rt.PhpVal {
	mut var_report_mutated := var_report
	mut var_query_args_mutated := var_query_args
	if this.stats_data.array_isset(var_report_mutated) {
		return this.stats_data.array_get(var_report_mutated)
	}
	mut var_request_url := this.endpoints.array_get(var_report_mutated)
	mut var_request := create_wp_rest_request(rt.new_string('GET'), var_request_url.dup())
	var_request.set_param(rt.new_string('before'), var_query_args_mutated.array_get('before'))
	var_request.set_param(rt.new_string('after'), var_query_args_mutated.array_get('after'))
	mut var_response := rt.call_function('rest_do_request', [var_request])
	this.stats_data.array_set(var_report_mutated, var_response.dup())
	return var_response.dup()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_PerformanceIndicators_Controller) get_items(var_request rt.PhpVal) rt.PhpVal {
	mut var_request_mutated := var_request
	mut var_indicator_data := rt.new_bool(this.get_indicator_data())
	if rt.is_true(rt.call_function('is_wp_error', [var_indicator_data.dup()])) {
		return var_indicator_data.dup()
	}
	mut var_query_args := this.prepare_reports_query(var_request_mutated)
	if !rt.is_true(var_query_args.array_get('stats')) {
		return create_automattic_woocommerce_admin_api_reports_performanceindicators_wp_error(rt.new_string('woocommerce_analytics_performance_indicators_empty_query'), rt.call_function('__', [rt.new_string('A list of stats to query must be provided.'), rt.new_string('woocommerce')]), rt.new_int(400))
	}
	mut var_stats := rt.new_array()
	{
		mut iter_1 := var_query_args.array_get('stats').iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_stat := item_1.val
			mut var_is_error := rt.new_bool()
			
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_PerformanceIndicators_Controller) prepare_item_for_response(var_stat_data rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
	mut var_request_mutated := var_request
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_PerformanceIndicators_Controller) prepare_links(var_object rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_PerformanceIndicators_Controller) get_stats_parts(var_full_stat rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_PerformanceIndicators_Controller) format_data_value(var_data rt.PhpVal, var_stat rt.PhpVal, var_report rt.PhpVal, var_chart rt.PhpVal, var_query_args rt.PhpVal) rt.PhpVal {
	mut var_data_mutated := var_data
	mut var_stat_mutated := var_stat
	mut var_report_mutated := var_report
	mut var_chart_mutated := var_chart
	mut var_query_args_mutated := var_query_args
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_PerformanceIndicators_Controller) get_item_schema() rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_PerformanceIndicators_Controller) get_public_allowed_item_schema() rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_PerformanceIndicators_Controller) get_collection_params() rt.PhpVal {
}

struct Class_Automattic_WooCommerce_Admin_API_Reports_GenericController {
	rt.PhpObjectBase
}

struct Class_WP_REST_Request {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_API_Reports_PerformanceIndicators_WP_Error {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_API_Reports_PerformanceIndicators_Jetpack {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_api_reports_performanceindicators_controller() &Class_Automattic_WooCommerce_Admin_API_Reports_PerformanceIndicators_Controller {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_PerformanceIndicators_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
		rest_base: rt.new_string('reports/performance-indicators')
		endpoints: rt.new_array()
		active_jetpack_modules: rt.new_null()
		allowed_stats: rt.new_array()
		labels: rt.new_array()
		urls: rt.new_array()
		stats_data: rt.new_array()
	}
	obj.construct()
	return obj
}

fn create_automattic_woocommerce_admin_api_reports_genericcontroller() &Class_Automattic_WooCommerce_Admin_API_Reports_GenericController {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_GenericController{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_rest_request() &Class_WP_REST_Request {
	mut obj := &Class_WP_REST_Request{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_reports_performanceindicators_wp_error() &Class_Automattic_WooCommerce_Admin_API_Reports_PerformanceIndicators_WP_Error {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_PerformanceIndicators_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_reports_performanceindicators_jetpack() &Class_Automattic_WooCommerce_Admin_API_Reports_PerformanceIndicators_Jetpack {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_PerformanceIndicators_Jetpack{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_PerformanceIndicators_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'register_routes' {
			this.register_routes()
			return rt.new_null()
		}
		'prepare_reports_query' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.prepare_reports_query(dispatch_arg_0)
		}
		'get_analytics_report_data' {
			return this.get_analytics_report_data()
		}
		'get_active_jetpack_modules' {
			return this.get_active_jetpack_modules()
		}
		'set_active_jetpack_modules' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_active_jetpack_modules(dispatch_arg_0)
			return rt.new_null()
		}
		'get_jetpack_modules_data' {
			this.get_jetpack_modules_data()
			return rt.new_null()
		}
		'get_indicator_data' {
			return rt.new_bool(this.get_indicator_data())
		}
		'get_allowed_items' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_allowed_items(dispatch_arg_0)
		}
		'sort' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_int(this.sort(dispatch_arg_0, dispatch_arg_1))
		}
		'get_stats_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.get_stats_data(dispatch_arg_0, dispatch_arg_1)
		}
		'get_items' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_items(dispatch_arg_0)
		}
		'prepare_item_for_response' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.prepare_item_for_response(dispatch_arg_0, dispatch_arg_1)
		}
		'prepare_links' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.prepare_links(dispatch_arg_0)
		}
		'get_stats_parts' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_stats_parts(dispatch_arg_0)
		}
		'format_data_value' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			dispatch_arg_4 := if args.len > 4 { args[4] } else { rt.new_null() }
			return this.format_data_value(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3, dispatch_arg_4)
		}
		'get_item_schema' {
			return this.get_item_schema()
		}
		'get_public_allowed_item_schema' {
			return this.get_public_allowed_item_schema()
		}
		'get_collection_params' {
			return this.get_collection_params()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_API_Reports_PerformanceIndicators_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'rest_base' { return this.rest_base }
		'endpoints' { return this.endpoints }
		'active_jetpack_modules' { return this.active_jetpack_modules }
		'allowed_stats' { return this.allowed_stats }
		'labels' { return this.labels }
		'urls' { return this.urls }
		'stats_data' { return this.stats_data }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_PerformanceIndicators_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'rest_base' { this.rest_base = val; return true }
		'endpoints' { this.endpoints = val; return true }
		'active_jetpack_modules' { this.active_jetpack_modules = val; return true }
		'allowed_stats' { this.allowed_stats = val; return true }
		'labels' { this.labels = val; return true }
		'urls' { this.urls = val; return true }
		'stats_data' { this.stats_data = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_GenericController) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_API_Reports_GenericController) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_GenericController) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_REST_Request) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_REST_Request) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_REST_Request) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_PerformanceIndicators_WP_Error) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_API_Reports_PerformanceIndicators_WP_Error) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_PerformanceIndicators_WP_Error) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_PerformanceIndicators_Jetpack) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_API_Reports_PerformanceIndicators_Jetpack) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_PerformanceIndicators_Jetpack) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_admin_api_reports_performanceindicators_controller_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
