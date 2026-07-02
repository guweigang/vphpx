import rt

struct Class_Text_Diff_Renderer {
	rt.PhpObjectBase
pub mut:
	_leading_context_lines  rt.PhpVal = rt.new_int(0)
	_trailing_context_lines rt.PhpVal = rt.new_int(0)
}

fn (mut this Class_Text_Diff_Renderer) construct(var_params rt.PhpVal) {
	mut var_params_mutated := var_params
	mut iter_1 := var_params_mutated.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_value := item_1.val
		mut var_param := item_1.key
		mut var_v := rt.new_string('_' + var_param.str())
		if !(rt.get_property(rt.new_object('Text_Diff_Renderer', []string{}, &this),
			'{"nodeType":"Expr_Variable","line":40,"name":"v"}')).is_null() {
			this.dispatch_set_prop('{"nodeType":"Expr_Variable","line":41,"name":"v"}',
				var_value.clone())
		}
	}
}

fn (mut this Class_Text_Diff_Renderer) text_diff_renderer(var_params rt.PhpVal) {
	mut var_params_mutated := var_params
	mut iife_temp_0 := Class_Text_Diff_Renderer{}
	iife_temp_0.construct(var_params_mutated.clone())
	rt.new_null()
}

fn (mut this Class_Text_Diff_Renderer) getparams() rt.PhpVal {
	mut var_params := rt.new_array()
	mut iter_2 := rt.call_function('get_object_vars', [
		rt.new_object('Text_Diff_Renderer', []string{}, &this),
	]).iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_v := item_2.val
		mut var_k := item_2.key
		if rt.is_true(rt.equal(var_k.array_get(rt.new_int(0)), rt.new_string('_'))) {
			var_params.array_set(rt.call_function('substr', [
				var_k.clone(), rt.new_int(1)]), var_v.clone())
		}
	}
	return var_params.clone()
}

fn (mut this Class_Text_Diff_Renderer) render(var_diff rt.PhpVal) string {
	mut var_yi := rt.new_int(1)
	mut var_xi := var_yi
	mut var_block := rt.new_bool(false)
	mut var_context := rt.new_array()
	mut var_nlead := this._leading_context_lines
	mut var_ntrail := this._trailing_context_lines
	mut var_output := rt.new_string(this._startdiff())
	mut var_diffs := rt.call_method(var_diff, 'getDiff', []rt.PhpVal{})
	mut iter_3 := var_diffs.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_edit := item_3.val
		mut var_i := item_3.key
		if rt.is_true(rt.call_function('is_a', [var_edit.clone(),
			rt.new_string('Text_Diff_Op_copy')]))
		{
			if rt.is_true(rt.new_bool(var_block.clone().is_array())) {
				mut var_keep := if rt.is_true(rt.equal(var_i, var_diffs.clone().array_count() - 1)) {
					var_ntrail
				} else {
					rt.add(var_nlead, var_ntrail)
				}
				if rt.is_true(rt.less_equal(rt.new_int(rt.get_property(var_edit, 'orig').array_count()),
					var_keep))
				{
					var_block.array_push(var_edit.clone())
				} else {
					if rt.is_true(var_ntrail) {
						var_context = rt.call_function('array_slice', [
							rt.get_property(var_edit, 'orig'),
							rt.new_int(0),
							var_ntrail.clone(),
						])
						var_block.array_push(create_text_diff_op_copy(var_context.clone()))
					}
					var_output = rt.concat(var_output, this._block(var_x0.clone(), rt.sub(rt.add(var_ntrail,
						var_xi), var_x0), var_y0.clone(),
						rt.sub(rt.add(var_ntrail, var_yi), var_y0), var_block.clone()))
					var_block = rt.new_bool(false)
				}
			}
			var_context = rt.get_property(var_edit, 'orig')
		} else {
			if !(var_block.clone().is_array()) {
				var_context = rt.call_function('array_slice', [
					var_context.clone(),
					rt.sub(rt.new_int(var_context.clone().array_count()),
						var_nlead)])
				mut var_x0 := rt.sub(var_xi, rt.new_int(var_context.clone().array_count()))
				mut var_y0 := rt.sub(var_yi, rt.new_int(var_context.clone().array_count()))
				var_block = rt.new_array()
				if rt.is_true(var_context) {
					var_block.array_push(create_text_diff_op_copy(var_context.clone()))
				}
			}
			var_block.array_push(var_edit.clone())
		}
		if rt.is_true(rt.get_property(var_edit, 'orig')) {
			var_xi = rt.add(var_xi, rt.new_int(rt.get_property(var_edit, 'orig').array_count()))
		}
		if rt.is_true(rt.get_property(var_edit, 'final')) {
			var_yi = rt.add(var_yi, rt.new_int(rt.get_property(var_edit, 'final').array_count()))
		}
	}
	if rt.is_true(rt.new_bool(var_block.clone().is_array())) {
		var_output = rt.concat(var_output, this._block(var_x0.clone(), rt.sub(var_xi, var_x0),
			var_y0.clone(), rt.sub(var_yi, var_y0), var_block.clone()))
	}
	return var_output.str() + this._enddiff()
}

fn (mut this Class_Text_Diff_Renderer) _block(var_xbeg rt.PhpVal, var_xlen rt.PhpVal, var_ybeg rt.PhpVal, var_ylen rt.PhpVal, var_edits rt.PhpVal) string {
	mut var_xbeg_mutated := var_xbeg
	mut var_ybeg_mutated := var_ybeg
	mut var_output := rt.new_string(this._startblock(rt.new_string(this._blockheader(var_xbeg_mutated.clone(),
		var_xlen.clone(), var_ybeg_mutated.clone(), var_ylen.clone()))))
	mut iter_4 := var_edits.iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_edit := item_4.val
		mut switch_val_1 := rt.new_string(rt.call_function('get_class', [
			var_edit.clone()]).to_string().to_lower())
		if rt.is_true(rt.equal(switch_val_1, rt.new_string('text_diff_op_copy'))) {
			var_output = rt.concat(var_output, this._context(rt.get_property(var_edit, 'orig')))
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('text_diff_op_add'))) {
			var_output = rt.concat(var_output, this._added(rt.get_property(var_edit, 'final')))
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('text_diff_op_delete'))) {
			var_output = rt.concat(var_output, this._deleted(rt.get_property(var_edit, 'orig')))
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('text_diff_op_change'))) {
			var_output = rt.concat(var_output, this._changed(rt.get_property(var_edit, 'orig'), rt.get_property(var_edit,
				'final')))
		}
	}
	return var_output.str() + this._endblock()
}

fn (mut this Class_Text_Diff_Renderer) _startdiff() string {
	return ''
}

fn (mut this Class_Text_Diff_Renderer) _enddiff() string {
	return ''
}

fn (mut this Class_Text_Diff_Renderer) _blockheader(var_xbeg rt.PhpVal, var_xlen rt.PhpVal, var_ybeg rt.PhpVal, var_ylen rt.PhpVal) string {
	mut var_xbeg_mutated := var_xbeg
	mut var_ybeg_mutated := var_ybeg
	if rt.is_true(rt.greater(var_xlen, rt.new_int(1))) {
		var_xbeg_mutated = rt.concat(var_xbeg_mutated, rt.new_string(',' +
			(rt.sub(rt.add(var_xbeg_mutated, var_xlen), rt.new_int(1))).str()))
	}
	if rt.is_true(rt.greater(var_ylen, rt.new_int(1))) {
		var_ybeg_mutated = rt.concat(var_ybeg_mutated, rt.new_string(',' +
			(rt.sub(rt.add(var_ybeg_mutated, var_ylen), rt.new_int(1))).str()))
	}
	if rt.is_true(var_xlen) && rt.is_true(rt.new_bool(!(rt.is_true(var_ylen)))) {
		rt.post_dec(var_ybeg_mutated)
	} else if rt.is_true(rt.new_bool(!(rt.is_true(var_xlen)))) {
		rt.post_dec(var_xbeg_mutated)
	}
	return var_xbeg_mutated.str() + if rt.is_true(var_xlen) {
		if rt.is_true(var_ylen) {
			'c'
		} else {
			'd'
		}
	} else {
		'a'
	} + var_ybeg_mutated.str()
}

fn (mut this Class_Text_Diff_Renderer) _startblock(var_header rt.PhpVal) string {
	return var_header.str() + '\n'
}

fn (mut this Class_Text_Diff_Renderer) _endblock() string {
	return ''
}

fn (mut this Class_Text_Diff_Renderer) _lines(var_lines rt.PhpVal, prefix string) string {
	return prefix +
		(rt.call_function('implode', [rt.new_string('\n${var_prefix}'), var_lines.clone()])).str() +
		'\n'
}

fn (mut this Class_Text_Diff_Renderer) _context(var_lines rt.PhpVal) rt.PhpVal {
	return rt.new_string(this._lines(var_lines.clone(), '  '))
}

fn (mut this Class_Text_Diff_Renderer) _added(var_lines rt.PhpVal) rt.PhpVal {
	return rt.new_string(this._lines(var_lines.clone(), '> '))
}

fn (mut this Class_Text_Diff_Renderer) _deleted(var_lines rt.PhpVal) rt.PhpVal {
	return rt.new_string(this._lines(var_lines.clone(), '< '))
}

fn (mut this Class_Text_Diff_Renderer) _changed(var_orig rt.PhpVal, var_final rt.PhpVal) string {
	return
		(this._deleted(var_orig.clone())).str() + '---\n' + (this._added(var_final.clone())).str()
}

struct Class_Text_Diff_Op_copy {
	rt.PhpObjectBase
}

fn create_text_diff_renderer(arg_0 rt.PhpVal) &Class_Text_Diff_Renderer {
	mut obj := &Class_Text_Diff_Renderer{
		PhpObjectBase:           rt.PhpObjectBase{}
		_leading_context_lines:  rt.new_int(0)
		_trailing_context_lines: rt.new_int(0)
	}
	obj.construct(arg_0)
	return obj
}

fn create_text_diff_op_copy(_args ...rt.PhpVal) &Class_Text_Diff_Op_copy {
	mut obj := &Class_Text_Diff_Op_copy{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Text_Diff_Renderer) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'Text_Diff_Renderer' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.text_diff_renderer(dispatch_arg_0)
			return rt.new_null()
		}
		'getParams' {
			return this.getparams()
		}
		'render' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.render(dispatch_arg_0))
		}
		'_block' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			dispatch_arg_4 := if args.len > 4 { args[4] } else { rt.new_null() }
			return rt.new_string(this._block(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2,
				dispatch_arg_3, dispatch_arg_4))
		}
		'_startDiff' {
			return rt.new_string(this._startdiff())
		}
		'_endDiff' {
			return rt.new_string(this._enddiff())
		}
		'_blockHeader' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			return rt.new_string(this._blockheader(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2,
				dispatch_arg_3))
		}
		'_startBlock' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this._startblock(dispatch_arg_0))
		}
		'_endBlock' {
			return rt.new_string(this._endblock())
		}
		'_lines' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return rt.new_string(this._lines(dispatch_arg_0, dispatch_arg_1))
		}
		'_context' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this._context(dispatch_arg_0)
		}
		'_added' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this._added(dispatch_arg_0)
		}
		'_deleted' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this._deleted(dispatch_arg_0)
		}
		'_changed' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_string(this._changed(dispatch_arg_0, dispatch_arg_1))
		}
		else {
			return none
		}
	}
}

fn (this &Class_Text_Diff_Renderer) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'_leading_context_lines' { return this._leading_context_lines }
		'_trailing_context_lines' { return this._trailing_context_lines }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Text_Diff_Renderer) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'_leading_context_lines' {
			this._leading_context_lines = val
			return true
		}
		'_trailing_context_lines' {
			this._trailing_context_lines = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
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

fn main() {
	defer {
		rt.shutdown()
	}
}
