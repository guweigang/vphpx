import rt

struct Class_WP_Debug_Data {
	rt.PhpObjectBase
}

fn Class_WP_Debug_Data.check_for_updates() {
	rt.call_function('wp_version_check', []rt.PhpVal{})
	rt.call_function('wp_update_plugins', []rt.PhpVal{})
	rt.call_function('wp_update_themes', []rt.PhpVal{})
}

fn Class_WP_Debug_Data.debug_data() rt.PhpVal {
	mut var_info := rt.create_array([
		rt.ArrayItem{ key: 'wp-core', val: Class_WP_Debug_Data.get_wp_core() },
		rt.ArrayItem{ key: 'wp-paths-sizes', val: Class_WP_Debug_Data.get_wp_paths_sizes() },
		rt.ArrayItem{ key: 'wp-dropins', val: Class_WP_Debug_Data.get_wp_dropins() },
		rt.ArrayItem{ key: 'wp-active-theme', val: Class_WP_Debug_Data.get_wp_active_theme() },
		rt.ArrayItem{ key: 'wp-parent-theme', val: Class_WP_Debug_Data.get_wp_parent_theme() },
		rt.ArrayItem{ key: 'wp-themes-inactive', val: Class_WP_Debug_Data.get_wp_themes_inactive() },
		rt.ArrayItem{ key: 'wp-mu-plugins', val: Class_WP_Debug_Data.get_wp_mu_plugins() },
		rt.ArrayItem{ key: 'wp-plugins-active', val: Class_WP_Debug_Data.get_wp_plugins_active() },
		rt.ArrayItem{ key: 'wp-plugins-inactive', val: Class_WP_Debug_Data.get_wp_plugins_inactive() },
		rt.ArrayItem{ key: 'wp-media', val: Class_WP_Debug_Data.get_wp_media() },
		rt.ArrayItem{ key: 'wp-server', val: Class_WP_Debug_Data.get_wp_server() },
		rt.ArrayItem{ key: 'wp-database', val: Class_WP_Debug_Data.get_wp_database() },
		rt.ArrayItem{ key: 'wp-constants', val: Class_WP_Debug_Data.get_wp_constants() },
		rt.ArrayItem{ key: 'wp-filesystem', val: Class_WP_Debug_Data.get_wp_filesystem() },
	])
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_section := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.new_bool(!var_section.is_null())
	}
	var_info = rt.call_function('array_filter', [var_info.clone(),
		rt.new_closure(closure_1_fn)])
	var_info = rt.call_function('apply_filters', [rt.new_string('debug_information'),
		var_info.clone()])
	return var_info.clone()
}

fn Class_WP_Debug_Data.get_wp_core() rt.PhpVal {
	mut var_permalink_structure := rt.call_function('get_option', [
		rt.new_string('permalink_structure'),
	])
	mut var_is_ssl := rt.call_function('is_ssl', []rt.PhpVal{})
	mut var_users_can_register := rt.call_function('get_option', [
		rt.new_string('users_can_register'),
	])
	mut var_blog_public := rt.call_function('get_option', [rt.new_string('blog_public')])
	mut var_default_comment_status := rt.call_function('get_option', [
		rt.new_string('default_comment_status'),
	])
	mut var_environment_type := rt.call_function('wp_get_environment_type', []rt.PhpVal{})
	mut var_core_version := rt.call_function('wp_get_wp_version', []rt.PhpVal{})
	mut var_core_updates := rt.call_function('get_core_updates', []rt.PhpVal{})
	mut var_core_update_needed := rt.new_string('')
	if rt.is_true(rt.new_bool(var_core_updates.clone().is_array())) {
		mut iter_1 := var_core_updates.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_update := item_1.val
			mut var_core := item_1.key
			if rt.is_true(rt.identical(rt.new_string('upgrade'), rt.get_property(var_update,
				'response')))
			{
				var_core_update_needed =
					rt.new_string(' ' +(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('(Latest version: %s)')]), rt.get_property(var_update, 'version')])).str())
			} else {
				var_core_update_needed = rt.new_string('')
			}
		}
	}
	mut var_fields := rt.create_array([
		rt.ArrayItem{ key: 'version', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('Version'),
			]) },
			rt.ArrayItem{ key: 'value', val: var_core_version.str() + var_core_update_needed.str() },
			rt.ArrayItem{ key: 'debug', val: var_core_version },
		]) },
		rt.ArrayItem{ key: 'site_language', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('Site Language'),
			]) },
			rt.ArrayItem{ key: 'value', val: rt.call_function('get_locale', []rt.PhpVal{}) },
		]) },
		rt.ArrayItem{ key: 'user_language', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('User Language'),
			]) },
			rt.ArrayItem{ key: 'value', val: rt.call_function('get_user_locale', []rt.PhpVal{}) },
		]) },
		rt.ArrayItem{ key: 'timezone', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('Timezone'),
			]) },
			rt.ArrayItem{ key: 'value', val: rt.call_function('wp_timezone_string', []rt.PhpVal{}) },
		]) },
		rt.ArrayItem{ key: 'home_url', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('Home URL'),
			]) },
			rt.ArrayItem{ key: 'value', val: rt.call_function('get_bloginfo', [
				rt.new_string('url'),
			]) },
			rt.ArrayItem{ key: 'private', val: true },
		]) },
		rt.ArrayItem{ key: 'site_url', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('Site URL'),
			]) },
			rt.ArrayItem{ key: 'value', val: rt.call_function('get_bloginfo', [
				rt.new_string('wpurl'),
			]) },
			rt.ArrayItem{ key: 'private', val: true },
		]) },
		rt.ArrayItem{ key: 'permalink', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('Permalink structure'),
			]) },
			rt.ArrayItem{
				key: 'value'
				val: if rt.is_true(var_permalink_structure) { var_permalink_structure } else { rt.call_function('__', [
						rt.new_string('No permalink structure set'),
					]) }
			},
			rt.ArrayItem{ key: 'debug', val: var_permalink_structure },
		]) },
		rt.ArrayItem{ key: 'https_status', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('Is this site using HTTPS?'),
			]) },
			rt.ArrayItem{
				key: 'value'
				val: if rt.is_true(var_is_ssl) { rt.call_function('__', [
						rt.new_string('Yes'),
					]) } else { rt.call_function('__', [
						rt.new_string('No'),
					]) }
			},
			rt.ArrayItem{ key: 'debug', val: var_is_ssl },
		]) },
		rt.ArrayItem{ key: 'multisite', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('Is this a multisite?'),
			]) },
			rt.ArrayItem{
				key: 'value'
				val: if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) { rt.call_function('__', [
						rt.new_string('Yes'),
					]) } else { rt.call_function('__', [
						rt.new_string('No'),
					]) }
			},
			rt.ArrayItem{ key: 'debug', val: rt.call_function('is_multisite', []rt.PhpVal{}) },
		]) },
		rt.ArrayItem{ key: 'user_registration', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('Can anyone register on this site?'),
			]) },
			rt.ArrayItem{
				key: 'value'
				val: if rt.is_true(var_users_can_register) { rt.call_function('__', [
						rt.new_string('Yes'),
					]) } else { rt.call_function('__', [
						rt.new_string('No'),
					]) }
			},
			rt.ArrayItem{ key: 'debug', val: var_users_can_register },
		]) },
		rt.ArrayItem{ key: 'blog_public', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('Is this site discouraging search engines?'),
			]) },
			rt.ArrayItem{
				key: 'value'
				val: if rt.is_true(var_blog_public) { rt.call_function('__', [
						rt.new_string('No'),
					]) } else { rt.call_function('__', [
						rt.new_string('Yes'),
					]) }
			},
			rt.ArrayItem{ key: 'debug', val: var_blog_public },
		]) },
		rt.ArrayItem{ key: 'default_comment_status', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('Default comment status'),
			]) },
			rt.ArrayItem{
				key: 'value'
				val: if rt.is_true(rt.identical(rt.new_string('open'), var_default_comment_status)) { rt.call_function('_x', [
						rt.new_string('Open'),
						rt.new_string('comment status'),
					]) } else { rt.call_function('_x', [
						rt.new_string('Closed'),
						rt.new_string('comment status'),
					]) }
			},
			rt.ArrayItem{ key: 'debug', val: var_default_comment_status },
		]) },
		rt.ArrayItem{ key: 'environment_type', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('Environment type'),
			]) },
			rt.ArrayItem{ key: 'value', val: var_environment_type },
			rt.ArrayItem{ key: 'debug', val: var_environment_type },
		]) },
	])
	if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) {
		mut var_site_id := rt.call_function('get_current_blog_id', []rt.PhpVal{})
		var_fields.array_set('site_id', rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('Site ID'),
			]) },
			rt.ArrayItem{ key: 'value', val: var_site_id },
			rt.ArrayItem{ key: 'debug', val: var_site_id },
		]))
		mut var_network_query := create_wp_network_query()
		mut var_network_ids := var_network_query.query(rt.create_array([
			rt.ArrayItem{ key: 'fields', val: 'ids' },
			rt.ArrayItem{ key: 'number', val: 100 },
			rt.ArrayItem{ key: 'no_found_rows', val: false },
		]))
		mut var_site_count := rt.new_int(0)
		mut iter_2 := var_network_ids.iterator()
		for {
			item_2 := iter_2.next() or { break }
			mut var_network_id := item_2.val
			var_site_count = rt.add(var_site_count, rt.call_function('get_blog_count', [
				var_network_id.clone(),
			]))
		}
		var_fields.array_set('site_count', rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('Site count'),
			]) },
			rt.ArrayItem{ key: 'value', val: var_site_count },
		]))
		var_fields.array_set('network_count', rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('Network count'),
			]) },
			rt.ArrayItem{ key: 'value', val: rt.get_property(var_network_query, 'found_networks') },
		]))
	}
	var_fields.array_set('user_count', rt.create_array([
		rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
			rt.new_string('User count'),
		]) },
		rt.ArrayItem{ key: 'value', val: rt.call_function('get_user_count', []rt.PhpVal{}) },
	]))
	mut var_wp_dotorg := rt.call_function('wp_remote_get', [
		rt.new_string('https://wordpress.org'),
		rt.create_array([rt.ArrayItem{ key: 'timeout', val: 10 }]),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [
		var_wp_dotorg.clone()])))))
	{
		var_fields.array_set('dotorg_communication', rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('Communication with WordPress.org'),
			]) },
			rt.ArrayItem{ key: 'value', val: rt.call_function('__', [
				rt.new_string('WordPress.org is reachable'),
			]) },
			rt.ArrayItem{ key: 'debug', val: 'true' },
		]))
	} else {
		var_fields.array_set('dotorg_communication', rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('Communication with WordPress.org'),
			]) },
			rt.ArrayItem{ key: 'value', val: rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('Unable to reach WordPress.org at %1$s: %2$s'),
				]),
				rt.call_function('gethostbyname', [
					rt.new_string('wordpress.org'),
				]),
				rt.call_method(var_wp_dotorg, 'get_error_message', []rt.PhpVal{}),
			]) },
			rt.ArrayItem{ key: 'debug', val: rt.call_method(var_wp_dotorg, 'get_error_message',
				[]rt.PhpVal{}) },
		]))
	}
	return rt.create_array([
		rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
			rt.new_string('WordPress'),
		]) },
		rt.ArrayItem{ key: 'fields', val: var_fields },
	])
}

fn Class_WP_Debug_Data.get_wp_dropins() rt.PhpVal {
	mut var_dropins := rt.call_function('get_dropins', []rt.PhpVal{})
	mut var_dropin_descriptions := rt.call_function('_get_dropins', []rt.PhpVal{})
	mut var_fields := rt.new_array()
	mut iter_3 := var_dropins.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_dropin := item_3.val
		mut var_dropin_key := item_3.key
		var_fields.array_set(rt.call_function('sanitize_text_field', [
			var_dropin_key.clone()]), rt.create_array([
			rt.ArrayItem{ key: 'label', val: var_dropin_key },
			rt.ArrayItem{
				key: 'value'
				val: var_dropin_descriptions.array_get(var_dropin_key).array_get(rt.new_int(0))
			},
			rt.ArrayItem{ key: 'debug', val: 'true' },
		]))
	}
	return rt.create_array([
		rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
			rt.new_string('Drop-ins'),
		]) },
		rt.ArrayItem{ key: 'show_count', val: true },
		rt.ArrayItem{ key: 'description', val: rt.call_function('sprintf', [
			rt.call_function('__', [
				rt.new_string('Drop-ins are single files, found in the %s directory, that replace or enhance WordPress features in ways that are not possible for traditional plugins.'),
			]),
			rt.new_string('<code>' +
				(rt.call_function('str_replace', [rt.get_constant('ABSPATH'), rt.new_string(''), rt.get_constant('WP_CONTENT_DIR')])).str() +
				'</code>'),
		]) },
		rt.ArrayItem{ key: 'fields', val: var_fields },
	])
}

fn Class_WP_Debug_Data.get_wp_server() rt.PhpVal {
	if rt.is_true(rt.call_function('function_exists', [rt.new_string('php_uname')])) {
		mut var_server_architecture := rt.call_function('sprintf', [
			rt.new_string('%s %s %s'),
			rt.call_function('php_uname', [rt.new_string('s')]),
			rt.call_function('php_uname', [rt.new_string('r')]),
			rt.call_function('php_uname', [rt.new_string('m')]),
		])
	} else {
		var_server_architecture = rt.new_string('unknown')
	}
	mut var_php_version_debug := rt.get_constant('PHP_VERSION')
	mut var_php64bit := rt.identical(rt.mul(rt.get_constant('PHP_INT_SIZE'), rt.new_int(8)),
		rt.new_int(64))
	mut var_php_version := rt.call_function('sprintf', [rt.new_string('%s %s'),
		var_php_version_debug.clone(), if rt.is_true(var_php64bit) { rt.call_function('__', [
				rt.new_string('(Supports 64bit values)'),
			]) } else { rt.call_function('__', [
				rt.new_string('(Does not support 64bit values)'),
			]) }])
	if rt.is_true(var_php64bit) {
		var_php_version_debug = rt.concat(var_php_version_debug, rt.new_string(' 64bit'))
	}
	mut var_fields := rt.new_array()
	var_fields.array_set('server_architecture', rt.create_array([
		rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
			rt.new_string('Server architecture'),
		]) },
		rt.ArrayItem{
			key: 'value'
			val: if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('unknown'), var_server_architecture)))) { var_server_architecture } else { rt.call_function('__', [
					rt.new_string('Unable to determine server architecture'),
				]) }
		},
		rt.ArrayItem{ key: 'debug', val: var_server_architecture },
	]))
	var_fields.array_set('httpd_software', rt.create_array([
		rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
			rt.new_string('Web server'),
		]) },
		rt.ArrayItem{
			key: 'value'
			val: if !(!rt.is_true(rt.get_superglobal('_SERVER').array_get(rt.new_string('SERVER_SOFTWARE')))) { rt.call_function('wp_unslash', [
					rt.get_superglobal('_SERVER').array_get(rt.new_string('SERVER_SOFTWARE')),
				]) } else { rt.call_function('__', [
					rt.new_string('Unable to determine what web server software is used'),
				]) }
		},
		rt.ArrayItem{
			key: 'debug'
			val: if !(!rt.is_true(rt.get_superglobal('_SERVER').array_get(rt.new_string('SERVER_SOFTWARE')))) { rt.call_function('wp_unslash', [
					rt.get_superglobal('_SERVER').array_get(rt.new_string('SERVER_SOFTWARE')),
				]) } else { rt.new_string('unknown') }
		},
	]))
	var_fields.array_set('php_version', rt.create_array([
		rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
			rt.new_string('PHP version'),
		]) },
		rt.ArrayItem{ key: 'value', val: var_php_version },
		rt.ArrayItem{ key: 'debug', val: var_php_version_debug },
	]))
	var_fields.array_set('php_sapi', rt.create_array([
		rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
			rt.new_string('PHP SAPI'),
		]) },
		rt.ArrayItem{ key: 'value', val: rt.get_constant('PHP_SAPI') },
		rt.ArrayItem{ key: 'debug', val: rt.get_constant('PHP_SAPI') },
	]))
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('ini_get'),
	])))))
	{
		var_fields.array_set('ini_get', rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('Server settings'),
			]) },
			rt.ArrayItem{ key: 'value', val: rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('Unable to determine some settings, as the %s function has been disabled.'),
				]),
				rt.new_string('ini_get()'),
			]) },
			rt.ArrayItem{ key: 'debug', val: 'ini_get() is disabled' },
		]))
	} else {
		var_fields.array_set('max_input_variables', rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('PHP max input variables'),
			]) },
			rt.ArrayItem{ key: 'value', val: rt.call_function('ini_get', [
				rt.new_string('max_input_vars'),
			]) },
		]))
		var_fields.array_set('time_limit', rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('PHP time limit'),
			]) },
			rt.ArrayItem{ key: 'value', val: rt.call_function('ini_get', [
				rt.new_string('max_execution_time'),
			]) },
		]))
		mut iife_temp_1 := Class_WP_Site_Health{}
		mut iife_result_1 := iife_temp_1.get_instance()
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.get_property(iife_result_1,
			'php_memory_limit'), rt.call_function('ini_get', [
			rt.new_string('memory_limit'),
		])))))
		{
			mut iife_temp_2 := Class_WP_Site_Health{}
			mut iife_result_2 := iife_temp_2.get_instance()
			var_fields.array_set('memory_limit', rt.create_array([
				rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
					rt.new_string('PHP memory limit'),
				]) },
				rt.ArrayItem{ key: 'value', val: rt.get_property(iife_result_2, 'php_memory_limit') },
			]))
			var_fields.array_set('admin_memory_limit', rt.create_array([
				rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
					rt.new_string('PHP memory limit (only for admin screens)'),
				]) },
				rt.ArrayItem{ key: 'value', val: rt.call_function('ini_get', [
					rt.new_string('memory_limit'),
				]) },
			]))
		} else {
			var_fields.array_set('memory_limit', rt.create_array([
				rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
					rt.new_string('PHP memory limit'),
				]) },
				rt.ArrayItem{ key: 'value', val: rt.call_function('ini_get', [
					rt.new_string('memory_limit'),
				]) },
			]))
		}
		var_fields.array_set('max_input_time', rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('Max input time'),
			]) },
			rt.ArrayItem{ key: 'value', val: rt.call_function('ini_get', [
				rt.new_string('max_input_time'),
			]) },
		]))
		var_fields.array_set('upload_max_filesize', rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('Upload max filesize'),
			]) },
			rt.ArrayItem{ key: 'value', val: rt.call_function('ini_get', [
				rt.new_string('upload_max_filesize'),
			]) },
		]))
		var_fields.array_set('php_post_max_size', rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('PHP post max size'),
			]) },
			rt.ArrayItem{ key: 'value', val: rt.call_function('ini_get', [
				rt.new_string('post_max_size'),
			]) },
		]))
	}
	if rt.is_true(rt.call_function('function_exists', [rt.new_string('curl_version')])) {
		mut var_curl := rt.call_function('curl_version', []rt.PhpVal{})
		var_fields.array_set('curl_version', rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('cURL version'),
			]) },
			rt.ArrayItem{ key: 'value', val: rt.call_function('sprintf', [
				rt.new_string('%s %s'),
				var_curl.array_get(rt.new_string('version')),
				var_curl.array_get(rt.new_string('ssl_version')),
			]) },
		]))
	} else {
		var_fields.array_set('curl_version', rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('cURL version'),
			]) },
			rt.ArrayItem{ key: 'value', val: rt.call_function('__', [
				rt.new_string('Not available'),
			]) },
			rt.ArrayItem{ key: 'debug', val: 'not available' },
		]))
	}
	mut var_suhosin_loaded := rt.new_bool(
		rt.is_true(rt.call_function('extension_loaded', [rt.new_string('suhosin')]))
		|| rt.is_true(rt.call_function('defined', [rt.new_string('SUHOSIN_PATCH')]))
		&& rt.is_true(rt.call_function('constant', [rt.new_string('SUHOSIN_PATCH')])))
	var_fields.array_set('suhosin', rt.create_array([
		rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
			rt.new_string('Is SUHOSIN installed?'),
		]) },
		rt.ArrayItem{
			key: 'value'
			val: if rt.is_true(var_suhosin_loaded) { rt.call_function('__', [
					rt.new_string('Yes'),
				]) } else { rt.call_function('__', [
					rt.new_string('No'),
				]) }
		},
		rt.ArrayItem{ key: 'debug', val: var_suhosin_loaded },
	]))
	mut var_imagick_loaded := rt.call_function('extension_loaded', [
		rt.new_string('imagick'),
	])
	var_fields.array_set('imagick_availability', rt.create_array([
		rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
			rt.new_string('Is the Imagick library available?'),
		]) },
		rt.ArrayItem{
			key: 'value'
			val: if rt.is_true(var_imagick_loaded) { rt.call_function('__', [
					rt.new_string('Yes'),
				]) } else { rt.call_function('__', [
					rt.new_string('No'),
				]) }
		},
		rt.ArrayItem{ key: 'debug', val: var_imagick_loaded },
	]))
	if rt.is_true(rt.call_function('function_exists', [
		rt.new_string('opcache_get_status'),
	]))
	{
		mut var_opcache_status := rt.call_function('opcache_get_status', [
			rt.new_bool(false),
		])
		if rt.is_true(rt.identical(rt.new_bool(false), var_opcache_status)) {
			var_fields.array_set('opcode_cache', rt.create_array([
				rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
					rt.new_string('Opcode cache'),
				]) },
				rt.ArrayItem{ key: 'value', val: rt.call_function('__', [
					rt.new_string('Disabled by configuration'),
				]) },
				rt.ArrayItem{ key: 'debug', val: 'not available' },
			]))
		} else {
			var_fields.array_set('opcode_cache', rt.create_array([
				rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
					rt.new_string('Opcode cache'),
				]) },
				rt.ArrayItem{
					key: 'value'
					val: if rt.is_true(var_opcache_status.array_get(rt.new_string('opcache_enabled'))) { rt.call_function('__', [
							rt.new_string('Enabled'),
						]) } else { rt.call_function('__', [
							rt.new_string('Disabled'),
						]) }
				},
				rt.ArrayItem{
					key: 'debug'
					val: var_opcache_status.array_get(rt.new_string('opcache_enabled'))
				},
			]))
			if rt.is_true(rt.identical(rt.new_bool(true),
				var_opcache_status.array_get(rt.new_string('opcache_enabled'))))
			{
				var_fields.array_set('opcode_cache_memory_usage', rt.create_array([
					rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
						rt.new_string('Opcode cache memory usage'),
					]) },
					rt.ArrayItem{ key: 'value', val: rt.call_function('sprintf', [
						rt.call_function('__', [
							rt.new_string('%1$s of %2$s'),
						]),
						rt.call_function('size_format', [
							var_opcache_status.array_get(rt.new_string('memory_usage')).array_get(rt.new_string('used_memory')),
						]),
						rt.call_function('size_format', [
							rt.add(var_opcache_status.array_get(rt.new_string('memory_usage')).array_get(rt.new_string('free_memory')),
								var_opcache_status.array_get(rt.new_string('memory_usage')).array_get(rt.new_string('used_memory'))),
						]),
					]) },
					rt.ArrayItem{ key: 'debug', val: rt.call_function('sprintf', [
						rt.new_string('%s of %s'),
						var_opcache_status.array_get(rt.new_string('memory_usage')).array_get(rt.new_string('used_memory')),
						rt.add(var_opcache_status.array_get(rt.new_string('memory_usage')).array_get(rt.new_string('free_memory')),
							var_opcache_status.array_get(rt.new_string('memory_usage')).array_get(rt.new_string('used_memory'))),
					]) },
				]))
				if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int(0),
					var_opcache_status.array_get(rt.new_string('interned_strings_usage')).array_get(rt.new_string('buffer_size'))))))
				{
					var_fields.array_set('opcode_cache_interned_strings_usage', rt.create_array([
						rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
							rt.new_string('Opcode cache interned strings usage'),
						]) },
						rt.ArrayItem{ key: 'value', val: rt.call_function('sprintf', [
							rt.call_function('__', [
								rt.new_string('%1$s%% of %2$s (%3$s free)'),
							]),
							rt.call_function('number_format_i18n', [
								rt.mul(rt.div(var_opcache_status.array_get(rt.new_string('interned_strings_usage')).array_get(rt.new_string('used_memory')),
									var_opcache_status.array_get(rt.new_string('interned_strings_usage')).array_get(rt.new_string('buffer_size'))),
									rt.new_int(100)),
								rt.new_int(2),
							]),
							rt.call_function('size_format', [
								var_opcache_status.array_get(rt.new_string('interned_strings_usage')).array_get(rt.new_string('buffer_size')),
							]),
							rt.call_function('size_format', [
								var_opcache_status.array_get(rt.new_string('interned_strings_usage')).array_get(rt.new_string('free_memory')),
							]),
						]) },
						rt.ArrayItem{ key: 'debug', val: rt.call_function('sprintf', [
							rt.new_string('%s%% of %s (%s free)'),
							rt.call_function('round', [
								rt.mul(rt.div(var_opcache_status.array_get(rt.new_string('interned_strings_usage')).array_get(rt.new_string('used_memory')),
									var_opcache_status.array_get(rt.new_string('interned_strings_usage')).array_get(rt.new_string('buffer_size'))),
									rt.new_int(100)),
								rt.new_int(2),
							]),
							var_opcache_status.array_get(rt.new_string('interned_strings_usage')).array_get(rt.new_string('buffer_size')),
							var_opcache_status.array_get(rt.new_string('interned_strings_usage')).array_get(rt.new_string('free_memory')),
						]) },
					]))
				}
				var_fields.array_set('opcode_cache_hit_rate', rt.create_array([
					rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
						rt.new_string('Opcode cache hit rate'),
					]) },
					rt.ArrayItem{ key: 'value', val: rt.call_function('sprintf', [
						rt.call_function('__', [rt.new_string('%s%%')]),
						rt.call_function('number_format_i18n', [
							var_opcache_status.array_get(rt.new_string('opcache_statistics')).array_get(rt.new_string('opcache_hit_rate')),
							rt.new_int(2)]),
					]) },
					rt.ArrayItem{ key: 'debug', val: rt.call_function('round', [
						var_opcache_status.array_get(rt.new_string('opcache_statistics')).array_get(rt.new_string('opcache_hit_rate')),
						rt.new_int(2),
					]) },
				]))
				var_fields.array_set('opcode_cache_full', rt.create_array([
					rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
						rt.new_string('Is the Opcode cache full?'),
					]) },
					rt.ArrayItem{
						key: 'value'
						val: if rt.is_true(var_opcache_status.array_get(rt.new_string('cache_full'))) { rt.call_function('__', [
								rt.new_string('Yes'),
							]) } else { rt.call_function('__', [
								rt.new_string('No'),
							]) }
					},
					rt.ArrayItem{
						key: 'debug'
						val: var_opcache_status.array_get(rt.new_string('cache_full'))
					},
				]))
			}
		}
	} else {
		var_fields.array_set('opcode_cache', rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('Opcode cache'),
			]) },
			rt.ArrayItem{ key: 'value', val: rt.call_function('__', [
				rt.new_string('Disabled'),
			]) },
			rt.ArrayItem{ key: 'debug', val: 'not available' },
		]))
	}
	mut var_pretty_permalinks_supported := rt.call_function('got_url_rewrite', []rt.PhpVal{})
	var_fields.array_set('pretty_permalinks', rt.create_array([
		rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
			rt.new_string('Are pretty permalinks supported?'),
		]) },
		rt.ArrayItem{
			key: 'value'
			val: if rt.is_true(var_pretty_permalinks_supported) { rt.call_function('__', [
					rt.new_string('Yes'),
				]) } else { rt.call_function('__', [
					rt.new_string('No'),
				]) }
		},
		rt.ArrayItem{ key: 'debug', val: var_pretty_permalinks_supported },
	]))
	if rt.is_true(rt.call_function('is_file', [
		rt.new_string((rt.get_constant('ABSPATH')).str() + '.htaccess'),
	]))
	{
		mut var_htaccess_content := rt.call_function('file_get_contents', [
			rt.new_string((rt.get_constant('ABSPATH')).str() + '.htaccess'),
		])
		mut var_filtered_htaccess_content := rt.new_string(rt.call_function('preg_replace', [
			rt.new_string('/\\# BEGIN WordPress[\\s\\S]+?# END WordPress/si'),
			rt.new_string(''),
			var_htaccess_content.clone(),
		]).to_string().trim_space())
		var_filtered_htaccess_content = rt.new_bool(!(!rt.is_true(var_filtered_htaccess_content)))
		if rt.is_true(var_filtered_htaccess_content) {
			mut var_htaccess_rules_string := rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('Custom rules have been added to your %s file.'),
				]),
				rt.new_string('.htaccess'),
			])
		} else {
			var_htaccess_rules_string = rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('Your %s file contains only core WordPress features.'),
				]),
				rt.new_string('.htaccess'),
			])
		}
		var_fields.array_set('htaccess_extra_rules', rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('.htaccess rules'),
			]) },
			rt.ArrayItem{ key: 'value', val: var_htaccess_rules_string },
			rt.ArrayItem{ key: 'debug', val: var_filtered_htaccess_content },
		]))
	}
	if rt.is_true(rt.call_function('is_file', [
		rt.new_string((rt.call_function('get_home_path', []rt.PhpVal{})).str() + 'robots.txt'),
	]))
	{
		mut var_robotstxt_debug := rt.new_bool(true)
		mut var_robotstxt_string := rt.call_function('sprintf', [
			rt.call_function('__', [
				rt.new_string('Your site is using a static %s file. WordPress cannot dynamically serve one.'),
			]),
			rt.new_string('robots.txt'),
		])
	} else if rt.is_true(rt.call_function('got_url_rewrite', []rt.PhpVal{})) {
		var_robotstxt_debug = rt.new_bool(false)
		var_robotstxt_string = rt.call_function('sprintf', [
			rt.call_function('__', [
				rt.new_string('Your site is using the dynamic %s file which is generated by WordPress.'),
			]),
			rt.new_string('robots.txt'),
		])
	} else {
		var_robotstxt_debug = rt.new_bool(true)
		var_robotstxt_string = rt.call_function('sprintf', [
			rt.call_function('__', [
				rt.new_string('WordPress cannot dynamically serve a %s file due to a lack of rewrite rule support.'),
			]),
			rt.new_string('robots.txt'),
		])
	}
	var_fields.array_set('static_robotstxt_file', rt.create_array([
		rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
			rt.new_string('robots.txt'),
		]) },
		rt.ArrayItem{ key: 'value', val: var_robotstxt_string },
		rt.ArrayItem{ key: 'debug', val: var_robotstxt_debug },
	]))
	mut var_date := create_datetime(rt.new_string('now'), create_datetimezone(rt.new_string('UTC')))
	var_fields.array_set('current', rt.create_array([
		rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
			rt.new_string('Current time'),
		]) },
		rt.ArrayItem{ key: 'value', val: var_date.format(Class_DateTime.atom()) },
	]))
	var_fields.array_set('utc-time', rt.create_array([
		rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
			rt.new_string('Current UTC time'),
		]) },
		rt.ArrayItem{ key: 'value', val: var_date.format(Class_DateTime.rfc850()) },
	]))
	var_fields.array_set('server-time', rt.create_array([
		rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
			rt.new_string('Current Server time'),
		]) },
		rt.ArrayItem{
			key: 'value'
			val: if rt.get_superglobal('_SERVER').array_isset(rt.new_string('REQUEST_TIME')) { rt.call_function('wp_date', [
					rt.new_string('c'),
					rt.new_int((rt.get_superglobal('_SERVER').array_get(rt.new_string('REQUEST_TIME'))).to_i64()),
				]) } else { rt.call_function('__', [
					rt.new_string('Unable to determine server time'),
				]) }
		},
	]))
	return rt.create_array([
		rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
			rt.new_string('Server')]) },
		rt.ArrayItem{
			key: 'description'
			val: rt.call_function('__', [
				rt.new_string('The options shown below relate to your server setup. If changes are required, you may need your web host&#8217;s assistance.'),
			])
		},
		rt.ArrayItem{ key: 'fields', val: var_fields },
	])
}

fn Class_WP_Debug_Data.get_wp_media() rt.PhpVal {
	mut var_fields := rt.new_null()
	mut var_not_available := rt.call_function('__', [rt.new_string('Not available')])
	var_fields.array_set('image_editor', rt.create_array([
		rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
			rt.new_string('Active editor'),
		]) },
		rt.ArrayItem{ key: 'value', val: rt.call_function('_wp_image_editor_choose', []rt.PhpVal{}) },
	]))
	if rt.is_true(rt.call_function('class_exists', [rt.new_string('Imagick')])) {
		mut var_imagick := create_imagick()
		mut var_imagemagick_version := var_imagick.getversion()
	} else {
		var_imagemagick_version = rt.call_function('__', [rt.new_string('Not available')])
	}
	var_fields.array_set('imagick_module_version', rt.create_array([
		rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
			rt.new_string('ImageMagick version number'),
		]) },
		rt.ArrayItem{
			key: 'value'
			val: if var_imagemagick_version.clone().is_array() {
				var_imagemagick_version.array_get(rt.new_string('versionNumber'))
			} else {
				var_imagemagick_version
			}
		},
	]))
	var_fields.array_set('imagemagick_version', rt.create_array([
		rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
			rt.new_string('ImageMagick version string'),
		]) },
		rt.ArrayItem{
			key: 'value'
			val: if var_imagemagick_version.clone().is_array() {
				var_imagemagick_version.array_get(rt.new_string('versionString'))
			} else {
				var_imagemagick_version
			}
		},
	]))
	mut var_imagick_version := rt.call_function('phpversion', [
		rt.new_string('imagick')])
	var_fields.array_set('imagick_version', rt.create_array([
		rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
			rt.new_string('Imagick version'),
		]) },
		rt.ArrayItem{
			key: 'value'
			val: if rt.is_true(var_imagick_version) { var_imagick_version } else { rt.call_function('__', [
					rt.new_string('Not available'),
				]) }
		},
	]))
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('ini_get'),
	])))))
	{
		var_fields.array_set('ini_get', rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('File upload settings'),
			]) },
			rt.ArrayItem{ key: 'value', val: rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('Unable to determine some settings, as the %s function has been disabled.'),
				]),
				rt.new_string('ini_get()'),
			]) },
			rt.ArrayItem{ key: 'debug', val: 'ini_get() is disabled' },
		]))
	} else {
		mut var_file_uploads := rt.call_function('ini_get', [
			rt.new_string('file_uploads'),
		])
		mut var_post_max_size := rt.call_function('ini_get', [
			rt.new_string('post_max_size'),
		])
		mut var_upload_max_filesize := rt.call_function('ini_get', [
			rt.new_string('upload_max_filesize'),
		])
		mut var_max_file_uploads := rt.call_function('ini_get', [
			rt.new_string('max_file_uploads'),
		])
		mut var_effective := rt.call_function('min', [
			rt.call_function('wp_convert_hr_to_bytes', [var_post_max_size.clone()]),
			rt.call_function('wp_convert_hr_to_bytes', [var_upload_max_filesize.clone()]),
		])
		var_fields.array_set('file_uploads', rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('File uploads'),
			]) },
			rt.ArrayItem{
				key: 'value'
				val: if rt.is_true(var_file_uploads) { rt.call_function('__', [
						rt.new_string('Enabled'),
					]) } else { rt.call_function('__', [
						rt.new_string('Disabled'),
					]) }
			},
			rt.ArrayItem{ key: 'debug', val: var_file_uploads },
		]))
		var_fields.array_set('post_max_size', rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('Max size of post data allowed'),
			]) },
			rt.ArrayItem{ key: 'value', val: var_post_max_size },
		]))
		var_fields.array_set('upload_max_filesize', rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('Max size of an uploaded file'),
			]) },
			rt.ArrayItem{ key: 'value', val: var_upload_max_filesize },
		]))
		var_fields.array_set('max_effective_size', rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('Max effective file size'),
			]) },
			rt.ArrayItem{ key: 'value', val: rt.call_function('size_format', [
				var_effective.clone(),
			]) },
		]))
		var_fields.array_set('max_file_uploads', rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('Max simultaneous file uploads'),
			]) },
			rt.ArrayItem{ key: 'value', val: var_max_file_uploads },
		]))
	}
	if rt.is_true(rt.identical(rt.new_string('WP_Image_Editor_Imagick'), rt.call_function('_wp_image_editor_choose', []rt.PhpVal{})))
		&& !var_imagick.is_null() && true {
		mut var_limits := {
			'area':   if rt.is_true(rt.call_function('defined', [
				rt.new_string('imagick::RESOURCETYPE_AREA'),
			]))
			{ rt.call_function('size_format', [
					var_imagick.getresourcelimit(Class_imagick.resourcetype_area()),
				]) } else { var_not_available }
			'disk':   if rt.is_true(rt.call_function('defined', [
				rt.new_string('imagick::RESOURCETYPE_DISK'),
			]))
			{
				var_imagick.getresourcelimit(Class_imagick.resourcetype_disk())
			} else {
				var_not_available
			}
			'file':   if rt.is_true(rt.call_function('defined', [
				rt.new_string('imagick::RESOURCETYPE_FILE'),
			]))
			{
				var_imagick.getresourcelimit(Class_imagick.resourcetype_file())
			} else {
				var_not_available
			}
			'map':    if rt.is_true(rt.call_function('defined', [
				rt.new_string('imagick::RESOURCETYPE_MAP'),
			]))
			{ rt.call_function('size_format', [
					var_imagick.getresourcelimit(Class_imagick.resourcetype_map()),
				]) } else { var_not_available }
			'memory': if rt.is_true(rt.call_function('defined', [
				rt.new_string('imagick::RESOURCETYPE_MEMORY'),
			]))
			{ rt.call_function('size_format', [
					var_imagick.getresourcelimit(Class_imagick.resourcetype_memory()),
				]) } else { var_not_available }
			'thread': if rt.is_true(rt.call_function('defined', [
				rt.new_string('imagick::RESOURCETYPE_THREAD'),
			]))
			{
				var_imagick.getresourcelimit(Class_imagick.resourcetype_thread())
			} else {
				var_not_available
			}
			'time':   if rt.is_true(rt.call_function('defined', [
				rt.new_string('imagick::RESOURCETYPE_TIME'),
			]))
			{
				var_imagick.getresourcelimit(Class_imagick.resourcetype_time())
			} else {
				var_not_available
			}
		}
		mut var_limits_debug := {
			'imagick::RESOURCETYPE_AREA':   if rt.is_true(rt.call_function('defined', [
				rt.new_string('imagick::RESOURCETYPE_AREA'),
			]))
			{ rt.call_function('size_format', [
					var_imagick.getresourcelimit(Class_imagick.resourcetype_area()),
				]) } else { rt.new_string('not available') }
			'imagick::RESOURCETYPE_DISK':   if rt.is_true(rt.call_function('defined', [
				rt.new_string('imagick::RESOURCETYPE_DISK'),
			]))
			{
				var_imagick.getresourcelimit(Class_imagick.resourcetype_disk())
			} else {
				rt.new_string('not available')
			}
			'imagick::RESOURCETYPE_FILE':   if rt.is_true(rt.call_function('defined', [
				rt.new_string('imagick::RESOURCETYPE_FILE'),
			]))
			{
				var_imagick.getresourcelimit(Class_imagick.resourcetype_file())
			} else {
				rt.new_string('not available')
			}
			'imagick::RESOURCETYPE_MAP':    if rt.is_true(rt.call_function('defined', [
				rt.new_string('imagick::RESOURCETYPE_MAP'),
			]))
			{ rt.call_function('size_format', [
					var_imagick.getresourcelimit(Class_imagick.resourcetype_map()),
				]) } else { rt.new_string('not available') }
			'imagick::RESOURCETYPE_MEMORY': if rt.is_true(rt.call_function('defined', [
				rt.new_string('imagick::RESOURCETYPE_MEMORY'),
			]))
			{ rt.call_function('size_format', [
					var_imagick.getresourcelimit(Class_imagick.resourcetype_memory()),
				]) } else { rt.new_string('not available') }
			'imagick::RESOURCETYPE_THREAD': if rt.is_true(rt.call_function('defined', [
				rt.new_string('imagick::RESOURCETYPE_THREAD'),
			]))
			{
				var_imagick.getresourcelimit(Class_imagick.resourcetype_thread())
			} else {
				rt.new_string('not available')
			}
			'imagick::RESOURCETYPE_TIME':   if rt.is_true(rt.call_function('defined', [
				rt.new_string('imagick::RESOURCETYPE_TIME'),
			]))
			{
				var_imagick.getresourcelimit(Class_imagick.resourcetype_time())
			} else {
				rt.new_string('not available')
			}
		}
		var_fields.array_set('imagick_limits', rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('Imagick Resource Limits'),
			]) },
			rt.ArrayItem{ key: 'value', val: var_limits },
			rt.ArrayItem{ key: 'debug', val: var_limits_debug },
		]))
		mut iife_temp_3 := Class_Imagick{}
		mut iife_result_3 := iife_temp_3.queryformats(rt.new_string('*'))
		mut var_formats := iife_result_3
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
		unsafe {
			goto end_label_1
		}
		catch_label_1:
		mut var_e_1 := rt.get_and_clear_exception()
		if rt.instance_of(var_e_1, 'Exception') {
			mut var_e := var_e_1.clone()
			var_formats = rt.new_array()
			unsafe {
				goto end_label_1
			}
		} else {
			rt.throw_exception(var_e_1)
			unsafe {
				goto end_label_1
			}
		}

		end_label_1:
		var_fields.array_set('imagemagick_file_formats', rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('ImageMagick supported file formats'),
			]) },
			rt.ArrayItem{
				key: 'value'
				val: if !rt.is_true(var_formats) { rt.call_function('__', [
						rt.new_string('Unable to determine'),
					]) } else { rt.call_function('implode', [
						rt.new_string(', '),
						var_formats.clone(),
					]) }
			},
			rt.ArrayItem{
				key: 'debug'
				val: if !rt.is_true(var_formats) { rt.new_string('Unable to determine') } else { rt.call_function('implode', [
						rt.new_string(', '),
						var_formats.clone(),
					]) }
			},
		]))
	}
	mut var_mappings := rt.call_function('wp_get_image_editor_output_format', [
		rt.new_string(''),
		rt.new_string(''),
	])
	mut var_formatted_mappings := rt.new_array()
	if !(!rt.is_true(var_mappings)) {
		mut iter_4 := var_mappings.iterator()
		for {
			item_4 := iter_4.next() or { break }
			mut var_mime_type := item_4.val
			mut var_format := item_4.key
			var_formatted_mappings << rt.call_function('sprintf', [
				rt.new_string('%s &rarr; %s'),
				var_format.clone(),
				var_mime_type.clone(),
			])
		}
		mut var_mappings_display := rt.call_function('implode', [
			rt.new_string(', '), rt.create_array_from_list(var_formatted_mappings)])
	} else {
		var_mappings_display = rt.call_function('__', [
			rt.new_string('No format transforms defined'),
		])
	}
	var_fields.array_set('image_format_transforms', rt.create_array([
		rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
			rt.new_string('Image format transforms'),
		]) },
		rt.ArrayItem{ key: 'value', val: var_mappings_display },
		rt.ArrayItem{
			key: 'debug'
			val: if !rt.is_true(var_mappings) {
				rt.new_string('No format transforms defined')
			} else {
				var_mappings_display
			}
		},
	]))
	if rt.is_true(rt.call_function('function_exists', [rt.new_string('gd_info')])) {
		mut var_gd := rt.call_function('gd_info', []rt.PhpVal{})
	} else {
		var_gd = rt.new_bool(false)
	}
	var_fields.array_set('gd_version', rt.create_array([
		rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
			rt.new_string('GD version'),
		]) },
		rt.ArrayItem{
			key: 'value'
			val: if var_gd.clone().is_array() {
				var_gd.array_get(rt.new_string('GD Version'))
			} else {
				var_not_available
			}
		},
		rt.ArrayItem{
			key: 'debug'
			val: if var_gd.clone().is_array() {
				var_gd.array_get(rt.new_string('GD Version'))
			} else {
				rt.new_string('not available')
			}
		},
	]))
	mut var_gd_image_formats := rt.new_array()
	mut var_gd_supported_formats := {
		'GIF Create': 'GIF'
		'JPEG':       'JPEG'
		'PNG':        'PNG'
		'WebP':       'WebP'
		'BMP':        'BMP'
		'AVIF':       'AVIF'
		'HEIF':       'HEIF'
		'TIFF':       'TIFF'
		'XPM':        'XPM'
	}
	for var_format_key, var_format in var_gd_supported_formats {
		mut var_index := rt.new_string(format_key + ' Support')
		if var_gd.array_isset(var_index) && rt.is_true(var_gd.array_get(var_index)) {
			var_gd_image_formats.clone().array_push(rt.new_string(format))
		}
	}
	if !(!rt.is_true(var_gd_image_formats)) {
		var_fields.array_set('gd_formats', rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('GD supported file formats'),
			]) },
			rt.ArrayItem{ key: 'value', val: rt.call_function('implode', [
				rt.new_string(', '),
				var_gd_image_formats.clone(),
			]) },
		]))
	}
	if rt.is_true(rt.call_function('function_exists', [rt.new_string('exec')])) {
		mut var_gs := rt.call_function('exec', [rt.new_string('gs --version')])
		if !rt.is_true(var_gs) {
			var_gs = var_not_available.clone()
			mut var_gs_debug := rt.new_string('not available')
		} else {
			var_gs_debug = var_gs.clone()
		}
	} else {
		var_gs = rt.call_function('__', [
			rt.new_string('Unable to determine if Ghostscript is installed'),
		])
		var_gs_debug = rt.new_string('unknown')
	}
	var_fields.array_set('ghostscript_version', rt.create_array([
		rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
			rt.new_string('Ghostscript version'),
		]) },
		rt.ArrayItem{ key: 'value', val: var_gs },
		rt.ArrayItem{ key: 'debug', val: var_gs_debug },
	]))
	return rt.create_array([
		rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
			rt.new_string('Media Handling'),
		]) },
		rt.ArrayItem{ key: 'fields', val: var_fields },
	])
}

fn Class_WP_Debug_Data.get_wp_mu_plugins() rt.PhpVal {
	mut var_mu_plugins := rt.call_function('get_mu_plugins', []rt.PhpVal{})
	mut var_fields := rt.new_array()
	mut iter_5 := var_mu_plugins.iterator()
	for {
		item_5 := iter_5.next() or { break }
		mut var_plugin := item_5.val
		mut var_plugin_path := item_5.key
		mut var_plugin_version := var_plugin.array_get(rt.new_string('Version'))
		mut var_plugin_author := var_plugin.array_get(rt.new_string('Author'))
		mut var_plugin_version_string := rt.call_function('__', [
			rt.new_string('No version or author information is available.'),
		])
		mut var_plugin_version_string_debug :=
			rt.new_string('author: (undefined), version: (undefined)')
		if !(!rt.is_true(var_plugin_version)) && !(!rt.is_true(var_plugin_author)) {
			var_plugin_version_string = rt.call_function('sprintf', [
				rt.call_function('__', [rt.new_string('Version %1$s by %2$s')]),
				var_plugin_version.clone(),
				var_plugin_author.clone(),
			])
			var_plugin_version_string_debug = rt.call_function('sprintf', [
				rt.new_string('version: %s, author: %s'),
				var_plugin_version.clone(),
				var_plugin_author.clone(),
			])
		} else {
			if !(!rt.is_true(var_plugin_author)) {
				var_plugin_version_string = rt.call_function('sprintf', [
					rt.call_function('__', [rt.new_string('By %s')]),
					var_plugin_author.clone(),
				])
				var_plugin_version_string_debug = rt.call_function('sprintf', [
					rt.new_string('author: %s, version: (undefined)'),
					var_plugin_author.clone(),
				])
			}
			if !(!rt.is_true(var_plugin_version)) {
				var_plugin_version_string = rt.call_function('sprintf', [
					rt.call_function('__', [rt.new_string('Version %s')]),
					var_plugin_version.clone(),
				])
				var_plugin_version_string_debug = rt.call_function('sprintf', [
					rt.new_string('author: (undefined), version: %s'),
					var_plugin_version.clone(),
				])
			}
		}
		var_fields.array_set(rt.call_function('sanitize_text_field', [
			var_plugin.array_get(rt.new_string('Name')),
		]), rt.create_array([
			rt.ArrayItem{ key: 'label', val: var_plugin.array_get(rt.new_string('Name')) },
			rt.ArrayItem{ key: 'value', val: var_plugin_version_string },
			rt.ArrayItem{ key: 'debug', val: var_plugin_version_string_debug },
		]))
	}
	return rt.create_array([
		rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
			rt.new_string('Must Use Plugins'),
		]) },
		rt.ArrayItem{ key: 'show_count', val: true },
		rt.ArrayItem{ key: 'fields', val: var_fields },
	])
}

fn Class_WP_Debug_Data.get_wp_paths_sizes() rt.PhpVal {
	if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) {
		return rt.new_null()
	}
	mut var_loading := rt.call_function('__', [rt.new_string('Loading&hellip;')])
	mut var_fields := rt.create_array([
		rt.ArrayItem{ key: 'wordpress_path', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('WordPress directory location'),
			]) },
			rt.ArrayItem{ key: 'value', val: rt.call_function('untrailingslashit', [
				rt.get_constant('ABSPATH'),
			]) },
		]) },
		rt.ArrayItem{ key: 'wordpress_size', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('WordPress directory size'),
			]) },
			rt.ArrayItem{ key: 'value', val: var_loading },
			rt.ArrayItem{ key: 'debug', val: 'loading...' },
		]) },
		rt.ArrayItem{ key: 'uploads_path', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('Uploads directory location'),
			]) },
			rt.ArrayItem{
				key: 'value'
				val: rt.call_function('wp_upload_dir', []rt.PhpVal{}).array_get(rt.new_string('basedir'))
			},
		]) },
		rt.ArrayItem{ key: 'uploads_size', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('Uploads directory size'),
			]) },
			rt.ArrayItem{ key: 'value', val: var_loading },
			rt.ArrayItem{ key: 'debug', val: 'loading...' },
		]) },
		rt.ArrayItem{ key: 'themes_path', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('Themes directory location'),
			]) },
			rt.ArrayItem{ key: 'value', val: rt.call_function('get_theme_root', []rt.PhpVal{}) },
		]) },
		rt.ArrayItem{ key: 'themes_size', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('Themes directory size'),
			]) },
			rt.ArrayItem{ key: 'value', val: var_loading },
			rt.ArrayItem{ key: 'debug', val: 'loading...' },
		]) },
		rt.ArrayItem{ key: 'plugins_path', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('Plugins directory location'),
			]) },
			rt.ArrayItem{ key: 'value', val: rt.get_constant('WP_PLUGIN_DIR') },
		]) },
		rt.ArrayItem{ key: 'plugins_size', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('Plugins directory size'),
			]) },
			rt.ArrayItem{ key: 'value', val: var_loading },
			rt.ArrayItem{ key: 'debug', val: 'loading...' },
		]) },
		rt.ArrayItem{ key: 'fonts_path', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('Fonts directory location'),
			]) },
			rt.ArrayItem{
				key: 'value'
				val: rt.call_function('wp_get_font_dir', []rt.PhpVal{}).array_get(rt.new_string('basedir'))
			},
		]) },
		rt.ArrayItem{ key: 'fonts_size', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('Fonts directory size'),
			]) },
			rt.ArrayItem{ key: 'value', val: var_loading },
			rt.ArrayItem{ key: 'debug', val: 'loading...' },
		]) },
		rt.ArrayItem{ key: 'database_size', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('Database size'),
			]) },
			rt.ArrayItem{ key: 'value', val: var_loading },
			rt.ArrayItem{ key: 'debug', val: 'loading...' },
		]) },
		rt.ArrayItem{ key: 'total_size', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('Total installation size'),
			]) },
			rt.ArrayItem{ key: 'value', val: var_loading },
			rt.ArrayItem{ key: 'debug', val: 'loading...' },
		]) },
	])
	return rt.create_array([
		rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
			rt.new_string('Directories and Sizes'),
		]) },
		rt.ArrayItem{ key: 'fields', val: var_fields },
	])
}

fn Class_WP_Debug_Data.get_wp_plugins_active() rt.PhpVal {
	return rt.create_array([
		rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
			rt.new_string('Active Plugins'),
		]) },
		rt.ArrayItem{ key: 'show_count', val: true },
		rt.ArrayItem{
			key: 'fields'
			val: Class_WP_Debug_Data.get_wp_plugins_raw_data().array_get(rt.new_string('wp-plugins-active'))
		},
	])
}

fn Class_WP_Debug_Data.get_wp_plugins_inactive() rt.PhpVal {
	return rt.create_array([
		rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
			rt.new_string('Inactive Plugins'),
		]) },
		rt.ArrayItem{ key: 'show_count', val: true },
		rt.ArrayItem{
			key: 'fields'
			val: Class_WP_Debug_Data.get_wp_plugins_raw_data().array_get(rt.new_string('wp-plugins-inactive'))
		},
	])
}

fn Class_WP_Debug_Data.get_wp_plugins_raw_data() rt.PhpVal {
	mut var_plugins := rt.call_function('get_plugins', []rt.PhpVal{})
	mut var_plugin_updates := rt.call_function('get_plugin_updates', []rt.PhpVal{})
	mut var_transient := rt.call_function('get_site_transient', [
		rt.new_string('update_plugins'),
	])
	mut var_auto_updates := rt.new_array()
	mut var_fields := rt.create_array([
		rt.ArrayItem{ key: 'wp-plugins-active', val: rt.new_array() },
		rt.ArrayItem{ key: 'wp-plugins-inactive', val: rt.new_array() },
	])
	mut var_auto_updates_enabled := rt.call_function('wp_is_auto_update_enabled_for_type', [
		rt.new_string('plugin'),
	])
	if rt.is_true(var_auto_updates_enabled) {
		var_auto_updates = rt.cast_array(rt.call_function('get_site_option', [
			rt.new_string('auto_update_plugins'),
			rt.new_array(),
		]))
	}
	mut iter_6 := var_plugins.iterator()
	for {
		item_6 := iter_6.next() or { break }
		mut var_plugin := item_6.val
		mut var_plugin_path := item_6.key
		mut var_plugin_part := rt.new_string((if rt.is_true(rt.call_function('is_plugin_active', [
			var_plugin_path.clone(),
		]))
		{ 'wp-plugins-active' } else { 'wp-plugins-inactive' }).str())
		mut var_plugin_version := var_plugin.array_get(rt.new_string('Version'))
		mut var_plugin_author := var_plugin.array_get(rt.new_string('Author'))
		mut var_plugin_version_string := rt.call_function('__', [
			rt.new_string('No version or author information is available.'),
		])
		mut var_plugin_version_string_debug :=
			rt.new_string('author: (undefined), version: (undefined)')
		if !(!rt.is_true(var_plugin_version)) && !(!rt.is_true(var_plugin_author)) {
			var_plugin_version_string = rt.call_function('sprintf', [
				rt.call_function('__', [rt.new_string('Version %1$s by %2$s')]),
				var_plugin_version.clone(),
				var_plugin_author.clone(),
			])
			var_plugin_version_string_debug = rt.call_function('sprintf', [
				rt.new_string('version: %s, author: %s'),
				var_plugin_version.clone(),
				var_plugin_author.clone(),
			])
		} else {
			if !(!rt.is_true(var_plugin_author)) {
				var_plugin_version_string = rt.call_function('sprintf', [
					rt.call_function('__', [rt.new_string('By %s')]),
					var_plugin_author.clone(),
				])
				var_plugin_version_string_debug = rt.call_function('sprintf', [
					rt.new_string('author: %s, version: (undefined)'),
					var_plugin_author.clone(),
				])
			}
			if !(!rt.is_true(var_plugin_version)) {
				var_plugin_version_string = rt.call_function('sprintf', [
					rt.call_function('__', [rt.new_string('Version %s')]),
					var_plugin_version.clone(),
				])
				var_plugin_version_string_debug = rt.call_function('sprintf', [
					rt.new_string('author: (undefined), version: %s'),
					var_plugin_version.clone(),
				])
			}
		}
		if rt.is_true(rt.new_bool(var_plugin_updates.clone().array_isset(var_plugin_path.clone()))) {
			var_plugin_version_string = rt.concat(var_plugin_version_string,
				rt.new_string(' ' +(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('(Latest version: %s)')]), rt.get_property(rt.get_property(var_plugin_updates.array_get(var_plugin_path), 'update'), 'new_version')])).str()))
			var_plugin_version_string_debug = rt.concat(var_plugin_version_string_debug, rt.call_function('sprintf', [
				rt.new_string(' (latest version: %s)'),
				rt.get_property(rt.get_property(var_plugin_updates.array_get(var_plugin_path),
					'update'), 'new_version'),
			]))
		}
		if rt.is_true(var_auto_updates_enabled) {
			if rt.get_property(var_transient, 'response').array_isset(var_plugin_path) {
				mut var_item :=
					rt.get_property(var_transient, 'response').array_get(var_plugin_path)
			} else if rt.get_property(var_transient, 'no_update').array_isset(var_plugin_path) {
				var_item = rt.get_property(var_transient, 'no_update').array_get(var_plugin_path)
			} else {
				var_item = rt.create_array([
					rt.ArrayItem{ key: 'id', val: var_plugin_path },
					rt.ArrayItem{ key: 'slug', val: '' },
					rt.ArrayItem{ key: 'plugin', val: var_plugin_path },
					rt.ArrayItem{ key: 'new_version', val: '' },
					rt.ArrayItem{ key: 'url', val: '' },
					rt.ArrayItem{ key: 'package', val: '' },
					rt.ArrayItem{ key: 'icons', val: rt.new_array() },
					rt.ArrayItem{ key: 'banners', val: rt.new_array() },
					rt.ArrayItem{ key: 'banners_rtl', val: rt.new_array() },
					rt.ArrayItem{ key: 'tested', val: '' },
					rt.ArrayItem{ key: 'requires_php', val: '' },
					rt.ArrayItem{ key: 'compatibility', val: create_stdclass() },
				])
				var_item = rt.call_function('wp_parse_args', [
					var_plugin.clone(), var_item.clone()])
			}
			mut var_auto_update_forced := rt.call_function('wp_is_auto_update_forced_for_item', [
				rt.new_string('plugin'),
				rt.new_null(),
				rt.array_to_object(var_item),
			])
			if !(var_auto_update_forced.clone().is_null()) {
				mut var_enabled := var_auto_update_forced.clone()
			} else {
				var_enabled = rt.call_function('in_array', [var_plugin_path.clone(),
					var_auto_updates.clone(), rt.new_bool(true)])
			}
			if rt.is_true(var_enabled) {
				mut var_auto_updates_string := rt.call_function('__', [
					rt.new_string('Auto-updates enabled'),
				])
			} else {
				var_auto_updates_string = rt.call_function('__', [
					rt.new_string('Auto-updates disabled'),
				])
			}
			var_auto_updates_string = rt.call_function('apply_filters', [
				rt.new_string('plugin_auto_update_debug_string'),
				var_auto_updates_string.clone(),
				var_plugin_path.clone(),
				var_plugin.clone(),
				var_enabled.clone(),
			])
			var_plugin_version_string = rt.concat(var_plugin_version_string, rt.new_string(' | ' +
				var_auto_updates_string.str()))
			var_plugin_version_string_debug = rt.concat(var_plugin_version_string_debug, rt.new_string(
				', ' + var_auto_updates_string.str()))
		}
		var_fields.array_get_mut(var_plugin_part).array_set(rt.call_function('sanitize_text_field', [
			var_plugin.array_get(rt.new_string('Name')),
		]), rt.create_array([
			rt.ArrayItem{ key: 'label', val: var_plugin.array_get(rt.new_string('Name')) },
			rt.ArrayItem{ key: 'value', val: var_plugin_version_string },
			rt.ArrayItem{ key: 'debug', val: var_plugin_version_string_debug },
		]))
	}
	return var_fields.clone()
}

fn Class_WP_Debug_Data.get_wp_active_theme() rt.PhpVal {
	mut var__wp_theme_features := rt.new_null()
	mut var_theme_features := rt.new_array()
	if !(!rt.is_true(var__wp_theme_features)) {
		mut iter_7 := var__wp_theme_features.iterator()
		for {
			item_7 := iter_7.next() or { break }
			mut var_options := item_7.val
			mut var_feature := item_7.key
			var_theme_features << var_feature.clone()
		}
	}
	mut var_active_theme := rt.call_function('wp_get_theme', []rt.PhpVal{})
	mut var_theme_updates := rt.call_function('get_theme_updates', []rt.PhpVal{})
	mut var_transient := rt.call_function('get_site_transient', [
		rt.new_string('update_themes'),
	])
	mut var_active_theme_version := rt.get_property(var_active_theme, 'version')
	mut var_active_theme_version_debug := var_active_theme_version.clone()
	mut var_auto_updates := rt.new_array()
	mut var_auto_updates_enabled := rt.call_function('wp_is_auto_update_enabled_for_type', [
		rt.new_string('theme'),
	])
	if rt.is_true(var_auto_updates_enabled) {
		var_auto_updates = rt.cast_array(rt.call_function('get_site_option', [
			rt.new_string('auto_update_themes'),
			rt.new_array(),
		]))
	}
	if rt.is_true(rt.new_bool(var_theme_updates.clone().array_isset(rt.get_property(var_active_theme,
		'stylesheet'))))
	{
		mut var_theme_update_new_version := rt.get_property(var_theme_updates.array_get(rt.get_property(var_active_theme,
			'stylesheet')), 'update').array_get(rt.new_string('new_version'))
		var_active_theme_version = rt.concat(var_active_theme_version,
			rt.new_string(' ' +(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('(Latest version: %s)')]), var_theme_update_new_version.clone()])).str()))
		var_active_theme_version_debug = rt.concat(var_active_theme_version_debug, rt.call_function('sprintf', [
			rt.new_string(' (latest version: %s)'),
			var_theme_update_new_version.clone(),
		]))
	}
	mut var_active_theme_author_uri := rt.call_method(var_active_theme, 'display', [
		rt.new_string('AuthorURI'),
	])
	if rt.is_true(rt.get_property(var_active_theme, 'parent_theme')) {
		mut var_active_theme_parent_theme := rt.call_function('sprintf', [
			rt.call_function('__', [rt.new_string('%1$s (%2$s)')]),
			rt.get_property(var_active_theme, 'parent_theme'),
			rt.get_property(var_active_theme, 'template'),
		])
		mut var_active_theme_parent_theme_debug := rt.call_function('sprintf', [
			rt.new_string('%s (%s)'),
			rt.get_property(var_active_theme, 'parent_theme'),
			rt.get_property(var_active_theme, 'template'),
		])
	} else {
		var_active_theme_parent_theme = rt.call_function('__', [
			rt.new_string('None')])
		var_active_theme_parent_theme_debug = rt.new_string('none')
	}
	mut var_fields := rt.create_array([
		rt.ArrayItem{ key: 'name', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('Name'),
			]) },
			rt.ArrayItem{ key: 'value', val: rt.call_function('sprintf', [
				rt.call_function('__', [rt.new_string('%1$s (%2$s)')]),
				rt.get_property(var_active_theme, 'name'),
				rt.get_property(var_active_theme, 'stylesheet'),
			]) },
		]) },
		rt.ArrayItem{ key: 'version', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('Version'),
			]) },
			rt.ArrayItem{ key: 'value', val: var_active_theme_version },
			rt.ArrayItem{ key: 'debug', val: var_active_theme_version_debug },
		]) },
		rt.ArrayItem{ key: 'author', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('Author'),
			]) },
			rt.ArrayItem{ key: 'value', val: rt.call_function('wp_kses', [
				rt.get_property(var_active_theme, 'author'),
				rt.new_array(),
			]) },
		]) },
		rt.ArrayItem{ key: 'author_website', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('Author website'),
			]) },
			rt.ArrayItem{
				key: 'value'
				val: if rt.is_true(var_active_theme_author_uri) { var_active_theme_author_uri } else { rt.call_function('__', [
						rt.new_string('Undefined'),
					]) }
			},
			rt.ArrayItem{
				key: 'debug'
				val: if rt.is_true(var_active_theme_author_uri) {
					var_active_theme_author_uri
				} else {
					rt.new_string('(undefined)')
				}
			},
		]) },
		rt.ArrayItem{ key: 'parent_theme', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('Parent theme'),
			]) },
			rt.ArrayItem{ key: 'value', val: var_active_theme_parent_theme },
			rt.ArrayItem{ key: 'debug', val: var_active_theme_parent_theme_debug },
		]) },
		rt.ArrayItem{ key: 'theme_features', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('Theme features'),
			]) },
			rt.ArrayItem{ key: 'value', val: rt.call_function('implode', [
				rt.new_string(', '),
				rt.create_array_from_list(var_theme_features),
			]) },
		]) },
		rt.ArrayItem{ key: 'theme_path', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('Theme directory location'),
			]) },
			rt.ArrayItem{ key: 'value', val: rt.call_function('get_stylesheet_directory',
				[]rt.PhpVal{}) },
		]) },
	])
	if rt.is_true(var_auto_updates_enabled) {
		if rt.get_property(var_transient, 'response').array_isset(rt.get_property(var_active_theme,
			'stylesheet'))
		{
			mut var_item := rt.get_property(var_transient, 'response').array_get(rt.get_property(var_active_theme,
				'stylesheet'))
		} else if rt.get_property(var_transient, 'no_update').array_isset(rt.get_property(var_active_theme,
			'stylesheet'))
		{
			var_item = rt.get_property(var_transient, 'no_update').array_get(rt.get_property(var_active_theme,
				'stylesheet'))
		} else {
			var_item = rt.create_array([
				rt.ArrayItem{ key: 'theme', val: rt.get_property(var_active_theme, 'stylesheet') },
				rt.ArrayItem{ key: 'new_version', val: rt.get_property(var_active_theme, 'version') },
				rt.ArrayItem{ key: 'url', val: '' },
				rt.ArrayItem{ key: 'package', val: '' },
				rt.ArrayItem{ key: 'requires', val: '' },
				rt.ArrayItem{ key: 'requires_php', val: '' },
			])
		}
		mut var_auto_update_forced := rt.call_function('wp_is_auto_update_forced_for_item', [
			rt.new_string('theme'),
			rt.new_null(),
			rt.array_to_object(var_item),
		])
		if !(var_auto_update_forced.clone().is_null()) {
			mut var_enabled := var_auto_update_forced.clone()
		} else {
			var_enabled = rt.call_function('in_array', [
				rt.get_property(var_active_theme, 'stylesheet'),
				var_auto_updates.clone(),
				rt.new_bool(true),
			])
		}
		if rt.is_true(var_enabled) {
			mut var_auto_updates_string := rt.call_function('__', [
				rt.new_string('Enabled'),
			])
		} else {
			var_auto_updates_string = rt.call_function('__', [
				rt.new_string('Disabled')])
		}
		var_auto_updates_string = rt.call_function('apply_filters', [
			rt.new_string('theme_auto_update_debug_string'),
			var_auto_updates_string.clone(),
			var_active_theme.clone(),
			var_enabled.clone(),
		])
		var_fields.array_set('auto_update', rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('Auto-updates'),
			]) },
			rt.ArrayItem{ key: 'value', val: var_auto_updates_string },
			rt.ArrayItem{ key: 'debug', val: var_auto_updates_string },
		]))
	}
	return rt.create_array([
		rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
			rt.new_string('Active Theme'),
		]) },
		rt.ArrayItem{ key: 'fields', val: var_fields },
	])
}

fn Class_WP_Debug_Data.get_wp_parent_theme() rt.PhpVal {
	mut var_theme_updates := rt.call_function('get_theme_updates', []rt.PhpVal{})
	mut var_transient := rt.call_function('get_site_transient', [
		rt.new_string('update_themes'),
	])
	mut var_auto_updates := rt.new_array()
	mut var_auto_updates_enabled := rt.call_function('wp_is_auto_update_enabled_for_type', [
		rt.new_string('theme'),
	])
	if rt.is_true(var_auto_updates_enabled) {
		var_auto_updates = rt.cast_array(rt.call_function('get_site_option', [
			rt.new_string('auto_update_themes'),
			rt.new_array(),
		]))
	}
	mut var_active_theme := rt.call_function('wp_get_theme', []rt.PhpVal{})
	mut var_parent_theme := rt.call_method(var_active_theme, 'parent', []rt.PhpVal{})
	mut var_fields := rt.new_array()
	if rt.is_true(var_parent_theme) {
		mut var_parent_theme_version := rt.get_property(var_parent_theme, 'version')
		mut var_parent_theme_version_debug := var_parent_theme_version.clone()
		if rt.is_true(rt.new_bool(var_theme_updates.clone().array_isset(rt.get_property(var_parent_theme,
			'stylesheet'))))
		{
			mut var_parent_theme_update_new_version := rt.get_property(var_theme_updates.array_get(rt.get_property(var_parent_theme,
				'stylesheet')), 'update').array_get(rt.new_string('new_version'))
			var_parent_theme_version = rt.concat(var_parent_theme_version,
				rt.new_string(' ' +(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('(Latest version: %s)')]), var_parent_theme_update_new_version.clone()])).str()))
			var_parent_theme_version_debug = rt.concat(var_parent_theme_version_debug, rt.call_function('sprintf', [
				rt.new_string(' (latest version: %s)'),
				var_parent_theme_update_new_version.clone(),
			]))
		}
		mut var_parent_theme_author_uri := rt.call_method(var_parent_theme, 'display', [
			rt.new_string('AuthorURI'),
		])
		var_fields = rt.create_array([
			rt.ArrayItem{ key: 'name', val: rt.create_array([
				rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
					rt.new_string('Name'),
				]) },
				rt.ArrayItem{ key: 'value', val: rt.call_function('sprintf', [
					rt.call_function('__', [rt.new_string('%1$s (%2$s)')]),
					rt.get_property(var_parent_theme, 'name'),
					rt.get_property(var_parent_theme, 'stylesheet'),
				]) },
			]) },
			rt.ArrayItem{ key: 'version', val: rt.create_array([
				rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
					rt.new_string('Version'),
				]) },
				rt.ArrayItem{ key: 'value', val: var_parent_theme_version },
				rt.ArrayItem{ key: 'debug', val: var_parent_theme_version_debug },
			]) },
			rt.ArrayItem{ key: 'author', val: rt.create_array([
				rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
					rt.new_string('Author'),
				]) },
				rt.ArrayItem{ key: 'value', val: rt.call_function('wp_kses', [
					rt.get_property(var_parent_theme, 'author'),
					rt.new_array(),
				]) },
			]) },
			rt.ArrayItem{ key: 'author_website', val: rt.create_array([
				rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
					rt.new_string('Author website'),
				]) },
				rt.ArrayItem{
					key: 'value'
					val: if rt.is_true(var_parent_theme_author_uri) { var_parent_theme_author_uri } else { rt.call_function('__', [
							rt.new_string('Undefined'),
						]) }
				},
				rt.ArrayItem{
					key: 'debug'
					val: if rt.is_true(var_parent_theme_author_uri) {
						var_parent_theme_author_uri
					} else {
						rt.new_string('(undefined)')
					}
				},
			]) },
			rt.ArrayItem{ key: 'theme_path', val: rt.create_array([
				rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
					rt.new_string('Theme directory location'),
				]) },
				rt.ArrayItem{ key: 'value', val: rt.call_function('get_template_directory',
					[]rt.PhpVal{}) },
			]) },
		])
		if rt.is_true(var_auto_updates_enabled) {
			if rt.get_property(var_transient, 'response').array_isset(rt.get_property(var_parent_theme,
				'stylesheet'))
			{
				mut var_item := rt.get_property(var_transient, 'response').array_get(rt.get_property(var_parent_theme,
					'stylesheet'))
			} else if rt.get_property(var_transient, 'no_update').array_isset(rt.get_property(var_parent_theme,
				'stylesheet'))
			{
				var_item = rt.get_property(var_transient, 'no_update').array_get(rt.get_property(var_parent_theme,
					'stylesheet'))
			} else {
				var_item = rt.create_array([
					rt.ArrayItem{ key: 'theme', val: rt.get_property(var_parent_theme, 'stylesheet') },
					rt.ArrayItem{ key: 'new_version', val: rt.get_property(var_parent_theme,
						'version') },
					rt.ArrayItem{ key: 'url', val: '' },
					rt.ArrayItem{ key: 'package', val: '' },
					rt.ArrayItem{ key: 'requires', val: '' },
					rt.ArrayItem{ key: 'requires_php', val: '' },
				])
			}
			mut var_auto_update_forced := rt.call_function('wp_is_auto_update_forced_for_item', [
				rt.new_string('theme'),
				rt.new_null(),
				rt.array_to_object(var_item),
			])
			if !(var_auto_update_forced.clone().is_null()) {
				mut var_enabled := var_auto_update_forced.clone()
			} else {
				var_enabled = rt.call_function('in_array', [
					rt.get_property(var_parent_theme, 'stylesheet'),
					var_auto_updates.clone(),
					rt.new_bool(true),
				])
			}
			if rt.is_true(var_enabled) {
				mut var_parent_theme_auto_update_string := rt.call_function('__', [
					rt.new_string('Enabled'),
				])
			} else {
				var_parent_theme_auto_update_string = rt.call_function('__', [
					rt.new_string('Disabled'),
				])
			}
			var_parent_theme_auto_update_string = rt.call_function('apply_filters', [
				rt.new_string('theme_auto_update_debug_string'),
				var_parent_theme_auto_update_string.clone(),
				var_parent_theme.clone(),
				var_enabled.clone(),
			])
			var_fields.array_set('auto_update', rt.create_array([
				rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
					rt.new_string('Auto-update'),
				]) },
				rt.ArrayItem{ key: 'value', val: var_parent_theme_auto_update_string },
				rt.ArrayItem{ key: 'debug', val: var_parent_theme_auto_update_string },
			]))
		}
	}
	return rt.create_array([
		rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
			rt.new_string('Parent Theme'),
		]) },
		rt.ArrayItem{ key: 'fields', val: var_fields },
	])
}

fn Class_WP_Debug_Data.get_wp_themes_inactive() rt.PhpVal {
	mut var_active_theme := rt.call_function('wp_get_theme', []rt.PhpVal{})
	mut var_parent_theme := rt.call_method(var_active_theme, 'parent', []rt.PhpVal{})
	mut var_theme_updates := rt.call_function('get_theme_updates', []rt.PhpVal{})
	mut var_transient := rt.call_function('get_site_transient', [
		rt.new_string('update_themes'),
	])
	mut var_auto_updates := rt.new_array()
	mut var_auto_updates_enabled := rt.call_function('wp_is_auto_update_enabled_for_type', [
		rt.new_string('theme'),
	])
	if rt.is_true(var_auto_updates_enabled) {
		var_auto_updates = rt.cast_array(rt.call_function('get_site_option', [
			rt.new_string('auto_update_themes'),
			rt.new_array(),
		]))
	}
	mut var_all_themes := rt.call_function('wp_get_themes', []rt.PhpVal{})
	mut var_fields := rt.new_array()
	mut iter_8 := var_all_themes.iterator()
	for {
		item_8 := iter_8.next() or { break }
		mut var_theme := item_8.val
		mut var_theme_slug := item_8.key
		if rt.is_true(rt.identical(rt.get_property(var_active_theme, 'stylesheet'), var_theme_slug)) {
			continue
		}
		if !(!rt.is_true(var_parent_theme))
			&& rt.is_true(rt.identical(rt.get_property(var_parent_theme, 'stylesheet'), var_theme_slug)) {
			continue
		}
		mut var_theme_version := rt.get_property(var_theme, 'version')
		mut var_theme_author := rt.get_property(var_theme, 'author')
		var_theme_author = rt.call_function('wp_kses', [var_theme_author.clone(),
			rt.new_array()])
		mut var_theme_version_string := rt.call_function('__', [
			rt.new_string('No version or author information is available.'),
		])
		mut var_theme_version_string_debug := rt.new_string('undefined')
		if !(!rt.is_true(var_theme_version)) && !(!rt.is_true(var_theme_author)) {
			var_theme_version_string = rt.call_function('sprintf', [
				rt.call_function('__', [rt.new_string('Version %1$s by %2$s')]),
				var_theme_version.clone(),
				var_theme_author.clone(),
			])
			var_theme_version_string_debug = rt.call_function('sprintf', [
				rt.new_string('version: %s, author: %s'),
				var_theme_version.clone(),
				var_theme_author.clone(),
			])
		} else {
			if !(!rt.is_true(var_theme_author)) {
				var_theme_version_string = rt.call_function('sprintf', [
					rt.call_function('__', [rt.new_string('By %s')]),
					var_theme_author.clone(),
				])
				var_theme_version_string_debug = rt.call_function('sprintf', [
					rt.new_string('author: %s, version: (undefined)'),
					var_theme_author.clone(),
				])
			}
			if !(!rt.is_true(var_theme_version)) {
				var_theme_version_string = rt.call_function('sprintf', [
					rt.call_function('__', [rt.new_string('Version %s')]),
					var_theme_version.clone(),
				])
				var_theme_version_string_debug = rt.call_function('sprintf', [
					rt.new_string('author: (undefined), version: %s'),
					var_theme_version.clone(),
				])
			}
		}
		if rt.is_true(rt.new_bool(var_theme_updates.clone().array_isset(var_theme_slug.clone()))) {
			var_theme_version_string = rt.concat(var_theme_version_string,
				rt.new_string(' ' +(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('(Latest version: %s)')]), rt.get_property(var_theme_updates.array_get(var_theme_slug), 'update').array_get(rt.new_string('new_version'))])).str()))
			var_theme_version_string_debug = rt.concat(var_theme_version_string_debug, rt.call_function('sprintf', [
				rt.new_string(' (latest version: %s)'),
				rt.get_property(var_theme_updates.array_get(var_theme_slug), 'update').array_get(rt.new_string('new_version')),
			]))
		}
		if rt.is_true(var_auto_updates_enabled) {
			if rt.get_property(var_transient, 'response').array_isset(var_theme_slug) {
				mut var_item := rt.get_property(var_transient, 'response').array_get(var_theme_slug)
			} else if rt.get_property(var_transient, 'no_update').array_isset(var_theme_slug) {
				var_item = rt.get_property(var_transient, 'no_update').array_get(var_theme_slug)
			} else {
				var_item = rt.create_array([
					rt.ArrayItem{ key: 'theme', val: var_theme_slug },
					rt.ArrayItem{ key: 'new_version', val: rt.get_property(var_theme, 'version') },
					rt.ArrayItem{ key: 'url', val: '' },
					rt.ArrayItem{ key: 'package', val: '' },
					rt.ArrayItem{ key: 'requires', val: '' },
					rt.ArrayItem{ key: 'requires_php', val: '' },
				])
			}
			mut var_auto_update_forced := rt.call_function('wp_is_auto_update_forced_for_item', [
				rt.new_string('theme'),
				rt.new_null(),
				rt.array_to_object(var_item),
			])
			if !(var_auto_update_forced.clone().is_null()) {
				mut var_enabled := var_auto_update_forced.clone()
			} else {
				var_enabled = rt.call_function('in_array', [var_theme_slug.clone(),
					var_auto_updates.clone(), rt.new_bool(true)])
			}
			if rt.is_true(var_enabled) {
				mut var_auto_updates_string := rt.call_function('__', [
					rt.new_string('Auto-updates enabled'),
				])
			} else {
				var_auto_updates_string = rt.call_function('__', [
					rt.new_string('Auto-updates disabled'),
				])
			}
			var_auto_updates_string = rt.call_function('apply_filters', [
				rt.new_string('theme_auto_update_debug_string'),
				var_auto_updates_string.clone(),
				var_theme.clone(),
				var_enabled.clone(),
			])
			var_theme_version_string = rt.concat(var_theme_version_string, rt.new_string(' | ' +
				var_auto_updates_string.str()))
			var_theme_version_string_debug = rt.concat(var_theme_version_string_debug, rt.new_string(
				', ' + var_auto_updates_string.str()))
		}
		var_fields.array_set(rt.call_function('sanitize_text_field', [
			rt.get_property(var_theme, 'name'),
		]), rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('sprintf', [
				rt.call_function('__', [rt.new_string('%1$s (%2$s)')]),
				rt.get_property(var_theme, 'name'),
				var_theme_slug.clone(),
			]) },
			rt.ArrayItem{ key: 'value', val: var_theme_version_string },
			rt.ArrayItem{ key: 'debug', val: var_theme_version_string_debug },
		]))
	}
	return rt.create_array([
		rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
			rt.new_string('Inactive Themes'),
		]) },
		rt.ArrayItem{ key: 'show_count', val: true },
		rt.ArrayItem{ key: 'fields', val: var_fields },
	])
}

fn Class_WP_Debug_Data.get_wp_constants() rt.PhpVal {
	mut var_wp_debug_log_value := rt.call_function('__', [rt.new_string('Disabled')])
	if rt.is_true(rt.new_bool(rt.get_constant('WP_DEBUG_LOG').is_string())) {
		var_wp_debug_log_value = rt.get_constant('WP_DEBUG_LOG')
	} else if rt.is_true(rt.get_constant('WP_DEBUG_LOG')) {
		var_wp_debug_log_value = rt.call_function('__', [rt.new_string('Enabled')])
	}
	if rt.is_true(rt.call_function('defined', [rt.new_string('CONCATENATE_SCRIPTS')])) {
		mut var_concatenate_scripts := if rt.is_true(rt.get_constant('CONCATENATE_SCRIPTS')) { rt.call_function('__', [
				rt.new_string('Enabled'),
			]) } else { rt.call_function('__', [rt.new_string('Disabled')]) }
		mut var_concatenate_scripts_debug := rt.new_string((if rt.is_true(rt.get_constant('CONCATENATE_SCRIPTS')) {
			'true'
		} else {
			'false'
		}).str())
	} else {
		var_concatenate_scripts = rt.call_function('__', [rt.new_string('Undefined')])
		var_concatenate_scripts_debug = rt.new_string('undefined')
	}
	if rt.is_true(rt.call_function('defined', [rt.new_string('COMPRESS_SCRIPTS')])) {
		mut var_compress_scripts := if rt.is_true(rt.get_constant('COMPRESS_SCRIPTS')) { rt.call_function('__', [
				rt.new_string('Enabled'),
			]) } else { rt.call_function('__', [rt.new_string('Disabled')]) }
		mut var_compress_scripts_debug := rt.new_string((if rt.is_true(rt.get_constant('COMPRESS_SCRIPTS')) {
			'true'
		} else {
			'false'
		}).str())
	} else {
		var_compress_scripts = rt.call_function('__', [rt.new_string('Undefined')])
		var_compress_scripts_debug = rt.new_string('undefined')
	}
	if rt.is_true(rt.call_function('defined', [rt.new_string('COMPRESS_CSS')])) {
		mut var_compress_css := if rt.is_true(rt.get_constant('COMPRESS_CSS')) { rt.call_function('__', [
				rt.new_string('Enabled'),
			]) } else { rt.call_function('__', [rt.new_string('Disabled')]) }
		mut var_compress_css_debug := rt.new_string((if rt.is_true(rt.get_constant('COMPRESS_CSS')) {
			'true'
		} else {
			'false'
		}).str())
	} else {
		var_compress_css = rt.call_function('__', [rt.new_string('Undefined')])
		var_compress_css_debug = rt.new_string('undefined')
	}
	if rt.is_true(rt.call_function('defined', [rt.new_string('WP_ENVIRONMENT_TYPE')])) {
		mut var_wp_environment_type := if rt.is_true(rt.get_constant('WP_ENVIRONMENT_TYPE')) { rt.get_constant('WP_ENVIRONMENT_TYPE') } else { rt.call_function('__', [
				rt.new_string('Empty value'),
			]) }
		mut var_wp_environment_type_debug := rt.get_constant('WP_ENVIRONMENT_TYPE')
	} else {
		var_wp_environment_type = rt.call_function('__', [rt.new_string('Undefined')])
		var_wp_environment_type_debug = rt.new_string('undefined')
	}
	if rt.is_true(rt.call_function('defined', [rt.new_string('DB_COLLATE')])) {
		mut var_db_collate := if rt.is_true(rt.get_constant('DB_COLLATE')) { rt.get_constant('DB_COLLATE') } else { rt.call_function('__', [
				rt.new_string('Empty value'),
			]) }
		mut var_db_collate_debug := rt.get_constant('DB_COLLATE')
	} else {
		var_db_collate = rt.call_function('__', [rt.new_string('Undefined')])
		var_db_collate_debug = rt.new_string('undefined')
	}
	mut var_fields := rt.create_array([
		rt.ArrayItem{ key: 'ABSPATH', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: 'ABSPATH' },
			rt.ArrayItem{ key: 'value', val: rt.get_constant('ABSPATH') },
			rt.ArrayItem{ key: 'private', val: true },
		]) },
		rt.ArrayItem{ key: 'WP_HOME', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: 'WP_HOME' },
			rt.ArrayItem{
				key: 'value'
				val: if rt.is_true(rt.call_function('defined', [
					rt.new_string('WP_HOME'),
				]))
				{ rt.get_constant('WP_HOME') } else { rt.call_function('__', [
						rt.new_string('Undefined'),
					]) }
			},
			rt.ArrayItem{
				key: 'debug'
				val: if rt.is_true(rt.call_function('defined', [
					rt.new_string('WP_HOME'),
				]))
				{ rt.get_constant('WP_HOME') } else { rt.new_string('undefined') }
			},
		]) },
		rt.ArrayItem{ key: 'WP_SITEURL', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: 'WP_SITEURL' },
			rt.ArrayItem{
				key: 'value'
				val: if rt.is_true(rt.call_function('defined', [
					rt.new_string('WP_SITEURL'),
				]))
				{ rt.get_constant('WP_SITEURL') } else { rt.call_function('__', [
						rt.new_string('Undefined'),
					]) }
			},
			rt.ArrayItem{
				key: 'debug'
				val: if rt.is_true(rt.call_function('defined', [
					rt.new_string('WP_SITEURL'),
				]))
				{ rt.get_constant('WP_SITEURL') } else { rt.new_string('undefined') }
			},
		]) },
		rt.ArrayItem{ key: 'WP_CONTENT_DIR', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: 'WP_CONTENT_DIR' },
			rt.ArrayItem{ key: 'value', val: rt.get_constant('WP_CONTENT_DIR') },
		]) },
		rt.ArrayItem{ key: 'WP_PLUGIN_DIR', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: 'WP_PLUGIN_DIR' },
			rt.ArrayItem{ key: 'value', val: rt.get_constant('WP_PLUGIN_DIR') },
		]) },
		rt.ArrayItem{ key: 'WP_MEMORY_LIMIT', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: 'WP_MEMORY_LIMIT' },
			rt.ArrayItem{ key: 'value', val: rt.get_constant('WP_MEMORY_LIMIT') },
		]) },
		rt.ArrayItem{ key: 'WP_MAX_MEMORY_LIMIT', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: 'WP_MAX_MEMORY_LIMIT' },
			rt.ArrayItem{ key: 'value', val: rt.get_constant('WP_MAX_MEMORY_LIMIT') },
		]) },
		rt.ArrayItem{ key: 'WP_DEBUG', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: 'WP_DEBUG' },
			rt.ArrayItem{
				key: 'value'
				val: if rt.is_true(rt.get_constant('WP_DEBUG')) { rt.call_function('__', [
						rt.new_string('Enabled'),
					]) } else { rt.call_function('__', [
						rt.new_string('Disabled'),
					]) }
			},
			rt.ArrayItem{ key: 'debug', val: rt.get_constant('WP_DEBUG') },
		]) },
		rt.ArrayItem{ key: 'WP_DEBUG_DISPLAY', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: 'WP_DEBUG_DISPLAY' },
			rt.ArrayItem{
				key: 'value'
				val: if rt.is_true(rt.get_constant('WP_DEBUG_DISPLAY')) { rt.call_function('__', [
						rt.new_string('Enabled'),
					]) } else { rt.call_function('__', [
						rt.new_string('Disabled'),
					]) }
			},
			rt.ArrayItem{ key: 'debug', val: rt.get_constant('WP_DEBUG_DISPLAY') },
		]) },
		rt.ArrayItem{ key: 'WP_DEBUG_LOG', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: 'WP_DEBUG_LOG' },
			rt.ArrayItem{ key: 'value', val: var_wp_debug_log_value },
			rt.ArrayItem{ key: 'debug', val: rt.get_constant('WP_DEBUG_LOG') },
		]) },
		rt.ArrayItem{ key: 'SCRIPT_DEBUG', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: 'SCRIPT_DEBUG' },
			rt.ArrayItem{
				key: 'value'
				val: if rt.is_true(rt.get_constant('SCRIPT_DEBUG')) { rt.call_function('__', [
						rt.new_string('Enabled'),
					]) } else { rt.call_function('__', [
						rt.new_string('Disabled'),
					]) }
			},
			rt.ArrayItem{ key: 'debug', val: rt.get_constant('SCRIPT_DEBUG') },
		]) },
		rt.ArrayItem{ key: 'WP_CACHE', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: 'WP_CACHE' },
			rt.ArrayItem{
				key: 'value'
				val: if rt.is_true(rt.get_constant('WP_CACHE')) { rt.call_function('__', [
						rt.new_string('Enabled'),
					]) } else { rt.call_function('__', [
						rt.new_string('Disabled'),
					]) }
			},
			rt.ArrayItem{ key: 'debug', val: rt.get_constant('WP_CACHE') },
		]) },
		rt.ArrayItem{ key: 'CONCATENATE_SCRIPTS', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: 'CONCATENATE_SCRIPTS' },
			rt.ArrayItem{ key: 'value', val: var_concatenate_scripts },
			rt.ArrayItem{ key: 'debug', val: var_concatenate_scripts_debug },
		]) },
		rt.ArrayItem{ key: 'COMPRESS_SCRIPTS', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: 'COMPRESS_SCRIPTS' },
			rt.ArrayItem{ key: 'value', val: var_compress_scripts },
			rt.ArrayItem{ key: 'debug', val: var_compress_scripts_debug },
		]) },
		rt.ArrayItem{ key: 'COMPRESS_CSS', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: 'COMPRESS_CSS' },
			rt.ArrayItem{ key: 'value', val: var_compress_css },
			rt.ArrayItem{ key: 'debug', val: var_compress_css_debug },
		]) },
		rt.ArrayItem{ key: 'WP_ENVIRONMENT_TYPE', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: 'WP_ENVIRONMENT_TYPE' },
			rt.ArrayItem{ key: 'value', val: var_wp_environment_type },
			rt.ArrayItem{ key: 'debug', val: var_wp_environment_type_debug },
		]) },
		rt.ArrayItem{ key: 'WP_DEVELOPMENT_MODE', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: 'WP_DEVELOPMENT_MODE' },
			rt.ArrayItem{
				key: 'value'
				val: if rt.is_true(rt.get_constant('WP_DEVELOPMENT_MODE')) { rt.get_constant('WP_DEVELOPMENT_MODE') } else { rt.call_function('__', [
						rt.new_string('Disabled'),
					]) }
			},
			rt.ArrayItem{ key: 'debug', val: rt.get_constant('WP_DEVELOPMENT_MODE') },
		]) },
		rt.ArrayItem{ key: 'DB_CHARSET', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: 'DB_CHARSET' },
			rt.ArrayItem{
				key: 'value'
				val: if rt.is_true(rt.call_function('defined', [
					rt.new_string('DB_CHARSET'),
				]))
				{ rt.get_constant('DB_CHARSET') } else { rt.call_function('__', [
						rt.new_string('Undefined'),
					]) }
			},
			rt.ArrayItem{
				key: 'debug'
				val: if rt.is_true(rt.call_function('defined', [
					rt.new_string('DB_CHARSET'),
				]))
				{ rt.get_constant('DB_CHARSET') } else { rt.new_string('undefined') }
			},
		]) },
		rt.ArrayItem{ key: 'DB_COLLATE', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: 'DB_COLLATE' },
			rt.ArrayItem{ key: 'value', val: var_db_collate },
			rt.ArrayItem{ key: 'debug', val: var_db_collate_debug },
		]) },
		rt.ArrayItem{ key: 'EMPTY_TRASH_DAYS', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: 'EMPTY_TRASH_DAYS' },
			rt.ArrayItem{
				key: 'value'
				val: if rt.is_true(rt.get_constant('EMPTY_TRASH_DAYS')) { rt.get_constant('EMPTY_TRASH_DAYS') } else { rt.call_function('__', [
						rt.new_string('Empty value'),
					]) }
			},
			rt.ArrayItem{ key: 'debug', val: rt.get_constant('EMPTY_TRASH_DAYS') },
		]) },
	])
	return rt.create_array([
		rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
			rt.new_string('WordPress Constants'),
		]) },
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('These settings alter where and how parts of WordPress are loaded.'),
		]) },
		rt.ArrayItem{ key: 'fields', val: var_fields },
	])
}

fn Class_WP_Debug_Data.get_wp_database() rt.PhpVal {
	mut var_wpdb := rt.new_null()
	if rt.is_true(rt.new_bool(rt.get_property(var_wpdb, 'dbh').is_object())) {
		mut var_extension := rt.call_function('get_class', [
			rt.get_property(var_wpdb, 'dbh'),
		])
	} else {
		var_extension = rt.new_null()
	}
	mut var_server := rt.call_method(var_wpdb, 'get_var', [
		rt.new_string('SELECT VERSION()'),
	])
	mut var_client_version := rt.get_property(rt.get_property(var_wpdb, 'dbh'), 'client_info')
	mut var_fields := rt.create_array([
		rt.ArrayItem{ key: 'extension', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('Database Extension'),
			]) },
			rt.ArrayItem{ key: 'value', val: var_extension },
		]) },
		rt.ArrayItem{ key: 'server_version', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('Server version'),
			]) },
			rt.ArrayItem{ key: 'value', val: var_server },
		]) },
		rt.ArrayItem{ key: 'client_version', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('Client version'),
			]) },
			rt.ArrayItem{ key: 'value', val: var_client_version },
		]) },
		rt.ArrayItem{ key: 'database_user', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('Database username'),
			]) },
			rt.ArrayItem{ key: 'value', val: rt.get_property(var_wpdb, 'dbuser') },
			rt.ArrayItem{ key: 'private', val: true },
		]) },
		rt.ArrayItem{ key: 'database_host', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('Database host'),
			]) },
			rt.ArrayItem{ key: 'value', val: rt.get_property(var_wpdb, 'dbhost') },
			rt.ArrayItem{ key: 'private', val: true },
		]) },
		rt.ArrayItem{ key: 'database_name', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('Database name'),
			]) },
			rt.ArrayItem{ key: 'value', val: rt.get_property(var_wpdb, 'dbname') },
			rt.ArrayItem{ key: 'private', val: true },
		]) },
		rt.ArrayItem{ key: 'database_prefix', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('Table prefix'),
			]) },
			rt.ArrayItem{ key: 'value', val: rt.get_property(var_wpdb, 'prefix') },
			rt.ArrayItem{ key: 'private', val: true },
		]) },
		rt.ArrayItem{ key: 'database_charset', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('Database charset'),
			]) },
			rt.ArrayItem{ key: 'value', val: rt.get_property(var_wpdb, 'charset') },
			rt.ArrayItem{ key: 'private', val: true },
		]) },
		rt.ArrayItem{ key: 'database_collate', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('Database collation'),
			]) },
			rt.ArrayItem{ key: 'value', val: rt.get_property(var_wpdb, 'collate') },
			rt.ArrayItem{ key: 'private', val: true },
		]) },
		rt.ArrayItem{ key: 'max_allowed_packet', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('Max allowed packet size'),
			]) },
			rt.ArrayItem{
				key: 'value'
				val: Class_WP_Debug_Data.get_mysql_var(rt.new_string('max_allowed_packet'))
			},
		]) },
		rt.ArrayItem{ key: 'max_connections', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('Max connections number'),
			]) },
			rt.ArrayItem{
				key: 'value'
				val: Class_WP_Debug_Data.get_mysql_var(rt.new_string('max_connections'))
			},
		]) },
	])
	return rt.create_array([
		rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
			rt.new_string('Database'),
		]) },
		rt.ArrayItem{ key: 'fields', val: var_fields },
	])
}

fn Class_WP_Debug_Data.get_wp_filesystem() rt.PhpVal {
	mut var_upload_dir := rt.call_function('wp_upload_dir', []rt.PhpVal{})
	mut var_fonts_dir_exists := rt.call_function('file_exists', [
		rt.call_function('wp_get_font_dir', []rt.PhpVal{}).array_get(rt.new_string('basedir')),
	])
	mut var_is_writable_abspath := rt.call_function('wp_is_writable', [
		rt.get_constant('ABSPATH'),
	])
	mut var_is_writable_wp_content_dir := rt.call_function('wp_is_writable', [
		rt.get_constant('WP_CONTENT_DIR'),
	])
	mut var_is_writable_upload_dir := rt.call_function('wp_is_writable', [
		var_upload_dir.array_get(rt.new_string('basedir')),
	])
	mut var_is_writable_wp_plugin_dir := rt.call_function('wp_is_writable', [
		rt.get_constant('WP_PLUGIN_DIR'),
	])
	mut var_is_writable_template_directory := rt.call_function('wp_is_writable', [
		rt.call_function('get_theme_root', [
			rt.call_function('get_template', []rt.PhpVal{}),
		]),
	])
	mut var_is_writable_fonts_dir := if rt.is_true(var_fonts_dir_exists) { rt.call_function('wp_is_writable', [
			rt.call_function('wp_get_font_dir', []rt.PhpVal{}).array_get(rt.new_string('basedir')),
		]) } else { rt.new_bool(false) }
	mut var_fields := rt.create_array([
		rt.ArrayItem{ key: 'wordpress', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('The main WordPress directory'),
			]) },
			rt.ArrayItem{
				key: 'value'
				val: if rt.is_true(var_is_writable_abspath) { rt.call_function('__', [
						rt.new_string('Writable'),
					]) } else { rt.call_function('__', [
						rt.new_string('Not writable'),
					]) }
			},
			rt.ArrayItem{
				key: 'debug'
				val: if rt.is_true(var_is_writable_abspath) { 'writable' } else { 'not writable' }
			},
		]) },
		rt.ArrayItem{ key: 'wp-content', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('The wp-content directory'),
			]) },
			rt.ArrayItem{
				key: 'value'
				val: if rt.is_true(var_is_writable_wp_content_dir) { rt.call_function('__', [
						rt.new_string('Writable'),
					]) } else { rt.call_function('__', [
						rt.new_string('Not writable'),
					]) }
			},
			rt.ArrayItem{
				key: 'debug'
				val: if rt.is_true(var_is_writable_wp_content_dir) {
					'writable'
				} else {
					'not writable'
				}
			},
		]) },
		rt.ArrayItem{ key: 'uploads', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('The uploads directory'),
			]) },
			rt.ArrayItem{
				key: 'value'
				val: if rt.is_true(var_is_writable_upload_dir) { rt.call_function('__', [
						rt.new_string('Writable'),
					]) } else { rt.call_function('__', [
						rt.new_string('Not writable'),
					]) }
			},
			rt.ArrayItem{
				key: 'debug'
				val: if rt.is_true(var_is_writable_upload_dir) { 'writable' } else { 'not writable' }
			},
		]) },
		rt.ArrayItem{ key: 'plugins', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('The plugins directory'),
			]) },
			rt.ArrayItem{
				key: 'value'
				val: if rt.is_true(var_is_writable_wp_plugin_dir) { rt.call_function('__', [
						rt.new_string('Writable'),
					]) } else { rt.call_function('__', [
						rt.new_string('Not writable'),
					]) }
			},
			rt.ArrayItem{
				key: 'debug'
				val: if rt.is_true(var_is_writable_wp_plugin_dir) {
					'writable'
				} else {
					'not writable'
				}
			},
		]) },
		rt.ArrayItem{ key: 'themes', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('The themes directory'),
			]) },
			rt.ArrayItem{
				key: 'value'
				val: if rt.is_true(var_is_writable_template_directory) { rt.call_function('__', [
						rt.new_string('Writable'),
					]) } else { rt.call_function('__', [
						rt.new_string('Not writable'),
					]) }
			},
			rt.ArrayItem{
				key: 'debug'
				val: if rt.is_true(var_is_writable_template_directory) {
					'writable'
				} else {
					'not writable'
				}
			},
		]) },
		rt.ArrayItem{ key: 'fonts', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('The fonts directory'),
			]) },
			rt.ArrayItem{
				key: 'value'
				val: if rt.is_true(var_fonts_dir_exists) {
					if rt.is_true(var_is_writable_fonts_dir) { rt.call_function('__', [
							rt.new_string('Writable'),
						]) } else { rt.call_function('__', [
							rt.new_string('Not writable'),
						]) }
				} else {
					rt.call_function('__', [
						rt.new_string('Does not exist'),
					])
				}
			},
			rt.ArrayItem{
				key: 'debug'
				val: if rt.is_true(var_fonts_dir_exists) {
					if rt.is_true(var_is_writable_fonts_dir) { 'writable' } else { 'not writable' }
				} else {
					'does not exist'
				}
			},
		]) },
	])
	if rt.is_true(rt.call_function('defined', [rt.new_string('WPMU_PLUGIN_DIR')]))
		&& rt.is_true(rt.call_function('is_dir', [rt.get_constant('WPMU_PLUGIN_DIR')])) {
		mut var_is_writable_wpmu_plugin_dir := rt.call_function('wp_is_writable', [
			rt.get_constant('WPMU_PLUGIN_DIR'),
		])
		var_fields.array_set('mu-plugins', rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('The must use plugins directory'),
			]) },
			rt.ArrayItem{
				key: 'value'
				val: if rt.is_true(var_is_writable_wpmu_plugin_dir) { rt.call_function('__', [
						rt.new_string('Writable'),
					]) } else { rt.call_function('__', [
						rt.new_string('Not writable'),
					]) }
			},
			rt.ArrayItem{
				key: 'debug'
				val: if rt.is_true(var_is_writable_wpmu_plugin_dir) {
					'writable'
				} else {
					'not writable'
				}
			},
		]))
	}
	return rt.create_array([
		rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
			rt.new_string('Filesystem Permissions'),
		]) },
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Shows whether WordPress is able to write to the directories it needs access to.'),
		]) },
		rt.ArrayItem{ key: 'fields', val: var_fields },
	])
}

fn Class_WP_Debug_Data.get_mysql_var(var_mysql_var rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_result := rt.call_method(var_wpdb, 'get_row', [
		rt.call_method(var_wpdb, 'prepare', [rt.new_string('SHOW VARIABLES LIKE %s'),
			var_mysql_var.clone()]),
		rt.get_constant('ARRAY_A'),
	])
	if !(!rt.is_true(var_result))
		&& rt.is_true(rt.new_bool(var_result.clone().array_isset(rt.new_string('Value')))) {
		return var_result.array_get(rt.new_string('Value'))
	}
	return rt.new_null()
}

fn Class_WP_Debug_Data.format(var_info_array rt.PhpVal, var_data_type rt.PhpVal) rt.PhpVal {
	mut var_return := rt.new_string('`\n')
	mut iter_9 := var_info_array.iterator()
	for {
		item_9 := iter_9.next() or { break }
		mut var_details := item_9.val
		mut var_section := item_9.key
		if !rt.is_true(var_details.array_get(rt.new_string('fields')))
			|| (var_details.array_isset(rt.new_string('private'))
			&& rt.is_true(var_details.array_get(rt.new_string('private')))) {
			continue
		}
		mut var_section_label := if rt.is_true(rt.identical(rt.new_string('debug'), var_data_type)) {
			var_section
		} else {
			var_details.array_get(rt.new_string('label'))
		}
		var_return = rt.concat(var_return, rt.call_function('sprintf', [
			rt.new_string('### %s%s ###\n\n'),
			var_section_label.clone(),
			if var_details.array_isset(rt.new_string('show_count')) && rt.is_true(var_details.array_get(rt.new_string('show_count'))) { rt.call_function('sprintf', [
					rt.new_string(' (%d)'),
					rt.new_int(var_details.array_get(rt.new_string('fields')).array_count()),
				]) } else { rt.new_string('') },
		]))
		mut iter_10 := var_details.array_get(rt.new_string('fields')).iterator()
		for {
			item_10 := iter_10.next() or { break }
			mut var_field := item_10.val
			mut var_field_name := item_10.key
			if var_field.array_isset(rt.new_string('private'))
				&& rt.is_true(rt.identical(rt.new_bool(true), var_field.array_get(rt.new_string('private')))) {
				continue
			}
			if rt.is_true(rt.identical(rt.new_string('debug'), var_data_type))
				&& var_field.array_isset(rt.new_string('debug')) {
				mut var_debug_data := var_field.array_get(rt.new_string('debug'))
			} else {
				var_debug_data = var_field.array_get(rt.new_string('value'))
			}
			if rt.is_true(rt.new_bool(var_debug_data.clone().is_array())) {
				mut var_value := rt.new_string('')
				mut iter_11 := var_debug_data.iterator()
				for {
					item_11 := iter_11.next() or { break }
					mut var_sub_field_value := item_11.val
					mut var_sub_field_name := item_11.key
					var_value = rt.concat(var_value, rt.call_function('sprintf', [
						rt.new_string('\n\t%s: %s'),
						var_sub_field_name.clone(),
						var_sub_field_value.clone(),
					]))
				}
			} else if rt.is_true(rt.new_bool(var_debug_data.clone().is_bool())) {
				var_value =
					rt.new_string((if rt.is_true(var_debug_data) { 'true' } else { 'false' }).str())
			} else if !rt.is_true(var_debug_data)
				&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('0'), var_debug_data)))) {
				var_value = rt.new_string('undefined')
			} else {
				var_value = var_debug_data.clone()
			}
			if rt.is_true(rt.identical(rt.new_string('debug'), var_data_type)) {
				mut var_label := var_field_name
			} else {
				var_label = var_field.array_get(rt.new_string('label'))
			}
			var_return = rt.concat(var_return, rt.call_function('sprintf', [
				rt.new_string('%s: %s\n'),
				var_label.clone(),
				var_value.clone(),
			]))
		}
		var_return = rt.concat(var_return, rt.new_string('\n'))
	}
	var_return = rt.concat(var_return, rt.new_string('`'))
	return var_return.clone()
}

fn Class_WP_Debug_Data.get_database_size() i64 {
	mut var_wpdb := rt.new_null()
	mut var_size := rt.new_int(0)
	mut var_rows := rt.call_method(var_wpdb, 'get_results', [
		rt.new_string('SHOW TABLE STATUS'),
		rt.get_constant('ARRAY_A'),
	])
	if rt.is_true(rt.greater(rt.get_property(var_wpdb, 'num_rows'), rt.new_int(0))) {
		mut iter_12 := var_rows.iterator()
		for {
			item_12 := iter_12.next() or { break }
			mut var_row := item_12.val
			var_size = rt.add(var_size, rt.add(var_row.array_get(rt.new_string('Data_length')),
				var_row.array_get(rt.new_string('Index_length'))))
		}
	}
	return rt.new_int(var_size.to_i64())
}

fn Class_WP_Debug_Data.get_sizes() rt.PhpVal {
	rt.call_function('_deprecated_function', [rt.new_string(@METHOD),
		rt.new_string('5.6.0'), rt.new_string('WP_REST_Site_Health_Controller::get_directory_sizes()')])
	mut var_size_db := Class_WP_Debug_Data.get_database_size()
	mut var_upload_dir := rt.call_function('wp_get_upload_dir', []rt.PhpVal{})
	if rt.is_true(rt.call_function('function_exists', [rt.new_string('ini_get')])) {
		mut var_max_execution_time := rt.call_function('ini_get', [
			rt.new_string('max_execution_time'),
		])
	}
	if !rt.is_true(var_max_execution_time) {
		var_max_execution_time = rt.new_int(30)
	}
	if rt.is_true(rt.greater(var_max_execution_time, rt.new_int(20))) {
		var_max_execution_time = rt.sub(var_max_execution_time, rt.new_int(2))
	}
	mut var_paths := {
		'wordpress_size': rt.call_function('untrailingslashit', [
			rt.get_constant('ABSPATH'),
		])
		'themes_size':    rt.call_function('get_theme_root', []rt.PhpVal{})
		'plugins_size':   rt.get_constant('WP_PLUGIN_DIR')
		'uploads_size':   var_upload_dir.array_get(rt.new_string('basedir'))
		'fonts_size':     rt.call_function('wp_get_font_dir', []rt.PhpVal{}).array_get(rt.new_string('basedir'))
	}
	mut var_exclude := var_paths.clone()
	var_exclude.array_unset(rt.new_string('wordpress_size'))
	var_exclude = rt.call_function('array_values', [var_exclude.clone()])
	mut var_size_total := rt.new_int(0)
	mut var_all_sizes := rt.new_array()
	for var_name, var_path in var_paths {
		mut var_dir_size := rt.new_null()
		mut var_results := {
			'path': var_path
			'raw':  rt.new_int(0)
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_dir', [
			var_path.clone()])))))
		{
			var_all_sizes.array_set(name, rt.create_array([
				rt.ArrayItem{ key: 'path', val: var_path },
				rt.ArrayItem{ key: 'raw', val: 0 },
				rt.ArrayItem{ key: 'size', val: rt.call_function('__', [
					rt.new_string('The directory does not exist.'),
				]) },
				rt.ArrayItem{ key: 'debug', val: 'directory not found' },
			]))
			continue
		}
		if rt.is_true(rt.less(rt.sub(rt.call_function('microtime', [
			rt.new_bool(true)]), rt.get_constant('WP_START_TIMESTAMP')), var_max_execution_time))
		{
			if rt.is_true(rt.identical(rt.new_string('wordpress_size'), rt.new_string(name))) {
				var_dir_size = rt.call_function('recurse_dirsize', [
					var_path.clone(), var_exclude.clone(), var_max_execution_time.clone()])
			} else {
				var_dir_size = rt.call_function('recurse_dirsize', [
					var_path.clone(), rt.new_null(), var_max_execution_time.clone()])
			}
		}
		if rt.is_true(rt.identical(rt.new_bool(false), var_dir_size)) {
			var_results['size'] = rt.call_function('__', [
				rt.new_string('The size cannot be calculated. The directory is not accessible. Usually caused by invalid permissions.'),
			])
			var_results['debug'] = rt.new_string('not accessible')
			var_size_total = rt.new_null()
		} else if rt.is_true(rt.identical(rt.new_null(), var_dir_size)) {
			var_results['size'] = rt.call_function('__', [
				rt.new_string('The directory size calculation has timed out. Usually caused by a very large number of sub-directories and files.'),
			])
			var_results['debug'] = rt.new_string('timeout while calculating size')
			var_size_total = rt.new_null()
		} else {
			if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_size_total)))) {
				var_size_total = rt.add(var_size_total, var_dir_size)
			}
			var_results['raw'] = var_dir_size.clone()
			var_results['size'] = rt.call_function('size_format', [
				var_dir_size.clone(), rt.new_int(2)])
			var_results['debug'] =
				(var_results['size']).str() + ' (${var_dir_size.to_string()} bytes)'
		}
		var_all_sizes.array_set(name, var_results.clone())
	}
	if rt.is_true(rt.greater(var_size_db, rt.new_int(0))) {
		mut var_database_size := rt.call_function('size_format', [
			var_size_db.clone(), rt.new_int(2)])
		var_all_sizes.array_set('database_size', rt.create_array([
			rt.ArrayItem{ key: 'raw', val: var_size_db },
			rt.ArrayItem{ key: 'size', val: var_database_size },
			rt.ArrayItem{ key: 'debug', val: var_database_size.str() +
				' (${var_size_db.to_string()} bytes)' },
		]))
	} else {
		var_all_sizes.array_set('database_size', rt.create_array([
			rt.ArrayItem{ key: 'size', val: rt.call_function('__', [
				rt.new_string('Not available'),
			]) },
			rt.ArrayItem{ key: 'debug', val: 'not available' },
		]))
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_size_total))))
		&& rt.is_true(rt.greater(var_size_db, rt.new_int(0))) {
		mut var_total_size := rt.add(var_size_total, var_size_db)
		mut var_total_size_mb := rt.call_function('size_format', [
			var_total_size.clone(), rt.new_int(2)])
		var_all_sizes.array_set('total_size', rt.create_array([
			rt.ArrayItem{ key: 'raw', val: var_total_size },
			rt.ArrayItem{ key: 'size', val: var_total_size_mb },
			rt.ArrayItem{ key: 'debug', val: var_total_size_mb.str() +
				' (${var_total_size.to_string()} bytes)' },
		]))
	} else {
		var_all_sizes.array_set('total_size', rt.create_array([
			rt.ArrayItem{ key: 'size', val: rt.call_function('__', [
				rt.new_string('Total size is not available. Some errors were encountered when determining the size of your installation.'),
			]) },
			rt.ArrayItem{ key: 'debug', val: 'not available' },
		]))
	}
	return var_all_sizes.clone()
}

struct Class_WP_Network_Query {
	rt.PhpObjectBase
}

struct Class_WP_Site_Health {
	rt.PhpObjectBase
}

struct Class_DateTime {
	rt.PhpObjectBase
}

struct Class_DateTimeZone {
	rt.PhpObjectBase
}

struct Class_Imagick {
	rt.PhpObjectBase
}

struct Class_stdClass {
	rt.PhpObjectBase
}

fn create_wp_debug_data(_args ...rt.PhpVal) &Class_WP_Debug_Data {
	mut obj := &Class_WP_Debug_Data{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_network_query(_args ...rt.PhpVal) &Class_WP_Network_Query {
	mut obj := &Class_WP_Network_Query{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_site_health(_args ...rt.PhpVal) &Class_WP_Site_Health {
	mut obj := &Class_WP_Site_Health{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_datetime(_args ...rt.PhpVal) &Class_DateTime {
	mut obj := &Class_DateTime{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_datetimezone(_args ...rt.PhpVal) &Class_DateTimeZone {
	mut obj := &Class_DateTimeZone{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_imagick(_args ...rt.PhpVal) &Class_Imagick {
	mut obj := &Class_Imagick{
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

fn (mut this Class_WP_Debug_Data) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'check_for_updates' {
			Class_WP_Debug_Data.check_for_updates()
			return rt.new_null()
		}
		'debug_data' {
			return Class_WP_Debug_Data.debug_data()
		}
		'get_wp_core' {
			return Class_WP_Debug_Data.get_wp_core()
		}
		'get_wp_dropins' {
			return Class_WP_Debug_Data.get_wp_dropins()
		}
		'get_wp_server' {
			return Class_WP_Debug_Data.get_wp_server()
		}
		'get_wp_media' {
			return Class_WP_Debug_Data.get_wp_media()
		}
		'get_wp_mu_plugins' {
			return Class_WP_Debug_Data.get_wp_mu_plugins()
		}
		'get_wp_paths_sizes' {
			return Class_WP_Debug_Data.get_wp_paths_sizes()
		}
		'get_wp_plugins_active' {
			return Class_WP_Debug_Data.get_wp_plugins_active()
		}
		'get_wp_plugins_inactive' {
			return Class_WP_Debug_Data.get_wp_plugins_inactive()
		}
		'get_wp_plugins_raw_data' {
			return Class_WP_Debug_Data.get_wp_plugins_raw_data()
		}
		'get_wp_active_theme' {
			return Class_WP_Debug_Data.get_wp_active_theme()
		}
		'get_wp_parent_theme' {
			return Class_WP_Debug_Data.get_wp_parent_theme()
		}
		'get_wp_themes_inactive' {
			return Class_WP_Debug_Data.get_wp_themes_inactive()
		}
		'get_wp_constants' {
			return Class_WP_Debug_Data.get_wp_constants()
		}
		'get_wp_database' {
			return Class_WP_Debug_Data.get_wp_database()
		}
		'get_wp_filesystem' {
			return Class_WP_Debug_Data.get_wp_filesystem()
		}
		'get_mysql_var' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WP_Debug_Data.get_mysql_var(dispatch_arg_0)
		}
		'format' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_WP_Debug_Data.format(dispatch_arg_0, dispatch_arg_1)
		}
		'get_database_size' {
			return rt.new_int(Class_WP_Debug_Data.get_database_size())
		}
		'get_sizes' {
			return Class_WP_Debug_Data.get_sizes()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WP_Debug_Data) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Debug_Data) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WP_Network_Query) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Network_Query) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Network_Query) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WP_Site_Health) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Site_Health) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Site_Health) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_DateTime) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_DateTime) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_DateTime) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_DateTimeZone) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_DateTimeZone) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_DateTimeZone) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Imagick) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Imagick) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Imagick) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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
