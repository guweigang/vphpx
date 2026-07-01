import rt

struct Class_WP_Image_Editor {
	rt.PhpObjectBase
pub mut:
		file rt.PhpVal = rt.new_null()
		size rt.PhpVal = rt.new_null()
		mime_type rt.PhpVal = rt.new_null()
		output_mime_type rt.PhpVal = rt.new_null()
		default_mime_type rt.PhpVal = rt.new_string('image/jpeg')
		quality rt.PhpVal = rt.new_bool(false)
		default_quality rt.PhpVal = rt.new_int(82)
}

fn (mut this Class_WP_Image_Editor) construct(var_file rt.PhpVal)  {
	this.file = var_file.dup()
}

fn Class_WP_Image_Editor.test(var_args rt.PhpVal) bool {
	return false
}

fn Class_WP_Image_Editor.supports_mime_type(var_mime_type rt.PhpVal) bool {
	mut var_mime_type_mutated := var_mime_type
	return false
}

fn (mut this Class_WP_Image_Editor) load()  {
}

fn (mut this Class_WP_Image_Editor) save(var_destfilename rt.PhpVal, var_mime_type rt.PhpVal)  {
	mut var_mime_type_mutated := var_mime_type
}

fn (mut this Class_WP_Image_Editor) resize(var_max_w rt.PhpVal, var_max_h rt.PhpVal, crop bool)  {
}

fn (mut this Class_WP_Image_Editor) multi_resize(var_sizes rt.PhpVal)  {
}

fn (mut this Class_WP_Image_Editor) crop(var_src_x rt.PhpVal, var_src_y rt.PhpVal, var_src_w rt.PhpVal, var_src_h rt.PhpVal, var_dst_w rt.PhpVal, var_dst_h rt.PhpVal, src_abs bool)  {
}

fn (mut this Class_WP_Image_Editor) rotate(var_angle rt.PhpVal)  {
}

fn (mut this Class_WP_Image_Editor) flip(var_horz rt.PhpVal, var_vert rt.PhpVal)  {
}

fn (mut this Class_WP_Image_Editor) stream(var_mime_type rt.PhpVal)  {
	mut var_mime_type_mutated := var_mime_type
}

fn (mut this Class_WP_Image_Editor) get_size() rt.PhpVal {
	return this.size
}

fn (mut this Class_WP_Image_Editor) update_size(var_width rt.PhpVal, var_height rt.PhpVal) bool {
	this.size = rt.create_array([rt.ArrayItem{ key: 'width', val: // unsupported expression: Expr_Cast_Int }, rt.ArrayItem{ key: 'height', val: // unsupported expression: Expr_Cast_Int }])
	return true
}

fn (mut this Class_WP_Image_Editor) get_quality() rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(this.quality)))) {
		this.set_quality(rt.new_null(), rt.new_null())
	}
	return this.quality
}

fn (mut this Class_WP_Image_Editor) set_quality(var_quality rt.PhpVal, var_dims rt.PhpVal) bool {
	mut var_quality_mutated := var_quality
	mut var_mime_type := if !(!rt.is_true(this.output_mime_type)) { this.output_mime_type } else { this.mime_type }
	mut var_default_quality := this.get_default_quality(var_mime_type.dup())
	if rt.is_true(rt.identical(rt.new_null(), var_quality_mutated)) {
		var_quality_mutated = rt.call_function('apply_filters', [rt.new_string('wp_editor_set_quality'), var_default_quality.dup(), var_mime_type.dup(), if rt.is_true(var_dims) { var_dims } else { this.size }])
		if rt.is_true(rt.identical(rt.new_string('image/jpeg'), var_mime_type)) {
			var_quality_mutated = rt.call_function('apply_filters', [rt.new_string('jpeg_quality'), var_quality_mutated.dup(), rt.new_string('image_resize')])
		}
		if rt.is_true(rt.new_bool(rt.is_true(rt.less(var_quality_mutated, rt.new_int(0))) || rt.is_true(rt.greater(var_quality_mutated, rt.new_int(100))))) {
			var_quality_mutated = var_default_quality.dup()
		}
	}
	if rt.is_true(rt.identical(rt.new_int(0), var_quality_mutated)) {
		var_quality_mutated = rt.new_int(rt.new_int(1))
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.greater_equal(var_quality_mutated, rt.new_int(1))) && rt.is_true(rt.less_equal(var_quality_mutated, rt.new_int(100))))) {
		this.quality = var_quality_mutated.dup()
		return true
	} else {
		return (create_wp_error(rt.new_string('invalid_image_quality'), rt.call_function('__', [rt.new_string('Attempted to set image quality outside of the range [1,100].')]))).to_bool()
	}
	return false
}

fn (mut this Class_WP_Image_Editor) get_default_quality(var_mime_type rt.PhpVal) rt.PhpVal {
	mut var_mime_type_mutated := var_mime_type
	mut switch_val_1 := var_mime_type_mutated
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('image/webp'))) {
		mut var_quality := rt.new_int(rt.new_int(86))
	} else {
		var_quality = this.default_quality
	}
	return var_quality.dup()
}

fn (mut this Class_WP_Image_Editor) get_output_format(var_filename rt.PhpVal, var_mime_type rt.PhpVal) rt.PhpVal {
	mut var_filename_mutated := var_filename
	mut var_mime_type_mutated := var_mime_type
	mut var_new_ext := rt.new_null()
	if rt.is_true(var_mime_type_mutated) {
		var_new_ext = rt.new_bool(this.get_extension(var_mime_type_mutated.dup()))
	}
	if rt.is_true(var_filename_mutated) {
		mut var_file_ext := rt.new_string(rt.new_string(rt.call_function('pathinfo', [var_filename_mutated.dup(), rt.get_constant('PATHINFO_EXTENSION')]).to_string().to_lower()))
		mut var_file_mime := rt.new_bool(this.get_mime_type(var_file_ext.dup()))
	} else {
		var_file_ext = rt.new_string(rt.new_string(rt.call_function('pathinfo', [this.file, rt.get_constant('PATHINFO_EXTENSION')]).to_string().to_lower()))
		var_file_mime = this.mime_type
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_mime_type_mutated)))) || rt.is_true(rt.identical(var_file_mime, var_mime_type_mutated)))) {
		var_mime_type_mutated = var_file_mime.dup()
		var_new_ext = var_file_ext.dup()
	}
	mut var_output_format := rt.call_function('wp_get_image_editor_output_format', [var_filename_mutated.dup(), var_mime_type_mutated.dup()])
	if var_output_format.array_isset(var_mime_type_mutated) && this.supports_mime_type(var_output_format.array_get(var_mime_type_mutated)) {
		var_mime_type_mutated = var_output_format.array_get(var_mime_type_mutated)
		var_new_ext = rt.new_bool(this.get_extension(var_mime_type_mutated.dup()))
	}
	if !(this.supports_mime_type(var_mime_type_mutated.dup())) {
		var_mime_type_mutated = rt.call_function('apply_filters', [rt.new_string('image_editor_default_mime_type'), this.default_mime_type])
		var_new_ext = rt.new_bool(this.get_extension(var_mime_type_mutated.dup()))
	}
	if rt.is_true(rt.new_bool(rt.is_true(var_filename_mutated) && rt.is_true(var_new_ext))) {
		mut var_dir := rt.call_function('pathinfo', [var_filename_mutated.dup(), rt.get_constant('PATHINFO_DIRNAME')])
		mut var_ext := rt.call_function('pathinfo', [var_filename_mutated.dup(), rt.get_constant('PATHINFO_EXTENSION')])
		var_filename_mutated = rt.new_string((rt.call_function('trailingslashit', [var_dir.dup()])).str() + (rt.call_function('wp_basename', [var_filename_mutated.dup(), rt.new_string(".${var_ext.to_string()}")])).str() + ".${var_new_ext.to_string()}")
	}
	if rt.is_true(rt.new_bool(rt.is_true(var_mime_type_mutated) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
			this.output_mime_type = var_mime_type_mutated.dup()
		}
		this.set_quality(rt.new_null(), rt.new_null())
	} else if !(!rt.is_true(this.output_mime_type)) {
		this.output_mime_type = rt.new_null()
		this.set_quality(rt.new_null(), rt.new_null())
	}
	return rt.create_array([rt.ArrayItem{ key: none, val: var_filename_mutated }, rt.ArrayItem{ key: none, val: var_new_ext }, rt.ArrayItem{ key: none, val: var_mime_type_mutated }])
}

fn (mut this Class_WP_Image_Editor) generate_filename(var_suffix rt.PhpVal, var_dest_path rt.PhpVal, var_extension rt.PhpVal) string {
	mut var_suffix_mutated := var_suffix
	if rt.is_true(var_suffix_mutated) {
		var_suffix_mutated = rt.new_string('-' + (var_suffix_mutated).str())
	} else if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		var_suffix_mutated = rt.new_string('-' + (this.get_suffix()).str())
	}
	mut var_dir := rt.call_function('pathinfo', [this.file, rt.get_constant('PATHINFO_DIRNAME')])
	mut var_ext := rt.call_function('pathinfo', [this.file, rt.get_constant('PATHINFO_EXTENSION')])
	mut var_name := rt.call_function('wp_basename', [this.file, rt.new_string(".${var_ext.to_string()}")])
	mut var_new_ext := rt.new_string(rt.new_string(if rt.is_true(var_extension) { var_extension } else { var_ext }.to_string().to_lower()))
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_dest_path.dup().is_null()))))) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_is_stream', [var_dest_path.dup()]))))) {
			mut var__dest_path := rt.call_function('realpath', [var_dest_path.dup()])
			if rt.is_true(var__dest_path) {
				var_dir = var__dest_path.dup()
			}
		} else {
			var_dir = var_dest_path
		}
	}
	return (rt.call_function('trailingslashit', [var_dir.dup()])).str() + "${var_name.to_string()}${var_suffix.to_string()}.${var_new_ext.to_string()}"
}

fn (mut this Class_WP_Image_Editor) get_suffix() rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(this.get_size())))) {
		return rt.new_bool(false)
	}
	return rt.new_string(rt.concat(rt.concat(this.size.array_get('width'), rt.new_string('x')), this.size.array_get('height')))
}

fn (mut this Class_WP_Image_Editor) maybe_exif_rotate() bool {
	mut var_orientation := rt.new_null()
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('is_callable', [rt.new_string('exif_read_data')])) && rt.is_true(rt.identical(rt.new_string('image/jpeg'), this.mime_type)))) {
		mut var_exif_data := rt.call_function('exif_read_data', [this.file])
		if !(!rt.is_true(var_exif_data.array_get('Orientation'))) {
			var_orientation = // unsupported expression: Expr_Cast_Int
		}
	}
	var_orientation = rt.call_function('apply_filters', [rt.new_string('wp_image_maybe_exif_rotate'), var_orientation.dup(), this.file])
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_orientation)))) || rt.is_true(rt.identical(rt.new_int(1), var_orientation)))) {
		return false
	}
	mut switch_val_2 := var_orientation
	if rt.is_true(rt.equal(switch_val_2, rt.new_int(2))) {
		mut var_result := this.flip(rt.new_bool(false), rt.new_bool(true))
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_int(3))) {
		var_result = this.flip(rt.new_bool(true), rt.new_bool(true))
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_int(4))) {
		var_result = this.flip(rt.new_bool(true), rt.new_bool(false))
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_int(5))) {
		var_result = this.rotate(rt.new_int(90))
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [var_result.dup()]))))) {
			var_result = this.flip(rt.new_bool(true), rt.new_bool(false))
		}
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_int(6))) {
		var_result = this.rotate(rt.new_int(270))
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_int(7))) {
		var_result = this.rotate(rt.new_int(90))
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [var_result.dup()]))))) {
			var_result = this.flip(rt.new_bool(false), rt.new_bool(true))
		}
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_int(8))) {
		var_result = this.rotate(rt.new_int(90))
	}
	return (var_result).to_bool()
}

fn (mut this Class_WP_Image_Editor) make_image(var_filename rt.PhpVal, var_callback rt.PhpVal, var_arguments rt.PhpVal) bool {
	mut var_filename_mutated := var_filename
	mut var_stream := rt.call_function('wp_is_stream', [var_filename_mutated.dup()])
	if rt.is_true(var_stream) {
		rt.call_function('ob_start', []rt.PhpVal{})
	} else {
		rt.call_function('wp_mkdir_p', [rt.call_function('dirname', [var_filename_mutated.dup()])])
	}
	mut var_result := rt.call_function('call_user_func_array', [var_callback.dup(), var_arguments.dup()])
	if rt.is_true(rt.new_bool(rt.is_true(var_result) && rt.is_true(var_stream))) {
		mut var_contents := rt.call_function('ob_get_contents', []rt.PhpVal{})
		mut var_fp := rt.call_function('fopen', [var_filename_mutated.dup(), rt.new_string('w')])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_fp)))) {
			rt.call_function('ob_end_clean', []rt.PhpVal{})
			return false
		}
		rt.call_function('fwrite', [var_fp.dup(), var_contents.dup()])
		rt.call_function('fclose', [var_fp.dup()])
	}
	if rt.is_true(var_stream) {
		rt.call_function('ob_end_clean', []rt.PhpVal{})
	}
	return (var_result).to_bool()
}

fn Class_WP_Image_Editor.get_mime_type(var_extension rt.PhpVal) bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(var_extension)))) {
		return false
	}
	mut var_mime_types := rt.call_function('wp_get_mime_types', []rt.PhpVal{})
	mut var_extensions := rt.func_array_keys(var_mime_types.dup())
	{
		mut iter_1 := var_extensions.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var__extension := item_1.val
			if rt.is_true(rt.call_function('preg_match', [rt.new_string("/${var_extension.to_string()}/i"), var__extension.dup()])) {
				return (var_mime_types.array_get(var__extension)).to_bool()
			}
		}
	}
	return false
}

fn Class_WP_Image_Editor.get_extension(var_mime_type rt.PhpVal) bool {
	mut var_mime_type_mutated := var_mime_type
	if !rt.is_true(var_mime_type_mutated) {
		return false
	}
	return (rt.call_function('wp_get_default_extension_for_mime_type', [var_mime_type_mutated.dup()])).to_bool()
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

fn create_wp_image_editor(arg_0 rt.PhpVal) &Class_WP_Image_Editor {
	mut obj := &Class_WP_Image_Editor{
		PhpObjectBase: rt.PhpObjectBase{}
		file: rt.new_null()
		size: rt.new_null()
		mime_type: rt.new_null()
		output_mime_type: rt.new_null()
		default_mime_type: rt.new_string('image/jpeg')
		quality: rt.new_bool(false)
		default_quality: rt.new_int(82)
	}
	obj.construct(arg_0)
	return obj
}

fn create_wp_error() &Class_WP_Error {
	mut obj := &Class_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Image_Editor) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'test' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(Class_WP_Image_Editor.test(dispatch_arg_0))
		}
		'supports_mime_type' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(Class_WP_Image_Editor.supports_mime_type(dispatch_arg_0))
		}
		'load' {
			this.load()
			return rt.new_null()
		}
		'save' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.save(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'resize' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
			this.resize(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'multi_resize' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.multi_resize(dispatch_arg_0)
			return rt.new_null()
		}
		'crop' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			dispatch_arg_4 := if args.len > 4 { args[4] } else { rt.new_null() }
			dispatch_arg_5 := if args.len > 5 { args[5] } else { rt.new_null() }
			dispatch_arg_6 := (if args.len > 6 { args[6] } else { rt.new_null() }).to_bool()
			this.crop(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3, dispatch_arg_4, dispatch_arg_5, dispatch_arg_6)
			return rt.new_null()
		}
		'rotate' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.rotate(dispatch_arg_0)
			return rt.new_null()
		}
		'flip' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.flip(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'stream' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.stream(dispatch_arg_0)
			return rt.new_null()
		}
		'get_size' {
			return this.get_size()
		}
		'update_size' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(this.update_size(dispatch_arg_0, dispatch_arg_1))
		}
		'get_quality' {
			return this.get_quality()
		}
		'set_quality' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(this.set_quality(dispatch_arg_0, dispatch_arg_1))
		}
		'get_default_quality' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_default_quality(dispatch_arg_0)
		}
		'get_output_format' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.get_output_format(dispatch_arg_0, dispatch_arg_1)
		}
		'generate_filename' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return rt.new_string(this.generate_filename(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2))
		}
		'get_suffix' {
			return this.get_suffix()
		}
		'maybe_exif_rotate' {
			return rt.new_bool(this.maybe_exif_rotate())
		}
		'make_image' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return rt.new_bool(this.make_image(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2))
		}
		'get_mime_type' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(Class_WP_Image_Editor.get_mime_type(dispatch_arg_0))
		}
		'get_extension' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(Class_WP_Image_Editor.get_extension(dispatch_arg_0))
		}
		else { return none }
	}
}

fn (this &Class_WP_Image_Editor) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'file' { return this.file }
		'size' { return this.size }
		'mime_type' { return this.mime_type }
		'output_mime_type' { return this.output_mime_type }
		'default_mime_type' { return this.default_mime_type }
		'quality' { return this.quality }
		'default_quality' { return this.default_quality }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_Image_Editor) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'file' { this.file = val; return true }
		'size' { this.size = val; return true }
		'mime_type' { this.mime_type = val; return true }
		'output_mime_type' { this.output_mime_type = val; return true }
		'default_mime_type' { this.default_mime_type = val; return true }
		'quality' { this.quality = val; return true }
		'default_quality' { this.default_quality = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
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




pub fn init_wp_includes_class_wp_image_editor_php() {
}
