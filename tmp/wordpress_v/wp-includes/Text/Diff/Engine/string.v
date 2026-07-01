import rt

struct Class_Text_Diff_Engine_string {
	rt.PhpObjectBase
}

fn (mut this Class_Text_Diff_Engine_string) diff(var_diff rt.PhpVal, mode string) rt.PhpVal {
	mut var_diff_mutated := var_diff
	mut mode_mutated := mode
	mut var_lnbr := rt.new_string(rt.new_string('\n'))
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		var_lnbr = rt.new_string(rt.new_string('\r\n'))
	} else if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		var_lnbr = rt.new_string(rt.new_string('\r'))
	}
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotEqual) {
		// unsupported expression: Expr_AssignOp_Concat
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotEqual) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotEqual))) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotEqual))) {
		return fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_PEAR{}; return temp.raiseerror(arg_0) }(rt.new_string('Type of diff is unsupported'))
	}
	if rt.is_true(rt.equal(rt.new_string(mode_mutated), rt.new_string('autodetect'))) {
		mut var_context := rt.call_function('strpos', [var_diff_mutated.dup(), rt.new_string('***')])
		mut var_unified := rt.call_function('strpos', [var_diff_mutated.dup(), rt.new_string('---')])
		if rt.is_true(rt.identical(var_context, var_unified)) {
			return fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_PEAR{}; return temp.raiseerror(arg_0) }(rt.new_string('Type of diff could not be detected'))
		} else if rt.is_true(rt.new_bool(rt.is_true(rt.identical(var_context, rt.new_bool(false))) || rt.is_true(rt.identical(var_unified, rt.new_bool(false))))) {
			mode_mutated = if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) { 'context' } else { 'unified' }
		} else {
			mode_mutated = if rt.is_true(rt.less(var_context, var_unified)) { 'context' } else { 'unified' }
		}
	}
	var_diff_mutated = rt.call_function('explode', [var_lnbr.dup(), var_diff_mutated.dup()])
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.equal(rt.new_string(mode_mutated), rt.new_string('context'))) && rt.is_true(rt.identical(rt.call_function('strpos', [var_diff_mutated.array_get(0), rt.new_string('***')]), rt.new_int(0))))) || rt.is_true(rt.new_bool(rt.is_true(rt.equal(rt.new_string(mode_mutated), rt.new_string('unified'))) && rt.is_true(rt.identical(rt.call_function('strpos', [var_diff_mutated.array_get(0), rt.new_string('---')]), rt.new_int(0))))))) {
		rt.call_function('array_shift', [var_diff_mutated.dup()])
		rt.call_function('array_shift', [var_diff_mutated.dup()])
	}
	if rt.is_true(rt.equal(rt.new_string(mode_mutated), rt.new_string('context'))) {
		return this.parsecontextdiff(var_diff_mutated.dup())
	} else {
		return this.parseunifieddiff(var_diff_mutated.dup())
	}
	return rt.new_null()
}

fn (mut this Class_Text_Diff_Engine_string) parseunifieddiff(var_diff rt.PhpVal) rt.PhpVal {
	mut var_diff_mutated := var_diff
	mut var_edits := []rt.PhpVal{}
	mut var_end := rt.new_int(var_diff_mutated.dup().array_count() - 1)
	{
		mut var_i := rt.new_int(rt.new_int(0))
		for {
			if !(rt.is_true(rt.less(var_i, var_end))) { break }
			mut var_diff1 := []rt.PhpVal{}
			mut switch_val_1 := rt.call_function('substr', [var_diff_mutated.array_get(var_i), rt.new_int(0), rt.new_int(1)])
			if rt.is_true(rt.equal(switch_val_1, rt.new_string(' '))) {
				for {
					var_diff1.array_push(rt.call_function('substr', [var_diff_mutated.array_get(var_i), rt.new_int(1)]))
					if !(rt.is_true(rt.new_bool(rt.is_true(rt.less(rt.pre_inc(var_i), var_end)) && rt.is_true(rt.equal(rt.call_function('substr', [var_diff_mutated.array_get(var_i), rt.new_int(0), rt.new_int(1)]), rt.new_string(' ')))))) {
						break
					}
				}
				var_edits << create_text_diff_op_copy(var_diff1.dup())
			} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('+'))) {
				for {
					var_diff1.array_push(rt.call_function('substr', [var_diff_mutated.array_get(var_i), rt.new_int(1)]))
					if !(rt.is_true(rt.new_bool(rt.is_true(rt.less(rt.pre_inc(var_i), var_end)) && rt.is_true(rt.equal(rt.call_function('substr', [var_diff_mutated.array_get(var_i), rt.new_int(0), rt.new_int(1)]), rt.new_string('+')))))) {
						break
					}
				}
				var_edits << create_text_diff_op_add(var_diff1.dup())
			} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('-'))) {
				mut var_diff2 := []rt.PhpVal{}
				for {
					var_diff1.array_push(rt.call_function('substr', [var_diff_mutated.array_get(var_i), rt.new_int(1)]))
					if !(rt.is_true(rt.new_bool(rt.is_true(rt.less(rt.pre_inc(var_i), var_end)) && rt.is_true(rt.equal(rt.call_function('substr', [var_diff_mutated.array_get(var_i), rt.new_int(0), rt.new_int(1)]), rt.new_string('-')))))) {
						break
					}
				}
				for rt.is_true(rt.new_bool(rt.is_true(rt.less(var_i, var_end)) && rt.is_true(rt.equal(rt.call_function('substr', [var_diff_mutated.array_get(var_i), rt.new_int(0), rt.new_int(1)]), rt.new_string('+'))))) {
					var_diff2.array_push(rt.call_function('substr', [var_diff_mutated.array_get(rt.post_inc(var_i)), rt.new_int(1)]))
				}
				if var_diff2.dup().array_count() == 0 {
					var_edits << create_text_diff_op_delete(var_diff1.dup())
				} else {
					var_edits << create_text_diff_op_change(var_diff1.dup(), var_diff2.dup())
				}
			} else {
				rt.post_inc(var_i)
			}
		}
	}
	return var_edits.dup()
}

fn (mut this Class_Text_Diff_Engine_string) parsecontextdiff(var_diff rt.PhpVal) rt.PhpVal {
	mut var_diff_mutated := var_diff
	mut var_edits := []rt.PhpVal{}
	mut var_i := mut var_max_i := mut var_j := mut var_max_j := rt.new_int(rt.new_int(0))
	mut var_end := rt.new_int(var_diff_mutated.dup().array_count() - 1)
	for rt.is_true(rt.new_bool(rt.is_true(rt.less(var_i, var_end)) && rt.is_true(rt.less(var_j, var_end)))) {
		for rt.is_true(rt.new_bool(rt.is_true(rt.greater_equal(var_i, var_max_i)) && rt.is_true(rt.greater_equal(var_j, var_max_j)))) {
			{
				var_i = var_j.dup()
				for {
					if !(rt.is_true(rt.new_bool(rt.is_true(rt.less(var_i, var_end)) && rt.is_true(rt.equal(rt.call_function('substr', [var_diff_mutated.array_get(var_i), rt.new_int(0), rt.new_int(3)]), rt.new_string('***')))))) { break }
					rt.post_inc(var_i)
				}
			}
			{
				var_max_i = var_i.dup()
				for {
					if !(rt.is_true(rt.new_bool(rt.is_true(rt.less(var_max_i, var_end)) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotEqual)))) { break }
					rt.post_inc(var_max_i)
				}
			}
			{
				var_j = var_max_i.dup()
				for {
					if !(rt.is_true(rt.new_bool(rt.is_true(rt.less(var_j, var_end)) && rt.is_true(rt.equal(rt.call_function('substr', [var_diff_mutated.array_get(var_j), rt.new_int(0), rt.new_int(3)]), rt.new_string('---')))))) { break }
					rt.post_inc(var_j)
				}
			}
			{
				var_max_j = var_j.dup()
				for {
					if !(rt.is_true(rt.new_bool(rt.is_true(rt.less(var_max_j, var_end)) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotEqual)))) { break }
					rt.post_inc(var_max_j)
				}
			}
		}
		mut var_array := []rt.PhpVal{}
		for rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.less(var_i, var_max_i)) && rt.is_true(rt.less(var_j, var_max_j)))) && rt.is_true(rt.equal(rt.call_function('strcmp', [var_diff_mutated.array_get(var_i), var_diff_mutated.array_get(var_j)]), rt.new_int(0))))) {
			var_array << rt.call_function('substr', [var_diff_mutated.array_get(var_i), rt.new_int(2)])
			rt.post_inc(var_i)
			rt.post_inc(var_j)
		}
		for rt.is_true(rt.new_bool(rt.is_true(rt.less(var_i, var_max_i)) && rt.is_true(rt.less_equal(rt.sub(var_max_j, var_j), rt.new_int(1))))) {
			if rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotEqual) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotEqual))) {
				break
			}
			var_array << rt.call_function('substr', [var_diff_mutated.array_get(rt.post_inc(var_i)), rt.new_int(2)])
		}
		for rt.is_true(rt.new_bool(rt.is_true(rt.less(var_j, var_max_j)) && rt.is_true(rt.less_equal(rt.sub(var_max_i, var_i), rt.new_int(1))))) {
			if rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotEqual) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotEqual))) {
				break
			}
			var_array << rt.call_function('substr', [var_diff_mutated.array_get(rt.post_inc(var_j)), rt.new_int(2)])
		}
		if var_array.len > 0 {
			var_edits << create_text_diff_op_copy(var_array.dup())
		}
		if rt.is_true(rt.less(var_i, var_max_i)) {
			mut var_diff1 := []rt.PhpVal{}
			mut switch_val_2 := rt.call_function('substr', [var_diff_mutated.array_get(var_i), rt.new_int(0), rt.new_int(1)])
			if rt.is_true(rt.equal(switch_val_2, rt.new_string('!'))) {
				mut var_diff2 := []rt.PhpVal{}
				for {
					var_diff1.array_push(rt.call_function('substr', [var_diff_mutated.array_get(var_i), rt.new_int(2)]))
					if rt.is_true(rt.new_bool(rt.is_true(rt.less(var_j, var_max_j)) && rt.is_true(rt.equal(rt.call_function('substr', [var_diff_mutated.array_get(var_j), rt.new_int(0), rt.new_int(1)]), rt.new_string('!'))))) {
						var_diff2.array_push(rt.call_function('substr', [var_diff_mutated.array_get(rt.post_inc(var_j)), rt.new_int(2)]))
					}
					if !(rt.is_true(rt.new_bool(rt.is_true(rt.less(rt.pre_inc(var_i), var_max_i)) && rt.is_true(rt.equal(rt.call_function('substr', [var_diff_mutated.array_get(var_i), rt.new_int(0), rt.new_int(1)]), rt.new_string('!')))))) {
						break
					}
				}
				var_edits << create_text_diff_op_change(var_diff1.dup(), var_diff2.dup())
			} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('+'))) {
				for {
					var_diff1.array_push(rt.call_function('substr', [var_diff_mutated.array_get(var_i), rt.new_int(2)]))
					if !(rt.is_true(rt.new_bool(rt.is_true(rt.less(rt.pre_inc(var_i), var_max_i)) && rt.is_true(rt.equal(rt.call_function('substr', [var_diff_mutated.array_get(var_i), rt.new_int(0), rt.new_int(1)]), rt.new_string('+')))))) {
						break
					}
				}
				var_edits << create_text_diff_op_add(var_diff1.dup())
			} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('-'))) {
				for {
					var_diff1.array_push(rt.call_function('substr', [var_diff_mutated.array_get(var_i), rt.new_int(2)]))
					if !(rt.is_true(rt.new_bool(rt.is_true(rt.less(rt.pre_inc(var_i), var_max_i)) && rt.is_true(rt.equal(rt.call_function('substr', [var_diff_mutated.array_get(var_i), rt.new_int(0), rt.new_int(1)]), rt.new_string('-')))))) {
						break
					}
				}
				var_edits << create_text_diff_op_delete(var_diff1.dup())
			}
		}
		if rt.is_true(rt.less(var_j, var_max_j)) {
			var_diff2 = []rt.PhpVal{}
			mut switch_val_3 := rt.call_function('substr', [var_diff_mutated.array_get(var_j), rt.new_int(0), rt.new_int(1)])
			if rt.is_true(rt.equal(switch_val_3, rt.new_string('+'))) {
				for {
					var_diff2.array_push(rt.call_function('substr', [var_diff_mutated.array_get(rt.post_inc(var_j)), rt.new_int(2)]))
					if !(rt.is_true(rt.new_bool(rt.is_true(rt.less(var_j, var_max_j)) && rt.is_true(rt.equal(rt.call_function('substr', [var_diff_mutated.array_get(var_j), rt.new_int(0), rt.new_int(1)]), rt.new_string('+')))))) {
						break
					}
				}
				var_edits << create_text_diff_op_add(var_diff2.dup())
			} else if rt.is_true(rt.equal(switch_val_3, rt.new_string('-'))) {
				for {
					var_diff2.array_push(rt.call_function('substr', [var_diff_mutated.array_get(rt.post_inc(var_j)), rt.new_int(2)]))
					if !(rt.is_true(rt.new_bool(rt.is_true(rt.less(var_j, var_max_j)) && rt.is_true(rt.equal(rt.call_function('substr', [var_diff_mutated.array_get(var_j), rt.new_int(0), rt.new_int(1)]), rt.new_string('-')))))) {
						break
					}
				}
				var_edits << create_text_diff_op_delete(var_diff2.dup())
			}
		}
	}
	return var_edits.dup()
}

struct Class_PEAR {
	rt.PhpObjectBase
}

struct Class_Text_Diff_Op_copy {
	rt.PhpObjectBase
}

struct Class_Text_Diff_Op_add {
	rt.PhpObjectBase
}

struct Class_Text_Diff_Op_delete {
	rt.PhpObjectBase
}

struct Class_Text_Diff_Op_change {
	rt.PhpObjectBase
}

fn create_text_diff_engine_string() &Class_Text_Diff_Engine_string {
	mut obj := &Class_Text_Diff_Engine_string{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_pear() &Class_PEAR {
	mut obj := &Class_PEAR{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_text_diff_op_copy() &Class_Text_Diff_Op_copy {
	mut obj := &Class_Text_Diff_Op_copy{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_text_diff_op_add() &Class_Text_Diff_Op_add {
	mut obj := &Class_Text_Diff_Op_add{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_text_diff_op_delete() &Class_Text_Diff_Op_delete {
	mut obj := &Class_Text_Diff_Op_delete{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_text_diff_op_change() &Class_Text_Diff_Op_change {
	mut obj := &Class_Text_Diff_Op_change{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Text_Diff_Engine_string) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'diff' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return this.diff(dispatch_arg_0, dispatch_arg_1)
		}
		'parseUnifiedDiff' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.parseunifieddiff(dispatch_arg_0)
		}
		'parseContextDiff' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.parsecontextdiff(dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_Text_Diff_Engine_string) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Text_Diff_Engine_string) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_PEAR) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_PEAR) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_PEAR) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Text_Diff_Op_copy) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Text_Diff_Op_copy) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Text_Diff_Op_copy) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Text_Diff_Op_add) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Text_Diff_Op_add) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Text_Diff_Op_add) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Text_Diff_Op_delete) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Text_Diff_Op_delete) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Text_Diff_Op_delete) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Text_Diff_Op_change) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Text_Diff_Op_change) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Text_Diff_Op_change) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_includes_text_diff_engine_string_php() {
}
