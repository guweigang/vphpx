import rt

struct Class_Walker_PageDropdown {
	rt.PhpObjectBase
pub mut:
	tree_type rt.PhpVal = rt.new_string('page')
	db_fields rt.PhpVal = rt.new_array()
}

fn (mut this Class_Walker_PageDropdown) start_el(var_output rt.PhpVal, var_data_object rt.PhpVal, depth i64, var_args rt.PhpVal, current_object_id i64) {
	mut var_args_mutated := var_args
	mut var_page := var_data_object
	mut var_pad := rt.call_function('str_repeat', [rt.new_string('&nbsp;'),
		rt.new_int(depth * 3)])
	if !(var_args_mutated.array_isset(rt.new_string('value_field')))
		|| !(!(rt.get_property(var_page, '{"nodeType":"Expr_ArrayDimFetch","line":68,"var":{"nodeType":"Expr_Variable","line":68,"name":"args"},"dim":{"nodeType":"Scalar_String","line":68,"value":"value_field"}}')).is_null()) {
		var_args_mutated.array_set('value_field', 'ID')
	}
	var_output = rt.concat(var_output, rt.new_string(
		"\t<option class=\"level-${var_depth.str()}\" value=\"" +
		(rt.call_function('esc_attr', [rt.get_property(var_page, '{"nodeType":"Expr_ArrayDimFetch","line":72,"var":{"nodeType":"Expr_Variable","line":72,"name":"args"},"dim":{"nodeType":"Scalar_String","line":72,"value":"value_field"}}')])).str() +
		'"'))
	if rt.is_true(rt.identical(rt.get_property(var_page, 'ID'),
		rt.new_int((var_args_mutated.array_get(rt.new_string('selected'))).to_i64())))
	{
		var_output = rt.concat(var_output, rt.new_string(' selected="selected"'))
	}
	var_output = rt.concat(var_output, rt.new_string('>'))
	mut var_title := rt.get_property(var_page, 'post_title')
	if rt.is_true(rt.identical(rt.new_string(''), var_title)) {
		var_title = rt.call_function('sprintf', [
			rt.call_function('__', [rt.new_string('#%d (no title)')]),
			rt.get_property(var_page, 'ID'),
		])
	}
	var_title = rt.call_function('apply_filters', [rt.new_string('list_pages'),
		var_title.clone(), var_page.clone()])
	var_output = rt.concat(var_output, rt.new_string(var_pad.str() +
		(rt.call_function('esc_html', [var_title.clone()])).str()))
	var_output = rt.concat(var_output, rt.new_string('</option>\n'))
}

struct Class_Walker {
	rt.PhpObjectBase
}

fn create_walker_pagedropdown(_args ...rt.PhpVal) &Class_Walker_PageDropdown {
	mut obj := &Class_Walker_PageDropdown{
		PhpObjectBase: rt.PhpObjectBase{}
		tree_type:     rt.new_string('page')
		db_fields:     rt.new_array()
	}
	return obj
}

fn create_walker(_args ...rt.PhpVal) &Class_Walker {
	mut obj := &Class_Walker{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Walker_PageDropdown) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'start_el' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_i64()
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			dispatch_arg_4 := (if args.len > 4 { args[4] } else { rt.new_null() }).to_i64()
			this.start_el(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3,
				dispatch_arg_4)
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Walker_PageDropdown) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'tree_type' { return this.tree_type }
		'db_fields' { return this.db_fields }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Walker_PageDropdown) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'tree_type' {
			this.tree_type = val
			return true
		}
		'db_fields' {
			this.db_fields = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
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

fn main() {
	defer {
		rt.shutdown()
	}
}
