import rt
import crypto.md5

struct Class_WC_Regenerate_Images {
	rt.PhpObjectBase
}

fn init_static_wc_regenerate_images() {
	rt.init_static_prop('WC_Regenerate_Images', 'background_process', rt.new_null())
	rt.init_static_prop('WC_Regenerate_Images', 'regenerate_size', rt.new_null())
}

fn Class_WC_Regenerate_Images.init() {
	rt.call_function('add_action', [rt.new_string('image_get_intermediate_size'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'filter_image_get_intermediate_size' }]),
		rt.new_int(10), rt.new_int(3)])
	rt.call_function('add_filter', [rt.new_string('wp_generate_attachment_metadata'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'add_uncropped_metadata' }])])
	rt.call_function('add_filter', [rt.new_string('wp_get_attachment_image_src'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'maybe_resize_image' }]),
		rt.new_int(10), rt.new_int(4)])
	mut iife_temp_0 := Class_Jetpack{}
	mut iife_result_0 := iife_temp_0.is_module_active(rt.new_string('photon'))
	if rt.is_true(rt.call_function('method_exists', [rt.new_string('Jetpack'), rt.new_string('is_module_active')]))
		&& rt.is_true(iife_result_0) {
		return
	}
	if rt.is_true(rt.call_function('apply_filters', [
		rt.new_string('woocommerce_background_image_regeneration'),
		rt.new_bool(true),
	]))
	{
		rt.include_file(
			(rt.get_constant('WC_ABSPATH')).str() + 'includes/class-wc-regenerate-images-request.php',
			'2')
		rt.set_static_prop('WC_Regenerate_Images', 'background_process', rt.new_object('WC_Regenerate_Images_Request',
			[]string{}, create_wc_regenerate_images_request()))
		rt.call_function('add_action', [rt.new_string('admin_init'),
			rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
				rt.ArrayItem{ key: none, val: 'regenerating_notice' }])])
		rt.call_function('add_action', [
			rt.new_string('woocommerce_hide_regenerating_thumbnails_notice'),
			rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
				rt.ArrayItem{ key: none, val: 'dismiss_regenerating_notice' }]),
		])
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{}))))) {
			rt.call_function('add_action', [rt.new_string('customize_save_after'),
				rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
					rt.ArrayItem{ key: none, val: 'maybe_regenerate_images' }])])
			rt.call_function('add_action', [rt.new_string('after_switch_theme'),
				rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
					rt.ArrayItem{ key: none, val: 'maybe_regenerate_images' }])])
		}
	}
}

fn Class_WC_Regenerate_Images.filter_image_get_intermediate_size(var_data rt.PhpVal, var_attachment_id rt.PhpVal, var_size rt.PhpVal) bool {
	if !(var_size.clone().is_string())
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_size.clone(), rt.call_function('apply_filters', [rt.new_string('woocommerce_image_sizes_to_resize'), rt.create_array([rt.ArrayItem{
		key: none
		val: 'woocommerce_thumbnail'
	}, rt.ArrayItem{ key: none, val: 'woocommerce_gallery_thumbnail' }, rt.ArrayItem{
		key: none
		val: 'woocommerce_single'
	}])]), rt.new_bool(true)]))))) {
		return var_data.to_bool()
	}
	if !(var_data.array_isset(rt.new_string('width'))
		&& var_data.array_isset(rt.new_string('height'))) {
		return var_data.to_bool()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(Class_WC_Regenerate_Images.image_size_matches_settings(var_data.clone(),
		var_size.clone())))))
	{
		mut iife_temp_1 := Class_Jetpack{}
		mut iife_result_1 := iife_temp_1.is_module_active(rt.new_string('photon'))
		if rt.is_true(rt.call_function('method_exists', [rt.new_string('Jetpack'), rt.new_string('is_module_active')]))
			&& rt.is_true(iife_result_1) {
			return false
		} else {
			mut var_size_data := rt.call_function('wc_get_image_size', [
				var_size.clone()])
			return (rt.call_function('image_get_intermediate_size', [
				var_attachment_id.clone(),
				rt.create_array([
					rt.ArrayItem{ key: none, val: rt.call_function('absint', [
						var_size_data.array_get(rt.new_string('width')),
					]) },
					rt.ArrayItem{ key: none, val: rt.call_function('absint', [
						var_size_data.array_get(rt.new_string('height')),
					]) },
				])])).to_bool()
		}
	}
	return var_data.to_bool()
}

fn Class_WC_Regenerate_Images.add_uncropped_metadata(var_meta_data rt.PhpVal) rt.PhpVal {
	mut var_size_data := rt.call_function('wc_get_image_size', [
		rt.new_string('woocommerce_thumbnail'),
	])
	if var_meta_data.array_isset(rt.new_string('sizes'))
		&& var_meta_data.array_get(rt.new_string('sizes')).array_isset(rt.new_string('woocommerce_thumbnail')) {
		var_meta_data.array_get_mut('sizes').array_get_mut('woocommerce_thumbnail').array_set('uncropped',
			rt.new_bool(!rt.is_true(var_size_data.array_get(rt.new_string('height')))))
	}
	return var_meta_data.clone()
}

fn Class_WC_Regenerate_Images.image_size_matches_settings(var_image rt.PhpVal, var_size rt.PhpVal) bool {
	mut var_target_size := rt.call_function('wc_get_image_size', [
		var_size.clone()])
	mut var_uncropped := rt.new_bool(
		rt.is_true(rt.identical(rt.new_string(''), var_target_size.array_get(rt.new_string('width'))))
		|| rt.is_true(rt.identical(rt.new_string(''), var_target_size.array_get(rt.new_string('height')))))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_uncropped)))) {
		mut var_ratio_match := rt.call_function('wp_image_matches_ratio', [
			var_image.array_get(rt.new_string('width')),
			var_image.array_get(rt.new_string('height')),
			var_target_size.array_get(rt.new_string('width')),
			var_target_size.array_get(rt.new_string('height')),
		])
		if rt.is_true(var_ratio_match)
			&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_target_size.array_get(rt.new_string('width')), var_image.array_get(rt.new_string('width')))))) {
			return false
		}
		if rt.is_true(var_ratio_match)
			&& rt.is_true(var_target_size.array_get(rt.new_string('height')))
			&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_target_size.array_get(rt.new_string('height')), var_image.array_get(rt.new_string('height')))))) {
			return false
		}
	}
	if rt.is_true(var_uncropped) && !rt.is_true(var_image.array_get(rt.new_string('uncropped'))) {
		return false
	}
	return true
}

fn Class_WC_Regenerate_Images.regenerating_notice() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(rt.get_static_prop('WC_Regenerate_Images',
		'background_process'), 'is_running', []rt.PhpVal{})))))
	{
		mut iife_temp_2 := Class_WC_Admin_Notices{}
		mut iife_result_2 := iife_temp_2.add_notice(rt.new_string('regenerating_thumbnails'))
	} else {
		mut iife_temp_3 := Class_WC_Admin_Notices{}
		mut iife_result_3 := iife_temp_3.remove_notice(rt.new_string('regenerating_thumbnails'))
	}
}

fn Class_WC_Regenerate_Images.dismiss_regenerating_notice() {
	if rt.is_true(rt.get_static_prop('WC_Regenerate_Images', 'background_process')) {
		rt.call_method(rt.get_static_prop('WC_Regenerate_Images', 'background_process'),
			'kill_process', []rt.PhpVal{})
		mut var_log := rt.call_function('wc_get_logger', []rt.PhpVal{})
		rt.call_method(var_log, 'info', [
			rt.call_function('__', [
				rt.new_string('Cancelled product image regeneration job.'),
				rt.new_string('woocommerce'),
			]),
			rt.create_array([
				rt.ArrayItem{ key: 'source', val: 'wc-image-regeneration' },
			]),
		])
	}
	mut iife_temp_4 := Class_WC_Admin_Notices{}
	mut iife_result_4 := iife_temp_4.remove_notice(rt.new_string('regenerating_thumbnails'))
}

fn Class_WC_Regenerate_Images.maybe_regenerate_images() {
	mut var_size_hash := rt.new_string(md5.hexhash(rt.call_function('wp_json_encode', [
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.call_function('wc_get_image_size', [
				rt.new_string('thumbnail'),
			]) },
			rt.ArrayItem{ key: none, val: rt.call_function('wc_get_image_size', [
				rt.new_string('single'),
			]) },
			rt.ArrayItem{ key: none, val: rt.call_function('wc_get_image_size', [
				rt.new_string('gallery_thumbnail'),
			]) },
		]),
	]).to_string()))
	if rt.is_true(rt.call_function('update_option', [
		rt.new_string('woocommerce_maybe_regenerate_images_hash'),
		var_size_hash.clone(),
	]))
	{
		Class_WC_Regenerate_Images.queue_image_regeneration()
	}
}

fn Class_WC_Regenerate_Images.maybe_resize_image(var_image rt.PhpVal, var_attachment_id rt.PhpVal, var_size rt.PhpVal, var_icon rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('apply_filters', [
		rt.new_string('woocommerce_resize_images'),
		rt.new_bool(true),
	])))))
	{
		return var_image.clone()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_image))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_size.clone(), rt.call_function('apply_filters', [rt.new_string('woocommerce_image_sizes_to_resize'), rt.create_array([rt.ArrayItem{
		key: none
		val: 'woocommerce_thumbnail'
	}, rt.ArrayItem{ key: none, val: 'woocommerce_gallery_thumbnail' }, rt.ArrayItem{
		key: none
		val: 'woocommerce_single'
	}])]), rt.new_bool(true)]))))) {
		return var_image.clone()
	}
	mut var_target_size := rt.call_function('wc_get_image_size', [
		var_size.clone()])
	mut var_image_width := var_image.array_get(rt.new_int(1))
	mut var_image_height := var_image.array_get(rt.new_int(2))
	mut var_ratio_match := rt.new_bool(false)
	mut var_target_uncropped := rt.new_bool(
		rt.is_true(rt.identical(rt.new_string(''), var_target_size.array_get(rt.new_string('width'))))
		|| rt.is_true(rt.identical(rt.new_string(''), var_target_size.array_get(rt.new_string('height'))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(var_target_size.array_get(rt.new_string('crop')))))))
	if rt.is_true(var_target_uncropped) {
		mut var_full_size :=
			Class_WC_Regenerate_Images.get_full_size_image_dimensions(var_attachment_id.clone())
		if rt.is_true(rt.new_bool(!(rt.is_true(var_full_size))))
			|| rt.is_true(rt.new_bool(!(rt.is_true(var_full_size.array_get(rt.new_string('width'))))))
			|| rt.is_true(rt.new_bool(!(rt.is_true(var_full_size.array_get(rt.new_string('height')))))) {
			return var_image.clone()
		}
		var_ratio_match = rt.call_function('wp_image_matches_ratio', [
			var_image_width.clone(), var_image_height.clone(),
			var_full_size.array_get(rt.new_string('width')), var_full_size.array_get(rt.new_string('height'))])
	} else {
		var_ratio_match = rt.call_function('wp_image_matches_ratio', [
			var_image_width.clone(), var_image_height.clone(),
			var_target_size.array_get(rt.new_string('width')),
			var_target_size.array_get(rt.new_string('height'))])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_ratio_match)))) {
		var_full_size =
			Class_WC_Regenerate_Images.get_full_size_image_dimensions(var_attachment_id.clone())
		if rt.is_true(rt.new_bool(!(rt.is_true(var_full_size)))) {
			return var_image.clone()
		}
		if rt.is_true(rt.identical(var_image_width, var_target_size.array_get(rt.new_string('width'))))
			&& rt.is_true(rt.less(var_full_size.array_get(rt.new_string('height')), var_target_size.array_get(rt.new_string('height')))) {
			return var_image.clone()
		}
		if rt.is_true(rt.identical(var_image_height, var_target_size.array_get(rt.new_string('height'))))
			&& rt.is_true(rt.less(var_full_size.array_get(rt.new_string('width')), var_target_size.array_get(rt.new_string('width')))) {
			return var_image.clone()
		}
		if rt.is_true(rt.less(var_full_size.array_get(rt.new_string('height')), var_target_size.array_get(rt.new_string('height'))))
			&& rt.is_true(rt.less(var_full_size.array_get(rt.new_string('width')), var_target_size.array_get(rt.new_string('width')))) {
			return var_image.clone()
		}
		return Class_WC_Regenerate_Images.resize_and_return_image(var_attachment_id.clone(),
			var_image.clone(), var_size.clone(), var_icon.clone())
	}
	return var_image.clone()
}

fn Class_WC_Regenerate_Images.get_full_size_image_dimensions(var_attachment_id rt.PhpVal) rt.PhpVal {
	mut var_imagedata := rt.call_function('wp_get_attachment_metadata', [
		var_attachment_id.clone()])
	if !(var_imagedata.clone().is_array()) {
		return rt.new_array()
	}
	if !(var_imagedata.array_isset(rt.new_string('file')))
		&& var_imagedata.array_get(rt.new_string('sizes')).array_isset(rt.new_string('full')) {
		var_imagedata.array_set('height',
			var_imagedata.array_get(rt.new_string('sizes')).array_get(rt.new_string('full')).array_get(rt.new_string('height')))
		var_imagedata.array_set('width',
			var_imagedata.array_get(rt.new_string('sizes')).array_get(rt.new_string('full')).array_get(rt.new_string('width')))
	}
	if !(var_imagedata.array_isset(rt.new_string('height')))
		|| !(var_imagedata.array_isset(rt.new_string('width'))) {
		return rt.new_array()
	}
	return rt.create_array([
		rt.ArrayItem{ key: 'width', val: var_imagedata.array_get(rt.new_string('width')) },
		rt.ArrayItem{ key: 'height', val: var_imagedata.array_get(rt.new_string('height')) },
	])
}

fn Class_WC_Regenerate_Images.is_regeneratable(var_attachment rt.PhpVal) bool {
	if rt.is_true(rt.identical(rt.new_string('site-icon'), rt.call_function('get_post_meta', [
		if var_attachment.clone().is_object() {
			rt.get_property(var_attachment, 'ID')
		} else {
			var_attachment
		},
		rt.new_string('_wp_attachment_context'),
		rt.new_bool(true),
	])))
	{
		return false
	}
	if rt.is_true(rt.call_function('wp_attachment_is_image', [
		var_attachment.clone()]))
	{
		return true
	}
	return false
}

fn Class_WC_Regenerate_Images.adjust_intermediate_image_sizes(var_sizes rt.PhpVal) rt.PhpVal {
	return rt.create_array([
		rt.ArrayItem{ key: none, val: rt.get_static_prop('WC_Regenerate_Images', 'regenerate_size') },
	])
}

fn Class_WC_Regenerate_Images.get_image(var_fullsizepath rt.PhpVal, var_thumbnail_width rt.PhpVal, var_thumbnail_height rt.PhpVal, var_crop rt.PhpVal) rt.PhpVal {
	mut var_fullsize_width := rt.new_null()
	mut var_fullsize_height := rt.new_null()
	mut var_dst_w := rt.new_null()
	mut var_dst_h := rt.new_null()
	mut var_fullsizepath_mutated := var_fullsizepath
	mut list_tmp_1 := rt.call_function('getimagesize', [var_fullsizepath_mutated.clone()])
	var_fullsize_width = list_tmp_1.array_get(0)
	var_fullsize_height = list_tmp_1.array_get(1)
	mut var_dimensions := rt.call_function('image_resize_dimensions', [
		var_fullsize_width.clone(), var_fullsize_height.clone(),
		var_thumbnail_width.clone(), var_thumbnail_height.clone(),
		var_crop.clone()])
	mut var_editor := rt.call_function('wp_get_image_editor', [
		var_fullsizepath_mutated.clone()])
	if rt.is_true(rt.call_function('is_wp_error', [var_editor.clone()])) {
		return rt.new_bool(false)
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_dimensions))))
		|| !(var_dimensions.clone().is_array()) {
		return rt.new_bool(false)
	}
	mut list_tmp_2 := var_dimensions
	var_dst_w = list_tmp_2.array_get(4)
	var_dst_h = list_tmp_2.array_get(5)
	mut var_suffix := rt.new_string('${var_dst_w.to_string()}x${var_dst_h.to_string()}')
	mut var_file_ext := rt.new_string(rt.call_function('pathinfo', [
		var_fullsizepath_mutated.clone(), rt.get_constant('PATHINFO_EXTENSION')]).to_string().to_lower())
	return rt.create_array([
		rt.ArrayItem{ key: 'filename', val: rt.call_method(var_editor, 'generate_filename', [
			var_suffix.clone(),
			rt.new_null(),
			var_file_ext.clone(),
		]) },
		rt.ArrayItem{ key: 'width', val: var_dst_w },
		rt.ArrayItem{ key: 'height', val: var_dst_h },
	])
}

fn Class_WC_Regenerate_Images.resize_and_return_image(var_attachment_id rt.PhpVal, var_image rt.PhpVal, var_size rt.PhpVal, var_icon rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(Class_WC_Regenerate_Images.is_regeneratable(var_attachment_id.clone()))))) {
		return var_image.clone()
	}
	mut var_fullsizepath := rt.call_function('get_attached_file', [
		var_attachment_id.clone()])
	if rt.is_true(rt.identical(rt.new_bool(false), var_fullsizepath))
		|| rt.is_true(rt.call_function('is_wp_error', [var_fullsizepath.clone()]))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('file_exists', [var_fullsizepath.clone()]))))) {
		return var_image.clone()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('wp_crop_image'),
	])))))
	{
		rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/image.php', '1')
	}
	rt.set_static_prop('WC_Regenerate_Images', 'regenerate_size', if rt.is_true(rt.call_function('is_customize_preview',
		[]rt.PhpVal{}))
	{
		var_size.str() + '_preview'
	} else {
		var_size
	})
	if rt.is_true(rt.call_function('is_customize_preview', []rt.PhpVal{})) {
		mut var_image_size := rt.call_function('wc_get_image_size', [
			var_size.clone()])
		rt.call_function('add_image_size', [
			rt.get_static_prop('WC_Regenerate_Images', 'regenerate_size'),
			rt.call_function('absint', [var_image_size.array_get(rt.new_string('width'))]),
			rt.call_function('absint', [var_image_size.array_get(rt.new_string('height'))]),
			var_image_size.array_get(rt.new_string('crop')),
		])
		mut var_thumbnail := Class_WC_Regenerate_Images.get_image(var_fullsizepath.clone(), rt.call_function('absint', [
			var_image_size.array_get(rt.new_string('width')),
		]), rt.call_function('absint', [var_image_size.array_get(rt.new_string('height'))]),
			var_image_size.array_get(rt.new_string('crop')))
		if rt.is_true(var_thumbnail)
			&& rt.is_true(rt.call_function('file_exists', [var_thumbnail.array_get(rt.new_string('filename'))])) {
			mut var_wp_uploads := rt.call_function('wp_upload_dir', [
				rt.new_null(), rt.new_bool(false)])
			mut var_wp_uploads_dir := var_wp_uploads.array_get(rt.new_string('basedir'))
			mut var_wp_uploads_url := var_wp_uploads.array_get(rt.new_string('baseurl'))
			return rt.create_array([
				rt.ArrayItem{ key: 0, val: rt.call_function('str_replace', [
					var_wp_uploads_dir.clone(), var_wp_uploads_url.clone(),
					var_thumbnail.array_get(rt.new_string('filename'))]) },
				rt.ArrayItem{ key: 1, val: var_thumbnail.array_get(rt.new_string('width')) },
				rt.ArrayItem{ key: 2, val: var_thumbnail.array_get(rt.new_string('height')) },
			])
		}
	}
	mut var_metadata := rt.call_function('wp_get_attachment_metadata', [
		var_attachment_id.clone()])
	if !(var_metadata.clone().is_array()) {
		var_metadata = rt.new_array()
	}
	rt.call_function('add_filter', [rt.new_string('intermediate_image_sizes'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'adjust_intermediate_image_sizes' }])])
	mut var_new_metadata := rt.call_function('wp_generate_attachment_metadata', [
		var_attachment_id.clone(),
		var_fullsizepath.clone(),
	])
	rt.call_function('remove_filter', [rt.new_string('intermediate_image_sizes'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'adjust_intermediate_image_sizes' }])])
	if rt.is_true(rt.call_function('is_wp_error', [var_new_metadata.clone()]))
		|| !rt.is_true(var_new_metadata) {
		return var_image.clone()
	}
	if var_new_metadata.array_get(rt.new_string('sizes')).array_isset(rt.get_static_prop('WC_Regenerate_Images',
		'regenerate_size'))
	{
		var_metadata.array_get_mut('sizes').array_set(rt.get_static_prop('WC_Regenerate_Images',
			'regenerate_size'), var_new_metadata.array_get(rt.new_string('sizes')).array_get(rt.get_static_prop('WC_Regenerate_Images',
			'regenerate_size')))
		rt.call_function('wp_update_attachment_metadata', [var_attachment_id.clone(),
			var_metadata.clone()])
	}
	mut var_new_image := Class_WC_Regenerate_Images.unfiltered_image_downsize(var_attachment_id.clone(), rt.get_static_prop('WC_Regenerate_Images',
		'regenerate_size'))
	return if rt.is_true(var_new_image) { var_new_image } else { var_image }
}

fn Class_WC_Regenerate_Images.unfiltered_image_downsize(var_attachment_id rt.PhpVal, var_size rt.PhpVal) rt.PhpVal {
	rt.call_function('remove_action', [rt.new_string('image_get_intermediate_size'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'filter_image_get_intermediate_size' }]),
		rt.new_int(10), rt.new_int(3)])
	mut var_return := rt.call_function('image_downsize', [var_attachment_id.clone(),
		var_size.clone()])
	rt.call_function('add_action', [rt.new_string('image_get_intermediate_size'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'filter_image_get_intermediate_size' }]),
		rt.new_int(10), rt.new_int(3)])
	return var_return.clone()
}

fn Class_WC_Regenerate_Images.queue_image_regeneration() {
	mut var_wpdb := rt.new_null()
	rt.call_method(rt.get_static_prop('WC_Regenerate_Images', 'background_process'),
		'kill_process', []rt.PhpVal{})
	mut var_images := rt.call_method(var_wpdb, 'get_results', [
		rt.concat(rt.concat(rt.new_string('SELECT ID\n\t\t\tFROM '), rt.get_property(var_wpdb,
			'posts')),
			rt.new_string("\n\t\t\tWHERE post_type = 'attachment'\n\t\t\tAND post_mime_type LIKE 'image/%'\n\t\t\tORDER BY ID DESC")),
	])
	mut iter_1 := var_images.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_image := item_1.val
		rt.call_method(rt.get_static_prop('WC_Regenerate_Images', 'background_process'),
			'push_to_queue', [
			rt.create_array([
				rt.ArrayItem{ key: 'attachment_id', val: rt.get_property(var_image, 'ID') },
			]),
		])
	}
	rt.call_method(rt.call_method(rt.get_static_prop('WC_Regenerate_Images', 'background_process'),
		'save', []rt.PhpVal{}), 'dispatch', []rt.PhpVal{})
}

struct Class_Jetpack {
	rt.PhpObjectBase
}

struct Class_WC_Regenerate_Images_Request {
	rt.PhpObjectBase
}

struct Class_WC_Admin_Notices {
	rt.PhpObjectBase
}

fn create_wc_regenerate_images(_args ...rt.PhpVal) &Class_WC_Regenerate_Images {
	mut obj := &Class_WC_Regenerate_Images{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_jetpack(_args ...rt.PhpVal) &Class_Jetpack {
	mut obj := &Class_Jetpack{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_regenerate_images_request(_args ...rt.PhpVal) &Class_WC_Regenerate_Images_Request {
	mut obj := &Class_WC_Regenerate_Images_Request{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_admin_notices(_args ...rt.PhpVal) &Class_WC_Admin_Notices {
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
			return rt.new_bool(Class_WC_Regenerate_Images.filter_image_get_intermediate_size(dispatch_arg_0,
				dispatch_arg_1, dispatch_arg_2))
		}
		'add_uncropped_metadata' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WC_Regenerate_Images.add_uncropped_metadata(dispatch_arg_0)
		}
		'image_size_matches_settings' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(Class_WC_Regenerate_Images.image_size_matches_settings(dispatch_arg_0,
				dispatch_arg_1))
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
			return Class_WC_Regenerate_Images.maybe_resize_image(dispatch_arg_0, dispatch_arg_1,
				dispatch_arg_2, dispatch_arg_3)
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
			return Class_WC_Regenerate_Images.get_image(dispatch_arg_0, dispatch_arg_1,
				dispatch_arg_2, dispatch_arg_3)
		}
		'resize_and_return_image' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			return Class_WC_Regenerate_Images.resize_and_return_image(dispatch_arg_0,
				dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
		}
		'unfiltered_image_downsize' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_WC_Regenerate_Images.unfiltered_image_downsize(dispatch_arg_0,
				dispatch_arg_1)
		}
		'queue_image_regeneration' {
			Class_WC_Regenerate_Images.queue_image_regeneration()
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_Regenerate_Images) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Regenerate_Images) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
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

fn (mut this Class_WC_Regenerate_Images_Request) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Regenerate_Images_Request) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Regenerate_Images_Request) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
	rt.call_function('add_action', [rt.new_string('init'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'WC_Regenerate_Images' },
			rt.ArrayItem{ key: none, val: 'init' }])])
}
