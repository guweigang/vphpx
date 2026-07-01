import rt


fn main() {
	defer {
		rt.shutdown()
	}

	mut var_submenu := rt.new_null()
	mut var_self := rt.new_null()
	rt.include_file(@DIR + '/admin.php', '4')
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('switch_themes')]))))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_theme_options')]))))))) {
		rt.call_function('wp_die', ['<h1>' + (rt.call_function('__', [rt.new_string('You need a higher level of permission.')])).str() + '</h1>' + '<p>' + (rt.call_function('__', [rt.new_string('Sorry, you are not allowed to edit theme options on this site.')])).str() + '</p>', rt.new_int(403)])
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('current_user_can', [rt.new_string('switch_themes')])) && rt.get_superglobal('_GET').array_isset(rt.new_string('action')))) {
		if rt.is_true(rt.identical(rt.new_string('activate'), rt.get_superglobal('_GET').array_get('action'))) {
			rt.call_function('check_admin_referer', ['switch-theme_' + (rt.get_superglobal('_GET').array_get('stylesheet')).str()])
			mut var_theme := rt.call_function('wp_get_theme', [rt.get_superglobal('_GET').array_get('stylesheet')])
			if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_theme, 'exists', []rt.PhpVal{}))))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_theme, 'is_allowed', []rt.PhpVal{}))))))) {
				rt.call_function('wp_die', ['<h1>' + (rt.call_function('__', [rt.new_string('An error occurred.')])).str() + '</h1>' + '<p>' + (rt.call_function('__', [rt.new_string('The requested theme does not exist.')])).str() + '</p>', rt.new_int(403)])
			}
			rt.call_function('switch_theme', [rt.call_method(var_theme, 'get_stylesheet', []rt.PhpVal{})])
			rt.call_function('wp_redirect', [rt.call_function('admin_url', [rt.new_string('themes.php?activated=true')])])
			// unsupported expression: Expr_Exit
		} else if rt.is_true(rt.identical(rt.new_string('resume'), rt.get_superglobal('_GET').array_get('action'))) {
			rt.call_function('check_admin_referer', ['resume-theme_' + (rt.get_superglobal('_GET').array_get('stylesheet')).str()])
			var_theme = rt.call_function('wp_get_theme', [rt.get_superglobal('_GET').array_get('stylesheet')])
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('resume_theme'), rt.get_superglobal('_GET').array_get('stylesheet')]))))) {
				rt.call_function('wp_die', ['<h1>' + (rt.call_function('__', [rt.new_string('You need a higher level of permission.')])).str() + '</h1>' + '<p>' + (rt.call_function('__', [rt.new_string('Sorry, you are not allowed to resume this theme.')])).str() + '</p>', rt.new_int(403)])
			}
			mut var_result := rt.call_function('resume_theme', [rt.call_method(var_theme, 'get_stylesheet', []rt.PhpVal{}), rt.call_function('self_admin_url', [rt.new_string('themes.php?error=resuming')])])
			if rt.is_true(rt.call_function('is_wp_error', [var_result.dup()])) {
				rt.call_function('wp_die', [var_result.dup()])
			}
			rt.call_function('wp_redirect', [rt.call_function('admin_url', [rt.new_string('themes.php?resumed=true')])])
			// unsupported expression: Expr_Exit
		} else if rt.is_true(rt.identical(rt.new_string('delete'), rt.get_superglobal('_GET').array_get('action'))) {
			rt.call_function('check_admin_referer', ['delete-theme_' + (rt.get_superglobal('_GET').array_get('stylesheet')).str()])
			var_theme = rt.call_function('wp_get_theme', [rt.get_superglobal('_GET').array_get('stylesheet')])
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('delete_themes')]))))) {
				rt.call_function('wp_die', ['<h1>' + (rt.call_function('__', [rt.new_string('You need a higher level of permission.')])).str() + '</h1>' + '<p>' + (rt.call_function('__', [rt.new_string('Sorry, you are not allowed to delete this item.')])).str() + '</p>', rt.new_int(403)])
			}
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_theme, 'exists', []rt.PhpVal{}))))) {
				rt.call_function('wp_die', ['<h1>' + (rt.call_function('__', [rt.new_string('An error occurred while deleting the theme.')])).str() + '</h1>' + '<p>' + (rt.call_function('__', [rt.new_string('The requested theme does not exist.')])).str() + '</p>', rt.new_int(403)])
			}
			mut var_active := rt.call_function('wp_get_theme', []rt.PhpVal{})
			if rt.is_true(rt.identical(rt.call_method(var_active, 'get', [rt.new_string('Template')]), rt.get_superglobal('_GET').array_get('stylesheet'))) {
				rt.call_function('wp_redirect', [rt.call_function('admin_url', [rt.new_string('themes.php?delete-active-child=true')])])
			} else {
				rt.call_function('delete_theme', [rt.get_superglobal('_GET').array_get('stylesheet')])
				rt.call_function('wp_redirect', [rt.call_function('admin_url', [rt.new_string('themes.php?deleted=true')])])
			}
			// unsupported expression: Expr_Exit
		} else if rt.is_true(rt.identical(rt.new_string('enable-auto-update'), rt.get_superglobal('_GET').array_get('action'))) {
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.is_true(rt.call_function('current_user_can', [rt.new_string('update_themes')])) && rt.is_true(rt.call_function('wp_is_auto_update_enabled_for_type', [rt.new_string('theme')]))))))) {
				rt.call_function('wp_die', [rt.call_function('__', [rt.new_string('Sorry, you are not allowed to enable themes automatic updates.')])])
			}
			rt.call_function('check_admin_referer', [rt.new_string('updates')])
			mut var_all_items := rt.call_function('wp_get_themes', []rt.PhpVal{})
			mut var_auto_updates := rt.cast_array(rt.call_function('get_site_option', [rt.new_string('auto_update_themes'), rt.new_array()]))
			var_auto_updates.array_push(rt.get_superglobal('_GET').array_get('stylesheet'))
			var_auto_updates = rt.call_function('array_unique', [var_auto_updates.dup()])
			var_auto_updates = rt.call_function('array_intersect', [var_auto_updates.dup(), rt.func_array_keys(var_all_items.dup())])
			rt.call_function('update_site_option', [rt.new_string('auto_update_themes'), var_auto_updates.dup()])
			rt.call_function('wp_redirect', [rt.call_function('admin_url', [rt.new_string('themes.php?enabled-auto-update=true')])])
			// unsupported expression: Expr_Exit
		} else if rt.is_true(rt.identical(rt.new_string('disable-auto-update'), rt.get_superglobal('_GET').array_get('action'))) {
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.is_true(rt.call_function('current_user_can', [rt.new_string('update_themes')])) && rt.is_true(rt.call_function('wp_is_auto_update_enabled_for_type', [rt.new_string('theme')]))))))) {
				rt.call_function('wp_die', [rt.call_function('__', [rt.new_string('Sorry, you are not allowed to disable themes automatic updates.')])])
			}
			rt.call_function('check_admin_referer', [rt.new_string('updates')])
			var_all_items = rt.call_function('wp_get_themes', []rt.PhpVal{})
			var_auto_updates = rt.cast_array(rt.call_function('get_site_option', [rt.new_string('auto_update_themes'), rt.new_array()]))
			var_auto_updates = rt.call_function('array_diff', [var_auto_updates.dup(), rt.create_array([rt.ArrayItem{ key: none, val: rt.get_superglobal('_GET').array_get('stylesheet') }])])
			var_auto_updates = rt.call_function('array_intersect', [var_auto_updates.dup(), rt.func_array_keys(var_all_items.dup())])
			rt.call_function('update_site_option', [rt.new_string('auto_update_themes'), var_auto_updates.dup()])
			rt.call_function('wp_redirect', [rt.call_function('admin_url', [rt.new_string('themes.php?disabled-auto-update=true')])])
			// unsupported expression: Expr_Exit
		}
	}
	mut var_title := rt.call_function('__', [rt.new_string('Themes')])
	mut var_parent_file := 'themes.php'
	if rt.is_true(rt.call_function('current_user_can', [rt.new_string('switch_themes')])) {
		mut var_help_overview := rt.new_string('<p>' + (rt.call_function('__', [rt.new_string('This screen is used for managing your installed themes. Aside from the default theme(s) included with your WordPress installation, themes are designed and developed by third parties.')])).str() + '</p>' + '<p>' + (rt.call_function('__', [rt.new_string('From this screen you can:')])).str() + '</p>' + '<ul><li>' + (rt.call_function('__', [rt.new_string('Hover or tap to see Activate and Live Preview buttons')])).str() + '</li>' + '<li>' + (rt.call_function('__', [rt.new_string('Click on the theme to see the theme name, version, author, description, tags, and the Delete link')])).str() + '</li>' + '<li>' + (rt.call_function('__', [rt.new_string('Click Customize for the active theme or Live Preview for any other theme to see a live preview')])).str() + '</li></ul>' + '<p>' + (rt.call_function('__', [rt.new_string('The active theme is displayed highlighted as the first theme.')])).str() + '</p>' + '<p>' + (rt.call_function('__', [rt.new_string('The search for installed themes will search for terms in their name, description, author, or tag.')])).str() + ' <span id="live-search-desc">' + (rt.call_function('__', [rt.new_string('The search results will be updated as you type.')])).str() + '</span></p>')
		rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'add_help_tab', [rt.create_array([rt.ArrayItem{ key: 'id', val: 'overview' }, rt.ArrayItem{ key: 'title', val: rt.call_function('__', [rt.new_string('Overview')]) }, rt.ArrayItem{ key: 'content', val: var_help_overview }])])
	}
	if rt.is_true(rt.call_function('current_user_can', [rt.new_string('install_themes')])) {
		if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) {
			mut var_help_install := rt.new_string('<p>' + (rt.call_function('__', [rt.new_string('Installing themes on Multisite can only be done from the Network Admin section.')])).str() + '</p>')
		} else {
			var_help_install = rt.new_string('<p>' + (rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('If you would like to see more themes to choose from, click on the &#8220;Add Theme&#8221; button and you will be able to browse or search for additional themes from the <a href="%s">WordPress Theme Directory</a>. Themes in the WordPress Theme Directory are designed and developed by third parties, and are compatible with the license WordPress uses. Oh, and they are free!')]), rt.call_function('__', [rt.new_string('https://wordpress.org/themes/')])])).str() + '</p>')
		}
		rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'add_help_tab', [rt.create_array([rt.ArrayItem{ key: 'id', val: 'adding-themes' }, rt.ArrayItem{ key: 'title', val: rt.call_function('__', [rt.new_string('Adding Themes')]) }, rt.ArrayItem{ key: 'content', val: var_help_install }])])
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_theme_options')])) && rt.is_true(rt.call_function('current_user_can', [rt.new_string('customize')])))) {
		mut var_help_customize := rt.new_string('<p>' + (rt.call_function('__', [rt.new_string('Tap or hover on any theme then click the Live Preview button to see a live preview of that theme and change theme options in a separate, full-screen view. You can also find a Live Preview button at the bottom of the theme details screen. Any installed theme can be previewed and customized in this way.')])).str() + '</p>' + '<p>' + (rt.call_function('__', [rt.new_string('The theme being previewed is fully interactive &mdash; navigate to different pages to see how the theme handles posts, archives, and other page templates. The settings may differ depending on what theme features the theme being previewed supports. To accept the new settings and activate the theme all in one step, click the Activate &amp; Publish button above the menu.')])).str() + '</p>' + '<p>' + (rt.call_function('__', [rt.new_string('When previewing on smaller monitors, you can use the collapse icon at the bottom of the left-hand pane. This will hide the pane, giving you more room to preview your site in the new theme. To bring the pane back, click on the collapse icon again.')])).str() + '</p>')
		rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'add_help_tab', [rt.create_array([rt.ArrayItem{ key: 'id', val: 'customize-preview-themes' }, rt.ArrayItem{ key: 'title', val: rt.call_function('__', [rt.new_string('Previewing and Customizing')]) }, rt.ArrayItem{ key: 'content', val: var_help_customize }])])
	}
	mut var_help_sidebar_autoupdates := rt.new_string(rt.new_string(''))
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('current_user_can', [rt.new_string('update_themes')])) && rt.is_true(rt.call_function('wp_is_auto_update_enabled_for_type', [rt.new_string('theme')])))) {
		mut var_help_tab_autoupdates := rt.new_string('<p>' + (rt.call_function('__', [rt.new_string('Auto-updates can be enabled or disabled for each individual theme. Themes with auto-updates enabled will display the estimated date of the next auto-update. Auto-updates depends on the WP-Cron task scheduling system.')])).str() + '</p>' + '<p>' + (rt.call_function('__', [rt.new_string('Please note: Third-party themes and plugins, or custom code, may override WordPress scheduling.')])).str() + '</p>')
		rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'add_help_tab', [rt.create_array([rt.ArrayItem{ key: 'id', val: 'plugins-themes-auto-updates' }, rt.ArrayItem{ key: 'title', val: rt.call_function('__', [rt.new_string('Auto-updates')]) }, rt.ArrayItem{ key: 'content', val: var_help_tab_autoupdates }])])
		var_help_sidebar_autoupdates = rt.new_string('<p>' + (rt.call_function('__', [rt.new_string('<a href="https://wordpress.org/documentation/article/plugins-themes-auto-updates/">Documentation on Auto-updates</a>')])).str() + '</p>')
	}
	rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'set_help_sidebar', ['<p><strong>' + (rt.call_function('__', [rt.new_string('For more information:')])).str() + '</strong></p>' + '<p>' + (rt.call_function('__', [rt.new_string('<a href="https://wordpress.org/documentation/article/work-with-themes/">Documentation on Using Themes</a>')])).str() + '</p>' + '<p>' + (rt.call_function('__', [rt.new_string('<a href="https://wordpress.org/documentation/article/appearance-themes-screen/">Documentation on Managing Themes</a>')])).str() + '</p>' + (var_help_sidebar_autoupdates).str() + '<p>' + (rt.call_function('__', [rt.new_string('<a href="https://wordpress.org/support/forums/">Support forums</a>')])).str() + '</p>'])
	if rt.is_true(rt.call_function('current_user_can', [rt.new_string('switch_themes')])) {
		mut var_themes := rt.call_function('wp_prepare_themes_for_js', []rt.PhpVal{})
	} else {
		var_themes = rt.call_function('wp_prepare_themes_for_js', [rt.create_array([rt.ArrayItem{ key: none, val: rt.call_function('wp_get_theme', []rt.PhpVal{}) }])])
	}
	var_theme = if !(!rt.is_true(rt.get_superglobal('_REQUEST').array_get('theme'))) { rt.call_function('sanitize_text_field', [rt.get_superglobal('_REQUEST').array_get('theme')]) } else { rt.new_string('') }
	mut var_search := if !(!rt.is_true(rt.get_superglobal('_REQUEST').array_get('search'))) { rt.call_function('sanitize_text_field', [rt.get_superglobal('_REQUEST').array_get('search')]) } else { rt.new_string('') }
	rt.call_function('wp_localize_script', [rt.new_string('theme'), rt.new_string('_wpThemeSettings'), rt.create_array([rt.ArrayItem{ key: 'themes', val: var_themes }, rt.ArrayItem{ key: 'settings', val: rt.create_array([rt.ArrayItem{ key: 'canInstall', val: rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{}))))) && rt.is_true(rt.call_function('current_user_can', [rt.new_string('install_themes')])) }, rt.ArrayItem{ key: 'installURI', val: if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{}))))) && rt.is_true(rt.call_function('current_user_can', [rt.new_string('install_themes')])))) { rt.call_function('admin_url', [rt.new_string('theme-install.php')]) } else { rt.new_null() } }, rt.ArrayItem{ key: 'confirmDelete', val: rt.call_function('__', [rt.new_string('Are you sure you want to delete this theme?\n\nClick \'Cancel\' to go back, \'OK\' to confirm the delete.')]) }, rt.ArrayItem{ key: 'adminUrl', val: rt.call_function('parse_url', [rt.call_function('admin_url', []rt.PhpVal{}), rt.get_constant('PHP_URL_PATH')]) }]) }, rt.ArrayItem{ key: 'l10n', val: rt.create_array([rt.ArrayItem{ key: 'addNew', val: rt.call_function('__', [rt.new_string('Add Theme')]) }, rt.ArrayItem{ key: 'search', val: rt.call_function('__', [rt.new_string('Search installed themes')]) }, rt.ArrayItem{ key: 'themesFound', val: rt.call_function('__', [rt.new_string('Number of Themes found: %d')]) }, rt.ArrayItem{ key: 'noThemesFound', val: rt.call_function('__', [rt.new_string('No themes found. Try a different search.')]) }]) }])])
	rt.call_function('add_thickbox', []rt.PhpVal{})
	rt.call_function('wp_enqueue_script', [rt.new_string('theme')])
	rt.call_function('wp_enqueue_script', [rt.new_string('updates')])
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-header.php', '4')
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Themes')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(if !(!rt.is_true(rt.get_superglobal('_GET').array_get('search'))) { rt.call_function('__', [rt.new_string('&hellip;')]) } else { rt.new_int(var_themes.dup().array_count()) })
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{}))))) && rt.is_true(rt.call_function('current_user_can', [rt.new_string('install_themes')])))) {
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_url', [rt.call_function('admin_url', [rt.new_string('theme-install.php')])]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_html__', [rt.new_string('Add Theme')]))
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('validate_current_theme', []rt.PhpVal{}))))) || rt.get_superglobal('_GET').array_isset(rt.new_string('broken')))) {
		rt.call_function('wp_admin_notice', [rt.call_function('__', [rt.new_string('The active theme is broken. Reverting to the default theme.')]), rt.create_array([rt.ArrayItem{ key: 'id', val: 'message1' }, rt.ArrayItem{ key: 'additional_classes', val: rt.create_array([rt.ArrayItem{ key: none, val: 'updated' }]) }, rt.ArrayItem{ key: 'dismissible', val: true }])])
	} else if rt.get_superglobal('_GET').array_isset(rt.new_string('activated')) {
		if rt.get_superglobal('_GET').array_isset(rt.new_string('previewed')) {
			rt.call_function('wp_admin_notice', [(rt.call_function('__', [rt.new_string('Settings saved and theme activated.')])).str() + ' <a href="' + (rt.call_function('esc_url', [rt.call_function('home_url', [rt.new_string('/')])])).str() + '">' + (rt.call_function('__', [rt.new_string('Visit site')])).str() + '</a>', rt.create_array([rt.ArrayItem{ key: 'id', val: 'message2' }, rt.ArrayItem{ key: 'additional_classes', val: rt.create_array([rt.ArrayItem{ key: none, val: 'updated' }]) }, rt.ArrayItem{ key: 'dismissible', val: true }])])
		} else {
			rt.call_function('wp_admin_notice', [(rt.call_function('__', [rt.new_string('New theme activated.')])).str() + ' <a href="' + (rt.call_function('esc_url', [rt.call_function('home_url', [rt.new_string('/')])])).str() + '">' + (rt.call_function('__', [rt.new_string('Visit site')])).str() + '</a>', rt.create_array([rt.ArrayItem{ key: 'id', val: 'message2' }, rt.ArrayItem{ key: 'additional_classes', val: rt.create_array([rt.ArrayItem{ key: none, val: 'updated' }]) }, rt.ArrayItem{ key: 'dismissible', val: true }])])
		}
	} else if rt.get_superglobal('_GET').array_isset(rt.new_string('deleted')) {
		rt.call_function('wp_admin_notice', [rt.call_function('__', [rt.new_string('Theme deleted.')]), rt.create_array([rt.ArrayItem{ key: 'id', val: 'message3' }, rt.ArrayItem{ key: 'additional_classes', val: rt.create_array([rt.ArrayItem{ key: none, val: 'updated' }]) }, rt.ArrayItem{ key: 'dismissible', val: true }])])
	} else if rt.get_superglobal('_GET').array_isset(rt.new_string('delete-active-child')) {
		rt.call_function('wp_admin_notice', [rt.call_function('__', [rt.new_string('You cannot delete a theme while it has an active child theme.')]), rt.create_array([rt.ArrayItem{ key: 'id', val: 'message4' }, rt.ArrayItem{ key: 'additional_classes', val: rt.create_array([rt.ArrayItem{ key: none, val: 'error' }]) }])])
	} else if rt.get_superglobal('_GET').array_isset(rt.new_string('resumed')) {
		rt.call_function('wp_admin_notice', [rt.call_function('__', [rt.new_string('Theme resumed.')]), rt.create_array([rt.ArrayItem{ key: 'id', val: 'message5' }, rt.ArrayItem{ key: 'additional_classes', val: rt.create_array([rt.ArrayItem{ key: none, val: 'updated' }]) }, rt.ArrayItem{ key: 'dismissible', val: true }])])
	} else if rt.is_true(rt.new_bool(rt.get_superglobal('_GET').array_isset(rt.new_string('error')) && rt.is_true(rt.identical(rt.new_string('resuming'), rt.get_superglobal('_GET').array_get('error'))))) {
		rt.call_function('wp_admin_notice', [rt.call_function('__', [rt.new_string('Theme could not be resumed because it triggered a <strong>fatal error</strong>.')]), rt.create_array([rt.ArrayItem{ key: 'id', val: 'message6' }, rt.ArrayItem{ key: 'additional_classes', val: rt.create_array([rt.ArrayItem{ key: none, val: 'error' }]) }])])
	} else if rt.get_superglobal('_GET').array_isset(rt.new_string('enabled-auto-update')) {
		rt.call_function('wp_admin_notice', [rt.call_function('__', [rt.new_string('Theme will be auto-updated.')]), rt.create_array([rt.ArrayItem{ key: 'id', val: 'message7' }, rt.ArrayItem{ key: 'additional_classes', val: rt.create_array([rt.ArrayItem{ key: none, val: 'updated' }]) }, rt.ArrayItem{ key: 'dismissible', val: true }])])
	} else if rt.get_superglobal('_GET').array_isset(rt.new_string('disabled-auto-update')) {
		rt.call_function('wp_admin_notice', [rt.call_function('__', [rt.new_string('Theme will no longer be auto-updated.')]), rt.create_array([rt.ArrayItem{ key: 'id', val: 'message8' }, rt.ArrayItem{ key: 'additional_classes', val: rt.create_array([rt.ArrayItem{ key: none, val: 'updated' }]) }, rt.ArrayItem{ key: 'dismissible', val: true }])])
	}
	mut var_current_theme := rt.call_function('wp_get_theme', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_method(var_current_theme, 'errors', []rt.PhpVal{})) && rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{}))))) || rt.is_true(rt.call_function('current_user_can', [rt.new_string('manage_network_themes')])))))) {
		rt.call_function('wp_admin_notice', ['<strong>' + (rt.call_function('__', [rt.new_string('Error:')])).str() + '</strong> ' + (rt.call_method(rt.call_method(var_current_theme, 'errors', []rt.PhpVal{}), 'get_error_message', []rt.PhpVal{})).str(), rt.create_array([rt.ArrayItem{ key: 'additional_classes', val: rt.create_array([rt.ArrayItem{ key: none, val: 'error' }]) }])])
	}
	mut var_current_theme_actions := rt.new_array()
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_submenu.dup().is_array())) && var_submenu.array_isset(rt.new_string('themes.php')))) {
		mut var_forbidden_paths := ['themes.php', 'theme-editor.php', 'site-editor.php', 'edit.php?post_type=wp_navigation']
		{
			mut iter_1 := rt.cast_array(var_submenu.array_get('themes.php')).iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_item := item_1.val
				mut var_class := ''
				if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('in_array', [var_item.array_get(2), var_forbidden_paths.dup(), rt.new_bool(true)])) || rt.is_true(rt.call_function('str_starts_with', [var_item.array_get(2), rt.new_string('customize.php')])))) {
					continue
				}
				if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_int(0), rt.call_function('strcmp', [var_self.dup(), .array_get()]))) && var_parent_file == '')) || rt.is_true(rt.new_bool(var_parent_file.len > 0 && var_parent_file != '0' && rt.is_true(rt.identical(var_item.array_get(2), rt.new_string(var_parent_file))))))) {
					var_class = ' current'
				}
				if !(!rt.is_true(var_submenu.array_get(var_item.array_get(2)))) {
					var_submenu.array_set(var_item.array_get(2), rt.call_function('array_values', [.array_get()]))
					mut var_menu_hook := rt.call_function('get_plugin_page_hook', [, ])
					if rt.is_true(rt.new_bool(rt.is_true() || !(!rt.is_true()))) {
						
					} else {
					}
				} else if rt.is_true(rt.new_bool(!(!rt.is_true()) && rt.is_true())) {
					
				}
			}
		}
	}
	mut var_class_name := 
	if !(!rt.is_true()) {
	}
	// unsupported statement: Stmt_InlineHTML
}
