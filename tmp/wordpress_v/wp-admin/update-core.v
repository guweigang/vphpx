import rt

fn list_core_update(var_update rt.PhpVal) {
	mut var_wp_local_package := rt.new_null()
	mut var_wpdb := rt.new_null()
	mut var_update_major := []rt.PhpVal{}
	// unsupported statement: Stmt_Global
	// unsupported statement: Stmt_Static
	mut var_wp_version := rt.call_function('wp_get_wp_version', []rt.PhpVal{})
	mut var_version_string := rt.call_function('sprintf', [rt.new_string('%s&ndash;%s'), rt.get_property(var_update, 'current'), rt.call_function('get_locale', []rt.PhpVal{})])
	if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('en_US'), rt.get_property(var_update, 'locale'))) && rt.is_true(rt.identical(rt.new_string('en_US'), rt.call_function('get_locale', []rt.PhpVal{}))))) {
		var_version_string = rt.get_property(var_update, 'current')
	} else if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('en_US'), rt.get_property(var_update, 'locale'))) && rt.is_true(rt.get_property(rt.get_property(var_update, 'packages'), 'partial')))) && rt.is_true(rt.identical(var_wp_version, rt.get_property(var_update, 'partial_version'))))) {
		mut var_updates := rt.call_function('get_core_updates', []rt.PhpVal{})
		if rt.is_true(rt.new_bool(rt.is_true(var_updates) && 1 == var_updates.dup().array_count())) {
			var_version_string = rt.get_property(var_update, 'current')
		}
	} else if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('en_US'), rt.get_property(var_update, 'locale'))) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		var_version_string = rt.call_function('sprintf', [rt.new_string('%s&ndash;%s'), rt.get_property(var_update, 'current'), rt.get_property(var_update, 'locale')])
	}
	mut var_current := false
	if rt.is_true(rt.new_bool(!(!(rt.get_property(var_update, 'response')).is_null()) || rt.is_true(rt.identical(rt.new_string('latest'), rt.get_property(var_update, 'response'))))) {
		var_current = true
	}
	mut var_message := rt.new_string(rt.new_string(''))
	mut var_form_action := 'update-core.php?action=do-core-upgrade'
	mut var_php_version := rt.get_constant('PHP_VERSION')
	mut var_mysql_version := rt.call_method(var_wpdb, 'db_version', []rt.PhpVal{})
	mut var_show_buttons := true
	if rt.is_true(rt.call_function('preg_match', [rt.new_string('/-\\w+-\\d+/'), rt.get_property(var_update, 'current')])) {
		rt.call_function('preg_match', [rt.new_string('/^\\d+.\\d+/'), rt.get_property(var_update, 'current'), var_update_major.dup()])
		mut var_submit := rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Update to latest %s nightly')]), var_update_major.array_get(0)])
	} else {
		var_submit = rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Update to version %s')]), var_version_string.dup()])
	}
	if rt.is_true(rt.identical(rt.new_string('development'), rt.get_property(var_update, 'response'))) {
		var_message = rt.call_function('__', [rt.new_string('You can update to the latest nightly build manually:')])
	} else {
		if var_current {
			var_submit = rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Re-install version %s')]), var_version_string.dup()])
			var_form_action = 'update-core.php?action=do-core-reinstall'
		} else {
			mut var_php_compat := rt.call_function('version_compare', [var_php_version.dup(), rt.get_property(var_update, 'php_version'), rt.new_string('>=')])
			if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('file_exists', [(rt.get_constant('WP_CONTENT_DIR')).str() + '/db.php'])) && !rt.is_true(rt.get_property(var_wpdb, 'is_mysql')))) {
				mut var_mysql_compat := rt.new_bool(rt.new_bool(true))
			} else {
				var_mysql_compat = rt.call_function('version_compare', [var_mysql_version.dup(), rt.get_property(var_update, 'mysql_version'), rt.new_string('>=')])
			}
			mut var_version_url := rt.call_function('sprintf', [rt.call_function('esc_url', [rt.call_function('__', [rt.new_string('https://wordpress.org/documentation/wordpress-version/version-%s/')])]), rt.call_function('sanitize_title', [rt.get_property(var_update, 'current')])])
			mut var_php_update_message := rt.new_string('</p><p>' + (rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('<a href="%s">Learn more about updating PHP</a>.')]), rt.call_function('esc_url', [rt.call_function('wp_get_update_php_url', []rt.PhpVal{})])])).str())
			mut var_annotation := rt.call_function('wp_get_update_php_annotation', []rt.PhpVal{})
			if rt.is_true(var_annotation) {
				// unsupported expression: Expr_AssignOp_Concat
			}
			if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_mysql_compat)))) && rt.is_true(rt.new_bool(!(rt.is_true(var_php_compat)))))) {
				var_message = rt.new_string(rt.concat(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('You cannot update because <a href="%1$s">WordPress %2$s</a> requires PHP version %3$s or higher and MySQL version %4$s or higher. You are running PHP version %5$s and MySQL version %6$s.')]), var_version_url.dup(), rt.get_property(var_update, 'current'), rt.get_property(var_update, 'php_version'), rt.get_property(var_update, 'mysql_version'), var_php_version.dup(), var_mysql_version.dup()]), var_php_update_message))
			} else if rt.is_true(rt.new_bool(!(rt.is_true(var_php_compat)))) {
				var_message = rt.new_string(rt.concat(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('You cannot update because <a href="%1$s">WordPress %2$s</a> requires PHP version %3$s or higher. You are running version %4$s.')]), var_version_url.dup(), rt.get_property(var_update, 'current'), rt.get_property(var_update, 'php_version'), var_php_version.dup()]), var_php_update_message))
			} else if rt.is_true(rt.new_bool(!(rt.is_true(var_mysql_compat)))) {
				var_message = rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('You cannot update because <a href="%1$s">WordPress %2$s</a> requires MySQL version %3$s or higher. You are running version %4$s.')]), var_version_url.dup(), rt.get_property(var_update, 'current'), rt.get_property(var_update, 'mysql_version'), var_mysql_version.dup()])
			} else {
				var_message = rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('You can update from WordPress %1$s to <a href="%2$s">WordPress %3$s</a> manually:')]), var_wp_version.dup(), var_version_url.dup(), var_version_string.dup()])
			}
			if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_mysql_compat)))) || rt.is_true(rt.new_bool(!(rt.is_true(var_php_compat)))))) {
				var_show_buttons = false
			}
		}
	}
	print('<p>')
	rt.echo_val(var_message)
	print('</p>')
	print('<form method="post" action="' + (rt.call_function('esc_url', [rt.new_string(var_form_action).dup()])).str() + '" name="upgrade" class="upgrade">')
	rt.call_function('wp_nonce_field', [rt.new_string('upgrade-core')])
	print('<p>')
	print('<input name="version" value="' + (rt.call_function('esc_attr', [rt.get_property(var_update, 'current')])).str() + '" type="hidden" />')
	print('<input name="locale" value="' + (rt.call_function('esc_attr', [rt.get_property(var_update, 'locale')])).str() + '" type="hidden" />')
	if var_show_buttons {
		if var_first_pass {
			rt.call_function('submit_button', [var_submit.dup(), if var_current { rt.new_string('') } else { rt.new_string('primary regular') }, rt.new_string('upgrade'), rt.new_bool(false)])
			mut var_first_pass := false
		} else {
			rt.call_function('submit_button', [var_submit.dup(), rt.new_string(''), rt.new_string('upgrade'), rt.new_bool(false)])
		}
	}
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		if rt.is_true(rt.new_bool(!(!(rt.get_property(var_update, 'dismissed')).is_null()) || rt.is_true(rt.new_bool(!(rt.is_true(rt.get_property(var_update, 'dismissed'))))))) {
			rt.call_function('submit_button', [rt.call_function('__', [rt.new_string('Hide this update')]), rt.new_string(''), rt.new_string('dismiss'), rt.new_bool(false)])
		} else {
			rt.call_function('submit_button', [rt.call_function('__', [rt.new_string('Bring back this update')]), rt.new_string(''), rt.new_string('undismiss'), rt.new_bool(false)])
		}
	}
	print('</p>')
	if rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) && rt.is_true(rt.new_bool(!(!(var_wp_local_package).is_null()) || rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))))) {
		print('<p class="hint">' + (rt.call_function('__', [rt.new_string('This localized version contains both the translation and various other localization fixes.')])).str() + '</p>')
	} else if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('en_US'), rt.get_property(var_update, 'locale'))) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) && rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.get_property(rt.get_property(var_update, 'packages'), 'partial'))))) && rt.is_true(rt.identical(var_wp_version, rt.get_property(var_update, 'partial_version'))))))) {
		print('<p class="hint">' + (rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('You are about to install WordPress %s <strong>in English (US)</strong>. There is a chance this update will break your translation. You may prefer to wait for the localized version to be released.')]), if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) { rt.get_property(var_update, 'current') } else { rt.new_string('') }])).str() + '</p>')
	}
	print('</form>')
}

fn dismissed_updates() {
	mut var_dismissed := rt.call_function('get_core_updates', [rt.create_array([rt.ArrayItem{ key: 'dismissed', val: true }, rt.ArrayItem{ key: 'available', val: false }])])
	if rt.is_true(var_dismissed) {
		mut var_show_text := rt.call_function('esc_js', [rt.call_function('__', [rt.new_string('Show hidden updates')])])
		mut var_hide_text := rt.call_function('esc_js', [rt.call_function('__', [rt.new_string('Hide hidden updates')])])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(var_show_text)
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(var_hide_text)
		// unsupported statement: Stmt_InlineHTML
		print('<p class="hide-if-no-js"><button type="button" class="button" id="show-dismissed" aria-expanded="false">' + (rt.call_function('__', [rt.new_string('Show hidden updates')])).str() + '</button></p>')
		print('<ul id="dismissed-updates" class="core-updates dismissed">')
		{
			mut iter_1 := rt.cast_array(var_dismissed).iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_update := item_1.val
				print('<li>')
				list_core_update(var_update.dup())
				print('</li>')
			}
		}
		print('</ul>')
	}
}

fn core_upgrade_preamble() {
	mut var_wp_version := rt.new_null()
	mut var_normalized_version := rt.new_null()
	mut var_updates := rt.call_function('get_core_updates', []rt.PhpVal{})
	rt.include_file((rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/version.php', '3')
	mut var_is_development_version := rt.call_function('preg_match', [rt.new_string('/alpha|beta|RC/'), var_wp_version.dup()])
	if rt.is_true(rt.new_bool(!(rt.get_property(var_updates.array_get(0), 'version')).is_null() && rt.is_true(rt.call_function('version_compare', [rt.get_property(var_updates.array_get(0), 'version'), var_wp_version.dup(), rt.new_string('>')])))) {
		print('<h2 class="response">')
		rt.call_function('_e', [rt.new_string('An updated version of WordPress is available.')])
		print('</h2>')
		mut var_message := rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('<strong>Important:</strong> Before updating, please <a href="%1$s">back up your database and files</a>. For help with updates, visit the <a href="%2$s">Updating WordPress</a> documentation page.')]), rt.call_function('__', [rt.new_string('https://developer.wordpress.org/advanced-administration/security/backup/')]), rt.call_function('__', [rt.new_string('https://wordpress.org/documentation/article/updating-wordpress/')])])
		rt.call_function('wp_admin_notice', [var_message.dup(), rt.create_array([rt.ArrayItem{ key: 'type', val: 'warning' }, rt.ArrayItem{ key: 'additional_classes', val: rt.create_array([rt.ArrayItem{ key: none, val: 'inline' }]) }])])
	} else if rt.is_true(var_is_development_version) {
		print('<h2 class="response">' + (rt.call_function('__', [rt.new_string('You are using a development version of WordPress.')])).str() + '</h2>')
	} else {
		print('<h2 class="response">' + (rt.call_function('__', [rt.new_string('You have the latest version of WordPress.')])).str() + '</h2>')
	}
	print('<ul class="core-updates">')
	{
		mut iter_1 := rt.cast_array(var_updates).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_update := item_1.val
			print('<li>')
			list_core_update(var_update.dup())
			print('</li>')
		}
	}
	print('</ul>')
	if rt.is_true(rt.new_bool(rt.is_true(var_updates) && rt.is_true(rt.new_bool(var_updates.dup().array_count() > 1 || rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))))) {
		print('<p>' + (rt.call_function('__', [rt.new_string('While your site is being updated, it will be in maintenance mode. As soon as your updates are complete, this mode will be deactivated.')])).str() + '</p>')
	} else if rt.is_true(rt.new_bool(!(rt.is_true(var_updates)))) {
		// unsupported assign target: Expr_List
		print('<p>' + (rt.call_function('sprintf', [rt.call_function('__', []), rt.call_function('esc_url', []), var_normalized_version.dup()])).str() + '</p>')
	}
	dismissed_updates()
}

fn core_auto_updates_settings() {
	if rt.get_superglobal('_GET').array_isset(rt.new_string('core-major-auto-updates-saved')) {
		if rt.is_true(rt.identical(, )) {
			
		} else if rt.is_true() {
		}
	}
	rt.include_file(, '4')
	
}


fn main() {
	defer {
		rt.shutdown()
	}

	rt.include_file(@DIR + '/admin.php', '4')
	rt.call_function('wp_enqueue_style', [rt.new_string('plugin-install')])
	rt.call_function('wp_enqueue_script', [rt.new_string('plugin-install')])
	rt.call_function('wp_enqueue_script', [rt.new_string('updates')])
	rt.call_function('add_thickbox', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_network_admin', []rt.PhpVal{}))))))) {
		rt.call_function('wp_redirect', [rt.call_function('network_admin_url', [rt.new_string('update-core.php')])])
		// unsupported expression: Expr_Exit
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('update_core')]))))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('update_themes')]))))))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('update_plugins')]))))))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('update_languages')]))))))) {
		rt.call_function('wp_die', [rt.call_function('__', [rt.new_string('Sorry, you are not allowed to update this site.')])])
	}
}
