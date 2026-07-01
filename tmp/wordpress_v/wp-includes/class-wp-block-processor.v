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

fn (mut this Class_WP_Block_Processor) construct(source_text string)  {
	this.source_text = source_text
}

fn (mut this Class_WP_Block_Processor) next_block(mut var_block_type Class_?string) bool {
	mut var_block_type_mutated := var_block_type
	for this.next_delimiter(mut var_block_type_mutated) {
		if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
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
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(this.last_error) || rt.is_true(rt.identical(Class_WP_Block_Processor.complete(), this.state)))) || rt.is_true(rt.identical(Class_WP_Block_Processor.incomplete_input(), this.state)))) {
		return false
	}
	if rt.is_true(this.was_void) {
		rt.call_function('array_pop', [this.open_blocks_at])
		rt.call_function('array_pop', [this.open_blocks_length])
		this.was_void = false
	}
	mut var_text := rt.new_string(this.source_text)
	mut var_end := rt.new_int(rt.new_int(var_text.dup().to_string().len))
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
	mut var_at := var_after_prev_delimiter.dup()
	for rt.is_true(rt.less(var_at, var_end)) {
		mut var_comment_opening_at := rt.call_function('strpos', [var_text.dup(), rt.new_string('<!--'), var_at.dup()])
		if rt.is_true(rt.identical(rt.new_bool(false), var_comment_opening_at)) {
			if rt.is_true(rt.call_function('str_ends_with', [var_text.dup(), rt.new_string('<!-')])) {
				mut var_backup := rt.new_int(rt.new_int(3))
			} else if rt.is_true(rt.call_function('str_ends_with', [var_text.dup(), rt.new_string('<!')])) {
				var_backup = rt.new_int(rt.new_int(2))
			} else if rt.is_true(rt.call_function('str_ends_with', [var_text.dup(), rt.new_string('<')])) {
				var_backup = rt.new_int(rt.new_int(1))
			} else {
				var_backup = rt.new_int(rt.new_int(0))
			}
			if rt.is_true(rt.less(var_after_prev_delimiter, rt.sub(var_end, var_backup))) {
				this.state = Class_WP_Block_Processor.html_span()
				this.after_previous_delimiter = var_after_prev_delimiter.dup()
				this.matched_delimiter_at = rt.sub(var_end, var_backup)
				this.matched_delimiter_length = var_backup.dup()
				this.open_blocks_at.array_push(var_after_prev_delimiter.dup())
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
		mut var_opening_whitespace_length := rt.call_function('strspn', [var_text.dup(), rt.new_string(' \t\r\n'), var_opening_whitespace_at.dup()])
		mut var_wp_prefix_at := rt.add(var_opening_whitespace_at, var_opening_whitespace_length)
		if rt.is_true(rt.greater_equal(var_wp_prefix_at, var_end)) {
			// unsupported statement: Stmt_Goto
		}
		if rt.is_true(rt.identical(rt.new_int(0), var_opening_whitespace_length)) {
			var_at = rt.new_int(this.find_html_comment_end((var_comment_opening_at).to_i64(), (var_end).to_i64()))
			continue
		}
		mut var_has_closer := rt.new_bool(rt.new_bool(false))
		if rt.is_true(rt.identical(rt.new_string('/'), var_text.array_get(var_wp_prefix_at))) {
			var_has_closer = rt.new_bool(rt.new_bool(true))
			rt.pre_inc(var_wp_prefix_at)
		}
		if rt.is_true(rt.new_bool(rt.is_true(rt.less(var_wp_prefix_at, var_end)) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
			if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.greater_equal(rt.add(var_wp_prefix_at, rt.new_int(2)), var_end)) && rt.is_true(rt.call_function('str_ends_with', [var_text.dup(), rt.new_string('wp')])))) || rt.is_true(rt.new_bool(rt.is_true(rt.greater_equal(rt.add(var_wp_prefix_at, rt.new_int(1)), var_end)) && rt.is_true(rt.call_function('str_ends_with', [var_text.dup(), rt.new_string('w')])))))) {
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
		if rt.is_true(rt.new_bool(rt.is_true(rt.greater(rt.new_string('a'), var_start_of_namespace)) || rt.is_true(rt.less(rt.new_string('z'), var_start_of_namespace)))) {
			var_at = rt.new_int(this.find_html_comment_end((var_comment_opening_at).to_i64(), (var_end).to_i64()))
			continue
		}
		mut var_namespace_length := rt.add(rt.new_int(1), rt.call_function('strspn', [var_text.dup(), rt.new_string('abcdefghijklmnopqrstuvwxyz0123456789-_'), rt.add(var_namespace_at, rt.new_int(1))]))
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
			if rt.is_true(rt.new_bool(rt.is_true(rt.greater(rt.new_string('a'), var_start_of_name)) || rt.is_true(rt.less(rt.new_string('z'), var_start_of_name)))) {
				var_at = rt.new_int(this.find_html_comment_end((var_comment_opening_at).to_i64(), (var_end).to_i64()))
				continue
			}
			mut var_name_length := rt.add(rt.new_int(1), rt.call_function('strspn', [var_text.dup(), rt.new_string('abcdefghijklmnopqrstuvwxyz0123456789-_'), rt.add(var_name_at, rt.new_int(1))]))
		} else {
			var_name_at = var_namespace_at.dup()
			var_name_length = var_namespace_length.dup()
		}
		if rt.is_true(rt.greater_equal(rt.add(var_name_at, var_name_length), var_end)) {
			// unsupported statement: Stmt_Goto
		}
		mut var_after_name_whitespace_at := rt.add(var_name_at, var_name_length)
		mut var_after_name_whitespace_length := rt.call_function('strspn', [var_text.dup(), rt.new_string(' \t\r\n'), var_after_name_whitespace_at.dup()])
		mut var_json_at := rt.add(var_after_name_whitespace_at, var_after_name_whitespace_length)
		if rt.is_true(rt.greater_equal(var_json_at, var_end)) {
			// unsupported statement: Stmt_Goto
		}
		if rt.is_true(rt.identical(rt.new_int(0), var_after_name_whitespace_length)) {
			var_at = rt.new_int(this.find_html_comment_end((var_comment_opening_at).to_i64(), (var_end).to_i64()))
			continue
		}
		mut var_has_json := rt.identical(rt.new_string('{'), var_text.array_get(var_json_at))
		mut var_json_length := rt.new_int(rt.new_int(0))
		mut var_comment_closing_at := rt.call_function('strpos', [var_text.dup(), rt.new_string('-->'), var_json_at.dup()])
		if rt.is_true(rt.identical(rt.new_bool(false), var_comment_closing_at)) {
			// unsupported statement: Stmt_Goto
		}
		if rt.is_true(rt.identical(rt.new_string('/'), var_text.array_get(rt.sub(var_comment_closing_at, rt.new_int(1))))) {
			mut var_has_void_flag := rt.new_bool(rt.new_bool(true))
			mut var_void_flag_length := rt.new_int(rt.new_int(1))
		} else {
			var_has_void_flag = rt.new_bool(rt.new_bool(false))
			var_void_flag_length = rt.new_int(rt.new_int(0))
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(var_has_json)))) {
			if rt.is_true(rt.identical(rt.add(var_after_name_whitespace_at, var_after_name_whitespace_length), rt.sub(var_comment_closing_at, var_void_flag_length))) {
				this.state = Class_WP_Block_Processor.matched()
				break
			}
			var_at = rt.new_int()
			continue
		}
		
	}
}

fn (mut this Class_WP_Block_Processor) get_breadcrumbs() rt.PhpVal {
}

fn (mut this Class_WP_Block_Processor) get_depth() i64 {
}

fn (mut this Class_WP_Block_Processor) extract_full_block_and_advance() rt.PhpVal {
}

fn (mut this Class_WP_Block_Processor) find_html_comment_end(comment_starting_at i64, search_end i64) i64 {
}

fn (mut this Class_WP_Block_Processor) get_last_error() string {
}

fn (mut this Class_WP_Block_Processor) get_last_json_error() i64 {
}

fn (mut this Class_WP_Block_Processor) get_delimiter_type() string {
	return ''
}

fn (mut this Class_WP_Block_Processor) has_closing_flag() bool {
}

fn (mut this Class_WP_Block_Processor) is_block_type(block_type string) bool {
	mut block_type_mutated := block_type
}

fn Class_WP_Block_Processor.are_equal_block_types(a_text string, a_at i64, a_length i64, b_text string, b_at i64, b_length i64) bool {
}

fn (mut this Class_WP_Block_Processor) opens_block(block_type string) bool {
	mut block_type_mutated := block_type
}

fn (mut this Class_WP_Block_Processor) is_html() bool {
}

fn (mut this Class_WP_Block_Processor) is_non_whitespace_html() bool {
}

fn (mut this Class_WP_Block_Processor) get_html_content() string {
}

fn (mut this Class_WP_Block_Processor) get_block_type() string {
}

fn (mut this Class_WP_Block_Processor) get_printable_block_type() string {
}

fn Class_WP_Block_Processor.normalize_block_type(block_type string) string {
	mut block_type_mutated := block_type
}

fn (mut this Class_WP_Block_Processor) get_attributes()  {
}

fn (mut this Class_WP_Block_Processor) allocate_and_return_parsed_attributes() rt.PhpVal {
}

fn (mut this Class_WP_Block_Processor) get_span()  {
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
			this.get_span()
			return rt.new_null()
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




pub fn init_wp_includes_class_wp_block_processor_php() {
}
