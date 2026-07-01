import rt

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_VariablesInAllowedPosition {
	rt.PhpObjectBase
pub mut:
		varDefMap rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_VariablesInAllowedPosition) getvisitor(mut var_context Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_QueryValidationContext) rt.PhpVal {
	closure_3_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_2_fn := fn [var_context] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	this.varDefMap = rt.new_array()
	return rt.new_null()
	}
	mut var_operation := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	mut var_usages := var_context.getrecursivevariableusages(var_operation.dup())
	{
		mut iter_1 := var_usages.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_usage := item_1.val
			mut var_node := var_usage.array_get('node')
			mut var_type := var_usage.array_get('type')
			mut var_defaultValue := var_usage.array_get('defaultValue')
			mut var_varName := rt.get_property(rt.get_property(var_node, 'name'), 'value')
			mut var_varDef := if !(this.varDefMap.array_get(var_varName)).is_null() { this.varDefMap.array_get(var_varName) } else { rt.new_null() }
			if rt.is_true(rt.new_bool(rt.is_true(rt.identical(var_varDef, rt.new_null())) || rt.is_true(rt.identical(var_type, rt.new_null())))) {
				continue
			}
			mut var_schema := var_context.getschema()
			mut var_varType := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_AST{}; return temp.typefromast(arg_0, arg_1) }(rt.create_array([rt.ArrayItem{ key: none, val: var_schema }, rt.ArrayItem{ key: none, val: 'getType' }]), rt.get_property(var_varDef, 'type'))
			if rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) && !(this.allowedvariableusage(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema](var_schema), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type](var_varType), rt.get_property(var_varDef, 'defaultValue'), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type](var_type), var_defaultValue.dup())))) {
				var_context.reporterror(create_automattic_woocommerce_vendor_graphql_error_error(Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_VariablesInAllowedPosition.badvarposmessage((var_varName).str(), (rt.call_method(var_varType, 'toString', []rt.PhpVal{})).str(), (rt.call_method(var_type, 'toString', []rt.PhpVal{})).str()), rt.create_array([rt.ArrayItem{ key: none, val: var_varDef }, rt.ArrayItem{ key: none, val: var_node }])))
			}
		}
	}
	return rt.new_null()
	}
	mut var_varDefNode := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	this.varDefMap.array_set(rt.get_property(rt.get_property(rt.get_property(var_varDefNode, 'variable'), 'name'), 'value'), var_varDefNode.dup())
	return rt.new_null()
	}
	return rt.create_array([rt.ArrayItem{ key: Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeKind.operation_definition(), val: rt.create_array([rt.ArrayItem{ key: 'enter', val: rt.new_closure(closure_1_fn) }, rt.ArrayItem{ key: 'leave', val: rt.new_closure(closure_2_fn) }]) }, rt.ArrayItem{ key: Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeKind.variable_definition(), val: rt.new_closure(closure_3_fn) }])
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_VariablesInAllowedPosition.badvarposmessage(varName string, varType string, expectedType string) string {
	return rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('Variable "$'), rt.new_string(varName)), rt.new_string('" of type "')), rt.new_string(varType)), rt.new_string('" used in position expecting type "')), rt.new_string(expectedType)), rt.new_string('".'))
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_VariablesInAllowedPosition) allowedvariableusage(mut var_schema Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema, mut var_varType Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type, var_varDefaultValue rt.PhpVal, mut var_locationType Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type, var_locationDefaultValue rt.PhpVal) bool {
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type', []string{}, var_locationType), 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_NonNull'))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type', []string{}, var_varType), 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_NonNull')))))))) {
		mut var_hasNonNullVariableDefaultValue := rt.new_bool(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) && rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_varDefaultValue, 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NullValueNode'))))))))
		mut var_hasLocationDefaultValue := // unsupported expression: Expr_BinaryOp_NotIdentical
		if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_hasNonNullVariableDefaultValue)))) && rt.is_true(rt.new_bool(!(rt.is_true(var_hasLocationDefaultValue)))))) {
			return false
		}
		mut var_nullableLocationType := var_locationType.getwrappedtype()
		return (fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_TypeComparators{}; return temp.istypesubtypeof(arg_0, arg_1, arg_2) }(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Schema', []string{}, var_schema), rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type', []string{}, var_varType), var_nullableLocationType.dup())).to_bool()
	}
	return (fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_TypeComparators{}; return temp.istypesubtypeof(arg_0, arg_1, arg_2) }(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Schema', []string{}, var_schema), rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type', []string{}, var_varType), rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type', []string{}, var_locationType))).to_bool()
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_ValidationRule {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_AST {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Error {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_TypeComparators {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_vendor_graphql_validator_rules_variablesinallowedposition() &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_VariablesInAllowedPosition {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_VariablesInAllowedPosition{
		PhpObjectBase: rt.PhpObjectBase{}
		varDefMap: rt.new_null()
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_validator_rules_validationrule() &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_ValidationRule {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_ValidationRule{
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

fn create_automattic_woocommerce_vendor_graphql_error_error() &Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Error {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_utils_typecomparators() &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_TypeComparators {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_TypeComparators{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_VariablesInAllowedPosition) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'getVisitor' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_QueryValidationContext](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.getvisitor(mut dispatch_arg_0)
		}
		'badVarPosMessage' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			return rt.new_string(Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_VariablesInAllowedPosition.badvarposmessage(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2))
		}
		'allowedVariableUsage' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type](if args.len > 1 { args[1] } else { rt.new_null() })
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			mut dispatch_arg_3 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type](if args.len > 3 { args[3] } else { rt.new_null() })
			dispatch_arg_4 := if args.len > 4 { args[4] } else { rt.new_null() }
			return rt.new_bool(this.allowedvariableusage(mut dispatch_arg_0, mut dispatch_arg_1, dispatch_arg_2, mut dispatch_arg_3, dispatch_arg_4))
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_VariablesInAllowedPosition) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'varDefMap' { return this.varDefMap }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_VariablesInAllowedPosition) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'varDefMap' { this.varDefMap = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
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


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_AST) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_AST) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_AST) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_TypeComparators) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_TypeComparators) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_TypeComparators) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_lib_packages_graphql_validator_rules_variablesinallowedposition_php() {
	// unsupported statement: Stmt_Declare
}
