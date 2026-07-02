import rt

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_current_user := rt.new_null()
	rt.include_file(@DIR + '/admin.php', '4')
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{}))))) {
		rt.call_function('wp_die', [
			rt.call_function('__', [rt.new_string('Multisite support is not enabled.')]),
		])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('read'),
	])))))
	{
		rt.call_function('wp_die', [
			rt.call_function('__', [
				rt.new_string('Sorry, you are not allowed to access this page.'),
			]),
		])
	}
	mut var_action := if !(rt.get_superglobal('_POST').array_get(rt.new_string('action'))).is_null() {
		rt.get_superglobal('_POST').array_get(rt.new_string('action'))
	} else {
		rt.new_string('splash')
	}
	mut var_blogs := rt.call_function('get_blogs_of_user', [
		rt.get_property(var_current_user, 'ID'),
	])
	mut var_updated := false
	if rt.is_true(rt.identical(rt.new_string('updateblogsettings'), var_action))
		&& rt.get_superglobal('_POST').array_isset(rt.new_string('primary_blog')) {
		rt.call_function('check_admin_referer', [rt.new_string('update-my-sites')])
		mut var_blog := rt.call_function('get_site', [
			rt.new_int((rt.get_superglobal('_POST').array_get(rt.new_string('primary_blog'))).to_i64()),
		])
		if rt.is_true(var_blog) && !(rt.get_property(var_blog, 'domain')).is_null() {
			rt.call_function('update_user_meta', [
				rt.get_property(var_current_user, 'ID'),
				rt.new_string('primary_blog'),
				rt.new_int((rt.get_superglobal('_POST').array_get(rt.new_string('primary_blog'))).to_i64()),
			])
			var_updated = true
		} else {
			rt.call_function('wp_die', [
				rt.call_function('__', [
					rt.new_string('The primary site you chose does not exist.'),
				]),
			])
		}
	}
	mut var_title := rt.call_function('__', [rt.new_string('My Sites')])
	mut var_parent_file := 'index.php'
	rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'add_help_tab', [
		rt.create_array([rt.ArrayItem{ key: 'id', val: 'overview' },
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Overview'),
			]) }, rt.ArrayItem{ key: 'content', val: '<p>' +
				(rt.call_function('__', [rt.new_string('This screen shows an individual user all of their sites in this network, and also allows that user to set a primary site. They can use the links under each site to visit either the front end or the dashboard for that site.')])).str() +
				'</p>' }]),
	])
	rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'set_help_sidebar', [
		rt.new_string('<p><strong>' +
			(rt.call_function('__', [rt.new_string('For more information:')])).str() +
			'</strong></p>' + '<p>' +
			(rt.call_function('__', [rt.new_string('<a href="https://codex.wordpress.org/Dashboard_My_Sites_Screen">Documentation on My Sites</a>')])).str() +
			'</p>' + '<p>' +
			(rt.call_function('__', [rt.new_string('<a href="https://wordpress.org/support/forums/">Support forums</a>')])).str() +
			'</p>'),
	])
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-header.php', '4')
	if var_updated {
		rt.call_function('wp_admin_notice', [
			rt.new_string('<strong>' +
				(rt.call_function('__', [rt.new_string('Settings saved.')])).str() + '</strong>'),
			rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'success' },
				rt.ArrayItem{ key: 'dismissible', val: true },
				rt.ArrayItem{ key: 'id', val: 'message' },
			]),
		])
	}
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_title.clone()]))
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.call_function('in_array', [
		rt.call_function('get_site_option', [rt.new_string('registration')]),
		rt.create_array([rt.ArrayItem{ key: none, val: 'all' },
			rt.ArrayItem{ key: none, val: 'blog' }]),
		rt.new_bool(true),
	]))
	{
		mut var_sign_up_url := rt.call_function('apply_filters', [
			rt.new_string('wp_signup_location'),
			rt.call_function('network_site_url', [rt.new_string('wp-signup.php')]),
		])
		rt.call_function('printf', [
			rt.new_string(' <a href="%s" class="page-title-action">%s</a>'),
			rt.call_function('esc_url', [var_sign_up_url.clone()]),
			rt.call_function('esc_html__', [rt.new_string('Add New Site')]),
		])
	}
	if !rt.is_true(var_blogs) {
		rt.call_function('wp_admin_notice', [
			rt.new_string('<strong>' +
				(rt.call_function('__', [rt.new_string('You must be a member of at least one site to use this page.')])).str() +
				'</strong>'),
			rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'error' },
				rt.ArrayItem{ key: 'dismissible', val: true },
			]),
		])
		// unsupported statement: Stmt_InlineHTML
	} else {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('choose_primary_blog', []rt.PhpVal{})
		rt.call_function('do_action', [rt.new_string('myblogs_allblogs_options')])
		// unsupported statement: Stmt_InlineHTML
		mut var_settings_html := rt.call_function('apply_filters', [
			rt.new_string('myblogs_options'),
			rt.new_string(''),
			rt.new_string('global'),
		])
		if rt.is_true(var_settings_html) {
			print('<h3>' + (rt.call_function('__', [rt.new_string('Global Settings')])).str() +
				'</h3>')
			rt.echo_val(var_settings_html)
		}
		rt.call_function('reset', [var_blogs.clone()])
		mut iter_1 := var_blogs.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_user_blog := item_1.val
			rt.call_function('switch_to_blog', [
				rt.get_property(var_user_blog, 'userblog_id'),
			])
			print('<li>')
			print(rt.concat(rt.concat(rt.new_string('<h3>'), rt.get_property(var_user_blog,
				'blogname')), rt.new_string('</h3>')))
			mut var_actions := rt.new_string("<a href='" +
				(rt.call_function('esc_url', [rt.call_function('home_url', []rt.PhpVal{})])).str() +
				"'>" + (rt.call_function('__', [rt.new_string('Visit')])).str() + '</a>')
			if rt.is_true(rt.call_function('current_user_can', [
				rt.new_string('read')]))
			{
				var_actions = rt.concat(var_actions, rt.new_string(" | <a href='" +
					(rt.call_function('esc_url', [rt.call_function('admin_url', []rt.PhpVal{})])).str() +
					"'>" + (rt.call_function('__', [rt.new_string('Dashboard')])).str() + '</a>'))
			}
			var_actions = rt.call_function('apply_filters', [
				rt.new_string('myblogs_blog_actions'),
				var_actions.clone(),
				var_user_blog.clone(),
			])
			print("<p class='my-sites-actions'>" + var_actions.str() + '</p>')
			rt.echo_val(rt.call_function('apply_filters', [
				rt.new_string('myblogs_options'),
				rt.new_string(''),
				var_user_blog.clone(),
			]))
			print('</li>')
			rt.call_function('restore_current_blog', []rt.PhpVal{})
		}
		// unsupported statement: Stmt_InlineHTML
		if var_blogs.clone().array_count() > 1
			|| rt.is_true(rt.call_function('has_action', [rt.new_string('myblogs_allblogs_options')]))
			|| rt.is_true(rt.call_function('has_filter', [rt.new_string('myblogs_options')])) {
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('wp_nonce_field', [rt.new_string('update-my-sites')])
			rt.call_function('submit_button', []rt.PhpVal{})
		}
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-footer.php', '4')
}
