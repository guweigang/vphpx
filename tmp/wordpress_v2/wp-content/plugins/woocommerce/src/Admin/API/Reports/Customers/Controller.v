import rt

struct Class_Automattic_WooCommerce_Admin_API_Reports_Customers_Controller {
	rt.PhpObjectBase
pub mut:
	rest_base rt.PhpVal = rt.new_string('reports/customers')
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Customers_Controller) get_datastore_data(var_query_args rt.PhpVal) rt.PhpVal {
	mut var_query_args_mutated := var_query_args
	mut var_query :=
		create_automattic_woocommerce_admin_api_reports_customers_query(var_query_args_mutated.clone())
	return var_query.get_data()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Customers_Controller) prepare_reports_query(var_request rt.PhpVal) rt.PhpVal {
	mut var_args := rt.new_array()
	var_args.array_set('registered_before',
		var_request.array_get(rt.new_string('registered_before')))
	var_args.array_set('registered_after', var_request.array_get(rt.new_string('registered_after')))
	var_args.array_set('order_before', var_request.array_get(rt.new_string('before')))
	var_args.array_set('order_after', var_request.array_get(rt.new_string('after')))
	var_args.array_set('page', var_request.array_get(rt.new_string('page')))
	var_args.array_set('per_page', var_request.array_get(rt.new_string('per_page')))
	var_args.array_set('order', var_request.array_get(rt.new_string('order')))
	var_args.array_set('orderby', var_request.array_get(rt.new_string('orderby')))
	var_args.array_set('match', var_request.array_get(rt.new_string('match')))
	var_args.array_set('search', var_request.array_get(rt.new_string('search')))
	var_args.array_set('searchby', var_request.array_get(rt.new_string('searchby')))
	var_args.array_set('name_includes', var_request.array_get(rt.new_string('name_includes')))
	var_args.array_set('name_excludes', var_request.array_get(rt.new_string('name_excludes')))
	var_args.array_set('username_includes',
		var_request.array_get(rt.new_string('username_includes')))
	var_args.array_set('username_excludes',
		var_request.array_get(rt.new_string('username_excludes')))
	var_args.array_set('email_includes', var_request.array_get(rt.new_string('email_includes')))
	var_args.array_set('email_excludes', var_request.array_get(rt.new_string('email_excludes')))
	var_args.array_set('country_includes', var_request.array_get(rt.new_string('country_includes')))
	var_args.array_set('country_excludes', var_request.array_get(rt.new_string('country_excludes')))
	var_args.array_set('last_active_before',
		var_request.array_get(rt.new_string('last_active_before')))
	var_args.array_set('last_active_after',
		var_request.array_get(rt.new_string('last_active_after')))
	var_args.array_set('orders_count_min', var_request.array_get(rt.new_string('orders_count_min')))
	var_args.array_set('orders_count_max', var_request.array_get(rt.new_string('orders_count_max')))
	var_args.array_set('total_spend_min', var_request.array_get(rt.new_string('total_spend_min')))
	var_args.array_set('total_spend_max', var_request.array_get(rt.new_string('total_spend_max')))
	var_args.array_set('avg_order_value_min',
		var_request.array_get(rt.new_string('avg_order_value_min')))
	var_args.array_set('avg_order_value_max',
		var_request.array_get(rt.new_string('avg_order_value_max')))
	var_args.array_set('last_order_before',
		var_request.array_get(rt.new_string('last_order_before')))
	var_args.array_set('last_order_after', var_request.array_get(rt.new_string('last_order_after')))
	var_args.array_set('customers', var_request.array_get(rt.new_string('customers')))
	var_args.array_set('customers_exclude',
		var_request.array_get(rt.new_string('customers_exclude')))
	var_args.array_set('users', var_request.array_get(rt.new_string('users')))
	var_args.array_set('force_cache_refresh',
		var_request.array_get(rt.new_string('force_cache_refresh')))
	var_args.array_set('filter_empty', var_request.array_get(rt.new_string('filter_empty')))
	var_args.array_set('user_type', var_request.array_get(rt.new_string('user_type')))
	var_args.array_set('location_includes',
		var_request.array_get(rt.new_string('location_includes')))
	var_args.array_set('location_excludes',
		var_request.array_get(rt.new_string('location_excludes')))
	mut var_between_params_numeric := rt.create_array([
		rt.ArrayItem{ key: none, val: 'orders_count' },
		rt.ArrayItem{ key: none, val: 'total_spend' },
		rt.ArrayItem{ key: none, val: 'avg_order_value' },
	])
	mut iife_temp_0 := Class_Automattic_WooCommerce_Admin_API_Reports_TimeInterval{}
	mut iife_result_0 := iife_temp_0.normalize_between_params(var_request.clone(),
		var_between_params_numeric.clone(), rt.new_bool(false))
	mut var_normalized_params_numeric := iife_result_0
	mut var_between_params_date := rt.create_array([
		rt.ArrayItem{ key: none, val: 'last_active' },
		rt.ArrayItem{ key: none, val: 'registered' },
	])
	mut iife_temp_1 := Class_Automattic_WooCommerce_Admin_API_Reports_TimeInterval{}
	mut iife_result_1 := iife_temp_1.normalize_between_params(var_request.clone(),
		var_between_params_date.clone(), rt.new_bool(true))
	mut var_normalized_params_date := iife_result_1
	var_args = rt.call_function('array_merge', [var_args.clone(),
		var_normalized_params_numeric.clone(), var_normalized_params_date.clone()])
	var_args =
		Class_Automattic_WooCommerce_Admin_API_Reports_Customers_Controller.consolidate_customer_id_filters(var_args.clone())
	return var_args.clone()
}

fn Class_Automattic_WooCommerce_Admin_API_Reports_Customers_Controller.consolidate_customer_id_filters(var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
	mut var_include_params := rt.create_array([
		rt.ArrayItem{ key: none, val: 'name_includes' },
		rt.ArrayItem{ key: none, val: 'email_includes' },
		rt.ArrayItem{ key: none, val: 'username_includes' },
	])
	mut var_exclude_params := rt.create_array([
		rt.ArrayItem{ key: none, val: 'name_excludes' },
		rt.ArrayItem{ key: none, val: 'email_excludes' },
		rt.ArrayItem{ key: none, val: 'username_excludes' },
	])
	mut var_match := if !(var_args_mutated.array_get(rt.new_string('match'))).is_null() {
		var_args_mutated.array_get(rt.new_string('match'))
	} else {
		rt.new_string('all')
	}
	mut var_include_sets := rt.new_array()
	mut iter_1 := var_include_params.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_param := item_1.val
		if !(!rt.is_true(var_args_mutated.array_get(var_param)))
			&& rt.is_true(Class_Automattic_WooCommerce_Admin_API_Reports_Customers_Controller.is_id_list(var_args_mutated.array_get(var_param))) {
			var_include_sets.array_push(rt.call_function('wp_parse_id_list', [
				var_args_mutated.array_get(var_param),
			]))
			var_args_mutated.array_set(var_param, rt.new_null())
		}
	}
	if !(!rt.is_true(var_include_sets)) {
		mut var_consolidated := if var_include_sets.clone().array_count() > 1 {
			if rt.is_true(rt.identical(rt.new_string('all'), var_match)) { rt.call_function('call_user_func_array', [
					rt.new_string('array_intersect'),
					var_include_sets.clone(),
				]) } else { rt.call_function('array_unique', [
					rt.call_function('array_merge', [var_include_sets.clone()]),
				]) }
		} else {
			var_include_sets.array_get(rt.new_int(0))
		}
		if !(!rt.is_true(var_args_mutated.array_get(rt.new_string('customers')))) {
			mut var_existing := rt.call_function('wp_parse_id_list', [
				var_args_mutated.array_get(rt.new_string('customers')),
			])
			var_consolidated = if rt.is_true(rt.identical(rt.new_string('all'), var_match)) { rt.call_function('array_intersect', [
					var_consolidated.clone(),
					var_existing.clone(),
				]) } else { rt.call_function('array_unique', [
					rt.call_function('array_merge', [var_consolidated.clone(),
						var_existing.clone()]),
				]) }
		}
		var_args_mutated.array_set('customers', if !rt.is_true(var_consolidated) { rt.create_array([
				rt.ArrayItem{ key: none, val: 0 },
			]) } else { rt.call_function('array_values', [var_consolidated.clone()]) })
	}
	mut var_exclude_sets := rt.new_array()
	mut iter_2 := var_exclude_params.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_param := item_2.val
		if !(!rt.is_true(var_args_mutated.array_get(var_param)))
			&& rt.is_true(Class_Automattic_WooCommerce_Admin_API_Reports_Customers_Controller.is_id_list(var_args_mutated.array_get(var_param))) {
			var_exclude_sets.array_push(rt.call_function('wp_parse_id_list', [
				var_args_mutated.array_get(var_param),
			]))
			var_args_mutated.array_set(var_param, rt.new_null())
		}
	}
	if !(!rt.is_true(var_exclude_sets)) {
		var_consolidated = if var_exclude_sets.clone().array_count() > 1 {
			if rt.is_true(rt.identical(rt.new_string('all'), var_match)) { rt.call_function('array_unique', [
					rt.call_function('array_merge', [var_exclude_sets.clone()]),
				]) } else { rt.call_function('call_user_func_array', [
					rt.new_string('array_intersect'),
					var_exclude_sets.clone(),
				]) }
		} else {
			var_exclude_sets.array_get(rt.new_int(0))
		}
		if !(!rt.is_true(var_args_mutated.array_get(rt.new_string('customers_exclude')))) {
			var_existing = rt.call_function('wp_parse_id_list', [
				var_args_mutated.array_get(rt.new_string('customers_exclude')),
			])
			var_consolidated = rt.call_function('array_unique', [
				rt.call_function('array_merge', [var_consolidated.clone(),
					var_existing.clone()]),
			])
		}
		var_args_mutated.array_set('customers_exclude', rt.call_function('array_values', [
			var_consolidated.clone(),
		]))
	}
	return var_args_mutated.clone()
}

fn Class_Automattic_WooCommerce_Admin_API_Reports_Customers_Controller.is_id_list(var_value rt.PhpVal) bool {
	if rt.is_true(rt.new_bool(var_value.clone().is_array())) {
		mut var_values := var_value
	} else if rt.is_true(rt.new_bool(var_value.clone().is_string())) {
		var_values = rt.call_function('explode', [rt.new_string(','),
			var_value.clone()])
	} else {
		return false
	}
	mut iter_3 := var_values.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_v := item_3.val
		if !(rt.new_string(var_v.clone().to_string().trim_space()).is_long()
			|| rt.new_string(var_v.clone().to_string().trim_space()).is_double()) {
			return false
		}
	}
	return true
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Customers_Controller) get_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_query_args := this.prepare_reports_query(var_request.clone())
	var_query_args.array_set('customers', rt.create_array([
		rt.ArrayItem{ key: none, val: rt.call_method(var_request, 'get_param', [
			rt.new_string('id'),
		]) },
	]))
	mut var_customers_query :=
		create_automattic_woocommerce_admin_api_reports_customers_query(var_query_args.clone())
	mut var_report_data := var_customers_query.get_data()
	mut var_data := rt.new_array()
	mut iter_4 := rt.get_property(var_report_data, 'data').iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_customer_data := item_4.val
		mut var_item := this.prepare_item_for_response(var_customer_data.clone(),
			var_request.clone())
		var_data.array_push(this.prepare_response_for_collection(var_item.clone()))
	}
	mut var_response := rt.call_function('rest_ensure_response', [
		var_data.clone()])
	rt.call_method(var_response, 'header', [rt.new_string('X-WP-Total'),
		rt.new_int((rt.get_property(var_report_data, 'total')).to_i64())])
	rt.call_method(var_response, 'header', [rt.new_string('X-WP-TotalPages'),
		rt.new_int((rt.get_property(var_report_data, 'pages')).to_i64())])
	return var_response.clone()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Customers_Controller) prepare_item_for_response(var_report rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
	mut var_context := if !(!rt.is_true(var_request.array_get(rt.new_string('context')))) {
		var_request.array_get(rt.new_string('context'))
	} else {
		rt.new_string('view')
	}
	mut var_data := this.add_additional_fields_to_object(var_report.clone(), var_request.clone())
	var_data.array_set('name', var_data.array_get(rt.new_string('name')).to_string().trim_space())
	var_data.array_set('date_registered_gmt', rt.call_function('wc_rest_prepare_date_response', [
		var_data.array_get(rt.new_string('date_registered')),
	]))
	var_data.array_set('date_registered', rt.call_function('wc_rest_prepare_date_response', [
		var_data.array_get(rt.new_string('date_registered')),
		rt.new_bool(false),
	]))
	var_data.array_set('date_last_active_gmt', rt.call_function('wc_rest_prepare_date_response', [
		var_data.array_get(rt.new_string('date_last_active')),
		rt.new_bool(false),
	]))
	var_data.array_set('date_last_active', rt.call_function('wc_rest_prepare_date_response', [
		var_data.array_get(rt.new_string('date_last_active')),
	]))
	var_data = this.filter_response_by_context(var_data.clone(), var_context.clone())
	mut var_response := rt.call_function('rest_ensure_response', [
		var_data.clone()])
	rt.call_method(var_response, 'add_links', [this.prepare_links(var_report.clone())])
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_rest_prepare_report_customers'),
		var_response.clone(),
		var_report.clone(),
		var_request.clone(),
	])
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Customers_Controller) prepare_links(var_object rt.PhpVal) rt.PhpVal {
	if !rt.is_true(var_object.array_get(rt.new_string('user_id'))) {
		return rt.new_array()
	}
	return rt.create_array([
		rt.ArrayItem{ key: 'customer', val: rt.create_array([
			rt.ArrayItem{ key: 'href', val: rt.call_function('rest_url', [
				rt.call_function('sprintf', [rt.new_string('/%s/customers/%d'),
					rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Customers_Controller', [
						'Automattic_WooCommerce_Admin_API_Reports_GenericController',
						'ExportableInterface',
					], &this), 'namespace'),
					var_object.array_get(rt.new_string('id'))]),
			]) },
		]) },
		rt.ArrayItem{ key: 'collection', val: rt.create_array([
			rt.ArrayItem{ key: 'href', val: rt.call_function('rest_url', [
				rt.call_function('sprintf', [rt.new_string('/%s/customers'),
					rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Customers_Controller', [
						'Automattic_WooCommerce_Admin_API_Reports_GenericController',
						'ExportableInterface',
					], &this), 'namespace')]),
			]) },
		]) },
	])
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Customers_Controller) get_item_schema() rt.PhpVal {
	mut var_schema := rt.create_array([
		rt.ArrayItem{ key: '$schema', val: 'http://json-schema.org/draft-04/schema#' },
		rt.ArrayItem{ key: 'title', val: 'report_customers' },
		rt.ArrayItem{ key: 'type', val: 'object' },
		rt.ArrayItem{ key: 'properties', val: rt.create_array([
			rt.ArrayItem{ key: 'id', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Customer ID.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'integer' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
			]) },
			rt.ArrayItem{ key: 'user_id', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('User ID.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'integer' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
			]) },
			rt.ArrayItem{ key: 'name', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Name.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
			]) },
			rt.ArrayItem{ key: 'first_name', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('First name.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
			]) },
			rt.ArrayItem{ key: 'last_name', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Last name.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
			]) },
			rt.ArrayItem{ key: 'email', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Email address.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
			]) },
			rt.ArrayItem{ key: 'username', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Username.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
			]) },
			rt.ArrayItem{ key: 'country', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Country / Region.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
			]) },
			rt.ArrayItem{ key: 'city', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('City.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
			]) },
			rt.ArrayItem{ key: 'state', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Region.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
			]) },
			rt.ArrayItem{ key: 'postcode', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Postal code.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
			]) },
			rt.ArrayItem{ key: 'date_registered', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Date registered.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'date-time' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
			]) },
			rt.ArrayItem{ key: 'date_registered_gmt', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Date registered GMT.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'date-time' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
			]) },
			rt.ArrayItem{ key: 'date_last_active', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Date last active.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'date-time' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
			]) },
			rt.ArrayItem{ key: 'date_last_active_gmt', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Date last active GMT.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'date-time' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
			]) },
			rt.ArrayItem{ key: 'orders_count', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Order count.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'integer' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
			]) },
			rt.ArrayItem{ key: 'total_spend', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Total spend.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'number' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
			]) },
			rt.ArrayItem{ key: 'avg_order_value', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Avg order value.'),
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

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Customers_Controller) get_collection_params() rt.PhpVal {
	mut var_params :=
		this.Class_Automattic_WooCommerce_Admin_API_Reports_GenericController.get_collection_params()
	var_params.array_set('registered_before', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Limit response to objects registered before (or at) a given ISO8601 compliant datetime.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'string' },
		rt.ArrayItem{ key: 'format', val: 'date-time' },
		rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' },
	]))
	var_params.array_set('registered_after', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Limit response to objects registered after (or at) a given ISO8601 compliant datetime.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'string' },
		rt.ArrayItem{ key: 'format', val: 'date-time' },
		rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' },
	]))
	var_params.array_get_mut('orderby').array_set('default', 'date_registered')
	var_params.array_get_mut('orderby').array_set('enum', this.apply_custom_orderby_filters(rt.create_array([
		rt.ArrayItem{ key: none, val: 'username' },
		rt.ArrayItem{ key: none, val: 'name' },
		rt.ArrayItem{ key: none, val: 'first_name' },
		rt.ArrayItem{ key: none, val: 'last_name' },
		rt.ArrayItem{ key: none, val: 'email' },
		rt.ArrayItem{ key: none, val: 'location' },
		rt.ArrayItem{ key: none, val: 'country' },
		rt.ArrayItem{ key: none, val: 'city' },
		rt.ArrayItem{ key: none, val: 'state' },
		rt.ArrayItem{ key: none, val: 'postcode' },
		rt.ArrayItem{ key: none, val: 'date_registered' },
		rt.ArrayItem{ key: none, val: 'date_last_active' },
		rt.ArrayItem{ key: none, val: 'orders_count' },
		rt.ArrayItem{ key: none, val: 'total_spend' },
		rt.ArrayItem{ key: none, val: 'avg_order_value' },
	])))
	var_params.array_set('match', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Indicates whether all the conditions should be true for the resulting set, or if any one of them is sufficient. Match affects the following parameters: status_is, status_is_not, product_includes, product_excludes, coupon_includes, coupon_excludes, customer, categories'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'string' },
		rt.ArrayItem{ key: 'default', val: 'all' },
		rt.ArrayItem{ key: 'enum', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'all' },
			rt.ArrayItem{ key: none, val: 'any' },
		]) },
		rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' },
	]))
	var_params.array_set('search', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Limit response to objects with a customer field containing the search term. Searches the field provided by `searchby`.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'string' },
		rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' },
	]))
	var_params.array_set('searchby', rt.create_array([
		rt.ArrayItem{
			key: 'description'
			val: 'Limit results with `search` and `searchby` to specific fields containing the search term.'
		},
		rt.ArrayItem{ key: 'type', val: 'string' },
		rt.ArrayItem{ key: 'default', val: 'name' },
		rt.ArrayItem{ key: 'enum', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'name' },
			rt.ArrayItem{ key: none, val: 'username' },
			rt.ArrayItem{ key: none, val: 'email' },
			rt.ArrayItem{ key: none, val: 'all' },
		]) },
	]))
	var_params.array_set('name_includes', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Limit response to objects with specific names.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'string' },
		rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' },
	]))
	var_params.array_set('name_excludes', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Limit response to objects excluding specific names.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'string' },
		rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' },
	]))
	var_params.array_set('username_includes', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Limit response to objects with specific usernames.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'string' },
		rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' },
	]))
	var_params.array_set('username_excludes', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Limit response to objects excluding specific usernames.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'string' },
		rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' },
	]))
	var_params.array_set('email_includes', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Limit response to objects including emails.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'string' },
		rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' },
	]))
	var_params.array_set('email_excludes', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Limit response to objects excluding emails.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'string' },
		rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' },
	]))
	var_params.array_set('country_includes', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Limit response to objects with specific countries.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'string' },
		rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' },
	]))
	var_params.array_set('country_excludes', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Limit response to objects excluding specific countries.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'string' },
		rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' },
	]))
	var_params.array_set('last_active_before', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Limit response to objects last active before (or at) a given ISO8601 compliant datetime.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'string' },
		rt.ArrayItem{ key: 'format', val: 'date-time' },
		rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' },
	]))
	var_params.array_set('last_active_after', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Limit response to objects last active after (or at) a given ISO8601 compliant datetime.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'string' },
		rt.ArrayItem{ key: 'format', val: 'date-time' },
		rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' },
	]))
	var_params.array_set('last_active_between', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Limit response to objects last active between two given ISO8601 compliant datetime.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'array' },
		rt.ArrayItem{ key: 'validate_callback', val: rt.create_array([
			rt.ArrayItem{
				key: none
				val: '\\Automattic\\WooCommerce\\Admin\\API\\Reports\\TimeInterval'
			},
			rt.ArrayItem{ key: none, val: 'rest_validate_between_date_arg' },
		]) },
		rt.ArrayItem{ key: 'items', val: rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'string' },
		]) },
	]))
	var_params.array_set('registered_before', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Limit response to objects registered before (or at) a given ISO8601 compliant datetime.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'string' },
		rt.ArrayItem{ key: 'format', val: 'date-time' },
		rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' },
	]))
	var_params.array_set('registered_after', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Limit response to objects registered after (or at) a given ISO8601 compliant datetime.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'string' },
		rt.ArrayItem{ key: 'format', val: 'date-time' },
		rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' },
	]))
	var_params.array_set('registered_between', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Limit response to objects last active between two given ISO8601 compliant datetime.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'array' },
		rt.ArrayItem{ key: 'validate_callback', val: rt.create_array([
			rt.ArrayItem{
				key: none
				val: '\\Automattic\\WooCommerce\\Admin\\API\\Reports\\TimeInterval'
			},
			rt.ArrayItem{ key: none, val: 'rest_validate_between_date_arg' },
		]) },
		rt.ArrayItem{ key: 'items', val: rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'string' },
		]) },
	]))
	var_params.array_set('orders_count_min', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Limit response to objects with an order count greater than or equal to given integer.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'integer' },
		rt.ArrayItem{ key: 'sanitize_callback', val: 'absint' },
		rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' },
	]))
	var_params.array_set('orders_count_max', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Limit response to objects with an order count less than or equal to given integer.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'integer' },
		rt.ArrayItem{ key: 'sanitize_callback', val: 'absint' },
		rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' },
	]))
	var_params.array_set('orders_count_between', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Limit response to objects with an order count between two given integers.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'array' },
		rt.ArrayItem{ key: 'validate_callback', val: rt.create_array([
			rt.ArrayItem{
				key: none
				val: '\\Automattic\\WooCommerce\\Admin\\API\\Reports\\TimeInterval'
			},
			rt.ArrayItem{ key: none, val: 'rest_validate_between_numeric_arg' },
		]) },
		rt.ArrayItem{ key: 'items', val: rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'integer' },
		]) },
	]))
	var_params.array_set('total_spend_min', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Limit response to objects with a total order spend greater than or equal to given number.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'number' },
		rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' },
	]))
	var_params.array_set('total_spend_max', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Limit response to objects with a total order spend less than or equal to given number.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'number' },
		rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' },
	]))
	var_params.array_set('total_spend_between', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Limit response to objects with a total order spend between two given numbers.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'array' },
		rt.ArrayItem{ key: 'validate_callback', val: rt.create_array([
			rt.ArrayItem{
				key: none
				val: '\\Automattic\\WooCommerce\\Admin\\API\\Reports\\TimeInterval'
			},
			rt.ArrayItem{ key: none, val: 'rest_validate_between_numeric_arg' },
		]) },
		rt.ArrayItem{ key: 'items', val: rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'integer' },
		]) },
	]))
	var_params.array_set('avg_order_value_min', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Limit response to objects with an average order spend greater than or equal to given number.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'number' },
		rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' },
	]))
	var_params.array_set('avg_order_value_max', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Limit response to objects with an average order spend less than or equal to given number.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'number' },
		rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' },
	]))
	var_params.array_set('avg_order_value_between', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Limit response to objects with an average order spend between two given numbers.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'array' },
		rt.ArrayItem{ key: 'validate_callback', val: rt.create_array([
			rt.ArrayItem{
				key: none
				val: '\\Automattic\\WooCommerce\\Admin\\API\\Reports\\TimeInterval'
			},
			rt.ArrayItem{ key: none, val: 'rest_validate_between_numeric_arg' },
		]) },
		rt.ArrayItem{ key: 'items', val: rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'integer' },
		]) },
	]))
	var_params.array_set('last_order_before', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Limit response to objects with last order before (or at) a given ISO8601 compliant datetime.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'string' },
		rt.ArrayItem{ key: 'format', val: 'date-time' },
		rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' },
	]))
	var_params.array_set('last_order_after', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Limit response to objects with last order after (or at) a given ISO8601 compliant datetime.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'string' },
		rt.ArrayItem{ key: 'format', val: 'date-time' },
		rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' },
	]))
	var_params.array_set('customers', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Limit result to items with specified customer ids.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'array' },
		rt.ArrayItem{ key: 'sanitize_callback', val: 'wp_parse_id_list' },
		rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' },
		rt.ArrayItem{ key: 'items', val: rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'integer' },
		]) },
	]))
	var_params.array_set('customers_exclude', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Limit result to exclude items with specified customer ids.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'array' },
		rt.ArrayItem{ key: 'sanitize_callback', val: 'wp_parse_id_list' },
		rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' },
		rt.ArrayItem{ key: 'items', val: rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'integer' },
		]) },
	]))
	var_params.array_set('users', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Limit result to items with specified user ids.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'array' },
		rt.ArrayItem{ key: 'sanitize_callback', val: 'wp_parse_id_list' },
		rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' },
		rt.ArrayItem{ key: 'items', val: rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'integer' },
		]) },
	]))
	var_params.array_set('filter_empty', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Filter out results where any of the passed fields are empty'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'array' },
		rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' },
		rt.ArrayItem{ key: 'items', val: rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'string' },
			rt.ArrayItem{ key: 'enum', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'email' },
				rt.ArrayItem{ key: none, val: 'name' },
				rt.ArrayItem{ key: none, val: 'country' },
				rt.ArrayItem{ key: none, val: 'city' },
				rt.ArrayItem{ key: none, val: 'state' },
				rt.ArrayItem{ key: none, val: 'postcode' },
			]) },
		]) },
	]))
	var_params.array_set('user_type', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Limit result to items with specified user type.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'string' },
		rt.ArrayItem{ key: 'default', val: 'all' },
		rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' },
		rt.ArrayItem{ key: 'enum', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'all' },
			rt.ArrayItem{ key: none, val: 'registered' },
			rt.ArrayItem{ key: none, val: 'guest' },
		]) },
	]))
	var_params.array_set('location_includes', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Includes customers by location (state, country). Provide a comma-separated list of locations. Each location can be a country code (e.g. GB) or combination of country and state (e.g. US:CA).'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'string' },
		rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' },
	]))
	var_params.array_set('location_excludes', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Excludes customers by location (state, country). Provide a comma-separated list of locations. Each location can be a country code (e.g. GB) or combination of country and state (e.g. US:CA).'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'string' },
		rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' },
	]))
	return var_params.clone()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Customers_Controller) get_export_columns() rt.PhpVal {
	mut var_export_columns := rt.create_array([
		rt.ArrayItem{ key: 'name', val: rt.call_function('__', [
			rt.new_string('Name'), rt.new_string('woocommerce')]) },
		rt.ArrayItem{ key: 'username', val: rt.call_function('__', [
			rt.new_string('Username'), rt.new_string('woocommerce')]) },
		rt.ArrayItem{ key: 'last_active', val: rt.call_function('__', [
			rt.new_string('Last Active'), rt.new_string('woocommerce')]) },
		rt.ArrayItem{ key: 'registered', val: rt.call_function('__', [
			rt.new_string('Sign Up'), rt.new_string('woocommerce')]) },
		rt.ArrayItem{ key: 'email', val: rt.call_function('__', [
			rt.new_string('Email'), rt.new_string('woocommerce')]) },
		rt.ArrayItem{ key: 'orders_count', val: rt.call_function('__', [
			rt.new_string('Orders'), rt.new_string('woocommerce')]) },
		rt.ArrayItem{ key: 'total_spend', val: rt.call_function('__', [
			rt.new_string('Total Spend'), rt.new_string('woocommerce')]) },
		rt.ArrayItem{ key: 'avg_order_value', val: rt.call_function('__', [
			rt.new_string('AOV'), rt.new_string('woocommerce')]) },
		rt.ArrayItem{ key: 'country', val: rt.call_function('__', [
			rt.new_string('Country / Region'), rt.new_string('woocommerce')]) },
		rt.ArrayItem{ key: 'city', val: rt.call_function('__', [
			rt.new_string('City'), rt.new_string('woocommerce')]) },
		rt.ArrayItem{ key: 'region', val: rt.call_function('__', [
			rt.new_string('Region'), rt.new_string('woocommerce')]) },
		rt.ArrayItem{ key: 'postcode', val: rt.call_function('__', [
			rt.new_string('Postal Code'), rt.new_string('woocommerce')]) },
	])
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_report_customers_export_columns'),
		var_export_columns.clone(),
	])
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Customers_Controller) prepare_item_for_export(var_item rt.PhpVal) rt.PhpVal {
	mut var_item_mutated := var_item
	mut iife_temp_2 := Class_Automattic_WooCommerce_Admin_API_Reports_Customers_Controller{}
	mut iife_result_2 :=
		iife_temp_2.csv_number_format(var_item_mutated.array_get(rt.new_string('total_spend')))
	mut iife_temp_3 := Class_Automattic_WooCommerce_Admin_API_Reports_Customers_Controller{}
	mut iife_result_3 :=
		iife_temp_3.csv_number_format(var_item_mutated.array_get(rt.new_string('avg_order_value')))
	mut var_export_item := rt.create_array([
		rt.ArrayItem{ key: 'name', val: var_item_mutated.array_get(rt.new_string('name')) },
		rt.ArrayItem{ key: 'username', val: var_item_mutated.array_get(rt.new_string('username')) },
		rt.ArrayItem{
			key: 'last_active'
			val: var_item_mutated.array_get(rt.new_string('date_last_active'))
		},
		rt.ArrayItem{
			key: 'registered'
			val: var_item_mutated.array_get(rt.new_string('date_registered'))
		},
		rt.ArrayItem{ key: 'email', val: var_item_mutated.array_get(rt.new_string('email')) },
		rt.ArrayItem{
			key: 'orders_count'
			val: var_item_mutated.array_get(rt.new_string('orders_count'))
		},
		rt.ArrayItem{ key: 'total_spend', val: iife_result_2 },
		rt.ArrayItem{ key: 'avg_order_value', val: iife_result_3 },
		rt.ArrayItem{ key: 'country', val: var_item_mutated.array_get(rt.new_string('country')) },
		rt.ArrayItem{ key: 'city', val: var_item_mutated.array_get(rt.new_string('city')) },
		rt.ArrayItem{ key: 'region', val: var_item_mutated.array_get(rt.new_string('state')) },
		rt.ArrayItem{ key: 'postcode', val: var_item_mutated.array_get(rt.new_string('postcode')) },
	])
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_report_customers_prepare_export_item'),
		var_export_item.clone(),
		var_item_mutated.clone(),
	])
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

fn create_automattic_woocommerce_admin_api_reports_customers_controller(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_API_Reports_Customers_Controller {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_Customers_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
		rest_base:     rt.new_string('reports/customers')
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_reports_genericcontroller(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_API_Reports_GenericController {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_GenericController{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_reports_customers_query(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_API_Reports_Customers_Query {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_Customers_Query{
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
		else {
			return none
		}
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
		'rest_base' {
			this.rest_base = val
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

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}
