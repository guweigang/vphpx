import rt

const global_const_wp_installing = true

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_wp_version := rt.new_null()
	mut var_required_php_version := rt.new_null()
	mut var_required_php_extensions := rt.new_null()
	mut var_required_mysql_version := rt.new_null()
	mut var_wpdb := rt.new_null()
	mut var_wp_db_version := rt.new_null()
	rt.include_file((rt.call_function('dirname', [rt.new_string(@DIR)])).str() + '/wp-load.php',
		'3')
	rt.call_function('nocache_headers', []rt.PhpVal{})
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/upgrade.php', '4')
	rt.call_function('delete_site_transient', [rt.new_string('update_core')])
	mut var_step := if !(rt.get_superglobal('_GET').array_get(rt.new_string('step'))).is_null() {
		rt.get_superglobal('_GET').array_get(rt.new_string('step'))
	} else {
		rt.new_int(0)
	}
	if rt.is_true(rt.identical(rt.new_string('upgrade_db'), var_step)) {
		rt.call_function('wp_upgrade', []rt.PhpVal{})
		fn () {
			print((rt.new_string('0')).str())
			exit(0)
		}()
	}
	var_step = rt.new_int(var_step.to_i64())
	mut var_php_version := rt.get_constant('PHP_VERSION')
	mut var_mysql_version := rt.call_method(var_wpdb, 'db_version', []rt.PhpVal{})
	mut var_php_compat := rt.call_function('version_compare', [
		var_php_version.clone(), var_required_php_version.clone(),
		rt.new_string('>=')])
	if rt.is_true(rt.call_function('file_exists', [rt.new_string((rt.get_constant('WP_CONTENT_DIR')).str() + '/db.php')]))
		&& !rt.is_true(rt.get_property(var_wpdb, 'is_mysql')) {
		mut var_mysql_compat := rt.new_bool(true)
	} else {
		var_mysql_compat = rt.call_function('version_compare', [
			var_mysql_version.clone(), var_required_mysql_version.clone(),
			rt.new_string('>=')])
	}
	mut var_missing_extensions := []rt.PhpVal{}
	if !var_required_php_extensions.is_null() && var_required_php_extensions.clone().is_array() {
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
					rt.new_string('You cannot upgrade because <a href="%1$s">WordPress %2$s</a> requires the %3$s PHP extension.'),
				]),
				var_version_url.clone(),
				var_wp_version.clone(),
				var_extension.clone(),
			])
		}
	}
	rt.call_function('header', [
		rt.new_string('Content-Type: ' +
			(rt.call_function('get_option', [rt.new_string('html_type')])).str() + '; charset=' +
			(rt.call_function('get_option', [rt.new_string('blog_charset')])).str()),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('language_attributes', []rt.PhpVal{})
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('bloginfo', [rt.new_string('html_type')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('get_option', [rt.new_string('blog_charset')]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('WordPress &rsaquo; Update')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('wp_admin_css', [rt.new_string('install'),
		rt.new_bool(true)])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('WordPress')])
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.identical(rt.new_int((rt.call_function('get_option', [rt.new_string('db_version')])).to_i64()), var_wp_db_version))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_blog_installed', []rt.PhpVal{}))))) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('No Update Required')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [
			rt.new_string('Your WordPress database is already up to date!'),
		])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_url', [
			rt.call_function('get_option', [rt.new_string('home')]),
		]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Continue')])
		// unsupported statement: Stmt_InlineHTML
	} else if rt.is_true(rt.new_bool(!(rt.is_true(var_php_compat))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(var_mysql_compat)))) {
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
			var_php_update_message = rt.concat(var_php_update_message, rt.new_string(
				'</p><p><em>' + var_annotation.str() + '</em>'))
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(var_mysql_compat))))
			&& rt.is_true(rt.new_bool(!(rt.is_true(var_php_compat)))) {
			mut var_message := rt.new_string(
				(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('You cannot update because <a href="%1$s">WordPress %2$s</a> requires PHP version %3$s or higher and MySQL version %4$s or higher. You are running PHP version %5$s and MySQL version %6$s.')]), var_version_url.clone(), var_wp_version.clone(), var_required_php_version.clone(), var_required_mysql_version.clone(), var_php_version.clone(), var_mysql_version.clone()])).str() +
				var_php_update_message.str())
		} else if rt.is_true(rt.new_bool(!(rt.is_true(var_php_compat)))) {
			var_message = rt.new_string(
				(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('You cannot update because <a href="%1$s">WordPress %2$s</a> requires PHP version %3$s or higher. You are running version %4$s.')]), var_version_url.clone(), var_wp_version.clone(), var_required_php_version.clone(), var_php_version.clone()])).str() +
				var_php_update_message.str())
		} else if rt.is_true(rt.new_bool(!(rt.is_true(var_mysql_compat)))) {
			var_message = rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('You cannot update because <a href="%1$s">WordPress %2$s</a> requires MySQL version %3$s or higher. You are running version %4$s.'),
				]),
				var_version_url.clone(),
				var_wp_version.clone(),
				var_required_mysql_version.clone(),
				var_mysql_version.clone(),
			])
		}
		print('<p>' + var_message.str() + '</p>')
	} else if var_missing_extensions.len > 0 {
		print('<p>' +
			(rt.call_function('implode', [rt.new_string('</p><p>'), rt.create_array_from_list(var_missing_extensions)])).str() +
			'</p>')
	} else {
		mut switch_val_1 := var_step
		if rt.is_true(rt.equal(switch_val_1, rt.new_int(0))) {
			mut var_goback := rt.call_function('wp_get_referer', []rt.PhpVal{})
			if rt.is_true(var_goback) {
				var_goback = rt.call_function('sanitize_url', [
					var_goback.clone()])
				var_goback = rt.call_function('urlencode', [var_goback.clone()])
			}
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('_e', [rt.new_string('Database Update Required')])
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('_e', [
				rt.new_string('WordPress has been updated! Next and final step is to update your database to the newest version.'),
			])
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('_e', [
				rt.new_string('The database update process may take a little while, so please be patient.'),
			])
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(var_goback)
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('_e', [rt.new_string('Update WordPress Database')])
			// unsupported statement: Stmt_InlineHTML
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_int(1))) {
			rt.call_function('wp_upgrade', []rt.PhpVal{})
			mut var_backto := if !(!rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('backto')))) { rt.call_function('wp_unslash', [
					rt.call_function('urldecode', [rt.get_superglobal('_GET').array_get(rt.new_string('backto'))]),
				]) } else { (rt.call_function('__get_option', [rt.new_string('home')])).str() + '/' }
			var_backto = rt.call_function('esc_url', [var_backto.clone()])
			var_backto = rt.call_function('wp_validate_redirect', [
				var_backto.clone(),
				rt.new_string(
					(rt.call_function('__get_option', [rt.new_string('home')])).str() + '/')])
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('_e', [rt.new_string('Update Complete')])
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('_e', [
				rt.new_string('Your WordPress database has been successfully updated!'),
			])
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(var_backto)
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('_e', [rt.new_string('Continue')])
			// unsupported statement: Stmt_InlineHTML
		}
	}
	// unsupported statement: Stmt_InlineHTML
}
