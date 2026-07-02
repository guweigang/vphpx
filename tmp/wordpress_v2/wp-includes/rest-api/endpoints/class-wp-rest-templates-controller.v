import rt

struct Class_WP_REST_Templates_Controller {
	rt.PhpObjectBase
pub mut:
	post_type rt.PhpVal = rt.new_null()
}

fn (mut this Class_WP_REST_Templates_Controller) construct(var_post_type rt.PhpVal) {
	mut var_post_type_mutated := var_post_type
	this.post_type = var_post_type_mutated.clone()
	mut var_obj := rt.call_function('get_post_type_object', [
		var_post_type_mutated.clone()])
	this.dispatch_set_prop('rest_base', if !(!rt.is_true(rt.get_property(var_obj, 'rest_base'))) {
		rt.get_property(var_obj, 'rest_base')
	} else {
		rt.get_property(var_obj, 'name')
	})
	this.dispatch_set_prop('namespace', if !(!rt.is_true(rt.get_property(var_obj, 'rest_namespace'))) {
		rt.get_property(var_obj, 'rest_namespace')
	} else {
		rt.new_string('wp/v2')
	})
}

fn (mut this Class_WP_REST_Templates_Controller) register_routes() {
	rt.call_function('register_rest_route', [
		rt.get_property(rt.new_object('WP_REST_Templates_Controller', [
			'WP_REST_Controller',
		], &this), 'namespace'),
		rt.new_string('/' +(rt.get_property(rt.new_object('WP_REST_Templates_Controller', ['WP_REST_Controller'], &this), 'rest_base')).str()),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() },
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Templates_Controller', [
						'WP_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'get_items' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Templates_Controller', [
						'WP_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'get_items_permissions_check' },
				]) },
				rt.ArrayItem{ key: 'args', val: this.get_collection_params() },
			]) },
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.creatable() },
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Templates_Controller', [
						'WP_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'create_item' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Templates_Controller', [
						'WP_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'create_item_permissions_check' },
				]) },
				rt.ArrayItem{
					key: 'args'
					val: this.get_endpoint_args_for_item_schema(Class_WP_REST_Server.creatable())
				},
			]) },
			rt.ArrayItem{ key: 'schema', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Templates_Controller', [
					'WP_REST_Controller',
				], &this) },
				rt.ArrayItem{ key: none, val: 'get_public_item_schema' },
			]) },
		]),
	])
	rt.call_function('register_rest_route', [
		rt.get_property(rt.new_object('WP_REST_Templates_Controller', [
			'WP_REST_Controller',
		], &this), 'namespace'),
		rt.new_string('/' +
			(rt.get_property(rt.new_object('WP_REST_Templates_Controller', ['WP_REST_Controller'], &this), 'rest_base')).str() +
			'/lookup'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() },
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Templates_Controller', [
						'WP_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'get_template_fallback' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Templates_Controller', [
						'WP_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'get_item_permissions_check' },
				]) },
				rt.ArrayItem{ key: 'args', val: rt.create_array([
					rt.ArrayItem{ key: 'slug', val: rt.create_array([
						rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
							rt.new_string('The slug of the template to get the fallback for'),
						]) },
						rt.ArrayItem{ key: 'type', val: 'string' },
						rt.ArrayItem{ key: 'required', val: true },
					]) },
					rt.ArrayItem{ key: 'is_custom', val: rt.create_array([
						rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
							rt.new_string('Indicates if a template is custom or part of the template hierarchy'),
						]) },
						rt.ArrayItem{ key: 'type', val: 'boolean' },
					]) },
					rt.ArrayItem{ key: 'template_prefix', val: rt.create_array([
						rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
							rt.new_string('The template prefix for the created template. This is used to extract the main template type, e.g. in `taxonomy-books` extracts the `taxonomy`'),
						]) },
						rt.ArrayItem{ key: 'type', val: 'string' },
					]) },
				]) },
			]) },
		]),
	])
	rt.call_function('register_rest_route', [
		rt.get_property(rt.new_object('WP_REST_Templates_Controller', [
			'WP_REST_Controller',
		], &this), 'namespace'),
		rt.call_function('sprintf', [
			rt.new_string('/%s/(?P<id>%s%s)'),
			rt.get_property(rt.new_object('WP_REST_Templates_Controller', [
				'WP_REST_Controller',
			], &this), 'rest_base'),
			rt.new_string('([^\\/:<>\\*\\?"\\|]+(?:\\/[^\\/:<>\\*\\?"\\|]+)?)'),
			rt.new_string('[\\/\\w%-]+'),
		]),
		rt.create_array([
			rt.ArrayItem{ key: 'args', val: rt.create_array([
				rt.ArrayItem{ key: 'id', val: rt.create_array([
					rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
						rt.new_string('The id of a template'),
					]) },
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'sanitize_callback', val: rt.create_array([
						rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Templates_Controller', [
							'WP_REST_Controller',
						], &this) },
						rt.ArrayItem{ key: none, val: '_sanitize_template_id' },
					]) },
				]) },
			]) },
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() },
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Templates_Controller', [
						'WP_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'get_item' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Templates_Controller', [
						'WP_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'get_item_permissions_check' },
				]) },
				rt.ArrayItem{ key: 'args', val: rt.create_array([
					rt.ArrayItem{ key: 'context', val: this.get_context_param(rt.create_array([
						rt.ArrayItem{ key: 'default', val: 'view' },
					])) },
				]) },
			]) },
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.editable() },
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Templates_Controller', [
						'WP_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'update_item' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Templates_Controller', [
						'WP_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'update_item_permissions_check' },
				]) },
				rt.ArrayItem{
					key: 'args'
					val: this.get_endpoint_args_for_item_schema(Class_WP_REST_Server.editable())
				},
			]) },
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.deletable() },
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Templates_Controller', [
						'WP_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'delete_item' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Templates_Controller', [
						'WP_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'delete_item_permissions_check' },
				]) },
				rt.ArrayItem{ key: 'args', val: rt.create_array([
					rt.ArrayItem{ key: 'force', val: rt.create_array([
						rt.ArrayItem{ key: 'type', val: 'boolean' },
						rt.ArrayItem{ key: 'default', val: false },
						rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
							rt.new_string('Whether to bypass Trash and force deletion.'),
						]) },
					]) },
				]) },
			]) },
			rt.ArrayItem{ key: 'schema', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Templates_Controller', [
					'WP_REST_Controller',
				], &this) },
				rt.ArrayItem{ key: none, val: 'get_public_item_schema' },
			]) },
		]),
	])
}

fn (mut this Class_WP_REST_Templates_Controller) get_template_fallback(var_request rt.PhpVal) rt.PhpVal {
	mut var_hierarchy := rt.call_function('get_template_hierarchy', [
		var_request.array_get(rt.new_string('slug')),
		var_request.array_get(rt.new_string('is_custom')),
		var_request.array_get(rt.new_string('template_prefix')),
	])
	for {
		mut var_fallback_template := rt.call_function('resolve_block_template', [
			var_request.array_get(rt.new_string('slug')),
			var_hierarchy.clone(),
			rt.new_string(''),
		])
		rt.call_function('array_shift', [var_hierarchy.clone()])
		if !(!(!rt.is_true(var_hierarchy))
			&& !rt.is_true(rt.get_property(var_fallback_template, 'content'))) {
			break
		}
	}
	mut var_response := if rt.is_true(var_fallback_template) {
		this.prepare_item_for_response(var_fallback_template.clone(), var_request.clone())
	} else {
		create_stdclass()
	}
	return rt.call_function('rest_ensure_response', [var_response.clone()])
}

fn (mut this Class_WP_REST_Templates_Controller) permissions_check(var_request rt.PhpVal) bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('edit_theme_options'),
	])))))
	{
		return (create_wp_error(rt.new_string('rest_cannot_manage_templates'), rt.call_function('__', [
			rt.new_string('Sorry, you are not allowed to access the templates on this site.'),
		]), rt.create_array([
			rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code',
				[]rt.PhpVal{}) },
		]))).to_bool()
	}
	return true
}

fn (mut this Class_WP_REST_Templates_Controller) _sanitize_template_id(var_id rt.PhpVal) string {
	mut var_id_mutated := var_id
	var_id_mutated = rt.call_function('urldecode', [var_id_mutated.clone()])
	mut var_last_slash_pos := rt.call_function('strrpos', [var_id_mutated.clone(),
		rt.new_string('/')])
	if rt.is_true(rt.identical(rt.new_bool(false), var_last_slash_pos)) {
		return var_id_mutated.str()
	}
	mut var_is_double_slashed := rt.identical(rt.call_function('substr', [
		var_id_mutated.clone(), rt.sub(var_last_slash_pos, rt.new_int(1)),
		rt.new_int(1)]), rt.new_string('/'))
	if rt.is_true(var_is_double_slashed) {
		return var_id_mutated.str()
	}
	return
		(rt.call_function('substr', [var_id_mutated.clone(), rt.new_int(0), var_last_slash_pos.clone()])).str() +
		'/' +
		(rt.call_function('substr', [var_id_mutated.clone(), var_last_slash_pos.clone()])).str()
}

fn (mut this Class_WP_REST_Templates_Controller) get_items_permissions_check(var_request rt.PhpVal) bool {
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
	return (create_wp_error(rt.new_string('rest_cannot_manage_templates'), rt.call_function('__', [
		rt.new_string('Sorry, you are not allowed to access the templates on this site.'),
	]), rt.create_array([
		rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code',
			[]rt.PhpVal{}) },
	]))).to_bool()
}

fn (mut this Class_WP_REST_Templates_Controller) get_items(var_request rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.call_method(var_request, 'is_method', [rt.new_string('HEAD')])) {
		return rt.new_object('WP_REST_Response', []string{},
			create_wp_rest_response(rt.new_array()))
	}
	mut var_query := rt.new_array()
	if var_request.array_isset(rt.new_string('wp_id')) {
		var_query['wp_id'] = var_request.array_get(rt.new_string('wp_id'))
	}
	if var_request.array_isset(rt.new_string('area')) {
		var_query['area'] = var_request.array_get(rt.new_string('area'))
	}
	if var_request.array_isset(rt.new_string('post_type')) {
		var_query['post_type'] = var_request.array_get(rt.new_string('post_type'))
	}
	mut var_templates := rt.new_array()
	mut iter_2 := rt.call_function('get_block_templates', [
		rt.create_array_from_native_map(var_query),
		this.post_type,
	]).iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_template := item_2.val
		mut var_data := this.prepare_item_for_response(var_template.clone(), var_request.clone())
		var_templates << this.prepare_response_for_collection(var_data.clone())
	}
	return rt.call_function('rest_ensure_response', [
		rt.create_array_from_list(var_templates),
	])
}

fn (mut this Class_WP_REST_Templates_Controller) get_item_permissions_check(var_request rt.PhpVal) bool {
	if rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_posts')])) {
		return true
	}
	mut iter_3 := rt.call_function('get_post_types', [
		rt.create_array([rt.ArrayItem{ key: 'show_in_rest', val: true }]),
		rt.new_string('objects'),
	]).iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_post_type := item_3.val
		if rt.is_true(rt.call_function('current_user_can', [
			rt.get_property(rt.get_property(var_post_type, 'cap'), 'edit_posts'),
		]))
		{
			return true
		}
	}
	return (create_wp_error(rt.new_string('rest_cannot_manage_templates'), rt.call_function('__', [
		rt.new_string('Sorry, you are not allowed to access the templates on this site.'),
	]), rt.create_array([
		rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code',
			[]rt.PhpVal{}) },
	]))).to_bool()
}

fn (mut this Class_WP_REST_Templates_Controller) get_item(var_request rt.PhpVal) rt.PhpVal {
	if var_request.array_isset(rt.new_string('source'))
		&& rt.is_true(rt.identical(rt.new_string('theme'), var_request.array_get(rt.new_string('source'))))
		|| rt.is_true(rt.identical(rt.new_string('plugin'), var_request.array_get(rt.new_string('source')))) {
		mut var_template := rt.call_function('get_block_file_template', [
			var_request.array_get(rt.new_string('id')),
			this.post_type,
		])
	} else {
		var_template = rt.call_function('get_block_template', [
			var_request.array_get(rt.new_string('id')),
			this.post_type,
		])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_template)))) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('rest_template_not_found'), rt.call_function('__', [
			rt.new_string('No templates exist with that id.'),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 404 }])))
	}
	return this.prepare_item_for_response(var_template.clone(), var_request.clone())
}

fn (mut this Class_WP_REST_Templates_Controller) update_item_permissions_check(var_request rt.PhpVal) rt.PhpVal {
	return rt.new_bool(this.permissions_check(var_request.clone()))
}

fn (mut this Class_WP_REST_Templates_Controller) update_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_template := rt.call_function('get_block_template', [
		var_request.array_get(rt.new_string('id')),
		this.post_type,
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_template)))) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('rest_template_not_found'), rt.call_function('__', [
			rt.new_string('No templates exist with that id.'),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 404 }])))
	}
	mut var_post_before := rt.call_function('get_post', [
		rt.get_property(var_template, 'wp_id'),
	])
	if var_request.array_isset(rt.new_string('source'))
		&& rt.is_true(rt.identical(rt.new_string('theme'), var_request.array_get(rt.new_string('source')))) {
		rt.call_function('wp_delete_post', [rt.get_property(var_template, 'wp_id'),
			rt.new_bool(true)])
		rt.call_method(var_request, 'set_param', [rt.new_string('context'),
			rt.new_string('edit')])
		var_template = rt.call_function('get_block_template', [
			var_request.array_get(rt.new_string('id')),
			this.post_type,
		])
		mut var_response := this.prepare_item_for_response(var_template.clone(),
			var_request.clone())
		return rt.call_function('rest_ensure_response', [var_response.clone()])
	}
	mut var_changes := this.prepare_item_for_database(var_request.clone())
	if rt.is_true(rt.call_function('is_wp_error', [var_changes.clone()])) {
		return var_changes.clone()
	}
	if rt.is_true(rt.identical(rt.new_string('custom'), rt.get_property(var_template, 'source'))) {
		mut var_update := rt.new_bool(true)
		mut var_result := rt.call_function('wp_update_post', [
			rt.call_function('wp_slash', [rt.cast_array(var_changes)]),
			rt.new_bool(false),
		])
	} else {
		var_update = rt.new_bool(false)
		var_post_before = rt.new_null()
		var_result = rt.call_function('wp_insert_post', [
			rt.call_function('wp_slash', [rt.cast_array(var_changes)]),
			rt.new_bool(false),
		])
	}
	if rt.is_true(rt.call_function('is_wp_error', [var_result.clone()])) {
		if rt.is_true(rt.identical(rt.new_string('db_update_error'), rt.call_method(var_result,
			'get_error_code', []rt.PhpVal{})))
		{
			rt.call_method(var_result, 'add_data', [
				rt.create_array([rt.ArrayItem{ key: 'status', val: 500 }]),
			])
		} else {
			rt.call_method(var_result, 'add_data', [
				rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }]),
			])
		}
		return var_result.clone()
	}
	var_template = rt.call_function('get_block_template', [
		var_request.array_get(rt.new_string('id')),
		this.post_type,
	])
	mut var_fields_update := this.update_additional_fields_for_object(var_template.clone(),
		var_request.clone())
	if rt.is_true(rt.call_function('is_wp_error', [var_fields_update.clone()])) {
		return var_fields_update.clone()
	}
	rt.call_method(var_request, 'set_param', [rt.new_string('context'),
		rt.new_string('edit')])
	mut var_post := rt.call_function('get_post', [rt.get_property(var_template, 'wp_id')])
	rt.call_function('do_action', [
		rt.concat(rt.new_string('rest_after_insert_'), this.post_type),
		var_post.clone(),
		var_request.clone(),
		rt.new_bool(false),
	])
	rt.call_function('wp_after_insert_post', [var_post.clone(),
		var_update.clone(), var_post_before.clone()])
	var_response = this.prepare_item_for_response(var_template.clone(), var_request.clone())
	return rt.call_function('rest_ensure_response', [var_response.clone()])
}

fn (mut this Class_WP_REST_Templates_Controller) create_item_permissions_check(var_request rt.PhpVal) rt.PhpVal {
	return rt.new_bool(this.permissions_check(var_request.clone()))
}

fn (mut this Class_WP_REST_Templates_Controller) create_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_prepared_post := this.prepare_item_for_database(var_request.clone())
	if rt.is_true(rt.call_function('is_wp_error', [var_prepared_post.clone()])) {
		return var_prepared_post.clone()
	}
	rt.set_property(var_prepared_post, 'post_name', var_request.array_get(rt.new_string('slug')))
	mut var_post_id := rt.call_function('wp_insert_post', [
		rt.call_function('wp_slash', [rt.cast_array(var_prepared_post)]),
		rt.new_bool(true),
	])
	if rt.is_true(rt.call_function('is_wp_error', [var_post_id.clone()])) {
		if rt.is_true(rt.identical(rt.new_string('db_insert_error'), rt.call_method(var_post_id,
			'get_error_code', []rt.PhpVal{})))
		{
			rt.call_method(var_post_id, 'add_data', [
				rt.create_array([rt.ArrayItem{ key: 'status', val: 500 }]),
			])
		} else {
			rt.call_method(var_post_id, 'add_data', [
				rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }]),
			])
		}
		return var_post_id.clone()
	}
	mut var_posts := rt.call_function('get_block_templates', [
		rt.create_array([rt.ArrayItem{ key: 'wp_id', val: var_post_id }]),
		this.post_type,
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_int(var_posts.clone().array_count()))))) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('rest_template_insert_error'), rt.call_function('__', [
			rt.new_string('No templates exist with that id.'),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }])))
	}
	mut var_id := rt.get_property(var_posts.array_get(rt.new_int(0)), 'id')
	mut var_post := rt.call_function('get_post', [var_post_id.clone()])
	mut var_template := rt.call_function('get_block_template', [
		var_id.clone(), this.post_type])
	mut var_fields_update := this.update_additional_fields_for_object(var_template.clone(),
		var_request.clone())
	if rt.is_true(rt.call_function('is_wp_error', [var_fields_update.clone()])) {
		return var_fields_update.clone()
	}
	rt.call_function('do_action', [
		rt.concat(rt.new_string('rest_after_insert_'), this.post_type),
		var_post.clone(),
		var_request.clone(),
		rt.new_bool(true),
	])
	rt.call_function('wp_after_insert_post', [var_post.clone(),
		rt.new_bool(false), rt.new_null()])
	mut var_response := this.prepare_item_for_response(var_template.clone(), var_request.clone())
	var_response = rt.call_function('rest_ensure_response', [
		var_response.clone()])
	rt.call_method(var_response, 'set_status', [rt.new_int(201)])
	rt.call_method(var_response, 'header', [rt.new_string('Location'),
		rt.call_function('rest_url', [
			rt.call_function('sprintf', [rt.new_string('%s/%s/%s'),
				rt.get_property(rt.new_object('WP_REST_Templates_Controller', [
					'WP_REST_Controller',
				], &this), 'namespace'),
				rt.get_property(rt.new_object('WP_REST_Templates_Controller', [
					'WP_REST_Controller',
				], &this), 'rest_base'),
				rt.get_property(var_template, 'id')]),
		])])
	return var_response.clone()
}

fn (mut this Class_WP_REST_Templates_Controller) delete_item_permissions_check(var_request rt.PhpVal) rt.PhpVal {
	return rt.new_bool(this.permissions_check(var_request.clone()))
}

fn (mut this Class_WP_REST_Templates_Controller) delete_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_template := rt.call_function('get_block_template', [
		var_request.array_get(rt.new_string('id')),
		this.post_type,
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_template)))) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('rest_template_not_found'), rt.call_function('__', [
			rt.new_string('No templates exist with that id.'),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 404 }])))
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('custom'), rt.get_property(var_template,
		'source')))))
	{
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('rest_invalid_template'), rt.call_function('__', [
			rt.new_string("Templates based on theme files can't be removed."),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }])))
	}
	mut var_id := rt.get_property(var_template, 'wp_id')
	mut var_force := rt.new_bool((var_request.array_get(rt.new_string('force'))).to_bool())
	rt.call_method(var_request, 'set_param', [rt.new_string('context'),
		rt.new_string('edit')])
	if rt.is_true(var_force) {
		mut var_previous := this.prepare_item_for_response(var_template.clone(),
			var_request.clone())
		mut var_result := rt.call_function('wp_delete_post', [
			var_id.clone(), rt.new_bool(true)])
		mut var_response := create_wp_rest_response()
		rt.call_method(var_response, 'set_data', [
			rt.create_array([rt.ArrayItem{ key: 'deleted', val: true },
				rt.ArrayItem{ key: 'previous', val: rt.call_method(var_previous, 'get_data',
					[]rt.PhpVal{}) }]),
		])
	} else {
		if rt.is_true(rt.identical(rt.new_string('trash'), rt.get_property(var_template, 'status'))) {
			return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('rest_template_already_trashed'), rt.call_function('__', [
				rt.new_string('The template has already been deleted.'),
			]), rt.create_array([rt.ArrayItem{ key: 'status', val: 410 }])))
		}
		var_result = rt.call_function('wp_trash_post', [var_id.clone()])
		rt.set_property(var_template, 'status', rt.new_string('trash'))
		var_response = this.prepare_item_for_response(var_template.clone(), var_request.clone())
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_result)))) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('rest_cannot_delete'), rt.call_function('__', [
			rt.new_string('The template cannot be deleted.'),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 500 }])))
	}
	return var_response.clone()
}

fn (mut this Class_WP_REST_Templates_Controller) prepare_item_for_database(var_request rt.PhpVal) rt.PhpVal {
	mut var_template := if rt.is_true(var_request.array_get(rt.new_string('id'))) { rt.call_function('get_block_template', [
			var_request.array_get(rt.new_string('id')),
			this.post_type,
		]) } else { rt.new_null() }
	mut var_changes := create_stdclass()
	if rt.is_true(rt.identical(rt.new_null(), var_template)) {
		rt.set_property(var_changes, 'post_type', this.post_type)
		rt.set_property(var_changes, 'post_status', rt.new_string('publish'))
		rt.set_property(var_changes, 'tax_input', rt.create_array([
			rt.ArrayItem{
				key: 'wp_theme'
				val: if !(var_request.array_get(rt.new_string('theme'))).is_null() {
					var_request.array_get(rt.new_string('theme'))
				} else {
					rt.call_function('get_stylesheet', []rt.PhpVal{})
				}
			},
		]))
	} else if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('custom'), rt.get_property(var_template,
		'source')))))
	{
		rt.set_property(var_changes, 'post_name', rt.get_property(var_template, 'slug'))
		rt.set_property(var_changes, 'post_type', this.post_type)
		rt.set_property(var_changes, 'post_status', rt.new_string('publish'))
		rt.set_property(var_changes, 'tax_input', rt.create_array([
			rt.ArrayItem{ key: 'wp_theme', val: rt.get_property(var_template, 'theme') },
		]))
		rt.set_property(var_changes, 'meta_input', rt.create_array([
			rt.ArrayItem{ key: 'origin', val: rt.get_property(var_template, 'source') },
		]))
	} else {
		rt.set_property(var_changes, 'post_name', rt.get_property(var_template, 'slug'))
		rt.set_property(var_changes, 'ID', rt.get_property(var_template, 'wp_id'))
		rt.set_property(var_changes, 'post_status', rt.new_string('publish'))
	}
	if var_request.array_isset(rt.new_string('content')) {
		if rt.is_true(rt.new_bool(var_request.array_get(rt.new_string('content')).is_string())) {
			rt.set_property(var_changes, 'post_content',
				var_request.array_get(rt.new_string('content')))
		} else if var_request.array_get(rt.new_string('content')).array_isset(rt.new_string('raw')) {
			rt.set_property(var_changes, 'post_content',
				var_request.array_get(rt.new_string('content')).array_get(rt.new_string('raw')))
		}
	} else if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_template))))
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('custom'), rt.get_property(var_template, 'source'))))) {
		rt.set_property(var_changes, 'post_content', rt.get_property(var_template, 'content'))
	}
	if var_request.array_isset(rt.new_string('title')) {
		if rt.is_true(rt.new_bool(var_request.array_get(rt.new_string('title')).is_string())) {
			rt.set_property(var_changes, 'post_title',
				var_request.array_get(rt.new_string('title')))
		} else if !(!rt.is_true(var_request.array_get(rt.new_string('title')).array_get(rt.new_string('raw')))) {
			rt.set_property(var_changes, 'post_title',
				var_request.array_get(rt.new_string('title')).array_get(rt.new_string('raw')))
		}
	} else if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_template))))
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('custom'), rt.get_property(var_template, 'source'))))) {
		rt.set_property(var_changes, 'post_title', rt.get_property(var_template, 'title'))
	}
	if var_request.array_isset(rt.new_string('description')) {
		rt.set_property(var_changes, 'post_excerpt',
			var_request.array_get(rt.new_string('description')))
	} else if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_template))))
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('custom'), rt.get_property(var_template, 'source'))))) {
		rt.set_property(var_changes, 'post_excerpt', rt.get_property(var_template, 'description'))
	}
	if rt.is_true(rt.identical(rt.new_string('wp_template'), this.post_type))
		&& var_request.array_isset(rt.new_string('is_wp_suggestion')) {
		rt.set_property(var_changes, 'meta_input', rt.call_function('wp_parse_args', [
			rt.create_array([
				rt.ArrayItem{
					key: 'is_wp_suggestion'
					val: var_request.array_get(rt.new_string('is_wp_suggestion'))
				},
			]),
			rt.set_property(var_changes, 'meta_input', rt.new_array()),
		]))
	}
	if rt.is_true(rt.identical(rt.new_string('wp_template_part'), this.post_type)) {
		if var_request.array_isset(rt.new_string('area')) {
			rt.get_property(var_changes, 'tax_input').array_set('wp_template_part_area', rt.call_function('_filter_block_template_part_area', [
				var_request.array_get(rt.new_string('area')),
			]))
		} else if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_template))))
			&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('custom'), rt.get_property(var_template, 'source')))))
			&& rt.is_true(rt.get_property(var_template, 'area')) {
			rt.get_property(var_changes, 'tax_input').array_set('wp_template_part_area', rt.call_function('_filter_block_template_part_area', [
				rt.get_property(var_template, 'area'),
			]))
		} else if !rt.is_true(rt.get_property(var_template, 'area')) {
			rt.get_property(var_changes, 'tax_input').array_set('wp_template_part_area',
				rt.get_constant('WP_TEMPLATE_PART_AREA_UNCATEGORIZED'))
		}
	}
	if !(!rt.is_true(var_request.array_get(rt.new_string('author')))) {
		mut var_post_author := rt.new_int((var_request.array_get(rt.new_string('author'))).to_i64())
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('get_current_user_id',
			[]rt.PhpVal{}), var_post_author))))
		{
			mut var_user_obj := rt.call_function('get_userdata', [
				var_post_author.clone()])
			if rt.is_true(rt.new_bool(!(rt.is_true(var_user_obj)))) {
				return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('rest_invalid_author'), rt.call_function('__', [
					rt.new_string('Invalid author ID.'),
				]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }])))
			}
		}
		rt.set_property(var_changes, 'post_author', var_post_author.clone())
	}
	return rt.call_function('apply_filters', [
		rt.concat(rt.new_string('rest_pre_insert_'), this.post_type),
		var_changes.clone(),
		var_request.clone(),
	])
}

fn (mut this Class_WP_REST_Templates_Controller) prepare_item_for_response(var_item rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
	mut var_item_mutated := var_item
	if rt.is_true(rt.call_method(var_request, 'is_method', [rt.new_string('HEAD')])) {
		return rt.new_object('WP_REST_Response', []string{},
			create_wp_rest_response(rt.new_array()))
	}
	mut var_blocks := rt.call_function('parse_blocks', [
		rt.get_property(var_item_mutated, 'content'),
	])
	var_blocks = rt.call_function('resolve_pattern_blocks', [
		var_blocks.clone()])
	rt.set_property(var_item_mutated, 'content', rt.call_function('serialize_blocks', [
		var_blocks.clone(),
	]))
	mut var_template := var_item_mutated.clone()
	mut var_fields := this.get_fields_for_response(var_request.clone())
	mut var_data := rt.new_array()
	if rt.is_true(rt.call_function('rest_is_field_included', [
		rt.new_string('id'), var_fields.clone()]))
	{
		var_data.array_set('id', rt.get_property(var_template, 'id'))
	}
	if rt.is_true(rt.call_function('rest_is_field_included', [
		rt.new_string('theme'), var_fields.clone()]))
	{
		var_data.array_set('theme', rt.get_property(var_template, 'theme'))
	}
	if rt.is_true(rt.call_function('rest_is_field_included', [
		rt.new_string('content'), var_fields.clone()]))
	{
		var_data.array_set('content', rt.new_array())
	}
	if rt.is_true(rt.call_function('rest_is_field_included', [
		rt.new_string('content.raw'),
		var_fields.clone(),
	]))
	{
		var_data.array_get_mut('content').array_set('raw', rt.get_property(var_template, 'content'))
	}
	if rt.is_true(rt.call_function('rest_is_field_included', [
		rt.new_string('content.block_version'),
		var_fields.clone(),
	]))
	{
		var_data.array_get_mut('content').array_set('block_version', rt.call_function('block_version', [
			rt.get_property(var_template, 'content'),
		]))
	}
	if rt.is_true(rt.call_function('rest_is_field_included', [
		rt.new_string('slug'), var_fields.clone()]))
	{
		var_data.array_set('slug', rt.get_property(var_template, 'slug'))
	}
	if rt.is_true(rt.call_function('rest_is_field_included', [
		rt.new_string('source'), var_fields.clone()]))
	{
		var_data.array_set('source', rt.get_property(var_template, 'source'))
	}
	if rt.is_true(rt.call_function('rest_is_field_included', [
		rt.new_string('origin'), var_fields.clone()]))
	{
		var_data.array_set('origin', rt.get_property(var_template, 'origin'))
	}
	if rt.is_true(rt.call_function('rest_is_field_included', [
		rt.new_string('type'), var_fields.clone()]))
	{
		var_data.array_set('type', rt.get_property(var_template, 'type'))
	}
	if rt.is_true(rt.call_function('rest_is_field_included', [
		rt.new_string('description'),
		var_fields.clone(),
	]))
	{
		var_data.array_set('description', rt.get_property(var_template, 'description'))
	}
	if rt.is_true(rt.call_function('rest_is_field_included', [
		rt.new_string('title'), var_fields.clone()]))
	{
		var_data.array_set('title', rt.new_array())
	}
	if rt.is_true(rt.call_function('rest_is_field_included', [
		rt.new_string('title.raw'), var_fields.clone()]))
	{
		var_data.array_get_mut('title').array_set('raw', rt.get_property(var_template, 'title'))
	}
	if rt.is_true(rt.call_function('rest_is_field_included', [
		rt.new_string('title.rendered'),
		var_fields.clone(),
	]))
	{
		if rt.is_true(rt.get_property(var_template, 'wp_id')) {
			var_data.array_get_mut('title').array_set('rendered', rt.call_function('apply_filters', [
				rt.new_string('the_title'),
				rt.get_property(var_template, 'title'),
				rt.get_property(var_template, 'wp_id'),
			]))
		} else {
			var_data.array_get_mut('title').array_set('rendered', rt.get_property(var_template,
				'title'))
		}
	}
	if rt.is_true(rt.call_function('rest_is_field_included', [
		rt.new_string('status'), var_fields.clone()]))
	{
		var_data.array_set('status', rt.get_property(var_template, 'status'))
	}
	if rt.is_true(rt.call_function('rest_is_field_included', [
		rt.new_string('wp_id'), var_fields.clone()]))
	{
		var_data.array_set('wp_id', rt.new_int((rt.get_property(var_template, 'wp_id')).to_i64()))
	}
	if rt.is_true(rt.call_function('rest_is_field_included', [
		rt.new_string('has_theme_file'),
		var_fields.clone(),
	]))
	{
		var_data.array_set('has_theme_file',
			(rt.get_property(var_template, 'has_theme_file')).to_bool())
	}
	if rt.is_true(rt.call_function('rest_is_field_included', [rt.new_string('is_custom'), var_fields.clone()]))
		&& rt.is_true(rt.identical(rt.new_string('wp_template'), rt.get_property(var_template, 'type'))) {
		var_data.array_set('is_custom', rt.get_property(var_template, 'is_custom'))
	}
	if rt.is_true(rt.call_function('rest_is_field_included', [
		rt.new_string('author'), var_fields.clone()]))
	{
		var_data.array_set('author', rt.new_int((rt.get_property(var_template, 'author')).to_i64()))
	}
	if rt.is_true(rt.call_function('rest_is_field_included', [rt.new_string('area'), var_fields.clone()]))
		&& rt.is_true(rt.identical(rt.new_string('wp_template_part'), rt.get_property(var_template, 'type'))) {
		var_data.array_set('area', rt.get_property(var_template, 'area'))
	}
	if rt.is_true(rt.call_function('rest_is_field_included', [
		rt.new_string('modified'), var_fields.clone()]))
	{
		var_data.array_set('modified', rt.call_function('mysql_to_rfc3339', [
			rt.get_property(var_template, 'modified'),
		]))
	}
	if rt.is_true(rt.call_function('rest_is_field_included', [
		rt.new_string('author_text'),
		var_fields.clone(),
	]))
	{
		var_data.array_set('author_text',
			Class_WP_REST_Templates_Controller.get_wp_templates_author_text_field(var_template.clone()))
	}
	if rt.is_true(rt.call_function('rest_is_field_included', [
		rt.new_string('original_source'),
		var_fields.clone(),
	]))
	{
		var_data.array_set('original_source',
			Class_WP_REST_Templates_Controller.get_wp_templates_original_source_field(var_template.clone()))
	}
	if rt.is_true(rt.call_function('rest_is_field_included', [
		rt.new_string('plugin'), var_fields.clone()]))
	{
		mut iife_temp_0 := Class_WP_Block_Templates_Registry{}
		mut iife_result_0 := iife_temp_0.get_instance()
		mut var_registered_template := rt.call_method(iife_result_0, 'get_by_slug', [
			rt.get_property(var_template, 'slug'),
		])
		if rt.is_true(var_registered_template) {
			var_data.array_set('plugin', rt.get_property(var_registered_template, 'plugin'))
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
		mut var_links := this.prepare_links(rt.get_property(var_template, 'id'))
		rt.call_method(var_response, 'add_links', [var_links.clone()])
		if !(!rt.is_true(var_links.array_get(rt.new_string('self')).array_get(rt.new_string('href')))) {
			mut var_actions := this.get_available_actions()
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
	return var_response.clone()
}

fn Class_WP_REST_Templates_Controller.get_wp_templates_original_source_field(var_template_object rt.PhpVal) string {
	if rt.is_true(rt.identical(rt.new_string('wp_template'), rt.get_property(var_template_object, 'type')))
		|| rt.is_true(rt.identical(rt.new_string('wp_template_part'), rt.get_property(var_template_object, 'type'))) {
		if rt.is_true(rt.get_property(var_template_object, 'has_theme_file'))
			&& rt.is_true(rt.identical(rt.new_string('theme'), rt.get_property(var_template_object, 'origin')))
			|| (!rt.is_true(rt.get_property(var_template_object, 'origin'))
			&& rt.is_true(rt.call_function('in_array', [rt.get_property(var_template_object, 'source'), rt.create_array([rt.ArrayItem{
			key: none
			val: 'theme'
		}, rt.ArrayItem{ key: none, val: 'custom' }]), rt.new_bool(true)]))) {
			return 'theme'
		}
		if rt.is_true(rt.identical(rt.new_string('plugin'), rt.get_property(var_template_object,
			'origin')))
		{
			return 'plugin'
		}
		if !rt.is_true(rt.get_property(var_template_object, 'has_theme_file'))
			&& rt.is_true(rt.identical(rt.new_string('custom'), rt.get_property(var_template_object, 'source')))
			&& !rt.is_true(rt.get_property(var_template_object, 'author')) {
			return 'site'
		}
	}
	return 'user'
}

fn Class_WP_REST_Templates_Controller.get_wp_templates_author_text_field(var_template_object rt.PhpVal) string {
	mut var_plugin_slug := rt.new_null()
	mut var_original_source :=
		Class_WP_REST_Templates_Controller.get_wp_templates_original_source_field(var_template_object.clone())
	mut switch_val_1 := var_original_source
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('theme'))) {
		mut var_theme_name := rt.call_method(rt.call_function('wp_get_theme', [
			rt.get_property(var_template_object, 'theme'),
		]), 'get', [rt.new_string('Name')])
		return (if !rt.is_true(var_theme_name) {
			rt.get_property(var_template_object, 'theme')
		} else {
			var_theme_name
		}).str()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('plugin'))) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
			rt.new_string('get_plugins'),
		])))))
		{
			rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/plugin.php',
				'4')
		}
		if !(rt.get_property(var_template_object, 'plugin')).is_null() {
			mut var_plugins := rt.call_function('wp_get_active_and_valid_plugins', []rt.PhpVal{})
			mut iter_5 := var_plugins.iterator()
			for {
				item_5 := iter_5.next() or { break }
				mut var_plugin_file := item_5.val
				mut var_plugin_basename := rt.call_function('plugin_basename', [
					var_plugin_file.clone(),
				])
				mut list_tmp_1 := rt.call_function('explode', [
					rt.new_string('/'), var_plugin_basename.clone()])
				var_plugin_slug = list_tmp_1.array_get(0)
				if rt.is_true(rt.identical(var_plugin_slug, rt.get_property(var_template_object,
					'plugin')))
				{
					mut var_plugin_data := rt.call_function('get_plugin_data', [
						var_plugin_file.clone(),
					])
					if !(!rt.is_true(var_plugin_data.array_get(rt.new_string('Name')))) {
						return (var_plugin_data.array_get(rt.new_string('Name'))).str()
					}
				}
			}
		}
		var_plugins = rt.call_function('get_plugins', []rt.PhpVal{})
		mut var_plugin_basename := rt.call_function('plugin_basename', [
			rt.call_function('sanitize_text_field', [
				rt.new_string((rt.get_property(var_template_object, 'theme')).str() + '.php'),
			]),
		])
		if var_plugins.array_isset(var_plugin_basename)
			&& var_plugins.array_get(var_plugin_basename).array_isset(rt.new_string('Name')) {
			return (var_plugins.array_get(var_plugin_basename).array_get(rt.new_string('Name'))).str()
		}
		return (if !(rt.get_property(var_template_object, 'plugin')).is_null() {
			rt.get_property(var_template_object, 'plugin')
		} else {
			rt.get_property(var_template_object, 'theme')
		}).str()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('site'))) {
		return (rt.call_function('get_bloginfo', [rt.new_string('name')])).str()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('user'))) {
		mut var_author := rt.call_function('get_user_by', [rt.new_string('id'),
			rt.get_property(var_template_object, 'author')])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_author)))) {
			return (rt.call_function('__', [rt.new_string('Unknown author')])).str()
		}
		return (rt.call_method(var_author, 'get', [rt.new_string('display_name')])).str()
	}
	return ''
}

fn (mut this Class_WP_REST_Templates_Controller) prepare_links(var_id rt.PhpVal) rt.PhpVal {
	mut var_id_mutated := var_id
	mut var_links := rt.create_array([
		rt.ArrayItem{ key: 'self', val: rt.create_array([
			rt.ArrayItem{ key: 'href', val: rt.call_function('rest_url', [
				rt.call_function('sprintf', [rt.new_string('/%s/%s/%s'),
					rt.get_property(rt.new_object('WP_REST_Templates_Controller', [
						'WP_REST_Controller',
					], &this), 'namespace'),
					rt.get_property(rt.new_object('WP_REST_Templates_Controller', [
						'WP_REST_Controller',
					], &this), 'rest_base'),
					var_id_mutated.clone()]),
			]) },
		]) },
		rt.ArrayItem{ key: 'collection', val: rt.create_array([
			rt.ArrayItem{ key: 'href', val: rt.call_function('rest_url', [
				rt.call_function('rest_get_route_for_post_type_items', [this.post_type]),
			]) },
		]) },
		rt.ArrayItem{ key: 'about', val: rt.create_array([
			rt.ArrayItem{ key: 'href', val: rt.call_function('rest_url', [
				rt.new_string('wp/v2/types/' + (this.post_type).str()),
			]) },
		]) },
	])
	if rt.is_true(rt.call_function('post_type_supports',
		[this.post_type, rt.new_string('revisions')]))
	{
		mut var_template := rt.call_function('get_block_template', [
			var_id_mutated.clone(), this.post_type])
		if rt.is_true(rt.new_bool(rt.instance_of(var_template, 'WP_Block_Template')))
			&& !(!rt.is_true(rt.get_property(var_template, 'wp_id'))) {
			mut var_revisions := rt.call_function('wp_get_latest_revision_id_and_total_count', [
				rt.get_property(var_template, 'wp_id'),
			])
			mut var_revisions_count := if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [
				var_revisions.clone(),
			])))))
			{ var_revisions.array_get(rt.new_string('count')) } else { rt.new_int(0) }
			mut var_revisions_base := rt.call_function('sprintf', [
				rt.new_string('/%s/%s/%s/revisions'),
				rt.get_property(rt.new_object('WP_REST_Templates_Controller', [
					'WP_REST_Controller',
				], &this), 'namespace'),
				rt.get_property(rt.new_object('WP_REST_Templates_Controller', [
					'WP_REST_Controller',
				], &this), 'rest_base'),
				var_id_mutated.clone(),
			])
			var_links.array_set('version-history', rt.create_array([
				rt.ArrayItem{ key: 'href', val: rt.call_function('rest_url', [
					var_revisions_base.clone()]) },
				rt.ArrayItem{ key: 'count', val: var_revisions_count },
			]))
			if rt.is_true(rt.greater(var_revisions_count, rt.new_int(0))) {
				var_links.array_set('predecessor-version', rt.create_array([
					rt.ArrayItem{ key: 'href', val: rt.call_function('rest_url', [
						rt.new_string(var_revisions_base.str() + '/' +
							(var_revisions.array_get(rt.new_string('latest_id'))).str()),
					]) },
					rt.ArrayItem{
						key: 'id'
						val: var_revisions.array_get(rt.new_string('latest_id'))
					},
				]))
			}
		}
	}
	return var_links.clone()
}

fn (mut this Class_WP_REST_Templates_Controller) get_available_actions() rt.PhpVal {
	mut var_rels := rt.new_array()
	mut var_post_type := rt.call_function('get_post_type_object', [this.post_type])
	if rt.is_true(rt.call_function('current_user_can', [
		rt.get_property(rt.get_property(var_post_type, 'cap'), 'publish_posts'),
	]))
	{
		var_rels << 'https://api.w.org/action-publish'
	}
	if rt.is_true(rt.call_function('current_user_can', [rt.new_string('unfiltered_html')])) {
		var_rels << 'https://api.w.org/action-unfiltered-html'
	}
	return var_rels.clone()
}

fn (mut this Class_WP_REST_Templates_Controller) get_collection_params() rt.PhpVal {
	return rt.create_array([
		rt.ArrayItem{ key: 'context', val: this.get_context_param(rt.create_array([
			rt.ArrayItem{ key: 'default', val: 'view' },
		])) },
		rt.ArrayItem{ key: 'wp_id', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Limit to the specified post id.'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'integer' },
		]) },
		rt.ArrayItem{ key: 'area', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Limit to the specified template part area.'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'string' },
		]) },
		rt.ArrayItem{ key: 'post_type', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Post type to get the templates for.'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'string' },
		]) },
	])
}

fn (mut this Class_WP_REST_Templates_Controller) get_item_schema() rt.PhpVal {
	if rt.is_true(rt.get_property(rt.new_object('WP_REST_Templates_Controller', [
		'WP_REST_Controller',
	], &this), 'schema'))
	{
		return this.add_additional_fields_schema(rt.get_property(rt.new_object('WP_REST_Templates_Controller', [
			'WP_REST_Controller',
		], &this), 'schema'))
	}
	mut var_schema := {
		'$schema':    rt.new_string('http://json-schema.org/draft-04/schema#')
		'title':      this.post_type
		'type':       rt.new_string('object')
		'properties': {
			'id':              {
				'description': rt.call_function('__', [rt.new_string('ID of template.')])
				'type':        rt.new_string('string')
				'context':     map[string]rt.PhpVal{}
				'readonly':    rt.new_bool(true)
			}
			'slug':            {
				'description': rt.call_function('__', [
					rt.new_string('Unique slug identifying the template.'),
				])
				'type':        rt.new_string('string')
				'context':     map[string]rt.PhpVal{}
				'required':    rt.new_bool(true)
				'minLength':   rt.new_int(1)
				'pattern':     rt.new_string('[a-zA-Z0-9_\\%-]+')
			}
			'theme':           {
				'description': rt.call_function('__', [
					rt.new_string('Theme identifier for the template.'),
				])
				'type':        rt.new_string('string')
				'context':     map[string]rt.PhpVal{}
			}
			'type':            {
				'description': rt.call_function('__', [
					rt.new_string('Type of template.'),
				])
				'type':        rt.new_string('string')
				'context':     map[string]rt.PhpVal{}
			}
			'source':          {
				'description': rt.call_function('__', [
					rt.new_string('Source of template'),
				])
				'type':        rt.new_string('string')
				'context':     map[string]rt.PhpVal{}
				'readonly':    rt.new_bool(true)
			}
			'origin':          {
				'description': rt.call_function('__', [
					rt.new_string('Source of a customized template'),
				])
				'type':        rt.new_string('string')
				'context':     map[string]rt.PhpVal{}
				'readonly':    rt.new_bool(true)
			}
			'content':         {
				'description': rt.call_function('__', [
					rt.new_string('Content of template.'),
				])
				'type':        map[string]rt.PhpVal{}
				'default':     rt.new_string('')
				'context':     map[string]rt.PhpVal{}
				'properties':  {
					'raw':           {
						'description': rt.call_function('__', [
							rt.new_string('Content for the template, as it exists in the database.'),
						])
						'type':        rt.new_string('string')
						'context':     map[string]rt.PhpVal{}
					}
					'block_version': {
						'description': rt.call_function('__', [
							rt.new_string('Version of the content block format used by the template.'),
						])
						'type':        rt.new_string('integer')
						'context':     map[string]rt.PhpVal{}
						'readonly':    rt.new_bool(true)
					}
				}
			}
			'title':           {
				'description': rt.call_function('__', [
					rt.new_string('Title of template.'),
				])
				'type':        map[string]rt.PhpVal{}
				'default':     rt.new_string('')
				'context':     map[string]rt.PhpVal{}
				'properties':  {
					'raw':      {
						'description': rt.call_function('__', [
							rt.new_string('Title for the template, as it exists in the database.'),
						])
						'type':        rt.new_string('string')
						'context':     map[string]rt.PhpVal{}
					}
					'rendered': {
						'description': rt.call_function('__', [
							rt.new_string('HTML title for the template, transformed for display.'),
						])
						'type':        rt.new_string('string')
						'context':     map[string]rt.PhpVal{}
						'readonly':    rt.new_bool(true)
					}
				}
			}
			'description':     {
				'description': rt.call_function('__', [
					rt.new_string('Description of template.'),
				])
				'type':        rt.new_string('string')
				'default':     rt.new_string('')
				'context':     map[string]rt.PhpVal{}
			}
			'status':          {
				'description': rt.call_function('__', [
					rt.new_string('Status of template.'),
				])
				'type':        rt.new_string('string')
				'enum':        rt.func_array_keys(rt.call_function('get_post_stati', [
					{
						'internal': rt.new_bool(false)
					},
				]))
				'default':     rt.new_string('publish')
				'context':     map[string]rt.PhpVal{}
			}
			'wp_id':           {
				'description': rt.call_function('__', [rt.new_string('Post ID.')])
				'type':        rt.new_string('integer')
				'context':     map[string]rt.PhpVal{}
				'readonly':    rt.new_bool(true)
			}
			'has_theme_file':  {
				'description': rt.call_function('__', [
					rt.new_string('Theme file exists.'),
				])
				'type':        rt.new_string('bool')
				'context':     map[string]rt.PhpVal{}
				'readonly':    rt.new_bool(true)
			}
			'author':          {
				'description': rt.call_function('__', [
					rt.new_string('The ID for the author of the template.'),
				])
				'type':        rt.new_string('integer')
				'context':     map[string]rt.PhpVal{}
			}
			'modified':        {
				'description': rt.call_function('__', [
					rt.new_string("The date the template was last modified, in the site's timezone."),
				])
				'type':        rt.new_string('string')
				'format':      rt.new_string('date-time')
				'context':     map[string]rt.PhpVal{}
				'readonly':    rt.new_bool(true)
			}
			'author_text':     {
				'type':        rt.new_string('string')
				'description': rt.call_function('__', [
					rt.new_string('Human readable text for the author.'),
				])
				'readonly':    rt.new_bool(true)
				'context':     map[string]rt.PhpVal{}
			}
			'original_source': {
				'description': rt.call_function('__', [
					rt.new_string("Where the template originally comes from e.g. 'theme'"),
				])
				'type':        rt.new_string('string')
				'readonly':    rt.new_bool(true)
				'context':     map[string]rt.PhpVal{}
				'enum':        map[string]rt.PhpVal{}
			}
		}
	}
	if rt.is_true(rt.identical(rt.new_string('wp_template'), this.post_type)) {
		var_schema.array_get_mut('properties').array_set('is_custom', rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Whether a template is a custom template.'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'bool' },
			rt.ArrayItem{ key: 'context', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'embed' },
				rt.ArrayItem{ key: none, val: 'view' },
				rt.ArrayItem{ key: none, val: 'edit' },
			]) },
			rt.ArrayItem{ key: 'readonly', val: true },
		]))
		var_schema.array_get_mut('properties').array_set('plugin', rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'string' },
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Plugin that registered the template.'),
			]) },
			rt.ArrayItem{ key: 'readonly', val: true },
			rt.ArrayItem{ key: 'context', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'view' },
				rt.ArrayItem{ key: none, val: 'edit' },
				rt.ArrayItem{ key: none, val: 'embed' },
			]) },
		]))
	}
	if rt.is_true(rt.identical(rt.new_string('wp_template_part'), this.post_type)) {
		var_schema.array_get_mut('properties').array_set('area', rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Where the template part is intended for use (header, footer, etc.)'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'string' },
			rt.ArrayItem{ key: 'context', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'embed' },
				rt.ArrayItem{ key: none, val: 'view' },
				rt.ArrayItem{ key: none, val: 'edit' },
			]) },
		]))
	}
	this.dispatch_set_prop('schema', var_schema.clone())
	return this.add_additional_fields_schema(rt.get_property(rt.new_object('WP_REST_Templates_Controller', [
		'WP_REST_Controller',
	], &this), 'schema'))
}

struct Class_WP_REST_Controller {
	rt.PhpObjectBase
}

struct Class_stdClass {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

struct Class_WP_REST_Response {
	rt.PhpObjectBase
}

struct Class_WP_Block_Templates_Registry {
	rt.PhpObjectBase
}

fn create_wp_rest_templates_controller(arg_0 rt.PhpVal) &Class_WP_REST_Templates_Controller {
	mut obj := &Class_WP_REST_Templates_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
		post_type:     rt.new_null()
	}
	obj.construct(arg_0)
	return obj
}

fn create_wp_rest_controller(_args ...rt.PhpVal) &Class_WP_REST_Controller {
	mut obj := &Class_WP_REST_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_stdclass(_args ...rt.PhpVal) &Class_stdClass {
	mut obj := &Class_stdClass{
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

fn create_wp_block_templates_registry(_args ...rt.PhpVal) &Class_WP_Block_Templates_Registry {
	mut obj := &Class_WP_Block_Templates_Registry{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_REST_Templates_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'register_routes' {
			this.register_routes()
			return rt.new_null()
		}
		'get_template_fallback' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_template_fallback(dispatch_arg_0)
		}
		'permissions_check' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.permissions_check(dispatch_arg_0))
		}
		'_sanitize_template_id' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this._sanitize_template_id(dispatch_arg_0))
		}
		'get_items_permissions_check' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.get_items_permissions_check(dispatch_arg_0))
		}
		'get_items' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_items(dispatch_arg_0)
		}
		'get_item_permissions_check' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.get_item_permissions_check(dispatch_arg_0))
		}
		'get_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_item(dispatch_arg_0)
		}
		'update_item_permissions_check' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.update_item_permissions_check(dispatch_arg_0)
		}
		'update_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.update_item(dispatch_arg_0)
		}
		'create_item_permissions_check' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.create_item_permissions_check(dispatch_arg_0)
		}
		'create_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.create_item(dispatch_arg_0)
		}
		'delete_item_permissions_check' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.delete_item_permissions_check(dispatch_arg_0)
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
		'get_wp_templates_original_source_field' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(Class_WP_REST_Templates_Controller.get_wp_templates_original_source_field(dispatch_arg_0))
		}
		'get_wp_templates_author_text_field' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(Class_WP_REST_Templates_Controller.get_wp_templates_author_text_field(dispatch_arg_0))
		}
		'prepare_links' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.prepare_links(dispatch_arg_0)
		}
		'get_available_actions' {
			return this.get_available_actions()
		}
		'get_collection_params' {
			return this.get_collection_params()
		}
		'get_item_schema' {
			return this.get_item_schema()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WP_REST_Templates_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'post_type' { return this.post_type }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_REST_Templates_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'post_type' {
			this.post_type = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_WP_REST_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_REST_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_REST_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_stdClass) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_stdClass) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_stdClass) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_WP_Block_Templates_Registry) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Block_Templates_Registry) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Block_Templates_Registry) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
