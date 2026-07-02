import rt
import crypto.md5

fn wp_get_additional_image_sizes() rt.PhpVal {
	mut var__wp_additional_image_sizes := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(var__wp_additional_image_sizes)))) {
		var__wp_additional_image_sizes = rt.new_array()
	}
	return var__wp_additional_image_sizes.clone()
}

fn image_constrain_size_for_editor(var_width rt.PhpVal, var_height rt.PhpVal, size string, var_context_arg rt.PhpVal) rt.PhpVal {
	mut var_size := size
	mut var_context := var_context_arg
	mut var_content_width := rt.new_null()
	mut var__wp_additional_image_sizes := rt.new_null()
	mut var_max_width := rt.new_null()
	mut var_max_height := rt.new_null()
	var__wp_additional_image_sizes = wp_get_additional_image_sizes()
	if rt.is_true(rt.new_bool(!(rt.is_true(var_context)))) {
		var_context = rt.new_string((if rt.is_true(rt.call_function('is_admin', []rt.PhpVal{})) {
			'edit'
		} else {
			'display'
		}).str())
	}
	if rt.is_true(rt.new_bool(rt.new_string(size).is_array())) {
		var_max_width = rt.new_string(size).array_get(rt.new_int(0))
		var_max_height = rt.new_string(size).array_get(rt.new_int(1))
	} else if rt.is_true(rt.identical(rt.new_string('thumb'), rt.new_string(size)))
		|| rt.is_true(rt.identical(rt.new_string('thumbnail'), rt.new_string(size))) {
		var_max_width = rt.new_int((rt.call_function('get_option', [
			rt.new_string('thumbnail_size_w'),
		])).to_i64())
		var_max_height = rt.new_int((rt.call_function('get_option', [
			rt.new_string('thumbnail_size_h'),
		])).to_i64())
		if rt.is_true(rt.new_bool(!(rt.is_true(var_max_width))))
			&& rt.is_true(rt.new_bool(!(rt.is_true(var_max_height)))) {
			var_max_width = rt.new_int(128)
			var_max_height = rt.new_int(96)
		}
	} else if rt.is_true(rt.identical(rt.new_string('medium'), rt.new_string(size))) {
		var_max_width = rt.new_int((rt.call_function('get_option', [
			rt.new_string('medium_size_w'),
		])).to_i64())
		var_max_height = rt.new_int((rt.call_function('get_option', [
			rt.new_string('medium_size_h'),
		])).to_i64())
	} else if rt.is_true(rt.identical(rt.new_string('medium_large'), rt.new_string(size))) {
		var_max_width = rt.new_int((rt.call_function('get_option', [
			rt.new_string('medium_large_size_w'),
		])).to_i64())
		var_max_height = rt.new_int((rt.call_function('get_option', [
			rt.new_string('medium_large_size_h'),
		])).to_i64())
		if rt.new_int(var_content_width.to_i64()) > 0 {
			var_max_width = rt.call_function('min', [
				rt.new_int(var_content_width.to_i64()),
				var_max_width.clone(),
			])
		}
	} else if rt.is_true(rt.identical(rt.new_string('large'), rt.new_string(size))) {
		var_max_width = rt.new_int((rt.call_function('get_option', [
			rt.new_string('large_size_w'),
		])).to_i64())
		var_max_height = rt.new_int((rt.call_function('get_option', [
			rt.new_string('large_size_h'),
		])).to_i64())
		if rt.new_int(var_content_width.to_i64()) > 0 {
			var_max_width = rt.call_function('min', [
				rt.new_int(var_content_width.to_i64()),
				var_max_width.clone(),
			])
		}
	} else if !(!rt.is_true(var__wp_additional_image_sizes))
		&& rt.is_true(rt.call_function('in_array', [rt.new_string(size), rt.func_array_keys(var__wp_additional_image_sizes.clone()), rt.new_bool(true)])) {
		var_max_width =
			rt.new_int((var__wp_additional_image_sizes.array_get(rt.new_string(size)).array_get(rt.new_string('width'))).to_i64())
		var_max_height =
			rt.new_int((var__wp_additional_image_sizes.array_get(rt.new_string(size)).array_get(rt.new_string('height'))).to_i64())
		if rt.new_int(var_content_width.to_i64()) > 0
			&& rt.is_true(rt.identical(rt.new_string('edit'), var_context)) {
			var_max_width = rt.call_function('min', [
				rt.new_int(var_content_width.to_i64()),
				var_max_width.clone(),
			])
		}
	} else {
		var_max_width = var_width.clone()
		var_max_height = var_height.clone()
	}
	mut list_tmp_1 := rt.call_function('apply_filters', [
		rt.new_string('editor_max_image_size'),
		rt.create_array([rt.ArrayItem{ key: none, val: var_max_width },
			rt.ArrayItem{ key: none, val: var_max_height }]),
		rt.new_string(size),
		var_context.clone(),
	])
	var_max_width = list_tmp_1.array_get(0)
	var_max_height = list_tmp_1.array_get(1)
	return wp_constrain_dimensions(var_width.clone(), var_height.clone(), var_max_width.clone(),
		var_max_height.clone())
}

fn image_hwstring(var_width rt.PhpVal, var_height rt.PhpVal) string {
	mut var_out := ''
	var_out = ''
	if rt.is_true(var_width) {
		var_out = var_out + 'width="' + rt.new_int(var_width.to_i64()).str() + '" '
	}
	if rt.is_true(var_height) {
		var_out = var_out + 'height="' + rt.new_int(var_height.to_i64()).str() + '" '
	}
	return var_out
}

fn image_downsize(var_id rt.PhpVal, size string) rt.PhpVal {
	mut var_size := size
	mut var_is_image := rt.new_null()
	mut var_out := rt.new_null()
	mut var_img_url := rt.new_null()
	mut var_meta := rt.new_null()
	mut var_width := rt.new_null()
	mut var_height := rt.new_null()
	mut var_is_intermediate := false
	mut var_img_url_basename := rt.new_null()
	mut var_intermediate := rt.new_null()
	mut var_imagefile := rt.new_null()
	mut var_thumbfile := rt.new_null()
	mut var_info := rt.new_null()
	var_is_image = rt.call_function('wp_attachment_is_image', [
		var_id.clone()])
	var_out = rt.call_function('apply_filters', [rt.new_string('image_downsize'),
		rt.new_bool(false), var_id.clone(), rt.new_string(size)])
	if rt.is_true(var_out) {
		return var_out.clone()
	}
	var_img_url = rt.call_function('wp_get_attachment_url', [
		var_id.clone()])
	var_meta = rt.call_function('wp_get_attachment_metadata', [
		var_id.clone()])
	var_width = rt.new_int(0)
	var_height = rt.new_int(0)
	var_is_intermediate = false
	var_img_url_basename = rt.call_function('wp_basename', [var_img_url.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_is_image)))) {
		if !(!rt.is_true(var_meta.array_get(rt.new_string('sizes')).array_get(rt.new_string('full')))) {
			var_img_url = rt.call_function('str_replace', [var_img_url_basename.clone(),
				var_meta.array_get(rt.new_string('sizes')).array_get(rt.new_string('full')).array_get(rt.new_string('file')),
				var_img_url.clone()])
			var_img_url_basename =
				var_meta.array_get(rt.new_string('sizes')).array_get(rt.new_string('full')).array_get(rt.new_string('file'))
			var_width =
				var_meta.array_get(rt.new_string('sizes')).array_get(rt.new_string('full')).array_get(rt.new_string('width'))
			var_height =
				var_meta.array_get(rt.new_string('sizes')).array_get(rt.new_string('full')).array_get(rt.new_string('height'))
		} else {
			return rt.new_bool(false)
		}
	}
	var_intermediate = rt.new_bool(image_get_intermediate_size(var_id.clone(), size))
	if rt.is_true(var_intermediate) {
		var_img_url = rt.call_function('str_replace', [var_img_url_basename.clone(),
			var_intermediate.array_get(rt.new_string('file')),
			var_img_url.clone()])
		var_width = var_intermediate.array_get(rt.new_string('width'))
		var_height = var_intermediate.array_get(rt.new_string('height'))
		var_is_intermediate = true
	} else if rt.is_true(rt.identical(rt.new_string('thumbnail'), rt.new_string(size)))
		&& !(!rt.is_true(var_meta.array_get(rt.new_string('thumb'))))
		&& var_meta.array_get(rt.new_string('thumb')).is_string() {
		var_imagefile = rt.call_function('get_attached_file', [
			var_id.clone()])
		var_thumbfile = rt.call_function('str_replace', [
			rt.call_function('wp_basename', [var_imagefile.clone()]),
			rt.call_function('wp_basename', [var_meta.array_get(rt.new_string('thumb'))]),
			var_imagefile.clone(),
		])
		if rt.is_true(rt.call_function('file_exists', [var_thumbfile.clone()])) {
			var_info = wp_getimagesize(var_thumbfile.clone(), rt.new_null())
			if rt.is_true(var_info) {
				var_img_url = rt.call_function('str_replace', [
					var_img_url_basename.clone(),
					rt.call_function('wp_basename', [
						var_thumbfile.clone(),
					]),
					var_img_url.clone()])
				var_width = var_info.array_get(rt.new_int(0))
				var_height = var_info.array_get(rt.new_int(1))
				var_is_intermediate = true
			}
		}
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_width))))
		&& rt.is_true(rt.new_bool(!(rt.is_true(var_height))))
		&& var_meta.array_isset(rt.new_string('width'))
		&& var_meta.array_isset(rt.new_string('height')) {
		var_width = var_meta.array_get(rt.new_string('width'))
		var_height = var_meta.array_get(rt.new_string('height'))
	}
	if rt.is_true(var_img_url) {
		mut list_tmp_2 := image_constrain_size_for_editor(var_width.clone(), var_height.clone(),
			size, rt.new_null())
		var_width = list_tmp_2.array_get(0)
		var_height = list_tmp_2.array_get(1)
		return rt.create_array([rt.ArrayItem{ key: none, val: var_img_url },
			rt.ArrayItem{ key: none, val: var_width }, rt.ArrayItem{ key: none, val: var_height },
			rt.ArrayItem{ key: none, val: var_is_intermediate }])
	}
	return rt.new_bool(false)
}

fn add_image_size(name string, width i64, height i64, crop bool) {
	mut var_name := name
	mut var_width := width
	mut var_height := height
	mut var_crop := crop
	mut var__wp_additional_image_sizes := rt.new_null()
	var__wp_additional_image_sizes.array_set(name, rt.create_array([
		rt.ArrayItem{ key: 'width', val: rt.call_function('absint', [
			rt.new_int(width)]) },
		rt.ArrayItem{ key: 'height', val: rt.call_function('absint', [
			rt.new_int(height)]) },
		rt.ArrayItem{ key: 'crop', val: crop },
	]))
}

fn has_image_size(var_name rt.PhpVal) rt.PhpVal {
	mut var_sizes := rt.new_null()
	var_sizes = wp_get_additional_image_sizes()
	return rt.new_bool(var_sizes.array_isset(var_name))
}

fn remove_image_size(var_name rt.PhpVal) bool {
	mut var__wp_additional_image_sizes := rt.new_null()
	if var__wp_additional_image_sizes.array_isset(var_name) {
		var__wp_additional_image_sizes.array_unset(var_name)
		return true
	}
	return false
}

fn set_post_thumbnail_size(width i64, height i64, crop bool) {
	mut var_width := width
	mut var_height := height
	mut var_crop := crop
	add_image_size('post-thumbnail', width, height, crop)
}

fn get_image_tag(var_id rt.PhpVal, var_alt rt.PhpVal, var_title_arg rt.PhpVal, var_align rt.PhpVal, size string) rt.PhpVal {
	mut var_size := size
	mut var_title := var_title_arg
	mut var_img_src := rt.new_null()
	mut var_width := rt.new_null()
	mut var_height := rt.new_null()
	mut var_hwstring := ''
	mut var_size_class := rt.new_null()
	mut var_class := rt.new_null()
	mut var_html := rt.new_null()
	mut list_tmp_3 := image_downsize(var_id.clone(), size)
	var_img_src = list_tmp_3.array_get(0)
	var_width = list_tmp_3.array_get(1)
	var_height = list_tmp_3.array_get(2)
	var_hwstring = image_hwstring(var_width.clone(), var_height.clone())
	var_title = rt.new_string((if rt.is_true(var_title) {
		'title="' + (rt.call_function('esc_attr', [var_title.clone()])).str() + '" '
	} else {
		''
	}).str())
	var_size_class = if rt.new_string(size).is_array() { rt.call_function('implode', [
			rt.new_string('x'),
			rt.new_string(size),
		]) } else { rt.new_string(size) }
	var_class = rt.new_string('align' + (rt.call_function('esc_attr', [var_align.clone()])).str() +
		' size-' + (rt.call_function('esc_attr', [var_size_class.clone()])).str() + ' wp-image-' +
		var_id.str())
	var_class = rt.call_function('apply_filters', [rt.new_string('get_image_tag_class'),
		var_class.clone(), var_id.clone(), var_align.clone(),
		rt.new_string(size)])
	var_html = rt.new_string('<img src="' +
		(rt.call_function('esc_url', [var_img_src.clone()])).str() + '" alt="' +
		(rt.call_function('esc_attr', [var_alt.clone()])).str() + '" ' + var_title.str() +
		var_hwstring + 'class="' + var_class.str() + '" />')
	return rt.call_function('apply_filters', [rt.new_string('get_image_tag'),
		var_html.clone(), var_id.clone(), var_alt.clone(), var_title.clone(),
		var_align.clone(), rt.new_string(size)])
}

fn wp_constrain_dimensions(var_current_width rt.PhpVal, var_current_height rt.PhpVal, max_width i64, max_height i64) rt.PhpVal {
	mut var_max_width := max_width
	mut var_max_height := max_height
	mut var_width_ratio := rt.new_null()
	mut var_height_ratio := rt.new_null()
	mut var_did_width := false
	mut var_did_height := false
	mut var_smaller_ratio := rt.new_null()
	mut var_larger_ratio := rt.new_null()
	mut var_ratio := rt.new_null()
	mut var_w := rt.new_null()
	mut var_h := rt.new_null()
	if !(var_max_width != 0) && !(var_max_height != 0) {
		return rt.create_array([rt.ArrayItem{ key: none, val: var_current_width },
			rt.ArrayItem{ key: none, val: var_current_height }])
	}
	var_width_ratio = rt.new_float(1)
	var_height_ratio = rt.new_float(1)
	var_did_width = false
	var_did_height = false
	if max_width > 0 && rt.is_true(rt.greater(var_current_width, rt.new_int(0)))
		&& rt.is_true(rt.greater(var_current_width, rt.new_int(max_width))) {
		var_width_ratio = rt.div(rt.new_int(max_width), var_current_width)
		var_did_width = true
	}
	if max_height > 0 && rt.is_true(rt.greater(var_current_height, rt.new_int(0)))
		&& rt.is_true(rt.greater(var_current_height, rt.new_int(max_height))) {
		var_height_ratio = rt.div(rt.new_int(max_height), var_current_height)
		var_did_height = true
	}
	var_smaller_ratio = rt.call_function('min', [var_width_ratio.clone(),
		var_height_ratio.clone()])
	var_larger_ratio = rt.call_function('max', [var_width_ratio.clone(),
		var_height_ratio.clone()])
	if rt.new_int((rt.call_function('round', [rt.mul(var_current_width, var_larger_ratio)])).to_i64()) > max_width
		|| rt.new_int((rt.call_function('round', [rt.mul(var_current_height, var_larger_ratio)])).to_i64()) > max_height {
		var_ratio = var_smaller_ratio.clone()
	} else {
		var_ratio = var_larger_ratio.clone()
	}
	var_w = rt.call_function('max', [rt.new_int(1),
		rt.new_int((rt.call_function('round', [rt.mul(var_current_width, var_ratio)])).to_i64())])
	var_h = rt.call_function('max', [rt.new_int(1),
		rt.new_int((rt.call_function('round', [rt.mul(var_current_height, var_ratio)])).to_i64())])
	if var_did_width && rt.is_true(rt.identical(var_w, max_width - 1)) {
		var_w = rt.new_int(max_width)
	}
	if var_did_height && rt.is_true(rt.identical(var_h, max_height - 1)) {
		var_h = rt.new_int(max_height)
	}
	return rt.call_function('apply_filters', [rt.new_string('wp_constrain_dimensions'),
		rt.create_array([rt.ArrayItem{ key: none, val: var_w },
			rt.ArrayItem{ key: none, val: var_h }]),
		var_current_width.clone(), var_current_height.clone(),
		rt.new_int(max_width), rt.new_int(max_height)])
}

fn image_resize_dimensions(var_orig_w rt.PhpVal, var_orig_h rt.PhpVal, var_dest_w rt.PhpVal, var_dest_h rt.PhpVal, crop bool) rt.PhpVal {
	mut var_crop := crop
	mut var_x := rt.new_null()
	mut var_y := rt.new_null()
	mut var_output := rt.new_null()
	mut var_aspect_ratio := rt.new_null()
	mut var_new_w := rt.new_null()
	mut var_new_h := rt.new_null()
	mut var_size_ratio := rt.new_null()
	mut var_crop_w := rt.new_null()
	mut var_crop_h := rt.new_null()
	mut var_s_x := rt.new_null()
	mut var_s_y := rt.new_null()
	mut var_proceed := rt.new_null()
	if rt.is_true(rt.less_equal(var_orig_w, rt.new_int(0)))
		|| rt.is_true(rt.less_equal(var_orig_h, rt.new_int(0))) {
		return rt.new_bool(false)
	}
	if rt.is_true(rt.less_equal(var_dest_w, rt.new_int(0)))
		&& rt.is_true(rt.less_equal(var_dest_h, rt.new_int(0))) {
		return rt.new_bool(false)
	}
	var_output = rt.call_function('apply_filters', [
		rt.new_string('image_resize_dimensions'),
		rt.new_null(),
		var_orig_w.clone(),
		var_orig_h.clone(),
		var_dest_w.clone(),
		var_dest_h.clone(),
		rt.new_bool(var_crop),
	])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_output)))) {
		return var_output.clone()
	}
	if !rt.is_true(var_dest_h) {
		if rt.is_true(rt.less(var_orig_w, var_dest_w)) {
			return rt.new_bool(false)
		}
	} else if !rt.is_true(var_dest_w) {
		if rt.is_true(rt.less(var_orig_h, var_dest_h)) {
			return rt.new_bool(false)
		}
	} else {
		if rt.is_true(rt.less(var_orig_w, var_dest_w))
			&& rt.is_true(rt.less(var_orig_h, var_dest_h)) {
			return rt.new_bool(false)
		}
	}
	if var_crop {
		var_aspect_ratio = rt.div(var_orig_w, var_orig_h)
		var_new_w = rt.call_function('min', [var_dest_w.clone(),
			var_orig_w.clone()])
		var_new_h = rt.call_function('min', [var_dest_h.clone(),
			var_orig_h.clone()])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_new_w)))) {
			var_new_w = rt.new_int((rt.call_function('round', [
				rt.mul(var_new_h, var_aspect_ratio),
			])).to_i64())
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(var_new_h)))) {
			var_new_h = rt.new_int((rt.call_function('round', [
				rt.div(var_new_w, var_aspect_ratio),
			])).to_i64())
		}
		var_size_ratio = rt.call_function('max', [rt.div(var_new_w, var_orig_w),
			rt.div(var_new_h, var_orig_h)])
		var_crop_w = rt.call_function('round', [rt.div(var_new_w, var_size_ratio)])
		var_crop_h = rt.call_function('round', [rt.div(var_new_h, var_size_ratio)])
		if !(rt.new_bool(var_crop).is_array())
			|| rt.is_true(rt.new_bool(rt.new_bool(var_crop).array_count() != 2)) {
			var_crop = (rt.create_array([rt.ArrayItem{ key: none, val: 'center' },
				rt.ArrayItem{ key: none, val: 'center' }])).to_bool()
		}
		mut list_tmp_4 := rt.new_bool(var_crop)
		var_x = list_tmp_4.array_get(0)
		var_y = list_tmp_4.array_get(1)
		if rt.is_true(rt.identical(rt.new_string('left'), var_x)) {
			var_s_x = rt.new_int(0)
		} else if rt.is_true(rt.identical(rt.new_string('right'), var_x)) {
			var_s_x = rt.sub(var_orig_w, var_crop_w)
		} else {
			var_s_x = rt.call_function('floor', [
				rt.div(rt.sub(var_orig_w, var_crop_w), rt.new_int(2)),
			])
		}
		if rt.is_true(rt.identical(rt.new_string('top'), var_y)) {
			var_s_y = rt.new_int(0)
		} else if rt.is_true(rt.identical(rt.new_string('bottom'), var_y)) {
			var_s_y = rt.sub(var_orig_h, var_crop_h)
		} else {
			var_s_y = rt.call_function('floor', [
				rt.div(rt.sub(var_orig_h, var_crop_h), rt.new_int(2)),
			])
		}
	} else {
		var_crop_w = var_orig_w
		var_crop_h = var_orig_h
		var_s_x = rt.new_int(0)
		var_s_y = rt.new_int(0)
		mut list_tmp_5 := wp_constrain_dimensions(var_orig_w.clone(), var_orig_h.clone(),
			var_dest_w.clone(), var_dest_h.clone())
		var_new_w = list_tmp_5.array_get(0)
		var_new_h = list_tmp_5.array_get(1)
	}
	if rt.is_true(rt.call_function('wp_fuzzy_number_match', [var_new_w.clone(), var_orig_w.clone()]))
		&& rt.is_true(rt.call_function('wp_fuzzy_number_match', [var_new_h.clone(), var_orig_h.clone()])) {
		var_proceed = rt.new_bool((rt.call_function('apply_filters', [
			rt.new_string('wp_image_resize_identical_dimensions'),
			rt.new_bool(false),
			var_orig_w.clone(),
			var_orig_h.clone(),
		])).to_bool())
		if rt.is_true(rt.new_bool(!(rt.is_true(var_proceed)))) {
			return rt.new_bool(false)
		}
	}
	return rt.create_array([rt.ArrayItem{ key: none, val: 0 },
		rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{
			key: none
			val: rt.new_int(var_s_x.to_i64())
		}, rt.ArrayItem{ key: none, val: rt.new_int(var_s_y.to_i64()) },
		rt.ArrayItem{ key: none, val: rt.new_int(var_new_w.to_i64()) },
		rt.ArrayItem{ key: none, val: rt.new_int(var_new_h.to_i64()) },
		rt.ArrayItem{ key: none, val: rt.new_int(var_crop_w.to_i64()) },
		rt.ArrayItem{ key: none, val: rt.new_int(var_crop_h.to_i64()) }])
}

fn image_make_intermediate_size(var_file rt.PhpVal, var_width rt.PhpVal, var_height rt.PhpVal, crop bool) bool {
	mut var_crop := crop
	mut var_editor := rt.new_null()
	mut var_resized_file := rt.new_null()
	if rt.is_true(var_width) || rt.is_true(var_height) {
		var_editor = wp_get_image_editor(var_file.clone(), rt.new_null())
		if rt.is_true(rt.call_function('is_wp_error', [var_editor.clone()]))
			|| rt.is_true(rt.call_function('is_wp_error', [rt.call_method(var_editor, 'resize', [var_width.clone(), var_height.clone(), rt.new_bool(var_crop)])])) {
			return false
		}
		var_resized_file = rt.call_method(var_editor, 'save', []rt.PhpVal{})
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [var_resized_file.clone()])))))
			&& rt.is_true(var_resized_file) {
			var_resized_file.array_unset(rt.new_string('path'))
			return var_resized_file.to_bool()
		}
	}
	return false
}

fn wp_image_matches_ratio(var_source_width rt.PhpVal, var_source_height rt.PhpVal, var_target_width rt.PhpVal, var_target_height rt.PhpVal) bool {
	mut var_constrained_size := rt.new_null()
	mut var_expected_size := []rt.PhpVal{}
	mut var_matched := false
	if rt.is_true(rt.greater(var_source_width, var_target_width)) {
		var_constrained_size = wp_constrain_dimensions(var_source_width.clone(),
			var_source_height.clone(), var_target_width.clone(), 0)
		var_expected_size = [var_target_width, var_target_height]
	} else {
		var_constrained_size = wp_constrain_dimensions(var_target_width.clone(),
			var_target_height.clone(), var_source_width.clone(), 0)
		var_expected_size = [var_source_width, var_source_height]
	}
	var_matched =
		rt.is_true(rt.call_function('wp_fuzzy_number_match', [var_constrained_size.array_get(rt.new_int(0)), var_expected_size[0]]))
		&& rt.is_true(rt.call_function('wp_fuzzy_number_match', [var_constrained_size.array_get(rt.new_int(1)), var_expected_size[1]]))
	return var_matched
}

fn image_get_intermediate_size(var_post_id rt.PhpVal, size string) bool {
	mut var_size := size
	mut var_imagedata := rt.new_null()
	mut var_data := rt.new_null()
	mut var_candidates := rt.new_null()
	mut var__size := rt.new_null()
	mut var_same_ratio := false
	mut var_file_url := rt.new_null()
	var_imagedata = rt.call_function('wp_get_attachment_metadata', [
		var_post_id.clone()])
	if ((!(var_size.len > 0 && var_size != '0'))
		|| !(var_imagedata.clone().is_array()))
		|| !rt.is_true(var_imagedata.array_get(rt.new_string('sizes'))) {
		return false
	}
	var_data = rt.new_array()
	if rt.is_true(rt.new_bool(rt.new_string(size).is_array())) {
		var_candidates = rt.new_array()
		if !(var_imagedata.array_isset(rt.new_string('file')))
			&& var_imagedata.array_get(rt.new_string('sizes')).array_isset(rt.new_string('full')) {
			var_imagedata.array_set('height',
				var_imagedata.array_get(rt.new_string('sizes')).array_get(rt.new_string('full')).array_get(rt.new_string('height')))
			var_imagedata.array_set('width',
				var_imagedata.array_get(rt.new_string('sizes')).array_get(rt.new_string('full')).array_get(rt.new_string('width')))
		}
		mut iter_1 := var_imagedata.array_get(rt.new_string('sizes')).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_data_shadow := item_1.val
			mut var__size_shadow := item_1.key
			if rt.new_int((var_data_shadow.array_get(rt.new_string('width'))).to_i64()) == rt.new_int((rt.new_string(size).array_get(rt.new_int(0))).to_i64())
				&& rt.new_int((var_data_shadow.array_get(rt.new_string('height'))).to_i64()) == rt.new_int((rt.new_string(size).array_get(rt.new_int(1))).to_i64()) {
				var_candidates.array_set(rt.mul(var_data_shadow.array_get(rt.new_string('width')),
					var_data_shadow.array_get(rt.new_string('height'))), var_data_shadow.clone())
				break
			}
			if rt.is_true(rt.greater_equal(var_data_shadow.array_get(rt.new_string('width')), rt.new_string(size).array_get(rt.new_int(0))))
				&& rt.is_true(rt.greater_equal(var_data_shadow.array_get(rt.new_string('height')), rt.new_string(size).array_get(rt.new_int(1)))) {
				if rt.is_true(rt.identical(rt.new_int(0), rt.new_string(size).array_get(rt.new_int(0))))
					|| rt.is_true(rt.identical(rt.new_int(0), rt.new_string(size).array_get(rt.new_int(1)))) {
					var_same_ratio = wp_image_matches_ratio(var_data_shadow.array_get(rt.new_string('width')),
						var_data_shadow.array_get(rt.new_string('height')),
						var_imagedata.array_get(rt.new_string('width')),
						var_imagedata.array_get(rt.new_string('height')))
				} else {
					var_same_ratio = wp_image_matches_ratio(var_data_shadow.array_get(rt.new_string('width')),
						var_data_shadow.array_get(rt.new_string('height')),
						rt.new_string(size).array_get(rt.new_int(0)),
						rt.new_string(size).array_get(rt.new_int(1)))
				}
				if var_same_ratio {
					var_candidates.array_set(rt.mul(var_data_shadow.array_get(rt.new_string('width')),
						var_data_shadow.array_get(rt.new_string('height'))),
						var_data_shadow.clone())
				}
			}
		}
		if !(!rt.is_true(var_candidates)) {
			if 1 < var_candidates.clone().array_count() {
				rt.call_function('ksort', [var_candidates.clone()])
			}
			var_data = rt.call_function('array_shift', [var_candidates.clone()])
		} else if
			!(!rt.is_true(var_imagedata.array_get(rt.new_string('sizes')).array_get(rt.new_string('thumbnail'))))
			&& rt.is_true(rt.less_equal(rt.new_string(size).array_get(rt.new_int(0)), var_imagedata.array_get(rt.new_string('sizes')).array_get(rt.new_string('thumbnail')).array_get(rt.new_string('width'))))
			&& rt.is_true(rt.less_equal(rt.new_string(size).array_get(rt.new_int(1)), var_imagedata.array_get(rt.new_string('sizes')).array_get(rt.new_string('thumbnail')).array_get(rt.new_string('width')))) {
			var_data =
				var_imagedata.array_get(rt.new_string('sizes')).array_get(rt.new_string('thumbnail'))
		} else {
			return false
		}
		mut list_tmp_6 := image_constrain_size_for_editor(var_data.array_get(rt.new_string('width')),
			var_data.array_get(rt.new_string('height')), size, rt.new_null())
		var_data.array_get_mut('width') = list_tmp_6.array_get(0)
		var_data.array_get_mut('height') = list_tmp_6.array_get(1)
	} else if !(!rt.is_true(var_imagedata.array_get(rt.new_string('sizes')).array_get(rt.new_string(size)))) {
		var_data = var_imagedata.array_get(rt.new_string('sizes')).array_get(rt.new_string(size))
	}
	if !rt.is_true(var_data) {
		return false
	}
	if !rt.is_true(var_data.array_get(rt.new_string('path')))
		&& !(!rt.is_true(var_data.array_get(rt.new_string('file'))))
		&& !(!rt.is_true(var_imagedata.array_get(rt.new_string('file')))) {
		var_file_url = rt.call_function('wp_get_attachment_url', [
			var_post_id.clone()])
		var_data.array_set('path', rt.call_function('path_join', [
			rt.call_function('dirname', [var_imagedata.array_get(rt.new_string('file'))]),
			var_data.array_get(rt.new_string('file')),
		]))
		var_data.array_set('url', rt.call_function('path_join', [
			rt.call_function('dirname', [var_file_url.clone()]),
			var_data.array_get(rt.new_string('file')),
		]))
	}
	return (rt.call_function('apply_filters', [
		rt.new_string('image_get_intermediate_size'),
		var_data.clone(),
		var_post_id.clone(),
		rt.new_string(size),
	])).to_bool()
}

fn get_intermediate_image_sizes() rt.PhpVal {
	mut var_default_sizes := rt.new_null()
	mut var_additional_sizes := rt.new_null()
	var_default_sizes = rt.create_array([rt.ArrayItem{ key: none, val: 'thumbnail' },
		rt.ArrayItem{ key: none, val: 'medium' }, rt.ArrayItem{ key: none, val: 'medium_large' },
		rt.ArrayItem{ key: none, val: 'large' }])
	var_additional_sizes = wp_get_additional_image_sizes()
	if !(!rt.is_true(var_additional_sizes)) {
		var_default_sizes = rt.call_function('array_merge', [
			var_default_sizes.clone(), rt.func_array_keys(var_additional_sizes.clone())])
	}
	return rt.call_function('apply_filters', [rt.new_string('intermediate_image_sizes'),
		var_default_sizes.clone()])
}

fn wp_get_registered_image_subsizes() rt.PhpVal {
	mut var_additional_sizes := rt.new_null()
	mut var_all_sizes := rt.new_null()
	mut var_size_name := rt.new_null()
	mut var_size_data := map[string]rt.PhpVal{}
	var_additional_sizes = wp_get_additional_image_sizes()
	var_all_sizes = rt.new_array()
	mut iter_2 := get_intermediate_image_sizes().iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_size_name_shadow := item_2.val
		var_size_data = {
			'width':  rt.new_int(0)
			'height': rt.new_int(0)
			'crop':   rt.new_bool(false)
		}
		if var_additional_sizes.array_get(var_size_name_shadow).array_isset(rt.new_string('width')) {
			var_size_data['width'] =
				rt.new_int((var_additional_sizes.array_get(var_size_name_shadow).array_get(rt.new_string('width'))).to_i64())
		} else {
			var_size_data['width'] = rt.new_int((rt.call_function('get_option', [
				rt.new_string('${var_size_name.to_string()}_size_w'),
			])).to_i64())
		}
		if var_additional_sizes.array_get(var_size_name_shadow).array_isset(rt.new_string('height')) {
			var_size_data['height'] =
				rt.new_int((var_additional_sizes.array_get(var_size_name_shadow).array_get(rt.new_string('height'))).to_i64())
		} else {
			var_size_data['height'] = rt.new_int((rt.call_function('get_option', [
				rt.new_string('${var_size_name.to_string()}_size_h'),
			])).to_i64())
		}
		if !rt.is_true(var_size_data['width']) && !rt.is_true(var_size_data['height']) {
			continue
		}
		if var_additional_sizes.array_get(var_size_name_shadow).array_isset(rt.new_string('crop')) {
			var_size_data['crop'] =
				var_additional_sizes.array_get(var_size_name_shadow).array_get(rt.new_string('crop'))
		} else {
			var_size_data['crop'] = rt.call_function('get_option', [
				rt.new_string('${var_size_name.to_string()}_crop'),
			])
		}
		if !(var_size_data['crop'].is_array()) || !rt.is_true(var_size_data['crop']) {
			var_size_data['crop'] = (var_size_data['crop']).to_bool()
		}
		var_all_sizes.array_set(var_size_name_shadow, var_size_data.clone())
	}
	return var_all_sizes.clone()
}

fn wp_get_attachment_image_src(var_attachment_id rt.PhpVal, size string, icon bool) rt.PhpVal {
	mut var_size := size
	mut var_icon := icon
	mut var_image := rt.new_null()
	mut var_src := rt.new_null()
	mut var_icon_dir := rt.new_null()
	mut var_src_file := rt.new_null()
	mut var_ext := ''
	mut var_width := i64(0)
	mut var_height := i64(0)
	var_image = image_downsize(var_attachment_id.clone(), size)
	if rt.is_true(rt.new_bool(!(rt.is_true(var_image)))) {
		var_src = rt.new_bool(false)
		if var_icon {
			var_src = rt.call_function('wp_mime_type_icon', [
				var_attachment_id.clone(), rt.new_string('.svg')])
			if rt.is_true(var_src) {
				var_icon_dir = rt.call_function('apply_filters', [
					rt.new_string('icon_dir'),
					rt.new_string(
						(rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/images/media'),
				])
				var_src_file = rt.new_string(var_icon_dir.str() + '/' +
					(rt.call_function('wp_basename', [var_src.clone()])).str())
				mut list_tmp_7 := wp_getimagesize(var_src_file.clone(), rt.new_null())
				var_width = list_tmp_7.array_get(0)
				var_height = list_tmp_7.array_get(1)
				var_ext = rt.call_function('substr', [var_src_file.clone(),
					rt.new_int(-4)]).to_string().to_lower()
				if rt.is_true(rt.identical(rt.new_string('.svg'), rt.new_string(var_ext.str()))) {
					var_width = 48
					var_height = 64
				} else {
					mut list_tmp_8 := wp_getimagesize(var_src_file.clone(), rt.new_null())
					var_width = list_tmp_8.array_get(0)
					var_height = list_tmp_8.array_get(1)
				}
			}
		}
		if rt.is_true(var_src) && var_width != 0 && var_height != 0 {
			var_image = rt.create_array([rt.ArrayItem{ key: none, val: var_src },
				rt.ArrayItem{ key: none, val: var_width }, rt.ArrayItem{ key: none, val: var_height },
				rt.ArrayItem{ key: none, val: false }])
		}
	}
	return rt.call_function('apply_filters', [
		rt.new_string('wp_get_attachment_image_src'),
		var_image.clone(),
		var_attachment_id.clone(),
		rt.new_string(size),
		rt.new_bool(icon),
	])
}

fn wp_get_attachment_image(var_attachment_id rt.PhpVal, size string, icon bool, attr string) rt.PhpVal {
	mut var_size := size
	mut var_icon := icon
	mut var_attr := attr
	mut var_src := rt.new_null()
	mut var_html := ''
	mut var_image := rt.new_null()
	mut var_attachment := rt.new_null()
	mut var_size_class := rt.new_null()
	mut var_default_attr := map[string]rt.PhpVal{}
	mut var_context := rt.new_null()
	mut var_loading_optimization_attr := rt.new_null()
	mut var_image_meta := rt.new_null()
	mut var_size_array := rt.new_null()
	mut var_srcset := rt.new_null()
	mut var_sizes := rt.new_null()
	mut var_add_auto_sizes := rt.new_null()
	mut var_width := rt.new_null()
	mut var_height := rt.new_null()
	mut var_hwstring := ''
	mut var_value := rt.new_null()
	mut var_name := rt.new_null()
	var_html = ''
	var_image = wp_get_attachment_image_src(var_attachment_id.clone(), size, icon)
	if rt.is_true(var_image) {
		mut list_tmp_9 := var_image
		var_src = list_tmp_9.array_get(0)
		var_width = list_tmp_9.array_get(1)
		var_height = list_tmp_9.array_get(2)
		var_attachment = rt.call_function('get_post', [var_attachment_id.clone()])
		var_size_class = rt.new_string(size)
		if rt.is_true(rt.new_bool(var_size_class.clone().is_array())) {
			var_size_class = rt.call_function('implode', [rt.new_string('x'),
				var_size_class.clone()])
		}
		var_default_attr = {
			'src':   var_src
			'class': rt.new_string('attachment-${var_size_class.to_string()} size-${var_size_class.to_string()}')
			'alt':   rt.new_string(rt.call_function('strip_tags', [
				rt.call_function('get_post_meta', [var_attachment_id.clone(),
					rt.new_string('_wp_attachment_image_alt'),
					rt.new_bool(true)]),
			]).to_string().trim_space())
		}
		var_context = rt.call_function('apply_filters', [
			rt.new_string('wp_get_attachment_image_context'),
			rt.new_string('wp_get_attachment_image'),
		])
		var_attr = (rt.call_function('wp_parse_args', [rt.new_string(var_attr.str()),
			rt.create_array_from_native_map(var_default_attr)])).str()
		if !(rt.new_string(var_attr.str()).array_isset(rt.new_string('width')))
			|| !(rt.new_string(var_attr.str()).array_get(rt.new_string('width')).is_long()
			|| rt.new_string(var_attr.str()).array_get(rt.new_string('width')).is_double()) {
			rt.new_string(var_attr.str()).array_set('width', var_width.clone())
		}
		if !(rt.new_string(var_attr.str()).array_isset(rt.new_string('height')))
			|| !(rt.new_string(var_attr.str()).array_get(rt.new_string('height')).is_long()
			|| rt.new_string(var_attr.str()).array_get(rt.new_string('height')).is_double()) {
			rt.new_string(var_attr.str()).array_set('height', var_height.clone())
		}
		var_loading_optimization_attr = wp_get_loading_optimization_attributes('img',
			rt.new_string(var_attr.str()), var_context.clone())
		var_attr = (rt.call_function('array_merge', [rt.new_string(var_attr.str()),
			var_loading_optimization_attr.clone()])).str()
		if !rt.is_true(rt.new_string(var_attr.str()).array_get(rt.new_string('decoding')))
			|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [rt.new_string(var_attr.str()).array_get(rt.new_string('decoding')), rt.create_array([rt.ArrayItem{
			key: none
			val: 'async'
		}, rt.ArrayItem{ key: none, val: 'sync' }, rt.ArrayItem{ key: none, val: 'auto' }]), rt.new_bool(true)]))))) {
			rt.new_string(var_attr.str()).array_unset(rt.new_string('decoding'))
		}
		if rt.new_string(var_attr.str()).array_isset(rt.new_string('loading'))
			&& rt.is_true(rt.new_bool(!(rt.is_true(rt.new_string(var_attr.str()).array_get(rt.new_string('loading')))))) {
			rt.new_string(var_attr.str()).array_unset(rt.new_string('loading'))
		}
		if rt.new_string(var_attr.str()).array_isset(rt.new_string('fetchpriority'))
			&& rt.is_true(rt.new_bool(!(rt.is_true(rt.new_string(var_attr.str()).array_get(rt.new_string('fetchpriority')))))) {
			rt.new_string(var_attr.str()).array_unset(rt.new_string('fetchpriority'))
		}
		if !rt.is_true(rt.new_string(var_attr.str()).array_get(rt.new_string('srcset'))) {
			var_image_meta = rt.call_function('wp_get_attachment_metadata', [
				var_attachment_id.clone()])
			if rt.is_true(rt.new_bool(var_image_meta.clone().is_array())) {
				var_size_array = rt.create_array([
					rt.ArrayItem{ key: none, val: rt.call_function('absint', [
						var_width.clone()]) },
					rt.ArrayItem{ key: none, val: rt.call_function('absint', [
						var_height.clone()]) },
				])
				var_srcset = wp_calculate_image_srcset(var_size_array.clone(), var_src.clone(),
					var_image_meta.clone(), var_attachment_id.clone())
				var_sizes = rt.new_bool(wp_calculate_image_sizes(var_size_array.clone(),
					var_src.clone(), var_image_meta.clone(), var_attachment_id.clone()))
				if rt.is_true(var_srcset) && rt.is_true(var_sizes)
					|| !(!rt.is_true(rt.new_string(var_attr.str()).array_get(rt.new_string('sizes')))) {
					rt.new_string(var_attr.str()).array_set('srcset', var_srcset.clone())
					if !rt.is_true(rt.new_string(var_attr.str()).array_get(rt.new_string('sizes'))) {
						rt.new_string(var_attr.str()).array_set('sizes', var_sizes.clone())
					}
				}
			}
		}
		var_add_auto_sizes = rt.call_function('apply_filters', [
			rt.new_string('wp_img_tag_add_auto_sizes'),
			rt.new_bool(true),
		])
		if rt.is_true(var_add_auto_sizes)
			&& rt.new_string(var_attr.str()).array_isset(rt.new_string('loading'))
			&& rt.is_true(rt.identical(rt.new_string('lazy'), rt.new_string(var_attr.str()).array_get(rt.new_string('loading'))))
			&& rt.new_string(var_attr.str()).array_isset(rt.new_string('sizes'))
			&& !(wp_sizes_attribute_includes_valid_auto(rt.new_string(var_attr.str()).array_get(rt.new_string('sizes')))) {
			rt.new_string(var_attr.str()).array_set('sizes', 'auto, ' +
				(rt.new_string(var_attr.str()).array_get(rt.new_string('sizes'))).str())
		}
		var_attr = (rt.call_function('apply_filters', [
			rt.new_string('wp_get_attachment_image_attributes'),
			rt.new_string(var_attr.str()),
			var_attachment.clone(),
			rt.new_string(size),
		])).str()
		if rt.new_string(var_attr.str()).array_isset(rt.new_string('width'))
			&& rt.new_string(var_attr.str()).array_get(rt.new_string('width')).is_long()
			|| rt.new_string(var_attr.str()).array_get(rt.new_string('width')).is_double() {
			var_width = rt.call_function('absint',
				[rt.new_string(var_attr.str()).array_get(rt.new_string('width'))])
		}
		if rt.new_string(var_attr.str()).array_isset(rt.new_string('height'))
			&& rt.new_string(var_attr.str()).array_get(rt.new_string('height')).is_long()
			|| rt.new_string(var_attr.str()).array_get(rt.new_string('height')).is_double() {
			var_height = rt.call_function('absint', [
				rt.new_string(var_attr.str()).array_get(rt.new_string('height')),
			])
		}
		rt.new_string(var_attr.str()).array_unset(rt.new_string('width'))
		rt.new_string(var_attr.str()).array_unset(rt.new_string('height'))
		var_attr = (rt.call_function('array_map', [rt.new_string('esc_attr'),
			rt.new_string(var_attr.str())])).str()
		var_hwstring = image_hwstring(var_width.clone(), var_height.clone())
		var_html = '<img ${var_hwstring}'.trim_right(' \t\n\r')
		mut iter_3 := rt.new_string(var_attr.str()).iterator()
		for {
			item_3 := iter_3.next() or { break }
			mut var_value_shadow := item_3.val
			mut var_name_shadow := item_3.key
			var_html = var_html + ' ${var_name.to_string()}=' + '"' + var_value_shadow.str() + '"'
		}
		var_html = var_html + ' />'
	}
	return rt.call_function('apply_filters', [rt.new_string('wp_get_attachment_image'),
		rt.new_string(var_html.str()).clone(), var_attachment_id.clone(),
		rt.new_string(size), rt.new_bool(icon), rt.new_string(var_attr.str())])
}

fn wp_get_attachment_image_url(var_attachment_id rt.PhpVal, size string, icon bool) rt.PhpVal {
	mut var_size := size
	mut var_icon := icon
	mut var_image := rt.new_null()
	var_image = wp_get_attachment_image_src(var_attachment_id.clone(), size, icon)
	return if !(var_image.array_get(rt.new_int(0))).is_null() {
		var_image.array_get(rt.new_int(0))
	} else {
		rt.new_bool(false)
	}
}

fn _wp_get_attachment_relative_path(var_file rt.PhpVal) string {
	mut var_dirname := rt.new_null()
	var_dirname = rt.call_function('dirname', [var_file.clone()])
	if rt.is_true(rt.identical(rt.new_string('.'), var_dirname)) {
		return ''
	}
	if rt.is_true(rt.call_function('str_contains', [var_dirname.clone(),
		rt.new_string('wp-content/uploads')]))
	{
		var_dirname = rt.call_function('substr', [var_dirname.clone(),
			rt.add(rt.call_function('strpos', [var_dirname.clone(),
				rt.new_string('wp-content/uploads')]), rt.new_int(18))])
		var_dirname = rt.new_string(var_dirname.clone().to_string().trim_left(' \t\n\r'))
	}
	return var_dirname.str()
}

fn _wp_get_image_size_from_meta(var_size_name rt.PhpVal, var_image_meta rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.identical(rt.new_string('full'), var_size_name)) {
		return rt.create_array([
			rt.ArrayItem{ key: none, val: rt.call_function('absint', [
				var_image_meta.array_get(rt.new_string('width')),
			]) },
			rt.ArrayItem{ key: none, val: rt.call_function('absint', [
				var_image_meta.array_get(rt.new_string('height')),
			]) },
		])
	} else if !(!rt.is_true(var_image_meta.array_get(rt.new_string('sizes')).array_get(var_size_name))) {
		return rt.create_array([
			rt.ArrayItem{ key: none, val: rt.call_function('absint', [
				var_image_meta.array_get(rt.new_string('sizes')).array_get(var_size_name).array_get(rt.new_string('width')),
			]) },
			rt.ArrayItem{ key: none, val: rt.call_function('absint', [
				var_image_meta.array_get(rt.new_string('sizes')).array_get(var_size_name).array_get(rt.new_string('height')),
			]) },
		])
	}
	return rt.new_bool(false)
}

fn wp_get_attachment_image_srcset(var_attachment_id rt.PhpVal, size string, var_image_meta_arg rt.PhpVal) bool {
	mut var_size := size
	mut var_image_meta := var_image_meta_arg
	mut var_image := rt.new_null()
	mut var_image_src := rt.new_null()
	mut var_size_array := rt.new_null()
	var_image = wp_get_attachment_image_src(var_attachment_id.clone(), size, false)
	if rt.is_true(rt.new_bool(!(rt.is_true(var_image)))) {
		return false
	}
	if !(var_image_meta.clone().is_array()) {
		var_image_meta = rt.call_function('wp_get_attachment_metadata', [
			var_attachment_id.clone()])
	}
	var_image_src = var_image.array_get(rt.new_int(0))
	var_size_array = rt.create_array([
		rt.ArrayItem{ key: none, val: rt.call_function('absint', [
			var_image.array_get(rt.new_int(1)),
		]) },
		rt.ArrayItem{ key: none, val: rt.call_function('absint', [
			var_image.array_get(rt.new_int(2)),
		]) },
	])
	return (wp_calculate_image_srcset(var_size_array.clone(), var_image_src.clone(),
		var_image_meta.clone(), var_attachment_id.clone())).to_bool()
}

fn wp_calculate_image_srcset(var_size_array rt.PhpVal, var_image_src rt.PhpVal, var_image_meta_arg rt.PhpVal, attachment_id i64) rt.PhpVal {
	mut var_attachment_id := attachment_id
	mut var_image_meta := var_image_meta_arg
	mut var_image_edit_hash := []rt.PhpVal{}
	mut var_image_sizes := rt.new_null()
	mut var_image_width := rt.new_null()
	mut var_image_height := rt.new_null()
	mut var_image_basename := rt.new_null()
	mut var_dirname := rt.new_null()
	mut var_upload_dir := rt.new_null()
	mut var_image_baseurl := rt.new_null()
	mut var_parsed := rt.new_null()
	mut var_domain := rt.new_null()
	mut var_image_edited := rt.new_null()
	mut var_max_srcset_image_width := rt.new_null()
	mut var_sources := rt.new_null()
	mut var_src_matched := false
	mut var_image := rt.new_null()
	mut var_is_src := false
	mut var_source := rt.new_null()
	mut var_srcset := ''
	var_image_meta = rt.call_function('apply_filters', [
		rt.new_string('wp_calculate_image_srcset_meta'),
		var_image_meta.clone(),
		var_size_array.clone(),
		var_image_src.clone(),
		rt.new_int(attachment_id),
	])
	if !rt.is_true(var_image_meta.array_get(rt.new_string('sizes')))
		|| !(var_image_meta.array_isset(rt.new_string('file')))
		|| var_image_meta.array_get(rt.new_string('file')).to_string().len < 4 {
		return rt.new_bool(false)
	}
	var_image_sizes = var_image_meta.array_get(rt.new_string('sizes'))
	var_image_width = rt.new_int((var_size_array.array_get(rt.new_int(0))).to_i64())
	var_image_height = rt.new_int((var_size_array.array_get(rt.new_int(1))).to_i64())
	if rt.is_true(rt.less(var_image_width, rt.new_int(1))) {
		return rt.new_bool(false)
	}
	var_image_basename = rt.call_function('wp_basename', [
		var_image_meta.array_get(rt.new_string('file')),
	])
	if !(var_image_sizes.array_get(rt.new_string('thumbnail')).array_isset(rt.new_string('mime-type')))
		|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('image/gif'), var_image_sizes.array_get(rt.new_string('thumbnail')).array_get(rt.new_string('mime-type')))))) {
		var_image_sizes.array_push(rt.create_array([
			rt.ArrayItem{ key: 'width', val: var_image_meta.array_get(rt.new_string('width')) },
			rt.ArrayItem{ key: 'height', val: var_image_meta.array_get(rt.new_string('height')) },
			rt.ArrayItem{ key: 'file', val: var_image_basename },
		]))
	} else if rt.is_true(rt.call_function('str_contains', [var_image_src.clone(),
		var_image_meta.array_get(rt.new_string('file'))]))
	{
		return rt.new_bool(false)
	}
	var_dirname =
		rt.new_string(_wp_get_attachment_relative_path(var_image_meta.array_get(rt.new_string('file'))))
	if rt.is_true(var_dirname) {
		var_dirname = rt.call_function('trailingslashit', [var_dirname.clone()])
	}
	var_upload_dir = rt.call_function('wp_get_upload_dir', []rt.PhpVal{})
	var_image_baseurl = rt.new_string(
		(rt.call_function('trailingslashit', [var_upload_dir.array_get(rt.new_string('baseurl'))])).str() +
		var_dirname.str())
	if rt.is_true(rt.call_function('is_ssl', []rt.PhpVal{}))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('str_starts_with', [var_image_baseurl.clone(), rt.new_string('https')]))))) {
		var_parsed = rt.call_function('parse_url', [var_image_baseurl.clone()])
		var_domain = if !(var_parsed.array_get(rt.new_string('host'))).is_null() {
			var_parsed.array_get(rt.new_string('host'))
		} else {
			rt.new_string('')
		}
		if var_parsed.array_isset(rt.new_string('port')) {
			var_domain = rt.concat(var_domain, rt.new_string(':' +
				(var_parsed.array_get(rt.new_string('port'))).str()))
		}
		if rt.is_true(rt.identical(rt.get_superglobal('_SERVER').array_get(rt.new_string('HTTP_HOST')),
			var_domain))
		{
			var_image_baseurl = rt.call_function('set_url_scheme', [
				var_image_baseurl.clone(), rt.new_string('https')])
		}
	}
	var_image_edited = rt.call_function('preg_match', [rt.new_string('/-e[0-9]{13}/'),
		rt.call_function('wp_basename', [var_image_src.clone()]),
		rt.create_array_from_list(var_image_edit_hash)])
	var_max_srcset_image_width = rt.call_function('apply_filters', [
		rt.new_string('max_srcset_image_width'),
		rt.new_int(2048),
		var_size_array.clone(),
	])
	var_sources = rt.new_array()
	var_src_matched = false
	mut iter_4 := var_image_sizes.iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_image_shadow := item_4.val
		var_is_src = false
		if !(var_image_shadow.clone().is_array()) {
			continue
		}
		if !var_src_matched
			&& rt.is_true(rt.call_function('str_contains', [var_image_src.clone(), rt.new_string(var_dirname.str() + (var_image_shadow.array_get(rt.new_string('file'))).str())])) {
			var_src_matched = true
			var_is_src = true
		}
		if rt.is_true(var_image_edited)
			&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('strpos', [var_image_shadow.array_get(rt.new_string('file')), var_image_edit_hash[0]]))))) {
			continue
		}
		if rt.is_true(var_max_srcset_image_width)
			&& rt.is_true(rt.greater(var_image_shadow.array_get(rt.new_string('width')), var_max_srcset_image_width))
			&& !var_is_src {
			continue
		}
		if rt.is_true(rt.new_bool(wp_image_matches_ratio(var_image_width.clone(),
			var_image_height.clone(), var_image_shadow.array_get(rt.new_string('width')),
			var_image_shadow.array_get(rt.new_string('height')))))
		{
			var_source = rt.create_array([
				rt.ArrayItem{ key: 'url', val: var_image_baseurl.str() +
					(var_image_shadow.array_get(rt.new_string('file'))).str() },
				rt.ArrayItem{ key: 'descriptor', val: 'w' },
				rt.ArrayItem{ key: 'value', val: var_image_shadow.array_get(rt.new_string('width')) },
			])
			if var_is_src {
				var_sources = rt.add(rt.create_array([
					rt.ArrayItem{
						key: var_image_shadow.array_get(rt.new_string('width'))
						val: var_source
					},
				]), var_sources)
			} else {
				var_sources.array_set(var_image_shadow.array_get(rt.new_string('width')),
					var_source.clone())
			}
		}
	}
	var_sources = rt.call_function('apply_filters', [
		rt.new_string('wp_calculate_image_srcset'),
		var_sources.clone(),
		var_size_array.clone(),
		var_image_src.clone(),
		var_image_meta.clone(),
		rt.new_int(attachment_id),
	])
	if !var_src_matched || !(var_sources.clone().is_array())
		|| var_sources.clone().array_count() < 2 {
		return rt.new_bool(false)
	}
	var_srcset = ''
	mut iter_5 := var_sources.iterator()
	for {
		item_5 := iter_5.next() or { break }
		mut var_source_shadow := item_5.val
		var_srcset = var_srcset +
			(rt.call_function('str_replace', [rt.new_string(' '), rt.new_string('%20'), var_source_shadow.array_get(rt.new_string('url'))])).str() +
			' ' +
			(var_source_shadow.array_get(rt.new_string('value'))).str() + (var_source_shadow.array_get(rt.new_string('descriptor'))).str() + ', '
	}
	return rt.new_string((var_srcset.trim_right(' \t\n\r')).str())
}

fn wp_get_attachment_image_sizes(var_attachment_id rt.PhpVal, size string, var_image_meta_arg rt.PhpVal) bool {
	mut var_size := size
	mut var_image_meta := var_image_meta_arg
	mut var_image := rt.new_null()
	mut var_image_src := rt.new_null()
	mut var_size_array := rt.new_null()
	var_image = wp_get_attachment_image_src(var_attachment_id.clone(), size, false)
	if rt.is_true(rt.new_bool(!(rt.is_true(var_image)))) {
		return false
	}
	if !(var_image_meta.clone().is_array()) {
		var_image_meta = rt.call_function('wp_get_attachment_metadata', [
			var_attachment_id.clone()])
	}
	var_image_src = var_image.array_get(rt.new_int(0))
	var_size_array = rt.create_array([
		rt.ArrayItem{ key: none, val: rt.call_function('absint', [
			var_image.array_get(rt.new_int(1)),
		]) },
		rt.ArrayItem{ key: none, val: rt.call_function('absint', [
			var_image.array_get(rt.new_int(2)),
		]) },
	])
	return wp_calculate_image_sizes(var_size_array.clone(), var_image_src.clone(),
		var_image_meta.clone(), var_attachment_id.clone())
}

fn wp_calculate_image_sizes(var_size rt.PhpVal, var_image_src rt.PhpVal, var_image_meta_arg rt.PhpVal, attachment_id i64) bool {
	mut var_attachment_id := attachment_id
	mut var_image_meta := var_image_meta_arg
	mut var_width := rt.new_null()
	mut var_size_array := rt.new_null()
	mut var_sizes := rt.new_null()
	var_width = rt.new_int(0)
	if rt.is_true(rt.new_bool(var_size.clone().is_array())) {
		var_width = rt.call_function('absint', [var_size.array_get(rt.new_int(0))])
	} else if rt.is_true(rt.new_bool(var_size.clone().is_string())) {
		if rt.is_true(rt.new_bool(!(rt.is_true(var_image_meta)))) && var_attachment_id != 0 {
			var_image_meta = rt.call_function('wp_get_attachment_metadata', [
				rt.new_int(attachment_id),
			])
		}
		if rt.is_true(rt.new_bool(var_image_meta.clone().is_array())) {
			var_size_array = _wp_get_image_size_from_meta(var_size.clone(), var_image_meta.clone())
			if rt.is_true(var_size_array) {
				var_width = rt.call_function('absint', [var_size_array.array_get(rt.new_int(0))])
			}
		}
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_width)))) {
		return false
	}
	var_sizes = rt.call_function('sprintf', [
		rt.new_string('(max-width: %1$dpx) 100vw, %1$dpx'),
		var_width.clone(),
	])
	return (rt.call_function('apply_filters', [rt.new_string('wp_calculate_image_sizes'),
		var_sizes.clone(), var_size.clone(), var_image_src.clone(),
		var_image_meta.clone(), rt.new_int(attachment_id)])).to_bool()
}

fn wp_image_file_matches_image_meta(var_image_location rt.PhpVal, var_image_meta rt.PhpVal, attachment_id i64) rt.PhpVal {
	mut var_attachment_id := attachment_id
	mut var_match := false
	mut var_dirname := rt.new_null()
	mut var_relative_path := rt.new_null()
	mut var_image_size_data := map[string]rt.PhpVal{}
	var_match = false
	if var_image_meta.array_isset(rt.new_string('file'))
		&& var_image_meta.array_get(rt.new_string('file')).to_string().len > 4 {
		mut list_tmp_10 := rt.call_function('explode', [rt.new_string('?'),
			var_image_location.clone()])
		var_image_location = list_tmp_10.array_get(0)
		if rt.is_true(rt.identical(rt.call_function('strrpos', [
			var_image_location.clone(), var_image_meta.array_get(rt.new_string('file'))]),
			var_image_location.clone().to_string().len - var_image_meta.array_get(rt.new_string('file')).to_string().len))
		{
			var_match = true
		} else {
			var_dirname =
				rt.new_string(_wp_get_attachment_relative_path(var_image_meta.array_get(rt.new_string('file'))))
			if rt.is_true(var_dirname) {
				var_dirname = rt.call_function('trailingslashit', [
					var_dirname.clone()])
			}
			if !(!rt.is_true(var_image_meta.array_get(rt.new_string('original_image')))) {
				var_relative_path = rt.new_string(var_dirname.str() +
					(var_image_meta.array_get(rt.new_string('original_image'))).str())
				if rt.is_true(rt.identical(rt.call_function('strrpos', [
					var_image_location.clone(), var_relative_path.clone()]),
					var_image_location.clone().to_string().len - var_relative_path.clone().to_string().len))
				{
					var_match = true
				}
			}
			if !var_match && !(!rt.is_true(var_image_meta.array_get(rt.new_string('sizes')))) {
				mut iter_6 := var_image_meta.array_get(rt.new_string('sizes')).iterator()
				for {
					item_6 := iter_6.next() or { break }
					mut var_image_size_data_shadow := item_6.val
					var_relative_path = rt.new_string(var_dirname.str() +
						(var_image_size_data_shadow['file']).str())
					if rt.is_true(rt.identical(rt.call_function('strrpos', [
						var_image_location.clone(), var_relative_path.clone()]),
						var_image_location.clone().to_string().len - var_relative_path.clone().to_string().len))
					{
						var_match = true
						break
					}
				}
			}
		}
	}
	return rt.call_function('apply_filters', [
		rt.new_string('wp_image_file_matches_image_meta'),
		rt.new_bool(var_match).clone(),
		var_image_location.clone(),
		var_image_meta.clone(),
		rt.new_int(attachment_id),
	])
}

fn wp_image_src_get_dimensions(var_image_src rt.PhpVal, var_image_meta rt.PhpVal, attachment_id i64) rt.PhpVal {
	mut var_attachment_id := attachment_id
	mut var_dimensions := rt.new_null()
	mut var_src_filename := rt.new_null()
	mut var_image_size_data := map[string]rt.PhpVal{}
	var_dimensions = rt.new_bool(false)
	if var_image_meta.array_isset(rt.new_string('file'))
		&& rt.is_true(rt.call_function('str_contains', [var_image_src.clone(), rt.call_function('wp_basename', [var_image_meta.array_get(rt.new_string('file'))])])) {
		var_dimensions = rt.create_array([
			rt.ArrayItem{
				key: none
				val: rt.new_int((var_image_meta.array_get(rt.new_string('width'))).to_i64())
			},
			rt.ArrayItem{
				key: none
				val: rt.new_int((var_image_meta.array_get(rt.new_string('height'))).to_i64())
			},
		])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_dimensions))))
		&& !(!rt.is_true(var_image_meta.array_get(rt.new_string('sizes')))) {
		var_src_filename = rt.call_function('wp_basename', [var_image_src.clone()])
		mut iter_7 := var_image_meta.array_get(rt.new_string('sizes')).iterator()
		for {
			item_7 := iter_7.next() or { break }
			mut var_image_size_data_shadow := item_7.val
			if rt.is_true(rt.identical(var_src_filename, var_image_size_data_shadow['file'])) {
				var_dimensions = rt.create_array([
					rt.ArrayItem{
						key: none
						val: rt.new_int((var_image_size_data_shadow['width']).to_i64())
					},
					rt.ArrayItem{
						key: none
						val: rt.new_int((var_image_size_data_shadow['height']).to_i64())
					},
				])
				break
			}
		}
	}
	return rt.call_function('apply_filters', [
		rt.new_string('wp_image_src_get_dimensions'),
		var_dimensions.clone(),
		var_image_src.clone(),
		var_image_meta.clone(),
		rt.new_int(attachment_id),
	])
}

fn wp_image_add_srcset_and_sizes(var_image rt.PhpVal, var_image_meta rt.PhpVal, var_attachment_id rt.PhpVal) rt.PhpVal {
	mut var_match_src := rt.new_null()
	mut var_img_edit_hash := []rt.PhpVal{}
	mut var_match_width := rt.new_null()
	mut var_match_height := rt.new_null()
	mut var_image_src := rt.new_null()
	mut var_width := rt.new_null()
	mut var_height := rt.new_null()
	mut var_size_array := rt.new_null()
	mut var_srcset := rt.new_null()
	mut var_sizes := rt.new_null()
	mut var_attr := rt.new_null()
	if !rt.is_true(var_image_meta.array_get(rt.new_string('sizes'))) {
		return var_image.clone()
	}
	var_image_src = if rt.is_true(rt.call_function('preg_match', [
		rt.new_string('/src="([^"]+)"/'),
		var_image.clone(),
		var_match_src.clone(),
	]))
	{ var_match_src.array_get(rt.new_int(1)) } else { rt.new_string('') }
	mut list_tmp_11 := rt.call_function('explode', [rt.new_string('?'),
		var_image_src.clone()])
	var_image_src = list_tmp_11.array_get(0)
	if rt.is_true(rt.new_bool(!(rt.is_true(var_image_src)))) {
		return var_image.clone()
	}
	if var_image_meta.array_isset(rt.new_string('file'))
		&& rt.is_true(rt.call_function('preg_match', [rt.new_string('/-e[0-9]{13}/'), var_image_meta.array_get(rt.new_string('file')), rt.create_array_from_list(var_img_edit_hash)]))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('str_contains', [rt.call_function('wp_basename', [var_image_src.clone()]), var_img_edit_hash[0]]))))) {
		return var_image.clone()
	}
	var_width = rt.new_int(if rt.is_true(rt.call_function('preg_match', [
		rt.new_string('/ width="([0-9]+)"/'),
		var_image.clone(),
		var_match_width.clone(),
	]))
	{ rt.new_int((var_match_width.array_get(rt.new_int(1))).to_i64()) } else { 0 })
	var_height = rt.new_int(if rt.is_true(rt.call_function('preg_match', [
		rt.new_string('/ height="([0-9]+)"/'),
		var_image.clone(),
		var_match_height.clone(),
	]))
	{ rt.new_int((var_match_height.array_get(rt.new_int(1))).to_i64()) } else { 0 })
	if rt.is_true(var_width) && rt.is_true(var_height) {
		var_size_array = rt.create_array([rt.ArrayItem{ key: none, val: var_width },
			rt.ArrayItem{ key: none, val: var_height }])
	} else {
		var_size_array = wp_image_src_get_dimensions(var_image_src.clone(), var_image_meta.clone(),
			var_attachment_id.clone())
		if rt.is_true(rt.new_bool(!(rt.is_true(var_size_array)))) {
			return var_image.clone()
		}
	}
	var_srcset = wp_calculate_image_srcset(var_size_array.clone(), var_image_src.clone(),
		var_image_meta.clone(), var_attachment_id.clone())
	if rt.is_true(var_srcset) {
		var_sizes = rt.call_function('strpos', [var_image.clone(),
			rt.new_string(' sizes=')])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_sizes)))) {
			var_sizes = rt.new_bool(wp_calculate_image_sizes(var_size_array.clone(),
				var_image_src.clone(), var_image_meta.clone(), var_attachment_id.clone()))
		}
	}
	if rt.is_true(var_srcset) && rt.is_true(var_sizes) {
		var_attr = rt.call_function('sprintf', [rt.new_string(' srcset="%s"'),
			rt.call_function('esc_attr', [var_srcset.clone()])])
		if rt.is_true(rt.new_bool(var_sizes.clone().is_string())) {
			var_attr = rt.concat(var_attr, rt.call_function('sprintf', [
				rt.new_string(' sizes="%s"'),
				rt.call_function('esc_attr', [var_sizes.clone()]),
			]))
		}
		return rt.call_function('preg_replace', [
			rt.new_string('/<img ([^>]+?)[\\/ ]*>/'),
			rt.new_string('<img $1' + var_attr.str() + ' />'),
			var_image.clone(),
		])
	}
	return var_image.clone()
}

fn wp_lazy_loading_enabled(tag_name string, var_context rt.PhpVal) bool {
	mut var_tag_name := tag_name
	mut var_default := false
	var_default = rt.is_true(rt.identical(rt.new_string('img'), rt.new_string(tag_name)))
		|| rt.is_true(rt.identical(rt.new_string('iframe'), rt.new_string(tag_name)))
	return (rt.call_function('apply_filters', [rt.new_string('wp_lazy_loading_enabled'),
		rt.new_bool(var_default).clone(), rt.new_string(tag_name),
		var_context.clone()])).to_bool()
}

fn wp_filter_content_tags(var_content_arg rt.PhpVal, var_context_arg rt.PhpVal) rt.PhpVal {
	mut var_content := var_content_arg
	mut var_context := var_context_arg
	mut var_matches := []rt.PhpVal{}
	mut var_tag := rt.new_null()
	mut var_tag_name := rt.new_null()
	mut var_class_id := rt.new_null()
	mut var_add_iframe_loading_attr := false
	mut var_images := rt.new_null()
	mut var_iframes := rt.new_null()
	mut var_match := rt.new_null()
	mut var_attachment_id := rt.new_null()
	mut var_attachment_ids := rt.new_null()
	mut var_filtered_image := rt.new_null()
	mut var_filtered_iframe := rt.new_null()
	if rt.is_true(rt.identical(rt.new_null(), var_context)) {
		var_context = rt.call_function('current_filter', []rt.PhpVal{})
	}
	var_add_iframe_loading_attr = wp_lazy_loading_enabled('iframe', var_context.clone())
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('preg_match_all', [
		rt.new_string('/<(img|iframe)\\s[^>]+>/'),
		var_content.clone(),
		rt.create_array_from_list(var_matches),
		rt.get_constant('PREG_SET_ORDER'),
	])))))
	{
		return var_content.clone()
	}
	var_images = rt.new_array()
	var_iframes = rt.new_array()
	for var_match_shadow in var_matches {
		mut list_tmp_12 := var_match_shadow
		var_tag = list_tmp_12.array_get(0)
		var_tag_name = list_tmp_12.array_get(1)
		mut switch_val_1 := var_tag_name
		if rt.is_true(rt.equal(switch_val_1, rt.new_string('img'))) {
			if rt.is_true(rt.call_function('preg_match', [
				rt.new_string('/wp-image-([0-9]+)/i'),
				var_tag.clone(),
				var_class_id.clone(),
			]))
			{
				var_attachment_id = rt.call_function('absint', [
					var_class_id.array_get(rt.new_int(1)),
				])
				if rt.is_true(var_attachment_id) {
					var_images.array_set(var_tag, var_attachment_id.clone())
				}
			}
			var_images.array_set(var_tag, 0)
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('iframe'))) {
			var_iframes.array_set(var_tag, 0)
		}
	}
	var_attachment_ids = rt.call_function('array_unique', [
		rt.call_function('array_filter', [
			rt.call_function('array_values', [var_images.clone()]),
		]),
	])
	if var_attachment_ids.clone().array_count() > 1 {
		rt.call_function('_prime_post_caches', [var_attachment_ids.clone(),
			rt.new_bool(false), rt.new_bool(true)])
	}
	for var_match_shadow in var_matches {
		if var_images.array_isset(var_match_shadow.array_get(rt.new_int(0))) {
			var_filtered_image = var_match_shadow.array_get(rt.new_int(0))
			var_attachment_id = var_images.array_get(var_match_shadow.array_get(rt.new_int(0)))
			if rt.is_true(rt.greater(var_attachment_id, rt.new_int(0)))
				&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('str_contains', [var_filtered_image.clone(), rt.new_string(' width=')])))))
				&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('str_contains', [var_filtered_image.clone(), rt.new_string(' height=')]))))) {
				var_filtered_image = wp_img_tag_add_width_and_height_attr(var_filtered_image.clone(),
					var_context.clone(), var_attachment_id.clone())
			}
			if rt.is_true(rt.greater(var_attachment_id, rt.new_int(0)))
				&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('str_contains', [var_filtered_image.clone(), rt.new_string(' srcset=')]))))) {
				var_filtered_image = wp_img_tag_add_srcset_and_sizes_attr(var_filtered_image.clone(),
					var_context.clone(), var_attachment_id.clone())
			}
			var_filtered_image = wp_img_tag_add_loading_optimization_attrs(var_filtered_image.clone(),
				var_context.clone())
			var_filtered_image =
				rt.new_string(wp_img_tag_add_auto_sizes(var_filtered_image.clone()))
			var_filtered_image = rt.call_function('apply_filters', [
				rt.new_string('wp_content_img_tag'),
				var_filtered_image.clone(),
				var_context.clone(),
				var_attachment_id.clone(),
			])
			if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_filtered_image,
				var_match_shadow.array_get(rt.new_int(0))))))
			{
				var_content = rt.call_function('str_replace', [
					var_match_shadow.array_get(rt.new_int(0)),
					var_filtered_image.clone(),
					var_content.clone(),
				])
			}
			var_images.array_unset(var_match_shadow.array_get(rt.new_int(0)))
		}
		if var_iframes.array_isset(var_match_shadow.array_get(rt.new_int(0))) {
			var_filtered_iframe = var_match_shadow.array_get(rt.new_int(0))
			if var_add_iframe_loading_attr
				&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('str_contains', [var_filtered_iframe.clone(), rt.new_string(' loading=')]))))) {
				var_filtered_iframe = wp_iframe_tag_add_loading_attr(var_filtered_iframe.clone(),
					var_context.clone())
			}
			if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_filtered_iframe,
				var_match_shadow.array_get(rt.new_int(0))))))
			{
				var_content = rt.call_function('str_replace', [
					var_match_shadow.array_get(rt.new_int(0)),
					var_filtered_iframe.clone(),
					var_content.clone(),
				])
			}
			var_iframes.array_unset(var_match_shadow.array_get(rt.new_int(0)))
		}
	}
	return var_content.clone()
}

fn wp_img_tag_add_auto_sizes(image string) string {
	mut var_image := image
	mut var_processor := rt.new_null()
	mut var_loading := rt.new_null()
	mut var_width := rt.new_null()
	mut var_sizes := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('apply_filters', [
		rt.new_string('wp_img_tag_add_auto_sizes'),
		rt.new_bool(true),
	])))))
	{
		return image
	}
	var_processor = create_wp_html_tag_processor(rt.new_string(image))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_processor.next_tag(rt.create_array([
		rt.ArrayItem{ key: 'tag_name', val: 'IMG' },
	]))))))
	{
		return image
	}
	var_loading = var_processor.get_attribute(rt.new_string('loading'))
	if !(var_loading.clone().is_string())
		|| rt.is_true(rt.new_bool('lazy' != var_loading.clone().to_string().trim_space().to_lower())) {
		return image
	}
	var_width = var_processor.get_attribute(rt.new_string('width'))
	if !(var_width.clone().is_string()) || rt.is_true(rt.identical(rt.new_string(''), var_width)) {
		return image
	}
	var_sizes = var_processor.get_attribute(rt.new_string('sizes'))
	if !(var_sizes.clone().is_string()) {
		return image
	}
	if rt.is_true(rt.new_bool(wp_sizes_attribute_includes_valid_auto(var_sizes.clone()))) {
		return image
	}
	var_processor.set_attribute(rt.new_string('sizes'),
		rt.new_string('auto, ${var_sizes.to_string()}'))
	return (var_processor.get_updated_html()).str()
}

fn wp_sizes_attribute_includes_valid_auto(sizes_attr string) bool {
	mut var_sizes_attr := sizes_attr
	mut var_first_size := rt.new_null()
	mut list_tmp_13 := rt.call_function('explode', [rt.new_string(','),
		rt.new_string(sizes_attr), rt.new_int(2)])
	var_first_size = list_tmp_13.array_get(0)
	return (rt.identical(rt.new_string('auto'),
		rt.new_string(var_first_size.clone().to_string().trim_space().to_lower()))).to_bool()
}

fn wp_enqueue_img_auto_sizes_contain_css_fix() {
	mut var_priority := rt.new_null()
	mut var_add_auto_sizes := rt.new_null()
	mut var_handle := ''
	var_priority = rt.call_function('has_action', [rt.new_string('wp_head'),
		rt.new_string('wp_print_auto_sizes_contain_css_fix')])
	if rt.is_true(rt.identical(rt.new_bool(false), var_priority)) {
		return
	}
	rt.call_function('remove_action', [rt.new_string('wp_head'),
		rt.new_string('wp_print_auto_sizes_contain_css_fix'),
		var_priority.clone()])
	var_add_auto_sizes = rt.call_function('apply_filters', [
		rt.new_string('wp_img_tag_add_auto_sizes'),
		rt.new_bool(true),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_add_auto_sizes)))) {
		return
	}
	var_handle = 'wp-img-auto-sizes-contain'
	rt.call_function('wp_register_style', [rt.new_string(var_handle.str()).clone(),
		rt.new_bool(false)])
	rt.call_function('wp_add_inline_style', [rt.new_string(var_handle.str()).clone(),
		rt.new_string('img:is([sizes=auto i],[sizes^="auto," i]){contain-intrinsic-size:3000px 1500px}')])
	rt.call_function('array_unshift', [
		rt.get_property(rt.call_function('wp_styles', []rt.PhpVal{}), 'queue'),
		rt.new_string(var_handle.str()).clone(),
	])
}

fn wp_img_tag_add_loading_optimization_attrs(var_image_arg rt.PhpVal, var_context rt.PhpVal) rt.PhpVal {
	mut var_image := var_image_arg
	mut var_matche_src := rt.new_null()
	mut var_match_width := rt.new_null()
	mut var_match_height := rt.new_null()
	mut var_match_loading := rt.new_null()
	mut var_match_fetchpriority := rt.new_null()
	mut var_match_decoding := rt.new_null()
	mut var_src := rt.new_null()
	mut var_width := rt.new_null()
	mut var_height := rt.new_null()
	mut var_loading_val := rt.new_null()
	mut var_fetchpriority_val := rt.new_null()
	mut var_decoding_val := rt.new_null()
	mut var_optimization_attrs := rt.new_null()
	mut var_filtered_decoding_attr := rt.new_null()
	mut var_loading_attrs_enabled := false
	mut var_filtered_loading_attr := rt.new_null()
	var_src = if rt.is_true(rt.call_function('preg_match', [
		rt.new_string('/ src=["\']?([^"\']*)/i'),
		var_image.clone(),
		var_matche_src.clone(),
	]))
	{ var_matche_src.array_get(rt.new_int(1)) } else { rt.new_null() }
	var_width = if rt.is_true(rt.call_function('preg_match', [
		rt.new_string('/ width=["\']([0-9]+)["\']/'),
		var_image.clone(),
		var_match_width.clone(),
	]))
	{ rt.new_int((var_match_width.array_get(rt.new_int(1))).to_i64()) } else { rt.new_null() }
	var_height = if rt.is_true(rt.call_function('preg_match', [
		rt.new_string('/ height=["\']([0-9]+)["\']/'),
		var_image.clone(),
		var_match_height.clone(),
	]))
	{ rt.new_int((var_match_height.array_get(rt.new_int(1))).to_i64()) } else { rt.new_null() }
	var_loading_val = if rt.is_true(rt.call_function('preg_match', [
		rt.new_string('/ loading=["\']([A-Za-z]+)["\']/'),
		var_image.clone(),
		var_match_loading.clone(),
	]))
	{ var_match_loading.array_get(rt.new_int(1)) } else { rt.new_null() }
	var_fetchpriority_val = if rt.is_true(rt.call_function('preg_match', [
		rt.new_string('/ fetchpriority=["\']([A-Za-z]+)["\']/'),
		var_image.clone(),
		var_match_fetchpriority.clone(),
	]))
	{ var_match_fetchpriority.array_get(rt.new_int(1)) } else { rt.new_null() }
	var_decoding_val = if rt.is_true(rt.call_function('preg_match', [
		rt.new_string('/ decoding=["\']([A-Za-z]+)["\']/'),
		var_image.clone(),
		var_match_decoding.clone(),
	]))
	{ var_match_decoding.array_get(rt.new_int(1)) } else { rt.new_null() }
	var_optimization_attrs = wp_get_loading_optimization_attributes('img', rt.create_array([
		rt.ArrayItem{ key: 'src', val: var_src },
		rt.ArrayItem{ key: 'width', val: var_width },
		rt.ArrayItem{ key: 'height', val: var_height },
		rt.ArrayItem{ key: 'loading', val: var_loading_val },
		rt.ArrayItem{ key: 'fetchpriority', val: var_fetchpriority_val },
		rt.ArrayItem{ key: 'decoding', val: var_decoding_val },
	]), var_context.clone())
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('str_contains', [
		var_image.clone(), rt.new_string(' src="')])))))
	{
		return var_image.clone()
	}
	if !rt.is_true(var_decoding_val) {
		var_filtered_decoding_attr = rt.call_function('apply_filters', [
			rt.new_string('wp_img_tag_add_decoding_attr'),
			if !(var_optimization_attrs.array_get(rt.new_string('decoding'))).is_null() {
				var_optimization_attrs.array_get(rt.new_string('decoding'))
			} else {
				rt.new_bool(false)
			},
			var_image.clone(),
			var_context.clone(),
		])
		if var_optimization_attrs.array_isset(rt.new_string('decoding'))
			&& rt.is_true(rt.new_bool(!(rt.is_true(var_filtered_decoding_attr)))) {
			var_optimization_attrs.array_unset(rt.new_string('decoding'))
		} else if rt.is_true(rt.call_function('in_array', [var_filtered_decoding_attr.clone(),
			rt.create_array([rt.ArrayItem{ key: none, val: 'async' },
				rt.ArrayItem{ key: none, val: 'sync' }, rt.ArrayItem{ key: none, val: 'auto' }]),
			rt.new_bool(true)]))
		{
			var_optimization_attrs.array_set('decoding', var_filtered_decoding_attr.clone())
		}
		if !(!rt.is_true(var_optimization_attrs.array_get(rt.new_string('decoding')))) {
			var_image = rt.call_function('str_replace', [rt.new_string('<img'),
				rt.new_string('<img decoding="' +
					(rt.call_function('esc_attr', [var_optimization_attrs.array_get(rt.new_string('decoding'))])).str() +
					'"'),
				var_image.clone()])
		}
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('str_contains', [var_image.clone(), rt.new_string(' width="')])))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('str_contains', [var_image.clone(), rt.new_string(' height="')]))))) {
		return var_image.clone()
	}
	var_loading_attrs_enabled = wp_lazy_loading_enabled('img', var_context.clone())
	if !rt.is_true(var_loading_val) && var_loading_attrs_enabled {
		var_filtered_loading_attr = rt.call_function('apply_filters', [
			rt.new_string('wp_img_tag_add_loading_attr'),
			if !(var_optimization_attrs.array_get(rt.new_string('loading'))).is_null() {
				var_optimization_attrs.array_get(rt.new_string('loading'))
			} else {
				rt.new_bool(false)
			},
			var_image.clone(),
			var_context.clone(),
		])
		if var_optimization_attrs.array_isset(rt.new_string('loading'))
			&& rt.is_true(rt.new_bool(!(rt.is_true(var_filtered_loading_attr)))) {
			var_optimization_attrs.array_unset(rt.new_string('loading'))
		} else if rt.is_true(rt.call_function('in_array', [var_filtered_loading_attr.clone(),
			rt.create_array([rt.ArrayItem{ key: none, val: 'lazy' },
				rt.ArrayItem{ key: none, val: 'eager' }]),
			rt.new_bool(true)]))
		{
			if var_optimization_attrs.array_isset(rt.new_string('fetchpriority'))
				&& rt.is_true(rt.identical(rt.new_string('high'), var_optimization_attrs.array_get(rt.new_string('fetchpriority'))))
				&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(if !(var_optimization_attrs.array_get(rt.new_string('loading'))).is_null() { var_optimization_attrs.array_get(rt.new_string('loading')) } else { rt.new_bool(false) }, var_filtered_loading_attr))))
				&& rt.is_true(rt.identical(rt.new_string('lazy'), var_filtered_loading_attr)) {
				rt.call_function('_doing_it_wrong', [rt.new_string(@FN),
					rt.call_function('__', [
						rt.new_string('An image should not be lazy-loaded and marked as high priority at the same time.'),
					]),
					rt.new_string('6.3.0')])
			}
			var_optimization_attrs.array_set('loading', var_filtered_loading_attr.clone())
		}
		if !(!rt.is_true(var_optimization_attrs.array_get(rt.new_string('loading')))) {
			var_image = rt.call_function('str_replace', [rt.new_string('<img'),
				rt.new_string('<img loading="' +
					(rt.call_function('esc_attr', [var_optimization_attrs.array_get(rt.new_string('loading'))])).str() +
					'"'),
				var_image.clone()])
		}
	}
	if !rt.is_true(var_fetchpriority_val)
		&& !(!rt.is_true(var_optimization_attrs.array_get(rt.new_string('fetchpriority')))) {
		var_image = rt.call_function('str_replace', [rt.new_string('<img'),
			rt.new_string('<img fetchpriority="' +
				(rt.call_function('esc_attr', [var_optimization_attrs.array_get(rt.new_string('fetchpriority'))])).str() +
				'"'),
			var_image.clone()])
	}
	return var_image.clone()
}

fn wp_img_tag_add_width_and_height_attr(var_image rt.PhpVal, var_context rt.PhpVal, var_attachment_id rt.PhpVal) rt.PhpVal {
	mut var_match_src := rt.new_null()
	mut var_match_width := rt.new_null()
	mut var_image_src := rt.new_null()
	mut var_add := rt.new_null()
	mut var_image_meta := rt.new_null()
	mut var_size_array := rt.new_null()
	mut var_style_width := rt.new_null()
	mut var_hw := ''
	var_image_src = if rt.is_true(rt.call_function('preg_match', [
		rt.new_string('/src="([^"]+)"/'),
		var_image.clone(),
		var_match_src.clone(),
	]))
	{ var_match_src.array_get(rt.new_int(1)) } else { rt.new_string('') }
	mut list_tmp_14 := rt.call_function('explode', [rt.new_string('?'),
		var_image_src.clone()])
	var_image_src = list_tmp_14.array_get(0)
	if rt.is_true(rt.new_bool(!(rt.is_true(var_image_src)))) {
		return var_image.clone()
	}
	var_add = rt.call_function('apply_filters', [
		rt.new_string('wp_img_tag_add_width_and_height_attr'),
		rt.new_bool(true),
		var_image.clone(),
		var_context.clone(),
		var_attachment_id.clone(),
	])
	if rt.is_true(rt.identical(rt.new_bool(true), var_add)) {
		var_image_meta = rt.call_function('wp_get_attachment_metadata', [
			var_attachment_id.clone()])
		var_size_array = wp_image_src_get_dimensions(var_image_src.clone(), var_image_meta.clone(),
			var_attachment_id.clone())
		if rt.is_true(var_size_array) && rt.is_true(var_size_array.array_get(rt.new_int(0)))
			&& rt.is_true(var_size_array.array_get(rt.new_int(1))) {
			var_style_width = rt.new_int(if rt.is_true(rt.call_function('preg_match', [
				rt.new_string('/style="width:\\s*(\\d+)px;"/'),
				var_image.clone(),
				var_match_width.clone(),
			]))
			{ rt.new_int((var_match_width.array_get(rt.new_int(1))).to_i64()) } else { 0 })
			if rt.is_true(var_style_width) {
				var_size_array.array_set(1, rt.new_int((rt.call_function('round', [
					rt.div(rt.mul(var_size_array.array_get(rt.new_int(1)), var_style_width),
						var_size_array.array_get(rt.new_int(0))),
				])).to_i64()))
				var_size_array.array_set(0, var_style_width.clone())
			}
			var_hw = image_hwstring(var_size_array.array_get(rt.new_int(0)),
				var_size_array.array_get(rt.new_int(1))).trim_space()
			return rt.call_function('str_replace', [rt.new_string('<img'),
				rt.new_string('<img ${var_hw}'), var_image.clone()])
		}
	}
	return var_image.clone()
}

fn wp_img_tag_add_srcset_and_sizes_attr(var_image rt.PhpVal, var_context rt.PhpVal, var_attachment_id rt.PhpVal) rt.PhpVal {
	mut var_add := rt.new_null()
	mut var_image_meta := rt.new_null()
	var_add = rt.call_function('apply_filters', [
		rt.new_string('wp_img_tag_add_srcset_and_sizes_attr'),
		rt.new_bool(true),
		var_image.clone(),
		var_context.clone(),
		var_attachment_id.clone(),
	])
	if rt.is_true(rt.identical(rt.new_bool(true), var_add)) {
		var_image_meta = rt.call_function('wp_get_attachment_metadata', [
			var_attachment_id.clone()])
		return wp_image_add_srcset_and_sizes(var_image.clone(), var_image_meta.clone(),
			var_attachment_id.clone())
	}
	return var_image.clone()
}

fn wp_iframe_tag_add_loading_attr(var_iframe rt.PhpVal, var_context rt.PhpVal) rt.PhpVal {
	mut var_optimization_attrs := rt.new_null()
	mut var_value := rt.new_null()
	var_optimization_attrs = wp_get_loading_optimization_attributes('iframe', rt.create_array([
		rt.ArrayItem{
			key: 'width'
			val: if rt.is_true(rt.call_function('str_contains', [
				var_iframe.clone(),
				rt.new_string(' width="'),
			]))
			{ rt.new_int(100) } else { rt.new_null() }
		},
		rt.ArrayItem{
			key: 'height'
			val: if rt.is_true(rt.call_function('str_contains', [
				var_iframe.clone(),
				rt.new_string(' height="'),
			]))
			{ rt.new_int(100) } else { rt.new_null() }
		},
		rt.ArrayItem{ key: 'loading', val: rt.new_null() },
	]), var_context.clone())
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('str_contains', [var_iframe.clone(), rt.new_string(' src="')])))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('str_contains', [var_iframe.clone(), rt.new_string(' width="')])))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('str_contains', [var_iframe.clone(), rt.new_string(' height="')]))))) {
		return var_iframe.clone()
	}
	var_value = if !(var_optimization_attrs.array_get(rt.new_string('loading'))).is_null() {
		var_optimization_attrs.array_get(rt.new_string('loading'))
	} else {
		rt.new_bool(false)
	}
	var_value = rt.call_function('apply_filters', [
		rt.new_string('wp_iframe_tag_add_loading_attr'),
		var_value.clone(),
		var_iframe.clone(),
		var_context.clone(),
	])
	if rt.is_true(var_value) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
			var_value.clone(),
			rt.create_array([rt.ArrayItem{ key: none, val: 'lazy' },
				rt.ArrayItem{ key: none, val: 'eager' }]),
			rt.new_bool(true)])))))
		{
			var_value = rt.new_string('lazy')
		}
		return rt.call_function('str_replace', [rt.new_string('<iframe'),
			rt.new_string('<iframe loading="' +
				(rt.call_function('esc_attr', [var_value.clone()])).str() + '"'),
			var_iframe.clone()])
	}
	return var_iframe.clone()
}

fn _wp_post_thumbnail_class_filter(var_attr rt.PhpVal) rt.PhpVal {
	var_attr.array_get(rt.new_string('class')) = rt.concat(var_attr.array_get(rt.new_string('class')),
		rt.new_string(' wp-post-image'))
	return var_attr.clone()
}

fn _wp_post_thumbnail_class_filter_add(var_attr rt.PhpVal) {
	rt.call_function('add_filter', [rt.new_string('wp_get_attachment_image_attributes'),
		rt.new_string('_wp_post_thumbnail_class_filter')])
}

fn _wp_post_thumbnail_class_filter_remove(var_attr rt.PhpVal) {
	rt.call_function('remove_filter', [
		rt.new_string('wp_get_attachment_image_attributes'),
		rt.new_string('_wp_post_thumbnail_class_filter'),
	])
}

fn _wp_post_thumbnail_context_filter(var_context rt.PhpVal) string {
	return 'the_post_thumbnail'
}

fn _wp_post_thumbnail_context_filter_add() {
	rt.call_function('add_filter', [rt.new_string('wp_get_attachment_image_context'),
		rt.new_string('_wp_post_thumbnail_context_filter')])
}

fn _wp_post_thumbnail_context_filter_remove() {
	rt.call_function('remove_filter', [rt.new_string('wp_get_attachment_image_context'),
		rt.new_string('_wp_post_thumbnail_context_filter')])
}

fn img_caption_shortcode(var_attr rt.PhpVal, content string) rt.PhpVal {
	mut var_content := content
	mut var_matches := []rt.PhpVal{}
	mut var_output := rt.new_null()
	mut var_atts := rt.new_null()
	mut var_id := rt.new_null()
	mut var_caption_id := rt.new_null()
	mut var_describedby := rt.new_null()
	mut var_class := ''
	mut var_html5 := rt.new_null()
	mut var_width := rt.new_null()
	mut var_caption_width := rt.new_null()
	mut var_style := rt.new_null()
	mut var_html := rt.new_null()
	if !(var_attr.array_isset(rt.new_string('caption'))) {
		if rt.is_true(rt.call_function('preg_match', [
			rt.new_string('#((?:<a [^>]+>\\s*)?<img [^>]+>(?:\\s*</a>)?)(.*)#is'),
			rt.new_string(var_content.str()),
			rt.create_array_from_list(var_matches),
		]))
		{
			var_content = (var_matches[1]).str()
			var_attr.array_set('caption', var_matches[2].to_string().trim_space())
		}
	} else if rt.is_true(rt.call_function('str_contains', [
		var_attr.array_get(rt.new_string('caption')),
		rt.new_string('<'),
	]))
	{
		var_attr.array_set('caption', rt.call_function('wp_kses', [
			var_attr.array_get(rt.new_string('caption')),
			rt.new_string('post'),
		]))
	}
	var_output = rt.call_function('apply_filters', [
		rt.new_string('img_caption_shortcode'),
		rt.new_string(''),
		var_attr.clone(),
		rt.new_string(var_content.str()),
	])
	if !(!rt.is_true(var_output)) {
		return var_output.clone()
	}
	var_atts = rt.call_function('shortcode_atts', [
		rt.create_array([rt.ArrayItem{ key: 'id', val: '' }, rt.ArrayItem{
			key: 'caption_id'
			val: ''
		}, rt.ArrayItem{ key: 'align', val: 'alignnone' }, rt.ArrayItem{ key: 'width', val: '' },
			rt.ArrayItem{ key: 'caption', val: '' }, rt.ArrayItem{ key: 'class', val: '' }]),
		var_attr.clone(),
		rt.new_string('caption'),
	])
	var_atts.array_set('width', rt.new_int((var_atts.array_get(rt.new_string('width'))).to_i64()))
	if rt.is_true(rt.less(var_atts.array_get(rt.new_string('width')), rt.new_int(1)))
		|| !rt.is_true(var_atts.array_get(rt.new_string('caption'))) {
		return rt.new_string(var_content.str())
	}
	var_id = rt.new_string('')
	var_caption_id = rt.new_string('')
	var_describedby = rt.new_string('')
	if rt.is_true(var_atts.array_get(rt.new_string('id'))) {
		var_atts.array_set('id', rt.call_function('sanitize_html_class', [
			var_atts.array_get(rt.new_string('id')),
		]))
		var_id = rt.new_string('id="' +
			(rt.call_function('esc_attr', [var_atts.array_get(rt.new_string('id'))])).str() + '" ')
	}
	if rt.is_true(var_atts.array_get(rt.new_string('caption_id'))) {
		var_atts.array_set('caption_id', rt.call_function('sanitize_html_class', [
			var_atts.array_get(rt.new_string('caption_id')),
		]))
	} else if rt.is_true(var_atts.array_get(rt.new_string('id'))) {
		var_atts.array_set('caption_id',
			'caption-' +(rt.call_function('str_replace', [rt.new_string('_'), rt.new_string('-'), var_atts.array_get(rt.new_string('id'))])).str())
	}
	if rt.is_true(var_atts.array_get(rt.new_string('caption_id'))) {
		var_caption_id = rt.new_string('id="' +
			(rt.call_function('esc_attr', [var_atts.array_get(rt.new_string('caption_id'))])).str() +
			'" ')
		var_describedby = rt.new_string('aria-describedby="' +
			(rt.call_function('esc_attr', [var_atts.array_get(rt.new_string('caption_id'))])).str() +
			'" ')
	}
	var_class = 'wp-caption ' +(var_atts.array_get(rt.new_string('align'))).str() + ' ' +
		(var_atts.array_get(rt.new_string('class'))).str().trim_space()
	var_html5 = rt.call_function('current_theme_supports', [rt.new_string('html5'),
		rt.new_string('caption')])
	var_width = if rt.is_true(var_html5) {
		var_atts.array_get(rt.new_string('width'))
	} else {
		rt.add(rt.new_int(10), var_atts.array_get(rt.new_string('width')))
	}
	var_caption_width = rt.call_function('apply_filters', [
		rt.new_string('img_caption_shortcode_width'),
		var_width.clone(),
		var_atts.clone(),
		rt.new_string(var_content.str()),
	])
	var_style = rt.new_string('')
	if rt.is_true(var_caption_width) {
		var_style = rt.new_string('style="width: ' + rt.new_int(var_caption_width.to_i64()).str() +
			'px" ')
	}
	if rt.is_true(var_html5) {
		var_html = rt.call_function('sprintf', [
			rt.new_string('<figure %s%s%sclass="%s">%s%s</figure>'),
			var_id.clone(),
			var_describedby.clone(),
			var_style.clone(),
			rt.call_function('esc_attr', [rt.new_string(var_class.str()).clone()]),
			rt.call_function('do_shortcode', [rt.new_string(var_content.str())]),
			rt.call_function('sprintf', [
				rt.new_string('<figcaption %sclass="wp-caption-text">%s</figcaption>'),
				var_caption_id.clone(),
				var_atts.array_get(rt.new_string('caption')),
			]),
		])
	} else {
		var_html = rt.call_function('sprintf', [
			rt.new_string('<div %s%sclass="%s">%s%s</div>'),
			var_id.clone(),
			var_style.clone(),
			rt.call_function('esc_attr', [rt.new_string(var_class.str()).clone()]),
			rt.call_function('str_replace', [rt.new_string('<img '),
				rt.new_string('<img ' + var_describedby.str()),
				rt.call_function('do_shortcode', [rt.new_string(var_content.str())])]),
			rt.call_function('sprintf', [rt.new_string('<p %sclass="wp-caption-text">%s</p>'),
				var_caption_id.clone(), var_atts.array_get(rt.new_string('caption'))]),
		])
	}
	return var_html.clone()
}

fn gallery_shortcode(var_attr_arg rt.PhpVal) string {
	mut var_attr := var_attr_arg
	mut var_instance := rt.new_null()
	mut var_post := rt.new_null()
	mut var_output := rt.new_null()
	mut var_html5 := rt.new_null()
	mut var_atts := rt.new_null()
	mut var_id := rt.new_null()
	mut var__attachments := rt.new_null()
	mut var_attachments := rt.new_null()
	mut var_val := rt.new_null()
	mut var_key := rt.new_null()
	mut var_post_parent_id := rt.new_null()
	mut var_post_parent := rt.new_null()
	mut var_attachment := rt.new_null()
	mut var_att_id := rt.new_null()
	mut var_itemtag := rt.new_null()
	mut var_captiontag := rt.new_null()
	mut var_icontag := rt.new_null()
	mut var_valid_tags := rt.new_null()
	mut var_columns := rt.new_null()
	mut var_itemwidth := rt.new_null()
	mut var_float := ''
	mut var_selector := ''
	mut var_gallery_style := ''
	mut var_size_class := rt.new_null()
	mut var_gallery_div := ''
	mut var_i := i64(0)
	mut var_image_output := rt.new_null()
	mut var_image_meta := rt.new_null()
	mut var_orientation := ''
	var_post = rt.call_function('get_post', []rt.PhpVal{})
	rt.pre_inc(var_instance)
	if !(!rt.is_true(var_attr.array_get(rt.new_string('ids')))) {
		if !rt.is_true(var_attr.array_get(rt.new_string('orderby'))) {
			var_attr.array_set('orderby', 'post__in')
		}
		var_attr.array_set('include', var_attr.array_get(rt.new_string('ids')))
	}
	var_output = rt.call_function('apply_filters', [rt.new_string('post_gallery'),
		rt.new_string(''), var_attr.clone(), var_instance.clone()])
	if !(!rt.is_true(var_output)) {
		return var_output.str()
	}
	var_html5 = rt.call_function('current_theme_supports', [rt.new_string('html5'),
		rt.new_string('gallery')])
	var_atts = rt.call_function('shortcode_atts', [
		rt.create_array([rt.ArrayItem{ key: 'order', val: 'ASC' },
			rt.ArrayItem{ key: 'orderby', val: 'menu_order ID' },
			rt.ArrayItem{
				key: 'id'
				val: if rt.is_true(var_post) {
					rt.get_property(var_post, 'ID')
				} else {
					rt.new_int(0)
				}
			}, rt.ArrayItem{
				key: 'itemtag'
				val: if rt.is_true(var_html5) { 'figure' } else { 'dl' }
			}, rt.ArrayItem{
				key: 'icontag'
				val: if rt.is_true(var_html5) { 'div' } else { 'dt' }
			}, rt.ArrayItem{
				key: 'captiontag'
				val: if rt.is_true(var_html5) { 'figcaption' } else { 'dd' }
			}, rt.ArrayItem{ key: 'columns', val: 3 }, rt.ArrayItem{ key: 'size', val: 'thumbnail' },
			rt.ArrayItem{ key: 'include', val: '' }, rt.ArrayItem{ key: 'exclude', val: '' },
			rt.ArrayItem{ key: 'link', val: '' }]),
		var_attr.clone(),
		rt.new_string('gallery'),
	])
	var_id = rt.new_int((var_atts.array_get(rt.new_string('id'))).to_i64())
	if !(!rt.is_true(var_atts.array_get(rt.new_string('include')))) {
		var__attachments = rt.call_function('get_posts', [
			rt.create_array([
				rt.ArrayItem{ key: 'include', val: var_atts.array_get(rt.new_string('include')) },
				rt.ArrayItem{ key: 'post_status', val: 'inherit' },
				rt.ArrayItem{ key: 'post_type', val: 'attachment' },
				rt.ArrayItem{ key: 'post_mime_type', val: 'image' },
				rt.ArrayItem{ key: 'order', val: var_atts.array_get(rt.new_string('order')) },
				rt.ArrayItem{ key: 'orderby', val: var_atts.array_get(rt.new_string('orderby')) },
			]),
		])
		var_attachments = rt.new_array()
		mut iter_8 := var__attachments.iterator()
		for {
			item_8 := iter_8.next() or { break }
			mut var_val_shadow := item_8.val
			mut var_key_shadow := item_8.key
			var_attachments.array_set(rt.get_property(var_val_shadow, 'ID'),
				var__attachments.array_get(var_key_shadow))
		}
	} else if !(!rt.is_true(var_atts.array_get(rt.new_string('exclude')))) {
		var_post_parent_id = var_id.clone()
		var_attachments = rt.call_function('get_children', [
			rt.create_array([rt.ArrayItem{ key: 'post_parent', val: var_id },
				rt.ArrayItem{ key: 'exclude', val: var_atts.array_get(rt.new_string('exclude')) },
				rt.ArrayItem{ key: 'post_status', val: 'inherit' },
				rt.ArrayItem{ key: 'post_type', val: 'attachment' },
				rt.ArrayItem{ key: 'post_mime_type', val: 'image' },
				rt.ArrayItem{ key: 'order', val: var_atts.array_get(rt.new_string('order')) },
				rt.ArrayItem{ key: 'orderby', val: var_atts.array_get(rt.new_string('orderby')) }]),
		])
	} else {
		var_post_parent_id = var_id.clone()
		var_attachments = rt.call_function('get_children', [
			rt.create_array([rt.ArrayItem{ key: 'post_parent', val: var_id },
				rt.ArrayItem{ key: 'post_status', val: 'inherit' },
				rt.ArrayItem{ key: 'post_type', val: 'attachment' },
				rt.ArrayItem{ key: 'post_mime_type', val: 'image' },
				rt.ArrayItem{ key: 'order', val: var_atts.array_get(rt.new_string('order')) },
				rt.ArrayItem{ key: 'orderby', val: var_atts.array_get(rt.new_string('orderby')) }]),
		])
	}
	if !(!rt.is_true(var_post_parent_id)) {
		var_post_parent = rt.call_function('get_post', [var_post_parent_id.clone()])
		if (rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_post_publicly_viewable', [rt.get_property(var_post_parent, 'ID')])))))
			&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('read_post'), rt.get_property(var_post_parent, 'ID')]))))))
			|| rt.is_true(rt.call_function('post_password_required', [var_post_parent.clone()])) {
			return ''
		}
	}
	if !rt.is_true(var_attachments) {
		return ''
	}
	if rt.is_true(rt.call_function('is_feed', []rt.PhpVal{})) {
		var_output = rt.new_string('\n')
		mut iter_9 := var_attachments.iterator()
		for {
			item_9 := iter_9.next() or { break }
			mut var_attachment_shadow := item_9.val
			mut var_att_id_shadow := item_9.key
			if !(!rt.is_true(var_atts.array_get(rt.new_string('link')))) {
				if rt.is_true(rt.identical(rt.new_string('none'),
					var_atts.array_get(rt.new_string('link'))))
				{
					var_output = rt.concat(var_output, wp_get_attachment_image(var_att_id_shadow.clone(),
						var_atts.array_get(rt.new_string('size')), false, var_attr.clone()))
				} else {
					var_output = rt.concat(var_output, rt.call_function('wp_get_attachment_link', [
						var_att_id_shadow.clone(),
						var_atts.array_get(rt.new_string('size')),
						rt.new_bool(false),
					]))
				}
			} else {
				var_output = rt.concat(var_output, rt.call_function('wp_get_attachment_link', [
					var_att_id_shadow.clone(),
					var_atts.array_get(rt.new_string('size')),
					rt.new_bool(true),
				]))
			}
			var_output = rt.concat(var_output, rt.new_string('\n'))
		}
		return var_output.str()
	}
	var_itemtag = rt.call_function('tag_escape', [var_atts.array_get(rt.new_string('itemtag'))])
	var_captiontag = rt.call_function('tag_escape', [
		var_atts.array_get(rt.new_string('captiontag')),
	])
	var_icontag = rt.call_function('tag_escape', [var_atts.array_get(rt.new_string('icontag'))])
	var_valid_tags = rt.call_function('wp_kses_allowed_html', [
		rt.new_string('post')])
	if !(var_valid_tags.array_isset(var_itemtag)) {
		var_itemtag = rt.new_string('dl')
	}
	if !(var_valid_tags.array_isset(var_captiontag)) {
		var_captiontag = rt.new_string('dd')
	}
	if !(var_valid_tags.array_isset(var_icontag)) {
		var_icontag = rt.new_string('dt')
	}
	var_columns = rt.new_int((var_atts.array_get(rt.new_string('columns'))).to_i64())
	var_itemwidth = if rt.is_true(rt.greater(var_columns, rt.new_int(0))) { rt.call_function('floor', [
			rt.div(rt.new_int(100), var_columns),
		]) } else { rt.new_int(100) }
	var_float = if rt.is_true(rt.call_function('is_rtl', []rt.PhpVal{})) { 'right' } else { 'left' }
	var_selector = 'gallery-${var_instance.to_string()}'
	var_gallery_style = ''
	if rt.is_true(rt.call_function('apply_filters', [
		rt.new_string('use_default_gallery_style'),
		rt.new_bool(!(rt.is_true(var_html5))),
	]))
	{
		var_gallery_style = '\n\t\t<style>\n\t\t\t#${var_selector} {\n\t\t\t\tmargin: auto;\n\t\t\t}\n\t\t\t#${var_selector} .gallery-item {\n\t\t\t\tfloat: ${var_float};\n\t\t\t\tmargin-top: 10px;\n\t\t\t\ttext-align: center;\n\t\t\t\twidth: ${var_itemwidth.to_string()}%;\n\t\t\t}\n\t\t\t#${var_selector} img {\n\t\t\t\tborder: 2px solid #cfcfcf;\n\t\t\t}\n\t\t\t#${var_selector} .gallery-caption {\n\t\t\t\tmargin-left: 0;\n\t\t\t}\n\t\t\t/* see gallery_shortcode() in wp-includes/media.php */\n\t\t</style>\n\t\t'
	}
	var_size_class = rt.call_function('sanitize_html_class', [if var_atts.array_get(rt.new_string('size')).is_array() { rt.call_function('implode', [
			rt.new_string('x'),
			var_atts.array_get(rt.new_string('size')),
		]) } else { var_atts.array_get(rt.new_string('size')) }])
	var_gallery_div = "<div id='${var_selector}' class='gallery galleryid-${var_id.to_string()} gallery-columns-${var_columns.to_string()} gallery-size-${var_size_class.to_string()}'>"
	var_output = rt.call_function('apply_filters', [rt.new_string('gallery_style'),
		rt.new_string(var_gallery_style + var_gallery_div)])
	var_i = 0
	mut iter_10 := var_attachments.iterator()
	for {
		item_10 := iter_10.next() or { break }
		mut var_attachment_shadow := item_10.val
		mut var_id_shadow := item_10.key
		var_attr = if rt.is_true(rt.new_string(rt.get_property(var_attachment_shadow, 'post_excerpt').to_string().trim_space())) { rt.create_array([
				rt.ArrayItem{ key: 'aria-describedby', val: '${var_selector}-${var_id.to_string()}' },
			]) } else { rt.new_string('') }
		if !(!rt.is_true(var_atts.array_get(rt.new_string('link'))))
			&& rt.is_true(rt.identical(rt.new_string('file'), var_atts.array_get(rt.new_string('link')))) {
			var_image_output = rt.call_function('wp_get_attachment_link', [
				var_id_shadow.clone(), var_atts.array_get(rt.new_string('size')),
				rt.new_bool(false), rt.new_bool(false), rt.new_bool(false),
				var_attr.clone()])
		} else if !(!rt.is_true(var_atts.array_get(rt.new_string('link'))))
			&& rt.is_true(rt.identical(rt.new_string('none'), var_atts.array_get(rt.new_string('link')))) {
			var_image_output = wp_get_attachment_image(var_id_shadow.clone(),
				var_atts.array_get(rt.new_string('size')), false, var_attr.clone())
		} else {
			var_image_output = rt.call_function('wp_get_attachment_link', [
				var_id_shadow.clone(), var_atts.array_get(rt.new_string('size')),
				rt.new_bool(true), rt.new_bool(false), rt.new_bool(false),
				var_attr.clone()])
		}
		var_image_meta = rt.call_function('wp_get_attachment_metadata', [
			var_id_shadow.clone()])
		var_orientation = ''
		if var_image_meta.array_isset(rt.new_string('height'))
			&& var_image_meta.array_isset(rt.new_string('width')) {
			var_orientation = if rt.is_true(rt.greater(var_image_meta.array_get(rt.new_string('height')),
				var_image_meta.array_get(rt.new_string('width'))))
			{
				'portrait'
			} else {
				'landscape'
			}
		}
		var_output = rt.concat(var_output,
			rt.new_string("<${var_itemtag.to_string()} class='gallery-item'>"))
		var_output = rt.concat(var_output,
			rt.new_string("\n\t\t\t<${var_icontag.to_string()} class='gallery-icon ${var_orientation}'>\n\t\t\t\t${var_image_output.to_string()}\n\t\t\t</${var_icontag.to_string()}>"))
		if rt.is_true(var_captiontag)
			&& rt.is_true(rt.new_string(rt.get_property(var_attachment_shadow, 'post_excerpt').to_string().trim_space())) {
			var_output = rt.concat(var_output, rt.new_string(
				"\n\t\t\t\t<${var_captiontag.to_string()} class='wp-caption-text gallery-caption' id='${var_selector}-${var_id.to_string()}'>\n\t\t\t\t" +
				(rt.call_function('wptexturize', [rt.get_property(var_attachment_shadow, 'post_excerpt')])).str() +
				'\n\t\t\t\t</${var_captiontag.to_string()}>'))
		}
		var_output = rt.concat(var_output, rt.new_string('</${var_itemtag.to_string()}>'))
		if rt.is_true(rt.new_bool(!(rt.is_true(var_html5))))
			&& rt.is_true(rt.greater(var_columns, rt.new_int(0)))
			&& rt.is_true(rt.identical(rt.new_int(0), rt.mod_(rt.pre_inc(rt.new_int(var_i)), var_columns))) {
			var_output = rt.concat(var_output, rt.new_string('<br style="clear: both" />'))
		}
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_html5))))
		&& rt.is_true(rt.greater(var_columns, rt.new_int(0)))
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int(0), rt.mod_(rt.new_int(var_i), var_columns))))) {
		var_output = rt.concat(var_output, rt.new_string("\n\t\t\t<br style='clear: both' />"))
	}
	var_output = rt.concat(var_output, rt.new_string('\n\t\t</div>\n'))
	return var_output.str()
}

fn wp_underscore_playlist_templates() {
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('printf', [
		rt.call_function('_x', [rt.new_string('&#8220;%s&#8221;'),
			rt.new_string('playlist item title')]),
		rt.new_string('{{ data.title }}'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('printf', [
		rt.call_function('_x', [rt.new_string('&#8220;%s&#8221;'),
			rt.new_string('playlist item title')]),
		rt.new_string('{{{ data.title }}}'),
	])
	// unsupported statement: Stmt_InlineHTML
}

fn wp_playlist_scripts(var_type rt.PhpVal) {
	rt.call_function('wp_enqueue_style', [rt.new_string('wp-mediaelement')])
	rt.call_function('wp_enqueue_script', [rt.new_string('wp-playlist')])
	rt.call_function('add_action', [rt.new_string('wp_footer'),
		rt.new_string('wp_underscore_playlist_templates'), rt.new_int(0)])
	rt.call_function('add_action', [rt.new_string('admin_footer'),
		rt.new_string('wp_underscore_playlist_templates'), rt.new_int(0)])
}

fn wp_playlist_shortcode(var_attr rt.PhpVal) string {
	mut var_content_width := rt.new_null()
	mut var_instance := rt.new_null()
	mut var_post := rt.new_null()
	mut var_output := rt.new_null()
	mut var_atts := rt.new_null()
	mut var_id := rt.new_null()
	mut var_args := rt.new_null()
	mut var__attachments := rt.new_null()
	mut var_attachments := rt.new_null()
	mut var_val := rt.new_null()
	mut var_key := rt.new_null()
	mut var_post_parent := rt.new_null()
	mut var_attachment := rt.new_null()
	mut var_att_id := rt.new_null()
	mut var_outer := i64(0)
	mut var_default_width := i64(0)
	mut var_default_height := i64(0)
	mut var_theme_width := rt.new_null()
	mut var_theme_height := rt.new_null()
	mut var_data := rt.new_null()
	mut var_tracks := []rt.PhpVal{}
	mut var_url := rt.new_null()
	mut var_ftype := rt.new_null()
	mut var_track := map[string]rt.PhpVal{}
	mut var_meta := rt.new_null()
	mut var_label := rt.new_null()
	mut var_width := rt.new_null()
	mut var_height := rt.new_null()
	mut var_thumb_id := rt.new_null()
	mut var_src := rt.new_null()
	mut var_safe_type := rt.new_null()
	mut var_safe_style := rt.new_null()
	mut var_is_loaded := false
	var_post = rt.call_function('get_post', []rt.PhpVal{})
	rt.pre_inc(var_instance)
	if !(!rt.is_true(var_attr.array_get(rt.new_string('ids')))) {
		if !rt.is_true(var_attr.array_get(rt.new_string('orderby'))) {
			var_attr.array_set('orderby', 'post__in')
		}
		var_attr.array_set('include', var_attr.array_get(rt.new_string('ids')))
	}
	var_output = rt.call_function('apply_filters', [rt.new_string('post_playlist'),
		rt.new_string(''), var_attr.clone(), var_instance.clone()])
	if !(!rt.is_true(var_output)) {
		return var_output.str()
	}
	var_atts = rt.call_function('shortcode_atts', [
		rt.create_array([rt.ArrayItem{ key: 'type', val: 'audio' },
			rt.ArrayItem{ key: 'order', val: 'ASC' }, rt.ArrayItem{
				key: 'orderby'
				val: 'menu_order ID'
			}, rt.ArrayItem{
				key: 'id'
				val: if rt.is_true(var_post) {
					rt.get_property(var_post, 'ID')
				} else {
					rt.new_int(0)
				}
			}, rt.ArrayItem{ key: 'include', val: '' }, rt.ArrayItem{ key: 'exclude', val: '' },
			rt.ArrayItem{ key: 'style', val: 'light' }, rt.ArrayItem{ key: 'tracklist', val: true },
			rt.ArrayItem{ key: 'tracknumbers', val: true }, rt.ArrayItem{ key: 'images', val: true },
			rt.ArrayItem{ key: 'artists', val: true }]),
		var_attr.clone(),
		rt.new_string('playlist'),
	])
	var_id = rt.new_int((var_atts.array_get(rt.new_string('id'))).to_i64())
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('audio'),
		var_atts.array_get(rt.new_string('type'))))))
	{
		var_atts.array_set('type', 'video')
	}
	var_args = rt.create_array([rt.ArrayItem{ key: 'post_status', val: 'inherit' },
		rt.ArrayItem{ key: 'post_type', val: 'attachment' }, rt.ArrayItem{
			key: 'post_mime_type'
			val: var_atts.array_get(rt.new_string('type'))
		}, rt.ArrayItem{ key: 'order', val: var_atts.array_get(rt.new_string('order')) },
		rt.ArrayItem{ key: 'orderby', val: var_atts.array_get(rt.new_string('orderby')) }])
	if !(!rt.is_true(var_atts.array_get(rt.new_string('include')))) {
		var_args.array_set('include', var_atts.array_get(rt.new_string('include')))
		var__attachments = rt.call_function('get_posts', [var_args.clone()])
		var_attachments = rt.new_array()
		mut iter_11 := var__attachments.iterator()
		for {
			item_11 := iter_11.next() or { break }
			mut var_val_shadow := item_11.val
			mut var_key_shadow := item_11.key
			var_attachments.array_set(rt.get_property(var_val_shadow, 'ID'),
				var__attachments.array_get(var_key_shadow))
		}
	} else if !(!rt.is_true(var_atts.array_get(rt.new_string('exclude')))) {
		var_args.array_set('post_parent', var_id.clone())
		var_args.array_set('exclude', var_atts.array_get(rt.new_string('exclude')))
		var_attachments = rt.call_function('get_children', [var_args.clone()])
	} else {
		var_args.array_set('post_parent', var_id.clone())
		var_attachments = rt.call_function('get_children', [var_args.clone()])
	}
	if !(!rt.is_true(var_args.array_get(rt.new_string('post_parent')))) {
		var_post_parent = rt.call_function('get_post', [var_id.clone()])
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('read_post'), rt.get_property(var_post_parent, 'ID')])))))
			|| rt.is_true(rt.call_function('post_password_required', [var_post_parent.clone()])) {
			return ''
		}
	}
	if !rt.is_true(var_attachments) {
		return ''
	}
	if rt.is_true(rt.call_function('is_feed', []rt.PhpVal{})) {
		var_output = rt.new_string('\n')
		mut iter_12 := var_attachments.iterator()
		for {
			item_12 := iter_12.next() or { break }
			mut var_attachment_shadow := item_12.val
			mut var_att_id_shadow := item_12.key
			var_output = rt.concat(var_output, rt.new_string(
				(rt.call_function('wp_get_attachment_link', [var_att_id_shadow.clone()])).str() +
				'\n'))
		}
		return var_output.str()
	}
	var_outer = 22
	var_default_width = 640
	var_default_height = 360
	var_theme_width = if !rt.is_true(var_content_width) {
		rt.new_int(var_default_width)
	} else {
		rt.sub(var_content_width, rt.new_int(var_outer))
	}
	var_theme_height = if !rt.is_true(var_content_width) { rt.new_int(var_default_height) } else { rt.call_function('round', [
			rt.div(rt.mul(rt.new_int(var_default_height), var_theme_width), rt.new_int(var_default_width)),
		]) }
	var_data = rt.create_array([
		rt.ArrayItem{ key: 'type', val: var_atts.array_get(rt.new_string('type')) },
		rt.ArrayItem{ key: 'tracklist', val: rt.call_function('wp_validate_boolean', [
			var_atts.array_get(rt.new_string('tracklist')),
		]) },
		rt.ArrayItem{ key: 'tracknumbers', val: rt.call_function('wp_validate_boolean', [
			var_atts.array_get(rt.new_string('tracknumbers')),
		]) },
		rt.ArrayItem{ key: 'images', val: rt.call_function('wp_validate_boolean', [
			var_atts.array_get(rt.new_string('images')),
		]) },
		rt.ArrayItem{ key: 'artists', val: rt.call_function('wp_validate_boolean', [
			var_atts.array_get(rt.new_string('artists')),
		]) },
	])
	var_tracks = rt.new_array()
	mut iter_13 := var_attachments.iterator()
	for {
		item_13 := iter_13.next() or { break }
		mut var_attachment_shadow := item_13.val
		var_url = rt.call_function('wp_get_attachment_url', [
			rt.get_property(var_attachment_shadow, 'ID'),
		])
		var_ftype = rt.call_function('wp_check_filetype', [var_url.clone(),
			rt.call_function('wp_get_mime_types', []rt.PhpVal{})])
		var_track = {
			'src':         var_url
			'type':        var_ftype.array_get(rt.new_string('type'))
			'title':       rt.get_property(var_attachment_shadow, 'post_title')
			'caption':     rt.get_property(var_attachment_shadow, 'post_excerpt')
			'description': rt.get_property(var_attachment_shadow, 'post_content')
		}
		var_track['meta'] = rt.new_array()
		var_meta = rt.call_function('wp_get_attachment_metadata', [
			rt.get_property(var_attachment_shadow, 'ID'),
		])
		if !(!rt.is_true(var_meta)) {
			mut iter_14 := wp_get_attachment_id3_keys(var_attachment_shadow.clone(), '').iterator()
			for {
				item_14 := iter_14.next() or { break }
				mut var_label_shadow := item_14.val
				mut var_key_shadow := item_14.key
				if !(!rt.is_true(var_meta.array_get(var_key_shadow))) {
					var_track.array_get_mut('meta').array_set(var_key_shadow,
						var_meta.array_get(var_key_shadow))
				}
			}
			if rt.is_true(rt.identical(rt.new_string('video'),
				var_atts.array_get(rt.new_string('type'))))
			{
				if !(!rt.is_true(var_meta.array_get(rt.new_string('width'))))
					&& !(!rt.is_true(var_meta.array_get(rt.new_string('height')))) {
					var_width = var_meta.array_get(rt.new_string('width'))
					var_height = var_meta.array_get(rt.new_string('height'))
					var_theme_height = rt.call_function('round', [
						rt.div(rt.mul(var_height, var_theme_width), var_width),
					])
				} else {
					var_width = rt.new_int(var_default_width).clone()
					var_height = rt.new_int(var_default_height).clone()
				}
				var_track['dimensions'] = rt.create_array([
					rt.ArrayItem{ key: 'original', val: rt.call_function('compact', [
						rt.new_string('width'),
						rt.new_string('height'),
					]) },
					rt.ArrayItem{ key: 'resized', val: rt.create_array([
						rt.ArrayItem{ key: 'width', val: var_theme_width },
						rt.ArrayItem{ key: 'height', val: var_theme_height },
					]) },
				])
			}
		}
		if rt.is_true(var_atts.array_get(rt.new_string('images'))) {
			var_thumb_id = rt.call_function('get_post_thumbnail_id', [
				rt.get_property(var_attachment_shadow, 'ID'),
			])
			if !(!rt.is_true(var_thumb_id)) {
				mut list_tmp_15 := wp_get_attachment_image_src(var_thumb_id.clone(), 'full', false)
				var_src = list_tmp_15.array_get(0)
				var_width = list_tmp_15.array_get(1)
				var_height = list_tmp_15.array_get(2)
				var_track['image'] = rt.call_function('compact', [
					rt.new_string('src'), rt.new_string('width'),
					rt.new_string('height')])
				mut list_tmp_16 := wp_get_attachment_image_src(var_thumb_id.clone(), 'thumbnail',
					false)
				var_src = list_tmp_16.array_get(0)
				var_width = list_tmp_16.array_get(1)
				var_height = list_tmp_16.array_get(2)
				var_track['thumb'] = rt.call_function('compact', [
					rt.new_string('src'), rt.new_string('width'),
					rt.new_string('height')])
			} else {
				var_src = rt.call_function('wp_mime_type_icon', [
					rt.get_property(var_attachment_shadow, 'ID'),
					rt.new_string('.svg'),
				])
				var_width = rt.new_int(48)
				var_height = rt.new_int(64)
				var_track['image'] = rt.call_function('compact', [
					rt.new_string('src'), rt.new_string('width'),
					rt.new_string('height')])
				var_track['thumb'] = rt.call_function('compact', [
					rt.new_string('src'), rt.new_string('width'),
					rt.new_string('height')])
			}
		}
		var_tracks << var_track.clone()
	}
	var_data.array_set('tracks', var_tracks.clone())
	var_safe_type = rt.call_function('esc_attr', [var_atts.array_get(rt.new_string('type'))])
	var_safe_style = rt.call_function('esc_attr', [var_atts.array_get(rt.new_string('style'))])
	rt.call_function('ob_start', []rt.PhpVal{})
	if !var_is_loaded {
		rt.call_function('do_action', [rt.new_string('wp_playlist_scripts'),
			var_atts.array_get(rt.new_string('type')), var_atts.array_get(rt.new_string('style'))])
		var_is_loaded = true
	}
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_safe_type)
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_safe_style)
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.identical(rt.new_string('audio'), var_atts.array_get(rt.new_string('type')))) {
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_safe_type)
	// unsupported statement: Stmt_InlineHTML
	print(rt.new_int(var_theme_width.to_i64()).str())
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.identical(rt.new_string('video'), var_safe_type)) {
		print(' height="')
		print(rt.new_int(var_theme_height.to_i64()).str())
		print('"')
	}
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_safe_type)
	// unsupported statement: Stmt_InlineHTML
	mut iter_15 := var_attachments.iterator()
	for {
		item_15 := iter_15.next() or { break }
		mut var_attachment_shadow := item_15.val
		mut var_att_id_shadow := item_15.key
		rt.call_function('printf', [rt.new_string('<li>%s</li>'),
			rt.call_function('wp_get_attachment_link', [var_att_id_shadow.clone()])])
	}
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wp_json_encode', [var_data.clone(),
		rt.bitwise_or(rt.get_constant('JSON_HEX_TAG'), rt.get_constant('JSON_UNESCAPED_SLASHES'))]))
	// unsupported statement: Stmt_InlineHTML
	return (rt.call_function('ob_get_clean', []rt.PhpVal{})).str()
}

fn wp_mediaelement_fallback(var_url rt.PhpVal) rt.PhpVal {
	return rt.call_function('apply_filters', [rt.new_string('wp_mediaelement_fallback'),
		rt.call_function('sprintf', [rt.new_string('<a href="%1$s">%1$s</a>'),
			rt.call_function('esc_url', [var_url.clone()])]),
		var_url.clone()])
}

fn wp_get_audio_extensions() rt.PhpVal {
	return rt.call_function('apply_filters', [rt.new_string('wp_audio_extensions'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'mp3' },
			rt.ArrayItem{ key: none, val: 'ogg' }, rt.ArrayItem{ key: none, val: 'flac' },
			rt.ArrayItem{ key: none, val: 'm4a' }, rt.ArrayItem{ key: none, val: 'wav' }])])
}

fn wp_get_attachment_id3_keys(var_attachment rt.PhpVal, context string) rt.PhpVal {
	mut var_context := context
	mut var_fields := map[string]rt.PhpVal{}
	var_fields = {
		'artist': rt.call_function('__', [rt.new_string('Artist')])
		'album':  rt.call_function('__', [rt.new_string('Album')])
	}
	if rt.is_true(rt.identical(rt.new_string('display'), rt.new_string(context))) {
		var_fields['genre'] = rt.call_function('__', [rt.new_string('Genre')])
		var_fields['year'] = rt.call_function('__', [rt.new_string('Year')])
		var_fields['length_formatted'] = rt.call_function('_x', [
			rt.new_string('Length'), rt.new_string('video or audio')])
	} else if rt.is_true(rt.identical(rt.new_string('js'), rt.new_string(context))) {
		var_fields['bitrate'] = rt.call_function('__', [rt.new_string('Bitrate')])
		var_fields['bitrate_mode'] = rt.call_function('__', [
			rt.new_string('Bitrate Mode'),
		])
	}
	return rt.call_function('apply_filters', [
		rt.new_string('wp_get_attachment_id3_keys'),
		rt.create_array_from_native_map(var_fields),
		var_attachment.clone(),
		rt.new_string(context),
	])
}

fn wp_audio_shortcode(var_attr rt.PhpVal, content string) rt.PhpVal {
	mut var_content := content
	mut var_instance := rt.new_null()
	mut var_post_id := rt.new_null()
	mut var_override := rt.new_null()
	mut var_audio := rt.new_null()
	mut var_default_types := rt.new_null()
	mut var_defaults_atts := rt.new_null()
	mut var_type := rt.new_null()
	mut var_atts := rt.new_null()
	mut var_primary := false
	mut var_ext := rt.new_null()
	mut var_audios := rt.new_null()
	mut var_library := rt.new_null()
	mut var_html_atts := rt.new_null()
	mut var_a := rt.new_null()
	mut var_attr_strings := []rt.PhpVal{}
	mut var_attribute_value := rt.new_null()
	mut var_attribute_name := rt.new_null()
	mut var_allowed_preload_values := []rt.PhpVal{}
	mut var_html := rt.new_null()
	mut var_fileurl := rt.new_null()
	mut var_source := ''
	mut var_fallback := rt.new_null()
	mut var_url := rt.new_null()
	var_post_id = if rt.is_true(rt.call_function('get_post', []rt.PhpVal{})) {
		rt.call_function('get_the_ID', []rt.PhpVal{})
	} else {
		rt.new_int(0)
	}
	rt.pre_inc(var_instance)
	var_override = rt.call_function('apply_filters', [
		rt.new_string('wp_audio_shortcode_override'),
		rt.new_string(''),
		var_attr.clone(),
		rt.new_string(var_content.str()),
		var_instance.clone(),
	])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), var_override)))) {
		return var_override.clone()
	}
	var_audio = rt.new_null()
	var_default_types = wp_get_audio_extensions()
	var_defaults_atts = rt.create_array([rt.ArrayItem{ key: 'src', val: '' },
		rt.ArrayItem{ key: 'loop', val: '' }, rt.ArrayItem{ key: 'autoplay', val: '' },
		rt.ArrayItem{ key: 'muted', val: 'false' }, rt.ArrayItem{ key: 'preload', val: 'none' },
		rt.ArrayItem{ key: 'class', val: 'wp-audio-shortcode' },
		rt.ArrayItem{ key: 'style', val: 'width: 100%;' }])
	mut iter_16 := var_default_types.iterator()
	for {
		item_16 := iter_16.next() or { break }
		mut var_type_shadow := item_16.val
		var_defaults_atts.array_set(var_type_shadow, '')
	}
	var_atts = rt.call_function('shortcode_atts', [var_defaults_atts.clone(),
		var_attr.clone(), rt.new_string('audio')])
	var_primary = false
	if !(!rt.is_true(var_atts.array_get(rt.new_string('src')))) {
		var_type = rt.call_function('wp_check_filetype', [
			var_atts.array_get(rt.new_string('src')),
			rt.call_function('wp_get_mime_types', []rt.PhpVal{}),
		])
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
			rt.new_string(var_type.array_get(rt.new_string('ext')).to_string().to_lower()),
			var_default_types.clone(),
			rt.new_bool(true),
		])))))
		{
			return rt.call_function('sprintf', [
				rt.new_string('<a class="wp-embedded-audio" href="%s">%s</a>'),
				rt.call_function('esc_url', [var_atts.array_get(rt.new_string('src'))]),
				rt.call_function('esc_html', [var_atts.array_get(rt.new_string('src'))]),
			])
		}
		var_primary = true
		rt.call_function('array_unshift', [var_default_types.clone(),
			rt.new_string('src')])
	} else {
		mut iter_17 := var_default_types.iterator()
		for {
			item_17 := iter_17.next() or { break }
			mut var_ext_shadow := item_17.val
			if !(!rt.is_true(var_atts.array_get(var_ext_shadow))) {
				var_type = rt.call_function('wp_check_filetype', [
					var_atts.array_get(var_ext_shadow),
					rt.call_function('wp_get_mime_types', []rt.PhpVal{}),
				])
				if rt.is_true(rt.identical(rt.new_string(var_type.array_get(rt.new_string('ext')).to_string().to_lower()),
					var_ext_shadow))
				{
					var_primary = true
				}
			}
		}
	}
	if !var_primary {
		var_audios = get_attached_media('audio', var_post_id.clone())
		if !rt.is_true(var_audios) {
			return rt.new_null()
		}
		var_audio = rt.call_function('reset', [var_audios.clone()])
		var_atts.array_set('src', rt.call_function('wp_get_attachment_url', [
			rt.get_property(var_audio, 'ID'),
		]))
		if !rt.is_true(var_atts.array_get(rt.new_string('src'))) {
			return rt.new_null()
		}
		rt.call_function('array_unshift', [var_default_types.clone(),
			rt.new_string('src')])
	}
	var_library = rt.call_function('apply_filters', [
		rt.new_string('wp_audio_shortcode_library'),
		rt.new_string('mediaelement'),
	])
	if rt.is_true(rt.identical(rt.new_string('mediaelement'), var_library))
		&& rt.is_true(rt.call_function('did_action', [rt.new_string('init')])) {
		rt.call_function('wp_enqueue_style', [rt.new_string('wp-mediaelement')])
		rt.call_function('wp_enqueue_script', [rt.new_string('wp-mediaelement')])
	}
	var_atts.array_set('class', rt.call_function('apply_filters', [
		rt.new_string('wp_audio_shortcode_class'),
		var_atts.array_get(rt.new_string('class')),
		var_atts.clone(),
	]))
	var_html_atts = rt.create_array([
		rt.ArrayItem{ key: 'class', val: var_atts.array_get(rt.new_string('class')) },
		rt.ArrayItem{ key: 'id', val: rt.call_function('sprintf', [
			rt.new_string('audio-%d-%d'),
			var_post_id.clone(),
			var_instance.clone(),
		]) },
		rt.ArrayItem{ key: 'loop', val: rt.call_function('wp_validate_boolean', [
			var_atts.array_get(rt.new_string('loop')),
		]) },
		rt.ArrayItem{ key: 'autoplay', val: rt.call_function('wp_validate_boolean', [
			var_atts.array_get(rt.new_string('autoplay')),
		]) },
		rt.ArrayItem{ key: 'muted', val: rt.call_function('wp_validate_boolean', [
			var_atts.array_get(rt.new_string('muted')),
		]) },
		rt.ArrayItem{ key: 'preload', val: var_atts.array_get(rt.new_string('preload')) },
		rt.ArrayItem{ key: 'style', val: var_atts.array_get(rt.new_string('style')) },
	])
	mut iter_18 := rt.create_array([rt.ArrayItem{ key: none, val: 'loop' },
		rt.ArrayItem{ key: none, val: 'autoplay' }, rt.ArrayItem{ key: none, val: 'preload' },
		rt.ArrayItem{ key: none, val: 'muted' }]).iterator()
	for {
		item_18 := iter_18.next() or { break }
		mut var_a_shadow := item_18.val
		if !rt.is_true(var_html_atts.array_get(var_a_shadow)) {
			var_html_atts.array_unset(var_a_shadow)
		}
	}
	var_attr_strings = rt.new_array()
	mut iter_19 := var_html_atts.iterator()
	for {
		item_19 := iter_19.next() or { break }
		mut var_attribute_value_shadow := item_19.val
		mut var_attribute_name_shadow := item_19.key
		if rt.is_true(rt.call_function('in_array', [var_attribute_name_shadow.clone(), rt.create_array([rt.ArrayItem{
			key: none
			val: 'loop'
		}, rt.ArrayItem{ key: none, val: 'autoplay' }, rt.ArrayItem{ key: none, val: 'muted' }]), rt.new_bool(true)]))
			&& rt.is_true(rt.identical(rt.new_bool(true), var_attribute_value_shadow)) {
			var_attr_strings << rt.call_function('esc_attr', [
				var_attribute_name_shadow.clone()])
		} else if rt.is_true(rt.identical(rt.new_string('preload'), var_attribute_name_shadow))
			&& !(!rt.is_true(var_attribute_value_shadow)) {
			var_allowed_preload_values = ['none', 'metadata', 'auto']
			if rt.is_true(rt.call_function('in_array', [var_attribute_value_shadow.clone(),
				rt.create_array_from_list(var_allowed_preload_values),
				rt.new_bool(true)]))
			{
				var_attr_strings << rt.call_function('sprintf', [
					rt.new_string('%s="%s"'),
					rt.call_function('esc_attr', [var_attribute_name_shadow.clone()]),
					rt.call_function('esc_attr', [var_attribute_value_shadow.clone()]),
				])
			}
		} else {
			var_attr_strings << rt.call_function('sprintf', [
				rt.new_string('%s="%s"'),
				rt.call_function('esc_attr', [
					var_attribute_name_shadow.clone()]),
				rt.call_function('esc_attr', [var_attribute_value_shadow.clone()])])
		}
	}
	var_html = rt.call_function('sprintf', [
		rt.new_string('<audio %s controls="controls">'),
		rt.call_function('implode',
			[rt.new_string(' '), rt.create_array_from_list(var_attr_strings)]),
	])
	var_fileurl = rt.new_string('')
	var_source = '<source type="%s" src="%s" />'
	mut iter_20 := var_default_types.iterator()
	for {
		item_20 := iter_20.next() or { break }
		mut var_fallback_shadow := item_20.val
		if !(!rt.is_true(var_atts.array_get(var_fallback_shadow))) {
			if !rt.is_true(var_fileurl) {
				var_fileurl = var_atts.array_get(var_fallback_shadow)
			}
			var_type = rt.call_function('wp_check_filetype', [
				var_atts.array_get(var_fallback_shadow),
				rt.call_function('wp_get_mime_types', []rt.PhpVal{}),
			])
			var_url = rt.call_function('add_query_arg', [rt.new_string('_'),
				var_instance.clone(), var_atts.array_get(var_fallback_shadow)])
			var_html = rt.concat(var_html, rt.call_function('sprintf', [
				rt.new_string(var_source.str()).clone(), var_type.array_get(rt.new_string('type')),
				rt.call_function('esc_url', [var_url.clone()])]))
		}
	}
	if rt.is_true(rt.identical(rt.new_string('mediaelement'), var_library)) {
		var_html = rt.concat(var_html, wp_mediaelement_fallback(var_fileurl.clone()))
	}
	var_html = rt.concat(var_html, rt.new_string('</audio>'))
	return rt.call_function('apply_filters', [rt.new_string('wp_audio_shortcode'),
		var_html.clone(), var_atts.clone(), var_audio.clone(),
		var_post_id.clone(), var_library.clone()])
}

fn wp_get_video_extensions() rt.PhpVal {
	return rt.call_function('apply_filters', [rt.new_string('wp_video_extensions'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'mp4' },
			rt.ArrayItem{ key: none, val: 'm4v' }, rt.ArrayItem{ key: none, val: 'webm' },
			rt.ArrayItem{ key: none, val: 'ogv' }, rt.ArrayItem{ key: none, val: 'flv' }])])
}

fn wp_video_shortcode(var_attr rt.PhpVal, content string) rt.PhpVal {
	mut var_content := content
	mut var_content_width := rt.new_null()
	mut var_instance := rt.new_null()
	mut var_post_id := rt.new_null()
	mut var_override := rt.new_null()
	mut var_video := rt.new_null()
	mut var_default_types := rt.new_null()
	mut var_defaults_atts := rt.new_null()
	mut var_type := rt.new_null()
	mut var_atts := rt.new_null()
	mut var_is_vimeo := rt.new_null()
	mut var_is_youtube := rt.new_null()
	mut var_yt_pattern := ''
	mut var_vimeo_pattern := ''
	mut var_primary := false
	mut var_ext := rt.new_null()
	mut var_videos := rt.new_null()
	mut var_library := rt.new_null()
	mut var_parsed_vimeo_url := rt.new_null()
	mut var_vimeo_src := rt.new_null()
	mut var_loop := ''
	mut var_html_atts := rt.new_null()
	mut var_a := rt.new_null()
	mut var_attr_strings := []rt.PhpVal{}
	mut var_attribute_value := rt.new_null()
	mut var_attribute_name := rt.new_null()
	mut var_allowed_preload_values := []rt.PhpVal{}
	mut var_html := rt.new_null()
	mut var_fileurl := rt.new_null()
	mut var_source := ''
	mut var_fallback := rt.new_null()
	mut var_url := rt.new_null()
	mut var_width_rule := rt.new_null()
	mut var_output := rt.new_null()
	var_post_id = if rt.is_true(rt.call_function('get_post', []rt.PhpVal{})) {
		rt.call_function('get_the_ID', []rt.PhpVal{})
	} else {
		rt.new_int(0)
	}
	rt.pre_inc(var_instance)
	var_override = rt.call_function('apply_filters', [
		rt.new_string('wp_video_shortcode_override'),
		rt.new_string(''),
		var_attr.clone(),
		rt.new_string(var_content.str()),
		var_instance.clone(),
	])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), var_override)))) {
		return var_override.clone()
	}
	var_video = rt.new_null()
	var_default_types = wp_get_video_extensions()
	var_defaults_atts = rt.create_array([rt.ArrayItem{ key: 'src', val: '' },
		rt.ArrayItem{ key: 'poster', val: '' }, rt.ArrayItem{ key: 'loop', val: '' },
		rt.ArrayItem{ key: 'autoplay', val: '' }, rt.ArrayItem{ key: 'muted', val: 'false' },
		rt.ArrayItem{ key: 'preload', val: 'metadata' }, rt.ArrayItem{ key: 'width', val: 640 },
		rt.ArrayItem{ key: 'height', val: 360 }, rt.ArrayItem{
			key: 'class'
			val: 'wp-video-shortcode'
		}])
	mut iter_21 := var_default_types.iterator()
	for {
		item_21 := iter_21.next() or { break }
		mut var_type_shadow := item_21.val
		var_defaults_atts.array_set(var_type_shadow, '')
	}
	var_atts = rt.call_function('shortcode_atts', [var_defaults_atts.clone(),
		var_attr.clone(), rt.new_string('video')])
	if rt.is_true(rt.call_function('is_admin', []rt.PhpVal{})) {
		if rt.is_true(rt.greater(var_atts.array_get(rt.new_string('width')),
			var_defaults_atts.array_get(rt.new_string('width'))))
		{
			var_atts.array_set('height', rt.call_function('round', [
				rt.div(rt.mul(var_atts.array_get(rt.new_string('height')),
					var_defaults_atts.array_get(rt.new_string('width'))),
					var_atts.array_get(rt.new_string('width'))),
			]))
			var_atts.array_set('width', var_defaults_atts.array_get(rt.new_string('width')))
		}
	} else {
		if !(!rt.is_true(var_content_width))
			&& rt.is_true(rt.greater(var_atts.array_get(rt.new_string('width')), var_content_width)) {
			var_atts.array_set('height', rt.call_function('round', [
				rt.div(rt.mul(var_atts.array_get(rt.new_string('height')), var_content_width),
					var_atts.array_get(rt.new_string('width'))),
			]))
			var_atts.array_set('width', var_content_width.clone())
		}
	}
	var_is_vimeo = rt.new_bool(false)
	var_is_youtube = rt.new_bool(false)
	var_yt_pattern = '#^https?://(?:www\\.)?(?:youtube\\.com/watch|youtu\\.be/)#'
	var_vimeo_pattern = '#^https?://(.+\\.)?vimeo\\.com/.*#'
	var_primary = false
	if !(!rt.is_true(var_atts.array_get(rt.new_string('src')))) {
		var_is_vimeo = rt.call_function('preg_match', [rt.new_string(var_vimeo_pattern.str()).clone(),
			var_atts.array_get(rt.new_string('src'))])
		var_is_youtube = rt.call_function('preg_match', [rt.new_string(var_yt_pattern.str()).clone(),
			var_atts.array_get(rt.new_string('src'))])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_is_youtube))))
			&& rt.is_true(rt.new_bool(!(rt.is_true(var_is_vimeo)))) {
			var_type = rt.call_function('wp_check_filetype', [
				var_atts.array_get(rt.new_string('src')),
				rt.call_function('wp_get_mime_types', []rt.PhpVal{}),
			])
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
				rt.new_string(var_type.array_get(rt.new_string('ext')).to_string().to_lower()),
				var_default_types.clone(),
				rt.new_bool(true),
			])))))
			{
				return rt.call_function('sprintf', [
					rt.new_string('<a class="wp-embedded-video" href="%s">%s</a>'),
					rt.call_function('esc_url', [var_atts.array_get(rt.new_string('src'))]),
					rt.call_function('esc_html', [var_atts.array_get(rt.new_string('src'))]),
				])
			}
		}
		if rt.is_true(var_is_vimeo) {
			rt.call_function('wp_enqueue_script', [rt.new_string('mediaelement-vimeo')])
		}
		var_primary = true
		rt.call_function('array_unshift', [var_default_types.clone(),
			rt.new_string('src')])
	} else {
		mut iter_22 := var_default_types.iterator()
		for {
			item_22 := iter_22.next() or { break }
			mut var_ext_shadow := item_22.val
			if !(!rt.is_true(var_atts.array_get(var_ext_shadow))) {
				var_type = rt.call_function('wp_check_filetype', [
					var_atts.array_get(var_ext_shadow),
					rt.call_function('wp_get_mime_types', []rt.PhpVal{}),
				])
				if rt.is_true(rt.identical(rt.new_string(var_type.array_get(rt.new_string('ext')).to_string().to_lower()),
					var_ext_shadow))
				{
					var_primary = true
				}
			}
		}
	}
	if !var_primary {
		var_videos = get_attached_media('video', var_post_id.clone())
		if !rt.is_true(var_videos) {
			return rt.new_null()
		}
		var_video = rt.call_function('reset', [var_videos.clone()])
		var_atts.array_set('src', rt.call_function('wp_get_attachment_url', [
			rt.get_property(var_video, 'ID'),
		]))
		if !rt.is_true(var_atts.array_get(rt.new_string('src'))) {
			return rt.new_null()
		}
		rt.call_function('array_unshift', [var_default_types.clone(),
			rt.new_string('src')])
	}
	var_library = rt.call_function('apply_filters', [
		rt.new_string('wp_video_shortcode_library'),
		rt.new_string('mediaelement'),
	])
	if rt.is_true(rt.identical(rt.new_string('mediaelement'), var_library))
		&& rt.is_true(rt.call_function('did_action', [rt.new_string('init')])) {
		rt.call_function('wp_enqueue_style', [rt.new_string('wp-mediaelement')])
		rt.call_function('wp_enqueue_script', [rt.new_string('wp-mediaelement')])
		rt.call_function('wp_enqueue_script', [rt.new_string('mediaelement-vimeo')])
	}
	if rt.is_true(rt.identical(rt.new_string('mediaelement'), var_library)) {
		if rt.is_true(var_is_youtube) {
			var_atts.array_set('src', rt.call_function('remove_query_arg', [
				rt.new_string('feature'),
				var_atts.array_get(rt.new_string('src')),
			]))
			var_atts.array_set('src', rt.call_function('set_url_scheme', [
				var_atts.array_get(rt.new_string('src')),
				rt.new_string('https'),
			]))
		} else if rt.is_true(var_is_vimeo) {
			var_parsed_vimeo_url = rt.call_function('wp_parse_url', [
				var_atts.array_get(rt.new_string('src')),
			])
			var_vimeo_src = rt.new_string('https://' +
				(var_parsed_vimeo_url.array_get(rt.new_string('host'))).str() +
				(var_parsed_vimeo_url.array_get(rt.new_string('path'))).str())
			var_loop = if rt.is_true(var_atts.array_get(rt.new_string('loop'))) { '1' } else { '0' }
			var_atts.array_set('src', rt.call_function('add_query_arg', [
				rt.new_string('loop'),
				rt.new_string(var_loop.str()).clone(),
				var_vimeo_src.clone(),
			]))
		}
	}
	var_atts.array_set('class', rt.call_function('apply_filters', [
		rt.new_string('wp_video_shortcode_class'),
		var_atts.array_get(rt.new_string('class')),
		var_atts.clone(),
	]))
	var_html_atts = rt.create_array([
		rt.ArrayItem{ key: 'class', val: var_atts.array_get(rt.new_string('class')) },
		rt.ArrayItem{ key: 'id', val: rt.call_function('sprintf', [
			rt.new_string('video-%d-%d'),
			var_post_id.clone(),
			var_instance.clone(),
		]) },
		rt.ArrayItem{ key: 'width', val: rt.call_function('absint', [
			var_atts.array_get(rt.new_string('width')),
		]) },
		rt.ArrayItem{ key: 'height', val: rt.call_function('absint', [
			var_atts.array_get(rt.new_string('height')),
		]) },
		rt.ArrayItem{ key: 'poster', val: rt.call_function('esc_url', [
			var_atts.array_get(rt.new_string('poster')),
		]) },
		rt.ArrayItem{ key: 'loop', val: rt.call_function('wp_validate_boolean', [
			var_atts.array_get(rt.new_string('loop')),
		]) },
		rt.ArrayItem{ key: 'autoplay', val: rt.call_function('wp_validate_boolean', [
			var_atts.array_get(rt.new_string('autoplay')),
		]) },
		rt.ArrayItem{ key: 'muted', val: rt.call_function('wp_validate_boolean', [
			var_atts.array_get(rt.new_string('muted')),
		]) },
		rt.ArrayItem{ key: 'preload', val: var_atts.array_get(rt.new_string('preload')) },
	])
	mut iter_23 := rt.create_array([rt.ArrayItem{ key: none, val: 'poster' },
		rt.ArrayItem{ key: none, val: 'loop' }, rt.ArrayItem{ key: none, val: 'autoplay' },
		rt.ArrayItem{ key: none, val: 'preload' }, rt.ArrayItem{ key: none, val: 'muted' }]).iterator()
	for {
		item_23 := iter_23.next() or { break }
		mut var_a_shadow := item_23.val
		if !rt.is_true(var_html_atts.array_get(var_a_shadow)) {
			var_html_atts.array_unset(var_a_shadow)
		}
	}
	var_attr_strings = rt.new_array()
	mut iter_24 := var_html_atts.iterator()
	for {
		item_24 := iter_24.next() or { break }
		mut var_attribute_value_shadow := item_24.val
		mut var_attribute_name_shadow := item_24.key
		if rt.is_true(rt.call_function('in_array', [var_attribute_name_shadow.clone(), rt.create_array([rt.ArrayItem{
			key: none
			val: 'loop'
		}, rt.ArrayItem{ key: none, val: 'autoplay' }, rt.ArrayItem{ key: none, val: 'muted' }]), rt.new_bool(true)]))
			&& rt.is_true(rt.identical(rt.new_bool(true), var_attribute_value_shadow)) {
			var_attr_strings << rt.call_function('esc_attr', [
				var_attribute_name_shadow.clone()])
		} else if rt.is_true(rt.identical(rt.new_string('preload'), var_attribute_name_shadow))
			&& !(!rt.is_true(var_attribute_value_shadow)) {
			var_allowed_preload_values = ['none', 'metadata', 'auto']
			if rt.is_true(rt.call_function('in_array', [var_attribute_value_shadow.clone(),
				rt.create_array_from_list(var_allowed_preload_values),
				rt.new_bool(true)]))
			{
				var_attr_strings << rt.call_function('sprintf', [
					rt.new_string('%s="%s"'),
					rt.call_function('esc_attr', [var_attribute_name_shadow.clone()]),
					rt.call_function('esc_attr', [var_attribute_value_shadow.clone()]),
				])
			}
		} else if !(!rt.is_true(var_attribute_value_shadow)) {
			var_attr_strings << rt.call_function('sprintf', [
				rt.new_string('%s="%s"'),
				rt.call_function('esc_attr', [
					var_attribute_name_shadow.clone()]),
				rt.call_function('esc_attr', [var_attribute_value_shadow.clone()])])
		}
	}
	var_html = rt.call_function('sprintf', [
		rt.new_string('<video %s controls="controls">'),
		rt.call_function('implode',
			[rt.new_string(' '), rt.create_array_from_list(var_attr_strings)]),
	])
	var_fileurl = rt.new_string('')
	var_source = '<source type="%s" src="%s" />'
	mut iter_25 := var_default_types.iterator()
	for {
		item_25 := iter_25.next() or { break }
		mut var_fallback_shadow := item_25.val
		if !(!rt.is_true(var_atts.array_get(var_fallback_shadow))) {
			if !rt.is_true(var_fileurl) {
				var_fileurl = var_atts.array_get(var_fallback_shadow)
			}
			if rt.is_true(rt.identical(rt.new_string('src'), var_fallback_shadow))
				&& rt.is_true(var_is_youtube) {
				var_type = rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'video/youtube' },
				])
			} else if rt.is_true(rt.identical(rt.new_string('src'), var_fallback_shadow))
				&& rt.is_true(var_is_vimeo) {
				var_type = rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'video/vimeo' },
				])
			} else {
				var_type = rt.call_function('wp_check_filetype', [
					var_atts.array_get(var_fallback_shadow),
					rt.call_function('wp_get_mime_types', []rt.PhpVal{}),
				])
			}
			var_url = rt.call_function('add_query_arg', [rt.new_string('_'),
				var_instance.clone(), var_atts.array_get(var_fallback_shadow)])
			var_html = rt.concat(var_html, rt.call_function('sprintf', [
				rt.new_string(var_source.str()).clone(), var_type.array_get(rt.new_string('type')),
				rt.call_function('esc_url', [var_url.clone()])]))
		}
	}
	if !(var_content == '') {
		if rt.is_true(rt.call_function('str_contains', [
			rt.new_string(var_content.str()),
			rt.new_string('\n'),
		]))
		{
			var_content = (rt.call_function('str_replace', [
				rt.create_array([rt.ArrayItem{ key: none, val: '\r\n' },
					rt.ArrayItem{ key: none, val: '\n' }, rt.ArrayItem{ key: none, val: '\t' }]),
				rt.new_string(''),
				rt.new_string(var_content.str()),
			])).str()
		}
		var_html = rt.concat(var_html, rt.new_string(var_content.trim_space()))
	}
	if rt.is_true(rt.identical(rt.new_string('mediaelement'), var_library)) {
		var_html = rt.concat(var_html, wp_mediaelement_fallback(var_fileurl.clone()))
	}
	var_html = rt.concat(var_html, rt.new_string('</video>'))
	var_width_rule = rt.new_string('')
	if !(!rt.is_true(var_atts.array_get(rt.new_string('width')))) {
		var_width_rule = rt.call_function('sprintf', [rt.new_string('width: %dpx;'),
			var_atts.array_get(rt.new_string('width'))])
	}
	var_output = rt.call_function('sprintf', [
		rt.new_string('<div style="%s" class="wp-video">%s</div>'),
		var_width_rule.clone(),
		var_html.clone(),
	])
	return rt.call_function('apply_filters', [rt.new_string('wp_video_shortcode'),
		var_output.clone(), var_atts.clone(), var_video.clone(),
		var_post_id.clone(), var_library.clone()])
}

fn get_previous_image_link(size string, text bool) rt.PhpVal {
	mut var_size := size
	mut var_text := text
	return get_adjacent_image_link(true, size, text)
}

fn previous_image_link(size string, text bool) {
	mut var_size := size
	mut var_text := text
	rt.echo_val(get_previous_image_link(size, text))
}

fn get_next_image_link(size string, text bool) rt.PhpVal {
	mut var_size := size
	mut var_text := text
	return get_adjacent_image_link(false, size, text)
}

fn next_image_link(size string, text bool) {
	mut var_size := size
	mut var_text := text
	rt.echo_val(get_next_image_link(size, text))
}

fn get_adjacent_image_link(prev bool, size string, text bool) rt.PhpVal {
	mut var_prev := prev
	mut var_size := size
	mut var_text := text
	mut var_post := rt.new_null()
	mut var_attachments := rt.new_null()
	mut var_attachment := rt.new_null()
	mut var_k := rt.new_null()
	mut var_output := rt.new_null()
	mut var_attachment_id := rt.new_null()
	mut var_attr := rt.new_null()
	mut var_adjacent := ''
	var_post = rt.call_function('get_post', []rt.PhpVal{})
	var_attachments = rt.call_function('array_values', [
		rt.call_function('get_children', [
			rt.create_array([
				rt.ArrayItem{ key: 'post_parent', val: rt.get_property(var_post, 'post_parent') },
				rt.ArrayItem{ key: 'post_status', val: 'inherit' },
				rt.ArrayItem{ key: 'post_type', val: 'attachment' },
				rt.ArrayItem{ key: 'post_mime_type', val: 'image' },
				rt.ArrayItem{ key: 'order', val: 'ASC' },
				rt.ArrayItem{ key: 'orderby', val: 'menu_order ID' },
			]),
		]),
	])
	mut iter_26 := var_attachments.iterator()
	for {
		item_26 := iter_26.next() or { break }
		mut var_attachment_shadow := item_26.val
		mut var_k_shadow := item_26.key
		if rt.new_int((rt.get_property(var_attachment_shadow, 'ID')).to_i64()) == rt.new_int((rt.get_property(var_post,
			'ID')).to_i64()) {
			break
		}
	}
	var_output = rt.new_string('')
	var_attachment_id = rt.new_int(0)
	if rt.is_true(var_attachments) {
		var_k = if var_prev { rt.sub(var_k, rt.new_int(1)) } else { rt.add(var_k, rt.new_int(1)) }
		if var_attachments.array_isset(var_k) {
			var_attachment_id = rt.get_property(var_attachments.array_get(var_k), 'ID')
			var_attr = rt.create_array([
				rt.ArrayItem{ key: 'alt', val: rt.call_function('get_the_title', [
					var_attachment_id.clone(),
				]) },
			])
			var_output = rt.call_function('wp_get_attachment_link', [
				var_attachment_id.clone(), rt.new_string(size),
				rt.new_bool(true), rt.new_bool(false), rt.new_bool(text),
				var_attr.clone()])
		}
	}
	var_adjacent = if var_prev { 'previous' } else { 'next' }
	return rt.call_function('apply_filters', [
		rt.new_string('${var_adjacent}_image_link'),
		var_output.clone(),
		var_attachment_id.clone(),
		rt.new_string(size),
		rt.new_bool(text),
	])
}

fn adjacent_image_link(prev bool, size string, text bool) {
	mut var_prev := prev
	mut var_size := size
	mut var_text := text
	rt.echo_val(get_adjacent_image_link(prev, size, text))
}

fn get_attachment_taxonomies(var_attachment_arg rt.PhpVal, output string) rt.PhpVal {
	mut var_output := output
	mut var_attachment := var_attachment_arg
	mut var_file := rt.new_null()
	mut var_filename := rt.new_null()
	mut var_objects := []rt.PhpVal{}
	mut var_token := rt.new_null()
	mut var_taxonomies := rt.new_null()
	mut var_object := rt.new_null()
	mut var_taxes := rt.new_null()
	if rt.is_true(rt.new_bool(var_attachment.clone().is_long())) {
		var_attachment = rt.call_function('get_post', [var_attachment.clone()])
	} else if rt.is_true(rt.new_bool(var_attachment.clone().is_array())) {
		var_attachment = rt.array_to_object(var_attachment)
	}
	if !(var_attachment.clone().is_object()) {
		return rt.new_array()
	}
	var_file = rt.call_function('get_attached_file', [
		rt.get_property(var_attachment, 'ID'),
	])
	var_filename = rt.call_function('wp_basename', [var_file.clone()])
	var_objects = ['attachment']
	if rt.is_true(rt.call_function('str_contains', [var_filename.clone(),
		rt.new_string('.')]))
	{
		var_objects << 'attachment:' +(rt.call_function('substr', [var_filename.clone(), rt.add(rt.call_function('strrpos', [var_filename.clone(), rt.new_string('.')]), rt.new_int(1))])).str()
	}
	if !(!rt.is_true(rt.get_property(var_attachment, 'post_mime_type'))) {
		var_objects << 'attachment:' + (rt.get_property(var_attachment, 'post_mime_type')).str()
		if rt.is_true(rt.call_function('str_contains', [
			rt.get_property(var_attachment, 'post_mime_type'),
			rt.new_string('/'),
		]))
		{
			mut iter_27 := rt.call_function('explode', [rt.new_string('/'),
				rt.get_property(var_attachment, 'post_mime_type')]).iterator()
			for {
				item_27 := iter_27.next() or { break }
				mut var_token_shadow := item_27.val
				if !(!rt.is_true(var_token_shadow)) {
					var_objects << 'attachment:${var_token.to_string()}'
				}
			}
		}
	}
	var_taxonomies = rt.new_array()
	for var_object_shadow in var_objects {
		var_taxes = rt.call_function('get_object_taxonomies', [
			rt.new_string(var_object_shadow.str()).clone(), rt.new_string(output)])
		if rt.is_true(var_taxes) {
			var_taxonomies = rt.call_function('array_merge', [
				var_taxonomies.clone(), var_taxes.clone()])
		}
	}
	if rt.is_true(rt.identical(rt.new_string('names'), rt.new_string(output))) {
		var_taxonomies = rt.call_function('array_unique', [var_taxonomies.clone()])
	}
	return var_taxonomies.clone()
}

fn get_taxonomies_for_attachments(output string) rt.PhpVal {
	mut var_output := output
	mut var_taxonomies := rt.new_null()
	mut var_taxonomy := rt.new_null()
	mut var_object_type := rt.new_null()
	var_taxonomies = rt.new_array()
	mut iter_28 := rt.call_function('get_taxonomies', [rt.new_array(),
		rt.new_string('objects')]).iterator()
	for {
		item_28 := iter_28.next() or { break }
		mut var_taxonomy_shadow := item_28.val
		mut iter_29 := rt.get_property(var_taxonomy_shadow, 'object_type').iterator()
		for {
			item_29 := iter_29.next() or { break }
			mut var_object_type_shadow := item_29.val
			if rt.is_true(rt.identical(rt.new_string('attachment'), var_object_type_shadow))
				|| rt.is_true(rt.call_function('str_starts_with', [var_object_type_shadow.clone(), rt.new_string('attachment:')])) {
				if rt.is_true(rt.identical(rt.new_string('names'), rt.new_string(output))) {
					var_taxonomies.array_push(rt.get_property(var_taxonomy_shadow, 'name'))
				} else {
					var_taxonomies.array_set(rt.get_property(var_taxonomy_shadow, 'name'),
						var_taxonomy_shadow.clone())
				}
				break
			}
		}
	}
	return var_taxonomies.clone()
}

fn is_gd_image(var_image rt.PhpVal) bool {
	if rt.is_true(rt.new_bool(rt.instance_of(var_image, 'GdImage')))
		|| (rt.is_true(rt.call_function('is_resource', [var_image.clone()]))
		&& rt.is_true(rt.identical(rt.new_string('gd'), rt.call_function('get_resource_type', [var_image.clone()])))) {
		return true
	}
	return false
}

fn wp_imagecreatetruecolor(var_width rt.PhpVal, var_height rt.PhpVal) rt.PhpVal {
	mut var_img := rt.new_null()
	var_img = rt.call_function('imagecreatetruecolor', [var_width.clone(),
		var_height.clone()])
	if is_gd_image(var_img.clone())
		&& rt.is_true(rt.call_function('function_exists', [rt.new_string('imagealphablending')]))
		&& rt.is_true(rt.call_function('function_exists', [rt.new_string('imagesavealpha')])) {
		rt.call_function('imagealphablending', [var_img.clone(),
			rt.new_bool(false)])
		rt.call_function('imagesavealpha', [var_img.clone(), rt.new_bool(true)])
	}
	return var_img.clone()
}

fn wp_expand_dimensions(var_example_width_arg rt.PhpVal, var_example_height_arg rt.PhpVal, var_max_width_arg rt.PhpVal, var_max_height_arg rt.PhpVal) rt.PhpVal {
	mut var_example_width := var_example_width_arg
	mut var_example_height := var_example_height_arg
	mut var_max_width := var_max_width_arg
	mut var_max_height := var_max_height_arg
	var_example_width = rt.new_int(var_example_width.to_i64())
	var_example_height = rt.new_int(var_example_height.to_i64())
	var_max_width = rt.new_int(var_max_width.to_i64())
	var_max_height = rt.new_int(var_max_height.to_i64())
	return wp_constrain_dimensions(rt.mul(var_example_width, rt.new_int(1000000)), rt.mul(var_example_height,
		rt.new_int(1000000)), var_max_width.clone(), var_max_height.clone())
}

fn wp_max_upload_size() rt.PhpVal {
	mut var_u_bytes := rt.new_null()
	mut var_p_bytes := rt.new_null()
	var_u_bytes = rt.call_function('wp_convert_hr_to_bytes', [
		rt.call_function('ini_get', [rt.new_string('upload_max_filesize')]),
	])
	var_p_bytes = rt.call_function('wp_convert_hr_to_bytes', [
		rt.call_function('ini_get', [rt.new_string('post_max_size')]),
	])
	return rt.call_function('apply_filters', [rt.new_string('upload_size_limit'),
		rt.call_function('min', [var_u_bytes.clone(), var_p_bytes.clone()]),
		var_u_bytes.clone(), var_p_bytes.clone()])
}

fn wp_get_image_editor(var_path rt.PhpVal, var_args rt.PhpVal) rt.PhpVal {
	mut var_file_info := rt.new_null()
	mut var_output_format := rt.new_null()
	mut var_implementation := rt.new_null()
	mut var_editor := rt.new_null()
	mut var_loaded := rt.new_null()
	var_args.array_set('path', var_path.clone())
	if !(var_args.array_isset(rt.new_string('mime_type'))) {
		var_file_info = rt.call_function('wp_check_filetype', [
			var_args.array_get(rt.new_string('path')),
		])
		if !var_file_info.is_null() && rt.is_true(var_file_info.array_get(rt.new_string('type'))) {
			var_args.array_set('mime_type', var_file_info.array_get(rt.new_string('type')))
		}
	}
	if var_args.array_isset(rt.new_string('mime_type')) {
		var_output_format = wp_get_image_editor_output_format(var_path.clone(),
			var_args.array_get(rt.new_string('mime_type')))
		if var_output_format.array_isset(var_args.array_get(rt.new_string('mime_type'))) {
			var_args.array_set('output_mime_type',
				var_output_format.array_get(var_args.array_get(rt.new_string('mime_type'))))
		}
	}
	var_implementation = _wp_image_editor_choose(var_args.clone())
	if rt.is_true(var_implementation) {
		var_editor = rt.create_object_dynamically(var_implementation, [
			var_path.clone()])
		var_loaded = rt.call_method(var_editor, 'load', []rt.PhpVal{})
		if rt.is_true(rt.call_function('is_wp_error', [var_loaded.clone()])) {
			return var_loaded.clone()
		}
		return var_editor.clone()
	}
	return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('image_no_editor'), rt.call_function('__', [
		rt.new_string('No editor could be selected.'),
	])))
}

fn wp_image_editor_supports(var_args rt.PhpVal) bool {
	return (_wp_image_editor_choose(var_args.clone())).to_bool()
}

fn _wp_image_editor_choose(var_args rt.PhpVal) rt.PhpVal {
	mut var_implementations := rt.new_null()
	mut var_editors := rt.new_null()
	mut var_cache_key := ''
	mut var_editor := rt.new_null()
	mut var_implementation := rt.new_null()
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/class-wp-image-editor.php',
		'4')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/class-wp-image-editor-gd.php',
		'4')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/class-wp-image-editor-imagick.php',
		'4')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/class-avif-info.php',
		'4')
	var_implementations = rt.call_function('apply_filters', [
		rt.new_string('wp_image_editors'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'WP_Image_Editor_Imagick' },
			rt.ArrayItem{ key: none, val: 'WP_Image_Editor_GD' }]),
	])
	var_editors = rt.call_function('wp_cache_get', [
		rt.new_string('wp_image_editor_choose'),
		rt.new_string('image_editor'),
	])
	if !(var_editors.clone().is_array()) {
		var_editors = rt.new_array()
	}
	var_cache_key = md5.hexhash(rt.call_function('serialize', [
		rt.create_array([rt.ArrayItem{ key: none, val: var_args },
			rt.ArrayItem{ key: none, val: var_implementations }]),
	]).to_string())
	if var_editors.array_isset(rt.new_string(var_cache_key.str())) {
		return var_editors.array_get(rt.new_string(var_cache_key.str()))
	}
	var_editor = rt.new_bool(false)
	mut iter_30 := var_implementations.iterator()
	for {
		item_30 := iter_30.next() or { break }
		mut var_implementation_shadow := item_30.val
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('call_user_func', [
			rt.create_array([rt.ArrayItem{ key: none, val: var_implementation_shadow },
				rt.ArrayItem{ key: none, val: 'test' }]),
			var_args.clone(),
		])))))
		{
			continue
		}
		if var_args.array_isset(rt.new_string('mime_type'))
			&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('call_user_func', [rt.create_array([rt.ArrayItem{
			key: none
			val: var_implementation_shadow
		}, rt.ArrayItem{ key: none, val: 'supports_mime_type' }]), var_args.array_get(rt.new_string('mime_type'))]))))) {
			continue
		}
		if var_args.array_isset(rt.new_string('methods'))
			&& rt.is_true(rt.call_function('array_diff', [var_args.array_get(rt.new_string('methods')), rt.call_function('get_class_methods', [var_implementation_shadow.clone()])])) {
			continue
		}
		if var_args.array_isset(rt.new_string('mime_type'))
			&& var_args.array_isset(rt.new_string('output_mime_type'))
			&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_args.array_get(rt.new_string('mime_type')), var_args.array_get(rt.new_string('output_mime_type'))))))
			&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('call_user_func', [rt.create_array([rt.ArrayItem{
			key: none
			val: var_implementation_shadow
		}, rt.ArrayItem{ key: none, val: 'supports_mime_type' }]), var_args.array_get(rt.new_string('output_mime_type'))]))))) {
			var_editor = var_implementation_shadow.clone()
			continue
		}
		var_editor = var_implementation_shadow.clone()
		break
	}
	var_editors.array_set(var_cache_key, var_editor.clone())
	rt.call_function('wp_cache_set', [rt.new_string('wp_image_editor_choose'),
		var_editors.clone(), rt.new_string('image_editor'), rt.get_constant('DAY_IN_SECONDS')])
	return var_editor.clone()
}

fn wp_plupload_default_settings() {
	mut var_wp_scripts := rt.new_null()
	mut var_data := rt.new_null()
	mut var_max_upload_size := rt.new_null()
	mut var_allowed_extensions := rt.new_null()
	mut var_extensions := rt.new_null()
	mut var_extension := rt.new_null()
	mut var_defaults := rt.new_null()
	mut var_params := rt.new_null()
	mut var_settings := rt.new_null()
	mut var_script := rt.new_null()
	var_wp_scripts = rt.call_function('wp_scripts', []rt.PhpVal{})
	var_data = rt.call_method(var_wp_scripts, 'get_data', [rt.new_string('wp-plupload'),
		rt.new_string('data')])
	if rt.is_true(var_data)
		&& rt.is_true(rt.call_function('str_contains', [var_data.clone(), rt.new_string('_wpPluploadSettings')])) {
		return
	}
	var_max_upload_size = wp_max_upload_size()
	var_allowed_extensions = rt.func_array_keys(rt.call_function('get_allowed_mime_types',
		[]rt.PhpVal{}))
	var_extensions = rt.new_array()
	mut iter_31 := var_allowed_extensions.iterator()
	for {
		item_31 := iter_31.next() or { break }
		mut var_extension_shadow := item_31.val
		var_extensions = rt.call_function('array_merge', [var_extensions.clone(),
			rt.call_function('explode', [rt.new_string('|'), var_extension_shadow.clone()])])
	}
	var_defaults = rt.create_array([
		rt.ArrayItem{ key: 'file_data_name', val: 'async-upload' },
		rt.ArrayItem{ key: 'url', val: rt.call_function('admin_url', [
			rt.new_string('async-upload.php'),
			rt.new_string('relative'),
		]) },
		rt.ArrayItem{ key: 'filters', val: rt.create_array([
			rt.ArrayItem{ key: 'max_file_size', val: var_max_upload_size.str() + 'b' },
			rt.ArrayItem{ key: 'mime_types', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.create_array([
					rt.ArrayItem{ key: 'extensions', val: rt.call_function('implode', [
						rt.new_string(','),
						var_extensions.clone(),
					]) },
				]) },
			]) },
		]) },
	])
	if rt.is_true(rt.call_function('wp_is_mobile', []rt.PhpVal{}))
		&& rt.is_true(rt.call_function('str_contains', [rt.get_superglobal('_SERVER').array_get(rt.new_string('HTTP_USER_AGENT')), rt.new_string('OS 7_')]))
		&& rt.is_true(rt.call_function('str_contains', [rt.get_superglobal('_SERVER').array_get(rt.new_string('HTTP_USER_AGENT')), rt.new_string('like Mac OS X')])) {
		var_defaults.array_set('multi_selection', false)
	}
	if !(wp_image_editor_supports(rt.create_array([
		rt.ArrayItem{ key: 'mime_type', val: 'image/webp' },
	]))) {
		var_defaults.array_set('webp_upload_error', true)
	}
	if !(wp_image_editor_supports(rt.create_array([
		rt.ArrayItem{ key: 'mime_type', val: 'image/avif' },
	]))) {
		var_defaults.array_set('avif_upload_error', true)
	}
	if !(wp_image_editor_supports(rt.create_array([
		rt.ArrayItem{ key: 'mime_type', val: 'image/heic' },
	]))) {
		var_defaults.array_set('heic_upload_error', true)
	}
	var_defaults = rt.call_function('apply_filters', [
		rt.new_string('plupload_default_settings'),
		var_defaults.clone(),
	])
	var_params = rt.create_array([
		rt.ArrayItem{ key: 'action', val: 'upload-attachment' },
	])
	var_params = rt.call_function('apply_filters', [
		rt.new_string('plupload_default_params'),
		var_params.clone(),
	])
	var_params.array_set('_wpnonce', rt.call_function('wp_create_nonce', [
		rt.new_string('media-form'),
	]))
	var_defaults.array_set('multipart_params', var_params.clone())
	var_settings = rt.create_array([rt.ArrayItem{ key: 'defaults', val: var_defaults },
		rt.ArrayItem{ key: 'browser', val: rt.create_array([
			rt.ArrayItem{ key: 'mobile', val: rt.call_function('wp_is_mobile', []rt.PhpVal{}) },
			rt.ArrayItem{ key: 'supported', val: rt.call_function('_device_can_upload',
				[]rt.PhpVal{}) },
		]) }, rt.ArrayItem{
			key: 'limitExceeded'
			val: rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{}))
				&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_upload_space_available', []rt.PhpVal{})))))
		}])
	var_script = rt.new_string('var _wpPluploadSettings = ' +
		(rt.call_function('wp_json_encode', [var_settings.clone(), rt.bitwise_or(rt.get_constant('JSON_HEX_TAG'), rt.get_constant('JSON_UNESCAPED_SLASHES'))])).str() +
		';')
	if rt.is_true(var_data) {
		var_script = rt.new_string('${var_data.to_string()}\n${var_script.to_string()}')
	}
	rt.call_method(var_wp_scripts, 'add_data', [rt.new_string('wp-plupload'),
		rt.new_string('data'), var_script.clone()])
}

fn wp_prepare_attachment_for_js(var_attachment_arg rt.PhpVal) rt.PhpVal {
	mut var_attachment := var_attachment_arg
	mut var_type := rt.new_null()
	mut var_subtype := rt.new_null()
	mut var_meta := rt.new_null()
	mut var_attachment_url := rt.new_null()
	mut var_base_url := rt.new_null()
	mut var_response := rt.new_null()
	mut var_author := rt.new_null()
	mut var_author_name := rt.new_null()
	mut var_post_parent := rt.new_null()
	mut var_attached_file := rt.new_null()
	mut var_bytes := rt.new_null()
	mut var_context := rt.new_null()
	mut var_sizes := rt.new_null()
	mut var_possible_sizes := rt.new_null()
	mut var_label := rt.new_null()
	mut var_size := rt.new_null()
	mut var_downsize := rt.new_null()
	mut var_size_meta := rt.new_null()
	mut var_key := rt.new_null()
	mut var_id := rt.new_null()
	mut var_src := rt.new_null()
	mut var_width := i64(0)
	mut var_height := i64(0)
	mut var_media_states := rt.new_null()
	var_attachment = rt.call_function('get_post', [var_attachment.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_attachment)))) {
		return rt.new_null()
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('attachment'), rt.get_property(var_attachment,
		'post_type')))))
	{
		return rt.new_null()
	}
	var_meta = rt.call_function('wp_get_attachment_metadata', [
		rt.get_property(var_attachment, 'ID'),
	])
	if rt.is_true(rt.call_function('str_contains', [
		rt.get_property(var_attachment, 'post_mime_type'),
		rt.new_string('/'),
	]))
	{
		mut list_tmp_17 := rt.call_function('explode', [rt.new_string('/'),
			rt.get_property(var_attachment, 'post_mime_type')])
		var_type = list_tmp_17.array_get(0)
		var_subtype = list_tmp_17.array_get(1)
	} else {
		mut list_tmp_18 := rt.create_array([
			rt.ArrayItem{ key: none, val: rt.get_property(var_attachment, 'post_mime_type') },
			rt.ArrayItem{ key: none, val: '' },
		])
		var_type = list_tmp_18.array_get(0)
		var_subtype = list_tmp_18.array_get(1)
	}
	var_attachment_url = rt.call_function('wp_get_attachment_url', [
		rt.get_property(var_attachment, 'ID'),
	])
	var_base_url = rt.call_function('str_replace', [
		rt.call_function('wp_basename', [var_attachment_url.clone()]),
		rt.new_string(''),
		var_attachment_url.clone(),
	])
	var_response = rt.create_array([
		rt.ArrayItem{ key: 'id', val: rt.get_property(var_attachment, 'ID') },
		rt.ArrayItem{ key: 'title', val: rt.get_property(var_attachment, 'post_title') },
		rt.ArrayItem{ key: 'filename', val: rt.call_function('wp_basename', [
			rt.call_function('get_attached_file', [rt.get_property(var_attachment, 'ID')]),
		]) },
		rt.ArrayItem{ key: 'url', val: var_attachment_url },
		rt.ArrayItem{ key: 'link', val: rt.call_function('get_attachment_link', [
			rt.get_property(var_attachment, 'ID'),
		]) },
		rt.ArrayItem{ key: 'alt', val: rt.call_function('get_post_meta', [
			rt.get_property(var_attachment, 'ID'),
			rt.new_string('_wp_attachment_image_alt'),
			rt.new_bool(true),
		]) },
		rt.ArrayItem{ key: 'author', val: rt.get_property(var_attachment, 'post_author') },
		rt.ArrayItem{ key: 'description', val: rt.get_property(var_attachment, 'post_content') },
		rt.ArrayItem{ key: 'caption', val: rt.get_property(var_attachment, 'post_excerpt') },
		rt.ArrayItem{ key: 'name', val: rt.get_property(var_attachment, 'post_name') },
		rt.ArrayItem{ key: 'status', val: rt.get_property(var_attachment, 'post_status') },
		rt.ArrayItem{ key: 'uploadedTo', val: rt.get_property(var_attachment, 'post_parent') },
		rt.ArrayItem{ key: 'date', val: rt.mul(rt.call_function('strtotime', [
			rt.get_property(var_attachment, 'post_date_gmt'),
		]), rt.new_int(1000)) },
		rt.ArrayItem{ key: 'modified', val: rt.mul(rt.call_function('strtotime', [
			rt.get_property(var_attachment, 'post_modified_gmt'),
		]), rt.new_int(1000)) },
		rt.ArrayItem{ key: 'menuOrder', val: rt.get_property(var_attachment, 'menu_order') },
		rt.ArrayItem{ key: 'mime', val: rt.get_property(var_attachment, 'post_mime_type') },
		rt.ArrayItem{ key: 'type', val: var_type },
		rt.ArrayItem{ key: 'subtype', val: var_subtype },
		rt.ArrayItem{ key: 'icon', val: rt.call_function('wp_mime_type_icon', [
			rt.get_property(var_attachment, 'ID'),
			rt.new_string('.svg'),
		]) },
		rt.ArrayItem{ key: 'dateFormatted', val: rt.call_function('mysql2date', [
			rt.call_function('__', [rt.new_string('F j, Y')]),
			rt.get_property(var_attachment, 'post_date'),
		]) },
		rt.ArrayItem{ key: 'nonces', val: rt.create_array([
			rt.ArrayItem{ key: 'update', val: false },
			rt.ArrayItem{ key: 'delete', val: false },
			rt.ArrayItem{ key: 'edit', val: false },
		]) },
		rt.ArrayItem{ key: 'editLink', val: false },
		rt.ArrayItem{ key: 'meta', val: false },
	])
	var_author = create_wp_user(rt.get_property(var_attachment, 'post_author'))
	if rt.is_true(var_author.exists()) {
		var_author_name = if rt.is_true(rt.get_property(var_author, 'display_name')) {
			rt.get_property(var_author, 'display_name')
		} else {
			rt.get_property(var_author, 'nickname')
		}
		var_response.array_set('authorName', rt.call_function('html_entity_decode', [
			var_author_name.clone(),
			rt.get_constant('ENT_QUOTES'),
			rt.call_function('get_bloginfo', [rt.new_string('charset')]),
		]))
		var_response.array_set('authorLink', rt.call_function('get_edit_user_link', [
			rt.get_property(var_author, 'ID'),
		]))
	} else {
		var_response.array_set('authorName', rt.call_function('__', [
			rt.new_string('(no author)'),
		]))
	}
	if rt.is_true(rt.get_property(var_attachment, 'post_parent')) {
		var_post_parent = rt.call_function('get_post', [
			rt.get_property(var_attachment, 'post_parent'),
		])
		if rt.is_true(var_post_parent)
			&& rt.is_true(rt.call_function('current_user_can', [rt.new_string('read_post'), rt.get_property(var_attachment, 'post_parent')])) {
			var_response.array_set('uploadedToTitle', if rt.is_true(rt.get_property(var_post_parent, 'post_title')) { rt.get_property(var_post_parent, 'post_title') } else { rt.call_function('__', [
					rt.new_string('(no title)'),
				]) })
			var_response.array_set('uploadedToLink', rt.call_function('get_edit_post_link', [
				rt.get_property(var_attachment, 'post_parent'),
				rt.new_string('raw'),
			]))
		}
	}
	var_attached_file = rt.call_function('get_attached_file', [
		rt.get_property(var_attachment, 'ID'),
	])
	if var_meta.array_isset(rt.new_string('filesize')) {
		var_bytes = var_meta.array_get(rt.new_string('filesize'))
	} else if rt.is_true(rt.call_function('file_exists', [var_attached_file.clone()])) {
		var_bytes = rt.call_function('wp_filesize', [var_attached_file.clone()])
	} else {
		var_bytes = rt.new_string('')
	}
	if rt.is_true(var_bytes) {
		var_response.array_set('filesizeInBytes', var_bytes.clone())
		var_response.array_set('filesizeHumanReadable', rt.call_function('size_format', [
			var_bytes.clone(),
		]))
	}
	var_context = rt.call_function('get_post_meta', [
		rt.get_property(var_attachment, 'ID'),
		rt.new_string('_wp_attachment_context'),
		rt.new_bool(true),
	])
	var_response.array_set('context', if rt.is_true(var_context) {
		var_context
	} else {
		rt.new_string('')
	})
	if rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_post'),
		rt.get_property(var_attachment, 'ID')]))
	{
		var_response.array_get_mut('nonces').array_set('update', rt.call_function('wp_create_nonce', [
			rt.new_string('update-post_' + (rt.get_property(var_attachment, 'ID')).str()),
		]))
		var_response.array_get_mut('nonces').array_set('edit', rt.call_function('wp_create_nonce', [
			rt.new_string('image_editor-' + (rt.get_property(var_attachment, 'ID')).str()),
		]))
		var_response.array_set('editLink', rt.call_function('get_edit_post_link', [
			rt.get_property(var_attachment, 'ID'),
			rt.new_string('raw'),
		]))
	}
	if rt.is_true(rt.call_function('current_user_can', [rt.new_string('delete_post'),
		rt.get_property(var_attachment, 'ID')]))
	{
		var_response.array_get_mut('nonces').array_set('delete', rt.call_function('wp_create_nonce', [
			rt.new_string('delete-post_' + (rt.get_property(var_attachment, 'ID')).str()),
		]))
	}
	if rt.is_true(var_meta) && rt.is_true(rt.identical(rt.new_string('image'), var_type))
		|| !(!rt.is_true(var_meta.array_get(rt.new_string('sizes')))) {
		var_sizes = rt.new_array()
		var_possible_sizes = rt.call_function('apply_filters', [
			rt.new_string('image_size_names_choose'),
			rt.create_array([
				rt.ArrayItem{ key: 'thumbnail', val: rt.call_function('__', [
					rt.new_string('Thumbnail'),
				]) },
				rt.ArrayItem{ key: 'medium', val: rt.call_function('__', [
					rt.new_string('Medium'),
				]) },
				rt.ArrayItem{ key: 'large', val: rt.call_function('__', [
					rt.new_string('Large'),
				]) },
				rt.ArrayItem{ key: 'full', val: rt.call_function('__', [
					rt.new_string('Full Size'),
				]) },
			]),
		])
		var_possible_sizes.array_unset(rt.new_string('full'))
		mut iter_32 := var_possible_sizes.iterator()
		for {
			item_32 := iter_32.next() or { break }
			mut var_label_shadow := item_32.val
			mut var_size_shadow := item_32.key
			var_downsize = rt.call_function('apply_filters', [
				rt.new_string('image_downsize'),
				rt.new_bool(false),
				rt.get_property(var_attachment, 'ID'),
				var_size_shadow.clone(),
			])
			if rt.is_true(var_downsize) {
				if !rt.is_true(var_downsize.array_get(rt.new_int(3))) {
					continue
				}
				var_sizes.array_set(var_size_shadow, rt.create_array([
					rt.ArrayItem{ key: 'height', val: var_downsize.array_get(rt.new_int(2)) },
					rt.ArrayItem{ key: 'width', val: var_downsize.array_get(rt.new_int(1)) },
					rt.ArrayItem{ key: 'url', val: var_downsize.array_get(rt.new_int(0)) },
					rt.ArrayItem{
						key: 'orientation'
						val: if rt.is_true(rt.greater(var_downsize.array_get(rt.new_int(2)),
							var_downsize.array_get(rt.new_int(1))))
						{
							'portrait'
						} else {
							'landscape'
						}
					},
				]))
			} else if var_meta.array_get(rt.new_string('sizes')).array_isset(var_size_shadow) {
				var_size_meta =
					var_meta.array_get(rt.new_string('sizes')).array_get(var_size_shadow)
				mut list_tmp_19 := image_constrain_size_for_editor(var_size_meta.array_get(rt.new_string('width')),
					var_size_meta.array_get(rt.new_string('height')), var_size_shadow.clone(),
					rt.new_string('edit'))
				var_width = list_tmp_19.array_get(0)
				var_height = list_tmp_19.array_get(1)
				var_sizes.array_set(var_size_shadow, rt.create_array([
					rt.ArrayItem{ key: 'height', val: var_height },
					rt.ArrayItem{ key: 'width', val: var_width },
					rt.ArrayItem{ key: 'url', val: var_base_url.str() +
						(var_size_meta.array_get(rt.new_string('file'))).str() },
					rt.ArrayItem{
						key: 'orientation'
						val: if var_height > var_width { 'portrait' } else { 'landscape' }
					},
				]))
			}
		}
		if rt.is_true(rt.identical(rt.new_string('image'), var_type)) {
			if !(!rt.is_true(var_meta.array_get(rt.new_string('original_image')))) {
				var_response.array_set('originalImageURL', rt.call_function('wp_get_original_image_url', [
					rt.get_property(var_attachment, 'ID'),
				]))
				var_response.array_set('originalImageName', rt.call_function('wp_basename', [
					rt.call_function('wp_get_original_image_path', [
						rt.get_property(var_attachment, 'ID'),
					]),
				]))
			}
			var_sizes.array_set('full', rt.create_array([
				rt.ArrayItem{ key: 'url', val: var_attachment_url },
			]))
			if var_meta.array_isset(rt.new_string('height'))
				&& var_meta.array_isset(rt.new_string('width')) {
				var_sizes.array_get_mut('full').array_set('height',
					var_meta.array_get(rt.new_string('height')))
				var_sizes.array_get_mut('full').array_set('width',
					var_meta.array_get(rt.new_string('width')))
				var_sizes.array_get_mut('full').array_set('orientation', if rt.is_true(rt.greater(var_meta.array_get(rt.new_string('height')),
					var_meta.array_get(rt.new_string('width'))))
				{
					'portrait'
				} else {
					'landscape'
				})
			}
			var_response = rt.call_function('array_merge', [var_response.clone(),
				var_sizes.array_get(rt.new_string('full'))])
		} else if rt.is_true(var_meta.array_get(rt.new_string('sizes')).array_get(rt.new_string('full')).array_get(rt.new_string('file'))) {
			var_sizes.array_set('full', rt.create_array([
				rt.ArrayItem{
					key: 'url'
					val: var_base_url.str() +(var_meta.array_get(rt.new_string('sizes')).array_get(rt.new_string('full')).array_get(rt.new_string('file'))).str()
				},
				rt.ArrayItem{
					key: 'height'
					val: var_meta.array_get(rt.new_string('sizes')).array_get(rt.new_string('full')).array_get(rt.new_string('height'))
				},
				rt.ArrayItem{
					key: 'width'
					val: var_meta.array_get(rt.new_string('sizes')).array_get(rt.new_string('full')).array_get(rt.new_string('width'))
				},
				rt.ArrayItem{
					key: 'orientation'
					val: if rt.is_true(rt.greater(var_meta.array_get(rt.new_string('sizes')).array_get(rt.new_string('full')).array_get(rt.new_string('height')),
						var_meta.array_get(rt.new_string('sizes')).array_get(rt.new_string('full')).array_get(rt.new_string('width'))))
					{
						'portrait'
					} else {
						'landscape'
					}
				},
			]))
		}
		var_response = rt.call_function('array_merge', [var_response.clone(),
			rt.create_array([rt.ArrayItem{ key: 'sizes', val: var_sizes }])])
	}
	if rt.is_true(var_meta) && rt.is_true(rt.identical(rt.new_string('video'), var_type)) {
		if var_meta.array_isset(rt.new_string('width')) {
			var_response.array_set('width',
				rt.new_int((var_meta.array_get(rt.new_string('width'))).to_i64()))
		}
		if var_meta.array_isset(rt.new_string('height')) {
			var_response.array_set('height',
				rt.new_int((var_meta.array_get(rt.new_string('height'))).to_i64()))
		}
	}
	if rt.is_true(var_meta) && rt.is_true(rt.identical(rt.new_string('audio'), var_type))
		|| rt.is_true(rt.identical(rt.new_string('video'), var_type)) {
		if var_meta.array_isset(rt.new_string('length_formatted')) {
			var_response.array_set('fileLength',
				var_meta.array_get(rt.new_string('length_formatted')))
			var_response.array_set('fileLengthHumanReadable', rt.call_function('human_readable_duration', [
				var_meta.array_get(rt.new_string('length_formatted')),
			]))
		}
		var_response.array_set('meta', rt.new_array())
		mut iter_33 := wp_get_attachment_id3_keys(var_attachment.clone(), 'js').iterator()
		for {
			item_33 := iter_33.next() or { break }
			mut var_label_shadow := item_33.val
			mut var_key_shadow := item_33.key
			var_response.array_get_mut('meta').array_set(var_key_shadow, false)
			if !(!rt.is_true(var_meta.array_get(var_key_shadow))) {
				var_response.array_get_mut('meta').array_set(var_key_shadow,
					var_meta.array_get(var_key_shadow))
			}
		}
		var_id = rt.call_function('get_post_thumbnail_id', [
			rt.get_property(var_attachment, 'ID'),
		])
		if !(!rt.is_true(var_id)) {
			mut list_tmp_20 := wp_get_attachment_image_src(var_id.clone(), 'full', false)
			var_src = list_tmp_20.array_get(0)
			var_width = list_tmp_20.array_get(1)
			var_height = list_tmp_20.array_get(2)
			var_response.array_set('image', rt.call_function('compact', [
				rt.new_string('src'),
				rt.new_string('width'),
				rt.new_string('height'),
			]))
			mut list_tmp_21 := wp_get_attachment_image_src(var_id.clone(), 'thumbnail', false)
			var_src = list_tmp_21.array_get(0)
			var_width = list_tmp_21.array_get(1)
			var_height = list_tmp_21.array_get(2)
			var_response.array_set('thumb', rt.call_function('compact', [
				rt.new_string('src'),
				rt.new_string('width'),
				rt.new_string('height'),
			]))
		} else {
			var_src = rt.call_function('wp_mime_type_icon', [
				rt.get_property(var_attachment, 'ID'),
				rt.new_string('.svg'),
			])
			var_width = 48
			var_height = 64
			var_response.array_set('image', rt.call_function('compact', [
				rt.new_string('src'),
				rt.new_string('width'),
				rt.new_string('height'),
			]))
			var_response.array_set('thumb', rt.call_function('compact', [
				rt.new_string('src'),
				rt.new_string('width'),
				rt.new_string('height'),
			]))
		}
	}
	if rt.is_true(rt.call_function('function_exists', [
		rt.new_string('get_compat_media_markup'),
	]))
	{
		var_response.array_set('compat', rt.call_function('get_compat_media_markup', [
			rt.get_property(var_attachment, 'ID'),
			rt.create_array([rt.ArrayItem{ key: 'in_modal', val: true }]),
		]))
	}
	if rt.is_true(rt.call_function('function_exists', [rt.new_string('get_media_states')])) {
		var_media_states = rt.call_function('get_media_states', [
			var_attachment.clone()])
		if !(!rt.is_true(var_media_states)) {
			var_response.array_set('mediaStates', rt.call_function('implode', [
				rt.new_string(', '),
				var_media_states.clone(),
			]))
		}
	}
	return rt.call_function('apply_filters', [
		rt.new_string('wp_prepare_attachment_for_js'),
		var_response.clone(),
		var_attachment.clone(),
		var_meta.clone(),
	])
}

fn wp_enqueue_media(var_args_arg rt.PhpVal) {
	mut var_args := var_args_arg
	mut var_content_width := rt.new_null()
	mut var_wpdb := rt.new_null()
	mut var_wp_locale := rt.new_null()
	mut var_defaults := rt.new_null()
	mut var_tabs := rt.new_null()
	mut var_props := map[string]rt.PhpVal{}
	mut var_exts := rt.new_null()
	mut var_mimes := rt.new_null()
	mut var_ext_mimes := rt.new_null()
	mut var_ext := rt.new_null()
	mut var_mime_match := rt.new_null()
	mut var_ext_preg := rt.new_null()
	mut var_show_audio_playlist := rt.new_null()
	mut var_show_video_playlist := rt.new_null()
	mut var_months := rt.new_null()
	mut var_month_year := rt.new_null()
	mut var_infinite_scrolling := rt.new_null()
	mut var_settings := rt.new_null()
	mut var_post := rt.new_null()
	mut var_thumbnail_support := false
	mut var_featured_image_id := rt.new_null()
	mut var_post_type_object := rt.new_null()
	mut var_strings := rt.new_null()
	if rt.is_true(rt.call_function('did_action', [rt.new_string('wp_enqueue_media')])) {
		return
	}
	var_defaults = rt.create_array([rt.ArrayItem{ key: 'post', val: rt.new_null() }])
	var_args = rt.call_function('wp_parse_args', [var_args.clone(),
		var_defaults.clone()])
	var_tabs = rt.create_array([rt.ArrayItem{ key: 'type', val: '' },
		rt.ArrayItem{ key: 'type_url', val: '' }, rt.ArrayItem{ key: 'gallery', val: '' },
		rt.ArrayItem{ key: 'library', val: '' }])
	var_tabs = rt.call_function('apply_filters', [rt.new_string('media_upload_tabs'),
		var_tabs.clone()])
	var_tabs.array_unset(rt.new_string('type'))
	var_tabs.array_unset(rt.new_string('type_url'))
	var_tabs.array_unset(rt.new_string('gallery'))
	var_tabs.array_unset(rt.new_string('library'))
	var_props = {
		'link':  rt.call_function('get_option', [
			rt.new_string('image_default_link_type'),
		])
		'align': rt.call_function('get_option', [rt.new_string('image_default_align')])
		'size':  rt.call_function('get_option', [rt.new_string('image_default_size')])
	}
	var_exts = rt.call_function('array_merge', [wp_get_audio_extensions(),
		wp_get_video_extensions()])
	var_mimes = rt.call_function('get_allowed_mime_types', []rt.PhpVal{})
	var_ext_mimes = rt.new_array()
	mut iter_34 := var_exts.iterator()
	for {
		item_34 := iter_34.next() or { break }
		mut var_ext_shadow := item_34.val
		mut iter_35 := var_mimes.iterator()
		for {
			item_35 := iter_35.next() or { break }
			mut var_mime_match_shadow := item_35.val
			mut var_ext_preg_shadow := item_35.key
			if rt.is_true(rt.call_function('preg_match', [
				rt.new_string('#' + var_ext_shadow.str() + '#i'),
				var_ext_preg_shadow.clone(),
			]))
			{
				var_ext_mimes.array_set(var_ext_shadow, var_mime_match_shadow.clone())
				break
			}
		}
	}
	var_show_audio_playlist = rt.call_function('apply_filters', [
		rt.new_string('media_library_show_audio_playlist'),
		rt.new_bool(true),
	])
	if rt.is_true(rt.identical(rt.new_null(), var_show_audio_playlist)) {
		var_show_audio_playlist = rt.call_method(var_wpdb, 'get_var', [
			rt.concat(rt.concat(rt.new_string('SELECT ID\n\t\t\tFROM '), rt.get_property(var_wpdb,
				'posts')),
				rt.new_string("\n\t\t\tWHERE post_type = 'attachment'\n\t\t\tAND post_mime_type LIKE 'audio%'\n\t\t\tLIMIT 1")),
		])
	}
	var_show_video_playlist = rt.call_function('apply_filters', [
		rt.new_string('media_library_show_video_playlist'),
		rt.new_bool(true),
	])
	if rt.is_true(rt.identical(rt.new_null(), var_show_video_playlist)) {
		var_show_video_playlist = rt.call_method(var_wpdb, 'get_var', [
			rt.concat(rt.concat(rt.new_string('SELECT ID\n\t\t\tFROM '), rt.get_property(var_wpdb,
				'posts')),
				rt.new_string("\n\t\t\tWHERE post_type = 'attachment'\n\t\t\tAND post_mime_type LIKE 'video%'\n\t\t\tLIMIT 1")),
		])
	}
	var_months = rt.call_function('apply_filters', [
		rt.new_string('media_library_months_with_files'),
		rt.new_null(),
	])
	if !(var_months.clone().is_array()) {
		var_months = rt.call_method(var_wpdb, 'get_results', [
			rt.call_method(var_wpdb, 'prepare', [
				rt.concat(rt.concat(rt.new_string('SELECT DISTINCT YEAR( post_date ) AS year, MONTH( post_date ) AS month\n\t\t\t\tFROM '), rt.get_property(var_wpdb,
					'posts')),
					rt.new_string('\n\t\t\t\tWHERE post_type = %s\n\t\t\t\tORDER BY post_date DESC')),
				rt.new_string('attachment'),
			]),
		])
	}
	mut iter_36 := var_months.iterator()
	for {
		item_36 := iter_36.next() or { break }
		mut var_month_year_shadow := item_36.val
		rt.set_property(var_month_year_shadow, 'text', rt.call_function('sprintf', [
			rt.call_function('__', [rt.new_string('%1$s %2$d')]),
			rt.call_method(var_wp_locale, 'get_month', [rt.get_property(var_month_year_shadow,
				'month')]),
			rt.get_property(var_month_year_shadow, 'year'),
		]))
	}
	var_infinite_scrolling = rt.call_function('apply_filters', [
		rt.new_string('media_library_infinite_scrolling'),
		rt.new_bool(false),
	])
	var_settings = rt.create_array([rt.ArrayItem{ key: 'tabs', val: var_tabs },
		rt.ArrayItem{ key: 'tabUrl', val: rt.call_function('add_query_arg', [
			rt.create_array([rt.ArrayItem{ key: 'chromeless', val: true }]),
			rt.call_function('admin_url', [rt.new_string('media-upload.php')]),
		]) }, rt.ArrayItem{ key: 'mimeTypes', val: rt.call_function('wp_list_pluck', [
			rt.call_function('get_post_mime_types', []rt.PhpVal{}),
			rt.new_int(0),
		]) }, rt.ArrayItem{ key: 'captions', val: !(rt.is_true(rt.call_function('apply_filters', [
			rt.new_string('disable_captions'),
			rt.new_string(''),
		]))) }, rt.ArrayItem{ key: 'nonce', val: rt.create_array([
			rt.ArrayItem{ key: 'sendToEditor', val: rt.call_function('wp_create_nonce', [
				rt.new_string('media-send-to-editor')]) },
			rt.ArrayItem{ key: 'setAttachmentThumbnail', val: rt.call_function('wp_create_nonce', [
				rt.new_string('set-attachment-thumbnail')]) },
		]) }, rt.ArrayItem{ key: 'post', val: rt.create_array([
			rt.ArrayItem{ key: 'id', val: 0 },
		]) }, rt.ArrayItem{ key: 'defaultProps', val: var_props },
		rt.ArrayItem{ key: 'attachmentCounts', val: rt.create_array([
			rt.ArrayItem{
				key: 'audio'
				val: if rt.is_true(var_show_audio_playlist) { 1 } else { 0 }
			},
			rt.ArrayItem{
				key: 'video'
				val: if rt.is_true(var_show_video_playlist) { 1 } else { 0 }
			},
		]) }, rt.ArrayItem{ key: 'oEmbedProxyUrl', val: rt.call_function('rest_url', [
			rt.new_string('oembed/1.0/proxy'),
		]) }, rt.ArrayItem{ key: 'embedExts', val: var_exts },
		rt.ArrayItem{ key: 'embedMimes', val: var_ext_mimes },
		rt.ArrayItem{ key: 'contentWidth', val: var_content_width },
		rt.ArrayItem{ key: 'months', val: var_months }, rt.ArrayItem{
			key: 'mediaTrash'
			val: if rt.is_true(rt.get_constant('MEDIA_TRASH')) { 1 } else { 0 }
		}, rt.ArrayItem{
			key: 'infiniteScrolling'
			val: if rt.is_true(var_infinite_scrolling) { 1 } else { 0 }
		}])
	var_post = rt.new_null()
	if var_args.array_isset(rt.new_string('post')) {
		var_post = rt.call_function('get_post', [var_args.array_get(rt.new_string('post'))])
		var_settings.array_set('post', rt.create_array([
			rt.ArrayItem{ key: 'id', val: rt.get_property(var_post, 'ID') },
			rt.ArrayItem{ key: 'nonce', val: rt.call_function('wp_create_nonce', [
				rt.new_string('update-post_' + (rt.get_property(var_post, 'ID')).str()),
			]) },
		]))
		var_thumbnail_support =
			rt.is_true(rt.call_function('current_theme_supports', [rt.new_string('post-thumbnails'), rt.get_property(var_post, 'post_type')]))
			&& rt.is_true(rt.call_function('post_type_supports', [rt.get_property(var_post, 'post_type'), rt.new_string('thumbnail')]))
		if !var_thumbnail_support
			&& rt.is_true(rt.identical(rt.new_string('attachment'), rt.get_property(var_post, 'post_type')))
			&& rt.is_true(rt.get_property(var_post, 'post_mime_type')) {
			if rt.is_true(rt.call_function('wp_attachment_is', [
				rt.new_string('audio'), var_post.clone()]))
			{
				var_thumbnail_support =
					rt.is_true(rt.call_function('post_type_supports', [rt.new_string('attachment:audio'), rt.new_string('thumbnail')]))
					|| rt.is_true(rt.call_function('current_theme_supports', [rt.new_string('post-thumbnails'), rt.new_string('attachment:audio')]))
			} else if rt.is_true(rt.call_function('wp_attachment_is', [
				rt.new_string('video'),
				var_post.clone(),
			]))
			{
				var_thumbnail_support =
					rt.is_true(rt.call_function('post_type_supports', [rt.new_string('attachment:video'), rt.new_string('thumbnail')]))
					|| rt.is_true(rt.call_function('current_theme_supports', [rt.new_string('post-thumbnails'), rt.new_string('attachment:video')]))
			}
		}
		if var_thumbnail_support {
			var_featured_image_id = rt.call_function('get_post_meta', [
				rt.get_property(var_post, 'ID'),
				rt.new_string('_thumbnail_id'),
				rt.new_bool(true),
			])
			var_settings.array_get_mut('post').array_set('featuredImageId', if rt.is_true(var_featured_image_id) {
				var_featured_image_id
			} else {
				-1
			})
		}
	}
	if rt.is_true(var_post) {
		var_post_type_object = rt.call_function('get_post_type_object', [
			rt.get_property(var_post, 'post_type'),
		])
	} else {
		var_post_type_object = rt.call_function('get_post_type_object', [
			rt.new_string('post'),
		])
	}
	var_strings = rt.create_array([
		rt.ArrayItem{ key: 'mediaFrameDefaultTitle', val: rt.call_function('__', [
			rt.new_string('Media'),
		]) },
		rt.ArrayItem{ key: 'url', val: rt.call_function('__', [
			rt.new_string('URL'),
		]) },
		rt.ArrayItem{ key: 'addMedia', val: rt.call_function('__', [
			rt.new_string('Add media'),
		]) },
		rt.ArrayItem{ key: 'search', val: rt.call_function('__', [
			rt.new_string('Search'),
		]) },
		rt.ArrayItem{ key: 'select', val: rt.call_function('__', [
			rt.new_string('Select'),
		]) },
		rt.ArrayItem{ key: 'cancel', val: rt.call_function('__', [
			rt.new_string('Cancel'),
		]) },
		rt.ArrayItem{ key: 'update', val: rt.call_function('__', [
			rt.new_string('Update'),
		]) },
		rt.ArrayItem{ key: 'replace', val: rt.call_function('__', [
			rt.new_string('Replace'),
		]) },
		rt.ArrayItem{ key: 'remove', val: rt.call_function('__', [
			rt.new_string('Remove'),
		]) },
		rt.ArrayItem{ key: 'back', val: rt.call_function('__', [
			rt.new_string('Back'),
		]) },
		rt.ArrayItem{ key: 'selected', val: rt.call_function('__', [
			rt.new_string('%d selected'),
		]) },
		rt.ArrayItem{ key: 'dragInfo', val: rt.call_function('__', [
			rt.new_string('Drag and drop to reorder media files.'),
		]) },
		rt.ArrayItem{ key: 'uploadFilesTitle', val: rt.call_function('__', [
			rt.new_string('Upload files'),
		]) },
		rt.ArrayItem{ key: 'uploadImagesTitle', val: rt.call_function('__', [
			rt.new_string('Upload images'),
		]) },
		rt.ArrayItem{ key: 'mediaLibraryTitle', val: rt.call_function('__', [
			rt.new_string('Media Library'),
		]) },
		rt.ArrayItem{ key: 'insertMediaTitle', val: rt.call_function('__', [
			rt.new_string('Add media'),
		]) },
		rt.ArrayItem{ key: 'createNewGallery', val: rt.call_function('__', [
			rt.new_string('Create a new gallery'),
		]) },
		rt.ArrayItem{ key: 'createNewPlaylist', val: rt.call_function('__', [
			rt.new_string('Create a new playlist'),
		]) },
		rt.ArrayItem{ key: 'createNewVideoPlaylist', val: rt.call_function('__', [
			rt.new_string('Create a new video playlist'),
		]) },
		rt.ArrayItem{ key: 'returnToLibrary', val: rt.call_function('__', [
			rt.new_string('&#8592; Go to library'),
		]) },
		rt.ArrayItem{ key: 'allMediaItems', val: rt.call_function('__', [
			rt.new_string('All media items'),
		]) },
		rt.ArrayItem{ key: 'allDates', val: rt.call_function('__', [
			rt.new_string('All dates'),
		]) },
		rt.ArrayItem{ key: 'noItemsFound', val: rt.call_function('__', [
			rt.new_string('No items found.'),
		]) },
		rt.ArrayItem{ key: 'insertIntoPost', val: rt.get_property(rt.get_property(var_post_type_object,
			'labels'), 'insert_into_item') },
		rt.ArrayItem{ key: 'unattached', val: rt.call_function('_x', [
			rt.new_string('Unattached'),
			rt.new_string('media items'),
		]) },
		rt.ArrayItem{ key: 'mine', val: rt.call_function('_x', [
			rt.new_string('Mine'),
			rt.new_string('media items'),
		]) },
		rt.ArrayItem{ key: 'trash', val: rt.call_function('_x', [
			rt.new_string('Trash'),
			rt.new_string('noun'),
		]) },
		rt.ArrayItem{ key: 'uploadedToThisPost', val: rt.get_property(rt.get_property(var_post_type_object,
			'labels'), 'uploaded_to_this_item') },
		rt.ArrayItem{ key: 'warnDelete', val: rt.call_function('__', [
			rt.new_string("You are about to permanently delete this item from your site.\nThis action cannot be undone.\n 'Cancel' to stop, 'OK' to delete."),
		]) },
		rt.ArrayItem{ key: 'warnBulkDelete', val: rt.call_function('__', [
			rt.new_string("You are about to permanently delete these items from your site.\nThis action cannot be undone.\n 'Cancel' to stop, 'OK' to delete."),
		]) },
		rt.ArrayItem{ key: 'warnBulkTrash', val: rt.call_function('__', [
			rt.new_string("You are about to trash these items.\n  'Cancel' to stop, 'OK' to delete."),
		]) },
		rt.ArrayItem{ key: 'bulkSelect', val: rt.call_function('__', [
			rt.new_string('Bulk select'),
		]) },
		rt.ArrayItem{ key: 'trashSelected', val: rt.call_function('__', [
			rt.new_string('Move to Trash'),
		]) },
		rt.ArrayItem{ key: 'restoreSelected', val: rt.call_function('__', [
			rt.new_string('Restore from Trash'),
		]) },
		rt.ArrayItem{ key: 'deletePermanently', val: rt.call_function('__', [
			rt.new_string('Delete permanently'),
		]) },
		rt.ArrayItem{ key: 'errorDeleting', val: rt.call_function('__', [
			rt.new_string('Error in deleting the attachment.'),
		]) },
		rt.ArrayItem{ key: 'apply', val: rt.call_function('__', [
			rt.new_string('Apply'),
		]) },
		rt.ArrayItem{ key: 'filterByDate', val: rt.call_function('__', [
			rt.new_string('Filter by date'),
		]) },
		rt.ArrayItem{ key: 'filterByType', val: rt.call_function('__', [
			rt.new_string('Filter by type'),
		]) },
		rt.ArrayItem{ key: 'searchLabel', val: rt.call_function('__', [
			rt.new_string('Search media'),
		]) },
		rt.ArrayItem{ key: 'searchMediaLabel', val: rt.call_function('__', [
			rt.new_string('Search media'),
		]) },
		rt.ArrayItem{ key: 'searchMediaPlaceholder', val: rt.call_function('__', [
			rt.new_string('Search media items...'),
		]) },
		rt.ArrayItem{ key: 'mediaFound', val: rt.call_function('__', [
			rt.new_string('Number of media items found: %d'),
		]) },
		rt.ArrayItem{ key: 'noMedia', val: rt.call_function('__', [
			rt.new_string('No media items found.'),
		]) },
		rt.ArrayItem{ key: 'noMediaTryNewSearch', val: rt.call_function('__', [
			rt.new_string('No media items found. Try a different search.'),
		]) },
		rt.ArrayItem{ key: 'attachmentDetails', val: rt.call_function('__', [
			rt.new_string('Attachment details'),
		]) },
		rt.ArrayItem{ key: 'insertFromUrlTitle', val: rt.call_function('__', [
			rt.new_string('Insert from URL'),
		]) },
		rt.ArrayItem{ key: 'setFeaturedImageTitle', val: rt.get_property(rt.get_property(var_post_type_object,
			'labels'), 'featured_image') },
		rt.ArrayItem{ key: 'setFeaturedImage', val: rt.get_property(rt.get_property(var_post_type_object,
			'labels'), 'set_featured_image') },
		rt.ArrayItem{ key: 'createGalleryTitle', val: rt.call_function('__', [
			rt.new_string('Create gallery'),
		]) },
		rt.ArrayItem{ key: 'editGalleryTitle', val: rt.call_function('__', [
			rt.new_string('Edit gallery'),
		]) },
		rt.ArrayItem{ key: 'cancelGalleryTitle', val: rt.call_function('__', [
			rt.new_string('&#8592; Cancel gallery'),
		]) },
		rt.ArrayItem{ key: 'insertGallery', val: rt.call_function('__', [
			rt.new_string('Insert gallery'),
		]) },
		rt.ArrayItem{ key: 'updateGallery', val: rt.call_function('__', [
			rt.new_string('Update gallery'),
		]) },
		rt.ArrayItem{ key: 'addToGallery', val: rt.call_function('__', [
			rt.new_string('Add to gallery'),
		]) },
		rt.ArrayItem{ key: 'addToGalleryTitle', val: rt.call_function('__', [
			rt.new_string('Add to gallery'),
		]) },
		rt.ArrayItem{ key: 'reverseOrder', val: rt.call_function('__', [
			rt.new_string('Reverse order'),
		]) },
		rt.ArrayItem{ key: 'imageDetailsTitle', val: rt.call_function('__', [
			rt.new_string('Image details'),
		]) },
		rt.ArrayItem{ key: 'imageReplaceTitle', val: rt.call_function('__', [
			rt.new_string('Replace image'),
		]) },
		rt.ArrayItem{ key: 'imageDetailsCancel', val: rt.call_function('__', [
			rt.new_string('Cancel edit'),
		]) },
		rt.ArrayItem{ key: 'editImage', val: rt.call_function('__', [
			rt.new_string('Edit image'),
		]) },
		rt.ArrayItem{ key: 'chooseImage', val: rt.call_function('__', [
			rt.new_string('Choose image'),
		]) },
		rt.ArrayItem{ key: 'selectAndCrop', val: rt.call_function('__', [
			rt.new_string('Select and crop'),
		]) },
		rt.ArrayItem{ key: 'skipCropping', val: rt.call_function('__', [
			rt.new_string('Skip cropping'),
		]) },
		rt.ArrayItem{ key: 'cropImage', val: rt.call_function('__', [
			rt.new_string('Crop image'),
		]) },
		rt.ArrayItem{ key: 'cropYourImage', val: rt.call_function('__', [
			rt.new_string('Crop your image'),
		]) },
		rt.ArrayItem{ key: 'cropping', val: rt.call_function('__', [
			rt.new_string('Cropping&hellip;'),
		]) },
		rt.ArrayItem{ key: 'suggestedDimensions', val: rt.call_function('__', [
			rt.new_string('Suggested image dimensions: %1$s by %2$s pixels.'),
		]) },
		rt.ArrayItem{ key: 'cropError', val: rt.call_function('__', [
			rt.new_string('There has been an error cropping your image.'),
		]) },
		rt.ArrayItem{ key: 'audioDetailsTitle', val: rt.call_function('__', [
			rt.new_string('Audio details'),
		]) },
		rt.ArrayItem{ key: 'audioReplaceTitle', val: rt.call_function('__', [
			rt.new_string('Replace audio'),
		]) },
		rt.ArrayItem{ key: 'audioAddSourceTitle', val: rt.call_function('__', [
			rt.new_string('Add audio source'),
		]) },
		rt.ArrayItem{ key: 'audioDetailsCancel', val: rt.call_function('__', [
			rt.new_string('Cancel edit'),
		]) },
		rt.ArrayItem{ key: 'videoDetailsTitle', val: rt.call_function('__', [
			rt.new_string('Video details'),
		]) },
		rt.ArrayItem{ key: 'videoReplaceTitle', val: rt.call_function('__', [
			rt.new_string('Replace video'),
		]) },
		rt.ArrayItem{ key: 'videoAddSourceTitle', val: rt.call_function('__', [
			rt.new_string('Add video source'),
		]) },
		rt.ArrayItem{ key: 'videoDetailsCancel', val: rt.call_function('__', [
			rt.new_string('Cancel edit'),
		]) },
		rt.ArrayItem{ key: 'videoSelectPosterImageTitle', val: rt.call_function('__', [
			rt.new_string('Select poster image'),
		]) },
		rt.ArrayItem{ key: 'videoAddTrackTitle', val: rt.call_function('__', [
			rt.new_string('Add subtitles'),
		]) },
		rt.ArrayItem{ key: 'playlistDragInfo', val: rt.call_function('__', [
			rt.new_string('Drag and drop to reorder tracks.'),
		]) },
		rt.ArrayItem{ key: 'createPlaylistTitle', val: rt.call_function('__', [
			rt.new_string('Create audio playlist'),
		]) },
		rt.ArrayItem{ key: 'editPlaylistTitle', val: rt.call_function('__', [
			rt.new_string('Edit audio playlist'),
		]) },
		rt.ArrayItem{ key: 'cancelPlaylistTitle', val: rt.call_function('__', [
			rt.new_string('&#8592; Cancel audio playlist'),
		]) },
		rt.ArrayItem{ key: 'insertPlaylist', val: rt.call_function('__', [
			rt.new_string('Insert audio playlist'),
		]) },
		rt.ArrayItem{ key: 'updatePlaylist', val: rt.call_function('__', [
			rt.new_string('Update audio playlist'),
		]) },
		rt.ArrayItem{ key: 'addToPlaylist', val: rt.call_function('__', [
			rt.new_string('Add to audio playlist'),
		]) },
		rt.ArrayItem{ key: 'addToPlaylistTitle', val: rt.call_function('__', [
			rt.new_string('Add to Audio Playlist'),
		]) },
		rt.ArrayItem{ key: 'videoPlaylistDragInfo', val: rt.call_function('__', [
			rt.new_string('Drag and drop to reorder videos.'),
		]) },
		rt.ArrayItem{ key: 'createVideoPlaylistTitle', val: rt.call_function('__', [
			rt.new_string('Create video playlist'),
		]) },
		rt.ArrayItem{ key: 'editVideoPlaylistTitle', val: rt.call_function('__', [
			rt.new_string('Edit video playlist'),
		]) },
		rt.ArrayItem{ key: 'cancelVideoPlaylistTitle', val: rt.call_function('__', [
			rt.new_string('&#8592; Cancel video playlist'),
		]) },
		rt.ArrayItem{ key: 'insertVideoPlaylist', val: rt.call_function('__', [
			rt.new_string('Insert video playlist'),
		]) },
		rt.ArrayItem{ key: 'updateVideoPlaylist', val: rt.call_function('__', [
			rt.new_string('Update video playlist'),
		]) },
		rt.ArrayItem{ key: 'addToVideoPlaylist', val: rt.call_function('__', [
			rt.new_string('Add to video playlist'),
		]) },
		rt.ArrayItem{ key: 'addToVideoPlaylistTitle', val: rt.call_function('__', [
			rt.new_string('Add to video Playlist'),
		]) },
		rt.ArrayItem{ key: 'filterAttachments', val: rt.call_function('__', [
			rt.new_string('Filter media'),
		]) },
		rt.ArrayItem{ key: 'attachmentsList', val: rt.call_function('__', [
			rt.new_string('Media list'),
		]) },
	])
	var_settings = rt.call_function('apply_filters', [
		rt.new_string('media_view_settings'),
		var_settings.clone(),
		var_post.clone(),
	])
	var_strings = rt.call_function('apply_filters', [rt.new_string('media_view_strings'),
		var_strings.clone(), var_post.clone()])
	var_strings.array_set('settings', var_settings.clone())
	rt.call_function('wp_enqueue_script', [rt.new_string('media-editor')])
	rt.call_function('wp_localize_script', [rt.new_string('media-views'),
		rt.new_string('_wpMediaViewsL10n'), var_strings.clone()])
	rt.call_function('wp_enqueue_script', [rt.new_string('media-audiovideo')])
	rt.call_function('wp_enqueue_style', [rt.new_string('media-views')])
	if rt.is_true(rt.call_function('is_admin', []rt.PhpVal{})) {
		rt.call_function('wp_enqueue_script', [rt.new_string('mce-view')])
		rt.call_function('wp_enqueue_script', [rt.new_string('image-edit')])
	}
	rt.call_function('wp_enqueue_style', [rt.new_string('imgareaselect')])
	wp_plupload_default_settings()
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/media-template.php',
		'4')
	rt.call_function('add_action', [rt.new_string('admin_footer'),
		rt.new_string('wp_print_media_templates')])
	rt.call_function('add_action', [rt.new_string('wp_footer'),
		rt.new_string('wp_print_media_templates')])
	rt.call_function('add_action', [
		rt.new_string('customize_controls_print_footer_scripts'),
		rt.new_string('wp_print_media_templates'),
	])
	rt.call_function('do_action', [rt.new_string('wp_enqueue_media')])
}

fn get_attached_media(type string, post i64) rt.PhpVal {
	mut var_type := type
	mut var_post := post
	mut var_args := rt.new_null()
	mut var_children := rt.new_null()
	var_post = (rt.call_function('get_post', [rt.new_int(var_post)])).to_i64()
	if !(var_post != 0) {
		return rt.new_array()
	}
	var_args = rt.create_array([
		rt.ArrayItem{ key: 'post_parent', val: rt.get_property(rt.new_int(var_post), 'ID') },
		rt.ArrayItem{ key: 'post_type', val: 'attachment' },
		rt.ArrayItem{ key: 'post_mime_type', val: type },
		rt.ArrayItem{ key: 'posts_per_page', val: -1 },
		rt.ArrayItem{ key: 'orderby', val: 'menu_order' },
		rt.ArrayItem{ key: 'order', val: 'ASC' },
	])
	var_args = rt.call_function('apply_filters', [
		rt.new_string('get_attached_media_args'),
		var_args.clone(),
		rt.new_string(type),
		rt.new_int(var_post),
	])
	var_children = rt.call_function('get_children', [var_args.clone()])
	return rt.cast_array(rt.call_function('apply_filters', [
		rt.new_string('get_attached_media'),
		var_children.clone(),
		rt.new_string(type),
		rt.new_int(var_post),
	]))
}

fn get_media_embedded_in_content(var_content rt.PhpVal, var_types_arg rt.PhpVal) rt.PhpVal {
	mut var_types := var_types_arg
	mut var_matches := []rt.PhpVal{}
	mut var_html := rt.new_null()
	mut var_allowed_media_types := rt.new_null()
	mut var_tags := rt.new_null()
	mut var_match := rt.new_null()
	var_html = rt.new_array()
	var_allowed_media_types = rt.call_function('apply_filters', [
		rt.new_string('media_embedded_in_content_allowed_types'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'audio' },
			rt.ArrayItem{ key: none, val: 'video' }, rt.ArrayItem{ key: none, val: 'object' },
			rt.ArrayItem{ key: none, val: 'embed' }, rt.ArrayItem{ key: none, val: 'iframe' }]),
	])
	if !(!rt.is_true(var_types)) {
		if !(rt.create_array_from_list(var_types).is_array()) {
			var_types = [var_types]
		}
		var_allowed_media_types = rt.call_function('array_intersect', [
			var_allowed_media_types.clone(), rt.create_array_from_list(var_types)])
	}
	var_tags = rt.call_function('implode', [rt.new_string('|'),
		var_allowed_media_types.clone()])
	if rt.is_true(rt.call_function('preg_match_all', [
		rt.new_string('#<(?P<tag>' + var_tags.str() +
			')[^<]*?(?:>[\\s\\S]*?<\\/(?P=tag)>|\\s*\\/>)#'),
		var_content.clone(),
		rt.create_array_from_list(var_matches),
	]))
	{
		mut iter_37 := var_matches[0].iterator()
		for {
			item_37 := iter_37.next() or { break }
			mut var_match_shadow := item_37.val
			var_html.array_push(var_match_shadow.clone())
		}
	}
	return var_html.clone()
}

fn get_post_galleries(var_post_arg rt.PhpVal, html bool) rt.PhpVal {
	mut var_html := html
	mut var_post := var_post_arg
	mut var_matches := []rt.PhpVal{}
	mut var_found_srcs := []rt.PhpVal{}
	mut var_galleries := rt.new_null()
	mut var_shortcode := []rt.PhpVal{}
	mut var_srcs := []rt.PhpVal{}
	mut var_shortcode_attrs := rt.new_null()
	mut var_gallery := rt.new_null()
	mut var_s := []rt.PhpVal{}
	mut var_post_blocks := rt.new_null()
	mut var_block := rt.new_null()
	mut var_has_inner_blocks := false
	mut var_block_html := rt.new_null()
	mut var_attrs := rt.new_null()
	mut var_ids := rt.new_null()
	mut var_id := rt.new_null()
	mut var_url := rt.new_null()
	mut var_src := rt.new_null()
	var_post = rt.call_function('get_post', [var_post.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_post)))) {
		return rt.new_array()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('has_shortcode', [rt.get_property(var_post, 'post_content'), rt.new_string('gallery')])))))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('has_block', [rt.new_string('gallery'), rt.get_property(var_post, 'post_content')]))))) {
		return rt.new_array()
	}
	var_galleries = rt.new_array()
	if rt.is_true(rt.call_function('preg_match_all', [
		rt.new_string('/' + (rt.call_function('get_shortcode_regex', []rt.PhpVal{})).str() + '/s'),
		rt.get_property(var_post, 'post_content'),
		rt.create_array_from_list(var_matches),
		rt.get_constant('PREG_SET_ORDER'),
	]))
	{
		for var_shortcode_shadow in var_matches {
			if rt.is_true(rt.identical(rt.new_string('gallery'), var_shortcode_shadow[2])) {
				var_srcs = rt.new_array()
				var_shortcode_attrs = rt.call_function('shortcode_parse_atts',
					[var_shortcode_shadow[3]])
				if !(var_shortcode_attrs.array_isset(rt.new_string('id'))) {
					var_shortcode_shadow[3] = rt.concat(var_shortcode_shadow[3], rt.new_string(
						' id="' + rt.new_int((rt.get_property(var_post, 'ID')).to_i64()).str() + '"'))
				}
				var_gallery = rt.call_function('do_shortcode_tag', [
					var_shortcode_shadow.clone()])
				if var_html {
					var_galleries.array_push(var_gallery.clone())
				} else {
					rt.call_function('preg_match_all', [
						rt.new_string('#src=([\'"])(.+?)\\1#is'),
						var_gallery.clone(),
						var_src.clone(),
						rt.get_constant('PREG_SET_ORDER'),
					])
					if !(!rt.is_true(var_src)) {
						mut iter_38 := var_src.iterator()
						for {
							item_38 := iter_38.next() or { break }
							mut var_s_shadow := item_38.val
							var_srcs << var_s_shadow[2]
						}
					}
					var_galleries.array_push(rt.call_function('array_merge', [
						var_shortcode_attrs.clone(),
						rt.create_array([
							rt.ArrayItem{ key: 'src', val: rt.call_function('array_values', [
								rt.call_function('array_unique', [
									rt.create_array_from_list(var_srcs),
								]),
							]) },
						])]))
				}
			}
		}
	}
	if rt.is_true(rt.call_function('has_block', [rt.new_string('gallery'),
		rt.get_property(var_post, 'post_content')]))
	{
		var_post_blocks = rt.call_function('parse_blocks', [
			rt.get_property(var_post, 'post_content'),
		])
		var_block = rt.call_function('array_shift', [var_post_blocks.clone()])
		for rt.is_true(var_block) {
			var_has_inner_blocks = !(!rt.is_true(var_block.array_get(rt.new_string('innerBlocks'))))
			if rt.is_true(rt.new_bool(!(rt.is_true(var_block.array_get(rt.new_string('blockName')))))) {
				continue
			}
			if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('core/gallery'),
				var_block.array_get(rt.new_string('blockName'))))))
			{
				if var_has_inner_blocks {
					var_post_blocks.clone().array_push(var_block.array_get(rt.new_string('innerBlocks')))
				}
				continue
			}
			if var_has_inner_blocks && var_html {
				var_block_html = rt.call_function('wp_list_pluck', [
					var_block.array_get(rt.new_string('innerBlocks')),
					rt.new_string('innerHTML'),
				])
				var_galleries.array_push('<figure>' +
					(rt.call_function('implode', [rt.new_string(' '), var_block_html.clone()])).str() +
					'</figure>')
				continue
			}
			var_srcs = rt.new_array()
			if var_has_inner_blocks {
				var_attrs = rt.call_function('wp_list_pluck', [
					var_block.array_get(rt.new_string('innerBlocks')),
					rt.new_string('attrs'),
				])
				var_ids = rt.call_function('wp_list_pluck', [
					var_attrs.clone(), rt.new_string('id')])
				mut iter_39 := var_ids.iterator()
				for {
					item_39 := iter_39.next() or { break }
					mut var_id_shadow := item_39.val
					var_url = rt.call_function('wp_get_attachment_url', [
						var_id_shadow.clone()])
					if var_url.clone().is_string()
						&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_url.clone(), rt.create_array_from_list(var_srcs), rt.new_bool(true)]))))) {
						var_srcs << var_url.clone()
					}
				}
				var_galleries.array_push(rt.create_array([
					rt.ArrayItem{ key: 'ids', val: rt.call_function('implode', [
						rt.new_string(','),
						var_ids.clone(),
					]) },
					rt.ArrayItem{ key: 'src', val: var_srcs },
				]))
				continue
			}
			if var_html {
				var_galleries.array_push(var_block.array_get(rt.new_string('innerHTML')))
				continue
			}
			var_ids = if !(!rt.is_true(var_block.array_get(rt.new_string('attrs')).array_get(rt.new_string('ids')))) {
				var_block.array_get(rt.new_string('attrs')).array_get(rt.new_string('ids'))
			} else {
				rt.new_array()
			}
			if !(!rt.is_true(var_ids)) {
				mut iter_40 := var_ids.iterator()
				for {
					item_40 := iter_40.next() or { break }
					mut var_id_shadow := item_40.val
					var_url = rt.call_function('wp_get_attachment_url', [
						var_id_shadow.clone()])
					if var_url.clone().is_string()
						&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_url.clone(), rt.create_array_from_list(var_srcs), rt.new_bool(true)]))))) {
						var_srcs << var_url.clone()
					}
				}
				var_galleries.array_push(rt.create_array([
					rt.ArrayItem{ key: 'ids', val: rt.call_function('implode', [
						rt.new_string(','),
						var_ids.clone(),
					]) },
					rt.ArrayItem{ key: 'src', val: var_srcs },
				]))
				continue
			}
			rt.call_function('preg_match_all', [rt.new_string('#src=([\'"])(.+?)\\1#is'),
				var_block.array_get(rt.new_string('innerHTML')),
				rt.create_array_from_list(var_found_srcs), rt.get_constant('PREG_SET_ORDER')])
			if !(!rt.is_true(var_found_srcs[0])) {
				for var_src_shadow in var_found_srcs {
					if var_src_shadow.array_isset(rt.new_int(2))
						&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_src_shadow.array_get(rt.new_int(2)), rt.create_array_from_list(var_srcs), rt.new_bool(true)]))))) {
						var_srcs << var_src_shadow.array_get(rt.new_int(2))
					}
				}
			}
			var_galleries.array_push(rt.create_array([
				rt.ArrayItem{ key: 'src', val: var_srcs },
			]))
		}
	}
	return rt.call_function('apply_filters', [rt.new_string('get_post_galleries'),
		var_galleries.clone(), var_post.clone()])
}

fn get_post_gallery(post i64, html bool) rt.PhpVal {
	mut var_post := post
	mut var_html := html
	mut var_galleries := rt.new_null()
	mut var_gallery := rt.new_null()
	var_galleries = get_post_galleries(rt.new_int(var_post), html)
	var_gallery = rt.call_function('reset', [var_galleries.clone()])
	return rt.call_function('apply_filters', [rt.new_string('get_post_gallery'),
		var_gallery.clone(), rt.new_int(var_post), var_galleries.clone()])
}

fn get_post_galleries_images(post i64) rt.PhpVal {
	mut var_post := post
	mut var_galleries := rt.new_null()
	var_galleries = get_post_galleries(rt.new_int(var_post), false)
	return rt.call_function('wp_list_pluck', [var_galleries.clone(),
		rt.new_string('src')])
}

fn get_post_gallery_images(post i64) rt.PhpVal {
	mut var_post := post
	mut var_gallery := rt.new_null()
	var_gallery = get_post_gallery(var_post, false)
	return if !rt.is_true(var_gallery.array_get(rt.new_string('src'))) {
		rt.new_array()
	} else {
		var_gallery.array_get(rt.new_string('src'))
	}
}

fn wp_maybe_generate_attachment_metadata(var_attachment rt.PhpVal) {
	mut var_attachment_id := rt.new_null()
	mut var_file := rt.new_null()
	mut var_meta := rt.new_null()
	mut var__meta := rt.new_null()
	mut var__lock := rt.new_null()
	if !rt.is_true(var_attachment) || !rt.is_true(rt.get_property(var_attachment, 'ID')) {
		return
	}
	var_attachment_id = rt.new_int((rt.get_property(var_attachment, 'ID')).to_i64())
	var_file = rt.call_function('get_attached_file', [var_attachment_id.clone()])
	var_meta = rt.call_function('wp_get_attachment_metadata', [
		var_attachment_id.clone()])
	if !rt.is_true(var_meta) && rt.is_true(rt.call_function('file_exists', [var_file.clone()])) {
		var__meta = rt.call_function('get_post_meta', [var_attachment_id.clone()])
		var__lock = rt.new_string('wp_generating_att_' + var_attachment_id.str())
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var__meta.clone().array_isset(rt.new_string('_wp_attachment_metadata')))))))
			&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('get_transient', [var__lock.clone()]))))) {
			rt.call_function('set_transient', [var__lock.clone(),
				var_file.clone()])
			rt.call_function('wp_update_attachment_metadata', [
				var_attachment_id.clone(),
				rt.call_function('wp_generate_attachment_metadata', [
					var_attachment_id.clone(),
					var_file.clone(),
				])])
			rt.call_function('delete_transient', [var__lock.clone()])
		}
	}
}

fn attachment_url_to_postid(var_url rt.PhpVal) i64 {
	mut var_wpdb := rt.new_null()
	mut var_post_id := rt.new_null()
	mut var_dir := rt.new_null()
	mut var_path := rt.new_null()
	mut var_site_url := rt.new_null()
	mut var_image_path := rt.new_null()
	mut var_sql := rt.new_null()
	mut var_results := rt.new_null()
	mut var_result := rt.new_null()
	var_post_id = rt.call_function('apply_filters', [
		rt.new_string('pre_attachment_url_to_postid'),
		rt.new_null(),
		var_url.clone(),
	])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_post_id)))) {
		return rt.new_int(var_post_id.to_i64())
	}
	var_dir = rt.call_function('wp_get_upload_dir', []rt.PhpVal{})
	var_path = var_url.clone()
	var_site_url = rt.call_function('parse_url', [var_dir.array_get(rt.new_string('url'))])
	var_image_path = rt.call_function('parse_url', [var_path.clone()])
	if var_image_path.array_isset(rt.new_string('scheme'))
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_image_path.array_get(rt.new_string('scheme')), var_site_url.array_get(rt.new_string('scheme')))))) {
		var_path = rt.call_function('str_replace', [
			var_image_path.array_get(rt.new_string('scheme')),
			var_site_url.array_get(rt.new_string('scheme')),
			var_path.clone(),
		])
	}
	if rt.is_true(rt.call_function('str_starts_with', [var_path.clone(),
		rt.new_string((var_dir.array_get(rt.new_string('baseurl'))).str() + '/')]))
	{
		var_path = rt.call_function('substr', [var_path.clone(),
			rt.new_int((var_dir.array_get(rt.new_string('baseurl'))).str() + '/'.len)])
	}
	var_sql = rt.call_method(var_wpdb, 'prepare', [
		rt.concat(rt.concat(rt.new_string('SELECT post_id, meta_value FROM '), rt.get_property(var_wpdb,
			'postmeta')),
			rt.new_string(" WHERE meta_key = '_wp_attached_file' AND meta_value = %s")),
		var_path.clone(),
	])
	var_results = rt.call_method(var_wpdb, 'get_results', [var_sql.clone()])
	var_post_id = rt.new_null()
	if rt.is_true(var_results) {
		var_post_id = rt.get_property(rt.call_function('reset', [
			var_results.clone()]), 'post_id')
		if var_results.clone().array_count() > 1 {
			mut iter_41 := var_results.iterator()
			for {
				item_41 := iter_41.next() or { break }
				mut var_result_shadow := item_41.val
				if rt.is_true(rt.identical(var_path, rt.get_property(var_result_shadow,
					'meta_value')))
				{
					var_post_id = rt.get_property(var_result_shadow, 'post_id')
					break
				}
			}
		}
	}
	return rt.new_int((rt.call_function('apply_filters', [
		rt.new_string('attachment_url_to_postid'),
		var_post_id.clone(),
		var_url.clone(),
	])).to_i64())
}

fn wpview_media_sandbox_styles() rt.PhpVal {
	mut var_version := rt.new_null()
	mut var_mediaelement := rt.new_null()
	mut var_wpmediaelement := rt.new_null()
	var_version = rt.new_string('ver=' +
		(rt.call_function('get_bloginfo', [rt.new_string('version')])).str())
	var_mediaelement = rt.call_function('includes_url', [
		rt.new_string('js/mediaelement/mediaelementplayer-legacy.min.css?${var_version.to_string()}'),
	])
	var_wpmediaelement = rt.call_function('includes_url', [
		rt.new_string('js/mediaelement/wp-mediaelement.css?${var_version.to_string()}'),
	])
	return rt.create_array([rt.ArrayItem{ key: none, val: var_mediaelement },
		rt.ArrayItem{ key: none, val: var_wpmediaelement }])
}

fn wp_register_media_personal_data_exporter(var_exporters rt.PhpVal) rt.PhpVal {
	var_exporters['wordpress-media'] = rt.create_array([
		rt.ArrayItem{ key: 'exporter_friendly_name', val: rt.call_function('__', [
			rt.new_string('WordPress Media'),
		]) },
		rt.ArrayItem{ key: 'callback', val: 'wp_media_personal_data_exporter' },
	])
	return var_exporters.clone()
}

fn wp_media_personal_data_exporter(var_email_address rt.PhpVal, page i64) rt.PhpVal {
	mut var_page := page
	mut var_number := i64(0)
	mut var_data_to_export := []rt.PhpVal{}
	mut var_user := rt.new_null()
	mut var_post_query := rt.new_null()
	mut var_post := rt.new_null()
	mut var_attachment_url := rt.new_null()
	mut var_post_data_to_export := []rt.PhpVal{}
	mut var_done := false
	var_number = 50
	var_page = var_page
	var_data_to_export = rt.new_array()
	var_user = rt.call_function('get_user_by', [rt.new_string('email'),
		var_email_address.clone()])
	if rt.is_true(rt.identical(rt.new_bool(false), var_user)) {
		return rt.create_array([rt.ArrayItem{ key: 'data', val: var_data_to_export },
			rt.ArrayItem{ key: 'done', val: true }])
	}
	var_post_query = create_wp_query(rt.create_array([
		rt.ArrayItem{ key: 'author', val: rt.get_property(var_user, 'ID') },
		rt.ArrayItem{ key: 'posts_per_page', val: var_number },
		rt.ArrayItem{ key: 'paged', val: var_page },
		rt.ArrayItem{ key: 'post_type', val: 'attachment' },
		rt.ArrayItem{ key: 'post_status', val: 'any' },
		rt.ArrayItem{ key: 'orderby', val: 'ID' },
		rt.ArrayItem{ key: 'order', val: 'ASC' },
	]))
	mut iter_42 := rt.cast_array(rt.get_property(var_post_query, 'posts')).iterator()
	for {
		item_42 := iter_42.next() or { break }
		mut var_post_shadow := item_42.val
		var_attachment_url = rt.call_function('wp_get_attachment_url', [
			rt.get_property(var_post_shadow, 'ID'),
		])
		if rt.is_true(var_attachment_url) {
			var_post_data_to_export = [
				[rt.call_function('__', [rt.new_string('URL')]), var_attachment_url],
			]
			var_data_to_export << rt.create_array([
				rt.ArrayItem{ key: 'group_id', val: 'media' },
				rt.ArrayItem{ key: 'group_label', val: rt.call_function('__', [
					rt.new_string('Media'),
				]) },
				rt.ArrayItem{ key: 'group_description', val: rt.call_function('__', [
					rt.new_string('User&#8217;s media data.'),
				]) },
				rt.ArrayItem{ key: 'item_id', val: rt.concat(rt.new_string('post-'),
					rt.get_property(var_post_shadow, 'ID')) },
				rt.ArrayItem{ key: 'data', val: var_post_data_to_export },
			])
		}
	}
	var_done = (rt.less_equal(rt.get_property(var_post_query, 'max_num_pages'),
		rt.new_int(var_page))).to_bool()
	return rt.create_array([rt.ArrayItem{ key: 'data', val: var_data_to_export },
		rt.ArrayItem{ key: 'done', val: var_done }])
}

fn _wp_add_additional_image_sizes() {
	add_image_size('1536x1536', 1536, 1536, false)
	add_image_size('2048x2048', 2048, 2048, false)
}

fn wp_show_heic_upload_error(var_plupload_settings rt.PhpVal) rt.PhpVal {
	mut var_plupload_init := map[string]rt.PhpVal{}
	if !(wp_image_editor_supports(rt.create_array([
		rt.ArrayItem{ key: 'mime_type', val: 'image/heic' },
	]))) {
		var_plupload_init['heic_upload_error'] = true
	}
	return var_plupload_settings.clone()
}

fn wp_getimagesize(var_filename rt.PhpVal, var_image_info rt.PhpVal) rt.PhpVal {
	mut var_info := rt.new_null()
	mut var_image_mime_type := rt.new_null()
	mut var_webp_info := rt.new_null()
	mut var_width := rt.new_null()
	mut var_height := rt.new_null()
	mut var_avif_info := rt.new_null()
	mut var_editor := rt.new_null()
	mut var_size := rt.new_null()
	if rt.is_true(rt.call_function('defined', [rt.new_string('WP_DEBUG')]))
		&& rt.is_true(rt.get_constant('WP_DEBUG'))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('WP_RUN_CORE_TESTS')]))))) {
		if rt.is_true(rt.identical(rt.new_int(2), rt.call_function('func_num_args', []rt.PhpVal{}))) {
			var_info = rt.call_function('getimagesize', [var_filename.clone(),
				var_image_info.clone()])
		} else {
			var_info = rt.call_function('getimagesize', [var_filename.clone()])
		}
	} else {
		if rt.is_true(rt.identical(rt.new_int(2), rt.call_function('func_num_args', []rt.PhpVal{}))) {
			var_info = rt.call_function('getimagesize', [var_filename.clone(),
				var_image_info.clone()])
		} else {
			var_info = rt.call_function('getimagesize', [var_filename.clone()])
		}
	}
	if !(!rt.is_true(var_info)) && !(!rt.is_true(var_info.array_get(rt.new_int(0)))
		&& !rt.is_true(var_info.array_get(rt.new_int(1)))) {
		return var_info.clone()
	}
	var_image_mime_type = rt.call_function('wp_get_image_mime', [
		var_filename.clone()])
	if rt.is_true(rt.identical(rt.new_bool(false), var_image_mime_type)) {
		return rt.new_bool(false)
	}
	if rt.is_true(rt.identical(rt.new_string('image/webp'), var_image_mime_type)) {
		var_webp_info = wp_get_webp_info(var_filename.clone())
		var_width = var_webp_info.array_get(rt.new_string('width'))
		var_height = var_webp_info.array_get(rt.new_string('height'))
		if rt.is_true(var_width) && rt.is_true(var_height) {
			return rt.create_array([rt.ArrayItem{ key: none, val: var_width },
				rt.ArrayItem{ key: none, val: var_height }, rt.ArrayItem{
					key: none
					val: rt.get_constant('IMAGETYPE_WEBP')
				}, rt.ArrayItem{ key: none, val: rt.call_function('sprintf', [
					rt.new_string('width="%d" height="%d"'),
					var_width.clone(),
					var_height.clone(),
				]) }, rt.ArrayItem{ key: 'mime', val: 'image/webp' }])
		}
	}
	if rt.is_true(rt.identical(rt.new_string('image/avif'), var_image_mime_type)) {
		var_avif_info = wp_get_avif_info(var_filename.clone())
		var_width = var_avif_info.array_get(rt.new_string('width'))
		var_height = var_avif_info.array_get(rt.new_string('height'))
		if rt.is_true(var_width) && rt.is_true(var_height) {
			return rt.create_array([rt.ArrayItem{ key: none, val: var_width },
				rt.ArrayItem{ key: none, val: var_height }, rt.ArrayItem{
					key: none
					val: rt.get_constant('IMAGETYPE_AVIF')
				}, rt.ArrayItem{ key: none, val: rt.call_function('sprintf', [
					rt.new_string('width="%d" height="%d"'),
					var_width.clone(),
					var_height.clone(),
				]) }, rt.ArrayItem{ key: 'mime', val: 'image/avif' }])
		}
	}
	if rt.is_true(rt.call_function('wp_is_heic_image_mime_type', [
		var_image_mime_type.clone()]))
	{
		var_editor = wp_get_image_editor(var_filename.clone(), rt.new_null())
		if rt.is_true(rt.call_function('is_wp_error', [var_editor.clone()])) {
			return rt.new_bool(false)
		}
		if rt.is_true(rt.new_bool(rt.instance_of(var_editor, 'WP_Image_Editor_Imagick'))) {
			var_size = rt.call_method(var_editor, 'get_size', []rt.PhpVal{})
			return rt.create_array([
				rt.ArrayItem{ key: none, val: var_size.array_get(rt.new_string('width')) },
				rt.ArrayItem{ key: none, val: var_size.array_get(rt.new_string('height')) },
				rt.ArrayItem{ key: none, val: rt.get_constant('IMAGETYPE_HEIF') },
				rt.ArrayItem{ key: none, val: rt.call_function('sprintf', [
					rt.new_string('width="%d" height="%d"'),
					var_size.array_get(rt.new_string('width')),
					var_size.array_get(rt.new_string('height')),
				]) },
				rt.ArrayItem{ key: 'mime', val: 'image/heic' },
			])
		}
	}
	return rt.new_bool(false)
}

fn wp_get_avif_info(var_filename rt.PhpVal) rt.PhpVal {
	mut var_results := rt.new_null()
	mut var_handle := rt.new_null()
	mut var_parser := rt.new_null()
	mut var_success := false
	var_results = rt.create_array([rt.ArrayItem{ key: 'width', val: false },
		rt.ArrayItem{ key: 'height', val: false }, rt.ArrayItem{ key: 'bit_depth', val: false },
		rt.ArrayItem{ key: 'num_channels', val: false }])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('image/avif'), rt.call_function('wp_get_image_mime', [
		var_filename.clone(),
	])))))
	{
		return var_results.clone()
	}
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/class-avif-info.php',
		'4')
	var_handle = rt.call_function('fopen', [var_filename.clone(),
		rt.new_string('rb')])
	if rt.is_true(var_handle) {
		var_parser = create_avifinfo_parser(var_handle.clone())
		var_success = rt.is_true(var_parser.parse_ftyp()) && rt.is_true(var_parser.parse_file())
		rt.call_function('fclose', [var_handle.clone()])
		if var_success {
			var_results = rt.get_property(rt.get_property(var_parser, 'features'),
				'primary_item_features')
		}
	}
	return var_results.clone()
}

fn wp_get_webp_info(var_filename rt.PhpVal) rt.PhpVal {
	mut var_width := false
	mut var_height := false
	mut var_type := false
	mut var_magic := rt.new_null()
	mut var_parts := rt.new_null()
	var_width = false
	var_height = false
	var_type = false
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('image/webp'), rt.call_function('wp_get_image_mime', [
		var_filename.clone(),
	])))))
	{
		return rt.call_function('compact', [rt.new_string('width'),
			rt.new_string('height'), rt.new_string('type')])
	}
	var_magic = rt.call_function('file_get_contents', [var_filename.clone(),
		rt.new_bool(false), rt.new_null(), rt.new_int(0), rt.new_int(40)])
	if rt.is_true(rt.identical(rt.new_bool(false), var_magic)) {
		return rt.call_function('compact', [rt.new_string('width'),
			rt.new_string('height'), rt.new_string('type')])
	}
	if var_magic.clone().to_string().len < 40 {
		return rt.call_function('compact', [rt.new_string('width'),
			rt.new_string('height'), rt.new_string('type')])
	}
	mut switch_val_2 := rt.call_function('substr', [var_magic.clone(),
		rt.new_int(12), rt.new_int(4)])
	if rt.is_true(rt.equal(switch_val_2, rt.new_string('VP8 '))) {
		var_parts = rt.call_function('unpack', [rt.new_string('v2'),
			rt.call_function('substr', [var_magic.clone(), rt.new_int(26),
				rt.new_int(4)])])
		var_width = rt.bitwise_and(var_parts.array_get(rt.new_int(1)), rt.new_int(16383))
		var_height = rt.bitwise_and(var_parts.array_get(rt.new_int(2)), rt.new_int(16383))
		var_type = 'lossy'
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('VP8L'))) {
		var_parts = rt.call_function('unpack', [rt.new_string('C4'),
			rt.call_function('substr', [var_magic.clone(), rt.new_int(21),
				rt.new_int(4)])])
		var_width =
			rt.bitwise_or(var_parts.array_get(rt.new_int(1)), rt.bitwise_and(var_parts.array_get(rt.new_int(2)), rt.new_int(63)) << 8) +
			1
		var_height =
			rt.bitwise_and(var_parts.array_get(rt.new_int(2)), rt.new_int(192)) >> 6 | rt.shift_left(var_parts.array_get(rt.new_int(3)), rt.new_int(2)) | rt.bitwise_and(var_parts.array_get(rt.new_int(4)), rt.new_int(3)) << 10 +
			1
		var_type = 'lossless'
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('VP8X'))) {
		var_width = (rt.call_function('unpack', [rt.new_string('V'),
			rt.new_string(
				(rt.call_function('substr', [var_magic.clone(), rt.new_int(24), rt.new_int(3)])).str() +
				'')])).to_bool()
		var_width =
			rt.bitwise_and(rt.new_bool(var_width).array_get(rt.new_int(1)), rt.new_int(16777215)) +
			1
		var_height = (rt.call_function('unpack', [rt.new_string('V'),
			rt.new_string(
				(rt.call_function('substr', [var_magic.clone(), rt.new_int(27), rt.new_int(3)])).str() +
				'')])).to_bool()
		var_height =
			rt.bitwise_and(rt.new_bool(var_height).array_get(rt.new_int(1)), rt.new_int(16777215)) +
			1
		var_type = 'animated-alpha'
	}
	return rt.call_function('compact', [rt.new_string('width'),
		rt.new_string('height'), rt.new_string('type')])
}

fn wp_get_loading_optimization_attributes(tag_name string, var_attr rt.PhpVal, var_context rt.PhpVal) rt.PhpVal {
	mut var_tag_name := tag_name
	mut var_wp_query := rt.new_null()
	mut var_loading_attrs := rt.new_null()
	mut var_maybe_in_viewport := rt.new_null()
	mut var_increase_count := false
	mut var_maybe_increase_count := false
	mut var_existing_fetchpriority := rt.new_null()
	mut var_is_low_fetchpriority := false
	mut var_header_enforced_contexts := rt.new_null()
	mut var_content_media_count := rt.new_null()
	mut var_wp_min_priority_img_pixels := rt.new_null()
	var_loading_attrs = rt.call_function('apply_filters', [
		rt.new_string('pre_wp_get_loading_optimization_attributes'),
		rt.new_bool(false),
		rt.new_string(tag_name),
		var_attr.clone(),
		var_context.clone(),
	])
	if rt.is_true(rt.new_bool(var_loading_attrs.clone().is_array())) {
		return var_loading_attrs.clone()
	}
	var_loading_attrs = rt.new_array()
	if rt.is_true(rt.identical(rt.new_string('template'), var_context)) {
		return rt.call_function('apply_filters', [
			rt.new_string('wp_get_loading_optimization_attributes'),
			var_loading_attrs.clone(),
			rt.new_string(tag_name),
			var_attr.clone(),
			var_context.clone(),
		])
	}
	if rt.is_true(rt.new_bool('img' != tag_name)) && rt.is_true(rt.new_bool('iframe' != tag_name)) {
		return rt.call_function('apply_filters', [
			rt.new_string('wp_get_loading_optimization_attributes'),
			var_loading_attrs.clone(),
			rt.new_string(tag_name),
			var_attr.clone(),
			var_context.clone(),
		])
	}
	if ((rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('the_content'), var_context))))
		&& rt.is_true(rt.call_function('doing_filter', [rt.new_string('the_content')])))|| (rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('widget_text_content'), var_context))))
		&& rt.is_true(rt.call_function('doing_filter', [rt.new_string('widget_text_content')]))))|| (rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('widget_block_content'), var_context))))
		&& rt.is_true(rt.call_function('doing_filter', [rt.new_string('widget_block_content')]))) {
		return rt.call_function('apply_filters', [
			rt.new_string('wp_get_loading_optimization_attributes'),
			var_loading_attrs.clone(),
			rt.new_string(tag_name),
			var_attr.clone(),
			var_context.clone(),
		])
	}
	if rt.is_true(rt.identical(rt.new_string('img'), rt.new_string(tag_name))) {
		var_loading_attrs.array_set('decoding', if !(var_attr.array_get(rt.new_string('decoding'))).is_null() {
			var_attr.array_get(rt.new_string('decoding'))
		} else {
			rt.new_string('async')
		})
	}
	if !(var_attr.array_isset(rt.new_string('width'))
		&& var_attr.array_isset(rt.new_string('height'))) {
		return rt.call_function('apply_filters', [
			rt.new_string('wp_get_loading_optimization_attributes'),
			var_loading_attrs.clone(),
			rt.new_string(tag_name),
			var_attr.clone(),
			var_context.clone(),
		])
	}
	var_maybe_in_viewport = rt.new_null()
	var_increase_count = false
	var_maybe_increase_count = false
	if var_attr.array_isset(rt.new_string('loading')) {
		if rt.is_true(rt.identical(rt.new_string('lazy'),
			var_attr.array_get(rt.new_string('loading'))))
		{
			var_maybe_in_viewport = rt.new_bool(false)
		} else {
			var_maybe_in_viewport = rt.new_bool(true)
		}
	}
	var_existing_fetchpriority = if !(var_attr.array_get(rt.new_string('fetchpriority'))).is_null() {
		var_attr.array_get(rt.new_string('fetchpriority'))
	} else {
		rt.new_null()
	}
	var_is_low_fetchpriority =
		(rt.identical(rt.new_string('low'), var_existing_fetchpriority)).to_bool()
	if rt.is_true(rt.identical(rt.new_string('high'), var_existing_fetchpriority)) {
		if rt.is_true(rt.identical(rt.new_bool(false), var_maybe_in_viewport)) {
			rt.call_function('_doing_it_wrong', [rt.new_string(@FN),
				rt.call_function('__', [
					rt.new_string('An image should not be lazy-loaded and marked as high priority at the same time.'),
				]),
				rt.new_string('6.3.0')])
			var_loading_attrs.array_set('fetchpriority', 'high')
		} else {
			var_maybe_in_viewport = rt.new_bool(true)
		}
	} else if var_is_low_fetchpriority {
		var_maybe_in_viewport = rt.new_bool(false)
		var_loading_attrs.array_set('fetchpriority', 'low')
	} else if rt.is_true(rt.identical(rt.new_string('auto'), var_existing_fetchpriority)) {
		var_loading_attrs.array_set('fetchpriority', 'auto')
	}
	if rt.is_true(rt.identical(rt.new_null(), var_maybe_in_viewport)) {
		var_header_enforced_contexts = rt.create_array([
			rt.ArrayItem{ key: 'template_part_' +
				(rt.get_constant('WP_TEMPLATE_PART_AREA_HEADER')).str(), val: true },
			rt.ArrayItem{ key: 'get_header_image_tag', val: true },
		])
		var_header_enforced_contexts = rt.call_function('apply_filters', [
			rt.new_string('wp_loading_optimization_force_header_contexts'),
			var_header_enforced_contexts.clone(),
		])
		if var_header_enforced_contexts.array_isset(var_context) {
			var_maybe_in_viewport = rt.new_bool(true)
			var_maybe_increase_count = true
		} else if
			rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_admin', []rt.PhpVal{})))))
			&& rt.is_true(rt.call_function('in_the_loop', []rt.PhpVal{}))
			&& rt.is_true(rt.call_function('is_main_query', []rt.PhpVal{})) {
			var_content_media_count = wp_increase_content_media_count(0)
			var_increase_count = true
			if rt.is_true(rt.less(var_content_media_count, wp_omit_loading_attr_threshold(false))) {
				var_maybe_in_viewport = rt.new_bool(true)
			} else {
				var_maybe_in_viewport = rt.new_bool(false)
			}
		} else if rt.is_true(rt.get_property(var_wp_query, 'before_loop'))
			&& rt.is_true(rt.call_method(var_wp_query, 'is_main_query', []rt.PhpVal{}))
			&& rt.is_true(rt.call_function('did_action', [rt.new_string('get_header')]))
			&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('did_action', [rt.new_string('get_footer')]))))) {
			var_maybe_in_viewport = rt.new_bool(true)
			var_maybe_increase_count = true
		}
	}
	if rt.is_true(var_maybe_in_viewport) {
		var_loading_attrs = wp_maybe_add_fetchpriority_high_attr(var_loading_attrs.clone(),
			rt.new_string(tag_name), var_attr.clone())
	} else if !var_is_low_fetchpriority {
		if rt.is_true(rt.new_bool(wp_lazy_loading_enabled(tag_name, var_context.clone()))) {
			var_loading_attrs.array_set('loading', 'lazy')
		}
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('auto'),
		var_existing_fetchpriority))))
	{
		if var_increase_count {
			wp_increase_content_media_count(0)
		} else if var_maybe_increase_count {
			var_wp_min_priority_img_pixels = rt.call_function('apply_filters', [
				rt.new_string('wp_min_priority_img_pixels'),
				rt.new_int(50000),
			])
			if rt.is_true(rt.less_equal(var_wp_min_priority_img_pixels, rt.mul(var_attr.array_get(rt.new_string('width')),
				var_attr.array_get(rt.new_string('height')))))
			{
				wp_increase_content_media_count(0)
			}
		}
	}
	return rt.call_function('apply_filters', [
		rt.new_string('wp_get_loading_optimization_attributes'),
		var_loading_attrs.clone(),
		rt.new_string(tag_name),
		var_attr.clone(),
		var_context.clone(),
	])
}

fn wp_omit_loading_attr_threshold(force bool) rt.PhpVal {
	mut var_force := force
	mut var_omit_threshold := rt.new_null()
	if !(!var_omit_threshold.is_null()) || var_force {
		var_omit_threshold = rt.call_function('apply_filters', [
			rt.new_string('wp_omit_loading_attr_threshold'),
			rt.new_int(3),
		])
	}
	return var_omit_threshold.clone()
}

fn wp_increase_content_media_count(amount i64) rt.PhpVal {
	mut var_amount := amount
	mut var_content_media_count := rt.new_null()
	var_content_media_count = rt.add(var_content_media_count, rt.new_int(amount))
	return var_content_media_count.clone()
}

fn wp_maybe_add_fetchpriority_high_attr(var_loading_attrs rt.PhpVal, var_tag_name rt.PhpVal, var_attr rt.PhpVal) rt.PhpVal {
	mut var_existing_fetchpriority := rt.new_null()
	mut var_wp_min_priority_img_pixels := rt.new_null()
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('img'), var_tag_name)))) {
		return var_loading_attrs.clone()
	}
	var_existing_fetchpriority = if !(var_attr.array_get(rt.new_string('fetchpriority'))).is_null() {
		var_attr.array_get(rt.new_string('fetchpriority'))
	} else {
		rt.new_null()
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_existing_fetchpriority))))
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('auto'), var_existing_fetchpriority)))) {
		if rt.is_true(rt.identical(rt.new_string('high'), var_existing_fetchpriority)) {
			var_loading_attrs.array_set('fetchpriority', 'high')
			rt.new_bool(wp_high_priority_element_flag(rt.new_bool(false)))
		}
		return var_loading_attrs.clone()
	}
	if var_loading_attrs.array_isset(rt.new_string('loading'))
		&& rt.is_true(rt.identical(rt.new_string('lazy'), var_loading_attrs.array_get(rt.new_string('loading')))) {
		return var_loading_attrs.clone()
	}
	if !(wp_high_priority_element_flag()) {
		return var_loading_attrs.clone()
	}
	var_wp_min_priority_img_pixels = rt.call_function('apply_filters', [
		rt.new_string('wp_min_priority_img_pixels'),
		rt.new_int(50000),
	])
	if rt.is_true(rt.less_equal(var_wp_min_priority_img_pixels, rt.mul(var_attr.array_get(rt.new_string('width')),
		var_attr.array_get(rt.new_string('height')))))
	{
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('auto'),
			var_existing_fetchpriority))))
		{
			var_loading_attrs.array_set('fetchpriority', 'high')
		}
		rt.new_bool(wp_high_priority_element_flag(rt.new_bool(false)))
	}
	return var_loading_attrs.clone()
}

fn wp_high_priority_element_flag(var_value rt.PhpVal) bool {
	mut var_high_priority_element := rt.new_null()
	if rt.is_true(rt.new_bool(var_value.clone().is_bool())) {
		var_high_priority_element = var_value.clone()
	}
	return var_high_priority_element.to_bool()
}

fn wp_get_image_editor_output_format(var_filename rt.PhpVal, var_mime_type rt.PhpVal) rt.PhpVal {
	mut var_output_format := rt.new_null()
	var_output_format = rt.create_array([
		rt.ArrayItem{ key: 'image/heic', val: 'image/jpeg' },
		rt.ArrayItem{ key: 'image/heif', val: 'image/jpeg' },
		rt.ArrayItem{ key: 'image/heic-sequence', val: 'image/jpeg' },
		rt.ArrayItem{ key: 'image/heif-sequence', val: 'image/jpeg' },
	])
	return rt.call_function('apply_filters', [
		rt.new_string('image_editor_output_format'),
		var_output_format.clone(),
		var_filename.clone(),
		var_mime_type.clone(),
	])
}

struct Class_WP_HTML_Tag_Processor {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

struct Class_WP_User {
	rt.PhpObjectBase
}

struct Class_WP_Query {
	rt.PhpObjectBase
}

struct Class_Avifinfo_Parser {
	rt.PhpObjectBase
}

fn create_wp_html_tag_processor(_args ...rt.PhpVal) &Class_WP_HTML_Tag_Processor {
	mut obj := &Class_WP_HTML_Tag_Processor{
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

fn create_wp_user(_args ...rt.PhpVal) &Class_WP_User {
	mut obj := &Class_WP_User{
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

fn create_avifinfo_parser(_args ...rt.PhpVal) &Class_Avifinfo_Parser {
	mut obj := &Class_Avifinfo_Parser{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_HTML_Tag_Processor) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_HTML_Tag_Processor) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_HTML_Tag_Processor) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_WP_User) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_User) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_User) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_Avifinfo_Parser) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Avifinfo_Parser) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Avifinfo_Parser) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn init_registry() {
	rt.register_class_factory('WP_HTML_Tag_Processor', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_wp_html_tag_processor()
		return rt.new_object('WP_HTML_Tag_Processor', []string{}, obj)
	})
	rt.register_class_factory('WP_Error', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_wp_error()
		return rt.new_object('WP_Error', []string{}, obj)
	})
	rt.register_class_factory('WP_User', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_wp_user()
		return rt.new_object('WP_User', []string{}, obj)
	})
	rt.register_class_factory('WP_Query', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_wp_query()
		return rt.new_object('WP_Query', []string{}, obj)
	})
	rt.register_class_factory('Avifinfo_Parser', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_avifinfo_parser()
		return rt.new_object('Avifinfo_Parser', []string{}, obj)
	})
}

fn init() {
	init_registry()
}

fn main() {
	defer {
		rt.shutdown()
	}

	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		fn () {
			print((rt.new_string('-1')).str())
			exit(0)
		}()
	}
	rt.call_function('add_shortcode', [rt.new_string('wp_caption'),
		rt.new_string('img_caption_shortcode')])
	rt.call_function('add_shortcode', [rt.new_string('caption'),
		rt.new_string('img_caption_shortcode')])
	rt.call_function('add_shortcode', [rt.new_string('gallery'),
		rt.new_string('gallery_shortcode')])
	rt.call_function('add_shortcode', [rt.new_string('playlist'),
		rt.new_string('wp_playlist_shortcode')])
	rt.call_function('add_shortcode', [rt.new_string('audio'),
		rt.new_string('wp_audio_shortcode')])
	rt.call_function('add_shortcode', [rt.new_string('video'),
		rt.new_string('wp_video_shortcode')])
}
