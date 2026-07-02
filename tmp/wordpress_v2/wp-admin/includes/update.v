import rt

fn get_preferred_from_update_core() rt.PhpVal {
	mut var_updates := rt.new_null()
	var_updates = rt.new_bool(get_core_updates(rt.new_null()))
	if !(var_updates.clone().is_array()) {
		return rt.new_bool(false)
	}
	if !rt.is_true(var_updates) {
		return rt.new_object('stdClass', []string{}, rt.array_to_object(rt.create_array([
			rt.ArrayItem{ key: 'response', val: 'latest' },
		])))
	}
	return var_updates.array_get(rt.new_int(0))
}

fn get_core_updates(var_options_arg rt.PhpVal) bool {
	mut var_options := var_options_arg
	mut var_dismissed := rt.new_null()
	mut var_from_api := rt.new_null()
	mut var_updates := rt.new_null()
	mut var_result := []rt.PhpVal{}
	mut var_update := rt.new_null()
	var_options = rt.call_function('array_merge', [
		rt.create_array([rt.ArrayItem{ key: 'available', val: true },
			rt.ArrayItem{ key: 'dismissed', val: false }]),
		var_options.clone(),
	])
	var_dismissed = rt.call_function('get_site_option', [
		rt.new_string('dismissed_update_core'),
	])
	if !(var_dismissed.clone().is_array()) {
		var_dismissed = rt.new_array()
	}
	var_from_api = rt.call_function('get_site_transient', [rt.new_string('update_core')])
	if !(!(rt.get_property(var_from_api, 'updates')).is_null())
		|| !(rt.get_property(var_from_api, 'updates').is_array()) {
		return false
	}
	var_updates = rt.get_property(var_from_api, 'updates')
	var_result = rt.new_array()
	mut iter_1 := var_updates.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_update_shadow := item_1.val
		if rt.is_true(rt.identical(rt.new_string('autoupdate'), rt.get_property(var_update_shadow,
			'response')))
		{
			continue
		}
		if rt.is_true(rt.new_bool(var_dismissed.clone().array_isset(rt.new_string(
			(rt.get_property(var_update_shadow, 'current')).str() + '|' +
			(rt.get_property(var_update_shadow, 'locale')).str()))))
		{
			if rt.is_true(var_options.array_get(rt.new_string('dismissed'))) {
				rt.set_property(var_update_shadow, 'dismissed', rt.new_bool(true))
				var_result << var_update_shadow.clone()
			}
		} else {
			if rt.is_true(var_options.array_get(rt.new_string('available'))) {
				rt.set_property(var_update_shadow, 'dismissed', rt.new_bool(false))
				var_result << var_update_shadow.clone()
			}
		}
	}
	return var_result.to_bool()
}

fn find_core_auto_update() bool {
	mut var_updates := rt.new_null()
	mut var_auto_update := rt.new_null()
	mut var_upgrader := rt.new_null()
	mut var_update := rt.new_null()
	var_updates = rt.call_function('get_site_transient', [rt.new_string('update_core')])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_updates))))
		|| !rt.is_true(rt.get_property(var_updates, 'updates')) {
		return false
	}
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/class-wp-upgrader.php',
		'4')
	var_auto_update = rt.new_bool(false)
	var_upgrader = create_wp_automatic_updater()
	mut iter_2 := rt.get_property(var_updates, 'updates').iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_update_shadow := item_2.val
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('autoupdate'), rt.get_property(var_update_shadow,
			'response')))))
		{
			continue
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(var_upgrader.should_update(rt.new_string('core'),
			var_update_shadow.clone(), rt.get_constant('ABSPATH'))))))
		{
			continue
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(var_auto_update))))
			|| rt.is_true(rt.call_function('version_compare', [rt.get_property(var_update_shadow, 'current'), rt.get_property(var_auto_update, 'current'), rt.new_string('>')])) {
			var_auto_update = var_update_shadow.clone()
		}
	}
	return var_auto_update.to_bool()
}

fn get_core_checksums(var_version rt.PhpVal, var_locale rt.PhpVal) bool {
	mut var_http_url := rt.new_null()
	mut var_url := rt.new_null()
	mut var_ssl := rt.new_null()
	mut var_options := rt.new_null()
	mut var_response := rt.new_null()
	mut var_body := rt.new_null()
	var_http_url =
		rt.new_string('http://api.wordpress.org/core/checksums/1.0/?' +(rt.call_function('http_build_query', [rt.call_function('compact', [rt.new_string('version'), rt.new_string('locale')]), rt.new_string(''), rt.new_string('&')])).str())
	var_url = var_http_url.clone()
	var_ssl = rt.call_function('wp_http_supports', [
		rt.create_array([rt.ArrayItem{ key: none, val: 'ssl' }]),
	])
	if rt.is_true(var_ssl) {
		var_url = rt.call_function('set_url_scheme', [var_url.clone(),
			rt.new_string('https')])
	}
	var_options = rt.create_array([
		rt.ArrayItem{
			key: 'timeout'
			val: if rt.is_true(rt.call_function('wp_doing_cron', []rt.PhpVal{})) { 30 } else { 3 }
		},
	])
	var_response = rt.call_function('wp_remote_get', [var_url.clone(),
		var_options.clone()])
	if rt.is_true(var_ssl) && rt.is_true(rt.call_function('is_wp_error', [var_response.clone()])) {
		rt.call_function('wp_trigger_error', [rt.new_string(@FN),
			rt.new_string(
				(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('An unexpected error occurred. Something may be wrong with WordPress.org or this server&#8217;s configuration. If you continue to have problems, please try the <a href="%s">support forums</a>.')]), rt.call_function('__', [rt.new_string('https://wordpress.org/support/forums/')])])).str() +
				' ' +(rt.call_function('__', [rt.new_string('(WordPress could not establish a secure connection to WordPress.org. Please contact your server administrator.)')])).str()),
			if rt.is_true(rt.call_function('headers_sent', []rt.PhpVal{}))
				|| rt.is_true(rt.get_constant('WP_DEBUG')) {
				rt.get_constant('E_USER_WARNING')
			} else {
				rt.get_constant('E_USER_NOTICE')
			}])
		var_response = rt.call_function('wp_remote_get', [var_http_url.clone(),
			var_options.clone()])
	}
	if rt.is_true(rt.call_function('is_wp_error', [var_response.clone()]))
		|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int(200), rt.call_function('wp_remote_retrieve_response_code', [var_response.clone()]))))) {
		return false
	}
	var_body = rt.new_string(rt.call_function('wp_remote_retrieve_body', [
		var_response.clone()]).to_string().trim_space())
	var_body = rt.call_function('json_decode', [var_body.clone(),
		rt.new_bool(true)])
	if !(var_body.clone().is_array()) || !(var_body.array_isset(rt.new_string('checksums')))
		|| !(var_body.array_get(rt.new_string('checksums')).is_array()) {
		return false
	}
	return (var_body.array_get(rt.new_string('checksums'))).to_bool()
}

fn dismiss_core_update(var_update rt.PhpVal) rt.PhpVal {
	mut var_dismissed := rt.new_null()
	var_dismissed = rt.call_function('get_site_option', [
		rt.new_string('dismissed_update_core'),
	])
	var_dismissed.array_set((rt.get_property(var_update, 'current')).str() + '|' +
		(rt.get_property(var_update, 'locale')).str(), true)
	return rt.call_function('update_site_option', [
		rt.new_string('dismissed_update_core'),
		var_dismissed.clone(),
	])
}

fn undismiss_core_update(var_version rt.PhpVal, var_locale rt.PhpVal) bool {
	mut var_dismissed := rt.new_null()
	mut var_key := rt.new_null()
	var_dismissed = rt.call_function('get_site_option', [
		rt.new_string('dismissed_update_core'),
	])
	var_key = rt.new_string(var_version.str() + '|' + var_locale.str())
	if !(var_dismissed.array_isset(var_key)) {
		return false
	}
	var_dismissed.array_unset(var_key)
	return (rt.call_function('update_site_option', [
		rt.new_string('dismissed_update_core'),
		var_dismissed.clone(),
	])).to_bool()
}

fn find_core_update(var_version rt.PhpVal, var_locale rt.PhpVal) bool {
	mut var_from_api := rt.new_null()
	mut var_updates := rt.new_null()
	mut var_update := rt.new_null()
	var_from_api = rt.call_function('get_site_transient', [rt.new_string('update_core')])
	if !(!(rt.get_property(var_from_api, 'updates')).is_null())
		|| !(rt.get_property(var_from_api, 'updates').is_array()) {
		return false
	}
	var_updates = rt.get_property(var_from_api, 'updates')
	mut iter_3 := var_updates.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_update_shadow := item_3.val
		if rt.is_true(rt.identical(rt.get_property(var_update_shadow, 'current'), var_version))
			&& rt.is_true(rt.identical(rt.get_property(var_update_shadow, 'locale'), var_locale)) {
			return var_update_shadow.to_bool()
		}
	}
	return false
}

fn core_update_footer(msg string) rt.PhpVal {
	mut var_msg := msg
	mut var_cur := rt.new_null()
	mut var_is_development_version := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('update_core'),
	])))))
	{
		return rt.call_function('sprintf', [
			rt.call_function('__', [rt.new_string('Version %s')]),
			rt.call_function('get_bloginfo', [rt.new_string('version'),
				rt.new_string('display')]),
		])
	}
	var_cur = get_preferred_from_update_core()
	if !(var_cur.clone().is_object()) {
		var_cur = create_stdclass()
	}
	if !(!(rt.get_property(var_cur, 'current')).is_null()) {
		rt.set_property(var_cur, 'current', rt.new_string(''))
	}
	if !(!(rt.get_property(var_cur, 'response')).is_null()) {
		rt.set_property(var_cur, 'response', rt.new_string(''))
	}
	var_is_development_version = rt.call_function('preg_match', [
		rt.new_string('/alpha|beta|RC/'),
		rt.call_function('wp_get_wp_version', []rt.PhpVal{}),
	])
	if rt.is_true(var_is_development_version) {
		return rt.call_function('sprintf', [
			rt.call_function('__', [
				rt.new_string('You are using a development version (%1$s). Cool! Please <a href="%2$s">stay updated</a>.'),
			]),
			rt.call_function('get_bloginfo', [
				rt.new_string('version'),
				rt.new_string('display'),
			]),
			rt.call_function('network_admin_url', [
				rt.new_string('update-core.php'),
			]),
		])
	}
	mut switch_val_1 := rt.get_property(var_cur, 'response')
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('upgrade'))) {
		return rt.call_function('sprintf', [
			rt.new_string('<strong><a href="%s">%s</a></strong>'),
			rt.call_function('network_admin_url', [rt.new_string('update-core.php')]),
			rt.call_function('sprintf', [rt.call_function('__', [
				rt.new_string('Get Version %s'),
			]),
				rt.get_property(var_cur, 'current')]),
		])
	} else {
		return rt.call_function('sprintf', [
			rt.call_function('__', [rt.new_string('Version %s')]),
			rt.call_function('get_bloginfo', [rt.new_string('version'),
				rt.new_string('display')]),
		])
	}
	return rt.new_null()
}

fn update_nag() bool {
	mut var_pagenow := rt.new_null()
	mut var_cur := rt.new_null()
	mut var_version_url := rt.new_null()
	mut var_msg := rt.new_null()
	if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{}))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('update_core')]))))) {
		return false
	}
	if rt.is_true(rt.identical(rt.new_string('update-core.php'), var_pagenow)) {
		return false
	}
	var_cur = get_preferred_from_update_core()
	if !(!(rt.get_property(var_cur, 'response')).is_null())
		|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('upgrade'), rt.get_property(var_cur, 'response'))))) {
		return false
	}
	var_version_url = rt.call_function('sprintf', [
		rt.call_function('esc_url', [
			rt.call_function('__', [
				rt.new_string('https://wordpress.org/documentation/wordpress-version/version-%s/'),
			]),
		]),
		rt.call_function('sanitize_title', [
			rt.get_property(var_cur, 'current'),
		]),
	])
	if rt.is_true(rt.call_function('current_user_can', [rt.new_string('update_core')])) {
		var_msg = rt.call_function('sprintf', [
			rt.call_function('__', [
				rt.new_string('<a href="%1$s">WordPress %2$s</a> is available! <a href="%3$s" aria-label="%4$s">Please update now</a>.'),
			]),
			var_version_url.clone(),
			rt.get_property(var_cur, 'current'),
			rt.call_function('network_admin_url', [
				rt.new_string('update-core.php'),
			]),
			rt.call_function('esc_attr__', [
				rt.new_string('Please update WordPress now'),
			]),
		])
	} else {
		var_msg = rt.call_function('sprintf', [
			rt.call_function('__', [
				rt.new_string('<a href="%1$s">WordPress %2$s</a> is available! Please notify the site administrator.'),
			]),
			var_version_url.clone(),
			rt.get_property(var_cur, 'current'),
		])
	}
	rt.call_function('wp_admin_notice', [var_msg.clone(),
		rt.create_array([rt.ArrayItem{ key: 'type', val: 'warning' },
			rt.ArrayItem{ key: 'additional_classes', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'update-nag' },
				rt.ArrayItem{ key: none, val: 'inline' },
			]) }, rt.ArrayItem{ key: 'paragraph_wrap', val: false }])])
	return false
}

fn update_right_now_message() {
	mut var_theme_name := rt.new_null()
	mut var_msg := ''
	mut var_cur := rt.new_null()
	mut var_content := rt.new_null()
	var_theme_name = rt.call_function('wp_get_theme', []rt.PhpVal{})
	if rt.is_true(rt.call_function('current_user_can', [rt.new_string('switch_themes')])) {
		var_theme_name = rt.call_function('sprintf', [
			rt.new_string('<a href="themes.php">%1$s</a>'),
			var_theme_name.clone(),
		])
	}
	var_msg = ''
	if rt.is_true(rt.call_function('current_user_can', [rt.new_string('update_core')])) {
		var_cur = get_preferred_from_update_core()
		if !(rt.get_property(var_cur, 'response')).is_null()
			&& rt.is_true(rt.identical(rt.new_string('upgrade'), rt.get_property(var_cur, 'response'))) {
			var_msg = var_msg +(rt.call_function('sprintf', [rt.new_string('<a href="%s" class="button" aria-describedby="wp-version">%s</a> '), rt.call_function('network_admin_url', [rt.new_string('update-core.php')]), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Update to %s')]), if rt.is_true(rt.get_property(var_cur, 'current')) { rt.get_property(var_cur, 'current') } else { rt.call_function('__', [rt.new_string('Latest')]) }])])).str()
		}
	}
	var_content = rt.call_function('__', [
		rt.new_string('WordPress %1$s running %2$s theme.'),
	])
	var_content = rt.call_function('apply_filters', [
		rt.new_string('update_right_now_text'),
		var_content.clone(),
	])
	var_msg = var_msg +
		(rt.call_function('sprintf', [rt.new_string('<span id="wp-version">' + var_content.str() +
		'</span>'), rt.call_function('get_bloginfo', [rt.new_string('version'), rt.new_string('display')]), var_theme_name.clone()])).str()
	print("<p id='wp-version-message'>${var_msg}</p>")
}

fn get_plugin_updates() rt.PhpVal {
	mut var_all_plugins := rt.new_null()
	mut var_upgrade_plugins := rt.new_null()
	mut var_current := rt.new_null()
	mut var_plugin_data := map[string]rt.PhpVal{}
	mut var_plugin_file := rt.new_null()
	var_all_plugins = rt.call_function('get_plugins', []rt.PhpVal{})
	var_upgrade_plugins = rt.new_array()
	var_current = rt.call_function('get_site_transient', [
		rt.new_string('update_plugins'),
	])
	mut iter_4 := rt.cast_array(var_all_plugins).iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_plugin_data_shadow := item_4.val
		mut var_plugin_file_shadow := item_4.key
		if rt.get_property(var_current, 'response').array_isset(var_plugin_file_shadow) {
			var_upgrade_plugins.array_set(var_plugin_file_shadow,
				rt.array_to_object(var_plugin_data_shadow))
			rt.set_property(var_upgrade_plugins.array_get(var_plugin_file_shadow), 'update', rt.get_property(var_current,
				'response').array_get(var_plugin_file_shadow))
		}
	}
	return var_upgrade_plugins.clone()
}

fn wp_plugin_update_rows() {
	mut var_plugins := rt.new_null()
	mut var_plugin_file := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('update_plugins'),
	])))))
	{
		return
	}
	var_plugins = rt.call_function('get_site_transient', [
		rt.new_string('update_plugins'),
	])
	if !(rt.get_property(var_plugins, 'response')).is_null()
		&& rt.get_property(var_plugins, 'response').is_array() {
		var_plugins = rt.func_array_keys(rt.get_property(var_plugins, 'response'))
		mut iter_5 := var_plugins.iterator()
		for {
			item_5 := iter_5.next() or { break }
			mut var_plugin_file_shadow := item_5.val
			rt.call_function('add_action', [
				rt.new_string('after_plugin_row_${var_plugin_file.to_string()}'),
				rt.new_string('wp_plugin_update_row'),
				rt.new_int(10),
				rt.new_int(2),
			])
		}
	}
}

fn wp_plugin_update_row(var_file rt.PhpVal, var_plugin_data rt.PhpVal) bool {
	mut var_current := rt.new_null()
	mut var_response := rt.new_null()
	mut var_plugins_allowedtags := map[string]rt.PhpVal{}
	mut var_plugin_name := rt.new_null()
	mut var_plugin_slug := rt.new_null()
	mut var_details_url := rt.new_null()
	mut var_wp_list_table := rt.new_null()
	mut var_active_class := ''
	mut var_requires_php := rt.new_null()
	mut var_compatible_php := rt.new_null()
	mut var_notice_type := ''
	var_current = rt.call_function('get_site_transient', [
		rt.new_string('update_plugins'),
	])
	if !(rt.get_property(var_current, 'response').array_isset(var_file)) {
		return false
	}
	var_response = rt.get_property(var_current, 'response').array_get(var_file)
	var_plugins_allowedtags = {
		'a':       {
			'href':  rt.new_array()
			'title': rt.new_array()
		}
		'abbr':    {
			'title': rt.new_array()
		}
		'acronym': {
			'title': rt.new_array()
		}
		'code':    rt.new_array()
		'em':      rt.new_array()
		'strong':  rt.new_array()
	}
	var_plugin_name = rt.call_function('wp_kses', [var_plugin_data['Name'],
		rt.create_array_from_native_map(var_plugins_allowedtags)])
	var_plugin_slug = if !(rt.get_property(var_response, 'slug')).is_null() {
		rt.get_property(var_response, 'slug')
	} else {
		rt.get_property(var_response, 'id')
	}
	if !(rt.get_property(var_response, 'slug')).is_null() {
		var_details_url = rt.call_function('self_admin_url', [
			rt.new_string('plugin-install.php?tab=plugin-information&plugin=' +
				var_plugin_slug.str() + '&section=changelog'),
		])
	} else if !(rt.get_property(var_response, 'url')).is_null() {
		var_details_url = rt.get_property(var_response, 'url')
	} else {
		var_details_url = var_plugin_data['PluginURI']
	}
	var_details_url = rt.call_function('add_query_arg', [
		rt.create_array([rt.ArrayItem{ key: 'TB_iframe', val: 'true' },
			rt.ArrayItem{ key: 'width', val: 600 }, rt.ArrayItem{ key: 'height', val: 800 }]),
		var_details_url.clone(),
	])
	var_wp_list_table = rt.call_function('_get_list_table', [
		rt.new_string('WP_Plugins_List_Table'),
		rt.create_array([
			rt.ArrayItem{ key: 'screen', val: rt.call_function('get_current_screen', []rt.PhpVal{}) },
		]),
	])
	if rt.is_true(rt.call_function('is_network_admin', []rt.PhpVal{}))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{}))))) {
		if rt.is_true(rt.call_function('is_network_admin', []rt.PhpVal{})) {
			var_active_class = if rt.is_true(rt.call_function('is_plugin_active_for_network', [
				var_file.clone(),
			]))
			{ ' active' } else { '' }
		} else {
			var_active_class = if rt.is_true(rt.call_function('is_plugin_active', [
				var_file.clone(),
			]))
			{ ' active' } else { '' }
		}
		var_requires_php = if !(rt.get_property(var_response, 'requires_php')).is_null() {
			rt.get_property(var_response, 'requires_php')
		} else {
			rt.new_null()
		}
		var_compatible_php = rt.call_function('is_php_version_compatible', [
			var_requires_php.clone()])
		var_notice_type = if rt.is_true(var_compatible_php) {
			'notice-warning'
		} else {
			'notice-error'
		}
		rt.call_function('printf', [
			rt.new_string(
				'<tr class="plugin-update-tr%s" id="%s" data-slug="%s" data-plugin="%s">' +
				'<td colspan="%s" class="plugin-update colspanchange">' +
				'<div class="update-message notice inline %s notice-alt"><p>'),
			rt.new_string(var_active_class.str()).clone(),
			rt.call_function('esc_attr', [
				rt.new_string(var_plugin_slug.str() + '-update'),
			]),
			rt.call_function('esc_attr', [
				var_plugin_slug.clone(),
			]),
			rt.call_function('esc_attr', [
				var_file.clone(),
			]),
			rt.call_function('esc_attr', [
				rt.call_method(var_wp_list_table, 'get_column_count', []rt.PhpVal{}),
			]),
			rt.new_string(var_notice_type.str()).clone(),
		])
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
			rt.new_string('update_plugins'),
		])))))
		{
			rt.call_function('printf', [
				rt.call_function('__', [
					rt.new_string('There is a new version of %1$s available. <a href="%2$s" %3$s>View version %4$s details</a>.'),
				]),
				var_plugin_name.clone(),
				rt.call_function('esc_url', [
					var_details_url.clone(),
				]),
				rt.call_function('sprintf', [
					rt.new_string('class="thickbox open-plugin-details-modal" aria-label="%s"'),
					rt.call_function('esc_attr', [
						rt.call_function('sprintf', [
							rt.call_function('__', [
								rt.new_string('View %1$s version %2$s details'),
							]),
							var_plugin_name.clone(),
							rt.get_property(var_response, 'new_version'),
						]),
					]),
				]),
				rt.call_function('esc_attr', [
					rt.get_property(var_response, 'new_version'),
				]),
			])
		} else if !rt.is_true(rt.get_property(var_response, 'package')) {
			rt.call_function('printf', [
				rt.call_function('__', [
					rt.new_string('There is a new version of %1$s available. <a href="%2$s" %3$s>View version %4$s details</a>. <em>Automatic update is unavailable for this plugin.</em>'),
				]),
				var_plugin_name.clone(),
				rt.call_function('esc_url', [
					var_details_url.clone(),
				]),
				rt.call_function('sprintf', [
					rt.new_string('class="thickbox open-plugin-details-modal" aria-label="%s"'),
					rt.call_function('esc_attr', [
						rt.call_function('sprintf', [
							rt.call_function('__', [
								rt.new_string('View %1$s version %2$s details'),
							]),
							var_plugin_name.clone(),
							rt.get_property(var_response, 'new_version'),
						]),
					]),
				]),
				rt.call_function('esc_attr', [
					rt.get_property(var_response, 'new_version'),
				]),
			])
		} else {
			if rt.is_true(var_compatible_php) {
				rt.call_function('printf', [
					rt.call_function('__', [
						rt.new_string('There is a new version of %1$s available. <a href="%2$s" %3$s>View version %4$s details</a> or <a href="%5$s" %6$s>update now</a>.'),
					]),
					var_plugin_name.clone(),
					rt.call_function('esc_url', [
						var_details_url.clone(),
					]),
					rt.call_function('sprintf', [
						rt.new_string('class="thickbox open-plugin-details-modal" aria-label="%s"'),
						rt.call_function('esc_attr', [
							rt.call_function('sprintf', [
								rt.call_function('__', [
									rt.new_string('View %1$s version %2$s details'),
								]),
								var_plugin_name.clone(),
								rt.get_property(var_response, 'new_version'),
							]),
						]),
					]),
					rt.call_function('esc_attr', [
						rt.get_property(var_response, 'new_version'),
					]),
					rt.call_function('wp_nonce_url', [
						rt.new_string(
							(rt.call_function('self_admin_url', [rt.new_string('update.php?action=upgrade-plugin&plugin=')])).str() +
							var_file.str()),
						rt.new_string('upgrade-plugin_' + var_file.str()),
					]),
					rt.call_function('sprintf', [
						rt.new_string('class="update-link" aria-label="%s"'),
						rt.call_function('esc_attr', [
							rt.call_function('sprintf', [
								rt.call_function('_x', [
									rt.new_string('Update %s now'),
									rt.new_string('plugin'),
								]),
								var_plugin_name.clone(),
							]),
						]),
					]),
				])
			} else {
				rt.call_function('printf', [
					rt.call_function('__', [
						rt.new_string('There is a new version of %1$s available, but it does not work with your version of PHP. <a href="%2$s" %3$s>View version %4$s details</a> or <a href="%5$s">learn more about updating PHP</a>.'),
					]),
					var_plugin_name.clone(),
					rt.call_function('esc_url', [
						var_details_url.clone(),
					]),
					rt.call_function('sprintf', [
						rt.new_string('class="thickbox open-plugin-details-modal" aria-label="%s"'),
						rt.call_function('esc_attr', [
							rt.call_function('sprintf', [
								rt.call_function('__', [
									rt.new_string('View %1$s version %2$s details'),
								]),
								var_plugin_name.clone(),
								rt.get_property(var_response, 'new_version'),
							]),
						]),
					]),
					rt.call_function('esc_attr', [
						rt.get_property(var_response, 'new_version'),
					]),
					rt.call_function('esc_url', [
						rt.call_function('wp_get_update_php_url', []rt.PhpVal{}),
					]),
				])
				rt.call_function('wp_update_php_annotation', [
					rt.new_string('<br><em>'), rt.new_string('</em>')])
			}
		}
		rt.call_function('do_action', [
			rt.new_string('in_plugin_update_message-${var_file.to_string()}'),
			rt.create_array_from_native_map(var_plugin_data),
			var_response.clone(),
		])
		print('</p></div></td></tr>')
	}
	return false
}

fn get_theme_updates() rt.PhpVal {
	mut var_current := rt.new_null()
	mut var_update_themes := rt.new_null()
	mut var_data := rt.new_null()
	mut var_stylesheet := rt.new_null()
	var_current = rt.call_function('get_site_transient', [rt.new_string('update_themes')])
	if !(!(rt.get_property(var_current, 'response')).is_null()) {
		return rt.new_array()
	}
	var_update_themes = rt.new_array()
	mut iter_6 := rt.get_property(var_current, 'response').iterator()
	for {
		item_6 := iter_6.next() or { break }
		mut var_data_shadow := item_6.val
		mut var_stylesheet_shadow := item_6.key
		var_update_themes.array_set(var_stylesheet_shadow, rt.call_function('wp_get_theme', [
			var_stylesheet_shadow.clone(),
		]))
		rt.set_property(var_update_themes.array_get(var_stylesheet_shadow), 'update',
			var_data_shadow.clone())
	}
	return var_update_themes.clone()
}

fn wp_theme_update_rows() {
	mut var_themes := rt.new_null()
	mut var_theme := map[string]rt.PhpVal{}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('update_themes'),
	])))))
	{
		return
	}
	var_themes = rt.call_function('get_site_transient', [rt.new_string('update_themes')])
	if !(rt.get_property(var_themes, 'response')).is_null()
		&& rt.get_property(var_themes, 'response').is_array() {
		var_themes = rt.func_array_keys(rt.get_property(var_themes, 'response'))
		mut iter_7 := var_themes.iterator()
		for {
			item_7 := iter_7.next() or { break }
			mut var_theme_shadow := item_7.val
			rt.call_function('add_action', [
				rt.new_string('after_theme_row_${var_theme.to_string()}'),
				rt.new_string('wp_theme_update_row'),
				rt.new_int(10),
				rt.new_int(2),
			])
		}
	}
}

fn wp_theme_update_row(var_theme_key rt.PhpVal, var_theme rt.PhpVal) bool {
	mut var_current := rt.new_null()
	mut var_response := rt.new_null()
	mut var_details_url := rt.new_null()
	mut var_wp_list_table := rt.new_null()
	mut var_active := ''
	mut var_requires_wp := rt.new_null()
	mut var_requires_php := rt.new_null()
	mut var_compatible_wp := rt.new_null()
	mut var_compatible_php := rt.new_null()
	var_current = rt.call_function('get_site_transient', [rt.new_string('update_themes')])
	if !(rt.get_property(var_current, 'response').array_isset(var_theme_key)) {
		return false
	}
	var_response = rt.get_property(var_current, 'response').array_get(var_theme_key)
	var_details_url = rt.call_function('add_query_arg', [
		rt.create_array([rt.ArrayItem{ key: 'TB_iframe', val: 'true' },
			rt.ArrayItem{ key: 'width', val: 1024 }, rt.ArrayItem{ key: 'height', val: 800 }]),
		rt.get_property(var_current, 'response').array_get(var_theme_key).array_get(rt.new_string('url')),
	])
	var_wp_list_table = rt.call_function('_get_list_table', [
		rt.new_string('WP_MS_Themes_List_Table'),
	])
	var_active = if rt.is_true(rt.call_method(var_theme, 'is_allowed', [
		rt.new_string('network'),
	]))
	{ ' active' } else { '' }
	var_requires_wp = if !(var_response.array_get(rt.new_string('requires'))).is_null() {
		var_response.array_get(rt.new_string('requires'))
	} else {
		rt.new_null()
	}
	var_requires_php = if !(var_response.array_get(rt.new_string('requires_php'))).is_null() {
		var_response.array_get(rt.new_string('requires_php'))
	} else {
		rt.new_null()
	}
	var_compatible_wp = rt.call_function('is_wp_version_compatible', [
		var_requires_wp.clone()])
	var_compatible_php = rt.call_function('is_php_version_compatible', [
		var_requires_php.clone()])
	rt.call_function('printf', [
		rt.new_string('<tr class="plugin-update-tr%s" id="%s" data-slug="%s">' +
			'<td colspan="%s" class="plugin-update colspanchange">' +
			'<div class="update-message notice inline notice-warning notice-alt"><p>'),
		rt.new_string(var_active.str()).clone(),
		rt.call_function('esc_attr', [
			rt.new_string((rt.call_method(var_theme, 'get_stylesheet', []rt.PhpVal{})).str() +
				'-update'),
		]),
		rt.call_function('esc_attr', [
			rt.call_method(var_theme, 'get_stylesheet', []rt.PhpVal{}),
		]),
		rt.call_method(var_wp_list_table, 'get_column_count', []rt.PhpVal{}),
	])
	if rt.is_true(var_compatible_wp) && rt.is_true(var_compatible_php) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
			rt.new_string('update_themes'),
		])))))
		{
			rt.call_function('printf', [
				rt.call_function('__', [
					rt.new_string('There is a new version of %1$s available. <a href="%2$s" %3$s>View version %4$s details</a>.'),
				]),
				var_theme['Name'],
				rt.call_function('esc_url', [
					var_details_url.clone(),
				]),
				rt.call_function('sprintf', [
					rt.new_string('class="thickbox open-plugin-details-modal" aria-label="%s"'),
					rt.call_function('esc_attr', [
						rt.call_function('sprintf', [
							rt.call_function('__', [
								rt.new_string('View %1$s version %2$s details'),
							]),
							var_theme['Name'],
							var_response.array_get(rt.new_string('new_version')),
						]),
					]),
				]),
				var_response.array_get(rt.new_string('new_version')),
			])
		} else if !rt.is_true(var_response.array_get(rt.new_string('package'))) {
			rt.call_function('printf', [
				rt.call_function('__', [
					rt.new_string('There is a new version of %1$s available. <a href="%2$s" %3$s>View version %4$s details</a>. <em>Automatic update is unavailable for this theme.</em>'),
				]),
				var_theme['Name'],
				rt.call_function('esc_url', [
					var_details_url.clone(),
				]),
				rt.call_function('sprintf', [
					rt.new_string('class="thickbox open-plugin-details-modal" aria-label="%s"'),
					rt.call_function('esc_attr', [
						rt.call_function('sprintf', [
							rt.call_function('__', [
								rt.new_string('View %1$s version %2$s details'),
							]),
							var_theme['Name'],
							var_response.array_get(rt.new_string('new_version')),
						]),
					]),
				]),
				var_response.array_get(rt.new_string('new_version')),
			])
		} else {
			rt.call_function('printf', [
				rt.call_function('__', [
					rt.new_string('There is a new version of %1$s available. <a href="%2$s" %3$s>View version %4$s details</a> or <a href="%5$s" %6$s>update now</a>.'),
				]),
				var_theme['Name'],
				rt.call_function('esc_url', [
					var_details_url.clone(),
				]),
				rt.call_function('sprintf', [
					rt.new_string('class="thickbox open-plugin-details-modal" aria-label="%s"'),
					rt.call_function('esc_attr', [
						rt.call_function('sprintf', [
							rt.call_function('__', [
								rt.new_string('View %1$s version %2$s details'),
							]),
							var_theme['Name'],
							var_response.array_get(rt.new_string('new_version')),
						]),
					]),
				]),
				var_response.array_get(rt.new_string('new_version')),
				rt.call_function('wp_nonce_url', [
					rt.new_string(
						(rt.call_function('self_admin_url', [rt.new_string('update.php?action=upgrade-theme&theme=')])).str() +
						var_theme_key.str()),
					rt.new_string('upgrade-theme_' + var_theme_key.str()),
				]),
				rt.call_function('sprintf', [
					rt.new_string('class="update-link" aria-label="%s"'),
					rt.call_function('esc_attr', [
						rt.call_function('sprintf', [
							rt.call_function('_x', [
								rt.new_string('Update %s now'),
								rt.new_string('theme'),
							]),
							var_theme['Name'],
						]),
					]),
				]),
			])
		}
	} else {
		if rt.is_true(rt.new_bool(!(rt.is_true(var_compatible_wp))))
			&& rt.is_true(rt.new_bool(!(rt.is_true(var_compatible_php)))) {
			rt.call_function('printf', [
				rt.call_function('__', [
					rt.new_string('There is a new version of %s available, but it does not work with your versions of WordPress and PHP.'),
				]),
				var_theme['Name'],
			])
			if rt.is_true(rt.call_function('current_user_can', [rt.new_string('update_core')]))
				&& rt.is_true(rt.call_function('current_user_can', [rt.new_string('update_php')])) {
				rt.call_function('printf', [
					rt.new_string(' ' +(rt.call_function('__', [rt.new_string('<a href="%1$s">Please update WordPress</a>, and then <a href="%2$s">learn more about updating PHP</a>.')])).str()),
					rt.call_function('self_admin_url', [
						rt.new_string('update-core.php'),
					]),
					rt.call_function('esc_url', [
						rt.call_function('wp_get_update_php_url', []rt.PhpVal{}),
					]),
				])
				rt.call_function('wp_update_php_annotation', [
					rt.new_string('</p><p><em>'),
					rt.new_string('</em>'),
				])
			} else if rt.is_true(rt.call_function('current_user_can', [
				rt.new_string('update_core'),
			]))
			{
				rt.call_function('printf', [
					rt.new_string(' ' +(rt.call_function('__', [rt.new_string('<a href="%s">Please update WordPress</a>.')])).str()),
					rt.call_function('self_admin_url', [
						rt.new_string('update-core.php'),
					]),
				])
			} else if rt.is_true(rt.call_function('current_user_can', [
				rt.new_string('update_php'),
			]))
			{
				rt.call_function('printf', [
					rt.new_string(' ' +(rt.call_function('__', [rt.new_string('<a href="%s">Learn more about updating PHP</a>.')])).str()),
					rt.call_function('esc_url', [
						rt.call_function('wp_get_update_php_url', []rt.PhpVal{}),
					]),
				])
				rt.call_function('wp_update_php_annotation', [
					rt.new_string('</p><p><em>'),
					rt.new_string('</em>'),
				])
			}
		} else if rt.is_true(rt.new_bool(!(rt.is_true(var_compatible_wp)))) {
			rt.call_function('printf', [
				rt.call_function('__', [
					rt.new_string('There is a new version of %s available, but it does not work with your version of WordPress.'),
				]),
				var_theme['Name'],
			])
			if rt.is_true(rt.call_function('current_user_can', [
				rt.new_string('update_core'),
			]))
			{
				rt.call_function('printf', [
					rt.new_string(' ' +(rt.call_function('__', [rt.new_string('<a href="%s">Please update WordPress</a>.')])).str()),
					rt.call_function('self_admin_url', [
						rt.new_string('update-core.php'),
					]),
				])
			}
		} else if rt.is_true(rt.new_bool(!(rt.is_true(var_compatible_php)))) {
			rt.call_function('printf', [
				rt.call_function('__', [
					rt.new_string('There is a new version of %s available, but it does not work with your version of PHP.'),
				]),
				var_theme['Name'],
			])
			if rt.is_true(rt.call_function('current_user_can', [
				rt.new_string('update_php'),
			]))
			{
				rt.call_function('printf', [
					rt.new_string(' ' +(rt.call_function('__', [rt.new_string('<a href="%s">Learn more about updating PHP</a>.')])).str()),
					rt.call_function('esc_url', [
						rt.call_function('wp_get_update_php_url', []rt.PhpVal{}),
					]),
				])
				rt.call_function('wp_update_php_annotation', [
					rt.new_string('</p><p><em>'),
					rt.new_string('</em>'),
				])
			}
		}
	}
	rt.call_function('do_action', [
		rt.new_string('in_theme_update_message-${var_theme_key.to_string()}'),
		rt.create_array_from_native_map(var_theme),
		var_response.clone(),
	])
	print('</p></div></td></tr>')
	return false
}

fn maintenance_nag() bool {
	mut var_upgrading := rt.new_null()
	mut var_nag := rt.new_null()
	mut var_failed := rt.new_null()
	mut var_comparison := ''
	mut var_msg := rt.new_null()
	var_nag = rt.new_bool(!var_upgrading.is_null())
	if rt.is_true(rt.new_bool(!(rt.is_true(var_nag)))) {
		var_failed = rt.call_function('get_site_option', [
			rt.new_string('auto_core_update_failed'),
		])
		var_comparison = if !(!rt.is_true(var_failed.array_get(rt.new_string('critical')))) {
			'>='
		} else {
			'>'
		}
		if var_failed.array_isset(rt.new_string('attempted'))
			&& rt.is_true(rt.call_function('version_compare', [var_failed.array_get(rt.new_string('attempted')), rt.call_function('wp_get_wp_version', []rt.PhpVal{}), rt.new_string(var_comparison.str()).clone()])) {
			var_nag = rt.new_bool(true)
		}
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_nag)))) {
		return false
	}
	if rt.is_true(rt.call_function('current_user_can', [rt.new_string('update_core')])) {
		var_msg = rt.call_function('sprintf', [
			rt.call_function('__', [
				rt.new_string('An automated WordPress update has failed to complete - <a href="%s">please attempt the update again now</a>.'),
			]),
			rt.new_string('update-core.php'),
		])
	} else {
		var_msg = rt.call_function('__', [
			rt.new_string('An automated WordPress update has failed to complete! Please notify the site administrator.'),
		])
	}
	rt.call_function('wp_admin_notice', [var_msg.clone(),
		rt.create_array([rt.ArrayItem{ key: 'type', val: 'warning' },
			rt.ArrayItem{ key: 'additional_classes', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'update-nag' },
				rt.ArrayItem{ key: none, val: 'inline' },
			]) }, rt.ArrayItem{ key: 'paragraph_wrap', val: false }])])
	return false
}

fn wp_print_admin_notice_templates() {
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Show more details')])
	// unsupported statement: Stmt_InlineHTML
}

fn wp_print_update_row_templates() {
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('printf', [
		rt.call_function('_x', [rt.new_string('%s was successfully deleted.'),
			rt.new_string('plugin')]),
		rt.new_string('<strong>{{{ data.name }}}</strong>'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('printf', [
		rt.call_function('_x', [rt.new_string('%s was successfully deleted.'),
			rt.new_string('theme')]),
		rt.new_string('<strong>{{{ data.name }}}</strong>'),
	])
	// unsupported statement: Stmt_InlineHTML
}

fn wp_recovery_mode_nag() {
	mut var_url := rt.new_null()
	mut var_message := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_is_recovery_mode', []rt.PhpVal{}))))) {
		return
	}
	var_url = rt.call_function('wp_login_url', []rt.PhpVal{})
	var_url = rt.call_function('add_query_arg', [rt.new_string('action'),
		Class_WP_Recovery_Mode.exit_action(), var_url.clone()])
	var_url = rt.call_function('wp_nonce_url', [var_url.clone(),
		Class_WP_Recovery_Mode.exit_action()])
	var_message = rt.call_function('sprintf', [
		rt.call_function('__', [
			rt.new_string('You are in recovery mode. This means there may be an error with a theme or plugin. To exit recovery mode, log out or use the Exit button. <a href="%s">Exit Recovery Mode</a>'),
		]),
		rt.call_function('esc_url', [
			var_url.clone(),
		]),
	])
	rt.call_function('wp_admin_notice', [var_message.clone(),
		rt.create_array([rt.ArrayItem{ key: 'type', val: 'info' }])])
}

fn wp_is_auto_update_enabled_for_type(var_type rt.PhpVal) bool {
	mut var_updater := rt.new_null()
	mut var_enabled := false
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [
		rt.new_string('WP_Automatic_Updater'),
	])))))
	{
		rt.include_file(
			(rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/class-wp-automatic-updater.php',
			'4')
	}
	var_updater = create_wp_automatic_updater()
	var_enabled = !(rt.is_true(var_updater.is_disabled()))
	mut switch_val_2 := var_type
	if rt.is_true(rt.equal(switch_val_2, rt.new_string('plugin'))) {
		return (rt.call_function('apply_filters', [
			rt.new_string('plugins_auto_update_enabled'),
			rt.new_bool(var_enabled).clone(),
		])).to_bool()
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('theme'))) {
		return (rt.call_function('apply_filters', [
			rt.new_string('themes_auto_update_enabled'),
			rt.new_bool(var_enabled).clone(),
		])).to_bool()
	}
	return false
}

fn wp_is_auto_update_forced_for_item(var_type rt.PhpVal, var_update rt.PhpVal, var_item rt.PhpVal) rt.PhpVal {
	return rt.call_function('apply_filters', [
		rt.new_string('auto_update_${var_type.to_string()}'),
		var_update.clone(),
		var_item.clone(),
	])
}

fn wp_get_auto_update_message() rt.PhpVal {
	mut var_next_update_time := rt.new_null()
	mut var_message := rt.new_null()
	mut var_time_to_next_update := rt.new_null()
	mut var_overdue := false
	var_next_update_time = rt.call_function('wp_next_scheduled', [
		rt.new_string('wp_version_check'),
	])
	if rt.is_true(rt.identical(rt.new_bool(false), var_next_update_time)) {
		var_message = rt.call_function('__', [
			rt.new_string('Automatic update not scheduled. There may be a problem with WP-Cron.'),
		])
	} else {
		var_time_to_next_update = rt.call_function('human_time_diff', [
			rt.new_int(var_next_update_time.to_i64()),
		])
		var_overdue = (rt.greater(rt.sub(rt.call_function('time', []rt.PhpVal{}),
			var_next_update_time), rt.new_int(0))).to_bool()
		if var_overdue {
			var_message = rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('Automatic update overdue by %s. There may be a problem with WP-Cron.'),
				]),
				var_time_to_next_update.clone(),
			])
		} else {
			var_message = rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('Automatic update scheduled in %s.'),
				]),
				var_time_to_next_update.clone(),
			])
		}
	}
	return var_message.clone()
}

struct Class_WP_Automatic_Updater {
	rt.PhpObjectBase
}

struct Class_stdClass {
	rt.PhpObjectBase
}

fn create_wp_automatic_updater(_args ...rt.PhpVal) &Class_WP_Automatic_Updater {
	mut obj := &Class_WP_Automatic_Updater{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_stdclass(_args ...rt.PhpVal) &Class_stdClass {
	mut obj := &Class_stdClass{
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

fn (mut this Class_stdClass) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_stdClass) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_stdClass) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
