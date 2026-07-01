import rt


fn main() {
	defer {
		rt.shutdown()
	}

	mut var_is_nginx := rt.new_null()
	mut var_wp_rewrite := rt.new_null()
	mut var_is_caddy := rt.new_null()
	rt.include_file(@DIR + '/admin.php', '4')
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('manage_options')]))))) {
		rt.call_function('wp_die', [rt.call_function('__', [rt.new_string('Sorry, you are not allowed to manage options for this site.')])])
	}
	mut var_title := rt.call_function('__', [rt.new_string('Permalink Settings')])
	mut var_parent_file := 'options-general.php'
	rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'add_help_tab', [rt.create_array([rt.ArrayItem{ key: 'id', val: 'overview' }, rt.ArrayItem{ key: 'title', val: rt.call_function('__', [rt.new_string('Overview')]) }, rt.ArrayItem{ key: 'content', val: '<p>' + (rt.call_function('__', [rt.new_string('Permalinks are the permanent URLs to your individual pages and blog posts, as well as your category and tag archives. A permalink is the web address used to link to your content. The URL to each post should be permanent, and never change &#8212; hence the name permalink.')])).str() + '</p>' + '<p>' + (rt.call_function('__', [rt.new_string('This screen allows you to choose your permalink structure. You can choose from common settings or create custom URL structures.')])).str() + '</p>' + '<p>' + (rt.call_function('__', [rt.new_string('You must click the Save Changes button at the bottom of the screen for new settings to take effect.')])).str() + '</p>' }])])
	rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'add_help_tab', [rt.create_array([rt.ArrayItem{ key: 'id', val: 'permalink-settings' }, rt.ArrayItem{ key: 'title', val: rt.call_function('__', [rt.new_string('Permalink Settings')]) }, rt.ArrayItem{ key: 'content', val: '<p>' + (rt.call_function('__', [rt.new_string('Permalinks can contain useful information, such as the post date, title, or other elements. You can choose from any of the suggested permalink formats, or you can craft your own if you select Custom Structure.')])).str() + '</p>' + '<p>' + (rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('If you pick an option other than Plain, your general URL path with structure tags (terms surrounded by %s) will also appear in the custom structure field and your path can be further modified there.')]), rt.new_string('<code>%</code>')])).str() + '</p>' + '<p>' + (rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('When you assign multiple categories or tags to a post, only one can show up in the permalink: the lowest numbered category. This applies if your custom structure includes %1$s or %2$s.')]), rt.new_string('<code>%category%</code>'), rt.new_string('<code>%tag%</code>')])).str() + '</p>' + '<p>' + (rt.call_function('__', [rt.new_string('You must click the Save Changes button at the bottom of the screen for new settings to take effect.')])).str() + '</p>' }])])
	rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'add_help_tab', [rt.create_array([rt.ArrayItem{ key: 'id', val: 'custom-structures' }, rt.ArrayItem{ key: 'title', val: rt.call_function('__', [rt.new_string('Custom Structures')]) }, rt.ArrayItem{ key: 'content', val: '<p>' + (rt.call_function('__', [rt.new_string('The Optional fields let you customize the &#8220;category&#8221; and &#8220;tag&#8221; base names that will appear in archive URLs. For example, the page listing all posts in the &#8220;Uncategorized&#8221; category could be <code>/topics/uncategorized</code> instead of <code>/category/uncategorized</code>.')])).str() + '</p>' + '<p>' + (rt.call_function('__', [rt.new_string('You must click the Save Changes button at the bottom of the screen for new settings to take effect.')])).str() + '</p>' }])])
	mut var_help_sidebar_content := rt.new_string('<p><strong>' + (rt.call_function('__', [rt.new_string('For more information:')])).str() + '</strong></p>' + '<p>' + (rt.call_function('__', [rt.new_string('<a href="https://wordpress.org/documentation/article/settings-permalinks-screen/">Documentation on Permalinks Settings</a>')])).str() + '</p>' + '<p>' + (rt.call_function('__', [rt.new_string('<a href="https://wordpress.org/documentation/article/customize-permalinks/">Documentation on Using Permalinks</a>')])).str() + '</p>')
	if rt.is_true(var_is_nginx) {
		// unsupported expression: Expr_AssignOp_Concat
	}
	// unsupported expression: Expr_AssignOp_Concat
	rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'set_help_sidebar', [var_help_sidebar_content.dup()])
	var_help_sidebar_content = rt.new_null()
	mut var_home_path := rt.call_function('get_home_path', []rt.PhpVal{})
	mut var_iis7_permalinks := rt.call_function('iis7_supports_permalinks', []rt.PhpVal{})
	mut var_permalink_structure := rt.call_function('get_option', [rt.new_string('permalink_structure')])
	mut var_index_php_prefix := ''
	mut var_blog_prefix := ''
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('got_url_rewrite', []rt.PhpVal{}))))) {
		var_index_php_prefix = '/index.php'
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_subdomain_install', []rt.PhpVal{}))))))) && rt.is_true(rt.call_function('is_main_site', []rt.PhpVal{})))) && rt.is_true(rt.call_function('str_starts_with', [var_permalink_structure.dup(), rt.new_string('/blog/')])))) {
		var_blog_prefix = '/blog'
	}
	mut var_category_base := rt.call_function('get_option', [rt.new_string('category_base')])
	mut var_tag_base := rt.call_function('get_option', [rt.new_string('tag_base')])
	mut var_structure_updated := false
	mut var_htaccess_update_required := rt.new_bool(rt.new_bool(false))
	if rt.get_superglobal('_POST').array_isset(rt.new_string('permalink_structure')) || rt.get_superglobal('_POST').array_isset(rt.new_string('category_base')) {
		rt.call_function('check_admin_referer', [rt.new_string('update-permalink')])
		if rt.get_superglobal('_POST').array_isset(rt.new_string('permalink_structure')) {
			if rt.is_true(rt.new_bool(rt.get_superglobal('_POST').array_isset(rt.new_string('selection')) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
				var_permalink_structure = rt.get_superglobal('_POST').array_get('selection')
			} else {
				var_permalink_structure = rt.get_superglobal('_POST').array_get('permalink_structure')
			}
			if !(!rt.is_true(var_permalink_structure)) {
				var_permalink_structure = rt.call_function('preg_replace', [rt.new_string('#/+#'), rt.new_string('/'), '/' + (rt.call_function('str_replace', [rt.new_string('#'), rt.new_string(''), var_permalink_structure.dup()])).str()])
				if var_index_php_prefix.len > 0 && var_index_php_prefix != '0' && var_blog_prefix.len > 0 && var_blog_prefix != '0' {
					var_permalink_structure = rt.new_string(var_index_php_prefix + (rt.call_function('preg_replace', [rt.new_string('#^/?index\\.php#'), rt.new_string(''), var_permalink_structure.dup()])).str())
				} else {
					var_permalink_structure = rt.new_string(var_blog_prefix + (var_permalink_structure).str())
				}
			}
			var_permalink_structure = rt.call_function('sanitize_option', [rt.new_string('permalink_structure'), var_permalink_structure.dup()])
			rt.call_method(var_wp_rewrite, 'set_permalink_structure', [var_permalink_structure.dup()])
			var_structure_updated = true
		}
		if rt.get_superglobal('_POST').array_isset(rt.new_string('category_base')) {
			var_category_base = rt.get_superglobal('_POST').array_get('category_base')
			if !(!rt.is_true(var_category_base)) {
				var_category_base = rt.new_string(var_blog_prefix + (rt.call_function('preg_replace', [rt.new_string('#/+#'), rt.new_string('/'), '/' + (rt.call_function('str_replace', [rt.new_string('#'), rt.new_string(''), var_category_base.dup()])).str()])).str())
			}
			rt.call_method(var_wp_rewrite, 'set_category_base', [var_category_base.dup()])
		}
		if rt.get_superglobal('_POST').array_isset(rt.new_string('tag_base')) {
			var_tag_base = rt.get_superglobal('_POST').array_get('tag_base')
			if !(!rt.is_true(var_tag_base)) {
				var_tag_base = rt.new_string(var_blog_prefix + (rt.call_function('preg_replace', [rt.new_string('#/+#'), rt.new_string('/'), '/' + (rt.call_function('str_replace', [rt.new_string('#'), rt.new_string(''), var_tag_base.dup()])).str()])).str())
			}
			rt.call_method(var_wp_rewrite, 'set_tag_base', [var_tag_base.dup()])
		}
	}
	if rt.is_true(var_iis7_permalinks) {
		if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('file_exists', [(var_home_path).str() + 'web.config']))))) && rt.is_true(rt.call_function('win_is_writable', [var_home_path.dup()])))) || rt.is_true(rt.call_function('win_is_writable', [(var_home_path).str() + 'web.config'])))) {
			mut var_writable := true
		} else {
			var_writable = false
		}
	} else if rt.is_true(rt.new_bool(rt.is_true(var_is_nginx) || rt.is_true(var_is_caddy))) {
		var_writable = false
	} else {
		if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('file_exists', [(var_home_path).str() + '.htaccess']))))) && rt.is_true(rt.call_function('is_writable', [var_home_path.dup()])))) || rt.is_true(rt.call_function('is_writable', [(var_home_path).str() + '.htaccess'])))) {
			var_writable = true
		} else {
			var_writable = false
			mut var_existing_rules := rt.call_function('array_filter', [rt.call_function('extract_from_markers', [(var_home_path).str() + '.htaccess', rt.new_string('WordPress')])])
			mut var_new_rules := rt.call_function('array_filter', [rt.call_function('explode', [rt.new_string('\n'), rt.call_method(var_wp_rewrite, 'mod_rewrite_rules', []rt.PhpVal{})])])
			var_htaccess_update_required = // unsupported expression: Expr_BinaryOp_NotIdentical
		}
	}
	mut var_using_index_permalinks := rt.call_method(var_wp_rewrite, 'using_index_permalinks', []rt.PhpVal{})
	if var_structure_updated {
		mut var_message := rt.call_function('__', [rt.new_string('Permalink structure updated.')])
		if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{}))))) && rt.is_true(var_permalink_structure))) && rt.is_true(rt.new_bool(!(rt.is_true(var_using_index_permalinks)))))) {
			if rt.is_true(var_iis7_permalinks) {
				if !(var_writable) {
					var_message = rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('You should update your %s file now.')]), rt.new_string('<code>web.config</code>')])
				} else {
					var_message = rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Permalink structure updated. Remove write access on %s file now!')]), rt.new_string('<code>web.config</code>')])
				}
			} else if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_is_nginx)))) && rt.is_true(rt.new_bool(!(rt.is_true(var_is_caddy)))))) && rt.is_true(var_htaccess_update_required))) && !(var_writable))) {
				var_message = rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('You should update your %s file now.')]), rt.new_string('<code>.htaccess</code>')])
			}
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('get_settings_errors', []rt.PhpVal{}))))) {
			rt.call_function('add_settings_error', [rt.new_string('general'), rt.new_string('settings_updated'), var_message.dup(), rt.new_string('success')])
		}
		rt.call_function('set_transient', [rt.new_string('settings_errors'), rt.call_function('get_settings_errors', []rt.PhpVal{}), rt.new_int(30)])
		rt.call_function('wp_redirect', [rt.call_function('admin_url', [rt.new_string('options-permalink.php?settings-updated=true')])])
		// unsupported expression: Expr_Exit
	}
	rt.call_function('flush_rewrite_rules', []rt.PhpVal{})
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-header.php', '4')
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_title.dup()]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('wp_nonce_field', [rt.new_string('update-permalink')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('printf', [rt.call_function('__', [rt.new_string('WordPress offers you the ability to create a custom URL structure for your permalinks and archives. Custom URL structures can improve the aesthetics, usability, and forward-compatibility of your links. A <a href="%s">number of tags are available</a>, and here are some examples to get you started.')]), rt.call_function('__', [rt.new_string('https://wordpress.org/documentation/article/customize-permalinks/')])])
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_subdomain_install', []rt.PhpVal{}))))))) && rt.is_true(rt.call_function('is_main_site', []rt.PhpVal{})))) && rt.is_true(rt.call_function('str_starts_with', [var_permalink_structure.dup(), rt.new_string('/blog/')])))) {
		var_permalink_structure = rt.call_function('preg_replace', [rt.new_string('|^/?blog|'), rt.new_string(''), var_permalink_structure.dup()])
		var_category_base = rt.call_function('preg_replace', [rt.new_string('|^/?blog|'), rt.new_string(''), var_category_base.dup()])
		var_tag_base = rt.call_function('preg_replace', [rt.new_string('|^/?blog|'), rt.new_string(''), var_tag_base.dup()])
	}
	mut var_url_base := rt.call_function('home_url', [var_blog_prefix + var_index_php_prefix])
	mut var_default_structures := [[rt.new_string('plain'), rt.call_function('__', [rt.new_string('Plain')]), rt.new_string(''), rt.call_function('home_url', [rt.new_string('/?p=123')])], [rt.new_string('day-name'), rt.call_function('__', [rt.new_string('Day and name')]), var_index_php_prefix + '/%year%/%monthnum%/%day%/%postname%/', (var_url_base).str() + '/' + (rt.call_function('gmdate', [rt.new_string('Y/m/d')])).str() + '/' + (rt.call_function('_x', [rt.new_string('sample-post'), rt.new_string('sample permalink structure')])).str() + '/'], [rt.new_string('month-name'), rt.call_function('__', [rt.new_string('Month and name')]), var_index_php_prefix + '/%year%/%monthnum%/%postname%/', (var_url_base).str() + '/' + (rt.call_function('gmdate', [rt.new_string('Y/m')])).str() + '/' + (rt.call_function('_x', [rt.new_string('sample-post'), rt.new_string('sample permalink structure')])).str() + '/'], [rt.new_string('numeric'), rt.call_function('__', [rt.new_string('Numeric')]), var_index_php_prefix + '/' + (rt.call_function('_x', [rt.new_string('archives'), rt.new_string('sample permalink base')])).str() + '/%post_id%', (var_url_base).str() + '/' + (rt.call_function('_x', [rt.new_string('archives'), rt.new_string('sample permalink base')])).str() + '/123'], [rt.new_string('post-name'), rt.call_function('__', [rt.new_string('Post name')]), var_index_php_prefix + '/%postname%/', (var_url_base).str() + '/' + (rt.call_function('_x', [rt.new_string('sample-post'), rt.new_string('sample permalink structure')])).str() + '/']]
	mut var_default_structure_values := rt.call_function('wp_list_pluck', [var_default_structures.dup(), rt.new_string('value')])
	mut var_available_tags := rt.create_array([rt.ArrayItem{ key: 'year', val: rt.call_function('__', [rt.new_string('%s (The year of the post, four digits, for example 2004.)')]) }, rt.ArrayItem{ key: 'monthnum', val: rt.call_function('__', [rt.new_string('%s (Month of the year, for example 05.)')]) }, rt.ArrayItem{ key: 'day', val: rt.call_function('__', [rt.new_string('%s (Day of the month, for example 28.)')]) }, rt.ArrayItem{ key: 'hour', val: rt.call_function('__', [rt.new_string('%s (Hour of the day, for example 15.)')]) }, rt.ArrayItem{ key: 'minute', val: rt.call_function('__', [rt.new_string('%s (Minute of the hour, for example 43.)')]) }, rt.ArrayItem{ key: 'second', val: rt.call_function('__', [rt.new_string('%s (Second of the minute, for example 33.)')]) }, rt.ArrayItem{ key: 'post_id', val: rt.call_function('__', [rt.new_string('%s (The unique ID of the post, for example 423.)')]) }, rt.ArrayItem{ key: 'postname', val: rt.call_function('__', [rt.new_string('%s (The sanitized post title (slug).)')]) }, rt.ArrayItem{ key: 'category', val: rt.call_function('__', [rt.new_string('%s (Category slug. Nested sub-categories appear as nested directories in the URL.)')]) }, rt.ArrayItem{ key: 'author', val: rt.call_function('__', [rt.new_string('%s (A sanitized version of the author name.)')]) }])
	var_available_tags = rt.call_function('apply_filters', [rt.new_string('available_permalink_structure_tags'), var_available_tags.dup()])
	mut var_tag_added := rt.call_function('__', [rt.new_string('%s added to permalink structure')])
	mut var_tag_removed := rt.call_function('__', [rt.new_string('%s removed from permalink structure')])
	mut var_tag_already_used := rt.call_function('__', [rt.new_string('%s (already used in permalink structure)')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Common Settings')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('printf', [rt.call_function('__', [rt.new_string('Select the permalink structure for your website. Including the %s tag makes links easy to understand, and can help your posts rank higher in search engines.')]), rt.new_string('<code>%postname%</code>')])
	// unsupported statement: Stmt_InlineHTML
	mut var_permalink_structure_title := rt.call_function('__', [rt.new_string('Permalink structure')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_permalink_structure_title)
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_permalink_structure_title)
	// unsupported statement: Stmt_InlineHTML
	for var_input in var_default_structures {
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [var_input.array_get('id')]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [var_input.array_get('id')]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [var_input.array_get('value')]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('checked', [var_input.array_get('value'), var_permalink_structure.dup()])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [var_input.array_get('id')]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_html', []))
		// unsupported statement: Stmt_InlineHTML
	}
}
