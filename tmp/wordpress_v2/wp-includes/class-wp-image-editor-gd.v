import rt

struct Class_WP_Image_Editor_GD {
	rt.PhpObjectBase
pub mut:
	image rt.PhpVal = rt.new_null()
}

fn (mut this Class_WP_Image_Editor_GD) magic_destruct() {
	if rt.is_true(this.image) {
		if rt.is_true(rt.less(rt.get_constant('PHP_VERSION_ID'), rt.new_int(80000))) {
			rt.call_function('imagedestroy', [this.image])
		}
	}
}

fn Class_WP_Image_Editor_GD.test(var_args rt.PhpVal) bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('extension_loaded', [rt.new_string('gd')])))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('gd_info')]))))) {
		return false
	}
	if var_args.array_isset(rt.new_string('methods'))
		&& rt.is_true(rt.call_function('in_array', [rt.new_string('rotate'), var_args.array_get(rt.new_string('methods')), rt.new_bool(true)]))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('imagerotate')]))))) {
		return false
	}
	return true
}

fn Class_WP_Image_Editor_GD.supports_mime_type(var_mime_type rt.PhpVal) bool {
	mut var_image_types := rt.call_function('imagetypes', []rt.PhpVal{})
	mut switch_val_1 := var_mime_type
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('image/jpeg'))) {
		return rt.new_bool(rt.bitwise_and(var_image_types, rt.get_constant('IMG_JPG')) != 0)
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('image/png'))) {
		return rt.new_bool(rt.bitwise_and(var_image_types, rt.get_constant('IMG_PNG')) != 0)
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('image/gif'))) {
		return rt.new_bool(rt.bitwise_and(var_image_types, rt.get_constant('IMG_GIF')) != 0)
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('image/webp'))) {
		return rt.new_bool(rt.bitwise_and(var_image_types, rt.get_constant('IMG_WEBP')) != 0)
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('image/avif'))) {
		return
			rt.is_true(rt.new_bool(rt.bitwise_and(var_image_types, rt.get_constant('IMG_AVIF')) != 0))
			&& rt.is_true(rt.call_function('function_exists', [rt.new_string('imageavif')]))
	}
	return false
}

fn (mut this Class_WP_Image_Editor_GD) load() bool {
	if rt.is_true(this.image) {
		return true
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_file', [rt.get_property(rt.new_object('WP_Image_Editor_GD', ['WP_Image_Editor'], &this), 'file')])))))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('preg_match', [rt.new_string('|^https?://|'), rt.get_property(rt.new_object('WP_Image_Editor_GD', ['WP_Image_Editor'], &this), 'file')]))))) {
		return (create_wp_error(rt.new_string('error_loading_image'), rt.call_function('__', [
			rt.new_string('File does not exist?'),
		]),
			rt.get_property(rt.new_object('WP_Image_Editor_GD', ['WP_Image_Editor'], &this), 'file'))).to_bool()
	}
	rt.call_function('wp_raise_memory_limit', [rt.new_string('image')])
	mut var_file_contents := rt.call_function('file_get_contents', [
		rt.get_property(rt.new_object('WP_Image_Editor_GD', ['WP_Image_Editor'], &this), 'file'),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_file_contents)))) {
		return (create_wp_error(rt.new_string('error_loading_image'), rt.call_function('__', [
			rt.new_string('File does not exist?'),
		]),
			rt.get_property(rt.new_object('WP_Image_Editor_GD', ['WP_Image_Editor'], &this), 'file'))).to_bool()
	}
	if rt.is_true(rt.call_function('function_exists', [rt.new_string('imagecreatefromwebp')]))
		&& rt.is_true(rt.identical(rt.new_string('image/webp'), rt.call_function('wp_get_image_mime', [rt.get_property(rt.new_object('WP_Image_Editor_GD', ['WP_Image_Editor'], &this), 'file')]))) {
		this.image = rt.call_function('imagecreatefromwebp', [
			rt.get_property(rt.new_object('WP_Image_Editor_GD', ['WP_Image_Editor'], &this), 'file'),
		])
	} else if
		rt.is_true(rt.call_function('function_exists', [rt.new_string('imagecreatefromavif')]))
		&& rt.is_true(rt.identical(rt.new_string('image/avif'), rt.call_function('wp_get_image_mime', [rt.get_property(rt.new_object('WP_Image_Editor_GD', ['WP_Image_Editor'], &this), 'file')]))) {
		this.image = rt.call_function('imagecreatefromavif', [
			rt.get_property(rt.new_object('WP_Image_Editor_GD', ['WP_Image_Editor'], &this), 'file'),
		])
	} else {
		this.image = rt.call_function('imagecreatefromstring', [
			var_file_contents.clone()])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_gd_image', [this.image]))))) {
		return (create_wp_error(rt.new_string('invalid_image'), rt.call_function('__', [
			rt.new_string('File is not an image.'),
		]),
			rt.get_property(rt.new_object('WP_Image_Editor_GD', ['WP_Image_Editor'], &this), 'file'))).to_bool()
	}
	mut var_size := rt.call_function('wp_getimagesize', [
		rt.get_property(rt.new_object('WP_Image_Editor_GD', ['WP_Image_Editor'], &this), 'file'),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_size)))) {
		return (create_wp_error(rt.new_string('invalid_image'), rt.call_function('__', [
			rt.new_string('Could not read image size.'),
		]),
			rt.get_property(rt.new_object('WP_Image_Editor_GD', ['WP_Image_Editor'], &this), 'file'))).to_bool()
	}
	if rt.is_true(rt.call_function('function_exists', [rt.new_string('imagealphablending')]))
		&& rt.is_true(rt.call_function('function_exists', [rt.new_string('imagesavealpha')])) {
		rt.call_function('imagealphablending', [this.image, rt.new_bool(false)])
		rt.call_function('imagesavealpha', [this.image, rt.new_bool(true)])
	}
	this.update_size((var_size.array_get(rt.new_int(0))).to_bool(),
		(var_size.array_get(rt.new_int(1))).to_bool())
	this.dispatch_set_prop('mime_type', var_size.array_get(rt.new_string('mime')))
	return this.set_quality(rt.new_null(), rt.new_null())
}

fn (mut this Class_WP_Image_Editor_GD) update_size(width bool, height bool) rt.PhpVal {
	mut width_mutated := width
	mut height_mutated := height
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(width_mutated))))) {
		width_mutated = (rt.call_function('imagesx', [this.image])).to_bool()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(height_mutated))))) {
		height_mutated = (rt.call_function('imagesy', [this.image])).to_bool()
	}
	return this.Class_WP_Image_Editor.update_size(rt.new_bool(width_mutated),
		rt.new_bool(height_mutated))
}

fn (mut this Class_WP_Image_Editor_GD) resize(var_max_w rt.PhpVal, var_max_h rt.PhpVal, crop bool) bool {
	if rt.is_true(rt.identical(rt.get_property(rt.new_object('WP_Image_Editor_GD', ['WP_Image_Editor'], &this), 'size').array_get(rt.new_string('width')), var_max_w))
		&& rt.is_true(rt.identical(rt.get_property(rt.new_object('WP_Image_Editor_GD', ['WP_Image_Editor'], &this), 'size').array_get(rt.new_string('height')), var_max_h)) {
		return true
	}
	mut var_resized := this._resize(var_max_w.clone(), var_max_h.clone(), crop)
	if rt.is_true(rt.call_function('is_gd_image', [var_resized.clone()])) {
		if rt.is_true(rt.less(rt.get_constant('PHP_VERSION_ID'), rt.new_int(80000))) {
			rt.call_function('imagedestroy', [this.image])
		}
		this.image = var_resized.clone()
		return true
	} else if rt.is_true(rt.call_function('is_wp_error', [var_resized.clone()])) {
		return var_resized.to_bool()
	}
	return (create_wp_error(rt.new_string('image_resize_error'), rt.call_function('__', [
		rt.new_string('Image resize failed.'),
	]), rt.get_property(rt.new_object('WP_Image_Editor_GD', ['WP_Image_Editor'], &this), 'file'))).to_bool()
}

fn (mut this Class_WP_Image_Editor_GD) _resize(var_max_w rt.PhpVal, var_max_h rt.PhpVal, crop bool) rt.PhpVal {
	mut var_dst_x := rt.new_null()
	mut var_dst_y := rt.new_null()
	mut var_src_x := rt.new_null()
	mut var_src_y := rt.new_null()
	mut var_dst_w := rt.new_null()
	mut var_dst_h := rt.new_null()
	mut var_src_w := rt.new_null()
	mut var_src_h := rt.new_null()
	mut var_dims := rt.call_function('image_resize_dimensions', [
		rt.get_property(rt.new_object('WP_Image_Editor_GD', ['WP_Image_Editor'], &this), 'size').array_get(rt.new_string('width')),
		rt.get_property(rt.new_object('WP_Image_Editor_GD', ['WP_Image_Editor'], &this), 'size').array_get(rt.new_string('height')),
		var_max_w.clone(),
		var_max_h.clone(),
		rt.new_bool(crop),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_dims)))) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('error_getting_dimensions'), rt.call_function('__', [
			rt.new_string('Could not calculate resized image dimensions'),
		]),
			rt.get_property(rt.new_object('WP_Image_Editor_GD', ['WP_Image_Editor'], &this), 'file')))
	}
	mut list_tmp_1 := var_dims
	var_dst_x = list_tmp_1.array_get(0)
	var_dst_y = list_tmp_1.array_get(1)
	var_src_x = list_tmp_1.array_get(2)
	var_src_y = list_tmp_1.array_get(3)
	var_dst_w = list_tmp_1.array_get(4)
	var_dst_h = list_tmp_1.array_get(5)
	var_src_w = list_tmp_1.array_get(6)
	var_src_h = list_tmp_1.array_get(7)
	this.set_quality(rt.new_null(), rt.create_array([
		rt.ArrayItem{ key: 'width', val: var_dst_w },
		rt.ArrayItem{ key: 'height', val: var_dst_h },
	]))
	mut var_resized := rt.call_function('wp_imagecreatetruecolor', [
		var_dst_w.clone(), var_dst_h.clone()])
	rt.call_function('imagecopyresampled', [var_resized.clone(), this.image, var_dst_x.clone(),
		var_dst_y.clone(), var_src_x.clone(), var_src_y.clone(),
		var_dst_w.clone(), var_dst_h.clone(), var_src_w.clone(),
		var_src_h.clone()])
	if rt.is_true(rt.call_function('is_gd_image', [var_resized.clone()])) {
		this.update_size(var_dst_w.to_bool(), var_dst_h.to_bool())
		return var_resized.clone()
	}
	return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('image_resize_error'), rt.call_function('__', [
		rt.new_string('Image resize failed.'),
	]), rt.get_property(rt.new_object('WP_Image_Editor_GD', ['WP_Image_Editor'], &this), 'file')))
}

fn (mut this Class_WP_Image_Editor_GD) multi_resize(var_sizes rt.PhpVal) rt.PhpVal {
	mut var_metadata := rt.new_array()
	mut iter_1 := var_sizes.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_size_data := item_1.val
		mut var_size := item_1.key
		mut var_meta := this.make_subsize(var_size_data.clone())
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [
			var_meta.clone(),
		])))))
		{
			var_metadata.array_set(var_size, var_meta.clone())
		}
	}
	return var_metadata.clone()
}

fn (mut this Class_WP_Image_Editor_GD) make_subsize(var_size_data rt.PhpVal) rt.PhpVal {
	mut var_size_data_mutated := var_size_data
	if !(var_size_data_mutated.array_isset(rt.new_string('width')))
		&& !(var_size_data_mutated.array_isset(rt.new_string('height'))) {
		return create_wp_error(rt.new_string('image_subsize_create_error'), rt.call_function('__', [
			rt.new_string('Cannot resize the image. Both width and height are not set.'),
		]))
	}
	mut var_orig_size := rt.get_property(rt.new_object('WP_Image_Editor_GD', [
		'WP_Image_Editor',
	], &this), 'size')
	if !(var_size_data_mutated.array_isset(rt.new_string('width'))) {
		var_size_data_mutated.array_set('width', rt.new_null())
	}
	if !(var_size_data_mutated.array_isset(rt.new_string('height'))) {
		var_size_data_mutated.array_set('height', rt.new_null())
	}
	if !(var_size_data_mutated.array_isset(rt.new_string('crop'))) {
		var_size_data_mutated.array_set('crop', false)
	}
	mut var_resized := this._resize(var_size_data_mutated.array_get(rt.new_string('width')),
		var_size_data_mutated.array_get(rt.new_string('height')),
		(var_size_data_mutated.array_get(rt.new_string('crop'))).to_bool())
	if rt.is_true(rt.call_function('is_wp_error', [var_resized.clone()])) {
		mut var_saved := var_resized.clone()
	} else {
		var_saved = this._save(var_resized.clone(), rt.new_null(), rt.new_null())
		if rt.is_true(rt.less(rt.get_constant('PHP_VERSION_ID'), rt.new_int(80000))) {
			rt.call_function('imagedestroy', [var_resized.clone()])
		}
	}
	this.dispatch_set_prop('size', var_orig_size.clone())
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [
		var_saved.clone()])))))
	{
		var_saved.array_unset(rt.new_string('path'))
	}
	return var_saved.clone()
}

fn (mut this Class_WP_Image_Editor_GD) crop(var_src_x rt.PhpVal, var_src_y rt.PhpVal, var_src_w rt.PhpVal, var_src_h rt.PhpVal, var_dst_w rt.PhpVal, var_dst_h rt.PhpVal, src_abs bool) bool {
	mut var_dst_w_mutated := var_dst_w
	mut var_dst_h_mutated := var_dst_h
	if rt.is_true(rt.new_bool(!(rt.is_true(var_dst_w_mutated)))) {
		var_dst_w_mutated = var_src_w
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_dst_h_mutated)))) {
		var_dst_h_mutated = var_src_h
	}
	mut iter_2 := rt.create_array([rt.ArrayItem{ key: none, val: var_src_w },
		rt.ArrayItem{ key: none, val: var_src_h }, rt.ArrayItem{ key: none, val: var_dst_w_mutated },
		rt.ArrayItem{ key: none, val: var_dst_h_mutated }]).iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_value := item_2.val
		if !(var_value.clone().is_long() || var_value.clone().is_double())
			|| rt.new_int(var_value.to_i64()) <= 0 {
			return (create_wp_error(rt.new_string('image_crop_error'), rt.call_function('__', [
				rt.new_string('Image crop failed.'),
			]), rt.get_property(rt.new_object('WP_Image_Editor_GD', [
				'WP_Image_Editor',
			], &this), 'file'))).to_bool()
		}
	}
	mut var_dst := rt.call_function('wp_imagecreatetruecolor', [
		rt.new_int(var_dst_w_mutated.to_i64()),
		rt.new_int(var_dst_h_mutated.to_i64()),
	])
	if var_src_abs {
		var_src_w = rt.sub(var_src_w, var_src_x)
		var_src_h = rt.sub(var_src_h, var_src_y)
	}
	if rt.is_true(rt.call_function('function_exists', [rt.new_string('imageantialias')])) {
		rt.call_function('imageantialias', [var_dst.clone(), rt.new_bool(true)])
	}
	rt.call_function('imagecopyresampled', [var_dst.clone(), this.image, rt.new_int(0),
		rt.new_int(0), rt.new_int(var_src_x.to_i64()), rt.new_int(var_src_y.to_i64()),
		rt.new_int(var_dst_w_mutated.to_i64()), rt.new_int(var_dst_h_mutated.to_i64()),
		rt.new_int(var_src_w.to_i64()), rt.new_int(var_src_h.to_i64())])
	if rt.is_true(rt.call_function('is_gd_image', [var_dst.clone()])) {
		if rt.is_true(rt.less(rt.get_constant('PHP_VERSION_ID'), rt.new_int(80000))) {
			rt.call_function('imagedestroy', [this.image])
		}
		this.image = var_dst.clone()
		this.update_size(false, false)
		return true
	}
	return (create_wp_error(rt.new_string('image_crop_error'), rt.call_function('__', [
		rt.new_string('Image crop failed.'),
	]), rt.get_property(rt.new_object('WP_Image_Editor_GD', ['WP_Image_Editor'], &this), 'file'))).to_bool()
}

fn (mut this Class_WP_Image_Editor_GD) rotate(var_angle rt.PhpVal) bool {
	if rt.is_true(rt.call_function('function_exists', [rt.new_string('imagerotate')])) {
		mut var_transparency := rt.call_function('imagecolorallocatealpha', [this.image,
			rt.new_int(255), rt.new_int(255), rt.new_int(255),
			rt.new_int(127)])
		mut var_rotated := rt.call_function('imagerotate', [this.image, var_angle.clone(),
			var_transparency.clone()])
		if rt.is_true(rt.call_function('is_gd_image', [var_rotated.clone()])) {
			rt.call_function('imagealphablending', [var_rotated.clone(),
				rt.new_bool(true)])
			rt.call_function('imagesavealpha', [var_rotated.clone(),
				rt.new_bool(true)])
			if rt.is_true(rt.less(rt.get_constant('PHP_VERSION_ID'), rt.new_int(80000))) {
				rt.call_function('imagedestroy', [this.image])
			}
			this.image = var_rotated.clone()
			this.update_size(false, false)
			return true
		}
	}
	return (create_wp_error(rt.new_string('image_rotate_error'), rt.call_function('__', [
		rt.new_string('Image rotate failed.'),
	]), rt.get_property(rt.new_object('WP_Image_Editor_GD', ['WP_Image_Editor'], &this), 'file'))).to_bool()
}

fn (mut this Class_WP_Image_Editor_GD) flip(var_horz rt.PhpVal, var_vert rt.PhpVal) bool {
	mut var_w := rt.get_property(rt.new_object('WP_Image_Editor_GD', [
		'WP_Image_Editor',
	], &this), 'size').array_get(rt.new_string('width'))
	mut var_h := rt.get_property(rt.new_object('WP_Image_Editor_GD', [
		'WP_Image_Editor',
	], &this), 'size').array_get(rt.new_string('height'))
	mut var_dst := rt.call_function('wp_imagecreatetruecolor', [
		var_w.clone(), var_h.clone()])
	if rt.is_true(rt.call_function('is_gd_image', [var_dst.clone()])) {
		mut var_sx := if rt.is_true(var_vert) { rt.sub(var_w, rt.new_int(1)) } else { rt.new_int(0) }
		mut var_sy := if rt.is_true(var_horz) { rt.sub(var_h, rt.new_int(1)) } else { rt.new_int(0) }
		mut var_sw := if rt.is_true(var_vert) { rt.sub(rt.new_int(0), var_w) } else { var_w }
		mut var_sh := if rt.is_true(var_horz) { rt.sub(rt.new_int(0), var_h) } else { var_h }
		if rt.is_true(rt.call_function('imagecopyresampled', [
			var_dst.clone(), this.image, rt.new_int(0), rt.new_int(0),
			var_sx.clone(), var_sy.clone(), var_w.clone(), var_h.clone(),
			var_sw.clone(), var_sh.clone()]))
		{
			if rt.is_true(rt.less(rt.get_constant('PHP_VERSION_ID'), rt.new_int(80000))) {
				rt.call_function('imagedestroy', [this.image])
			}
			this.image = var_dst.clone()
			return true
		}
	}
	return (create_wp_error(rt.new_string('image_flip_error'), rt.call_function('__', [
		rt.new_string('Image flip failed.'),
	]), rt.get_property(rt.new_object('WP_Image_Editor_GD', ['WP_Image_Editor'], &this), 'file'))).to_bool()
}

fn (mut this Class_WP_Image_Editor_GD) save(var_destfilename rt.PhpVal, var_mime_type rt.PhpVal) rt.PhpVal {
	mut var_saved := this._save(this.image, var_destfilename.clone(), var_mime_type.clone())
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [
		var_saved.clone()])))))
	{
		this.dispatch_set_prop('file', var_saved.array_get(rt.new_string('path')))
		this.dispatch_set_prop('mime_type', var_saved.array_get(rt.new_string('mime-type')))
	}
	return var_saved.clone()
}

fn (mut this Class_WP_Image_Editor_GD) _save(var_image rt.PhpVal, var_filename rt.PhpVal, var_mime_type rt.PhpVal) rt.PhpVal {
	mut var_extension := rt.new_null()
	mut var_filename_mutated := var_filename
	mut list_tmp_2 := this.get_output_format(var_filename_mutated.clone(), var_mime_type.clone())
	var_filename_mutated = list_tmp_2.array_get(0)
	var_extension = list_tmp_2.array_get(1)
	var_mime_type = list_tmp_2.array_get(2)
	if rt.is_true(rt.new_bool(!(rt.is_true(var_filename_mutated)))) {
		var_filename_mutated = this.generate_filename(rt.new_null(), rt.new_null(),
			var_extension.clone())
	}
	if rt.is_true(rt.call_function('function_exists', [rt.new_string('imageinterlace')])) {
		rt.call_function('imageinterlace', [var_image.clone(),
			rt.call_function('apply_filters', [rt.new_string('image_save_progressive'),
				rt.new_bool(false), var_mime_type.clone()])])
	}
	if rt.is_true(rt.identical(rt.new_string('image/gif'), var_mime_type)) {
		if rt.is_true(rt.new_bool(!(rt.is_true(this.make_image(var_filename_mutated.clone(),
			rt.new_string('imagegif'), rt.create_array([
			rt.ArrayItem{ key: none, val: var_image },
			rt.ArrayItem{ key: none, val: var_filename_mutated },
		]))))))
		{
			return create_wp_error(rt.new_string('image_save_error'), rt.call_function('__', [
				rt.new_string('Image Editor Save Failed'),
			]))
		}
	} else if rt.is_true(rt.identical(rt.new_string('image/png'), var_mime_type)) {
		if rt.is_true(rt.call_function('function_exists', [rt.new_string('imageistruecolor')]))
			&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('imageistruecolor', [var_image.clone()]))))) {
			rt.call_function('imagetruecolortopalette', [var_image.clone(),
				rt.new_bool(false), rt.call_function('imagecolorstotal', [
					var_image.clone()])])
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(this.make_image(var_filename_mutated.clone(),
			rt.new_string('imagepng'), rt.create_array([
			rt.ArrayItem{ key: none, val: var_image },
			rt.ArrayItem{ key: none, val: var_filename_mutated },
		]))))))
		{
			return create_wp_error(rt.new_string('image_save_error'), rt.call_function('__', [
				rt.new_string('Image Editor Save Failed'),
			]))
		}
	} else if rt.is_true(rt.identical(rt.new_string('image/jpeg'), var_mime_type)) {
		if rt.is_true(rt.new_bool(!(rt.is_true(this.make_image(var_filename_mutated.clone(),
			rt.new_string('imagejpeg'), rt.create_array([
			rt.ArrayItem{ key: none, val: var_image },
			rt.ArrayItem{ key: none, val: var_filename_mutated },
			rt.ArrayItem{ key: none, val: this.get_quality() },
		]))))))
		{
			return create_wp_error(rt.new_string('image_save_error'), rt.call_function('__', [
				rt.new_string('Image Editor Save Failed'),
			]))
		}
	} else if rt.is_true(rt.identical(rt.new_string('image/webp'), var_mime_type)) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('imagewebp')]))))) || rt.is_true(rt.new_bool(!(rt.is_true(this.make_image(var_filename_mutated.clone(), rt.new_string('imagewebp'), rt.create_array([rt.ArrayItem{
			key: none
			val: var_image
		}, rt.ArrayItem{ key: none, val: var_filename_mutated }, rt.ArrayItem{
			key: none
			val: this.get_quality()
		}])))))) {
			return create_wp_error(rt.new_string('image_save_error'), rt.call_function('__', [
				rt.new_string('Image Editor Save Failed'),
			]))
		}
	} else if rt.is_true(rt.identical(rt.new_string('image/avif'), var_mime_type)) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('imageavif')]))))) || rt.is_true(rt.new_bool(!(rt.is_true(this.make_image(var_filename_mutated.clone(), rt.new_string('imageavif'), rt.create_array([rt.ArrayItem{
			key: none
			val: var_image
		}, rt.ArrayItem{ key: none, val: var_filename_mutated }, rt.ArrayItem{
			key: none
			val: this.get_quality()
		}])))))) {
			return create_wp_error(rt.new_string('image_save_error'), rt.call_function('__', [
				rt.new_string('Image Editor Save Failed'),
			]))
		}
	} else {
		return create_wp_error(rt.new_string('image_save_error'), rt.call_function('__', [
			rt.new_string('Image Editor Save Failed'),
		]))
	}
	mut var_stat := rt.call_function('stat', [
		rt.call_function('dirname', [var_filename_mutated.clone()]),
	])
	mut var_perms := rt.new_int(rt.bitwise_and(var_stat.array_get(rt.new_string('mode')),
		rt.new_int(438)))
	rt.call_function('chmod', [var_filename_mutated.clone(), var_perms.clone()])
	return rt.create_array([rt.ArrayItem{ key: 'path', val: var_filename_mutated },
		rt.ArrayItem{ key: 'file', val: rt.call_function('wp_basename', [
			rt.call_function('apply_filters', [
				rt.new_string('image_make_intermediate_size'),
				var_filename_mutated.clone(),
			]),
		]) }, rt.ArrayItem{ key: 'width', val: rt.get_property(rt.new_object('WP_Image_Editor_GD', [
			'WP_Image_Editor',
		], &this), 'size').array_get(rt.new_string('width')) },
		rt.ArrayItem{ key: 'height', val: rt.get_property(rt.new_object('WP_Image_Editor_GD', [
			'WP_Image_Editor',
		], &this), 'size').array_get(rt.new_string('height')) },
		rt.ArrayItem{ key: 'mime-type', val: var_mime_type },
		rt.ArrayItem{ key: 'filesize', val: rt.call_function('wp_filesize', [
			var_filename_mutated.clone(),
		]) }])
}

fn (mut this Class_WP_Image_Editor_GD) set_quality(var_quality rt.PhpVal, var_dims rt.PhpVal) bool {
	mut var_quality_mutated := var_quality
	mut var_dims_mutated := var_dims
	mut var_quality_result := this.Class_WP_Image_Editor.set_quality(var_quality_mutated.clone(),
		var_dims_mutated.clone())
	if rt.is_true(rt.call_function('is_wp_error', [var_quality_result.clone()])) {
		return var_quality_result.to_bool()
	} else {
		var_quality_mutated = this.get_quality()
	}
	if rt.is_true(rt.identical(rt.new_string('image/webp'), rt.get_property(rt.new_object('WP_Image_Editor_GD', ['WP_Image_Editor'], &this), 'mime_type')))
		&& rt.is_true(rt.call_function('defined', [rt.new_string('IMG_WEBP_LOSSLESS')])) {
		mut var_webp_info := rt.call_function('wp_get_webp_info', [
			rt.get_property(rt.new_object('WP_Image_Editor_GD', ['WP_Image_Editor'], &this), 'file'),
		])
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
		if !(!rt.is_true(var_webp_info.array_get(rt.new_string('type'))))
			&& rt.is_true(rt.identical(rt.new_string('lossless'), var_webp_info.array_get(rt.new_string('type')))) {
			var_quality_mutated = rt.get_constant('IMG_WEBP_LOSSLESS')
			if rt.has_exception() {
				unsafe {
					goto catch_label_1
				}
			}
			this.Class_WP_Image_Editor.set_quality(var_quality_mutated.clone(),
				var_dims_mutated.clone())
			if rt.has_exception() {
				unsafe {
					goto catch_label_1
				}
			}
		}
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
	}
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	unsafe {
		goto end_label_1
	}
	catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'Exception') {
		mut var_e := var_e_1.clone()
		return (create_wp_error(rt.new_string('image_quality_error'), rt.call_method(var_e,
			'getMessage', []rt.PhpVal{}))).to_bool()
		unsafe {
			goto end_label_1
		}
	} else {
		rt.throw_exception(var_e_1)
		unsafe {
			goto end_label_1
		}
	}

	end_label_1:
	this.dispatch_set_prop('quality', var_quality_mutated.clone())
	return true
}

fn (mut this Class_WP_Image_Editor_GD) stream(var_mime_type rt.PhpVal) rt.PhpVal {
	mut var_filename := rt.new_null()
	mut var_extension := rt.new_null()
	mut list_tmp_3 := this.get_output_format(rt.new_null(), var_mime_type.clone())
	var_filename = list_tmp_3.array_get(0)
	var_extension = list_tmp_3.array_get(1)
	var_mime_type = list_tmp_3.array_get(2)
	mut switch_val_2 := var_mime_type
	if rt.is_true(rt.equal(switch_val_2, rt.new_string('image/png'))) {
		rt.call_function('header', [rt.new_string('Content-Type: image/png')])
		return rt.call_function('imagepng', [this.image])
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('image/gif'))) {
		rt.call_function('header', [rt.new_string('Content-Type: image/gif')])
		return rt.call_function('imagegif', [this.image])
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('image/webp'))) {
		if rt.is_true(rt.call_function('function_exists', [rt.new_string('imagewebp')])) {
			rt.call_function('header', [rt.new_string('Content-Type: image/webp')])
			return rt.call_function('imagewebp', [this.image, rt.new_null(),
				this.get_quality()])
		} else {
			rt.call_function('header', [rt.new_string('Content-Type: image/jpeg')])
			return rt.call_function('imagejpeg', [this.image, rt.new_null(),
				this.get_quality()])
		}
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('image/avif'))) {
		if rt.is_true(rt.call_function('function_exists', [rt.new_string('imageavif')])) {
			rt.call_function('header', [rt.new_string('Content-Type: image/avif')])
			return rt.call_function('imageavif', [this.image, rt.new_null(),
				this.get_quality()])
		}
	} else {
		rt.call_function('header', [rt.new_string('Content-Type: image/jpeg')])
		return rt.call_function('imagejpeg', [this.image, rt.new_null(),
			this.get_quality()])
	}
	return rt.new_null()
}

fn (mut this Class_WP_Image_Editor_GD) make_image(var_filename rt.PhpVal, var_callback rt.PhpVal, var_arguments rt.PhpVal) rt.PhpVal {
	mut var_filename_mutated := var_filename
	mut var_arguments_mutated := var_arguments
	if rt.is_true(rt.call_function('wp_is_stream', [var_filename_mutated.clone()])) {
		var_arguments_mutated.array_set(1, rt.new_null())
	}
	return this.Class_WP_Image_Editor.make_image(var_filename_mutated.clone(),
		var_callback.clone(), var_arguments_mutated.clone())
}

struct Class_WP_Image_Editor {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

fn create_wp_image_editor_gd(_args ...rt.PhpVal) &Class_WP_Image_Editor_GD {
	mut obj := &Class_WP_Image_Editor_GD{
		PhpObjectBase: rt.PhpObjectBase{}
		image:         rt.new_null()
	}
	return obj
}

fn create_wp_image_editor(_args ...rt.PhpVal) &Class_WP_Image_Editor {
	mut obj := &Class_WP_Image_Editor{
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

fn (mut this Class_WP_Image_Editor_GD) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__destruct' {
			this.magic_destruct()
			return rt.new_null()
		}
		'test' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(Class_WP_Image_Editor_GD.test(dispatch_arg_0))
		}
		'supports_mime_type' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(Class_WP_Image_Editor_GD.supports_mime_type(dispatch_arg_0))
		}
		'load' {
			return rt.new_bool(this.load())
		}
		'update_size' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			return this.update_size(dispatch_arg_0, dispatch_arg_1)
		}
		'resize' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
			return rt.new_bool(this.resize(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2))
		}
		'_resize' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
			return this._resize(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'multi_resize' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.multi_resize(dispatch_arg_0)
		}
		'make_subsize' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.make_subsize(dispatch_arg_0)
		}
		'crop' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			dispatch_arg_4 := if args.len > 4 { args[4] } else { rt.new_null() }
			dispatch_arg_5 := if args.len > 5 { args[5] } else { rt.new_null() }
			dispatch_arg_6 := (if args.len > 6 { args[6] } else { rt.new_null() }).to_bool()
			return rt.new_bool(this.crop(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2,
				dispatch_arg_3, dispatch_arg_4, dispatch_arg_5, dispatch_arg_6))
		}
		'rotate' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.rotate(dispatch_arg_0))
		}
		'flip' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(this.flip(dispatch_arg_0, dispatch_arg_1))
		}
		'save' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.save(dispatch_arg_0, dispatch_arg_1)
		}
		'_save' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this._save(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'set_quality' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(this.set_quality(dispatch_arg_0, dispatch_arg_1))
		}
		'stream' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.stream(dispatch_arg_0)
		}
		'make_image' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.make_image(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		else {
			return none
		}
	}
}

fn (this &Class_WP_Image_Editor_GD) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'image' { return this.image }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_Image_Editor_GD) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'image' {
			this.image = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_WP_Image_Editor) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Image_Editor) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Image_Editor) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn main() {
	defer {
		rt.shutdown()
	}
}
