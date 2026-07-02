import rt

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_ProvidedRequiredArguments {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_ProvidedRequiredArguments) getvisitor(mut var_context Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_QueryValidationContext) rt.PhpVal {
	mut var_providedRequiredArgumentsOnDirectives :=
		create_automattic_woocommerce_vendor_graphql_validator_rules_providedrequiredargumentsondirectives()
	closure_2_fn := fn [var_context] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_fieldNode := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_fieldDef := var_context.getfielddef()
		if rt.is_true(rt.identical(var_fieldDef, rt.new_null())) {
			mut iife_temp_1 := Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Visitor{}
			mut iife_result_1 := iife_temp_1.skipnode()
			return iife_result_1
		}
		mut var_argNodes := rt.get_property(var_fieldNode, 'arguments')
		mut var_argNodeMap := rt.new_array()
		mut iter_1 := var_argNodes.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_argNode := item_1.val
			var_argNodeMap.array_set(rt.get_property(rt.get_property(var_argNode, 'name'), 'value'),
				var_argNode.clone())
		}
		mut iter_2 := rt.get_property(var_fieldDef, 'args').iterator()
		for {
			item_2 := iter_2.next() or { break }
			mut var_argDef := item_2.val
			mut var_argNode := if !(var_argNodeMap.array_get(rt.get_property(var_argDef, 'name'))).is_null() {
				var_argNodeMap.array_get(rt.get_property(var_argDef, 'name'))
			} else {
				rt.new_null()
			}
			if rt.is_true(rt.identical(var_argNode, rt.new_null()))
				&& rt.is_true(rt.call_method(var_argDef, 'isRequired', []rt.PhpVal{})) {
				var_context.reporterror(create_automattic_woocommerce_vendor_graphql_error_error(Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_ProvidedRequiredArguments.missingfieldargmessage((rt.get_property(rt.get_property(var_fieldNode,
					'name'), 'value')).str(), (rt.get_property(var_argDef, 'name')).str(), (rt.call_method(rt.call_method(var_argDef,
					'getType', []rt.PhpVal{}), 'toString', []rt.PhpVal{})).str()), rt.create_array([
					rt.ArrayItem{ key: none, val: var_fieldNode },
				])))
			}
		}
		return rt.new_null()
	}
	return rt.add(var_providedRequiredArgumentsOnDirectives.getvisitor(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Validator_QueryValidationContext',
		[]string{}, var_context)), rt.create_array([
		rt.ArrayItem{
			key: Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeKind.field()
			val: rt.create_array([
				rt.ArrayItem{ key: 'leave', val: rt.new_closure(closure_2_fn) },
			])
		},
	]))
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_ProvidedRequiredArguments.missingfieldargmessage(fieldName string, argName string, type string) string {
	return "Field \"${var_fieldName}\" argument \"${var_argName}\" of type \"${var_type}\" is required but not provided."
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_ValidationRule {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_ProvidedRequiredArgumentsOnDirectives {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Visitor {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Error {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_vendor_graphql_validator_rules_providedrequiredarguments(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_ProvidedRequiredArguments {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_ProvidedRequiredArguments{
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

fn create_automattic_woocommerce_vendor_graphql_validator_rules_providedrequiredargumentsondirectives(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_ProvidedRequiredArgumentsOnDirectives {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_ProvidedRequiredArgumentsOnDirectives{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_language_visitor(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Visitor {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Visitor{
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

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_ProvidedRequiredArguments) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'getVisitor' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_QueryValidationContext](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.getvisitor(mut dispatch_arg_0)
		}
		'missingFieldArgMessage' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			return rt.new_string(Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_ProvidedRequiredArguments.missingfieldargmessage(dispatch_arg_0,
				dispatch_arg_1, dispatch_arg_2))
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_ProvidedRequiredArguments) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_ProvidedRequiredArguments) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_ProvidedRequiredArgumentsOnDirectives) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_ProvidedRequiredArgumentsOnDirectives) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_ProvidedRequiredArgumentsOnDirectives) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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
