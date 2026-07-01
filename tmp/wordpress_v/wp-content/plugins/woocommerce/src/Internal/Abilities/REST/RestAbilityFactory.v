import rt

struct Class_Automattic_WooCommerce_Internal_Abilities_REST_RestAbilityFactory {
	rt.PhpObjectBase
pub mut:
		valid_types rt.PhpVal = rt.new_array()
}

fn Class_Automattic_WooCommerce_Internal_Abilities_REST_RestAbilityFactory.register_controller_abilities(mut var_config Class_Automattic_WooCommerce_Internal_Abilities_REST_array)  {
	mut var_controller_class := var_config.array_get('controller')
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [var_controller_class.dup()]))))) {
		return rt.new_null()
	}
	mut var_controller := rt.create_object_dynamically(var_controller_class, []rt.PhpVal{})
	{
		mut iter_1 := var_config.array_get('abilities').iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_ability_config := item_1.val
			Class_Automattic_WooCommerce_Internal_Abilities_REST_RestAbilityFactory.register_single_ability(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Abilities_REST_array](var_controller), (var_ability_config).str(), var_config.array_get('route'))
		}
	}
}

fn Class_Automattic_WooCommerce_Internal_Abilities_REST_RestAbilityFactory.register_single_ability(var_controller rt.PhpVal, mut var_ability_config Class_Automattic_WooCommerce_Internal_Abilities_REST_array, route string)  {
	mut var_controller_mutated := var_controller
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('wp_register_ability')]))))) {
		return rt.new_null()
	}
	closure_2_fn := fn [var_controller, var_ability_config] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_1_fn := fn [var_controller, var_ability_config, var_route] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_input := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return Class_Automattic_WooCommerce_Internal_Abilities_REST_RestAbilityFactory.execute_operation((var_controller_mutated).str(), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Abilities_REST_array](var_ability_config.array_get('operation')), (var_input).str(), rt.new_string(rt.new_string(var_route)))
	}
	return Class_Automattic_WooCommerce_Internal_Abilities_REST_RestAbilityFactory.check_permission((var_controller_mutated).str(), var_ability_config.array_get('operation'))
	}
	mut var_ability_args := rt.create_array([rt.ArrayItem{ key: 'label', val: var_ability_config.array_get('label') }, rt.ArrayItem{ key: 'description', val: var_ability_config.array_get('description') }, rt.ArrayItem{ key: 'category', val: 'woocommerce-rest' }, rt.ArrayItem{ key: 'input_schema', val: Class_Automattic_WooCommerce_Internal_Abilities_REST_RestAbilityFactory.get_schema_for_operation((var_controller_mutated).str(), var_ability_config.array_get('operation')) }, rt.ArrayItem{ key: 'output_schema', val: Class_Automattic_WooCommerce_Internal_Abilities_REST_RestAbilityFactory.get_output_schema((var_controller_mutated).str(), var_ability_config.array_get('operation')) }, rt.ArrayItem{ key: 'execute_callback', val: rt.new_closure(closure_1_fn) }, rt.ArrayItem{ key: 'permission_callback', val: rt.new_closure(closure_2_fn) }, rt.ArrayItem{ key: 'ability_class', val: Class_Automattic_WooCommerce_Internal_Abilities_REST_RestAbility.class() }, rt.ArrayItem{ key: 'meta', val: rt.create_array([rt.ArrayItem{ key: 'show_in_rest', val: true }]) }])
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	if rt.is_true(rt.call_function('in_array', [var_ability_config.array_get('operation'), rt.create_array([rt.ArrayItem{ key: none, val: 'list' }, rt.ArrayItem{ key: none, val: 'get' }]), rt.new_bool(true)])) {
		var_ability_args.array_get_mut('meta').array_set('annotations', rt.create_array([rt.ArrayItem{ key: 'readonly', val: true }]))
		if rt.has_exception() { unsafe { goto catch_label_1 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	rt.call_function('wp_register_ability', [var_ability_config.array_get('id'), var_ability_args.dup()])
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	unsafe { goto end_label_1 }

catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'Automattic_WooCommerce_Internal_Abilities_REST_Throwable') {
		mut var_e := var_e_1.dup()
		if rt.is_true(rt.call_function('function_exists', [rt.new_string('wc_get_logger')])) {
			rt.call_method(rt.call_function('wc_get_logger', []rt.PhpVal{}), 'error', [rt.concat(rt.concat(rt.new_string('Failed to register ability '), var_ability_config.array_get('id')), rt.new_string(': ')) + (rt.call_method(var_e, 'getMessage', []rt.PhpVal{})).str(), rt.create_array([rt.ArrayItem{ key: 'source', val: 'woocommerce-rest-abilities' }])])
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
		if rt.is_true(rt.call_function('method_exists', [var_controller_mutated.dup(), rt.new_string('get_collection_params')])) {
			return Class_Automattic_WooCommerce_Internal_Abilities_REST_RestAbilityFactory.sanitize_args_to_schema(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Abilities_REST_array](rt.call_method(var_controller_mutated, 'get_collection_params', []rt.PhpVal{})))
		}
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('create'))) {
		if rt.is_true(rt.call_function('method_exists', [var_controller_mutated.dup(), rt.new_string('get_endpoint_args_for_item_schema')])) {
			mut var_args := rt.call_method(var_controller_mutated, 'get_endpoint_args_for_item_schema', [Class_Automattic_WooCommerce_Internal_Abilities_REST_WP_REST_Server.creatable()])
			return Class_Automattic_WooCommerce_Internal_Abilities_REST_RestAbilityFactory.sanitize_args_to_schema(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Abilities_REST_array](var_args))
		}
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('update'))) {
		if rt.is_true(rt.call_function('method_exists', [var_controller_mutated.dup(), rt.new_string('get_endpoint_args_for_item_schema')])) {
			var_args = rt.call_method(var_controller_mutated, 'get_endpoint_args_for_item_schema', [Class_Automattic_WooCommerce_Internal_Abilities_REST_WP_REST_Server.editable()])
			mut var_schema := Class_Automattic_WooCommerce_Internal_Abilities_REST_RestAbilityFactory.sanitize_args_to_schema(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Abilities_REST_array](var_args))
			var_schema.array_get_mut('properties').array_set('id', rt.create_array([rt.ArrayItem{ key: 'type', val: 'integer' }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Unique identifier for the resource'), rt.new_string('woocommerce')]) }]))
			if !(var_schema.array_isset(rt.new_string('required'))) {
				var_schema.array_set('required', rt.new_array())
			}
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [rt.new_string('id'), var_schema.array_get('required'), rt.new_bool(true)]))))) {
				var_schema.array_get_mut('required').array_push('id')
			}
			return var_schema.dup()
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
	{
		mut iter_1 := var_args_mutated.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_arg := item_1.val
			mut var_key := item_1.key
			mut var_property := rt.new_array()
			if var_arg.array_isset(rt.new_string('type')) {
				var_property = Class_Automattic_WooCommerce_Internal_Abilities_REST_RestAbilityFactory.normalize_type(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Abilities_REST_array](var_property), var_arg.array_get('type'))
			}
			if var_arg.array_isset(rt.new_string('description')) {
				var_property.array_set('description', var_arg.array_get('description'))
			}
			if var_arg.array_isset(rt.new_string('default')) {
				var_property.array_set('default', var_arg.array_get('default'))
			}
			if var_arg.array_isset(rt.new_string('enum')) {
				var_property.array_set('enum', Class_Automattic_WooCommerce_Internal_Abilities_REST_RestAbilityFactory.dedupe_enum(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Abilities_REST_array](var_arg.array_get('enum'))))
			}
			if var_arg.array_isset(rt.new_string('items')) {
				var_property.array_set('items', Class_Automattic_WooCommerce_Internal_Abilities_REST_RestAbilityFactory.sanitize_schema(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Abilities_REST_array](var_arg.array_get('items'))))
			}
			if var_arg.array_isset(rt.new_string('minimum')) {
				var_property.array_set('minimum', var_arg.array_get('minimum'))
			}
			if var_arg.array_isset(rt.new_string('maximum')) {
				var_property.array_set('maximum', var_arg.array_get('maximum'))
			}
			if var_arg.array_isset(rt.new_string('format')) && !(var_property.array_isset(rt.new_string('format'))) {
				var_property.array_set('format', var_arg.array_get('format'))
			}
			if var_arg.array_isset(rt.new_string('properties')) {
				var_property.array_set('properties', Class_Automattic_WooCommerce_Internal_Abilities_REST_RestAbilityFactory.sanitize_schema_properties(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Abilities_REST_array](var_arg.array_get('properties'))))
			}
			if rt.is_true(rt.new_bool(var_arg.array_isset(rt.new_string('readonly')) && rt.is_true(var_arg.array_get('readonly')))) {
				var_property.array_set('readOnly', true)
			}
			if rt.is_true(rt.new_bool(var_arg.array_isset(rt.new_string('required')) && rt.is_true(rt.identical(rt.new_bool(true), var_arg.array_get('required'))))) {
				var_required.array_push(var_key.dup())
			}
			var_properties.array_set(var_key, var_property.dup())
		}
	}
	mut var_schema := rt.create_array([rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'properties', val: var_properties }])
	if !(!rt.is_true(var_required)) {
		var_schema.array_set('required', rt.call_function('array_unique', [var_required.dup()]))
	}
	return var_schema.dup()
}

fn Class_Automattic_WooCommerce_Internal_Abilities_REST_RestAbilityFactory.sanitize_schema(mut var_schema Class_Automattic_WooCommerce_Internal_Abilities_REST_array) rt.PhpVal {
	mut var_schema_mutated := var_schema
	if var_schema_mutated.array_isset(rt.new_string('type')) {
		var_schema_mutated = Class_Automattic_WooCommerce_Internal_Abilities_REST_RestAbilityFactory.normalize_type(mut var_schema_mutated, var_schema_mutated.array_get('type'))
	}
	if var_schema_mutated.array_isset(rt.new_string('enum')) {
		var_schema_mutated.array_set('enum', Class_Automattic_WooCommerce_Internal_Abilities_REST_RestAbilityFactory.dedupe_enum(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Abilities_REST_array](var_schema_mutated.array_get('enum'))))
	}
	if rt.is_true(rt.new_bool(var_schema_mutated.array_isset(rt.new_string('required')) && rt.is_true(rt.new_bool(var_schema_mutated.array_get('required').is_bool())))) {
		var_schema_mutated.array_unset(rt.new_string('required'))
	}
	if rt.is_true(rt.new_bool(var_schema_mutated.array_isset(rt.new_string('properties')) && rt.is_true(rt.new_bool(var_schema_mutated.array_get('properties').is_array())))) {
		mut var_required := rt.new_array()
		{
			mut iter_1 := var_schema_mutated.array_get('properties').iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_property := item_1.val
				mut var_key := item_1.key
				if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_property.dup().is_array())) && var_property.array_isset(rt.new_string('required')))) && rt.is_true(rt.identical(rt.new_bool(true), var_property.array_get('required'))))) {
					var_required.array_push(var_key.dup())
				}
			}
		}
		if !(!rt.is_true(var_required)) {
			var_schema_mutated.array_set('required', if rt.is_true(rt.new_bool(var_schema_mutated.array_isset(rt.new_string('required')) && rt.is_true(rt.new_bool(var_schema_mutated.array_get('required').is_array())))) { rt.call_function('array_values', [rt.call_function('array_unique', [rt.call_function('array_merge', [var_schema_mutated.array_get('required'), var_required.dup()])])]) } else { var_required })
		}
		var_schema_mutated.array_set('properties', Class_Automattic_WooCommerce_Internal_Abilities_REST_RestAbilityFactory.sanitize_schema_properties(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Abilities_REST_array](var_schema_mutated.array_get('properties'))))
	}
	if rt.is_true(rt.new_bool(var_schema_mutated.array_isset(rt.new_string('items')) && rt.is_true(rt.new_bool(var_schema_mutated.array_get('items').is_array())))) {
		var_schema_mutated.array_set('items', Class_Automattic_WooCommerce_Internal_Abilities_REST_RestAbilityFactory.sanitize_schema(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Abilities_REST_array](var_schema_mutated.array_get('items'))))
	}
	return rt.new_object('Automattic_WooCommerce_Internal_Abilities_REST_array', []string{}, var_schema_mutated)
}

fn Class_Automattic_WooCommerce_Internal_Abilities_REST_RestAbilityFactory.sanitize_schema_properties(mut var_properties Class_Automattic_WooCommerce_Internal_Abilities_REST_array) rt.PhpVal {
	mut var_properties_mutated := var_properties
	{
		mut iter_1 := var_properties_mutated.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_property := item_1.val
			mut var_key := item_1.key
			if rt.is_true(rt.new_bool(var_property.dup().is_array())) {
				var_properties_mutated.array_set(var_key, Class_Automattic_WooCommerce_Internal_Abilities_REST_RestAbilityFactory.sanitize_schema(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Abilities_REST_array](var_property)))
			}
		}
	}
	return rt.new_object('Automattic_WooCommerce_Internal_Abilities_REST_array', []string{}, var_properties_mutated)
}

fn Class_Automattic_WooCommerce_Internal_Abilities_REST_RestAbilityFactory.normalize_type(mut var_schema Class_Automattic_WooCommerce_Internal_Abilities_REST_array, var_type rt.PhpVal) rt.PhpVal {
	mut var_schema_mutated := var_schema
	if rt.is_true(rt.new_bool(var_type.dup().is_string())) {
		if rt.is_true(rt.identical(rt.new_string('date-time'), var_type)) {
			var_schema_mutated.array_set('type', 'string')
			if !(var_schema_mutated.array_isset(rt.new_string('format'))) {
				var_schema_mutated.array_set('format', 'date-time')
			}
		} else if rt.is_true(rt.identical(rt.new_string('action'), var_type)) {
			var_schema_mutated.array_set('type', 'object')
		} else if rt.is_true(rt.call_function('in_array', [var_type.dup(), // unsupported expression: Expr_StaticPropertyFetch, rt.new_bool(true)])) {
			var_schema_mutated.array_set('type', var_type.dup())
		} else {
			var_schema_mutated.array_unset(rt.new_string('type'))
		}
		return rt.new_object('Automattic_WooCommerce_Internal_Abilities_REST_array', []string{}, var_schema_mutated)
	}
	if rt.is_true(rt.new_bool(var_type.dup().is_array())) {
		mut var_normalized := rt.new_array()
		{
			mut iter_1 := var_type.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_single := item_1.val
				if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_single.dup().is_string()))))) {
					continue
				}
				if rt.is_true(rt.identical(rt.new_string('date-time'), var_single)) {
					var_single = rt.new_string(rt.new_string('string'))
					if !(var_schema_mutated.array_isset(rt.new_string('format'))) {
						var_schema_mutated.array_set('format', 'date-time')
					}
				} else if rt.is_true(rt.identical(rt.new_string('action'), var_single)) {
					var_single = rt.new_string(rt.new_string('object'))
				} else if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_single.dup(), // unsupported expression: Expr_StaticPropertyFetch, rt.new_bool(true)]))))) {
					continue
				}
				var_normalized.array_push(var_single.dup())
			}
		}
		var_normalized = rt.call_function('array_values', [rt.call_function('array_unique', [var_normalized.dup()])])
		if !rt.is_true(var_normalized) {
			var_schema_mutated.array_unset(rt.new_string('type'))
		} else if 1 == var_normalized.dup().array_count() {
			var_schema_mutated.array_set('type', var_normalized.array_get(0))
		} else {
			var_schema_mutated.array_set('type', var_normalized.dup())
		}
		return rt.new_object('Automattic_WooCommerce_Internal_Abilities_REST_array', []string{}, var_schema_mutated)
	}
	var_schema_mutated.array_unset(rt.new_string('type'))
	return rt.new_object('Automattic_WooCommerce_Internal_Abilities_REST_array', []string{}, var_schema_mutated)
}

fn Class_Automattic_WooCommerce_Internal_Abilities_REST_RestAbilityFactory.dedupe_enum(mut var_values Class_Automattic_WooCommerce_Internal_Abilities_REST_array) rt.PhpVal {
	mut var_seen := rt.new_array()
	mut var_unique := rt.new_array()
	{
		mut iter_1 := var_values.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_value := item_1.val
			mut var_fingerprint := rt.call_function('wp_json_encode', [var_value.dup()])
			if var_seen.array_isset(var_fingerprint) {
				continue
			}
			var_seen.array_set(var_fingerprint, true)
			var_unique.array_push(var_value.dup())
		}
	}
	return var_unique.dup()
}

fn Class_Automattic_WooCommerce_Internal_Abilities_REST_RestAbilityFactory.get_output_schema(var_controller rt.PhpVal, operation string) rt.PhpVal {
	mut var_controller_mutated := var_controller
	if rt.is_true(rt.call_function('method_exists', [var_controller_mutated.dup(), rt.new_string('get_item_schema')])) {
		mut var_schema := Class_Automattic_WooCommerce_Internal_Abilities_REST_RestAbilityFactory.sanitize_schema(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Abilities_REST_array](rt.call_method(var_controller_mutated, 'get_item_schema', []rt.PhpVal{})))
		if rt.is_true(rt.identical(rt.new_string('list'), rt.new_string(operation))) {
			return rt.create_array([rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: 'data', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'array' }, rt.ArrayItem{ key: 'items', val: var_schema }]) }]) }])
		} else if rt.is_true(rt.identical(rt.new_string('delete'), rt.new_string(operation))) {
			return rt.create_array([rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: 'deleted', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'boolean' }]) }, rt.ArrayItem{ key: 'previous', val: var_schema }]) }])
		}
		return var_schema.dup()
	}
	return rt.create_array([rt.ArrayItem{ key: 'type', val: 'object' }])
}

fn Class_Automattic_WooCommerce_Internal_Abilities_REST_RestAbilityFactory.execute_operation(var_controller rt.PhpVal, operation string, mut var_input Class_Automattic_WooCommerce_Internal_Abilities_REST_array, route string) rt.PhpVal {
	mut var_controller_mutated := var_controller
	mut var_method := Class_Automattic_WooCommerce_Internal_Abilities_REST_RestAbilityFactory.get_http_method_for_operation(operation)
	mut var_request_route := rt.new_string(rt.new_string(route))
	if rt.is_true(rt.new_bool(.array_isset() && rt.is_true())) {
		
	}
	
}

fn Class_Automattic_WooCommerce_Internal_Abilities_REST_RestAbilityFactory.get_http_method_for_operation(operation string) string {
}

fn Class_Automattic_WooCommerce_Internal_Abilities_REST_RestAbilityFactory.check_permission(var_controller rt.PhpVal, operation string) bool {
	mut var_controller_mutated := var_controller
}

fn create_automattic_woocommerce_internal_abilities_rest_restabilityfactory() &Class_Automattic_WooCommerce_Internal_Abilities_REST_RestAbilityFactory {
	mut obj := &Class_Automattic_WooCommerce_Internal_Abilities_REST_RestAbilityFactory{
		PhpObjectBase: rt.PhpObjectBase{}
		valid_types: rt.new_array()
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
	match prop_name {
		'valid_types' { return this.valid_types }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Abilities_REST_RestAbilityFactory) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'valid_types' { this.valid_types = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn init_registry() {
	rt.register_class_factory('Automattic_WooCommerce_Internal_Abilities_REST_RestAbilityFactory', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_internal_abilities_rest_restabilityfactory()
		return rt.new_object('Automattic_WooCommerce_Internal_Abilities_REST_RestAbilityFactory', []string{}, obj)
	})
}

fn init() {
	init_registry()
}



pub fn init_wp_content_plugins_woocommerce_src_internal_abilities_rest_restabilityfactory_php() {
	// unsupported statement: Stmt_Declare
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
