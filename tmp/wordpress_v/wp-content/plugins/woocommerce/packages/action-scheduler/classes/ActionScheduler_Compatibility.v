import rt

struct Class_ActionScheduler_Compatibility {
	rt.PhpObjectBase
}

fn Class_ActionScheduler_Compatibility.convert_hr_to_bytes(var_value rt.PhpVal) rt.PhpVal {
	mut var_value_mutated := var_value
	if rt.is_true(rt.call_function('function_exists', [rt.new_string('wp_convert_hr_to_bytes')])) {
		return rt.call_function('wp_convert_hr_to_bytes', [var_value_mutated.dup()])
	}
	var_value_mutated = rt.new_string(rt.new_string(var_value_mutated.dup().to_string().trim_space().to_lower()))
	mut var_bytes := // unsupported expression: Expr_Cast_Int
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		// unsupported expression: Expr_AssignOp_Mul
	} else if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		// unsupported expression: Expr_AssignOp_Mul
	} else if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		// unsupported expression: Expr_AssignOp_Mul
	}
	return rt.call_function('min', [var_bytes.dup(), rt.get_constant('PHP_INT_MAX')])
}

fn Class_ActionScheduler_Compatibility.raise_memory_limit() bool {
	if rt.is_true(rt.call_function('function_exists', [rt.new_string('wp_raise_memory_limit')])) {
		return (rt.call_function('wp_raise_memory_limit', [rt.new_string('admin')])).to_bool()
	}
	mut var_current_limit := rt.call_function('ini_get', [rt.new_string('memory_limit')])
	mut var_current_limit_int := Class_ActionScheduler_Compatibility.convert_hr_to_bytes(var_current_limit.dup())
	if rt.is_true(rt.identical(// unsupported expression: Expr_UnaryMinus, var_current_limit_int)) {
		return false
	}
	mut var_wp_max_limit := rt.get_constant('WP_MAX_MEMORY_LIMIT')
	mut var_wp_max_limit_int := Class_ActionScheduler_Compatibility.convert_hr_to_bytes(var_wp_max_limit.dup())
	mut var_filtered_limit := rt.call_function('apply_filters', [rt.new_string('admin_memory_limit'), var_wp_max_limit.dup()])
	mut var_filtered_limit_int := Class_ActionScheduler_Compatibility.convert_hr_to_bytes(var_filtered_limit.dup())
	if rt.is_true(rt.new_bool(rt.is_true(rt.identical(// unsupported expression: Expr_UnaryMinus, var_filtered_limit_int)) || rt.is_true(rt.new_bool(rt.is_true(rt.greater(var_filtered_limit_int, var_wp_max_limit_int)) && rt.is_true(rt.greater(var_filtered_limit_int, var_current_limit_int)))))) {
		if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
			return (var_filtered_limit).to_bool()
		} else {
			return false
		}
	} else if rt.is_true(rt.new_bool(rt.is_true(rt.identical(// unsupported expression: Expr_UnaryMinus, var_wp_max_limit_int)) || rt.is_true(rt.greater(var_wp_max_limit_int, var_current_limit_int)))) {
		if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
			return (var_wp_max_limit).to_bool()
		} else {
			return false
		}
	}
	return false
}

fn Class_ActionScheduler_Compatibility.raise_time_limit(limit i64)  {
	mut limit_mutated := limit
	limit_mutated = (// unsupported expression: Expr_Cast_Int).to_i64()
	mut var_max_execution_time := // unsupported expression: Expr_Cast_Int
	if rt.is_true(rt.identical(rt.new_int(0), var_max_execution_time)) {
		return rt.new_null()
	}
	mut var_raise_by := if rt.is_true(rt.new_bool(0 == limit_mutated || rt.is_true(rt.greater(rt.new_int(limit_mutated), var_max_execution_time)))) { rt.new_int(limit_mutated) } else { var_max_execution_time }
	if rt.is_true(rt.call_function('function_exists', [rt.new_string('wc_set_time_limit')])) {
		rt.call_function('wc_set_time_limit', [var_raise_by.dup()])
	} else if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.call_function('function_exists', [rt.new_string('set_time_limit')])) && rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('strpos', [rt.call_function('ini_get', [rt.new_string('disable_functions')]), rt.new_string('set_time_limit')]))))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('ini_get', [rt.new_string('safe_mode')]))))))) {
		rt.call_function('set_time_limit', [var_raise_by.dup()])
		// unsupported statement: Stmt_Nop
	}
}

fn create_actionscheduler_compatibility() &Class_ActionScheduler_Compatibility {
	mut obj := &Class_ActionScheduler_Compatibility{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_ActionScheduler_Compatibility) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'convert_hr_to_bytes' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_ActionScheduler_Compatibility.convert_hr_to_bytes(dispatch_arg_0)
		}
		'raise_memory_limit' {
			return rt.new_bool(Class_ActionScheduler_Compatibility.raise_memory_limit())
		}
		'raise_time_limit' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			Class_ActionScheduler_Compatibility.raise_time_limit(dispatch_arg_0)
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_ActionScheduler_Compatibility) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ActionScheduler_Compatibility) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_packages_action_scheduler_classes_actionscheduler_compatibility_php() {
}
