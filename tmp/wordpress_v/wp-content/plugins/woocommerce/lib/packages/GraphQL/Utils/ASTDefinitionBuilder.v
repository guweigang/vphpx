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

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_ASTDefinitionBuilder) construct(mut var_typeDefinitionsMap Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array, mut var_typeExtensionsMap Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array, mut var_resolveType Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_callable, mut var_typeConfigDecorator Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_?callable, mut var_fieldConfigDecorator Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_?callable)  {
	this.typeDefinitionsMap = var_typeDefinitionsMap.dup()
	this.typeExtensionsMap = var_typeExtensionsMap.dup()
	this.resolveType = var_resolveType.dup()
	this.typeConfigDecorator = var_typeConfigDecorator.dup()
	this.fieldConfigDecorator = var_fieldConfigDecorator.dup()
	this.cache = fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type{}; return temp.builtintypes() }()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_ASTDefinitionBuilder) builddirective(mut var_directiveNode Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_DirectiveDefinitionNode) rt.PhpVal {
	mut var_locations := rt.new_array()
	{
		mut iter_1 := rt.get_property(var_directiveNode, 'locations').iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_location := item_1.val
			var_locations.array_push(rt.get_property(var_location, 'value'))
		}
	}
	return create_automattic_woocommerce_vendor_graphql_type_definition_directive(rt.create_array([rt.ArrayItem{ key: 'name', val: rt.get_property(rt.get_property(var_directiveNode, 'name'), 'value') }, rt.ArrayItem{ key: 'description', val: if !(rt.get_property(rt.get_property(var_directiveNode, 'description'), 'value')).is_null() { rt.get_property(rt.get_property(var_directiveNode, 'description'), 'value') } else { rt.new_null() } }, rt.ArrayItem{ key: 'args', val: this.makeinputvalues(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeList](rt.get_property(var_directiveNode, 'arguments'))) }, rt.ArrayItem{ key: 'isRepeatable', val: rt.get_property(var_directiveNode, 'repeatable') }, rt.ArrayItem{ key: 'locations', val: var_locations }, rt.ArrayItem{ key: 'astNode', val: var_directiveNode }]))
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_ASTDefinitionBuilder) makeinputvalues(mut var_values Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeList) rt.PhpVal {
	mut var_values_mutated := var_values
	mut var_map := rt.new_array()
	{
		mut iter_1 := var_values_mutated.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_value := item_1.val
			mut var_type := this.buildwrappedtype(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_TypeNode](rt.get_property(var_value, 'type')))
			mut var_config := rt.create_array([rt.ArrayItem{ key: 'name', val: rt.get_property(rt.get_property(var_value, 'name'), 'value') }, rt.ArrayItem{ key: 'type', val: var_type }, rt.ArrayItem{ key: 'description', val: if !(rt.get_property(rt.get_property(var_value, 'description'), 'value')).is_null() { rt.get_property(rt.get_property(var_value, 'description'), 'value') } else { rt.new_null() } }, rt.ArrayItem{ key: 'deprecationReason', val: this.getdeprecationreason(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Node](var_value)) }, rt.ArrayItem{ key: 'astNode', val: var_value }])
			if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
				var_config.array_set('defaultValue', fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_AST{}; return temp.valuefromast(arg_0, arg_1) }(rt.get_property(var_value, 'defaultValue'), var_type.dup()))
			}
			var_map.array_set(rt.get_property(rt.get_property(var_value, 'name'), 'value'), var_config.dup())
		}
	}
	return var_map.dup()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_ASTDefinitionBuilder) makeinputfields(mut var_nodes Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array) rt.PhpVal {
	mut var_fields := rt.new_array()
	{
		mut iter_1 := var_nodes.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_node := item_1.val
			var_fields.dup().array_push(rt.get_property(var_node, 'fields'))
		}
	}
	return this.makeinputvalues(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeList](create_automattic_woocommerce_vendor_graphql_language_ast_nodelist(var_fields.dup())))
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_ASTDefinitionBuilder) buildwrappedtype(mut var_typeNode Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_TypeNode) rt.PhpVal {
	if rt.is_true(rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_TypeNode', []string{}, var_typeNode), 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_ListTypeNode'))) {
		return fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type{}; return temp.listof(arg_0) }(this.buildwrappedtype(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_TypeNode](rt.get_property(var_typeNode, 'type'))))
	}
	if rt.is_true(rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_TypeNode', []string{}, var_typeNode), 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NonNullTypeNode'))) {
		return fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type{}; return temp.nonnull(arg_0) }(this.buildwrappedtype(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_TypeNode](rt.get_property(var_typeNode, 'type'))))
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
		return this.cache.array_get(typeName)
	}
	if this.typeDefinitionsMap.array_isset(rt.new_string(typeName)) {
		mut var_type := this.makeschemadef(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Node](this.typeDefinitionsMap.array_get(typeName)))
		if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
			mut var_config := rt.call_callable(this.typeConfigDecorator, [rt.get_property(var_type, 'config'), this.typeDefinitionsMap.array_get(typeName), this.typeDefinitionsMap])
			if rt.has_exception() { unsafe { goto catch_label_1 } }
			unsafe { goto end_label_1 }

catch_label_1:
			mut var_e_1 := rt.get_and_clear_exception()
			if rt.instance_of(var_e_1, 'Automattic_WooCommerce_Vendor_GraphQL_Utils_Throwable') {
				mut var_e := var_e_1.dup()
				mut var_class := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_static.class()
				rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Error_Error', []string{}, create_automattic_woocommerce_vendor_graphql_error_error(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('Type config decorator passed to '), var_class), rt.new_string(' threw an error when building ')), rt.new_string(typeName)), rt.new_string(' type: ')), rt.call_method(var_e, 'getMessage', []rt.PhpVal{})), rt.new_null(), rt.new_null(), rt.new_array(), rt.new_null(), var_e.dup())))
				unsafe { goto end_label_1 }
			}
			else {
				rt.throw_exception(var_e_1)
				unsafe { goto end_label_1 }
			}

end_label_1:
			if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_config.dup().is_array()))))) || var_config.array_isset(rt.new_int(0)))) {
				var_class = Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_static.class()
				mut var_notArray := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils{}; return temp.printsafe(arg_0) }(var_config.dup())
				rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Error_Error', []string{}, create_automattic_woocommerce_vendor_graphql_error_error(rt.new_string("Type config decorator passed to ${var_class.to_string()} is expected to return an array, but got ${var_notArray.to_string()}"))))
			}
			var_type = this.makeschemadeffromconfig(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Node](this.typeDefinitionsMap.array_get(typeName)), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array](var_config))
		}
		return this.cache.array_set(typeName, var_type.dup())
	}
	return this.cache.array_set(typeName, rt.call_callable(this.resolveType, [rt.new_string(typeName), var_typeNode]))
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_ASTDefinitionBuilder) makeschemadef(mut var_def Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Node)  {
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
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_ASTDefinitionBuilder) maketypedef(mut var_def Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_ObjectTypeDefinitionNode) rt.PhpVal {
	mut var_name := rt.get_property(rt.get_property(var_def, 'name'), 'value')
	mut var_extensionASTNodes := if !(this.typeExtensionsMap.array_get(var_name)).is_null() { this.typeExtensionsMap.array_get(var_name) } else { rt.new_array() }
	mut var_allNodes := rt.create_array([rt.ArrayItem{ key: none, val: var_def }, rt.ArrayItem{ key: none, val: var_extensionASTNodes }])
	closure_2_fn := fn [var_allNodes] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_1_fn := fn [var_allNodes] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	return this.makefielddefmap(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array](var_allNodes))
	}
	return this.makeimplementedinterfaces(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array](var_allNodes))
	}
	return create_automattic_woocommerce_vendor_graphql_type_definition_objecttype(rt.create_array([rt.ArrayItem{ key: 'name', val: var_name }, rt.ArrayItem{ key: 'description', val: if !(rt.get_property(rt.get_property(, 'description'), 'value')).is_null() { rt.get_property(rt.get_property(, 'description'), 'value') } else { rt.new_null() } }, rt.ArrayItem{ key: 'fields', val: rt.new_closure(closure_1_fn) }, rt.ArrayItem{ key: 'interfaces', val: rt.new_closure(closure_2_fn) }, rt.ArrayItem{ key: 'astNode', val: var_def }, rt.ArrayItem{ key: 'extensionASTNodes', val: var_extensionASTNodes }]))
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_ASTDefinitionBuilder) makefielddefmap(mut var_nodes Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array) rt.PhpVal {
	mut var_map := rt.new_array()
	{
		mut iter_1 := var_nodes.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_node := item_1.val
			{
				mut iter_2 := rt.get_property(var_node, 'fields').iterator()
				for {
					item_2 := iter_2.next() or { break }
					mut var_field := item_2.val
					.array_set(, )
				}
			}
		}
	}
	return .dup()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_ASTDefinitionBuilder) buildfield(mut var_field Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_FieldDefinitionNode, mut var_node Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_object) rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_ASTDefinitionBuilder) getdeprecationreason(mut var_node Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Node) string {
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_ASTDefinitionBuilder) makeimplementedinterfaces(mut var_nodes Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array) rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_ASTDefinitionBuilder) makeinterfacedef(mut var_def Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_InterfaceTypeDefinitionNode) rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_ASTDefinitionBuilder) makeenumdef(mut var_def Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_EnumTypeDefinitionNode) rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_ASTDefinitionBuilder) makeuniondef(mut var_def Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_UnionTypeDefinitionNode) rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_ASTDefinitionBuilder) makescalardef(mut var_def Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_ScalarTypeDefinitionNode) rt.PhpVal {
	mut var_value := rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_ASTDefinitionBuilder) makeinputobjectdef(mut var_def Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_InputObjectTypeDefinitionNode) rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_ASTDefinitionBuilder) makeschemadeffromconfig(mut var_def Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Node, mut var_config Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array)  {
	mut var_config_mutated := var_config
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_ASTDefinitionBuilder) buildinputfield(mut var_value Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_InputValueDefinitionNode) rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_ASTDefinitionBuilder) buildenumvalue(mut var_value Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_EnumValueDefinitionNode) rt.PhpVal {
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

fn create_automattic_woocommerce_vendor_graphql_type_definition_type() &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_type_definition_directive() &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Directive {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Directive{
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

fn create_automattic_woocommerce_vendor_graphql_language_ast_nodelist() &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeList {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeList{
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

fn create_automattic_woocommerce_vendor_graphql_type_definition_objecttype() &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ObjectType {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ObjectType{
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
			this.makeschemadef(mut dispatch_arg_0)
			return rt.new_null()
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
			this.makeschemadeffromconfig(mut dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
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


fn init_registry() {
}

fn init() {
	init_registry()
}



pub fn init_wp_content_plugins_woocommerce_lib_packages_graphql_utils_astdefinitionbuilder_php() {
	// unsupported statement: Stmt_Declare
}
