import rt

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_display_version := rt.new_null()
	rt.include_file(@DIR + '/admin.php', '4')
	if rt.get_superglobal('_GET').array_isset(rt.new_string('privacy-notice')) {
		rt.call_function('wp_redirect', [
			rt.call_function('admin_url', [rt.new_string('privacy.php')]),
			rt.new_int(301),
		])
		// unsupported expression: Expr_Exit
	}
	mut var_title := rt.call_function('__', [rt.new_string('Freedoms')])
	// unsupported assign target: Expr_List
	mut var_header_alt_text := rt.call_function('sprintf', [
		rt.call_function('__', [rt.new_string('WordPress %s')]),
		var_display_version.dup(),
	])
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-header.php', '4')
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_header_alt_text.dup()]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('The Four Freedoms')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('WordPress is free and open source software')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('Secondary menu')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('What&#8217;s New')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Credits')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Freedoms')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Privacy')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Get Involved')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('printf', [
		rt.call_function('__', [
			rt.new_string('WordPress comes with some awesome, worldview-changing rights courtesy of its <a href="%s">license</a>, the GPL.'),
		]),
		rt.call_function('__', [
			rt.new_string('https://wordpress.org/about/license/'),
		]),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [
		rt.call_function('admin_url', [rt.new_string('images/freedom-1.svg?ver=6.5')]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('The 1st Freedom')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('To run the program for any purpose.')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [
		rt.call_function('admin_url', [rt.new_string('images/freedom-2.svg?ver=6.5')]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('The 2nd Freedom')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [
		rt.new_string('To study how the program works and change it to make it do what you wish.'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [
		rt.call_function('admin_url', [rt.new_string('images/freedom-3.svg?ver=6.5')]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('The 3rd Freedom')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('To redistribute.')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [
		rt.call_function('admin_url', [rt.new_string('images/freedom-4.svg?ver=6.5')]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('The 4th Freedom')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [
		rt.new_string('To distribute copies of your modified versions to others.'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('printf', [
		rt.call_function('__', [
			rt.new_string('WordPress grows when people like you tell their friends about it, and the thousands of businesses and services that are built on and around WordPress share that fact with their users. The WordPress community is flattered every time someone spreads the good word, just make sure to <a href="%s">check out the WordPress Foundation trademark guidelines</a> first.'),
		]),
		rt.new_string('https://wordpressfoundation.org/trademark-policy/'),
	])
	// unsupported statement: Stmt_InlineHTML
	mut var_plugins_url := if rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('activate_plugins'),
	]))
	{ rt.call_function('admin_url', [rt.new_string('plugins.php')]) } else { rt.call_function('__', [
			rt.new_string('https://wordpress.org/plugins/'),
		]) }
	mut var_themes_url := if rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('switch_themes'),
	]))
	{ rt.call_function('admin_url', [rt.new_string('themes.php')]) } else { rt.call_function('__', [
			rt.new_string('https://wordpress.org/themes/'),
		]) }
	rt.call_function('printf', [
		rt.call_function('__', [
			rt.new_string('Every plugin and theme in WordPress.org&#8217;s directory is 100%% GPL or a similarly free and compatible license, so you can feel safe finding <a href="%1$s">plugins</a> and <a href="%2$s">themes</a> there. If you get a plugin or theme from another source, make sure to <a href="%3$s">ask them if it&#8217;s GPL</a> first. If they do not respect the WordPress license, it is not recommended to use them.'),
		]),
		var_plugins_url.dup(),
		var_themes_url.dup(),
		rt.call_function('__', [
			rt.new_string('https://wordpress.org/about/license/'),
		]),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-footer.php', '4')
}
