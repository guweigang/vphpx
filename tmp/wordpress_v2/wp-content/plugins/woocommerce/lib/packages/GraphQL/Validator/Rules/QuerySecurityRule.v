import rt

pub fn Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_QuerySecurityRule.disabled() i64 {
	return 0
}
struct Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_QuerySecurityRule {
	rt.PhpObjectBase
pub mut:
		fragments rt.PhpVal = rt.new_array()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_QuerySecurityRule) checkifgreaterorequaltozero(name string, value i64) {
	if value < 0 {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_InvalidArgumentException', []string{}, create_automattic_woocommerce_vendor_graphql_validator_rules_invalidargumentexception(rt.concat(rt.concat(rt.new_string('$'), rt.new_string(name)), rt.new_string(' argument must be greater or equal to 0.')))))
	}
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_QuerySecurityRule) getfragment(mut var_fragmentSpread Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_FragmentSpreadNode) rt.PhpVal {
	return if !(this.fragments.array_get(rt.get_property(rt.get_property(var_fragmentSpread, 'name'), 'value'))).is_null() { this.fragments.array_get(rt.get_property(rt.get_property(var_fragmentSpread, 'name'), 'value')) } else { rt.new_null() }
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_QuerySecurityRule) getfragments() rt.PhpVal {
	return this.fragments
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_QuerySecurityRule) invokeifneeded(mut var_context Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_QueryValidationContext, mut var_validators Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_array) rt.PhpVal {
	if !(this.isenabled()) {
		return rt.new_array()
	}
	this.gatherfragmentdefinition(mut var_context)
	return rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_array', []string{}, var_validators)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_QuerySecurityRule) isenabled() bool {
	return false
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_QuerySecurityRule) gatherfragmentdefinition(mut var_context Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_QueryValidationContext) {
	mut var_definitions := rt.get_property(var_context.getdocument(), 'definitions')
	mut iter_1 := var_definitions.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_node := item_1.val
		if rt.is_true(rt.new_bool(rt.instance_of(var_node, 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_FragmentDefinitionNode'))) {
			this.fragments.array_set(rt.get_property(rt.get_property(var_node, 'name'), 'value'), var_node.clone())
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_QuerySecurityRule) collectfieldastsanddefs(mut var_context Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_QueryValidationContext, mut var_parentType Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_?Type, mut var_selectionSet Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_SelectionSetNode, mut var_visitedFragmentNames Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_?ArrayObject, mut var_astAndDefs Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_?ArrayObject) rt.PhpVal {
	mut var_visitedFragmentNames_mutated := var_visitedFragmentNames
	mut var_astAndDefs_mutated := var_astAndDefs
	rt.new_null()
	rt.new_null()
	mut iter_2 := rt.get_property(var_selectionSet, 'selections').iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_selection := item_2.val
		if rt.is_true(rt.new_bool(rt.instance_of(var_selection, 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_FieldNode'))) {
			mut var_fieldName := rt.get_property(rt.get_property(var_selection, 'name'), 'value')
			mut var_fieldDef := rt.new_null()
			if rt.is_true(rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_?Type', []string{}, var_parentType), 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_HasFieldsType'))) {
				mut iife_temp_0 := Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Introspection{}
				mut iife_result_0 := iife_temp_0.schemametafielddef()
				mut var_schemaMetaFieldDef := iife_result_0
				mut iife_temp_1 := Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Introspection{}
				mut iife_result_1 := iife_temp_1.typemetafielddef()
				mut var_typeMetaFieldDef := iife_result_1
				mut iife_temp_2 := Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Introspection{}
				mut iife_result_2 := iife_temp_2.typenamemetafielddef()
				mut var_typeNameMetaFieldDef := iife_result_2
				mut var_queryType := rt.call_method(var_context.getschema(), 'getQueryType', []rt.PhpVal{})
				if rt.is_true(rt.identical(var_fieldName, rt.get_property(var_schemaMetaFieldDef, 'name'))) && rt.is_true(rt.identical(var_queryType, var_parentType)) {
				var_fieldDef = var_schemaMetaFieldDef.clone()
				} else if rt.is_true(rt.identical(var_fieldName, rt.get_property(var_typeMetaFieldDef, 'name'))) && rt.is_true(rt.identical(var_queryType, var_parentType)) {
				var_fieldDef = var_typeMetaFieldDef.clone()
				} else if rt.is_true(rt.identical(var_fieldName, rt.get_property(var_typeNameMetaFieldDef, 'name'))) {
				var_fieldDef = var_typeNameMetaFieldDef.clone()
				} else if rt.is_true(var_parentType.hasfield(var_fieldName.clone())) {
				var_fieldDef = var_parentType.getfield(var_fieldName.clone())
				}
			}
			mut var_responseName := rt.new_string(this.getfieldname(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_FieldNode](var_selection)))
			mut var_responseContext := rt.new_null()
			var_responseContext.array_push(rt.create_array([rt.ArrayItem{ key: none, val: var_selection }, rt.ArrayItem{ key: none, val: var_fieldDef }]))
		} else if rt.is_true(rt.new_bool(rt.instance_of(var_selection, 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_InlineFragmentNode'))) {
		mut var_typeCondition := rt.get_property(var_selection, 'typeCondition')
		mut iife_temp_3 := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_AST{}
		mut iife_result_3 := iife_temp_3.typefromast(rt.create_array([rt.ArrayItem{ key: none, val: var_context.getschema() }, rt.ArrayItem{ key: none, val: 'getType' }]), var_typeCondition.clone())
		mut var_fragmentParentType := if rt.is_true(rt.identical(var_typeCondition, rt.new_null())) { var_parentType } else { iife_result_3 }
		var_astAndDefs_mutated = this.collectfieldastsanddefs(mut var_context, mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_?Type](var_fragmentParentType), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_SelectionSetNode](rt.get_property(var_selection, 'selectionSet')), mut var_visitedFragmentNames_mutated, mut var_astAndDefs_mutated)
		} else if rt.is_true(rt.new_bool(rt.instance_of(var_selection, 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_FragmentSpreadNode'))) {
			mut var_fragName := rt.get_property(rt.get_property(var_selection, 'name'), 'value')
			if var_visitedFragmentNames_mutated.array_isset(var_fragName) {
				continue
			}
			var_visitedFragmentNames_mutated.array_set(var_fragName, true)
			mut var_fragment := var_context.getfragment(var_fragName.clone())
			if rt.is_true(rt.identical(var_fragment, rt.new_null())) {
				continue
			}
		mut iife_temp_4 := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_AST{}
		mut iife_result_4 := iife_temp_4.typefromast(rt.create_array([rt.ArrayItem{ key: none, val: var_context.getschema() }, rt.ArrayItem{ key: none, val: 'getType' }]), rt.get_property(var_fragment, 'typeCondition'))
		var_astAndDefs_mutated = this.collectfieldastsanddefs(mut var_context, mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_?Type](iife_result_4), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_SelectionSetNode](rt.get_property(var_fragment, 'selectionSet')), mut var_visitedFragmentNames_mutated, mut var_astAndDefs_mutated)
		}
	}
	return rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_?ArrayObject', []string{}, var_astAndDefs_mutated)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_QuerySecurityRule) getfieldname(mut var_node Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_FieldNode) string {
	mut var_fieldName := rt.get_property(rt.get_property(var_node, 'name'), 'value')
	return (if rt.is_true(rt.identical(rt.get_property(var_node, 'alias'), rt.new_null())) { var_fieldName } else { rt.get_property(rt.get_property(var_node, 'alias'), 'value') }).str()
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_ValidationRule {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_InvalidArgumentException {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Introspection {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_AST {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_vendor_graphql_validator_rules_querysecurityrule(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_QuerySecurityRule {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_QuerySecurityRule{
		PhpObjectBase: rt.PhpObjectBase{}
		fragments: rt.new_array()
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_validator_rules_validationrule(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_ValidationRule {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_ValidationRule{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_validator_rules_invalidargumentexception(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_InvalidArgumentException {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_InvalidArgumentException{
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

fn create_automattic_woocommerce_vendor_graphql_utils_ast(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_AST {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_AST{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_QuerySecurityRule) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'checkIfGreaterOrEqualToZero' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			this.checkifgreaterorequaltozero(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'getFragment' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_FragmentSpreadNode](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.getfragment(mut dispatch_arg_0)
		}
		'getFragments' {
			return this.getfragments()
		}
		'invokeIfNeeded' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_QueryValidationContext](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_array](if args.len > 1 { args[1] } else { rt.new_null() })
			return this.invokeifneeded(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		'isEnabled' {
			return rt.new_bool(this.isenabled())
		}
		'gatherFragmentDefinition' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_QueryValidationContext](if args.len > 0 { args[0] } else { rt.new_null() })
			this.gatherfragmentdefinition(mut dispatch_arg_0)
			return rt.new_null()
		}
		'collectFieldASTsAndDefs' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_QueryValidationContext](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_?Type](if args.len > 1 { args[1] } else { rt.new_null() })
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_SelectionSetNode](if args.len > 2 { args[2] } else { rt.new_null() })
			mut dispatch_arg_3 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_?ArrayObject](if args.len > 3 { args[3] } else { rt.new_null() })
			mut dispatch_arg_4 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_?ArrayObject](if args.len > 4 { args[4] } else { rt.new_null() })
			return this.collectfieldastsanddefs(mut dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2, mut dispatch_arg_3, mut dispatch_arg_4)
		}
		'getFieldName' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_FieldNode](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_string(this.getfieldname(mut dispatch_arg_0))
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_QuerySecurityRule) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'fragments' { return this.fragments }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_QuerySecurityRule) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'fragments' { this.fragments = val; return true }
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


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_InvalidArgumentException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_InvalidArgumentException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_InvalidArgumentException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_AST) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_AST) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_AST) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}



fn main() {
	defer {
		rt.shutdown()
	}

}
