import rt

struct Class_WP_REST_Templates_Controller {
	rt.PhpObjectBase
pub mut:
		post_type rt.PhpVal = rt.new_null()
}

fn (mut this Class_WP_REST_Templates_Controller) construct(var_post_type rt.PhpVal)  {
	mut var_post_type_mutated := var_post_type
	this.post_type = var_post_type_mutated.dup()
	mut var_obj := rt.call_function('get_post_type_object', [var_post_type_mutated.dup()])
	this.dispatch_set_prop('rest_base', if !(!rt.is_true(rt.get_property(var_obj, 'rest_base'))) { rt.get_property(var_obj, 'rest_base') } else { rt.get_property(var_obj, 'name') })
	this.dispatch_set_prop('namespace', if !(!rt.is_true(rt.get_property(var_obj, 'rest_namespace'))) { rt.get_property(var_obj, 'rest_namespace') } else { rt.new_string('wp/v2') })
}

fn (mut this Class_WP_REST_Templates_Controller) register_routes()  {
	rt.call_function('register_rest_route', [rt.get_property(rt.new_object('WP_REST_Templates_Controller', ['WP_REST_Controller'], &this), 'namespace'), '/' + (rt.get_property(rt.new_object('WP_REST_Templates_Controller', ['WP_REST_Controller'], &this), 'rest_base')).str(), rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Templates_Controller', ['WP_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_items' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Templates_Controller', ['WP_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_items_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: this.get_collection_params() }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.creatable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Templates_Controller', ['WP_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'create_item' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Templates_Controller', ['WP_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'create_item_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: this.get_endpoint_args_for_item_schema(Class_WP_REST_Server.creatable()) }]) }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Templates_Controller', ['WP_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_public_item_schema' }]) }])])
	rt.call_function('register_rest_route', [rt.get_property(rt.new_object('WP_REST_Templates_Controller', ['WP_REST_Controller'], &this), 'namespace'), '/' + (rt.get_property(rt.new_object('WP_REST_Templates_Controller', ['WP_REST_Controller'], &this), 'rest_base')).str() + '/lookup', rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Templates_Controller', ['WP_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_template_fallback' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Templates_Controller', ['WP_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_item_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'slug', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('The slug of the template to get the fallback for')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'required', val: true }]) }, rt.ArrayItem{ key: 'is_custom', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Indicates if a template is custom or part of the template hierarchy')]) }, rt.ArrayItem{ key: 'type', val: 'boolean' }]) }, rt.ArrayItem{ key: 'template_prefix', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('The template prefix for the created template. This is used to extract the main template type, e.g. in `taxonomy-books` extracts the `taxonomy`')]) }, rt.ArrayItem{ key: 'type', val: 'string' }]) }]) }]) }])])
	rt.call_function('register_rest_route', [rt.get_property(rt.new_object('WP_REST_Templates_Controller', ['WP_REST_Controller'], &this), 'namespace'), rt.call_function('sprintf', [rt.new_string('/%s/(?P<id>%s%s)'), rt.get_property(rt.new_object('WP_REST_Templates_Controller', ['WP_REST_Controller'], &this), 'rest_base'), rt.new_string('([^\\/:<>\\*\\?"\\|]+(?:\\/[^\\/:<>\\*\\?"\\|]+)?)'), rt.new_string('[\\/\\w%-]+')]), rt.create_array([rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('The id of a template')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'sanitize_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Templates_Controller', ['WP_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: '_sanitize_template_id' }]) }]) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Templates_Controller', ['WP_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_item' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Templates_Controller', ['WP_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_item_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'context', val: this.get_context_param(rt.create_array([rt.ArrayItem{ key: 'default', val: 'view' }])) }]) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.editable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Templates_Controller', ['WP_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'update_item' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Templates_Controller', ['WP_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'update_item_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: this.get_endpoint_args_for_item_schema(Class_WP_REST_Server.editable()) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.deletable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Templates_Controller', ['WP_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'delete_item' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Templates_Controller', ['WP_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'delete_item_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'force', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'boolean' }, rt.ArrayItem{ key: 'default', val: false }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Whether to bypass Trash and force deletion.')]) }]) }]) }]) }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Templates_Controller', ['WP_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_public_item_schema' }]) }])])
}

fn (mut this Class_WP_REST_Templates_Controller) get_template_fallback(var_request rt.PhpVal) rt.PhpVal {
	mut var_hierarchy := rt.call_function('get_template_hierarchy', [var_request.array_get('slug'), var_request.array_get('is_custom'), var_request.array_get('template_prefix')])
	for {
		mut var_fallback_template := rt.call_function('resolve_block_template', [var_request.array_get('slug'), var_hierarchy.dup(), rt.new_string('')])
		rt.call_function('array_shift', [var_hierarchy.dup()])
		if !(!(!rt.is_true(var_hierarchy)) && !rt.is_true(rt.get_property(var_fallback_template, 'content'))) {
			break
		}
	}
	mut var_response := if rt.is_true(var_fallback_template) { this.prepare_item_for_response(var_fallback_template.dup(), var_request.dup()) } else { create_stdclass() }
	return rt.call_function('rest_ensure_response', [var_response.dup()])
}

fn (mut this Class_WP_REST_Templates_Controller) permissions_check(var_request rt.PhpVal) bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_theme_options')]))))) {
		return (create_wp_error(rt.new_string('rest_cannot_manage_templates'), rt.call_function('__', [rt.new_string('Sorry, you are not allowed to access the templates on this site.')]), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code', []rt.PhpVal{}) }]))).to_bool()
	}
	return true
}

fn (mut this Class_WP_REST_Templates_Controller) _sanitize_template_id(var_id rt.PhpVal) string {
	mut var_id_mutated := var_id
	var_id_mutated = rt.call_function('urldecode', [var_id_mutated.dup()])
	mut var_last_slash_pos := rt.call_function('strrpos', [var_id_mutated.dup(), rt.new_string('/')])
	if rt.is_true(rt.identical(rt.new_bool(false), var_last_slash_pos)) {
		return (var_id_mutated).str()
	}
	mut var_is_double_slashed := rt.identical(rt.call_function('substr', [var_id_mutated.dup(), rt.sub(var_last_slash_pos, rt.new_int(1)), rt.new_int(1)]), rt.new_string('/'))
	if rt.is_true(var_is_double_slashed) {
		return (var_id_mutated).str()
	}
	return (rt.call_function('substr', [var_id_mutated.dup(), rt.new_int(0), var_last_slash_pos.dup()])).str() + '/' + (rt.call_function('substr', [var_id_mutated.dup(), var_last_slash_pos.dup()])).str()
}

fn (mut this Class_WP_REST_Templates_Controller) get_items_permissions_check(var_request rt.PhpVal) bool {
	if rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_posts')])) {
		return true
	}
	{
		mut iter_1 := rt.call_function('get_post_types', [rt.create_array([rt.ArrayItem{ key: 'show_in_rest', val: true }]), rt.new_string('objects')]).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_post_type := item_1.val
			if rt.is_true(rt.call_function('current_user_can', [rt.get_property(rt.get_property(var_post_type, 'cap'), 'edit_posts')])) {
				return true
			}
		}
	}
	return (create_wp_error(rt.new_string('rest_cannot_manage_templates'), rt.call_function('__', [rt.new_string('Sorry, you are not allowed to access the templates on this site.')]), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code', []rt.PhpVal{}) }]))).to_bool()
}

fn (mut this Class_WP_REST_Templates_Controller) get_items(var_request rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.call_method(var_request, 'is_method', [rt.new_string('HEAD')])) {
		return create_wp_rest_response(rt.new_array())
	}
	mut var_query := rt.new_array()
	if var_request.array_isset(rt.new_string('wp_id')) {
		var_query['wp_id'] = var_request.array_get('wp_id')
	}
	if var_request.array_isset(rt.new_string('area')) {
		var_query['area'] = var_request.array_get('area')
	}
	if var_request.array_isset(rt.new_string('post_type')) {
		var_query['post_type'] = var_request.array_get('post_type')
	}
	mut var_templates := rt.new_array()
	{
		mut iter_1 := rt.call_function('get_block_templates', [var_query.dup(), this.post_type]).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_template := item_1.val
			mut var_data := this.prepare_item_for_response(var_template.dup(), var_request.dup())
			var_templates << this.prepare_response_for_collection(var_data.dup())
		}
	}
	return rt.call_function('rest_ensure_response', [var_templates.dup()])
}

fn (mut this Class_WP_REST_Templates_Controller) get_item_permissions_check(var_request rt.PhpVal) bool {
	if rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_posts')])) {
		return true
	}
	{
		mut iter_1 := rt.call_function('get_post_types', [rt.create_array([rt.ArrayItem{ key: 'show_in_rest', val: true }]), rt.new_string('objects')]).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_post_type := item_1.val
			if rt.is_true(rt.call_function('current_user_can', [rt.get_property(rt.get_property(var_post_type, 'cap'), 'edit_posts')])) {
				return true
			}
		}
	}
	return (create_wp_error(rt.new_string('rest_cannot_manage_templates'), rt.call_function('__', [rt.new_string('Sorry, you are not allowed to access the templates on this site.')]), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code', []rt.PhpVal{}) }]))).to_bool()
}

fn (mut this Class_WP_REST_Templates_Controller) get_item(var_request rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.new_bool(var_request.array_isset(rt.new_string('source')) && rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('theme'), var_request.array_get('source'))) || rt.is_true(rt.identical(rt.new_string('plugin'), var_request.array_get('source'))))))) {
		mut var_template := rt.call_function('get_block_file_template', [var_request.array_get('id'), this.post_type])
	} else {
		var_template = rt.call_function('get_block_template', [var_request.array_get('id'), this.post_type])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_template)))) {
		return create_wp_error(rt.new_string('rest_template_not_found'), rt.call_function('__', [rt.new_string('No templates exist with that id.')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 404 }]))
	}
	return this.prepare_item_for_response(var_template.dup(), var_request.dup())
}

fn (mut this Class_WP_REST_Templates_Controller) update_item_permissions_check(var_request rt.PhpVal) rt.PhpVal {
	return rt.new_bool(this.permissions_check(var_request.dup()))
}

fn (mut this Class_WP_REST_Templates_Controller) update_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_template := rt.call_function('get_block_template', [var_request.array_get('id'), this.post_type])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_template)))) {
		return create_wp_error(rt.new_string('rest_template_not_found'), rt.call_function('__', [rt.new_string('No templates exist with that id.')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 404 }]))
	}
	mut var_post_before := rt.call_function('get_post', [rt.get_property(var_template, 'wp_id')])
	if rt.is_true(rt.new_bool(var_request.array_isset(rt.new_string('source')) && rt.is_true(rt.identical(rt.new_string('theme'), var_request.array_get('source'))))) {
		rt.call_function('wp_delete_post', [rt.get_property(var_template, 'wp_id'), rt.new_bool(true)])
		rt.call_method(var_request, 'set_param', [rt.new_string('context'), rt.new_string('edit')])
		var_template = rt.call_function('get_block_template', [var_request.array_get('id'), this.post_type])
		mut var_response := this.prepare_item_for_response(var_template.dup(), var_request.dup())
		return rt.call_function('rest_ensure_response', [var_response.dup()])
	}
	mut var_changes := this.prepare_item_for_database(var_request.dup())
	if rt.is_true(rt.call_function('is_wp_error', [var_changes.dup()])) {
		return var_changes.dup()
	}
	if rt.is_true(rt.identical(rt.new_string('custom'), rt.get_property(var_template, 'source'))) {
		mut var_update := rt.new_bool(rt.new_bool(true))
		mut var_result := rt.call_function('wp_update_post', [rt.call_function('wp_slash', [rt.cast_array(var_changes)]), rt.new_bool(false)])
	} else {
		var_update = rt.new_bool(rt.new_bool(false))
		var_post_before = rt.new_null()
		var_result = rt.call_function('wp_insert_post', [rt.call_function('wp_slash', [rt.cast_array(var_changes)]), rt.new_bool(false)])
	}
	if rt.is_true(rt.call_function('is_wp_error', [var_result.dup()])) {
		if rt.is_true(rt.identical(rt.new_string('db_update_error'), rt.call_method(var_result, 'get_error_code', []rt.PhpVal{}))) {
			rt.call_method(var_result, 'add_data', [rt.create_array([rt.ArrayItem{ key: 'status', val: 500 }])])
		} else {
			rt.call_method(var_result, 'add_data', [rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }])])
		}
		return var_result.dup()
	}
	var_template = rt.call_function('get_block_template', [var_request.array_get('id'), this.post_type])
	mut var_fields_update := this.update_additional_fields_for_object(var_template.dup(), var_request.dup())
	if rt.is_true(rt.call_function('is_wp_error', [var_fields_update.dup()])) {
		return var_fields_update.dup()
	}
	rt.call_method(var_request, 'set_param', [rt.new_string('context'), rt.new_string('edit')])
	mut var_post := rt.call_function('get_post', [rt.get_property(var_template, 'wp_id')])
	rt.call_function('do_action', [rt.concat(rt.new_string('rest_after_insert_'), this.post_type), var_post.dup(), var_request.dup(), rt.new_bool(false)])
	rt.call_function('wp_after_insert_post', [var_post.dup(), var_update.dup(), var_post_before.dup()])
	var_response = this.prepare_item_for_response(var_template.dup(), var_request.dup())
	return rt.call_function('rest_ensure_response', [var_response.dup()])
}

fn (mut this Class_WP_REST_Templates_Controller) create_item_permissions_check(var_request rt.PhpVal) rt.PhpVal {
	return rt.new_bool(this.permissions_check(var_request.dup()))
}

fn (mut this Class_WP_REST_Templates_Controller) create_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_prepared_post := this.prepare_item_for_database(var_request.dup())
	if rt.is_true(rt.call_function('is_wp_error', [var_prepared_post.dup()])) {
		return var_prepared_post.dup()
	}
	rt.set_property(var_prepared_post, 'post_name', var_request.array_get('slug'))
	mut var_post_id := rt.call_function('wp_insert_post', [rt.call_function('wp_slash', [rt.cast_array(var_prepared_post)]), rt.new_bool(true)])
	if rt.is_true(rt.call_function('is_wp_error', [var_post_id.dup()])) {
		if rt.is_true(rt.identical(rt.new_string('db_insert_error'), rt.call_method(var_post_id, 'get_error_code', []rt.PhpVal{}))) {
			rt.call_method(var_post_id, 'add_data', [rt.create_array([rt.ArrayItem{ key: 'status', val: 500 }])])
		} else {
			rt.call_method(var_post_id, 'add_data', [rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }])])
		}
		return var_post_id.dup()
	}
	mut var_posts := rt.call_function('get_block_templates', [rt.create_array([rt.ArrayItem{ key: 'wp_id', val: var_post_id }]), this.post_type])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_int(var_posts.dup().array_count()))))) {
		return create_wp_error(rt.new_string('rest_template_insert_error'), rt.call_function('__', [rt.new_string('No templates exist with that id.')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }]))
	}
	mut var_id := rt.get_property(var_posts.array_get(0), 'id')
	mut var_post := rt.call_function('get_post', [var_post_id.dup()])
	mut var_template := rt.call_function('get_block_template', [var_id.dup(), this.post_type])
	mut var_fields_update := this.update_additional_fields_for_object(var_template.dup(), var_request.dup())
	if rt.is_true(rt.call_function('is_wp_error', [var_fields_update.dup()])) {
		return var_fields_update.dup()
	}
	rt.call_function('do_action', [rt.concat(rt.new_string('rest_after_insert_'), this.post_type), var_post.dup(), var_request.dup(), rt.new_bool(true)])
	rt.call_function('wp_after_insert_post', [var_post.dup(), rt.new_bool(false), rt.new_null()])
	mut var_response := this.prepare_item_for_response(var_template.dup(), var_request.dup())
	var_response = rt.call_function('rest_ensure_response', [var_response.dup()])
	rt.call_method(var_response, 'set_status', [rt.new_int(201)])
	rt.call_method(var_response, 'header', [rt.new_string('Location'), rt.call_function('rest_url', [rt.call_function('sprintf', [rt.new_string('%s/%s/%s'), rt.get_property(rt.new_object('WP_REST_Templates_Controller', ['WP_REST_Controller'], &this), 'namespace'), rt.get_property(rt.new_object('WP_REST_Templates_Controller', ['WP_REST_Controller'], &this), 'rest_base'), rt.get_property(var_template, 'id')])])])
	return var_response.dup()
}

fn (mut this Class_WP_REST_Templates_Controller) delete_item_permissions_check(var_request rt.PhpVal) rt.PhpVal {
	return rt.new_bool(this.permissions_check(var_request.dup()))
}

fn (mut this Class_WP_REST_Templates_Controller) delete_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_template := rt.call_function('get_block_template', [var_request.array_get('id'), this.post_type])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_template)))) {
		return create_wp_error(rt.new_string('rest_template_not_found'), rt.call_function('__', []), rt.create_array([rt.ArrayItem{ key: , val:  }]))
	}
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return create_wp_error(, , )
	}
	mut var_id := 
	
}

fn (mut this Class_WP_REST_Templates_Controller) prepare_item_for_database(var_request rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_WP_REST_Templates_Controller) prepare_item_for_response(var_item rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
	mut var_item_mutated := var_item
}

fn Class_WP_REST_Templates_Controller.get_wp_templates_original_source_field(var_template_object rt.PhpVal) string {
}

fn Class_WP_REST_Templates_Controller.get_wp_templates_author_text_field(var_template_object rt.PhpVal) string {
	mut var_plugin_slug := rt.new_null()
}

fn (mut this Class_WP_REST_Templates_Controller) prepare_links(var_id rt.PhpVal) rt.PhpVal {
	mut var_id_mutated := var_id
}

fn (mut this Class_WP_REST_Templates_Controller) get_available_actions() rt.PhpVal {
}

fn (mut this Class_WP_REST_Templates_Controller) get_collection_params() rt.PhpVal {
}

fn (mut this Class_WP_REST_Templates_Controller) get_item_schema() rt.PhpVal {
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

fn create_wp_rest_templates_controller(arg_0 rt.PhpVal) &Class_WP_REST_Templates_Controller {
	mut obj := &Class_WP_REST_Templates_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
		post_type: rt.new_null()
	}
	obj.construct(arg_0)
	return obj
}

fn create_wp_rest_controller() &Class_WP_REST_Controller {
	mut obj := &Class_WP_REST_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_stdclass() &Class_stdClass {
	mut obj := &Class_stdClass{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_error() &Class_WP_Error {
	mut obj := &Class_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_rest_response() &Class_WP_REST_Response {
	mut obj := &Class_WP_REST_Response{
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
		else { return none }
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
		'post_type' { this.post_type = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
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




pub fn init_wp_includes_rest_api_endpoints_class_wp_rest_templates_controller_php() {
}
