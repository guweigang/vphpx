import rt

struct Class_WP_Image_Editor_GD {
	rt.PhpObjectBase
pub mut:
		image rt.PhpVal = rt.new_null()
}

fn (mut this Class_WP_Image_Editor_GD) magic_destruct()  {
	if rt.is_true(this.image) {
		if rt.is_true(rt.less(rt.get_constant('PHP_VERSION_ID'), rt.new_int(80000))) {
			rt.call_function('imagedestroy', [this.image])
		}
	}
}

fn Class_WP_Image_Editor_GD.test(var_args rt.PhpVal) bool {
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('extension_loaded', [rt.new_string('gd')]))))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('gd_info')]))))))) {
		return false
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_args.array_isset(rt.new_string('methods')) && rt.is_true(rt.call_function('in_array', [rt.new_string('rotate'), var_args.array_get('methods'), rt.new_bool(true)])))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('imagerotate')]))))))) {
		return false
	}
	return true
}

fn Class_WP_Image_Editor_GD.supports_mime_type(var_mime_type rt.PhpVal) bool {
	mut var_image_types := rt.call_function('imagetypes', []rt.PhpVal{})
	mut switch_val_1 := var_mime_type
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('image/jpeg'))) {
		return (// unsupported expression: Expr_BinaryOp_NotIdentical).to_bool()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('image/png'))) {
		return (// unsupported expression: Expr_BinaryOp_NotIdentical).to_bool()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('image/gif'))) {
		return (// unsupported expression: Expr_BinaryOp_NotIdentical).to_bool()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('image/webp'))) {
		return (// unsupported expression: Expr_BinaryOp_NotIdentical).to_bool()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('image/avif'))) {
		return rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) && rt.is_true(rt.call_function('function_exists', [rt.new_string('imageavif')]))
	}
	return false
}

fn (mut this Class_WP_Image_Editor_GD) load() bool {
	if rt.is_true(this.image) {
		return true
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_file', [rt.get_property(rt.new_object('WP_Image_Editor_GD', ['WP_Image_Editor'], &this), 'file')]))))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('preg_match', [rt.new_string('|^https?://|'), rt.get_property(rt.new_object('WP_Image_Editor_GD', ['WP_Image_Editor'], &this), 'file')]))))))) {
		return (create_wp_error(rt.new_string('error_loading_image'), rt.call_function('__', [rt.new_string('File does not exist?')]), rt.get_property(rt.new_object('WP_Image_Editor_GD', ['WP_Image_Editor'], &this), 'file'))).to_bool()
	}
	rt.call_function('wp_raise_memory_limit', [rt.new_string('image')])
	mut var_file_contents := rt.call_function('file_get_contents', [rt.get_property(rt.new_object('WP_Image_Editor_GD', ['WP_Image_Editor'], &this), 'file')])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_file_contents)))) {
		return (create_wp_error(rt.new_string('error_loading_image'), rt.call_function('__', [rt.new_string('File does not exist?')]), rt.get_property(rt.new_object('WP_Image_Editor_GD', ['WP_Image_Editor'], &this), 'file'))).to_bool()
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('function_exists', [rt.new_string('imagecreatefromwebp')])) && rt.is_true(rt.identical(rt.new_string('image/webp'), rt.call_function('wp_get_image_mime', [rt.get_property(rt.new_object('WP_Image_Editor_GD', ['WP_Image_Editor'], &this), 'file')]))))) {
		this.image = rt.call_function('imagecreatefromwebp', [rt.get_property(rt.new_object('WP_Image_Editor_GD', ['WP_Image_Editor'], &this), 'file')])
	} else if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('function_exists', [rt.new_string('imagecreatefromavif')])) && rt.is_true(rt.identical(rt.new_string('image/avif'), rt.call_function('wp_get_image_mime', [rt.get_property(rt.new_object('WP_Image_Editor_GD', ['WP_Image_Editor'], &this), 'file')]))))) {
		this.image = rt.call_function('imagecreatefromavif', [rt.get_property(rt.new_object('WP_Image_Editor_GD', ['WP_Image_Editor'], &this), 'file')])
	} else {
		this.image = rt.call_function('imagecreatefromstring', [var_file_contents.dup()])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_gd_image', [this.image]))))) {
		return (create_wp_error(rt.new_string('invalid_image'), rt.call_function('__', [rt.new_string('File is not an image.')]), rt.get_property(rt.new_object('WP_Image_Editor_GD', ['WP_Image_Editor'], &this), 'file'))).to_bool()
	}
	mut var_size := rt.call_function('wp_getimagesize', [rt.get_property(rt.new_object('WP_Image_Editor_GD', ['WP_Image_Editor'], &this), 'file')])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_size)))) {
		return (create_wp_error(rt.new_string('invalid_image'), rt.call_function('__', [rt.new_string('Could not read image size.')]), rt.get_property(rt.new_object('WP_Image_Editor_GD', ['WP_Image_Editor'], &this), 'file'))).to_bool()
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('function_exists', [rt.new_string('imagealphablending')])) && rt.is_true(rt.call_function('function_exists', [rt.new_string('imagesavealpha')])))) {
		rt.call_function('imagealphablending', [this.image, rt.new_bool(false)])
		rt.call_function('imagesavealpha', [this.image, rt.new_bool(true)])
	}
	this.update_size((var_size.array_get(0)).to_bool(), (var_size.array_get(1)).to_bool())
	this.dispatch_set_prop('mime_type', var_size.array_get('mime'))
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
	return this.Class_WP_Image_Editor.update_size(rt.new_bool(width_mutated), rt.new_bool(height_mutated))
}

fn (mut this Class_WP_Image_Editor_GD) resize(var_max_w rt.PhpVal, var_max_h rt.PhpVal, crop bool) bool {
	if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.get_property(rt.new_object('WP_Image_Editor_GD', ['WP_Image_Editor'], &this), 'size').array_get('width'), var_max_w)) && rt.is_true(rt.identical(rt.get_property(rt.new_object('WP_Image_Editor_GD', ['WP_Image_Editor'], &this), 'size').array_get('height'), var_max_h)))) {
		return true
	}
	mut var_resized := this._resize(var_max_w.dup(), var_max_h.dup(), crop)
	if rt.is_true(rt.call_function('is_gd_image', [var_resized.dup()])) {
		if rt.is_true(rt.less(rt.get_constant('PHP_VERSION_ID'), rt.new_int(80000))) {
			rt.call_function('imagedestroy', [this.image])
		}
		this.image = var_resized.dup()
		return true
	} else if rt.is_true(rt.call_function('is_wp_error', [var_resized.dup()])) {
		return (var_resized).to_bool()
	}
	return (create_wp_error(rt.new_string('image_resize_error'), rt.call_function('__', [rt.new_string('Image resize failed.')]), rt.get_property(rt.new_object('WP_Image_Editor_GD', ['WP_Image_Editor'], &this), 'file'))).to_bool()
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
	mut var_dims := rt.call_function('image_resize_dimensions', [rt.get_property(rt.new_object('WP_Image_Editor_GD', ['WP_Image_Editor'], &this), 'size').array_get('width'), rt.get_property(rt.new_object('WP_Image_Editor_GD', ['WP_Image_Editor'], &this), 'size').array_get('height'), var_max_w.dup(), var_max_h.dup(), rt.new_bool(crop)])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_dims)))) {
		return create_wp_error(rt.new_string('error_getting_dimensions'), rt.call_function('__', [rt.new_string('Could not calculate resized image dimensions')]), rt.get_property(rt.new_object('WP_Image_Editor_GD', ['WP_Image_Editor'], &this), 'file'))
	}
	// unsupported assign target: Expr_List
	this.set_quality(rt.new_null(), rt.create_array([rt.ArrayItem{ key: 'width', val: var_dst_w }, rt.ArrayItem{ key: 'height', val: var_dst_h }]))
	mut var_resized := rt.call_function('wp_imagecreatetruecolor', [var_dst_w.dup(), var_dst_h.dup()])
	rt.call_function('imagecopyresampled', [var_resized.dup(), this.image, var_dst_x.dup(), var_dst_y.dup(), var_src_x.dup(), var_src_y.dup(), var_dst_w.dup(), var_dst_h.dup(), var_src_w.dup(), var_src_h.dup()])
	if rt.is_true(rt.call_function('is_gd_image', [var_resized.dup()])) {
		this.update_size((var_dst_w).to_bool(), (var_dst_h).to_bool())
		return var_resized.dup()
	}
	return create_wp_error(rt.new_string('image_resize_error'), rt.call_function('__', [rt.new_string('Image resize failed.')]), rt.get_property(rt.new_object('WP_Image_Editor_GD', ['WP_Image_Editor'], &this), 'file'))
}

fn (mut this Class_WP_Image_Editor_GD) multi_resize(var_sizes rt.PhpVal) rt.PhpVal {
	mut var_metadata := rt.new_array()
	{
		mut iter_1 := var_sizes.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_size_data := item_1.val
			mut var_size := item_1.key
			mut var_meta := this.make_subsize(var_size_data.dup())
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [var_meta.dup()]))))) {
				var_metadata.array_set(var_size, var_meta.dup())
			}
		}
	}
	return var_metadata.dup()
}

fn (mut this Class_WP_Image_Editor_GD) make_subsize(var_size_data rt.PhpVal) rt.PhpVal {
	mut var_size_data_mutated := var_size_data
	if !(var_size_data_mutated.array_isset(rt.new_string('width'))) && !(var_size_data_mutated.array_isset(rt.new_string('height'))) {
		return create_wp_error(rt.new_string('image_subsize_create_error'), rt.call_function('__', [rt.new_string('Cannot resize the image. Both width and height are not set.')]))
	}
	mut var_orig_size := rt.get_property(rt.new_object('WP_Image_Editor_GD', ['WP_Image_Editor'], &this), 'size')
	if !(var_size_data_mutated.array_isset(rt.new_string('width'))) {
		var_size_data_mutated.array_set('width', rt.new_null())
	}
	if !(var_size_data_mutated.array_isset(rt.new_string('height'))) {
		var_size_data_mutated.array_set('height', rt.new_null())
	}
	if !(var_size_data_mutated.array_isset(rt.new_string('crop'))) {
		var_size_data_mutated.array_set('crop', false)
	}
	mut var_resized := this._resize(var_size_data_mutated.array_get('width'), var_size_data_mutated.array_get('height'), (var_size_data_mutated.array_get('crop')).to_bool())
	if rt.is_true(rt.call_function('is_wp_error', [var_resized.dup()])) {
		mut var_saved := var_resized.dup()
	} else {
		var_saved = this._save(var_resized.dup(), rt.new_null(), rt.new_null())
		if rt.is_true(rt.less(rt.get_constant('PHP_VERSION_ID'), rt.new_int(80000))) {
			rt.call_function('imagedestroy', [var_resized.dup()])
		}
	}
	this.dispatch_set_prop('size', var_orig_size.dup())
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [var_saved.dup()]))))) {
		var_saved.array_unset(rt.new_string('path'))
	}
	return var_saved.dup()
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
	{
		mut iter_1 := rt.create_array([rt.ArrayItem{ key: none, val: var_src_w }, rt.ArrayItem{ key: none, val: var_src_h }, rt.ArrayItem{ key: none, val: var_dst_w_mutated }, rt.ArrayItem{ key: none, val: var_dst_h_mutated }]).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_value := item_1.val
			if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_value.dup().is_long() || var_value.dup().is_double()))))) || rt.is_true(rt.less_equal(// unsupported expression: Expr_Cast_Int, rt.new_int(0))))) {
				return (create_wp_error(rt.new_string('image_crop_error'), rt.call_function('__', [rt.new_string('Image crop failed.')]), rt.get_property(rt.new_object('WP_Image_Editor_GD', ['WP_Image_Editor'], &this), 'file'))).to_bool()
			}
		}
	}
	mut var_dst := rt.call_function('wp_imagecreatetruecolor', [// unsupported expression: Expr_Cast_Int, // unsupported expression: Expr_Cast_Int])
	if var_src_abs {
		// unsupported expression: Expr_AssignOp_Minus
		// unsupported expression: Expr_AssignOp_Minus
	}
	if rt.is_true(rt.call_function('function_exists', [rt.new_string('imageantialias')])) {
		rt.call_function('imageantialias', [var_dst.dup(), rt.new_bool(true)])
	}
	rt.call_function('imagecopyresampled', [var_dst.dup(), this.image, rt.new_int(0), rt.new_int(0), // unsupported expression: Expr_Cast_Int, // unsupported expression: Expr_Cast_Int, // unsupported expression: Expr_Cast_Int, // unsupported expression: Expr_Cast_Int, // unsupported expression: Expr_Cast_Int, // unsupported expression: Expr_Cast_Int])
	if rt.is_true(rt.call_function('is_gd_image', [var_dst.dup()])) {
		if rt.is_true(rt.less(rt.get_constant('PHP_VERSION_ID'), rt.new_int(80000))) {
			rt.call_function('imagedestroy', [this.image])
		}
		this.image = var_dst.dup()
		this.update_size(false, false)
		return true
	}
	return (create_wp_error(rt.new_string('image_crop_error'), rt.call_function('__', [rt.new_string('Image crop failed.')]), rt.get_property(rt.new_object('WP_Image_Editor_GD', ['WP_Image_Editor'], &this), 'file'))).to_bool()
}

fn (mut this Class_WP_Image_Editor_GD) rotate(var_angle rt.PhpVal) bool {
	if rt.is_true(rt.call_function('function_exists', [rt.new_string('imagerotate')])) {
		mut var_transparency := rt.call_function('imagecolorallocatealpha', [this.image, rt.new_int(255), rt.new_int(255), rt.new_int(255), rt.new_int(127)])
		mut var_rotated := rt.call_function('imagerotate', [this.image, var_angle.dup(), var_transparency.dup()])
		if rt.is_true(rt.call_function('is_gd_image', [var_rotated.dup()])) {
			rt.call_function('imagealphablending', [var_rotated.dup(), rt.new_bool(true)])
			rt.call_function('imagesavealpha', [var_rotated.dup(), rt.new_bool(true)])
			if rt.is_true(rt.less(rt.get_constant('PHP_VERSION_ID'), rt.new_int(80000))) {
				rt.call_function('imagedestroy', [this.image])
			}
			this.image = var_rotated.dup()
			this.update_size(false, false)
			return true
		}
	}
	return (create_wp_error(rt.new_string('image_rotate_error'), rt.call_function('__', [rt.new_string('Image rotate failed.')]), rt.get_property(rt.new_object('WP_Image_Editor_GD', ['WP_Image_Editor'], &this), 'file'))).to_bool()
}

fn (mut this Class_WP_Image_Editor_GD) flip(var_horz rt.PhpVal, var_vert rt.PhpVal) bool {
	mut var_w := rt.get_property(rt.new_object('WP_Image_Editor_GD', ['WP_Image_Editor'], &this), 'size').array_get('width')
	mut var_h := rt.get_property(rt.new_object('WP_Image_Editor_GD', ['WP_Image_Editor'], &this), 'size').array_get('height')
	mut var_dst := rt.call_function('wp_imagecreatetruecolor', [var_w.dup(), var_h.dup()])
	if rt.is_true(rt.call_function('is_gd_image', [var_dst.dup()])) {
		mut var_sx := if rt.is_true(var_vert) { rt.sub(var_w, rt.new_int(1)) } else { rt.new_int(0) }
		mut var_sy := if rt.is_true(var_horz) { rt.sub(var_h, rt.new_int(1)) } else { rt.new_int(0) }
		mut var_sw := if rt.is_true(var_vert) { // unsupported expression: Expr_UnaryMinus } else { var_w }
		mut var_sh := if rt.is_true(var_horz) { // unsupported expression: Expr_UnaryMinus } else { var_h }
		if rt.is_true(rt.call_function('imagecopyresampled', [var_dst.dup(), this.image, rt.new_int(0), rt.new_int(0), var_sx.dup(), var_sy.dup(), var_w.dup(), var_h.dup(), var_sw.dup(), var_sh.dup()])) {
			if rt.is_true(rt.less(rt.get_constant('PHP_VERSION_ID'), rt.new_int(80000))) {
				rt.call_function('imagedestroy', [])
			}
			this.image = .dup()
			return 
		}
	}
	return (create_wp_error(, , )).to_bool()
}

fn (mut this Class_WP_Image_Editor_GD) save(var_destfilename rt.PhpVal, var_mime_type rt.PhpVal) rt.PhpVal {
	
}

fn (mut this Class_WP_Image_Editor_GD) _save(var_image rt.PhpVal, var_filename rt.PhpVal, var_mime_type rt.PhpVal) rt.PhpVal {
	mut var_extension := rt.new_null()
	mut var_filename_mutated := var_filename
}

fn (mut this Class_WP_Image_Editor_GD) set_quality(var_quality rt.PhpVal, var_dims rt.PhpVal) bool {
	mut var_quality_mutated := var_quality
	mut var_dims_mutated := var_dims
}

fn (mut this Class_WP_Image_Editor_GD) stream(var_mime_type rt.PhpVal)  {
	mut var_filename := rt.new_null()
	mut var_extension := rt.new_null()
}

fn (mut this Class_WP_Image_Editor_GD) make_image(var_filename rt.PhpVal, var_callback rt.PhpVal, var_arguments rt.PhpVal) rt.PhpVal {
	mut var_filename_mutated := var_filename
	mut var_arguments_mutated := var_arguments
}

struct Class_WP_Image_Editor {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

fn create_wp_image_editor_gd() &Class_WP_Image_Editor_GD {
	mut obj := &Class_WP_Image_Editor_GD{
		PhpObjectBase: rt.PhpObjectBase{}
		image: rt.new_null()
	}
	return obj
}

fn create_wp_image_editor() &Class_WP_Image_Editor {
	mut obj := &Class_WP_Image_Editor{
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
			return rt.new_bool(this.crop(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3, dispatch_arg_4, dispatch_arg_5, dispatch_arg_6))
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
			this.stream(dispatch_arg_0)
			return rt.new_null()
		}
		'make_image' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.make_image(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		else { return none }
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
		'image' { this.image = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
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




pub fn init_wp_includes_class_wp_image_editor_gd_php() {
}
