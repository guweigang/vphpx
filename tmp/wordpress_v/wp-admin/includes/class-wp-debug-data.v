import rt

struct Class_WP_Debug_Data {
	rt.PhpObjectBase
}

fn Class_WP_Debug_Data.check_for_updates()  {
	rt.call_function('wp_version_check', []rt.PhpVal{})
	rt.call_function('wp_update_plugins', []rt.PhpVal{})
	rt.call_function('wp_update_themes', []rt.PhpVal{})
}

fn Class_WP_Debug_Data.debug_data() rt.PhpVal {
	mut var_info := rt.create_array([rt.ArrayItem{ key: 'wp-core', val: Class_WP_Debug_Data.get_wp_core() }, rt.ArrayItem{ key: 'wp-paths-sizes', val: Class_WP_Debug_Data.get_wp_paths_sizes() }, rt.ArrayItem{ key: 'wp-dropins', val: Class_WP_Debug_Data.get_wp_dropins() }, rt.ArrayItem{ key: 'wp-active-theme', val: Class_WP_Debug_Data.get_wp_active_theme() }, rt.ArrayItem{ key: 'wp-parent-theme', val: Class_WP_Debug_Data.get_wp_parent_theme() }, rt.ArrayItem{ key: 'wp-themes-inactive', val: Class_WP_Debug_Data.get_wp_themes_inactive() }, rt.ArrayItem{ key: 'wp-mu-plugins', val: Class_WP_Debug_Data.get_wp_mu_plugins() }, rt.ArrayItem{ key: 'wp-plugins-active', val: Class_WP_Debug_Data.get_wp_plugins_active() }, rt.ArrayItem{ key: 'wp-plugins-inactive', val: Class_WP_Debug_Data.get_wp_plugins_inactive() }, rt.ArrayItem{ key: 'wp-media', val: Class_WP_Debug_Data.get_wp_media() }, rt.ArrayItem{ key: 'wp-server', val: Class_WP_Debug_Data.get_wp_server() }, rt.ArrayItem{ key: 'wp-database', val: Class_WP_Debug_Data.get_wp_database() }, rt.ArrayItem{ key: 'wp-constants', val: Class_WP_Debug_Data.get_wp_constants() }, rt.ArrayItem{ key: 'wp-filesystem', val: Class_WP_Debug_Data.get_wp_filesystem() }])
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_section := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return rt.new_bool(!(var_section).is_null())
	}
	var_info = rt.call_function('array_filter', [var_info.dup(), rt.new_closure(closure_1_fn)])
	var_info = rt.call_function('apply_filters', [rt.new_string('debug_information'), var_info.dup()])
	return var_info.dup()
}

fn Class_WP_Debug_Data.get_wp_core() rt.PhpVal {
	mut var_permalink_structure := rt.call_function('get_option', [rt.new_string('permalink_structure')])
	mut var_is_ssl := rt.call_function('is_ssl', []rt.PhpVal{})
	mut var_users_can_register := rt.call_function('get_option', [rt.new_string('users_can_register')])
	mut var_blog_public := rt.call_function('get_option', [rt.new_string('blog_public')])
	mut var_default_comment_status := rt.call_function('get_option', [rt.new_string('default_comment_status')])
	mut var_environment_type := rt.call_function('wp_get_environment_type', []rt.PhpVal{})
	mut var_core_version := rt.call_function('wp_get_wp_version', []rt.PhpVal{})
	mut var_core_updates := rt.call_function('get_core_updates', []rt.PhpVal{})
	mut var_core_update_needed := rt.new_string(rt.new_string(''))
	if rt.is_true(rt.new_bool(var_core_updates.dup().is_array())) {
		{
			mut iter_1 := var_core_updates.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_update := item_1.val
				mut var_core := item_1.key
				if rt.is_true(rt.identical(rt.new_string('upgrade'), rt.get_property(var_update, 'response'))) {
					var_core_update_needed = rt.new_string(' ' + (rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('(Latest version: %s)')]), rt.get_property(var_update, 'version')])).str())
				} else {
					var_core_update_needed = rt.new_string(rt.new_string(''))
				}
			}
		}
	}
	mut var_fields := rt.create_array([rt.ArrayItem{ key: 'version', val: rt.create_array([rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('Version')]) }, rt.ArrayItem{ key: 'value', val: (var_core_version).str() + (var_core_update_needed).str() }, rt.ArrayItem{ key: 'debug', val: var_core_version }]) }, rt.ArrayItem{ key: 'site_language', val: rt.create_array([rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('Site Language')]) }, rt.ArrayItem{ key: 'value', val: rt.call_function('get_locale', []rt.PhpVal{}) }]) }, rt.ArrayItem{ key: 'user_language', val: rt.create_array([rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('User Language')]) }, rt.ArrayItem{ key: 'value', val: rt.call_function('get_user_locale', []rt.PhpVal{}) }]) }, rt.ArrayItem{ key: 'timezone', val: rt.create_array([rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('Timezone')]) }, rt.ArrayItem{ key: 'value', val: rt.call_function('wp_timezone_string', []rt.PhpVal{}) }]) }, rt.ArrayItem{ key: 'home_url', val: rt.create_array([rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('Home URL')]) }, rt.ArrayItem{ key: 'value', val: rt.call_function('get_bloginfo', [rt.new_string('url')]) }, rt.ArrayItem{ key: 'private', val: true }]) }, rt.ArrayItem{ key: 'site_url', val: rt.create_array([rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('Site URL')]) }, rt.ArrayItem{ key: 'value', val: rt.call_function('get_bloginfo', [rt.new_string('wpurl')]) }, rt.ArrayItem{ key: 'private', val: true }]) }, rt.ArrayItem{ key: 'permalink', val: rt.create_array([rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('Permalink structure')]) }, rt.ArrayItem{ key: 'value', val: if rt.is_true(var_permalink_structure) { var_permalink_structure } else { rt.call_function('__', [rt.new_string('No permalink structure set')]) } }, rt.ArrayItem{ key: 'debug', val: var_permalink_structure }]) }, rt.ArrayItem{ key: 'https_status', val: rt.create_array([rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('Is this site using HTTPS?')]) }, rt.ArrayItem{ key: 'value', val: if rt.is_true(var_is_ssl) { rt.call_function('__', [rt.new_string('Yes')]) } else { rt.call_function('__', [rt.new_string('No')]) } }, rt.ArrayItem{ key: 'debug', val: var_is_ssl }]) }, rt.ArrayItem{ key: 'multisite', val: rt.create_array([rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('Is this a multisite?')]) }, rt.ArrayItem{ key: 'value', val: if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) { rt.call_function('__', [rt.new_string('Yes')]) } else { rt.call_function('__', [rt.new_string('No')]) } }, rt.ArrayItem{ key: 'debug', val: rt.call_function('is_multisite', []rt.PhpVal{}) }]) }, rt.ArrayItem{ key: 'user_registration', val: rt.create_array([rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('Can anyone register on this site?')]) }, rt.ArrayItem{ key: 'value', val: if rt.is_true(var_users_can_register) { rt.call_function('__', [rt.new_string('Yes')]) } else { rt.call_function('__', [rt.new_string('No')]) } }, rt.ArrayItem{ key: 'debug', val: var_users_can_register }]) }, rt.ArrayItem{ key: 'blog_public', val: rt.create_array([rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('Is this site discouraging search engines?')]) }, rt.ArrayItem{ key: 'value', val: if rt.is_true(var_blog_public) { rt.call_function('__', [rt.new_string('No')]) } else { rt.call_function('__', [rt.new_string('Yes')]) } }, rt.ArrayItem{ key: 'debug', val: var_blog_public }]) }, rt.ArrayItem{ key: 'default_comment_status', val: rt.create_array([rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('Default comment status')]) }, rt.ArrayItem{ key: 'value', val: if rt.is_true(rt.identical(rt.new_string('open'), var_default_comment_status)) { rt.call_function('_x', [rt.new_string('Open'), rt.new_string('comment status')]) } else { rt.call_function('_x', [rt.new_string('Closed'), rt.new_string('comment status')]) } }, rt.ArrayItem{ key: 'debug', val: var_default_comment_status }]) }, rt.ArrayItem{ key: 'environment_type', val: rt.create_array([rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('Environment type')]) }, rt.ArrayItem{ key: 'value', val: var_environment_type }, rt.ArrayItem{ key: 'debug', val: var_environment_type }]) }])
	if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) {
		mut var_site_id := rt.call_function('get_current_blog_id', []rt.PhpVal{})
		var_fields.array_set('site_id', rt.create_array([rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('Site ID')]) }, rt.ArrayItem{ key: 'value', val: var_site_id }, rt.ArrayItem{ key: 'debug', val: var_site_id }]))
		mut var_network_query := create_wp_network_query()
		mut var_network_ids := var_network_query.query(rt.create_array([rt.ArrayItem{ key: 'fields', val: 'ids' }, rt.ArrayItem{ key: 'number', val: 100 }, rt.ArrayItem{ key: 'no_found_rows', val: false }]))
		mut var_site_count := rt.new_int(rt.new_int(0))
		{
			mut iter_1 := var_network_ids.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_network_id := item_1.val
				// unsupported expression: Expr_AssignOp_Plus
			}
		}
		var_fields.array_set('site_count', rt.create_array([rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('Site count')]) }, rt.ArrayItem{ key: 'value', val: var_site_count }]))
		var_fields.array_set('network_count', rt.create_array([rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('Network count')]) }, rt.ArrayItem{ key: 'value', val: rt.get_property(var_network_query, 'found_networks') }]))
	}
	var_fields.array_set('user_count', rt.create_array([rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('User count')]) }, rt.ArrayItem{ key: 'value', val: rt.call_function('get_user_count', []rt.PhpVal{}) }]))
	mut var_wp_dotorg := rt.call_function('wp_remote_get', [rt.new_string('https://wordpress.org'), rt.create_array([rt.ArrayItem{ key: 'timeout', val: 10 }])])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [var_wp_dotorg.dup()]))))) {
		var_fields.array_set('dotorg_communication', rt.create_array([rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('Communication with WordPress.org')]) }, rt.ArrayItem{ key: 'value', val: rt.call_function('__', [rt.new_string('WordPress.org is reachable')]) }, rt.ArrayItem{ key: 'debug', val: 'true' }]))
	} else {
		var_fields.array_set('dotorg_communication', rt.create_array([rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('Communication with WordPress.org')]) }, rt.ArrayItem{ key: 'value', val: rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Unable to reach WordPress.org at %1$s: %2$s')]), rt.call_function('gethostbyname', [rt.new_string('wordpress.org')]), rt.call_method(var_wp_dotorg, 'get_error_message', []rt.PhpVal{})]) }, rt.ArrayItem{ key: 'debug', val: rt.call_method(var_wp_dotorg, 'get_error_message', []rt.PhpVal{}) }]))
	}
	return rt.create_array([rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('WordPress')]) }, rt.ArrayItem{ key: 'fields', val: var_fields }])
}

fn Class_WP_Debug_Data.get_wp_dropins() rt.PhpVal {
	mut var_dropins := rt.call_function('get_dropins', []rt.PhpVal{})
	mut var_dropin_descriptions := rt.call_function('_get_dropins', []rt.PhpVal{})
	mut var_fields := rt.new_array()
	{
		mut iter_1 := var_dropins.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_dropin := item_1.val
			mut var_dropin_key := item_1.key
			var_fields.array_set(rt.call_function('sanitize_text_field', [var_dropin_key.dup()]), rt.create_array([rt.ArrayItem{ key: 'label', val: var_dropin_key }, rt.ArrayItem{ key: 'value', val: var_dropin_descriptions.array_get(var_dropin_key).array_get(0) }, rt.ArrayItem{ key: 'debug', val: 'true' }]))
		}
	}
	return rt.create_array([rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('Drop-ins')]) }, rt.ArrayItem{ key: 'show_count', val: true }, rt.ArrayItem{ key: 'description', val: rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Drop-ins are single files, found in the %s directory, that replace or enhance WordPress features in ways that are not possible for traditional plugins.')]), '<code>' + (rt.call_function('str_replace', [rt.get_constant('ABSPATH'), rt.new_string(''), rt.get_constant('WP_CONTENT_DIR')])).str() + '</code>']) }, rt.ArrayItem{ key: 'fields', val: var_fields }])
}

fn Class_WP_Debug_Data.get_wp_server() rt.PhpVal {
	if rt.is_true(rt.call_function('function_exists', [rt.new_string('php_uname')])) {
		mut var_server_architecture := rt.call_function('sprintf', [rt.new_string('%s %s %s'), rt.call_function('php_uname', [rt.new_string('s')]), rt.call_function('php_uname', [rt.new_string('r')]), rt.call_function('php_uname', [rt.new_string('m')])])
	} else {
		var_server_architecture = rt.new_string(rt.new_string('unknown'))
	}
	mut var_php_version_debug := rt.get_constant('PHP_VERSION')
	mut var_php64bit := rt.identical(rt.mul(rt.get_constant('PHP_INT_SIZE'), rt.new_int(8)), rt.new_int(64))
	mut var_php_version := rt.call_function('sprintf', [rt.new_string('%s %s'), var_php_version_debug.dup(), if rt.is_true(var_php64bit) { rt.call_function('__', [rt.new_string('(Supports 64bit values)')]) } else { rt.call_function('__', [rt.new_string('(Does not support 64bit values)')]) }])
	if rt.is_true(var_php64bit) {
		// unsupported expression: Expr_AssignOp_Concat
	}
	mut var_fields := rt.new_array()
	var_fields.array_set('server_architecture', rt.create_array([rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('Server architecture')]) }, rt.ArrayItem{ key: 'value', val: if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) { var_server_architecture } else { rt.call_function('__', [rt.new_string('Unable to determine server architecture')]) } }, rt.ArrayItem{ key: 'debug', val: var_server_architecture }]))
	var_fields.array_set('httpd_software', rt.create_array([rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('Web server')]) }, rt.ArrayItem{ key: 'value', val: if !(!rt.is_true(rt.get_superglobal('_SERVER').array_get('SERVER_SOFTWARE'))) { rt.call_function('wp_unslash', [rt.get_superglobal('_SERVER').array_get('SERVER_SOFTWARE')]) } else { rt.call_function('__', [rt.new_string('Unable to determine what web server software is used')]) } }, rt.ArrayItem{ key: 'debug', val: if !(!rt.is_true(rt.get_superglobal('_SERVER').array_get('SERVER_SOFTWARE'))) { rt.call_function('wp_unslash', [rt.get_superglobal('_SERVER').array_get('SERVER_SOFTWARE')]) } else { rt.new_string('unknown') } }]))
	var_fields.array_set('php_version', rt.create_array([rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('PHP version')]) }, rt.ArrayItem{ key: 'value', val: var_php_version }, rt.ArrayItem{ key: 'debug', val: var_php_version_debug }]))
	var_fields.array_set('php_sapi', rt.create_array([rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('PHP SAPI')]) }, rt.ArrayItem{ key: 'value', val: rt.get_constant('PHP_SAPI') }, rt.ArrayItem{ key: 'debug', val: rt.get_constant('PHP_SAPI') }]))
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('ini_get')]))))) {
		var_fields.array_set('ini_get', rt.create_array([rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('Server settings')]) }, rt.ArrayItem{ key: 'value', val: rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Unable to determine some settings, as the %s function has been disabled.')]), rt.new_string('ini_get()')]) }, rt.ArrayItem{ key: 'debug', val: 'ini_get() is disabled' }]))
	} else {
		var_fields.array_set('max_input_variables', rt.create_array([rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('PHP max input variables')]) }, rt.ArrayItem{ key: 'value', val: rt.call_function('ini_get', [rt.new_string('max_input_vars')]) }]))
		var_fields.array_set('time_limit', rt.create_array([rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('PHP time limit')]) }, rt.ArrayItem{ key: 'value', val: rt.call_function('ini_get', [rt.new_string('max_execution_time')]) }]))
		if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
			var_fields.array_set('memory_limit', rt.create_array([rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('PHP memory limit')]) }, rt.ArrayItem{ key: 'value', val: rt.get_property(fn () rt.PhpVal { mut temp := Class_WP_Site_Health{}; return temp.get_instance() }(), 'php_memory_limit') }]))
			var_fields.array_set('admin_memory_limit', rt.create_array([rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('PHP memory limit (only for admin screens)')]) }, rt.ArrayItem{ key: 'value', val: rt.call_function('ini_get', [rt.new_string('memory_limit')]) }]))
		} else {
			var_fields.array_set('memory_limit', rt.create_array([rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('PHP memory limit')]) }, rt.ArrayItem{ key: 'value', val: rt.call_function('ini_get', [rt.new_string('memory_limit')]) }]))
		}
		var_fields.array_set('max_input_time', rt.create_array([rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('Max input time')]) }, rt.ArrayItem{ key: 'value', val: rt.call_function('ini_get', [rt.new_string('max_input_time')]) }]))
		var_fields.array_set('upload_max_filesize', rt.create_array([rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('Upload max filesize')]) }, rt.ArrayItem{ key: 'value', val: rt.call_function('ini_get', [rt.new_string('upload_max_filesize')]) }]))
		var_fields.array_set('php_post_max_size', rt.create_array([rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('PHP post max size')]) }, rt.ArrayItem{ key: 'value', val: rt.call_function('ini_get', [rt.new_string('post_max_size')]) }]))
	}
	if rt.is_true(rt.call_function('function_exists', [rt.new_string('curl_version')])) {
		mut var_curl := rt.call_function('curl_version', []rt.PhpVal{})
		var_fields.array_set('curl_version', rt.create_array([rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('cURL version')]) }, rt.ArrayItem{ key: 'value', val: rt.call_function('sprintf', [rt.new_string('%s %s'), var_curl.array_get('version'), var_curl.array_get('ssl_version')]) }]))
	} else {
		var_fields.array_set('curl_version', rt.create_array([rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('cURL version')]) }, rt.ArrayItem{ key: 'value', val: rt.call_function('__', [rt.new_string('Not available')]) }, rt.ArrayItem{ key: 'debug', val: 'not available' }]))
	}
	mut var_suhosin_loaded := rt.new_bool(rt.new_bool(rt.is_true(rt.call_function('extension_loaded', [rt.new_string('suhosin')])) || rt.is_true(rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('SUHOSIN_PATCH')])) && rt.is_true(rt.call_function('constant', [rt.new_string('SUHOSIN_PATCH')]))))))
	var_fields.array_set('suhosin', rt.create_array([rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('Is SUHOSIN installed?')]) }, rt.ArrayItem{ key: 'value', val: if rt.is_true(var_suhosin_loaded) { rt.call_function('__', [rt.new_string('Yes')]) } else { rt.call_function('__', [rt.new_string('No')]) } }, rt.ArrayItem{ key: 'debug', val: var_suhosin_loaded }]))
	mut var_imagick_loaded := rt.call_function('extension_loaded', [rt.new_string('imagick')])
	var_fields.array_set('imagick_availability', rt.create_array([rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('Is the Imagick library available?')]) }, rt.ArrayItem{ key: 'value', val: if rt.is_true(var_imagick_loaded) { rt.call_function('__', [rt.new_string('Yes')]) } else { rt.call_function('__', [rt.new_string('No')]) } }, rt.ArrayItem{ key: 'debug', val: var_imagick_loaded }]))
	if rt.is_true(rt.call_function('function_exists', [rt.new_string('opcache_get_status')])) {
		mut var_opcache_status := rt.call_function('opcache_get_status', [rt.new_bool(false)])
		if rt.is_true(rt.identical(rt.new_bool(false), var_opcache_status)) {
			var_fields.array_set('opcode_cache', rt.create_array([rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('Opcode cache')]) }, rt.ArrayItem{ key: 'value', val: rt.call_function('__', [rt.new_string('Disabled by configuration')]) }, rt.ArrayItem{ key: 'debug', val: 'not available' }]))
		} else {
			var_fields.array_set('opcode_cache', rt.create_array([rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('Opcode cache')]) }, rt.ArrayItem{ key: 'value', val: if rt.is_true(var_opcache_status.array_get('opcache_enabled')) { rt.call_function('__', [rt.new_string('Enabled')]) } else { rt.call_function('__', [rt.new_string('Disabled')]) } }, rt.ArrayItem{ key: 'debug', val: var_opcache_status.array_get('opcache_enabled') }]))
			if rt.is_true(rt.identical(rt.new_bool(true), var_opcache_status.array_get('opcache_enabled'))) {
				var_fields.array_set('opcode_cache_memory_usage', rt.create_array([rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('Opcode cache memory usage')]) }, rt.ArrayItem{ key: 'value', val: rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('%1$s of %2$s')]), rt.call_function('size_format', [var_opcache_status.array_get('memory_usage').array_get('used_memory')]), rt.call_function('size_format', [rt.add(var_opcache_status.array_get('memory_usage').array_get('free_memory'), var_opcache_status.array_get('memory_usage').array_get('used_memory'))])]) }, rt.ArrayItem{ key: 'debug', val: rt.call_function('sprintf', [rt.new_string('%s of %s'), var_opcache_status.array_get('memory_usage').array_get('used_memory'), rt.add(var_opcache_status.array_get('memory_usage').array_get('free_memory'), var_opcache_status.array_get('memory_usage').array_get('used_memory'))]) }]))
				if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
					var_fields.array_set('opcode_cache_interned_strings_usage', rt.create_array([rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('Opcode cache interned strings usage')]) }, rt.ArrayItem{ key: 'value', val: rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('%1$s%% of %2$s (%3$s free)')]), rt.call_function('number_format_i18n', [rt.mul(rt.div(var_opcache_status.array_get('interned_strings_usage').array_get('used_memory'), var_opcache_status.array_get('interned_strings_usage').array_get('buffer_size')), rt.new_int(100)), rt.new_int(2)]), rt.call_function('size_format', [var_opcache_status.array_get('interned_strings_usage').array_get('buffer_size')]), rt.call_function('size_format', [var_opcache_status.array_get('interned_strings_usage').array_get('free_memory')])]) }, rt.ArrayItem{ key: 'debug', val: rt.call_function('sprintf', [rt.new_string('%s%% of %s (%s free)'), rt.call_function('round', [rt.mul(rt.div(var_opcache_status.array_get('interned_strings_usage').array_get('used_memory'), var_opcache_status.array_get('interned_strings_usage').array_get('buffer_size')), rt.new_int(100)), rt.new_int(2)]), var_opcache_status.array_get('interned_strings_usage').array_get('buffer_size'), var_opcache_status.array_get('interned_strings_usage').array_get('free_memory')]) }]))
				}
				var_fields.array_set('opcode_cache_hit_rate', rt.create_array([rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('Opcode cache hit rate')]) }, rt.ArrayItem{ key: 'value', val: rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('%s%%')]), rt.call_function('number_format_i18n', [var_opcache_status.array_get('opcache_statistics').array_get('opcache_hit_rate'), rt.new_int(2)])]) }, rt.ArrayItem{ key: 'debug', val: rt.call_function('round', [var_opcache_status.array_get('opcache_statistics').array_get('opcache_hit_rate'), rt.new_int(2)]) }]))
				var_fields.array_set('opcode_cache_full', rt.create_array([rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('Is the Opcode cache full?')]) }, rt.ArrayItem{ key: 'value', val: if rt.is_true(var_opcache_status.array_get('cache_full')) { rt.call_function('__', [rt.new_string('Yes')]) } else { rt.call_function('__', [rt.new_string('No')]) } }, rt.ArrayItem{ key: 'debug', val: var_opcache_status.array_get('cache_full') }]))
			}
		}
	} else {
		var_fields.array_set('opcode_cache', rt.create_array([rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('Opcode cache')]) }, rt.ArrayItem{ key: 'value', val: rt.call_function('__', [rt.new_string('Disabled')]) }, rt.ArrayItem{ key: 'debug', val: 'not available' }]))
	}
	mut var_pretty_permalinks_supported := rt.call_function('got_url_rewrite', []rt.PhpVal{})
	var_fields.array_set('pretty_permalinks', rt.create_array([rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('Are pretty permalinks supported?')]) }, rt.ArrayItem{ key: 'value', val: if rt.is_true(var_pretty_permalinks_supported) { rt.call_function('__', [rt.new_string('Yes')]) } else { rt.call_function('__', [rt.new_string('No')]) } }, rt.ArrayItem{ key: 'debug', val: var_pretty_permalinks_supported }]))
	if rt.is_true(rt.call_function('is_file', [(rt.get_constant('ABSPATH')).str() + '.htaccess'])) {
		mut var_htaccess_content := rt.call_function('file_get_contents', [(rt.get_constant('ABSPATH')).str() + '.htaccess'])
		mut var_filtered_htaccess_content := rt.new_string(rt.new_string(rt.call_function('preg_replace', [rt.new_string('/\\# BEGIN WordPress[\\s\\S]+?# END WordPress/si'), rt.new_string(''), var_htaccess_content.dup()]).to_string().trim_space()))
		var_filtered_htaccess_content = rt.new_bool(rt.new_bool(!(!rt.is_true(var_filtered_htaccess_content))))
		if rt.is_true(var_filtered_htaccess_content) {
			mut var_htaccess_rules_string := rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Custom rules have been added to your %s file.')]), rt.new_string('.htaccess')])
		} else {
			var_htaccess_rules_string = rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Your %s file contains only core WordPress features.')]), rt.new_string('.htaccess')])
		}
		var_fields.array_set('htaccess_extra_rules', rt.create_array([rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('.htaccess rules')]) }, rt.ArrayItem{ key: 'value', val: var_htaccess_rules_string }, rt.ArrayItem{ key: 'debug', val: var_filtered_htaccess_content }]))
	}
	if rt.is_true(rt.call_function('is_file', [(rt.call_function('get_home_path', []rt.PhpVal{})).str() + 'robots.txt'])) {
		mut var_robotstxt_debug := rt.new_bool(rt.new_bool(true))
		mut var_robotstxt_string := rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Your site is using a static %s file. WordPress cannot dynamically serve one.')]), rt.new_string('robots.txt')])
	} else if rt.is_true(rt.call_function('got_url_rewrite', []rt.PhpVal{})) {
		var_robotstxt_debug = rt.new_bool(rt.new_bool(false))
		var_robotstxt_string = rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Your site is using the dynamic %s file which is generated by WordPress.')]), rt.new_string('robots.txt')])
	} else {
		var_robotstxt_debug = rt.new_bool(rt.new_bool(true))
		var_robotstxt_string = rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('WordPress cannot dynamically serve a %s file due to a lack of rewrite rule support.')]), rt.new_string('robots.txt')])
	}
	var_fields.array_set('static_robotstxt_file', rt.create_array([rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('robots.txt')]) }, rt.ArrayItem{ key: 'value', val: var_robotstxt_string }, rt.ArrayItem{ key: 'debug', val: var_robotstxt_debug }]))
	mut var_date := create_datetime(rt.new_string('now'), create_datetimezone(rt.new_string('UTC')))
	var_fields.array_set('current', rt.create_array([rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('Current time')]) }, rt.ArrayItem{ key: 'value', val: var_date.format(Class_DateTime.atom()) }]))
	var_fields.array_set('utc-time', rt.create_array([rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('Current UTC time')]) }, rt.ArrayItem{ key: 'value', val: var_date.format(Class_DateTime.rfc850()) }]))
	var_fields.array_set('server-time', rt.create_array([rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('Current Server time')]) }, rt.ArrayItem{ key: 'value', val: if rt.get_superglobal('_SERVER').array_isset(rt.new_string('REQUEST_TIME')) { rt.call_function('wp_date', [, ]) } else { rt.call_function('__', []) } }]))
	return rt.create_array([rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('Server')]) }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('The options shown below relate to your server setup. If changes are required, you may need your web host&#8217;s assistance.')]) }, rt.ArrayItem{ key: 'fields', val: var_fields }])
}

fn Class_WP_Debug_Data.get_wp_media() rt.PhpVal {
	mut var_fields := rt.new_null()
	mut var_not_available := rt.call_function('__', [])
	.array_set(, )
	if rt.is_true() {
	} else {
	}
	
}

fn Class_WP_Debug_Data.get_wp_mu_plugins() rt.PhpVal {
}

fn Class_WP_Debug_Data.get_wp_paths_sizes() rt.PhpVal {
}

fn Class_WP_Debug_Data.get_wp_plugins_active() rt.PhpVal {
}

fn Class_WP_Debug_Data.get_wp_plugins_inactive() rt.PhpVal {
}

fn Class_WP_Debug_Data.get_wp_plugins_raw_data() rt.PhpVal {
}

fn Class_WP_Debug_Data.get_wp_active_theme() rt.PhpVal {
	mut var__wp_theme_features := rt.new_null()
}

fn Class_WP_Debug_Data.get_wp_parent_theme() rt.PhpVal {
}

fn Class_WP_Debug_Data.get_wp_themes_inactive() rt.PhpVal {
}

fn Class_WP_Debug_Data.get_wp_constants() rt.PhpVal {
}

fn Class_WP_Debug_Data.get_wp_database() rt.PhpVal {
	mut var_wpdb := rt.new_null()
}

fn Class_WP_Debug_Data.get_wp_filesystem() rt.PhpVal {
}

fn Class_WP_Debug_Data.get_mysql_var(var_mysql_var rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
}

fn Class_WP_Debug_Data.format(var_info_array rt.PhpVal, var_data_type rt.PhpVal) rt.PhpVal {
}

fn Class_WP_Debug_Data.get_database_size() rt.PhpVal {
	mut var_wpdb := rt.new_null()
}

fn Class_WP_Debug_Data.get_sizes() rt.PhpVal {
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

fn create_wp_debug_data() &Class_WP_Debug_Data {
	mut obj := &Class_WP_Debug_Data{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_network_query() &Class_WP_Network_Query {
	mut obj := &Class_WP_Network_Query{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_site_health() &Class_WP_Site_Health {
	mut obj := &Class_WP_Site_Health{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_datetime() &Class_DateTime {
	mut obj := &Class_DateTime{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_datetimezone() &Class_DateTimeZone {
	mut obj := &Class_DateTimeZone{
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
			return Class_WP_Debug_Data.get_database_size()
		}
		'get_sizes' {
			return Class_WP_Debug_Data.get_sizes()
		}
		else { return none }
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




pub fn init_wp_admin_includes_class_wp_debug_data_php() {
}
