import rt

struct Class_Walker_Nav_Menu_Checklist {
	rt.PhpObjectBase
}

fn (mut this Class_Walker_Nav_Menu_Checklist) construct(fields bool)  {
	if var_fields {
		this.dispatch_set_prop('db_fields', rt.new_bool(fields))
	}
}

fn (mut this Class_Walker_Nav_Menu_Checklist) start_lvl(var_output rt.PhpVal, depth i64, var_args rt.PhpVal)  {
	mut var_indent := rt.call_function('str_repeat', [rt.new_string('\t'), rt.new_int(depth)])
	// unsupported expression: Expr_AssignOp_Concat
}

fn (mut this Class_Walker_Nav_Menu_Checklist) end_lvl(var_output rt.PhpVal, depth i64, var_args rt.PhpVal)  {
	mut var_indent := rt.call_function('str_repeat', [rt.new_string('\t'), rt.new_int(depth)])
	// unsupported expression: Expr_AssignOp_Concat
}

fn (mut this Class_Walker_Nav_Menu_Checklist) start_el(var_output rt.PhpVal, var_data_object rt.PhpVal, depth i64, var_args rt.PhpVal, current_object_id i64)  {
	mut var_nav_menu_selected_id := rt.new_null()
	// unsupported statement: Stmt_Global
	mut var_menu_item := var_data_object
	mut var__nav_menu_placeholder := if rt.is_true(rt.greater(rt.new_int(0), var__nav_menu_placeholder)) { rt.sub(// unsupported expression: Expr_Cast_Int, rt.new_int(1)) } else { // unsupported expression: Expr_UnaryMinus }
	mut var_possible_object_id := if rt.is_true(rt.new_bool(!(rt.get_property(var_menu_item, 'post_type')).is_null() && rt.is_true(rt.identical(rt.new_string('nav_menu_item'), rt.get_property(var_menu_item, 'post_type'))))) { rt.get_property(var_menu_item, 'object_id') } else { var__nav_menu_placeholder }
	mut var_possible_db_id := if rt.is_true(rt.new_bool(!(!rt.is_true(rt.get_property(var_menu_item, 'ID'))) && rt.is_true(rt.less(rt.new_int(0), var_possible_object_id)))) { // unsupported expression: Expr_Cast_Int } else { rt.new_int(0) }
	mut var_indent := if var_depth != 0 { rt.call_function('str_repeat', [rt.new_string('\t'), rt.new_int(depth)]) } else { rt.new_string('') }
	// unsupported expression: Expr_AssignOp_Concat
	// unsupported expression: Expr_AssignOp_Concat
	// unsupported expression: Expr_AssignOp_Concat
	if !(!rt.is_true(rt.get_property(var_menu_item, 'front_or_home'))) {
		// unsupported expression: Expr_AssignOp_Concat
	}
	// unsupported expression: Expr_AssignOp_Concat
	if !(!rt.is_true(rt.get_property(var_menu_item, 'label'))) {
		mut var_title := rt.get_property(var_menu_item, 'label')
	} else if !(rt.get_property(var_menu_item, 'post_type')).is_null() {
		var_title = rt.call_function('apply_filters', [rt.new_string('the_title'), rt.get_property(var_menu_item, 'post_title'), rt.get_property(var_menu_item, 'ID')])
	}
	// unsupported expression: Expr_AssignOp_Concat
	if rt.is_true(rt.new_bool(!rt.is_true(rt.get_property(var_menu_item, 'label')) && !(rt.get_property(var_menu_item, 'post_type')).is_null() && rt.is_true(rt.identical(rt.new_string('page'), rt.get_property(var_menu_item, 'post_type'))))) {
		// unsupported expression: Expr_AssignOp_Concat
	}
	// unsupported expression: Expr_AssignOp_Concat
	// unsupported expression: Expr_AssignOp_Concat
	// unsupported expression: Expr_AssignOp_Concat
	// unsupported expression: Expr_AssignOp_Concat
	// unsupported expression: Expr_AssignOp_Concat
	// unsupported expression: Expr_AssignOp_Concat
	// unsupported expression: Expr_AssignOp_Concat
	// unsupported expression: Expr_AssignOp_Concat
	// unsupported expression: Expr_AssignOp_Concat
	// unsupported expression: Expr_AssignOp_Concat
	// unsupported expression: Expr_AssignOp_Concat
}

struct Class_Walker_Nav_Menu {
	rt.PhpObjectBase
}

fn create_walker_nav_menu_checklist(fields bool) &Class_Walker_Nav_Menu_Checklist {
	mut obj := &Class_Walker_Nav_Menu_Checklist{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	obj.construct(fields)
	return obj
}

fn create_walker_nav_menu() &Class_Walker_Nav_Menu {
	mut obj := &Class_Walker_Nav_Menu{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Walker_Nav_Menu_Checklist) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			this.construct(dispatch_arg_0)
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
		else { return none }
	}
}

fn (this &Class_Walker_Nav_Menu_Checklist) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Walker_Nav_Menu_Checklist) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Walker_Nav_Menu) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Walker_Nav_Menu) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Walker_Nav_Menu) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_admin_includes_class_walker_nav_menu_checklist_php() {
}
