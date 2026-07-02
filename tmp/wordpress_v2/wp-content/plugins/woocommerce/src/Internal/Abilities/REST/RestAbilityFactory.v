import rt

struct Class_Automattic_WooCommerce_Internal_Abilities_REST_RestAbilityFactory {
	rt.PhpObjectBase
}

fn init_static_automattic_woocommerce_internal_abilities_rest_restabilityfactory() {
		rt.init_static_prop('Automattic_WooCommerce_Internal_Abilities_REST_RestAbilityFactory', 'valid_types', rt.create_array([rt.ArrayItem{ key: none, val: 'string' }, rt.ArrayItem{ key: none, val: 'number' }, rt.ArrayItem{ key: none, val: 'integer' }, rt.ArrayItem{ key: none, val: 'boolean' }, rt.ArrayItem{ key: none, val: 'object' }, rt.ArrayItem{ key: none, val: 'array' }, rt.ArrayItem{ key: none, val: 'null' }]))
}

fn Class_Automattic_WooCommerce_Internal_Abilities_REST_RestAbilityFactory.register_controller_abilities(mut var_config Class_Automattic_WooCommerce_Internal_Abilities_REST_array) {
	mut var_controller_class := var_config.array_get(rt.new_string('controller'))
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [var_controller_class.clone()]))))) {
		return
	}
	mut var_controller := rt.create_object_dynamically(var_controller_class, []rt.PhpVal{})
	mut iter_1 := var_config.array_get(rt.new_string('abilities')).iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_ability_config := item_1.val
		Class_Automattic_WooCommerce_Internal_Abilities_REST_RestAbilityFactory.register_single_ability(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Abilities_REST_array](var_controller), (var_ability_config).str(), var_config.array_get(rt.new_string('route')))
	}
}

fn Class_Automattic_WooCommerce_Internal_Abilities_REST_RestAbilityFactory.register_single_ability(var_controller rt.PhpVal, mut var_ability_config Class_Automattic_WooCommerce_Internal_Abilities_REST_array, route string) {
	mut var_controller_mutated := var_controller
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('wp_register_ability')]))))) {
		return
	}
	closure_1_fn := fn [var_controller, var_ability_config, var_route] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_input := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return
		}
	closure_2_fn := fn [var_controller, var_ability_config] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		return
		}
	mut var_ability_args := rt.create_array([rt.ArrayItem{ key: 'label', val: var_ability_config.array_get(rt.new_string('label')) }, rt.ArrayItem{ key: 'description', val: var_ability_config.array_get(rt.new_string('description')) }, rt.ArrayItem{ key: 'category', val: 'woocommerce-rest' }, rt.ArrayItem{ key: 'input_schema', val: Class_Automattic_WooCommerce_Internal_Abilities_REST_RestAbilityFactory.get_schema_for_operation((var_controller_mutated).str(), var_ability_config.array_get(rt.new_string('operation'))) }, rt.ArrayItem{ key: 'output_schema', val: Class_Automattic_WooCommerce_Internal_Abilities_REST_RestAbilityFactory.get_output_schema((var_controller_mutated).str(), var_ability_config.array_get(rt.new_string('operation'))) }, rt.ArrayItem{ key: 'execute_callback', val: rt.new_closure(closure_1_fn) }, rt.ArrayItem{ key: 'permission_callback', val: rt.new_closure(closure_2_fn) }, rt.ArrayItem{ key: 'ability_class', val: Class_Automattic_WooCommerce_Internal_Abilities_REST_RestAbility.class() }, rt.ArrayItem{ key: 'meta', val: rt.create_array([rt.ArrayItem{ key: 'show_in_rest', val: true }]) }])
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	if rt.is_true(rt.call_function('in_array', [var_ability_config.array_get(rt.new_string('operation')), rt.create_array([rt.ArrayItem{ key: none, val: 'list' }, rt.ArrayItem{ key: none, val: 'get' }]), rt.new_bool(true)])) {
		var_ability_args.array_get_mut('meta').array_set('annotations', rt.create_array([rt.ArrayItem{ key: 'readonly', val: true }]))
		if rt.has_exception() { unsafe { goto catch_label_1 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	rt.call_function('wp_register_ability', [var_ability_config.array_get(rt.new_string('id')), var_ability_args.clone()])
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	unsafe { goto end_label_1 }

catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'Automattic_WooCommerce_Internal_Abilities_REST_Throwable') {
		mut var_e := var_e_1.clone()
		if rt.is_true(rt.call_function('function_exists', [rt.new_string('wc_get_logger')])) {
			rt.call_method(rt.call_function('wc_get_logger', []rt.PhpVal{}), 'error', [rt.new_string((rt.concat(rt.concat(rt.new_string('Failed to register ability '), var_ability_config.array_get(rt.new_string('id'))), rt.new_string(': ')) + (rt.call_method(var_e, 'getMessage', []rt.PhpVal{})).str()).str()), rt.create_array([rt.ArrayItem{ key: 'source', val: 'woocommerce-rest-abilities' }])])
		}
		unsafe { goto end_label_1 }
	}
	else {
		rt.throw_exception(var_e_1)
		unsafe { goto end_label_1 }
	}

end_label_1:
}

fn Class_Automattic_WooCommerce_Internal_Abilities_REST_RestAbilityFactory.get_schema_for_operation(var_controller rt.PhpVal, operation string) rt.PhpVal {
	mut var_controller_mutated := var_controller
	mut switch_val_1 := rt.new_string(operation)
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('list'))) {
		if rt.is_true(rt.call_function('method_exists', [var_controller_mutated.clone(), rt.new_string('get_collection_params')])) {
			return Class_Automattic_WooCommerce_Internal_Abilities_REST_RestAbilityFactory.sanitize_args_to_schema(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Abilities_REST_array](rt.call_method(var_controller_mutated, 'get_collection_params', []rt.PhpVal{})))
		}
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('create'))) {
		if rt.is_true(rt.call_function('method_exists', [var_controller_mutated.clone(), rt.new_string('get_endpoint_args_for_item_schema')])) {
			mut var_args := rt.call_method(var_controller_mutated, 'get_endpoint_args_for_item_schema', [Class_Automattic_WooCommerce_Internal_Abilities_REST_WP_REST_Server.creatable()])
			return Class_Automattic_WooCommerce_Internal_Abilities_REST_RestAbilityFactory.sanitize_args_to_schema(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Abilities_REST_array](var_args))
		}
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('update'))) {
		if rt.is_true(rt.call_function('method_exists', [var_controller_mutated.clone(), rt.new_string('get_endpoint_args_for_item_schema')])) {
			var_args = rt.call_method(var_controller_mutated, 'get_endpoint_args_for_item_schema', [Class_Automattic_WooCommerce_Internal_Abilities_REST_WP_REST_Server.editable()])
			mut var_schema := Class_Automattic_WooCommerce_Internal_Abilities_REST_RestAbilityFactory.sanitize_args_to_schema(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Abilities_REST_array](var_args))
			var_schema.array_get_mut('properties').array_set('id', rt.create_array([rt.ArrayItem{ key: 'type', val: 'integer' }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Unique identifier for the resource'), rt.new_string('woocommerce')]) }]))
			if !(var_schema.array_isset(rt.new_string('required'))) {
				var_schema.array_set('required', rt.new_array())
			}
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [rt.new_string('id'), var_schema.array_get(rt.new_string('required')), rt.new_bool(true)]))))) {
				var_schema.array_get_mut('required').array_push('id')
			}
			return var_schema.clone()
		}
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('get'))) || rt.is_true(rt.equal(switch_val_1, rt.new_string('delete'))) {
		return rt.create_array([rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: 'id', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'integer' }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Unique identifier for the resource'), rt.new_string('woocommerce')]) }]) }]) }, rt.ArrayItem{ key: 'required', val: rt.create_array([rt.ArrayItem{ key: none, val: 'id' }]) }])
	}
	return rt.create_array([rt.ArrayItem{ key: 'type', val: 'object' }])
}

fn Class_Automattic_WooCommerce_Internal_Abilities_REST_RestAbilityFactory.sanitize_args_to_schema(mut var_args Class_Automattic_WooCommerce_Internal_Abilities_REST_array) rt.PhpVal {
	mut var_args_mutated := var_args
	mut var_properties := rt.new_array()
	mut var_required := rt.new_array()
	mut iter_2 := var_args_mutated.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_arg := item_2.val
		mut var_key := item_2.key
		mut var_property := rt.new_array()
		if var_arg.array_isset(rt.new_string('type')) {
		var_property = Class_Automattic_WooCommerce_Internal_Abilities_REST_RestAbilityFactory.normalize_type(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Abilities_REST_array](var_property), var_arg.array_get(rt.new_string('type')))
		}
		if var_arg.array_isset(rt.new_string('description')) {
			var_property.array_set('description', var_arg.array_get(rt.new_string('description')))
		}
		if var_arg.array_isset(rt.new_string('default')) {
			var_property.array_set('default', var_arg.array_get(rt.new_string('default')))
		}
		if var_arg.array_isset(rt.new_string('enum')) {
			var_property.array_set('enum', Class_Automattic_WooCommerce_Internal_Abilities_REST_RestAbilityFactory.dedupe_enum(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Abilities_REST_array](var_arg.array_get(rt.new_string('enum')))))
		}
		if var_arg.array_isset(rt.new_string('items')) {
			var_property.array_set('items', Class_Automattic_WooCommerce_Internal_Abilities_REST_RestAbilityFactory.sanitize_schema(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Abilities_REST_array](var_arg.array_get(rt.new_string('items')))))
		}
		if var_arg.array_isset(rt.new_string('minimum')) {
			var_property.array_set('minimum', var_arg.array_get(rt.new_string('minimum')))
		}
		if var_arg.array_isset(rt.new_string('maximum')) {
			var_property.array_set('maximum', var_arg.array_get(rt.new_string('maximum')))
		}
		if var_arg.array_isset(rt.new_string('format')) && !(var_property.array_isset(rt.new_string('format'))) {
			var_property.array_set('format', var_arg.array_get(rt.new_string('format')))
		}
		if var_arg.array_isset(rt.new_string('properties')) {
			var_property.array_set('properties', Class_Automattic_WooCommerce_Internal_Abilities_REST_RestAbilityFactory.sanitize_schema_properties(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Abilities_REST_array](var_arg.array_get(rt.new_string('properties')))))
		}
		if var_arg.array_isset(rt.new_string('readonly')) && rt.is_true(var_arg.array_get(rt.new_string('readonly'))) {
			var_property.array_set('readOnly', true)
		}
		if var_arg.array_isset(rt.new_string('required')) && rt.is_true(rt.identical(rt.new_bool(true), var_arg.array_get(rt.new_string('required')))) {
			var_required.array_push(var_key.clone())
		}
		var_properties.array_set(var_key, var_property.clone())
	}
	mut var_schema := rt.create_array([rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'properties', val: var_properties }])
	if !(!rt.is_true(var_required)) {
		var_schema.array_set('required', rt.call_function('array_unique', [var_required.clone()]))
	}
	return var_schema.clone()
}

fn Class_Automattic_WooCommerce_Internal_Abilities_REST_RestAbilityFactory.sanitize_schema(mut var_schema Class_Automattic_WooCommerce_Internal_Abilities_REST_array) rt.PhpVal {
	mut var_schema_mutated := var_schema
	if var_schema_mutated.array_isset(rt.new_string('type')) {
	var_schema_mutated = Class_Automattic_WooCommerce_Internal_Abilities_REST_RestAbilityFactory.normalize_type(mut var_schema_mutated, var_schema_mutated.array_get(rt.new_string('type')))
	}
	if var_schema_mutated.array_isset(rt.new_string('enum')) {
		var_schema_mutated.array_set('enum', Class_Automattic_WooCommerce_Internal_Abilities_REST_RestAbilityFactory.dedupe_enum(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Abilities_REST_array](var_schema_mutated.array_get(rt.new_string('enum')))))
	}
	if var_schema_mutated.array_isset(rt.new_string('required')) && var_schema_mutated.array_get(rt.new_string('required')).is_bool() {
		var_schema_mutated.array_unset(rt.new_string('required'))
	}
	if var_schema_mutated.array_isset(rt.new_string('properties')) && var_schema_mutated.array_get(rt.new_string('properties')).is_array() {
		mut var_required := rt.new_array()
		mut iter_3 := var_schema_mutated.array_get(rt.new_string('properties')).iterator()
		for {
			item_3 := iter_3.next() or { break }
			mut var_property := item_3.val
			mut var_key := item_3.key
			if var_property.clone().is_array() && var_property.array_isset(rt.new_string('required')) && rt.is_true(rt.identical(rt.new_bool(true), var_property.array_get(rt.new_string('required')))) {
				var_required.array_push(var_key.clone())
			}
		}
		if !(!rt.is_true(var_required)) {
			var_schema_mutated.array_set('required', if var_schema_mutated.array_isset(rt.new_string('required')) && var_schema_mutated.array_get(rt.new_string('required')).is_array() { rt.call_function('array_values', [rt.call_function('array_unique', [rt.call_function('array_merge', [var_schema_mutated.array_get(rt.new_string('required')), var_required.clone()])])]) } else { var_required })
		}
		var_schema_mutated.array_set('properties', Class_Automattic_WooCommerce_Internal_Abilities_REST_RestAbilityFactory.sanitize_schema_properties(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Abilities_REST_array](var_schema_mutated.array_get(rt.new_string('properties')))))
	}
	if var_schema_mutated.array_isset(rt.new_string('items')) && var_schema_mutated.array_get(rt.new_string('items')).is_array() {
		var_schema_mutated.array_set('items', Class_Automattic_WooCommerce_Internal_Abilities_REST_RestAbilityFactory.sanitize_schema(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Abilities_REST_array](var_schema_mutated.array_get(rt.new_string('items')))))
	}
	return rt.new_object('Automattic_WooCommerce_Internal_Abilities_REST_array', []string{}, var_schema_mutated)
}

fn Class_Automattic_WooCommerce_Internal_Abilities_REST_RestAbilityFactory.sanitize_schema_properties(mut var_properties Class_Automattic_WooCommerce_Internal_Abilities_REST_array) rt.PhpVal {
	mut var_properties_mutated := var_properties
	mut iter_4 := var_properties_mutated.iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_property := item_4.val
		mut var_key := item_4.key
		if rt.is_true(rt.new_bool(var_property.clone().is_array())) {
			var_properties_mutated.array_set(var_key, Class_Automattic_WooCommerce_Internal_Abilities_REST_RestAbilityFactory.sanitize_schema(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Abilities_REST_array](var_property)))
		}
	}
	return rt.new_object('Automattic_WooCommerce_Internal_Abilities_REST_array', []string{}, var_properties_mutated)
}

fn Class_Automattic_WooCommerce_Internal_Abilities_REST_RestAbilityFactory.normalize_type(mut var_schema Class_Automattic_WooCommerce_Internal_Abilities_REST_array, var_type rt.PhpVal) rt.PhpVal {
	mut var_schema_mutated := var_schema
	if rt.is_true(rt.new_bool(var_type.clone().is_string())) {
		if rt.is_true(rt.identical(rt.new_string('date-time'), var_type)) {
			var_schema_mutated.array_set('type', 'string')
			if !(var_schema_mutated.array_isset(rt.new_string('format'))) {
				var_schema_mutated.array_set('format', 'date-time')
			}
		} else if rt.is_true(rt.identical(rt.new_string('action'), var_type)) {
			var_schema_mutated.array_set('type', 'object')
		} else if rt.is_true(rt.call_function('in_array', [var_type.clone(), rt.get_static_prop('Automattic_WooCommerce_Internal_Abilities_REST_RestAbilityFactory', 'valid_types'), rt.new_bool(true)])) {
			var_schema_mutated.array_set('type', var_type.clone())
		} else {
			var_schema_mutated.array_unset(rt.new_string('type'))
		}
		return rt.new_object('Automattic_WooCommerce_Internal_Abilities_REST_array', []string{}, var_schema_mutated)
	}
	if rt.is_true(rt.new_bool(var_type.clone().is_array())) {
		mut var_normalized := rt.new_array()
		mut iter_5 := var_type.iterator()
		for {
			item_5 := iter_5.next() or { break }
			mut var_single := item_5.val
			if !(var_single.clone().is_string()) {
				continue
			}
			if rt.is_true(rt.identical(rt.new_string('date-time'), var_single)) {
				var_single = rt.new_string('string')
				if !(var_schema_mutated.array_isset(rt.new_string('format'))) {
					var_schema_mutated.array_set('format', 'date-time')
				}
			} else if rt.is_true(rt.identical(rt.new_string('action'), var_single)) {
			var_single = rt.new_string('object')
			} else if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_single.clone(), rt.get_static_prop('Automattic_WooCommerce_Internal_Abilities_REST_RestAbilityFactory', 'valid_types'), rt.new_bool(true)]))))) {
				continue
			}
			var_normalized.array_push(var_single.clone())
		}
		var_normalized = rt.call_function('array_values', [rt.call_function('array_unique', [var_normalized.clone()])])
		if !rt.is_true(var_normalized) {
			var_schema_mutated.array_unset(rt.new_string('type'))
		} else if 1 == var_normalized.clone().array_count() {
			var_schema_mutated.array_set('type', var_normalized.array_get(rt.new_int(0)))
		} else {
			var_schema_mutated.array_set('type', var_normalized.clone())
		}
		return rt.new_object('Automattic_WooCommerce_Internal_Abilities_REST_array', []string{}, var_schema_mutated)
	}
	var_schema_mutated.array_unset(rt.new_string('type'))
	return rt.new_object('Automattic_WooCommerce_Internal_Abilities_REST_array', []string{}, var_schema_mutated)
}

fn Class_Automattic_WooCommerce_Internal_Abilities_REST_RestAbilityFactory.dedupe_enum(mut var_values Class_Automattic_WooCommerce_Internal_Abilities_REST_array) rt.PhpVal {
	mut var_seen := rt.new_array()
	mut var_unique := rt.new_array()
	mut iter_6 := var_values.iterator()
	for {
		item_6 := iter_6.next() or { break }
		mut var_value := item_6.val
		mut var_fingerprint := rt.call_function('wp_json_encode', [var_value.clone()])
		if var_seen.array_isset(var_fingerprint) {
			continue
		}
		var_seen.array_set(var_fingerprint, true)
		var_unique.array_push(var_value.clone())
	}
	return var_unique.clone()
}

fn Class_Automattic_WooCommerce_Internal_Abilities_REST_RestAbilityFactory.get_output_schema(var_controller rt.PhpVal, operation string) rt.PhpVal {
	mut var_controller_mutated := var_controller
	if rt.is_true(rt.call_function('method_exists', [var_controller_mutated.clone(), rt.new_string('get_item_schema')])) {
		mut var_schema := Class_Automattic_WooCommerce_Internal_Abilities_REST_RestAbilityFactory.sanitize_schema(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Abilities_REST_array](rt.call_method(var_controller_mutated, 'get_item_schema', []rt.PhpVal{})))
		if rt.is_true(rt.identical(rt.new_string('list'), rt.new_string(operation))) {
			return rt.create_array([rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: 'data', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'array' }, rt.ArrayItem{ key: 'items', val: var_schema }]) }]) }])
		} else if rt.is_true(rt.identical(rt.new_string('delete'), rt.new_string(operation))) {
			return rt.create_array([rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: 'deleted', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'boolean' }]) }, rt.ArrayItem{ key: 'previous', val: var_schema }]) }])
		}
		return var_schema.clone()
	}
	return rt.create_array([rt.ArrayItem{ key: 'type', val: 'object' }])
}

fn Class_Automattic_WooCommerce_Internal_Abilities_REST_RestAbilityFactory.execute_operation(var_controller rt.PhpVal, operation string, mut var_input Class_Automattic_WooCommerce_Internal_Abilities_REST_array, route string) rt.PhpVal {
	mut var_controller_mutated := var_controller
	mut var_method := Class_Automattic_WooCommerce_Internal_Abilities_REST_RestAbilityFactory.get_http_method_for_operation(operation)
	mut var_request_route := rt.new_string(route)
	if var_input.array_isset(rt.new_string('id')) && rt.is_true(rt.call_function('in_array', [rt.new_string(operation), rt.create_array([rt.ArrayItem{ key: none, val: 'get' }, rt.ArrayItem{ key: none, val: 'update' }, rt.ArrayItem{ key: none, val: 'delete' }]), rt.new_bool(true)])) {
		var_request_route = rt.concat(var_request_route, rt.new_string('/' + var_input.array_get(rt.new_string('id')).to_i64().str()))
		var_input.array_unset(rt.new_string('id'))
	}
	mut var_request := create_automattic_woocommerce_internal_abilities_rest_wp_rest_request(var_method.clone(), var_request_route.clone())
	mut iter_7 := var_input.iterator()
	for {
		item_7 := iter_7.next() or { break }
		mut var_value := item_7.val
		mut var_key := item_7.key
		var_request.set_param(var_key.clone(), var_value.clone())
	}
	mut var_response := rt.call_function('rest_do_request', [var_request])
	if rt.is_true(rt.call_function('is_wp_error', [var_response.clone()])) {
		return var_response.clone()
	}
	mut var_data := if rt.is_true(rt.new_bool(rt.instance_of(var_response, 'Automattic_WooCommerce_Internal_Abilities_REST_WP_REST_Response'))) { rt.call_method(var_response, 'get_data', []rt.PhpVal{}) } else { var_response }
	if rt.is_true(rt.identical(rt.new_string('list'), rt.new_string(operation))) {
		return rt.create_array([rt.ArrayItem{ key: 'data', val: var_data }])
	}
	return var_data.clone()
}

fn Class_Automattic_WooCommerce_Internal_Abilities_REST_RestAbilityFactory.get_http_method_for_operation(operation string) string {
	mut var_method_map := rt.create_array([rt.ArrayItem{ key: 'list', val: 'GET' }, rt.ArrayItem{ key: 'get', val: 'GET' }, rt.ArrayItem{ key: 'create', val: 'POST' }, rt.ArrayItem{ key: 'update', val: 'PUT' }, rt.ArrayItem{ key: 'delete', val: 'DELETE' }])
	return (if !(var_method_map.array_get(rt.new_string(operation))).is_null() { var_method_map.array_get(rt.new_string(operation)) } else { rt.new_string('GET') }).str()
}

fn Class_Automattic_WooCommerce_Internal_Abilities_REST_RestAbilityFactory.check_permission(var_controller rt.PhpVal, operation string) bool {
	mut var_controller_mutated := var_controller
	mut var_method := Class_Automattic_WooCommerce_Internal_Abilities_REST_RestAbilityFactory.get_http_method_for_operation(operation)
	return (rt.call_function('apply_filters', [rt.new_string('woocommerce_check_rest_ability_permissions_for_method'), rt.new_bool(false), var_method.clone(), var_controller_mutated.clone()])).to_bool()
}

struct Class_Automattic_WooCommerce_Internal_Abilities_REST_WP_REST_Request {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_abilities_rest_restabilityfactory(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Abilities_REST_RestAbilityFactory {
	mut obj := &Class_Automattic_WooCommerce_Internal_Abilities_REST_RestAbilityFactory{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_abilities_rest_wp_rest_request(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Abilities_REST_WP_REST_Request {
	mut obj := &Class_Automattic_WooCommerce_Internal_Abilities_REST_WP_REST_Request{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_Abilities_REST_RestAbilityFactory) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'register_controller_abilities' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Abilities_REST_array](if args.len > 0 { args[0] } else { rt.new_null() })
			Class_Automattic_WooCommerce_Internal_Abilities_REST_RestAbilityFactory.register_controller_abilities(mut dispatch_arg_0)
			return rt.new_null()
		}
		'register_single_ability' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Abilities_REST_array](if args.len > 1 { args[1] } else { rt.new_null() })
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			Class_Automattic_WooCommerce_Internal_Abilities_REST_RestAbilityFactory.register_single_ability(dispatch_arg_0, mut dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'get_schema_for_operation' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return Class_Automattic_WooCommerce_Internal_Abilities_REST_RestAbilityFactory.get_schema_for_operation(dispatch_arg_0, dispatch_arg_1)
		}
		'sanitize_args_to_schema' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Abilities_REST_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return Class_Automattic_WooCommerce_Internal_Abilities_REST_RestAbilityFactory.sanitize_args_to_schema(mut dispatch_arg_0)
		}
		'sanitize_schema' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Abilities_REST_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return Class_Automattic_WooCommerce_Internal_Abilities_REST_RestAbilityFactory.sanitize_schema(mut dispatch_arg_0)
		}
		'sanitize_schema_properties' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Abilities_REST_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return Class_Automattic_WooCommerce_Internal_Abilities_REST_RestAbilityFactory.sanitize_schema_properties(mut dispatch_arg_0)
		}
		'normalize_type' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Abilities_REST_array](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Internal_Abilities_REST_RestAbilityFactory.normalize_type(mut dispatch_arg_0, dispatch_arg_1)
		}
		'dedupe_enum' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Abilities_REST_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return Class_Automattic_WooCommerce_Internal_Abilities_REST_RestAbilityFactory.dedupe_enum(mut dispatch_arg_0)
		}
		'get_output_schema' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return Class_Automattic_WooCommerce_Internal_Abilities_REST_RestAbilityFactory.get_output_schema(dispatch_arg_0, dispatch_arg_1)
		}
		'execute_operation' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Abilities_REST_array](if args.len > 2 { args[2] } else { rt.new_null() })
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).str()
			return Class_Automattic_WooCommerce_Internal_Abilities_REST_RestAbilityFactory.execute_operation(dispatch_arg_0, dispatch_arg_1, mut dispatch_arg_2, dispatch_arg_3)
		}
		'get_http_method_for_operation' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(Class_Automattic_WooCommerce_Internal_Abilities_REST_RestAbilityFactory.get_http_method_for_operation(dispatch_arg_0))
		}
		'check_permission' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return rt.new_bool(Class_Automattic_WooCommerce_Internal_Abilities_REST_RestAbilityFactory.check_permission(dispatch_arg_0, dispatch_arg_1))
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Abilities_REST_RestAbilityFactory) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Abilities_REST_RestAbilityFactory) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Internal_Abilities_REST_WP_REST_Request) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Abilities_REST_WP_REST_Request) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Abilities_REST_WP_REST_Request) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn init_registry() {
	rt.register_class_factory('Automattic_WooCommerce_Internal_Abilities_REST_RestAbilityFactory', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_internal_abilities_rest_restabilityfactory()
		return rt.new_object('Automattic_WooCommerce_Internal_Abilities_REST_RestAbilityFactory', []string{}, obj)
	})
	rt.register_class_factory('Automattic_WooCommerce_Internal_Abilities_REST_WP_REST_Request', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_internal_abilities_rest_wp_rest_request()
		return rt.new_object('Automattic_WooCommerce_Internal_Abilities_REST_WP_REST_Request', []string{}, obj)
	})
}

fn init() {
	init_registry()
}


fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(exit(0)))
}
