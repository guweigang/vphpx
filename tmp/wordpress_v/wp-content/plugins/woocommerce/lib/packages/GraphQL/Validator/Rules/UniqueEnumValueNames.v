import rt

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_UniqueEnumValueNames {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_UniqueEnumValueNames) getsdlvisitor(mut var_context Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_SDLValidationContext) rt.PhpVal {
	mut var_knownValueNames := rt.new_array()
	closure_1_fn := fn [var_context, mut var_knownValueNames] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_enum := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	mut var_valueNames := rt.new_null()
	mut var_typeName := rt.get_property(rt.get_property(var_enum, 'name'), 'value')
	mut var_schema := var_context.getschema()
	mut var_existingType := if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) { rt.call_method(var_schema, 'getType', [var_typeName.dup()]) } else { rt.new_null() }
	mut var_valueNodes := rt.get_property(var_enum, 'values')
	if !(var_knownValueNames.array_isset(var_typeName)) {
		var_knownValueNames.array_set(var_typeName, rt.new_array())
	}
	// unsupported expression: Expr_AssignRef
	{
		mut iter_1 := var_valueNodes.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_valueDef := item_1.val
			mut var_valueNameNode := rt.get_property(var_valueDef, 'name')
			mut var_valueName := rt.get_property(var_valueNameNode, 'value')
			if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.instance_of(var_existingType, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_EnumType'))) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
				var_context.reporterror(create_automattic_woocommerce_vendor_graphql_error_error(rt.new_string("Enum value \"${var_typeName.to_string()}.${var_valueName.to_string()}\" already exists in the schema. It cannot also be defined in this type extension."), var_valueNameNode.dup()))
			} else if var_valueNames.array_isset(var_valueName) {
				var_context.reporterror(create_automattic_woocommerce_vendor_graphql_error_error(rt.new_string("Enum value \"${var_typeName.to_string()}.${var_valueName.to_string()}\" can only be defined once."), rt.create_array([rt.ArrayItem{ key: none, val: var_valueNames.array_get(var_valueName) }, rt.ArrayItem{ key: none, val: var_valueNameNode }])))
			} else {
				var_valueNames.array_set(var_valueName, var_valueNameNode.dup())
			}
		}
	}
	return fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Visitor{}; return temp.skipnode() }()
	}
	mut var_checkValueUniqueness := rt.new_closure(closure_1_fn)
	return rt.create_array([rt.ArrayItem{ key: Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeKind.enum_type_definition(), val: var_checkValueUniqueness }, rt.ArrayItem{ key: Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeKind.enum_type_extension(), val: var_checkValueUniqueness }])
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_ValidationRule {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Error {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Visitor {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_vendor_graphql_validator_rules_uniqueenumvaluenames() &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_UniqueEnumValueNames {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_UniqueEnumValueNames{
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

fn create_automattic_woocommerce_vendor_graphql_language_visitor() &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Visitor {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Visitor{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_UniqueEnumValueNames) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'getSDLVisitor' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_SDLValidationContext](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.getsdlvisitor(mut dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_UniqueEnumValueNames) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_UniqueEnumValueNames) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Visitor) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Visitor) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Visitor) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_lib_packages_graphql_validator_rules_uniqueenumvaluenames_php() {
	// unsupported statement: Stmt_Declare
}
