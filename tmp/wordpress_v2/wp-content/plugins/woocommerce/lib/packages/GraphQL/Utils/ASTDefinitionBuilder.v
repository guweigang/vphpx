import rt

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_ASTDefinitionBuilder {
	rt.PhpObjectBase
pub mut:
		typeDefinitionsMap rt.PhpVal = rt.new_null()
		resolveType rt.PhpVal = rt.new_null()
		typeConfigDecorator rt.PhpVal = rt.new_null()
		fieldConfigDecorator rt.PhpVal = rt.new_null()
		cache rt.PhpVal = rt.new_null()
		typeExtensionsMap rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_ASTDefinitionBuilder) construct(mut var_typeDefinitionsMap Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array, mut var_typeExtensionsMap Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array, mut var_resolveType Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_callable, mut var_typeConfigDecorator Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_?callable, mut var_fieldConfigDecorator Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_?callable) {
	this.typeDefinitionsMap = var_typeDefinitionsMap
	this.typeExtensionsMap = var_typeExtensionsMap
	this.resolveType = var_resolveType
	this.typeConfigDecorator = var_typeConfigDecorator
	this.fieldConfigDecorator = var_fieldConfigDecorator
	mut iife_temp_0 := Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type{}
	mut iife_result_0 := iife_temp_0.builtintypes()
	this.cache = iife_result_0
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_ASTDefinitionBuilder) builddirective(mut var_directiveNode Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_DirectiveDefinitionNode) rt.PhpVal {
	mut var_locations := rt.new_array()
	mut iter_1 := rt.get_property(var_directiveNode, 'locations').iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_location := item_1.val
		var_locations.array_push(rt.get_property(var_location, 'value'))
	}
	return rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Directive', []string{}, create_automattic_woocommerce_vendor_graphql_type_definition_directive(rt.create_array([rt.ArrayItem{ key: 'name', val: rt.get_property(rt.get_property(var_directiveNode, 'name'), 'value') }, rt.ArrayItem{ key: 'description', val: if !(rt.get_property(rt.get_property(var_directiveNode, 'description'), 'value')).is_null() { rt.get_property(rt.get_property(var_directiveNode, 'description'), 'value') } else { rt.new_null() } }, rt.ArrayItem{ key: 'args', val: this.makeinputvalues(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeList](rt.get_property(var_directiveNode, 'arguments'))) }, rt.ArrayItem{ key: 'isRepeatable', val: rt.get_property(var_directiveNode, 'repeatable') }, rt.ArrayItem{ key: 'locations', val: var_locations }, rt.ArrayItem{ key: 'astNode', val: var_directiveNode }])))
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_ASTDefinitionBuilder) makeinputvalues(mut var_values Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeList) rt.PhpVal {
	mut var_values_mutated := var_values
	mut var_map := rt.new_array()
	mut iter_2 := var_values_mutated.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_value := item_2.val
		mut var_type := this.buildwrappedtype(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_TypeNode](rt.get_property(var_value, 'type')))
		mut var_config := rt.create_array([rt.ArrayItem{ key: 'name', val: rt.get_property(rt.get_property(var_value, 'name'), 'value') }, rt.ArrayItem{ key: 'type', val: var_type }, rt.ArrayItem{ key: 'description', val: if !(rt.get_property(rt.get_property(var_value, 'description'), 'value')).is_null() { rt.get_property(rt.get_property(var_value, 'description'), 'value') } else { rt.new_null() } }, rt.ArrayItem{ key: 'deprecationReason', val: this.getdeprecationreason(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Node](var_value)) }, rt.ArrayItem{ key: 'astNode', val: var_value }])
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.get_property(var_value, 'defaultValue'), rt.new_null())))) {
			mut iife_temp_1 := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_AST{}
			mut iife_result_1 := iife_temp_1.valuefromast(rt.get_property(var_value, 'defaultValue'), var_type.clone())
			var_config.array_set('defaultValue', iife_result_1)
		}
		var_map.array_set(rt.get_property(rt.get_property(var_value, 'name'), 'value'), var_config.clone())
	}
	return var_map.clone()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_ASTDefinitionBuilder) makeinputfields(mut var_nodes Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array) rt.PhpVal {
	mut var_fields := rt.new_array()
	mut iter_3 := var_nodes.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_node := item_3.val
		var_fields.clone().array_push(rt.get_property(var_node, 'fields'))
	}
	return this.makeinputvalues(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeList](create_automattic_woocommerce_vendor_graphql_language_ast_nodelist(var_fields.clone())))
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_ASTDefinitionBuilder) buildwrappedtype(mut var_typeNode Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_TypeNode) rt.PhpVal {
	if rt.is_true(rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_TypeNode', []string{}, var_typeNode), 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_ListTypeNode'))) {
		mut iife_temp_2 := Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type{}
		mut iife_result_2 := iife_temp_2.listof(this.buildwrappedtype(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_TypeNode](rt.get_property(var_typeNode, 'type'))))
		return iife_result_2
	}
	if rt.is_true(rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_TypeNode', []string{}, var_typeNode), 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NonNullTypeNode'))) {
		mut iife_temp_3 := Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type{}
		mut iife_result_3 := iife_temp_3.nonnull(this.buildwrappedtype(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_TypeNode](rt.get_property(var_typeNode, 'type'))))
		return iife_result_3
	}
	return this.buildtype(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_TypeNode', []string{}, var_typeNode))
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_ASTDefinitionBuilder) buildtype(var_ref rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.new_bool(rt.instance_of(var_ref, 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_TypeDefinitionNode'))) {
		return this.internalbuildtype((rt.get_property(rt.call_method(var_ref, 'getName', []rt.PhpVal{}), 'value')).str(), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_?Node](var_ref))
	}
	if rt.is_true(rt.new_bool(rt.instance_of(var_ref, 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NamedTypeNode'))) {
		return this.internalbuildtype((rt.get_property(rt.get_property(var_ref, 'name'), 'value')).str(), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_?Node](var_ref))
	}
	return this.internalbuildtype((var_ref).str(), rt.new_null())
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_ASTDefinitionBuilder) maybebuildtype(name string) rt.PhpVal {
	mut name_mutated := name
	return if this.typeDefinitionsMap.array_isset(rt.new_string(name_mutated)) { this.buildtype(rt.new_string(name_mutated)) } else { rt.new_null() }
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_ASTDefinitionBuilder) internalbuildtype(typeName string, mut var_typeNode Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_?Node) rt.PhpVal {
	if this.cache.array_isset(rt.new_string(typeName)) {
		return this.cache.array_get(rt.new_string(typeName))
	}
	if this.typeDefinitionsMap.array_isset(rt.new_string(typeName)) {
		mut var_type := this.makeschemadef(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Node](this.typeDefinitionsMap.array_get(rt.new_string(typeName))))
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(this.typeConfigDecorator, rt.new_null())))) {
			mut var_config := rt.call_callable(this.typeConfigDecorator, [rt.get_property(var_type, 'config'), this.typeDefinitionsMap.array_get(rt.new_string(typeName)), this.typeDefinitionsMap])
			if rt.has_exception() { unsafe { goto catch_label_1 } }
			unsafe { goto end_label_1 }

catch_label_1:
			mut var_e_1 := rt.get_and_clear_exception()
			if rt.instance_of(var_e_1, 'Automattic_WooCommerce_Vendor_GraphQL_Utils_Throwable') {
				mut var_e := var_e_1.clone()
				mut var_class := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_static.class()
				rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Error_Error', []string{}, create_automattic_woocommerce_vendor_graphql_error_error(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('Type config decorator passed to '), var_class), rt.new_string(' threw an error when building ')), rt.new_string(typeName)), rt.new_string(' type: ')), rt.call_method(var_e, 'getMessage', []rt.PhpVal{})), rt.new_null(), rt.new_null(), rt.new_array(), rt.new_null(), var_e.clone())))
				unsafe { goto end_label_1 }
			}
			else {
				rt.throw_exception(var_e_1)
				unsafe { goto end_label_1 }
			}

end_label_1:
			if !(var_config.clone().is_array()) || var_config.array_isset(rt.new_int(0)) {
				var_class = Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_static.class()
				mut iife_temp_4 := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils{}
				mut iife_result_4 := iife_temp_4.printsafe(var_config.clone())
				mut var_notArray := iife_result_4
				rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Error_Error', []string{}, create_automattic_woocommerce_vendor_graphql_error_error(rt.new_string("Type config decorator passed to ${var_class.to_string()} is expected to return an array, but got ${var_notArray.to_string()}"))))
			}
		var_type = this.makeschemadeffromconfig(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Node](this.typeDefinitionsMap.array_get(rt.new_string(typeName))), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array](var_config))
		}
		return this.cache.array_set(typeName, var_type.clone())
	}
	return this.cache.array_set(typeName, rt.call_callable(this.resolveType, [rt.new_string(typeName), var_typeNode]))
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_ASTDefinitionBuilder) makeschemadef(mut var_def Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Node) rt.PhpVal {
	mut switch_val_1 := rt.new_bool(true)
	if rt.is_true(rt.equal(switch_val_1, rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Node', []string{}, var_def), 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_ObjectTypeDefinitionNode')))) {
		return this.maketypedef(mut var_def)
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Node', []string{}, var_def), 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_InterfaceTypeDefinitionNode')))) {
		return this.makeinterfacedef(mut var_def)
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Node', []string{}, var_def), 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_EnumTypeDefinitionNode')))) {
		return this.makeenumdef(mut var_def)
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Node', []string{}, var_def), 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_UnionTypeDefinitionNode')))) {
		return this.makeuniondef(mut var_def)
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Node', []string{}, var_def), 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_ScalarTypeDefinitionNode')))) {
		return this.makescalardef(mut var_def)
	} else {
		rt.call_function('assert', [rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Node', []string{}, var_def), 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_InputObjectTypeDefinitionNode')), rt.new_string('all implementations are known')])
		return this.makeinputobjectdef(mut var_def)
	}
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_ASTDefinitionBuilder) maketypedef(mut var_def Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_ObjectTypeDefinitionNode) rt.PhpVal {
	mut var_name := rt.get_property(rt.get_property(var_def, 'name'), 'value')
	mut var_extensionASTNodes := if !(this.typeExtensionsMap.array_get(var_name)).is_null() { this.typeExtensionsMap.array_get(var_name) } else { rt.new_array() }
	mut var_allNodes := rt.create_array([rt.ArrayItem{ key: none, val: var_def }, rt.ArrayItem{ key: none, val: var_extensionASTNodes }])
	closure_6_fn := fn [var_allNodes] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		return this.makefielddefmap(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array](var_allNodes))
		}
	closure_7_fn := fn [var_allNodes] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		return this.makeimplementedinterfaces(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array](var_allNodes))
		}
	return rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ObjectType', []string{}, create_automattic_woocommerce_vendor_graphql_type_definition_objecttype(rt.create_array([rt.ArrayItem{ key: 'name', val: var_name }, rt.ArrayItem{ key: 'description', val: if !(rt.get_property(rt.get_property(var_def, 'description'), 'value')).is_null() { rt.get_property(rt.get_property(var_def, 'description'), 'value') } else { rt.new_null() } }, rt.ArrayItem{ key: 'fields', val: rt.new_closure(closure_6_fn) }, rt.ArrayItem{ key: 'interfaces', val: rt.new_closure(closure_7_fn) }, rt.ArrayItem{ key: 'astNode', val: var_def }, rt.ArrayItem{ key: 'extensionASTNodes', val: var_extensionASTNodes }])))
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_ASTDefinitionBuilder) makefielddefmap(mut var_nodes Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array) rt.PhpVal {
	mut var_map := rt.new_array()
	mut iter_4 := var_nodes.iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_node := item_4.val
		mut iter_5 := rt.get_property(var_node, 'fields').iterator()
		for {
			item_5 := iter_5.next() or { break }
			mut var_field := item_5.val
			var_map.array_set(rt.get_property(rt.get_property(var_field, 'name'), 'value'), this.buildfield(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_FieldDefinitionNode](var_field), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_object](var_node)))
		}
	}
	return var_map.clone()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_ASTDefinitionBuilder) buildfield(mut var_field Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_FieldDefinitionNode, mut var_node Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_object) rt.PhpVal {
	mut var_type := this.buildwrappedtype(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_TypeNode](rt.get_property(var_field, 'type')))
	mut var_config := rt.create_array([rt.ArrayItem{ key: 'type', val: var_type }, rt.ArrayItem{ key: 'description', val: if !(rt.get_property(rt.get_property(var_field, 'description'), 'value')).is_null() { rt.get_property(rt.get_property(var_field, 'description'), 'value') } else { rt.new_null() } }, rt.ArrayItem{ key: 'args', val: this.makeinputvalues(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeList](rt.get_property(var_field, 'arguments'))) }, rt.ArrayItem{ key: 'deprecationReason', val: this.getdeprecationreason(mut var_field) }, rt.ArrayItem{ key: 'astNode', val: var_field }])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(this.fieldConfigDecorator, rt.new_null())))) {
	var_config = rt.call_callable(this.fieldConfigDecorator, [var_config.clone(), var_field, var_node])
	}
	return var_config.clone()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_ASTDefinitionBuilder) getdeprecationreason(mut var_node Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Node) string {
	mut iife_temp_7 := Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Directive{}
	mut iife_result_7 := iife_temp_7.deprecateddirective()
	mut iife_temp_8 := Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Values{}
	mut iife_result_8 := iife_temp_8.getdirectivevalues(iife_result_7, rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Node', []string{}, var_node))
	mut var_deprecated := iife_result_8
	return (if !(var_deprecated.array_get(rt.new_string('reason'))).is_null() { var_deprecated.array_get(rt.new_string('reason')) } else { rt.new_null() }).str()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_ASTDefinitionBuilder) makeimplementedinterfaces(mut var_nodes Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array) rt.PhpVal {
	mut var_interfaces := rt.new_array()
	mut iter_6 := var_nodes.iterator()
	for {
		item_6 := iter_6.next() or { break }
		mut var_node := item_6.val
		mut iter_7 := rt.get_property(var_node, 'interfaces').iterator()
		for {
			item_7 := iter_7.next() or { break }
			mut var_interface := item_7.val
			var_interfaces.array_push(this.buildtype(var_interface.clone()))
		}
	}
	return var_interfaces.clone()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_ASTDefinitionBuilder) makeinterfacedef(mut var_def Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_InterfaceTypeDefinitionNode) rt.PhpVal {
	mut var_name := rt.get_property(rt.get_property(var_def, 'name'), 'value')
	mut var_extensionASTNodes := if !(this.typeExtensionsMap.array_get(var_name)).is_null() { this.typeExtensionsMap.array_get(var_name) } else { rt.new_array() }
	mut var_allNodes := rt.create_array([rt.ArrayItem{ key: none, val: var_def }, rt.ArrayItem{ key: none, val: var_extensionASTNodes }])
	closure_10_fn := fn [var_allNodes] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		return this.makefielddefmap(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array](var_allNodes))
		}
	closure_11_fn := fn [var_allNodes] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		return this.makeimplementedinterfaces(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array](var_allNodes))
		}
	return rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InterfaceType', []string{}, create_automattic_woocommerce_vendor_graphql_type_definition_interfacetype(rt.create_array([rt.ArrayItem{ key: 'name', val: var_name }, rt.ArrayItem{ key: 'description', val: if !(rt.get_property(rt.get_property(var_def, 'description'), 'value')).is_null() { rt.get_property(rt.get_property(var_def, 'description'), 'value') } else { rt.new_null() } }, rt.ArrayItem{ key: 'fields', val: rt.new_closure(closure_10_fn) }, rt.ArrayItem{ key: 'interfaces', val: rt.new_closure(closure_11_fn) }, rt.ArrayItem{ key: 'astNode', val: var_def }, rt.ArrayItem{ key: 'extensionASTNodes', val: var_extensionASTNodes }])))
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_ASTDefinitionBuilder) makeenumdef(mut var_def Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_EnumTypeDefinitionNode) rt.PhpVal {
	mut var_name := rt.get_property(rt.get_property(var_def, 'name'), 'value')
	mut var_extensionASTNodes := if !(this.typeExtensionsMap.array_get(var_name)).is_null() { this.typeExtensionsMap.array_get(var_name) } else { rt.new_array() }
	mut var_values := rt.new_array()
	mut iter_8 := rt.create_array([rt.ArrayItem{ key: none, val: var_def }, rt.ArrayItem{ key: none, val: var_extensionASTNodes }]).iterator()
	for {
		item_8 := iter_8.next() or { break }
		mut var_node := item_8.val
		mut iter_9 := rt.get_property(var_node, 'values').iterator()
		for {
			item_9 := iter_9.next() or { break }
			mut var_value := item_9.val
			var_values.array_set(rt.get_property(rt.get_property(var_value, 'name'), 'value'), rt.create_array([rt.ArrayItem{ key: 'description', val: if !(rt.get_property(rt.get_property(var_value, 'description'), 'value')).is_null() { rt.get_property(rt.get_property(var_value, 'description'), 'value') } else { rt.new_null() } }, rt.ArrayItem{ key: 'deprecationReason', val: this.getdeprecationreason(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Node](var_value)) }, rt.ArrayItem{ key: 'astNode', val: var_value }]))
		}
	}
	return rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_EnumType', []string{}, create_automattic_woocommerce_vendor_graphql_type_definition_enumtype(rt.create_array([rt.ArrayItem{ key: 'name', val: var_name }, rt.ArrayItem{ key: 'description', val: if !(rt.get_property(rt.get_property(var_def, 'description'), 'value')).is_null() { rt.get_property(rt.get_property(var_def, 'description'), 'value') } else { rt.new_null() } }, rt.ArrayItem{ key: 'values', val: var_values }, rt.ArrayItem{ key: 'astNode', val: var_def }, rt.ArrayItem{ key: 'extensionASTNodes', val: var_extensionASTNodes }])))
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_ASTDefinitionBuilder) makeuniondef(mut var_def Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_UnionTypeDefinitionNode) rt.PhpVal {
	mut var_name := rt.get_property(rt.get_property(var_def, 'name'), 'value')
	mut var_extensionASTNodes := if !(this.typeExtensionsMap.array_get(var_name)).is_null() { this.typeExtensionsMap.array_get(var_name) } else { rt.new_array() }
	closure_12_fn := fn [var_def, var_extensionASTNodes] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_types := rt.new_array()
		mut iter_10 := rt.create_array([rt.ArrayItem{ key: none, val: var_def }, rt.ArrayItem{ key: none, val: var_extensionASTNodes }]).iterator()
		for {
			item_10 := iter_10.next() or { break }
			mut var_node := item_10.val
			mut iter_11 := rt.get_property(var_node, 'types').iterator()
			for {
				item_11 := iter_11.next() or { break }
				mut var_type := item_11.val
				var_types.array_push(this.buildtype(var_type.clone()))
			}
		}
		return var_types.clone()
		}
	return rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_UnionType', []string{}, create_automattic_woocommerce_vendor_graphql_type_definition_uniontype(rt.create_array([rt.ArrayItem{ key: 'name', val: var_name }, rt.ArrayItem{ key: 'description', val: if !(rt.get_property(rt.get_property(var_def, 'description'), 'value')).is_null() { rt.get_property(rt.get_property(var_def, 'description'), 'value') } else { rt.new_null() } }, rt.ArrayItem{ key: 'types', val: rt.new_closure(closure_12_fn) }, rt.ArrayItem{ key: 'astNode', val: var_def }, rt.ArrayItem{ key: 'extensionASTNodes', val: var_extensionASTNodes }])))
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_ASTDefinitionBuilder) makescalardef(mut var_def Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_ScalarTypeDefinitionNode) rt.PhpVal {
	mut var_value := rt.new_null()
	mut var_name := rt.get_property(rt.get_property(var_def, 'name'), 'value')
	mut var_extensionASTNodes := if !(this.typeExtensionsMap.array_get(var_name)).is_null() { this.typeExtensionsMap.array_get(var_name) } else { rt.new_array() }
	closure_13_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_value := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return var_value
		}
	return rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_CustomScalarType', []string{}, create_automattic_woocommerce_vendor_graphql_type_definition_customscalartype(rt.create_array([rt.ArrayItem{ key: 'name', val: var_name }, rt.ArrayItem{ key: 'description', val: if !(rt.get_property(rt.get_property(var_def, 'description'), 'value')).is_null() { rt.get_property(rt.get_property(var_def, 'description'), 'value') } else { rt.new_null() } }, rt.ArrayItem{ key: 'serialize', val: rt.new_closure(closure_13_fn) }, rt.ArrayItem{ key: 'astNode', val: var_def }, rt.ArrayItem{ key: 'extensionASTNodes', val: var_extensionASTNodes }])))
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_ASTDefinitionBuilder) makeinputobjectdef(mut var_def Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_InputObjectTypeDefinitionNode) rt.PhpVal {
	mut var_name := rt.get_property(rt.get_property(var_def, 'name'), 'value')
	mut var_extensionASTNodes := if !(this.typeExtensionsMap.array_get(var_name)).is_null() { this.typeExtensionsMap.array_get(var_name) } else { rt.new_array() }
	mut iife_temp_13 := Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Directive{}
	mut iife_result_13 := iife_temp_13.oneofdirective()
	mut var_oneOfDirective := iife_result_13
	mut iife_temp_14 := Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Values{}
	mut iife_result_14 := iife_temp_14.getdirectivevalues(var_oneOfDirective.clone(), rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_InputObjectTypeDefinitionNode', []string{}, var_def))
	mut var_isOneOf := rt.new_bool(!rt.is_true(rt.identical(iife_result_14, rt.new_null())))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_isOneOf)))) {
		mut iter_12 := var_extensionASTNodes.iterator()
		for {
			item_12 := iter_12.next() or { break }
			mut var_extensionNode := item_12.val
			mut iife_temp_15 := Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Values{}
			mut iife_result_15 := iife_temp_15.getdirectivevalues(var_oneOfDirective.clone(), var_extensionNode.clone())
			if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(iife_result_15, rt.new_null())))) {
				var_isOneOf = rt.new_bool(true)
				break
			}
		}
	}
	closure_17_fn := fn [var_def, var_extensionASTNodes] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		return this.makeinputfields(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array](rt.create_array([rt.ArrayItem{ key: none, val: var_def }, rt.ArrayItem{ key: none, val: var_extensionASTNodes }])))
		}
	return rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InputObjectType', []string{}, create_automattic_woocommerce_vendor_graphql_type_definition_inputobjecttype(rt.create_array([rt.ArrayItem{ key: 'name', val: var_name }, rt.ArrayItem{ key: 'description', val: if !(rt.get_property(rt.get_property(var_def, 'description'), 'value')).is_null() { rt.get_property(rt.get_property(var_def, 'description'), 'value') } else { rt.new_null() } }, rt.ArrayItem{ key: 'isOneOf', val: var_isOneOf }, rt.ArrayItem{ key: 'fields', val: rt.new_closure(closure_17_fn) }, rt.ArrayItem{ key: 'astNode', val: var_def }, rt.ArrayItem{ key: 'extensionASTNodes', val: var_extensionASTNodes }])))
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_ASTDefinitionBuilder) makeschemadeffromconfig(mut var_def Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Node, mut var_config Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array) rt.PhpVal {
	mut var_config_mutated := var_config
	mut switch_val_2 := rt.new_bool(true)
	if rt.is_true(rt.equal(switch_val_2, rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Node', []string{}, var_def), 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_ObjectTypeDefinitionNode')))) {
		return rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ObjectType', []string{}, create_automattic_woocommerce_vendor_graphql_type_definition_objecttype(var_config_mutated))
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Node', []string{}, var_def), 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_InterfaceTypeDefinitionNode')))) {
		return rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InterfaceType', []string{}, create_automattic_woocommerce_vendor_graphql_type_definition_interfacetype(var_config_mutated))
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Node', []string{}, var_def), 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_EnumTypeDefinitionNode')))) {
		return rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_EnumType', []string{}, create_automattic_woocommerce_vendor_graphql_type_definition_enumtype(var_config_mutated))
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Node', []string{}, var_def), 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_UnionTypeDefinitionNode')))) {
		return rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_UnionType', []string{}, create_automattic_woocommerce_vendor_graphql_type_definition_uniontype(var_config_mutated))
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Node', []string{}, var_def), 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_ScalarTypeDefinitionNode')))) {
		return rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_CustomScalarType', []string{}, create_automattic_woocommerce_vendor_graphql_type_definition_customscalartype(var_config_mutated))
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Node', []string{}, var_def), 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_InputObjectTypeDefinitionNode')))) {
		return rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InputObjectType', []string{}, create_automattic_woocommerce_vendor_graphql_type_definition_inputobjecttype(var_config_mutated))
	} else {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Error_Error', []string{}, create_automattic_woocommerce_vendor_graphql_error_error(rt.concat(rt.concat(rt.new_string('Type kind of '), rt.get_property(var_def, 'kind')), rt.new_string(' not supported.')))))
	}
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_ASTDefinitionBuilder) buildinputfield(mut var_value Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_InputValueDefinitionNode) rt.PhpVal {
	mut var_type := this.buildwrappedtype(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_TypeNode](rt.get_property(var_value, 'type')))
	rt.call_function('assert', [rt.new_bool(rt.instance_of(var_type, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InputType')), rt.new_string('proven by schema validation')])
	mut var_config := rt.create_array([rt.ArrayItem{ key: 'name', val: rt.get_property(rt.get_property(var_value, 'name'), 'value') }, rt.ArrayItem{ key: 'type', val: var_type }, rt.ArrayItem{ key: 'description', val: if !(rt.get_property(rt.get_property(var_value, 'description'), 'value')).is_null() { rt.get_property(rt.get_property(var_value, 'description'), 'value') } else { rt.new_null() } }, rt.ArrayItem{ key: 'astNode', val: var_value }])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.get_property(var_value, 'defaultValue'), rt.new_null())))) {
		mut iife_temp_17 := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_AST{}
		mut iife_result_17 := iife_temp_17.valuefromast(rt.get_property(var_value, 'defaultValue'), var_type.clone())
		var_config.array_set('defaultValue', iife_result_17)
	}
	return var_config.clone()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_ASTDefinitionBuilder) buildenumvalue(mut var_value Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_EnumValueDefinitionNode) rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: 'description', val: if !(rt.get_property(rt.get_property(var_value, 'description'), 'value')).is_null() { rt.get_property(rt.get_property(var_value, 'description'), 'value') } else { rt.new_null() } }, rt.ArrayItem{ key: 'deprecationReason', val: this.getdeprecationreason(mut var_value) }, rt.ArrayItem{ key: 'astNode', val: var_value }])
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Directive {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_AST {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeList {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Error {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ObjectType {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Values {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InterfaceType {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_EnumType {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_UnionType {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_CustomScalarType {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InputObjectType {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_vendor_graphql_utils_astdefinitionbuilder(arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal, arg_3 rt.PhpVal, arg_4 rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_ASTDefinitionBuilder {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_ASTDefinitionBuilder{
		PhpObjectBase: rt.PhpObjectBase{}
		typeDefinitionsMap: rt.new_null()
		resolveType: rt.new_null()
		typeConfigDecorator: rt.new_null()
		fieldConfigDecorator: rt.new_null()
		cache: rt.new_null()
		typeExtensionsMap: rt.new_null()
	}
	obj.construct(arg_0, arg_1, arg_2, arg_3, arg_4)
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_type_definition_type(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_type_definition_directive(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Directive {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Directive{
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

fn create_automattic_woocommerce_vendor_graphql_language_ast_nodelist(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeList {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeList{
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

fn create_automattic_woocommerce_vendor_graphql_type_definition_objecttype(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ObjectType {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ObjectType{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_executor_values(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Values {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Values{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_type_definition_interfacetype(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InterfaceType {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InterfaceType{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_type_definition_enumtype(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_EnumType {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_EnumType{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_type_definition_uniontype(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_UnionType {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_UnionType{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_type_definition_customscalartype(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_CustomScalarType {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_CustomScalarType{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_type_definition_inputobjecttype(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InputObjectType {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InputObjectType{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_ASTDefinitionBuilder) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array](if args.len > 1 { args[1] } else { rt.new_null() })
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_callable](if args.len > 2 { args[2] } else { rt.new_null() })
			mut dispatch_arg_3 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_?callable](if args.len > 3 { args[3] } else { rt.new_null() })
			mut dispatch_arg_4 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_?callable](if args.len > 4 { args[4] } else { rt.new_null() })
			this.construct(mut dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2, mut dispatch_arg_3, mut dispatch_arg_4)
			return rt.new_null()
		}
		'buildDirective' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_DirectiveDefinitionNode](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.builddirective(mut dispatch_arg_0)
		}
		'makeInputValues' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeList](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.makeinputvalues(mut dispatch_arg_0)
		}
		'makeInputFields' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.makeinputfields(mut dispatch_arg_0)
		}
		'buildWrappedType' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_TypeNode](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.buildwrappedtype(mut dispatch_arg_0)
		}
		'buildType' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.buildtype(dispatch_arg_0)
		}
		'maybeBuildType' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.maybebuildtype(dispatch_arg_0)
		}
		'internalBuildType' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_?Node](if args.len > 1 { args[1] } else { rt.new_null() })
			return this.internalbuildtype(dispatch_arg_0, mut dispatch_arg_1)
		}
		'makeSchemaDef' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Node](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.makeschemadef(mut dispatch_arg_0)
		}
		'makeTypeDef' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_ObjectTypeDefinitionNode](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.maketypedef(mut dispatch_arg_0)
		}
		'makeFieldDefMap' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.makefielddefmap(mut dispatch_arg_0)
		}
		'buildField' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_FieldDefinitionNode](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_object](if args.len > 1 { args[1] } else { rt.new_null() })
			return this.buildfield(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		'getDeprecationReason' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Node](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_string(this.getdeprecationreason(mut dispatch_arg_0))
		}
		'makeImplementedInterfaces' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.makeimplementedinterfaces(mut dispatch_arg_0)
		}
		'makeInterfaceDef' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_InterfaceTypeDefinitionNode](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.makeinterfacedef(mut dispatch_arg_0)
		}
		'makeEnumDef' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_EnumTypeDefinitionNode](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.makeenumdef(mut dispatch_arg_0)
		}
		'makeUnionDef' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_UnionTypeDefinitionNode](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.makeuniondef(mut dispatch_arg_0)
		}
		'makeScalarDef' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_ScalarTypeDefinitionNode](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.makescalardef(mut dispatch_arg_0)
		}
		'makeInputObjectDef' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_InputObjectTypeDefinitionNode](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.makeinputobjectdef(mut dispatch_arg_0)
		}
		'makeSchemaDefFromConfig' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Node](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array](if args.len > 1 { args[1] } else { rt.new_null() })
			return this.makeschemadeffromconfig(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		'buildInputField' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_InputValueDefinitionNode](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.buildinputfield(mut dispatch_arg_0)
		}
		'buildEnumValue' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_EnumValueDefinitionNode](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.buildenumvalue(mut dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_ASTDefinitionBuilder) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'typeDefinitionsMap' { return this.typeDefinitionsMap }
		'resolveType' { return this.resolveType }
		'typeConfigDecorator' { return this.typeConfigDecorator }
		'fieldConfigDecorator' { return this.fieldConfigDecorator }
		'cache' { return this.cache }
		'typeExtensionsMap' { return this.typeExtensionsMap }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_ASTDefinitionBuilder) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'typeDefinitionsMap' { this.typeDefinitionsMap = val; return true }
		'resolveType' { this.resolveType = val; return true }
		'typeConfigDecorator' { this.typeConfigDecorator = val; return true }
		'fieldConfigDecorator' { this.fieldConfigDecorator = val; return true }
		'cache' { this.cache = val; return true }
		'typeExtensionsMap' { this.typeExtensionsMap = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
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


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Directive) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Directive) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Directive) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeList) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeList) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeList) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ObjectType) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ObjectType) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ObjectType) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Values) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Values) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Values) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InterfaceType) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InterfaceType) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InterfaceType) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_EnumType) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_EnumType) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_EnumType) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_UnionType) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_UnionType) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_UnionType) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_CustomScalarType) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_CustomScalarType) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_CustomScalarType) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InputObjectType) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InputObjectType) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InputObjectType) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn init_registry() {
}

fn init() {
	init_registry()
}


fn main() {
	defer {
		rt.shutdown()
	}

}
