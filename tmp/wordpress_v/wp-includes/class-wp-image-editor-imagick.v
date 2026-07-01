import rt

struct Class_WP_Image_Editor_Imagick {
	rt.PhpObjectBase
pub mut:
		image rt.PhpVal = rt.new_null()
}

fn (mut this Class_WP_Image_Editor_Imagick) magic_destruct()  {
	if rt.is_true(rt.new_bool(rt.instance_of(this.image, 'Imagick'))) {
		rt.call_method(this.image, 'clear', []rt.PhpVal{})
		rt.call_method(this.image, 'destroy', []rt.PhpVal{})
	}
}

fn Class_WP_Image_Editor_Imagick.test(var_args rt.PhpVal) bool {
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('extension_loaded', [rt.new_string('imagick')]))))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [rt.new_string('Imagick'), rt.new_bool(false)]))))))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [rt.new_string('ImagickPixel'), rt.new_bool(false)]))))))) {
		return false
	}
	if rt.is_true(rt.call_function('version_compare', [rt.call_function('phpversion', [rt.new_string('imagick')]), rt.new_string('2.2.0'), rt.new_string('<')])) {
		return false
	}
	mut var_required_methods := ['clear', 'destroy', 'valid', 'getimage', 'writeimage', 'getimageblob', 'getimagegeometry', 'getimageformat', 'setimageformat', 'setimagecompression', 'setimagecompressionquality', 'setimagepage', 'setoption', 'scaleimage', 'cropimage', 'rotateimage', 'flipimage', 'flopimage', 'readimage', 'readimageblob']
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('imagick::COMPRESSION_JPEG')]))))) {
		return false
	}
	mut var_class_methods := rt.call_function('array_map', [rt.new_string('strtolower'), rt.call_function('get_class_methods', [rt.new_string('Imagick')])])
	if rt.is_true(rt.call_function('array_diff', [var_required_methods.dup(), var_class_methods.dup()])) {
		return false
	}
	return true
}

fn Class_WP_Image_Editor_Imagick.supports_mime_type(var_mime_type rt.PhpVal) bool {
	mut var_imagick_extension := rt.new_string(rt.new_string(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WP_Image_Editor_Imagick{}; return temp.get_extension(arg_0) }(var_mime_type.dup()).to_string().to_upper()))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_imagick_extension)))) {
		return false
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('method_exists', [rt.new_string('Imagick'), rt.new_string('setIteratorIndex')]))))) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		return false
	}
	return (// unsupported expression: Expr_Cast_Bool).to_bool()
	unsafe { goto end_label_1 }

catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'Exception') {
		mut var_e := var_e_1.dup()
		return false
		unsafe { goto end_label_1 }
	}
	else {
		rt.throw_exception(var_e_1)
		unsafe { goto end_label_1 }
	}

end_label_1:
	return false
}

fn (mut this Class_WP_Image_Editor_Imagick) load() bool {
	if rt.is_true(rt.new_bool(rt.instance_of(this.image, 'Imagick'))) {
		return true
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_file', [rt.get_property(rt.new_object('WP_Image_Editor_Imagick', ['WP_Image_Editor'], &this), 'file')]))))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_is_stream', [rt.get_property(rt.new_object('WP_Image_Editor_Imagick', ['WP_Image_Editor'], &this), 'file')]))))))) {
		return (create_wp_error(rt.new_string('error_loading_image'), rt.call_function('__', [rt.new_string('File does not exist?')]), rt.get_property(rt.new_object('WP_Image_Editor_Imagick', ['WP_Image_Editor'], &this), 'file'))).to_bool()
	}
	rt.call_function('wp_raise_memory_limit', [rt.new_string('image')])
	this.image = create_imagick()
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	mut var_file_extension := rt.new_string(rt.new_string(rt.call_function('pathinfo', [rt.get_property(rt.new_object('WP_Image_Editor_Imagick', ['WP_Image_Editor'], &this), 'file'), rt.get_constant('PATHINFO_EXTENSION')]).to_string().to_lower()))
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	if rt.is_true(rt.identical(rt.new_string('pdf'), var_file_extension)) {
		mut var_pdf_loaded := rt.new_bool(this.pdf_load_source())
		if rt.has_exception() { unsafe { goto catch_label_2 } }
		if rt.is_true(rt.call_function('is_wp_error', [var_pdf_loaded.dup()])) {
			return (var_pdf_loaded).to_bool()
		}
		if rt.has_exception() { unsafe { goto catch_label_2 } }
	} else {
		if rt.is_true(rt.call_function('wp_is_stream', [rt.get_property(rt.new_object('WP_Image_Editor_Imagick', ['WP_Image_Editor'], &this), 'file')])) {
			rt.call_method(this.image, 'readImageBlob', [rt.call_function('file_get_contents', [rt.get_property(rt.new_object('WP_Image_Editor_Imagick', ['WP_Image_Editor'], &this), 'file')]), rt.get_property(rt.new_object('WP_Image_Editor_Imagick', ['WP_Image_Editor'], &this), 'file')])
			if rt.has_exception() { unsafe { goto catch_label_2 } }
		} else {
			rt.call_method(this.image, 'readImage', [rt.get_property(rt.new_object('WP_Image_Editor_Imagick', ['WP_Image_Editor'], &this), 'file')])
			if rt.has_exception() { unsafe { goto catch_label_2 } }
		}
		if rt.has_exception() { unsafe { goto catch_label_2 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(this.image, 'valid', []rt.PhpVal{}))))) {
		return (create_wp_error(rt.new_string('invalid_image'), rt.call_function('__', [rt.new_string('File is not an image.')]), rt.get_property(rt.new_object('WP_Image_Editor_Imagick', ['WP_Image_Editor'], &this), 'file'))).to_bool()
	}
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	if rt.is_true(rt.call_function('is_callable', [rt.create_array([rt.ArrayItem{ key: none, val: this.image }, rt.ArrayItem{ key: none, val: 'setIteratorIndex' }])])) {
		rt.call_method(this.image, 'setIteratorIndex', [rt.new_int(0)])
		if rt.has_exception() { unsafe { goto catch_label_2 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	if rt.is_true(rt.identical(rt.new_string('pdf'), var_file_extension)) {
		this.remove_pdf_alpha_channel()
		if rt.has_exception() { unsafe { goto catch_label_2 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	this.dispatch_set_prop('mime_type', this.get_mime_type(rt.call_method(this.image, 'getImageFormat', []rt.PhpVal{})))
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	unsafe { goto end_label_2 }

catch_label_2:
	mut var_e_2 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_2, 'Exception') {
		mut var_e := var_e_2.dup()
		return (create_wp_error(rt.new_string('invalid_image'), rt.call_method(var_e, 'getMessage', []rt.PhpVal{}), rt.get_property(rt.new_object('WP_Image_Editor_Imagick', ['WP_Image_Editor'], &this), 'file'))).to_bool()
		unsafe { goto end_label_2 }
	}
	else {
		rt.throw_exception(var_e_2)
		unsafe { goto end_label_2 }
	}

end_label_2:
	mut var_updated_size := this.update_size(rt.new_null(), rt.new_null())
	if rt.is_true(rt.call_function('is_wp_error', [var_updated_size.dup()])) {
		return (var_updated_size).to_bool()
	}
	return this.set_quality(rt.new_null(), rt.new_null())
}

fn (mut this Class_WP_Image_Editor_Imagick) set_quality(var_quality rt.PhpVal, var_dims rt.PhpVal) bool {
	mut var_quality_mutated := var_quality
	mut var_dims_mutated := var_dims
	mut var_quality_result := this.Class_WP_Image_Editor.set_quality(var_quality_mutated.dup(), var_dims_mutated.dup())
	if rt.is_true(rt.call_function('is_wp_error', [var_quality_result.dup()])) {
		return (var_quality_result).to_bool()
	} else {
		var_quality_mutated = this.get_quality()
	}
	mut switch_val_1 := rt.get_property(rt.new_object('WP_Image_Editor_Imagick', ['WP_Image_Editor'], &this), 'mime_type')
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('image/jpeg'))) {
		rt.call_method(this.image, 'setImageCompressionQuality', [var_quality_mutated.dup()])
		if rt.has_exception() { unsafe { goto catch_label_3 } }
		rt.call_method(this.image, 'setCompressionQuality', [var_quality_mutated.dup()])
		if rt.has_exception() { unsafe { goto catch_label_3 } }
		rt.call_method(this.image, 'setImageCompression', [Class_imagick.compression_jpeg()])
		if rt.has_exception() { unsafe { goto catch_label_3 } }
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('image/webp'))) {
		mut var_webp_info := rt.call_function('wp_get_webp_info', [rt.get_property(rt.new_object('WP_Image_Editor_Imagick', ['WP_Image_Editor'], &this), 'file')])
		if rt.has_exception() { unsafe { goto catch_label_3 } }
		if rt.is_true(rt.identical(rt.new_string('lossless'), var_webp_info.array_get('type'))) {
			rt.call_method(this.image, 'setImageCompressionQuality', [rt.new_int(100)])
			if rt.has_exception() { unsafe { goto catch_label_3 } }
			rt.call_method(this.image, 'setCompressionQuality', [rt.new_int(100)])
			if rt.has_exception() { unsafe { goto catch_label_3 } }
			rt.call_method(this.image, 'setOption', [rt.new_string('webp:lossless'), rt.new_string('true')])
			if rt.has_exception() { unsafe { goto catch_label_3 } }
			this.Class_WP_Image_Editor.set_quality(rt.new_int(100))
			if rt.has_exception() { unsafe { goto catch_label_3 } }
		} else {
			rt.call_method(this.image, 'setImageCompressionQuality', [var_quality_mutated.dup()])
			if rt.has_exception() { unsafe { goto catch_label_3 } }
			rt.call_method(this.image, 'setCompressionQuality', [var_quality_mutated.dup()])
			if rt.has_exception() { unsafe { goto catch_label_3 } }
		}
		if rt.has_exception() { unsafe { goto catch_label_3 } }
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('image/avif'))) {
		rt.call_method(this.image, 'setOption', [rt.new_string('heic:speed'), rt.new_int(7)])
		if rt.has_exception() { unsafe { goto catch_label_3 } }
		rt.call_method(this.image, 'setImageCompressionQuality', [var_quality_mutated.dup()])
		if rt.has_exception() { unsafe { goto catch_label_3 } }
		rt.call_method(this.image, 'setCompressionQuality', [var_quality_mutated.dup()])
		if rt.has_exception() { unsafe { goto catch_label_3 } }
	} else {
		rt.call_method(this.image, 'setImageCompressionQuality', [var_quality_mutated.dup()])
		if rt.has_exception() { unsafe { goto catch_label_3 } }
		rt.call_method(this.image, 'setCompressionQuality', [var_quality_mutated.dup()])
		if rt.has_exception() { unsafe { goto catch_label_3 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_3 } }
	unsafe { goto end_label_3 }

catch_label_3:
	mut var_e_3 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_3, 'Exception') {
		mut var_e := var_e_3.dup()
		return (create_wp_error(rt.new_string('image_quality_error'), rt.call_method(var_e, 'getMessage', []rt.PhpVal{}))).to_bool()
		unsafe { goto end_label_3 }
	}
	else {
		rt.throw_exception(var_e_3)
		unsafe { goto end_label_3 }
	}

end_label_3:
	return true
}

fn (mut this Class_WP_Image_Editor_Imagick) update_size(var_width rt.PhpVal, var_height rt.PhpVal) rt.PhpVal {
	mut var_width_mutated := var_width
	mut var_height_mutated := var_height
	mut var_size := rt.new_null()
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_width_mutated)))) || rt.is_true(rt.new_bool(!(rt.is_true(var_height_mutated)))))) {
		var_size = rt.call_method(this.image, 'getImageGeometry', []rt.PhpVal{})
		if rt.has_exception() { unsafe { goto catch_label_4 } }
		unsafe { goto end_label_4 }

catch_label_4:
		mut var_e_4 := rt.get_and_clear_exception()
		if rt.instance_of(var_e_4, 'Exception') {
			mut var_e := var_e_4.dup()
			return create_wp_error(rt.new_string('invalid_image'), rt.call_function('__', [rt.new_string('Could not read image size.')]), rt.get_property(rt.new_object('WP_Image_Editor_Imagick', ['WP_Image_Editor'], &this), 'file'))
			unsafe { goto end_label_4 }
		}
		else {
			rt.throw_exception(var_e_4)
			unsafe { goto end_label_4 }
		}

end_label_4:
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_width_mutated)))) {
		var_width_mutated = var_size.array_get('width')
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_height_mutated)))) {
		var_height_mutated = var_size.array_get('height')
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_width_mutated)))) || rt.is_true(rt.new_bool(!(rt.is_true(var_height_mutated)))))) && rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('image/avif'), rt.get_property(rt.new_object('WP_Image_Editor_Imagick', ['WP_Image_Editor'], &this), 'mime_type'))) || rt.is_true(rt.call_function('wp_is_heic_image_mime_type', [rt.get_property(rt.new_object('WP_Image_Editor_Imagick', ['WP_Image_Editor'], &this), 'mime_type')])))))) {
		var_size = rt.call_function('wp_getimagesize', [rt.get_property(rt.new_object('WP_Image_Editor_Imagick', ['WP_Image_Editor'], &this), 'file')])
		var_width_mutated = var_size.array_get(0)
		var_height_mutated = var_size.array_get(1)
	}
	return this.Class_WP_Image_Editor.update_size(var_width_mutated.dup(), var_height_mutated.dup())
}

fn Class_WP_Image_Editor_Imagick.set_imagick_time_limit() rt.PhpVal {
	rt.call_function('_deprecated_function', [rt.new_string(@METHOD), rt.new_string('6.3.0')])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('Imagick::RESOURCETYPE_TIME')]))))) {
		return rt.new_null()
	}
	mut var_imagick_timeout := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Imagick{}; return temp.getresourcelimit(arg_0) }(Class_Imagick.resourcetype_time())
	var_imagick_timeout = if rt.is_true(rt.greater(var_imagick_timeout, rt.get_constant('PHP_INT_MAX'))) { rt.get_constant('PHP_INT_MAX') } else { // unsupported expression: Expr_Cast_Int }
	mut var_php_timeout := // unsupported expression: Expr_Cast_Int
	if rt.is_true(rt.new_bool(rt.is_true(rt.greater(var_php_timeout, rt.new_int(1))) && rt.is_true(rt.less(var_php_timeout, var_imagick_timeout)))) {
		mut var_limit := rt.mul(// unsupported expression: Expr_Cast_Double, var_php_timeout)
		fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Imagick{}; return temp.setresourcelimit(arg_0, arg_1) }(Class_Imagick.resourcetype_time(), var_limit.dup())
		return var_limit.dup()
	}
	return rt.new_null()
}

fn (mut this Class_WP_Image_Editor_Imagick) resize(var_max_w rt.PhpVal, var_max_h rt.PhpVal, crop bool) bool {
	mut var_dst_x := rt.new_null()
	mut var_dst_y := rt.new_null()
	mut var_src_x := rt.new_null()
	mut var_src_y := rt.new_null()
	mut var_dst_w := rt.new_null()
	mut var_dst_h := rt.new_null()
	mut var_src_w := rt.new_null()
	mut var_src_h := rt.new_null()
	if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.get_property(rt.new_object('WP_Image_Editor_Imagick', ['WP_Image_Editor'], &this), 'size').array_get('width'), var_max_w)) && rt.is_true(rt.identical(rt.get_property(rt.new_object('WP_Image_Editor_Imagick', ['WP_Image_Editor'], &this), 'size').array_get('height'), var_max_h)))) {
		return true
	}
	mut var_dims := rt.call_function('image_resize_dimensions', [rt.get_property(rt.new_object('WP_Image_Editor_Imagick', ['WP_Image_Editor'], &this), 'size').array_get('width'), rt.get_property(rt.new_object('WP_Image_Editor_Imagick', ['WP_Image_Editor'], &this), 'size').array_get('height'), var_max_w.dup(), var_max_h.dup(), rt.new_bool(crop)])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_dims)))) {
		return (create_wp_error(rt.new_string('error_getting_dimensions'), rt.call_function('__', [rt.new_string('Could not calculate resized image dimensions')]))).to_bool()
	}
	// unsupported assign target: Expr_List
	if var_crop {
		return (this.crop(var_src_x.dup(), var_src_y.dup(), var_src_w.dup(), var_src_h.dup(), var_dst_w.dup(), var_dst_h.dup(), false)).to_bool()
	}
	this.set_quality(rt.new_null(), rt.create_array([rt.ArrayItem{ key: 'width', val: var_dst_w }, rt.ArrayItem{ key: 'height', val: var_dst_h }]))
	mut var_thumb_result := this.thumbnail_image(var_dst_w.dup(), var_dst_h.dup(), '', false)
	if rt.is_true(rt.call_function('is_wp_error', [var_thumb_result.dup()])) {
		return (var_thumb_result).to_bool()
	}
	return (this.update_size(var_dst_w.dup(), var_dst_h.dup())).to_bool()
}

fn (mut this Class_WP_Image_Editor_Imagick) thumbnail_image(var_dst_w rt.PhpVal, var_dst_h rt.PhpVal, filter_name string, strip_meta bool)  {
	mut var_dst_w_mutated := var_dst_w
	mut var_dst_h_mutated := var_dst_h
	mut var_allowed_filters := ['FILTER_POINT', 'FILTER_BOX', 'FILTER_TRIANGLE', 'FILTER_HERMITE', 'FILTER_HANNING', 'FILTER_HAMMING', 'FILTER_BLACKMAN', 'FILTER_GAUSSIAN', 'FILTER_QUADRATIC', 'FILTER_CUBIC', 'FILTER_CATROM', 'FILTER_MITCHELL', 'FILTER_LANCZOS', 'FILTER_BESSEL', 'FILTER_SINC']
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('in_array', [rt.new_string(filter_name), var_allowed_filters.dup(), rt.new_bool(true)])) && rt.is_true(rt.call_function('defined', ['Imagick::' + filter_name])))) {
		mut var_filter := rt.call_function('constant', ['Imagick::' + filter_name])
	} else {
		var_filter = if rt.is_true(rt.call_function('defined', [rt.new_string('Imagick::FILTER_TRIANGLE')])) { Class_Imagick.filter_triangle() } else { rt.new_bool(false) }
	}
	if rt.is_true(rt.call_function('apply_filters', [rt.new_string('image_strip_meta'), rt.new_bool(strip_meta)])) {
		this.strip_meta()
		// unsupported statement: Stmt_Nop
	}
	mut var_is_png := rt.new_bool(rt.new_bool(false))
	if rt.has_exception() { unsafe { goto catch_label_5 } }
	mut var_is_indexed_png := rt.new_bool(rt.new_bool(false))
	if rt.has_exception() { unsafe { goto catch_label_5 } }
	mut var_is_indexed_png_with_alpha_channel := rt.new_bool(rt.new_bool(false))
	if rt.has_exception() { unsafe { goto catch_label_5 } }
	mut var_is_indexed_png_with_true_alpha_transparency := rt.new_bool(rt.new_bool(false))
	if rt.has_exception() { unsafe { goto catch_label_5 } }
	if rt.is_true(rt.identical(rt.new_string('image/png'), rt.get_property(rt.new_object('WP_Image_Editor_Imagick', ['WP_Image_Editor'], &this), 'mime_type'))) {
		var_is_png = rt.new_bool(rt.new_bool(true))
		if rt.has_exception() { unsafe { goto catch_label_5 } }
		if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('is_callable', [rt.create_array([rt.ArrayItem{ key: none, val: this.image }, rt.ArrayItem{ key: none, val: 'getImageProperty' }])])) && rt.is_true(rt.identical(rt.new_string('3'), rt.call_method(this.image, 'getImageProperty', [rt.new_string('png:IHDR.color-type-orig')]))))) {
			var_is_indexed_png = rt.new_bool(rt.new_bool(true))
			if rt.has_exception() { unsafe { goto catch_label_5 } }
			if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('is_callable', [])) && rt.is_true(rt.call_method(, 'getImageAlphaChannel', []rt.PhpVal{})))) {
				var_is_indexed_png_with_alpha_channel = rt.new_bool()
				if rt.has_exception() { unsafe { goto catch_label_5 } }
				if rt.is_true() {
				}
				if rt.has_exception() { unsafe { goto catch_label_5 } }
			}
			if rt.has_exception() { unsafe { goto catch_label_5 } }
		}
		if rt.has_exception() { unsafe { goto catch_label_5 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_5 } }
	if rt.is_true(rt.call_function('is_callable', [rt.create_array([rt.ArrayItem{ key: none, val: this.image }, rt.ArrayItem{ key: none, val: 'sampleImage' }])])) {
		mut var_resize_ratio := rt.mul(, )
		if rt.has_exception() { unsafe { goto catch_label_5 } }
		mut var_sample_factor := rt.new_int()
		if rt.has_exception() { unsafe { goto catch_label_5 } }
		if rt.is_true() {
		}
		if rt.has_exception() { unsafe { goto catch_label_5 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_5 } }
	if rt.is_true(rt.new_bool(rt.is_true() && rt.is_true())) {
		
		if rt.has_exception() { unsafe { goto catch_label_5 } }
	} else {
	}
	if rt.has_exception() { unsafe { goto catch_label_5 } }
	if rt.is_true() {
	}
	if rt.has_exception() { unsafe { goto catch_label_5 } }
	if rt.is_true() {
	}
	if rt.has_exception() { unsafe { goto catch_label_5 } }
	if rt.is_true() {
	}
	if rt.has_exception() { unsafe { goto catch_label_5 } }
	if rt.is_true() {
	}
	if rt.has_exception() { unsafe { goto catch_label_5 } }
	unsafe { goto end_label_5 }

catch_label_5:
	mut var_e_5 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_5, 'Exception') {
		mut var_e := var_e_5.dup()
		return 
		unsafe { goto end_label_5 }
	}
	else {
		rt.throw_exception(var_e_5)
		unsafe { goto end_label_5 }
	}

end_label_5:
}

fn (mut this Class_WP_Image_Editor_Imagick) multi_resize(var_sizes rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_WP_Image_Editor_Imagick) make_subsize(var_size_data rt.PhpVal) rt.PhpVal {
	mut var_size_data_mutated := var_size_data
}

fn (mut this Class_WP_Image_Editor_Imagick) crop(var_src_x rt.PhpVal, var_src_y rt.PhpVal, var_src_w rt.PhpVal, var_src_h rt.PhpVal, var_dst_w rt.PhpVal, var_dst_h rt.PhpVal, src_abs bool) rt.PhpVal {
	mut var_dst_w_mutated := var_dst_w
	mut var_dst_h_mutated := var_dst_h
}

fn (mut this Class_WP_Image_Editor_Imagick) rotate(var_angle rt.PhpVal) bool {
}

fn (mut this Class_WP_Image_Editor_Imagick) flip(var_horz rt.PhpVal, var_vert rt.PhpVal) bool {
}

fn (mut this Class_WP_Image_Editor_Imagick) maybe_exif_rotate() rt.PhpVal {
	return rt.new_null()
}

fn (mut this Class_WP_Image_Editor_Imagick) save(var_destfilename rt.PhpVal, var_mime_type rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_WP_Image_Editor_Imagick) remove_pdf_alpha_channel()  {
}

fn (mut this Class_WP_Image_Editor_Imagick) _save(var_image rt.PhpVal, var_filename rt.PhpVal, var_mime_type rt.PhpVal) rt.PhpVal {
	mut var_extension := rt.new_null()
	mut var_filename_mutated := var_filename
}

fn (mut this Class_WP_Image_Editor_Imagick) write_image(var_image rt.PhpVal, var_filename rt.PhpVal) bool {
	mut var_filename_mutated := var_filename
	return false
}

fn (mut this Class_WP_Image_Editor_Imagick) stream(var_mime_type rt.PhpVal) bool {
	mut var_filename := rt.new_null()
	mut var_extension := rt.new_null()
}

fn (mut this Class_WP_Image_Editor_Imagick) strip_meta() bool {
}

fn (mut this Class_WP_Image_Editor_Imagick) pdf_setup() string {
	return ''
}

fn (mut this Class_WP_Image_Editor_Imagick) pdf_load_source() bool {
}

struct Class_WP_Image_Editor {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

struct Class_Imagick {
	rt.PhpObjectBase
}

fn create_wp_image_editor_imagick() &Class_WP_Image_Editor_Imagick {
	mut obj := &Class_WP_Image_Editor_Imagick{
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

fn create_imagick() &Class_Imagick {
	mut obj := &Class_Imagick{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Image_Editor_Imagick) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__destruct' {
			this.magic_destruct()
			return rt.new_null()
		}
		'test' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(Class_WP_Image_Editor_Imagick.test(dispatch_arg_0))
		}
		'supports_mime_type' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(Class_WP_Image_Editor_Imagick.supports_mime_type(dispatch_arg_0))
		}
		'load' {
			return rt.new_bool(this.load())
		}
		'set_quality' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(this.set_quality(dispatch_arg_0, dispatch_arg_1))
		}
		'update_size' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.update_size(dispatch_arg_0, dispatch_arg_1)
		}
		'set_imagick_time_limit' {
			return Class_WP_Image_Editor_Imagick.set_imagick_time_limit()
		}
		'resize' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
			return rt.new_bool(this.resize(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2))
		}
		'thumbnail_image' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).to_bool()
			this.thumbnail_image(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
			return rt.new_null()
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
			return this.crop(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3, dispatch_arg_4, dispatch_arg_5, dispatch_arg_6)
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
		'maybe_exif_rotate' {
			return this.maybe_exif_rotate()
		}
		'save' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.save(dispatch_arg_0, dispatch_arg_1)
		}
		'remove_pdf_alpha_channel' {
			this.remove_pdf_alpha_channel()
			return rt.new_null()
		}
		'_save' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this._save(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'write_image' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(this.write_image(dispatch_arg_0, dispatch_arg_1))
		}
		'stream' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.stream(dispatch_arg_0))
		}
		'strip_meta' {
			return rt.new_bool(this.strip_meta())
		}
		'pdf_setup' {
			return rt.new_string(this.pdf_setup())
		}
		'pdf_load_source' {
			return rt.new_bool(this.pdf_load_source())
		}
		else { return none }
	}
}

fn (this &Class_WP_Image_Editor_Imagick) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'image' { return this.image }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_Image_Editor_Imagick) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_Imagick) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Imagick) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Imagick) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_includes_class_wp_image_editor_imagick_php() {
}
