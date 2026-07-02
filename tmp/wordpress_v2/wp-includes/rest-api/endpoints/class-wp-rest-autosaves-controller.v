import rt

struct Class_WP_REST_Autosaves_Controller {
	rt.PhpObjectBase
pub mut:
	parent_post_type     rt.PhpVal = rt.new_null()
	parent_controller    rt.PhpVal = rt.new_null()
	revisions_controller rt.PhpVal = rt.new_null()
	parent_base          rt.PhpVal = rt.new_null()
}

fn (mut this Class_WP_REST_Autosaves_Controller) construct(var_parent_post_type rt.PhpVal) {
	this.parent_post_type = var_parent_post_type.clone()
	mut var_post_type_object := rt.call_function('get_post_type_object', [
		var_parent_post_type.clone()])
	mut var_parent_controller := rt.call_method(var_post_type_object, 'get_rest_controller',
		[]rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(rt.is_true(var_parent_controller)))) {
		var_parent_controller = create_wp_rest_posts_controller(var_parent_post_type.clone())
	}
	this.parent_controller = var_parent_controller.clone()
	mut var_revisions_controller := rt.call_method(var_post_type_object,
		'get_revisions_rest_controller', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(rt.is_true(var_revisions_controller)))) {
		var_revisions_controller = create_wp_rest_revisions_controller(var_parent_post_type.clone())
	}
	this.revisions_controller = var_revisions_controller.clone()
	this.dispatch_set_prop('rest_base', rt.new_string('autosaves'))
	this.parent_base = if !(!rt.is_true(rt.get_property(var_post_type_object, 'rest_base'))) {
		rt.get_property(var_post_type_object, 'rest_base')
	} else {
		rt.get_property(var_post_type_object, 'name')
	}
	this.dispatch_set_prop('namespace', if !(!rt.is_true(rt.get_property(var_post_type_object,
		'rest_namespace'))) {
		rt.get_property(var_post_type_object, 'rest_namespace')
	} else {
		rt.new_string('wp/v2')
	})
}

fn (mut this Class_WP_REST_Autosaves_Controller) register_routes() {
	rt.call_function('register_rest_route', [
		rt.get_property(rt.new_object('WP_REST_Autosaves_Controller', [
			'WP_REST_Revisions_Controller',
		], &this), 'namespace'),
		rt.new_string('/' +(this.parent_base).str() + '/(?P<id>[\\d]+)/' +
			rt.get_property(rt.new_object('WP_REST_Autosaves_Controller', ['WP_REST_Revisions_Controller'], &this), 'rest_base')),
		rt.create_array([
			rt.ArrayItem{ key: 'args', val: rt.create_array([
				rt.ArrayItem{ key: 'parent', val: rt.create_array([
					rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
						rt.new_string('The ID for the parent of the autosave.'),
					]) },
					rt.ArrayItem{ key: 'type', val: 'integer' },
				]) },
			]) },
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() },
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Autosaves_Controller', [
						'WP_REST_Revisions_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'get_items' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Autosaves_Controller', [
						'WP_REST_Revisions_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'get_items_permissions_check' },
				]) },
				rt.ArrayItem{ key: 'args', val: this.get_collection_params() },
			]) },
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.creatable() },
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Autosaves_Controller', [
						'WP_REST_Revisions_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'create_item' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Autosaves_Controller', [
						'WP_REST_Revisions_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'create_item_permissions_check' },
				]) },
				rt.ArrayItem{ key: 'args', val: rt.call_method(this.parent_controller,
					'get_endpoint_args_for_item_schema', [
					Class_WP_REST_Server.editable(),
				]) },
			]) },
			rt.ArrayItem{ key: 'schema', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Autosaves_Controller', [
					'WP_REST_Revisions_Controller',
				], &this) },
				rt.ArrayItem{ key: none, val: 'get_public_item_schema' },
			]) },
		]),
	])
	rt.call_function('register_rest_route', [
		rt.get_property(rt.new_object('WP_REST_Autosaves_Controller', [
			'WP_REST_Revisions_Controller',
		], &this), 'namespace'),
		rt.new_string('/' +
			(this.parent_base).str() + '/(?P<parent>[\\d]+)/' + rt.get_property(rt.new_object('WP_REST_Autosaves_Controller', ['WP_REST_Revisions_Controller'], &this), 'rest_base') +
			'/(?P<id>[\\d]+)'),
		rt.create_array([
			rt.ArrayItem{ key: 'args', val: rt.create_array([
				rt.ArrayItem{ key: 'parent', val: rt.create_array([
					rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
						rt.new_string('The ID for the parent of the autosave.'),
					]) },
					rt.ArrayItem{ key: 'type', val: 'integer' },
				]) },
				rt.ArrayItem{ key: 'id', val: rt.create_array([
					rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
						rt.new_string('The ID for the autosave.'),
					]) },
					rt.ArrayItem{ key: 'type', val: 'integer' },
				]) },
			]) },
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() },
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Autosaves_Controller', [
						'WP_REST_Revisions_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'get_item' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: this.revisions_controller },
					rt.ArrayItem{ key: none, val: 'get_item_permissions_check' },
				]) },
				rt.ArrayItem{ key: 'args', val: rt.create_array([
					rt.ArrayItem{ key: 'context', val: this.get_context_param(rt.create_array([
						rt.ArrayItem{ key: 'default', val: 'view' },
					])) },
				]) },
			]) },
			rt.ArrayItem{ key: 'schema', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Autosaves_Controller', [
					'WP_REST_Revisions_Controller',
				], &this) },
				rt.ArrayItem{ key: none, val: 'get_public_item_schema' },
			]) },
		]),
	])
}

fn (mut this Class_WP_REST_Autosaves_Controller) get_parent(var_parent_id rt.PhpVal) rt.PhpVal {
	mut var_parent_id_mutated := var_parent_id
	return rt.call_method(this.revisions_controller, 'get_parent', [
		var_parent_id_mutated.clone()])
}

fn (mut this Class_WP_REST_Autosaves_Controller) get_items_permissions_check(var_request rt.PhpVal) bool {
	mut var_parent := this.get_parent(var_request.array_get(rt.new_string('id')))
	if rt.is_true(rt.call_function('is_wp_error', [var_parent.clone()])) {
		return var_parent.to_bool()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('edit_post'),
		rt.get_property(var_parent, 'ID'),
	])))))
	{
		return (create_wp_error(rt.new_string('rest_cannot_read'), rt.call_function('__', [
			rt.new_string('Sorry, you are not allowed to view autosaves of this post.'),
		]), rt.create_array([
			rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code',
				[]rt.PhpVal{}) },
		]))).to_bool()
	}
	return true
}

fn (mut this Class_WP_REST_Autosaves_Controller) create_item_permissions_check(var_request rt.PhpVal) rt.PhpVal {
	mut var_id := rt.call_method(var_request, 'get_param', [rt.new_string('id')])
	if !rt.is_true(var_id) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('rest_post_invalid_id'), rt.call_function('__', [
			rt.new_string('Invalid item ID.'),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 404 }])))
	}
	return rt.call_method(this.parent_controller, 'update_item_permissions_check', [
		var_request.clone(),
	])
}

fn (mut this Class_WP_REST_Autosaves_Controller) create_item(var_request rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('WP_RUN_CORE_TESTS')])))))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('DOING_AUTOSAVE')]))))) {
		rt.call_function('define', [rt.new_string('DOING_AUTOSAVE'),
			rt.new_bool(true)])
	}
	mut var_post := this.get_parent(var_request.array_get(rt.new_string('id')))
	if rt.is_true(rt.call_function('is_wp_error', [var_post.clone()])) {
		return var_post.clone()
	}
	mut var_prepared_post := rt.call_method(this.parent_controller, 'prepare_item_for_database', [
		var_request.clone(),
	])
	rt.set_property(var_prepared_post, 'ID', rt.get_property(var_post, 'ID'))
	mut var_user_id := rt.call_function('get_current_user_id', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('wp_check_post_lock'),
	])))))
	{
		rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/post.php', '4')
	}
	mut var_post_lock_is_active := rt.call_function('wp_check_post_lock', [
		rt.get_property(var_post, 'ID'),
	])
	mut var_is_draft := rt.new_bool(
		rt.is_true(rt.identical(rt.new_string('draft'), rt.get_property(var_post, 'post_status')))
		|| rt.is_true(rt.identical(rt.new_string('auto-draft'), rt.get_property(var_post, 'post_status'))))
	mut var_can_update_author_draft_post := rt.new_bool(rt.is_true(var_is_draft)
		&& rt.is_true(rt.identical(rt.new_int((rt.get_property(var_post, 'post_author')).to_i64()), var_user_id)))
	mut var_should_update_parent_draft_post := rt.new_bool(
		rt.is_true(rt.new_bool(!(rt.is_true(var_post_lock_is_active))))
		&& rt.is_true(var_can_update_author_draft_post))
	if rt.is_true(var_should_update_parent_draft_post) {
		mut var_autosave_id := rt.call_function('wp_update_post', [
			rt.call_function('wp_slash', [rt.cast_array(var_prepared_post)]),
			rt.new_bool(true),
		])
	} else {
		var_autosave_id = this.create_post_autosave(rt.cast_array(var_prepared_post), mut rt.cast_object_ptr[Class_array](rt.cast_array(rt.call_method(var_request,
			'get_param', [rt.new_string('meta')]))))
	}
	if rt.is_true(rt.call_function('is_wp_error', [var_autosave_id.clone()])) {
		return var_autosave_id.clone()
	}
	mut var_autosave := rt.call_function('get_post', [var_autosave_id.clone()])
	rt.call_method(var_request, 'set_param', [rt.new_string('context'),
		rt.new_string('edit')])
	mut var_response := this.prepare_item_for_response(var_autosave.clone(), var_request.clone())
	var_response = rt.call_function('rest_ensure_response', [
		var_response.clone()])
	return var_response.clone()
}

fn (mut this Class_WP_REST_Autosaves_Controller) get_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_parent_id := rt.new_int((rt.call_method(var_request, 'get_param', [
		rt.new_string('parent'),
	])).to_i64())
	if rt.is_true(rt.less_equal(var_parent_id, rt.new_int(0))) {
		return create_wp_error(rt.new_string('rest_post_invalid_id'), rt.call_function('__', [
			rt.new_string('Invalid post parent ID.'),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 404 }]))
	}
	mut var_autosave := rt.call_function('wp_get_post_autosave', [
		var_parent_id.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_autosave)))) {
		return create_wp_error(rt.new_string('rest_post_no_autosave'), rt.call_function('__', [
			rt.new_string('There is no autosave revision for this post.'),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 404 }]))
	}
	mut var_response := this.prepare_item_for_response(var_autosave.clone(), var_request.clone())
	return var_response.clone()
}

fn (mut this Class_WP_REST_Autosaves_Controller) get_items(var_request rt.PhpVal) rt.PhpVal {
	mut var_parent := this.get_parent(var_request.array_get(rt.new_string('id')))
	if rt.is_true(rt.call_function('is_wp_error', [var_parent.clone()])) {
		return var_parent.clone()
	}
	if rt.is_true(rt.call_method(var_request, 'is_method', [rt.new_string('HEAD')])) {
		return rt.new_object('WP_REST_Response', []string{},
			create_wp_rest_response(rt.new_array()))
	}
	mut var_response := rt.new_array()
	mut var_parent_id := rt.get_property(var_parent, 'ID')
	mut var_revisions := rt.call_function('wp_get_post_revisions', [
		var_parent_id.clone(), rt.create_array([
			rt.ArrayItem{ key: 'check_enabled', val: false },
		])])
	mut iter_1 := var_revisions.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_revision := item_1.val
		if rt.is_true(rt.call_function('str_contains', [
			rt.get_property(var_revision, 'post_name'),
			rt.new_string('${var_parent_id.to_string()}-autosave'),
		]))
		{
			mut var_data := this.prepare_item_for_response(var_revision.clone(),
				var_request.clone())
			var_response.array_push(this.prepare_response_for_collection(var_data.clone()))
		}
	}
	return rt.call_function('rest_ensure_response', [var_response.clone()])
}

fn (mut this Class_WP_REST_Autosaves_Controller) get_item_schema() rt.PhpVal {
	if rt.is_true(rt.get_property(rt.new_object('WP_REST_Autosaves_Controller', [
		'WP_REST_Revisions_Controller',
	], &this), 'schema'))
	{
		return this.add_additional_fields_schema(rt.get_property(rt.new_object('WP_REST_Autosaves_Controller', [
			'WP_REST_Revisions_Controller',
		], &this), 'schema'))
	}
	mut var_schema := rt.call_method(this.revisions_controller, 'get_item_schema', []rt.PhpVal{})
	var_schema.array_get_mut('properties').array_set('preview_link', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Preview link for the post.'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'string' },
		rt.ArrayItem{ key: 'format', val: 'uri' },
		rt.ArrayItem{ key: 'context', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'edit' },
		]) },
		rt.ArrayItem{ key: 'readonly', val: true },
	]))
	this.dispatch_set_prop('schema', var_schema.clone())
	return this.add_additional_fields_schema(rt.get_property(rt.new_object('WP_REST_Autosaves_Controller', [
		'WP_REST_Revisions_Controller',
	], &this), 'schema'))
}

fn (mut this Class_WP_REST_Autosaves_Controller) create_post_autosave(var_post_data rt.PhpVal, mut var_meta Class_array) rt.PhpVal {
	mut var_post_id := rt.new_int((var_post_data.array_get(rt.new_string('ID'))).to_i64())
	mut var_post := rt.call_function('get_post', [var_post_id.clone()])
	if rt.is_true(rt.call_function('is_wp_error', [var_post.clone()])) {
		return var_post.clone()
	}
	mut var_autosave_is_different := rt.new_bool(false)
	mut var_new_autosave := rt.call_function('_wp_post_revision_data', [
		var_post_data.clone(), rt.new_bool(true)])
	mut iter_2 := rt.call_function('array_intersect', [
		rt.func_array_keys(var_new_autosave.clone()),
		rt.func_array_keys(rt.call_function('_wp_post_revision_fields', [
			var_post.clone()])),
	]).iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_field := item_2.val
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('normalize_whitespace', [
			var_new_autosave.array_get(var_field),
		]), rt.call_function('normalize_whitespace', [
			rt.get_property(var_post, '{"nodeType":"Expr_Variable","line":392,"name":"field"}'),
		])))))
		{
			var_autosave_is_different = rt.new_bool(true)
			break
		}
	}
	if !(!rt.is_true(var_meta)) {
		mut var_revisioned_meta_keys := rt.call_function('wp_post_revision_meta_keys', [
			rt.get_property(var_post, 'post_type'),
		])
		mut iter_3 := var_revisioned_meta_keys.iterator()
		for {
			item_3 := iter_3.next() or { break }
			mut var_meta_key := item_3.val
			mut var_old_meta := rt.call_function('get_metadata_raw', [
				rt.new_string('post'),
				var_post_id.clone(),
				var_meta_key.clone(),
				rt.new_bool(true),
			])
			mut var_new_meta := if !(var_meta.array_get(var_meta_key)).is_null() {
				var_meta.array_get(var_meta_key)
			} else {
				rt.new_string('')
			}
			if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_new_meta, var_old_meta)))) {
				var_autosave_is_different = rt.new_bool(true)
				break
			}
		}
	}
	mut var_user_id := rt.call_function('get_current_user_id', []rt.PhpVal{})
	mut var_old_autosave := rt.call_function('wp_get_post_autosave', [
		var_post_id.clone(), var_user_id.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_autosave_is_different))))
		&& rt.is_true(var_old_autosave) {
		return rt.get_property(var_old_autosave, 'ID')
	}
	if rt.is_true(var_old_autosave) {
		var_new_autosave.array_set('ID', rt.get_property(var_old_autosave, 'ID'))
		var_new_autosave.array_set('post_author', var_user_id.clone())
		rt.call_function('do_action', [rt.new_string('wp_creating_autosave'),
			var_new_autosave.clone()])
		mut var_revision_id := rt.call_function('wp_update_post', [
			rt.call_function('wp_slash', [var_new_autosave.clone()]),
		])
	} else {
		var_revision_id = rt.call_function('_wp_put_post_revision', [
			var_post_data.clone(), rt.new_bool(true)])
	}
	if rt.is_true(rt.call_function('is_wp_error', [var_revision_id.clone()]))
		|| rt.is_true(rt.identical(rt.new_int(0), var_revision_id)) {
		return var_revision_id.clone()
	}
	if !(!rt.is_true(var_meta)) {
		mut iter_4 := var_revisioned_meta_keys.iterator()
		for {
			item_4 := iter_4.next() or { break }
			mut var_meta_key := item_4.val
			if var_meta.array_isset(var_meta_key) {
				rt.call_function('update_metadata', [rt.new_string('post'),
					var_revision_id.clone(), var_meta_key.clone(),
					rt.call_function('wp_slash', [var_meta.array_get(var_meta_key)])])
			}
		}
	}
	return var_revision_id.clone()
}

fn (mut this Class_WP_REST_Autosaves_Controller) prepare_item_for_response(var_item rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
	mut var_post := var_item
	if rt.is_true(rt.call_method(var_request, 'is_method', [rt.new_string('HEAD')])) {
		return rt.call_function('apply_filters', [rt.new_string('rest_prepare_autosave'),
			create_wp_rest_response(rt.new_array()), var_post.clone(),
			var_request.clone()])
	}
	mut var_response := rt.call_method(this.revisions_controller, 'prepare_item_for_response', [
		var_post.clone(),
		var_request.clone(),
	])
	mut var_fields := this.get_fields_for_response(var_request.clone())
	if rt.is_true(rt.call_function('in_array', [rt.new_string('preview_link'),
		var_fields.clone(), rt.new_bool(true)]))
	{
		mut var_parent_id := rt.call_function('wp_is_post_autosave', [
			var_post.clone()])
		mut var_preview_post_id := if rt.is_true(rt.identical(rt.new_bool(false), var_parent_id)) {
			rt.get_property(var_post, 'ID')
		} else {
			var_parent_id
		}
		mut var_preview_query_args := rt.new_array()
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_parent_id)))) {
			var_preview_query_args['preview_id'] = var_parent_id.clone()
			var_preview_query_args['preview_nonce'] = rt.call_function('wp_create_nonce', [
				rt.new_string('post_preview_' + var_parent_id.str()),
			])
		}
		rt.get_property(var_response, 'data').array_set('preview_link', rt.call_function('get_preview_post_link', [
			var_preview_post_id.clone(),
			rt.create_array_from_native_map(var_preview_query_args),
		]))
	}
	mut var_context := if !(!rt.is_true(var_request.array_get(rt.new_string('context')))) {
		var_request.array_get(rt.new_string('context'))
	} else {
		rt.new_string('view')
	}
	rt.set_property(var_response, 'data', this.add_additional_fields_to_object(rt.get_property(var_response,
		'data'), var_request.clone()))
	rt.set_property(var_response, 'data', this.filter_response_by_context(rt.get_property(var_response,
		'data'), var_context.clone()))
	return rt.call_function('apply_filters', [rt.new_string('rest_prepare_autosave'),
		var_response.clone(), var_post.clone(), var_request.clone()])
}

fn (mut this Class_WP_REST_Autosaves_Controller) get_collection_params() rt.PhpVal {
	return rt.create_array([
		rt.ArrayItem{ key: 'context', val: this.get_context_param(rt.create_array([
			rt.ArrayItem{ key: 'default', val: 'view' },
		])) },
	])
}

struct Class_WP_REST_Revisions_Controller {
	rt.PhpObjectBase
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

fn create_wp_rest_autosaves_controller(arg_0 rt.PhpVal) &Class_WP_REST_Autosaves_Controller {
	mut obj := &Class_WP_REST_Autosaves_Controller{
		PhpObjectBase:        rt.PhpObjectBase{}
		parent_post_type:     rt.new_null()
		parent_controller:    rt.new_null()
		revisions_controller: rt.new_null()
		parent_base:          rt.new_null()
	}
	obj.construct(arg_0)
	return obj
}

fn create_wp_rest_revisions_controller(_args ...rt.PhpVal) &Class_WP_REST_Revisions_Controller {
	mut obj := &Class_WP_REST_Revisions_Controller{
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

fn (mut this Class_WP_REST_Autosaves_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
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
		'get_parent' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_parent(dispatch_arg_0)
		}
		'get_items_permissions_check' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.get_items_permissions_check(dispatch_arg_0))
		}
		'create_item_permissions_check' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.create_item_permissions_check(dispatch_arg_0)
		}
		'create_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.create_item(dispatch_arg_0)
		}
		'get_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_item(dispatch_arg_0)
		}
		'get_items' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_items(dispatch_arg_0)
		}
		'get_item_schema' {
			return this.get_item_schema()
		}
		'create_post_autosave' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_array](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			return this.create_post_autosave(dispatch_arg_0, mut dispatch_arg_1)
		}
		'prepare_item_for_response' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.prepare_item_for_response(dispatch_arg_0, dispatch_arg_1)
		}
		'get_collection_params' {
			return this.get_collection_params()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WP_REST_Autosaves_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'parent_post_type' { return this.parent_post_type }
		'parent_controller' { return this.parent_controller }
		'revisions_controller' { return this.revisions_controller }
		'parent_base' { return this.parent_base }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_REST_Autosaves_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'parent_post_type' {
			this.parent_post_type = val
			return true
		}
		'parent_controller' {
			this.parent_controller = val
			return true
		}
		'revisions_controller' {
			this.revisions_controller = val
			return true
		}
		'parent_base' {
			this.parent_base = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_WP_REST_Revisions_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_REST_Revisions_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_REST_Revisions_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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
