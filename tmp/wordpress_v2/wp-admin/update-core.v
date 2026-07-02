import rt
import crypto.md5

fn list_core_update(var_update rt.PhpVal) {
	mut var_wp_local_package := rt.new_null()
	mut var_wpdb := rt.new_null()
	mut var_update_major := []rt.PhpVal{}
	mut var_wp_version := rt.new_null()
	mut var_version_string := rt.new_null()
	mut var_updates := rt.new_null()
	mut var_current := false
	mut var_message := rt.new_null()
	mut var_form_action := ''
	mut var_php_version := rt.new_null()
	mut var_mysql_version := rt.new_null()
	mut var_show_buttons := false
	mut var_submit := rt.new_null()
	mut var_php_compat := rt.new_null()
	mut var_mysql_compat := rt.new_null()
	mut var_version_url := rt.new_null()
	mut var_php_update_message := rt.new_null()
	mut var_annotation := rt.new_null()
	mut var_first_pass := false
	var_wp_version = rt.call_function('wp_get_wp_version', []rt.PhpVal{})
	var_version_string = rt.call_function('sprintf', [rt.new_string('%s&ndash;%s'),
		rt.get_property(var_update, 'current'), rt.call_function('get_locale', []rt.PhpVal{})])
	if rt.is_true(rt.identical(rt.new_string('en_US'), rt.get_property(var_update, 'locale')))
		&& rt.is_true(rt.identical(rt.new_string('en_US'), rt.call_function('get_locale', []rt.PhpVal{}))) {
		var_version_string = rt.get_property(var_update, 'current')
	} else if
		rt.is_true(rt.identical(rt.new_string('en_US'), rt.get_property(var_update, 'locale')))
		&& rt.is_true(rt.get_property(rt.get_property(var_update, 'packages'), 'partial'))
		&& rt.is_true(rt.identical(var_wp_version, rt.get_property(var_update, 'partial_version'))) {
		var_updates = rt.call_function('get_core_updates', []rt.PhpVal{})
		if rt.is_true(var_updates) && 1 == var_updates.clone().array_count() {
			var_version_string = rt.get_property(var_update, 'current')
		}
	} else if
		rt.is_true(rt.identical(rt.new_string('en_US'), rt.get_property(var_update, 'locale')))
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('en_US'), rt.call_function('get_locale', []rt.PhpVal{}))))) {
		var_version_string = rt.call_function('sprintf', [rt.new_string('%s&ndash;%s'),
			rt.get_property(var_update, 'current'), rt.get_property(var_update, 'locale')])
	}
	var_current = false
	if !(!(rt.get_property(var_update, 'response')).is_null())
		|| rt.is_true(rt.identical(rt.new_string('latest'), rt.get_property(var_update, 'response'))) {
		var_current = true
	}
	var_message = rt.new_string('')
	var_form_action = 'update-core.php?action=do-core-upgrade'
	var_php_version = rt.get_constant('PHP_VERSION')
	var_mysql_version = rt.call_method(var_wpdb, 'db_version', []rt.PhpVal{})
	var_show_buttons = true
	if rt.is_true(rt.call_function('preg_match', [rt.new_string('/-\\w+-\\d+/'),
		rt.get_property(var_update, 'current')]))
	{
		rt.call_function('preg_match', [rt.new_string('/^\\d+.\\d+/'),
			rt.get_property(var_update, 'current'), rt.create_array_from_list(var_update_major)])
		var_submit = rt.call_function('sprintf', [
			rt.call_function('__', [rt.new_string('Update to latest %s nightly')]),
			var_update_major[0],
		])
	} else {
		var_submit = rt.call_function('sprintf', [
			rt.call_function('__', [rt.new_string('Update to version %s')]),
			var_version_string.clone(),
		])
	}
	if rt.is_true(rt.identical(rt.new_string('development'),
		rt.get_property(var_update, 'response')))
	{
		var_message = rt.call_function('__', [
			rt.new_string('You can update to the latest nightly build manually:'),
		])
	} else {
		if var_current {
			var_submit = rt.call_function('sprintf', [
				rt.call_function('__', [rt.new_string('Re-install version %s')]),
				var_version_string.clone(),
			])
			var_form_action = 'update-core.php?action=do-core-reinstall'
		} else {
			var_php_compat = rt.call_function('version_compare', [
				var_php_version.clone(), rt.get_property(var_update, 'php_version'),
				rt.new_string('>=')])
			if rt.is_true(rt.call_function('file_exists', [rt.new_string((rt.get_constant('WP_CONTENT_DIR')).str() + '/db.php')]))
				&& !rt.is_true(rt.get_property(var_wpdb, 'is_mysql')) {
				var_mysql_compat = rt.new_bool(true)
			} else {
				var_mysql_compat = rt.call_function('version_compare', [
					var_mysql_version.clone(), rt.get_property(var_update, 'mysql_version'),
					rt.new_string('>=')])
			}
			var_version_url = rt.call_function('sprintf', [
				rt.call_function('esc_url', [
					rt.call_function('__', [
						rt.new_string('https://wordpress.org/documentation/wordpress-version/version-%s/'),
					]),
				]),
				rt.call_function('sanitize_title', [
					rt.get_property(var_update, 'current'),
				]),
			])
			var_php_update_message =
				rt.new_string('</p><p>' +(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('<a href="%s">Learn more about updating PHP</a>.')]), rt.call_function('esc_url', [rt.call_function('wp_get_update_php_url', []rt.PhpVal{})])])).str())
			var_annotation = rt.call_function('wp_get_update_php_annotation', []rt.PhpVal{})
			if rt.is_true(var_annotation) {
				var_php_update_message = rt.concat(var_php_update_message, rt.new_string(
					'</p><p><em>' + var_annotation.str() + '</em>'))
			}
			if rt.is_true(rt.new_bool(!(rt.is_true(var_mysql_compat))))
				&& rt.is_true(rt.new_bool(!(rt.is_true(var_php_compat)))) {
				var_message = rt.new_string(
					(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('You cannot update because <a href="%1$s">WordPress %2$s</a> requires PHP version %3$s or higher and MySQL version %4$s or higher. You are running PHP version %5$s and MySQL version %6$s.')]), var_version_url.clone(), rt.get_property(var_update, 'current'), rt.get_property(var_update, 'php_version'), rt.get_property(var_update, 'mysql_version'), var_php_version.clone(), var_mysql_version.clone()])).str() +
					var_php_update_message.str())
			} else if rt.is_true(rt.new_bool(!(rt.is_true(var_php_compat)))) {
				var_message = rt.new_string(
					(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('You cannot update because <a href="%1$s">WordPress %2$s</a> requires PHP version %3$s or higher. You are running version %4$s.')]), var_version_url.clone(), rt.get_property(var_update, 'current'), rt.get_property(var_update, 'php_version'), var_php_version.clone()])).str() +
					var_php_update_message.str())
			} else if rt.is_true(rt.new_bool(!(rt.is_true(var_mysql_compat)))) {
				var_message = rt.call_function('sprintf', [
					rt.call_function('__', [
						rt.new_string('You cannot update because <a href="%1$s">WordPress %2$s</a> requires MySQL version %3$s or higher. You are running version %4$s.'),
					]),
					var_version_url.clone(),
					rt.get_property(var_update, 'current'),
					rt.get_property(var_update, 'mysql_version'),
					var_mysql_version.clone(),
				])
			} else {
				var_message = rt.call_function('sprintf', [
					rt.call_function('__', [
						rt.new_string('You can update from WordPress %1$s to <a href="%2$s">WordPress %3$s</a> manually:'),
					]),
					var_wp_version.clone(),
					var_version_url.clone(),
					var_version_string.clone(),
				])
			}
			if rt.is_true(rt.new_bool(!(rt.is_true(var_mysql_compat))))
				|| rt.is_true(rt.new_bool(!(rt.is_true(var_php_compat)))) {
				var_show_buttons = false
			}
		}
	}
	print('<p>')
	rt.echo_val(var_message)
	print('</p>')
	print('<form method="post" action="' +
		(rt.call_function('esc_url', [rt.new_string(var_form_action.str()).clone()])).str() +
		'" name="upgrade" class="upgrade">')
	rt.call_function('wp_nonce_field', [rt.new_string('upgrade-core')])
	print('<p>')
	print('<input name="version" value="' +
		(rt.call_function('esc_attr', [rt.get_property(var_update, 'current')])).str() +
		'" type="hidden" />')
	print('<input name="locale" value="' +
		(rt.call_function('esc_attr', [rt.get_property(var_update, 'locale')])).str() +
		'" type="hidden" />')
	if var_show_buttons {
		if var_first_pass {
			rt.call_function('submit_button', [var_submit.clone(),
				rt.new_string((if var_current { '' } else { 'primary regular' }).str()),
				rt.new_string('upgrade'), rt.new_bool(false)])
			var_first_pass = false
		} else {
			rt.call_function('submit_button', [var_submit.clone(),
				rt.new_string(''), rt.new_string('upgrade'), rt.new_bool(false)])
		}
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('en_US'), rt.get_property(var_update,
		'locale')))))
	{
		if !(!(rt.get_property(var_update, 'dismissed')).is_null())
			|| rt.is_true(rt.new_bool(!(rt.is_true(rt.get_property(var_update, 'dismissed'))))) {
			rt.call_function('submit_button', [
				rt.call_function('__', [rt.new_string('Hide this update')]),
				rt.new_string(''),
				rt.new_string('dismiss'),
				rt.new_bool(false),
			])
		} else {
			rt.call_function('submit_button', [
				rt.call_function('__', [rt.new_string('Bring back this update')]),
				rt.new_string(''),
				rt.new_string('undismiss'),
				rt.new_bool(false),
			])
		}
	}
	print('</p>')
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('en_US'), rt.get_property(var_update, 'locale')))))
		&& !(!var_wp_local_package.is_null())
		|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_wp_local_package, rt.get_property(var_update, 'locale'))))) {
		print('<p class="hint">' +
			(rt.call_function('__', [rt.new_string('This localized version contains both the translation and various other localization fixes.')])).str() +
			'</p>')
	} else if
		rt.is_true(rt.identical(rt.new_string('en_US'), rt.get_property(var_update, 'locale')))
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('en_US'), rt.call_function('get_locale', []rt.PhpVal{})))))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.get_property(rt.get_property(var_update, 'packages'), 'partial')))))
		&& rt.is_true(rt.identical(var_wp_version, rt.get_property(var_update, 'partial_version'))) {
		print('<p class="hint">' +
			(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('You are about to install WordPress %s <strong>in English (US)</strong>. There is a chance this update will break your translation. You may prefer to wait for the localized version to be released.')]), if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('development'), rt.get_property(var_update, 'response'))))) { rt.get_property(var_update, 'current') } else { rt.new_string('') }])).str() +
			'</p>')
	}
	print('</form>')
}

fn dismissed_updates() {
	mut var_dismissed := rt.new_null()
	mut var_show_text := rt.new_null()
	mut var_hide_text := rt.new_null()
	mut var_update := rt.new_null()
	var_dismissed = rt.call_function('get_core_updates', [
		rt.create_array([rt.ArrayItem{ key: 'dismissed', val: true },
			rt.ArrayItem{ key: 'available', val: false }]),
	])
	if rt.is_true(var_dismissed) {
		var_show_text = rt.call_function('esc_js', [
			rt.call_function('__', [rt.new_string('Show hidden updates')]),
		])
		var_hide_text = rt.call_function('esc_js', [
			rt.call_function('__', [rt.new_string('Hide hidden updates')]),
		])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(var_show_text)
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(var_hide_text)
		// unsupported statement: Stmt_InlineHTML
		print(
			'<p class="hide-if-no-js"><button type="button" class="button" id="show-dismissed" aria-expanded="false">' +
			(rt.call_function('__', [rt.new_string('Show hidden updates')])).str() + '</button></p>')
		print('<ul id="dismissed-updates" class="core-updates dismissed">')
		mut iter_1 := rt.cast_array(var_dismissed).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_update_shadow := item_1.val
			print('<li>')
			list_core_update(var_update_shadow.clone())
			print('</li>')
		}
		print('</ul>')
	}
}

fn core_upgrade_preamble() {
	mut var_wp_version := rt.new_null()
	mut var_normalized_version := rt.new_null()
	mut var_updates := rt.new_null()
	mut var_is_development_version := rt.new_null()
	mut var_message := rt.new_null()
	mut var_update := rt.new_null()
	var_updates = rt.call_function('get_core_updates', []rt.PhpVal{})
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/version.php', '3')
	var_is_development_version = rt.call_function('preg_match', [
		rt.new_string('/alpha|beta|RC/'),
		var_wp_version.clone(),
	])
	if !(rt.get_property(var_updates.array_get(rt.new_int(0)), 'version')).is_null()
		&& rt.is_true(rt.call_function('version_compare', [rt.get_property(var_updates.array_get(rt.new_int(0)), 'version'), var_wp_version.clone(), rt.new_string('>')])) {
		print('<h2 class="response">')
		rt.call_function('_e', [
			rt.new_string('An updated version of WordPress is available.'),
		])
		print('</h2>')
		var_message = rt.call_function('sprintf', [
			rt.call_function('__', [
				rt.new_string('<strong>Important:</strong> Before updating, please <a href="%1$s">back up your database and files</a>. For help with updates, visit the <a href="%2$s">Updating WordPress</a> documentation page.'),
			]),
			rt.call_function('__', [
				rt.new_string('https://developer.wordpress.org/advanced-administration/security/backup/'),
			]),
			rt.call_function('__', [
				rt.new_string('https://wordpress.org/documentation/article/updating-wordpress/'),
			]),
		])
		rt.call_function('wp_admin_notice', [var_message.clone(),
			rt.create_array([rt.ArrayItem{ key: 'type', val: 'warning' },
				rt.ArrayItem{ key: 'additional_classes', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'inline' },
				]) }])])
	} else if rt.is_true(var_is_development_version) {
		print('<h2 class="response">' +
			(rt.call_function('__', [rt.new_string('You are using a development version of WordPress.')])).str() +
			'</h2>')
	} else {
		print('<h2 class="response">' +
			(rt.call_function('__', [rt.new_string('You have the latest version of WordPress.')])).str() +
			'</h2>')
	}
	print('<ul class="core-updates">')
	mut iter_2 := rt.cast_array(var_updates).iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_update_shadow := item_2.val
		print('<li>')
		list_core_update(var_update_shadow.clone())
		print('</li>')
	}
	print('</ul>')
	if rt.is_true(var_updates) && var_updates.clone().array_count() > 1
		|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('latest'), rt.get_property(var_updates.array_get(rt.new_int(0)), 'response'))))) {
		print('<p>' +
			(rt.call_function('__', [rt.new_string('While your site is being updated, it will be in maintenance mode. As soon as your updates are complete, this mode will be deactivated.')])).str() +
			'</p>')
	} else if rt.is_true(rt.new_bool(!(rt.is_true(var_updates)))) {
		mut list_tmp_1 := rt.call_function('explode', [rt.new_string('-'),
			var_wp_version.clone()])
		var_normalized_version = list_tmp_1.array_get(0)
		print('<p>' +
			(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('<a href="%1$s">Learn more about WordPress %2$s</a>.')]), rt.call_function('esc_url', [rt.call_function('self_admin_url', [rt.new_string('about.php')])]), var_normalized_version.clone()])).str() +
			'</p>')
	}
	dismissed_updates()
}

fn core_auto_updates_settings() {
	mut var_notice_text := rt.new_null()
	mut var_updater := rt.new_null()
	mut var_upgrade_dev := rt.new_null()
	mut var_upgrade_minor := rt.new_null()
	mut var_upgrade_major := rt.new_null()
	mut var_can_set_update_option := false
	mut var_auto_update_settings := map[string]rt.PhpVal{}
	mut var_wp_version := rt.new_null()
	mut var_updates := rt.new_null()
	mut var_action_url := rt.new_null()
	if rt.get_superglobal('_GET').array_isset(rt.new_string('core-major-auto-updates-saved')) {
		if rt.is_true(rt.identical(rt.new_string('enabled'),
			rt.get_superglobal('_GET').array_get(rt.new_string('core-major-auto-updates-saved'))))
		{
			var_notice_text = rt.call_function('__', [
				rt.new_string('Automatic updates for all WordPress versions have been enabled. Thank you!'),
			])
			rt.call_function('wp_admin_notice', [var_notice_text.clone(),
				rt.create_array([rt.ArrayItem{ key: 'type', val: 'success' },
					rt.ArrayItem{ key: 'dismissible', val: true }])])
		} else if rt.is_true(rt.identical(rt.new_string('disabled'),
			rt.get_superglobal('_GET').array_get(rt.new_string('core-major-auto-updates-saved'))))
		{
			var_notice_text = rt.call_function('__', [
				rt.new_string('WordPress will only receive automatic security and maintenance releases from now on.'),
			])
			rt.call_function('wp_admin_notice', [var_notice_text.clone(),
				rt.create_array([rt.ArrayItem{ key: 'type', val: 'success' },
					rt.ArrayItem{ key: 'dismissible', val: true }])])
		}
	}
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/class-wp-upgrader.php',
		'4')
	var_updater = create_wp_automatic_updater()
	var_upgrade_dev = rt.identical(rt.call_function('get_site_option', [
		rt.new_string('auto_update_core_dev'),
		rt.new_string('enabled'),
	]), rt.new_string('enabled'))
	var_upgrade_minor = rt.identical(rt.call_function('get_site_option', [
		rt.new_string('auto_update_core_minor'),
		rt.new_string('enabled'),
	]), rt.new_string('enabled'))
	var_upgrade_major = rt.identical(rt.call_function('get_site_option', [
		rt.new_string('auto_update_core_major'),
		rt.new_string('unset'),
	]), rt.new_string('enabled'))
	var_can_set_update_option = true
	if rt.is_true(rt.call_function('defined', [rt.new_string('WP_AUTO_UPDATE_CORE')])) {
		if rt.is_true(rt.identical(rt.new_bool(false), rt.get_constant('WP_AUTO_UPDATE_CORE'))) {
			var_upgrade_dev = rt.new_bool(false)
			var_upgrade_minor = rt.new_bool(false)
			var_upgrade_major = rt.new_bool(false)
		} else if
			rt.is_true(rt.identical(rt.new_bool(true), rt.get_constant('WP_AUTO_UPDATE_CORE')))
			|| rt.is_true(rt.call_function('in_array', [rt.get_constant('WP_AUTO_UPDATE_CORE'), rt.create_array([rt.ArrayItem{
			key: none
			val: 'beta'
		}, rt.ArrayItem{ key: none, val: 'rc' }, rt.ArrayItem{ key: none, val: 'development' }, rt.ArrayItem{
			key: none
			val: 'branch-development'
		}]), rt.new_bool(true)])) {
			var_upgrade_dev = rt.new_bool(true)
			var_upgrade_minor = rt.new_bool(true)
			var_upgrade_major = rt.new_bool(true)
		} else if rt.is_true(rt.identical(rt.new_string('minor'),
			rt.get_constant('WP_AUTO_UPDATE_CORE')))
		{
			var_upgrade_dev = rt.new_bool(false)
			var_upgrade_minor = rt.new_bool(true)
			var_upgrade_major = rt.new_bool(false)
		}
		var_can_set_update_option = false
	}
	if rt.is_true(var_updater.is_disabled()) {
		var_upgrade_dev = rt.new_bool(false)
		var_upgrade_minor = rt.new_bool(false)
		var_upgrade_major = rt.new_bool(false)
		var_can_set_update_option = false
	}
	if rt.is_true(rt.call_function('has_filter', [
		rt.new_string('allow_major_auto_core_updates'),
	]))
	{
		var_can_set_update_option = false
	}
	var_upgrade_dev = rt.call_function('apply_filters', [
		rt.new_string('allow_dev_auto_core_updates'),
		var_upgrade_dev.clone(),
	])
	var_upgrade_minor = rt.call_function('apply_filters', [
		rt.new_string('allow_minor_auto_core_updates'),
		var_upgrade_minor.clone(),
	])
	var_upgrade_major = rt.call_function('apply_filters', [
		rt.new_string('allow_major_auto_core_updates'),
		var_upgrade_major.clone(),
	])
	var_auto_update_settings = {
		'dev':   var_upgrade_dev
		'minor': var_upgrade_minor
		'major': var_upgrade_major
	}
	if rt.is_true(var_upgrade_major) {
		var_wp_version = rt.call_function('wp_get_wp_version', []rt.PhpVal{})
		var_updates = rt.call_function('get_core_updates', []rt.PhpVal{})
		if !(rt.get_property(var_updates.array_get(rt.new_int(0)), 'version')).is_null()
			&& rt.is_true(rt.call_function('version_compare', [rt.get_property(var_updates.array_get(rt.new_int(0)), 'version'), var_wp_version.clone(), rt.new_string('>')])) {
			print('<p>' + (rt.call_function('wp_get_auto_update_message', []rt.PhpVal{})).str() +
				'</p>')
		}
	}
	var_action_url = rt.call_function('self_admin_url', [
		rt.new_string('update-core.php?action=core-major-auto-updates-settings'),
	])
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(var_updater.is_vcs_checkout(rt.get_constant('ABSPATH'))) {
		rt.call_function('_e', [
			rt.new_string('This site appears to be under version control. Automatic updates are disabled.'),
		])
	} else if rt.is_true(var_upgrade_major) {
		rt.call_function('_e', [
			rt.new_string('This site is automatically kept up to date with each new version of WordPress.'),
		])
		if var_can_set_update_option {
			print('<br />')
			rt.call_function('printf', [
				rt.new_string('<a href="%s" class="core-auto-update-settings-link core-auto-update-settings-link-disable">%s</a>'),
				rt.call_function('wp_nonce_url', [
					rt.call_function('add_query_arg', [rt.new_string('value'),
						rt.new_string('disable'), var_action_url.clone()]),
					rt.new_string('core-major-auto-updates-nonce'),
				]),
				rt.call_function('__', [
					rt.new_string('Switch to automatic updates for maintenance and security releases only.'),
				]),
			])
		}
	} else if rt.is_true(var_upgrade_minor) {
		rt.call_function('_e', [
			rt.new_string('This site is automatically kept up to date with maintenance and security releases of WordPress only.'),
		])
		if var_can_set_update_option {
			print('<br />')
			rt.call_function('printf', [
				rt.new_string('<a href="%s" class="core-auto-update-settings-link core-auto-update-settings-link-enable">%s</a>'),
				rt.call_function('wp_nonce_url', [
					rt.call_function('add_query_arg', [rt.new_string('value'),
						rt.new_string('enable'), var_action_url.clone()]),
					rt.new_string('core-major-auto-updates-nonce'),
				]),
				rt.call_function('__', [
					rt.new_string('Enable automatic updates for all new versions of WordPress.'),
				]),
			])
		}
	} else {
		rt.call_function('_e', [
			rt.new_string('This site will not receive automatic updates for new versions of WordPress.'),
		])
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string('after_core_auto_updates_settings'),
		rt.create_array_from_native_map(var_auto_update_settings)])
}

fn list_plugin_updates() {
	mut var_wp_version := rt.new_null()
	mut var_cur_wp_version := rt.new_null()
	mut var_plugins := rt.new_null()
	mut var_form_action := ''
	mut var_core_updates := rt.new_null()
	mut var_core_update_version := rt.new_null()
	mut var_plugins_count := i64(0)
	mut var_auto_updates := rt.new_null()
	mut var_auto_update_notice := rt.new_null()
	mut var_plugin_data := rt.new_null()
	mut var_plugin_file := rt.new_null()
	mut var_icon := rt.new_null()
	mut var_preferred_icons := []rt.PhpVal{}
	mut var_preferred_icon := rt.new_null()
	mut var_compat := rt.new_null()
	mut var_requires_php := rt.new_null()
	mut var_compatible_php := rt.new_null()
	mut var_annotation := rt.new_null()
	mut var_upgrade_notice := rt.new_null()
	mut var_details_url := rt.new_null()
	mut var_details := rt.new_null()
	mut var_checkbox_id := rt.new_null()
	var_wp_version = rt.call_function('wp_get_wp_version', []rt.PhpVal{})
	var_cur_wp_version = rt.call_function('preg_replace', [rt.new_string('/-.*$/'),
		rt.new_string(''), var_wp_version.clone()])
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/plugin-install.php',
		'4')
	var_plugins = rt.call_function('get_plugin_updates', []rt.PhpVal{})
	if !rt.is_true(var_plugins) {
		print('<h2>' + (rt.call_function('__', [rt.new_string('Plugins')])).str() + '</h2>')
		print('<p>' +
			(rt.call_function('__', [rt.new_string('Your plugins are all up to date.')])).str() +
			'</p>')
		return
	}
	var_form_action = 'update-core.php?action=do-plugin-upgrade'
	var_core_updates = rt.call_function('get_core_updates', []rt.PhpVal{})
	if !(!(rt.get_property(var_core_updates.array_get(rt.new_int(0)), 'response')).is_null())
		|| rt.is_true(rt.identical(rt.new_string('latest'), rt.get_property(var_core_updates.array_get(rt.new_int(0)), 'response')))
		|| rt.is_true(rt.identical(rt.new_string('development'), rt.get_property(var_core_updates.array_get(rt.new_int(0)), 'response')))
		|| rt.is_true(rt.call_function('version_compare', [rt.get_property(var_core_updates.array_get(rt.new_int(0)), 'current'), var_cur_wp_version.clone(), rt.new_string('=')])) {
		var_core_update_version = rt.new_bool(false)
	} else {
		var_core_update_version = rt.get_property(var_core_updates.array_get(rt.new_int(0)),
			'current')
	}
	var_plugins_count = var_plugins.clone().array_count()
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('printf', [rt.new_string('%s <span class="count">(%d)</span>'),
		rt.call_function('__', [rt.new_string('Plugins')]),
		rt.call_function('number_format_i18n', [
			rt.new_int(var_plugins_count).clone()])])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [
		rt.new_string('The following plugins have new versions available. Check the ones you want to update and then click &#8220;Update Plugins&#8221;.'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [rt.new_string(var_form_action.str()).clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('wp_nonce_field', [rt.new_string('upgrade-core')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('Update Plugins')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Select All')])
	// unsupported statement: Stmt_InlineHTML
	var_auto_updates = rt.new_array()
	if rt.is_true(rt.call_function('wp_is_auto_update_enabled_for_type', [
		rt.new_string('plugin'),
	]))
	{
		var_auto_updates = rt.cast_array(rt.call_function('get_site_option', [
			rt.new_string('auto_update_plugins'),
			rt.new_array(),
		]))
		var_auto_update_notice = rt.new_string(' | ' +
			(rt.call_function('wp_get_auto_update_message', []rt.PhpVal{})).str())
	}
	mut iter_3 := rt.cast_array(var_plugins).iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_plugin_data_shadow := item_3.val
		mut var_plugin_file_shadow := item_3.key
		var_plugin_data_shadow = rt.array_to_object(rt.call_function('_get_plugin_data_markup_translate', [
			var_plugin_file_shadow.clone(),
			rt.cast_array(var_plugin_data_shadow),
			rt.new_bool(false),
			rt.new_bool(true),
		]))
		var_icon = rt.new_string('<span class="dashicons dashicons-admin-plugins"></span>')
		var_preferred_icons = ['svg', '2x', '1x', 'default']
		for var_preferred_icon_shadow in var_preferred_icons {
			if !(!rt.is_true(rt.get_property(rt.get_property(var_plugin_data_shadow, 'update'),
				'icons').array_get(rt.new_string(var_preferred_icon_shadow.str())))) {
				var_icon = rt.new_string('<img src="' +
					(rt.call_function('esc_url', [rt.get_property(rt.get_property(var_plugin_data_shadow, 'update'), 'icons').array_get(rt.new_string(var_preferred_icon_shadow.str()))])).str() +
					'" alt="" class="plugin-icon" />')
				break
			}
		}
		if !(rt.get_property(rt.get_property(var_plugin_data_shadow, 'update'), 'tested')).is_null()
			&& rt.is_true(rt.call_function('version_compare', [rt.get_property(rt.get_property(var_plugin_data_shadow, 'update'), 'tested'), var_cur_wp_version.clone(), rt.new_string('>=')])) {
			var_compat =
				rt.new_string('<br />' +(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Compatibility with WordPress %s: Yes (according to its author)')]), var_cur_wp_version.clone()])).str())
		} else {
			var_compat =
				rt.new_string('<br />' +(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Compatibility with WordPress %s: Not tested')]), var_cur_wp_version.clone()])).str())
		}
		if rt.is_true(var_core_update_version) {
			if !(rt.get_property(rt.get_property(var_plugin_data_shadow, 'update'), 'tested')).is_null()
				&& rt.is_true(rt.call_function('version_compare', [rt.get_property(rt.get_property(var_plugin_data_shadow, 'update'), 'tested'), var_core_update_version.clone(), rt.new_string('>=')])) {
				var_compat = rt.concat(var_compat,
					rt.new_string('<br />' +(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Compatibility with WordPress %s: Yes (according to its author)')]), var_core_update_version.clone()])).str()))
			} else {
				var_compat = rt.concat(var_compat,
					rt.new_string('<br />' +(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Compatibility with WordPress %s: Not tested')]), var_core_update_version.clone()])).str()))
			}
		}
		var_requires_php = if !(rt.get_property(rt.get_property(var_plugin_data_shadow, 'update'),
			'requires_php')).is_null() {
			rt.get_property(rt.get_property(var_plugin_data_shadow, 'update'), 'requires_php')
		} else {
			rt.new_null()
		}
		var_compatible_php = rt.call_function('is_php_version_compatible', [
			var_requires_php.clone()])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_compatible_php))))
			&& rt.is_true(rt.call_function('current_user_can', [rt.new_string('update_php')])) {
			var_compat = rt.concat(var_compat, rt.new_string('<br />' +
				(rt.call_function('__', [rt.new_string('This update does not work with your version of PHP.')])).str() +
				'&nbsp;'))
			var_compat = rt.concat(var_compat, rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('<a href="%s">Learn more about updating PHP</a>.'),
				]),
				rt.call_function('esc_url', [
					rt.call_function('wp_get_update_php_url', []rt.PhpVal{}),
				]),
			]))
			var_annotation = rt.call_function('wp_get_update_php_annotation', []rt.PhpVal{})
			if rt.is_true(var_annotation) {
				var_compat = rt.concat(var_compat, rt.new_string('</p><p><em>' +
					var_annotation.str() + '</em>'))
			}
		}
		if !(rt.get_property(rt.get_property(var_plugin_data_shadow, 'update'), 'upgrade_notice')).is_null() {
			var_upgrade_notice =
				rt.new_string('<br />' +(rt.call_function('strip_tags', [rt.get_property(rt.get_property(var_plugin_data_shadow, 'update'), 'upgrade_notice')])).str())
		} else {
			var_upgrade_notice = rt.new_string('')
		}
		var_details_url = rt.call_function('self_admin_url', [
			rt.new_string('plugin-install.php?tab=plugin-information&plugin=' +
				(rt.get_property(rt.get_property(var_plugin_data_shadow, 'update'), 'slug')).str() +
				'&section=changelog&TB_iframe=true&width=640&height=662'),
		])
		var_details = rt.call_function('sprintf', [
			rt.new_string('<a href="%1$s" class="thickbox open-plugin-details-modal" aria-label="%2$s">%3$s</a>'),
			rt.call_function('esc_url', [var_details_url.clone()]),
			rt.call_function('esc_attr', [
				rt.call_function('sprintf', [
					rt.call_function('__', [
						rt.new_string('View %1$s version %2$s details'),
					]),
					rt.get_property(var_plugin_data_shadow, 'Name'),
					rt.get_property(rt.get_property(var_plugin_data_shadow, 'update'),
						'new_version'),
				]),
			]),
			rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('View version %s details.'),
				]),
				rt.get_property(rt.get_property(var_plugin_data_shadow, 'update'), 'new_version'),
			]),
		])
		var_checkbox_id = rt.new_string('checkbox_' +
			md5.hexhash(var_plugin_file_shadow.clone().to_string()))
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(var_compatible_php) {
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(var_checkbox_id)
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [var_plugin_file_shadow.clone()]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(var_checkbox_id)
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('printf', [
				rt.call_function('__', [rt.new_string('Select %s')]),
				rt.get_property(var_plugin_data_shadow, 'Name'),
			])
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(var_icon)
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.get_property(var_plugin_data_shadow, 'Name'))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('printf', [
			rt.call_function('__', [
				rt.new_string('You have version %1$s installed. Update to %2$s.'),
			]),
			rt.get_property(var_plugin_data_shadow, 'Version'),
			rt.get_property(rt.get_property(var_plugin_data_shadow, 'update'), 'new_version'),
		])
		print(' ' + var_details.str() + var_compat.str())
		if rt.is_true(rt.call_function('in_array', [var_plugin_file_shadow.clone(),
			var_auto_updates.clone(), rt.new_bool(true)]))
		{
			rt.echo_val(var_auto_update_notice)
		}
		rt.echo_val(var_upgrade_notice)
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Select All')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('Update Plugins')])
	// unsupported statement: Stmt_InlineHTML
}

fn list_theme_updates() {
	mut var_themes := rt.new_null()
	mut var_form_action := ''
	mut var_themes_count := i64(0)
	mut var_auto_updates := rt.new_null()
	mut var_auto_update_notice := rt.new_null()
	mut var_theme := rt.new_null()
	mut var_stylesheet := rt.new_null()
	mut var_requires_wp := rt.new_null()
	mut var_requires_php := rt.new_null()
	mut var_compatible_wp := rt.new_null()
	mut var_compatible_php := rt.new_null()
	mut var_compat := ''
	mut var_annotation := rt.new_null()
	mut var_checkbox_id := rt.new_null()
	var_themes = rt.call_function('get_theme_updates', []rt.PhpVal{})
	if !rt.is_true(var_themes) {
		print('<h2>' + (rt.call_function('__', [rt.new_string('Themes')])).str() + '</h2>')
		print('<p>' +
			(rt.call_function('__', [rt.new_string('Your themes are all up to date.')])).str() +
			'</p>')
		return
	}
	var_form_action = 'update-core.php?action=do-theme-upgrade'
	var_themes_count = var_themes.clone().array_count()
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('printf', [rt.new_string('%s <span class="count">(%d)</span>'),
		rt.call_function('__', [rt.new_string('Themes')]),
		rt.call_function('number_format_i18n', [
			rt.new_int(var_themes_count).clone()])])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [
		rt.new_string('The following themes have new versions available. Check the ones you want to update and then click &#8220;Update Themes&#8221;.'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('printf', [
		rt.call_function('__', [
			rt.new_string('<strong>Please Note:</strong> Any customizations you have made to theme files will be lost. Please consider using <a href="%s">child themes</a> for modifications.'),
		]),
		rt.call_function('__', [
			rt.new_string('https://developer.wordpress.org/themes/advanced-topics/child-themes/'),
		]),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [rt.new_string(var_form_action.str()).clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('wp_nonce_field', [rt.new_string('upgrade-core')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('Update Themes')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Select All')])
	// unsupported statement: Stmt_InlineHTML
	var_auto_updates = rt.new_array()
	if rt.is_true(rt.call_function('wp_is_auto_update_enabled_for_type', [
		rt.new_string('theme'),
	]))
	{
		var_auto_updates = rt.cast_array(rt.call_function('get_site_option', [
			rt.new_string('auto_update_themes'),
			rt.new_array(),
		]))
		var_auto_update_notice = rt.new_string(' | ' +
			(rt.call_function('wp_get_auto_update_message', []rt.PhpVal{})).str())
	}
	mut iter_4 := var_themes.iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_theme_shadow := item_4.val
		mut var_stylesheet_shadow := item_4.key
		var_requires_wp = if !(rt.get_property(var_theme_shadow, 'update').array_get(rt.new_string('requires'))).is_null() {
			rt.get_property(var_theme_shadow, 'update').array_get(rt.new_string('requires'))
		} else {
			rt.new_null()
		}
		var_requires_php = if !(rt.get_property(var_theme_shadow, 'update').array_get(rt.new_string('requires_php'))).is_null() {
			rt.get_property(var_theme_shadow, 'update').array_get(rt.new_string('requires_php'))
		} else {
			rt.new_null()
		}
		var_compatible_wp = rt.call_function('is_wp_version_compatible', [
			var_requires_wp.clone()])
		var_compatible_php = rt.call_function('is_php_version_compatible', [
			var_requires_php.clone()])
		var_compat = ''
		if rt.is_true(rt.new_bool(!(rt.is_true(var_compatible_wp))))
			&& rt.is_true(rt.new_bool(!(rt.is_true(var_compatible_php)))) {
			var_compat = var_compat + '<br />' +
				(rt.call_function('__', [rt.new_string('This update does not work with your versions of WordPress and PHP.')])).str() +
				'&nbsp;'
			if rt.is_true(rt.call_function('current_user_can', [rt.new_string('update_core')]))
				&& rt.is_true(rt.call_function('current_user_can', [rt.new_string('update_php')])) {
				var_compat = var_compat +(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('<a href="%1$s">Please update WordPress</a>, and then <a href="%2$s">learn more about updating PHP</a>.')]), rt.call_function('esc_url', [rt.call_function('self_admin_url', [rt.new_string('update-core.php')])]), rt.call_function('esc_url', [rt.call_function('wp_get_update_php_url', []rt.PhpVal{})])])).str()
				var_annotation = rt.call_function('wp_get_update_php_annotation', []rt.PhpVal{})
				if rt.is_true(var_annotation) {
					var_compat = var_compat + '</p><p><em>' + var_annotation.str() + '</em>'
				}
			} else if rt.is_true(rt.call_function('current_user_can', [
				rt.new_string('update_core'),
			]))
			{
				var_compat = var_compat +(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('<a href="%s">Please update WordPress</a>.')]), rt.call_function('esc_url', [rt.call_function('self_admin_url', [rt.new_string('update-core.php')])])])).str()
			} else if rt.is_true(rt.call_function('current_user_can', [
				rt.new_string('update_php'),
			]))
			{
				var_compat = var_compat +(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('<a href="%s">Learn more about updating PHP</a>.')]), rt.call_function('esc_url', [rt.call_function('wp_get_update_php_url', []rt.PhpVal{})])])).str()
				var_annotation = rt.call_function('wp_get_update_php_annotation', []rt.PhpVal{})
				if rt.is_true(var_annotation) {
					var_compat = var_compat + '</p><p><em>' + var_annotation.str() + '</em>'
				}
			}
		} else if rt.is_true(rt.new_bool(!(rt.is_true(var_compatible_wp)))) {
			var_compat = var_compat + '<br />' +
				(rt.call_function('__', [rt.new_string('This update does not work with your version of WordPress.')])).str() +
				'&nbsp;'
			if rt.is_true(rt.call_function('current_user_can', [
				rt.new_string('update_core'),
			]))
			{
				var_compat = var_compat +(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('<a href="%s">Please update WordPress</a>.')]), rt.call_function('esc_url', [rt.call_function('self_admin_url', [rt.new_string('update-core.php')])])])).str()
			}
		} else if rt.is_true(rt.new_bool(!(rt.is_true(var_compatible_php)))) {
			var_compat = var_compat + '<br />' +
				(rt.call_function('__', [rt.new_string('This update does not work with your version of PHP.')])).str() +
				'&nbsp;'
			if rt.is_true(rt.call_function('current_user_can', [
				rt.new_string('update_php'),
			]))
			{
				var_compat = var_compat +(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('<a href="%s">Learn more about updating PHP</a>.')]), rt.call_function('esc_url', [rt.call_function('wp_get_update_php_url', []rt.PhpVal{})])])).str()
				var_annotation = rt.call_function('wp_get_update_php_annotation', []rt.PhpVal{})
				if rt.is_true(var_annotation) {
					var_compat = var_compat + '</p><p><em>' + var_annotation.str() + '</em>'
				}
			}
		}
		var_checkbox_id = rt.new_string('checkbox_' +
			md5.hexhash(rt.call_method(var_theme_shadow, 'get', [rt.new_string('Name')]).to_string()))
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(var_compatible_wp) && rt.is_true(var_compatible_php) {
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(var_checkbox_id)
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [var_stylesheet_shadow.clone()]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(var_checkbox_id)
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('printf', [
				rt.call_function('__', [rt.new_string('Select %s')]),
				rt.call_method(var_theme_shadow, 'display', [
					rt.new_string('Name')]),
			])
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_url', [
			rt.new_string(
				(rt.call_method(var_theme_shadow, 'get_screenshot', []rt.PhpVal{})).str() +
				'?ver=' + (rt.get_property(var_theme_shadow, 'version')).str()),
		]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_method(var_theme_shadow, 'display', [
			rt.new_string('Name')]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('printf', [
			rt.call_function('__', [
				rt.new_string('You have version %1$s installed. Update to %2$s.'),
			]),
			rt.call_method(var_theme_shadow, 'display', [
				rt.new_string('Version'),
			]),
			rt.get_property(var_theme_shadow, 'update').array_get(rt.new_string('new_version')),
		])
		print(' ' + var_compat)
		if rt.is_true(rt.call_function('in_array', [var_stylesheet_shadow.clone(),
			var_auto_updates.clone(), rt.new_bool(true)]))
		{
			rt.echo_val(var_auto_update_notice)
		}
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Select All')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('Update Themes')])
	// unsupported statement: Stmt_InlineHTML
}

fn list_translation_updates() {
	mut var_updates := rt.new_null()
	mut var_form_action := ''
	var_updates = rt.call_function('wp_get_translation_updates', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(rt.is_true(var_updates)))) {
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('en_US'), rt.call_function('get_locale',
			[]rt.PhpVal{})))))
		{
			print('<h2>' + (rt.call_function('__', [rt.new_string('Translations')])).str() + '</h2>')
			print('<p>' +
				(rt.call_function('__', [rt.new_string('Your translations are all up to date.')])).str() +
				'</p>')
		}
		return
	}
	var_form_action = 'update-core.php?action=do-translation-upgrade'
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Translations')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [rt.new_string(var_form_action.str()).clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('New translations are available.')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('wp_nonce_field', [rt.new_string('upgrade-translations')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('Update Translations')])
	// unsupported statement: Stmt_InlineHTML
}

fn do_core_upgrade(reinstall bool) {
	mut var_reinstall := reinstall
	mut var_wp_filesystem := rt.new_null()
	mut var_url := rt.new_null()
	mut var_version := rt.new_null()
	mut var_locale := rt.new_null()
	mut var_update := rt.new_null()
	mut var_allow_relaxed_file_ownership := false
	mut var_credentials := rt.new_null()
	mut var_message := rt.new_null()
	mut var_upgrader := rt.new_null()
	mut var_result := rt.new_null()
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/class-wp-upgrader.php',
		'4')
	if var_reinstall {
		var_url = rt.new_string('update-core.php?action=do-core-reinstall')
	} else {
		var_url = rt.new_string('update-core.php?action=do-core-upgrade')
	}
	var_url = rt.call_function('wp_nonce_url', [var_url.clone(),
		rt.new_string('upgrade-core')])
	var_version = if !(rt.get_superglobal('_POST').array_get(rt.new_string('version'))).is_null() {
		rt.get_superglobal('_POST').array_get(rt.new_string('version'))
	} else {
		rt.new_bool(false)
	}
	var_locale = if !(rt.get_superglobal('_POST').array_get(rt.new_string('locale'))).is_null() {
		rt.get_superglobal('_POST').array_get(rt.new_string('locale'))
	} else {
		rt.new_string('en_US')
	}
	var_update = rt.call_function('find_core_update', [var_version.clone(),
		var_locale.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_update)))) {
		return
	}
	var_allow_relaxed_file_ownership = !var_reinstall
		&& !(rt.get_property(var_update, 'new_files')).is_null()
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.get_property(var_update, 'new_files')))))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Update WordPress')])
	// unsupported statement: Stmt_InlineHTML
	var_credentials = rt.call_function('request_filesystem_credentials', [
		var_url.clone(), rt.new_string(''), rt.new_bool(false),
		rt.get_constant('ABSPATH'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: 'version' },
			rt.ArrayItem{ key: none, val: 'locale' },
		]),
		rt.new_bool(var_allow_relaxed_file_ownership).clone()])
	if rt.is_true(rt.identical(rt.new_bool(false), var_credentials)) {
		print('</div>')
		return
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('WP_Filesystem', [
		var_credentials.clone(), rt.get_constant('ABSPATH'), rt.new_bool(var_allow_relaxed_file_ownership).clone()])))))
	{
		rt.call_function('request_filesystem_credentials', [var_url.clone(),
			rt.new_string(''), rt.new_bool(true), rt.get_constant('ABSPATH'),
			rt.create_array([rt.ArrayItem{ key: none, val: 'version' },
				rt.ArrayItem{ key: none, val: 'locale' }]),
			rt.new_bool(var_allow_relaxed_file_ownership).clone()])
		print('</div>')
		return
	}
	if rt.is_true(rt.call_method(rt.get_property(var_wp_filesystem, 'errors'), 'has_errors',
		[]rt.PhpVal{}))
	{
		mut iter_5 := rt.call_method(rt.get_property(var_wp_filesystem, 'errors'),
			'get_error_messages', []rt.PhpVal{}).iterator()
		for {
			item_5 := iter_5.next() or { break }
			mut var_message_shadow := item_5.val
			rt.call_function('show_message', [var_message_shadow.clone()])
		}
		print('</div>')
		return
	}
	if var_reinstall {
		rt.set_property(var_update, 'response', rt.new_string('reinstall'))
	}
	rt.call_function('add_filter', [rt.new_string('update_feedback'),
		rt.new_string('show_message')])
	var_upgrader = create_core_upgrader()
	var_result = rt.call_method(var_upgrader, 'upgrade', [var_update.clone(),
		rt.create_array([
			rt.ArrayItem{ key: 'allow_relaxed_file_ownership', val: var_allow_relaxed_file_ownership },
		])])
	if rt.is_true(rt.call_function('is_wp_error', [var_result.clone()])) {
		rt.call_function('show_message', [var_result.clone()])
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('up_to_date'), rt.call_method(var_result, 'get_error_code', []rt.PhpVal{})))))
			&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('locked'), rt.call_method(var_result, 'get_error_code', []rt.PhpVal{}))))) {
			rt.call_function('show_message', [
				rt.call_function('__', [rt.new_string('Installation failed.')]),
			])
		}
		print('</div>')
		return
	}
	rt.call_function('show_message', [
		rt.call_function('__', [rt.new_string('WordPress updated successfully.')]),
	])
	rt.call_function('show_message', [
		rt.new_string('<span class="hide-if-no-js">' +
			(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Welcome to WordPress %1$s. You will be redirected to the About WordPress screen. If not, click <a href="%2$s">here</a>.')]), var_result.clone(), rt.call_function('esc_url', [rt.call_function('self_admin_url', [rt.new_string('about.php?updated')])])])).str() +
			'</span>'),
	])
	rt.call_function('show_message', [
		rt.new_string('<span class="hide-if-js">' +
			(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Welcome to WordPress %1$s. <a href="%2$s">Learn more</a>.')]), var_result.clone(), rt.call_function('esc_url', [rt.call_function('self_admin_url', [rt.new_string('about.php?updated')])])])).str() +
			'</span>'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [
		rt.call_function('self_admin_url', [rt.new_string('about.php?updated')]),
	]))
	// unsupported statement: Stmt_InlineHTML
}

fn do_dismiss_core_update() {
	mut var_version := rt.new_null()
	mut var_locale := rt.new_null()
	mut var_update := rt.new_null()
	var_version = if !(rt.get_superglobal('_POST').array_get(rt.new_string('version'))).is_null() {
		rt.get_superglobal('_POST').array_get(rt.new_string('version'))
	} else {
		rt.new_bool(false)
	}
	var_locale = if !(rt.get_superglobal('_POST').array_get(rt.new_string('locale'))).is_null() {
		rt.get_superglobal('_POST').array_get(rt.new_string('locale'))
	} else {
		rt.new_string('en_US')
	}
	var_update = rt.call_function('find_core_update', [var_version.clone(),
		var_locale.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_update)))) {
		return
	}
	rt.call_function('dismiss_core_update', [var_update.clone()])
	rt.call_function('wp_redirect', [
		rt.call_function('wp_nonce_url', [
			rt.new_string('update-core.php?action=upgrade-core'),
			rt.new_string('upgrade-core'),
		]),
	])
	exit(0)
}

fn do_undismiss_core_update() {
	mut var_version := rt.new_null()
	mut var_locale := rt.new_null()
	mut var_update := rt.new_null()
	var_version = if !(rt.get_superglobal('_POST').array_get(rt.new_string('version'))).is_null() {
		rt.get_superglobal('_POST').array_get(rt.new_string('version'))
	} else {
		rt.new_bool(false)
	}
	var_locale = if !(rt.get_superglobal('_POST').array_get(rt.new_string('locale'))).is_null() {
		rt.get_superglobal('_POST').array_get(rt.new_string('locale'))
	} else {
		rt.new_string('en_US')
	}
	var_update = rt.call_function('find_core_update', [var_version.clone(),
		var_locale.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_update)))) {
		return
	}
	rt.call_function('undismiss_core_update', [var_version.clone(),
		var_locale.clone()])
	rt.call_function('wp_redirect', [
		rt.call_function('wp_nonce_url', [
			rt.new_string('update-core.php?action=upgrade-core'),
			rt.new_string('upgrade-core'),
		]),
	])
	exit(0)
}

struct Class_WP_Automatic_Updater {
	rt.PhpObjectBase
}

struct Class_Core_Upgrader {
	rt.PhpObjectBase
}

struct Class_Language_Pack_Upgrader {
	rt.PhpObjectBase
}

struct Class_Language_Pack_Upgrader_Skin {
	rt.PhpObjectBase
}

fn create_wp_automatic_updater(_args ...rt.PhpVal) &Class_WP_Automatic_Updater {
	mut obj := &Class_WP_Automatic_Updater{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_core_upgrader(_args ...rt.PhpVal) &Class_Core_Upgrader {
	mut obj := &Class_Core_Upgrader{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_language_pack_upgrader(_args ...rt.PhpVal) &Class_Language_Pack_Upgrader {
	mut obj := &Class_Language_Pack_Upgrader{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_language_pack_upgrader_skin(_args ...rt.PhpVal) &Class_Language_Pack_Upgrader_Skin {
	mut obj := &Class_Language_Pack_Upgrader_Skin{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Automatic_Updater) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Automatic_Updater) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Automatic_Updater) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Core_Upgrader) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Core_Upgrader) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Core_Upgrader) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Language_Pack_Upgrader) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Language_Pack_Upgrader) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Language_Pack_Upgrader) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Language_Pack_Upgrader_Skin) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Language_Pack_Upgrader_Skin) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Language_Pack_Upgrader_Skin) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
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
	if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{}))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_network_admin', []rt.PhpVal{}))))) {
		rt.call_function('wp_redirect', [
			rt.call_function('network_admin_url', [rt.new_string('update-core.php')]),
		])
		exit(0)
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('update_core')])))))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('update_themes')])))))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('update_plugins')])))))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('update_languages')]))))) {
		rt.call_function('wp_die', [
			rt.call_function('__', [
				rt.new_string('Sorry, you are not allowed to update this site.'),
			]),
		])
	}
	mut var_action := if !(rt.get_superglobal('_GET').array_get(rt.new_string('action'))).is_null() {
		rt.get_superglobal('_GET').array_get(rt.new_string('action'))
	} else {
		rt.new_string('upgrade-core')
	}
	mut var_upgrade_error := rt.new_bool(false)
	if rt.is_true(rt.identical(rt.new_string('do-theme-upgrade'), var_action))
		|| (rt.is_true(rt.identical(rt.new_string('do-plugin-upgrade'), var_action))
		&& !(rt.get_superglobal('_GET').array_isset(rt.new_string('plugins'))))
		&& !(rt.get_superglobal('_POST').array_isset(rt.new_string('checked'))) {
		var_upgrade_error = rt.new_string((if rt.is_true(rt.identical(rt.new_string('do-theme-upgrade'),
			var_action))
		{
			'themes'
		} else {
			'plugins'
		}).str())
		var_action = rt.new_string('upgrade-core')
	}
	mut var_title := rt.call_function('__', [rt.new_string('WordPress Updates')])
	mut var_parent_file := 'index.php'
	mut var_updates_overview := rt.new_string('<p>' +
		(rt.call_function('__', [rt.new_string('On this screen, you can update to the latest version of WordPress, as well as update your themes, plugins, and translations.')])).str() +
		'</p>')
	var_updates_overview = rt.concat(var_updates_overview, rt.new_string('<p>' +
		(rt.call_function('__', [rt.new_string('If an update is available, you&#8127;ll see a notification appear in the Toolbar and navigation menu.')])).str() +
		' ' +
		(rt.call_function('__', [rt.new_string('Keeping your site updated is important for security. It also makes the internet a safer place for you and your readers.')])).str() +
		'</p>'))
	rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'add_help_tab', [
		rt.create_array([rt.ArrayItem{ key: 'id', val: 'overview' },
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Overview'),
			]) }, rt.ArrayItem{ key: 'content', val: var_updates_overview }]),
	])
	mut var_updates_howto := rt.new_string('<p>' +
		(rt.call_function('__', [rt.new_string('<strong>WordPress</strong> &mdash; Updating your WordPress installation is a simple one-click procedure: just <strong>click on the &#8220;Update now&#8221; button</strong> when you are notified that a new version is available.')])).str() +
		' ' +
		(rt.call_function('__', [rt.new_string('In most cases, WordPress will automatically apply maintenance and security updates in the background for you.')])).str() +
		'</p>')
	var_updates_howto = rt.concat(var_updates_howto, rt.new_string('<p>' +
		(rt.call_function('__', [rt.new_string('<strong>Themes and Plugins</strong> &mdash; To update individual themes or plugins from this screen, use the checkboxes to make your selection, then <strong>click on the appropriate &#8220;Update&#8221; button</strong>. To update all of your themes or plugins at once, you can check the box at the top of the section to select all before clicking the update button.')])).str() +
		'</p>'))
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('en_US'), rt.call_function('get_locale',
		[]rt.PhpVal{})))))
	{
		var_updates_howto = rt.concat(var_updates_howto, rt.new_string('<p>' +
			(rt.call_function('__', [rt.new_string('<strong>Translations</strong> &mdash; The files translating WordPress into your language are updated for you whenever any other updates occur. But if these files are out of date, you can <strong>click the &#8220;Update Translations&#8221;</strong> button.')])).str() +
			'</p>'))
	}
	rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'add_help_tab', [
		rt.create_array([rt.ArrayItem{ key: 'id', val: 'how-to-update' },
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('How to Update'),
			]) }, rt.ArrayItem{ key: 'content', val: var_updates_howto }]),
	])
	mut var_help_sidebar_autoupdates := rt.new_string('')
	if (rt.is_true(rt.call_function('current_user_can', [rt.new_string('update_themes')]))
		&& rt.is_true(rt.call_function('wp_is_auto_update_enabled_for_type', [rt.new_string('theme')])))
		|| (rt.is_true(rt.call_function('current_user_can', [rt.new_string('update_plugins')]))
		&& rt.is_true(rt.call_function('wp_is_auto_update_enabled_for_type', [rt.new_string('plugin')]))) {
		mut var_help_tab_autoupdates := rt.new_string('<p>' +
			(rt.call_function('__', [rt.new_string('Auto-updates can be enabled or disabled for WordPress major versions and for each individual theme or plugin. Themes or plugins with auto-updates enabled will display the estimated date of the next auto-update. Auto-updates depends on the WP-Cron task scheduling system.')])).str() +
			'</p>')
		var_help_tab_autoupdates = rt.concat(var_help_tab_autoupdates, rt.new_string('<p>' +
			(rt.call_function('__', [rt.new_string('Please note: Third-party themes and plugins, or custom code, may override WordPress scheduling.')])).str() +
			'</p>'))
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
	mut var_help_sidebar_rollback := rt.new_string('')
	if rt.is_true(rt.call_function('current_user_can', [rt.new_string('update_themes')]))
		|| rt.is_true(rt.call_function('current_user_can', [rt.new_string('update_plugins')])) {
		mut var_rollback_help := rt.new_string('<p>' +
			(rt.call_function('__', [rt.new_string('This feature will create a temporary backup of a plugin or theme before it is upgraded. This backup is used to restore the plugin or theme back to its previous state if there is an error during the update process.')])).str() +
			'</p>')
		var_rollback_help = rt.concat(var_rollback_help, rt.new_string('<p>' +
			(rt.call_function('__', [rt.new_string('On systems with fewer resources, this may lead to server timeouts or resource limits being reached. If you encounter an issue during the update process, please create a support forum topic and reference <strong>Rollback</strong> in the issue title.')])).str() +
			'</p>'))
		rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'add_help_tab', [
			rt.create_array([rt.ArrayItem{ key: 'id', val: 'rollback-plugins-themes' },
				rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
					rt.new_string('Restore Plugin or Theme'),
				]) }, rt.ArrayItem{ key: 'content', val: var_rollback_help }]),
		])
		var_help_sidebar_rollback = rt.new_string('<p>' +
			(rt.call_function('__', [rt.new_string('<a href="https://developer.wordpress.org/advanced-administration/wordpress/common-errors/">Common Errors</a>')])).str() +
			'</p>')
	}
	rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'set_help_sidebar', [
		rt.new_string('<p><strong>' +
			(rt.call_function('__', [rt.new_string('For more information:')])).str() +
			'</strong></p>' + '<p>' +
			(rt.call_function('__', [rt.new_string('<a href="https://wordpress.org/documentation/article/dashboard-updates-screen/">Documentation on Updating WordPress</a>')])).str() +
			'</p>' + var_help_sidebar_autoupdates.str() + '<p>' +
			(rt.call_function('__', [rt.new_string('<a href="https://wordpress.org/support/forums/">Support forums</a>')])).str() +
			'</p>' + var_help_sidebar_rollback.str()),
	])
	if rt.is_true(rt.identical(rt.new_string('upgrade-core'), var_action)) {
		mut var_force_check := !(!rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('force-check'))))
		rt.call_function('wp_version_check', [rt.new_array(),
			rt.new_bool(var_force_check).clone()])
		rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-header.php', '4')
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('WordPress Updates')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [
			rt.new_string('Updates may take several minutes to complete. If there is no feedback after 5 minutes, or if there are errors please refer to the Help section above.'),
		])
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(var_upgrade_error) {
			if rt.is_true(rt.identical(rt.new_string('themes'), var_upgrade_error)) {
				mut var_theme_updates := rt.call_function('get_theme_updates', []rt.PhpVal{})
				if !(!rt.is_true(var_theme_updates)) {
					rt.call_function('wp_admin_notice', [
						rt.call_function('__', [
							rt.new_string('Please select one or more themes to update.'),
						]),
						rt.create_array([
							rt.ArrayItem{ key: 'additional_classes', val: rt.create_array([
								rt.ArrayItem{ key: none, val: 'error' },
							]) },
						]),
					])
				}
			} else {
				mut var_plugin_updates := rt.call_function('get_plugin_updates', []rt.PhpVal{})
				if !(!rt.is_true(var_plugin_updates)) {
					rt.call_function('wp_admin_notice', [
						rt.call_function('__', [
							rt.new_string('Please select one or more plugins to update.'),
						]),
						rt.create_array([
							rt.ArrayItem{ key: 'additional_classes', val: rt.create_array([
								rt.ArrayItem{ key: none, val: 'error' },
							]) },
						]),
					])
				}
			}
		}
		mut var_last_update_check := rt.new_bool(false)
		mut var_current := rt.call_function('get_site_transient', [
			rt.new_string('update_core'),
		])
		if rt.is_true(var_current) && !(rt.get_property(var_current, 'last_checked')).is_null() {
			var_last_update_check = rt.add(rt.get_property(var_current, 'last_checked'), i64(rt.new_float((rt.call_function('get_option', [
				rt.new_string('gmt_offset'),
			])).to_f64()) * rt.get_constant('HOUR_IN_SECONDS')))
		}
		print('<h2 class="wp-current-version">')
		rt.call_function('printf', [
			rt.call_function('__', [rt.new_string('Current version: %s')]),
			rt.call_function('esc_html', [rt.call_function('wp_get_wp_version', []rt.PhpVal{})]),
		])
		print('</h2>')
		print('<p class="update-last-checked">')
		rt.call_function('printf', [
			rt.call_function('__', [rt.new_string('Last checked on %1$s at %2$s.')]),
			rt.call_function('date_i18n', [rt.call_function('__', [
				rt.new_string('F j, Y'),
			]),
				var_last_update_check.clone()]),
			rt.call_function('date_i18n', [rt.call_function('__', [
				rt.new_string('g:i a T'),
			]),
				var_last_update_check.clone()]),
		])
		print(' <a href="' +
			(rt.call_function('esc_url', [rt.call_function('self_admin_url', [rt.new_string('update-core.php?force-check=1')])])).str() +
			'">' + (rt.call_function('__', [rt.new_string('Check again.')])).str() + '</a>')
		print('</p>')
		if rt.is_true(rt.call_function('current_user_can', [rt.new_string('update_core')])) {
			core_auto_updates_settings()
			core_upgrade_preamble()
		}
		if rt.is_true(rt.call_function('current_user_can', [
			rt.new_string('update_plugins'),
		]))
		{
			list_plugin_updates()
		}
		if rt.is_true(rt.call_function('current_user_can', [
			rt.new_string('update_themes'),
		]))
		{
			list_theme_updates()
		}
		if rt.is_true(rt.call_function('current_user_can', [
			rt.new_string('update_languages'),
		]))
		{
			list_translation_updates()
		}
		rt.call_function('do_action', [rt.new_string('core_upgrade_preamble')])
		print('</div>')
		rt.call_function('wp_localize_script', [rt.new_string('updates'),
			rt.new_string('_wpUpdatesItemCounts'),
			rt.create_array([
				rt.ArrayItem{ key: 'totals', val: rt.call_function('wp_get_update_data',
					[]rt.PhpVal{}) },
			])])
		rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-footer.php', '4')
	} else if rt.is_true(rt.identical(rt.new_string('do-core-upgrade'), var_action))
		|| rt.is_true(rt.identical(rt.new_string('do-core-reinstall'), var_action)) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
			rt.new_string('update_core'),
		])))))
		{
			rt.call_function('wp_die', [
				rt.call_function('__', [
					rt.new_string('Sorry, you are not allowed to update this site.'),
				]),
			])
		}
		rt.call_function('check_admin_referer', [rt.new_string('upgrade-core')])
		if rt.get_superglobal('_POST').array_isset(rt.new_string('dismiss')) {
			do_dismiss_core_update()
		} else if rt.get_superglobal('_POST').array_isset(rt.new_string('undismiss')) {
			do_undismiss_core_update()
		}
		rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-header.php', '4')
		if rt.is_true(rt.identical(rt.new_string('do-core-reinstall'), var_action)) {
			mut var_reinstall := true
		} else {
			var_reinstall = false
		}
		if rt.get_superglobal('_POST').array_isset(rt.new_string('upgrade')) {
			do_core_upgrade(var_reinstall)
		}
		rt.call_function('wp_localize_script', [rt.new_string('updates'),
			rt.new_string('_wpUpdatesItemCounts'),
			rt.create_array([
				rt.ArrayItem{ key: 'totals', val: rt.call_function('wp_get_update_data',
					[]rt.PhpVal{}) },
			])])
		rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-footer.php', '4')
	} else if rt.is_true(rt.identical(rt.new_string('do-plugin-upgrade'), var_action)) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
			rt.new_string('update_plugins'),
		])))))
		{
			rt.call_function('wp_die', [
				rt.call_function('__', [
					rt.new_string('Sorry, you are not allowed to update this site.'),
				]),
			])
		}
		rt.call_function('check_admin_referer', [rt.new_string('upgrade-core')])
		if rt.get_superglobal('_GET').array_isset(rt.new_string('plugins')) {
			mut var_plugins := rt.call_function('explode', [rt.new_string(','),
				rt.get_superglobal('_GET').array_get(rt.new_string('plugins'))])
		} else if rt.get_superglobal('_POST').array_isset(rt.new_string('checked')) {
			var_plugins =
				rt.cast_array(rt.get_superglobal('_POST').array_get(rt.new_string('checked')))
		} else {
			rt.call_function('wp_redirect', [
				rt.call_function('admin_url', [rt.new_string('update-core.php')]),
			])
			exit(0)
		}
		mut var_url :=
			rt.new_string('update.php?action=update-selected&plugins=' +(rt.call_function('urlencode', [rt.call_function('implode', [rt.new_string(','), var_plugins.clone()])])).str())
		var_url = rt.call_function('wp_nonce_url', [var_url.clone(),
			rt.new_string('bulk-update-plugins')])
		var_title = rt.call_function('__', [rt.new_string('Update Plugins')])
		rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-header.php', '4')
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Update Plugins')])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(var_url)
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_attr_e', [rt.new_string('Update progress')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('wp_localize_script', [rt.new_string('updates'),
			rt.new_string('_wpUpdatesItemCounts'),
			rt.create_array([
				rt.ArrayItem{ key: 'totals', val: rt.call_function('wp_get_update_data',
					[]rt.PhpVal{}) },
			])])
		rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-footer.php', '4')
	} else if rt.is_true(rt.identical(rt.new_string('do-theme-upgrade'), var_action)) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
			rt.new_string('update_themes'),
		])))))
		{
			rt.call_function('wp_die', [
				rt.call_function('__', [
					rt.new_string('Sorry, you are not allowed to update this site.'),
				]),
			])
		}
		rt.call_function('check_admin_referer', [rt.new_string('upgrade-core')])
		if rt.get_superglobal('_GET').array_isset(rt.new_string('themes')) {
			mut var_themes := rt.call_function('explode', [rt.new_string(','),
				rt.get_superglobal('_GET').array_get(rt.new_string('themes'))])
		} else if rt.get_superglobal('_POST').array_isset(rt.new_string('checked')) {
			var_themes =
				rt.cast_array(rt.get_superglobal('_POST').array_get(rt.new_string('checked')))
		} else {
			rt.call_function('wp_redirect', [
				rt.call_function('admin_url', [rt.new_string('update-core.php')]),
			])
			exit(0)
		}
		var_url =
			rt.new_string('update.php?action=update-selected-themes&themes=' +(rt.call_function('urlencode', [rt.call_function('implode', [rt.new_string(','), var_themes.clone()])])).str())
		var_url = rt.call_function('wp_nonce_url', [var_url.clone(),
			rt.new_string('bulk-update-themes')])
		var_title = rt.call_function('__', [rt.new_string('Update Themes')])
		rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-header.php', '4')
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Update Themes')])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(var_url)
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_attr_e', [rt.new_string('Update progress')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('wp_localize_script', [rt.new_string('updates'),
			rt.new_string('_wpUpdatesItemCounts'),
			rt.create_array([
				rt.ArrayItem{ key: 'totals', val: rt.call_function('wp_get_update_data',
					[]rt.PhpVal{}) },
			])])
		rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-footer.php', '4')
	} else if rt.is_true(rt.identical(rt.new_string('do-translation-upgrade'), var_action)) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
			rt.new_string('update_languages'),
		])))))
		{
			rt.call_function('wp_die', [
				rt.call_function('__', [
					rt.new_string('Sorry, you are not allowed to update this site.'),
				]),
			])
		}
		rt.call_function('check_admin_referer', [rt.new_string('upgrade-translations')])
		rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-header.php', '4')
		rt.include_file(
			(rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/class-wp-upgrader.php', '4')
		var_url = rt.new_string('update-core.php?action=do-translation-upgrade')
		mut var_nonce := 'upgrade-translations'
		var_title = rt.call_function('__', [rt.new_string('Update Translations')])
		mut var_context := rt.get_constant('WP_LANG_DIR')
		mut var_upgrader := create_language_pack_upgrader(create_language_pack_upgrader_skin(rt.call_function('compact', [
			rt.new_string('url'),
			rt.new_string('nonce'),
			rt.new_string('title'),
			rt.new_string('context'),
		])))
		mut var_result := rt.call_method(var_upgrader, 'bulk_upgrade', []rt.PhpVal{})
		rt.call_function('wp_localize_script', [rt.new_string('updates'),
			rt.new_string('_wpUpdatesItemCounts'),
			rt.create_array([
				rt.ArrayItem{ key: 'totals', val: rt.call_function('wp_get_update_data',
					[]rt.PhpVal{}) },
			])])
		rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-footer.php', '4')
	} else if rt.is_true(rt.identical(rt.new_string('core-major-auto-updates-settings'), var_action)) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
			rt.new_string('update_core'),
		])))))
		{
			rt.call_function('wp_die', [
				rt.call_function('__', [
					rt.new_string('Sorry, you are not allowed to update this site.'),
				]),
			])
		}
		mut var_redirect_url := rt.call_function('self_admin_url', [
			rt.new_string('update-core.php'),
		])
		if rt.get_superglobal('_GET').array_isset(rt.new_string('value')) {
			rt.call_function('check_admin_referer', [
				rt.new_string('core-major-auto-updates-nonce'),
			])
			if rt.is_true(rt.identical(rt.new_string('enable'),
				rt.get_superglobal('_GET').array_get(rt.new_string('value'))))
			{
				rt.call_function('update_site_option', [
					rt.new_string('auto_update_core_major'),
					rt.new_string('enabled'),
				])
				var_redirect_url = rt.call_function('add_query_arg', [
					rt.new_string('core-major-auto-updates-saved'),
					rt.new_string('enabled'),
					var_redirect_url.clone(),
				])
			} else if rt.is_true(rt.identical(rt.new_string('disable'),
				rt.get_superglobal('_GET').array_get(rt.new_string('value'))))
			{
				rt.call_function('update_site_option', [
					rt.new_string('auto_update_core_major'),
					rt.new_string('disabled'),
				])
				var_redirect_url = rt.call_function('add_query_arg', [
					rt.new_string('core-major-auto-updates-saved'),
					rt.new_string('disabled'),
					var_redirect_url.clone(),
				])
			}
		}
		rt.call_function('wp_redirect', [var_redirect_url.clone()])
		exit(0)
	} else {
		rt.call_function('do_action', [
			rt.new_string('update-core-custom_${var_action.to_string()}'),
		])
	}
}
