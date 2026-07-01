import rt

struct Class_Automattic_WooCommerce_Admin_API_Reports_Variations_Stats_Controller {
	rt.PhpObjectBase
pub mut:
		rest_base rt.PhpVal = rt.new_string('reports/variations/stats')
		param_mapping rt.PhpVal = rt.new_array()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Variations_Stats_Controller) construct()  {
	rt.call_function('add_filter', [rt.new_string('woocommerce_analytics_variations_stats_select_query'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Variations_Stats_Controller', ['Automattic_WooCommerce_Admin_API_Reports_GenericStatsController'], &this) }, rt.ArrayItem{ key: none, val: 'set_default_report_data' }])])
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Variations_Stats_Controller) get_datastore_data(var_query_args rt.PhpVal) rt.PhpVal {
	mut var_query_args_mutated := var_query_args
	mut var_query := create_automattic_woocommerce_admin_api_reports_genericquery(var_query_args_mutated.dup(), rt.new_string('variations-stats'))
	return var_query.get_data()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Variations_Stats_Controller) prepare_reports_query(var_request rt.PhpVal) rt.PhpVal {
	mut var_query_args := rt.create_array([rt.ArrayItem{ key: 'fields', val: rt.create_array([rt.ArrayItem{ key: none, val: 'items_sold' }, rt.ArrayItem{ key: none, val: 'net_revenue' }, rt.ArrayItem{ key: none, val: 'orders_count' }, rt.ArrayItem{ key: none, val: 'variations_count' }]) }])
	mut var_collection_params := rt.call_function('apply_filters', [rt.new_string('experimental_woocommerce_analytics_variations_stats_collection_params'), this.get_collection_params()])
	mut var_registered := rt.func_array_keys(var_collection_params.dup())
	{
		mut iter_1 := var_registered.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_param_name := item_1.val
			if var_request.array_isset(var_param_name) {
				if this.param_mapping.array_isset(var_param_name) {
					var_query_args.array_set(this.param_mapping.array_get(var_param_name), var_request.array_get(var_param_name))
				} else {
					var_query_args.array_set(var_param_name, var_request.array_get(var_param_name))
				}
			}
		}
	}
	return var_query_args.dup()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Variations_Stats_Controller) prepare_item_for_response(var_report rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
	mut var_response := this.Class_Automattic_WooCommerce_Admin_API_Reports_GenericStatsController.prepare_item_for_response(var_report.dup(), var_request.dup())
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_rest_prepare_report_variations_stats'), var_response.dup(), var_report.dup(), var_request.dup()])
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Variations_Stats_Controller) get_item_properties_schema() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: 'items_sold', val: rt.create_array([rt.ArrayItem{ key: 'title', val: rt.call_function('__', [rt.new_string('Variations Sold'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Number of variation items sold.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }, rt.ArrayItem{ key: 'indicator', val: true }]) }, rt.ArrayItem{ key: 'net_revenue', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Net sales.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'number' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }, rt.ArrayItem{ key: 'format', val: 'currency' }]) }, rt.ArrayItem{ key: 'orders_count', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Number of orders.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }])
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Variations_Stats_Controller) get_item_schema() rt.PhpVal {
	mut var_schema := this.Class_Automattic_WooCommerce_Admin_API_Reports_GenericStatsController.get_item_schema()
	var_schema.array_set('title', 'report_variations_stats')
	mut var_segment_label := rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Human readable segment label, either product or variation name.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }, rt.ArrayItem{ key: 'enum', val: rt.create_array([rt.ArrayItem{ key: none, val: 'day' }, rt.ArrayItem{ key: none, val: 'week' }, rt.ArrayItem{ key: none, val: 'month' }, rt.ArrayItem{ key: none, val: 'year' }]) }])
	var_schema.array_get_mut('properties').array_get_mut('totals').array_get_mut('properties').array_get_mut('segments').array_get_mut('items').array_get_mut('properties').array_set('segment_label', var_segment_label.dup())
	var_schema.array_get_mut('properties').array_get_mut('intervals').array_get_mut('items').array_get_mut('properties').array_get_mut('subtotals').array_get_mut('properties').array_get_mut('segments').array_get_mut('items').array_get_mut('properties').array_set('segment_label', var_segment_label.dup())
	return this.add_additional_fields_schema(var_schema.dup())
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Variations_Stats_Controller) set_default_report_data(var_results rt.PhpVal) rt.PhpVal {
	mut var_results_mutated := var_results
	if !rt.is_true(var_results_mutated) {
		var_results_mutated = create_automattic_woocommerce_admin_api_reports_variations_stats_stdclass()
		rt.set_property(var_results_mutated, 'total', rt.new_int(0))
		rt.set_property(var_results_mutated, 'totals', create_automattic_woocommerce_admin_api_reports_variations_stats_stdclass())
		rt.set_property(rt.get_property(var_results_mutated, 'totals'), 'items_sold', rt.new_int(0))
		rt.set_property(rt.get_property(var_results_mutated, 'totals'), 'net_revenue', rt.new_int(0))
		rt.set_property(rt.get_property(var_results_mutated, 'totals'), 'orders_count', rt.new_int(0))
		rt.set_property(var_results_mutated, 'intervals', rt.new_array())
		rt.set_property(var_results_mutated, 'pages', rt.new_int(1))
		rt.set_property(var_results_mutated, 'page_no', rt.new_int(1))
	}
	return var_results_mutated
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Variations_Stats_Controller) get_collection_params() rt.PhpVal {
	mut var_params := this.Class_Automattic_WooCommerce_Admin_API_Reports_GenericStatsController.get_collection_params()
	var_params.array_set('match', rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Indicates whether all the conditions should be true for the resulting set, or if any one of them is sufficient. Match affects the following parameters: status_is, status_is_not, product_includes, product_excludes, coupon_includes, coupon_excludes, customer, categories'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'default', val: 'all' }, rt.ArrayItem{ key: 'enum', val: rt.create_array([rt.ArrayItem{ key: none, val: 'all' }, rt.ArrayItem{ key: none, val: 'any' }]) }, rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' }]))
	var_params.array_get_mut('orderby').array_set('enum', this.apply_custom_orderby_filters(rt.create_array([rt.ArrayItem{ key: none, val: 'date' }, rt.ArrayItem{ key: none, val: 'net_revenue' }, rt.ArrayItem{ key: none, val: 'coupons' }, rt.ArrayItem{ key: none, val: 'refunds' }, rt.ArrayItem{ key: none, val: 'shipping' }, rt.ArrayItem{ key: none, val: 'taxes' }, rt.ArrayItem{ key: none, val: 'net_revenue' }, rt.ArrayItem{ key: none, val: 'orders_count' }, rt.ArrayItem{ key: none, val: 'items_sold' }])))
	var_params.array_set('category_includes', rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Limit result to items from the specified categories.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'array' }, rt.ArrayItem{ key: 'sanitize_callback', val: 'wp_parse_id_list' }, rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' }, rt.ArrayItem{ key: 'items', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'integer' }]) }]))
	var_params.array_set('category_excludes', rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Limit result set to variations not in the specified categories.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'array' }, rt.ArrayItem{ key: 'sanitize_callback', val: 'wp_parse_id_list' }, rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' }, rt.ArrayItem{ key: 'items', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'integer' }]) }]))
	var_params.array_set('product_includes', rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Limit result set to items that have the specified parent product(s).'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'array' }, rt.ArrayItem{ key: 'items', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'integer' }]) }, rt.ArrayItem{ key: 'default', val: rt.new_array() }, rt.ArrayItem{ key: 'sanitize_callback', val: 'wp_parse_id_list' }, rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' }]))
	var_params.array_set('product_excludes', rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Limit result set to items that don\'t have the specified parent product(s).'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'array' }, rt.ArrayItem{ key: 'items', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'integer' }]) }, rt.ArrayItem{ key: 'default', val: rt.new_array() }, rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' }, rt.ArrayItem{ key: 'sanitize_callback', val: 'wp_parse_id_list' }]))
	var_params.array_set('variations', rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Limit result to items with specified variation ids.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'array' }, rt.ArrayItem{ key: 'sanitize_callback', val: 'wp_parse_id_list' }, rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' }, rt.ArrayItem{ key: 'items', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'integer' }]) }]))
	var_params.array_set('segmentby', rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Segment the response by additional constraint.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'enum', val: rt.create_array([rt.ArrayItem{ key: none, val: 'product' }, rt.ArrayItem{ key: none, val: 'category' }, rt.ArrayItem{ key: none, val: 'variation' }]) }, rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' }]))
	var_params.array_set('attribute_is', rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Limit result set to orders that include products with the specified attributes.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'array' }, rt.ArrayItem{ key: 'items', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'array' }]) }, rt.ArrayItem{ key: 'default', val: rt.new_array() }, rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' }]))
	var_params.array_set('attribute_is_not', rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Limit result set to orders that don\'t include products with the specified attributes.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'array' }, rt.ArrayItem{ key: 'items', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'array' }]) }, rt.ArrayItem{ key: 'default', val: rt.new_array() }, rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' }]))
	return var_params.dup()
}

struct Class_Automattic_WooCommerce_Admin_API_Reports_GenericStatsController {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_API_Reports_GenericQuery {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_API_Reports_Variations_Stats_stdClass {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_api_reports_variations_stats_controller() &Class_Automattic_WooCommerce_Admin_API_Reports_Variations_Stats_Controller {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_Variations_Stats_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
		rest_base: rt.new_string('reports/variations/stats')
		param_mapping: rt.new_array()
	}
	obj.construct()
	return obj
}

fn create_automattic_woocommerce_admin_api_reports_genericstatscontroller() &Class_Automattic_WooCommerce_Admin_API_Reports_GenericStatsController {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_GenericStatsController{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_reports_genericquery() &Class_Automattic_WooCommerce_Admin_API_Reports_GenericQuery {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_GenericQuery{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_reports_variations_stats_stdclass() &Class_Automattic_WooCommerce_Admin_API_Reports_Variations_Stats_stdClass {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_Variations_Stats_stdClass{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Variations_Stats_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'get_datastore_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_datastore_data(dispatch_arg_0)
		}
		'prepare_reports_query' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.prepare_reports_query(dispatch_arg_0)
		}
		'prepare_item_for_response' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.prepare_item_for_response(dispatch_arg_0, dispatch_arg_1)
		}
		'get_item_properties_schema' {
			return this.get_item_properties_schema()
		}
		'get_item_schema' {
			return this.get_item_schema()
		}
		'set_default_report_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.set_default_report_data(dispatch_arg_0)
		}
		'get_collection_params' {
			return this.get_collection_params()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_API_Reports_Variations_Stats_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'rest_base' { return this.rest_base }
		'param_mapping' { return this.param_mapping }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Variations_Stats_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'rest_base' { this.rest_base = val; return true }
		'param_mapping' { this.param_mapping = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_GenericStatsController) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_API_Reports_GenericStatsController) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_GenericStatsController) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_GenericQuery) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_API_Reports_GenericQuery) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_GenericQuery) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Variations_Stats_stdClass) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_API_Reports_Variations_Stats_stdClass) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Variations_Stats_stdClass) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_admin_api_reports_variations_stats_controller_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
