import rt

fn wp_get_nav_menu_object(var_menu rt.PhpVal) rt.PhpVal {
	mut var_menu_obj := rt.new_null()
	var_menu_obj = rt.new_bool(false)
	if rt.is_true(rt.new_bool(var_menu.clone().is_object())) {
	var_menu_obj = var_menu.clone()
	}
	if rt.is_true(var_menu) && rt.is_true(rt.new_bool(!(rt.is_true(var_menu_obj)))) {
		var_menu_obj = rt.call_function('get_term', [var_menu.clone(), rt.new_string('nav_menu')])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_menu_obj)))) {
		var_menu_obj = rt.call_function('get_term_by', [rt.new_string('slug'), var_menu.clone(), rt.new_string('nav_menu')])
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(var_menu_obj)))) {
		var_menu_obj = rt.call_function('get_term_by', [rt.new_string('name'), var_menu.clone(), rt.new_string('nav_menu')])
		}
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_menu_obj)))) || rt.is_true(rt.call_function('is_wp_error', [var_menu_obj.clone()])) {
	var_menu_obj = rt.new_bool(false)
	}
	return rt.call_function('apply_filters', [rt.new_string('wp_get_nav_menu_object'), var_menu_obj.clone(), var_menu.clone()])
}

fn is_nav_menu(var_menu rt.PhpVal) bool {
	mut var_menu_obj := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(var_menu)))) {
		return false
	}
	var_menu_obj = wp_get_nav_menu_object(var_menu.clone())
	if rt.is_true(var_menu_obj) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [var_menu_obj.clone()]))))) && !(!rt.is_true(rt.get_property(var_menu_obj, 'taxonomy'))) && rt.is_true(rt.identical(rt.new_string('nav_menu'), rt.get_property(var_menu_obj, 'taxonomy'))) {
		return true
	}
	return false
}

fn register_nav_menus(var_locations rt.PhpVal) {
	mut var_value := rt.new_null()
	mut var_key := rt.new_null()
	mut var__wp_registered_nav_menus := rt.new_null()
	rt.call_function('add_theme_support', [rt.new_string('menus')])
	mut iter_1 := var_locations.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_value_shadow := item_1.val
		mut var_key_shadow := item_1.key
		if rt.is_true(rt.new_bool(var_key_shadow.clone().is_long())) {
			rt.call_function('_doing_it_wrong', [rt.new_string(@FN), rt.call_function('__', [rt.new_string('Nav menu locations must be strings.')]), rt.new_string('5.3.0')])
			break
		}
	}
var__wp_registered_nav_menus = rt.call_function('array_merge', [rt.cast_array(var__wp_registered_nav_menus), var_locations.clone()])
}

fn unregister_nav_menu(var_location rt.PhpVal) bool {
	mut var__wp_registered_nav_menus := rt.new_null()
	if var__wp_registered_nav_menus.clone().is_array() && var__wp_registered_nav_menus.array_isset(var_location) {
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
	return if !(var__wp_registered_nav_menus).is_null() { var__wp_registered_nav_menus } else { rt.new_array() }
}

fn get_nav_menu_locations() rt.PhpVal {
	mut var_locations := rt.new_null()
	var_locations = rt.call_function('get_theme_mod', [rt.new_string('nav_menu_locations')])
	return if var_locations.clone().is_array() { var_locations } else { rt.new_array() }
}

fn has_nav_menu(var_location rt.PhpVal) rt.PhpVal {
	mut var_has_nav_menu := false
	mut var_registered_nav_menus := rt.new_null()
	mut var_locations := rt.new_null()
	var_has_nav_menu = false
	var_registered_nav_menus = get_registered_nav_menus()
	if var_registered_nav_menus.array_isset(var_location) {
	var_locations = get_nav_menu_locations()
	var_has_nav_menu = !(!rt.is_true(var_locations.array_get(var_location)))
	}
	return rt.call_function('apply_filters', [rt.new_string('has_nav_menu'), rt.new_bool(var_has_nav_menu).clone(), var_location.clone()])
}

fn wp_get_nav_menu_name(var_location rt.PhpVal) rt.PhpVal {
	mut var_menu_name := rt.new_null()
	mut var_locations := rt.new_null()
	mut var_menu := rt.new_null()
	var_menu_name = rt.new_string('')
	var_locations = get_nav_menu_locations()
	if var_locations.array_isset(var_location) {
		var_menu = wp_get_nav_menu_object(var_locations.array_get(var_location))
		if rt.is_true(var_menu) && rt.is_true(rt.get_property(var_menu, 'name')) {
		var_menu_name = rt.get_property(var_menu, 'name')
		}
	}
	return rt.call_function('apply_filters', [rt.new_string('wp_get_nav_menu_name'), var_menu_name.clone(), var_location.clone()])
}

fn is_nav_menu_item(menu_item_id i64) bool {
	mut var_menu_item_id := menu_item_id
	return rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [rt.new_int(menu_item_id)]))))) && rt.is_true(rt.identical(rt.new_string('nav_menu_item'), rt.call_function('get_post_type', [rt.new_int(menu_item_id)])))
}

fn wp_create_nav_menu(var_menu_name rt.PhpVal) rt.PhpVal {
	return rt.new_int(wp_update_nav_menu_object(0, rt.create_array([rt.ArrayItem{ key: 'menu-name', val: var_menu_name }])))
}

fn wp_delete_nav_menu(var_menu_arg rt.PhpVal) bool {
	mut var_menu := var_menu_arg
	mut var_menu_objects := rt.new_null()
	mut var_item := rt.new_null()
	mut var_result := rt.new_null()
	mut var_locations := rt.new_null()
	mut var_menu_id := rt.new_null()
	mut var_location := rt.new_null()
	var_menu = wp_get_nav_menu_object(var_menu.clone())
	if rt.is_true(rt.new_bool(!(rt.is_true(var_menu)))) {
		return false
	}
	var_menu_objects = rt.call_function('get_objects_in_term', [rt.get_property(var_menu, 'term_id'), rt.new_string('nav_menu')])
	if !(!rt.is_true(var_menu_objects)) {
		mut iter_2 := var_menu_objects.iterator()
		for {
			item_2 := iter_2.next() or { break }
			mut var_item_shadow := item_2.val
			rt.call_function('wp_delete_post', [var_item_shadow.clone()])
		}
	}
	var_result = rt.call_function('wp_delete_term', [rt.get_property(var_menu, 'term_id'), rt.new_string('nav_menu')])
	var_locations = get_nav_menu_locations()
	mut iter_3 := var_locations.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_menu_id_shadow := item_3.val
		mut var_location_shadow := item_3.key
		if rt.is_true(rt.identical(var_menu_id_shadow, rt.get_property(var_menu, 'term_id'))) {
			var_locations.array_set(var_location_shadow, 0)
		}
	}
	rt.call_function('set_theme_mod', [rt.new_string('nav_menu_locations'), var_locations.clone()])
	if rt.is_true(var_result) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [var_result.clone()]))))) {
		rt.call_function('do_action', [rt.new_string('wp_delete_nav_menu'), rt.get_property(var_menu, 'term_id')])
	}
	return (var_result).to_bool()
}

fn wp_update_nav_menu_object(menu_id i64, var_menu_data rt.PhpVal) i64 {
	mut var_menu_id := menu_id
	mut var__menu := rt.new_null()
	mut var_args := rt.new_null()
	mut var__possible_existing := rt.new_null()
	mut var_menu_exists := rt.new_null()
	mut var_update_response := rt.new_null()
	var_menu_id = var_menu_id
	var__menu = wp_get_nav_menu_object(rt.new_int(var_menu_id))
	var_args = rt.create_array([rt.ArrayItem{ key: 'description', val: if !(var_menu_data.array_get(rt.new_string('description'))).is_null() { var_menu_data.array_get(rt.new_string('description')) } else { rt.new_string('') } }, rt.ArrayItem{ key: 'name', val: if !(var_menu_data.array_get(rt.new_string('menu-name'))).is_null() { var_menu_data.array_get(rt.new_string('menu-name')) } else { rt.new_string('') } }, rt.ArrayItem{ key: 'parent', val: if var_menu_data.array_isset(rt.new_string('parent')) { rt.new_int((var_menu_data.array_get(rt.new_string('parent'))).to_i64()) } else { 0 } }, rt.ArrayItem{ key: 'slug', val: rt.new_null() }])
	var__possible_existing = rt.call_function('get_term_by', [rt.new_string('name'), var_menu_data.array_get(rt.new_string('menu-name')), rt.new_string('nav_menu')])
	if rt.is_true(var__possible_existing) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [var__possible_existing.clone()]))))) && !(rt.get_property(var__possible_existing, 'term_id')).is_null() && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.get_property(var__possible_existing, 'term_id'), rt.new_int(var_menu_id))))) {
		return (create_wp_error(rt.new_string('menu_exists'), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('The menu name %s conflicts with another menu name. Please try another.')]), rt.new_string('<strong>' + (rt.call_function('esc_html', [var_menu_data.array_get(rt.new_string('menu-name'))])).str() + '</strong>')]))).to_i64()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var__menu)))) || rt.is_true(rt.call_function('is_wp_error', [var__menu.clone()])) {
		var_menu_exists = rt.call_function('get_term_by', [rt.new_string('name'), var_menu_data.array_get(rt.new_string('menu-name')), rt.new_string('nav_menu')])
		if rt.is_true(var_menu_exists) {
			return (create_wp_error(rt.new_string('menu_exists'), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('The menu name %s conflicts with another menu name. Please try another.')]), rt.new_string('<strong>' + (rt.call_function('esc_html', [var_menu_data.array_get(rt.new_string('menu-name'))])).str() + '</strong>')]))).to_i64()
		}
		var__menu = rt.call_function('wp_insert_term', [var_menu_data.array_get(rt.new_string('menu-name')), rt.new_string('nav_menu'), var_args.clone()])
		if rt.is_true(rt.call_function('is_wp_error', [var__menu.clone()])) {
			return (var__menu).to_i64()
		}
		rt.call_function('do_action', [rt.new_string('wp_create_nav_menu'), var__menu.array_get(rt.new_string('term_id')), rt.create_array_from_native_map(var_menu_data)])
		return rt.new_int((var__menu.array_get(rt.new_string('term_id'))).to_i64())
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var__menu)))) || !(!(rt.get_property(var__menu, 'term_id')).is_null()) {
		return 0
	}
	var_menu_id = rt.new_int((rt.get_property(var__menu, 'term_id')).to_i64())
	var_update_response = rt.call_function('wp_update_term', [rt.new_int(var_menu_id), rt.new_string('nav_menu'), var_args.clone()])
	if rt.is_true(rt.call_function('is_wp_error', [var_update_response.clone()])) {
		return (var_update_response).to_i64()
	}
	var_menu_id = rt.new_int((var_update_response.array_get(rt.new_string('term_id'))).to_i64())
	rt.call_function('do_action', [rt.new_string('wp_update_nav_menu'), rt.new_int(var_menu_id), rt.create_array_from_native_map(var_menu_data)])
	return var_menu_id
}

fn wp_update_nav_menu_item(menu_id i64, menu_item_db_id i64, var_menu_item_data rt.PhpVal, fire_after_hooks bool) rt.PhpVal {
	mut var_menu_id := menu_id
	mut var_menu_item_db_id := menu_item_db_id
	mut var_fire_after_hooks := fire_after_hooks
	mut var_menu := rt.new_null()
	mut var_defaults := map[string]rt.PhpVal{}
	mut var_args := rt.new_null()
	mut var_menu_items := rt.new_null()
	mut var_last_item := rt.new_null()
	mut var_original_parent := rt.new_null()
	mut var_original_title := rt.new_null()
	mut var_original_object := rt.new_null()
	mut var_post := rt.new_null()
	mut var_post_date := rt.new_null()
	mut var_update := rt.new_null()
	mut var_update_terms := rt.new_null()
	mut var_update_post := rt.new_null()
	var_menu_id = var_menu_id
	var_menu_item_db_id = var_menu_item_db_id
	if !(var_menu_item_db_id == 0) && !(is_nav_menu_item(var_menu_item_db_id)) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('update_nav_menu_item_failed'), rt.call_function('__', [rt.new_string('The given object ID is not that of a menu item.')])))
	}
	var_menu = wp_get_nav_menu_object(rt.new_int(var_menu_id))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_menu)))) && rt.is_true(rt.new_bool(0 != var_menu_id)) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('invalid_menu_id'), rt.call_function('__', [rt.new_string('Invalid menu ID.')])))
	}
	if rt.is_true(rt.call_function('is_wp_error', [var_menu.clone()])) {
		return var_menu.clone()
	}
	var_defaults = { 'menu-item-db-id': rt.new_int(var_menu_item_db_id), 'menu-item-object-id': rt.new_int(0), 'menu-item-object': rt.new_string(''), 'menu-item-parent-id': rt.new_int(0), 'menu-item-position': rt.new_int(0), 'menu-item-type': rt.new_string('custom'), 'menu-item-title': rt.new_string(''), 'menu-item-url': rt.new_string(''), 'menu-item-description': rt.new_string(''), 'menu-item-attr-title': rt.new_string(''), 'menu-item-target': rt.new_string(''), 'menu-item-classes': rt.new_string(''), 'menu-item-xfn': rt.new_string(''), 'menu-item-status': rt.new_string(''), 'menu-item-post-date': rt.new_string(''), 'menu-item-post-date-gmt': rt.new_string('') }
	var_args = rt.call_function('wp_parse_args', [rt.create_array_from_native_map(var_menu_item_data), rt.create_array_from_native_map(var_defaults)])
	if 0 == var_menu_id {
		var_args.array_set('menu-item-position', 1)
	} else if 0 == rt.new_int((var_args.array_get(rt.new_string('menu-item-position'))).to_i64()) {
		var_menu_items = rt.new_array()
		if rt.is_true(rt.new_bool(0 != var_menu_id)) {
		var_menu_items = rt.cast_array(rt.new_bool(wp_get_nav_menu_items(rt.new_int(var_menu_id), rt.create_array([rt.ArrayItem{ key: 'post_status', val: 'publish,draft' }]))))
		}
		var_last_item = rt.call_function('array_pop', [var_menu_items.clone()])
		if rt.is_true(var_last_item) && !(rt.get_property(var_last_item, 'menu_order')).is_null() {
			var_args.array_set('menu-item-position', rt.add(rt.new_int(1), rt.get_property(var_last_item, 'menu_order')))
		} else {
			var_args.array_set('menu-item-position', var_menu_items.clone().array_count())
		}
	}
	var_original_parent = if 0 < var_menu_item_db_id { rt.call_function('get_post_field', [rt.new_string('post_parent'), rt.new_int(var_menu_item_db_id)]) } else { rt.new_int(0) }
	if rt.is_true(rt.identical(rt.new_string('custom'), var_args.array_get(rt.new_string('menu-item-type')))) {
		var_args.array_set('menu-item-url', var_args.array_get(rt.new_string('menu-item-url')).to_string().trim_space())
	} else {
		var_args.array_set('menu-item-url', '')
		var_original_title = rt.new_string('')
		if rt.is_true(rt.identical(rt.new_string('taxonomy'), var_args.array_get(rt.new_string('menu-item-type')))) {
			var_original_object = rt.call_function('get_term', [var_args.array_get(rt.new_string('menu-item-object-id')), var_args.array_get(rt.new_string('menu-item-object'))])
			if rt.is_true(rt.new_bool(rt.instance_of(var_original_object, 'WP_Term'))) {
			var_original_parent = rt.call_function('get_term_field', [rt.new_string('parent'), var_args.array_get(rt.new_string('menu-item-object-id')), var_args.array_get(rt.new_string('menu-item-object')), rt.new_string('raw')])
			var_original_title = rt.call_function('get_term_field', [rt.new_string('name'), var_args.array_get(rt.new_string('menu-item-object-id')), var_args.array_get(rt.new_string('menu-item-object')), rt.new_string('raw')])
			}
		} else if rt.is_true(rt.identical(rt.new_string('post_type'), var_args.array_get(rt.new_string('menu-item-type')))) {
			var_original_object = rt.call_function('get_post', [var_args.array_get(rt.new_string('menu-item-object-id'))])
			if rt.is_true(rt.new_bool(rt.instance_of(var_original_object, 'WP_Post'))) {
			var_original_parent = rt.new_int((rt.get_property(var_original_object, 'post_parent')).to_i64())
			var_original_title = rt.get_property(var_original_object, 'post_title')
			}
		} else if rt.is_true(rt.identical(rt.new_string('post_type_archive'), var_args.array_get(rt.new_string('menu-item-type')))) {
			var_original_object = rt.call_function('get_post_type_object', [var_args.array_get(rt.new_string('menu-item-object'))])
			if rt.is_true(rt.new_bool(rt.instance_of(var_original_object, 'WP_Post_Type'))) {
			var_original_title = rt.get_property(rt.get_property(var_original_object, 'labels'), 'archives')
			}
		}
		if rt.is_true(rt.identical(rt.call_function('wp_unslash', [var_args.array_get(rt.new_string('menu-item-title'))]), var_original_title)) {
			var_args.array_set('menu-item-title', '')
		}
		if rt.is_true(rt.identical(rt.new_string(''), var_args.array_get(rt.new_string('menu-item-title')))) && rt.is_true(rt.identical(rt.new_string(''), var_args.array_get(rt.new_string('menu-item-description')))) {
			var_args.array_set('menu-item-description', ' ')
		}
	}
	var_post = rt.create_array([rt.ArrayItem{ key: 'menu_order', val: var_args.array_get(rt.new_string('menu-item-position')) }, rt.ArrayItem{ key: 'ping_status', val: 0 }, rt.ArrayItem{ key: 'post_content', val: var_args.array_get(rt.new_string('menu-item-description')) }, rt.ArrayItem{ key: 'post_excerpt', val: var_args.array_get(rt.new_string('menu-item-attr-title')) }, rt.ArrayItem{ key: 'post_parent', val: var_original_parent }, rt.ArrayItem{ key: 'post_title', val: var_args.array_get(rt.new_string('menu-item-title')) }, rt.ArrayItem{ key: 'post_type', val: 'nav_menu_item' }])
	var_post_date = rt.call_function('wp_resolve_post_date', [var_args.array_get(rt.new_string('menu-item-post-date')), var_args.array_get(rt.new_string('menu-item-post-date-gmt'))])
	if rt.is_true(var_post_date) {
		var_post.array_set('post_date', var_post_date.clone())
	}
	var_update = rt.new_bool(0 != var_menu_item_db_id)
	if rt.is_true(rt.new_bool(!(rt.is_true(var_update)))) {
		var_post.array_set('ID', 0)
		var_post.array_set('post_status', if rt.is_true(rt.identical(rt.new_string('publish'), var_args.array_get(rt.new_string('menu-item-status')))) { 'publish' } else { 'draft' })
		var_menu_item_db_id = (rt.call_function('wp_insert_post', [var_post.clone(), rt.new_bool(true), rt.new_bool(fire_after_hooks)])).to_i64()
		if !(var_menu_item_db_id != 0) || rt.is_true(rt.call_function('is_wp_error', [rt.new_int(var_menu_item_db_id)])) {
			return rt.new_int(var_menu_item_db_id)
		}
		rt.call_function('do_action', [rt.new_string('wp_add_nav_menu_item'), rt.new_int(var_menu_id), rt.new_int(var_menu_item_db_id), var_args.clone()])
	}
	if var_menu_id != 0 && rt.is_true(rt.new_bool(!(rt.is_true(var_update)))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_object_in_term', [rt.new_int(var_menu_item_db_id), rt.new_string('nav_menu'), rt.new_int((rt.get_property(var_menu, 'term_id')).to_i64())]))))) {
		var_update_terms = rt.call_function('wp_set_object_terms', [rt.new_int(var_menu_item_db_id), rt.create_array([rt.ArrayItem{ key: none, val: rt.get_property(var_menu, 'term_id') }]), rt.new_string('nav_menu')])
		if rt.is_true(rt.call_function('is_wp_error', [var_update_terms.clone()])) {
			return var_update_terms.clone()
		}
	}
	if rt.is_true(rt.identical(rt.new_string('custom'), var_args.array_get(rt.new_string('menu-item-type')))) {
		var_args.array_set('menu-item-object-id', var_menu_item_db_id)
		var_args.array_set('menu-item-object', 'custom')
	}
	var_menu_item_db_id = var_menu_item_db_id
	if rt.new_int((var_args.array_get(rt.new_string('menu-item-parent-id'))).to_i64()) == var_menu_item_db_id {
		var_args.array_set('menu-item-parent-id', 0)
	}
	rt.call_function('update_post_meta', [rt.new_int(var_menu_item_db_id), rt.new_string('_menu_item_type'), rt.call_function('sanitize_key', [var_args.array_get(rt.new_string('menu-item-type'))])])
	rt.call_function('update_post_meta', [rt.new_int(var_menu_item_db_id), rt.new_string('_menu_item_menu_item_parent'), rt.new_string((rt.new_int((var_args.array_get(rt.new_string('menu-item-parent-id'))).to_i64()).str()).str())])
	rt.call_function('update_post_meta', [rt.new_int(var_menu_item_db_id), rt.new_string('_menu_item_object_id'), rt.new_string((rt.new_int((var_args.array_get(rt.new_string('menu-item-object-id'))).to_i64()).str()).str())])
	rt.call_function('update_post_meta', [rt.new_int(var_menu_item_db_id), rt.new_string('_menu_item_object'), rt.call_function('sanitize_key', [var_args.array_get(rt.new_string('menu-item-object'))])])
	rt.call_function('update_post_meta', [rt.new_int(var_menu_item_db_id), rt.new_string('_menu_item_target'), rt.call_function('sanitize_key', [var_args.array_get(rt.new_string('menu-item-target'))])])
	var_args.array_set('menu-item-classes', rt.call_function('array_map', [rt.new_string('sanitize_html_class'), rt.call_function('explode', [rt.new_string(' '), var_args.array_get(rt.new_string('menu-item-classes'))])]))
	var_args.array_set('menu-item-xfn', rt.call_function('implode', [rt.new_string(' '), rt.call_function('array_map', [rt.new_string('sanitize_html_class'), rt.call_function('explode', [rt.new_string(' '), var_args.array_get(rt.new_string('menu-item-xfn'))])])]))
	rt.call_function('update_post_meta', [rt.new_int(var_menu_item_db_id), rt.new_string('_menu_item_classes'), var_args.array_get(rt.new_string('menu-item-classes'))])
	rt.call_function('update_post_meta', [rt.new_int(var_menu_item_db_id), rt.new_string('_menu_item_xfn'), var_args.array_get(rt.new_string('menu-item-xfn'))])
	rt.call_function('update_post_meta', [rt.new_int(var_menu_item_db_id), rt.new_string('_menu_item_url'), rt.call_function('sanitize_url', [var_args.array_get(rt.new_string('menu-item-url'))])])
	if 0 == var_menu_id {
		rt.call_function('update_post_meta', [rt.new_int(var_menu_item_db_id), rt.new_string('_menu_item_orphaned'), rt.new_string((rt.call_function('time', []rt.PhpVal{})).str())])
	} else if rt.is_true(rt.call_function('get_post_meta', [rt.new_int(var_menu_item_db_id), rt.new_string('_menu_item_orphaned')])) {
		rt.call_function('delete_post_meta', [rt.new_int(var_menu_item_db_id), rt.new_string('_menu_item_orphaned')])
	}
	if rt.is_true(var_update) {
		var_post.array_set('ID', var_menu_item_db_id)
		var_post.array_set('post_status', if rt.is_true(rt.identical(rt.new_string('draft'), var_args.array_get(rt.new_string('menu-item-status')))) { 'draft' } else { 'publish' })
		var_update_post = rt.call_function('wp_update_post', [var_post.clone(), rt.new_bool(true)])
		if rt.is_true(rt.call_function('is_wp_error', [var_update_post.clone()])) {
			return var_update_post.clone()
		}
	}
	rt.call_function('do_action', [rt.new_string('wp_update_nav_menu_item'), rt.new_int(var_menu_id), rt.new_int(var_menu_item_db_id), var_args.clone()])
	return rt.new_int(var_menu_item_db_id)
}

fn wp_get_nav_menus(var_args_arg rt.PhpVal) rt.PhpVal {
	mut var_args := var_args_arg
	mut var_defaults := map[string]rt.PhpVal{}
	var_defaults = { 'taxonomy': rt.new_string('nav_menu'), 'hide_empty': rt.new_bool(false), 'orderby': rt.new_string('name') }
	var_args = rt.call_function('wp_parse_args', [var_args.clone(), rt.create_array_from_native_map(var_defaults)])
	return rt.call_function('apply_filters', [rt.new_string('wp_get_nav_menus'), rt.call_function('get_terms', [var_args.clone()]), var_args.clone()])
}

fn _is_valid_nav_menu_item(var_item rt.PhpVal) rt.PhpVal {
	return rt.new_bool(!rt.is_true(rt.get_property(var_item, '_invalid')))
}

fn wp_get_nav_menu_items(var_menu_arg rt.PhpVal, var_args_arg rt.PhpVal) bool {
	mut var_menu := var_menu_arg
	mut var_args := var_args_arg
	mut var_defaults := map[string]rt.PhpVal{}
	mut var_items := rt.new_null()
	mut var_i := i64(0)
	mut var_item := rt.new_null()
	mut var_k := rt.new_null()
	var_menu = wp_get_nav_menu_object(var_menu.clone())
	if rt.is_true(rt.new_bool(!(rt.is_true(var_menu)))) {
		return false
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('taxonomy_exists', [rt.new_string('nav_menu')]))))) {
		return false
	}
	var_defaults = { 'order': rt.new_string('ASC'), 'orderby': rt.new_string('menu_order'), 'post_type': rt.new_string('nav_menu_item'), 'post_status': rt.new_string('publish'), 'output': rt.get_constant('ARRAY_A'), 'output_key': rt.new_string('menu_order'), 'nopaging': rt.new_bool(true), 'update_menu_item_cache': rt.new_bool(true), 'tax_query': map[string]rt.PhpVal{} }
	var_args = rt.call_function('wp_parse_args', [var_args.clone(), rt.create_array_from_native_map(var_defaults)])
	if rt.is_true(rt.greater(rt.get_property(var_menu, 'count'), rt.new_int(0))) {
	var_items = rt.call_function('get_posts', [var_args.clone()])
	} else {
	var_items = rt.new_array()
	}
	var_items = rt.call_function('array_map', [rt.new_string('wp_setup_nav_menu_item'), var_items.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_admin', []rt.PhpVal{}))))) {
	var_items = rt.call_function('array_filter', [var_items.clone(), rt.new_string('_is_valid_nav_menu_item')])
	}
	if rt.is_true(rt.identical(rt.get_constant('ARRAY_A'), var_args.array_get(rt.new_string('output')))) {
		var_items = rt.call_function('wp_list_sort', [var_items.clone(), rt.create_array([rt.ArrayItem{ key: var_args.array_get(rt.new_string('output_key')), val: 'ASC' }])])
		var_i = 1
		mut iter_4 := var_items.iterator()
		for {
			item_4 := iter_4.next() or { break }
			mut var_item_shadow := item_4.val
			mut var_k_shadow := item_4.key
			rt.set_property(var_items.array_get(var_k_shadow), '{"nodeType":"Expr_ArrayDimFetch","line":764,"var":{"nodeType":"Expr_Variable","line":764,"name":"args"},"dim":{"nodeType":"Scalar_String","line":764,"value":"output_key"}}', rt.post_inc(rt.new_int(var_i)))
		}
	}
	return (rt.call_function('apply_filters', [rt.new_string('wp_get_nav_menu_items'), var_items.clone(), var_menu.clone(), var_args.clone()])).to_bool()
}

fn update_menu_item_cache(var_menu_items rt.PhpVal) {
	mut var_post_ids := []rt.PhpVal{}
	mut var_term_ids := []rt.PhpVal{}
	mut var_menu_item := rt.new_null()
	mut var_object_id := rt.new_null()
	mut var_type := rt.new_null()
	var_post_ids = rt.new_array()
	var_term_ids = rt.new_array()
	mut iter_5 := var_menu_items.iterator()
	for {
		item_5 := iter_5.next() or { break }
		mut var_menu_item_shadow := item_5.val
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('nav_menu_item'), rt.get_property(var_menu_item_shadow, 'post_type'))))) {
			continue
		}
		var_object_id = rt.call_function('get_post_meta', [rt.get_property(var_menu_item_shadow, 'ID'), rt.new_string('_menu_item_object_id'), rt.new_bool(true)])
		var_type = rt.call_function('get_post_meta', [rt.get_property(var_menu_item_shadow, 'ID'), rt.new_string('_menu_item_type'), rt.new_bool(true)])
		if rt.is_true(rt.identical(rt.new_string('post_type'), var_type)) {
			var_post_ids << rt.new_int((var_object_id).to_i64())
		} else if rt.is_true(rt.identical(rt.new_string('taxonomy'), var_type)) {
			var_term_ids << rt.new_int((var_object_id).to_i64())
		}
	}
	if !(!rt.is_true(var_post_ids)) {
		rt.call_function('_prime_post_caches', [rt.create_array_from_list(var_post_ids), rt.new_bool(false)])
	}
	if !(!rt.is_true(var_term_ids)) {
		rt.call_function('_prime_term_caches', [rt.create_array_from_list(var_term_ids)])
	}
}

fn wp_setup_nav_menu_item(var_menu_item rt.PhpVal) rt.PhpVal {
	mut var_pre_menu_item := rt.new_null()
	mut var_object := rt.new_null()
	mut var_menu_post := rt.new_null()
	mut var_post_states := rt.new_null()
	mut var_original_object := rt.new_null()
	mut var_original_title := rt.new_null()
	mut var_post_type_description := rt.new_null()
	mut var_post_content := rt.new_null()
	var_pre_menu_item = rt.call_function('apply_filters', [rt.new_string('pre_wp_setup_nav_menu_item'), rt.new_null(), var_menu_item.clone()])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_pre_menu_item)))) {
		return var_pre_menu_item.clone()
	}
	if !(rt.get_property(var_menu_item, 'post_type')).is_null() {
		if rt.is_true(rt.identical(rt.new_string('nav_menu_item'), rt.get_property(var_menu_item, 'post_type'))) {
			rt.set_property(var_menu_item, 'db_id', rt.new_int((rt.get_property(var_menu_item, 'ID')).to_i64()))
			rt.set_property(var_menu_item, 'menu_item_parent', if !(!(rt.get_property(var_menu_item, 'menu_item_parent')).is_null()) { rt.call_function('get_post_meta', [rt.get_property(var_menu_item, 'ID'), rt.new_string('_menu_item_menu_item_parent'), rt.new_bool(true)]) } else { rt.get_property(var_menu_item, 'menu_item_parent') })
			rt.set_property(var_menu_item, 'object_id', if !(!(rt.get_property(var_menu_item, 'object_id')).is_null()) { rt.call_function('get_post_meta', [rt.get_property(var_menu_item, 'ID'), rt.new_string('_menu_item_object_id'), rt.new_bool(true)]) } else { rt.get_property(var_menu_item, 'object_id') })
			rt.set_property(var_menu_item, 'object', if !(!(rt.get_property(var_menu_item, 'object')).is_null()) { rt.call_function('get_post_meta', [rt.get_property(var_menu_item, 'ID'), rt.new_string('_menu_item_object'), rt.new_bool(true)]) } else { rt.get_property(var_menu_item, 'object') })
			rt.set_property(var_menu_item, 'type', if !(!(rt.get_property(var_menu_item, 'type')).is_null()) { rt.call_function('get_post_meta', [rt.get_property(var_menu_item, 'ID'), rt.new_string('_menu_item_type'), rt.new_bool(true)]) } else { rt.get_property(var_menu_item, 'type') })
			if rt.is_true(rt.identical(rt.new_string('post_type'), rt.get_property(var_menu_item, 'type'))) {
				var_object = rt.call_function('get_post_type_object', [rt.get_property(var_menu_item, 'object')])
				if rt.is_true(var_object) {
					rt.set_property(var_menu_item, 'type_label', rt.get_property(rt.get_property(var_object, 'labels'), 'singular_name'))
					if rt.is_true(rt.call_function('function_exists', [rt.new_string('get_post_states')])) {
						var_menu_post = rt.call_function('get_post', [rt.get_property(var_menu_item, 'object_id')])
						if rt.is_true(rt.new_bool(rt.instance_of(var_menu_post, 'WP_Post'))) {
							var_post_states = rt.call_function('get_post_states', [var_menu_post.clone()])
							if rt.is_true(var_post_states) {
								rt.set_property(var_menu_item, 'type_label', rt.call_function('wp_strip_all_tags', [rt.call_function('implode', [rt.new_string(', '), var_post_states.clone()])]))
							}
						}
					}
				} else {
					rt.set_property(var_menu_item, 'type_label', rt.get_property(var_menu_item, 'object'))
					rt.set_property(var_menu_item, '_invalid', rt.new_bool(true))
				}
				if rt.is_true(rt.identical(rt.new_string('trash'), rt.call_function('get_post_status', [rt.get_property(var_menu_item, 'object_id')]))) {
					rt.set_property(var_menu_item, '_invalid', rt.new_bool(true))
				}
				var_original_object = rt.call_function('get_post', [rt.get_property(var_menu_item, 'object_id')])
				if rt.is_true(var_original_object) {
					rt.set_property(var_menu_item, 'url', rt.call_function('get_permalink', [rt.get_property(var_original_object, 'ID')]))
				var_original_title = rt.call_function('apply_filters', [rt.new_string('the_title'), rt.get_property(var_original_object, 'post_title'), rt.get_property(var_original_object, 'ID')])
				} else {
					rt.set_property(var_menu_item, 'url', rt.new_string(''))
					var_original_title = rt.new_string('')
					rt.set_property(var_menu_item, '_invalid', rt.new_bool(true))
				}
				if rt.is_true(rt.identical(rt.new_string(''), var_original_title)) {
				var_original_title = rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('#%d (no title)')]), rt.get_property(var_menu_item, 'object_id')])
				}
				rt.set_property(var_menu_item, 'title', if rt.is_true(rt.identical(rt.new_string(''), rt.get_property(var_menu_item, 'post_title'))) { var_original_title } else { rt.get_property(var_menu_item, 'post_title') })
			} else if rt.is_true(rt.identical(rt.new_string('post_type_archive'), rt.get_property(var_menu_item, 'type'))) {
				var_object = rt.call_function('get_post_type_object', [rt.get_property(var_menu_item, 'object')])
				if rt.is_true(var_object) {
					rt.set_property(var_menu_item, 'title', if rt.is_true(rt.identical(rt.new_string(''), rt.get_property(var_menu_item, 'post_title'))) { rt.get_property(rt.get_property(var_object, 'labels'), 'archives') } else { rt.get_property(var_menu_item, 'post_title') })
				var_post_type_description = rt.get_property(var_object, 'description')
				} else {
					var_post_type_description = rt.new_string('')
					rt.set_property(var_menu_item, '_invalid', rt.new_bool(true))
				}
				rt.set_property(var_menu_item, 'type_label', rt.call_function('__', [rt.new_string('Post Type Archive')]))
				var_post_content = rt.call_function('wp_trim_words', [rt.get_property(var_menu_item, 'post_content'), rt.new_int(200)])
				var_post_type_description = if rt.is_true(rt.identical(rt.new_string(''), var_post_content)) { var_post_type_description } else { var_post_content }
				rt.set_property(var_menu_item, 'url', rt.call_function('get_post_type_archive_link', [rt.get_property(var_menu_item, 'object')]))
			} else if rt.is_true(rt.identical(rt.new_string('taxonomy'), rt.get_property(var_menu_item, 'type'))) {
				var_object = rt.call_function('get_taxonomy', [rt.get_property(var_menu_item, 'object')])
				if rt.is_true(var_object) {
					rt.set_property(var_menu_item, 'type_label', rt.get_property(rt.get_property(var_object, 'labels'), 'singular_name'))
				} else {
					rt.set_property(var_menu_item, 'type_label', rt.get_property(var_menu_item, 'object'))
					rt.set_property(var_menu_item, '_invalid', rt.new_bool(true))
				}
				var_original_object = rt.call_function('get_term', [rt.new_int((rt.get_property(var_menu_item, 'object_id')).to_i64()), rt.get_property(var_menu_item, 'object')])
				if rt.is_true(var_original_object) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [var_original_object.clone()]))))) {
					rt.set_property(var_menu_item, 'url', rt.call_function('get_term_link', [rt.new_int((rt.get_property(var_menu_item, 'object_id')).to_i64()), rt.get_property(var_menu_item, 'object')]))
				var_original_title = rt.get_property(var_original_object, 'name')
				} else {
					rt.set_property(var_menu_item, 'url', rt.new_string(''))
					var_original_title = rt.new_string('')
					rt.set_property(var_menu_item, '_invalid', rt.new_bool(true))
				}
				if rt.is_true(rt.identical(rt.new_string(''), var_original_title)) {
				var_original_title = rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('#%d (no title)')]), rt.get_property(var_menu_item, 'object_id')])
				}
				rt.set_property(var_menu_item, 'title', if rt.is_true(rt.identical(rt.new_string(''), rt.get_property(var_menu_item, 'post_title'))) { var_original_title } else { rt.get_property(var_menu_item, 'post_title') })
			} else {
				rt.set_property(var_menu_item, 'type_label', rt.call_function('__', [rt.new_string('Custom Link')]))
				rt.set_property(var_menu_item, 'title', rt.get_property(var_menu_item, 'post_title'))
				rt.set_property(var_menu_item, 'url', if !(!(rt.get_property(var_menu_item, 'url')).is_null()) { rt.call_function('get_post_meta', [rt.get_property(var_menu_item, 'ID'), rt.new_string('_menu_item_url'), rt.new_bool(true)]) } else { rt.get_property(var_menu_item, 'url') })
			}
			rt.set_property(var_menu_item, 'target', if !(!(rt.get_property(var_menu_item, 'target')).is_null()) { rt.call_function('get_post_meta', [rt.get_property(var_menu_item, 'ID'), rt.new_string('_menu_item_target'), rt.new_bool(true)]) } else { rt.get_property(var_menu_item, 'target') })
			rt.set_property(var_menu_item, 'attr_title', if !(!(rt.get_property(var_menu_item, 'attr_title')).is_null()) { rt.call_function('apply_filters', [rt.new_string('nav_menu_attr_title'), rt.get_property(var_menu_item, 'post_excerpt')]) } else { rt.get_property(var_menu_item, 'attr_title') })
			if !(!(rt.get_property(var_menu_item, 'description')).is_null()) {
				rt.set_property(var_menu_item, 'description', rt.call_function('apply_filters', [rt.new_string('nav_menu_description'), rt.call_function('wp_trim_words', [rt.get_property(var_menu_item, 'post_content'), rt.new_int(200)])]))
			}
			rt.set_property(var_menu_item, 'classes', if !(!(rt.get_property(var_menu_item, 'classes')).is_null()) { rt.cast_array(rt.call_function('get_post_meta', [rt.get_property(var_menu_item, 'ID'), rt.new_string('_menu_item_classes'), rt.new_bool(true)])) } else { rt.get_property(var_menu_item, 'classes') })
			rt.set_property(var_menu_item, 'xfn', if !(!(rt.get_property(var_menu_item, 'xfn')).is_null()) { rt.call_function('get_post_meta', [rt.get_property(var_menu_item, 'ID'), rt.new_string('_menu_item_xfn'), rt.new_bool(true)]) } else { rt.get_property(var_menu_item, 'xfn') })
		} else {
			rt.set_property(var_menu_item, 'db_id', rt.new_int(0))
			rt.set_property(var_menu_item, 'menu_item_parent', rt.new_int(0))
			rt.set_property(var_menu_item, 'object_id', rt.new_int((rt.get_property(var_menu_item, 'ID')).to_i64()))
			rt.set_property(var_menu_item, 'type', rt.new_string('post_type'))
			var_object = rt.call_function('get_post_type_object', [rt.get_property(var_menu_item, 'post_type')])
			rt.set_property(var_menu_item, 'object', rt.get_property(var_object, 'name'))
			rt.set_property(var_menu_item, 'type_label', rt.get_property(rt.get_property(var_object, 'labels'), 'singular_name'))
			if rt.is_true(rt.identical(rt.new_string(''), rt.get_property(var_menu_item, 'post_title'))) {
				rt.set_property(var_menu_item, 'post_title', rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('#%d (no title)')]), rt.get_property(var_menu_item, 'ID')]))
			}
			rt.set_property(var_menu_item, 'title', rt.get_property(var_menu_item, 'post_title'))
			rt.set_property(var_menu_item, 'url', rt.call_function('get_permalink', [rt.get_property(var_menu_item, 'ID')]))
			rt.set_property(var_menu_item, 'target', rt.new_string(''))
			rt.set_property(var_menu_item, 'attr_title', rt.call_function('apply_filters', [rt.new_string('nav_menu_attr_title'), rt.new_string('')]))
			rt.set_property(var_menu_item, 'description', rt.call_function('apply_filters', [rt.new_string('nav_menu_description'), rt.new_string('')]))
			rt.set_property(var_menu_item, 'classes', rt.new_array())
			rt.set_property(var_menu_item, 'xfn', rt.new_string(''))
		}
	} else if !(rt.get_property(var_menu_item, 'taxonomy')).is_null() {
		rt.set_property(var_menu_item, 'ID', rt.get_property(var_menu_item, 'term_id'))
		rt.set_property(var_menu_item, 'db_id', rt.new_int(0))
		rt.set_property(var_menu_item, 'menu_item_parent', rt.new_int(0))
		rt.set_property(var_menu_item, 'object_id', rt.new_int((rt.get_property(var_menu_item, 'term_id')).to_i64()))
		rt.set_property(var_menu_item, 'post_parent', rt.new_int((rt.get_property(var_menu_item, 'parent')).to_i64()))
		rt.set_property(var_menu_item, 'type', rt.new_string('taxonomy'))
		var_object = rt.call_function('get_taxonomy', [rt.get_property(var_menu_item, 'taxonomy')])
		rt.set_property(var_menu_item, 'object', rt.get_property(var_object, 'name'))
		rt.set_property(var_menu_item, 'type_label', rt.get_property(rt.get_property(var_object, 'labels'), 'singular_name'))
		rt.set_property(var_menu_item, 'title', rt.get_property(var_menu_item, 'name'))
		rt.set_property(var_menu_item, 'url', rt.call_function('get_term_link', [var_menu_item.clone(), rt.get_property(var_menu_item, 'taxonomy')]))
		rt.set_property(var_menu_item, 'target', rt.new_string(''))
		rt.set_property(var_menu_item, 'attr_title', rt.new_string(''))
		rt.set_property(var_menu_item, 'description', rt.call_function('get_term_field', [rt.new_string('description'), rt.get_property(var_menu_item, 'term_id'), rt.get_property(var_menu_item, 'taxonomy')]))
		rt.set_property(var_menu_item, 'classes', rt.new_array())
		rt.set_property(var_menu_item, 'xfn', rt.new_string(''))
	}
	return rt.call_function('apply_filters', [rt.new_string('wp_setup_nav_menu_item'), var_menu_item.clone()])
}

fn wp_get_associated_nav_menu_items(object_id i64, object_type string, taxonomy string) rt.PhpVal {
	mut var_object_id := object_id
	mut var_object_type := object_type
	mut var_taxonomy := taxonomy
	mut var_menu_item_ids := rt.new_null()
	mut var_query := rt.new_null()
	mut var_menu_items := rt.new_null()
	mut var_menu_item := rt.new_null()
	mut var_menu_item_type := rt.new_null()
	var_object_id = var_object_id
	var_menu_item_ids = rt.new_array()
	var_query = create_wp_query()
	var_menu_items = var_query.query(rt.create_array([rt.ArrayItem{ key: 'meta_key', val: '_menu_item_object_id' }, rt.ArrayItem{ key: 'meta_value', val: var_object_id }, rt.ArrayItem{ key: 'post_status', val: 'any' }, rt.ArrayItem{ key: 'post_type', val: 'nav_menu_item' }, rt.ArrayItem{ key: 'posts_per_page', val: -1 }]))
	mut iter_6 := rt.cast_array(var_menu_items).iterator()
	for {
		item_6 := iter_6.next() or { break }
		mut var_menu_item_shadow := item_6.val
		if !(rt.get_property(var_menu_item_shadow, 'ID')).is_null() && is_nav_menu_item(rt.get_property(var_menu_item_shadow, 'ID')) {
			var_menu_item_type = rt.call_function('get_post_meta', [rt.get_property(var_menu_item_shadow, 'ID'), rt.new_string('_menu_item_type'), rt.new_bool(true)])
			if rt.is_true(rt.identical(rt.new_string('post_type'), rt.new_string(object_type))) && rt.is_true(rt.identical(rt.new_string('post_type'), var_menu_item_type)) {
				var_menu_item_ids.array_push(rt.new_int((rt.get_property(var_menu_item_shadow, 'ID')).to_i64()))
			} else if rt.is_true(rt.identical(rt.new_string('taxonomy'), rt.new_string(object_type))) && rt.is_true(rt.identical(rt.new_string('taxonomy'), var_menu_item_type)) && rt.is_true(rt.identical(rt.call_function('get_post_meta', [rt.get_property(var_menu_item_shadow, 'ID'), rt.new_string('_menu_item_object'), rt.new_bool(true)]), rt.new_string(taxonomy))) {
				var_menu_item_ids.array_push(rt.new_int((rt.get_property(var_menu_item_shadow, 'ID')).to_i64()))
			}
		}
	}
	return rt.call_function('array_unique', [var_menu_item_ids.clone()])
}

fn _wp_delete_post_menu_item(var_object_id_arg rt.PhpVal) {
	mut var_object_id := var_object_id_arg
	mut var_menu_item_ids := rt.new_null()
	mut var_menu_item_id := rt.new_null()
	var_object_id = rt.new_int((var_object_id).to_i64())
	var_menu_item_ids = wp_get_associated_nav_menu_items(var_object_id.clone(), 'post_type', '')
	mut iter_7 := rt.cast_array(var_menu_item_ids).iterator()
	for {
		item_7 := iter_7.next() or { break }
		mut var_menu_item_id_shadow := item_7.val
		rt.call_function('wp_delete_post', [var_menu_item_id_shadow.clone(), rt.new_bool(true)])
	}
}

fn _wp_delete_tax_menu_item(var_object_id_arg rt.PhpVal, var_tt_id rt.PhpVal, var_taxonomy rt.PhpVal) {
	mut var_object_id := var_object_id_arg
	mut var_menu_item_ids := rt.new_null()
	mut var_menu_item_id := rt.new_null()
	var_object_id = rt.new_int((var_object_id).to_i64())
	var_menu_item_ids = wp_get_associated_nav_menu_items(var_object_id.clone(), 'taxonomy', var_taxonomy.clone())
	mut iter_8 := rt.cast_array(var_menu_item_ids).iterator()
	for {
		item_8 := iter_8.next() or { break }
		mut var_menu_item_id_shadow := item_8.val
		rt.call_function('wp_delete_post', [var_menu_item_id_shadow.clone(), rt.new_bool(true)])
	}
}

fn _wp_auto_add_pages_to_menu(var_new_status rt.PhpVal, var_old_status rt.PhpVal, var_post rt.PhpVal) {
	mut var_auto_add := rt.new_null()
	mut var_args := rt.new_null()
	mut var_menu_id := rt.new_null()
	mut var_items := false
	mut var_item := rt.new_null()
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('publish'), var_new_status)))) || rt.is_true(rt.identical(rt.new_string('publish'), var_old_status)) || rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('page'), rt.get_property(var_post, 'post_type'))))) {
		return
	}
	if !(!rt.is_true(rt.get_property(var_post, 'post_parent'))) {
		return
	}
	var_auto_add = rt.call_function('get_option', [rt.new_string('nav_menu_options')])
	if !rt.is_true(var_auto_add) || !(var_auto_add.clone().is_array()) || !(var_auto_add.array_isset(rt.new_string('auto_add'))) {
		return
	}
	var_auto_add = var_auto_add.array_get(rt.new_string('auto_add'))
	if !rt.is_true(var_auto_add) || !(var_auto_add.clone().is_array()) {
		return
	}
	var_args = rt.create_array([rt.ArrayItem{ key: 'menu-item-object-id', val: rt.get_property(var_post, 'ID') }, rt.ArrayItem{ key: 'menu-item-object', val: rt.get_property(var_post, 'post_type') }, rt.ArrayItem{ key: 'menu-item-type', val: 'post_type' }, rt.ArrayItem{ key: 'menu-item-status', val: 'publish' }])
	mut iter_9 := var_auto_add.iterator()
	for {
		item_9 := iter_9.next() or { break }
		mut var_menu_id_shadow := item_9.val
		var_items = wp_get_nav_menu_items(var_menu_id_shadow.clone(), rt.create_array([rt.ArrayItem{ key: 'post_status', val: 'publish,draft' }]))
		if !(rt.new_bool(var_items).clone().is_array()) {
			continue
		}
		mut iter_10 := rt.new_bool(var_items).iterator()
		for {
			item_10 := iter_10.next() or { break }
			mut var_item_shadow := item_10.val
			if rt.is_true(rt.identical(rt.get_property(var_post, 'ID'), rt.new_int((rt.get_property(var_item_shadow, 'object_id')).to_i64()))) {
				continue
			}
		}
		wp_update_nav_menu_item(var_menu_id_shadow.clone(), 0, var_args.clone(), false)
	}
}

fn _wp_delete_customize_changeset_dependent_auto_drafts(var_post_id rt.PhpVal) {
	mut var_post := rt.new_null()
	mut var_data := rt.new_null()
	mut var_stub_post_id := rt.new_null()
	var_post = rt.call_function('get_post', [var_post_id.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_post)))) || rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('customize_changeset'), rt.get_property(var_post, 'post_type'))))) {
		return
	}
	var_data = rt.call_function('json_decode', [rt.get_property(var_post, 'post_content'), rt.new_bool(true)])
	if !rt.is_true(var_data.array_get(rt.new_string('nav_menus_created_posts')).array_get(rt.new_string('value'))) {
		return
	}
	rt.call_function('remove_action', [rt.new_string('delete_post'), rt.new_string('_wp_delete_customize_changeset_dependent_auto_drafts')])
	mut iter_11 := var_data.array_get(rt.new_string('nav_menus_created_posts')).array_get(rt.new_string('value')).iterator()
	for {
		item_11 := iter_11.next() or { break }
		mut var_stub_post_id_shadow := item_11.val
		if !rt.is_true(var_stub_post_id_shadow) {
			continue
		}
		if rt.is_true(rt.identical(rt.new_string('auto-draft'), rt.call_function('get_post_status', [var_stub_post_id_shadow.clone()]))) {
			rt.call_function('wp_delete_post', [var_stub_post_id_shadow.clone(), rt.new_bool(true)])
		} else if rt.is_true(rt.identical(rt.new_string('draft'), rt.call_function('get_post_status', [var_stub_post_id_shadow.clone()]))) {
			rt.call_function('wp_trash_post', [var_stub_post_id_shadow.clone()])
			rt.call_function('delete_post_meta', [var_stub_post_id_shadow.clone(), rt.new_string('_customize_changeset_uuid')])
		}
	}
	rt.call_function('add_action', [rt.new_string('delete_post'), rt.new_string('_wp_delete_customize_changeset_dependent_auto_drafts')])
}

fn _wp_menus_changed() {
	mut var_old_nav_menu_locations := rt.new_null()
	mut var_new_nav_menu_locations := rt.new_null()
	mut var_mapped_nav_menu_locations := rt.new_null()
	var_old_nav_menu_locations = rt.call_function('get_option', [rt.new_string('theme_switch_menu_locations'), rt.new_array()])
	var_new_nav_menu_locations = get_nav_menu_locations()
	var_mapped_nav_menu_locations = wp_map_nav_menu_locations(var_new_nav_menu_locations.clone(), var_old_nav_menu_locations.clone())
	rt.call_function('set_theme_mod', [rt.new_string('nav_menu_locations'), var_mapped_nav_menu_locations.clone()])
	rt.call_function('delete_option', [rt.new_string('theme_switch_menu_locations')])
}

fn wp_map_nav_menu_locations(var_new_nav_menu_locations_arg rt.PhpVal, var_old_nav_menu_locations rt.PhpVal) rt.PhpVal {
	mut var_new_nav_menu_locations := var_new_nav_menu_locations_arg
	mut var_registered_nav_menus := rt.new_null()
	mut var_old_locations := rt.new_null()
	mut var_name := rt.new_null()
	mut var_location := rt.new_null()
	mut var_common_slug_groups := []rt.PhpVal{}
	mut var_slug_group := rt.new_null()
	mut var_slug := rt.new_null()
	mut var_new_location := rt.new_null()
	mut var_menu_id := rt.new_null()
	var_registered_nav_menus = get_registered_nav_menus()
	var_new_nav_menu_locations = rt.call_function('array_intersect_key', [var_new_nav_menu_locations.clone(), var_registered_nav_menus.clone()])
	if !rt.is_true(var_old_nav_menu_locations) {
		return var_new_nav_menu_locations.clone()
	}
	if 1 == var_old_nav_menu_locations.clone().array_count() && 1 == var_registered_nav_menus.clone().array_count() {
		var_new_nav_menu_locations.array_set(rt.call_function('key', [var_registered_nav_menus.clone()]), rt.call_function('array_pop', [var_old_nav_menu_locations.clone()]))
		return var_new_nav_menu_locations.clone()
	}
	var_old_locations = rt.func_array_keys(var_old_nav_menu_locations.clone())
	mut iter_12 := var_registered_nav_menus.iterator()
	for {
		item_12 := iter_12.next() or { break }
		mut var_name_shadow := item_12.val
		mut var_location_shadow := item_12.key
		if rt.is_true(rt.call_function('in_array', [var_location_shadow.clone(), var_old_locations.clone(), rt.new_bool(true)])) {
			var_new_nav_menu_locations.array_set(var_location_shadow, var_old_nav_menu_locations.array_get(var_location_shadow))
			var_old_nav_menu_locations.array_unset(var_location_shadow)
		}
	}
	if !rt.is_true(var_old_nav_menu_locations) {
		return var_new_nav_menu_locations.clone()
	}
	var_common_slug_groups = [[rt.new_string('primary'), rt.new_string('menu-1'), rt.new_string('main'), rt.new_string('header'), rt.new_string('navigation'), rt.new_string('top')], [rt.new_string('secondary'), rt.new_string('menu-2'), rt.new_string('footer'), rt.new_string('subsidiary'), rt.new_string('bottom')], [rt.new_string('social')]]
	for var_slug_group_shadow in var_common_slug_groups {
		mut iter_13 := var_slug_group_shadow.iterator()
		for {
			item_13 := iter_13.next() or { break }
			mut var_slug_shadow := item_13.val
			mut iter_14 := var_registered_nav_menus.iterator()
			for {
				item_14 := iter_14.next() or { break }
				mut var_name_shadow := item_14.val
				mut var_new_location_shadow := item_14.key
				if var_new_location_shadow.clone().is_string() && rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('stripos', [var_new_location_shadow.clone(), var_slug_shadow.clone()]))) && rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('stripos', [var_slug_shadow.clone(), var_new_location_shadow.clone()]))) {
					continue
				} else if var_new_location_shadow.clone().is_long() || var_new_location_shadow.clone().is_double() && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_new_location_shadow, var_slug_shadow)))) {
					continue
				}
				mut iter_15 := var_old_nav_menu_locations.iterator()
				for {
					item_15 := iter_15.next() or { break }
					mut var_menu_id_shadow := item_15.val
					mut var_location_shadow := item_15.key
					mut iter_16 := var_slug_group_shadow.iterator()
					for {
						item_16 := iter_16.next() or { break }
						mut var_slug_shadow := item_16.val
						if var_location_shadow.clone().is_string() && rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('stripos', [var_location_shadow.clone(), var_slug_shadow.clone()]))) && rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('stripos', [var_slug_shadow.clone(), var_location_shadow.clone()]))) {
							continue
						} else if var_location_shadow.clone().is_long() || var_location_shadow.clone().is_double() && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_location_shadow, var_slug_shadow)))) {
							continue
						}
						if !(!rt.is_true(var_old_nav_menu_locations.array_get(var_location_shadow))) {
							var_new_nav_menu_locations.array_set(var_new_location_shadow, var_old_nav_menu_locations.array_get(var_location_shadow))
							var_old_nav_menu_locations.array_unset(var_location_shadow)
							continue
						}
					}
				}
			}
		}
	}
	return var_new_nav_menu_locations.clone()
}

fn _wp_reset_invalid_menu_item_parent(var_menu_item_data rt.PhpVal) rt.PhpVal {
	if !(rt.create_array_from_native_map(var_menu_item_data).is_array()) {
		return var_menu_item_data.clone()
	}
	if !(var_menu_item_data['ID'] == 0) && !(var_menu_item_data['menu_item_parent'] == 0) && var_menu_item_data['ID'] == var_menu_item_data['menu_item_parent'] {
		var_menu_item_data['menu_item_parent'] = 0
	}
	return var_menu_item_data.clone()
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

struct Class_WP_Query {
	rt.PhpObjectBase
}

fn create_wp_error(_args ...rt.PhpVal) &Class_WP_Error {
	mut obj := &Class_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_query(_args ...rt.PhpVal) &Class_WP_Query {
	mut obj := &Class_WP_Query{
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


fn (mut this Class_WP_Query) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Query) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Query) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}



fn main() {
	defer {
		rt.shutdown()
	}

}
