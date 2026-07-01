import rt

fn wp_crop_image(var_src rt.PhpVal, var_src_x rt.PhpVal, var_src_y rt.PhpVal, var_src_w rt.PhpVal, var_src_h rt.PhpVal, var_dst_w rt.PhpVal, var_dst_h rt.PhpVal, src_abs bool, dst_file bool) rt.PhpVal {
	mut var_src_file := var_src.dup()
	if rt.is_true(rt.new_bool(var_src.dup().is_long() || var_src.dup().is_double())) {
		var_src_file = rt.call_function('get_attached_file', [var_src.dup()])
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('file_exists', [var_src_file.dup()]))))) {
			var_src = _load_image_to_edit_path(var_src.dup(), 'full')
		} else {
			var_src = var_src_file.dup()
		}
	}
	mut var_editor := rt.call_function('wp_get_image_editor', [var_src.dup()])
	if rt.is_true(rt.call_function('is_wp_error', [var_editor.dup()])) {
		return var_editor.dup()
	}
	var_src = rt.call_method(var_editor, 'crop', [var_src_x.dup(), var_src_y.dup(), var_src_w.dup(), var_src_h.dup(), var_dst_w.dup(), var_dst_h.dup(), rt.new_bool(src_abs)])
	if rt.is_true(rt.call_function('is_wp_error', [var_src.dup()])) {
		return var_src.dup()
	}
	if !(var_dst_file) {
		dst_file = (rt.call_function('str_replace', [rt.call_function('wp_basename', [var_src_file.dup()]), 'cropped-' + (rt.call_function('wp_basename', [var_src_file.dup()])).str(), var_src_file.dup()])).to_bool()
	}
	rt.call_function('wp_mkdir_p', [rt.call_function('dirname', [rt.new_bool(dst_file)])])
	dst_file = (rt.call_function('dirname', [rt.new_bool(dst_file)])).str() + '/' + (rt.call_function('wp_unique_filename', [rt.call_function('dirname', [rt.new_bool(dst_file)]), rt.call_function('wp_basename', [rt.new_bool(dst_file)])])).str()
	mut var_result := rt.call_method(var_editor, 'save', [rt.new_bool(dst_file)])
	if rt.is_true(rt.call_function('is_wp_error', [var_result.dup()])) {
		return var_result.dup()
	}
	if !(!rt.is_true(var_result.array_get('path'))) {
		return var_result.array_get('path')
	}
	return rt.new_bool(dst_file)
}

fn wp_get_missing_image_subsizes(var_attachment_id rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_attachment_is_image', [var_attachment_id.dup()]))))) {
		return rt.new_array()
	}
	mut var_registered_sizes := rt.call_function('wp_get_registered_image_subsizes', []rt.PhpVal{})
	mut var_image_meta := rt.call_function('wp_get_attachment_metadata', [var_attachment_id.dup()])
	if !rt.is_true(var_image_meta) {
		return var_registered_sizes.dup()
	}
	if !(!rt.is_true(var_image_meta.array_get('original_image'))) {
		mut var_image_file := rt.call_function('wp_get_original_image_path', [var_attachment_id.dup()])
		mut var_imagesize := rt.call_function('wp_getimagesize', [var_image_file.dup()])
	}
	if !(!rt.is_true(var_imagesize)) {
		mut var_full_width := var_imagesize.array_get(0)
		mut var_full_height := var_imagesize.array_get(1)
	} else {
		var_full_width = // unsupported expression: Expr_Cast_Int
		var_full_height = // unsupported expression: Expr_Cast_Int
	}
	mut var_possible_sizes := rt.new_array()
	{
		mut iter_1 := var_registered_sizes.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_size_data := item_1.val
			mut var_size_name := item_1.key
			if rt.is_true(rt.call_function('image_resize_dimensions', [var_full_width.dup(), var_full_height.dup(), var_size_data.array_get('width'), var_size_data.array_get('height'), var_size_data.array_get('crop')])) {
				var_possible_sizes.array_set(var_size_name, var_size_data.dup())
			}
		}
	}
	if !rt.is_true(var_image_meta.array_get('sizes')) {
		var_image_meta.array_set('sizes', rt.new_array())
	}
	mut var_missing_sizes := rt.call_function('array_diff_key', [var_possible_sizes.dup(), var_image_meta.array_get('sizes')])
	return rt.call_function('apply_filters', [rt.new_string('wp_get_missing_image_subsizes'), var_missing_sizes.dup(), var_image_meta.dup(), var_attachment_id.dup()])
}

fn wp_update_image_subsizes(var_attachment_id rt.PhpVal) rt.PhpVal {
	mut var_image_meta := rt.call_function('wp_get_attachment_metadata', [var_attachment_id.dup()])
	mut var_image_file := rt.call_function('wp_get_original_image_path', [var_attachment_id.dup()])
	if rt.is_true(rt.new_bool(!rt.is_true(var_image_meta) || rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_image_meta.dup().is_array()))))))) {
		if !(!rt.is_true(var_image_file)) {
			var_image_meta = wp_create_image_subsizes(var_image_file.dup(), var_attachment_id.dup())
		} else {
			return create_wp_error(rt.new_string('invalid_attachment'), rt.call_function('__', [rt.new_string('The attached file cannot be found.')]))
		}
	} else {
		mut var_missing_sizes := wp_get_missing_image_subsizes(var_attachment_id.dup())
		if !rt.is_true(var_missing_sizes) {
			return var_image_meta.dup()
		}
		var_image_meta = _wp_make_subsizes(var_missing_sizes.dup(), var_image_file.dup(), var_image_meta.dup(), var_attachment_id.dup())
	}
	var_image_meta = rt.call_function('apply_filters', [rt.new_string('wp_generate_attachment_metadata'), var_image_meta.dup(), var_attachment_id.dup(), rt.new_string('update')])
	rt.call_function('wp_update_attachment_metadata', [var_attachment_id.dup(), var_image_meta.dup()])
	return var_image_meta.dup()
}

fn _wp_image_meta_replace_original(var_saved_data rt.PhpVal, var_original_file rt.PhpVal, var_image_meta rt.PhpVal, var_attachment_id rt.PhpVal) rt.PhpVal {
	mut var_new_file := var_saved_data.array_get('path')
	rt.call_function('update_attached_file', [var_attachment_id.dup(), var_new_file.dup()])
	var_image_meta.array_set('width', var_saved_data.array_get('width'))
	var_image_meta.array_set('height', var_saved_data.array_get('height'))
	var_image_meta.array_set('file', rt.call_function('_wp_relative_upload_path', [var_new_file.dup()]))
	var_image_meta.array_set('filesize', rt.call_function('wp_filesize', [var_new_file.dup()]))
	var_image_meta.array_set('original_image', rt.call_function('wp_basename', [var_original_file.dup()]))
	return var_image_meta.dup()
}

fn wp_create_image_subsizes(var_file rt.PhpVal, var_attachment_id rt.PhpVal) rt.PhpVal {
	mut var_imagesize := rt.call_function('wp_getimagesize', [var_file.dup()])
	if !rt.is_true(var_imagesize) {
		return rt.new_array()
	}
	mut var_image_meta := rt.create_array([rt.ArrayItem{ key: 'width', val: var_imagesize.array_get(0) }, rt.ArrayItem{ key: 'height', val: var_imagesize.array_get(1) }, rt.ArrayItem{ key: 'file', val: rt.call_function('_wp_relative_upload_path', [var_file.dup()]) }, rt.ArrayItem{ key: 'filesize', val: rt.call_function('wp_filesize', [var_file.dup()]) }, rt.ArrayItem{ key: 'sizes', val: rt.new_array() }])
	mut var_exif_meta := rt.new_bool(rt.new_bool(wp_read_image_metadata(var_file.dup())))
	if rt.is_true(var_exif_meta) {
		var_image_meta.array_set('image_meta', var_exif_meta.dup())
	}
	mut var_threshold := // unsupported expression: Expr_Cast_Int
	mut var_scale_down := false
	mut var_convert := false
	if rt.is_true(rt.new_bool(rt.is_true(var_threshold) && rt.is_true(rt.new_bool(rt.is_true(rt.greater(var_image_meta.array_get('width'), var_threshold)) || rt.is_true(rt.greater(var_image_meta.array_get('height'), var_threshold)))))) {
		var_scale_down = true
	} else {
		mut var_output_format := rt.call_function('wp_get_image_editor_output_format', [var_file.dup(), var_imagesize.array_get('mime')])
		if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_output_format.dup().is_array())) && rt.is_true(rt.new_bool(var_output_format.dup().array_isset(var_imagesize.array_get('mime')))))) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
			var_convert = true
		}
	}
	if var_scale_down || var_convert {
		mut var_editor := rt.call_function('wp_get_image_editor', [var_file.dup()])
		if rt.is_true(rt.call_function('is_wp_error', [var_editor.dup()])) {
			return var_image_meta.dup()
		}
		if var_scale_down {
			mut var_resized := rt.call_method(var_editor, 'resize', [var_threshold.dup(), var_threshold.dup()])
		} else if var_convert {
			var_resized = rt.new_bool(rt.new_bool(true))
		}
		mut var_rotated := rt.new_null()
		if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [var_resized.dup()]))))) && rt.is_true(rt.new_bool(var_exif_meta.dup().is_array())))) {
			var_resized = rt.call_method(var_editor, 'maybe_exif_rotate', []rt.PhpVal{})
			var_rotated = var_resized.dup()
			// unsupported statement: Stmt_Nop
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [var_resized.dup()]))))) {
			if var_scale_down {
				mut var_saved := rt.call_method(var_editor, 'save', [rt.call_method(var_editor, 'generate_filename', [rt.new_string('scaled')])])
			} else if var_convert {
				var_saved = rt.call_method(var_editor, 'save', [rt.call_method(var_editor, 'generate_filename', [rt.new_string('')])])
			} else {
				var_saved = rt.call_method(var_editor, 'save', []rt.PhpVal{})
			}
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [var_saved.dup()]))))) {
				var_image_meta = _wp_image_meta_replace_original(var_saved.dup(), var_file.dup(), var_image_meta.dup(), var_attachment_id.dup())
				if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_bool(true), var_rotated)) && !(!rt.is_true(var_image_meta.array_get('image_meta').array_get('orientation'))))) {
					var_image_meta.array_get_mut('image_meta').array_set('orientation', 1)
				}
			} else {
				// unsupported statement: Stmt_Nop
			}
		} else {
			// unsupported statement: Stmt_Nop
		}
	} else if rt.is_true(rt.new_bool(!(!rt.is_true(var_exif_meta.array_get('orientation'))) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		var_editor = rt.call_function('wp_get_image_editor', [var_file.dup()])
		if rt.is_true(rt.call_function('is_wp_error', [var_editor.dup()])) {
			return var_image_meta.dup()
		}
		var_rotated = rt.call_method(var_editor, 'maybe_exif_rotate', []rt.PhpVal{})
		if rt.is_true(rt.identical(rt.new_bool(true), var_rotated)) {
			var_saved = rt.call_method(var_editor, 'save', [rt.call_method(var_editor, 'generate_filename', [rt.new_string('rotated')])])
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [var_saved.dup()]))))) {
				var_image_meta = _wp_image_meta_replace_original(var_saved.dup(), var_file.dup(), var_image_meta.dup(), var_attachment_id.dup())
				if !(!rt.is_true(var_image_meta.array_get('image_meta').array_get('orientation'))) {
					var_image_meta.array_get_mut('image_meta').array_set('orientation', 1)
				}
			} else {
				// unsupported statement: Stmt_Nop
			}
		}
	}
	rt.call_function('wp_update_attachment_metadata', [var_attachment_id.dup(), var_image_meta.dup()])
	mut var_new_sizes := rt.call_function('wp_get_registered_image_subsizes', []rt.PhpVal{})
	var_new_sizes = rt.call_function('apply_filters', [rt.new_string('intermediate_image_sizes_advanced'), var_new_sizes.dup(), var_image_meta.dup(), var_attachment_id.dup()])
	return _wp_make_subsizes(var_new_sizes.dup(), var_file.dup(), var_image_meta.dup(), var_attachment_id.dup())
}

fn _wp_make_subsizes(var_new_sizes rt.PhpVal, var_file rt.PhpVal, var_image_meta rt.PhpVal, var_attachment_id rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.new_bool(!rt.is_true(var_image_meta) || rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_image_meta.dup().is_array()))))))) {
		return rt.new_array()
	}
	if rt.is_true(rt.new_bool(var_image_meta.array_isset(rt.new_string('sizes')) && rt.is_true(rt.new_bool(var_image_meta.array_get('sizes').is_array())))) {
		{
			mut iter_1 := var_image_meta.array_get('sizes').iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_size_meta := item_1.val
				mut var_size_name := item_1.key
				if rt.is_true(rt.new_bool(var_new_sizes.dup().array_isset(var_size_name.dup()))) {
					var_new_sizes.array_unset(var_size_name)
				}
			}
		}
	} else {
		var_image_meta.array_set('sizes', rt.new_array())
	}
	if !rt.is_true(var_new_sizes) {
		return var_image_meta.dup()
	}
	mut var_priority := { : , : , : , :  }
	var_new_sizes = 
	
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

fn create_wp_error() &Class_WP_Error {
	mut obj := &Class_WP_Error{
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




pub fn init_wp_admin_includes_image_php() {
}
