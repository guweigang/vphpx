import rt

struct Class_WP_REST_Menus_Controller {
	rt.PhpObjectBase
}

fn (mut this Class_WP_REST_Menus_Controller) get_items_permissions_check(var_request rt.PhpVal) rt.PhpVal {
	mut var_has_permission :=
		this.Class_WP_REST_Terms_Controller.get_items_permissions_check(var_request.clone())
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(true), var_has_permission)))) {
		return var_has_permission.clone()
	}
	return rt.new_bool(this.check_has_read_only_access(var_request.clone()))
}

fn (mut this Class_WP_REST_Menus_Controller) get_item_permissions_check(var_request rt.PhpVal) rt.PhpVal {
	mut var_has_permission :=
		this.Class_WP_REST_Terms_Controller.get_item_permissions_check(var_request.clone())
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(true), var_has_permission)))) {
		return var_has_permission.clone()
	}
	return rt.new_bool(this.check_has_read_only_access(var_request.clone()))
}

fn (mut this Class_WP_REST_Menus_Controller) get_term(var_id rt.PhpVal) rt.PhpVal {
	mut var_term := this.Class_WP_REST_Terms_Controller.get_term(var_id.clone())
	if rt.is_true(rt.call_function('is_wp_error', [var_term.clone()])) {
		return var_term.clone()
	}
	mut var_nav_term := rt.call_function('wp_get_nav_menu_object', [
		var_term.clone()])
	rt.set_property(var_nav_term, 'auto_add', this.get_menu_auto_add(rt.get_property(var_nav_term,
		'term_id')))
	return var_nav_term.clone()
}

fn (mut this Class_WP_REST_Menus_Controller) check_has_read_only_access(var_request rt.PhpVal) bool {
	mut var_read_only_access := rt.call_function('apply_filters', [
		rt.new_string('rest_menu_read_access'),
		rt.new_bool(false),
		var_request.clone(),
		rt.new_object('WP_REST_Menus_Controller', ['WP_REST_Terms_Controller'], &this),
	])
	if rt.is_true(var_read_only_access) {
		return true
	}
	if rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('edit_theme_options'),
	]))
	{
		return true
	}
	if rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_posts')])) {
		return true
	}
	mut iter_1 := rt.call_function('get_post_types', [
		rt.create_array([rt.ArrayItem{ key: 'show_in_rest', val: true }]),
		rt.new_string('objects'),
	]).iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_post_type := item_1.val
		if rt.is_true(rt.call_function('current_user_can', [
			rt.get_property(rt.get_property(var_post_type, 'cap'), 'edit_posts'),
		]))
		{
			return true
		}
	}
	return (create_wp_error(rt.new_string('rest_cannot_view'), rt.call_function('__', [
		rt.new_string('Sorry, you are not allowed to view menus.'),
	]), rt.create_array([
		rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code',
			[]rt.PhpVal{}) },
	]))).to_bool()
}

fn (mut this Class_WP_REST_Menus_Controller) prepare_item_for_response(var_term rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
	mut var_term_mutated := var_term
	mut var_nav_menu := rt.call_function('wp_get_nav_menu_object', [
		var_term_mutated.clone()])
	mut var_response := this.Class_WP_REST_Terms_Controller.prepare_item_for_response(var_nav_menu.clone(),
		var_request.clone())
	mut var_fields := this.get_fields_for_response(var_request.clone())
	mut var_data := rt.call_method(var_response, 'get_data', []rt.PhpVal{})
	if rt.is_true(rt.call_function('rest_is_field_included', [
		rt.new_string('locations'), var_fields.clone()]))
	{
		var_data.array_set('locations', this.get_menu_locations(rt.get_property(var_nav_menu,
			'term_id')))
	}
	if rt.is_true(rt.call_function('rest_is_field_included', [
		rt.new_string('auto_add'), var_fields.clone()]))
	{
		var_data.array_set('auto_add', this.get_menu_auto_add(rt.get_property(var_nav_menu,
			'term_id')))
	}
	mut var_context := if !(!rt.is_true(var_request.array_get(rt.new_string('context')))) {
		var_request.array_get(rt.new_string('context'))
	} else {
		rt.new_string('view')
	}
	var_data = this.add_additional_fields_to_object(var_data.clone(), var_request.clone())
	var_data = this.filter_response_by_context(var_data.clone(), var_context.clone())
	var_response = rt.call_function('rest_ensure_response', [
		var_data.clone()])
	if rt.is_true(rt.call_function('rest_is_field_included', [rt.new_string('_links'), var_fields.clone()]))
		|| rt.is_true(rt.call_function('rest_is_field_included', [rt.new_string('_embedded'), var_fields.clone()])) {
		rt.call_method(var_response, 'add_links', [
			this.prepare_links(var_term_mutated.clone()),
		])
	}
	return rt.call_function('apply_filters', [
		rt.concat(rt.new_string('rest_prepare_'), rt.get_property(rt.new_object('WP_REST_Menus_Controller', [
			'WP_REST_Terms_Controller',
		], &this), 'taxonomy')),
		var_response.clone(),
		var_term_mutated.clone(),
		var_request.clone(),
	])
}

fn (mut this Class_WP_REST_Menus_Controller) prepare_links(var_term rt.PhpVal) rt.PhpVal {
	mut var_term_mutated := var_term
	mut var_links := this.Class_WP_REST_Terms_Controller.prepare_links(var_term_mutated.clone())
	mut var_locations := this.get_menu_locations(rt.get_property(var_term_mutated, 'term_id'))
	mut iter_2 := var_locations.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_location := item_2.val
		mut var_url := rt.call_function('rest_url', [
			rt.call_function('sprintf', [rt.new_string('wp/v2/menu-locations/%s'),
				var_location.clone()]),
		])
		var_links.array_get_mut('https://api.w.org/menu-location').array_push(rt.create_array([
			rt.ArrayItem{ key: 'href', val: var_url },
			rt.ArrayItem{ key: 'embeddable', val: true },
		]))
	}
	return var_links.clone()
}

fn (mut this Class_WP_REST_Menus_Controller) prepare_item_for_database(var_request rt.PhpVal) rt.PhpVal {
	mut var_prepared_term :=
		this.Class_WP_REST_Terms_Controller.prepare_item_for_database(var_request.clone())
	mut var_schema := this.get_item_schema()
	if var_request.array_isset(rt.new_string('name'))
		&& !(!rt.is_true(var_schema.array_get(rt.new_string('properties')).array_get(rt.new_string('name')))) {
		rt.set_property(var_prepared_term,
			'{"nodeType":"Scalar_String","line":190,"value":"menu-name"}',
			var_request.array_get(rt.new_string('name')))
	}
	return var_prepared_term.clone()
}

fn (mut this Class_WP_REST_Menus_Controller) create_item(var_request rt.PhpVal) rt.PhpVal {
	if var_request.array_isset(rt.new_string('parent')) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_taxonomy_hierarchical', [
			rt.get_property(rt.new_object('WP_REST_Menus_Controller', [
				'WP_REST_Terms_Controller',
			], &this), 'taxonomy'),
		])))))
		{
			return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('rest_taxonomy_not_hierarchical'), rt.call_function('__', [
				rt.new_string('Cannot set parent term, taxonomy is not hierarchical.'),
			]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }])))
		}
		mut var_parent := rt.call_function('wp_get_nav_menu_object', [
			rt.new_int((var_request.array_get(rt.new_string('parent'))).to_i64()),
		])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_parent)))) {
			return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('rest_term_invalid'), rt.call_function('__', [
				rt.new_string('Parent term does not exist.'),
			]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }])))
		}
	}
	mut var_prepared_term := this.prepare_item_for_database(var_request.clone())
	mut var_term := rt.call_function('wp_update_nav_menu_object', [
		rt.new_int(0), rt.call_function('wp_slash', [rt.cast_array(var_prepared_term)])])
	if rt.is_true(rt.call_function('is_wp_error', [var_term.clone()])) {
		if rt.is_true(rt.call_function('in_array', [rt.new_string('menu_exists'),
			rt.call_method(var_term, 'get_error_codes', []rt.PhpVal{}),
			rt.new_bool(true)]))
		{
			mut var_existing_term := rt.call_function('get_term_by', [
				rt.new_string('name'),
				rt.get_property(var_prepared_term,
					'{"nodeType":"Scalar_String","line":228,"value":"menu-name"}'),
				rt.get_property(rt.new_object('WP_REST_Menus_Controller', [
					'WP_REST_Terms_Controller',
				], &this), 'taxonomy'),
			])
			rt.call_method(var_term, 'add_data', [
				rt.get_property(var_existing_term, 'term_id'),
				rt.new_string('menu_exists'),
			])
			rt.call_method(var_term, 'add_data', [
				rt.create_array([rt.ArrayItem{ key: 'status', val: 400 },
					rt.ArrayItem{ key: 'term_id', val: rt.get_property(var_existing_term, 'term_id') }]),
			])
		} else {
			rt.call_method(var_term, 'add_data', [
				rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }]),
			])
		}
		return var_term.clone()
	}
	var_term = this.get_term(var_term.clone())
	rt.call_function('do_action', [
		rt.concat(rt.new_string('rest_insert_'), rt.get_property(rt.new_object('WP_REST_Menus_Controller', [
			'WP_REST_Terms_Controller',
		], &this), 'taxonomy')),
		var_term.clone(),
		var_request.clone(),
		rt.new_bool(true),
	])
	mut var_schema := this.get_item_schema()
	if !(!rt.is_true(var_schema.array_get(rt.new_string('properties')).array_get(rt.new_string('meta'))))
		&& var_request.array_isset(rt.new_string('meta')) {
		mut var_meta_update := rt.call_method(rt.get_property(rt.new_object('WP_REST_Menus_Controller', [
			'WP_REST_Terms_Controller',
		], &this), 'meta'), 'update_value', [var_request.array_get(rt.new_string('meta')),
			rt.get_property(var_term, 'term_id')])
		if rt.is_true(rt.call_function('is_wp_error', [var_meta_update.clone()])) {
			return var_meta_update.clone()
		}
	}
	mut var_locations_update := rt.new_bool(this.handle_locations(rt.get_property(var_term,
		'term_id'), var_request.clone()))
	if rt.is_true(rt.call_function('is_wp_error', [var_locations_update.clone()])) {
		return var_locations_update.clone()
	}
	this.handle_auto_add(rt.get_property(var_term, 'term_id'), var_request.clone())
	mut var_fields_update := this.update_additional_fields_for_object(var_term.clone(),
		var_request.clone())
	if rt.is_true(rt.call_function('is_wp_error', [var_fields_update.clone()])) {
		return var_fields_update.clone()
	}
	rt.call_method(var_request, 'set_param', [rt.new_string('context'),
		rt.new_string('view')])
	rt.call_function('do_action', [
		rt.concat(rt.new_string('rest_after_insert_'), rt.get_property(rt.new_object('WP_REST_Menus_Controller', [
			'WP_REST_Terms_Controller',
		], &this), 'taxonomy')),
		var_term.clone(),
		var_request.clone(),
		rt.new_bool(true),
	])
	mut var_response := this.prepare_item_for_response(var_term.clone(), var_request.clone())
	var_response = rt.call_function('rest_ensure_response', [
		var_response.clone()])
	rt.call_method(var_response, 'set_status', [rt.new_int(201)])
	rt.call_method(var_response, 'header', [rt.new_string('Location'),
		rt.call_function('rest_url', [
			rt.new_string(
				(rt.get_property(rt.new_object('WP_REST_Menus_Controller', ['WP_REST_Terms_Controller'], &this), 'namespace')).str() +
				'/' +
				(rt.get_property(rt.new_object('WP_REST_Menus_Controller', ['WP_REST_Terms_Controller'], &this), 'rest_base')).str() +
				'/' + (rt.get_property(var_term, 'term_id')).str()),
		])])
	return var_response.clone()
}

fn (mut this Class_WP_REST_Menus_Controller) update_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_term := this.get_term(var_request.array_get(rt.new_string('id')))
	if rt.is_true(rt.call_function('is_wp_error', [var_term.clone()])) {
		return var_term.clone()
	}
	if var_request.array_isset(rt.new_string('parent')) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_taxonomy_hierarchical', [
			rt.get_property(rt.new_object('WP_REST_Menus_Controller', [
				'WP_REST_Terms_Controller',
			], &this), 'taxonomy'),
		])))))
		{
			return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('rest_taxonomy_not_hierarchical'), rt.call_function('__', [
				rt.new_string('Cannot set parent term, taxonomy is not hierarchical.'),
			]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }])))
		}
		mut var_parent := rt.call_function('get_term', [
			rt.new_int((var_request.array_get(rt.new_string('parent'))).to_i64()),
			rt.get_property(rt.new_object('WP_REST_Menus_Controller', [
				'WP_REST_Terms_Controller',
			], &this), 'taxonomy'),
		])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_parent)))) {
			return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('rest_term_invalid'), rt.call_function('__', [
				rt.new_string('Parent term does not exist.'),
			]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }])))
		}
	}
	mut var_prepared_term := this.prepare_item_for_database(var_request.clone())
	if !(!rt.is_true(var_prepared_term)) {
		if !(!(rt.get_property(var_prepared_term,
			'{"nodeType":"Scalar_String","line":315,"value":"menu-name"}')).is_null()) {
			rt.set_property(var_prepared_term,
				'{"nodeType":"Scalar_String","line":317,"value":"menu-name"}', rt.get_property(var_term,
				'name'))
		}
		mut var_update := rt.call_function('wp_update_nav_menu_object', [
			rt.get_property(var_term, 'term_id'),
			rt.call_function('wp_slash', [rt.cast_array(var_prepared_term)]),
		])
		if rt.is_true(rt.call_function('is_wp_error', [var_update.clone()])) {
			return var_update.clone()
		}
	}
	var_term = rt.call_function('get_term', [rt.get_property(var_term, 'term_id'),
		rt.get_property(rt.new_object('WP_REST_Menus_Controller', [
			'WP_REST_Terms_Controller',
		], &this), 'taxonomy')])
	rt.call_function('do_action', [
		rt.concat(rt.new_string('rest_insert_'), rt.get_property(rt.new_object('WP_REST_Menus_Controller', [
			'WP_REST_Terms_Controller',
		], &this), 'taxonomy')),
		var_term.clone(),
		var_request.clone(),
		rt.new_bool(false),
	])
	mut var_schema := this.get_item_schema()
	if !(!rt.is_true(var_schema.array_get(rt.new_string('properties')).array_get(rt.new_string('meta'))))
		&& var_request.array_isset(rt.new_string('meta')) {
		mut var_meta_update := rt.call_method(rt.get_property(rt.new_object('WP_REST_Menus_Controller', [
			'WP_REST_Terms_Controller',
		], &this), 'meta'), 'update_value', [var_request.array_get(rt.new_string('meta')),
			rt.get_property(var_term, 'term_id')])
		if rt.is_true(rt.call_function('is_wp_error', [var_meta_update.clone()])) {
			return var_meta_update.clone()
		}
	}
	mut var_locations_update := rt.new_bool(this.handle_locations(rt.get_property(var_term,
		'term_id'), var_request.clone()))
	if rt.is_true(rt.call_function('is_wp_error', [var_locations_update.clone()])) {
		return var_locations_update.clone()
	}
	this.handle_auto_add(rt.get_property(var_term, 'term_id'), var_request.clone())
	mut var_fields_update := this.update_additional_fields_for_object(var_term.clone(),
		var_request.clone())
	if rt.is_true(rt.call_function('is_wp_error', [var_fields_update.clone()])) {
		return var_fields_update.clone()
	}
	rt.call_method(var_request, 'set_param', [rt.new_string('context'),
		rt.new_string('view')])
	rt.call_function('do_action', [
		rt.concat(rt.new_string('rest_after_insert_'), rt.get_property(rt.new_object('WP_REST_Menus_Controller', [
			'WP_REST_Terms_Controller',
		], &this), 'taxonomy')),
		var_term.clone(),
		var_request.clone(),
		rt.new_bool(false),
	])
	mut var_response := this.prepare_item_for_response(var_term.clone(), var_request.clone())
	return rt.call_function('rest_ensure_response', [var_response.clone()])
}

fn (mut this Class_WP_REST_Menus_Controller) delete_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_term := this.get_term(var_request.array_get(rt.new_string('id')))
	if rt.is_true(rt.call_function('is_wp_error', [var_term.clone()])) {
		return var_term.clone()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_request.array_get(rt.new_string('force')))))) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('rest_trash_not_supported'), rt.call_function('sprintf', [
			rt.call_function('__', [
				rt.new_string("Menus do not support trashing. Set '%s' to delete."),
			]),
			rt.new_string('force=true'),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 501 }])))
	}
	rt.call_method(var_request, 'set_param', [rt.new_string('context'),
		rt.new_string('view')])
	mut var_previous := this.prepare_item_for_response(var_term.clone(), var_request.clone())
	mut var_result := rt.call_function('wp_delete_nav_menu', [
		var_term.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_result))))
		|| rt.is_true(rt.call_function('is_wp_error', [var_result.clone()])) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('rest_cannot_delete'), rt.call_function('__', [
			rt.new_string('The menu cannot be deleted.'),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 500 }])))
	}
	mut var_response := create_wp_rest_response()
	rt.call_method(var_response, 'set_data', [
		rt.create_array([rt.ArrayItem{ key: 'deleted', val: true },
			rt.ArrayItem{ key: 'previous', val: rt.call_method(var_previous, 'get_data',
				[]rt.PhpVal{}) }]),
	])
	rt.call_function('do_action', [
		rt.concat(rt.new_string('rest_delete_'), rt.get_property(rt.new_object('WP_REST_Menus_Controller', [
			'WP_REST_Terms_Controller',
		], &this), 'taxonomy')),
		var_term.clone(),
		var_response.clone(),
		var_request.clone(),
	])
	return var_response.clone()
}

fn (mut this Class_WP_REST_Menus_Controller) get_menu_auto_add(var_menu_id rt.PhpVal) rt.PhpVal {
	mut var_nav_menu_option := rt.cast_array(rt.call_function('get_option', [
		rt.new_string('nav_menu_options'),
		rt.create_array([rt.ArrayItem{ key: 'auto_add', val: rt.new_array() }]),
	]))
	return rt.call_function('in_array', [var_menu_id.clone(),
		var_nav_menu_option.array_get(rt.new_string('auto_add')),
		rt.new_bool(true)])
}

fn (mut this Class_WP_REST_Menus_Controller) handle_auto_add(var_menu_id rt.PhpVal, var_request rt.PhpVal) bool {
	if !(var_request.array_isset(rt.new_string('auto_add'))) {
		return true
	}
	mut var_nav_menu_option := rt.cast_array(rt.call_function('get_option', [
		rt.new_string('nav_menu_options'),
		rt.create_array([rt.ArrayItem{ key: 'auto_add', val: rt.new_array() }]),
	]))
	if !(var_nav_menu_option.array_isset(rt.new_string('auto_add'))) {
		var_nav_menu_option.array_set('auto_add', rt.new_array())
	}
	mut var_auto_add := var_request.array_get(rt.new_string('auto_add'))
	mut var_i := rt.call_function('array_search', [var_menu_id.clone(),
		var_nav_menu_option.array_get(rt.new_string('auto_add')),
		rt.new_bool(true)])
	if rt.is_true(var_auto_add) && rt.is_true(rt.identical(rt.new_bool(false), var_i)) {
		var_nav_menu_option.array_get_mut('auto_add').array_push(var_menu_id.clone())
	} else if rt.is_true(rt.new_bool(!(rt.is_true(var_auto_add))))
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_i)))) {
		rt.call_function('array_splice', [var_nav_menu_option.array_get(rt.new_string('auto_add')),
			var_i.clone(), rt.new_int(1)])
	}
	mut var_update := rt.call_function('update_option', [
		rt.new_string('nav_menu_options'),
		var_nav_menu_option.clone(),
	])
	rt.call_function('do_action', [rt.new_string('wp_update_nav_menu'),
		var_menu_id.clone()])
	return var_update.to_bool()
}

fn (mut this Class_WP_REST_Menus_Controller) get_menu_locations(var_menu_id rt.PhpVal) rt.PhpVal {
	mut var_locations := rt.call_function('get_nav_menu_locations', []rt.PhpVal{})
	mut var_menu_locations := rt.new_array()
	mut iter_3 := var_locations.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_assigned_menu_id := item_3.val
		mut var_location := item_3.key
		if rt.is_true(rt.identical(var_menu_id, var_assigned_menu_id)) {
			var_menu_locations.array_push(var_location.clone())
		}
	}
	return var_menu_locations.clone()
}

fn (mut this Class_WP_REST_Menus_Controller) handle_locations(var_menu_id rt.PhpVal, var_request rt.PhpVal) bool {
	if !(var_request.array_isset(rt.new_string('locations'))) {
		return true
	}
	mut var_menu_locations := rt.call_function('get_registered_nav_menus', []rt.PhpVal{})
	var_menu_locations = rt.func_array_keys(var_menu_locations.clone())
	mut var_new_locations := rt.new_array()
	mut iter_4 := var_request.array_get(rt.new_string('locations')).iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_location := item_4.val
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
			var_location.clone(), var_menu_locations.clone(),
			rt.new_bool(true)])))))
		{
			return (create_wp_error(rt.new_string('rest_invalid_menu_location'), rt.call_function('__', [
				rt.new_string('Invalid menu location.'),
			]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 },
				rt.ArrayItem{ key: 'location', val: var_location }]))).to_bool()
		}
		var_new_locations.array_set(var_location, var_menu_id.clone())
	}
	mut var_assigned_menu := rt.call_function('get_nav_menu_locations', []rt.PhpVal{})
	mut iter_5 := var_assigned_menu.iterator()
	for {
		item_5 := iter_5.next() or { break }
		mut var_term_id := item_5.val
		mut var_location := item_5.key
		if rt.is_true(rt.identical(var_term_id, var_menu_id)) {
			var_assigned_menu.array_unset(var_location)
		}
	}
	mut var_new_assignments := rt.call_function('array_merge', [
		var_assigned_menu.clone(), var_new_locations.clone()])
	rt.call_function('set_theme_mod', [rt.new_string('nav_menu_locations'),
		var_new_assignments.clone()])
	return true
}

fn (mut this Class_WP_REST_Menus_Controller) get_item_schema() rt.PhpVal {
	if rt.is_true(rt.get_property(rt.new_object('WP_REST_Menus_Controller', [
		'WP_REST_Terms_Controller',
	], &this), 'schema'))
	{
		return this.add_additional_fields_schema(rt.get_property(rt.new_object('WP_REST_Menus_Controller', [
			'WP_REST_Terms_Controller',
		], &this), 'schema'))
	}
	mut var_schema := this.Class_WP_REST_Terms_Controller.get_item_schema()
	var_schema.array_get(rt.new_string('properties')).array_unset(rt.new_string('count'))
	var_schema.array_get(rt.new_string('properties')).array_unset(rt.new_string('link'))
	var_schema.array_get(rt.new_string('properties')).array_unset(rt.new_string('taxonomy'))
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_locations := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_request := if args.len > 1 { args[1].clone() } else { rt.new_null() }
		mut var_param := if args.len > 2 { args[2].clone() } else { rt.new_null() }
		mut var_valid := rt.call_function('rest_validate_request_arg', [
			var_locations.clone(), var_request.clone(), var_param.clone()])
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(true), var_valid)))) {
			return var_valid.clone()
		}
		var_locations = rt.call_function('rest_sanitize_request_arg', [
			var_locations.clone(), var_request.clone(), var_param.clone()])
		mut iter_6 := var_locations.iterator()
		for {
			item_6 := iter_6.next() or { break }
			mut var_location := item_6.val
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.call_function('get_registered_nav_menus',
				[]rt.PhpVal{}).array_isset(var_location.clone()))))))
			{
				return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('rest_invalid_menu_location'), rt.call_function('__', [
					rt.new_string('Invalid menu location.'),
				]), rt.create_array([rt.ArrayItem{ key: 'location', val: var_location }])))
			}
		}
		return rt.new_bool(true)
	}
	var_schema.array_get_mut('properties').array_set('locations', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('The locations assigned to the menu.'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'array' },
		rt.ArrayItem{ key: 'items', val: rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'string' },
		]) },
		rt.ArrayItem{ key: 'context', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'view' },
			rt.ArrayItem{ key: none, val: 'edit' },
		]) },
		rt.ArrayItem{ key: 'arg_options', val: rt.create_array([
			rt.ArrayItem{ key: 'validate_callback', val: rt.new_closure(closure_1_fn) },
		]) },
	]))
	var_schema.array_get_mut('properties').array_set('auto_add', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Whether to automatically add top level pages to this menu.'),
		]) },
		rt.ArrayItem{ key: 'context', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'view' },
			rt.ArrayItem{ key: none, val: 'edit' },
		]) },
		rt.ArrayItem{ key: 'type', val: 'boolean' },
	]))
	this.dispatch_set_prop('schema', var_schema.clone())
	return this.add_additional_fields_schema(rt.get_property(rt.new_object('WP_REST_Menus_Controller', [
		'WP_REST_Terms_Controller',
	], &this), 'schema'))
}

struct Class_WP_REST_Terms_Controller {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

struct Class_WP_REST_Response {
	rt.PhpObjectBase
}

fn create_wp_rest_menus_controller(_args ...rt.PhpVal) &Class_WP_REST_Menus_Controller {
	mut obj := &Class_WP_REST_Menus_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_rest_terms_controller(_args ...rt.PhpVal) &Class_WP_REST_Terms_Controller {
	mut obj := &Class_WP_REST_Terms_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_error(_args ...rt.PhpVal) &Class_WP_Error {
	mut obj := &Class_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_rest_response(_args ...rt.PhpVal) &Class_WP_REST_Response {
	mut obj := &Class_WP_REST_Response{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_REST_Menus_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_items_permissions_check' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_items_permissions_check(dispatch_arg_0)
		}
		'get_item_permissions_check' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_item_permissions_check(dispatch_arg_0)
		}
		'get_term' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_term(dispatch_arg_0)
		}
		'check_has_read_only_access' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.check_has_read_only_access(dispatch_arg_0))
		}
		'prepare_item_for_response' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.prepare_item_for_response(dispatch_arg_0, dispatch_arg_1)
		}
		'prepare_links' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.prepare_links(dispatch_arg_0)
		}
		'prepare_item_for_database' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.prepare_item_for_database(dispatch_arg_0)
		}
		'create_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.create_item(dispatch_arg_0)
		}
		'update_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.update_item(dispatch_arg_0)
		}
		'delete_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.delete_item(dispatch_arg_0)
		}
		'get_menu_auto_add' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_menu_auto_add(dispatch_arg_0)
		}
		'handle_auto_add' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(this.handle_auto_add(dispatch_arg_0, dispatch_arg_1))
		}
		'get_menu_locations' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_menu_locations(dispatch_arg_0)
		}
		'handle_locations' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(this.handle_locations(dispatch_arg_0, dispatch_arg_1))
		}
		'get_item_schema' {
			return this.get_item_schema()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WP_REST_Menus_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_REST_Menus_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WP_REST_Terms_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_REST_Terms_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_REST_Terms_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
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

fn (mut this Class_WP_REST_Response) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_REST_Response) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_REST_Response) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
