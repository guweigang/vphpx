import rt

struct Class_Text_Diff_Renderer {
	rt.PhpObjectBase
pub mut:
		_leading_context_lines rt.PhpVal = rt.new_int(0)
		_trailing_context_lines rt.PhpVal = rt.new_int(0)
}

fn (mut this Class_Text_Diff_Renderer) construct(var_params rt.PhpVal)  {
	mut var_params_mutated := var_params
	{
		mut iter_1 := var_params_mutated.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_value := item_1.val
			mut var_param := item_1.key
			mut var_v := rt.new_string('_' + (var_param).str())
			if !(rt.get_property(rt.new_object('Text_Diff_Renderer', []string{}, &this), '{"nodeType":"Expr_Variable","line":40,"name":"v"}')).is_null() {
				this.dispatch_set_prop('{"nodeType":"Expr_Variable","line":41,"name":"v"}', var_value.dup())
			}
		}
	}
}

fn (mut this Class_Text_Diff_Renderer) text_diff_renderer(var_params rt.PhpVal)  {
	mut var_params_mutated := var_params
	fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Text_Diff_Renderer{}; temp.construct(arg_0); return rt.new_null() }(var_params_mutated.dup())
}

fn (mut this Class_Text_Diff_Renderer) getparams() rt.PhpVal {
	mut var_params := rt.new_array()
	{
		mut iter_1 := rt.call_function('get_object_vars', [rt.new_object('Text_Diff_Renderer', []string{}, &this)]).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_v := item_1.val
			mut var_k := item_1.key
			if rt.is_true(rt.equal(var_k.array_get(0), rt.new_string('_'))) {
				var_params.array_set(rt.call_function('substr', [var_k.dup(), rt.new_int(1)]), var_v.dup())
			}
		}
	}
	return var_params.dup()
}

fn (mut this Class_Text_Diff_Renderer) render(var_diff rt.PhpVal) string {
	mut var_xi := mut var_yi := rt.new_int(rt.new_int(1))
	mut var_block := rt.new_bool(rt.new_bool(false))
	mut var_context := rt.new_array()
	mut var_nlead := this._leading_context_lines
	mut var_ntrail := this._trailing_context_lines
	mut var_output := rt.new_string(this._startdiff())
	mut var_diffs := rt.call_method(var_diff, 'getDiff', []rt.PhpVal{})
	{
		mut iter_1 := var_diffs.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_edit := item_1.val
			mut var_i := item_1.key
			if rt.is_true(rt.call_function('is_a', [var_edit.dup(), rt.new_string('Text_Diff_Op_copy')])) {
				if rt.is_true(rt.new_bool(var_block.dup().is_array())) {
					mut var_keep := if rt.is_true(rt.equal(var_i, var_diffs.dup().array_count() - 1)) { var_ntrail } else { rt.add(var_nlead, var_ntrail) }
					if rt.is_true(rt.less_equal(rt.new_int(rt.get_property(var_edit, 'orig').array_count()), var_keep)) {
						var_block.array_push(var_edit.dup())
					} else {
						if rt.is_true(var_ntrail) {
							var_context = rt.call_function('array_slice', [rt.get_property(var_edit, 'orig'), rt.new_int(0), var_ntrail.dup()])
							var_block.array_push(create_text_diff_op_copy(var_context.dup()))
						}
						// unsupported expression: Expr_AssignOp_Concat
						var_block = rt.new_bool(rt.new_bool(false))
					}
				}
				var_context = rt.get_property(var_edit, 'orig')
			} else {
				if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_block.dup().is_array()))))) {
					var_context = rt.call_function('array_slice', [var_context.dup(), rt.sub(rt.new_int(var_context.dup().array_count()), var_nlead)])
					mut var_x0 := rt.sub(var_xi, rt.new_int(var_context.dup().array_count()))
					mut var_y0 := rt.sub(var_yi, rt.new_int(var_context.dup().array_count()))
					var_block = rt.new_array()
					if rt.is_true(var_context) {
						var_block.array_push(create_text_diff_op_copy(var_context.dup()))
					}
				}
				var_block.array_push(var_edit.dup())
			}
			if rt.is_true(rt.get_property(var_edit, 'orig')) {
				// unsupported expression: Expr_AssignOp_Plus
			}
			if rt.is_true(rt.get_property(var_edit, 'final')) {
				// unsupported expression: Expr_AssignOp_Plus
			}
		}
	}
	if rt.is_true(rt.new_bool(var_block.dup().is_array())) {
		// unsupported expression: Expr_AssignOp_Concat
	}
	return (var_output).str() + this._enddiff()
}

fn (mut this Class_Text_Diff_Renderer) _block(var_xbeg rt.PhpVal, var_xlen rt.PhpVal, var_ybeg rt.PhpVal, var_ylen rt.PhpVal, var_edits rt.PhpVal) string {
	mut var_xbeg_mutated := var_xbeg
	mut var_ybeg_mutated := var_ybeg
	mut var_output := rt.new_string(this._startblock(rt.new_string(this._blockheader(var_xbeg_mutated.dup(), var_xlen.dup(), var_ybeg_mutated.dup(), var_ylen.dup()))))
	{
		mut iter_1 := var_edits.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_edit := item_1.val
			mut switch_val_1 := rt.new_string(rt.call_function('get_class', [var_edit.dup()]).to_string().to_lower())
			if rt.is_true(rt.equal(switch_val_1, rt.new_string('text_diff_op_copy'))) {
				// unsupported expression: Expr_AssignOp_Concat
			} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('text_diff_op_add'))) {
				// unsupported expression: Expr_AssignOp_Concat
			} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('text_diff_op_delete'))) {
				// unsupported expression: Expr_AssignOp_Concat
			} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('text_diff_op_change'))) {
				// unsupported expression: Expr_AssignOp_Concat
			}
		}
	}
	return (var_output).str() + this._endblock()
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
		// unsupported expression: Expr_AssignOp_Concat
	}
	if rt.is_true(rt.greater(var_ylen, rt.new_int(1))) {
		// unsupported expression: Expr_AssignOp_Concat
	}
	if rt.is_true(rt.new_bool(rt.is_true(var_xlen) && rt.is_true(rt.new_bool(!(rt.is_true(var_ylen)))))) {
		rt.post_dec(var_ybeg_mutated)
	} else if rt.is_true(rt.new_bool(!(rt.is_true(var_xlen)))) {
		rt.post_dec(var_xbeg_mutated)
	}
	return (var_xbeg_mutated).str() + if rt.is_true(var_xlen) { if rt.is_true(var_ylen) { 'c' } else { 'd' } } else { 'a' } + (var_ybeg_mutated).str()
}

fn (mut this Class_Text_Diff_Renderer) _startblock(var_header rt.PhpVal) string {
	return (var_header).str() + '\n'
}

fn (mut this Class_Text_Diff_Renderer) _endblock() string {
	return ''
}

fn (mut this Class_Text_Diff_Renderer) _lines(var_lines rt.PhpVal, prefix string) string {
	return prefix + (rt.call_function('implode', [rt.new_string("\n${var_prefix}"), var_lines.dup()])).str() + '\n'
}

fn (mut this Class_Text_Diff_Renderer) _context(var_lines rt.PhpVal) rt.PhpVal {
	return rt.new_string(this._lines(var_lines.dup(), '  '))
}

fn (mut this Class_Text_Diff_Renderer) _added(var_lines rt.PhpVal) rt.PhpVal {
	return rt.new_string(this._lines(var_lines.dup(), '> '))
}

fn (mut this Class_Text_Diff_Renderer) _deleted(var_lines rt.PhpVal) rt.PhpVal {
	return rt.new_string(this._lines(var_lines.dup(), '< '))
}

fn (mut this Class_Text_Diff_Renderer) _changed(var_orig rt.PhpVal, var_final rt.PhpVal) string {
	return (this._deleted(var_orig.dup())).str() + '---\n' + (this._added(var_final.dup())).str()
}

struct Class_Text_Diff_Op_copy {
	rt.PhpObjectBase
}

fn create_text_diff_renderer(arg_0 rt.PhpVal) &Class_Text_Diff_Renderer {
	mut obj := &Class_Text_Diff_Renderer{
		PhpObjectBase: rt.PhpObjectBase{}
		_leading_context_lines: rt.new_int(0)
		_trailing_context_lines: rt.new_int(0)
	}
	obj.construct(arg_0)
	return obj
}

fn create_text_diff_op_copy() &Class_Text_Diff_Op_copy {
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
			return rt.new_string(this._block(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3, dispatch_arg_4))
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
			return rt.new_string(this._blockheader(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3))
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
		else { return none }
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
		'_leading_context_lines' { this._leading_context_lines = val; return true }
		'_trailing_context_lines' { this._trailing_context_lines = val; return true }
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




pub fn init_wp_includes_text_diff_renderer_php() {
}
