import rt

struct Class_Automattic_WooCommerce_Admin_API_Reports_GenericController {
	rt.PhpObjectBase
pub mut:
	namespace rt.PhpVal = rt.new_string('wc-analytics')
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_GenericController) add_pagination_headers(var_request rt.PhpVal, var_response rt.PhpVal, total i64, page i64, max_pages i64) rt.PhpVal {
	mut var_response_mutated := var_response
	var_response_mutated = rt.call_function('rest_ensure_response', [
		var_response_mutated.clone()])
	rt.call_method(var_response_mutated, 'header', [rt.new_string('X-WP-Total'),
		rt.new_int(total)])
	rt.call_method(var_response_mutated, 'header', [rt.new_string('X-WP-TotalPages'),
		rt.new_int(max_pages)])
	mut var_base := rt.call_function('add_query_arg', [
		rt.call_method(var_request, 'get_query_params', []rt.PhpVal{}),
		rt.call_function('rest_url', [
			rt.call_function('sprintf', [rt.new_string('/%s/%s'), this.namespace,
				rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_GenericController', [
					'Automattic_WooCommerce_Admin_API_Reports_WC_REST_Reports_Controller',
				], &this), 'rest_base')]),
		]),
	])
	if page > 1 {
		mut var_prev_page := rt.new_int(page - 1)
		if rt.is_true(rt.greater(var_prev_page, rt.new_int(max_pages))) {
			var_prev_page = rt.new_int(max_pages)
		}
		mut var_prev_link := rt.call_function('add_query_arg', [
			rt.new_string('page'), var_prev_page.clone(), var_base.clone()])
		rt.call_method(var_response_mutated, 'link_header', [
			rt.new_string('prev'), var_prev_link.clone()])
	}
	if max_pages > page {
		mut var_next_page := rt.new_int(page + 1)
		mut var_next_link := rt.call_function('add_query_arg', [
			rt.new_string('page'), var_next_page.clone(), var_base.clone()])
		rt.call_method(var_response_mutated, 'link_header', [
			rt.new_string('next'), var_next_link.clone()])
	}
	return var_response_mutated.clone()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_GenericController) get_datastore_data(var_query_args rt.PhpVal) rt.PhpVal {
	mut var_query_args_mutated := var_query_args
	mut iife_temp_0 := Class_Automattic_WooCommerce_Admin_API_Reports_WC_Data_Store{}
	mut iife_result_0 := iife_temp_0.load(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_GenericController', [
		'Automattic_WooCommerce_Admin_API_Reports_WC_REST_Reports_Controller',
	], &this), 'rest_base'))
	mut var_data_store := iife_result_0
	return rt.call_method(var_data_store, 'get_data', [var_query_args_mutated.clone()])
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_GenericController) get_collection_params() rt.PhpVal {
	mut var_params := rt.new_array()
	var_params.array_set('context', this.get_context_param(rt.create_array([
		rt.ArrayItem{ key: 'default', val: 'view' },
	])))
	var_params.array_set('page', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Current page of the collection.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'integer' },
		rt.ArrayItem{ key: 'default', val: 1 },
		rt.ArrayItem{ key: 'sanitize_callback', val: 'absint' },
		rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' },
		rt.ArrayItem{ key: 'minimum', val: 1 },
	]))
	var_params.array_set('per_page', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Maximum number of items to be returned in result set.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'integer' },
		rt.ArrayItem{ key: 'default', val: 10 },
		rt.ArrayItem{ key: 'minimum', val: 1 },
		rt.ArrayItem{ key: 'maximum', val: 100 },
		rt.ArrayItem{ key: 'sanitize_callback', val: 'absint' },
		rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' },
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
	var_params.array_set('order', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Order sort attribute ascending or descending.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'string' },
		rt.ArrayItem{ key: 'default', val: 'desc' },
		rt.ArrayItem{ key: 'enum', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'asc' },
			rt.ArrayItem{ key: none, val: 'desc' },
		]) },
		rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' },
	]))
	var_params.array_set('orderby', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Sort collection by object attribute.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'string' },
		rt.ArrayItem{ key: 'default', val: 'date' },
		rt.ArrayItem{ key: 'enum', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'date' },
		]) },
		rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' },
	]))
	var_params.array_set('force_cache_refresh', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Force retrieval of fresh data instead of from the cache.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'boolean' },
		rt.ArrayItem{ key: 'sanitize_callback', val: 'wp_validate_boolean' },
		rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' },
	]))
	return var_params.clone()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_GenericController) get_items(var_request rt.PhpVal) rt.PhpVal {
	mut var_query_args := this.prepare_reports_query(var_request.clone())
	mut var_report_data := this.get_datastore_data(var_query_args.clone())
	if rt.is_true(rt.call_function('is_wp_error', [var_report_data.clone()])) {
		return var_report_data.clone()
	}
	if !(!(rt.get_property(var_report_data, 'data')).is_null())
		|| !(!(rt.get_property(var_report_data, 'page_no')).is_null())
		|| !(!(rt.get_property(var_report_data, 'pages')).is_null()) {
		return rt.new_object('Automattic_WooCommerce_Admin_API_Reports_WP_Error', []string{}, create_automattic_woocommerce_admin_api_reports_wp_error(rt.new_string('woocommerce_rest_reports_invalid_response'), rt.call_function('__', [
			rt.new_string('Invalid response from data store.'),
			rt.new_string('woocommerce'),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 500 }])))
	}
	mut var_out_data := rt.new_array()
	mut iter_1 := rt.get_property(var_report_data, 'data').iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_datum := item_1.val
		mut var_item := this.prepare_item_for_response(var_datum.clone(), var_request.clone())
		var_out_data.array_push(this.prepare_response_for_collection(var_item.clone()))
	}
	return this.add_pagination_headers(var_request.clone(), var_out_data.clone(), rt.new_int((rt.get_property(var_report_data,
		'total')).to_i64()), rt.new_int((rt.get_property(var_report_data, 'page_no')).to_i64()), rt.new_int((rt.get_property(var_report_data,
		'pages')).to_i64()))
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_GenericController) prepare_item_for_response(var_report_item rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
	mut var_data := var_report_item
	mut var_context := if !(!rt.is_true(var_request.array_get(rt.new_string('context')))) {
		var_request.array_get(rt.new_string('context'))
	} else {
		rt.new_string('view')
	}
	var_data = this.add_additional_fields_to_object(var_data.clone(), var_request.clone())
	var_data = this.filter_response_by_context(var_data.clone(), var_context.clone())
	return rt.call_function('rest_ensure_response', [var_data.clone()])
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_GenericController) prepare_reports_query(var_request rt.PhpVal) rt.PhpVal {
	mut var_args := rt.call_function('wp_parse_args', [
		rt.call_function('array_intersect_key', [
			rt.call_method(var_request, 'get_query_params', []rt.PhpVal{}),
			this.get_collection_params(),
		]),
		rt.call_method(var_request, 'get_default_params', []rt.PhpVal{}),
	])
	return var_args.clone()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_GenericController) apply_custom_orderby_filters(var_orderby_enum rt.PhpVal) rt.PhpVal {
	return rt.call_function('apply_filters', [
		rt.concat(rt.new_string('woocommerce_analytics_orderby_enum_'), rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_GenericController', [
			'Automattic_WooCommerce_Admin_API_Reports_WC_REST_Reports_Controller',
		], &this), 'rest_base')),
		var_orderby_enum.clone(),
	])
}

struct Class_Automattic_WooCommerce_Admin_API_Reports_WC_REST_Reports_Controller {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_API_Reports_WC_Data_Store {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_API_Reports_WP_Error {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_api_reports_genericcontroller(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_API_Reports_GenericController {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_GenericController{
		PhpObjectBase: rt.PhpObjectBase{}
		namespace:     rt.new_string('wc-analytics')
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_reports_wc_rest_reports_controller(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_API_Reports_WC_REST_Reports_Controller {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_WC_REST_Reports_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_reports_wc_data_store(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_API_Reports_WC_Data_Store {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_WC_Data_Store{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_reports_wp_error(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_API_Reports_WP_Error {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_GenericController) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'add_pagination_headers' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_i64()
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).to_i64()
			dispatch_arg_4 := (if args.len > 4 { args[4] } else { rt.new_null() }).to_i64()
			return this.add_pagination_headers(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2,
				dispatch_arg_3, dispatch_arg_4)
		}
		'get_datastore_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_datastore_data(dispatch_arg_0)
		}
		'get_collection_params' {
			return this.get_collection_params()
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
		'prepare_reports_query' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.prepare_reports_query(dispatch_arg_0)
		}
		'apply_custom_orderby_filters' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.apply_custom_orderby_filters(dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_API_Reports_GenericController) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'namespace' { return this.namespace }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_GenericController) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'namespace' {
			this.namespace = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_WC_REST_Reports_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_API_Reports_WC_REST_Reports_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_WC_REST_Reports_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_WC_Data_Store) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_API_Reports_WC_Data_Store) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_WC_Data_Store) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_WP_Error) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_API_Reports_WP_Error) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_WP_Error) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}
