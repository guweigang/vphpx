import rt

struct Class_WC_REST_Controller {
	rt.PhpObjectBase
pub mut:
		namespace rt.PhpVal = rt.new_string('wc/v1')
		rest_base rt.PhpVal = rt.new_string('')
		_fields rt.PhpVal = rt.new_null()
		_request rt.PhpVal = rt.new_null()
}

fn (mut this Class_WC_REST_Controller) add_additional_fields_schema(var_schema rt.PhpVal) rt.PhpVal {
	mut var_schema_mutated := var_schema
	if !rt.is_true(var_schema_mutated.array_get('title')) {
		return var_schema_mutated.dup()
	}
	mut var_object_type := var_schema_mutated.array_get('title')
	mut var_additional_fields := this.get_additional_fields(var_object_type.dup())
	{
		mut iter_1 := var_additional_fields.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_field_options := item_1.val
			mut var_field_name := item_1.key
			if rt.is_true(rt.new_bool(!(rt.is_true(var_field_options.array_get('schema'))))) {
				continue
			}
			var_schema_mutated.array_get_mut('properties').array_set(var_field_name, var_field_options.array_get('schema'))
		}
	}
	var_schema_mutated.array_set('properties', rt.call_function('apply_filters', ['woocommerce_rest_' + (var_object_type).str() + '_schema', var_schema_mutated.array_get('properties')]))
	return var_schema_mutated.dup()
}

fn (mut this Class_WC_REST_Controller) get_endpoint_args_for_item_schema(var_method rt.PhpVal) rt.PhpVal {
	mut var_endpoint_args := this.Class_WP_REST_Controller.get_endpoint_args_for_item_schema(var_method.dup())
	if rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('strpos', [Class_WP_REST_Server.editable(), var_method.dup()]))) {
		return var_endpoint_args.dup()
	}
	var_endpoint_args = this.adjust_wp_5_5_datatype_compatibility(var_endpoint_args.dup())
	return var_endpoint_args.dup()
}

fn (mut this Class_WC_REST_Controller) adjust_wp_5_5_datatype_compatibility(var_endpoint_args rt.PhpVal) rt.PhpVal {
	mut var_endpoint_args_mutated := var_endpoint_args
	if rt.is_true(rt.call_function('version_compare', [rt.call_function('get_bloginfo', [rt.new_string('version')]), rt.new_string('5.5'), rt.new_string('<')])) {
		return var_endpoint_args_mutated.dup()
	}
	{
		mut iter_1 := var_endpoint_args_mutated.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_params := item_1.val
			mut var_field_id := item_1.key
			if !(var_params.array_isset(rt.new_string('type'))) {
				continue
			}
			if rt.is_true(rt.identical(rt.new_string('date-time'), var_params.array_get('type'))) {
				var_params.array_set('type', rt.create_array([rt.ArrayItem{ key: none, val: 'null' }, rt.ArrayItem{ key: none, val: 'string' }]))
			}
			if rt.is_true(rt.identical(rt.new_string('mixed'), var_params.array_get('type'))) {
				var_params.array_set('type', rt.create_array([rt.ArrayItem{ key: none, val: 'null' }, rt.ArrayItem{ key: none, val: 'object' }, rt.ArrayItem{ key: none, val: 'string' }, rt.ArrayItem{ key: none, val: 'number' }, rt.ArrayItem{ key: none, val: 'boolean' }, rt.ArrayItem{ key: none, val: 'integer' }, rt.ArrayItem{ key: none, val: 'array' }]))
			}
			if var_params.array_isset(rt.new_string('properties')) {
				var_params.array_set('properties', this.adjust_wp_5_5_datatype_compatibility(var_params.array_get('properties')))
			}
			if var_params.array_isset(rt.new_string('items')) && var_params.array_get('items').array_isset(rt.new_string('properties')) {
				var_params.array_get_mut('items').array_set('properties', this.adjust_wp_5_5_datatype_compatibility(var_params.array_get('items').array_get('properties')))
			}
			var_endpoint_args_mutated.array_set(var_field_id, var_params.dup())
		}
	}
	return var_endpoint_args_mutated.dup()
}

fn (mut this Class_WC_REST_Controller) get_normalized_rest_base() rt.PhpVal {
	return rt.call_function('preg_replace', [rt.new_string('/\\(.*\\)\\//i'), rt.new_string(''), this.rest_base])
}

fn (mut this Class_WC_REST_Controller) check_batch_limit(var_items rt.PhpVal) bool {
	mut var_items_mutated := var_items
	mut var_limit := rt.call_function('apply_filters', [rt.new_string('woocommerce_rest_batch_items_limit'), rt.new_int(100), this.get_normalized_rest_base()])
	mut var_total := rt.new_int(rt.new_int(0))
	if rt.is_true(rt.new_bool(!(!rt.is_true(var_items_mutated.array_get('create'))) && rt.is_true(rt.call_function('is_countable', [var_items_mutated.array_get('create')])))) {
		// unsupported expression: Expr_AssignOp_Plus
	}
	if rt.is_true(rt.new_bool(!(!rt.is_true(var_items_mutated.array_get('update'))) && rt.is_true(rt.call_function('is_countable', [var_items_mutated.array_get('update')])))) {
		// unsupported expression: Expr_AssignOp_Plus
	}
	if rt.is_true(rt.new_bool(!(!rt.is_true(var_items_mutated.array_get('delete'))) && rt.is_true(rt.call_function('is_countable', [var_items_mutated.array_get('delete')])))) {
		// unsupported expression: Expr_AssignOp_Plus
	}
	if rt.is_true(rt.greater(var_total, var_limit)) {
		return (create_wp_error(rt.new_string('woocommerce_rest_request_entity_too_large'), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Unable to accept more than %s items for this request.'), rt.new_string('woocommerce')]), var_limit.dup()]), rt.create_array([rt.ArrayItem{ key: 'status', val: 413 }]))).to_bool()
	}
	return true
}

fn (mut this Class_WC_REST_Controller) batch_items(var_request rt.PhpVal) rt.PhpVal {
	mut var_wp_rest_server := rt.new_null()
	// unsupported statement: Stmt_Global
	mut var_items := rt.call_function('array_filter', [rt.call_method(var_request, 'get_params', []rt.PhpVal{})])
	mut var_query := rt.call_method(var_request, 'get_query_params', []rt.PhpVal{})
	mut var_response := map[string]rt.PhpVal{}
	mut var_limit := rt.new_bool(this.check_batch_limit(var_items.dup()))
	if rt.is_true(rt.call_function('is_wp_error', [var_limit.dup()])) {
		return var_limit.dup()
	}
	if !(!rt.is_true(var_items.array_get('create'))) {
		{
			mut iter_1 := var_items.array_get('create').iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_item := item_1.val
				mut var__item := create_wp_rest_request(rt.new_string('POST'), rt.call_method(var_request, 'get_route', []rt.PhpVal{}))
				mut var_defaults := map[string]rt.PhpVal{}
				mut var_schema := this.get_public_item_schema()
				{
					mut iter_2 := var_schema.array_get('properties').iterator()
					for {
						item_2 := iter_2.next() or { break }
						mut var_options := item_2.val
						mut var_arg := item_2.key
						if var_options.array_isset(rt.new_string('default')) {
							var_defaults.array_set(var_arg, var_options.array_get('default'))
						}
					}
				}
				rt.call_method(var__item, 'set_default_params', [var_defaults.dup()])
				rt.call_method(var__item, 'set_body_params', [var_item.dup()])
				rt.call_method(var__item, 'set_query_params', [var_query.dup()])
				mut var_allowed := this.create_item_permissions_check(var__item.dup())
				if rt.is_true(rt.call_function('is_wp_error', [var_allowed.dup()])) {
					var_response.array_get_mut('create').array_push(rt.create_array([rt.ArrayItem{ key: 'id', val: 0 }, rt.ArrayItem{ key: 'error', val: rt.create_array([rt.ArrayItem{ key: 'code', val: rt.call_method(var_allowed, 'get_error_code', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'message', val: rt.call_method(var_allowed, 'get_error_message', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'data', val: rt.call_method(var_allowed, 'get_error_data', []rt.PhpVal{}) }]) }]))
					continue
				}
				mut var__response := this.create_item(var__item.dup())
				if rt.is_true(rt.call_function('is_wp_error', [var__response.dup()])) {
					var_response.array_get_mut('create').array_push(rt.create_array([rt.ArrayItem{ key: 'id', val: 0 }, rt.ArrayItem{ key: 'error', val: rt.create_array([rt.ArrayItem{ key: 'code', val: rt.call_method(var__response, 'get_error_code', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'message', val: rt.call_method(var__response, 'get_error_message', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'data', val: rt.call_method(var__response, 'get_error_data', []rt.PhpVal{}) }]) }]))
				} else {
					var_response.array_get_mut('create').array_push(rt.call_method(var_wp_rest_server, 'response_to_data', [var__response.dup(), rt.new_string('')]))
				}
			}
		}
	}
	if !(!rt.is_true(var_items.array_get('update'))) {
		{
			mut iter_1 := var_items.array_get('update').iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_item := item_1.val
				mut var__item := create_wp_rest_request(rt.new_string('PUT'), rt.call_method(var_request, 'get_route', []rt.PhpVal{}))
				rt.call_method(var__item, 'set_body_params', [var_item.dup()])
				mut var_allowed := this.update_item_permissions_check(var__item.dup())
				if rt.is_true(rt.call_function('is_wp_error', [var_allowed.dup()])) {
					var_response.array_get_mut('update').array_push(rt.create_array([rt.ArrayItem{ key: 'id', val: var__item.array_get('id') }, rt.ArrayItem{ key: 'error', val: rt.create_array([rt.ArrayItem{ key: 'code', val: rt.call_method(var_allowed, 'get_error_code', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'message', val: rt.call_method(var_allowed, 'get_error_message', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'data', val: rt.call_method(var_allowed, 'get_error_data', []rt.PhpVal{}) }]) }]))
					continue
				}
				mut var__response := this.update_item(var__item.dup())
				if rt.is_true(rt.call_function('is_wp_error', [var__response.dup()])) {
					var_response.array_get_mut('update').array_push(rt.create_array([rt.ArrayItem{ key: 'id', val: var_item.array_get('id') }, rt.ArrayItem{ key: 'error', val: rt.create_array([rt.ArrayItem{ key: 'code', val: rt.call_method(var__response, 'get_error_code', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'message', val: rt.call_method(var__response, 'get_error_message', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'data', val: rt.call_method(var__response, 'get_error_data', []rt.PhpVal{}) }]) }]))
				} else {
					var_response.array_get_mut('update').array_push(rt.call_method(var_wp_rest_server, 'response_to_data', [var__response.dup(), rt.new_string('')]))
				}
			}
		}
	}
	if !(!rt.is_true(var_items.array_get('delete'))) {
		{
			mut iter_1 := var_items.array_get('delete').iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_id := item_1.val
				var_id = if rt.is_true(rt.new_bool(var_id.dup().is_array())) { var_id } else { // unsupported expression: Expr_Cast_Int }
				if rt.is_true(rt.identical(rt.new_int(0), var_id)) {
					continue
				}
				mut var__item := create_wp_rest_request(rt.new_string('DELETE'), rt.call_method(var_request, 'get_route', []rt.PhpVal{}))
				if rt.is_true(rt.new_bool(var_id.dup().is_array())) {
					var_id.array_set('force', true)
					rt.call_method(var__item, 'set_query_params', [var_id.dup()])
				} else {
					rt.call_method(var__item, 'set_query_params', [rt.create_array([rt.ArrayItem{ key: 'id', val: var_id }, rt.ArrayItem{ key: 'force', val: true }])])
				}
				mut var_allowed := this.delete_item_permissions_check(var__item.dup())
				if rt.is_true(rt.call_function('is_wp_error', [var_allowed.dup()])) {
					var_response.array_get_mut('delete').array_push(rt.create_array([rt.ArrayItem{ key: 'id', val: var_id }, rt.ArrayItem{ key: 'error', val: rt.create_array([rt.ArrayItem{ key: 'code', val: rt.call_method(var_allowed, 'get_error_code', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'message', val: rt.call_method(var_allowed, 'get_error_message', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'data', val: rt.call_method(var_allowed, 'get_error_data', []rt.PhpVal{}) }]) }]))
					continue
				}
				mut var__response := this.delete_item(var__item.dup())
				if rt.is_true(rt.call_function('is_wp_error', [var__response.dup()])) {
					var_response.array_get_mut('delete').array_push(rt.create_array([rt.ArrayItem{ key: 'id', val: var_id }, rt.ArrayItem{ key: 'error', val: rt.create_array([rt.ArrayItem{ key: 'code', val: rt.call_method(var__response, 'get_error_code', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'message', val: rt.call_method(var__response, 'get_error_message', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'data', val: rt.call_method(var__response, 'get_error_data', []rt.PhpVal{}) }]) }]))
				} else {
					var_response.array_get_mut('delete').array_push(rt.call_method(var_wp_rest_server, 'response_to_data', [var__response.dup(), rt.new_string('')]))
				}
			}
		}
	}
	return var_response.dup()
}

fn (mut this Class_WC_REST_Controller) validate_setting_text_field(var_value rt.PhpVal, var_setting rt.PhpVal) rt.PhpVal {
	mut var_value_mutated := var_value
	var_value_mutated = if rt.is_true(rt.new_bool(var_value_mutated.dup().is_null())) { rt.new_string('') } else { var_value_mutated }
	return rt.call_function('wp_kses_post', [rt.new_string(rt.call_function('stripslashes', [var_value_mutated.dup()]).to_string().trim_space())])
}

fn (mut this Class_WC_REST_Controller) validate_setting_select_field(var_value rt.PhpVal, var_setting rt.PhpVal) rt.PhpVal {
	mut var_value_mutated := var_value
	if rt.is_true(rt.new_bool(var_setting.array_get('options').array_isset(var_value_mutated.dup()))) {
		return var_value_mutated.dup()
	} else {
		return create_wp_error(rt.new_string('rest_setting_value_invalid'), rt.call_function('__', [rt.new_string('An invalid setting value was passed.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }]))
	}
	return rt.new_null()
}

fn (mut this Class_WC_REST_Controller) validate_setting_multiselect_field(var_values rt.PhpVal, var_setting rt.PhpVal) rt.PhpVal {
	if !rt.is_true(var_values) {
		return map[string]rt.PhpVal{}
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_values.dup().is_array()))))) {
		return create_wp_error(rt.new_string('rest_setting_value_invalid'), rt.call_function('__', [rt.new_string('An invalid setting value was passed.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }]))
	}
	mut var_final_values := map[string]rt.PhpVal{}
	{
		mut iter_1 := var_values.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_value := item_1.val
			if rt.is_true(rt.new_bool(var_setting.array_get('options').array_isset(var_value.dup()))) {
				var_final_values << var_value.dup()
			}
		}
	}
	return var_final_values.dup()
}

fn (mut this Class_WC_REST_Controller) validate_setting_image_width_field(var_values rt.PhpVal, var_setting rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_values.dup().is_array()))))) {
		return create_wp_error(rt.new_string('rest_setting_value_invalid'), rt.call_function('__', [rt.new_string('An invalid setting value was passed.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }]))
	}
	mut var_current := var_setting.array_get('value')
	if var_values.array_isset(rt.new_string('width')) {
		var_current.array_set('width', var_values.array_get('width').to_i64())
	}
	if var_values.array_isset(rt.new_string('height')) {
		var_current.array_set('height', var_values.array_get('height').to_i64())
	}
	if var_values.array_isset(rt.new_string('crop')) {
		var_current.array_set('crop', // unsupported expression: Expr_Cast_Bool)
	}
	return var_current.dup()
}

fn (mut this Class_WC_REST_Controller) validate_setting_radio_field(var_value rt.PhpVal, var_setting rt.PhpVal) rt.PhpVal {
	mut var_value_mutated := var_value
	return this.validate_setting_select_field(var_value_mutated.dup(), var_setting.dup())
}

fn (mut this Class_WC_REST_Controller) validate_setting_checkbox_field(var_value rt.PhpVal, var_setting rt.PhpVal) rt.PhpVal {
	mut var_value_mutated := var_value
	if rt.is_true(rt.call_function('in_array', [var_value_mutated.dup(), rt.create_array([rt.ArrayItem{ key: none, val: 'yes' }, rt.ArrayItem{ key: none, val: 'no' }])])) {
		return var_value_mutated.dup()
	} else if !rt.is_true(var_value_mutated) {
		var_value_mutated = if var_setting.array_isset(rt.new_string('default')) { var_setting.array_get('default') } else { rt.new_string('no') }
		return var_value_mutated.dup()
	} else {
		return create_wp_error(rt.new_string('rest_setting_value_invalid'), rt.call_function('__', [rt.new_string('An invalid setting value was passed.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }]))
	}
	return rt.new_null()
}

fn (mut this Class_WC_REST_Controller) validate_setting_textarea_field(var_value rt.PhpVal, var_setting rt.PhpVal) rt.PhpVal {
	mut var_value_mutated := var_value
	var_value_mutated = if rt.is_true(rt.new_bool(.dup().is_null())) { rt.new_string('') } else { var_value_mutated }
	return rt.call_function('wp_kses_post', [rt.new_string(.to_string().trim_space())])
}

fn (mut this Class_WC_REST_Controller) add_meta_query(var_args rt.PhpVal, var_meta_query rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
	if !rt.is_true(.array_get()) {
		
	}
	
}

fn (mut this Class_WC_REST_Controller) get_public_batch_schema() rt.PhpVal {
}

fn (mut this Class_WC_REST_Controller) get_fields_for_response(var_request rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_WC_REST_Controller) get_meta_data_for_response(var_request rt.PhpVal, var_meta_data rt.PhpVal) rt.PhpVal {
	mut var_meta_data_mutated := var_meta_data
}

struct Class_WP_REST_Controller {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

struct Class_WP_REST_Request {
	rt.PhpObjectBase
}

fn create_wc_rest_controller() &Class_WC_REST_Controller {
	mut obj := &Class_WC_REST_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
		namespace: rt.new_string('wc/v1')
		rest_base: rt.new_string('')
		_fields: rt.new_null()
		_request: rt.new_null()
	}
	return obj
}

fn create_wp_rest_controller() &Class_WP_REST_Controller {
	mut obj := &Class_WP_REST_Controller{
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

fn create_wp_rest_request() &Class_WP_REST_Request {
	mut obj := &Class_WP_REST_Request{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_REST_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'add_additional_fields_schema' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.add_additional_fields_schema(dispatch_arg_0)
		}
		'get_endpoint_args_for_item_schema' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_endpoint_args_for_item_schema(dispatch_arg_0)
		}
		'adjust_wp_5_5_datatype_compatibility' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.adjust_wp_5_5_datatype_compatibility(dispatch_arg_0)
		}
		'get_normalized_rest_base' {
			return this.get_normalized_rest_base()
		}
		'check_batch_limit' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.check_batch_limit(dispatch_arg_0))
		}
		'batch_items' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.batch_items(dispatch_arg_0)
		}
		'validate_setting_text_field' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.validate_setting_text_field(dispatch_arg_0, dispatch_arg_1)
		}
		'validate_setting_select_field' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.validate_setting_select_field(dispatch_arg_0, dispatch_arg_1)
		}
		'validate_setting_multiselect_field' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.validate_setting_multiselect_field(dispatch_arg_0, dispatch_arg_1)
		}
		'validate_setting_image_width_field' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.validate_setting_image_width_field(dispatch_arg_0, dispatch_arg_1)
		}
		'validate_setting_radio_field' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.validate_setting_radio_field(dispatch_arg_0, dispatch_arg_1)
		}
		'validate_setting_checkbox_field' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.validate_setting_checkbox_field(dispatch_arg_0, dispatch_arg_1)
		}
		'validate_setting_textarea_field' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.validate_setting_textarea_field(dispatch_arg_0, dispatch_arg_1)
		}
		'add_meta_query' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.add_meta_query(dispatch_arg_0, dispatch_arg_1)
		}
		'get_public_batch_schema' {
			return this.get_public_batch_schema()
		}
		'get_fields_for_response' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_fields_for_response(dispatch_arg_0)
		}
		'get_meta_data_for_response' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.get_meta_data_for_response(dispatch_arg_0, dispatch_arg_1)
		}
		else { return none }
	}
}

fn (this &Class_WC_REST_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'namespace' { return this.namespace }
		'rest_base' { return this.rest_base }
		'_fields' { return this._fields }
		'_request' { return this._request }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_REST_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'namespace' { this.namespace = val; return true }
		'rest_base' { this.rest_base = val; return true }
		'_fields' { this._fields = val; return true }
		'_request' { this._request = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_WP_REST_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_REST_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_REST_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_WP_REST_Request) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_REST_Request) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_REST_Request) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_includes_rest_api_controllers_version3_class_wc_rest_controller_php() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))))) {
		// unsupported expression: Expr_Exit
	}
}
