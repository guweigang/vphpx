import rt

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Value {
	rt.PhpObjectBase
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Value.coerceinputvalue(var_value rt.PhpVal, mut var_type Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InputType, mut var_path Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_?array, mut var_schema Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_?Schema) rt.PhpVal {
	mut var_value_mutated := var_value
	mut var_type_mutated := var_type
	if rt.is_true(rt.new_bool(rt.instance_of(var_type_mutated, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_NonNull'))) {
		if rt.is_true(rt.identical(var_value_mutated, rt.new_null())) {
			mut iife_temp_0 := Class_Automattic_WooCommerce_Vendor_GraphQL_Error_CoercionError{}
			mut iife_result_0 := iife_temp_0.make(rt.new_string("Expected non-nullable type \"${var_type.to_string()}\" not to be null."), rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Utils_?array', []string{}, var_path), var_value_mutated.clone())
			return Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Value.oferrors(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array](rt.create_array([rt.ArrayItem{ key: none, val: iife_result_0 }])))
		}
		return Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Value.coerceinputvalue(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InputType](var_value_mutated), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_?array](rt.call_method(var_type_mutated, 'getWrappedType', []rt.PhpVal{})), mut var_path, rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Utils_?Schema', []string{}, var_schema))
	}
	if rt.is_true(rt.identical(var_value_mutated, rt.new_null())) {
		return Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Value.ofvalue(rt.new_null())
	}
	mut iife_temp_1 := Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type{}
	mut iife_result_1 := iife_temp_1.isbuiltinscalar(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InputType', []string{}, var_type_mutated))
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_schema, rt.new_null())))) && rt.is_true(iife_result_1) {
		mut var_schemaType := var_schema.gettype(rt.get_property(var_type_mutated, 'name'))
		rt.call_function('assert', [rt.new_bool(rt.instance_of(var_schemaType, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ScalarType')), rt.concat(rt.concat(rt.new_string('Schema must provide a ScalarType for built-in scalar "'), rt.get_property(var_type_mutated, 'name')), rt.new_string('".'))])
	var_type_mutated = var_schemaType.clone()
	}
	if rt.is_true(rt.new_bool(rt.instance_of(var_type_mutated, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ScalarType'))) || rt.is_true(rt.new_bool(rt.instance_of(var_type_mutated, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_EnumType'))) {
		return Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Value.ofvalue(rt.call_method(var_type_mutated, 'parseValue', [var_value_mutated.clone()]))
		unsafe { goto end_label_1 }

catch_label_1:
		mut var_e_1 := rt.get_and_clear_exception()
		if rt.instance_of(var_e_1, 'Automattic_WooCommerce_Vendor_GraphQL_Utils_Throwable') {
			mut var_error := var_e_1.clone()
			if rt.is_true(rt.new_bool(rt.instance_of(var_error, 'Automattic_WooCommerce_Vendor_GraphQL_Error_Error'))) || (rt.is_true(rt.new_bool(rt.instance_of(var_error, 'Automattic_WooCommerce_Vendor_GraphQL_Error_ClientAware'))) && rt.is_true(rt.call_method(var_error, 'isClientSafe', []rt.PhpVal{}))) {
				mut iife_temp_2 := Class_Automattic_WooCommerce_Vendor_GraphQL_Error_CoercionError{}
				mut iife_result_2 := iife_temp_2.make(rt.call_method(var_error, 'getMessage', []rt.PhpVal{}), rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Utils_?array', []string{}, var_path), var_value_mutated.clone(), var_error.clone())
				return Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Value.oferrors(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array](rt.create_array([rt.ArrayItem{ key: none, val: iife_result_2 }])))
			}
			mut iife_temp_3 := Class_Automattic_WooCommerce_Vendor_GraphQL_Error_CoercionError{}
			mut iife_result_3 := iife_temp_3.make(rt.new_string((rt.concat(rt.concat(rt.new_string('Expected type "'), rt.get_property(var_type_mutated, 'name')), rt.new_string('".'))).str()), rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Utils_?array', []string{}, var_path), var_value_mutated.clone(), var_error.clone())
			return Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Value.oferrors(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array](rt.create_array([rt.ArrayItem{ key: none, val: iife_result_3 }])))
			unsafe { goto end_label_1 }
		}
		else {
			rt.throw_exception(var_e_1)
			unsafe { goto end_label_1 }
		}

end_label_1:
	}
	if rt.is_true(rt.new_bool(rt.instance_of(var_type_mutated, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ListOfType'))) {
		mut var_itemType := rt.call_method(var_type_mutated, 'getWrappedType', []rt.PhpVal{})
		rt.call_function('assert', [rt.new_bool(rt.instance_of(var_itemType, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InputType')), rt.new_string('known through schema validation')])
		if rt.is_true(rt.call_function('is_iterable', [var_value_mutated.clone()])) {
			mut var_errors := rt.new_array()
			mut var_coercedValue := rt.new_array()
			mut iter_1 := var_value_mutated.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_itemValue := item_1.val
				mut var_index := item_1.key
				mut var_coercedItem := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Value.coerceinputvalue(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InputType](var_itemValue), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_?array](var_itemType), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_?Schema](rt.create_array([rt.ArrayItem{ key: none, val: if !(var_path).is_null() { var_path } else { rt.new_array() } }, rt.ArrayItem{ key: none, val: var_index }])), rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Utils_?Schema', []string{}, var_schema))
				if var_coercedItem.array_isset(rt.new_string('errors')) {
				var_errors = Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Value.add(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array](var_errors), var_coercedItem.array_get(rt.new_string('errors')))
				} else {
					var_coercedValue.array_push(var_coercedItem.array_get(rt.new_string('value')))
				}
			}
			return if rt.is_true(rt.identical(var_errors, rt.new_array())) { Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Value.ofvalue(var_coercedValue.clone()) } else { Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Value.oferrors(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array](var_errors)) }
		}
		mut var_coercedItem := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Value.coerceinputvalue(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InputType](var_value_mutated), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_?array](var_itemType), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_?Schema](rt.new_null()), rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Utils_?Schema', []string{}, var_schema))
		return if var_coercedItem.array_isset(rt.new_string('errors')) { var_coercedItem } else { Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Value.ofvalue(rt.create_array([rt.ArrayItem{ key: none, val: var_coercedItem.array_get(rt.new_string('value')) }])) }
	}
	rt.call_function('assert', [rt.new_bool(rt.instance_of(var_type_mutated, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InputObjectType')), rt.new_string('we handled all other cases at this point')])
	if rt.is_true(rt.new_bool(rt.instance_of(var_value_mutated, 'Automattic_WooCommerce_Vendor_GraphQL_Utils_stdClass'))) {
	var_value_mutated = rt.cast_array(var_value_mutated)
	} else if !(var_value_mutated.clone().is_array()) {
		mut iife_temp_4 := Class_Automattic_WooCommerce_Vendor_GraphQL_Error_CoercionError{}
		mut iife_result_4 := iife_temp_4.make(rt.new_string((rt.concat(rt.concat(rt.new_string('Expected type "'), rt.get_property(var_type_mutated, 'name')), rt.new_string('" to be an object.'))).str()), rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Utils_?array', []string{}, var_path), var_value_mutated.clone())
		return Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Value.oferrors(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array](rt.create_array([rt.ArrayItem{ key: none, val: iife_result_4 }])))
	}
	var_errors = rt.new_array()
	var_coercedValue = rt.new_array()
	mut var_fields := rt.call_method(var_type_mutated, 'getFields', []rt.PhpVal{})
	mut iter_2 := var_fields.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_field := item_2.val
		mut var_fieldName := item_2.key
		if rt.is_true(rt.new_bool(var_value_mutated.clone().array_isset(var_fieldName.clone()))) {
			mut var_fieldValue := var_value_mutated.array_get(var_fieldName)
			mut var_coercedField := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Value.coerceinputvalue(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InputType](var_fieldValue), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_?array](rt.call_method(var_field, 'getType', []rt.PhpVal{})), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_?Schema](rt.create_array([rt.ArrayItem{ key: none, val: if !(var_path).is_null() { var_path } else { rt.new_array() } }, rt.ArrayItem{ key: none, val: var_fieldName }])), rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Utils_?Schema', []string{}, var_schema))
			if var_coercedField.array_isset(rt.new_string('errors')) {
			var_errors = Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Value.add(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array](var_errors), var_coercedField.array_get(rt.new_string('errors')))
			} else {
				var_coercedValue.array_set(var_fieldName, var_coercedField.array_get(rt.new_string('value')))
			}
		} else if rt.is_true(rt.call_method(var_field, 'defaultValueExists', []rt.PhpVal{})) {
			var_coercedValue.array_set(var_fieldName, rt.get_property(var_field, 'defaultValue'))
		} else if rt.is_true(rt.new_bool(rt.instance_of(rt.call_method(var_field, 'getType', []rt.PhpVal{}), 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_NonNull'))) {
		mut iife_temp_5 := Class_Automattic_WooCommerce_Vendor_GraphQL_Error_CoercionError{}
		mut iife_result_5 := iife_temp_5.make(rt.new_string((rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('Field "'), var_fieldName), rt.new_string('" of required type "')), rt.call_method(rt.call_method(var_field, 'getType', []rt.PhpVal{}), 'toString', []rt.PhpVal{})), rt.new_string('" was not provided.'))).str()), rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Utils_?array', []string{}, var_path), var_value_mutated.clone())
		var_errors = Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Value.add(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array](var_errors), iife_result_5)
		}
	}
	mut iter_3 := var_value_mutated.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_field := item_3.val
		mut var_fieldName := item_3.key
		if rt.is_true(rt.new_bool(var_fields.clone().array_isset(var_fieldName.clone()))) {
			continue
		}
	mut iife_temp_6 := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils{}
	mut iife_result_6 := iife_temp_6.suggestionlist(rt.new_string((var_fieldName).str()), rt.func_array_keys(var_fields.clone()))
	mut var_suggestions := iife_result_6
	mut iife_temp_7 := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils{}
	mut iife_result_7 := iife_temp_7.quotedorlist(var_suggestions.clone())
	mut var_message := rt.new_string((rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('Field "'), var_fieldName), rt.new_string('" is not defined by type "')), rt.get_property(var_type_mutated, 'name')), rt.new_string('".')) + if rt.is_true(rt.identical(var_suggestions, rt.new_array())) { '' } else { ' Did you mean ' + (iife_result_7).str() + '?' }).str())
	mut iife_temp_8 := Class_Automattic_WooCommerce_Vendor_GraphQL_Error_CoercionError{}
	mut iife_result_8 := iife_temp_8.make(var_message.clone(), rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Utils_?array', []string{}, var_path), var_value_mutated.clone())
	var_errors = Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Value.add(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array](var_errors), iife_result_8)
	}
	if rt.is_true(rt.call_method(var_type_mutated, 'isOneOf', []rt.PhpVal{})) {
		mut var_providedFieldCount := rt.new_int(var_coercedValue.clone().array_count())
		mut var_nullFieldName := rt.new_null()
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_providedFieldCount, rt.new_int(1))))) {
		mut iife_temp_9 := Class_Automattic_WooCommerce_Vendor_GraphQL_Error_CoercionError{}
		mut iife_result_9 := iife_temp_9.make(rt.new_string((rt.concat(rt.concat(rt.new_string('OneOf input object "'), rt.get_property(var_type_mutated, 'name')), rt.new_string('" must specify exactly one field.'))).str()), rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Utils_?array', []string{}, var_path), var_value_mutated.clone())
		var_errors = Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Value.add(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array](var_errors), iife_result_9)
		} else {
			mut iter_4 := var_coercedValue.iterator()
			for {
				item_4 := iter_4.next() or { break }
				mut var_fieldValue := item_4.val
				mut var_fieldName := item_4.key
				if rt.is_true(rt.identical(var_fieldValue, rt.new_null())) {
				var_nullFieldName = var_fieldName
				}
			}
			if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_nullFieldName, rt.new_null())))) {
			mut iife_temp_10 := Class_Automattic_WooCommerce_Vendor_GraphQL_Error_CoercionError{}
			mut iife_result_10 := iife_temp_10.make(rt.new_string((rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('OneOf input object "'), rt.get_property(var_type_mutated, 'name')), rt.new_string('" field "')), var_nullFieldName), rt.new_string('" must be non-null.'))).str()), rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Utils_?array', []string{}, var_path), var_value_mutated.clone())
			var_errors = Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Value.add(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array](var_errors), iife_result_10)
			}
		}
	}
	return if rt.is_true(rt.identical(var_errors, rt.new_array())) { Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Value.ofvalue(rt.call_method(var_type_mutated, 'parseValue', [var_coercedValue.clone()])) } else { Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Value.oferrors(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array](var_errors)) }
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Value.oferrors(mut var_errors Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array) rt.PhpVal {
	mut var_errors_mutated := var_errors
	return rt.create_array([rt.ArrayItem{ key: 'errors', val: var_errors_mutated }, rt.ArrayItem{ key: 'value', val: rt.new_null() }])
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Value.ofvalue(var_value rt.PhpVal) rt.PhpVal {
	mut var_value_mutated := var_value
	return rt.create_array([rt.ArrayItem{ key: 'errors', val: rt.new_null() }, rt.ArrayItem{ key: 'value', val: var_value_mutated }])
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Value.add(mut var_errors Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array, var_errorOrErrors rt.PhpVal) rt.PhpVal {
	mut var_errors_mutated := var_errors
	mut var_moreErrors := if var_errorOrErrors.clone().is_array() { var_errorOrErrors } else { rt.create_array([rt.ArrayItem{ key: none, val: var_errorOrErrors }]) }
	return rt.call_function('array_merge', [var_errors_mutated, var_moreErrors.clone()])
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Error_CoercionError {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_vendor_graphql_utils_value(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Value {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Value{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_error_coercionerror(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Error_CoercionError {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Error_CoercionError{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_type_definition_type(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_utils_utils(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Value) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'coerceInputValue' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InputType](if args.len > 1 { args[1] } else { rt.new_null() })
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_?array](if args.len > 2 { args[2] } else { rt.new_null() })
			mut dispatch_arg_3 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_?Schema](if args.len > 3 { args[3] } else { rt.new_null() })
			return Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Value.coerceinputvalue(dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2, mut dispatch_arg_3)
		}
		'ofErrors' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Value.oferrors(mut dispatch_arg_0)
		}
		'ofValue' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Value.ofvalue(dispatch_arg_0)
		}
		'add' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Value.add(mut dispatch_arg_0, dispatch_arg_1)
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Value) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Value) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Error_CoercionError) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Error_CoercionError) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Error_CoercionError) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}



fn main() {
	defer {
		rt.shutdown()
	}

}
