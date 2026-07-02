import rt

struct Class_WP_HTML_Active_Formatting_Elements {
	rt.PhpObjectBase
pub mut:
	stack rt.PhpVal = rt.new_array()
}

fn (mut this Class_WP_HTML_Active_Formatting_Elements) contains_node(mut var_token Class_WP_HTML_Token) bool {
	mut iter_1 := this.walk_up().iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_item := item_1.val
		if rt.is_true(rt.identical(rt.get_property(var_token, 'bookmark_name'), rt.get_property(var_item,
			'bookmark_name')))
		{
			return true
		}
	}
	return false
}

fn (mut this Class_WP_HTML_Active_Formatting_Elements) count() i64 {
	return this.stack.array_count()
}

fn (mut this Class_WP_HTML_Active_Formatting_Elements) current_node() rt.PhpVal {
	mut var_current_node := rt.call_function('end', [this.stack])
	return if rt.is_true(var_current_node) { var_current_node } else { rt.new_null() }
}

fn (mut this Class_WP_HTML_Active_Formatting_Elements) insert_marker() {
	this.push(mut rt.cast_object_ptr[Class_WP_HTML_Token](create_wp_html_token(rt.new_null(),
		rt.new_string('marker'), rt.new_bool(false))))
}

fn (mut this Class_WP_HTML_Active_Formatting_Elements) push(mut var_token Class_WP_HTML_Token) {
	this.stack.array_push(var_token)
}

fn (mut this Class_WP_HTML_Active_Formatting_Elements) remove_node(mut var_token Class_WP_HTML_Token) bool {
	mut iter_2 := this.walk_up().iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_item := item_2.val
		mut var_position_from_end := item_2.key
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.get_property(var_token,
			'bookmark_name'), rt.get_property(var_item, 'bookmark_name')))))
		{
			continue
		}
		mut var_position_from_start := rt.sub(rt.sub(this.count(), var_position_from_end),
			rt.new_int(1))
		rt.call_function('array_splice', [this.stack, var_position_from_start.clone(),
			rt.new_int(1)])
		return true
	}
	return false
}

fn (mut this Class_WP_HTML_Active_Formatting_Elements) walk_down() {
	mut var_count := rt.new_int(this.stack.array_count())
	mut var_i := rt.new_int(0)
	for {
		if !(rt.is_true(rt.less(var_i, var_count))) { break
		 }
		rt.new_null()
		rt.post_inc(var_i)
	}
}

fn (mut this Class_WP_HTML_Active_Formatting_Elements) walk_up() {
	mut var_i := rt.new_int(this.stack.array_count() - 1)
	for {
		if !(rt.is_true(rt.greater_equal(var_i, rt.new_int(0)))) { break
		 }
		rt.new_null()
		rt.post_dec(var_i)
	}
}

fn (mut this Class_WP_HTML_Active_Formatting_Elements) clear_up_to_last_marker() {
	mut iter_3 := this.walk_up().iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_item := item_3.val
		rt.call_function('array_pop', [this.stack])
		if rt.is_true(rt.identical(rt.new_string('marker'), rt.get_property(var_item, 'node_name'))) {
			break
		}
	}
}

struct Class_WP_HTML_Token {
	rt.PhpObjectBase
}

fn create_wp_html_active_formatting_elements(_args ...rt.PhpVal) &Class_WP_HTML_Active_Formatting_Elements {
	mut obj := &Class_WP_HTML_Active_Formatting_Elements{
		PhpObjectBase: rt.PhpObjectBase{}
		stack:         rt.new_array()
	}
	return obj
}

fn create_wp_html_token(_args ...rt.PhpVal) &Class_WP_HTML_Token {
	mut obj := &Class_WP_HTML_Token{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_HTML_Active_Formatting_Elements) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'contains_node' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WP_HTML_Token](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return rt.new_bool(this.contains_node(mut dispatch_arg_0))
		}
		'count' {
			return rt.new_int(this.count())
		}
		'current_node' {
			return this.current_node()
		}
		'insert_marker' {
			this.insert_marker()
			return rt.new_null()
		}
		'push' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WP_HTML_Token](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.push(mut dispatch_arg_0)
			return rt.new_null()
		}
		'remove_node' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WP_HTML_Token](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return rt.new_bool(this.remove_node(mut dispatch_arg_0))
		}
		'walk_down' {
			this.walk_down()
			return rt.new_null()
		}
		'walk_up' {
			this.walk_up()
			return rt.new_null()
		}
		'clear_up_to_last_marker' {
			this.clear_up_to_last_marker()
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WP_HTML_Active_Formatting_Elements) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'stack' { return this.stack }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_HTML_Active_Formatting_Elements) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'stack' {
			this.stack = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_WP_HTML_Token) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_HTML_Token) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_HTML_Token) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
