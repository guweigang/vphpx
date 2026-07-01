import rt

struct Class_Automattic_WooCommerce_Admin_API_Reports_Customers_Controller {
	rt.PhpObjectBase
pub mut:
		rest_base rt.PhpVal = rt.new_string('reports/customers')
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Customers_Controller) get_datastore_data(var_query_args rt.PhpVal) rt.PhpVal {
	mut var_query_args_mutated := var_query_args
	mut var_query := create_automattic_woocommerce_admin_api_reports_customers_query(var_query_args_mutated.dup())
	return var_query.get_data()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Customers_Controller) prepare_reports_query(var_request rt.PhpVal) rt.PhpVal {
	mut var_args := rt.new_array()
	var_args.array_set('registered_before', var_request.array_get('registered_before'))
	var_args.array_set('registered_after', var_request.array_get('registered_after'))
	var_args.array_set('order_before', var_request.array_get('before'))
	var_args.array_set('order_after', var_request.array_get('after'))
	var_args.array_set('page', var_request.array_get('page'))
	var_args.array_set('per_page', var_request.array_get('per_page'))
	var_args.array_set('order', var_request.array_get('order'))
	var_args.array_set('orderby', var_request.array_get('orderby'))
	var_args.array_set('match', var_request.array_get('match'))
	var_args.array_set('search', var_request.array_get('search'))
	var_args.array_set('searchby', var_request.array_get('searchby'))
	var_args.array_set('name_includes', var_request.array_get('name_includes'))
	var_args.array_set('name_excludes', var_request.array_get('name_excludes'))
	var_args.array_set('username_includes', var_request.array_get('username_includes'))
	var_args.array_set('username_excludes', var_request.array_get('username_excludes'))
	var_args.array_set('email_includes', var_request.array_get('email_includes'))
	var_args.array_set('email_excludes', var_request.array_get('email_excludes'))
	var_args.array_set('country_includes', var_request.array_get('country_includes'))
	var_args.array_set('country_excludes', var_request.array_get('country_excludes'))
	var_args.array_set('last_active_before', var_request.array_get('last_active_before'))
	var_args.array_set('last_active_after', var_request.array_get('last_active_after'))
	var_args.array_set('orders_count_min', var_request.array_get('orders_count_min'))
	var_args.array_set('orders_count_max', var_request.array_get('orders_count_max'))
	var_args.array_set('total_spend_min', var_request.array_get('total_spend_min'))
	var_args.array_set('total_spend_max', var_request.array_get('total_spend_max'))
	var_args.array_set('avg_order_value_min', var_request.array_get('avg_order_value_min'))
	var_args.array_set('avg_order_value_max', var_request.array_get('avg_order_value_max'))
	var_args.array_set('last_order_before', var_request.array_get('last_order_before'))
	var_args.array_set('last_order_after', var_request.array_get('last_order_after'))
	var_args.array_set('customers', var_request.array_get('customers'))
	var_args.array_set('customers_exclude', var_request.array_get('customers_exclude'))
	var_args.array_set('users', var_request.array_get('users'))
	var_args.array_set('force_cache_refresh', var_request.array_get('force_cache_refresh'))
	var_args.array_set('filter_empty', var_request.array_get('filter_empty'))
	var_args.array_set('user_type', var_request.array_get('user_type'))
	var_args.array_set('location_includes', var_request.array_get('location_includes'))
	var_args.array_set('location_excludes', var_request.array_get('location_excludes'))
	mut var_between_params_numeric := rt.create_array([rt.ArrayItem{ key: none, val: 'orders_count' }, rt.ArrayItem{ key: none, val: 'total_spend' }, rt.ArrayItem{ key: none, val: 'avg_order_value' }])
	mut var_normalized_params_numeric := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_API_Reports_TimeInterval{}; return temp.normalize_between_params(arg_0, arg_1, arg_2) }(var_request.dup(), var_between_params_numeric.dup(), rt.new_bool(false))
	mut var_between_params_date := rt.create_array([rt.ArrayItem{ key: none, val: 'last_active' }, rt.ArrayItem{ key: none, val: 'registered' }])
	mut var_normalized_params_date := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_API_Reports_TimeInterval{}; return temp.normalize_between_params(arg_0, arg_1, arg_2) }(var_request.dup(), var_between_params_date.dup(), rt.new_bool(true))
	var_args = rt.call_function('array_merge', [var_args.dup(), var_normalized_params_numeric.dup(), var_normalized_params_date.dup()])
	var_args = Class_Automattic_WooCommerce_Admin_API_Reports_Customers_Controller.consolidate_customer_id_filters(var_args.dup())
	return var_args.dup()
}

fn Class_Automattic_WooCommerce_Admin_API_Reports_Customers_Controller.consolidate_customer_id_filters(var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
	mut var_include_params := rt.create_array([rt.ArrayItem{ key: none, val: 'name_includes' }, rt.ArrayItem{ key: none, val: 'email_includes' }, rt.ArrayItem{ key: none, val: 'username_includes' }])
	mut var_exclude_params := rt.create_array([rt.ArrayItem{ key: none, val: 'name_excludes' }, rt.ArrayItem{ key: none, val: 'email_excludes' }, rt.ArrayItem{ key: none, val: 'username_excludes' }])
	mut var_match := if !(var_args_mutated.array_get('match')).is_null() { var_args_mutated.array_get('match') } else { rt.new_string('all') }
	mut var_include_sets := rt.new_array()
	{
		mut iter_1 := var_include_params.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_param := item_1.val
			if rt.is_true(rt.new_bool(!(!rt.is_true(var_args_mutated.array_get(var_param))) && rt.is_true(Class_Automattic_WooCommerce_Admin_API_Reports_Customers_Controller.is_id_list(var_args_mutated.array_get(var_param))))) {
				var_include_sets.array_push(rt.call_function('wp_parse_id_list', [var_args_mutated.array_get(var_param)]))
				var_args_mutated.array_set(var_param, rt.new_null())
			}
		}
	}
	if !(!rt.is_true(var_include_sets)) {
		mut var_consolidated := if var_include_sets.dup().array_count() > 1 { if rt.is_true(rt.identical(rt.new_string('all'), var_match)) { rt.call_function('call_user_func_array', [rt.new_string('array_intersect'), var_include_sets.dup()]) } else { rt.call_function('array_unique', [rt.call_function('array_merge', [var_include_sets.dup()])]) } } else { var_include_sets.array_get(0) }
		if !(!rt.is_true(var_args_mutated.array_get('customers'))) {
			mut var_existing := rt.call_function('wp_parse_id_list', [var_args_mutated.array_get('customers')])
			var_consolidated = if rt.is_true(rt.identical(rt.new_string('all'), var_match)) { rt.call_function('array_intersect', [var_consolidated.dup(), var_existing.dup()]) } else { rt.call_function('array_unique', [rt.call_function('array_merge', [var_consolidated.dup(), var_existing.dup()])]) }
		}
		var_args_mutated.array_set('customers', if !rt.is_true(var_consolidated) { rt.create_array([rt.ArrayItem{ key: none, val: 0 }]) } else { rt.call_function('array_values', [var_consolidated.dup()]) })
	}
	mut var_exclude_sets := rt.new_array()
	{
		mut iter_1 := var_exclude_params.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_param := item_1.val
			if rt.is_true(rt.new_bool(!(!rt.is_true(var_args_mutated.array_get(var_param))) && rt.is_true(Class_Automattic_WooCommerce_Admin_API_Reports_Customers_Controller.is_id_list(var_args_mutated.array_get(var_param))))) {
				var_exclude_sets.array_push(rt.call_function('wp_parse_id_list', [var_args_mutated.array_get(var_param)]))
				var_args_mutated.array_set(var_param, rt.new_null())
			}
		}
	}
	if !(!rt.is_true(var_exclude_sets)) {
		var_consolidated = if var_exclude_sets.dup().array_count() > 1 { if rt.is_true(rt.identical(rt.new_string('all'), var_match)) { rt.call_function('array_unique', [rt.call_function('array_merge', [var_exclude_sets.dup()])]) } else { rt.call_function('call_user_func_array', [rt.new_string('array_intersect'), var_exclude_sets.dup()]) } } else { var_exclude_sets.array_get(0) }
		if !(!rt.is_true(var_args_mutated.array_get('customers_exclude'))) {
			var_existing = rt.call_function('wp_parse_id_list', [var_args_mutated.array_get('customers_exclude')])
			var_consolidated = rt.call_function('array_unique', [rt.call_function('array_merge', [var_consolidated.dup(), var_existing.dup()])])
		}
		var_args_mutated.array_set('customers_exclude', rt.call_function('array_values', [var_consolidated.dup()]))
	}
	return var_args_mutated.dup()
}

fn Class_Automattic_WooCommerce_Admin_API_Reports_Customers_Controller.is_id_list(var_value rt.PhpVal) bool {
	if rt.is_true(rt.new_bool(var_value.dup().is_array())) {
		mut var_values := var_value
	} else if rt.is_true(rt.new_bool(var_value.dup().is_string())) {
		var_values = rt.call_function('explode', [rt.new_string(','), var_value.dup()])
	} else {
		return false
	}
	{
		mut iter_1 := var_values.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_v := item_1.val
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.new_string(var_v.dup().to_string().trim_space()).is_long() || rt.new_string(var_v.dup().to_string().trim_space()).is_double()))))) {
				return false
			}
		}
	}
	return true
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Customers_Controller) get_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_query_args := this.prepare_reports_query(var_request.dup())
	var_query_args.array_set('customers', rt.create_array([rt.ArrayItem{ key: none, val: rt.call_method(var_request, 'get_param', [rt.new_string('id')]) }]))
	mut var_customers_query := create_automattic_woocommerce_admin_api_reports_customers_query(var_query_args.dup())
	mut var_report_data := var_customers_query.get_data()
	mut var_data := rt.new_array()
	{
		mut iter_1 := rt.get_property(var_report_data, 'data').iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_customer_data := item_1.val
			mut var_item := this.prepare_item_for_response(var_customer_data.dup(), var_request.dup())
			var_data.array_push(this.prepare_response_for_collection(var_item.dup()))
		}
	}
	mut var_response := rt.call_function('rest_ensure_response', [var_data.dup()])
	rt.call_method(var_response, 'header', [rt.new_string('X-WP-Total'), // unsupported expression: Expr_Cast_Int])
	rt.call_method(var_response, 'header', [rt.new_string('X-WP-TotalPages'), // unsupported expression: Expr_Cast_Int])
	return var_response.dup()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Customers_Controller) prepare_item_for_response(var_report rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
	mut var_context := if !(!rt.is_true(var_request.array_get('context'))) { var_request.array_get('context') } else { rt.new_string('view') }
	mut var_data := this.add_additional_fields_to_object(var_report.dup(), var_request.dup())
	var_data.array_set('name', var_data.array_get('name').to_string().trim_space())
	var_data.array_set('date_registered_gmt', rt.call_function('wc_rest_prepare_date_response', [var_data.array_get('date_registered')]))
	var_data.array_set('date_registered', rt.call_function('wc_rest_prepare_date_response', [.array_get(), rt.new_bool(false)]))
	var_data.array_set('date_last_active_gmt', rt.call_function('wc_rest_prepare_date_response', [, ]))
	.array_set(, )
	
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Customers_Controller) prepare_links(var_object rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Customers_Controller) get_item_schema() rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Customers_Controller) get_collection_params() rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Customers_Controller) get_export_columns() rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Customers_Controller) prepare_item_for_export(var_item rt.PhpVal) rt.PhpVal {
	mut var_item_mutated := var_item
}

struct Class_Automattic_WooCommerce_Admin_API_Reports_GenericController {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_API_Reports_Customers_Query {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_API_Reports_TimeInterval {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_api_reports_customers_controller() &Class_Automattic_WooCommerce_Admin_API_Reports_Customers_Controller {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_Customers_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
		rest_base: rt.new_string('reports/customers')
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_reports_genericcontroller() &Class_Automattic_WooCommerce_Admin_API_Reports_GenericController {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_GenericController{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_reports_customers_query() &Class_Automattic_WooCommerce_Admin_API_Reports_Customers_Query {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_Customers_Query{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_reports_timeinterval() &Class_Automattic_WooCommerce_Admin_API_Reports_TimeInterval {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_TimeInterval{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Customers_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_datastore_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_datastore_data(dispatch_arg_0)
		}
		'prepare_reports_query' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.prepare_reports_query(dispatch_arg_0)
		}
		'consolidate_customer_id_filters' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Admin_API_Reports_Customers_Controller.consolidate_customer_id_filters(dispatch_arg_0)
		}
		'is_id_list' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(Class_Automattic_WooCommerce_Admin_API_Reports_Customers_Controller.is_id_list(dispatch_arg_0))
		}
		'get_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_item(dispatch_arg_0)
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
		'get_item_schema' {
			return this.get_item_schema()
		}
		'get_collection_params' {
			return this.get_collection_params()
		}
		'get_export_columns' {
			return this.get_export_columns()
		}
		'prepare_item_for_export' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.prepare_item_for_export(dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_API_Reports_Customers_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'rest_base' { return this.rest_base }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Customers_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'rest_base' { this.rest_base = val; return true }
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


fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Customers_Query) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_API_Reports_Customers_Query) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Customers_Query) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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




pub fn init_wp_content_plugins_woocommerce_src_admin_api_reports_customers_controller_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
