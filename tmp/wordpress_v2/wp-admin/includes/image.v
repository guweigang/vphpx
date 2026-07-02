import rt
import crypto.md5

fn wp_crop_image(var_src_arg rt.PhpVal, var_src_x rt.PhpVal, var_src_y rt.PhpVal, var_src_w rt.PhpVal, var_src_h rt.PhpVal, var_dst_w rt.PhpVal, var_dst_h rt.PhpVal, src_abs bool, dst_file bool) rt.PhpVal {
	mut var_src_abs := src_abs
	mut var_dst_file := dst_file
	mut var_src := var_src_arg
	mut var_src_file := rt.new_null()
	mut var_editor := rt.new_null()
	mut var_result := rt.new_null()
	var_src_file = var_src.clone()
	if rt.is_true(rt.new_bool(var_src.clone().is_long() || var_src.clone().is_double())) {
		var_src_file = rt.call_function('get_attached_file', [
			var_src.clone()])
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('file_exists', [
			var_src_file.clone(),
		])))))
		{
			var_src = _load_image_to_edit_path(var_src.clone(), 'full')
		} else {
			var_src = var_src_file.clone()
		}
	}
	var_editor = rt.call_function('wp_get_image_editor', [var_src.clone()])
	if rt.is_true(rt.call_function('is_wp_error', [var_editor.clone()])) {
		return var_editor.clone()
	}
	var_src = rt.call_method(var_editor, 'crop', [var_src_x.clone(),
		var_src_y.clone(), var_src_w.clone(), var_src_h.clone(),
		var_dst_w.clone(), var_dst_h.clone(), rt.new_bool(src_abs)])
	if rt.is_true(rt.call_function('is_wp_error', [var_src.clone()])) {
		return var_src.clone()
	}
	if !var_dst_file {
		var_dst_file = (rt.call_function('str_replace', [
			rt.call_function('wp_basename', [var_src_file.clone()]),
			rt.new_string('cropped-' +
				(rt.call_function('wp_basename', [var_src_file.clone()])).str()),
			var_src_file.clone(),
		])).to_bool()
	}
	rt.call_function('wp_mkdir_p', [
		rt.call_function('dirname', [rt.new_bool(var_dst_file)]),
	])
	var_dst_file = (rt.call_function('dirname', [rt.new_bool(var_dst_file)])).str() + '/' +(rt.call_function('wp_unique_filename', [rt.call_function('dirname', [rt.new_bool(var_dst_file)]), rt.call_function('wp_basename', [rt.new_bool(var_dst_file)])])).str()
	var_result = rt.call_method(var_editor, 'save', [rt.new_bool(var_dst_file)])
	if rt.is_true(rt.call_function('is_wp_error', [var_result.clone()])) {
		return var_result.clone()
	}
	if !(!rt.is_true(var_result.array_get(rt.new_string('path')))) {
		return var_result.array_get(rt.new_string('path'))
	}
	return rt.new_bool(var_dst_file)
}

fn wp_get_missing_image_subsizes(var_attachment_id rt.PhpVal) rt.PhpVal {
	mut var_registered_sizes := rt.new_null()
	mut var_image_meta := rt.new_null()
	mut var_image_file := rt.new_null()
	mut var_imagesize := rt.new_null()
	mut var_full_width := rt.new_null()
	mut var_full_height := rt.new_null()
	mut var_possible_sizes := rt.new_null()
	mut var_size_data := map[string]rt.PhpVal{}
	mut var_size_name := rt.new_null()
	mut var_missing_sizes := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_attachment_is_image', [
		var_attachment_id.clone(),
	])))))
	{
		return rt.new_array()
	}
	var_registered_sizes = rt.call_function('wp_get_registered_image_subsizes', []rt.PhpVal{})
	var_image_meta = rt.call_function('wp_get_attachment_metadata', [
		var_attachment_id.clone()])
	if !rt.is_true(var_image_meta) {
		return var_registered_sizes.clone()
	}
	if !(!rt.is_true(var_image_meta.array_get(rt.new_string('original_image')))) {
		var_image_file = rt.call_function('wp_get_original_image_path', [
			var_attachment_id.clone()])
		var_imagesize = rt.call_function('wp_getimagesize', [
			var_image_file.clone()])
	}
	if !(!rt.is_true(var_imagesize)) {
		var_full_width = var_imagesize.array_get(rt.new_int(0))
		var_full_height = var_imagesize.array_get(rt.new_int(1))
	} else {
		var_full_width = rt.new_int((var_image_meta.array_get(rt.new_string('width'))).to_i64())
		var_full_height = rt.new_int((var_image_meta.array_get(rt.new_string('height'))).to_i64())
	}
	var_possible_sizes = rt.new_array()
	mut iter_1 := var_registered_sizes.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_size_data_shadow := item_1.val
		mut var_size_name_shadow := item_1.key
		if rt.is_true(rt.call_function('image_resize_dimensions', [
			var_full_width.clone(), var_full_height.clone(), var_size_data_shadow['width'],
			var_size_data_shadow['height'], var_size_data_shadow['crop']]))
		{
			var_possible_sizes.array_set(var_size_name_shadow, var_size_data_shadow.clone())
		}
	}
	if !rt.is_true(var_image_meta.array_get(rt.new_string('sizes'))) {
		var_image_meta.array_set('sizes', rt.new_array())
	}
	var_missing_sizes = rt.call_function('array_diff_key', [var_possible_sizes.clone(),
		var_image_meta.array_get(rt.new_string('sizes'))])
	return rt.call_function('apply_filters', [
		rt.new_string('wp_get_missing_image_subsizes'),
		var_missing_sizes.clone(),
		var_image_meta.clone(),
		var_attachment_id.clone(),
	])
}

fn wp_update_image_subsizes(var_attachment_id rt.PhpVal) rt.PhpVal {
	mut var_image_meta := rt.new_null()
	mut var_image_file := rt.new_null()
	mut var_missing_sizes := rt.new_null()
	var_image_meta = rt.call_function('wp_get_attachment_metadata', [
		var_attachment_id.clone()])
	var_image_file = rt.call_function('wp_get_original_image_path', [
		var_attachment_id.clone()])
	if !rt.is_true(var_image_meta) || !(var_image_meta.clone().is_array()) {
		if !(!rt.is_true(var_image_file)) {
			var_image_meta = wp_create_image_subsizes(var_image_file.clone(),
				var_attachment_id.clone())
		} else {
			return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('invalid_attachment'), rt.call_function('__', [
				rt.new_string('The attached file cannot be found.'),
			])))
		}
	} else {
		var_missing_sizes = wp_get_missing_image_subsizes(var_attachment_id.clone())
		if !rt.is_true(var_missing_sizes) {
			return var_image_meta.clone()
		}
		var_image_meta = _wp_make_subsizes(var_missing_sizes.clone(), var_image_file.clone(),
			var_image_meta.clone(), var_attachment_id.clone())
	}
	var_image_meta = rt.call_function('apply_filters', [
		rt.new_string('wp_generate_attachment_metadata'),
		var_image_meta.clone(),
		var_attachment_id.clone(),
		rt.new_string('update'),
	])
	rt.call_function('wp_update_attachment_metadata', [var_attachment_id.clone(),
		var_image_meta.clone()])
	return var_image_meta.clone()
}

fn _wp_image_meta_replace_original(var_saved_data rt.PhpVal, var_original_file rt.PhpVal, var_image_meta rt.PhpVal, var_attachment_id rt.PhpVal) rt.PhpVal {
	mut var_new_file := rt.new_null()
	var_new_file = var_saved_data.array_get(rt.new_string('path'))
	rt.call_function('update_attached_file', [var_attachment_id.clone(),
		var_new_file.clone()])
	var_image_meta.array_set('width', var_saved_data.array_get(rt.new_string('width')))
	var_image_meta.array_set('height', var_saved_data.array_get(rt.new_string('height')))
	var_image_meta.array_set('file', rt.call_function('_wp_relative_upload_path', [
		var_new_file.clone(),
	]))
	var_image_meta.array_set('filesize', rt.call_function('wp_filesize', [
		var_new_file.clone()]))
	var_image_meta.array_set('original_image', rt.call_function('wp_basename', [
		var_original_file.clone(),
	]))
	return var_image_meta.clone()
}

fn wp_create_image_subsizes(var_file rt.PhpVal, var_attachment_id rt.PhpVal) rt.PhpVal {
	mut var_imagesize := rt.new_null()
	mut var_image_meta := rt.new_null()
	mut var_exif_meta := rt.new_null()
	mut var_threshold := rt.new_null()
	mut var_scale_down := false
	mut var_convert := false
	mut var_output_format := rt.new_null()
	mut var_editor := rt.new_null()
	mut var_resized := rt.new_null()
	mut var_rotated := rt.new_null()
	mut var_saved := rt.new_null()
	mut var_new_sizes := rt.new_null()
	var_imagesize = rt.call_function('wp_getimagesize', [var_file.clone()])
	if !rt.is_true(var_imagesize) {
		return rt.new_array()
	}
	var_image_meta = rt.create_array([
		rt.ArrayItem{ key: 'width', val: var_imagesize.array_get(rt.new_int(0)) },
		rt.ArrayItem{ key: 'height', val: var_imagesize.array_get(rt.new_int(1)) },
		rt.ArrayItem{ key: 'file', val: rt.call_function('_wp_relative_upload_path', [
			var_file.clone(),
		]) },
		rt.ArrayItem{ key: 'filesize', val: rt.call_function('wp_filesize', [
			var_file.clone(),
		]) },
		rt.ArrayItem{ key: 'sizes', val: rt.new_array() },
	])
	var_exif_meta = rt.new_bool(wp_read_image_metadata(var_file.clone()))
	if rt.is_true(var_exif_meta) {
		var_image_meta.array_set('image_meta', var_exif_meta.clone())
	}
	var_threshold = rt.new_int((rt.call_function('apply_filters', [
		rt.new_string('big_image_size_threshold'),
		rt.new_int(2560),
		var_imagesize.clone(),
		var_file.clone(),
		var_attachment_id.clone(),
	])).to_i64())
	var_scale_down = false
	var_convert = false
	if rt.is_true(var_threshold)
		&& rt.is_true(rt.greater(var_image_meta.array_get(rt.new_string('width')), var_threshold))
		|| rt.is_true(rt.greater(var_image_meta.array_get(rt.new_string('height')), var_threshold)) {
		var_scale_down = true
	} else {
		var_output_format = rt.call_function('wp_get_image_editor_output_format', [
			var_file.clone(),
			var_imagesize.array_get(rt.new_string('mime')),
		])
		if var_output_format.clone().is_array()
			&& rt.is_true(rt.new_bool(var_output_format.clone().array_isset(var_imagesize.array_get(rt.new_string('mime')))))
			&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_output_format.array_get(var_imagesize.array_get(rt.new_string('mime'))), var_imagesize.array_get(rt.new_string('mime')))))) {
			var_convert = true
		}
	}
	if var_scale_down || var_convert {
		var_editor = rt.call_function('wp_get_image_editor', [
			var_file.clone()])
		if rt.is_true(rt.call_function('is_wp_error', [var_editor.clone()])) {
			return var_image_meta.clone()
		}
		if var_scale_down {
			var_resized = rt.call_method(var_editor, 'resize', [
				var_threshold.clone(), var_threshold.clone()])
		} else if var_convert {
			var_resized = rt.new_bool(true)
		}
		var_rotated = rt.new_null()
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [var_resized.clone()])))))
			&& var_exif_meta.clone().is_array() {
			var_resized = rt.call_method(var_editor, 'maybe_exif_rotate', []rt.PhpVal{})
			var_rotated = var_resized.clone()
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [
			var_resized.clone(),
		])))))
		{
			if var_scale_down {
				var_saved = rt.call_method(var_editor, 'save', [
					rt.call_method(var_editor, 'generate_filename', [
						rt.new_string('scaled'),
					]),
				])
			} else if var_convert {
				var_saved = rt.call_method(var_editor, 'save', [
					rt.call_method(var_editor, 'generate_filename', [
						rt.new_string('')]),
				])
			} else {
				var_saved = rt.call_method(var_editor, 'save', []rt.PhpVal{})
			}
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [
				var_saved.clone(),
			])))))
			{
				var_image_meta = _wp_image_meta_replace_original(var_saved.clone(),
					var_file.clone(), var_image_meta.clone(), var_attachment_id.clone())
				if rt.is_true(rt.identical(rt.new_bool(true), var_rotated))
					&& !(!rt.is_true(var_image_meta.array_get(rt.new_string('image_meta')).array_get(rt.new_string('orientation')))) {
					var_image_meta.array_get_mut('image_meta').array_set('orientation', 1)
				}
			} else {
			}
		} else {
		}
	} else if !(!rt.is_true(var_exif_meta.array_get(rt.new_string('orientation'))))
		&& rt.is_true(rt.new_bool(1 != rt.new_int((var_exif_meta.array_get(rt.new_string('orientation'))).to_i64()))) {
		var_editor = rt.call_function('wp_get_image_editor', [
			var_file.clone()])
		if rt.is_true(rt.call_function('is_wp_error', [var_editor.clone()])) {
			return var_image_meta.clone()
		}
		var_rotated = rt.call_method(var_editor, 'maybe_exif_rotate', []rt.PhpVal{})
		if rt.is_true(rt.identical(rt.new_bool(true), var_rotated)) {
			var_saved = rt.call_method(var_editor, 'save', [
				rt.call_method(var_editor, 'generate_filename', [
					rt.new_string('rotated'),
				]),
			])
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [
				var_saved.clone(),
			])))))
			{
				var_image_meta = _wp_image_meta_replace_original(var_saved.clone(),
					var_file.clone(), var_image_meta.clone(), var_attachment_id.clone())
				if !(!rt.is_true(var_image_meta.array_get(rt.new_string('image_meta')).array_get(rt.new_string('orientation')))) {
					var_image_meta.array_get_mut('image_meta').array_set('orientation', 1)
				}
			} else {
			}
		}
	}
	rt.call_function('wp_update_attachment_metadata', [var_attachment_id.clone(),
		var_image_meta.clone()])
	var_new_sizes = rt.call_function('wp_get_registered_image_subsizes', []rt.PhpVal{})
	var_new_sizes = rt.call_function('apply_filters', [
		rt.new_string('intermediate_image_sizes_advanced'),
		var_new_sizes.clone(),
		var_image_meta.clone(),
		var_attachment_id.clone(),
	])
	return _wp_make_subsizes(var_new_sizes.clone(), var_file.clone(), var_image_meta.clone(),
		var_attachment_id.clone())
}

fn _wp_make_subsizes(var_new_sizes_arg rt.PhpVal, var_file rt.PhpVal, var_image_meta rt.PhpVal, var_attachment_id rt.PhpVal) rt.PhpVal {
	mut var_new_sizes := var_new_sizes_arg
	mut var_size_meta := rt.new_null()
	mut var_size_name := rt.new_null()
	mut var_priority := map[string]rt.PhpVal{}
	mut var_editor := rt.new_null()
	mut var_rotated := rt.new_null()
	mut var_new_size_data := rt.new_null()
	mut var_new_size_name := rt.new_null()
	mut var_new_size_meta := rt.new_null()
	mut var_created_sizes := rt.new_null()
	if !rt.is_true(var_image_meta) || !(var_image_meta.clone().is_array()) {
		return rt.new_array()
	}
	if var_image_meta.array_isset(rt.new_string('sizes'))
		&& var_image_meta.array_get(rt.new_string('sizes')).is_array() {
		mut iter_2 := var_image_meta.array_get(rt.new_string('sizes')).iterator()
		for {
			item_2 := iter_2.next() or { break }
			mut var_size_meta_shadow := item_2.val
			mut var_size_name_shadow := item_2.key
			if rt.is_true(rt.new_bool(var_new_sizes.clone().array_isset(var_size_name_shadow.clone()))) {
				var_new_sizes.array_unset(var_size_name_shadow)
			}
		}
	} else {
		var_image_meta.array_set('sizes', rt.new_array())
	}
	if !rt.is_true(var_new_sizes) {
		return var_image_meta.clone()
	}
	var_priority = {
		'medium':       rt.new_null()
		'large':        rt.new_null()
		'thumbnail':    rt.new_null()
		'medium_large': rt.new_null()
	}
	var_new_sizes = rt.call_function('array_filter', [
		rt.call_function('array_merge', [rt.create_array_from_native_map(var_priority),
			var_new_sizes.clone()]),
	])
	var_editor = rt.call_function('wp_get_image_editor', [var_file.clone()])
	if rt.is_true(rt.call_function('is_wp_error', [var_editor.clone()])) {
		return var_image_meta.clone()
	}
	if !(!rt.is_true(var_image_meta.array_get(rt.new_string('image_meta')))) {
		var_rotated = rt.call_method(var_editor, 'maybe_exif_rotate', []rt.PhpVal{})
		if rt.is_true(rt.call_function('is_wp_error', [var_rotated.clone()])) {
		}
	}
	if rt.is_true(rt.call_function('method_exists', [var_editor.clone(),
		rt.new_string('make_subsize')]))
	{
		mut iter_3 := var_new_sizes.iterator()
		for {
			item_3 := iter_3.next() or { break }
			mut var_new_size_data_shadow := item_3.val
			mut var_new_size_name_shadow := item_3.key
			var_new_size_meta = rt.call_method(var_editor, 'make_subsize', [
				var_new_size_data_shadow.clone()])
			if rt.is_true(rt.call_function('is_wp_error', [var_new_size_meta.clone()])) {
			} else {
				var_image_meta.array_get_mut('sizes').array_set(var_new_size_name_shadow,
					var_new_size_meta.clone())
				rt.call_function('wp_update_attachment_metadata', [
					var_attachment_id.clone(), var_image_meta.clone()])
			}
		}
	} else {
		var_created_sizes = rt.call_method(var_editor, 'multi_resize', [
			var_new_sizes.clone()])
		if !(!rt.is_true(var_created_sizes)) {
			var_image_meta.array_set('sizes', rt.call_function('array_merge', [
				var_image_meta.array_get(rt.new_string('sizes')),
				var_created_sizes.clone(),
			]))
			rt.call_function('wp_update_attachment_metadata', [
				var_attachment_id.clone(), var_image_meta.clone()])
		}
	}
	return var_image_meta.clone()
}

fn wp_copy_parent_attachment_properties(var_cropped rt.PhpVal, var_parent_attachment_id rt.PhpVal, context string) rt.PhpVal {
	mut var_context := context
	mut var_parent := rt.new_null()
	mut var_parent_url := rt.new_null()
	mut var_parent_basename := rt.new_null()
	mut var_url := rt.new_null()
	mut var_size := rt.new_null()
	mut var_image_type := rt.new_null()
	mut var_sanitized_post_title := rt.new_null()
	mut var_use_original_title := false
	mut var_use_original_description := rt.new_null()
	mut var_attachment := rt.new_null()
	var_parent = rt.call_function('get_post', [var_parent_attachment_id.clone()])
	var_parent_url = rt.call_function('wp_get_attachment_url', [
		rt.get_property(var_parent, 'ID'),
	])
	var_parent_basename = rt.call_function('wp_basename', [var_parent_url.clone()])
	var_url = rt.call_function('str_replace', [
		rt.call_function('wp_basename', [var_parent_url.clone()]),
		rt.call_function('wp_basename', [var_cropped.clone()]),
		var_parent_url.clone(),
	])
	var_size = rt.call_function('wp_getimagesize', [var_cropped.clone()])
	var_image_type = if rt.is_true(var_size) {
		var_size.array_get(rt.new_string('mime'))
	} else {
		rt.new_string('image/jpeg')
	}
	var_sanitized_post_title = rt.call_function('sanitize_file_name', [
		rt.get_property(var_parent, 'post_title'),
	])
	var_use_original_title =
		rt.is_true(rt.new_bool('' != rt.get_property(var_parent, 'post_title').to_string().trim_space()))
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_parent_basename, var_sanitized_post_title))))
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('pathinfo', [var_parent_basename.clone(), rt.get_constant('PATHINFO_FILENAME')]), var_sanitized_post_title))))
	var_use_original_description =
		rt.new_bool('' != rt.get_property(var_parent, 'post_content').to_string().trim_space())
	var_attachment = rt.create_array([
		rt.ArrayItem{
			key: 'post_title'
			val: if var_use_original_title { rt.get_property(var_parent, 'post_title') } else { rt.call_function('wp_basename', [
					var_cropped.clone(),
				]) }
		},
		rt.ArrayItem{
			key: 'post_content'
			val: if rt.is_true(var_use_original_description) {
				rt.get_property(var_parent, 'post_content')
			} else {
				var_url
			}
		},
		rt.ArrayItem{ key: 'post_mime_type', val: var_image_type },
		rt.ArrayItem{ key: 'guid', val: var_url },
		rt.ArrayItem{ key: 'context', val: context },
	])
	if rt.is_true(rt.new_bool('' != rt.get_property(var_parent, 'post_excerpt').to_string().trim_space())) {
		var_attachment.array_set('post_excerpt', rt.get_property(var_parent, 'post_excerpt'))
	}
	if rt.is_true(rt.new_bool('' != rt.get_property(var_parent, '_wp_attachment_image_alt').to_string().trim_space())) {
		var_attachment.array_set('meta_input', rt.create_array([
			rt.ArrayItem{ key: '_wp_attachment_image_alt', val: rt.call_function('wp_slash', [
				rt.get_property(var_parent, '_wp_attachment_image_alt'),
			]) },
		]))
	}
	var_attachment.array_set('post_parent', var_parent_attachment_id.clone())
	return var_attachment.clone()
}

fn wp_generate_attachment_metadata(var_attachment_id rt.PhpVal, var_file rt.PhpVal) rt.PhpVal {
	mut var_attachment := rt.new_null()
	mut var_metadata := rt.new_null()
	mut var_support := false
	mut var_mime_type := rt.new_null()
	mut var_hash := ''
	mut var_posts := rt.new_null()
	mut var_exists := rt.new_null()
	mut var_ext := rt.new_null()
	mut var_basename := rt.new_null()
	mut var_uploaded := rt.new_null()
	mut var_image_attachment := rt.new_null()
	mut var_sub_attachment_id := rt.new_null()
	mut var_attach_data := rt.new_null()
	mut var_fallback_sizes := rt.new_null()
	mut var_registered_sizes := rt.new_null()
	mut var_merged_sizes := rt.new_null()
	mut var_editor := rt.new_null()
	mut var_dirname := rt.new_null()
	mut var_preview_file := rt.new_null()
	mut var_image_file := rt.new_null()
	var_attachment = rt.call_function('get_post', [var_attachment_id.clone()])
	var_metadata = rt.new_array()
	var_support = false
	var_mime_type = rt.call_function('get_post_mime_type', [var_attachment.clone()])
	if rt.is_true(rt.identical(rt.new_string('image/heic'), var_mime_type))|| (rt.is_true(rt.call_function('preg_match', [rt.new_string('!^image/!'), var_mime_type.clone()]))
		&& rt.is_true(file_is_displayable_image(var_file.clone()))) {
		var_metadata = wp_create_image_subsizes(var_file.clone(), var_attachment_id.clone())
	} else if rt.is_true(rt.call_function('wp_attachment_is', [
		rt.new_string('video'), var_attachment.clone()]))
	{
		var_metadata = rt.call_function('wp_read_video_metadata', [
			var_file.clone()])
		var_support =
			rt.is_true(rt.call_function('current_theme_supports', [rt.new_string('post-thumbnails'), rt.new_string('attachment:video')]))
			|| rt.is_true(rt.call_function('post_type_supports', [rt.new_string('attachment:video'), rt.new_string('thumbnail')]))
	} else if rt.is_true(rt.call_function('wp_attachment_is', [
		rt.new_string('audio'), var_attachment.clone()]))
	{
		var_metadata = rt.call_function('wp_read_audio_metadata', [
			var_file.clone()])
		var_support =
			rt.is_true(rt.call_function('current_theme_supports', [rt.new_string('post-thumbnails'), rt.new_string('attachment:audio')]))
			|| rt.is_true(rt.call_function('post_type_supports', [rt.new_string('attachment:audio'), rt.new_string('thumbnail')]))
	}
	if !(var_metadata.clone().is_array()) {
		var_metadata = rt.new_array()
	}
	if var_support
		&& !(!rt.is_true(var_metadata.array_get(rt.new_string('image')).array_get(rt.new_string('data')))) {
		var_hash =
			md5.hexhash(var_metadata.array_get(rt.new_string('image')).array_get(rt.new_string('data')).to_string())
		var_posts = rt.call_function('get_posts', [
			rt.create_array([rt.ArrayItem{ key: 'fields', val: 'ids' },
				rt.ArrayItem{ key: 'post_type', val: 'attachment' },
				rt.ArrayItem{
					key: 'post_mime_type'
					val: var_metadata.array_get(rt.new_string('image')).array_get(rt.new_string('mime'))
				}, rt.ArrayItem{ key: 'post_status', val: 'inherit' },
				rt.ArrayItem{ key: 'posts_per_page', val: 1 },
				rt.ArrayItem{ key: 'meta_key', val: '_cover_hash' },
				rt.ArrayItem{ key: 'meta_value', val: var_hash }]),
		])
		var_exists = rt.call_function('reset', [var_posts.clone()])
		if !(!rt.is_true(var_exists)) {
			rt.call_function('update_post_meta', [var_attachment_id.clone(),
				rt.new_string('_thumbnail_id'), var_exists.clone()])
		} else {
			var_ext = rt.new_string('.jpg')
			mut switch_val_1 :=
				var_metadata.array_get(rt.new_string('image')).array_get(rt.new_string('mime'))
			if rt.is_true(rt.equal(switch_val_1, rt.new_string('image/gif'))) {
				var_ext = rt.new_string('.gif')
			} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('image/png'))) {
				var_ext = rt.new_string('.png')
			} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('image/webp'))) {
				var_ext = rt.new_string('.webp')
			}
			var_basename = rt.new_string(
				(rt.call_function('str_replace', [rt.new_string('.'), rt.new_string('-'), rt.call_function('wp_basename', [var_file.clone()])])).str() +
				'-image' + var_ext.str())
			var_uploaded = rt.call_function('wp_upload_bits', [
				var_basename.clone(), rt.new_string(''), var_metadata.array_get(rt.new_string('image')).array_get(rt.new_string('data'))])
			if rt.is_true(rt.identical(rt.new_bool(false),
				var_uploaded.array_get(rt.new_string('error'))))
			{
				var_image_attachment = rt.create_array([
					rt.ArrayItem{
						key: 'post_mime_type'
						val: var_metadata.array_get(rt.new_string('image')).array_get(rt.new_string('mime'))
					},
					rt.ArrayItem{ key: 'post_type', val: 'attachment' },
					rt.ArrayItem{ key: 'post_content', val: '' },
				])
				var_image_attachment = rt.call_function('apply_filters', [
					rt.new_string('attachment_thumbnail_args'),
					var_image_attachment.clone(),
					var_metadata.clone(),
					var_uploaded.clone(),
				])
				var_sub_attachment_id = rt.call_function('wp_insert_attachment', [
					var_image_attachment.clone(),
					var_uploaded.array_get(rt.new_string('file')),
				])
				rt.call_function('add_post_meta', [var_sub_attachment_id.clone(),
					rt.new_string('_cover_hash'), rt.new_string(var_hash.str()).clone()])
				var_attach_data = wp_generate_attachment_metadata(var_sub_attachment_id.clone(),
					var_uploaded.array_get(rt.new_string('file')))
				rt.call_function('wp_update_attachment_metadata', [
					var_sub_attachment_id.clone(), var_attach_data.clone()])
				rt.call_function('update_post_meta', [var_attachment_id.clone(),
					rt.new_string('_thumbnail_id'), var_sub_attachment_id.clone()])
			}
		}
	} else if rt.is_true(rt.identical(rt.new_string('application/pdf'), var_mime_type)) {
		var_fallback_sizes = rt.create_array([
			rt.ArrayItem{ key: none, val: 'thumbnail' },
			rt.ArrayItem{ key: none, val: 'medium' },
			rt.ArrayItem{ key: none, val: 'large' },
		])
		var_fallback_sizes = rt.call_function('apply_filters', [
			rt.new_string('fallback_intermediate_image_sizes'),
			var_fallback_sizes.clone(),
			var_metadata.clone(),
		])
		var_registered_sizes = rt.call_function('wp_get_registered_image_subsizes', []rt.PhpVal{})
		var_merged_sizes = rt.call_function('array_intersect_key', [
			var_registered_sizes.clone(), rt.call_function('array_flip', [
				var_fallback_sizes.clone()])])
		if var_merged_sizes.array_isset(rt.new_string('thumbnail'))
			&& var_merged_sizes.array_get(rt.new_string('thumbnail')).is_array() {
			var_merged_sizes.array_get_mut('thumbnail').array_set('crop', false)
		}
		if !(!rt.is_true(var_merged_sizes)) {
			var_editor = rt.call_function('wp_get_image_editor', [
				var_file.clone()])
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [
				var_editor.clone(),
			])))))
			{
				var_dirname = rt.new_string(
					(rt.call_function('dirname', [var_file.clone()])).str() + '/')
				var_ext =
					rt.new_string('.' +(rt.call_function('pathinfo', [var_file.clone(), rt.get_constant('PATHINFO_EXTENSION')])).str())
				var_preview_file = rt.new_string(var_dirname.str() +
					(rt.call_function('wp_unique_filename', [var_dirname.clone(), rt.new_string((rt.call_function('wp_basename', [var_file.clone(), var_ext.clone()])).str() +
					'-pdf.jpg')])).str())
				var_uploaded = rt.call_method(var_editor, 'save', [
					var_preview_file.clone(), rt.new_string('image/jpeg')])
				var_editor = rt.new_null()
				if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [
					var_uploaded.clone(),
				])))))
				{
					var_image_file = var_uploaded.array_get(rt.new_string('path'))
					var_uploaded.array_unset(rt.new_string('path'))
					var_metadata.array_set('sizes', rt.create_array([
						rt.ArrayItem{ key: 'full', val: var_uploaded },
					]))
					rt.call_function('wp_update_attachment_metadata', [
						var_attachment_id.clone(), var_metadata.clone()])
					var_metadata = _wp_make_subsizes(var_merged_sizes.clone(),
						var_image_file.clone(), var_metadata.clone(), var_attachment_id.clone())
				}
			}
		}
	}
	var_metadata.array_get(rt.new_string('image')).array_unset(rt.new_string('data'))
	if !(var_metadata.array_isset(rt.new_string('filesize')))
		&& rt.is_true(rt.call_function('file_exists', [var_file.clone()])) {
		var_metadata.array_set('filesize', rt.call_function('wp_filesize', [
			var_file.clone()]))
	}
	return rt.call_function('apply_filters', [
		rt.new_string('wp_generate_attachment_metadata'),
		var_metadata.clone(),
		var_attachment_id.clone(),
		rt.new_string('create'),
	])
}

fn wp_exif_frac2dec(var_str rt.PhpVal) rt.PhpVal {
	mut var_numerator := rt.new_null()
	mut var_denominator := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_scalar', [var_str.clone()])))))
		|| var_str.clone().is_bool() {
		return rt.new_int(0)
	}
	if !(var_str.clone().is_string()) {
		return var_str.clone()
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('substr_count', [
		var_str.clone(),
		rt.new_string('/'),
	]), rt.new_int(1)))))
	{
		if rt.is_true(rt.new_bool(var_str.clone().is_long() || var_str.clone().is_double())) {
			return rt.new_float(var_str.to_f64())
		}
		return rt.new_int(0)
	}
	mut list_tmp_1 := rt.call_function('explode', [rt.new_string('/'),
		var_str.clone()])
	var_numerator = list_tmp_1.array_get(0)
	var_denominator = list_tmp_1.array_get(1)
	if !(var_numerator.clone().is_long() || var_numerator.clone().is_double())
		|| !(var_denominator.clone().is_long() || var_denominator.clone().is_double()) {
		return rt.new_int(0)
	}
	if rt.is_true(rt.equal(rt.new_int(0), var_denominator)) {
		return rt.new_int(0)
	}
	return rt.div(var_numerator, var_denominator)
}

fn wp_exif_date2ts(var_str rt.PhpVal) rt.PhpVal {
	mut var_date := rt.new_null()
	mut var_time := rt.new_null()
	mut var_y := rt.new_null()
	mut var_m := rt.new_null()
	mut var_d := rt.new_null()
	mut list_tmp_2 := rt.call_function('explode', [rt.new_string(' '),
		rt.new_string(var_str.clone().to_string().trim_space())])
	var_date = list_tmp_2.array_get(0)
	var_time = list_tmp_2.array_get(1)
	mut list_tmp_3 := rt.call_function('explode', [rt.new_string(':'),
		var_date.clone()])
	var_y = list_tmp_3.array_get(0)
	var_m = list_tmp_3.array_get(1)
	var_d = list_tmp_3.array_get(2)
	return rt.call_function('strtotime', [
		rt.new_string('${var_y.to_string()}-${var_m.to_string()}-${var_d.to_string()} ${var_time.to_string()}'),
	])
}

fn wp_read_image_metadata(var_file rt.PhpVal) bool {
	mut var_image_type := rt.new_null()
	mut var_image_size := rt.new_null()
	mut var_meta := rt.new_null()
	mut var_iptc := rt.new_null()
	mut var_info := rt.new_null()
	mut var_caption := ''
	mut var_caption_length := i64(0)
	mut var_exif := rt.new_null()
	mut var_exif_image_types := rt.new_null()
	mut var_exif_description := ''
	mut var_exif_usercomment := ''
	mut var_description_length := i64(0)
	mut var_key := rt.new_null()
	mut var_keyword := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('file_exists', [
		var_file.clone()])))))
	{
		return false
	}
	var_image_size = rt.call_function('wp_getimagesize', [var_file.clone()])
	if rt.is_true(rt.identical(rt.new_bool(false), var_image_size)) {
		return false
	}
	mut list_tmp_4 := var_image_size
	var_image_type = list_tmp_4.array_get(2)
	var_meta = rt.create_array([rt.ArrayItem{ key: 'aperture', val: 0 },
		rt.ArrayItem{ key: 'credit', val: '' }, rt.ArrayItem{ key: 'camera', val: '' },
		rt.ArrayItem{ key: 'caption', val: '' }, rt.ArrayItem{ key: 'created_timestamp', val: 0 },
		rt.ArrayItem{ key: 'copyright', val: '' }, rt.ArrayItem{ key: 'focal_length', val: 0 },
		rt.ArrayItem{ key: 'iso', val: 0 }, rt.ArrayItem{ key: 'shutter_speed', val: 0 },
		rt.ArrayItem{ key: 'title', val: '' }, rt.ArrayItem{ key: 'orientation', val: 0 },
		rt.ArrayItem{ key: 'keywords', val: rt.new_array() },
		rt.ArrayItem{ key: 'alt', val: '' }])
	var_iptc = rt.new_array()
	var_info = rt.new_array()
	if rt.is_true(rt.call_function('is_callable', [rt.new_string('iptcparse')])) {
		rt.call_function('wp_getimagesize', [var_file.clone(),
			var_info.clone()])
		if !(!rt.is_true(var_info.array_get(rt.new_string('APP13')))) {
			if rt.is_true(rt.call_function('defined', [rt.new_string('WP_DEBUG')]))
				&& rt.is_true(rt.get_constant('WP_DEBUG'))
				&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('WP_RUN_CORE_TESTS')]))))) {
				var_iptc = rt.call_function('iptcparse', [
					var_info.array_get(rt.new_string('APP13')),
				])
			} else {
				var_iptc = rt.call_function('iptcparse', [
					var_info.array_get(rt.new_string('APP13')),
				])
			}
			if !(var_iptc.clone().is_array()) {
				var_iptc = rt.new_array()
			}
			if !(!rt.is_true(var_iptc.array_get(rt.new_string('2#105')).array_get(rt.new_int(0)))) {
				var_meta.array_set('title',
					var_iptc.array_get(rt.new_string('2#105')).array_get(rt.new_int(0)).to_string().trim_space())
			} else if !(!rt.is_true(var_iptc.array_get(rt.new_string('2#005')).array_get(rt.new_int(0)))) {
				var_meta.array_set('title',
					var_iptc.array_get(rt.new_string('2#005')).array_get(rt.new_int(0)).to_string().trim_space())
			}
			if !(!rt.is_true(var_iptc.array_get(rt.new_string('2#120')).array_get(rt.new_int(0)))) {
				var_caption =
					var_iptc.array_get(rt.new_string('2#120')).array_get(rt.new_int(0)).to_string().trim_space()
				rt.call_function('mbstring_binary_safe_encoding', []rt.PhpVal{})
				var_caption_length = var_caption.len
				rt.call_function('reset_mbstring_encoding', []rt.PhpVal{})
				if !rt.is_true(var_meta.array_get(rt.new_string('title')))
					&& var_caption_length < 80 {
					var_meta.array_set('title', var_caption)
				}
				var_meta.array_set('caption', var_caption)
			}
			if !(!rt.is_true(var_iptc.array_get(rt.new_string('2#110')).array_get(rt.new_int(0)))) {
				var_meta.array_set('credit',
					var_iptc.array_get(rt.new_string('2#110')).array_get(rt.new_int(0)).to_string().trim_space())
			} else if !(!rt.is_true(var_iptc.array_get(rt.new_string('2#080')).array_get(rt.new_int(0)))) {
				var_meta.array_set('credit',
					var_iptc.array_get(rt.new_string('2#080')).array_get(rt.new_int(0)).to_string().trim_space())
			}
			if !(!rt.is_true(var_iptc.array_get(rt.new_string('2#055')).array_get(rt.new_int(0))))
				&& !(!rt.is_true(var_iptc.array_get(rt.new_string('2#060')).array_get(rt.new_int(0)))) {
				var_meta.array_set('created_timestamp', rt.call_function('strtotime', [
					rt.new_string(
						(var_iptc.array_get(rt.new_string('2#055')).array_get(rt.new_int(0))).str() +
						' ' +
						(var_iptc.array_get(rt.new_string('2#060')).array_get(rt.new_int(0))).str()),
				]))
			}
			if !(!rt.is_true(var_iptc.array_get(rt.new_string('2#116')).array_get(rt.new_int(0)))) {
				var_meta.array_set('copyright',
					var_iptc.array_get(rt.new_string('2#116')).array_get(rt.new_int(0)).to_string().trim_space())
			}
			if !(!rt.is_true(var_iptc.array_get(rt.new_string('2#025')).array_get(rt.new_int(0)))) {
				var_meta.array_set('keywords', rt.call_function('array_values', [
					var_iptc.array_get(rt.new_string('2#025')),
				]))
			}
		}
	}
	var_meta.array_set('alt', wp_get_image_alttext(var_file.clone()))
	var_exif = rt.new_array()
	var_exif_image_types = rt.call_function('apply_filters', [
		rt.new_string('wp_read_image_metadata_types'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.get_constant('IMAGETYPE_JPEG') },
			rt.ArrayItem{ key: none, val: rt.get_constant('IMAGETYPE_TIFF_II') },
			rt.ArrayItem{ key: none, val: rt.get_constant('IMAGETYPE_TIFF_MM') },
		]),
	])
	if rt.call_function('is_callable', [rt.new_string('exif_read_data')])
		&& rt.is_true(rt.call_function('in_array', [var_image_type.clone(), var_exif_image_types.clone(), rt.new_bool(true)])) {
		if rt.is_true(rt.call_function('defined', [rt.new_string('WP_DEBUG')]))
			&& rt.is_true(rt.get_constant('WP_DEBUG'))
			&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('WP_RUN_CORE_TESTS')]))))) {
			var_exif = rt.call_function('exif_read_data', [var_file.clone()])
		} else {
			var_exif = rt.call_function('exif_read_data', [var_file.clone()])
		}
		if !(var_exif.clone().is_array()) {
			var_exif = rt.new_array()
		}
		var_exif_description = ''
		var_exif_usercomment = ''
		if !(!rt.is_true(var_exif.array_get(rt.new_string('ImageDescription')))) {
			var_exif_description =
				var_exif.array_get(rt.new_string('ImageDescription')).to_string().trim_space()
		}
		if !(!rt.is_true(var_exif.array_get(rt.new_string('COMPUTED')).array_get(rt.new_string('UserComment')))) {
			var_exif_usercomment =
				var_exif.array_get(rt.new_string('COMPUTED')).array_get(rt.new_string('UserComment')).to_string().trim_space()
		}
		if var_exif_description.len > 0 && var_exif_description != '0' {
			rt.call_function('mbstring_binary_safe_encoding', []rt.PhpVal{})
			var_description_length = var_exif_description.len
			rt.call_function('reset_mbstring_encoding', []rt.PhpVal{})
			if !rt.is_true(var_meta.array_get(rt.new_string('title')))
				&& var_description_length < 80 {
				var_meta.array_set('title', var_exif_description)
			}
			if !rt.is_true(var_meta.array_get(rt.new_string('caption')))
				&& var_exif_usercomment.len > 0 && var_exif_usercomment != '0' {
				if !(!rt.is_true(var_meta.array_get(rt.new_string('title'))))
					&& rt.is_true(rt.identical(rt.new_string(var_exif_description.str()), var_meta.array_get(rt.new_string('title')))) {
					var_caption = var_exif_usercomment
				} else {
					if rt.is_true(rt.identical(rt.new_string(var_exif_description.str()),
						rt.new_string(var_exif_usercomment.str())))
					{
						var_caption = var_exif_description
					} else {
						var_caption = var_exif_description + ' ' + var_exif_usercomment.trim_space()
					}
				}
				var_meta.array_set('caption', var_caption)
			}
			if !rt.is_true(var_meta.array_get(rt.new_string('caption')))
				&& var_exif_usercomment.len > 0 && var_exif_usercomment != '0' {
				var_meta.array_set('caption', var_exif_usercomment)
			}
			if !rt.is_true(var_meta.array_get(rt.new_string('caption'))) {
				var_meta.array_set('caption', var_exif_description)
			}
		} else if !rt.is_true(var_meta.array_get(rt.new_string('caption')))
			&& var_exif_usercomment.len > 0 && var_exif_usercomment != '0' {
			var_meta.array_set('caption', var_exif_usercomment)
			var_description_length = var_exif_usercomment.len
			if !rt.is_true(var_meta.array_get(rt.new_string('title')))
				&& var_description_length < 80 {
				var_meta.array_set('title', var_exif_usercomment.trim_space())
			}
		} else if !rt.is_true(var_meta.array_get(rt.new_string('caption')))
			&& !(!rt.is_true(var_exif.array_get(rt.new_string('Comments')))) {
			var_meta.array_set('caption',
				var_exif.array_get(rt.new_string('Comments')).to_string().trim_space())
		}
		if !rt.is_true(var_meta.array_get(rt.new_string('credit'))) {
			if !(!rt.is_true(var_exif.array_get(rt.new_string('Artist')))) {
				var_meta.array_set('credit',
					var_exif.array_get(rt.new_string('Artist')).to_string().trim_space())
			} else if !(!rt.is_true(var_exif.array_get(rt.new_string('Author')))) {
				var_meta.array_set('credit',
					var_exif.array_get(rt.new_string('Author')).to_string().trim_space())
			}
		}
		if !rt.is_true(var_meta.array_get(rt.new_string('copyright')))
			&& !(!rt.is_true(var_exif.array_get(rt.new_string('Copyright')))) {
			var_meta.array_set('copyright',
				var_exif.array_get(rt.new_string('Copyright')).to_string().trim_space())
		}
		if !(!rt.is_true(var_exif.array_get(rt.new_string('FNumber'))))
			&& rt.is_true(rt.call_function('is_scalar', [var_exif.array_get(rt.new_string('FNumber'))])) {
			var_meta.array_set('aperture', rt.call_function('round', [
				wp_exif_frac2dec(var_exif.array_get(rt.new_string('FNumber'))),
				rt.new_int(2),
			]))
		}
		if !(!rt.is_true(var_exif.array_get(rt.new_string('Model')))) {
			var_meta.array_set('camera',
				var_exif.array_get(rt.new_string('Model')).to_string().trim_space())
		}
		if !rt.is_true(var_meta.array_get(rt.new_string('created_timestamp')))
			&& !(!rt.is_true(var_exif.array_get(rt.new_string('DateTimeDigitized')))) {
			var_meta.array_set('created_timestamp',
				wp_exif_date2ts(var_exif.array_get(rt.new_string('DateTimeDigitized'))))
		}
		if !(!rt.is_true(var_exif.array_get(rt.new_string('FocalLength')))) {
			var_meta.array_set('focal_length',
				(var_exif.array_get(rt.new_string('FocalLength'))).str())
			if rt.is_true(rt.call_function('is_scalar', [
				var_exif.array_get(rt.new_string('FocalLength')),
			]))
			{
				var_meta.array_set('focal_length',
					(wp_exif_frac2dec(var_exif.array_get(rt.new_string('FocalLength')))).str())
			}
		}
		if !(!rt.is_true(var_exif.array_get(rt.new_string('ISOSpeedRatings')))) {
			var_meta.array_set('iso', if var_exif.array_get(rt.new_string('ISOSpeedRatings')).is_array() { rt.call_function('reset', [
					var_exif.array_get(rt.new_string('ISOSpeedRatings')),
				]) } else { var_exif.array_get(rt.new_string('ISOSpeedRatings')) })
			var_meta.array_set('iso',
				var_meta.array_get(rt.new_string('iso')).to_string().trim_space())
		}
		if !(!rt.is_true(var_exif.array_get(rt.new_string('ExposureTime')))) {
			var_meta.array_set('shutter_speed',
				(var_exif.array_get(rt.new_string('ExposureTime'))).str())
			if rt.is_true(rt.call_function('is_scalar', [
				var_exif.array_get(rt.new_string('ExposureTime')),
			]))
			{
				var_meta.array_set('shutter_speed',
					(wp_exif_frac2dec(var_exif.array_get(rt.new_string('ExposureTime')))).str())
			}
		}
		if !(!rt.is_true(var_exif.array_get(rt.new_string('Orientation')))) {
			var_meta.array_set('orientation', var_exif.array_get(rt.new_string('Orientation')))
		}
	}
	mut iter_4 := rt.create_array([rt.ArrayItem{ key: none, val: 'title' },
		rt.ArrayItem{ key: none, val: 'caption' }, rt.ArrayItem{ key: none, val: 'credit' },
		rt.ArrayItem{ key: none, val: 'copyright' }, rt.ArrayItem{ key: none, val: 'camera' },
		rt.ArrayItem{ key: none, val: 'iso' }]).iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_key_shadow := item_4.val
		if rt.is_true(var_meta.array_get(var_key_shadow))
			&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_is_valid_utf8', [var_meta.array_get(var_key_shadow)]))))) {
			var_meta.array_set(var_key_shadow, rt.call_function('utf8_encode', [
				var_meta.array_get(var_key_shadow),
			]))
		}
	}
	mut iter_5 := var_meta.array_get(rt.new_string('keywords')).iterator()
	for {
		item_5 := iter_5.next() or { break }
		mut var_keyword_shadow := item_5.val
		mut var_key_shadow := item_5.key
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_is_valid_utf8', [
			var_keyword_shadow.clone(),
		])))))
		{
			var_meta.array_get_mut('keywords').array_set(var_key_shadow, rt.call_function('utf8_encode', [
				var_keyword_shadow.clone(),
			]))
		}
	}
	var_meta = rt.call_function('wp_kses_post_deep', [var_meta.clone()])
	return (rt.call_function('apply_filters', [rt.new_string('wp_read_image_metadata'),
		var_meta.clone(), var_file.clone(), var_image_type.clone(),
		var_iptc.clone(), var_exif.clone()])).to_bool()
}

fn wp_get_image_alttext(var_file rt.PhpVal) rt.PhpVal {
	mut var_alt_text := rt.new_null()
	mut var_img_contents := rt.new_null()
	mut var_xmp_start := rt.new_null()
	mut var_xmp_end := rt.new_null()
	mut var_xmp_data := rt.new_null()
	mut var_doc := rt.new_null()
	mut var_xpath := rt.new_null()
	mut var_node_list := rt.new_null()
	mut var_node := rt.new_null()
	mut var_locale := rt.new_null()
	var_alt_text = rt.new_string('')
	var_img_contents = rt.call_function('file_get_contents', [
		var_file.clone()])
	if rt.is_true(rt.identical(rt.new_bool(false), var_img_contents)) {
		return var_alt_text.clone()
	}
	var_xmp_start = rt.call_function('strpos', [var_img_contents.clone(),
		rt.new_string('<x:xmpmeta')])
	var_xmp_end = rt.call_function('strpos', [var_img_contents.clone(),
		rt.new_string('</x:xmpmeta>')])
	if rt.is_true(rt.identical(rt.new_bool(false), var_xmp_start))
		|| rt.is_true(rt.identical(rt.new_bool(false), var_xmp_end)) {
		return var_alt_text.clone()
	}
	var_xmp_data = rt.call_function('substr', [var_img_contents.clone(),
		var_xmp_start.clone(), rt.add(rt.sub(var_xmp_end, var_xmp_start), rt.new_int(12))])
	var_doc = create_domdocument()
	if rt.is_true(rt.identical(rt.new_bool(false), var_doc.loadxml(var_xmp_data.clone()))) {
		return var_alt_text.clone()
	}
	var_xpath = create_domxpath(var_doc)
	var_xpath.registernamespace(rt.new_string('x'), rt.new_string('adobe:ns:meta/'))
	var_xpath.registernamespace(rt.new_string('rdf'),
		rt.new_string('http://www.w3.org/1999/02/22-rdf-syntax-ns#'))
	var_xpath.registernamespace(rt.new_string('Iptc4xmpCore'),
		rt.new_string('http://iptc.org/std/Iptc4xmpCore/1.0/xmlns/'))
	var_node_list =
		var_xpath.query(rt.new_string('/x:xmpmeta/rdf:RDF/rdf:Description/Iptc4xmpCore:AltTextAccessibility'))
	if rt.is_true(var_node_list)
		&& rt.is_true(rt.call_method(var_node_list, 'count', []rt.PhpVal{})) {
		var_node = rt.call_method(var_node_list, 'item', [rt.new_int(0)])
		var_locale = rt.call_function('get_locale', []rt.PhpVal{})
		var_alt_text = var_xpath.evaluate(rt.new_string("string( rdf:Alt/rdf:li[ @xml:lang = '${var_locale.to_string()}' ] )"),
			var_node.clone())
		if rt.is_true(rt.new_bool(!(rt.is_true(var_alt_text)))) {
			var_alt_text = var_xpath.evaluate(rt.new_string(
				'string( rdf:Alt/rdf:li[ @xml:lang = "' +
				(rt.call_function('substr', [var_locale.clone(), rt.new_int(0), rt.new_int(2)])).str() +
				'" ] )'), var_node.clone())
			if rt.is_true(rt.new_bool(!(rt.is_true(var_alt_text)))) {
				var_alt_text = var_xpath.evaluate(rt.new_string('string( rdf:Alt/rdf:li[ @xml:lang = "x-default" ] )'),
					var_node.clone())
			}
		}
	}
	return var_alt_text.clone()
}

fn file_is_valid_image(var_path rt.PhpVal) bool {
	mut var_size := rt.new_null()
	var_size = rt.call_function('wp_getimagesize', [var_path.clone()])
	return !(!rt.is_true(var_size))
}

fn file_is_displayable_image(var_path rt.PhpVal) rt.PhpVal {
	mut var_displayable_image_types := []rt.PhpVal{}
	mut var_info := rt.new_null()
	mut var_result := false
	var_displayable_image_types = [rt.get_constant('IMAGETYPE_GIF'),
		rt.get_constant('IMAGETYPE_JPEG'), rt.get_constant('IMAGETYPE_PNG'),
		rt.get_constant('IMAGETYPE_BMP'), rt.get_constant('IMAGETYPE_ICO'),
		rt.get_constant('IMAGETYPE_WEBP'), rt.get_constant('IMAGETYPE_AVIF')]
	var_info = rt.call_function('wp_getimagesize', [var_path.clone()])
	if !rt.is_true(var_info) {
		var_result = false
	} else if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
		var_info.array_get(rt.new_int(2)),
		rt.create_array_from_list(var_displayable_image_types),
		rt.new_bool(true),
	])))))
	{
		var_result = false
	} else {
		var_result = true
	}
	return rt.call_function('apply_filters', [rt.new_string('file_is_displayable_image'),
		rt.new_bool(var_result).clone(), var_path.clone()])
}

fn load_image_to_edit(var_attachment_id rt.PhpVal, var_mime_type rt.PhpVal, size string) bool {
	mut var_size := size
	mut var_filepath := rt.new_null()
	mut var_image := rt.new_null()
	var_filepath = _load_image_to_edit_path(var_attachment_id.clone(), size)
	if !rt.is_true(var_filepath) {
		return false
	}
	mut switch_val_2 := var_mime_type
	if rt.is_true(rt.equal(switch_val_2, rt.new_string('image/jpeg'))) {
		var_image = rt.call_function('imagecreatefromjpeg', [
			var_filepath.clone()])
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('image/png'))) {
		var_image = rt.call_function('imagecreatefrompng', [var_filepath.clone()])
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('image/gif'))) {
		var_image = rt.call_function('imagecreatefromgif', [var_filepath.clone()])
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('image/webp'))) {
		var_image = rt.new_bool(false)
		if rt.is_true(rt.call_function('function_exists', [
			rt.new_string('imagecreatefromwebp'),
		]))
		{
			var_image = rt.call_function('imagecreatefromwebp', [
				var_filepath.clone()])
		}
	} else {
		var_image = rt.new_bool(false)
	}
	if rt.is_true(rt.call_function('is_gd_image', [var_image.clone()])) {
		var_image = rt.call_function('apply_filters', [
			rt.new_string('load_image_to_edit'),
			var_image.clone(),
			var_attachment_id.clone(),
			rt.new_string(size),
		])
		if rt.is_true(rt.call_function('function_exists', [rt.new_string('imagealphablending')]))
			&& rt.is_true(rt.call_function('function_exists', [rt.new_string('imagesavealpha')])) {
			rt.call_function('imagealphablending', [var_image.clone(),
				rt.new_bool(false)])
			rt.call_function('imagesavealpha', [var_image.clone(),
				rt.new_bool(true)])
		}
	}
	return var_image.to_bool()
}

fn _load_image_to_edit_path(var_attachment_id rt.PhpVal, size string) rt.PhpVal {
	mut var_size := size
	mut var_filepath := rt.new_null()
	mut var_data := rt.new_null()
	var_filepath = rt.call_function('get_attached_file', [var_attachment_id.clone()])
	if rt.is_true(var_filepath)
		&& rt.is_true(rt.call_function('file_exists', [var_filepath.clone()])) {
		if rt.is_true(rt.new_bool('full' != size)) {
			var_data = rt.call_function('image_get_intermediate_size', [
				var_attachment_id.clone(), rt.new_string(size)])
			if rt.is_true(var_data) {
				var_filepath = rt.call_function('path_join', [
					rt.call_function('dirname', [var_filepath.clone()]),
					var_data.array_get(rt.new_string('file')),
				])
				var_filepath = rt.call_function('apply_filters', [
					rt.new_string('load_image_to_edit_filesystempath'),
					var_filepath.clone(),
					var_attachment_id.clone(),
					rt.new_string(size),
				])
			}
		}
	} else if rt.is_true(rt.call_function('function_exists', [rt.new_string('fopen')]))
		&& rt.is_true(rt.call_function('ini_get', [rt.new_string('allow_url_fopen')])) {
		var_filepath = rt.call_function('apply_filters', [
			rt.new_string('load_image_to_edit_attachmenturl'),
			rt.call_function('wp_get_attachment_url', [var_attachment_id.clone()]),
			var_attachment_id.clone(),
			rt.new_string(size),
		])
	}
	return rt.call_function('apply_filters', [rt.new_string('load_image_to_edit_path'),
		var_filepath.clone(), var_attachment_id.clone(), rt.new_string(size)])
}

fn _copy_image_file(var_attachment_id rt.PhpVal) rt.PhpVal {
	mut var_dst_file := rt.new_null()
	mut var_src_file := rt.new_null()
	var_dst_file = rt.call_function('get_attached_file', [var_attachment_id.clone()])
	var_src_file = var_dst_file.clone()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('file_exists', [
		var_src_file.clone()])))))
	{
		var_src_file = _load_image_to_edit_path(var_attachment_id.clone(), '')
	}
	if rt.is_true(var_src_file) {
		var_dst_file = rt.call_function('str_replace', [
			rt.call_function('wp_basename', [var_dst_file.clone()]),
			rt.new_string('copy-' + (rt.call_function('wp_basename', [var_dst_file.clone()])).str()),
			var_dst_file.clone(),
		])
		var_dst_file = rt.new_string((rt.call_function('dirname', [var_dst_file.clone()])).str() +
			'/' +(rt.call_function('wp_unique_filename', [rt.call_function('dirname', [var_dst_file.clone()]), rt.call_function('wp_basename', [var_dst_file.clone()])])).str())
		rt.call_function('wp_mkdir_p', [
			rt.call_function('dirname', [var_dst_file.clone()]),
		])
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('copy', [
			var_src_file.clone(), var_dst_file.clone()])))))
		{
			var_dst_file = rt.new_bool(false)
		}
	} else {
		var_dst_file = rt.new_bool(false)
	}
	return var_dst_file.clone()
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

struct Class_DOMDocument {
	rt.PhpObjectBase
}

struct Class_DOMXPath {
	rt.PhpObjectBase
}

fn create_wp_error(_args ...rt.PhpVal) &Class_WP_Error {
	mut obj := &Class_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_domdocument(_args ...rt.PhpVal) &Class_DOMDocument {
	mut obj := &Class_DOMDocument{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_domxpath(_args ...rt.PhpVal) &Class_DOMXPath {
	mut obj := &Class_DOMXPath{
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

fn (mut this Class_DOMDocument) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_DOMDocument) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_DOMDocument) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_DOMXPath) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_DOMXPath) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_DOMXPath) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
