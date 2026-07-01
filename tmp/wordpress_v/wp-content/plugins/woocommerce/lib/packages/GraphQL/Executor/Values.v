import rt

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Values {
	rt.PhpObjectBase
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Values.getvariablevalues(mut var_schema Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema, mut var_varDefNodes Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeList, mut var_rawVariableValues Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_array) rt.PhpVal {
	mut var_errors := rt.new_array()
	mut var_coercedValues := rt.new_array()
	{
		mut iter_1 := var_varDefNodes.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_varDefNode := item_1.val
			mut var_varName := rt.get_property(rt.get_property(rt.get_property(var_varDefNode, 'variable'), 'name'), 'value')
			mut var_varType := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_AST{}; return temp.typefromast(arg_0, arg_1) }(rt.create_array([rt.ArrayItem{ key: none, val: var_schema }, rt.ArrayItem{ key: none, val: 'getType' }]), rt.get_property(var_varDefNode, 'type'))
			if rt.is_true(rt.new_bool(!(rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type{}; return temp.isinputtype(arg_0) }(var_varType.dup()))))) {
				mut var_typeStr := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer{}; return temp.doprint(arg_0) }(rt.get_property(var_varDefNode, 'type'))
				var_errors.array_push(create_automattic_woocommerce_vendor_graphql_error_error(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('Variable "$'), var_varName), rt.new_string('" expected value of type "')), var_typeStr), rt.new_string('" which cannot be used as an input type.')), rt.create_array([rt.ArrayItem{ key: none, val: rt.get_property(var_varDefNode, 'type') }])))
			} else {
				mut var_hasValue := rt.new_bool(rt.new_bool(var_rawVariableValues.array_isset(var_varName.dup())))
				mut var_value := if rt.is_true(var_hasValue) { var_rawVariableValues.array_get(var_varName) } else { fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils{}; return temp.undefined() }() }
				if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_hasValue)))) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
					var_coercedValues.array_set(var_varName, fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_AST{}; return temp.valuefromast(arg_0, arg_1) }(rt.get_property(var_varDefNode, 'defaultValue'), var_varType.dup()))
				} else if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_hasValue)))) || rt.is_true(rt.identical(var_value, rt.new_null())))) && rt.is_true(rt.new_bool(rt.instance_of(var_varType, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_NonNull'))))) {
					mut var_safeVarType := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils{}; return temp.printsafe(arg_0) }(var_varType.dup())
					mut var_message := rt.new_string(if rt.is_true(var_hasValue) { rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('Variable "$'), var_varName), rt.new_string('" of non-null type "')), var_safeVarType), rt.new_string('" must not be null.')) } else { rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('Variable "$'), var_varName), rt.new_string('" of required type "')), var_safeVarType), rt.new_string('" was not provided.')) })
					var_errors.array_push(create_automattic_woocommerce_vendor_graphql_error_error(var_message.dup(), rt.create_array([rt.ArrayItem{ key: none, val: var_varDefNode }])))
				} else if rt.is_true(var_hasValue) {
					if rt.is_true(rt.identical(var_value, rt.new_null())) {
						var_coercedValues.array_set(var_varName, rt.new_null())
					} else {
						mut var_coerced := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal, arg_3 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Value{}; return temp.coerceinputvalue(arg_0, arg_1, arg_2, arg_3) }(var_value.dup(), var_varType.dup(), rt.new_null(), rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Schema', []string{}, var_schema))
						mut var_coercionErrors := var_coerced.array_get('errors')
						if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
							{
								mut iter_2 := var_coercionErrors.iterator()
								for {
									item_2 := iter_2.next() or { break }
									mut var_coercionError := item_2.val
									mut var_invalidValue := rt.call_method(var_coercionError, 'printInvalidValue', []rt.PhpVal{})
									mut var_inputPath := rt.call_method(var_coercionError, 'printInputPath', []rt.PhpVal{})
									mut var_pathMessage := rt.new_string(if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) { rt.new_string(" at \"${var_varName.to_string()}${var_inputPath.to_string()}\"") } else { rt.new_string('') })
									var_errors.array_push(create_automattic_woocommerce_vendor_graphql_error_error(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('Variable "$'), var_varName), rt.new_string('" got invalid value ')), var_invalidValue), var_pathMessage), rt.new_string('; ')), rt.call_method(var_coercionError, 'getMessage', []rt.PhpVal{})), var_varDefNode.dup(), rt.call_method(var_coercionError, 'getSource', []rt.PhpVal{}), rt.call_method(var_coercionError, 'getPositions', []rt.PhpVal{}), rt.call_method(var_coercionError, 'getPath', []rt.PhpVal{}), var_coercionError.dup(), rt.call_method(var_coercionError, 'getExtensions', []rt.PhpVal{})))
								}
							}
						} else {
							var_coercedValues.array_set(var_varName, var_coerced.array_get('value'))
						}
					}
				}
			}
		}
	}
	return if rt.is_true(rt.identical(var_errors, rt.new_array())) { rt.create_array([rt.ArrayItem{ key: none, val: rt.new_null() }, rt.ArrayItem{ key: none, val: var_coercedValues }]) } else { rt.create_array([rt.ArrayItem{ key: none, val: var_errors }, rt.ArrayItem{ key: none, val: rt.new_null() }]) }
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Values.getdirectivevalues(mut var_directiveDef Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Directive, mut var_node Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Node, mut var_variableValues Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_?array, mut var_schema Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_?Schema) rt.PhpVal {
	mut var_directiveDefName := rt.get_property(var_directiveDef, 'name')
	{
		mut iter_1 := rt.get_property(var_node, 'directives').iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_directive := item_1.val
			if rt.is_true(rt.identical(rt.get_property(rt.get_property(var_directive, 'name'), 'value'), var_directiveDefName)) {
				return Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Values.getargumentvalues(mut var_directiveDef, mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_?array](var_directive), mut var_variableValues, rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Executor_?Schema', []string{}, var_schema))
			}
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
		{
			mut iter_1 := rt.get_property(var_node, 'arguments').iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_argumentNode := item_1.val
				var_argumentValueMap.array_set(rt.get_property(rt.get_property(var_argumentNode, 'name'), 'value'), rt.get_property(var_argumentNode, 'value'))
			}
		}
	}
	return Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Values.getargumentvaluesformap(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_array](var_def), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_?array](var_argumentValueMap), mut var_variableValues, mut var_node, rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Executor_?Schema', []string{}, var_schema))
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Values.getargumentvaluesformap(var_def rt.PhpVal, mut var_argumentValueMap Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_array, mut var_variableValues Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_?array, mut var_referenceNode Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_?Node, mut var_schema Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_?Schema) rt.PhpVal {
	mut var_argumentValueMap_mutated := var_argumentValueMap
	mut var_coercedValues := rt.new_array()
	{
		mut iter_1 := rt.get_property(var_def, 'args').iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_argumentDefinition := item_1.val
			mut var_name := rt.get_property(var_argumentDefinition, 'name')
			mut var_argType := rt.call_method(var_argumentDefinition, 'getType', []rt.PhpVal{})
			mut var_argumentValueNode := if !(var_argumentValueMap_mutated.array_get(var_name)).is_null() { var_argumentValueMap_mutated.array_get(var_name) } else { rt.new_null() }
			if rt.is_true(rt.new_bool(rt.instance_of(var_argumentValueNode, 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_VariableNode'))) {
				mut var_variableName := rt.get_property(rt.get_property(var_argumentValueNode, 'name'), 'value')
				mut var_hasValue := rt.new_bool(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) && rt.is_true(rt.new_bool(var_variableValues.array_isset(var_variableName.dup())))))
				mut var_isNull := rt.new_bool(rt.new_bool(rt.is_true(var_hasValue) && rt.is_true(rt.identical(var_variableValues.array_get(var_variableName), rt.new_null()))))
			} else {
				var_hasValue = // unsupported expression: Expr_BinaryOp_NotIdentical
				var_isNull = rt.new_bool(rt.instance_of(var_argumentValueNode, 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NullValueNode'))
			}
			if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_hasValue)))) && rt.is_true(rt.call_method(var_argumentDefinition, 'defaultValueExists', []rt.PhpVal{})))) {
				var_coercedValues.array_set(var_name, rt.get_property(var_argumentDefinition, 'defaultValue'))
			} else if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_hasValue)))) || rt.is_true(var_isNull))) && rt.is_true(rt.new_bool(rt.instance_of(var_argType, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_NonNull'))))) {
				mut var_safeArgType := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils{}; return temp.printsafe(arg_0) }(var_argType.dup())
				if rt.is_true(var_isNull) {
					rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Error_Error', []string{}, create_automattic_woocommerce_vendor_graphql_error_error(rt.new_string("Argument \"${var_name.to_string()}\" of non-null type \"${var_safeArgType.to_string()}\" must not be null."), var_referenceNode.dup())))
				}
				if rt.is_true(rt.new_bool(rt.instance_of(var_argumentValueNode, 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_VariableNode'))) {
					rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Error_Error', []string{}, create_automattic_woocommerce_vendor_graphql_error_error(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('Argument "'), var_name), rt.new_string('" of required type "')), var_safeArgType), rt.new_string('" was provided the variable "$')), rt.get_property(rt.get_property(var_argumentValueNode, 'name'), 'value')), rt.new_string('" which was not provided a runtime value.')), rt.create_array([rt.ArrayItem{ key: none, val: var_argumentValueNode }]))))
				}
				rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Error_Error', []string{}, create_automattic_woocommerce_vendor_graphql_error_error(rt.new_string("Argument \"${var_name.to_string()}\" of required type \"${var_safeArgType.to_string()}\" was not provided."), var_referenceNode.dup())))
			} else if rt.is_true(var_hasValue) {
				rt.call_function('assert', [rt.new_bool(rt.instance_of(var_argumentValueNode, 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Node'))])
				if rt.is_true(rt.new_bool(rt.instance_of(var_argumentValueNode, 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NullValueNode'))) {
					var_coercedValues.array_set(var_name, rt.new_null())
				} else if rt.is_true(rt.new_bool(rt.instance_of(var_argumentValueNode, 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_VariableNode'))) {
					var_variableName = rt.get_property(rt.get_property(var_argumentValueNode, 'name'), 'value')
					var_coercedValues.array_set(var_name, if !(var_variableValues.array_get(var_variableName)).is_null() { var_variableValues.array_get(var_variableName) } else { rt.new_null() })
				} else {
					mut var_coercedValue := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal, arg_3 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_AST{}; return temp.valuefromast(arg_0, arg_1, arg_2, arg_3) }(var_argumentValueNode.dup(), var_argType.dup(), rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Executor_?array', []string{}, var_variableValues), rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Executor_?Schema', []string{}, var_schema))
					if rt.is_true(rt.identical(fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils{}; return temp.undefined() }(), var_coercedValue)) {
						mut var_invalidValue := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer{}; return temp.doprint(arg_0) }(var_argumentValueNode.dup())
						rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Error_Error', []string{}, create_automattic_woocommerce_vendor_graphql_error_error(, )))
					}
					var_coercedValues.array_set(var_name, var_coercedValue.dup())
				}
			}
		}
	}
	return var_coercedValues.dup()
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

fn create_automattic_woocommerce_vendor_graphql_executor_values() &Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Values {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Values{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_utils_ast() &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_AST {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_AST{
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

fn create_automattic_woocommerce_vendor_graphql_language_printer() &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_error_error() &Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Error {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Error{
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

fn create_automattic_woocommerce_vendor_graphql_utils_value() &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Value {
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




pub fn init_wp_content_plugins_woocommerce_lib_packages_graphql_executor_values_php() {
	// unsupported statement: Stmt_Declare
}
