import rt

pub fn Class_WP_REST_Font_Faces_Controller.latest_theme_json_version_supported() i64 {
	return 3
}

struct Class_WP_REST_Font_Faces_Controller {
	rt.PhpObjectBase
pub mut:
	allow_batch rt.PhpVal = rt.new_bool(false)
}

fn (mut this Class_WP_REST_Font_Faces_Controller) register_routes() {
	rt.call_function('register_rest_route', [
		rt.get_property(rt.new_object('WP_REST_Font_Faces_Controller', [
			'WP_REST_Posts_Controller',
		], &this), 'namespace'),
		rt.new_string('/' +(rt.get_property(rt.new_object('WP_REST_Font_Faces_Controller', ['WP_REST_Posts_Controller'], &this), 'rest_base')).str()),
		rt.create_array([
			rt.ArrayItem{ key: 'args', val: rt.create_array([
				rt.ArrayItem{ key: 'font_family_id', val: rt.create_array([
					rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
						rt.new_string('The ID for the parent font family of the font face.'),
					]) },
					rt.ArrayItem{ key: 'type', val: 'integer' },
					rt.ArrayItem{ key: 'required', val: true },
				]) },
			]) },
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() },
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Font_Faces_Controller', [
						'WP_REST_Posts_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'get_items' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Font_Faces_Controller', [
						'WP_REST_Posts_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'get_items_permissions_check' },
				]) },
				rt.ArrayItem{ key: 'args', val: this.get_collection_params() },
			]) },
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.creatable() },
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Font_Faces_Controller', [
						'WP_REST_Posts_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'create_item' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Font_Faces_Controller', [
						'WP_REST_Posts_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'create_item_permissions_check' },
				]) },
				rt.ArrayItem{ key: 'args', val: this.get_create_params() },
			]) },
			rt.ArrayItem{ key: 'schema', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Font_Faces_Controller', [
					'WP_REST_Posts_Controller',
				], &this) },
				rt.ArrayItem{ key: none, val: 'get_public_item_schema' },
			]) },
		]),
	])
	rt.call_function('register_rest_route', [
		rt.get_property(rt.new_object('WP_REST_Font_Faces_Controller', [
			'WP_REST_Posts_Controller',
		], &this), 'namespace'),
		rt.new_string('/' +
			(rt.get_property(rt.new_object('WP_REST_Font_Faces_Controller', ['WP_REST_Posts_Controller'], &this), 'rest_base')).str() +
			'/(?P<id>[\\d]+)'),
		rt.create_array([
			rt.ArrayItem{ key: 'args', val: rt.create_array([
				rt.ArrayItem{ key: 'font_family_id', val: rt.create_array([
					rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
						rt.new_string('The ID for the parent font family of the font face.'),
					]) },
					rt.ArrayItem{ key: 'type', val: 'integer' },
					rt.ArrayItem{ key: 'required', val: true },
				]) },
				rt.ArrayItem{ key: 'id', val: rt.create_array([
					rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
						rt.new_string('Unique identifier for the font face.'),
					]) },
					rt.ArrayItem{ key: 'type', val: 'integer' },
					rt.ArrayItem{ key: 'required', val: true },
				]) },
			]) },
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() },
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Font_Faces_Controller', [
						'WP_REST_Posts_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'get_item' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Font_Faces_Controller', [
						'WP_REST_Posts_Controller',
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
				rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.deletable() },
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Font_Faces_Controller', [
						'WP_REST_Posts_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'delete_item' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Font_Faces_Controller', [
						'WP_REST_Posts_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'delete_item_permissions_check' },
				]) },
				rt.ArrayItem{ key: 'args', val: rt.create_array([
					rt.ArrayItem{ key: 'force', val: rt.create_array([
						rt.ArrayItem{ key: 'type', val: 'boolean' },
						rt.ArrayItem{ key: 'default', val: false },
						rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
							rt.new_string('Whether to bypass Trash and force deletion.'),
							rt.new_string('default'),
						]) },
					]) },
				]) },
			]) },
			rt.ArrayItem{ key: 'schema', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Font_Faces_Controller', [
					'WP_REST_Posts_Controller',
				], &this) },
				rt.ArrayItem{ key: none, val: 'get_public_item_schema' },
			]) },
		]),
	])
}

fn (mut this Class_WP_REST_Font_Faces_Controller) get_items_permissions_check(var_request rt.PhpVal) bool {
	mut var_post_type := rt.call_function('get_post_type_object', [
		rt.get_property(rt.new_object('WP_REST_Font_Faces_Controller', [
			'WP_REST_Posts_Controller',
		], &this), 'post_type'),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.get_property(rt.get_property(var_post_type, 'cap'), 'read'),
	])))))
	{
		return (create_wp_error(rt.new_string('rest_cannot_read'), rt.call_function('__', [
			rt.new_string('Sorry, you are not allowed to access font faces.'),
		]), rt.create_array([
			rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code',
				[]rt.PhpVal{}) },
		]))).to_bool()
	}
	return true
}

fn (mut this Class_WP_REST_Font_Faces_Controller) get_item_permissions_check(var_request rt.PhpVal) bool {
	mut var_post := this.get_post(var_request.array_get(rt.new_string('id')))
	if rt.is_true(rt.call_function('is_wp_error', [var_post.clone()])) {
		return var_post.to_bool()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('read_post'),
		rt.get_property(var_post, 'ID'),
	])))))
	{
		return (create_wp_error(rt.new_string('rest_cannot_read'), rt.call_function('__', [
			rt.new_string('Sorry, you are not allowed to access this font face.'),
		]), rt.create_array([
			rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code',
				[]rt.PhpVal{}) },
		]))).to_bool()
	}
	return true
}

fn (mut this Class_WP_REST_Font_Faces_Controller) validate_create_font_face_settings(var_value rt.PhpVal, var_request rt.PhpVal) bool {
	mut var_value_mutated := var_value
	mut var_args := this.get_create_params()
	mut var_validity := rt.call_function('rest_validate_value_from_schema', [
		var_value_mutated.clone(), var_args.array_get(rt.new_string('font_face_settings')),
		rt.new_string('font_face_settings')])
	if rt.is_true(rt.call_function('is_wp_error', [var_validity.clone()])) {
		return var_validity.to_bool()
	}
	mut var_settings := rt.call_function('json_decode', [var_value_mutated.clone(),
		rt.new_bool(true)])
	if rt.is_true(rt.identical(rt.new_null(), var_settings)) {
		return (create_wp_error(rt.new_string('rest_invalid_param'), rt.call_function('__', [
			rt.new_string('font_face_settings parameter must be a valid JSON string.'),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }]))).to_bool()
	}
	mut var_schema :=
		this.get_item_schema().array_get(rt.new_string('properties')).array_get(rt.new_string('font_face_settings'))
	mut var_has_valid_settings := rt.call_function('rest_validate_value_from_schema', [
		var_settings.clone(),
		var_schema.clone(),
		rt.new_string('font_face_settings'),
	])
	if rt.is_true(rt.call_function('is_wp_error', [var_has_valid_settings.clone()])) {
		rt.call_method(var_has_valid_settings, 'add_data', [
			rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }]),
		])
		return var_has_valid_settings.to_bool()
	}
	mut var_required := var_schema.array_get(rt.new_string('required'))
	mut iter_1 := var_required.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_key := item_1.val
		if var_settings.array_isset(var_key)
			&& rt.is_true(rt.new_bool(!(rt.is_true(var_settings.array_get(var_key))))) {
			return (create_wp_error(rt.new_string('rest_invalid_param'), rt.call_function('sprintf', [
				rt.call_function('__', [rt.new_string('%s cannot be empty.')]),
				rt.new_string('font_face_setting[ ${var_key.to_string()} ]'),
			]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }]))).to_bool()
		}
	}
	mut var_srcs := if var_settings.array_get(rt.new_string('src')).is_array() { var_settings.array_get(rt.new_string('src')) } else { rt.create_array([
			rt.ArrayItem{ key: none, val: var_settings.array_get(rt.new_string('src')) },
		]) }
	mut var_files := rt.call_method(var_request, 'get_file_params', []rt.PhpVal{})
	mut iter_2 := var_srcs.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_src := item_2.val
		var_src = rt.new_string(var_src.clone().to_string().trim_left(' \t\n\r'))
		if !rt.is_true(var_src) {
			return (create_wp_error(rt.new_string('rest_invalid_param'), rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('%s values must be non-empty strings.'),
				]),
				rt.new_string('font_face_settings[src]'),
			]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }]))).to_bool()
		}
		if rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('wp_http_validate_url', [var_src.clone()])))
			&& !(var_files.array_isset(var_src)) {
			return (create_wp_error(rt.new_string('rest_invalid_param'), rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('%1$s value "%2$s" must be a valid URL or file reference.'),
				]),
				rt.new_string('font_face_settings[src]'),
				var_src.clone(),
			]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }]))).to_bool()
		}
	}
	mut iter_3 := rt.func_array_keys(var_files.clone()).iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_file := item_3.val
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
			var_file.clone(), var_srcs.clone(), rt.new_bool(true)])))))
		{
			return (create_wp_error(rt.new_string('rest_invalid_param'), rt.call_function('sprintf', [
				rt.call_function('__', [rt.new_string('File %1$s must be used in %2$s.')]),
				var_file.clone(),
				rt.new_string('font_face_settings[src]'),
			]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }]))).to_bool()
		}
	}
	return true
}

fn (mut this Class_WP_REST_Font_Faces_Controller) sanitize_font_face_settings(var_value rt.PhpVal) rt.PhpVal {
	mut var_value_mutated := var_value
	mut var_settings := rt.call_function('json_decode', [var_value_mutated.clone(),
		rt.new_bool(true)])
	mut var_schema :=
		this.get_item_schema().array_get(rt.new_string('properties')).array_get(rt.new_string('font_face_settings')).array_get(rt.new_string('properties'))
	mut iter_4 := var_settings.iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_value_shadow := item_4.val
		mut var_key := item_4.key
		mut var_sanitize_callback :=
			var_schema.array_get(var_key).array_get(rt.new_string('arg_options')).array_get(rt.new_string('sanitize_callback'))
		var_settings.array_set(var_key, rt.call_function('call_user_func', [
			var_sanitize_callback.clone(), var_value_shadow.clone()]))
	}
	return var_settings.clone()
}

fn (mut this Class_WP_REST_Font_Faces_Controller) get_items(var_request rt.PhpVal) rt.PhpVal {
	mut var_font_family :=
		this.get_parent_font_family_post(var_request.array_get(rt.new_string('font_family_id')))
	if rt.is_true(rt.call_function('is_wp_error', [var_font_family.clone()])) {
		return var_font_family.clone()
	}
	return this.Class_WP_REST_Posts_Controller.get_items(var_request.clone())
}

fn (mut this Class_WP_REST_Font_Faces_Controller) get_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_post := this.get_post(var_request.array_get(rt.new_string('id')))
	if rt.is_true(rt.call_function('is_wp_error', [var_post.clone()])) {
		return var_post.clone()
	}
	mut var_font_family :=
		this.get_parent_font_family_post(var_request.array_get(rt.new_string('font_family_id')))
	if rt.is_true(rt.call_function('is_wp_error', [var_font_family.clone()])) {
		return var_font_family.clone()
	}
	if rt.is_true(rt.new_bool(rt.new_int((rt.get_property(var_font_family, 'ID')).to_i64()) != rt.new_int((rt.get_property(var_post,
		'post_parent')).to_i64())))
	{
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('rest_font_face_parent_id_mismatch'), rt.call_function('sprintf', [
			rt.call_function('__', [
				rt.new_string('The font face does not belong to the specified font family with id of "%d".'),
			]),
			rt.get_property(var_font_family, 'ID'),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 404 }])))
	}
	return this.Class_WP_REST_Posts_Controller.get_item(var_request.clone())
}

fn (mut this Class_WP_REST_Font_Faces_Controller) create_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_font_family :=
		this.get_parent_font_family_post(var_request.array_get(rt.new_string('font_family_id')))
	if rt.is_true(rt.call_function('is_wp_error', [var_font_family.clone()])) {
		return var_font_family.clone()
	}
	mut var_settings := rt.call_method(var_request, 'get_param', [
		rt.new_string('font_face_settings'),
	])
	mut var_file_params := rt.call_method(var_request, 'get_file_params', []rt.PhpVal{})
	mut iife_temp_0 := Class_WP_Font_Utils{}
	mut iife_result_0 := iife_temp_0.get_font_face_slug(var_settings.clone())
	mut var_query := create_wp_query(rt.create_array([
		rt.ArrayItem{ key: 'post_type', val: rt.get_property(rt.new_object('WP_REST_Font_Faces_Controller', [
			'WP_REST_Posts_Controller',
		], &this), 'post_type') },
		rt.ArrayItem{ key: 'posts_per_page', val: 1 },
		rt.ArrayItem{ key: 'title', val: iife_result_0 },
		rt.ArrayItem{ key: 'update_post_meta_cache', val: false },
		rt.ArrayItem{ key: 'update_post_term_cache', val: false },
	]))
	if !(!rt.is_true(rt.get_property(var_query, 'posts'))) {
		return create_wp_error(rt.new_string('rest_duplicate_font_face'), rt.call_function('__', [
			rt.new_string('A font face matching those settings already exists.'),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }]))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('wp_handle_upload'),
	])))))
	{
		rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/file.php', '4')
	}
	mut var_srcs := if var_settings.array_get(rt.new_string('src')).is_string() { rt.create_array([
			rt.ArrayItem{ key: none, val: var_settings.array_get(rt.new_string('src')) },
		]) } else { var_settings.array_get(rt.new_string('src')) }
	mut var_processed_srcs := []rt.PhpVal{}
	mut var_font_file_meta := []rt.PhpVal{}
	mut iter_5 := var_srcs.iterator()
	for {
		item_5 := iter_5.next() or { break }
		mut var_src := item_5.val
		if !(var_file_params.array_isset(var_src)) {
			var_processed_srcs << var_src.clone()
			continue
		}
		mut var_file := var_file_params.array_get(var_src)
		mut var_font_file := this.handle_font_file_upload(var_file.clone())
		if rt.is_true(rt.call_function('is_wp_error', [var_font_file.clone()])) {
			return var_font_file.clone()
		}
		var_processed_srcs << var_font_file.array_get(rt.new_string('url'))
		var_font_file_meta << this.relative_fonts_path(var_font_file.array_get(rt.new_string('file')))
	}
	var_settings.array_set('src', if var_processed_srcs.len == 1 {
		var_processed_srcs[0]
	} else {
		var_processed_srcs
	})
	rt.call_method(var_request, 'set_param', [rt.new_string('font_face_settings'),
		var_settings.clone()])
	mut var_font_face_post := this.Class_WP_REST_Posts_Controller.create_item(var_request.clone())
	if rt.is_true(rt.call_function('is_wp_error', [var_font_face_post.clone()])) {
		return var_font_face_post.clone()
	}
	mut var_font_face_id :=
		rt.get_property(var_font_face_post, 'data').array_get(rt.new_string('id'))
	for var_font_file_path in var_font_file_meta {
		rt.call_function('add_post_meta', [var_font_face_id.clone(),
			rt.new_string('_wp_font_face_file'), var_font_file_path.clone()])
	}
	return var_font_face_post.clone()
}

fn (mut this Class_WP_REST_Font_Faces_Controller) delete_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_post := this.get_post(var_request.array_get(rt.new_string('id')))
	if rt.is_true(rt.call_function('is_wp_error', [var_post.clone()])) {
		return var_post.clone()
	}
	mut var_font_family :=
		this.get_parent_font_family_post(var_request.array_get(rt.new_string('font_family_id')))
	if rt.is_true(rt.call_function('is_wp_error', [var_font_family.clone()])) {
		return var_font_family.clone()
	}
	if rt.is_true(rt.new_bool(rt.new_int((rt.get_property(var_font_family, 'ID')).to_i64()) != rt.new_int((rt.get_property(var_post,
		'post_parent')).to_i64())))
	{
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('rest_font_face_parent_id_mismatch'), rt.call_function('sprintf', [
			rt.call_function('__', [
				rt.new_string('The font face does not belong to the specified font family with id of "%d".'),
			]),
			rt.get_property(var_font_family, 'ID'),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 404 }])))
	}
	mut var_force := rt.new_bool(if var_request.array_isset(rt.new_string('force')) {
		(var_request.array_get(rt.new_string('force'))).to_bool()
	} else {
		false
	})
	if rt.is_true(rt.new_bool(!(rt.is_true(var_force)))) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('rest_trash_not_supported'), rt.call_function('sprintf', [
			rt.call_function('__', [
				rt.new_string('Font faces do not support trashing. Set "%s" to delete.'),
			]),
			rt.new_string('force=true'),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 501 }])))
	}
	return this.Class_WP_REST_Posts_Controller.delete_item(var_request.clone())
}

fn (mut this Class_WP_REST_Font_Faces_Controller) prepare_item_for_response(var_item rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
	mut var_fields := this.get_fields_for_response(var_request.clone())
	mut var_data := []rt.PhpVal{}
	if rt.is_true(rt.call_function('rest_is_field_included', [
		rt.new_string('id'), var_fields.clone()]))
	{
		var_data.array_set('id', rt.get_property(var_item, 'ID'))
	}
	if rt.is_true(rt.call_function('rest_is_field_included', [
		rt.new_string('theme_json_version'),
		var_fields.clone(),
	]))
	{
		var_data.array_set('theme_json_version', Class_static.latest_theme_json_version_supported())
	}
	if rt.is_true(rt.call_function('rest_is_field_included', [
		rt.new_string('parent'), var_fields.clone()]))
	{
		var_data.array_set('parent', rt.get_property(var_item, 'post_parent'))
	}
	if rt.is_true(rt.call_function('rest_is_field_included', [
		rt.new_string('font_face_settings'),
		var_fields.clone(),
	]))
	{
		var_data.array_set('font_face_settings', this.get_settings_from_post(var_item.clone()))
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
	}
	return rt.call_function('apply_filters', [rt.new_string('rest_prepare_wp_font_face'),
		var_response.clone(), var_item.clone(), var_request.clone()])
}

fn (mut this Class_WP_REST_Font_Faces_Controller) get_item_schema() rt.PhpVal {
	if rt.is_true(rt.get_property(rt.new_object('WP_REST_Font_Faces_Controller', [
		'WP_REST_Posts_Controller',
	], &this), 'schema'))
	{
		return this.add_additional_fields_schema(rt.get_property(rt.new_object('WP_REST_Font_Faces_Controller', [
			'WP_REST_Posts_Controller',
		], &this), 'schema'))
	}
	closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_value := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return if var_value.clone().is_array() { rt.call_function('array_map', [
				rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Font_Faces_Controller', [
						'WP_REST_Posts_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'sanitize_src' },
				]),
				var_value.clone(),
			]) } else { this.sanitize_src(var_value.clone()) }
	}
	mut var_schema := rt.create_array([
		rt.ArrayItem{ key: '$schema', val: 'http://json-schema.org/draft-04/schema#' },
		rt.ArrayItem{ key: 'title', val: rt.get_property(rt.new_object('WP_REST_Font_Faces_Controller', [
			'WP_REST_Posts_Controller',
		], &this), 'post_type') },
		rt.ArrayItem{ key: 'type', val: 'object' },
		rt.ArrayItem{ key: 'properties', val: rt.create_array([
			rt.ArrayItem{ key: 'id', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Unique identifier for the post.'),
					rt.new_string('default'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'integer' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
					rt.ArrayItem{ key: none, val: 'embed' },
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
			]) },
			rt.ArrayItem{ key: 'theme_json_version', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Version of the theme.json schema used for the typography settings.'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'integer' },
				rt.ArrayItem{
					key: 'default'
					val: Class_static.latest_theme_json_version_supported()
				},
				rt.ArrayItem{ key: 'minimum', val: 2 },
				rt.ArrayItem{
					key: 'maximum'
					val: Class_static.latest_theme_json_version_supported()
				},
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
					rt.ArrayItem{ key: none, val: 'embed' },
				]) },
			]) },
			rt.ArrayItem{ key: 'parent', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('The ID for the parent font family of the font face.'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'integer' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
					rt.ArrayItem{ key: none, val: 'embed' },
				]) },
			]) },
			rt.ArrayItem{ key: 'font_face_settings', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('font-face declaration in theme.json format.'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'object' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
					rt.ArrayItem{ key: none, val: 'embed' },
				]) },
				rt.ArrayItem{ key: 'properties', val: rt.create_array([
					rt.ArrayItem{ key: 'fontFamily', val: rt.create_array([
						rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
							rt.new_string('CSS font-family value.'),
						]) },
						rt.ArrayItem{ key: 'type', val: 'string' },
						rt.ArrayItem{ key: 'default', val: '' },
						rt.ArrayItem{ key: 'arg_options', val: rt.create_array([
							rt.ArrayItem{ key: 'sanitize_callback', val: rt.create_array([
								rt.ArrayItem{ key: none, val: 'WP_Font_Utils' },
								rt.ArrayItem{ key: none, val: 'sanitize_font_family' },
							]) },
						]) },
					]) },
					rt.ArrayItem{ key: 'fontStyle', val: rt.create_array([
						rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
							rt.new_string('CSS font-style value.'),
						]) },
						rt.ArrayItem{ key: 'type', val: 'string' },
						rt.ArrayItem{ key: 'default', val: 'normal' },
						rt.ArrayItem{ key: 'arg_options', val: rt.create_array([
							rt.ArrayItem{ key: 'sanitize_callback', val: 'sanitize_text_field' },
						]) },
					]) },
					rt.ArrayItem{ key: 'fontWeight', val: rt.create_array([
						rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
							rt.new_string('List of available font weights, separated by a space.'),
						]) },
						rt.ArrayItem{ key: 'default', val: '400' },
						rt.ArrayItem{ key: 'type', val: rt.create_array([
							rt.ArrayItem{ key: none, val: 'string' },
							rt.ArrayItem{ key: none, val: 'integer' },
						]) },
						rt.ArrayItem{ key: 'arg_options', val: rt.create_array([
							rt.ArrayItem{ key: 'sanitize_callback', val: 'sanitize_text_field' },
						]) },
					]) },
					rt.ArrayItem{ key: 'fontDisplay', val: rt.create_array([
						rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
							rt.new_string('CSS font-display value.'),
						]) },
						rt.ArrayItem{ key: 'type', val: 'string' },
						rt.ArrayItem{ key: 'default', val: 'fallback' },
						rt.ArrayItem{ key: 'enum', val: rt.create_array([
							rt.ArrayItem{ key: none, val: 'auto' },
							rt.ArrayItem{ key: none, val: 'block' },
							rt.ArrayItem{ key: none, val: 'fallback' },
							rt.ArrayItem{ key: none, val: 'swap' },
							rt.ArrayItem{ key: none, val: 'optional' },
						]) },
						rt.ArrayItem{ key: 'arg_options', val: rt.create_array([
							rt.ArrayItem{ key: 'sanitize_callback', val: 'sanitize_text_field' },
						]) },
					]) },
					rt.ArrayItem{ key: 'src', val: rt.create_array([
						rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
							rt.new_string('Paths or URLs to the font files.'),
						]) },
						rt.ArrayItem{ key: 'anyOf', val: rt.create_array([
							rt.ArrayItem{ key: none, val: rt.create_array([
								rt.ArrayItem{ key: 'type', val: 'string' },
							]) },
							rt.ArrayItem{ key: none, val: rt.create_array([
								rt.ArrayItem{ key: 'type', val: 'array' },
								rt.ArrayItem{ key: 'items', val: rt.create_array([
									rt.ArrayItem{ key: 'type', val: 'string' },
								]) },
							]) },
						]) },
						rt.ArrayItem{ key: 'default', val: []rt.PhpVal{} },
						rt.ArrayItem{ key: 'arg_options', val: rt.create_array([
							rt.ArrayItem{
								key: 'sanitize_callback'
								val: rt.new_closure(closure_2_fn)
							},
						]) },
					]) },
					rt.ArrayItem{ key: 'fontStretch', val: rt.create_array([
						rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
							rt.new_string('CSS font-stretch value.'),
						]) },
						rt.ArrayItem{ key: 'type', val: 'string' },
						rt.ArrayItem{ key: 'arg_options', val: rt.create_array([
							rt.ArrayItem{ key: 'sanitize_callback', val: 'sanitize_text_field' },
						]) },
					]) },
					rt.ArrayItem{ key: 'ascentOverride', val: rt.create_array([
						rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
							rt.new_string('CSS ascent-override value.'),
						]) },
						rt.ArrayItem{ key: 'type', val: 'string' },
						rt.ArrayItem{ key: 'arg_options', val: rt.create_array([
							rt.ArrayItem{ key: 'sanitize_callback', val: 'sanitize_text_field' },
						]) },
					]) },
					rt.ArrayItem{ key: 'descentOverride', val: rt.create_array([
						rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
							rt.new_string('CSS descent-override value.'),
						]) },
						rt.ArrayItem{ key: 'type', val: 'string' },
						rt.ArrayItem{ key: 'arg_options', val: rt.create_array([
							rt.ArrayItem{ key: 'sanitize_callback', val: 'sanitize_text_field' },
						]) },
					]) },
					rt.ArrayItem{ key: 'fontVariant', val: rt.create_array([
						rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
							rt.new_string('CSS font-variant value.'),
						]) },
						rt.ArrayItem{ key: 'type', val: 'string' },
						rt.ArrayItem{ key: 'arg_options', val: rt.create_array([
							rt.ArrayItem{ key: 'sanitize_callback', val: 'sanitize_text_field' },
						]) },
					]) },
					rt.ArrayItem{ key: 'fontFeatureSettings', val: rt.create_array([
						rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
							rt.new_string('CSS font-feature-settings value.'),
						]) },
						rt.ArrayItem{ key: 'type', val: 'string' },
						rt.ArrayItem{ key: 'arg_options', val: rt.create_array([
							rt.ArrayItem{ key: 'sanitize_callback', val: 'sanitize_text_field' },
						]) },
					]) },
					rt.ArrayItem{ key: 'fontVariationSettings', val: rt.create_array([
						rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
							rt.new_string('CSS font-variation-settings value.'),
						]) },
						rt.ArrayItem{ key: 'type', val: 'string' },
						rt.ArrayItem{ key: 'arg_options', val: rt.create_array([
							rt.ArrayItem{ key: 'sanitize_callback', val: 'sanitize_text_field' },
						]) },
					]) },
					rt.ArrayItem{ key: 'lineGapOverride', val: rt.create_array([
						rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
							rt.new_string('CSS line-gap-override value.'),
						]) },
						rt.ArrayItem{ key: 'type', val: 'string' },
						rt.ArrayItem{ key: 'arg_options', val: rt.create_array([
							rt.ArrayItem{ key: 'sanitize_callback', val: 'sanitize_text_field' },
						]) },
					]) },
					rt.ArrayItem{ key: 'sizeAdjust', val: rt.create_array([
						rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
							rt.new_string('CSS size-adjust value.'),
						]) },
						rt.ArrayItem{ key: 'type', val: 'string' },
						rt.ArrayItem{ key: 'arg_options', val: rt.create_array([
							rt.ArrayItem{ key: 'sanitize_callback', val: 'sanitize_text_field' },
						]) },
					]) },
					rt.ArrayItem{ key: 'unicodeRange', val: rt.create_array([
						rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
							rt.new_string('CSS unicode-range value.'),
						]) },
						rt.ArrayItem{ key: 'type', val: 'string' },
						rt.ArrayItem{ key: 'arg_options', val: rt.create_array([
							rt.ArrayItem{ key: 'sanitize_callback', val: 'sanitize_text_field' },
						]) },
					]) },
					rt.ArrayItem{ key: 'preview', val: rt.create_array([
						rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
							rt.new_string('URL to a preview image of the font face.'),
						]) },
						rt.ArrayItem{ key: 'type', val: 'string' },
						rt.ArrayItem{ key: 'format', val: 'uri' },
						rt.ArrayItem{ key: 'default', val: '' },
						rt.ArrayItem{ key: 'arg_options', val: rt.create_array([
							rt.ArrayItem{ key: 'sanitize_callback', val: 'sanitize_url' },
						]) },
					]) },
				]) },
				rt.ArrayItem{ key: 'required', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'fontFamily' },
					rt.ArrayItem{ key: none, val: 'src' },
				]) },
				rt.ArrayItem{ key: 'additionalProperties', val: false },
			]) },
		]) },
	])
	this.dispatch_set_prop('schema', var_schema.clone())
	return this.add_additional_fields_schema(rt.get_property(rt.new_object('WP_REST_Font_Faces_Controller', [
		'WP_REST_Posts_Controller',
	], &this), 'schema'))
}

fn (mut this Class_WP_REST_Font_Faces_Controller) get_public_item_schema() rt.PhpVal {
	mut var_schema := this.Class_WP_REST_Posts_Controller.get_public_item_schema()
	mut iter_6 :=
		var_schema.array_get(rt.new_string('properties')).array_get(rt.new_string('font_face_settings')).array_get(rt.new_string('properties')).iterator()
	for {
		item_6 := iter_6.next() or { break }
		mut var_property := item_6.val
		var_property.array_unset(rt.new_string('arg_options'))
	}
	return var_schema.clone()
}

fn (mut this Class_WP_REST_Font_Faces_Controller) get_collection_params() rt.PhpVal {
	mut var_query_params := this.Class_WP_REST_Posts_Controller.get_collection_params()
	var_query_params.array_unset(rt.new_string('after'))
	var_query_params.array_unset(rt.new_string('modified_after'))
	var_query_params.array_unset(rt.new_string('before'))
	var_query_params.array_unset(rt.new_string('modified_before'))
	var_query_params.array_unset(rt.new_string('search'))
	var_query_params.array_unset(rt.new_string('search_columns'))
	var_query_params.array_unset(rt.new_string('slug'))
	var_query_params.array_unset(rt.new_string('status'))
	var_query_params.array_get_mut('orderby').array_set('default', 'id')
	var_query_params.array_get_mut('orderby').array_set('enum', rt.create_array([
		rt.ArrayItem{ key: none, val: 'id' },
		rt.ArrayItem{ key: none, val: 'include' },
	]))
	return rt.call_function('apply_filters', [
		rt.new_string('rest_wp_font_face_collection_params'),
		var_query_params.clone(),
	])
}

fn (mut this Class_WP_REST_Font_Faces_Controller) get_create_params() rt.PhpVal {
	mut var_properties := this.get_item_schema().array_get(rt.new_string('properties'))
	return rt.create_array([
		rt.ArrayItem{
			key: 'theme_json_version'
			val: var_properties.array_get(rt.new_string('theme_json_version'))
		},
		rt.ArrayItem{ key: 'font_face_settings', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('font-face declaration in theme.json format, encoded as a string.'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'string' },
			rt.ArrayItem{ key: 'required', val: true },
			rt.ArrayItem{ key: 'validate_callback', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Font_Faces_Controller', [
					'WP_REST_Posts_Controller',
				], &this) },
				rt.ArrayItem{ key: none, val: 'validate_create_font_face_settings' },
			]) },
			rt.ArrayItem{ key: 'sanitize_callback', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Font_Faces_Controller', [
					'WP_REST_Posts_Controller',
				], &this) },
				rt.ArrayItem{ key: none, val: 'sanitize_font_face_settings' },
			]) },
		]) },
	])
}

fn (mut this Class_WP_REST_Font_Faces_Controller) get_parent_font_family_post(var_font_family_id rt.PhpVal) rt.PhpVal {
	mut var_error := create_wp_error(rt.new_string('rest_post_invalid_parent'), rt.call_function('__', [
		rt.new_string('Invalid post parent ID.'),
		rt.new_string('default'),
	]), rt.create_array([rt.ArrayItem{ key: 'status', val: 404 }]))
	if rt.new_int(var_font_family_id.to_i64()) <= 0 {
		return mut var_error
	}
	mut var_font_family_post := rt.call_function('get_post', [
		rt.new_int(var_font_family_id.to_i64()),
	])
	if !rt.is_true(var_font_family_post) || !rt.is_true(rt.get_property(var_font_family_post, 'ID'))
		|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('wp_font_family'), rt.get_property(var_font_family_post, 'post_type'))))) {
		return mut var_error
	}
	return mut rt.cast_object_ptr[Class_WP_Error](var_font_family_post)
}

fn (mut this Class_WP_REST_Font_Faces_Controller) prepare_links(var_post rt.PhpVal) rt.PhpVal {
	mut var_post_mutated := var_post
	return rt.create_array([
		rt.ArrayItem{ key: 'self', val: rt.create_array([
			rt.ArrayItem{ key: 'href', val: rt.call_function('rest_url', [
				rt.new_string(
					(rt.get_property(rt.new_object('WP_REST_Font_Faces_Controller', ['WP_REST_Posts_Controller'], &this), 'namespace')).str() +
					'/font-families/' + (rt.get_property(var_post_mutated, 'post_parent')).str() +
					'/font-faces/' + (rt.get_property(var_post_mutated, 'ID')).str()),
			]) },
		]) },
		rt.ArrayItem{ key: 'collection', val: rt.create_array([
			rt.ArrayItem{ key: 'href', val: rt.call_function('rest_url', [
				rt.new_string(
					(rt.get_property(rt.new_object('WP_REST_Font_Faces_Controller', ['WP_REST_Posts_Controller'], &this), 'namespace')).str() +
					'/font-families/' + (rt.get_property(var_post_mutated, 'post_parent')).str() +
					'/font-faces'),
			]) },
		]) },
		rt.ArrayItem{ key: 'parent', val: rt.create_array([
			rt.ArrayItem{ key: 'href', val: rt.call_function('rest_url', [
				rt.new_string(
					(rt.get_property(rt.new_object('WP_REST_Font_Faces_Controller', ['WP_REST_Posts_Controller'], &this), 'namespace')).str() +
					'/font-families/' + (rt.get_property(var_post_mutated, 'post_parent')).str()),
			]) },
		]) },
	])
}

fn (mut this Class_WP_REST_Font_Faces_Controller) prepare_item_for_database(var_request rt.PhpVal) rt.PhpVal {
	mut var_prepared_post := create_stdclass()
	mut var_settings := rt.call_method(var_request, 'get_param', [
		rt.new_string('font_face_settings'),
	])
	mut iife_temp_2 := Class_WP_Font_Utils{}
	mut iife_result_2 := iife_temp_2.get_font_face_slug(var_settings.clone())
	mut var_title := iife_result_2
	rt.set_property(var_prepared_post, 'post_type', rt.get_property(rt.new_object('WP_REST_Font_Faces_Controller', [
		'WP_REST_Posts_Controller',
	], &this), 'post_type'))
	rt.set_property(var_prepared_post, 'post_parent',
		var_request.array_get(rt.new_string('font_family_id')))
	rt.set_property(var_prepared_post, 'post_status', rt.new_string('publish'))
	rt.set_property(var_prepared_post, 'post_title', var_title.clone())
	rt.set_property(var_prepared_post, 'post_name', rt.call_function('sanitize_title', [
		var_title.clone(),
	]))
	rt.set_property(var_prepared_post, 'post_content', rt.call_function('wp_json_encode', [
		var_settings.clone(),
	]))
	return mut var_prepared_post
}

fn (mut this Class_WP_REST_Font_Faces_Controller) sanitize_src(var_value rt.PhpVal) rt.PhpVal {
	mut var_value_mutated := var_value
	var_value_mutated = rt.new_string(var_value_mutated.clone().to_string().trim_left(' \t\n\r'))
	return if rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('wp_http_validate_url', [
		var_value_mutated.clone(),
	])))
	{ var_value_mutated.str() } else { rt.call_function('sanitize_url', [
			var_value_mutated.clone()]) }
}

fn (mut this Class_WP_REST_Font_Faces_Controller) handle_font_file_upload(var_file rt.PhpVal) rt.PhpVal {
	mut var_file_mutated := var_file
	rt.call_function('add_filter', [rt.new_string('upload_mimes'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'WP_Font_Utils' },
			rt.ArrayItem{ key: none, val: 'get_allowed_font_mime_types' }])])
	rt.call_function('add_filter', [rt.new_string('upload_dir'),
		rt.new_string('_wp_filter_font_directory')])
	mut iife_temp_3 := Class_WP_Font_Utils{}
	mut iife_result_3 := iife_temp_3.get_allowed_font_mime_types()
	mut var_overrides := {
		'upload_error_handler': map[string]rt.PhpVal{}
		'test_form':            rt.new_bool(false)
		'mimes':                iife_result_3
	}
	if rt.is_true(rt.call_function('defined', [rt.new_string('DIR_TESTDATA')]))
		&& rt.is_true(rt.get_constant('DIR_TESTDATA')) {
		var_overrides['action'] = rt.new_string('wp_handle_mock_upload')
	}
	mut var_uploaded_file := rt.call_function('wp_handle_upload', [
		var_file_mutated.clone(), rt.create_array_from_native_map(var_overrides)])
	rt.call_function('remove_filter', [rt.new_string('upload_dir'),
		rt.new_string('_wp_filter_font_directory')])
	rt.call_function('remove_filter', [rt.new_string('upload_mimes'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'WP_Font_Utils' },
			rt.ArrayItem{ key: none, val: 'get_allowed_font_mime_types' }])])
	return var_uploaded_file.clone()
}

fn (mut this Class_WP_REST_Font_Faces_Controller) handle_font_file_upload_error(var_file rt.PhpVal, var_message rt.PhpVal) rt.PhpVal {
	mut var_file_mutated := var_file
	mut var_status := rt.new_int(500)
	mut var_code := rt.new_string('rest_font_upload_unknown_error')
	if rt.is_true(rt.identical(rt.call_function('__', [
		rt.new_string('Sorry, you are not allowed to upload this file type.'),
	]), var_message))
	{
		var_status = rt.new_int(400)
		var_code = rt.new_string('rest_font_upload_invalid_file_type')
	}
	return rt.new_object('WP_Error', []string{}, create_wp_error(var_code.clone(),
		var_message.clone(), rt.create_array([
		rt.ArrayItem{ key: 'status', val: var_status },
	])))
}

fn (mut this Class_WP_REST_Font_Faces_Controller) relative_fonts_path(var_path rt.PhpVal) rt.PhpVal {
	mut var_new_path := var_path
	mut var_fonts_dir := rt.call_function('wp_get_font_dir', []rt.PhpVal{})
	if rt.is_true(rt.call_function('str_starts_with', [var_new_path.clone(),
		var_fonts_dir.array_get(rt.new_string('basedir'))]))
	{
		var_new_path = rt.call_function('str_replace', [
			var_fonts_dir.array_get(rt.new_string('basedir')),
			rt.new_string(''),
			var_new_path.clone(),
		])
		var_new_path = rt.new_string(var_new_path.clone().to_string().trim_left(' \t\n\r'))
	}
	return var_new_path.clone()
}

fn (mut this Class_WP_REST_Font_Faces_Controller) get_settings_from_post(var_post rt.PhpVal) rt.PhpVal {
	mut var_post_mutated := var_post
	mut var_settings := rt.call_function('json_decode', [
		rt.get_property(var_post_mutated, 'post_content'),
		rt.new_bool(true),
	])
	mut var_properties :=
		this.get_item_schema().array_get(rt.new_string('properties')).array_get(rt.new_string('font_face_settings')).array_get(rt.new_string('properties'))
	if rt.is_true(rt.identical(rt.new_null(), var_settings)) {
		var_settings = rt.create_array([rt.ArrayItem{ key: 'fontFamily', val: '' },
			rt.ArrayItem{ key: 'src', val: []rt.PhpVal{} }])
	}
	return rt.call_function('array_intersect_key', [var_settings.clone(),
		var_properties.clone()])
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

struct Class_stdClass {
	rt.PhpObjectBase
}

fn create_wp_rest_font_faces_controller(_args ...rt.PhpVal) &Class_WP_REST_Font_Faces_Controller {
	mut obj := &Class_WP_REST_Font_Faces_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
		allow_batch:   rt.new_bool(false)
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

fn create_wp_query(_args ...rt.PhpVal) &Class_WP_Query {
	mut obj := &Class_WP_Query{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_font_utils(_args ...rt.PhpVal) &Class_WP_Font_Utils {
	mut obj := &Class_WP_Font_Utils{
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
			return rt.new_bool(this.validate_create_font_face_settings(dispatch_arg_0,
				dispatch_arg_1))
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
		else {
			return none
		}
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
		'allow_batch' {
			this.allow_batch = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
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

fn (mut this Class_stdClass) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_stdClass) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_stdClass) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
