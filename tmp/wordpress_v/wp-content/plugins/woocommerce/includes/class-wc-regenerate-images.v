import rt
import crypto.md5

struct Class_WC_Regenerate_Images {
	rt.PhpObjectBase
pub mut:
		background_process rt.PhpVal = rt.new_null()
		regenerate_size rt.PhpVal = rt.new_null()
}

fn Class_WC_Regenerate_Images.init()  {
	rt.call_function('add_action', [rt.new_string('image_get_intermediate_size'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'filter_image_get_intermediate_size' }]), rt.new_int(10), rt.new_int(3)])
	rt.call_function('add_filter', [rt.new_string('wp_generate_attachment_metadata'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'add_uncropped_metadata' }])])
	rt.call_function('add_filter', [rt.new_string('wp_get_attachment_image_src'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'maybe_resize_image' }]), rt.new_int(10), rt.new_int(4)])
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('method_exists', [rt.new_string('Jetpack'), rt.new_string('is_module_active')])) && rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Jetpack{}; return temp.is_module_active(arg_0) }(rt.new_string('photon'))))) {
		return rt.new_null()
	}
	if rt.is_true(rt.call_function('apply_filters', [rt.new_string('woocommerce_background_image_regeneration'), rt.new_bool(true)])) {
		rt.include_file((rt.get_constant('WC_ABSPATH')).str() + 'includes/class-wc-regenerate-images-request.php', '2')
		// unsupported assign target: Expr_StaticPropertyFetch
		rt.call_function('add_action', [rt.new_string('admin_init'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'regenerating_notice' }])])
		rt.call_function('add_action', [rt.new_string('woocommerce_hide_regenerating_thumbnails_notice'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'dismiss_regenerating_notice' }])])
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{}))))) {
			rt.call_function('add_action', [rt.new_string('customize_save_after'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'maybe_regenerate_images' }])])
			rt.call_function('add_action', [rt.new_string('after_switch_theme'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'maybe_regenerate_images' }])])
		}
	}
}

fn Class_WC_Regenerate_Images.filter_image_get_intermediate_size(var_data rt.PhpVal, var_attachment_id rt.PhpVal, var_size rt.PhpVal) bool {
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_size.dup().is_string()))))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_size.dup(), rt.call_function('apply_filters', [rt.new_string('woocommerce_image_sizes_to_resize'), rt.create_array([rt.ArrayItem{ key: none, val: 'woocommerce_thumbnail' }, rt.ArrayItem{ key: none, val: 'woocommerce_gallery_thumbnail' }, rt.ArrayItem{ key: none, val: 'woocommerce_single' }])]), rt.new_bool(true)]))))))) {
		return (var_data).to_bool()
	}
	if !(var_data.array_isset(rt.new_string('width')) && var_data.array_isset(rt.new_string('height'))) {
		return (var_data).to_bool()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(Class_WC_Regenerate_Images.image_size_matches_settings(var_data.dup(), var_size.dup()))))) {
		if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('method_exists', [rt.new_string('Jetpack'), rt.new_string('is_module_active')])) && rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Jetpack{}; return temp.is_module_active(arg_0) }(rt.new_string('photon'))))) {
			return false
		} else {
			mut var_size_data := rt.call_function('wc_get_image_size', [var_size.dup()])
			return (rt.call_function('image_get_intermediate_size', [var_attachment_id.dup(), rt.create_array([rt.ArrayItem{ key: none, val: rt.call_function('absint', [var_size_data.array_get('width')]) }, rt.ArrayItem{ key: none, val: rt.call_function('absint', [var_size_data.array_get('height')]) }])])).to_bool()
		}
	}
	return (var_data).to_bool()
}

fn Class_WC_Regenerate_Images.add_uncropped_metadata(var_meta_data rt.PhpVal) rt.PhpVal {
	mut var_size_data := rt.call_function('wc_get_image_size', [rt.new_string('woocommerce_thumbnail')])
	if var_meta_data.array_isset(rt.new_string('sizes')) && var_meta_data.array_get('sizes').array_isset(rt.new_string('woocommerce_thumbnail')) {
		var_meta_data.array_get_mut('sizes').array_get_mut('woocommerce_thumbnail').array_set('uncropped', rt.new_bool(!rt.is_true(var_size_data.array_get('height'))))
	}
	return var_meta_data.dup()
}

fn Class_WC_Regenerate_Images.image_size_matches_settings(var_image rt.PhpVal, var_size rt.PhpVal) bool {
	mut var_target_size := rt.call_function('wc_get_image_size', [var_size.dup()])
	mut var_uncropped := rt.new_bool(rt.new_bool(rt.is_true(rt.identical(rt.new_string(''), var_target_size.array_get('width'))) || rt.is_true(rt.identical(rt.new_string(''), var_target_size.array_get('height')))))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_uncropped)))) {
		mut var_ratio_match := rt.call_function('wp_image_matches_ratio', [var_image.array_get('width'), var_image.array_get('height'), var_target_size.array_get('width'), var_target_size.array_get('height')])
		if rt.is_true(rt.new_bool(rt.is_true(var_ratio_match) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
			return false
		}
		if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(var_ratio_match) && rt.is_true(var_target_size.array_get('height')))) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
			return false
		}
	}
	if rt.is_true(rt.new_bool(rt.is_true(var_uncropped) && !rt.is_true(var_image.array_get('uncropped')))) {
		return false
	}
	return true
}

fn Class_WC_Regenerate_Images.regenerating_notice()  {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(// unsupported expression: Expr_StaticPropertyFetch, 'is_running', []rt.PhpVal{}))))) {
		fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Admin_Notices{}; return temp.add_notice(arg_0) }(rt.new_string('regenerating_thumbnails'))
	} else {
		fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Admin_Notices{}; return temp.remove_notice(arg_0) }(rt.new_string('regenerating_thumbnails'))
	}
}

fn Class_WC_Regenerate_Images.dismiss_regenerating_notice()  {
	if rt.is_true(// unsupported expression: Expr_StaticPropertyFetch) {
		rt.call_method(// unsupported expression: Expr_StaticPropertyFetch, 'kill_process', []rt.PhpVal{})
		mut var_log := rt.call_function('wc_get_logger', []rt.PhpVal{})
		rt.call_method(var_log, 'info', [rt.call_function('__', [rt.new_string('Cancelled product image regeneration job.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'source', val: 'wc-image-regeneration' }])])
	}
	fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Admin_Notices{}; return temp.remove_notice(arg_0) }(rt.new_string('regenerating_thumbnails'))
}

fn Class_WC_Regenerate_Images.maybe_regenerate_images()  {
	mut var_size_hash := rt.new_string(rt.new_string(md5.hexhash(rt.call_function('wp_json_encode', [rt.create_array([rt.ArrayItem{ key: none, val: rt.call_function('wc_get_image_size', [rt.new_string('thumbnail')]) }, rt.ArrayItem{ key: none, val: rt.call_function('wc_get_image_size', [rt.new_string('single')]) }, rt.ArrayItem{ key: none, val: rt.call_function('wc_get_image_size', [rt.new_string('gallery_thumbnail')]) }])]).to_string())))
	if rt.is_true(rt.call_function('update_option', [rt.new_string('woocommerce_maybe_regenerate_images_hash'), var_size_hash.dup()])) {
		Class_WC_Regenerate_Images.queue_image_regeneration()
	}
}

fn Class_WC_Regenerate_Images.maybe_resize_image(var_image rt.PhpVal, var_attachment_id rt.PhpVal, var_size rt.PhpVal, var_icon rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('apply_filters', [rt.new_string('woocommerce_resize_images'), rt.new_bool(true)]))))) {
		return var_image.dup()
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_image)))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_size.dup(), rt.call_function('apply_filters', [rt.new_string('woocommerce_image_sizes_to_resize'), rt.create_array([rt.ArrayItem{ key: none, val: 'woocommerce_thumbnail' }, rt.ArrayItem{ key: none, val: 'woocommerce_gallery_thumbnail' }, rt.ArrayItem{ key: none, val: 'woocommerce_single' }])]), rt.new_bool(true)]))))))) {
		return var_image.dup()
	}
	mut var_target_size := rt.call_function('wc_get_image_size', [var_size.dup()])
	mut var_image_width := var_image.array_get(1)
	mut var_image_height := var_image.array_get(2)
	mut var_ratio_match := rt.new_bool(rt.new_bool(false))
	mut var_target_uncropped := rt.new_bool(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string(''), var_target_size.array_get('width'))) || rt.is_true(rt.identical(rt.new_string(''), var_target_size.array_get('height'))))) || rt.is_true(rt.new_bool(!(rt.is_true(var_target_size.array_get('crop')))))))
	if rt.is_true(var_target_uncropped) {
		mut var_full_size := Class_WC_Regenerate_Images.get_full_size_image_dimensions(var_attachment_id.dup())
		if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_full_size)))) || rt.is_true(rt.new_bool(!(rt.is_true(var_full_size.array_get('width'))))))) || rt.is_true(rt.new_bool(!(rt.is_true(var_full_size.array_get('height'))))))) {
			return var_image.dup()
		}
		var_ratio_match = rt.call_function('wp_image_matches_ratio', [var_image_width.dup(), var_image_height.dup(), var_full_size.array_get('width'), var_full_size.array_get('height')])
	} else {
		var_ratio_match = rt.call_function('wp_image_matches_ratio', [var_image_width.dup(), var_image_height.dup(), var_target_size.array_get('width'), var_target_size.array_get('height')])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_ratio_match)))) {
		var_full_size = Class_WC_Regenerate_Images.get_full_size_image_dimensions(var_attachment_id.dup())
		if rt.is_true(rt.new_bool(!(rt.is_true(var_full_size)))) {
			return var_image.dup()
		}
		if rt.is_true(rt.new_bool(rt.is_true(rt.identical(var_image_width, var_target_size.array_get('width'))) && rt.is_true(rt.less(var_full_size.array_get('height'), var_target_size.array_get('height'))))) {
			return var_image.dup()
		}
		if rt.is_true(rt.new_bool(rt.is_true(rt.identical(var_image_height, var_target_size.array_get('height'))) && rt.is_true(rt.less(var_full_size.array_get('width'), var_target_size.array_get('width'))))) {
			return var_image.dup()
		}
		if rt.is_true(rt.new_bool(rt.is_true(rt.less(var_full_size.array_get('height'), var_target_size.array_get('height'))) && rt.is_true(rt.less(var_full_size.array_get('width'), var_target_size.array_get('width'))))) {
			return var_image.dup()
		}
		return Class_WC_Regenerate_Images.resize_and_return_image(var_attachment_id.dup(), var_image.dup(), var_size.dup(), var_icon.dup())
	}
	return var_image.dup()
}

fn Class_WC_Regenerate_Images.get_full_size_image_dimensions(var_attachment_id rt.PhpVal) rt.PhpVal {
	mut var_imagedata := rt.call_function('wp_get_attachment_metadata', [var_attachment_id.dup()])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_imagedata.dup().is_array()))))) {
		return rt.new_array()
	}
	if !(var_imagedata.array_isset(rt.new_string('file'))) && var_imagedata.array_get('sizes').array_isset(rt.new_string('full')) {
		var_imagedata.array_set('height', var_imagedata.array_get('sizes').array_get('full').array_get('height'))
		var_imagedata.array_set('width', var_imagedata.array_get('sizes').array_get('full').array_get('width'))
	}
	if !(var_imagedata.array_isset(rt.new_string('height'))) || !(var_imagedata.array_isset(rt.new_string('width'))) {
		return rt.new_array()
	}
	return rt.create_array([rt.ArrayItem{ key: 'width', val: var_imagedata.array_get('width') }, rt.ArrayItem{ key: 'height', val: var_imagedata.array_get('height') }])
}

fn Class_WC_Regenerate_Images.is_regeneratable(var_attachment rt.PhpVal) bool {
	if rt.is_true(rt.identical(rt.new_string('site-icon'), rt.call_function('get_post_meta', [if rt.is_true(rt.new_bool(var_attachment.dup().is_object())) { rt.get_property(var_attachment, 'ID') } else { var_attachment }, rt.new_string('_wp_attachment_context'), rt.new_bool(true)]))) {
		return false
	}
	if rt.is_true(rt.call_function('wp_attachment_is_image', [var_attachment.dup()])) {
		return true
	}
	return false
}

fn Class_WC_Regenerate_Images.adjust_intermediate_image_sizes(var_sizes rt.PhpVal) rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: none, val: // unsupported expression: Expr_StaticPropertyFetch }])
}

fn Class_WC_Regenerate_Images.get_image(var_fullsizepath rt.PhpVal, var_thumbnail_width rt.PhpVal, var_thumbnail_height rt.PhpVal, var_crop rt.PhpVal) rt.PhpVal {
	mut var_fullsize_width := rt.new_null()
	mut var_fullsize_height := rt.new_null()
	mut var_dst_w := rt.new_null()
	mut var_dst_h := rt.new_null()
	mut var_fullsizepath_mutated := var_fullsizepath
	// unsupported assign target: Expr_List
	mut var_dimensions := rt.call_function('image_resize_dimensions', [var_fullsize_width.dup(), var_fullsize_height.dup(), var_thumbnail_width.dup(), var_thumbnail_height.dup(), var_crop.dup()])
	mut var_editor := rt.call_function('wp_get_image_editor', [var_fullsizepath_mutated.dup()])
	if rt.is_true(rt.call_function('is_wp_error', [var_editor.dup()])) {
		return rt.new_bool(false)
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_dimensions)))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_dimensions.dup().is_array()))))))) {
		return rt.new_bool(false)
	}
	// unsupported assign target: Expr_List
	mut var_suffix := rt.new_string(rt.new_string("${var_dst_w.to_string()}x${var_dst_h.to_string()}"))
	mut var_file_ext := rt.new_string(rt.new_string(rt.call_function('pathinfo', [var_fullsizepath_mutated.dup(), rt.get_constant('PATHINFO_EXTENSION')]).to_string().to_lower()))
	return rt.create_array([rt.ArrayItem{ key: 'filename', val: rt.call_method(var_editor, 'generate_filename', [var_suffix.dup(), rt.new_null(), var_file_ext.dup()]) }, rt.ArrayItem{ key: 'width', val: var_dst_w }, rt.ArrayItem{ key: 'height', val: var_dst_h }])
}

fn Class_WC_Regenerate_Images.resize_and_return_image(var_attachment_id rt.PhpVal, var_image rt.PhpVal, var_size rt.PhpVal, var_icon rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(Class_WC_Regenerate_Images.is_regeneratable(var_attachment_id.dup()))))) {
		return var_image.dup()
	}
	mut var_fullsizepath := rt.call_function('get_attached_file', [var_attachment_id.dup()])
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_bool(false), var_fullsizepath)) || rt.is_true(rt.call_function('is_wp_error', [var_fullsizepath.dup()])))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('file_exists', [var_fullsizepath.dup()]))))))) {
		return var_image.dup()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('wp_crop_image')]))))) {
		rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/image.php', '1')
	}
	// unsupported assign target: Expr_StaticPropertyFetch
	if rt.is_true(rt.call_function('is_customize_preview', []rt.PhpVal{})) {
		mut var_image_size := rt.call_function('wc_get_image_size', [var_size.dup()])
		rt.call_function('add_image_size', [// unsupported expression: Expr_StaticPropertyFetch, rt.call_function('absint', [var_image_size.array_get('width')]), rt.call_function('absint', [var_image_size.array_get('height')]), var_image_size.array_get('crop')])
		mut var_thumbnail := Class_WC_Regenerate_Images.get_image(var_fullsizepath.dup(), rt.call_function('absint', [var_image_size.array_get('width')]), rt.call_function('absint', [var_image_size.array_get('height')]), var_image_size.array_get('crop'))
		if rt.is_true(rt.new_bool(rt.is_true(var_thumbnail) && rt.is_true(rt.call_function('file_exists', [var_thumbnail.array_get('filename')])))) {
			mut var_wp_uploads := rt.call_function('wp_upload_dir', [rt.new_null(), rt.new_bool(false)])
			mut var_wp_uploads_dir := var_wp_uploads.array_get('basedir')
			mut var_wp_uploads_url := var_wp_uploads.array_get('baseurl')
			return rt.create_array([rt.ArrayItem{ key: 0, val: rt.call_function('str_replace', [var_wp_uploads_dir.dup(), var_wp_uploads_url.dup(), var_thumbnail.array_get('filename')]) }, rt.ArrayItem{ key: 1, val: var_thumbnail.array_get('width') }, rt.ArrayItem{ key: 2, val: var_thumbnail.array_get('height') }])
		}
	}
	mut var_metadata := rt.call_function('wp_get_attachment_metadata', [var_attachment_id.dup()])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_metadata.dup().is_array()))))) {
		var_metadata = rt.new_array()
	}
	rt.call_function('add_filter', [rt.new_string('intermediate_image_sizes'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'adjust_intermediate_image_sizes' }])])
	mut var_new_metadata := rt.call_function('wp_generate_attachment_metadata', [var_attachment_id.dup(), var_fullsizepath.dup()])
	rt.call_function('remove_filter', [rt.new_string('intermediate_image_sizes'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'adjust_intermediate_image_sizes' }])])
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('is_wp_error', [var_new_metadata.dup()])) || !rt.is_true(var_new_metadata))) {
		return var_image.dup()
	}
	if var_new_metadata.array_get('sizes').array_isset(// unsupported expression: Expr_StaticPropertyFetch) {
		var_metadata.array_get_mut('sizes').array_set(// unsupported expression: Expr_StaticPropertyFetch, var_new_metadata.array_get('sizes').array_get(// unsupported expression: Expr_StaticPropertyFetch))
		rt.call_function('wp_update_attachment_metadata', [var_attachment_id.dup(), var_metadata.dup()])
	}
	mut var_new_image := Class_WC_Regenerate_Images.unfiltered_image_downsize(var_attachment_id.dup(), // unsupported expression: Expr_StaticPropertyFetch)
	return if rt.is_true(var_new_image) { var_new_image } else { var_image }
}

fn Class_WC_Regenerate_Images.unfiltered_image_downsize(var_attachment_id rt.PhpVal, var_size rt.PhpVal) rt.PhpVal {
	rt.call_function('remove_action', [rt.new_string('image_get_intermediate_size'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'filter_image_get_intermediate_size' }]), rt.new_int(10), rt.new_int(3)])
	mut var_return := rt.call_function('image_downsize', [var_attachment_id.dup(), var_size.dup()])
	rt.call_function('add_action', [rt.new_string('image_get_intermediate_size'), rt.create_array([rt.ArrayItem{ key: none, val:  }, rt.ArrayItem{ key: none, val:  }]), rt.new_int(10), rt.new_int(3)])
	return var_return.dup()
}

fn Class_WC_Regenerate_Images.queue_image_regeneration()  {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
}

struct Class_Jetpack {
	rt.PhpObjectBase
}

struct Class_WC_Admin_Notices {
	rt.PhpObjectBase
}

fn create_wc_regenerate_images() &Class_WC_Regenerate_Images {
	mut obj := &Class_WC_Regenerate_Images{
		PhpObjectBase: rt.PhpObjectBase{}
		background_process: rt.new_null()
		regenerate_size: rt.new_null()
	}
	return obj
}

fn create_jetpack() &Class_Jetpack {
	mut obj := &Class_Jetpack{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_admin_notices() &Class_WC_Admin_Notices {
	mut obj := &Class_WC_Admin_Notices{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Regenerate_Images) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'init' {
			Class_WC_Regenerate_Images.init()
			return rt.new_null()
		}
		'filter_image_get_intermediate_size' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return rt.new_bool(Class_WC_Regenerate_Images.filter_image_get_intermediate_size(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2))
		}
		'add_uncropped_metadata' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WC_Regenerate_Images.add_uncropped_metadata(dispatch_arg_0)
		}
		'image_size_matches_settings' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(Class_WC_Regenerate_Images.image_size_matches_settings(dispatch_arg_0, dispatch_arg_1))
		}
		'regenerating_notice' {
			Class_WC_Regenerate_Images.regenerating_notice()
			return rt.new_null()
		}
		'dismiss_regenerating_notice' {
			Class_WC_Regenerate_Images.dismiss_regenerating_notice()
			return rt.new_null()
		}
		'maybe_regenerate_images' {
			Class_WC_Regenerate_Images.maybe_regenerate_images()
			return rt.new_null()
		}
		'maybe_resize_image' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			return Class_WC_Regenerate_Images.maybe_resize_image(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
		}
		'get_full_size_image_dimensions' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WC_Regenerate_Images.get_full_size_image_dimensions(dispatch_arg_0)
		}
		'is_regeneratable' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(Class_WC_Regenerate_Images.is_regeneratable(dispatch_arg_0))
		}
		'adjust_intermediate_image_sizes' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WC_Regenerate_Images.adjust_intermediate_image_sizes(dispatch_arg_0)
		}
		'get_image' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			return Class_WC_Regenerate_Images.get_image(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
		}
		'resize_and_return_image' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			return Class_WC_Regenerate_Images.resize_and_return_image(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
		}
		'unfiltered_image_downsize' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_WC_Regenerate_Images.unfiltered_image_downsize(dispatch_arg_0, dispatch_arg_1)
		}
		'queue_image_regeneration' {
			Class_WC_Regenerate_Images.queue_image_regeneration()
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_WC_Regenerate_Images) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'background_process' { return this.background_process }
		'regenerate_size' { return this.regenerate_size }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_Regenerate_Images) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'background_process' { this.background_process = val; return true }
		'regenerate_size' { this.regenerate_size = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Jetpack) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Jetpack) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Jetpack) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_Admin_Notices) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Admin_Notices) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Admin_Notices) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_includes_class_wc_regenerate_images_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
