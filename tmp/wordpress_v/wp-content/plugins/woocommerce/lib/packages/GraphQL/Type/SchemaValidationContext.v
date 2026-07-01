import rt

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Type_SchemaValidationContext {
	rt.PhpObjectBase
pub mut:
		errors rt.PhpVal = rt.new_array()
		schema rt.PhpVal = rt.new_null()
		inputObjectCircularRefs rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_SchemaValidationContext) construct(mut var_schema Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema)  {
	mut var_schema_mutated := var_schema
	this.schema = var_schema_mutated.dup()
	this.inputObjectCircularRefs = create_automattic_woocommerce_vendor_graphql_type_validation_inputobjectcircularrefs(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_SchemaValidationContext', []string{}, &this).dup())
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_SchemaValidationContext) geterrors() rt.PhpVal {
	return this.errors
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_SchemaValidationContext) validateroottypes()  {
	if rt.is_true(rt.identical(rt.call_method(this.schema, 'getQueryType', []rt.PhpVal{}), rt.new_null())) {
		this.reporterror('Query root type must be provided.', rt.get_property(this.schema, 'astNode'))
	}
	rt.call_method(this.schema, 'getMutationType', []rt.PhpVal{})
	rt.call_method(this.schema, 'getSubscriptionType', []rt.PhpVal{})
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_SchemaValidationContext) reporterror(message string, var_nodes rt.PhpVal)  {
	mut var_nodes_mutated := var_nodes
	var_nodes_mutated = rt.call_function('array_filter', [if rt.is_true(rt.new_bool(var_nodes_mutated.dup().is_array())) { var_nodes_mutated } else { rt.create_array([rt.ArrayItem{ key: none, val: var_nodes_mutated }]) }])
	this.adderror(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Error](create_automattic_woocommerce_vendor_graphql_error_error(rt.new_string(message).dup(), var_nodes_mutated.dup())))
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_SchemaValidationContext) adderror(mut var_error Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Error)  {
	mut var_error_mutated := var_error
	this.errors.array_push(var_error_mutated.dup())
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_SchemaValidationContext) validatedirectives()  {
	this.validatedirectivedefinitions()
	this.validatedirectivesatlocation(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeList](this.getdirectives(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_object](this.schema))), (Class_Automattic_WooCommerce_Vendor_GraphQL_Language_DirectiveLocation.schema()).str())
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_SchemaValidationContext) validatedirectivedefinitions()  {
	mut var_directiveDefinitions := rt.new_array()
	mut var_directives := rt.call_method(this.schema, 'getDirectives', []rt.PhpVal{})
	{
		mut iter_1 := var_directives.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_directive := item_1.val
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_directive, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Directive')))))) {
				mut var_notDirective := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils{}; return temp.printsafe(arg_0) }(var_directive.dup())
				mut var_nodes := if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_directive.dup().is_object())) && rt.is_true(rt.call_function('property_exists', [var_directive.dup(), rt.new_string('astNode')])))) { rt.get_property(var_directive, 'astNode') } else { rt.new_null() }
				this.reporterror("Expected directive but got: ${var_notDirective.to_string()}.", var_nodes.dup())
				continue
			}
			mut var_existingDefinitions := if !(var_directiveDefinitions.array_get(rt.get_property(var_directive, 'name'))).is_null() { var_directiveDefinitions.array_get(rt.get_property(var_directive, 'name')) } else { rt.new_array() }
			var_existingDefinitions.array_push(var_directive.dup())
			var_directiveDefinitions.array_set(rt.get_property(var_directive, 'name'), var_existingDefinitions.dup())
			this.validatename(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_object](var_directive))
			mut var_argNames := rt.new_array()
			{
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
					if rt.is_true(rt.new_bool(!(rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type{}; return temp.isinputtype(arg_0) }(rt.call_method(var_arg, 'getType', []rt.PhpVal{})))))) {
						mut var_type := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils{}; return temp.printsafe(arg_0) }(rt.call_method(var_arg, 'getType', []rt.PhpVal{}))
						this.reporterror(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('The type of @'), rt.get_property(var_directive, 'name')), rt.new_string('(')), var_argName), rt.new_string(':) must be Input Type but got: ')), var_type), rt.new_string('.')), this.getdirectiveargtypenode(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Directive](var_directive), (var_argName).str()))
					}
				}
			}
		}
	}
	{
		mut iter_1 := var_directiveDefinitions.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_directiveList := item_1.val
			mut var_directiveName := item_1.key
			if var_directiveList.dup().array_count() > 1 {
				mut var_nodes := rt.new_array()
				{
					mut iter_2 := var_directiveList.iterator()
					for {
						item_2 := iter_2.next() or { break }
						mut var_dir := item_2.val
						if !(rt.get_property(var_dir, 'astNode')).is_null() {
							var_nodes.array_push(rt.get_property(var_dir, 'astNode'))
						}
					}
				}
				this.reporterror("Directive @${var_directiveName.to_string()} defined multiple times.", var_nodes.dup())
			}
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_SchemaValidationContext) validatename(mut var_object Class_Automattic_WooCommerce_Vendor_GraphQL_Type_object)  {
	mut var_error := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils{}; return temp.isvalidnameerror(arg_0, arg_1) }(rt.get_property(var_object, 'name'), rt.get_property(var_object, 'astNode'))
	if rt.is_true(rt.new_bool(rt.is_true(rt.identical(var_error, rt.new_null())) || rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_object', []string{}, var_object), 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type'))) && rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Introspection{}; return temp.isintrospectiontype(arg_0) }(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_object', []string{}, var_object))))))) {
		return rt.new_null()
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
	{
		mut iter_1 := rt.get_property(var_astNode, 'arguments').iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_subNode := item_1.val
			if rt.is_true(rt.identical(rt.get_property(rt.get_property(var_subNode, 'name'), 'value'), rt.new_string(argName_mutated))) {
				var_matchingSubnodes.array_push(var_subNode.dup())
			}
		}
	}
	return var_matchingSubnodes.dup()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_SchemaValidationContext) getdirectiveargtypenode(mut var_directive Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Directive, argName string) rt.PhpVal {
	mut argName_mutated := argName
	mut var_argNode := if !(this.getalldirectiveargnodes(mut var_directive, argName_mutated).array_get(0)).is_null() { this.getalldirectiveargnodes(mut var_directive, argName_mutated).array_get(0) } else { rt.new_null() }
	return if rt.is_true(rt.identical(var_argNode, rt.new_null())) { rt.new_null() } else { rt.get_property(var_argNode, 'type') }
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_SchemaValidationContext) validatetypes()  {
	mut var_typeMap := rt.call_method(this.schema, 'getTypeMap', []rt.PhpVal{})
	{
		mut iter_1 := var_typeMap.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_type := item_1.val
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_type, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_NamedType')))))) {
				mut var_notNamedType := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils{}; return temp.printsafe(arg_0) }(var_type.dup())
				mut var_node := if rt.is_true(rt.new_bool(rt.instance_of(, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type'))) { rt.get_property(, 'astNode') } else { rt.new_null() }
				this.reporterror("Expected Automattic\\WooCommerce\\Vendor\\GraphQL named type but got: ${var_notNamedType.to_string()}.", var_node.dup())
				continue
			}
			this.validatename(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_object]())
			if rt.is_true() {
			} else if rt.is_true() {
			} else if rt.is_true() {
			} else if rt.is_true() {
			} else if rt.is_true() {
			} else {
			}
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_SchemaValidationContext) validatedirectivesatlocation(mut var_directives Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeList, location string)  {
	mut var_directives_mutated := var_directives
	
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_SchemaValidationContext) validatefields(mut var_type Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type)  {
	mut var_type_mutated := var_type
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_SchemaValidationContext) getallnodes(mut var_obj Class_Automattic_WooCommerce_Vendor_GraphQL_Type_object) rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_SchemaValidationContext) getallfieldnodes(mut var_type Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type, fieldName string) rt.PhpVal {
	mut var_type_mutated := var_type
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_SchemaValidationContext) getfieldtypenode(mut var_type Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type, fieldName string) rt.PhpVal {
	mut var_type_mutated := var_type
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_SchemaValidationContext) getfieldnode(mut var_type Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type, fieldName string) rt.PhpVal {
	mut var_type_mutated := var_type
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_SchemaValidationContext) getallfieldargnodes(mut var_type Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type, fieldName string, argName string) rt.PhpVal {
	mut var_type_mutated := var_type
	mut argName_mutated := argName
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_SchemaValidationContext) getfieldargtypenode(mut var_type Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type, fieldName string, argName string) rt.PhpVal {
	mut var_type_mutated := var_type
	mut argName_mutated := argName
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_SchemaValidationContext) getfieldargnode(mut var_type Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type, fieldName string, argName string) rt.PhpVal {
	mut var_type_mutated := var_type
	mut argName_mutated := argName
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_SchemaValidationContext) validateinterfaces(mut var_type Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ImplementingType)  {
	mut var_type_mutated := var_type
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_SchemaValidationContext) getdirectives(mut var_object Class_Automattic_WooCommerce_Vendor_GraphQL_Type_object) rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_SchemaValidationContext) getimplementsinterfacenode(mut var_type Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ImplementingType, mut var_shouldBeInterface Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_NamedType) rt.PhpVal {
	mut var_type_mutated := var_type
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_SchemaValidationContext) getallimplementsinterfacenodes(mut var_type Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ImplementingType, mut var_shouldBeInterface Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_NamedType) rt.PhpVal {
	mut var_type_mutated := var_type
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_SchemaValidationContext) validatetypeimplementsinterface(mut var_type Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ImplementingType, mut var_iface Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InterfaceType)  {
	mut var_type_mutated := var_type
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_SchemaValidationContext) validatetypeimplementsancestors(mut var_type Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ImplementingType, mut var_iface Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InterfaceType)  {
	mut var_type_mutated := var_type
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_SchemaValidationContext) validateunionmembers(mut var_union Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_UnionType)  {
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_SchemaValidationContext) getunionmembertypenodes(mut var_union Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_UnionType, typeName string) rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_SchemaValidationContext) validateenumvalues(mut var_enumType Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_EnumType)  {
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_SchemaValidationContext) validateinputfields(mut var_inputObj Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InputObjectType)  {
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_SchemaValidationContext) validatetypeissingleton(mut var_type Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type, path string)  {
	mut var_type_mutated := var_type
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Type_SchemaValidationContext.duplicatetype(mut var_schema Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema, path string, name string) string {
	mut var_schema_mutated := var_schema
	mut name_mutated := name
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

fn create_automattic_woocommerce_vendor_graphql_type_validation_inputobjectcircularrefs() &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Validation_InputObjectCircularRefs {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Validation_InputObjectCircularRefs{
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

fn create_automattic_woocommerce_vendor_graphql_type_definition_type() &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_type_introspection() &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Introspection {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Introspection{
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


fn init_registry() {
}

fn init() {
	init_registry()
}



pub fn init_wp_content_plugins_woocommerce_lib_packages_graphql_type_schemavalidationcontext_php() {
	// unsupported statement: Stmt_Declare
}
