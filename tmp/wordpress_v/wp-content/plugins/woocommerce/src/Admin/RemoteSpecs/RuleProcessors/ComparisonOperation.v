import rt

struct Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_ComparisonOperation {
	rt.PhpObjectBase
}

fn Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_ComparisonOperation.compare(var_left_operand rt.PhpVal, var_right_operand rt.PhpVal, var_operation rt.PhpVal) bool {
	mut switch_val_1 := var_operation
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('='))) {
		return (rt.identical(var_left_operand, var_right_operand)).to_bool()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('<'))) {
		return (rt.less(var_left_operand, var_right_operand)).to_bool()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('<='))) {
		return (rt.less_equal(var_left_operand, var_right_operand)).to_bool()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('>'))) {
		return (rt.greater(var_left_operand, var_right_operand)).to_bool()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('>='))) {
		return (rt.greater_equal(var_left_operand, var_right_operand)).to_bool()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('!='))) {
		return (// unsupported expression: Expr_BinaryOp_NotIdentical).to_bool()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('contains'))) {
		if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_left_operand.dup().is_array())) && rt.is_true(rt.new_bool(var_right_operand.dup().is_string())))) {
			return (rt.call_function('in_array', [var_right_operand.dup(), var_left_operand.dup(), rt.new_bool(true)])).to_bool()
		}
		if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_right_operand.dup().is_string())) && rt.is_true(rt.new_bool(var_left_operand.dup().is_string())))) {
			return (// unsupported expression: Expr_BinaryOp_NotIdentical).to_bool()
		}
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('!contains'))) {
		if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_left_operand.dup().is_array())) && rt.is_true(rt.new_bool(var_right_operand.dup().is_string())))) {
			return !(rt.is_true(rt.call_function('in_array', [var_right_operand.dup(), var_left_operand.dup(), rt.new_bool(true)])))
		}
		if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_right_operand.dup().is_string())) && rt.is_true(rt.new_bool(var_left_operand.dup().is_string())))) {
			return (rt.identical(rt.call_function('strpos', [var_right_operand.dup(), var_left_operand.dup()]), rt.new_bool(false))).to_bool()
		}
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('in'))) {
		if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_right_operand.dup().is_array())) && rt.is_true(rt.new_bool(var_left_operand.dup().is_string())))) {
			return (rt.call_function('in_array', [var_left_operand.dup(), var_right_operand.dup(), rt.new_bool(true)])).to_bool()
		}
		if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_left_operand.dup().is_string())) && rt.is_true(rt.new_bool(var_right_operand.dup().is_string())))) {
			return (// unsupported expression: Expr_BinaryOp_NotIdentical).to_bool()
		}
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('!in'))) {
		if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_right_operand.dup().is_array())) && rt.is_true(rt.new_bool(var_left_operand.dup().is_string())))) {
			return !(rt.is_true(rt.call_function('in_array', [var_left_operand.dup(), var_right_operand.dup(), rt.new_bool(true)])))
		}
		if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_left_operand.dup().is_string())) && rt.is_true(rt.new_bool(var_right_operand.dup().is_string())))) {
			return (rt.identical(rt.call_function('strpos', [var_left_operand.dup(), var_right_operand.dup()]), rt.new_bool(false))).to_bool()
		}
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('range'))) {
		if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_right_operand.dup().is_array()))))) || rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
			return false
		}
		return rt.is_true(rt.greater_equal(var_left_operand, var_right_operand.array_get(0))) && rt.is_true(rt.less_equal(var_left_operand, var_right_operand.array_get(1)))
	}
	return false
}

fn create_automattic_woocommerce_admin_remotespecs_ruleprocessors_comparisonoperation() &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_ComparisonOperation {
	mut obj := &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_ComparisonOperation{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_ComparisonOperation) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'compare' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return rt.new_bool(Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_ComparisonOperation.compare(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2))
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_ComparisonOperation) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_ComparisonOperation) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_admin_remotespecs_ruleprocessors_comparisonoperation_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
