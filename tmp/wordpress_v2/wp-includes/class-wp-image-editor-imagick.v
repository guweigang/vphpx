import rt

struct Class_WP_Image_Editor_Imagick {
	rt.PhpObjectBase
pub mut:
	image rt.PhpVal = rt.new_null()
}

fn (mut this Class_WP_Image_Editor_Imagick) magic_destruct() {
	if rt.is_true(rt.new_bool(rt.instance_of(this.image, 'Imagick'))) {
		rt.call_method(this.image, 'clear', []rt.PhpVal{})
		rt.call_method(this.image, 'destroy', []rt.PhpVal{})
	}
}

fn Class_WP_Image_Editor_Imagick.test(var_args rt.PhpVal) bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('extension_loaded', [rt.new_string('imagick')])))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [rt.new_string('Imagick'), rt.new_bool(false)])))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [rt.new_string('ImagickPixel'), rt.new_bool(false)]))))) {
		return false
	}
	if rt.is_true(rt.call_function('version_compare', [
		rt.call_function('phpversion', [rt.new_string('imagick')]),
		rt.new_string('2.2.0'),
		rt.new_string('<'),
	]))
	{
		return false
	}
	mut var_required_methods := ['clear', 'destroy', 'valid', 'getimage', 'writeimage',
		'getimageblob', 'getimagegeometry', 'getimageformat', 'setimageformat', 'setimagecompression',
		'setimagecompressionquality', 'setimagepage', 'setoption', 'scaleimage', 'cropimage',
		'rotateimage', 'flipimage', 'flopimage', 'readimage', 'readimageblob']
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('imagick::COMPRESSION_JPEG'),
	])))))
	{
		return false
	}
	mut var_class_methods := rt.call_function('array_map', [rt.new_string('strtolower'),
		rt.call_function('get_class_methods', [rt.new_string('Imagick')])])
	if rt.is_true(rt.call_function('array_diff', [
		rt.create_array_from_list(var_required_methods),
		var_class_methods.clone(),
	]))
	{
		return false
	}
	return true
}

fn Class_WP_Image_Editor_Imagick.supports_mime_type(var_mime_type rt.PhpVal) bool {
	mut iife_temp_0 := Class_WP_Image_Editor_Imagick{}
	mut iife_result_0 := iife_temp_0.get_extension(var_mime_type.clone())
	mut iife_temp_1 := Class_WP_Image_Editor_Imagick{}
	mut iife_result_1 := iife_temp_1.get_extension(var_mime_type.clone())
	mut var_imagick_extension := rt.new_string(iife_result_1.to_string().to_upper())
	if rt.is_true(rt.new_bool(!(rt.is_true(var_imagick_extension)))) {
		return false
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('method_exists', [rt.new_string('Imagick'), rt.new_string('setIteratorIndex')])))))
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('image/jpeg'), var_mime_type)))) {
		return false
	}
	mut iife_temp_2 := Class_Imagick{}
	mut iife_result_2 := iife_temp_2.queryformats(var_imagick_extension.clone())
	return iife_result_2.to_bool()
	unsafe {
		goto end_label_1
	}
	catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'Exception') {
		mut var_e := var_e_1.clone()
		return false
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
	return false
}

fn (mut this Class_WP_Image_Editor_Imagick) load() bool {
	if rt.is_true(rt.new_bool(rt.instance_of(this.image, 'Imagick'))) {
		return true
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_file', [rt.get_property(rt.new_object('WP_Image_Editor_Imagick', ['WP_Image_Editor'], &this), 'file')])))))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_is_stream', [rt.get_property(rt.new_object('WP_Image_Editor_Imagick', ['WP_Image_Editor'], &this), 'file')]))))) {
		return (create_wp_error(rt.new_string('error_loading_image'), rt.call_function('__', [
			rt.new_string('File does not exist?'),
		]), rt.get_property(rt.new_object('WP_Image_Editor_Imagick', [
			'WP_Image_Editor',
		], &this), 'file'))).to_bool()
	}
	rt.call_function('wp_raise_memory_limit', [rt.new_string('image')])
	this.image = create_imagick()
	if rt.has_exception() {
		unsafe {
			goto catch_label_2
		}
	}
	mut var_file_extension := rt.new_string(rt.call_function('pathinfo', [
		rt.get_property(rt.new_object('WP_Image_Editor_Imagick', ['WP_Image_Editor'], &this),
			'file'),
		rt.get_constant('PATHINFO_EXTENSION'),
	]).to_string().to_lower())
	if rt.has_exception() {
		unsafe {
			goto catch_label_2
		}
	}
	if rt.is_true(rt.identical(rt.new_string('pdf'), var_file_extension)) {
		mut var_pdf_loaded := rt.new_bool(this.pdf_load_source())
		if rt.has_exception() {
			unsafe {
				goto catch_label_2
			}
		}
		if rt.is_true(rt.call_function('is_wp_error', [var_pdf_loaded.clone()])) {
			return var_pdf_loaded.to_bool()
		}
		if rt.has_exception() {
			unsafe {
				goto catch_label_2
			}
		}
	} else {
		if rt.is_true(rt.call_function('wp_is_stream', [
			rt.get_property(rt.new_object('WP_Image_Editor_Imagick', [
				'WP_Image_Editor',
			], &this), 'file'),
		]))
		{
			rt.call_method(this.image, 'readImageBlob', [
				rt.call_function('file_get_contents', [
					rt.get_property(rt.new_object('WP_Image_Editor_Imagick', [
						'WP_Image_Editor',
					], &this), 'file'),
				]),
				rt.get_property(rt.new_object('WP_Image_Editor_Imagick', [
					'WP_Image_Editor',
				], &this), 'file'),
			])
			if rt.has_exception() {
				unsafe {
					goto catch_label_2
				}
			}
		} else {
			rt.call_method(this.image, 'readImage', [
				rt.get_property(rt.new_object('WP_Image_Editor_Imagick', [
					'WP_Image_Editor',
				], &this), 'file'),
			])
			if rt.has_exception() {
				unsafe {
					goto catch_label_2
				}
			}
		}
		if rt.has_exception() {
			unsafe {
				goto catch_label_2
			}
		}
	}
	if rt.has_exception() {
		unsafe {
			goto catch_label_2
		}
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(this.image, 'valid', []rt.PhpVal{}))))) {
		return (create_wp_error(rt.new_string('invalid_image'), rt.call_function('__', [
			rt.new_string('File is not an image.'),
		]), rt.get_property(rt.new_object('WP_Image_Editor_Imagick', [
			'WP_Image_Editor',
		], &this), 'file'))).to_bool()
	}
	if rt.has_exception() {
		unsafe {
			goto catch_label_2
		}
	}
	if rt.is_true(rt.call_function('is_callable', [
		rt.create_array([rt.ArrayItem{ key: none, val: this.image },
			rt.ArrayItem{ key: none, val: 'setIteratorIndex' }]),
	]))
	{
		rt.call_method(this.image, 'setIteratorIndex', [rt.new_int(0)])
		if rt.has_exception() {
			unsafe {
				goto catch_label_2
			}
		}
	}
	if rt.has_exception() {
		unsafe {
			goto catch_label_2
		}
	}
	if rt.is_true(rt.identical(rt.new_string('pdf'), var_file_extension)) {
		this.remove_pdf_alpha_channel()
		if rt.has_exception() {
			unsafe {
				goto catch_label_2
			}
		}
	}
	if rt.has_exception() {
		unsafe {
			goto catch_label_2
		}
	}
	this.dispatch_set_prop('mime_type', this.get_mime_type(rt.call_method(this.image,
		'getImageFormat', []rt.PhpVal{})))
	if rt.has_exception() {
		unsafe {
			goto catch_label_2
		}
	}
	unsafe {
		goto end_label_2
	}
	catch_label_2:
	mut var_e_2 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_2, 'Exception') {
		mut var_e := var_e_2.clone()
		return (create_wp_error(rt.new_string('invalid_image'), rt.call_method(var_e, 'getMessage',
			[]rt.PhpVal{}), rt.get_property(rt.new_object('WP_Image_Editor_Imagick', [
			'WP_Image_Editor',
		], &this), 'file'))).to_bool()
		unsafe {
			goto end_label_2
		}
	} else {
		rt.throw_exception(var_e_2)
		unsafe {
			goto end_label_2
		}
	}

	end_label_2:
	mut var_updated_size := this.update_size(rt.new_null(), rt.new_null())
	if rt.is_true(rt.call_function('is_wp_error', [var_updated_size.clone()])) {
		return var_updated_size.to_bool()
	}
	return this.set_quality(rt.new_null(), rt.new_null())
}

fn (mut this Class_WP_Image_Editor_Imagick) set_quality(var_quality rt.PhpVal, var_dims rt.PhpVal) bool {
	mut var_quality_mutated := var_quality
	mut var_dims_mutated := var_dims
	mut var_quality_result := this.Class_WP_Image_Editor.set_quality(var_quality_mutated.clone(),
		var_dims_mutated.clone())
	if rt.is_true(rt.call_function('is_wp_error', [var_quality_result.clone()])) {
		return var_quality_result.to_bool()
	} else {
		var_quality_mutated = this.get_quality()
	}
	mut switch_val_1 := rt.get_property(rt.new_object('WP_Image_Editor_Imagick', [
		'WP_Image_Editor',
	], &this), 'mime_type')
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('image/jpeg'))) {
		rt.call_method(this.image, 'setImageCompressionQuality', [
			var_quality_mutated.clone()])
		if rt.has_exception() {
			unsafe {
				goto catch_label_3
			}
		}
		rt.call_method(this.image, 'setCompressionQuality', [
			var_quality_mutated.clone()])
		if rt.has_exception() {
			unsafe {
				goto catch_label_3
			}
		}
		rt.call_method(this.image, 'setImageCompression', [
			Class_imagick.compression_jpeg(),
		])
		if rt.has_exception() {
			unsafe {
				goto catch_label_3
			}
		}
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('image/webp'))) {
		mut var_webp_info := rt.call_function('wp_get_webp_info', [
			rt.get_property(rt.new_object('WP_Image_Editor_Imagick', [
				'WP_Image_Editor',
			], &this), 'file'),
		])
		if rt.has_exception() {
			unsafe {
				goto catch_label_3
			}
		}
		if rt.is_true(rt.identical(rt.new_string('lossless'),
			var_webp_info.array_get(rt.new_string('type'))))
		{
			rt.call_method(this.image, 'setImageCompressionQuality', [
				rt.new_int(100)])
			if rt.has_exception() {
				unsafe {
					goto catch_label_3
				}
			}
			rt.call_method(this.image, 'setCompressionQuality', [
				rt.new_int(100)])
			if rt.has_exception() {
				unsafe {
					goto catch_label_3
				}
			}
			rt.call_method(this.image, 'setOption', [rt.new_string('webp:lossless'),
				rt.new_string('true')])
			if rt.has_exception() {
				unsafe {
					goto catch_label_3
				}
			}
			this.Class_WP_Image_Editor.set_quality(rt.new_int(100))
			if rt.has_exception() {
				unsafe {
					goto catch_label_3
				}
			}
		} else {
			rt.call_method(this.image, 'setImageCompressionQuality', [
				var_quality_mutated.clone()])
			if rt.has_exception() {
				unsafe {
					goto catch_label_3
				}
			}
			rt.call_method(this.image, 'setCompressionQuality', [
				var_quality_mutated.clone()])
			if rt.has_exception() {
				unsafe {
					goto catch_label_3
				}
			}
		}
		if rt.has_exception() {
			unsafe {
				goto catch_label_3
			}
		}
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('image/avif'))) {
		rt.call_method(this.image, 'setOption', [rt.new_string('heic:speed'),
			rt.new_int(7)])
		if rt.has_exception() {
			unsafe {
				goto catch_label_3
			}
		}
		rt.call_method(this.image, 'setImageCompressionQuality', [
			var_quality_mutated.clone()])
		if rt.has_exception() {
			unsafe {
				goto catch_label_3
			}
		}
		rt.call_method(this.image, 'setCompressionQuality', [
			var_quality_mutated.clone()])
		if rt.has_exception() {
			unsafe {
				goto catch_label_3
			}
		}
	} else {
		rt.call_method(this.image, 'setImageCompressionQuality', [
			var_quality_mutated.clone()])
		if rt.has_exception() {
			unsafe {
				goto catch_label_3
			}
		}
		rt.call_method(this.image, 'setCompressionQuality', [
			var_quality_mutated.clone()])
		if rt.has_exception() {
			unsafe {
				goto catch_label_3
			}
		}
	}
	if rt.has_exception() {
		unsafe {
			goto catch_label_3
		}
	}
	unsafe {
		goto end_label_3
	}
	catch_label_3:
	mut var_e_3 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_3, 'Exception') {
		mut var_e := var_e_3.clone()
		return (create_wp_error(rt.new_string('image_quality_error'), rt.call_method(var_e,
			'getMessage', []rt.PhpVal{}))).to_bool()
		unsafe {
			goto end_label_3
		}
	} else {
		rt.throw_exception(var_e_3)
		unsafe {
			goto end_label_3
		}
	}

	end_label_3:
	return true
}

fn (mut this Class_WP_Image_Editor_Imagick) update_size(var_width rt.PhpVal, var_height rt.PhpVal) rt.PhpVal {
	mut var_width_mutated := var_width
	mut var_height_mutated := var_height
	mut var_size := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(var_width_mutated))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(var_height_mutated)))) {
		var_size = rt.call_method(this.image, 'getImageGeometry', []rt.PhpVal{})
		if rt.has_exception() {
			unsafe {
				goto catch_label_4
			}
		}
		unsafe {
			goto end_label_4
		}
		catch_label_4:
		mut var_e_4 := rt.get_and_clear_exception()
		if rt.instance_of(var_e_4, 'Exception') {
			mut var_e := var_e_4.clone()
			return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('invalid_image'), rt.call_function('__', [
				rt.new_string('Could not read image size.'),
			]), rt.get_property(rt.new_object('WP_Image_Editor_Imagick', [
				'WP_Image_Editor',
			], &this), 'file')))
			unsafe {
				goto end_label_4
			}
		} else {
			rt.throw_exception(var_e_4)
			unsafe {
				goto end_label_4
			}
		}

		end_label_4:
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_width_mutated)))) {
		var_width_mutated = var_size.array_get(rt.new_string('width'))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_height_mutated)))) {
		var_height_mutated = var_size.array_get(rt.new_string('height'))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_width_mutated))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(var_height_mutated))))
		&& rt.is_true(rt.identical(rt.new_string('image/avif'), rt.get_property(rt.new_object('WP_Image_Editor_Imagick', ['WP_Image_Editor'], &this), 'mime_type')))
		|| rt.is_true(rt.call_function('wp_is_heic_image_mime_type', [rt.get_property(rt.new_object('WP_Image_Editor_Imagick', ['WP_Image_Editor'], &this), 'mime_type')])) {
		var_size = rt.call_function('wp_getimagesize', [
			rt.get_property(rt.new_object('WP_Image_Editor_Imagick', [
				'WP_Image_Editor',
			], &this), 'file'),
		])
		var_width_mutated = var_size.array_get(rt.new_int(0))
		var_height_mutated = var_size.array_get(rt.new_int(1))
	}
	return this.Class_WP_Image_Editor.update_size(var_width_mutated.clone(),
		var_height_mutated.clone())
}

fn Class_WP_Image_Editor_Imagick.set_imagick_time_limit() rt.PhpVal {
	rt.call_function('_deprecated_function', [rt.new_string(@METHOD),
		rt.new_string('6.3.0')])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('Imagick::RESOURCETYPE_TIME'),
	])))))
	{
		return rt.new_null()
	}
	mut iife_temp_3 := Class_Imagick{}
	mut iife_result_3 := iife_temp_3.getresourcelimit(Class_Imagick.resourcetype_time())
	mut var_imagick_timeout := iife_result_3
	var_imagick_timeout = if rt.is_true(rt.greater(var_imagick_timeout,
		rt.get_constant('PHP_INT_MAX')))
	{
		rt.get_constant('PHP_INT_MAX')
	} else {
		rt.new_int(var_imagick_timeout.to_i64())
	}
	mut var_php_timeout := rt.new_int((rt.call_function('ini_get', [
		rt.new_string('max_execution_time'),
	])).to_i64())
	if rt.is_true(rt.greater(var_php_timeout, rt.new_int(1)))
		&& rt.is_true(rt.less(var_php_timeout, var_imagick_timeout)) {
		mut var_limit := rt.new_float(0.8 * var_php_timeout)
		mut iife_temp_4 := Class_Imagick{}
		mut iife_result_4 := iife_temp_4.setresourcelimit(Class_Imagick.resourcetype_time(),
			var_limit.clone())
		return var_limit.clone()
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
	if rt.is_true(rt.identical(rt.get_property(rt.new_object('WP_Image_Editor_Imagick', ['WP_Image_Editor'], &this), 'size').array_get(rt.new_string('width')), var_max_w))
		&& rt.is_true(rt.identical(rt.get_property(rt.new_object('WP_Image_Editor_Imagick', ['WP_Image_Editor'], &this), 'size').array_get(rt.new_string('height')), var_max_h)) {
		return true
	}
	mut var_dims := rt.call_function('image_resize_dimensions', [
		rt.get_property(rt.new_object('WP_Image_Editor_Imagick', ['WP_Image_Editor'], &this),
			'size').array_get(rt.new_string('width')),
		rt.get_property(rt.new_object('WP_Image_Editor_Imagick', ['WP_Image_Editor'], &this),
			'size').array_get(rt.new_string('height')),
		var_max_w.clone(),
		var_max_h.clone(),
		rt.new_bool(crop),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_dims)))) {
		return (create_wp_error(rt.new_string('error_getting_dimensions'), rt.call_function('__', [
			rt.new_string('Could not calculate resized image dimensions'),
		]))).to_bool()
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
	if var_crop {
		return (this.crop(var_src_x.clone(), var_src_y.clone(), var_src_w.clone(),
			var_src_h.clone(), var_dst_w.clone(), var_dst_h.clone(), false)).to_bool()
	}
	this.set_quality(rt.new_null(), rt.create_array([
		rt.ArrayItem{ key: 'width', val: var_dst_w },
		rt.ArrayItem{ key: 'height', val: var_dst_h },
	]))
	mut var_thumb_result := this.thumbnail_image(var_dst_w.clone(), var_dst_h.clone(), '', false)
	if rt.is_true(rt.call_function('is_wp_error', [var_thumb_result.clone()])) {
		return var_thumb_result.to_bool()
	}
	return (this.update_size(var_dst_w.clone(), var_dst_h.clone())).to_bool()
}

fn (mut this Class_WP_Image_Editor_Imagick) thumbnail_image(var_dst_w rt.PhpVal, var_dst_h rt.PhpVal, filter_name string, strip_meta bool) rt.PhpVal {
	mut var_dst_w_mutated := var_dst_w
	mut var_dst_h_mutated := var_dst_h
	mut var_allowed_filters := ['FILTER_POINT', 'FILTER_BOX', 'FILTER_TRIANGLE', 'FILTER_HERMITE',
		'FILTER_HANNING', 'FILTER_HAMMING', 'FILTER_BLACKMAN', 'FILTER_GAUSSIAN', 'FILTER_QUADRATIC',
		'FILTER_CUBIC', 'FILTER_CATROM', 'FILTER_MITCHELL', 'FILTER_LANCZOS', 'FILTER_BESSEL',
		'FILTER_SINC']
	if rt.is_true(rt.call_function('in_array', [rt.new_string(filter_name), rt.create_array_from_list(var_allowed_filters), rt.new_bool(true)]))
		&& rt.is_true(rt.call_function('defined', [rt.new_string('Imagick::' + filter_name)])) {
		mut var_filter := rt.call_function('constant', [
			rt.new_string('Imagick::' + filter_name),
		])
	} else {
		var_filter = if rt.is_true(rt.call_function('defined', [
			rt.new_string('Imagick::FILTER_TRIANGLE'),
		]))
		{ Class_Imagick.filter_triangle() } else { rt.new_bool(false) }
	}
	if rt.is_true(rt.call_function('apply_filters', [rt.new_string('image_strip_meta'),
		rt.new_bool(strip_meta)]))
	{
		this.strip_meta()
	}
	mut var_is_png := rt.new_bool(false)
	if rt.has_exception() {
		unsafe {
			goto catch_label_5
		}
	}
	mut var_is_indexed_png := rt.new_bool(false)
	if rt.has_exception() {
		unsafe {
			goto catch_label_5
		}
	}
	mut var_is_indexed_png_with_alpha_channel := rt.new_bool(false)
	if rt.has_exception() {
		unsafe {
			goto catch_label_5
		}
	}
	mut var_is_indexed_png_with_true_alpha_transparency := rt.new_bool(false)
	if rt.has_exception() {
		unsafe {
			goto catch_label_5
		}
	}
	if rt.is_true(rt.identical(rt.new_string('image/png'), rt.get_property(rt.new_object('WP_Image_Editor_Imagick', [
		'WP_Image_Editor',
	], &this), 'mime_type')))
	{
		var_is_png = rt.new_bool(true)
		if rt.has_exception() {
			unsafe {
				goto catch_label_5
			}
		}
		if rt.call_function('is_callable', [rt.create_array([rt.ArrayItem{
			key: none
			val: this.image
		}, rt.ArrayItem{ key: none, val: 'getImageProperty' }])])
			&& rt.is_true(rt.identical(rt.new_string('3'), rt.call_method(this.image, 'getImageProperty', [rt.new_string('png:IHDR.color-type-orig')]))) {
			var_is_indexed_png = rt.new_bool(true)
			if rt.has_exception() {
				unsafe {
					goto catch_label_5
				}
			}
			if rt.call_function('is_callable', [rt.create_array([rt.ArrayItem{
				key: none
				val: this.image
			}, rt.ArrayItem{ key: none, val: 'getImageAlphaChannel' }])])
				&& rt.is_true(rt.call_method(this.image, 'getImageAlphaChannel', []rt.PhpVal{})) {
				var_is_indexed_png_with_alpha_channel = rt.new_bool(true)
				if rt.has_exception() {
					unsafe {
						goto catch_label_5
					}
				}
				if rt.call_function('is_callable', [rt.create_array([rt.ArrayItem{
					key: none
					val: this.image
				}, rt.ArrayItem{ key: none, val: 'getImageChannelDepth' }])])
					&& rt.is_true(rt.call_function('defined', [rt.new_string('Imagick::CHANNEL_ALPHA')]))
					&& rt.is_true(rt.less(rt.new_int(1), rt.call_method(this.image, 'getImageChannelDepth', [Class_Imagick.channel_alpha()]))) {
					var_is_indexed_png_with_true_alpha_transparency = rt.new_bool(true)
					if rt.has_exception() {
						unsafe {
							goto catch_label_5
						}
					}
				}
				if rt.has_exception() {
					unsafe {
						goto catch_label_5
					}
				}
			}
			if rt.has_exception() {
				unsafe {
					goto catch_label_5
				}
			}
		}
		if rt.has_exception() {
			unsafe {
				goto catch_label_5
			}
		}
	}
	if rt.has_exception() {
		unsafe {
			goto catch_label_5
		}
	}
	if rt.is_true(rt.call_function('is_callable', [
		rt.create_array([rt.ArrayItem{ key: none, val: this.image },
			rt.ArrayItem{ key: none, val: 'sampleImage' }]),
	]))
	{
		mut var_resize_ratio := rt.mul(rt.div(var_dst_w_mutated, rt.get_property(rt.new_object('WP_Image_Editor_Imagick', [
			'WP_Image_Editor',
		], &this), 'size').array_get(rt.new_string('width'))), rt.div(var_dst_h_mutated, rt.get_property(rt.new_object('WP_Image_Editor_Imagick', [
			'WP_Image_Editor',
		], &this), 'size').array_get(rt.new_string('height'))))
		if rt.has_exception() {
			unsafe {
				goto catch_label_5
			}
		}
		mut var_sample_factor := rt.new_int(5)
		if rt.has_exception() {
			unsafe {
				goto catch_label_5
			}
		}
		if rt.is_true(rt.less(var_resize_ratio, rt.new_float(0.111)))
			&& rt.is_true(rt.greater(rt.mul(var_dst_w_mutated, var_sample_factor), rt.new_int(128)))
			&& rt.is_true(rt.greater(rt.mul(var_dst_h_mutated, var_sample_factor), rt.new_int(128))) {
			rt.call_method(this.image, 'sampleImage', [
				rt.mul(var_dst_w_mutated, var_sample_factor),
				rt.mul(var_dst_h_mutated, var_sample_factor),
			])
			if rt.has_exception() {
				unsafe {
					goto catch_label_5
				}
			}
		}
		if rt.has_exception() {
			unsafe {
				goto catch_label_5
			}
		}
	}
	if rt.has_exception() {
		unsafe {
			goto catch_label_5
		}
	}
	if rt.call_function('is_callable', [rt.create_array([rt.ArrayItem{ key: none, val: this.image }, rt.ArrayItem{
		key: none
		val: 'resizeImage'
	}])])
		&& rt.is_true(var_filter) {
		rt.call_method(this.image, 'setOption', [rt.new_string('filter:support'),
			rt.new_string('2.0')])
		if rt.has_exception() {
			unsafe {
				goto catch_label_5
			}
		}
		rt.call_method(this.image, 'resizeImage', [var_dst_w_mutated.clone(),
			var_dst_h_mutated.clone(), var_filter.clone(), rt.new_int(1)])
		if rt.has_exception() {
			unsafe {
				goto catch_label_5
			}
		}
	} else {
		rt.call_method(this.image, 'scaleImage', [var_dst_w_mutated.clone(),
			var_dst_h_mutated.clone()])
		if rt.has_exception() {
			unsafe {
				goto catch_label_5
			}
		}
	}
	if rt.has_exception() {
		unsafe {
			goto catch_label_5
		}
	}
	if rt.is_true(rt.identical(rt.new_string('image/jpeg'), rt.get_property(rt.new_object('WP_Image_Editor_Imagick', [
		'WP_Image_Editor',
	], &this), 'mime_type')))
	{
		if rt.is_true(rt.call_function('is_callable', [
			rt.create_array([rt.ArrayItem{ key: none, val: this.image },
				rt.ArrayItem{ key: none, val: 'unsharpMaskImage' }]),
		]))
		{
			rt.call_method(this.image, 'unsharpMaskImage', [rt.new_float(0.25),
				rt.new_float(0.25), rt.new_int(8), rt.new_float(0.065)])
			if rt.has_exception() {
				unsafe {
					goto catch_label_5
				}
			}
		}
		if rt.has_exception() {
			unsafe {
				goto catch_label_5
			}
		}
		rt.call_method(this.image, 'setOption', [rt.new_string('jpeg:fancy-upsampling'),
			rt.new_string('off')])
		if rt.has_exception() {
			unsafe {
				goto catch_label_5
			}
		}
	}
	if rt.has_exception() {
		unsafe {
			goto catch_label_5
		}
	}
	if rt.is_true(var_is_png) {
		rt.call_method(this.image, 'setOption', [rt.new_string('png:compression-filter'),
			rt.new_string('5')])
		if rt.has_exception() {
			unsafe {
				goto catch_label_5
			}
		}
		rt.call_method(this.image, 'setOption', [rt.new_string('png:compression-level'),
			rt.new_string('9')])
		if rt.has_exception() {
			unsafe {
				goto catch_label_5
			}
		}
		rt.call_method(this.image, 'setOption', [
			rt.new_string('png:compression-strategy'),
			rt.new_string('1'),
		])
		if rt.has_exception() {
			unsafe {
				goto catch_label_5
			}
		}
		if rt.is_true(var_is_indexed_png) {
			if rt.is_true(var_is_indexed_png_with_alpha_channel) {
				rt.call_method(this.image, 'setOption', [
					rt.new_string('png:include-chunk'),
					rt.new_string('tRNS'),
				])
				if rt.has_exception() {
					unsafe {
						goto catch_label_5
					}
				}
			} else {
				rt.call_method(this.image, 'setOption', [
					rt.new_string('png:exclude-chunk'),
					rt.new_string('all'),
				])
				if rt.has_exception() {
					unsafe {
						goto catch_label_5
					}
				}
			}
			if rt.has_exception() {
				unsafe {
					goto catch_label_5
				}
			}
			rt.call_method(this.image, 'quantizeImage', [rt.new_int(256),
				rt.call_method(this.image, 'getColorspace', []rt.PhpVal{}),
				rt.new_int(0), rt.new_bool(false), rt.new_bool(false)])
			if rt.has_exception() {
				unsafe {
					goto catch_label_5
				}
			}
			if rt.is_true(rt.identical(Class_Imagick.colorspace_gray(), rt.call_method(this.image, 'getImageColorspace', []rt.PhpVal{})))
				&& rt.is_true(rt.new_bool(!(rt.is_true(var_is_indexed_png_with_true_alpha_transparency)))) {
				rt.call_method(this.image, 'setOption', [rt.new_string('png:format'),
					rt.new_string('png8')])
				if rt.has_exception() {
					unsafe {
						goto catch_label_5
					}
				}
			}
			if rt.has_exception() {
				unsafe {
					goto catch_label_5
				}
			}
		} else {
			rt.call_method(this.image, 'setOption', [rt.new_string('png:exclude-chunk'),
				rt.new_string('all')])
			if rt.has_exception() {
				unsafe {
					goto catch_label_5
				}
			}
		}
		if rt.has_exception() {
			unsafe {
				goto catch_label_5
			}
		}
	}
	if rt.has_exception() {
		unsafe {
			goto catch_label_5
		}
	}
	if rt.call_function('is_callable', [rt.create_array([rt.ArrayItem{ key: none, val: this.image }, rt.ArrayItem{
		key: none
		val: 'getImageAlphaChannel'
	}])])
		&& rt.call_function('is_callable', [rt.create_array([rt.ArrayItem{
		key: none
		val: this.image
	}, rt.ArrayItem{ key: none, val: 'setImageAlphaChannel' }])])
		&& rt.is_true(rt.call_function('defined', [rt.new_string('Imagick::ALPHACHANNEL_UNDEFINED')]))
		&& rt.is_true(rt.call_function('defined', [rt.new_string('Imagick::ALPHACHANNEL_OPAQUE')])) {
		if rt.is_true(rt.identical(rt.call_method(this.image, 'getImageAlphaChannel', []rt.PhpVal{}),
			Class_Imagick.alphachannel_undefined()))
		{
			rt.call_method(this.image, 'setImageAlphaChannel', [
				Class_Imagick.alphachannel_opaque(),
			])
			if rt.has_exception() {
				unsafe {
					goto catch_label_5
				}
			}
		}
		if rt.has_exception() {
			unsafe {
				goto catch_label_5
			}
		}
	}
	if rt.has_exception() {
		unsafe {
			goto catch_label_5
		}
	}
	if rt.call_function('is_callable', [rt.create_array([rt.ArrayItem{ key: none, val: this.image }, rt.ArrayItem{
		key: none
		val: 'getImageDepth'
	}])])
		&& rt.call_function('is_callable', [rt.create_array([rt.ArrayItem{
		key: none
		val: this.image
	}, rt.ArrayItem{ key: none, val: 'setImageDepth' }])]) {
		mut var_max_depth := rt.call_function('apply_filters', [
			rt.new_string('image_max_bit_depth'),
			rt.call_method(this.image, 'getImageDepth', []rt.PhpVal{}),
			rt.call_method(this.image, 'getImageDepth', []rt.PhpVal{}),
		])
		if rt.has_exception() {
			unsafe {
				goto catch_label_5
			}
		}
		rt.call_method(this.image, 'setImageDepth', [var_max_depth.clone()])
		if rt.has_exception() {
			unsafe {
				goto catch_label_5
			}
		}
	}
	if rt.has_exception() {
		unsafe {
			goto catch_label_5
		}
	}
	unsafe {
		goto end_label_5
	}
	catch_label_5:
	mut var_e_5 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_5, 'Exception') {
		mut var_e := var_e_5.clone()
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('image_resize_error'), rt.call_method(var_e,
			'getMessage', []rt.PhpVal{})))
		unsafe {
			goto end_label_5
		}
	} else {
		rt.throw_exception(var_e_5)
		unsafe {
			goto end_label_5
		}
	}

	end_label_5:
	return rt.new_null()
}

fn (mut this Class_WP_Image_Editor_Imagick) multi_resize(var_sizes rt.PhpVal) rt.PhpVal {
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

fn (mut this Class_WP_Image_Editor_Imagick) make_subsize(var_size_data rt.PhpVal) rt.PhpVal {
	mut var_size_data_mutated := var_size_data
	if !(var_size_data_mutated.array_isset(rt.new_string('width')))
		&& !(var_size_data_mutated.array_isset(rt.new_string('height'))) {
		return create_wp_error(rt.new_string('image_subsize_create_error'), rt.call_function('__', [
			rt.new_string('Cannot resize the image. Both width and height are not set.'),
		]))
	}
	mut var_orig_size := rt.get_property(rt.new_object('WP_Image_Editor_Imagick', [
		'WP_Image_Editor',
	], &this), 'size')
	mut var_orig_image := rt.call_method(this.image, 'getImage', []rt.PhpVal{})
	if !(var_size_data_mutated.array_isset(rt.new_string('width'))) {
		var_size_data_mutated.array_set('width', rt.new_null())
	}
	if !(var_size_data_mutated.array_isset(rt.new_string('height'))) {
		var_size_data_mutated.array_set('height', rt.new_null())
	}
	if !(var_size_data_mutated.array_isset(rt.new_string('crop'))) {
		var_size_data_mutated.array_set('crop', false)
	}
	if rt.is_true(rt.identical(rt.get_property(rt.new_object('WP_Image_Editor_Imagick', ['WP_Image_Editor'], &this), 'size').array_get(rt.new_string('width')), var_size_data_mutated.array_get(rt.new_string('width'))))
		&& rt.is_true(rt.identical(rt.get_property(rt.new_object('WP_Image_Editor_Imagick', ['WP_Image_Editor'], &this), 'size').array_get(rt.new_string('height')), var_size_data_mutated.array_get(rt.new_string('height')))) {
		return create_wp_error(rt.new_string('image_subsize_create_error'), rt.call_function('__', [
			rt.new_string('The image already has the requested size.'),
		]))
	}
	mut var_resized := rt.new_bool(this.resize(var_size_data_mutated.array_get(rt.new_string('width')),
		var_size_data_mutated.array_get(rt.new_string('height')),
		(var_size_data_mutated.array_get(rt.new_string('crop'))).to_bool()))
	if rt.is_true(rt.call_function('is_wp_error', [var_resized.clone()])) {
		mut var_saved := var_resized.clone()
	} else {
		var_saved = this._save(this.image, rt.new_null(), rt.new_null())
		rt.call_method(this.image, 'clear', []rt.PhpVal{})
		rt.call_method(this.image, 'destroy', []rt.PhpVal{})
		this.image = rt.new_null()
	}
	this.dispatch_set_prop('size', var_orig_size.clone())
	this.image = var_orig_image.clone()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [
		var_saved.clone()])))))
	{
		var_saved.array_unset(rt.new_string('path'))
	}
	return var_saved.clone()
}

fn (mut this Class_WP_Image_Editor_Imagick) crop(var_src_x rt.PhpVal, var_src_y rt.PhpVal, var_src_w rt.PhpVal, var_src_h rt.PhpVal, var_dst_w rt.PhpVal, var_dst_h rt.PhpVal, src_abs bool) rt.PhpVal {
	mut var_dst_w_mutated := var_dst_w
	mut var_dst_h_mutated := var_dst_h
	if var_src_abs {
		var_src_w = rt.sub(var_src_w, var_src_x)
		var_src_h = rt.sub(var_src_h, var_src_y)
	}
	rt.call_method(this.image, 'cropImage', [var_src_w.clone(),
		var_src_h.clone(), var_src_x.clone(), var_src_y.clone()])
	if rt.has_exception() {
		unsafe {
			goto catch_label_6
		}
	}
	rt.call_method(this.image, 'setImagePage', [var_src_w.clone(),
		var_src_h.clone(), rt.new_int(0), rt.new_int(0)])
	if rt.has_exception() {
		unsafe {
			goto catch_label_6
		}
	}
	if rt.is_true(var_dst_w_mutated) || rt.is_true(var_dst_h_mutated) {
		if rt.is_true(rt.new_bool(!(rt.is_true(var_dst_w_mutated)))) {
			var_dst_w_mutated = var_src_w
			if rt.has_exception() {
				unsafe {
					goto catch_label_6
				}
			}
		}
		if rt.has_exception() {
			unsafe {
				goto catch_label_6
			}
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(var_dst_h_mutated)))) {
			var_dst_h_mutated = var_src_h
			if rt.has_exception() {
				unsafe {
					goto catch_label_6
				}
			}
		}
		if rt.has_exception() {
			unsafe {
				goto catch_label_6
			}
		}
		mut var_thumb_result := this.thumbnail_image(var_dst_w_mutated.clone(),
			var_dst_h_mutated.clone(), '', false)
		if rt.has_exception() {
			unsafe {
				goto catch_label_6
			}
		}
		if rt.is_true(rt.call_function('is_wp_error', [var_thumb_result.clone()])) {
			return var_thumb_result.clone()
		}
		if rt.has_exception() {
			unsafe {
				goto catch_label_6
			}
		}
		return this.update_size(rt.new_null(), rt.new_null())
	}
	if rt.has_exception() {
		unsafe {
			goto catch_label_6
		}
	}
	unsafe {
		goto end_label_6
	}
	catch_label_6:
	mut var_e_6 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_6, 'Exception') {
		mut var_e := var_e_6.clone()
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('image_crop_error'), rt.call_method(var_e,
			'getMessage', []rt.PhpVal{})))
		unsafe {
			goto end_label_6
		}
	} else {
		rt.throw_exception(var_e_6)
		unsafe {
			goto end_label_6
		}
	}

	end_label_6:
	return this.update_size(rt.new_null(), rt.new_null())
}

fn (mut this Class_WP_Image_Editor_Imagick) rotate(var_angle rt.PhpVal) bool {
	rt.call_method(this.image, 'rotateImage', [
		create_imagickpixel(rt.new_string('none')),
		rt.sub(rt.new_int(360), var_angle),
	])
	if rt.has_exception() {
		unsafe {
			goto catch_label_7
		}
	}
	if rt.call_function('is_callable', [rt.create_array([rt.ArrayItem{ key: none, val: this.image }, rt.ArrayItem{
		key: none
		val: 'setImageOrientation'
	}])])
		&& rt.is_true(rt.call_function('defined', [rt.new_string('Imagick::ORIENTATION_TOPLEFT')])) {
		rt.call_method(this.image, 'setImageOrientation', [
			Class_Imagick.orientation_topleft(),
		])
		if rt.has_exception() {
			unsafe {
				goto catch_label_7
			}
		}
	}
	if rt.has_exception() {
		unsafe {
			goto catch_label_7
		}
	}
	mut var_result := this.update_size(rt.new_null(), rt.new_null())
	if rt.has_exception() {
		unsafe {
			goto catch_label_7
		}
	}
	if rt.is_true(rt.call_function('is_wp_error', [var_result.clone()])) {
		return var_result.to_bool()
	}
	if rt.has_exception() {
		unsafe {
			goto catch_label_7
		}
	}
	rt.call_method(this.image, 'setImagePage', [rt.get_property(rt.new_object('WP_Image_Editor_Imagick', [
		'WP_Image_Editor',
	], &this), 'size').array_get(rt.new_string('width')),
		rt.get_property(rt.new_object('WP_Image_Editor_Imagick', [
			'WP_Image_Editor',
		], &this), 'size').array_get(rt.new_string('height')),
		rt.new_int(0), rt.new_int(0)])
	if rt.has_exception() {
		unsafe {
			goto catch_label_7
		}
	}
	unsafe {
		goto end_label_7
	}
	catch_label_7:
	mut var_e_7 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_7, 'Exception') {
		mut var_e := var_e_7.clone()
		return (create_wp_error(rt.new_string('image_rotate_error'), rt.call_method(var_e,
			'getMessage', []rt.PhpVal{}))).to_bool()
		unsafe {
			goto end_label_7
		}
	} else {
		rt.throw_exception(var_e_7)
		unsafe {
			goto end_label_7
		}
	}

	end_label_7:
	return true
}

fn (mut this Class_WP_Image_Editor_Imagick) flip(var_horz rt.PhpVal, var_vert rt.PhpVal) bool {
	if rt.is_true(var_horz) {
		rt.call_method(this.image, 'flipImage', []rt.PhpVal{})
		if rt.has_exception() {
			unsafe {
				goto catch_label_8
			}
		}
	}
	if rt.has_exception() {
		unsafe {
			goto catch_label_8
		}
	}
	if rt.is_true(var_vert) {
		rt.call_method(this.image, 'flopImage', []rt.PhpVal{})
		if rt.has_exception() {
			unsafe {
				goto catch_label_8
			}
		}
	}
	if rt.has_exception() {
		unsafe {
			goto catch_label_8
		}
	}
	if rt.call_function('is_callable', [rt.create_array([rt.ArrayItem{ key: none, val: this.image }, rt.ArrayItem{
		key: none
		val: 'setImageOrientation'
	}])])
		&& rt.is_true(rt.call_function('defined', [rt.new_string('Imagick::ORIENTATION_TOPLEFT')])) {
		rt.call_method(this.image, 'setImageOrientation', [
			Class_Imagick.orientation_topleft(),
		])
		if rt.has_exception() {
			unsafe {
				goto catch_label_8
			}
		}
	}
	if rt.has_exception() {
		unsafe {
			goto catch_label_8
		}
	}
	unsafe {
		goto end_label_8
	}
	catch_label_8:
	mut var_e_8 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_8, 'Exception') {
		mut var_e := var_e_8.clone()
		return (create_wp_error(rt.new_string('image_flip_error'), rt.call_method(var_e,
			'getMessage', []rt.PhpVal{}))).to_bool()
		unsafe {
			goto end_label_8
		}
	} else {
		rt.throw_exception(var_e_8)
		unsafe {
			goto end_label_8
		}
	}

	end_label_8:
	return true
}

fn (mut this Class_WP_Image_Editor_Imagick) maybe_exif_rotate() rt.PhpVal {
	if rt.call_function('is_callable', [rt.create_array([rt.ArrayItem{ key: none, val: this.image }, rt.ArrayItem{
		key: none
		val: 'setImageOrientation'
	}])])
		&& rt.is_true(rt.call_function('defined', [rt.new_string('Imagick::ORIENTATION_TOPLEFT')])) {
		return this.Class_WP_Image_Editor.maybe_exif_rotate()
	} else {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('write_exif_error'), rt.call_function('__', [
			rt.new_string('The image cannot be rotated because the embedded meta data cannot be updated.'),
		])))
	}
	return rt.new_null()
}

fn (mut this Class_WP_Image_Editor_Imagick) save(var_destfilename rt.PhpVal, var_mime_type rt.PhpVal) rt.PhpVal {
	mut var_saved := this._save(this.image, var_destfilename.clone(), var_mime_type.clone())
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [
		var_saved.clone()])))))
	{
		this.dispatch_set_prop('file', var_saved.array_get(rt.new_string('path')))
		this.dispatch_set_prop('mime_type', var_saved.array_get(rt.new_string('mime-type')))
		rt.call_method(this.image, 'setImageFormat', [
			rt.new_string(this.get_extension(rt.get_property(rt.new_object('WP_Image_Editor_Imagick', [
				'WP_Image_Editor',
			], &this), 'mime_type')).to_string().to_upper()),
		])
		if rt.has_exception() {
			unsafe {
				goto catch_label_9
			}
		}
		unsafe {
			goto end_label_9
		}
		catch_label_9:
		mut var_e_9 := rt.get_and_clear_exception()
		if rt.instance_of(var_e_9, 'Exception') {
			mut var_e := var_e_9.clone()
			return create_wp_error(rt.new_string('image_save_error'), rt.call_method(var_e,
				'getMessage', []rt.PhpVal{}), rt.get_property(rt.new_object('WP_Image_Editor_Imagick', [
				'WP_Image_Editor',
			], &this), 'file'))
			unsafe {
				goto end_label_9
			}
		} else {
			rt.throw_exception(var_e_9)
			unsafe {
				goto end_label_9
			}
		}

		end_label_9:
	}
	return var_saved.clone()
}

fn (mut this Class_WP_Image_Editor_Imagick) remove_pdf_alpha_channel() rt.PhpVal {
	mut iife_temp_5 := Class_Imagick{}
	mut iife_result_5 := iife_temp_5.getversion()
	mut var_version := iife_result_5
	if rt.is_true(rt.greater_equal(var_version.array_get(rt.new_string('versionNumber')),
		rt.new_int(1653)))
	{
		rt.call_method(this.image, 'setImageAlphaChannel', [if rt.is_true(rt.call_function('defined', [
			rt.new_string('Imagick::ALPHACHANNEL_REMOVE'),
		]))
		{ Class_Imagick.alphachannel_remove() } else { rt.new_int(12) }])
		if rt.has_exception() {
			unsafe {
				goto catch_label_10
			}
		}
		unsafe {
			goto end_label_10
		}
		catch_label_10:
		mut var_e_10 := rt.get_and_clear_exception()
		if rt.instance_of(var_e_10, 'Exception') {
			mut var_e := var_e_10.clone()
			return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('pdf_alpha_process_failed'), rt.call_method(var_e,
				'getMessage', []rt.PhpVal{})))
			unsafe {
				goto end_label_10
			}
		} else {
			rt.throw_exception(var_e_10)
			unsafe {
				goto end_label_10
			}
		}

		end_label_10:
	}
	return rt.new_null()
}

fn (mut this Class_WP_Image_Editor_Imagick) _save(var_image rt.PhpVal, var_filename rt.PhpVal, var_mime_type rt.PhpVal) rt.PhpVal {
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
	mut var_orig_format := rt.call_method(this.image, 'getImageFormat', []rt.PhpVal{})
	if rt.has_exception() {
		unsafe {
			goto catch_label_11
		}
	}
	rt.call_method(this.image, 'setImageFormat', [
		rt.new_string(this.get_extension(var_mime_type.clone()).to_string().to_upper()),
	])
	if rt.has_exception() {
		unsafe {
			goto catch_label_11
		}
	}
	unsafe {
		goto end_label_11
	}
	catch_label_11:
	mut var_e_11 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_11, 'Exception') {
		mut var_e := var_e_11.clone()
		return create_wp_error(rt.new_string('image_save_error'), rt.call_method(var_e,
			'getMessage', []rt.PhpVal{}), var_filename_mutated.clone())
		unsafe {
			goto end_label_11
		}
	} else {
		rt.throw_exception(var_e_11)
		unsafe {
			goto end_label_11
		}
	}

	end_label_11:
	if rt.is_true(rt.call_function('method_exists', [this.image, rt.new_string('setInterlaceScheme')]))
		&& rt.is_true(rt.call_function('method_exists', [this.image, rt.new_string('getInterlaceScheme')]))
		&& rt.is_true(rt.call_function('defined', [rt.new_string('Imagick::INTERLACE_PLANE')])) {
		mut var_orig_interlace := rt.call_method(this.image, 'getInterlaceScheme', []rt.PhpVal{})
		if rt.is_true(rt.call_function('apply_filters', [
			rt.new_string('image_save_progressive'),
			rt.new_bool(false),
			var_mime_type.clone(),
		]))
		{
			rt.call_method(this.image, 'setInterlaceScheme', [
				Class_Imagick.interlace_plane(),
			])
		} else {
			rt.call_method(this.image, 'setInterlaceScheme', [
				Class_Imagick.interlace_no(),
			])
		}
	}
	mut var_write_image_result := rt.new_bool(this.write_image(this.image,
		var_filename_mutated.clone()))
	if rt.is_true(rt.call_function('is_wp_error', [var_write_image_result.clone()])) {
		return var_write_image_result.clone()
	}
	rt.call_method(this.image, 'setImageFormat', [var_orig_format.clone()])
	if rt.has_exception() {
		unsafe {
			goto catch_label_12
		}
	}
	if !var_orig_interlace.is_null() {
		rt.call_method(this.image, 'setInterlaceScheme', [var_orig_interlace.clone()])
		if rt.has_exception() {
			unsafe {
				goto catch_label_12
			}
		}
	}
	if rt.has_exception() {
		unsafe {
			goto catch_label_12
		}
	}
	unsafe {
		goto end_label_12
	}
	catch_label_12:
	mut var_e_12 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_12, 'Exception') {
		var_e = var_e_12.clone()
		return create_wp_error(rt.new_string('image_save_error'), rt.call_method(var_e,
			'getMessage', []rt.PhpVal{}), var_filename_mutated.clone())
		unsafe {
			goto end_label_12
		}
	} else {
		rt.throw_exception(var_e_12)
		unsafe {
			goto end_label_12
		}
	}

	end_label_12:
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
		]) }, rt.ArrayItem{ key: 'width', val: rt.get_property(rt.new_object('WP_Image_Editor_Imagick', [
			'WP_Image_Editor',
		], &this), 'size').array_get(rt.new_string('width')) },
		rt.ArrayItem{ key: 'height', val: rt.get_property(rt.new_object('WP_Image_Editor_Imagick', [
			'WP_Image_Editor',
		], &this), 'size').array_get(rt.new_string('height')) },
		rt.ArrayItem{ key: 'mime-type', val: var_mime_type },
		rt.ArrayItem{ key: 'filesize', val: rt.call_function('wp_filesize', [
			var_filename_mutated.clone(),
		]) }])
}

fn (mut this Class_WP_Image_Editor_Imagick) write_image(var_image rt.PhpVal, var_filename rt.PhpVal) bool {
	mut var_filename_mutated := var_filename
	if rt.is_true(rt.call_function('wp_is_stream', [var_filename_mutated.clone()])) {
		if rt.is_true(rt.identical(rt.call_function('file_put_contents', [
			var_filename_mutated.clone(), rt.call_method(var_image, 'getImageBlob', []rt.PhpVal{})]),
			rt.new_bool(false)))
		{
			return (create_wp_error(rt.new_string('image_save_error'), rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('%s failed while writing image to stream.'),
				]),
				rt.new_string('<code>file_put_contents()</code>'),
			]), var_filename_mutated.clone())).to_bool()
		} else {
			return true
		}
	} else {
		mut var_dirname := rt.call_function('dirname', [var_filename_mutated.clone()])
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_mkdir_p', [
			var_dirname.clone(),
		])))))
		{
			return (create_wp_error(rt.new_string('image_save_error'), rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('Unable to create directory %s. Is its parent directory writable by the server?'),
				]),
				rt.call_function('esc_html', [
					var_dirname.clone(),
				]),
			]))).to_bool()
		}
		return (rt.call_method(var_image, 'writeImage', [var_filename_mutated.clone()])).to_bool()
		unsafe {
			goto end_label_13
		}
		catch_label_13:
		mut var_e_13 := rt.get_and_clear_exception()
		if rt.instance_of(var_e_13, 'Exception') {
			mut var_e := var_e_13.clone()
			return (create_wp_error(rt.new_string('image_save_error'), rt.call_method(var_e,
				'getMessage', []rt.PhpVal{}), var_filename_mutated.clone())).to_bool()
			unsafe {
				goto end_label_13
			}
		} else {
			rt.throw_exception(var_e_13)
			unsafe {
				goto end_label_13
			}
		}

		end_label_13:
	}
	return false
}

fn (mut this Class_WP_Image_Editor_Imagick) stream(var_mime_type rt.PhpVal) bool {
	mut var_filename := rt.new_null()
	mut var_extension := rt.new_null()
	mut list_tmp_3 := this.get_output_format(rt.new_null(), var_mime_type.clone())
	var_filename = list_tmp_3.array_get(0)
	var_extension = list_tmp_3.array_get(1)
	var_mime_type = list_tmp_3.array_get(2)
	rt.call_method(this.image, 'setImageFormat', [
		rt.new_string(var_extension.clone().to_string().to_upper()),
	])
	if rt.has_exception() {
		unsafe {
			goto catch_label_14
		}
	}
	rt.call_function('header', [
		rt.new_string('Content-Type: ${var_mime_type.to_string()}'),
	])
	if rt.has_exception() {
		unsafe {
			goto catch_label_14
		}
	}
	fn () {
		print((rt.call_method(this.image, 'getImageBlob', []rt.PhpVal{})).str())
		return i64(1)
	}()
	if rt.has_exception() {
		unsafe {
			goto catch_label_14
		}
	}
	rt.call_method(this.image, 'setImageFormat', [
		this.get_extension(rt.get_property(rt.new_object('WP_Image_Editor_Imagick', [
			'WP_Image_Editor',
		], &this), 'mime_type')),
	])
	if rt.has_exception() {
		unsafe {
			goto catch_label_14
		}
	}
	unsafe {
		goto end_label_14
	}
	catch_label_14:
	mut var_e_14 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_14, 'Exception') {
		mut var_e := var_e_14.clone()
		return (create_wp_error(rt.new_string('image_stream_error'), rt.call_method(var_e,
			'getMessage', []rt.PhpVal{}))).to_bool()
		unsafe {
			goto end_label_14
		}
	} else {
		rt.throw_exception(var_e_14)
		unsafe {
			goto end_label_14
		}
	}

	end_label_14:
	return true
}

fn (mut this Class_WP_Image_Editor_Imagick) strip_meta() bool {
	if !(rt.call_function('is_callable', [
		rt.create_array([rt.ArrayItem{ key: none, val: this.image },
			rt.ArrayItem{ key: none, val: 'getImageProfiles' }]),
	])) {
		return (create_wp_error(rt.new_string('image_strip_meta_error'), rt.call_function('sprintf', [
			rt.call_function('__', [rt.new_string('%s is required to strip image meta.')]),
			rt.new_string('<code>Imagick::getImageProfiles()</code>'),
		]))).to_bool()
	}
	if !(rt.call_function('is_callable', [
		rt.create_array([rt.ArrayItem{ key: none, val: this.image },
			rt.ArrayItem{ key: none, val: 'removeImageProfile' }]),
	])) {
		return (create_wp_error(rt.new_string('image_strip_meta_error'), rt.call_function('sprintf', [
			rt.call_function('__', [rt.new_string('%s is required to strip image meta.')]),
			rt.new_string('<code>Imagick::removeImageProfile()</code>'),
		]))).to_bool()
	}
	mut var_protected_profiles := ['icc', 'icm', 'iptc', 'exif', 'xmp']
	mut iter_2 := rt.call_method(this.image, 'getImageProfiles', [
		rt.new_string('*'), rt.new_bool(true)]).iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_value := item_2.val
		mut var_key := item_2.key
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
			var_key.clone(), rt.create_array_from_list(var_protected_profiles),
			rt.new_bool(true)])))))
		{
			rt.call_method(this.image, 'removeImageProfile', [
				var_key.clone()])
			if rt.has_exception() {
				unsafe {
					goto catch_label_15
				}
			}
		}
		if rt.has_exception() {
			unsafe {
				goto catch_label_15
			}
		}
	}
	if rt.has_exception() {
		unsafe {
			goto catch_label_15
		}
	}
	unsafe {
		goto end_label_15
	}
	catch_label_15:
	mut var_e_15 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_15, 'Exception') {
		mut var_e := var_e_15.clone()
		return (create_wp_error(rt.new_string('image_strip_meta_error'), rt.call_method(var_e,
			'getMessage', []rt.PhpVal{}))).to_bool()
		unsafe {
			goto end_label_15
		}
	} else {
		rt.throw_exception(var_e_15)
		unsafe {
			goto end_label_15
		}
	}

	end_label_15:
	return true
}

fn (mut this Class_WP_Image_Editor_Imagick) pdf_setup() string {
	rt.call_method(this.image, 'setResolution', [rt.new_int(128),
		rt.new_int(128)])
	if rt.has_exception() {
		unsafe {
			goto catch_label_16
		}
	}
	return
		(rt.get_property(rt.new_object('WP_Image_Editor_Imagick', ['WP_Image_Editor'], &this), 'file')).str() +
		'[0]'
	unsafe {
		goto end_label_16
	}
	catch_label_16:
	mut var_e_16 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_16, 'Exception') {
		mut var_e := var_e_16.clone()
		return (create_wp_error(rt.new_string('pdf_setup_failed'), rt.call_method(var_e,
			'getMessage', []rt.PhpVal{}), rt.get_property(rt.new_object('WP_Image_Editor_Imagick', [
			'WP_Image_Editor',
		], &this), 'file'))).str()
		unsafe {
			goto end_label_16
		}
	} else {
		rt.throw_exception(var_e_16)
		unsafe {
			goto end_label_16
		}
	}

	end_label_16:
	return ''
}

fn (mut this Class_WP_Image_Editor_Imagick) pdf_load_source() bool {
	mut var_filename := rt.new_string(this.pdf_setup())
	if rt.is_true(rt.call_function('is_wp_error', [var_filename.clone()])) {
		return var_filename.to_bool()
	}
	rt.call_method(this.image, 'setOption', [rt.new_string('pdf:use-cropbox'),
		rt.new_bool(true)])
	if rt.has_exception() {
		unsafe {
			goto catch_label_17
		}
	}
	rt.call_method(this.image, 'readImage', [var_filename.clone()])
	if rt.has_exception() {
		unsafe {
			goto catch_label_17
		}
	}
	unsafe {
		goto end_label_17
	}
	catch_label_17:
	mut var_e_17 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_17, 'Exception') {
		mut var_e := var_e_17.clone()
		rt.call_method(this.image, 'setOption', [rt.new_string('pdf:use-cropbox'),
			rt.new_bool(false)])
		rt.call_method(this.image, 'readImage', [var_filename.clone()])
		unsafe {
			goto end_label_17
		}
	} else {
		rt.throw_exception(var_e_17)
		unsafe {
			goto end_label_17
		}
	}

	end_label_17:
	return true
}

struct Class_WP_Image_Editor {
	rt.PhpObjectBase
}

struct Class_Imagick {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

struct Class_ImagickPixel {
	rt.PhpObjectBase
}

fn create_wp_image_editor_imagick(_args ...rt.PhpVal) &Class_WP_Image_Editor_Imagick {
	mut obj := &Class_WP_Image_Editor_Imagick{
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

fn create_imagick(_args ...rt.PhpVal) &Class_Imagick {
	mut obj := &Class_Imagick{
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

fn create_imagickpixel(_args ...rt.PhpVal) &Class_ImagickPixel {
	mut obj := &Class_ImagickPixel{
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
			return this.thumbnail_image(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2,
				dispatch_arg_3)
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
			return this.crop(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3,
				dispatch_arg_4, dispatch_arg_5, dispatch_arg_6)
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
			return this.remove_pdf_alpha_channel()
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
		else {
			return none
		}
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

fn (mut this Class_Imagick) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Imagick) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Imagick) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_ImagickPixel) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ImagickPixel) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ImagickPixel) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
