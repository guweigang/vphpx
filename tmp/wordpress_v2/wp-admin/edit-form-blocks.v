import rt

struct Class_WP_Block_Editor_Context {
	rt.PhpObjectBase
}

struct Class_WP_Theme_JSON_Resolver {
	rt.PhpObjectBase
}

struct Class_WP_Block_Patterns_Registry {
	rt.PhpObjectBase
}

struct Class_WP_Block_Pattern_Categories_Registry {
	rt.PhpObjectBase
}

fn create_wp_block_editor_context(_args ...rt.PhpVal) &Class_WP_Block_Editor_Context {
	mut obj := &Class_WP_Block_Editor_Context{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_theme_json_resolver(_args ...rt.PhpVal) &Class_WP_Theme_JSON_Resolver {
	mut obj := &Class_WP_Theme_JSON_Resolver{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_block_patterns_registry(_args ...rt.PhpVal) &Class_WP_Block_Patterns_Registry {
	mut obj := &Class_WP_Block_Patterns_Registry{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_block_pattern_categories_registry(_args ...rt.PhpVal) &Class_WP_Block_Pattern_Categories_Registry {
	mut obj := &Class_WP_Block_Pattern_Categories_Registry{
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

fn (mut this Class_WP_Theme_JSON_Resolver) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Theme_JSON_Resolver) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Theme_JSON_Resolver) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WP_Block_Patterns_Registry) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Block_Patterns_Registry) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Block_Patterns_Registry) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WP_Block_Pattern_Categories_Registry) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Block_Pattern_Categories_Registry) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Block_Pattern_Categories_Registry) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_post_type := rt.new_null()
	mut var_post_type_object := rt.new_null()
	mut var_post := rt.new_null()
	mut var_title := rt.new_null()
	mut var_wp_meta_boxes := rt.new_null()
	mut var_paths := []rt.PhpVal{}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		fn () {
			print((rt.new_string('-1')).str())
			exit(0)
		}()
	}
	mut var_block_editor_context := create_wp_block_editor_context(rt.create_array([
		rt.ArrayItem{ key: 'post', val: var_post },
	]))
	mut var_current_screen := rt.call_function('get_current_screen', []rt.PhpVal{})
	rt.call_method(var_current_screen, 'is_block_editor', [rt.new_bool(true)])
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_classes := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.new_string('${var_classes.to_string()} is-fullscreen-mode')
	}
	rt.call_function('add_filter', [rt.new_string('admin_body_class'),
		rt.new_closure(closure_1_fn)])
	rt.call_function('remove_action', [rt.new_string('admin_print_scripts'),
		rt.new_string('print_emoji_detection_script')])
	rt.call_function('add_filter', [rt.new_string('screen_options_show_screen'),
		rt.new_string('__return_false')])
	rt.call_function('wp_enqueue_script', [rt.new_string('heartbeat')])
	rt.call_function('wp_enqueue_script', [rt.new_string('wp-edit-post')])
	mut var_rest_path := rt.call_function('rest_get_route_for_post', [
		var_post.clone()])
	mut var_active_theme := rt.call_function('get_stylesheet', []rt.PhpVal{})
	mut var_global_styles_endpoint_context := if rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('edit_theme_options'),
	]))
	{ 'edit' } else { 'view' }
	mut var_template_lookup_slug := rt.new_string((if rt.is_true(rt.identical(rt.new_string('page'), rt.get_property(var_post,
		'post_type')))
	{
		'page'
	} else {
		'single-' + (rt.get_property(var_post, 'post_type')).str()
	}).str())
	if !(!rt.is_true(rt.get_property(var_post, 'post_name'))) {
		var_template_lookup_slug = rt.concat(var_template_lookup_slug, rt.new_string('-' +
			(rt.get_property(var_post, 'post_name')).str()))
	}
	mut iife_temp_1 := Class_WP_Theme_JSON_Resolver{}
	mut iife_result_1 := iife_temp_1.get_user_global_styles_post_id()
	mut iife_temp_2 := Class_WP_Theme_JSON_Resolver{}
	mut iife_result_2 := iife_temp_2.get_user_global_styles_post_id()
	mut var_preload_paths := [rt.new_string('/wp/v2/types?context=view'),
		rt.new_string('/wp/v2/taxonomies?context=view'),
		rt.call_function('add_query_arg', [
			rt.new_string('context'),
			rt.new_string('edit'),
			var_rest_path.clone(),
		]),
		rt.call_function('sprintf', [
			rt.new_string('/wp/v2/types/%s?context=edit'),
			var_post_type.clone(),
		]),
		rt.new_string('/wp/v2/users/me'),
		[
			rt.call_function('rest_get_route_for_post_type_items', [
				rt.new_string('attachment'),
			]),
			rt.new_string('OPTIONS'),
		],
		[
			rt.call_function('rest_get_route_for_post_type_items', [
				rt.new_string('page'),
			]),
			rt.new_string('OPTIONS'),
		],
		[
			rt.call_function('rest_get_route_for_post_type_items', [
				rt.new_string('wp_block'),
			]),
			rt.new_string('OPTIONS'),
		],
		[
			rt.call_function('rest_get_route_for_post_type_items', [
				rt.new_string('wp_template'),
			]),
			rt.new_string('OPTIONS'),
		],
		rt.call_function('sprintf', [
			rt.new_string('%s/autosaves?context=edit'),
			var_rest_path.clone(),
		]),
		rt.new_string('/wp/v2/settings'),
		[
			rt.new_string('/wp/v2/settings'),
			rt.new_string('OPTIONS'),
		],
		
			'/wp/v2/global-styles/themes/' + var_active_theme.str() + '?context=view',
		
			'/wp/v2/global-styles/themes/' + var_active_theme.str() + '/variations?context=view',
		rt.new_string('/wp/v2/themes?context=edit&status=active'),
		[
			'/wp/v2/global-styles/' + iife_result_1.str(),
			rt.new_string('OPTIONS'),
		],
		'/wp/v2/global-styles/' + iife_result_2.str() + '?context=' +
			var_global_styles_endpoint_context,
		rt.new_string('/wp/v2/block-patterns/categories'),
		'/?_fields=' +(rt.call_function('implode', [rt.new_string(','), [rt.new_string('description'), rt.new_string('gmt_offset'), rt.new_string('home'), rt.new_string('image_sizes'), rt.new_string('image_size_threshold'), rt.new_string('image_output_formats'), rt.new_string('jpeg_interlaced'), rt.new_string('png_interlaced'), rt.new_string('gif_interlaced'), rt.new_string('name'), rt.new_string('site_icon'), rt.new_string('site_icon_url'), rt.new_string('site_logo'), rt.new_string('timezone_string'), rt.new_string('url'), rt.new_string('page_for_posts'), rt.new_string('page_on_front'), rt.new_string('show_on_front')]])).str(),
		var_paths << rt.call_function('add_query_arg', [
			rt.new_string('slug'),
			var_template_lookup_slug.clone(),
			rt.new_string('/wp/v2/templates/lookup'),
		])]
	rt.call_function('block_editor_rest_api_preload', [
		rt.create_array_from_list(var_preload_paths),
		var_block_editor_context,
	])
	rt.call_function('wp_add_inline_script', [rt.new_string('wp-blocks'),
		rt.call_function('sprintf', [rt.new_string('wp.blocks.setCategories( %s );'),
			rt.call_function('wp_json_encode', [
				rt.call_function('get_block_categories', [var_post.clone()]),
				rt.bitwise_or(rt.get_constant('JSON_HEX_TAG'),
					rt.get_constant('JSON_UNESCAPED_SLASHES')),
			])]),
		rt.new_string('after')])
	mut var_initial_edits := map[string]rt.PhpVal{}
	mut var_is_new_post := false
	if rt.is_true(rt.identical(rt.new_string('auto-draft'),
		rt.get_property(var_post, 'post_status')))
	{
		var_is_new_post = true
		if rt.is_true(rt.call_function('post_type_supports', [
			rt.get_property(var_post, 'post_type'),
			rt.new_string('title'),
		]))
		{
			var_initial_edits['title'] = rt.get_property(var_post, 'post_title')
		}
		if rt.is_true(rt.call_function('post_type_supports', [
			rt.get_property(var_post, 'post_type'),
			rt.new_string('editor'),
		]))
		{
			var_initial_edits['content'] = rt.get_property(var_post, 'post_content')
		}
		if rt.is_true(rt.call_function('post_type_supports', [
			rt.get_property(var_post, 'post_type'),
			rt.new_string('excerpt'),
		]))
		{
			var_initial_edits['excerpt'] = rt.get_property(var_post, 'post_excerpt')
		}
	}
	rt.call_function('wp_add_inline_script', [rt.new_string('wp-blocks'),
		rt.new_string('wp.blocks.unstable__bootstrapServerSideBlockDefinitions(' +
			(rt.call_function('wp_json_encode', [rt.call_function('get_block_editor_server_block_settings', []rt.PhpVal{}), rt.bitwise_or(rt.get_constant('JSON_HEX_TAG'), rt.get_constant('JSON_UNESCAPED_SLASHES'))])).str() +
			');')])
	mut var_registered_sources := rt.call_function('get_all_registered_block_bindings_sources',
		[]rt.PhpVal{})
	if !(!rt.is_true(var_registered_sources)) {
		mut var_filtered_sources := map[string]rt.PhpVal{}
		mut iter_1 := var_registered_sources.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_source := item_1.val
			var_filtered_sources << rt.create_array([
				rt.ArrayItem{ key: 'name', val: rt.get_property(var_source, 'name') },
				rt.ArrayItem{ key: 'label', val: rt.get_property(var_source, 'label') },
				rt.ArrayItem{ key: 'usesContext', val: rt.get_property(var_source, 'uses_context') },
			])
		}
		mut var_script := rt.call_function('sprintf', [
			rt.new_string('for ( const source of %s ) { wp.blocks.registerBlockBindingsSource( source ); }'),
			rt.call_function('wp_json_encode', [
				rt.create_array_from_list(var_filtered_sources),
				rt.bitwise_or(rt.get_constant('JSON_HEX_TAG'),
					rt.get_constant('JSON_UNESCAPED_SLASHES')),
			]),
		])
		rt.call_function('wp_add_inline_script', [rt.new_string('wp-blocks'),
			var_script.clone()])
	}
	mut var_meta_box_url := rt.call_function('admin_url', [rt.new_string('post.php')])
	var_meta_box_url = rt.call_function('add_query_arg', [
		rt.create_array([
			rt.ArrayItem{ key: 'post', val: rt.get_property(var_post, 'ID') },
			rt.ArrayItem{ key: 'action', val: 'edit' },
			rt.ArrayItem{ key: 'meta-box-loader', val: true },
			rt.ArrayItem{ key: 'meta-box-loader-nonce', val: rt.call_function('wp_create_nonce', [
				rt.new_string('meta-box-loader'),
			]) },
		]),
		var_meta_box_url.clone(),
	])
	rt.call_function('wp_add_inline_script', [rt.new_string('wp-editor'),
		rt.call_function('sprintf', [rt.new_string('var _wpMetaBoxUrl = %s;'),
			rt.call_function('wp_json_encode', [var_meta_box_url.clone(),
				rt.bitwise_or(rt.get_constant('JSON_HEX_TAG'),
					rt.get_constant('JSON_UNESCAPED_SLASHES'))])]),
		rt.new_string('before')])
	rt.call_function('wp_add_inline_script', [rt.new_string('heartbeat'),
		rt.new_string('jQuery( function() {\n\t\twp.heartbeat.interval( 10 );\n\t} );'),
		rt.new_string('after')])
	mut var_available_templates := rt.call_method(rt.call_function('wp_get_theme', []rt.PhpVal{}),
		'get_page_templates', [
		rt.call_function('get_post', [rt.get_property(var_post, 'ID')]),
	])
	var_available_templates = if !(!rt.is_true(var_available_templates)) { rt.call_function('array_replace', [
			rt.create_array([
				rt.ArrayItem{ key: '', val: rt.call_function('apply_filters', [
					rt.new_string('default_page_template_title'),
					rt.call_function('__', [rt.new_string('Default template')]),
					rt.new_string('rest-api'),
				]) },
			]),
			var_available_templates.clone(),
		]) } else { var_available_templates }
	mut var_user_id := rt.call_function('wp_check_post_lock', [
		rt.get_property(var_post, 'ID'),
	])
	if rt.is_true(var_user_id) {
		mut var_locked := false
		if rt.is_true(rt.call_function('apply_filters', [
			rt.new_string('show_post_locked_dialog'),
			rt.new_bool(true),
			var_post.clone(),
			var_user_id.clone(),
		]))
		{
			var_locked = true
		}
		mut var_user_details := rt.new_null()
		if var_locked {
			mut var_user := rt.call_function('get_userdata', [
				var_user_id.clone()])
			var_user_details = rt.create_array([
				rt.ArrayItem{ key: 'name', val: rt.get_property(var_user, 'display_name') },
			])
			if rt.is_true(rt.call_function('get_option', [rt.new_string('show_avatars')])) {
				var_user_details.array_set('avatar', rt.call_function('get_avatar_url', [
					var_user_id.clone(),
					rt.create_array([rt.ArrayItem{ key: 'size', val: 128 }]),
				]))
			}
		}
		mut var_lock_details := {
			'isLocked': rt.new_bool(var_locked)
			'user':     var_user_details
		}
	} else {
		mut var_active_post_lock := rt.call_function('wp_set_post_lock', [
			rt.get_property(var_post, 'ID'),
		])
		if rt.is_true(var_active_post_lock) {
			var_active_post_lock = rt.call_function('esc_attr', [
				rt.call_function('implode', [rt.new_string(':'),
					var_active_post_lock.clone()]),
			])
		}
		var_lock_details = {
			'isLocked':       rt.new_bool(false)
			'activePostLock': var_active_post_lock
		}
	}
	mut var_body_placeholder := rt.call_function('apply_filters', [
		rt.new_string('write_your_story'),
		rt.call_function('__', [rt.new_string('Type / to choose a block')]),
		var_post.clone(),
	])
	mut var_editor_settings := rt.create_array([
		rt.ArrayItem{ key: 'availableTemplates', val: var_available_templates },
		rt.ArrayItem{ key: 'disablePostFormats', val: !(rt.is_true(rt.call_function('current_theme_supports', [
			rt.new_string('post-formats'),
		]))) },
		rt.ArrayItem{ key: 'titlePlaceholder', val: rt.call_function('apply_filters', [
			rt.new_string('enter_title_here'),
			rt.call_function('__', [rt.new_string('Add title')]),
			var_post.clone(),
		]) },
		rt.ArrayItem{ key: 'bodyPlaceholder', val: var_body_placeholder },
		rt.ArrayItem{ key: 'autosaveInterval', val: rt.get_constant('AUTOSAVE_INTERVAL') },
		rt.ArrayItem{ key: 'richEditingEnabled', val: rt.call_function('user_can_richedit',
			[]rt.PhpVal{}) },
		rt.ArrayItem{ key: 'postLock', val: var_lock_details },
		rt.ArrayItem{ key: 'postLockUtils', val: rt.create_array([
			rt.ArrayItem{ key: 'nonce', val: rt.call_function('wp_create_nonce', [
				rt.new_string('lock-post_' + (rt.get_property(var_post, 'ID')).str())]) },
			rt.ArrayItem{ key: 'unlockNonce', val: rt.call_function('wp_create_nonce', [
				rt.new_string('update-post_' + (rt.get_property(var_post, 'ID')).str())]) },
			rt.ArrayItem{ key: 'ajaxUrl', val: rt.call_function('admin_url', [
				rt.new_string('admin-ajax.php')]) },
		]) },
		rt.ArrayItem{ key: 'supportsLayout', val: rt.call_function('wp_theme_has_theme_json',
			[]rt.PhpVal{}) },
		rt.ArrayItem{ key: 'supportsTemplateMode', val: rt.call_function('current_theme_supports', [
			rt.new_string('block-templates'),
		]) },
		rt.ArrayItem{ key: 'enableCustomFields', val: (rt.call_function('get_user_meta', [
			rt.call_function('get_current_user_id', []rt.PhpVal{}),
			rt.new_string('enable_custom_fields'),
			rt.new_bool(true),
		])).to_bool() },
	])
	mut iife_temp_3 := Class_WP_Block_Patterns_Registry{}
	mut iife_result_3 := iife_temp_3.get_instance()
	var_editor_settings.array_set('__experimentalAdditionalBlockPatterns', rt.call_method(iife_result_3,
		'get_all_registered', [rt.new_bool(true)]))
	mut iife_temp_4 := Class_WP_Block_Pattern_Categories_Registry{}
	mut iife_result_4 := iife_temp_4.get_instance()
	var_editor_settings.array_set('__experimentalAdditionalBlockPatternCategories', rt.call_method(iife_result_4,
		'get_all_registered', [rt.new_bool(true)]))
	mut var_autosave := rt.call_function('wp_get_post_autosave', [
		rt.get_property(var_post, 'ID'),
	])
	if rt.is_true(var_autosave) {
		if rt.is_true(rt.greater(rt.call_function('mysql2date', [
			rt.new_string('U'), rt.get_property(var_autosave, 'post_modified_gmt'),
			rt.new_bool(false)]), rt.call_function('mysql2date', [
			rt.new_string('U'), rt.get_property(var_post, 'post_modified_gmt'),
			rt.new_bool(false)])))
		{
			var_editor_settings.array_set('autosave', rt.create_array([
				rt.ArrayItem{ key: 'editLink', val: rt.call_function('get_edit_post_link', [
					rt.get_property(var_autosave, 'ID'),
				]) },
			]))
		} else {
			rt.call_function('wp_delete_post_revision', [
				rt.get_property(var_autosave, 'ID'),
			])
		}
	}
	if !(!rt.is_true(rt.get_property(var_post_type_object, 'template'))) {
		var_editor_settings.array_set('template', rt.get_property(var_post_type_object, 'template'))
		var_editor_settings.array_set('templateLock', if !(!rt.is_true(rt.get_property(var_post_type_object,
			'template_lock'))) {
			rt.get_property(var_post_type_object, 'template_lock')
		} else {
			rt.new_bool(false)
		})
	}
	if var_is_new_post && !(var_editor_settings.array_isset(rt.new_string('template')))
		&& rt.is_true(rt.identical(rt.new_string('post'), rt.get_property(var_post, 'post_type'))) {
		mut var_post_format := rt.call_function('get_post_format', [
			var_post.clone()])
		if rt.is_true(rt.call_function('in_array', [var_post_format.clone(),
			rt.create_array([rt.ArrayItem{ key: none, val: 'audio' },
				rt.ArrayItem{ key: none, val: 'gallery' }, rt.ArrayItem{ key: none, val: 'image' },
				rt.ArrayItem{ key: none, val: 'quote' }, rt.ArrayItem{ key: none, val: 'video' }]),
			rt.new_bool(true)]))
		{
			var_editor_settings.array_set('template', rt.create_array([
				rt.ArrayItem{ key: none, val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'core/${var_post_format.to_string()}' },
				]) },
			]))
		}
	}
	if rt.is_true(rt.call_function('wp_is_block_theme', []rt.PhpVal{}))
		&& rt.is_true(var_editor_settings.array_get(rt.new_string('supportsTemplateMode'))) {
		var_editor_settings.array_set('defaultTemplatePartAreas', rt.call_function('get_allowed_block_template_part_areas',
			[]rt.PhpVal{}))
	}
	rt.call_function('wp_enqueue_media', [
		rt.create_array([
			rt.ArrayItem{ key: 'post', val: rt.get_property(var_post, 'ID') },
		]),
	])
	rt.call_function('wp_tinymce_inline_scripts', []rt.PhpVal{})
	rt.call_function('wp_enqueue_editor', []rt.PhpVal{})
	rt.call_function('wp_enqueue_style', [rt.new_string('wp-edit-post')])
	rt.call_function('do_action', [rt.new_string('enqueue_block_editor_assets')])
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/meta-boxes.php', '4')
	rt.call_function('register_and_do_post_meta_boxes', [var_post.clone()])
	mut var_core_meta_boxes :=
		var_wp_meta_boxes.array_get(rt.get_property(var_current_screen, 'id')).array_get(rt.new_string('normal')).array_get(rt.new_string('core'))
	if !(var_core_meta_boxes.array_isset(rt.new_string('postcustom')))
		|| rt.is_true(rt.new_bool(!(rt.is_true(var_core_meta_boxes.array_get(rt.new_string('postcustom')))))) {
		var_editor_settings.array_unset(rt.new_string('enableCustomFields'))
	}
	var_editor_settings = rt.call_function('get_block_editor_settings', [
		var_editor_settings.clone(), var_block_editor_context])
	mut var_init_script := '( function() {\n\twindow._wpLoadBlockEditor = new Promise( function( resolve ) {\n\t\twp.domReady( function() {\n\t\t\tresolve( wp.editPost.initializeEditor( \'editor\', "%s", %d, %s, %s ) );\n\t\t} );\n\t} );\n} )();'
	var_script = rt.call_function('sprintf', [rt.new_string(var_init_script.str()).clone(),
		rt.get_property(var_post, 'post_type'), rt.get_property(var_post, 'ID'),
		rt.call_function('wp_json_encode', [var_editor_settings.clone(),
			rt.bitwise_or(rt.get_constant('JSON_HEX_TAG'),
				rt.get_constant('JSON_UNESCAPED_SLASHES'))]),
		rt.call_function('wp_json_encode', [rt.create_array_from_native_map(var_initial_edits),
			rt.bitwise_or(rt.get_constant('JSON_HEX_TAG'),
				rt.get_constant('JSON_UNESCAPED_SLASHES'))])])
	rt.call_function('wp_add_inline_script', [rt.new_string('wp-edit-post'),
		var_script.clone()])
	if rt.is_true(rt.identical(rt.new_int((rt.call_function('get_option', [
		rt.new_string('page_for_posts'),
	])).to_i64()), rt.get_property(var_post, 'ID')))
	{
		rt.call_function('add_action', [rt.new_string('admin_enqueue_scripts'),
			rt.new_string('_wp_block_editor_posts_page_notice')])
	}
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-header.php', '4')
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_title.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('the_block_editor_meta_boxes', []rt.PhpVal{})
	// unsupported statement: Stmt_InlineHTML
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_title.clone()]))
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.call_function('file_exists', [
		rt.new_string(
			(rt.get_constant('WP_PLUGIN_DIR')).str() + '/classic-editor/classic-editor.php'),
	]))
	{
		mut var_installed := true
		mut var_plugin_activate_url := rt.call_function('wp_nonce_url', [
			rt.new_string('plugins.php?action=activate&amp;plugin=classic-editor/classic-editor.php'),
			rt.new_string('activate-plugin_classic-editor/classic-editor.php'),
		])
		mut var_message := rt.call_function('sprintf', [
			rt.call_function('__', [
				rt.new_string('The block editor requires JavaScript. Please enable JavaScript in your browser settings, or activate the <a href="%s">Classic Editor plugin</a>.'),
			]),
			rt.call_function('esc_url', [
				var_plugin_activate_url.clone(),
			]),
		])
	} else {
		var_installed = false
		mut var_plugin_install_url := rt.call_function('wp_nonce_url', [
			rt.call_function('self_admin_url', [
				rt.new_string('update.php?action=install-plugin&plugin=classic-editor'),
			]),
			rt.new_string('install-plugin_classic-editor'),
		])
		var_message = rt.call_function('sprintf', [
			rt.call_function('__', [
				rt.new_string('The block editor requires JavaScript. Please enable JavaScript in your browser settings, or install the <a href="%s">Classic Editor plugin</a>.'),
			]),
			rt.call_function('esc_url', [
				var_plugin_install_url.clone(),
			]),
		])
	}
	var_message = rt.call_function('apply_filters', [
		rt.new_string('block_editor_no_javascript_message'),
		var_message.clone(),
		var_post.clone(),
		rt.new_bool(var_installed).clone(),
	])
	rt.call_function('wp_admin_notice', [var_message.clone(),
		rt.create_array([rt.ArrayItem{ key: 'type', val: 'error' }])])
	// unsupported statement: Stmt_InlineHTML
}
