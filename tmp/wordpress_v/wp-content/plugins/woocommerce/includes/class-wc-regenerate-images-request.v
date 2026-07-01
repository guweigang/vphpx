import rt

struct Class_WC_Regenerate_Images_Request {
	rt.PhpObjectBase
pub mut:
		attachment_id rt.PhpVal = rt.new_int(0)
}

fn (mut this Class_WC_Regenerate_Images_Request) construct()  {
	this.dispatch_set_prop('prefix', 'wp_' + (rt.call_function('get_current_blog_id', []rt.PhpVal{})).str())
	this.dispatch_set_prop('action', rt.new_string('wc_regenerate_images'))
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('extension_loaded', [rt.new_string('imagick')])) && rt.is_true(rt.call_function('method_exists', [Class_Imagick.class(), rt.new_string('setResourceLimit')])))) {
		if rt.is_true(rt.call_function('defined', [rt.new_string('Imagick::RESOURCETYPE_THREAD')])) {
			fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Imagick{}; return temp.setresourcelimit(arg_0, arg_1) }(Class_Imagick.resourcetype_thread(), rt.new_int(1))
		} else {
			fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Imagick{}; return temp.setresourcelimit(arg_0, arg_1) }(rt.new_int(6), rt.new_int(1))
		}
	}
	this.Class_WC_Background_Process.construct()
}

fn (mut this Class_WC_Regenerate_Images_Request) is_running() rt.PhpVal {
	return this.is_queue_empty()
}

fn (mut this Class_WC_Regenerate_Images_Request) batch_limit_exceeded() bool {
	return true
}

fn (mut this Class_WC_Regenerate_Images_Request) is_regeneratable(var_attachment rt.PhpVal) bool {
	mut var_attachment_mutated := var_attachment
	if rt.is_true(rt.identical(rt.new_string('site-icon'), rt.call_function('get_post_meta', [rt.get_property(var_attachment_mutated, 'ID'), rt.new_string('_wp_attachment_context'), rt.new_bool(true)]))) {
		return false
	}
	if rt.is_true(rt.call_function('wp_attachment_is_image', [var_attachment_mutated.dup()])) {
		return true
	}
	return false
}

fn (mut this Class_WC_Regenerate_Images_Request) task(var_item rt.PhpVal) bool {
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_item.dup().is_array()))))) && !(var_item.array_isset(rt.new_string('attachment_id'))))) {
		return false
	}
	this.attachment_id = rt.call_function('absint', [var_item.array_get('attachment_id')])
	mut var_attachment := rt.call_function('get_post', [this.attachment_id])
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_attachment)))) || rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) || !(this.is_regeneratable(var_attachment.dup())))) {
		return false
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('wp_crop_image')]))))) {
		rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/image.php', '1')
	}
	mut var_log := rt.call_function('wc_get_logger', []rt.PhpVal{})
	rt.call_method(var_log, 'info', [rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Regenerating images for attachment ID: %s'), rt.new_string('woocommerce')]), this.attachment_id]), rt.create_array([rt.ArrayItem{ key: 'source', val: 'wc-image-regeneration' }])])
	mut var_fullsizepath := rt.call_function('get_attached_file', [this.attachment_id])
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_bool(false), var_fullsizepath)) || rt.is_true(rt.call_function('is_wp_error', [var_fullsizepath.dup()])))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('file_exists', [var_fullsizepath.dup()]))))))) {
		return false
	}
	mut var_old_metadata := rt.call_function('wp_get_attachment_metadata', [this.attachment_id])
	rt.call_function('add_filter', [rt.new_string('intermediate_image_sizes'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Regenerate_Images_Request', ['WC_Background_Process'], &this) }, rt.ArrayItem{ key: none, val: 'adjust_intermediate_image_sizes' }])])
	rt.call_function('add_filter', [rt.new_string('intermediate_image_sizes_advanced'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Regenerate_Images_Request', ['WC_Background_Process'], &this) }, rt.ArrayItem{ key: none, val: 'filter_image_sizes_to_only_missing_thumbnails' }]), rt.new_int(10), rt.new_int(3)])
	mut var_new_metadata := rt.call_function('wp_generate_attachment_metadata', [this.attachment_id, var_fullsizepath.dup()])
	rt.call_function('remove_filter', [rt.new_string('intermediate_image_sizes'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Regenerate_Images_Request', ['WC_Background_Process'], &this) }, rt.ArrayItem{ key: none, val: 'adjust_intermediate_image_sizes' }])])
	rt.call_function('remove_filter', [rt.new_string('intermediate_image_sizes_advanced'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Regenerate_Images_Request', ['WC_Background_Process'], &this) }, rt.ArrayItem{ key: none, val: 'filter_image_sizes_to_only_missing_thumbnails' }]), rt.new_int(10), rt.new_int(3)])
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('is_wp_error', [var_new_metadata.dup()])) || !rt.is_true(var_new_metadata))) {
		return false
	}
	if rt.is_true(rt.new_bool(!(!rt.is_true(var_old_metadata)) && !(!rt.is_true(var_old_metadata.array_get('sizes'))) && rt.is_true(rt.new_bool(var_old_metadata.array_get('sizes').is_array())))) {
		{
			mut iter_1 := var_old_metadata.array_get('sizes').iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_old_size_data := item_1.val
				mut var_old_size := item_1.key
				if !rt.is_true(var_new_metadata.array_get('sizes').array_get(var_old_size)) {
					var_new_metadata.array_get_mut('sizes').array_set(var_old_size, var_old_metadata.array_get('sizes').array_get(var_old_size))
				}
			}
		}
	}
	rt.call_function('wp_update_attachment_metadata', [this.attachment_id, var_new_metadata.dup()])
	return false
}

fn (mut this Class_WC_Regenerate_Images_Request) filter_image_sizes_to_only_missing_thumbnails(var_sizes rt.PhpVal, var_metadata rt.PhpVal, var_attachment_id rt.PhpVal) rt.PhpVal {
	mut var_orig_w := rt.new_null()
	mut var_orig_h := rt.new_null()
	mut var_metadata_mutated := var_metadata
	mut var_attachment_id_mutated := var_attachment_id
	var_attachment_id_mutated = if rt.is_true(rt.new_bool(var_attachment_id_mutated.dup().is_null())) { this.attachment_id } else { var_attachment_id_mutated }
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_sizes)))) || rt.is_true(rt.new_bool(!(rt.is_true(var_attachment_id_mutated)))))) {
		return var_sizes.dup()
	}
	mut var_fullsizepath := rt.call_function('get_attached_file', [var_attachment_id_mutated.dup()])
	mut var_editor := rt.call_function('wp_get_image_editor', [var_fullsizepath.dup()])
	if rt.is_true(rt.call_function('is_wp_error', [var_editor.dup()])) {
		return var_sizes.dup()
	}
	var_metadata_mutated = rt.call_function('wp_get_attachment_metadata', [var_attachment_id_mutated.dup()])
	{
		mut iter_1 := var_sizes.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_size_data := item_1.val
			mut var_size := item_1.key
			if !rt.is_true(var_metadata_mutated.array_get('sizes').array_get(var_size)) {
				continue
			}
			if !(var_size_data.array_isset(rt.new_string('width'))) && !(var_size_data.array_isset(rt.new_string('height'))) {
				continue
			}
			if !(var_size_data.array_isset(rt.new_string('width'))) {
				var_size_data.array_set('width', rt.new_null())
			}
			if !(var_size_data.array_isset(rt.new_string('height'))) {
				var_size_data.array_set('height', rt.new_null())
			}
			if !(var_size_data.array_isset(rt.new_string('crop'))) {
				var_size_data.array_set('crop', false)
			}
			mut var_image_sizes := rt.call_function('getimagesize', [var_fullsizepath.dup()])
			if rt.is_true(rt.identical(rt.new_bool(false), var_image_sizes)) {
				continue
			}
			// unsupported assign target: Expr_List
			mut var_dimensions := rt.call_function('image_resize_dimensions', [var_orig_w.dup(), var_orig_h.dup(), var_size_data.array_get('width'), var_size_data.array_get('height'), var_size_data.array_get('crop')])
			if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_dimensions)))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_dimensions.dup().is_array()))))))) {
				continue
			}
			mut var_info := rt.call_function('pathinfo', [var_fullsizepath.dup()])
			mut var_ext := var_info.array_get('extension')
			mut var_dst_w := var_dimensions.array_get(4)
			mut var_dst_h := var_dimensions.array_get(5)
			mut var_suffix := rt.new_string(rt.new_string("${var_dst_w.to_string()}x${var_dst_h.to_string()}"))
			mut var_dst_rel_path := rt.call_function('str_replace', ['.' + (var_ext).str(), rt.new_string(''), var_fullsizepath.dup()])
			mut var_thumbnail := rt.new_string(rt.new_string("${var_dst_rel_path.to_string()}-${var_suffix.to_string()}.${var_ext.to_string()}"))
			if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.identical(var_dst_w, var_metadata_mutated.array_get('sizes').array_get(var_size).array_get('width'))) && rt.is_true(rt.identical(var_dst_h, var_metadata_mutated.array_get('sizes').array_get(var_size).array_get('height'))))) && rt.is_true(rt.call_function('file_exists', [var_thumbnail.dup()])))) {
				var_sizes.array_unset(var_size)
			}
		}
	}
	return var_sizes.dup()
}

fn (mut this Class_WC_Regenerate_Images_Request) adjust_intermediate_image_sizes(var_sizes rt.PhpVal) rt.PhpVal {
	mut var_unfiltered_sizes := ['woocommerce_thumbnail', 'woocommerce_gallery_thumbnail', 'woocommerce_single']
	// unsupported statement: Stmt_Static
	if rt.is_true(var_in_filter) {
		return var_unfiltered_sizes.dup()
	}
	mut var_in_filter := rt.new_bool(rt.new_bool(true))
	mut var_filtered_sizes := rt.call_function('apply_filters', [rt.new_string('woocommerce_regenerate_images_intermediate_image_sizes'), var_unfiltered_sizes.dup()])
	var_in_filter = rt.new_bool(rt.new_bool(false))
	return var_filtered_sizes.dup()
}

fn (mut this Class_WC_Regenerate_Images_Request) complete()  {
	this.Class_WC_Background_Process.complete()
	mut var_log := rt.call_function('wc_get_logger', []rt.PhpVal{})
	rt.call_method(var_log, 'info', [rt.call_function('__', [rt.new_string('Completed product image regeneration job.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'source', val: 'wc-image-regeneration' }])])
}

struct Class_WC_Background_Process {
	rt.PhpObjectBase
}

struct Class_Imagick {
	rt.PhpObjectBase
}

fn create_wc_regenerate_images_request() &Class_WC_Regenerate_Images_Request {
	mut obj := &Class_WC_Regenerate_Images_Request{
		PhpObjectBase: rt.PhpObjectBase{}
		attachment_id: rt.new_int(0)
	}
	obj.construct()
	return obj
}

fn create_wc_background_process() &Class_WC_Background_Process {
	mut obj := &Class_WC_Background_Process{
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

fn (mut this Class_WC_Regenerate_Images_Request) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'is_running' {
			return this.is_running()
		}
		'batch_limit_exceeded' {
			return rt.new_bool(this.batch_limit_exceeded())
		}
		'is_regeneratable' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.is_regeneratable(dispatch_arg_0))
		}
		'task' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.task(dispatch_arg_0))
		}
		'filter_image_sizes_to_only_missing_thumbnails' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.filter_image_sizes_to_only_missing_thumbnails(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'adjust_intermediate_image_sizes' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.adjust_intermediate_image_sizes(dispatch_arg_0)
		}
		'complete' {
			this.complete()
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_WC_Regenerate_Images_Request) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'attachment_id' { return this.attachment_id }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_Regenerate_Images_Request) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'attachment_id' { this.attachment_id = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_WC_Background_Process) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Background_Process) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Background_Process) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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




pub fn init_wp_content_plugins_woocommerce_includes_class_wc_regenerate_images_request_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [rt.new_string('WC_Background_Process'), rt.new_bool(false)]))))) {
		rt.include_file((rt.call_function('dirname', [rt.new_string(@FILE)])).str() + '/abstracts/class-wc-background-process.php', '2')
	}
}
