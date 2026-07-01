import rt

fn delete_theme(var_stylesheet rt.PhpVal, redirect string) rt.PhpVal {
	mut var_wp_filesystem := rt.new_null()
	// unsupported statement: Stmt_Global
	if !rt.is_true(var_stylesheet) {
		return rt.new_bool(false)
	}
	if redirect == '' {
		redirect = (rt.call_function('wp_nonce_url', ['themes.php?action=delete&stylesheet=' + (rt.call_function('urlencode', [var_stylesheet.dup()])).str(), 'delete-theme_' + (var_stylesheet).str()])).str()
	}
	rt.call_function('ob_start', []rt.PhpVal{})
	mut var_credentials := rt.call_function('request_filesystem_credentials', [rt.new_string(redirect)])
	mut var_data := rt.call_function('ob_get_clean', []rt.PhpVal{})
	if rt.is_true(rt.identical(rt.new_bool(false), var_credentials)) {
		if !(!rt.is_true(var_data)) {
			rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-header.php', '4')
			rt.echo_val(var_data)
			rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-footer.php', '4')
			// unsupported expression: Expr_Exit
		}
		return rt.new_null()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('WP_Filesystem', [var_credentials.dup()]))))) {
		rt.call_function('ob_start', []rt.PhpVal{})
		rt.call_function('request_filesystem_credentials', [rt.new_string(redirect), rt.new_string(''), rt.new_bool(true)])
		var_data = rt.call_function('ob_get_clean', []rt.PhpVal{})
		if !(!rt.is_true(var_data)) {
			rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-header.php', '4')
			rt.echo_val(var_data)
			rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-footer.php', '4')
			// unsupported expression: Expr_Exit
		}
		return rt.new_null()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_wp_filesystem.dup().is_object()))))) {
		return create_wp_error(rt.new_string('fs_unavailable'), rt.call_function('__', [rt.new_string('Could not access filesystem.')]))
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('is_wp_error', [rt.get_property(var_wp_filesystem, 'errors')])) && rt.is_true(rt.call_method(rt.get_property(var_wp_filesystem, 'errors'), 'has_errors', []rt.PhpVal{})))) {
		return create_wp_error(rt.new_string('fs_error'), rt.call_function('__', [rt.new_string('Filesystem error.')]), rt.get_property(var_wp_filesystem, 'errors'))
	}
	mut var_themes_dir := rt.call_method(var_wp_filesystem, 'wp_themes_dir', []rt.PhpVal{})
	if !rt.is_true(var_themes_dir) {
		return create_wp_error(rt.new_string('fs_no_themes_dir'), rt.call_function('__', [rt.new_string('Unable to locate WordPress theme directory.')]))
	}
	rt.call_function('do_action', [rt.new_string('delete_theme'), var_stylesheet.dup()])
	mut var_theme := rt.call_function('wp_get_theme', [var_stylesheet.dup()])
	var_themes_dir = rt.call_function('trailingslashit', [var_themes_dir.dup()])
	mut var_theme_dir := rt.call_function('trailingslashit', [rt.concat(var_themes_dir, var_stylesheet)])
	mut var_deleted := rt.call_method(var_wp_filesystem, 'delete', [var_theme_dir.dup(), rt.new_bool(true)])
	rt.call_function('do_action', [rt.new_string('deleted_theme'), var_stylesheet.dup(), var_deleted.dup()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_deleted)))) {
		return create_wp_error(rt.new_string('could_not_remove_theme'), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Could not fully remove the theme %s.')]), var_stylesheet.dup()]))
	}
	mut var_theme_translations := rt.call_function('wp_get_installed_translations', [rt.new_string('themes')])
	if !(!rt.is_true(var_theme_translations.array_get(var_stylesheet))) {
		mut var_translations := var_theme_translations.array_get(var_stylesheet)
		{
			mut iter_1 := var_translations.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_data_shadow := item_1.val
				mut var_translation := item_1.key
				rt.call_method(var_wp_filesystem, 'delete', [(rt.get_constant('WP_LANG_DIR')).str() + '/themes/' + (var_stylesheet).str() + '-' + (var_translation).str() + '.po'])
				rt.call_method(var_wp_filesystem, 'delete', [(rt.get_constant('WP_LANG_DIR')).str() + '/themes/' + (var_stylesheet).str() + '-' + (var_translation).str() + '.mo'])
				rt.call_method(var_wp_filesystem, 'delete', [(rt.get_constant('WP_LANG_DIR')).str() + '/themes/' + (var_stylesheet).str() + '-' + (var_translation).str() + '.l10n.php'])
				mut var_json_translation_files := rt.call_function('glob', [(rt.get_constant('WP_LANG_DIR')).str() + '/themes/' + (var_stylesheet).str() + '-' + (var_translation).str() + '-*.json'])
				if rt.is_true(var_json_translation_files) {
					rt.call_function('array_map', [rt.create_array([rt.ArrayItem{ key: none, val: var_wp_filesystem }, rt.ArrayItem{ key: none, val: 'delete' }]), var_json_translation_files.dup()])
				}
			}
		}
	}
	if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) {
		fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WP_Theme{}; return temp.network_disable_theme(arg_0) }(var_stylesheet.dup())
	}
	rt.call_method(var_theme, 'cache_delete', []rt.PhpVal{})
	rt.call_function('delete_site_transient', [rt.new_string('update_themes')])
	return rt.new_bool(true)
}

fn get_page_templates(var_post rt.PhpVal, post_type string) rt.PhpVal {
	return rt.call_function('array_flip', [rt.call_method(rt.call_function('wp_get_theme', []rt.PhpVal{}), 'get_page_templates', [var_post.dup(), rt.new_string(post_type)])])
}

fn _get_template_edit_filename(var_fullpath rt.PhpVal, var_containingfolder rt.PhpVal) rt.PhpVal {
	return rt.call_function('str_replace', [rt.call_function('dirname', [var_containingfolder.dup(), rt.new_int(2)]), rt.new_string(''), var_fullpath.dup()])
}

fn theme_update_available(var_theme rt.PhpVal) {
	rt.echo_val(rt.new_bool(get_theme_update_available(var_theme.dup())))
}

fn get_theme_update_available(var_theme rt.PhpVal) bool {
	// unsupported statement: Stmt_Static
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('update_themes')]))))) {
		return false
	}
	if !(!(var_themes_update).is_null()) {
		mut var_themes_update := rt.call_function('get_site_transient', [rt.new_string('update_themes')])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_theme, 'WP_Theme')))))) {
		return false
	}
	mut var_stylesheet := rt.call_method(var_theme, 'get_stylesheet', []rt.PhpVal{})
	mut var_html := rt.new_string(rt.new_string(''))
	if rt.get_property(var_themes_update, 'response').array_isset(var_stylesheet) {
		mut var_update := rt.get_property(var_themes_update, 'response').array_get(var_stylesheet)
		mut var_theme_name := rt.call_method(var_theme, 'display', [rt.new_string('Name')])
		mut var_details_url := rt.call_function('add_query_arg', [rt.create_array([rt.ArrayItem{ key: 'TB_iframe', val: 'true' }, rt.ArrayItem{ key: 'width', val: 1024 }, rt.ArrayItem{ key: 'height', val: 800 }]), var_update.array_get('url')])
		mut var_update_url := rt.call_function('wp_nonce_url', [rt.call_function('admin_url', ['update.php?action=upgrade-theme&amp;theme=' + (rt.call_function('urlencode', [var_stylesheet.dup()])).str()]), 'upgrade-theme_' + (var_stylesheet).str()])
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{}))))) {
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('update_themes')]))))) {
				var_html = rt.call_function('sprintf', ['<p><strong>' + (rt.call_function('__', [rt.new_string('There is a new version of %1$s available. <a href="%2$s" %3$s>View version %4$s details</a>.')])).str() + '</strong></p>', var_theme_name.dup(), rt.call_function('esc_url', [var_details_url.dup()]), rt.call_function('sprintf', [rt.new_string('class="thickbox open-plugin-details-modal" aria-label="%s"'), rt.call_function('esc_attr', [rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('View %1$s version %2$s details')]), var_theme_name.dup(), var_update.array_get('new_version')])])]), var_update.array_get('new_version')])
			} else if !rt.is_true(var_update.array_get('package')) {
				var_html = rt.call_function('sprintf', ['<p><strong>' + (rt.call_function('__', [rt.new_string('There is a new version of %1$s available. <a href="%2$s" %3$s>View version %4$s details</a>. <em>Automatic update is unavailable for this theme.</em>')])).str() + '</strong></p>', var_theme_name.dup(), rt.call_function('esc_url', [var_details_url.dup()]), rt.call_function('sprintf', [rt.new_string('class="thickbox open-plugin-details-modal" aria-label="%s"'), rt.call_function('esc_attr', [rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('View %1$s version %2$s details')]), var_theme_name.dup(), var_update.array_get('new_version')])])]), var_update.array_get('new_version')])
			} else {
				var_html = rt.call_function('sprintf', ['<p><strong>' + (rt.call_function('__', [rt.new_string('There is a new version of %1$s available. <a href="%2$s" %3$s>View version %4$s details</a> or <a href="%5$s" %6$s>update now</a>.')])).str() + '</strong></p>', var_theme_name.dup(), rt.call_function('esc_url', [var_details_url.dup()]), rt.call_function('sprintf', [rt.new_string('class="thickbox open-plugin-details-modal" aria-label="%s"'), rt.call_function('esc_attr', [rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('View %1$s version %2$s details')]), var_theme_name.dup(), var_update.array_get('new_version')])])]), var_update.array_get('new_version'), var_update_url.dup(), rt.call_function('sprintf', [rt.new_string('aria-label="%s" id="update-theme" data-slug="%s"'), rt.call_function('esc_attr', [rt.call_function('sprintf', [rt.call_function('_x', [rt.new_string('Update %s now'), rt.new_string('theme')]), var_theme_name.dup()])]), var_stylesheet.dup()])])
			}
		}
	}
	return (var_html).to_bool()
}

fn get_theme_feature_list(api bool) rt.PhpVal {
	mut var_features := rt.create_array([rt.ArrayItem{ key: rt.call_function('__', [rt.new_string('Subject')]), val: rt.create_array([rt.ArrayItem{ key: 'blog', val: rt.call_function('__', [rt.new_string('Blog')]) }, rt.ArrayItem{ key: 'e-commerce', val: rt.call_function('__', [rt.new_string('E-Commerce')]) }, rt.ArrayItem{ key: 'education', val: rt.call_function('__', [rt.new_string('Education')]) }, rt.ArrayItem{ key: 'entertainment', val: rt.call_function('__', [rt.new_string('Entertainment')]) }, rt.ArrayItem{ key: 'food-and-drink', val: rt.call_function('__', [rt.new_string('Food & Drink')]) }, rt.ArrayItem{ key: 'holiday', val: rt.call_function('__', [rt.new_string('Holiday')]) }, rt.ArrayItem{ key: 'news', val: rt.call_function('__', [rt.new_string('News')]) }, rt.ArrayItem{ key: 'photography', val: rt.call_function('__', [rt.new_string('Photography')]) }, rt.ArrayItem{ key: 'portfolio', val: rt.call_function('__', [rt.new_string('Portfolio')]) }]) }, rt.ArrayItem{ key: rt.call_function('__', [rt.new_string('Features')]), val: rt.create_array([rt.ArrayItem{ key: 'accessibility-ready', val: rt.call_function('__', [rt.new_string('Accessibility Ready')]) }, rt.ArrayItem{ key: 'block-patterns', val: rt.call_function('__', [rt.new_string('Block Editor Patterns')]) }, rt.ArrayItem{ key: 'block-styles', val: rt.call_function('__', [rt.new_string('Block Editor Styles')]) }, rt.ArrayItem{ key: 'custom-background', val: rt.call_function('__', [rt.new_string('Custom Background')]) }, rt.ArrayItem{ key: 'custom-colors', val: rt.call_function('__', [rt.new_string('Custom Colors')]) }, rt.ArrayItem{ key: 'custom-header', val: rt.call_function('__', [rt.new_string('Custom Header')]) }, rt.ArrayItem{ key: 'custom-logo', val: rt.call_function('__', [rt.new_string('Custom Logo')]) }, rt.ArrayItem{ key: 'editor-style', val: rt.call_function('__', [rt.new_string('Editor Style')]) }, rt.ArrayItem{ key: 'featured-image-header', val: rt.call_function('__', [rt.new_string('Featured Image Header')]) }, rt.ArrayItem{ key: 'featured-images', val: rt.call_function('__', [rt.new_string('Featured Images')]) }, rt.ArrayItem{ key: 'footer-widgets', val: rt.call_function('__', [rt.new_string('Footer Widgets')]) }, rt.ArrayItem{ key: 'full-site-editing', val: rt.call_function('__', [rt.new_string('Site Editor')]) }, rt.ArrayItem{ key: 'full-width-template', val: rt.call_function('__', [rt.new_string('Full Width Template')]) }, rt.ArrayItem{ key: 'post-formats', val: rt.call_function('__', [rt.new_string('Post Formats')]) }, rt.ArrayItem{ key: 'sticky-post', val: rt.call_function('__', [rt.new_string('Sticky Post')]) }, rt.ArrayItem{ key: 'style-variations', val: rt.call_function('__', [rt.new_string('Style Variations')]) }, rt.ArrayItem{ key: 'template-editing', val: rt.call_function('__', [rt.new_string('Template Editing')]) }, rt.ArrayItem{ key: 'theme-options', val: rt.call_function('__', [rt.new_string('Theme Options')]) }]) }, rt.ArrayItem{ key: rt.call_function('__', [rt.new_string('Layout')]), val: rt.create_array([rt.ArrayItem{ key: 'grid-layout', val: rt.call_function('__', [rt.new_string('Grid Layout')]) }, rt.ArrayItem{ key: 'one-column', val: rt.call_function('__', [rt.new_string('One Column')]) }, rt.ArrayItem{ key: 'two-columns', val: rt.call_function('__', [rt.new_string('Two Columns')]) }, rt.ArrayItem{ key: 'three-columns', val: rt.call_function('__', [rt.new_string('Three Columns')]) }, rt.ArrayItem{ key: 'four-columns', val: rt.call_function('__', [rt.new_string('Four Columns')]) }, rt.ArrayItem{ key: 'left-sidebar', val: rt.call_function('__', [rt.new_string('Left Sidebar')]) }, rt.ArrayItem{ key: 'right-sidebar', val: rt.call_function('__', [rt.new_string('Right Sidebar')]) }, rt.ArrayItem{ key: 'wide-blocks', val: rt.call_function('__', [rt.new_string('Wide Blocks')]) }]) }])
	if rt.is_true(rt.new_bool(!(var_api) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('install_themes')]))))))) {
		return var_features.dup()
	}
	mut var_feature_list := rt.call_function('get_site_transient', [rt.new_string('wporg_theme_feature_list')])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_feature_list)))) {
		rt.call_function('set_site_transient', [rt.new_string('wporg_theme_feature_list'), rt.new_array(), rt.mul(rt.new_int(3), rt.get_constant('HOUR_IN_SECONDS'))])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_feature_list)))) {
		var_feature_list = themes_api('feature_list', rt.new_array())
		if rt.is_true(rt.call_function('is_wp_error', [var_feature_list.dup()])) {
			return var_features.dup()
		}
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_feature_list)))) {
		return var_features.dup()
	}
	rt.call_function('set_site_transient', [rt.new_string('wporg_theme_feature_list'), var_feature_list.dup(), rt.mul(rt.new_int(3), rt.get_constant('HOUR_IN_SECONDS'))])
	mut var_category_translations := rt.create_array([rt.ArrayItem{ key: 'Layout', val: rt.call_function('__', [rt.new_string('Layout')]) }, rt.ArrayItem{ key: 'Features', val: rt.call_function('__', [rt.new_string('Features')]) }, rt.ArrayItem{ key: 'Subject', val: rt.call_function('__', [rt.new_string('Subject')]) }])
	mut var_wporg_features := rt.new_array()
	{
		mut iter_1 := rt.cast_array(var_feature_list).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_feature_items := item_1.val
			mut var_feature_category := item_1.key
			if var_category_translations.array_isset(var_feature_category) {
				var_feature_category = var_category_translations.array_get(var_feature_category)
			}
			var_wporg_features.array_set(var_feature_category, rt.new_array())
			{
				mut iter_2 := var_feature_items.iterator()
				for {
					item_2 := iter_2.next() or { break }
					mut var_feature := item_2.val
					var_wporg_features.array_get_mut(var_feature_category).array_set(var_feature, if !(var_features.array_get(var_feature_category).array_get(var_feature)).is_null() { var_features.array_get(var_feature_category).array_get(var_feature) } else { var_feature })
				}
			}
		}
	}
	return var_wporg_features.dup()
}

fn themes_api(action string, var_args rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.new_bool(var_args.dup().is_array())) {
		var_args = // unsupported expression: Expr_Cast_Object
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
		rt.set_property(var_args, 'wp_version', rt.call_function('substr', [rt.call_function('wp_get_wp_version', []rt.PhpVal{}), rt.new_int(0), rt.new_int(3)]))
		// unsupported statement: Stmt_Nop
	}
	var_args = rt.call_function('apply_filters', [rt.new_string('themes_api_args'), var_args.dup(), rt.new_string(action)])
	mut var_res := rt.call_function('apply_filters', [rt.new_string('themes_api'), rt.new_bool(false), rt.new_string(action), var_args.dup()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_res)))) {
		mut var_url := rt.new_string(rt.new_string('http://api.wordpress.org/themes/info/1.2/'))
		var_url = rt.call_function('add_query_arg', [rt.create_array([rt.ArrayItem{ key: 'action', val: action }, rt.ArrayItem{ key: 'request', val: var_args }]), var_url.dup()])
		mut var_http_url := var_url.dup()
		mut var_ssl := rt.call_function('wp_http_supports', [rt.create_array([rt.ArrayItem{ key: none, val: 'ssl' }])])
		if rt.is_true(var_ssl) {
			var_url = rt.call_function('set_url_scheme', [var_url.dup(), rt.new_string('https')])
		}
		mut var_http_args := { 'timeout': rt.new_int(15), 'user-agent':  +  + (rt.call_function('home_url', [])).str() }
		mut var_request := rt.call_function('wp_remote_get', [var_url.dup(), var_http_args.dup()])
		if rt.is_true(rt.new_bool(rt.is_true(var_ssl) && rt.is_true(rt.call_function('is_wp_error', [.dup()])))) {
			if rt.is_true(rt.new_bool(!(rt.is_true()))) {
				
			}
			
		}
		if rt.is_true() {
		} else {
		}
		if rt.is_true() {
		}
	}
	return rt.call_function('apply_filters', [, .dup(), , .dup()])
}

fn wp_prepare_themes_for_js(var_themes rt.PhpVal) rt.PhpVal {
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

struct Class_WP_Theme {
	rt.PhpObjectBase
}

fn create_wp_error() &Class_WP_Error {
	mut obj := &Class_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_theme() &Class_WP_Theme {
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




pub fn init_wp_admin_includes_theme_php() {
}
