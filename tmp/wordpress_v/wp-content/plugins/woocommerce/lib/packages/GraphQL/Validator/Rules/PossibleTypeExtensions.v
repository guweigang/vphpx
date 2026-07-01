import rt

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_PossibleTypeExtensions {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_PossibleTypeExtensions) getsdlvisitor(mut var_context Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_SDLValidationContext) rt.PhpVal {
	mut var_schema := var_context.getschema()
	mut var_definedTypes := rt.new_array()
	{
		mut iter_1 := rt.get_property(var_context.getdocument(), 'definitions').iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_def := item_1.val
			if rt.is_true(rt.new_bool(rt.instance_of(var_def, 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_TypeDefinitionNode'))) {
				mut var_name := rt.get_property(rt.call_method(var_def, 'getName', []rt.PhpVal{}), 'value')
				var_definedTypes.array_set(var_name, var_def.dup())
			}
		}
	}
	closure_1_fn := fn [var_context, var_schema, mut var_definedTypes] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_node := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	mut var_typeName := rt.get_property(rt.get_property(var_node, 'name'), 'value')
	mut var_defNode := if !(var_definedTypes.array_get(var_typeName)).is_null() { var_definedTypes.array_get(var_typeName) } else { rt.new_null() }
	mut var_existingType := if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) { rt.call_method(var_schema, 'getType', [var_typeName.dup()]) } else { rt.new_null() }
	mut var_expectedKind := rt.new_null()
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		var_expectedKind = Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_PossibleTypeExtensions.defkindtoextkind((rt.get_property(var_defNode, 'kind')).str())
	} else if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		var_expectedKind = Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_PossibleTypeExtensions.typetoextkind(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_NamedType](var_existingType))
	}
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
			mut var_kindStr := Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_PossibleTypeExtensions.extensionkindtotypename((rt.get_property(var_node, 'kind')).str())
			var_context.reporterror(create_automattic_woocommerce_vendor_graphql_error_error(rt.new_string("Cannot extend non-${var_kindStr.to_string()} type \"${var_typeName.to_string()}\"."), if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) { rt.create_array([rt.ArrayItem{ key: none, val: var_defNode }, rt.ArrayItem{ key: none, val: var_node }]) } else { var_node }))
		}
	} else {
		mut var_existingTypesMap := if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) { rt.call_method(var_schema, 'getTypeMap', []rt.PhpVal{}) } else { rt.new_array() }
		mut var_allTypeNames := rt.create_array([rt.ArrayItem{ key: none, val: rt.func_array_keys(var_definedTypes.dup()) }, rt.ArrayItem{ key: none, val: rt.func_array_keys(var_existingTypesMap.dup()) }])
		mut var_suggestedTypes := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils{}; return temp.suggestionlist(arg_0, arg_1) }(var_typeName.dup(), var_allTypeNames.dup())
		mut var_didYouMean := rt.new_string(if rt.is_true(rt.identical(var_suggestedTypes, rt.new_array())) { rt.new_string('') } else { ' Did you mean ' + (fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils{}; return temp.quotedorlist(arg_0) }(var_suggestedTypes.dup())).str() + '?' })
		var_context.reporterror(create_automattic_woocommerce_vendor_graphql_error_error(rt.new_string("Cannot extend type \"${var_typeName.to_string()}\" because it is not defined.${var_didYouMean.to_string()}"), rt.get_property(var_node, 'name')))
	}
	return rt.new_null()
	}
	mut var_checkTypeExtension := rt.new_closure(closure_1_fn)
	return rt.create_array([rt.ArrayItem{ key: Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeKind.scalar_type_extension(), val: var_checkTypeExtension }, rt.ArrayItem{ key: Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeKind.object_type_extension(), val: var_checkTypeExtension }, rt.ArrayItem{ key: Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeKind.interface_type_extension(), val: var_checkTypeExtension }, rt.ArrayItem{ key: Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeKind.union_type_extension(), val: var_checkTypeExtension }, rt.ArrayItem{ key: Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeKind.enum_type_extension(), val: var_checkTypeExtension }, rt.ArrayItem{ key: Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeKind.input_object_type_extension(), val: var_checkTypeExtension }])
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_PossibleTypeExtensions.defkindtoextkind(kind string) string {
	mut switch_val_1 := rt.new_string(kind)
	if rt.is_true(rt.equal(switch_val_1, Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeKind.scalar_type_definition())) {
		return (Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeKind.scalar_type_extension()).str()
	} else if rt.is_true(rt.equal(switch_val_1, Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeKind.object_type_definition())) {
		return (Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeKind.object_type_extension()).str()
	} else if rt.is_true(rt.equal(switch_val_1, Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeKind.interface_type_definition())) {
		return (Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeKind.interface_type_extension()).str()
	} else if rt.is_true(rt.equal(switch_val_1, Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeKind.union_type_definition())) {
		return (Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeKind.union_type_extension()).str()
	} else if rt.is_true(rt.equal(switch_val_1, Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeKind.enum_type_definition())) {
		return (Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeKind.enum_type_extension()).str()
	} else if rt.is_true(rt.equal(switch_val_1, Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeKind.input_object_type_definition())) {
		return (Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeKind.input_object_type_extension()).str()
	} else {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Error_InvariantViolation', []string{}, create_automattic_woocommerce_vendor_graphql_error_invariantviolation(rt.new_string("Unexpected definition kind: ${var_kind}."))))
	}
	return ''
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_PossibleTypeExtensions.typetoextkind(mut var_type Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_NamedType) string {
	mut switch_val_2 := rt.new_bool(true)
	if rt.is_true(rt.equal(switch_val_2, rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_NamedType', []string{}, var_type), 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ScalarType')))) {
		return (Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeKind.scalar_type_extension()).str()
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_NamedType', []string{}, var_type), 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ObjectType')))) {
		return (Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeKind.object_type_extension()).str()
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_NamedType', []string{}, var_type), 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InterfaceType')))) {
		return (Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeKind.interface_type_extension()).str()
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_NamedType', []string{}, var_type), 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_UnionType')))) {
		return (Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeKind.union_type_extension()).str()
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_NamedType', []string{}, var_type), 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_EnumType')))) {
		return (Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeKind.enum_type_extension()).str()
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_NamedType', []string{}, var_type), 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InputObjectType')))) {
		return (Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeKind.input_object_type_extension()).str()
	} else {
		mut var_unexpectedType := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils{}; return temp.printsafe(arg_0) }(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_NamedType', []string{}, var_type))
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Error_InvariantViolation', []string{}, create_automattic_woocommerce_vendor_graphql_error_invariantviolation(rt.new_string("Unexpected type: ${var_unexpectedType.to_string()}."))))
	}
	return ''
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_PossibleTypeExtensions.extensionkindtotypename(kind string) string {
	mut switch_val_3 := rt.new_string(kind)
	if rt.is_true(rt.equal(switch_val_3, Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeKind.scalar_type_extension())) {
		return 'scalar'
	} else if rt.is_true(rt.equal(switch_val_3, Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeKind.object_type_extension())) {
		return 'object'
	} else if rt.is_true(rt.equal(switch_val_3, Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeKind.interface_type_extension())) {
		return 'interface'
	} else if rt.is_true(rt.equal(switch_val_3, Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeKind.union_type_extension())) {
		return 'union'
	} else if rt.is_true(rt.equal(switch_val_3, Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeKind.enum_type_extension())) {
		return 'enum'
	} else if rt.is_true(rt.equal(switch_val_3, Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeKind.input_object_type_extension())) {
		return 'input object'
	} else {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Error_InvariantViolation', []string{}, create_automattic_woocommerce_vendor_graphql_error_invariantviolation(rt.new_string("Unexpected extension kind: ${var_kind}."))))
	}
	return ''
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_ValidationRule {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Error {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Error_InvariantViolation {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_vendor_graphql_validator_rules_possibletypeextensions() &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_PossibleTypeExtensions {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_PossibleTypeExtensions{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_validator_rules_validationrule() &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_ValidationRule {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_ValidationRule{
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

fn create_automattic_woocommerce_vendor_graphql_error_invariantviolation() &Class_Automattic_WooCommerce_Vendor_GraphQL_Error_InvariantViolation {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Error_InvariantViolation{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_PossibleTypeExtensions) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'getSDLVisitor' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_SDLValidationContext](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.getsdlvisitor(mut dispatch_arg_0)
		}
		'defKindToExtKind' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_PossibleTypeExtensions.defkindtoextkind(dispatch_arg_0))
		}
		'typeToExtKind' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_NamedType](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_string(Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_PossibleTypeExtensions.typetoextkind(mut dispatch_arg_0))
		}
		'extensionKindToTypeName' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_PossibleTypeExtensions.extensionkindtotypename(dispatch_arg_0))
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_PossibleTypeExtensions) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_PossibleTypeExtensions) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_ValidationRule) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_ValidationRule) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_ValidationRule) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Error_InvariantViolation) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Error_InvariantViolation) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Error_InvariantViolation) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_lib_packages_graphql_validator_rules_possibletypeextensions_php() {
	// unsupported statement: Stmt_Declare
}
