import rt
import crypto.md5

struct Class_WP_Text_Diff_Renderer_Table {
	rt.PhpObjectBase
pub mut:
		_leading_context_lines rt.PhpVal = rt.new_int(10000)
		_trailing_context_lines rt.PhpVal = rt.new_int(10000)
		_title rt.PhpVal = rt.new_null()
		_title_left rt.PhpVal = rt.new_null()
		_title_right rt.PhpVal = rt.new_null()
		_diff_threshold rt.PhpVal = rt.new_float(0.6)
		inline_diff_renderer rt.PhpVal = rt.new_string('WP_Text_Diff_Renderer_inline')
		_show_split_view rt.PhpVal = rt.new_bool(true)
		compat_fields rt.PhpVal = rt.new_array()
		count_cache rt.PhpVal = rt.new_array()
		difference_cache rt.PhpVal = rt.new_array()
}

fn (mut this Class_WP_Text_Diff_Renderer_Table) construct(var_params rt.PhpVal)  {
	this.Class_Text_Diff_Renderer.construct(var_params.dup())
	if var_params.array_isset(rt.new_string('show_split_view')) {
		this._show_split_view = var_params.array_get('show_split_view')
	}
}

fn (mut this Class_WP_Text_Diff_Renderer_Table) _startblock(var_header rt.PhpVal) string {
	return ''
}

fn (mut this Class_WP_Text_Diff_Renderer_Table) _lines(var_lines rt.PhpVal, prefix string)  {
}

fn (mut this Class_WP_Text_Diff_Renderer_Table) addedline(var_line rt.PhpVal) string {
	mut var_line_mutated := var_line
	return '<td class=\'diff-addedline\'><span aria-hidden=\'true\' class=\'dashicons dashicons-plus\'></span><span class=\'screen-reader-text\'>' + (rt.call_function('__', [rt.new_string('Added:')])).str() + " </span>${var_line.to_string()}</td>"
}

fn (mut this Class_WP_Text_Diff_Renderer_Table) deletedline(var_line rt.PhpVal) string {
	mut var_line_mutated := var_line
	return '<td class=\'diff-deletedline\'><span aria-hidden=\'true\' class=\'dashicons dashicons-minus\'></span><span class=\'screen-reader-text\'>' + (rt.call_function('__', [rt.new_string('Deleted:')])).str() + " </span>${var_line.to_string()}</td>"
}

fn (mut this Class_WP_Text_Diff_Renderer_Table) contextline(var_line rt.PhpVal) string {
	mut var_line_mutated := var_line
	return '<td class=\'diff-context\'><span class=\'screen-reader-text\'>' + (rt.call_function('__', [rt.new_string('Unchanged:')])).str() + " </span>${var_line.to_string()}</td>"
}

fn (mut this Class_WP_Text_Diff_Renderer_Table) emptyline() string {
	return '<td>&nbsp;</td>'
}

fn (mut this Class_WP_Text_Diff_Renderer_Table) _added(var_lines rt.PhpVal, encode bool) rt.PhpVal {
	mut var_r := rt.new_string(rt.new_string(''))
	{
		mut iter_1 := var_lines.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_line := item_1.val
			if var_encode {
				mut var_processed_line := rt.call_function('htmlspecialchars', [var_line.dup()])
				var_line = rt.call_function('apply_filters', [rt.new_string('process_text_diff_html'), var_processed_line.dup(), var_line.dup(), rt.new_string('added')])
			}
			if rt.is_true(this._show_split_view) {
				// unsupported expression: Expr_AssignOp_Concat
			} else {
				// unsupported expression: Expr_AssignOp_Concat
			}
		}
	}
	return var_r.dup()
}

fn (mut this Class_WP_Text_Diff_Renderer_Table) _deleted(var_lines rt.PhpVal, encode bool) rt.PhpVal {
	mut var_r := rt.new_string(rt.new_string(''))
	{
		mut iter_1 := var_lines.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_line := item_1.val
			if var_encode {
				mut var_processed_line := rt.call_function('htmlspecialchars', [var_line.dup()])
				var_line = rt.call_function('apply_filters', [rt.new_string('process_text_diff_html'), var_processed_line.dup(), var_line.dup(), rt.new_string('deleted')])
			}
			if rt.is_true(this._show_split_view) {
				// unsupported expression: Expr_AssignOp_Concat
			} else {
				// unsupported expression: Expr_AssignOp_Concat
			}
		}
	}
	return var_r.dup()
}

fn (mut this Class_WP_Text_Diff_Renderer_Table) _context(var_lines rt.PhpVal, encode bool) rt.PhpVal {
	mut var_r := rt.new_string(rt.new_string(''))
	{
		mut iter_1 := var_lines.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_line := item_1.val
			if var_encode {
				mut var_processed_line := rt.call_function('htmlspecialchars', [var_line.dup()])
				var_line = rt.call_function('apply_filters', [rt.new_string('process_text_diff_html'), var_processed_line.dup(), var_line.dup(), rt.new_string('unchanged')])
			}
			if rt.is_true(this._show_split_view) {
				// unsupported expression: Expr_AssignOp_Concat
			} else {
				// unsupported expression: Expr_AssignOp_Concat
			}
		}
	}
	return var_r.dup()
}

fn (mut this Class_WP_Text_Diff_Renderer_Table) _changed(var_orig rt.PhpVal, var_final rt.PhpVal) rt.PhpVal {
	mut var_orig_matches := rt.new_null()
	mut var_final_matches := rt.new_null()
	mut var_orig_rows := rt.new_null()
	mut var_final_rows := rt.new_null()
	mut var_diff_matches := []rt.PhpVal{}
	mut var_r := rt.new_string(rt.new_string(''))
	// unsupported assign target: Expr_List
	mut var_orig_diffs := rt.new_array()
	mut var_final_diffs := rt.new_array()
	{
		mut iter_1 := var_orig_matches.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_f := item_1.val
			mut var_o := item_1.key
			if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_o.dup().is_long() || var_o.dup().is_double())) && rt.is_true(rt.new_bool(var_f.dup().is_long() || var_f.dup().is_double())))) {
				mut var_text_diff := create_text_diff(rt.new_string('auto'), rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: none, val: var_orig.array_get(var_o) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: none, val: var_final.array_get(var_f) }]) }]))
				mut var_renderer := rt.create_object_dynamically(this.inline_diff_renderer, []rt.PhpVal{})
				mut var_diff := rt.call_method(var_renderer, 'render', [var_text_diff])
				if rt.is_true(rt.call_function('preg_match_all', [rt.new_string('!(<ins>.*?</ins>|<del>.*?</del>)!'), var_diff.dup(), var_diff_matches.dup()])) {
					mut var_stripped_matches := rt.new_int(rt.new_int(rt.call_function('strip_tags', [rt.call_function('implode', [rt.new_string(' '), var_diff_matches.array_get(0)])]).to_string().len))
					mut var_stripped_diff := rt.sub(rt.call_function('strip_tags', [var_diff.dup()]).to_string().len * 2, var_stripped_matches)
					mut var_diff_ratio := rt.div(var_stripped_matches, var_stripped_diff)
					if rt.is_true(rt.greater(var_diff_ratio, this._diff_threshold)) {
						continue
						// unsupported statement: Stmt_Nop
					}
				}
				var_orig_diffs.array_set(var_o, rt.call_function('preg_replace', [rt.new_string('|<ins>.*?</ins>|'), rt.new_string(''), var_diff.dup()]))
				var_final_diffs.array_set(var_f, rt.call_function('preg_replace', [rt.new_string('|<del>.*?</del>|'), rt.new_string(''), var_diff.dup()]))
			}
		}
	}
	{
		mut iter_1 := rt.func_array_keys(var_orig_rows.dup()).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_row := item_1.val
			if rt.is_true(rt.new_bool(rt.is_true(rt.less(var_orig_rows.array_get(var_row), rt.new_int(0))) && rt.is_true(rt.less(var_final_rows.array_get(var_row), rt.new_int(0))))) {
				continue
			}
			if var_orig_diffs.array_isset(var_orig_rows.array_get(var_row)) {
				mut var_orig_line := var_orig_diffs.array_get(var_orig_rows.array_get(var_row))
			} else if var_orig.array_isset(var_orig_rows.array_get(var_row)) {
				var_orig_line = rt.call_function('htmlspecialchars', [var_orig.array_get(var_orig_rows.array_get(var_row))])
			} else {
				var_orig_line = rt.new_string(rt.new_string(''))
			}
			if var_final_diffs.array_isset(var_final_rows.array_get(var_row)) {
				mut var_final_line := var_final_diffs.array_get(var_final_rows.array_get(var_row))
			} else if var_final.array_isset(var_final_rows.array_get(var_row)) {
				var_final_line = rt.call_function('htmlspecialchars', [var_final.array_get(var_final_rows.array_get(var_row))])
			} else {
				var_final_line = rt.new_string(rt.new_string(''))
			}
			if rt.is_true(rt.less(var_orig_rows.array_get(var_row), rt.new_int(0))) {
				// unsupported expression: Expr_AssignOp_Concat
			} else if rt.is_true(rt.less(var_final_rows.array_get(var_row), rt.new_int(0))) {
				// unsupported expression: Expr_AssignOp_Concat
			} else {
				if rt.is_true(this._show_split_view) {
					// unsupported expression: Expr_AssignOp_Concat
				} else {
					// unsupported expression: Expr_AssignOp_Concat
				}
			}
		}
	}
	return var_r.dup()
}

fn (mut this Class_WP_Text_Diff_Renderer_Table) interleave_changed_lines(var_orig rt.PhpVal, var_final rt.PhpVal) rt.PhpVal {
	mut var_matches := rt.new_array()
	{
		mut iter_1 := rt.func_array_keys(var_orig.dup()).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_o := item_1.val
			{
				mut iter_2 := rt.func_array_keys(var_final.dup()).iterator()
				for {
					item_2 := iter_2.next() or { break }
					mut var_f := item_2.val
					var_matches["${var_o.to_string()},${var_f.to_string()}"] = this.compute_string_distance(var_orig.array_get(var_o), var_final.array_get(var_f))
				}
			}
		}
	}
	rt.call_function('asort', [var_matches.dup()])
	mut var_orig_matches := rt.new_array()
	mut var_final_matches := rt.new_array()
	for var_keys, var_difference in var_matches {
		// unsupported assign target: Expr_List
		mut var_o := // unsupported expression: Expr_Cast_Int
		mut var_f := // unsupported expression: Expr_Cast_Int
		if var_orig_matches.array_isset(var_o) && var_final_matches.array_isset(var_f) {
			continue
		}
		if !(var_orig_matches.array_isset(var_o)) && !(var_final_matches.array_isset(var_f)) {
			var_orig_matches.array_set(var_o, var_f.dup())
			var_final_matches.array_set(var_f, var_o.dup())
			continue
		}
		if var_orig_matches.array_isset(var_o) {
			var_final_matches.array_set(var_f, 'x')
		} else if var_final_matches.array_isset(var_f) {
			var_orig_matches.array_set(var_o, 'x')
		}
	}
	rt.call_function('ksort', [var_orig_matches.dup()])
	rt.call_function('ksort', [var_final_matches.dup()])
	mut var_orig_rows := rt.func_array_keys(var_orig_matches.dup())
	mut var_orig_rows_copy := var_orig_rows.dup()
	mut var_final_rows := rt.func_array_keys(var_final_matches.dup())
	{
		mut iter_1 := var_orig_rows_copy.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_orig_row := item_1.val
			mut var_final_pos := rt.call_function('array_search', [var_orig_matches.array_get(var_orig_row), var_final_rows.dup(), rt.new_bool(true)])
			mut var_orig_pos := // unsupported expression: Expr_Cast_Int
			if rt.is_true(rt.identical(rt.new_bool(false), var_final_pos)) {
				rt.call_function('array_splice', [var_final_rows.dup(), var_orig_pos.dup(), rt.new_int(0), // unsupported expression: Expr_UnaryMinus])
			} else if rt.is_true(rt.less(var_final_pos, var_orig_pos)) {
				mut var_diff_array := rt.call_function('range', [// unsupported expression: Expr_UnaryMinus, rt.sub(var_final_pos, var_orig_pos)])
				rt.call_function('array_splice', [var_final_rows.dup(), var_orig_pos.dup(), rt.new_int(0), var_diff_array.dup()])
			} else if rt.is_true(rt.greater(var_final_pos, var_orig_pos)) {
				var_diff_array = rt.call_function('range', [// unsupported expression: Expr_UnaryMinus, rt.sub(var_orig_pos, var_final_pos)])
				rt.call_function('array_splice', [var_orig_rows.dup(), var_orig_pos.dup(), rt.new_int(0), var_diff_array.dup()])
			}
		}
	}
	mut var_diff_count := rt.new_int(var_orig_rows.dup().array_count() - var_final_rows.dup().array_count())
	if rt.is_true(rt.less(var_diff_count, rt.new_int(0))) {
		for rt.is_true(rt.less(var_diff_count, rt.new_int(0))) {
			var_orig_rows.dup().array_push(rt.post_inc(var_diff_count))
		}
	} else if rt.is_true(rt.greater(var_diff_count, rt.new_int(0))) {
		var_diff_count = rt.mul(// unsupported expression: Expr_UnaryMinus, var_diff_count)
		for rt.is_true(rt.less(var_diff_count, rt.new_int(0))) {
			var_final_rows.dup().array_push(rt.post_inc(var_diff_count))
		}
	}
	return rt.create_array([rt.ArrayItem{ key: none, val: var_orig_matches }, rt.ArrayItem{ key: none, val: var_final_matches }, rt.ArrayItem{ key: none, val: var_orig_rows }, rt.ArrayItem{ key: none, val: var_final_rows }])
}

fn (mut this Class_WP_Text_Diff_Renderer_Table) compute_string_distance(var_string1 rt.PhpVal, var_string2 rt.PhpVal) rt.PhpVal {
	mut var_count_key1 := rt.new_string(rt.new_string(md5.hexhash(var_string1.dup().to_string())))
	mut var_count_key2 := rt.new_string(rt.new_string(md5.hexhash(var_string2.dup().to_string())))
	if !(this.count_cache.array_isset(var_count_key1)) {
		.array_set(, )
	}
	if !(this.count_cache.array_isset(var_count_key2)) {
		
	}
	
}

fn (mut this Class_WP_Text_Diff_Renderer_Table) difference(var_a rt.PhpVal, var_b rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_WP_Text_Diff_Renderer_Table) magic_get(var_name rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_WP_Text_Diff_Renderer_Table) magic_set(var_name rt.PhpVal, var_value rt.PhpVal)  {
}

fn (mut this Class_WP_Text_Diff_Renderer_Table) magic_isset(var_name rt.PhpVal) bool {
}

fn (mut this Class_WP_Text_Diff_Renderer_Table) magic_unset(var_name rt.PhpVal)  {
}

struct Class_Text_Diff_Renderer {
	rt.PhpObjectBase
}

struct Class_Text_Diff {
	rt.PhpObjectBase
}

fn create_wp_text_diff_renderer_table(arg_0 rt.PhpVal) &Class_WP_Text_Diff_Renderer_Table {
	mut obj := &Class_WP_Text_Diff_Renderer_Table{
		PhpObjectBase: rt.PhpObjectBase{}
		_leading_context_lines: rt.new_int(10000)
		_trailing_context_lines: rt.new_int(10000)
		_title: rt.new_null()
		_title_left: rt.new_null()
		_title_right: rt.new_null()
		_diff_threshold: rt.new_float(0.6)
		inline_diff_renderer: rt.new_string('WP_Text_Diff_Renderer_inline')
		_show_split_view: rt.new_bool(true)
		compat_fields: rt.new_array()
		count_cache: rt.new_array()
		difference_cache: rt.new_array()
	}
	obj.construct(arg_0)
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

fn (mut this Class_WP_Text_Diff_Renderer_Table) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'_startBlock' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this._startblock(dispatch_arg_0))
		}
		'_lines' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			this._lines(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'addedLine' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.addedline(dispatch_arg_0))
		}
		'deletedLine' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.deletedline(dispatch_arg_0))
		}
		'contextLine' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.contextline(dispatch_arg_0))
		}
		'emptyLine' {
			return rt.new_string(this.emptyline())
		}
		'_added' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			return this._added(dispatch_arg_0, dispatch_arg_1)
		}
		'_deleted' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			return this._deleted(dispatch_arg_0, dispatch_arg_1)
		}
		'_context' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			return this._context(dispatch_arg_0, dispatch_arg_1)
		}
		'_changed' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this._changed(dispatch_arg_0, dispatch_arg_1)
		}
		'interleave_changed_lines' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.interleave_changed_lines(dispatch_arg_0, dispatch_arg_1)
		}
		'compute_string_distance' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.compute_string_distance(dispatch_arg_0, dispatch_arg_1)
		}
		'difference' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.difference(dispatch_arg_0, dispatch_arg_1)
		}
		'__get' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.magic_get(dispatch_arg_0)
		}
		'__set' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.magic_set(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'__isset' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.magic_isset(dispatch_arg_0))
		}
		'__unset' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.magic_unset(dispatch_arg_0)
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_WP_Text_Diff_Renderer_Table) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'_leading_context_lines' { return this._leading_context_lines }
		'_trailing_context_lines' { return this._trailing_context_lines }
		'_title' { return this._title }
		'_title_left' { return this._title_left }
		'_title_right' { return this._title_right }
		'_diff_threshold' { return this._diff_threshold }
		'inline_diff_renderer' { return this.inline_diff_renderer }
		'_show_split_view' { return this._show_split_view }
		'compat_fields' { return this.compat_fields }
		'count_cache' { return this.count_cache }
		'difference_cache' { return this.difference_cache }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_Text_Diff_Renderer_Table) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'_leading_context_lines' { this._leading_context_lines = val; return true }
		'_trailing_context_lines' { this._trailing_context_lines = val; return true }
		'_title' { this._title = val; return true }
		'_title_left' { this._title_left = val; return true }
		'_title_right' { this._title_right = val; return true }
		'_diff_threshold' { this._diff_threshold = val; return true }
		'inline_diff_renderer' { this.inline_diff_renderer = val; return true }
		'_show_split_view' { this._show_split_view = val; return true }
		'compat_fields' { this.compat_fields = val; return true }
		'count_cache' { this.count_cache = val; return true }
		'difference_cache' { this.difference_cache = val; return true }
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


fn init_registry() {
	rt.register_class_factory('WP_Text_Diff_Renderer_Table', fn(args []rt.PhpVal) rt.PhpVal {
		c_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		obj := create_wp_text_diff_renderer_table(c_arg_0)
		return rt.new_object('WP_Text_Diff_Renderer_Table', ['Text_Diff_Renderer'], obj)
	})
	rt.register_class_factory('Text_Diff_Renderer', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_text_diff_renderer()
		return rt.new_object('Text_Diff_Renderer', []string{}, obj)
	})
	rt.register_class_factory('Text_Diff', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_text_diff()
		return rt.new_object('Text_Diff', []string{}, obj)
	})
}

fn init() {
	init_registry()
}



pub fn init_wp_includes_class_wp_text_diff_renderer_table_php() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))))) {
		// unsupported expression: Expr_Exit
	}
}
