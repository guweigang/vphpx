import rt


fn main() {
	defer {
		rt.shutdown()
	}

	mut var_paged := rt.new_null()
	rt.include_file(@DIR + '/admin.php', '4')
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/theme-install.php', '3')
	mut var_tab := if !(!rt.is_true(rt.get_superglobal('_REQUEST').array_get('tab'))) { rt.call_function('sanitize_text_field', [rt.get_superglobal('_REQUEST').array_get('tab')]) } else { rt.new_string('') }
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('install_themes')]))))) {
		rt.call_function('wp_die', [rt.call_function('__', [rt.new_string('Sorry, you are not allowed to install themes on this site.')])])
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_network_admin', []rt.PhpVal{}))))))) {
		rt.call_function('wp_redirect', [rt.call_function('network_admin_url', [rt.new_string('theme-install.php')])])
		// unsupported expression: Expr_Exit
	}
	mut var_title := rt.call_function('__', [rt.new_string('Add Themes')])
	mut var_parent_file := 'themes.php'
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_network_admin', []rt.PhpVal{}))))) {
		mut var_submenu_file := 'themes.php'
	}
	mut var_installed_themes := rt.call_function('search_theme_directories', []rt.PhpVal{})
	if rt.is_true(rt.identical(rt.new_bool(false), var_installed_themes)) {
		var_installed_themes = rt.new_array()
	}
	{
		mut iter_1 := var_installed_themes.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_theme_data := item_1.val
			mut var_theme_slug := item_1.key
			if rt.is_true(rt.call_function('str_contains', [var_theme_slug.dup(), rt.new_string('/')])) {
				var_installed_themes.array_unset(var_theme_slug)
			}
		}
	}
	rt.call_function('wp_localize_script', [rt.new_string('theme'), rt.new_string('_wpThemeSettings'), rt.create_array([rt.ArrayItem{ key: 'themes', val: false }, rt.ArrayItem{ key: 'settings', val: rt.create_array([rt.ArrayItem{ key: 'isInstall', val: true }, rt.ArrayItem{ key: 'canInstall', val: rt.call_function('current_user_can', [rt.new_string('install_themes')]) }, rt.ArrayItem{ key: 'installURI', val: if rt.is_true(rt.call_function('current_user_can', [rt.new_string('install_themes')])) { rt.call_function('self_admin_url', [rt.new_string('theme-install.php')]) } else { rt.new_null() } }, rt.ArrayItem{ key: 'adminUrl', val: rt.call_function('parse_url', [rt.call_function('self_admin_url', []rt.PhpVal{}), rt.get_constant('PHP_URL_PATH')]) }]) }, rt.ArrayItem{ key: 'l10n', val: rt.create_array([rt.ArrayItem{ key: 'addNew', val: rt.call_function('__', [rt.new_string('Add Theme')]) }, rt.ArrayItem{ key: 'search', val: rt.call_function('__', [rt.new_string('Search Themes')]) }, rt.ArrayItem{ key: 'upload', val: rt.call_function('__', [rt.new_string('Upload Theme')]) }, rt.ArrayItem{ key: 'back', val: rt.call_function('__', [rt.new_string('Back')]) }, rt.ArrayItem{ key: 'error', val: rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('An unexpected error occurred. Something may be wrong with WordPress.org or this server&#8217;s configuration. If you continue to have problems, please try the <a href="%s">support forums</a>.')]), rt.call_function('__', [rt.new_string('https://wordpress.org/support/forums/')])]) }, rt.ArrayItem{ key: 'tryAgain', val: rt.call_function('__', [rt.new_string('Try Again')]) }, rt.ArrayItem{ key: 'themesFound', val: rt.call_function('__', [rt.new_string('Number of Themes found: %d')]) }, rt.ArrayItem{ key: 'noThemesFound', val: rt.call_function('__', [rt.new_string('No themes found. Try a different search.')]) }, rt.ArrayItem{ key: 'collapseSidebar', val: rt.call_function('__', [rt.new_string('Collapse Sidebar')]) }, rt.ArrayItem{ key: 'expandSidebar', val: rt.call_function('__', [rt.new_string('Expand Sidebar')]) }, rt.ArrayItem{ key: 'selectFeatureFilter', val: rt.call_function('__', [rt.new_string('Select one or more Theme features to filter by')]) }]) }, rt.ArrayItem{ key: 'installedThemes', val: rt.func_array_keys(var_installed_themes.dup()) }, rt.ArrayItem{ key: 'activeTheme', val: rt.call_function('get_stylesheet', []rt.PhpVal{}) }])])
	rt.call_function('wp_enqueue_script', [rt.new_string('theme')])
	rt.call_function('wp_enqueue_script', [rt.new_string('updates')])
	if rt.is_true(var_tab) {
		rt.call_function('do_action', [rt.new_string("install_themes_pre_${var_tab.to_string()}")])
	}
	mut var_help_overview := rt.new_string('<p>' + (rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('You can find additional themes for your site by using the Theme Browser/Installer on this screen, which will display themes from the <a href="%s">WordPress Theme Directory</a>. These themes are designed and developed by third parties, are available free of charge, and are compatible with the license WordPress uses.')]), rt.call_function('__', [rt.new_string('https://wordpress.org/themes/')])])).str() + '</p>' + '<p>' + (rt.call_function('__', [rt.new_string('You can Search for themes by keyword, author, or tag, or can get more specific and search by criteria listed in the feature filter.')])).str() + ' <span id="live-search-desc">' + (rt.call_function('__', [rt.new_string('The search results will be updated as you type.')])).str() + '</span></p>' + '<p>' + (rt.call_function('__', [rt.new_string('Alternately, you can browse the themes that are Popular or Latest. When you find a theme you like, you can preview it or install it.')])).str() + '</p>' + '<p>' + (rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('You can Upload a theme manually if you have already downloaded its ZIP archive onto your computer (make sure it is from a trusted and original source). You can also do it the old-fashioned way and copy a downloaded theme&#8217;s folder via FTP into your %s directory.')]), rt.new_string('<code>/wp-content/themes</code>')])).str() + '</p>')
	rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'add_help_tab', [rt.create_array([rt.ArrayItem{ key: 'id', val: 'overview' }, rt.ArrayItem{ key: 'title', val: rt.call_function('__', [rt.new_string('Overview')]) }, rt.ArrayItem{ key: 'content', val: var_help_overview }])])
	mut var_help_installing := rt.new_string('<p>' + (rt.call_function('__', [rt.new_string('Once you have generated a list of themes, you can preview and install any of them. Click on the thumbnail of the theme you are interested in previewing. It will open up in a full-screen Preview page to give you a better idea of how that theme will look.')])).str() + '</p>' + '<p>' + (rt.call_function('__', [rt.new_string('To install the theme so you can preview it with your site&#8217;s content and customize its theme options, click the "Install" button at the top of the left-hand pane. The theme files will be downloaded to your website automatically. When this is complete, the theme is now available for activation, which you can do by clicking the "Activate" link, or by navigating to your Manage Themes screen and clicking the "Live Preview" link under any installed theme&#8217;s thumbnail image.')])).str() + '</p>')
	rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'add_help_tab', [rt.create_array([rt.ArrayItem{ key: 'id', val: 'installing' }, rt.ArrayItem{ key: 'title', val: rt.call_function('__', [rt.new_string('Previewing and Installing')]) }, rt.ArrayItem{ key: 'content', val: var_help_installing }])])
	mut var_help_block_themes := rt.new_string('<p>' + (rt.call_function('__', [rt.new_string('A block theme is a theme that uses blocks for all parts of a site including navigation menus, header, content, and site footer. These themes are built for the features that allow you to edit and customize all parts of your site.')])).str() + '</p>' + '<p>' + (rt.call_function('__', [rt.new_string('With a block theme, you can place and edit blocks without affecting your content by customizing or creating new templates.')])).str() + '</p>')
	rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'add_help_tab', [rt.create_array([rt.ArrayItem{ key: 'id', val: 'block_themes' }, rt.ArrayItem{ key: 'title', val: rt.call_function('__', [rt.new_string('Block themes')]) }, rt.ArrayItem{ key: 'content', val: var_help_block_themes }])])
	rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'set_help_sidebar', ['<p><strong>' + (rt.call_function('__', [rt.new_string('For more information:')])).str() + '</strong></p>' + '<p>' + (rt.call_function('__', [rt.new_string('<a href="https://wordpress.org/documentation/article/appearance-themes-screen/#install-themes">Documentation on Adding New Themes</a>')])).str() + '</p>' + '<p>' + (rt.call_function('__', [rt.new_string('<a href="https://wordpress.org/documentation/article/block-themes/">Documentation on Block Themes</a>')])).str() + '</p>' + '<p>' + (rt.call_function('__', [rt.new_string('<a href="https://wordpress.org/support/forums/">Support forums</a>')])).str() + '</p>'])
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-header.php', '4')
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_title.dup()]))
	// unsupported statement: Stmt_InlineHTML
	mut var_tabs := rt.call_function('apply_filters', [rt.new_string('install_themes_tabs'), rt.create_array([rt.ArrayItem{ key: 'upload', val: rt.call_function('__', [rt.new_string('Upload Theme')]) }])])
	if rt.is_true(rt.new_bool(!(!rt.is_true(var_tabs.array_get('upload'))) && rt.is_true(rt.call_function('current_user_can', [rt.new_string('upload_themes')])))) {
		print(' <button type="button" class="upload-view-toggle page-title-action hide-if-no-js" aria-expanded="false">' + (rt.call_function('__', [rt.new_string('Upload Theme')])).str() + '</button>')
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('wp_admin_notice', [rt.call_function('__', [rt.new_string('The Theme Installer screen requires JavaScript.')]), rt.create_array([rt.ArrayItem{ key: 'additional_classes', val: rt.create_array([rt.ArrayItem{ key: none, val: 'error' }, rt.ArrayItem{ key: none, val: 'hide-if-js' }]) }])])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('install_themes_upload', []rt.PhpVal{})
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Filter themes list')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_ex', [rt.new_string('Popular'), rt.new_string('themes')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_ex', [rt.new_string('Latest'), rt.new_string('themes')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_ex', [rt.new_string('Block Themes'), rt.new_string('themes')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_ex', [rt.new_string('Favorites'), rt.new_string('themes')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Feature Filter')])
	// unsupported statement: Stmt_InlineHTML
	mut var_action := rt.new_string('save_wporg_username_' + (rt.call_function('get_current_user_id', []rt.PhpVal{})).str())
	if rt.is_true(rt.new_bool(rt.get_superglobal('_GET').array_isset(rt.new_string('_wpnonce')) && rt.is_true(rt.call_function('wp_verify_nonce', [rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get('_wpnonce')]), var_action.dup()])))) {
		mut var_user := if rt.get_superglobal('_GET').array_isset(rt.new_string('user')) { rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get('user')]) } else { rt.call_function('get_user_option', [rt.new_string('wporg_favorites')]) }
		rt.call_function('update_user_meta', [rt.call_function('get_current_user_id', []rt.PhpVal{}), rt.new_string('wporg_favorites'), var_user.dup()])
	} else {
		var_user = rt.call_function('get_user_option', [rt.new_string('wporg_favorites')])
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('If you have marked themes as favorites on WordPress.org, you can browse them here.')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Your WordPress.org username:')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [rt.call_function('wp_create_nonce', [var_action.dup()])]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_user.dup()]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('Get Favorites')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Apply Filters')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('Clear current filters')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Clear')])
	// unsupported statement: Stmt_InlineHTML
	mut var_feature_list := rt.call_function('get_theme_feature_list', [rt.new_bool(false)])
	{
		mut iter_1 := var_feature_list.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_features := item_1.val
			mut var_feature_group := item_1.key
			print('<fieldset class="filter-group">')
			print('<legend>' + (rt.call_function('esc_html', [var_feature_group.dup()])).str() + '</legend>')
			print('<div class="filter-group-feature">')
			{
				mut iter_2 := var_features.iterator()
				for {
					item_2 := iter_2.next() or { break }
					mut var_feature_name := item_2.val
					mut var_feature := item_2.key
					var_feature = rt.call_function('esc_attr', [var_feature.dup()])
					print('<input type="checkbox" id="filter-id-' + (var_feature).str() + '" value="' + (var_feature).str() + '" /> ')
					print('<label for="filter-id-' + (var_feature).str() + '">' + (rt.call_function('esc_html', [var_feature_name.dup()])).str() + '</label>')
				}
			}
			print('</div>')
			print('</fieldset>')
		}
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Apply Filters')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('Clear current filters')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Clear')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Filtering by:')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Edit Filters')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Themes list')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('No themes found. Try a different search.')])
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(var_tab) {
		rt.call_function('do_action', [rt.new_string("install_themes_${var_tab.to_string()}"), var_paged.dup()])
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('wp_admin_notice', [rt.call_function('_x', [rt.new_string('Installed'), rt.new_string('theme')]), rt.create_array([rt.ArrayItem{ key: 'type', val: 'success' }, rt.ArrayItem{ key: 'additional_classes', val: rt.create_array([rt.ArrayItem{ key: none, val:  }]) }])])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [])
	if rt.is_true() {
	} else if rt.is_true() {
	} else if rt.is_true() {
	}
	// unsupported statement: Stmt_InlineHTML
}
