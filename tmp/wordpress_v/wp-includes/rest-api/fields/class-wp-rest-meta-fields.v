import rt

struct Class_WP_REST_Meta_Fields {
	rt.PhpObjectBase
}

fn (mut this Class_WP_REST_Meta_Fields) get_meta_type()  {
}

fn (mut this Class_WP_REST_Meta_Fields) get_meta_subtype() string {
	return ''
}

fn (mut this Class_WP_REST_Meta_Fields) get_rest_field_type()  {
}

fn (mut this Class_WP_REST_Meta_Fields) register_field()  {
	rt.call_function('_deprecated_function', [rt.new_string(@METHOD), rt.new_string('5.6.0')])
	rt.call_function('register_rest_field', [this.get_rest_field_type(), rt.new_string('meta'), rt.create_array([rt.ArrayItem{ key: 'get_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Meta_Fields', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'get_value' }]) }, rt.ArrayItem{ key: 'update_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Meta_Fields', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'update_value' }]) }, rt.ArrayItem{ key: 'schema', val: this.get_field_schema() }])])
}

fn (mut this Class_WP_REST_Meta_Fields) get_value(var_object_id rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
	mut var_fields := this.get_registered_fields()
	mut var_response := rt.new_array()
	{
		mut iter_1 := var_fields.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_args := item_1.val
			mut var_meta_key := item_1.key
			mut var_name := var_args.array_get('name')
			mut var_all_values := rt.call_function('get_metadata', [this.get_meta_type(), var_object_id.dup(), var_meta_key.dup(), rt.new_bool(false)])
			if rt.is_true(var_args.array_get('single')) {
				if !rt.is_true(var_all_values) {
					mut var_value := var_args.array_get('schema').array_get('default')
				} else {
					var_value = var_all_values.array_get(0)
				}
				var_value = this.prepare_value_for_response(var_value.dup(), var_request.dup(), var_args.dup())
			} else {
				var_value = rt.new_array()
				if rt.is_true(rt.new_bool(var_all_values.dup().is_array())) {
					{
						mut iter_2 := var_all_values.iterator()
						for {
							item_2 := iter_2.next() or { break }
							mut var_row := item_2.val
							var_value.array_push(this.prepare_value_for_response(var_row.dup(), var_request.dup(), var_args.dup()))
						}
					}
				}
			}
			var_response.array_set(var_name, var_value.dup())
		}
	}
	return var_response.dup()
}

fn (mut this Class_WP_REST_Meta_Fields) prepare_value_for_response(var_value rt.PhpVal, var_request rt.PhpVal, var_args rt.PhpVal) rt.PhpVal {
	mut var_value_mutated := var_value
	mut var_args_mutated := var_args
	if !(!rt.is_true(var_args_mutated.array_get('prepare_callback'))) {
		var_value_mutated = rt.call_function('call_user_func', [var_args_mutated.array_get('prepare_callback'), var_value_mutated.dup(), var_request.dup(), var_args_mutated.dup()])
	}
	return var_value_mutated.dup()
}

fn (mut this Class_WP_REST_Meta_Fields) update_value(var_meta rt.PhpVal, var_object_id rt.PhpVal) rt.PhpVal {
	mut var_fields := this.get_registered_fields()
	mut var_error := create_wp_error()
	{
		mut iter_1 := var_fields.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_args := item_1.val
			mut var_meta_key := item_1.key
			mut var_name := var_args.array_get('name')
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_meta.dup().array_isset(var_name.dup())))))) {
				continue
			}
			mut var_value := var_meta.array_get(var_name)
			if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_value.dup().is_null())) || rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_array(), var_value)) && rt.is_true(rt.new_bool(!(rt.is_true(var_args.array_get('single'))))))))) {
				var_args = this.get_registered_fields().array_get(var_meta_key)
				if rt.is_true(var_args.array_get('single')) {
					mut var_current := rt.call_function('get_metadata', [this.get_meta_type(), var_object_id.dup(), var_meta_key.dup(), rt.new_bool(true)])
					if rt.is_true(rt.call_function('is_wp_error', [rt.call_function('rest_validate_value_from_schema', [var_current.dup(), var_args.array_get('schema')])])) {
						var_error.add(rt.new_string('rest_invalid_stored_value'), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('The %s property has an invalid stored value, and cannot be updated to null.')]), var_name.dup()]), rt.create_array([rt.ArrayItem{ key: 'status', val: 500 }]))
						continue
					}
				}
				mut var_result := rt.new_bool(this.delete_meta_value(var_object_id.dup(), var_meta_key.dup(), var_name.dup()))
				if rt.is_true(rt.call_function('is_wp_error', [var_result.dup()])) {
					var_error.merge_from(var_result.dup())
				}
				continue
			}
			if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_args.array_get('single'))))) && rt.is_true(rt.new_bool(var_value.dup().is_array())))) && rt.is_true(rt.new_int(rt.call_function('array_filter', [var_value.dup(), rt.new_string('is_null')]).array_count())))) {
				var_error.add(rt.new_string('rest_invalid_stored_value'), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('The %s property has an invalid stored value, and cannot be updated to null.')]), var_name.dup()]), rt.create_array([rt.ArrayItem{ key: 'status', val: 500 }]))
				continue
			}
			mut var_is_valid := rt.call_function('rest_validate_value_from_schema', [var_value.dup(), var_args.array_get('schema'), 'meta.' + (var_name).str()])
			if rt.is_true(rt.call_function('is_wp_error', [var_is_valid.dup()])) {
				rt.call_method(var_is_valid, 'add_data', [rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }])])
				var_error.merge_from(var_is_valid.dup())
				continue
			}
			var_value = rt.call_function('rest_sanitize_value_from_schema', [var_value.dup(), var_args.array_get('schema')])
			if rt.is_true(var_args.array_get('single')) {
				var_result = rt.new_bool(this.update_meta_value(var_object_id.dup(), var_meta_key.dup(), var_name.dup(), var_value.dup()))
			} else {
				var_result = rt.new_bool(this.update_multi_meta_value(var_object_id.dup(), var_meta_key.dup(), var_name.dup(), var_value.dup()))
			}
			if rt.is_true(rt.call_function('is_wp_error', [var_result.dup()])) {
				var_error.merge_from(var_result.dup())
				continue
			}
		}
	}
	if rt.is_true(var_error.has_errors()) {
		return rt.new_object('WP_Error', []string{}, var_error)
	}
	return rt.new_null()
}

fn (mut this Class_WP_REST_Meta_Fields) delete_meta_value(var_object_id rt.PhpVal, var_meta_key rt.PhpVal, var_name rt.PhpVal) bool {
	mut var_name_mutated := var_name
	mut var_meta_type := this.get_meta_type()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string("delete_${var_meta_type.to_string()}_meta"), var_object_id.dup(), var_meta_key.dup()]))))) {
		return (create_wp_error(rt.new_string('rest_cannot_delete'), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Sorry, you are not allowed to edit the %s custom field.')]), var_name_mutated.dup()]), rt.create_array([rt.ArrayItem{ key: 'key', val: var_name_mutated }, rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code', []rt.PhpVal{}) }]))).to_bool()
	}
	if rt.is_true(rt.identical(rt.new_null(), rt.call_function('get_metadata_raw', [var_meta_type.dup(), var_object_id.dup(), rt.call_function('wp_slash', [var_meta_key.dup()])]))) {
		return true
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('delete_metadata', [var_meta_type.dup(), var_object_id.dup(), rt.call_function('wp_slash', [var_meta_key.dup()])]))))) {
		return (create_wp_error(rt.new_string('rest_meta_database_error'), rt.call_function('__', [rt.new_string('Could not delete meta value from database.')]), rt.create_array([rt.ArrayItem{ key: 'key', val: var_name_mutated }, rt.ArrayItem{ key: 'status', val: Class_WP_Http.internal_server_error() }]))).to_bool()
	}
	return true
}

fn (mut this Class_WP_REST_Meta_Fields) update_multi_meta_value(var_object_id rt.PhpVal, var_meta_key rt.PhpVal, var_name rt.PhpVal, var_values rt.PhpVal) bool {
	mut var_name_mutated := var_name
	mut var_meta_type := this.get_meta_type()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string("edit_${var_meta_type.to_string()}_meta"), var_object_id.dup(), var_meta_key.dup()]))))) {
		return (create_wp_error(rt.new_string('rest_cannot_update'), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Sorry, you are not allowed to edit the %s custom field.')]), var_name_mutated.dup()]), rt.create_array([rt.ArrayItem{ key: 'key', val: var_name_mutated }, rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code', []rt.PhpVal{}) }]))).to_bool()
	}
	mut var_current_values := rt.call_function('get_metadata_raw', [var_meta_type.dup(), var_object_id.dup(), var_meta_key.dup(), rt.new_bool(false)])
	mut var_subtype := rt.call_function('get_object_subtype', [var_meta_type.dup(), var_object_id.dup()])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_current_values.dup().is_array()))))) {
		var_current_values = rt.new_array()
	}
	mut var_to_remove := var_current_values.dup()
	mut var_to_add := var_values
	{
		mut iter_1 := var_to_add.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_value := item_1.val
			mut var_add_key := item_1.key
			closure_1_fn := fn [var_meta_key, var_subtype, var_value] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_stored_value := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return (this.is_meta_value_same_as_stored_value(var_meta_key.dup(), var_subtype.dup(), var_stored_value.dup(), var_value.dup())).to_bool()
	}
			mut var_remove_keys := rt.func_array_keys(rt.call_function('array_filter', [var_current_values.dup(), rt.new_closure(closure_1_fn)]))
			if !rt.is_true(var_remove_keys) {
				continue
			}
			if var_remove_keys.dup().array_count() > 1 {
				continue
			}
			mut var_remove_key := var_remove_keys.array_get(0)
			var_to_remove.array_unset(var_remove_key)
			var_to_add.array_unset(var_add_key)
		}
	}
	var_to_remove = rt.call_function('array_map', [rt.new_string('maybe_unserialize'), rt.call_function('array_unique', [rt.call_function('array_map', [rt.new_string('maybe_serialize'), var_to_remove.dup()])])])
	{
		mut iter_1 := var_to_remove.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_value := item_1.val
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('delete_metadata', [var_meta_type.dup(), var_object_id.dup(), rt.call_function('wp_slash', [var_meta_key.dup()]), rt.call_function('wp_slash', [var_value.dup()])]))))) {
				return (create_wp_error(rt.new_string('rest_meta_database_error'), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Could not update the meta value of %s in database.')]), var_meta_key.dup()]), rt.create_array([rt.ArrayItem{ key: 'key', val: var_name_mutated }, rt.ArrayItem{ key: 'status', val: Class_WP_Http.internal_server_error() }]))).to_bool()
			}
		}
	}
	{
		mut iter_1 := var_to_add.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_value := item_1.val
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('add_metadata', [var_meta_type.dup(), var_object_id.dup(), rt.call_function('wp_slash', [var_meta_key.dup()]), rt.call_function('wp_slash', [var_value.dup()])]))))) {
				return (create_wp_error(rt.new_string('rest_meta_database_error'), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Could not update the meta value of %s in database.')]), var_meta_key.dup()]), rt.create_array([rt.ArrayItem{ key: 'key', val: var_name_mutated }, rt.ArrayItem{ key: 'status', val: Class_WP_Http.internal_server_error() }]))).to_bool()
			}
		}
	}
	return true
}

fn (mut this Class_WP_REST_Meta_Fields) update_meta_value(var_object_id rt.PhpVal, var_meta_key rt.PhpVal, var_name rt.PhpVal, var_value rt.PhpVal) bool {
	mut var_name_mutated := var_name
	mut var_value_mutated := var_value
	mut var_meta_type := this.get_meta_type()
	mut var_old_value := rt.call_function('get_metadata_raw', [var_meta_type.dup(), var_object_id.dup(), var_meta_key.dup()])
	mut var_subtype := rt.call_function('get_object_subtype', [var_meta_type.dup(), var_object_id.dup()])
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_old_value.dup().is_array())) && 1 == var_old_value.dup().array_count())) && rt.is_true(this.is_meta_value_same_as_stored_value(var_meta_key.dup(), var_subtype.dup(), var_old_value.array_get(0), var_value_mutated.dup())))) {
		return true
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string("edit_${var_meta_type.to_string()}_meta"), var_object_id.dup(), var_meta_key.dup()]))))) {
		return (create_wp_error(rt.new_string('rest_cannot_update'), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Sorry, you are not allowed to edit the %s custom field.')]), var_name_mutated.dup()]), rt.create_array([rt.ArrayItem{ key: 'key', val: var_name_mutated }, rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code', []rt.PhpVal{}) }]))).to_bool()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('update_metadata', [var_meta_type.dup(), var_object_id.dup(), rt.call_function('wp_slash', [var_meta_key.dup()]), rt.call_function('wp_slash', [var_value_mutated.dup()])]))))) {
		return (create_wp_error(rt.new_string('rest_meta_database_error'), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Could not update the meta value of %s in database.')]), var_meta_key.dup()]), rt.create_array([rt.ArrayItem{ key: 'key', val: var_name_mutated }, rt.ArrayItem{ key: 'status', val: Class_WP_Http.internal_server_error() }]))).to_bool()
	}
	return true
}

fn (mut this Class_WP_REST_Meta_Fields) is_meta_value_same_as_stored_value(var_meta_key rt.PhpVal, var_subtype rt.PhpVal, var_stored_value rt.PhpVal, var_user_value rt.PhpVal) rt.PhpVal {
	mut var_subtype_mutated := var_subtype
	mut var_args := this.get_registered_fields().array_get(var_meta_key)
	mut var_sanitized := rt.call_function('sanitize_meta', [var_meta_key.dup(), var_user_value.dup(), this.get_meta_type(), var_subtype_mutated.dup()])
	if rt.is_true(rt.call_function('in_array', [var_args.array_get('type'), rt.create_array([rt.ArrayItem{ key: none, val: 'string' }, rt.ArrayItem{ key: none, val: 'number' }, rt.ArrayItem{ key: none, val: 'integer' }, rt.ArrayItem{ key: none, val: 'boolean' }]), rt.new_bool(true)])) {
		var_sanitized = // unsupported expression: Expr_Cast_String
	}
	return rt.identical(var_sanitized, var_stored_value)
}

fn (mut this Class_WP_REST_Meta_Fields) get_registered_fields() rt.PhpVal {
	mut var_registered := rt.new_array()
	mut var_meta_type := this.get_meta_type()
	mut var_meta_subtype := rt.new_string(this.get_meta_subtype())
	mut var_meta_keys := rt.call_function('get_registered_meta_keys', [var_meta_type.dup()])
	if !(!rt.is_true(var_meta_subtype)) {
		var_meta_keys = rt.call_function('array_merge', [var_meta_keys.dup(), rt.call_function('get_registered_meta_keys', [var_meta_type.dup(), var_meta_subtype.dup()])])
	}
	{
		mut iter_1 := var_meta_keys.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_args := item_1.val
			mut var_name := item_1.key
			if !rt.is_true(var_args.array_get('show_in_rest')) {
				continue
			}
			mut var_rest_args := rt.new_array()
			if rt.is_true(rt.new_bool(var_args.array_get('show_in_rest').is_array())) {
				var_rest_args = var_args.array_get('show_in_rest')
			}
			mut var_default_args := { 'name': var_name, 'single': var_args.array_get('single'), 'type': if !(!rt.is_true(var_args.array_get('type'))) { var_args.array_get('type') } else { rt.new_null() }, 'schema': rt.new_array(), 'prepare_callback': map[string]rt.PhpVal{} }
			mut var_default_schema := { 'type': var_default_args['type'], 'title': if !rt.is_true(var_args.array_get('label')) { rt.new_string('') } else { var_args.array_get('label') }, 'description': if !rt.is_true(var_args.array_get('description')) { rt.new_string('') } else { var_args.array_get('description') }, 'default': if !(var_args.array_get('default')).is_null() { var_args.array_get('default') } else { rt.new_null() } }
			var_rest_args = rt.call_function('array_merge', [var_default_args.dup(), var_rest_args.dup()])
			var_rest_args.array_set('schema', rt.call_function('array_merge', [var_default_schema.dup(), var_rest_args.array_get('schema')]))
			mut var_type := if !(!rt.is_true(var_rest_args.array_get('type'))) { var_rest_args.array_get('type') } else { rt.new_null() }
			var_type = if !(!rt.is_true(.array_get())) { .array_get() } else { var_type }
			if rt.is_true(rt.identical(rt.new_null(), .array_get())) {
				.array_get_mut().array_set(, )
			}
			.array_set(, )
			if rt.is_true() {
			}
			if !rt.is_true() {
			}
			
		}
	}
}

fn (mut this Class_WP_REST_Meta_Fields) get_field_schema() rt.PhpVal {
}

fn Class_WP_REST_Meta_Fields.prepare_value(var_value rt.PhpVal, var_request rt.PhpVal, var_args rt.PhpVal) rt.PhpVal {
	mut var_value_mutated := var_value
	mut var_args_mutated := var_args
}

fn (mut this Class_WP_REST_Meta_Fields) check_meta_is_array(var_value rt.PhpVal, var_request rt.PhpVal, var_param rt.PhpVal) bool {
	mut var_value_mutated := var_value
}

fn (mut this Class_WP_REST_Meta_Fields) default_additional_properties_to_false(var_schema rt.PhpVal) rt.PhpVal {
	mut var_schema_mutated := var_schema
}

fn Class_WP_REST_Meta_Fields.get_empty_value_for_type(var_type rt.PhpVal)  {
	mut var_type_mutated := var_type
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

fn create_wp_rest_meta_fields() &Class_WP_REST_Meta_Fields {
	mut obj := &Class_WP_REST_Meta_Fields{
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

fn (mut this Class_WP_REST_Meta_Fields) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_meta_type' {
			this.get_meta_type()
			return rt.new_null()
		}
		'get_meta_subtype' {
			return rt.new_string(this.get_meta_subtype())
		}
		'get_rest_field_type' {
			this.get_rest_field_type()
			return rt.new_null()
		}
		'register_field' {
			this.register_field()
			return rt.new_null()
		}
		'get_value' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.get_value(dispatch_arg_0, dispatch_arg_1)
		}
		'prepare_value_for_response' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.prepare_value_for_response(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'update_value' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.update_value(dispatch_arg_0, dispatch_arg_1)
		}
		'delete_meta_value' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return rt.new_bool(this.delete_meta_value(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2))
		}
		'update_multi_meta_value' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			return rt.new_bool(this.update_multi_meta_value(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3))
		}
		'update_meta_value' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			return rt.new_bool(this.update_meta_value(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3))
		}
		'is_meta_value_same_as_stored_value' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			return this.is_meta_value_same_as_stored_value(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
		}
		'get_registered_fields' {
			return this.get_registered_fields()
		}
		'get_field_schema' {
			return this.get_field_schema()
		}
		'prepare_value' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return Class_WP_REST_Meta_Fields.prepare_value(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'check_meta_is_array' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return rt.new_bool(this.check_meta_is_array(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2))
		}
		'default_additional_properties_to_false' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.default_additional_properties_to_false(dispatch_arg_0)
		}
		'get_empty_value_for_type' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			Class_WP_REST_Meta_Fields.get_empty_value_for_type(dispatch_arg_0)
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_WP_REST_Meta_Fields) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_REST_Meta_Fields) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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




pub fn init_wp_includes_rest_api_fields_class_wp_rest_meta_fields_php() {
}
