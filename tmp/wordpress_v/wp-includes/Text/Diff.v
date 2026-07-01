import rt

struct Class_Text_Diff {
	rt.PhpObjectBase
pub mut:
		_edits rt.PhpVal = rt.new_null()
}

fn (mut this Class_Text_Diff) construct(var_engine rt.PhpVal, var_params rt.PhpVal)  {
	mut var_engine_mutated := var_engine
	mut var_params_mutated := var_params
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_engine_mutated.dup().is_string()))))) {
		var_params_mutated = rt.create_array([rt.ArrayItem{ key: none, val: var_engine_mutated }, rt.ArrayItem{ key: none, val: var_params_mutated }])
		var_engine_mutated = rt.new_string(rt.new_string('auto'))
	}
	if rt.is_true(rt.equal(var_engine_mutated, rt.new_string('auto'))) {
		var_engine_mutated = rt.new_string(if rt.is_true(rt.call_function('extension_loaded', [rt.new_string('xdiff')])) { rt.new_string('xdiff') } else { rt.new_string('native') })
	} else {
		var_engine_mutated = rt.call_function('basename', [var_engine_mutated.dup()])
	}
	rt.include_file((rt.call_function('dirname', [rt.new_string(@FILE)])).str() + '/Diff/Engine/' + (var_engine_mutated).str() + '.php', '4')
	mut var_class := rt.new_string('Text_Diff_Engine_' + (var_engine_mutated).str())
	mut var_diff_engine := rt.create_object_dynamically(var_class, []rt.PhpVal{})
	this._edits = rt.call_function('call_user_func_array', [rt.create_array([rt.ArrayItem{ key: none, val: var_diff_engine }, rt.ArrayItem{ key: none, val: 'diff' }]), var_params_mutated.dup()])
}

fn (mut this Class_Text_Diff) text_diff(var_engine rt.PhpVal, var_params rt.PhpVal)  {
	mut var_engine_mutated := var_engine
	mut var_params_mutated := var_params
	fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Text_Diff{}; temp.construct(arg_0, arg_1); return rt.new_null() }(var_engine_mutated.dup(), var_params_mutated.dup())
}

fn (mut this Class_Text_Diff) getdiff() rt.PhpVal {
	return this._edits
}

fn (mut this Class_Text_Diff) countaddedlines() rt.PhpVal {
	mut var_count := rt.new_int(rt.new_int(0))
	{
		mut iter_1 := this._edits.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_edit := item_1.val
			if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('is_a', [var_edit.dup(), rt.new_string('Text_Diff_Op_add')])) || rt.is_true(rt.call_function('is_a', [var_edit.dup(), rt.new_string('Text_Diff_Op_change')])))) {
				// unsupported expression: Expr_AssignOp_Plus
			}
		}
	}
	return var_count.dup()
}

fn (mut this Class_Text_Diff) countdeletedlines() rt.PhpVal {
	mut var_count := rt.new_int(rt.new_int(0))
	{
		mut iter_1 := this._edits.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_edit := item_1.val
			if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('is_a', [var_edit.dup(), rt.new_string('Text_Diff_Op_delete')])) || rt.is_true(rt.call_function('is_a', [var_edit.dup(), rt.new_string('Text_Diff_Op_change')])))) {
				// unsupported expression: Expr_AssignOp_Plus
			}
		}
	}
	return var_count.dup()
}

fn (mut this Class_Text_Diff) reverse() rt.PhpVal {
	if rt.is_true(rt.call_function('version_compare', [rt.call_function('zend_version', []rt.PhpVal{}), rt.new_string('2'), rt.new_string('>')])) {
		mut var_rev := // unsupported expression: Expr_Clone
	} else {
		var_rev = rt.new_object('Text_Diff', []string{}, &this).dup()
	}
	rt.set_property(var_rev, '_edits', rt.new_array())
	{
		mut iter_1 := this._edits.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_edit := item_1.val
			rt.get_property(var_rev, '_edits').array_push(rt.call_method(var_edit, 'reverse', []rt.PhpVal{}))
		}
	}
	return var_rev.dup()
}

fn (mut this Class_Text_Diff) isempty() bool {
	{
		mut iter_1 := this._edits.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_edit := item_1.val
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_a', [var_edit.dup(), rt.new_string('Text_Diff_Op_copy')]))))) {
				return false
			}
		}
	}
	return true
}

fn (mut this Class_Text_Diff) lcs() rt.PhpVal {
	mut var_lcs := rt.new_int(rt.new_int(0))
	{
		mut iter_1 := this._edits.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_edit := item_1.val
			if rt.is_true(rt.call_function('is_a', [var_edit.dup(), rt.new_string('Text_Diff_Op_copy')])) {
				// unsupported expression: Expr_AssignOp_Plus
			}
		}
	}
	return var_lcs.dup()
}

fn (mut this Class_Text_Diff) getoriginal() rt.PhpVal {
	mut var_lines := rt.new_array()
	{
		mut iter_1 := this._edits.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_edit := item_1.val
			if rt.is_true(rt.get_property(var_edit, 'orig')) {
				rt.call_function('array_splice', [var_lines.dup(), rt.new_int(var_lines.dup().array_count()), rt.new_int(0), rt.get_property(var_edit, 'orig')])
			}
		}
	}
	return var_lines.dup()
}

fn (mut this Class_Text_Diff) getfinal() rt.PhpVal {
	mut var_lines := rt.new_array()
	{
		mut iter_1 := this._edits.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_edit := item_1.val
			if rt.is_true(rt.get_property(var_edit, 'final')) {
				rt.call_function('array_splice', [var_lines.dup(), rt.new_int(var_lines.dup().array_count()), rt.new_int(0), rt.get_property(var_edit, 'final')])
			}
		}
	}
	return var_lines.dup()
}

fn Class_Text_Diff.trimnewlines(var_line rt.PhpVal, var_key rt.PhpVal)  {
	mut var_line_mutated := var_line
	var_line_mutated = rt.call_function('str_replace', [rt.create_array([rt.ArrayItem{ key: none, val: '\n' }, rt.ArrayItem{ key: none, val: '\r' }]), rt.new_string(''), var_line_mutated.dup()])
}

fn Class_Text_Diff._gettempdir() rt.PhpVal {
	return rt.call_function('get_temp_dir', []rt.PhpVal{})
}

fn (mut this Class_Text_Diff) _check(var_from_lines rt.PhpVal, var_to_lines rt.PhpVal) bool {
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotEqual) {
		rt.throw_exception(rt.new_object('Text_Exception', []string{}, create_text_exception(rt.new_string('Reconstructed original does not match'))))
	}
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotEqual) {
		rt.throw_exception(rt.new_object('Text_Exception', []string{}, create_text_exception(rt.new_string('Reconstructed final does not match'))))
	}
	mut var_rev := this.reverse()
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotEqual) {
		rt.throw_exception(rt.new_object('Text_Exception', []string{}, create_text_exception(rt.new_string('Reversed original does not match'))))
	}
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotEqual) {
		rt.throw_exception(rt.new_object('Text_Exception', []string{}, create_text_exception(rt.new_string('Reversed final does not match'))))
	}
	mut var_prevtype := rt.new_null()
	{
		mut iter_1 := this._edits.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_edit := item_1.val
			if rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) && rt.is_true(rt.new_bool(rt.instance_of(var_edit, '{"nodeType":"Expr_Variable","line":256,"name":"prevtype"}'))))) {
				rt.throw_exception(rt.new_object('Text_Exception', []string{}, create_text_exception(rt.new_string('Edit sequence is non-optimal'))))
			}
			var_prevtype = rt.call_function('get_class', [var_edit.dup()])
		}
	}
	return true
}

struct Class_Text_MappedDiff {
	rt.PhpObjectBase
}

fn (mut this Class_Text_MappedDiff) construct(var_from_lines rt.PhpVal, var_to_lines rt.PhpVal, var_mapped_from_lines rt.PhpVal, var_mapped_to_lines rt.PhpVal)  {
	rt.call_function('assert', [rt.new_bool(var_from_lines.dup().array_count() == var_mapped_from_lines.dup().array_count())])
	rt.call_function('assert', [rt.new_bool(var_to_lines.dup().array_count() == var_mapped_to_lines.dup().array_count())])
	this.Class_Text_Diff.text_diff(var_mapped_from_lines.dup(), var_mapped_to_lines.dup())
	mut var_xi := mut var_yi := rt.new_int(rt.new_int(0))
	{
		mut var_i := rt.new_int(rt.new_int(0))
		for {
			if !(rt.is_true(rt.less(var_i, rt.new_int(rt.get_property(rt.new_object('Text_MappedDiff', ['Text_Diff'], &this), '_edits').array_count())))) { break }
			// unsupported expression: Expr_AssignRef
			if rt.is_true(rt.new_bool(var_orig.dup().is_array())) {
				mut var_orig := rt.call_function('array_slice', [var_from_lines.dup(), var_xi.dup(), rt.new_int(var_orig.dup().array_count())])
				// unsupported expression: Expr_AssignOp_Plus
			}
			// unsupported expression: Expr_AssignRef
			if rt.is_true(rt.new_bool(var_final.dup().is_array())) {
				mut var_final := rt.call_function('array_slice', [var_to_lines.dup(), var_yi.dup(), rt.new_int(var_final.dup().array_count())])
				// unsupported expression: Expr_AssignOp_Plus
			}
			rt.post_inc(var_i)
		}
	}
}

fn (mut this Class_Text_MappedDiff) text_mappeddiff(var_from_lines rt.PhpVal, var_to_lines rt.PhpVal, var_mapped_from_lines rt.PhpVal, var_mapped_to_lines rt.PhpVal)  {
	fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal, arg_3 rt.PhpVal) rt.PhpVal { mut temp := Class_Text_MappedDiff{}; temp.construct(arg_0, arg_1, arg_2, arg_3); return rt.new_null() }(var_from_lines.dup(), var_to_lines.dup(), var_mapped_from_lines.dup(), var_mapped_to_lines.dup())
}

struct Class_Text_Diff_Op {
	rt.PhpObjectBase
pub mut:
		orig rt.PhpVal = rt.new_null()
		final rt.PhpVal = rt.new_null()
}

fn (mut this Class_Text_Diff_Op) reverse()  {
}

fn (mut this Class_Text_Diff_Op) norig() i64 {
	return if rt.is_true(this.orig) { this.orig.array_count() } else { 0 }
}

fn (mut this Class_Text_Diff_Op) nfinal() i64 {
	return if rt.is_true(this.final) { this.final.array_count() } else { 0 }
}

struct Class_Text_Diff_Op_copy {
	Class_Text_Diff_Op
}

fn (mut this Class_Text_Diff_Op_copy) construct(var_orig rt.PhpVal, final bool)  {
	mut var_orig_mutated := var_orig
	mut final_mutated := final
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.new_bool(final_mutated).dup().is_array()))))) {
		final_mutated = (var_orig_mutated).to_bool()
	}
	this.orig = var_orig_mutated.dup()
	this.final = rt.new_bool(final_mutated).dup()
}

fn (mut this Class_Text_Diff_Op_copy) text_diff_op_copy(var_orig rt.PhpVal, final bool)  {
	mut var_orig_mutated := var_orig
	mut final_mutated := final
	fn (arg_0 bool, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Text_Diff_Op_copy{}; temp.construct(arg_0, arg_1); return rt.new_null() }((var_orig_mutated).to_bool(), rt.new_bool(final_mutated))
}

fn (mut this Class_Text_Diff_Op_copy) reverse()  {
	mut var_reverse := create_text_diff_op_copy(this.final, this.orig)
	return var_reverse.dup()
}

struct Class_Text_Diff_Op_delete {
	Class_Text_Diff_Op
}

fn (mut this Class_Text_Diff_Op_delete) construct(var_lines rt.PhpVal)  {
	mut var_lines_mutated := var_lines
	this.orig = var_lines_mutated.dup()
	this.final = false
}

fn (mut this Class_Text_Diff_Op_delete) text_diff_op_delete(var_lines rt.PhpVal)  {
	mut var_lines_mutated := var_lines
	fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Text_Diff_Op_delete{}; temp.construct(arg_0); return rt.new_null() }(var_lines_mutated.dup())
}

fn (mut this Class_Text_Diff_Op_delete) reverse()  {
	mut var_reverse := create_text_diff_op_add(this.orig)
	return var_reverse.dup()
}

struct Class_Text_Diff_Op_add {
	Class_Text_Diff_Op
}

fn (mut this Class_Text_Diff_Op_add) construct(var_lines rt.PhpVal)  {
	mut var_lines_mutated := var_lines
	this.final = var_lines_mutated.dup()
	this.orig = false
}

fn (mut this Class_Text_Diff_Op_add) text_diff_op_add(var_lines rt.PhpVal)  {
	mut var_lines_mutated := var_lines
	fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Text_Diff_Op_add{}; temp.construct(arg_0); return rt.new_null() }(var_lines_mutated.dup())
}

fn (mut this Class_Text_Diff_Op_add) reverse()  {
	mut var_reverse := create_text_diff_op_delete(this.final)
	return var_reverse.dup()
}

struct Class_Text_Diff_Op_change {
	Class_Text_Diff_Op
}

fn (mut this Class_Text_Diff_Op_change) construct(var_orig rt.PhpVal, var_final rt.PhpVal)  {
	mut var_orig_mutated := var_orig
	mut var_final_mutated := var_final
	this.orig = var_orig_mutated.dup()
	this.final = var_final_mutated.dup()
}

fn (mut this Class_Text_Diff_Op_change) text_diff_op_change(var_orig rt.PhpVal, var_final rt.PhpVal)  {
	mut var_orig_mutated := var_orig
	mut var_final_mutated := var_final
	fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Text_Diff_Op_change{}; temp.construct(arg_0, arg_1); return rt.new_null() }(var_orig_mutated.dup(), var_final_mutated.dup())
}

fn (mut this Class_Text_Diff_Op_change) reverse()  {
	mut var_reverse := create_text_diff_op_change(this.final, this.orig)
	return var_reverse.dup()
}

struct Class_Text_Exception {
	rt.PhpObjectBase
}

fn create_text_diff(arg_0 rt.PhpVal, arg_1 rt.PhpVal) &Class_Text_Diff {
	mut obj := &Class_Text_Diff{
		PhpObjectBase: rt.PhpObjectBase{}
		_edits: rt.new_null()
	}
	obj.construct(arg_0, arg_1)
	return obj
}

fn create_text_mappeddiff(arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal, arg_3 rt.PhpVal) &Class_Text_MappedDiff {
	mut obj := &Class_Text_MappedDiff{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	obj.construct(arg_0, arg_1, arg_2, arg_3)
	return obj
}

fn create_text_diff_op() &Class_Text_Diff_Op {
	mut obj := &Class_Text_Diff_Op{
		PhpObjectBase: rt.PhpObjectBase{}
		orig: rt.new_null()
		final: rt.new_null()
	}
	return obj
}

fn create_text_diff_op_copy(final bool, arg_1 rt.PhpVal) &Class_Text_Diff_Op_copy {
	mut obj := &Class_Text_Diff_Op_copy{
		Class_Text_Diff_Op: Class_Text_Diff_Op{
			PhpObjectBase: rt.PhpObjectBase{}
			orig: rt.new_null()
			final: rt.new_null()
		}
	}
	obj.construct(final, arg_1)
	return obj
}

fn create_text_diff_op_delete(arg_0 rt.PhpVal) &Class_Text_Diff_Op_delete {
	mut obj := &Class_Text_Diff_Op_delete{
		Class_Text_Diff_Op: Class_Text_Diff_Op{
			PhpObjectBase: rt.PhpObjectBase{}
			orig: rt.new_null()
			final: rt.new_null()
		}
	}
	obj.construct(arg_0)
	return obj
}

fn create_text_diff_op_add(arg_0 rt.PhpVal) &Class_Text_Diff_Op_add {
	mut obj := &Class_Text_Diff_Op_add{
		Class_Text_Diff_Op: Class_Text_Diff_Op{
			PhpObjectBase: rt.PhpObjectBase{}
			orig: rt.new_null()
			final: rt.new_null()
		}
	}
	obj.construct(arg_0)
	return obj
}

fn create_text_diff_op_change(arg_0 rt.PhpVal, arg_1 rt.PhpVal) &Class_Text_Diff_Op_change {
	mut obj := &Class_Text_Diff_Op_change{
		Class_Text_Diff_Op: Class_Text_Diff_Op{
			PhpObjectBase: rt.PhpObjectBase{}
			orig: rt.new_null()
			final: rt.new_null()
		}
	}
	obj.construct(arg_0, arg_1)
	return obj
}

fn create_text_exception() &Class_Text_Exception {
	mut obj := &Class_Text_Exception{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Text_Diff) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.construct(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'Text_Diff' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.text_diff(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'getDiff' {
			return this.getdiff()
		}
		'countAddedLines' {
			return this.countaddedlines()
		}
		'countDeletedLines' {
			return this.countdeletedlines()
		}
		'reverse' {
			return this.reverse()
		}
		'isEmpty' {
			return rt.new_bool(this.isempty())
		}
		'lcs' {
			return this.lcs()
		}
		'getOriginal' {
			return this.getoriginal()
		}
		'getFinal' {
			return this.getfinal()
		}
		'trimNewlines' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			Class_Text_Diff.trimnewlines(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'_getTempDir' {
			return Class_Text_Diff._gettempdir()
		}
		'_check' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(this._check(dispatch_arg_0, dispatch_arg_1))
		}
		else { return none }
	}
}

fn (this &Class_Text_Diff) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'_edits' { return this._edits }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Text_Diff) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'_edits' { this._edits = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Text_MappedDiff) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			this.construct(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
			return rt.new_null()
		}
		'Text_MappedDiff' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			this.text_mappeddiff(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_Text_MappedDiff) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Text_MappedDiff) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Text_Diff_Op) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'reverse' {
			this.reverse()
			return rt.new_null()
		}
		'norig' {
			return rt.new_int(this.norig())
		}
		'nfinal' {
			return rt.new_int(this.nfinal())
		}
		else { return none }
	}
}

fn (this &Class_Text_Diff_Op) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'orig' { return this.orig }
		'final' { return this.final }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Text_Diff_Op) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'orig' { this.orig = val; return true }
		'final' { this.final = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Text_Diff_Op_copy) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			this.construct(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'Text_Diff_Op_copy' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			this.text_diff_op_copy(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'reverse' {
			this.reverse()
			return rt.new_null()
		}
		'norig' {
			return rt.new_int(this.norig())
		}
		'nfinal' {
			return rt.new_int(this.nfinal())
		}
		else { return none }
	}
}

fn (this &Class_Text_Diff_Op_copy) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'orig' { return this.Class_Text_Diff_Op.orig }
		'final' { return this.Class_Text_Diff_Op.final }
		else { return this.Class_Text_Diff_Op.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Text_Diff_Op_copy) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'orig' { this.Class_Text_Diff_Op.orig = val; return true }
		'final' { this.Class_Text_Diff_Op.final = val; return true }
		else { return this.Class_Text_Diff_Op.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Text_Diff_Op_delete) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'Text_Diff_Op_delete' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.text_diff_op_delete(dispatch_arg_0)
			return rt.new_null()
		}
		'reverse' {
			this.reverse()
			return rt.new_null()
		}
		'norig' {
			return rt.new_int(this.norig())
		}
		'nfinal' {
			return rt.new_int(this.nfinal())
		}
		else { return none }
	}
}

fn (this &Class_Text_Diff_Op_delete) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'orig' { return this.Class_Text_Diff_Op.orig }
		'final' { return rt.new_bool(this.Class_Text_Diff_Op.final) }
		else { return this.Class_Text_Diff_Op.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Text_Diff_Op_delete) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'orig' { this.Class_Text_Diff_Op.orig = val; return true }
		'final' { this.Class_Text_Diff_Op.final = (val).to_bool(); return true }
		else { return this.Class_Text_Diff_Op.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Text_Diff_Op_add) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'Text_Diff_Op_add' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.text_diff_op_add(dispatch_arg_0)
			return rt.new_null()
		}
		'reverse' {
			this.reverse()
			return rt.new_null()
		}
		'norig' {
			return rt.new_int(this.norig())
		}
		'nfinal' {
			return rt.new_int(this.nfinal())
		}
		else { return none }
	}
}

fn (this &Class_Text_Diff_Op_add) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'orig' { return rt.new_bool(this.Class_Text_Diff_Op.orig) }
		'final' { return this.Class_Text_Diff_Op.final }
		else { return this.Class_Text_Diff_Op.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Text_Diff_Op_add) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'orig' { this.Class_Text_Diff_Op.orig = (val).to_bool(); return true }
		'final' { this.Class_Text_Diff_Op.final = val; return true }
		else { return this.Class_Text_Diff_Op.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Text_Diff_Op_change) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.construct(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'Text_Diff_Op_change' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.text_diff_op_change(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'reverse' {
			this.reverse()
			return rt.new_null()
		}
		'norig' {
			return rt.new_int(this.norig())
		}
		'nfinal' {
			return rt.new_int(this.nfinal())
		}
		else { return none }
	}
}

fn (this &Class_Text_Diff_Op_change) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'orig' { return this.Class_Text_Diff_Op.orig }
		'final' { return this.Class_Text_Diff_Op.final }
		else { return this.Class_Text_Diff_Op.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Text_Diff_Op_change) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'orig' { this.Class_Text_Diff_Op.orig = val; return true }
		'final' { this.Class_Text_Diff_Op.final = val; return true }
		else { return this.Class_Text_Diff_Op.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Text_Exception) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Text_Exception) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Text_Exception) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn init_registry() {
	rt.register_class_factory('Text_Diff', fn(args []rt.PhpVal) rt.PhpVal {
		c_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		c_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		obj := create_text_diff(c_arg_0, c_arg_1)
		return rt.new_object('Text_Diff', []string{}, obj)
	})
	rt.register_class_factory('Text_MappedDiff', fn(args []rt.PhpVal) rt.PhpVal {
		c_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		c_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		c_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
		c_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
		obj := create_text_mappeddiff(c_arg_0, c_arg_1, c_arg_2, c_arg_3)
		return rt.new_object('Text_MappedDiff', ['Text_Diff'], obj)
	})
	rt.register_class_factory('Text_Diff_Op', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_text_diff_op()
		return rt.new_object('Text_Diff_Op', []string{}, obj)
	})
	rt.register_class_factory('Text_Diff_Op_copy', fn(args []rt.PhpVal) rt.PhpVal {
		c_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
		c_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		obj := create_text_diff_op_copy(c_arg_0, c_arg_1)
		return rt.new_object('Text_Diff_Op_copy', ['Text_Diff_Op'], obj)
	})
	rt.register_class_factory('Text_Diff_Op_delete', fn(args []rt.PhpVal) rt.PhpVal {
		c_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		obj := create_text_diff_op_delete(c_arg_0)
		return rt.new_object('Text_Diff_Op_delete', ['Text_Diff_Op'], obj)
	})
	rt.register_class_factory('Text_Diff_Op_add', fn(args []rt.PhpVal) rt.PhpVal {
		c_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		obj := create_text_diff_op_add(c_arg_0)
		return rt.new_object('Text_Diff_Op_add', ['Text_Diff_Op'], obj)
	})
	rt.register_class_factory('Text_Diff_Op_change', fn(args []rt.PhpVal) rt.PhpVal {
		c_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		c_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		obj := create_text_diff_op_change(c_arg_0, c_arg_1)
		return rt.new_object('Text_Diff_Op_change', ['Text_Diff_Op'], obj)
	})
	rt.register_class_factory('Text_Exception', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_text_exception()
		return rt.new_object('Text_Exception', []string{}, obj)
	})
}

fn init() {
	init_registry()
}



pub fn init_wp_includes_text_diff_php() {
}
