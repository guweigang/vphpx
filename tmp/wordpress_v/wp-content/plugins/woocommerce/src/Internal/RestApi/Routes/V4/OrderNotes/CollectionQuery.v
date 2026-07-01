import rt

struct Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_OrderNotes_CollectionQuery {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_OrderNotes_CollectionQuery) get_query_schema() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: 'note_type', val: rt.create_array([rt.ArrayItem{ key: 'default', val: 'all' }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Limit result to customer notes or private notes.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'enum', val: rt.create_array([rt.ArrayItem{ key: none, val: 'all' }, rt.ArrayItem{ key: none, val: 'customer' }, rt.ArrayItem{ key: none, val: 'private' }]) }, rt.ArrayItem{ key: 'sanitize_callback', val: 'sanitize_key' }, rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' }]) }])
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_OrderNotes_CollectionQuery) get_query_args(mut var_request Class_WP_REST_Request) rt.PhpVal {
	mut var_args := rt.create_array([rt.ArrayItem{ key: 'post_id', val: if !(var_request.array_get('order_id')).is_null() { var_request.array_get('order_id') } else { rt.new_int(0) } }, rt.ArrayItem{ key: 'status', val: 'approve' }, rt.ArrayItem{ key: 'type', val: 'order_note' }])
	if rt.is_true(rt.identical(rt.new_string('customer'), var_request.array_get('note_type'))) {
		var_args.array_set('meta_query', rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'key', val: 'is_customer_note' }, rt.ArrayItem{ key: 'value', val: 1 }, rt.ArrayItem{ key: 'compare', val: '=' }]) }]))
	} else if rt.is_true(rt.identical(rt.new_string('private'), var_request.array_get('note_type'))) {
		var_args.array_set('meta_query', rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'key', val: 'is_customer_note' }, rt.ArrayItem{ key: 'compare', val: 'NOT EXISTS' }]) }]))
	}
	return var_args.dup()
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_OrderNotes_CollectionQuery) get_query_results(mut var_query_args Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_OrderNotes_array, mut var_request Class_WP_REST_Request) rt.PhpVal {
	rt.call_function('remove_filter', [rt.new_string('comments_clauses'), rt.create_array([rt.ArrayItem{ key: none, val: 'WC_Comments' }, rt.ArrayItem{ key: none, val: 'exclude_order_comments' }]), rt.new_int(10), rt.new_int(1)])
	mut var_results := rt.call_function('get_comments', [var_query_args])
	rt.call_function('add_filter', [rt.new_string('comments_clauses'), rt.create_array([rt.ArrayItem{ key: none, val: 'WC_Comments' }, rt.ArrayItem{ key: none, val: 'exclude_order_comments' }]), rt.new_int(10), rt.new_int(1)])
	return rt.cast_array(var_results)
}

struct Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractCollectionQuery {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_restapi_routes_v4_ordernotes_collectionquery() &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_OrderNotes_CollectionQuery {
	mut obj := &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_OrderNotes_CollectionQuery{
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

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_OrderNotes_CollectionQuery) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_query_schema' {
			return this.get_query_schema()
		}
		'get_query_args' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WP_REST_Request](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.get_query_args(mut dispatch_arg_0)
		}
		'get_query_results' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_OrderNotes_array](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_WP_REST_Request](if args.len > 1 { args[1] } else { rt.new_null() })
			return this.get_query_results(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_OrderNotes_CollectionQuery) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_OrderNotes_CollectionQuery) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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




pub fn init_wp_content_plugins_woocommerce_src_internal_restapi_routes_v4_ordernotes_collectionquery_php() {
	// unsupported statement: Stmt_Declare
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
