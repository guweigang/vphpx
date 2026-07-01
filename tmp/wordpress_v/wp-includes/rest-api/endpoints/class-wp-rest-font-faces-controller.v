import rt

pub fn Class_WP_REST_Font_Faces_Controller.latest_theme_json_version_supported() i64 {
	return 3
}
struct Class_WP_REST_Font_Faces_Controller {
	rt.PhpObjectBase
pub mut:
		allow_batch rt.PhpVal = rt.new_bool(false)
}

fn (mut this Class_WP_REST_Font_Faces_Controller) register_routes()  {
	rt.call_function('register_rest_route', [rt.get_property(rt.new_object('WP_REST_Font_Faces_Controller', ['WP_REST_Posts_Controller'], &this), 'namespace'), '/' + (rt.get_property(rt.new_object('WP_REST_Font_Faces_Controller', ['WP_REST_Posts_Controller'], &this), 'rest_base')).str(), rt.create_array([rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'font_family_id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('The ID for the parent font family of the font face.')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }, rt.ArrayItem{ key: 'required', val: true }]) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Font_Faces_Controller', ['WP_REST_Posts_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_items' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Font_Faces_Controller', ['WP_REST_Posts_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_items_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: this.get_collection_params() }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.creatable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Font_Faces_Controller', ['WP_REST_Posts_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'create_item' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Font_Faces_Controller', ['WP_REST_Posts_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'create_item_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: this.get_create_params() }]) }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Font_Faces_Controller', ['WP_REST_Posts_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_public_item_schema' }]) }])])
	rt.call_function('register_rest_route', [rt.get_property(rt.new_object('WP_REST_Font_Faces_Controller', ['WP_REST_Posts_Controller'], &this), 'namespace'), '/' + (rt.get_property(rt.new_object('WP_REST_Font_Faces_Controller', ['WP_REST_Posts_Controller'], &this), 'rest_base')).str() + '/(?P<id>[\\d]+)', rt.create_array([rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'font_family_id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('The ID for the parent font family of the font face.')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }, rt.ArrayItem{ key: 'required', val: true }]) }, rt.ArrayItem{ key: 'id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Unique identifier for the font face.')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }, rt.ArrayItem{ key: 'required', val: true }]) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Font_Faces_Controller', ['WP_REST_Posts_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_item' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Font_Faces_Controller', ['WP_REST_Posts_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_item_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'context', val: this.get_context_param(rt.create_array([rt.ArrayItem{ key: 'default', val: 'view' }])) }]) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.deletable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Font_Faces_Controller', ['WP_REST_Posts_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'delete_item' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Font_Faces_Controller', ['WP_REST_Posts_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'delete_item_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'force', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'boolean' }, rt.ArrayItem{ key: 'default', val: false }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Whether to bypass Trash and force deletion.'), rt.new_string('default')]) }]) }]) }]) }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Font_Faces_Controller', ['WP_REST_Posts_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_public_item_schema' }]) }])])
}

fn (mut this Class_WP_REST_Font_Faces_Controller) get_items_permissions_check(var_request rt.PhpVal) bool {
	mut var_post_type := rt.call_function('get_post_type_object', [rt.get_property(rt.new_object('WP_REST_Font_Faces_Controller', ['WP_REST_Posts_Controller'], &this), 'post_type')])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.get_property(rt.get_property(var_post_type, 'cap'), 'read')]))))) {
		return (create_wp_error(rt.new_string('rest_cannot_read'), rt.call_function('__', [rt.new_string('Sorry, you are not allowed to access font faces.')]), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code', []rt.PhpVal{}) }]))).to_bool()
	}
	return true
}

fn (mut this Class_WP_REST_Font_Faces_Controller) get_item_permissions_check(var_request rt.PhpVal) bool {
	mut var_post := this.get_post(var_request.array_get('id'))
	if rt.is_true(rt.call_function('is_wp_error', [var_post.dup()])) {
		return (var_post).to_bool()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('read_post'), rt.get_property(var_post, 'ID')]))))) {
		return (create_wp_error(rt.new_string('rest_cannot_read'), rt.call_function('__', [rt.new_string('Sorry, you are not allowed to access this font face.')]), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code', []rt.PhpVal{}) }]))).to_bool()
	}
	return true
}

fn (mut this Class_WP_REST_Font_Faces_Controller) validate_create_font_face_settings(var_value rt.PhpVal, var_request rt.PhpVal) bool {
	mut var_value_mutated := var_value
	mut var_args := this.get_create_params()
	mut var_validity := rt.call_function('rest_validate_value_from_schema', [var_value_mutated.dup(), var_args.array_get('font_face_settings'), rt.new_string('font_face_settings')])
	if rt.is_true(rt.call_function('is_wp_error', [var_validity.dup()])) {
		return (var_validity).to_bool()
	}
	mut var_settings := rt.call_function('json_decode', [var_value_mutated.dup(), rt.new_bool(true)])
	if rt.is_true(rt.identical(rt.new_null(), var_settings)) {
		return (create_wp_error(rt.new_string('rest_invalid_param'), rt.call_function('__', [rt.new_string('font_face_settings parameter must be a valid JSON string.')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }]))).to_bool()
	}
	mut var_schema := this.get_item_schema().array_get('properties').array_get('font_face_settings')
	mut var_has_valid_settings := rt.call_function('rest_validate_value_from_schema', [var_settings.dup(), var_schema.dup(), rt.new_string('font_face_settings')])
	if rt.is_true(rt.call_function('is_wp_error', [var_has_valid_settings.dup()])) {
		rt.call_method(var_has_valid_settings, 'add_data', [rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }])])
		return (var_has_valid_settings).to_bool()
	}
	mut var_required := var_schema.array_get('required')
	{
		mut iter_1 := var_required.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_key := item_1.val
			if rt.is_true(rt.new_bool(var_settings.array_isset(var_key) && rt.is_true(rt.new_bool(!(rt.is_true(var_settings.array_get(var_key))))))) {
				return (create_wp_error(rt.new_string('rest_invalid_param'), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('%s cannot be empty.')]), rt.new_string("font_face_setting[ ${var_key.to_string()} ]")]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }]))).to_bool()
			}
		}
	}
	mut var_srcs := if rt.is_true(rt.new_bool(var_settings.array_get('src').is_array())) { var_settings.array_get('src') } else { rt.create_array([rt.ArrayItem{ key: none, val: var_settings.array_get('src') }]) }
	mut var_files := rt.call_method(var_request, 'get_file_params', []rt.PhpVal{})
	{
		mut iter_1 := var_srcs.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_src := item_1.val
			var_src = rt.new_string(rt.new_string(var_src.dup().to_string().trim_left(' \t\n\r')))
			if !rt.is_true(var_src) {
				return (create_wp_error(rt.new_string('rest_invalid_param'), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('%s values must be non-empty strings.')]), rt.new_string('font_face_settings[src]')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }]))).to_bool()
			}
			if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('wp_http_validate_url', [var_src.dup()]))) && !(var_files.array_isset(var_src)))) {
				return (create_wp_error(rt.new_string('rest_invalid_param'), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('%1$s value "%2$s" must be a valid URL or file reference.')]), rt.new_string('font_face_settings[src]'), var_src.dup()]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }]))).to_bool()
			}
		}
	}
	{
		mut iter_1 := rt.func_array_keys(var_files.dup()).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_file := item_1.val
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_file.dup(), var_srcs.dup(), rt.new_bool(true)]))))) {
				return (create_wp_error(rt.new_string('rest_invalid_param'), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('File %1$s must be used in %2$s.')]), var_file.dup(), rt.new_string('font_face_settings[src]')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }]))).to_bool()
			}
		}
	}
	return true
}

fn (mut this Class_WP_REST_Font_Faces_Controller) sanitize_font_face_settings(var_value rt.PhpVal) rt.PhpVal {
	mut var_value_mutated := var_value
	mut var_settings := rt.call_function('json_decode', [var_value_mutated.dup(), rt.new_bool(true)])
	mut var_schema := this.get_item_schema().array_get('properties').array_get('font_face_settings').array_get('properties')
	{
		mut iter_1 := var_settings.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_value_shadow := item_1.val
			mut var_key := item_1.key
			mut var_sanitize_callback := var_schema.array_get(var_key).array_get('arg_options').array_get('sanitize_callback')
			var_settings.array_set(var_key, rt.call_function('call_user_func', [var_sanitize_callback.dup(), var_value_shadow.dup()]))
		}
	}
	return var_settings.dup()
}

fn (mut this Class_WP_REST_Font_Faces_Controller) get_items(var_request rt.PhpVal) rt.PhpVal {
	mut var_font_family := this.get_parent_font_family_post(var_request.array_get('font_family_id'))
	if rt.is_true(rt.call_function('is_wp_error', [var_font_family.dup()])) {
		return var_font_family.dup()
	}
	return this.Class_WP_REST_Posts_Controller.get_items(var_request.dup())
}

fn (mut this Class_WP_REST_Font_Faces_Controller) get_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_post := this.get_post(var_request.array_get('id'))
	if rt.is_true(rt.call_function('is_wp_error', [var_post.dup()])) {
		return var_post.dup()
	}
	mut var_font_family := this.get_parent_font_family_post(var_request.array_get('font_family_id'))
	if rt.is_true(rt.call_function('is_wp_error', [var_font_family.dup()])) {
		return var_font_family.dup()
	}
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return create_wp_error(rt.new_string('rest_font_face_parent_id_mismatch'), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('The font face does not belong to the specified font family with id of "%d".')]), rt.get_property(var_font_family, 'ID')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 404 }]))
	}
	return this.Class_WP_REST_Posts_Controller.get_item(var_request.dup())
}

fn (mut this Class_WP_REST_Font_Faces_Controller) create_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_font_family := this.get_parent_font_family_post(var_request.array_get('font_family_id'))
	if rt.is_true(rt.call_function('is_wp_error', [var_font_family.dup()])) {
		return var_font_family.dup()
	}
	mut var_settings := rt.call_method(var_request, 'get_param', [rt.new_string('font_face_settings')])
	mut var_file_params := rt.call_method(var_request, 'get_file_params', []rt.PhpVal{})
	mut var_query := create_wp_query(rt.create_array([rt.ArrayItem{ key: 'post_type', val: rt.get_property(rt.new_object('WP_REST_Font_Faces_Controller', ['WP_REST_Posts_Controller'], &this), 'post_type') }, rt.ArrayItem{ key: 'posts_per_page', val: 1 }, rt.ArrayItem{ key: 'title', val: fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WP_Font_Utils{}; return temp.get_font_face_slug(arg_0) }(var_settings.dup()) }, rt.ArrayItem{ key: 'update_post_meta_cache', val: false }, rt.ArrayItem{ key: 'update_post_term_cache', val: false }]))
	if !(!rt.is_true(rt.get_property(var_query, 'posts'))) {
		return create_wp_error(rt.new_string('rest_duplicate_font_face'), rt.call_function('__', [rt.new_string('A font face matching those settings already exists.')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }]))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('wp_handle_upload')]))))) {
		rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/file.php', '4')
	}
	mut var_srcs := if rt.is_true(rt.new_bool(var_settings.array_get('src').is_string())) { rt.create_array([rt.ArrayItem{ key: none, val: var_settings.array_get('src') }]) } else { var_settings.array_get('src') }
	mut var_processed_srcs := []rt.PhpVal{}
	mut var_font_file_meta := []rt.PhpVal{}
	{
		mut iter_1 := var_srcs.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_src := item_1.val
			if !(var_file_params.array_isset(var_src)) {
				var_processed_srcs << var_src.dup()
				continue
			}
			mut var_file := var_file_params.array_get(var_src)
			mut var_font_file := this.handle_font_file_upload(var_file.dup())
			if rt.is_true(rt.call_function('is_wp_error', [var_font_file.dup()])) {
				return var_font_file.dup()
			}
			var_processed_srcs << var_font_file.array_get('url')
			var_font_file_meta << this.relative_fonts_path(var_font_file.array_get('file'))
		}
	}
	var_settings.array_set('src', if var_processed_srcs.len == 1 { var_processed_srcs.array_get(0) } else { var_processed_srcs })
	rt.call_method(var_request, 'set_param', [rt.new_string('font_face_settings'), var_settings.dup()])
	mut var_font_face_post := this.Class_WP_REST_Posts_Controller.create_item(var_request.dup())
	if rt.is_true(rt.call_function('is_wp_error', [var_font_face_post.dup()])) {
		return var_font_face_post.dup()
	}
	mut var_font_face_id := rt.get_property(var_font_face_post, 'data').array_get('id')
	for var_font_file_path in var_font_file_meta {
		rt.call_function('add_post_meta', [var_font_face_id.dup(), rt.new_string('_wp_font_face_file'), var_font_file_path.dup()])
	}
	return var_font_face_post.dup()
}

fn (mut this Class_WP_REST_Font_Faces_Controller) delete_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_post := this.get_post(var_request.array_get('id'))
	if rt.is_true(rt.call_function('is_wp_error', [var_post.dup()])) {
		return var_post.dup()
	}
	mut var_font_family := this.get_parent_font_family_post(var_request.array_get('font_family_id'))
	if rt.is_true(rt.call_function('is_wp_error', [var_font_family.dup()])) {
		return var_font_family.dup()
	}
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return create_wp_error(rt.new_string('rest_font_face_parent_id_mismatch'), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('The font face does not belong to the specified font family with id of "%d".')]), rt.get_property(var_font_family, 'ID')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 404 }]))
	}
	mut var_force := if var_request.array_isset(rt.new_string('force')) { // unsupported expression: Expr_Cast_Bool } else { rt.new_bool(false) }
	if rt.is_true(rt.new_bool(!(rt.is_true(var_force)))) {
		return create_wp_error(rt.new_string('rest_trash_not_supported'), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Font faces do not support trashing. Set "%s" to delete.')]), rt.new_string('force=true')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 501 }]))
	}
	return this.Class_WP_REST_Posts_Controller.delete_item(var_request.dup())
}

fn (mut this Class_WP_REST_Font_Faces_Controller) prepare_item_for_response(var_item rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
	mut var_fields := this.get_fields_for_response(var_request.dup())
	mut var_data := []rt.PhpVal{}
	if rt.is_true(rt.call_function('rest_is_field_included', [rt.new_string('id'), var_fields.dup()])) {
		var_data.array_set('id', rt.get_property(var_item, 'ID'))
	}
	if rt.is_true(rt.call_function('rest_is_field_included', [rt.new_string('theme_json_version'), var_fields.dup()])) {
		var_data.array_set('theme_json_version', Class_static.latest_theme_json_version_supported())
	}
	if rt.is_true(rt.call_function('rest_is_field_included', [rt.new_string('parent'), var_fields.dup()])) {
		var_data.array_set('parent', rt.get_property(var_item, 'post_parent'))
	}
	if rt.is_true(rt.call_function('rest_is_field_included', [rt.new_string('font_face_settings'), var_fields.dup()])) {
		var_data.array_set('font_face_settings', this.get_settings_from_post(var_item.dup()))
	}
	mut var_context := if !(!rt.is_true(var_request.array_get('context'))) { var_request.array_get('context') } else { rt.new_string('view') }
	var_data = this.add_additional_fields_to_object(var_data.dup(), var_request.dup())
	var_data = this.filter_response_by_context(var_data.dup(), var_context.dup())
	mut var_response := rt.call_function('rest_ensure_response', [var_data.dup()])
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('rest_is_field_included', [rt.new_string('_links'), var_fields.dup()])) || rt.is_true(rt.call_function('rest_is_field_included', [rt.new_string('_embedded'), var_fields.dup()])))) {
		mut var_links := this.prepare_links(var_item.dup())
		rt.call_method(var_response, 'add_links', [var_links.dup()])
	}
	return rt.call_function('apply_filters', [rt.new_string('rest_prepare_wp_font_face'), var_response.dup(), var_item.dup(), var_request.dup()])
}

fn (mut this Class_WP_REST_Font_Faces_Controller) get_item_schema() rt.PhpVal {
	if rt.is_true(rt.get_property(rt.new_object('WP_REST_Font_Faces_Controller', ['WP_REST_Posts_Controller'], &this), 'schema')) {
		return this.add_additional_fields_schema(rt.get_property(rt.new_object('WP_REST_Font_Faces_Controller', ['WP_REST_Posts_Controller'], &this), 'schema'))
	}
	mut var_schema := rt.create_array([rt.ArrayItem{ key: '$schema', val: 'http://json-schema.org/draft-04/schema#' }, rt.ArrayItem{ key: 'title', val: rt.get_property(rt.new_object('WP_REST_Font_Faces_Controller', ['WP_REST_Posts_Controller'], &this), 'post_type') }, rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: 'id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [, ]) }, rt.ArrayItem{ key: 'type', val: 'integer' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val:  }, rt.ArrayItem{ key: none, val:  }, rt.ArrayItem{ key: none, val:  }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'theme_json_version', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', []) }, rt.ArrayItem{ key: 'type', val: 'integer' }, rt.ArrayItem{ key: 'default', val: Class_static.latest_theme_json_version_supported() }, rt.ArrayItem{ key: 'minimum', val: 2 }, rt.ArrayItem{ key: 'maximum', val: Class_static.latest_theme_json_version_supported() }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val:  }, rt.ArrayItem{ key: none, val:  }, rt.ArrayItem{ key: none, val:  }]) }]) }, rt.ArrayItem{ key: 'parent', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', []) }, rt.ArrayItem{ key: 'type', val: 'integer' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val:  }, rt.ArrayItem{ key: none, val:  }, rt.ArrayItem{ key: none, val:  }]) }]) }, rt.ArrayItem{ key: 'font_face_settings', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', []) }, rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val:  }, rt.ArrayItem{ key: none, val:  }, rt.ArrayItem{ key: none, val:  }]) }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: , val:  }, rt.ArrayItem{ key: , val:  }, rt.ArrayItem{ key: , val:  }, rt.ArrayItem{ key: , val:  }, rt.ArrayItem{ key: , val:  }, rt.ArrayItem{ key: , val:  }, rt.ArrayItem{ key: , val:  }, rt.ArrayItem{ key: , val:  }, rt.ArrayItem{ key: , val:  }, rt.ArrayItem{ key: , val:  }, rt.ArrayItem{ key: , val:  }, rt.ArrayItem{ key: , val:  }, rt.ArrayItem{ key: , val:  }, rt.ArrayItem{ key: , val:  }, rt.ArrayItem{ key: , val:  }]) }, rt.ArrayItem{ key: 'required', val: rt.create_array([rt.ArrayItem{ key: none, val:  }, rt.ArrayItem{ key: none, val:  }]) }, rt.ArrayItem{ key: 'additionalProperties', val: false }]) }]) }])
	this.dispatch_set_prop('schema', var_schema.dup())
	return this.add_additional_fields_schema(rt.get_property(rt.new_object('WP_REST_Font_Faces_Controller', ['WP_REST_Posts_Controller'], &this), 'schema'))
}

fn (mut this Class_WP_REST_Font_Faces_Controller) get_public_item_schema() rt.PhpVal {
	mut var_schema := this.Class_WP_REST_Posts_Controller.get_public_item_schema()
	{
		mut iter_1 := .array_get().iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_property := item_1.val
			.array_unset()
		}
	}
}

fn (mut this Class_WP_REST_Font_Faces_Controller) get_collection_params() rt.PhpVal {
}

fn (mut this Class_WP_REST_Font_Faces_Controller) get_create_params() rt.PhpVal {
}

fn (mut this Class_WP_REST_Font_Faces_Controller) get_parent_font_family_post(var_font_family_id rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_WP_REST_Font_Faces_Controller) prepare_links(var_post rt.PhpVal) rt.PhpVal {
	mut var_post_mutated := var_post
}

fn (mut this Class_WP_REST_Font_Faces_Controller) prepare_item_for_database(var_request rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_WP_REST_Font_Faces_Controller) sanitize_src(var_value rt.PhpVal) rt.PhpVal {
	mut var_value_mutated := var_value
}

fn (mut this Class_WP_REST_Font_Faces_Controller) handle_font_file_upload(var_file rt.PhpVal) rt.PhpVal {
	mut var_file_mutated := var_file
}

fn (mut this Class_WP_REST_Font_Faces_Controller) handle_font_file_upload_error(var_file rt.PhpVal, var_message rt.PhpVal) rt.PhpVal {
	mut var_file_mutated := var_file
}

fn (mut this Class_WP_REST_Font_Faces_Controller) relative_fonts_path(var_path rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_WP_REST_Font_Faces_Controller) get_settings_from_post(var_post rt.PhpVal) rt.PhpVal {
	mut var_post_mutated := var_post
}

struct Class_WP_REST_Posts_Controller {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

struct Class_WP_Query {
	rt.PhpObjectBase
}

struct Class_WP_Font_Utils {
	rt.PhpObjectBase
}

fn create_wp_rest_font_faces_controller() &Class_WP_REST_Font_Faces_Controller {
	mut obj := &Class_WP_REST_Font_Faces_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
		allow_batch: rt.new_bool(false)
	}
	return obj
}

fn create_wp_rest_posts_controller() &Class_WP_REST_Posts_Controller {
	mut obj := &Class_WP_REST_Posts_Controller{
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

fn create_wp_query() &Class_WP_Query {
	mut obj := &Class_WP_Query{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_font_utils() &Class_WP_Font_Utils {
	mut obj := &Class_WP_Font_Utils{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_REST_Font_Faces_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'register_routes' {
			this.register_routes()
			return rt.new_null()
		}
		'get_items_permissions_check' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.get_items_permissions_check(dispatch_arg_0))
		}
		'get_item_permissions_check' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.get_item_permissions_check(dispatch_arg_0))
		}
		'validate_create_font_face_settings' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(this.validate_create_font_face_settings(dispatch_arg_0, dispatch_arg_1))
		}
		'sanitize_font_face_settings' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.sanitize_font_face_settings(dispatch_arg_0)
		}
		'get_items' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_items(dispatch_arg_0)
		}
		'get_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_item(dispatch_arg_0)
		}
		'create_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.create_item(dispatch_arg_0)
		}
		'delete_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.delete_item(dispatch_arg_0)
		}
		'prepare_item_for_response' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.prepare_item_for_response(dispatch_arg_0, dispatch_arg_1)
		}
		'get_item_schema' {
			return this.get_item_schema()
		}
		'get_public_item_schema' {
			return this.get_public_item_schema()
		}
		'get_collection_params' {
			return this.get_collection_params()
		}
		'get_create_params' {
			return this.get_create_params()
		}
		'get_parent_font_family_post' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_parent_font_family_post(dispatch_arg_0)
		}
		'prepare_links' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.prepare_links(dispatch_arg_0)
		}
		'prepare_item_for_database' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.prepare_item_for_database(dispatch_arg_0)
		}
		'sanitize_src' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.sanitize_src(dispatch_arg_0)
		}
		'handle_font_file_upload' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.handle_font_file_upload(dispatch_arg_0)
		}
		'handle_font_file_upload_error' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.handle_font_file_upload_error(dispatch_arg_0, dispatch_arg_1)
		}
		'relative_fonts_path' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.relative_fonts_path(dispatch_arg_0)
		}
		'get_settings_from_post' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_settings_from_post(dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_WP_REST_Font_Faces_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'allow_batch' { return this.allow_batch }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_REST_Font_Faces_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'allow_batch' { this.allow_batch = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
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


fn (mut this Class_WP_Query) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Query) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Query) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_Font_Utils) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Font_Utils) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Font_Utils) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_includes_rest_api_endpoints_class_wp_rest_font_faces_controller_php() {
}
