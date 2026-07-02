import rt

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_TypeInfo {
	rt.PhpObjectBase
pub mut:
		schema rt.PhpVal = rt.new_null()
		typeStack rt.PhpVal = rt.new_array()
		parentTypeStack rt.PhpVal = rt.new_array()
		inputTypeStack rt.PhpVal = rt.new_array()
		fieldDefStack rt.PhpVal = rt.new_array()
		defaultValueStack rt.PhpVal = rt.new_array()
		directive rt.PhpVal = rt.new_null()
		argument rt.PhpVal = rt.new_null()
		enumValue rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_TypeInfo) construct(mut var_schema Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema) {
	mut var_schema_mutated := var_schema
	this.schema = var_schema_mutated
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_TypeInfo) getparenttypestack() rt.PhpVal {
	return this.parentTypeStack
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_TypeInfo) getfielddefstack() rt.PhpVal {
	return this.fieldDefStack
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_TypeInfo.extracttypes(mut var_type Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type, mut var_typeMap Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array) {
	mut var_type_mutated := var_type
	mut var_typeMap_mutated := var_typeMap
	if rt.is_true(rt.new_bool(rt.instance_of(var_type_mutated, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_WrappingType'))) {
		Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_TypeInfo.extracttypes(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type](rt.call_method(var_type_mutated, 'getInnermostType', []rt.PhpVal{})), mut var_typeMap_mutated)
		return
	}
	mut var_name := rt.get_property(var_type_mutated, 'name')
	rt.call_function('assert', [rt.new_bool(var_name.clone().is_string())])
	if var_typeMap_mutated.array_isset(var_name) {
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_typeMap_mutated.array_get(var_name), var_type_mutated)))) {
			rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Error_InvariantViolation', []string{}, create_automattic_woocommerce_vendor_graphql_error_invariantviolation(rt.new_string("Schema must contain unique named types but contains multiple types named \"${var_type.to_string()}\" (see https://webonyx.github.io/graphql-php/type-definitions/#type-registry)."))))
		}
		return
	}
	var_typeMap_mutated.array_set(var_name, var_type_mutated)
	if rt.is_true(rt.new_bool(rt.instance_of(var_type_mutated, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_UnionType'))) {
		mut iter_1 := rt.call_method(var_type_mutated, 'getTypes', []rt.PhpVal{}).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_member := item_1.val
			Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_TypeInfo.extracttypes(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type](var_member), mut var_typeMap_mutated)
		}
		return
	}
	if rt.is_true(rt.new_bool(rt.instance_of(var_type_mutated, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InputObjectType'))) {
		mut iter_2 := rt.call_method(var_type_mutated, 'getFields', []rt.PhpVal{}).iterator()
		for {
			item_2 := iter_2.next() or { break }
			mut var_field := item_2.val
			mut var_fieldType := rt.call_method(var_field, 'getType', []rt.PhpVal{})
			rt.call_function('assert', [rt.new_bool(rt.is_true(rt.new_bool(rt.instance_of(var_fieldType, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_NamedType'))) || rt.is_true(rt.new_bool(rt.instance_of(var_fieldType, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_WrappingType'))))])
			Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_TypeInfo.extracttypes(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type](var_fieldType), mut var_typeMap_mutated)
		}
		return
	}
	if rt.is_true(rt.new_bool(rt.instance_of(var_type_mutated, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ImplementingType'))) {
		mut iter_3 := rt.call_method(var_type_mutated, 'getInterfaces', []rt.PhpVal{}).iterator()
		for {
			item_3 := iter_3.next() or { break }
			mut var_interface := item_3.val
			Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_TypeInfo.extracttypes(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type](var_interface), mut var_typeMap_mutated)
		}
	}
	if rt.is_true(rt.new_bool(rt.instance_of(var_type_mutated, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_HasFieldsType'))) {
		mut iter_4 := rt.call_method(var_type_mutated, 'getFields', []rt.PhpVal{}).iterator()
		for {
			item_4 := iter_4.next() or { break }
			mut var_field := item_4.val
			mut iter_5 := rt.get_property(var_field, 'args').iterator()
			for {
				item_5 := iter_5.next() or { break }
				mut var_arg := item_5.val
				mut var_argType := rt.call_method(var_arg, 'getType', []rt.PhpVal{})
				rt.call_function('assert', [rt.new_bool(rt.is_true(rt.new_bool(rt.instance_of(var_argType, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_NamedType'))) || rt.is_true(rt.new_bool(rt.instance_of(var_argType, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_WrappingType'))))])
				Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_TypeInfo.extracttypes(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type](var_argType), mut var_typeMap_mutated)
			}
			mut var_fieldType := rt.call_method(var_field, 'getType', []rt.PhpVal{})
			rt.call_function('assert', [rt.new_bool(rt.is_true(rt.new_bool(rt.instance_of(var_fieldType, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_NamedType'))) || rt.is_true(rt.new_bool(rt.instance_of(var_fieldType, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_WrappingType'))))])
			Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_TypeInfo.extracttypes(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type](var_fieldType), mut var_typeMap_mutated)
		}
	}
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_TypeInfo.extracttypesfromdirectives(mut var_directive Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Directive, mut var_typeMap Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array) {
	mut var_typeMap_mutated := var_typeMap
	mut iter_6 := rt.get_property(var_directive, 'args').iterator()
	for {
		item_6 := iter_6.next() or { break }
		mut var_arg := item_6.val
		mut var_argType := rt.call_method(var_arg, 'getType', []rt.PhpVal{})
		rt.call_function('assert', [rt.new_bool(rt.is_true(rt.new_bool(rt.instance_of(var_argType, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_NamedType'))) || rt.is_true(rt.new_bool(rt.instance_of(var_argType, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_WrappingType'))))])
		Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_TypeInfo.extracttypes(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type](var_argType), mut var_typeMap_mutated)
	}
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_TypeInfo) getparentinputtype() rt.PhpVal {
	return if !(this.inputTypeStack.array_get(rt.new_int(this.inputTypeStack.array_count() - 2))).is_null() { this.inputTypeStack.array_get(rt.new_int(this.inputTypeStack.array_count() - 2)) } else { rt.new_null() }
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_TypeInfo) getargument() rt.PhpVal {
	return this.argument
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_TypeInfo) getenumvalue() rt.PhpVal {
	return this.enumValue
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_TypeInfo) enter(mut var_node Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Node) {
	mut var_schema := this.schema
	mut switch_val_1 := rt.new_bool(true)
	if rt.is_true(rt.equal(switch_val_1, rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Node', []string{}, var_node), 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_SelectionSetNode')))) {
		mut iife_temp_0 := Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type{}
		mut iife_result_0 := iife_temp_0.getnamedtype(this.gettype())
		mut var_namedType := iife_result_0
		mut iife_temp_1 := Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type{}
		mut iife_result_1 := iife_temp_1.iscompositetype(var_namedType.clone())
		this.parentTypeStack.array_push(if rt.is_true(iife_result_1) { var_namedType } else { rt.new_null() })
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Node', []string{}, var_node), 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_FieldNode')))) {
		mut var_parentType := this.getparenttype()
		mut var_fieldDef := if rt.is_true(rt.identical(var_parentType, rt.new_null())) { rt.new_null() } else { Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_TypeInfo.getfielddefinition(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema](var_schema), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type](var_parentType), mut var_node) }
		mut var_fieldType := if rt.is_true(rt.identical(var_fieldDef, rt.new_null())) { rt.new_null() } else { rt.call_method(var_fieldDef, 'getType', []rt.PhpVal{}) }
		this.fieldDefStack.array_push(var_fieldDef.clone())
		this.typeStack.array_push(var_fieldType.clone())
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Node', []string{}, var_node), 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_DirectiveNode')))) {
		this.directive = rt.call_method(var_schema, 'getDirective', [rt.get_property(rt.get_property(var_node, 'name'), 'value')])
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Node', []string{}, var_node), 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_OperationDefinitionNode')))) {
		if rt.is_true(rt.identical(rt.get_property(var_node, 'operation'), rt.new_string('query'))) {
		mut var_type := rt.call_method(var_schema, 'getQueryType', []rt.PhpVal{})
		} else if rt.is_true(rt.identical(rt.get_property(var_node, 'operation'), rt.new_string('mutation'))) {
		var_type = rt.call_method(var_schema, 'getMutationType', []rt.PhpVal{})
		} else {
		var_type = rt.call_method(var_schema, 'getSubscriptionType', []rt.PhpVal{})
		}
		mut iife_temp_2 := Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type{}
		mut iife_result_2 := iife_temp_2.isoutputtype(var_type.clone())
		this.typeStack.array_push(if rt.is_true(iife_result_2) { var_type } else { rt.new_null() })
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Node', []string{}, var_node), 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_InlineFragmentNode')))) || rt.is_true(rt.equal(switch_val_1, rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Node', []string{}, var_node), 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_FragmentDefinitionNode')))) {
		mut var_typeConditionNode := rt.get_property(var_node, 'typeCondition')
		mut iife_temp_3 := Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type{}
		mut iife_result_3 := iife_temp_3.getnamedtype(this.gettype())
		mut iife_temp_4 := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_AST{}
		mut iife_result_4 := iife_temp_4.typefromast(rt.create_array([rt.ArrayItem{ key: none, val: var_schema }, rt.ArrayItem{ key: none, val: 'getType' }]), var_typeConditionNode.clone())
		mut var_outputType := if rt.is_true(rt.identical(var_typeConditionNode, rt.new_null())) { iife_result_3 } else { iife_result_4 }
		mut iife_temp_5 := Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type{}
		mut iife_result_5 := iife_temp_5.isoutputtype(var_outputType.clone())
		this.typeStack.array_push(if rt.is_true(iife_result_5) { var_outputType } else { rt.new_null() })
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Node', []string{}, var_node), 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_VariableDefinitionNode')))) {
		mut iife_temp_6 := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_AST{}
		mut iife_result_6 := iife_temp_6.typefromast(rt.create_array([rt.ArrayItem{ key: none, val: var_schema }, rt.ArrayItem{ key: none, val: 'getType' }]), rt.get_property(var_node, 'type'))
		mut var_inputType := iife_result_6
		mut iife_temp_7 := Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type{}
		mut iife_result_7 := iife_temp_7.isinputtype(var_inputType.clone())
		this.inputTypeStack.array_push(if rt.is_true(iife_result_7) { var_inputType } else { rt.new_null() })
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Node', []string{}, var_node), 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_ArgumentNode')))) {
		mut var_fieldOrDirective := if !(this.getdirective()).is_null() { this.getdirective() } else { this.getfielddef() }
		mut var_argDef := rt.new_null()
		mut var_argType := rt.new_null()
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_fieldOrDirective, rt.new_null())))) {
			mut iter_7 := rt.get_property(var_fieldOrDirective, 'args').iterator()
			for {
				item_7 := iter_7.next() or { break }
				mut var_arg := item_7.val
				if rt.is_true(rt.identical(rt.get_property(var_arg, 'name'), rt.get_property(rt.get_property(var_node, 'name'), 'value'))) {
				var_argDef = var_arg
				var_argType = rt.call_method(var_arg, 'getType', []rt.PhpVal{})
				}
			}
		}
		this.argument = var_argDef.clone()
		mut iife_temp_8 := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils{}
		mut iife_result_8 := iife_temp_8.undefined()
		this.defaultValueStack.array_push(if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_argDef, rt.new_null())))) && rt.is_true(rt.call_method(var_argDef, 'defaultValueExists', []rt.PhpVal{})) { rt.get_property(var_argDef, 'defaultValue') } else { iife_result_8 })
		mut iife_temp_9 := Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type{}
		mut iife_result_9 := iife_temp_9.isinputtype(var_argType.clone())
		this.inputTypeStack.array_push(if rt.is_true(iife_result_9) { var_argType } else { rt.new_null() })
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Node', []string{}, var_node), 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_ListValueNode')))) {
		var_type = this.getinputtype()
		mut var_listType := if rt.is_true(rt.new_bool(rt.instance_of(var_type, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_NonNull'))) { rt.call_method(var_type, 'getWrappedType', []rt.PhpVal{}) } else { var_type }
		mut var_itemType := if rt.is_true(rt.new_bool(rt.instance_of(var_listType, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ListOfType'))) { rt.call_method(var_listType, 'getWrappedType', []rt.PhpVal{}) } else { var_listType }
		mut iife_temp_10 := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils{}
		mut iife_result_10 := iife_temp_10.undefined()
		this.defaultValueStack.array_push(iife_result_10)
		mut iife_temp_11 := Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type{}
		mut iife_result_11 := iife_temp_11.isinputtype(var_itemType.clone())
		this.inputTypeStack.array_push(if rt.is_true(iife_result_11) { var_itemType } else { rt.new_null() })
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Node', []string{}, var_node), 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_ObjectFieldNode')))) {
		mut iife_temp_12 := Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type{}
		mut iife_result_12 := iife_temp_12.getnamedtype(this.getinputtype())
		mut var_objectType := iife_result_12
		mut var_inputField := rt.new_null()
		mut var_inputFieldType := rt.new_null()
		if rt.is_true(rt.new_bool(rt.instance_of(var_objectType, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InputObjectType'))) {
		mut var_tmp := rt.call_method(var_objectType, 'getFields', []rt.PhpVal{})
		var_inputField = if !(var_tmp.array_get(rt.get_property(rt.get_property(var_node, 'name'), 'value'))).is_null() { var_tmp.array_get(rt.get_property(rt.get_property(var_node, 'name'), 'value')) } else { rt.new_null() }
		var_inputFieldType = if rt.is_true(rt.identical(var_inputField, rt.new_null())) { rt.new_null() } else { rt.call_method(var_inputField, 'getType', []rt.PhpVal{}) }
		}
		mut iife_temp_13 := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils{}
		mut iife_result_13 := iife_temp_13.undefined()
		this.defaultValueStack.array_push(if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_inputField, rt.new_null())))) && rt.is_true(rt.call_method(var_inputField, 'defaultValueExists', []rt.PhpVal{})) { rt.get_property(var_inputField, 'defaultValue') } else { iife_result_13 })
		mut iife_temp_14 := Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type{}
		mut iife_result_14 := iife_temp_14.isinputtype(var_inputFieldType.clone())
		this.inputTypeStack.array_push(if rt.is_true(iife_result_14) { var_inputFieldType } else { rt.new_null() })
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Node', []string{}, var_node), 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_EnumValueNode')))) {
		mut iife_temp_15 := Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type{}
		mut iife_result_15 := iife_temp_15.getnamedtype(this.getinputtype())
		mut var_enumType := iife_result_15
		this.enumValue = if rt.is_true(rt.new_bool(rt.instance_of(var_enumType, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_EnumType'))) { rt.call_method(var_enumType, 'getValue', [rt.get_property(var_node, 'value')]) } else { rt.new_null() }
	}
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_TypeInfo) gettype() rt.PhpVal {
	return if !(this.typeStack.array_get(rt.new_int(this.typeStack.array_count() - 1))).is_null() { this.typeStack.array_get(rt.new_int(this.typeStack.array_count() - 1)) } else { rt.new_null() }
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_TypeInfo) getparenttype() rt.PhpVal {
	return if !(this.parentTypeStack.array_get(rt.new_int(this.parentTypeStack.array_count() - 1))).is_null() { this.parentTypeStack.array_get(rt.new_int(this.parentTypeStack.array_count() - 1)) } else { rt.new_null() }
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_TypeInfo.getfielddefinition(mut var_schema Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema, mut var_parentType Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type, mut var_fieldNode Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_FieldNode) rt.PhpVal {
	mut var_schema_mutated := var_schema
	mut var_parentType_mutated := var_parentType
	mut var_name := rt.get_property(rt.get_property(var_fieldNode, 'name'), 'value')
	mut iife_temp_16 := Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Introspection{}
	mut iife_result_16 := iife_temp_16.schemametafielddef()
	mut var_schemaMeta := iife_result_16
	if rt.is_true(rt.identical(var_name, rt.get_property(var_schemaMeta, 'name'))) && rt.is_true(rt.identical(rt.call_method(var_schema_mutated, 'getQueryType', []rt.PhpVal{}), var_parentType_mutated)) {
		return var_schemaMeta.clone()
	}
	mut iife_temp_17 := Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Introspection{}
	mut iife_result_17 := iife_temp_17.typemetafielddef()
	mut var_typeMeta := iife_result_17
	if rt.is_true(rt.identical(var_name, rt.get_property(var_typeMeta, 'name'))) && rt.is_true(rt.identical(rt.call_method(var_schema_mutated, 'getQueryType', []rt.PhpVal{}), var_parentType_mutated)) {
		return var_typeMeta.clone()
	}
	mut iife_temp_18 := Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Introspection{}
	mut iife_result_18 := iife_temp_18.typenamemetafielddef()
	mut var_typeNameMeta := iife_result_18
	if rt.is_true(rt.identical(var_name, rt.get_property(var_typeNameMeta, 'name'))) && rt.is_true(rt.new_bool(rt.instance_of(var_parentType_mutated, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_CompositeType'))) {
		return var_typeNameMeta.clone()
	}
	if rt.is_true(rt.new_bool(rt.instance_of(var_parentType_mutated, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ObjectType'))) || rt.is_true(rt.new_bool(rt.instance_of(var_parentType_mutated, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InterfaceType'))) {
		return rt.call_method(var_parentType_mutated, 'findField', [var_name.clone()])
	}
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_TypeInfo) getdirective() rt.PhpVal {
	return this.directive
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_TypeInfo) getfielddef() rt.PhpVal {
	return if !(this.fieldDefStack.array_get(rt.new_int(this.fieldDefStack.array_count() - 1))).is_null() { this.fieldDefStack.array_get(rt.new_int(this.fieldDefStack.array_count() - 1)) } else { rt.new_null() }
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_TypeInfo) getdefaultvalue() rt.PhpVal {
	return if !(this.defaultValueStack.array_get(rt.new_int(this.defaultValueStack.array_count() - 1))).is_null() { this.defaultValueStack.array_get(rt.new_int(this.defaultValueStack.array_count() - 1)) } else { rt.new_null() }
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_TypeInfo) getinputtype() rt.PhpVal {
	return if !(this.inputTypeStack.array_get(rt.new_int(this.inputTypeStack.array_count() - 1))).is_null() { this.inputTypeStack.array_get(rt.new_int(this.inputTypeStack.array_count() - 1)) } else { rt.new_null() }
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_TypeInfo) leave(mut var_node Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Node) {
	mut switch_val_2 := rt.get_property(var_node, 'kind')
	if rt.is_true(rt.equal(switch_val_2, Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeKind.selection_set())) {
		rt.call_function('array_pop', [this.parentTypeStack])
	} else if rt.is_true(rt.equal(switch_val_2, Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeKind.field())) {
		rt.call_function('array_pop', [this.fieldDefStack])
		rt.call_function('array_pop', [this.typeStack])
	} else if rt.is_true(rt.equal(switch_val_2, Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeKind.directive())) {
		this.directive = rt.new_null()
	} else if rt.is_true(rt.equal(switch_val_2, Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeKind.operation_definition())) || rt.is_true(rt.equal(switch_val_2, Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeKind.inline_fragment())) || rt.is_true(rt.equal(switch_val_2, Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeKind.fragment_definition())) {
		rt.call_function('array_pop', [this.typeStack])
	} else if rt.is_true(rt.equal(switch_val_2, Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeKind.variable_definition())) {
		rt.call_function('array_pop', [this.inputTypeStack])
	} else if rt.is_true(rt.equal(switch_val_2, Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeKind.argument())) {
		this.argument = rt.new_null()
		rt.call_function('array_pop', [this.defaultValueStack])
		rt.call_function('array_pop', [this.inputTypeStack])
	} else if rt.is_true(rt.equal(switch_val_2, Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeKind.lst())) || rt.is_true(rt.equal(switch_val_2, Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeKind.object_field())) {
		rt.call_function('array_pop', [this.defaultValueStack])
		rt.call_function('array_pop', [this.inputTypeStack])
	} else if rt.is_true(rt.equal(switch_val_2, Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeKind.enum())) {
		this.enumValue = rt.new_null()
	}
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Error_InvariantViolation {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_AST {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Introspection {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_vendor_graphql_utils_typeinfo(arg_0 rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_TypeInfo {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_TypeInfo{
		PhpObjectBase: rt.PhpObjectBase{}
		schema: rt.new_null()
		typeStack: rt.new_array()
		parentTypeStack: rt.new_array()
		inputTypeStack: rt.new_array()
		fieldDefStack: rt.new_array()
		defaultValueStack: rt.new_array()
		directive: rt.new_null()
		argument: rt.new_null()
		enumValue: rt.new_null()
	}
	obj.construct(arg_0)
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_error_invariantviolation(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Error_InvariantViolation {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Error_InvariantViolation{
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

fn create_automattic_woocommerce_vendor_graphql_type_introspection(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Introspection {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Introspection{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_TypeInfo) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema](if args.len > 0 { args[0] } else { rt.new_null() })
			this.construct(mut dispatch_arg_0)
			return rt.new_null()
		}
		'getParentTypeStack' {
			return this.getparenttypestack()
		}
		'getFieldDefStack' {
			return this.getfielddefstack()
		}
		'extractTypes' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array](if args.len > 1 { args[1] } else { rt.new_null() })
			Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_TypeInfo.extracttypes(mut dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'extractTypesFromDirectives' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Directive](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array](if args.len > 1 { args[1] } else { rt.new_null() })
			Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_TypeInfo.extracttypesfromdirectives(mut dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'getParentInputType' {
			return this.getparentinputtype()
		}
		'getArgument' {
			return this.getargument()
		}
		'getEnumValue' {
			return this.getenumvalue()
		}
		'enter' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Node](if args.len > 0 { args[0] } else { rt.new_null() })
			this.enter(mut dispatch_arg_0)
			return rt.new_null()
		}
		'getType' {
			return this.gettype()
		}
		'getParentType' {
			return this.getparenttype()
		}
		'getFieldDefinition' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type](if args.len > 1 { args[1] } else { rt.new_null() })
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_FieldNode](if args.len > 2 { args[2] } else { rt.new_null() })
			return Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_TypeInfo.getfielddefinition(mut dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2)
		}
		'getDirective' {
			return this.getdirective()
		}
		'getFieldDef' {
			return this.getfielddef()
		}
		'getDefaultValue' {
			return this.getdefaultvalue()
		}
		'getInputType' {
			return this.getinputtype()
		}
		'leave' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Node](if args.len > 0 { args[0] } else { rt.new_null() })
			this.leave(mut dispatch_arg_0)
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_TypeInfo) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'schema' { return this.schema }
		'typeStack' { return this.typeStack }
		'parentTypeStack' { return this.parentTypeStack }
		'inputTypeStack' { return this.inputTypeStack }
		'fieldDefStack' { return this.fieldDefStack }
		'defaultValueStack' { return this.defaultValueStack }
		'directive' { return this.directive }
		'argument' { return this.argument }
		'enumValue' { return this.enumValue }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_TypeInfo) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'schema' { this.schema = val; return true }
		'typeStack' { this.typeStack = val; return true }
		'parentTypeStack' { this.parentTypeStack = val; return true }
		'inputTypeStack' { this.inputTypeStack = val; return true }
		'fieldDefStack' { this.fieldDefStack = val; return true }
		'defaultValueStack' { this.defaultValueStack = val; return true }
		'directive' { this.directive = val; return true }
		'argument' { this.argument = val; return true }
		'enumValue' { this.enumValue = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
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


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Introspection) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Introspection) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Introspection) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}



fn main() {
	defer {
		rt.shutdown()
	}

}
