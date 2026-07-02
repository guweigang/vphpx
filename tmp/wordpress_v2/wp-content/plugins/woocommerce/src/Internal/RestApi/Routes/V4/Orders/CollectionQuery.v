import rt

struct Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_CollectionQuery {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_CollectionQuery) get_query_schema() rt.PhpVal {
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_param := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_request := if args.len > 1 { args[1].clone() } else { rt.new_null() }
		mut var_key := if args.len > 2 { args[2].clone() } else { rt.new_null() }
		mut var_valid := rt.call_function('rest_validate_request_arg', [
			var_param.clone(), var_request.clone(), var_key.clone()])
		if rt.is_true(rt.identical(rt.new_bool(true), var_valid))
			&& rt.is_true(rt.identical(Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_CollectionQuery.operator_between(), var_param)) {
			mut var_total_field := rt.call_function('wp_parse_list', [
				rt.call_method(var_request, 'get_param', [rt.new_string('total')]),
			])
			if !(var_total_field.clone().is_array())
				|| rt.is_true(rt.new_bool(var_total_field.clone().array_count() != 2)) {
				return create_wp_error(rt.new_string('rest_invalid_param'), rt.call_function('__', [
					rt.new_string('Total value must be an array with exactly 2 numbers for between operators.'),
					rt.new_string('woocommerce'),
				]), rt.create_array([
					rt.ArrayItem{ key: 'status', val: Class_WP_Http.bad_request() },
				]))
			}
		}
		return var_valid.clone()
	}
	mut iife_temp_1 := Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils{}
	mut iife_result_1 := iife_temp_1.get_order_fulfillment_statuses()
	return rt.create_array([
		rt.ArrayItem{ key: 'page', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Current page of the collection.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'integer' },
			rt.ArrayItem{ key: 'default', val: 1 },
			rt.ArrayItem{ key: 'sanitize_callback', val: 'absint' },
			rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' },
			rt.ArrayItem{ key: 'minimum', val: 1 },
		]) },
		rt.ArrayItem{ key: 'per_page', val: rt.create_array([
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
		]) },
		rt.ArrayItem{ key: 'order', val: rt.create_array([
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
		]) },
		rt.ArrayItem{ key: 'orderby', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Sort collection by object attribute.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'string' },
			rt.ArrayItem{ key: 'default', val: 'date' },
			rt.ArrayItem{ key: 'enum', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'date' },
				rt.ArrayItem{ key: none, val: 'id' },
				rt.ArrayItem{ key: none, val: 'include' },
				rt.ArrayItem{ key: none, val: 'title' },
				rt.ArrayItem{ key: none, val: 'slug' },
				rt.ArrayItem{ key: none, val: 'modified' },
				rt.ArrayItem{ key: none, val: 'total' },
			]) },
			rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' },
		]) },
		rt.ArrayItem{ key: 'created_via', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Limit result set to orders created via specific sources (e.g. checkout, admin).'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'array' },
			rt.ArrayItem{ key: 'items', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'string' },
			]) },
			rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' },
			rt.ArrayItem{ key: 'sanitize_callback', val: 'wp_parse_list' },
		]) },
		rt.ArrayItem{ key: 'customer', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Limit result set to orders assigned a specific customer.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'string' },
				rt.ArrayItem{ key: none, val: 'integer' },
			]) },
			rt.ArrayItem{ key: 'sanitize_callback', val: 'sanitize_text_field' },
			rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' },
		]) },
		rt.ArrayItem{ key: 'product', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Limit result set to orders assigned a specific product.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'integer' },
			rt.ArrayItem{ key: 'sanitize_callback', val: 'absint' },
			rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' },
		]) },
		rt.ArrayItem{ key: 'status', val: rt.create_array([
			rt.ArrayItem{ key: 'default', val: 'any' },
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Limit result set to orders which have specific statuses.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'array' },
			rt.ArrayItem{ key: 'items', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'enum', val: rt.call_function('array_map', [
					rt.new_string(
						(Class_Automattic_WooCommerce_Utilities_OrderUtil.class()).str() + '::remove_status_prefix'),
					rt.call_function('array_merge', [
						rt.create_array([rt.ArrayItem{ key: none, val: 'any' },
							rt.ArrayItem{
								key: none
								val: Class_Automattic_WooCommerce_Enums_OrderStatus.trash()
							}]),
						rt.func_array_keys(rt.call_function('wc_get_order_statuses', []rt.PhpVal{})),
					]),
				]) },
			]) },
			rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' },
		]) },
		rt.ArrayItem{ key: 'search', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Limit results to those matching a string.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'string' },
			rt.ArrayItem{ key: 'sanitize_callback', val: 'sanitize_text_field' },
			rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' },
		]) },
		rt.ArrayItem{ key: 'after', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Limit response to resources published after a given ISO8601 compliant date.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'string' },
			rt.ArrayItem{ key: 'format', val: 'date-time' },
			rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' },
		]) },
		rt.ArrayItem{ key: 'before', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Limit response to resources published before a given ISO8601 compliant date.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'string' },
			rt.ArrayItem{ key: 'format', val: 'date-time' },
			rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' },
		]) },
		rt.ArrayItem{ key: 'modified_after', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Limit response to resources modified after a given ISO8601 compliant date.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'string' },
			rt.ArrayItem{ key: 'format', val: 'date-time' },
			rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' },
		]) },
		rt.ArrayItem{ key: 'modified_before', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Limit response to resources modified before a given ISO8601 compliant date.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'string' },
			rt.ArrayItem{ key: 'format', val: 'date-time' },
			rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' },
		]) },
		rt.ArrayItem{ key: 'dates_are_gmt', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Whether to consider GMT post dates when limiting response by published or modified date.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'boolean' },
			rt.ArrayItem{ key: 'default', val: false },
			rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' },
		]) },
		rt.ArrayItem{ key: 'total', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Limit result set to orders with specific total amounts. For between operators, list two values.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'string' },
				rt.ArrayItem{ key: none, val: 'array' },
			]) },
			rt.ArrayItem{ key: 'items', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'string' },
			]) },
			rt.ArrayItem{ key: 'sanitize_callback', val: 'wp_parse_list' },
		]) },
		rt.ArrayItem{ key: 'total_operator', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('The comparison operator to use for total filtering.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'string' },
			rt.ArrayItem{
				key: 'enum'
				val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_CollectionQuery.operators()
			},
			rt.ArrayItem{
				key: 'default'
				val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_CollectionQuery.operator_is()
			},
			rt.ArrayItem{ key: 'validate_callback', val: rt.new_closure(closure_1_fn) },
		]) },
		rt.ArrayItem{ key: 'fulfillment_status', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Limit result set to orders with specific fulfillment statuses.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'array' },
			rt.ArrayItem{ key: 'items', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'enum', val: rt.func_array_keys(iife_result_1) },
			]) },
			rt.ArrayItem{ key: 'sanitize_callback', val: 'wp_parse_list' },
			rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' },
		]) },
	])
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_CollectionQuery) get_query_args(mut var_request Class_WP_REST_Request) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_request_mutated := var_request
	mut var_args := rt.create_array([
		rt.ArrayItem{ key: 'order', val: var_request_mutated.array_get(rt.new_string('order')) },
		rt.ArrayItem{ key: 'orderby', val: var_request_mutated.array_get(rt.new_string('orderby')) },
		rt.ArrayItem{ key: 'page', val: var_request_mutated.array_get(rt.new_string('page')) },
		rt.ArrayItem{
			key: 'posts_per_page'
			val: var_request_mutated.array_get(rt.new_string('per_page'))
		},
		rt.ArrayItem{ key: 's', val: var_request_mutated.array_get(rt.new_string('search')) },
		rt.ArrayItem{
			key: 'created_via'
			val: var_request_mutated.array_get(rt.new_string('created_via'))
		},
		rt.ArrayItem{ key: 'status', val: var_request_mutated.array_get(rt.new_string('status')) },
		rt.ArrayItem{ key: 'customer', val: var_request_mutated.array_get(rt.new_string('customer')) },
	])
	if rt.is_true(rt.identical(rt.new_string('date'), var_args.array_get(rt.new_string('orderby')))) {
		var_args.array_set('orderby', 'date ID')
	}
	mut var_date_query := rt.new_array()
	mut var_use_gmt := var_request_mutated.array_get(rt.new_string('dates_are_gmt'))
	if var_request_mutated.array_isset(rt.new_string('before')) {
		var_date_query.array_push(rt.create_array([
			rt.ArrayItem{
				key: 'column'
				val: if rt.is_true(var_use_gmt) { 'post_date_gmt' } else { 'post_date' }
			},
			rt.ArrayItem{ key: 'before', val: var_request_mutated.array_get(rt.new_string('before')) },
		]))
	}
	if var_request_mutated.array_isset(rt.new_string('after')) {
		var_date_query.array_push(rt.create_array([
			rt.ArrayItem{
				key: 'column'
				val: if rt.is_true(var_use_gmt) { 'post_date_gmt' } else { 'post_date' }
			},
			rt.ArrayItem{ key: 'after', val: var_request_mutated.array_get(rt.new_string('after')) },
		]))
	}
	if var_request_mutated.array_isset(rt.new_string('modified_before')) {
		var_date_query.array_push(rt.create_array([
			rt.ArrayItem{
				key: 'column'
				val: if rt.is_true(var_use_gmt) { 'post_modified_gmt' } else { 'post_modified' }
			},
			rt.ArrayItem{
				key: 'before'
				val: var_request_mutated.array_get(rt.new_string('modified_before'))
			},
		]))
	}
	if var_request_mutated.array_isset(rt.new_string('modified_after')) {
		var_date_query.array_push(rt.create_array([
			rt.ArrayItem{
				key: 'column'
				val: if rt.is_true(var_use_gmt) { 'post_modified_gmt' } else { 'post_modified' }
			},
			rt.ArrayItem{
				key: 'after'
				val: var_request_mutated.array_get(rt.new_string('modified_after'))
			},
		]))
	}
	if !(!rt.is_true(var_date_query)) {
		var_date_query.array_set('relation', 'AND')
		var_args.array_set('date_query', var_date_query.clone())
	}
	if !(!rt.is_true(var_request_mutated.array_get(rt.new_string('product')))) {
		mut var_order_ids := rt.call_method(var_wpdb, 'get_col', [
			rt.call_method(var_wpdb, 'prepare', [
				rt.new_string("SELECT order_id FROM %i WHERE order_item_id IN ( SELECT order_item_id FROM %i WHERE meta_key = '_product_id' AND meta_value = %d ) AND order_item_type = %s"),
				rt.new_string((rt.get_property(var_wpdb, 'prefix')).str() +
					'woocommerce_order_items'),
				rt.new_string((rt.get_property(var_wpdb, 'prefix')).str() +
					'woocommerce_order_itemmeta'),
				var_request_mutated.array_get(rt.new_string('product')),
				Class_Automattic_WooCommerce_Enums_OrderItemType.line_item(),
			]),
		])
		if !rt.is_true(var_order_ids) {
			var_order_ids = rt.create_array([rt.ArrayItem{ key: none, val: 0 }])
		} else {
			mut var_include_ids := if !(var_args.array_get(rt.new_string('post__in'))).is_null() {
				var_args.array_get(rt.new_string('post__in'))
			} else {
				rt.new_array()
			}
			var_order_ids = if !(!rt.is_true(var_include_ids)) { rt.call_function('array_intersect', [
					var_order_ids.clone(),
					var_include_ids.clone(),
				]) } else { var_order_ids }
			var_args.array_set('post__in', rt.call_function('array_merge', [
				var_order_ids.clone(), rt.create_array([rt.ArrayItem{ key: none, val: 0 }])]))
		}
	}
	mut iife_temp_2 := Class_Automattic_WooCommerce_Utilities_OrderUtil{}
	mut iife_result_2 := iife_temp_2.custom_orders_table_usage_is_enabled()
	if rt.is_true(rt.new_bool(!(rt.is_true(iife_result_2))))
		&& !(!rt.is_true(var_args.array_get(rt.new_string('s')))) {
		var_order_ids = rt.call_function('wc_order_search', [
			var_args.array_get(rt.new_string('s')),
		])
		if !(!rt.is_true(var_order_ids)) {
			var_args.array_unset(rt.new_string('s'))
			var_include_ids = if !(var_args.array_get(rt.new_string('post__in'))).is_null() {
				var_args.array_get(rt.new_string('post__in'))
			} else {
				rt.new_array()
			}
			var_order_ids = if !(!rt.is_true(var_include_ids)) { rt.call_function('array_intersect', [
					var_order_ids.clone(),
					var_include_ids.clone(),
				]) } else { var_order_ids }
			var_args.array_set('post__in', rt.call_function('array_merge', [
				var_order_ids.clone(), rt.create_array([rt.ArrayItem{ key: none, val: 0 }])]))
		}
	}
	if var_request_mutated.array_isset(rt.new_string('total')) {
		mut var_total_param := rt.cast_array(var_request_mutated.array_get(rt.new_string('total')))
		mut var_total_value := if !(var_total_param.array_get(rt.new_int(0))).is_null() {
			var_total_param.array_get(rt.new_int(0))
		} else {
			rt.new_int(0)
		}
		mut var_total_operator := rt.new_string('=')
		mut switch_val_1 := if !(var_request_mutated.array_get(rt.new_string('total_operator'))).is_null() {
			var_request_mutated.array_get(rt.new_string('total_operator'))
		} else {
			Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_CollectionQuery.operator_is()
		}
		if rt.is_true(rt.equal(switch_val_1,
			Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_CollectionQuery.operator_is_not()))
		{
			var_total_operator = rt.new_string('!=')
		} else if rt.is_true(rt.equal(switch_val_1,
			Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_CollectionQuery.operator_less_than()))
		{
			var_total_operator = rt.new_string('<')
		} else if rt.is_true(rt.equal(switch_val_1,
			Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_CollectionQuery.operator_greater_than()))
		{
			var_total_operator = rt.new_string('>')
		} else if rt.is_true(rt.equal(switch_val_1,
			Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_CollectionQuery.operator_less_than_or_equal()))
		{
			var_total_operator = rt.new_string('<=')
		} else if rt.is_true(rt.equal(switch_val_1,
			Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_CollectionQuery.operator_greater_than_or_equal()))
		{
			var_total_operator = rt.new_string('>=')
		} else if rt.is_true(rt.equal(switch_val_1,
			Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_CollectionQuery.operator_between()))
		{
			var_total_operator = rt.new_string('BETWEEN')
			var_total_value = rt.create_array([
				rt.ArrayItem{
					key: none
					val: if !(var_total_param.array_get(rt.new_int(0))).is_null() {
						var_total_param.array_get(rt.new_int(0))
					} else {
						rt.new_int(0)
					}
				},
				rt.ArrayItem{
					key: none
					val: if !(var_total_param.array_get(rt.new_int(1))).is_null() {
						var_total_param.array_get(rt.new_int(1))
					} else {
						rt.new_int(0)
					}
				},
			])
		}
		var_args.array_set('total', rt.create_array([
			rt.ArrayItem{ key: 'value', val: var_total_value },
			rt.ArrayItem{ key: 'operator', val: var_total_operator },
		]))
	}
	if var_request_mutated.array_isset(rt.new_string('fulfillment_status')) {
		var_request_mutated.array_set('fulfillment_status', if var_request_mutated.array_get(rt.new_string('fulfillment_status')).is_array() { var_request_mutated.array_get(rt.new_string('fulfillment_status')) } else { rt.create_array([
				rt.ArrayItem{
					key: none
					val: var_request_mutated.array_get(rt.new_string('fulfillment_status'))
				},
			]) })
		mut var_fulfillment_status := rt.new_array()
		mut iter_1 := var_request_mutated.array_get(rt.new_string('fulfillment_status')).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_status := item_1.val
			mut iife_temp_3 :=
				Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils{}
			mut iife_result_3 := iife_temp_3.is_valid_order_fulfillment_status(var_status.clone())
			if rt.is_true(iife_result_3) {
				var_fulfillment_status.array_push(var_status.clone())
			}
		}
		var_args.array_set('fulfillment_status', var_fulfillment_status.clone())
	}
	return var_args.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_CollectionQuery) get_query_results(mut var_query_args Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_array, mut var_request Class_WP_REST_Request) rt.PhpVal {
	mut var_request_mutated := var_request
	mut var_query := create_wc_order_query(rt.call_function('array_merge', [
		var_query_args,
		rt.create_array([rt.ArrayItem{ key: 'paginate', val: true }]),
	]))
	mut var_results := var_query.get_orders()
	return rt.create_array([
		rt.ArrayItem{ key: 'results', val: rt.get_property(var_results, 'orders') },
		rt.ArrayItem{ key: 'total', val: rt.get_property(var_results, 'total') },
		rt.ArrayItem{ key: 'pages', val: rt.get_property(var_results, 'max_num_pages') },
	])
}

struct Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractCollectionQuery {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Utilities_OrderUtil {
	rt.PhpObjectBase
}

struct Class_WC_Order_Query {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_restapi_routes_v4_orders_collectionquery(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_CollectionQuery {
	mut obj := &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_CollectionQuery{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_restapi_routes_v4_abstractcollectionquery(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractCollectionQuery {
	mut obj := &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractCollectionQuery{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_error(_args ...rt.PhpVal) &Class_WP_Error {
	mut obj := &Class_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_features_fulfillments_fulfillmentutils(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils{
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

fn create_wc_order_query(_args ...rt.PhpVal) &Class_WC_Order_Query {
	mut obj := &Class_WC_Order_Query{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_CollectionQuery) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_query_schema' {
			return this.get_query_schema()
		}
		'get_query_args' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WP_REST_Request](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.get_query_args(mut dispatch_arg_0)
		}
		'get_query_results' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_WP_REST_Request](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			return this.get_query_results(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_CollectionQuery) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_CollectionQuery) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractCollectionQuery) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractCollectionQuery) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractCollectionQuery) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WP_Error) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Error) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Error) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_WC_Order_Query) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Order_Query) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Order_Query) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}
