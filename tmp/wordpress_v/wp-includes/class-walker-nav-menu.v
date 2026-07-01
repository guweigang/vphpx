import rt

struct Class_Walker_Nav_Menu {
	rt.PhpObjectBase
pub mut:
		tree_type rt.PhpVal = rt.new_array()
		db_fields rt.PhpVal = rt.new_array()
		privacy_policy_url rt.PhpVal = rt.new_null()
}

fn (mut this Class_Walker_Nav_Menu) construct()  {
	this.privacy_policy_url = rt.call_function('get_privacy_policy_url', []rt.PhpVal{})
}

fn (mut this Class_Walker_Nav_Menu) start_lvl(var_output rt.PhpVal, depth i64, var_args rt.PhpVal)  {
	mut var_args_mutated := var_args
	if rt.is_true(rt.new_bool(!(rt.get_property(var_args_mutated, 'item_spacing')).is_null() && rt.is_true(rt.identical(rt.new_string('discard'), rt.get_property(var_args_mutated, 'item_spacing'))))) {
		mut var_t := rt.new_string(rt.new_string(''))
		mut var_n := rt.new_string(rt.new_string(''))
	} else {
		var_t = rt.new_string(rt.new_string('\t'))
		var_n = rt.new_string(rt.new_string('\n'))
	}
	mut var_indent := rt.call_function('str_repeat', [var_t.dup(), rt.new_int(depth)])
	mut var_classes := rt.create_array([rt.ArrayItem{ key: none, val: 'sub-menu' }])
	mut var_class_names := rt.call_function('implode', [rt.new_string(' '), rt.call_function('apply_filters', [rt.new_string('nav_menu_submenu_css_class'), var_classes.dup(), var_args_mutated.dup(), rt.new_int(depth)])])
	mut var_atts := rt.new_array()
	var_atts.array_set('class', if !(!rt.is_true(var_class_names)) { var_class_names } else { rt.new_string('') })
	var_atts = rt.call_function('apply_filters', [rt.new_string('nav_menu_submenu_attributes'), var_atts.dup(), var_args_mutated.dup(), rt.new_int(depth)])
	mut var_attributes := this.build_atts(var_atts.dup())
	// unsupported expression: Expr_AssignOp_Concat
}

fn (mut this Class_Walker_Nav_Menu) end_lvl(var_output rt.PhpVal, depth i64, var_args rt.PhpVal)  {
	mut var_args_mutated := var_args
	if rt.is_true(rt.new_bool(!(rt.get_property(var_args_mutated, 'item_spacing')).is_null() && rt.is_true(rt.identical(rt.new_string('discard'), rt.get_property(var_args_mutated, 'item_spacing'))))) {
		mut var_t := rt.new_string(rt.new_string(''))
		mut var_n := rt.new_string(rt.new_string(''))
	} else {
		var_t = rt.new_string(rt.new_string('\t'))
		var_n = rt.new_string(rt.new_string('\n'))
	}
	mut var_indent := rt.call_function('str_repeat', [var_t.dup(), rt.new_int(depth)])
	// unsupported expression: Expr_AssignOp_Concat
}

fn (mut this Class_Walker_Nav_Menu) start_el(var_output rt.PhpVal, var_data_object rt.PhpVal, depth i64, var_args rt.PhpVal, current_object_id i64)  {
	mut var_args_mutated := var_args
	mut var_menu_item := var_data_object
	if rt.is_true(rt.new_bool(!(rt.get_property(var_args_mutated, 'item_spacing')).is_null() && rt.is_true(rt.identical(rt.new_string('discard'), rt.get_property(var_args_mutated, 'item_spacing'))))) {
		mut var_t := rt.new_string(rt.new_string(''))
		mut var_n := rt.new_string(rt.new_string(''))
	} else {
		var_t = rt.new_string(rt.new_string('\t'))
		var_n = rt.new_string(rt.new_string('\n'))
	}
	mut var_indent := if var_depth != 0 { rt.call_function('str_repeat', [var_t.dup(), rt.new_int(depth)]) } else { rt.new_string('') }
	mut var_classes := if !rt.is_true(rt.get_property(var_menu_item, 'classes')) { rt.new_array() } else { rt.cast_array(rt.get_property(var_menu_item, 'classes')) }
	var_classes.array_push('menu-item-' + (rt.get_property(var_menu_item, 'ID')).str())
	var_args_mutated = rt.call_function('apply_filters', [rt.new_string('nav_menu_item_args'), var_args_mutated.dup(), var_menu_item.dup(), rt.new_int(depth)])
	mut var_class_names := rt.call_function('implode', [rt.new_string(' '), rt.call_function('apply_filters', [rt.new_string('nav_menu_css_class'), rt.call_function('array_filter', [var_classes.dup()]), var_menu_item.dup(), var_args_mutated.dup(), rt.new_int(depth)])])
	mut var_id := rt.call_function('apply_filters', [rt.new_string('nav_menu_item_id'), 'menu-item-' + (rt.get_property(var_menu_item, 'ID')).str(), var_menu_item.dup(), var_args_mutated.dup(), rt.new_int(depth)])
	mut var_li_atts := rt.new_array()
	var_li_atts.array_set('id', if !(!rt.is_true(var_id)) { var_id } else { rt.new_string('') })
	var_li_atts.array_set('class', if !(!rt.is_true(var_class_names)) { var_class_names } else { rt.new_string('') })
	var_li_atts = rt.call_function('apply_filters', [rt.new_string('nav_menu_item_attributes'), var_li_atts.dup(), var_menu_item.dup(), var_args_mutated.dup(), rt.new_int(depth)])
	mut var_li_attributes := this.build_atts(var_li_atts.dup())
	// unsupported expression: Expr_AssignOp_Concat
	mut var_title := rt.call_function('apply_filters', [rt.new_string('the_title'), rt.get_property(var_menu_item, 'title'), rt.get_property(var_menu_item, 'ID')])
	mut var_the_title_filtered := var_title.dup()
	var_title = rt.call_function('apply_filters', [rt.new_string('nav_menu_item_title'), var_title.dup(), var_menu_item.dup(), var_args_mutated.dup(), rt.new_int(depth)])
	mut var_atts := rt.new_array()
	var_atts.array_set('target', if !(!rt.is_true(rt.get_property(var_menu_item, 'target'))) { rt.get_property(var_menu_item, 'target') } else { rt.new_string('') })
	var_atts.array_set('rel', if !(!rt.is_true(rt.get_property(var_menu_item, 'xfn'))) { rt.get_property(var_menu_item, 'xfn') } else { rt.new_string('') })
	if !(!rt.is_true(rt.get_property(var_menu_item, 'url'))) {
		if rt.is_true(rt.identical(this.privacy_policy_url, rt.get_property(var_menu_item, 'url'))) {
			var_atts.array_set('rel', if !rt.is_true(var_atts.array_get('rel')) { 'privacy-policy' } else { (var_atts.array_get('rel')).str() + ' privacy-policy' })
		}
		var_atts.array_set('href', rt.get_property(var_menu_item, 'url'))
	} else {
		var_atts.array_set('href', '')
	}
	var_atts.array_set('aria-current', if rt.is_true(rt.get_property(var_menu_item, 'current')) { 'page' } else { '' })
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(!rt.is_true(rt.get_property(var_menu_item, 'attr_title'))) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		var_atts.array_set('title', rt.get_property(var_menu_item, 'attr_title'))
	} else {
		var_atts.array_set('title', '')
	}
	var_atts = rt.call_function('apply_filters', [rt.new_string('nav_menu_link_attributes'), var_atts.dup(), var_menu_item.dup(), var_args_mutated.dup(), rt.new_int(depth)])
	mut var_attributes := this.build_atts(var_atts.dup())
	mut var_item_output := rt.get_property(var_args_mutated, 'before')
	// unsupported expression: Expr_AssignOp_Concat
	// unsupported expression: Expr_AssignOp_Concat
	// unsupported expression: Expr_AssignOp_Concat
	// unsupported expression: Expr_AssignOp_Concat
	// unsupported expression: Expr_AssignOp_Concat
}

fn (mut this Class_Walker_Nav_Menu) end_el(var_output rt.PhpVal, var_data_object rt.PhpVal, depth i64, var_args rt.PhpVal)  {
	mut var_args_mutated := var_args
	if rt.is_true(rt.new_bool(!(rt.get_property(var_args_mutated, 'item_spacing')).is_null() && rt.is_true(rt.identical(rt.new_string('discard'), rt.get_property(var_args_mutated, 'item_spacing'))))) {
		mut var_t := rt.new_string(rt.new_string(''))
		mut var_n := rt.new_string(rt.new_string(''))
	} else {
		var_t = rt.new_string(rt.new_string('\t'))
		var_n = rt.new_string(rt.new_string('\n'))
	}
	// unsupported expression: Expr_AssignOp_Concat
}

fn (mut this Class_Walker_Nav_Menu) build_atts(var_atts rt.PhpVal) rt.PhpVal {
	mut var_atts_mutated := var_atts
	mut var_attribute_string := rt.new_string(rt.new_string(''))
	{
		mut iter_1 := var_atts_mutated.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_value := item_1.val
			mut var_attr := item_1.key
			if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) && rt.is_true(rt.call_function('is_scalar', [var_value.dup()])))) {
				var_value = if rt.is_true(rt.identical(rt.new_string('href'), var_attr)) { rt.call_function('esc_url', [var_value.dup()]) } else { rt.call_function('esc_attr', [var_value.dup()]) }
				// unsupported expression: Expr_AssignOp_Concat
			}
		}
	}
	return var_attribute_string.dup()
}

struct Class_Walker {
	rt.PhpObjectBase
}

fn create_walker_nav_menu() &Class_Walker_Nav_Menu {
	mut obj := &Class_Walker_Nav_Menu{
		PhpObjectBase: rt.PhpObjectBase{}
		tree_type: rt.new_array()
		db_fields: rt.new_array()
		privacy_policy_url: rt.new_null()
	}
	obj.construct()
	return obj
}

fn create_walker() &Class_Walker {
	mut obj := &Class_Walker{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Walker_Nav_Menu) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
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
		'build_atts' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.build_atts(dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_Walker_Nav_Menu) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'tree_type' { return this.tree_type }
		'db_fields' { return this.db_fields }
		'privacy_policy_url' { return this.privacy_policy_url }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Walker_Nav_Menu) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'tree_type' { this.tree_type = val; return true }
		'db_fields' { this.db_fields = val; return true }
		'privacy_policy_url' { this.privacy_policy_url = val; return true }
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




pub fn init_wp_includes_class_walker_nav_menu_php() {
}
