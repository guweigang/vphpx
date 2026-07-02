import rt

struct Class_WC_REST_Controller {
	rt.PhpObjectBase
pub mut:
	namespace rt.PhpVal = rt.new_string('wc/v1')
	rest_base rt.PhpVal = rt.new_string('')
	_fields   rt.PhpVal = rt.new_null()
	_request  rt.PhpVal = rt.new_null()
}

fn (mut this Class_WC_REST_Controller) add_additional_fields_schema(var_schema rt.PhpVal) rt.PhpVal {
	mut var_schema_mutated := var_schema
	if !rt.is_true(var_schema_mutated.array_get(rt.new_string('title'))) {
		return var_schema_mutated.clone()
	}
	mut var_object_type := var_schema_mutated.array_get(rt.new_string('title'))
	mut var_additional_fields := this.get_additional_fields(var_object_type.clone())
	mut iter_1 := var_additional_fields.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_field_options := item_1.val
		mut var_field_name := item_1.key
		if rt.is_true(rt.new_bool(!(rt.is_true(var_field_options.array_get(rt.new_string('schema')))))) {
			continue
		}
		var_schema_mutated.array_get_mut('properties').array_set(var_field_name,
			var_field_options.array_get(rt.new_string('schema')))
	}
	var_schema_mutated.array_set('properties', rt.call_function('apply_filters', [
		rt.new_string('woocommerce_rest_' + var_object_type.str() + '_schema'),
		var_schema_mutated.array_get(rt.new_string('properties')),
	]))
	return var_schema_mutated.clone()
}

fn (mut this Class_WC_REST_Controller) get_endpoint_args_for_item_schema(var_method rt.PhpVal) rt.PhpVal {
	mut var_endpoint_args :=
		this.Class_WP_REST_Controller.get_endpoint_args_for_item_schema(var_method.clone())
	if rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('strpos', [
		Class_WP_REST_Server.editable(),
		var_method.clone(),
	])))
	{
		return var_endpoint_args.clone()
	}
	var_endpoint_args = this.adjust_wp_5_5_datatype_compatibility(var_endpoint_args.clone())
	return var_endpoint_args.clone()
}

fn (mut this Class_WC_REST_Controller) adjust_wp_5_5_datatype_compatibility(var_endpoint_args rt.PhpVal) rt.PhpVal {
	mut var_endpoint_args_mutated := var_endpoint_args
	if rt.is_true(rt.call_function('version_compare', [
		rt.call_function('get_bloginfo', [rt.new_string('version')]),
		rt.new_string('5.5'),
		rt.new_string('<'),
	]))
	{
		return var_endpoint_args_mutated.clone()
	}
	mut iter_2 := var_endpoint_args_mutated.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_params := item_2.val
		mut var_field_id := item_2.key
		if !(var_params.array_isset(rt.new_string('type'))) {
			continue
		}
		if rt.is_true(rt.identical(rt.new_string('date-time'),
			var_params.array_get(rt.new_string('type'))))
		{
			var_params.array_set('type', rt.create_array([
				rt.ArrayItem{ key: none, val: 'null' },
				rt.ArrayItem{ key: none, val: 'string' },
			]))
		}
		if rt.is_true(rt.identical(rt.new_string('mixed'),
			var_params.array_get(rt.new_string('type'))))
		{
			var_params.array_set('type', rt.create_array([
				rt.ArrayItem{ key: none, val: 'null' },
				rt.ArrayItem{ key: none, val: 'object' },
				rt.ArrayItem{ key: none, val: 'string' },
				rt.ArrayItem{ key: none, val: 'number' },
				rt.ArrayItem{ key: none, val: 'boolean' },
				rt.ArrayItem{ key: none, val: 'integer' },
				rt.ArrayItem{ key: none, val: 'array' },
			]))
		}
		if var_params.array_isset(rt.new_string('properties')) {
			var_params.array_set('properties',
				this.adjust_wp_5_5_datatype_compatibility(var_params.array_get(rt.new_string('properties'))))
		}
		if var_params.array_isset(rt.new_string('items'))
			&& var_params.array_get(rt.new_string('items')).array_isset(rt.new_string('properties')) {
			var_params.array_get_mut('items').array_set('properties',
				this.adjust_wp_5_5_datatype_compatibility(var_params.array_get(rt.new_string('items')).array_get(rt.new_string('properties'))))
		}
		var_endpoint_args_mutated.array_set(var_field_id, var_params.clone())
	}
	return var_endpoint_args_mutated.clone()
}

fn (mut this Class_WC_REST_Controller) get_normalized_rest_base() rt.PhpVal {
	return rt.call_function('preg_replace', [rt.new_string('/\\(.*\\)\\//i'),
		rt.new_string(''), this.rest_base])
}

fn (mut this Class_WC_REST_Controller) check_batch_limit(var_items rt.PhpVal) bool {
	mut var_items_mutated := var_items
	mut var_limit := rt.call_function('apply_filters', [
		rt.new_string('woocommerce_rest_batch_items_limit'),
		rt.new_int(100),
		this.get_normalized_rest_base(),
	])
	mut var_total := rt.new_int(0)
	if !(!rt.is_true(var_items_mutated.array_get(rt.new_string('create'))))
		&& rt.call_function('is_countable', [var_items_mutated.array_get(rt.new_string('create'))]) {
		var_total = rt.add(var_total,
			rt.new_int(var_items_mutated.array_get(rt.new_string('create')).array_count()))
	}
	if !(!rt.is_true(var_items_mutated.array_get(rt.new_string('update'))))
		&& rt.call_function('is_countable', [var_items_mutated.array_get(rt.new_string('update'))]) {
		var_total = rt.add(var_total,
			rt.new_int(var_items_mutated.array_get(rt.new_string('update')).array_count()))
	}
	if !(!rt.is_true(var_items_mutated.array_get(rt.new_string('delete'))))
		&& rt.call_function('is_countable', [var_items_mutated.array_get(rt.new_string('delete'))]) {
		var_total = rt.add(var_total,
			rt.new_int(var_items_mutated.array_get(rt.new_string('delete')).array_count()))
	}
	if rt.is_true(rt.greater(var_total, var_limit)) {
		return (create_wp_error(rt.new_string('woocommerce_rest_request_entity_too_large'), rt.call_function('sprintf', [
			rt.call_function('__', [
				rt.new_string('Unable to accept more than %s items for this request.'),
				rt.new_string('woocommerce'),
			]),
			var_limit.clone(),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 413 }]))).to_bool()
	}
	return true
}

fn (mut this Class_WC_REST_Controller) batch_items(var_request rt.PhpVal) rt.PhpVal {
	mut var_wp_rest_server := rt.new_null()
	mut var_items := rt.call_function('array_filter', [
		rt.call_method(var_request, 'get_params', []rt.PhpVal{}),
	])
	mut var_query := rt.call_method(var_request, 'get_query_params', []rt.PhpVal{})
	mut var_response := map[string]rt.PhpVal{}
	mut var_limit := rt.new_bool(this.check_batch_limit(var_items.clone()))
	if rt.is_true(rt.call_function('is_wp_error', [var_limit.clone()])) {
		return var_limit.clone()
	}
	if !(!rt.is_true(var_items.array_get(rt.new_string('create')))) {
		mut iter_3 := var_items.array_get(rt.new_string('create')).iterator()
		for {
			item_3 := iter_3.next() or { break }
			mut var_item := item_3.val
			mut var__item := create_wp_rest_request(rt.new_string('POST'), rt.call_method(var_request,
				'get_route', []rt.PhpVal{}))
			mut var_defaults := map[string]rt.PhpVal{}
			mut var_schema := this.get_public_item_schema()
			mut iter_4 := var_schema.array_get(rt.new_string('properties')).iterator()
			for {
				item_4 := iter_4.next() or { break }
				mut var_options := item_4.val
				mut var_arg := item_4.key
				if var_options.array_isset(rt.new_string('default')) {
					var_defaults.array_set(var_arg, var_options.array_get(rt.new_string('default')))
				}
			}
			rt.call_method(var__item, 'set_default_params', [
				var_defaults.clone()])
			rt.call_method(var__item, 'set_body_params', [var_item.clone()])
			rt.call_method(var__item, 'set_query_params', [var_query.clone()])
			mut var_allowed := this.create_item_permissions_check(var__item.clone())
			if rt.is_true(rt.call_function('is_wp_error', [var_allowed.clone()])) {
				var_response.array_get_mut('create').array_push(rt.create_array([
					rt.ArrayItem{ key: 'id', val: 0 },
					rt.ArrayItem{ key: 'error', val: rt.create_array([
						rt.ArrayItem{ key: 'code', val: rt.call_method(var_allowed,
							'get_error_code', []rt.PhpVal{}) },
						rt.ArrayItem{ key: 'message', val: rt.call_method(var_allowed,
							'get_error_message', []rt.PhpVal{}) },
						rt.ArrayItem{ key: 'data', val: rt.call_method(var_allowed,
							'get_error_data', []rt.PhpVal{}) },
					]) },
				]))
				continue
			}
			mut var__response := this.create_item(var__item.clone())
			if rt.is_true(rt.call_function('is_wp_error', [var__response.clone()])) {
				var_response.array_get_mut('create').array_push(rt.create_array([
					rt.ArrayItem{ key: 'id', val: 0 },
					rt.ArrayItem{ key: 'error', val: rt.create_array([
						rt.ArrayItem{ key: 'code', val: rt.call_method(var__response,
							'get_error_code', []rt.PhpVal{}) },
						rt.ArrayItem{ key: 'message', val: rt.call_method(var__response,
							'get_error_message', []rt.PhpVal{}) },
						rt.ArrayItem{ key: 'data', val: rt.call_method(var__response,
							'get_error_data', []rt.PhpVal{}) },
					]) },
				]))
			} else {
				var_response.array_get_mut('create').array_push(rt.call_method(var_wp_rest_server,
					'response_to_data', [var__response.clone(),
					rt.new_string('')]))
			}
		}
	}
	if !(!rt.is_true(var_items.array_get(rt.new_string('update')))) {
		mut iter_5 := var_items.array_get(rt.new_string('update')).iterator()
		for {
			item_5 := iter_5.next() or { break }
			mut var_item := item_5.val
			mut var__item := create_wp_rest_request(rt.new_string('PUT'), rt.call_method(var_request,
				'get_route', []rt.PhpVal{}))
			rt.call_method(var__item, 'set_body_params', [var_item.clone()])
			mut var_allowed := this.update_item_permissions_check(var__item.clone())
			if rt.is_true(rt.call_function('is_wp_error', [var_allowed.clone()])) {
				var_response.array_get_mut('update').array_push(rt.create_array([
					rt.ArrayItem{ key: 'id', val: var__item.array_get(rt.new_string('id')) },
					rt.ArrayItem{ key: 'error', val: rt.create_array([
						rt.ArrayItem{ key: 'code', val: rt.call_method(var_allowed,
							'get_error_code', []rt.PhpVal{}) },
						rt.ArrayItem{ key: 'message', val: rt.call_method(var_allowed,
							'get_error_message', []rt.PhpVal{}) },
						rt.ArrayItem{ key: 'data', val: rt.call_method(var_allowed,
							'get_error_data', []rt.PhpVal{}) },
					]) },
				]))
				continue
			}
			mut var__response := this.update_item(var__item.clone())
			if rt.is_true(rt.call_function('is_wp_error', [var__response.clone()])) {
				var_response.array_get_mut('update').array_push(rt.create_array([
					rt.ArrayItem{ key: 'id', val: var_item.array_get(rt.new_string('id')) },
					rt.ArrayItem{ key: 'error', val: rt.create_array([
						rt.ArrayItem{ key: 'code', val: rt.call_method(var__response,
							'get_error_code', []rt.PhpVal{}) },
						rt.ArrayItem{ key: 'message', val: rt.call_method(var__response,
							'get_error_message', []rt.PhpVal{}) },
						rt.ArrayItem{ key: 'data', val: rt.call_method(var__response,
							'get_error_data', []rt.PhpVal{}) },
					]) },
				]))
			} else {
				var_response.array_get_mut('update').array_push(rt.call_method(var_wp_rest_server,
					'response_to_data', [var__response.clone(),
					rt.new_string('')]))
			}
		}
	}
	if !(!rt.is_true(var_items.array_get(rt.new_string('delete')))) {
		mut iter_6 := var_items.array_get(rt.new_string('delete')).iterator()
		for {
			item_6 := iter_6.next() or { break }
			mut var_id := item_6.val
			var_id = if var_id.clone().is_array() { var_id } else { rt.new_int(var_id.to_i64()) }
			if rt.is_true(rt.identical(rt.new_int(0), var_id)) {
				continue
			}
			mut var__item := create_wp_rest_request(rt.new_string('DELETE'), rt.call_method(var_request,
				'get_route', []rt.PhpVal{}))
			if rt.is_true(rt.new_bool(var_id.clone().is_array())) {
				var_id.array_set('force', true)
				rt.call_method(var__item, 'set_query_params', [
					var_id.clone()])
			} else {
				rt.call_method(var__item, 'set_query_params', [
					rt.create_array([rt.ArrayItem{ key: 'id', val: var_id },
						rt.ArrayItem{ key: 'force', val: true }]),
				])
			}
			mut var_allowed := this.delete_item_permissions_check(var__item.clone())
			if rt.is_true(rt.call_function('is_wp_error', [var_allowed.clone()])) {
				var_response.array_get_mut('delete').array_push(rt.create_array([
					rt.ArrayItem{ key: 'id', val: var_id },
					rt.ArrayItem{ key: 'error', val: rt.create_array([
						rt.ArrayItem{ key: 'code', val: rt.call_method(var_allowed,
							'get_error_code', []rt.PhpVal{}) },
						rt.ArrayItem{ key: 'message', val: rt.call_method(var_allowed,
							'get_error_message', []rt.PhpVal{}) },
						rt.ArrayItem{ key: 'data', val: rt.call_method(var_allowed,
							'get_error_data', []rt.PhpVal{}) },
					]) },
				]))
				continue
			}
			mut var__response := this.delete_item(var__item.clone())
			if rt.is_true(rt.call_function('is_wp_error', [var__response.clone()])) {
				var_response.array_get_mut('delete').array_push(rt.create_array([
					rt.ArrayItem{ key: 'id', val: var_id },
					rt.ArrayItem{ key: 'error', val: rt.create_array([
						rt.ArrayItem{ key: 'code', val: rt.call_method(var__response,
							'get_error_code', []rt.PhpVal{}) },
						rt.ArrayItem{ key: 'message', val: rt.call_method(var__response,
							'get_error_message', []rt.PhpVal{}) },
						rt.ArrayItem{ key: 'data', val: rt.call_method(var__response,
							'get_error_data', []rt.PhpVal{}) },
					]) },
				]))
			} else {
				var_response.array_get_mut('delete').array_push(rt.call_method(var_wp_rest_server,
					'response_to_data', [var__response.clone(),
					rt.new_string('')]))
			}
		}
	}
	return var_response.clone()
}

fn (mut this Class_WC_REST_Controller) validate_setting_text_field(var_value rt.PhpVal, var_setting rt.PhpVal) rt.PhpVal {
	mut var_value_mutated := var_value
	var_value_mutated = if var_value_mutated.clone().is_null() {
		rt.new_string('')
	} else {
		var_value_mutated
	}
	return rt.call_function('wp_kses_post', [
		rt.new_string(rt.call_function('stripslashes', [var_value_mutated.clone()]).to_string().trim_space()),
	])
}

fn (mut this Class_WC_REST_Controller) validate_setting_select_field(var_value rt.PhpVal, var_setting rt.PhpVal) rt.PhpVal {
	mut var_value_mutated := var_value
	if rt.is_true(rt.new_bool(var_setting.array_get(rt.new_string('options')).array_isset(var_value_mutated.clone()))) {
		return var_value_mutated.clone()
	} else {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('rest_setting_value_invalid'), rt.call_function('__', [
			rt.new_string('An invalid setting value was passed.'),
			rt.new_string('woocommerce'),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }])))
	}
	return rt.new_null()
}

fn (mut this Class_WC_REST_Controller) validate_setting_multiselect_field(var_values rt.PhpVal, var_setting rt.PhpVal) rt.PhpVal {
	if !rt.is_true(var_values) {
		return map[string]rt.PhpVal{}
	}
	if !(var_values.clone().is_array()) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('rest_setting_value_invalid'), rt.call_function('__', [
			rt.new_string('An invalid setting value was passed.'),
			rt.new_string('woocommerce'),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }])))
	}
	mut var_final_values := map[string]rt.PhpVal{}
	mut iter_7 := var_values.iterator()
	for {
		item_7 := iter_7.next() or { break }
		mut var_value := item_7.val
		if rt.is_true(rt.new_bool(var_setting.array_get(rt.new_string('options')).array_isset(var_value.clone()))) {
			var_final_values << var_value.clone()
		}
	}
	return var_final_values.clone()
}

fn (mut this Class_WC_REST_Controller) validate_setting_image_width_field(var_values rt.PhpVal, var_setting rt.PhpVal) rt.PhpVal {
	if !(var_values.clone().is_array()) {
		return create_wp_error(rt.new_string('rest_setting_value_invalid'), rt.call_function('__', [
			rt.new_string('An invalid setting value was passed.'),
			rt.new_string('woocommerce'),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }]))
	}
	mut var_current := var_setting.array_get(rt.new_string('value'))
	if var_values.array_isset(rt.new_string('width')) {
		var_current.array_set('width', var_values.array_get(rt.new_string('width')).to_i64())
	}
	if var_values.array_isset(rt.new_string('height')) {
		var_current.array_set('height', var_values.array_get(rt.new_string('height')).to_i64())
	}
	if var_values.array_isset(rt.new_string('crop')) {
		var_current.array_set('crop', (var_values.array_get(rt.new_string('crop'))).to_bool())
	}
	return var_current.clone()
}

fn (mut this Class_WC_REST_Controller) validate_setting_radio_field(var_value rt.PhpVal, var_setting rt.PhpVal) rt.PhpVal {
	mut var_value_mutated := var_value
	return this.validate_setting_select_field(var_value_mutated.clone(), var_setting.clone())
}

fn (mut this Class_WC_REST_Controller) validate_setting_checkbox_field(var_value rt.PhpVal, var_setting rt.PhpVal) rt.PhpVal {
	mut var_value_mutated := var_value
	if rt.is_true(rt.call_function('in_array', [var_value_mutated.clone(),
		rt.create_array([rt.ArrayItem{ key: none, val: 'yes' },
			rt.ArrayItem{ key: none, val: 'no' }])]))
	{
		return var_value_mutated.clone()
	} else if !rt.is_true(var_value_mutated) {
		var_value_mutated = if var_setting.array_isset(rt.new_string('default')) {
			var_setting.array_get(rt.new_string('default'))
		} else {
			rt.new_string('no')
		}
		return var_value_mutated.clone()
	} else {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('rest_setting_value_invalid'), rt.call_function('__', [
			rt.new_string('An invalid setting value was passed.'),
			rt.new_string('woocommerce'),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }])))
	}
	return rt.new_null()
}

fn (mut this Class_WC_REST_Controller) validate_setting_textarea_field(var_value rt.PhpVal, var_setting rt.PhpVal) rt.PhpVal {
	mut var_value_mutated := var_value
	var_value_mutated = if var_value_mutated.clone().is_null() {
		rt.new_string('')
	} else {
		var_value_mutated
	}
	return rt.call_function('wp_kses_post', [
		rt.new_string(rt.call_function('stripslashes', [var_value_mutated.clone()]).to_string().trim_space()),
	])
}

fn (mut this Class_WC_REST_Controller) add_meta_query(var_args rt.PhpVal, var_meta_query rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
	if !rt.is_true(var_args_mutated.array_get(rt.new_string('meta_query'))) {
		var_args_mutated.array_set('meta_query', map[string]rt.PhpVal{})
	}
	var_args_mutated.array_get_mut('meta_query').array_push(var_meta_query.clone())
	return var_args_mutated.array_get(rt.new_string('meta_query'))
}

fn (mut this Class_WC_REST_Controller) get_public_batch_schema() rt.PhpVal {
	mut var_schema := rt.create_array([
		rt.ArrayItem{ key: '$schema', val: 'http://json-schema.org/draft-04/schema#' },
		rt.ArrayItem{ key: 'title', val: 'batch' },
		rt.ArrayItem{ key: 'type', val: 'object' },
		rt.ArrayItem{ key: 'properties', val: rt.create_array([
			rt.ArrayItem{ key: 'create', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('List of created resources.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'array' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'items', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'object' },
				]) },
			]) },
			rt.ArrayItem{ key: 'update', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('List of updated resources.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'array' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'items', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'object' },
				]) },
			]) },
			rt.ArrayItem{ key: 'delete', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('List of delete resources.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'array' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'items', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'integer' },
				]) },
			]) },
		]) },
	])
	return var_schema.clone()
}

fn (mut this Class_WC_REST_Controller) get_fields_for_response(var_request rt.PhpVal) rt.PhpVal {
	if !(this._fields).is_null() && this._fields.is_array()
		&& rt.is_true(rt.identical(var_request, this._request)) {
		return this._fields
	}
	this._request = var_request.clone()
	mut var_schema := this.get_item_schema()
	mut var_properties := if var_schema.array_isset(rt.new_string('properties')) {
		var_schema.array_get(rt.new_string('properties'))
	} else {
		map[string]rt.PhpVal{}
	}
	mut var_additional_fields := this.get_additional_fields()
	mut iter_8 := var_additional_fields.iterator()
	for {
		item_8 := iter_8.next() or { break }
		mut var_field_options := item_8.val
		mut var_field_name := item_8.key
		if rt.is_true(rt.new_bool(var_field_options.array_get(rt.new_string('schema')).is_null())) {
			var_properties.array_set(var_field_name, var_field_options.clone())
		}
	}
	mut var_context := var_request.array_get(rt.new_string('context'))
	if rt.is_true(var_context) {
		mut iter_9 := var_properties.iterator()
		for {
			item_9 := iter_9.next() or { break }
			mut var_options := item_9.val
			mut var_name := item_9.key
			if !(!rt.is_true(var_options.array_get(rt.new_string('context'))))
				&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_context.clone(), var_options.array_get(rt.new_string('context')), rt.new_bool(true)]))))) {
				var_properties.array_unset(var_name)
			}
		}
	}
	mut var_fields := rt.func_array_keys(var_properties.clone())
	if !(var_request.array_isset(rt.new_string('_fields'))) {
		this._fields = var_fields.clone()
		return var_fields.clone()
	}
	mut var_requested_fields := rt.call_function('wp_parse_list', [
		var_request.array_get(rt.new_string('_fields')),
	])
	if 0 == var_requested_fields.clone().array_count() {
		this._fields = var_fields.clone()
		return var_fields.clone()
	}
	var_requested_fields = rt.call_function('array_map', [rt.new_string('trim'),
		var_requested_fields.clone()])
	if rt.is_true(rt.call_function('in_array', [rt.new_string('id'),
		var_fields.clone(), rt.new_bool(true)]))
	{
		var_requested_fields.array_push('id')
	}
	closure_1_fn := fn [var_fields] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_response_fields := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_field := if args.len > 1 { args[1].clone() } else { rt.new_null() }
		if rt.is_true(rt.call_function('in_array', [var_field.clone(),
			var_fields.clone(), rt.new_bool(true)]))
		{
			var_response_fields.array_push(var_field.clone())
			return var_response_fields.clone()
		}
		mut var_nested_fields := rt.call_function('explode', [
			rt.new_string('.'), var_field.clone()])
		if rt.is_true(rt.call_function('in_array', [var_nested_fields.array_get(rt.new_int(0)),
			var_fields.clone(), rt.new_bool(true)]))
		{
			var_response_fields.array_push(var_field.clone())
		}
		return var_response_fields.clone()
	}
	this._fields = rt.call_function('array_reduce', [var_requested_fields.clone(),
		rt.new_closure(closure_1_fn), map[string]rt.PhpVal{}])
	return this._fields
}

fn (mut this Class_WC_REST_Controller) get_meta_data_for_response(var_request rt.PhpVal, var_meta_data rt.PhpVal) rt.PhpVal {
	mut var_meta_data_mutated := var_meta_data
	mut var_fields := this.get_fields_for_response(var_request.clone())
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
		rt.new_string('meta_data'),
		var_fields.clone(),
		rt.new_bool(true),
	])))))
	{
		return map[string]rt.PhpVal{}
	}
	mut var_include := rt.cast_array(var_request.array_get(rt.new_string('include_meta')))
	mut var_exclude := rt.cast_array(var_request.array_get(rt.new_string('exclude_meta')))
	if !(!rt.is_true(var_include)) {
		closure_2_fn := fn [var_include] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_item := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			mut var_data := rt.call_method(var_item, 'get_data', []rt.PhpVal{})
			return rt.call_function('in_array', [var_data.array_get(rt.new_string('key')),
				var_include.clone(), rt.new_bool(true)])
		}
		var_meta_data_mutated = rt.call_function('array_filter', [
			var_meta_data_mutated.clone(), rt.new_closure(closure_2_fn)])
	} else if !(!rt.is_true(var_exclude)) {
		closure_3_fn := fn [var_exclude] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_item := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			mut var_data := rt.call_method(var_item, 'get_data', []rt.PhpVal{})
			return rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
				var_data.array_get(rt.new_string('key')),
				var_exclude.clone(),
				rt.new_bool(true),
			]))))
		}
		var_meta_data_mutated = rt.call_function('array_filter', [
			var_meta_data_mutated.clone(), rt.new_closure(closure_3_fn)])
	}
	return rt.call_function('array_values', [var_meta_data_mutated.clone()])
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

fn create_wc_rest_controller(_args ...rt.PhpVal) &Class_WC_REST_Controller {
	mut obj := &Class_WC_REST_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
		namespace:     rt.new_string('wc/v1')
		rest_base:     rt.new_string('')
		_fields:       rt.new_null()
		_request:      rt.new_null()
	}
	return obj
}

fn create_wp_rest_controller(_args ...rt.PhpVal) &Class_WP_REST_Controller {
	mut obj := &Class_WP_REST_Controller{
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

fn create_wp_rest_request(_args ...rt.PhpVal) &Class_WP_REST_Request {
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
		else {
			return none
		}
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
		'namespace' {
			this.namespace = val
			return true
		}
		'rest_base' {
			this.rest_base = val
			return true
		}
		'_fields' {
			this._fields = val
			return true
		}
		'_request' {
			this._request = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
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

fn main() {
	defer {
		rt.shutdown()
	}

	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		exit(0)
	}
}
