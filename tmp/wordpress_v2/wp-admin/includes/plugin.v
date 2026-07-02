import rt
import crypto.md5

fn get_plugin_data(var_plugin_file rt.PhpVal, markup bool, translate bool) rt.PhpVal {
	mut var_markup := markup
	mut var_translate := translate
	mut var_default_headers := map[string]rt.PhpVal{}
	mut var_plugin_data := rt.new_null()
	mut var_plugin_slug := rt.new_null()
	var_default_headers = { 'Name': 'Plugin Name', 'PluginURI': 'Plugin URI', 'Version': 'Version', 'Description': 'Description', 'Author': 'Author', 'AuthorURI': 'Author URI', 'TextDomain': 'Text Domain', 'DomainPath': 'Domain Path', 'Network': 'Network', 'RequiresWP': 'Requires at least', 'RequiresPHP': 'Requires PHP', 'UpdateURI': 'Update URI', 'RequiresPlugins': 'Requires Plugins', '_sitewide': 'Site Wide Only' }
	var_plugin_data = rt.call_function('get_file_data', [var_plugin_file.clone(), rt.create_array_from_native_map(var_default_headers), rt.new_string('plugin')])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_plugin_data.array_get(rt.new_string('Network')))))) && rt.is_true(var_plugin_data.array_get(rt.new_string('_sitewide'))) {
		rt.call_function('_deprecated_argument', [rt.new_string(@FN), rt.new_string('3.0.0'), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('The %1$s plugin header is deprecated. Use %2$s instead.')]), rt.new_string('<code>Site Wide Only: true</code>'), rt.new_string('<code>Network: true</code>')])])
		var_plugin_data.array_set('Network', var_plugin_data.array_get(rt.new_string('_sitewide')))
	}
	var_plugin_data.array_set('Network', rt.identical(rt.new_string('true'), rt.new_string(var_plugin_data.array_get(rt.new_string('Network')).to_string().to_lower())))
	var_plugin_data.array_unset(rt.new_string('_sitewide'))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_plugin_data.array_get(rt.new_string('TextDomain')))))) {
		var_plugin_slug = rt.call_function('dirname', [rt.call_function('plugin_basename', [var_plugin_file.clone()])])
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('.'), var_plugin_slug)))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('str_contains', [var_plugin_slug.clone(), rt.new_string('/')]))))) {
			var_plugin_data.array_set('TextDomain', var_plugin_slug.clone())
		}
	}
	if var_markup || var_translate {
	var_plugin_data = _get_plugin_data_markup_translate(var_plugin_file.clone(), var_plugin_data.clone(), markup, translate)
	} else {
		var_plugin_data.array_set('Title', var_plugin_data.array_get(rt.new_string('Name')))
		var_plugin_data.array_set('AuthorName', var_plugin_data.array_get(rt.new_string('Author')))
	}
	return var_plugin_data.clone()
}

fn _get_plugin_data_markup_translate(var_plugin_file_arg rt.PhpVal, var_plugin_data rt.PhpVal, markup bool, translate bool) rt.PhpVal {
	mut var_markup := markup
	mut var_translate := translate
	mut var_plugin_file := var_plugin_file_arg
	mut var_textdomain := rt.new_null()
	mut var_field := rt.new_null()
	mut var_allowed_tags_in_links := map[string]rt.PhpVal{}
	mut var_allowed_tags := rt.new_null()
	var_plugin_file = rt.call_function('plugin_basename', [var_plugin_file.clone()])
	if var_translate {
		var_textdomain = var_plugin_data.array_get(rt.new_string('TextDomain'))
		if rt.is_true(var_textdomain) {
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_textdomain_loaded', [var_textdomain.clone()]))))) {
				if rt.is_true(var_plugin_data.array_get(rt.new_string('DomainPath'))) {
					rt.call_function('load_plugin_textdomain', [var_textdomain.clone(), rt.new_bool(false), rt.new_string((rt.call_function('dirname', [var_plugin_file.clone()])).str() + (var_plugin_data.array_get(rt.new_string('DomainPath'))).str())])
				} else {
					rt.call_function('load_plugin_textdomain', [var_textdomain.clone(), rt.new_bool(false), rt.call_function('dirname', [var_plugin_file.clone()])])
				}
			}
		} else if rt.is_true(rt.identical(rt.new_string('hello.php'), rt.call_function('basename', [var_plugin_file.clone()]))) {
		var_textdomain = rt.new_string('default')
		}
		if rt.is_true(var_textdomain) {
			mut iter_1 := rt.create_array([rt.ArrayItem{ key: none, val: 'Name' }, rt.ArrayItem{ key: none, val: 'PluginURI' }, rt.ArrayItem{ key: none, val: 'Description' }, rt.ArrayItem{ key: none, val: 'Author' }, rt.ArrayItem{ key: none, val: 'AuthorURI' }, rt.ArrayItem{ key: none, val: 'Version' }]).iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_field_shadow := item_1.val
				if !(!rt.is_true(var_plugin_data.array_get(var_field_shadow))) {
					var_plugin_data.array_set(var_field_shadow, rt.call_function('translate', [var_plugin_data.array_get(var_field_shadow), var_textdomain.clone()]))
				}
			}
		}
	}
	var_allowed_tags_in_links = { 'abbr': { 'title': rt.new_bool(true) }, 'acronym': { 'title': rt.new_bool(true) }, 'code': rt.new_bool(true), 'em': rt.new_bool(true), 'strong': rt.new_bool(true) }
	var_allowed_tags = var_allowed_tags_in_links.clone()
	var_allowed_tags.array_set('a', rt.create_array([rt.ArrayItem{ key: 'href', val: true }, rt.ArrayItem{ key: 'title', val: true }]))
	var_plugin_data.array_set('Name', rt.call_function('wp_kses', [var_plugin_data.array_get(rt.new_string('Name')), rt.create_array_from_native_map(var_allowed_tags_in_links)]))
	var_plugin_data.array_set('Author', rt.call_function('wp_kses', [var_plugin_data.array_get(rt.new_string('Author')), var_allowed_tags.clone()]))
	var_plugin_data.array_set('Description', rt.call_function('wp_kses', [var_plugin_data.array_get(rt.new_string('Description')), var_allowed_tags.clone()]))
	var_plugin_data.array_set('Version', rt.call_function('wp_kses', [var_plugin_data.array_get(rt.new_string('Version')), var_allowed_tags.clone()]))
	var_plugin_data.array_set('PluginURI', rt.call_function('esc_url', [var_plugin_data.array_get(rt.new_string('PluginURI'))]))
	var_plugin_data.array_set('AuthorURI', rt.call_function('esc_url', [var_plugin_data.array_get(rt.new_string('AuthorURI'))]))
	var_plugin_data.array_set('Title', var_plugin_data.array_get(rt.new_string('Name')))
	var_plugin_data.array_set('AuthorName', var_plugin_data.array_get(rt.new_string('Author')))
	if var_markup {
		if rt.is_true(var_plugin_data.array_get(rt.new_string('PluginURI'))) && rt.is_true(var_plugin_data.array_get(rt.new_string('Name'))) {
			var_plugin_data.array_set('Title', '<a href="' + (var_plugin_data.array_get(rt.new_string('PluginURI'))).str() + '">' + (var_plugin_data.array_get(rt.new_string('Name'))).str() + '</a>')
		}
		if rt.is_true(var_plugin_data.array_get(rt.new_string('AuthorURI'))) && rt.is_true(var_plugin_data.array_get(rt.new_string('Author'))) {
			var_plugin_data.array_set('Author', '<a href="' + (var_plugin_data.array_get(rt.new_string('AuthorURI'))).str() + '">' + (var_plugin_data.array_get(rt.new_string('Author'))).str() + '</a>')
		}
		var_plugin_data.array_set('Description', rt.call_function('wptexturize', [var_plugin_data.array_get(rt.new_string('Description'))]))
		if rt.is_true(var_plugin_data.array_get(rt.new_string('Author'))) {
			var_plugin_data.array_get(rt.new_string('Description')) = rt.concat(var_plugin_data.array_get(rt.new_string('Description')), rt.call_function('sprintf', [rt.new_string(' <cite>' + (rt.call_function('__', [rt.new_string('By %s.')])).str() + '</cite>'), var_plugin_data.array_get(rt.new_string('Author'))]))
		}
	}
	return var_plugin_data.clone()
}

fn get_plugin_files(var_plugin rt.PhpVal) rt.PhpVal {
	mut var_plugin_file := rt.new_null()
	mut var_dir := rt.new_null()
	mut var_plugin_files := rt.new_null()
	mut var_exclusions := rt.new_null()
	mut var_list_files := rt.new_null()
	var_plugin_file = rt.new_string((rt.get_constant('WP_PLUGIN_DIR')).str() + '/' + (var_plugin).str())
	var_dir = rt.call_function('dirname', [var_plugin_file.clone()])
	var_plugin_files = rt.create_array([rt.ArrayItem{ key: none, val: rt.call_function('plugin_basename', [var_plugin_file.clone()]) }])
	if rt.is_true(rt.call_function('is_dir', [var_dir.clone()])) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.get_constant('WP_PLUGIN_DIR'), var_dir)))) {
	var_exclusions = rt.cast_array(rt.call_function('apply_filters', [rt.new_string('plugin_files_exclusions'), rt.create_array([rt.ArrayItem{ key: none, val: 'CVS' }, rt.ArrayItem{ key: none, val: 'node_modules' }, rt.ArrayItem{ key: none, val: 'vendor' }, rt.ArrayItem{ key: none, val: 'bower_components' }])]))
	var_list_files = rt.call_function('list_files', [var_dir.clone(), rt.new_int(100), var_exclusions.clone()])
	var_list_files = rt.call_function('array_map', [rt.new_string('plugin_basename'), var_list_files.clone()])
	var_plugin_files = rt.call_function('array_merge', [var_plugin_files.clone(), var_list_files.clone()])
	var_plugin_files = rt.call_function('array_values', [rt.call_function('array_unique', [var_plugin_files.clone()])])
	}
	return var_plugin_files.clone()
}

fn get_plugins(plugin_folder string) rt.PhpVal {
	mut var_plugin_folder := plugin_folder
	mut var_cache_plugins := rt.new_null()
	mut var_wp_plugins := rt.new_null()
	mut var_plugin_root := rt.new_null()
	mut var_plugins_dir := rt.new_null()
	mut var_plugin_files := rt.new_null()
	mut var_file := rt.new_null()
	mut var_plugins_subdir := rt.new_null()
	mut var_subfile := rt.new_null()
	mut var_plugin_file := rt.new_null()
	mut var_plugin_data := rt.new_null()
	var_cache_plugins = rt.call_function('wp_cache_get', [rt.new_string('plugins'), rt.new_string('plugins')])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_cache_plugins)))) {
	var_cache_plugins = rt.new_array()
	}
	if var_cache_plugins.array_isset(rt.new_string(plugin_folder)) {
		return var_cache_plugins.array_get(rt.new_string(plugin_folder))
	}
	var_wp_plugins = rt.new_array()
	var_plugin_root = rt.get_constant('WP_PLUGIN_DIR')
	if !(plugin_folder == '') {
		var_plugin_root = rt.concat(var_plugin_root, rt.new_string(plugin_folder))
	}
	var_plugins_dir = rt.call_function('opendir', [var_plugin_root.clone()])
	var_plugin_files = rt.new_array()
	if rt.is_true(var_plugins_dir) {
		var_file = rt.call_function('readdir', [var_plugins_dir.clone()])
		for rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_file, rt.new_bool(false))))) {
			if rt.is_true(rt.call_function('str_starts_with', [var_file.clone(), rt.new_string('.')])) {
				continue
			}
			if rt.is_true(rt.call_function('is_dir', [rt.new_string((var_plugin_root).str() + '/' + (var_file).str())])) {
				var_plugins_subdir = rt.call_function('opendir', [rt.new_string((var_plugin_root).str() + '/' + (var_file).str())])
				if rt.is_true(var_plugins_subdir) {
					var_subfile = rt.call_function('readdir', [var_plugins_subdir.clone()])
					for rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_subfile, rt.new_bool(false))))) {
						if rt.is_true(rt.call_function('str_starts_with', [var_subfile.clone(), rt.new_string('.')])) {
							continue
						}
						if rt.is_true(rt.call_function('str_ends_with', [var_subfile.clone(), rt.new_string('.php')])) {
							var_plugin_files.array_push("${var_file.to_string()}/${var_subfile.to_string()}")
						}
					}
					rt.call_function('closedir', [var_plugins_subdir.clone()])
				}
			} else if rt.is_true(rt.call_function('str_ends_with', [var_file.clone(), rt.new_string('.php')])) {
				var_plugin_files.array_push(var_file.clone())
			}
		}
		rt.call_function('closedir', [var_plugins_dir.clone()])
	}
	if !rt.is_true(var_plugin_files) {
		return var_wp_plugins.clone()
	}
	mut iter_2 := var_plugin_files.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_plugin_file_shadow := item_2.val
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_readable', [rt.new_string("${var_plugin_root.to_string()}/${var_plugin_file.to_string()}")]))))) {
			continue
		}
		var_plugin_data = get_plugin_data(rt.new_string("${var_plugin_root.to_string()}/${var_plugin_file.to_string()}"), false, false)
		if !rt.is_true(var_plugin_data.array_get(rt.new_string('Name'))) {
			continue
		}
		var_wp_plugins.array_set(rt.call_function('plugin_basename', [var_plugin_file_shadow.clone()]), var_plugin_data.clone())
	}
	rt.call_function('uasort', [var_wp_plugins.clone(), rt.new_string('_sort_uname_callback')])
	var_cache_plugins.array_set(plugin_folder, var_wp_plugins.clone())
	rt.call_function('wp_cache_set', [rt.new_string('plugins'), var_cache_plugins.clone(), rt.new_string('plugins')])
	return var_wp_plugins.clone()
}

fn get_mu_plugins() rt.PhpVal {
	mut var_wp_plugins := rt.new_null()
	mut var_plugin_files := rt.new_null()
	mut var_plugins_dir := rt.new_null()
	mut var_file := rt.new_null()
	mut var_plugin_file := rt.new_null()
	mut var_plugin_data := rt.new_null()
	var_wp_plugins = rt.new_array()
	var_plugin_files = rt.new_array()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_dir', [rt.get_constant('WPMU_PLUGIN_DIR')]))))) {
		return var_wp_plugins.clone()
	}
	var_plugins_dir = rt.call_function('opendir', [rt.get_constant('WPMU_PLUGIN_DIR')])
	if rt.is_true(var_plugins_dir) {
		var_file = rt.call_function('readdir', [var_plugins_dir.clone()])
		for rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_file, rt.new_bool(false))))) {
			if rt.is_true(rt.call_function('str_ends_with', [var_file.clone(), rt.new_string('.php')])) {
				var_plugin_files.array_push(var_file.clone())
			}
		}
	} else {
		return var_wp_plugins.clone()
	}
	rt.call_function('closedir', [var_plugins_dir.clone()])
	if !rt.is_true(var_plugin_files) {
		return var_wp_plugins.clone()
	}
	mut iter_3 := var_plugin_files.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_plugin_file_shadow := item_3.val
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_readable', [rt.new_string((rt.get_constant('WPMU_PLUGIN_DIR')).str() + "/${var_plugin_file.to_string()}")]))))) {
			continue
		}
		var_plugin_data = get_plugin_data(rt.new_string((rt.get_constant('WPMU_PLUGIN_DIR')).str() + "/${var_plugin_file.to_string()}"), false, false)
		if !rt.is_true(var_plugin_data.array_get(rt.new_string('Name'))) {
			var_plugin_data.array_set('Name', var_plugin_file_shadow.clone())
		}
		var_wp_plugins.array_set(var_plugin_file_shadow, var_plugin_data.clone())
	}
	if var_wp_plugins.array_isset(rt.new_string('index.php')) && rt.is_true(rt.less_equal(rt.call_function('filesize', [rt.new_string((rt.get_constant('WPMU_PLUGIN_DIR')).str() + '/index.php')]), rt.new_int(30))) {
		var_wp_plugins.array_unset(rt.new_string('index.php'))
	}
	rt.call_function('uasort', [var_wp_plugins.clone(), rt.new_string('_sort_uname_callback')])
	return var_wp_plugins.clone()
}

fn _sort_uname_callback(var_a rt.PhpVal, var_b rt.PhpVal) rt.PhpVal {
	return rt.call_function('strnatcasecmp', [var_a.array_get(rt.new_string('Name')), var_b.array_get(rt.new_string('Name'))])
}

fn get_dropins() rt.PhpVal {
	mut var_dropins := rt.new_null()
	mut var_plugin_files := rt.new_null()
	mut var__dropins := rt.new_null()
	mut var_plugins_dir := rt.new_null()
	mut var_file := rt.new_null()
	mut var_plugin_file := rt.new_null()
	mut var_plugin_data := rt.new_null()
	var_dropins = rt.new_array()
	var_plugin_files = rt.new_array()
	var__dropins = _get_dropins()
	var_plugins_dir = rt.call_function('opendir', [rt.get_constant('WP_CONTENT_DIR')])
	if rt.is_true(var_plugins_dir) {
		var_file = rt.call_function('readdir', [var_plugins_dir.clone()])
		for rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_file, rt.new_bool(false))))) {
			if var__dropins.array_isset(var_file) {
				var_plugin_files.array_push(var_file.clone())
			}
		}
	} else {
		return var_dropins.clone()
	}
	rt.call_function('closedir', [var_plugins_dir.clone()])
	if !rt.is_true(var_plugin_files) {
		return var_dropins.clone()
	}
	mut iter_4 := var_plugin_files.iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_plugin_file_shadow := item_4.val
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_readable', [rt.new_string((rt.get_constant('WP_CONTENT_DIR')).str() + "/${var_plugin_file.to_string()}")]))))) {
			continue
		}
		var_plugin_data = get_plugin_data(rt.new_string((rt.get_constant('WP_CONTENT_DIR')).str() + "/${var_plugin_file.to_string()}"), false, false)
		if !rt.is_true(var_plugin_data.array_get(rt.new_string('Name'))) {
			var_plugin_data.array_set('Name', var_plugin_file_shadow.clone())
		}
		var_dropins.array_set(var_plugin_file_shadow, var_plugin_data.clone())
	}
	rt.call_function('uksort', [var_dropins.clone(), rt.new_string('strnatcasecmp')])
	return var_dropins.clone()
}

fn _get_dropins() rt.PhpVal {
	mut var_dropins := rt.new_null()
	var_dropins = rt.create_array([rt.ArrayItem{ key: 'advanced-cache.php', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.call_function('__', [rt.new_string('Advanced caching plugin.')]) }, rt.ArrayItem{ key: none, val: 'WP_CACHE' }]) }, rt.ArrayItem{ key: 'db.php', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.call_function('__', [rt.new_string('Custom database class.')]) }, rt.ArrayItem{ key: none, val: true }]) }, rt.ArrayItem{ key: 'db-error.php', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.call_function('__', [rt.new_string('Custom database error message.')]) }, rt.ArrayItem{ key: none, val: true }]) }, rt.ArrayItem{ key: 'install.php', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.call_function('__', [rt.new_string('Custom installation script.')]) }, rt.ArrayItem{ key: none, val: true }]) }, rt.ArrayItem{ key: 'maintenance.php', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.call_function('__', [rt.new_string('Custom maintenance message.')]) }, rt.ArrayItem{ key: none, val: true }]) }, rt.ArrayItem{ key: 'object-cache.php', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.call_function('__', [rt.new_string('External object cache.')]) }, rt.ArrayItem{ key: none, val: true }]) }, rt.ArrayItem{ key: 'php-error.php', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.call_function('__', [rt.new_string('Custom PHP error message.')]) }, rt.ArrayItem{ key: none, val: true }]) }, rt.ArrayItem{ key: 'fatal-error-handler.php', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.call_function('__', [rt.new_string('Custom PHP fatal error handler.')]) }, rt.ArrayItem{ key: none, val: true }]) }])
	if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) {
		var_dropins.array_set('sunrise.php', rt.create_array([rt.ArrayItem{ key: none, val: rt.call_function('__', [rt.new_string('Executed before Multisite is loaded.')]) }, rt.ArrayItem{ key: none, val: 'SUNRISE' }]))
		var_dropins.array_set('blog-deleted.php', rt.create_array([rt.ArrayItem{ key: none, val: rt.call_function('__', [rt.new_string('Custom site deleted message.')]) }, rt.ArrayItem{ key: none, val: true }]))
		var_dropins.array_set('blog-inactive.php', rt.create_array([rt.ArrayItem{ key: none, val: rt.call_function('__', [rt.new_string('Custom site inactive message.')]) }, rt.ArrayItem{ key: none, val: true }]))
		var_dropins.array_set('blog-suspended.php', rt.create_array([rt.ArrayItem{ key: none, val: rt.call_function('__', [rt.new_string('Custom site suspended message.')]) }, rt.ArrayItem{ key: none, val: true }]))
	}
	return var_dropins.clone()
}

fn is_plugin_active(var_plugin rt.PhpVal) bool {
	return rt.is_true(rt.call_function('in_array', [var_plugin.clone(), rt.cast_array(rt.call_function('get_option', [rt.new_string('active_plugins'), rt.new_array()])), rt.new_bool(true)])) || is_plugin_active_for_network(var_plugin.clone())
}

fn is_plugin_inactive(var_plugin rt.PhpVal) bool {
	return !(is_plugin_active(var_plugin.clone()))
}

fn is_plugin_active_for_network(var_plugin rt.PhpVal) bool {
	mut var_plugins := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{}))))) {
		return false
	}
	var_plugins = rt.call_function('get_site_option', [rt.new_string('active_sitewide_plugins')])
	if var_plugins.array_isset(var_plugin) {
		return true
	}
	return false
}

fn is_network_only_plugin(var_plugin rt.PhpVal) bool {
	mut var_plugin_data := rt.new_null()
	var_plugin_data = get_plugin_data(rt.new_string((rt.get_constant('WP_PLUGIN_DIR')).str() + '/' + (var_plugin).str()), false, false)
	if rt.is_true(var_plugin_data) {
		return (var_plugin_data.array_get(rt.new_string('Network'))).to_bool()
	}
	return false
}

fn activate_plugin(var_plugin_arg rt.PhpVal, redirect string, network_wide bool, silent bool) rt.PhpVal {
	mut var_redirect := redirect
	mut var_network_wide := network_wide
	mut var_silent := silent
	mut var_plugin := var_plugin_arg
	mut var_current := rt.new_null()
	mut var_valid := rt.new_null()
	mut var_requirements := rt.new_null()
	mut var_output := rt.new_null()
	var_plugin = rt.call_function('plugin_basename', [rt.new_string(var_plugin.clone().to_string().trim_space())])
	if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) && var_network_wide || is_network_only_plugin(var_plugin.clone()) {
		var_network_wide = true
		var_current = rt.call_function('get_site_option', [rt.new_string('active_sitewide_plugins'), rt.new_array()])
		rt.get_superglobal('_GET').array_set('networkwide', 1)
	} else {
	var_current = rt.call_function('get_option', [rt.new_string('active_plugins'), rt.new_array()])
	}
	var_valid = rt.new_int(validate_plugin(var_plugin.clone()))
	if rt.is_true(rt.call_function('is_wp_error', [var_valid.clone()])) {
		return var_valid.clone()
	}
	var_requirements = validate_plugin_requirements(var_plugin.clone())
	if rt.is_true(rt.call_function('is_wp_error', [var_requirements.clone()])) {
		return var_requirements.clone()
	}
	if (var_network_wide && !(var_current.array_isset(var_plugin))) || (!(var_network_wide) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_plugin.clone(), var_current.clone(), rt.new_bool(true)])))))) {
		if !(redirect == '') {
			rt.call_function('wp_redirect', [rt.call_function('add_query_arg', [rt.new_string('_error_nonce'), rt.call_function('wp_create_nonce', [rt.new_string('plugin-activation-error_' + (var_plugin).str())]), rt.new_string(redirect)])])
		}
		rt.call_function('ob_start', []rt.PhpVal{})
		plugin_sandbox_scrape(var_plugin.clone())
		if !(var_silent) {
			rt.call_function('do_action', [rt.new_string('activate_plugin'), var_plugin.clone(), rt.new_bool(var_network_wide)])
			rt.call_function('do_action', [rt.new_string("activate_${var_plugin.to_string()}"), rt.new_bool(var_network_wide)])
		}
		if var_network_wide {
			var_current = rt.call_function('get_site_option', [rt.new_string('active_sitewide_plugins'), rt.new_array()])
			var_current.array_set(var_plugin, rt.call_function('time', []rt.PhpVal{}))
			rt.call_function('update_site_option', [rt.new_string('active_sitewide_plugins'), var_current.clone()])
		} else {
			var_current = rt.call_function('get_option', [rt.new_string('active_plugins'), rt.new_array()])
			var_current.array_push(var_plugin.clone())
			rt.call_function('sort', [var_current.clone()])
			rt.call_function('update_option', [rt.new_string('active_plugins'), var_current.clone()])
		}
		if !(var_silent) {
			rt.call_function('do_action', [rt.new_string('activated_plugin'), var_plugin.clone(), rt.new_bool(var_network_wide)])
		}
		if rt.is_true(rt.greater(rt.call_function('ob_get_length', []rt.PhpVal{}), rt.new_int(0))) {
			var_output = rt.call_function('ob_get_clean', []rt.PhpVal{})
			return create_wp_error(rt.new_string('unexpected_output'), rt.call_function('__', [rt.new_string('The plugin generated unexpected output.')]), var_output.clone())
		}
		rt.call_function('ob_end_clean', []rt.PhpVal{})
	}
	return rt.new_null()
}

fn deactivate_plugins(var_plugins rt.PhpVal, silent bool, var_network_wide rt.PhpVal) {
	mut var_silent := silent
	mut var_extension := rt.new_null()
	mut var_network_current := rt.new_null()
	mut var_current := rt.new_null()
	mut var_do_blog := false
	mut var_do_network := false
	mut var_plugin := rt.new_null()
	mut var_network_deactivating := false
	mut var_key := rt.new_null()
	if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) {
	var_network_current = rt.call_function('get_site_option', [rt.new_string('active_sitewide_plugins'), rt.new_array()])
	}
	var_current = rt.call_function('get_option', [rt.new_string('active_plugins'), rt.new_array()])
	var_do_blog = false
	var_do_network = false
	mut iter_5 := rt.cast_array(var_plugins).iterator()
	for {
		item_5 := iter_5.next() or { break }
		mut var_plugin_shadow := item_5.val
		var_plugin_shadow = rt.call_function('plugin_basename', [rt.new_string(var_plugin_shadow.clone().to_string().trim_space())])
		if !(is_plugin_active(var_plugin_shadow.clone())) {
			continue
		}
		var_network_deactivating = rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_network_wide)))) && is_plugin_active_for_network(var_plugin_shadow.clone())
		if !(var_silent) {
			rt.call_function('do_action', [rt.new_string('deactivate_plugin'), var_plugin_shadow.clone(), rt.new_bool(var_network_deactivating).clone()])
		}
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_network_wide)))) {
			if rt.is_true(rt.new_bool(is_plugin_active_for_network(var_plugin_shadow.clone()))) {
				var_do_network = true
				var_network_current.array_unset(var_plugin_shadow)
			} else if rt.is_true(var_network_wide) {
				continue
			}
		}
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(true), var_network_wide)))) {
			var_key = rt.call_function('array_search', [var_plugin_shadow.clone(), var_current.clone(), rt.new_bool(true)])
			if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_key)))) {
				var_do_blog = true
				var_current.array_unset(var_key)
			}
		}
		if var_do_blog && rt.is_true(rt.call_function('wp_is_recovery_mode', []rt.PhpVal{})) {
			mut list_tmp_1 := rt.call_function('explode', [rt.new_string('/'), var_plugin_shadow.clone()])
			var_extension = (list_tmp_1).array_get(0)
			rt.call_method(rt.call_function('wp_paused_plugins', []rt.PhpVal{}), 'delete', [var_extension.clone()])
		}
		if !(var_silent) {
			rt.call_function('do_action', [rt.new_string("deactivate_${var_plugin.to_string()}"), rt.new_bool(var_network_deactivating).clone()])
			rt.call_function('do_action', [rt.new_string('deactivated_plugin'), var_plugin_shadow.clone(), rt.new_bool(var_network_deactivating).clone()])
		}
	}
	if var_do_blog {
		rt.call_function('update_option', [rt.new_string('active_plugins'), var_current.clone()])
	}
	if var_do_network {
		rt.call_function('update_site_option', [rt.new_string('active_sitewide_plugins'), var_network_current.clone()])
	}
}

fn activate_plugins(var_plugins_arg rt.PhpVal, redirect string, network_wide bool, silent bool) bool {
	mut var_redirect := redirect
	mut var_network_wide := network_wide
	mut var_silent := silent
	mut var_plugins := var_plugins_arg
	mut var_errors := rt.new_null()
	mut var_plugin := rt.new_null()
	mut var_result := rt.new_null()
	if !(var_plugins.clone().is_array()) {
	var_plugins = rt.create_array([rt.ArrayItem{ key: none, val: var_plugins }])
	}
	var_errors = rt.new_array()
	mut iter_6 := var_plugins.iterator()
	for {
		item_6 := iter_6.next() or { break }
		mut var_plugin_shadow := item_6.val
		if !(var_redirect == '') {
		var_redirect = (rt.call_function('add_query_arg', [rt.new_string('plugin'), var_plugin_shadow.clone(), rt.new_string((var_redirect).str())])).str()
		}
		var_result = activate_plugin(var_plugin_shadow.clone(), var_redirect, var_network_wide, silent)
		if rt.is_true(rt.call_function('is_wp_error', [var_result.clone()])) {
			var_errors.array_set(var_plugin_shadow, var_result.clone())
		}
	}
	if !(!rt.is_true(var_errors)) {
		return (create_wp_error(rt.new_string('plugins_invalid'), rt.call_function('__', [rt.new_string('One of the plugins is invalid.')]), var_errors.clone())).to_bool()
	}
	return true
}

fn delete_plugins(var_plugins rt.PhpVal, deprecated string) rt.PhpVal {
	mut var_deprecated := deprecated
	mut var_wp_filesystem := rt.new_null()
	mut var_checked := []rt.PhpVal{}
	mut var_plugin := rt.new_null()
	mut var_url := rt.new_null()
	mut var_credentials := rt.new_null()
	mut var_data := rt.new_null()
	mut var_plugins_dir := rt.new_null()
	mut var_plugin_translations := rt.new_null()
	mut var_errors := rt.new_null()
	mut var_plugin_file := rt.new_null()
	mut var_this_plugin_dir := rt.new_null()
	mut var_deleted := rt.new_null()
	mut var_plugin_slug := rt.new_null()
	mut var_translations := rt.new_null()
	mut var_translation := rt.new_null()
	mut var_json_translation_files := rt.new_null()
	mut var_current := rt.new_null()
	mut var_message := rt.new_null()
	if !rt.is_true(var_plugins) {
		return rt.new_bool(false)
	}
	var_checked = rt.new_array()
	mut iter_7 := var_plugins.iterator()
	for {
		item_7 := iter_7.next() or { break }
		mut var_plugin_shadow := item_7.val
		var_checked << 'checked[]=' + (var_plugin_shadow).str()
	}
	var_url = rt.call_function('wp_nonce_url', [rt.new_string('plugins.php?action=delete-selected&verify-delete=1&' + (rt.call_function('implode', [rt.new_string('&'), rt.create_array_from_list(var_checked)])).str()), rt.new_string('bulk-plugins')])
	rt.call_function('ob_start', []rt.PhpVal{})
	var_credentials = rt.call_function('request_filesystem_credentials', [var_url.clone()])
	var_data = rt.call_function('ob_get_clean', []rt.PhpVal{})
	if rt.is_true(rt.identical(rt.new_bool(false), var_credentials)) {
		if !(!rt.is_true(var_data)) {
			rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-header.php', '4')
			rt.echo_val(var_data)
			rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-footer.php', '4')
			exit(0)
		}
		return rt.new_null()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('WP_Filesystem', [var_credentials.clone()]))))) {
		rt.call_function('ob_start', []rt.PhpVal{})
		rt.call_function('request_filesystem_credentials', [var_url.clone(), rt.new_string(''), rt.new_bool(true)])
		var_data = rt.call_function('ob_get_clean', []rt.PhpVal{})
		if !(!rt.is_true(var_data)) {
			rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-header.php', '4')
			rt.echo_val(var_data)
			rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-footer.php', '4')
			exit(0)
		}
		return rt.new_null()
	}
	if !(var_wp_filesystem.clone().is_object()) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('fs_unavailable'), rt.call_function('__', [rt.new_string('Could not access filesystem.')])))
	}
	if rt.is_true(rt.call_function('is_wp_error', [rt.get_property(var_wp_filesystem, 'errors')])) && rt.is_true(rt.call_method(rt.get_property(var_wp_filesystem, 'errors'), 'has_errors', []rt.PhpVal{})) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('fs_error'), rt.call_function('__', [rt.new_string('Filesystem error.')]), rt.get_property(var_wp_filesystem, 'errors')))
	}
	var_plugins_dir = rt.call_method(var_wp_filesystem, 'wp_plugins_dir', []rt.PhpVal{})
	if !rt.is_true(var_plugins_dir) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('fs_no_plugins_dir'), rt.call_function('__', [rt.new_string('Unable to locate WordPress plugin directory.')])))
	}
	var_plugins_dir = rt.call_function('trailingslashit', [var_plugins_dir.clone()])
	var_plugin_translations = rt.call_function('wp_get_installed_translations', [rt.new_string('plugins')])
	var_errors = rt.new_array()
	mut iter_8 := var_plugins.iterator()
	for {
		item_8 := iter_8.next() or { break }
		mut var_plugin_file_shadow := item_8.val
		if rt.is_true(rt.new_bool(is_uninstallable_plugin(var_plugin_file_shadow.clone()))) {
			rt.new_bool(uninstall_plugin(var_plugin_file_shadow.clone()))
		}
		rt.call_function('do_action', [rt.new_string('delete_plugin'), var_plugin_file_shadow.clone()])
		var_this_plugin_dir = rt.call_function('trailingslashit', [rt.call_function('dirname', [rt.new_string((var_plugins_dir).str() + (var_plugin_file_shadow).str())])])
		if rt.is_true(rt.call_function('strpos', [var_plugin_file_shadow.clone(), rt.new_string('/')])) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_this_plugin_dir, var_plugins_dir)))) {
		var_deleted = rt.call_method(var_wp_filesystem, 'delete', [var_this_plugin_dir.clone(), rt.new_bool(true)])
		} else {
		var_deleted = rt.call_method(var_wp_filesystem, 'delete', [rt.new_string((var_plugins_dir).str() + (var_plugin_file_shadow).str())])
		}
		rt.call_function('do_action', [rt.new_string('deleted_plugin'), var_plugin_file_shadow.clone(), var_deleted.clone()])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_deleted)))) {
			var_errors.array_push(var_plugin_file_shadow.clone())
			continue
		}
		var_plugin_slug = rt.call_function('dirname', [var_plugin_file_shadow.clone()])
		if rt.is_true(rt.identical(rt.new_string('hello.php'), var_plugin_file_shadow)) {
		var_plugin_slug = rt.new_string('hello-dolly')
		}
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('.'), var_plugin_slug)))) && !(!rt.is_true(var_plugin_translations.array_get(var_plugin_slug))) {
			var_translations = var_plugin_translations.array_get(var_plugin_slug)
			mut iter_9 := var_translations.iterator()
			for {
				item_9 := iter_9.next() or { break }
				mut var_data_shadow := item_9.val
				mut var_translation_shadow := item_9.key
				rt.call_method(var_wp_filesystem, 'delete', [rt.new_string((rt.get_constant('WP_LANG_DIR')).str() + '/plugins/' + (var_plugin_slug).str() + '-' + (var_translation_shadow).str() + '.po')])
				rt.call_method(var_wp_filesystem, 'delete', [rt.new_string((rt.get_constant('WP_LANG_DIR')).str() + '/plugins/' + (var_plugin_slug).str() + '-' + (var_translation_shadow).str() + '.mo')])
				rt.call_method(var_wp_filesystem, 'delete', [rt.new_string((rt.get_constant('WP_LANG_DIR')).str() + '/plugins/' + (var_plugin_slug).str() + '-' + (var_translation_shadow).str() + '.l10n.php')])
				var_json_translation_files = rt.call_function('glob', [rt.new_string((rt.get_constant('WP_LANG_DIR')).str() + '/plugins/' + (var_plugin_slug).str() + '-' + (var_translation_shadow).str() + '-*.json')])
				if rt.is_true(var_json_translation_files) {
					rt.call_function('array_map', [rt.create_array([rt.ArrayItem{ key: none, val: var_wp_filesystem }, rt.ArrayItem{ key: none, val: 'delete' }]), var_json_translation_files.clone()])
				}
			}
		}
	}
	var_current = rt.call_function('get_site_transient', [rt.new_string('update_plugins')])
	if rt.is_true(var_current) {
		var_deleted = rt.call_function('array_diff', [var_plugins.clone(), var_errors.clone()])
		mut iter_10 := var_deleted.iterator()
		for {
			item_10 := iter_10.next() or { break }
			mut var_plugin_file_shadow := item_10.val
			rt.get_property(var_current, 'response').array_unset(var_plugin_file_shadow)
		}
		rt.call_function('set_site_transient', [rt.new_string('update_plugins'), var_current.clone()])
	}
	if !(!rt.is_true(var_errors)) {
		if 1 == var_errors.clone().array_count() {
		var_message = rt.call_function('__', [rt.new_string('Could not fully remove the plugin %s.')])
		} else {
		var_message = rt.call_function('__', [rt.new_string('Could not fully remove the plugins %s.')])
		}
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('could_not_remove_plugin'), rt.call_function('sprintf', [var_message.clone(), rt.call_function('implode', [rt.new_string(', '), var_errors.clone()])])))
	}
	return rt.new_bool(true)
}

fn validate_active_plugins() rt.PhpVal {
	mut var_plugins := rt.new_null()
	mut var_network_plugins := rt.new_null()
	mut var_invalid := rt.new_null()
	mut var_plugin := rt.new_null()
	mut var_result := rt.new_null()
	var_plugins = rt.call_function('get_option', [rt.new_string('active_plugins'), rt.new_array()])
	if !(var_plugins.clone().is_array()) {
		rt.call_function('update_option', [rt.new_string('active_plugins'), rt.new_array()])
	var_plugins = rt.new_array()
	}
	if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) && rt.is_true(rt.call_function('current_user_can', [rt.new_string('manage_network_plugins')])) {
	var_network_plugins = rt.cast_array(rt.call_function('get_site_option', [rt.new_string('active_sitewide_plugins'), rt.new_array()]))
	var_plugins = rt.call_function('array_merge', [var_plugins.clone(), rt.func_array_keys(var_network_plugins.clone())])
	}
	if !rt.is_true(var_plugins) {
		return rt.new_array()
	}
	var_invalid = rt.new_array()
	mut iter_11 := var_plugins.iterator()
	for {
		item_11 := iter_11.next() or { break }
		mut var_plugin_shadow := item_11.val
		var_result = rt.new_int(validate_plugin(var_plugin_shadow.clone()))
		if rt.is_true(rt.call_function('is_wp_error', [var_result.clone()])) {
			var_invalid.array_set(var_plugin_shadow, var_result.clone())
			deactivate_plugins(var_plugin_shadow.clone(), true, rt.new_null())
		}
	}
	return var_invalid.clone()
}

fn validate_plugin(var_plugin rt.PhpVal) i64 {
	mut var_installed_plugins := rt.new_null()
	if rt.is_true(rt.call_function('validate_file', [var_plugin.clone()])) {
		return (create_wp_error(rt.new_string('plugin_invalid'), rt.call_function('__', [rt.new_string('Invalid plugin path.')]))).to_i64()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('file_exists', [rt.new_string((rt.get_constant('WP_PLUGIN_DIR')).str() + '/' + (var_plugin).str())]))))) {
		return (create_wp_error(rt.new_string('plugin_not_found'), rt.call_function('__', [rt.new_string('Plugin file does not exist.')]))).to_i64()
	}
	var_installed_plugins = get_plugins('')
	if !(var_installed_plugins.array_isset(var_plugin)) {
		return (create_wp_error(rt.new_string('no_plugin_header'), rt.call_function('__', [rt.new_string('The plugin does not have a valid header.')]))).to_i64()
	}
	return 0
}

fn validate_plugin_requirements(var_plugin rt.PhpVal) rt.PhpVal {
	mut var_plugin_headers := rt.new_null()
	mut var_requirements := rt.new_null()
	mut var_compatible_wp := rt.new_null()
	mut var_compatible_php := rt.new_null()
	mut var_php_update_message := rt.new_null()
	mut var_annotation := rt.new_null()
	mut var_dependency_names := rt.new_null()
	mut var_unmet_dependencies := map[string]rt.PhpVal{}
	mut var_unmet_dependency_names := []rt.PhpVal{}
	mut var_dependency_name := rt.new_null()
	mut var_dependency := rt.new_null()
	mut var_dependency_file := rt.new_null()
	mut var_error_message := rt.new_null()
	var_plugin_headers = get_plugin_data(rt.new_string((rt.get_constant('WP_PLUGIN_DIR')).str() + '/' + (var_plugin).str()), false, false)
	var_requirements = rt.create_array([rt.ArrayItem{ key: 'requires', val: if !(!rt.is_true(var_plugin_headers.array_get(rt.new_string('RequiresWP')))) { var_plugin_headers.array_get(rt.new_string('RequiresWP')) } else { rt.new_string('') } }, rt.ArrayItem{ key: 'requires_php', val: if !(!rt.is_true(var_plugin_headers.array_get(rt.new_string('RequiresPHP')))) { var_plugin_headers.array_get(rt.new_string('RequiresPHP')) } else { rt.new_string('') } }, rt.ArrayItem{ key: 'requires_plugins', val: if !(!rt.is_true(var_plugin_headers.array_get(rt.new_string('RequiresPlugins')))) { var_plugin_headers.array_get(rt.new_string('RequiresPlugins')) } else { rt.new_string('') } }])
	var_compatible_wp = rt.call_function('is_wp_version_compatible', [var_requirements.array_get(rt.new_string('requires'))])
	var_compatible_php = rt.call_function('is_php_version_compatible', [var_requirements.array_get(rt.new_string('requires_php'))])
	var_php_update_message = rt.new_string('</p><p>' + (rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('<a href="%s">Learn more about updating PHP</a>.')]), rt.call_function('esc_url', [rt.call_function('wp_get_update_php_url', []rt.PhpVal{})])])).str())
	var_annotation = rt.call_function('wp_get_update_php_annotation', []rt.PhpVal{})
	if rt.is_true(var_annotation) {
		var_php_update_message = rt.concat(var_php_update_message, rt.new_string('</p><p><em>' + (var_annotation).str() + '</em>'))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_compatible_wp)))) && rt.is_true(rt.new_bool(!(rt.is_true(var_compatible_php)))) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('plugin_wp_php_incompatible'), '<p>' + (rt.call_function('sprintf', [rt.call_function('_x', [rt.new_string('<strong>Error:</strong> Current versions of WordPress (%1$s) and PHP (%2$s) do not meet minimum requirements for %3$s. The plugin requires WordPress %4$s and PHP %5$s.'), rt.new_string('plugin')]), rt.call_function('get_bloginfo', [rt.new_string('version')]), rt.get_constant('PHP_VERSION'), var_plugin_headers.array_get(rt.new_string('Name')), var_requirements.array_get(rt.new_string('requires')), var_requirements.array_get(rt.new_string('requires_php'))])).str() + (var_php_update_message).str() + '</p>'))
	} else if rt.is_true(rt.new_bool(!(rt.is_true(var_compatible_php)))) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('plugin_php_incompatible'), '<p>' + (rt.call_function('sprintf', [rt.call_function('_x', [rt.new_string('<strong>Error:</strong> Current PHP version (%1$s) does not meet minimum requirements for %2$s. The plugin requires PHP %3$s.'), rt.new_string('plugin')]), rt.get_constant('PHP_VERSION'), var_plugin_headers.array_get(rt.new_string('Name')), var_requirements.array_get(rt.new_string('requires_php'))])).str() + (var_php_update_message).str() + '</p>'))
	} else if rt.is_true(rt.new_bool(!(rt.is_true(var_compatible_wp)))) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('plugin_wp_incompatible'), '<p>' + (rt.call_function('sprintf', [rt.call_function('_x', [rt.new_string('<strong>Error:</strong> Current WordPress version (%1$s) does not meet minimum requirements for %2$s. The plugin requires WordPress %3$s.'), rt.new_string('plugin')]), rt.call_function('get_bloginfo', [rt.new_string('version')]), var_plugin_headers.array_get(rt.new_string('Name')), var_requirements.array_get(rt.new_string('requires'))])).str() + '</p>'))
	}
	mut iife_temp_0 := Class_WP_Plugin_Dependencies{}
	mut iife_result_0 := iife_temp_0.initialize()
	mut iife_temp_1 := Class_WP_Plugin_Dependencies{}
	mut iife_result_1 := iife_temp_1.has_unmet_dependencies(var_plugin.clone())
	if rt.is_true(iife_result_1) {
		mut iife_temp_2 := Class_WP_Plugin_Dependencies{}
		mut iife_result_2 := iife_temp_2.get_dependency_names(var_plugin.clone())
		var_dependency_names = iife_result_2
		var_unmet_dependencies = rt.new_array()
		var_unmet_dependency_names = rt.new_array()
		mut iter_12 := var_dependency_names.iterator()
		for {
			item_12 := iter_12.next() or { break }
			mut var_dependency_name_shadow := item_12.val
			mut var_dependency_shadow := item_12.key
			mut iife_temp_3 := Class_WP_Plugin_Dependencies{}
			mut iife_result_3 := iife_temp_3.get_dependency_filepath(var_dependency_shadow.clone())
			var_dependency_file = iife_result_3
			if rt.is_true(rt.identical(rt.new_bool(false), var_dependency_file)) {
				var_unmet_dependencies.array_get_mut('not_installed').array_set(var_dependency_shadow, var_dependency_name_shadow.clone())
				var_unmet_dependency_names << var_dependency_name_shadow.clone()
			} else if rt.is_true(rt.new_bool(is_plugin_inactive(var_dependency_file.clone()))) {
				var_unmet_dependencies.array_get_mut('inactive').array_set(var_dependency_shadow, var_dependency_name_shadow.clone())
				var_unmet_dependency_names << var_dependency_name_shadow.clone()
			}
		}
		var_error_message = rt.call_function('sprintf', [rt.call_function('_n', [rt.new_string('<strong>Error:</strong> %1$s requires %2$d plugin to be installed and activated: %3$s.'), rt.new_string('<strong>Error:</strong> %1$s requires %2$d plugins to be installed and activated: %3$s.'), rt.new_int(var_unmet_dependency_names.len)]), var_plugin_headers.array_get(rt.new_string('Name')), rt.new_int(var_unmet_dependency_names.len), rt.call_function('implode', [rt.call_function('wp_get_list_item_separator', []rt.PhpVal{}), rt.create_array_from_list(var_unmet_dependency_names)])])
		if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) {
			if rt.is_true(rt.call_function('current_user_can', [rt.new_string('manage_network_plugins')])) {
				var_error_message = rt.concat(var_error_message, rt.new_string(' ' + (rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('<a href="%s">Manage plugins</a>.')]), rt.call_function('esc_url', [rt.call_function('network_admin_url', [rt.new_string('plugins.php')])])])).str()))
			} else {
				var_error_message = rt.concat(var_error_message, rt.new_string(' ' + (rt.call_function('__', [rt.new_string('Please contact your network administrator.')])).str()))
			}
		} else {
			var_error_message = rt.concat(var_error_message, rt.new_string(' ' + (rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('<a href="%s">Manage plugins</a>.')]), rt.call_function('esc_url', [rt.call_function('admin_url', [rt.new_string('plugins.php')])])])).str()))
		}
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('plugin_missing_dependencies'), rt.new_string("<p>${var_error_message.to_string()}</p>"), var_unmet_dependencies.clone()))
	}
	return rt.call_function('apply_filters', [rt.new_string('validate_plugin_requirements'), rt.new_bool(true), var_plugin.clone()])
}

fn is_uninstallable_plugin(var_plugin rt.PhpVal) bool {
	mut var_file := rt.new_null()
	mut var_uninstallable_plugins := rt.new_null()
	var_file = rt.call_function('plugin_basename', [var_plugin.clone()])
	var_uninstallable_plugins = rt.cast_array(rt.call_function('get_option', [rt.new_string('uninstall_plugins')]))
	if var_uninstallable_plugins.array_isset(var_file) || rt.is_true(rt.call_function('file_exists', [rt.new_string((rt.get_constant('WP_PLUGIN_DIR')).str() + '/' + (rt.call_function('dirname', [var_file.clone()])).str() + '/uninstall.php')])) {
		return true
	}
	return false
}

fn uninstall_plugin(var_plugin rt.PhpVal) bool {
	mut var_file := rt.new_null()
	mut var_uninstallable_plugins := rt.new_null()
	mut var_callable := rt.new_null()
	var_file = rt.call_function('plugin_basename', [var_plugin.clone()])
	var_uninstallable_plugins = rt.cast_array(rt.call_function('get_option', [rt.new_string('uninstall_plugins')]))
	rt.call_function('do_action', [rt.new_string('pre_uninstall_plugin'), var_plugin.clone(), var_uninstallable_plugins.clone()])
	if rt.is_true(rt.call_function('file_exists', [rt.new_string((rt.get_constant('WP_PLUGIN_DIR')).str() + '/' + (rt.call_function('dirname', [var_file.clone()])).str() + '/uninstall.php')])) {
		if var_uninstallable_plugins.array_isset(var_file) {
			var_uninstallable_plugins.array_unset(var_file)
			rt.call_function('update_option', [rt.new_string('uninstall_plugins'), var_uninstallable_plugins.clone()])
		}
		var_uninstallable_plugins = rt.new_null()
		rt.call_function('define', [rt.new_string('WP_UNINSTALL_PLUGIN'), var_file.clone()])
		rt.call_function('wp_register_plugin_realpath', [rt.new_string((rt.get_constant('WP_PLUGIN_DIR')).str() + '/' + (var_file).str())])
		rt.include_file((rt.get_constant('WP_PLUGIN_DIR')).str() + '/' + (rt.call_function('dirname', [var_file.clone()])).str() + '/uninstall.php', '2')
		return true
	}
	if var_uninstallable_plugins.array_isset(var_file) {
		var_callable = var_uninstallable_plugins.array_get(var_file)
		var_uninstallable_plugins.array_unset(var_file)
		rt.call_function('update_option', [rt.new_string('uninstall_plugins'), var_uninstallable_plugins.clone()])
		var_uninstallable_plugins = rt.new_null()
		rt.call_function('wp_register_plugin_realpath', [rt.new_string((rt.get_constant('WP_PLUGIN_DIR')).str() + '/' + (var_file).str())])
		rt.include_file((rt.get_constant('WP_PLUGIN_DIR')).str() + '/' + (var_file).str(), '2')
		rt.call_function('add_action', [rt.new_string("uninstall_${var_file.to_string()}"), var_callable.clone()])
		rt.call_function('do_action', [rt.new_string("uninstall_${var_file.to_string()}")])
	}
	return false
}

fn add_menu_page(var_page_title rt.PhpVal, var_menu_title rt.PhpVal, var_capability rt.PhpVal, var_menu_slug_arg rt.PhpVal, callback string, icon_url string, var_position_arg rt.PhpVal) rt.PhpVal {
	mut var_callback := callback
	mut var_icon_url := icon_url
	mut var_menu_slug := var_menu_slug_arg
	mut var_position := var_position_arg
	mut var_menu := rt.new_null()
	mut var_admin_page_hooks := rt.new_null()
	mut var__registered_pages := rt.new_null()
	mut var__parent_pages := rt.new_null()
	mut var_hookname := rt.new_null()
	mut var_icon_class := ''
	mut var_new_menu := []rt.PhpVal{}
	mut var_collision_avoider := f64(0.0)
	var_menu_slug = rt.call_function('plugin_basename', [var_menu_slug.clone()])
	var_admin_page_hooks.array_set(var_menu_slug, rt.call_function('sanitize_title', [var_menu_title.clone()]))
	var_hookname = rt.new_string(get_plugin_page_hookname(var_menu_slug.clone(), rt.new_string('')))
	if !(callback == '') && !(!rt.is_true(var_hookname)) && rt.is_true(rt.call_function('current_user_can', [var_capability.clone()])) {
		rt.call_function('add_action', [var_hookname.clone(), rt.new_string(callback)])
	}
	if var_icon_url == '' {
	var_icon_url = 'dashicons-admin-generic'
	var_icon_class = 'menu-icon-generic '
	} else {
	var_icon_url = (rt.call_function('set_url_scheme', [rt.new_string((var_icon_url).str())])).str()
	var_icon_class = ''
	}
	var_new_menu = [var_menu_title, var_capability, var_menu_slug, var_page_title, 'menu-top ' + var_icon_class + (var_hookname).str(), var_hookname, rt.new_string((var_icon_url).str())]
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_position)))) && !(var_position.clone().is_long() || var_position.clone().is_double()) {
		rt.call_function('_doing_it_wrong', [rt.new_string(@FN), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('The seventh parameter passed to %s should be numeric representing menu position.')]), rt.new_string('<code>add_menu_page()</code>')]), rt.new_string('6.0.0')])
	var_position = rt.new_null()
	}
	if rt.is_true(rt.identical(rt.new_null(), var_position)) || !(var_position.clone().is_long() || var_position.clone().is_double()) {
		var_menu.array_push(var_new_menu.clone())
	} else if var_menu.array_isset((var_position).str()) {
		var_collision_avoider = rt.new_int((rt.call_function('base_convert', [rt.call_function('substr', [rt.new_string(md5.hexhash((var_menu_slug).str() + (var_menu_title).str())), rt.new_int(-4)]), rt.new_int(16), rt.new_int(10)])).to_i64()) * 1.0E-5
		var_position = rt.new_string((var_position + var_collision_avoider.str()).str())
		var_menu.array_set(var_position, var_new_menu.clone())
	} else {
		var_position = rt.new_string((var_position).str())
		var_menu.array_set(var_position, var_new_menu.clone())
	}
	var__registered_pages.array_set(var_hookname, true)
	var__parent_pages.array_set(var_menu_slug, false)
	return var_hookname.clone()
}

fn add_submenu_page(var_parent_slug_arg rt.PhpVal, var_page_title rt.PhpVal, var_menu_title rt.PhpVal, var_capability rt.PhpVal, var_menu_slug_arg rt.PhpVal, callback string, var_position_arg rt.PhpVal) bool {
	mut var_callback := callback
	mut var_parent_slug := var_parent_slug_arg
	mut var_menu_slug := var_menu_slug_arg
	mut var_position := var_position_arg
	mut var_submenu := rt.new_null()
	mut var_menu := rt.new_null()
	mut var__wp_real_parent_file := rt.new_null()
	mut var__wp_submenu_nopriv := rt.new_null()
	mut var__registered_pages := rt.new_null()
	mut var__parent_pages := rt.new_null()
	mut var_parent_menu := []rt.PhpVal{}
	mut var_new_sub_menu := []rt.PhpVal{}
	mut var_before_items := rt.new_null()
	mut var_after_items := rt.new_null()
	mut var_hookname := rt.new_null()
	var_menu_slug = rt.call_function('plugin_basename', [var_menu_slug.clone()])
	var_parent_slug = rt.call_function('plugin_basename', [var_parent_slug.clone()])
	if var__wp_real_parent_file.array_isset(var_parent_slug) {
	var_parent_slug = var__wp_real_parent_file.array_get(var_parent_slug)
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [var_capability.clone()]))))) {
		var__wp_submenu_nopriv.array_get_mut(var_parent_slug).array_set(var_menu_slug, true)
		return false
	}
	if !(var_submenu.array_isset(var_parent_slug)) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_menu_slug, var_parent_slug)))) {
		mut iter_13 := rt.cast_array(var_menu).iterator()
		for {
			item_13 := iter_13.next() or { break }
			mut var_parent_menu_shadow := item_13.val
			if rt.is_true(rt.identical(var_parent_menu_shadow[2], var_parent_slug)) && rt.is_true(rt.call_function('current_user_can', [var_parent_menu_shadow[1]])) {
				var_submenu.array_get_mut(var_parent_slug).array_push(rt.call_function('array_slice', [var_parent_menu_shadow.clone(), rt.new_int(0), rt.new_int(4)]))
			}
		}
	}
	var_new_sub_menu = [var_menu_title, var_capability, var_menu_slug, var_page_title]
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_position)))) && !(var_position.clone().is_long() || var_position.clone().is_double()) {
		rt.call_function('_doing_it_wrong', [rt.new_string(@FN), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('The seventh parameter passed to %s should be numeric representing menu position.')]), rt.new_string('<code>add_submenu_page()</code>')]), rt.new_string('5.3.0')])
	var_position = rt.new_null()
	}
	if rt.is_true(rt.identical(rt.new_null(), var_position)) || !(var_submenu.array_isset(var_parent_slug)) || rt.is_true(rt.greater_equal(var_position, rt.new_int(var_submenu.array_get(var_parent_slug).array_count()))) {
		var_submenu.array_get_mut(var_parent_slug).array_push(var_new_sub_menu.clone())
	} else {
		var_position = rt.call_function('max', [var_position.clone(), rt.new_int(0)])
		if rt.is_true(rt.identical(rt.new_int(0), var_position)) {
			rt.call_function('array_unshift', [var_submenu.array_get(var_parent_slug), rt.create_array_from_list(var_new_sub_menu)])
		} else {
			var_position = rt.call_function('absint', [var_position.clone()])
			var_before_items = rt.call_function('array_slice', [var_submenu.array_get(var_parent_slug), rt.new_int(0), var_position.clone(), rt.new_bool(true)])
			var_after_items = rt.call_function('array_slice', [var_submenu.array_get(var_parent_slug), var_position.clone(), rt.new_null(), rt.new_bool(true)])
			var_before_items.array_push(var_new_sub_menu.clone())
			var_submenu.array_set(var_parent_slug, rt.call_function('array_merge', [var_before_items.clone(), var_after_items.clone()]))
		}
	}
	rt.call_function('ksort', [var_submenu.array_get(var_parent_slug)])
	var_hookname = rt.new_string(get_plugin_page_hookname(var_menu_slug.clone(), var_parent_slug.clone()))
	if !(callback == '') && !(!rt.is_true(var_hookname)) {
		rt.call_function('add_action', [var_hookname.clone(), rt.new_string(callback)])
	}
	var__registered_pages.array_set(var_hookname, true)
	if rt.is_true(rt.identical(rt.new_string('tools.php'), var_parent_slug)) {
		var__registered_pages.array_set(get_plugin_page_hookname(var_menu_slug.clone(), 'edit.php'), true)
	}
	var__parent_pages.array_set(var_menu_slug, var_parent_slug.clone())
	return (var_hookname).to_bool()
}

fn add_management_page(var_page_title rt.PhpVal, var_menu_title rt.PhpVal, var_capability rt.PhpVal, var_menu_slug rt.PhpVal, callback string, var_position rt.PhpVal) bool {
	mut var_callback := callback
	return add_submenu_page('tools.php', var_page_title.clone(), var_menu_title.clone(), var_capability.clone(), var_menu_slug.clone(), callback, var_position.clone())
}

fn add_options_page(var_page_title rt.PhpVal, var_menu_title rt.PhpVal, var_capability rt.PhpVal, var_menu_slug rt.PhpVal, callback string, var_position rt.PhpVal) bool {
	mut var_callback := callback
	return add_submenu_page('options-general.php', var_page_title.clone(), var_menu_title.clone(), var_capability.clone(), var_menu_slug.clone(), callback, var_position.clone())
}

fn add_theme_page(var_page_title rt.PhpVal, var_menu_title rt.PhpVal, var_capability rt.PhpVal, var_menu_slug rt.PhpVal, callback string, var_position rt.PhpVal) bool {
	mut var_callback := callback
	return add_submenu_page('themes.php', var_page_title.clone(), var_menu_title.clone(), var_capability.clone(), var_menu_slug.clone(), callback, var_position.clone())
}

fn add_plugins_page(var_page_title rt.PhpVal, var_menu_title rt.PhpVal, var_capability rt.PhpVal, var_menu_slug rt.PhpVal, callback string, var_position rt.PhpVal) bool {
	mut var_callback := callback
	return add_submenu_page('plugins.php', var_page_title.clone(), var_menu_title.clone(), var_capability.clone(), var_menu_slug.clone(), callback, var_position.clone())
}

fn add_users_page(var_page_title rt.PhpVal, var_menu_title rt.PhpVal, var_capability rt.PhpVal, var_menu_slug rt.PhpVal, callback string, var_position rt.PhpVal) bool {
	mut var_callback := callback
	mut var_parent := ''
	if rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_users')])) {
	var_parent = 'users.php'
	} else {
	var_parent = 'profile.php'
	}
	return add_submenu_page(var_parent, var_page_title.clone(), var_menu_title.clone(), var_capability.clone(), var_menu_slug.clone(), callback, var_position.clone())
}

fn add_dashboard_page(var_page_title rt.PhpVal, var_menu_title rt.PhpVal, var_capability rt.PhpVal, var_menu_slug rt.PhpVal, callback string, var_position rt.PhpVal) bool {
	mut var_callback := callback
	return add_submenu_page('index.php', var_page_title.clone(), var_menu_title.clone(), var_capability.clone(), var_menu_slug.clone(), callback, var_position.clone())
}

fn add_posts_page(var_page_title rt.PhpVal, var_menu_title rt.PhpVal, var_capability rt.PhpVal, var_menu_slug rt.PhpVal, callback string, var_position rt.PhpVal) bool {
	mut var_callback := callback
	return add_submenu_page('edit.php', var_page_title.clone(), var_menu_title.clone(), var_capability.clone(), var_menu_slug.clone(), callback, var_position.clone())
}

fn add_media_page(var_page_title rt.PhpVal, var_menu_title rt.PhpVal, var_capability rt.PhpVal, var_menu_slug rt.PhpVal, callback string, var_position rt.PhpVal) bool {
	mut var_callback := callback
	return add_submenu_page('upload.php', var_page_title.clone(), var_menu_title.clone(), var_capability.clone(), var_menu_slug.clone(), callback, var_position.clone())
}

fn add_links_page(var_page_title rt.PhpVal, var_menu_title rt.PhpVal, var_capability rt.PhpVal, var_menu_slug rt.PhpVal, callback string, var_position rt.PhpVal) bool {
	mut var_callback := callback
	return add_submenu_page('link-manager.php', var_page_title.clone(), var_menu_title.clone(), var_capability.clone(), var_menu_slug.clone(), callback, var_position.clone())
}

fn add_pages_page(var_page_title rt.PhpVal, var_menu_title rt.PhpVal, var_capability rt.PhpVal, var_menu_slug rt.PhpVal, callback string, var_position rt.PhpVal) bool {
	mut var_callback := callback
	return add_submenu_page('edit.php?post_type=page', var_page_title.clone(), var_menu_title.clone(), var_capability.clone(), var_menu_slug.clone(), callback, var_position.clone())
}

fn add_comments_page(var_page_title rt.PhpVal, var_menu_title rt.PhpVal, var_capability rt.PhpVal, var_menu_slug rt.PhpVal, callback string, var_position rt.PhpVal) bool {
	mut var_callback := callback
	return add_submenu_page('edit-comments.php', var_page_title.clone(), var_menu_title.clone(), var_capability.clone(), var_menu_slug.clone(), callback, var_position.clone())
}

fn remove_menu_page(var_menu_slug rt.PhpVal) bool {
	mut var_menu := rt.new_null()
	mut var_item := []rt.PhpVal{}
	mut var_i := rt.new_null()
	mut iter_14 := var_menu.iterator()
	for {
		item_14 := iter_14.next() or { break }
		mut var_item_shadow := item_14.val
		mut var_i_shadow := item_14.key
		if rt.is_true(rt.identical(var_menu_slug, var_item_shadow[2])) {
			var_menu.array_unset(var_i_shadow)
			return (var_item_shadow).to_bool()
		}
	}
	return false
}

fn remove_submenu_page(var_menu_slug rt.PhpVal, var_submenu_slug rt.PhpVal) bool {
	mut var_submenu := rt.new_null()
	mut var_item := []rt.PhpVal{}
	mut var_i := rt.new_null()
	if !(var_submenu.array_isset(var_menu_slug)) {
		return false
	}
	mut iter_15 := var_submenu.array_get(var_menu_slug).iterator()
	for {
		item_15 := iter_15.next() or { break }
		mut var_item_shadow := item_15.val
		mut var_i_shadow := item_15.key
		if rt.is_true(rt.identical(var_submenu_slug, var_item_shadow[2])) {
			var_submenu.array_get(var_menu_slug).array_unset(var_i_shadow)
			return (var_item_shadow).to_bool()
		}
	}
	return false
}

fn menu_page_url(var_menu_slug rt.PhpVal, display bool) rt.PhpVal {
	mut var_display := display
	mut var__parent_pages := rt.new_null()
	mut var_parent_slug := rt.new_null()
	mut var_url := rt.new_null()
	if var__parent_pages.array_isset(var_menu_slug) {
		var_parent_slug = var__parent_pages.array_get(var_menu_slug)
		if rt.is_true(var_parent_slug) && !(var__parent_pages.array_isset(var_parent_slug)) {
		var_url = rt.call_function('admin_url', [rt.call_function('add_query_arg', [rt.new_string('page'), var_menu_slug.clone(), var_parent_slug.clone()])])
		} else {
		var_url = rt.call_function('admin_url', [rt.new_string('admin.php?page=' + (var_menu_slug).str())])
		}
	} else {
	var_url = rt.new_string('')
	}
	var_url = rt.call_function('esc_url', [var_url.clone()])
	if var_display {
		rt.echo_val(var_url)
	}
	return var_url.clone()
}

fn get_admin_page_parent(parent_page string) string {
	mut var_parent_page := parent_page
	mut var_menu := rt.new_null()
	mut var_submenu := rt.new_null()
	mut var_pagenow := rt.new_null()
	mut var_typenow := rt.new_null()
	mut var_plugin_page := rt.new_null()
	mut var__wp_real_parent_file := rt.new_null()
	mut var__wp_menu_nopriv := rt.new_null()
	mut var__wp_submenu_nopriv := rt.new_null()
	mut var_parent_menu := []rt.PhpVal{}
	mut var_parent_file := rt.new_null()
	mut var_submenu_array := []rt.PhpVal{}
	if !(var_parent_page == '') && rt.is_true(rt.new_bool('admin.php' != var_parent_page)) {
		return (if !(var__wp_real_parent_file.array_get(rt.new_string((var_parent_page).str()))).is_null() { var__wp_real_parent_file.array_get(rt.new_string((var_parent_page).str())) } else { rt.new_string((var_parent_page).str()) }).str()
	}
	if rt.is_true(rt.identical(rt.new_string('admin.php'), var_pagenow)) && !(var_plugin_page).is_null() {
		mut iter_16 := rt.cast_array(var_menu).iterator()
		for {
			item_16 := iter_16.next() or { break }
			mut var_parent_menu_shadow := item_16.val
			if rt.is_true(rt.identical(var_parent_menu_shadow[2], var_plugin_page)) {
				var_parent_file = var_plugin_page
				return (if !(var__wp_real_parent_file.array_get(var_parent_file)).is_null() { var__wp_real_parent_file.array_get(var_parent_file) } else { var_parent_file }).str()
			}
		}
		if var__wp_menu_nopriv.array_isset(var_plugin_page) {
			var_parent_file = var_plugin_page
			return (if !(var__wp_real_parent_file.array_get(var_parent_file)).is_null() { var__wp_real_parent_file.array_get(var_parent_file) } else { var_parent_file }).str()
		}
	}
	if !(var_plugin_page).is_null() && var__wp_submenu_nopriv.array_get(var_pagenow).array_isset(var_plugin_page) {
		var_parent_file = var_pagenow
		return (if !(var__wp_real_parent_file.array_get(var_parent_file)).is_null() { var__wp_real_parent_file.array_get(var_parent_file) } else { var_parent_file }).str()
	}
	mut iter_17 := rt.func_array_keys(rt.cast_array(var_submenu)).iterator()
	for {
		item_17 := iter_17.next() or { break }
		mut var_parent_page_shadow := item_17.val
		mut iter_18 := var_submenu.array_get(rt.new_string((var_parent_page_shadow).str())).iterator()
		for {
			item_18 := iter_18.next() or { break }
			mut var_submenu_array_shadow := item_18.val
			if var__wp_real_parent_file.array_isset(var_parent_page_shadow) {
			var_parent_page_shadow = var__wp_real_parent_file.array_get(rt.new_string((var_parent_page_shadow).str()))
			}
			if !(!rt.is_true(var_typenow)) && rt.is_true(rt.identical(rt.new_string("${var_pagenow.to_string()}?post_type=${var_typenow.to_string()}"), var_submenu_array_shadow[2])) {
				var_parent_file = rt.new_string((var_parent_page_shadow).str())
				return var_parent_page_shadow
			} else if !rt.is_true(var_typenow) && rt.is_true(rt.identical(var_pagenow, var_submenu_array_shadow[2])) && !rt.is_true(var_parent_file) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('str_contains', [var_parent_file.clone(), rt.new_string('?')]))))) {
				var_parent_file = rt.new_string((var_parent_page_shadow).str())
				return var_parent_page_shadow
			} else if !(var_plugin_page).is_null() && rt.is_true(rt.identical(var_plugin_page, var_submenu_array_shadow[2])) {
				var_parent_file = rt.new_string((var_parent_page_shadow).str())
				return var_parent_page_shadow
			}
		}
	}
	if !rt.is_true(var_parent_file) {
	var_parent_file = rt.new_string('')
	}
	return ''
}

fn get_admin_page_title() rt.PhpVal {
	mut var_menu := rt.new_null()
	mut var_submenu := rt.new_null()
	mut var_pagenow := rt.new_null()
	mut var_typenow := rt.new_null()
	mut var_plugin_page := rt.new_null()
	mut var_hook := rt.new_null()
	mut var_parent := ''
	mut var_parent1 := ''
	mut var_menu_array := []rt.PhpVal{}
	mut var_title := rt.new_null()
	mut var_submenu_array := []rt.PhpVal{}
	if !(!rt.is_true(var_title)) {
		return var_title.clone()
	}
	var_hook = get_plugin_page_hook(var_plugin_page.clone(), var_pagenow.clone())
	var_parent = get_admin_page_parent()
	var_parent1 = var_parent
	if var_parent == '' {
		mut iter_19 := rt.cast_array(var_menu).iterator()
		for {
			item_19 := iter_19.next() or { break }
			mut var_menu_array_shadow := item_19.val
			if var_menu_array_shadow.array_isset(rt.new_int(3)) {
				if rt.is_true(rt.identical(var_menu_array_shadow[2], var_pagenow)) {
					var_title = var_menu_array_shadow[3]
					return var_menu_array_shadow[3]
				} else if !(var_plugin_page).is_null() && rt.is_true(rt.identical(var_plugin_page, var_menu_array_shadow[2])) && rt.is_true(rt.identical(var_hook, var_menu_array_shadow[5])) {
					var_title = var_menu_array_shadow[3]
					return var_menu_array_shadow[3]
				}
			} else {
				var_title = var_menu_array_shadow[0]
				return var_title.clone()
			}
		}
	} else {
		mut iter_20 := rt.func_array_keys(var_submenu.clone()).iterator()
		for {
			item_20 := iter_20.next() or { break }
			mut var_parent_shadow := item_20.val
			mut iter_21 := var_submenu.array_get(rt.new_string((var_parent_shadow).str())).iterator()
			for {
				item_21 := iter_21.next() or { break }
				mut var_submenu_array_shadow := item_21.val
				if !(var_plugin_page).is_null() && rt.is_true(rt.identical(var_plugin_page, var_submenu_array_shadow[2])) && (rt.is_true(rt.identical(var_pagenow, var_parent_shadow)) || rt.is_true(rt.identical(var_plugin_page, var_parent_shadow)) || rt.is_true(rt.identical(var_plugin_page, var_hook)) || (rt.is_true(rt.identical(rt.new_string('admin.php'), var_pagenow)) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string((var_parent1).str()), var_submenu_array_shadow[2])))))) || (!(!rt.is_true(var_typenow)) && rt.is_true(rt.identical(rt.new_string("${var_pagenow.to_string()}?post_type=${var_typenow.to_string()}"), var_parent_shadow))) {
					var_title = var_submenu_array_shadow[3]
					return var_submenu_array_shadow[3]
				}
				if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_submenu_array_shadow[2], var_pagenow)))) || rt.get_superglobal('_GET').array_isset(rt.new_string('page')) {
					continue
				}
				if var_submenu_array_shadow.array_isset(rt.new_int(3)) {
					var_title = var_submenu_array_shadow[3]
					return var_submenu_array_shadow[3]
				} else {
					var_title = var_submenu_array_shadow[0]
					return var_title.clone()
				}
			}
		}
		if !rt.is_true(var_title) {
			mut iter_22 := var_menu.iterator()
			for {
				item_22 := iter_22.next() or { break }
				mut var_menu_array_shadow := item_22.val
				if !(var_plugin_page).is_null() && rt.is_true(rt.identical(var_plugin_page, var_menu_array_shadow[2])) && rt.is_true(rt.identical(rt.new_string('admin.php'), var_pagenow)) && rt.is_true(rt.identical(rt.new_string((var_parent1).str()), var_menu_array_shadow[2])) {
					var_title = var_menu_array_shadow[3]
					return var_menu_array_shadow[3]
				}
			}
		}
	}
	return var_title.clone()
}

fn get_plugin_page_hook(var_plugin_page rt.PhpVal, var_parent_page rt.PhpVal) rt.PhpVal {
	mut var_hook := rt.new_null()
	var_hook = rt.new_string(get_plugin_page_hookname(var_plugin_page.clone(), var_parent_page.clone()))
	if rt.is_true(rt.call_function('has_action', [var_hook.clone()])) {
		return var_hook.clone()
	} else {
		return rt.new_null()
	}
	return rt.new_null()
}

fn get_plugin_page_hookname(var_plugin_page rt.PhpVal, var_parent_page rt.PhpVal) string {
	mut var_admin_page_hooks := rt.new_null()
	mut var_parent := ''
	mut var_page_type := rt.new_null()
	mut var_plugin_name := rt.new_null()
	var_parent = get_admin_page_parent(var_parent_page.clone())
	var_page_type = rt.new_string('admin')
	if !rt.is_true(var_parent_page) || rt.is_true(rt.identical(rt.new_string('admin.php'), var_parent_page)) || var_admin_page_hooks.array_isset(var_plugin_page) {
		if var_admin_page_hooks.array_isset(var_plugin_page) {
		var_page_type = rt.new_string('toplevel')
		} else if var_admin_page_hooks.array_isset(rt.new_string((var_parent).str())) {
		var_page_type = var_admin_page_hooks.array_get(rt.new_string((var_parent).str()))
		}
	} else if var_admin_page_hooks.array_isset(rt.new_string((var_parent).str())) {
	var_page_type = var_admin_page_hooks.array_get(rt.new_string((var_parent).str()))
	}
	var_plugin_name = rt.call_function('preg_replace', [rt.new_string('!\\.php!'), rt.new_string(''), var_plugin_page.clone()])
	return (var_page_type).str() + '_page_' + (var_plugin_name).str()
}

fn user_can_access_admin_page() bool {
	mut var_pagenow := rt.new_null()
	mut var_menu := rt.new_null()
	mut var_submenu := rt.new_null()
	mut var__wp_menu_nopriv := rt.new_null()
	mut var__wp_submenu_nopriv := rt.new_null()
	mut var_plugin_page := rt.new_null()
	mut var__registered_pages := rt.new_null()
	mut var_parent := ''
	mut var_hookname := ''
	mut var_key := rt.new_null()
	mut var_submenu_array := []rt.PhpVal{}
	mut var_menu_array := []rt.PhpVal{}
	var_parent = get_admin_page_parent()
	if !(!(var_plugin_page).is_null()) && var__wp_submenu_nopriv.array_get(rt.new_string((var_parent).str())).array_isset(var_pagenow) {
		return false
	}
	if !(var_plugin_page).is_null() {
		if var__wp_submenu_nopriv.array_get(rt.new_string((var_parent).str())).array_isset(var_plugin_page) {
			return false
		}
		var_hookname = get_plugin_page_hookname(var_plugin_page.clone(), var_parent)
		if !(var__registered_pages.array_isset(rt.new_string((var_hookname).str()))) {
			return false
		}
	}
	if var_parent == '' {
		if var__wp_menu_nopriv.array_isset(var_pagenow) {
			return false
		}
		if var__wp_submenu_nopriv.array_get(var_pagenow).array_isset(var_pagenow) {
			return false
		}
		if !(var_plugin_page).is_null() && var__wp_submenu_nopriv.array_get(var_pagenow).array_isset(var_plugin_page) {
			return false
		}
		if !(var_plugin_page).is_null() && var__wp_menu_nopriv.array_isset(var_plugin_page) {
			return false
		}
		mut iter_23 := rt.func_array_keys(var__wp_submenu_nopriv.clone()).iterator()
		for {
			item_23 := iter_23.next() or { break }
			mut var_key_shadow := item_23.val
			if var__wp_submenu_nopriv.array_get(var_key_shadow).array_isset(var_pagenow) {
				return false
			}
			if !(var_plugin_page).is_null() && var__wp_submenu_nopriv.array_get(var_key_shadow).array_isset(var_plugin_page) {
				return false
			}
		}
		return true
	}
	if !(var_plugin_page).is_null() && rt.is_true(rt.identical(var_plugin_page, rt.new_string((var_parent).str()))) && var__wp_menu_nopriv.array_isset(var_plugin_page) {
		return false
	}
	if var_submenu.array_isset(rt.new_string((var_parent).str())) {
		mut iter_24 := var_submenu.array_get(rt.new_string((var_parent).str())).iterator()
		for {
			item_24 := iter_24.next() or { break }
			mut var_submenu_array_shadow := item_24.val
			if !(var_plugin_page).is_null() && rt.is_true(rt.identical(var_submenu_array_shadow[2], var_plugin_page)) {
				return (rt.call_function('current_user_can', [var_submenu_array_shadow[1]])).to_bool()
			} else if rt.is_true(rt.identical(var_submenu_array_shadow[2], var_pagenow)) {
				return (rt.call_function('current_user_can', [var_submenu_array_shadow[1]])).to_bool()
			}
		}
	}
	mut iter_25 := var_menu.iterator()
	for {
		item_25 := iter_25.next() or { break }
		mut var_menu_array_shadow := item_25.val
		if rt.is_true(rt.identical(var_menu_array_shadow[2], rt.new_string((var_parent).str()))) {
			return (rt.call_function('current_user_can', [var_menu_array_shadow[1]])).to_bool()
		}
	}
	return true
}

fn option_update_filter(var_options_arg rt.PhpVal) rt.PhpVal {
	mut var_options := var_options_arg
	mut var_new_allowed_options := rt.new_null()
	if rt.is_true(rt.new_bool(var_new_allowed_options.clone().is_array())) {
	var_options = rt.new_string(add_allowed_options(var_new_allowed_options.clone(), var_options.clone()))
	}
	return var_options.clone()
}

fn add_allowed_options(var_new_options rt.PhpVal, options string) string {
	mut var_options := options
	mut var_allowed_options := ''
	mut var_keys := rt.new_null()
	mut var_page := rt.new_null()
	mut var_key := rt.new_null()
	mut var_pos := rt.new_null()
	if rt.is_true(rt.identical(rt.new_string(''), rt.new_string(options))) {
	} else {
	var_allowed_options = options
	}
	mut iter_26 := var_new_options.iterator()
	for {
		item_26 := iter_26.next() or { break }
		mut var_keys_shadow := item_26.val
		mut var_page_shadow := item_26.key
		mut iter_27 := var_keys_shadow.iterator()
		for {
			item_27 := iter_27.next() or { break }
			mut var_key_shadow := item_27.val
			if !(rt.new_string((var_allowed_options).str()).array_isset(var_page_shadow)) || !(rt.new_string((var_allowed_options).str()).array_get(var_page_shadow).is_array()) {
				rt.new_string((var_allowed_options).str()).array_set(var_page_shadow, rt.new_array())
				rt.new_string((var_allowed_options).str()).array_get_mut(var_page_shadow).array_push(var_key_shadow.clone())
			} else {
				var_pos = rt.call_function('array_search', [var_key_shadow.clone(), rt.new_string((var_allowed_options).str()).array_get(var_page_shadow), rt.new_bool(true)])
				if rt.is_true(rt.identical(rt.new_bool(false), var_pos)) {
					rt.new_string((var_allowed_options).str()).array_get_mut(var_page_shadow).array_push(var_key_shadow.clone())
				}
			}
		}
	}
	return var_allowed_options
}

fn remove_allowed_options(var_del_options rt.PhpVal, options string) string {
	mut var_options := options
	mut var_allowed_options := ''
	mut var_keys := rt.new_null()
	mut var_page := rt.new_null()
	mut var_key := rt.new_null()
	mut var_pos := rt.new_null()
	if rt.is_true(rt.identical(rt.new_string(''), rt.new_string(options))) {
	} else {
	var_allowed_options = options
	}
	mut iter_28 := var_del_options.iterator()
	for {
		item_28 := iter_28.next() or { break }
		mut var_keys_shadow := item_28.val
		mut var_page_shadow := item_28.key
		mut iter_29 := var_keys_shadow.iterator()
		for {
			item_29 := iter_29.next() or { break }
			mut var_key_shadow := item_29.val
			if rt.new_string((var_allowed_options).str()).array_isset(var_page_shadow) && rt.new_string((var_allowed_options).str()).array_get(var_page_shadow).is_array() {
				var_pos = rt.call_function('array_search', [var_key_shadow.clone(), rt.new_string((var_allowed_options).str()).array_get(var_page_shadow), rt.new_bool(true)])
				if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_pos)))) {
					rt.new_string((var_allowed_options).str()).array_get(var_page_shadow).array_unset(var_pos)
				}
			}
		}
	}
	return var_allowed_options
}

fn settings_fields(var_option_group rt.PhpVal) {
	print('<input type=\'hidden\' name=\'option_page\' value=\'' + (rt.call_function('esc_attr', [var_option_group.clone()])).str() + '\' />')
	print('<input type="hidden" name="action" value="update" />')
	rt.call_function('wp_nonce_field', [rt.new_string("${var_option_group.to_string()}-options")])
}

fn wp_clean_plugins_cache(clear_update_cache bool) {
	mut var_clear_update_cache := clear_update_cache
	if var_clear_update_cache {
		rt.call_function('delete_site_transient', [rt.new_string('update_plugins')])
	}
	rt.call_function('wp_cache_delete', [rt.new_string('plugins'), rt.new_string('plugins')])
}

fn plugin_sandbox_scrape(var_plugin rt.PhpVal) {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('WP_SANDBOX_SCRAPING')]))))) {
		rt.call_function('define', [rt.new_string('WP_SANDBOX_SCRAPING'), rt.new_bool(true)])
	}
	rt.call_function('wp_register_plugin_realpath', [rt.new_string((rt.get_constant('WP_PLUGIN_DIR')).str() + '/' + (var_plugin).str())])
	rt.include_file((rt.get_constant('WP_PLUGIN_DIR')).str() + '/' + (var_plugin).str(), '2')
}

fn wp_add_privacy_policy_content(var_plugin_name rt.PhpVal, var_policy_text rt.PhpVal) {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_admin', []rt.PhpVal{}))))) {
		rt.call_function('_doing_it_wrong', [rt.new_string(@FN), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('The suggested privacy policy content should be added only in wp-admin by using the %s (or later) action.')]), rt.new_string('<code>admin_init</code>')]), rt.new_string('4.9.7')])
		return
	} else if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('doing_action', [rt.new_string('admin_init')]))))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('did_action', [rt.new_string('admin_init')]))))) {
		rt.call_function('_doing_it_wrong', [rt.new_string(@FN), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('The suggested privacy policy content should be added by using the %s (or later) action. Please see the inline documentation.')]), rt.new_string('<code>admin_init</code>')]), rt.new_string('4.9.7')])
		return
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [rt.new_string('WP_Privacy_Policy_Content')]))))) {
		rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/class-wp-privacy-policy-content.php', '4')
	}
mut iife_temp_4 := Class_WP_Privacy_Policy_Content{}
mut iife_result_4 := iife_temp_4.add(var_plugin_name.clone(), var_policy_text.clone())
}

fn is_plugin_paused(var_plugin rt.PhpVal) bool {
	mut var_GLOBALS := rt.new_null()
	if !(var_GLOBALS.array_isset(rt.new_string('_paused_plugins'))) {
		return false
	}
	if !(is_plugin_active(var_plugin.clone())) {
		return false
	}
	mut list_tmp_2 := rt.call_function('explode', [rt.new_string('/'), var_plugin.clone()])
	var_plugin = (list_tmp_2).array_get(0)
	return var_GLOBALS.array_get(rt.new_string('_paused_plugins')).array_isset(var_plugin.clone())
}

fn wp_get_plugin_error(var_plugin rt.PhpVal) bool {
	mut var_GLOBALS := rt.new_null()
	if !(var_GLOBALS.array_isset(rt.new_string('_paused_plugins'))) {
		return false
	}
	mut list_tmp_3 := rt.call_function('explode', [rt.new_string('/'), var_plugin.clone()])
	var_plugin = (list_tmp_3).array_get(0)
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_GLOBALS.array_get(rt.new_string('_paused_plugins')).array_isset(var_plugin.clone())))))) {
		return false
	}
	return (var_GLOBALS.array_get(rt.new_string('_paused_plugins')).array_get(var_plugin)).to_bool()
}

fn resume_plugin(var_plugin rt.PhpVal, redirect string) bool {
	mut var_redirect := redirect
	mut var_extension := rt.new_null()
	mut var_result := rt.new_null()
	if !(var_redirect == '') {
		rt.call_function('wp_redirect', [rt.call_function('add_query_arg', [rt.new_string('_error_nonce'), rt.call_function('wp_create_nonce', [rt.new_string('plugin-resume-error_' + (var_plugin).str())]), rt.new_string((var_redirect).str())])])
		rt.call_function('ob_start', []rt.PhpVal{})
		plugin_sandbox_scrape(var_plugin.clone())
		rt.call_function('ob_clean', []rt.PhpVal{})
	}
	mut list_tmp_4 := rt.call_function('explode', [rt.new_string('/'), var_plugin.clone()])
	var_extension = (list_tmp_4).array_get(0)
	var_result = rt.call_method(rt.call_function('wp_paused_plugins', []rt.PhpVal{}), 'delete', [var_extension.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_result)))) {
		return (create_wp_error(rt.new_string('could_not_resume_plugin'), rt.call_function('__', [rt.new_string('Could not resume the plugin.')]))).to_bool()
	}
	return true
}

fn paused_plugins_notice() {
	mut var_GLOBALS := rt.new_null()
	mut var_message := rt.new_null()
	if rt.is_true(rt.identical(rt.new_string('plugins.php'), var_GLOBALS.array_get(rt.new_string('pagenow')))) {
		return
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('resume_plugins')]))))) {
		return
	}
	if !(var_GLOBALS.array_isset(rt.new_string('_paused_plugins'))) || !rt.is_true(var_GLOBALS.array_get(rt.new_string('_paused_plugins'))) {
		return
	}
	var_message = rt.call_function('sprintf', [rt.new_string('<strong>%s</strong><br>%s</p><p><a href="%s">%s</a>'), rt.call_function('__', [rt.new_string('One or more plugins failed to load properly.')]), rt.call_function('__', [rt.new_string('You can find more details and make changes on the Plugins screen.')]), rt.call_function('esc_url', [rt.call_function('admin_url', [rt.new_string('plugins.php?plugin_status=paused')])]), rt.call_function('__', [rt.new_string('Go to the Plugins screen')])])
	rt.call_function('wp_admin_notice', [var_message.clone(), rt.create_array([rt.ArrayItem{ key: 'type', val: 'error' }])])
}

fn deactivated_plugins_notice() {
	mut var_GLOBALS := rt.new_null()
	mut var_blog_deactivated_plugins := rt.new_null()
	mut var_site_deactivated_plugins := rt.new_null()
	mut var_deactivated_plugins := rt.new_null()
	mut var_plugin := rt.new_null()
	mut var_explanation := rt.new_null()
	mut var_message := rt.new_null()
	if rt.is_true(rt.identical(rt.new_string('plugins.php'), var_GLOBALS.array_get(rt.new_string('pagenow')))) {
		return
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('activate_plugins')]))))) {
		return
	}
	var_blog_deactivated_plugins = rt.call_function('get_option', [rt.new_string('wp_force_deactivated_plugins')])
	var_site_deactivated_plugins = rt.new_array()
	if rt.is_true(rt.identical(rt.new_bool(false), var_blog_deactivated_plugins)) {
		rt.call_function('update_option', [rt.new_string('wp_force_deactivated_plugins'), rt.new_array(), rt.new_bool(false)])
	}
	if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) {
		var_site_deactivated_plugins = rt.call_function('get_site_option', [rt.new_string('wp_force_deactivated_plugins')])
		if rt.is_true(rt.identical(rt.new_bool(false), var_site_deactivated_plugins)) {
			rt.call_function('update_site_option', [rt.new_string('wp_force_deactivated_plugins'), rt.new_array()])
		}
	}
	if !rt.is_true(var_blog_deactivated_plugins) && !rt.is_true(var_site_deactivated_plugins) {
		return
	}
	var_deactivated_plugins = rt.call_function('array_merge', [var_blog_deactivated_plugins.clone(), var_site_deactivated_plugins.clone()])
	mut iter_30 := var_deactivated_plugins.iterator()
	for {
		item_30 := iter_30.next() or { break }
		mut var_plugin_shadow := item_30.val
		if !(!rt.is_true(var_plugin_shadow.array_get(rt.new_string('version_compatible')))) && !(!rt.is_true(var_plugin_shadow.array_get(rt.new_string('version_deactivated')))) {
		var_explanation = rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('%1$s %2$s was deactivated due to incompatibility with WordPress %3$s, please upgrade to %1$s %4$s or later.')]), var_plugin_shadow.array_get(rt.new_string('plugin_name')), var_plugin_shadow.array_get(rt.new_string('version_deactivated')), var_GLOBALS.array_get(rt.new_string('wp_version')), var_plugin_shadow.array_get(rt.new_string('version_compatible'))])
		} else {
		var_explanation = rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('%1$s %2$s was deactivated due to incompatibility with WordPress %3$s.')]), var_plugin_shadow.array_get(rt.new_string('plugin_name')), if !(!rt.is_true(var_plugin_shadow.array_get(rt.new_string('version_deactivated')))) { var_plugin_shadow.array_get(rt.new_string('version_deactivated')) } else { rt.new_string('') }, var_GLOBALS.array_get(rt.new_string('wp_version')), var_plugin_shadow.array_get(rt.new_string('version_compatible'))])
		}
		var_message = rt.call_function('sprintf', [rt.new_string('<strong>%s</strong><br>%s</p><p><a href="%s">%s</a>'), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('%s plugin deactivated during WordPress upgrade.')]), var_plugin_shadow.array_get(rt.new_string('plugin_name'))]), var_explanation.clone(), rt.call_function('esc_url', [rt.call_function('admin_url', [rt.new_string('plugins.php?plugin_status=inactive')])]), rt.call_function('__', [rt.new_string('Go to the Plugins screen')])])
		rt.call_function('wp_admin_notice', [var_message.clone(), rt.create_array([rt.ArrayItem{ key: 'type', val: 'warning' }])])
	}
	rt.call_function('update_option', [rt.new_string('wp_force_deactivated_plugins'), rt.new_array(), rt.new_bool(false)])
	if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) {
		rt.call_function('update_site_option', [rt.new_string('wp_force_deactivated_plugins'), rt.new_array()])
	}
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

struct Class_WP_Plugin_Dependencies {
	rt.PhpObjectBase
}

struct Class_WP_Privacy_Policy_Content {
	rt.PhpObjectBase
}

fn create_wp_error(_args ...rt.PhpVal) &Class_WP_Error {
	mut obj := &Class_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_plugin_dependencies(_args ...rt.PhpVal) &Class_WP_Plugin_Dependencies {
	mut obj := &Class_WP_Plugin_Dependencies{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_privacy_policy_content(_args ...rt.PhpVal) &Class_WP_Privacy_Policy_Content {
	mut obj := &Class_WP_Privacy_Policy_Content{
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


fn (mut this Class_WP_Plugin_Dependencies) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Plugin_Dependencies) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Plugin_Dependencies) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_Privacy_Policy_Content) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Privacy_Policy_Content) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Privacy_Policy_Content) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}



fn main() {
	defer {
		rt.shutdown()
	}

}
