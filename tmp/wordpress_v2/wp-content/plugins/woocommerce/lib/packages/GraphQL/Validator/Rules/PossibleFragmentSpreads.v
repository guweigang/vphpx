import rt

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_PossibleFragmentSpreads {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_PossibleFragmentSpreads) getvisitor(mut var_context Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_QueryValidationContext) rt.PhpVal {
	closure_1_fn := fn [var_context] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_node := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_fragType := var_context.gettype()
		mut var_parentType := var_context.getparenttype()
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_fragType, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_CompositeType'))))))
			|| rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_parentType, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_CompositeType'))))))
			|| this.dotypesoverlap(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema](var_context.getschema()), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_CompositeType](var_fragType), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_CompositeType](var_parentType)) {
			return rt.new_null()
		}
		var_context.reporterror(create_automattic_woocommerce_vendor_graphql_error_error(Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_PossibleFragmentSpreads.typeincompatibleanonspreadmessage((rt.call_method(var_parentType,
			'toString', []rt.PhpVal{})).str(), (rt.call_method(var_fragType, 'toString',
			[]rt.PhpVal{})).str()), rt.create_array([
			rt.ArrayItem{ key: none, val: var_node },
		])))
		return rt.new_null()
	}
	closure_2_fn := fn [var_context] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_node := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_fragName := rt.get_property(rt.get_property(var_node, 'name'), 'value')
		mut var_fragType := this.getfragmenttype(mut rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Validator_QueryValidationContext',
			[]string{}, var_context), var_fragName.str())
		mut var_parentType := var_context.getparenttype()
		if rt.is_true(rt.identical(var_fragType, rt.new_null()))
			|| rt.is_true(rt.identical(var_parentType, rt.new_null()))
			|| this.dotypesoverlap(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema](var_context.getschema()), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_CompositeType](var_fragType), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_CompositeType](var_parentType)) {
			return rt.new_null()
		}
		var_context.reporterror(create_automattic_woocommerce_vendor_graphql_error_error(Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_PossibleFragmentSpreads.typeincompatiblespreadmessage(var_fragName.str(), (rt.call_method(var_parentType,
			'toString', []rt.PhpVal{})).str(), (rt.call_method(var_fragType, 'toString',
			[]rt.PhpVal{})).str()), rt.create_array([
			rt.ArrayItem{ key: none, val: var_node },
		])))
		return rt.new_null()
	}
	return rt.create_array([
		rt.ArrayItem{
			key: Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeKind.inline_fragment()
			val: rt.new_closure(closure_1_fn)
		},
		rt.ArrayItem{
			key: Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeKind.fragment_spread()
			val: rt.new_closure(closure_2_fn)
		},
	])
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_PossibleFragmentSpreads) dotypesoverlap(mut var_schema Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema, mut var_fragType Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_CompositeType, mut var_parentType Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_CompositeType) bool {
	if rt.is_true(rt.identical(var_parentType, var_fragType)) {
		return true
	}
	if rt.is_true(rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_CompositeType', []string{}, var_parentType), 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_AbstractType')))
		&& rt.is_true(rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_CompositeType', []string{}, var_fragType), 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ObjectType'))) {
		return (var_schema.issubtype(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_CompositeType',
			[]string{}, var_parentType), rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_CompositeType',
			[]string{}, var_fragType))).to_bool()
	}
	if rt.is_true(rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_CompositeType', []string{}, var_parentType), 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ObjectType')))
		&& rt.is_true(rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_CompositeType', []string{}, var_fragType), 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_AbstractType'))) {
		return (var_schema.issubtype(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_CompositeType',
			[]string{}, var_fragType), rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_CompositeType',
			[]string{}, var_parentType))).to_bool()
	}
	if rt.is_true(rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_CompositeType', []string{}, var_parentType), 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ObjectType')))
		&& rt.is_true(rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_CompositeType', []string{}, var_fragType), 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ObjectType'))) {
		return (rt.identical(var_parentType, var_fragType)).to_bool()
	}
	if rt.is_true(rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_CompositeType', []string{}, var_parentType), 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InterfaceType')))
		&& rt.is_true(rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_CompositeType', []string{}, var_fragType), 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InterfaceType'))) {
		return true
	}
	if rt.is_true(rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_CompositeType', []string{}, var_parentType), 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_UnionType')))
		&& rt.is_true(rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_CompositeType', []string{}, var_fragType), 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InterfaceType'))) {
		mut iter_1 := var_parentType.gettypes().iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_type := item_1.val
			if rt.is_true(rt.call_method(var_type, 'implementsInterface', [
				var_fragType,
			]))
			{
				return true
			}
		}
	}
	if rt.is_true(rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_CompositeType', []string{}, var_parentType), 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InterfaceType')))
		&& rt.is_true(rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_CompositeType', []string{}, var_fragType), 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_UnionType'))) {
		mut iter_2 := var_fragType.gettypes().iterator()
		for {
			item_2 := iter_2.next() or { break }
			mut var_type := item_2.val
			if rt.is_true(rt.call_method(var_type, 'implementsInterface', [
				var_parentType,
			]))
			{
				return true
			}
		}
	}
	if rt.is_true(rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_CompositeType', []string{}, var_parentType), 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_UnionType')))
		&& rt.is_true(rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_CompositeType', []string{}, var_fragType), 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_UnionType'))) {
		mut iter_3 := var_fragType.gettypes().iterator()
		for {
			item_3 := iter_3.next() or { break }
			mut var_type := item_3.val
			if rt.is_true(var_parentType.ispossibletype(var_type.clone())) {
				return true
			}
		}
	}
	return false
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_PossibleFragmentSpreads.typeincompatibleanonspreadmessage(parentType string, fragType string) string {
	return "Fragment cannot be spread here as objects of type \"${var_parentType}\" can never be of type \"${var_fragType}\"."
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_PossibleFragmentSpreads) getfragmenttype(mut var_context Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_QueryValidationContext, name string) rt.PhpVal {
	mut var_frag := var_context.getfragment(rt.new_string(name))
	if rt.is_true(rt.identical(var_frag, rt.new_null())) {
		return rt.new_null()
	}
	mut iife_temp_2 := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_AST{}
	mut iife_result_2 := iife_temp_2.typefromast(rt.create_array([
		rt.ArrayItem{ key: none, val: var_context.getschema() },
		rt.ArrayItem{ key: none, val: 'getType' },
	]), rt.get_property(var_frag, 'typeCondition'))
	mut var_type := iife_result_2
	return if rt.is_true(rt.new_bool(rt.instance_of(var_type,
		'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_CompositeType')))
	{
		var_type
	} else {
		rt.new_null()
	}
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_PossibleFragmentSpreads.typeincompatiblespreadmessage(fragName string, parentType string, fragType string) string {
	return "Fragment \"${var_fragName}\" cannot be spread here as objects of type \"${var_parentType}\" can never be of type \"${var_fragType}\"."
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_ValidationRule {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Error {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_AST {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_vendor_graphql_validator_rules_possiblefragmentspreads(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_PossibleFragmentSpreads {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_PossibleFragmentSpreads{
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

fn create_automattic_woocommerce_vendor_graphql_error_error(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Error {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Error{
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

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_PossibleFragmentSpreads) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'getVisitor' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_QueryValidationContext](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.getvisitor(mut dispatch_arg_0)
		}
		'doTypesOverlap' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_CompositeType](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_CompositeType](if args.len > 2 {
				args[2]
			} else {
				rt.new_null()
			})
			return rt.new_bool(this.dotypesoverlap(mut dispatch_arg_0, mut dispatch_arg_1, mut
				dispatch_arg_2))
		}
		'typeIncompatibleAnonSpreadMessage' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return rt.new_string(Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_PossibleFragmentSpreads.typeincompatibleanonspreadmessage(dispatch_arg_0,
				dispatch_arg_1))
		}
		'getFragmentType' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_QueryValidationContext](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return this.getfragmenttype(mut dispatch_arg_0, dispatch_arg_1)
		}
		'typeIncompatibleSpreadMessage' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			return rt.new_string(Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_PossibleFragmentSpreads.typeincompatiblespreadmessage(dispatch_arg_0,
				dispatch_arg_1, dispatch_arg_2))
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_PossibleFragmentSpreads) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_PossibleFragmentSpreads) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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
