import rt

fn wp_theme_auto_update_setting_template() rt.PhpVal {
	mut var_notice := rt.new_null()
	mut var_template := rt.new_null()
	var_notice = rt.call_function('wp_get_admin_notice', [rt.new_string(''),
		rt.create_array([rt.ArrayItem{ key: 'type', val: 'error' },
			rt.ArrayItem{ key: 'additional_classes', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'notice-alt' },
				rt.ArrayItem{ key: none, val: 'inline' },
				rt.ArrayItem{ key: none, val: 'hidden' },
			]) }])])
	var_template = rt.new_string(
		'\n\t\t<div class="theme-autoupdate">\n\t\t\t<# if ( data.autoupdate.supported ) { #>\n\t\t\t\t<# if ( data.autoupdate.forced === false ) { #>\n\t\t\t\t\t' +
		(rt.call_function('__', [rt.new_string('Auto-updates disabled')])).str() +
		'\n\t\t\t\t<# } else if ( data.autoupdate.forced ) { #>\n\t\t\t\t\t' +
		(rt.call_function('__', [rt.new_string('Auto-updates enabled')])).str() +
		'\n\t\t\t\t<# } else if ( data.autoupdate.enabled ) { #>\n\t\t\t\t\t<button type="button" class="toggle-auto-update button-link" data-slug="{{ data.id }}" data-wp-action="disable">\n\t\t\t\t\t\t<span class="dashicons dashicons-update spin hidden" aria-hidden="true"></span><span class="label">' +
		(rt.call_function('__', [rt.new_string('Disable auto-updates')])).str() +
		'</span>\n\t\t\t\t\t</button>\n\t\t\t\t<# } else { #>\n\t\t\t\t\t<button type="button" class="toggle-auto-update button-link" data-slug="{{ data.id }}" data-wp-action="enable">\n\t\t\t\t\t\t<span class="dashicons dashicons-update spin hidden" aria-hidden="true"></span><span class="label">' +
		(rt.call_function('__', [rt.new_string('Enable auto-updates')])).str() +
		'</span>\n\t\t\t\t\t</button>\n\t\t\t\t<# } #>\n\t\t\t<# } #>\n\t\t\t<# if ( data.hasUpdate ) { #>\n\t\t\t\t<# if ( data.autoupdate.supported && data.autoupdate.enabled ) { #>\n\t\t\t\t\t<span class="auto-update-time">\n\t\t\t\t<# } else { #>\n\t\t\t\t\t<span class="auto-update-time hidden">\n\t\t\t\t<# } #>\n\t\t\t\t<br />' +
		(rt.call_function('wp_get_auto_update_message', []rt.PhpVal{})).str() +
		'</span>\n\t\t\t<# } #>\n\t\t\t' + var_notice.str() + '\n\t\t</div>\n\t')
	return rt.call_function('apply_filters', [
		rt.new_string('theme_auto_update_setting_template'),
		var_template.clone(),
	])
}

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_submenu := rt.new_null()
	mut var_self := rt.new_null()
	rt.include_file(@DIR + '/admin.php', '4')
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('switch_themes')])))))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_theme_options')]))))) {
		rt.call_function('wp_die', [
			rt.new_string('<h1>' +
				(rt.call_function('__', [rt.new_string('You need a higher level of permission.')])).str() +
				'</h1>' + '<p>' +
				(rt.call_function('__', [rt.new_string('Sorry, you are not allowed to edit theme options on this site.')])).str() +
				'</p>'),
			rt.new_int(403),
		])
	}
	if rt.is_true(rt.call_function('current_user_can', [rt.new_string('switch_themes')]))
		&& rt.get_superglobal('_GET').array_isset(rt.new_string('action')) {
		if rt.is_true(rt.identical(rt.new_string('activate'),
			rt.get_superglobal('_GET').array_get(rt.new_string('action'))))
		{
			rt.call_function('check_admin_referer', [
				rt.new_string('switch-theme_' +
					(rt.get_superglobal('_GET').array_get(rt.new_string('stylesheet'))).str()),
			])
			mut var_theme := rt.call_function('wp_get_theme', [
				rt.get_superglobal('_GET').array_get(rt.new_string('stylesheet')),
			])
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_theme, 'exists', []rt.PhpVal{})))))
				|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_theme, 'is_allowed', []rt.PhpVal{}))))) {
				rt.call_function('wp_die', [
					rt.new_string('<h1>' +
						(rt.call_function('__', [rt.new_string('An error occurred.')])).str() +
						'</h1>' + '<p>' +
						(rt.call_function('__', [rt.new_string('The requested theme does not exist.')])).str() +
						'</p>'),
					rt.new_int(403),
				])
			}
			rt.call_function('switch_theme', [
				rt.call_method(var_theme, 'get_stylesheet', []rt.PhpVal{}),
			])
			rt.call_function('wp_redirect', [
				rt.call_function('admin_url', [
					rt.new_string('themes.php?activated=true'),
				]),
			])
			exit(0)
		} else if rt.is_true(rt.identical(rt.new_string('resume'),
			rt.get_superglobal('_GET').array_get(rt.new_string('action'))))
		{
			rt.call_function('check_admin_referer', [
				rt.new_string('resume-theme_' +
					(rt.get_superglobal('_GET').array_get(rt.new_string('stylesheet'))).str()),
			])
			var_theme = rt.call_function('wp_get_theme', [
				rt.get_superglobal('_GET').array_get(rt.new_string('stylesheet')),
			])
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
				rt.new_string('resume_theme'),
				rt.get_superglobal('_GET').array_get(rt.new_string('stylesheet')),
			])))))
			{
				rt.call_function('wp_die', [
					rt.new_string('<h1>' +
						(rt.call_function('__', [rt.new_string('You need a higher level of permission.')])).str() +
						'</h1>' + '<p>' +
						(rt.call_function('__', [rt.new_string('Sorry, you are not allowed to resume this theme.')])).str() +
						'</p>'),
					rt.new_int(403),
				])
			}
			mut var_result := rt.call_function('resume_theme', [
				rt.call_method(var_theme, 'get_stylesheet', []rt.PhpVal{}),
				rt.call_function('self_admin_url', [
					rt.new_string('themes.php?error=resuming'),
				]),
			])
			if rt.is_true(rt.call_function('is_wp_error', [var_result.clone()])) {
				rt.call_function('wp_die', [var_result.clone()])
			}
			rt.call_function('wp_redirect', [
				rt.call_function('admin_url', [rt.new_string('themes.php?resumed=true')]),
			])
			exit(0)
		} else if rt.is_true(rt.identical(rt.new_string('delete'),
			rt.get_superglobal('_GET').array_get(rt.new_string('action'))))
		{
			rt.call_function('check_admin_referer', [
				rt.new_string('delete-theme_' +
					(rt.get_superglobal('_GET').array_get(rt.new_string('stylesheet'))).str()),
			])
			var_theme = rt.call_function('wp_get_theme', [
				rt.get_superglobal('_GET').array_get(rt.new_string('stylesheet')),
			])
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
				rt.new_string('delete_themes'),
			])))))
			{
				rt.call_function('wp_die', [
					rt.new_string('<h1>' +
						(rt.call_function('__', [rt.new_string('You need a higher level of permission.')])).str() +
						'</h1>' + '<p>' +
						(rt.call_function('__', [rt.new_string('Sorry, you are not allowed to delete this item.')])).str() +
						'</p>'),
					rt.new_int(403),
				])
			}
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_theme, 'exists',
				[]rt.PhpVal{})))))
			{
				rt.call_function('wp_die', [
					rt.new_string('<h1>' +
						(rt.call_function('__', [rt.new_string('An error occurred while deleting the theme.')])).str() +
						'</h1>' + '<p>' +
						(rt.call_function('__', [rt.new_string('The requested theme does not exist.')])).str() +
						'</p>'),
					rt.new_int(403),
				])
			}
			mut var_active := rt.call_function('wp_get_theme', []rt.PhpVal{})
			if rt.is_true(rt.identical(rt.call_method(var_active, 'get', [
				rt.new_string('Template'),
			]), rt.get_superglobal('_GET').array_get(rt.new_string('stylesheet'))))
			{
				rt.call_function('wp_redirect', [
					rt.call_function('admin_url', [
						rt.new_string('themes.php?delete-active-child=true'),
					]),
				])
			} else {
				rt.call_function('delete_theme', [
					rt.get_superglobal('_GET').array_get(rt.new_string('stylesheet')),
				])
				rt.call_function('wp_redirect', [
					rt.call_function('admin_url', [
						rt.new_string('themes.php?deleted=true'),
					]),
				])
			}
			exit(0)
		} else if rt.is_true(rt.identical(rt.new_string('enable-auto-update'),
			rt.get_superglobal('_GET').array_get(rt.new_string('action'))))
		{
			if !(rt.is_true(rt.call_function('current_user_can', [rt.new_string('update_themes')]))
				&& rt.is_true(rt.call_function('wp_is_auto_update_enabled_for_type', [rt.new_string('theme')]))) {
				rt.call_function('wp_die', [
					rt.call_function('__', [
						rt.new_string('Sorry, you are not allowed to enable themes automatic updates.'),
					]),
				])
			}
			rt.call_function('check_admin_referer', [rt.new_string('updates')])
			mut var_all_items := rt.call_function('wp_get_themes', []rt.PhpVal{})
			mut var_auto_updates := rt.cast_array(rt.call_function('get_site_option', [
				rt.new_string('auto_update_themes'),
				rt.new_array(),
			]))
			var_auto_updates.array_push(rt.get_superglobal('_GET').array_get(rt.new_string('stylesheet')))
			var_auto_updates = rt.call_function('array_unique', [
				var_auto_updates.clone()])
			var_auto_updates = rt.call_function('array_intersect', [
				var_auto_updates.clone(), rt.func_array_keys(var_all_items.clone())])
			rt.call_function('update_site_option', [rt.new_string('auto_update_themes'),
				var_auto_updates.clone()])
			rt.call_function('wp_redirect', [
				rt.call_function('admin_url', [
					rt.new_string('themes.php?enabled-auto-update=true'),
				]),
			])
			exit(0)
		} else if rt.is_true(rt.identical(rt.new_string('disable-auto-update'),
			rt.get_superglobal('_GET').array_get(rt.new_string('action'))))
		{
			if !(rt.is_true(rt.call_function('current_user_can', [rt.new_string('update_themes')]))
				&& rt.is_true(rt.call_function('wp_is_auto_update_enabled_for_type', [rt.new_string('theme')]))) {
				rt.call_function('wp_die', [
					rt.call_function('__', [
						rt.new_string('Sorry, you are not allowed to disable themes automatic updates.'),
					]),
				])
			}
			rt.call_function('check_admin_referer', [rt.new_string('updates')])
			var_all_items = rt.call_function('wp_get_themes', []rt.PhpVal{})
			var_auto_updates = rt.cast_array(rt.call_function('get_site_option', [
				rt.new_string('auto_update_themes'),
				rt.new_array(),
			]))
			var_auto_updates = rt.call_function('array_diff', [
				var_auto_updates.clone(),
				rt.create_array([
					rt.ArrayItem{
						key: none
						val: rt.get_superglobal('_GET').array_get(rt.new_string('stylesheet'))
					},
				])])
			var_auto_updates = rt.call_function('array_intersect', [
				var_auto_updates.clone(), rt.func_array_keys(var_all_items.clone())])
			rt.call_function('update_site_option', [rt.new_string('auto_update_themes'),
				var_auto_updates.clone()])
			rt.call_function('wp_redirect', [
				rt.call_function('admin_url', [
					rt.new_string('themes.php?disabled-auto-update=true'),
				]),
			])
			exit(0)
		}
	}
	mut var_title := rt.call_function('__', [rt.new_string('Themes')])
	mut var_parent_file := 'themes.php'
	if rt.is_true(rt.call_function('current_user_can', [rt.new_string('switch_themes')])) {
		mut var_help_overview := rt.new_string('<p>' +
			(rt.call_function('__', [rt.new_string('This screen is used for managing your installed themes. Aside from the default theme(s) included with your WordPress installation, themes are designed and developed by third parties.')])).str() +
			'</p>' + '<p>' +
			(rt.call_function('__', [rt.new_string('From this screen you can:')])).str() + '</p>' +
			'<ul><li>' +
			(rt.call_function('__', [rt.new_string('Hover or tap to see Activate and Live Preview buttons')])).str() +
			'</li>' + '<li>' +
			(rt.call_function('__', [rt.new_string('Click on the theme to see the theme name, version, author, description, tags, and the Delete link')])).str() +
			'</li>' + '<li>' +
			(rt.call_function('__', [rt.new_string('Click Customize for the active theme or Live Preview for any other theme to see a live preview')])).str() +
			'</li></ul>' + '<p>' +
			(rt.call_function('__', [rt.new_string('The active theme is displayed highlighted as the first theme.')])).str() +
			'</p>' + '<p>' +
			(rt.call_function('__', [rt.new_string('The search for installed themes will search for terms in their name, description, author, or tag.')])).str() +
			' <span id="live-search-desc">' +
			(rt.call_function('__', [rt.new_string('The search results will be updated as you type.')])).str() +
			'</span></p>')
		rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'add_help_tab', [
			rt.create_array([rt.ArrayItem{ key: 'id', val: 'overview' },
				rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
					rt.new_string('Overview'),
				]) }, rt.ArrayItem{ key: 'content', val: var_help_overview }]),
		])
	}
	if rt.is_true(rt.call_function('current_user_can', [rt.new_string('install_themes')])) {
		if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) {
			mut var_help_install := rt.new_string('<p>' +
				(rt.call_function('__', [rt.new_string('Installing themes on Multisite can only be done from the Network Admin section.')])).str() +
				'</p>')
		} else {
			var_help_install = rt.new_string('<p>' +
				(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('If you would like to see more themes to choose from, click on the &#8220;Add Theme&#8221; button and you will be able to browse or search for additional themes from the <a href="%s">WordPress Theme Directory</a>. Themes in the WordPress Theme Directory are designed and developed by third parties, and are compatible with the license WordPress uses. Oh, and they are free!')]), rt.call_function('__', [rt.new_string('https://wordpress.org/themes/')])])).str() +
				'</p>')
		}
		rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'add_help_tab', [
			rt.create_array([rt.ArrayItem{ key: 'id', val: 'adding-themes' },
				rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
					rt.new_string('Adding Themes'),
				]) }, rt.ArrayItem{ key: 'content', val: var_help_install }]),
		])
	}
	if rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_theme_options')]))
		&& rt.is_true(rt.call_function('current_user_can', [rt.new_string('customize')])) {
		mut var_help_customize := rt.new_string('<p>' +
			(rt.call_function('__', [rt.new_string('Tap or hover on any theme then click the Live Preview button to see a live preview of that theme and change theme options in a separate, full-screen view. You can also find a Live Preview button at the bottom of the theme details screen. Any installed theme can be previewed and customized in this way.')])).str() +
			'</p>' + '<p>' +
			(rt.call_function('__', [rt.new_string('The theme being previewed is fully interactive &mdash; navigate to different pages to see how the theme handles posts, archives, and other page templates. The settings may differ depending on what theme features the theme being previewed supports. To accept the new settings and activate the theme all in one step, click the Activate &amp; Publish button above the menu.')])).str() +
			'</p>' + '<p>' +
			(rt.call_function('__', [rt.new_string('When previewing on smaller monitors, you can use the collapse icon at the bottom of the left-hand pane. This will hide the pane, giving you more room to preview your site in the new theme. To bring the pane back, click on the collapse icon again.')])).str() +
			'</p>')
		rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'add_help_tab', [
			rt.create_array([rt.ArrayItem{ key: 'id', val: 'customize-preview-themes' },
				rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
					rt.new_string('Previewing and Customizing'),
				]) }, rt.ArrayItem{ key: 'content', val: var_help_customize }]),
		])
	}
	mut var_help_sidebar_autoupdates := rt.new_string('')
	if rt.is_true(rt.call_function('current_user_can', [rt.new_string('update_themes')]))
		&& rt.is_true(rt.call_function('wp_is_auto_update_enabled_for_type', [rt.new_string('theme')])) {
		mut var_help_tab_autoupdates := rt.new_string('<p>' +
			(rt.call_function('__', [rt.new_string('Auto-updates can be enabled or disabled for each individual theme. Themes with auto-updates enabled will display the estimated date of the next auto-update. Auto-updates depends on the WP-Cron task scheduling system.')])).str() +
			'</p>' + '<p>' +
			(rt.call_function('__', [rt.new_string('Please note: Third-party themes and plugins, or custom code, may override WordPress scheduling.')])).str() +
			'</p>')
		rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'add_help_tab', [
			rt.create_array([
				rt.ArrayItem{ key: 'id', val: 'plugins-themes-auto-updates' },
				rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
					rt.new_string('Auto-updates'),
				]) },
				rt.ArrayItem{ key: 'content', val: var_help_tab_autoupdates },
			]),
		])
		var_help_sidebar_autoupdates = rt.new_string('<p>' +
			(rt.call_function('__', [rt.new_string('<a href="https://wordpress.org/documentation/article/plugins-themes-auto-updates/">Documentation on Auto-updates</a>')])).str() +
			'</p>')
	}
	rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'set_help_sidebar', [
		rt.new_string('<p><strong>' +
			(rt.call_function('__', [rt.new_string('For more information:')])).str() +
			'</strong></p>' + '<p>' +
			(rt.call_function('__', [rt.new_string('<a href="https://wordpress.org/documentation/article/work-with-themes/">Documentation on Using Themes</a>')])).str() +
			'</p>' + '<p>' +
			(rt.call_function('__', [rt.new_string('<a href="https://wordpress.org/documentation/article/appearance-themes-screen/">Documentation on Managing Themes</a>')])).str() +
			'</p>' + var_help_sidebar_autoupdates.str() + '<p>' +
			(rt.call_function('__', [rt.new_string('<a href="https://wordpress.org/support/forums/">Support forums</a>')])).str() +
			'</p>'),
	])
	if rt.is_true(rt.call_function('current_user_can', [rt.new_string('switch_themes')])) {
		mut var_themes := rt.call_function('wp_prepare_themes_for_js', []rt.PhpVal{})
	} else {
		var_themes = rt.call_function('wp_prepare_themes_for_js', [
			rt.create_array([
				rt.ArrayItem{ key: none, val: rt.call_function('wp_get_theme', []rt.PhpVal{}) },
			]),
		])
	}
	var_theme = if !(!rt.is_true(rt.get_superglobal('_REQUEST').array_get(rt.new_string('theme')))) { rt.call_function('sanitize_text_field', [
			rt.get_superglobal('_REQUEST').array_get(rt.new_string('theme')),
		]) } else { rt.new_string('') }
	mut var_search := if !(!rt.is_true(rt.get_superglobal('_REQUEST').array_get(rt.new_string('search')))) { rt.call_function('sanitize_text_field', [
			rt.get_superglobal('_REQUEST').array_get(rt.new_string('search')),
		]) } else { rt.new_string('') }
	rt.call_function('wp_localize_script', [rt.new_string('theme'),
		rt.new_string('_wpThemeSettings'),
		rt.create_array([
			rt.ArrayItem{ key: 'themes', val: var_themes },
			rt.ArrayItem{ key: 'settings', val: rt.create_array([
				rt.ArrayItem{
					key: 'canInstall'
					val:
						rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})))))
						&& rt.is_true(rt.call_function('current_user_can', [rt.new_string('install_themes')]))
				},
				rt.ArrayItem{
					key: 'installURI'
					val: if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{}))))) && rt.is_true(rt.call_function('current_user_can', [rt.new_string('install_themes')])) { rt.call_function('admin_url', [
							rt.new_string('theme-install.php'),
						]) } else { rt.new_null() }
				},
				rt.ArrayItem{ key: 'confirmDelete', val: rt.call_function('__', [
					rt.new_string("Are you sure you want to delete this theme?\n\nClick 'Cancel' to go back, 'OK' to confirm the delete."),
				]) },
				rt.ArrayItem{ key: 'adminUrl', val: rt.call_function('parse_url', [
					rt.call_function('admin_url', []rt.PhpVal{}),
					rt.get_constant('PHP_URL_PATH'),
				]) },
			]) },
			rt.ArrayItem{ key: 'l10n', val: rt.create_array([
				rt.ArrayItem{ key: 'addNew', val: rt.call_function('__', [
					rt.new_string('Add Theme'),
				]) },
				rt.ArrayItem{ key: 'search', val: rt.call_function('__', [
					rt.new_string('Search installed themes'),
				]) },
				rt.ArrayItem{ key: 'themesFound', val: rt.call_function('__', [
					rt.new_string('Number of Themes found: %d'),
				]) },
				rt.ArrayItem{ key: 'noThemesFound', val: rt.call_function('__', [
					rt.new_string('No themes found. Try a different search.'),
				]) },
			]) },
		])])
	rt.call_function('add_thickbox', []rt.PhpVal{})
	rt.call_function('wp_enqueue_script', [rt.new_string('theme')])
	rt.call_function('wp_enqueue_script', [rt.new_string('updates')])
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-header.php', '4')
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Themes')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(if !(!rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('search')))) { rt.call_function('__', [
			rt.new_string('&hellip;'),
		]) } else { rt.new_int(var_themes.clone().array_count()) })
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})))))
		&& rt.is_true(rt.call_function('current_user_can', [rt.new_string('install_themes')])) {
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_url', [
			rt.call_function('admin_url', [rt.new_string('theme-install.php')]),
		]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_html__', [rt.new_string('Add Theme')]))
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('validate_current_theme', []rt.PhpVal{})))))
		|| rt.get_superglobal('_GET').array_isset(rt.new_string('broken')) {
		rt.call_function('wp_admin_notice', [
			rt.call_function('__', [
				rt.new_string('The active theme is broken. Reverting to the default theme.'),
			]),
			rt.create_array([
				rt.ArrayItem{ key: 'id', val: 'message1' },
				rt.ArrayItem{ key: 'additional_classes', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'updated' },
				]) },
				rt.ArrayItem{ key: 'dismissible', val: true },
			]),
		])
	} else if rt.get_superglobal('_GET').array_isset(rt.new_string('activated')) {
		if rt.get_superglobal('_GET').array_isset(rt.new_string('previewed')) {
			rt.call_function('wp_admin_notice', [
				rt.new_string(
					(rt.call_function('__', [rt.new_string('Settings saved and theme activated.')])).str() +
					' <a href="' +
					(rt.call_function('esc_url', [rt.call_function('home_url', [rt.new_string('/')])])).str() +
					'">' + (rt.call_function('__', [rt.new_string('Visit site')])).str() + '</a>'),
				rt.create_array([
					rt.ArrayItem{ key: 'id', val: 'message2' },
					rt.ArrayItem{ key: 'additional_classes', val: rt.create_array([
						rt.ArrayItem{ key: none, val: 'updated' },
					]) },
					rt.ArrayItem{ key: 'dismissible', val: true },
				]),
			])
		} else {
			rt.call_function('wp_admin_notice', [
				rt.new_string(
					(rt.call_function('__', [rt.new_string('New theme activated.')])).str() +
					' <a href="' +
					(rt.call_function('esc_url', [rt.call_function('home_url', [rt.new_string('/')])])).str() +
					'">' + (rt.call_function('__', [rt.new_string('Visit site')])).str() + '</a>'),
				rt.create_array([
					rt.ArrayItem{ key: 'id', val: 'message2' },
					rt.ArrayItem{ key: 'additional_classes', val: rt.create_array([
						rt.ArrayItem{ key: none, val: 'updated' },
					]) },
					rt.ArrayItem{ key: 'dismissible', val: true },
				]),
			])
		}
	} else if rt.get_superglobal('_GET').array_isset(rt.new_string('deleted')) {
		rt.call_function('wp_admin_notice', [
			rt.call_function('__', [rt.new_string('Theme deleted.')]),
			rt.create_array([rt.ArrayItem{ key: 'id', val: 'message3' },
				rt.ArrayItem{ key: 'additional_classes', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'updated' },
				]) }, rt.ArrayItem{ key: 'dismissible', val: true }]),
		])
	} else if rt.get_superglobal('_GET').array_isset(rt.new_string('delete-active-child')) {
		rt.call_function('wp_admin_notice', [
			rt.call_function('__', [
				rt.new_string('You cannot delete a theme while it has an active child theme.'),
			]),
			rt.create_array([
				rt.ArrayItem{ key: 'id', val: 'message4' },
				rt.ArrayItem{ key: 'additional_classes', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'error' },
				]) },
			]),
		])
	} else if rt.get_superglobal('_GET').array_isset(rt.new_string('resumed')) {
		rt.call_function('wp_admin_notice', [
			rt.call_function('__', [rt.new_string('Theme resumed.')]),
			rt.create_array([rt.ArrayItem{ key: 'id', val: 'message5' },
				rt.ArrayItem{ key: 'additional_classes', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'updated' },
				]) }, rt.ArrayItem{ key: 'dismissible', val: true }]),
		])
	} else if rt.get_superglobal('_GET').array_isset(rt.new_string('error'))
		&& rt.is_true(rt.identical(rt.new_string('resuming'), rt.get_superglobal('_GET').array_get(rt.new_string('error')))) {
		rt.call_function('wp_admin_notice', [
			rt.call_function('__', [
				rt.new_string('Theme could not be resumed because it triggered a <strong>fatal error</strong>.'),
			]),
			rt.create_array([
				rt.ArrayItem{ key: 'id', val: 'message6' },
				rt.ArrayItem{ key: 'additional_classes', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'error' },
				]) },
			]),
		])
	} else if rt.get_superglobal('_GET').array_isset(rt.new_string('enabled-auto-update')) {
		rt.call_function('wp_admin_notice', [
			rt.call_function('__', [rt.new_string('Theme will be auto-updated.')]),
			rt.create_array([rt.ArrayItem{ key: 'id', val: 'message7' },
				rt.ArrayItem{ key: 'additional_classes', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'updated' },
				]) }, rt.ArrayItem{ key: 'dismissible', val: true }]),
		])
	} else if rt.get_superglobal('_GET').array_isset(rt.new_string('disabled-auto-update')) {
		rt.call_function('wp_admin_notice', [
			rt.call_function('__', [
				rt.new_string('Theme will no longer be auto-updated.'),
			]),
			rt.create_array([
				rt.ArrayItem{ key: 'id', val: 'message8' },
				rt.ArrayItem{ key: 'additional_classes', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'updated' },
				]) },
				rt.ArrayItem{ key: 'dismissible', val: true },
			]),
		])
	}
	mut var_current_theme := rt.call_function('wp_get_theme', []rt.PhpVal{})
	if rt.is_true(rt.call_method(var_current_theme, 'errors', []rt.PhpVal{}))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})))))
		|| rt.is_true(rt.call_function('current_user_can', [rt.new_string('manage_network_themes')])) {
		rt.call_function('wp_admin_notice', [
			rt.new_string('<strong>' + (rt.call_function('__', [rt.new_string('Error:')])).str() +
				'</strong> ' +(rt.call_method(rt.call_method(var_current_theme, 'errors', []rt.PhpVal{}), 'get_error_message', []rt.PhpVal{})).str()),
			rt.create_array([rt.ArrayItem{ key: 'additional_classes', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'error' },
			]) }]),
		])
	}
	mut var_current_theme_actions := rt.new_array()
	if var_submenu.clone().is_array() && var_submenu.array_isset(rt.new_string('themes.php')) {
		mut var_forbidden_paths := ['themes.php', 'theme-editor.php', 'site-editor.php',
			'edit.php?post_type=wp_navigation']
		mut iter_1 := rt.cast_array(var_submenu.array_get(rt.new_string('themes.php'))).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_item := item_1.val
			mut var_class := ''
			if rt.is_true(rt.call_function('in_array', [var_item.array_get(rt.new_int(2)), rt.create_array_from_list(var_forbidden_paths), rt.new_bool(true)]))
				|| rt.is_true(rt.call_function('str_starts_with', [var_item.array_get(rt.new_int(2)), rt.new_string('customize.php')])) {
				continue
			}
			if (rt.is_true(rt.identical(rt.new_int(0), rt.call_function('strcmp', [var_self.clone(), var_item.array_get(rt.new_int(2))])))
				&& var_parent_file == '') || (var_parent_file.len > 0 && var_parent_file != '0'
				&& rt.is_true(rt.identical(var_item.array_get(rt.new_int(2)), rt.new_string(var_parent_file.str())))) {
				var_class = ' current'
			}
			if !(!rt.is_true(var_submenu.array_get(var_item.array_get(rt.new_int(2))))) {
				var_submenu.array_set(var_item.array_get(rt.new_int(2)), rt.call_function('array_values', [
					var_submenu.array_get(var_item.array_get(rt.new_int(2))),
				]))
				mut var_menu_hook := rt.call_function('get_plugin_page_hook', [
					var_submenu.array_get(var_item.array_get(rt.new_int(2))).array_get(rt.new_int(0)).array_get(rt.new_int(2)),
					var_item.array_get(rt.new_int(2)),
				])
				if rt.is_true(rt.call_function('file_exists', [rt.new_string((rt.get_constant('WP_PLUGIN_DIR')).str() + rt.concat(rt.new_string('/'), var_submenu.array_get(var_item.array_get(rt.new_int(2))).array_get(rt.new_int(0)).array_get(rt.new_int(2))))]))
					|| !(!rt.is_true(var_menu_hook)) {
					var_current_theme_actions << rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string("<a class='button"),
						rt.new_string(var_class.str())), rt.new_string("' href='admin.php?page=")),
						var_submenu.array_get(var_item.array_get(rt.new_int(2))).array_get(rt.new_int(0)).array_get(rt.new_int(2))),
						rt.new_string("'>")), var_item.array_get(rt.new_int(0))),
						rt.new_string('</a>'))
				} else {
					var_current_theme_actions << rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string("<a class='button"),
						rt.new_string(var_class.str())), rt.new_string("' href='")),
						var_submenu.array_get(var_item.array_get(rt.new_int(2))).array_get(rt.new_int(0)).array_get(rt.new_int(2))),
						rt.new_string("'>")), var_item.array_get(rt.new_int(0))),
						rt.new_string('</a>'))
				}
			} else if !(!rt.is_true(var_item.array_get(rt.new_int(2))))
				&& rt.is_true(rt.call_function('current_user_can', [var_item.array_get(rt.new_int(1))])) {
				mut var_menu_file := var_item.array_get(rt.new_int(2))
				if rt.is_true(rt.call_function('current_user_can', [
					rt.new_string('customize'),
				]))
				{
					if rt.is_true(rt.identical(rt.new_string('custom-header'), var_menu_file)) {
						var_current_theme_actions << rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string("<a class='button hide-if-no-customize"),
							rt.new_string(var_class.str())),
							rt.new_string("' href='customize.php?autofocus[control]=header_image'>")),
							var_item.array_get(rt.new_int(0))), rt.new_string('</a>'))
					} else if rt.is_true(rt.identical(rt.new_string('custom-background'),
						var_menu_file))
					{
						var_current_theme_actions << rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string("<a class='button hide-if-no-customize"),
							rt.new_string(var_class.str())),
							rt.new_string("' href='customize.php?autofocus[control]=background_image'>")),
							var_item.array_get(rt.new_int(0))), rt.new_string('</a>'))
					}
				}
				mut var_pos := rt.call_function('strpos', [var_menu_file.clone(),
					rt.new_string('?')])
				if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_pos)))) {
					var_menu_file = rt.call_function('substr', [
						var_menu_file.clone(), rt.new_int(0),
						var_pos.clone()])
				}
				if rt.is_true(rt.call_function('file_exists', [
					rt.new_string(
						(rt.get_constant('ABSPATH')).str() + 'wp-admin/${var_menu_file.to_string()}'),
				]))
				{
					var_current_theme_actions << rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string("<a class='button"),
						rt.new_string(var_class.str())), rt.new_string("' href='")),
						var_item.array_get(rt.new_int(2))), rt.new_string("'>")),
						var_item.array_get(rt.new_int(0))), rt.new_string('</a>'))
				} else {
					var_current_theme_actions << rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string("<a class='button"),
						rt.new_string(var_class.str())), rt.new_string("' href='themes.php?page=")),
						var_item.array_get(rt.new_int(2))), rt.new_string("'>")),
						var_item.array_get(rt.new_int(0))), rt.new_string('</a>'))
				}
			}
		}
	}
	mut var_class_name := 'theme-browser'
	if !(!rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('search')))) {
		var_class_name = var_class_name + ' search-loading'
	}
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [rt.new_string(var_class_name.str()).clone()]))
	// unsupported statement: Stmt_InlineHTML
	mut iter_2 := var_themes.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_theme_shadow := item_2.val
		mut var_aria_action := rt.new_string(
			(var_theme_shadow.array_get(rt.new_string('id'))).str() + '-action')
		mut var_aria_name := rt.new_string(
			(var_theme_shadow.array_get(rt.new_string('id'))).str() + '-name')
		mut var_active_class := ''
		if rt.is_true(var_theme_shadow.array_get(rt.new_string('active'))) {
			var_active_class = ' active'
		}
		// unsupported statement: Stmt_InlineHTML
		print(var_active_class)
		// unsupported statement: Stmt_InlineHTML
		if !(!rt.is_true(var_theme_shadow.array_get(rt.new_string('screenshot')).array_get(rt.new_int(0)))) {
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_url', [
				rt.new_string(
					(var_theme_shadow.array_get(rt.new_string('screenshot')).array_get(rt.new_int(0))).str() +
					'?ver=' + (var_theme_shadow.array_get(rt.new_string('version'))).str()),
			]))
			// unsupported statement: Stmt_InlineHTML
		} else {
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(var_theme_shadow.array_get(rt.new_string('hasUpdate'))) {
			// unsupported statement: Stmt_InlineHTML
			if rt.is_true(var_theme_shadow.array_get(rt.new_string('updateResponse')).array_get(rt.new_string('compatibleWP')))
				&& rt.is_true(var_theme_shadow.array_get(rt.new_string('updateResponse')).array_get(rt.new_string('compatiblePHP'))) {
				if rt.is_true(var_theme_shadow.array_get(rt.new_string('hasPackage'))) {
					mut var_new_version_available := rt.call_function('__', [
						rt.new_string('New version available. <button class="button-link" type="button">Update now</button>'),
					])
				} else {
					var_new_version_available = rt.call_function('__', [
						rt.new_string('New version available.'),
					])
				}
				rt.call_function('wp_admin_notice', [var_new_version_available.clone(),
					rt.create_array([rt.ArrayItem{ key: 'type', val: 'warning' },
						rt.ArrayItem{ key: 'additional_classes', val: rt.create_array([
							rt.ArrayItem{ key: none, val: 'notice-alt' },
							rt.ArrayItem{ key: none, val: 'inline' },
							rt.ArrayItem{ key: none, val: 'update-message' },
						]) }])])
			} else {
				mut var_theme_update_error := ''
				if rt.is_true(rt.new_bool(!(rt.is_true(var_theme_shadow.array_get(rt.new_string('updateResponse')).array_get(rt.new_string('compatibleWP'))))))
					&& rt.is_true(rt.new_bool(!(rt.is_true(var_theme_shadow.array_get(rt.new_string('updateResponse')).array_get(rt.new_string('compatiblePHP')))))) {
					var_theme_update_error = var_theme_update_error +(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('There is a new version of %s available, but it does not work with your versions of WordPress and PHP.')]), var_theme_shadow.array_get(rt.new_string('name'))])).str()
					if rt.is_true(rt.call_function('current_user_can', [rt.new_string('update_core')]))
						&& rt.is_true(rt.call_function('current_user_can', [rt.new_string('update_php')])) {
						var_theme_update_error = var_theme_update_error +
							(rt.call_function('sprintf', [rt.new_string(' ' +(rt.call_function('__', [rt.new_string('<a href="%1$s">Please update WordPress</a>, and then <a href="%2$s">learn more about updating PHP</a>.')])).str()), rt.call_function('self_admin_url', [rt.new_string('update-core.php')]), rt.call_function('esc_url', [rt.call_function('wp_get_update_php_url', []rt.PhpVal{})])])).str()
						rt.call_function('wp_update_php_annotation', [
							rt.new_string('</p><p><em>'),
							rt.new_string('</em>'),
							rt.new_bool(false),
						])
					} else if rt.is_true(rt.call_function('current_user_can', [
						rt.new_string('update_core'),
					]))
					{
						var_theme_update_error = var_theme_update_error +
							(rt.call_function('sprintf', [rt.new_string(' ' +(rt.call_function('__', [rt.new_string('<a href="%s">Please update WordPress</a>.')])).str()), rt.call_function('self_admin_url', [rt.new_string('update-core.php')])])).str()
					} else if rt.is_true(rt.call_function('current_user_can', [
						rt.new_string('update_php'),
					]))
					{
						var_theme_update_error = var_theme_update_error +
							(rt.call_function('sprintf', [rt.new_string(' ' +(rt.call_function('__', [rt.new_string('<a href="%s">Learn more about updating PHP</a>.')])).str()), rt.call_function('esc_url', [rt.call_function('wp_get_update_php_url', []rt.PhpVal{})])])).str()
						rt.call_function('wp_update_php_annotation', [
							rt.new_string('</p><p><em>'),
							rt.new_string('</em>'),
							rt.new_bool(false),
						])
					}
				} else if rt.is_true(rt.new_bool(!(rt.is_true(var_theme_shadow.array_get(rt.new_string('updateResponse')).array_get(rt.new_string('compatibleWP')))))) {
					var_theme_update_error = var_theme_update_error +(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('There is a new version of %s available, but it does not work with your version of WordPress.')]), var_theme_shadow.array_get(rt.new_string('name'))])).str()
					if rt.is_true(rt.call_function('current_user_can', [
						rt.new_string('update_core'),
					]))
					{
						var_theme_update_error = var_theme_update_error +
							(rt.call_function('sprintf', [rt.new_string(' ' +(rt.call_function('__', [rt.new_string('<a href="%s">Please update WordPress</a>.')])).str()), rt.call_function('self_admin_url', [rt.new_string('update-core.php')])])).str()
					}
				} else if rt.is_true(rt.new_bool(!(rt.is_true(var_theme_shadow.array_get(rt.new_string('updateResponse')).array_get(rt.new_string('compatiblePHP')))))) {
					var_theme_update_error = var_theme_update_error +(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('There is a new version of %s available, but it does not work with your version of PHP.')]), var_theme_shadow.array_get(rt.new_string('name'))])).str()
					if rt.is_true(rt.call_function('current_user_can', [
						rt.new_string('update_php'),
					]))
					{
						var_theme_update_error = var_theme_update_error +
							(rt.call_function('sprintf', [rt.new_string(' ' +(rt.call_function('__', [rt.new_string('<a href="%s">Learn more about updating PHP</a>.')])).str()), rt.call_function('esc_url', [rt.call_function('wp_get_update_php_url', []rt.PhpVal{})])])).str()
						rt.call_function('wp_update_php_annotation', [
							rt.new_string('</p><p><em>'),
							rt.new_string('</em>'),
							rt.new_bool(false),
						])
					}
				}
				rt.call_function('wp_admin_notice', [rt.new_string(var_theme_update_error.str()).clone(),
					rt.create_array([rt.ArrayItem{ key: 'type', val: 'error' },
						rt.ArrayItem{ key: 'additional_classes', val: rt.create_array([
							rt.ArrayItem{ key: none, val: 'notice-alt' },
							rt.ArrayItem{ key: none, val: 'inline' },
							rt.ArrayItem{ key: none, val: 'update-message' },
						]) }])])
			}
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(var_theme_shadow.array_get(rt.new_string('compatibleWP'))))))
			|| rt.is_true(rt.new_bool(!(rt.is_true(var_theme_shadow.array_get(rt.new_string('compatiblePHP')))))) {
			mut var_message := rt.new_string('')
			if rt.is_true(rt.new_bool(!(rt.is_true(var_theme_shadow.array_get(rt.new_string('compatibleWP'))))))
				&& rt.is_true(rt.new_bool(!(rt.is_true(var_theme_shadow.array_get(rt.new_string('compatiblePHP')))))) {
				var_message = rt.call_function('__', [
					rt.new_string('This theme does not work with your versions of WordPress and PHP.'),
				])
				if rt.is_true(rt.call_function('current_user_can', [rt.new_string('update_core')]))
					&& rt.is_true(rt.call_function('current_user_can', [rt.new_string('update_php')])) {
					var_message = rt.concat(var_message, rt.call_function('sprintf', [
						rt.new_string(' ' +(rt.call_function('__', [rt.new_string('<a href="%1$s">Please update WordPress</a>, and then <a href="%2$s">learn more about updating PHP</a>.')])).str()),
						rt.call_function('self_admin_url', [
							rt.new_string('update-core.php'),
						]),
						rt.call_function('esc_url', [
							rt.call_function('wp_get_update_php_url', []rt.PhpVal{}),
						]),
					]))
					var_message = rt.concat(var_message, rt.call_function('wp_update_php_annotation', [
						rt.new_string('</p><p><em>'),
						rt.new_string('</em>'),
						rt.new_bool(false),
					]))
				} else if rt.is_true(rt.call_function('current_user_can', [
					rt.new_string('update_core'),
				]))
				{
					var_message = rt.concat(var_message, rt.call_function('sprintf', [
						rt.new_string(' ' +(rt.call_function('__', [rt.new_string('<a href="%s">Please update WordPress</a>.')])).str()),
						rt.call_function('self_admin_url', [
							rt.new_string('update-core.php'),
						]),
					]))
				} else if rt.is_true(rt.call_function('current_user_can', [
					rt.new_string('update_php'),
				]))
				{
					var_message = rt.concat(var_message, rt.call_function('sprintf', [
						rt.new_string(' ' +(rt.call_function('__', [rt.new_string('<a href="%s">Learn more about updating PHP</a>.')])).str()),
						rt.call_function('esc_url', [
							rt.call_function('wp_get_update_php_url', []rt.PhpVal{}),
						]),
					]))
					var_message = rt.concat(var_message, rt.call_function('wp_update_php_annotation', [
						rt.new_string('</p><p><em>'),
						rt.new_string('</em>'),
						rt.new_bool(false),
					]))
				}
			} else if rt.is_true(rt.new_bool(!(rt.is_true(var_theme_shadow.array_get(rt.new_string('compatibleWP')))))) {
				var_message = rt.concat(var_message, rt.call_function('__', [
					rt.new_string('This theme does not work with your version of WordPress.'),
				]))
				if rt.is_true(rt.call_function('current_user_can', [
					rt.new_string('update_core'),
				]))
				{
					var_message = rt.concat(var_message, rt.call_function('sprintf', [
						rt.new_string(' ' +(rt.call_function('__', [rt.new_string('<a href="%s">Please update WordPress</a>.')])).str()),
						rt.call_function('self_admin_url', [
							rt.new_string('update-core.php'),
						]),
					]))
				}
			} else if rt.is_true(rt.new_bool(!(rt.is_true(var_theme_shadow.array_get(rt.new_string('compatiblePHP')))))) {
				var_message = rt.concat(var_message, rt.call_function('__', [
					rt.new_string('This theme does not work with your version of PHP.'),
				]))
				if rt.is_true(rt.call_function('current_user_can', [
					rt.new_string('update_php'),
				]))
				{
					var_message = rt.concat(var_message, rt.call_function('sprintf', [
						rt.new_string(' ' +(rt.call_function('__', [rt.new_string('<a href="%s">Learn more about updating PHP</a>.')])).str()),
						rt.call_function('esc_url', [
							rt.call_function('wp_get_update_php_url', []rt.PhpVal{}),
						]),
					]))
					var_message = rt.concat(var_message, rt.call_function('wp_update_php_annotation', [
						rt.new_string('</p><p><em>'),
						rt.new_string('</em>'),
						rt.new_bool(false),
					]))
				}
			}
			rt.call_function('wp_admin_notice', [var_message.clone(),
				rt.create_array([rt.ArrayItem{ key: 'type', val: 'error' },
					rt.ArrayItem{ key: 'additional_classes', val: rt.create_array([
						rt.ArrayItem{ key: none, val: 'inline' },
						rt.ArrayItem{ key: none, val: 'notice-alt' },
					]) }])])
		}
		mut var_details_aria_label := rt.call_function('sprintf', [
			rt.call_function('_x', [rt.new_string('View Theme Details for %s'),
				rt.new_string('theme')]),
			var_theme_shadow.array_get(rt.new_string('name')),
		])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [var_aria_action.clone()]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [var_details_aria_label.clone()]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Theme Details')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('printf', [rt.call_function('__', [rt.new_string('By %s')]),
			var_theme_shadow.array_get(rt.new_string('author'))])
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(var_theme_shadow.array_get(rt.new_string('active'))) {
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [var_aria_name.clone()]))
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('_ex', [rt.new_string('Active:'),
				rt.new_string('theme')])
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(var_theme_shadow.array_get(rt.new_string('name')))
			// unsupported statement: Stmt_InlineHTML
		} else {
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [var_aria_name.clone()]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(var_theme_shadow.array_get(rt.new_string('name')))
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(var_theme_shadow.array_get(rt.new_string('active'))) {
			// unsupported statement: Stmt_InlineHTML
			if rt.is_true(var_theme_shadow.array_get(rt.new_string('actions')).array_get(rt.new_string('customize')))
				&& rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_theme_options')]))
				&& rt.is_true(rt.call_function('current_user_can', [rt.new_string('customize')])) {
				mut var_customize_aria_label := rt.call_function('sprintf', [
					rt.call_function('_x', [rt.new_string('Customize %s'),
						rt.new_string('theme')]),
					var_theme_shadow.array_get(rt.new_string('name')),
				])
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_url', [
					var_theme_shadow.array_get(rt.new_string('actions')).array_get(rt.new_string('customize')),
				]))
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_attr', [var_customize_aria_label.clone()]))
				// unsupported statement: Stmt_InlineHTML
				rt.call_function('_e', [rt.new_string('Customize')])
				// unsupported statement: Stmt_InlineHTML
			}
			// unsupported statement: Stmt_InlineHTML
		} else if rt.is_true(var_theme_shadow.array_get(rt.new_string('compatibleWP')))
			&& rt.is_true(var_theme_shadow.array_get(rt.new_string('compatiblePHP'))) {
			// unsupported statement: Stmt_InlineHTML
			mut var_aria_label := rt.call_function('sprintf', [
				rt.call_function('_x', [rt.new_string('Activate %s'),
					rt.new_string('theme')]),
				rt.new_string('{{ data.name }}'),
			])
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_url', [
				var_theme_shadow.array_get(rt.new_string('actions')).array_get(rt.new_string('activate')),
			]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [var_aria_label.clone()]))
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('_e', [rt.new_string('Activate')])
			// unsupported statement: Stmt_InlineHTML
			if rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_theme_options')]))
				&& rt.is_true(var_theme_shadow.array_get(rt.new_string('blockTheme')))
				|| rt.is_true(rt.call_function('current_user_can', [rt.new_string('customize')])) {
				mut var_live_preview_aria_label := rt.call_function('sprintf', [
					rt.call_function('_x', [rt.new_string('Live Preview %s'),
						rt.new_string('theme')]),
					rt.new_string('{{ data.name }}'),
				])
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_url', [
					var_theme_shadow.array_get(rt.new_string('actions')).array_get(rt.new_string('customize')),
				]))
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_attr', [var_live_preview_aria_label.clone()]))
				// unsupported statement: Stmt_InlineHTML
				rt.call_function('_e', [rt.new_string('Live Preview')])
				// unsupported statement: Stmt_InlineHTML
			}
			// unsupported statement: Stmt_InlineHTML
		} else {
			// unsupported statement: Stmt_InlineHTML
			var_aria_label = rt.call_function('sprintf', [
				rt.call_function('_x', [rt.new_string('Cannot Activate %s'),
					rt.new_string('theme')]),
				rt.new_string('{{ data.name }}'),
			])
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [var_aria_label.clone()]))
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('_ex', [rt.new_string('Cannot Activate'),
				rt.new_string('theme')])
			// unsupported statement: Stmt_InlineHTML
			if rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_theme_options')]))
				&& rt.is_true(rt.call_function('current_user_can', [rt.new_string('customize')])) {
				var_live_preview_aria_label = rt.call_function('sprintf', [
					rt.call_function('_x', [rt.new_string('Live Preview %s'),
						rt.new_string('theme')]),
					rt.new_string('{{ data.name }}'),
				])
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_attr', [var_live_preview_aria_label.clone()]))
				// unsupported statement: Stmt_InlineHTML
				rt.call_function('_e', [rt.new_string('Live Preview')])
				// unsupported statement: Stmt_InlineHTML
			}
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('Theme Details')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('No themes found. Try a different search.')])
	// unsupported statement: Stmt_InlineHTML
	mut var_broken_themes := rt.call_function('wp_get_themes', [
		rt.create_array([rt.ArrayItem{ key: 'errors', val: true }]),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})))))
		&& rt.is_true(var_broken_themes) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Broken Themes')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [
			rt.new_string('The following themes are installed but incomplete.'),
		])
		// unsupported statement: Stmt_InlineHTML
		mut var_can_resume := rt.call_function('current_user_can', [
			rt.new_string('resume_themes'),
		])
		mut var_can_delete := rt.call_function('current_user_can', [
			rt.new_string('delete_themes'),
		])
		mut var_can_install := rt.call_function('current_user_can', [
			rt.new_string('install_themes'),
		])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_ex', [rt.new_string('Name'), rt.new_string('theme name')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Description')])
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(var_can_resume) {
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(var_can_delete) {
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(var_can_install) {
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
		mut iter_3 := var_broken_themes.iterator()
		for {
			item_3 := iter_3.next() or { break }
			mut var_broken_theme := item_3.val
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(if rt.is_true(rt.call_method(var_broken_theme, 'get', [
				rt.new_string('Name'),
			]))
			{ rt.call_method(var_broken_theme, 'display', [rt.new_string('Name')]) } else { rt.call_function('esc_html', [
					rt.call_method(var_broken_theme, 'get_stylesheet', []rt.PhpVal{}),
				]) })
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_method(rt.call_method(var_broken_theme, 'errors', []rt.PhpVal{}),
				'get_error_message', []rt.PhpVal{}))
			// unsupported statement: Stmt_InlineHTML
			if rt.is_true(var_can_resume) {
				if rt.is_true(rt.identical(rt.new_string('theme_paused'), rt.call_method(rt.call_method(var_broken_theme,
					'errors', []rt.PhpVal{}), 'get_error_code', []rt.PhpVal{})))
				{
					mut var_stylesheet := rt.call_method(var_broken_theme, 'get_stylesheet',
						[]rt.PhpVal{})
					mut var_resume_url := rt.call_function('add_query_arg', [
						rt.create_array([rt.ArrayItem{ key: 'action', val: 'resume' },
							rt.ArrayItem{ key: 'stylesheet', val: rt.call_function('urlencode', [
								var_stylesheet.clone(),
							]) }]),
						rt.call_function('admin_url', [rt.new_string('themes.php')]),
					])
					var_resume_url = rt.call_function('wp_nonce_url', [
						var_resume_url.clone(), rt.new_string('resume-theme_' + var_stylesheet.str())])
					// unsupported statement: Stmt_InlineHTML
					rt.echo_val(rt.call_function('esc_url', [
						var_resume_url.clone()]))
					// unsupported statement: Stmt_InlineHTML
					rt.call_function('_e', [rt.new_string('Resume')])
					// unsupported statement: Stmt_InlineHTML
				} else {
					// unsupported statement: Stmt_InlineHTML
				}
			}
			if rt.is_true(var_can_delete) {
				var_stylesheet = rt.call_method(var_broken_theme, 'get_stylesheet', []rt.PhpVal{})
				mut var_delete_url := rt.call_function('add_query_arg', [
					rt.create_array([rt.ArrayItem{ key: 'action', val: 'delete' },
						rt.ArrayItem{ key: 'stylesheet', val: rt.call_function('urlencode', [
							var_stylesheet.clone(),
						]) }]),
					rt.call_function('admin_url', [rt.new_string('themes.php')]),
				])
				var_delete_url = rt.call_function('wp_nonce_url', [
					var_delete_url.clone(), rt.new_string('delete-theme_' + var_stylesheet.str())])
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_url', [var_delete_url.clone()]))
				// unsupported statement: Stmt_InlineHTML
				rt.call_function('_e', [rt.new_string('Delete')])
				// unsupported statement: Stmt_InlineHTML
			}
			if rt.is_true(var_can_install)
				&& rt.is_true(rt.identical(rt.new_string('theme_no_parent'), rt.call_method(rt.call_method(var_broken_theme, 'errors', []rt.PhpVal{}), 'get_error_code', []rt.PhpVal{}))) {
				mut var_parent_theme_name := rt.call_method(var_broken_theme, 'get', [
					rt.new_string('Template'),
				])
				mut var_parent_theme := rt.call_function('themes_api', [
					rt.new_string('theme_information'),
					rt.create_array([
						rt.ArrayItem{ key: 'slug', val: rt.call_function('urlencode', [
							var_parent_theme_name.clone(),
						]) },
					]),
				])
				if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [
					var_parent_theme.clone(),
				])))))
				{
					mut var_install_url := rt.call_function('add_query_arg', [
						rt.create_array([
							rt.ArrayItem{ key: 'action', val: 'install-theme' },
							rt.ArrayItem{ key: 'theme', val: rt.call_function('urlencode', [
								var_parent_theme_name.clone(),
							]) },
						]),
						rt.call_function('admin_url', [
							rt.new_string('update.php'),
						]),
					])
					var_install_url = rt.call_function('wp_nonce_url', [
						var_install_url.clone(),
						rt.new_string('install-theme_' +
							var_parent_theme_name.str())])
					// unsupported statement: Stmt_InlineHTML
					rt.echo_val(rt.call_function('esc_url', [
						var_install_url.clone()]))
					// unsupported statement: Stmt_InlineHTML
					rt.call_function('_e', [rt.new_string('Install Parent Theme')])
					// unsupported statement: Stmt_InlineHTML
				}
			}
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [
		rt.new_string('New version available. <button class="button-link" type="button">Update now</button>'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('New version available.')])
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
	mut var_details_aria_label := rt.call_function('sprintf', [
		rt.call_function('_x', [rt.new_string('View Theme Details for %s'),
			rt.new_string('theme')]),
		rt.new_string('{{ data.name }}'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_details_aria_label.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Theme Details')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('printf', [rt.call_function('__', [rt.new_string('By %s')]),
		rt.new_string('{{{ data.author }}}')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_ex', [rt.new_string('Active:'), rt.new_string('theme')])
	// unsupported statement: Stmt_InlineHTML
	mut var_customize_aria_label := rt.call_function('sprintf', [
		rt.call_function('_x', [rt.new_string('Customize %s'),
			rt.new_string('theme')]),
		rt.new_string('{{ data.name }}'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_customize_aria_label.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Customize')])
	// unsupported statement: Stmt_InlineHTML
	mut var_aria_label := rt.call_function('sprintf', [
		rt.call_function('_x', [rt.new_string('Activate %s'),
			rt.new_string('theme')]),
		rt.new_string('{{ data.name }}'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_aria_label.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Activate')])
	// unsupported statement: Stmt_InlineHTML
	mut var_live_preview_aria_label := rt.call_function('sprintf', [
		rt.call_function('_x', [rt.new_string('Live Preview %s'),
			rt.new_string('theme')]),
		rt.new_string('{{ data.name }}'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_live_preview_aria_label.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Live Preview')])
	// unsupported statement: Stmt_InlineHTML
	var_aria_label = rt.call_function('sprintf', [
		rt.call_function('_x', [rt.new_string('Cannot Activate %s'),
			rt.new_string('theme')]),
		rt.new_string('{{ data.name }}'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_aria_label.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_ex', [rt.new_string('Cannot Activate'),
		rt.new_string('theme')])
	// unsupported statement: Stmt_InlineHTML
	var_live_preview_aria_label = rt.call_function('sprintf', [
		rt.call_function('_x', [rt.new_string('Live Preview %s'),
			rt.new_string('theme')]),
		rt.new_string('{{ data.name }}'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_live_preview_aria_label.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Live Preview')])
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
	rt.echo_val(wp_theme_auto_update_setting_template())
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('printf', [
		rt.call_function('__', [rt.new_string('This is a child theme of %s.')]),
		rt.new_string('<strong>{{{ data.parent }}}</strong>'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Tags:')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Customize')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('implode', [rt.new_string(' '),
		rt.create_array_from_list(var_current_theme_actions)]))
	// unsupported statement: Stmt_InlineHTML
	var_live_preview_aria_label = rt.call_function('sprintf', [
		rt.call_function('_x', [rt.new_string('Live Preview %s'),
			rt.new_string('theme')]),
		rt.new_string('{{ data.name }}'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_live_preview_aria_label.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Live Preview')])
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
	var_live_preview_aria_label = rt.call_function('sprintf', [
		rt.call_function('_x', [rt.new_string('Live Preview %s'),
			rt.new_string('theme')]),
		rt.new_string('{{ data.name }}'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_live_preview_aria_label.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Live Preview')])
	// unsupported statement: Stmt_InlineHTML
	var_aria_label = rt.call_function('sprintf', [
		rt.call_function('_x', [rt.new_string('Cannot Activate %s'),
			rt.new_string('theme')]),
		rt.new_string('{{ data.name }}'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_aria_label.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_ex', [rt.new_string('Cannot Activate'),
		rt.new_string('theme')])
	// unsupported statement: Stmt_InlineHTML
	var_aria_label = rt.call_function('sprintf', [
		rt.call_function('_x', [rt.new_string('Delete %s'), rt.new_string('theme')]),
		rt.new_string('{{ data.name }}'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_aria_label.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Delete')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('wp_print_request_filesystem_credentials_modal', []rt.PhpVal{})
	rt.call_function('wp_print_admin_notice_templates', []rt.PhpVal{})
	rt.call_function('wp_print_update_row_templates', []rt.PhpVal{})
	rt.call_function('wp_localize_script', [rt.new_string('updates'),
		rt.new_string('_wpUpdatesItemCounts'),
		rt.create_array([
			rt.ArrayItem{ key: 'totals', val: rt.call_function('wp_get_update_data', []rt.PhpVal{}) },
		])])
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-footer.php', '4')
}
