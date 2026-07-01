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
	mut var_block_categories := get_default_block_categories()
	mut var_block_editor_context := if rt.is_true(rt.new_bool(rt.instance_of(var_post_or_block_editor_context, 'WP_Post'))) { create_wp_block_editor_context(rt.create_array([
			rt.ArrayItem{ key: 'post', val: var_post_or_block_editor_context },
		])) } else { var_post_or_block_editor_context }
	var_block_categories = rt.call_function('apply_filters', [
		rt.new_string('block_categories_all'),
		var_block_categories.dup(),
		var_block_editor_context.dup(),
	])
	if !(!rt.is_true(rt.get_property(var_block_editor_context, 'post'))) {
		mut var_post := rt.get_property(var_block_editor_context, 'post')
		var_block_categories = rt.call_function('apply_filters_deprecated', [
			rt.new_string('block_categories'),
			rt.create_array([rt.ArrayItem{ key: none, val: var_block_categories },
				rt.ArrayItem{ key: none, val: var_post }]),
			rt.new_string('5.8.0'),
			rt.new_string('block_categories_all'),
		])
	}
	return var_block_categories.dup()
}

fn get_allowed_block_types(var_block_editor_context rt.PhpVal) rt.PhpVal {
	mut var_allowed_block_types := rt.new_bool(rt.new_bool(true))
	var_allowed_block_types = rt.call_function('apply_filters', [
		rt.new_string('allowed_block_types_all'),
		var_allowed_block_types.dup(),
		var_block_editor_context.dup(),
	])
	if !(!rt.is_true(rt.get_property(var_block_editor_context, 'post'))) {
		mut var_post := rt.get_property(var_block_editor_context, 'post')
		var_allowed_block_types = rt.call_function('apply_filters_deprecated', [
			rt.new_string('allowed_block_types'),
			rt.create_array([rt.ArrayItem{ key: none, val: var_allowed_block_types },
				rt.ArrayItem{ key: none, val: var_post }]),
			rt.new_string('5.8.0'),
			rt.new_string('allowed_block_types_all'),
		])
	}
	return var_allowed_block_types.dup()
}

fn get_default_block_editor_settings() rt.PhpVal {
	mut var_max_upload_size := rt.new_int(rt.new_int(0))
	if rt.is_true(rt.call_function('current_user_can', [rt.new_string('upload_files')])) {
		var_max_upload_size = rt.call_function('wp_max_upload_size', []rt.PhpVal{})
		if rt.is_true(rt.new_bool(!(rt.is_true(var_max_upload_size)))) {
			var_max_upload_size = rt.new_int(rt.new_int(0))
		}
	}
	mut var_image_size_names := rt.call_function('apply_filters', [
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
	mut var_available_image_sizes := []rt.PhpVal{}
	{
		mut iter_1 := var_image_size_names.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_image_size_name := item_1.val
			mut var_image_size_slug := item_1.key
			var_available_image_sizes << rt.create_array([
				rt.ArrayItem{ key: 'slug', val: var_image_size_slug },
				rt.ArrayItem{ key: 'name', val: var_image_size_name },
			])
		}
	}
	mut var_default_size := rt.call_function('get_option', [
		rt.new_string('image_default_size'),
		rt.new_string('large'),
	])
	mut var_image_default_size := if rt.is_true(rt.call_function('in_array', [
		var_default_size.dup(), rt.func_array_keys(var_image_size_names.dup()),
		rt.new_bool(true)]))
	{ var_default_size } else { rt.new_string('large') }
	mut var_image_dimensions := []rt.PhpVal{}
	mut var_all_sizes := rt.call_function('wp_get_registered_image_subsizes', []rt.PhpVal{})
	for var_size in var_available_image_sizes {
		mut var_key := var_size.array_get('slug')
		if var_all_sizes.array_isset(var_key) {
			var_image_dimensions.array_set(var_key, var_all_sizes.array_get(var_key))
		}
	}
	mut var_default_editor_styles_file := rt.new_string(
		(rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/css/dist/block-editor/default-editor-styles.css')
	// unsupported statement: Stmt_Static
	if rt.is_true(rt.new_bool(
		rt.is_true(rt.new_bool(!(rt.is_true(var_default_editor_styles_file_contents))))
		&& rt.is_true(rt.call_function('file_exists', [var_default_editor_styles_file.dup()]))))
	{
		mut var_default_editor_styles_file_contents := rt.call_function('file_get_contents', [
			var_default_editor_styles_file.dup(),
		])
	}
	mut var_default_editor_styles := []rt.PhpVal{}
	if rt.is_true(var_default_editor_styles_file_contents) {
		var_default_editor_styles = [[var_default_editor_styles_file_contents]]
	}
	mut var_editor_settings := rt.create_array([
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
	mut var_theme_settings := get_classic_theme_supports_block_editor_settings()
	{
		mut iter_1 := var_theme_settings.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_value := item_1.val
			mut var_key := item_1.key
			var_editor_settings.array_set(var_key, var_value.dup())
		}
	}
	return var_editor_settings.dup()
}

fn get_legacy_widget_block_editor_settings() rt.PhpVal {
	mut var_editor_settings := []rt.PhpVal{}
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
	return var_editor_settings.dup()
}

fn _wp_get_iframed_editor_assets() rt.PhpVal {
	// unsupported statement: Stmt_Global
	mut var_current_wp_styles := var_wp_styles.dup()
	mut var_current_wp_scripts := var_wp_scripts.dup()
	mut var_wp_styles := create_wp_styles()
	mut var_wp_scripts := create_wp_scripts()
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
	mut var_block_registry := fn () rt.PhpVal {
		mut temp := Class_WP_Block_Type_Registry{}
		return temp.get_instance()
	}()
	{
		mut iter_1 :=
			rt.call_method(var_block_registry, 'get_all_registered', []rt.PhpVal{}).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_block_type := item_1.val
			if rt.is_true(rt.new_bool(
				!(rt.get_property(var_block_type, 'editor_style_handles')).is_null()
				&& rt.is_true(rt.new_bool(rt.get_property(var_block_type, 'editor_style_handles').is_array()))))
			{
				{
					mut iter_2 := rt.get_property(var_block_type, 'editor_style_handles').iterator()
					for {
						item_2 := iter_2.next() or { break }
						mut var_style_handle := item_2.val
						rt.call_function('wp_enqueue_style', [
							var_style_handle.dup()])
					}
				}
			}
		}
	}
	mut var_has_emoji_styles := rt.call_function('has_action', [
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
	mut var_styles := rt.call_function('ob_get_clean', []rt.PhpVal{})
	if rt.is_true(var_has_emoji_styles) {
		rt.call_function('add_action', [rt.new_string('wp_print_styles'),
			rt.new_string('print_emoji_styles')])
	}
	rt.call_function('ob_start', []rt.PhpVal{})
	rt.call_function('wp_print_head_scripts', []rt.PhpVal{})
	rt.call_function('wp_print_footer_scripts', []rt.PhpVal{})
	mut var_scripts := rt.call_function('ob_get_clean', []rt.PhpVal{})
	var_wp_styles = var_current_wp_styles.dup()
	var_wp_scripts = var_current_wp_scripts.dup()
	return rt.create_array([rt.ArrayItem{ key: 'styles', val: var_styles },
		rt.ArrayItem{ key: 'scripts', val: var_scripts }])
}

fn wp_get_first_block(var_blocks rt.PhpVal, var_block_name rt.PhpVal) rt.PhpVal {
	{
		mut iter_1 := var_blocks.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_block := item_1.val
			if rt.is_true(rt.identical(var_block_name, var_block.array_get('blockName'))) {
				return var_block.dup()
			}
			if !(!rt.is_true(var_block.array_get('innerBlocks'))) {
				mut var_found_block := wp_get_first_block(var_block.array_get('innerBlocks'),
					var_block_name.dup())
				if !(!rt.is_true(var_found_block)) {
					return var_found_block.dup()
				}
			}
		}
	}
	return []rt.PhpVal{}
}

fn wp_get_post_content_block_attributes() rt.PhpVal {
	mut var_post_ID := rt.new_null()
	// unsupported statement: Stmt_Global
	mut var_is_block_theme := rt.call_function('wp_is_block_theme', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_is_block_theme))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(var_post_ID))))))
	{
		return rt.new_null()
	}
	mut var_template_slug := rt.call_function('get_page_template_slug', [
		var_post_ID.dup()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_template_slug)))) {
		mut var_post_slug := 'singular'
		mut var_page_slug := 'singular'
		mut var_template_types := rt.call_function('get_block_templates', []rt.PhpVal{})
		{
			mut iter_1 := var_template_types.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_template_type := item_1.val
				if rt.is_true(rt.identical(rt.new_string('page'), rt.get_property(var_template_type,
					'slug')))
				{
					var_page_slug = 'page'
				}
				if rt.is_true(rt.identical(rt.new_string('single'), rt.get_property(var_template_type,
					'slug')))
				{
					var_post_slug = 'single'
				}
			}
		}
		mut var_what_post_type := rt.call_function('get_post_type', [
			var_post_ID.dup()])
		mut switch_val_1 := var_what_post_type
		if rt.is_true(rt.equal(switch_val_1, rt.new_string('page'))) {
			var_template_slug = rt.new_string().dup()
		} else {
		}
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

fn create_wp_block_editor_context() &Class_WP_Block_Editor_Context {
	mut obj := &Class_WP_Block_Editor_Context{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_styles() &Class_WP_Styles {
	mut obj := &Class_WP_Styles{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_scripts() &Class_WP_Scripts {
	mut obj := &Class_WP_Scripts{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_block_type_registry() &Class_WP_Block_Type_Registry {
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

pub fn init_wp_includes_block_editor_php() {
}
