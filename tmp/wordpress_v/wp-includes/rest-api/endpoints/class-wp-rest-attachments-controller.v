import rt

struct Class_WP_REST_Attachments_Controller {
	rt.PhpObjectBase
pub mut:
		allow_batch rt.PhpVal = rt.new_bool(false)
}

fn (mut this Class_WP_REST_Attachments_Controller) register_routes()  {
	this.Class_WP_REST_Posts_Controller.register_routes()
	rt.call_function('register_rest_route', [rt.get_property(rt.new_object('WP_REST_Attachments_Controller', ['WP_REST_Posts_Controller'], &this), 'namespace'), '/' + (rt.get_property(rt.new_object('WP_REST_Attachments_Controller', ['WP_REST_Posts_Controller'], &this), 'rest_base')).str() + '/(?P<id>[\\d]+)/post-process', rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.creatable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Attachments_Controller', ['WP_REST_Posts_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'post_process_item' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Attachments_Controller', ['WP_REST_Posts_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'post_process_item_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Unique identifier for the attachment.')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }]) }, rt.ArrayItem{ key: 'action', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'enum', val: rt.create_array([rt.ArrayItem{ key: none, val: 'create-image-subsizes' }]) }, rt.ArrayItem{ key: 'required', val: true }]) }]) }])])
	rt.call_function('register_rest_route', [rt.get_property(rt.new_object('WP_REST_Attachments_Controller', ['WP_REST_Posts_Controller'], &this), 'namespace'), '/' + (rt.get_property(rt.new_object('WP_REST_Attachments_Controller', ['WP_REST_Posts_Controller'], &this), 'rest_base')).str() + '/(?P<id>[\\d]+)/edit', rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.creatable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Attachments_Controller', ['WP_REST_Posts_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'edit_media_item' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Attachments_Controller', ['WP_REST_Posts_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'edit_media_item_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: this.get_edit_media_item_args() }])])
}

fn (mut this Class_WP_REST_Attachments_Controller) prepare_items_query(var_prepared_args rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
	mut var_request_mutated := var_request
	mut var_query_args := this.Class_WP_REST_Posts_Controller.prepare_items_query(var_prepared_args.dup(), var_request_mutated.dup())
	if !rt.is_true(var_query_args.array_get('post_status')) {
		var_query_args.array_set('post_status', 'inherit')
	}
	mut var_all_mime_types := rt.new_array()
	mut var_media_types := this.get_media_types()
	if rt.is_true(rt.new_bool(!(!rt.is_true(var_request_mutated.array_get('media_type'))) && rt.is_true(rt.new_bool(var_request_mutated.array_get('media_type').is_array())))) {
		{
			mut iter_1 := var_request_mutated.array_get('media_type').iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_type := item_1.val
				if var_media_types.array_isset(var_type) {
					var_all_mime_types = rt.call_function('array_merge', [var_all_mime_types.dup(), var_media_types.array_get(var_type)])
				}
			}
		}
	}
	if rt.is_true(rt.new_bool(!(!rt.is_true(var_request_mutated.array_get('mime_type'))) && rt.is_true(rt.new_bool(var_request_mutated.array_get('mime_type').is_array())))) {
		{
			mut iter_1 := var_request_mutated.array_get('mime_type').iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_mime_type := item_1.val
				mut var_parts := rt.call_function('explode', [rt.new_string('/'), var_mime_type.dup()])
				if rt.is_true(rt.new_bool(var_media_types.array_isset(var_parts.array_get(0)) && rt.is_true(rt.call_function('in_array', [var_mime_type.dup(), var_media_types.array_get(var_parts.array_get(0)), rt.new_bool(true)])))) {
					var_all_mime_types.array_push(var_mime_type.dup())
				}
			}
		}
	}
	if !(!rt.is_true(var_all_mime_types)) {
		var_query_args.array_set('post_mime_type', rt.call_function('array_values', [rt.call_function('array_unique', [var_all_mime_types.dup()])]))
	}
	if var_query_args.array_isset(rt.new_string('s')) {
		rt.call_function('add_filter', [rt.new_string('wp_allow_query_attachment_by_filename'), rt.new_string('__return_true')])
	}
	return var_query_args.dup()
}

fn (mut this Class_WP_REST_Attachments_Controller) create_item_permissions_check(var_request rt.PhpVal) bool {
	mut var_request_mutated := var_request
	mut var_ret := this.Class_WP_REST_Posts_Controller.create_item_permissions_check(var_request_mutated.dup())
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_ret)))) || rt.is_true(rt.call_function('is_wp_error', [var_ret.dup()])))) {
		return (var_ret).to_bool()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('upload_files')]))))) {
		return (create_wp_error(rt.new_string('rest_cannot_create'), rt.call_function('__', [rt.new_string('Sorry, you are not allowed to upload media on this site.')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }]))).to_bool()
	}
	if rt.is_true(rt.new_bool(!(!rt.is_true(var_request_mutated.array_get('post'))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_post'), // unsupported expression: Expr_Cast_Int]))))))) {
		return (create_wp_error(rt.new_string('rest_cannot_edit'), rt.call_function('__', [rt.new_string('Sorry, you are not allowed to upload media to this post.')]), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code', []rt.PhpVal{}) }]))).to_bool()
	}
	mut var_files := rt.call_method(var_request_mutated, 'get_file_params', []rt.PhpVal{})
	mut var_prevent_unsupported_uploads := rt.call_function('apply_filters', [rt.new_string('wp_prevent_unsupported_mime_type_uploads'), rt.new_bool(true), if !(var_files.array_get('file').array_get('type')).is_null() { var_files.array_get('file').array_get('type') } else { rt.new_null() }])
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(var_prevent_unsupported_uploads) && var_files.array_get('file').array_isset(rt.new_string('type')))) && rt.is_true(rt.call_function('str_starts_with', [var_files.array_get('file').array_get('type'), rt.new_string('image/')])))) {
		mut var_editor_non_resizable_formats := ['image/svg+xml']
		if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_files.array_get('file').array_get('type'), var_editor_non_resizable_formats.dup(), rt.new_bool(true)]))))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_image_editor_supports', [rt.create_array([rt.ArrayItem{ key: 'mime_type', val: var_files.array_get('file').array_get('type') }])]))))))) {
			return (create_wp_error(rt.new_string('rest_upload_image_type_not_supported'), rt.call_function('__', [rt.new_string('The web server cannot generate responsive image sizes for this image. Convert it to JPEG or PNG before uploading.')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }]))).to_bool()
		}
	}
	return true
}

fn (mut this Class_WP_REST_Attachments_Controller) create_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_request_mutated := var_request
	if rt.is_true(rt.new_bool(!(!rt.is_true(var_request_mutated.array_get('post'))) && rt.is_true(rt.call_function('in_array', [rt.call_function('get_post_type', [var_request_mutated.array_get('post')]), rt.create_array([rt.ArrayItem{ key: none, val: 'revision' }, rt.ArrayItem{ key: none, val: 'attachment' }]), rt.new_bool(true)])))) {
		return create_wp_error(rt.new_string('rest_invalid_param'), rt.call_function('__', [rt.new_string('Invalid parent type.')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }]))
	}
	mut var_insert := this.insert_attachment(var_request_mutated.dup())
	if rt.is_true(rt.call_function('is_wp_error', [var_insert.dup()])) {
		return var_insert.dup()
	}
	mut var_schema := this.get_item_schema()
	mut var_attachment_id := var_insert.array_get('attachment_id')
	mut var_file := var_insert.array_get('file')
	if var_request_mutated.array_isset(rt.new_string('alt_text')) {
		rt.call_function('update_post_meta', [var_attachment_id.dup(), rt.new_string('_wp_attachment_image_alt'), rt.call_function('sanitize_text_field', [var_request_mutated.array_get('alt_text')])])
	}
	if !(!rt.is_true(var_schema.array_get('properties').array_get('featured_media'))) && var_request_mutated.array_isset(rt.new_string('featured_media')) {
		mut var_thumbnail_update := this.handle_featured_media(var_request_mutated.array_get('featured_media'), var_attachment_id.dup())
		if rt.is_true(rt.call_function('is_wp_error', [var_thumbnail_update.dup()])) {
			return var_thumbnail_update.dup()
		}
	}
	if !(!rt.is_true(var_schema.array_get('properties').array_get('meta'))) && var_request_mutated.array_isset(rt.new_string('meta')) {
		mut var_meta_update := rt.call_method(rt.get_property(rt.new_object('WP_REST_Attachments_Controller', ['WP_REST_Posts_Controller'], &this), 'meta'), 'update_value', [var_request_mutated.array_get('meta'), var_attachment_id.dup()])
		if rt.is_true(rt.call_function('is_wp_error', [var_meta_update.dup()])) {
			return var_meta_update.dup()
		}
	}
	mut var_attachment := rt.call_function('get_post', [var_attachment_id.dup()])
	mut var_fields_update := this.update_additional_fields_for_object(var_attachment.dup(), var_request_mutated.dup())
	if rt.is_true(rt.call_function('is_wp_error', [var_fields_update.dup()])) {
		return var_fields_update.dup()
	}
	mut var_terms_update := this.handle_terms(var_attachment_id.dup(), var_request_mutated.dup())
	if rt.is_true(rt.call_function('is_wp_error', [var_terms_update.dup()])) {
		return var_terms_update.dup()
	}
	rt.call_method(var_request_mutated, 'set_param', [rt.new_string('context'), rt.new_string('edit')])
	rt.call_function('do_action', [rt.new_string('rest_after_insert_attachment'), var_attachment.dup(), var_request_mutated.dup(), rt.new_bool(true)])
	rt.call_function('wp_after_insert_post', [var_attachment.dup(), rt.new_bool(false), rt.new_null()])
	if rt.is_true(rt.call_function('wp_is_serving_rest_request', []rt.PhpVal{})) {
		rt.call_function('header', ['X-WP-Upload-Attachment-ID: ' + (var_attachment_id).str()])
	}
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/media.php', '4')
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/image.php', '4')
	rt.call_function('wp_update_attachment_metadata', [var_attachment_id.dup(), rt.call_function('wp_generate_attachment_metadata', [var_attachment_id.dup(), var_file.dup()])])
	mut var_response := this.prepare_item_for_response(var_attachment.dup(), var_request_mutated.dup())
	var_response = rt.call_function('rest_ensure_response', [var_response.dup()])
	rt.call_method(var_response, 'set_status', [rt.new_int(201)])
	rt.call_method(var_response, 'header', [rt.new_string('Location'), rt.call_function('rest_url', [rt.call_function('sprintf', [rt.new_string('%s/%s/%d'), rt.get_property(rt.new_object('WP_REST_Attachments_Controller', ['WP_REST_Posts_Controller'], &this), 'namespace'), rt.get_property(rt.new_object('WP_REST_Attachments_Controller', ['WP_REST_Posts_Controller'], &this), 'rest_base'), var_attachment_id.dup()])])])
	return var_response.dup()
}

fn (mut this Class_WP_REST_Attachments_Controller) insert_attachment(var_request rt.PhpVal) rt.PhpVal {
	mut var_request_mutated := var_request
	mut var_files := rt.call_method(var_request_mutated, 'get_file_params', []rt.PhpVal{})
	mut var_headers := rt.call_method(var_request_mutated, 'get_headers', []rt.PhpVal{})
	mut var_time := rt.new_null()
	if !(!rt.is_true(var_request_mutated.array_get('post'))) {
		mut var_post := rt.call_function('get_post', [var_request_mutated.array_get('post')])
		if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(var_post) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) && rt.is_true(rt.greater(rt.call_function('substr', [rt.get_property(var_post, 'post_date'), rt.new_int(0), rt.new_int(4)]), rt.new_int(0))))) {
			var_time = rt.get_property(var_post, 'post_date')
		}
	}
	if !(!rt.is_true(var_files)) {
		mut var_file := this.upload_from_file(var_files.dup(), var_headers.dup(), var_time.dup())
	} else {
		var_file = this.upload_from_data(rt.call_method(var_request_mutated, 'get_body', []rt.PhpVal{}), var_headers.dup(), var_time.dup())
	}
	if rt.is_true(rt.call_function('is_wp_error', [var_file.dup()])) {
		return var_file.dup()
	}
	mut var_name := rt.call_function('wp_basename', [var_file.array_get('file')])
	mut var_name_parts := rt.call_function('pathinfo', [var_name.dup()])
	var_name = rt.new_string(rt.new_string(rt.call_function('substr', [var_name.dup(), rt.new_int(0), // unsupported expression: Expr_UnaryMinus]).to_string().trim_space()))
	mut var_url := var_file.array_get('url')
	mut var_type := var_file.array_get('type')
	var_file = var_file.array_get('file')
	mut var_alt := rt.new_string(rt.new_string(''))
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/image.php', '4')
	mut var_image_meta := rt.call_function('wp_read_image_metadata', [var_file.dup()])
	if !(!rt.is_true(var_image_meta)) {
		if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!rt.is_true(var_request_mutated.array_get('title')) && rt.is_true(rt.new_string(var_image_meta.array_get('title').to_string().trim_space())))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.call_function('sanitize_title', [var_image_meta.array_get('title')]).is_long() || rt.call_function('sanitize_title', [var_image_meta.array_get('title')]).is_double()))))))) {
			var_request_mutated.array_set('title', var_image_meta.array_get('title'))
		}
		if rt.is_true(rt.new_bool(!rt.is_true(var_request_mutated.array_get('caption')) && rt.is_true(rt.new_string(var_image_meta.array_get('caption').to_string().trim_space())))) {
			var_request_mutated.array_set('caption', var_image_meta.array_get('caption'))
		}
		if rt.is_true(rt.new_bool(!rt.is_true(var_request_mutated.array_get('alt')) && rt.is_true(rt.new_string(var_image_meta.array_get('alt').to_string().trim_space())))) {
			var_alt = var_image_meta.array_get('alt')
		}
	}
	mut var_attachment := this.prepare_item_for_database(var_request_mutated.dup())
	rt.set_property(var_attachment, 'post_mime_type', var_type.dup())
	rt.set_property(var_attachment, 'guid', var_url.dup())
	if !rt.is_true(rt.get_property(var_attachment, 'post_title')) && !(!rt.is_true(var_files.array_get('file').array_get('name'))) {
		mut var_tmp_title := rt.call_function('substr', [var_files.array_get('file').array_get('name'), rt.new_int(0), rt.call_function('strrpos', [var_files.array_get('file').array_get('name'), rt.new_string('.')])])
		if !(!rt.is_true(var_tmp_title)) {
			rt.set_property(var_attachment, 'post_title', var_tmp_title.dup())
		}
	}
	if !rt.is_true(rt.get_property(var_attachment, 'post_title')) {
		rt.set_property(var_attachment, 'post_title', rt.call_function('preg_replace', [rt.new_string('/\\.[^.]+$/'), rt.new_string(''), rt.call_function('wp_basename', [var_file.dup()])]))
	}
	mut var_id := rt.call_function('wp_insert_attachment', [rt.call_function('wp_slash', [rt.cast_array(var_attachment)]), var_file.dup(), rt.new_int(0), rt.new_bool(true), rt.new_bool(false)])
	if rt.is_true(rt.new_string(var_alt.dup().to_string().trim_space())) {
		rt.call_function('update_post_meta', [var_id.dup(), rt.new_string('_wp_attachment_image_alt'), rt.call_function('sanitize_text_field', [var_alt.dup()])])
	}
	if rt.is_true(rt.call_function('is_wp_error', [var_id.dup()])) {
		if rt.is_true(rt.identical(rt.new_string('db_update_error'), rt.call_method(var_id, 'get_error_code', []rt.PhpVal{}))) {
			rt.call_method(var_id, 'add_data', [rt.create_array([rt.ArrayItem{ key: 'status', val: 500 }])])
		} else {
			rt.call_method(var_id, 'add_data', [rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }])])
		}
		return var_id.dup()
	}
	var_attachment = rt.call_function('get_post', [var_id.dup()])
	rt.call_function('do_action', [rt.new_string('rest_insert_attachment'), var_attachment.dup(), var_request_mutated.dup(), rt.new_bool(true)])
	return rt.create_array([rt.ArrayItem{ key: 'attachment_id', val: var_id }, rt.ArrayItem{ key: 'file', val: var_file }])
}

fn (mut this Class_WP_REST_Attachments_Controller) handle_featured_media(var_featured_media rt.PhpVal, var_post_id rt.PhpVal) rt.PhpVal {
	mut var_post_type := rt.call_function('get_post_type', [var_post_id.dup()])
	mut var_thumbnail_support := rt.new_bool(rt.new_bool(rt.is_true(rt.call_function('current_theme_supports', [rt.new_string('post-thumbnails'), var_post_type.dup()])) && rt.is_true(rt.call_function('post_type_supports', [var_post_type.dup(), rt.new_string('thumbnail')]))))
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_thumbnail_support)))) && rt.is_true(rt.call_function('get_post_mime_type', [var_post_id.dup()])))) {
		if rt.is_true(rt.call_function('wp_attachment_is', [rt.new_string('audio'), var_post_id.dup()])) {
			var_thumbnail_support = rt.new_bool(rt.new_bool(rt.is_true(rt.call_function('post_type_supports', [rt.new_string('attachment:audio'), rt.new_string('thumbnail')])) || rt.is_true(rt.call_function('current_theme_supports', [rt.new_string('post-thumbnails'), rt.new_string('attachment:audio')]))))
		} else if rt.is_true(rt.call_function('wp_attachment_is', [rt.new_string('video'), var_post_id.dup()])) {
			var_thumbnail_support = rt.new_bool(rt.new_bool(rt.is_true(rt.call_function('post_type_supports', [rt.new_string('attachment:video'), rt.new_string('thumbnail')])) || rt.is_true(rt.call_function('current_theme_supports', [rt.new_string('post-thumbnails'), rt.new_string('attachment:video')]))))
		}
	}
	if rt.is_true(var_thumbnail_support) {
		return this.Class_WP_REST_Posts_Controller.handle_featured_media(var_featured_media.dup(), var_post_id.dup())
	}
	return create_wp_error(rt.new_string('rest_no_featured_media'), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('This site does not support post thumbnails on attachments with MIME type %s.')]), rt.call_function('get_post_mime_type', [var_post_id.dup()])]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }]))
}

fn (mut this Class_WP_REST_Attachments_Controller) update_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_schema := rt.new_null()
	mut var_request_mutated := var_request
	if rt.is_true(rt.new_bool(!(!rt.is_true(var_request_mutated.array_get('post'))) && rt.is_true(rt.call_function('in_array', [rt.call_function('get_post_type', [var_request_mutated.array_get('post')]), rt.create_array([rt.ArrayItem{ key: none, val: 'revision' }, rt.ArrayItem{ key: none, val: 'attachment' }]), rt.new_bool(true)])))) {
		return create_wp_error(rt.new_string('rest_invalid_param'), rt.call_function('__', [rt.new_string('Invalid parent type.')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }]))
	}
	mut var_attachment_before := rt.call_function('get_post', [var_request_mutated.array_get('id')])
	mut var_response := this.Class_WP_REST_Posts_Controller.update_item(var_request_mutated.dup())
	if rt.is_true(rt.call_function('is_wp_error', [var_response.dup()])) {
		return var_response.dup()
	}
	var_response = rt.call_function('rest_ensure_response', [.dup()])
	mut var_data := 
	if .array_isset() {
	}
	
}

fn (mut this Class_WP_REST_Attachments_Controller) post_process_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_request_mutated := var_request
}

fn (mut this Class_WP_REST_Attachments_Controller) post_process_item_permissions_check(var_request rt.PhpVal) rt.PhpVal {
	mut var_request_mutated := var_request
}

fn (mut this Class_WP_REST_Attachments_Controller) edit_media_item_permissions_check(var_request rt.PhpVal) rt.PhpVal {
	mut var_request_mutated := var_request
}

fn (mut this Class_WP_REST_Attachments_Controller) edit_media_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_request_mutated := var_request
}

fn (mut this Class_WP_REST_Attachments_Controller) prepare_item_for_database(var_request rt.PhpVal) rt.PhpVal {
	mut var_request_mutated := var_request
}

fn (mut this Class_WP_REST_Attachments_Controller) prepare_item_for_response(var_item rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
	mut var_request_mutated := var_request
}

fn (mut this Class_WP_REST_Attachments_Controller) prepare_links(var_post rt.PhpVal) rt.PhpVal {
	mut var_post_mutated := var_post
}

fn (mut this Class_WP_REST_Attachments_Controller) get_item_schema() rt.PhpVal {
}

fn (mut this Class_WP_REST_Attachments_Controller) upload_from_data(var_data rt.PhpVal, var_headers rt.PhpVal, var_time rt.PhpVal) rt.PhpVal {
	mut var_data_mutated := var_data
	mut var_headers_mutated := var_headers
	mut var_time_mutated := var_time
}

fn Class_WP_REST_Attachments_Controller.get_filename_from_disposition(var_disposition_header rt.PhpVal) rt.PhpVal {
	mut var_key := rt.new_null()
}

fn (mut this Class_WP_REST_Attachments_Controller) get_collection_params() rt.PhpVal {
}

fn (mut this Class_WP_REST_Attachments_Controller) upload_from_file(var_files rt.PhpVal, var_headers rt.PhpVal, var_time rt.PhpVal) rt.PhpVal {
	mut var_files_mutated := var_files
	mut var_headers_mutated := var_headers
	mut var_time_mutated := var_time
}

fn (mut this Class_WP_REST_Attachments_Controller) get_media_types() rt.PhpVal {
}

fn (mut this Class_WP_REST_Attachments_Controller) check_upload_size(var_file rt.PhpVal) bool {
	mut var_file_mutated := var_file
}

fn (mut this Class_WP_REST_Attachments_Controller) get_edit_media_item_args() rt.PhpVal {
}

fn (mut this Class_WP_REST_Attachments_Controller) get_attachment_filename(attachment_id i64) string {
	mut attachment_id_mutated := attachment_id
}

fn (mut this Class_WP_REST_Attachments_Controller) get_attachment_filesize(attachment_id i64) i64 {
	mut attachment_id_mutated := attachment_id
}

struct Class_WP_REST_Posts_Controller {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

fn create_wp_rest_attachments_controller() &Class_WP_REST_Attachments_Controller {
	mut obj := &Class_WP_REST_Attachments_Controller{
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
		else { return none }
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




pub fn init_wp_includes_rest_api_endpoints_class_wp_rest_attachments_controller_php() {
}
