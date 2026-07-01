import rt

struct Class_Automattic_WooCommerce_Admin_API_Reports_Coupons_Stats_Controller {
	rt.PhpObjectBase
pub mut:
		rest_base rt.PhpVal = rt.new_string('reports/coupons/stats')
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Coupons_Stats_Controller) prepare_reports_query(var_request rt.PhpVal) rt.PhpVal {
	mut var_args := rt.new_array()
	var_args.array_set('before', var_request.array_get('before'))
	var_args.array_set('after', var_request.array_get('after'))
	var_args.array_set('interval', var_request.array_get('interval'))
	var_args.array_set('page', var_request.array_get('page'))
	var_args.array_set('per_page', var_request.array_get('per_page'))
	var_args.array_set('orderby', var_request.array_get('orderby'))
	var_args.array_set('order', var_request.array_get('order'))
	var_args.array_set('coupons', rt.cast_array(var_request.array_get('coupons')))
	var_args.array_set('segmentby', var_request.array_get('segmentby'))
	var_args.array_set('fields', var_request.array_get('fields'))
	var_args.array_set('force_cache_refresh', var_request.array_get('force_cache_refresh'))
	return var_args.dup()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Coupons_Stats_Controller) get_datastore_data(var_query_args rt.PhpVal) rt.PhpVal {
	mut var_query := create_automattic_woocommerce_admin_api_reports_genericquery(var_query_args.dup(), rt.new_string('coupons-stats'))
	return var_query.get_data()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Coupons_Stats_Controller) prepare_item_for_response(var_report rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
	mut var_report_mutated := var_report
	mut var_response := this.Class_Automattic_WooCommerce_Admin_API_Reports_GenericStatsController.prepare_item_for_response(var_report_mutated.dup(), var_request.dup())
	var_report_mutated = // unsupported expression: Expr_Cast_Object
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_rest_prepare_report_coupons_stats'), var_response.dup(), var_report_mutated.dup(), var_request.dup()])
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Coupons_Stats_Controller) get_item_properties_schema() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: 'amount', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Net discount amount.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'number' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }, rt.ArrayItem{ key: 'indicator', val: true }, rt.ArrayItem{ key: 'format', val: 'currency' }]) }, rt.ArrayItem{ key: 'coupons_count', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Number of coupons.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'orders_count', val: rt.create_array([rt.ArrayItem{ key: 'title', val: rt.call_function('__', [rt.new_string('Discounted orders'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Number of discounted orders.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }, rt.ArrayItem{ key: 'indicator', val: true }]) }])
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Coupons_Stats_Controller) get_item_schema() rt.PhpVal {
	mut var_schema := this.Class_Automattic_WooCommerce_Admin_API_Reports_GenericStatsController.get_item_schema()
	var_schema.array_set('title', 'report_coupons_stats')
	return this.add_additional_fields_schema(var_schema.dup())
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Coupons_Stats_Controller) get_collection_params() rt.PhpVal {
	mut var_params := this.Class_Automattic_WooCommerce_Admin_API_Reports_GenericStatsController.get_collection_params()
	var_params.array_get_mut('orderby').array_set('enum', this.apply_custom_orderby_filters(rt.create_array([rt.ArrayItem{ key: none, val: 'date' }, rt.ArrayItem{ key: none, val: 'amount' }, rt.ArrayItem{ key: none, val: 'coupons_count' }, rt.ArrayItem{ key: none, val: 'orders_count' }])))
	var_params.array_set('coupons', rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Limit result set to coupons assigned specific coupon IDs.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'array' }, rt.ArrayItem{ key: 'sanitize_callback', val: 'wp_parse_id_list' }, rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' }, rt.ArrayItem{ key: 'items', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'integer' }]) }]))
	var_params.array_set('segmentby', rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Segment the response by additional constraint.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'enum', val: rt.create_array([rt.ArrayItem{ key: none, val: 'product' }, rt.ArrayItem{ key: none, val: 'variation' }, rt.ArrayItem{ key: none, val: 'category' }, rt.ArrayItem{ key: none, val: 'coupon' }]) }, rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' }]))
	return var_params.dup()
}

struct Class_Automattic_WooCommerce_Admin_API_Reports_GenericStatsController {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_API_Reports_GenericQuery {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_api_reports_coupons_stats_controller() &Class_Automattic_WooCommerce_Admin_API_Reports_Coupons_Stats_Controller {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_Coupons_Stats_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
		rest_base: rt.new_string('reports/coupons/stats')
	}
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

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Coupons_Stats_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'prepare_reports_query' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.prepare_reports_query(dispatch_arg_0)
		}
		'get_datastore_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_datastore_data(dispatch_arg_0)
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
		'get_collection_params' {
			return this.get_collection_params()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_API_Reports_Coupons_Stats_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'rest_base' { return this.rest_base }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Coupons_Stats_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'rest_base' { this.rest_base = val; return true }
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




pub fn init_wp_content_plugins_woocommerce_src_admin_api_reports_coupons_stats_controller_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
