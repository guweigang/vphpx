import rt

struct Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_CollectionQuery {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_CollectionQuery) get_query_schema() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: 'page', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Current page of the collection.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }, rt.ArrayItem{ key: 'default', val: 1 }, rt.ArrayItem{ key: 'sanitize_callback', val: 'absint' }, rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' }, rt.ArrayItem{ key: 'minimum', val: 1 }]) }, rt.ArrayItem{ key: 'per_page', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Maximum number of items to be returned in result set.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }, rt.ArrayItem{ key: 'default', val: 10 }, rt.ArrayItem{ key: 'minimum', val: 1 }, rt.ArrayItem{ key: 'maximum', val: 100 }, rt.ArrayItem{ key: 'sanitize_callback', val: 'absint' }, rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' }]) }, rt.ArrayItem{ key: 'search', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Limit results to those matching a string.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'sanitize_callback', val: 'sanitize_text_field' }, rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' }]) }, rt.ArrayItem{ key: 'exclude', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Ensure result set excludes specific IDs.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'array' }, rt.ArrayItem{ key: 'items', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'integer' }]) }, rt.ArrayItem{ key: 'default', val: rt.new_array() }, rt.ArrayItem{ key: 'sanitize_callback', val: 'wp_parse_id_list' }]) }, rt.ArrayItem{ key: 'include', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Limit result set to specific IDs.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'array' }, rt.ArrayItem{ key: 'items', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'integer' }]) }, rt.ArrayItem{ key: 'default', val: rt.new_array() }, rt.ArrayItem{ key: 'sanitize_callback', val: 'wp_parse_id_list' }]) }, rt.ArrayItem{ key: 'order', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Order sort attribute ascending or descending.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'default', val: 'asc' }, rt.ArrayItem{ key: 'enum', val: rt.create_array([rt.ArrayItem{ key: none, val: 'asc' }, rt.ArrayItem{ key: none, val: 'desc' }]) }, rt.ArrayItem{ key: 'sanitize_callback', val: 'sanitize_key' }, rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' }]) }, rt.ArrayItem{ key: 'orderby', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Sort collection by object attribute.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'default', val: 'name' }, rt.ArrayItem{ key: 'enum', val: rt.create_array([rt.ArrayItem{ key: none, val: 'id' }, rt.ArrayItem{ key: none, val: 'name' }, rt.ArrayItem{ key: none, val: 'registered_date' }, rt.ArrayItem{ key: none, val: 'order_count' }, rt.ArrayItem{ key: none, val: 'total_spent' }, rt.ArrayItem{ key: none, val: 'last_active' }]) }, rt.ArrayItem{ key: 'sanitize_callback', val: 'sanitize_key' }, rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' }]) }, rt.ArrayItem{ key: 'role', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Limit result set to resources with a specific role.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'default', val: 'customer' }, rt.ArrayItem{ key: 'enum', val: rt.create_array([rt.ArrayItem{ key: none, val: 'customer' }, rt.ArrayItem{ key: none, val: 'all' }]) }, rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' }]) }])
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_CollectionQuery) get_query_args(mut var_request Class_WP_REST_Request) rt.PhpVal {
	mut var_prepared_args := rt.new_array()
	var_prepared_args.array_set('exclude', var_request.array_get('exclude'))
	var_prepared_args.array_set('include', var_request.array_get('include'))
	var_prepared_args.array_set('order', var_request.array_get('order'))
	var_prepared_args.array_set('number', var_request.array_get('per_page'))
	var_prepared_args.array_set('page', rt.call_function('max', [rt.new_int(1), rt.new_int(var_request.array_get('page').to_i64())]))
	mut var_orderby_possibles := rt.create_array([rt.ArrayItem{ key: 'id', val: 'ID' }, rt.ArrayItem{ key: 'name', val: 'display_name' }, rt.ArrayItem{ key: 'registered_date', val: 'user_registered' }, rt.ArrayItem{ key: 'order_count', val: 'wc_order_count' }, rt.ArrayItem{ key: 'total_spent', val: 'wc_money_spent' }, rt.ArrayItem{ key: 'last_active', val: 'wc_last_active' }])
	var_prepared_args.array_set('orderby', var_orderby_possibles.array_get(var_request.array_get('orderby')))
	var_prepared_args.array_set('search', var_request.array_get('search'))
	if !(!rt.is_true(var_prepared_args.array_get('search'))) {
		var_prepared_args.array_set('search', '*' + (var_prepared_args.array_get('search')).str() + '*')
	}
	var_prepared_args.array_set('role', var_request.array_get('role'))
	var_prepared_args = rt.call_function('apply_filters', [rt.new_string('woocommerce_rest_customer_query'), var_prepared_args.dup(), var_request])
	return var_prepared_args.dup()
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_CollectionQuery) get_query_results(mut var_query_args Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_array, mut var_request Class_WP_REST_Request) rt.PhpVal {
	mut var_method_args := rt.create_array([rt.ArrayItem{ key: 'order', val: if !(var_query_args.array_get('order')).is_null() { var_query_args.array_get('order') } else { rt.new_string('asc') } }, rt.ArrayItem{ key: 'orderby', val: if !(var_query_args.array_get('orderby')).is_null() { var_query_args.array_get('orderby') } else { rt.new_string('user_registered') } }, rt.ArrayItem{ key: 'per_page', val: if !(var_query_args.array_get('number')).is_null() { var_query_args.array_get('number') } else { rt.new_int(10) } }, rt.ArrayItem{ key: 'search', val: if !(var_query_args.array_get('search')).is_null() { var_query_args.array_get('search') } else { rt.new_string('') } }, rt.ArrayItem{ key: 'role', val: if !(var_query_args.array_get('role')).is_null() { var_query_args.array_get('role') } else { rt.new_string('customer') } }, rt.ArrayItem{ key: 'include', val: if !(var_query_args.array_get('include')).is_null() { var_query_args.array_get('include') } else { rt.new_array() } }, rt.ArrayItem{ key: 'exclude', val: if !(var_query_args.array_get('exclude')).is_null() { var_query_args.array_get('exclude') } else { rt.new_array() } }, rt.ArrayItem{ key: 'page', val: if !(var_query_args.array_get('page')).is_null() { var_query_args.array_get('page') } else { rt.new_int(1) } }])
	mut var_data_store := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_WC_Data_Store{}; return temp.load(arg_0) }(rt.new_string('customer'))
	mut var_customer_query_results := rt.call_method(var_data_store, 'query_customers', [var_method_args.dup()])
	mut var_users := rt.get_property(var_customer_query_results, 'customers')
	mut var_total_users := rt.get_property(var_customer_query_results, 'total')
	mut var_max_pages := rt.get_property(var_customer_query_results, 'max_num_pages')
	return rt.create_array([rt.ArrayItem{ key: 'results', val: var_users }, rt.ArrayItem{ key: 'total', val: var_total_users }, rt.ArrayItem{ key: 'pages', val: var_max_pages }])
}

struct Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractCollectionQuery {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_WC_Data_Store {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_restapi_routes_v4_customers_collectionquery() &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_CollectionQuery {
	mut obj := &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_CollectionQuery{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_restapi_routes_v4_abstractcollectionquery() &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractCollectionQuery {
	mut obj := &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractCollectionQuery{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_restapi_routes_v4_customers_wc_data_store() &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_WC_Data_Store {
	mut obj := &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_WC_Data_Store{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_CollectionQuery) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_query_schema' {
			return this.get_query_schema()
		}
		'get_query_args' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WP_REST_Request](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.get_query_args(mut dispatch_arg_0)
		}
		'get_query_results' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_array](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_WP_REST_Request](if args.len > 1 { args[1] } else { rt.new_null() })
			return this.get_query_results(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_CollectionQuery) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_CollectionQuery) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_WC_Data_Store) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_WC_Data_Store) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_WC_Data_Store) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_internal_restapi_routes_v4_customers_collectionquery_php() {
	// unsupported statement: Stmt_Declare
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
