import rt

const global_const_wp_installing = true
fn display_header(body_classes string) {
	rt.call_function('header', [rt.new_string('Content-Type: text/html; charset=utf-8')])
	if rt.is_true(rt.call_function('is_rtl', []rt.PhpVal{})) {
		// unsupported expression: Expr_AssignOp_Concat
	}
	if var_body_classes.len > 0 && var_body_classes != '0' {
		body_classes = ' ' + body_classes
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('language_attributes', []rt.PhpVal{})
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('WordPress &rsaquo; Installation')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('wp_admin_css', [rt.new_string('install'), rt.new_bool(true)])
	// unsupported statement: Stmt_InlineHTML
	print(var_body_classes)
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('WordPress')])
	// unsupported statement: Stmt_InlineHTML
}

fn display_setup_form(var_error rt.PhpVal) {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	mut var_user_table := // unsupported expression: Expr_BinaryOp_NotIdentical
	mut var_blog_public := rt.new_int(rt.new_int(1))
	if rt.get_superglobal('_POST').array_isset(rt.new_string('weblog_title')) {
		var_blog_public = if rt.get_superglobal('_POST').array_isset(rt.new_string('blog_public')) { // unsupported expression: Expr_Cast_Int } else { var_blog_public }
	}
	mut var_weblog_title := if rt.get_superglobal('_POST').array_isset(rt.new_string('weblog_title')) { rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get('weblog_title')]).to_string().trim_space() } else { '' }
	mut var_user_name := if rt.get_superglobal('_POST').array_isset(rt.new_string('user_name')) { rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get('user_name')]).to_string().trim_space() } else { '' }
	mut var_admin_email := if rt.get_superglobal('_POST').array_isset(rt.new_string('admin_email')) { rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get('admin_email')]).to_string().trim_space() } else { '' }
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.new_bool(var_error).dup().is_null()))))) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_ex', [rt.new_string('Welcome'), rt.new_string('Howdy')])
		// unsupported statement: Stmt_InlineHTML
		print(if var_error { '1' } else { '' })
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Site Title')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [rt.new_string(var_weblog_title).dup()]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Username')])
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(var_user_table) {
		rt.call_function('_e', [rt.new_string('User(s) already exists.')])
		print('<input name="user_name" type="hidden" value="admin" />')
	} else {
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [rt.call_function('sanitize_user', [rt.new_string(var_user_name).dup(), rt.new_bool(true)])]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Usernames can have only alphanumeric characters, spaces, underscores, hyphens, periods, and the @ symbol.')])
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.new_bool(!(rt.is_true(var_user_table)))) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Password')])
		// unsupported statement: Stmt_InlineHTML
		mut var_initial_password := if rt.get_superglobal('_POST').array_isset(rt.new_string('admin_password')) { rt.call_function('stripslashes', [rt.get_superglobal('_POST').array_get('admin_password')]) } else { rt.call_function('wp_generate_password', [rt.new_int(18)]) }
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [var_initial_password.dup()]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(// unsupported expression: Expr_Cast_Int)
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_attr_e', [rt.new_string('Hide password')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Hide')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Important:')])
		// unsupported statement: Stmt_InlineHTML
		// unsupported statement: Stmt_Nop
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('You will need this password to log&nbsp;in. Please store it in a secure location.')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Repeat Password')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('(required)')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Confirm Password')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Confirm use of weak password')])
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Your Email')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [rt.new_string(var_admin_email).dup()]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Double-check your email address before continuing.')])
	// unsupported statement: Stmt_InlineHTML
	mut var_blog_privacy_selector_title := if rt.is_true(rt.call_function('has_action', [rt.new_string('blog_privacy_selector')])) { rt.call_function('__', [rt.new_string('Site visibility')]) } else { rt.call_function('__', [rt.new_string('Search engine visibility')]) }
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_blog_privacy_selector_title)
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_blog_privacy_selector_title)
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.call_function('has_action', [rt.new_string('blog_privacy_selector')])) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('checked', [rt.new_int(1), var_blog_public.dup()])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Allow search engines to index this site')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('checked', [rt.new_int(0), var_blog_public.dup()])
		// unsupported statement: Stmt_InlineHTML
		
	} else {
	}
	// unsupported statement: Stmt_InlineHTML
}


fn main() {
	defer {
		rt.shutdown()
	}

	mut var_wp_version := rt.new_null()
	mut var_required_php_version := rt.new_null()
	mut var_required_php_extensions := rt.new_null()
	mut var_required_mysql_version := rt.new_null()
	mut var_wpdb := rt.new_null()
	mut var_GLOBALS := rt.new_null()
	if false {
		// unsupported statement: Stmt_InlineHTML
	}
	rt.include_file((rt.call_function('dirname', [rt.new_string(@DIR)])).str() + '/wp-load.php', '4')
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/upgrade.php', '4')
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/translation-install.php', '4')
	rt.include_file((rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/class-wpdb.php', '4')
	rt.call_function('nocache_headers', []rt.PhpVal{})
	mut var_step := if rt.get_superglobal('_GET').array_isset(rt.new_string('step')) { // unsupported expression: Expr_Cast_Int } else { rt.new_int(0) }
}
