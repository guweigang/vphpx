import rt

fn wp_image_editor(var_post_id rt.PhpVal, msg bool) {
	mut var_msg := msg
	mut var_nonce := rt.new_null()
	mut var_meta := rt.new_null()
	mut var_thumb := rt.new_null()
	mut var_sub_sizes := false
	mut var_note := ''
	mut var_big := rt.new_null()
	mut var_sizer := rt.new_null()
	mut var_backup_sizes := rt.new_null()
	mut var_can_restore := rt.new_null()
	mut var_edit_thumbnails_separately := rt.new_null()
	mut var_note_no_rotate := rt.new_null()
	mut var_thumb_img := rt.new_null()
	var_nonce = rt.call_function('wp_create_nonce', [rt.new_string("image_editor-${var_post_id.to_string()}")])
	var_meta = rt.call_function('wp_get_attachment_metadata', [var_post_id.clone()])
	var_thumb = rt.call_function('image_get_intermediate_size', [var_post_id.clone(), rt.new_string('thumbnail')])
	var_sub_sizes = var_meta.array_isset(rt.new_string('sizes')) && var_meta.array_get(rt.new_string('sizes')).is_array()
	var_note = ''
	if var_meta.array_isset(rt.new_string('width')) && var_meta.array_isset(rt.new_string('height')) {
	var_big = rt.call_function('max', [var_meta.array_get(rt.new_string('width')), var_meta.array_get(rt.new_string('height'))])
	} else {
		fn () { print((rt.call_function('__', [rt.new_string('Image data does not exist. Please re-upload the image.')])).str()); exit(0) }()
	}
	var_sizer = if rt.is_true(rt.greater(var_big, rt.new_int(600))) { rt.div(rt.new_int(600), var_big) } else { rt.new_int(1) }
	var_backup_sizes = rt.call_function('get_post_meta', [var_post_id.clone(), rt.new_string('_wp_attachment_backup_sizes'), rt.new_bool(true)])
	var_can_restore = rt.new_bool(false)
	if !(!rt.is_true(var_backup_sizes)) && var_backup_sizes.array_isset(rt.new_string('full-orig')) && var_meta.array_isset(rt.new_string('file')) {
	var_can_restore = rt.new_bool(!rt.is_true(rt.identical(rt.call_function('wp_basename', [var_meta.array_get(rt.new_string('file'))]), var_backup_sizes.array_get(rt.new_string('full-orig')).array_get(rt.new_string('file')))))
	}
	if var_msg {
		if !(rt.get_property(rt.new_bool(msg), 'error')).is_null() {
		var_note = rt.concat(rt.concat(rt.new_string('<div class=\'notice notice-error\' role=\'alert\'><p>'), rt.get_property(rt.new_bool(msg), 'error')), rt.new_string('</p></div>'))
		} else if !(rt.get_property(rt.new_bool(msg), 'msg')).is_null() {
		var_note = rt.concat(rt.concat(rt.new_string('<div class=\'notice notice-success\' role=\'alert\'><p>'), rt.get_property(rt.new_bool(msg), 'msg')), rt.new_string('</p></div>'))
		}
	}
	var_edit_thumbnails_separately = rt.new_bool((rt.call_function('apply_filters', [rt.new_string('image_edit_thumbnails_separately'), rt.new_bool(false)])).to_bool())
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_post_id)
	// unsupported statement: Stmt_InlineHTML
	print(var_note)
	// unsupported statement: Stmt_InlineHTML
	print("${var_post_id.to_string()}, '${var_nonce.to_string()}'")
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Crop')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html_x', [rt.new_string('Scale'), rt.new_string('verb')]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Image Rotation')])
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.call_function('wp_image_editor_supports', [rt.create_array([rt.ArrayItem{ key: 'mime_type', val: rt.call_function('get_post_mime_type', [var_post_id.clone()]) }, rt.ArrayItem{ key: 'methods', val: rt.create_array([rt.ArrayItem{ key: none, val: 'rotate' }]) }])])) {
		var_note_no_rotate = rt.new_string('')
		// unsupported statement: Stmt_InlineHTML
		print("${var_post_id.to_string()}, '${var_nonce.to_string()}'")
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Rotate 90&deg; left')])
		// unsupported statement: Stmt_InlineHTML
		print("${var_post_id.to_string()}, '${var_nonce.to_string()}'")
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Rotate 90&deg; right')])
		// unsupported statement: Stmt_InlineHTML
		print("${var_post_id.to_string()}, '${var_nonce.to_string()}'")
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Rotate 180&deg;')])
		// unsupported statement: Stmt_InlineHTML
	} else {
		var_note_no_rotate = rt.new_string('<p class="note-no-rotate"><em>' + (rt.call_function('__', [rt.new_string('Image rotation is not supported by your web host.')])).str() + '</em></p>')
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	print("${var_post_id.to_string()}, '${var_nonce.to_string()}'")
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Flip vertical')])
	// unsupported statement: Stmt_InlineHTML
	print("${var_post_id.to_string()}, '${var_nonce.to_string()}'")
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Flip horizontal')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_note_no_rotate)
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_post_id)
	// unsupported statement: Stmt_InlineHTML
	print("${var_post_id.to_string()}, '${var_nonce.to_string()}'")
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Undo')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_post_id)
	// unsupported statement: Stmt_InlineHTML
	print("${var_post_id.to_string()}, '${var_nonce.to_string()}'")
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Redo')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_post_id)
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Cancel Editing')])
	// unsupported statement: Stmt_InlineHTML
	print("${var_post_id.to_string()}, '${var_nonce.to_string()}'")
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Save Edits')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_post_id)
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_nonce)
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_post_id)
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_sizer)
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_post_id)
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_post_id)
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_post_id)
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_post_id)
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(if !(var_meta.array_get(rt.new_string('width'))).is_null() { var_meta.array_get(rt.new_string('width')) } else { rt.new_int(0) })
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_post_id)
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(if !(var_meta.array_get(rt.new_string('height'))).is_null() { var_meta.array_get(rt.new_string('height')) } else { rt.new_int(0) })
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_post_id)
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_post_id)
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_post_id)
	// unsupported statement: Stmt_InlineHTML
	print((rt.call_function('esc_url', [rt.call_function('admin_url', [rt.new_string('admin-ajax.php'), rt.new_string('relative')])])).str() + '?action=imgedit-preview&amp;_ajax_nonce=' + (var_nonce).str() + '&amp;postid=' + (var_post_id).str() + '&amp;rand=' + (rt.call_function('rand', [rt.new_int(1), rt.new_int(99999)])).str())
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Scale Image')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Scale Image Help')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('You can proportionally scale the original image. For best results, scaling should be done before you crop, flip, or rotate. Images can only be scaled down, not up.')])
	// unsupported statement: Stmt_InlineHTML
	if var_meta.array_isset(rt.new_string('width')) && var_meta.array_isset(rt.new_string('height')) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('printf', [rt.call_function('__', [rt.new_string('Original dimensions %s')]), rt.new_string('<span class="imgedit-original-dimensions">' + (var_meta.array_get(rt.new_string('width'))).str() + ' &times; ' + (var_meta.array_get(rt.new_string('height'))).str() + '</span>')])
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('New dimensions:')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_post_id)
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('scale height')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(if !(var_meta.array_get(rt.new_string('width'))).is_null() { var_meta.array_get(rt.new_string('width')) } else { rt.new_string('') })
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_post_id)
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_post_id)
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_post_id)
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_post_id)
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(if !(var_meta.array_get(rt.new_string('width'))).is_null() { var_meta.array_get(rt.new_string('width')) } else { rt.new_int(0) })
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_post_id)
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('scale height')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(if !(var_meta.array_get(rt.new_string('height'))).is_null() { var_meta.array_get(rt.new_string('height')) } else { rt.new_string('') })
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_post_id)
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_post_id)
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_post_id)
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_post_id)
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(if !(var_meta.array_get(rt.new_string('height'))).is_null() { var_meta.array_get(rt.new_string('height')) } else { rt.new_int(0) })
	// unsupported statement: Stmt_InlineHTML
	print("${var_post_id.to_string()}, '${var_nonce.to_string()}'")
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html_x', [rt.new_string('Scale'), rt.new_string('verb')]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_post_id)
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Images cannot be scaled to a size larger than the original.')])
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(var_can_restore) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Restore original image')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Discard any changes and restore the original image.')])
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('IMAGE_EDIT_OVERWRITE')]))))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.get_constant('IMAGE_EDIT_OVERWRITE'))))) {
			print(' ' + (rt.call_function('__', [rt.new_string('Previously edited copies of the image will not be deleted.')])).str())
		}
		// unsupported statement: Stmt_InlineHTML
		print("${var_post_id.to_string()}, '${var_nonce.to_string()}'")
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_attr_e', [rt.new_string('Restore image')])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(var_can_restore)
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Crop Image')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Image Crop Help')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('To crop the image, click on it and drag to make your selection.')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Crop Aspect Ratio')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('The aspect ratio is the relationship between the width and height. You can preserve the aspect ratio by holding down the shift key while resizing your selection. Use the input box to specify the aspect ratio, e.g. 1:1 (square), 4:3, 16:9, etc.')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Crop Selection')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Once you have made your selection, you can adjust it by entering the size in pixels. The minimum selection size is the thumbnail size as set in the Media settings.')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Aspect ratio:')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_post_id)
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('crop ratio width')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_post_id)
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_post_id)
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_post_id)
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_post_id)
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('crop ratio height')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_post_id)
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_post_id)
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_post_id)
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_post_id)
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Selection:')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_post_id)
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('selection width')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_post_id)
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_post_id)
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_post_id)
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_post_id)
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('selection height')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_post_id)
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_post_id)
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_post_id)
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_post_id)
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Starting Coordinates:')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_post_id)
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('horizontal start position')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_post_id)
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_post_id)
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_post_id)
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_post_id)
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('vertical start position')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_post_id)
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_post_id)
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_post_id)
	// unsupported statement: Stmt_InlineHTML
	print("${var_post_id.to_string()}, '${var_nonce.to_string()}'")
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Apply Crop')])
	// unsupported statement: Stmt_InlineHTML
	print("${var_post_id.to_string()}, '${var_nonce.to_string()}'")
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Clear Crop')])
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(var_edit_thumbnails_separately) && rt.is_true(var_thumb) && var_sub_sizes {
		var_thumb_img = rt.call_function('wp_constrain_dimensions', [var_thumb.array_get(rt.new_string('width')), var_thumb.array_get(rt.new_string('height')), rt.new_int(160), rt.new_int(120)])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Thumbnail Settings')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Thumbnail Settings Help')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('You can edit the image while preserving the thumbnail. For example, you may wish to have a square thumbnail that displays just a section of the image.')])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_url', [var_thumb.array_get(rt.new_string('url'))]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [var_thumb_img.array_get(rt.new_int(0))]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [var_thumb_img.array_get(rt.new_int(1))]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Current thumbnail')])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(var_post_id)
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Apply changes to:')])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(var_post_id)
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('All image sizes')])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(var_post_id)
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Thumbnail')])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(var_post_id)
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('All sizes except thumbnail')])
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_post_id)
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_post_id)
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('There are unsaved changes that will be lost. \'OK\' to continue, \'Cancel\' to return to the Image Editor.')])
	// unsupported statement: Stmt_InlineHTML
}

fn wp_stream_image(var_image_arg rt.PhpVal, var_mime_type rt.PhpVal, var_attachment_id rt.PhpVal) bool {
	mut var_image := var_image_arg
	if rt.is_true(rt.new_bool(rt.instance_of(var_image, 'WP_Image_Editor'))) {
		var_image = rt.call_function('apply_filters', [rt.new_string('image_editor_save_pre'), var_image.clone(), var_attachment_id.clone()])
		if rt.is_true(rt.call_function('is_wp_error', [rt.call_method(var_image, 'stream', [var_mime_type.clone()])])) {
			return false
		}
		return true
	} else {
		rt.call_function('_deprecated_argument', [rt.new_string(@FN), rt.new_string('3.5.0'), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('%1$s needs to be a %2$s object.')]), rt.new_string('$image'), rt.new_string('WP_Image_Editor')])])
		var_image = rt.call_function('apply_filters_deprecated', [rt.new_string('image_save_pre'), rt.create_array([rt.ArrayItem{ key: none, val: var_image }, rt.ArrayItem{ key: none, val: var_attachment_id }]), rt.new_string('3.5.0'), rt.new_string('image_editor_save_pre')])
		mut switch_val_1 := var_mime_type
		if rt.is_true(rt.equal(switch_val_1, rt.new_string('image/jpeg'))) {
			rt.call_function('header', [rt.new_string('Content-Type: image/jpeg')])
			return (rt.call_function('imagejpeg', [var_image.clone(), rt.new_null(), rt.new_int(90)])).to_bool()
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('image/png'))) {
			rt.call_function('header', [rt.new_string('Content-Type: image/png')])
			return (rt.call_function('imagepng', [var_image.clone()])).to_bool()
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('image/gif'))) {
			rt.call_function('header', [rt.new_string('Content-Type: image/gif')])
			return (rt.call_function('imagegif', [var_image.clone()])).to_bool()
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('image/webp'))) {
			if rt.is_true(rt.call_function('function_exists', [rt.new_string('imagewebp')])) {
				rt.call_function('header', [rt.new_string('Content-Type: image/webp')])
				return (rt.call_function('imagewebp', [var_image.clone(), rt.new_null(), rt.new_int(90)])).to_bool()
			}
			return false
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('image/avif'))) {
			if rt.is_true(rt.call_function('function_exists', [rt.new_string('imageavif')])) {
				rt.call_function('header', [rt.new_string('Content-Type: image/avif')])
				return (rt.call_function('imageavif', [var_image.clone(), rt.new_null(), rt.new_int(90)])).to_bool()
			}
			return false
		} else {
			return false
		}
	}
	return false
}

fn wp_save_image_file(var_filename rt.PhpVal, var_image_arg rt.PhpVal, var_mime_type rt.PhpVal, var_post_id rt.PhpVal) bool {
	mut var_image := var_image_arg
	mut var_saved := rt.new_null()
	if rt.is_true(rt.new_bool(rt.instance_of(var_image, 'WP_Image_Editor'))) {
		var_image = rt.call_function('apply_filters', [rt.new_string('image_editor_save_pre'), var_image.clone(), var_post_id.clone()])
		var_saved = rt.call_function('apply_filters', [rt.new_string('wp_save_image_editor_file'), rt.new_null(), var_filename.clone(), var_image.clone(), var_mime_type.clone(), var_post_id.clone()])
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_saved)))) {
			return (var_saved).to_bool()
		}
		return (rt.call_method(var_image, 'save', [var_filename.clone(), var_mime_type.clone()])).to_bool()
	} else {
		rt.call_function('_deprecated_argument', [rt.new_string(@FN), rt.new_string('3.5.0'), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('%1$s needs to be a %2$s object.')]), rt.new_string('$image'), rt.new_string('WP_Image_Editor')])])
		var_image = rt.call_function('apply_filters_deprecated', [rt.new_string('image_save_pre'), rt.create_array([rt.ArrayItem{ key: none, val: var_image }, rt.ArrayItem{ key: none, val: var_post_id }]), rt.new_string('3.5.0'), rt.new_string('image_editor_save_pre')])
		var_saved = rt.call_function('apply_filters_deprecated', [rt.new_string('wp_save_image_file'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_null() }, rt.ArrayItem{ key: none, val: var_filename }, rt.ArrayItem{ key: none, val: var_image }, rt.ArrayItem{ key: none, val: var_mime_type }, rt.ArrayItem{ key: none, val: var_post_id }]), rt.new_string('3.5.0'), rt.new_string('wp_save_image_editor_file')])
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_saved)))) {
			return (var_saved).to_bool()
		}
		mut switch_val_2 := var_mime_type
		if rt.is_true(rt.equal(switch_val_2, rt.new_string('image/jpeg'))) {
			return (rt.call_function('imagejpeg', [var_image.clone(), var_filename.clone(), rt.call_function('apply_filters', [rt.new_string('jpeg_quality'), rt.new_int(90), rt.new_string('edit_image')])])).to_bool()
		} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('image/png'))) {
			return (rt.call_function('imagepng', [var_image.clone(), var_filename.clone()])).to_bool()
		} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('image/gif'))) {
			return (rt.call_function('imagegif', [var_image.clone(), var_filename.clone()])).to_bool()
		} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('image/webp'))) {
			if rt.is_true(rt.call_function('function_exists', [rt.new_string('imagewebp')])) {
				return (rt.call_function('imagewebp', [var_image.clone(), var_filename.clone()])).to_bool()
			}
			return false
		} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('image/avif'))) {
			if rt.is_true(rt.call_function('function_exists', [rt.new_string('imageavif')])) {
				return (rt.call_function('imageavif', [var_image.clone(), var_filename.clone()])).to_bool()
			}
			return false
		} else {
			return false
		}
	}
	return false
}

fn _image_get_preview_ratio(var_w rt.PhpVal, var_h rt.PhpVal) rt.PhpVal {
	mut var_max := rt.new_null()
	var_max = rt.call_function('max', [var_w.clone(), var_h.clone()])
	return if rt.is_true(rt.greater(var_max, rt.new_int(600))) { rt.div(rt.new_int(600), var_max) } else { rt.new_int(1) }
}

fn _rotate_image_resource(var_img_arg rt.PhpVal, var_angle rt.PhpVal) rt.PhpVal {
	mut var_img := var_img_arg
	mut var_rotated := rt.new_null()
	rt.call_function('_deprecated_function', [rt.new_string(@FN), rt.new_string('3.5.0'), rt.new_string('WP_Image_Editor::rotate()')])
	if rt.is_true(rt.call_function('function_exists', [rt.new_string('imagerotate')])) {
		var_rotated = rt.call_function('imagerotate', [var_img.clone(), var_angle.clone(), rt.new_int(0)])
		if rt.is_true(rt.call_function('is_gd_image', [var_rotated.clone()])) {
			if rt.is_true(rt.less(rt.get_constant('PHP_VERSION_ID'), rt.new_int(80000))) {
				rt.call_function('imagedestroy', [var_img.clone()])
			}
		var_img = var_rotated.clone()
		}
	}
	return var_img.clone()
}

fn _flip_image_resource(var_img_arg rt.PhpVal, var_horz rt.PhpVal, var_vert rt.PhpVal) rt.PhpVal {
	mut var_img := var_img_arg
	mut var_w := rt.new_null()
	mut var_h := rt.new_null()
	mut var_dst := rt.new_null()
	mut var_sx := rt.new_null()
	mut var_sy := rt.new_null()
	mut var_sw := rt.new_null()
	mut var_sh := rt.new_null()
	rt.call_function('_deprecated_function', [rt.new_string(@FN), rt.new_string('3.5.0'), rt.new_string('WP_Image_Editor::flip()')])
	var_w = rt.call_function('imagesx', [var_img.clone()])
	var_h = rt.call_function('imagesy', [var_img.clone()])
	var_dst = rt.call_function('wp_imagecreatetruecolor', [var_w.clone(), var_h.clone()])
	if rt.is_true(rt.call_function('is_gd_image', [var_dst.clone()])) {
		var_sx = if rt.is_true(var_vert) { rt.sub(var_w, rt.new_int(1)) } else { rt.new_int(0) }
		var_sy = if rt.is_true(var_horz) { rt.sub(var_h, rt.new_int(1)) } else { rt.new_int(0) }
		var_sw = if rt.is_true(var_vert) { rt.sub(rt.new_int(0), var_w) } else { var_w }
		var_sh = if rt.is_true(var_horz) { rt.sub(rt.new_int(0), var_h) } else { var_h }
		if rt.is_true(rt.call_function('imagecopyresampled', [var_dst.clone(), var_img.clone(), rt.new_int(0), rt.new_int(0), var_sx.clone(), var_sy.clone(), var_w.clone(), var_h.clone(), var_sw.clone(), var_sh.clone()])) {
			if rt.is_true(rt.less(rt.get_constant('PHP_VERSION_ID'), rt.new_int(80000))) {
				rt.call_function('imagedestroy', [var_img.clone()])
			}
		var_img = var_dst.clone()
		}
	}
	return var_img.clone()
}

fn _crop_image_resource(var_img_arg rt.PhpVal, var_x rt.PhpVal, var_y rt.PhpVal, var_w rt.PhpVal, var_h rt.PhpVal) rt.PhpVal {
	mut var_img := var_img_arg
	mut var_dst := rt.new_null()
	var_dst = rt.call_function('wp_imagecreatetruecolor', [var_w.clone(), var_h.clone()])
	if rt.is_true(rt.call_function('is_gd_image', [var_dst.clone()])) {
		if rt.is_true(rt.call_function('imagecopy', [var_dst.clone(), var_img.clone(), rt.new_int(0), rt.new_int(0), var_x.clone(), var_y.clone(), var_w.clone(), var_h.clone()])) {
			if rt.is_true(rt.less(rt.get_constant('PHP_VERSION_ID'), rt.new_int(80000))) {
				rt.call_function('imagedestroy', [var_img.clone()])
			}
		var_img = var_dst.clone()
		}
	}
	return var_img.clone()
}

fn image_edit_apply_changes(var_image_arg rt.PhpVal, var_changes_arg rt.PhpVal) rt.PhpVal {
	mut var_image := var_image_arg
	mut var_changes := var_changes_arg
	mut var_obj := rt.new_null()
	mut var_key := rt.new_null()
	mut var_filtered := rt.new_null()
	mut var_combined := false
	mut var_i := i64(0)
	mut var_j := i64(0)
	mut var_c := i64(0)
	mut var_operation := rt.new_null()
	mut var_sel := rt.new_null()
	mut var_size := rt.new_null()
	mut var_w := rt.new_null()
	mut var_h := rt.new_null()
	mut var_scale := rt.new_null()
	if rt.is_true(rt.call_function('is_gd_image', [var_image.clone()])) {
		rt.call_function('_deprecated_argument', [rt.new_string(@FN), rt.new_string('3.5.0'), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('%1$s needs to be a %2$s object.')]), rt.new_string('$image'), rt.new_string('WP_Image_Editor')])])
	}
	if !(var_changes.clone().is_array()) {
		return var_image.clone()
	}
	mut iter_1 := var_changes.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_obj_shadow := item_1.val
		mut var_key_shadow := item_1.key
		if !(rt.get_property(var_obj_shadow, 'r')).is_null() {
			rt.set_property(var_obj_shadow, 'type', rt.new_string('rotate'))
			rt.set_property(var_obj_shadow, 'angle', rt.get_property(var_obj_shadow, 'r'))
			rt.get_property(var_obj_shadow, 'r') = rt.new_null()
		} else if !(rt.get_property(var_obj_shadow, 'f')).is_null() {
			rt.set_property(var_obj_shadow, 'type', rt.new_string('flip'))
			rt.set_property(var_obj_shadow, 'axis', rt.get_property(var_obj_shadow, 'f'))
			rt.get_property(var_obj_shadow, 'f') = rt.new_null()
		} else if !(rt.get_property(var_obj_shadow, 'c')).is_null() {
			rt.set_property(var_obj_shadow, 'type', rt.new_string('crop'))
			rt.set_property(var_obj_shadow, 'sel', rt.get_property(var_obj_shadow, 'c'))
			rt.get_property(var_obj_shadow, 'c') = rt.new_null()
		}
		var_changes.array_set(var_key_shadow, var_obj_shadow.clone())
	}
	if var_changes.clone().array_count() > 1 {
		var_filtered = rt.create_array([rt.ArrayItem{ key: none, val: var_changes.array_get(rt.new_int(0)) }])
		var_i = 0
		var_j = 1
		var_c = var_changes.clone().array_count()
		for {
			if !(var_j < var_c) { break }
			var_combined = false
			if rt.is_true(rt.identical(rt.get_property(var_filtered.array_get(rt.new_int(var_i)), 'type'), rt.get_property(var_changes.array_get(rt.new_int(var_j)), 'type'))) {
				mut switch_val_3 := rt.get_property(var_filtered.array_get(rt.new_int(var_i)), 'type')
				if rt.is_true(rt.equal(switch_val_3, rt.new_string('rotate'))) {
					rt.get_property(var_filtered.array_get(rt.new_int(var_i)), 'angle') = rt.add(rt.get_property(var_filtered.array_get(rt.new_int(var_i)), 'angle'), rt.get_property(var_changes.array_get(rt.new_int(var_j)), 'angle'))
				var_combined = true
				} else if rt.is_true(rt.equal(switch_val_3, rt.new_string('flip'))) {
					rt.new_null()
				var_combined = true
				}
			}
			if !(var_combined) {
				var_filtered.array_set(rt.pre_inc(rt.new_int(var_i)), var_changes.array_get(rt.new_int(var_j)))
			}
			var_j += 1
		}
		var_changes = var_filtered.clone()
		var_filtered = rt.new_null()
	}
	if rt.is_true(rt.new_bool(rt.instance_of(var_image, 'WP_Image_Editor'))) {
	var_image = rt.call_function('apply_filters', [rt.new_string('wp_image_editor_before_change'), var_image.clone(), var_changes.clone()])
	} else if rt.is_true(rt.call_function('is_gd_image', [var_image.clone()])) {
	var_image = rt.call_function('apply_filters_deprecated', [rt.new_string('image_edit_before_change'), rt.create_array([rt.ArrayItem{ key: none, val: var_image }, rt.ArrayItem{ key: none, val: var_changes }]), rt.new_string('3.5.0'), rt.new_string('wp_image_editor_before_change')])
	}
	mut iter_2 := var_changes.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_operation_shadow := item_2.val
		mut switch_val_4 := rt.get_property(var_operation_shadow, 'type')
		if rt.is_true(rt.equal(switch_val_4, rt.new_string('rotate'))) {
			if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int(0), rt.get_property(var_operation_shadow, 'angle'))))) {
				if rt.is_true(rt.new_bool(rt.instance_of(var_image, 'WP_Image_Editor'))) {
					rt.call_method(var_image, 'rotate', [rt.get_property(var_operation_shadow, 'angle')])
				} else {
				var_image = _rotate_image_resource(var_image.clone(), rt.get_property(var_operation_shadow, 'angle'))
				}
			}
		} else if rt.is_true(rt.equal(switch_val_4, rt.new_string('flip'))) {
			if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int(0), rt.get_property(var_operation_shadow, 'axis'))))) {
				if rt.is_true(rt.new_bool(rt.instance_of(var_image, 'WP_Image_Editor'))) {
					rt.call_method(var_image, 'flip', [rt.new_bool(rt.bitwise_and(rt.get_property(var_operation_shadow, 'axis'), rt.new_int(1)) != 0), rt.new_bool(rt.bitwise_and(rt.get_property(var_operation_shadow, 'axis'), rt.new_int(2)) != 0)])
				} else {
				var_image = _flip_image_resource(var_image.clone(), rt.new_bool(rt.bitwise_and(rt.get_property(var_operation_shadow, 'axis'), rt.new_int(1)) != 0), rt.new_bool(rt.bitwise_and(rt.get_property(var_operation_shadow, 'axis'), rt.new_int(2)) != 0))
				}
			}
		} else if rt.is_true(rt.equal(switch_val_4, rt.new_string('crop'))) {
			var_sel = rt.get_property(var_operation_shadow, 'sel')
			if rt.is_true(rt.new_bool(rt.instance_of(var_image, 'WP_Image_Editor'))) {
				var_size = rt.call_method(var_image, 'get_size', []rt.PhpVal{})
				var_w = var_size.array_get(rt.new_string('width'))
				var_h = var_size.array_get(rt.new_string('height'))
				var_scale = if !(rt.get_property(var_sel, 'r')).is_null() { rt.get_property(var_sel, 'r') } else { rt.div(rt.new_int(1), _image_get_preview_ratio(var_w.clone(), var_h.clone())) }
				rt.call_method(var_image, 'crop', [rt.new_int((rt.mul(rt.get_property(var_sel, 'x'), var_scale)).to_i64()), rt.new_int((rt.mul(rt.get_property(var_sel, 'y'), var_scale)).to_i64()), rt.new_int((rt.mul(rt.get_property(var_sel, 'w'), var_scale)).to_i64()), rt.new_int((rt.mul(rt.get_property(var_sel, 'h'), var_scale)).to_i64())])
			} else {
			var_scale = if !(rt.get_property(var_sel, 'r')).is_null() { rt.get_property(var_sel, 'r') } else { rt.div(rt.new_int(1), _image_get_preview_ratio(rt.call_function('imagesx', [var_image.clone()]), rt.call_function('imagesy', [var_image.clone()]))) }
			var_image = _crop_image_resource(var_image.clone(), rt.mul(rt.get_property(var_sel, 'x'), var_scale), rt.mul(rt.get_property(var_sel, 'y'), var_scale), rt.mul(rt.get_property(var_sel, 'w'), var_scale), rt.mul(rt.get_property(var_sel, 'h'), var_scale))
			}
		}
	}
	return var_image.clone()
}

fn stream_preview_image(var_post_id rt.PhpVal) bool {
	mut var_post := rt.new_null()
	mut var_img := rt.new_null()
	mut var_changes := rt.new_null()
	mut var_size := rt.new_null()
	mut var_w := rt.new_null()
	mut var_h := rt.new_null()
	mut var_ratio := rt.new_null()
	mut var_w2 := rt.new_null()
	mut var_h2 := rt.new_null()
	var_post = rt.call_function('get_post', [var_post_id.clone()])
	rt.call_function('wp_raise_memory_limit', [rt.new_string('admin')])
	var_img = rt.call_function('wp_get_image_editor', [rt.call_function('_load_image_to_edit_path', [var_post_id.clone()])])
	if rt.is_true(rt.call_function('is_wp_error', [var_img.clone()])) {
		return false
	}
	var_changes = if !(!rt.is_true(rt.get_superglobal('_REQUEST').array_get(rt.new_string('history')))) { rt.call_function('json_decode', [rt.call_function('wp_unslash', [rt.get_superglobal('_REQUEST').array_get(rt.new_string('history'))])]) } else { rt.new_null() }
	if rt.is_true(var_changes) {
	var_img = image_edit_apply_changes(var_img.clone(), var_changes.clone())
	}
	var_size = rt.call_method(var_img, 'get_size', []rt.PhpVal{})
	var_w = var_size.array_get(rt.new_string('width'))
	var_h = var_size.array_get(rt.new_string('height'))
	var_ratio = _image_get_preview_ratio(var_w.clone(), var_h.clone())
	var_w2 = rt.call_function('max', [rt.new_int(1), rt.mul(var_w, var_ratio)])
	var_h2 = rt.call_function('max', [rt.new_int(1), rt.mul(var_h, var_ratio)])
	if rt.is_true(rt.call_function('is_wp_error', [rt.call_method(var_img, 'resize', [var_w2.clone(), var_h2.clone()])])) {
		return false
	}
	return wp_stream_image(var_img.clone(), rt.get_property(var_post, 'post_mime_type'), var_post_id.clone())
}

fn wp_restore_image(var_post_id rt.PhpVal) rt.PhpVal {
	mut var_meta := rt.new_null()
	mut var_file := rt.new_null()
	mut var_backup_sizes := rt.new_null()
	mut var_old_backup_sizes := rt.new_null()
	mut var_restored := rt.new_null()
	mut var_msg := rt.new_null()
	mut var_parts := rt.new_null()
	mut var_suffix := rt.new_null()
	mut var_default_sizes := rt.new_null()
	mut var_data := rt.new_null()
	mut var_restored_file := rt.new_null()
	mut var_default_size := rt.new_null()
	mut var_delete_file := rt.new_null()
	var_meta = rt.call_function('wp_get_attachment_metadata', [var_post_id.clone()])
	var_file = rt.call_function('get_attached_file', [var_post_id.clone()])
	var_backup_sizes = rt.call_function('get_post_meta', [var_post_id.clone(), rt.new_string('_wp_attachment_backup_sizes'), rt.new_bool(true)])
	var_old_backup_sizes = var_backup_sizes.clone()
	var_restored = rt.new_bool(false)
	var_msg = create_stdclass()
	if !(var_backup_sizes.clone().is_array()) {
		rt.set_property(var_msg, 'error', rt.call_function('__', [rt.new_string('Cannot load image metadata.')]))
		return mut var_msg
	}
	var_parts = rt.call_function('pathinfo', [var_file.clone()])
	var_suffix = rt.new_string((rt.call_function('time', []rt.PhpVal{})).str() + (rt.call_function('rand', [rt.new_int(100), rt.new_int(999)])).str())
	var_default_sizes = rt.call_function('get_intermediate_image_sizes', []rt.PhpVal{})
	if var_backup_sizes.array_isset(rt.new_string('full-orig')) && var_backup_sizes.array_get(rt.new_string('full-orig')).is_array() {
		var_data = var_backup_sizes.array_get(rt.new_string('full-orig'))
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_parts.array_get(rt.new_string('basename')), var_data.array_get(rt.new_string('file')))))) {
			if rt.is_true(rt.call_function('defined', [rt.new_string('IMAGE_EDIT_OVERWRITE')])) && rt.is_true(rt.get_constant('IMAGE_EDIT_OVERWRITE')) {
				if rt.is_true(rt.call_function('preg_match', [rt.new_string('/-e[0-9]{13}\\./'), var_parts.array_get(rt.new_string('basename'))])) {
					rt.call_function('wp_delete_file', [var_file.clone()])
				}
			} else if var_meta.array_isset(rt.new_string('width')) && var_meta.array_isset(rt.new_string('height')) {
				var_backup_sizes.array_set("full-${var_suffix.to_string()}", rt.create_array([rt.ArrayItem{ key: 'width', val: var_meta.array_get(rt.new_string('width')) }, rt.ArrayItem{ key: 'height', val: var_meta.array_get(rt.new_string('height')) }, rt.ArrayItem{ key: 'filesize', val: var_meta.array_get(rt.new_string('filesize')) }, rt.ArrayItem{ key: 'file', val: var_parts.array_get(rt.new_string('basename')) }]))
			}
		}
		var_restored_file = rt.call_function('path_join', [var_parts.array_get(rt.new_string('dirname')), var_data.array_get(rt.new_string('file'))])
		var_restored = rt.call_function('update_attached_file', [var_post_id.clone(), var_restored_file.clone()])
		var_meta.array_set('file', rt.call_function('_wp_relative_upload_path', [var_restored_file.clone()]))
		var_meta.array_set('width', var_data.array_get(rt.new_string('width')))
		var_meta.array_set('height', var_data.array_get(rt.new_string('height')))
		if var_data.array_isset(rt.new_string('filesize')) {
			var_meta.array_set('filesize', var_data.array_get(rt.new_string('filesize')))
		}
	}
	mut iter_3 := var_default_sizes.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_default_size_shadow := item_3.val
		if var_backup_sizes.array_isset(rt.new_string("${var_default_size.to_string()}-orig")) {
			var_data = var_backup_sizes.array_get(rt.new_string("${var_default_size.to_string()}-orig"))
			if var_meta.array_get(rt.new_string('sizes')).array_isset(var_default_size_shadow) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_meta.array_get(rt.new_string('sizes')).array_get(var_default_size_shadow).array_get(rt.new_string('file')), var_data.array_get(rt.new_string('file')))))) {
				if rt.is_true(rt.call_function('defined', [rt.new_string('IMAGE_EDIT_OVERWRITE')])) && rt.is_true(rt.get_constant('IMAGE_EDIT_OVERWRITE')) {
					if rt.is_true(rt.call_function('preg_match', [rt.new_string('/-e[0-9]{13}-/'), var_meta.array_get(rt.new_string('sizes')).array_get(var_default_size_shadow).array_get(rt.new_string('file'))])) {
						var_delete_file = rt.call_function('path_join', [var_parts.array_get(rt.new_string('dirname')), var_meta.array_get(rt.new_string('sizes')).array_get(var_default_size_shadow).array_get(rt.new_string('file'))])
						rt.call_function('wp_delete_file', [var_delete_file.clone()])
					}
				} else {
					var_backup_sizes.array_set("${var_default_size.to_string()}-${var_suffix.to_string()}", var_meta.array_get(rt.new_string('sizes')).array_get(var_default_size_shadow))
				}
			}
			var_meta.array_get_mut('sizes').array_set(var_default_size_shadow, var_data.clone())
		} else {
			var_meta.array_get(rt.new_string('sizes')).array_unset(var_default_size_shadow)
		}
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_update_attachment_metadata', [var_post_id.clone(), var_meta.clone()]))))) || (rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_old_backup_sizes, var_backup_sizes)))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('update_post_meta', [var_post_id.clone(), rt.new_string('_wp_attachment_backup_sizes'), var_backup_sizes.clone()])))))) {
		rt.set_property(var_msg, 'error', rt.call_function('__', [rt.new_string('Cannot save image metadata.')]))
		return mut var_msg
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_restored)))) {
		rt.set_property(var_msg, 'error', rt.call_function('__', [rt.new_string('Image metadata is inconsistent.')]))
	} else {
		rt.set_property(var_msg, 'msg', rt.call_function('__', [rt.new_string('Image restored successfully.')]))
		if rt.is_true(rt.call_function('defined', [rt.new_string('IMAGE_EDIT_OVERWRITE')])) && rt.is_true(rt.get_constant('IMAGE_EDIT_OVERWRITE')) {
			rt.call_function('delete_post_meta', [var_post_id.clone(), rt.new_string('_wp_attachment_backup_sizes')])
		}
	}
	return mut var_msg
}

fn wp_save_image(var_post_id rt.PhpVal) rt.PhpVal {
	mut var__wp_additional_image_sizes := rt.new_null()
	mut var_return := rt.new_null()
	mut var_success := false
	mut var_delete := false
	mut var_scaled := false
	mut var_nocrop := false
	mut var_post := rt.new_null()
	mut var_img := rt.new_null()
	mut var_full_width := rt.new_null()
	mut var_full_height := rt.new_null()
	mut var_target := rt.new_null()
	mut var_scale := false
	mut var_edit_thumbnails_separately := rt.new_null()
	mut var_size := rt.new_null()
	mut var_original_width := rt.new_null()
	mut var_original_height := rt.new_null()
	mut var_diff := rt.new_null()
	mut var_changes := rt.new_null()
	mut var_meta := rt.new_null()
	mut var_backup_sizes := rt.new_null()
	mut var_path := rt.new_null()
	mut var_basename := rt.new_null()
	mut var_dirname := rt.new_null()
	mut var_ext := rt.new_null()
	mut var_filename := rt.new_null()
	mut var_suffix := rt.new_null()
	mut var_new_path := rt.new_null()
	mut var_new_filename := ''
	mut var_saved_image := false
	mut var_tag := rt.new_null()
	mut var_sizes := rt.new_null()
	mut var_delete_file := rt.new_null()
	mut var__sizes := rt.new_null()
	mut var_width := rt.new_null()
	mut var_height := rt.new_null()
	mut var_crop := rt.new_null()
	mut var_thumb_url := rt.new_null()
	mut var_file_url := rt.new_null()
	mut var_thumb := rt.new_null()
	var__wp_additional_image_sizes = rt.call_function('wp_get_additional_image_sizes', []rt.PhpVal{})
	var_return = create_stdclass()
	var_success = false
	var_delete = false
	var_scaled = false
	var_nocrop = false
	var_post = rt.call_function('get_post', [var_post_id.clone()])
	var_img = rt.call_function('wp_get_image_editor', [rt.call_function('_load_image_to_edit_path', [var_post_id.clone(), rt.new_string('full')])])
	if rt.is_true(rt.call_function('is_wp_error', [var_img.clone()])) {
		rt.set_property(var_return, 'error', rt.call_function('esc_js', [rt.call_function('__', [rt.new_string('Unable to create new image.')])]))
		return mut var_return
	}
	var_full_width = rt.new_int(if !(!rt.is_true(rt.get_superglobal('_REQUEST').array_get(rt.new_string('fwidth')))) { rt.new_int((rt.get_superglobal('_REQUEST').array_get(rt.new_string('fwidth'))).to_i64()) } else { 0 })
	var_full_height = rt.new_int(if !(!rt.is_true(rt.get_superglobal('_REQUEST').array_get(rt.new_string('fheight')))) { rt.new_int((rt.get_superglobal('_REQUEST').array_get(rt.new_string('fheight'))).to_i64()) } else { 0 })
	var_target = if !(!rt.is_true(rt.get_superglobal('_REQUEST').array_get(rt.new_string('target')))) { rt.call_function('preg_replace', [rt.new_string('/[^a-z0-9_-]+/i'), rt.new_string(''), rt.get_superglobal('_REQUEST').array_get(rt.new_string('target'))]) } else { rt.new_string('') }
	var_scale = !(!rt.is_true(rt.get_superglobal('_REQUEST').array_get(rt.new_string('do')))) && rt.is_true(rt.identical(rt.new_string('scale'), rt.get_superglobal('_REQUEST').array_get(rt.new_string('do'))))
	var_edit_thumbnails_separately = rt.new_bool((rt.call_function('apply_filters', [rt.new_string('image_edit_thumbnails_separately'), rt.new_bool(false)])).to_bool())
	if var_scale {
		var_size = rt.call_method(var_img, 'get_size', []rt.PhpVal{})
		var_original_width = var_size.array_get(rt.new_string('width'))
		var_original_height = var_size.array_get(rt.new_string('height'))
		if rt.is_true(rt.greater(var_full_width, var_original_width)) || rt.is_true(rt.greater(var_full_height, var_original_height)) {
			rt.set_property(var_return, 'error', rt.call_function('esc_js', [rt.call_function('__', [rt.new_string('Images cannot be scaled to a size larger than the original.')])]))
			return mut var_return
		}
		if rt.is_true(rt.greater(var_full_width, rt.new_int(0))) && rt.is_true(rt.greater(var_full_height, rt.new_int(0))) {
			var_diff = rt.sub(rt.call_function('round', [rt.div(var_original_width, var_original_height), rt.new_int(2)]), rt.call_function('round', [rt.div(var_full_width, var_full_height), rt.new_int(2)]))
			if rt.is_true(rt.less(-0.1, var_diff)) && rt.is_true(rt.less(var_diff, rt.new_float(0.1))) {
				if rt.is_true(rt.call_method(var_img, 'resize', [var_full_width.clone(), var_full_height.clone()])) {
				var_scaled = true
				}
			}
			if !(var_scaled) {
				rt.set_property(var_return, 'error', rt.call_function('esc_js', [rt.call_function('__', [rt.new_string('Error while saving the scaled image. Please reload the page and try again.')])]))
				return mut var_return
			}
		}
	} else if !(!rt.is_true(rt.get_superglobal('_REQUEST').array_get(rt.new_string('history')))) {
		var_changes = rt.call_function('json_decode', [rt.call_function('wp_unslash', [rt.get_superglobal('_REQUEST').array_get(rt.new_string('history'))])])
		if rt.is_true(var_changes) {
		var_img = image_edit_apply_changes(var_img.clone(), var_changes.clone())
		}
	} else {
		rt.set_property(var_return, 'error', rt.call_function('esc_js', [rt.call_function('__', [rt.new_string('Nothing to save, the image has not changed.')])]))
		return mut var_return
	}
	var_meta = rt.call_function('wp_get_attachment_metadata', [var_post_id.clone()])
	var_backup_sizes = rt.call_function('get_post_meta', [rt.get_property(var_post, 'ID'), rt.new_string('_wp_attachment_backup_sizes'), rt.new_bool(true)])
	if !(var_meta.clone().is_array()) {
		rt.set_property(var_return, 'error', rt.call_function('esc_js', [rt.call_function('__', [rt.new_string('Image data does not exist. Please re-upload the image.')])]))
		return mut var_return
	}
	if !(var_backup_sizes.clone().is_array()) {
	var_backup_sizes = rt.new_array()
	}
	var_path = rt.call_function('get_attached_file', [var_post_id.clone()])
	var_basename = rt.call_function('pathinfo', [var_path.clone(), rt.get_constant('PATHINFO_BASENAME')])
	var_dirname = rt.call_function('pathinfo', [var_path.clone(), rt.get_constant('PATHINFO_DIRNAME')])
	var_ext = rt.call_function('pathinfo', [var_path.clone(), rt.get_constant('PATHINFO_EXTENSION')])
	var_filename = rt.call_function('pathinfo', [var_path.clone(), rt.get_constant('PATHINFO_FILENAME')])
	var_suffix = rt.new_string((rt.call_function('time', []rt.PhpVal{})).str() + (rt.call_function('rand', [rt.new_int(100), rt.new_int(999)])).str())
	if rt.is_true(rt.call_function('defined', [rt.new_string('IMAGE_EDIT_OVERWRITE')])) && rt.is_true(rt.get_constant('IMAGE_EDIT_OVERWRITE')) && var_backup_sizes.array_isset(rt.new_string('full-orig')) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_backup_sizes.array_get(rt.new_string('full-orig')).array_get(rt.new_string('file')), var_basename)))) {
		if rt.is_true(var_edit_thumbnails_separately) && rt.is_true(rt.identical(rt.new_string('thumbnail'), var_target)) {
		var_new_path = rt.new_string("${var_dirname.to_string()}/${var_filename.to_string()}-temp.${var_ext.to_string()}")
		} else {
		var_new_path = var_path.clone()
		}
	} else {
		for true {
			var_filename = rt.call_function('preg_replace', [rt.new_string('/-e([0-9]+)$/'), rt.new_string(''), var_filename.clone()])
			var_filename = rt.concat(var_filename, rt.new_string("-e${var_suffix.to_string()}"))
			var_new_filename = "${var_filename.to_string()}.${var_ext.to_string()}"
			var_new_path = rt.new_string("${var_dirname.to_string()}/${var_new_filename}")
			if rt.is_true(rt.call_function('file_exists', [var_new_path.clone()])) {
				rt.pre_inc(var_suffix)
			} else {
				break
			}
		}
	}
	var_saved_image = wp_save_image_file(var_new_path.clone(), var_img.clone(), rt.get_property(var_post, 'post_mime_type'), var_post_id.clone())
	if !(var_saved_image) {
		rt.set_property(var_return, 'error', rt.call_function('esc_js', [rt.call_function('__', [rt.new_string('Unable to save the image.')])]))
		return mut var_return
	}
	if rt.is_true(rt.identical(rt.new_string('nothumb'), var_target)) || rt.is_true(rt.identical(rt.new_string('all'), var_target)) || rt.is_true(rt.identical(rt.new_string('full'), var_target)) || var_scaled {
		var_tag = rt.new_bool(false)
		if var_backup_sizes.array_isset(rt.new_string('full-orig')) {
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('IMAGE_EDIT_OVERWRITE')]))))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.get_constant('IMAGE_EDIT_OVERWRITE'))))) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_backup_sizes.array_get(rt.new_string('full-orig')).array_get(rt.new_string('file')), var_basename)))) {
			var_tag = rt.new_string("full-${var_suffix.to_string()}")
			}
		} else {
		var_tag = rt.new_string('full-orig')
		}
		if rt.is_true(var_tag) {
			var_backup_sizes.array_set(var_tag, rt.create_array([rt.ArrayItem{ key: 'width', val: var_meta.array_get(rt.new_string('width')) }, rt.ArrayItem{ key: 'height', val: var_meta.array_get(rt.new_string('height')) }, rt.ArrayItem{ key: 'filesize', val: var_meta.array_get(rt.new_string('filesize')) }, rt.ArrayItem{ key: 'file', val: var_basename }]))
		}
		var_success = rt.is_true(rt.identical(var_path, var_new_path)) || rt.is_true(rt.call_function('update_attached_file', [var_post_id.clone(), var_new_path.clone()]))
		var_meta.array_set('file', rt.call_function('_wp_relative_upload_path', [var_new_path.clone()]))
		var_size = rt.call_method(var_img, 'get_size', []rt.PhpVal{})
		var_meta.array_set('width', var_size.array_get(rt.new_string('width')))
		var_meta.array_set('height', var_size.array_get(rt.new_string('height')))
		var_meta.array_set('filesize', rt.new_bool(var_saved_image).array_get(rt.new_string('filesize')))
		if var_success && rt.is_true(rt.identical(rt.new_string('nothumb'), var_target)) || rt.is_true(rt.identical(rt.new_string('all'), var_target)) {
			var_sizes = rt.call_function('get_intermediate_image_sizes', []rt.PhpVal{})
			if rt.is_true(var_edit_thumbnails_separately) && rt.is_true(rt.identical(rt.new_string('nothumb'), var_target)) {
			var_sizes = rt.call_function('array_diff', [var_sizes.clone(), rt.create_array([rt.ArrayItem{ key: none, val: 'thumbnail' }])])
			}
		}
		rt.set_property(var_return, 'fw', var_meta.array_get(rt.new_string('width')))
		rt.set_property(var_return, 'fh', var_meta.array_get(rt.new_string('height')))
	} else if rt.is_true(var_edit_thumbnails_separately) && rt.is_true(rt.identical(rt.new_string('thumbnail'), var_target)) {
	var_sizes = rt.create_array([rt.ArrayItem{ key: none, val: 'thumbnail' }])
	var_success = true
	var_delete = true
	var_nocrop = true
	}
	if rt.is_true(rt.call_function('defined', [rt.new_string('IMAGE_EDIT_OVERWRITE')])) && rt.is_true(rt.get_constant('IMAGE_EDIT_OVERWRITE')) && !(!rt.is_true(var_meta.array_get(rt.new_string('sizes')))) {
		mut iter_4 := var_meta.array_get(rt.new_string('sizes')).iterator()
		for {
			item_4 := iter_4.next() or { break }
			mut var_size_shadow := item_4.val
			if !(!rt.is_true(var_size_shadow.array_get(rt.new_string('file')))) && rt.is_true(rt.call_function('preg_match', [rt.new_string('/-e[0-9]{13}-/'), var_size_shadow.array_get(rt.new_string('file'))])) {
				var_delete_file = rt.call_function('path_join', [var_dirname.clone(), var_size_shadow.array_get(rt.new_string('file'))])
				rt.call_function('wp_delete_file', [var_delete_file.clone()])
			}
		}
	}
	if !(var_sizes).is_null() {
		var__sizes = rt.new_array()
		mut iter_5 := var_sizes.iterator()
		for {
			item_5 := iter_5.next() or { break }
			mut var_size_shadow := item_5.val
			var_tag = rt.new_bool(false)
			if var_meta.array_get(rt.new_string('sizes')).array_isset(var_size_shadow) {
				if var_backup_sizes.array_isset(rt.new_string("${var_size.to_string()}-orig")) {
					if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('IMAGE_EDIT_OVERWRITE')]))))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.get_constant('IMAGE_EDIT_OVERWRITE'))))) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_backup_sizes.array_get(rt.new_string("${var_size.to_string()}-orig")).array_get(rt.new_string('file')), var_meta.array_get(rt.new_string('sizes')).array_get(var_size_shadow).array_get(rt.new_string('file')))))) {
					var_tag = rt.new_string("${var_size.to_string()}-${var_suffix.to_string()}")
					}
				} else {
				var_tag = rt.new_string("${var_size.to_string()}-orig")
				}
				if rt.is_true(var_tag) {
					var_backup_sizes.array_set(var_tag, var_meta.array_get(rt.new_string('sizes')).array_get(var_size_shadow))
				}
			}
			if var__wp_additional_image_sizes.array_isset(var_size_shadow) {
			var_width = rt.new_int((var__wp_additional_image_sizes.array_get(var_size_shadow).array_get(rt.new_string('width'))).to_i64())
			var_height = rt.new_int((var__wp_additional_image_sizes.array_get(var_size_shadow).array_get(rt.new_string('height'))).to_i64())
			var_crop = if var_nocrop { rt.new_bool(false) } else { var__wp_additional_image_sizes.array_get(var_size_shadow).array_get(rt.new_string('crop')) }
			} else {
			var_height = rt.call_function('get_option', [rt.new_string("${var_size.to_string()}_size_h")])
			var_width = rt.call_function('get_option', [rt.new_string("${var_size.to_string()}_size_w")])
			var_crop = if var_nocrop { rt.new_bool(false) } else { rt.call_function('get_option', [rt.new_string("${var_size.to_string()}_crop")]) }
			}
			var__sizes.array_set(var_size_shadow, rt.create_array([rt.ArrayItem{ key: 'width', val: var_width }, rt.ArrayItem{ key: 'height', val: var_height }, rt.ArrayItem{ key: 'crop', val: var_crop }]))
		}
		var_meta.array_set('sizes', rt.call_function('array_merge', [var_meta.array_get(rt.new_string('sizes')), rt.call_method(var_img, 'multi_resize', [var__sizes.clone()])]))
	}
	var_img = rt.new_null()
	if var_success {
		rt.call_function('wp_update_attachment_metadata', [var_post_id.clone(), var_meta.clone()])
		rt.call_function('update_post_meta', [var_post_id.clone(), rt.new_string('_wp_attachment_backup_sizes'), var_backup_sizes.clone()])
		if rt.is_true(rt.identical(rt.new_string('thumbnail'), var_target)) || rt.is_true(rt.identical(rt.new_string('all'), var_target)) || rt.is_true(rt.identical(rt.new_string('full'), var_target)) {
			if !(!rt.is_true(rt.get_superglobal('_REQUEST').array_get(rt.new_string('context')))) && rt.is_true(rt.identical(rt.new_string('edit-attachment'), rt.get_superglobal('_REQUEST').array_get(rt.new_string('context')))) {
				var_thumb_url = rt.call_function('wp_get_attachment_image_src', [var_post_id.clone(), rt.create_array([rt.ArrayItem{ key: none, val: 900 }, rt.ArrayItem{ key: none, val: 600 }]), rt.new_bool(true)])
				rt.set_property(var_return, 'thumbnail', var_thumb_url.array_get(rt.new_int(0)))
			} else {
				var_file_url = rt.call_function('wp_get_attachment_url', [var_post_id.clone()])
				if !(!rt.is_true(var_meta.array_get(rt.new_string('sizes')).array_get(rt.new_string('thumbnail')))) {
					var_thumb = var_meta.array_get(rt.new_string('sizes')).array_get(rt.new_string('thumbnail'))
					rt.set_property(var_return, 'thumbnail', rt.call_function('path_join', [rt.call_function('dirname', [var_file_url.clone()]), var_thumb.array_get(rt.new_string('file'))]))
				} else {
					rt.set_property(var_return, 'thumbnail', rt.new_string("${var_file_url.to_string()}?w=128&h=128"))
				}
			}
		}
	} else {
	var_delete = true
	}
	if var_delete {
		rt.call_function('wp_delete_file', [var_new_path.clone()])
	}
	rt.set_property(var_return, 'msg', rt.call_function('esc_js', [rt.call_function('__', [rt.new_string('Image saved')])]))
	return mut var_return
}

struct Class_stdClass {
	rt.PhpObjectBase
}

fn create_stdclass(_args ...rt.PhpVal) &Class_stdClass {
	mut obj := &Class_stdClass{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
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
