import rt
import crypto.md5

fn plugins_api(action string, var_args_arg rt.PhpVal) rt.PhpVal {
	mut var_action := action
	mut var_args := var_args_arg
	mut var_res := rt.new_null()
	mut var_url := rt.new_null()
	mut var_http_url := rt.new_null()
	mut var_ssl := rt.new_null()
	mut var_http_args := map[string]rt.PhpVal{}
	mut var_request := rt.new_null()
	if rt.is_true(rt.new_bool(var_args.clone().is_array())) {
		var_args = rt.array_to_object(var_args)
	}
	if rt.is_true(rt.identical(rt.new_string('query_plugins'), rt.new_string(action))) {
		if !(!(rt.get_property(var_args, 'per_page')).is_null()) {
			rt.set_property(var_args, 'per_page', rt.new_int(24))
		}
	}
	if !(!(rt.get_property(var_args, 'locale')).is_null()) {
		rt.set_property(var_args, 'locale', rt.call_function('get_user_locale', []rt.PhpVal{}))
	}
	if !(!(rt.get_property(var_args, 'wp_version')).is_null()) {
		rt.set_property(var_args, 'wp_version', rt.call_function('substr', [
			rt.call_function('wp_get_wp_version', []rt.PhpVal{}),
			rt.new_int(0),
			rt.new_int(3),
		]))
	}
	var_args = rt.call_function('apply_filters', [rt.new_string('plugins_api_args'),
		var_args.clone(), rt.new_string(action)])
	var_res = rt.call_function('apply_filters', [rt.new_string('plugins_api'),
		rt.new_bool(false), rt.new_string(action), var_args.clone()])
	if rt.is_true(rt.identical(rt.new_bool(false), var_res)) {
		var_url = rt.new_string('http://api.wordpress.org/plugins/info/1.2/')
		var_url = rt.call_function('add_query_arg', [
			rt.create_array([rt.ArrayItem{ key: 'action', val: action },
				rt.ArrayItem{ key: 'request', val: var_args }]),
			var_url.clone(),
		])
		var_http_url = var_url.clone()
		var_ssl = rt.call_function('wp_http_supports', [
			rt.create_array([rt.ArrayItem{ key: none, val: 'ssl' }]),
		])
		if rt.is_true(var_ssl) {
			var_url = rt.call_function('set_url_scheme', [var_url.clone(),
				rt.new_string('https')])
		}
		var_http_args = {
			'timeout':    rt.new_int(15)
			'user-agent': 'WordPress/' +
				(rt.call_function('wp_get_wp_version', []rt.PhpVal{})).str() + '; ' +
				(rt.call_function('home_url', [rt.new_string('/')])).str()
		}
		var_request = rt.call_function('wp_remote_get', [var_url.clone(),
			rt.create_array_from_native_map(var_http_args)])
		if rt.is_true(var_ssl) && rt.is_true(rt.call_function('is_wp_error', [var_request.clone()])) {
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_is_json_request',
				[]rt.PhpVal{})))))
			{
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
			}
			var_request = rt.call_function('wp_remote_get', [
				var_http_url.clone(), rt.create_array_from_native_map(var_http_args)])
		}
		if rt.is_true(rt.call_function('is_wp_error', [var_request.clone()])) {
			var_res = create_wp_error(rt.new_string('plugins_api_failed'), rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('An unexpected error occurred. Something may be wrong with WordPress.org or this server&#8217;s configuration. If you continue to have problems, please try the <a href="%s">support forums</a>.'),
				]),
				rt.call_function('__', [
					rt.new_string('https://wordpress.org/support/forums/'),
				]),
			]), rt.call_method(var_request, 'get_error_message', []rt.PhpVal{}))
		} else {
			var_res = rt.call_function('json_decode', [
				rt.call_function('wp_remote_retrieve_body', [
					var_request.clone()]),
				rt.new_bool(true),
			])
			if rt.is_true(rt.new_bool(var_res.clone().is_array())) {
				var_res = rt.array_to_object(var_res)
			} else if rt.is_true(rt.identical(rt.new_null(), var_res)) {
				var_res = create_wp_error(rt.new_string('plugins_api_failed'), rt.call_function('sprintf', [
					rt.call_function('__', [
						rt.new_string('An unexpected error occurred. Something may be wrong with WordPress.org or this server&#8217;s configuration. If you continue to have problems, please try the <a href="%s">support forums</a>.'),
					]),
					rt.call_function('__', [
						rt.new_string('https://wordpress.org/support/forums/'),
					]),
				]), rt.call_function('wp_remote_retrieve_body', [
					var_request.clone()]))
			}
			if !(rt.get_property(var_res, 'error')).is_null() {
				var_res = create_wp_error(rt.new_string('plugins_api_failed'), rt.get_property(var_res,
					'error'))
			}
		}
	} else if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [
		var_res.clone(),
	])))))
	{
		rt.set_property(var_res, 'external', rt.new_bool(true))
	}
	return rt.call_function('apply_filters', [rt.new_string('plugins_api_result'),
		var_res.clone(), rt.new_string(action), var_args.clone()])
}

fn install_popular_tags(var_args rt.PhpVal) rt.PhpVal {
	mut var_key := ''
	mut var_tags := rt.new_null()
	var_key = md5.hexhash(rt.call_function('serialize', [var_args.clone()]).to_string())
	var_tags = rt.call_function('get_site_transient', [
		rt.new_string('poptags_' + var_key),
	])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_tags)))) {
		return var_tags.clone()
	}
	var_tags = plugins_api('hot_tags', var_args.clone())
	if rt.is_true(rt.call_function('is_wp_error', [var_tags.clone()])) {
		return var_tags.clone()
	}
	rt.call_function('set_site_transient', [rt.new_string('poptags_' + var_key),
		var_tags.clone(), rt.mul(rt.new_int(3), rt.get_constant('HOUR_IN_SECONDS'))])
	return var_tags.clone()
}

fn install_dashboard() {
	mut var_api_tags := rt.new_null()
	mut var_tags := rt.new_null()
	mut var_tag := map[string]rt.PhpVal{}
	mut var_url := rt.new_null()
	mut var_data := rt.new_null()
	display_plugins_table()
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Popular tags')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [
		rt.new_string('You may also browse based on the most popular tags in the Plugin Directory:'),
	])
	// unsupported statement: Stmt_InlineHTML
	var_api_tags = install_popular_tags(rt.new_null())
	print('<p class="popular-tags">')
	if rt.is_true(rt.call_function('is_wp_error', [var_api_tags.clone()])) {
		rt.echo_val(rt.call_method(var_api_tags, 'get_error_message', []rt.PhpVal{}))
	} else {
		var_tags = rt.new_array()
		mut iter_1 := rt.cast_array(var_api_tags).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_tag_shadow := item_1.val
			var_url = rt.call_function('self_admin_url', [
				rt.new_string('plugin-install.php?tab=search&type=tag&s=' +
					(rt.call_function('urlencode', [var_tag_shadow['name']])).str()),
			])
			var_data = rt.create_array([
				rt.ArrayItem{ key: 'link', val: rt.call_function('esc_url', [
					var_url.clone()]) },
				rt.ArrayItem{ key: 'name', val: var_tag_shadow['name'] },
				rt.ArrayItem{ key: 'slug', val: var_tag_shadow['slug'] },
				rt.ArrayItem{ key: 'id', val: rt.call_function('sanitize_title_with_dashes', [
					var_tag_shadow['name']]) },
				rt.ArrayItem{ key: 'count', val: var_tag_shadow['count'] },
			])
			var_tags.array_set(var_tag_shadow['name'], rt.array_to_object(var_data))
		}
		rt.echo_val(rt.call_function('wp_generate_tag_cloud', [
			var_tags.clone(),
			rt.create_array([
				rt.ArrayItem{ key: 'single_text', val: rt.call_function('__', [
					rt.new_string('%s plugin'),
				]) },
				rt.ArrayItem{ key: 'multiple_text', val: rt.call_function('__', [
					rt.new_string('%s plugins'),
				]) },
			])]))
	}
	print('</p><br class="clear" /></div>')
}

fn install_search_form(deprecated bool) {
	mut var_deprecated := deprecated
	mut var_type := rt.new_null()
	mut var_term := rt.new_null()
	var_type = if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('type')) { rt.call_function('wp_unslash', [
			rt.get_superglobal('_REQUEST').array_get(rt.new_string('type')),
		]) } else { rt.new_string('term') }
	var_term = if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('s')) { rt.call_function('urldecode', [
			rt.call_function('wp_unslash', [rt.get_superglobal('_REQUEST').array_get(rt.new_string('s'))]),
		]) } else { rt.new_string('') }
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Search Plugins')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_term.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Search plugins by:')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('selected', [rt.new_string('term'), var_type.clone()])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Keyword')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('selected', [rt.new_string('author'), var_type.clone()])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Author')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('selected', [rt.new_string('tag'), var_type.clone()])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_ex', [rt.new_string('Tag'), rt.new_string('Plugin Installer')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('submit_button', [
		rt.call_function('__', [rt.new_string('Search Plugins')]),
		rt.new_string('hide-if-js'),
		rt.new_bool(false),
		rt.new_bool(false),
		rt.create_array([rt.ArrayItem{ key: 'id', val: 'search-submit' }]),
	])
	// unsupported statement: Stmt_InlineHTML
}

fn install_plugins_upload() {
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [
		rt.new_string('If you have a plugin in a .zip format, you may install or update it by uploading it here.'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [
		rt.call_function('self_admin_url', [
			rt.new_string('update.php?action=upload-plugin'),
		]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('wp_nonce_field', [rt.new_string('plugin-upload')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Plugin zip file')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('submit_button', [
		rt.call_function('_x', [rt.new_string('Install Now'),
			rt.new_string('plugin')]),
		rt.new_string(''),
		rt.new_string('install-plugin-submit'),
		rt.new_bool(false),
	])
	// unsupported statement: Stmt_InlineHTML
}

fn install_plugins_favorites_form() {
	mut var_user := rt.new_null()
	mut var_action := rt.new_null()
	var_user = rt.call_function('get_user_option', [rt.new_string('wporg_favorites')])
	var_action = rt.new_string('save_wporg_username_' +
		(rt.call_function('get_current_user_id', []rt.PhpVal{})).str())
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [
		rt.new_string('If you have marked plugins as favorites on WordPress.org, you can browse them here.'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Your WordPress.org username:')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_user.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('Get Favorites')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [
		rt.call_function('wp_create_nonce', [var_action.clone()]),
	]))
	// unsupported statement: Stmt_InlineHTML
}

fn display_plugins_table() {
	mut var_wp_list_table := rt.new_null()
	mut switch_val_1 := rt.call_function('current_filter', []rt.PhpVal{})
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('install_plugins_beta'))) {
		rt.call_function('printf', [
			rt.new_string('<p>' +
				(rt.call_function('__', [rt.new_string('You are using a development version of WordPress. These feature plugins are also under development. <a href="%s">Learn more</a>.')])).str() +
				'</p>'),
			rt.new_string('https://make.wordpress.org/core/handbook/about/release-cycle/features-as-plugins/'),
		])
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('install_plugins_featured'))) {
		print('<br>')
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('install_plugins_recommended'))) {
		print('<p>' +
			(rt.call_function('__', [rt.new_string('These suggestions are based on the plugins you and other users have installed.')])).str() +
			'</p>')
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('install_plugins_favorites'))) {
		if !rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('user')))
			&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('get_user_option', [rt.new_string('wporg_favorites')]))))) {
			return
		}
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_method(var_wp_list_table, 'display', []rt.PhpVal{})
	// unsupported statement: Stmt_InlineHTML
}

fn install_plugin_install_status(var_api_arg rt.PhpVal, loop bool) rt.PhpVal {
	mut var_loop := loop
	mut var_api := var_api_arg
	mut var_status := ''
	mut var_url := rt.new_null()
	mut var_update_file := rt.new_null()
	mut var_version := rt.new_null()
	mut var_update_plugins := rt.new_null()
	mut var_plugin := rt.new_null()
	mut var_file := rt.new_null()
	mut var_installed_plugin := rt.new_null()
	mut var_key := rt.new_null()
	if rt.is_true(rt.new_bool(var_api.clone().is_array())) {
		var_api = rt.array_to_object(var_api)
	}
	var_status = 'install'
	var_url = rt.new_bool(false)
	var_update_file = rt.new_bool(false)
	var_version = rt.new_string('')
	var_update_plugins = rt.call_function('get_site_transient', [
		rt.new_string('update_plugins'),
	])
	if !(rt.get_property(var_update_plugins, 'response')).is_null() {
		mut iter_2 := rt.cast_array(rt.get_property(var_update_plugins, 'response')).iterator()
		for {
			item_2 := iter_2.next() or { break }
			mut var_plugin_shadow := item_2.val
			mut var_file_shadow := item_2.key
			if rt.is_true(rt.identical(rt.get_property(var_plugin_shadow, 'slug'), rt.get_property(var_api,
				'slug')))
			{
				var_status = 'update_available'
				var_update_file = var_file_shadow.clone()
				var_version = rt.get_property(var_plugin_shadow, 'new_version')
				if rt.is_true(rt.call_function('current_user_can', [
					rt.new_string('update_plugins'),
				]))
				{
					var_url = rt.call_function('wp_nonce_url', [
						rt.call_function('self_admin_url', [
							rt.new_string('update.php?action=upgrade-plugin&plugin=' +
								var_update_file.str()),
						]),
						rt.new_string('upgrade-plugin_' + var_update_file.str()),
					])
				}
				break
			}
		}
	}
	if rt.is_true(rt.identical(rt.new_string('install'), rt.new_string(var_status.str()))) {
		if rt.is_true(rt.call_function('is_dir', [
			rt.new_string((rt.get_constant('WP_PLUGIN_DIR')).str() + '/' +
				(rt.get_property(var_api, 'slug')).str()),
		]))
		{
			var_installed_plugin = rt.call_function('get_plugins', [
				rt.new_string('/' + (rt.get_property(var_api, 'slug')).str()),
			])
			if !rt.is_true(var_installed_plugin) {
				if rt.is_true(rt.call_function('current_user_can', [
					rt.new_string('install_plugins'),
				]))
				{
					var_url = rt.call_function('wp_nonce_url', [
						rt.call_function('self_admin_url', [
							rt.new_string('update.php?action=install-plugin&plugin=' +
								(rt.get_property(var_api, 'slug')).str()),
						]),
						rt.new_string('install-plugin_' + (rt.get_property(var_api, 'slug')).str()),
					])
				}
			} else {
				var_key = rt.func_array_keys(var_installed_plugin.clone())
				var_key = rt.call_function('reset', [var_key.clone()])
				var_update_file = rt.new_string((rt.get_property(var_api, 'slug')).str() + '/' +
					var_key.str())
				if rt.is_true(rt.call_function('version_compare', [
					rt.get_property(var_api, 'version'),
					var_installed_plugin.array_get(var_key).array_get(rt.new_string('Version')),
					rt.new_string('='),
				]))
				{
					var_status = 'latest_installed'
				} else if rt.is_true(rt.call_function('version_compare', [
					rt.get_property(var_api, 'version'),
					var_installed_plugin.array_get(var_key).array_get(rt.new_string('Version')),
					rt.new_string('<'),
				]))
				{
					var_status = 'newer_installed'
					var_version =
						var_installed_plugin.array_get(var_key).array_get(rt.new_string('Version'))
				} else {
					if !var_loop {
						rt.call_function('delete_site_transient', [
							rt.new_string('update_plugins'),
						])
						rt.call_function('wp_update_plugins', []rt.PhpVal{})
						return install_plugin_install_status(var_api.clone(), true)
					}
				}
			}
		} else {
			if rt.is_true(rt.call_function('current_user_can', [
				rt.new_string('install_plugins'),
			]))
			{
				var_url = rt.call_function('wp_nonce_url', [
					rt.call_function('self_admin_url', [
						rt.new_string('update.php?action=install-plugin&plugin=' +
							(rt.get_property(var_api, 'slug')).str()),
					]),
					rt.new_string('install-plugin_' + (rt.get_property(var_api, 'slug')).str()),
				])
			}
		}
	}
	if rt.get_superglobal('_GET').array_isset(rt.new_string('from')) {
		var_url = rt.concat(var_url,
			rt.new_string('&amp;from=' +(rt.call_function('urlencode', [rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get(rt.new_string('from'))])])).str()))
	}
	var_file = var_update_file.clone()
	return rt.call_function('compact', [rt.new_string('status'),
		rt.new_string('url'), rt.new_string('version'), rt.new_string('file')])
}

fn install_plugin_information() {
	mut var_tab := rt.new_null()
	mut var_api := rt.new_null()
	mut var_plugins_allowedtags := map[string]rt.PhpVal{}
	mut var_plugins_section_titles := rt.new_null()
	mut var_content := rt.new_null()
	mut var_section_name := rt.new_null()
	mut var_key := rt.new_null()
	mut var__tab := rt.new_null()
	mut var_section := rt.new_null()
	mut var_section_titles := rt.new_null()
	mut var__with_banner := ''
	mut var_low := rt.new_null()
	mut var_high := rt.new_null()
	mut var_title := rt.new_null()
	mut var_class := ''
	mut var_href := rt.new_null()
	mut var_san_section := rt.new_null()
	mut var_active_installs_millions := rt.new_null()
	mut var_ratecount := rt.new_null()
	mut var__rating := rt.new_null()
	mut var_aria_label := rt.new_null()
	mut var_contrib_details := map[string]rt.PhpVal{}
	mut var_contrib_username := rt.new_null()
	mut var_contrib_name := rt.new_null()
	mut var_contrib_profile := rt.new_null()
	mut var_contrib_avatar := rt.new_null()
	mut var_requires_php := rt.new_null()
	mut var_requires_wp := rt.new_null()
	mut var_compatible_php := rt.new_null()
	mut var_compatible_wp := rt.new_null()
	mut var_tested_wp := false
	mut var_compatible_php_notice_message := ''
	mut var_compatible_wp_notice_message := rt.new_null()
	mut var_display := ''
	mut var_button := rt.new_null()
	if !rt.is_true(rt.get_superglobal('_REQUEST').array_get(rt.new_string('plugin'))) {
		return
	}
	var_api = plugins_api('plugin_information', rt.create_array([
		rt.ArrayItem{ key: 'slug', val: rt.call_function('wp_unslash', [
			rt.get_superglobal('_REQUEST').array_get(rt.new_string('plugin')),
		]) },
	]))
	if rt.is_true(rt.call_function('is_wp_error', [var_api.clone()])) {
		rt.call_function('wp_die', [var_api.clone()])
	}
	var_plugins_allowedtags = {
		'a':          {
			'href':   rt.new_array()
			'title':  rt.new_array()
			'target': rt.new_array()
		}
		'abbr':       {
			'title': rt.new_array()
		}
		'acronym':    {
			'title': rt.new_array()
		}
		'code':       rt.new_array()
		'pre':        rt.new_array()
		'em':         rt.new_array()
		'strong':     rt.new_array()
		'div':        {
			'class': rt.new_array()
		}
		'span':       {
			'class': rt.new_array()
		}
		'p':          rt.new_array()
		'br':         rt.new_array()
		'ul':         rt.new_array()
		'ol':         rt.new_array()
		'li':         rt.new_array()
		'h1':         rt.new_array()
		'h2':         rt.new_array()
		'h3':         rt.new_array()
		'h4':         rt.new_array()
		'h5':         rt.new_array()
		'h6':         rt.new_array()
		'img':        {
			'src':   rt.new_array()
			'class': rt.new_array()
			'alt':   rt.new_array()
		}
		'blockquote': {
			'cite': rt.new_bool(true)
		}
	}
	var_plugins_section_titles = rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('_x', [
			rt.new_string('Description'),
			rt.new_string('Plugin installer section title'),
		]) },
		rt.ArrayItem{ key: 'installation', val: rt.call_function('_x', [
			rt.new_string('Installation'),
			rt.new_string('Plugin installer section title'),
		]) },
		rt.ArrayItem{ key: 'faq', val: rt.call_function('_x', [
			rt.new_string('FAQ'),
			rt.new_string('Plugin installer section title'),
		]) },
		rt.ArrayItem{ key: 'screenshots', val: rt.call_function('_x', [
			rt.new_string('Screenshots'),
			rt.new_string('Plugin installer section title'),
		]) },
		rt.ArrayItem{ key: 'changelog', val: rt.call_function('_x', [
			rt.new_string('Changelog'),
			rt.new_string('Plugin installer section title'),
		]) },
		rt.ArrayItem{ key: 'reviews', val: rt.call_function('_x', [
			rt.new_string('Reviews'),
			rt.new_string('Plugin installer section title'),
		]) },
		rt.ArrayItem{ key: 'other_notes', val: rt.call_function('_x', [
			rt.new_string('Other Notes'),
			rt.new_string('Plugin installer section title'),
		]) },
	])
	mut iter_3 := rt.cast_array(rt.get_property(var_api, 'sections')).iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_content_shadow := item_3.val
		mut var_section_name_shadow := item_3.key
		rt.get_property(var_api, 'sections').array_set(var_section_name_shadow, rt.call_function('wp_kses', [
			var_content_shadow.clone(),
			rt.create_array_from_native_map(var_plugins_allowedtags),
		]))
	}
	mut iter_4 := rt.create_array([rt.ArrayItem{ key: none, val: 'version' },
		rt.ArrayItem{ key: none, val: 'author' }, rt.ArrayItem{ key: none, val: 'requires' },
		rt.ArrayItem{ key: none, val: 'tested' }, rt.ArrayItem{ key: none, val: 'homepage' },
		rt.ArrayItem{ key: none, val: 'downloaded' }, rt.ArrayItem{ key: none, val: 'slug' }]).iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_key_shadow := item_4.val
		if !(rt.get_property(var_api, '{"nodeType":"Expr_Variable","line":586,"name":"key"}')).is_null() {
			rt.set_property(var_api, '{"nodeType":"Expr_Variable","line":587,"name":"key"}', rt.call_function('wp_kses', [
				rt.get_property(var_api, '{"nodeType":"Expr_Variable","line":587,"name":"key"}'),
				rt.create_array_from_native_map(var_plugins_allowedtags),
			]))
		}
	}
	var__tab = rt.call_function('esc_attr', [var_tab.clone()])
	var_section = if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('section')) { rt.call_function('wp_unslash', [
			rt.get_superglobal('_REQUEST').array_get(rt.new_string('section')),
		]) } else { rt.new_string('description') }
	if !rt.is_true(var_section) || !(rt.get_property(var_api, 'sections').array_isset(var_section)) {
		var_section_titles = rt.func_array_keys(rt.cast_array(rt.get_property(var_api, 'sections')))
		var_section = rt.call_function('reset', [var_section_titles.clone()])
	}
	rt.call_function('iframe_header', [
		rt.call_function('__', [rt.new_string('Plugin Installation')]),
	])
	var__with_banner = ''
	if !(!rt.is_true(rt.get_property(var_api, 'banners')))
		&& !(!rt.is_true(rt.get_property(var_api, 'banners').array_get(rt.new_string('low'))))
		|| !(!rt.is_true(rt.get_property(var_api, 'banners').array_get(rt.new_string('high')))) {
		var__with_banner = 'with-banner'
		var_low = if !rt.is_true(rt.get_property(var_api, 'banners').array_get(rt.new_string('low'))) {
			rt.get_property(var_api, 'banners').array_get(rt.new_string('high'))
		} else {
			rt.get_property(var_api, 'banners').array_get(rt.new_string('low'))
		}
		var_high = if !rt.is_true(rt.get_property(var_api, 'banners').array_get(rt.new_string('high'))) {
			rt.get_property(var_api, 'banners').array_get(rt.new_string('low'))
		} else {
			rt.get_property(var_api, 'banners').array_get(rt.new_string('high'))
		}
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_url', [var_low.clone()]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_url', [var_high.clone()]))
		// unsupported statement: Stmt_InlineHTML
	}
	print('<div id="plugin-information-scrollable">')
	print(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string("<div id='"),
		var__tab), rt.new_string("-title' class='")), rt.new_string(var__with_banner.str())),
		rt.new_string("'><div class='vignette'></div><h2>")), rt.get_property(var_api, 'name')),
		rt.new_string('</h2></div>')))
	print("<div id='${var__tab.to_string()}-tabs' class='${var__with_banner}'>\n")
	mut iter_5 := rt.cast_array(rt.get_property(var_api, 'sections')).iterator()
	for {
		item_5 := iter_5.next() or { break }
		mut var_content_shadow := item_5.val
		mut var_section_name_shadow := item_5.key
		if rt.is_true(rt.identical(rt.new_string('reviews'), var_section_name_shadow))
			&& !rt.is_true(rt.get_property(var_api, 'ratings'))
			|| rt.is_true(rt.identical(rt.new_int(0), rt.call_function('array_sum', [rt.cast_array(rt.get_property(var_api, 'ratings'))]))) {
			continue
		}
		if var_plugins_section_titles.array_isset(var_section_name_shadow) {
			var_title = var_plugins_section_titles.array_get(var_section_name_shadow)
		} else {
			var_title = rt.call_function('ucwords', [
				rt.call_function('str_replace', [rt.new_string('_'),
					rt.new_string(' '), var_section_name_shadow.clone()]),
			])
		}
		var_class = if rt.is_true(rt.identical(var_section_name_shadow, var_section)) {
			' class="current"'
		} else {
			''
		}
		var_href = rt.call_function('add_query_arg', [
			rt.create_array([rt.ArrayItem{ key: 'tab', val: var_tab },
				rt.ArrayItem{ key: 'section', val: var_section_name_shadow }]),
		])
		var_href = rt.call_function('esc_url', [var_href.clone()])
		var_san_section = rt.call_function('esc_attr', [var_section_name_shadow.clone()])
		print("\t<a name='${var_san_section.to_string()}' href='${var_href.to_string()}' ${var_class}>${var_title.to_string()}</a>\n")
	}
	print('</div>\n')
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var__tab)
	// unsupported statement: Stmt_InlineHTML
	print(var__with_banner)
	// unsupported statement: Stmt_InlineHTML
	if !(!rt.is_true(rt.get_property(var_api, 'version'))) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Version:')])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.get_property(var_api, 'version'))
		// unsupported statement: Stmt_InlineHTML
	}
	if !(!rt.is_true(rt.get_property(var_api, 'author'))) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Author:')])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('links_add_target', [
			rt.get_property(var_api, 'author'),
			rt.new_string('_blank'),
		]))
		// unsupported statement: Stmt_InlineHTML
	}
	if !(!rt.is_true(rt.get_property(var_api, 'last_updated'))) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Last Updated:')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('printf', [rt.call_function('__', [rt.new_string('%s ago')]),
			rt.call_function('human_time_diff', [
				rt.call_function('strtotime', [rt.get_property(var_api, 'last_updated')]),
			])])
		// unsupported statement: Stmt_InlineHTML
	}
	if !(!rt.is_true(rt.get_property(var_api, 'requires'))) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Requires WordPress Version:')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('printf', [
			rt.call_function('__', [rt.new_string('%s or higher')]),
			rt.get_property(var_api, 'requires'),
		])
		// unsupported statement: Stmt_InlineHTML
	}
	if !(!rt.is_true(rt.get_property(var_api, 'tested'))) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Compatible up to:')])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.get_property(var_api, 'tested'))
		// unsupported statement: Stmt_InlineHTML
	}
	if !(!rt.is_true(rt.get_property(var_api, 'requires_php'))) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Requires PHP Version:')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('printf', [
			rt.call_function('__', [rt.new_string('%s or higher')]),
			rt.get_property(var_api, 'requires_php'),
		])
		// unsupported statement: Stmt_InlineHTML
	}
	if !(rt.get_property(var_api, 'active_installs')).is_null() {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Active Installations:')])
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(rt.greater_equal(rt.get_property(var_api, 'active_installs'),
			rt.new_int(1000000)))
		{
			var_active_installs_millions = rt.call_function('floor', [
				rt.div(rt.get_property(var_api, 'active_installs'), rt.new_int(1000000)),
			])
			rt.call_function('printf', [
				rt.call_function('_nx', [rt.new_string('%s+ Million'),
					rt.new_string('%s+ Million'), var_active_installs_millions.clone(),
					rt.new_string('Active plugin installations')]),
				rt.call_function('number_format_i18n', [var_active_installs_millions.clone()]),
			])
		} else if rt.is_true(rt.less(rt.get_property(var_api, 'active_installs'), rt.new_int(10))) {
			rt.call_function('_ex', [rt.new_string('Less Than 10'),
				rt.new_string('Active plugin installations')])
		} else {
			print(
				(rt.call_function('number_format_i18n', [rt.get_property(var_api, 'active_installs')])).str() +
				'+')
		}
		// unsupported statement: Stmt_InlineHTML
	}
	if !(!rt.is_true(rt.get_property(var_api, 'slug')))
		&& !rt.is_true(rt.get_property(var_api, 'external')) {
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_url', [
			rt.new_string(
				(rt.call_function('__', [rt.new_string('https://wordpress.org/plugins/')])).str() +
				(rt.get_property(var_api, 'slug')).str()),
		]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('WordPress.org Plugin Page &#187;')])
		// unsupported statement: Stmt_InlineHTML
	}
	if !(!rt.is_true(rt.get_property(var_api, 'homepage'))) {
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_url', [rt.get_property(var_api, 'homepage')]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Plugin Homepage &#187;')])
		// unsupported statement: Stmt_InlineHTML
	}
	if !(!rt.is_true(rt.get_property(var_api, 'donate_link')))
		&& !rt.is_true(rt.get_property(var_api, 'contributors')) {
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_url', [rt.get_property(var_api, 'donate_link')]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Donate to this plugin &#187;')])
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	if !(!rt.is_true(rt.get_property(var_api, 'rating'))) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Average Rating')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('wp_star_rating', [
			rt.create_array([
				rt.ArrayItem{ key: 'rating', val: rt.get_property(var_api, 'rating') },
				rt.ArrayItem{ key: 'type', val: 'percent' },
				rt.ArrayItem{ key: 'number', val: rt.get_property(var_api, 'num_ratings') },
			]),
		])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('printf', [
			rt.call_function('_n', [rt.new_string('(based on %s rating)'),
				rt.new_string('(based on %s ratings)'), rt.get_property(var_api, 'num_ratings')]),
			rt.call_function('number_format_i18n', [rt.get_property(var_api, 'num_ratings')]),
		])
		// unsupported statement: Stmt_InlineHTML
	}
	if !(!rt.is_true(rt.get_property(var_api, 'ratings')))
		&& rt.is_true(rt.greater(rt.call_function('array_sum', [rt.cast_array(rt.get_property(var_api, 'ratings'))]), rt.new_int(0))) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Reviews')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [
			rt.new_string('Read all reviews on WordPress.org or write your own!'),
		])
		// unsupported statement: Stmt_InlineHTML
		mut iter_6 := rt.get_property(var_api, 'ratings').iterator()
		for {
			item_6 := iter_6.next() or { break }
			mut var_ratecount_shadow := item_6.val
			mut var_key_shadow := item_6.key
			var__rating = if rt.is_true(rt.get_property(var_api, 'num_ratings')) {
				rt.div(var_ratecount_shadow, rt.get_property(var_api, 'num_ratings'))
			} else {
				rt.new_int(0)
			}
			var_aria_label = rt.call_function('esc_attr', [
				rt.call_function('sprintf', [
					rt.call_function('_n', [
						rt.new_string('Reviews with %1$d star: %2$s. Opens in a new tab.'),
						rt.new_string('Reviews with %1$d stars: %2$s. Opens in a new tab.'),
						var_key_shadow.clone(),
					]),
					var_key_shadow.clone(),
					rt.call_function('number_format_i18n', [
						var_ratecount_shadow.clone(),
					]),
				]),
			])
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('printf', [
				rt.new_string('<a href="%s" target="_blank" aria-label="%s">%s</a>'),
				rt.concat(rt.concat(rt.concat(rt.new_string('https://wordpress.org/support/plugin/'), rt.get_property(var_api,
					'slug')), rt.new_string('/reviews/?filter=')), var_key_shadow),
				var_aria_label.clone(),
				rt.call_function('sprintf', [
					rt.call_function('_n', [rt.new_string('%d star'),
						rt.new_string('%d stars'), var_key_shadow.clone()]),
					var_key_shadow.clone(),
				]),
			])
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.mul(rt.new_int(92), var__rating))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('number_format_i18n', [
				var_ratecount_shadow.clone()]))
			// unsupported statement: Stmt_InlineHTML
		}
	}
	if !(!rt.is_true(rt.get_property(var_api, 'contributors'))) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Contributors')])
		// unsupported statement: Stmt_InlineHTML
		mut iter_7 := rt.cast_array(rt.get_property(var_api, 'contributors')).iterator()
		for {
			item_7 := iter_7.next() or { break }
			mut var_contrib_details_shadow := item_7.val
			mut var_contrib_username_shadow := item_7.key
			var_contrib_name = var_contrib_details_shadow['display_name']
			if rt.is_true(rt.new_bool(!(rt.is_true(var_contrib_name)))) {
				var_contrib_name = var_contrib_username_shadow
			}
			var_contrib_name = rt.call_function('esc_html', [
				var_contrib_name.clone()])
			var_contrib_profile = rt.call_function('esc_url',
				[var_contrib_details_shadow['profile']])
			var_contrib_avatar = rt.call_function('esc_url', [
				rt.call_function('add_query_arg', [rt.new_string('s'),
					rt.new_string('36'), var_contrib_details_shadow['avatar']]),
			])
			print("<li><a href='${var_contrib_profile.to_string()}' target='_blank'><img src='${var_contrib_avatar.to_string()}' width='18' height='18' alt='' />${var_contrib_name.to_string()}</a></li>")
		}
		// unsupported statement: Stmt_InlineHTML
		if !(!rt.is_true(rt.get_property(var_api, 'donate_link'))) {
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_url', [
				rt.get_property(var_api, 'donate_link'),
			]))
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('_e', [rt.new_string('Donate to this plugin &#187;')])
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	var_requires_php = if !(rt.get_property(var_api, 'requires_php')).is_null() {
		rt.get_property(var_api, 'requires_php')
	} else {
		rt.new_null()
	}
	var_requires_wp = if !(rt.get_property(var_api, 'requires')).is_null() {
		rt.get_property(var_api, 'requires')
	} else {
		rt.new_null()
	}
	var_compatible_php = rt.call_function('is_php_version_compatible', [
		var_requires_php.clone()])
	var_compatible_wp = rt.call_function('is_wp_version_compatible', [
		var_requires_wp.clone()])
	var_tested_wp = !rt.is_true(rt.get_property(var_api, 'tested'))
		|| rt.is_true(rt.call_function('version_compare', [rt.call_function('get_bloginfo', [rt.new_string('version')]), rt.get_property(var_api, 'tested'), rt.new_string('<=')]))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_compatible_php)))) {
		var_compatible_php_notice_message = '<p>'
		var_compatible_php_notice_message = var_compatible_php_notice_message +(rt.call_function('__', [rt.new_string('<strong>Error:</strong> This plugin <strong>requires a newer version of PHP</strong>.')])).str()
		if rt.is_true(rt.call_function('current_user_can', [rt.new_string('update_php')])) {
			var_compatible_php_notice_message = var_compatible_php_notice_message +
				(rt.call_function('sprintf', [rt.new_string(' ' + (rt.call_function('__', [rt.new_string('<a href="%s" target="_blank">Click here to learn more about updating PHP</a>.')])).str()), rt.call_function('esc_url', [rt.call_function('wp_get_update_php_url', []rt.PhpVal{})])])).str() +(rt.call_function('wp_update_php_annotation', [rt.new_string('</p><p><em>'), rt.new_string('</em>'), rt.new_bool(false)])).str()
		} else {
			var_compatible_php_notice_message = var_compatible_php_notice_message + '</p>'
		}
		rt.call_function('wp_admin_notice', [rt.new_string(var_compatible_php_notice_message.str()).clone(),
			rt.create_array([rt.ArrayItem{ key: 'type', val: 'error' },
				rt.ArrayItem{ key: 'additional_classes', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'notice-alt' },
				]) }, rt.ArrayItem{ key: 'paragraph_wrap', val: false }])])
	}
	if !var_tested_wp {
		rt.call_function('wp_admin_notice', [
			rt.call_function('__', [
				rt.new_string('<strong>Warning:</strong> This plugin <strong>has not been tested</strong> with your current version of WordPress.'),
			]),
			rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'warning' },
				rt.ArrayItem{ key: 'additional_classes', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'notice-alt' },
				]) },
			]),
		])
	} else if rt.is_true(rt.new_bool(!(rt.is_true(var_compatible_wp)))) {
		var_compatible_wp_notice_message = rt.call_function('__', [
			rt.new_string('<strong>Error:</strong> This plugin <strong>requires a newer version of WordPress</strong>.'),
		])
		if rt.is_true(rt.call_function('current_user_can', [rt.new_string('update_core')])) {
			var_compatible_wp_notice_message = rt.concat(var_compatible_wp_notice_message, rt.call_function('sprintf', [
				rt.new_string(' ' +(rt.call_function('__', [rt.new_string('<a href="%s" target="_parent">Click here to update WordPress</a>.')])).str()),
				rt.call_function('esc_url', [
					rt.call_function('self_admin_url', [rt.new_string('update-core.php')]),
				]),
			]))
		}
		rt.call_function('wp_admin_notice', [var_compatible_wp_notice_message.clone(),
			rt.create_array([rt.ArrayItem{ key: 'type', val: 'error' },
				rt.ArrayItem{ key: 'additional_classes', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'notice-alt' },
				]) }])])
	}
	mut iter_8 := rt.cast_array(rt.get_property(var_api, 'sections')).iterator()
	for {
		item_8 := iter_8.next() or { break }
		mut var_content_shadow := item_8.val
		mut var_section_name_shadow := item_8.key
		var_content_shadow = rt.call_function('links_add_base_url', [
			var_content_shadow.clone(),
			rt.new_string('https://wordpress.org/plugins/' +
				(rt.get_property(var_api, 'slug')).str() + '/')])
		var_content_shadow = rt.call_function('links_add_target', [
			var_content_shadow.clone(), rt.new_string('_blank')])
		var_san_section = rt.call_function('esc_attr', [var_section_name_shadow.clone()])
		var_display = if rt.is_true(rt.identical(var_section_name_shadow, var_section)) {
			'block'
		} else {
			'none'
		}
		print("\t<div id='section-${var_san_section.to_string()}' class='section' style='display: ${var_display};'>\n")
		rt.echo_val(var_content_shadow)
		print('\t</div>\n')
	}
	print('</div>\n')
	print('</div>\n')
	print('</div>\n')
	print("<div id='${var_tab.to_string()}-footer'>\n")
	if !(!rt.is_true(rt.get_property(var_api, 'download_link')))
		&& rt.is_true(rt.call_function('current_user_can', [rt.new_string('install_plugins')]))
		|| rt.is_true(rt.call_function('current_user_can', [rt.new_string('update_plugins')])) {
		var_button = rt.new_string(wp_get_plugin_action_button(rt.get_property(var_api, 'name'),
			var_api.clone(), var_compatible_php.clone(), var_compatible_wp.clone()))
		var_button = rt.call_function('str_replace', [rt.new_string('class="'),
			rt.new_string('class="right '), var_button.clone()])
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('str_contains', [
			var_button.clone(),
			rt.call_function('_x', [rt.new_string('Activate'),
				rt.new_string('plugin')]),
		])))))
		{
			var_button = rt.call_function('str_replace', [rt.new_string('class="'),
				rt.new_string('id="plugin_install_from_iframe" class="'),
				var_button.clone()])
		}
		rt.echo_val(rt.call_function('wp_kses_post', [var_button.clone()]))
	}
	print('</div>\n')
	rt.call_function('wp_print_request_filesystem_credentials_modal', []rt.PhpVal{})
	rt.call_function('wp_print_admin_notice_templates', []rt.PhpVal{})
	rt.call_function('iframe_footer', []rt.PhpVal{})
	exit(0)
}

fn wp_get_plugin_action_button(var_name rt.PhpVal, var_data_arg rt.PhpVal, var_compatible_php rt.PhpVal, var_compatible_wp rt.PhpVal) string {
	mut var_data := var_data_arg
	mut var_button := ''
	mut var_status := rt.new_null()
	mut var_requires_plugins := rt.new_null()
	mut var_installed_plugins := rt.new_null()
	mut var_active_plugins := rt.new_null()
	mut var_plugin_dependencies_count := i64(0)
	mut var_installed_plugin_dependencies_count := i64(0)
	mut var_active_plugin_dependencies_count := i64(0)
	mut var_dependency := rt.new_null()
	mut var_installed_plugin_file := rt.new_null()
	mut var_active_plugin_file := rt.new_null()
	mut var_all_plugin_dependencies_installed := false
	mut var_all_plugin_dependencies_active := false
	mut var_button_text := rt.new_null()
	mut var_button_label := rt.new_null()
	mut var_activate_url := rt.new_null()
	var_button = ''
	var_data = rt.array_to_object(var_data)
	var_status = install_plugin_install_status(var_data.clone(), false)
	var_requires_plugins = if !(rt.get_property(var_data, 'requires_plugins')).is_null() {
		rt.get_property(var_data, 'requires_plugins')
	} else {
		rt.new_array()
	}
	var_installed_plugins = rt.call_function('get_plugins', []rt.PhpVal{})
	var_active_plugins = rt.call_function('get_option', [rt.new_string('active_plugins'),
		rt.new_array()])
	var_plugin_dependencies_count = var_requires_plugins.clone().array_count()
	var_installed_plugin_dependencies_count = 0
	var_active_plugin_dependencies_count = 0
	mut iter_9 := var_requires_plugins.iterator()
	for {
		item_9 := iter_9.next() or { break }
		mut var_dependency_shadow := item_9.val
		mut iter_10 := rt.func_array_keys(var_installed_plugins.clone()).iterator()
		for {
			item_10 := iter_10.next() or { break }
			mut var_installed_plugin_file_shadow := item_10.val
			if rt.is_true(rt.call_function('str_contains', [var_installed_plugin_file_shadow.clone(), rt.new_string('/')]))
				&& rt.is_true(rt.identical(rt.call_function('explode', [rt.new_string('/'), var_installed_plugin_file_shadow.clone()]).array_get(rt.new_int(0)), var_dependency_shadow)) {
				var_installed_plugin_dependencies_count += 1
			}
		}
		mut iter_11 := var_active_plugins.iterator()
		for {
			item_11 := iter_11.next() or { break }
			mut var_active_plugin_file_shadow := item_11.val
			if rt.is_true(rt.call_function('str_contains', [var_active_plugin_file_shadow.clone(), rt.new_string('/')]))
				&& rt.is_true(rt.identical(rt.call_function('explode', [rt.new_string('/'), var_active_plugin_file_shadow.clone()]).array_get(rt.new_int(0)), var_dependency_shadow)) {
				var_active_plugin_dependencies_count += 1
			}
		}
	}
	var_all_plugin_dependencies_installed =
		rt.new_bool(var_installed_plugin_dependencies_count == var_plugin_dependencies_count)
	var_all_plugin_dependencies_active =
		rt.new_bool(var_active_plugin_dependencies_count == var_plugin_dependencies_count)
	if rt.is_true(rt.call_function('current_user_can', [rt.new_string('install_plugins')]))
		|| rt.is_true(rt.call_function('current_user_can', [rt.new_string('update_plugins')])) {
		mut switch_val_2 := var_status.array_get(rt.new_string('status'))
		if rt.is_true(rt.equal(switch_val_2, rt.new_string('install'))) {
			if rt.is_true(var_status.array_get(rt.new_string('url'))) {
				if rt.is_true(var_compatible_php) && rt.is_true(var_compatible_wp)
					&& var_all_plugin_dependencies_installed
					&& !(!rt.is_true(rt.get_property(var_data, 'download_link'))) {
					var_button = (rt.call_function('sprintf', [
						rt.new_string('<a class="install-now button" data-slug="%s" href="%s" aria-label="%s" data-name="%s" role="button">%s</a>'),
						rt.call_function('esc_attr', [rt.get_property(var_data, 'slug')]),
						rt.call_function('esc_url', [var_status.array_get(rt.new_string('url'))]),
						rt.call_function('esc_attr', [
							rt.call_function('sprintf', [
								rt.call_function('_x', [rt.new_string('Install %s now'),
									rt.new_string('plugin')]),
								var_name.clone(),
							]),
						]),
						rt.call_function('esc_attr', [
							var_name.clone(),
						]),
						rt.call_function('_x', [
							rt.new_string('Install Now'),
							rt.new_string('plugin'),
						]),
					])).str()
				} else {
					var_button = (rt.call_function('sprintf', [
						rt.new_string('<button type="button" class="install-now button button-disabled" disabled="disabled">%s</button>'),
						rt.call_function('_x', [rt.new_string('Install Now'),
							rt.new_string('plugin')]),
					])).str()
				}
			}
		} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('update_available'))) {
			if rt.is_true(var_status.array_get(rt.new_string('url'))) {
				if rt.is_true(var_compatible_php) && rt.is_true(var_compatible_wp) {
					var_button = (rt.call_function('sprintf', [
						rt.new_string('<a class="update-now button aria-button-if-js" data-plugin="%s" data-slug="%s" href="%s" aria-label="%s" data-name="%s" role="button">%s</a>'),
						rt.call_function('esc_attr', [
							var_status.array_get(rt.new_string('file')),
						]),
						rt.call_function('esc_attr', [
							rt.get_property(var_data, 'slug'),
						]),
						rt.call_function('esc_url', [
							var_status.array_get(rt.new_string('url')),
						]),
						rt.call_function('esc_attr', [
							rt.call_function('sprintf', [
								rt.call_function('_x', [rt.new_string('Update %s now'),
									rt.new_string('plugin')]),
								var_name.clone(),
							]),
						]),
						rt.call_function('esc_attr', [
							var_name.clone(),
						]),
						rt.call_function('_x', [
							rt.new_string('Update Now'),
							rt.new_string('plugin'),
						]),
					])).str()
				} else {
					var_button = (rt.call_function('sprintf', [
						rt.new_string('<button type="button" class="button button-disabled" disabled="disabled">%s</button>'),
						rt.call_function('_x', [rt.new_string('Update Now'),
							rt.new_string('plugin')]),
					])).str()
				}
			}
		} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('latest_installed')))
			|| rt.is_true(rt.equal(switch_val_2, rt.new_string('newer_installed'))) {
			if rt.is_true(rt.call_function('is_plugin_active', [
				var_status.array_get(rt.new_string('file')),
			]))
			{
				var_button = (rt.call_function('sprintf', [
					rt.new_string('<button type="button" class="button button-disabled" disabled="disabled">%s</button>'),
					rt.call_function('_x', [rt.new_string('Active'),
						rt.new_string('plugin')]),
				])).str()
			} else if rt.is_true(rt.call_function('current_user_can', [
				rt.new_string('activate_plugin'),
				var_status.array_get(rt.new_string('file')),
			]))
			{
				if rt.is_true(var_compatible_php) && rt.is_true(var_compatible_wp)
					&& var_all_plugin_dependencies_active {
					var_button_text = rt.call_function('_x', [
						rt.new_string('Activate'), rt.new_string('plugin')])
					var_button_label = rt.call_function('_x', [
						rt.new_string('Activate %s'),
						rt.new_string('plugin'),
					])
					var_activate_url = rt.call_function('add_query_arg', [
						rt.create_array([
							rt.ArrayItem{ key: '_wpnonce', val: rt.call_function('wp_create_nonce', [
								rt.new_string('activate-plugin_' +
									(var_status.array_get(rt.new_string('file'))).str()),
							]) },
							rt.ArrayItem{ key: 'action', val: 'activate' },
							rt.ArrayItem{
								key: 'plugin'
								val: var_status.array_get(rt.new_string('file'))
							},
						]),
						rt.call_function('network_admin_url', [
							rt.new_string('plugins.php'),
						]),
					])
					if rt.is_true(rt.call_function('is_network_admin', []rt.PhpVal{})) {
						var_button_text = rt.call_function('_x', [
							rt.new_string('Network Activate'),
							rt.new_string('plugin'),
						])
						var_button_label = rt.call_function('_x', [
							rt.new_string('Network Activate %s'),
							rt.new_string('plugin'),
						])
						var_activate_url = rt.call_function('add_query_arg', [
							rt.create_array([rt.ArrayItem{ key: 'networkwide', val: 1 }]),
							var_activate_url.clone(),
						])
					}
					var_button = (rt.call_function('sprintf', [
						rt.new_string('<a href="%1$s" data-name="%2$s" data-slug="%3$s" data-plugin="%4$s" class="button button-primary activate-now" aria-label="%5$s" role="button">%6$s</a>'),
						rt.call_function('esc_url', [var_activate_url.clone()]),
						rt.call_function('esc_attr', [var_name.clone()]),
						rt.call_function('esc_attr', [rt.get_property(var_data, 'slug')]),
						rt.call_function('esc_attr', [var_status.array_get(rt.new_string('file'))]),
						rt.call_function('esc_attr', [
							rt.call_function('sprintf', [var_button_label.clone(),
								var_name.clone()]),
						]),
						var_button_text.clone(),
					])).str()
				} else {
					var_button = (rt.call_function('sprintf', [
						rt.new_string('<button type="button" class="button button-disabled" disabled="disabled">%s</button>'),
						if rt.is_true(rt.call_function('is_network_admin', []rt.PhpVal{})) { rt.call_function('_x', [
								rt.new_string('Network Activate'),
								rt.new_string('plugin'),
							]) } else { rt.call_function('_x', [
								rt.new_string('Activate'),
								rt.new_string('plugin'),
							]) },
					])).str()
				}
			} else {
				var_button = (rt.call_function('sprintf', [
					rt.new_string('<button type="button" class="button button-disabled" disabled="disabled">%s</button>'),
					rt.call_function('_x', [rt.new_string('Installed'),
						rt.new_string('plugin')]),
				])).str()
			}
		}
	}
	return var_button
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

fn create_wp_error(_args ...rt.PhpVal) &Class_WP_Error {
	mut obj := &Class_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Error) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Error) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Error) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
