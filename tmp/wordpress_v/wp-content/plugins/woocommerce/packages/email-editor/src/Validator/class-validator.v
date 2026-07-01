import rt

struct Class_Automattic_WooCommerce_EmailEditor_Validator_Validator {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Validator_Validator) validate(mut var_schema Class_Automattic_WooCommerce_EmailEditor_Validator_Schema, var_value rt.PhpVal, param_name string) rt.PhpVal {
	mut var_value_mutated := var_value
	return this.validate_schema_array(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Validator_array](var_schema.to_array()), var_value_mutated.dup(), param_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Validator_Validator) validate_schema_array(mut var_schema Class_Automattic_WooCommerce_EmailEditor_Validator_array, var_value rt.PhpVal, param_name string) rt.PhpVal {
	mut var_value_mutated := var_value
	mut var_result := this.validate_and_sanitize_value_from_schema(var_value_mutated.dup(), mut var_schema, param_name)
	if rt.is_true(rt.new_bool(rt.instance_of(var_result, 'WP_Error'))) {
		rt.throw_exception(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_EmailEditor_Validator_Validation_Exception{}; return temp.create_from_wp_error(arg_0) }(var_result.dup()))
		// unsupported statement: Stmt_Nop
	}
	return var_result.dup()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Validator_Validator) validate_and_sanitize_value_from_schema(var_value rt.PhpVal, mut var_schema Class_Automattic_WooCommerce_EmailEditor_Validator_array, param_name string) rt.PhpVal {
	mut var_value_mutated := var_value
	mut var_full_type := if !(var_schema.array_get('type')).is_null() { var_schema.array_get('type') } else { rt.new_null() }
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_full_type.dup().is_array())) && rt.is_true(rt.call_function('in_array', [rt.new_string('null'), var_full_type.dup(), rt.new_bool(true)])))) && rt.is_true(rt.identical(rt.new_null(), var_value_mutated)))) {
		return rt.new_null()
	}
	if var_schema.array_isset(rt.new_string('anyOf')) {
		return this.validate_and_sanitize_any_of(var_value_mutated.dup(), mut var_schema, param_name)
	} else if var_schema.array_isset(rt.new_string('oneOf')) {
		return this.validate_and_sanitize_one_of(var_value_mutated.dup(), mut var_schema, param_name)
	}
	mut var_type := if rt.is_true(rt.new_bool(var_full_type.dup().is_array())) { var_full_type.array_get(0) } else { var_full_type }
	mut switch_val_1 := var_type
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('number'))) {
		if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_value_mutated.dup().is_double()))))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_value_mutated.dup().is_long()))))))) {
			return this.get_type_error(param_name, var_full_type.dup())
		}
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('integer'))) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_value_mutated.dup().is_long()))))) {
			return this.get_type_error(param_name, var_full_type.dup())
		}
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('boolean'))) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_value_mutated.dup().is_bool()))))) {
			return this.get_type_error(param_name, var_full_type.dup())
		}
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('array'))) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_value_mutated.dup().is_array()))))) {
			return this.get_type_error(param_name, var_full_type.dup())
		}
		if var_schema.array_isset(rt.new_string('items')) {
			{
				mut iter_1 := var_value_mutated.iterator()
				for {
					item_1 := iter_1.next() or { break }
					mut var_v := item_1.val
					mut var_i := item_1.key
					mut var_result := this.validate_and_sanitize_value_from_schema(var_v.dup(), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Validator_array](var_schema.array_get('items')), param_name + '[' + (var_i).str() + ']')
					if rt.is_true(rt.call_function('is_wp_error', [var_result.dup()])) {
						return var_result.dup()
					}
				}
			}
		}
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('object'))) {
		if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_value_mutated.dup().is_array()))))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_value_mutated, 'stdClass')))))))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_value_mutated, 'JsonSerializable')))))))) {
			return this.get_type_error(param_name, var_full_type.dup())
		}
		var_value_mutated = rt.cast_array(if rt.is_true(rt.new_bool(rt.instance_of(var_value_mutated, 'JsonSerializable'))) { rt.call_method(var_value_mutated, 'jsonSerialize', []rt.PhpVal{}) } else { var_value_mutated })
		if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
			return this.get_type_error(param_name, var_full_type.dup())
		}
		{
			mut iter_1 := var_value_mutated.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_v := item_1.val
				mut var_k := item_1.key
				if var_schema.array_get('properties').array_isset(var_k) {
					mut var_result := this.validate_and_sanitize_value_from_schema(var_v.dup(), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Validator_array](var_schema.array_get('properties').array_get(var_k)), param_name + '[' + (var_k).str() + ']')
					if rt.is_true(rt.call_function('is_wp_error', [var_result.dup()])) {
						return var_result.dup()
					}
					continue
				}
				mut var_pattern_property_schema := rt.call_function('rest_find_matching_pattern_property_schema', [var_k.dup(), var_schema])
				if rt.is_true(var_pattern_property_schema) {
					var_result = this.validate_and_sanitize_value_from_schema(var_v.dup(), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Validator_array](var_pattern_property_schema), param_name + '[' + (var_k).str() + ']')
					if rt.is_true(rt.call_function('is_wp_error', [var_result.dup()])) {
						return var_result.dup()
					}
					continue
				}
				if rt.is_true(rt.new_bool(var_schema.array_isset(rt.new_string('additionalProperties')) && rt.is_true(rt.new_bool(var_schema.array_get('additionalProperties').is_array())))) {
					var_result = this.validate_and_sanitize_value_from_schema(var_v.dup(), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Validator_array](var_schema.array_get('additionalProperties')), param_name + '[' + (var_k).str() + ']')
					if rt.is_true(rt.call_function('is_wp_error', [var_result.dup()])) {
						return var_result.dup()
					}
				}
			}
		}
	}
	mut var_result := rt.call_function('rest_validate_value_from_schema', [var_value_mutated.dup(), var_schema, rt.new_string(param_name)])
	if rt.is_true(rt.call_function('is_wp_error', [var_result.dup()])) {
		return var_result.dup()
	}
	return rt.call_function('rest_sanitize_value_from_schema', [var_value_mutated.dup(), var_schema, rt.new_string(param_name)])
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Validator_Validator) validate_and_sanitize_any_of(var_value rt.PhpVal, mut var_any_of_schema Class_Automattic_WooCommerce_EmailEditor_Validator_array, param_name string) rt.PhpVal {
	mut var_value_mutated := var_value
	mut var_errors := rt.new_array()
	{
		mut iter_1 := var_any_of_schema.array_get('anyOf').iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_schema := item_1.val
			mut var_index := item_1.key
			mut var_result := this.validate_and_sanitize_value_from_schema(var_value_mutated.dup(), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Validator_array](var_schema), param_name)
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [var_result.dup()]))))) {
				return var_result.dup()
			}
			var_errors.array_push(rt.create_array([rt.ArrayItem{ key: 'error_object', val: var_result }, rt.ArrayItem{ key: 'schema', val: var_schema }, rt.ArrayItem{ key: 'index', val: var_index }]))
		}
	}
	return rt.call_function('rest_get_combining_operation_error', [var_value_mutated.dup(), rt.new_string(param_name), var_errors.dup()])
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Validator_Validator) validate_and_sanitize_one_of(var_value rt.PhpVal, mut var_one_of_schema Class_Automattic_WooCommerce_EmailEditor_Validator_array, param_name string) rt.PhpVal {
	mut var_value_mutated := var_value
	mut var_matching_schemas := rt.new_array()
	mut var_errors := rt.new_array()
	mut var_data := rt.new_null()
	{
		mut iter_1 := var_one_of_schema.array_get('oneOf').iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_schema := item_1.val
			mut var_index := item_1.key
			mut var_result := this.validate_and_sanitize_value_from_schema(var_value_mutated.dup(), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Validator_array](var_schema), param_name)
			if rt.is_true(rt.call_function('is_wp_error', [var_result.dup()])) {
				var_errors.array_push(rt.create_array([rt.ArrayItem{ key: 'error_object', val: var_result }, rt.ArrayItem{ key: 'schema', val: var_schema }, rt.ArrayItem{ key: 'index', val: var_index }]))
			} else {
				var_data = var_result.dup()
				var_matching_schemas.array_set(var_index, var_schema.dup())
			}
		}
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_matching_schemas)))) {
		return rt.call_function('rest_get_combining_operation_error', [var_value_mutated.dup(), rt.new_string(param_name), var_errors.dup()])
	}
	if var_matching_schemas.dup().array_count() > 1 {
		mut var_invalid_schema := rt.create_array([rt.ArrayItem{ key: 'type', val: rt.new_array() }])
		mut var_one_of := rt.call_function('array_replace', [rt.call_function('array_fill', [rt.new_int(0), rt.new_int(var_one_of_schema.array_get('oneOf').array_count()), var_invalid_schema.dup()]), var_matching_schemas.dup()])
		return rt.call_function('rest_find_one_matching_schema', [var_value_mutated.dup(), rt.create_array([rt.ArrayItem{ key: 'oneOf', val: var_one_of }]), rt.new_string(param_name)])
	}
	return var_data.dup()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Validator_Validator) get_type_error(param string, var_type rt.PhpVal) rt.PhpVal {
	mut var_type_mutated := var_type
	var_type_mutated = if rt.is_true(rt.new_bool(var_type_mutated.dup().is_array())) { var_type_mutated } else { rt.create_array([rt.ArrayItem{ key: none, val: var_type_mutated }]) }
	return create_wp_error(rt.new_string('rest_invalid_type'), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('%1$s is not of type %2$s.'), rt.new_string('woocommerce')]), rt.new_string(param), rt.call_function('implode', [rt.new_string(','), var_type_mutated.dup()])]), rt.create_array([rt.ArrayItem{ key: 'param', val: param }]))
}

struct Class_Automattic_WooCommerce_EmailEditor_Validator_Validation_Exception {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_emaileditor_validator_validator() &Class_Automattic_WooCommerce_EmailEditor_Validator_Validator {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Validator_Validator{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditor_validator_validation_exception() &Class_Automattic_WooCommerce_EmailEditor_Validator_Validation_Exception {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Validator_Validation_Exception{
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

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Validator_Validator) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'validate' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Validator_Schema](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			return this.validate(mut dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'validate_schema_array' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Validator_array](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			return this.validate_schema_array(mut dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'validate_and_sanitize_value_from_schema' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Validator_array](if args.len > 1 { args[1] } else { rt.new_null() })
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			return this.validate_and_sanitize_value_from_schema(dispatch_arg_0, mut dispatch_arg_1, dispatch_arg_2)
		}
		'validate_and_sanitize_any_of' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Validator_array](if args.len > 1 { args[1] } else { rt.new_null() })
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			return this.validate_and_sanitize_any_of(dispatch_arg_0, mut dispatch_arg_1, dispatch_arg_2)
		}
		'validate_and_sanitize_one_of' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Validator_array](if args.len > 1 { args[1] } else { rt.new_null() })
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			return this.validate_and_sanitize_one_of(dispatch_arg_0, mut dispatch_arg_1, dispatch_arg_2)
		}
		'get_type_error' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.get_type_error(dispatch_arg_0, dispatch_arg_1)
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Validator_Validator) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Validator_Validator) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_EmailEditor_Validator_Validation_Exception) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Validator_Validation_Exception) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Validator_Validation_Exception) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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




pub fn init_wp_content_plugins_woocommerce_packages_email_editor_src_validator_class_validator_php() {
	// unsupported statement: Stmt_Declare
}
