import rt

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Value {
	rt.PhpObjectBase
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Value.coerceinputvalue(var_value rt.PhpVal, mut var_type Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InputType, mut var_path Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_?array, mut var_schema Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_?Schema) rt.PhpVal {
	mut var_value_mutated := var_value
	mut var_type_mutated := var_type
	if rt.is_true(rt.new_bool(rt.instance_of(var_type_mutated, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_NonNull'))) {
		if rt.is_true(rt.identical(var_value_mutated, rt.new_null())) {
			return Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Value.oferrors(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array](rt.create_array([rt.ArrayItem{ key: none, val: fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Error_CoercionError{}; return temp.make(arg_0, arg_1, arg_2) }(rt.new_string("Expected non-nullable type \"${var_type.to_string()}\" not to be null."), rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Utils_?array', []string{}, var_path), var_value_mutated.dup()) }])))
		}
		return Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Value.coerceinputvalue(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InputType](var_value_mutated), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_?array](rt.call_method(var_type_mutated, 'getWrappedType', []rt.PhpVal{})), mut var_path, rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Utils_?Schema', []string{}, var_schema))
	}
	if rt.is_true(rt.identical(var_value_mutated, rt.new_null())) {
		return Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Value.ofvalue(rt.new_null())
	}
	if rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) && rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type{}; return temp.isbuiltinscalar(arg_0) }(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InputType', []string{}, var_type_mutated))))) {
		mut var_schemaType := var_schema.gettype(rt.get_property(var_type_mutated, 'name'))
		rt.call_function('assert', [rt.new_bool(rt.instance_of(var_schemaType, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ScalarType')), rt.concat(rt.concat(rt.new_string('Schema must provide a ScalarType for built-in scalar "'), rt.get_property(var_type_mutated, 'name')), rt.new_string('".'))])
		var_type_mutated = var_schemaType.dup()
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.instance_of(var_type_mutated, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ScalarType'))) || rt.is_true(rt.new_bool(rt.instance_of(var_type_mutated, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_EnumType'))))) {
		return Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Value.ofvalue(rt.call_method(var_type_mutated, 'parseValue', [var_value_mutated.dup()]))
		unsafe { goto end_label_1 }

catch_label_1:
		mut var_e_1 := rt.get_and_clear_exception()
		if rt.instance_of(var_e_1, 'Automattic_WooCommerce_Vendor_GraphQL_Utils_Throwable') {
			mut var_error := var_e_1.dup()
			if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.instance_of(var_error, 'Automattic_WooCommerce_Vendor_GraphQL_Error_Error'))) || rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.instance_of(var_error, 'Automattic_WooCommerce_Vendor_GraphQL_Error_ClientAware'))) && rt.is_true(rt.call_method(var_error, 'isClientSafe', []rt.PhpVal{})))))) {
				return Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Value.oferrors(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array](rt.create_array([rt.ArrayItem{ key: none, val: fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal, arg_3 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Error_CoercionError{}; return temp.make(arg_0, arg_1, arg_2, arg_3) }(rt.call_method(var_error, 'getMessage', []rt.PhpVal{}), rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Utils_?array', []string{}, var_path), var_value_mutated.dup(), var_error.dup()) }])))
			}
			return Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Value.oferrors(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array](rt.create_array([rt.ArrayItem{ key: none, val: fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal, arg_3 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Error_CoercionError{}; return temp.make(arg_0, arg_1, arg_2, arg_3) }(rt.new_string(rt.concat(rt.concat(rt.new_string('Expected type "'), rt.get_property(var_type_mutated, 'name')), rt.new_string('".'))), rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Utils_?array', []string{}, var_path), var_value_mutated.dup(), var_error.dup()) }])))
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
		if rt.is_true(rt.call_function('is_iterable', [var_value_mutated.dup()])) {
			mut var_errors := rt.new_array()
			mut var_coercedValue := rt.new_array()
			{
				mut iter_1 := var_value_mutated.iterator()
				for {
					item_1 := iter_1.next() or { break }
					mut var_itemValue := item_1.val
					mut var_index := item_1.key
					mut var_coercedItem := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Value.coerceinputvalue(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InputType](var_itemValue), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_?array](var_itemType), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_?Schema](rt.create_array([rt.ArrayItem{ key: none, val: if !(var_path).is_null() { var_path } else { rt.new_array() } }, rt.ArrayItem{ key: none, val: var_index }])), rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Utils_?Schema', []string{}, var_schema))
					if var_coercedItem.array_isset(rt.new_string('errors')) {
						var_errors = Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Value.add(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array](var_errors), var_coercedItem.array_get('errors'))
					} else {
						var_coercedValue.array_push(var_coercedItem.array_get('value'))
					}
				}
			}
			return if rt.is_true(rt.identical(var_errors, rt.new_array())) { Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Value.ofvalue(var_coercedValue.dup()) } else { Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Value.oferrors(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array](var_errors)) }
		}
		mut var_coercedItem := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Value.coerceinputvalue(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InputType](var_value_mutated), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_?array](var_itemType), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_?Schema](rt.new_null()), rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Utils_?Schema', []string{}, var_schema))
		return if var_coercedItem.array_isset(rt.new_string('errors')) { var_coercedItem } else { Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Value.ofvalue(rt.create_array([rt.ArrayItem{ key: none, val: var_coercedItem.array_get('value') }])) }
	}
	rt.call_function('assert', [rt.new_bool(rt.instance_of(var_type_mutated, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InputObjectType')), rt.new_string('we handled all other cases at this point')])
	if rt.is_true(rt.new_bool(rt.instance_of(var_value_mutated, 'Automattic_WooCommerce_Vendor_GraphQL_Utils_stdClass'))) {
		var_value_mutated = rt.cast_array(var_value_mutated)
	} else if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_value_mutated.dup().is_array()))))) {
		return Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Value.oferrors(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array](rt.create_array([rt.ArrayItem{ key: none, val: fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Error_CoercionError{}; return temp.make(arg_0, arg_1, arg_2) }(rt.new_string(rt.concat(rt.concat(rt.new_string('Expected type "'), rt.get_property(var_type_mutated, 'name')), rt.new_string('" to be an object.'))), rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Utils_?array', []string{}, var_path), var_value_mutated.dup()) }])))
	}
	var_errors = rt.new_array()
	var_coercedValue = rt.new_array()
	mut var_fields := rt.call_method(var_type_mutated, 'getFields', []rt.PhpVal{})
	{
		mut iter_1 := var_fields.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_field := item_1.val
			mut var_fieldName := item_1.key
			if rt.is_true(rt.new_bool(var_value_mutated.dup().array_isset(var_fieldName.dup()))) {
				mut var_fieldValue := var_value_mutated.array_get(var_fieldName)
				mut var_coercedField := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Value.coerceinputvalue(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InputType](var_fieldValue), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_?array](rt.call_method(var_field, 'getType', []rt.PhpVal{})), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_?Schema](rt.create_array([rt.ArrayItem{ key: none, val: if !(var_path).is_null() { var_path } else { rt.new_array() } }, rt.ArrayItem{ key: none, val: var_fieldName }])), rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Utils_?Schema', []string{}, var_schema))
				if var_coercedField.array_isset(rt.new_string('errors')) {
					var_errors = Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Value.add(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array](var_errors), var_coercedField.array_get('errors'))
				} else {
					var_coercedValue.array_set(var_fieldName, var_coercedField.array_get('value'))
				}
			} else if rt.is_true(rt.call_method(var_field, 'defaultValueExists', []rt.PhpVal{})) {
				var_coercedValue.array_set(var_fieldName, rt.get_property(var_field, 'defaultValue'))
			} else if rt.is_true(rt.new_bool(rt.instance_of(rt.call_method(var_field, 'getType', []rt.PhpVal{}), 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_NonNull'))) {
				var_errors = Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Value.add(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array](var_errors), fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Error_CoercionError{}; return temp.make(arg_0, arg_1, arg_2) }(rt.new_string(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('Field "'), var_fieldName), rt.new_string('" of required type "')), rt.call_method(rt.call_method(var_field, 'getType', []rt.PhpVal{}), 'toString', []rt.PhpVal{})), rt.new_string('" was not provided.'))), rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Utils_?array', []string{}, var_path), var_value_mutated.dup()))
			}
		}
	}
	{
		mut iter_1 := var_value_mutated.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_field := item_1.val
			mut var_fieldName := item_1.key
			if rt.is_true(rt.new_bool(var_fields.dup().array_isset(var_fieldName.dup()))) {
				continue
			}
			mut var_suggestions := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils{}; return temp.suggestionlist(arg_0, arg_1) }(// unsupported expression: Expr_Cast_String, rt.func_array_keys(var_fields.dup()))
			mut var_message := rt.new_string(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('Field "'), var_fieldName), rt.new_string('" is not defined by type "')), rt.get_property(var_type_mutated, 'name')), rt.new_string('".')) + if rt.is_true(rt.identical(var_suggestions, rt.new_array())) { '' } else { ' Did you mean ' + (fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils{}; return temp.quotedorlist(arg_0) }(var_suggestions.dup())).str() + '?' })
			var_errors = Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Value.add(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array](var_errors), fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Error_CoercionError{}; return temp.make(arg_0, arg_1, arg_2) }(var_message.dup(), rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Utils_?array', []string{}, var_path), var_value_mutated.dup()))
		}
	}
	if rt.is_true(rt.call_method(var_type_mutated, 'isOneOf', []rt.PhpVal{})) {
		mut var_providedFieldCount := rt.new_int(rt.new_int(var_coercedValue.dup().array_count()))
		mut var_nullFieldName := rt.new_null()
		if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
			var_errors = Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Value.add(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array](var_errors), fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Error_CoercionError{}; return temp.make(arg_0, arg_1, arg_2) }(rt.new_string(rt.concat(rt.concat(rt.new_string('OneOf input object "'), rt.get_property(var_type_mutated, 'name')), rt.new_string('" must specify exactly one field.'))), rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Utils_?array', []string{}, var_path), var_value_mutated.dup()))
		} else {
			{
				mut iter_1 := var_coercedValue.iterator()
				for {
					item_1 := iter_1.next() or { break }
					mut var_fieldValue := item_1.val
					mut var_fieldName := item_1.key
					if rt.is_true(rt.identical(var_fieldValue, rt.new_null())) {
						var_nullFieldName = var_fieldName
					}
				}
			}
			if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
				var_errors = Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Value.add(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array](var_errors), fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Error_CoercionError{}; return temp.make(arg_0, arg_1, arg_2) }(rt.new_string(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('OneOf input object "'), rt.get_property(var_type_mutated, 'name')), rt.new_string('" field "')), var_nullFieldName), rt.new_string('" must be non-null.'))), rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Utils_?array', []string{}, var_path), var_value_mutated.dup()))
			}
		}
	}
	return if rt.is_true(rt.identical(var_errors, rt.new_array())) { Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Value.ofvalue(rt.call_method(var_type_mutated, 'parseValue', [var_coercedValue.dup()])) } else { Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Value.oferrors(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array](var_errors)) }
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
	mut var_moreErrors := if rt.is_true(rt.new_bool(var_errorOrErrors.dup().is_array())) { var_errorOrErrors } else { rt.create_array([rt.ArrayItem{ key: none, val: var_errorOrErrors }]) }
	return rt.call_function('array_merge', [var_errors_mutated.dup(), var_moreErrors.dup()])
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

fn create_automattic_woocommerce_vendor_graphql_utils_value() &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Value {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Value{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_error_coercionerror() &Class_Automattic_WooCommerce_Vendor_GraphQL_Error_CoercionError {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Error_CoercionError{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_type_definition_type() &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_utils_utils() &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils {
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




pub fn init_wp_content_plugins_woocommerce_lib_packages_graphql_utils_value_php() {
	// unsupported statement: Stmt_Declare
}
