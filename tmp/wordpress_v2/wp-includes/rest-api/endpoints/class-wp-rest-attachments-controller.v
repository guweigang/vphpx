import rt
import crypto.md5

struct Class_WP_REST_Attachments_Controller {
	rt.PhpObjectBase
pub mut:
	allow_batch rt.PhpVal = rt.new_bool(false)
}

fn (mut this Class_WP_REST_Attachments_Controller) register_routes() {
	this.Class_WP_REST_Posts_Controller.register_routes()
	rt.call_function('register_rest_route', [
		rt.get_property(rt.new_object('WP_REST_Attachments_Controller', [
			'WP_REST_Posts_Controller',
		], &this), 'namespace'),
		rt.new_string('/' +
			(rt.get_property(rt.new_object('WP_REST_Attachments_Controller', ['WP_REST_Posts_Controller'], &this), 'rest_base')).str() +
			'/(?P<id>[\\d]+)/post-process'),
		rt.create_array([
			rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.creatable() },
			rt.ArrayItem{ key: 'callback', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Attachments_Controller', [
					'WP_REST_Posts_Controller',
				], &this) },
				rt.ArrayItem{ key: none, val: 'post_process_item' },
			]) },
			rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Attachments_Controller', [
					'WP_REST_Posts_Controller',
				], &this) },
				rt.ArrayItem{ key: none, val: 'post_process_item_permissions_check' },
			]) },
			rt.ArrayItem{ key: 'args', val: rt.create_array([
				rt.ArrayItem{ key: 'id', val: rt.create_array([
					rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
						rt.new_string('Unique identifier for the attachment.'),
					]) },
					rt.ArrayItem{ key: 'type', val: 'integer' },
				]) },
				rt.ArrayItem{ key: 'action', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'enum', val: rt.create_array([
						rt.ArrayItem{ key: none, val: 'create-image-subsizes' },
					]) },
					rt.ArrayItem{ key: 'required', val: true },
				]) },
			]) },
		]),
	])
	rt.call_function('register_rest_route', [
		rt.get_property(rt.new_object('WP_REST_Attachments_Controller', [
			'WP_REST_Posts_Controller',
		], &this), 'namespace'),
		rt.new_string('/' +
			(rt.get_property(rt.new_object('WP_REST_Attachments_Controller', ['WP_REST_Posts_Controller'], &this), 'rest_base')).str() +
			'/(?P<id>[\\d]+)/edit'),
		rt.create_array([
			rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.creatable() },
			rt.ArrayItem{ key: 'callback', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Attachments_Controller', [
					'WP_REST_Posts_Controller',
				], &this) },
				rt.ArrayItem{ key: none, val: 'edit_media_item' },
			]) },
			rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Attachments_Controller', [
					'WP_REST_Posts_Controller',
				], &this) },
				rt.ArrayItem{ key: none, val: 'edit_media_item_permissions_check' },
			]) },
			rt.ArrayItem{ key: 'args', val: this.get_edit_media_item_args() },
		]),
	])
}

fn (mut this Class_WP_REST_Attachments_Controller) prepare_items_query(var_prepared_args rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
	mut var_request_mutated := var_request
	mut var_query_args := this.Class_WP_REST_Posts_Controller.prepare_items_query(var_prepared_args.clone(),
		var_request_mutated.clone())
	if !rt.is_true(var_query_args.array_get(rt.new_string('post_status'))) {
		var_query_args.array_set('post_status', 'inherit')
	}
	mut var_all_mime_types := rt.new_array()
	mut var_media_types := this.get_media_types()
	if !(!rt.is_true(var_request_mutated.array_get(rt.new_string('media_type'))))
		&& var_request_mutated.array_get(rt.new_string('media_type')).is_array() {
		mut iter_1 := var_request_mutated.array_get(rt.new_string('media_type')).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_type := item_1.val
			if var_media_types.array_isset(var_type) {
				var_all_mime_types = rt.call_function('array_merge', [
					var_all_mime_types.clone(), var_media_types.array_get(var_type)])
			}
		}
	}
	if !(!rt.is_true(var_request_mutated.array_get(rt.new_string('mime_type'))))
		&& var_request_mutated.array_get(rt.new_string('mime_type')).is_array() {
		mut iter_2 := var_request_mutated.array_get(rt.new_string('mime_type')).iterator()
		for {
			item_2 := iter_2.next() or { break }
			mut var_mime_type := item_2.val
			mut var_parts := rt.call_function('explode', [rt.new_string('/'),
				var_mime_type.clone()])
			if var_media_types.array_isset(var_parts.array_get(rt.new_int(0)))
				&& rt.is_true(rt.call_function('in_array', [var_mime_type.clone(), var_media_types.array_get(var_parts.array_get(rt.new_int(0))), rt.new_bool(true)])) {
				var_all_mime_types.array_push(var_mime_type.clone())
			}
		}
	}
	if !(!rt.is_true(var_all_mime_types)) {
		var_query_args.array_set('post_mime_type', rt.call_function('array_values', [
			rt.call_function('array_unique', [var_all_mime_types.clone()]),
		]))
	}
	if var_query_args.array_isset(rt.new_string('s')) {
		rt.call_function('add_filter', [
			rt.new_string('wp_allow_query_attachment_by_filename'),
			rt.new_string('__return_true'),
		])
	}
	return var_query_args.clone()
}

fn (mut this Class_WP_REST_Attachments_Controller) create_item_permissions_check(var_request rt.PhpVal) bool {
	mut var_request_mutated := var_request
	mut var_ret :=
		this.Class_WP_REST_Posts_Controller.create_item_permissions_check(var_request_mutated.clone())
	if rt.is_true(rt.new_bool(!(rt.is_true(var_ret))))
		|| rt.is_true(rt.call_function('is_wp_error', [var_ret.clone()])) {
		return var_ret.to_bool()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('upload_files'),
	])))))
	{
		return (create_wp_error(rt.new_string('rest_cannot_create'), rt.call_function('__', [
			rt.new_string('Sorry, you are not allowed to upload media on this site.'),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }]))).to_bool()
	}
	if !(!rt.is_true(var_request_mutated.array_get(rt.new_string('post'))))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_post'), rt.new_int((var_request_mutated.array_get(rt.new_string('post'))).to_i64())]))))) {
		return (create_wp_error(rt.new_string('rest_cannot_edit'), rt.call_function('__', [
			rt.new_string('Sorry, you are not allowed to upload media to this post.'),
		]), rt.create_array([
			rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code',
				[]rt.PhpVal{}) },
		]))).to_bool()
	}
	mut var_files := rt.call_method(var_request_mutated, 'get_file_params', []rt.PhpVal{})
	mut var_prevent_unsupported_uploads := rt.call_function('apply_filters', [
		rt.new_string('wp_prevent_unsupported_mime_type_uploads'),
		rt.new_bool(true),
		if !(var_files.array_get(rt.new_string('file')).array_get(rt.new_string('type'))).is_null() {
			var_files.array_get(rt.new_string('file')).array_get(rt.new_string('type'))
		} else {
			rt.new_null()
		},
	])
	if rt.is_true(var_prevent_unsupported_uploads)
		&& var_files.array_get(rt.new_string('file')).array_isset(rt.new_string('type'))
		&& rt.is_true(rt.call_function('str_starts_with', [var_files.array_get(rt.new_string('file')).array_get(rt.new_string('type')), rt.new_string('image/')])) {
		mut var_editor_non_resizable_formats := ['image/svg+xml']
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_files.array_get(rt.new_string('file')).array_get(rt.new_string('type')), rt.create_array_from_list(var_editor_non_resizable_formats), rt.new_bool(true)])))))
			&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_image_editor_supports', [rt.create_array([rt.ArrayItem{
			key: 'mime_type'
			val: var_files.array_get(rt.new_string('file')).array_get(rt.new_string('type'))
		}])]))))) {
			return (create_wp_error(rt.new_string('rest_upload_image_type_not_supported'), rt.call_function('__', [
				rt.new_string('The web server cannot generate responsive image sizes for this image. Convert it to JPEG or PNG before uploading.'),
			]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }]))).to_bool()
		}
	}
	return true
}

fn (mut this Class_WP_REST_Attachments_Controller) create_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_request_mutated := var_request
	if !(!rt.is_true(var_request_mutated.array_get(rt.new_string('post'))))
		&& rt.is_true(rt.call_function('in_array', [rt.call_function('get_post_type', [var_request_mutated.array_get(rt.new_string('post'))]), rt.create_array([rt.ArrayItem{
		key: none
		val: 'revision'
	}, rt.ArrayItem{ key: none, val: 'attachment' }]), rt.new_bool(true)])) {
		return create_wp_error(rt.new_string('rest_invalid_param'), rt.call_function('__', [
			rt.new_string('Invalid parent type.'),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }]))
	}
	mut var_insert := this.insert_attachment(var_request_mutated.clone())
	if rt.is_true(rt.call_function('is_wp_error', [var_insert.clone()])) {
		return var_insert.clone()
	}
	mut var_schema := this.get_item_schema()
	mut var_attachment_id := var_insert.array_get(rt.new_string('attachment_id'))
	mut var_file := var_insert.array_get(rt.new_string('file'))
	if var_request_mutated.array_isset(rt.new_string('alt_text')) {
		rt.call_function('update_post_meta', [var_attachment_id.clone(),
			rt.new_string('_wp_attachment_image_alt'),
			rt.call_function('sanitize_text_field', [
				var_request_mutated.array_get(rt.new_string('alt_text')),
			])])
	}
	if !(!rt.is_true(var_schema.array_get(rt.new_string('properties')).array_get(rt.new_string('featured_media'))))
		&& var_request_mutated.array_isset(rt.new_string('featured_media')) {
		mut var_thumbnail_update := this.handle_featured_media(var_request_mutated.array_get(rt.new_string('featured_media')),
			var_attachment_id.clone())
		if rt.is_true(rt.call_function('is_wp_error', [var_thumbnail_update.clone()])) {
			return var_thumbnail_update.clone()
		}
	}
	if !(!rt.is_true(var_schema.array_get(rt.new_string('properties')).array_get(rt.new_string('meta'))))
		&& var_request_mutated.array_isset(rt.new_string('meta')) {
		mut var_meta_update := rt.call_method(rt.get_property(rt.new_object('WP_REST_Attachments_Controller', [
			'WP_REST_Posts_Controller',
		], &this), 'meta'), 'update_value', [var_request_mutated.array_get(rt.new_string('meta')),
			var_attachment_id.clone()])
		if rt.is_true(rt.call_function('is_wp_error', [var_meta_update.clone()])) {
			return var_meta_update.clone()
		}
	}
	mut var_attachment := rt.call_function('get_post', [var_attachment_id.clone()])
	mut var_fields_update := this.update_additional_fields_for_object(var_attachment.clone(),
		var_request_mutated.clone())
	if rt.is_true(rt.call_function('is_wp_error', [var_fields_update.clone()])) {
		return var_fields_update.clone()
	}
	mut var_terms_update := this.handle_terms(var_attachment_id.clone(),
		var_request_mutated.clone())
	if rt.is_true(rt.call_function('is_wp_error', [var_terms_update.clone()])) {
		return var_terms_update.clone()
	}
	rt.call_method(var_request_mutated, 'set_param', [rt.new_string('context'),
		rt.new_string('edit')])
	rt.call_function('do_action', [rt.new_string('rest_after_insert_attachment'),
		var_attachment.clone(), var_request_mutated.clone(), rt.new_bool(true)])
	rt.call_function('wp_after_insert_post', [var_attachment.clone(),
		rt.new_bool(false), rt.new_null()])
	if rt.is_true(rt.call_function('wp_is_serving_rest_request', []rt.PhpVal{})) {
		rt.call_function('header', [
			rt.new_string('X-WP-Upload-Attachment-ID: ' + var_attachment_id.str()),
		])
	}
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/media.php', '4')
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/image.php', '4')
	rt.call_function('wp_update_attachment_metadata', [var_attachment_id.clone(),
		rt.call_function('wp_generate_attachment_metadata', [
			var_attachment_id.clone(), var_file.clone()])])
	mut var_response := this.prepare_item_for_response(var_attachment.clone(),
		var_request_mutated.clone())
	var_response = rt.call_function('rest_ensure_response', [
		var_response.clone()])
	rt.call_method(var_response, 'set_status', [rt.new_int(201)])
	rt.call_method(var_response, 'header', [rt.new_string('Location'),
		rt.call_function('rest_url', [
			rt.call_function('sprintf', [rt.new_string('%s/%s/%d'),
				rt.get_property(rt.new_object('WP_REST_Attachments_Controller', [
					'WP_REST_Posts_Controller',
				], &this), 'namespace'),
				rt.get_property(rt.new_object('WP_REST_Attachments_Controller', [
					'WP_REST_Posts_Controller',
				], &this), 'rest_base'),
				var_attachment_id.clone()]),
		])])
	return var_response.clone()
}

fn (mut this Class_WP_REST_Attachments_Controller) insert_attachment(var_request rt.PhpVal) rt.PhpVal {
	mut var_request_mutated := var_request
	mut var_files := rt.call_method(var_request_mutated, 'get_file_params', []rt.PhpVal{})
	mut var_headers := rt.call_method(var_request_mutated, 'get_headers', []rt.PhpVal{})
	mut var_time := rt.new_null()
	if !(!rt.is_true(var_request_mutated.array_get(rt.new_string('post')))) {
		mut var_post := rt.call_function('get_post', [
			var_request_mutated.array_get(rt.new_string('post')),
		])
		if rt.is_true(var_post)
			&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('page'), rt.get_property(var_post, 'post_type')))))
			&& rt.is_true(rt.greater(rt.call_function('substr', [rt.get_property(var_post, 'post_date'), rt.new_int(0), rt.new_int(4)]), rt.new_int(0))) {
			var_time = rt.get_property(var_post, 'post_date')
		}
	}
	if !(!rt.is_true(var_files)) {
		mut var_file := this.upload_from_file(var_files.clone(), var_headers.clone(),
			var_time.clone())
	} else {
		var_file = this.upload_from_data(rt.call_method(var_request_mutated, 'get_body',
			[]rt.PhpVal{}), var_headers.clone(), var_time.clone())
	}
	if rt.is_true(rt.call_function('is_wp_error', [var_file.clone()])) {
		return var_file.clone()
	}
	mut var_name := rt.call_function('wp_basename', [var_file.array_get(rt.new_string('file'))])
	mut var_name_parts := rt.call_function('pathinfo', [var_name.clone()])
	var_name = rt.new_string(rt.call_function('substr', [var_name.clone(),
		rt.new_int(0),
		rt.new_int(-1 +
			var_name_parts.array_get(rt.new_string('extension')).to_string().len)]).to_string().trim_space())
	mut var_url := var_file.array_get(rt.new_string('url'))
	mut var_type := var_file.array_get(rt.new_string('type'))
	var_file = var_file.array_get(rt.new_string('file'))
	mut var_alt := rt.new_string('')
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/image.php', '4')
	mut var_image_meta := rt.call_function('wp_read_image_metadata', [
		var_file.clone()])
	if !(!rt.is_true(var_image_meta)) {
		if !rt.is_true(var_request_mutated.array_get(rt.new_string('title')))
			&& rt.is_true(rt.new_string(var_image_meta.array_get(rt.new_string('title')).to_string().trim_space()))
			&& !(rt.call_function('sanitize_title', [var_image_meta.array_get(rt.new_string('title'))]).is_long()
			|| rt.call_function('sanitize_title', [var_image_meta.array_get(rt.new_string('title'))]).is_double()) {
			var_request_mutated.array_set('title', var_image_meta.array_get(rt.new_string('title')))
		}
		if !rt.is_true(var_request_mutated.array_get(rt.new_string('caption')))
			&& rt.is_true(rt.new_string(var_image_meta.array_get(rt.new_string('caption')).to_string().trim_space())) {
			var_request_mutated.array_set('caption',
				var_image_meta.array_get(rt.new_string('caption')))
		}
		if !rt.is_true(var_request_mutated.array_get(rt.new_string('alt')))
			&& rt.is_true(rt.new_string(var_image_meta.array_get(rt.new_string('alt')).to_string().trim_space())) {
			var_alt = var_image_meta.array_get(rt.new_string('alt'))
		}
	}
	mut var_attachment := this.prepare_item_for_database(var_request_mutated.clone())
	rt.set_property(var_attachment, 'post_mime_type', var_type.clone())
	rt.set_property(var_attachment, 'guid', var_url.clone())
	if !rt.is_true(rt.get_property(var_attachment, 'post_title'))
		&& !(!rt.is_true(var_files.array_get(rt.new_string('file')).array_get(rt.new_string('name')))) {
		mut var_tmp_title := rt.call_function('substr', [
			var_files.array_get(rt.new_string('file')).array_get(rt.new_string('name')),
			rt.new_int(0),
			rt.call_function('strrpos', [var_files.array_get(rt.new_string('file')).array_get(rt.new_string('name')),
				rt.new_string('.')]),
		])
		if !(!rt.is_true(var_tmp_title)) {
			rt.set_property(var_attachment, 'post_title', var_tmp_title.clone())
		}
	}
	if !rt.is_true(rt.get_property(var_attachment, 'post_title')) {
		rt.set_property(var_attachment, 'post_title', rt.call_function('preg_replace', [
			rt.new_string('/\\.[^.]+$/'),
			rt.new_string(''),
			rt.call_function('wp_basename', [var_file.clone()]),
		]))
	}
	mut var_id := rt.call_function('wp_insert_attachment', [
		rt.call_function('wp_slash', [rt.cast_array(var_attachment)]),
		var_file.clone(),
		rt.new_int(0),
		rt.new_bool(true),
		rt.new_bool(false),
	])
	if rt.is_true(rt.new_string(var_alt.clone().to_string().trim_space())) {
		rt.call_function('update_post_meta', [var_id.clone(),
			rt.new_string('_wp_attachment_image_alt'),
			rt.call_function('sanitize_text_field', [
				var_alt.clone(),
			])])
	}
	if rt.is_true(rt.call_function('is_wp_error', [var_id.clone()])) {
		if rt.is_true(rt.identical(rt.new_string('db_update_error'), rt.call_method(var_id,
			'get_error_code', []rt.PhpVal{})))
		{
			rt.call_method(var_id, 'add_data', [
				rt.create_array([rt.ArrayItem{ key: 'status', val: 500 }]),
			])
		} else {
			rt.call_method(var_id, 'add_data', [
				rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }]),
			])
		}
		return var_id.clone()
	}
	var_attachment = rt.call_function('get_post', [var_id.clone()])
	rt.call_function('do_action', [rt.new_string('rest_insert_attachment'),
		var_attachment.clone(), var_request_mutated.clone(), rt.new_bool(true)])
	return rt.create_array([rt.ArrayItem{ key: 'attachment_id', val: var_id },
		rt.ArrayItem{ key: 'file', val: var_file }])
}

fn (mut this Class_WP_REST_Attachments_Controller) handle_featured_media(var_featured_media rt.PhpVal, var_post_id rt.PhpVal) rt.PhpVal {
	mut var_post_type := rt.call_function('get_post_type', [var_post_id.clone()])
	mut var_thumbnail_support := rt.new_bool(
		rt.is_true(rt.call_function('current_theme_supports', [rt.new_string('post-thumbnails'), var_post_type.clone()]))
		&& rt.is_true(rt.call_function('post_type_supports', [var_post_type.clone(), rt.new_string('thumbnail')])))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_thumbnail_support))))
		&& rt.is_true(rt.call_function('get_post_mime_type', [var_post_id.clone()])) {
		if rt.is_true(rt.call_function('wp_attachment_is', [rt.new_string('audio'),
			var_post_id.clone()]))
		{
			var_thumbnail_support = rt.new_bool(
				rt.is_true(rt.call_function('post_type_supports', [rt.new_string('attachment:audio'), rt.new_string('thumbnail')]))
				|| rt.is_true(rt.call_function('current_theme_supports', [rt.new_string('post-thumbnails'), rt.new_string('attachment:audio')])))
		} else if rt.is_true(rt.call_function('wp_attachment_is', [
			rt.new_string('video'),
			var_post_id.clone(),
		]))
		{
			var_thumbnail_support = rt.new_bool(
				rt.is_true(rt.call_function('post_type_supports', [rt.new_string('attachment:video'), rt.new_string('thumbnail')]))
				|| rt.is_true(rt.call_function('current_theme_supports', [rt.new_string('post-thumbnails'), rt.new_string('attachment:video')])))
		}
	}
	if rt.is_true(var_thumbnail_support) {
		return this.Class_WP_REST_Posts_Controller.handle_featured_media(var_featured_media.clone(),
			var_post_id.clone())
	}
	return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('rest_no_featured_media'), rt.call_function('sprintf', [
		rt.call_function('__', [
			rt.new_string('This site does not support post thumbnails on attachments with MIME type %s.'),
		]),
		rt.call_function('get_post_mime_type', [
			var_post_id.clone(),
		]),
	]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }])))
}

fn (mut this Class_WP_REST_Attachments_Controller) update_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_schema := rt.new_null()
	mut var_request_mutated := var_request
	if !(!rt.is_true(var_request_mutated.array_get(rt.new_string('post'))))
		&& rt.is_true(rt.call_function('in_array', [rt.call_function('get_post_type', [var_request_mutated.array_get(rt.new_string('post'))]), rt.create_array([rt.ArrayItem{
		key: none
		val: 'revision'
	}, rt.ArrayItem{ key: none, val: 'attachment' }]), rt.new_bool(true)])) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('rest_invalid_param'), rt.call_function('__', [
			rt.new_string('Invalid parent type.'),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }])))
	}
	mut var_attachment_before := rt.call_function('get_post', [
		var_request_mutated.array_get(rt.new_string('id')),
	])
	mut var_response := this.Class_WP_REST_Posts_Controller.update_item(var_request_mutated.clone())
	if rt.is_true(rt.call_function('is_wp_error', [var_response.clone()])) {
		return var_response.clone()
	}
	var_response = rt.call_function('rest_ensure_response', [
		var_response.clone()])
	mut var_data := rt.call_method(var_response, 'get_data', []rt.PhpVal{})
	if var_request_mutated.array_isset(rt.new_string('alt_text')) {
		rt.call_function('update_post_meta', [var_data.array_get(rt.new_string('id')),
			rt.new_string('_wp_attachment_image_alt'), var_request_mutated.array_get(rt.new_string('alt_text'))])
	}
	mut var_attachment := rt.call_function('get_post', [
		var_request_mutated.array_get(rt.new_string('id')),
	])
	if !(!rt.is_true(var_schema.array_get(rt.new_string('properties')).array_get(rt.new_string('featured_media'))))
		&& var_request_mutated.array_isset(rt.new_string('featured_media')) {
		mut var_thumbnail_update := this.handle_featured_media(var_request_mutated.array_get(rt.new_string('featured_media')),
			rt.get_property(var_attachment, 'ID'))
		if rt.is_true(rt.call_function('is_wp_error', [var_thumbnail_update.clone()])) {
			return var_thumbnail_update.clone()
		}
	}
	mut var_fields_update := this.update_additional_fields_for_object(var_attachment.clone(),
		var_request_mutated.clone())
	if rt.is_true(rt.call_function('is_wp_error', [var_fields_update.clone()])) {
		return var_fields_update.clone()
	}
	rt.call_method(var_request_mutated, 'set_param', [rt.new_string('context'),
		rt.new_string('edit')])
	rt.call_function('do_action', [rt.new_string('rest_after_insert_attachment'),
		var_attachment.clone(), var_request_mutated.clone(), rt.new_bool(false)])
	rt.call_function('wp_after_insert_post', [var_attachment.clone(),
		rt.new_bool(true), var_attachment_before.clone()])
	var_response = this.prepare_item_for_response(var_attachment.clone(),
		var_request_mutated.clone())
	var_response = rt.call_function('rest_ensure_response', [
		var_response.clone()])
	return var_response.clone()
}

fn (mut this Class_WP_REST_Attachments_Controller) post_process_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_request_mutated := var_request
	mut switch_val_1 := var_request_mutated.array_get(rt.new_string('action'))
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('create-image-subsizes'))) {
		rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/image.php', '4')
		rt.call_function('wp_update_image_subsizes',
			[var_request_mutated.array_get(rt.new_string('id'))])
	}
	var_request_mutated.array_set('context', 'edit')
	return this.prepare_item_for_response(rt.call_function('get_post', [
		var_request_mutated.array_get(rt.new_string('id')),
	]), var_request_mutated.clone())
}

fn (mut this Class_WP_REST_Attachments_Controller) post_process_item_permissions_check(var_request rt.PhpVal) rt.PhpVal {
	mut var_request_mutated := var_request
	return this.update_item_permissions_check(var_request_mutated.clone())
}

fn (mut this Class_WP_REST_Attachments_Controller) edit_media_item_permissions_check(var_request rt.PhpVal) rt.PhpVal {
	mut var_request_mutated := var_request
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('upload_files'),
	])))))
	{
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('rest_cannot_edit_image'), rt.call_function('__', [
			rt.new_string('Sorry, you are not allowed to upload media on this site.'),
		]), rt.create_array([
			rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code',
				[]rt.PhpVal{}) },
		])))
	}
	return this.update_item_permissions_check(var_request_mutated.clone())
}

fn (mut this Class_WP_REST_Attachments_Controller) edit_media_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_request_mutated := var_request
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/image.php', '4')
	mut var_attachment_id := var_request_mutated.array_get(rt.new_string('id'))
	mut var_image_file := rt.call_function('wp_get_original_image_path', [
		var_attachment_id.clone()])
	mut var_image_meta := rt.call_function('wp_get_attachment_metadata', [
		var_attachment_id.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_image_meta))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(var_image_file))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_image_file_matches_image_meta', [var_request_mutated.array_get(rt.new_string('src')), var_image_meta.clone(), var_attachment_id.clone()]))))) {
		return create_wp_error(rt.new_string('rest_unknown_attachment'), rt.call_function('__', [
			rt.new_string('Unable to get meta information for file.'),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 404 }]))
	}
	mut var_supported_types := ['image/jpeg', 'image/png', 'image/gif', 'image/webp', 'image/avif',
		'image/heic']
	mut var_mime_type := rt.call_function('get_post_mime_type', [
		var_attachment_id.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
		var_mime_type.clone(), rt.create_array_from_list(var_supported_types),
		rt.new_bool(true)])))))
	{
		return create_wp_error(rt.new_string('rest_cannot_edit_file_type'), rt.call_function('__', [
			rt.new_string('This type of file cannot be edited.'),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }]))
	}
	if var_request_mutated.array_isset(rt.new_string('modifiers')) {
		mut var_modifiers := var_request_mutated.array_get(rt.new_string('modifiers'))
	} else {
		var_modifiers = rt.new_array()
		if var_request_mutated.array_get(rt.new_string('flip')).array_isset(rt.new_string('horizontal'))
			|| var_request_mutated.array_get(rt.new_string('flip')).array_isset(rt.new_string('vertical')) {
			mut var_flip_args := {
				'vertical':   if var_request_mutated.array_get(rt.new_string('flip')).array_isset(rt.new_string('vertical')) {
					(var_request_mutated.array_get(rt.new_string('flip')).array_get(rt.new_string('vertical'))).to_bool()
				} else {
					false
				}
				'horizontal': if var_request_mutated.array_get(rt.new_string('flip')).array_isset(rt.new_string('horizontal')) {
					(var_request_mutated.array_get(rt.new_string('flip')).array_get(rt.new_string('horizontal'))).to_bool()
				} else {
					false
				}
			}
			var_modifiers.array_push(rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'flip' },
				rt.ArrayItem{ key: 'args', val: rt.create_array([
					rt.ArrayItem{ key: 'flip', val: var_flip_args },
				]) },
			]))
		}
		if !(!rt.is_true(var_request_mutated.array_get(rt.new_string('rotation')))) {
			var_modifiers.array_push(rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'rotate' },
				rt.ArrayItem{ key: 'args', val: rt.create_array([
					rt.ArrayItem{
						key: 'angle'
						val: var_request_mutated.array_get(rt.new_string('rotation'))
					},
				]) },
			]))
		}
		if var_request_mutated.array_isset(rt.new_string('x'))
			&& var_request_mutated.array_isset(rt.new_string('y'))
			&& var_request_mutated.array_isset(rt.new_string('width'))
			&& var_request_mutated.array_isset(rt.new_string('height')) {
			var_modifiers.array_push(rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'crop' },
				rt.ArrayItem{ key: 'args', val: rt.create_array([
					rt.ArrayItem{
						key: 'left'
						val: var_request_mutated.array_get(rt.new_string('x'))
					},
					rt.ArrayItem{ key: 'top', val: var_request_mutated.array_get(rt.new_string('y')) },
					rt.ArrayItem{
						key: 'width'
						val: var_request_mutated.array_get(rt.new_string('width'))
					},
					rt.ArrayItem{
						key: 'height'
						val: var_request_mutated.array_get(rt.new_string('height'))
					},
				]) },
			]))
		}
		if 0 == var_modifiers.clone().array_count() {
			return create_wp_error(rt.new_string('rest_image_not_edited'), rt.call_function('__', [
				rt.new_string('The image was not edited. Edit the image before applying the changes.'),
			]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }]))
		}
	}
	mut var_image_file_to_edit := var_image_file.clone()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('file_exists', [
		var_image_file_to_edit.clone()])))))
	{
		var_image_file_to_edit = rt.call_function('_load_image_to_edit_path', [
			var_attachment_id.clone(),
		])
	}
	mut var_image_editor := rt.call_function('wp_get_image_editor', [
		var_image_file_to_edit.clone()])
	if rt.is_true(rt.call_function('is_wp_error', [var_image_editor.clone()])) {
		return create_wp_error(rt.new_string('rest_unknown_image_file_type'), rt.call_function('__', [
			rt.new_string('Unable to edit this image.'),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 500 }]))
	}
	mut iter_3 := var_modifiers.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_modifier := item_3.val
		mut var_args := var_modifier.array_get(rt.new_string('args'))
		mut switch_val_2 := var_modifier.array_get(rt.new_string('type'))
		if rt.is_true(rt.equal(switch_val_2, rt.new_string('flip'))) {
			mut var_result := rt.call_method(var_image_editor, 'flip', [
				var_args.array_get(rt.new_string('flip')).array_get(rt.new_string('vertical')),
				var_args.array_get(rt.new_string('flip')).array_get(rt.new_string('horizontal')),
			])
			if rt.is_true(rt.call_function('is_wp_error', [var_result.clone()])) {
				return create_wp_error(rt.new_string('rest_image_flip_failed'), rt.call_function('__', [
					rt.new_string('Unable to flip this image.'),
				]), rt.create_array([rt.ArrayItem{ key: 'status', val: 500 }]))
			}
		} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('rotate'))) {
			mut var_rotate := rt.sub(rt.new_int(0), var_args.array_get(rt.new_string('angle')))
			if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int(0), var_rotate)))) {
				var_result = rt.call_method(var_image_editor, 'rotate', [
					var_rotate.clone()])
				if rt.is_true(rt.call_function('is_wp_error', [
					var_result.clone()]))
				{
					return create_wp_error(rt.new_string('rest_image_rotation_failed'), rt.call_function('__', [
						rt.new_string('Unable to rotate this image.'),
					]), rt.create_array([rt.ArrayItem{ key: 'status', val: 500 }]))
				}
			}
		} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('crop'))) {
			mut var_size := rt.call_method(var_image_editor, 'get_size', []rt.PhpVal{})
			mut var_crop_x := rt.new_int((rt.call_function('round', [
				rt.new_float(var_size.array_get(rt.new_string('width')) * var_args.array_get(rt.new_string('left')) / 100),
			])).to_i64())
			mut var_crop_y := rt.new_int((rt.call_function('round', [
				rt.new_float(var_size.array_get(rt.new_string('height')) * var_args.array_get(rt.new_string('top')) / 100),
			])).to_i64())
			mut var_width := rt.new_int((rt.call_function('round', [
				rt.new_float(var_size.array_get(rt.new_string('width')) * var_args.array_get(rt.new_string('width')) / 100),
			])).to_i64())
			mut var_height := rt.new_int((rt.call_function('round', [
				rt.new_float(var_size.array_get(rt.new_string('height')) * var_args.array_get(rt.new_string('height')) / 100),
			])).to_i64())
			if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_size.array_get(rt.new_string('width')), var_width))))
				|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_size.array_get(rt.new_string('height')), var_height)))) {
				var_result = rt.call_method(var_image_editor, 'crop', [
					var_crop_x.clone(), var_crop_y.clone(), var_width.clone(),
					var_height.clone()])
				if rt.is_true(rt.call_function('is_wp_error', [
					var_result.clone()]))
				{
					return create_wp_error(rt.new_string('rest_image_crop_failed'), rt.call_function('__', [
						rt.new_string('Unable to crop this image.'),
					]), rt.create_array([rt.ArrayItem{ key: 'status', val: 500 }]))
				}
			}
		}
	}
	mut var_image_ext := rt.call_function('pathinfo', [var_image_file.clone(),
		rt.get_constant('PATHINFO_EXTENSION')])
	mut var_image_name := rt.call_function('wp_basename', [var_image_file.clone(),
		rt.new_string('.${var_image_ext.to_string()}')])
	if rt.is_true(rt.call_function('preg_match', [rt.new_string('/-edited(-\\d+)?$/'),
		var_image_name.clone()]))
	{
		var_image_name = rt.call_function('preg_replace', [
			rt.new_string('/-edited(-\\d+)?$/'),
			rt.new_string('-edited'),
			var_image_name.clone(),
		])
	} else {
		var_image_name = rt.concat(var_image_name, rt.new_string('-edited'))
	}
	mut var_filename := rt.new_string('${var_image_name.to_string()}.${var_image_ext.to_string()}')
	mut var_uploads := rt.call_function('wp_upload_dir', []rt.PhpVal{})
	var_filename = rt.call_function('wp_unique_filename', [
		var_uploads.array_get(rt.new_string('path')),
		var_filename.clone(),
	])
	mut var_saved := rt.call_method(var_image_editor, 'save', [
		rt.new_string(
			(var_uploads.array_get(rt.new_string('path'))).str() + '/${var_filename.to_string()}'),
	])
	if rt.is_true(rt.call_function('is_wp_error', [var_saved.clone()])) {
		return var_saved.clone()
	}
	mut var_original_attachment_post := rt.call_function('get_post', [
		var_attachment_id.clone()])
	mut var_new_attachment_post := this.prepare_item_for_database(var_request_mutated.clone())
	rt.set_property(var_new_attachment_post, 'post_mime_type',
		var_saved.array_get(rt.new_string('mime-type')))
	rt.set_property(var_new_attachment_post, 'guid',

		(var_uploads.array_get(rt.new_string('url'))).str() + '/${var_filename.to_string()}')
	rt.get_property(var_new_attachment_post, 'ID') = rt.new_null()
	rt.set_property(var_new_attachment_post, 'post_title', if !(rt.get_property(var_new_attachment_post,
		'post_title')).is_null() {
		rt.get_property(var_new_attachment_post, 'post_title')
	} else {
		if !(rt.get_property(var_original_attachment_post, 'post_title')).is_null() {
			rt.get_property(var_original_attachment_post, 'post_title')
		} else {
			var_image_name
		}
	})
	rt.set_property(var_new_attachment_post, 'post_excerpt', if !(rt.get_property(var_new_attachment_post,
		'post_excerpt')).is_null() {
		rt.get_property(var_new_attachment_post, 'post_excerpt')
	} else {
		if !(rt.get_property(var_original_attachment_post, 'post_excerpt')).is_null() {
			rt.get_property(var_original_attachment_post, 'post_excerpt')
		} else {
			rt.new_string('')
		}
	})
	rt.set_property(var_new_attachment_post, 'post_content', if !(rt.get_property(var_new_attachment_post,
		'post_content')).is_null() {
		rt.get_property(var_new_attachment_post, 'post_content')
	} else {
		if !(rt.get_property(var_original_attachment_post, 'post_content')).is_null() {
			rt.get_property(var_original_attachment_post, 'post_content')
		} else {
			rt.new_string('')
		}
	})
	rt.set_property(var_new_attachment_post, 'post_parent', if !(rt.get_property(var_new_attachment_post,
		'post_parent')).is_null() {
		rt.get_property(var_new_attachment_post, 'post_parent')
	} else {
		rt.new_int(0)
	})
	mut var_new_attachment_id := rt.call_function('wp_insert_attachment', [
		rt.call_function('wp_slash', [rt.cast_array(var_new_attachment_post)]),
		var_saved.array_get(rt.new_string('path')),
		rt.new_int(0),
		rt.new_bool(true),
	])
	if rt.is_true(rt.call_function('is_wp_error', [var_new_attachment_id.clone()])) {
		if rt.is_true(rt.identical(rt.new_string('db_update_error'), rt.call_method(var_new_attachment_id,
			'get_error_code', []rt.PhpVal{})))
		{
			rt.call_method(var_new_attachment_id, 'add_data', [
				rt.create_array([rt.ArrayItem{ key: 'status', val: 500 }]),
			])
		} else {
			rt.call_method(var_new_attachment_id, 'add_data', [
				rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }]),
			])
		}
		return var_new_attachment_id.clone()
	}
	mut var_image_alt := if var_request_mutated.array_isset(rt.new_string('alt_text')) { rt.call_function('sanitize_text_field', [
			var_request_mutated.array_get(rt.new_string('alt_text')),
		]) } else { rt.call_function('get_post_meta', [var_attachment_id.clone(),
			rt.new_string('_wp_attachment_image_alt'), rt.new_bool(true)]) }
	if !(!rt.is_true(var_image_alt)) {
		rt.call_function('update_post_meta', [var_new_attachment_id.clone(),
			rt.new_string('_wp_attachment_image_alt'),
			rt.call_function('wp_slash', [
				var_image_alt.clone(),
			])])
	}
	if rt.is_true(rt.call_function('wp_is_serving_rest_request', []rt.PhpVal{})) {
		rt.call_function('header', [
			rt.new_string('X-WP-Upload-Attachment-ID: ' + var_new_attachment_id.str()),
		])
	}
	mut var_new_image_meta := rt.call_function('wp_generate_attachment_metadata', [
		var_new_attachment_id.clone(),
		var_saved.array_get(rt.new_string('path')),
	])
	if var_image_meta.array_isset(rt.new_string('image_meta'))
		&& var_new_image_meta.array_isset(rt.new_string('image_meta'))
		&& var_new_image_meta.array_get(rt.new_string('image_meta')).is_array() {
		mut iter_4 :=
			rt.cast_array(var_image_meta.array_get(rt.new_string('image_meta'))).iterator()
		for {
			item_4 := iter_4.next() or { break }
			mut var_value := item_4.val
			mut var_key := item_4.key
			if !rt.is_true(var_new_image_meta.array_get(rt.new_string('image_meta')).array_get(var_key))
				&& !(!rt.is_true(var_value)) {
				var_new_image_meta.array_get_mut('image_meta').array_set(var_key, var_value.clone())
			}
		}
	}
	if !(!rt.is_true(var_new_image_meta.array_get(rt.new_string('image_meta')).array_get(rt.new_string('orientation')))) {
		var_new_image_meta.array_get_mut('image_meta').array_set('orientation', 1)
	}
	var_new_image_meta.array_set('parent_image', rt.create_array([
		rt.ArrayItem{ key: 'attachment_id', val: var_attachment_id },
		rt.ArrayItem{ key: 'file', val: rt.call_function('_wp_relative_upload_path', [
			var_image_file.clone(),
		]) },
	]))
	var_new_image_meta = rt.call_function('apply_filters', [
		rt.new_string('wp_edited_image_metadata'),
		var_new_image_meta.clone(),
		var_new_attachment_id.clone(),
		var_attachment_id.clone(),
	])
	rt.call_function('wp_update_attachment_metadata', [var_new_attachment_id.clone(),
		var_new_image_meta.clone()])
	mut var_response := this.prepare_item_for_response(rt.call_function('get_post', [
		var_new_attachment_id.clone(),
	]), var_request_mutated.clone())
	rt.call_method(var_response, 'set_status', [rt.new_int(201)])
	rt.call_method(var_response, 'header', [rt.new_string('Location'),
		rt.call_function('rest_url', [
			rt.call_function('sprintf', [rt.new_string('%s/%s/%s'),
				rt.get_property(rt.new_object('WP_REST_Attachments_Controller', [
					'WP_REST_Posts_Controller',
				], &this), 'namespace'),
				rt.get_property(rt.new_object('WP_REST_Attachments_Controller', [
					'WP_REST_Posts_Controller',
				], &this), 'rest_base'),
				var_new_attachment_id.clone()]),
		])])
	return var_response.clone()
}

fn (mut this Class_WP_REST_Attachments_Controller) prepare_item_for_database(var_request rt.PhpVal) rt.PhpVal {
	mut var_request_mutated := var_request
	mut var_prepared_attachment :=
		this.Class_WP_REST_Posts_Controller.prepare_item_for_database(var_request_mutated.clone())
	if var_request_mutated.array_isset(rt.new_string('caption')) {
		if rt.is_true(rt.new_bool(var_request_mutated.array_get(rt.new_string('caption')).is_string())) {
			rt.set_property(var_prepared_attachment, 'post_excerpt',
				var_request_mutated.array_get(rt.new_string('caption')))
		} else if var_request_mutated.array_get(rt.new_string('caption')).array_isset(rt.new_string('raw')) {
			rt.set_property(var_prepared_attachment, 'post_excerpt',
				var_request_mutated.array_get(rt.new_string('caption')).array_get(rt.new_string('raw')))
		}
	}
	if var_request_mutated.array_isset(rt.new_string('description')) {
		if rt.is_true(rt.new_bool(var_request_mutated.array_get(rt.new_string('description')).is_string())) {
			rt.set_property(var_prepared_attachment, 'post_content',
				var_request_mutated.array_get(rt.new_string('description')))
		} else if var_request_mutated.array_get(rt.new_string('description')).array_isset(rt.new_string('raw')) {
			rt.set_property(var_prepared_attachment, 'post_content',
				var_request_mutated.array_get(rt.new_string('description')).array_get(rt.new_string('raw')))
		}
	}
	if var_request_mutated.array_isset(rt.new_string('post')) {
		rt.set_property(var_prepared_attachment, 'post_parent',
			rt.new_int((var_request_mutated.array_get(rt.new_string('post'))).to_i64()))
	}
	return var_prepared_attachment.clone()
}

fn (mut this Class_WP_REST_Attachments_Controller) prepare_item_for_response(var_item rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
	mut var_request_mutated := var_request
	mut var_post := var_item
	mut var_response := this.Class_WP_REST_Posts_Controller.prepare_item_for_response(var_post.clone(),
		var_request_mutated.clone())
	mut var_fields := this.get_fields_for_response(var_request_mutated.clone())
	mut var_data := rt.call_method(var_response, 'get_data', []rt.PhpVal{})
	if rt.is_true(rt.call_function('in_array', [rt.new_string('description'),
		var_fields.clone(), rt.new_bool(true)]))
	{
		var_data.array_set('description', rt.create_array([
			rt.ArrayItem{ key: 'raw', val: rt.get_property(var_post, 'post_content') },
			rt.ArrayItem{ key: 'rendered', val: rt.call_function('apply_filters', [
				rt.new_string('the_content'),
				rt.get_property(var_post, 'post_content'),
			]) },
		]))
	}
	if rt.is_true(rt.call_function('in_array', [rt.new_string('caption'),
		var_fields.clone(), rt.new_bool(true)]))
	{
		mut var_caption := rt.call_function('apply_filters', [
			rt.new_string('get_the_excerpt'),
			rt.get_property(var_post, 'post_excerpt'),
			var_post.clone(),
		])
		var_caption = rt.call_function('apply_filters', [rt.new_string('the_excerpt'),
			var_caption.clone()])
		var_data.array_set('caption', rt.create_array([
			rt.ArrayItem{ key: 'raw', val: rt.get_property(var_post, 'post_excerpt') },
			rt.ArrayItem{ key: 'rendered', val: var_caption },
		]))
	}
	if rt.is_true(rt.call_function('in_array', [rt.new_string('alt_text'),
		var_fields.clone(), rt.new_bool(true)]))
	{
		var_data.array_set('alt_text', rt.call_function('get_post_meta', [
			rt.get_property(var_post, 'ID'),
			rt.new_string('_wp_attachment_image_alt'),
			rt.new_bool(true),
		]))
	}
	if rt.is_true(rt.call_function('in_array', [rt.new_string('media_type'),
		var_fields.clone(), rt.new_bool(true)]))
	{
		var_data.array_set('media_type', if rt.is_true(rt.call_function('wp_attachment_is_image', [
			rt.get_property(var_post, 'ID'),
		]))
		{ 'image' } else { 'file' })
	}
	if rt.is_true(rt.call_function('in_array', [rt.new_string('mime_type'),
		var_fields.clone(), rt.new_bool(true)]))
	{
		var_data.array_set('mime_type', rt.get_property(var_post, 'post_mime_type'))
	}
	if rt.is_true(rt.call_function('in_array', [rt.new_string('media_details'),
		var_fields.clone(), rt.new_bool(true)]))
	{
		var_data.array_set('media_details', rt.call_function('wp_get_attachment_metadata', [
			rt.get_property(var_post, 'ID'),
		]))
		if !rt.is_true(var_data.array_get(rt.new_string('media_details'))) {
			var_data.array_set('media_details', create_stdclass())
		} else if !(!rt.is_true(var_data.array_get(rt.new_string('media_details')).array_get(rt.new_string('sizes')))) {
			mut iter_5 :=
				var_data.array_get(rt.new_string('media_details')).array_get(rt.new_string('sizes')).iterator()
			for {
				item_5 := iter_5.next() or { break }
				mut var_size_data := item_5.val
				mut var_size := item_5.key
				if var_size_data.array_isset(rt.new_string('mime-type')) {
					var_size_data.array_set('mime_type',
						var_size_data.array_get(rt.new_string('mime-type')))
					var_size_data.array_unset(rt.new_string('mime-type'))
				}
				mut var_image_src := rt.call_function('wp_get_attachment_image_src', [
					rt.get_property(var_post, 'ID'),
					var_size.clone(),
				])
				if rt.is_true(rt.new_bool(!(rt.is_true(var_image_src)))) {
					continue
				}
				var_size_data.array_set('source_url', var_image_src.array_get(rt.new_int(0)))
			}
			mut var_full_src := rt.call_function('wp_get_attachment_image_src', [
				rt.get_property(var_post, 'ID'),
				rt.new_string('full'),
			])
			if !(!rt.is_true(var_full_src)) {
				var_data.array_get_mut('media_details').array_get_mut('sizes').array_set('full', rt.create_array([
					rt.ArrayItem{ key: 'file', val: rt.call_function('wp_basename', [
						var_full_src.array_get(rt.new_int(0)),
					]) },
					rt.ArrayItem{ key: 'width', val: var_full_src.array_get(rt.new_int(1)) },
					rt.ArrayItem{ key: 'height', val: var_full_src.array_get(rt.new_int(2)) },
					rt.ArrayItem{ key: 'mime_type', val: rt.get_property(var_post, 'post_mime_type') },
					rt.ArrayItem{ key: 'source_url', val: var_full_src.array_get(rt.new_int(0)) },
				]))
			}
		} else {
			var_data.array_get_mut('media_details').array_set('sizes', create_stdclass())
		}
	}
	if rt.is_true(rt.call_function('in_array', [rt.new_string('post'),
		var_fields.clone(), rt.new_bool(true)]))
	{
		var_data.array_set('post', if !(!rt.is_true(rt.get_property(var_post, 'post_parent'))) {
			rt.new_int((rt.get_property(var_post, 'post_parent')).to_i64())
		} else {
			rt.new_null()
		})
	}
	if rt.is_true(rt.call_function('in_array', [rt.new_string('source_url'),
		var_fields.clone(), rt.new_bool(true)]))
	{
		var_data.array_set('source_url', rt.call_function('wp_get_attachment_url', [
			rt.get_property(var_post, 'ID'),
		]))
	}
	if rt.is_true(rt.call_function('in_array', [rt.new_string('missing_image_sizes'),
		var_fields.clone(), rt.new_bool(true)]))
	{
		rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/image.php', '4')
		var_data.array_set('missing_image_sizes', rt.func_array_keys(rt.call_function('wp_get_missing_image_subsizes', [
			rt.get_property(var_post, 'ID'),
		])))
		if !rt.is_true(var_data.array_get(rt.new_string('missing_image_sizes')))
			&& rt.is_true(rt.identical(rt.new_string('application/pdf'), rt.call_function('get_post_mime_type', [var_post.clone()]))) {
			mut var_metadata := rt.call_function('wp_get_attachment_metadata', [
				rt.get_property(var_post, 'ID'),
				rt.new_bool(true),
			])
			if !(var_metadata.clone().is_array()) {
				var_metadata = rt.new_array()
			}
			var_metadata.array_set('sizes', if !(var_metadata.array_get(rt.new_string('sizes'))).is_null() {
				var_metadata.array_get(rt.new_string('sizes'))
			} else {
				rt.new_array()
			})
			mut var_fallback_sizes := rt.create_array([
				rt.ArrayItem{ key: none, val: 'thumbnail' },
				rt.ArrayItem{ key: none, val: 'medium' },
				rt.ArrayItem{ key: none, val: 'large' },
			])
			rt.call_function('remove_filter', [
				rt.new_string('fallback_intermediate_image_sizes'),
				rt.new_string('__return_empty_array'),
				rt.new_int(100),
			])
			var_fallback_sizes = rt.call_function('apply_filters', [
				rt.new_string('fallback_intermediate_image_sizes'),
				var_fallback_sizes.clone(),
				var_metadata.clone(),
			])
			mut var_registered_sizes := rt.call_function('wp_get_registered_image_subsizes',
				[]rt.PhpVal{})
			mut var_merged_sizes := rt.func_array_keys(rt.call_function('array_intersect_key', [
				var_registered_sizes.clone(),
				rt.call_function('array_flip', [var_fallback_sizes.clone()]),
			]))
			var_data.array_set('missing_image_sizes', rt.call_function('array_values', [
				rt.call_function('array_diff', [var_merged_sizes.clone(),
					rt.func_array_keys(var_metadata.array_get(rt.new_string('sizes')))]),
			]))
		}
	}
	if rt.is_true(rt.call_function('in_array', [rt.new_string('filename'),
		var_fields.clone(), rt.new_bool(true)]))
	{
		var_data.array_set('filename',
			this.get_attachment_filename((rt.get_property(var_post, 'ID')).to_i64()))
	}
	if rt.is_true(rt.call_function('in_array', [rt.new_string('filesize'),
		var_fields.clone(), rt.new_bool(true)]))
	{
		var_data.array_set('filesize',
			this.get_attachment_filesize((rt.get_property(var_post, 'ID')).to_i64()))
	}
	if rt.is_true(rt.call_function('in_array', [rt.new_string('exif_orientation'), var_fields.clone(), rt.new_bool(true)]))
		&& rt.is_true(rt.call_function('wp_attachment_is_image', [var_post.clone()])) {
		var_metadata = rt.call_function('wp_get_attachment_metadata', [
			rt.get_property(var_post, 'ID'),
			rt.new_bool(true),
		])
		mut var_orientation := rt.new_int(1)
		if var_metadata.clone().is_array()
			&& var_metadata.array_get(rt.new_string('image_meta')).array_isset(rt.new_string('orientation'))
			&& rt.new_int((var_metadata.array_get(rt.new_string('image_meta')).array_get(rt.new_string('orientation'))).to_i64()) > 0 {
			var_orientation =
				rt.new_int((var_metadata.array_get(rt.new_string('image_meta')).array_get(rt.new_string('orientation'))).to_i64())
		}
		var_data.array_set('exif_orientation', var_orientation.clone())
	}
	mut var_context := if !(!rt.is_true(var_request_mutated.array_get(rt.new_string('context')))) {
		var_request_mutated.array_get(rt.new_string('context'))
	} else {
		rt.new_string('view')
	}
	var_data = this.filter_response_by_context(var_data.clone(), var_context.clone())
	mut var_links := rt.call_method(var_response, 'get_links', []rt.PhpVal{})
	var_response = rt.call_function('rest_ensure_response', [
		var_data.clone()])
	mut iter_6 := var_links.iterator()
	for {
		item_6 := iter_6.next() or { break }
		mut var_rel_links := item_6.val
		mut var_rel := item_6.key
		mut iter_7 := var_rel_links.iterator()
		for {
			item_7 := iter_7.next() or { break }
			mut var_link := item_7.val
			rt.call_method(var_response, 'add_link', [var_rel.clone(),
				var_link.array_get(rt.new_string('href')), var_link.array_get(rt.new_string('attributes'))])
		}
	}
	return rt.call_function('apply_filters', [rt.new_string('rest_prepare_attachment'),
		var_response.clone(), var_post.clone(), var_request_mutated.clone()])
}

fn (mut this Class_WP_REST_Attachments_Controller) prepare_links(var_post rt.PhpVal) rt.PhpVal {
	mut var_post_mutated := var_post
	mut var_links := this.Class_WP_REST_Posts_Controller.prepare_links(var_post_mutated.clone())
	if !(!rt.is_true(rt.get_property(var_post_mutated, 'post_parent'))) {
		var_post_mutated = rt.call_function('get_post', [
			rt.get_property(var_post_mutated, 'post_parent'),
		])
		if !(!rt.is_true(var_post_mutated)) {
			var_links.array_set('https://api.w.org/attached-to', rt.create_array([
				rt.ArrayItem{ key: 'href', val: rt.call_function('rest_url', [
					rt.call_function('rest_get_route_for_post', [
						var_post_mutated.clone()]),
				]) },
				rt.ArrayItem{ key: 'embeddable', val: true },
				rt.ArrayItem{ key: 'post_type', val: rt.get_property(var_post_mutated, 'post_type') },
				rt.ArrayItem{ key: 'id', val: rt.get_property(var_post_mutated, 'ID') },
			]))
		}
	}
	return var_links.clone()
}

fn (mut this Class_WP_REST_Attachments_Controller) get_item_schema() rt.PhpVal {
	if rt.is_true(rt.get_property(rt.new_object('WP_REST_Attachments_Controller', [
		'WP_REST_Posts_Controller',
	], &this), 'schema'))
	{
		return this.add_additional_fields_schema(rt.get_property(rt.new_object('WP_REST_Attachments_Controller', [
			'WP_REST_Posts_Controller',
		], &this), 'schema'))
	}
	mut var_schema := this.Class_WP_REST_Posts_Controller.get_item_schema()
	var_schema.array_get_mut('properties').array_set('alt_text', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Alternative text to display when attachment is not displayed.'),
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
	var_schema.array_get_mut('properties').array_set('caption', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('The attachment caption.'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'object' },
		rt.ArrayItem{ key: 'context', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'view' },
			rt.ArrayItem{ key: none, val: 'edit' },
			rt.ArrayItem{ key: none, val: 'embed' },
		]) },
		rt.ArrayItem{ key: 'arg_options', val: rt.create_array([
			rt.ArrayItem{ key: 'sanitize_callback', val: rt.new_null() },
			rt.ArrayItem{ key: 'validate_callback', val: rt.new_null() },
		]) },
		rt.ArrayItem{ key: 'properties', val: rt.create_array([
			rt.ArrayItem{ key: 'raw', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Caption for the attachment, as it exists in the database.'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
			]) },
			rt.ArrayItem{ key: 'rendered', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('HTML caption for the attachment, transformed for display.'),
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
	var_schema.array_get_mut('properties').array_set('description', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('The attachment description.'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'object' },
		rt.ArrayItem{ key: 'context', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'view' },
			rt.ArrayItem{ key: none, val: 'edit' },
		]) },
		rt.ArrayItem{ key: 'arg_options', val: rt.create_array([
			rt.ArrayItem{ key: 'sanitize_callback', val: rt.new_null() },
			rt.ArrayItem{ key: 'validate_callback', val: rt.new_null() },
		]) },
		rt.ArrayItem{ key: 'properties', val: rt.create_array([
			rt.ArrayItem{ key: 'raw', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Description for the attachment, as it exists in the database.'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
			]) },
			rt.ArrayItem{ key: 'rendered', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('HTML description for the attachment, transformed for display.'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
			]) },
		]) },
	]))
	var_schema.array_get_mut('properties').array_set('media_type', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Attachment type.'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'string' },
		rt.ArrayItem{ key: 'enum', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'image' },
			rt.ArrayItem{ key: none, val: 'file' },
		]) },
		rt.ArrayItem{ key: 'context', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'view' },
			rt.ArrayItem{ key: none, val: 'edit' },
			rt.ArrayItem{ key: none, val: 'embed' },
		]) },
		rt.ArrayItem{ key: 'readonly', val: true },
	]))
	var_schema.array_get_mut('properties').array_set('mime_type', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('The attachment MIME type.'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'string' },
		rt.ArrayItem{ key: 'context', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'view' },
			rt.ArrayItem{ key: none, val: 'edit' },
			rt.ArrayItem{ key: none, val: 'embed' },
		]) },
		rt.ArrayItem{ key: 'readonly', val: true },
	]))
	var_schema.array_get_mut('properties').array_set('media_details', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Details about the media file, specific to its type.'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'object' },
		rt.ArrayItem{ key: 'context', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'view' },
			rt.ArrayItem{ key: none, val: 'edit' },
			rt.ArrayItem{ key: none, val: 'embed' },
		]) },
		rt.ArrayItem{ key: 'readonly', val: true },
	]))
	var_schema.array_get_mut('properties').array_set('post', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('The ID for the associated post of the attachment.'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'integer' },
		rt.ArrayItem{ key: 'context', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'view' },
			rt.ArrayItem{ key: none, val: 'edit' },
		]) },
	]))
	var_schema.array_get_mut('properties').array_set('source_url', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('URL to the original attachment file.'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'string' },
		rt.ArrayItem{ key: 'format', val: 'uri' },
		rt.ArrayItem{ key: 'context', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'view' },
			rt.ArrayItem{ key: none, val: 'edit' },
			rt.ArrayItem{ key: none, val: 'embed' },
		]) },
		rt.ArrayItem{ key: 'readonly', val: true },
	]))
	var_schema.array_get_mut('properties').array_set('missing_image_sizes', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('List of the missing image sizes of the attachment.'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'array' },
		rt.ArrayItem{ key: 'items', val: rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'string' },
		]) },
		rt.ArrayItem{ key: 'context', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'edit' },
		]) },
		rt.ArrayItem{ key: 'readonly', val: true },
	]))
	var_schema.array_get_mut('properties').array_set('filename', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Original attachment file name.'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'string' },
		rt.ArrayItem{ key: 'context', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'view' },
			rt.ArrayItem{ key: none, val: 'edit' },
		]) },
		rt.ArrayItem{ key: 'readonly', val: true },
	]))
	var_schema.array_get_mut('properties').array_set('filesize', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Attachment file size in bytes.'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'integer' },
		rt.ArrayItem{ key: 'context', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'view' },
			rt.ArrayItem{ key: none, val: 'edit' },
		]) },
		rt.ArrayItem{ key: 'readonly', val: true },
	]))
	var_schema.array_get_mut('properties').array_set('exif_orientation', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('EXIF orientation value. Values 1-8 follow the EXIF specification, where 1 means no rotation needed.'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'integer' },
		rt.ArrayItem{ key: 'context', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'edit' },
		]) },
		rt.ArrayItem{ key: 'readonly', val: true },
	]))
	var_schema.array_get(rt.new_string('properties')).array_unset(rt.new_string('password'))
	this.dispatch_set_prop('schema', var_schema.clone())
	return this.add_additional_fields_schema(rt.get_property(rt.new_object('WP_REST_Attachments_Controller', [
		'WP_REST_Posts_Controller',
	], &this), 'schema'))
}

fn (mut this Class_WP_REST_Attachments_Controller) upload_from_data(var_data rt.PhpVal, var_headers rt.PhpVal, var_time rt.PhpVal) rt.PhpVal {
	mut var_data_mutated := var_data
	mut var_headers_mutated := var_headers
	mut var_time_mutated := var_time
	if !rt.is_true(var_data_mutated) {
		return create_wp_error(rt.new_string('rest_upload_no_data'), rt.call_function('__', [
			rt.new_string('No data supplied.'),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }]))
	}
	if !rt.is_true(var_headers_mutated.array_get(rt.new_string('content_type'))) {
		return create_wp_error(rt.new_string('rest_upload_no_content_type'), rt.call_function('__', [
			rt.new_string('No Content-Type supplied.'),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }]))
	}
	if !rt.is_true(var_headers_mutated.array_get(rt.new_string('content_disposition'))) {
		return create_wp_error(rt.new_string('rest_upload_no_content_disposition'), rt.call_function('__', [
			rt.new_string('No Content-Disposition supplied.'),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }]))
	}
	mut var_filename :=
		Class_WP_REST_Attachments_Controller.get_filename_from_disposition(var_headers_mutated.array_get(rt.new_string('content_disposition')))
	if !rt.is_true(var_filename) {
		return create_wp_error(rt.new_string('rest_upload_invalid_disposition'), rt.call_function('__', [
			rt.new_string('Invalid Content-Disposition supplied. Content-Disposition needs to be formatted as `attachment; filename="image.png"` or similar.'),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }]))
	}
	if !(!rt.is_true(var_headers_mutated.array_get(rt.new_string('content_md5')))) {
		mut var_content_md5 := rt.call_function('array_shift', [
			var_headers_mutated.array_get(rt.new_string('content_md5')),
		])
		mut var_expected := rt.new_string(var_content_md5.clone().to_string().trim_space())
		mut var_actual := rt.new_string(md5.hexhash(var_data_mutated.clone().to_string()))
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_expected, var_actual)))) {
			return create_wp_error(rt.new_string('rest_upload_hash_mismatch'), rt.call_function('__', [
				rt.new_string('Content hash did not match expected.'),
			]), rt.create_array([rt.ArrayItem{ key: 'status', val: 412 }]))
		}
	}
	mut var_type := rt.call_function('array_shift', [
		var_headers_mutated.array_get(rt.new_string('content_type')),
	])
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/file.php', '4')
	mut var_tmpfname := rt.call_function('wp_tempnam', [var_filename.clone()])
	mut var_fp := rt.call_function('fopen', [var_tmpfname.clone(),
		rt.new_string('w+')])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_fp)))) {
		return create_wp_error(rt.new_string('rest_upload_file_error'), rt.call_function('__', [
			rt.new_string('Could not open file handle.'),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 500 }]))
	}
	rt.call_function('fwrite', [var_fp.clone(), var_data_mutated.clone()])
	rt.call_function('fclose', [var_fp.clone()])
	mut var_file_data := {
		'error':    rt.new_null()
		'tmp_name': var_tmpfname
		'name':     var_filename
		'type':     var_type
	}
	mut iife_temp_0 := Class_WP_REST_Attachments_Controller{}
	mut iife_result_0 := iife_temp_0.check_upload_size(var_file_data.clone())
	mut var_size_check := iife_result_0
	if rt.is_true(rt.call_function('is_wp_error', [var_size_check.clone()])) {
		return var_size_check.clone()
	}
	mut var_overrides := {
		'test_form': rt.new_bool(false)
	}
	mut var_sideloaded := rt.call_function('wp_handle_sideload', [
		rt.create_array_from_native_map(var_file_data),
		rt.create_array_from_native_map(var_overrides),
		var_time_mutated.clone(),
	])
	if var_sideloaded.array_isset(rt.new_string('error')) {
		rt.call_function('unlink', [var_tmpfname.clone()])
		return create_wp_error(rt.new_string('rest_upload_sideload_error'),
			var_sideloaded.array_get(rt.new_string('error')), rt.create_array([
			rt.ArrayItem{ key: 'status', val: 500 },
		]))
	}
	return var_sideloaded.clone()
}

fn Class_WP_REST_Attachments_Controller.get_filename_from_disposition(var_disposition_header rt.PhpVal) rt.PhpVal {
	mut var_key := rt.new_null()
	mut var_filename := rt.new_null()
	mut iter_8 := var_disposition_header.iterator()
	for {
		item_8 := iter_8.next() or { break }
		mut var_value := item_8.val
		var_value = rt.new_string(var_value.clone().to_string().trim_space())
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('str_contains', [
			var_value.clone(),
			rt.new_string(';'),
		])))))
		{
			continue
		}
		mut list_tmp_1 := rt.call_function('explode', [rt.new_string(';'),
			var_value.clone(), rt.new_int(2)])
		mut var_attr_parts := list_tmp_1.array_get(1)
		var_attr_parts = rt.call_function('explode', [rt.new_string(';'),
			var_attr_parts.clone()])
		mut var_attributes := rt.new_array()
		mut iter_9 := var_attr_parts.iterator()
		for {
			item_9 := iter_9.next() or { break }
			mut var_part := item_9.val
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('str_contains', [
				var_part.clone(),
				rt.new_string('='),
			])))))
			{
				continue
			}
			mut list_tmp_2 := rt.call_function('explode', [rt.new_string('='),
				var_part.clone(), rt.new_int(2)])
			var_key = list_tmp_2.array_get(0)
			var_value = list_tmp_2.array_get(1)
			var_attributes[var_key.clone().to_string().trim_space()] =
				var_value.clone().to_string().trim_space()
		}
		if var_attributes['filename'] == '' {
			continue
		}
		var_filename = rt.new_string(var_attributes['filename'].trim_space())
		if rt.is_true(rt.call_function('str_starts_with', [var_filename.clone(), rt.new_string('"')]))
			&& rt.is_true(rt.call_function('str_ends_with', [var_filename.clone(), rt.new_string('"')])) {
			var_filename = rt.call_function('substr', [var_filename.clone(),
				rt.new_int(1), rt.new_int(-1)])
		}
	}
	return var_filename.clone()
}

fn (mut this Class_WP_REST_Attachments_Controller) get_collection_params() rt.PhpVal {
	mut var_params := this.Class_WP_REST_Posts_Controller.get_collection_params()
	var_params.array_get_mut('status').array_set('default', 'inherit')
	var_params.array_get_mut('status').array_get_mut('items').array_set('enum', rt.create_array([
		rt.ArrayItem{ key: none, val: 'inherit' },
		rt.ArrayItem{ key: none, val: 'private' },
		rt.ArrayItem{ key: none, val: 'trash' },
	]))
	mut var_media_types := rt.func_array_keys(this.get_media_types())
	var_params.array_set('media_type', rt.create_array([
		rt.ArrayItem{ key: 'default', val: rt.new_null() },
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Limit result set to attachments of a particular media type or media types.'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'array' },
		rt.ArrayItem{ key: 'items', val: rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'string' },
			rt.ArrayItem{ key: 'enum', val: var_media_types },
		]) },
	]))
	var_params.array_set('mime_type', rt.create_array([
		rt.ArrayItem{ key: 'default', val: rt.new_null() },
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Limit result set to attachments of a particular MIME type or MIME types.'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'array' },
		rt.ArrayItem{ key: 'items', val: rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'string' },
		]) },
	]))
	return var_params.clone()
}

fn (mut this Class_WP_REST_Attachments_Controller) upload_from_file(var_files rt.PhpVal, var_headers rt.PhpVal, var_time rt.PhpVal) rt.PhpVal {
	mut var_files_mutated := var_files
	mut var_headers_mutated := var_headers
	mut var_time_mutated := var_time
	if !rt.is_true(var_files_mutated) {
		return create_wp_error(rt.new_string('rest_upload_no_data'), rt.call_function('__', [
			rt.new_string('No data supplied.'),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }]))
	}
	if !(!rt.is_true(var_headers_mutated.array_get(rt.new_string('content_md5')))) {
		mut var_content_md5 := rt.call_function('array_shift', [
			var_headers_mutated.array_get(rt.new_string('content_md5')),
		])
		mut var_expected := rt.new_string(var_content_md5.clone().to_string().trim_space())
		mut var_actual := rt.call_function('md5_file', [
			var_files_mutated.array_get(rt.new_string('file')).array_get(rt.new_string('tmp_name')),
		])
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_expected, var_actual)))) {
			return create_wp_error(rt.new_string('rest_upload_hash_mismatch'), rt.call_function('__', [
				rt.new_string('Content hash did not match expected.'),
			]), rt.create_array([rt.ArrayItem{ key: 'status', val: 412 }]))
		}
	}
	mut var_overrides := {
		'test_form': rt.new_bool(false)
	}
	if rt.is_true(rt.call_function('defined', [rt.new_string('DIR_TESTDATA')]))
		&& rt.is_true(rt.get_constant('DIR_TESTDATA')) {
		var_overrides['action'] = rt.new_string('wp_handle_mock_upload')
	}
	mut iife_temp_1 := Class_WP_REST_Attachments_Controller{}
	mut iife_result_1 :=
		iife_temp_1.check_upload_size(var_files_mutated.array_get(rt.new_string('file')))
	mut var_size_check := iife_result_1
	if rt.is_true(rt.call_function('is_wp_error', [var_size_check.clone()])) {
		return var_size_check.clone()
	}
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/file.php', '4')
	mut var_file := rt.call_function('wp_handle_upload', [
		var_files_mutated.array_get(rt.new_string('file')),
		rt.create_array_from_native_map(var_overrides),
		var_time_mutated.clone(),
	])
	if var_file.array_isset(rt.new_string('error')) {
		return create_wp_error(rt.new_string('rest_upload_unknown_error'),
			var_file.array_get(rt.new_string('error')), rt.create_array([
			rt.ArrayItem{ key: 'status', val: 500 },
		]))
	}
	return var_file.clone()
}

fn (mut this Class_WP_REST_Attachments_Controller) get_media_types() rt.PhpVal {
	mut var_media_types := rt.new_array()
	mut iter_10 := rt.call_function('get_allowed_mime_types', []rt.PhpVal{}).iterator()
	for {
		item_10 := iter_10.next() or { break }
		mut var_mime_type := item_10.val
		mut var_parts := rt.call_function('explode', [rt.new_string('/'),
			var_mime_type.clone()])
		if !(var_media_types.array_isset(var_parts.array_get(rt.new_int(0)))) {
			var_media_types.array_set(var_parts.array_get(rt.new_int(0)), rt.new_array())
		}
		var_media_types.array_get_mut(var_parts.array_get(rt.new_int(0))).array_push(var_mime_type.clone())
	}
	return var_media_types.clone()
}

fn (mut this Class_WP_REST_Attachments_Controller) check_upload_size(var_file rt.PhpVal) bool {
	mut var_file_mutated := var_file
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{}))))) {
		return true
	}
	if rt.is_true(rt.call_function('get_site_option', [
		rt.new_string('upload_space_check_disabled'),
	]))
	{
		return true
	}
	mut var_space_left := rt.call_function('get_upload_space_available', []rt.PhpVal{})
	mut var_file_size := rt.call_function('filesize', [
		var_file_mutated.array_get(rt.new_string('tmp_name')),
	])
	if rt.is_true(rt.less(var_space_left, var_file_size)) {
		return (create_wp_error(rt.new_string('rest_upload_limited_space'), rt.call_function('sprintf', [
			rt.call_function('__', [
				rt.new_string('Not enough space to upload. %s KB needed.'),
			]),
			rt.call_function('number_format', [
				rt.div(rt.sub(var_file_size, var_space_left), rt.get_constant('KB_IN_BYTES')),
			]),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }]))).to_bool()
	}
	if rt.is_true(rt.greater(var_file_size, rt.mul(rt.get_constant('KB_IN_BYTES'), rt.call_function('get_site_option', [
		rt.new_string('fileupload_maxk'),
		rt.new_int(1500),
	]))))
	{
		return (create_wp_error(rt.new_string('rest_upload_file_too_big'), rt.call_function('sprintf', [
			rt.call_function('__', [
				rt.new_string('This file is too big. Files must be less than %s KB in size.'),
			]),
			rt.call_function('get_site_option', [
				rt.new_string('fileupload_maxk'),
				rt.new_int(1500),
			]),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }]))).to_bool()
	}
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/ms.php', '4')
	if rt.is_true(rt.call_function('upload_is_user_over_quota', [
		rt.new_bool(false)]))
	{
		return (create_wp_error(rt.new_string('rest_upload_user_quota_exceeded'), rt.call_function('__', [
			rt.new_string('You have used your space quota. Please delete files before uploading.'),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }]))).to_bool()
	}
	return true
}

fn (mut this Class_WP_REST_Attachments_Controller) get_edit_media_item_args() rt.PhpVal {
	mut var_args := rt.create_array([
		rt.ArrayItem{ key: 'src', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('URL to the edited image file.'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'string' },
			rt.ArrayItem{ key: 'format', val: 'uri' },
			rt.ArrayItem{ key: 'required', val: true },
		]) },
		rt.ArrayItem{ key: 'modifiers', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Array of image edits.'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'array' },
			rt.ArrayItem{ key: 'minItems', val: 1 },
			rt.ArrayItem{ key: 'items', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Image edit.'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'object' },
				rt.ArrayItem{ key: 'required', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'type' },
					rt.ArrayItem{ key: none, val: 'args' },
				]) },
				rt.ArrayItem{ key: 'oneOf', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.create_array([
						rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
							rt.new_string('Flip'),
						]) },
						rt.ArrayItem{ key: 'properties', val: rt.create_array([
							rt.ArrayItem{ key: 'type', val: rt.create_array([
								rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
									rt.new_string('Flip type.'),
								]) },
								rt.ArrayItem{ key: 'type', val: 'string' },
								rt.ArrayItem{ key: 'enum', val: rt.create_array([
									rt.ArrayItem{ key: none, val: 'flip' },
								]) },
							]) },
							rt.ArrayItem{ key: 'args', val: rt.create_array([
								rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
									rt.new_string('Flip arguments.'),
								]) },
								rt.ArrayItem{ key: 'type', val: 'object' },
								rt.ArrayItem{ key: 'required', val: rt.create_array([
									rt.ArrayItem{ key: none, val: 'flip' },
								]) },
								rt.ArrayItem{ key: 'properties', val: rt.create_array([
									rt.ArrayItem{ key: 'flip', val: rt.create_array([
										rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
											rt.new_string('Flip direction.'),
										]) },
										rt.ArrayItem{ key: 'type', val: 'object' },
										rt.ArrayItem{ key: 'required', val: rt.create_array([
											rt.ArrayItem{ key: none, val: 'horizontal' },
											rt.ArrayItem{ key: none, val: 'vertical' },
										]) },
										rt.ArrayItem{ key: 'properties', val: rt.create_array([
											rt.ArrayItem{ key: 'horizontal', val: rt.create_array([
												rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
													rt.new_string('Whether to flip in the horizontal direction.'),
												]) },
												rt.ArrayItem{ key: 'type', val: 'boolean' },
											]) },
											rt.ArrayItem{ key: 'vertical', val: rt.create_array([
												rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
													rt.new_string('Whether to flip in the vertical direction.'),
												]) },
												rt.ArrayItem{ key: 'type', val: 'boolean' },
											]) },
										]) },
									]) },
								]) },
							]) },
						]) },
					]) },
					rt.ArrayItem{ key: none, val: rt.create_array([
						rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
							rt.new_string('Rotation'),
						]) },
						rt.ArrayItem{ key: 'properties', val: rt.create_array([
							rt.ArrayItem{ key: 'type', val: rt.create_array([
								rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
									rt.new_string('Rotation type.'),
								]) },
								rt.ArrayItem{ key: 'type', val: 'string' },
								rt.ArrayItem{ key: 'enum', val: rt.create_array([
									rt.ArrayItem{ key: none, val: 'rotate' },
								]) },
							]) },
							rt.ArrayItem{ key: 'args', val: rt.create_array([
								rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
									rt.new_string('Rotation arguments.'),
								]) },
								rt.ArrayItem{ key: 'type', val: 'object' },
								rt.ArrayItem{ key: 'required', val: rt.create_array([
									rt.ArrayItem{ key: none, val: 'angle' },
								]) },
								rt.ArrayItem{ key: 'properties', val: rt.create_array([
									rt.ArrayItem{ key: 'angle', val: rt.create_array([
										rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
											rt.new_string('Angle to rotate clockwise in degrees.'),
										]) },
										rt.ArrayItem{ key: 'type', val: 'number' },
									]) },
								]) },
							]) },
						]) },
					]) },
					rt.ArrayItem{ key: none, val: rt.create_array([
						rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
							rt.new_string('Crop'),
						]) },
						rt.ArrayItem{ key: 'properties', val: rt.create_array([
							rt.ArrayItem{ key: 'type', val: rt.create_array([
								rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
									rt.new_string('Crop type.'),
								]) },
								rt.ArrayItem{ key: 'type', val: 'string' },
								rt.ArrayItem{ key: 'enum', val: rt.create_array([
									rt.ArrayItem{ key: none, val: 'crop' },
								]) },
							]) },
							rt.ArrayItem{ key: 'args', val: rt.create_array([
								rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
									rt.new_string('Crop arguments.'),
								]) },
								rt.ArrayItem{ key: 'type', val: 'object' },
								rt.ArrayItem{ key: 'required', val: rt.create_array([
									rt.ArrayItem{ key: none, val: 'left' },
									rt.ArrayItem{ key: none, val: 'top' },
									rt.ArrayItem{ key: none, val: 'width' },
									rt.ArrayItem{ key: none, val: 'height' },
								]) },
								rt.ArrayItem{ key: 'properties', val: rt.create_array([
									rt.ArrayItem{ key: 'left', val: rt.create_array([
										rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
											rt.new_string('Horizontal position from the left to begin the crop as a percentage of the image width.'),
										]) },
										rt.ArrayItem{ key: 'type', val: 'number' },
									]) },
									rt.ArrayItem{ key: 'top', val: rt.create_array([
										rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
											rt.new_string('Vertical position from the top to begin the crop as a percentage of the image height.'),
										]) },
										rt.ArrayItem{ key: 'type', val: 'number' },
									]) },
									rt.ArrayItem{ key: 'width', val: rt.create_array([
										rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
											rt.new_string('Width of the crop as a percentage of the image width.'),
										]) },
										rt.ArrayItem{ key: 'type', val: 'number' },
									]) },
									rt.ArrayItem{ key: 'height', val: rt.create_array([
										rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
											rt.new_string('Height of the crop as a percentage of the image height.'),
										]) },
										rt.ArrayItem{ key: 'type', val: 'number' },
									]) },
								]) },
							]) },
						]) },
					]) },
				]) },
			]) },
		]) },
		rt.ArrayItem{ key: 'rotation', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('The amount to rotate the image clockwise in degrees. DEPRECATED: Use `modifiers` instead.'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'integer' },
			rt.ArrayItem{ key: 'minimum', val: 0 },
			rt.ArrayItem{ key: 'exclusiveMinimum', val: true },
			rt.ArrayItem{ key: 'maximum', val: 360 },
			rt.ArrayItem{ key: 'exclusiveMaximum', val: true },
		]) },
		rt.ArrayItem{ key: 'x', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('As a percentage of the image, the x position to start the crop from. DEPRECATED: Use `modifiers` instead.'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'number' },
			rt.ArrayItem{ key: 'minimum', val: 0 },
			rt.ArrayItem{ key: 'maximum', val: 100 },
		]) },
		rt.ArrayItem{ key: 'y', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('As a percentage of the image, the y position to start the crop from. DEPRECATED: Use `modifiers` instead.'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'number' },
			rt.ArrayItem{ key: 'minimum', val: 0 },
			rt.ArrayItem{ key: 'maximum', val: 100 },
		]) },
		rt.ArrayItem{ key: 'width', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('As a percentage of the image, the width to crop the image to. DEPRECATED: Use `modifiers` instead.'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'number' },
			rt.ArrayItem{ key: 'minimum', val: 0 },
			rt.ArrayItem{ key: 'maximum', val: 100 },
		]) },
		rt.ArrayItem{ key: 'height', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('As a percentage of the image, the height to crop the image to. DEPRECATED: Use `modifiers` instead.'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'number' },
			rt.ArrayItem{ key: 'minimum', val: 0 },
			rt.ArrayItem{ key: 'maximum', val: 100 },
		]) },
	])
	mut var_update_item_args :=
		this.get_endpoint_args_for_item_schema(Class_WP_REST_Server.editable())
	if var_update_item_args.array_isset(rt.new_string('caption')) {
		var_args.array_set('caption', var_update_item_args.array_get(rt.new_string('caption')))
	}
	if var_update_item_args.array_isset(rt.new_string('description')) {
		var_args.array_set('description',
			var_update_item_args.array_get(rt.new_string('description')))
	}
	if var_update_item_args.array_isset(rt.new_string('title')) {
		var_args.array_set('title', var_update_item_args.array_get(rt.new_string('title')))
	}
	if var_update_item_args.array_isset(rt.new_string('post')) {
		var_args.array_set('post', var_update_item_args.array_get(rt.new_string('post')))
	}
	if var_update_item_args.array_isset(rt.new_string('alt_text')) {
		var_args.array_set('alt_text', var_update_item_args.array_get(rt.new_string('alt_text')))
	}
	return var_args.clone()
}

fn (mut this Class_WP_REST_Attachments_Controller) get_attachment_filename(attachment_id i64) string {
	mut attachment_id_mutated := attachment_id
	mut var_path := rt.call_function('wp_get_original_image_path', [
		rt.new_int(attachment_id_mutated).clone()])
	if rt.is_true(var_path) {
		return (rt.call_function('wp_basename', [var_path.clone()])).str()
	}
	var_path = rt.call_function('get_attached_file', [rt.new_int(attachment_id_mutated).clone()])
	if rt.is_true(var_path) {
		return (rt.call_function('wp_basename', [var_path.clone()])).str()
	}
	return (rt.new_null()).str()
}

fn (mut this Class_WP_REST_Attachments_Controller) get_attachment_filesize(attachment_id i64) i64 {
	mut attachment_id_mutated := attachment_id
	mut var_meta := rt.call_function('wp_get_attachment_metadata', [
		rt.new_int(attachment_id_mutated).clone()])
	if var_meta.array_isset(rt.new_string('filesize')) {
		return (var_meta.array_get(rt.new_string('filesize'))).to_i64()
	}
	mut var_original_path := rt.call_function('wp_get_original_image_path', [
		rt.new_int(attachment_id_mutated).clone()])
	mut var_attached_file := if rt.is_true(var_original_path) { var_original_path } else { rt.call_function('get_attached_file', [
			rt.new_int(attachment_id_mutated).clone(),
		]) }
	if var_attached_file.clone().is_string()
		&& rt.is_true(rt.call_function('is_readable', [var_attached_file.clone()])) {
		return (rt.call_function('wp_filesize', [var_attached_file.clone()])).to_i64()
	}
	return (rt.new_null()).to_i64()
}

struct Class_WP_REST_Posts_Controller {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

struct Class_stdClass {
	rt.PhpObjectBase
}

fn create_wp_rest_attachments_controller(_args ...rt.PhpVal) &Class_WP_REST_Attachments_Controller {
	mut obj := &Class_WP_REST_Attachments_Controller{
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

fn create_stdclass(_args ...rt.PhpVal) &Class_stdClass {
	mut obj := &Class_stdClass{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_REST_Attachments_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'register_routes' {
			this.register_routes()
			return rt.new_null()
		}
		'prepare_items_query' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.prepare_items_query(dispatch_arg_0, dispatch_arg_1)
		}
		'create_item_permissions_check' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.create_item_permissions_check(dispatch_arg_0))
		}
		'create_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.create_item(dispatch_arg_0)
		}
		'insert_attachment' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.insert_attachment(dispatch_arg_0)
		}
		'handle_featured_media' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.handle_featured_media(dispatch_arg_0, dispatch_arg_1)
		}
		'update_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.update_item(dispatch_arg_0)
		}
		'post_process_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.post_process_item(dispatch_arg_0)
		}
		'post_process_item_permissions_check' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.post_process_item_permissions_check(dispatch_arg_0)
		}
		'edit_media_item_permissions_check' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.edit_media_item_permissions_check(dispatch_arg_0)
		}
		'edit_media_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.edit_media_item(dispatch_arg_0)
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
		'get_item_schema' {
			return this.get_item_schema()
		}
		'upload_from_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.upload_from_data(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'get_filename_from_disposition' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WP_REST_Attachments_Controller.get_filename_from_disposition(dispatch_arg_0)
		}
		'get_collection_params' {
			return this.get_collection_params()
		}
		'upload_from_file' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.upload_from_file(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'get_media_types' {
			return this.get_media_types()
		}
		'check_upload_size' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.check_upload_size(dispatch_arg_0))
		}
		'get_edit_media_item_args' {
			return this.get_edit_media_item_args()
		}
		'get_attachment_filename' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			return rt.new_string(this.get_attachment_filename(dispatch_arg_0))
		}
		'get_attachment_filesize' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			return rt.new_int(this.get_attachment_filesize(dispatch_arg_0))
		}
		else {
			return none
		}
	}
}

fn (this &Class_WP_REST_Attachments_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'allow_batch' { return this.allow_batch }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_REST_Attachments_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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
