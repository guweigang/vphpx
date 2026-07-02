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
	rt.call_function('array_walk', [var_from_lines.clone(), rt.create_array([rt.ArrayItem{ key: none, val: 'Text_Diff' }, rt.ArrayItem{ key: none, val: 'trimNewlines' }])])
	rt.call_function('array_walk', [var_to_lines.clone(), rt.create_array([rt.ArrayItem{ key: none, val: 'Text_Diff' }, rt.ArrayItem{ key: none, val: 'trimNewlines' }])])
	mut var_n_from := rt.new_int(var_from_lines.clone().array_count())
	mut var_n_to := rt.new_int(var_to_lines.clone().array_count())
	this.xchanged = this.ychanged = rt.new_array()
	this.xv = this.yv = rt.new_array()
	this.xind = this.yind = rt.new_array()
	this.seq = rt.new_null()
	this.in_seq = rt.new_null()
	this.lcs = rt.new_null()
	mut var_skip := rt.new_int(0)
	for {
		if !(rt.is_true(rt.less(var_skip, var_n_from)) && rt.is_true(rt.less(var_skip, var_n_to))) { break }
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_from_lines.array_get(var_skip), var_to_lines.array_get(var_skip))))) {
			break
		}
		this.xchanged.array_set(var_skip, this.ychanged.array_set(var_skip, false))
		rt.post_inc(var_skip)
	}
	mut var_xi := var_n_from.clone()
	mut var_yi := var_n_to.clone()
	mut var_endskip := rt.new_int(0)
	for {
		if !(rt.is_true(rt.greater(rt.pre_dec(var_xi), var_skip)) && rt.is_true(rt.greater(rt.pre_dec(var_yi), var_skip))) { break }
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_from_lines.array_get(var_xi), var_to_lines.array_get(var_yi))))) {
			break
		}
		this.xchanged.array_set(var_xi, this.ychanged.array_set(var_yi, false))
		rt.post_inc(var_endskip)
	}
	mut var_xi := var_skip.clone()
	for {
		if !(rt.is_true(rt.less(var_xi, rt.sub(var_n_from, var_endskip)))) { break }
		var_xhash.array_set(var_from_lines.array_get(var_xi), 1)
		rt.post_inc(var_xi)
	}
	mut var_yi := var_skip.clone()
	for {
		if !(rt.is_true(rt.less(var_yi, rt.sub(var_n_to, var_endskip)))) { break }
		mut var_line := var_to_lines.array_get(var_yi)
		if rt.is_true(this.ychanged.array_set(var_yi, rt.new_bool(!rt.is_true(var_xhash.array_get(var_line))))) {
			continue
		}
		var_yhash.array_set(var_line, 1)
		this.yv.array_push(var_line.clone())
		this.yind.array_push(var_yi.clone())
		rt.post_inc(var_yi)
	}
	mut var_xi := var_skip.clone()
	for {
		if !(rt.is_true(rt.less(var_xi, rt.sub(var_n_from, var_endskip)))) { break }
		mut var_line := var_from_lines.array_get(var_xi)
		if rt.is_true(this.xchanged.array_set(var_xi, rt.new_bool(!rt.is_true(var_yhash.array_get(var_line))))) {
			continue
		}
		this.xv.array_push(var_line.clone())
		this.xind.array_push(var_xi.clone())
		rt.post_inc(var_xi)
	}
	this._compareseq(rt.new_int(0), rt.new_int(this.xv.array_count()), rt.new_int(0), rt.new_int(this.yv.array_count()))
	this._shiftboundaries(var_from_lines.clone(), this.xchanged, this.ychanged)
	this._shiftboundaries(var_to_lines.clone(), this.ychanged, this.xchanged)
	mut var_edits := rt.new_array()
	mut var_yi := rt.new_int(0)
	mut var_xi := var_yi
	for rt.is_true(rt.less(var_xi, var_n_from)) || rt.is_true(rt.less(var_yi, var_n_to)) {
		rt.call_function('assert', [rt.new_bool(rt.is_true(rt.less(var_yi, var_n_to)) || rt.is_true(this.xchanged.array_get(var_xi)))])
		rt.call_function('assert', [rt.new_bool(rt.is_true(rt.less(var_xi, var_n_from)) || rt.is_true(this.ychanged.array_get(var_yi)))])
		mut var_copy := rt.new_array()
		for rt.is_true(rt.less(var_xi, var_n_from)) && rt.is_true(rt.less(var_yi, var_n_to)) && rt.is_true(rt.new_bool(!(rt.is_true(this.xchanged.array_get(var_xi))))) && rt.is_true(rt.new_bool(!(rt.is_true(this.ychanged.array_get(var_yi))))) {
			var_copy << var_from_lines.array_get(rt.post_inc(var_xi))
			rt.pre_inc(var_yi)
		}
		if rt.is_true(var_copy) {
			var_edits << create_text_diff_op_copy(var_copy.clone())
		}
		mut var_delete := rt.new_array()
		for rt.is_true(rt.less(var_xi, var_n_from)) && rt.is_true(this.xchanged.array_get(var_xi)) {
			var_delete << var_from_lines.array_get(rt.post_inc(var_xi))
		}
		mut var_add := rt.new_array()
		for rt.is_true(rt.less(var_yi, var_n_to)) && rt.is_true(this.ychanged.array_get(var_yi)) {
			var_add << var_to_lines.array_get(rt.post_inc(var_yi))
		}
		if rt.is_true(var_delete) && rt.is_true(var_add) {
			var_edits << create_text_diff_op_change(var_delete.clone(), var_add.clone())
		} else if rt.is_true(var_delete) {
			var_edits << create_text_diff_op_delete(var_delete.clone())
		} else if rt.is_true(var_add) {
			var_edits << create_text_diff_op_add(var_add.clone())
		}
	}
	return var_edits.clone()
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
	mut var_flip := rt.new_bool(false)
	if rt.is_true(rt.greater(rt.sub(var_xlim_mutated, var_xoff_mutated), rt.sub(var_ylim_mutated, var_yoff_mutated))) {
		var_flip = rt.new_bool(true)
		mut list_tmp_1 := rt.create_array([rt.ArrayItem{ key: none, val: var_yoff_mutated }, rt.ArrayItem{ key: none, val: var_ylim_mutated }, rt.ArrayItem{ key: none, val: var_xoff_mutated }, rt.ArrayItem{ key: none, val: var_xlim_mutated }])
		var_xoff_mutated = (list_tmp_1).array_get(0)
		var_xlim_mutated = (list_tmp_1).array_get(1)
		var_yoff_mutated = (list_tmp_1).array_get(2)
		var_ylim_mutated = (list_tmp_1).array_get(3)
	}
	if rt.is_true(var_flip) {
		mut var_i := rt.sub(var_ylim_mutated, rt.new_int(1))
		for {
			if !(rt.is_true(rt.greater_equal(var_i, var_yoff_mutated))) { break }
			var_ymatches.array_get_mut(this.xv.array_get(var_i)).array_push(var_i.clone())
			rt.post_dec(var_i)
		}
	} else {
		mut var_i := rt.sub(var_ylim_mutated, rt.new_int(1))
		for {
			if !(rt.is_true(rt.greater_equal(var_i, var_yoff_mutated))) { break }
			var_ymatches.array_get_mut(this.yv.array_get(var_i)).array_push(var_i.clone())
			rt.post_dec(var_i)
		}
	}
	this.lcs = 0
	this.seq.array_set(0, rt.sub(var_yoff_mutated, rt.new_int(1)))
	this.in_seq = rt.new_array()
	var_ymids.array_set(0, rt.new_array())
	mut var_numer := rt.sub(rt.add(rt.sub(var_xlim_mutated, var_xoff_mutated), var_nchunks_mutated), rt.new_int(1))
	mut var_x := var_xoff_mutated.clone()
	mut var_chunk := rt.new_int(0)
	for {
		if !(rt.is_true(rt.less(var_chunk, var_nchunks_mutated))) { break }
		if rt.is_true(rt.greater(var_chunk, rt.new_int(0))) {
			mut var_i := rt.new_int(0)
			for {
				if !(rt.is_true(rt.less_equal(var_i, this.lcs))) { break }
				var_ymids.array_get_mut(var_i).array_set(rt.sub(var_chunk, rt.new_int(1)), this.seq.array_get(var_i))
				rt.post_inc(var_i)
			}
		}
		mut var_x1 := rt.add(var_xoff_mutated, rt.new_int((rt.div(rt.add(var_numer, rt.mul(rt.sub(var_xlim_mutated, var_xoff_mutated), var_chunk)), var_nchunks_mutated)).to_i64()))
		for {
			if !(rt.is_true(rt.less(var_x, var_x1))) { break }
			mut var_line := if rt.is_true(var_flip) { this.yv.array_get(var_x) } else { this.xv.array_get(var_x) }
			if !rt.is_true(var_ymatches.array_get(var_line)) {
				continue
			}
			mut var_matches := var_ymatches.array_get(var_line)
			rt.call_function('reset', [var_matches.clone()])
			mut var_y := rt.call_function('current', [var_matches.clone()])
			for rt.is_true(var_y) {
				if !rt.is_true(this.in_seq.array_get(var_y)) {
					mut var_k := rt.new_int(this._lcspos(var_y.clone()))
					rt.call_function('assert', [rt.greater(var_k, rt.new_int(0))])
					var_ymids.array_set(var_k, var_ymids.array_get(rt.sub(var_k, rt.new_int(1))))
					break
				}
				rt.call_function('next', [var_matches.clone()])
			}
			var_y = rt.call_function('current', [var_matches.clone()])
			for rt.is_true(var_y) {
				if rt.is_true(rt.greater(var_y, this.seq.array_get(rt.sub(var_k, rt.new_int(1))))) {
					rt.call_function('assert', [rt.less_equal(var_y, this.seq.array_get(var_k))])
					this.in_seq.array_set(this.seq.array_get(var_k), false)
					this.seq.array_set(var_k, var_y.clone())
					this.in_seq.array_set(var_y, 1)
				} else if !rt.is_true(this.in_seq.array_get(var_y)) {
					var_k = rt.new_int(this._lcspos(var_y.clone()))
					rt.call_function('assert', [rt.greater(var_k, rt.new_int(0))])
					var_ymids.array_set(var_k, var_ymids.array_get(rt.sub(var_k, rt.new_int(1))))
				}
				rt.call_function('next', [var_matches.clone()])
			}
			rt.post_inc(var_x)
		}
		rt.post_inc(var_chunk)
	}
	var_seps << if rt.is_true(var_flip) { rt.create_array([rt.ArrayItem{ key: none, val: var_yoff_mutated }, rt.ArrayItem{ key: none, val: var_xoff_mutated }]) } else { rt.create_array([rt.ArrayItem{ key: none, val: var_xoff_mutated }, rt.ArrayItem{ key: none, val: var_yoff_mutated }]) }
	mut var_ymid := var_ymids.array_get(rt.new_int(this.lcs))
	mut var_n := rt.new_int(0)
	for {
		if !(rt.is_true(rt.less(var_n, rt.sub(var_nchunks_mutated, rt.new_int(1))))) { break }
		mut var_x1 := rt.add(var_xoff_mutated, rt.new_int((rt.div(rt.add(var_numer, rt.mul(rt.sub(var_xlim_mutated, var_xoff_mutated), var_n)), var_nchunks_mutated)).to_i64()))
		mut var_y1 := rt.add(var_ymid.array_get(var_n), rt.new_int(1))
		var_seps << if rt.is_true(var_flip) { rt.create_array([rt.ArrayItem{ key: none, val: var_y1 }, rt.ArrayItem{ key: none, val: var_x1 }]) } else { rt.create_array([rt.ArrayItem{ key: none, val: var_x1 }, rt.ArrayItem{ key: none, val: var_y1 }]) }
		rt.post_inc(var_n)
	}
	var_seps << if rt.is_true(var_flip) { rt.create_array([rt.ArrayItem{ key: none, val: var_ylim_mutated }, rt.ArrayItem{ key: none, val: var_xlim_mutated }]) } else { rt.create_array([rt.ArrayItem{ key: none, val: var_xlim_mutated }, rt.ArrayItem{ key: none, val: var_ylim_mutated }]) }
	return rt.create_array([rt.ArrayItem{ key: none, val: this.lcs }, rt.ArrayItem{ key: none, val: var_seps }])
}

fn (mut this Class_Text_Diff_Engine_native) _lcspos(var_ypos rt.PhpVal) i64 {
	mut var_end := rt.new_int(this.lcs)
	if rt.is_true(rt.equal(var_end, rt.new_int(0))) || rt.is_true(rt.greater(var_ypos, this.seq.array_get(var_end))) {
		this.seq.array_set(rt.pre_inc(this.lcs), var_ypos.clone())
		this.in_seq.array_set(var_ypos, 1)
		return this.lcs
	}
	mut var_beg := rt.new_int(1)
	for rt.is_true(rt.less(var_beg, var_end)) {
		mut var_mid := rt.new_int((rt.div(rt.add(var_beg, var_end), rt.new_int(2))).to_i64())
		if rt.is_true(rt.greater(var_ypos, this.seq.array_get(var_mid))) {
		var_beg = rt.add(var_mid, rt.new_int(1))
		} else {
		var_end = var_mid.clone()
		}
	}
	rt.call_function('assert', [rt.new_bool(!rt.is_true(rt.equal(var_ypos, this.seq.array_get(var_end))))])
	this.in_seq.array_set(this.seq.array_get(var_end), false)
	this.seq.array_set(var_end, var_ypos.clone())
	this.in_seq.array_set(var_ypos, 1)
	return (var_end).to_i64()
}

fn (mut this Class_Text_Diff_Engine_native) _compareseq(var_xoff rt.PhpVal, var_xlim rt.PhpVal, var_yoff rt.PhpVal, var_ylim rt.PhpVal) {
	mut var_seps := []rt.PhpVal{}
	mut var_xoff_mutated := var_xoff
	mut var_xlim_mutated := var_xlim
	mut var_yoff_mutated := var_yoff
	mut var_ylim_mutated := var_ylim
	for rt.is_true(rt.less(var_xoff_mutated, var_xlim_mutated)) && rt.is_true(rt.less(var_yoff_mutated, var_ylim_mutated)) && rt.is_true(rt.equal(this.xv.array_get(var_xoff_mutated), this.yv.array_get(var_yoff_mutated))) {
		rt.pre_inc(var_xoff_mutated)
		rt.pre_inc(var_yoff_mutated)
	}
	for rt.is_true(rt.greater(var_xlim_mutated, var_xoff_mutated)) && rt.is_true(rt.greater(var_ylim_mutated, var_yoff_mutated)) && rt.is_true(rt.equal(this.xv.array_get(rt.sub(var_xlim_mutated, rt.new_int(1))), this.yv.array_get(rt.sub(var_ylim_mutated, rt.new_int(1))))) {
		rt.pre_dec(var_xlim_mutated)
		rt.pre_dec(var_ylim_mutated)
	}
	if rt.is_true(rt.equal(var_xoff_mutated, var_xlim_mutated)) || rt.is_true(rt.equal(var_yoff_mutated, var_ylim_mutated)) {
	mut var_lcs := rt.new_int(0)
	} else {
		mut var_nchunks := rt.add(rt.call_function('min', [rt.new_int(7), rt.sub(var_xlim_mutated, var_xoff_mutated), rt.sub(var_ylim_mutated, var_yoff_mutated)]), rt.new_int(1))
		mut list_tmp_2 := this._diag(var_xoff_mutated.clone(), var_xlim_mutated.clone(), var_yoff_mutated.clone(), var_ylim_mutated.clone(), var_nchunks.clone())
		var_lcs = (list_tmp_2).array_get(0)
		var_seps = (list_tmp_2).array_get(1)
	}
	if rt.is_true(rt.equal(var_lcs, rt.new_int(0))) {
		for rt.is_true(rt.less(var_yoff_mutated, var_ylim_mutated)) {
			this.ychanged.array_set(this.yind.array_get(rt.post_inc(var_yoff_mutated)), 1)
		}
		for rt.is_true(rt.less(var_xoff_mutated, var_xlim_mutated)) {
			this.xchanged.array_set(this.xind.array_get(rt.post_inc(var_xoff_mutated)), 1)
		}
	} else {
		rt.call_function('reset', [rt.create_array_from_list(var_seps)])
		mut var_pt1 := var_seps.array_get(rt.new_int(0))
		mut var_pt2 := rt.call_function('next', [rt.create_array_from_list(var_seps)])
		for rt.is_true(var_pt2) {
			this._compareseq(var_pt1.array_get(rt.new_int(0)), var_pt2.array_get(rt.new_int(0)), var_pt1.array_get(rt.new_int(1)), var_pt2.array_get(rt.new_int(1)))
		var_pt1 = var_pt2
		}
	}
}

fn (mut this Class_Text_Diff_Engine_native) _shiftboundaries(var_lines rt.PhpVal, var_changed rt.PhpVal, var_other_changed rt.PhpVal) {
	mut var_changed_mutated := var_changed
	mut var_i := rt.new_int(0)
	mut var_j := rt.new_int(0)
	rt.call_function('assert', [rt.new_bool(var_lines.clone().array_count() == var_changed_mutated.clone().array_count())])
	mut var_len := rt.new_int(var_lines.clone().array_count())
	mut var_other_len := rt.new_int(var_other_changed.clone().array_count())
	for rt.is_true(rt.new_int(1)) {
		for rt.is_true(rt.less(var_j, var_other_len)) && rt.is_true(var_other_changed.array_get(var_j)) {
			rt.post_inc(var_j)
		}
		for rt.is_true(rt.less(var_i, var_len)) && rt.is_true(rt.new_bool(!(rt.is_true(var_changed_mutated.array_get(var_i))))) {
			rt.call_function('assert', [rt.new_bool(rt.is_true(rt.less(var_j, var_other_len)) && rt.is_true(rt.new_bool(!(rt.is_true(var_other_changed.array_get(var_j))))))])
			rt.post_inc(var_i)
			rt.post_inc(var_j)
			for rt.is_true(rt.less(var_j, var_other_len)) && rt.is_true(var_other_changed.array_get(var_j)) {
				rt.post_inc(var_j)
			}
		}
		if rt.is_true(rt.equal(var_i, var_len)) {
			break
		}
		mut var_start := var_i.clone()
		for rt.is_true(rt.less(rt.pre_inc(var_i), var_len)) && rt.is_true(var_changed_mutated.array_get(var_i)) {
			continue
		}
		for {
			mut var_runlength := rt.sub(var_i, var_start)
			for rt.is_true(rt.greater(var_start, rt.new_int(0))) && rt.is_true(rt.equal(var_lines.array_get(rt.sub(var_start, rt.new_int(1))), var_lines.array_get(rt.sub(var_i, rt.new_int(1))))) {
				var_changed_mutated.array_set(rt.pre_dec(var_start), 1)
				var_changed_mutated.array_set(rt.pre_dec(var_i), false)
				for rt.is_true(rt.greater(var_start, rt.new_int(0))) && rt.is_true(var_changed_mutated.array_get(rt.sub(var_start, rt.new_int(1)))) {
					rt.post_dec(var_start)
				}
				rt.call_function('assert', [rt.greater(var_j, rt.new_int(0))])
				for rt.is_true(var_other_changed.array_get(rt.pre_dec(var_j))) {
					continue
				}
				rt.call_function('assert', [rt.new_bool(rt.is_true(rt.greater_equal(var_j, rt.new_int(0))) && rt.is_true(rt.new_bool(!(rt.is_true(var_other_changed.array_get(var_j))))))])
			}
			mut var_corresponding := if rt.is_true(rt.less(var_j, var_other_len)) { var_i } else { var_len }
			for rt.is_true(rt.less(var_i, var_len)) && rt.is_true(rt.equal(var_lines.array_get(var_start), var_lines.array_get(var_i))) {
				var_changed_mutated.array_set(rt.post_inc(var_start), false)
				var_changed_mutated.array_set(rt.post_inc(var_i), 1)
				for rt.is_true(rt.less(var_i, var_len)) && rt.is_true(var_changed_mutated.array_get(var_i)) {
					rt.post_inc(var_i)
				}
				rt.call_function('assert', [rt.new_bool(rt.is_true(rt.less(var_j, var_other_len)) && rt.is_true(rt.new_bool(!(rt.is_true(var_other_changed.array_get(var_j))))))])
				rt.post_inc(var_j)
				if rt.is_true(rt.less(var_j, var_other_len)) && rt.is_true(var_other_changed.array_get(var_j)) {
					var_corresponding = var_i.clone()
					for rt.is_true(rt.less(var_j, var_other_len)) && rt.is_true(var_other_changed.array_get(var_j)) {
						rt.post_inc(var_j)
					}
				}
			}
			if !(rt.is_true(rt.new_bool(!rt.is_true(rt.equal(var_runlength, rt.sub(var_i, var_start)))))) {
				break
			}
		}
		for rt.is_true(rt.less(var_corresponding, var_i)) {
			var_changed_mutated.array_set(rt.pre_dec(var_start), 1)
			var_changed_mutated.array_set(rt.pre_dec(var_i), 0)
			rt.call_function('assert', [rt.greater(var_j, rt.new_int(0))])
			for rt.is_true(var_other_changed.array_get(rt.pre_dec(var_j))) {
				continue
			}
			rt.call_function('assert', [rt.new_bool(rt.is_true(rt.greater_equal(var_j, rt.new_int(0))) && rt.is_true(rt.new_bool(!(rt.is_true(var_other_changed.array_get(var_j))))))])
		}
	}
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

fn create_text_diff_engine_native(_args ...rt.PhpVal) &Class_Text_Diff_Engine_native {
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

fn create_text_diff_op_copy(_args ...rt.PhpVal) &Class_Text_Diff_Op_copy {
	mut obj := &Class_Text_Diff_Op_copy{
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

fn create_text_diff_op_delete(_args ...rt.PhpVal) &Class_Text_Diff_Op_delete {
	mut obj := &Class_Text_Diff_Op_delete{
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



fn main() {
	defer {
		rt.shutdown()
	}

}
