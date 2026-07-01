import rt

struct Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Refunds_CollectionQuery {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Refunds_CollectionQuery) get_query_schema() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: 'order_id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Filter refunds by order ID.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }, rt.ArrayItem{ key: 'sanitize_callback', val: 'absint' }, rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' }]) }, rt.ArrayItem{ key: 'page', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Current page of the collection.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }, rt.ArrayItem{ key: 'default', val: 1 }, rt.ArrayItem{ key: 'sanitize_callback', val: 'absint' }, rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' }, rt.ArrayItem{ key: 'minimum', val: 1 }]) }, rt.ArrayItem{ key: 'per_page', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Maximum number of items to be returned in result set.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }, rt.ArrayItem{ key: 'default', val: 10 }, rt.ArrayItem{ key: 'minimum', val: 1 }, rt.ArrayItem{ key: 'maximum', val: 100 }, rt.ArrayItem{ key: 'sanitize_callback', val: 'absint' }, rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' }]) }, rt.ArrayItem{ key: 'order', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Order sort attribute ascending or descending.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'default', val: 'desc' }, rt.ArrayItem{ key: 'enum', val: rt.create_array([rt.ArrayItem{ key: none, val: 'asc' }, rt.ArrayItem{ key: none, val: 'desc' }]) }, rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' }]) }, rt.ArrayItem{ key: 'orderby', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Sort collection by object attribute.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'default', val: 'date' }, rt.ArrayItem{ key: 'enum', val: rt.create_array([rt.ArrayItem{ key: none, val: 'date' }, rt.ArrayItem{ key: none, val: 'id' }, rt.ArrayItem{ key: none, val: 'include' }, rt.ArrayItem{ key: none, val: 'title' }, rt.ArrayItem{ key: none, val: 'slug' }, rt.ArrayItem{ key: none, val: 'modified' }, rt.ArrayItem{ key: none, val: 'total' }]) }, rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' }]) }, rt.ArrayItem{ key: 'after', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Limit response to resources published after a given ISO8601 compliant date.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'format', val: 'date-time' }, rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' }]) }, rt.ArrayItem{ key: 'before', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Limit response to resources published before a given ISO8601 compliant date.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'format', val: 'date-time' }, rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' }]) }, rt.ArrayItem{ key: 'dates_are_gmt', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Whether to consider GMT post dates when limiting response by published or modified date.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'boolean' }, rt.ArrayItem{ key: 'default', val: false }, rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' }]) }])
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Refunds_CollectionQuery) get_query_args(mut var_request Class_WP_REST_Request) rt.PhpVal {
	mut var_args := rt.create_array([rt.ArrayItem{ key: 'order', val: var_request.array_get('order') }, rt.ArrayItem{ key: 'orderby', val: var_request.array_get('orderby') }, rt.ArrayItem{ key: 'page', val: var_request.array_get('page') }, rt.ArrayItem{ key: 'posts_per_page', val: var_request.array_get('per_page') }])
	if rt.is_true(rt.identical(rt.new_string('date'), var_args.array_get('orderby'))) {
		var_args.array_set('orderby', 'date ID')
	}
	mut var_date_query := rt.new_array()
	mut var_use_gmt := var_request.array_get('dates_are_gmt')
	if var_request.array_isset(rt.new_string('before')) {
		var_date_query.array_push(rt.create_array([rt.ArrayItem{ key: 'column', val: if rt.is_true(var_use_gmt) { 'post_date_gmt' } else { 'post_date' } }, rt.ArrayItem{ key: 'before', val: var_request.array_get('before') }]))
	}
	if var_request.array_isset(rt.new_string('after')) {
		var_date_query.array_push(rt.create_array([rt.ArrayItem{ key: 'column', val: if rt.is_true(var_use_gmt) { 'post_date_gmt' } else { 'post_date' } }, rt.ArrayItem{ key: 'after', val: var_request.array_get('after') }]))
	}
	if !(!rt.is_true(var_date_query)) {
		var_date_query.array_set('relation', 'AND')
		var_args.array_set('date_query', var_date_query.dup())
	}
	mut var_order_id := rt.call_function('absint', [if !(var_request.array_get('order_id')).is_null() { var_request.array_get('order_id') } else { rt.new_int(0) }])
	if rt.is_true(var_order_id) {
		var_args.array_set('post_parent__in', rt.create_array([rt.ArrayItem{ key: none, val: var_order_id }]))
	}
	return var_args.dup()
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Refunds_CollectionQuery) get_query_results(mut var_query_args Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Refunds_array, mut var_request Class_WP_REST_Request) rt.PhpVal {
	mut var_query := create_wc_order_query(rt.call_function('array_merge', [var_query_args, rt.create_array([rt.ArrayItem{ key: 'paginate', val: true }])]))
	mut var_results := var_query.get_orders()
	return rt.create_array([rt.ArrayItem{ key: 'results', val: rt.get_property(var_results, 'orders') }, rt.ArrayItem{ key: 'total', val: rt.get_property(var_results, 'total') }, rt.ArrayItem{ key: 'pages', val: rt.get_property(var_results, 'max_num_pages') }])
}

struct Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractCollectionQuery {
	rt.PhpObjectBase
}

struct Class_WC_Order_Query {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_restapi_routes_v4_refunds_collectionquery() &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Refunds_CollectionQuery {
	mut obj := &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Refunds_CollectionQuery{
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

fn create_wc_order_query() &Class_WC_Order_Query {
	mut obj := &Class_WC_Order_Query{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Refunds_CollectionQuery) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_query_schema' {
			return this.get_query_schema()
		}
		'get_query_args' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WP_REST_Request](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.get_query_args(mut dispatch_arg_0)
		}
		'get_query_results' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Refunds_array](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_WP_REST_Request](if args.len > 1 { args[1] } else { rt.new_null() })
			return this.get_query_results(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Refunds_CollectionQuery) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Refunds_CollectionQuery) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_WC_Order_Query) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Order_Query) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Order_Query) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_internal_restapi_routes_v4_refunds_collectionquery_php() {
	// unsupported statement: Stmt_Declare
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
