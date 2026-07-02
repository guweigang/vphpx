import rt

struct Class_WP_HTML_Open_Elements {
	rt.PhpObjectBase
pub mut:
		stack rt.PhpVal = rt.new_array()
		has_p_in_button_scope rt.PhpVal = rt.new_bool(false)
		pop_handler rt.PhpVal = rt.new_null()
		push_handler rt.PhpVal = rt.new_null()
}

fn (mut this Class_WP_HTML_Open_Elements) set_pop_handler(mut var_handler Class_Closure) {
	this.pop_handler = var_handler
}

fn (mut this Class_WP_HTML_Open_Elements) set_push_handler(mut var_handler Class_Closure) {
	this.push_handler = var_handler
}

fn (mut this Class_WP_HTML_Open_Elements) at(nth i64) rt.PhpVal {
	mut iter_1 := this.walk_down().iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_item := item_1.val
		if rt.is_true(rt.identical(rt.new_int(0), rt.pre_dec(rt.new_int(nth)))) {
			return var_item.clone()
		}
	}
	return rt.new_null()
}

fn (mut this Class_WP_HTML_Open_Elements) contains(node_name string) bool {
	mut iter_2 := this.walk_up(rt.new_null()).iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_item := item_2.val
		if rt.is_true(rt.identical(rt.new_string(node_name), rt.get_property(var_item, 'node_name'))) {
			return true
		}
	}
	return false
}

fn (mut this Class_WP_HTML_Open_Elements) contains_node(mut var_token Class_WP_HTML_Token) bool {
	mut iter_3 := this.walk_up(rt.new_null()).iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_item := item_3.val
		if rt.is_true(rt.identical(var_token, var_item)) {
			return true
		}
	}
	return false
}

fn (mut this Class_WP_HTML_Open_Elements) count() i64 {
	return this.stack.array_count()
}

fn (mut this Class_WP_HTML_Open_Elements) current_node() rt.PhpVal {
	mut var_current_node := rt.call_function('end', [this.stack])
	return if rt.is_true(var_current_node) { var_current_node } else { rt.new_null() }
}

fn (mut this Class_WP_HTML_Open_Elements) current_node_is(identity string) bool {
	mut var_current_node := rt.call_function('end', [this.stack])
	if rt.is_true(rt.identical(rt.new_bool(false), var_current_node)) {
		return false
	}
	mut var_current_node_name := rt.get_property(var_current_node, 'node_name')
	return rt.is_true(rt.identical(var_current_node_name, rt.new_string(identity))) || (rt.is_true(rt.identical(rt.new_string('#doctype'), rt.new_string(identity))) && rt.is_true(rt.identical(rt.new_string('html'), var_current_node_name))) || rt.is_true(rt.identical(rt.new_string('#tag'), rt.new_string(identity))) && rt.is_true(rt.call_function('ctype_upper', [var_current_node_name.clone()]))
}

fn (mut this Class_WP_HTML_Open_Elements) has_element_in_specific_scope(tag_name string, var_termination_list rt.PhpVal) bool {
	mut iter_4 := this.walk_up(rt.new_null()).iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_node := item_4.val
		mut var_namespaced_name := if rt.is_true(rt.identical(rt.new_string('html'), rt.get_property(var_node, 'namespace'))) { rt.get_property(var_node, 'node_name') } else { rt.concat(rt.concat(rt.get_property(var_node, 'namespace'), rt.new_string(' ')), rt.get_property(var_node, 'node_name')) }
		if rt.is_true(rt.identical(var_namespaced_name, rt.new_string(tag_name))) {
			return true
		}
		if rt.is_true(rt.identical(rt.new_string('(internal: H1 through H6 - do not use)'), rt.new_string(tag_name))) && rt.is_true(rt.call_function('in_array', [var_namespaced_name.clone(), rt.create_array([rt.ArrayItem{ key: none, val: 'H1' }, rt.ArrayItem{ key: none, val: 'H2' }, rt.ArrayItem{ key: none, val: 'H3' }, rt.ArrayItem{ key: none, val: 'H4' }, rt.ArrayItem{ key: none, val: 'H5' }, rt.ArrayItem{ key: none, val: 'H6' }]), rt.new_bool(true)])) {
			return true
		}
		if rt.is_true(rt.call_function('in_array', [var_namespaced_name.clone(), var_termination_list.clone(), rt.new_bool(true)])) {
			return false
		}
	}
	return false
}

fn (mut this Class_WP_HTML_Open_Elements) has_element_in_scope(tag_name string) bool {
	return this.has_element_in_specific_scope(tag_name, rt.create_array([rt.ArrayItem{ key: none, val: 'APPLET' }, rt.ArrayItem{ key: none, val: 'CAPTION' }, rt.ArrayItem{ key: none, val: 'HTML' }, rt.ArrayItem{ key: none, val: 'TABLE' }, rt.ArrayItem{ key: none, val: 'TD' }, rt.ArrayItem{ key: none, val: 'TH' }, rt.ArrayItem{ key: none, val: 'MARQUEE' }, rt.ArrayItem{ key: none, val: 'OBJECT' }, rt.ArrayItem{ key: none, val: 'TEMPLATE' }, rt.ArrayItem{ key: none, val: 'math MI' }, rt.ArrayItem{ key: none, val: 'math MO' }, rt.ArrayItem{ key: none, val: 'math MN' }, rt.ArrayItem{ key: none, val: 'math MS' }, rt.ArrayItem{ key: none, val: 'math MTEXT' }, rt.ArrayItem{ key: none, val: 'math ANNOTATION-XML' }, rt.ArrayItem{ key: none, val: 'svg FOREIGNOBJECT' }, rt.ArrayItem{ key: none, val: 'svg DESC' }, rt.ArrayItem{ key: none, val: 'svg TITLE' }]))
}

fn (mut this Class_WP_HTML_Open_Elements) has_element_in_list_item_scope(tag_name string) bool {
	return this.has_element_in_specific_scope(tag_name, rt.create_array([rt.ArrayItem{ key: none, val: 'APPLET' }, rt.ArrayItem{ key: none, val: 'BUTTON' }, rt.ArrayItem{ key: none, val: 'CAPTION' }, rt.ArrayItem{ key: none, val: 'HTML' }, rt.ArrayItem{ key: none, val: 'TABLE' }, rt.ArrayItem{ key: none, val: 'TD' }, rt.ArrayItem{ key: none, val: 'TH' }, rt.ArrayItem{ key: none, val: 'MARQUEE' }, rt.ArrayItem{ key: none, val: 'OBJECT' }, rt.ArrayItem{ key: none, val: 'OL' }, rt.ArrayItem{ key: none, val: 'TEMPLATE' }, rt.ArrayItem{ key: none, val: 'UL' }, rt.ArrayItem{ key: none, val: 'math MI' }, rt.ArrayItem{ key: none, val: 'math MO' }, rt.ArrayItem{ key: none, val: 'math MN' }, rt.ArrayItem{ key: none, val: 'math MS' }, rt.ArrayItem{ key: none, val: 'math MTEXT' }, rt.ArrayItem{ key: none, val: 'math ANNOTATION-XML' }, rt.ArrayItem{ key: none, val: 'svg FOREIGNOBJECT' }, rt.ArrayItem{ key: none, val: 'svg DESC' }, rt.ArrayItem{ key: none, val: 'svg TITLE' }]))
}

fn (mut this Class_WP_HTML_Open_Elements) has_element_in_button_scope(tag_name string) bool {
	return this.has_element_in_specific_scope(tag_name, rt.create_array([rt.ArrayItem{ key: none, val: 'APPLET' }, rt.ArrayItem{ key: none, val: 'BUTTON' }, rt.ArrayItem{ key: none, val: 'CAPTION' }, rt.ArrayItem{ key: none, val: 'HTML' }, rt.ArrayItem{ key: none, val: 'TABLE' }, rt.ArrayItem{ key: none, val: 'TD' }, rt.ArrayItem{ key: none, val: 'TH' }, rt.ArrayItem{ key: none, val: 'MARQUEE' }, rt.ArrayItem{ key: none, val: 'OBJECT' }, rt.ArrayItem{ key: none, val: 'TEMPLATE' }, rt.ArrayItem{ key: none, val: 'math MI' }, rt.ArrayItem{ key: none, val: 'math MO' }, rt.ArrayItem{ key: none, val: 'math MN' }, rt.ArrayItem{ key: none, val: 'math MS' }, rt.ArrayItem{ key: none, val: 'math MTEXT' }, rt.ArrayItem{ key: none, val: 'math ANNOTATION-XML' }, rt.ArrayItem{ key: none, val: 'svg FOREIGNOBJECT' }, rt.ArrayItem{ key: none, val: 'svg DESC' }, rt.ArrayItem{ key: none, val: 'svg TITLE' }]))
}

fn (mut this Class_WP_HTML_Open_Elements) has_element_in_table_scope(tag_name string) bool {
	return this.has_element_in_specific_scope(tag_name, rt.create_array([rt.ArrayItem{ key: none, val: 'HTML' }, rt.ArrayItem{ key: none, val: 'TABLE' }, rt.ArrayItem{ key: none, val: 'TEMPLATE' }]))
}

fn (mut this Class_WP_HTML_Open_Elements) has_element_in_select_scope(tag_name string) bool {
	mut iter_5 := this.walk_up(rt.new_null()).iterator()
	for {
		item_5 := iter_5.next() or { break }
		mut var_node := item_5.val
		if rt.is_true(rt.identical(rt.get_property(var_node, 'node_name'), rt.new_string(tag_name))) {
			return true
		}
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('OPTION'), rt.get_property(var_node, 'node_name'))))) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('OPTGROUP'), rt.get_property(var_node, 'node_name'))))) {
			return false
		}
	}
	return false
}

fn (mut this Class_WP_HTML_Open_Elements) has_p_in_button_scope() bool {
	return (this.has_p_in_button_scope).to_bool()
}

fn (mut this Class_WP_HTML_Open_Elements) pop() bool {
	mut var_item := rt.call_function('array_pop', [this.stack])
	if rt.is_true(rt.identical(rt.new_null(), var_item)) {
		return false
	}
	this.after_element_pop(mut rt.cast_object_ptr[Class_WP_HTML_Token](var_item))
	return true
}

fn (mut this Class_WP_HTML_Open_Elements) pop_until(html_tag_name string) bool {
	mut iter_6 := this.walk_up(rt.new_null()).iterator()
	for {
		item_6 := iter_6.next() or { break }
		mut var_item := item_6.val
		this.pop()
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('html'), rt.get_property(var_item, 'namespace'))))) {
			continue
		}
		if rt.is_true(rt.identical(rt.new_string('(internal: H1 through H6 - do not use)'), rt.new_string(html_tag_name))) && rt.is_true(rt.call_function('in_array', [rt.get_property(var_item, 'node_name'), rt.create_array([rt.ArrayItem{ key: none, val: 'H1' }, rt.ArrayItem{ key: none, val: 'H2' }, rt.ArrayItem{ key: none, val: 'H3' }, rt.ArrayItem{ key: none, val: 'H4' }, rt.ArrayItem{ key: none, val: 'H5' }, rt.ArrayItem{ key: none, val: 'H6' }]), rt.new_bool(true)])) {
			return true
		}
		if rt.is_true(rt.identical(rt.new_string(html_tag_name), rt.get_property(var_item, 'node_name'))) {
			return true
		}
	}
	return false
}

fn (mut this Class_WP_HTML_Open_Elements) push(mut var_stack_item Class_WP_HTML_Token) {
	this.stack.array_push(var_stack_item)
	this.after_element_push(mut var_stack_item)
}

fn (mut this Class_WP_HTML_Open_Elements) remove_node(mut var_token Class_WP_HTML_Token) bool {
	mut iter_7 := this.walk_up(rt.new_null()).iterator()
	for {
		item_7 := iter_7.next() or { break }
		mut var_item := item_7.val
		mut var_position_from_end := item_7.key
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.get_property(var_token, 'bookmark_name'), rt.get_property(var_item, 'bookmark_name'))))) {
			continue
		}
		mut var_position_from_start := rt.sub(rt.sub(this.count(), var_position_from_end), rt.new_int(1))
		rt.call_function('array_splice', [this.stack, var_position_from_start.clone(), rt.new_int(1)])
		this.after_element_pop(mut rt.cast_object_ptr[Class_WP_HTML_Token](var_item))
		return true
	}
	return false
}

fn (mut this Class_WP_HTML_Open_Elements) walk_down() {
	mut var_count := rt.new_int(this.stack.array_count())
	mut var_i := rt.new_int(0)
	for {
		if !(rt.is_true(rt.less(var_i, var_count))) { break }
		rt.new_null()
		rt.post_inc(var_i)
	}
}

fn (mut this Class_WP_HTML_Open_Elements) walk_up(mut var_above_this_node Class_?WP_HTML_Token) {
	mut var_has_found_node := rt.identical(rt.new_null(), var_above_this_node)
	mut var_i := rt.new_int(this.stack.array_count() - 1)
	for {
		if !(rt.is_true(rt.greater_equal(var_i, rt.new_int(0)))) { break }
		mut var_node := this.stack.array_get(var_i)
		if rt.is_true(rt.new_bool(!(rt.is_true(var_has_found_node)))) {
			var_has_found_node = rt.identical(var_node, var_above_this_node)
			continue
		}
		rt.new_null()
		rt.post_dec(var_i)
	}
}

fn (mut this Class_WP_HTML_Open_Elements) after_element_push(mut var_item Class_WP_HTML_Token) {
	mut var_item_mutated := var_item
	mut var_namespaced_name := if rt.is_true(rt.identical(rt.new_string('html'), rt.get_property(var_item_mutated, 'namespace'))) { rt.get_property(var_item_mutated, 'node_name') } else { rt.concat(rt.concat(rt.get_property(var_item_mutated, 'namespace'), rt.new_string(' ')), rt.get_property(var_item_mutated, 'node_name')) }
	mut switch_val_1 := var_namespaced_name
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('APPLET'))) || rt.is_true(rt.equal(switch_val_1, rt.new_string('BUTTON'))) || rt.is_true(rt.equal(switch_val_1, rt.new_string('CAPTION'))) || rt.is_true(rt.equal(switch_val_1, rt.new_string('HTML'))) || rt.is_true(rt.equal(switch_val_1, rt.new_string('TABLE'))) || rt.is_true(rt.equal(switch_val_1, rt.new_string('TD'))) || rt.is_true(rt.equal(switch_val_1, rt.new_string('TH'))) || rt.is_true(rt.equal(switch_val_1, rt.new_string('MARQUEE'))) || rt.is_true(rt.equal(switch_val_1, rt.new_string('OBJECT'))) || rt.is_true(rt.equal(switch_val_1, rt.new_string('TEMPLATE'))) || rt.is_true(rt.equal(switch_val_1, rt.new_string('math MI'))) || rt.is_true(rt.equal(switch_val_1, rt.new_string('math MO'))) || rt.is_true(rt.equal(switch_val_1, rt.new_string('math MN'))) || rt.is_true(rt.equal(switch_val_1, rt.new_string('math MS'))) || rt.is_true(rt.equal(switch_val_1, rt.new_string('math MTEXT'))) || rt.is_true(rt.equal(switch_val_1, rt.new_string('math ANNOTATION-XML'))) || rt.is_true(rt.equal(switch_val_1, rt.new_string('svg FOREIGNOBJECT'))) || rt.is_true(rt.equal(switch_val_1, rt.new_string('svg DESC'))) || rt.is_true(rt.equal(switch_val_1, rt.new_string('svg TITLE'))) {
		this.has_p_in_button_scope = rt.new_bool(false)
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('P'))) {
		this.has_p_in_button_scope = rt.new_bool(true)
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), this.push_handler)))) {
		rt.call_function('call_user_func', [this.push_handler, var_item_mutated])
	}
}

fn (mut this Class_WP_HTML_Open_Elements) after_element_pop(mut var_item Class_WP_HTML_Token) {
	mut var_item_mutated := var_item
	mut switch_val_2 := rt.get_property(var_item_mutated, 'node_name')
	if rt.is_true(rt.equal(switch_val_2, rt.new_string('APPLET'))) || rt.is_true(rt.equal(switch_val_2, rt.new_string('BUTTON'))) || rt.is_true(rt.equal(switch_val_2, rt.new_string('CAPTION'))) || rt.is_true(rt.equal(switch_val_2, rt.new_string('HTML'))) || rt.is_true(rt.equal(switch_val_2, rt.new_string('P'))) || rt.is_true(rt.equal(switch_val_2, rt.new_string('TABLE'))) || rt.is_true(rt.equal(switch_val_2, rt.new_string('TD'))) || rt.is_true(rt.equal(switch_val_2, rt.new_string('TH'))) || rt.is_true(rt.equal(switch_val_2, rt.new_string('MARQUEE'))) || rt.is_true(rt.equal(switch_val_2, rt.new_string('OBJECT'))) || rt.is_true(rt.equal(switch_val_2, rt.new_string('TEMPLATE'))) || rt.is_true(rt.equal(switch_val_2, rt.new_string('math MI'))) || rt.is_true(rt.equal(switch_val_2, rt.new_string('math MO'))) || rt.is_true(rt.equal(switch_val_2, rt.new_string('math MN'))) || rt.is_true(rt.equal(switch_val_2, rt.new_string('math MS'))) || rt.is_true(rt.equal(switch_val_2, rt.new_string('math MTEXT'))) || rt.is_true(rt.equal(switch_val_2, rt.new_string('math ANNOTATION-XML'))) || rt.is_true(rt.equal(switch_val_2, rt.new_string('svg FOREIGNOBJECT'))) || rt.is_true(rt.equal(switch_val_2, rt.new_string('svg DESC'))) || rt.is_true(rt.equal(switch_val_2, rt.new_string('svg TITLE'))) {
		this.has_p_in_button_scope = this.has_element_in_button_scope('P')
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), this.pop_handler)))) {
		rt.call_function('call_user_func', [this.pop_handler, var_item_mutated])
	}
}

fn (mut this Class_WP_HTML_Open_Elements) clear_to_table_context() {
	mut iter_8 := this.walk_up(rt.new_null()).iterator()
	for {
		item_8 := iter_8.next() or { break }
		mut var_item := item_8.val
		if rt.is_true(rt.identical(rt.new_string('TABLE'), rt.get_property(var_item, 'node_name'))) || rt.is_true(rt.identical(rt.new_string('TEMPLATE'), rt.get_property(var_item, 'node_name'))) || rt.is_true(rt.identical(rt.new_string('HTML'), rt.get_property(var_item, 'node_name'))) {
			break
		}
		this.pop()
	}
}

fn (mut this Class_WP_HTML_Open_Elements) clear_to_table_body_context() {
	mut iter_9 := this.walk_up(rt.new_null()).iterator()
	for {
		item_9 := iter_9.next() or { break }
		mut var_item := item_9.val
		if rt.is_true(rt.identical(rt.new_string('TBODY'), rt.get_property(var_item, 'node_name'))) || rt.is_true(rt.identical(rt.new_string('TFOOT'), rt.get_property(var_item, 'node_name'))) || rt.is_true(rt.identical(rt.new_string('THEAD'), rt.get_property(var_item, 'node_name'))) || rt.is_true(rt.identical(rt.new_string('TEMPLATE'), rt.get_property(var_item, 'node_name'))) || rt.is_true(rt.identical(rt.new_string('HTML'), rt.get_property(var_item, 'node_name'))) {
			break
		}
		this.pop()
	}
}

fn (mut this Class_WP_HTML_Open_Elements) clear_to_table_row_context() {
	mut iter_10 := this.walk_up(rt.new_null()).iterator()
	for {
		item_10 := iter_10.next() or { break }
		mut var_item := item_10.val
		if rt.is_true(rt.identical(rt.new_string('TR'), rt.get_property(var_item, 'node_name'))) || rt.is_true(rt.identical(rt.new_string('TEMPLATE'), rt.get_property(var_item, 'node_name'))) || rt.is_true(rt.identical(rt.new_string('HTML'), rt.get_property(var_item, 'node_name'))) {
			break
		}
		this.pop()
	}
}

fn (mut this Class_WP_HTML_Open_Elements) magic_wakeup() {
	rt.throw_exception(rt.new_object('LogicException', []string{}, create_logicexception(@STRUCT + ' should never be unserialized')))
}

struct Class_LogicException {
	rt.PhpObjectBase
}

fn create_wp_html_open_elements(_args ...rt.PhpVal) &Class_WP_HTML_Open_Elements {
	mut obj := &Class_WP_HTML_Open_Elements{
		PhpObjectBase: rt.PhpObjectBase{}
		stack: rt.new_array()
		has_p_in_button_scope: rt.new_bool(false)
		pop_handler: rt.new_null()
		push_handler: rt.new_null()
	}
	return obj
}

fn create_logicexception(_args ...rt.PhpVal) &Class_LogicException {
	mut obj := &Class_LogicException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_HTML_Open_Elements) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'set_pop_handler' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Closure](if args.len > 0 { args[0] } else { rt.new_null() })
			this.set_pop_handler(mut dispatch_arg_0)
			return rt.new_null()
		}
		'set_push_handler' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Closure](if args.len > 0 { args[0] } else { rt.new_null() })
			this.set_push_handler(mut dispatch_arg_0)
			return rt.new_null()
		}
		'at' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			return this.at(dispatch_arg_0)
		}
		'contains' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(this.contains(dispatch_arg_0))
		}
		'contains_node' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WP_HTML_Token](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_bool(this.contains_node(mut dispatch_arg_0))
		}
		'count' {
			return rt.new_int(this.count())
		}
		'current_node' {
			return this.current_node()
		}
		'current_node_is' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(this.current_node_is(dispatch_arg_0))
		}
		'has_element_in_specific_scope' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(this.has_element_in_specific_scope(dispatch_arg_0, dispatch_arg_1))
		}
		'has_element_in_scope' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(this.has_element_in_scope(dispatch_arg_0))
		}
		'has_element_in_list_item_scope' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(this.has_element_in_list_item_scope(dispatch_arg_0))
		}
		'has_element_in_button_scope' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(this.has_element_in_button_scope(dispatch_arg_0))
		}
		'has_element_in_table_scope' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(this.has_element_in_table_scope(dispatch_arg_0))
		}
		'has_element_in_select_scope' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(this.has_element_in_select_scope(dispatch_arg_0))
		}
		'has_p_in_button_scope' {
			return rt.new_bool(this.has_p_in_button_scope())
		}
		'pop' {
			return rt.new_bool(this.pop())
		}
		'pop_until' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(this.pop_until(dispatch_arg_0))
		}
		'push' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WP_HTML_Token](if args.len > 0 { args[0] } else { rt.new_null() })
			this.push(mut dispatch_arg_0)
			return rt.new_null()
		}
		'remove_node' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WP_HTML_Token](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_bool(this.remove_node(mut dispatch_arg_0))
		}
		'walk_down' {
			this.walk_down()
			return rt.new_null()
		}
		'walk_up' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_?WP_HTML_Token](if args.len > 0 { args[0] } else { rt.new_null() })
			this.walk_up(mut dispatch_arg_0)
			return rt.new_null()
		}
		'after_element_push' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WP_HTML_Token](if args.len > 0 { args[0] } else { rt.new_null() })
			this.after_element_push(mut dispatch_arg_0)
			return rt.new_null()
		}
		'after_element_pop' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WP_HTML_Token](if args.len > 0 { args[0] } else { rt.new_null() })
			this.after_element_pop(mut dispatch_arg_0)
			return rt.new_null()
		}
		'clear_to_table_context' {
			this.clear_to_table_context()
			return rt.new_null()
		}
		'clear_to_table_body_context' {
			this.clear_to_table_body_context()
			return rt.new_null()
		}
		'clear_to_table_row_context' {
			this.clear_to_table_row_context()
			return rt.new_null()
		}
		'__wakeup' {
			this.magic_wakeup()
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_WP_HTML_Open_Elements) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'stack' { return this.stack }
		'has_p_in_button_scope' { return this.has_p_in_button_scope }
		'pop_handler' { return this.pop_handler }
		'push_handler' { return this.push_handler }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_HTML_Open_Elements) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'stack' { this.stack = val; return true }
		'has_p_in_button_scope' { this.has_p_in_button_scope = val; return true }
		'pop_handler' { this.pop_handler = val; return true }
		'push_handler' { this.push_handler = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_LogicException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_LogicException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_LogicException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}



fn main() {
	defer {
		rt.shutdown()
	}

}
