import rt

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Values {
	rt.PhpObjectBase
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Values.getvariablevalues(mut var_schema Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema, mut var_varDefNodes Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeList, mut var_rawVariableValues Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_array) rt.PhpVal {
	mut var_errors := rt.new_array()
	mut var_coercedValues := rt.new_array()
	mut iter_1 := var_varDefNodes.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_varDefNode := item_1.val
		mut var_varName := rt.get_property(rt.get_property(rt.get_property(var_varDefNode, 'variable'), 'name'), 'value')
		mut iife_temp_0 := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_AST{}
		mut iife_result_0 := iife_temp_0.typefromast(rt.create_array([rt.ArrayItem{ key: none, val: var_schema }, rt.ArrayItem{ key: none, val: 'getType' }]), rt.get_property(var_varDefNode, 'type'))
		mut var_varType := iife_result_0
		mut iife_temp_1 := Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type{}
		mut iife_result_1 := iife_temp_1.isinputtype(var_varType.clone())
		if rt.is_true(rt.new_bool(!(rt.is_true(iife_result_1)))) {
			mut iife_temp_2 := Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer{}
			mut iife_result_2 := iife_temp_2.doprint(rt.get_property(var_varDefNode, 'type'))
			mut var_typeStr := iife_result_2
			var_errors.array_push(create_automattic_woocommerce_vendor_graphql_error_error(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('Variable "$'), var_varName), rt.new_string('" expected value of type "')), var_typeStr), rt.new_string('" which cannot be used as an input type.')), rt.create_array([rt.ArrayItem{ key: none, val: rt.get_property(var_varDefNode, 'type') }])))
		} else {
			mut var_hasValue := rt.new_bool(var_rawVariableValues.array_isset(var_varName.clone()))
			mut iife_temp_3 := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils{}
			mut iife_result_3 := iife_temp_3.undefined()
			mut var_value := if rt.is_true(var_hasValue) { var_rawVariableValues.array_get(var_varName) } else { iife_result_3 }
			if rt.is_true(rt.new_bool(!(rt.is_true(var_hasValue)))) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.get_property(var_varDefNode, 'defaultValue'), rt.new_null())))) {
				mut iife_temp_4 := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_AST{}
				mut iife_result_4 := iife_temp_4.valuefromast(rt.get_property(var_varDefNode, 'defaultValue'), var_varType.clone())
				var_coercedValues.array_set(var_varName, iife_result_4)
			} else if rt.is_true(rt.new_bool(!(rt.is_true(var_hasValue)))) || rt.is_true(rt.identical(var_value, rt.new_null())) && rt.is_true(rt.new_bool(rt.instance_of(var_varType, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_NonNull'))) {
				mut iife_temp_5 := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils{}
				mut iife_result_5 := iife_temp_5.printsafe(var_varType.clone())
				mut var_safeVarType := iife_result_5
				mut var_message := rt.new_string((if rt.is_true(var_hasValue) { rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('Variable "$'), var_varName), rt.new_string('" of non-null type "')), var_safeVarType), rt.new_string('" must not be null.')) } else { rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('Variable "$'), var_varName), rt.new_string('" of required type "')), var_safeVarType), rt.new_string('" was not provided.')) }).str())
				var_errors.array_push(create_automattic_woocommerce_vendor_graphql_error_error(var_message.clone(), rt.create_array([rt.ArrayItem{ key: none, val: var_varDefNode }])))
			} else if rt.is_true(var_hasValue) {
				if rt.is_true(rt.identical(var_value, rt.new_null())) {
					var_coercedValues.array_set(var_varName, rt.new_null())
				} else {
					mut iife_temp_6 := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Value{}
					mut iife_result_6 := iife_temp_6.coerceinputvalue(var_value.clone(), var_varType.clone(), rt.new_null(), rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Schema', []string{}, var_schema))
					mut var_coerced := iife_result_6
					mut var_coercionErrors := var_coerced.array_get(rt.new_string('errors'))
					if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_coercionErrors, rt.new_null())))) {
						mut iter_2 := var_coercionErrors.iterator()
						for {
							item_2 := iter_2.next() or { break }
							mut var_coercionError := item_2.val
							mut var_invalidValue := rt.call_method(var_coercionError, 'printInvalidValue', []rt.PhpVal{})
							mut var_inputPath := rt.call_method(var_coercionError, 'printInputPath', []rt.PhpVal{})
							mut var_pathMessage := rt.new_string((if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_inputPath, rt.new_null())))) { " at \"${var_varName.to_string()}${var_inputPath.to_string()}\"" } else { '' }).str())
							var_errors.array_push(create_automattic_woocommerce_vendor_graphql_error_error(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('Variable "$'), var_varName), rt.new_string('" got invalid value ')), var_invalidValue), var_pathMessage), rt.new_string('; ')), rt.call_method(var_coercionError, 'getMessage', []rt.PhpVal{})), var_varDefNode.clone(), rt.call_method(var_coercionError, 'getSource', []rt.PhpVal{}), rt.call_method(var_coercionError, 'getPositions', []rt.PhpVal{}), rt.call_method(var_coercionError, 'getPath', []rt.PhpVal{}), var_coercionError.clone(), rt.call_method(var_coercionError, 'getExtensions', []rt.PhpVal{})))
						}
					} else {
						var_coercedValues.array_set(var_varName, var_coerced.array_get(rt.new_string('value')))
					}
				}
			}
		}
	}
	return if rt.is_true(rt.identical(var_errors, rt.new_array())) { rt.create_array([rt.ArrayItem{ key: none, val: rt.new_null() }, rt.ArrayItem{ key: none, val: var_coercedValues }]) } else { rt.create_array([rt.ArrayItem{ key: none, val: var_errors }, rt.ArrayItem{ key: none, val: rt.new_null() }]) }
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Values.getdirectivevalues(mut var_directiveDef Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Directive, mut var_node Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Node, mut var_variableValues Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_?array, mut var_schema Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_?Schema) rt.PhpVal {
	mut var_directiveDefName := rt.get_property(var_directiveDef, 'name')
	mut iter_3 := rt.get_property(var_node, 'directives').iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_directive := item_3.val
		if rt.is_true(rt.identical(rt.get_property(rt.get_property(var_directive, 'name'), 'value'), var_directiveDefName)) {
			return Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Values.getargumentvalues(mut var_directiveDef, mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_?array](var_directive), mut var_variableValues, rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Executor_?Schema', []string{}, var_schema))
		}
	}
	return rt.new_null()
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Values.getargumentvalues(var_def rt.PhpVal, mut var_node Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Node, mut var_variableValues Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_?array, mut var_schema Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_?Schema) rt.PhpVal {
	if rt.is_true(rt.identical(rt.get_property(var_def, 'args'), rt.new_array())) {
		return rt.new_array()
	}
	mut var_argumentValueMap := rt.new_array()
	if !(rt.get_property(var_node, 'arguments')).is_null() {
		mut iter_4 := rt.get_property(var_node, 'arguments').iterator()
		for {
			item_4 := iter_4.next() or { break }
			mut var_argumentNode := item_4.val
			var_argumentValueMap.array_set(rt.get_property(rt.get_property(var_argumentNode, 'name'), 'value'), rt.get_property(var_argumentNode, 'value'))
		}
	}
	return Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Values.getargumentvaluesformap(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_array](var_def), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_?array](var_argumentValueMap), mut var_variableValues, mut var_node, rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Executor_?Schema', []string{}, var_schema))
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Values.getargumentvaluesformap(var_def rt.PhpVal, mut var_argumentValueMap Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_array, mut var_variableValues Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_?array, mut var_referenceNode Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_?Node, mut var_schema Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_?Schema) rt.PhpVal {
	mut var_argumentValueMap_mutated := var_argumentValueMap
	mut var_coercedValues := rt.new_array()
	mut iter_5 := rt.get_property(var_def, 'args').iterator()
	for {
		item_5 := iter_5.next() or { break }
		mut var_argumentDefinition := item_5.val
		mut var_name := rt.get_property(var_argumentDefinition, 'name')
		mut var_argType := rt.call_method(var_argumentDefinition, 'getType', []rt.PhpVal{})
		mut var_argumentValueNode := if !(var_argumentValueMap_mutated.array_get(var_name)).is_null() { var_argumentValueMap_mutated.array_get(var_name) } else { rt.new_null() }
		if rt.is_true(rt.new_bool(rt.instance_of(var_argumentValueNode, 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_VariableNode'))) {
		mut var_variableName := rt.get_property(rt.get_property(var_argumentValueNode, 'name'), 'value')
		mut var_hasValue := rt.new_bool(rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_variableValues, rt.new_null())))) && rt.is_true(rt.new_bool(var_variableValues.array_isset(var_variableName.clone()))))
		mut var_isNull := rt.new_bool(rt.is_true(var_hasValue) && rt.is_true(rt.identical(var_variableValues.array_get(var_variableName), rt.new_null())))
		} else {
		var_hasValue = rt.new_bool(!rt.is_true(rt.identical(var_argumentValueNode, rt.new_null())))
		var_isNull = rt.new_bool(rt.instance_of(var_argumentValueNode, 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NullValueNode'))
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(var_hasValue)))) && rt.is_true(rt.call_method(var_argumentDefinition, 'defaultValueExists', []rt.PhpVal{})) {
			var_coercedValues.array_set(var_name, rt.get_property(var_argumentDefinition, 'defaultValue'))
		} else if rt.is_true(rt.new_bool(!(rt.is_true(var_hasValue)))) || rt.is_true(var_isNull) && rt.is_true(rt.new_bool(rt.instance_of(var_argType, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_NonNull'))) {
			mut iife_temp_7 := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils{}
			mut iife_result_7 := iife_temp_7.printsafe(var_argType.clone())
			mut var_safeArgType := iife_result_7
			if rt.is_true(var_isNull) {
				rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Error_Error', []string{}, create_automattic_woocommerce_vendor_graphql_error_error(rt.new_string("Argument \"${var_name.to_string()}\" of non-null type \"${var_safeArgType.to_string()}\" must not be null."), var_referenceNode)))
			}
			if rt.is_true(rt.new_bool(rt.instance_of(var_argumentValueNode, 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_VariableNode'))) {
				rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Error_Error', []string{}, create_automattic_woocommerce_vendor_graphql_error_error(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('Argument "'), var_name), rt.new_string('" of required type "')), var_safeArgType), rt.new_string('" was provided the variable "$')), rt.get_property(rt.get_property(var_argumentValueNode, 'name'), 'value')), rt.new_string('" which was not provided a runtime value.')), rt.create_array([rt.ArrayItem{ key: none, val: var_argumentValueNode }]))))
			}
			rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Error_Error', []string{}, create_automattic_woocommerce_vendor_graphql_error_error(rt.new_string("Argument \"${var_name.to_string()}\" of required type \"${var_safeArgType.to_string()}\" was not provided."), var_referenceNode)))
		} else if rt.is_true(var_hasValue) {
			rt.call_function('assert', [rt.new_bool(rt.instance_of(var_argumentValueNode, 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Node'))])
			if rt.is_true(rt.new_bool(rt.instance_of(var_argumentValueNode, 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NullValueNode'))) {
				var_coercedValues.array_set(var_name, rt.new_null())
			} else if rt.is_true(rt.new_bool(rt.instance_of(var_argumentValueNode, 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_VariableNode'))) {
				var_variableName = rt.get_property(rt.get_property(var_argumentValueNode, 'name'), 'value')
				var_coercedValues.array_set(var_name, if !(var_variableValues.array_get(var_variableName)).is_null() { var_variableValues.array_get(var_variableName) } else { rt.new_null() })
			} else {
				mut iife_temp_8 := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_AST{}
				mut iife_result_8 := iife_temp_8.valuefromast(var_argumentValueNode.clone(), var_argType.clone(), rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Executor_?array', []string{}, var_variableValues), rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Executor_?Schema', []string{}, var_schema))
				mut var_coercedValue := iife_result_8
				mut iife_temp_9 := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils{}
				mut iife_result_9 := iife_temp_9.undefined()
				if rt.is_true(rt.identical(iife_result_9, var_coercedValue)) {
					mut iife_temp_10 := Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer{}
					mut iife_result_10 := iife_temp_10.doprint(var_argumentValueNode.clone())
					mut var_invalidValue := iife_result_10
					rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Error_Error', []string{}, create_automattic_woocommerce_vendor_graphql_error_error(rt.new_string("Argument \"${var_name.to_string()}\" has invalid value ${var_invalidValue.to_string()}."), rt.create_array([rt.ArrayItem{ key: none, val: var_argumentValueNode }]))))
				}
				var_coercedValues.array_set(var_name, var_coercedValue.clone())
			}
		}
	}
	return var_coercedValues.clone()
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_AST {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Error {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Value {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_vendor_graphql_executor_values(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Values {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Values{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_utils_ast(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_AST {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_AST{
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

fn create_automattic_woocommerce_vendor_graphql_language_printer(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_error_error(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Error {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Error{
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

fn create_automattic_woocommerce_vendor_graphql_utils_value(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Value {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Value{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Values) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'getVariableValues' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeList](if args.len > 1 { args[1] } else { rt.new_null() })
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_array](if args.len > 2 { args[2] } else { rt.new_null() })
			return Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Values.getvariablevalues(mut dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2)
		}
		'getDirectiveValues' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Directive](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Node](if args.len > 1 { args[1] } else { rt.new_null() })
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_?array](if args.len > 2 { args[2] } else { rt.new_null() })
			mut dispatch_arg_3 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_?Schema](if args.len > 3 { args[3] } else { rt.new_null() })
			return Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Values.getdirectivevalues(mut dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2, mut dispatch_arg_3)
		}
		'getArgumentValues' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Node](if args.len > 1 { args[1] } else { rt.new_null() })
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_?array](if args.len > 2 { args[2] } else { rt.new_null() })
			mut dispatch_arg_3 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_?Schema](if args.len > 3 { args[3] } else { rt.new_null() })
			return Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Values.getargumentvalues(dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2, mut dispatch_arg_3)
		}
		'getArgumentValuesForMap' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_array](if args.len > 1 { args[1] } else { rt.new_null() })
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_?array](if args.len > 2 { args[2] } else { rt.new_null() })
			mut dispatch_arg_3 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_?Node](if args.len > 3 { args[3] } else { rt.new_null() })
			mut dispatch_arg_4 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_?Schema](if args.len > 4 { args[4] } else { rt.new_null() })
			return Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Values.getargumentvaluesformap(dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2, mut dispatch_arg_3, mut dispatch_arg_4)
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Values) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Values) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_AST) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_AST) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_AST) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Error) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Error) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Error) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Value) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Value) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Value) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}



fn main() {
	defer {
		rt.shutdown()
	}

}
