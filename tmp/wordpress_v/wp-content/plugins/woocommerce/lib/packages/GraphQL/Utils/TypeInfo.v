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

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_TypeInfo) construct(mut var_schema Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema)  {
	mut var_schema_mutated := var_schema
	this.schema = var_schema_mutated.dup()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_TypeInfo) getparenttypestack() rt.PhpVal {
	return this.parentTypeStack
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_TypeInfo) getfielddefstack() rt.PhpVal {
	return this.fieldDefStack
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_TypeInfo.extracttypes(mut var_type Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type, mut var_typeMap Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array)  {
	mut var_type_mutated := var_type
	mut var_typeMap_mutated := var_typeMap
	if rt.is_true(rt.new_bool(rt.instance_of(var_type_mutated, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_WrappingType'))) {
		Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_TypeInfo.extracttypes(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type](rt.call_method(var_type_mutated, 'getInnermostType', []rt.PhpVal{})), mut var_typeMap_mutated)
		return rt.new_null()
	}
	mut var_name := rt.get_property(var_type_mutated, 'name')
	rt.call_function('assert', [rt.new_bool(var_name.dup().is_string())])
	if var_typeMap_mutated.array_isset(var_name) {
		if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
			rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Error_InvariantViolation', []string{}, create_automattic_woocommerce_vendor_graphql_error_invariantviolation(rt.new_string("Schema must contain unique named types but contains multiple types named \"${var_type.to_string()}\" (see https://webonyx.github.io/graphql-php/type-definitions/#type-registry)."))))
		}
		return rt.new_null()
	}
	var_typeMap_mutated.array_set(var_name, var_type_mutated.dup())
	if rt.is_true(rt.new_bool(rt.instance_of(var_type_mutated, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_UnionType'))) {
		{
			mut iter_1 := rt.call_method(var_type_mutated, 'getTypes', []rt.PhpVal{}).iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_member := item_1.val
				Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_TypeInfo.extracttypes(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type](var_member), mut var_typeMap_mutated)
			}
		}
		return rt.new_null()
	}
	if rt.is_true(rt.new_bool(rt.instance_of(var_type_mutated, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InputObjectType'))) {
		{
			mut iter_1 := rt.call_method(var_type_mutated, 'getFields', []rt.PhpVal{}).iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_field := item_1.val
				mut var_fieldType := rt.call_method(var_field, 'getType', []rt.PhpVal{})
				rt.call_function('assert', [rt.new_bool(rt.is_true(rt.new_bool(rt.instance_of(var_fieldType, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_NamedType'))) || rt.is_true(rt.new_bool(rt.instance_of(var_fieldType, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_WrappingType'))))])
				Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_TypeInfo.extracttypes(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type](var_fieldType), mut var_typeMap_mutated)
			}
		}
		return rt.new_null()
	}
	if rt.is_true(rt.new_bool(rt.instance_of(var_type_mutated, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ImplementingType'))) {
		{
			mut iter_1 := rt.call_method(var_type_mutated, 'getInterfaces', []rt.PhpVal{}).iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_interface := item_1.val
				Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_TypeInfo.extracttypes(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type](var_interface), mut var_typeMap_mutated)
			}
		}
	}
	if rt.is_true(rt.new_bool(rt.instance_of(var_type_mutated, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_HasFieldsType'))) {
		{
			mut iter_1 := rt.call_method(var_type_mutated, 'getFields', []rt.PhpVal{}).iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_field := item_1.val
				{
					mut iter_2 := rt.get_property(var_field, 'args').iterator()
					for {
						item_2 := iter_2.next() or { break }
						mut var_arg := item_2.val
						mut var_argType := rt.call_method(var_arg, 'getType', []rt.PhpVal{})
						rt.call_function('assert', [rt.new_bool(rt.is_true(rt.new_bool(rt.instance_of(var_argType, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_NamedType'))) || rt.is_true(rt.new_bool(rt.instance_of(var_argType, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_WrappingType'))))])
						Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_TypeInfo.extracttypes(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type](var_argType), mut var_typeMap_mutated)
					}
				}
				mut var_fieldType := rt.call_method(var_field, 'getType', []rt.PhpVal{})
				rt.call_function('assert', [rt.new_bool(rt.is_true(rt.new_bool(rt.instance_of(var_fieldType, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_NamedType'))) || rt.is_true(rt.new_bool(rt.instance_of(var_fieldType, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_WrappingType'))))])
				Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_TypeInfo.extracttypes(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type](var_fieldType), mut var_typeMap_mutated)
			}
		}
	}
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_TypeInfo.extracttypesfromdirectives(mut var_directive Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Directive, mut var_typeMap Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array)  {
	mut var_typeMap_mutated := var_typeMap
	{
		mut iter_1 := rt.get_property(var_directive, 'args').iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_arg := item_1.val
			mut var_argType := rt.call_method(var_arg, 'getType', []rt.PhpVal{})
			rt.call_function('assert', [rt.new_bool(rt.is_true(rt.new_bool(rt.instance_of(var_argType, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_NamedType'))) || rt.is_true(rt.new_bool(rt.instance_of(var_argType, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_WrappingType'))))])
			Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_TypeInfo.extracttypes(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type](var_argType), mut var_typeMap_mutated)
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_TypeInfo) getparentinputtype() rt.PhpVal {
	return if !(this.inputTypeStack.array_get(this.inputTypeStack.array_count() - 2)).is_null() { this.inputTypeStack.array_get(this.inputTypeStack.array_count() - 2) } else { rt.new_null() }
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_TypeInfo) getargument() rt.PhpVal {
	return this.argument
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_TypeInfo) getenumvalue() rt.PhpVal {
	return this.enumValue
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_TypeInfo) enter(mut var_node Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Node)  {
	mut var_schema := this.schema
	mut switch_val_1 := rt.new_bool(true)
	if rt.is_true(rt.equal(switch_val_1, rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Node', []string{}, var_node), 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_SelectionSetNode')))) {
		mut var_namedType := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type{}; return temp.getnamedtype(arg_0) }(this.gettype())
		this.parentTypeStack.array_push(if rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type{}; return temp.iscompositetype(arg_0) }(var_namedType.dup())) { var_namedType } else { rt.new_null() })
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Node', []string{}, var_node), 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_FieldNode')))) {
		mut var_parentType := this.getparenttype()
		mut var_fieldDef := if rt.is_true(rt.identical(var_parentType, rt.new_null())) { rt.new_null() } else { Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_TypeInfo.getfielddefinition(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema](var_schema), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type](var_parentType), mut var_node) }
		mut var_fieldType := if rt.is_true(rt.identical(var_fieldDef, rt.new_null())) { rt.new_null() } else { rt.call_method(var_fieldDef, 'getType', []rt.PhpVal{}) }
		this.fieldDefStack.array_push(var_fieldDef.dup())
		this.typeStack.array_push(var_fieldType.dup())
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
		this.typeStack.array_push(if rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type{}; return temp.isoutputtype(arg_0) }(var_type.dup())) { var_type } else { rt.new_null() })
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Node', []string{}, var_node), 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_InlineFragmentNode')))) || rt.is_true(rt.equal(switch_val_1, rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Node', []string{}, var_node), 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_FragmentDefinitionNode')))) {
		mut var_typeConditionNode := rt.get_property(var_node, 'typeCondition')
		mut var_outputType := if rt.is_true(rt.identical(var_typeConditionNode, rt.new_null())) { fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type{}; return temp.getnamedtype(arg_0) }(this.gettype()) } else { fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_AST{}; return temp.typefromast(arg_0, arg_1) }(rt.create_array([rt.ArrayItem{ key: none, val: var_schema }, rt.ArrayItem{ key: none, val: 'getType' }]), var_typeConditionNode.dup()) }
		this.typeStack.array_push(if rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type{}; return temp.isoutputtype(arg_0) }(var_outputType.dup())) { var_outputType } else { rt.new_null() })
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Node', []string{}, var_node), 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_VariableDefinitionNode')))) {
		mut var_inputType := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_AST{}; return temp.typefromast(arg_0, arg_1) }(rt.create_array([rt.ArrayItem{ key: none, val: var_schema }, rt.ArrayItem{ key: none, val: 'getType' }]), rt.get_property(var_node, 'type'))
		this.inputTypeStack.array_push(if rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type{}; return temp.isinputtype(arg_0) }(var_inputType.dup())) { var_inputType } else { rt.new_null() })
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Node', []string{}, var_node), 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_ArgumentNode')))) {
		mut var_fieldOrDirective := if !(this.getdirective()).is_null() { this.getdirective() } else { this.getfielddef() }
		mut var_argDef := rt.new_null()
		mut var_argType := rt.new_null()
		if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
			{
				mut iter_1 := rt.get_property(var_fieldOrDirective, 'args').iterator()
				for {
					item_1 := iter_1.next() or { break }
					mut var_arg := item_1.val
					if rt.is_true(rt.identical(rt.get_property(var_arg, 'name'), rt.get_property(rt.get_property(var_node, 'name'), 'value'))) {
						var_argDef = var_arg
						var_argType = rt.call_method(, 'getType', []rt.PhpVal{})
					}
				}
			}
		}
		this.argument = var_argDef.dup()
		this.defaultValueStack.array_push(if rt.is_true() {  } else {  })
		.array_push()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Node', []string{}, ), 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_ListValueNode')))) {
		
	} else if rt.is_true(rt.equal(switch_val_1, )) {
	} else if rt.is_true(rt.equal(switch_val_1, )) {
	}
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_TypeInfo) gettype() rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_TypeInfo) getparenttype() rt.PhpVal {
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_TypeInfo.getfielddefinition(mut var_schema Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema, mut var_parentType Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type, mut var_fieldNode Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_FieldNode) rt.PhpVal {
	mut var_schema_mutated := var_schema
	mut var_parentType_mutated := var_parentType
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_TypeInfo) getdirective() rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_TypeInfo) getfielddef() rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_TypeInfo) getdefaultvalue() rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_TypeInfo) getinputtype() rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_TypeInfo) leave(mut var_node Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Node)  {
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

fn create_automattic_woocommerce_vendor_graphql_error_invariantviolation() &Class_Automattic_WooCommerce_Vendor_GraphQL_Error_InvariantViolation {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Error_InvariantViolation{
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

fn create_automattic_woocommerce_vendor_graphql_utils_ast() &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_AST {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_AST{
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




pub fn init_wp_content_plugins_woocommerce_lib_packages_graphql_utils_typeinfo_php() {
	// unsupported statement: Stmt_Declare
}
