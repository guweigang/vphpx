import rt

struct Class_Text_Diff_Engine_xdiff {
	rt.PhpObjectBase
}

fn (mut this Class_Text_Diff_Engine_xdiff) diff(var_from_lines rt.PhpVal, var_to_lines rt.PhpVal) rt.PhpVal {
	rt.call_function('array_walk', [var_from_lines.dup(),
		rt.create_array([rt.ArrayItem{ key: none, val: 'Text_Diff' },
			rt.ArrayItem{ key: none, val: 'trimNewlines' }])])
	rt.call_function('array_walk', [var_to_lines.dup(),
		rt.create_array([rt.ArrayItem{ key: none, val: 'Text_Diff' },
			rt.ArrayItem{ key: none, val: 'trimNewlines' }])])
	mut var_from_string := rt.call_function('implode', [rt.new_string('\n'),
		var_from_lines.dup()])
	mut var_to_string := rt.call_function('implode', [rt.new_string('\n'),
		var_to_lines.dup()])
	mut var_diff := rt.call_function('xdiff_string_diff', [var_from_string.dup(),
		var_to_string.dup(), rt.new_int(var_to_lines.dup().array_count())])
	var_diff = rt.call_function('explode', [rt.new_string('\n'),
		var_diff.dup()])
	mut var_edits := rt.new_array()
	{
		mut iter_1 := var_diff.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_line := item_1.val
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_int(var_line.dup().to_string().len))))) {
				continue
			}
			mut switch_val_1 := var_line.array_get(0)
			if rt.is_true(rt.equal(switch_val_1, rt.new_string(' '))) {
				var_edits.array_push(create_text_diff_op_copy(rt.create_array([
					rt.ArrayItem{ key: none, val: rt.call_function('substr', [
						var_line.dup(), rt.new_int(1)]) },
				])))
			} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('+'))) {
				var_edits.array_push(create_text_diff_op_add(rt.create_array([
					rt.ArrayItem{ key: none, val: rt.call_function('substr', [
						var_line.dup(), rt.new_int(1)]) },
				])))
			} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('-'))) {
				var_edits.array_push(create_text_diff_op_delete(rt.create_array([
					rt.ArrayItem{ key: none, val: rt.call_function('substr', [
						var_line.dup(), rt.new_int(1)]) },
				])))
			}
		}
	}
	return var_edits.dup()
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

fn create_text_diff_engine_xdiff() &Class_Text_Diff_Engine_xdiff {
	mut obj := &Class_Text_Diff_Engine_xdiff{
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

fn (mut this Class_Text_Diff_Engine_xdiff) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'diff' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.diff(dispatch_arg_0, dispatch_arg_1)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Text_Diff_Engine_xdiff) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Text_Diff_Engine_xdiff) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

pub fn init_wp_includes_text_diff_engine_xdiff_php() {
}
