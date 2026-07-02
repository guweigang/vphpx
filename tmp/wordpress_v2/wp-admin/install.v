import rt

const global_const_wp_installing = true

mut var_step := rt.new_int(if rt.get_superglobal('_GET').array_isset(rt.new_string('step')) {
	rt.new_int((rt.get_superglobal('_GET').array_get(rt.new_string('step'))).to_i64())
} else {
	0
})
fn display_header(body_classes string) {
	mut var_body_classes := body_classes
	rt.call_function('header', [rt.new_string('Content-Type: text/html; charset=utf-8')])
	if rt.is_true(rt.call_function('is_rtl', []rt.PhpVal{})) {
		var_body_classes = var_body_classes + 'rtl'
	}
	if var_body_classes.len > 0 && var_body_classes != '0' {
		var_body_classes = ' ' + var_body_classes
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('language_attributes', []rt.PhpVal{})
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('WordPress &rsaquo; Installation')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('wp_admin_css', [rt.new_string('install'),
		rt.new_bool(true)])
	// unsupported statement: Stmt_InlineHTML
	print(var_body_classes)
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('WordPress')])
	// unsupported statement: Stmt_InlineHTML
}

fn display_setup_form(var_error rt.PhpVal) {
	mut var_wpdb := rt.new_null()
	mut var_user_table := rt.new_null()
	mut var_blog_public := rt.new_null()
	mut var_weblog_title := ''
	mut var_user_name := ''
	mut var_admin_email := ''
	mut var_initial_password := rt.new_null()
	mut var_blog_privacy_selector_title := rt.new_null()
	var_user_table = rt.new_bool(!rt.is_true(rt.identical(rt.call_method(var_wpdb, 'get_var', [
		rt.call_method(var_wpdb, 'prepare', [rt.new_string('SHOW TABLES LIKE %s'),
			rt.call_method(var_wpdb, 'esc_like', [rt.get_property(var_wpdb, 'users')])]),
	]), rt.new_null())))
	var_blog_public = rt.new_int(1)
	if rt.get_superglobal('_POST').array_isset(rt.new_string('weblog_title')) {
		var_blog_public = if rt.get_superglobal('_POST').array_isset(rt.new_string('blog_public')) {
			rt.new_int((rt.get_superglobal('_POST').array_get(rt.new_string('blog_public'))).to_i64())
		} else {
			var_blog_public
		}
	}
	var_weblog_title = if rt.get_superglobal('_POST').array_isset(rt.new_string('weblog_title')) { rt.call_function('wp_unslash', [
			rt.get_superglobal('_POST').array_get(rt.new_string('weblog_title')),
		]).to_string().trim_space() } else { '' }
	var_user_name = if rt.get_superglobal('_POST').array_isset(rt.new_string('user_name')) { rt.call_function('wp_unslash', [
			rt.get_superglobal('_POST').array_get(rt.new_string('user_name')),
		]).to_string().trim_space() } else { '' }
	var_admin_email = if rt.get_superglobal('_POST').array_isset(rt.new_string('admin_email')) { rt.call_function('wp_unslash', [
			rt.get_superglobal('_POST').array_get(rt.new_string('admin_email')),
		]).to_string().trim_space() } else { '' }
	if !(rt.new_bool(var_error).clone().is_null()) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_ex', [rt.new_string('Welcome'), rt.new_string('Howdy')])
		// unsupported statement: Stmt_InlineHTML
		print(if var_error { '1' } else { '' })
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Site Title')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [rt.new_string(var_weblog_title.str()).clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Username')])
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(var_user_table) {
		rt.call_function('_e', [rt.new_string('User(s) already exists.')])
		print('<input name="user_name" type="hidden" value="admin" />')
	} else {
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [
			rt.call_function('sanitize_user', [rt.new_string(var_user_name.str()).clone(),
				rt.new_bool(true)]),
		]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [
			rt.new_string('Usernames can have only alphanumeric characters, spaces, underscores, hyphens, periods, and the @ symbol.'),
		])
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.new_bool(!(rt.is_true(var_user_table)))) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Password')])
		// unsupported statement: Stmt_InlineHTML
		var_initial_password = if rt.get_superglobal('_POST').array_isset(rt.new_string('admin_password')) { rt.call_function('stripslashes', [
				rt.get_superglobal('_POST').array_get(rt.new_string('admin_password')),
			]) } else { rt.call_function('wp_generate_password', [
				rt.new_int(18)]) }
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [var_initial_password.clone()]))
		// unsupported statement: Stmt_InlineHTML
		print(rt.new_int((rt.new_bool(rt.get_superglobal('_POST').array_isset(rt.new_string('admin_password')))).to_i64()).str())
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_attr_e', [rt.new_string('Hide password')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Hide')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Important:')])
		// unsupported statement: Stmt_InlineHTML
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [
			rt.new_string('You will need this password to log&nbsp;in. Please store it in a secure location.'),
		])
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
	rt.echo_val(rt.call_function('esc_attr', [rt.new_string(var_admin_email.str()).clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [
		rt.new_string('Double-check your email address before continuing.'),
	])
	// unsupported statement: Stmt_InlineHTML
	var_blog_privacy_selector_title = if rt.is_true(rt.call_function('has_action', [
		rt.new_string('blog_privacy_selector'),
	]))
	{ rt.call_function('__', [rt.new_string('Site visibility')]) } else { rt.call_function('__', [
			rt.new_string('Search engine visibility'),
		]) }
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_blog_privacy_selector_title)
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_blog_privacy_selector_title)
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.call_function('has_action', [rt.new_string('blog_privacy_selector')])) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('checked', [rt.new_int(1), var_blog_public.clone()])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Allow search engines to index this site')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('checked', [rt.new_int(0), var_blog_public.clone()])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [
			rt.new_string('Discourage search engines from indexing this site'),
		])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [
			rt.new_string('Note: Discouraging search engines does not block access to your site &mdash; it is up to search engines to honor your request.'),
		])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('do_action', [rt.new_string('blog_privacy_selector')])
	} else {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('checked', [rt.new_int(0), var_blog_public.clone()])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [
			rt.new_string('Discourage search engines from indexing this site'),
		])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [
			rt.new_string('It is up to search engines to honor this request.'),
		])
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('submit_button', [
		rt.call_function('__', [rt.new_string('Install WordPress')]),
		rt.new_string('large'),
		rt.new_string('Submit'),
		rt.new_bool(false),
		rt.create_array([rt.ArrayItem{ key: 'id', val: 'submit' }]),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('language')) { rt.call_function('esc_attr', [
			rt.get_superglobal('_REQUEST').array_get(rt.new_string('language')),
		]) } else { rt.new_string('') })
	// unsupported statement: Stmt_InlineHTML
}

struct Class_WP_Locale {
	rt.PhpObjectBase
}

fn create_wp_locale(_args ...rt.PhpVal) &Class_WP_Locale {
	mut obj := &Class_WP_Locale{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Locale) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Locale) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Locale) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
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
	rt.include_file((rt.call_function('dirname', [rt.new_string(@DIR)])).str() + '/wp-load.php',
		'4')
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/upgrade.php', '4')
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/translation-install.php',
		'4')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/class-wpdb.php',
		'4')
	rt.call_function('nocache_headers', []rt.PhpVal{})
	if rt.is_true(rt.call_function('is_blog_installed', []rt.PhpVal{})) {
		display_header('')
		fn () {
			print(('<h1>' + (rt.call_function('__', [rt.new_string('Already Installed')])).str() +
				'</h1>' + '<p>' +
				(rt.call_function('__', [rt.new_string('You appear to have already installed WordPress. To reinstall please clear your old database tables first.')])).str() +
				'</p>' + '<p class="step"><a href="' +
				(rt.call_function('esc_url', [rt.call_function('wp_login_url', []rt.PhpVal{})])).str() +
				'">' + (rt.call_function('__', [rt.new_string('Log In')])).str() + '</a></p>' +
				'</body></html>').str())
			exit(0)
		}()
	}
	mut var_php_version := rt.get_constant('PHP_VERSION')
	mut var_mysql_version := rt.call_method(var_wpdb, 'db_version', []rt.PhpVal{})
	mut var_php_compat := rt.call_function('version_compare', [
		var_php_version.clone(), var_required_php_version.clone(),
		rt.new_string('>=')])
	mut var_mysql_compat :=
		rt.is_true(rt.call_function('version_compare', [var_mysql_version.clone(), var_required_mysql_version.clone(), rt.new_string('>=')]))
		|| rt.is_true(rt.call_function('file_exists', [rt.new_string((rt.get_constant('WP_CONTENT_DIR')).str() + '/db.php')]))
	mut var_version_url := rt.call_function('sprintf', [
		rt.call_function('esc_url', [
			rt.call_function('__', [
				rt.new_string('https://wordpress.org/documentation/wordpress-version/version-%s/'),
			]),
		]),
		rt.call_function('sanitize_title', [
			var_wp_version.clone(),
		]),
	])
	mut var_php_update_message :=
		rt.new_string('</p><p>' +(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('<a href="%s">Learn more about updating PHP</a>.')]), rt.call_function('esc_url', [rt.call_function('wp_get_update_php_url', []rt.PhpVal{})])])).str())
	mut var_annotation := rt.call_function('wp_get_update_php_annotation', []rt.PhpVal{})
	if rt.is_true(var_annotation) {
		var_php_update_message = rt.concat(var_php_update_message, rt.new_string('</p><p><em>' +
			var_annotation.str() + '</em>'))
	}
	if !var_mysql_compat && rt.is_true(rt.new_bool(!(rt.is_true(var_php_compat)))) {
		mut var_compat := rt.new_string(
			(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('You cannot install because <a href="%1$s">WordPress %2$s</a> requires PHP version %3$s or higher and MySQL version %4$s or higher. You are running PHP version %5$s and MySQL version %6$s.')]), var_version_url.clone(), var_wp_version.clone(), var_required_php_version.clone(), var_required_mysql_version.clone(), var_php_version.clone(), var_mysql_version.clone()])).str() +
			var_php_update_message.str())
	} else if rt.is_true(rt.new_bool(!(rt.is_true(var_php_compat)))) {
		var_compat = rt.new_string(
			(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('You cannot install because <a href="%1$s">WordPress %2$s</a> requires PHP version %3$s or higher. You are running version %4$s.')]), var_version_url.clone(), var_wp_version.clone(), var_required_php_version.clone(), var_php_version.clone()])).str() +
			var_php_update_message.str())
	} else if !var_mysql_compat {
		var_compat = rt.call_function('sprintf', [
			rt.call_function('__', [
				rt.new_string('You cannot install because <a href="%1$s">WordPress %2$s</a> requires MySQL version %3$s or higher. You are running version %4$s.'),
			]),
			var_version_url.clone(),
			var_wp_version.clone(),
			var_required_mysql_version.clone(),
			var_mysql_version.clone(),
		])
	}
	if !var_mysql_compat || rt.is_true(rt.new_bool(!(rt.is_true(var_php_compat)))) {
		display_header('')
		fn () {
			print(('<h1>' +
				(rt.call_function('__', [rt.new_string('Requirements Not Met')])).str() +
				'</h1><p>' + var_compat.str() + '</p></body></html>').str())
			exit(0)
		}()
	}
	if !var_required_php_extensions.is_null() && var_required_php_extensions.clone().is_array() {
		mut var_missing_extensions := []rt.PhpVal{}
		mut iter_1 := var_required_php_extensions.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_extension := item_1.val
			if rt.is_true(rt.call_function('extension_loaded', [
				var_extension.clone()]))
			{
				continue
			}
			var_missing_extensions << rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('You cannot install because <a href="%1$s">WordPress %2$s</a> requires the %3$s PHP extension.'),
				]),
				var_version_url.clone(),
				var_wp_version.clone(),
				var_extension.clone(),
			])
		}
		if var_missing_extensions.len > 0 {
			display_header('')
			fn () {
				print(('<h1>' +
					(rt.call_function('__', [rt.new_string('Requirements Not Met')])).str() +
					'</h1><p>' +
					(rt.call_function('implode', [rt.new_string('</p><p>'), rt.create_array_from_list(var_missing_extensions)])).str() +
					'</p></body></html>').str())
				exit(0)
			}()
		}
	}
	if !(rt.get_property(var_wpdb, 'base_prefix').is_string())
		|| rt.is_true(rt.identical(rt.new_string(''), rt.get_property(var_wpdb, 'base_prefix'))) {
		display_header('')
		fn () {
			print(('<h1>' + (rt.call_function('__', [rt.new_string('Configuration Error')])).str() +
				'</h1>' + '<p>' +
				(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Your %s file has an empty database table prefix, which is not supported.')]), rt.new_string('<code>wp-config.php</code>')])).str() +
				'</p></body></html>').str())
			exit(0)
		}()
	}
	if rt.is_true(rt.call_function('defined', [
		rt.new_string('DO_NOT_UPGRADE_GLOBAL_TABLES'),
	]))
	{
		display_header('')
		fn () {
			print(('<h1>' + (rt.call_function('__', [rt.new_string('Configuration Error')])).str() +
				'</h1>' + '<p>' +
				(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('The constant %s cannot be defined when installing WordPress.')]), rt.new_string('<code>DO_NOT_UPGRADE_GLOBAL_TABLES</code>')])).str() +
				'</p></body></html>').str())
			exit(0)
		}()
	}
	mut var_language := rt.new_string('')
	if !(!rt.is_true(rt.get_superglobal('_REQUEST').array_get(rt.new_string('language')))) {
		var_language = rt.call_function('sanitize_locale_name', [
			rt.get_superglobal('_REQUEST').array_get(rt.new_string('language')),
		])
	} else if var_GLOBALS.array_isset(rt.new_string('wp_local_package')) {
		var_language = var_GLOBALS.array_get(rt.new_string('wp_local_package'))
	}
	mut var_scripts_to_print := ['jquery']
	mut switch_val_1 := var_step
	if rt.is_true(rt.equal(switch_val_1, rt.new_int(0))) {
		if rt.is_true(rt.call_function('wp_can_install_language_pack', []rt.PhpVal{}))
			&& !rt.is_true(var_language) {
			mut var_languages := rt.call_function('wp_get_available_translations', []rt.PhpVal{})
			if rt.is_true(var_languages) {
				var_scripts_to_print << 'language-chooser'
				display_header('language-chooser')
				print('<form id="setup" method="post" action="?step=1">')
				rt.call_function('wp_install_language_form', [
					var_languages.clone()])
				print('</form>')
			}
		}
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_int(1))) {
		if !(!rt.is_true(var_language)) {
			mut var_loaded_language := rt.call_function('wp_download_language_pack', [
				var_language.clone(),
			])
			if rt.is_true(var_loaded_language) {
				rt.call_function('load_default_textdomain', [
					var_loaded_language.clone()])
				var_GLOBALS.array_set('wp_locale', create_wp_locale())
			}
		}
		var_scripts_to_print << 'user-profile'
		display_header('')
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_ex', [rt.new_string('Welcome'), rt.new_string('Howdy')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [
			rt.new_string('Welcome to the famous five-minute WordPress installation process! Just fill in the information below and you&#8217;ll be on your way to using the most extendable and powerful personal publishing platform in the world.'),
		])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Information needed')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [
			rt.new_string('Please provide the following information. Do not worry, you can always change these settings later.'),
		])
		// unsupported statement: Stmt_InlineHTML
		display_setup_form(rt.new_null())
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_int(2))) {
		if !(!rt.is_true(var_language))
			&& rt.is_true(rt.call_function('load_default_textdomain', [var_language.clone()])) {
			var_loaded_language = var_language.clone()
			var_GLOBALS.array_set('wp_locale', create_wp_locale())
		} else {
			var_loaded_language = rt.new_string('en_US')
		}
		if !(!rt.is_true(rt.get_property(var_wpdb, 'error'))) {
			rt.call_function('wp_die', [
				rt.call_method(rt.get_property(var_wpdb, 'error'), 'get_error_message',
					[]rt.PhpVal{}),
			])
		}
		var_scripts_to_print << 'user-profile'
		display_header('')
		mut var_weblog_title := if rt.get_superglobal('_POST').array_isset(rt.new_string('weblog_title')) { rt.call_function('wp_unslash', [
				rt.get_superglobal('_POST').array_get(rt.new_string('weblog_title')),
			]).to_string().trim_space() } else { '' }
		mut var_user_name := if rt.get_superglobal('_POST').array_isset(rt.new_string('user_name')) { rt.call_function('wp_unslash', [
				rt.get_superglobal('_POST').array_get(rt.new_string('user_name')),
			]).to_string().trim_space() } else { '' }
		mut var_admin_password := if rt.get_superglobal('_POST').array_isset(rt.new_string('admin_password')) { rt.call_function('wp_unslash', [
				rt.get_superglobal('_POST').array_get(rt.new_string('admin_password')),
			]) } else { rt.new_string('') }
		mut var_admin_password_check := if rt.get_superglobal('_POST').array_isset(rt.new_string('admin_password2')) { rt.call_function('wp_unslash', [
				rt.get_superglobal('_POST').array_get(rt.new_string('admin_password2')),
			]) } else { rt.new_string('') }
		mut var_admin_email := if rt.get_superglobal('_POST').array_isset(rt.new_string('admin_email')) { rt.call_function('wp_unslash', [
				rt.get_superglobal('_POST').array_get(rt.new_string('admin_email')),
			]).to_string().trim_space() } else { '' }
		mut var_public := rt.new_int(if rt.get_superglobal('_POST').array_isset(rt.new_string('blog_public')) {
			rt.new_int((rt.get_superglobal('_POST').array_get(rt.new_string('blog_public'))).to_i64())
		} else {
			1
		})
		mut var_error := false
		if var_user_name == '' {
			display_setup_form(rt.call_function('__', [
				rt.new_string('Please provide a valid username.'),
			]))
			var_error = true
		} else if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('sanitize_user', [
			rt.new_string(var_user_name.str()).clone(),
			rt.new_bool(true),
		]), rt.new_string(var_user_name.str())))))
		{
			display_setup_form(rt.call_function('__', [
				rt.new_string('The username you provided has invalid characters.'),
			]))
			var_error = true
		} else if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_admin_password,
			var_admin_password_check))))
		{
			display_setup_form(rt.call_function('__', [
				rt.new_string('Your passwords do not match. Please try again.'),
			]))
			var_error = true
		} else if var_admin_email == '' {
			display_setup_form(rt.call_function('__', [
				rt.new_string('You must provide an email address.'),
			]))
			var_error = true
		} else if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_email', [
			rt.new_string(var_admin_email.str()).clone(),
		])))))
		{
			display_setup_form(rt.call_function('__', [
				rt.new_string('Sorry, that is not a valid email address. Email addresses look like <code>username@example.com</code>.'),
			]))
			var_error = true
		}
		if rt.is_true(rt.identical(rt.new_bool(false), rt.new_bool(var_error))) {
			rt.call_method(var_wpdb, 'show_errors', []rt.PhpVal{})
			mut var_result := rt.call_function('wp_install', [
				rt.new_string(var_weblog_title.str()).clone(),
				rt.new_string(var_user_name.str()).clone(), rt.new_string(var_admin_email.str()).clone(),
				var_public.clone(), rt.new_string(''),
				rt.call_function('wp_slash', [
					var_admin_password.clone(),
				]),
				var_loaded_language.clone()])
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('_e', [rt.new_string('Success!')])
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('_e', [
				rt.new_string('WordPress has been installed. Thank you, and enjoy!'),
			])
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('_e', [rt.new_string('Username')])
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_html', [
				rt.call_function('sanitize_user', [rt.new_string(var_user_name.str()).clone(),
					rt.new_bool(true)]),
			]))
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('_e', [rt.new_string('Password')])
			// unsupported statement: Stmt_InlineHTML
			if !(!rt.is_true(var_result.array_get(rt.new_string('password'))))
				&& !rt.is_true(var_admin_password_check) {
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_html', [
					var_result.array_get(rt.new_string('password')),
				]))
				// unsupported statement: Stmt_InlineHTML
			}
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(var_result.array_get(rt.new_string('password_message')))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_url', [
				rt.call_function('wp_login_url', []rt.PhpVal{}),
			]))
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('_e', [rt.new_string('Log In')])
			// unsupported statement: Stmt_InlineHTML
		}
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_is_mobile', []rt.PhpVal{}))))) {
		// unsupported statement: Stmt_InlineHTML
	}
	rt.call_function('wp_print_scripts', [
		rt.create_array_from_list(var_scripts_to_print),
	])
	// unsupported statement: Stmt_InlineHTML
}
