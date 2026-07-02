import rt

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Type_SchemaValidationContext {
	rt.PhpObjectBase
pub mut:
		errors rt.PhpVal = rt.new_array()
		schema rt.PhpVal = rt.new_null()
		inputObjectCircularRefs rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_SchemaValidationContext) construct(mut var_schema Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema) {
	mut var_schema_mutated := var_schema
	this.schema = var_schema_mutated
	this.inputObjectCircularRefs = create_automattic_woocommerce_vendor_graphql_type_validation_inputobjectcircularrefs(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_SchemaValidationContext', []string{}, &this))
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_SchemaValidationContext) geterrors() rt.PhpVal {
	return this.errors
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_SchemaValidationContext) validateroottypes() {
	if rt.is_true(rt.identical(rt.call_method(this.schema, 'getQueryType', []rt.PhpVal{}), rt.new_null())) {
		this.reporterror('Query root type must be provided.', rt.get_property(this.schema, 'astNode'))
	}
	rt.call_method(this.schema, 'getMutationType', []rt.PhpVal{})
	rt.call_method(this.schema, 'getSubscriptionType', []rt.PhpVal{})
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_SchemaValidationContext) reporterror(message string, var_nodes rt.PhpVal) {
	mut var_nodes_mutated := var_nodes
	var_nodes_mutated = rt.call_function('array_filter', [if var_nodes_mutated.clone().is_array() { var_nodes_mutated } else { rt.create_array([rt.ArrayItem{ key: none, val: var_nodes_mutated }]) }])
	this.adderror(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Error](create_automattic_woocommerce_vendor_graphql_error_error(rt.new_string(message), var_nodes_mutated.clone())))
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_SchemaValidationContext) adderror(mut var_error Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Error) {
	mut var_error_mutated := var_error
	this.errors.array_push(var_error_mutated)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_SchemaValidationContext) validatedirectives() {
	this.validatedirectivedefinitions()
	this.validatedirectivesatlocation(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeList](this.getdirectives(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_object](this.schema))), (Class_Automattic_WooCommerce_Vendor_GraphQL_Language_DirectiveLocation.schema()).str())
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_SchemaValidationContext) validatedirectivedefinitions() {
	mut var_directiveDefinitions := rt.new_array()
	mut var_directives := rt.call_method(this.schema, 'getDirectives', []rt.PhpVal{})
	mut iter_1 := var_directives.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_directive := item_1.val
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_directive, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Directive')))))) {
			mut iife_temp_0 := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils{}
			mut iife_result_0 := iife_temp_0.printsafe(var_directive.clone())
			mut var_notDirective := iife_result_0
			mut var_nodes := if var_directive.clone().is_object() && rt.is_true(rt.call_function('property_exists', [var_directive.clone(), rt.new_string('astNode')])) { rt.get_property(var_directive, 'astNode') } else { rt.new_null() }
			this.reporterror("Expected directive but got: ${var_notDirective.to_string()}.", var_nodes.clone())
			continue
		}
		mut var_existingDefinitions := if !(var_directiveDefinitions.array_get(rt.get_property(var_directive, 'name'))).is_null() { var_directiveDefinitions.array_get(rt.get_property(var_directive, 'name')) } else { rt.new_array() }
		var_existingDefinitions.array_push(var_directive.clone())
		var_directiveDefinitions.array_set(rt.get_property(var_directive, 'name'), var_existingDefinitions.clone())
		this.validatename(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_object](var_directive))
		mut var_argNames := rt.new_array()
		mut iter_2 := rt.get_property(var_directive, 'args').iterator()
		for {
			item_2 := iter_2.next() or { break }
			mut var_arg := item_2.val
			this.validatename(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_object](var_arg))
			mut var_argName := rt.get_property(var_arg, 'name')
			if var_argNames.array_isset(var_argName) {
				this.reporterror(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('Argument @'), rt.get_property(var_directive, 'name')), rt.new_string('(')), var_argName), rt.new_string(':) can only be defined once.')), this.getalldirectiveargnodes(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Directive](var_directive), (var_argName).str()))
				continue
			}
			var_argNames.array_set(var_argName, true)
			mut iife_temp_1 := Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type{}
			mut iife_result_1 := iife_temp_1.isinputtype(rt.call_method(var_arg, 'getType', []rt.PhpVal{}))
			if rt.is_true(rt.new_bool(!(rt.is_true(iife_result_1)))) {
				mut iife_temp_2 := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils{}
				mut iife_result_2 := iife_temp_2.printsafe(rt.call_method(var_arg, 'getType', []rt.PhpVal{}))
				mut var_type := iife_result_2
				this.reporterror(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('The type of @'), rt.get_property(var_directive, 'name')), rt.new_string('(')), var_argName), rt.new_string(':) must be Input Type but got: ')), var_type), rt.new_string('.')), this.getdirectiveargtypenode(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Directive](var_directive), (var_argName).str()))
			}
		}
	}
	mut iter_3 := var_directiveDefinitions.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_directiveList := item_3.val
		mut var_directiveName := item_3.key
		if var_directiveList.clone().array_count() > 1 {
			mut var_nodes := rt.new_array()
			mut iter_4 := var_directiveList.iterator()
			for {
				item_4 := iter_4.next() or { break }
				mut var_dir := item_4.val
				if !(rt.get_property(var_dir, 'astNode')).is_null() {
					var_nodes.array_push(rt.get_property(var_dir, 'astNode'))
				}
			}
			this.reporterror("Directive @${var_directiveName.to_string()} defined multiple times.", var_nodes.clone())
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_SchemaValidationContext) validatename(mut var_object Class_Automattic_WooCommerce_Vendor_GraphQL_Type_object) {
	mut iife_temp_3 := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils{}
	mut iife_result_3 := iife_temp_3.isvalidnameerror(rt.get_property(var_object, 'name'), rt.get_property(var_object, 'astNode'))
	mut var_error := iife_result_3
	mut iife_temp_4 := Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Introspection{}
	mut iife_result_4 := iife_temp_4.isintrospectiontype(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_object', []string{}, var_object))
	if rt.is_true(rt.identical(var_error, rt.new_null())) || (rt.is_true(rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_object', []string{}, var_object), 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type'))) && rt.is_true(iife_result_4)) {
		return
	}
	this.adderror(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Error](var_error))
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_SchemaValidationContext) getalldirectiveargnodes(mut var_directive Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Directive, argName string) rt.PhpVal {
	mut argName_mutated := argName
	mut var_astNode := rt.get_property(var_directive, 'astNode')
	if rt.is_true(rt.identical(var_astNode, rt.new_null())) {
		return rt.new_array()
	}
	mut var_matchingSubnodes := rt.new_array()
	mut iter_5 := rt.get_property(var_astNode, 'arguments').iterator()
	for {
		item_5 := iter_5.next() or { break }
		mut var_subNode := item_5.val
		if rt.is_true(rt.identical(rt.get_property(rt.get_property(var_subNode, 'name'), 'value'), rt.new_string(argName_mutated))) {
			var_matchingSubnodes.array_push(var_subNode.clone())
		}
	}
	return var_matchingSubnodes.clone()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_SchemaValidationContext) getdirectiveargtypenode(mut var_directive Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Directive, argName string) rt.PhpVal {
	mut argName_mutated := argName
	mut var_argNode := if !(this.getalldirectiveargnodes(mut var_directive, argName_mutated).array_get(rt.new_int(0))).is_null() { this.getalldirectiveargnodes(mut var_directive, argName_mutated).array_get(rt.new_int(0)) } else { rt.new_null() }
	return if rt.is_true(rt.identical(var_argNode, rt.new_null())) { rt.new_null() } else { rt.get_property(var_argNode, 'type') }
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_SchemaValidationContext) validatetypes() {
	mut var_typeMap := rt.call_method(this.schema, 'getTypeMap', []rt.PhpVal{})
	mut iter_6 := var_typeMap.iterator()
	for {
		item_6 := iter_6.next() or { break }
		mut var_type := item_6.val
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_type, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_NamedType')))))) {
			mut iife_temp_5 := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils{}
			mut iife_result_5 := iife_temp_5.printsafe(var_type.clone())
			mut var_notNamedType := iife_result_5
			mut var_node := if rt.is_true(rt.new_bool(rt.instance_of(var_type, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type'))) { rt.get_property(var_type, 'astNode') } else { rt.new_null() }
			this.reporterror("Expected Automattic\\WooCommerce\\Vendor\\GraphQL named type but got: ${var_notNamedType.to_string()}.", var_node.clone())
			continue
		}
		this.validatename(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_object](var_type))
		if rt.is_true(rt.new_bool(rt.instance_of(var_type, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ObjectType'))) {
			this.validatefields(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type](var_type))
			this.validateinterfaces(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ImplementingType](var_type))
			this.validatedirectivesatlocation(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeList](this.getdirectives(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_object](var_type))), (Class_Automattic_WooCommerce_Vendor_GraphQL_Language_DirectiveLocation.object()).str())
		} else if rt.is_true(rt.new_bool(rt.instance_of(var_type, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InterfaceType'))) {
			this.validatefields(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type](var_type))
			this.validateinterfaces(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ImplementingType](var_type))
			this.validatedirectivesatlocation(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeList](this.getdirectives(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_object](var_type))), (Class_Automattic_WooCommerce_Vendor_GraphQL_Language_DirectiveLocation.iface()).str())
		} else if rt.is_true(rt.new_bool(rt.instance_of(var_type, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_UnionType'))) {
			this.validateunionmembers(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_UnionType](var_type))
			this.validatedirectivesatlocation(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeList](this.getdirectives(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_object](var_type))), (Class_Automattic_WooCommerce_Vendor_GraphQL_Language_DirectiveLocation.union()).str())
		} else if rt.is_true(rt.new_bool(rt.instance_of(var_type, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_EnumType'))) {
			this.validateenumvalues(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_EnumType](var_type))
			this.validatedirectivesatlocation(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeList](this.getdirectives(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_object](var_type))), (Class_Automattic_WooCommerce_Vendor_GraphQL_Language_DirectiveLocation.enum()).str())
		} else if rt.is_true(rt.new_bool(rt.instance_of(var_type, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InputObjectType'))) {
			this.validateinputfields(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InputObjectType](var_type))
			this.validatedirectivesatlocation(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeList](this.getdirectives(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_object](var_type))), (Class_Automattic_WooCommerce_Vendor_GraphQL_Language_DirectiveLocation.input_object()).str())
			rt.call_method(this.inputObjectCircularRefs, 'validate', [var_type.clone()])
		} else {
			rt.call_function('assert', [rt.new_bool(rt.instance_of(var_type, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ScalarType')), rt.new_string('only remaining option')])
			this.validatedirectivesatlocation(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeList](this.getdirectives(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_object](var_type))), (Class_Automattic_WooCommerce_Vendor_GraphQL_Language_DirectiveLocation.scalar()).str())
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_SchemaValidationContext) validatedirectivesatlocation(mut var_directives Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeList, location string) {
	mut var_directives_mutated := var_directives
	mut var_potentiallyDuplicateDirectives := rt.new_array()
	mut var_schema := this.schema
	mut iter_7 := var_directives_mutated.iterator()
	for {
		item_7 := iter_7.next() or { break }
		mut var_directiveNode := item_7.val
		mut var_directiveName := rt.get_property(rt.get_property(var_directiveNode, 'name'), 'value')
		mut var_schemaDirective := rt.call_method(var_schema, 'getDirective', [var_directiveName.clone()])
		if rt.is_true(rt.identical(var_schemaDirective, rt.new_null())) {
			this.reporterror("No directive @${var_directiveName.to_string()} defined.", var_directiveNode.clone())
			continue
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [rt.new_string(location), rt.get_property(var_schemaDirective, 'locations'), rt.new_bool(true)]))))) {
			this.reporterror("Directive @${var_directiveName.to_string()} not allowed at ${var_location} location.", rt.call_function('array_filter', [rt.create_array([rt.ArrayItem{ key: none, val: var_directiveNode }, rt.ArrayItem{ key: none, val: rt.get_property(var_schemaDirective, 'astNode') }])]))
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.get_property(var_schemaDirective, 'isRepeatable'))))) {
			var_potentiallyDuplicateDirectives.array_get_mut(var_directiveName).array_push(var_directiveNode.clone())
		}
	}
	mut iter_8 := var_potentiallyDuplicateDirectives.iterator()
	for {
		item_8 := iter_8.next() or { break }
		mut var_directiveList := item_8.val
		mut var_directiveName := item_8.key
		if var_directiveList.clone().array_count() > 1 {
			this.reporterror("Non-repeatable directive @${var_directiveName.to_string()} used more than once at the same location.", var_directiveList.clone())
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_SchemaValidationContext) validatefields(mut var_type Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type) {
	mut var_type_mutated := var_type
	mut var_fieldMap := rt.call_method(var_type_mutated, 'getFields', []rt.PhpVal{})
	if rt.is_true(rt.identical(var_fieldMap, rt.new_array())) {
		this.reporterror(rt.concat(rt.concat(rt.new_string('Type '), rt.get_property(var_type_mutated, 'name')), rt.new_string(' must define one or more fields.')), this.getallnodes(mut var_type_mutated))
	}
	mut iter_9 := var_fieldMap.iterator()
	for {
		item_9 := iter_9.next() or { break }
		mut var_field := item_9.val
		mut var_fieldName := item_9.key
		this.validatename(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_object](var_field))
		mut var_fieldNodes := this.getallfieldnodes(mut var_type_mutated, (var_fieldName).str())
		if var_fieldNodes.clone().array_count() > 1 {
			this.reporterror(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('Field '), rt.get_property(var_type_mutated, 'name')), rt.new_string('.')), var_fieldName), rt.new_string(' can only be defined once.')), var_fieldNodes.clone())
			continue
		}
		mut var_fieldType := rt.call_method(var_field, 'getType', []rt.PhpVal{})
		mut iife_temp_6 := Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type{}
		mut iife_result_6 := iife_temp_6.isoutputtype(var_fieldType.clone())
		if rt.is_true(rt.new_bool(!(rt.is_true(iife_result_6)))) {
			mut iife_temp_7 := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils{}
			mut iife_result_7 := iife_temp_7.printsafe(var_fieldType.clone())
			mut var_safeFieldType := iife_result_7
			this.reporterror(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('The type of '), rt.get_property(var_type_mutated, 'name')), rt.new_string('.')), var_fieldName), rt.new_string(' must be Output Type but got: ')), var_safeFieldType), rt.new_string('.')), this.getfieldtypenode(mut var_type_mutated, (var_fieldName).str()))
		}
		this.validatetypeissingleton(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type](var_fieldType), rt.concat(rt.concat(rt.get_property(var_type_mutated, 'name'), rt.new_string('.')), var_fieldName))
		mut var_argNames := rt.new_array()
		mut iter_10 := rt.get_property(var_field, 'args').iterator()
		for {
			item_10 := iter_10.next() or { break }
			mut var_arg := item_10.val
			mut var_argName := rt.get_property(var_arg, 'name')
			mut var_argPath := rt.new_string((rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.get_property(var_type_mutated, 'name'), rt.new_string('.')), var_fieldName), rt.new_string('(')), var_argName), rt.new_string(':)'))).str())
			this.validatename(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_object](var_arg))
			if var_argNames.array_isset(var_argName) {
				this.reporterror("Field argument ${var_argPath.to_string()} can only be defined once.", this.getallfieldargnodes(mut var_type_mutated, (var_fieldName).str(), (var_argName).str()))
			}
			var_argNames.array_set(var_argName, true)
			mut var_argType := rt.call_method(var_arg, 'getType', []rt.PhpVal{})
			mut iife_temp_8 := Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type{}
			mut iife_result_8 := iife_temp_8.isinputtype(var_argType.clone())
			if rt.is_true(rt.new_bool(!(rt.is_true(iife_result_8)))) {
				mut iife_temp_9 := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils{}
				mut iife_result_9 := iife_temp_9.printsafe(var_argType.clone())
				mut var_safeType := iife_result_9
				this.reporterror("The type of ${var_argPath.to_string()} must be Input Type but got: ${var_safeType.to_string()}.", this.getfieldargtypenode(mut var_type_mutated, (var_fieldName).str(), (var_argName).str()))
			}
			this.validatetypeissingleton(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type](var_argType), (var_argPath).str())
			if !(rt.get_property(rt.get_property(var_arg, 'astNode'), 'directives')).is_null() {
				this.validatedirectivesatlocation(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeList](rt.get_property(rt.get_property(var_arg, 'astNode'), 'directives')), (Class_Automattic_WooCommerce_Vendor_GraphQL_Language_DirectiveLocation.argument_definition()).str())
			}
		}
		if !(rt.get_property(rt.get_property(var_field, 'astNode'), 'directives')).is_null() {
			this.validatedirectivesatlocation(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeList](rt.get_property(rt.get_property(var_field, 'astNode'), 'directives')), (Class_Automattic_WooCommerce_Vendor_GraphQL_Language_DirectiveLocation.field_definition()).str())
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_SchemaValidationContext) getallnodes(mut var_obj Class_Automattic_WooCommerce_Vendor_GraphQL_Type_object) rt.PhpVal {
	mut var_astNode := rt.get_property(var_obj, 'astNode')
	if rt.is_true(rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_object', []string{}, var_obj), 'Automattic_WooCommerce_Vendor_GraphQL_Type_Schema'))) {
	mut var_extensionNodes := rt.get_property(var_obj, 'extensionASTNodes')
	} else if rt.is_true(rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_object', []string{}, var_obj), 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Directive'))) {
	var_extensionNodes = rt.new_array()
	} else {
	var_extensionNodes = rt.get_property(var_obj, 'extensionASTNodes')
	}
	mut var_allNodes := if rt.is_true(rt.identical(var_astNode, rt.new_null())) { rt.new_array() } else { rt.create_array([rt.ArrayItem{ key: none, val: var_astNode }]) }
	mut iter_11 := var_extensionNodes.iterator()
	for {
		item_11 := iter_11.next() or { break }
		mut var_extensionNode := item_11.val
		var_allNodes.array_push(var_extensionNode.clone())
	}
	return var_allNodes.clone()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_SchemaValidationContext) getallfieldnodes(mut var_type Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type, fieldName string) rt.PhpVal {
	mut var_type_mutated := var_type
	mut var_allNodes := rt.call_function('array_filter', [rt.create_array([rt.ArrayItem{ key: none, val: rt.get_property(var_type_mutated, 'astNode') }, rt.ArrayItem{ key: none, val: rt.get_property(var_type_mutated, 'extensionASTNodes') }])])
	mut var_matchingFieldNodes := rt.new_array()
	mut iter_12 := var_allNodes.iterator()
	for {
		item_12 := iter_12.next() or { break }
		mut var_node := item_12.val
		mut iter_13 := rt.get_property(var_node, 'fields').iterator()
		for {
			item_13 := iter_13.next() or { break }
			mut var_field := item_13.val
			if rt.is_true(rt.identical(rt.get_property(rt.get_property(var_field, 'name'), 'value'), rt.new_string(fieldName))) {
				var_matchingFieldNodes.array_push(var_field.clone())
			}
		}
	}
	return var_matchingFieldNodes.clone()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_SchemaValidationContext) getfieldtypenode(mut var_type Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type, fieldName string) rt.PhpVal {
	mut var_type_mutated := var_type
	mut var_fieldNode := this.getfieldnode(mut var_type_mutated, fieldName)
	return if rt.is_true(rt.identical(var_fieldNode, rt.new_null())) { rt.new_null() } else { rt.get_property(var_fieldNode, 'type') }
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_SchemaValidationContext) getfieldnode(mut var_type Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type, fieldName string) rt.PhpVal {
	mut var_type_mutated := var_type
	mut var_nodes := this.getallfieldnodes(mut var_type_mutated, fieldName)
	return if !(var_nodes.array_get(rt.new_int(0))).is_null() { var_nodes.array_get(rt.new_int(0)) } else { rt.new_null() }
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_SchemaValidationContext) getallfieldargnodes(mut var_type Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type, fieldName string, argName string) rt.PhpVal {
	mut var_type_mutated := var_type
	mut argName_mutated := argName
	mut var_argNodes := rt.new_array()
	mut var_fieldNode := this.getfieldnode(mut var_type_mutated, fieldName)
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_fieldNode, rt.new_null())))) {
		mut iter_14 := rt.get_property(var_fieldNode, 'arguments').iterator()
		for {
			item_14 := iter_14.next() or { break }
			mut var_node := item_14.val
			if rt.is_true(rt.identical(rt.get_property(rt.get_property(var_node, 'name'), 'value'), rt.new_string(argName_mutated))) {
				var_argNodes.array_push(var_node.clone())
			}
		}
	}
	return var_argNodes.clone()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_SchemaValidationContext) getfieldargtypenode(mut var_type Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type, fieldName string, argName string) rt.PhpVal {
	mut var_type_mutated := var_type
	mut argName_mutated := argName
	mut var_fieldArgNode := this.getfieldargnode(mut var_type_mutated, fieldName, argName_mutated)
	return if rt.is_true(rt.identical(var_fieldArgNode, rt.new_null())) { rt.new_null() } else { rt.get_property(var_fieldArgNode, 'type') }
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_SchemaValidationContext) getfieldargnode(mut var_type Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type, fieldName string, argName string) rt.PhpVal {
	mut var_type_mutated := var_type
	mut argName_mutated := argName
	mut var_nodes := this.getallfieldargnodes(mut var_type_mutated, fieldName, argName_mutated)
	return if !(var_nodes.array_get(rt.new_int(0))).is_null() { var_nodes.array_get(rt.new_int(0)) } else { rt.new_null() }
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_SchemaValidationContext) validateinterfaces(mut var_type Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ImplementingType) {
	mut var_type_mutated := var_type
	mut var_ifaceTypeNames := rt.new_array()
	mut iter_15 := rt.call_method(var_type_mutated, 'getInterfaces', []rt.PhpVal{}).iterator()
	for {
		item_15 := iter_15.next() or { break }
		mut var_interface := item_15.val
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_interface, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InterfaceType')))))) {
			mut iife_temp_10 := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils{}
			mut iife_result_10 := iife_temp_10.printsafe(var_interface.clone())
			mut var_notInterface := iife_result_10
			this.reporterror(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('Type '), rt.get_property(var_type_mutated, 'name')), rt.new_string(' must only implement Interface types, it cannot implement ')), var_notInterface), rt.new_string('.')), this.getimplementsinterfacenode(mut var_type_mutated, mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_NamedType](var_interface)))
			continue
		}
		if rt.is_true(rt.identical(var_type_mutated, var_interface)) {
			this.reporterror(rt.concat(rt.concat(rt.new_string('Type '), rt.get_property(var_type_mutated, 'name')), rt.new_string(' cannot implement itself because it would create a circular reference.')), this.getimplementsinterfacenode(mut var_type_mutated, mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_NamedType](var_interface)))
			continue
		}
		if var_ifaceTypeNames.array_isset(rt.get_property(var_interface, 'name')) {
			this.reporterror(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('Type '), rt.get_property(var_type_mutated, 'name')), rt.new_string(' can only implement ')), rt.get_property(var_interface, 'name')), rt.new_string(' once.')), this.getallimplementsinterfacenodes(mut var_type_mutated, mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_NamedType](var_interface)))
			continue
		}
		var_ifaceTypeNames.array_set(rt.get_property(var_interface, 'name'), true)
		this.validatetypeimplementsancestors(mut var_type_mutated, mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InterfaceType](var_interface))
		this.validatetypeimplementsinterface(mut var_type_mutated, mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InterfaceType](var_interface))
	}
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_SchemaValidationContext) getdirectives(mut var_object Class_Automattic_WooCommerce_Vendor_GraphQL_Type_object) rt.PhpVal {
	mut var_directives := rt.new_array()
	mut iter_16 := this.getallnodes(mut var_object).iterator()
	for {
		item_16 := iter_16.next() or { break }
		mut var_node := item_16.val
		mut iter_17 := rt.get_property(var_node, 'directives').iterator()
		for {
			item_17 := iter_17.next() or { break }
			mut var_directive := item_17.val
			var_directives.array_push(var_directive.clone())
		}
	}
	return rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeList', []string{}, create_automattic_woocommerce_vendor_graphql_language_ast_nodelist(var_directives.clone()))
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_SchemaValidationContext) getimplementsinterfacenode(mut var_type Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ImplementingType, mut var_shouldBeInterface Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_NamedType) rt.PhpVal {
	mut var_type_mutated := var_type
	mut var_nodes := this.getallimplementsinterfacenodes(mut var_type_mutated, mut var_shouldBeInterface)
	return if !(var_nodes.array_get(rt.new_int(0))).is_null() { var_nodes.array_get(rt.new_int(0)) } else { rt.new_null() }
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_SchemaValidationContext) getallimplementsinterfacenodes(mut var_type Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ImplementingType, mut var_shouldBeInterface Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_NamedType) rt.PhpVal {
	mut var_type_mutated := var_type
	mut var_allNodes := rt.call_function('array_filter', [rt.create_array([rt.ArrayItem{ key: none, val: rt.get_property(var_type_mutated, 'astNode') }, rt.ArrayItem{ key: none, val: rt.get_property(var_type_mutated, 'extensionASTNodes') }])])
	mut var_shouldBeInterfaceName := rt.get_property(var_shouldBeInterface, 'name')
	mut var_matchingInterfaceNodes := rt.new_array()
	mut iter_18 := var_allNodes.iterator()
	for {
		item_18 := iter_18.next() or { break }
		mut var_node := item_18.val
		mut iter_19 := rt.get_property(var_node, 'interfaces').iterator()
		for {
			item_19 := iter_19.next() or { break }
			mut var_interface := item_19.val
			if rt.is_true(rt.identical(rt.get_property(rt.get_property(var_interface, 'name'), 'value'), var_shouldBeInterfaceName)) {
				var_matchingInterfaceNodes.array_push(var_interface.clone())
			}
		}
	}
	return var_matchingInterfaceNodes.clone()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_SchemaValidationContext) validatetypeimplementsinterface(mut var_type Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ImplementingType, mut var_iface Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InterfaceType) {
	mut var_type_mutated := var_type
	mut var_typeFieldMap := rt.call_method(var_type_mutated, 'getFields', []rt.PhpVal{})
	mut var_ifaceFieldMap := var_iface.getfields()
	mut iter_20 := var_ifaceFieldMap.iterator()
	for {
		item_20 := iter_20.next() or { break }
		mut var_ifaceField := item_20.val
		mut var_fieldName := item_20.key
		mut var_typeField := if !(var_typeFieldMap.array_get(var_fieldName)).is_null() { var_typeFieldMap.array_get(var_fieldName) } else { rt.new_null() }
		if rt.is_true(rt.identical(var_typeField, rt.new_null())) {
			this.reporterror(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('Interface field '), rt.get_property(var_iface, 'name')), rt.new_string('.')), var_fieldName), rt.new_string(' expected but ')), rt.get_property(var_type_mutated, 'name')), rt.new_string(' does not provide it.')), rt.call_function('array_merge', [rt.create_array([rt.ArrayItem{ key: none, val: this.getfieldnode(mut var_iface, (var_fieldName).str()) }]), this.getallnodes(mut var_type_mutated)]))
			continue
		}
		mut var_typeFieldType := rt.call_method(var_typeField, 'getType', []rt.PhpVal{})
		mut var_ifaceFieldType := rt.call_method(var_ifaceField, 'getType', []rt.PhpVal{})
		mut iife_temp_11 := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_TypeComparators{}
		mut iife_result_11 := iife_temp_11.istypesubtypeof(this.schema, var_typeFieldType.clone(), var_ifaceFieldType.clone())
		if rt.is_true(rt.new_bool(!(rt.is_true(iife_result_11)))) {
			this.reporterror(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('Interface field '), rt.get_property(var_iface, 'name')), rt.new_string('.')), var_fieldName), rt.new_string(' expects type ')), var_ifaceFieldType), rt.new_string(' but ')), rt.get_property(var_type_mutated, 'name')), rt.new_string('.')), var_fieldName), rt.new_string(' is type ')), var_typeFieldType), rt.new_string('.')), rt.create_array([rt.ArrayItem{ key: none, val: this.getfieldtypenode(mut var_iface, (var_fieldName).str()) }, rt.ArrayItem{ key: none, val: this.getfieldtypenode(mut var_type_mutated, (var_fieldName).str()) }]))
		}
		mut iter_21 := rt.get_property(var_ifaceField, 'args').iterator()
		for {
			item_21 := iter_21.next() or { break }
			mut var_ifaceArg := item_21.val
			mut var_argName := rt.get_property(var_ifaceArg, 'name')
			mut var_typeArg := rt.call_method(var_typeField, 'getArg', [var_argName.clone()])
			if rt.is_true(rt.identical(var_typeArg, rt.new_null())) {
				this.reporterror(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('Interface field argument '), rt.get_property(var_iface, 'name')), rt.new_string('.')), var_fieldName), rt.new_string('(')), var_argName), rt.new_string(':) expected but ')), rt.get_property(var_type_mutated, 'name')), rt.new_string('.')), var_fieldName), rt.new_string(' does not provide it.')), rt.create_array([rt.ArrayItem{ key: none, val: this.getfieldargnode(mut var_iface, (var_fieldName).str(), (var_argName).str()) }, rt.ArrayItem{ key: none, val: this.getfieldnode(mut var_type_mutated, (var_fieldName).str()) }]))
				continue
			}
			mut var_ifaceArgType := rt.call_method(var_ifaceArg, 'getType', []rt.PhpVal{})
			mut var_typeArgType := rt.call_method(var_typeArg, 'getType', []rt.PhpVal{})
			mut iife_temp_12 := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_TypeComparators{}
			mut iife_result_12 := iife_temp_12.isequaltype(var_ifaceArgType.clone(), var_typeArgType.clone())
			if rt.is_true(rt.new_bool(!(rt.is_true(iife_result_12)))) {
				this.reporterror(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('Interface field argument '), rt.get_property(var_iface, 'name')), rt.new_string('.')), var_fieldName), rt.new_string('(')), var_argName), rt.new_string(':) expects type ')), var_ifaceArgType), rt.new_string(' but ')), rt.get_property(var_type_mutated, 'name')), rt.new_string('.')), var_fieldName), rt.new_string('(')), var_argName), rt.new_string(':) is type ')), var_typeArgType), rt.new_string('.')), rt.create_array([rt.ArrayItem{ key: none, val: this.getfieldargtypenode(mut var_iface, (var_fieldName).str(), (var_argName).str()) }, rt.ArrayItem{ key: none, val: this.getfieldargtypenode(mut var_type_mutated, (var_fieldName).str(), (var_argName).str()) }]))
			}
		}
		mut iter_22 := rt.get_property(var_typeField, 'args').iterator()
		for {
			item_22 := iter_22.next() or { break }
			mut var_typeArg := item_22.val
			mut var_argName := rt.get_property(var_typeArg, 'name')
			mut var_ifaceArg := rt.call_method(var_ifaceField, 'getArg', [var_argName.clone()])
			if rt.is_true(rt.call_method(var_typeArg, 'isRequired', []rt.PhpVal{})) && rt.is_true(rt.identical(var_ifaceArg, rt.new_null())) {
				this.reporterror(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('Object field '), rt.get_property(var_type_mutated, 'name')), rt.new_string('.')), var_fieldName), rt.new_string(' includes required argument ')), var_argName), rt.new_string(' that is missing from the Interface field ')), rt.get_property(var_iface, 'name')), rt.new_string('.')), var_fieldName), rt.new_string('.')), rt.create_array([rt.ArrayItem{ key: none, val: this.getfieldargnode(mut var_type_mutated, (var_fieldName).str(), (var_argName).str()) }, rt.ArrayItem{ key: none, val: this.getfieldnode(mut var_iface, (var_fieldName).str()) }]))
			}
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_SchemaValidationContext) validatetypeimplementsancestors(mut var_type Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ImplementingType, mut var_iface Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InterfaceType) {
	mut var_type_mutated := var_type
	mut var_typeInterfaces := rt.call_method(var_type_mutated, 'getInterfaces', []rt.PhpVal{})
	mut iter_23 := var_iface.getinterfaces().iterator()
	for {
		item_23 := iter_23.next() or { break }
		mut var_transitive := item_23.val
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_transitive.clone(), var_typeInterfaces.clone(), rt.new_bool(true)]))))) {
			this.reporterror(if rt.is_true(rt.identical(var_transitive, var_type_mutated)) { rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('Type '), rt.get_property(var_type_mutated, 'name')), rt.new_string(' cannot implement ')), rt.get_property(var_iface, 'name')), rt.new_string(' because it would create a circular reference.')) } else { rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('Type '), rt.get_property(var_type_mutated, 'name')), rt.new_string(' must implement ')), rt.get_property(var_transitive, 'name')), rt.new_string(' because it is implemented by ')), rt.get_property(var_iface, 'name')), rt.new_string('.')) }, rt.call_function('array_merge', [this.getallimplementsinterfacenodes(mut var_iface, mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_NamedType](var_transitive)), this.getallimplementsinterfacenodes(mut var_type_mutated, mut var_iface)]))
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_SchemaValidationContext) validateunionmembers(mut var_union Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_UnionType) {
	mut var_memberTypes := var_union.gettypes()
	if rt.is_true(rt.identical(var_memberTypes, rt.new_array())) {
		this.reporterror(rt.concat(rt.concat(rt.new_string('Union type '), rt.get_property(var_union, 'name')), rt.new_string(' must define one or more member types.')), this.getallnodes(mut var_union))
	}
	mut var_includedTypeNames := rt.new_array()
	mut iter_24 := var_memberTypes.iterator()
	for {
		item_24 := iter_24.next() or { break }
		mut var_memberType := item_24.val
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_memberType, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ObjectType')))))) {
			mut iife_temp_13 := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils{}
			mut iife_result_13 := iife_temp_13.printsafe(var_memberType.clone())
			mut var_notObjectType := iife_result_13
			this.reporterror(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('Union type '), rt.get_property(var_union, 'name')), rt.new_string(' can only include Object types, it cannot include ')), var_notObjectType), rt.new_string('.')), this.getunionmembertypenodes(mut var_union, (var_notObjectType).str()))
			continue
		}
		if var_includedTypeNames.array_isset(rt.get_property(var_memberType, 'name')) {
			this.reporterror(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('Union type '), rt.get_property(var_union, 'name')), rt.new_string(' can only include type ')), rt.get_property(var_memberType, 'name')), rt.new_string(' once.')), this.getunionmembertypenodes(mut var_union, (rt.get_property(var_memberType, 'name')).str()))
			continue
		}
		var_includedTypeNames.array_set(rt.get_property(var_memberType, 'name'), true)
	}
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_SchemaValidationContext) getunionmembertypenodes(mut var_union Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_UnionType, typeName string) rt.PhpVal {
	mut var_allNodes := rt.call_function('array_filter', [rt.create_array([rt.ArrayItem{ key: none, val: rt.get_property(var_union, 'astNode') }, rt.ArrayItem{ key: none, val: rt.get_property(var_union, 'extensionASTNodes') }])])
	mut var_types := rt.new_array()
	mut iter_25 := var_allNodes.iterator()
	for {
		item_25 := iter_25.next() or { break }
		mut var_node := item_25.val
		mut iter_26 := rt.get_property(var_node, 'types').iterator()
		for {
			item_26 := iter_26.next() or { break }
			mut var_type := item_26.val
			if rt.is_true(rt.identical(rt.get_property(rt.get_property(var_type, 'name'), 'value'), rt.new_string(typeName))) {
				var_types.array_push(var_type.clone())
			}
		}
	}
	return var_types.clone()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_SchemaValidationContext) validateenumvalues(mut var_enumType Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_EnumType) {
	mut var_enumValues := var_enumType.getvalues()
	if rt.is_true(rt.identical(var_enumValues, rt.new_array())) {
		this.reporterror(rt.concat(rt.concat(rt.new_string('Enum type '), rt.get_property(var_enumType, 'name')), rt.new_string(' must define one or more values.')), this.getallnodes(mut var_enumType))
	}
	mut iter_27 := var_enumValues.iterator()
	for {
		item_27 := iter_27.next() or { break }
		mut var_enumValue := item_27.val
		mut var_valueName := rt.get_property(var_enumValue, 'name')
		this.validatename(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_object](var_enumValue))
		if rt.is_true(rt.call_function('in_array', [var_valueName.clone(), rt.create_array([rt.ArrayItem{ key: none, val: 'true' }, rt.ArrayItem{ key: none, val: 'false' }, rt.ArrayItem{ key: none, val: 'null' }]), rt.new_bool(true)])) {
			this.reporterror(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('Enum type '), rt.get_property(var_enumType, 'name')), rt.new_string(' cannot include value: ')), var_valueName), rt.new_string('.')), rt.get_property(var_enumValue, 'astNode'))
		}
		if !(rt.get_property(var_enumValue, 'astNode')).is_null() && !(rt.get_property(rt.get_property(var_enumValue, 'astNode'), 'directives')).is_null() {
			this.validatedirectivesatlocation(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeList](rt.get_property(rt.get_property(var_enumValue, 'astNode'), 'directives')), (Class_Automattic_WooCommerce_Vendor_GraphQL_Language_DirectiveLocation.enum_value()).str())
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_SchemaValidationContext) validateinputfields(mut var_inputObj Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InputObjectType) {
	mut var_fieldMap := var_inputObj.getfields()
	if rt.is_true(rt.identical(var_fieldMap, rt.new_array())) {
		this.reporterror(rt.concat(rt.concat(rt.new_string('Input Object type '), rt.get_property(var_inputObj, 'name')), rt.new_string(' must define one or more fields.')), this.getallnodes(mut var_inputObj))
	}
	mut iter_28 := var_fieldMap.iterator()
	for {
		item_28 := iter_28.next() or { break }
		mut var_field := item_28.val
		mut var_fieldName := item_28.key
		this.validatename(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_object](var_field))
		mut var_type := rt.call_method(var_field, 'getType', []rt.PhpVal{})
		mut iife_temp_14 := Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type{}
		mut iife_result_14 := iife_temp_14.isinputtype(var_type.clone())
		if rt.is_true(rt.new_bool(!(rt.is_true(iife_result_14)))) {
			mut iife_temp_15 := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils{}
			mut iife_result_15 := iife_temp_15.printsafe(var_type.clone())
			mut var_notInputType := iife_result_15
			this.reporterror(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('The type of '), rt.get_property(var_inputObj, 'name')), rt.new_string('.')), var_fieldName), rt.new_string(' must be Input Type but got: ')), var_notInputType), rt.new_string('.')), if !(rt.get_property(rt.get_property(var_field, 'astNode'), 'type')).is_null() { rt.get_property(rt.get_property(var_field, 'astNode'), 'type') } else { rt.new_null() })
		}
		if !(rt.get_property(var_field, 'astNode')).is_null() && !(rt.get_property(rt.get_property(var_field, 'astNode'), 'directives')).is_null() {
			this.validatedirectivesatlocation(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeList](rt.get_property(rt.get_property(var_field, 'astNode'), 'directives')), (Class_Automattic_WooCommerce_Vendor_GraphQL_Language_DirectiveLocation.input_field_definition()).str())
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_SchemaValidationContext) validatetypeissingleton(mut var_type Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type, path string) {
	mut var_type_mutated := var_type
	mut var_schemaConfig := rt.call_method(this.schema, 'getConfig', []rt.PhpVal{})
	if !(!(rt.get_property(var_schemaConfig, 'typeLoader')).is_null()) {
		return
	}
	mut iife_temp_16 := Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type{}
	mut iife_result_16 := iife_temp_16.getnamedtype(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type', []string{}, var_type_mutated))
	mut var_namedType := iife_result_16
	if rt.is_true(rt.call_method(var_namedType, 'isBuiltInType', []rt.PhpVal{})) {
		return
	}
	mut var_name := rt.get_property(var_namedType, 'name')
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_namedType, rt.call_callable(rt.get_property(var_schemaConfig, 'typeLoader'), [var_name.clone()]))))) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Error_InvariantViolation', []string{}, create_automattic_woocommerce_vendor_graphql_error_invariantviolation(Class_Automattic_WooCommerce_Vendor_GraphQL_Type_SchemaValidationContext.duplicatetype(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema](this.schema), path, (var_name).str()))))
	}
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Type_SchemaValidationContext.duplicatetype(mut var_schema Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema, path string, name string) string {
	mut var_schema_mutated := var_schema
	mut name_mutated := name
	mut var_hint := rt.new_string((if !(rt.get_property(rt.call_method(var_schema_mutated, 'getConfig', []rt.PhpVal{}), 'typeLoader')).is_null() { 'Ensure the type loader returns the same instance. ' } else { '' }).str())
	return "Found duplicate type in schema at ${var_path}: ${var_name.to_string()}. ${var_hint.to_string()}See https://webonyx.github.io/graphql-php/type-definitions/#type-registry."
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Validation_InputObjectCircularRefs {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Error {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Introspection {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeList {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_TypeComparators {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Error_InvariantViolation {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_vendor_graphql_type_schemavalidationcontext(arg_0 rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_SchemaValidationContext {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_SchemaValidationContext{
		PhpObjectBase: rt.PhpObjectBase{}
		errors: rt.new_array()
		schema: rt.new_null()
		inputObjectCircularRefs: rt.new_null()
	}
	obj.construct(arg_0)
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_type_validation_inputobjectcircularrefs(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Validation_InputObjectCircularRefs {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Validation_InputObjectCircularRefs{
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

fn create_automattic_woocommerce_vendor_graphql_type_definition_type(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type{
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

fn create_automattic_woocommerce_vendor_graphql_language_ast_nodelist(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeList {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeList{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_utils_typecomparators(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_TypeComparators {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_TypeComparators{
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

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_SchemaValidationContext) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema](if args.len > 0 { args[0] } else { rt.new_null() })
			this.construct(mut dispatch_arg_0)
			return rt.new_null()
		}
		'getErrors' {
			return this.geterrors()
		}
		'validateRootTypes' {
			this.validateroottypes()
			return rt.new_null()
		}
		'reportError' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.reporterror(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'addError' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Error](if args.len > 0 { args[0] } else { rt.new_null() })
			this.adderror(mut dispatch_arg_0)
			return rt.new_null()
		}
		'validateDirectives' {
			this.validatedirectives()
			return rt.new_null()
		}
		'validateDirectiveDefinitions' {
			this.validatedirectivedefinitions()
			return rt.new_null()
		}
		'validateName' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_object](if args.len > 0 { args[0] } else { rt.new_null() })
			this.validatename(mut dispatch_arg_0)
			return rt.new_null()
		}
		'getAllDirectiveArgNodes' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Directive](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return this.getalldirectiveargnodes(mut dispatch_arg_0, dispatch_arg_1)
		}
		'getDirectiveArgTypeNode' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Directive](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return this.getdirectiveargtypenode(mut dispatch_arg_0, dispatch_arg_1)
		}
		'validateTypes' {
			this.validatetypes()
			return rt.new_null()
		}
		'validateDirectivesAtLocation' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeList](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			this.validatedirectivesatlocation(mut dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'validateFields' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type](if args.len > 0 { args[0] } else { rt.new_null() })
			this.validatefields(mut dispatch_arg_0)
			return rt.new_null()
		}
		'getAllNodes' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_object](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.getallnodes(mut dispatch_arg_0)
		}
		'getAllFieldNodes' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return this.getallfieldnodes(mut dispatch_arg_0, dispatch_arg_1)
		}
		'getFieldTypeNode' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return this.getfieldtypenode(mut dispatch_arg_0, dispatch_arg_1)
		}
		'getFieldNode' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return this.getfieldnode(mut dispatch_arg_0, dispatch_arg_1)
		}
		'getAllFieldArgNodes' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			return this.getallfieldargnodes(mut dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'getFieldArgTypeNode' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			return this.getfieldargtypenode(mut dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'getFieldArgNode' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			return this.getfieldargnode(mut dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'validateInterfaces' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ImplementingType](if args.len > 0 { args[0] } else { rt.new_null() })
			this.validateinterfaces(mut dispatch_arg_0)
			return rt.new_null()
		}
		'getDirectives' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_object](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.getdirectives(mut dispatch_arg_0)
		}
		'getImplementsInterfaceNode' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ImplementingType](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_NamedType](if args.len > 1 { args[1] } else { rt.new_null() })
			return this.getimplementsinterfacenode(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		'getAllImplementsInterfaceNodes' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ImplementingType](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_NamedType](if args.len > 1 { args[1] } else { rt.new_null() })
			return this.getallimplementsinterfacenodes(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		'validateTypeImplementsInterface' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ImplementingType](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InterfaceType](if args.len > 1 { args[1] } else { rt.new_null() })
			this.validatetypeimplementsinterface(mut dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'validateTypeImplementsAncestors' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ImplementingType](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InterfaceType](if args.len > 1 { args[1] } else { rt.new_null() })
			this.validatetypeimplementsancestors(mut dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'validateUnionMembers' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_UnionType](if args.len > 0 { args[0] } else { rt.new_null() })
			this.validateunionmembers(mut dispatch_arg_0)
			return rt.new_null()
		}
		'getUnionMemberTypeNodes' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_UnionType](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return this.getunionmembertypenodes(mut dispatch_arg_0, dispatch_arg_1)
		}
		'validateEnumValues' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_EnumType](if args.len > 0 { args[0] } else { rt.new_null() })
			this.validateenumvalues(mut dispatch_arg_0)
			return rt.new_null()
		}
		'validateInputFields' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InputObjectType](if args.len > 0 { args[0] } else { rt.new_null() })
			this.validateinputfields(mut dispatch_arg_0)
			return rt.new_null()
		}
		'validateTypeIsSingleton' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			this.validatetypeissingleton(mut dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'duplicateType' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			return rt.new_string(Class_Automattic_WooCommerce_Vendor_GraphQL_Type_SchemaValidationContext.duplicatetype(mut dispatch_arg_0, dispatch_arg_1, dispatch_arg_2))
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_SchemaValidationContext) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'errors' { return this.errors }
		'schema' { return this.schema }
		'inputObjectCircularRefs' { return this.inputObjectCircularRefs }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_SchemaValidationContext) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'errors' { this.errors = val; return true }
		'schema' { this.schema = val; return true }
		'inputObjectCircularRefs' { this.inputObjectCircularRefs = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Validation_InputObjectCircularRefs) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Validation_InputObjectCircularRefs) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Validation_InputObjectCircularRefs) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeList) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeList) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeList) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_TypeComparators) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_TypeComparators) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_TypeComparators) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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
