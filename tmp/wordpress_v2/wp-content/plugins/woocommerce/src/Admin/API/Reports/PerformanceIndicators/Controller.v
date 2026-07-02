import rt

struct Class_Automattic_WooCommerce_Admin_API_Reports_PerformanceIndicators_Controller {
	rt.PhpObjectBase
pub mut:
	rest_base              rt.PhpVal = rt.new_string('reports/performance-indicators')
	endpoints              rt.PhpVal = rt.new_array()
	active_jetpack_modules rt.PhpVal = rt.new_null()
	allowed_stats          rt.PhpVal = rt.new_array()
	labels                 rt.PhpVal = rt.new_array()
	urls                   rt.PhpVal = rt.new_array()
	stats_data             rt.PhpVal = rt.new_array()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_PerformanceIndicators_Controller) construct() {
	rt.call_function('add_filter', [
		rt.new_string('woocommerce_rest_performance_indicators_data_value'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Reports_PerformanceIndicators_Controller', [
				'Automattic_WooCommerce_Admin_API_Reports_GenericController',
			], &this) },
			rt.ArrayItem{ key: none, val: 'format_data_value' },
		]),
		rt.new_int(10),
		rt.new_int(5),
	])
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_PerformanceIndicators_Controller) register_routes() {
	this.Class_Automattic_WooCommerce_Admin_API_Reports_GenericController.register_routes()
	rt.call_function('register_rest_route', [
		rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_PerformanceIndicators_Controller', [
			'Automattic_WooCommerce_Admin_API_Reports_GenericController',
		], &this), 'namespace'),
		rt.new_string('/' + (this.rest_base).str() + '/allowed'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{
					key: 'methods'
					val: Class_Automattic_WooCommerce_Admin_API_Reports_PerformanceIndicators_WP_REST_Server.readable()
				},
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Reports_PerformanceIndicators_Controller', [
						'Automattic_WooCommerce_Admin_API_Reports_GenericController',
					], &this) },
					rt.ArrayItem{ key: none, val: 'get_allowed_items' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Reports_PerformanceIndicators_Controller', [
						'Automattic_WooCommerce_Admin_API_Reports_GenericController',
					], &this) },
					rt.ArrayItem{ key: none, val: 'get_items_permissions_check' },
				]) },
				rt.ArrayItem{ key: 'args', val: this.get_collection_params() },
			]) },
			rt.ArrayItem{ key: 'schema', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Reports_PerformanceIndicators_Controller', [
					'Automattic_WooCommerce_Admin_API_Reports_GenericController',
				], &this) },
				rt.ArrayItem{ key: none, val: 'get_public_allowed_item_schema' },
			]) },
		]),
	])
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_PerformanceIndicators_Controller) prepare_reports_query(var_request rt.PhpVal) rt.PhpVal {
	mut var_request_mutated := var_request
	mut var_args := rt.new_array()
	var_args.array_set('before', var_request_mutated.array_get(rt.new_string('before')))
	var_args.array_set('after', var_request_mutated.array_get(rt.new_string('after')))
	var_args.array_set('stats', var_request_mutated.array_get(rt.new_string('stats')))
	return var_args.clone()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_PerformanceIndicators_Controller) get_analytics_report_data() rt.PhpVal {
	mut var_request := create_wp_rest_request(rt.new_string('GET'),
		rt.new_string('/wc-analytics/reports'))
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_response := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		if rt.is_true(rt.call_function('is_callable', [
			rt.create_array([rt.ArrayItem{ key: none, val: var_response },
				rt.ArrayItem{ key: none, val: 'remove_link' }]),
		]))
		{
			rt.call_method(var_response, 'remove_link', [rt.new_string('self')])
		}
		return var_response.clone()
	}
	mut var_remove_self_link_from_prepared_internal_response := rt.new_closure(closure_1_fn)
	rt.call_function('add_filter', [rt.new_string('woocommerce_rest_prepare_report'),
		var_remove_self_link_from_prepared_internal_response.clone()])
	mut var_response := rt.call_function('rest_do_request', [var_request])
	rt.call_function('remove_filter', [rt.new_string('woocommerce_rest_prepare_report'),
		var_remove_self_link_from_prepared_internal_response.clone()])
	if rt.is_true(rt.call_function('is_wp_error', [var_response.clone()])) {
		return var_response.clone()
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int(200), rt.call_method(var_response,
		'get_status', []rt.PhpVal{})))))
	{
		return rt.new_object('Automattic_WooCommerce_Admin_API_Reports_PerformanceIndicators_WP_Error',
			[]string{}, create_automattic_woocommerce_admin_api_reports_performanceindicators_wp_error(rt.new_string('woocommerce_analytics_performance_indicators_result_failed'), rt.call_function('__', [
			rt.new_string('Sorry, fetching performance indicators failed.'),
			rt.new_string('woocommerce'),
		])))
	}
	mut var_endpoints := rt.call_method(var_response, 'get_data', []rt.PhpVal{})
	mut iter_1 := var_endpoints.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_endpoint := item_1.val
		if rt.is_true(rt.identical(rt.new_string('/stats'), rt.call_function('substr', [
			var_endpoint.array_get(rt.new_string('slug')),
			rt.new_int(-6),
		])))
		{
			var_request = create_wp_rest_request(rt.new_string('OPTIONS'),
				var_endpoint.array_get(rt.new_string('path')))
			var_response = rt.call_function('rest_do_request', [var_request])
			if rt.is_true(rt.call_function('is_wp_error', [var_response.clone()])) {
				return var_response.clone()
			}
			mut var_data := rt.call_method(var_response, 'get_data', []rt.PhpVal{})
			mut var_prefix := rt.call_function('substr', [
				var_endpoint.array_get(rt.new_string('slug')),
				rt.new_int(0),
				rt.new_int(-6),
			])
			if !rt.is_true(var_data.array_get(rt.new_string('schema')).array_get(rt.new_string('properties')).array_get(rt.new_string('totals')).array_get(rt.new_string('properties'))) {
				continue
			}
			mut iter_2 :=
				var_data.array_get(rt.new_string('schema')).array_get(rt.new_string('properties')).array_get(rt.new_string('totals')).array_get(rt.new_string('properties')).iterator()
			for {
				item_2 := iter_2.next() or { break }
				mut var_schema_info := item_2.val
				mut var_property_key := item_2.key
				if !rt.is_true(var_schema_info.array_get(rt.new_string('indicator')))
					|| rt.is_true(rt.new_bool(!(rt.is_true(var_schema_info.array_get(rt.new_string('indicator')))))) {
					continue
				}
				mut var_stat := rt.new_string(var_prefix.str() + '/' + var_property_key.str())
				this.allowed_stats.array_push(var_stat.clone())
				mut var_stat_label := if !rt.is_true(var_schema_info.array_get(rt.new_string('title'))) {
					var_schema_info.array_get(rt.new_string('description'))
				} else {
					var_schema_info.array_get(rt.new_string('title'))
				}
				this.labels.array_set(var_stat, var_stat_label.clone().to_string().trim_space())
				rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_PerformanceIndicators_Controller', [
					'Automattic_WooCommerce_Admin_API_Reports_GenericController',
				], &this), 'formats').array_set(var_stat, if var_schema_info.array_isset(rt.new_string('format')) {
					var_schema_info.array_get(rt.new_string('format'))
				} else {
					rt.new_string('number')
				})
			}
			this.endpoints.array_set(var_prefix, var_endpoint.array_get(rt.new_string('path')))
			this.urls.array_set(var_prefix,
				var_endpoint.array_get(rt.new_string('_links')).array_get(rt.new_string('report')).array_get(rt.new_int(0)).array_get(rt.new_string('href')))
		}
	}
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_PerformanceIndicators_Controller) get_active_jetpack_modules() rt.PhpVal {
	if rt.is_true(rt.new_bool(this.active_jetpack_modules.is_null())) {
		if rt.is_true(rt.call_function('class_exists', [rt.new_string('\\Jetpack')]))
			&& rt.is_true(rt.call_function('method_exists', [rt.new_string('\\Jetpack'), rt.new_string('get_active_modules')])) {
			mut iife_temp_1 :=
				Class_Automattic_WooCommerce_Admin_API_Reports_PerformanceIndicators_Jetpack{}
			mut iife_result_1 := iife_temp_1.get_active_modules()
			mut var_active_modules := iife_result_1
			this.active_jetpack_modules = if var_active_modules.clone().is_array() {
				var_active_modules
			} else {
				rt.new_array()
			}
		} else {
			this.active_jetpack_modules = rt.new_array()
		}
	}
	return this.active_jetpack_modules
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_PerformanceIndicators_Controller) set_active_jetpack_modules(var_modules rt.PhpVal) {
	this.active_jetpack_modules = var_modules.clone()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_PerformanceIndicators_Controller) get_jetpack_modules_data() {
	mut var_active_modules := this.get_active_jetpack_modules()
	if !rt.is_true(var_active_modules) {
		return
	}
	mut var_items := rt.call_function('apply_filters', [
		rt.new_string('woocommerce_rest_performance_indicators_jetpack_items'),
		rt.create_array([
			rt.ArrayItem{ key: 'stats/visitors', val: rt.create_array([
				rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
					rt.new_string('Visitors'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'permission', val: 'view_stats' },
				rt.ArrayItem{ key: 'format', val: 'number' },
				rt.ArrayItem{ key: 'module', val: 'stats' },
			]) },
			rt.ArrayItem{ key: 'stats/views', val: rt.create_array([
				rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
					rt.new_string('Views'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'permission', val: 'view_stats' },
				rt.ArrayItem{ key: 'format', val: 'number' },
				rt.ArrayItem{ key: 'module', val: 'stats' },
			]) },
		]),
	])
	mut iter_3 := var_items.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_item := item_3.val
		mut var_item_key := item_3.key
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
			var_item.array_get(rt.new_string('module')),
			var_active_modules.clone(),
			rt.new_bool(true),
		])))))
		{
			return
		}
		if rt.is_true(var_item.array_get(rt.new_string('permission')))
			&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [var_item.array_get(rt.new_string('permission'))]))))) {
			return
		}
		mut var_stat := rt.new_string('jetpack/' + var_item_key.str())
		mut var_endpoint := rt.new_string('jetpack/' +
			(var_item.array_get(rt.new_string('module'))).str())
		this.allowed_stats.array_push(var_stat.clone())
		this.labels.array_set(var_stat, var_item.array_get(rt.new_string('label')))
		this.endpoints.array_set(var_endpoint, '/jetpack/v4/module/' +
			(var_item.array_get(rt.new_string('module'))).str() + '/data')
		rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_PerformanceIndicators_Controller', [
			'Automattic_WooCommerce_Admin_API_Reports_GenericController',
		], &this), 'formats').array_set(var_stat, var_item.array_get(rt.new_string('format')))
	}
	this.urls.array_set('jetpack/stats', '/jetpack')
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_PerformanceIndicators_Controller) get_indicator_data() bool {
	if !(!rt.is_true(this.endpoints)) && !(!rt.is_true(this.labels))
		&& !(!rt.is_true(this.allowed_stats)) {
		return true
	}
	this.get_analytics_report_data()
	this.get_jetpack_modules_data()
	return true
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_PerformanceIndicators_Controller) get_allowed_items(var_request rt.PhpVal) rt.PhpVal {
	mut var_request_mutated := var_request
	mut var_indicator_data := rt.new_bool(this.get_indicator_data())
	if rt.is_true(rt.call_function('is_wp_error', [var_indicator_data.clone()])) {
		return var_indicator_data.clone()
	}
	mut var_data := rt.new_array()
	mut iter_4 := this.allowed_stats.iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_stat := item_4.val
		mut var_pieces := this.get_stats_parts(var_stat.clone())
		mut var_report := var_pieces.array_get(rt.new_int(0))
		mut var_chart := var_pieces.array_get(rt.new_int(1))
		var_data.array_push(rt.array_to_object(rt.create_array([
			rt.ArrayItem{ key: 'stat', val: var_stat },
			rt.ArrayItem{ key: 'chart', val: var_chart },
			rt.ArrayItem{ key: 'label', val: this.labels.array_get(var_stat) },
		])))
	}
	rt.call_function('usort', [var_data.clone(),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Reports_PerformanceIndicators_Controller', [
				'Automattic_WooCommerce_Admin_API_Reports_GenericController',
			], &this) },
			rt.ArrayItem{ key: none, val: 'sort' },
		])])
	mut var_objects := rt.new_array()
	mut iter_5 := var_data.iterator()
	for {
		item_5 := iter_5.next() or { break }
		mut var_item := item_5.val
		mut var_prepared := this.prepare_item_for_response(var_item.clone(),
			var_request_mutated.clone())
		var_objects.array_push(this.prepare_response_for_collection(var_prepared.clone()))
	}
	return this.add_pagination_headers(var_request_mutated.clone(), var_objects.clone(),
		rt.new_int(var_data.clone().array_count()), rt.new_int(1), rt.new_int(1))
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_PerformanceIndicators_Controller) sort(var_a rt.PhpVal, var_b rt.PhpVal) i64 {
	mut var_a_mutated := var_a
	mut var_b_mutated := var_b
	mut var_stat_order := rt.call_function('apply_filters', [
		rt.new_string('woocommerce_rest_report_sort_performance_indicators'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'revenue/total_sales' },
			rt.ArrayItem{ key: none, val: 'revenue/net_revenue' },
			rt.ArrayItem{ key: none, val: 'orders/orders_count' },
			rt.ArrayItem{ key: none, val: 'orders/avg_order_value' },
			rt.ArrayItem{ key: none, val: 'products/items_sold' },
			rt.ArrayItem{ key: none, val: 'revenue/refunds' },
			rt.ArrayItem{ key: none, val: 'coupons/orders_count' },
			rt.ArrayItem{ key: none, val: 'coupons/amount' },
			rt.ArrayItem{ key: none, val: 'taxes/total_tax' },
			rt.ArrayItem{ key: none, val: 'taxes/order_tax' },
			rt.ArrayItem{ key: none, val: 'taxes/shipping_tax' },
			rt.ArrayItem{ key: none, val: 'revenue/shipping' },
			rt.ArrayItem{ key: none, val: 'downloads/download_count' }]),
	])
	var_a_mutated = rt.call_function('array_search', [
		rt.get_property(var_a_mutated, 'stat'),
		var_stat_order.clone(),
		rt.new_bool(true),
	])
	var_b_mutated = rt.call_function('array_search', [
		rt.get_property(var_b_mutated, 'stat'),
		var_stat_order.clone(),
		rt.new_bool(true),
	])
	if rt.is_true(rt.identical(rt.new_bool(false), var_a_mutated))
		&& rt.is_true(rt.identical(rt.new_bool(false), var_b_mutated)) {
		return 0
	} else if rt.is_true(rt.identical(rt.new_bool(false), var_a_mutated)) {
		return 1
	} else if rt.is_true(rt.identical(rt.new_bool(false), var_b_mutated)) {
		return -1
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
	mut var_request := create_wp_rest_request(rt.new_string('GET'), var_request_url.clone())
	var_request.set_param(rt.new_string('before'),
		var_query_args_mutated.array_get(rt.new_string('before')))
	var_request.set_param(rt.new_string('after'),
		var_query_args_mutated.array_get(rt.new_string('after')))
	mut var_response := rt.call_function('rest_do_request', [var_request])
	this.stats_data.array_set(var_report_mutated, var_response.clone())
	return var_response.clone()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_PerformanceIndicators_Controller) get_items(var_request rt.PhpVal) rt.PhpVal {
	mut var_request_mutated := var_request
	mut var_indicator_data := rt.new_bool(this.get_indicator_data())
	if rt.is_true(rt.call_function('is_wp_error', [var_indicator_data.clone()])) {
		return var_indicator_data.clone()
	}
	mut var_query_args := this.prepare_reports_query(var_request_mutated.clone())
	if !rt.is_true(var_query_args.array_get(rt.new_string('stats'))) {
		return rt.new_object('Automattic_WooCommerce_Admin_API_Reports_PerformanceIndicators_WP_Error',
			[]string{}, create_automattic_woocommerce_admin_api_reports_performanceindicators_wp_error(rt.new_string('woocommerce_analytics_performance_indicators_empty_query'), rt.call_function('__', [
			rt.new_string('A list of stats to query must be provided.'),
			rt.new_string('woocommerce'),
		]), rt.new_int(400)))
	}
	mut var_stats := rt.new_array()
	mut iter_6 := var_query_args.array_get(rt.new_string('stats')).iterator()
	for {
		item_6 := iter_6.next() or { break }
		mut var_stat := item_6.val
		mut var_is_error := rt.new_bool(false)
		mut var_pieces := this.get_stats_parts(var_stat.clone())
		mut var_report := var_pieces.array_get(rt.new_int(0))
		mut var_chart := var_pieces.array_get(rt.new_int(1))
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
			var_stat.clone(), this.allowed_stats, rt.new_bool(true)])))))
		{
			continue
		}
		mut var_response := this.get_stats_data(var_report.clone(), var_query_args.clone())
		if rt.is_true(rt.call_function('is_wp_error', [var_response.clone()])) {
			return var_response.clone()
		}
		mut var_data := rt.call_method(var_response, 'get_data', []rt.PhpVal{})
		mut var_format := rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_PerformanceIndicators_Controller', [
			'Automattic_WooCommerce_Admin_API_Reports_GenericController',
		], &this), 'formats').array_get(var_stat)
		mut var_label := this.labels.array_get(var_stat)
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int(200), rt.call_method(var_response,
			'get_status', []rt.PhpVal{})))))
		{
			var_stats.array_push(rt.array_to_object(rt.create_array([
				rt.ArrayItem{ key: 'stat', val: var_stat },
				rt.ArrayItem{ key: 'chart', val: var_chart },
				rt.ArrayItem{ key: 'label', val: var_label },
				rt.ArrayItem{ key: 'format', val: var_format },
				rt.ArrayItem{ key: 'value', val: rt.new_null() },
			])))
			continue
		}
		var_stats.array_push(rt.array_to_object(rt.create_array([
			rt.ArrayItem{ key: 'stat', val: var_stat },
			rt.ArrayItem{ key: 'chart', val: var_chart },
			rt.ArrayItem{ key: 'label', val: var_label },
			rt.ArrayItem{ key: 'format', val: var_format },
			rt.ArrayItem{ key: 'value', val: rt.call_function('apply_filters', [
				rt.new_string('woocommerce_rest_performance_indicators_data_value'),
				var_data.clone(),
				var_stat.clone(),
				var_report.clone(),
				var_chart.clone(),
				var_query_args.clone(),
			]) },
		])))
	}
	rt.call_function('usort', [var_stats.clone(),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Reports_PerformanceIndicators_Controller', [
				'Automattic_WooCommerce_Admin_API_Reports_GenericController',
			], &this) },
			rt.ArrayItem{ key: none, val: 'sort' },
		])])
	mut var_objects := rt.new_array()
	mut iter_7 := var_stats.iterator()
	for {
		item_7 := iter_7.next() or { break }
		mut var_stat := item_7.val
		mut var_data := this.prepare_item_for_response(var_stat.clone(),
			var_request_mutated.clone())
		var_objects.array_push(this.prepare_response_for_collection(var_data.clone()))
	}
	mut var_response := rt.call_function('rest_ensure_response', [
		var_objects.clone()])
	rt.call_method(var_response, 'header', [rt.new_string('X-WP-Total'),
		rt.new_int(var_stats.clone().array_count())])
	rt.call_method(var_response, 'header', [rt.new_string('X-WP-TotalPages'),
		rt.new_int(1)])
	mut var_base := rt.call_function('add_query_arg', [var_request_mutated.get_query_params(),
		rt.call_function('rest_url', [
			rt.call_function('sprintf', [rt.new_string('/%s/%s'),
				rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_PerformanceIndicators_Controller', [
					'Automattic_WooCommerce_Admin_API_Reports_GenericController',
				], &this), 'namespace'),
				this.rest_base]),
		])])
	return var_response.clone()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_PerformanceIndicators_Controller) prepare_item_for_response(var_stat_data rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
	mut var_request_mutated := var_request
	mut var_response := this.Class_Automattic_WooCommerce_Admin_API_Reports_GenericController.prepare_item_for_response(var_stat_data.clone(),
		var_request_mutated.clone())
	rt.call_method(var_response, 'add_links', [this.prepare_links(var_stat_data.clone())])
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_rest_prepare_report_performance_indicators'),
		var_response.clone(),
		var_stat_data.clone(),
		var_request_mutated.clone(),
	])
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_PerformanceIndicators_Controller) prepare_links(var_object rt.PhpVal) rt.PhpVal {
	mut var_pieces := this.get_stats_parts(rt.get_property(var_object, 'stat'))
	mut var_endpoint := var_pieces.array_get(rt.new_int(0))
	mut var_stat := var_pieces.array_get(rt.new_int(1))
	mut var_url := if this.urls.array_isset(var_endpoint) {
		this.urls.array_get(var_endpoint)
	} else {
		rt.new_string('')
	}
	mut var_links := rt.create_array([
		rt.ArrayItem{ key: 'api', val: rt.create_array([
			rt.ArrayItem{ key: 'href', val: rt.call_function('rest_url', [
				this.endpoints.array_get(var_endpoint),
			]) },
		]) },
		rt.ArrayItem{ key: 'report', val: rt.create_array([
			rt.ArrayItem{ key: 'href', val: var_url },
		]) },
	])
	return var_links.clone()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_PerformanceIndicators_Controller) get_stats_parts(var_full_stat rt.PhpVal) rt.PhpVal {
	mut var_endpoint := rt.call_function('substr', [var_full_stat.clone(),
		rt.new_int(0), rt.call_function('strrpos', [var_full_stat.clone(),
			rt.new_string('/')])])
	mut var_stat := rt.call_function('substr', [var_full_stat.clone(),
		rt.add(rt.call_function('strrpos', [var_full_stat.clone(),
			rt.new_string('/')]), rt.new_int(1))])
	return rt.create_array([rt.ArrayItem{ key: none, val: var_endpoint },
		rt.ArrayItem{ key: none, val: var_stat }])
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_PerformanceIndicators_Controller) format_data_value(var_data rt.PhpVal, var_stat rt.PhpVal, var_report rt.PhpVal, var_chart rt.PhpVal, var_query_args rt.PhpVal) rt.PhpVal {
	mut var_data_mutated := var_data
	mut var_stat_mutated := var_stat
	mut var_report_mutated := var_report
	mut var_chart_mutated := var_chart
	mut var_query_args_mutated := var_query_args
	if rt.is_true(rt.identical(rt.new_string('jetpack/stats'), var_report_mutated)) {
		mut var_index := rt.new_bool(false)
		if !(rt.get_property(rt.get_property(var_data_mutated.array_get(rt.new_string('general')), 'visits'), 'fields')).is_null()
			&& rt.get_property(rt.get_property(var_data_mutated.array_get(rt.new_string('general')), 'visits'), 'fields').is_array() {
			var_index = rt.call_function('array_search', [var_chart_mutated.clone(),
				rt.get_property(rt.get_property(var_data_mutated.array_get(rt.new_string('general')),
					'visits'), 'fields'),
				rt.new_bool(true)])
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(var_index)))) {
			return rt.new_null()
		}
		mut var_total := rt.new_int(0)
		mut iife_temp_2 := Class_Automattic_WooCommerce_Admin_API_Reports_TimeInterval{}
		mut iife_result_2 := iife_temp_2.default_before()
		mut iife_temp_3 := Class_Automattic_WooCommerce_Admin_API_Reports_TimeInterval{}
		mut iife_result_3 := iife_temp_3.default_before()
		mut var_before := rt.call_function('gmdate', [rt.new_string('Y-m-d'),
			rt.call_function('strtotime', [if var_query_args_mutated.array_isset(rt.new_string('before')) {
				var_query_args_mutated.array_get(rt.new_string('before'))
			} else {
				iife_result_2
			}])])
		mut iife_temp_4 := Class_Automattic_WooCommerce_Admin_API_Reports_TimeInterval{}
		mut iife_result_4 := iife_temp_4.default_after()
		mut iife_temp_5 := Class_Automattic_WooCommerce_Admin_API_Reports_TimeInterval{}
		mut iife_result_5 := iife_temp_5.default_after()
		mut var_after := rt.call_function('gmdate', [rt.new_string('Y-m-d'),
			rt.call_function('strtotime', [if var_query_args_mutated.array_isset(rt.new_string('after')) {
				var_query_args_mutated.array_get(rt.new_string('after'))
			} else {
				iife_result_4
			}])])
		mut iter_8 := rt.get_property(rt.get_property(var_data_mutated.array_get(rt.new_string('general')),
			'visits'), 'data').iterator()
		for {
			item_8 := iter_8.next() or { break }
			mut var_datum := item_8.val
			if rt.is_true(rt.greater_equal(var_datum.array_get(rt.new_int(0)), var_after))
				&& rt.is_true(rt.less_equal(var_datum.array_get(rt.new_int(0)), var_before)) {
				var_total = rt.add(var_total, var_datum.array_get(var_index))
			}
		}
		return var_total.clone()
	}
	if var_data_mutated.array_isset(rt.new_string('totals'))
		&& var_data_mutated.array_get(rt.new_string('totals')).array_isset(var_chart_mutated) {
		return var_data_mutated.array_get(rt.new_string('totals')).array_get(var_chart_mutated)
	}
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_PerformanceIndicators_Controller) get_item_schema() rt.PhpVal {
	mut var_indicator_data := rt.new_bool(this.get_indicator_data())
	if rt.is_true(rt.call_function('is_wp_error', [var_indicator_data.clone()])) {
		mut var_allowed_stats := rt.new_array()
	} else {
		var_allowed_stats = this.allowed_stats
	}
	mut var_schema := rt.create_array([
		rt.ArrayItem{ key: '$schema', val: 'http://json-schema.org/draft-04/schema#' },
		rt.ArrayItem{ key: 'title', val: 'report_performance_indicator' },
		rt.ArrayItem{ key: 'type', val: 'object' },
		rt.ArrayItem{ key: 'properties', val: rt.create_array([
			rt.ArrayItem{ key: 'stat', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Unique identifier for the resource.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
				rt.ArrayItem{ key: 'enum', val: var_allowed_stats },
			]) },
			rt.ArrayItem{ key: 'chart', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('The specific chart this stat referrers to.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
			]) },
			rt.ArrayItem{ key: 'label', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Human readable label for the stat.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
			]) },
			rt.ArrayItem{ key: 'format', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Format of the stat.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'number' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
				rt.ArrayItem{ key: 'enum', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'number' },
					rt.ArrayItem{ key: none, val: 'currency' },
				]) },
			]) },
			rt.ArrayItem{ key: 'value', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Value of the stat. Returns null if the stat does not exist or cannot be loaded.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'number' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
			]) },
		]) },
	])
	return this.add_additional_fields_schema(var_schema.clone())
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_PerformanceIndicators_Controller) get_public_allowed_item_schema() rt.PhpVal {
	mut var_schema := this.get_public_item_schema()
	var_schema.array_get(rt.new_string('properties')).array_unset(rt.new_string('value'))
	var_schema.array_get(rt.new_string('properties')).array_unset(rt.new_string('format'))
	return var_schema.clone()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_PerformanceIndicators_Controller) get_collection_params() rt.PhpVal {
	mut var_indicator_data := rt.new_bool(this.get_indicator_data())
	if rt.is_true(rt.call_function('is_wp_error', [var_indicator_data.clone()])) {
		mut var_allowed_stats := rt.call_function('__', [
			rt.new_string('There was an issue loading the report endpoints'),
			rt.new_string('woocommerce'),
		])
	} else {
		var_allowed_stats = rt.call_function('implode', [rt.new_string(', '), this.allowed_stats])
	}
	mut var_params := rt.new_array()
	var_params.array_set('context', this.get_context_param(rt.create_array([
		rt.ArrayItem{ key: 'default', val: 'view' },
	])))
	var_params.array_set('stats', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('sprintf', [
			rt.call_function('__', [
				rt.new_string('Limit response to specific report stats. Allowed values: %s.'),
				rt.new_string('woocommerce'),
			]),
			var_allowed_stats.clone(),
		]) },
		rt.ArrayItem{ key: 'type', val: 'array' },
		rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' },
		rt.ArrayItem{ key: 'items', val: rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'string' },
			rt.ArrayItem{ key: 'enum', val: this.allowed_stats },
		]) },
		rt.ArrayItem{ key: 'default', val: this.allowed_stats },
	]))
	var_params.array_set('after', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Limit response to resources published after a given ISO8601 compliant date.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'string' },
		rt.ArrayItem{ key: 'format', val: 'date-time' },
		rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' },
	]))
	var_params.array_set('before', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Limit response to resources published before a given ISO8601 compliant date.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'string' },
		rt.ArrayItem{ key: 'format', val: 'date-time' },
		rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' },
	]))
	return var_params.clone()
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

struct Class_Automattic_WooCommerce_Admin_API_Reports_TimeInterval {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_api_reports_performanceindicators_controller() &Class_Automattic_WooCommerce_Admin_API_Reports_PerformanceIndicators_Controller {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_PerformanceIndicators_Controller{
		PhpObjectBase:          rt.PhpObjectBase{}
		rest_base:              rt.new_string('reports/performance-indicators')
		endpoints:              rt.new_array()
		active_jetpack_modules: rt.new_null()
		allowed_stats:          rt.new_array()
		labels:                 rt.new_array()
		urls:                   rt.new_array()
		stats_data:             rt.new_array()
	}
	obj.construct()
	return obj
}

fn create_automattic_woocommerce_admin_api_reports_genericcontroller(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_API_Reports_GenericController {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_GenericController{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_rest_request(_args ...rt.PhpVal) &Class_WP_REST_Request {
	mut obj := &Class_WP_REST_Request{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_reports_performanceindicators_wp_error(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_API_Reports_PerformanceIndicators_WP_Error {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_PerformanceIndicators_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_reports_performanceindicators_jetpack(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_API_Reports_PerformanceIndicators_Jetpack {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_PerformanceIndicators_Jetpack{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_reports_timeinterval(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_API_Reports_TimeInterval {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_TimeInterval{
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
			return this.format_data_value(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2,
				dispatch_arg_3, dispatch_arg_4)
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
		else {
			return none
		}
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
		'rest_base' {
			this.rest_base = val
			return true
		}
		'endpoints' {
			this.endpoints = val
			return true
		}
		'active_jetpack_modules' {
			this.active_jetpack_modules = val
			return true
		}
		'allowed_stats' {
			this.allowed_stats = val
			return true
		}
		'labels' {
			this.labels = val
			return true
		}
		'urls' {
			this.urls = val
			return true
		}
		'stats_data' {
			this.stats_data = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
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

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_TimeInterval) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_API_Reports_TimeInterval) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_TimeInterval) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}
