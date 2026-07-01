import rt

pub fn Class_Automattic_WooCommerce_StoreApi_Routes_V1_AbstractRoute.schema_type() string {
	return ''
}
pub fn Class_Automattic_WooCommerce_StoreApi_Routes_V1_AbstractRoute.schema_version() i64 {
	return 1
}
struct Class_Automattic_WooCommerce_StoreApi_Routes_V1_AbstractRoute {
	rt.PhpObjectBase
pub mut:
		schema rt.PhpVal = rt.new_null()
		namespace rt.PhpVal = rt.new_string('wc/store/v1')
		schema_controller rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_AbstractRoute) construct(mut var_schema_controller Class_Automattic_WooCommerce_StoreApi_SchemaController, mut var_schema Class_Automattic_WooCommerce_StoreApi_Schemas_V1_AbstractSchema)  {
	mut var_schema_mutated := var_schema
	this.schema_controller = var_schema_controller.dup()
	this.schema = var_schema_mutated.dup()
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_AbstractRoute) get_namespace() rt.PhpVal {
	return this.namespace
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_AbstractRoute) set_namespace(var_namespace rt.PhpVal)  {
	this.namespace = var_namespace.dup()
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_AbstractRoute) get_item_schema() rt.PhpVal {
	return rt.call_method(this.schema, 'get_item_schema', []rt.PhpVal{})
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_AbstractRoute) get_response(mut var_request Class_Automattic_WooCommerce_StoreApi_Routes_V1_WP_REST_Request) rt.PhpVal {
	mut var_response := rt.new_null()
	var_response = this.get_response_by_request_method(mut var_request)
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	unsafe { goto end_label_1 }

catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'Automattic_WooCommerce_StoreApi_Exceptions_RouteException') {
		mut var_error := var_e_1.dup()
		var_response = this.get_route_error_response(rt.call_method(var_error, 'getErrorCode', []rt.PhpVal{}), rt.call_method(var_error, 'getMessage', []rt.PhpVal{}), (rt.call_method(var_error, 'getCode', []rt.PhpVal{})).to_i64(), rt.call_method(var_error, 'getAdditionalData', []rt.PhpVal{}))
		unsafe { goto end_label_1 }
	}
	else if rt.instance_of(var_e_1, 'Automattic_WooCommerce_StoreApi_Exceptions_InvalidCartException') {
		mut var_error := var_e_1.dup()
		var_response = this.get_route_error_response_from_object(rt.call_method(var_error, 'getError', []rt.PhpVal{}), (rt.call_method(var_error, 'getCode', []rt.PhpVal{})).to_i64(), rt.call_method(var_error, 'getAdditionalData', []rt.PhpVal{}))
		unsafe { goto end_label_1 }
	}
	else if rt.instance_of(var_e_1, 'Automattic_WooCommerce_StoreApi_Routes_V1_Exception') {
		mut var_error := var_e_1.dup()
		var_response = this.get_route_error_response(rt.new_string('woocommerce_rest_unknown_server_error'), rt.call_method(var_error, 'getMessage', []rt.PhpVal{}), 500, rt.new_null())
		unsafe { goto end_label_1 }
	}
	else {
		rt.throw_exception(var_e_1)
		unsafe { goto end_label_1 }
	}

end_label_1:
	return if rt.is_true(rt.call_function('is_wp_error', [var_response.dup()])) { this.error_to_response(var_response.dup()) } else { var_response }
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_AbstractRoute) get_response_by_request_method(mut var_request Class_Automattic_WooCommerce_StoreApi_Routes_V1_WP_REST_Request) rt.PhpVal {
	mut switch_val_1 := var_request.get_method()
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('POST'))) {
		return this.get_route_post_response(mut var_request)
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('PUT'))) || rt.is_true(rt.equal(switch_val_1, rt.new_string('PATCH'))) {
		return this.get_route_update_response(mut var_request)
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('DELETE'))) {
		return this.get_route_delete_response(mut var_request)
	}
	return this.get_route_response(mut var_request)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_AbstractRoute) error_to_response(var_error rt.PhpVal) rt.PhpVal {
	mut var_error_data := rt.call_method(var_error, 'get_error_data', []rt.PhpVal{})
	mut var_status := if !(var_error_data).is_null() && var_error_data.array_isset(rt.new_string('status')) { var_error_data.array_get('status') } else { rt.new_int(500) }
	mut var_errors := rt.new_array()
	{
		mut iter_1 := rt.cast_array(rt.get_property(var_error, 'errors')).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_messages := item_1.val
			mut var_code := item_1.key
			{
				mut iter_2 := rt.cast_array(var_messages).iterator()
				for {
					item_2 := iter_2.next() or { break }
					mut var_message := item_2.val
					var_errors.array_push(rt.create_array([rt.ArrayItem{ key: 'code', val: var_code }, rt.ArrayItem{ key: 'message', val: var_message }, rt.ArrayItem{ key: 'data', val: rt.call_method(var_error, 'get_error_data', [var_code.dup()]) }]))
				}
			}
		}
	}
	mut var_data := rt.call_function('array_shift', [var_errors.dup()])
	if rt.is_true(rt.new_int(var_errors.dup().array_count())) {
		var_data.array_set('additional_errors', var_errors.dup())
	}
	return create_automattic_woocommerce_storeapi_routes_v1_wp_rest_response(var_data.dup(), var_status.dup())
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_AbstractRoute) get_route_response(mut var_request Class_Automattic_WooCommerce_StoreApi_Routes_V1_WP_REST_Request) rt.PhpVal {
	return this.get_route_error_response(rt.new_string('woocommerce_rest_invalid_endpoint'), rt.call_function('__', [rt.new_string('Method not implemented'), rt.new_string('woocommerce')]), 404, rt.new_null())
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_AbstractRoute) get_route_post_response(mut var_request Class_Automattic_WooCommerce_StoreApi_Routes_V1_WP_REST_Request) rt.PhpVal {
	return this.get_route_error_response(rt.new_string('woocommerce_rest_invalid_endpoint'), rt.call_function('__', [rt.new_string('Method not implemented'), rt.new_string('woocommerce')]), 404, rt.new_null())
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_AbstractRoute) get_route_update_response(mut var_request Class_Automattic_WooCommerce_StoreApi_Routes_V1_WP_REST_Request) rt.PhpVal {
	return this.get_route_error_response(rt.new_string('woocommerce_rest_invalid_endpoint'), rt.call_function('__', [rt.new_string('Method not implemented'), rt.new_string('woocommerce')]), 404, rt.new_null())
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_AbstractRoute) get_route_delete_response(mut var_request Class_Automattic_WooCommerce_StoreApi_Routes_V1_WP_REST_Request) rt.PhpVal {
	return this.get_route_error_response(rt.new_string('woocommerce_rest_invalid_endpoint'), rt.call_function('__', [rt.new_string('Method not implemented'), rt.new_string('woocommerce')]), 404, rt.new_null())
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_AbstractRoute) get_route_error_response(var_error_code rt.PhpVal, var_error_message rt.PhpVal, http_status_code i64, var_additional_data rt.PhpVal) rt.PhpVal {
	return create_wp_error(var_error_code.dup(), var_error_message.dup(), rt.call_function('array_merge', [var_additional_data.dup(), rt.create_array([rt.ArrayItem{ key: 'status', val: http_status_code }])]))
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_AbstractRoute) get_route_error_response_from_object(var_error_object rt.PhpVal, http_status_code i64, var_additional_data rt.PhpVal) rt.PhpVal {
	rt.call_method(var_error_object, 'add_data', [rt.call_function('array_merge', [var_additional_data.dup(), rt.create_array([rt.ArrayItem{ key: 'status', val: http_status_code }])])])
	return var_error_object.dup()
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_AbstractRoute) prepare_item_for_response(var_item rt.PhpVal, mut var_request Class_Automattic_WooCommerce_StoreApi_Routes_V1_WP_REST_Request) rt.PhpVal {
	mut var_response := rt.call_function('rest_ensure_response', [rt.call_method(this.schema, 'get_item_response', [var_item.dup()])])
	if rt.is_true(rt.call_function('is_wp_error', [var_response.dup()])) {
		return rt.call_function('rest_convert_error_to_response', [var_response.dup()])
	}
	rt.call_method(var_response, 'add_links', [this.prepare_links(var_item.dup(), rt.new_object('Automattic_WooCommerce_StoreApi_Routes_V1_WP_REST_Request', []string{}, var_request))])
	return var_response.dup()
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_AbstractRoute) get_context_param(var_args rt.PhpVal) rt.PhpVal {
	mut var_param_details := rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Scope under which the request is made; determines fields present in response.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'sanitize_callback', val: 'sanitize_key' }, rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' }])
	mut var_schema := this.get_item_schema()
	if !rt.is_true(var_schema.array_get('properties')) {
		return rt.call_function('array_merge', [var_param_details.dup(), var_args.dup()])
	}
	mut var_contexts := rt.new_array()
	{
		mut iter_1 := var_schema.array_get('properties').iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_attributes := item_1.val
			if !(!rt.is_true(var_attributes.array_get('context'))) {
				var_contexts = rt.call_function('array_merge', [var_contexts.dup(), var_attributes.array_get('context')])
			}
		}
	}
	if !(!rt.is_true(var_contexts)) {
		var_param_details.array_set('enum', rt.call_function('array_unique', [var_contexts.dup()]))
		rt.call_function('rsort', [var_param_details.array_get('enum')])
	}
	return rt.call_function('array_merge', [var_param_details.dup(), var_args.dup()])
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_AbstractRoute) prepare_response_for_collection(mut var_response Class_Automattic_WooCommerce_StoreApi_Routes_V1_WP_REST_Response) rt.PhpVal {
	mut var_response_mutated := var_response
	mut var_data := rt.cast_array(rt.call_method(var_response_mutated, 'get_data', []rt.PhpVal{}))
	mut var_server := rt.call_function('rest_get_server', []rt.PhpVal{})
	mut var_links := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_StoreApi_Routes_V1_{"nodeType":"Expr_Variable","line":305,"name":"server"}{}; return temp.get_compact_response_links(arg_0) }(rt.new_object('Automattic_WooCommerce_StoreApi_Routes_V1_WP_REST_Response', []string{}, var_response_mutated))
	if !(!rt.is_true(var_links)) {
		var_data.array_set('_links', var_links.dup())
	}
	return var_data.dup()
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_AbstractRoute) prepare_links(var_item rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
	return rt.new_array()
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_AbstractRoute) get_collection_params() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: 'context', val: this.get_context_param(rt.new_null()) }])
}

struct Class_Automattic_WooCommerce_StoreApi_Routes_V1_WP_REST_Response {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_StoreApi_Routes_V1_{"nodeType":"Expr_Variable","line":305,"name":"server"} {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_storeapi_routes_v1_abstractroute(arg_0 rt.PhpVal, arg_1 rt.PhpVal) &Class_Automattic_WooCommerce_StoreApi_Routes_V1_AbstractRoute {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Routes_V1_AbstractRoute{
		PhpObjectBase: rt.PhpObjectBase{}
		schema: rt.new_null()
		namespace: rt.new_string('wc/store/v1')
		schema_controller: rt.new_null()
	}
	obj.construct(arg_0, arg_1)
	return obj
}

fn create_automattic_woocommerce_storeapi_routes_v1_wp_rest_response() &Class_Automattic_WooCommerce_StoreApi_Routes_V1_WP_REST_Response {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Routes_V1_WP_REST_Response{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_error() &Class_WP_Error {
	mut obj := &Class_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_storeapi_routes_v1_{"nodetype":"expr_variable","line":305,"name":"server"}() &Class_Automattic_WooCommerce_StoreApi_Routes_V1_{"nodeType":"Expr_Variable","line":305,"name":"server"} {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Routes_V1_{"nodeType":"Expr_Variable","line":305,"name":"server"}{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_AbstractRoute) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_SchemaController](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Schemas_V1_AbstractSchema](if args.len > 1 { args[1] } else { rt.new_null() })
			this.construct(mut dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'get_namespace' {
			return this.get_namespace()
		}
		'set_namespace' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_namespace(dispatch_arg_0)
			return rt.new_null()
		}
		'get_item_schema' {
			return this.get_item_schema()
		}
		'get_response' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Routes_V1_WP_REST_Request](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.get_response(mut dispatch_arg_0)
		}
		'get_response_by_request_method' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Routes_V1_WP_REST_Request](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.get_response_by_request_method(mut dispatch_arg_0)
		}
		'error_to_response' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.error_to_response(dispatch_arg_0)
		}
		'get_route_response' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Routes_V1_WP_REST_Request](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.get_route_response(mut dispatch_arg_0)
		}
		'get_route_post_response' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Routes_V1_WP_REST_Request](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.get_route_post_response(mut dispatch_arg_0)
		}
		'get_route_update_response' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Routes_V1_WP_REST_Request](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.get_route_update_response(mut dispatch_arg_0)
		}
		'get_route_delete_response' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Routes_V1_WP_REST_Request](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.get_route_delete_response(mut dispatch_arg_0)
		}
		'get_route_error_response' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_i64()
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			return this.get_route_error_response(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
		}
		'get_route_error_response_from_object' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.get_route_error_response_from_object(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'prepare_item_for_response' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Routes_V1_WP_REST_Request](if args.len > 1 { args[1] } else { rt.new_null() })
			return this.prepare_item_for_response(dispatch_arg_0, mut dispatch_arg_1)
		}
		'get_context_param' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_context_param(dispatch_arg_0)
		}
		'prepare_response_for_collection' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Routes_V1_WP_REST_Response](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.prepare_response_for_collection(mut dispatch_arg_0)
		}
		'prepare_links' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.prepare_links(dispatch_arg_0, dispatch_arg_1)
		}
		'get_collection_params' {
			return this.get_collection_params()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Routes_V1_AbstractRoute) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'schema' { return this.schema }
		'namespace' { return this.namespace }
		'schema_controller' { return this.schema_controller }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_AbstractRoute) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'schema' { this.schema = val; return true }
		'namespace' { this.namespace = val; return true }
		'schema_controller' { this.schema_controller = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_WP_REST_Response) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Routes_V1_WP_REST_Response) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_WP_REST_Response) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_{"nodeType":"Expr_Variable","line":305,"name":"server"}) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Routes_V1_{"nodeType":"Expr_Variable","line":305,"name":"server"}) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_{"nodeType":"Expr_Variable","line":305,"name":"server"}) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_storeapi_routes_v1_abstractroute_php() {
}
