import rt

fn delete_theme(var_stylesheet rt.PhpVal, redirect string) rt.PhpVal {
	mut var_redirect := redirect
	mut var_wp_filesystem := rt.new_null()
	mut var_credentials := rt.new_null()
	mut var_data := rt.new_null()
	mut var_themes_dir := rt.new_null()
	mut var_theme := rt.new_null()
	mut var_theme_dir := rt.new_null()
	mut var_deleted := rt.new_null()
	mut var_theme_translations := rt.new_null()
	mut var_translations := rt.new_null()
	mut var_translation := rt.new_null()
	mut var_json_translation_files := rt.new_null()
	if !rt.is_true(var_stylesheet) {
		return rt.new_bool(false)
	}
	if var_redirect == '' {
		var_redirect = (rt.call_function('wp_nonce_url', [
			rt.new_string('themes.php?action=delete&stylesheet=' +
				(rt.call_function('urlencode', [var_stylesheet.clone()])).str()),
			rt.new_string('delete-theme_' + var_stylesheet.str()),
		])).str()
	}
	rt.call_function('ob_start', []rt.PhpVal{})
	var_credentials = rt.call_function('request_filesystem_credentials', [
		rt.new_string(var_redirect.str()),
	])
	var_data = rt.call_function('ob_get_clean', []rt.PhpVal{})
	if rt.is_true(rt.identical(rt.new_bool(false), var_credentials)) {
		if !(!rt.is_true(var_data)) {
			rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-header.php', '4')
			rt.echo_val(var_data)
			rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-footer.php', '4')
			exit(0)
		}
		return rt.new_null()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('WP_Filesystem', [
		var_credentials.clone()])))))
	{
		rt.call_function('ob_start', []rt.PhpVal{})
		rt.call_function('request_filesystem_credentials', [
			rt.new_string(var_redirect.str()),
			rt.new_string(''),
			rt.new_bool(true),
		])
		var_data = rt.call_function('ob_get_clean', []rt.PhpVal{})
		if !(!rt.is_true(var_data)) {
			rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-header.php', '4')
			rt.echo_val(var_data)
			rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-footer.php', '4')
			exit(0)
		}
		return rt.new_null()
	}
	if !(var_wp_filesystem.clone().is_object()) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('fs_unavailable'), rt.call_function('__', [
			rt.new_string('Could not access filesystem.'),
		])))
	}
	if rt.is_true(rt.call_function('is_wp_error', [rt.get_property(var_wp_filesystem, 'errors')]))
		&& rt.is_true(rt.call_method(rt.get_property(var_wp_filesystem, 'errors'), 'has_errors', []rt.PhpVal{})) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('fs_error'), rt.call_function('__', [
			rt.new_string('Filesystem error.'),
		]), rt.get_property(var_wp_filesystem, 'errors')))
	}
	var_themes_dir = rt.call_method(var_wp_filesystem, 'wp_themes_dir', []rt.PhpVal{})
	if !rt.is_true(var_themes_dir) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('fs_no_themes_dir'), rt.call_function('__', [
			rt.new_string('Unable to locate WordPress theme directory.'),
		])))
	}
	rt.call_function('do_action', [rt.new_string('delete_theme'),
		var_stylesheet.clone()])
	var_theme = rt.call_function('wp_get_theme', [var_stylesheet.clone()])
	var_themes_dir = rt.call_function('trailingslashit', [var_themes_dir.clone()])
	var_theme_dir = rt.call_function('trailingslashit', [
		rt.new_string(var_themes_dir.str() + var_stylesheet.str()),
	])
	var_deleted = rt.call_method(var_wp_filesystem, 'delete', [
		var_theme_dir.clone(), rt.new_bool(true)])
	rt.call_function('do_action', [rt.new_string('deleted_theme'),
		var_stylesheet.clone(), var_deleted.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_deleted)))) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('could_not_remove_theme'), rt.call_function('sprintf', [
			rt.call_function('__', [
				rt.new_string('Could not fully remove the theme %s.'),
			]),
			var_stylesheet.clone(),
		])))
	}
	var_theme_translations = rt.call_function('wp_get_installed_translations', [
		rt.new_string('themes'),
	])
	if !(!rt.is_true(var_theme_translations.array_get(var_stylesheet))) {
		var_translations = var_theme_translations.array_get(var_stylesheet)
		mut iter_1 := var_translations.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_data_shadow := item_1.val
			mut var_translation_shadow := item_1.key
			rt.call_method(var_wp_filesystem, 'delete', [
				rt.new_string(
					(rt.get_constant('WP_LANG_DIR')).str() + '/themes/' + var_stylesheet.str() +
					'-' + var_translation_shadow.str() + '.po'),
			])
			rt.call_method(var_wp_filesystem, 'delete', [
				rt.new_string(
					(rt.get_constant('WP_LANG_DIR')).str() + '/themes/' + var_stylesheet.str() +
					'-' + var_translation_shadow.str() + '.mo'),
			])
			rt.call_method(var_wp_filesystem, 'delete', [
				rt.new_string(
					(rt.get_constant('WP_LANG_DIR')).str() + '/themes/' + var_stylesheet.str() +
					'-' + var_translation_shadow.str() + '.l10n.php'),
			])
			var_json_translation_files = rt.call_function('glob', [
				rt.new_string(
					(rt.get_constant('WP_LANG_DIR')).str() + '/themes/' + var_stylesheet.str() +
					'-' + var_translation_shadow.str() + '-*.json'),
			])
			if rt.is_true(var_json_translation_files) {
				rt.call_function('array_map', [
					rt.create_array([rt.ArrayItem{ key: none, val: var_wp_filesystem },
						rt.ArrayItem{ key: none, val: 'delete' }]),
					var_json_translation_files.clone(),
				])
			}
		}
	}
	if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) {
		mut iife_temp_0 := Class_WP_Theme{}
		mut iife_result_0 := iife_temp_0.network_disable_theme(var_stylesheet.clone())
	}
	rt.call_method(var_theme, 'cache_delete', []rt.PhpVal{})
	rt.call_function('delete_site_transient', [rt.new_string('update_themes')])
	return rt.new_bool(true)
}

fn get_page_templates(var_post rt.PhpVal, post_type string) rt.PhpVal {
	mut var_post_type := post_type
	return rt.call_function('array_flip', [
		rt.call_method(rt.call_function('wp_get_theme', []rt.PhpVal{}), 'get_page_templates', [
			var_post.clone(),
			rt.new_string(post_type),
		]),
	])
}

fn _get_template_edit_filename(var_fullpath rt.PhpVal, var_containingfolder rt.PhpVal) rt.PhpVal {
	return rt.call_function('str_replace', [
		rt.call_function('dirname', [var_containingfolder.clone(),
			rt.new_int(2)]),
		rt.new_string(''),
		var_fullpath.clone(),
	])
}

fn theme_update_available(var_theme rt.PhpVal) {
	rt.echo_val(rt.new_bool(get_theme_update_available(var_theme.clone())))
}

fn get_theme_update_available(var_theme rt.PhpVal) bool {
	mut var_themes_update := rt.new_null()
	mut var_stylesheet := rt.new_null()
	mut var_html := rt.new_null()
	mut var_update := rt.new_null()
	mut var_theme_name := rt.new_null()
	mut var_details_url := rt.new_null()
	mut var_update_url := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('update_themes'),
	])))))
	{
		return false
	}
	if !(!var_themes_update.is_null()) {
		var_themes_update = rt.call_function('get_site_transient', [
			rt.new_string('update_themes'),
		])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_theme, 'WP_Theme')))))) {
		return false
	}
	var_stylesheet = rt.call_method(var_theme, 'get_stylesheet', []rt.PhpVal{})
	var_html = rt.new_string('')
	if rt.get_property(var_themes_update, 'response').array_isset(var_stylesheet) {
		var_update = rt.get_property(var_themes_update, 'response').array_get(var_stylesheet)
		var_theme_name = rt.call_method(var_theme, 'display', [
			rt.new_string('Name')])
		var_details_url = rt.call_function('add_query_arg', [
			rt.create_array([rt.ArrayItem{ key: 'TB_iframe', val: 'true' },
				rt.ArrayItem{ key: 'width', val: 1024 }, rt.ArrayItem{ key: 'height', val: 800 }]),
			var_update.array_get(rt.new_string('url')),
		])
		var_update_url = rt.call_function('wp_nonce_url', [
			rt.call_function('admin_url', [
				rt.new_string('update.php?action=upgrade-theme&amp;theme=' +
					(rt.call_function('urlencode', [var_stylesheet.clone()])).str()),
			]),
			rt.new_string('upgrade-theme_' + var_stylesheet.str()),
		])
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{}))))) {
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
				rt.new_string('update_themes'),
			])))))
			{
				var_html = rt.call_function('sprintf', [
					rt.new_string('<p><strong>' +
						(rt.call_function('__', [rt.new_string('There is a new version of %1$s available. <a href="%2$s" %3$s>View version %4$s details</a>.')])).str() +
						'</strong></p>'),
					var_theme_name.clone(),
					rt.call_function('esc_url', [
						var_details_url.clone(),
					]),
					rt.call_function('sprintf', [
						rt.new_string('class="thickbox open-plugin-details-modal" aria-label="%s"'),
						rt.call_function('esc_attr', [
							rt.call_function('sprintf', [
								rt.call_function('__', [
									rt.new_string('View %1$s version %2$s details'),
								]),
								var_theme_name.clone(),
								var_update.array_get(rt.new_string('new_version')),
							]),
						]),
					]),
					var_update.array_get(rt.new_string('new_version')),
				])
			} else if !rt.is_true(var_update.array_get(rt.new_string('package'))) {
				var_html = rt.call_function('sprintf', [
					rt.new_string('<p><strong>' +
						(rt.call_function('__', [rt.new_string('There is a new version of %1$s available. <a href="%2$s" %3$s>View version %4$s details</a>. <em>Automatic update is unavailable for this theme.</em>')])).str() +
						'</strong></p>'),
					var_theme_name.clone(),
					rt.call_function('esc_url', [
						var_details_url.clone(),
					]),
					rt.call_function('sprintf', [
						rt.new_string('class="thickbox open-plugin-details-modal" aria-label="%s"'),
						rt.call_function('esc_attr', [
							rt.call_function('sprintf', [
								rt.call_function('__', [
									rt.new_string('View %1$s version %2$s details'),
								]),
								var_theme_name.clone(),
								var_update.array_get(rt.new_string('new_version')),
							]),
						]),
					]),
					var_update.array_get(rt.new_string('new_version')),
				])
			} else {
				var_html = rt.call_function('sprintf', [
					rt.new_string('<p><strong>' +
						(rt.call_function('__', [rt.new_string('There is a new version of %1$s available. <a href="%2$s" %3$s>View version %4$s details</a> or <a href="%5$s" %6$s>update now</a>.')])).str() +
						'</strong></p>'),
					var_theme_name.clone(),
					rt.call_function('esc_url', [
						var_details_url.clone(),
					]),
					rt.call_function('sprintf', [
						rt.new_string('class="thickbox open-plugin-details-modal" aria-label="%s"'),
						rt.call_function('esc_attr', [
							rt.call_function('sprintf', [
								rt.call_function('__', [
									rt.new_string('View %1$s version %2$s details'),
								]),
								var_theme_name.clone(),
								var_update.array_get(rt.new_string('new_version')),
							]),
						]),
					]),
					var_update.array_get(rt.new_string('new_version')),
					var_update_url.clone(),
					rt.call_function('sprintf', [
						rt.new_string('aria-label="%s" id="update-theme" data-slug="%s"'),
						rt.call_function('esc_attr', [
							rt.call_function('sprintf', [
								rt.call_function('_x', [
									rt.new_string('Update %s now'),
									rt.new_string('theme'),
								]),
								var_theme_name.clone(),
							]),
						]),
						var_stylesheet.clone(),
					]),
				])
			}
		}
	}
	return var_html.to_bool()
}

fn get_theme_feature_list(api bool) rt.PhpVal {
	mut var_api := api
	mut var_features := rt.new_null()
	mut var_feature_list := rt.new_null()
	mut var_category_translations := rt.new_null()
	mut var_wporg_features := rt.new_null()
	mut var_feature_items := rt.new_null()
	mut var_feature_category := rt.new_null()
	mut var_feature := rt.new_null()
	var_features = rt.create_array([
		rt.ArrayItem{ key: rt.call_function('__', [rt.new_string('Subject')]), val: rt.create_array([
			rt.ArrayItem{ key: 'blog', val: rt.call_function('__', [
				rt.new_string('Blog'),
			]) }, rt.ArrayItem{ key: 'e-commerce', val: rt.call_function('__', [
				rt.new_string('E-Commerce'),
			]) }, rt.ArrayItem{ key: 'education', val: rt.call_function('__', [
				rt.new_string('Education'),
			]) }, rt.ArrayItem{ key: 'entertainment', val: rt.call_function('__', [
				rt.new_string('Entertainment'),
			]) }, rt.ArrayItem{ key: 'food-and-drink', val: rt.call_function('__', [
				rt.new_string('Food & Drink'),
			]) }, rt.ArrayItem{ key: 'holiday', val: rt.call_function('__', [
				rt.new_string('Holiday'),
			]) }, rt.ArrayItem{ key: 'news', val: rt.call_function('__', [
				rt.new_string('News'),
			]) }, rt.ArrayItem{ key: 'photography', val: rt.call_function('__', [
				rt.new_string('Photography'),
			]) }, rt.ArrayItem{ key: 'portfolio', val: rt.call_function('__', [
				rt.new_string('Portfolio'),
			]) }]) },
		rt.ArrayItem{ key: rt.call_function('__', [rt.new_string('Features')]), val: rt.create_array([
			rt.ArrayItem{ key: 'accessibility-ready', val: rt.call_function('__', [
				rt.new_string('Accessibility Ready'),
			]) }, rt.ArrayItem{ key: 'block-patterns', val: rt.call_function('__', [
				rt.new_string('Block Editor Patterns'),
			]) }, rt.ArrayItem{ key: 'block-styles', val: rt.call_function('__', [
				rt.new_string('Block Editor Styles'),
			]) }, rt.ArrayItem{ key: 'custom-background', val: rt.call_function('__', [
				rt.new_string('Custom Background'),
			]) }, rt.ArrayItem{ key: 'custom-colors', val: rt.call_function('__', [
				rt.new_string('Custom Colors'),
			]) }, rt.ArrayItem{ key: 'custom-header', val: rt.call_function('__', [
				rt.new_string('Custom Header'),
			]) }, rt.ArrayItem{ key: 'custom-logo', val: rt.call_function('__', [
				rt.new_string('Custom Logo'),
			]) }, rt.ArrayItem{ key: 'editor-style', val: rt.call_function('__', [
				rt.new_string('Editor Style'),
			]) }, rt.ArrayItem{ key: 'featured-image-header', val: rt.call_function('__', [
				rt.new_string('Featured Image Header'),
			]) }, rt.ArrayItem{ key: 'featured-images', val: rt.call_function('__', [
				rt.new_string('Featured Images'),
			]) }, rt.ArrayItem{ key: 'footer-widgets', val: rt.call_function('__', [
				rt.new_string('Footer Widgets'),
			]) }, rt.ArrayItem{ key: 'full-site-editing', val: rt.call_function('__', [
				rt.new_string('Site Editor'),
			]) }, rt.ArrayItem{ key: 'full-width-template', val: rt.call_function('__', [
				rt.new_string('Full Width Template'),
			]) }, rt.ArrayItem{ key: 'post-formats', val: rt.call_function('__', [
				rt.new_string('Post Formats'),
			]) }, rt.ArrayItem{ key: 'sticky-post', val: rt.call_function('__', [
				rt.new_string('Sticky Post'),
			]) }, rt.ArrayItem{ key: 'style-variations', val: rt.call_function('__', [
				rt.new_string('Style Variations'),
			]) }, rt.ArrayItem{ key: 'template-editing', val: rt.call_function('__', [
				rt.new_string('Template Editing'),
			]) }, rt.ArrayItem{ key: 'theme-options', val: rt.call_function('__', [
				rt.new_string('Theme Options'),
			]) }]) },
		rt.ArrayItem{ key: rt.call_function('__', [rt.new_string('Layout')]), val: rt.create_array([
			rt.ArrayItem{ key: 'grid-layout', val: rt.call_function('__', [
				rt.new_string('Grid Layout'),
			]) }, rt.ArrayItem{ key: 'one-column', val: rt.call_function('__', [
				rt.new_string('One Column'),
			]) }, rt.ArrayItem{ key: 'two-columns', val: rt.call_function('__', [
				rt.new_string('Two Columns'),
			]) }, rt.ArrayItem{ key: 'three-columns', val: rt.call_function('__', [
				rt.new_string('Three Columns'),
			]) }, rt.ArrayItem{ key: 'four-columns', val: rt.call_function('__', [
				rt.new_string('Four Columns'),
			]) }, rt.ArrayItem{ key: 'left-sidebar', val: rt.call_function('__', [
				rt.new_string('Left Sidebar'),
			]) }, rt.ArrayItem{ key: 'right-sidebar', val: rt.call_function('__', [
				rt.new_string('Right Sidebar'),
			]) }, rt.ArrayItem{ key: 'wide-blocks', val: rt.call_function('__', [
				rt.new_string('Wide Blocks'),
			]) }]) },
	])
	if !var_api
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('install_themes')]))))) {
		return var_features.clone()
	}
	var_feature_list = rt.call_function('get_site_transient', [
		rt.new_string('wporg_theme_feature_list'),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_feature_list)))) {
		rt.call_function('set_site_transient', [
			rt.new_string('wporg_theme_feature_list'),
			rt.new_array(),
			rt.mul(rt.new_int(3), rt.get_constant('HOUR_IN_SECONDS')),
		])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_feature_list)))) {
		var_feature_list = themes_api('feature_list', rt.new_array())
		if rt.is_true(rt.call_function('is_wp_error', [var_feature_list.clone()])) {
			return var_features.clone()
		}
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_feature_list)))) {
		return var_features.clone()
	}
	rt.call_function('set_site_transient', [rt.new_string('wporg_theme_feature_list'),
		var_feature_list.clone(), rt.mul(rt.new_int(3), rt.get_constant('HOUR_IN_SECONDS'))])
	var_category_translations = rt.create_array([
		rt.ArrayItem{ key: 'Layout', val: rt.call_function('__', [
			rt.new_string('Layout'),
		]) },
		rt.ArrayItem{ key: 'Features', val: rt.call_function('__', [
			rt.new_string('Features'),
		]) },
		rt.ArrayItem{ key: 'Subject', val: rt.call_function('__', [
			rt.new_string('Subject'),
		]) },
	])
	var_wporg_features = rt.new_array()
	mut iter_2 := rt.cast_array(var_feature_list).iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_feature_items_shadow := item_2.val
		mut var_feature_category_shadow := item_2.key
		if var_category_translations.array_isset(var_feature_category_shadow) {
			var_feature_category_shadow =
				var_category_translations.array_get(var_feature_category_shadow)
		}
		var_wporg_features.array_set(var_feature_category_shadow, rt.new_array())
		mut iter_3 := var_feature_items_shadow.iterator()
		for {
			item_3 := iter_3.next() or { break }
			mut var_feature_shadow := item_3.val
			var_wporg_features.array_get_mut(var_feature_category_shadow).array_set(var_feature_shadow, if !(var_features.array_get(var_feature_category_shadow).array_get(var_feature_shadow)).is_null() {
				var_features.array_get(var_feature_category_shadow).array_get(var_feature_shadow)
			} else {
				var_feature_shadow
			})
		}
	}
	return var_wporg_features.clone()
}

fn themes_api(action string, var_args_arg rt.PhpVal) rt.PhpVal {
	mut var_action := action
	mut var_args := var_args_arg
	mut var_res := rt.new_null()
	mut var_url := rt.new_null()
	mut var_http_url := rt.new_null()
	mut var_ssl := rt.new_null()
	mut var_http_args := map[string]rt.PhpVal{}
	mut var_request := rt.new_null()
	mut var_theme := rt.new_null()
	mut var_i := rt.new_null()
	if rt.is_true(rt.new_bool(var_args.clone().is_array())) {
		var_args = rt.array_to_object(var_args)
	}
	if rt.is_true(rt.identical(rt.new_string('query_themes'), rt.new_string(action))) {
		if !(!(rt.get_property(var_args, 'per_page')).is_null()) {
			rt.set_property(var_args, 'per_page', rt.new_int(24))
		}
	}
	if !(!(rt.get_property(var_args, 'locale')).is_null()) {
		rt.set_property(var_args, 'locale', rt.call_function('get_user_locale', []rt.PhpVal{}))
	}
	if !(!(rt.get_property(var_args, 'wp_version')).is_null()) {
		rt.set_property(var_args, 'wp_version', rt.call_function('substr', [
			rt.call_function('wp_get_wp_version', []rt.PhpVal{}),
			rt.new_int(0),
			rt.new_int(3),
		]))
	}
	var_args = rt.call_function('apply_filters', [rt.new_string('themes_api_args'),
		var_args.clone(), rt.new_string(action)])
	var_res = rt.call_function('apply_filters', [rt.new_string('themes_api'),
		rt.new_bool(false), rt.new_string(action), var_args.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_res)))) {
		var_url = rt.new_string('http://api.wordpress.org/themes/info/1.2/')
		var_url = rt.call_function('add_query_arg', [
			rt.create_array([rt.ArrayItem{ key: 'action', val: action },
				rt.ArrayItem{ key: 'request', val: var_args }]),
			var_url.clone(),
		])
		var_http_url = var_url.clone()
		var_ssl = rt.call_function('wp_http_supports', [
			rt.create_array([rt.ArrayItem{ key: none, val: 'ssl' }]),
		])
		if rt.is_true(var_ssl) {
			var_url = rt.call_function('set_url_scheme', [var_url.clone(),
				rt.new_string('https')])
		}
		var_http_args = {
			'timeout':    rt.new_int(15)
			'user-agent': 'WordPress/' +
				(rt.call_function('wp_get_wp_version', []rt.PhpVal{})).str() + '; ' +
				(rt.call_function('home_url', [rt.new_string('/')])).str()
		}
		var_request = rt.call_function('wp_remote_get', [var_url.clone(),
			rt.create_array_from_native_map(var_http_args)])
		if rt.is_true(var_ssl) && rt.is_true(rt.call_function('is_wp_error', [var_request.clone()])) {
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_doing_ajax', []rt.PhpVal{}))))) {
				rt.call_function('wp_trigger_error', [rt.new_string(@FN),
					rt.new_string(
						(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('An unexpected error occurred. Something may be wrong with WordPress.org or this server&#8217;s configuration. If you continue to have problems, please try the <a href="%s">support forums</a>.')]), rt.call_function('__', [rt.new_string('https://wordpress.org/support/forums/')])])).str() +
						' ' +(rt.call_function('__', [rt.new_string('(WordPress could not establish a secure connection to WordPress.org. Please contact your server administrator.)')])).str()),
					if rt.is_true(rt.call_function('headers_sent', []rt.PhpVal{}))
						|| rt.is_true(rt.get_constant('WP_DEBUG')) {
						rt.get_constant('E_USER_WARNING')
					} else {
						rt.get_constant('E_USER_NOTICE')
					}])
			}
			var_request = rt.call_function('wp_remote_get', [
				var_http_url.clone(), rt.create_array_from_native_map(var_http_args)])
		}
		if rt.is_true(rt.call_function('is_wp_error', [var_request.clone()])) {
			var_res = create_wp_error(rt.new_string('themes_api_failed'), rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('An unexpected error occurred. Something may be wrong with WordPress.org or this server&#8217;s configuration. If you continue to have problems, please try the <a href="%s">support forums</a>.'),
				]),
				rt.call_function('__', [
					rt.new_string('https://wordpress.org/support/forums/'),
				]),
			]), rt.call_method(var_request, 'get_error_message', []rt.PhpVal{}))
		} else {
			var_res = rt.call_function('json_decode', [
				rt.call_function('wp_remote_retrieve_body', [
					var_request.clone()]),
				rt.new_bool(true),
			])
			if rt.is_true(rt.new_bool(var_res.clone().is_array())) {
				var_res = rt.array_to_object(var_res)
			} else if rt.is_true(rt.identical(rt.new_null(), var_res)) {
				var_res = create_wp_error(rt.new_string('themes_api_failed'), rt.call_function('sprintf', [
					rt.call_function('__', [
						rt.new_string('An unexpected error occurred. Something may be wrong with WordPress.org or this server&#8217;s configuration. If you continue to have problems, please try the <a href="%s">support forums</a>.'),
					]),
					rt.call_function('__', [
						rt.new_string('https://wordpress.org/support/forums/'),
					]),
				]), rt.call_function('wp_remote_retrieve_body', [
					var_request.clone()]))
			}
			if !(rt.get_property(var_res, 'error')).is_null() {
				var_res = create_wp_error(rt.new_string('themes_api_failed'), rt.get_property(var_res,
					'error'))
			}
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [
			var_res.clone(),
		])))))
		{
			if rt.is_true(rt.identical(rt.new_string('query_themes'), rt.new_string(action))) {
				mut iter_4 := rt.get_property(var_res, 'themes').iterator()
				for {
					item_4 := iter_4.next() or { break }
					mut var_theme_shadow := item_4.val
					mut var_i_shadow := item_4.key
					rt.get_property(var_res, 'themes').array_set(var_i_shadow,
						rt.array_to_object(var_theme_shadow))
				}
			}
			if rt.is_true(rt.identical(rt.new_string('feature_list'), rt.new_string(action))) {
				var_res = rt.cast_array(var_res)
			}
		}
	}
	return rt.call_function('apply_filters', [rt.new_string('themes_api_result'),
		var_res.clone(), rt.new_string(action), var_args.clone()])
}

fn wp_prepare_themes_for_js(var_themes_arg rt.PhpVal) rt.PhpVal {
	mut var_themes := var_themes_arg
	mut var_current_theme := rt.new_null()
	mut var_prepared_themes := rt.new_null()
	mut var_updates := rt.new_null()
	mut var_no_updates := rt.new_null()
	mut var_updates_transient := rt.new_null()
	mut var_parents := rt.new_null()
	mut var_auto_updates := rt.new_null()
	mut var_theme := rt.new_null()
	mut var_slug := rt.new_null()
	mut var_encoded_slug := rt.new_null()
	mut var_parent := rt.new_null()
	mut var_customize_action := rt.new_null()
	mut var_can_edit_theme_options := rt.new_null()
	mut var_can_customize := rt.new_null()
	mut var_is_block_theme := rt.new_null()
	mut var_update_requires_wp := rt.new_null()
	mut var_update_requires_php := rt.new_null()
	mut var_auto_update := rt.new_null()
	mut var_auto_update_action := ''
	mut var_auto_update_supported := false
	mut var_auto_update_filter_payload := rt.new_null()
	mut var_auto_update_forced := rt.new_null()
	var_current_theme = rt.call_function('get_stylesheet', []rt.PhpVal{})
	var_prepared_themes = rt.cast_array(rt.call_function('apply_filters', [
		rt.new_string('pre_prepare_themes_for_js'),
		rt.new_array(),
		var_themes.clone(),
		var_current_theme.clone(),
	]))
	if !(!rt.is_true(var_prepared_themes)) {
		return var_prepared_themes.clone()
	}
	var_prepared_themes.array_set(var_current_theme, rt.new_array())
	if rt.is_true(rt.identical(rt.new_null(), var_themes)) {
		var_themes = rt.call_function('wp_get_themes', [
			rt.create_array([rt.ArrayItem{ key: 'allowed', val: true }]),
		])
		if !(var_themes.array_isset(var_current_theme)) {
			var_themes.array_set(var_current_theme, rt.call_function('wp_get_theme', []rt.PhpVal{}))
		}
	}
	var_updates = rt.new_array()
	var_no_updates = rt.new_array()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})))))
		&& rt.is_true(rt.call_function('current_user_can', [rt.new_string('update_themes')])) {
		var_updates_transient = rt.call_function('get_site_transient', [
			rt.new_string('update_themes'),
		])
		if !(rt.get_property(var_updates_transient, 'response')).is_null() {
			var_updates = rt.get_property(var_updates_transient, 'response')
		}
		if !(rt.get_property(var_updates_transient, 'no_update')).is_null() {
			var_no_updates = rt.get_property(var_updates_transient, 'no_update')
		}
	}
	mut iife_temp_1 := Class_WP_Theme{}
	mut iife_result_1 := iife_temp_1.sort_by_name(var_themes.clone())
	var_parents = rt.new_array()
	var_auto_updates = rt.cast_array(rt.call_function('get_site_option', [
		rt.new_string('auto_update_themes'),
		rt.new_array(),
	]))
	mut iter_5 := var_themes.iterator()
	for {
		item_5 := iter_5.next() or { break }
		mut var_theme_shadow := item_5.val
		var_slug = rt.call_method(var_theme_shadow, 'get_stylesheet', []rt.PhpVal{})
		var_encoded_slug = rt.call_function('urlencode', [var_slug.clone()])
		var_parent = rt.new_bool(false)
		if rt.is_true(rt.call_method(var_theme_shadow, 'parent', []rt.PhpVal{})) {
			var_parent = rt.call_method(var_theme_shadow, 'parent', []rt.PhpVal{})
			var_parents.array_set(var_slug, rt.call_method(var_parent, 'get_stylesheet',
				[]rt.PhpVal{}))
			var_parent = rt.call_method(var_parent, 'display', [
				rt.new_string('Name')])
		}
		var_customize_action = rt.new_null()
		var_can_edit_theme_options = rt.call_function('current_user_can', [
			rt.new_string('edit_theme_options'),
		])
		var_can_customize = rt.call_function('current_user_can', [
			rt.new_string('customize'),
		])
		var_is_block_theme = rt.call_method(var_theme_shadow, 'is_block_theme', []rt.PhpVal{})
		if rt.is_true(var_is_block_theme) && rt.is_true(var_can_edit_theme_options) {
			var_customize_action = rt.call_function('admin_url', [
				rt.new_string('site-editor.php'),
			])
			if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_current_theme, var_slug)))) {
				var_customize_action = rt.call_function('add_query_arg', [
					rt.new_string('wp_theme_preview'),
					var_slug.clone(),
					var_customize_action.clone(),
				])
			}
		} else if rt.is_true(rt.new_bool(!(rt.is_true(var_is_block_theme))))
			&& rt.is_true(var_can_customize) && rt.is_true(var_can_edit_theme_options) {
			var_customize_action = rt.call_function('wp_customize_url', [
				var_slug.clone()])
		}
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_customize_action)))) {
			var_customize_action = rt.call_function('add_query_arg', [
				rt.create_array([
					rt.ArrayItem{ key: 'return', val: rt.call_function('urlencode', [
						rt.call_function('sanitize_url', [
							rt.call_function('remove_query_arg', [
								rt.call_function('wp_removable_query_args', []rt.PhpVal{}),
								rt.call_function('wp_unslash', [
									rt.get_superglobal('_SERVER').array_get(rt.new_string('REQUEST_URI')),
								]),
							]),
						]),
					]) },
				]),
				var_customize_action.clone(),
			])
			var_customize_action = rt.call_function('esc_url', [
				var_customize_action.clone()])
		}
		var_update_requires_wp = if !(var_updates.array_get(var_slug).array_get(rt.new_string('requires'))).is_null() {
			var_updates.array_get(var_slug).array_get(rt.new_string('requires'))
		} else {
			rt.new_null()
		}
		var_update_requires_php = if !(var_updates.array_get(var_slug).array_get(rt.new_string('requires_php'))).is_null() {
			var_updates.array_get(var_slug).array_get(rt.new_string('requires_php'))
		} else {
			rt.new_null()
		}
		var_auto_update = rt.call_function('in_array', [var_slug.clone(),
			var_auto_updates.clone(), rt.new_bool(true)])
		var_auto_update_action = if rt.is_true(var_auto_update) {
			'disable-auto-update'
		} else {
			'enable-auto-update'
		}
		if var_updates.array_isset(var_slug) {
			var_auto_update_supported = true
			var_auto_update_filter_payload = rt.array_to_object(var_updates.array_get(var_slug))
		} else if var_no_updates.array_isset(var_slug) {
			var_auto_update_supported = true
			var_auto_update_filter_payload = rt.array_to_object(var_no_updates.array_get(var_slug))
		} else {
			var_auto_update_supported = false
			var_auto_update_filter_payload = rt.array_to_object(rt.create_array([
				rt.ArrayItem{ key: 'theme', val: var_slug },
				rt.ArrayItem{ key: 'new_version', val: rt.call_method(var_theme_shadow, 'get', [
					rt.new_string('Version'),
				]) },
				rt.ArrayItem{ key: 'url', val: '' },
				rt.ArrayItem{ key: 'package', val: '' },
				rt.ArrayItem{ key: 'requires', val: rt.call_method(var_theme_shadow, 'get', [
					rt.new_string('RequiresWP'),
				]) },
				rt.ArrayItem{ key: 'requires_php', val: rt.call_method(var_theme_shadow, 'get', [
					rt.new_string('RequiresPHP'),
				]) },
			]))
		}
		var_auto_update_forced = rt.call_function('wp_is_auto_update_forced_for_item', [
			rt.new_string('theme'),
			rt.new_null(),
			var_auto_update_filter_payload.clone(),
		])
		var_prepared_themes.array_set(var_slug, rt.create_array([
			rt.ArrayItem{ key: 'id', val: var_slug },
			rt.ArrayItem{ key: 'name', val: rt.call_method(var_theme_shadow, 'display', [
				rt.new_string('Name'),
			]) },
			rt.ArrayItem{ key: 'screenshot', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.call_method(var_theme_shadow, 'get_screenshot',
					[]rt.PhpVal{}) },
			]) },
			rt.ArrayItem{ key: 'description', val: rt.call_method(var_theme_shadow, 'display', [
				rt.new_string('Description'),
			]) },
			rt.ArrayItem{ key: 'author', val: rt.call_method(var_theme_shadow, 'display', [
				rt.new_string('Author'),
				rt.new_bool(false),
				rt.new_bool(true),
			]) },
			rt.ArrayItem{ key: 'authorAndUri', val: rt.call_method(var_theme_shadow, 'display', [
				rt.new_string('Author'),
			]) },
			rt.ArrayItem{ key: 'tags', val: rt.call_method(var_theme_shadow, 'display', [
				rt.new_string('Tags'),
			]) },
			rt.ArrayItem{ key: 'version', val: rt.call_method(var_theme_shadow, 'get', [
				rt.new_string('Version'),
			]) },
			rt.ArrayItem{ key: 'compatibleWP', val: rt.call_function('is_wp_version_compatible', [
				rt.call_method(var_theme_shadow, 'get', [rt.new_string('RequiresWP')]),
			]) },
			rt.ArrayItem{ key: 'compatiblePHP', val: rt.call_function('is_php_version_compatible', [
				rt.call_method(var_theme_shadow, 'get', [rt.new_string('RequiresPHP')]),
			]) },
			rt.ArrayItem{ key: 'updateResponse', val: rt.create_array([
				rt.ArrayItem{ key: 'compatibleWP', val: rt.call_function('is_wp_version_compatible', [
					var_update_requires_wp.clone()]) },
				rt.ArrayItem{ key: 'compatiblePHP', val: rt.call_function('is_php_version_compatible', [
					var_update_requires_php.clone()]) },
			]) },
			rt.ArrayItem{ key: 'parent', val: var_parent },
			rt.ArrayItem{ key: 'active', val: rt.identical(var_slug, var_current_theme) },
			rt.ArrayItem{ key: 'hasUpdate', val: rt.new_bool(var_updates.array_isset(var_slug)) },
			rt.ArrayItem{
				key: 'hasPackage'
				val: var_updates.array_isset(var_slug)
					&& !(!rt.is_true(var_updates.array_get(var_slug).array_get(rt.new_string('package'))))
			},
			rt.ArrayItem{ key: 'update', val: get_theme_update_available(var_theme_shadow.clone()) },
			rt.ArrayItem{ key: 'autoupdate', val: rt.create_array([
				rt.ArrayItem{ key: 'enabled', val: rt.is_true(var_auto_update)
					|| rt.is_true(var_auto_update_forced) },
				rt.ArrayItem{ key: 'supported', val: var_auto_update_supported },
				rt.ArrayItem{ key: 'forced', val: var_auto_update_forced },
			]) },
			rt.ArrayItem{ key: 'actions', val: rt.create_array([
				rt.ArrayItem{
					key: 'activate'
					val: if rt.is_true(rt.call_function('current_user_can', [
						rt.new_string('switch_themes'),
					]))
					{ rt.call_function('wp_nonce_url', [
							rt.call_function('admin_url', [
								rt.new_string('themes.php?action=activate&amp;stylesheet=' + var_encoded_slug.str()),
							]),
							rt.new_string('switch-theme_' + var_slug.str()),
						]) } else { rt.new_null() }
				},
				rt.ArrayItem{ key: 'customize', val: var_customize_action },
				rt.ArrayItem{
					key: 'delete'
					val: if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{}))))) && rt.is_true(rt.call_function('current_user_can', [rt.new_string('delete_themes')])) { rt.call_function('wp_nonce_url', [
							rt.call_function('admin_url', [
								rt.new_string('themes.php?action=delete&amp;stylesheet=' + var_encoded_slug.str()),
							]),
							rt.new_string('delete-theme_' + var_slug.str()),
						]) } else { rt.new_null() }
				},
				rt.ArrayItem{
					key: 'autoupdate'
					val: if rt.is_true(rt.call_function('wp_is_auto_update_enabled_for_type', [rt.new_string('theme')])) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{}))))) && rt.is_true(rt.call_function('current_user_can', [rt.new_string('update_themes')])) { rt.call_function('wp_nonce_url', [
							rt.call_function('admin_url', [
								rt.new_string('themes.php?action=' + var_auto_update_action + '&amp;stylesheet=' + var_encoded_slug.str()),
							]),
							rt.new_string('updates'),
						]) } else { rt.new_null() }
				},
			]) },
			rt.ArrayItem{ key: 'blockTheme', val: rt.call_method(var_theme_shadow,
				'is_block_theme', []rt.PhpVal{}) },
		]))
	}
	if !(!rt.is_true(var_parents))
		&& rt.is_true(rt.new_bool(var_parents.clone().array_isset(var_current_theme.clone()))) {
		var_prepared_themes.array_get(var_parents.array_get(var_current_theme)).array_get(rt.new_string('actions')).array_unset(rt.new_string('delete'))
	}
	var_prepared_themes = rt.call_function('apply_filters', [
		rt.new_string('wp_prepare_themes_for_js'),
		var_prepared_themes.clone(),
	])
	var_prepared_themes = rt.call_function('array_values', [var_prepared_themes.clone()])
	return rt.call_function('array_filter', [var_prepared_themes.clone()])
}

fn customize_themes_print_templates() {
	mut var_aria_label := rt.new_null()
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Show previous theme')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Show next theme')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Close details dialog')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Active Theme')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('printf', [rt.call_function('__', [rt.new_string('Version: %s')]),
		rt.new_string('{{ data.version }}')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('printf', [rt.call_function('__', [rt.new_string('By %s')]),
		rt.new_string('{{{ data.authorAndUri }}}')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('printf', [
		rt.new_string('%1$s <span class="screen-reader-text">%2$s</span>'),
		rt.call_function('sprintf', [
			rt.call_function('__', [rt.new_string('(%s ratings)')]),
			rt.new_string('{{ data.num_ratings }}'),
		]),
		rt.call_function('__', [
			rt.new_string('(opens in a new tab)'),
		]),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Update Available')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Update Incompatible')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('printf', [
		rt.call_function('__', [
			rt.new_string('There is a new version of %s available, but it does not work with your versions of WordPress and PHP.'),
		]),
		rt.new_string('{{{ data.name }}}'),
	])
	if rt.is_true(rt.call_function('current_user_can', [rt.new_string('update_core')]))
		&& rt.is_true(rt.call_function('current_user_can', [rt.new_string('update_php')])) {
		rt.call_function('printf', [
			rt.new_string(' ' +(rt.call_function('__', [rt.new_string('<a href="%1$s">Please update WordPress</a>, and then <a href="%2$s">learn more about updating PHP</a>.')])).str()),
			rt.call_function('self_admin_url', [
				rt.new_string('update-core.php'),
			]),
			rt.call_function('esc_url', [
				rt.call_function('wp_get_update_php_url', []rt.PhpVal{}),
			]),
		])
		rt.call_function('wp_update_php_annotation', [rt.new_string('</p><p><em>'),
			rt.new_string('</em>')])
	} else if rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('update_core'),
	]))
	{
		rt.call_function('printf', [
			rt.new_string(' ' +(rt.call_function('__', [rt.new_string('<a href="%s">Please update WordPress</a>.')])).str()),
			rt.call_function('self_admin_url', [
				rt.new_string('update-core.php'),
			]),
		])
	} else if rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('update_php'),
	]))
	{
		rt.call_function('printf', [
			rt.new_string(' ' +(rt.call_function('__', [rt.new_string('<a href="%s">Learn more about updating PHP</a>.')])).str()),
			rt.call_function('esc_url', [
				rt.call_function('wp_get_update_php_url', []rt.PhpVal{}),
			]),
		])
		rt.call_function('wp_update_php_annotation', [rt.new_string('</p><p><em>'),
			rt.new_string('</em>')])
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('printf', [
		rt.call_function('__', [
			rt.new_string('There is a new version of %s available, but it does not work with your version of WordPress.'),
		]),
		rt.new_string('{{{ data.name }}}'),
	])
	if rt.is_true(rt.call_function('current_user_can', [rt.new_string('update_core')])) {
		rt.call_function('printf', [
			rt.new_string(' ' +(rt.call_function('__', [rt.new_string('<a href="%s">Please update WordPress</a>.')])).str()),
			rt.call_function('self_admin_url', [
				rt.new_string('update-core.php'),
			]),
		])
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('printf', [
		rt.call_function('__', [
			rt.new_string('There is a new version of %s available, but it does not work with your version of PHP.'),
		]),
		rt.new_string('{{{ data.name }}}'),
	])
	if rt.is_true(rt.call_function('current_user_can', [rt.new_string('update_php')])) {
		rt.call_function('printf', [
			rt.new_string(' ' +(rt.call_function('__', [rt.new_string('<a href="%s">Learn more about updating PHP</a>.')])).str()),
			rt.call_function('esc_url', [
				rt.call_function('wp_get_update_php_url', []rt.PhpVal{}),
			]),
		])
		rt.call_function('wp_update_php_annotation', [rt.new_string('</p><p><em>'),
			rt.new_string('</em>')])
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('printf', [
		rt.call_function('__', [rt.new_string('This is a child theme of %s.')]),
		rt.new_string('<strong>{{{ data.parent }}}</strong>'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [
		rt.new_string('This theme does not work with your versions of WordPress and PHP.'),
	])
	if rt.is_true(rt.call_function('current_user_can', [rt.new_string('update_core')]))
		&& rt.is_true(rt.call_function('current_user_can', [rt.new_string('update_php')])) {
		rt.call_function('printf', [
			rt.new_string(' ' +(rt.call_function('__', [rt.new_string('<a href="%1$s">Please update WordPress</a>, and then <a href="%2$s">learn more about updating PHP</a>.')])).str()),
			rt.call_function('self_admin_url', [
				rt.new_string('update-core.php'),
			]),
			rt.call_function('esc_url', [
				rt.call_function('wp_get_update_php_url', []rt.PhpVal{}),
			]),
		])
		rt.call_function('wp_update_php_annotation', [rt.new_string('</p><p><em>'),
			rt.new_string('</em>')])
	} else if rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('update_core'),
	]))
	{
		rt.call_function('printf', [
			rt.new_string(' ' +(rt.call_function('__', [rt.new_string('<a href="%s">Please update WordPress</a>.')])).str()),
			rt.call_function('self_admin_url', [
				rt.new_string('update-core.php'),
			]),
		])
	} else if rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('update_php'),
	]))
	{
		rt.call_function('printf', [
			rt.new_string(' ' +(rt.call_function('__', [rt.new_string('<a href="%s">Learn more about updating PHP</a>.')])).str()),
			rt.call_function('esc_url', [
				rt.call_function('wp_get_update_php_url', []rt.PhpVal{}),
			]),
		])
		rt.call_function('wp_update_php_annotation', [rt.new_string('</p><p><em>'),
			rt.new_string('</em>')])
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [
		rt.new_string('This theme does not work with your version of WordPress.'),
	])
	if rt.is_true(rt.call_function('current_user_can', [rt.new_string('update_core')])) {
		rt.call_function('printf', [
			rt.new_string(' ' +(rt.call_function('__', [rt.new_string('<a href="%s">Please update WordPress</a>.')])).str()),
			rt.call_function('self_admin_url', [
				rt.new_string('update-core.php'),
			]),
		])
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [
		rt.new_string('This theme does not work with your version of PHP.'),
	])
	if rt.is_true(rt.call_function('current_user_can', [rt.new_string('update_php')])) {
		rt.call_function('printf', [
			rt.new_string(' ' +(rt.call_function('__', [rt.new_string('<a href="%s">Learn more about updating PHP</a>.')])).str()),
			rt.call_function('esc_url', [
				rt.call_function('wp_get_update_php_url', []rt.PhpVal{}),
			]),
		])
		rt.call_function('wp_update_php_annotation', [rt.new_string('</p><p><em>'),
			rt.new_string('</em>')])
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string("This theme doesn't support Customizer.")])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('printf', [
		rt.new_string(' ' +(rt.call_function('__', [rt.new_string('However, you can still <a href="%s">activate this theme</a>, and use the Site Editor to customize it.')])).str()),
		rt.new_string('{{{ data.actions.activate }}}'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Tags:')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Customize')])
	// unsupported statement: Stmt_InlineHTML
	var_aria_label = rt.call_function('sprintf', [
		rt.call_function('_x', [rt.new_string('Activate %s'),
			rt.new_string('theme')]),
		rt.new_string('{{ data.name }}'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_aria_label.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Activate')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Live Preview')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Live Preview')])
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.call_function('current_user_can', [rt.new_string('delete_themes')])) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Delete')])
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Install')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Install &amp; Preview')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_ex', [rt.new_string('Cannot Install'),
		rt.new_string('theme')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Install &amp; Preview')])
	// unsupported statement: Stmt_InlineHTML
}

fn is_theme_paused(var_theme rt.PhpVal) bool {
	mut var_GLOBALS := rt.new_null()
	if !(var_GLOBALS.array_isset(rt.new_string('_paused_themes'))) {
		return false
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('get_stylesheet', []rt.PhpVal{}), var_theme))))
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('get_template', []rt.PhpVal{}), var_theme)))) {
		return false
	}
	return var_GLOBALS.array_get(rt.new_string('_paused_themes')).array_isset(var_theme.clone())
}

fn wp_get_theme_error(var_theme rt.PhpVal) bool {
	mut var_GLOBALS := rt.new_null()
	if !(var_GLOBALS.array_isset(rt.new_string('_paused_themes'))) {
		return false
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_GLOBALS.array_get(rt.new_string('_paused_themes')).array_isset(var_theme.clone())))))) {
		return false
	}
	return (var_GLOBALS.array_get(rt.new_string('_paused_themes')).array_get(var_theme)).to_bool()
}

fn resume_theme(var_theme rt.PhpVal, redirect string) bool {
	mut var_redirect := redirect
	mut var_wp_stylesheet_path := rt.new_null()
	mut var_wp_template_path := rt.new_null()
	mut var_extension := rt.new_null()
	mut var_functions_path := rt.new_null()
	mut var_result := rt.new_null()
	mut list_tmp_1 := rt.call_function('explode', [rt.new_string('/'),
		var_theme.clone()])
	var_extension = list_tmp_1.array_get(0)
	if !(var_redirect == '') {
		var_functions_path = rt.new_string('')
		if rt.is_true(rt.call_function('str_contains', [var_wp_stylesheet_path.clone(),
			var_extension.clone()]))
		{
			var_functions_path = rt.new_string(var_wp_stylesheet_path.str() + '/functions.php')
		} else if rt.is_true(rt.call_function('str_contains', [
			var_wp_template_path.clone(), var_extension.clone()]))
		{
			var_functions_path = rt.new_string(var_wp_template_path.str() + '/functions.php')
		}
		if !(!rt.is_true(var_functions_path)) {
			rt.call_function('wp_redirect', [
				rt.call_function('add_query_arg', [rt.new_string('_error_nonce'),
					rt.call_function('wp_create_nonce', [
						rt.new_string('theme-resume-error_' + var_theme.str()),
					]),
					rt.new_string(var_redirect.str())]),
			])
			rt.call_function('ob_start', []rt.PhpVal{})
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
				rt.new_string('WP_SANDBOX_SCRAPING'),
			])))))
			{
				rt.call_function('define', [rt.new_string('WP_SANDBOX_SCRAPING'),
					rt.new_bool(true)])
			}
			rt.include_file(var_functions_path.to_string(), '1')
			rt.call_function('ob_clean', []rt.PhpVal{})
		}
	}
	var_result = rt.call_method(rt.call_function('wp_paused_themes', []rt.PhpVal{}), 'delete', [
		var_extension.clone(),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_result)))) {
		return (create_wp_error(rt.new_string('could_not_resume_theme'), rt.call_function('__', [
			rt.new_string('Could not resume the theme.'),
		]))).to_bool()
	}
	return true
}

fn paused_themes_notice() {
	mut var_GLOBALS := rt.new_null()
	mut var_message := rt.new_null()
	if rt.is_true(rt.identical(rt.new_string('themes.php'),
		var_GLOBALS.array_get(rt.new_string('pagenow'))))
	{
		return
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('resume_themes'),
	])))))
	{
		return
	}
	if !(var_GLOBALS.array_isset(rt.new_string('_paused_themes')))
		|| !rt.is_true(var_GLOBALS.array_get(rt.new_string('_paused_themes'))) {
		return
	}
	var_message = rt.call_function('sprintf', [
		rt.new_string('<p><strong>%s</strong><br>%s</p><p><a href="%s">%s</a></p>'),
		rt.call_function('__', [
			rt.new_string('One or more themes failed to load properly.'),
		]),
		rt.call_function('__', [
			rt.new_string('You can find more details and make changes on the Themes screen.'),
		]),
		rt.call_function('esc_url', [
			rt.call_function('admin_url', [rt.new_string('themes.php')]),
		]),
		rt.call_function('__', [
			rt.new_string('Go to the Themes screen'),
		]),
	])
	rt.call_function('wp_admin_notice', [var_message.clone(),
		rt.create_array([rt.ArrayItem{ key: 'type', val: 'error' },
			rt.ArrayItem{ key: 'paragraph_wrap', val: false }])])
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

struct Class_WP_Theme {
	rt.PhpObjectBase
}

fn create_wp_error(_args ...rt.PhpVal) &Class_WP_Error {
	mut obj := &Class_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_theme(_args ...rt.PhpVal) &Class_WP_Theme {
	mut obj := &Class_WP_Theme{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
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

fn (mut this Class_WP_Theme) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Theme) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Theme) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
