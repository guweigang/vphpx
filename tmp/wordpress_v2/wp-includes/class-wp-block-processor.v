import rt

pub fn Class_WP_Block_Processor.closer() string {
	return 'closer'
}
pub fn Class_WP_Block_Processor.opener() string {
	return 'opener'
}
pub fn Class_WP_Block_Processor.void() string {
	return 'void'
}
pub fn Class_WP_Block_Processor.ready() string {
	return 'processor-ready'
}
pub fn Class_WP_Block_Processor.matched() string {
	return 'processor-matched'
}
pub fn Class_WP_Block_Processor.html_span() string {
	return 'processor-html-span'
}
pub fn Class_WP_Block_Processor.incomplete_input() string {
	return 'incomplete-input'
}
pub fn Class_WP_Block_Processor.complete() string {
	return 'processor-complete'
}
struct Class_WP_Block_Processor {
	rt.PhpObjectBase
pub mut:
		last_error rt.PhpVal = rt.new_null()
		last_json_error rt.PhpVal = rt.new_null()
		source_text string
		matched_delimiter_at rt.PhpVal = rt.new_int(0)
		matched_delimiter_length rt.PhpVal = rt.new_int(0)
		after_previous_delimiter rt.PhpVal = rt.new_int(0)
		namespace_at rt.PhpVal = rt.new_int(0)
		name_at rt.PhpVal = rt.new_int(0)
		name_length rt.PhpVal = rt.new_int(0)
		has_closing_flag rt.PhpVal = rt.new_bool(false)
		json_at rt.PhpVal = rt.new_null()
		json_length rt.PhpVal = rt.new_int(0)
		state rt.PhpVal = rt.new_null()
		prop_type rt.PhpVal = rt.new_null()
		was_void bool
		open_blocks_at rt.PhpVal = rt.new_array()
		open_blocks_length rt.PhpVal = rt.new_array()
		next_stack_op rt.PhpVal = rt.new_null()
}

fn (mut this Class_WP_Block_Processor) construct(source_text string) {
	this.source_text = source_text
}

fn (mut this Class_WP_Block_Processor) next_block(mut var_block_type Class_?string) bool {
	mut var_block_type_mutated := var_block_type
	for this.next_delimiter(mut var_block_type_mutated) {
		if rt.is_true(rt.new_bool(Class_WP_Block_Processor.closer() != this.get_delimiter_type())) {
			return true
		}
	}
	return false
}

fn (mut this Class_WP_Block_Processor) next_delimiter(mut var_block_name Class_?string) bool {
	if !(!(var_block_name).is_null()) {
		for this.next_token() {
			if !(this.is_html()) {
				return true
			}
		}
		return false
	}
	for this.next_token() {
		if this.is_block_type(var_block_name) {
			return true
		}
	}
	return false
}

fn (mut this Class_WP_Block_Processor) next_token() bool {
	if rt.is_true(this.last_error) || rt.is_true(rt.identical(Class_WP_Block_Processor.complete(), this.state)) || rt.is_true(rt.identical(Class_WP_Block_Processor.incomplete_input(), this.state)) {
		return false
	}
	if this.was_void {
		rt.call_function('array_pop', [this.open_blocks_at])
		rt.call_function('array_pop', [this.open_blocks_length])
		this.was_void = false
	}
	mut var_text := rt.new_string(this.source_text)
	mut var_end := rt.new_int(var_text.clone().to_string().len)
	if rt.is_true(rt.identical(Class_WP_Block_Processor.html_span(), this.state)) {
		if rt.is_true(rt.greater_equal(this.matched_delimiter_at, var_end)) {
			this.state = Class_WP_Block_Processor.complete()
			return false
		}
		mut switch_val_1 := this.next_stack_op
		if rt.is_true(rt.equal(switch_val_1, rt.new_string('void'))) {
			this.was_void = true
			this.open_blocks_at.array_push(this.namespace_at)
			this.open_blocks_length.array_push(rt.sub(rt.add(this.name_at, this.name_length), this.namespace_at))
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('push'))) {
			this.open_blocks_at.array_push(this.namespace_at)
			this.open_blocks_length.array_push(rt.sub(rt.add(this.name_at, this.name_length), this.namespace_at))
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('pop'))) {
			rt.call_function('array_pop', [this.open_blocks_at])
			rt.call_function('array_pop', [this.open_blocks_length])
		}
		this.next_stack_op = rt.new_null()
		this.state = Class_WP_Block_Processor.matched()
		return true
	}
	this.state = Class_WP_Block_Processor.ready()
	mut var_after_prev_delimiter := rt.add(this.matched_delimiter_at, this.matched_delimiter_length)
	mut var_at := var_after_prev_delimiter.clone()
	for rt.is_true(rt.less(var_at, var_end)) {
		mut var_comment_opening_at := rt.call_function('strpos', [var_text.clone(), rt.new_string('<!--'), var_at.clone()])
		if rt.is_true(rt.identical(rt.new_bool(false), var_comment_opening_at)) {
			if rt.is_true(rt.call_function('str_ends_with', [var_text.clone(), rt.new_string('<!-')])) {
			mut var_backup := rt.new_int(3)
			} else if rt.is_true(rt.call_function('str_ends_with', [var_text.clone(), rt.new_string('<!')])) {
			var_backup = rt.new_int(2)
			} else if rt.is_true(rt.call_function('str_ends_with', [var_text.clone(), rt.new_string('<')])) {
			var_backup = rt.new_int(1)
			} else {
			var_backup = rt.new_int(0)
			}
			if rt.is_true(rt.less(var_after_prev_delimiter, rt.sub(var_end, var_backup))) {
				this.state = Class_WP_Block_Processor.html_span()
				this.after_previous_delimiter = var_after_prev_delimiter.clone()
				this.matched_delimiter_at = rt.sub(var_end, var_backup)
				this.matched_delimiter_length = var_backup.clone()
				this.open_blocks_at.array_push(var_after_prev_delimiter.clone())
				this.open_blocks_length.array_push(0)
				this.was_void = true
				return true
			}
			if rt.is_true(rt.greater(var_backup, rt.new_int(0))) {
				// unsupported statement: Stmt_Goto
			}
			this.state = Class_WP_Block_Processor.complete()
			return false
		}
		mut var_opening_whitespace_at := rt.add(var_comment_opening_at, rt.new_int(4))
		if rt.is_true(rt.greater_equal(var_opening_whitespace_at, var_end)) {
			// unsupported statement: Stmt_Goto
		}
		mut var_opening_whitespace_length := rt.call_function('strspn', [var_text.clone(), rt.new_string(' \t\r\n'), var_opening_whitespace_at.clone()])
		mut var_wp_prefix_at := rt.add(var_opening_whitespace_at, var_opening_whitespace_length)
		if rt.is_true(rt.greater_equal(var_wp_prefix_at, var_end)) {
			// unsupported statement: Stmt_Goto
		}
		if rt.is_true(rt.identical(rt.new_int(0), var_opening_whitespace_length)) {
			var_at = rt.new_int(this.find_html_comment_end((var_comment_opening_at).to_i64(), (var_end).to_i64()))
			continue
		}
		mut var_has_closer := rt.new_bool(false)
		if rt.is_true(rt.identical(rt.new_string('/'), var_text.array_get(var_wp_prefix_at))) {
			var_has_closer = rt.new_bool(true)
			rt.pre_inc(var_wp_prefix_at)
		}
		if rt.is_true(rt.less(var_wp_prefix_at, var_end)) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int(0), rt.call_function('substr_compare', [var_text.clone(), rt.new_string('wp:'), var_wp_prefix_at.clone(), rt.new_int(3)]))))) {
			if (rt.is_true(rt.greater_equal(rt.add(var_wp_prefix_at, rt.new_int(2)), var_end)) && rt.is_true(rt.call_function('str_ends_with', [var_text.clone(), rt.new_string('wp')]))) || (rt.is_true(rt.greater_equal(rt.add(var_wp_prefix_at, rt.new_int(1)), var_end)) && rt.is_true(rt.call_function('str_ends_with', [var_text.clone(), rt.new_string('w')]))) {
				// unsupported statement: Stmt_Goto
			}
			var_at = rt.new_int(this.find_html_comment_end((var_comment_opening_at).to_i64(), (var_end).to_i64()))
			continue
		}
		mut var_namespace_at := rt.add(var_wp_prefix_at, rt.new_int(3))
		if rt.is_true(rt.greater_equal(var_namespace_at, var_end)) {
			// unsupported statement: Stmt_Goto
		}
		mut var_start_of_namespace := var_text.array_get(var_namespace_at)
		if rt.is_true(rt.greater(rt.new_string('a'), var_start_of_namespace)) || rt.is_true(rt.less(rt.new_string('z'), var_start_of_namespace)) {
			var_at = rt.new_int(this.find_html_comment_end((var_comment_opening_at).to_i64(), (var_end).to_i64()))
			continue
		}
		mut var_namespace_length := rt.add(rt.new_int(1), rt.call_function('strspn', [var_text.clone(), rt.new_string('abcdefghijklmnopqrstuvwxyz0123456789-_'), rt.add(var_namespace_at, rt.new_int(1))]))
		mut var_separator_at := rt.add(var_namespace_at, var_namespace_length)
		if rt.is_true(rt.greater_equal(var_separator_at, var_end)) {
			// unsupported statement: Stmt_Goto
		}
		mut var_has_separator := rt.identical(rt.new_string('/'), var_text.array_get(var_separator_at))
		if rt.is_true(var_has_separator) {
			mut var_name_at := rt.add(var_separator_at, rt.new_int(1))
			if rt.is_true(rt.greater_equal(var_name_at, var_end)) {
				// unsupported statement: Stmt_Goto
			}
			mut var_start_of_name := var_text.array_get(var_name_at)
			if rt.is_true(rt.greater(rt.new_string('a'), var_start_of_name)) || rt.is_true(rt.less(rt.new_string('z'), var_start_of_name)) {
				var_at = rt.new_int(this.find_html_comment_end((var_comment_opening_at).to_i64(), (var_end).to_i64()))
				continue
			}
		mut var_name_length := rt.add(rt.new_int(1), rt.call_function('strspn', [var_text.clone(), rt.new_string('abcdefghijklmnopqrstuvwxyz0123456789-_'), rt.add(var_name_at, rt.new_int(1))]))
		} else {
		var_name_at = var_namespace_at.clone()
		var_name_length = var_namespace_length.clone()
		}
		if rt.is_true(rt.greater_equal(rt.add(var_name_at, var_name_length), var_end)) {
			// unsupported statement: Stmt_Goto
		}
		mut var_after_name_whitespace_at := rt.add(var_name_at, var_name_length)
		mut var_after_name_whitespace_length := rt.call_function('strspn', [var_text.clone(), rt.new_string(' \t\r\n'), var_after_name_whitespace_at.clone()])
		mut var_json_at := rt.add(var_after_name_whitespace_at, var_after_name_whitespace_length)
		if rt.is_true(rt.greater_equal(var_json_at, var_end)) {
			// unsupported statement: Stmt_Goto
		}
		if rt.is_true(rt.identical(rt.new_int(0), var_after_name_whitespace_length)) {
			var_at = rt.new_int(this.find_html_comment_end((var_comment_opening_at).to_i64(), (var_end).to_i64()))
			continue
		}
		mut var_has_json := rt.identical(rt.new_string('{'), var_text.array_get(var_json_at))
		mut var_json_length := rt.new_int(0)
		mut var_comment_closing_at := rt.call_function('strpos', [var_text.clone(), rt.new_string('-->'), var_json_at.clone()])
		if rt.is_true(rt.identical(rt.new_bool(false), var_comment_closing_at)) {
			// unsupported statement: Stmt_Goto
		}
		if rt.is_true(rt.identical(rt.new_string('/'), var_text.array_get(rt.sub(var_comment_closing_at, rt.new_int(1))))) {
		mut var_has_void_flag := rt.new_bool(true)
		mut var_void_flag_length := rt.new_int(1)
		} else {
		var_has_void_flag = rt.new_bool(false)
		var_void_flag_length = rt.new_int(0)
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(var_has_json)))) {
			if rt.is_true(rt.identical(rt.add(var_after_name_whitespace_at, var_after_name_whitespace_length), rt.sub(var_comment_closing_at, var_void_flag_length))) {
				this.state = Class_WP_Block_Processor.matched()
				break
			}
			var_at = rt.new_int(this.find_html_comment_end((var_comment_opening_at).to_i64(), (var_end).to_i64()))
			continue
		}
		mut var_after_json_whitespace_length := rt.new_int(0)
		mut var_char_at := rt.sub(rt.sub(var_comment_closing_at, var_void_flag_length), rt.new_int(1))
		for {
			if !(rt.is_true(rt.greater(var_char_at, var_json_at))) { break }
			mut var_char := var_text.array_get(var_char_at)
			mut switch_val_2 := var_char
			if rt.is_true(rt.equal(switch_val_2, rt.new_string(' '))) || rt.is_true(rt.equal(switch_val_2, rt.new_string('\t'))) || rt.is_true(rt.equal(switch_val_2, rt.new_string(''))) || rt.is_true(rt.equal(switch_val_2, rt.new_string('\r'))) || rt.is_true(rt.equal(switch_val_2, rt.new_string('\n'))) {
				rt.pre_inc(var_after_json_whitespace_length)
				continue
			} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('}'))) {
			var_json_length = rt.add(rt.sub(var_char_at, var_json_at), rt.new_int(1))
			} else {
				rt.pre_inc(var_at)
				continue
			}
			rt.post_dec(var_char_at)
		}
		if rt.is_true(rt.identical(rt.new_int(0), var_json_length)) || rt.is_true(rt.identical(rt.new_int(0), var_after_json_whitespace_length)) {
			var_at = rt.new_int(this.find_html_comment_end((var_comment_opening_at).to_i64(), (var_end).to_i64()))
			continue
		}
		this.state = Class_WP_Block_Processor.matched()
		break
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(Class_WP_Block_Processor.matched(), this.state)))) {
		this.state = Class_WP_Block_Processor.complete()
		return false
	}
	this.after_previous_delimiter = var_after_prev_delimiter.clone()
	this.matched_delimiter_at = var_comment_opening_at.clone()
	this.matched_delimiter_length = rt.sub(rt.add(var_comment_closing_at, rt.new_int(3)), var_comment_opening_at)
	this.namespace_at = var_namespace_at.clone()
	this.name_at = var_name_at.clone()
	this.name_length = var_name_length.clone()
	this.json_at = var_json_at.clone()
	this.json_length = var_json_length.clone()
	if rt.is_true(var_has_void_flag) {
		this.prop_type = Class_WP_Block_Processor.void()
		this.next_stack_op = rt.new_string('void')
	} else if rt.is_true(var_has_closer) {
		this.prop_type = Class_WP_Block_Processor.closer()
		this.next_stack_op = rt.new_string('pop')
	} else {
		this.prop_type = Class_WP_Block_Processor.opener()
		this.next_stack_op = rt.new_string('push')
	}
	this.has_closing_flag = var_has_closer.clone()
	if rt.is_true(rt.greater(var_comment_opening_at, var_after_prev_delimiter)) {
		this.state = Class_WP_Block_Processor.html_span()
		this.open_blocks_at.array_push(var_after_prev_delimiter.clone())
		this.open_blocks_length.array_push(0)
		this.was_void = true
		return true
	}
	mut switch_val_3 := this.next_stack_op
	if rt.is_true(rt.equal(switch_val_3, rt.new_string('void'))) {
		this.was_void = true
		this.open_blocks_at.array_push(var_namespace_at.clone())
		this.open_blocks_length.array_push(rt.sub(rt.add(var_name_at, var_name_length), var_namespace_at))
	} else if rt.is_true(rt.equal(switch_val_3, rt.new_string('push'))) {
		this.open_blocks_at.array_push(var_namespace_at.clone())
		this.open_blocks_length.array_push(rt.sub(rt.add(var_name_at, var_name_length), var_namespace_at))
	} else if rt.is_true(rt.equal(switch_val_3, rt.new_string('pop'))) {
		rt.call_function('array_pop', [this.open_blocks_at])
		rt.call_function('array_pop', [this.open_blocks_length])
	}
	this.next_stack_op = rt.new_null()
	return true
	// unsupported statement: Stmt_Label
	this.state = Class_WP_Block_Processor.complete()
	this.last_error = Class_WP_Block_Processor.incomplete_input()
	return false
}

fn (mut this Class_WP_Block_Processor) get_breadcrumbs() rt.PhpVal {
	mut var_breadcrumbs := rt.call_function('array_fill', [rt.new_int(0), rt.new_int(this.open_blocks_at.array_count()), rt.new_null()])
	mut iter_1 := this.open_blocks_at.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_at := item_1.val
		mut var_i := item_1.key
		mut var_block_type := rt.call_function('substr', [rt.new_string(this.source_text), var_at.clone(), this.open_blocks_length.array_get(var_i)])
		var_breadcrumbs.array_set(var_i, Class_WP_Block_Processor.normalize_block_type((var_block_type).str()))
	}
	if !(var_i).is_null() && rt.is_true(rt.identical(rt.new_int(0), this.open_blocks_length.array_get(var_i))) {
		var_breadcrumbs.array_set(var_i, '#html')
	}
	return var_breadcrumbs.clone()
}

fn (mut this Class_WP_Block_Processor) get_depth() i64 {
	return this.open_blocks_at.array_count()
}

fn (mut this Class_WP_Block_Processor) extract_full_block_and_advance() rt.PhpVal {
	if this.is_html() {
		mut var_chunk := rt.new_string(this.get_html_content())
		return rt.create_array([rt.ArrayItem{ key: 'blockName', val: rt.new_null() }, rt.ArrayItem{ key: 'attrs', val: rt.new_array() }, rt.ArrayItem{ key: 'innerBlocks', val: rt.new_array() }, rt.ArrayItem{ key: 'innerHTML', val: var_chunk }, rt.ArrayItem{ key: 'innerContent', val: rt.create_array([rt.ArrayItem{ key: none, val: var_chunk }]) }])
	}
	mut var_block := { 'blockName': this.get_block_type(), 'attrs': if !(this.allocate_and_return_parsed_attributes()).is_null() { this.allocate_and_return_parsed_attributes() } else { rt.new_array() }, 'innerBlocks': rt.new_array(), 'innerHTML': rt.new_string(''), 'innerContent': rt.new_array() }
	mut var_depth := rt.new_int(this.get_depth())
	for this.next_token() && rt.is_true(rt.greater(this.get_depth(), var_depth)) {
		if this.is_html() {
			var_chunk = rt.new_string(this.get_html_content())
			var_block['innerHTML'] = rt.concat(var_block['innerHTML'], var_chunk)
			var_block.array_get_mut('innerContent').array_push(var_chunk.clone())
			continue
		}
		if this.opens_block('') {
			mut var_inner_block := this.extract_full_block_and_advance()
			var_block.array_get_mut('innerBlocks').array_push(var_inner_block.clone())
			var_block.array_get_mut('innerContent').array_push(rt.new_null())
		}
		if this.is_html() {
			var_chunk = rt.new_string(this.get_html_content())
			var_block['innerHTML'] = rt.concat(var_block['innerHTML'], var_chunk)
			var_block.array_get_mut('innerContent').array_push(var_chunk.clone())
		}
	}
	return var_block.clone()
}

fn (mut this Class_WP_Block_Processor) find_html_comment_end(comment_starting_at i64, search_end i64) i64 {
	mut var_text := rt.new_string(this.source_text)
	mut var_span_of_dashes := rt.call_function('strspn', [var_text.clone(), rt.new_string('-'), rt.new_int(comment_starting_at + 2)])
	if rt.is_true(rt.less(rt.add(comment_starting_at + 2, var_span_of_dashes), rt.new_int(search_end))) && rt.is_true(rt.identical(rt.new_string('>'), var_text.array_get(rt.add(comment_starting_at + 2, var_span_of_dashes)))) {
		return (rt.add(rt.add(rt.new_int(comment_starting_at), var_span_of_dashes), rt.new_int(1))).to_i64()
	}
	mut var_now_at := rt.new_int(comment_starting_at + 4)
	for rt.is_true(rt.less(var_now_at, rt.new_int(search_end))) {
		mut var_dashes_at := rt.call_function('strpos', [var_text.clone(), rt.new_string('--'), var_now_at.clone()])
		if rt.is_true(rt.identical(rt.new_bool(false), var_dashes_at)) {
			return search_end
		}
		mut var_closer_must_be_at := rt.add(rt.add(var_dashes_at, rt.new_int(2)), rt.call_function('strspn', [var_text.clone(), rt.new_string('-'), rt.add(var_dashes_at, rt.new_int(2))]))
		if rt.is_true(rt.less(var_closer_must_be_at, rt.new_int(search_end))) && rt.is_true(rt.identical(rt.new_string('!'), var_text.array_get(var_closer_must_be_at))) {
			rt.pre_inc(var_closer_must_be_at)
		}
		if rt.is_true(rt.less(var_closer_must_be_at, rt.new_int(search_end))) && rt.is_true(rt.identical(rt.new_string('>'), var_text.array_get(var_closer_must_be_at))) {
			return (rt.add(var_closer_must_be_at, rt.new_int(1))).to_i64()
		}
		rt.pre_inc(var_now_at)
	}
	return search_end
}

fn (mut this Class_WP_Block_Processor) get_last_error() string {
	return (this.last_error).str()
}

fn (mut this Class_WP_Block_Processor) get_last_json_error() i64 {
	return (this.last_json_error).to_i64()
}

fn (mut this Class_WP_Block_Processor) get_delimiter_type() string {
	mut switch_val_4 := this.state
	if rt.is_true(rt.equal(switch_val_4, Class_WP_Block_Processor.html_span())) {
		return Class_WP_Block_Processor.void()
	} else if rt.is_true(rt.equal(switch_val_4, Class_WP_Block_Processor.matched())) {
		return (this.prop_type).str()
	} else {
		return (rt.new_null()).str()
	}
	return ''
}

fn (mut this Class_WP_Block_Processor) has_closing_flag() bool {
	return (this.has_closing_flag).to_bool()
}

fn (mut this Class_WP_Block_Processor) is_block_type(block_type string) bool {
	mut block_type_mutated := block_type
	if rt.is_true(rt.identical(rt.new_string('*'), rt.new_string(block_type_mutated))) {
		return true
	}
	if this.is_html() {
		if rt.is_true(rt.identical(rt.new_int(0), if !(this.open_blocks_length.array_get(rt.new_int(0))).is_null() { this.open_blocks_length.array_get(rt.new_int(0)) } else { rt.new_null() })) {
			return rt.is_true(rt.identical(rt.new_string('core/freeform'), rt.new_string(block_type_mutated))) || rt.is_true(rt.identical(rt.new_string('freeform'), rt.new_string(block_type_mutated)))
		}
		return false
	}
	return this.are_equal_block_types(this.source_text, (this.namespace_at).to_i64(), (rt.add(rt.sub(this.name_at, this.namespace_at), this.name_length)).to_i64(), block_type_mutated, 0, block_type_mutated.len)
}

fn Class_WP_Block_Processor.are_equal_block_types(a_text string, a_at i64, a_length i64, b_text string, b_at i64, b_length i64) bool {
	mut var_a_ns_length := rt.call_function('strcspn', [rt.new_string(a_text), rt.new_string('/'), rt.new_int(a_at), rt.new_int(a_length)])
	mut var_b_ns_length := rt.call_function('strcspn', [rt.new_string(b_text), rt.new_string('/'), rt.new_int(b_at), rt.new_int(b_length)])
	mut var_a_has_ns := rt.new_bool(!rt.is_true(rt.identical(var_a_ns_length, rt.new_int(a_length))))
	mut var_b_has_ns := rt.new_bool(!rt.is_true(rt.identical(var_b_ns_length, rt.new_int(b_length))))
	if rt.is_true(var_a_has_ns) && rt.is_true(var_b_has_ns) {
		if rt.is_true(rt.new_bool(a_length != b_length)) {
			return false
		}
		mut var_a_block_type := rt.call_function('substr', [rt.new_string(a_text), rt.new_int(a_at), rt.new_int(a_length)])
		return (rt.identical(rt.new_int(0), rt.call_function('substr_compare', [rt.new_string(b_text), var_a_block_type.clone(), rt.new_int(b_at), rt.new_int(b_length)]))).to_bool()
	}
	if rt.is_true(var_a_has_ns) {
		mut var_b_block_type := rt.new_string('core/' + (rt.call_function('substr', [rt.new_string(b_text), rt.new_int(b_at), rt.new_int(b_length)])).str())
		return var_b_block_type.clone().to_string().len == a_length && rt.is_true(rt.identical(rt.new_int(0), rt.call_function('substr_compare', [rt.new_string(a_text), var_b_block_type.clone(), rt.new_int(a_at), rt.new_int(a_length)])))
	}
	if rt.is_true(var_b_has_ns) {
		var_a_block_type = rt.new_string('core/' + (rt.call_function('substr', [rt.new_string(a_text), rt.new_int(a_at), rt.new_int(a_length)])).str())
		return var_a_block_type.clone().to_string().len == b_length && rt.is_true(rt.identical(rt.new_int(0), rt.call_function('substr_compare', [rt.new_string(b_text), var_a_block_type.clone(), rt.new_int(b_at), rt.new_int(b_length)])))
	}
	if rt.is_true(rt.new_bool(a_length != b_length)) {
		return false
	}
	mut var_a_name := rt.call_function('substr', [rt.new_string(a_text), rt.new_int(a_at), rt.new_int(a_length)])
	return (rt.identical(rt.new_int(0), rt.call_function('substr_compare', [rt.new_string(b_text), var_a_name.clone(), rt.new_int(b_at), rt.new_int(b_length)]))).to_bool()
}

fn (mut this Class_WP_Block_Processor) opens_block(block_type string) bool {
	mut block_type_mutated := block_type
	if rt.is_true(rt.identical(Class_WP_Block_Processor.html_span(), this.state)) && rt.is_true(rt.new_bool(1 != this.open_blocks_at.array_count())) {
		return false
	}
	if rt.is_true(rt.identical(Class_WP_Block_Processor.closer(), this.prop_type)) && !(this.is_html()) {
		return false
	}
	if rt.new_string(block_type_mutated).clone().array_count() == 0 {
		return true
	}
	mut iter_2 := rt.new_string(block_type_mutated).iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_block := item_2.val
		if this.is_block_type((var_block).str()) {
			return true
		}
	}
	return false
}

fn (mut this Class_WP_Block_Processor) is_html() bool {
	return (rt.identical(Class_WP_Block_Processor.html_span(), this.state)).to_bool()
}

fn (mut this Class_WP_Block_Processor) is_non_whitespace_html() bool {
	if !(this.is_html()) {
		return false
	}
	mut var_length := rt.sub(this.matched_delimiter_at, this.after_previous_delimiter)
	mut var_whitespace_length := rt.call_function('strspn', [rt.new_string(this.source_text), rt.new_string(' \t\r\n'), this.after_previous_delimiter, var_length.clone()])
	return rt.new_bool(!rt.is_true(rt.identical(var_whitespace_length, var_length)))
}

fn (mut this Class_WP_Block_Processor) get_html_content() string {
	if !(this.is_html()) {
		return (rt.new_null()).str()
	}
	return (rt.call_function('substr', [rt.new_string(this.source_text), this.after_previous_delimiter, rt.sub(this.matched_delimiter_at, this.after_previous_delimiter)])).str()
}

fn (mut this Class_WP_Block_Processor) get_block_type() string {
	if rt.is_true(rt.identical(Class_WP_Block_Processor.ready(), this.state)) || rt.is_true(rt.identical(Class_WP_Block_Processor.complete(), this.state)) || rt.is_true(rt.identical(Class_WP_Block_Processor.incomplete_input(), this.state)) {
		return (rt.new_null()).str()
	}
	if this.is_html() {
		return (rt.new_null()).str()
	}
	mut var_block_type := rt.call_function('substr', [rt.new_string(this.source_text), this.namespace_at, rt.add(rt.sub(this.name_at, this.namespace_at), this.name_length)])
	return (Class_WP_Block_Processor.normalize_block_type((var_block_type).str())).str()
}

fn (mut this Class_WP_Block_Processor) get_printable_block_type() string {
	if rt.is_true(rt.identical(Class_WP_Block_Processor.ready(), this.state)) || rt.is_true(rt.identical(Class_WP_Block_Processor.complete(), this.state)) || rt.is_true(rt.identical(Class_WP_Block_Processor.incomplete_input(), this.state)) {
		return (rt.new_null()).str()
	}
	if this.is_html() {
		return if 1 == this.open_blocks_at.array_count() { 'core/freeform' } else { '#innerHTML' }
	}
	mut var_block_type := rt.call_function('substr', [rt.new_string(this.source_text), this.namespace_at, rt.add(rt.sub(this.name_at, this.namespace_at), this.name_length)])
	return (Class_WP_Block_Processor.normalize_block_type((var_block_type).str())).str()
}

fn Class_WP_Block_Processor.normalize_block_type(block_type string) string {
	mut block_type_mutated := block_type
	return if rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('strpos', [rt.new_string(block_type_mutated).clone(), rt.new_string('/')]))) { "core/${var_block_type.to_string()}" } else { block_type_mutated }
}

fn (mut this Class_WP_Block_Processor) get_attributes() {
	rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.new_string('Lazy attribute parsing not yet supported'))))
}

fn (mut this Class_WP_Block_Processor) allocate_and_return_parsed_attributes() rt.PhpVal {
	this.last_json_error = rt.get_constant('JSON_ERROR_NONE')
	if rt.is_true(rt.identical(Class_WP_Block_Processor.closer(), this.prop_type)) || this.is_html() || rt.is_true(rt.identical(rt.new_int(0), this.json_length)) {
		return rt.new_null()
	}
	mut var_json_span := rt.call_function('substr', [rt.new_string(this.source_text), this.json_at, this.json_length])
	mut var_parsed := rt.call_function('json_decode', [var_json_span.clone(), rt.new_null(), rt.new_int(512), rt.bitwise_or(rt.get_constant('JSON_OBJECT_AS_ARRAY'), rt.get_constant('JSON_INVALID_UTF8_SUBSTITUTE'))])
	mut var_last_error := rt.call_function('json_last_error', []rt.PhpVal{})
	this.last_json_error = var_last_error.clone()
	return if rt.is_true(rt.identical(rt.get_constant('JSON_ERROR_NONE'), var_last_error)) && var_parsed.clone().is_array() { var_parsed } else { rt.new_null() }
}

fn (mut this Class_WP_Block_Processor) get_span() rt.PhpVal {
	mut switch_val_5 := this.state
	if rt.is_true(rt.equal(switch_val_5, Class_WP_Block_Processor.html_span())) {
		return create_wp_html_span(this.after_previous_delimiter, rt.sub(this.matched_delimiter_at, this.after_previous_delimiter))
	} else if rt.is_true(rt.equal(switch_val_5, Class_WP_Block_Processor.matched())) {
		return create_wp_html_span(this.matched_delimiter_at, this.matched_delimiter_length)
	} else {
		return rt.new_null()
	}
	return rt.new_null()
}

struct Class_Exception {
	rt.PhpObjectBase
pub mut:
		message string
		code i64
		file string
		line i64
}

fn (mut this Class_Exception) construct(var_message rt.PhpVal) {
	this.message = var_message.to_string()
}

fn (mut this Class_Exception) getmessage() string {
	return this.message
}

struct Class_WP_HTML_Span {
	rt.PhpObjectBase
}

fn create_wp_block_processor(source_text string) &Class_WP_Block_Processor {
	mut obj := &Class_WP_Block_Processor{
		PhpObjectBase: rt.PhpObjectBase{}
		last_error: rt.new_null()
		last_json_error: rt.new_null()
		source_text: ''
		matched_delimiter_at: rt.new_int(0)
		matched_delimiter_length: rt.new_int(0)
		after_previous_delimiter: rt.new_int(0)
		namespace_at: rt.new_int(0)
		name_at: rt.new_int(0)
		name_length: rt.new_int(0)
		has_closing_flag: rt.new_bool(false)
		json_at: rt.new_null()
		json_length: rt.new_int(0)
		state: rt.new_null()
		prop_type: rt.new_null()
		was_void: false
		open_blocks_at: rt.new_array()
		open_blocks_length: rt.new_array()
		next_stack_op: rt.new_null()
	}
	obj.construct(source_text)
	return obj
}

fn create_exception(arg_0 rt.PhpVal) &Class_Exception {
	mut obj := &Class_Exception{
		PhpObjectBase: rt.PhpObjectBase{}
		message: ''
		code: i64(0)
		file: ''
		line: i64(0)
	}
	obj.construct(arg_0)
	return obj
}

fn create_wp_html_span(_args ...rt.PhpVal) &Class_WP_HTML_Span {
	mut obj := &Class_WP_HTML_Span{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Block_Processor) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'next_block' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_?string](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_bool(this.next_block(mut dispatch_arg_0))
		}
		'next_delimiter' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_?string](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_bool(this.next_delimiter(mut dispatch_arg_0))
		}
		'next_token' {
			return rt.new_bool(this.next_token())
		}
		'get_breadcrumbs' {
			return this.get_breadcrumbs()
		}
		'get_depth' {
			return rt.new_int(this.get_depth())
		}
		'extract_full_block_and_advance' {
			return this.extract_full_block_and_advance()
		}
		'find_html_comment_end' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			return rt.new_int(this.find_html_comment_end(dispatch_arg_0, dispatch_arg_1))
		}
		'get_last_error' {
			return rt.new_string(this.get_last_error())
		}
		'get_last_json_error' {
			return rt.new_int(this.get_last_json_error())
		}
		'get_delimiter_type' {
			return rt.new_string(this.get_delimiter_type())
		}
		'has_closing_flag' {
			return rt.new_bool(this.has_closing_flag())
		}
		'is_block_type' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(this.is_block_type(dispatch_arg_0))
		}
		'are_equal_block_types' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_i64()
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).str()
			dispatch_arg_4 := (if args.len > 4 { args[4] } else { rt.new_null() }).to_i64()
			dispatch_arg_5 := (if args.len > 5 { args[5] } else { rt.new_null() }).to_i64()
			return rt.new_bool(Class_WP_Block_Processor.are_equal_block_types(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3, dispatch_arg_4, dispatch_arg_5))
		}
		'opens_block' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(this.opens_block(dispatch_arg_0))
		}
		'is_html' {
			return rt.new_bool(this.is_html())
		}
		'is_non_whitespace_html' {
			return rt.new_bool(this.is_non_whitespace_html())
		}
		'get_html_content' {
			return rt.new_string(this.get_html_content())
		}
		'get_block_type' {
			return rt.new_string(this.get_block_type())
		}
		'get_printable_block_type' {
			return rt.new_string(this.get_printable_block_type())
		}
		'normalize_block_type' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(Class_WP_Block_Processor.normalize_block_type(dispatch_arg_0))
		}
		'get_attributes' {
			this.get_attributes()
			return rt.new_null()
		}
		'allocate_and_return_parsed_attributes' {
			return this.allocate_and_return_parsed_attributes()
		}
		'get_span' {
			return this.get_span()
		}
		else { return none }
	}
}

fn (this &Class_WP_Block_Processor) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'last_error' { return this.last_error }
		'last_json_error' { return this.last_json_error }
		'source_text' { return rt.new_string(this.source_text) }
		'matched_delimiter_at' { return this.matched_delimiter_at }
		'matched_delimiter_length' { return this.matched_delimiter_length }
		'after_previous_delimiter' { return this.after_previous_delimiter }
		'namespace_at' { return this.namespace_at }
		'name_at' { return this.name_at }
		'name_length' { return this.name_length }
		'has_closing_flag' { return this.has_closing_flag }
		'json_at' { return this.json_at }
		'json_length' { return this.json_length }
		'state' { return this.state }
		'type' { return this.prop_type }
		'was_void' { return rt.new_bool(this.was_void) }
		'open_blocks_at' { return this.open_blocks_at }
		'open_blocks_length' { return this.open_blocks_length }
		'next_stack_op' { return this.next_stack_op }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_Block_Processor) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'last_error' { this.last_error = val; return true }
		'last_json_error' { this.last_json_error = val; return true }
		'source_text' { this.source_text = (val).str(); return true }
		'matched_delimiter_at' { this.matched_delimiter_at = val; return true }
		'matched_delimiter_length' { this.matched_delimiter_length = val; return true }
		'after_previous_delimiter' { this.after_previous_delimiter = val; return true }
		'namespace_at' { this.namespace_at = val; return true }
		'name_at' { this.name_at = val; return true }
		'name_length' { this.name_length = val; return true }
		'has_closing_flag' { this.has_closing_flag = val; return true }
		'json_at' { this.json_at = val; return true }
		'json_length' { this.json_length = val; return true }
		'state' { this.state = val; return true }
		'type' { this.prop_type = val; return true }
		'was_void' { this.was_void = (val).to_bool(); return true }
		'open_blocks_at' { this.open_blocks_at = val; return true }
		'open_blocks_length' { this.open_blocks_length = val; return true }
		'next_stack_op' { this.next_stack_op = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Exception) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'getMessage' {
			return rt.new_string(this.getmessage())
		}
		else { return none }
	}
}

fn (this &Class_Exception) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'message' { return rt.new_string(this.message) }
		'code' { return rt.new_int(this.code) }
		'file' { return rt.new_string(this.file) }
		'line' { return rt.new_int(this.line) }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Exception) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'message' { this.message = (val).str(); return true }
		'code' { this.code = (val).to_i64(); return true }
		'file' { this.file = (val).str(); return true }
		'line' { this.line = (val).to_i64(); return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_WP_HTML_Span) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_HTML_Span) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_HTML_Span) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}



fn main() {
	defer {
		rt.shutdown()
	}

}
