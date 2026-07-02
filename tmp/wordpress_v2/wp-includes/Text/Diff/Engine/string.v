import rt

struct Class_Text_Diff_Engine_string {
	rt.PhpObjectBase
}

fn (mut this Class_Text_Diff_Engine_string) diff(var_diff rt.PhpVal, mode string) rt.PhpVal {
	mut var_diff_mutated := var_diff
	mut mode_mutated := mode
	mut var_lnbr := rt.new_string('\n')
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('strpos', [
		var_diff_mutated.clone(),
		rt.new_string('\r\n'),
	]), rt.new_bool(false)))))
	{
		var_lnbr = rt.new_string('\r\n')
	} else if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('strpos', [
		var_diff_mutated.clone(),
		rt.new_string('\r'),
	]), rt.new_bool(false)))))
	{
		var_lnbr = rt.new_string('\r')
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.equal(rt.call_function('substr', [
		var_diff_mutated.clone(),
		rt.new_int(-var_lnbr.clone().to_string().len),
	]), var_lnbr))))
	{
		var_diff_mutated = rt.concat(var_diff_mutated, var_lnbr)
	}
	if rt.is_true(rt.new_bool(mode_mutated != 'autodetect'))
		&& rt.is_true(rt.new_bool(mode_mutated != 'context'))
		&& rt.is_true(rt.new_bool(mode_mutated != 'unified')) {
		mut iife_temp_0 := Class_PEAR{}
		mut iife_result_0 := iife_temp_0.raiseerror(rt.new_string('Type of diff is unsupported'))
		return iife_result_0
	}
	if rt.is_true(rt.equal(rt.new_string(mode_mutated), rt.new_string('autodetect'))) {
		mut var_context := rt.call_function('strpos', [var_diff_mutated.clone(),
			rt.new_string('***')])
		mut var_unified := rt.call_function('strpos', [var_diff_mutated.clone(),
			rt.new_string('---')])
		if rt.is_true(rt.identical(var_context, var_unified)) {
			mut iife_temp_1 := Class_PEAR{}
			mut iife_result_1 :=
				iife_temp_1.raiseerror(rt.new_string('Type of diff could not be detected'))
			return iife_result_1
		} else if rt.is_true(rt.identical(var_context, rt.new_bool(false)))
			|| rt.is_true(rt.identical(var_unified, rt.new_bool(false))) {
			mode_mutated = if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_context,
				rt.new_bool(false)))))
			{
				'context'
			} else {
				'unified'
			}
		} else {
			mode_mutated = if rt.is_true(rt.less(var_context, var_unified)) {
				'context'
			} else {
				'unified'
			}
		}
	}
	var_diff_mutated = rt.call_function('explode', [var_lnbr.clone(),
		var_diff_mutated.clone()])
	if (rt.is_true(rt.equal(rt.new_string(mode_mutated), rt.new_string('context')))
		&& rt.is_true(rt.identical(rt.call_function('strpos', [var_diff_mutated.array_get(rt.new_int(0)), rt.new_string('***')]), rt.new_int(0))))
		|| (rt.is_true(rt.equal(rt.new_string(mode_mutated), rt.new_string('unified')))
		&& rt.is_true(rt.identical(rt.call_function('strpos', [var_diff_mutated.array_get(rt.new_int(0)), rt.new_string('---')]), rt.new_int(0)))) {
		rt.call_function('array_shift', [var_diff_mutated.clone()])
		rt.call_function('array_shift', [var_diff_mutated.clone()])
	}
	if rt.is_true(rt.equal(rt.new_string(mode_mutated), rt.new_string('context'))) {
		return this.parsecontextdiff(var_diff_mutated.clone())
	} else {
		return this.parseunifieddiff(var_diff_mutated.clone())
	}
	return rt.new_null()
}

fn (mut this Class_Text_Diff_Engine_string) parseunifieddiff(var_diff rt.PhpVal) rt.PhpVal {
	mut var_diff_mutated := var_diff
	mut var_edits := []rt.PhpVal{}
	mut var_end := rt.new_int(var_diff_mutated.clone().array_count() - 1)
	mut var_i := rt.new_int(0)
	for {
		if !(rt.is_true(rt.less(var_i, var_end))) { break
		 }
		mut var_diff1 := []rt.PhpVal{}
		mut switch_val_1 := rt.call_function('substr', [var_diff_mutated.array_get(var_i),
			rt.new_int(0), rt.new_int(1)])
		if rt.is_true(rt.equal(switch_val_1, rt.new_string(' '))) {
			for {
				var_diff1.array_push(rt.call_function('substr', [
					var_diff_mutated.array_get(var_i), rt.new_int(1)]))
				if !(rt.is_true(rt.less(rt.pre_inc(var_i), var_end))
					&& rt.is_true(rt.equal(rt.call_function('substr', [var_diff_mutated.array_get(var_i), rt.new_int(0), rt.new_int(1)]), rt.new_string(' ')))) {
					break
				}
			}
			var_edits << create_text_diff_op_copy(var_diff1.clone())
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('+'))) {
			for {
				var_diff1.array_push(rt.call_function('substr', [
					var_diff_mutated.array_get(var_i), rt.new_int(1)]))
				if !(rt.is_true(rt.less(rt.pre_inc(var_i), var_end))
					&& rt.is_true(rt.equal(rt.call_function('substr', [var_diff_mutated.array_get(var_i), rt.new_int(0), rt.new_int(1)]), rt.new_string('+')))) {
					break
				}
			}
			var_edits << create_text_diff_op_add(var_diff1.clone())
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('-'))) {
			mut var_diff2 := []rt.PhpVal{}
			for {
				var_diff1.array_push(rt.call_function('substr', [
					var_diff_mutated.array_get(var_i), rt.new_int(1)]))
				if !(rt.is_true(rt.less(rt.pre_inc(var_i), var_end))
					&& rt.is_true(rt.equal(rt.call_function('substr', [var_diff_mutated.array_get(var_i), rt.new_int(0), rt.new_int(1)]), rt.new_string('-')))) {
					break
				}
			}
			for rt.is_true(rt.less(var_i, var_end))
				&& rt.is_true(rt.equal(rt.call_function('substr', [var_diff_mutated.array_get(var_i), rt.new_int(0), rt.new_int(1)]), rt.new_string('+'))) {
				var_diff2.array_push(rt.call_function('substr', [
					var_diff_mutated.array_get(rt.post_inc(var_i)),
					rt.new_int(1),
				]))
			}
			if var_diff2.clone().array_count() == 0 {
				var_edits << create_text_diff_op_delete(var_diff1.clone())
			} else {
				var_edits << create_text_diff_op_change(var_diff1.clone(), var_diff2.clone())
			}
		} else {
			rt.post_inc(var_i)
		}
	}
	return var_edits.clone()
}

fn (mut this Class_Text_Diff_Engine_string) parsecontextdiff(var_diff rt.PhpVal) rt.PhpVal {
	mut var_diff_mutated := var_diff
	mut var_edits := []rt.PhpVal{}
	mut var_max_j := rt.new_int(0)
	mut var_j := var_max_j
	mut var_max_i := var_j
	mut var_i := var_max_i
	mut var_end := rt.new_int(var_diff_mutated.clone().array_count() - 1)
	for rt.is_true(rt.less(var_i, var_end)) && rt.is_true(rt.less(var_j, var_end)) {
		for rt.is_true(rt.greater_equal(var_i, var_max_i))
			&& rt.is_true(rt.greater_equal(var_j, var_max_j)) {
			var_i = var_j.clone()
			for {
				if !(rt.is_true(rt.less(var_i, var_end)) && rt.is_true(rt.equal(rt.call_function('substr', [var_diff_mutated.array_get(var_i), rt.new_int(0), rt.new_int(3)]), rt.new_string('***')))) { break
				 }
				rt.post_inc(var_i)
			}
			var_max_i = var_i.clone()
			for {
				if !(rt.is_true(rt.less(var_max_i, var_end)) && rt.is_true(rt.new_bool(!rt.is_true(rt.equal(rt.call_function('substr', [var_diff_mutated.array_get(var_max_i), rt.new_int(0), rt.new_int(3)]), rt.new_string('---')))))) { break
				 }
				rt.post_inc(var_max_i)
			}
			var_j = var_max_i.clone()
			for {
				if !(rt.is_true(rt.less(var_j, var_end)) && rt.is_true(rt.equal(rt.call_function('substr', [var_diff_mutated.array_get(var_j), rt.new_int(0), rt.new_int(3)]), rt.new_string('---')))) { break
				 }
				rt.post_inc(var_j)
			}
			var_max_j = var_j.clone()
			for {
				if !(rt.is_true(rt.less(var_max_j, var_end)) && rt.is_true(rt.new_bool(!rt.is_true(rt.equal(rt.call_function('substr', [var_diff_mutated.array_get(var_max_j), rt.new_int(0), rt.new_int(3)]), rt.new_string('***')))))) { break
				 }
				rt.post_inc(var_max_j)
			}
		}
		mut var_array := []rt.PhpVal{}
		for rt.is_true(rt.less(var_i, var_max_i)) && rt.is_true(rt.less(var_j, var_max_j))
			&& rt.is_true(rt.equal(rt.call_function('strcmp', [var_diff_mutated.array_get(var_i), var_diff_mutated.array_get(var_j)]), rt.new_int(0))) {
			var_array << rt.call_function('substr', [var_diff_mutated.array_get(var_i),
				rt.new_int(2)])
			rt.post_inc(var_i)
			rt.post_inc(var_j)
		}
		for rt.is_true(rt.less(var_i, var_max_i))
			&& rt.is_true(rt.less_equal(rt.sub(var_max_j, var_j), rt.new_int(1))) {
			if rt.is_true(rt.new_bool(!rt.is_true(rt.equal(var_diff_mutated.array_get(var_i), rt.new_string('')))))
				&& rt.is_true(rt.new_bool(!rt.is_true(rt.equal(rt.call_function('substr', [var_diff_mutated.array_get(var_i), rt.new_int(0), rt.new_int(1)]), rt.new_string(' '))))) {
				break
			}
			var_array << rt.call_function('substr', [var_diff_mutated.array_get(rt.post_inc(var_i)),
				rt.new_int(2)])
		}
		for rt.is_true(rt.less(var_j, var_max_j))
			&& rt.is_true(rt.less_equal(rt.sub(var_max_i, var_i), rt.new_int(1))) {
			if rt.is_true(rt.new_bool(!rt.is_true(rt.equal(var_diff_mutated.array_get(var_j), rt.new_string('')))))
				&& rt.is_true(rt.new_bool(!rt.is_true(rt.equal(rt.call_function('substr', [var_diff_mutated.array_get(var_j), rt.new_int(0), rt.new_int(1)]), rt.new_string(' '))))) {
				break
			}
			var_array << rt.call_function('substr', [var_diff_mutated.array_get(rt.post_inc(var_j)),
				rt.new_int(2)])
		}
		if var_array.len > 0 {
			var_edits << create_text_diff_op_copy(var_array.clone())
		}
		if rt.is_true(rt.less(var_i, var_max_i)) {
			mut var_diff1 := []rt.PhpVal{}
			mut switch_val_2 := rt.call_function('substr', [var_diff_mutated.array_get(var_i),
				rt.new_int(0), rt.new_int(1)])
			if rt.is_true(rt.equal(switch_val_2, rt.new_string('!'))) {
				mut var_diff2 := []rt.PhpVal{}
				for {
					var_diff1.array_push(rt.call_function('substr', [
						var_diff_mutated.array_get(var_i), rt.new_int(2)]))
					if rt.is_true(rt.less(var_j, var_max_j))
						&& rt.is_true(rt.equal(rt.call_function('substr', [var_diff_mutated.array_get(var_j), rt.new_int(0), rt.new_int(1)]), rt.new_string('!'))) {
						var_diff2.array_push(rt.call_function('substr', [
							var_diff_mutated.array_get(rt.post_inc(var_j)),
							rt.new_int(2),
						]))
					}
					if !(rt.is_true(rt.less(rt.pre_inc(var_i), var_max_i))
						&& rt.is_true(rt.equal(rt.call_function('substr', [var_diff_mutated.array_get(var_i), rt.new_int(0), rt.new_int(1)]), rt.new_string('!')))) {
						break
					}
				}
				var_edits << create_text_diff_op_change(var_diff1.clone(), var_diff2.clone())
			} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('+'))) {
				for {
					var_diff1.array_push(rt.call_function('substr', [
						var_diff_mutated.array_get(var_i), rt.new_int(2)]))
					if !(rt.is_true(rt.less(rt.pre_inc(var_i), var_max_i))
						&& rt.is_true(rt.equal(rt.call_function('substr', [var_diff_mutated.array_get(var_i), rt.new_int(0), rt.new_int(1)]), rt.new_string('+')))) {
						break
					}
				}
				var_edits << create_text_diff_op_add(var_diff1.clone())
			} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('-'))) {
				for {
					var_diff1.array_push(rt.call_function('substr', [
						var_diff_mutated.array_get(var_i), rt.new_int(2)]))
					if !(rt.is_true(rt.less(rt.pre_inc(var_i), var_max_i))
						&& rt.is_true(rt.equal(rt.call_function('substr', [var_diff_mutated.array_get(var_i), rt.new_int(0), rt.new_int(1)]), rt.new_string('-')))) {
						break
					}
				}
				var_edits << create_text_diff_op_delete(var_diff1.clone())
			}
		}
		if rt.is_true(rt.less(var_j, var_max_j)) {
			var_diff2 = []rt.PhpVal{}
			mut switch_val_3 := rt.call_function('substr', [var_diff_mutated.array_get(var_j),
				rt.new_int(0), rt.new_int(1)])
			if rt.is_true(rt.equal(switch_val_3, rt.new_string('+'))) {
				for {
					var_diff2.array_push(rt.call_function('substr', [
						var_diff_mutated.array_get(rt.post_inc(var_j)),
						rt.new_int(2),
					]))
					if !(rt.is_true(rt.less(var_j, var_max_j))
						&& rt.is_true(rt.equal(rt.call_function('substr', [var_diff_mutated.array_get(var_j), rt.new_int(0), rt.new_int(1)]), rt.new_string('+')))) {
						break
					}
				}
				var_edits << create_text_diff_op_add(var_diff2.clone())
			} else if rt.is_true(rt.equal(switch_val_3, rt.new_string('-'))) {
				for {
					var_diff2.array_push(rt.call_function('substr', [
						var_diff_mutated.array_get(rt.post_inc(var_j)),
						rt.new_int(2),
					]))
					if !(rt.is_true(rt.less(var_j, var_max_j))
						&& rt.is_true(rt.equal(rt.call_function('substr', [var_diff_mutated.array_get(var_j), rt.new_int(0), rt.new_int(1)]), rt.new_string('-')))) {
						break
					}
				}
				var_edits << create_text_diff_op_delete(var_diff2.clone())
			}
		}
	}
	return var_edits.clone()
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

fn create_text_diff_engine_string(_args ...rt.PhpVal) &Class_Text_Diff_Engine_string {
	mut obj := &Class_Text_Diff_Engine_string{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_pear(_args ...rt.PhpVal) &Class_PEAR {
	mut obj := &Class_PEAR{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_text_diff_op_copy(_args ...rt.PhpVal) &Class_Text_Diff_Op_copy {
	mut obj := &Class_Text_Diff_Op_copy{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_text_diff_op_add(_args ...rt.PhpVal) &Class_Text_Diff_Op_add {
	mut obj := &Class_Text_Diff_Op_add{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_text_diff_op_delete(_args ...rt.PhpVal) &Class_Text_Diff_Op_delete {
	mut obj := &Class_Text_Diff_Op_delete{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_text_diff_op_change(_args ...rt.PhpVal) &Class_Text_Diff_Op_change {
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
		else {
			return none
		}
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

fn main() {
	defer {
		rt.shutdown()
	}
}
