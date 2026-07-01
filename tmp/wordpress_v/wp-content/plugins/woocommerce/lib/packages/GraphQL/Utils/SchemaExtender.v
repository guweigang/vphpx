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
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(if !(var_options.array_get('assumeValid')).is_null() { var_options.array_get('assumeValid') } else { rt.new_bool(false) })))) && rt.is_true(rt.new_bool(!(rt.is_true(if !(var_options.array_get('assumeValidSDL')).is_null() { var_options.array_get('assumeValidSDL') } else { rt.new_bool(false) })))))) {
		fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_DocumentValidator{}; return temp.assertvalidsdlextension(arg_0, arg_1) }(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_DocumentNode', []string{}, var_documentAST), rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Schema', []string{}, var_schema))
	}
	mut var_typeDefinitionMap := rt.new_array()
	mut var_directiveDefinitions := rt.new_array()
	mut var_schemaDef := rt.new_null()
	mut var_schemaExtensions := rt.new_array()
	{
		mut iter_1 := rt.get_property(var_documentAST, 'definitions').iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_def := item_1.val
			if rt.is_true(rt.new_bool(rt.instance_of(var_def, 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_SchemaDefinitionNode'))) {
				var_schemaDef = var_def.dup()
			} else if rt.is_true(rt.new_bool(rt.instance_of(var_def, 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_SchemaExtensionNode'))) {
				var_schemaExtensions.array_push(var_def.dup())
			} else if rt.is_true(rt.new_bool(rt.instance_of(var_def, 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_TypeDefinitionNode'))) {
				mut var_name := rt.get_property(rt.call_method(var_def, 'getName', []rt.PhpVal{}), 'value')
				var_typeDefinitionMap.array_set(var_name, var_def.dup())
			} else if rt.is_true(rt.new_bool(rt.instance_of(var_def, 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_TypeExtensionNode'))) {
				var_name = rt.get_property(rt.call_method(var_def, 'getName', []rt.PhpVal{}), 'value')
				this.typeExtensionsMap.array_get_mut(var_name).array_push(var_def.dup())
			} else if rt.is_true(rt.new_bool(rt.instance_of(var_def, 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_DirectiveDefinitionNode'))) {
				var_directiveDefinitions.array_push(var_def.dup())
			}
		}
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.identical(this.typeExtensionsMap, rt.new_array())) && rt.is_true(rt.identical(var_typeDefinitionMap, rt.new_array())))) && rt.is_true(rt.identical(var_directiveDefinitions, rt.new_array())))) && rt.is_true(rt.identical(var_schemaExtensions, rt.new_array())))) && rt.is_true(rt.identical(var_schemaDef, rt.new_null())))) {
		return rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Schema', []string{}, var_schema)
	}
	closure_1_fn := fn [var_schema] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_typeName := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	mut var_existingType := var_schema.gettype(var_typeName.dup())
	if rt.is_true(rt.identical(var_existingType, rt.new_null())) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Error_InvariantViolation', []string{}, create_automattic_woocommerce_vendor_graphql_error_invariantviolation(rt.new_string("Unknown type: \"${var_typeName.to_string()}\"."))))
	}
	return this.extendnamedtype(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type](var_existingType))
	}
	this.astBuilder = create_automattic_woocommerce_vendor_graphql_utils_astdefinitionbuilder(var_typeDefinitionMap.dup(), rt.new_array(), rt.new_closure(closure_1_fn), var_typeConfigDecorator.dup(), var_fieldConfigDecorator.dup())
	this.extendTypeCache = rt.new_array()
	mut var_types := rt.new_array()
	{
		mut iter_1 := var_schema.gettypemap().iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_type := item_1.val
			var_types.array_push(this.extendnamedtype(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type](var_type)))
		}
	}
	{
		mut iter_1 := var_typeDefinitionMap.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_type := item_1.val
			var_types.array_push(rt.call_method(this.astBuilder, 'buildType', [var_type.dup()]))
		}
	}
	mut var_operationTypes := rt.create_array([rt.ArrayItem{ key: 'query', val: this.extendmaybenamedtype(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_?Type](var_schema.getquerytype())) }, rt.ArrayItem{ key: 'mutation', val: this.extendmaybenamedtype(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_?Type](var_schema.getmutationtype())) }, rt.ArrayItem{ key: 'subscription', val: this.extendmaybenamedtype(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_?Type](var_schema.getsubscriptiontype())) }])
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		{
			mut iter_1 := rt.get_property(var_schemaDef, 'operationTypes').iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_operationType := item_1.val
				var_operationTypes.array_set(rt.get_property(var_operationType, 'operation'), rt.call_method(this.astBuilder, 'buildType', [rt.get_property(var_operationType, 'type')]))
			}
		}
	}
	{
		mut iter_1 := var_schemaExtensions.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_schemaExtension := item_1.val
			{
				mut iter_2 := rt.get_property(var_schemaExtension, 'operationTypes').iterator()
				for {
					item_2 := iter_2.next() or { break }
					mut var_operationType := item_2.val
					var_operationTypes.array_set(rt.get_property(var_operationType, 'operation'), rt.call_method(this.astBuilder, 'buildType', [rt.get_property(var_operationType, 'type')]))
				}
			}
		}
	}
	mut var_schemaConfig := rt.call_method(rt.call_method(rt.call_method(rt.call_method(rt.call_method(rt.call_method(rt.call_method(rt.call_method(create_automattic_woocommerce_vendor_graphql_type_schemaconfig(), 'setDescription', [if !(rt.get_property(rt.get_property(var_schemaDef, 'description'), 'value')).is_null() { rt.get_property(rt.get_property(var_schemaDef, 'description'), 'value') } else { if !(rt.get_property(var_schema, 'description')).is_null() { rt.get_property(var_schema, 'description') } else { rt.new_null() } }]), 'setQuery', [var_operationTypes.array_get('query')]), 'setMutation', [var_operationTypes.array_get('mutation')]), 'setSubscription', [var_operationTypes.array_get('subscription')]), 'setTypes', [var_types.dup()]), 'setDirectives', [this.getmergeddirectives(mut var_schema, mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array](var_directiveDefinitions))]), 'setAstNode', [if !(rt.get_property(var_schema, 'astNode')).is_null() { rt.get_property(var_schema, 'astNode') } else { var_schemaDef }]), 'setExtensionASTNodes', [rt.create_array([rt.ArrayItem{ key: none, val: rt.get_property(var_schema, 'extensionASTNodes') }, rt.ArrayItem{ key: none, val: var_schemaExtensions }])])
	return create_automattic_woocommerce_vendor_graphql_type_schema(var_schemaConfig.dup())
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaExtender) extensionastnodes(mut var_type Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_NamedType) rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: none, val: if !(rt.get_property(var_type, 'extensionASTNodes')).is_null() { rt.get_property(var_type, 'extensionASTNodes') } else { rt.new_array() } }, rt.ArrayItem{ key: none, val: if !(this.typeExtensionsMap.array_get(rt.get_property(var_type, 'name'))).is_null() { this.typeExtensionsMap.array_get(rt.get_property(var_type, 'name')) } else { rt.new_array() } }])
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaExtender) extendscalartype(mut var_type Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ScalarType) rt.PhpVal {
	mut var_extensionASTNodes := this.extensionastnodes(mut var_type)
	return create_automattic_woocommerce_vendor_graphql_type_definition_customscalartype(rt.create_array([rt.ArrayItem{ key: 'name', val: rt.get_property(var_type, 'name') }, rt.ArrayItem{ key: 'description', val: rt.get_property(var_type, 'description') }, rt.ArrayItem{ key: 'serialize', val: rt.create_array([rt.ArrayItem{ key: none, val: var_type }, rt.ArrayItem{ key: none, val: 'serialize' }]) }, rt.ArrayItem{ key: 'parseValue', val: rt.create_array([rt.ArrayItem{ key: none, val: var_type }, rt.ArrayItem{ key: none, val: 'parseValue' }]) }, rt.ArrayItem{ key: 'parseLiteral', val: rt.create_array([rt.ArrayItem{ key: none, val: var_type }, rt.ArrayItem{ key: none, val: 'parseLiteral' }]) }, rt.ArrayItem{ key: 'astNode', val: rt.get_property(var_type, 'astNode') }, rt.ArrayItem{ key: 'extensionASTNodes', val: var_extensionASTNodes }]))
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaExtender) extenduniontype(mut var_type Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_UnionType) rt.PhpVal {
	mut var_extensionASTNodes := this.extensionastnodes(mut var_type)
	closure_2_fn := fn [var_type] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	return this.extendunionpossibletypes(mut rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_UnionType', []string{}, var_type))
	}
	return create_automattic_woocommerce_vendor_graphql_type_definition_uniontype(rt.create_array([rt.ArrayItem{ key: 'name', val: rt.get_property(var_type, 'name') }, rt.ArrayItem{ key: 'description', val: rt.get_property(var_type, 'description') }, rt.ArrayItem{ key: 'types', val: rt.new_closure(closure_2_fn) }, rt.ArrayItem{ key: 'resolveType', val: rt.create_array([rt.ArrayItem{ key: none, val: var_type }, rt.ArrayItem{ key: none, val: 'resolveType' }]) }, rt.ArrayItem{ key: 'astNode', val: rt.get_property(var_type, 'astNode') }, rt.ArrayItem{ key: 'extensionASTNodes', val: var_extensionASTNodes }]))
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaExtender) extendenumtype(mut var_type Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_EnumType) rt.PhpVal {
	mut var_extensionASTNodes := this.extensionastnodes(mut var_type)
	return create_automattic_woocommerce_vendor_graphql_type_definition_enumtype(rt.create_array([rt.ArrayItem{ key: 'name', val: rt.get_property(var_type, 'name') }, rt.ArrayItem{ key: 'description', val: rt.get_property(var_type, 'description') }, rt.ArrayItem{ key: 'values', val: this.extendenumvaluemap(mut var_type) }, rt.ArrayItem{ key: 'astNode', val: rt.get_property(var_type, 'astNode') }, rt.ArrayItem{ key: 'extensionASTNodes', val: var_extensionASTNodes }]))
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaExtender) extendinputobjecttype(mut var_type Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InputObjectType) rt.PhpVal {
	mut var_extensionASTNodes := this.extensionastnodes(mut var_type)
	closure_3_fn := fn [var_type] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	return this.extendinputfieldmap(mut rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InputObjectType', []string{}, var_type))
	}
	return create_automattic_woocommerce_vendor_graphql_type_definition_inputobjecttype(rt.create_array([rt.ArrayItem{ key: 'name', val: rt.get_property(var_type, 'name') }, rt.ArrayItem{ key: 'description', val: rt.get_property(var_type, 'description') }, rt.ArrayItem{ key: 'fields', val: rt.new_closure(closure_3_fn) }, rt.ArrayItem{ key: 'parseValue', val: rt.create_array([rt.ArrayItem{ key: none, val: var_type }, rt.ArrayItem{ key: none, val: 'parseValue' }]) }, rt.ArrayItem{ key: 'astNode', val: rt.get_property(var_type, 'astNode') }, rt.ArrayItem{ key: 'extensionASTNodes', val: var_extensionASTNodes }, rt.ArrayItem{ key: 'isOneOf', val: rt.get_property(var_type, 'isOneOf') }]))
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaExtender) extendinputfieldmap(mut var_type Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InputObjectType) rt.PhpVal {
	mut var_newFieldMap := rt.new_array()
	mut var_oldFieldMap := var_type.getfields()
	{
		mut iter_1 := var_oldFieldMap.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_field := item_1.val
			mut var_fieldName := item_1.key
			mut var_extendedType := this.extendtype(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type](rt.call_method(var_field, 'getType', []rt.PhpVal{})))
			mut var_newFieldConfig := rt.create_array([rt.ArrayItem{ key: 'description', val: rt.get_property(var_field, 'description') }, rt.ArrayItem{ key: 'type', val: var_extendedType }, rt.ArrayItem{ key: 'deprecationReason', val: rt.get_property(var_field, 'deprecationReason') }, rt.ArrayItem{ key: 'astNode', val: rt.get_property(var_field, 'astNode') }])
			if rt.is_true(rt.call_method(var_field, 'defaultValueExists', []rt.PhpVal{})) {
				var_newFieldConfig.array_set('defaultValue', rt.get_property(var_field, 'defaultValue'))
			}
			var_newFieldMap.array_set(var_fieldName, var_newFieldConfig.dup())
		}
	}
	if this.typeExtensionsMap.array_isset(rt.get_property(var_type, 'name')) {
		{
			mut iter_1 := this.typeExtensionsMap.array_get(rt.get_property(var_type, 'name')).iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_extension := item_1.val
				rt.call_function('assert', [rt.new_bool(rt.instance_of(var_extension, 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_InputObjectTypeExtensionNode')), rt.new_string('proven by schema validation')])
				{
					mut iter_2 := rt.get_property(var_extension, 'fields').iterator()
					for {
						item_2 := iter_2.next() or { break }
						mut var_field := item_2.val
						var_newFieldMap.array_set(rt.get_property(rt.get_property(var_field, 'name'), 'value'), rt.call_method(this.astBuilder, 'buildInputField', [var_field.dup()]))
					}
				}
			}
		}
	}
	return var_newFieldMap.dup()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaExtender) extendenumvaluemap(mut var_type Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_EnumType) rt.PhpVal {
	mut var_newValueMap := rt.new_array()
	{
		mut iter_1 := var_type.getvalues().iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_value := item_1.val
			var_newValueMap.array_set(rt.get_property(var_value, 'name'), rt.create_array([rt.ArrayItem{ key: 'name', val: rt.get_property(var_value, 'name') }, rt.ArrayItem{ key: 'description', val: rt.get_property(var_value, 'description') }, rt.ArrayItem{ key: 'value', val: rt.get_property(var_value, 'value') }, rt.ArrayItem{ key: 'deprecationReason', val: rt.get_property(var_value, 'deprecationReason') }, rt.ArrayItem{ key: 'astNode', val: rt.get_property(var_value, 'astNode') }]))
		}
	}
	if this.typeExtensionsMap.array_isset(rt.get_property(var_type, 'name')) {
		{
			mut iter_1 := this.typeExtensionsMap.array_get(rt.get_property(var_type, 'name')).iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_extension := item_1.val
				rt.call_function('assert', [rt.new_bool(rt.instance_of(var_extension, 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_EnumTypeExtensionNode')), rt.new_string('proven by schema validation')])
				{
					mut iter_2 := rt.get_property(var_extension, 'values').iterator()
					for {
						item_2 := iter_2.next() or { break }
						mut var_value := item_2.val
						.array_set(, )
					}
				}
			}
		}
	}
	return var_newValueMap.dup()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaExtender) extendunionpossibletypes(mut var_type Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_UnionType) rt.PhpVal {
	
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaExtender) extendimplementedinterfaces(mut var_type Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ImplementingType) rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaExtender) extendtype(mut var_typeDef Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type) rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaExtender) extendargs(mut var_args Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array) rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaExtender) extendfieldmap(mut var_type Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type) rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaExtender) extendobjecttype(mut var_type Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ObjectType) rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaExtender) extendinterfacetype(mut var_type Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InterfaceType) rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaExtender) isspecifiedscalartype(mut var_type Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type) bool {
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaExtender) extendnamedtype(mut var_type Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type) rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaExtender) extendnamedtypewithoutcache(mut var_type Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type)  {
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaExtender) extendmaybenamedtype(mut var_type Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_?Type) rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaExtender) getmergeddirectives(mut var_schema Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema, mut var_directiveDefinitions Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array) rt.PhpVal {
	mut var_directiveDefinitions_mutated := var_directiveDefinitions
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaExtender) extenddirective(mut var_directive Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Directive) rt.PhpVal {
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

fn create_automattic_woocommerce_vendor_graphql_utils_schemaextender() &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaExtender {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SchemaExtender{
		PhpObjectBase: rt.PhpObjectBase{}
		extendTypeCache: rt.new_array()
		typeExtensionsMap: rt.new_array()
		astBuilder: rt.new_null()
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_utils_static() &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_static {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_static{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_validator_documentvalidator() &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_DocumentValidator {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_DocumentValidator{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_utils_astdefinitionbuilder() &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_ASTDefinitionBuilder {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_ASTDefinitionBuilder{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_error_invariantviolation() &Class_Automattic_WooCommerce_Vendor_GraphQL_Error_InvariantViolation {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Error_InvariantViolation{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_type_schemaconfig() &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_SchemaConfig {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_SchemaConfig{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_type_schema() &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_type_definition_customscalartype() &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_CustomScalarType {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_CustomScalarType{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_type_definition_uniontype() &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_UnionType {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_UnionType{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_type_definition_enumtype() &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_EnumType {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_EnumType{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_type_definition_inputobjecttype() &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InputObjectType {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InputObjectType{
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
			this.extendnamedtypewithoutcache(mut dispatch_arg_0)
			return rt.new_null()
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




pub fn init_wp_content_plugins_woocommerce_lib_packages_graphql_utils_schemaextender_php() {
	// unsupported statement: Stmt_Declare
}
