import rt

struct Class_Walker_Page {
	rt.PhpObjectBase
pub mut:
		tree_type rt.PhpVal = rt.new_string('page')
		db_fields rt.PhpVal = rt.new_array()
}

fn (mut this Class_Walker_Page) start_lvl(var_output rt.PhpVal, depth i64, var_args rt.PhpVal)  {
	mut var_args_mutated := var_args
	if rt.is_true(rt.new_bool(var_args_mutated.array_isset(rt.new_string('item_spacing')) && rt.is_true(rt.identical(rt.new_string('preserve'), var_args_mutated.array_get('item_spacing'))))) {
		mut var_t := rt.new_string(rt.new_string('\t'))
		mut var_n := rt.new_string(rt.new_string('\n'))
	} else {
		var_t = rt.new_string(rt.new_string(''))
		var_n = rt.new_string(rt.new_string(''))
	}
	mut var_indent := rt.call_function('str_repeat', [var_t.dup(), rt.new_int(depth)])
	// unsupported expression: Expr_AssignOp_Concat
}

fn (mut this Class_Walker_Page) end_lvl(var_output rt.PhpVal, depth i64, var_args rt.PhpVal)  {
	mut var_args_mutated := var_args
	if rt.is_true(rt.new_bool(var_args_mutated.array_isset(rt.new_string('item_spacing')) && rt.is_true(rt.identical(rt.new_string('preserve'), var_args_mutated.array_get('item_spacing'))))) {
		mut var_t := rt.new_string(rt.new_string('\t'))
		mut var_n := rt.new_string(rt.new_string('\n'))
	} else {
		var_t = rt.new_string(rt.new_string(''))
		var_n = rt.new_string(rt.new_string(''))
	}
	mut var_indent := rt.call_function('str_repeat', [var_t.dup(), rt.new_int(depth)])
	// unsupported expression: Expr_AssignOp_Concat
}

fn (mut this Class_Walker_Page) start_el(var_output rt.PhpVal, var_data_object rt.PhpVal, depth i64, var_args rt.PhpVal, current_object_id i64)  {
	mut var_args_mutated := var_args
	mut var_page := var_data_object
	mut var_current_page_id := rt.new_int(rt.new_int(current_object_id))
	if rt.is_true(rt.new_bool(var_args_mutated.array_isset(rt.new_string('item_spacing')) && rt.is_true(rt.identical(rt.new_string('preserve'), var_args_mutated.array_get('item_spacing'))))) {
		mut var_t := rt.new_string(rt.new_string('\t'))
		mut var_n := rt.new_string(rt.new_string('\n'))
	} else {
		var_t = rt.new_string(rt.new_string(''))
		var_n = rt.new_string(rt.new_string(''))
	}
	if var_depth != 0 {
		mut var_indent := rt.call_function('str_repeat', [var_t.dup(), rt.new_int(depth)])
	} else {
		var_indent = rt.new_string(rt.new_string(''))
	}
	mut var_css_class := ['page_item', 'page-item-' + (rt.get_property(var_page, 'ID')).str()]
	if var_args_mutated.array_get('pages_with_children').array_isset(rt.get_property(var_page, 'ID')) {
		var_css_class << 'page_item_has_children'
	}
	if !(!rt.is_true(var_current_page_id)) {
		mut var__current_page := rt.call_function('get_post', [var_current_page_id.dup()])
		if rt.is_true(rt.new_bool(rt.is_true(var__current_page) && rt.is_true(rt.call_function('in_array', [rt.get_property(var_page, 'ID'), rt.get_property(var__current_page, 'ancestors'), rt.new_bool(true)])))) {
			var_css_class << 'current_page_ancestor'
		}
		if rt.is_true(rt.identical(rt.get_property(var_page, 'ID'), // unsupported expression: Expr_Cast_Int)) {
			var_css_class << 'current_page_item'
		} else if rt.is_true(rt.new_bool(rt.is_true(var__current_page) && rt.is_true(rt.identical(rt.get_property(var_page, 'ID'), rt.get_property(var__current_page, 'post_parent'))))) {
			var_css_class << 'current_page_parent'
		}
	} else if rt.is_true(rt.identical(// unsupported expression: Expr_Cast_Int, rt.get_property(var_page, 'ID'))) {
		var_css_class << 'current_page_parent'
	}
	mut var_css_classes := rt.call_function('implode', [rt.new_string(' '), rt.call_function('apply_filters', [rt.new_string('page_css_class'), var_css_class.dup(), var_page.dup(), rt.new_int(depth), var_args_mutated.dup(), var_current_page_id.dup()])])
	var_css_classes = rt.new_string(if rt.is_true(var_css_classes) { ' class="' + (rt.call_function('esc_attr', [var_css_classes.dup()])).str() + '"' } else { rt.new_string('') })
	if rt.is_true(rt.identical(rt.new_string(''), rt.get_property(var_page, 'post_title'))) {
		rt.set_property(var_page, 'post_title', rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('#%d (no title)')]), rt.get_property(var_page, 'ID')]))
	}
	var_args_mutated.array_set('link_before', if !rt.is_true(var_args_mutated.array_get('link_before')) { rt.new_string('') } else { var_args_mutated.array_get('link_before') })
	var_args_mutated.array_set('link_after', if !rt.is_true(var_args_mutated.array_get('link_after')) { rt.new_string('') } else { var_args_mutated.array_get('link_after') })
	mut var_atts := rt.new_array()
	var_atts.array_set('href', rt.call_function('get_permalink', [rt.get_property(var_page, 'ID')]))
	var_atts.array_set('aria-current', if rt.is_true(rt.identical(rt.get_property(var_page, 'ID'), // unsupported expression: Expr_Cast_Int)) { 'page' } else { '' })
	var_atts = rt.call_function('apply_filters', [rt.new_string('page_menu_link_attributes'), var_atts.dup(), var_page.dup(), rt.new_int(depth), var_args_mutated.dup(), var_current_page_id.dup()])
	mut var_attributes := rt.new_string(rt.new_string(''))
	{
		mut iter_1 := var_atts.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_value := item_1.val
			mut var_attr := item_1.key
			if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.call_function('is_scalar', [var_value.dup()])) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
				var_value = if rt.is_true(rt.identical(rt.new_string('href'), var_attr)) { rt.call_function('esc_url', [var_value.dup()]) } else { rt.call_function('esc_attr', [var_value.dup()]) }
				// unsupported expression: Expr_AssignOp_Concat
			}
		}
	}
	// unsupported expression: Expr_AssignOp_Concat
	if !(!rt.is_true(var_args_mutated.array_get('show_date'))) {
		if rt.is_true(rt.identical(rt.new_string('modified'), var_args_mutated.array_get('show_date'))) {
			mut var_time := rt.get_property(var_page, 'post_modified')
		} else {
			var_time = rt.get_property(var_page, 'post_date')
		}
		mut var_date_format := if !rt.is_true(var_args_mutated.array_get('date_format')) { rt.new_string('') } else { var_args_mutated.array_get('date_format') }
		// unsupported expression: Expr_AssignOp_Concat
	}
}

fn (mut this Class_Walker_Page) end_el(var_output rt.PhpVal, var_data_object rt.PhpVal, depth i64, var_args rt.PhpVal)  {
	mut var_args_mutated := var_args
	if rt.is_true(rt.new_bool(var_args_mutated.array_isset(rt.new_string('item_spacing')) && rt.is_true(rt.identical(rt.new_string('preserve'), var_args_mutated.array_get('item_spacing'))))) {
		mut var_t := rt.new_string(rt.new_string('\t'))
		mut var_n := rt.new_string(rt.new_string('\n'))
	} else {
		var_t = rt.new_string(rt.new_string(''))
		var_n = rt.new_string(rt.new_string(''))
	}
	// unsupported expression: Expr_AssignOp_Concat
}

struct Class_Walker {
	rt.PhpObjectBase
}

fn create_walker_page() &Class_Walker_Page {
	mut obj := &Class_Walker_Page{
		PhpObjectBase: rt.PhpObjectBase{}
		tree_type: rt.new_string('page')
		db_fields: rt.new_array()
	}
	return obj
}

fn create_walker() &Class_Walker {
	mut obj := &Class_Walker{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Walker_Page) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'start_lvl' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			this.start_lvl(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'end_lvl' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			this.end_lvl(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'start_el' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_i64()
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			dispatch_arg_4 := (if args.len > 4 { args[4] } else { rt.new_null() }).to_i64()
			this.start_el(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3, dispatch_arg_4)
			return rt.new_null()
		}
		'end_el' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_i64()
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			this.end_el(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_Walker_Page) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'tree_type' { return this.tree_type }
		'db_fields' { return this.db_fields }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Walker_Page) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'tree_type' { this.tree_type = val; return true }
		'db_fields' { this.db_fields = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Walker) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Walker) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Walker) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_includes_class_walker_page_php() {
}
