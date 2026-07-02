import rt

struct Class_WP_REST_Menu_Items_Controller {
	rt.PhpObjectBase
}

fn (mut this Class_WP_REST_Menu_Items_Controller) get_nav_menu_item(var_id rt.PhpVal) rt.PhpVal {
	mut var_post := this.get_post(var_id.clone())
	if rt.is_true(rt.call_function('is_wp_error', [var_post.clone()])) {
		return var_post.clone()
	}
	return rt.call_function('wp_setup_nav_menu_item', [var_post.clone()])
}

fn (mut this Class_WP_REST_Menu_Items_Controller) get_items_permissions_check(var_request rt.PhpVal) rt.PhpVal {
	mut var_has_permission :=
		this.Class_WP_REST_Posts_Controller.get_items_permissions_check(var_request.clone())
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(true), var_has_permission)))) {
		return var_has_permission.clone()
	}
	return rt.new_bool(this.check_has_read_only_access(var_request.clone()))
}

fn (mut this Class_WP_REST_Menu_Items_Controller) get_item_permissions_check(var_request rt.PhpVal) rt.PhpVal {
	mut var_permission_check :=
		this.Class_WP_REST_Posts_Controller.get_item_permissions_check(var_request.clone())
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(true), var_permission_check)))) {
		return var_permission_check.clone()
	}
	return rt.new_bool(this.check_has_read_only_access(var_request.clone()))
}

fn (mut this Class_WP_REST_Menu_Items_Controller) check_has_read_only_access(var_request rt.PhpVal) bool {
	mut var_read_only_access := rt.call_function('apply_filters', [
		rt.new_string('rest_menu_read_access'),
		rt.new_bool(false),
		var_request.clone(),
		rt.new_object('WP_REST_Menu_Items_Controller', ['WP_REST_Posts_Controller'], &this),
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
		rt.new_string('Sorry, you are not allowed to view menu items.'),
	]), rt.create_array([
		rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code',
			[]rt.PhpVal{}) },
	]))).to_bool()
}

fn (mut this Class_WP_REST_Menu_Items_Controller) create_item(var_request rt.PhpVal) rt.PhpVal {
	if !(!rt.is_true(var_request.array_get(rt.new_string('id')))) {
		return create_wp_error(rt.new_string('rest_post_exists'), rt.call_function('__', [
			rt.new_string('Cannot create existing post.'),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }]))
	}
	mut var_prepared_nav_item := this.prepare_item_for_database(var_request.clone())
	if rt.is_true(rt.call_function('is_wp_error', [var_prepared_nav_item.clone()])) {
		return var_prepared_nav_item.clone()
	}
	var_prepared_nav_item = rt.cast_array(var_prepared_nav_item)
	mut var_nav_menu_item_id := rt.call_function('wp_update_nav_menu_item', [
		var_prepared_nav_item.array_get(rt.new_string('menu-id')),
		var_prepared_nav_item.array_get(rt.new_string('menu-item-db-id')),
		rt.call_function('wp_slash', [var_prepared_nav_item.clone()]),
		rt.new_bool(false),
	])
	if rt.is_true(rt.call_function('is_wp_error', [var_nav_menu_item_id.clone()])) {
		if rt.is_true(rt.identical(rt.new_string('db_insert_error'), rt.call_method(var_nav_menu_item_id,
			'get_error_code', []rt.PhpVal{})))
		{
			rt.call_method(var_nav_menu_item_id, 'add_data', [
				rt.create_array([rt.ArrayItem{ key: 'status', val: 500 }]),
			])
		} else {
			rt.call_method(var_nav_menu_item_id, 'add_data', [
				rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }]),
			])
		}
		return var_nav_menu_item_id.clone()
	}
	mut var_nav_menu_item := this.get_nav_menu_item(var_nav_menu_item_id.clone())
	if rt.is_true(rt.call_function('is_wp_error', [var_nav_menu_item.clone()])) {
		rt.call_method(var_nav_menu_item, 'add_data', [
			rt.create_array([rt.ArrayItem{ key: 'status', val: 404 }]),
		])
		return var_nav_menu_item.clone()
	}
	rt.call_function('do_action', [rt.new_string('rest_insert_nav_menu_item'),
		var_nav_menu_item.clone(), var_request.clone(), rt.new_bool(true)])
	mut var_schema := this.get_item_schema()
	if !(!rt.is_true(var_schema.array_get(rt.new_string('properties')).array_get(rt.new_string('meta'))))
		&& var_request.array_isset(rt.new_string('meta')) {
		mut var_meta_update := rt.call_method(rt.get_property(rt.new_object('WP_REST_Menu_Items_Controller', [
			'WP_REST_Posts_Controller',
		], &this), 'meta'), 'update_value', [var_request.array_get(rt.new_string('meta')),
			var_nav_menu_item_id.clone()])
		if rt.is_true(rt.call_function('is_wp_error', [var_meta_update.clone()])) {
			return var_meta_update.clone()
		}
	}
	var_nav_menu_item = this.get_nav_menu_item(var_nav_menu_item_id.clone())
	mut var_fields_update := this.update_additional_fields_for_object(var_nav_menu_item.clone(),
		var_request.clone())
	if rt.is_true(rt.call_function('is_wp_error', [var_fields_update.clone()])) {
		return var_fields_update.clone()
	}
	rt.call_method(var_request, 'set_param', [rt.new_string('context'),
		rt.new_string('edit')])
	rt.call_function('do_action', [rt.new_string('rest_after_insert_nav_menu_item'),
		var_nav_menu_item.clone(), var_request.clone(), rt.new_bool(true)])
	mut var_post := rt.call_function('get_post', [var_nav_menu_item_id.clone()])
	rt.call_function('wp_after_insert_post', [var_post.clone(),
		rt.new_bool(false), rt.new_null()])
	mut var_response := this.prepare_item_for_response(var_post.clone(), var_request.clone())
	var_response = rt.call_function('rest_ensure_response', [
		var_response.clone()])
	rt.call_method(var_response, 'set_status', [rt.new_int(201)])
	rt.call_method(var_response, 'header', [rt.new_string('Location'),
		rt.call_function('rest_url', [
			rt.call_function('sprintf', [rt.new_string('%s/%s/%d'),
				rt.get_property(rt.new_object('WP_REST_Menu_Items_Controller', [
					'WP_REST_Posts_Controller',
				], &this), 'namespace'),
				rt.get_property(rt.new_object('WP_REST_Menu_Items_Controller', [
					'WP_REST_Posts_Controller',
				], &this), 'rest_base'),
				var_nav_menu_item_id.clone()]),
		])])
	return var_response.clone()
}

fn (mut this Class_WP_REST_Menu_Items_Controller) update_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_valid_check := this.get_nav_menu_item(var_request.array_get(rt.new_string('id')))
	if rt.is_true(rt.call_function('is_wp_error', [var_valid_check.clone()])) {
		return var_valid_check.clone()
	}
	mut var_post_before := rt.call_function('get_post', [
		var_request.array_get(rt.new_string('id')),
	])
	mut var_prepared_nav_item := this.prepare_item_for_database(var_request.clone())
	if rt.is_true(rt.call_function('is_wp_error', [var_prepared_nav_item.clone()])) {
		return var_prepared_nav_item.clone()
	}
	var_prepared_nav_item = rt.cast_array(var_prepared_nav_item)
	mut var_nav_menu_item_id := rt.call_function('wp_update_nav_menu_item', [
		var_prepared_nav_item.array_get(rt.new_string('menu-id')),
		var_prepared_nav_item.array_get(rt.new_string('menu-item-db-id')),
		rt.call_function('wp_slash', [var_prepared_nav_item.clone()]),
		rt.new_bool(false),
	])
	if rt.is_true(rt.call_function('is_wp_error', [var_nav_menu_item_id.clone()])) {
		if rt.is_true(rt.identical(rt.new_string('db_update_error'), rt.call_method(var_nav_menu_item_id,
			'get_error_code', []rt.PhpVal{})))
		{
			rt.call_method(var_nav_menu_item_id, 'add_data', [
				rt.create_array([rt.ArrayItem{ key: 'status', val: 500 }]),
			])
		} else {
			rt.call_method(var_nav_menu_item_id, 'add_data', [
				rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }]),
			])
		}
		return var_nav_menu_item_id.clone()
	}
	mut var_nav_menu_item := this.get_nav_menu_item(var_nav_menu_item_id.clone())
	if rt.is_true(rt.call_function('is_wp_error', [var_nav_menu_item.clone()])) {
		rt.call_method(var_nav_menu_item, 'add_data', [
			rt.create_array([rt.ArrayItem{ key: 'status', val: 404 }]),
		])
		return var_nav_menu_item.clone()
	}
	rt.call_function('do_action', [rt.new_string('rest_insert_nav_menu_item'),
		var_nav_menu_item.clone(), var_request.clone(), rt.new_bool(false)])
	mut var_schema := this.get_item_schema()
	if !(!rt.is_true(var_schema.array_get(rt.new_string('properties')).array_get(rt.new_string('meta'))))
		&& var_request.array_isset(rt.new_string('meta')) {
		mut var_meta_update := rt.call_method(rt.get_property(rt.new_object('WP_REST_Menu_Items_Controller', [
			'WP_REST_Posts_Controller',
		], &this), 'meta'), 'update_value', [var_request.array_get(rt.new_string('meta')),
			rt.get_property(var_nav_menu_item, 'ID')])
		if rt.is_true(rt.call_function('is_wp_error', [var_meta_update.clone()])) {
			return var_meta_update.clone()
		}
	}
	mut var_post := rt.call_function('get_post', [var_nav_menu_item_id.clone()])
	var_nav_menu_item = this.get_nav_menu_item(var_nav_menu_item_id.clone())
	mut var_fields_update := this.update_additional_fields_for_object(var_nav_menu_item.clone(),
		var_request.clone())
	if rt.is_true(rt.call_function('is_wp_error', [var_fields_update.clone()])) {
		return var_fields_update.clone()
	}
	rt.call_method(var_request, 'set_param', [rt.new_string('context'),
		rt.new_string('edit')])
	rt.call_function('do_action', [rt.new_string('rest_after_insert_nav_menu_item'),
		var_nav_menu_item.clone(), var_request.clone(), rt.new_bool(false)])
	rt.call_function('wp_after_insert_post', [var_post.clone(),
		rt.new_bool(true), var_post_before.clone()])
	mut var_response := this.prepare_item_for_response(rt.call_function('get_post', [
		var_nav_menu_item_id.clone(),
	]), var_request.clone())
	return rt.call_function('rest_ensure_response', [var_response.clone()])
}

fn (mut this Class_WP_REST_Menu_Items_Controller) delete_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_menu_item := this.get_nav_menu_item(var_request.array_get(rt.new_string('id')))
	if rt.is_true(rt.call_function('is_wp_error', [var_menu_item.clone()])) {
		return var_menu_item.clone()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_request.array_get(rt.new_string('force')))))) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('rest_trash_not_supported'), rt.call_function('sprintf', [
			rt.call_function('__', [
				rt.new_string("Menu items do not support trashing. Set '%s' to delete."),
			]),
			rt.new_string('force=true'),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 501 }])))
	}
	mut var_previous := this.prepare_item_for_response(rt.call_function('get_post', [
		var_request.array_get(rt.new_string('id')),
	]), var_request.clone())
	mut var_result := rt.call_function('wp_delete_post', [
		var_request.array_get(rt.new_string('id')),
		rt.new_bool(true),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_result)))) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('rest_cannot_delete'), rt.call_function('__', [
			rt.new_string('The post cannot be deleted.'),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 500 }])))
	}
	mut var_response := create_wp_rest_response()
	rt.call_method(var_response, 'set_data', [
		rt.create_array([rt.ArrayItem{ key: 'deleted', val: true },
			rt.ArrayItem{ key: 'previous', val: rt.call_method(var_previous, 'get_data',
				[]rt.PhpVal{}) }]),
	])
	rt.call_function('do_action', [rt.new_string('rest_delete_nav_menu_item'),
		var_menu_item.clone(), var_response.clone(), var_request.clone()])
	return var_response.clone()
}

fn (mut this Class_WP_REST_Menu_Items_Controller) prepare_item_for_database(var_request rt.PhpVal) rt.PhpVal {
	mut var_menu_item_db_id := var_request.array_get(rt.new_string('id'))
	mut var_menu_item_obj := this.get_nav_menu_item(var_menu_item_db_id.clone())
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [
		var_menu_item_obj.clone()])))))
	{
		mut var_position := if rt.is_true(rt.identical(rt.new_int(0), rt.get_property(var_menu_item_obj,
			'menu_order')))
		{
			rt.new_int(1)
		} else {
			rt.get_property(var_menu_item_obj, 'menu_order')
		}
		mut var_prepared_nav_item := rt.create_array([
			rt.ArrayItem{ key: 'menu-item-db-id', val: var_menu_item_db_id },
			rt.ArrayItem{ key: 'menu-item-object-id', val: rt.get_property(var_menu_item_obj,
				'object_id') },
			rt.ArrayItem{ key: 'menu-item-object', val: rt.get_property(var_menu_item_obj, 'object') },
			rt.ArrayItem{ key: 'menu-item-parent-id', val: rt.get_property(var_menu_item_obj,
				'menu_item_parent') },
			rt.ArrayItem{ key: 'menu-item-position', val: var_position },
			rt.ArrayItem{ key: 'menu-item-type', val: rt.get_property(var_menu_item_obj, 'type') },
			rt.ArrayItem{ key: 'menu-item-title', val: rt.get_property(var_menu_item_obj, 'title') },
			rt.ArrayItem{ key: 'menu-item-url', val: rt.get_property(var_menu_item_obj, 'url') },
			rt.ArrayItem{ key: 'menu-item-description', val: rt.get_property(var_menu_item_obj,
				'description') },
			rt.ArrayItem{ key: 'menu-item-attr-title', val: rt.get_property(var_menu_item_obj,
				'attr_title') },
			rt.ArrayItem{ key: 'menu-item-target', val: rt.get_property(var_menu_item_obj, 'target') },
			rt.ArrayItem{ key: 'menu-item-classes', val: rt.get_property(var_menu_item_obj,
				'classes') },
			rt.ArrayItem{ key: 'menu-item-xfn', val: rt.call_function('explode', [
				rt.new_string(' '),
				rt.get_property(var_menu_item_obj, 'xfn'),
			]) },
			rt.ArrayItem{ key: 'menu-item-status', val: rt.get_property(var_menu_item_obj,
				'post_status') },
			rt.ArrayItem{ key: 'menu-id', val: this.get_menu_id(var_menu_item_db_id.clone()) },
		])
	} else {
		var_prepared_nav_item = rt.create_array([rt.ArrayItem{ key: 'menu-id', val: 0 },
			rt.ArrayItem{ key: 'menu-item-db-id', val: 0 }, rt.ArrayItem{
				key: 'menu-item-object-id'
				val: 0
			}, rt.ArrayItem{ key: 'menu-item-object', val: '' },
			rt.ArrayItem{ key: 'menu-item-parent-id', val: 0 },
			rt.ArrayItem{ key: 'menu-item-position', val: 1 },
			rt.ArrayItem{ key: 'menu-item-type', val: 'custom' },
			rt.ArrayItem{ key: 'menu-item-title', val: '' }, rt.ArrayItem{
				key: 'menu-item-url'
				val: ''
			}, rt.ArrayItem{ key: 'menu-item-description', val: '' },
			rt.ArrayItem{ key: 'menu-item-attr-title', val: '' },
			rt.ArrayItem{ key: 'menu-item-target', val: '' },
			rt.ArrayItem{ key: 'menu-item-classes', val: rt.new_array() },
			rt.ArrayItem{ key: 'menu-item-xfn', val: rt.new_array() },
			rt.ArrayItem{ key: 'menu-item-status', val: 'publish' }])
	}
	mut var_mapping := {
		'menu-item-db-id':       'id'
		'menu-item-object-id':   'object_id'
		'menu-item-object':      'object'
		'menu-item-parent-id':   'parent'
		'menu-item-position':    'menu_order'
		'menu-item-type':        'type'
		'menu-item-url':         'url'
		'menu-item-description': 'description'
		'menu-item-attr-title':  'attr_title'
		'menu-item-target':      'target'
		'menu-item-classes':     'classes'
		'menu-item-xfn':         'xfn'
		'menu-item-status':      'status'
	}
	mut var_schema := this.get_item_schema()
	for var_original, var_api_request in var_mapping {
		if var_request.array_isset(rt.new_string(api_request)) {
			var_prepared_nav_item.array_set(original,
				var_request.array_get(rt.new_string(api_request)))
		}
	}
	mut var_taxonomy := rt.call_function('get_taxonomy', [rt.new_string('nav_menu')])
	mut var_base := if !(!rt.is_true(rt.get_property(var_taxonomy, 'rest_base'))) {
		rt.get_property(var_taxonomy, 'rest_base')
	} else {
		rt.get_property(var_taxonomy, 'name')
	}
	if !(!rt.is_true(var_request.array_get(var_base))) {
		var_prepared_nav_item.array_set('menu-id', rt.call_function('absint', [
			var_request.array_get(var_base),
		]))
	}
	if !(!rt.is_true(var_schema.array_get(rt.new_string('properties')).array_get(rt.new_string('title'))))
		&& var_request.array_isset(rt.new_string('title')) {
		if rt.is_true(rt.new_bool(var_request.array_get(rt.new_string('title')).is_string())) {
			var_prepared_nav_item.array_set('menu-item-title',
				var_request.array_get(rt.new_string('title')))
		} else if !(!rt.is_true(var_request.array_get(rt.new_string('title')).array_get(rt.new_string('raw')))) {
			var_prepared_nav_item.array_set('menu-item-title',
				var_request.array_get(rt.new_string('title')).array_get(rt.new_string('raw')))
		}
	}
	mut var_error := create_wp_error()
	if rt.is_true(rt.new_bool(!(rt.is_true(var_prepared_nav_item.array_get(rt.new_string('menu-item-object')))))) {
		if rt.is_true(rt.identical(rt.new_string('taxonomy'),
			var_prepared_nav_item.array_get(rt.new_string('menu-item-type'))))
		{
			mut var_original := rt.call_function('get_term', [
				rt.call_function('absint', [
					var_prepared_nav_item.array_get(rt.new_string('menu-item-object-id')),
				]),
			])
			if !rt.is_true(var_original)
				|| rt.is_true(rt.call_function('is_wp_error', [var_original.clone()])) {
				var_error.add(rt.new_string('rest_term_invalid_id'), rt.call_function('__', [
					rt.new_string('Invalid term ID.'),
				]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }]))
			} else {
				var_prepared_nav_item.array_set('menu-item-object', rt.call_function('get_term_field', [
					rt.new_string('taxonomy'),
					var_original.clone(),
				]))
			}
		} else if rt.is_true(rt.identical(rt.new_string('post_type'),
			var_prepared_nav_item.array_get(rt.new_string('menu-item-type'))))
		{
			var_original = rt.call_function('get_post', [
				rt.call_function('absint', [
					var_prepared_nav_item.array_get(rt.new_string('menu-item-object-id')),
				]),
			])
			if !rt.is_true(var_original) {
				var_error.add(rt.new_string('rest_post_invalid_id'), rt.call_function('__', [
					rt.new_string('Invalid post ID.'),
				]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }]))
			} else {
				var_prepared_nav_item.array_set('menu-item-object', rt.call_function('get_post_type', [
					var_original.clone(),
				]))
			}
		}
	}
	if rt.is_true(rt.identical(rt.new_string('post_type_archive'),
		var_prepared_nav_item.array_get(rt.new_string('menu-item-type'))))
	{
		mut var_post_type := if rt.is_true(var_prepared_nav_item.array_get(rt.new_string('menu-item-object'))) {
			var_prepared_nav_item.array_get(rt.new_string('menu-item-object'))
		} else {
			rt.new_bool(false)
		}
		var_original = rt.call_function('get_post_type_object', [
			var_post_type.clone()])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_original)))) {
			var_error.add(rt.new_string('rest_post_invalid_type'), rt.call_function('__', [
				rt.new_string('Invalid post type.'),
			]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }]))
		}
	}
	if rt.is_true(rt.identical(rt.new_string('custom'),
		var_prepared_nav_item.array_get(rt.new_string('menu-item-type'))))
	{
		if rt.is_true(rt.identical(rt.new_string(''),
			var_prepared_nav_item.array_get(rt.new_string('menu-item-title'))))
		{
			var_error.add(rt.new_string('rest_title_required'), rt.call_function('__', [
				rt.new_string('The title is required when using a custom menu item type.'),
			]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }]))
		}
		if !rt.is_true(var_prepared_nav_item.array_get(rt.new_string('menu-item-url'))) {
			var_error.add(rt.new_string('rest_url_required'), rt.call_function('__', [
				rt.new_string('The url is required when using a custom menu item type.'),
			]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }]))
		}
	}
	if rt.is_true(var_error.has_errors()) {
		return mut var_error
	}
	mut iter_2 := rt.create_array([rt.ArrayItem{ key: none, val: 'menu-item-xfn' },
		rt.ArrayItem{ key: none, val: 'menu-item-classes' }]).iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_key := item_2.val
		var_prepared_nav_item.array_set(var_key, rt.call_function('implode', [
			rt.new_string(' '),
			var_prepared_nav_item.array_get(var_key),
		]))
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('publish'),
		var_prepared_nav_item.array_get(rt.new_string('menu-item-status'))))))
	{
		var_prepared_nav_item.array_set('menu-item-status', 'draft')
	}
	var_prepared_nav_item = rt.array_to_object(var_prepared_nav_item)
	return mut rt.cast_object_ptr[Class_WP_Error](rt.call_function('apply_filters', [
		rt.new_string('rest_pre_insert_nav_menu_item'),
		var_prepared_nav_item.clone(),
		var_request.clone(),
	]))
}

fn (mut this Class_WP_REST_Menu_Items_Controller) prepare_item_for_response(var_item rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
	mut var_fields := this.get_fields_for_response(var_request.clone())
	mut var_menu_item := this.get_nav_menu_item(rt.get_property(var_item, 'ID'))
	mut var_data := rt.new_array()
	if rt.is_true(rt.call_function('rest_is_field_included', [
		rt.new_string('id'), var_fields.clone()]))
	{
		var_data.array_set('id', rt.get_property(var_menu_item, 'ID'))
	}
	if rt.is_true(rt.call_function('rest_is_field_included', [
		rt.new_string('title'), var_fields.clone()]))
	{
		var_data.array_set('title', rt.new_array())
	}
	if rt.is_true(rt.call_function('rest_is_field_included', [
		rt.new_string('title.raw'), var_fields.clone()]))
	{
		var_data.array_get_mut('title').array_set('raw', rt.get_property(var_menu_item, 'title'))
	}
	if rt.is_true(rt.call_function('rest_is_field_included', [
		rt.new_string('title.rendered'),
		var_fields.clone(),
	]))
	{
		rt.call_function('add_filter', [rt.new_string('protected_title_format'),
			rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Menu_Items_Controller', [
					'WP_REST_Posts_Controller',
				], &this) },
				rt.ArrayItem{ key: none, val: 'protected_title_format' },
			])])
		rt.call_function('add_filter', [rt.new_string('private_title_format'),
			rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Menu_Items_Controller', [
					'WP_REST_Posts_Controller',
				], &this) },
				rt.ArrayItem{ key: none, val: 'protected_title_format' },
			])])
		mut var_title := rt.call_function('apply_filters', [rt.new_string('the_title'),
			rt.get_property(var_menu_item, 'title'), rt.get_property(var_menu_item, 'ID')])
		var_data.array_get_mut('title').array_set('rendered', var_title.clone())
		rt.call_function('remove_filter', [rt.new_string('protected_title_format'),
			rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Menu_Items_Controller', [
					'WP_REST_Posts_Controller',
				], &this) },
				rt.ArrayItem{ key: none, val: 'protected_title_format' },
			])])
		rt.call_function('remove_filter', [rt.new_string('private_title_format'),
			rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Menu_Items_Controller', [
					'WP_REST_Posts_Controller',
				], &this) },
				rt.ArrayItem{ key: none, val: 'protected_title_format' },
			])])
	}
	if rt.is_true(rt.call_function('rest_is_field_included', [
		rt.new_string('status'), var_fields.clone()]))
	{
		var_data.array_set('status', rt.get_property(var_menu_item, 'post_status'))
	}
	if rt.is_true(rt.call_function('rest_is_field_included', [
		rt.new_string('url'), var_fields.clone()]))
	{
		var_data.array_set('url', rt.get_property(var_menu_item, 'url'))
	}
	if rt.is_true(rt.call_function('rest_is_field_included', [
		rt.new_string('attr_title'),
		var_fields.clone(),
	]))
	{
		var_data.array_set('attr_title', rt.get_property(var_menu_item, 'attr_title'))
	}
	if rt.is_true(rt.call_function('rest_is_field_included', [
		rt.new_string('description'),
		var_fields.clone(),
	]))
	{
		var_data.array_set('description', rt.get_property(var_menu_item, 'description'))
	}
	if rt.is_true(rt.call_function('rest_is_field_included', [
		rt.new_string('type'), var_fields.clone()]))
	{
		var_data.array_set('type', rt.get_property(var_menu_item, 'type'))
	}
	if rt.is_true(rt.call_function('rest_is_field_included', [
		rt.new_string('type_label'),
		var_fields.clone(),
	]))
	{
		var_data.array_set('type_label', rt.get_property(var_menu_item, 'type_label'))
	}
	if rt.is_true(rt.call_function('rest_is_field_included', [
		rt.new_string('object'), var_fields.clone()]))
	{
		var_data.array_set('object', rt.get_property(var_menu_item, 'object'))
	}
	if rt.is_true(rt.call_function('rest_is_field_included', [
		rt.new_string('object_id'), var_fields.clone()]))
	{
		var_data.array_set('object_id', rt.call_function('absint', [
			rt.get_property(var_menu_item, 'object_id'),
		]))
	}
	if rt.is_true(rt.call_function('rest_is_field_included', [
		rt.new_string('parent'), var_fields.clone()]))
	{
		var_data.array_set('parent',
			rt.new_int((rt.get_property(var_menu_item, 'menu_item_parent')).to_i64()))
	}
	if rt.is_true(rt.call_function('rest_is_field_included', [
		rt.new_string('menu_order'),
		var_fields.clone(),
	]))
	{
		var_data.array_set('menu_order',
			rt.new_int((rt.get_property(var_menu_item, 'menu_order')).to_i64()))
	}
	if rt.is_true(rt.call_function('rest_is_field_included', [
		rt.new_string('target'), var_fields.clone()]))
	{
		var_data.array_set('target', rt.get_property(var_menu_item, 'target'))
	}
	if rt.is_true(rt.call_function('rest_is_field_included', [
		rt.new_string('classes'), var_fields.clone()]))
	{
		var_data.array_set('classes', rt.cast_array(rt.get_property(var_menu_item, 'classes')))
	}
	if rt.is_true(rt.call_function('rest_is_field_included', [
		rt.new_string('xfn'), var_fields.clone()]))
	{
		var_data.array_set('xfn', rt.call_function('array_map', [
			rt.new_string('sanitize_html_class'),
			rt.call_function('explode', [rt.new_string(' '), rt.get_property(var_menu_item, 'xfn')]),
		]))
	}
	if rt.is_true(rt.call_function('rest_is_field_included', [
		rt.new_string('invalid'), var_fields.clone()]))
	{
		var_data.array_set('invalid', (rt.get_property(var_menu_item, '_invalid')).to_bool())
	}
	if rt.is_true(rt.call_function('rest_is_field_included', [
		rt.new_string('meta'), var_fields.clone()]))
	{
		var_data.array_set('meta', rt.call_method(rt.get_property(rt.new_object('WP_REST_Menu_Items_Controller', [
			'WP_REST_Posts_Controller',
		], &this), 'meta'), 'get_value', [rt.get_property(var_menu_item, 'ID'),
			var_request.clone()]))
	}
	mut var_taxonomies := rt.call_function('wp_list_filter', [
		rt.call_function('get_object_taxonomies', [
			rt.get_property(rt.new_object('WP_REST_Menu_Items_Controller', [
				'WP_REST_Posts_Controller',
			], &this), 'post_type'),
			rt.new_string('objects'),
		]),
		rt.create_array([
			rt.ArrayItem{ key: 'show_in_rest', val: true },
		]),
	])
	mut iter_3 := var_taxonomies.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_taxonomy := item_3.val
		mut var_base := if !(!rt.is_true(rt.get_property(var_taxonomy, 'rest_base'))) {
			rt.get_property(var_taxonomy, 'rest_base')
		} else {
			rt.get_property(var_taxonomy, 'name')
		}
		if rt.is_true(rt.call_function('rest_is_field_included', [
			var_base.clone(), var_fields.clone()]))
		{
			mut var_terms := rt.call_function('get_the_terms', [
				var_item.clone(), rt.get_property(var_taxonomy, 'name')])
			if !(var_terms.clone().is_array()) {
				continue
			}
			mut var_term_ids := if rt.is_true(var_terms) { rt.call_function('array_values', [
					rt.call_function('wp_list_pluck', [var_terms.clone(),
						rt.new_string('term_id')]),
				]) } else { rt.new_array() }
			if rt.is_true(rt.identical(rt.new_string('nav_menu'), rt.get_property(var_taxonomy,
				'name')))
			{
				var_data.array_set(var_base, if rt.is_true(var_term_ids) { rt.call_function('array_shift', [
						var_term_ids.clone(),
					]) } else { rt.new_int(0) })
			} else {
				var_data.array_set(var_base, var_term_ids.clone())
			}
		}
	}
	mut var_context := if !(!rt.is_true(var_request.array_get(rt.new_string('context')))) {
		var_request.array_get(rt.new_string('context'))
	} else {
		rt.new_string('view')
	}
	var_data = this.add_additional_fields_to_object(var_data.clone(), var_request.clone())
	var_data = this.filter_response_by_context(var_data.clone(), var_context.clone())
	mut var_response := rt.call_function('rest_ensure_response', [
		var_data.clone()])
	if rt.is_true(rt.call_function('rest_is_field_included', [rt.new_string('_links'), var_fields.clone()]))
		|| rt.is_true(rt.call_function('rest_is_field_included', [rt.new_string('_embedded'), var_fields.clone()])) {
		mut var_links := this.prepare_links(var_item.clone())
		rt.call_method(var_response, 'add_links', [var_links.clone()])
		if !(!rt.is_true(var_links.array_get(rt.new_string('self')).array_get(rt.new_string('href')))) {
			mut var_actions := this.get_available_actions(var_item.clone(), var_request.clone())
			mut var_self :=
				var_links.array_get(rt.new_string('self')).array_get(rt.new_string('href'))
			mut iter_4 := var_actions.iterator()
			for {
				item_4 := iter_4.next() or { break }
				mut var_rel := item_4.val
				rt.call_method(var_response, 'add_link', [var_rel.clone(),
					var_self.clone()])
			}
		}
	}
	return rt.call_function('apply_filters', [
		rt.new_string('rest_prepare_nav_menu_item'),
		var_response.clone(),
		var_menu_item.clone(),
		var_request.clone(),
	])
}

fn (mut this Class_WP_REST_Menu_Items_Controller) prepare_links(var_post rt.PhpVal) rt.PhpVal {
	mut var_post_mutated := var_post
	mut var_links := this.Class_WP_REST_Posts_Controller.prepare_links(var_post_mutated.clone())
	mut var_menu_item := this.get_nav_menu_item(rt.get_property(var_post_mutated, 'ID'))
	if !rt.is_true(rt.get_property(var_menu_item, 'object_id')) {
		return var_links.clone()
	}
	mut var_path := rt.new_string('')
	mut var_type := rt.new_string('')
	mut var_key := rt.get_property(var_menu_item, 'type')
	if rt.is_true(rt.identical(rt.new_string('post_type'), rt.get_property(var_menu_item, 'type'))) {
		var_path = rt.call_function('rest_get_route_for_post', [
			rt.get_property(var_menu_item, 'object_id'),
		])
		var_type = rt.call_function('get_post_type', [
			rt.get_property(var_menu_item, 'object_id'),
		])
	} else if rt.is_true(rt.identical(rt.new_string('taxonomy'), rt.get_property(var_menu_item,
		'type')))
	{
		var_path = rt.call_function('rest_get_route_for_term', [
			rt.get_property(var_menu_item, 'object_id'),
		])
		var_type = rt.call_function('get_term_field', [rt.new_string('taxonomy'),
			rt.get_property(var_menu_item, 'object_id')])
	}
	if rt.is_true(var_path) && rt.is_true(var_type) {
		var_links.array_get_mut('https://api.w.org/menu-item-object').array_push(rt.create_array([
			rt.ArrayItem{ key: 'href', val: rt.call_function('rest_url', [
				var_path.clone()]) },
			rt.ArrayItem{ key: var_key, val: var_type },
			rt.ArrayItem{ key: 'embeddable', val: true },
		]))
	}
	return var_links.clone()
}

fn (mut this Class_WP_REST_Menu_Items_Controller) get_schema_links() rt.PhpVal {
	mut var_links := this.Class_WP_REST_Posts_Controller.get_schema_links()
	mut var_href := rt.call_function('rest_url', [
		rt.concat(rt.concat(rt.concat(rt.get_property(rt.new_object('WP_REST_Menu_Items_Controller', [
			'WP_REST_Posts_Controller',
		], &this), 'namespace'), rt.new_string('/')), rt.get_property(rt.new_object('WP_REST_Menu_Items_Controller', [
			'WP_REST_Posts_Controller',
		], &this), 'rest_base')), rt.new_string('/{id}')),
	])
	var_links.array_push(rt.create_array([
		rt.ArrayItem{ key: 'rel', val: 'https://api.w.org/menu-item-object' },
		rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
			rt.new_string('Get linked object.'),
		]) },
		rt.ArrayItem{ key: 'href', val: var_href },
		rt.ArrayItem{ key: 'targetSchema', val: rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'object' },
			rt.ArrayItem{ key: 'properties', val: rt.create_array([
				rt.ArrayItem{ key: 'object', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'integer' },
				]) },
			]) },
		]) },
	]))
	return var_links.clone()
}

fn (mut this Class_WP_REST_Menu_Items_Controller) get_item_schema() rt.PhpVal {
	if rt.is_true(rt.get_property(rt.new_object('WP_REST_Menu_Items_Controller', [
		'WP_REST_Posts_Controller',
	], &this), 'schema'))
	{
		return this.add_additional_fields_schema(rt.get_property(rt.new_object('WP_REST_Menu_Items_Controller', [
			'WP_REST_Posts_Controller',
		], &this), 'schema'))
	}
	mut var_schema := rt.create_array([
		rt.ArrayItem{ key: '$schema', val: 'http://json-schema.org/draft-04/schema#' },
		rt.ArrayItem{ key: 'title', val: rt.get_property(rt.new_object('WP_REST_Menu_Items_Controller', [
			'WP_REST_Posts_Controller',
		], &this), 'post_type') },
		rt.ArrayItem{ key: 'type', val: 'object' },
	])
	var_schema.array_get_mut('properties').array_set('title', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('The title for the object.'),
		]) },
		rt.ArrayItem{ key: 'type', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'string' },
			rt.ArrayItem{ key: none, val: 'object' },
		]) },
		rt.ArrayItem{ key: 'context', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'view' },
			rt.ArrayItem{ key: none, val: 'edit' },
			rt.ArrayItem{ key: none, val: 'embed' },
		]) },
		rt.ArrayItem{ key: 'properties', val: rt.create_array([
			rt.ArrayItem{ key: 'raw', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Title for the object, as it exists in the database.'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
			]) },
			rt.ArrayItem{ key: 'rendered', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('HTML title for the object, transformed for display.'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
					rt.ArrayItem{ key: none, val: 'embed' },
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
			]) },
		]) },
	]))
	var_schema.array_get_mut('properties').array_set('id', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Unique identifier for the object.'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'integer' },
		rt.ArrayItem{ key: 'default', val: 0 },
		rt.ArrayItem{ key: 'minimum', val: 0 },
		rt.ArrayItem{ key: 'context', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'view' },
			rt.ArrayItem{ key: none, val: 'edit' },
			rt.ArrayItem{ key: none, val: 'embed' },
		]) },
		rt.ArrayItem{ key: 'readonly', val: true },
	]))
	var_schema.array_get_mut('properties').array_set('type_label', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('The singular label used to describe this type of menu item.'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'string' },
		rt.ArrayItem{ key: 'context', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'view' },
			rt.ArrayItem{ key: none, val: 'edit' },
			rt.ArrayItem{ key: none, val: 'embed' },
		]) },
		rt.ArrayItem{ key: 'readonly', val: true },
	]))
	var_schema.array_get_mut('properties').array_set('type', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('The family of objects originally represented, such as "post_type" or "taxonomy".'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'string' },
		rt.ArrayItem{ key: 'enum', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'taxonomy' },
			rt.ArrayItem{ key: none, val: 'post_type' },
			rt.ArrayItem{ key: none, val: 'post_type_archive' },
			rt.ArrayItem{ key: none, val: 'custom' },
		]) },
		rt.ArrayItem{ key: 'context', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'view' },
			rt.ArrayItem{ key: none, val: 'edit' },
			rt.ArrayItem{ key: none, val: 'embed' },
		]) },
		rt.ArrayItem{ key: 'default', val: 'custom' },
	]))
	var_schema.array_get_mut('properties').array_set('status', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('A named status for the object.'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'string' },
		rt.ArrayItem{ key: 'enum', val: rt.func_array_keys(rt.call_function('get_post_stati', [
			rt.create_array([rt.ArrayItem{ key: 'internal', val: false }]),
		])) },
		rt.ArrayItem{ key: 'default', val: 'publish' },
		rt.ArrayItem{ key: 'context', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'view' },
			rt.ArrayItem{ key: none, val: 'edit' },
			rt.ArrayItem{ key: none, val: 'embed' },
		]) },
	]))
	var_schema.array_get_mut('properties').array_set('parent', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('The ID for the parent of the object.'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'integer' },
		rt.ArrayItem{ key: 'minimum', val: 0 },
		rt.ArrayItem{ key: 'default', val: 0 },
		rt.ArrayItem{ key: 'context', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'view' },
			rt.ArrayItem{ key: none, val: 'edit' },
			rt.ArrayItem{ key: none, val: 'embed' },
		]) },
	]))
	var_schema.array_get_mut('properties').array_set('attr_title', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Text for the title attribute of the link element for this menu item.'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'string' },
		rt.ArrayItem{ key: 'context', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'view' },
			rt.ArrayItem{ key: none, val: 'edit' },
			rt.ArrayItem{ key: none, val: 'embed' },
		]) },
		rt.ArrayItem{ key: 'arg_options', val: rt.create_array([
			rt.ArrayItem{ key: 'sanitize_callback', val: 'sanitize_text_field' },
		]) },
	]))
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_value := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.call_function('array_map', [rt.new_string('sanitize_html_class'),
			rt.call_function('wp_parse_list', [var_value.clone()])])
	}
	var_schema.array_get_mut('properties').array_set('classes', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Class names for the link element of this menu item.'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'array' },
		rt.ArrayItem{ key: 'items', val: rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'string' },
		]) },
		rt.ArrayItem{ key: 'context', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'view' },
			rt.ArrayItem{ key: none, val: 'edit' },
			rt.ArrayItem{ key: none, val: 'embed' },
		]) },
		rt.ArrayItem{ key: 'arg_options', val: rt.create_array([
			rt.ArrayItem{ key: 'sanitize_callback', val: rt.new_closure(closure_1_fn) },
		]) },
	]))
	var_schema.array_get_mut('properties').array_set('description', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('The description of this menu item.'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'string' },
		rt.ArrayItem{ key: 'context', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'view' },
			rt.ArrayItem{ key: none, val: 'edit' },
			rt.ArrayItem{ key: none, val: 'embed' },
		]) },
		rt.ArrayItem{ key: 'arg_options', val: rt.create_array([
			rt.ArrayItem{ key: 'sanitize_callback', val: 'sanitize_text_field' },
		]) },
	]))
	var_schema.array_get_mut('properties').array_set('menu_order', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string("The DB ID of the nav_menu_item that is this item's menu parent, if any, otherwise 0."),
		]) },
		rt.ArrayItem{ key: 'context', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'view' },
			rt.ArrayItem{ key: none, val: 'edit' },
			rt.ArrayItem{ key: none, val: 'embed' },
		]) },
		rt.ArrayItem{ key: 'type', val: 'integer' },
		rt.ArrayItem{ key: 'minimum', val: 1 },
		rt.ArrayItem{ key: 'default', val: 1 },
	]))
	var_schema.array_get_mut('properties').array_set('object', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('The type of object originally represented, such as "category", "post", or "attachment".'),
		]) },
		rt.ArrayItem{ key: 'context', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'view' },
			rt.ArrayItem{ key: none, val: 'edit' },
			rt.ArrayItem{ key: none, val: 'embed' },
		]) },
		rt.ArrayItem{ key: 'type', val: 'string' },
		rt.ArrayItem{ key: 'arg_options', val: rt.create_array([
			rt.ArrayItem{ key: 'sanitize_callback', val: 'sanitize_key' },
		]) },
	]))
	var_schema.array_get_mut('properties').array_set('object_id', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('The database ID of the original object this menu item represents, for example the ID for posts or the term_id for categories.'),
		]) },
		rt.ArrayItem{ key: 'context', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'view' },
			rt.ArrayItem{ key: none, val: 'edit' },
			rt.ArrayItem{ key: none, val: 'embed' },
		]) },
		rt.ArrayItem{ key: 'type', val: 'integer' },
		rt.ArrayItem{ key: 'minimum', val: 0 },
		rt.ArrayItem{ key: 'default', val: 0 },
	]))
	var_schema.array_get_mut('properties').array_set('target', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('The target attribute of the link element for this menu item.'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'string' },
		rt.ArrayItem{ key: 'context', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'view' },
			rt.ArrayItem{ key: none, val: 'edit' },
			rt.ArrayItem{ key: none, val: 'embed' },
		]) },
		rt.ArrayItem{ key: 'enum', val: rt.create_array([
			rt.ArrayItem{ key: none, val: '_blank' },
			rt.ArrayItem{ key: none, val: '' },
		]) },
	]))
	closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_url := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		if rt.is_true(rt.identical(rt.new_string(''), var_url)) {
			return rt.new_bool(true)
		}
		if rt.is_true(rt.call_function('sanitize_url', [var_url.clone()])) {
			return rt.new_bool(true)
		}
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('rest_invalid_url'), rt.call_function('__', [
			rt.new_string('Invalid URL.'),
		])))
	}
	var_schema.array_get_mut('properties').array_set('url', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('The URL to which this menu item points.'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'string' },
		rt.ArrayItem{ key: 'format', val: 'uri' },
		rt.ArrayItem{ key: 'context', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'view' },
			rt.ArrayItem{ key: none, val: 'edit' },
			rt.ArrayItem{ key: none, val: 'embed' },
		]) },
		rt.ArrayItem{ key: 'arg_options', val: rt.create_array([
			rt.ArrayItem{ key: 'validate_callback', val: rt.new_closure(closure_2_fn) },
		]) },
	]))
	closure_3_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_value := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.call_function('array_map', [rt.new_string('sanitize_html_class'),
			rt.call_function('wp_parse_list', [var_value.clone()])])
	}
	var_schema.array_get_mut('properties').array_set('xfn', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('The XFN relationship expressed in the link of this menu item.'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'array' },
		rt.ArrayItem{ key: 'items', val: rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'string' },
		]) },
		rt.ArrayItem{ key: 'context', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'view' },
			rt.ArrayItem{ key: none, val: 'edit' },
			rt.ArrayItem{ key: none, val: 'embed' },
		]) },
		rt.ArrayItem{ key: 'arg_options', val: rt.create_array([
			rt.ArrayItem{ key: 'sanitize_callback', val: rt.new_closure(closure_3_fn) },
		]) },
	]))
	var_schema.array_get_mut('properties').array_set('invalid', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Whether the menu item represents an object that no longer exists.'),
		]) },
		rt.ArrayItem{ key: 'context', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'view' },
			rt.ArrayItem{ key: none, val: 'edit' },
			rt.ArrayItem{ key: none, val: 'embed' },
		]) },
		rt.ArrayItem{ key: 'type', val: 'boolean' },
		rt.ArrayItem{ key: 'readonly', val: true },
	]))
	mut var_taxonomies := rt.call_function('wp_list_filter', [
		rt.call_function('get_object_taxonomies', [
			rt.get_property(rt.new_object('WP_REST_Menu_Items_Controller', [
				'WP_REST_Posts_Controller',
			], &this), 'post_type'),
			rt.new_string('objects'),
		]),
		rt.create_array([
			rt.ArrayItem{ key: 'show_in_rest', val: true },
		]),
	])
	mut iter_5 := var_taxonomies.iterator()
	for {
		item_5 := iter_5.next() or { break }
		mut var_taxonomy := item_5.val
		mut var_base := if !(!rt.is_true(rt.get_property(var_taxonomy, 'rest_base'))) {
			rt.get_property(var_taxonomy, 'rest_base')
		} else {
			rt.get_property(var_taxonomy, 'name')
		}
		var_schema.array_get_mut('properties').array_set(var_base, rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('The terms assigned to the object in the %s taxonomy.'),
				]),
				rt.get_property(var_taxonomy, 'name'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'array' },
			rt.ArrayItem{ key: 'items', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'integer' },
			]) },
			rt.ArrayItem{ key: 'context', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'view' },
				rt.ArrayItem{ key: none, val: 'edit' },
			]) },
		]))
		if rt.is_true(rt.identical(rt.new_string('nav_menu'), rt.get_property(var_taxonomy, 'name'))) {
			var_schema.array_get_mut('properties').array_get_mut(var_base).array_set('type',
				'integer')
			var_schema.array_get(rt.new_string('properties')).array_get(var_base).array_unset(rt.new_string('items'))
		}
	}
	var_schema.array_get_mut('properties').array_set('meta', rt.call_method(rt.get_property(rt.new_object('WP_REST_Menu_Items_Controller', [
		'WP_REST_Posts_Controller',
	], &this), 'meta'), 'get_field_schema', []rt.PhpVal{}))
	mut var_schema_links := this.get_schema_links()
	if rt.is_true(var_schema_links) {
		var_schema.array_set('links', var_schema_links.clone())
	}
	this.dispatch_set_prop('schema', var_schema.clone())
	return this.add_additional_fields_schema(rt.get_property(rt.new_object('WP_REST_Menu_Items_Controller', [
		'WP_REST_Posts_Controller',
	], &this), 'schema'))
}

fn (mut this Class_WP_REST_Menu_Items_Controller) get_collection_params() rt.PhpVal {
	mut var_query_params := this.Class_WP_REST_Posts_Controller.get_collection_params()
	var_query_params.array_set('menu_order', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Limit result set to posts with a specific menu_order value.'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'integer' },
	]))
	var_query_params.array_set('order', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Order sort attribute ascending or descending.'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'string' },
		rt.ArrayItem{ key: 'default', val: 'asc' },
		rt.ArrayItem{ key: 'enum', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'asc' },
			rt.ArrayItem{ key: none, val: 'desc' },
		]) },
	]))
	var_query_params.array_set('orderby', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Sort collection by object attribute.'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'string' },
		rt.ArrayItem{ key: 'default', val: 'menu_order' },
		rt.ArrayItem{ key: 'enum', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'author' },
			rt.ArrayItem{ key: none, val: 'date' },
			rt.ArrayItem{ key: none, val: 'id' },
			rt.ArrayItem{ key: none, val: 'include' },
			rt.ArrayItem{ key: none, val: 'modified' },
			rt.ArrayItem{ key: none, val: 'parent' },
			rt.ArrayItem{ key: none, val: 'relevance' },
			rt.ArrayItem{ key: none, val: 'slug' },
			rt.ArrayItem{ key: none, val: 'include_slugs' },
			rt.ArrayItem{ key: none, val: 'title' },
			rt.ArrayItem{ key: none, val: 'menu_order' },
		]) },
	]))
	var_query_params.array_get_mut('per_page').array_set('default', 100)
	return var_query_params.clone()
}

fn (mut this Class_WP_REST_Menu_Items_Controller) prepare_items_query(var_prepared_args rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
	mut var_query_args := this.Class_WP_REST_Posts_Controller.prepare_items_query(var_prepared_args.clone(),
		var_request.clone())
	if var_query_args.array_isset(rt.new_string('orderby'))
		&& var_request.array_isset(rt.new_string('orderby')) {
		mut var_orderby_mappings := rt.create_array([
			rt.ArrayItem{ key: 'id', val: 'ID' },
			rt.ArrayItem{ key: 'include', val: 'post__in' },
			rt.ArrayItem{ key: 'slug', val: 'post_name' },
			rt.ArrayItem{ key: 'include_slugs', val: 'post_name__in' },
			rt.ArrayItem{ key: 'menu_order', val: 'menu_order' },
		])
		if var_orderby_mappings.array_isset(var_request.array_get(rt.new_string('orderby'))) {
			var_query_args.array_set('orderby',
				var_orderby_mappings.array_get(var_request.array_get(rt.new_string('orderby'))))
		}
	}
	var_query_args.array_set('update_menu_item_cache', true)
	return var_query_args.clone()
}

fn (mut this Class_WP_REST_Menu_Items_Controller) get_menu_id(var_menu_item_id rt.PhpVal) rt.PhpVal {
	mut var_menu_ids := rt.call_function('wp_get_post_terms', [
		var_menu_item_id.clone(), rt.new_string('nav_menu'),
		rt.create_array([
			rt.ArrayItem{ key: 'fields', val: 'ids' },
		])])
	mut var_menu_id := rt.new_int(0)
	if rt.is_true(var_menu_ids)
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [var_menu_ids.clone()]))))) {
		var_menu_id = rt.call_function('array_shift', [var_menu_ids.clone()])
	}
	return var_menu_id.clone()
}

struct Class_WP_REST_Posts_Controller {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

struct Class_WP_REST_Response {
	rt.PhpObjectBase
}

fn create_wp_rest_menu_items_controller(_args ...rt.PhpVal) &Class_WP_REST_Menu_Items_Controller {
	mut obj := &Class_WP_REST_Menu_Items_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_rest_posts_controller(_args ...rt.PhpVal) &Class_WP_REST_Posts_Controller {
	mut obj := &Class_WP_REST_Posts_Controller{
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

fn (mut this Class_WP_REST_Menu_Items_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_nav_menu_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_nav_menu_item(dispatch_arg_0)
		}
		'get_items_permissions_check' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_items_permissions_check(dispatch_arg_0)
		}
		'get_item_permissions_check' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_item_permissions_check(dispatch_arg_0)
		}
		'check_has_read_only_access' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.check_has_read_only_access(dispatch_arg_0))
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
		'prepare_item_for_database' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.prepare_item_for_database(dispatch_arg_0)
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
		'get_schema_links' {
			return this.get_schema_links()
		}
		'get_item_schema' {
			return this.get_item_schema()
		}
		'get_collection_params' {
			return this.get_collection_params()
		}
		'prepare_items_query' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.prepare_items_query(dispatch_arg_0, dispatch_arg_1)
		}
		'get_menu_id' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_menu_id(dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_WP_REST_Menu_Items_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_REST_Menu_Items_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WP_REST_Posts_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_REST_Posts_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_REST_Posts_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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
