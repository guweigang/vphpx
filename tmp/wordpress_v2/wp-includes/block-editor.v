import rt

fn get_default_block_categories() rt.PhpVal {
	return rt.create_array([
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'slug', val: 'text' },
			rt.ArrayItem{ key: 'title', val: rt.call_function('_x', [
				rt.new_string('Text'),
				rt.new_string('block category'),
			]) },
			rt.ArrayItem{ key: 'icon', val: rt.new_null() },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'slug', val: 'media' },
			rt.ArrayItem{ key: 'title', val: rt.call_function('_x', [
				rt.new_string('Media'),
				rt.new_string('block category'),
			]) },
			rt.ArrayItem{ key: 'icon', val: rt.new_null() },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'slug', val: 'design' },
			rt.ArrayItem{ key: 'title', val: rt.call_function('_x', [
				rt.new_string('Design'),
				rt.new_string('block category'),
			]) },
			rt.ArrayItem{ key: 'icon', val: rt.new_null() },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'slug', val: 'widgets' },
			rt.ArrayItem{ key: 'title', val: rt.call_function('_x', [
				rt.new_string('Widgets'),
				rt.new_string('block category'),
			]) },
			rt.ArrayItem{ key: 'icon', val: rt.new_null() },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'slug', val: 'theme' },
			rt.ArrayItem{ key: 'title', val: rt.call_function('_x', [
				rt.new_string('Theme'),
				rt.new_string('block category'),
			]) },
			rt.ArrayItem{ key: 'icon', val: rt.new_null() },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'slug', val: 'embed' },
			rt.ArrayItem{ key: 'title', val: rt.call_function('_x', [
				rt.new_string('Embeds'),
				rt.new_string('block category'),
			]) },
			rt.ArrayItem{ key: 'icon', val: rt.new_null() },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'slug', val: 'reusable' },
			rt.ArrayItem{ key: 'title', val: rt.call_function('_x', [
				rt.new_string('Patterns'),
				rt.new_string('block category'),
			]) },
			rt.ArrayItem{ key: 'icon', val: rt.new_null() },
		]) },
	])
}

fn get_block_categories(var_post_or_block_editor_context rt.PhpVal) rt.PhpVal {
	mut var_block_categories := rt.new_null()
	mut var_block_editor_context := rt.new_null()
	mut var_post := rt.new_null()
	var_block_categories = get_default_block_categories()
	var_block_editor_context = if rt.is_true(rt.new_bool(rt.instance_of(var_post_or_block_editor_context, 'WP_Post'))) { create_wp_block_editor_context(rt.create_array([
			rt.ArrayItem{ key: 'post', val: var_post_or_block_editor_context },
		])) } else { var_post_or_block_editor_context }
	var_block_categories = rt.call_function('apply_filters', [
		rt.new_string('block_categories_all'),
		var_block_categories.clone(),
		var_block_editor_context.clone(),
	])
	if !(!rt.is_true(rt.get_property(var_block_editor_context, 'post'))) {
		var_post = rt.get_property(var_block_editor_context, 'post')
		var_block_categories = rt.call_function('apply_filters_deprecated', [
			rt.new_string('block_categories'),
			rt.create_array([rt.ArrayItem{ key: none, val: var_block_categories },
				rt.ArrayItem{ key: none, val: var_post }]),
			rt.new_string('5.8.0'),
			rt.new_string('block_categories_all'),
		])
	}
	return var_block_categories.clone()
}

fn get_allowed_block_types(var_block_editor_context rt.PhpVal) rt.PhpVal {
	mut var_allowed_block_types := rt.new_null()
	mut var_post := rt.new_null()
	var_allowed_block_types = rt.new_bool(true)
	var_allowed_block_types = rt.call_function('apply_filters', [
		rt.new_string('allowed_block_types_all'),
		var_allowed_block_types.clone(),
		var_block_editor_context.clone(),
	])
	if !(!rt.is_true(rt.get_property(var_block_editor_context, 'post'))) {
		var_post = rt.get_property(var_block_editor_context, 'post')
		var_allowed_block_types = rt.call_function('apply_filters_deprecated', [
			rt.new_string('allowed_block_types'),
			rt.create_array([rt.ArrayItem{ key: none, val: var_allowed_block_types },
				rt.ArrayItem{ key: none, val: var_post }]),
			rt.new_string('5.8.0'),
			rt.new_string('allowed_block_types_all'),
		])
	}
	return var_allowed_block_types.clone()
}

fn get_default_block_editor_settings() rt.PhpVal {
	mut var_max_upload_size := rt.new_null()
	mut var_image_size_names := rt.new_null()
	mut var_available_image_sizes := []rt.PhpVal{}
	mut var_image_size_name := rt.new_null()
	mut var_image_size_slug := rt.new_null()
	mut var_default_size := rt.new_null()
	mut var_image_default_size := rt.new_null()
	mut var_image_dimensions := rt.new_null()
	mut var_all_sizes := rt.new_null()
	mut var_size := map[string]rt.PhpVal{}
	mut var_key := rt.new_null()
	mut var_default_editor_styles_file := rt.new_null()
	mut var_default_editor_styles_file_contents := rt.new_null()
	mut var_default_editor_styles := []rt.PhpVal{}
	mut var_editor_settings := rt.new_null()
	mut var_theme_settings := rt.new_null()
	mut var_value := rt.new_null()
	var_max_upload_size = rt.new_int(0)
	if rt.is_true(rt.call_function('current_user_can', [rt.new_string('upload_files')])) {
		var_max_upload_size = rt.call_function('wp_max_upload_size', []rt.PhpVal{})
		if rt.is_true(rt.new_bool(!(rt.is_true(var_max_upload_size)))) {
			var_max_upload_size = rt.new_int(0)
		}
	}
	var_image_size_names = rt.call_function('apply_filters', [
		rt.new_string('image_size_names_choose'),
		rt.create_array([
			rt.ArrayItem{ key: 'thumbnail', val: rt.call_function('__', [
				rt.new_string('Thumbnail'),
			]) },
			rt.ArrayItem{ key: 'medium', val: rt.call_function('__', [
				rt.new_string('Medium'),
			]) },
			rt.ArrayItem{ key: 'large', val: rt.call_function('__', [
				rt.new_string('Large'),
			]) },
			rt.ArrayItem{ key: 'full', val: rt.call_function('__', [
				rt.new_string('Full Size'),
			]) },
		]),
	])
	var_available_image_sizes = []rt.PhpVal{}
	mut iter_1 := var_image_size_names.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_image_size_name_shadow := item_1.val
		mut var_image_size_slug_shadow := item_1.key
		var_available_image_sizes << rt.create_array([
			rt.ArrayItem{ key: 'slug', val: var_image_size_slug_shadow },
			rt.ArrayItem{ key: 'name', val: var_image_size_name_shadow },
		])
	}
	var_default_size = rt.call_function('get_option', [
		rt.new_string('image_default_size'),
		rt.new_string('large'),
	])
	var_image_default_size = if rt.is_true(rt.call_function('in_array', [
		var_default_size.clone(), rt.func_array_keys(var_image_size_names.clone()),
		rt.new_bool(true)]))
	{ var_default_size } else { rt.new_string('large') }
	var_image_dimensions = []rt.PhpVal{}
	var_all_sizes = rt.call_function('wp_get_registered_image_subsizes', []rt.PhpVal{})
	for var_size_shadow in var_available_image_sizes {
		var_key = var_size_shadow['slug']
		if var_all_sizes.array_isset(var_key) {
			var_image_dimensions.array_set(var_key, var_all_sizes.array_get(var_key))
		}
	}
	var_default_editor_styles_file = rt.new_string(
		(rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/css/dist/block-editor/default-editor-styles.css')
	if rt.is_true(rt.new_bool(!(rt.is_true(var_default_editor_styles_file_contents))))
		&& rt.is_true(rt.call_function('file_exists', [var_default_editor_styles_file.clone()])) {
		var_default_editor_styles_file_contents = rt.call_function('file_get_contents', [
			var_default_editor_styles_file.clone(),
		])
	}
	var_default_editor_styles = []rt.PhpVal{}
	if rt.is_true(var_default_editor_styles_file_contents) {
		var_default_editor_styles = [[var_default_editor_styles_file_contents]]
	}
	var_editor_settings = rt.create_array([
		rt.ArrayItem{ key: 'alignWide', val: rt.call_function('get_theme_support', [
			rt.new_string('align-wide'),
		]) },
		rt.ArrayItem{ key: 'allowedBlockTypes', val: true },
		rt.ArrayItem{ key: 'allowedMimeTypes', val: rt.call_function('get_allowed_mime_types',
			[]rt.PhpVal{}) },
		rt.ArrayItem{ key: 'defaultEditorStyles', val: var_default_editor_styles },
		rt.ArrayItem{ key: 'blockCategories', val: get_default_block_categories() },
		rt.ArrayItem{ key: 'isRTL', val: rt.call_function('is_rtl', []rt.PhpVal{}) },
		rt.ArrayItem{ key: 'imageDefaultSize', val: var_image_default_size },
		rt.ArrayItem{ key: 'imageDimensions', val: var_image_dimensions },
		rt.ArrayItem{ key: 'imageEditing', val: true },
		rt.ArrayItem{ key: 'imageSizes', val: var_available_image_sizes },
		rt.ArrayItem{ key: 'maxUploadFileSize', val: var_max_upload_size },
		rt.ArrayItem{ key: '__experimentalDashboardLink', val: rt.call_function('admin_url', [
			rt.new_string('/'),
		]) },
		rt.ArrayItem{ key: '__unstableGalleryWithImageBlocks', val: true },
	])
	var_theme_settings = get_classic_theme_supports_block_editor_settings()
	mut iter_2 := var_theme_settings.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_value_shadow := item_2.val
		mut var_key_shadow := item_2.key
		var_editor_settings.array_set(var_key_shadow, var_value_shadow.clone())
	}
	return var_editor_settings.clone()
}

fn get_legacy_widget_block_editor_settings() rt.PhpVal {
	mut var_editor_settings := rt.new_null()
	var_editor_settings = []rt.PhpVal{}
	var_editor_settings.array_set('widgetTypesToHideFromLegacyWidgetBlock', rt.call_function('apply_filters', [
		rt.new_string('widget_types_to_hide_from_legacy_widget_block'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'pages' },
			rt.ArrayItem{ key: none, val: 'calendar' }, rt.ArrayItem{ key: none, val: 'archives' },
			rt.ArrayItem{ key: none, val: 'media_audio' }, rt.ArrayItem{
				key: none
				val: 'media_image'
			}, rt.ArrayItem{ key: none, val: 'media_gallery' },
			rt.ArrayItem{ key: none, val: 'media_video' }, rt.ArrayItem{ key: none, val: 'search' },
			rt.ArrayItem{ key: none, val: 'text' }, rt.ArrayItem{ key: none, val: 'categories' },
			rt.ArrayItem{ key: none, val: 'recent-posts' }, rt.ArrayItem{
				key: none
				val: 'recent-comments'
			}, rt.ArrayItem{ key: none, val: 'rss' }, rt.ArrayItem{ key: none, val: 'tag_cloud' },
			rt.ArrayItem{ key: none, val: 'custom_html' }, rt.ArrayItem{ key: none, val: 'block' }]),
	]))
	return var_editor_settings.clone()
}

fn _wp_get_iframed_editor_assets() rt.PhpVal {
	mut var_current_wp_styles := rt.new_null()
	mut var_current_wp_scripts := rt.new_null()
	mut var_wp_styles := rt.new_null()
	mut var_wp_scripts := rt.new_null()
	mut var_block_registry := rt.new_null()
	mut var_block_type := rt.new_null()
	mut var_style_handle := rt.new_null()
	mut var_has_emoji_styles := rt.new_null()
	mut var_styles := rt.new_null()
	mut var_scripts := rt.new_null()
	var_current_wp_styles = var_wp_styles.clone()
	var_current_wp_scripts = var_wp_scripts.clone()
	var_wp_styles = create_wp_styles()
	var_wp_scripts = create_wp_scripts()
	rt.set_property(var_wp_styles, 'registered', rt.get_property(var_current_wp_styles,
		'registered'))
	rt.set_property(var_wp_scripts, 'registered', rt.get_property(var_current_wp_scripts,
		'registered'))
	rt.set_property(var_wp_styles, 'done', if rt.is_true(rt.call_function('wp_theme_has_theme_json', []rt.PhpVal{})) { rt.create_array([
			rt.ArrayItem{ key: none, val: 'wp-reset-editor-styles' },
		]) } else { []rt.PhpVal{} })
	rt.call_function('wp_enqueue_script', [rt.new_string('wp-polyfill')])
	rt.call_function('wp_enqueue_style', [rt.new_string('wp-edit-blocks')])
	if rt.is_true(rt.call_function('current_theme_supports', [
		rt.new_string('wp-block-styles'),
	]))
	{
		rt.call_function('wp_enqueue_style', [rt.new_string('wp-block-library-theme')])
	}
	rt.call_function('add_filter', [
		rt.new_string('should_load_block_editor_scripts_and_styles'),
		rt.new_string('__return_false'),
	])
	rt.call_function('do_action', [rt.new_string('enqueue_block_assets')])
	rt.call_function('remove_filter', [
		rt.new_string('should_load_block_editor_scripts_and_styles'),
		rt.new_string('__return_false'),
	])
	mut iife_temp_0 := Class_WP_Block_Type_Registry{}
	mut iife_result_0 := iife_temp_0.get_instance()
	var_block_registry = iife_result_0
	mut iter_3 := rt.call_method(var_block_registry, 'get_all_registered', []rt.PhpVal{}).iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_block_type_shadow := item_3.val
		if !(rt.get_property(var_block_type_shadow, 'editor_style_handles')).is_null()
			&& rt.get_property(var_block_type_shadow, 'editor_style_handles').is_array() {
			mut iter_4 := rt.get_property(var_block_type_shadow, 'editor_style_handles').iterator()
			for {
				item_4 := iter_4.next() or { break }
				mut var_style_handle_shadow := item_4.val
				rt.call_function('wp_enqueue_style', [var_style_handle_shadow.clone()])
			}
		}
	}
	var_has_emoji_styles = rt.call_function('has_action', [
		rt.new_string('wp_print_styles'),
		rt.new_string('print_emoji_styles'),
	])
	if rt.is_true(var_has_emoji_styles) {
		rt.call_function('remove_action', [rt.new_string('wp_print_styles'),
			rt.new_string('print_emoji_styles')])
	}
	rt.call_function('ob_start', []rt.PhpVal{})
	rt.call_function('wp_print_styles', []rt.PhpVal{})
	rt.call_function('wp_print_font_faces', []rt.PhpVal{})
	rt.call_function('wp_print_font_faces_from_style_variations', []rt.PhpVal{})
	var_styles = rt.call_function('ob_get_clean', []rt.PhpVal{})
	if rt.is_true(var_has_emoji_styles) {
		rt.call_function('add_action', [rt.new_string('wp_print_styles'),
			rt.new_string('print_emoji_styles')])
	}
	rt.call_function('ob_start', []rt.PhpVal{})
	rt.call_function('wp_print_head_scripts', []rt.PhpVal{})
	rt.call_function('wp_print_footer_scripts', []rt.PhpVal{})
	var_scripts = rt.call_function('ob_get_clean', []rt.PhpVal{})
	var_wp_styles = var_current_wp_styles.clone()
	var_wp_scripts = var_current_wp_scripts.clone()
	return rt.create_array([rt.ArrayItem{ key: 'styles', val: var_styles },
		rt.ArrayItem{ key: 'scripts', val: var_scripts }])
}

fn wp_get_first_block(var_blocks rt.PhpVal, var_block_name rt.PhpVal) rt.PhpVal {
	mut var_block := map[string]rt.PhpVal{}
	mut var_found_block := rt.new_null()
	mut iter_5 := var_blocks.iterator()
	for {
		item_5 := iter_5.next() or { break }
		mut var_block_shadow := item_5.val
		if rt.is_true(rt.identical(var_block_name, var_block_shadow['blockName'])) {
			return var_block_shadow.clone()
		}
		if !(!rt.is_true(var_block_shadow['innerBlocks'])) {
			var_found_block = wp_get_first_block(var_block_shadow['innerBlocks'],
				var_block_name.clone())
			if !(!rt.is_true(var_found_block)) {
				return var_found_block.clone()
			}
		}
	}
	return []rt.PhpVal{}
}

fn wp_get_post_content_block_attributes() rt.PhpVal {
	mut var_post_ID := rt.new_null()
	mut var_is_block_theme := rt.new_null()
	mut var_template_slug := rt.new_null()
	mut var_post_slug := ''
	mut var_page_slug := ''
	mut var_template_types := rt.new_null()
	mut var_template_type := rt.new_null()
	mut var_what_post_type := rt.new_null()
	mut var_current_template := rt.new_null()
	mut var_template_blocks := rt.new_null()
	mut var_post_content_block := rt.new_null()
	var_is_block_theme = rt.call_function('wp_is_block_theme', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(rt.is_true(var_is_block_theme))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(var_post_ID)))) {
		return rt.new_null()
	}
	var_template_slug = rt.call_function('get_page_template_slug', [
		var_post_ID.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_template_slug)))) {
		var_post_slug = 'singular'
		var_page_slug = 'singular'
		var_template_types = rt.call_function('get_block_templates', []rt.PhpVal{})
		mut iter_6 := var_template_types.iterator()
		for {
			item_6 := iter_6.next() or { break }
			mut var_template_type_shadow := item_6.val
			if rt.is_true(rt.identical(rt.new_string('page'), rt.get_property(var_template_type_shadow,
				'slug')))
			{
				var_page_slug = 'page'
			}
			if rt.is_true(rt.identical(rt.new_string('single'), rt.get_property(var_template_type_shadow,
				'slug')))
			{
				var_post_slug = 'single'
			}
		}
		var_what_post_type = rt.call_function('get_post_type', [
			var_post_ID.clone()])
		mut switch_val_1 := var_what_post_type
		if rt.is_true(rt.equal(switch_val_1, rt.new_string('page'))) {
			var_template_slug = rt.new_string(var_page_slug.str()).clone()
		} else {
			var_template_slug = rt.new_string(var_post_slug.str()).clone()
		}
	}
	var_current_template = rt.call_function('get_block_templates', [
		rt.create_array([
			rt.ArrayItem{ key: 'slug__in', val: rt.create_array([
				rt.ArrayItem{ key: none, val: var_template_slug },
			]) },
		]),
	])
	if !(!rt.is_true(var_current_template)) {
		var_template_blocks = rt.call_function('parse_blocks', [
			rt.get_property(var_current_template.array_get(rt.new_int(0)), 'content'),
		])
		var_post_content_block = wp_get_first_block(var_template_blocks.clone(),
			rt.new_string('core/post-content'))
		if var_post_content_block.array_isset(rt.new_string('attrs')) {
			return var_post_content_block.array_get(rt.new_string('attrs'))
		}
	}
	return rt.new_null()
}

fn get_block_editor_settings(var_custom_settings rt.PhpVal, var_block_editor_context rt.PhpVal) rt.PhpVal {
	mut var_editor_settings := rt.new_null()
	mut var_block_type := rt.new_null()
	mut var_supported_block_attributes := rt.new_null()
	mut var_global_styles := []rt.PhpVal{}
	mut var_presets := []rt.PhpVal{}
	mut var_preset_style := map[string]rt.PhpVal{}
	mut var_actual_css := rt.new_null()
	mut var_block_classes := map[string]rt.PhpVal{}
	mut var_colors_by_origin := rt.new_null()
	mut var_gradients_by_origin := rt.new_null()
	mut var_font_sizes_by_origin := rt.new_null()
	mut var_spacing_sizes_by_origin := rt.new_null()
	mut var_post_content_block_attributes := rt.new_null()
	mut var_post := rt.new_null()
	var_editor_settings = rt.call_function('array_merge', [
		get_default_block_editor_settings(),
		rt.create_array([
			rt.ArrayItem{
				key: 'allowedBlockTypes'
				val: get_allowed_block_types(var_block_editor_context.clone())
			},
			rt.ArrayItem{
				key: 'blockCategories'
				val: get_block_categories(var_block_editor_context.clone())
			},
		]),
		var_custom_settings.clone(),
	])
	var_editor_settings.array_set('__experimentalBlockBindingsSupportedAttributes', []rt.PhpVal{})
	mut iife_temp_1 := Class_WP_Block_Type_Registry{}
	mut iife_result_1 := iife_temp_1.get_instance()
	mut iter_7 := rt.func_array_keys(rt.call_method(iife_result_1, 'get_all_registered',
		[]rt.PhpVal{})).iterator()
	for {
		item_7 := iter_7.next() or { break }
		mut var_block_type_shadow := item_7.val
		var_supported_block_attributes = rt.call_function('get_block_bindings_supported_attributes', [
			var_block_type_shadow.clone(),
		])
		if !(!rt.is_true(var_supported_block_attributes)) {
			var_editor_settings.array_get_mut('__experimentalBlockBindingsSupportedAttributes').array_set(var_block_type_shadow,
				var_supported_block_attributes.clone())
		}
	}
	var_global_styles = []rt.PhpVal{}
	var_presets = [
		[rt.new_string('variables'), rt.new_string('presets'),
			rt.new_bool(true)],
		[rt.new_string('presets'), rt.new_string('presets'), rt.new_bool(true)],
	]
	for var_preset_style_shadow in var_presets {
		var_actual_css = rt.call_function('wp_get_global_stylesheet', [
			rt.create_array([
				rt.ArrayItem{ key: none, val: var_preset_style_shadow['css'] },
			]),
		])
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), var_actual_css)))) {
			var_preset_style_shadow['css'] = var_actual_css.clone()
			var_global_styles << var_preset_style_shadow.clone()
		}
	}
	var_block_classes = {
		'css':            rt.new_string('styles')
		'__unstableType': rt.new_string('theme')
		'isGlobalStyles': rt.new_bool(true)
	}
	var_actual_css = rt.call_function('wp_get_global_stylesheet', [
		rt.create_array([rt.ArrayItem{ key: none, val: var_block_classes['css'] }]),
	])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), var_actual_css)))) {
		var_block_classes['css'] = var_actual_css.clone()
		var_global_styles << var_block_classes.clone()
	}
	var_global_styles << rt.create_array([
		rt.ArrayItem{ key: 'css', val: rt.call_function('wp_get_custom_css', []rt.PhpVal{}) },
		rt.ArrayItem{ key: '__unstableType', val: 'user' },
		rt.ArrayItem{ key: 'isGlobalStyles', val: false },
	])
	var_global_styles << rt.create_array([
		rt.ArrayItem{ key: 'css', val: rt.call_function('wp_get_global_stylesheet', [
			rt.create_array([rt.ArrayItem{ key: none, val: 'custom-css' }]),
		]) },
		rt.ArrayItem{ key: '__unstableType', val: 'user' },
		rt.ArrayItem{ key: 'isGlobalStyles', val: true },
	])
	var_editor_settings.array_set('styles', rt.call_function('array_merge', [
		rt.create_array_from_list(var_global_styles),
		get_block_editor_theme_styles(),
	]))
	var_editor_settings.array_set('__experimentalFeatures', rt.call_function('wp_get_global_settings',
		[]rt.PhpVal{}))
	if var_editor_settings.array_get(rt.new_string('__experimentalFeatures')).array_get(rt.new_string('color')).array_isset(rt.new_string('palette')) {
		var_colors_by_origin =
			var_editor_settings.array_get(rt.new_string('__experimentalFeatures')).array_get(rt.new_string('color')).array_get(rt.new_string('palette'))
		var_editor_settings.array_set('colors', if !(var_colors_by_origin.array_get(rt.new_string('custom'))).is_null() {
			var_colors_by_origin.array_get(rt.new_string('custom'))
		} else {
			if !(var_colors_by_origin.array_get(rt.new_string('theme'))).is_null() {
				var_colors_by_origin.array_get(rt.new_string('theme'))
			} else {
				var_colors_by_origin.array_get(rt.new_string('default'))
			}
		})
	}
	if var_editor_settings.array_get(rt.new_string('__experimentalFeatures')).array_get(rt.new_string('color')).array_isset(rt.new_string('gradients')) {
		var_gradients_by_origin =
			var_editor_settings.array_get(rt.new_string('__experimentalFeatures')).array_get(rt.new_string('color')).array_get(rt.new_string('gradients'))
		var_editor_settings.array_set('gradients', if !(var_gradients_by_origin.array_get(rt.new_string('custom'))).is_null() {
			var_gradients_by_origin.array_get(rt.new_string('custom'))
		} else {
			if !(var_gradients_by_origin.array_get(rt.new_string('theme'))).is_null() {
				var_gradients_by_origin.array_get(rt.new_string('theme'))
			} else {
				var_gradients_by_origin.array_get(rt.new_string('default'))
			}
		})
	}
	if var_editor_settings.array_get(rt.new_string('__experimentalFeatures')).array_get(rt.new_string('typography')).array_isset(rt.new_string('fontSizes')) {
		var_font_sizes_by_origin =
			var_editor_settings.array_get(rt.new_string('__experimentalFeatures')).array_get(rt.new_string('typography')).array_get(rt.new_string('fontSizes'))
		var_editor_settings.array_set('fontSizes', if !(var_font_sizes_by_origin.array_get(rt.new_string('custom'))).is_null() {
			var_font_sizes_by_origin.array_get(rt.new_string('custom'))
		} else {
			if !(var_font_sizes_by_origin.array_get(rt.new_string('theme'))).is_null() {
				var_font_sizes_by_origin.array_get(rt.new_string('theme'))
			} else {
				var_font_sizes_by_origin.array_get(rt.new_string('default'))
			}
		})
	}
	if var_editor_settings.array_get(rt.new_string('__experimentalFeatures')).array_get(rt.new_string('color')).array_isset(rt.new_string('custom')) {
		var_editor_settings.array_set('disableCustomColors',
			!(rt.is_true(var_editor_settings.array_get(rt.new_string('__experimentalFeatures')).array_get(rt.new_string('color')).array_get(rt.new_string('custom')))))
		var_editor_settings.array_get(rt.new_string('__experimentalFeatures')).array_get(rt.new_string('color')).array_unset(rt.new_string('custom'))
	}
	if var_editor_settings.array_get(rt.new_string('__experimentalFeatures')).array_get(rt.new_string('color')).array_isset(rt.new_string('customGradient')) {
		var_editor_settings.array_set('disableCustomGradients',
			!(rt.is_true(var_editor_settings.array_get(rt.new_string('__experimentalFeatures')).array_get(rt.new_string('color')).array_get(rt.new_string('customGradient')))))
		var_editor_settings.array_get(rt.new_string('__experimentalFeatures')).array_get(rt.new_string('color')).array_unset(rt.new_string('customGradient'))
	}
	if var_editor_settings.array_get(rt.new_string('__experimentalFeatures')).array_get(rt.new_string('typography')).array_isset(rt.new_string('customFontSize')) {
		var_editor_settings.array_set('disableCustomFontSizes',
			!(rt.is_true(var_editor_settings.array_get(rt.new_string('__experimentalFeatures')).array_get(rt.new_string('typography')).array_get(rt.new_string('customFontSize')))))
		var_editor_settings.array_get(rt.new_string('__experimentalFeatures')).array_get(rt.new_string('typography')).array_unset(rt.new_string('customFontSize'))
	}
	if var_editor_settings.array_get(rt.new_string('__experimentalFeatures')).array_get(rt.new_string('typography')).array_isset(rt.new_string('lineHeight')) {
		var_editor_settings.array_set('enableCustomLineHeight',
			var_editor_settings.array_get(rt.new_string('__experimentalFeatures')).array_get(rt.new_string('typography')).array_get(rt.new_string('lineHeight')))
		var_editor_settings.array_get(rt.new_string('__experimentalFeatures')).array_get(rt.new_string('typography')).array_unset(rt.new_string('lineHeight'))
	}
	if var_editor_settings.array_get(rt.new_string('__experimentalFeatures')).array_get(rt.new_string('spacing')).array_isset(rt.new_string('units')) {
		var_editor_settings.array_set('enableCustomUnits',
			var_editor_settings.array_get(rt.new_string('__experimentalFeatures')).array_get(rt.new_string('spacing')).array_get(rt.new_string('units')))
		var_editor_settings.array_get(rt.new_string('__experimentalFeatures')).array_get(rt.new_string('spacing')).array_unset(rt.new_string('units'))
	}
	if var_editor_settings.array_get(rt.new_string('__experimentalFeatures')).array_get(rt.new_string('spacing')).array_isset(rt.new_string('padding')) {
		var_editor_settings.array_set('enableCustomSpacing',
			var_editor_settings.array_get(rt.new_string('__experimentalFeatures')).array_get(rt.new_string('spacing')).array_get(rt.new_string('padding')))
		var_editor_settings.array_get(rt.new_string('__experimentalFeatures')).array_get(rt.new_string('spacing')).array_unset(rt.new_string('padding'))
	}
	if var_editor_settings.array_get(rt.new_string('__experimentalFeatures')).array_get(rt.new_string('spacing')).array_isset(rt.new_string('customSpacingSize')) {
		var_editor_settings.array_set('disableCustomSpacingSizes',
			!(rt.is_true(var_editor_settings.array_get(rt.new_string('__experimentalFeatures')).array_get(rt.new_string('spacing')).array_get(rt.new_string('customSpacingSize')))))
		var_editor_settings.array_get(rt.new_string('__experimentalFeatures')).array_get(rt.new_string('spacing')).array_unset(rt.new_string('customSpacingSize'))
	}
	if var_editor_settings.array_get(rt.new_string('__experimentalFeatures')).array_get(rt.new_string('spacing')).array_isset(rt.new_string('spacingSizes')) {
		var_spacing_sizes_by_origin =
			var_editor_settings.array_get(rt.new_string('__experimentalFeatures')).array_get(rt.new_string('spacing')).array_get(rt.new_string('spacingSizes'))
		var_editor_settings.array_set('spacingSizes', if !(var_spacing_sizes_by_origin.array_get(rt.new_string('custom'))).is_null() {
			var_spacing_sizes_by_origin.array_get(rt.new_string('custom'))
		} else {
			if !(var_spacing_sizes_by_origin.array_get(rt.new_string('theme'))).is_null() {
				var_spacing_sizes_by_origin.array_get(rt.new_string('theme'))
			} else {
				var_spacing_sizes_by_origin.array_get(rt.new_string('default'))
			}
		})
	}
	var_editor_settings.array_set('__unstableResolvedAssets', _wp_get_iframed_editor_assets())
	var_editor_settings.array_set('__unstableIsBlockBasedTheme', rt.call_function('wp_is_block_theme',
		[]rt.PhpVal{}))
	var_editor_settings.array_set('localAutosaveInterval', 15)
	var_editor_settings.array_set('disableLayoutStyles', rt.call_function('current_theme_supports', [
		rt.new_string('disable-layout-styles'),
	]))
	var_editor_settings.array_set('__experimentalDiscussionSettings', rt.create_array([
		rt.ArrayItem{ key: 'commentOrder', val: rt.call_function('get_option', [
			rt.new_string('comment_order'),
		]) },
		rt.ArrayItem{ key: 'commentsPerPage', val: rt.call_function('get_option', [
			rt.new_string('comments_per_page'),
		]) },
		rt.ArrayItem{ key: 'defaultCommentsPage', val: rt.call_function('get_option', [
			rt.new_string('default_comments_page'),
		]) },
		rt.ArrayItem{ key: 'pageComments', val: rt.call_function('get_option', [
			rt.new_string('page_comments'),
		]) },
		rt.ArrayItem{ key: 'threadComments', val: rt.call_function('get_option', [
			rt.new_string('thread_comments'),
		]) },
		rt.ArrayItem{ key: 'threadCommentsDepth', val: rt.call_function('get_option', [
			rt.new_string('thread_comments_depth'),
		]) },
		rt.ArrayItem{ key: 'defaultCommentStatus', val: rt.call_function('get_option', [
			rt.new_string('default_comment_status'),
		]) },
		rt.ArrayItem{ key: 'avatarURL', val: rt.call_function('get_avatar_url', [
			rt.new_string(''),
			rt.create_array([rt.ArrayItem{ key: 'size', val: 96 },
				rt.ArrayItem{ key: 'force_default', val: true },
				rt.ArrayItem{ key: 'default', val: rt.call_function('get_option', [
					rt.new_string('avatar_default'),
				]) }]),
		]) },
	]))
	var_post_content_block_attributes = wp_get_post_content_block_attributes()
	if !var_post_content_block_attributes.is_null() {
		var_editor_settings.array_set('postContentAttributes',
			var_post_content_block_attributes.clone())
	}
	var_editor_settings.array_set('canUpdateBlockBindings', rt.call_function('current_user_can', [
		rt.new_string('edit_block_binding'),
		var_block_editor_context.clone(),
	]))
	var_editor_settings = rt.call_function('apply_filters', [
		rt.new_string('block_editor_settings_all'),
		var_editor_settings.clone(),
		var_block_editor_context.clone(),
	])
	if !(!rt.is_true(rt.get_property(var_block_editor_context, 'post'))) {
		var_post = rt.get_property(var_block_editor_context, 'post')
		var_editor_settings = rt.call_function('apply_filters_deprecated', [
			rt.new_string('block_editor_settings'),
			rt.create_array([rt.ArrayItem{ key: none, val: var_editor_settings },
				rt.ArrayItem{ key: none, val: var_post }]),
			rt.new_string('5.8.0'),
			rt.new_string('block_editor_settings_all'),
		])
	}
	var_editor_settings.array_set('canEditCSS', rt.call_function('current_user_can', [
		rt.new_string('edit_css'),
	]))
	return var_editor_settings.clone()
}

fn block_editor_rest_api_preload(var_preload_paths_arg rt.PhpVal, var_block_editor_context rt.PhpVal) {
	mut var_preload_paths := var_preload_paths_arg
	mut var_selected_post := rt.new_null()
	mut var_backup_global_post := rt.new_null()
	mut var_backup_wp_scripts := rt.new_null()
	mut var_backup_wp_styles := rt.new_null()
	mut var_path := rt.new_null()
	mut var_preload_data := rt.new_null()
	mut var_post := rt.new_null()
	mut var_wp_scripts := rt.new_null()
	mut var_wp_styles := rt.new_null()
	var_preload_paths = rt.call_function('apply_filters', [
		rt.new_string('block_editor_rest_api_preload_paths'),
		var_preload_paths.clone(),
		var_block_editor_context.clone(),
	])
	if !(!rt.is_true(rt.get_property(var_block_editor_context, 'post'))) {
		var_selected_post = rt.get_property(var_block_editor_context, 'post')
		var_preload_paths = rt.call_function('apply_filters_deprecated', [
			rt.new_string('block_editor_preload_paths'),
			rt.create_array([rt.ArrayItem{ key: none, val: var_preload_paths },
				rt.ArrayItem{ key: none, val: var_selected_post }]),
			rt.new_string('5.8.0'),
			rt.new_string('block_editor_rest_api_preload_paths'),
		])
	}
	if !rt.is_true(var_preload_paths) {
		return
	}
	var_backup_global_post = if !(!rt.is_true(var_post)) { var_post.dup() } else { var_post }
	var_backup_wp_scripts = if !(!rt.is_true(var_wp_scripts)) {
		var_wp_scripts.dup()
	} else {
		var_wp_scripts
	}
	var_backup_wp_styles = if !(!rt.is_true(var_wp_styles)) {
		var_wp_styles.dup()
	} else {
		var_wp_styles
	}
	mut iter_8 := var_preload_paths.iterator()
	for {
		item_8 := iter_8.next() or { break }
		mut var_path_shadow := item_8.val
		if var_path_shadow.clone().is_string()
			&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('str_starts_with', [var_path_shadow.clone(), rt.new_string('/')]))))) {
			var_path_shadow = rt.new_string('/' + var_path_shadow.str())
			continue
		}
		if var_path_shadow.clone().is_array()
			&& var_path_shadow.array_get(rt.new_int(0)).is_string()
			&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('str_starts_with', [var_path_shadow.array_get(rt.new_int(0)), rt.new_string('/')]))))) {
			var_path_shadow.array_set(0, '/' + (var_path_shadow.array_get(rt.new_int(0))).str())
		}
	}
	var_path = rt.new_null()
	var_preload_data = rt.call_function('array_reduce', [var_preload_paths.clone(),
		rt.new_string('rest_preload_api_request'), []rt.PhpVal{}])
	var_post = var_backup_global_post.clone()
	var_wp_scripts = var_backup_wp_scripts.clone()
	var_wp_styles = var_backup_wp_styles.clone()
	rt.call_function('wp_add_inline_script', [rt.new_string('wp-api-fetch'),
		rt.call_function('sprintf', [
			rt.new_string('wp.apiFetch.use( wp.apiFetch.createPreloadingMiddleware( %s ) );'),
			rt.call_function('wp_json_encode', [var_preload_data.clone(),
				rt.bitwise_or(rt.get_constant('JSON_HEX_TAG'),
					rt.get_constant('JSON_UNESCAPED_SLASHES'))]),
		]),
		rt.new_string('after')])
}

fn get_block_editor_theme_styles() rt.PhpVal {
	mut var_editor_styles := rt.new_null()
	mut var_styles := rt.new_null()
	mut var_style := rt.new_null()
	mut var_response := rt.new_null()
	mut var_file := rt.new_null()
	var_styles = []rt.PhpVal{}
	if rt.is_true(var_editor_styles)
		&& rt.is_true(rt.call_function('current_theme_supports', [rt.new_string('editor-styles')])) {
		mut iter_9 := var_editor_styles.iterator()
		for {
			item_9 := iter_9.next() or { break }
			mut var_style_shadow := item_9.val
			if rt.is_true(rt.call_function('preg_match', [
				rt.new_string('~^(https?:)?//~'),
				var_style_shadow.clone(),
			]))
			{
				var_response = rt.call_function('wp_remote_get', [
					var_style_shadow.clone()])
				if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [
					var_response.clone(),
				])))))
				{
					var_styles.array_push(rt.create_array([
						rt.ArrayItem{ key: 'css', val: rt.call_function('wp_remote_retrieve_body', [
							var_response.clone(),
						]) },
						rt.ArrayItem{ key: '__unstableType', val: 'theme' },
						rt.ArrayItem{ key: 'isGlobalStyles', val: false },
					]))
				}
			} else {
				var_file = rt.call_function('get_theme_file_path', [
					var_style_shadow.clone()])
				if rt.is_true(rt.call_function('is_file', [var_file.clone()])) {
					var_styles.array_push(rt.create_array([
						rt.ArrayItem{ key: 'css', val: rt.call_function('file_get_contents', [
							var_file.clone(),
						]) },
						rt.ArrayItem{ key: 'baseURL', val: rt.call_function('get_theme_file_uri', [
							var_style_shadow.clone(),
						]) },
						rt.ArrayItem{ key: '__unstableType', val: 'theme' },
						rt.ArrayItem{ key: 'isGlobalStyles', val: false },
					]))
				}
			}
		}
	}
	return var_styles.clone()
}

fn get_classic_theme_supports_block_editor_settings() rt.PhpVal {
	mut var_theme_settings := rt.new_null()
	mut var_color_palette := rt.new_null()
	mut var_font_sizes := rt.new_null()
	mut var_gradient_presets := rt.new_null()
	mut var_spacing_sizes := rt.new_null()
	var_theme_settings = rt.create_array([
		rt.ArrayItem{ key: 'disableCustomColors', val: rt.call_function('get_theme_support', [
			rt.new_string('disable-custom-colors'),
		]) },
		rt.ArrayItem{ key: 'disableCustomFontSizes', val: rt.call_function('get_theme_support', [
			rt.new_string('disable-custom-font-sizes'),
		]) },
		rt.ArrayItem{ key: 'disableCustomGradients', val: rt.call_function('get_theme_support', [
			rt.new_string('disable-custom-gradients'),
		]) },
		rt.ArrayItem{ key: 'disableLayoutStyles', val: rt.call_function('get_theme_support', [
			rt.new_string('disable-layout-styles'),
		]) },
		rt.ArrayItem{ key: 'enableCustomLineHeight', val: rt.call_function('get_theme_support', [
			rt.new_string('custom-line-height'),
		]) },
		rt.ArrayItem{ key: 'enableCustomSpacing', val: rt.call_function('get_theme_support', [
			rt.new_string('custom-spacing'),
		]) },
		rt.ArrayItem{ key: 'enableCustomUnits', val: rt.call_function('get_theme_support', [
			rt.new_string('custom-units'),
		]) },
	])
	var_color_palette = rt.call_function('current', [
		rt.cast_array(rt.call_function('get_theme_support', [
			rt.new_string('editor-color-palette'),
		])),
	])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_color_palette)))) {
		var_theme_settings.array_set('colors', var_color_palette.clone())
	}
	var_font_sizes = rt.call_function('current', [
		rt.cast_array(rt.call_function('get_theme_support', [
			rt.new_string('editor-font-sizes'),
		])),
	])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_font_sizes)))) {
		var_theme_settings.array_set('fontSizes', var_font_sizes.clone())
	}
	var_gradient_presets = rt.call_function('current', [
		rt.cast_array(rt.call_function('get_theme_support', [
			rt.new_string('editor-gradient-presets'),
		])),
	])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_gradient_presets)))) {
		var_theme_settings.array_set('gradients', var_gradient_presets.clone())
	}
	var_spacing_sizes = rt.call_function('current', [
		rt.cast_array(rt.call_function('get_theme_support', [
			rt.new_string('editor-spacing-sizes'),
		])),
	])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_spacing_sizes)))) {
		var_theme_settings.array_set('spacingSizes', var_spacing_sizes.clone())
	}
	return var_theme_settings.clone()
}

fn wp_initialize_site_preview_hooks() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('IFRAME_REQUEST')])))))
		&& rt.get_superglobal('_GET').array_isset(rt.new_string('wp_site_preview'))
		&& 1 == rt.new_int((rt.get_superglobal('_GET').array_get(rt.new_string('wp_site_preview'))).to_i64())
		&& rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_theme_options')])) {
		rt.call_function('define', [rt.new_string('IFRAME_REQUEST'),
			rt.new_bool(true)])
	}
}

struct Class_WP_Block_Editor_Context {
	rt.PhpObjectBase
}

struct Class_WP_Styles {
	rt.PhpObjectBase
}

struct Class_WP_Scripts {
	rt.PhpObjectBase
}

struct Class_WP_Block_Type_Registry {
	rt.PhpObjectBase
}

fn create_wp_block_editor_context(_args ...rt.PhpVal) &Class_WP_Block_Editor_Context {
	mut obj := &Class_WP_Block_Editor_Context{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_styles(_args ...rt.PhpVal) &Class_WP_Styles {
	mut obj := &Class_WP_Styles{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_scripts(_args ...rt.PhpVal) &Class_WP_Scripts {
	mut obj := &Class_WP_Scripts{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_block_type_registry(_args ...rt.PhpVal) &Class_WP_Block_Type_Registry {
	mut obj := &Class_WP_Block_Type_Registry{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Block_Editor_Context) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Block_Editor_Context) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Block_Editor_Context) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WP_Styles) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Styles) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Styles) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WP_Scripts) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Scripts) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Scripts) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WP_Block_Type_Registry) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Block_Type_Registry) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Block_Type_Registry) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
