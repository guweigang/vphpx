import rt

struct Class_Text_Diff_Engine_shell {
	rt.PhpObjectBase
pub mut:
	_diffCommand rt.PhpVal = rt.new_string('diff')
}

fn (mut this Class_Text_Diff_Engine_shell) diff(var_from_lines rt.PhpVal, var_to_lines rt.PhpVal) rt.PhpVal {
	mut var_matches := rt.new_null()
	rt.call_function('array_walk', [var_from_lines.clone(),
		rt.create_array([rt.ArrayItem{ key: none, val: 'Text_Diff' },
			rt.ArrayItem{ key: none, val: 'trimNewlines' }])])
	rt.call_function('array_walk', [var_to_lines.clone(),
		rt.create_array([rt.ArrayItem{ key: none, val: 'Text_Diff' },
			rt.ArrayItem{ key: none, val: 'trimNewlines' }])])
	mut iife_temp_0 := Class_Text_Diff{}
	mut iife_result_0 := iife_temp_0._gettempdir()
	mut var_temp_dir := iife_result_0
	mut var_from_file := rt.call_function('tempnam', [var_temp_dir.clone(),
		rt.new_string('Text_Diff')])
	mut var_to_file := rt.call_function('tempnam', [var_temp_dir.clone(),
		rt.new_string('Text_Diff')])
	mut var_fp := rt.call_function('fopen', [var_from_file.clone(),
		rt.new_string('w')])
	rt.call_function('fwrite', [var_fp.clone(),
		rt.call_function('implode', [rt.new_string('\n'), var_from_lines.clone()])])
	rt.call_function('fclose', [var_fp.clone()])
	var_fp = rt.call_function('fopen', [var_to_file.clone(), rt.new_string('w')])
	rt.call_function('fwrite', [var_fp.clone(),
		rt.call_function('implode', [rt.new_string('\n'), var_to_lines.clone()])])
	rt.call_function('fclose', [var_fp.clone()])
	mut var_diff := rt.call_function('shell_exec', [
		rt.new_string((this._diffCommand).str() + ' ' + var_from_file.str() + ' ' +
			var_to_file.str()),
	])
	rt.call_function('unlink', [var_from_file.clone()])
	rt.call_function('unlink', [var_to_file.clone()])
	if rt.is_true(rt.new_bool(var_diff.clone().is_null())) {
		return rt.create_array([
			rt.ArrayItem{ key: none, val: create_text_diff_op_copy(var_from_lines.clone()) },
		])
	}
	mut var_from_line_no := rt.new_int(1)
	mut var_to_line_no := rt.new_int(1)
	mut var_edits := rt.new_array()
	rt.call_function('preg_match_all', [
		rt.new_string('#^(\\d+)(?:,(\\d+))?([adc])(\\d+)(?:,(\\d+))?$#m'),
		var_diff.clone(),
		var_matches.clone(),
		rt.get_constant('PREG_SET_ORDER'),
	])
	mut iter_1 := var_matches.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_match := item_1.val
		if !(var_match.array_isset(rt.new_int(5))) {
			var_match.array_set(5, false)
		}
		if rt.is_true(rt.equal(var_match.array_get(rt.new_int(3)), rt.new_string('a'))) {
			rt.post_dec(var_from_line_no)
		}
		if rt.is_true(rt.equal(var_match.array_get(rt.new_int(3)), rt.new_string('d'))) {
			rt.post_dec(var_to_line_no)
		}
		if rt.is_true(rt.less(var_from_line_no, var_match.array_get(rt.new_int(1))))
			|| rt.is_true(rt.less(var_to_line_no, var_match.array_get(rt.new_int(4)))) {
			rt.call_function('assert', [
				rt.equal(rt.sub(var_match.array_get(rt.new_int(1)), var_from_line_no), rt.sub(var_match.array_get(rt.new_int(4)),
					var_to_line_no)),
			])
			var_edits.clone().array_push(create_text_diff_op_copy(this._getlines(var_from_lines.clone(),
				var_from_line_no.clone(),
				(rt.sub(var_match.array_get(rt.new_int(1)), rt.new_int(1))).to_bool()), this._getlines(var_to_lines.clone(),
				var_to_line_no.clone(),
				(rt.sub(var_match.array_get(rt.new_int(4)), rt.new_int(1))).to_bool())))
		}
		mut switch_val_1 := var_match.array_get(rt.new_int(3))
		if rt.is_true(rt.equal(switch_val_1, rt.new_string('d'))) {
			var_edits.clone().array_push(create_text_diff_op_delete(this._getlines(var_from_lines.clone(),
				var_from_line_no.clone(), (var_match.array_get(rt.new_int(2))).to_bool())))
			rt.post_inc(var_to_line_no)
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('c'))) {
			var_edits.clone().array_push(create_text_diff_op_change(this._getlines(var_from_lines.clone(),
				var_from_line_no.clone(), (var_match.array_get(rt.new_int(2))).to_bool()), this._getlines(var_to_lines.clone(),
				var_to_line_no.clone(), (var_match.array_get(rt.new_int(5))).to_bool())))
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('a'))) {
			var_edits.clone().array_push(create_text_diff_op_add(this._getlines(var_to_lines.clone(),
				var_to_line_no.clone(), (var_match.array_get(rt.new_int(5))).to_bool())))
			rt.post_inc(var_from_line_no)
		}
	}
	if !(!rt.is_true(var_from_lines)) {
		var_edits.clone().array_push(create_text_diff_op_copy(this._getlines(var_from_lines.clone(),
			var_from_line_no.clone(), (rt.sub(rt.add(var_from_line_no,
			rt.new_int(var_from_lines.clone().array_count())), rt.new_int(1))).to_bool()), this._getlines(var_to_lines.clone(),
			var_to_line_no.clone(), (rt.sub(rt.add(var_to_line_no,
			rt.new_int(var_to_lines.clone().array_count())), rt.new_int(1))).to_bool())))
	}
	return var_edits.clone()
}

fn (mut this Class_Text_Diff_Engine_shell) _getlines(var_text_lines rt.PhpVal, var_line_no rt.PhpVal, end bool) rt.PhpVal {
	mut var_line_no_mutated := var_line_no
	if !(!end) {
		mut var_lines := rt.new_array()
		for rt.is_true(rt.less_equal(var_line_no_mutated, rt.new_bool(end))) {
			rt.create_array_from_list(var_lines).array_push(rt.call_function('array_shift', [
				var_text_lines.clone(),
			]))
			rt.post_inc(var_line_no_mutated)
		}
	} else {
		var_lines = [rt.call_function('array_shift', [var_text_lines.clone()])]
		rt.post_inc(var_line_no_mutated)
	}
	return var_lines.clone()
}

struct Class_Text_Diff {
	rt.PhpObjectBase
}

struct Class_Text_Diff_Op_copy {
	rt.PhpObjectBase
}

struct Class_Text_Diff_Op_delete {
	rt.PhpObjectBase
}

struct Class_Text_Diff_Op_change {
	rt.PhpObjectBase
}

struct Class_Text_Diff_Op_add {
	rt.PhpObjectBase
}

fn create_text_diff_engine_shell(_args ...rt.PhpVal) &Class_Text_Diff_Engine_shell {
	mut obj := &Class_Text_Diff_Engine_shell{
		PhpObjectBase: rt.PhpObjectBase{}
		_diffCommand:  rt.new_string('diff')
	}
	return obj
}

fn create_text_diff(_args ...rt.PhpVal) &Class_Text_Diff {
	mut obj := &Class_Text_Diff{
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

fn create_text_diff_op_add(_args ...rt.PhpVal) &Class_Text_Diff_Op_add {
	mut obj := &Class_Text_Diff_Op_add{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Text_Diff_Engine_shell) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'diff' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.diff(dispatch_arg_0, dispatch_arg_1)
		}
		'_getLines' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
			return this._getlines(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Text_Diff_Engine_shell) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'_diffCommand' { return this._diffCommand }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Text_Diff_Engine_shell) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'_diffCommand' {
			this._diffCommand = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_Text_Diff) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Text_Diff) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Text_Diff) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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
