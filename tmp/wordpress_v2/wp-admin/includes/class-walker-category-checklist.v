import rt

struct Class_Walker_Category_Checklist {
	rt.PhpObjectBase
pub mut:
	tree_type rt.PhpVal = rt.new_string('category')
	db_fields rt.PhpVal = rt.new_array()
}

fn (mut this Class_Walker_Category_Checklist) start_lvl(var_output rt.PhpVal, depth i64, var_args rt.PhpVal) {
	mut var_args_mutated := var_args
	mut var_indent := rt.call_function('str_repeat', [rt.new_string('\t'),
		rt.new_int(depth)])
	var_output = rt.concat(var_output,
		rt.new_string("${var_indent.to_string()}<ul class='children'>\n"))
}

fn (mut this Class_Walker_Category_Checklist) end_lvl(var_output rt.PhpVal, depth i64, var_args rt.PhpVal) {
	mut var_args_mutated := var_args
	mut var_indent := rt.call_function('str_repeat', [rt.new_string('\t'),
		rt.new_int(depth)])
	var_output = rt.concat(var_output, rt.new_string('${var_indent.to_string()}</ul>\n'))
}

fn (mut this Class_Walker_Category_Checklist) start_el(var_output rt.PhpVal, var_data_object rt.PhpVal, depth i64, var_args rt.PhpVal, current_object_id i64) {
	mut var_args_mutated := var_args
	mut var_category := var_data_object
	if !rt.is_true(var_args_mutated.array_get(rt.new_string('taxonomy'))) {
		mut var_taxonomy := rt.new_string('category')
	} else {
		var_taxonomy = var_args_mutated.array_get(rt.new_string('taxonomy'))
	}
	if rt.is_true(rt.identical(rt.new_string('category'), var_taxonomy)) {
		mut var_name := rt.new_string('post_category')
	} else {
		var_name = rt.new_string('tax_input[' + var_taxonomy.str() + ']')
	}
	var_args_mutated.array_set('popular_cats', if !(!rt.is_true(var_args_mutated.array_get(rt.new_string('popular_cats')))) { rt.call_function('array_map', [
			rt.new_string('intval'),
			var_args_mutated.array_get(rt.new_string('popular_cats')),
		]) } else { rt.new_array() })
	mut var_class := rt.new_string((if rt.is_true(rt.call_function('in_array', [
		rt.get_property(var_category, 'term_id'),
		var_args_mutated.array_get(rt.new_string('popular_cats')),
		rt.new_bool(true),
	]))
	{ ' class="popular-category"' } else { '' }).str())
	var_args_mutated.array_set('selected_cats', if !(!rt.is_true(var_args_mutated.array_get(rt.new_string('selected_cats')))) { rt.call_function('array_map', [
			rt.new_string('intval'),
			var_args_mutated.array_get(rt.new_string('selected_cats')),
		]) } else { rt.new_array() })
	if !(!rt.is_true(var_args_mutated.array_get(rt.new_string('list_only')))) {
		mut var_aria_checked := rt.new_string('false')
		mut var_inner_class := rt.new_string('category')
		if rt.is_true(rt.call_function('in_array', [
			rt.get_property(var_category, 'term_id'),
			var_args_mutated.array_get(rt.new_string('selected_cats')),
			rt.new_bool(true),
		]))
		{
			var_inner_class = rt.concat(var_inner_class, rt.new_string(' selected'))
			var_aria_checked = rt.new_string('true')
		}
		var_output = rt.concat(var_output, rt.new_string('\n' + '<li' + var_class.str() + '>' +
			'<div class="' + var_inner_class.str() + '" data-term-id=' +
			(rt.get_property(var_category, 'term_id')).str() +
			' tabindex="0" role="checkbox" aria-checked="' + var_aria_checked.str() + '">' +
			(rt.call_function('esc_html', [rt.call_function('apply_filters', [rt.new_string('the_category'), rt.get_property(var_category, 'name'), rt.new_string(''), rt.new_string('')])])).str() +
			'</div>'))
	} else {
		mut var_is_selected := rt.call_function('in_array', [
			rt.get_property(var_category, 'term_id'),
			var_args_mutated.array_get(rt.new_string('selected_cats')),
			rt.new_bool(true),
		])
		mut var_is_disabled :=
			rt.new_bool(!(!rt.is_true(var_args_mutated.array_get(rt.new_string('disabled')))))
		mut var_li_element_id := rt.call_function('wp_unique_prefixed_id', [
			rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('in-'), var_taxonomy),
				rt.new_string('-')), rt.get_property(var_category, 'term_id')), rt.new_string('-')),
		])
		mut var_checkbox_element_id := rt.call_function('wp_unique_prefixed_id', [
			rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('in-'), var_taxonomy),
				rt.new_string('-')), rt.get_property(var_category, 'term_id')), rt.new_string('-')),
		])
		var_output = rt.concat(var_output, rt.new_string("\n<li id='" +
			(rt.call_function('esc_attr', [var_li_element_id.clone()])).str() +
			"'${var_class.to_string()}>" + '<label class="selectit"><input value="' +
			(rt.get_property(var_category, 'term_id')).str() + '" type="checkbox" name="' +
			var_name.str() + '[]" id="' +
			(rt.call_function('esc_attr', [var_checkbox_element_id.clone()])).str() + '"' +
			(rt.call_function('checked', [var_is_selected.clone(), rt.new_bool(true), rt.new_bool(false)])).str() +
			(rt.call_function('disabled', [var_is_disabled.clone(), rt.new_bool(true), rt.new_bool(false)])).str() +
			' /> ' +
			(rt.call_function('esc_html', [rt.call_function('apply_filters', [rt.new_string('the_category'), rt.get_property(var_category, 'name'), rt.new_string(''), rt.new_string('')])])).str() +
			'</label>'))
	}
}

fn (mut this Class_Walker_Category_Checklist) end_el(var_output rt.PhpVal, var_data_object rt.PhpVal, depth i64, var_args rt.PhpVal) {
	mut var_args_mutated := var_args
	var_output = rt.concat(var_output, rt.new_string('</li>\n'))
}

struct Class_Walker {
	rt.PhpObjectBase
}

fn create_walker_category_checklist(_args ...rt.PhpVal) &Class_Walker_Category_Checklist {
	mut obj := &Class_Walker_Category_Checklist{
		PhpObjectBase: rt.PhpObjectBase{}
		tree_type:     rt.new_string('category')
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

fn (mut this Class_Walker_Category_Checklist) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
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
			this.start_el(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3,
				dispatch_arg_4)
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
		else {
			return none
		}
	}
}

fn (this &Class_Walker_Category_Checklist) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'tree_type' { return this.tree_type }
		'db_fields' { return this.db_fields }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Walker_Category_Checklist) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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
