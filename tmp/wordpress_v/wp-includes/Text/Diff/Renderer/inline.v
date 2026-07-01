import rt

struct Class_Text_Diff_Renderer_inline {
	rt.PhpObjectBase
pub mut:
		_leading_context_lines rt.PhpVal = rt.new_int(10000)
		_trailing_context_lines rt.PhpVal = rt.new_int(10000)
		_ins_prefix rt.PhpVal = rt.new_string('<ins>')
		_ins_suffix rt.PhpVal = rt.new_string('</ins>')
		_del_prefix rt.PhpVal = rt.new_string('<del>')
		_del_suffix rt.PhpVal = rt.new_string('</del>')
		_block_header rt.PhpVal = rt.new_string('')
		_split_characters rt.PhpVal = rt.new_bool(false)
		_split_level rt.PhpVal = rt.new_string('lines')
}

fn (mut this Class_Text_Diff_Renderer_inline) _blockheader(var_xbeg rt.PhpVal, var_xlen rt.PhpVal, var_ybeg rt.PhpVal, var_ylen rt.PhpVal) rt.PhpVal {
	return this._block_header
}

fn (mut this Class_Text_Diff_Renderer_inline) _startblock(var_header rt.PhpVal) rt.PhpVal {
	return var_header.dup()
}

fn (mut this Class_Text_Diff_Renderer_inline) _lines(var_lines rt.PhpVal, prefix string, encode bool) string {
	mut var_lines_mutated := var_lines
	mut prefix_mutated := prefix
	if var_encode {
		rt.call_function('array_walk', [var_lines_mutated.dup(), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Text_Diff_Renderer_inline', ['Text_Diff_Renderer'], &this) }, rt.ArrayItem{ key: none, val: '_encode' }])])
	}
	if rt.is_true(rt.equal(this._split_level, rt.new_string('lines'))) {
		return (rt.call_function('implode', [rt.new_string('\n'), var_lines_mutated.dup()])).str() + '\n'
	} else {
		return (rt.call_function('implode', [rt.new_string(''), var_lines_mutated.dup()])).str()
	}
	return ''
}

fn (mut this Class_Text_Diff_Renderer_inline) _added(var_lines rt.PhpVal) rt.PhpVal {
	mut var_lines_mutated := var_lines
	rt.call_function('array_walk', [var_lines_mutated.dup(), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Text_Diff_Renderer_inline', ['Text_Diff_Renderer'], &this) }, rt.ArrayItem{ key: none, val: '_encode' }])])
	var_lines_mutated.array_set(0, (this._ins_prefix).str() + (var_lines_mutated.array_get(0)).str())
	// unsupported expression: Expr_AssignOp_Concat
	return rt.new_string(this._lines(var_lines_mutated.dup(), ' ', false))
}

fn (mut this Class_Text_Diff_Renderer_inline) _deleted(var_lines rt.PhpVal, words bool) rt.PhpVal {
	mut var_lines_mutated := var_lines
	mut words_mutated := words
	rt.call_function('array_walk', [var_lines_mutated.dup(), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Text_Diff_Renderer_inline', ['Text_Diff_Renderer'], &this) }, rt.ArrayItem{ key: none, val: '_encode' }])])
	var_lines_mutated.array_set(0, (this._del_prefix).str() + (var_lines_mutated.array_get(0)).str())
	// unsupported expression: Expr_AssignOp_Concat
	return rt.new_string(this._lines(var_lines_mutated.dup(), ' ', false))
}

fn (mut this Class_Text_Diff_Renderer_inline) _changed(var_orig rt.PhpVal, var_final rt.PhpVal) string {
	mut var_orig_mutated := var_orig
	mut var_final_mutated := var_final
	if rt.is_true(rt.equal(this._split_level, rt.new_string('characters'))) {
		return (this._deleted(var_orig_mutated.dup(), false)).str() + (this._added(var_final_mutated.dup())).str()
	}
	if rt.is_true(rt.equal(this._split_level, rt.new_string('words'))) {
		mut var_prefix := rt.new_string(rt.new_string(''))
		for rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) && rt.is_true(rt.equal(rt.call_function('substr', [var_orig_mutated.array_get(0), rt.new_int(0), rt.new_int(1)]), rt.new_string(' '))))) && rt.is_true(rt.equal(rt.call_function('substr', [var_final_mutated.array_get(0), rt.new_int(0), rt.new_int(1)]), rt.new_string(' '))))) {
			// unsupported expression: Expr_AssignOp_Concat
			var_orig_mutated.array_set(0, rt.call_function('substr', [var_orig_mutated.array_get(0), rt.new_int(1)]))
			var_final_mutated.array_set(0, rt.call_function('substr', [var_final_mutated.array_get(0), rt.new_int(1)]))
		}
		return (var_prefix).str() + (this._deleted(var_orig_mutated.dup(), false)).str() + (this._added(var_final_mutated.dup())).str()
	}
	mut var_text1 := rt.call_function('implode', [rt.new_string('\n'), var_orig_mutated.dup()])
	mut var_text2 := rt.call_function('implode', [rt.new_string('\n'), var_final_mutated.dup()])
	mut var_nl := rt.new_string(rt.new_string(''))
	if rt.is_true(this._split_characters) {
		mut var_diff := create_text_diff(rt.new_string('native'), rt.create_array([rt.ArrayItem{ key: none, val: rt.call_function('preg_split', [rt.new_string('//'), var_text1.dup()]) }, rt.ArrayItem{ key: none, val: rt.call_function('preg_split', [rt.new_string('//'), var_text2.dup()]) }]))
	} else {
		var_diff = create_text_diff(rt.new_string('native'), rt.create_array([rt.ArrayItem{ key: none, val: this._splitonwords(var_text1.dup(), (var_nl).str()) }, rt.ArrayItem{ key: none, val: this._splitonwords(var_text2.dup(), (var_nl).str()) }]))
	}
	mut var_renderer := create_text_diff_renderer_inline(rt.call_function('array_merge', [this.getparams(), rt.create_array([rt.ArrayItem{ key: 'split_level', val: if rt.is_true(this._split_characters) { 'characters' } else { 'words' } }])]))
	return (rt.call_function('str_replace', [var_nl.dup(), rt.new_string('\n'), var_renderer.render(rt.new_object('Text_Diff', []string{}, var_diff))])).str() + '\n'
}

fn (mut this Class_Text_Diff_Renderer_inline) _splitonwords(var_string rt.PhpVal, newlineEscape string) rt.PhpVal {
	mut var_string_mutated := var_string
	var_string_mutated = rt.call_function('str_replace', [rt.new_string(''), rt.new_string(''), var_string_mutated.dup()])
	mut var_words := []rt.PhpVal{}
	mut var_length := rt.new_int(rt.new_int(var_string_mutated.dup().to_string().len))
	mut var_pos := rt.new_int(rt.new_int(0))
	for rt.is_true(rt.less(var_pos, var_length)) {
		mut var_spaces := rt.call_function('strspn', [rt.call_function('substr', [var_string_mutated.dup(), var_pos.dup()]), rt.new_string(' \n')])
		mut var_nextpos := rt.call_function('strcspn', [rt.call_function('substr', [var_string_mutated.dup(), rt.add(var_pos, var_spaces)]), rt.new_string(' \n')])
		var_words << rt.call_function('str_replace', [rt.new_string('\n'), rt.new_string(newlineEscape), rt.call_function('substr', [var_string_mutated.dup(), var_pos.dup(), rt.add(var_spaces, var_nextpos)])])
		// unsupported expression: Expr_AssignOp_Plus
	}
	return var_words.dup()
}

fn (mut this Class_Text_Diff_Renderer_inline) _encode(var_string rt.PhpVal)  {
	mut var_string_mutated := var_string
	var_string_mutated = rt.call_function('htmlspecialchars', [var_string_mutated.dup()])
}

struct Class_Text_Diff_Renderer {
	rt.PhpObjectBase
}

struct Class_Text_Diff {
	rt.PhpObjectBase
}

fn create_text_diff_renderer_inline() &Class_Text_Diff_Renderer_inline {
	mut obj := &Class_Text_Diff_Renderer_inline{
		PhpObjectBase: rt.PhpObjectBase{}
		_leading_context_lines: rt.new_int(10000)
		_trailing_context_lines: rt.new_int(10000)
		_ins_prefix: rt.new_string('<ins>')
		_ins_suffix: rt.new_string('</ins>')
		_del_prefix: rt.new_string('<del>')
		_del_suffix: rt.new_string('</del>')
		_block_header: rt.new_string('')
		_split_characters: rt.new_bool(false)
		_split_level: rt.new_string('lines')
	}
	return obj
}

fn create_text_diff_renderer() &Class_Text_Diff_Renderer {
	mut obj := &Class_Text_Diff_Renderer{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_text_diff() &Class_Text_Diff {
	mut obj := &Class_Text_Diff{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Text_Diff_Renderer_inline) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'_blockHeader' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			return this._blockheader(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
		}
		'_startBlock' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this._startblock(dispatch_arg_0)
		}
		'_lines' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
			return rt.new_string(this._lines(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2))
		}
		'_added' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this._added(dispatch_arg_0)
		}
		'_deleted' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			return this._deleted(dispatch_arg_0, dispatch_arg_1)
		}
		'_changed' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_string(this._changed(dispatch_arg_0, dispatch_arg_1))
		}
		'_splitOnWords' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return this._splitonwords(dispatch_arg_0, dispatch_arg_1)
		}
		'_encode' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this._encode(dispatch_arg_0)
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_Text_Diff_Renderer_inline) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'_leading_context_lines' { return this._leading_context_lines }
		'_trailing_context_lines' { return this._trailing_context_lines }
		'_ins_prefix' { return this._ins_prefix }
		'_ins_suffix' { return this._ins_suffix }
		'_del_prefix' { return this._del_prefix }
		'_del_suffix' { return this._del_suffix }
		'_block_header' { return this._block_header }
		'_split_characters' { return this._split_characters }
		'_split_level' { return this._split_level }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Text_Diff_Renderer_inline) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'_leading_context_lines' { this._leading_context_lines = val; return true }
		'_trailing_context_lines' { this._trailing_context_lines = val; return true }
		'_ins_prefix' { this._ins_prefix = val; return true }
		'_ins_suffix' { this._ins_suffix = val; return true }
		'_del_prefix' { this._del_prefix = val; return true }
		'_del_suffix' { this._del_suffix = val; return true }
		'_block_header' { this._block_header = val; return true }
		'_split_characters' { this._split_characters = val; return true }
		'_split_level' { this._split_level = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Text_Diff_Renderer) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Text_Diff_Renderer) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Text_Diff_Renderer) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
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




pub fn init_wp_includes_text_diff_renderer_inline_php() {
	rt.include_file((rt.call_function('dirname', [rt.call_function('dirname', [rt.new_string(@FILE)])])).str() + '/Renderer.php', '4')
}
