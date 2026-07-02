import rt

fn _wp_get_site_editor_redirection_url() bool {
	mut var_pagenow := rt.new_null()
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('site-editor.php'), var_pagenow))))
		|| rt.get_superglobal('_REQUEST').array_isset(rt.new_string('p'))
		|| !rt.is_true(rt.get_superglobal('_SERVER').array_get(rt.new_string('QUERY_STRING'))) {
		return false
	}
	if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('postType'))
		&& rt.is_true(rt.identical(rt.new_string('wp_navigation'), rt.get_superglobal('_REQUEST').array_get(rt.new_string('postType'))))
		&& !(!rt.is_true(rt.get_superglobal('_REQUEST').array_get(rt.new_string('postId')))) {
		return (rt.call_function('add_query_arg', [
			rt.create_array([
				rt.ArrayItem{ key: 'p', val: '/wp_navigation/' +
					(rt.get_superglobal('_REQUEST').array_get(rt.new_string('postId'))).str() },
			]),
			rt.call_function('remove_query_arg', [
				rt.create_array([rt.ArrayItem{ key: none, val: 'postType' },
					rt.ArrayItem{ key: none, val: 'postId' }]),
			]),
		])).to_bool()
	}
	if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('postType'))
		&& rt.is_true(rt.identical(rt.new_string('wp_navigation'), rt.get_superglobal('_REQUEST').array_get(rt.new_string('postType'))))
		&& !rt.is_true(rt.get_superglobal('_REQUEST').array_get(rt.new_string('postId'))) {
		return (rt.call_function('add_query_arg', [
			rt.create_array([rt.ArrayItem{ key: 'p', val: '/navigation' }]),
			rt.call_function('remove_query_arg', [rt.new_string('postType')]),
		])).to_bool()
	}
	if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('path'))
		&& rt.is_true(rt.identical(rt.new_string('/wp_global_styles'), rt.get_superglobal('_REQUEST').array_get(rt.new_string('path')))) {
		return (rt.call_function('add_query_arg', [
			rt.create_array([rt.ArrayItem{ key: 'p', val: '/styles' }]),
			rt.call_function('remove_query_arg', [rt.new_string('path')]),
		])).to_bool()
	}
	if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('postType'))
		&& rt.is_true(rt.identical(rt.new_string('page'), rt.get_superglobal('_REQUEST').array_get(rt.new_string('postType'))))
		&& !rt.is_true(rt.get_superglobal('_REQUEST').array_get(rt.new_string('canvas')))
		|| !rt.is_true(rt.get_superglobal('_REQUEST').array_get(rt.new_string('postId'))) {
		return (rt.call_function('add_query_arg', [
			rt.create_array([rt.ArrayItem{ key: 'p', val: '/page' }]),
			rt.call_function('remove_query_arg', [rt.new_string('postType')]),
		])).to_bool()
	}
	if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('postType'))
		&& rt.is_true(rt.identical(rt.new_string('page'), rt.get_superglobal('_REQUEST').array_get(rt.new_string('postType'))))
		&& !(!rt.is_true(rt.get_superglobal('_REQUEST').array_get(rt.new_string('postId')))) {
		return (rt.call_function('add_query_arg', [
			rt.create_array([
				rt.ArrayItem{ key: 'p', val: '/page/' +
					(rt.get_superglobal('_REQUEST').array_get(rt.new_string('postId'))).str() },
			]),
			rt.call_function('remove_query_arg', [
				rt.create_array([rt.ArrayItem{ key: none, val: 'postType' },
					rt.ArrayItem{ key: none, val: 'postId' }]),
			]),
		])).to_bool()
	}
	if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('postType'))
		&& rt.is_true(rt.identical(rt.new_string('wp_template'), rt.get_superglobal('_REQUEST').array_get(rt.new_string('postType'))))
		&& !rt.is_true(rt.get_superglobal('_REQUEST').array_get(rt.new_string('canvas')))
		|| !rt.is_true(rt.get_superglobal('_REQUEST').array_get(rt.new_string('postId'))) {
		return (rt.call_function('add_query_arg', [
			rt.create_array([rt.ArrayItem{ key: 'p', val: '/template' }]),
			rt.call_function('remove_query_arg', [rt.new_string('postType')]),
		])).to_bool()
	}
	if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('postType'))
		&& rt.is_true(rt.identical(rt.new_string('wp_template'), rt.get_superglobal('_REQUEST').array_get(rt.new_string('postType'))))
		&& !(!rt.is_true(rt.get_superglobal('_REQUEST').array_get(rt.new_string('postId')))) {
		return (rt.call_function('add_query_arg', [
			rt.create_array([
				rt.ArrayItem{ key: 'p', val: '/wp_template/' +
					(rt.get_superglobal('_REQUEST').array_get(rt.new_string('postId'))).str() },
			]),
			rt.call_function('remove_query_arg', [
				rt.create_array([rt.ArrayItem{ key: none, val: 'postType' },
					rt.ArrayItem{ key: none, val: 'postId' }]),
			]),
		])).to_bool()
	}
	if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('postType'))
		&& rt.is_true(rt.identical(rt.new_string('wp_block'), rt.get_superglobal('_REQUEST').array_get(rt.new_string('postType'))))
		&& !rt.is_true(rt.get_superglobal('_REQUEST').array_get(rt.new_string('canvas')))
		|| !rt.is_true(rt.get_superglobal('_REQUEST').array_get(rt.new_string('postId'))) {
		return (rt.call_function('add_query_arg', [
			rt.create_array([rt.ArrayItem{ key: 'p', val: '/pattern' }]),
			rt.call_function('remove_query_arg', [rt.new_string('postType')]),
		])).to_bool()
	}
	if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('postType'))
		&& rt.is_true(rt.identical(rt.new_string('wp_block'), rt.get_superglobal('_REQUEST').array_get(rt.new_string('postType'))))
		&& !(!rt.is_true(rt.get_superglobal('_REQUEST').array_get(rt.new_string('postId')))) {
		return (rt.call_function('add_query_arg', [
			rt.create_array([
				rt.ArrayItem{ key: 'p', val: '/wp_block/' +
					(rt.get_superglobal('_REQUEST').array_get(rt.new_string('postId'))).str() },
			]),
			rt.call_function('remove_query_arg', [
				rt.create_array([rt.ArrayItem{ key: none, val: 'postType' },
					rt.ArrayItem{ key: none, val: 'postId' }]),
			]),
		])).to_bool()
	}
	if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('postType'))
		&& rt.is_true(rt.identical(rt.new_string('wp_template_part'), rt.get_superglobal('_REQUEST').array_get(rt.new_string('postType'))))
		&& !rt.is_true(rt.get_superglobal('_REQUEST').array_get(rt.new_string('canvas')))
		|| !rt.is_true(rt.get_superglobal('_REQUEST').array_get(rt.new_string('postId'))) {
		return (rt.call_function('add_query_arg', [
			rt.create_array([rt.ArrayItem{ key: 'p', val: '/pattern' }]),
		])).to_bool()
	}
	if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('postType'))
		&& rt.is_true(rt.identical(rt.new_string('wp_template_part'), rt.get_superglobal('_REQUEST').array_get(rt.new_string('postType'))))
		&& !(!rt.is_true(rt.get_superglobal('_REQUEST').array_get(rt.new_string('postId')))) {
		return (rt.call_function('add_query_arg', [
			rt.create_array([
				rt.ArrayItem{ key: 'p', val: '/wp_template_part/' +
					(rt.get_superglobal('_REQUEST').array_get(rt.new_string('postId'))).str() },
			]),
			rt.call_function('remove_query_arg', [
				rt.create_array([rt.ArrayItem{ key: none, val: 'postType' },
					rt.ArrayItem{ key: none, val: 'postId' }]),
			]),
		])).to_bool()
	}
	if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('path'))
		&& rt.is_true(rt.identical(rt.new_string('/wp_template_part/all'), rt.get_superglobal('_REQUEST').array_get(rt.new_string('path')))) {
		return (rt.call_function('add_query_arg', [
			rt.create_array([rt.ArrayItem{ key: 'p', val: '/pattern' },
				rt.ArrayItem{ key: 'postType', val: 'wp_template_part' }]),
			rt.call_function('remove_query_arg', [rt.new_string('path')]),
		])).to_bool()
	}
	if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('path'))
		&& rt.is_true(rt.identical(rt.new_string('/page'), rt.get_superglobal('_REQUEST').array_get(rt.new_string('path')))) {
		return (rt.call_function('add_query_arg', [
			rt.create_array([rt.ArrayItem{ key: 'p', val: '/page' }]),
			rt.call_function('remove_query_arg', [rt.new_string('path')]),
		])).to_bool()
	}
	if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('path'))
		&& rt.is_true(rt.identical(rt.new_string('/wp_template'), rt.get_superglobal('_REQUEST').array_get(rt.new_string('path')))) {
		return (rt.call_function('add_query_arg', [
			rt.create_array([rt.ArrayItem{ key: 'p', val: '/template' }]),
			rt.call_function('remove_query_arg', [rt.new_string('path')]),
		])).to_bool()
	}
	if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('path'))
		&& rt.is_true(rt.identical(rt.new_string('/patterns'), rt.get_superglobal('_REQUEST').array_get(rt.new_string('path')))) {
		return (rt.call_function('add_query_arg', [
			rt.create_array([rt.ArrayItem{ key: 'p', val: '/pattern' }]),
			rt.call_function('remove_query_arg', [rt.new_string('path')]),
		])).to_bool()
	}
	if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('path'))
		&& rt.is_true(rt.identical(rt.new_string('/navigation'), rt.get_superglobal('_REQUEST').array_get(rt.new_string('path')))) {
		return (rt.call_function('add_query_arg', [
			rt.create_array([rt.ArrayItem{ key: 'p', val: '/navigation' }]),
			rt.call_function('remove_query_arg', [rt.new_string('path')]),
		])).to_bool()
	}
	return (rt.call_function('add_query_arg', [
		rt.create_array([rt.ArrayItem{ key: 'p', val: '/' }]),
	])).to_bool()
}

struct Class_WP_Block_Editor_Context {
	rt.PhpObjectBase
}

struct Class_WP_Block_Patterns_Registry {
	rt.PhpObjectBase
}

struct Class_WP_Block_Pattern_Categories_Registry {
	rt.PhpObjectBase
}

struct Class_WP_Theme_JSON_Resolver {
	rt.PhpObjectBase
}

fn create_wp_block_editor_context(_args ...rt.PhpVal) &Class_WP_Block_Editor_Context {
	mut obj := &Class_WP_Block_Editor_Context{
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

fn create_wp_theme_json_resolver(_args ...rt.PhpVal) &Class_WP_Theme_JSON_Resolver {
	mut obj := &Class_WP_Theme_JSON_Resolver{
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

fn (mut this Class_WP_Theme_JSON_Resolver) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Theme_JSON_Resolver) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Theme_JSON_Resolver) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_editor_styles := rt.new_null()
	mut var_matches := []rt.PhpVal{}
	mut var_post := rt.new_null()
	rt.include_file(@DIR + '/admin.php', '4')
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('edit_theme_options'),
	])))))
	{
		rt.call_function('wp_die', [
			rt.new_string('<h1>' +
				(rt.call_function('__', [rt.new_string('You need a higher level of permission.')])).str() +
				'</h1>' + '<p>' +
				(rt.call_function('__', [rt.new_string('Sorry, you are not allowed to edit theme options on this site.')])).str() +
				'</p>'),
			rt.new_int(403),
		])
	}
	mut var_redirection := _wp_get_site_editor_redirection_url()
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false),
		rt.new_bool(var_redirection)))))
	{
		rt.call_function('wp_safe_redirect', [rt.new_bool(var_redirection).clone()])
		exit(0)
	}
	mut var_title := rt.call_function('_x', [rt.new_string('Editor'),
		rt.new_string('site editor title tag')])
	mut var_parent_file := 'themes.php'
	mut var_current_screen := rt.call_function('get_current_screen', []rt.PhpVal{})
	rt.call_method(var_current_screen, 'is_block_editor', [rt.new_bool(true)])
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_classes := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.new_string('${var_classes.to_string()} is-fullscreen-mode')
	}
	rt.call_function('add_filter', [rt.new_string('admin_body_class'),
		rt.new_closure(closure_1_fn)])
	mut var_indexed_template_types := []rt.PhpVal{}
	mut iter_1 := rt.call_function('get_default_block_template_types', []rt.PhpVal{}).iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_template_type := item_1.val
		mut var_slug := item_1.key
		var_template_type.array_set('slug', var_slug.str())
		var_indexed_template_types << var_template_type.clone()
	}
	mut var_context_settings := {
		'name': rt.new_string('core/edit-site')
	}
	if !(!rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('postId'))))
		&& rt.get_superglobal('_GET').array_get(rt.new_string('postId')).is_long()
		|| rt.get_superglobal('_GET').array_get(rt.new_string('postId')).is_double() {
		var_context_settings['post'] = rt.call_function('get_post', [
			rt.new_int((rt.get_superglobal('_GET').array_get(rt.new_string('postId'))).to_i64()),
		])
	} else if rt.get_superglobal('_GET').array_isset(rt.new_string('p'))
		&& rt.is_true(rt.call_function('preg_match', [rt.new_string('/^\\/page\\/(\\d+)$/'), rt.get_superglobal('_GET').array_get(rt.new_string('p')), rt.create_array_from_list(var_matches)])) {
		var_context_settings['post'] = rt.call_function('get_post', [
			rt.new_int((var_matches[1]).to_i64()),
		])
	}
	mut var_block_editor_context := create_wp_block_editor_context(var_context_settings.clone())
	mut var_custom_settings := {
		'siteUrl':                   rt.call_function('site_url', []rt.PhpVal{})
		'postsPerPage':              rt.call_function('get_option', [
			rt.new_string('posts_per_page'),
		])
		'styles':                    rt.call_function('get_block_editor_theme_styles',
			[]rt.PhpVal{})
		'defaultTemplateTypes':      var_indexed_template_types
		'defaultTemplatePartAreas':  rt.call_function('get_allowed_block_template_part_areas',
			[]rt.PhpVal{})
		'supportsLayout':            rt.call_function('wp_theme_has_theme_json', []rt.PhpVal{})
		'supportsTemplatePartsMode': rt.new_bool(
			rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_is_block_theme', []rt.PhpVal{})))))
			&& rt.is_true(rt.call_function('current_theme_supports', [rt.new_string('block-template-parts')])))
	}
	mut iife_temp_1 := Class_WP_Block_Patterns_Registry{}
	mut iife_result_1 := iife_temp_1.get_instance()
	var_custom_settings['__experimentalAdditionalBlockPatterns'] = rt.call_method(iife_result_1,
		'get_all_registered', [rt.new_bool(true)])
	mut iife_temp_2 := Class_WP_Block_Pattern_Categories_Registry{}
	mut iife_result_2 := iife_temp_2.get_instance()
	var_custom_settings['__experimentalAdditionalBlockPatternCategories'] = rt.call_method(iife_result_2,
		'get_all_registered', [rt.new_bool(true)])
	mut var_editor_settings := rt.call_function('get_block_editor_settings', [
		rt.create_array_from_native_map(var_custom_settings),
		var_block_editor_context,
	])
	if rt.get_superglobal('_GET').array_isset(rt.new_string('postType'))
		&& !(rt.get_superglobal('_GET').array_isset(rt.new_string('postId'))) {
		mut var_post_type := rt.call_function('get_post_type_object', [
			rt.get_superglobal('_GET').array_get(rt.new_string('postType')),
		])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_post_type)))) {
			rt.call_function('wp_die', [
				rt.call_function('__', [rt.new_string('Invalid post type.')]),
			])
		}
	}
	mut iife_temp_3 := Class_WP_Theme_JSON_Resolver{}
	mut iife_result_3 := iife_temp_3.get_user_global_styles_post_id()
	mut var_active_global_styles_id := iife_result_3
	mut var_active_theme := rt.call_function('get_stylesheet', []rt.PhpVal{})
	mut var_navigation_rest_route := rt.call_function('rest_get_route_for_post_type_items', [
		rt.new_string('wp_navigation'),
	])
	mut var_preload_paths := [
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
		rt.new_string('/wp/v2/types?context=view'),
		rt.new_string('/wp/v2/types/wp_template?context=edit'),
		rt.new_string('/wp/v2/types/wp_template_part?context=edit'),
		rt.new_string('/wp/v2/templates?context=edit&per_page=-1'),
		rt.new_string('/wp/v2/template-parts?context=edit&per_page=-1'),
		rt.new_string('/wp/v2/themes?context=edit&status=active'),
		'/wp/v2/global-styles/' + var_active_global_styles_id.str() + '?context=edit',
		[
			'/wp/v2/global-styles/' + var_active_global_styles_id.str(),
			rt.new_string('OPTIONS'),
		],
		'/wp/v2/global-styles/themes/' + var_active_theme.str() + '?context=view',
		'/wp/v2/global-styles/themes/' + var_active_theme.str() + '/variations?context=view',
		[
			var_navigation_rest_route,
			rt.new_string('OPTIONS'),
		],
		[
			rt.call_function('add_query_arg', [
				[rt.new_string('edit'), rt.new_int(100), rt.new_string('desc'),
					rt.new_string('date'), rt.new_string('publish'),
					rt.new_string('draft')],
				var_navigation_rest_route.clone(),
			]),
			rt.new_string('GET'),
		],
		rt.new_string('/wp/v2/settings'),
		[
			rt.new_string('/wp/v2/settings'),
			rt.new_string('OPTIONS'),
		],
		rt.new_string('/wp/v2/block-patterns/categories'),
		'/?_fields=' +(rt.call_function('implode', [rt.new_string(','), [rt.new_string('description'), rt.new_string('gmt_offset'), rt.new_string('home'), rt.new_string('image_sizes'), rt.new_string('image_size_threshold'), rt.new_string('image_output_formats'), rt.new_string('jpeg_interlaced'), rt.new_string('png_interlaced'), rt.new_string('gif_interlaced'), rt.new_string('name'), rt.new_string('site_icon'), rt.new_string('site_icon_url'), rt.new_string('site_logo'), rt.new_string('timezone_string'), rt.new_string('url'), rt.new_string('page_for_posts'), rt.new_string('page_on_front'), rt.new_string('show_on_front')]])).str(),
	]
	if rt.is_true(rt.get_property(var_block_editor_context, 'post')) {
		mut var_route_for_post := rt.call_function('rest_get_route_for_post', [
			rt.get_property(var_block_editor_context, 'post'),
		])
		if rt.is_true(var_route_for_post) {
			var_preload_paths << rt.call_function('add_query_arg', [
				rt.new_string('context'),
				rt.new_string('edit'),
				var_route_for_post.clone(),
			])
			if rt.is_true(rt.identical(rt.new_string('page'), rt.get_property(rt.get_property(var_block_editor_context,
				'post'), 'post_type')))
			{
				var_preload_paths << rt.call_function('add_query_arg', [
					rt.new_string('slug'),
					rt.new_string((if !rt.is_true(rt.get_property(rt.get_property(var_block_editor_context,
						'post'), 'post_name')) {
						'page'
					} else {
						'page-' +(rt.get_property(rt.get_property(var_block_editor_context, 'post'), 'post_name')).str()
					}).str()),
					rt.new_string('/wp/v2/templates/lookup'),
				])
			}
		}
	} else {
		var_preload_paths << rt.new_string('/wp/v2/templates/lookup?slug=front-page')
		var_preload_paths << rt.new_string('/wp/v2/templates/lookup?slug=home')
	}
	rt.call_function('block_editor_rest_api_preload', [
		rt.create_array_from_list(var_preload_paths),
		var_block_editor_context,
	])
	rt.call_function('wp_add_inline_script', [rt.new_string('wp-edit-site'),
		rt.call_function('sprintf', [
			rt.new_string('wp.domReady( function() {\n\t\t\twp.editSite.initializeEditor( "site-editor", %s );\n\t\t} );'),
			rt.call_function('wp_json_encode', [var_editor_settings.clone(),
				rt.bitwise_or(rt.get_constant('JSON_HEX_TAG'),
					rt.get_constant('JSON_UNESCAPED_SLASHES'))]),
		])])
	rt.call_function('wp_add_inline_script', [rt.new_string('wp-blocks'),
		rt.new_string('wp.blocks.unstable__bootstrapServerSideBlockDefinitions(' +
			(rt.call_function('wp_json_encode', [rt.call_function('get_block_editor_server_block_settings', []rt.PhpVal{}), rt.bitwise_or(rt.get_constant('JSON_HEX_TAG'), rt.get_constant('JSON_UNESCAPED_SLASHES'))])).str() +
			');')])
	mut var_registered_sources := rt.call_function('get_all_registered_block_bindings_sources',
		[]rt.PhpVal{})
	if !(!rt.is_true(var_registered_sources)) {
		mut var_filtered_sources := []rt.PhpVal{}
		mut iter_2 := var_registered_sources.iterator()
		for {
			item_2 := iter_2.next() or { break }
			mut var_source := item_2.val
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
	rt.call_function('wp_add_inline_script', [rt.new_string('wp-blocks'),
		rt.call_function('sprintf', [rt.new_string('wp.blocks.setCategories( %s );'),
			rt.call_function('wp_json_encode', [if !(var_editor_settings.array_get(rt.new_string('blockCategories'))).is_null() {
				var_editor_settings.array_get(rt.new_string('blockCategories'))
			} else {
				[]rt.PhpVal{}
			}, rt.bitwise_or(rt.get_constant('JSON_HEX_TAG'),
				rt.get_constant('JSON_UNESCAPED_SLASHES'))])]),
		rt.new_string('after')])
	rt.call_function('wp_enqueue_script', [rt.new_string('wp-edit-site')])
	rt.call_function('wp_enqueue_script', [rt.new_string('wp-format-library')])
	rt.call_function('wp_enqueue_style', [rt.new_string('wp-edit-site')])
	rt.call_function('wp_enqueue_style', [rt.new_string('wp-format-library')])
	rt.call_function('wp_enqueue_media', []rt.PhpVal{})
	if rt.is_true(rt.call_function('current_theme_supports', [rt.new_string('wp-block-styles')]))
		&& !(var_editor_styles.clone().is_array())
		|| var_editor_styles.clone().array_count() == 0 {
		rt.call_function('wp_enqueue_style', [rt.new_string('wp-block-library-theme')])
	}
	rt.call_function('do_action', [rt.new_string('enqueue_block_editor_assets')])
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-header.php', '4')
	// unsupported statement: Stmt_InlineHTML
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Edit Site')])
	// unsupported statement: Stmt_InlineHTML
	mut var_message := rt.call_function('apply_filters', [
		rt.new_string('site_editor_no_javascript_message'),
		rt.call_function('__', [
			rt.new_string('The site editor requires JavaScript. Please enable JavaScript in your browser settings.'),
		]),
		var_post.clone(),
	])
	rt.call_function('wp_admin_notice', [var_message.clone(),
		rt.create_array([rt.ArrayItem{ key: 'type', val: 'error' },
			rt.ArrayItem{ key: 'additional_classes', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'hide-if-js' },
			]) }])])
	// unsupported statement: Stmt_InlineHTML
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-footer.php', '4')
}
