import rt

struct Class_WP_Plugin_Dependencies {
	rt.PhpObjectBase
}

fn init_static_wp_plugin_dependencies() {
	rt.init_static_prop('WP_Plugin_Dependencies', 'plugins', rt.new_null())
	rt.init_static_prop('WP_Plugin_Dependencies', 'plugin_dirnames', rt.new_null())
	rt.init_static_prop('WP_Plugin_Dependencies', 'dependencies', rt.new_null())
	rt.init_static_prop('WP_Plugin_Dependencies', 'dependency_slugs', rt.new_null())
	rt.init_static_prop('WP_Plugin_Dependencies', 'dependent_slugs', rt.new_null())
	rt.init_static_prop('WP_Plugin_Dependencies', 'dependency_api_data', rt.new_null())
	rt.init_static_prop('WP_Plugin_Dependencies', 'dependency_filepaths', rt.new_null())
	rt.init_static_prop('WP_Plugin_Dependencies', 'circular_dependencies_pairs', rt.new_null())
	rt.init_static_prop('WP_Plugin_Dependencies', 'circular_dependencies_slugs', rt.new_null())
	rt.init_static_prop('WP_Plugin_Dependencies', 'initialized', rt.new_bool(false))
}

fn Class_WP_Plugin_Dependencies.initialize() {
	if rt.is_true(rt.identical(rt.new_bool(false), rt.get_static_prop('WP_Plugin_Dependencies',
		'initialized')))
	{
		Class_WP_Plugin_Dependencies.read_dependencies_from_plugin_headers()
		Class_WP_Plugin_Dependencies.get_dependency_api_data()
		rt.set_static_prop('WP_Plugin_Dependencies', 'initialized', rt.new_bool(true))
	}
}

fn Class_WP_Plugin_Dependencies.has_dependents(var_plugin_file rt.PhpVal) rt.PhpVal {
	mut var_plugin_file_mutated := var_plugin_file
	return rt.call_function('in_array', [
		Class_WP_Plugin_Dependencies.convert_to_slug(var_plugin_file_mutated.clone()),
		rt.cast_array(rt.get_static_prop('WP_Plugin_Dependencies', 'dependency_slugs')),
		rt.new_bool(true),
	])
}

fn Class_WP_Plugin_Dependencies.has_dependencies(var_plugin_file rt.PhpVal) rt.PhpVal {
	mut var_plugin_file_mutated := var_plugin_file
	return rt.new_bool(rt.get_static_prop('WP_Plugin_Dependencies', 'dependencies').array_isset(var_plugin_file_mutated))
}

fn Class_WP_Plugin_Dependencies.has_active_dependents(var_plugin_file rt.PhpVal) bool {
	mut var_plugin_file_mutated := var_plugin_file
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/plugin.php', '4')
	mut var_dependents :=
		Class_WP_Plugin_Dependencies.get_dependents(Class_WP_Plugin_Dependencies.convert_to_slug(var_plugin_file_mutated.clone()))
	mut iter_1 := var_dependents.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_dependent := item_1.val
		if rt.is_true(rt.call_function('is_plugin_active', [var_dependent.clone()])) {
			return true
		}
	}
	return false
}

fn Class_WP_Plugin_Dependencies.get_dependents(var_slug rt.PhpVal) rt.PhpVal {
	mut var_slug_mutated := var_slug
	mut var_dependents := rt.new_array()
	mut iter_2 :=
		rt.cast_array(rt.get_static_prop('WP_Plugin_Dependencies', 'dependencies')).iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_dependencies := item_2.val
		mut var_dependent := item_2.key
		if rt.is_true(rt.call_function('in_array', [var_slug_mutated.clone(),
			var_dependencies.clone(), rt.new_bool(true)]))
		{
			var_dependents.array_push(var_dependent.clone())
		}
	}
	return var_dependents.clone()
}

fn Class_WP_Plugin_Dependencies.get_dependencies(var_plugin_file rt.PhpVal) rt.PhpVal {
	mut var_plugin_file_mutated := var_plugin_file
	return if !(rt.get_static_prop('WP_Plugin_Dependencies', 'dependencies').array_get(var_plugin_file_mutated)).is_null() {
		rt.get_static_prop('WP_Plugin_Dependencies', 'dependencies').array_get(var_plugin_file_mutated)
	} else {
		rt.new_array()
	}
}

fn Class_WP_Plugin_Dependencies.get_dependent_filepath(var_slug rt.PhpVal) rt.PhpVal {
	mut var_slug_mutated := var_slug
	mut var_filepath := rt.call_function('array_search', [var_slug_mutated.clone(),
		rt.get_static_prop('WP_Plugin_Dependencies', 'dependent_slugs'),
		rt.new_bool(true)])
	return if rt.is_true(var_filepath) { var_filepath } else { rt.new_bool(false) }
}

fn Class_WP_Plugin_Dependencies.has_unmet_dependencies(var_plugin_file rt.PhpVal) bool {
	mut var_plugin_file_mutated := var_plugin_file
	if !(rt.get_static_prop('WP_Plugin_Dependencies', 'dependencies').array_isset(var_plugin_file_mutated)) {
		return false
	}
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/plugin.php', '4')
	mut iter_3 :=
		rt.get_static_prop('WP_Plugin_Dependencies', 'dependencies').array_get(var_plugin_file_mutated).iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_dependency := item_3.val
		mut var_dependency_filepath :=
			Class_WP_Plugin_Dependencies.get_dependency_filepath(var_dependency.clone())
		if rt.is_true(rt.identical(rt.new_bool(false), var_dependency_filepath))
			|| rt.is_true(rt.call_function('is_plugin_inactive', [var_dependency_filepath.clone()])) {
			return true
		}
	}
	return false
}

fn Class_WP_Plugin_Dependencies.has_circular_dependency(var_plugin_file rt.PhpVal) bool {
	mut var_plugin_file_mutated := var_plugin_file
	if !(rt.get_static_prop('WP_Plugin_Dependencies', 'circular_dependencies_slugs').is_array()) {
		Class_WP_Plugin_Dependencies.get_circular_dependencies()
	}
	if !(!rt.is_true(rt.get_static_prop('WP_Plugin_Dependencies', 'circular_dependencies_slugs'))) {
		mut var_slug :=
			Class_WP_Plugin_Dependencies.convert_to_slug(var_plugin_file_mutated.clone())
		if rt.is_true(rt.call_function('in_array', [var_slug.clone(),
			rt.get_static_prop('WP_Plugin_Dependencies', 'circular_dependencies_slugs'),
			rt.new_bool(true)]))
		{
			return true
		}
	}
	return false
}

fn Class_WP_Plugin_Dependencies.get_dependent_names(var_plugin_file rt.PhpVal) rt.PhpVal {
	mut var_plugin_file_mutated := var_plugin_file
	mut var_dependent_names := rt.new_array()
	mut var_plugins := Class_WP_Plugin_Dependencies.get_plugins()
	mut var_slug := Class_WP_Plugin_Dependencies.convert_to_slug(var_plugin_file_mutated.clone())
	mut iter_4 := Class_WP_Plugin_Dependencies.get_dependents(var_slug.clone()).iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_dependent := item_4.val
		var_dependent_names.array_set(var_dependent,
			var_plugins.array_get(var_dependent).array_get(rt.new_string('Name')))
	}
	rt.call_function('sort', [var_dependent_names.clone()])
	return var_dependent_names.clone()
}

fn Class_WP_Plugin_Dependencies.get_dependency_names(var_plugin_file rt.PhpVal) rt.PhpVal {
	mut var_plugin_file_mutated := var_plugin_file
	mut var_dependency_api_data := Class_WP_Plugin_Dependencies.get_dependency_api_data()
	mut var_dependencies :=
		Class_WP_Plugin_Dependencies.get_dependencies(var_plugin_file_mutated.clone())
	mut var_plugins := Class_WP_Plugin_Dependencies.get_plugins()
	mut var_dependency_names := rt.new_array()
	mut iter_5 := var_dependencies.iterator()
	for {
		item_5 := iter_5.next() or { break }
		mut var_dependency := item_5.val
		if var_dependency_api_data.array_get(var_dependency).array_isset(rt.new_string('name')) {
			mut var_name :=
				var_dependency_api_data.array_get(var_dependency).array_get(rt.new_string('name'))
		} else {
			mut var_dependency_filepath :=
				Class_WP_Plugin_Dependencies.get_dependency_filepath(var_dependency.clone())
			if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false),
				var_dependency_filepath))))
			{
				var_name =
					var_plugins.array_get(var_dependency_filepath).array_get(rt.new_string('Name'))
			} else {
				var_name = var_dependency
			}
		}
		var_dependency_names.array_set(var_dependency, var_name.clone())
	}
	return var_dependency_names.clone()
}

fn Class_WP_Plugin_Dependencies.get_dependency_filepath(var_slug rt.PhpVal) bool {
	mut var_slug_mutated := var_slug
	mut var_dependency_filepaths := Class_WP_Plugin_Dependencies.get_dependency_filepaths()
	if !(var_dependency_filepaths.array_isset(var_slug_mutated)) {
		return false
	}
	return (var_dependency_filepaths.array_get(var_slug_mutated)).to_bool()
}

fn Class_WP_Plugin_Dependencies.get_dependency_data(var_slug rt.PhpVal) rt.PhpVal {
	mut var_slug_mutated := var_slug
	mut var_dependency_api_data := Class_WP_Plugin_Dependencies.get_dependency_api_data()
	return if !(var_dependency_api_data.array_get(var_slug_mutated)).is_null() {
		var_dependency_api_data.array_get(var_slug_mutated)
	} else {
		rt.new_bool(false)
	}
}

fn Class_WP_Plugin_Dependencies.display_admin_notice_for_unmet_dependencies() {
	if rt.is_true(rt.call_function('in_array', [rt.new_bool(false),
		Class_WP_Plugin_Dependencies.get_dependency_filepaths(),
		rt.new_bool(true)]))
	{
		mut var_error_message := rt.call_function('__', [
			rt.new_string('Some required plugins are missing or inactive.'),
		])
		if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) {
			if rt.is_true(rt.call_function('current_user_can', [
				rt.new_string('manage_network_plugins'),
			]))
			{
				var_error_message = rt.concat(var_error_message,
					rt.new_string(' ' +(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('<a href="%s">Manage plugins</a>.')]), rt.call_function('esc_url', [rt.call_function('network_admin_url', [rt.new_string('plugins.php')])])])).str()))
			} else {
				var_error_message = rt.concat(var_error_message,
					rt.new_string(' ' +(rt.call_function('__', [rt.new_string('Please contact your network administrator.')])).str()))
			}
		} else if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('plugins'), rt.get_property(rt.call_function('get_current_screen',
			[]rt.PhpVal{}), 'base')))))
		{
			var_error_message = rt.concat(var_error_message,
				rt.new_string(' ' +(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('<a href="%s">Manage plugins</a>.')]), rt.call_function('esc_url', [rt.call_function('admin_url', [rt.new_string('plugins.php')])])])).str()))
		}
		rt.call_function('wp_admin_notice', [var_error_message.clone(),
			rt.create_array([rt.ArrayItem{ key: 'type', val: 'warning' }])])
	}
}

fn Class_WP_Plugin_Dependencies.display_admin_notice_for_circular_dependencies() {
	mut var_circular_dependencies := Class_WP_Plugin_Dependencies.get_circular_dependencies()
	if !(!rt.is_true(var_circular_dependencies))
		&& var_circular_dependencies.clone().array_count() > 1 {
		var_circular_dependencies = rt.call_function('array_unique', [
			var_circular_dependencies.clone(), rt.get_constant('SORT_REGULAR')])
		mut var_plugins := Class_WP_Plugin_Dependencies.get_plugins()
		mut var_plugin_dirnames := Class_WP_Plugin_Dependencies.get_plugin_dirnames()
		mut var_circular_dependency_lines := rt.new_string('')
		mut iter_6 := var_circular_dependencies.iterator()
		for {
			item_6 := iter_6.next() or { break }
			mut var_circular_dependency := item_6.val
			mut var_first_filepath :=
				var_plugin_dirnames.array_get(var_circular_dependency.array_get(rt.new_int(0)))
			mut var_second_filepath :=
				var_plugin_dirnames.array_get(var_circular_dependency.array_get(rt.new_int(1)))
			var_circular_dependency_lines = rt.concat(var_circular_dependency_lines, rt.call_function('sprintf', [
				rt.new_string('<li>' +
					(rt.call_function('_x', [rt.new_string('%1$s requires %2$s'), rt.new_string('The first plugin requires the second plugin.')])).str() +
					'</li>'),
				rt.new_string('<strong>' +
					(rt.call_function('esc_html', [var_plugins.array_get(var_first_filepath).array_get(rt.new_string('Name'))])).str() +
					'</strong>'),
				rt.new_string('<strong>' +
					(rt.call_function('esc_html', [var_plugins.array_get(var_second_filepath).array_get(rt.new_string('Name'))])).str() +
					'</strong>'),
			]))
		}
		rt.call_function('wp_admin_notice', [
			rt.call_function('sprintf', [
				rt.new_string('<p>%1$s</p><ul>%2$s</ul><p>%3$s</p>'),
				rt.call_function('__', [
					rt.new_string('These plugins cannot be activated because their requirements are invalid.'),
				]),
				var_circular_dependency_lines.clone(),
				rt.call_function('__', [
					rt.new_string('Please contact the plugin authors for more information.'),
				]),
			]),
			rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'warning' },
				rt.ArrayItem{ key: 'paragraph_wrap', val: false },
			]),
		])
	}
}

fn Class_WP_Plugin_Dependencies.check_plugin_dependencies_during_ajax() {
	rt.call_function('check_ajax_referer', [rt.new_string('updates')])
	if !rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('slug'))) {
		rt.call_function('wp_send_json_error', [
			rt.create_array([rt.ArrayItem{ key: 'slug', val: '' },
				rt.ArrayItem{ key: 'pluginName', val: '' }, rt.ArrayItem{
					key: 'errorCode'
					val: 'no_plugin_specified'
				}, rt.ArrayItem{ key: 'errorMessage', val: rt.call_function('__', [
					rt.new_string('No plugin specified.'),
				]) }]),
		])
	}
	mut var_slug := rt.call_function('sanitize_key', [
		rt.call_function('wp_unslash',
			[rt.get_superglobal('_POST').array_get(rt.new_string('slug'))]),
	])
	mut var_status := {
		'slug': var_slug
	}
	Class_WP_Plugin_Dependencies.get_plugins()
	Class_WP_Plugin_Dependencies.get_plugin_dirnames()
	if !(rt.get_static_prop('WP_Plugin_Dependencies', 'plugin_dirnames').array_isset(var_slug)) {
		var_status['errorCode'] = rt.new_string('plugin_not_installed')
		var_status['errorMessage'] = rt.call_function('__', [
			rt.new_string('The plugin is not installed.'),
		])
		rt.call_function('wp_send_json_error', [
			rt.create_array_from_native_map(var_status),
		])
	}
	mut var_plugin_file :=
		rt.get_static_prop('WP_Plugin_Dependencies', 'plugin_dirnames').array_get(var_slug)
	var_status['pluginName'] =
		rt.get_static_prop('WP_Plugin_Dependencies', 'plugins').array_get(var_plugin_file).array_get(rt.new_string('Name'))
	var_status['plugin'] = var_plugin_file.clone()
	if rt.is_true(rt.call_function('current_user_can', [rt.new_string('activate_plugin'), var_plugin_file.clone()]))
		&& rt.is_true(rt.call_function('is_plugin_inactive', [var_plugin_file.clone()])) {
		var_status['activateUrl'] = rt.call_function('add_query_arg', [
			rt.create_array([
				rt.ArrayItem{ key: '_wpnonce', val: rt.call_function('wp_create_nonce', [
					rt.new_string('activate-plugin_' + var_plugin_file.str()),
				]) },
				rt.ArrayItem{ key: 'action', val: 'activate' },
				rt.ArrayItem{ key: 'plugin', val: var_plugin_file },
			]),
			if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) { rt.call_function('network_admin_url', [
					rt.new_string('plugins.php'),
				]) } else { rt.call_function('admin_url', [
					rt.new_string('plugins.php'),
				]) },
		])
	}
	if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{}))
		&& rt.is_true(rt.call_function('current_user_can', [rt.new_string('manage_network_plugins')])) {
		var_status['activateUrl'] = rt.call_function('add_query_arg', [
			rt.create_array([rt.ArrayItem{ key: 'networkwide', val: 1 }]),
			var_status['activateUrl'],
		])
	}
	Class_WP_Plugin_Dependencies.initialize()
	mut var_dependencies := Class_WP_Plugin_Dependencies.get_dependencies(var_plugin_file.clone())
	if !rt.is_true(var_dependencies) {
		var_status['message'] = rt.call_function('__', [
			rt.new_string('The plugin has no required plugins.'),
		])
		rt.call_function('wp_send_json_success', [
			rt.create_array_from_native_map(var_status),
		])
	}
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/plugin.php', '4')
	mut var_inactive_dependencies := rt.new_array()
	mut iter_7 := var_dependencies.iterator()
	for {
		item_7 := iter_7.next() or { break }
		mut var_dependency := item_7.val
		if rt.is_true(rt.identical(rt.new_bool(false), rt.get_static_prop('WP_Plugin_Dependencies', 'plugin_dirnames').array_get(var_dependency)))
			|| rt.is_true(rt.call_function('is_plugin_inactive', [rt.get_static_prop('WP_Plugin_Dependencies', 'plugin_dirnames').array_get(var_dependency)])) {
			var_inactive_dependencies << var_dependency.clone()
		}
	}
	if !(!rt.is_true(var_inactive_dependencies)) {
		closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_dependency := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			if rt.get_static_prop('WP_Plugin_Dependencies', 'dependency_api_data').array_get(var_dependency).array_isset(rt.new_string('Name')) {
				mut var_inactive_dependency_name := rt.get_static_prop('WP_Plugin_Dependencies',
					'dependency_api_data').array_get(var_dependency).array_get(rt.new_string('Name'))
			} else {
				var_inactive_dependency_name = var_dependency
			}
			return
		}
		closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_dependency := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			if rt.get_static_prop('WP_Plugin_Dependencies', 'dependency_api_data').array_get(var_dependency).array_isset(rt.new_string('Name')) {
				mut var_inactive_dependency_name := rt.get_static_prop('WP_Plugin_Dependencies',
					'dependency_api_data').array_get(var_dependency).array_get(rt.new_string('Name'))
			} else {
				var_inactive_dependency_name = var_dependency
			}
			return
		}
		mut var_inactive_dependency_names := rt.call_function('array_map', [
			rt.new_closure(closure_1_fn),
			rt.create_array_from_list(var_inactive_dependencies),
		])
		var_status['errorCode'] = rt.new_string('inactive_dependencies')
		var_status['errorMessage'] = rt.call_function('sprintf', [
			rt.call_function('__', [
				rt.new_string('The following plugins must be activated first: %s.'),
			]),
			rt.call_function('implode', [
				rt.new_string(', '),
				var_inactive_dependency_names.clone(),
			]),
		])
		var_status['errorData'] = rt.call_function('array_combine', [
			rt.create_array_from_list(var_inactive_dependencies),
			var_inactive_dependency_names.clone(),
		])
		rt.call_function('wp_send_json_error', [
			rt.create_array_from_native_map(var_status),
		])
	}
	var_status['message'] = rt.call_function('__', [
		rt.new_string('All required plugins are installed and activated.'),
	])
	rt.call_function('wp_send_json_success', [
		rt.create_array_from_native_map(var_status),
	])
}

fn Class_WP_Plugin_Dependencies.get_plugins() rt.PhpVal {
	if rt.is_true(rt.new_bool(rt.get_static_prop('WP_Plugin_Dependencies', 'plugins').is_array())) {
		return rt.get_static_prop('WP_Plugin_Dependencies', 'plugins')
	}
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/plugin.php', '4')
	rt.set_static_prop('WP_Plugin_Dependencies', 'plugins', rt.call_function('get_plugins',
		[]rt.PhpVal{}))
	return rt.get_static_prop('WP_Plugin_Dependencies', 'plugins')
}

fn Class_WP_Plugin_Dependencies.read_dependencies_from_plugin_headers() {
	rt.set_static_prop('WP_Plugin_Dependencies', 'dependencies', rt.new_array())
	rt.set_static_prop('WP_Plugin_Dependencies', 'dependency_slugs', rt.new_array())
	rt.set_static_prop('WP_Plugin_Dependencies', 'dependent_slugs', rt.new_array())
	mut var_plugins := Class_WP_Plugin_Dependencies.get_plugins()
	mut iter_8 := var_plugins.iterator()
	for {
		item_8 := iter_8.next() or { break }
		mut var_header := item_8.val
		mut var_plugin := item_8.key
		if rt.is_true(rt.identical(rt.new_string(''),
			var_header.array_get(rt.new_string('RequiresPlugins'))))
		{
			continue
		}
		mut var_dependency_slugs :=
			Class_WP_Plugin_Dependencies.sanitize_dependency_slugs(var_header.array_get(rt.new_string('RequiresPlugins')))
		rt.get_static_prop('WP_Plugin_Dependencies', 'dependencies').array_set(var_plugin,
			var_dependency_slugs.clone())
		rt.set_static_prop('WP_Plugin_Dependencies', 'dependency_slugs', rt.call_function('array_merge', [
			rt.get_static_prop('WP_Plugin_Dependencies', 'dependency_slugs'),
			var_dependency_slugs.clone(),
		]))
		mut var_dependent_slug := Class_WP_Plugin_Dependencies.convert_to_slug(var_plugin.clone())
		rt.get_static_prop('WP_Plugin_Dependencies', 'dependent_slugs').array_set(var_plugin,
			var_dependent_slug.clone())
	}
	rt.set_static_prop('WP_Plugin_Dependencies', 'dependency_slugs', rt.call_function('array_unique', [
		rt.get_static_prop('WP_Plugin_Dependencies', 'dependency_slugs'),
	]))
}

fn Class_WP_Plugin_Dependencies.sanitize_dependency_slugs(var_slugs rt.PhpVal) rt.PhpVal {
	mut var_slugs_mutated := var_slugs
	mut var_sanitized_slugs := rt.new_array()
	var_slugs_mutated = rt.call_function('explode', [rt.new_string(','),
		var_slugs_mutated.clone()])
	mut iter_9 := var_slugs_mutated.iterator()
	for {
		item_9 := iter_9.next() or { break }
		mut var_slug := item_9.val
		var_slug = rt.new_string(var_slug.clone().to_string().trim_space())
		var_slug = rt.call_function('apply_filters', [
			rt.new_string('wp_plugin_dependencies_slug'),
			var_slug.clone(),
		])
		if rt.is_true(rt.call_function('preg_match', [
			rt.new_string('/^[a-z0-9]+(-[a-z0-9]+)*$/mu'),
			var_slug.clone(),
		]))
		{
			var_sanitized_slugs.array_push(var_slug.clone())
		}
	}
	var_sanitized_slugs = rt.call_function('array_unique', [var_sanitized_slugs.clone()])
	rt.call_function('sort', [var_sanitized_slugs.clone()])
	return var_sanitized_slugs.clone()
}

fn Class_WP_Plugin_Dependencies.get_dependency_filepaths() rt.PhpVal {
	if rt.is_true(rt.new_bool(rt.get_static_prop('WP_Plugin_Dependencies', 'dependency_filepaths').is_array())) {
		return rt.get_static_prop('WP_Plugin_Dependencies', 'dependency_filepaths')
	}
	if rt.is_true(rt.identical(rt.new_null(), rt.get_static_prop('WP_Plugin_Dependencies',
		'dependency_slugs')))
	{
		return rt.new_array()
	}
	rt.set_static_prop('WP_Plugin_Dependencies', 'dependency_filepaths', rt.new_array())
	mut var_plugin_dirnames := Class_WP_Plugin_Dependencies.get_plugin_dirnames()
	mut iter_10 := rt.get_static_prop('WP_Plugin_Dependencies', 'dependency_slugs').iterator()
	for {
		item_10 := iter_10.next() or { break }
		mut var_slug := item_10.val
		if var_plugin_dirnames.array_isset(var_slug) {
			rt.get_static_prop('WP_Plugin_Dependencies', 'dependency_filepaths').array_set(var_slug,
				var_plugin_dirnames.array_get(var_slug))
			continue
		}
		rt.get_static_prop('WP_Plugin_Dependencies', 'dependency_filepaths').array_set(var_slug,
			false)
	}
	return rt.get_static_prop('WP_Plugin_Dependencies', 'dependency_filepaths')
}

fn Class_WP_Plugin_Dependencies.get_dependency_api_data() rt.PhpVal {
	mut var_pagenow := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_admin', []rt.PhpVal{})))))|| (rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('plugins.php'), var_pagenow))))
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('plugin-install.php'), var_pagenow))))) {
		return rt.new_null()
	}
	if rt.is_true(rt.new_bool(rt.get_static_prop('WP_Plugin_Dependencies', 'dependency_api_data').is_array())) {
		return rt.get_static_prop('WP_Plugin_Dependencies', 'dependency_api_data')
	}
	mut var_plugins := Class_WP_Plugin_Dependencies.get_plugins()
	rt.set_static_prop('WP_Plugin_Dependencies', 'dependency_api_data', rt.cast_array(rt.call_function('get_site_transient', [
		rt.new_string('wp_plugin_dependencies_plugin_data'),
	])))
	mut iter_11 := rt.get_static_prop('WP_Plugin_Dependencies', 'dependency_slugs').iterator()
	for {
		item_11 := iter_11.next() or { break }
		mut var_slug := item_11.val
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('get_site_transient', [
			rt.new_string('wp_plugin_dependencies_plugin_timeout_${var_slug.to_string()}'),
		])))))
		{
			rt.get_static_prop('WP_Plugin_Dependencies', 'dependency_api_data').array_unset(var_slug)
			rt.call_function('set_site_transient', [
				rt.new_string('wp_plugin_dependencies_plugin_timeout_${var_slug.to_string()}'),
				rt.new_bool(true),
				rt.mul(rt.new_int(12), rt.get_constant('HOUR_IN_SECONDS')),
			])
		}
		if rt.get_static_prop('WP_Plugin_Dependencies', 'dependency_api_data').array_isset(var_slug) {
			if rt.is_true(rt.identical(rt.new_bool(false), rt.get_static_prop('WP_Plugin_Dependencies',
				'dependency_api_data').array_get(var_slug)))
			{
				mut var_dependency_file :=
					Class_WP_Plugin_Dependencies.get_dependency_filepath(var_slug.clone())
				if rt.is_true(rt.identical(rt.new_bool(false), var_dependency_file)) {
					rt.get_static_prop('WP_Plugin_Dependencies', 'dependency_api_data').array_set(var_slug, rt.create_array([
						rt.ArrayItem{ key: 'Name', val: var_slug },
					]))
				} else {
					rt.get_static_prop('WP_Plugin_Dependencies', 'dependency_api_data').array_set(var_slug, rt.create_array([
						rt.ArrayItem{
							key: 'Name'
							val: var_plugins.array_get(var_dependency_file).array_get(rt.new_string('Name'))
						},
					]))
				}
				continue
			}
			if !(!rt.is_true(rt.get_static_prop('WP_Plugin_Dependencies', 'dependency_api_data').array_get(var_slug).array_get(rt.new_string('last_updated')))) {
				continue
			}
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
			rt.new_string('plugins_api'),
		])))))
		{
			rt.include_file(
				(rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/plugin-install.php', '4')
		}
		mut var_information := rt.call_function('plugins_api', [
			rt.new_string('plugin_information'),
			rt.create_array([rt.ArrayItem{ key: 'slug', val: var_slug },
				rt.ArrayItem{ key: 'fields', val: rt.create_array([
					rt.ArrayItem{ key: 'short_description', val: true },
					rt.ArrayItem{ key: 'icons', val: true },
				]) }]),
		])
		if rt.is_true(rt.call_function('is_wp_error', [var_information.clone()])) {
			continue
		}
		rt.get_static_prop('WP_Plugin_Dependencies', 'dependency_api_data').array_set(var_slug,
			rt.cast_array(var_information))
		rt.get_static_prop('WP_Plugin_Dependencies', 'dependency_api_data').array_get_mut(var_slug).array_set('Name', rt.get_static_prop('WP_Plugin_Dependencies',
			'dependency_api_data').array_get(var_slug).array_get(rt.new_string('name')))
		rt.call_function('set_site_transient', [
			rt.new_string('wp_plugin_dependencies_plugin_data'),
			rt.get_static_prop('WP_Plugin_Dependencies', 'dependency_api_data'),
			rt.new_int(0),
		])
	}
	mut var_differences := rt.call_function('array_diff', [
		rt.func_array_keys(rt.get_static_prop('WP_Plugin_Dependencies', 'dependency_api_data')),
		rt.get_static_prop('WP_Plugin_Dependencies', 'dependency_slugs'),
	])
	mut iter_12 := var_differences.iterator()
	for {
		item_12 := iter_12.next() or { break }
		mut var_difference := item_12.val
		rt.get_static_prop('WP_Plugin_Dependencies', 'dependency_api_data').array_unset(var_difference)
	}
	rt.call_function('ksort', [
		rt.get_static_prop('WP_Plugin_Dependencies', 'dependency_api_data'),
	])
	rt.set_static_prop('WP_Plugin_Dependencies', 'dependency_api_data', rt.call_function('array_filter', [
		rt.get_static_prop('WP_Plugin_Dependencies', 'dependency_api_data'),
	]))
	rt.call_function('set_site_transient', [
		rt.new_string('wp_plugin_dependencies_plugin_data'),
		rt.get_static_prop('WP_Plugin_Dependencies', 'dependency_api_data'),
		rt.new_int(0),
	])
	return rt.get_static_prop('WP_Plugin_Dependencies', 'dependency_api_data')
}

fn Class_WP_Plugin_Dependencies.get_plugin_dirnames() rt.PhpVal {
	if rt.is_true(rt.new_bool(rt.get_static_prop('WP_Plugin_Dependencies', 'plugin_dirnames').is_array())) {
		return rt.get_static_prop('WP_Plugin_Dependencies', 'plugin_dirnames')
	}
	rt.set_static_prop('WP_Plugin_Dependencies', 'plugin_dirnames', rt.new_array())
	mut var_plugin_files := rt.func_array_keys(Class_WP_Plugin_Dependencies.get_plugins())
	mut iter_13 := var_plugin_files.iterator()
	for {
		item_13 := iter_13.next() or { break }
		mut var_plugin_file := item_13.val
		mut var_slug := Class_WP_Plugin_Dependencies.convert_to_slug(var_plugin_file.clone())
		rt.get_static_prop('WP_Plugin_Dependencies', 'plugin_dirnames').array_set(var_slug,
			var_plugin_file.clone())
	}
	return rt.get_static_prop('WP_Plugin_Dependencies', 'plugin_dirnames')
}

fn Class_WP_Plugin_Dependencies.get_circular_dependencies() rt.PhpVal {
	if rt.is_true(rt.new_bool(rt.get_static_prop('WP_Plugin_Dependencies',
		'circular_dependencies_pairs').is_array()))
	{
		return rt.get_static_prop('WP_Plugin_Dependencies', 'circular_dependencies_pairs')
	}
	if rt.is_true(rt.identical(rt.new_null(), rt.get_static_prop('WP_Plugin_Dependencies',
		'dependencies')))
	{
		return rt.new_array()
	}
	rt.set_static_prop('WP_Plugin_Dependencies', 'circular_dependencies_slugs', rt.new_array())
	rt.set_static_prop('WP_Plugin_Dependencies', 'circular_dependencies_pairs', rt.new_array())
	mut iter_14 := rt.get_static_prop('WP_Plugin_Dependencies', 'dependencies').iterator()
	for {
		item_14 := iter_14.next() or { break }
		mut var_dependencies := item_14.val
		mut var_dependent := item_14.key
		mut var_dependent_slug :=
			Class_WP_Plugin_Dependencies.convert_to_slug(var_dependent.clone())
		rt.set_static_prop('WP_Plugin_Dependencies', 'circular_dependencies_pairs', rt.call_function('array_merge', [
			rt.get_static_prop('WP_Plugin_Dependencies', 'circular_dependencies_pairs'),
			Class_WP_Plugin_Dependencies.check_for_circular_dependencies(rt.create_array([
				rt.ArrayItem{ key: none, val: var_dependent_slug },
			]), var_dependencies.clone()),
		]))
	}
	return rt.get_static_prop('WP_Plugin_Dependencies', 'circular_dependencies_pairs')
}

fn Class_WP_Plugin_Dependencies.check_for_circular_dependencies(var_dependents rt.PhpVal, var_dependencies rt.PhpVal) rt.PhpVal {
	mut var_dependents_mutated := var_dependents
	mut var_dependencies_mutated := var_dependencies
	mut var_circular_dependencies_pairs := rt.new_array()
	mut var_dependents_location_in_its_own_dependencies := rt.call_function('array_intersect', [
		var_dependents_mutated.clone(),
		var_dependencies_mutated.clone(),
	])
	if !(!rt.is_true(var_dependents_location_in_its_own_dependencies)) {
		mut iter_15 := var_dependents_location_in_its_own_dependencies.iterator()
		for {
			item_15 := iter_15.next() or { break }
			mut var_self_dependency := item_15.val
			rt.get_static_prop('WP_Plugin_Dependencies', 'circular_dependencies_slugs').array_push(var_self_dependency.clone())
			var_circular_dependencies_pairs.array_push(rt.create_array([
				rt.ArrayItem{ key: none, val: var_self_dependency },
				rt.ArrayItem{ key: none, val: var_self_dependency },
			]))
			var_dependencies_mutated.array_unset(rt.call_function('array_search', [
				var_self_dependency.clone(),
				var_dependencies_mutated.clone(),
				rt.new_bool(true),
			]))
		}
	}
	mut iter_16 := var_dependencies_mutated.iterator()
	for {
		item_16 := iter_16.next() or { break }
		mut var_dependency := item_16.val
		mut var_dependency_location_in_dependents := rt.call_function('array_search', [
			var_dependency.clone(),
			rt.get_static_prop('WP_Plugin_Dependencies', 'dependent_slugs'),
			rt.new_bool(true),
		])
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false),
			var_dependency_location_in_dependents))))
		{
			mut var_dependencies_of_the_dependency := rt.get_static_prop('WP_Plugin_Dependencies',
				'dependencies').array_get(var_dependency_location_in_dependents)
			mut iter_17 := var_dependents_mutated.iterator()
			for {
				item_17 := iter_17.next() or { break }
				mut var_dependent := item_17.val
				mut var_dependent_location_in_dependency_dependencies := rt.call_function('array_search', [
					var_dependent.clone(),
					var_dependencies_of_the_dependency.clone(),
					rt.new_bool(true),
				])
				if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false),
					var_dependent_location_in_dependency_dependencies))))
				{
					rt.get_static_prop('WP_Plugin_Dependencies', 'circular_dependencies_slugs').array_push(var_dependent.clone())
					rt.get_static_prop('WP_Plugin_Dependencies', 'circular_dependencies_slugs').array_push(var_dependency.clone())
					var_circular_dependencies_pairs.array_push(rt.create_array([
						rt.ArrayItem{ key: none, val: var_dependent },
						rt.ArrayItem{ key: none, val: var_dependency },
					]))
					var_dependencies_of_the_dependency.array_unset(var_dependent_location_in_dependency_dependencies)
				}
			}
			var_dependents_mutated.array_push(var_dependency.clone())
			var_circular_dependencies_pairs = rt.call_function('array_merge', [
				var_circular_dependencies_pairs.clone(),
				Class_WP_Plugin_Dependencies.check_for_circular_dependencies(var_dependents_mutated.clone(), rt.call_function('array_unique', [
					var_dependencies_of_the_dependency.clone(),
				])),
			])
		}
	}
	return var_circular_dependencies_pairs.clone()
}

fn Class_WP_Plugin_Dependencies.convert_to_slug(var_plugin_file rt.PhpVal) string {
	mut var_plugin_file_mutated := var_plugin_file
	if rt.is_true(rt.identical(rt.new_string('hello.php'), var_plugin_file_mutated)) {
		return 'hello-dolly'
	}
	return (if rt.is_true(rt.call_function('str_contains', [var_plugin_file_mutated.clone(),
		rt.new_string('/')]))
	{
		rt.call_function('dirname', [var_plugin_file_mutated.clone()])
	} else {
		rt.call_function('str_replace', [rt.new_string('.php'),
			rt.new_string(''), var_plugin_file_mutated.clone()])
	}).str()
}

fn create_wp_plugin_dependencies(_args ...rt.PhpVal) &Class_WP_Plugin_Dependencies {
	mut obj := &Class_WP_Plugin_Dependencies{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Plugin_Dependencies) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'initialize' {
			Class_WP_Plugin_Dependencies.initialize()
			return rt.new_null()
		}
		'has_dependents' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WP_Plugin_Dependencies.has_dependents(dispatch_arg_0)
		}
		'has_dependencies' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WP_Plugin_Dependencies.has_dependencies(dispatch_arg_0)
		}
		'has_active_dependents' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(Class_WP_Plugin_Dependencies.has_active_dependents(dispatch_arg_0))
		}
		'get_dependents' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WP_Plugin_Dependencies.get_dependents(dispatch_arg_0)
		}
		'get_dependencies' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WP_Plugin_Dependencies.get_dependencies(dispatch_arg_0)
		}
		'get_dependent_filepath' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WP_Plugin_Dependencies.get_dependent_filepath(dispatch_arg_0)
		}
		'has_unmet_dependencies' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(Class_WP_Plugin_Dependencies.has_unmet_dependencies(dispatch_arg_0))
		}
		'has_circular_dependency' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(Class_WP_Plugin_Dependencies.has_circular_dependency(dispatch_arg_0))
		}
		'get_dependent_names' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WP_Plugin_Dependencies.get_dependent_names(dispatch_arg_0)
		}
		'get_dependency_names' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WP_Plugin_Dependencies.get_dependency_names(dispatch_arg_0)
		}
		'get_dependency_filepath' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(Class_WP_Plugin_Dependencies.get_dependency_filepath(dispatch_arg_0))
		}
		'get_dependency_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WP_Plugin_Dependencies.get_dependency_data(dispatch_arg_0)
		}
		'display_admin_notice_for_unmet_dependencies' {
			Class_WP_Plugin_Dependencies.display_admin_notice_for_unmet_dependencies()
			return rt.new_null()
		}
		'display_admin_notice_for_circular_dependencies' {
			Class_WP_Plugin_Dependencies.display_admin_notice_for_circular_dependencies()
			return rt.new_null()
		}
		'check_plugin_dependencies_during_ajax' {
			Class_WP_Plugin_Dependencies.check_plugin_dependencies_during_ajax()
			return rt.new_null()
		}
		'get_plugins' {
			return Class_WP_Plugin_Dependencies.get_plugins()
		}
		'read_dependencies_from_plugin_headers' {
			Class_WP_Plugin_Dependencies.read_dependencies_from_plugin_headers()
			return rt.new_null()
		}
		'sanitize_dependency_slugs' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WP_Plugin_Dependencies.sanitize_dependency_slugs(dispatch_arg_0)
		}
		'get_dependency_filepaths' {
			return Class_WP_Plugin_Dependencies.get_dependency_filepaths()
		}
		'get_dependency_api_data' {
			return Class_WP_Plugin_Dependencies.get_dependency_api_data()
		}
		'get_plugin_dirnames' {
			return Class_WP_Plugin_Dependencies.get_plugin_dirnames()
		}
		'get_circular_dependencies' {
			return Class_WP_Plugin_Dependencies.get_circular_dependencies()
		}
		'check_for_circular_dependencies' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_WP_Plugin_Dependencies.check_for_circular_dependencies(dispatch_arg_0,
				dispatch_arg_1)
		}
		'convert_to_slug' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(Class_WP_Plugin_Dependencies.convert_to_slug(dispatch_arg_0))
		}
		else {
			return none
		}
	}
}

fn (this &Class_WP_Plugin_Dependencies) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Plugin_Dependencies) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
