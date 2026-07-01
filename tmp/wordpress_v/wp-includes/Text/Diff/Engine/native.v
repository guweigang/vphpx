import rt

struct Class_Text_Diff_Engine_native {
	rt.PhpObjectBase
pub mut:
		xchanged rt.PhpVal = rt.new_null()
		ychanged rt.PhpVal = rt.new_null()
		xv rt.PhpVal = rt.new_null()
		yv rt.PhpVal = rt.new_null()
		xind rt.PhpVal = rt.new_null()
		yind rt.PhpVal = rt.new_null()
		seq rt.PhpVal = rt.new_null()
		in_seq rt.PhpVal = rt.new_null()
		lcs i64
}

fn (mut this Class_Text_Diff_Engine_native) diff(var_from_lines rt.PhpVal, var_to_lines rt.PhpVal) rt.PhpVal {
	mut var_xhash := rt.new_null()
	mut var_yhash := rt.new_null()
	rt.call_function('array_walk', [var_from_lines.dup(), rt.create_array([rt.ArrayItem{ key: none, val: 'Text_Diff' }, rt.ArrayItem{ key: none, val: 'trimNewlines' }])])
	rt.call_function('array_walk', [var_to_lines.dup(), rt.create_array([rt.ArrayItem{ key: none, val: 'Text_Diff' }, rt.ArrayItem{ key: none, val: 'trimNewlines' }])])
	mut var_n_from := rt.new_int(rt.new_int(var_from_lines.dup().array_count()))
	mut var_n_to := rt.new_int(rt.new_int(var_to_lines.dup().array_count()))
	this.xchanged = this.ychanged = rt.new_array()
	this.xv = this.yv = rt.new_array()
	this.xind = this.yind = rt.new_array()
	this.seq = rt.new_null()
	this.in_seq = rt.new_null()
	this.lcs = rt.new_null()
	{
		mut var_skip := rt.new_int(rt.new_int(0))
		for {
			if !(rt.is_true(rt.new_bool(rt.is_true(rt.less(var_skip, var_n_from)) && rt.is_true(rt.less(var_skip, var_n_to))))) { break }
			if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
				break
			}
			this.xchanged.array_set(var_skip, this.ychanged.array_set(var_skip, false))
			rt.post_inc(var_skip)
		}
	}
	mut var_xi := var_n_from.dup()
	mut var_yi := var_n_to.dup()
	{
		mut var_endskip := rt.new_int(rt.new_int(0))
		for {
			if !(rt.is_true(rt.new_bool(rt.is_true(rt.greater(rt.pre_dec(var_xi), var_skip)) && rt.is_true(rt.greater(rt.pre_dec(var_yi), var_skip))))) { break }
			if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
				break
			}
			this.xchanged.array_set(var_xi, this.ychanged.array_set(var_yi, false))
			rt.post_inc(var_endskip)
		}
	}
	{
		mut var_xi := var_skip.dup()
		for {
			if !(rt.is_true(rt.less(var_xi, rt.sub(var_n_from, var_endskip)))) { break }
			var_xhash.array_set(var_from_lines.array_get(var_xi), 1)
			rt.post_inc(var_xi)
		}
	}
	{
		mut var_yi := var_skip.dup()
		for {
			if !(rt.is_true(rt.less(var_yi, rt.sub(var_n_to, var_endskip)))) { break }
			mut var_line := var_to_lines.array_get(var_yi)
			if rt.is_true(this.ychanged.array_set(var_yi, rt.new_bool(!rt.is_true(var_xhash.array_get(var_line))))) {
				continue
			}
			var_yhash.array_set(var_line, 1)
			this.yv.array_push(var_line.dup())
			this.yind.array_push(var_yi.dup())
			rt.post_inc(var_yi)
		}
	}
	{
		mut var_xi := var_skip.dup()
		for {
			if !(rt.is_true(rt.less(var_xi, rt.sub(var_n_from, var_endskip)))) { break }
			mut var_line := var_from_lines.array_get(var_xi)
			if rt.is_true(this.xchanged.array_set(var_xi, rt.new_bool(!rt.is_true(var_yhash.array_get(var_line))))) {
				continue
			}
			this.xv.array_push(var_line.dup())
			this.xind.array_push(var_xi.dup())
			rt.post_inc(var_xi)
		}
	}
	this._compareseq(rt.new_int(0), rt.new_int(this.xv.array_count()), rt.new_int(0), rt.new_int(this.yv.array_count()))
	this._shiftboundaries(var_from_lines.dup(), this.xchanged, this.ychanged)
	this._shiftboundaries(var_to_lines.dup(), this.ychanged, this.xchanged)
	mut var_edits := rt.new_array()
	mut var_xi := mut var_yi := rt.new_int(rt.new_int(0))
	for rt.is_true(rt.new_bool(rt.is_true(rt.less(var_xi, var_n_from)) || rt.is_true(rt.less(var_yi, var_n_to)))) {
		rt.call_function('assert', [rt.new_bool(rt.is_true(rt.less(var_yi, var_n_to)) || rt.is_true(this.xchanged.array_get(var_xi)))])
		rt.call_function('assert', [rt.new_bool(rt.is_true(rt.less(var_xi, var_n_from)) || rt.is_true(this.ychanged.array_get(var_yi)))])
		mut var_copy := rt.new_array()
		for rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.less(var_xi, var_n_from)) && rt.is_true(rt.less(var_yi, var_n_to)))) && rt.is_true(rt.new_bool(!(rt.is_true(this.xchanged.array_get(var_xi))))))) && rt.is_true(rt.new_bool(!(rt.is_true(this.ychanged.array_get(var_yi))))))) {
			var_copy << var_from_lines.array_get(rt.post_inc(var_xi))
			rt.pre_inc(var_yi)
		}
		if rt.is_true(var_copy) {
			var_edits << create_text_diff_op_copy(var_copy.dup())
		}
		mut var_delete := rt.new_array()
		for rt.is_true(rt.new_bool(rt.is_true(rt.less(var_xi, var_n_from)) && rt.is_true(this.xchanged.array_get(var_xi)))) {
			var_delete << var_from_lines.array_get(rt.post_inc(var_xi))
		}
		mut var_add := rt.new_array()
		for rt.is_true(rt.new_bool(rt.is_true(rt.less(var_yi, var_n_to)) && rt.is_true(this.ychanged.array_get(var_yi)))) {
			var_add << var_to_lines.array_get(rt.post_inc(var_yi))
		}
		if rt.is_true(rt.new_bool(rt.is_true(var_delete) && rt.is_true(var_add))) {
			var_edits << create_text_diff_op_change(var_delete.dup(), var_add.dup())
		} else if rt.is_true(var_delete) {
			var_edits << create_text_diff_op_delete(var_delete.dup())
		} else if rt.is_true(var_add) {
			var_edits << create_text_diff_op_add(var_add.dup())
		}
	}
	return var_edits.dup()
}

fn (mut this Class_Text_Diff_Engine_native) _diag(var_xoff rt.PhpVal, var_xlim rt.PhpVal, var_yoff rt.PhpVal, var_ylim rt.PhpVal, var_nchunks rt.PhpVal) rt.PhpVal {
	mut var_ymatches := rt.new_null()
	mut var_ymids := rt.new_null()
	mut var_seps := []rt.PhpVal{}
	mut var_xoff_mutated := var_xoff
	mut var_xlim_mutated := var_xlim
	mut var_yoff_mutated := var_yoff
	mut var_ylim_mutated := var_ylim
	mut var_nchunks_mutated := var_nchunks
	mut var_flip := rt.new_bool(rt.new_bool(false))
	if rt.is_true(rt.greater(rt.sub(var_xlim_mutated, var_xoff_mutated), rt.sub(var_ylim_mutated, var_yoff_mutated))) {
		var_flip = rt.new_bool(rt.new_bool(true))
		// unsupported assign target: Expr_List
	}
	if rt.is_true(var_flip) {
		{
			mut var_i := rt.sub(var_ylim_mutated, rt.new_int(1))
			for {
				if !(rt.is_true(rt.greater_equal(var_i, var_yoff_mutated))) { break }
				var_ymatches.array_get_mut(this.xv.array_get(var_i)).array_push(var_i.dup())
				rt.post_dec(var_i)
			}
		}
	} else {
		{
			mut var_i := rt.sub(var_ylim_mutated, rt.new_int(1))
			for {
				if !(rt.is_true(rt.greater_equal(var_i, var_yoff_mutated))) { break }
				var_ymatches.array_get_mut(this.yv.array_get(var_i)).array_push(var_i.dup())
				rt.post_dec(var_i)
			}
		}
	}
	this.lcs = 0
	this.seq.array_set(0, rt.sub(var_yoff_mutated, rt.new_int(1)))
	this.in_seq = rt.new_array()
	var_ymids.array_set(0, rt.new_array())
	mut var_numer := rt.sub(rt.add(rt.sub(var_xlim_mutated, var_xoff_mutated), var_nchunks_mutated), rt.new_int(1))
	mut var_x := var_xoff_mutated.dup()
	{
		mut var_chunk := rt.new_int(rt.new_int(0))
		for {
			if !(rt.is_true(rt.less(var_chunk, var_nchunks_mutated))) { break }
			if rt.is_true(rt.greater(var_chunk, rt.new_int(0))) {
				{
					mut var_i := rt.new_int(rt.new_int(0))
					for {
						if !(rt.is_true(rt.less_equal(var_i, this.lcs))) { break }
						var_ymids.array_get_mut(var_i).array_set(rt.sub(var_chunk, rt.new_int(1)), this.seq.array_get(var_i))
						rt.post_inc(var_i)
					}
				}
			}
			mut var_x1 := rt.add(var_xoff_mutated, // unsupported expression: Expr_Cast_Int)
			{
				for {
					if !(rt.is_true(rt.less(var_x, var_x1))) { break }
					mut var_line := if rt.is_true(var_flip) { this.yv.array_get(var_x) } else { this.xv.array_get(var_x) }
					if !rt.is_true(var_ymatches.array_get(var_line)) {
						continue
					}
					mut var_matches := var_ymatches.array_get(var_line)
					rt.call_function('reset', [var_matches.dup()])
					for rt.is_true(mut var_y := rt.call_function('current', [var_matches.dup()])) {
						if !rt.is_true(this.in_seq.array_get(var_y)) {
							mut var_k := rt.new_int(this._lcspos(var_y.dup()))
							rt.call_function('assert', [rt.greater(var_k, rt.new_int(0))])
							var_ymids.array_set(var_k, var_ymids.array_get(rt.sub(var_k, rt.new_int(1))))
							break
						}
						rt.call_function('next', [var_matches.dup()])
					}
					for rt.is_true(var_y = rt.call_function('current', [var_matches.dup()])) {
						if rt.is_true(rt.greater(var_y, this.seq.array_get(rt.sub(var_k, rt.new_int(1))))) {
							rt.call_function('assert', [rt.less_equal(var_y, this.seq.array_get(var_k))])
							this.in_seq.array_set(this.seq.array_get(var_k), false)
							this.seq.array_set(var_k, var_y.dup())
							this.in_seq.array_set(var_y, 1)
						} else if !rt.is_true(this.in_seq.array_get(var_y)) {
							var_k = rt.new_int(this._lcspos(var_y.dup()))
							rt.call_function('assert', [rt.greater(var_k, rt.new_int(0))])
							var_ymids.array_set(var_k, var_ymids.array_get(rt.sub(var_k, rt.new_int(1))))
						}
						rt.call_function('next', [var_matches.dup()])
					}
					rt.post_inc(var_x)
				}
			}
			rt.post_inc(var_chunk)
		}
	}
	var_seps << if rt.is_true(var_flip) { rt.create_array([rt.ArrayItem{ key: none, val: var_yoff_mutated }, rt.ArrayItem{ key: none, val: var_xoff_mutated }]) } else { rt.create_array([rt.ArrayItem{ key: none, val: var_xoff_mutated }, rt.ArrayItem{ key: none, val: var_yoff_mutated }]) }
	mut var_ymid := var_ymids.array_get(this.lcs)
	{
		mut var_n := rt.new_int(rt.new_int(0))
		for {
			if !(rt.is_true(rt.less(var_n, rt.sub(var_nchunks_mutated, rt.new_int(1))))) { break }
			mut var_x1 := rt.add(var_xoff_mutated, // unsupported expression: Expr_Cast_Int)
			mut var_y1 := rt.add(.array_get(), rt.new_int(1))
			var_seps << if rt.is_true() {  } else {  }
			rt.post_inc(var_n)
		}
	}
	 << 
	return 
}

fn (mut this Class_Text_Diff_Engine_native) _lcspos(var_ypos rt.PhpVal) i64 {
}

fn (mut this Class_Text_Diff_Engine_native) _compareseq(var_xoff rt.PhpVal, var_xlim rt.PhpVal, var_yoff rt.PhpVal, var_ylim rt.PhpVal)  {
	mut var_seps := []rt.PhpVal{}
	mut var_xoff_mutated := var_xoff
	mut var_xlim_mutated := var_xlim
	mut var_yoff_mutated := var_yoff
	mut var_ylim_mutated := var_ylim
}

fn (mut this Class_Text_Diff_Engine_native) _shiftboundaries(var_lines rt.PhpVal, var_changed rt.PhpVal, var_other_changed rt.PhpVal)  {
	mut var_changed_mutated := var_changed
}

struct Class_Text_Diff_Op_copy {
	rt.PhpObjectBase
}

struct Class_Text_Diff_Op_change {
	rt.PhpObjectBase
}

struct Class_Text_Diff_Op_delete {
	rt.PhpObjectBase
}

struct Class_Text_Diff_Op_add {
	rt.PhpObjectBase
}

fn create_text_diff_engine_native() &Class_Text_Diff_Engine_native {
	mut obj := &Class_Text_Diff_Engine_native{
		PhpObjectBase: rt.PhpObjectBase{}
		xchanged: rt.new_null()
		ychanged: rt.new_null()
		xv: rt.new_null()
		yv: rt.new_null()
		xind: rt.new_null()
		yind: rt.new_null()
		seq: rt.new_null()
		in_seq: rt.new_null()
		lcs: i64(0)
	}
	return obj
}

fn create_text_diff_op_copy() &Class_Text_Diff_Op_copy {
	mut obj := &Class_Text_Diff_Op_copy{
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

fn create_text_diff_op_delete() &Class_Text_Diff_Op_delete {
	mut obj := &Class_Text_Diff_Op_delete{
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

fn (mut this Class_Text_Diff_Engine_native) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'diff' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.diff(dispatch_arg_0, dispatch_arg_1)
		}
		'_diag' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			dispatch_arg_4 := if args.len > 4 { args[4] } else { rt.new_null() }
			return this._diag(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3, dispatch_arg_4)
		}
		'_lcsPos' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_int(this._lcspos(dispatch_arg_0))
		}
		'_compareseq' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			this._compareseq(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
			return rt.new_null()
		}
		'_shiftBoundaries' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			this._shiftboundaries(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_Text_Diff_Engine_native) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'xchanged' { return this.xchanged }
		'ychanged' { return this.ychanged }
		'xv' { return this.xv }
		'yv' { return this.yv }
		'xind' { return this.xind }
		'yind' { return this.yind }
		'seq' { return this.seq }
		'in_seq' { return this.in_seq }
		'lcs' { return rt.new_int(this.lcs) }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Text_Diff_Engine_native) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'xchanged' { this.xchanged = val; return true }
		'ychanged' { this.ychanged = val; return true }
		'xv' { this.xv = val; return true }
		'yv' { this.yv = val; return true }
		'xind' { this.xind = val; return true }
		'yind' { this.yind = val; return true }
		'seq' { this.seq = val; return true }
		'in_seq' { this.in_seq = val; return true }
		'lcs' { this.lcs = (val).to_i64(); return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
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


fn (mut this Class_Text_Diff_Op_change) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Text_Diff_Op_change) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Text_Diff_Op_change) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_Text_Diff_Op_add) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Text_Diff_Op_add) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Text_Diff_Op_add) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_includes_text_diff_engine_native_php() {
}
