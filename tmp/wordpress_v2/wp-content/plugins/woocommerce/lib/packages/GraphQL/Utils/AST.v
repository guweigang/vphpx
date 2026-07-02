import rt

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_AST {
	rt.PhpObjectBase
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_AST.fromarray(mut var_node Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array) rt.PhpVal {
	mut var_kind := if !(var_node.array_get(rt.new_string('kind'))).is_null() { var_node.array_get(rt.new_string('kind')) } else { rt.new_null() }
	if rt.is_true(rt.identical(var_kind, rt.new_null())) {
		mut iife_temp_0 := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils{}
		mut iife_result_0 := iife_temp_0.printsafejson(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Utils_array', []string{}, var_node))
		mut var_safeNode := iife_result_0
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Error_InvariantViolation', []string{}, create_automattic_woocommerce_vendor_graphql_error_invariantviolation(rt.new_string("Node is missing kind: ${var_safeNode.to_string()}"))))
	}
	mut var_class := if !(Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeKind.class_map().array_get(var_kind)).is_null() { Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeKind.class_map().array_get(var_kind) } else { rt.new_null() }
	if rt.is_true(rt.identical(var_class, rt.new_null())) {
		mut iife_temp_1 := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils{}
		mut iife_result_1 := iife_temp_1.printsafejson(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Utils_array', []string{}, var_node))
		var_safeNode = iife_result_1
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Error_InvariantViolation', []string{}, create_automattic_woocommerce_vendor_graphql_error_invariantviolation(rt.new_string("Node has unexpected kind: ${var_safeNode.to_string()}"))))
	}
	mut var_instance := rt.create_object_dynamically(var_class, [rt.new_array()])
	if var_node.array_get(rt.new_string('loc')).array_isset(rt.new_string('start')) && var_node.array_get(rt.new_string('loc')).array_isset(rt.new_string('end')) {
		mut iife_temp_2 := Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Location{}
		mut iife_result_2 := iife_temp_2.create(var_node.array_get(rt.new_string('loc')).array_get(rt.new_string('start')), var_node.array_get(rt.new_string('loc')).array_get(rt.new_string('end')))
		rt.set_property(var_instance, 'loc', iife_result_2)
	}
	mut iter_1 := var_node.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_value := item_1.val
		mut var_key := item_1.key
		if rt.is_true(rt.identical(var_key, rt.new_string('loc'))) || rt.is_true(rt.identical(var_key, rt.new_string('kind'))) {
			continue
		}
		if rt.is_true(rt.new_bool(var_value.clone().is_array())) {
		var_value = if var_value.array_isset(rt.new_int(0)) || rt.is_true(rt.identical(var_value, rt.new_array())) { create_automattic_woocommerce_vendor_graphql_language_ast_nodelist(var_value.clone()) } else { Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_AST.fromarray(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array](var_value)) }
		}
		rt.set_property(var_instance, '{"nodeType":"Expr_Variable","line":106,"name":"key"}', var_value.clone())
	}
	return var_instance.clone()
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_AST.toarray(mut var_node Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Node) rt.PhpVal {
	return var_node.toarray()
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_AST.astfromvalue(var_value rt.PhpVal, mut var_type Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InputType) rt.PhpVal {
	mut var_value_mutated := var_value
	mut var_type_mutated := var_type
	if rt.is_true(rt.new_bool(rt.instance_of(var_type_mutated, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_NonNull'))) {
		mut var_wrappedType := rt.call_method(var_type_mutated, 'getWrappedType', []rt.PhpVal{})
		rt.call_function('assert', [rt.new_bool(rt.instance_of(var_wrappedType, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InputType'))])
		mut var_astValue := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_AST.astfromvalue(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InputType](var_value_mutated), var_wrappedType.clone())
		return if rt.is_true(rt.new_bool(rt.instance_of(var_astValue, 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NullValueNode'))) { rt.new_null() } else { var_astValue }
	}
	if rt.is_true(rt.identical(var_value_mutated, rt.new_null())) {
		return create_automattic_woocommerce_vendor_graphql_language_ast_nullvaluenode(rt.new_array())
	}
	if rt.is_true(rt.new_bool(rt.instance_of(var_type_mutated, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ListOfType'))) {
		mut var_itemType := rt.call_method(var_type_mutated, 'getWrappedType', []rt.PhpVal{})
		rt.call_function('assert', [rt.new_bool(rt.instance_of(var_itemType, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InputType')), rt.new_string('proven by schema validation')])
		if rt.is_true(rt.call_function('is_iterable', [var_value_mutated.clone()])) {
			mut var_valuesNodes := rt.new_array()
			mut iter_2 := var_value_mutated.iterator()
			for {
				item_2 := iter_2.next() or { break }
				mut var_item := item_2.val
				mut var_itemNode := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_AST.astfromvalue(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InputType](var_item), var_itemType.clone())
				if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_itemNode, rt.new_null())))) {
					var_valuesNodes.array_push(var_itemNode.clone())
				}
			}
			return create_automattic_woocommerce_vendor_graphql_language_ast_listvaluenode(rt.create_array([rt.ArrayItem{ key: 'values', val: create_automattic_woocommerce_vendor_graphql_language_ast_nodelist(var_valuesNodes.clone()) }]))
		}
		return Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_AST.astfromvalue(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InputType](var_value_mutated), var_itemType.clone())
	}
	if rt.is_true(rt.new_bool(rt.instance_of(var_type_mutated, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InputObjectType'))) {
		mut var_isArray := rt.new_bool(var_value_mutated.clone().is_array())
		mut var_isArrayLike := rt.new_bool(rt.is_true(var_isArray) || rt.is_true(rt.new_bool(rt.instance_of(var_value_mutated, 'Automattic_WooCommerce_Vendor_GraphQL_Utils_ArrayAccess'))))
		if rt.is_true(rt.new_bool(!(rt.is_true(var_isArrayLike)))) && !(var_value_mutated.clone().is_object()) {
			return rt.new_null()
		}
		mut var_fields := rt.call_method(var_type_mutated, 'getFields', []rt.PhpVal{})
		mut var_fieldNodes := rt.new_array()
		mut iter_3 := var_fields.iterator()
		for {
			item_3 := iter_3.next() or { break }
			mut var_field := item_3.val
			mut var_fieldName := item_3.key
			mut var_fieldValue := if rt.is_true(var_isArrayLike) { if !(var_value_mutated.array_get(var_fieldName)).is_null() { var_value_mutated.array_get(var_fieldName) } else { rt.new_null() } } else { if !(rt.get_property(var_value_mutated, '{"nodeType":"Expr_Variable","line":205,"name":"fieldName"}')).is_null() { rt.get_property(var_value_mutated, '{"nodeType":"Expr_Variable","line":205,"name":"fieldName"}') } else { rt.new_null() } }
			if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_fieldValue, rt.new_null())))) {
			mut var_fieldExists := rt.new_bool(true)
			} else if rt.is_true(var_isArray) {
			var_fieldExists = rt.new_bool(var_value_mutated.clone().array_isset(var_fieldName.clone()))
			} else if rt.is_true(var_isArrayLike) {
			var_fieldExists = rt.call_method(var_value_mutated, 'offsetExists', [var_fieldName.clone()])
			} else {
			var_fieldExists = rt.call_function('property_exists', [var_value_mutated.clone(), var_fieldName.clone()])
			}
			if rt.is_true(rt.new_bool(!(rt.is_true(var_fieldExists)))) {
				continue
			}
			mut var_fieldNode := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_AST.astfromvalue(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InputType](var_fieldValue), rt.call_method(var_field, 'getType', []rt.PhpVal{}))
			if rt.is_true(rt.identical(var_fieldNode, rt.new_null())) {
				continue
			}
			var_fieldNodes.array_push(create_automattic_woocommerce_vendor_graphql_language_ast_objectfieldnode(rt.create_array([rt.ArrayItem{ key: 'name', val: create_automattic_woocommerce_vendor_graphql_language_ast_namenode(rt.create_array([rt.ArrayItem{ key: 'value', val: var_fieldName }])) }, rt.ArrayItem{ key: 'value', val: var_fieldNode }])))
		}
		return create_automattic_woocommerce_vendor_graphql_language_ast_objectvaluenode(rt.create_array([rt.ArrayItem{ key: 'fields', val: create_automattic_woocommerce_vendor_graphql_language_ast_nodelist(var_fieldNodes.clone()) }]))
	}
	rt.call_function('assert', [rt.new_bool(rt.instance_of(var_type_mutated, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_LeafType')), rt.new_string('other options were exhausted')])
	mut var_serialized := rt.call_method(var_type_mutated, 'serialize', [var_value_mutated.clone()])
	if rt.is_true(rt.new_bool(var_serialized.clone().is_bool())) {
		return create_automattic_woocommerce_vendor_graphql_language_ast_booleanvaluenode(rt.create_array([rt.ArrayItem{ key: 'value', val: var_serialized }]))
	}
	if rt.is_true(rt.new_bool(var_serialized.clone().is_long())) {
		return create_automattic_woocommerce_vendor_graphql_language_ast_intvaluenode(rt.create_array([rt.ArrayItem{ key: 'value', val: (var_serialized).str() }]))
	}
	if rt.is_true(rt.new_bool(var_serialized.clone().is_double())) {
		if rt.is_true(rt.equal(rt.new_int((var_serialized).to_i64()), var_serialized)) {
			return create_automattic_woocommerce_vendor_graphql_language_ast_intvaluenode(rt.create_array([rt.ArrayItem{ key: 'value', val: (var_serialized).str() }]))
		}
		return create_automattic_woocommerce_vendor_graphql_language_ast_floatvaluenode(rt.create_array([rt.ArrayItem{ key: 'value', val: (var_serialized).str() }]))
	}
	if rt.is_true(rt.new_bool(var_serialized.clone().is_string())) {
		if rt.is_true(rt.new_bool(rt.instance_of(var_type_mutated, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_EnumType'))) {
			return create_automattic_woocommerce_vendor_graphql_language_ast_enumvaluenode(rt.create_array([rt.ArrayItem{ key: 'value', val: var_serialized }]))
		}
		mut var_asInt := rt.new_int((var_serialized).to_i64())
		if rt.is_true(rt.new_bool(rt.instance_of(var_type_mutated, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_IDType'))) && rt.is_true(rt.identical((var_asInt).str(), var_serialized)) {
			return create_automattic_woocommerce_vendor_graphql_language_ast_intvaluenode(rt.create_array([rt.ArrayItem{ key: 'value', val: var_serialized }]))
		}
		return create_automattic_woocommerce_vendor_graphql_language_ast_stringvaluenode(rt.create_array([rt.ArrayItem{ key: 'value', val: var_serialized }]))
	}
	mut iife_temp_3 := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils{}
	mut iife_result_3 := iife_temp_3.printsafe(var_serialized.clone())
	mut var_notConvertible := iife_result_3
	rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Error_InvariantViolation', []string{}, create_automattic_woocommerce_vendor_graphql_error_invariantviolation(rt.new_string("Cannot convert value to AST: ${var_notConvertible.to_string()}"))))
	return rt.new_null()
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_AST.valuefromast(mut var_valueNode Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_?ValueNode, mut var_type Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type, mut var_variables Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_?array, mut var_schema Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_?Schema) rt.PhpVal {
	mut var_type_mutated := var_type
	mut iife_temp_4 := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils{}
	mut iife_result_4 := iife_temp_4.undefined()
	mut var_undefined := iife_result_4
	if rt.is_true(rt.identical(var_valueNode, rt.new_null())) {
		return var_undefined.clone()
	}
	if rt.is_true(rt.new_bool(rt.instance_of(var_type_mutated, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_NonNull'))) {
		if rt.is_true(rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Utils_?ValueNode', []string{}, var_valueNode), 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NullValueNode'))) {
			return var_undefined.clone()
		}
		return Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_AST.valuefromast(mut var_valueNode, mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type](rt.call_method(var_type_mutated, 'getWrappedType', []rt.PhpVal{})), mut var_variables, mut var_schema)
	}
	if rt.is_true(rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Utils_?ValueNode', []string{}, var_valueNode), 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NullValueNode'))) {
		return rt.new_null()
	}
	if rt.is_true(rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Utils_?ValueNode', []string{}, var_valueNode), 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_VariableNode'))) {
		mut var_variableName := rt.get_property(rt.get_property(var_valueNode, 'name'), 'value')
		if rt.is_true(rt.identical(var_variables, rt.new_null())) || rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_variables.array_isset(var_variableName.clone())))))) {
			return var_undefined.clone()
		}
		return var_variables.array_get(var_variableName)
	}
	if rt.is_true(rt.new_bool(rt.instance_of(var_type_mutated, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ListOfType'))) {
		mut var_itemType := rt.call_method(var_type_mutated, 'getWrappedType', []rt.PhpVal{})
		if rt.is_true(rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Utils_?ValueNode', []string{}, var_valueNode), 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_ListValueNode'))) {
			mut var_coercedValues := rt.new_array()
			mut var_itemNodes := rt.get_property(var_valueNode, 'values')
			mut iter_4 := var_itemNodes.iterator()
			for {
				item_4 := iter_4.next() or { break }
				mut var_itemNode := item_4.val
				if rt.is_true(Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_AST.ismissingvariable(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_ValueNode](var_itemNode), mut var_variables)) {
					if rt.is_true(rt.new_bool(rt.instance_of(var_itemType, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_NonNull'))) {
						return var_undefined.clone()
					}
					var_coercedValues.array_push(rt.new_null())
				} else {
					mut var_itemValue := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_AST.valuefromast(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_?ValueNode](var_itemNode), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type](var_itemType), mut var_variables, mut var_schema)
					if rt.is_true(rt.identical(var_undefined, var_itemValue)) {
						return var_undefined.clone()
					}
					var_coercedValues.array_push(var_itemValue.clone())
				}
			}
			return var_coercedValues.clone()
		}
		mut var_coercedValue := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_AST.valuefromast(mut var_valueNode, mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type](var_itemType), mut var_variables, mut var_schema)
		if rt.is_true(rt.identical(var_undefined, var_coercedValue)) {
			return var_undefined.clone()
		}
		return rt.create_array([rt.ArrayItem{ key: none, val: var_coercedValue }])
	}
	if rt.is_true(rt.new_bool(rt.instance_of(var_type_mutated, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InputObjectType'))) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Utils_?ValueNode', []string{}, var_valueNode), 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_ObjectValueNode')))))) {
			return var_undefined.clone()
		}
		mut var_coercedObj := rt.new_array()
		mut var_fields := rt.call_method(var_type_mutated, 'getFields', []rt.PhpVal{})
		mut var_fieldNodes := rt.new_array()
		mut iter_5 := rt.get_property(var_valueNode, 'fields').iterator()
		for {
			item_5 := iter_5.next() or { break }
			mut var_field := item_5.val
			var_fieldNodes.array_set(rt.get_property(rt.get_property(var_field, 'name'), 'value'), var_field.clone())
		}
		mut iter_6 := var_fields.iterator()
		for {
			item_6 := iter_6.next() or { break }
			mut var_field := item_6.val
			mut var_fieldName := rt.get_property(var_field, 'name')
			mut var_fieldNode := if !(var_fieldNodes.array_get(var_fieldName)).is_null() { var_fieldNodes.array_get(var_fieldName) } else { rt.new_null() }
			if rt.is_true(rt.identical(var_fieldNode, rt.new_null())) || rt.is_true(Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_AST.ismissingvariable(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_ValueNode](rt.get_property(var_fieldNode, 'value')), mut var_variables)) {
				if rt.is_true(rt.call_method(var_field, 'defaultValueExists', []rt.PhpVal{})) {
					var_coercedObj.array_set(var_fieldName, rt.get_property(var_field, 'defaultValue'))
				} else if rt.is_true(rt.new_bool(rt.instance_of(rt.call_method(var_field, 'getType', []rt.PhpVal{}), 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_NonNull'))) {
					return var_undefined.clone()
				}
				continue
			}
			mut var_fieldValue := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_AST.valuefromast(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_?ValueNode](rt.get_property(var_fieldNode, 'value')), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type](rt.call_method(var_field, 'getType', []rt.PhpVal{})), mut var_variables, mut var_schema)
			if rt.is_true(rt.identical(var_undefined, var_fieldValue)) {
				return var_undefined.clone()
			}
			var_coercedObj.array_set(var_fieldName, var_fieldValue.clone())
		}
		return rt.call_method(var_type_mutated, 'parseValue', [var_coercedObj.clone()])
	}
	if rt.is_true(rt.new_bool(rt.instance_of(var_type_mutated, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_EnumType'))) {
		return rt.call_method(var_type_mutated, 'parseLiteral', [var_valueNode, var_variables])
		unsafe { goto end_label_1 }

catch_label_1:
		mut var_e_1 := rt.get_and_clear_exception()
		if rt.instance_of(var_e_1, 'Automattic_WooCommerce_Vendor_GraphQL_Utils_Throwable') {
			mut var_error := var_e_1.clone()
			return var_undefined.clone()
			unsafe { goto end_label_1 }
		}
		else {
			rt.throw_exception(var_e_1)
			unsafe { goto end_label_1 }
		}

end_label_1:
	}
	rt.call_function('assert', [rt.new_bool(rt.instance_of(var_type_mutated, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ScalarType')), rt.new_string('only remaining option')])
	mut var_typeName := rt.get_property(var_type_mutated, 'name')
	mut iife_temp_5 := Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type{}
	mut iife_result_5 := iife_temp_5.isbuiltinscalarname(var_typeName.clone())
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_schema, rt.new_null())))) && rt.is_true(iife_result_5) {
		mut var_schemaType := var_schema.gettype(var_typeName.clone())
		rt.call_function('assert', [rt.new_bool(rt.instance_of(var_schemaType, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ScalarType')), rt.new_string("Schema must provide a ScalarType for built-in scalar \"${var_typeName.to_string()}\".")])
	var_type_mutated = var_schemaType.clone()
	}
	return rt.call_method(var_type_mutated, 'parseLiteral', [var_valueNode, var_variables])
	unsafe { goto end_label_2 }

catch_label_2:
	mut var_e_2 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_2, 'Automattic_WooCommerce_Vendor_GraphQL_Utils_Throwable') {
		var_error = var_e_2.clone()
		return var_undefined.clone()
		unsafe { goto end_label_2 }
	}
	else {
		rt.throw_exception(var_e_2)
		unsafe { goto end_label_2 }
	}

end_label_2:
	return rt.new_null()
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_AST.ismissingvariable(mut var_valueNode Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_ValueNode, mut var_variables Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_?array) bool {
	return rt.is_true(rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_ValueNode', []string{}, var_valueNode), 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_VariableNode'))) && rt.is_true(rt.identical(var_variables, rt.new_null())) || rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_variables.array_isset(rt.get_property(rt.get_property(var_valueNode, 'name'), 'value')))))))
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_AST.valuefromastuntyped(mut var_valueNode Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Node, mut var_variables Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_?array) rt.PhpVal {
	mut switch_val_1 := rt.new_bool(true)
	if rt.is_true(rt.equal(switch_val_1, rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Node', []string{}, var_valueNode), 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NullValueNode')))) {
		return rt.new_null()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Node', []string{}, var_valueNode), 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_IntValueNode')))) {
		return rt.new_int((rt.get_property(var_valueNode, 'value')).to_i64())
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Node', []string{}, var_valueNode), 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_FloatValueNode')))) {
		return rt.new_float((rt.get_property(var_valueNode, 'value')).to_f64())
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Node', []string{}, var_valueNode), 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_StringValueNode')))) || rt.is_true(rt.equal(switch_val_1, rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Node', []string{}, var_valueNode), 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_EnumValueNode')))) || rt.is_true(rt.equal(switch_val_1, rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Node', []string{}, var_valueNode), 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_BooleanValueNode')))) {
		return rt.get_property(var_valueNode, 'value')
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Node', []string{}, var_valueNode), 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_ListValueNode')))) {
		mut var_values := rt.new_array()
		mut iter_7 := rt.get_property(var_valueNode, 'values').iterator()
		for {
			item_7 := iter_7.next() or { break }
			mut var_node := item_7.val
			var_values.array_push(Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_AST.valuefromastuntyped(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Node](var_node), mut var_variables))
		}
		return var_values.clone()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Node', []string{}, var_valueNode), 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_ObjectValueNode')))) {
		var_values = rt.new_array()
		mut iter_8 := rt.get_property(var_valueNode, 'fields').iterator()
		for {
			item_8 := iter_8.next() or { break }
			mut var_field := item_8.val
			var_values.array_set(rt.get_property(rt.get_property(var_field, 'name'), 'value'), Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_AST.valuefromastuntyped(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Node](rt.get_property(var_field, 'value')), mut var_variables))
		}
		return var_values.clone()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Node', []string{}, var_valueNode), 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_VariableNode')))) {
		mut var_variableName := rt.get_property(rt.get_property(var_valueNode, 'name'), 'value')
		return if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(if !(var_variables).is_null() { var_variables } else { rt.new_array() }, rt.new_array())))) && var_variables.array_isset(var_variableName) { var_variables.array_get(var_variableName) } else { rt.new_null() }
	}
	rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Error_Error', []string{}, create_automattic_woocommerce_vendor_graphql_error_error(rt.concat(rt.new_string('Unexpected value kind: '), rt.get_property(var_valueNode, 'kind')))))
	return rt.new_null()
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_AST.typefromast(mut var_typeLoader Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_callable, mut var_inputTypeNode Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Node) rt.PhpVal {
	if rt.is_true(rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Node', []string{}, var_inputTypeNode), 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_ListTypeNode'))) {
		mut var_innerType := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_AST.typefromast(mut var_typeLoader, mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Node](rt.get_property(var_inputTypeNode, 'type')))
		return if rt.is_true(rt.identical(var_innerType, rt.new_null())) { rt.new_null() } else { create_automattic_woocommerce_vendor_graphql_type_definition_listoftype(var_innerType.clone()) }
	}
	if rt.is_true(rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Node', []string{}, var_inputTypeNode), 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NonNullTypeNode'))) {
		var_innerType = Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_AST.typefromast(mut var_typeLoader, mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Node](rt.get_property(var_inputTypeNode, 'type')))
		if rt.is_true(rt.identical(var_innerType, rt.new_null())) {
			return rt.new_null()
		}
		rt.call_function('assert', [rt.new_bool(rt.instance_of(var_innerType, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_NullableType')), rt.new_string('proven by schema validation')])
		return create_automattic_woocommerce_vendor_graphql_type_definition_nonnull(var_innerType.clone())
	}
	return rt.call_callable(var_typeLoader, [rt.get_property(rt.get_property(var_inputTypeNode, 'name'), 'value')])
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_AST.getoperationast(mut var_document Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_DocumentNode, mut var_operationName Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_?string) rt.PhpVal {
	mut var_operation := rt.new_null()
	mut iter_9 := rt.call_method(rt.get_property(var_document, 'definitions'), 'getIterator', []rt.PhpVal{}).iterator()
	for {
		item_9 := iter_9.next() or { break }
		mut var_node := item_9.val
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_node, 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_OperationDefinitionNode')))))) {
			continue
		}
		if rt.is_true(rt.identical(var_operationName, rt.new_null())) {
			if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_operation, rt.new_null())))) {
				return rt.new_null()
			}
		var_operation = var_node
		} else if rt.is_true(rt.new_bool(rt.instance_of(rt.get_property(var_node, 'name'), 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NameNode'))) && rt.is_true(rt.identical(rt.get_property(rt.get_property(var_node, 'name'), 'value'), var_operationName)) {
			return var_node.clone()
		}
	}
	return var_operation.clone()
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_AST.concatast(mut var_documents Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array) rt.PhpVal {
	mut var_definitions := rt.new_array()
	mut iter_10 := var_documents.iterator()
	for {
		item_10 := iter_10.next() or { break }
		mut var_document := item_10.val
		mut iter_11 := rt.get_property(var_document, 'definitions').iterator()
		for {
			item_11 := iter_11.next() or { break }
			mut var_definition := item_11.val
			var_definitions.array_push(var_definition.clone())
		}
	}
	return rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_DocumentNode', []string{}, create_automattic_woocommerce_vendor_graphql_language_ast_documentnode(rt.create_array([rt.ArrayItem{ key: 'definitions', val: create_automattic_woocommerce_vendor_graphql_language_ast_nodelist(var_definitions.clone()) }])))
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Error_InvariantViolation {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Location {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeList {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NullValueNode {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_ListValueNode {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_ObjectFieldNode {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NameNode {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_ObjectValueNode {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_BooleanValueNode {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_IntValueNode {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_FloatValueNode {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_EnumValueNode {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_StringValueNode {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Error {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ListOfType {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_NonNull {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_DocumentNode {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_vendor_graphql_utils_ast(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_AST {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_AST{
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

fn create_automattic_woocommerce_vendor_graphql_error_invariantviolation(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Error_InvariantViolation {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Error_InvariantViolation{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_language_ast_location(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Location {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Location{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_language_ast_nodelist(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeList {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeList{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_language_ast_nullvaluenode(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NullValueNode {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NullValueNode{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_language_ast_listvaluenode(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_ListValueNode {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_ListValueNode{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_language_ast_objectfieldnode(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_ObjectFieldNode {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_ObjectFieldNode{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_language_ast_namenode(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NameNode {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NameNode{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_language_ast_objectvaluenode(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_ObjectValueNode {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_ObjectValueNode{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_language_ast_booleanvaluenode(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_BooleanValueNode {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_BooleanValueNode{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_language_ast_intvaluenode(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_IntValueNode {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_IntValueNode{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_language_ast_floatvaluenode(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_FloatValueNode {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_FloatValueNode{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_language_ast_enumvaluenode(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_EnumValueNode {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_EnumValueNode{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_language_ast_stringvaluenode(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_StringValueNode {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_StringValueNode{
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

fn create_automattic_woocommerce_vendor_graphql_error_error(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Error {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_type_definition_listoftype(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ListOfType {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ListOfType{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_type_definition_nonnull(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_NonNull {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_NonNull{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_language_ast_documentnode(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_DocumentNode {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_DocumentNode{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_AST) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'fromArray' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_AST.fromarray(mut dispatch_arg_0)
		}
		'toArray' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Node](if args.len > 0 { args[0] } else { rt.new_null() })
			return Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_AST.toarray(mut dispatch_arg_0)
		}
		'astFromValue' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InputType](if args.len > 1 { args[1] } else { rt.new_null() })
			return Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_AST.astfromvalue(dispatch_arg_0, mut dispatch_arg_1)
		}
		'valueFromAST' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_?ValueNode](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type](if args.len > 1 { args[1] } else { rt.new_null() })
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_?array](if args.len > 2 { args[2] } else { rt.new_null() })
			mut dispatch_arg_3 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_?Schema](if args.len > 3 { args[3] } else { rt.new_null() })
			return Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_AST.valuefromast(mut dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2, mut dispatch_arg_3)
		}
		'isMissingVariable' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_ValueNode](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_?array](if args.len > 1 { args[1] } else { rt.new_null() })
			return rt.new_bool(Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_AST.ismissingvariable(mut dispatch_arg_0, mut dispatch_arg_1))
		}
		'valueFromASTUntyped' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Node](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_?array](if args.len > 1 { args[1] } else { rt.new_null() })
			return Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_AST.valuefromastuntyped(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		'typeFromAST' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_callable](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Node](if args.len > 1 { args[1] } else { rt.new_null() })
			return Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_AST.typefromast(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		'getOperationAST' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_DocumentNode](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_?string](if args.len > 1 { args[1] } else { rt.new_null() })
			return Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_AST.getoperationast(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		'concatAST' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_AST.concatast(mut dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_AST) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_AST) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Error_InvariantViolation) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Error_InvariantViolation) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Error_InvariantViolation) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Location) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Location) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Location) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeList) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeList) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeList) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NullValueNode) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NullValueNode) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NullValueNode) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_ListValueNode) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_ListValueNode) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_ListValueNode) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_ObjectFieldNode) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_ObjectFieldNode) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_ObjectFieldNode) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NameNode) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NameNode) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NameNode) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_ObjectValueNode) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_ObjectValueNode) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_ObjectValueNode) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_BooleanValueNode) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_BooleanValueNode) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_BooleanValueNode) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_IntValueNode) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_IntValueNode) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_IntValueNode) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_FloatValueNode) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_FloatValueNode) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_FloatValueNode) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_EnumValueNode) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_EnumValueNode) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_EnumValueNode) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_StringValueNode) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_StringValueNode) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_StringValueNode) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Error) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Error) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Error) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ListOfType) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ListOfType) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ListOfType) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_NonNull) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_NonNull) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_NonNull) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_DocumentNode) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_DocumentNode) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_DocumentNode) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn init_registry() {
	rt.register_class_factory('Automattic_WooCommerce_Vendor_GraphQL_Utils_AST', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_vendor_graphql_utils_ast()
		return rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Utils_AST', []string{}, obj)
	})
	rt.register_class_factory('Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_vendor_graphql_utils_utils()
		return rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils', []string{}, obj)
	})
	rt.register_class_factory('Automattic_WooCommerce_Vendor_GraphQL_Error_InvariantViolation', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_vendor_graphql_error_invariantviolation()
		return rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Error_InvariantViolation', []string{}, obj)
	})
	rt.register_class_factory('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Location', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_vendor_graphql_language_ast_location()
		return rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Location', []string{}, obj)
	})
	rt.register_class_factory('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeList', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_vendor_graphql_language_ast_nodelist()
		return rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeList', []string{}, obj)
	})
	rt.register_class_factory('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NullValueNode', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_vendor_graphql_language_ast_nullvaluenode()
		return rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NullValueNode', []string{}, obj)
	})
	rt.register_class_factory('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_ListValueNode', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_vendor_graphql_language_ast_listvaluenode()
		return rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_ListValueNode', []string{}, obj)
	})
	rt.register_class_factory('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_ObjectFieldNode', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_vendor_graphql_language_ast_objectfieldnode()
		return rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_ObjectFieldNode', []string{}, obj)
	})
	rt.register_class_factory('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NameNode', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_vendor_graphql_language_ast_namenode()
		return rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NameNode', []string{}, obj)
	})
	rt.register_class_factory('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_ObjectValueNode', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_vendor_graphql_language_ast_objectvaluenode()
		return rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_ObjectValueNode', []string{}, obj)
	})
	rt.register_class_factory('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_BooleanValueNode', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_vendor_graphql_language_ast_booleanvaluenode()
		return rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_BooleanValueNode', []string{}, obj)
	})
	rt.register_class_factory('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_IntValueNode', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_vendor_graphql_language_ast_intvaluenode()
		return rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_IntValueNode', []string{}, obj)
	})
	rt.register_class_factory('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_FloatValueNode', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_vendor_graphql_language_ast_floatvaluenode()
		return rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_FloatValueNode', []string{}, obj)
	})
	rt.register_class_factory('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_EnumValueNode', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_vendor_graphql_language_ast_enumvaluenode()
		return rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_EnumValueNode', []string{}, obj)
	})
	rt.register_class_factory('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_StringValueNode', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_vendor_graphql_language_ast_stringvaluenode()
		return rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_StringValueNode', []string{}, obj)
	})
	rt.register_class_factory('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_vendor_graphql_type_definition_type()
		return rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type', []string{}, obj)
	})
	rt.register_class_factory('Automattic_WooCommerce_Vendor_GraphQL_Error_Error', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_vendor_graphql_error_error()
		return rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Error_Error', []string{}, obj)
	})
	rt.register_class_factory('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ListOfType', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_vendor_graphql_type_definition_listoftype()
		return rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ListOfType', []string{}, obj)
	})
	rt.register_class_factory('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_NonNull', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_vendor_graphql_type_definition_nonnull()
		return rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_NonNull', []string{}, obj)
	})
	rt.register_class_factory('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_DocumentNode', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_vendor_graphql_language_ast_documentnode()
		return rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_DocumentNode', []string{}, obj)
	})
}

fn init() {
	init_registry()
}


fn main() {
	defer {
		rt.shutdown()
	}

}
