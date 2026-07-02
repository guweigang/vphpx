import rt

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaExtender {
	rt.PhpObjectBase
pub mut:
		extendTypeCache rt.PhpVal = rt.new_array()
		typeExtensionsMap rt.PhpVal = rt.new_array()
		astBuilder rt.PhpVal = rt.new_null()
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaExtender.extend(mut var_schema Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema, mut var_documentAST Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_DocumentNode, mut var_options Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array, mut var_typeConfigDecorator Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_?callable, mut var_fieldConfigDecorator Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_?callable) rt.PhpVal {
	return rt.call_method(create_automattic_woocommerce_vendor_graphql_utils_static(), 'doExtend', [var_schema, var_documentAST, var_options, var_typeConfigDecorator, var_fieldConfigDecorator])
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaExtender) doextend(mut var_schema Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema, mut var_documentAST Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_DocumentNode, mut var_options Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array, mut var_typeConfigDecorator Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_?callable, mut var_fieldConfigDecorator Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_?callable) rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(if !(var_options.array_get(rt.new_string('assumeValid'))).is_null() { var_options.array_get(rt.new_string('assumeValid')) } else { rt.new_bool(false) })))) && rt.is_true(rt.new_bool(!(rt.is_true(if !(var_options.array_get(rt.new_string('assumeValidSDL'))).is_null() { var_options.array_get(rt.new_string('assumeValidSDL')) } else { rt.new_bool(false) })))) {
	mut iife_temp_0 := Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_DocumentValidator{}
	mut iife_result_0 := iife_temp_0.assertvalidsdlextension(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_DocumentNode', []string{}, var_documentAST), rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Schema', []string{}, var_schema))
	}
	mut var_typeDefinitionMap := rt.new_array()
	mut var_directiveDefinitions := rt.new_array()
	mut var_schemaDef := rt.new_null()
	mut var_schemaExtensions := rt.new_array()
	mut iter_1 := rt.get_property(var_documentAST, 'definitions').iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_def := item_1.val
		if rt.is_true(rt.new_bool(rt.instance_of(var_def, 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_SchemaDefinitionNode'))) {
		var_schemaDef = var_def.clone()
		} else if rt.is_true(rt.new_bool(rt.instance_of(var_def, 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_SchemaExtensionNode'))) {
			var_schemaExtensions.array_push(var_def.clone())
		} else if rt.is_true(rt.new_bool(rt.instance_of(var_def, 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_TypeDefinitionNode'))) {
			mut var_name := rt.get_property(rt.call_method(var_def, 'getName', []rt.PhpVal{}), 'value')
			var_typeDefinitionMap.array_set(var_name, var_def.clone())
		} else if rt.is_true(rt.new_bool(rt.instance_of(var_def, 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_TypeExtensionNode'))) {
			var_name = rt.get_property(rt.call_method(var_def, 'getName', []rt.PhpVal{}), 'value')
			this.typeExtensionsMap.array_get_mut(var_name).array_push(var_def.clone())
		} else if rt.is_true(rt.new_bool(rt.instance_of(var_def, 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_DirectiveDefinitionNode'))) {
			var_directiveDefinitions.array_push(var_def.clone())
		}
	}
	if rt.is_true(rt.identical(this.typeExtensionsMap, rt.new_array())) && rt.is_true(rt.identical(var_typeDefinitionMap, rt.new_array())) && rt.is_true(rt.identical(var_directiveDefinitions, rt.new_array())) && rt.is_true(rt.identical(var_schemaExtensions, rt.new_array())) && rt.is_true(rt.identical(var_schemaDef, rt.new_null())) {
		return rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Schema', []string{}, var_schema)
	}
	closure_2_fn := fn [var_schema] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_typeName := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_existingType := var_schema.gettype(var_typeName.clone())
		if rt.is_true(rt.identical(var_existingType, rt.new_null())) {
			rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Error_InvariantViolation', []string{}, create_automattic_woocommerce_vendor_graphql_error_invariantviolation(rt.new_string("Unknown type: \"${var_typeName.to_string()}\"."))))
		}
		return this.extendnamedtype(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type](var_existingType))
		}
	this.astBuilder = create_automattic_woocommerce_vendor_graphql_utils_astdefinitionbuilder(var_typeDefinitionMap.clone(), rt.new_array(), rt.new_closure(closure_2_fn), var_typeConfigDecorator, var_fieldConfigDecorator)
	this.extendTypeCache = rt.new_array()
	mut var_types := rt.new_array()
	mut iter_2 := var_schema.gettypemap().iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_type := item_2.val
		var_types.array_push(this.extendnamedtype(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type](var_type)))
	}
	mut iter_3 := var_typeDefinitionMap.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_type := item_3.val
		var_types.array_push(rt.call_method(this.astBuilder, 'buildType', [var_type.clone()]))
	}
	mut var_operationTypes := rt.create_array([rt.ArrayItem{ key: 'query', val: this.extendmaybenamedtype(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_?Type](var_schema.getquerytype())) }, rt.ArrayItem{ key: 'mutation', val: this.extendmaybenamedtype(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_?Type](var_schema.getmutationtype())) }, rt.ArrayItem{ key: 'subscription', val: this.extendmaybenamedtype(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_?Type](var_schema.getsubscriptiontype())) }])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_schemaDef, rt.new_null())))) {
		mut iter_4 := rt.get_property(var_schemaDef, 'operationTypes').iterator()
		for {
			item_4 := iter_4.next() or { break }
			mut var_operationType := item_4.val
			var_operationTypes.array_set(rt.get_property(var_operationType, 'operation'), rt.call_method(this.astBuilder, 'buildType', [rt.get_property(var_operationType, 'type')]))
		}
	}
	mut iter_5 := var_schemaExtensions.iterator()
	for {
		item_5 := iter_5.next() or { break }
		mut var_schemaExtension := item_5.val
		mut iter_6 := rt.get_property(var_schemaExtension, 'operationTypes').iterator()
		for {
			item_6 := iter_6.next() or { break }
			mut var_operationType := item_6.val
			var_operationTypes.array_set(rt.get_property(var_operationType, 'operation'), rt.call_method(this.astBuilder, 'buildType', [rt.get_property(var_operationType, 'type')]))
		}
	}
	mut var_schemaConfig := rt.call_method(rt.call_method(rt.call_method(rt.call_method(rt.call_method(rt.call_method(rt.call_method(rt.call_method(create_automattic_woocommerce_vendor_graphql_type_schemaconfig(), 'setDescription', [if !(rt.get_property(rt.get_property(var_schemaDef, 'description'), 'value')).is_null() { rt.get_property(rt.get_property(var_schemaDef, 'description'), 'value') } else { if !(rt.get_property(var_schema, 'description')).is_null() { rt.get_property(var_schema, 'description') } else { rt.new_null() } }]), 'setQuery', [var_operationTypes.array_get(rt.new_string('query'))]), 'setMutation', [var_operationTypes.array_get(rt.new_string('mutation'))]), 'setSubscription', [var_operationTypes.array_get(rt.new_string('subscription'))]), 'setTypes', [var_types.clone()]), 'setDirectives', [this.getmergeddirectives(mut var_schema, mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array](var_directiveDefinitions))]), 'setAstNode', [if !(rt.get_property(var_schema, 'astNode')).is_null() { rt.get_property(var_schema, 'astNode') } else { var_schemaDef }]), 'setExtensionASTNodes', [rt.create_array([rt.ArrayItem{ key: none, val: rt.get_property(var_schema, 'extensionASTNodes') }, rt.ArrayItem{ key: none, val: var_schemaExtensions }])])
	return rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Schema', []string{}, create_automattic_woocommerce_vendor_graphql_type_schema(var_schemaConfig.clone()))
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaExtender) extensionastnodes(mut var_type Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_NamedType) rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: none, val: if !(rt.get_property(var_type, 'extensionASTNodes')).is_null() { rt.get_property(var_type, 'extensionASTNodes') } else { rt.new_array() } }, rt.ArrayItem{ key: none, val: if !(this.typeExtensionsMap.array_get(rt.get_property(var_type, 'name'))).is_null() { this.typeExtensionsMap.array_get(rt.get_property(var_type, 'name')) } else { rt.new_array() } }])
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaExtender) extendscalartype(mut var_type Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ScalarType) rt.PhpVal {
	mut var_extensionASTNodes := this.extensionastnodes(mut var_type)
	return rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_CustomScalarType', []string{}, create_automattic_woocommerce_vendor_graphql_type_definition_customscalartype(rt.create_array([rt.ArrayItem{ key: 'name', val: rt.get_property(var_type, 'name') }, rt.ArrayItem{ key: 'description', val: rt.get_property(var_type, 'description') }, rt.ArrayItem{ key: 'serialize', val: rt.create_array([rt.ArrayItem{ key: none, val: var_type }, rt.ArrayItem{ key: none, val: 'serialize' }]) }, rt.ArrayItem{ key: 'parseValue', val: rt.create_array([rt.ArrayItem{ key: none, val: var_type }, rt.ArrayItem{ key: none, val: 'parseValue' }]) }, rt.ArrayItem{ key: 'parseLiteral', val: rt.create_array([rt.ArrayItem{ key: none, val: var_type }, rt.ArrayItem{ key: none, val: 'parseLiteral' }]) }, rt.ArrayItem{ key: 'astNode', val: rt.get_property(var_type, 'astNode') }, rt.ArrayItem{ key: 'extensionASTNodes', val: var_extensionASTNodes }])))
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaExtender) extenduniontype(mut var_type Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_UnionType) rt.PhpVal {
	mut var_extensionASTNodes := this.extensionastnodes(mut var_type)
	closure_3_fn := fn [var_type] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		return this.extendunionpossibletypes(mut rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_UnionType', []string{}, var_type))
		}
	return rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_UnionType', []string{}, create_automattic_woocommerce_vendor_graphql_type_definition_uniontype(rt.create_array([rt.ArrayItem{ key: 'name', val: rt.get_property(var_type, 'name') }, rt.ArrayItem{ key: 'description', val: rt.get_property(var_type, 'description') }, rt.ArrayItem{ key: 'types', val: rt.new_closure(closure_3_fn) }, rt.ArrayItem{ key: 'resolveType', val: rt.create_array([rt.ArrayItem{ key: none, val: var_type }, rt.ArrayItem{ key: none, val: 'resolveType' }]) }, rt.ArrayItem{ key: 'astNode', val: rt.get_property(var_type, 'astNode') }, rt.ArrayItem{ key: 'extensionASTNodes', val: var_extensionASTNodes }])))
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaExtender) extendenumtype(mut var_type Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_EnumType) rt.PhpVal {
	mut var_extensionASTNodes := this.extensionastnodes(mut var_type)
	return rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_EnumType', []string{}, create_automattic_woocommerce_vendor_graphql_type_definition_enumtype(rt.create_array([rt.ArrayItem{ key: 'name', val: rt.get_property(var_type, 'name') }, rt.ArrayItem{ key: 'description', val: rt.get_property(var_type, 'description') }, rt.ArrayItem{ key: 'values', val: this.extendenumvaluemap(mut var_type) }, rt.ArrayItem{ key: 'astNode', val: rt.get_property(var_type, 'astNode') }, rt.ArrayItem{ key: 'extensionASTNodes', val: var_extensionASTNodes }])))
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaExtender) extendinputobjecttype(mut var_type Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InputObjectType) rt.PhpVal {
	mut var_extensionASTNodes := this.extensionastnodes(mut var_type)
	closure_4_fn := fn [var_type] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		return this.extendinputfieldmap(mut rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InputObjectType', []string{}, var_type))
		}
	return rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InputObjectType', []string{}, create_automattic_woocommerce_vendor_graphql_type_definition_inputobjecttype(rt.create_array([rt.ArrayItem{ key: 'name', val: rt.get_property(var_type, 'name') }, rt.ArrayItem{ key: 'description', val: rt.get_property(var_type, 'description') }, rt.ArrayItem{ key: 'fields', val: rt.new_closure(closure_4_fn) }, rt.ArrayItem{ key: 'parseValue', val: rt.create_array([rt.ArrayItem{ key: none, val: var_type }, rt.ArrayItem{ key: none, val: 'parseValue' }]) }, rt.ArrayItem{ key: 'astNode', val: rt.get_property(var_type, 'astNode') }, rt.ArrayItem{ key: 'extensionASTNodes', val: var_extensionASTNodes }, rt.ArrayItem{ key: 'isOneOf', val: rt.get_property(var_type, 'isOneOf') }])))
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaExtender) extendinputfieldmap(mut var_type Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InputObjectType) rt.PhpVal {
	mut var_newFieldMap := rt.new_array()
	mut var_oldFieldMap := var_type.getfields()
	mut iter_7 := var_oldFieldMap.iterator()
	for {
		item_7 := iter_7.next() or { break }
		mut var_field := item_7.val
		mut var_fieldName := item_7.key
		mut var_extendedType := this.extendtype(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type](rt.call_method(var_field, 'getType', []rt.PhpVal{})))
		mut var_newFieldConfig := rt.create_array([rt.ArrayItem{ key: 'description', val: rt.get_property(var_field, 'description') }, rt.ArrayItem{ key: 'type', val: var_extendedType }, rt.ArrayItem{ key: 'deprecationReason', val: rt.get_property(var_field, 'deprecationReason') }, rt.ArrayItem{ key: 'astNode', val: rt.get_property(var_field, 'astNode') }])
		if rt.is_true(rt.call_method(var_field, 'defaultValueExists', []rt.PhpVal{})) {
			var_newFieldConfig.array_set('defaultValue', rt.get_property(var_field, 'defaultValue'))
		}
		var_newFieldMap.array_set(var_fieldName, var_newFieldConfig.clone())
	}
	if this.typeExtensionsMap.array_isset(rt.get_property(var_type, 'name')) {
		mut iter_8 := this.typeExtensionsMap.array_get(rt.get_property(var_type, 'name')).iterator()
		for {
			item_8 := iter_8.next() or { break }
			mut var_extension := item_8.val
			rt.call_function('assert', [rt.new_bool(rt.instance_of(var_extension, 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_InputObjectTypeExtensionNode')), rt.new_string('proven by schema validation')])
			mut iter_9 := rt.get_property(var_extension, 'fields').iterator()
			for {
				item_9 := iter_9.next() or { break }
				mut var_field := item_9.val
				var_newFieldMap.array_set(rt.get_property(rt.get_property(var_field, 'name'), 'value'), rt.call_method(this.astBuilder, 'buildInputField', [var_field.clone()]))
			}
		}
	}
	return var_newFieldMap.clone()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaExtender) extendenumvaluemap(mut var_type Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_EnumType) rt.PhpVal {
	mut var_newValueMap := rt.new_array()
	mut iter_10 := var_type.getvalues().iterator()
	for {
		item_10 := iter_10.next() or { break }
		mut var_value := item_10.val
		var_newValueMap.array_set(rt.get_property(var_value, 'name'), rt.create_array([rt.ArrayItem{ key: 'name', val: rt.get_property(var_value, 'name') }, rt.ArrayItem{ key: 'description', val: rt.get_property(var_value, 'description') }, rt.ArrayItem{ key: 'value', val: rt.get_property(var_value, 'value') }, rt.ArrayItem{ key: 'deprecationReason', val: rt.get_property(var_value, 'deprecationReason') }, rt.ArrayItem{ key: 'astNode', val: rt.get_property(var_value, 'astNode') }]))
	}
	if this.typeExtensionsMap.array_isset(rt.get_property(var_type, 'name')) {
		mut iter_11 := this.typeExtensionsMap.array_get(rt.get_property(var_type, 'name')).iterator()
		for {
			item_11 := iter_11.next() or { break }
			mut var_extension := item_11.val
			rt.call_function('assert', [rt.new_bool(rt.instance_of(var_extension, 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_EnumTypeExtensionNode')), rt.new_string('proven by schema validation')])
			mut iter_12 := rt.get_property(var_extension, 'values').iterator()
			for {
				item_12 := iter_12.next() or { break }
				mut var_value := item_12.val
				var_newValueMap.array_set(rt.get_property(rt.get_property(var_value, 'name'), 'value'), rt.call_method(this.astBuilder, 'buildEnumValue', [var_value.clone()]))
			}
		}
	}
	return var_newValueMap.clone()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaExtender) extendunionpossibletypes(mut var_type Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_UnionType) rt.PhpVal {
	mut var_possibleTypes := rt.call_function('array_map', [rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaExtender', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'extendNamedType' }]), var_type.gettypes()])
	if this.typeExtensionsMap.array_isset(rt.get_property(var_type, 'name')) {
		mut iter_13 := this.typeExtensionsMap.array_get(rt.get_property(var_type, 'name')).iterator()
		for {
			item_13 := iter_13.next() or { break }
			mut var_extension := item_13.val
			rt.call_function('assert', [rt.new_bool(rt.instance_of(var_extension, 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_UnionTypeExtensionNode')), rt.new_string('proven by schema validation')])
			mut iter_14 := rt.get_property(var_extension, 'types').iterator()
			for {
				item_14 := iter_14.next() or { break }
				mut var_namedType := item_14.val
				var_possibleTypes.array_push(rt.call_method(this.astBuilder, 'buildType', [var_namedType.clone()]))
			}
		}
	}
	return var_possibleTypes.clone()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaExtender) extendimplementedinterfaces(mut var_type Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ImplementingType) rt.PhpVal {
	mut var_interfaces := rt.call_function('array_map', [rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaExtender', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'extendNamedType' }]), var_type.getinterfaces()])
	if this.typeExtensionsMap.array_isset(rt.get_property(var_type, 'name')) {
		mut iter_15 := this.typeExtensionsMap.array_get(rt.get_property(var_type, 'name')).iterator()
		for {
			item_15 := iter_15.next() or { break }
			mut var_extension := item_15.val
			rt.call_function('assert', [rt.new_bool(rt.is_true(rt.new_bool(rt.instance_of(var_extension, 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_ObjectTypeExtensionNode'))) || rt.is_true(rt.new_bool(rt.instance_of(var_extension, 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_InterfaceTypeExtensionNode')))), rt.new_string('proven by schema validation')])
			mut iter_16 := rt.get_property(var_extension, 'interfaces').iterator()
			for {
				item_16 := iter_16.next() or { break }
				mut var_namedType := item_16.val
				mut var_interface := rt.call_method(this.astBuilder, 'buildType', [var_namedType.clone()])
				rt.call_function('assert', [rt.new_bool(rt.instance_of(var_interface, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InterfaceType')), rt.new_string('we know this, but PHP templates cannot express it')])
				var_interfaces.array_push(var_interface.clone())
			}
		}
	}
	return var_interfaces.clone()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaExtender) extendtype(mut var_typeDef Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type) rt.PhpVal {
	if rt.is_true(rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type', []string{}, var_typeDef), 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ListOfType'))) {
		mut iife_temp_4 := Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type{}
		mut iife_result_4 := iife_temp_4.listof(this.extendtype(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type](var_typeDef.getwrappedtype())))
		return iife_result_4
	}
	if rt.is_true(rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type', []string{}, var_typeDef), 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_NonNull'))) {
		mut iife_temp_5 := Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type{}
		mut iife_result_5 := iife_temp_5.nonnull(this.extendtype(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type](var_typeDef.getwrappedtype())))
		return iife_result_5
	}
	return this.extendnamedtype(mut var_typeDef)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaExtender) extendargs(mut var_args Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array) rt.PhpVal {
	mut var_extended := rt.new_array()
	mut iter_17 := var_args.iterator()
	for {
		item_17 := iter_17.next() or { break }
		mut var_arg := item_17.val
		mut var_extendedType := this.extendtype(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type](rt.call_method(var_arg, 'getType', []rt.PhpVal{})))
		mut var_def := rt.create_array([rt.ArrayItem{ key: 'type', val: var_extendedType }, rt.ArrayItem{ key: 'description', val: rt.get_property(var_arg, 'description') }, rt.ArrayItem{ key: 'deprecationReason', val: rt.get_property(var_arg, 'deprecationReason') }, rt.ArrayItem{ key: 'astNode', val: rt.get_property(var_arg, 'astNode') }])
		if rt.is_true(rt.call_method(var_arg, 'defaultValueExists', []rt.PhpVal{})) {
			var_def.array_set('defaultValue', rt.get_property(var_arg, 'defaultValue'))
		}
		var_extended.array_set(rt.get_property(var_arg, 'name'), var_def.clone())
	}
	return var_extended.clone()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaExtender) extendfieldmap(mut var_type Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type) rt.PhpVal {
	mut var_newFieldMap := rt.new_array()
	mut var_oldFieldMap := var_type.getfields()
	mut iter_18 := rt.func_array_keys(var_oldFieldMap.clone()).iterator()
	for {
		item_18 := iter_18.next() or { break }
		mut var_fieldName := item_18.val
		mut var_field := var_oldFieldMap.array_get(var_fieldName)
		var_newFieldMap.array_set(var_fieldName, rt.create_array([rt.ArrayItem{ key: 'name', val: var_fieldName }, rt.ArrayItem{ key: 'description', val: rt.get_property(var_field, 'description') }, rt.ArrayItem{ key: 'deprecationReason', val: rt.get_property(var_field, 'deprecationReason') }, rt.ArrayItem{ key: 'type', val: this.extendtype(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type](rt.call_method(var_field, 'getType', []rt.PhpVal{}))) }, rt.ArrayItem{ key: 'args', val: this.extendargs(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array](rt.get_property(var_field, 'args'))) }, rt.ArrayItem{ key: 'resolve', val: rt.get_property(var_field, 'resolveFn') }, rt.ArrayItem{ key: 'argsMapper', val: rt.get_property(var_field, 'argsMapper') }, rt.ArrayItem{ key: 'astNode', val: rt.get_property(var_field, 'astNode') }]))
	}
	if this.typeExtensionsMap.array_isset(rt.get_property(var_type, 'name')) {
		mut iter_19 := this.typeExtensionsMap.array_get(rt.get_property(var_type, 'name')).iterator()
		for {
			item_19 := iter_19.next() or { break }
			mut var_extension := item_19.val
			rt.call_function('assert', [rt.new_bool(rt.is_true(rt.new_bool(rt.instance_of(var_extension, 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_ObjectTypeExtensionNode'))) || rt.is_true(rt.new_bool(rt.instance_of(var_extension, 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_InterfaceTypeExtensionNode')))), rt.new_string('proven by schema validation')])
			mut iter_20 := rt.get_property(var_extension, 'fields').iterator()
			for {
				item_20 := iter_20.next() or { break }
				mut var_field := item_20.val
				var_newFieldMap.array_set(rt.get_property(rt.get_property(var_field, 'name'), 'value'), rt.call_method(this.astBuilder, 'buildField', [var_field.clone(), var_extension.clone()]))
			}
		}
	}
	return var_newFieldMap.clone()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaExtender) extendobjecttype(mut var_type Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ObjectType) rt.PhpVal {
	mut var_extensionASTNodes := this.extensionastnodes(mut var_type)
	closure_7_fn := fn [var_type] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		return this.extendimplementedinterfaces(mut rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ObjectType', []string{}, var_type))
		}
	closure_8_fn := fn [var_type] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		return this.extendfieldmap(mut rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ObjectType', []string{}, var_type))
		}
	return rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ObjectType', []string{}, create_automattic_woocommerce_vendor_graphql_type_definition_objecttype(rt.create_array([rt.ArrayItem{ key: 'name', val: rt.get_property(var_type, 'name') }, rt.ArrayItem{ key: 'description', val: rt.get_property(var_type, 'description') }, rt.ArrayItem{ key: 'interfaces', val: rt.new_closure(closure_7_fn) }, rt.ArrayItem{ key: 'fields', val: rt.new_closure(closure_8_fn) }, rt.ArrayItem{ key: 'isTypeOf', val: rt.create_array([rt.ArrayItem{ key: none, val: var_type }, rt.ArrayItem{ key: none, val: 'isTypeOf' }]) }, rt.ArrayItem{ key: 'resolveField', val: rt.get_property(var_type, 'resolveFieldFn') }, rt.ArrayItem{ key: 'argsMapper', val: rt.get_property(var_type, 'argsMapper') }, rt.ArrayItem{ key: 'astNode', val: rt.get_property(var_type, 'astNode') }, rt.ArrayItem{ key: 'extensionASTNodes', val: var_extensionASTNodes }])))
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaExtender) extendinterfacetype(mut var_type Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InterfaceType) rt.PhpVal {
	mut var_extensionASTNodes := this.extensionastnodes(mut var_type)
	closure_9_fn := fn [var_type] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		return this.extendimplementedinterfaces(mut rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InterfaceType', []string{}, var_type))
		}
	closure_10_fn := fn [var_type] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		return this.extendfieldmap(mut rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InterfaceType', []string{}, var_type))
		}
	return rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InterfaceType', []string{}, create_automattic_woocommerce_vendor_graphql_type_definition_interfacetype(rt.create_array([rt.ArrayItem{ key: 'name', val: rt.get_property(var_type, 'name') }, rt.ArrayItem{ key: 'description', val: rt.get_property(var_type, 'description') }, rt.ArrayItem{ key: 'interfaces', val: rt.new_closure(closure_9_fn) }, rt.ArrayItem{ key: 'fields', val: rt.new_closure(closure_10_fn) }, rt.ArrayItem{ key: 'resolveType', val: rt.create_array([rt.ArrayItem{ key: none, val: var_type }, rt.ArrayItem{ key: none, val: 'resolveType' }]) }, rt.ArrayItem{ key: 'astNode', val: rt.get_property(var_type, 'astNode') }, rt.ArrayItem{ key: 'extensionASTNodes', val: var_extensionASTNodes }])))
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaExtender) isspecifiedscalartype(mut var_type Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type) bool {
	return rt.is_true(rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type', []string{}, var_type), 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_NamedType'))) && rt.is_true(rt.call_function('in_array', [rt.get_property(var_type, 'name'), rt.create_array([rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type.string() }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type.int() }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type.float() }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type.boolean() }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type.id() }]), rt.new_bool(true)]))
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaExtender) extendnamedtype(mut var_type Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type) rt.PhpVal {
	mut iife_temp_10 := Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Introspection{}
	mut iife_result_10 := iife_temp_10.isintrospectiontype(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type', []string{}, var_type))
	if rt.is_true(iife_result_10) || this.isspecifiedscalartype(mut var_type) {
		return rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type', []string{}, var_type)
	}
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaExtender) extendnamedtypewithoutcache(mut var_type Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type) rt.PhpVal {
	mut switch_val_1 := rt.new_bool(true)
	if rt.is_true(rt.equal(switch_val_1, rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type', []string{}, var_type), 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ScalarType')))) {
		return this.extendscalartype(mut var_type)
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type', []string{}, var_type), 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ObjectType')))) {
		return this.extendobjecttype(mut var_type)
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type', []string{}, var_type), 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InterfaceType')))) {
		return this.extendinterfacetype(mut var_type)
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type', []string{}, var_type), 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_UnionType')))) {
		return this.extenduniontype(mut var_type)
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type', []string{}, var_type), 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_EnumType')))) {
		return this.extendenumtype(mut var_type)
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type', []string{}, var_type), 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InputObjectType')))) {
		return this.extendinputobjecttype(mut var_type)
	} else {
		mut var_unconsideredType := rt.call_function('get_class', [var_type])
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Utils_Exception', []string{}, create_automattic_woocommerce_vendor_graphql_utils_exception(rt.new_string("Unconsidered type: ${var_unconsideredType.to_string()}."))))
	}
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaExtender) extendmaybenamedtype(mut var_type Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_?Type) rt.PhpVal {
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_type, rt.new_null())))) {
		return this.extendnamedtype(mut var_type)
	}
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaExtender) getmergeddirectives(mut var_schema Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema, mut var_directiveDefinitions Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array) rt.PhpVal {
	mut var_directiveDefinitions_mutated := var_directiveDefinitions
	mut var_directives := rt.call_function('array_map', [rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaExtender', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'extendDirective' }]), var_schema.getdirectives()])
	if rt.is_true(rt.identical(var_directives, rt.new_array())) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Error_InvariantViolation', []string{}, create_automattic_woocommerce_vendor_graphql_error_invariantviolation(rt.new_string('Schema must have default directives.'))))
	}
	mut iter_21 := var_directiveDefinitions_mutated.iterator()
	for {
		item_21 := iter_21.next() or { break }
		mut var_directive := item_21.val
		var_directives.array_push(rt.call_method(this.astBuilder, 'buildDirective', [var_directive.clone()]))
	}
	return var_directives.clone()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaExtender) extenddirective(mut var_directive Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Directive) rt.PhpVal {
	return rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Directive', []string{}, create_automattic_woocommerce_vendor_graphql_type_definition_directive(rt.create_array([rt.ArrayItem{ key: 'name', val: rt.get_property(var_directive, 'name') }, rt.ArrayItem{ key: 'description', val: rt.get_property(var_directive, 'description') }, rt.ArrayItem{ key: 'locations', val: rt.get_property(var_directive, 'locations') }, rt.ArrayItem{ key: 'args', val: this.extendargs(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array](rt.get_property(var_directive, 'args'))) }, rt.ArrayItem{ key: 'isRepeatable', val: rt.get_property(var_directive, 'isRepeatable') }, rt.ArrayItem{ key: 'astNode', val: rt.get_property(var_directive, 'astNode') }])))
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_static {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_DocumentValidator {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_ASTDefinitionBuilder {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Error_InvariantViolation {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Type_SchemaConfig {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_CustomScalarType {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_UnionType {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_EnumType {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InputObjectType {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ObjectType {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InterfaceType {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Introspection {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Exception {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Directive {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_vendor_graphql_utils_schemaextender(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaExtender {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaExtender{
		PhpObjectBase: rt.PhpObjectBase{}
		extendTypeCache: rt.new_array()
		typeExtensionsMap: rt.new_array()
		astBuilder: rt.new_null()
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_utils_static(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_static {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_static{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_validator_documentvalidator(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_DocumentValidator {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_DocumentValidator{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_utils_astdefinitionbuilder(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_ASTDefinitionBuilder {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_ASTDefinitionBuilder{
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

fn create_automattic_woocommerce_vendor_graphql_type_schemaconfig(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_SchemaConfig {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_SchemaConfig{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_type_schema(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema{
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

fn create_automattic_woocommerce_vendor_graphql_type_definition_uniontype(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_UnionType {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_UnionType{
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

fn create_automattic_woocommerce_vendor_graphql_type_definition_inputobjecttype(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InputObjectType {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InputObjectType{
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

fn create_automattic_woocommerce_vendor_graphql_type_definition_objecttype(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ObjectType {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ObjectType{
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

fn create_automattic_woocommerce_vendor_graphql_type_introspection(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Introspection {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Introspection{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_utils_exception(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Exception {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Exception{
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

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaExtender) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'extend' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_DocumentNode](if args.len > 1 { args[1] } else { rt.new_null() })
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array](if args.len > 2 { args[2] } else { rt.new_null() })
			mut dispatch_arg_3 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_?callable](if args.len > 3 { args[3] } else { rt.new_null() })
			mut dispatch_arg_4 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_?callable](if args.len > 4 { args[4] } else { rt.new_null() })
			return Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaExtender.extend(mut dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2, mut dispatch_arg_3, mut dispatch_arg_4)
		}
		'doExtend' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_DocumentNode](if args.len > 1 { args[1] } else { rt.new_null() })
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array](if args.len > 2 { args[2] } else { rt.new_null() })
			mut dispatch_arg_3 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_?callable](if args.len > 3 { args[3] } else { rt.new_null() })
			mut dispatch_arg_4 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_?callable](if args.len > 4 { args[4] } else { rt.new_null() })
			return this.doextend(mut dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2, mut dispatch_arg_3, mut dispatch_arg_4)
		}
		'extensionASTNodes' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_NamedType](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.extensionastnodes(mut dispatch_arg_0)
		}
		'extendScalarType' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ScalarType](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.extendscalartype(mut dispatch_arg_0)
		}
		'extendUnionType' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_UnionType](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.extenduniontype(mut dispatch_arg_0)
		}
		'extendEnumType' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_EnumType](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.extendenumtype(mut dispatch_arg_0)
		}
		'extendInputObjectType' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InputObjectType](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.extendinputobjecttype(mut dispatch_arg_0)
		}
		'extendInputFieldMap' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InputObjectType](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.extendinputfieldmap(mut dispatch_arg_0)
		}
		'extendEnumValueMap' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_EnumType](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.extendenumvaluemap(mut dispatch_arg_0)
		}
		'extendUnionPossibleTypes' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_UnionType](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.extendunionpossibletypes(mut dispatch_arg_0)
		}
		'extendImplementedInterfaces' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ImplementingType](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.extendimplementedinterfaces(mut dispatch_arg_0)
		}
		'extendType' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.extendtype(mut dispatch_arg_0)
		}
		'extendArgs' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.extendargs(mut dispatch_arg_0)
		}
		'extendFieldMap' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.extendfieldmap(mut dispatch_arg_0)
		}
		'extendObjectType' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ObjectType](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.extendobjecttype(mut dispatch_arg_0)
		}
		'extendInterfaceType' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InterfaceType](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.extendinterfacetype(mut dispatch_arg_0)
		}
		'isSpecifiedScalarType' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_bool(this.isspecifiedscalartype(mut dispatch_arg_0))
		}
		'extendNamedType' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.extendnamedtype(mut dispatch_arg_0)
		}
		'extendNamedTypeWithoutCache' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.extendnamedtypewithoutcache(mut dispatch_arg_0)
		}
		'extendMaybeNamedType' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_?Type](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.extendmaybenamedtype(mut dispatch_arg_0)
		}
		'getMergedDirectives' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array](if args.len > 1 { args[1] } else { rt.new_null() })
			return this.getmergeddirectives(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		'extendDirective' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Directive](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.extenddirective(mut dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaExtender) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'extendTypeCache' { return this.extendTypeCache }
		'typeExtensionsMap' { return this.typeExtensionsMap }
		'astBuilder' { return this.astBuilder }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaExtender) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'extendTypeCache' { this.extendTypeCache = val; return true }
		'typeExtensionsMap' { this.typeExtensionsMap = val; return true }
		'astBuilder' { this.astBuilder = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_static) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_static) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_static) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_DocumentValidator) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_DocumentValidator) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_DocumentValidator) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_ASTDefinitionBuilder) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_ASTDefinitionBuilder) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_ASTDefinitionBuilder) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_SchemaConfig) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_SchemaConfig) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_SchemaConfig) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_UnionType) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_UnionType) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_UnionType) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InputObjectType) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InputObjectType) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InputObjectType) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ObjectType) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ObjectType) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ObjectType) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Introspection) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Introspection) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Introspection) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Exception) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Exception) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Exception) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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



fn main() {
	defer {
		rt.shutdown()
	}

}
