import rt

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_NoFragmentCycles {
	rt.PhpObjectBase
pub mut:
	visitedFrags          rt.PhpVal = rt.new_null()
	spreadPath            rt.PhpVal = rt.new_null()
	spreadPathIndexByName rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_NoFragmentCycles) getvisitor(mut var_context Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_QueryValidationContext) rt.PhpVal {
	this.visitedFrags = rt.new_array()
	this.spreadPath = rt.new_array()
	this.spreadPathIndexByName = rt.new_array()
	closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut iife_temp_1 := Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Visitor{}
		mut iife_result_1 := iife_temp_1.skipnode()
		return iife_result_1
	}
	closure_4_fn := fn [var_context] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_node := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		this.detectcyclerecursive(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_FragmentDefinitionNode](var_node), mut rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Validator_QueryValidationContext',
			[]string{}, var_context))
		mut iife_temp_3 := Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Visitor{}
		mut iife_result_3 := iife_temp_3.skipnode()
		return iife_result_3
	}
	return rt.create_array([
		rt.ArrayItem{
			key: Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeKind.operation_definition()
			val: rt.new_closure(closure_2_fn)
		},
		rt.ArrayItem{
			key: Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeKind.fragment_definition()
			val: rt.new_closure(closure_4_fn)
		},
	])
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_NoFragmentCycles) detectcyclerecursive(mut var_fragment Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_FragmentDefinitionNode, mut var_context Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_QueryValidationContext) {
	if this.visitedFrags.array_isset(rt.get_property(rt.get_property(var_fragment, 'name'), 'value')) {
		return
	}
	mut var_fragmentName := rt.get_property(rt.get_property(var_fragment, 'name'), 'value')
	this.visitedFrags.array_set(var_fragmentName, true)
	mut var_spreadNodes := var_context.getfragmentspreads(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_FragmentDefinitionNode',
		[]string{}, var_fragment))
	if rt.is_true(rt.identical(var_spreadNodes, rt.new_array())) {
		return
	}
	this.spreadPathIndexByName.array_set(var_fragmentName, this.spreadPath.array_count())
	mut iter_1 := var_spreadNodes.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_spreadNode := item_1.val
		mut var_spreadName := rt.get_property(rt.get_property(var_spreadNode, 'name'), 'value')
		mut var_cycleIndex := if !(this.spreadPathIndexByName.array_get(var_spreadName)).is_null() {
			this.spreadPathIndexByName.array_get(var_spreadName)
		} else {
			rt.new_null()
		}
		this.spreadPath.array_push(var_spreadNode.clone())
		if rt.is_true(rt.identical(var_cycleIndex, rt.new_null())) {
			mut var_spreadFragment := var_context.getfragment(var_spreadName.clone())
			if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_spreadFragment, rt.new_null())))) {
				this.detectcyclerecursive(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_FragmentDefinitionNode](var_spreadFragment), mut
					var_context)
			}
		} else {
			mut var_cyclePath := rt.call_function('array_slice',
				[this.spreadPath, var_cycleIndex.clone()])
			mut var_fragmentNames := rt.new_array()
			mut iter_2 := rt.call_function('array_slice', [var_cyclePath.clone(),
				rt.new_int(0), rt.new_int(-1)]).iterator()
			for {
				item_2 := iter_2.next() or { break }
				mut var_frag := item_2.val
				var_fragmentNames.array_push(rt.get_property(rt.get_property(var_frag, 'name'),
					'value'))
			}
			var_context.reporterror(create_automattic_woocommerce_vendor_graphql_error_error(Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_NoFragmentCycles.cycleerrormessage(var_spreadName.str(), mut
				rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_array](var_fragmentNames)),
				var_cyclePath.clone()))
		}
		rt.call_function('array_pop', [this.spreadPath])
	}
	this.spreadPathIndexByName.array_set(var_fragmentName, rt.new_null())
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_NoFragmentCycles.cycleerrormessage(fragName string, mut var_spreadNames Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_array) string {
	mut var_via := rt.new_string((if rt.is_true(rt.identical(var_spreadNames, rt.new_array())) {
		''
	} else {
		' via ' + (rt.call_function('implode', [rt.new_string(', '), var_spreadNames])).str()
	}).str())
	return "Cannot spread fragment \"${var_fragName}\" within itself${var_via.to_string()}."
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_ValidationRule {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Visitor {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Error {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_vendor_graphql_validator_rules_nofragmentcycles(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_NoFragmentCycles {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_NoFragmentCycles{
		PhpObjectBase:         rt.PhpObjectBase{}
		visitedFrags:          rt.new_null()
		spreadPath:            rt.new_null()
		spreadPathIndexByName: rt.new_null()
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_validator_rules_validationrule(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_ValidationRule {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_ValidationRule{
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

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_NoFragmentCycles) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'getVisitor' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_QueryValidationContext](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.getvisitor(mut dispatch_arg_0)
		}
		'detectCycleRecursive' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_FragmentDefinitionNode](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_QueryValidationContext](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			this.detectcyclerecursive(mut dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'cycleErrorMessage' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_array](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			return rt.new_string(Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_NoFragmentCycles.cycleerrormessage(dispatch_arg_0, mut
				dispatch_arg_1))
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_NoFragmentCycles) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'visitedFrags' { return this.visitedFrags }
		'spreadPath' { return this.spreadPath }
		'spreadPathIndexByName' { return this.spreadPathIndexByName }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_NoFragmentCycles) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'visitedFrags' {
			this.visitedFrags = val
			return true
		}
		'spreadPath' {
			this.spreadPath = val
			return true
		}
		'spreadPathIndexByName' {
			this.spreadPathIndexByName = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
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
