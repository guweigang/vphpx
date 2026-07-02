import rt

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_OneOfInputObjectsRule {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_OneOfInputObjectsRule) getvisitor(mut var_context Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_QueryValidationContext) rt.PhpVal {
	closure_2_fn := fn [var_context] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_node := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_type := var_context.getinputtype()
		if rt.is_true(rt.identical(var_type, rt.new_null())) {
			return rt.new_null()
		}
		mut iife_temp_1 := Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type{}
		mut iife_result_1 := iife_temp_1.getnamedtype(var_type.clone())
		mut var_namedType := iife_result_1
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_namedType, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InputObjectType')))))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_namedType, 'isOneOf', []rt.PhpVal{}))))) {
			return rt.new_null()
		}
		mut var_providedFields := rt.new_array()
		mut var_nullFields := rt.new_array()
		mut iter_1 := rt.get_property(var_node, 'fields').iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_fieldNode := item_1.val
			mut var_fieldName := rt.get_property(rt.get_property(var_fieldNode, 'name'), 'value')
			var_providedFields.array_push(var_fieldName.clone())
			if rt.is_true(rt.identical(rt.get_property(rt.get_property(var_fieldNode, 'value'), 'kind'), Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeKind.null())) {
				var_nullFields.array_push(var_fieldName.clone())
			}
		}
		mut var_fieldCount := rt.new_int(var_providedFields.clone().array_count())
		if rt.is_true(rt.identical(var_fieldCount, rt.new_int(0))) {
			var_context.reporterror(create_automattic_woocommerce_vendor_graphql_error_error(Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_OneOfInputObjectsRule.oneofinputobjectexpectedexactlyonefieldmessage((rt.get_property(var_namedType, 'name')).str()), rt.create_array([rt.ArrayItem{ key: none, val: var_node }])))
			return rt.new_null()
		}
		if rt.is_true(rt.greater(var_fieldCount, rt.new_int(1))) {
			var_context.reporterror(create_automattic_woocommerce_vendor_graphql_error_error(Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_OneOfInputObjectsRule.oneofinputobjectexpectedexactlyonefieldmessage((rt.get_property(var_namedType, 'name')).str(), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_?int](var_fieldCount)), rt.create_array([rt.ArrayItem{ key: none, val: var_node }])))
			return rt.new_null()
		}
		if var_nullFields.clone().array_count() > 0 {
			var_context.reporterror(create_automattic_woocommerce_vendor_graphql_error_error(Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_OneOfInputObjectsRule.oneofinputobjectfieldvaluemustnotbenullmessage((rt.get_property(var_namedType, 'name')).str(), (var_nullFields.array_get(rt.new_int(0))).str()), rt.create_array([rt.ArrayItem{ key: none, val: var_node }])))
		}
		return rt.new_null()
		}
	return rt.create_array([rt.ArrayItem{ key: Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeKind.object(), val: rt.new_closure(closure_2_fn) }])
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_OneOfInputObjectsRule.oneofinputobjectexpectedexactlyonefieldmessage(typeName string, mut var_providedCount Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_?int) string {
	if rt.is_true(rt.identical(var_providedCount, rt.new_null())) {
		return "OneOf input object '${var_typeName}' must specify exactly one field."
	}
	return "OneOf input object '${var_typeName}' must specify exactly one field, but ${var_providedCount.to_string()} fields were provided."
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_OneOfInputObjectsRule.oneofinputobjectfieldvaluemustnotbenullmessage(typeName string, fieldName string) string {
	return "OneOf input object '${var_typeName}' field '${var_fieldName}' must be non-null."
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_ValidationRule {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Error {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_vendor_graphql_validator_rules_oneofinputobjectsrule(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_OneOfInputObjectsRule {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_OneOfInputObjectsRule{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_validator_rules_validationrule(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_ValidationRule {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_ValidationRule{
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

fn create_automattic_woocommerce_vendor_graphql_error_error(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Error {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_OneOfInputObjectsRule) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'getVisitor' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_QueryValidationContext](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.getvisitor(mut dispatch_arg_0)
		}
		'oneOfInputObjectExpectedExactlyOneFieldMessage' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_?int](if args.len > 1 { args[1] } else { rt.new_null() })
			return rt.new_string(Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_OneOfInputObjectsRule.oneofinputobjectexpectedexactlyonefieldmessage(dispatch_arg_0, mut dispatch_arg_1))
		}
		'oneOfInputObjectFieldValueMustNotBeNullMessage' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return rt.new_string(Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_OneOfInputObjectsRule.oneofinputobjectfieldvaluemustnotbenullmessage(dispatch_arg_0, dispatch_arg_1))
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_OneOfInputObjectsRule) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_OneOfInputObjectsRule) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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



fn main() {
	defer {
		rt.shutdown()
	}

}
