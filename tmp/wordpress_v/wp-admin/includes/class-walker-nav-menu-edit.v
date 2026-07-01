import rt

struct Class_Walker_Nav_Menu_Edit {
	rt.PhpObjectBase
}

fn (mut this Class_Walker_Nav_Menu_Edit) start_lvl(var_output rt.PhpVal, depth i64, var_args rt.PhpVal)  {
}

fn (mut this Class_Walker_Nav_Menu_Edit) end_lvl(var_output rt.PhpVal, depth i64, var_args rt.PhpVal)  {
}

fn (mut this Class_Walker_Nav_Menu_Edit) start_el(var_output rt.PhpVal, var_data_object rt.PhpVal, depth i64, var_args rt.PhpVal, current_object_id i64)  {
	// unsupported statement: Stmt_Global
	mut var_menu_item := var_data_object
	mut var__wp_nav_menu_max_depth := if rt.is_true(rt.greater(rt.new_int(depth), var__wp_nav_menu_max_depth)) { rt.new_int(depth) } else { var__wp_nav_menu_max_depth }
	rt.call_function('ob_start', []rt.PhpVal{})
	mut var_item_id := rt.call_function('esc_attr', [rt.get_property(var_menu_item, 'ID')])
	mut var_removed_args := ['action', 'customlink-tab', 'edit-menu-item', 'menu-item', 'page-tab', '_wpnonce']
	mut var_original_title := rt.new_bool(rt.new_bool(false))
	if rt.is_true(rt.identical(rt.new_string('taxonomy'), rt.get_property(var_menu_item, 'type'))) {
		mut var_original_object := rt.call_function('get_term', [// unsupported expression: Expr_Cast_Int, rt.get_property(var_menu_item, 'object')])
		if rt.is_true(rt.new_bool(rt.is_true(var_original_object) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [var_original_object.dup()]))))))) {
			var_original_title = rt.get_property(var_original_object, 'name')
		}
	} else if rt.is_true(rt.identical(rt.new_string('post_type'), rt.get_property(var_menu_item, 'type'))) {
		var_original_object = rt.call_function('get_post', [rt.get_property(var_menu_item, 'object_id')])
		if rt.is_true(var_original_object) {
			var_original_title = rt.call_function('get_the_title', [rt.get_property(var_original_object, 'ID')])
		}
	} else if rt.is_true(rt.identical(rt.new_string('post_type_archive'), rt.get_property(var_menu_item, 'type'))) {
		var_original_object = rt.call_function('get_post_type_object', [rt.get_property(var_menu_item, 'object')])
		if rt.is_true(var_original_object) {
			var_original_title = rt.get_property(rt.get_property(var_original_object, 'labels'), 'archives')
		}
	}
	mut var_classes := ['menu-item menu-item-depth-' + depth.str(), 'menu-item-' + (rt.call_function('esc_attr', [rt.get_property(var_menu_item, 'object')])).str(), 'menu-item-edit-' + if rt.is_true(rt.new_bool(rt.get_superglobal('_GET').array_isset(rt.new_string('edit-menu-item')) && rt.is_true(rt.identical(var_item_id, rt.get_superglobal('_GET').array_get('edit-menu-item'))))) { 'active' } else { 'inactive' }]
	mut var_title := rt.get_property(var_menu_item, 'title')
	if !(!rt.is_true(rt.get_property(var_menu_item, '_invalid'))) {
		var_classes << 'menu-item-invalid'
		var_title = rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('%s (Invalid)')]), rt.get_property(var_menu_item, 'title')])
	} else if rt.is_true(rt.new_bool(!(rt.get_property(var_menu_item, 'post_status')).is_null() && rt.is_true(rt.identical(rt.new_string('draft'), rt.get_property(var_menu_item, 'post_status'))))) {
		var_classes << 'pending'
		var_title = rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('%s (Pending)')]), rt.get_property(var_menu_item, 'title')])
	}
	var_title = if rt.is_true(rt.new_bool(!(!(rt.get_property(var_menu_item, 'label')).is_null()) || rt.is_true(rt.identical(rt.new_string(''), rt.get_property(var_menu_item, 'label'))))) { var_title } else { rt.get_property(var_menu_item, 'label') }
	mut var_submenu_text := rt.new_string(rt.new_string(''))
	if 0 == depth {
		var_submenu_text = rt.new_string(rt.new_string('style="display: none;"'))
	}
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_item_id)
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('implode', [rt.new_string(' '), var_classes.dup()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_item_id)
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_item_id)
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_item_id)
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_title.dup()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_submenu_text)
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('sub item')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [rt.get_property(var_menu_item, 'type_label')]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('printf', [rt.new_string('<a href="%s" class="item-move-up" aria-label="%s">&#8593;</a>'), rt.call_function('wp_nonce_url', [rt.call_function('add_query_arg', [rt.create_array([rt.ArrayItem{ key: 'action', val: 'move-up-menu-item' }, rt.ArrayItem{ key: 'menu-item', val: var_item_id }]), rt.call_function('remove_query_arg', [var_removed_args.dup(), rt.call_function('admin_url', [rt.new_string('nav-menus.php')])])]), rt.new_string('move-menu_item')]), rt.call_function('esc_attr__', [rt.new_string('Move up')])])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('printf', [rt.new_string('<a href="%s" class="item-move-down" aria-label="%s">&#8595;</a>'), rt.call_function('wp_nonce_url', [rt.call_function('add_query_arg', [rt.create_array([rt.ArrayItem{ key: 'action', val: 'move-down-menu-item' }, rt.ArrayItem{ key: 'menu-item', val: var_item_id }]), rt.call_function('remove_query_arg', [var_removed_args.dup(), rt.call_function('admin_url', [rt.new_string('nav-menus.php')])])]), rt.new_string('move-menu_item')]), rt.call_function('esc_attr__', [rt.new_string('Move down')])])
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.new_bool(rt.get_superglobal('_GET').array_isset(rt.new_string('edit-menu-item')) && rt.is_true(rt.identical(var_item_id, rt.get_superglobal('_GET').array_get('edit-menu-item'))))) {
		mut var_edit_url := rt.call_function('admin_url', [rt.new_string('nav-menus.php')])
	} else {
		var_edit_url = rt.call_function('add_query_arg', [rt.create_array([rt.ArrayItem{ key: 'edit-menu-item', val: var_item_id }]), rt.call_function('remove_query_arg', [var_removed_args.dup(), rt.call_function('admin_url', ['nav-menus.php#menu-item-settings-' + (var_item_id).str()])])])
	}
	rt.call_function('printf', [rt.new_string('<a class="item-edit" id="edit-%s" href="%s" aria-label="%s"><span class="screen-reader-text">%s</span></a>'), var_item_id.dup(), rt.call_function('esc_url', [var_edit_url.dup()]), rt.call_function('esc_attr__', [rt.new_string('Edit menu item')]), rt.call_function('__', [rt.new_string('Edit')])])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_item_id)
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.identical(rt.new_string('custom'), rt.get_property(var_menu_item, 'type'))) {
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(var_item_id)
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('URL')])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(var_item_id)
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(var_item_id)
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_url', [rt.get_property(var_menu_item, 'url')]))
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_item_id)
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Navigation Label')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_item_id)
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_item_id)
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('htmlspecialchars', [rt.get_property(var_menu_item, 'title'), rt.get_constant('ENT_QUOTES')]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_item_id)
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Title Attribute')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_item_id)
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_item_id)
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('htmlspecialchars', [rt.get_property(var_menu_item, 'post_excerpt'), rt.get_constant('ENT_QUOTES')]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_item_id)
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_item_id)
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_item_id)
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('checked', [rt.get_property(var_menu_item, 'target'), rt.new_string('_blank')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Open link in a new tab')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_item_id)
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('CSS Classes (optional)')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_item_id)
	// unsupported statement: Stmt_InlineHTML
}

struct Class_Walker_Nav_Menu {
	rt.PhpObjectBase
}

fn create_walker_nav_menu_edit() &Class_Walker_Nav_Menu_Edit {
	mut obj := &Class_Walker_Nav_Menu_Edit{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_walker_nav_menu() &Class_Walker_Nav_Menu {
	mut obj := &Class_Walker_Nav_Menu{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Walker_Nav_Menu_Edit) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
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
		else { return none }
	}
}

fn (this &Class_Walker_Nav_Menu_Edit) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Walker_Nav_Menu_Edit) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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




pub fn init_wp_admin_includes_class_walker_nav_menu_edit_php() {
}
