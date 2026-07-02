import rt

struct Class_WP_REST_Controller {
	rt.PhpObjectBase
pub mut:
		namespace rt.PhpVal = rt.new_null()
		rest_base rt.PhpVal = rt.new_null()
		schema rt.PhpVal = rt.new_null()
}

fn (mut this Class_WP_REST_Controller) register_routes() {
	rt.call_function('_doing_it_wrong', [rt.new_string('WP_REST_Controller::register_routes'), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Method \'%s\' must be overridden.')]), rt.new_string(@METHOD)]), rt.new_string('4.7.0')])
}

fn (mut this Class_WP_REST_Controller) get_items_permissions_check(var_request rt.PhpVal) rt.PhpVal {
	return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('invalid-method'), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Method \'%s\' not implemented. Must be overridden in subclass.')]), rt.new_string(@METHOD)]), rt.create_array([rt.ArrayItem{ key: 'status', val: 405 }])))
}

fn (mut this Class_WP_REST_Controller) get_items(var_request rt.PhpVal) rt.PhpVal {
	return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('invalid-method'), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Method \'%s\' not implemented. Must be overridden in subclass.')]), rt.new_string(@METHOD)]), rt.create_array([rt.ArrayItem{ key: 'status', val: 405 }])))
}

fn (mut this Class_WP_REST_Controller) get_item_permissions_check(var_request rt.PhpVal) rt.PhpVal {
	return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('invalid-method'), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Method \'%s\' not implemented. Must be overridden in subclass.')]), rt.new_string(@METHOD)]), rt.create_array([rt.ArrayItem{ key: 'status', val: 405 }])))
}

fn (mut this Class_WP_REST_Controller) get_item(var_request rt.PhpVal) rt.PhpVal {
	return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('invalid-method'), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Method \'%s\' not implemented. Must be overridden in subclass.')]), rt.new_string(@METHOD)]), rt.create_array([rt.ArrayItem{ key: 'status', val: 405 }])))
}

fn (mut this Class_WP_REST_Controller) create_item_permissions_check(var_request rt.PhpVal) rt.PhpVal {
	return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('invalid-method'), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Method \'%s\' not implemented. Must be overridden in subclass.')]), rt.new_string(@METHOD)]), rt.create_array([rt.ArrayItem{ key: 'status', val: 405 }])))
}

fn (mut this Class_WP_REST_Controller) create_item(var_request rt.PhpVal) rt.PhpVal {
	return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('invalid-method'), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Method \'%s\' not implemented. Must be overridden in subclass.')]), rt.new_string(@METHOD)]), rt.create_array([rt.ArrayItem{ key: 'status', val: 405 }])))
}

fn (mut this Class_WP_REST_Controller) update_item_permissions_check(var_request rt.PhpVal) rt.PhpVal {
	return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('invalid-method'), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Method \'%s\' not implemented. Must be overridden in subclass.')]), rt.new_string(@METHOD)]), rt.create_array([rt.ArrayItem{ key: 'status', val: 405 }])))
}

fn (mut this Class_WP_REST_Controller) update_item(var_request rt.PhpVal) rt.PhpVal {
	return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('invalid-method'), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Method \'%s\' not implemented. Must be overridden in subclass.')]), rt.new_string(@METHOD)]), rt.create_array([rt.ArrayItem{ key: 'status', val: 405 }])))
}

fn (mut this Class_WP_REST_Controller) delete_item_permissions_check(var_request rt.PhpVal) rt.PhpVal {
	return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('invalid-method'), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Method \'%s\' not implemented. Must be overridden in subclass.')]), rt.new_string(@METHOD)]), rt.create_array([rt.ArrayItem{ key: 'status', val: 405 }])))
}

fn (mut this Class_WP_REST_Controller) delete_item(var_request rt.PhpVal) rt.PhpVal {
	return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('invalid-method'), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Method \'%s\' not implemented. Must be overridden in subclass.')]), rt.new_string(@METHOD)]), rt.create_array([rt.ArrayItem{ key: 'status', val: 405 }])))
}

fn (mut this Class_WP_REST_Controller) prepare_item_for_database(var_request rt.PhpVal) rt.PhpVal {
	return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('invalid-method'), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Method \'%s\' not implemented. Must be overridden in subclass.')]), rt.new_string(@METHOD)]), rt.create_array([rt.ArrayItem{ key: 'status', val: 405 }])))
}

fn (mut this Class_WP_REST_Controller) prepare_item_for_response(var_item rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
	return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('invalid-method'), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Method \'%s\' not implemented. Must be overridden in subclass.')]), rt.new_string(@METHOD)]), rt.create_array([rt.ArrayItem{ key: 'status', val: 405 }])))
}

fn (mut this Class_WP_REST_Controller) prepare_response_for_collection(var_response rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_response, 'WP_REST_Response')))))) {
		return var_response.clone()
	}
	mut var_data := rt.cast_array(rt.call_method(var_response, 'get_data', []rt.PhpVal{}))
	mut var_server := rt.call_function('rest_get_server', []rt.PhpVal{})
	mut iife_temp_0 := Class_{"nodeType":"Expr_Variable","line":278,"name":"server"}{}
	mut iife_result_0 := iife_temp_0.get_compact_response_links(var_response.clone())
	mut var_links := iife_result_0
	if !(!rt.is_true(var_links)) {
		var_data.array_set('_links', var_links.clone())
	}
	return var_data.clone()
}

fn (mut this Class_WP_REST_Controller) filter_response_by_context(var_response_data rt.PhpVal, var_context rt.PhpVal) rt.PhpVal {
	mut var_response_data_mutated := var_response_data
	mut var_context_mutated := var_context
	mut var_schema := this.get_item_schema()
	return rt.call_function('rest_filter_response_by_context', [var_response_data_mutated.clone(), var_schema.clone(), var_context_mutated.clone()])
}

fn (mut this Class_WP_REST_Controller) get_item_schema() rt.PhpVal {
	return this.add_additional_fields_schema(rt.new_array())
}

fn (mut this Class_WP_REST_Controller) get_public_item_schema() rt.PhpVal {
	mut var_schema := this.get_item_schema()
	if !(!rt.is_true(var_schema.array_get(rt.new_string('properties')))) {
		mut iter_1 := var_schema.array_get(rt.new_string('properties')).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_property := item_1.val
			var_property.array_unset(rt.new_string('arg_options'))
		}
	}
	return var_schema.clone()
}

fn (mut this Class_WP_REST_Controller) get_collection_params() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: 'context', val: this.get_context_param(rt.new_null()) }, rt.ArrayItem{ key: 'page', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Current page of the collection.')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }, rt.ArrayItem{ key: 'default', val: 1 }, rt.ArrayItem{ key: 'sanitize_callback', val: 'absint' }, rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' }, rt.ArrayItem{ key: 'minimum', val: 1 }]) }, rt.ArrayItem{ key: 'per_page', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Maximum number of items to be returned in result set.')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }, rt.ArrayItem{ key: 'default', val: 10 }, rt.ArrayItem{ key: 'minimum', val: 1 }, rt.ArrayItem{ key: 'maximum', val: 100 }, rt.ArrayItem{ key: 'sanitize_callback', val: 'absint' }, rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' }]) }, rt.ArrayItem{ key: 'search', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Limit results to those matching a string.')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'sanitize_callback', val: 'sanitize_text_field' }, rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' }]) }])
}

fn (mut this Class_WP_REST_Controller) get_context_param(var_args rt.PhpVal) rt.PhpVal {
	mut var_param_details := { 'description': rt.call_function('__', [rt.new_string('Scope under which the request is made; determines fields present in response.')]), 'type': rt.new_string('string'), 'sanitize_callback': rt.new_string('sanitize_key'), 'validate_callback': rt.new_string('rest_validate_request_arg') }
	mut var_schema := this.get_item_schema()
	if !rt.is_true(var_schema.array_get(rt.new_string('properties'))) {
		return rt.call_function('array_merge', [rt.create_array_from_native_map(var_param_details), var_args.clone()])
	}
	mut var_contexts := rt.new_array()
	mut iter_2 := var_schema.array_get(rt.new_string('properties')).iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_attributes := item_2.val
		if !(!rt.is_true(var_attributes.array_get(rt.new_string('context')))) {
		var_contexts = rt.call_function('array_merge', [var_contexts.clone(), var_attributes.array_get(rt.new_string('context'))])
		}
	}
	if !(!rt.is_true(var_contexts)) {
		var_param_details['enum'] = rt.call_function('array_unique', [var_contexts.clone()])
		rt.call_function('rsort', [var_param_details['enum']])
	}
	return rt.call_function('array_merge', [rt.create_array_from_native_map(var_param_details), var_args.clone()])
}

fn (mut this Class_WP_REST_Controller) add_additional_fields_to_object(var_response_data rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
	mut var_response_data_mutated := var_response_data
	mut var_additional_fields := this.get_additional_fields(rt.new_null())
	mut var_requested_fields := this.get_fields_for_response(var_request.clone())
	mut iter_3 := var_additional_fields.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_field_options := item_3.val
		mut var_field_name := item_3.key
		if rt.is_true(rt.new_bool(!(rt.is_true(var_field_options.array_get(rt.new_string('get_callback')))))) {
			continue
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('rest_is_field_included', [var_field_name.clone(), var_requested_fields.clone()]))))) {
			continue
		}
		var_response_data_mutated.array_set(var_field_name, rt.call_function('call_user_func', [var_field_options.array_get(rt.new_string('get_callback')), var_response_data_mutated.clone(), var_field_name.clone(), var_request.clone(), this.get_object_type()]))
	}
	return var_response_data_mutated.clone()
}

fn (mut this Class_WP_REST_Controller) update_additional_fields_for_object(var_data_object rt.PhpVal, var_request rt.PhpVal) bool {
	mut var_additional_fields := this.get_additional_fields(rt.new_null())
	mut iter_4 := var_additional_fields.iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_field_options := item_4.val
		mut var_field_name := item_4.key
		if rt.is_true(rt.new_bool(!(rt.is_true(var_field_options.array_get(rt.new_string('update_callback')))))) {
			continue
		}
		if !(var_request.array_isset(var_field_name)) {
			continue
		}
		mut var_result := rt.call_function('call_user_func', [var_field_options.array_get(rt.new_string('update_callback')), var_request.array_get(var_field_name), var_data_object.clone(), var_field_name.clone(), var_request.clone(), this.get_object_type()])
		if rt.is_true(rt.call_function('is_wp_error', [var_result.clone()])) {
			return (var_result).to_bool()
		}
	}
	return true
}

fn (mut this Class_WP_REST_Controller) add_additional_fields_schema(var_schema rt.PhpVal) rt.PhpVal {
	mut var_schema_mutated := var_schema
	if !rt.is_true(var_schema_mutated.array_get(rt.new_string('title'))) {
		return var_schema_mutated.clone()
	}
	mut var_object_type := var_schema_mutated.array_get(rt.new_string('title'))
	mut var_additional_fields := this.get_additional_fields(var_object_type.clone())
	mut iter_5 := var_additional_fields.iterator()
	for {
		item_5 := iter_5.next() or { break }
		mut var_field_options := item_5.val
		mut var_field_name := item_5.key
		if rt.is_true(rt.new_bool(!(rt.is_true(var_field_options.array_get(rt.new_string('schema')))))) {
			continue
		}
		var_schema_mutated.array_get_mut('properties').array_set(var_field_name, var_field_options.array_get(rt.new_string('schema')))
	}
	return var_schema_mutated.clone()
}

fn (mut this Class_WP_REST_Controller) get_additional_fields(var_object_type rt.PhpVal) rt.PhpVal {
	mut var_wp_rest_additional_fields := rt.new_null()
	mut var_object_type_mutated := var_object_type
	if rt.is_true(rt.new_bool(!(rt.is_true(var_object_type_mutated)))) {
	var_object_type_mutated = this.get_object_type()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_object_type_mutated)))) {
		return rt.new_array()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_wp_rest_additional_fields)))) || !(var_wp_rest_additional_fields.array_isset(var_object_type_mutated)) {
		return rt.new_array()
	}
	return var_wp_rest_additional_fields.array_get(var_object_type_mutated)
}

fn (mut this Class_WP_REST_Controller) get_object_type() rt.PhpVal {
	mut var_schema := this.get_item_schema()
	if rt.is_true(rt.new_bool(!(rt.is_true(var_schema)))) || !(var_schema.array_isset(rt.new_string('title'))) {
		return rt.new_null()
	}
	return var_schema.array_get(rt.new_string('title'))
}

fn (mut this Class_WP_REST_Controller) get_fields_for_response(var_request rt.PhpVal) rt.PhpVal {
	mut var_schema := this.get_item_schema()
	mut var_properties := if !(var_schema.array_get(rt.new_string('properties'))).is_null() { var_schema.array_get(rt.new_string('properties')) } else { rt.new_array() }
	mut var_additional_fields := this.get_additional_fields(rt.new_null())
	mut iter_6 := var_additional_fields.iterator()
	for {
		item_6 := iter_6.next() or { break }
		mut var_field_options := item_6.val
		mut var_field_name := item_6.key
		if rt.is_true(rt.new_bool(var_field_options.array_get(rt.new_string('schema')).is_null())) {
			var_properties.array_set(var_field_name, var_field_options.clone())
		}
	}
	mut var_context := var_request.array_get(rt.new_string('context'))
	if rt.is_true(var_context) {
		mut iter_7 := var_properties.iterator()
		for {
			item_7 := iter_7.next() or { break }
			mut var_options := item_7.val
			mut var_name := item_7.key
			if !(!rt.is_true(var_options.array_get(rt.new_string('context')))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_context.clone(), var_options.array_get(rt.new_string('context')), rt.new_bool(true)]))))) {
				var_properties.array_unset(var_name)
			}
		}
	}
	mut var_fields := rt.func_array_keys(var_properties.clone())
	var_fields.array_push('_links')
	if rt.is_true(rt.call_method(var_request, 'has_param', [rt.new_string('_embed')])) {
		var_fields.array_push('_embedded')
	}
	var_fields = rt.call_function('array_unique', [var_fields.clone()])
	if !(var_request.array_isset(rt.new_string('_fields'))) {
		return var_fields.clone()
	}
	mut var_requested_fields := rt.call_function('wp_parse_list', [var_request.array_get(rt.new_string('_fields'))])
	if 0 == var_requested_fields.clone().array_count() {
		return var_fields.clone()
	}
	var_requested_fields = rt.call_function('array_map', [rt.new_string('trim'), var_requested_fields.clone()])
	if rt.is_true(rt.call_function('in_array', [rt.new_string('id'), var_fields.clone(), rt.new_bool(true)])) {
		var_requested_fields.array_push('id')
	}
	closure_2_fn := fn [var_fields] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_response_fields := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_field := if args.len > 1 { args[1].clone() } else { rt.new_null() }
		if rt.is_true(rt.call_function('in_array', [var_field.clone(), var_fields.clone(), rt.new_bool(true)])) {
			var_response_fields.array_push(var_field.clone())
			return var_response_fields.clone()
		}
		mut var_nested_fields := rt.call_function('explode', [rt.new_string('.'), var_field.clone()])
		if rt.is_true(rt.call_function('in_array', [var_nested_fields.array_get(rt.new_int(0)), var_fields.clone(), rt.new_bool(true)])) {
			var_response_fields.array_push(var_field.clone())
		}
		return var_response_fields.clone()
		}
	return rt.call_function('array_reduce', [var_requested_fields.clone(), rt.new_closure(closure_2_fn), rt.new_array()])
}

fn (mut this Class_WP_REST_Controller) get_endpoint_args_for_item_schema(var_method rt.PhpVal) rt.PhpVal {
	return rt.call_function('rest_get_endpoint_args_for_schema', [this.get_item_schema(), var_method.clone()])
}

fn (mut this Class_WP_REST_Controller) sanitize_slug(var_slug rt.PhpVal) rt.PhpVal {
	return rt.call_function('sanitize_title', [var_slug.clone()])
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

struct Class_{"nodeType":"Expr_Variable","line":278,"name":"server"} {
	rt.PhpObjectBase
}

fn create_wp_rest_controller(_args ...rt.PhpVal) &Class_WP_REST_Controller {
	mut obj := &Class_WP_REST_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
		namespace: rt.new_null()
		rest_base: rt.new_null()
		schema: rt.new_null()
	}
	return obj
}

fn create_wp_error(_args ...rt.PhpVal) &Class_WP_Error {
	mut obj := &Class_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_{"nodetype":"expr_variable","line":278,"name":"server"}(_args ...rt.PhpVal) &Class_{"nodeType":"Expr_Variable","line":278,"name":"server"} {
	mut obj := &Class_{"nodeType":"Expr_Variable","line":278,"name":"server"}{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_REST_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'register_routes' {
			this.register_routes()
			return rt.new_null()
		}
		'get_items_permissions_check' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_items_permissions_check(dispatch_arg_0)
		}
		'get_items' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_items(dispatch_arg_0)
		}
		'get_item_permissions_check' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_item_permissions_check(dispatch_arg_0)
		}
		'get_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_item(dispatch_arg_0)
		}
		'create_item_permissions_check' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.create_item_permissions_check(dispatch_arg_0)
		}
		'create_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.create_item(dispatch_arg_0)
		}
		'update_item_permissions_check' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.update_item_permissions_check(dispatch_arg_0)
		}
		'update_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.update_item(dispatch_arg_0)
		}
		'delete_item_permissions_check' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.delete_item_permissions_check(dispatch_arg_0)
		}
		'delete_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.delete_item(dispatch_arg_0)
		}
		'prepare_item_for_database' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.prepare_item_for_database(dispatch_arg_0)
		}
		'prepare_item_for_response' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.prepare_item_for_response(dispatch_arg_0, dispatch_arg_1)
		}
		'prepare_response_for_collection' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.prepare_response_for_collection(dispatch_arg_0)
		}
		'filter_response_by_context' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.filter_response_by_context(dispatch_arg_0, dispatch_arg_1)
		}
		'get_item_schema' {
			return this.get_item_schema()
		}
		'get_public_item_schema' {
			return this.get_public_item_schema()
		}
		'get_collection_params' {
			return this.get_collection_params()
		}
		'get_context_param' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_context_param(dispatch_arg_0)
		}
		'add_additional_fields_to_object' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.add_additional_fields_to_object(dispatch_arg_0, dispatch_arg_1)
		}
		'update_additional_fields_for_object' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(this.update_additional_fields_for_object(dispatch_arg_0, dispatch_arg_1))
		}
		'add_additional_fields_schema' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.add_additional_fields_schema(dispatch_arg_0)
		}
		'get_additional_fields' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_additional_fields(dispatch_arg_0)
		}
		'get_object_type' {
			return this.get_object_type()
		}
		'get_fields_for_response' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_fields_for_response(dispatch_arg_0)
		}
		'get_endpoint_args_for_item_schema' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_endpoint_args_for_item_schema(dispatch_arg_0)
		}
		'sanitize_slug' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.sanitize_slug(dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_WP_REST_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'namespace' { return this.namespace }
		'rest_base' { return this.rest_base }
		'schema' { return this.schema }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_REST_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'namespace' { this.namespace = val; return true }
		'rest_base' { this.rest_base = val; return true }
		'schema' { this.schema = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
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


fn (mut this Class_{"nodeType":"Expr_Variable","line":278,"name":"server"}) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_{"nodeType":"Expr_Variable","line":278,"name":"server"}) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_{"nodeType":"Expr_Variable","line":278,"name":"server"}) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}



fn main() {
	defer {
		rt.shutdown()
	}

}
