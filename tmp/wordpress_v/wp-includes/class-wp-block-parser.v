import rt

struct Class_WP_Block_Parser {
	rt.PhpObjectBase
pub mut:
		document rt.PhpVal = rt.new_null()
		offset i64
		output rt.PhpVal = rt.new_null()
		stack rt.PhpVal = rt.new_null()
}

fn (mut this Class_WP_Block_Parser) parse(var_document rt.PhpVal) rt.PhpVal {
	this.document = var_document.dup()
	this.offset = 0
	this.output = rt.new_array()
	this.stack = rt.new_array()
	for rt.is_true(this.proceed()) {
		continue
	}
	return this.output
}

fn (mut this Class_WP_Block_Parser) proceed()  {
	mut var_token_type := rt.new_null()
	mut var_block_name := rt.new_null()
	mut var_attrs := rt.new_null()
	mut var_start_offset := rt.new_null()
	mut var_token_length := rt.new_null()
	mut var_next_token := this.next_token()
	// unsupported assign target: Expr_List
	mut var_stack_depth := rt.new_int(rt.new_int(this.stack.array_count()))
	mut var_leading_html_start := if rt.is_true(rt.greater(var_start_offset, this.offset)) { this.offset } else { rt.new_null() }
	mut switch_val_1 := var_token_type
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('no-more-tokens'))) {
		if rt.is_true(rt.identical(rt.new_int(0), var_stack_depth)) {
			this.add_freeform(rt.new_null())
			return rt.new_bool(false)
		}
		if rt.is_true(rt.identical(rt.new_int(1), var_stack_depth)) {
			this.add_block_from_stack(rt.new_null())
			return rt.new_bool(false)
		}
		for 0 < this.stack.array_count() {
			this.add_block_from_stack(rt.new_null())
		}
		return rt.new_bool(false)
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('void-block'))) {
		if rt.is_true(rt.identical(rt.new_int(0), var_stack_depth)) {
			if !(var_leading_html_start).is_null() {
				this.output.array_push(rt.cast_array(this.freeform(rt.call_function('substr', [this.document, var_leading_html_start.dup(), rt.sub(var_start_offset, var_leading_html_start)]))))
			}
			this.output.array_push(rt.cast_array(create_wp_block_parser_block(var_block_name.dup(), var_attrs.dup(), rt.new_array(), rt.new_string(''), rt.new_array())))
			this.offset = var_start_offset + var_token_length
			return rt.new_bool(true)
		}
		this.add_inner_block(mut rt.cast_object_ptr[Class_WP_Block_Parser_Block](create_wp_block_parser_block(var_block_name.dup(), var_attrs.dup(), rt.new_array(), rt.new_string(''), rt.new_array())), var_start_offset.dup(), var_token_length.dup(), rt.new_null())
		this.offset = var_start_offset + var_token_length
		return rt.new_bool(true)
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('block-opener'))) {
		this.stack.array_push(create_wp_block_parser_frame(create_wp_block_parser_block(var_block_name.dup(), var_attrs.dup(), rt.new_array(), rt.new_string(''), rt.new_array()), var_start_offset.dup(), var_token_length.dup(), rt.add(var_start_offset, var_token_length), var_leading_html_start.dup()))
		this.offset = var_start_offset + var_token_length
		return rt.new_bool(true)
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('block-closer'))) {
		if rt.is_true(rt.identical(rt.new_int(0), var_stack_depth)) {
			this.add_freeform(rt.new_null())
			return rt.new_bool(false)
		}
		if rt.is_true(rt.identical(rt.new_int(1), var_stack_depth)) {
			this.add_block_from_stack(var_start_offset.dup())
			this.offset = var_start_offset + var_token_length
			return rt.new_bool(true)
		}
		mut var_stack_top := rt.call_function('array_pop', [this.stack])
		mut var_html := rt.call_function('substr', [this.document, rt.get_property(var_stack_top, 'prev_offset'), rt.sub(var_start_offset, rt.get_property(var_stack_top, 'prev_offset'))])
		// unsupported expression: Expr_AssignOp_Concat
		rt.get_property(rt.get_property(var_stack_top, 'block'), 'innerContent').array_push(var_html.dup())
		rt.set_property(var_stack_top, 'prev_offset', rt.add(var_start_offset, var_token_length))
		this.add_inner_block(mut rt.cast_object_ptr[Class_WP_Block_Parser_Block](rt.get_property(var_stack_top, 'block')), rt.get_property(var_stack_top, 'token_start'), rt.get_property(var_stack_top, 'token_length'), rt.add(var_start_offset, var_token_length))
		this.offset = var_start_offset + var_token_length
		return rt.new_bool(true)
	} else {
		this.add_freeform(rt.new_null())
		return rt.new_bool(false)
	}
}

fn (mut this Class_WP_Block_Parser) next_token() rt.PhpVal {
	mut var_match := rt.new_null()
	mut var_started_at := rt.new_null()
	mut var_matches := rt.new_null()
	mut var_has_match := rt.call_function('preg_match', [rt.new_string('/<!--\\s+(?P<closer>\\/)?wp:(?P<namespace>[a-z][a-z0-9_-]*\\/)?(?P<name>[a-z][a-z0-9_-]*)\\s+(?P<attrs>{(?:(?:[^}]+|}+(?=})|(?!}\\s+\\/?-->).)*+)?}\\s+)?(?P<void>\\/)?-->/s'), this.document, var_matches.dup(), rt.get_constant('PREG_OFFSET_CAPTURE'), this.offset])
	if rt.is_true(rt.identical(rt.new_bool(false), var_has_match)) {
		return rt.create_array([rt.ArrayItem{ key: none, val: 'no-more-tokens' }, rt.ArrayItem{ key: none, val: rt.new_null() }, rt.ArrayItem{ key: none, val: rt.new_null() }, rt.ArrayItem{ key: none, val: rt.new_null() }, rt.ArrayItem{ key: none, val: rt.new_null() }])
	}
	if rt.is_true(rt.identical(rt.new_int(0), var_has_match)) {
		return rt.create_array([rt.ArrayItem{ key: none, val: 'no-more-tokens' }, rt.ArrayItem{ key: none, val: rt.new_null() }, rt.ArrayItem{ key: none, val: rt.new_null() }, rt.ArrayItem{ key: none, val: rt.new_null() }, rt.ArrayItem{ key: none, val: rt.new_null() }])
	}
	// unsupported assign target: Expr_List
	mut var_length := rt.new_int(rt.new_int(var_match.dup().to_string().len))
	mut var_is_closer := rt.new_bool(rt.new_bool(var_matches.array_isset(rt.new_string('closer')) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical)))
	mut var_is_void := rt.new_bool(rt.new_bool(var_matches.array_isset(rt.new_string('void')) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical)))
	mut var_namespace := var_matches.array_get('namespace')
	var_namespace = if rt.is_true(rt.new_bool(!(var_namespace).is_null() && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) { var_namespace.array_get(0) } else { rt.new_string('core/') }
	mut var_name := rt.new_string(rt.concat(var_namespace, var_matches.array_get('name').array_get(0)))
	mut var_has_attrs := rt.new_bool(rt.new_bool(var_matches.array_isset(rt.new_string('attrs')) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical)))
	mut var_attrs := if rt.is_true(var_has_attrs) { rt.call_function('json_decode', [var_matches.array_get('attrs').array_get(0), rt.new_bool(true)]) } else { rt.new_array() }
	if rt.is_true(rt.new_bool(rt.is_true(var_is_closer) && rt.is_true(rt.new_bool(rt.is_true(var_is_void) || rt.is_true(var_has_attrs))))) {
		// unsupported statement: Stmt_Nop
	}
	if rt.is_true(var_is_void) {
		return rt.create_array([rt.ArrayItem{ key: none, val: 'void-block' }, rt.ArrayItem{ key: none, val: var_name }, rt.ArrayItem{ key: none, val: var_attrs }, rt.ArrayItem{ key: none, val: var_started_at }, rt.ArrayItem{ key: none, val: var_length }])
	}
	if rt.is_true(var_is_closer) {
		return rt.create_array([rt.ArrayItem{ key: none, val: 'block-closer' }, rt.ArrayItem{ key: none, val: var_name }, rt.ArrayItem{ key: none, val: rt.new_null() }, rt.ArrayItem{ key: none, val: var_started_at }, rt.ArrayItem{ key: none, val: var_length }])
	}
	return rt.create_array([rt.ArrayItem{ key: none, val: 'block-opener' }, rt.ArrayItem{ key: none, val: var_name }, rt.ArrayItem{ key: none, val: var_attrs }, rt.ArrayItem{ key: none, val: var_started_at }, rt.ArrayItem{ key: none, val: var_length }])
}

fn (mut this Class_WP_Block_Parser) freeform(var_inner_html rt.PhpVal) rt.PhpVal {
	return create_wp_block_parser_block(rt.new_null(), rt.new_array(), rt.new_array(), var_inner_html.dup(), rt.create_array([rt.ArrayItem{ key: none, val: var_inner_html }]))
}

fn (mut this Class_WP_Block_Parser) add_freeform(var_length rt.PhpVal)  {
	mut var_length_mutated := var_length
	var_length_mutated = if rt.is_true(var_length_mutated) { var_length_mutated } else { this.document.to_string().len - this.offset }
	if rt.is_true(rt.identical(rt.new_int(0), var_length_mutated)) {
		return rt.new_null()
	}
	this.output.array_push(rt.cast_array(this.freeform(rt.call_function('substr', [this.document, this.offset, var_length_mutated.dup()]))))
}

fn (mut this Class_WP_Block_Parser) add_inner_block(mut var_block Class_WP_Block_Parser_Block, var_token_start rt.PhpVal, var_token_length rt.PhpVal, var_last_offset rt.PhpVal)  {
	mut var_parent := this.stack.array_get(this.stack.array_count() - 1)
	rt.get_property(rt.get_property(var_parent, 'block'), 'innerBlocks').array_push(rt.cast_array(var_block))
	mut var_html := rt.call_function('substr', [this.document, rt.get_property(var_parent, 'prev_offset'), rt.sub(var_token_start, rt.get_property(var_parent, 'prev_offset'))])
	if !(!rt.is_true(var_html)) {
		// unsupported expression: Expr_AssignOp_Concat
		rt.get_property(rt.get_property(var_parent, 'block'), 'innerContent').array_push(var_html.dup())
	}
	rt.get_property(rt.get_property(var_parent, 'block'), 'innerContent').array_push(rt.new_null())
	rt.set_property(var_parent, 'prev_offset', if rt.is_true(var_last_offset) { var_last_offset } else { rt.add(var_token_start, var_token_length) })
}

fn (mut this Class_WP_Block_Parser) add_block_from_stack(var_end_offset rt.PhpVal)  {
	mut var_stack_top := rt.call_function('array_pop', [this.stack])
	mut var_prev_offset := rt.get_property(var_stack_top, 'prev_offset')
	mut var_html := if !(var_end_offset).is_null() { rt.call_function('substr', [this.document, var_prev_offset.dup(), rt.sub(var_end_offset, var_prev_offset)]) } else { rt.call_function('substr', [this.document, var_prev_offset.dup()]) }
	if !(!rt.is_true(var_html)) {
		// unsupported expression: Expr_AssignOp_Concat
		rt.get_property(rt.get_property(var_stack_top, 'block'), 'innerContent').array_push(var_html.dup())
	}
	if !(rt.get_property(var_stack_top, 'leading_html_start')).is_null() {
		this.output.array_push(rt.cast_array(this.freeform(rt.call_function('substr', [this.document, rt.get_property(var_stack_top, 'leading_html_start'), rt.sub(rt.get_property(var_stack_top, 'token_start'), rt.get_property(var_stack_top, 'leading_html_start'))]))))
	}
	this.output.array_push(rt.cast_array(rt.get_property(var_stack_top, 'block')))
}

struct Class_WP_Block_Parser_Block {
	rt.PhpObjectBase
}

struct Class_WP_Block_Parser_Frame {
	rt.PhpObjectBase
}

fn create_wp_block_parser() &Class_WP_Block_Parser {
	mut obj := &Class_WP_Block_Parser{
		PhpObjectBase: rt.PhpObjectBase{}
		document: rt.new_null()
		offset: i64(0)
		output: rt.new_null()
		stack: rt.new_null()
	}
	return obj
}

fn create_wp_block_parser_block() &Class_WP_Block_Parser_Block {
	mut obj := &Class_WP_Block_Parser_Block{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_block_parser_frame() &Class_WP_Block_Parser_Frame {
	mut obj := &Class_WP_Block_Parser_Frame{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Block_Parser) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'parse' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.parse(dispatch_arg_0)
		}
		'proceed' {
			this.proceed()
			return rt.new_null()
		}
		'next_token' {
			return this.next_token()
		}
		'freeform' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.freeform(dispatch_arg_0)
		}
		'add_freeform' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.add_freeform(dispatch_arg_0)
			return rt.new_null()
		}
		'add_inner_block' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WP_Block_Parser_Block](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			this.add_inner_block(mut dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
			return rt.new_null()
		}
		'add_block_from_stack' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.add_block_from_stack(dispatch_arg_0)
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_WP_Block_Parser) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'document' { return this.document }
		'offset' { return rt.new_int(this.offset) }
		'output' { return this.output }
		'stack' { return this.stack }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_Block_Parser) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'document' { this.document = val; return true }
		'offset' { this.offset = (val).to_i64(); return true }
		'output' { this.output = val; return true }
		'stack' { this.stack = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_WP_Block_Parser_Block) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Block_Parser_Block) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Block_Parser_Block) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_Block_Parser_Frame) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Block_Parser_Frame) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Block_Parser_Frame) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_includes_class_wp_block_parser_php() {
	rt.include_file(@DIR + '/class-wp-block-parser-block.php', '4')
	rt.include_file(@DIR + '/class-wp-block-parser-frame.php', '4')
}
