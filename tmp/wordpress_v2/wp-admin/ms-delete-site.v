import rt

fn main() {
	defer {
		rt.shutdown()
	}

	rt.include_file(@DIR + '/admin.php', '4')
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{}))))) {
		rt.call_function('wp_die', [
			rt.call_function('__', [rt.new_string('Multisite support is not enabled.')]),
		])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('delete_site'),
	])))))
	{
		rt.call_function('wp_die', [
			rt.call_function('__', [
				rt.new_string('Sorry, you are not allowed to delete this site.'),
			]),
		])
	}
	if rt.get_superglobal('_GET').array_isset(rt.new_string('h'))
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), rt.get_superglobal('_GET').array_get(rt.new_string('h'))))))
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('get_option', [rt.new_string('delete_blog_hash')]))))) {
		if rt.is_true(rt.call_function('hash_equals', [
			rt.call_function('get_option', [rt.new_string('delete_blog_hash')]),
			rt.get_superglobal('_GET').array_get(rt.new_string('h')),
		]))
		{
			rt.call_function('wpmu_delete_blog', [
				rt.call_function('get_current_blog_id', []rt.PhpVal{}),
			])
			rt.call_function('wp_die', [
				rt.call_function('sprintf', [
					rt.call_function('__', [
						rt.new_string('Thank you for using %s, your site has been deleted. Happy trails to you until we meet again.'),
					]),
					rt.get_property(rt.call_function('get_network', []rt.PhpVal{}), 'site_name'),
				]),
			])
		} else {
			rt.call_function('wp_die', [
				rt.call_function('__', [
					rt.new_string('Sorry, the link you clicked is stale. Please select another option.'),
				]),
			])
		}
	}
	mut var_blog := rt.call_function('get_site', []rt.PhpVal{})
	mut var_user := rt.call_function('wp_get_current_user', []rt.PhpVal{})
	mut var_title := rt.call_function('__', [rt.new_string('Delete Site')])
	mut var_parent_file := 'tools.php'
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-header.php', '4')
	print('<div class="wrap">')
	print('<h1>' + (rt.call_function('esc_html', [var_title.clone()])).str() + '</h1>')
	if rt.get_superglobal('_POST').array_isset(rt.new_string('action'))
		&& rt.is_true(rt.identical(rt.new_string('deleteblog'), rt.get_superglobal('_POST').array_get(rt.new_string('action'))))
		&& rt.get_superglobal('_POST').array_isset(rt.new_string('confirmdelete'))
		&& rt.is_true(rt.identical(rt.new_string('1'), rt.get_superglobal('_POST').array_get(rt.new_string('confirmdelete')))) {
		rt.call_function('check_admin_referer', [rt.new_string('delete-blog')])
		mut var_hash := rt.call_function('wp_generate_password', [
			rt.new_int(20), rt.new_bool(false)])
		rt.call_function('update_option', [rt.new_string('delete_blog_hash'),
			var_hash.clone(), rt.new_bool(false)])
		mut var_url_delete := rt.call_function('esc_url', [
			rt.call_function('admin_url', [
				rt.new_string('ms-delete-site.php?h=' + var_hash.str()),
			]),
		])
		mut var_switched_locale := rt.call_function('switch_to_locale', [
			rt.call_function('get_locale', []rt.PhpVal{}),
		])
		mut var_content := rt.call_function('__', [
			rt.new_string("Howdy ###USERNAME###,\n\nYou recently clicked the 'Delete Site' link on your site and filled in a\nform on that page.\n\nIf you really want to delete your site, click the link below. You will not\nbe asked to confirm again so only click this link if you are absolutely certain:\n###URL_DELETE###\n\nIf you delete your site, please consider opening a new site here some time in\nthe future! (But remember that your current site and username are gone forever.)\n\nThank you for using the site,\nAll at ###SITENAME###\n###SITEURL###"),
		])
		var_content = rt.call_function('apply_filters', [
			rt.new_string('delete_site_email_content'),
			var_content.clone(),
		])
		var_content = rt.call_function('str_replace', [rt.new_string('###USERNAME###'),
			rt.get_property(var_user, 'user_login'), var_content.clone()])
		var_content = rt.call_function('str_replace', [rt.new_string('###URL_DELETE###'),
			var_url_delete.clone(), var_content.clone()])
		var_content = rt.call_function('str_replace', [rt.new_string('###SITENAME###'),
			rt.get_property(rt.call_function('get_network', []rt.PhpVal{}), 'site_name'),
			var_content.clone()])
		var_content = rt.call_function('str_replace', [rt.new_string('###SITEURL###'),
			rt.call_function('network_home_url', []rt.PhpVal{}),
			var_content.clone()])
		rt.call_function('wp_mail', [
			rt.call_function('get_option', [rt.new_string('admin_email')]),
			rt.call_function('sprintf', [rt.call_function('__', [
				rt.new_string('[%s] Delete My Site'),
			]),
				rt.call_function('wp_specialchars_decode', [
					rt.call_function('get_option', [rt.new_string('blogname')]),
				])]),
			var_content.clone(),
		])
		if rt.is_true(var_switched_locale) {
			rt.call_function('restore_previous_locale', []rt.PhpVal{})
		}
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [
			rt.new_string('Thank you. Please check your email for a link to confirm your action. Your site will not be deleted until this link is clicked.'),
		])
		// unsupported statement: Stmt_InlineHTML
	} else {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('printf', [
			rt.call_function('__', [
				rt.new_string('If you do not want to use your %s site any more, you can delete it using the form below. When you click <strong>Delete My Site Permanently</strong> you will be sent an email with a link in it. Click on this link to delete your site.'),
			]),
			rt.get_property(rt.call_function('get_network', []rt.PhpVal{}), 'site_name'),
		])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [
			rt.new_string('Remember, once deleted your site cannot be restored.'),
		])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('wp_nonce_field', [rt.new_string('delete-blog')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('printf', [
			rt.call_function('__', [
				rt.new_string("I'm sure I want to permanently delete my site, and I am aware I can never get it back or use %s again."),
			]),
			rt.new_string((rt.get_property(var_blog, 'domain')).str() +
				(rt.get_property(var_blog, 'path')).str()),
		])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('submit_button', [
			rt.call_function('__', [rt.new_string('Delete My Site Permanently')]),
		])
		// unsupported statement: Stmt_InlineHTML
	}
	print('</div>')
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-footer.php', '4')
}
