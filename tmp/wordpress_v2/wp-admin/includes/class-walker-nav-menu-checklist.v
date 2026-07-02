import rt

struct Class_Walker_Nav_Menu_Checklist {
	rt.PhpObjectBase
}

fn (mut this Class_Walker_Nav_Menu_Checklist) construct(fields bool) {
	if var_fields {
		this.dispatch_set_prop('db_fields', rt.new_bool(fields))
	}
}

fn (mut this Class_Walker_Nav_Menu_Checklist) start_lvl(var_output rt.PhpVal, depth i64, var_args rt.PhpVal) {
	mut var_indent := rt.call_function('str_repeat', [rt.new_string('\t'),
		rt.new_int(depth)])
	var_output = rt.concat(var_output,
		rt.new_string("\n${var_indent.to_string()}<ul class='children'>\n"))
}

fn (mut this Class_Walker_Nav_Menu_Checklist) end_lvl(var_output rt.PhpVal, depth i64, var_args rt.PhpVal) {
	mut var_indent := rt.call_function('str_repeat', [rt.new_string('\t'),
		rt.new_int(depth)])
	var_output = rt.concat(var_output, rt.new_string('\n${var_indent.to_string()}</ul>'))
}

fn (mut this Class_Walker_Nav_Menu_Checklist) start_el(var_output rt.PhpVal, var_data_object rt.PhpVal, depth i64, var_args rt.PhpVal, current_object_id i64) {
	mut var_nav_menu_selected_id := rt.new_null()
	mut var__nav_menu_placeholder := rt.get_superglobal('_nav_menu_placeholder')
	mut var_menu_item := var_data_object
	var__nav_menu_placeholder = rt.new_int(if rt.is_true(rt.greater(rt.new_int(0),
		var__nav_menu_placeholder))
	{
		rt.new_int(var__nav_menu_placeholder.to_i64()) - 1
	} else {
		-1
	})
	mut var_possible_object_id := if !(rt.get_property(var_menu_item, 'post_type')).is_null()
		&& rt.is_true(rt.identical(rt.new_string('nav_menu_item'), rt.get_property(var_menu_item, 'post_type'))) {
		rt.get_property(var_menu_item, 'object_id')
	} else {
		var__nav_menu_placeholder
	}
	mut var_possible_db_id := rt.new_int(if !(!rt.is_true(rt.get_property(var_menu_item, 'ID')))
		&& rt.is_true(rt.less(rt.new_int(0), var_possible_object_id)) {
		rt.new_int((rt.get_property(var_menu_item, 'ID')).to_i64())
	} else {
		0
	})
	mut var_indent := if var_depth != 0 { rt.call_function('str_repeat', [
			rt.new_string('\t'),
			rt.new_int(depth),
		]) } else { rt.new_string('') }
	var_output = rt.concat(var_output, rt.new_string(var_indent.str() + '<li>'))
	var_output = rt.concat(var_output, rt.new_string('<label class="menu-item-title">'))
	var_output = rt.concat(var_output, rt.new_string('<input type="checkbox"' +
		(rt.call_function('wp_nav_menu_disabled_check', [var_nav_menu_selected_id.clone(), rt.new_bool(false)])).str() +
		' class="menu-item-checkbox'))
	if !(!rt.is_true(rt.get_property(var_menu_item, 'front_or_home'))) {
		var_output = rt.concat(var_output, rt.new_string(' add-to-top'))
	}
	var_output = rt.concat(var_output, rt.new_string('" name="menu-item[' +
		var_possible_object_id.str() + '][menu-item-object-id]" value="' +
		(rt.call_function('esc_attr', [rt.get_property(var_menu_item, 'object_id')])).str() +
		'" /> '))
	if !(!rt.is_true(rt.get_property(var_menu_item, 'label'))) {
		mut var_title := rt.get_property(var_menu_item, 'label')
	} else if !(rt.get_property(var_menu_item, 'post_type')).is_null() {
		var_title = rt.call_function('apply_filters', [rt.new_string('the_title'),
			rt.get_property(var_menu_item, 'post_title'), rt.get_property(var_menu_item, 'ID')])
	}
	var_output = rt.concat(var_output, if !var_title.is_null() { rt.call_function('esc_html', [
			var_title.clone(),
		]) } else { rt.call_function('esc_html', [
			rt.get_property(var_menu_item, 'title'),
		]) })
	if !rt.is_true(rt.get_property(var_menu_item, 'label'))
		&& !(rt.get_property(var_menu_item, 'post_type')).is_null()
		&& rt.is_true(rt.identical(rt.new_string('page'), rt.get_property(var_menu_item, 'post_type'))) {
		var_output = rt.concat(var_output, rt.call_function('_post_states', [
			var_menu_item.clone(), rt.new_bool(false)]))
	}
	var_output = rt.concat(var_output, rt.new_string('</label>'))
	var_output = rt.concat(var_output, rt.new_string(
		'<input type="hidden" class="menu-item-db-id" name="menu-item[' +
		var_possible_object_id.str() + '][menu-item-db-id]" value="' + var_possible_db_id.str() +
		'" />'))
	var_output = rt.concat(var_output, rt.new_string(
		'<input type="hidden" class="menu-item-object" name="menu-item[' +
		var_possible_object_id.str() + '][menu-item-object]" value="' +
		(rt.call_function('esc_attr', [rt.get_property(var_menu_item, 'object')])).str() + '" />'))
	var_output = rt.concat(var_output, rt.new_string(
		'<input type="hidden" class="menu-item-parent-id" name="menu-item[' +
		var_possible_object_id.str() + '][menu-item-parent-id]" value="' +
		(rt.call_function('esc_attr', [rt.get_property(var_menu_item, 'menu_item_parent')])).str() +
		'" />'))
	var_output = rt.concat(var_output, rt.new_string(
		'<input type="hidden" class="menu-item-type" name="menu-item[' +
		var_possible_object_id.str() + '][menu-item-type]" value="' +
		(rt.call_function('esc_attr', [rt.get_property(var_menu_item, 'type')])).str() + '" />'))
	var_output = rt.concat(var_output, rt.new_string(
		'<input type="hidden" class="menu-item-title" name="menu-item[' +
		var_possible_object_id.str() + '][menu-item-title]" value="' +
		(rt.call_function('htmlspecialchars', [rt.get_property(var_menu_item, 'title'), rt.get_constant('ENT_QUOTES')])).str() +
		'" />'))
	var_output = rt.concat(var_output, rt.new_string(
		'<input type="hidden" class="menu-item-url" name="menu-item[' +
		var_possible_object_id.str() + '][menu-item-url]" value="' +
		(rt.call_function('esc_url', [rt.get_property(var_menu_item, 'url')])).str() + '" />'))
	var_output = rt.concat(var_output, rt.new_string(
		'<input type="hidden" class="menu-item-target" name="menu-item[' +
		var_possible_object_id.str() + '][menu-item-target]" value="' +
		(rt.call_function('esc_attr', [rt.get_property(var_menu_item, 'target')])).str() + '" />'))
	var_output = rt.concat(var_output, rt.new_string(
		'<input type="hidden" class="menu-item-attr-title" name="menu-item[' +
		var_possible_object_id.str() + '][menu-item-attr-title]" value="' +
		(rt.call_function('htmlspecialchars', [rt.get_property(var_menu_item, 'attr_title'), rt.get_constant('ENT_QUOTES')])).str() +
		'" />'))
	var_output = rt.concat(var_output, rt.new_string(
		'<input type="hidden" class="menu-item-classes" name="menu-item[' +
		var_possible_object_id.str() + '][menu-item-classes]" value="' +
		(rt.call_function('htmlspecialchars', [rt.call_function('implode', [rt.new_string(' '), rt.get_property(var_menu_item, 'classes')]), rt.get_constant('ENT_QUOTES')])).str() +
		'" />'))
	var_output = rt.concat(var_output, rt.new_string(
		'<input type="hidden" class="menu-item-xfn" name="menu-item[' +
		var_possible_object_id.str() + '][menu-item-xfn]" value="' +
		(rt.call_function('htmlspecialchars', [rt.get_property(var_menu_item, 'xfn'), rt.get_constant('ENT_QUOTES')])).str() +
		'" />'))
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

fn create_walker_nav_menu(_args ...rt.PhpVal) &Class_Walker_Nav_Menu {
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
			this.start_el(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3,
				dispatch_arg_4)
			return rt.new_null()
		}
		else {
			return none
		}
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

fn main() {
	defer {
		rt.shutdown()
	}
}
