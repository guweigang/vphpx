import rt

struct Class_CronExpression_AbstractField {
	rt.PhpObjectBase
}

fn (mut this Class_CronExpression_AbstractField) issatisfied(var_dateValue rt.PhpVal, var_value rt.PhpVal) bool {
	if rt.is_true(this.isincrementsofranges(var_value.dup())) {
		return this.isinincrementsofranges(var_dateValue.dup(), var_value.dup())
	} else if rt.is_true(this.isrange(var_value.dup())) {
		return this.isinrange(var_dateValue.dup(), var_value.dup())
	}
	return rt.is_true(rt.equal(var_value, rt.new_string('*'))) || rt.is_true(rt.equal(var_dateValue, var_value))
}

fn (mut this Class_CronExpression_AbstractField) isrange(var_value rt.PhpVal) rt.PhpVal {
	return // unsupported expression: Expr_BinaryOp_NotIdentical
}

fn (mut this Class_CronExpression_AbstractField) isincrementsofranges(var_value rt.PhpVal) rt.PhpVal {
	return // unsupported expression: Expr_BinaryOp_NotIdentical
}

fn (mut this Class_CronExpression_AbstractField) isinrange(var_dateValue rt.PhpVal, var_value rt.PhpVal) bool {
	mut var_parts := rt.call_function('array_map', [rt.new_string('trim'), rt.call_function('explode', [rt.new_string('-'), var_value.dup(), rt.new_int(2)])])
	return rt.is_true(rt.greater_equal(var_dateValue, var_parts.array_get(0))) && rt.is_true(rt.less_equal(var_dateValue, var_parts.array_get(1)))
}

fn (mut this Class_CronExpression_AbstractField) isinincrementsofranges(var_dateValue rt.PhpVal, var_value rt.PhpVal) bool {
	mut var_parts := rt.call_function('array_map', [rt.new_string('trim'), rt.call_function('explode', [rt.new_string('/'), var_value.dup(), rt.new_int(2)])])
	mut var_stepSize := if var_parts.array_isset(rt.new_int(1)) { var_parts.array_get(1) } else { rt.new_int(0) }
	if rt.is_true(rt.new_bool(rt.is_true(rt.equal(var_parts.array_get(0), rt.new_string('*'))) || rt.is_true(rt.identical(var_parts.array_get(0), rt.new_string('0'))))) {
		return (rt.equal(rt.mod_(// unsupported expression: Expr_Cast_Int, var_stepSize), rt.new_int(0))).to_bool()
	}
	mut var_range := rt.call_function('explode', [rt.new_string('-'), var_parts.array_get(0), rt.new_int(2)])
	mut var_offset := var_range.array_get(0)
	mut var_to := if var_range.array_isset(rt.new_int(1)) { var_range.array_get(1) } else { var_dateValue }
	if rt.is_true(rt.new_bool(rt.is_true(rt.less(var_dateValue, var_offset)) || rt.is_true(rt.greater(var_dateValue, var_to)))) {
		return false
	}
	{
		mut var_i := var_offset.dup()
		for {
			if !(rt.is_true(rt.less_equal(var_i, var_to))) { break }
			if rt.is_true(rt.equal(var_i, var_dateValue)) {
				return true
			}
			// unsupported expression: Expr_AssignOp_Plus
		}
	}
	return false
}

fn create_cronexpression_abstractfield() &Class_CronExpression_AbstractField {
	mut obj := &Class_CronExpression_AbstractField{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_CronExpression_AbstractField) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'isSatisfied' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(this.issatisfied(dispatch_arg_0, dispatch_arg_1))
		}
		'isRange' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.isrange(dispatch_arg_0)
		}
		'isIncrementsOfRanges' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.isincrementsofranges(dispatch_arg_0)
		}
		'isInRange' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(this.isinrange(dispatch_arg_0, dispatch_arg_1))
		}
		'isInIncrementsOfRanges' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(this.isinincrementsofranges(dispatch_arg_0, dispatch_arg_1))
		}
		else { return none }
	}
}

fn (this &Class_CronExpression_AbstractField) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_CronExpression_AbstractField) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_packages_action_scheduler_lib_cron_expression_cronexpression_abstractfield_php() {
}
