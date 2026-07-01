import rt

fn wp_get_nav_menu_object(var_menu rt.PhpVal) rt.PhpVal {
	mut var_menu_obj := rt.new_bool(rt.new_bool(false))
	if rt.is_true(rt.new_bool(var_menu.dup().is_object())) {
		var_menu_obj = var_menu.dup()
	}
	if rt.is_true(rt.new_bool(rt.is_true(var_menu) && rt.is_true(rt.new_bool(!(rt.is_true(var_menu_obj)))))) {
		var_menu_obj = rt.call_function('get_term', [var_menu.dup(), rt.new_string('nav_menu')])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_menu_obj)))) {
			var_menu_obj = rt.call_function('get_term_by', [rt.new_string('slug'), var_menu.dup(), rt.new_string('nav_menu')])
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(var_menu_obj)))) {
			var_menu_obj = rt.call_function('get_term_by', [rt.new_string('name'), var_menu.dup(), rt.new_string('nav_menu')])
		}
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_menu_obj)))) || rt.is_true(rt.call_function('is_wp_error', [var_menu_obj.dup()])))) {
		var_menu_obj = rt.new_bool(rt.new_bool(false))
	}
	return rt.call_function('apply_filters', [rt.new_string('wp_get_nav_menu_object'), var_menu_obj.dup(), var_menu.dup()])
}

fn is_nav_menu(var_menu rt.PhpVal) bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(var_menu)))) {
		return false
	}
	mut var_menu_obj := wp_get_nav_menu_object(var_menu.dup())
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(var_menu_obj) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [var_menu_obj.dup()]))))))) && !(!rt.is_true(rt.get_property(var_menu_obj, 'taxonomy'))))) && rt.is_true(rt.identical(rt.new_string('nav_menu'), rt.get_property(var_menu_obj, 'taxonomy'))))) {
		return true
	}
	return false
}

fn register_nav_menus(var_locations rt.PhpVal) {
	// unsupported statement: Stmt_Global
	rt.call_function('add_theme_support', [rt.new_string('menus')])
	{
		mut iter_1 := var_locations.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_value := item_1.val
			mut var_key := item_1.key
			if rt.is_true(rt.new_bool(var_key.dup().is_long())) {
				rt.call_function('_doing_it_wrong', [rt.new_string(@FN), rt.call_function('__', [rt.new_string('Nav menu locations must be strings.')]), rt.new_string('5.3.0')])
				break
			}
		}
	}
	mut var__wp_registered_nav_menus := rt.call_function('array_merge', [rt.cast_array(var__wp_registered_nav_menus), var_locations.dup()])
}

fn unregister_nav_menu(var_location rt.PhpVal) bool {
	mut var__wp_registered_nav_menus := rt.new_null()
	// unsupported statement: Stmt_Global
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var__wp_registered_nav_menus.dup().is_array())) && var__wp_registered_nav_menus.array_isset(var_location))) {
		var__wp_registered_nav_menus.array_unset(var_location)
		if !rt.is_true(var__wp_registered_nav_menus) {
			rt.call_function('_remove_theme_support', [rt.new_string('menus')])
		}
		return true
	}
	return false
}

fn register_nav_menu(var_location rt.PhpVal, var_description rt.PhpVal) {
	register_nav_menus(rt.create_array([rt.ArrayItem{ key: var_location, val: var_description }]))
}

fn get_registered_nav_menus() rt.PhpVal {
	mut var__wp_registered_nav_menus := rt.new_null()
	// unsupported statement: Stmt_Global
	return if !(var__wp_registered_nav_menus).is_null() { var__wp_registered_nav_menus } else { rt.new_array() }
}

fn get_nav_menu_locations() rt.PhpVal {
	mut var_locations := rt.call_function('get_theme_mod', [rt.new_string('nav_menu_locations')])
	return if rt.is_true(rt.new_bool(var_locations.dup().is_array())) { var_locations } else { rt.new_array() }
}

fn has_nav_menu(var_location rt.PhpVal) rt.PhpVal {
	mut var_has_nav_menu := false
	mut var_registered_nav_menus := get_registered_nav_menus()
	if var_registered_nav_menus.array_isset(var_location) {
		mut var_locations := get_nav_menu_locations()
		var_has_nav_menu = !(!rt.is_true(var_locations.array_get(var_location)))
	}
	return rt.call_function('apply_filters', [rt.new_string('has_nav_menu'), rt.new_bool(var_has_nav_menu).dup(), var_location.dup()])
}

fn wp_get_nav_menu_name(var_location rt.PhpVal) rt.PhpVal {
	mut var_menu_name := rt.new_string(rt.new_string(''))
	mut var_locations := get_nav_menu_locations()
	if var_locations.array_isset(var_location) {
		mut var_menu := wp_get_nav_menu_object(var_locations.array_get(var_location))
		if rt.is_true(rt.new_bool(rt.is_true(var_menu) && rt.is_true(rt.get_property(var_menu, 'name')))) {
			var_menu_name = rt.get_property(var_menu, 'name')
		}
	}
	return rt.call_function('apply_filters', [rt.new_string('wp_get_nav_menu_name'), var_menu_name.dup(), var_location.dup()])
}

fn is_nav_menu_item(menu_item_id i64) bool {
	return rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [rt.new_int(menu_item_id)]))))) && rt.is_true(rt.identical(rt.new_string('nav_menu_item'), rt.call_function('get_post_type', [rt.new_int(menu_item_id)])))
}

fn wp_create_nav_menu(var_menu_name rt.PhpVal) rt.PhpVal {
	return rt.new_int(wp_update_nav_menu_object(0, rt.create_array([rt.ArrayItem{ key: 'menu-name', val: var_menu_name }])))
}

fn wp_delete_nav_menu(var_menu rt.PhpVal) bool {
	var_menu = wp_get_nav_menu_object(var_menu.dup())
	if rt.is_true(rt.new_bool(!(rt.is_true(var_menu)))) {
		return false
	}
	mut var_menu_objects := rt.call_function('get_objects_in_term', [rt.get_property(var_menu, 'term_id'), rt.new_string('nav_menu')])
	if !(!rt.is_true(var_menu_objects)) {
		{
			mut iter_1 := var_menu_objects.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_item := item_1.val
				rt.call_function('wp_delete_post', [var_item.dup()])
			}
		}
	}
	mut var_result := rt.call_function('wp_delete_term', [rt.get_property(var_menu, 'term_id'), rt.new_string('nav_menu')])
	mut var_locations := get_nav_menu_locations()
	{
		mut iter_1 := var_locations.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_menu_id := item_1.val
			mut var_location := item_1.key
			if rt.is_true(rt.identical(var_menu_id, rt.get_property(var_menu, 'term_id'))) {
				var_locations.array_set(var_location, 0)
			}
		}
	}
	rt.call_function('set_theme_mod', [rt.new_string('nav_menu_locations'), var_locations.dup()])
	if rt.is_true(rt.new_bool(rt.is_true(var_result) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [var_result.dup()]))))))) {
		rt.call_function('do_action', [rt.new_string('wp_delete_nav_menu'), rt.get_property(var_menu, 'term_id')])
	}
	return (var_result).to_bool()
}

fn wp_update_nav_menu_object(menu_id i64, var_menu_data rt.PhpVal) i64 {
	menu_id = (// unsupported expression: Expr_Cast_Int).to_i64()
	mut var__menu := wp_get_nav_menu_object(rt.new_int(menu_id))
	mut var_args := rt.create_array([rt.ArrayItem{ key: 'description', val: if !(var_menu_data.array_get('description')).is_null() { var_menu_data.array_get('description') } else { rt.new_string('') } }, rt.ArrayItem{ key: 'name', val: if !(var_menu_data.array_get('menu-name')).is_null() { var_menu_data.array_get('menu-name') } else { rt.new_string('') } }, rt.ArrayItem{ key: 'parent', val: if var_menu_data.array_isset(rt.new_string('parent')) { // unsupported expression: Expr_Cast_Int } else { rt.new_int(0) } }, rt.ArrayItem{ key: 'slug', val: rt.new_null() }])
	mut var__possible_existing := rt.call_function('get_term_by', [rt.new_string('name'), var_menu_data.array_get('menu-name'), rt.new_string('nav_menu')])
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(var__possible_existing) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [var__possible_existing.dup()]))))))) && !(rt.get_property(var__possible_existing, 'term_id')).is_null())) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		return (create_wp_error(rt.new_string('menu_exists'), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('The menu name %s conflicts with another menu name. Please try another.')]), '<strong>' + (rt.call_function('esc_html', [var_menu_data.array_get('menu-name')])).str() + '</strong>']))).to_i64()
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var__menu)))) || rt.is_true(rt.call_function('is_wp_error', [var__menu.dup()])))) {
		mut var_menu_exists := rt.call_function('get_term_by', [rt.new_string('name'), var_menu_data.array_get('menu-name'), rt.new_string('nav_menu')])
		if rt.is_true(var_menu_exists) {
			return (create_wp_error(rt.new_string('menu_exists'), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('The menu name %s conflicts with another menu name. Please try another.')]), '<strong>' + (rt.call_function('esc_html', [var_menu_data.array_get('menu-name')])).str() + '</strong>']))).to_i64()
		}
		var__menu = rt.call_function('wp_insert_term', [var_menu_data.array_get('menu-name'), rt.new_string('nav_menu'), var_args.dup()])
		if rt.is_true(rt.call_function('is_wp_error', [var__menu.dup()])) {
			return (var__menu).to_i64()
		}
		rt.call_function('do_action', [rt.new_string('wp_create_nav_menu'), var__menu.array_get('term_id'), var_menu_data.dup()])
		return (// unsupported expression: Expr_Cast_Int).to_i64()
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var__menu)))) || !(!(rt.get_property(var__menu, 'term_id')).is_null()))) {
		return 0
	}
	menu_id = (// unsupported expression: Expr_Cast_Int).to_i64()
	mut var_update_response := rt.call_function('wp_update_term', [rt.new_int(menu_id), rt.new_string('nav_menu'), var_args.dup()])
	if rt.is_true(rt.call_function('is_wp_error', [var_update_response.dup()])) {
		return (var_update_response).to_i64()
	}
	menu_id = (// unsupported expression: Expr_Cast_Int).to_i64()
	rt.call_function('do_action', [rt.new_string('wp_update_nav_menu'), rt.new_int(menu_id), var_menu_data.dup()])
	return menu_id
}

fn wp_update_nav_menu_item(menu_id i64, menu_item_db_id i64, var_menu_item_data rt.PhpVal, fire_after_hooks bool) rt.PhpVal {
	menu_id = (// unsupported expression: Expr_Cast_Int).to_i64()
	menu_item_db_id = (// unsupported expression: Expr_Cast_Int).to_i64()
	if !(menu_item_db_id == 0) && !(is_nav_menu_item(menu_item_db_id)) {
		return create_wp_error(rt.new_string('update_nav_menu_item_failed'), rt.call_function('__', [rt.new_string('The given object ID is not that of a menu item.')]))
	}
	mut var_menu := wp_get_nav_menu_object(rt.new_int(menu_id))
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_menu)))) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		return create_wp_error(rt.new_string('invalid_menu_id'), rt.call_function('__', [rt.new_string('Invalid menu ID.')]))
	}
	if rt.is_true(rt.call_function('is_wp_error', [var_menu.dup()])) {
		return var_menu.dup()
	}
	mut var_defaults := { 'menu-item-db-id': rt.new_int(menu_item_db_id), 'menu-item-object-id': rt.new_int(0), 'menu-item-object': rt.new_string(''), 'menu-item-parent-id': rt.new_int(0), 'menu-item-position': rt.new_int(0), 'menu-item-type': rt.new_string('custom'), 'menu-item-title': rt.new_string(''), 'menu-item-url': rt.new_string(''), 'menu-item-description': rt.new_string(''), 'menu-item-attr-title': rt.new_string(''), 'menu-item-target': rt.new_string(''), 'menu-item-classes': rt.new_string(''), 'menu-item-xfn': rt.new_string(''), 'menu-item-status': rt.new_string(''), 'menu-item-post-date': rt.new_string(''), 'menu-item-post-date-gmt': rt.new_string('') }
	mut var_args := rt.call_function('wp_parse_args', [var_menu_item_data.dup(), var_defaults.dup()])
	if 0 == menu_id {
		var_args.array_set('menu-item-position', 1)
	} else if rt.is_true(rt.identical(rt.new_int(0), // unsupported expression: Expr_Cast_Int)) {
		mut var_menu_items := rt.new_array()
		if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
			var_menu_items = rt.cast_array(rt.new_bool(wp_get_nav_menu_items(rt.new_int(menu_id), rt.create_array([rt.ArrayItem{ key: , val:  }]))))
		}
		mut var_last_item := rt.call_function('array_pop', [var_menu_items.dup()])
		if rt.is_true(rt.new_bool(rt.is_true(var_last_item) && !(rt.get_property(var_last_item, 'menu_order')).is_null())) {
			var_args.array_set('menu-item-position', rt.add(, ))
		} else {
			.array_set(, )
		}
	}
	mut var_original_parent := if  <  {  } else {  }
	if rt.is_true(rt.identical(, )) {
		
	} else {
	}
	
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

fn create_wp_error() &Class_WP_Error {
	mut obj := &Class_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Error) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Error) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Error) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_includes_nav_menu_php() {
}
