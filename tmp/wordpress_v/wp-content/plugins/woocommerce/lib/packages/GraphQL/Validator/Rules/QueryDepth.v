import rt

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_QueryDepth {
	rt.PhpObjectBase
pub mut:
		calculatedFragments rt.PhpVal = rt.new_array()
		maxQueryDepth i64
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_QueryDepth) construct(maxQueryDepth i64)  {
	this.setmaxquerydepth(maxQueryDepth)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_QueryDepth) getvisitor(mut var_context Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_QueryValidationContext) rt.PhpVal {
	closure_1_fn := fn [var_context] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_operationDefinition := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	mut var_maxDepth := rt.new_int(this.fielddepth(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Node](var_operationDefinition), 0, 0))
	if rt.is_true(rt.less_equal(var_maxDepth, this.maxQueryDepth)) {
		return rt.new_null()
	}
	var_context.reporterror(create_automattic_woocommerce_vendor_graphql_error_error(Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_QueryDepth.maxquerydeptherrormessage(this.maxQueryDepth, (var_maxDepth).to_i64())))
	return rt.new_null()
	}
	return this.invokeifneeded(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Validator_QueryValidationContext', []string{}, var_context), rt.create_array([rt.ArrayItem{ key: Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeKind.operation_definition(), val: rt.create_array([rt.ArrayItem{ key: 'leave', val: rt.new_closure(closure_1_fn) }]) }]))
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_QueryDepth) fielddepth(mut var_node Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Node, depth i64, maxDepth i64) i64 {
	mut maxDepth_mutated := maxDepth
	if rt.is_true(rt.new_bool(rt.instance_of(rt.get_property(var_node, 'selectionSet'), 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_SelectionSetNode'))) {
		{
			mut iter_1 := rt.get_property(rt.get_property(var_node, 'selectionSet'), 'selections').iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_childNode := item_1.val
				maxDepth_mutated = this.nodedepth(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Node](var_childNode), depth, maxDepth_mutated)
			}
		}
	}
	return maxDepth_mutated
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_QueryDepth) nodedepth(mut var_node Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Node, depth i64, maxDepth i64) i64 {
	mut maxDepth_mutated := maxDepth
	mut switch_val_1 := rt.new_bool(true)
	if rt.is_true(rt.equal(switch_val_1, rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Node', []string{}, var_node), 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_FieldNode')))) {
		if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
			if depth > maxDepth_mutated {
				maxDepth_mutated = depth
			}
			maxDepth_mutated = this.fielddepth(mut var_node, depth + 1, maxDepth_mutated)
		}
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Node', []string{}, var_node), 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_InlineFragmentNode')))) {
		maxDepth_mutated = this.fielddepth(mut var_node, depth, maxDepth_mutated)
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Node', []string{}, var_node), 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_FragmentSpreadNode')))) {
		mut var_fragment := this.getfragment(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Node', []string{}, var_node))
		if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
			mut var_name := rt.get_property(rt.get_property(var_fragment, 'name'), 'value')
			if this.calculatedFragments.array_isset(var_name) {
				return this.maxQueryDepth + 1
			}
			this.calculatedFragments.array_set(var_name, true)
			maxDepth_mutated = this.fielddepth(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Node](var_fragment), depth, maxDepth_mutated)
			this.calculatedFragments.array_unset(var_name)
		}
	}
	return maxDepth_mutated
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_QueryDepth) getmaxquerydepth() i64 {
	return this.maxQueryDepth
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_QueryDepth) setmaxquerydepth(maxQueryDepth i64)  {
	this.checkifgreaterorequaltozero(rt.new_string('maxQueryDepth'), rt.new_int(maxQueryDepth))
	this.maxQueryDepth = maxQueryDepth
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_QueryDepth.maxquerydeptherrormessage(max i64, count i64) string {
	return "Max query depth should be ${var_max.str()} but got ${var_count.str()}."
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_QueryDepth) isenabled() bool {
	return (// unsupported expression: Expr_BinaryOp_NotIdentical).to_bool()
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_QuerySecurityRule {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Error {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_vendor_graphql_validator_rules_querydepth(maxQueryDepth i64) &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_QueryDepth {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_QueryDepth{
		PhpObjectBase: rt.PhpObjectBase{}
		calculatedFragments: rt.new_array()
		maxQueryDepth: i64(0)
	}
	obj.construct(maxQueryDepth)
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_validator_rules_querysecurityrule() &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_QuerySecurityRule {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_QuerySecurityRule{
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

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_QueryDepth) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'getVisitor' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_QueryValidationContext](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.getvisitor(mut dispatch_arg_0)
		}
		'fieldDepth' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Node](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_i64()
			return rt.new_int(this.fielddepth(mut dispatch_arg_0, dispatch_arg_1, dispatch_arg_2))
		}
		'nodeDepth' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Node](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_i64()
			return rt.new_int(this.nodedepth(mut dispatch_arg_0, dispatch_arg_1, dispatch_arg_2))
		}
		'getMaxQueryDepth' {
			return rt.new_int(this.getmaxquerydepth())
		}
		'setMaxQueryDepth' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			this.setmaxquerydepth(dispatch_arg_0)
			return rt.new_null()
		}
		'maxQueryDepthErrorMessage' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			return rt.new_string(Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_QueryDepth.maxquerydeptherrormessage(dispatch_arg_0, dispatch_arg_1))
		}
		'isEnabled' {
			return rt.new_bool(this.isenabled())
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_QueryDepth) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'calculatedFragments' { return this.calculatedFragments }
		'maxQueryDepth' { return rt.new_int(this.maxQueryDepth) }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_QueryDepth) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'calculatedFragments' { this.calculatedFragments = val; return true }
		'maxQueryDepth' { this.maxQueryDepth = (val).to_i64(); return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_QuerySecurityRule) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_QuerySecurityRule) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_QuerySecurityRule) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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




pub fn init_wp_content_plugins_woocommerce_lib_packages_graphql_validator_rules_querydepth_php() {
	// unsupported statement: Stmt_Declare
}
