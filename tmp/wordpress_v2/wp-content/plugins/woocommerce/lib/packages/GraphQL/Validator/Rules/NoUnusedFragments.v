import rt

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_NoUnusedFragments {
	rt.PhpObjectBase
pub mut:
	operationDefs rt.PhpVal = rt.new_null()
	fragmentDefs  rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_NoUnusedFragments) getvisitor(mut var_context Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_QueryValidationContext) rt.PhpVal {
	this.operationDefs = rt.new_array()
	this.fragmentDefs = rt.new_array()
	closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_node := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		this.operationDefs.array_push(var_node.clone())
		mut iife_temp_1 := Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Visitor{}
		mut iife_result_1 := iife_temp_1.skipnode()
		return iife_result_1
	}
	closure_4_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_def := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		this.fragmentDefs.array_push(var_def.clone())
		mut iife_temp_3 := Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Visitor{}
		mut iife_result_3 := iife_temp_3.skipnode()
		return iife_result_3
	}
	closure_5_fn := fn [var_context] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_fragmentNameUsed := rt.new_array()
		mut iter_1 := this.operationDefs.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_operation := item_1.val
			mut iter_2 :=
				var_context.getrecursivelyreferencedfragments(var_operation.clone()).iterator()
			for {
				item_2 := iter_2.next() or { break }
				mut var_fragment := item_2.val
				var_fragmentNameUsed.array_set(rt.get_property(rt.get_property(var_fragment, 'name'),
					'value'), true)
			}
		}
		mut iter_3 := this.fragmentDefs.iterator()
		for {
			item_3 := iter_3.next() or { break }
			mut var_fragmentDef := item_3.val
			mut var_fragName := rt.get_property(rt.get_property(var_fragmentDef, 'name'), 'value')
			if !(var_fragmentNameUsed.array_isset(var_fragName)) {
				var_context.reporterror(create_automattic_woocommerce_vendor_graphql_error_error(Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_NoUnusedFragments.unusedfragmessage(var_fragName.str()), rt.create_array([
					rt.ArrayItem{ key: none, val: var_fragmentDef },
				])))
			}
		}
		return rt.new_null()
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
		rt.ArrayItem{
			key: Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeKind.document()
			val: rt.create_array([
				rt.ArrayItem{ key: 'leave', val: rt.new_closure(closure_5_fn) },
			])
		},
	])
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_NoUnusedFragments.unusedfragmessage(fragName string) string {
	return "Fragment \"${var_fragName}\" is never used."
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

fn create_automattic_woocommerce_vendor_graphql_validator_rules_nounusedfragments(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_NoUnusedFragments {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_NoUnusedFragments{
		PhpObjectBase: rt.PhpObjectBase{}
		operationDefs: rt.new_null()
		fragmentDefs:  rt.new_null()
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

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_NoUnusedFragments) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'getVisitor' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_QueryValidationContext](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.getvisitor(mut dispatch_arg_0)
		}
		'unusedFragMessage' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_NoUnusedFragments.unusedfragmessage(dispatch_arg_0))
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_NoUnusedFragments) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'operationDefs' { return this.operationDefs }
		'fragmentDefs' { return this.fragmentDefs }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_NoUnusedFragments) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'operationDefs' {
			this.operationDefs = val
			return true
		}
		'fragmentDefs' {
			this.fragmentDefs = val
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
