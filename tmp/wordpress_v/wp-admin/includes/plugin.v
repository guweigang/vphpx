import rt

fn get_plugin_data(var_plugin_file rt.PhpVal, markup bool, translate bool) rt.PhpVal {
	mut var_default_headers := { 'Name': 'Plugin Name', 'PluginURI': 'Plugin URI', 'Version': 'Version', 'Description': 'Description', 'Author': 'Author', 'AuthorURI': 'Author URI', 'TextDomain': 'Text Domain', 'DomainPath': 'Domain Path', 'Network': 'Network', 'RequiresWP': 'Requires at least', 'RequiresPHP': 'Requires PHP', 'UpdateURI': 'Update URI', 'RequiresPlugins': 'Requires Plugins', '_sitewide': 'Site Wide Only' }
	mut var_plugin_data := rt.call_function('get_file_data', [var_plugin_file.dup(), var_default_headers.dup(), rt.new_string('plugin')])
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_plugin_data.array_get('Network'))))) && rt.is_true(var_plugin_data.array_get('_sitewide')))) {
		rt.call_function('_deprecated_argument', [rt.new_string(@FN), rt.new_string('3.0.0'), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('The %1$s plugin header is deprecated. Use %2$s instead.')]), rt.new_string('<code>Site Wide Only: true</code>'), rt.new_string('<code>Network: true</code>')])])
		var_plugin_data.array_set('Network', var_plugin_data.array_get('_sitewide'))
	}
	var_plugin_data.array_set('Network', rt.identical(rt.new_string('true'), rt.new_string(var_plugin_data.array_get('Network').to_string().to_lower())))
	var_plugin_data.array_unset(rt.new_string('_sitewide'))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_plugin_data.array_get('TextDomain'))))) {
		mut var_plugin_slug := rt.call_function('dirname', [rt.call_function('plugin_basename', [var_plugin_file.dup()])])
		if rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('str_contains', [var_plugin_slug.dup(), rt.new_string('/')]))))))) {
			var_plugin_data.array_set('TextDomain', var_plugin_slug.dup())
		}
	}
	if var_markup || var_translate {
		var_plugin_data = _get_plugin_data_markup_translate(var_plugin_file.dup(), var_plugin_data.dup(), markup, translate)
	} else {
		var_plugin_data.array_set('Title', var_plugin_data.array_get('Name'))
		var_plugin_data.array_set('AuthorName', var_plugin_data.array_get('Author'))
	}
	return var_plugin_data.dup()
}

fn _get_plugin_data_markup_translate(var_plugin_file rt.PhpVal, var_plugin_data rt.PhpVal, markup bool, translate bool) rt.PhpVal {
	var_plugin_file = rt.call_function('plugin_basename', [var_plugin_file.dup()])
	if var_translate {
		mut var_textdomain := var_plugin_data.array_get('TextDomain')
		if rt.is_true(var_textdomain) {
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_textdomain_loaded', [var_textdomain.dup()]))))) {
				if rt.is_true(var_plugin_data.array_get('DomainPath')) {
					rt.call_function('load_plugin_textdomain', [var_textdomain.dup(), rt.new_bool(false), rt.concat(rt.call_function('dirname', [var_plugin_file.dup()]), var_plugin_data.array_get('DomainPath'))])
				} else {
					rt.call_function('load_plugin_textdomain', [var_textdomain.dup(), rt.new_bool(false), rt.call_function('dirname', [var_plugin_file.dup()])])
				}
			}
		} else if rt.is_true(rt.identical(rt.new_string('hello.php'), rt.call_function('basename', [var_plugin_file.dup()]))) {
			var_textdomain = rt.new_string(rt.new_string('default'))
		}
		if rt.is_true(var_textdomain) {
			{
				mut iter_1 := rt.create_array([rt.ArrayItem{ key: none, val: 'Name' }, rt.ArrayItem{ key: none, val: 'PluginURI' }, rt.ArrayItem{ key: none, val: 'Description' }, rt.ArrayItem{ key: none, val: 'Author' }, rt.ArrayItem{ key: none, val: 'AuthorURI' }, rt.ArrayItem{ key: none, val: 'Version' }]).iterator()
				for {
					item_1 := iter_1.next() or { break }
					mut var_field := item_1.val
					if !(!rt.is_true(var_plugin_data.array_get(var_field))) {
						var_plugin_data.array_set(var_field, rt.call_function('translate', [var_plugin_data.array_get(var_field), var_textdomain.dup()]))
					}
				}
			}
		}
	}
	mut var_allowed_tags_in_links := { 'abbr': { 'title': rt.new_bool(true) }, 'acronym': { 'title': rt.new_bool(true) }, 'code': rt.new_bool(true), 'em': rt.new_bool(true), 'strong': rt.new_bool(true) }
	mut var_allowed_tags := var_allowed_tags_in_links.dup()
	var_allowed_tags.array_set('a', rt.create_array([rt.ArrayItem{ key: 'href', val: true }, rt.ArrayItem{ key: 'title', val: true }]))
	var_plugin_data.array_set('Name', rt.call_function('wp_kses', [var_plugin_data.array_get('Name'), var_allowed_tags_in_links.dup()]))
	var_plugin_data.array_set('Author', rt.call_function('wp_kses', [var_plugin_data.array_get('Author'), var_allowed_tags.dup()]))
	var_plugin_data.array_set('Description', rt.call_function('wp_kses', [var_plugin_data.array_get('Description'), var_allowed_tags.dup()]))
	var_plugin_data.array_set('Version', rt.call_function('wp_kses', [var_plugin_data.array_get('Version'), var_allowed_tags.dup()]))
	var_plugin_data.array_set('PluginURI', rt.call_function('esc_url', [var_plugin_data.array_get('PluginURI')]))
	var_plugin_data.array_set('AuthorURI', rt.call_function('esc_url', [var_plugin_data.array_get('AuthorURI')]))
	var_plugin_data.array_set('Title', var_plugin_data.array_get('Name'))
	var_plugin_data.array_set('AuthorName', var_plugin_data.array_get('Author'))
	if var_markup {
		if rt.is_true(rt.new_bool(rt.is_true(var_plugin_data.array_get('PluginURI')) && rt.is_true(var_plugin_data.array_get('Name')))) {
			var_plugin_data.array_set('Title', '<a href="' + (var_plugin_data.array_get('PluginURI')).str() + '">' + (var_plugin_data.array_get('Name')).str() + '</a>')
		}
		if rt.is_true(rt.new_bool(rt.is_true(var_plugin_data.array_get('AuthorURI')) && rt.is_true(var_plugin_data.array_get('Author')))) {
			var_plugin_data.array_set('Author', '<a href="' + (var_plugin_data.array_get('AuthorURI')).str() + '">' + (var_plugin_data.array_get('Author')).str() + '</a>')
		}
		var_plugin_data.array_set('Description', rt.call_function('wptexturize', [var_plugin_data.array_get('Description')]))
		if rt.is_true(var_plugin_data.array_get('Author')) {
			// unsupported expression: Expr_AssignOp_Concat
		}
	}
	return var_plugin_data.dup()
}

fn get_plugin_files(var_plugin rt.PhpVal) rt.PhpVal {
	mut var_plugin_file := rt.new_string((rt.get_constant('WP_PLUGIN_DIR')).str() + '/' + (var_plugin).str())
	mut var_dir := rt.call_function('dirname', [var_plugin_file.dup()])
	mut var_plugin_files := rt.create_array([rt.ArrayItem{ key: none, val: rt.call_function('plugin_basename', [var_plugin_file.dup()]) }])
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('is_dir', [var_dir.dup()])) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		mut var_exclusions := rt.cast_array(rt.call_function('apply_filters', [rt.new_string('plugin_files_exclusions'), rt.create_array([rt.ArrayItem{ key: none, val: 'CVS' }, rt.ArrayItem{ key: none, val: 'node_modules' }, rt.ArrayItem{ key: none, val: 'vendor' }, rt.ArrayItem{ key: none, val: 'bower_components' }])]))
		mut var_list_files := rt.call_function('list_files', [var_dir.dup(), rt.new_int(100), var_exclusions.dup()])
		var_list_files = rt.call_function('array_map', [rt.new_string('plugin_basename'), var_list_files.dup()])
		var_plugin_files = rt.call_function('array_merge', [var_plugin_files.dup(), var_list_files.dup()])
		var_plugin_files = rt.call_function('array_values', [rt.call_function('array_unique', [var_plugin_files.dup()])])
	}
	return var_plugin_files.dup()
}

fn get_plugins(plugin_folder string) rt.PhpVal {
	mut var_cache_plugins := rt.call_function('wp_cache_get', [rt.new_string('plugins'), rt.new_string('plugins')])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_cache_plugins)))) {
		var_cache_plugins = rt.new_array()
	}
	if var_cache_plugins.array_isset(rt.new_string(plugin_folder)) {
		return var_cache_plugins.array_get(plugin_folder)
	}
	mut var_wp_plugins := rt.new_array()
	mut var_plugin_root := rt.get_constant('WP_PLUGIN_DIR')
	if !(plugin_folder == '') {
		// unsupported expression: Expr_AssignOp_Concat
	}
	mut var_plugins_dir := rt.call_function('opendir', [var_plugin_root.dup()])
	mut var_plugin_files := rt.new_array()
	if rt.is_true(var_plugins_dir) {
		for rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
			if rt.is_true(rt.call_function('str_starts_with', [var_file.dup(), rt.new_string('.')])) {
				continue
			}
			if rt.is_true(rt.call_function('is_dir', [(var_plugin_root).str() + '/' + (var_file).str()])) {
				mut var_plugins_subdir := rt.call_function('opendir', [(var_plugin_root).str() + '/' + (var_file).str()])
				if rt.is_true(var_plugins_subdir) {
					for rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
						if rt.is_true(rt.call_function('str_starts_with', [var_subfile.dup(), rt.new_string('.')])) {
							continue
						}
						if rt.is_true(rt.call_function('str_ends_with', [var_subfile.dup(), rt.new_string('.php')])) {
							var_plugin_files.array_push("${var_file.to_string()}/${var_subfile.to_string()}")
						}
					}
					rt.call_function('closedir', [var_plugins_subdir.dup()])
				}
			} else if rt.is_true(rt.call_function('str_ends_with', [var_file.dup(), rt.new_string('.php')])) {
				var_plugin_files.array_push(var_file.dup())
			}
		}
		rt.call_function('closedir', [var_plugins_dir.dup()])
	}
	if !rt.is_true(var_plugin_files) {
		return var_wp_plugins.dup()
	}
	{
		mut iter_1 := var_plugin_files.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_plugin_file := item_1.val
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_readable', [rt.new_string("${var_plugin_root.to_string()}/${var_plugin_file.to_string()}")]))))) {
				continue
			}
			mut var_plugin_data := get_plugin_data(rt.new_string("${var_plugin_root.to_string()}/${var_plugin_file.to_string()}"), false, false)
			if !rt.is_true(var_plugin_data.array_get('Name')) {
				continue
			}
			var_wp_plugins.array_set(rt.call_function('plugin_basename', [var_plugin_file.dup()]), var_plugin_data.dup())
		}
	}
	rt.call_function('uasort', [var_wp_plugins.dup(), rt.new_string('_sort_uname_callback')])
	var_cache_plugins.array_set(plugin_folder, var_wp_plugins.dup())
	rt.call_function('wp_cache_set', [rt.new_string('plugins'), var_cache_plugins.dup(), rt.new_string('plugins')])
	return var_wp_plugins.dup()
}

fn get_mu_plugins() rt.PhpVal {
	mut var_wp_plugins := rt.new_array()
	mut var_plugin_files := rt.new_array()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_dir', [rt.get_constant('WPMU_PLUGIN_DIR')]))))) {
		return var_wp_plugins.dup()
	}
	mut var_plugins_dir := rt.call_function('opendir', [rt.get_constant('WPMU_PLUGIN_DIR')])
	if rt.is_true(var_plugins_dir) {
		for rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
			if rt.is_true(rt.call_function('str_ends_with', [var_file.dup(), rt.new_string('.php')])) {
				var_plugin_files.array_push(var_file.dup())
			}
		}
	} else {
		return var_wp_plugins.dup()
	}
	rt.call_function('closedir', [var_plugins_dir.dup()])
	if !rt.is_true(var_plugin_files) {
		return var_wp_plugins.dup()
	}
	{
		mut iter_1 := var_plugin_files.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_plugin_file := item_1.val
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_readable', [(rt.get_constant('WPMU_PLUGIN_DIR')).str() + "/${var_plugin_file.to_string()}"]))))) {
				continue
			}
			mut var_plugin_data := get_plugin_data((rt.get_constant('WPMU_PLUGIN_DIR')).str() + "/${var_plugin_file.to_string()}", false, false)
			if !rt.is_true(var_plugin_data.array_get('Name')) {
				var_plugin_data.array_set('Name', var_plugin_file.dup())
			}
			var_wp_plugins.array_set(var_plugin_file, var_plugin_data.dup())
		}
	}
	if rt.is_true(rt.new_bool(var_wp_plugins.array_isset(rt.new_string('index.php')) && rt.is_true(rt.less_equal(rt.call_function('filesize', [(rt.get_constant('WPMU_PLUGIN_DIR')).str() + '/index.php']), rt.new_int(30))))) {
		var_wp_plugins.array_unset(rt.new_string('index.php'))
	}
	rt.call_function('uasort', [var_wp_plugins.dup(), rt.new_string('_sort_uname_callback')])
	return var_wp_plugins.dup()
}

fn _sort_uname_callback(var_a rt.PhpVal, var_b rt.PhpVal) rt.PhpVal {
	return rt.call_function('strnatcasecmp', [var_a.array_get('Name'), var_b.array_get('Name')])
}

fn get_dropins() rt.PhpVal {
	mut var_dropins := rt.new_array()
	mut var_plugin_files := rt.new_array()
	mut var__dropins := 
	
}



pub fn init_wp_admin_includes_plugin_php() {
}
