import rt

pub fn Class_Automattic_WooCommerce_Internal_Api_GraphQLController.max_query_depth() i64 {
	return 15
}
pub fn Class_Automattic_WooCommerce_Internal_Api_GraphQLController.max_query_complexity() i64 {
	return 1000
}
pub fn Class_Automattic_WooCommerce_Internal_Api_GraphQLController.error_status_map() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: 'UNAUTHORIZED', val: 401 }, rt.ArrayItem{ key: 'FORBIDDEN', val: 403 }, rt.ArrayItem{ key: 'NOT_FOUND', val: 404 }, rt.ArrayItem{ key: 'METHOD_NOT_ALLOWED', val: 405 }, rt.ArrayItem{ key: 'INVALID_ARGUMENT', val: 400 }, rt.ArrayItem{ key: 'BAD_USER_INPUT', val: 400 }, rt.ArrayItem{ key: 'GRAPHQL_PARSE_ERROR', val: 400 }, rt.ArrayItem{ key: 'GRAPHQL_PARSE_FAILED', val: 400 }, rt.ArrayItem{ key: 'GRAPHQL_VALIDATION_FAILED', val: 400 }, rt.ArrayItem{ key: 'VALIDATION_ERROR', val: 422 }, rt.ArrayItem{ key: 'INTERNAL_ERROR', val: 500 }])
}
struct Class_Automattic_WooCommerce_Internal_Api_GraphQLController {
	rt.PhpObjectBase
pub mut:
		schema rt.PhpVal = rt.new_null()
		query_cache rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Api_GraphQLController) init(mut var_query_cache Class_Automattic_WooCommerce_Internal_Api_QueryCache) {
	this.query_cache = var_query_cache
}

fn Class_Automattic_WooCommerce_Internal_Api_GraphQLController.get_max_query_depth() i64 {
	return (Class_Automattic_WooCommerce_Internal_Api_Automattic_WooCommerce_Internal_Api_GraphQLController.max_query_depth()).to_i64()
}

fn Class_Automattic_WooCommerce_Internal_Api_GraphQLController.get_max_query_complexity() i64 {
	return (Class_Automattic_WooCommerce_Internal_Api_Automattic_WooCommerce_Internal_Api_GraphQLController.max_query_complexity()).to_i64()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Api_GraphQLController) register() {
	mut iife_temp_0 := Class_Automattic_WooCommerce_Internal_Api_Main{}
	mut iife_result_0 := iife_temp_0.filter_methods_against_settings(rt.create_array([rt.ArrayItem{ key: none, val: 'GET' }, rt.ArrayItem{ key: none, val: 'POST' }]))
	mut var_methods := iife_result_0
	if !rt.is_true(var_methods) {
		return
	}
	rt.call_function('register_rest_route', [rt.new_string('wc'), rt.new_string('/graphql'), rt.create_array([rt.ArrayItem{ key: 'methods', val: var_methods }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Api_GraphQLController', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'handle_request' }]) }, rt.ArrayItem{ key: 'permission_callback', val: '__return_true' }])])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Api_GraphQLController) handle_request(mut var_request Class_Automattic_WooCommerce_Internal_Api_WP_REST_Request) rt.PhpVal {
	return this.process_request(mut var_request)
	unsafe { goto end_label_1 }

catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'Automattic_WooCommerce_Internal_Api_Throwable') {
		mut var_e := var_e_1.clone()
		mut var_output := rt.create_array([rt.ArrayItem{ key: 'errors', val: rt.create_array([rt.ArrayItem{ key: none, val: this.format_exception(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Api_Throwable](var_e), mut var_request) }]) }])
		mut var_status := rt.new_int(this.get_error_status(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Api_array](var_output.array_get(rt.new_string('errors')))))
		return rt.new_object('Automattic_WooCommerce_Internal_Api_WP_REST_Response', []string{}, create_automattic_woocommerce_internal_api_wp_rest_response(var_output.clone(), var_status.clone()))
		unsafe { goto end_label_1 }
	}
	else {
		rt.throw_exception(var_e_1)
		unsafe { goto end_label_1 }
	}

end_label_1:
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Api_GraphQLController) process_request(mut var_request Class_Automattic_WooCommerce_Internal_Api_WP_REST_Request) rt.PhpVal {
	mut var_query := var_request.get_param(rt.new_string('query'))
	mut var_operation_name := var_request.get_param(rt.new_string('operationName'))
	mut var_variables := this.decode_json_param(var_request.get_param(rt.new_string('variables')), 'variables')
	mut var_extensions := this.decode_json_param(var_request.get_param(rt.new_string('extensions')), 'extensions')
	mut var_source := rt.call_method(this.query_cache, 'resolve', [var_query.clone(), var_extensions.clone()])
	if rt.is_true(rt.new_bool(var_source.clone().is_array())) {
		return rt.new_object('Automattic_WooCommerce_Internal_Api_WP_REST_Response', []string{}, create_automattic_woocommerce_internal_api_wp_rest_response(var_source.clone(), this.get_resolve_error_status(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Api_array](var_source))))
	}
	if rt.is_true(rt.identical(rt.new_string('GET'), var_request.get_method())) && this.document_has_mutation(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_DocumentNode](var_source), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Api_?string](var_operation_name)) {
		return rt.new_object('Automattic_WooCommerce_Internal_Api_WP_REST_Response', []string{}, create_automattic_woocommerce_internal_api_wp_rest_response(rt.create_array([rt.ArrayItem{ key: 'errors', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'message', val: 'Mutations are not allowed over GET requests. Use POST instead.' }, rt.ArrayItem{ key: 'extensions', val: rt.create_array([rt.ArrayItem{ key: 'code', val: 'METHOD_NOT_ALLOWED' }]) }]) }]) }]), rt.new_int(405)))
	}
	mut var_schema := this.get_schema()
	mut var_complexity_rule := create_automattic_woocommerce_vendor_graphql_validator_rules_querycomplexity(Class_Automattic_WooCommerce_Internal_Api_GraphQLController.get_max_query_complexity())
	mut iife_temp_1 := Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_DocumentValidator{}
	mut iife_result_1 := iife_temp_1.allrules()
	mut iife_temp_2 := Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_DocumentValidator{}
	mut iife_result_2 := iife_temp_2.allrules()
	mut var_validation_rules := rt.call_function('array_values', [iife_result_1])
	var_validation_rules.array_push(create_automattic_woocommerce_vendor_graphql_validator_rules_querydepth(Class_Automattic_WooCommerce_Internal_Api_GraphQLController.get_max_query_depth()))
	var_validation_rules.array_push(var_complexity_rule)
	if !(this.is_introspection_allowed(mut var_request)) {
		var_validation_rules.array_push(create_automattic_woocommerce_vendor_graphql_validator_rules_disableintrospection(Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_DisableIntrospection.enabled()))
	}
	mut iife_temp_3 := Class_Automattic_WooCommerce_Vendor_GraphQL_GraphQL{}
	mut iife_result_3 := iife_temp_3.executequery(var_schema.clone(), var_source.clone(), var_variables.clone(), var_operation_name.clone(), var_validation_rules.clone())
	mut var_result := iife_result_3
	mut var_debug_mode := rt.new_bool(this.is_debug_mode(mut var_request))
	closure_6_fn := fn [var_debug_mode] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_error := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut iife_temp_5 := Class_Automattic_WooCommerce_Internal_Api_Automattic_WooCommerce_Vendor_GraphQL_Error_FormattedError{}
		mut iife_result_5 := iife_temp_5.createfromexception(var_error.clone())
		mut var_formatted := iife_result_5
		if !(var_formatted.array_get(rt.new_string('extensions')).array_isset(rt.new_string('code'))) {
			mut var_client_safe := rt.new_bool(rt.is_true(rt.new_bool(rt.instance_of(var_error, 'Automattic_WooCommerce_Internal_Api_Automattic_WooCommerce_Vendor_GraphQL_Error_ClientAware'))) && rt.is_true(rt.call_method(var_error, 'isClientSafe', []rt.PhpVal{})))
			var_formatted.array_get_mut('extensions').array_set('code', if rt.is_true(var_client_safe) { 'BAD_USER_INPUT' } else { 'INTERNAL_ERROR' })
		}
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('BAD_USER_INPUT'), if !(var_formatted.array_get(rt.new_string('extensions')).array_get(rt.new_string('code'))).is_null() { var_formatted.array_get(rt.new_string('extensions')).array_get(rt.new_string('code')) } else { rt.new_null() })))) {
			mut var_cursor := var_error.clone()
			for rt.is_true(rt.new_bool(rt.instance_of(var_cursor, 'Automattic_WooCommerce_Internal_Api_Throwable'))) {
				if rt.is_true(rt.new_bool(rt.instance_of(var_cursor, 'Automattic_WooCommerce_Internal_Api_Automattic_WooCommerce_Vendor_GraphQL_Error_SerializationError'))) {
					var_formatted.array_get_mut('extensions').array_set('code', 'BAD_USER_INPUT')
					break
				}
			var_cursor = rt.call_method(var_cursor, 'getPrevious', []rt.PhpVal{})
			}
		}
		if rt.is_true(var_debug_mode) {
			mut var_chain := this.extract_previous_chain(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Api_Throwable](var_error))
			if !(!rt.is_true(var_chain)) {
				var_formatted.array_get_mut('extensions').array_set('previous', var_chain.clone())
			}
		}
		return var_formatted.clone()
		}
	rt.call_method(var_result, 'setErrorFormatter', [rt.new_closure(closure_6_fn)])
	mut var_debug_flags := rt.new_int(this.get_debug_flags(mut var_request))
	mut var_output := rt.call_method(var_result, 'toArray', [var_debug_flags.clone()])
	if this.is_debug_mode(mut var_request) {
		if !(var_output.array_isset(rt.new_string('extensions'))) {
			var_output.array_set('extensions', rt.new_array())
		}
		if !(var_output.array_get(rt.new_string('extensions')).array_isset(rt.new_string('debug'))) {
			var_output.array_get_mut('extensions').array_set('debug', rt.new_array())
		}
		var_output.array_get_mut('extensions').array_get_mut('debug').array_set('complexity', var_complexity_rule.getquerycomplexity())
		var_output.array_get_mut('extensions').array_get_mut('debug').array_set('depth', this.compute_query_depth(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_DocumentNode](var_source), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Api_?string](var_operation_name)))
	}
	mut var_status := rt.new_int(if var_output.array_isset(rt.new_string('errors')) { this.get_error_status(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Api_array](var_output.array_get(rt.new_string('errors')))) } else { 200 })
	return rt.new_object('Automattic_WooCommerce_Internal_Api_WP_REST_Response', []string{}, create_automattic_woocommerce_internal_api_wp_rest_response(var_output.clone(), var_status.clone()))
}

fn (mut this Class_Automattic_WooCommerce_Internal_Api_GraphQLController) get_schema() rt.PhpVal {
	if rt.is_true(rt.identical(rt.new_null(), this.schema)) {
		this.schema = this.build_schema()
	}
	return this.schema
}

fn (mut this Class_Automattic_WooCommerce_Internal_Api_GraphQLController) build_schema() {
}

fn (mut this Class_Automattic_WooCommerce_Internal_Api_GraphQLController) decode_json_param(var_value rt.PhpVal, name string) rt.PhpVal {
	if rt.is_true(rt.identical(rt.new_null(), var_value)) {
		return rt.new_array()
	}
	if rt.is_true(rt.new_bool(var_value.clone().is_array())) {
		return var_value.clone()
	}
	if !(var_value.clone().is_string()) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Internal_Api_InvalidArgumentException', []string{}, create_automattic_woocommerce_internal_api_invalidargumentexception(rt.call_function('sprintf', [rt.new_string('Argument `%s` must be a JSON object or omitted.'), rt.new_string(name)]))))
	}
	if rt.is_true(rt.identical(rt.new_string(''), var_value)) {
		return rt.new_array()
	}
	mut var_decoded := rt.call_function('json_decode', [var_value.clone(), rt.new_bool(true)])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.get_constant('JSON_ERROR_NONE'), rt.call_function('json_last_error', []rt.PhpVal{}))))) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Internal_Api_InvalidArgumentException', []string{}, create_automattic_woocommerce_internal_api_invalidargumentexception(rt.call_function('sprintf', [rt.new_string('Argument `%s` is not valid JSON: %s'), rt.new_string(name), rt.call_function('json_last_error_msg', []rt.PhpVal{})]))))
	}
	if rt.is_true(rt.identical(rt.new_null(), var_decoded)) {
		return rt.new_array()
	}
	if !(var_decoded.clone().is_array()) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Internal_Api_InvalidArgumentException', []string{}, create_automattic_woocommerce_internal_api_invalidargumentexception(rt.call_function('sprintf', [rt.new_string('Argument `%s` must be a JSON object (got %s).'), rt.new_string(name), rt.call_function('gettype', [var_decoded.clone()])]))))
	}
	return var_decoded.clone()
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Api_GraphQLController) get_debug_flags(mut var_request Class_Automattic_WooCommerce_Internal_Api_WP_REST_Request) i64 {
	if !(this.is_debug_mode(mut var_request)) {
		return (Class_Automattic_WooCommerce_Vendor_GraphQL_Error_DebugFlag.none()).to_i64()
	}
	return rt.bitwise_or(Class_Automattic_WooCommerce_Vendor_GraphQL_Error_DebugFlag.include_debug_message(), Class_Automattic_WooCommerce_Vendor_GraphQL_Error_DebugFlag.include_trace())
}

fn (mut this Class_Automattic_WooCommerce_Internal_Api_GraphQLController) is_introspection_allowed(mut var_request Class_Automattic_WooCommerce_Internal_Api_WP_REST_Request) bool {
	return this.is_debug_mode(mut var_request) || rt.is_true(rt.call_function('current_user_can', [rt.new_string('manage_woocommerce')]))
}

fn (mut this Class_Automattic_WooCommerce_Internal_Api_GraphQLController) is_debug_mode(mut var_request Class_Automattic_WooCommerce_Internal_Api_WP_REST_Request) bool {
	if !(this.is_local_environment()) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('manage_options')]))))) {
		return false
	}
	if rt.is_true(rt.call_function('defined', [rt.new_string('WP_DEBUG')])) && rt.is_true(rt.get_constant('WP_DEBUG')) {
		return true
	}
	return (rt.identical(rt.new_string('1'), var_request.get_param(rt.new_string('_debug')))).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Api_GraphQLController) format_exception(mut var_e Class_Automattic_WooCommerce_Internal_Api_Throwable, mut var_request Class_Automattic_WooCommerce_Internal_Api_WP_REST_Request) rt.PhpVal {
	if rt.is_true(rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Internal_Api_Throwable', []string{}, var_e), 'Automattic_WooCommerce_Api_ApiException'))) {
	mut var_error := rt.create_array([rt.ArrayItem{ key: 'message', val: var_e.getmessage() }, rt.ArrayItem{ key: 'extensions', val: rt.call_function('array_merge', [var_e.getextensions(), rt.create_array([rt.ArrayItem{ key: 'code', val: var_e.geterrorcode() }])]) }])
	} else if rt.is_true(rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Internal_Api_Throwable', []string{}, var_e), 'Automattic_WooCommerce_Internal_Api_InvalidArgumentException'))) {
	var_error = rt.create_array([rt.ArrayItem{ key: 'message', val: var_e.getmessage() }, rt.ArrayItem{ key: 'extensions', val: rt.create_array([rt.ArrayItem{ key: 'code', val: 'INVALID_ARGUMENT' }]) }])
	} else {
	var_error = rt.create_array([rt.ArrayItem{ key: 'message', val: 'An unexpected error occurred.' }, rt.ArrayItem{ key: 'extensions', val: rt.create_array([rt.ArrayItem{ key: 'code', val: 'INTERNAL_ERROR' }]) }])
	}
	if this.is_debug_mode(mut var_request) {
		var_error.array_get_mut('extensions').array_set('debug', rt.create_array([rt.ArrayItem{ key: 'message', val: var_e.getmessage() }, rt.ArrayItem{ key: 'file', val: var_e.getfile() }, rt.ArrayItem{ key: 'line', val: var_e.getline() }, rt.ArrayItem{ key: 'trace', val: var_e.gettraceasstring() }]))
		mut var_chain := this.extract_previous_chain(mut var_e)
		if !(!rt.is_true(var_chain)) {
			var_error.array_get_mut('extensions').array_get_mut('debug').array_set('previous', var_chain.clone())
		}
	}
	return var_error.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Api_GraphQLController) extract_previous_chain(mut var_e Class_Automattic_WooCommerce_Internal_Api_Throwable) rt.PhpVal {
	mut var_chain := rt.new_array()
	mut var_prev := var_e.getprevious()
	for {
		if !(rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_prev))))) { break }
		var_chain.array_push(rt.create_array([rt.ArrayItem{ key: 'class', val: rt.call_function('get_class', [var_prev.clone()]) }, rt.ArrayItem{ key: 'message', val: rt.call_method(var_prev, 'getMessage', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'file', val: rt.call_method(var_prev, 'getFile', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'line', val: rt.call_method(var_prev, 'getLine', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'trace', val: rt.call_function('explode', [rt.new_string('\n'), rt.call_method(var_prev, 'getTraceAsString', []rt.PhpVal{})]) }]))
	var_prev = rt.call_method(var_prev, 'getPrevious', []rt.PhpVal{})
	}
	return var_chain.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Api_GraphQLController) get_error_status(mut var_errors Class_Automattic_WooCommerce_Internal_Api_array) i64 {
	mut var_status := rt.new_int(200)
	mut iter_1 := var_errors.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_error := item_1.val
		mut var_code := if !(var_error.array_get(rt.new_string('extensions')).array_get(rt.new_string('code'))).is_null() { var_error.array_get(rt.new_string('extensions')).array_get(rt.new_string('code')) } else { rt.new_null() }
		mut var_mapped := if !(Class_Automattic_WooCommerce_Internal_Api_Automattic_WooCommerce_Internal_Api_GraphQLController.error_status_map().array_get(var_code)).is_null() { Class_Automattic_WooCommerce_Internal_Api_Automattic_WooCommerce_Internal_Api_GraphQLController.error_status_map().array_get(var_code) } else { rt.new_int(500) }
		if rt.is_true(rt.greater(var_mapped, var_status)) {
		var_status = var_mapped.clone()
		}
	}
	return (var_status).to_i64()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Api_GraphQLController) get_resolve_error_status(mut var_response Class_Automattic_WooCommerce_Internal_Api_array) i64 {
	mut var_code := if !(var_response.array_get(rt.new_string('errors')).array_get(rt.new_int(0)).array_get(rt.new_string('extensions')).array_get(rt.new_string('code'))).is_null() { var_response.array_get(rt.new_string('errors')).array_get(rt.new_int(0)).array_get(rt.new_string('extensions')).array_get(rt.new_string('code')) } else { rt.new_string('') }
	if rt.is_true(rt.identical(rt.new_string('PERSISTED_QUERY_NOT_FOUND'), var_code)) {
		return 200
	}
	return 400
}

fn (mut this Class_Automattic_WooCommerce_Internal_Api_GraphQLController) compute_query_depth(mut var_document Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_DocumentNode, mut var_operation_name Class_Automattic_WooCommerce_Internal_Api_?string) i64 {
	mut var_operation_name_mutated := var_operation_name
	mut var_max := rt.new_int(0)
	mut iter_2 := rt.get_property(var_document, 'definitions').iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_definition := item_2.val
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_definition, 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_OperationDefinitionNode')))))) {
			continue
		}
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_operation_name_mutated)))) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(if !(rt.get_property(rt.get_property(var_definition, 'name'), 'value')).is_null() { rt.get_property(rt.get_property(var_definition, 'name'), 'value') } else { rt.new_null() }, var_operation_name_mutated)))) {
			continue
		}
	var_max = rt.call_function('max', [var_max.clone(), rt.new_int(this.walk_depth(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Api_?SelectionSetNode](rt.get_property(var_definition, 'selectionSet')), 0))])
	}
	return (var_max).to_i64()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Api_GraphQLController) walk_depth(mut var_selection_set Class_Automattic_WooCommerce_Internal_Api_?SelectionSetNode, depth i64) i64 {
	if rt.is_true(rt.identical(rt.new_null(), var_selection_set)) {
		return depth
	}
	mut var_max := rt.new_int(depth)
	mut iter_3 := rt.get_property(var_selection_set, 'selections').iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_selection := item_3.val
		if rt.is_true(rt.new_bool(rt.instance_of(var_selection, 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_FieldNode'))) {
		var_max = rt.call_function('max', [var_max.clone(), rt.new_int(this.walk_depth(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Api_?SelectionSetNode](rt.get_property(var_selection, 'selectionSet')), depth + 1))])
		} else if rt.is_true(rt.new_bool(rt.instance_of(var_selection, 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_InlineFragmentNode'))) {
		var_max = rt.call_function('max', [var_max.clone(), rt.new_int(this.walk_depth(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Api_?SelectionSetNode](rt.get_property(var_selection, 'selectionSet')), depth))])
		}
	}
	return (var_max).to_i64()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Api_GraphQLController) document_has_mutation(mut var_document Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_DocumentNode, mut var_operation_name Class_Automattic_WooCommerce_Internal_Api_?string) bool {
	mut var_operation_name_mutated := var_operation_name
	mut iter_4 := rt.get_property(var_document, 'definitions').iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_definition := item_4.val
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_definition, 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_OperationDefinitionNode')))))) {
			continue
		}
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_operation_name_mutated)))) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(if !(rt.get_property(rt.get_property(var_definition, 'name'), 'value')).is_null() { rt.get_property(rt.get_property(var_definition, 'name'), 'value') } else { rt.new_null() }, var_operation_name_mutated)))) {
			continue
		}
		if rt.is_true(rt.identical(rt.new_string('mutation'), rt.get_property(var_definition, 'operation'))) {
			return true
		}
	}
	return false
}

fn (mut this Class_Automattic_WooCommerce_Internal_Api_GraphQLController) is_local_environment() bool {
	if rt.is_true(rt.call_function('function_exists', [rt.new_string('wp_get_environment_type')])) && rt.is_true(rt.identical(rt.new_string('local'), rt.call_function('wp_get_environment_type', []rt.PhpVal{}))) {
		return true
	}
	mut var_host := rt.call_function('wp_parse_url', [rt.call_function('get_site_url', []rt.PhpVal{}), rt.get_constant('PHP_URL_HOST')])
	if !(var_host.clone().is_string()) {
		return false
	}
	var_host = rt.new_string(var_host.clone().to_string().to_lower())
	return rt.is_true(rt.identical(rt.new_string('localhost'), var_host)) || rt.is_true(rt.identical(rt.new_string('127.0.0.1'), var_host))
}

struct Class_Automattic_WooCommerce_Internal_Api_Main {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Api_WP_REST_Response {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_QueryComplexity {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_DocumentValidator {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_QueryDepth {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_DisableIntrospection {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_GraphQL {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Api_Automattic_WooCommerce_Vendor_GraphQL_Error_FormattedError {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Api_InvalidArgumentException {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_api_graphqlcontroller(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Api_GraphQLController {
	mut obj := &Class_Automattic_WooCommerce_Internal_Api_GraphQLController{
		PhpObjectBase: rt.PhpObjectBase{}
		schema: rt.new_null()
		query_cache: rt.new_null()
	}
	return obj
}

fn create_automattic_woocommerce_internal_api_main(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Api_Main {
	mut obj := &Class_Automattic_WooCommerce_Internal_Api_Main{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_api_wp_rest_response(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Api_WP_REST_Response {
	mut obj := &Class_Automattic_WooCommerce_Internal_Api_WP_REST_Response{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_validator_rules_querycomplexity(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_QueryComplexity {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_QueryComplexity{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_validator_documentvalidator(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_DocumentValidator {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_DocumentValidator{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_validator_rules_querydepth(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_QueryDepth {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_QueryDepth{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_validator_rules_disableintrospection(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_DisableIntrospection {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_DisableIntrospection{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_graphql(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_GraphQL {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_GraphQL{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_api_automattic_woocommerce_vendor_graphql_error_formattederror(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Api_Automattic_WooCommerce_Vendor_GraphQL_Error_FormattedError {
	mut obj := &Class_Automattic_WooCommerce_Internal_Api_Automattic_WooCommerce_Vendor_GraphQL_Error_FormattedError{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_api_invalidargumentexception(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Api_InvalidArgumentException {
	mut obj := &Class_Automattic_WooCommerce_Internal_Api_InvalidArgumentException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_Api_GraphQLController) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'init' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Api_QueryCache](if args.len > 0 { args[0] } else { rt.new_null() })
			this.init(mut dispatch_arg_0)
			return rt.new_null()
		}
		'get_max_query_depth' {
			return rt.new_int(Class_Automattic_WooCommerce_Internal_Api_GraphQLController.get_max_query_depth())
		}
		'get_max_query_complexity' {
			return rt.new_int(Class_Automattic_WooCommerce_Internal_Api_GraphQLController.get_max_query_complexity())
		}
		'register' {
			this.register()
			return rt.new_null()
		}
		'handle_request' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Api_WP_REST_Request](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.handle_request(mut dispatch_arg_0)
		}
		'process_request' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Api_WP_REST_Request](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.process_request(mut dispatch_arg_0)
		}
		'get_schema' {
			return this.get_schema()
		}
		'build_schema' {
			this.build_schema()
			return rt.new_null()
		}
		'decode_json_param' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return this.decode_json_param(dispatch_arg_0, dispatch_arg_1)
		}
		'get_debug_flags' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Api_WP_REST_Request](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_int(this.get_debug_flags(mut dispatch_arg_0))
		}
		'is_introspection_allowed' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Api_WP_REST_Request](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_bool(this.is_introspection_allowed(mut dispatch_arg_0))
		}
		'is_debug_mode' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Api_WP_REST_Request](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_bool(this.is_debug_mode(mut dispatch_arg_0))
		}
		'format_exception' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Api_Throwable](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Api_WP_REST_Request](if args.len > 1 { args[1] } else { rt.new_null() })
			return this.format_exception(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		'extract_previous_chain' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Api_Throwable](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.extract_previous_chain(mut dispatch_arg_0)
		}
		'get_error_status' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Api_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_int(this.get_error_status(mut dispatch_arg_0))
		}
		'get_resolve_error_status' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Api_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_int(this.get_resolve_error_status(mut dispatch_arg_0))
		}
		'compute_query_depth' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_DocumentNode](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Api_?string](if args.len > 1 { args[1] } else { rt.new_null() })
			return rt.new_int(this.compute_query_depth(mut dispatch_arg_0, mut dispatch_arg_1))
		}
		'walk_depth' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Api_?SelectionSetNode](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			return rt.new_int(this.walk_depth(mut dispatch_arg_0, dispatch_arg_1))
		}
		'document_has_mutation' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_DocumentNode](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Api_?string](if args.len > 1 { args[1] } else { rt.new_null() })
			return rt.new_bool(this.document_has_mutation(mut dispatch_arg_0, mut dispatch_arg_1))
		}
		'is_local_environment' {
			return rt.new_bool(this.is_local_environment())
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Api_GraphQLController) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'schema' { return this.schema }
		'query_cache' { return this.query_cache }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Api_GraphQLController) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'schema' { this.schema = val; return true }
		'query_cache' { this.query_cache = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_WooCommerce_Internal_Api_Main) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Api_Main) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Api_Main) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Internal_Api_WP_REST_Response) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Api_WP_REST_Response) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Api_WP_REST_Response) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_QueryComplexity) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_QueryComplexity) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_QueryComplexity) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_DocumentValidator) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_DocumentValidator) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_DocumentValidator) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_QueryDepth) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_QueryDepth) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_QueryDepth) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_DisableIntrospection) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_DisableIntrospection) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_DisableIntrospection) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_GraphQL) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_GraphQL) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_GraphQL) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Internal_Api_Automattic_WooCommerce_Vendor_GraphQL_Error_FormattedError) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Api_Automattic_WooCommerce_Vendor_GraphQL_Error_FormattedError) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Api_Automattic_WooCommerce_Vendor_GraphQL_Error_FormattedError) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Internal_Api_InvalidArgumentException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Api_InvalidArgumentException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Api_InvalidArgumentException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}



fn main() {
	defer {
		rt.shutdown()
	}

}
