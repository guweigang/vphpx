import rt

fn wp_get_themes(var_args_arg rt.PhpVal) rt.PhpVal {
	mut var_args := var_args_arg
	mut var_wp_theme_directories := rt.new_null()
	mut var__themes := map[string]rt.PhpVal{}
	mut var_defaults := map[string]rt.PhpVal{}
	mut var_theme_directories := rt.new_null()
	mut var_current_theme := rt.new_null()
	mut var_root_of_current_theme := rt.new_null()
	mut var_allowed := rt.new_null()
	mut var_themes := rt.new_null()
	mut var_theme_root := rt.new_null()
	mut var_theme := rt.new_null()
	mut var_wp_theme := rt.new_null()
	var_defaults = { 'errors': rt.new_bool(false), 'allowed': rt.new_null(), 'blog_id': rt.new_int(0) }
	var_args = rt.call_function('wp_parse_args', [var_args.clone(), rt.create_array_from_native_map(var_defaults)])
	var_theme_directories = rt.new_bool(search_theme_directories(false))
	if var_wp_theme_directories.clone().is_array() && var_wp_theme_directories.clone().array_count() > 1 {
		var_current_theme = get_stylesheet()
		if var_theme_directories.array_isset(var_current_theme) {
			var_root_of_current_theme = rt.new_string(get_raw_theme_root(var_current_theme.clone(), false))
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_root_of_current_theme.clone(), var_wp_theme_directories.clone(), rt.new_bool(true)]))))) {
			var_root_of_current_theme = rt.new_string((rt.get_constant('WP_CONTENT_DIR')).str() + (var_root_of_current_theme).str())
			}
			var_theme_directories.array_get_mut(var_current_theme).array_set('theme_root', var_root_of_current_theme.clone())
		}
	}
	if !rt.is_true(var_theme_directories) {
		return rt.new_array()
	}
	if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_args.array_get(rt.new_string('allowed')))))) {
		var_allowed = var_args.array_get(rt.new_string('allowed'))
		if rt.is_true(rt.identical(rt.new_string('network'), var_allowed)) {
		mut iife_temp_0 := Class_WP_Theme{}
		mut iife_result_0 := iife_temp_0.get_allowed_on_network()
		var_theme_directories = rt.call_function('array_intersect_key', [var_theme_directories.clone(), iife_result_0])
		} else if rt.is_true(rt.identical(rt.new_string('site'), var_allowed)) {
		mut iife_temp_1 := Class_WP_Theme{}
		mut iife_result_1 := iife_temp_1.get_allowed_on_site(var_args.array_get(rt.new_string('blog_id')))
		var_theme_directories = rt.call_function('array_intersect_key', [var_theme_directories.clone(), iife_result_1])
		} else if rt.is_true(var_allowed) {
		mut iife_temp_2 := Class_WP_Theme{}
		mut iife_result_2 := iife_temp_2.get_allowed(var_args.array_get(rt.new_string('blog_id')))
		var_theme_directories = rt.call_function('array_intersect_key', [var_theme_directories.clone(), iife_result_2])
		} else {
		mut iife_temp_3 := Class_WP_Theme{}
		mut iife_result_3 := iife_temp_3.get_allowed(var_args.array_get(rt.new_string('blog_id')))
		var_theme_directories = rt.call_function('array_diff_key', [var_theme_directories.clone(), iife_result_3])
		}
	}
	var_themes = rt.new_array()
	mut iter_1 := var_theme_directories.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_theme_root_shadow := item_1.val
		mut var_theme_shadow := item_1.key
		if var__themes.array_isset((var_theme_root_shadow.array_get(rt.new_string('theme_root'))).str() + '/' + (var_theme_shadow).str()) {
			var_themes.array_set(var_theme_shadow, var__themes[(var_theme_root_shadow.array_get(rt.new_string('theme_root'))).str() + '/' + (var_theme_shadow).str()])
		} else {
			var_themes.array_set(var_theme_shadow, create_wp_theme(var_theme_shadow.clone(), var_theme_root_shadow.array_get(rt.new_string('theme_root'))))
			var__themes[(var_theme_root_shadow.array_get(rt.new_string('theme_root'))).str() + '/' + (var_theme_shadow).str()] = var_themes.array_get(var_theme_shadow)
		}
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_args.array_get(rt.new_string('errors')))))) {
		mut iter_2 := var_themes.iterator()
		for {
			item_2 := iter_2.next() or { break }
			mut var_wp_theme_shadow := item_2.val
			mut var_theme_shadow := item_2.key
			if rt.is_true(rt.new_bool(!rt.is_true(rt.identical((rt.call_method(var_wp_theme_shadow, 'errors', []rt.PhpVal{})).to_bool(), var_args.array_get(rt.new_string('errors')))))) {
				var_themes.array_unset(var_theme_shadow)
			}
		}
	}
	return var_themes.clone()
}

fn wp_get_theme(stylesheet string, theme_root string) rt.PhpVal {
	mut var_stylesheet := stylesheet
	mut var_theme_root := theme_root
	mut var_wp_theme_directories := rt.new_null()
	if var_stylesheet == '' {
	var_stylesheet = (get_stylesheet()).str()
	}
	if var_theme_root == '' {
		var_theme_root = get_raw_theme_root(var_stylesheet)
		if rt.is_true(rt.identical(rt.new_bool(false), rt.new_string((var_theme_root).str()))) {
		var_theme_root = (rt.get_constant('WP_CONTENT_DIR')).str() + '/themes'
		} else if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [rt.new_string((var_theme_root).str()), rt.cast_array(var_wp_theme_directories), rt.new_bool(true)]))))) {
		var_theme_root = (rt.get_constant('WP_CONTENT_DIR')).str() + var_theme_root
		}
	}
	return rt.new_object('WP_Theme', []string{}, create_wp_theme(rt.new_string((var_stylesheet).str()), rt.new_string((var_theme_root).str())))
}

fn wp_clean_themes_cache(clear_update_cache bool) {
	mut var_clear_update_cache := clear_update_cache
	mut var_theme := rt.new_null()
	if var_clear_update_cache {
		rt.call_function('delete_site_transient', [rt.new_string('update_themes')])
	}
	rt.new_bool(search_theme_directories(true))
	mut iter_3 := wp_get_themes(rt.create_array([rt.ArrayItem{ key: 'errors', val: rt.new_null() }])).iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_theme_shadow := item_3.val
		rt.call_method(var_theme_shadow, 'cache_delete', []rt.PhpVal{})
	}
}

fn is_child_theme() bool {
	mut var_wp_stylesheet_path := rt.new_null()
	mut var_wp_template_path := rt.new_null()
	return rt.new_bool(!rt.is_true(rt.identical(var_wp_stylesheet_path, var_wp_template_path)))
}

fn get_stylesheet() rt.PhpVal {
	return rt.call_function('apply_filters', [rt.new_string('stylesheet'), rt.call_function('get_option', [rt.new_string('stylesheet')])])
}

fn get_stylesheet_directory() rt.PhpVal {
	mut var_stylesheet := rt.new_null()
	mut var_theme_root := rt.new_null()
	mut var_stylesheet_dir := ''
	var_stylesheet = get_stylesheet()
	var_theme_root = get_theme_root(var_stylesheet.clone())
	var_stylesheet_dir = "${var_theme_root.to_string()}/${var_stylesheet.to_string()}"
	return rt.call_function('apply_filters', [rt.new_string('stylesheet_directory'), rt.new_string((var_stylesheet_dir).str()).clone(), var_stylesheet.clone(), var_theme_root.clone()])
}

fn get_stylesheet_directory_uri() rt.PhpVal {
	mut var_stylesheet := rt.new_null()
	mut var_theme_root_uri := rt.new_null()
	mut var_stylesheet_dir_uri := ''
	var_stylesheet = rt.call_function('str_replace', [rt.new_string('%2F'), rt.new_string('/'), rt.call_function('rawurlencode', [get_stylesheet()])])
	var_theme_root_uri = get_theme_root_uri(var_stylesheet.clone(), '')
	var_stylesheet_dir_uri = "${var_theme_root_uri.to_string()}/${var_stylesheet.to_string()}"
	return rt.call_function('apply_filters', [rt.new_string('stylesheet_directory_uri'), rt.new_string((var_stylesheet_dir_uri).str()).clone(), var_stylesheet.clone(), var_theme_root_uri.clone()])
}

fn get_stylesheet_uri() rt.PhpVal {
	mut var_stylesheet_dir_uri := rt.new_null()
	mut var_stylesheet_uri := rt.new_null()
	var_stylesheet_dir_uri = get_stylesheet_directory_uri()
	var_stylesheet_uri = rt.new_string((var_stylesheet_dir_uri).str() + '/style.css')
	return rt.call_function('apply_filters', [rt.new_string('stylesheet_uri'), var_stylesheet_uri.clone(), var_stylesheet_dir_uri.clone()])
}

fn get_locale_stylesheet_uri() rt.PhpVal {
	mut var_wp_locale := rt.new_null()
	mut var_stylesheet_dir_uri := rt.new_null()
	mut var_dir := rt.new_null()
	mut var_locale := rt.new_null()
	mut var_stylesheet_uri := ''
	var_stylesheet_dir_uri = get_stylesheet_directory_uri()
	var_dir = get_stylesheet_directory()
	var_locale = rt.call_function('get_locale', []rt.PhpVal{})
	if rt.is_true(rt.call_function('file_exists', [rt.new_string("${var_dir.to_string()}/${var_locale.to_string()}.css")])) {
	var_stylesheet_uri = "${var_stylesheet_dir_uri.to_string()}/${var_locale.to_string()}.css"
	} else if !(!rt.is_true(rt.get_property(var_wp_locale, 'text_direction'))) && rt.is_true(rt.call_function('file_exists', [rt.concat(rt.concat(rt.concat(var_dir, rt.new_string('/')), rt.get_property(var_wp_locale, 'text_direction')), rt.new_string('.css'))])) {
	var_stylesheet_uri = rt.concat(rt.concat(rt.concat(var_stylesheet_dir_uri, rt.new_string('/')), rt.get_property(var_wp_locale, 'text_direction')), rt.new_string('.css'))
	} else {
	var_stylesheet_uri = ''
	}
	return rt.call_function('apply_filters', [rt.new_string('locale_stylesheet_uri'), rt.new_string((var_stylesheet_uri).str()).clone(), var_stylesheet_dir_uri.clone()])
}

fn get_template() rt.PhpVal {
	return rt.call_function('apply_filters', [rt.new_string('template'), rt.call_function('get_option', [rt.new_string('template')])])
}

fn get_template_directory() rt.PhpVal {
	mut var_template := rt.new_null()
	mut var_theme_root := rt.new_null()
	mut var_template_dir := ''
	var_template = get_template()
	var_theme_root = get_theme_root(var_template.clone())
	var_template_dir = "${var_theme_root.to_string()}/${var_template.to_string()}"
	return rt.call_function('apply_filters', [rt.new_string('template_directory'), rt.new_string((var_template_dir).str()).clone(), var_template.clone(), var_theme_root.clone()])
}

fn get_template_directory_uri() rt.PhpVal {
	mut var_template := rt.new_null()
	mut var_theme_root_uri := rt.new_null()
	mut var_template_dir_uri := ''
	var_template = rt.call_function('str_replace', [rt.new_string('%2F'), rt.new_string('/'), rt.call_function('rawurlencode', [get_template()])])
	var_theme_root_uri = get_theme_root_uri(var_template.clone(), '')
	var_template_dir_uri = "${var_theme_root_uri.to_string()}/${var_template.to_string()}"
	return rt.call_function('apply_filters', [rt.new_string('template_directory_uri'), rt.new_string((var_template_dir_uri).str()).clone(), var_template.clone(), var_theme_root_uri.clone()])
}

fn get_theme_roots() string {
	mut var_wp_theme_directories := rt.new_null()
	mut var_theme_roots := rt.new_null()
	if !(var_wp_theme_directories.clone().is_array()) || var_wp_theme_directories.clone().array_count() <= 1 {
		return '/themes'
	}
	var_theme_roots = rt.call_function('get_site_transient', [rt.new_string('theme_roots')])
	if rt.is_true(rt.identical(rt.new_bool(false), var_theme_roots)) {
		rt.new_bool(search_theme_directories(true))
	var_theme_roots = rt.call_function('get_site_transient', [rt.new_string('theme_roots')])
	}
	return (var_theme_roots).str()
}

fn register_theme_directory(var_directory_arg rt.PhpVal) bool {
	mut var_directory := var_directory_arg
	mut var_wp_theme_directories := rt.new_null()
	mut var_untrailed := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('file_exists', [var_directory.clone()]))))) {
		var_directory = rt.new_string((rt.get_constant('WP_CONTENT_DIR')).str() + '/' + (var_directory).str())
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('file_exists', [var_directory.clone()]))))) {
			return false
		}
	}
	if !(var_wp_theme_directories.clone().is_array()) {
	var_wp_theme_directories = rt.new_array()
	}
	var_untrailed = rt.call_function('untrailingslashit', [var_directory.clone()])
	if !(!rt.is_true(var_untrailed)) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_untrailed.clone(), var_wp_theme_directories.clone(), rt.new_bool(true)]))))) {
		var_wp_theme_directories.array_push(var_untrailed.clone())
	}
	return true
}

fn search_theme_directories(force bool) bool {
	mut var_force := force
	mut var_found_themes := rt.new_null()
	mut var_wp_theme_directories := rt.new_null()
	mut var_relative_theme_roots := rt.new_null()
	mut var_theme_root := rt.new_null()
	mut var_cache_expiration := rt.new_null()
	mut var_cached_roots := rt.new_null()
	mut var_theme_dir := rt.new_null()
	mut var_dirs := rt.new_null()
	mut var_dir := rt.new_null()
	mut var_found_theme := false
	mut var_sub_dirs := rt.new_null()
	mut var_sub_dir := rt.new_null()
	mut var_theme_roots := rt.new_null()
	mut var_theme_data := map[string]rt.PhpVal{}
	if !rt.is_true(var_wp_theme_directories) {
		return false
	}
	if !(var_force) && !(var_found_themes).is_null() {
		return (var_found_themes).to_bool()
	}
	var_found_themes = rt.new_array()
	var_wp_theme_directories = rt.cast_array(var_wp_theme_directories)
	var_relative_theme_roots = rt.new_array()
	mut iter_4 := var_wp_theme_directories.iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_theme_root_shadow := item_4.val
		if rt.is_true(rt.call_function('str_starts_with', [var_theme_root_shadow.clone(), rt.get_constant('WP_CONTENT_DIR')])) {
			var_relative_theme_roots.array_set(rt.call_function('str_replace', [rt.get_constant('WP_CONTENT_DIR'), rt.new_string(''), var_theme_root_shadow.clone()]), var_theme_root_shadow.clone())
		} else {
			var_relative_theme_roots.array_set(var_theme_root_shadow, var_theme_root_shadow.clone())
		}
	}
	var_cache_expiration = rt.call_function('apply_filters', [rt.new_string('wp_cache_themes_persistently'), rt.new_bool(false), rt.new_string('search_theme_directories')])
	if rt.is_true(var_cache_expiration) {
		var_cached_roots = rt.call_function('get_site_transient', [rt.new_string('theme_roots')])
		if rt.is_true(rt.new_bool(var_cached_roots.clone().is_array())) {
			mut iter_5 := var_cached_roots.iterator()
			for {
				item_5 := iter_5.next() or { break }
				mut var_theme_root_shadow := item_5.val
				mut var_theme_dir_shadow := item_5.key
				if !(var_relative_theme_roots.array_isset(var_theme_root_shadow)) {
					continue
				}
				var_found_themes.array_set(var_theme_dir_shadow, rt.create_array([rt.ArrayItem{ key: 'theme_file', val: (var_theme_dir_shadow).str() + '/style.css' }, rt.ArrayItem{ key: 'theme_root', val: var_relative_theme_roots.array_get(var_theme_root_shadow) }]))
			}
			return (var_found_themes).to_bool()
		}
		if !(var_cache_expiration.clone().is_long()) {
		var_cache_expiration = rt.mul(rt.new_int(30), rt.get_constant('MINUTE_IN_SECONDS'))
		}
	} else {
	var_cache_expiration = rt.mul(rt.new_int(30), rt.get_constant('MINUTE_IN_SECONDS'))
	}
	mut iter_6 := var_wp_theme_directories.iterator()
	for {
		item_6 := iter_6.next() or { break }
		mut var_theme_root_shadow := item_6.val
		var_dirs = rt.call_function('scandir', [var_theme_root_shadow.clone()])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_dirs)))) {
			rt.call_function('wp_trigger_error', [rt.new_string(@FN), rt.new_string("${var_theme_root.to_string()} is not readable")])
			continue
		}
		mut iter_7 := var_dirs.iterator()
		for {
			item_7 := iter_7.next() or { break }
			mut var_dir_shadow := item_7.val
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_dir', [rt.new_string((var_theme_root_shadow).str() + '/' + (var_dir_shadow).str())]))))) || rt.is_true(rt.identical(rt.new_string('.'), var_dir_shadow.array_get(rt.new_int(0)))) || rt.is_true(rt.identical(rt.new_string('CVS'), var_dir_shadow)) {
				continue
			}
			if rt.is_true(rt.call_function('file_exists', [rt.new_string((var_theme_root_shadow).str() + '/' + (var_dir_shadow).str() + '/style.css')])) {
				var_found_themes.array_set(var_dir_shadow, rt.create_array([rt.ArrayItem{ key: 'theme_file', val: (var_dir_shadow).str() + '/style.css' }, rt.ArrayItem{ key: 'theme_root', val: var_theme_root_shadow }]))
			} else {
				var_found_theme = false
				var_sub_dirs = rt.call_function('scandir', [rt.new_string((var_theme_root_shadow).str() + '/' + (var_dir_shadow).str())])
				if rt.is_true(rt.new_bool(!(rt.is_true(var_sub_dirs)))) {
					rt.call_function('wp_trigger_error', [rt.new_string(@FN), rt.new_string("${var_theme_root.to_string()}/${var_dir.to_string()} is not readable")])
					continue
				}
				mut iter_8 := var_sub_dirs.iterator()
				for {
					item_8 := iter_8.next() or { break }
					mut var_sub_dir_shadow := item_8.val
					if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_dir', [rt.new_string((var_theme_root_shadow).str() + '/' + (var_dir_shadow).str() + '/' + (var_sub_dir_shadow).str())]))))) || rt.is_true(rt.identical(rt.new_string('.'), var_dir_shadow.array_get(rt.new_int(0)))) || rt.is_true(rt.identical(rt.new_string('CVS'), var_dir_shadow)) {
						continue
					}
					if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('file_exists', [rt.new_string((var_theme_root_shadow).str() + '/' + (var_dir_shadow).str() + '/' + (var_sub_dir_shadow).str() + '/style.css')]))))) {
						continue
					}
					var_found_themes.array_set((var_dir_shadow).str() + '/' + (var_sub_dir_shadow).str(), rt.create_array([rt.ArrayItem{ key: 'theme_file', val: (var_dir_shadow).str() + '/' + (var_sub_dir_shadow).str() + '/style.css' }, rt.ArrayItem{ key: 'theme_root', val: var_theme_root_shadow }]))
				var_found_theme = true
				}
				if !(var_found_theme) {
					var_found_themes.array_set(var_dir_shadow, rt.create_array([rt.ArrayItem{ key: 'theme_file', val: (var_dir_shadow).str() + '/style.css' }, rt.ArrayItem{ key: 'theme_root', val: var_theme_root_shadow }]))
				}
			}
		}
	}
	rt.call_function('asort', [var_found_themes.clone()])
	var_theme_roots = rt.new_array()
	var_relative_theme_roots = rt.call_function('array_flip', [var_relative_theme_roots.clone()])
	mut iter_9 := var_found_themes.iterator()
	for {
		item_9 := iter_9.next() or { break }
		mut var_theme_data_shadow := item_9.val
		mut var_theme_dir_shadow := item_9.key
		var_theme_roots.array_set(var_theme_dir_shadow, var_relative_theme_roots.array_get(var_theme_data_shadow['theme_root']))
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('get_site_transient', [rt.new_string('theme_roots')]), var_theme_roots)))) {
		rt.call_function('set_site_transient', [rt.new_string('theme_roots'), var_theme_roots.clone(), var_cache_expiration.clone()])
	}
	return (var_found_themes).to_bool()
}

fn get_theme_root(stylesheet_or_template string) rt.PhpVal {
	mut var_stylesheet_or_template := stylesheet_or_template
	mut var_wp_theme_directories := rt.new_null()
	mut var_theme_root := rt.new_null()
	var_theme_root = rt.new_string('')
	if var_stylesheet_or_template.len > 0 && var_stylesheet_or_template != '0' {
		var_theme_root = rt.new_string(get_raw_theme_root(rt.new_string(stylesheet_or_template), false))
		if rt.is_true(var_theme_root) {
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_theme_root.clone(), rt.cast_array(var_wp_theme_directories), rt.new_bool(true)]))))) {
			var_theme_root = rt.new_string((rt.get_constant('WP_CONTENT_DIR')).str() + (var_theme_root).str())
			}
		}
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_theme_root)))) {
	var_theme_root = rt.new_string((rt.get_constant('WP_CONTENT_DIR')).str() + '/themes')
	}
	return rt.call_function('apply_filters', [rt.new_string('theme_root'), var_theme_root.clone()])
}

fn get_theme_root_uri(stylesheet_or_template string, theme_root string) rt.PhpVal {
	mut var_stylesheet_or_template := stylesheet_or_template
	mut var_theme_root := theme_root
	mut var_wp_theme_directories := rt.new_null()
	mut var_theme_root_uri := rt.new_null()
	if var_stylesheet_or_template.len > 0 && var_stylesheet_or_template != '0' && !(var_theme_root.len > 0 && var_theme_root != '0') {
	var_theme_root = get_raw_theme_root(stylesheet_or_template)
	}
	if var_stylesheet_or_template.len > 0 && var_stylesheet_or_template != '0' && var_theme_root.len > 0 && var_theme_root != '0' {
		if rt.is_true(rt.call_function('in_array', [rt.new_string((var_theme_root).str()), rt.cast_array(var_wp_theme_directories), rt.new_bool(true)])) {
			if rt.is_true(rt.call_function('str_starts_with', [rt.new_string((var_theme_root).str()), rt.get_constant('WP_CONTENT_DIR')])) {
			var_theme_root_uri = rt.call_function('content_url', [rt.call_function('str_replace', [rt.get_constant('WP_CONTENT_DIR'), rt.new_string(''), rt.new_string((var_theme_root).str())])])
			} else if rt.is_true(rt.call_function('str_starts_with', [rt.new_string((var_theme_root).str()), rt.get_constant('ABSPATH')])) {
			var_theme_root_uri = rt.call_function('site_url', [rt.call_function('str_replace', [rt.get_constant('ABSPATH'), rt.new_string(''), rt.new_string((var_theme_root).str())])])
			} else if rt.is_true(rt.call_function('str_starts_with', [rt.new_string((var_theme_root).str()), rt.get_constant('WP_PLUGIN_DIR')])) || rt.is_true(rt.call_function('str_starts_with', [rt.new_string((var_theme_root).str()), rt.get_constant('WPMU_PLUGIN_DIR')])) {
			var_theme_root_uri = rt.call_function('plugins_url', [rt.call_function('basename', [rt.new_string((var_theme_root).str())]), rt.new_string((var_theme_root).str())])
			} else {
			var_theme_root_uri = rt.new_string((var_theme_root).str())
			}
		} else {
		var_theme_root_uri = rt.call_function('content_url', [rt.new_string((var_theme_root).str())])
		}
	} else {
	var_theme_root_uri = rt.call_function('content_url', [rt.new_string('themes')])
	}
	return rt.call_function('apply_filters', [rt.new_string('theme_root_uri'), var_theme_root_uri.clone(), rt.call_function('get_option', [rt.new_string('siteurl')]), rt.new_string(stylesheet_or_template)])
}

fn get_raw_theme_root(var_stylesheet_or_template rt.PhpVal, skip_cache bool) string {
	mut var_skip_cache := skip_cache
	mut var_wp_theme_directories := rt.new_null()
	mut var_theme_root := rt.new_null()
	mut var_theme_roots := ''
	if !(var_wp_theme_directories.clone().is_array()) || var_wp_theme_directories.clone().array_count() <= 1 {
		return '/themes'
	}
	var_theme_root = rt.new_bool(false)
	if !(var_skip_cache) {
		if rt.is_true(rt.identical(rt.call_function('get_option', [rt.new_string('stylesheet')]), var_stylesheet_or_template)) {
		var_theme_root = rt.call_function('get_option', [rt.new_string('stylesheet_root')])
		} else if rt.is_true(rt.identical(rt.call_function('get_option', [rt.new_string('template')]), var_stylesheet_or_template)) {
		var_theme_root = rt.call_function('get_option', [rt.new_string('template_root')])
		}
	}
	if !rt.is_true(var_theme_root) {
		var_theme_roots = get_theme_roots()
		if !(!rt.is_true(rt.new_string((var_theme_roots).str()).array_get(var_stylesheet_or_template))) {
		var_theme_root = rt.new_string((var_theme_roots).str()).array_get(var_stylesheet_or_template)
		}
	}
	return (var_theme_root).str()
}

fn locale_stylesheet() {
	mut var_stylesheet := rt.new_null()
	var_stylesheet = get_locale_stylesheet_uri()
	if !rt.is_true(var_stylesheet) {
		return
	}
	rt.call_function('printf', [rt.new_string('<link rel="stylesheet" href="%s" media="screen" />'), var_stylesheet.clone()])
}

fn switch_theme(var_stylesheet_arg rt.PhpVal) {
	mut var_stylesheet := var_stylesheet_arg
	mut var_wp_theme_directories := rt.new_null()
	mut var_wp_customize := rt.new_null()
	mut var_sidebars_widgets := rt.new_null()
	mut var_wp_registered_sidebars := rt.new_null()
	mut var_requirements := rt.new_null()
	mut var__sidebars_widgets := rt.new_null()
	mut var_old_sidebars_widgets_data_setting := rt.new_null()
	mut var_nav_menu_locations := rt.new_null()
	mut var_old_theme := rt.new_null()
	mut var_new_theme := rt.new_null()
	mut var_template := rt.new_null()
	mut var_paused_themes := rt.new_null()
	mut var_new_name := rt.new_null()
	mut var_default_theme_mods := rt.new_null()
	mut var_theme_mods_options := rt.new_null()
	var_requirements = validate_theme_requirements(var_stylesheet.clone())
	if rt.is_true(rt.call_function('is_wp_error', [var_requirements.clone()])) {
		rt.call_function('wp_die', [var_requirements.clone()])
	}
	var__sidebars_widgets = rt.new_null()
	if rt.is_true(rt.identical(rt.new_string('wp_ajax_customize_save'), rt.call_function('current_action', []rt.PhpVal{}))) {
		var_old_sidebars_widgets_data_setting = var_wp_customize.get_setting(rt.new_string('old_sidebars_widgets_data'))
		if rt.is_true(var_old_sidebars_widgets_data_setting) {
		var__sidebars_widgets = var_wp_customize.post_value(var_old_sidebars_widgets_data_setting.clone())
		}
	} else if rt.is_true(rt.new_bool(var_sidebars_widgets.clone().is_array())) {
	var__sidebars_widgets = var_sidebars_widgets
	}
	if rt.is_true(rt.new_bool(var__sidebars_widgets.clone().is_array())) {
		set_theme_mod('sidebars_widgets', rt.create_array([rt.ArrayItem{ key: 'time', val: rt.call_function('time', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'data', val: var__sidebars_widgets }]))
	}
	var_nav_menu_locations = get_theme_mod('nav_menu_locations', false)
	rt.call_function('update_option', [rt.new_string('theme_switch_menu_locations'), var_nav_menu_locations.clone(), rt.new_bool(true)])
	if rt.is_true(rt.greater(rt.call_function('func_num_args', []rt.PhpVal{}), rt.new_int(1))) {
	var_stylesheet = rt.call_function('func_get_arg', [rt.new_int(1)])
	}
	var_old_theme = wp_get_theme('', '')
	var_new_theme = wp_get_theme(var_stylesheet.clone(), '')
	var_template = rt.call_method(var_new_theme, 'get_template', []rt.PhpVal{})
	if rt.is_true(rt.call_function('wp_is_recovery_mode', []rt.PhpVal{})) {
		var_paused_themes = rt.call_function('wp_paused_themes', []rt.PhpVal{})
		rt.call_method(var_paused_themes, 'delete', [rt.call_method(var_old_theme, 'get_stylesheet', []rt.PhpVal{})])
		rt.call_method(var_paused_themes, 'delete', [rt.call_method(var_old_theme, 'get_template', []rt.PhpVal{})])
	}
	rt.call_function('update_option', [rt.new_string('template'), var_template.clone()])
	rt.call_function('update_option', [rt.new_string('stylesheet'), var_stylesheet.clone()])
	if var_wp_theme_directories.clone().array_count() > 1 {
		rt.call_function('update_option', [rt.new_string('template_root'), rt.new_string(get_raw_theme_root(var_template.clone(), true))])
		rt.call_function('update_option', [rt.new_string('stylesheet_root'), rt.new_string(get_raw_theme_root(var_stylesheet.clone(), true))])
	} else {
		rt.call_function('delete_option', [rt.new_string('template_root')])
		rt.call_function('delete_option', [rt.new_string('stylesheet_root')])
	}
	var_new_name = rt.call_method(var_new_theme, 'get', [rt.new_string('Name')])
	rt.call_function('update_option', [rt.new_string('current_theme'), var_new_name.clone()])
	if rt.is_true(rt.call_function('is_admin', []rt.PhpVal{})) && rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('get_option', [rt.new_string('theme_mods_' + (var_stylesheet).str())]))) {
		var_default_theme_mods = rt.cast_array(rt.call_function('get_option', [rt.new_string('mods_' + (var_new_name).str())]))
		if !(!rt.is_true(var_nav_menu_locations)) && !rt.is_true(var_default_theme_mods.array_get(rt.new_string('nav_menu_locations'))) {
			var_default_theme_mods.array_set('nav_menu_locations', var_nav_menu_locations.clone())
		}
		rt.call_function('add_option', [rt.new_string("theme_mods_${var_stylesheet.to_string()}"), var_default_theme_mods.clone()])
	} else {
		if rt.is_true(rt.identical(rt.new_string('wp_ajax_customize_save'), rt.call_function('current_action', []rt.PhpVal{}))) {
			remove_theme_mod('sidebars_widgets')
		}
	}
	if rt.is_true(rt.call_method(var_new_theme, 'is_block_theme', []rt.PhpVal{})) {
		set_theme_mod('wp_classic_sidebars', var_wp_registered_sidebars.clone())
	}
	rt.call_function('update_option', [rt.new_string('theme_switched'), rt.call_method(var_old_theme, 'get_stylesheet', []rt.PhpVal{})])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{}))))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('ms_is_switched', []rt.PhpVal{}))))) {
		rt.call_function('wp_set_template_globals', []rt.PhpVal{})
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{}))))) {
		rt.call_method(var_new_theme, 'delete_pattern_cache', []rt.PhpVal{})
		rt.call_method(var_old_theme, 'delete_pattern_cache', []rt.PhpVal{})
	}
	var_theme_mods_options = rt.create_array([rt.ArrayItem{ key: 'theme_mods_' + (var_stylesheet).str(), val: 'yes' }, rt.ArrayItem{ key: 'theme_mods_' + (rt.call_method(var_old_theme, 'get_stylesheet', []rt.PhpVal{})).str(), val: 'no' }])
	rt.call_function('wp_set_option_autoload_values', [var_theme_mods_options.clone()])
	rt.call_function('do_action', [rt.new_string('switch_theme'), var_new_name.clone(), var_new_theme.clone(), var_old_theme.clone()])
}

fn validate_current_theme() bool {
	mut var_default := rt.new_null()
	if rt.is_true(rt.call_function('wp_installing', []rt.PhpVal{})) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('apply_filters', [rt.new_string('validate_current_theme'), rt.new_bool(true)]))))) {
		return true
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('file_exists', [rt.new_string((get_template_directory()).str() + '/templates/index.html')]))))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('file_exists', [rt.new_string((get_template_directory()).str() + '/block-templates/index.html')]))))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('file_exists', [rt.new_string((get_template_directory()).str() + '/index.php')]))))) {
	} else if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('file_exists', [rt.new_string((get_template_directory()).str() + '/style.css')]))))) {
	} else if is_child_theme() && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('file_exists', [rt.new_string((get_stylesheet_directory()).str() + '/style.css')]))))) {
	} else {
		return true
	}
	var_default = wp_get_theme(rt.get_constant('WP_DEFAULT_THEME'), '')
	if rt.is_true(rt.call_method(var_default, 'exists', []rt.PhpVal{})) {
		switch_theme(rt.get_constant('WP_DEFAULT_THEME'))
		return false
	}
	mut iife_temp_4 := Class_WP_Theme{}
	mut iife_result_4 := iife_temp_4.get_core_default_theme()
	var_default = iife_result_4
	if rt.is_true(rt.identical(rt.new_bool(false), var_default)) || rt.is_true(rt.identical(get_stylesheet(), rt.call_method(var_default, 'get_stylesheet', []rt.PhpVal{}))) {
		return true
	}
	switch_theme(rt.call_method(var_default, 'get_stylesheet', []rt.PhpVal{}))
	return false
}

fn validate_theme_requirements(var_stylesheet rt.PhpVal) rt.PhpVal {
	mut var_theme := rt.new_null()
	mut var_requirements := rt.new_null()
	mut var_compatible_wp := rt.new_null()
	mut var_compatible_php := rt.new_null()
	var_theme = wp_get_theme(var_stylesheet.clone(), '')
	var_requirements = rt.create_array([rt.ArrayItem{ key: 'requires', val: if !(!rt.is_true(rt.call_method(var_theme, 'get', [rt.new_string('RequiresWP')]))) { rt.call_method(var_theme, 'get', [rt.new_string('RequiresWP')]) } else { rt.new_string('') } }, rt.ArrayItem{ key: 'requires_php', val: if !(!rt.is_true(rt.call_method(var_theme, 'get', [rt.new_string('RequiresPHP')]))) { rt.call_method(var_theme, 'get', [rt.new_string('RequiresPHP')]) } else { rt.new_string('') } }])
	var_compatible_wp = rt.call_function('is_wp_version_compatible', [var_requirements.array_get(rt.new_string('requires'))])
	var_compatible_php = rt.call_function('is_php_version_compatible', [var_requirements.array_get(rt.new_string('requires_php'))])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_compatible_wp)))) && rt.is_true(rt.new_bool(!(rt.is_true(var_compatible_php)))) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('theme_wp_php_incompatible'), rt.call_function('sprintf', [rt.call_function('_x', [rt.new_string('<strong>Error:</strong> Current WordPress and PHP versions do not meet minimum requirements for %s.'), rt.new_string('theme')]), rt.call_method(var_theme, 'display', [rt.new_string('Name')])])))
	} else if rt.is_true(rt.new_bool(!(rt.is_true(var_compatible_php)))) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('theme_php_incompatible'), rt.call_function('sprintf', [rt.call_function('_x', [rt.new_string('<strong>Error:</strong> Current PHP version does not meet minimum requirements for %s.'), rt.new_string('theme')]), rt.call_method(var_theme, 'display', [rt.new_string('Name')])])))
	} else if rt.is_true(rt.new_bool(!(rt.is_true(var_compatible_wp)))) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('theme_wp_incompatible'), rt.call_function('sprintf', [rt.call_function('_x', [rt.new_string('<strong>Error:</strong> Current WordPress version does not meet minimum requirements for %s.'), rt.new_string('theme')]), rt.call_method(var_theme, 'display', [rt.new_string('Name')])])))
	}
	return rt.call_function('apply_filters', [rt.new_string('validate_theme_requirements'), rt.new_bool(true), var_stylesheet.clone()])
}

fn get_theme_mods() rt.PhpVal {
	mut var_theme_slug := rt.new_null()
	mut var_mods := rt.new_null()
	mut var_theme_name := rt.new_null()
	var_theme_slug = rt.call_function('get_option', [rt.new_string('stylesheet')])
	var_mods = rt.call_function('get_option', [rt.new_string("theme_mods_${var_theme_slug.to_string()}")])
	if rt.is_true(rt.identical(rt.new_bool(false), var_mods)) {
		var_theme_name = rt.call_function('get_option', [rt.new_string('current_theme')])
		if rt.is_true(rt.identical(rt.new_bool(false), var_theme_name)) {
		var_theme_name = rt.call_method(wp_get_theme('', ''), 'get', [rt.new_string('Name')])
		}
		var_mods = rt.call_function('get_option', [rt.new_string("mods_${var_theme_name.to_string()}")])
		if rt.is_true(rt.call_function('is_admin', []rt.PhpVal{})) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_mods)))) {
			rt.call_function('update_option', [rt.new_string("theme_mods_${var_theme_slug.to_string()}"), var_mods.clone()])
			rt.call_function('delete_option', [rt.new_string("mods_${var_theme_name.to_string()}")])
		}
	}
	if !(var_mods.clone().is_array()) {
	var_mods = rt.new_array()
	}
	return var_mods.clone()
}

fn get_theme_mod(name string, default_value bool) rt.PhpVal {
	mut var_name := name
	mut var_default_value := default_value
	mut var_mods := rt.new_null()
	var_mods = get_theme_mods()
	if var_mods.array_isset(rt.new_string(name)) {
		return rt.call_function('apply_filters', [rt.new_string("theme_mod_${var_name}"), var_mods.array_get(rt.new_string(name))])
	}
	if rt.is_true(rt.new_bool(rt.new_bool(var_default_value).is_string())) {
		if rt.is_true(rt.call_function('preg_match', [rt.new_string('#(?<!%)%(?:\\d+\\$?)?s#'), rt.new_bool(var_default_value)])) {
		var_default_value = (rt.call_function('preg_replace', [rt.new_string('#(?<!%)%$#'), rt.new_string(''), rt.new_bool(var_default_value)])).to_bool()
		var_default_value = (rt.call_function('sprintf', [rt.new_bool(var_default_value), get_template_directory_uri(), get_stylesheet_directory_uri()])).to_bool()
		}
	}
	return rt.call_function('apply_filters', [rt.new_string("theme_mod_${var_name}"), rt.new_bool(var_default_value)])
}

fn set_theme_mod(name string, var_value rt.PhpVal) rt.PhpVal {
	mut var_name := name
	mut var_mods := rt.new_null()
	mut var_old_value := rt.new_null()
	mut var_theme := rt.new_null()
	var_mods = get_theme_mods()
	var_old_value = if !(var_mods.array_get(rt.new_string(name))).is_null() { var_mods.array_get(rt.new_string(name)) } else { rt.new_bool(false) }
	var_mods.array_set(name, rt.call_function('apply_filters', [rt.new_string("pre_set_theme_mod_${var_name}"), var_value.clone(), var_old_value.clone()]))
	var_theme = rt.call_function('get_option', [rt.new_string('stylesheet')])
	return rt.call_function('update_option', [rt.new_string("theme_mods_${var_theme.to_string()}"), var_mods.clone()])
}

fn remove_theme_mod(name string) {
	mut var_name := name
	mut var_mods := rt.new_null()
	mut var_theme := rt.new_null()
	var_mods = get_theme_mods()
	if !(var_mods.array_isset(rt.new_string(name))) {
		return
	}
	var_mods.array_unset(rt.new_string(name))
	if !rt.is_true(var_mods) {
		remove_theme_mods()
		return
	}
	var_theme = rt.call_function('get_option', [rt.new_string('stylesheet')])
	rt.call_function('update_option', [rt.new_string("theme_mods_${var_theme.to_string()}"), var_mods.clone()])
}

fn remove_theme_mods() {
	mut var_theme_name := rt.new_null()
	rt.call_function('delete_option', [rt.new_string('theme_mods_' + (rt.call_function('get_option', [rt.new_string('stylesheet')])).str())])
	var_theme_name = rt.call_function('get_option', [rt.new_string('current_theme')])
	if rt.is_true(rt.identical(rt.new_bool(false), var_theme_name)) {
	var_theme_name = rt.call_method(wp_get_theme('', ''), 'get', [rt.new_string('Name')])
	}
	rt.call_function('delete_option', [rt.new_string('mods_' + (var_theme_name).str())])
}

fn get_header_textcolor() rt.PhpVal {
	return get_theme_mod('header_textcolor', get_theme_support('custom-header', 'default-text-color'))
}

fn header_textcolor() {
	rt.echo_val(get_header_textcolor())
}

fn display_header_text() bool {
	mut var_text_color := rt.new_null()
	if !(current_theme_supports('custom-header', 'header-text')) {
		return false
	}
	var_text_color = get_theme_mod('header_textcolor', get_theme_support('custom-header', 'default-text-color'))
	return rt.new_bool(!rt.is_true(rt.identical(rt.new_string('blank'), var_text_color)))
}

fn has_header_image() bool {
	return get_header_image()
}

fn get_header_image() bool {
	mut var_url := rt.new_null()
	var_url = get_theme_mod('header_image', get_theme_support('custom-header', 'default-image'))
	if rt.is_true(rt.identical(rt.new_string('remove-header'), var_url)) {
		return false
	}
	if rt.is_true(rt.new_bool(is_random_header_image(''))) {
	var_url = rt.new_string(get_random_header_image())
	}
	var_url = rt.call_function('apply_filters', [rt.new_string('get_header_image'), var_url.clone()])
	if !(var_url.clone().is_string()) {
		return false
	}
	var_url = rt.new_string(var_url.clone().to_string().trim_space())
	return (rt.call_function('sanitize_url', [rt.call_function('set_url_scheme', [var_url.clone()])])).to_bool()
}

fn get_header_image_tag(var_attr_arg rt.PhpVal) string {
	mut var_attr := var_attr_arg
	mut var_header := rt.new_null()
	mut var_width := rt.new_null()
	mut var_height := rt.new_null()
	mut var_alt := rt.new_null()
	mut var_image_alt := rt.new_null()
	mut var_image_meta := rt.new_null()
	mut var_size_array := []rt.PhpVal{}
	mut var_srcset := rt.new_null()
	mut var_sizes := rt.new_null()
	mut var_html := ''
	mut var_value := rt.new_null()
	mut var_name := rt.new_null()
	var_header = get_custom_header()
	rt.set_property(var_header, 'url', rt.new_bool(get_header_image()))
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.get_property(var_header, 'url'))))) {
		return ''
	}
	var_width = rt.call_function('absint', [rt.get_property(var_header, 'width')])
	var_height = rt.call_function('absint', [rt.get_property(var_header, 'height')])
	var_alt = rt.new_string('')
	if !(!rt.is_true(rt.get_property(var_header, 'attachment_id'))) {
		var_image_alt = rt.call_function('get_post_meta', [rt.get_property(var_header, 'attachment_id'), rt.new_string('_wp_attachment_image_alt'), rt.new_bool(true)])
		if rt.is_true(rt.new_bool(var_image_alt.clone().is_string())) {
		var_alt = var_image_alt.clone()
		}
	}
	var_attr = rt.call_function('wp_parse_args', [var_attr.clone(), rt.create_array([rt.ArrayItem{ key: 'src', val: rt.get_property(var_header, 'url') }, rt.ArrayItem{ key: 'width', val: var_width }, rt.ArrayItem{ key: 'height', val: var_height }, rt.ArrayItem{ key: 'alt', val: var_alt }])])
	if !rt.is_true(var_attr.array_get(rt.new_string('srcset'))) && !(!rt.is_true(rt.get_property(var_header, 'attachment_id'))) {
		var_image_meta = rt.call_function('get_post_meta', [rt.get_property(var_header, 'attachment_id'), rt.new_string('_wp_attachment_metadata'), rt.new_bool(true)])
		var_size_array = [var_width, var_height]
		if rt.is_true(rt.new_bool(var_image_meta.clone().is_array())) {
			var_srcset = rt.call_function('wp_calculate_image_srcset', [rt.create_array_from_list(var_size_array), rt.get_property(var_header, 'url'), var_image_meta.clone(), rt.get_property(var_header, 'attachment_id')])
			if !(!rt.is_true(var_attr.array_get(rt.new_string('sizes')))) {
			var_sizes = var_attr.array_get(rt.new_string('sizes'))
			} else {
			var_sizes = rt.call_function('wp_calculate_image_sizes', [rt.create_array_from_list(var_size_array), rt.get_property(var_header, 'url'), var_image_meta.clone(), rt.get_property(var_header, 'attachment_id')])
			}
			if rt.is_true(var_srcset) && rt.is_true(var_sizes) {
				var_attr.array_set('srcset', var_srcset.clone())
				var_attr.array_set('sizes', var_sizes.clone())
			}
		}
	}
	var_attr = rt.call_function('array_merge', [var_attr.clone(), rt.call_function('wp_get_loading_optimization_attributes', [rt.new_string('img'), var_attr.clone(), rt.new_string('get_header_image_tag')])])
	if var_attr.array_isset(rt.new_string('loading')) && rt.is_true(rt.new_bool(!(rt.is_true(var_attr.array_get(rt.new_string('loading')))))) {
		var_attr.array_unset(rt.new_string('loading'))
	}
	if var_attr.array_isset(rt.new_string('fetchpriority')) && rt.is_true(rt.new_bool(!(rt.is_true(var_attr.array_get(rt.new_string('fetchpriority')))))) {
		var_attr.array_unset(rt.new_string('fetchpriority'))
	}
	if var_attr.array_isset(rt.new_string('decoding')) && rt.is_true(rt.new_bool(!(rt.is_true(var_attr.array_get(rt.new_string('decoding')))))) {
		var_attr.array_unset(rt.new_string('decoding'))
	}
	var_attr = rt.call_function('apply_filters', [rt.new_string('get_header_image_tag_attributes'), var_attr.clone(), var_header.clone()])
	var_attr = rt.call_function('array_map', [rt.new_string('esc_attr'), var_attr.clone()])
	var_html = '<img'
	mut iter_10 := var_attr.iterator()
	for {
		item_10 := iter_10.next() or { break }
		mut var_value_shadow := item_10.val
		mut var_name_shadow := item_10.key
		var_html = var_html + ' ' + (var_name_shadow).str() + '="' + (var_value_shadow).str() + '"'
	}
	var_html = var_html + ' />'
	return (rt.call_function('apply_filters', [rt.new_string('get_header_image_tag'), rt.new_string((var_html).str()).clone(), var_header.clone(), var_attr.clone()])).str()
}

fn the_header_image_tag(var_attr rt.PhpVal) {
	print(get_header_image_tag(var_attr.clone()))
}

fn _get_random_header_data() rt.PhpVal {
	mut var__wp_default_headers := rt.new_null()
	mut var_header_image_mod := rt.new_null()
	mut var_headers := rt.new_null()
	mut var__wp_random_header := rt.new_null()
	if !rt.is_true(var__wp_random_header) {
		var_header_image_mod = get_theme_mod('header_image', '')
		var_headers = rt.new_array()
		if rt.is_true(rt.identical(rt.new_string('random-uploaded-image'), var_header_image_mod)) {
		var_headers = get_uploaded_header_images()
		} else if !(!rt.is_true(var__wp_default_headers)) {
			if rt.is_true(rt.identical(rt.new_string('random-default-image'), var_header_image_mod)) {
			var_headers = var__wp_default_headers.clone()
			} else {
				if rt.is_true(rt.new_bool(current_theme_supports('custom-header', rt.new_string('random-default')))) {
				var_headers = var__wp_default_headers.clone()
				}
			}
		}
		if !rt.is_true(var_headers) {
			return rt.new_object('stdClass', []string{}, create_stdclass())
		}
		var__wp_random_header = rt.array_to_object(var_headers.array_get(rt.call_function('array_rand', [var_headers.clone()])))
		rt.set_property(var__wp_random_header, 'url', rt.call_function('sprintf', [rt.get_property(var__wp_random_header, 'url'), get_template_directory_uri(), get_stylesheet_directory_uri()]))
		rt.set_property(var__wp_random_header, 'thumbnail_url', rt.call_function('sprintf', [rt.get_property(var__wp_random_header, 'thumbnail_url'), get_template_directory_uri(), get_stylesheet_directory_uri()]))
	}
	return var__wp_random_header.clone()
}

fn get_random_header_image() string {
	mut var_random_image := rt.new_null()
	var_random_image = _get_random_header_data()
	if !rt.is_true(rt.get_property(var_random_image, 'url')) {
		return ''
	}
	return (rt.get_property(var_random_image, 'url')).str()
}

fn is_random_header_image(type string) bool {
	mut var_type := type
	mut var_header_image_mod := rt.new_null()
	var_header_image_mod = get_theme_mod('header_image', get_theme_support('custom-header', 'default-image'))
	if rt.is_true(rt.identical(rt.new_string('any'), rt.new_string(type))) {
		if rt.is_true(rt.identical(rt.new_string('random-default-image'), var_header_image_mod)) || rt.is_true(rt.identical(rt.new_string('random-uploaded-image'), var_header_image_mod)) || (!rt.is_true(var_header_image_mod) && rt.is_true(rt.new_bool('' != get_random_header_image()))) {
			return true
		}
	} else {
		if rt.is_true(rt.identical(rt.new_string("random-${var_type}-image"), var_header_image_mod)) {
			return true
		} else if rt.is_true(rt.identical(rt.new_string('default'), rt.new_string(type))) && !rt.is_true(var_header_image_mod) && rt.is_true(rt.new_bool('' != get_random_header_image())) {
			return true
		}
	}
	return false
}

fn header_image() {
	mut var_image := false
	var_image = get_header_image()
	if var_image {
		rt.echo_val(rt.call_function('esc_url', [rt.new_bool(var_image).clone()]))
	}
}

fn get_uploaded_header_images() rt.PhpVal {
	mut var_header_images := rt.new_null()
	mut var_headers := rt.new_null()
	mut var_header := rt.new_null()
	mut var_url := rt.new_null()
	mut var_header_data := rt.new_null()
	mut var_header_index := rt.new_null()
	var_header_images = rt.new_array()
	var_headers = rt.call_function('get_posts', [rt.create_array([rt.ArrayItem{ key: 'post_type', val: 'attachment' }, rt.ArrayItem{ key: 'meta_key', val: '_wp_attachment_is_custom_header' }, rt.ArrayItem{ key: 'meta_value', val: rt.call_function('get_option', [rt.new_string('stylesheet')]) }, rt.ArrayItem{ key: 'orderby', val: 'none' }, rt.ArrayItem{ key: 'nopaging', val: true }])])
	if !rt.is_true(var_headers) {
		return rt.new_array()
	}
	mut iter_11 := rt.cast_array(var_headers).iterator()
	for {
		item_11 := iter_11.next() or { break }
		mut var_header_shadow := item_11.val
		var_url = rt.call_function('sanitize_url', [rt.call_function('wp_get_attachment_url', [rt.get_property(var_header_shadow, 'ID')])])
		var_header_data = rt.call_function('wp_get_attachment_metadata', [rt.get_property(var_header_shadow, 'ID')])
		var_header_index = rt.get_property(var_header_shadow, 'ID')
		var_header_images.array_set(var_header_index, rt.new_array())
		var_header_images.array_get_mut(var_header_index).array_set('attachment_id', rt.get_property(var_header_shadow, 'ID'))
		var_header_images.array_get_mut(var_header_index).array_set('url', var_url.clone())
		var_header_images.array_get_mut(var_header_index).array_set('thumbnail_url', var_url.clone())
		var_header_images.array_get_mut(var_header_index).array_set('alt_text', rt.call_function('get_post_meta', [rt.get_property(var_header_shadow, 'ID'), rt.new_string('_wp_attachment_image_alt'), rt.new_bool(true)]))
		var_header_images.array_get_mut(var_header_index).array_set('attachment_parent', if !(var_header_data.array_get(rt.new_string('attachment_parent'))).is_null() { var_header_data.array_get(rt.new_string('attachment_parent')) } else { rt.new_string('') })
		if var_header_data.array_isset(rt.new_string('width')) {
			var_header_images.array_get_mut(var_header_index).array_set('width', var_header_data.array_get(rt.new_string('width')))
		}
		if var_header_data.array_isset(rt.new_string('height')) {
			var_header_images.array_get_mut(var_header_index).array_set('height', var_header_data.array_get(rt.new_string('height')))
		}
	}
	return var_header_images.clone()
}

fn get_custom_header() rt.PhpVal {
	mut var__wp_default_headers := rt.new_null()
	mut var_data := rt.new_null()
	mut var_directory_args := []rt.PhpVal{}
	mut var_default_header := map[string]rt.PhpVal{}
	mut var_url := rt.new_null()
	mut var_default := rt.new_null()
	if rt.is_true(rt.new_bool(is_random_header_image(''))) {
	var_data = _get_random_header_data()
	} else {
		var_data = get_theme_mod('header_image_data', false)
		if rt.is_true(rt.new_bool(!(rt.is_true(var_data)))) && current_theme_supports('custom-header', 'default-image') {
			var_directory_args = [get_template_directory_uri(), get_stylesheet_directory_uri()]
			var_data = rt.new_array()
			var_data.array_set('url', rt.call_function('vsprintf', [rt.new_bool(get_theme_support('custom-header', rt.new_string('default-image'))), rt.create_array_from_list(var_directory_args)]))
			var_data.array_set('thumbnail_url', var_data.array_get(rt.new_string('url')))
			if !(!rt.is_true(var__wp_default_headers)) {
				mut iter_12 := rt.cast_array(var__wp_default_headers).iterator()
				for {
					item_12 := iter_12.next() or { break }
					mut var_default_header_shadow := item_12.val
					var_url = rt.call_function('vsprintf', [var_default_header_shadow['url'], rt.create_array_from_list(var_directory_args)])
					if rt.is_true(rt.identical(var_data.array_get(rt.new_string('url')), var_url)) {
						var_data = var_default_header_shadow
						var_data.array_set('url', var_url.clone())
						var_data.array_set('thumbnail_url', rt.call_function('vsprintf', [var_data.array_get(rt.new_string('thumbnail_url')), rt.create_array_from_list(var_directory_args)]))
						break
					}
				}
			}
		}
	}
	var_default = rt.create_array([rt.ArrayItem{ key: 'url', val: '' }, rt.ArrayItem{ key: 'thumbnail_url', val: '' }, rt.ArrayItem{ key: 'width', val: get_theme_support('custom-header', 'width') }, rt.ArrayItem{ key: 'height', val: get_theme_support('custom-header', 'height') }, rt.ArrayItem{ key: 'video', val: get_theme_support('custom-header', 'video') }])
	return mut rt.array_to_object(rt.call_function('wp_parse_args', [var_data.clone(), var_default.clone()]))
}

fn register_default_headers(var_headers rt.PhpVal) {
	mut var__wp_default_headers := rt.new_null()
var__wp_default_headers = rt.call_function('array_merge', [rt.cast_array(var__wp_default_headers), rt.cast_array(var_headers)])
}

fn unregister_default_headers(var_header rt.PhpVal) bool {
	mut var__wp_default_headers := rt.new_null()
	if rt.is_true(rt.new_bool(var_header.clone().is_array())) {
		rt.call_function('array_map', [rt.new_string('unregister_default_headers'), var_header.clone()])
	} else if var__wp_default_headers.array_isset(var_header) {
		var__wp_default_headers.array_unset(var_header)
		return true
	} else {
		return false
	}
	return false
}

fn has_header_video() bool {
	return get_header_video_url()
}

fn get_header_video_url() bool {
	mut var_id := rt.new_null()
	mut var_url := rt.new_null()
	var_id = rt.call_function('absint', [get_theme_mod('header_video', false)])
	if rt.is_true(var_id) {
	var_url = rt.call_function('wp_get_attachment_url', [var_id.clone()])
	} else {
	var_url = get_theme_mod('external_header_video', false)
	}
	var_url = rt.call_function('apply_filters', [rt.new_string('get_header_video_url'), var_url.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_id)))) && rt.is_true(rt.new_bool(!(rt.is_true(var_url)))) {
		return false
	}
	return (rt.call_function('sanitize_url', [rt.call_function('set_url_scheme', [var_url.clone()])])).to_bool()
}

fn the_header_video_url() {
	mut var_video := false
	var_video = get_header_video_url()
	if var_video {
		rt.echo_val(rt.call_function('esc_url', [rt.new_bool(var_video).clone()]))
	}
}

fn get_header_video_settings() rt.PhpVal {
	mut var_header := rt.new_null()
	mut var_video_url := false
	mut var_video_type := rt.new_null()
	mut var_settings := map[string]rt.PhpVal{}
	var_header = get_custom_header()
	var_video_url = get_header_video_url()
	var_video_type = rt.call_function('wp_check_filetype', [rt.new_bool(var_video_url).clone(), rt.call_function('wp_get_mime_types', []rt.PhpVal{})])
	var_settings = { 'mimeType': rt.new_string(''), 'posterUrl': rt.new_bool(get_header_image()), 'videoUrl': rt.new_bool(var_video_url), 'width': rt.call_function('absint', [rt.get_property(var_header, 'width')]), 'height': rt.call_function('absint', [rt.get_property(var_header, 'height')]), 'minWidth': rt.new_int(900), 'minHeight': rt.new_int(500), 'l10n': { 'pause': rt.call_function('__', [rt.new_string('Pause')]), 'play': rt.call_function('__', [rt.new_string('Play')]), 'pauseSpeak': rt.call_function('__', [rt.new_string('Video is paused.')]), 'playSpeak': rt.call_function('__', [rt.new_string('Video is playing.')]) } }
	if rt.is_true(rt.call_function('preg_match', [rt.new_string('#^https?://(?:www\\.)?(?:youtube\\.com/watch|youtu\\.be/)#'), rt.new_bool(var_video_url).clone()])) {
		var_settings['mimeType'] = rt.new_string('video/x-youtube')
	} else if !(!rt.is_true(var_video_type.array_get(rt.new_string('type')))) {
		var_settings['mimeType'] = var_video_type.array_get(rt.new_string('type'))
	}
	return rt.call_function('apply_filters', [rt.new_string('header_video_settings'), rt.create_array_from_native_map(var_settings)])
}

fn has_custom_header() bool {
	if has_header_image() || (has_header_video() && is_header_video_active()) {
		return true
	}
	return false
}

fn is_header_video_active() bool {
	mut var_video_active_cb := rt.new_null()
	mut var_show_video := rt.new_null()
	if !(get_theme_support('custom-header', 'video')) {
		return false
	}
	var_video_active_cb = rt.new_bool(get_theme_support('custom-header', rt.new_string('video-active-callback')))
	if !rt.is_true(var_video_active_cb) || !(rt.call_function('is_callable', [var_video_active_cb.clone()])) {
	var_show_video = rt.new_bool(true)
	} else {
	var_show_video = rt.call_function('call_user_func', [var_video_active_cb.clone()])
	}
	return (rt.call_function('apply_filters', [rt.new_string('is_header_video_active'), var_show_video.clone()])).to_bool()
}

fn get_custom_header_markup() string {
	if !(has_custom_header()) && !(is_customize_preview()) {
		return ''
	}
	return (rt.call_function('sprintf', [rt.new_string('<div id="wp-custom-header" class="wp-custom-header">%s</div>'), rt.new_string(get_header_image_tag(rt.new_null()))])).str()
}

fn the_custom_header_markup() {
	mut var_custom_header := ''
	var_custom_header = get_custom_header_markup()
	if var_custom_header == '' {
		return
	}
	print(var_custom_header)
	if is_header_video_active() && has_header_video() || is_customize_preview() {
		rt.call_function('wp_enqueue_script', [rt.new_string('wp-custom-header')])
		rt.call_function('wp_localize_script', [rt.new_string('wp-custom-header'), rt.new_string('_wpCustomHeaderSettings'), get_header_video_settings()])
	}
}

fn get_background_image() rt.PhpVal {
	return get_theme_mod('background_image', get_theme_support('custom-background', 'default-image'))
}

fn background_image() {
	rt.echo_val(get_background_image())
}

fn get_background_color() rt.PhpVal {
	return get_theme_mod('background_color', get_theme_support('custom-background', 'default-color'))
}

fn background_color() {
	rt.echo_val(get_background_color())
}

fn _custom_background_cb() {
	mut var_background := rt.new_null()
	mut var_color := rt.new_null()
	mut var_style := rt.new_null()
	mut var_image := rt.new_null()
	mut var_position_x := rt.new_null()
	mut var_position_y := rt.new_null()
	mut var_position := ''
	mut var_size := rt.new_null()
	mut var_repeat := rt.new_null()
	mut var_attachment := rt.new_null()
	mut var_processor := rt.new_null()
	mut var_style_tag_content := rt.new_null()
	var_background = rt.call_function('set_url_scheme', [get_background_image()])
	var_color = get_background_color()
	if rt.is_true(rt.identical(rt.new_bool(get_theme_support('custom-background', rt.new_string('default-color'))), var_color)) {
	var_color = rt.new_bool(false)
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_background)))) && rt.is_true(rt.new_bool(!(rt.is_true(var_color)))) {
		if rt.is_true(rt.new_bool(is_customize_preview())) {
			print('<style id="custom-background-css"></style>')
		}
		return
	}
	var_style = rt.new_string((if rt.is_true(var_color) { 'background-color: ' + (rt.call_function('maybe_hash_hex_color', [var_color.clone()])).str() + ';' } else { '' }).str())
	if rt.is_true(var_background) {
		var_image = rt.new_string(' background-image: url("' + (rt.call_function('sanitize_url', [var_background.clone()])).str() + '");')
		var_position_x = get_theme_mod('background_position_x', get_theme_support('custom-background', 'default-position-x'))
		var_position_y = get_theme_mod('background_position_y', get_theme_support('custom-background', 'default-position-y'))
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_position_x.clone(), rt.create_array([rt.ArrayItem{ key: none, val: 'left' }, rt.ArrayItem{ key: none, val: 'center' }, rt.ArrayItem{ key: none, val: 'right' }]), rt.new_bool(true)]))))) {
		var_position_x = rt.new_string('left')
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_position_y.clone(), rt.create_array([rt.ArrayItem{ key: none, val: 'top' }, rt.ArrayItem{ key: none, val: 'center' }, rt.ArrayItem{ key: none, val: 'bottom' }]), rt.new_bool(true)]))))) {
		var_position_y = rt.new_string('top')
		}
		var_position = " background-position: ${var_position_x.to_string()} ${var_position_y.to_string()};"
		var_size = get_theme_mod('background_size', get_theme_support('custom-background', 'default-size'))
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_size.clone(), rt.create_array([rt.ArrayItem{ key: none, val: 'auto' }, rt.ArrayItem{ key: none, val: 'contain' }, rt.ArrayItem{ key: none, val: 'cover' }]), rt.new_bool(true)]))))) {
		var_size = rt.new_string('auto')
		}
		var_size = rt.new_string(" background-size: ${var_size.to_string()};")
		var_repeat = get_theme_mod('background_repeat', get_theme_support('custom-background', 'default-repeat'))
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_repeat.clone(), rt.create_array([rt.ArrayItem{ key: none, val: 'repeat-x' }, rt.ArrayItem{ key: none, val: 'repeat-y' }, rt.ArrayItem{ key: none, val: 'repeat' }, rt.ArrayItem{ key: none, val: 'no-repeat' }]), rt.new_bool(true)]))))) {
		var_repeat = rt.new_string('repeat')
		}
		var_repeat = rt.new_string(" background-repeat: ${var_repeat.to_string()};")
		var_attachment = get_theme_mod('background_attachment', get_theme_support('custom-background', 'default-attachment'))
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('fixed'), var_attachment)))) {
		var_attachment = rt.new_string('scroll')
		}
		var_attachment = rt.new_string(" background-attachment: ${var_attachment.to_string()};")
		var_style = rt.concat(var_style, rt.new_string((var_image).str() + var_position + (var_size).str() + (var_repeat).str() + (var_attachment).str()))
	}
	var_processor = create_wp_html_tag_processor(rt.new_string('<style id="custom-background-css"></style>'))
	var_processor.next_tag()
	var_style_tag_content = rt.new_string('body.custom-background { ' + var_style.clone().to_string().trim_space() + ' }')
	var_processor.set_modifiable_text(rt.new_string("\n${var_style_tag_content.to_string()}\n"))
	print(rt.concat(var_processor.get_updated_html(), rt.new_string('\n')))
}

fn wp_custom_css_cb() {
	mut var_styles := rt.new_null()
	mut var_processor := rt.new_null()
	var_styles = wp_get_custom_css('')
	if rt.is_true(rt.new_bool(!(rt.is_true(var_styles)))) && !(is_customize_preview()) {
		return
	}
	var_processor = create_wp_html_tag_processor(rt.new_string('<style></style>'))
	var_processor.next_tag()
	var_processor.set_attribute(rt.new_string('id'), rt.new_string('wp-custom-css'))
	var_processor.set_modifiable_text(rt.new_string("\n${var_styles.to_string()}\n"))
	print(rt.concat(var_processor.get_updated_html(), rt.new_string('\n')))
}

fn wp_get_custom_css_post(stylesheet string) rt.PhpVal {
	mut var_stylesheet := stylesheet
	mut var_custom_css_query_vars := map[string]rt.PhpVal{}
	mut var_post := rt.new_null()
	mut var_post_id := rt.new_null()
	mut var_query := rt.new_null()
	if var_stylesheet == '' {
	var_stylesheet = (get_stylesheet()).str()
	}
	var_custom_css_query_vars = { 'post_type': rt.new_string('custom_css'), 'post_status': rt.call_function('get_post_stati', []rt.PhpVal{}), 'name': rt.call_function('sanitize_title', [rt.new_string((var_stylesheet).str())]), 'posts_per_page': rt.new_int(1), 'no_found_rows': rt.new_bool(true), 'cache_results': rt.new_bool(true), 'update_post_meta_cache': rt.new_bool(false), 'update_post_term_cache': rt.new_bool(false), 'lazy_load_term_meta': rt.new_bool(false) }
	var_post = rt.new_null()
	if rt.is_true(rt.identical(get_stylesheet(), rt.new_string((var_stylesheet).str()))) {
		var_post_id = get_theme_mod('custom_css_post_id', false)
		if rt.is_true(rt.greater(var_post_id, rt.new_int(0))) && rt.is_true(rt.call_function('get_post', [var_post_id.clone()])) {
		var_post = rt.call_function('get_post', [var_post_id.clone()])
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(var_post)))) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(-1, var_post_id)))) {
			var_query = create_wp_query(var_custom_css_query_vars.clone())
			var_post = rt.get_property(var_query, 'post')
			set_theme_mod('custom_css_post_id', if rt.is_true(var_post) { rt.get_property(var_post, 'ID') } else { -1 })
		}
	} else {
	var_query = create_wp_query(var_custom_css_query_vars.clone())
	var_post = rt.get_property(var_query, 'post')
	}
	return var_post.clone()
}

fn wp_get_custom_css(stylesheet string) rt.PhpVal {
	mut var_stylesheet := stylesheet
	mut var_css := rt.new_null()
	mut var_post := rt.new_null()
	var_css = rt.new_string('')
	if var_stylesheet == '' {
	var_stylesheet = (get_stylesheet()).str()
	}
	var_post = wp_get_custom_css_post(var_stylesheet)
	if rt.is_true(var_post) {
	var_css = rt.get_property(var_post, 'post_content')
	}
	var_css = rt.call_function('apply_filters', [rt.new_string('wp_get_custom_css'), var_css.clone(), rt.new_string((var_stylesheet).str())])
	return var_css.clone()
}

fn wp_update_custom_css_post(var_css rt.PhpVal, var_args_arg rt.PhpVal) rt.PhpVal {
	mut var_args := var_args_arg
	mut var_data := rt.new_null()
	mut var_post_data := map[string]rt.PhpVal{}
	mut var_post := rt.new_null()
	mut var_r := rt.new_null()
	mut var_revisions := rt.new_null()
	var_args = rt.call_function('wp_parse_args', [var_args.clone(), rt.create_array([rt.ArrayItem{ key: 'preprocessed', val: '' }, rt.ArrayItem{ key: 'stylesheet', val: get_stylesheet() }])])
	var_data = rt.create_array([rt.ArrayItem{ key: 'css', val: var_css }, rt.ArrayItem{ key: 'preprocessed', val: var_args.array_get(rt.new_string('preprocessed')) }])
	var_data = rt.call_function('apply_filters', [rt.new_string('update_custom_css_data'), var_data.clone(), rt.call_function('array_merge', [var_args.clone(), rt.call_function('compact', [rt.new_string('css')])])])
	var_post_data = { 'post_title': var_args.array_get(rt.new_string('stylesheet')), 'post_name': rt.call_function('sanitize_title', [var_args.array_get(rt.new_string('stylesheet'))]), 'post_type': rt.new_string('custom_css'), 'post_status': rt.new_string('publish'), 'post_content': var_data.array_get(rt.new_string('css')), 'post_content_filtered': var_data.array_get(rt.new_string('preprocessed')) }
	var_post = wp_get_custom_css_post(var_args.array_get(rt.new_string('stylesheet')))
	if rt.is_true(var_post) {
		var_post_data['ID'] = rt.get_property(var_post, 'ID')
	var_r = rt.call_function('wp_update_post', [rt.call_function('wp_slash', [rt.create_array_from_native_map(var_post_data)]), rt.new_bool(true)])
	} else {
		var_r = rt.call_function('wp_insert_post', [rt.call_function('wp_slash', [rt.create_array_from_native_map(var_post_data)]), rt.new_bool(true)])
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [var_r.clone()]))))) {
			if rt.is_true(rt.identical(get_stylesheet(), var_args.array_get(rt.new_string('stylesheet')))) {
				set_theme_mod('custom_css_post_id', var_r.clone())
			}
			var_revisions = rt.call_function('wp_get_latest_revision_id_and_total_count', [var_r.clone()])
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [var_revisions.clone()]))))) && rt.is_true(rt.identical(rt.new_int(0), var_revisions.array_get(rt.new_string('count')))) {
				rt.call_function('wp_save_post_revision', [var_r.clone()])
			}
		}
	}
	if rt.is_true(rt.call_function('is_wp_error', [var_r.clone()])) {
		return var_r.clone()
	}
	return rt.call_function('get_post', [var_r.clone()])
}

fn add_editor_style(stylesheet string) {
	mut var_stylesheet := stylesheet
	mut var_editor_styles := rt.new_null()
	mut var_rtl_stylesheet := rt.new_null()
	rt.new_bool(add_theme_support('editor-style'))
	var_editor_styles = rt.cast_array(var_editor_styles)
	var_stylesheet = (rt.cast_array(rt.new_string((var_stylesheet).str()))).str()
	if rt.is_true(rt.call_function('is_rtl', []rt.PhpVal{})) {
		var_rtl_stylesheet = rt.call_function('str_replace', [rt.new_string('.css'), rt.new_string('-rtl.css'), rt.new_string((var_stylesheet).str()).array_get(rt.new_int(0))])
		rt.new_string((var_stylesheet).str()).array_push(var_rtl_stylesheet.clone())
	}
var_editor_styles = rt.call_function('array_merge', [var_editor_styles.clone(), rt.new_string((var_stylesheet).str())])
}

fn remove_editor_styles() bool {
	mut var_GLOBALS := rt.new_null()
	if !(current_theme_supports('editor-style')) {
		return false
	}
	rt.new_bool(_remove_theme_support(rt.new_string('editor-style')))
	if rt.is_true(rt.call_function('is_admin', []rt.PhpVal{})) {
		var_GLOBALS.array_set('editor_styles', rt.new_array())
	}
	return true
}

fn get_editor_stylesheets() rt.PhpVal {
	mut var_GLOBALS := rt.new_null()
	mut var_stylesheets := []rt.PhpVal{}
	mut var_editor_styles := rt.new_null()
	mut var_style_uri := rt.new_null()
	mut var_style_dir := rt.new_null()
	mut var_file := rt.new_null()
	mut var_key := rt.new_null()
	mut var_template_uri := rt.new_null()
	mut var_template_dir := rt.new_null()
	var_stylesheets = rt.new_array()
	if !(!rt.is_true(var_GLOBALS.array_get(rt.new_string('editor_styles')))) && var_GLOBALS.array_get(rt.new_string('editor_styles')).is_array() {
		var_editor_styles = var_GLOBALS.array_get(rt.new_string('editor_styles'))
		var_editor_styles = rt.call_function('array_unique', [rt.call_function('array_filter', [var_editor_styles.clone()])])
		var_style_uri = get_stylesheet_directory_uri()
		var_style_dir = get_stylesheet_directory()
		mut iter_13 := var_editor_styles.iterator()
		for {
			item_13 := iter_13.next() or { break }
			mut var_file_shadow := item_13.val
			mut var_key_shadow := item_13.key
			if rt.is_true(rt.call_function('preg_match', [rt.new_string('~^(https?:)?//~'), var_file_shadow.clone()])) {
				var_stylesheets << rt.call_function('sanitize_url', [var_file_shadow.clone()])
				var_editor_styles.array_unset(var_key_shadow)
			}
		}
		if rt.is_true(rt.new_bool(is_child_theme())) {
			var_template_uri = get_template_directory_uri()
			var_template_dir = get_template_directory()
			mut iter_14 := var_editor_styles.iterator()
			for {
				item_14 := iter_14.next() or { break }
				mut var_file_shadow := item_14.val
				mut var_key_shadow := item_14.key
				if rt.is_true(var_file_shadow) && rt.is_true(rt.call_function('file_exists', [rt.new_string("${var_template_dir.to_string()}/${var_file.to_string()}")])) {
					var_stylesheets << rt.new_string("${var_template_uri.to_string()}/${var_file.to_string()}")
				}
			}
		}
		mut iter_15 := var_editor_styles.iterator()
		for {
			item_15 := iter_15.next() or { break }
			mut var_file_shadow := item_15.val
			if rt.is_true(var_file_shadow) && rt.is_true(rt.call_function('file_exists', [rt.new_string("${var_style_dir.to_string()}/${var_file.to_string()}")])) {
				var_stylesheets << rt.new_string("${var_style_uri.to_string()}/${var_file.to_string()}")
			}
		}
	}
	return rt.call_function('apply_filters', [rt.new_string('editor_stylesheets'), rt.create_array_from_list(var_stylesheets)])
}

fn get_theme_starter_content() rt.PhpVal {
	mut var_theme_support := rt.new_null()
	mut var_config := rt.new_null()
	mut var_core_content := map[string]rt.PhpVal{}
	mut var_content := rt.new_null()
	mut var_args := rt.new_null()
	mut var_type := rt.new_null()
	mut var_widgets := rt.new_null()
	mut var_sidebar_id := rt.new_null()
	mut var_widget := rt.new_null()
	mut var_id := rt.new_null()
	mut var_nav_menu := rt.new_null()
	mut var_nav_menu_location := rt.new_null()
	mut var_nav_menu_item := rt.new_null()
	mut var_item := rt.new_null()
	var_theme_support = rt.new_bool(get_theme_support('starter-content'))
	if var_theme_support.clone().is_array() && !(!rt.is_true(var_theme_support.array_get(rt.new_int(0)))) && var_theme_support.array_get(rt.new_int(0)).is_array() {
	var_config = var_theme_support.array_get(rt.new_int(0))
	} else {
	var_config = rt.new_array()
	}
	var_core_content = { 'widgets': { 'text_business_info': map[string]rt.PhpVal{}, 'text_about': map[string]rt.PhpVal{}, 'archives': map[string]rt.PhpVal{}, 'calendar': map[string]rt.PhpVal{}, 'categories': map[string]rt.PhpVal{}, 'meta': map[string]rt.PhpVal{}, 'recent-comments': map[string]rt.PhpVal{}, 'recent-posts': map[string]rt.PhpVal{}, 'search': map[string]rt.PhpVal{} }, 'nav_menus': { 'link_home': { 'type': rt.new_string('custom'), 'title': rt.call_function('_x', [rt.new_string('Home'), rt.new_string('Theme starter content')]), 'url': rt.call_function('home_url', [rt.new_string('/')]) }, 'page_home': { 'type': rt.new_string('post_type'), 'object': rt.new_string('page'), 'object_id': rt.new_string('{{home}}') }, 'page_about': { 'type': rt.new_string('post_type'), 'object': rt.new_string('page'), 'object_id': rt.new_string('{{about}}') }, 'page_blog': { 'type': rt.new_string('post_type'), 'object': rt.new_string('page'), 'object_id': rt.new_string('{{blog}}') }, 'page_news': { 'type': rt.new_string('post_type'), 'object': rt.new_string('page'), 'object_id': rt.new_string('{{news}}') }, 'page_contact': { 'type': rt.new_string('post_type'), 'object': rt.new_string('page'), 'object_id': rt.new_string('{{contact}}') }, 'link_email': { 'title': rt.call_function('_x', [rt.new_string('Email'), rt.new_string('Theme starter content')]), 'url': rt.new_string('mailto:wordpress@example.com') }, 'link_facebook': { 'title': rt.call_function('_x', [rt.new_string('Facebook'), rt.new_string('Theme starter content')]), 'url': rt.new_string('https://www.facebook.com/wordpress') }, 'link_foursquare': { 'title': rt.call_function('_x', [rt.new_string('Foursquare'), rt.new_string('Theme starter content')]), 'url': rt.new_string('https://foursquare.com/') }, 'link_github': { 'title': rt.call_function('_x', [rt.new_string('GitHub'), rt.new_string('Theme starter content')]), 'url': rt.new_string('https://github.com/wordpress/') }, 'link_instagram': { 'title': rt.call_function('_x', [rt.new_string('Instagram'), rt.new_string('Theme starter content')]), 'url': rt.new_string('https://www.instagram.com/explore/tags/wordcamp/') }, 'link_linkedin': { 'title': rt.call_function('_x', [rt.new_string('LinkedIn'), rt.new_string('Theme starter content')]), 'url': rt.new_string('https://www.linkedin.com/company/1089783') }, 'link_pinterest': { 'title': rt.call_function('_x', [rt.new_string('Pinterest'), rt.new_string('Theme starter content')]), 'url': rt.new_string('https://www.pinterest.com/') }, 'link_twitter': { 'title': rt.call_function('_x', [rt.new_string('Twitter'), rt.new_string('Theme starter content')]), 'url': rt.new_string('https://twitter.com/wordpress') }, 'link_yelp': { 'title': rt.call_function('_x', [rt.new_string('Yelp'), rt.new_string('Theme starter content')]), 'url': rt.new_string('https://www.yelp.com') }, 'link_youtube': { 'title': rt.call_function('_x', [rt.new_string('YouTube'), rt.new_string('Theme starter content')]), 'url': rt.new_string('https://www.youtube.com/channel/UCdof4Ju7amm1chz1gi1T2ZA') } }, 'posts': { 'home': { 'post_type': rt.new_string('page'), 'post_title': rt.call_function('_x', [rt.new_string('Home'), rt.new_string('Theme starter content')]), 'post_content': rt.call_function('sprintf', [rt.new_string('<!-- wp:paragraph -->\n<p>%s</p>\n<!-- /wp:paragraph -->'), rt.call_function('_x', [rt.new_string('Welcome to your site! This is your homepage, which is what most visitors will see when they come to your site for the first time.'), rt.new_string('Theme starter content')])]) }, 'about': { 'post_type': rt.new_string('page'), 'post_title': rt.call_function('_x', [rt.new_string('About'), rt.new_string('Theme starter content')]), 'post_content': rt.call_function('sprintf', [rt.new_string('<!-- wp:paragraph -->\n<p>%s</p>\n<!-- /wp:paragraph -->'), rt.call_function('_x', [rt.new_string('You might be an artist who would like to introduce yourself and your work here or maybe you are a business with a mission to describe.'), rt.new_string('Theme starter content')])]) }, 'contact': { 'post_type': rt.new_string('page'), 'post_title': rt.call_function('_x', [rt.new_string('Contact'), rt.new_string('Theme starter content')]), 'post_content': rt.call_function('sprintf', [rt.new_string('<!-- wp:paragraph -->\n<p>%s</p>\n<!-- /wp:paragraph -->'), rt.call_function('_x', [rt.new_string('This is a page with some basic contact information, such as an address and phone number. You might also try a plugin to add a contact form.'), rt.new_string('Theme starter content')])]) }, 'blog': { 'post_type': rt.new_string('page'), 'post_title': rt.call_function('_x', [rt.new_string('Blog'), rt.new_string('Theme starter content')]) }, 'news': { 'post_type': rt.new_string('page'), 'post_title': rt.call_function('_x', [rt.new_string('News'), rt.new_string('Theme starter content')]) }, 'homepage-section': { 'post_type': rt.new_string('page'), 'post_title': rt.call_function('_x', [rt.new_string('A homepage section'), rt.new_string('Theme starter content')]), 'post_content': rt.call_function('sprintf', [rt.new_string('<!-- wp:paragraph -->\n<p>%s</p>\n<!-- /wp:paragraph -->'), rt.call_function('_x', [rt.new_string('This is an example of a homepage section. Homepage sections can be any page other than the homepage itself, including the page that shows your latest blog posts.'), rt.new_string('Theme starter content')])]) } } }
	var_content = rt.new_array()
	mut iter_16 := var_config.iterator()
	for {
		item_16 := iter_16.next() or { break }
		mut var_args_shadow := item_16.val
		mut var_type_shadow := item_16.key
		mut switch_val_1 := var_type_shadow
		if rt.is_true(rt.equal(switch_val_1, rt.new_string('options'))) || rt.is_true(rt.equal(switch_val_1, rt.new_string('theme_mods'))) {
			var_content.array_set(var_type_shadow, var_config.array_get(var_type_shadow))
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('widgets'))) {
			mut iter_17 := var_config.array_get(var_type_shadow).iterator()
			for {
				item_17 := iter_17.next() or { break }
				mut var_widgets_shadow := item_17.val
				mut var_sidebar_id_shadow := item_17.key
				mut iter_18 := var_widgets_shadow.iterator()
				for {
					item_18 := iter_18.next() or { break }
					mut var_widget_shadow := item_18.val
					mut var_id_shadow := item_18.key
					if rt.is_true(rt.new_bool(var_widget_shadow.clone().is_array())) {
						if !(!rt.is_true(var_core_content[var_type_shadow].array_get(var_id_shadow))) {
						var_widget_shadow = rt.create_array([rt.ArrayItem{ key: none, val: var_core_content[var_type_shadow].array_get(var_id_shadow).array_get(rt.new_int(0)) }, rt.ArrayItem{ key: none, val: rt.call_function('array_merge', [var_core_content[var_type_shadow].array_get(var_id_shadow).array_get(rt.new_int(1)), var_widget_shadow.clone()]) }])
						}
						var_content.array_get_mut(var_type_shadow).array_get_mut(var_sidebar_id_shadow).array_push(var_widget_shadow.clone())
					} else if var_widget_shadow.clone().is_string() && !(!rt.is_true(var_core_content[var_type_shadow])) && !(!rt.is_true(var_core_content[var_type_shadow].array_get(var_widget_shadow))) {
						var_content.array_get_mut(var_type_shadow).array_get_mut(var_sidebar_id_shadow).array_push(var_core_content[var_type_shadow].array_get(var_widget_shadow))
					}
				}
			}
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('nav_menus'))) {
			mut iter_19 := var_config.array_get(var_type_shadow).iterator()
			for {
				item_19 := iter_19.next() or { break }
				mut var_nav_menu_shadow := item_19.val
				mut var_nav_menu_location_shadow := item_19.key
				if !rt.is_true(var_nav_menu_shadow.array_get(rt.new_string('name'))) {
					var_nav_menu_shadow.array_set('name', var_nav_menu_location_shadow.clone())
				}
				var_content.array_get_mut(var_type_shadow).array_get_mut(var_nav_menu_location_shadow).array_set('name', var_nav_menu_shadow.array_get(rt.new_string('name')))
				mut iter_20 := var_nav_menu_shadow.array_get(rt.new_string('items')).iterator()
				for {
					item_20 := iter_20.next() or { break }
					mut var_nav_menu_item_shadow := item_20.val
					mut var_id_shadow := item_20.key
					if rt.is_true(rt.new_bool(var_nav_menu_item_shadow.clone().is_array())) {
						if !(!rt.is_true(var_core_content[var_type_shadow].array_get(var_id_shadow))) {
						var_nav_menu_item_shadow = rt.call_function('array_merge', [var_core_content[var_type_shadow].array_get(var_id_shadow), var_nav_menu_item_shadow.clone()])
						}
						var_content.array_get_mut(var_type_shadow).array_get_mut(var_nav_menu_location_shadow).array_get_mut('items').array_push(var_nav_menu_item_shadow.clone())
					} else if var_nav_menu_item_shadow.clone().is_string() && !(!rt.is_true(var_core_content[var_type_shadow])) && !(!rt.is_true(var_core_content[var_type_shadow].array_get(var_nav_menu_item_shadow))) {
						var_content.array_get_mut(var_type_shadow).array_get_mut(var_nav_menu_location_shadow).array_get_mut('items').array_push(var_core_content[var_type_shadow].array_get(var_nav_menu_item_shadow))
					}
				}
			}
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('attachments'))) {
			mut iter_21 := var_config.array_get(var_type_shadow).iterator()
			for {
				item_21 := iter_21.next() or { break }
				mut var_item_shadow := item_21.val
				mut var_id_shadow := item_21.key
				if !(!rt.is_true(var_item_shadow.array_get(rt.new_string('file')))) {
					var_content.array_get_mut(var_type_shadow).array_set(var_id_shadow, var_item_shadow.clone())
				}
			}
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('posts'))) {
			mut iter_22 := var_config.array_get(var_type_shadow).iterator()
			for {
				item_22 := iter_22.next() or { break }
				mut var_item_shadow := item_22.val
				mut var_id_shadow := item_22.key
				if rt.is_true(rt.new_bool(var_item_shadow.clone().is_array())) {
					if !(!rt.is_true(var_core_content[var_type_shadow].array_get(var_id_shadow))) {
					var_item_shadow = rt.call_function('array_merge', [var_core_content[var_type_shadow].array_get(var_id_shadow), var_item_shadow.clone()])
					}
					var_content.array_get_mut(var_type_shadow).array_set(var_id_shadow, rt.call_function('wp_array_slice_assoc', [var_item_shadow.clone(), rt.create_array([rt.ArrayItem{ key: none, val: 'post_type' }, rt.ArrayItem{ key: none, val: 'post_title' }, rt.ArrayItem{ key: none, val: 'post_excerpt' }, rt.ArrayItem{ key: none, val: 'post_name' }, rt.ArrayItem{ key: none, val: 'post_content' }, rt.ArrayItem{ key: none, val: 'menu_order' }, rt.ArrayItem{ key: none, val: 'comment_status' }, rt.ArrayItem{ key: none, val: 'thumbnail' }, rt.ArrayItem{ key: none, val: 'template' }])]))
				} else if var_item_shadow.clone().is_string() && !(!rt.is_true(var_core_content[var_type_shadow].array_get(var_item_shadow))) {
					var_content.array_get_mut(var_type_shadow).array_set(var_item_shadow, var_core_content[var_type_shadow].array_get(var_item_shadow))
				}
			}
		}
	}
	return rt.call_function('apply_filters', [rt.new_string('get_theme_starter_content'), var_content.clone(), var_config.clone()])
}

fn add_theme_support(feature string, var_args_origin ...rt.PhpVal) bool {
	mut var_args := rt.create_array_from_list(var_args_origin)
	mut var_feature := feature
	mut var_args := var_args_arg
	mut var__wp_theme_features := rt.new_null()
	mut var_post_formats := rt.new_null()
	mut var_defaults := map[string]rt.PhpVal{}
	mut var_jit := rt.new_null()
	if !(var_args) {
	var_args = true
	}
	mut switch_val_2 := rt.new_string(feature)
	if rt.is_true(rt.equal(switch_val_2, rt.new_string('post-thumbnails'))) {
		if rt.is_true(rt.identical(rt.new_bool(true), rt.new_bool(get_theme_support('post-thumbnails')))) {
			return false
		}
		if rt.new_bool(var_args).array_isset(rt.new_int(0)) && rt.new_bool(var_args).array_get(rt.new_int(0)).is_array() && var__wp_theme_features.array_isset(rt.new_string('post-thumbnails')) {
			rt.new_bool(var_args).array_set(0, rt.call_function('array_unique', [rt.call_function('array_merge', [var__wp_theme_features.array_get(rt.new_string('post-thumbnails')).array_get(rt.new_int(0)), rt.new_bool(var_args).array_get(rt.new_int(0))])]))
		}
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('post-formats'))) {
		if rt.new_bool(var_args).array_isset(rt.new_int(0)) && rt.new_bool(var_args).array_get(rt.new_int(0)).is_array() {
			var_post_formats = rt.call_function('get_post_format_slugs', []rt.PhpVal{})
			var_post_formats.array_unset(rt.new_string('standard'))
			rt.new_bool(var_args).array_set(0, rt.call_function('array_intersect', [rt.new_bool(var_args).array_get(rt.new_int(0)), rt.func_array_keys(var_post_formats.clone())]))
		} else {
			rt.call_function('_doing_it_wrong', [rt.new_string('add_theme_support( \'post-formats\' )'), rt.call_function('__', [rt.new_string('You need to pass an array of post formats.')]), rt.new_string('5.6.0')])
			return false
		}
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('html5'))) {
		if !rt.is_true(rt.new_bool(var_args).array_get(rt.new_int(0))) || !(rt.new_bool(var_args).array_get(rt.new_int(0)).is_array()) {
			rt.call_function('_doing_it_wrong', [rt.new_string('add_theme_support( \'html5\' )'), rt.call_function('__', [rt.new_string('You need to pass an array of types.')]), rt.new_string('3.6.1')])
			if !(!rt.is_true(rt.new_bool(var_args).array_get(rt.new_int(0)))) && !(rt.new_bool(var_args).array_get(rt.new_int(0)).is_array()) {
				return false
			}
		var_args = (rt.create_array([rt.ArrayItem{ key: 0, val: rt.create_array([rt.ArrayItem{ key: none, val: 'comment-list' }, rt.ArrayItem{ key: none, val: 'comment-form' }, rt.ArrayItem{ key: none, val: 'search-form' }]) }])).to_bool()
		}
		if var__wp_theme_features.array_isset(rt.new_string('html5')) {
			rt.new_bool(var_args).array_set(0, rt.call_function('array_merge', [var__wp_theme_features.array_get(rt.new_string('html5')).array_get(rt.new_int(0)), rt.new_bool(var_args).array_get(rt.new_int(0))]))
		}
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('custom-logo'))) {
		if rt.is_true(rt.identical(rt.new_bool(true), rt.new_bool(var_args))) {
		var_args = (rt.create_array([rt.ArrayItem{ key: 0, val: rt.new_array() }])).to_bool()
		}
		var_defaults = { 'width': rt.new_null(), 'height': rt.new_null(), 'flex-width': rt.new_bool(false), 'flex-height': rt.new_bool(false), 'header-text': rt.new_string(''), 'unlink-homepage-logo': rt.new_bool(false) }
		rt.new_bool(var_args).array_set(0, rt.call_function('wp_parse_args', [rt.call_function('array_intersect_key', [rt.new_bool(var_args).array_get(rt.new_int(0)), rt.create_array_from_native_map(var_defaults)]), rt.create_array_from_native_map(var_defaults)]))
		if rt.new_bool(var_args).array_get(rt.new_int(0)).array_get(rt.new_string('width')).is_null() && rt.new_bool(var_args).array_get(rt.new_int(0)).array_get(rt.new_string('height')).is_null() {
			rt.new_bool(var_args).array_get_mut(0).array_set('flex-width', true)
			rt.new_bool(var_args).array_get_mut(0).array_set('flex-height', true)
		}
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('custom-header-uploads'))) {
		return add_theme_support('custom-header', rt.create_array([rt.ArrayItem{ key: 'uploads', val: true }]))
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('custom-header'))) {
		if rt.is_true(rt.identical(rt.new_bool(true), rt.new_bool(var_args))) {
		var_args = (rt.create_array([rt.ArrayItem{ key: 0, val: rt.new_array() }])).to_bool()
		}
		var_defaults = { 'default-image': rt.new_string(''), 'random-default': rt.new_bool(false), 'width': rt.new_int(0), 'height': rt.new_int(0), 'flex-height': rt.new_bool(false), 'flex-width': rt.new_bool(false), 'default-text-color': rt.new_string(''), 'header-text': rt.new_bool(true), 'uploads': rt.new_bool(true), 'wp-head-callback': rt.new_string(''), 'admin-head-callback': rt.new_string(''), 'admin-preview-callback': rt.new_string(''), 'video': rt.new_bool(false), 'video-active-callback': rt.new_string('is_front_page') }
		var_jit = rt.new_bool(rt.new_bool(var_args).array_get(rt.new_int(0)).array_isset(rt.new_string('__jit')))
		rt.new_bool(var_args).array_get(rt.new_int(0)).array_unset(rt.new_string('__jit'))
		if var__wp_theme_features.array_isset(rt.new_string('custom-header')) {
			rt.new_bool(var_args).array_set(0, rt.call_function('wp_parse_args', [var__wp_theme_features.array_get(rt.new_string('custom-header')).array_get(rt.new_int(0)), rt.new_bool(var_args).array_get(rt.new_int(0))]))
		}
		if rt.is_true(var_jit) {
			rt.new_bool(var_args).array_set(0, rt.call_function('wp_parse_args', [rt.new_bool(var_args).array_get(rt.new_int(0)), rt.create_array_from_native_map(var_defaults)]))
		}
		if rt.is_true(rt.call_function('defined', [rt.new_string('NO_HEADER_TEXT')])) {
			rt.new_bool(var_args).array_get_mut(0).array_set('header-text', !(rt.is_true(rt.get_constant('NO_HEADER_TEXT'))))
		} else if rt.new_bool(var_args).array_get(rt.new_int(0)).array_isset(rt.new_string('header-text')) {
			rt.call_function('define', [rt.new_string('NO_HEADER_TEXT'), rt.new_bool(!rt.is_true(rt.new_bool(var_args).array_get(rt.new_int(0)).array_get(rt.new_string('header-text'))))])
		}
		if rt.is_true(rt.call_function('defined', [rt.new_string('HEADER_IMAGE_WIDTH')])) {
			rt.new_bool(var_args).array_get_mut(0).array_set('width', rt.new_int((rt.get_constant('HEADER_IMAGE_WIDTH')).to_i64()))
		} else if rt.new_bool(var_args).array_get(rt.new_int(0)).array_isset(rt.new_string('width')) {
			rt.call_function('define', [rt.new_string('HEADER_IMAGE_WIDTH'), rt.new_int((rt.new_bool(var_args).array_get(rt.new_int(0)).array_get(rt.new_string('width'))).to_i64())])
		}
		if rt.is_true(rt.call_function('defined', [rt.new_string('HEADER_IMAGE_HEIGHT')])) {
			rt.new_bool(var_args).array_get_mut(0).array_set('height', rt.new_int((rt.get_constant('HEADER_IMAGE_HEIGHT')).to_i64()))
		} else if rt.new_bool(var_args).array_get(rt.new_int(0)).array_isset(rt.new_string('height')) {
			rt.call_function('define', [rt.new_string('HEADER_IMAGE_HEIGHT'), rt.new_int((rt.new_bool(var_args).array_get(rt.new_int(0)).array_get(rt.new_string('height'))).to_i64())])
		}
		if rt.is_true(rt.call_function('defined', [rt.new_string('HEADER_TEXTCOLOR')])) {
			rt.new_bool(var_args).array_get_mut(0).array_set('default-text-color', rt.get_constant('HEADER_TEXTCOLOR'))
		} else if rt.new_bool(var_args).array_get(rt.new_int(0)).array_isset(rt.new_string('default-text-color')) {
			rt.call_function('define', [rt.new_string('HEADER_TEXTCOLOR'), rt.new_bool(var_args).array_get(rt.new_int(0)).array_get(rt.new_string('default-text-color'))])
		}
		if rt.is_true(rt.call_function('defined', [rt.new_string('HEADER_IMAGE')])) {
			rt.new_bool(var_args).array_get_mut(0).array_set('default-image', rt.get_constant('HEADER_IMAGE'))
		} else if rt.new_bool(var_args).array_get(rt.new_int(0)).array_isset(rt.new_string('default-image')) {
			rt.call_function('define', [rt.new_string('HEADER_IMAGE'), rt.new_bool(var_args).array_get(rt.new_int(0)).array_get(rt.new_string('default-image'))])
		}
		if rt.is_true(var_jit) && !(!rt.is_true(rt.new_bool(var_args).array_get(rt.new_int(0)).array_get(rt.new_string('default-image')))) {
			rt.new_bool(var_args).array_get_mut(0).array_set('random-default', false)
		}
		if rt.is_true(var_jit) {
			if !rt.is_true(rt.new_bool(var_args).array_get(rt.new_int(0)).array_get(rt.new_string('width'))) && !rt.is_true(rt.new_bool(var_args).array_get(rt.new_int(0)).array_get(rt.new_string('flex-width'))) {
				rt.new_bool(var_args).array_get_mut(0).array_set('flex-width', true)
			}
			if !rt.is_true(rt.new_bool(var_args).array_get(rt.new_int(0)).array_get(rt.new_string('height'))) && !rt.is_true(rt.new_bool(var_args).array_get(rt.new_int(0)).array_get(rt.new_string('flex-height'))) {
				rt.new_bool(var_args).array_get_mut(0).array_set('flex-height', true)
			}
		}
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('custom-background'))) {
		if rt.is_true(rt.identical(rt.new_bool(true), rt.new_bool(var_args))) {
		var_args = (rt.create_array([rt.ArrayItem{ key: 0, val: rt.new_array() }])).to_bool()
		}
		var_defaults = { 'default-image': rt.new_string(''), 'default-preset': rt.new_string('default'), 'default-position-x': rt.new_string('left'), 'default-position-y': rt.new_string('top'), 'default-size': rt.new_string('auto'), 'default-repeat': rt.new_string('repeat'), 'default-attachment': rt.new_string('scroll'), 'default-color': rt.new_string(''), 'wp-head-callback': rt.new_string('_custom_background_cb'), 'admin-head-callback': rt.new_string(''), 'admin-preview-callback': rt.new_string('') }
		var_jit = rt.new_bool(rt.new_bool(var_args).array_get(rt.new_int(0)).array_isset(rt.new_string('__jit')))
		rt.new_bool(var_args).array_get(rt.new_int(0)).array_unset(rt.new_string('__jit'))
		if var__wp_theme_features.array_isset(rt.new_string('custom-background')) {
			rt.new_bool(var_args).array_set(0, rt.call_function('wp_parse_args', [var__wp_theme_features.array_get(rt.new_string('custom-background')).array_get(rt.new_int(0)), rt.new_bool(var_args).array_get(rt.new_int(0))]))
		}
		if rt.is_true(var_jit) {
			rt.new_bool(var_args).array_set(0, rt.call_function('wp_parse_args', [rt.new_bool(var_args).array_get(rt.new_int(0)), rt.create_array_from_native_map(var_defaults)]))
		}
		if rt.is_true(rt.call_function('defined', [rt.new_string('BACKGROUND_COLOR')])) {
			rt.new_bool(var_args).array_get_mut(0).array_set('default-color', rt.get_constant('BACKGROUND_COLOR'))
		} else if rt.new_bool(var_args).array_get(rt.new_int(0)).array_isset(rt.new_string('default-color')) || rt.is_true(var_jit) {
			rt.call_function('define', [rt.new_string('BACKGROUND_COLOR'), rt.new_bool(var_args).array_get(rt.new_int(0)).array_get(rt.new_string('default-color'))])
		}
		if rt.is_true(rt.call_function('defined', [rt.new_string('BACKGROUND_IMAGE')])) {
			rt.new_bool(var_args).array_get_mut(0).array_set('default-image', rt.get_constant('BACKGROUND_IMAGE'))
		} else if rt.new_bool(var_args).array_get(rt.new_int(0)).array_isset(rt.new_string('default-image')) || rt.is_true(var_jit) {
			rt.call_function('define', [rt.new_string('BACKGROUND_IMAGE'), rt.new_bool(var_args).array_get(rt.new_int(0)).array_get(rt.new_string('default-image'))])
		}
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('title-tag'))) {
		if rt.is_true(rt.call_function('did_action', [rt.new_string('wp_loaded')])) {
			rt.call_function('_doing_it_wrong', [rt.new_string('add_theme_support( \'title-tag\' )'), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Theme support for %1$s should be registered before the %2$s hook.')]), rt.new_string('<code>title-tag</code>'), rt.new_string('<code>wp_loaded</code>')]), rt.new_string('4.1.0')])
			return false
		}
	}
	var__wp_theme_features.array_set(feature, var_args)
	return false
}

fn _custom_header_background_just_in_time() {
	mut var_args := rt.new_null()
	mut var_custom_image_header := rt.new_null()
	mut var_custom_background := rt.new_null()
	if rt.is_true(rt.new_bool(current_theme_supports('custom-header'))) {
		rt.new_bool(add_theme_support('custom-header', rt.create_array([rt.ArrayItem{ key: '__jit', val: true }])))
		var_args = rt.new_bool(get_theme_support('custom-header'))
		if rt.is_true(var_args.array_get(rt.new_int(0)).array_get(rt.new_string('wp-head-callback'))) {
			rt.call_function('add_action', [rt.new_string('wp_head'), var_args.array_get(rt.new_int(0)).array_get(rt.new_string('wp-head-callback'))])
		}
		if rt.is_true(rt.call_function('is_admin', []rt.PhpVal{})) {
			rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/class-custom-image-header.php', '4')
		var_custom_image_header = create_custom_image_header(var_args.array_get(rt.new_int(0)).array_get(rt.new_string('admin-head-callback')), var_args.array_get(rt.new_int(0)).array_get(rt.new_string('admin-preview-callback')))
		}
	}
	if rt.is_true(rt.new_bool(current_theme_supports('custom-background'))) {
		rt.new_bool(add_theme_support('custom-background', rt.create_array([rt.ArrayItem{ key: '__jit', val: true }])))
		var_args = rt.new_bool(get_theme_support('custom-background'))
		rt.call_function('add_action', [rt.new_string('wp_head'), var_args.array_get(rt.new_int(0)).array_get(rt.new_string('wp-head-callback'))])
		if rt.is_true(rt.call_function('is_admin', []rt.PhpVal{})) {
			rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/class-custom-background.php', '4')
		var_custom_background = create_custom_background(var_args.array_get(rt.new_int(0)).array_get(rt.new_string('admin-head-callback')), var_args.array_get(rt.new_int(0)).array_get(rt.new_string('admin-preview-callback')))
		}
	}
}

fn _custom_logo_header_styles() {
	mut var_classes := rt.new_null()
	if !(current_theme_supports('custom-header', 'header-text')) && get_theme_support('custom-logo', 'header-text') && rt.is_true(rt.new_bool(!(rt.is_true(get_theme_mod('header_text', true))))) {
		var_classes = rt.cast_array(rt.new_bool(get_theme_support('custom-logo', rt.new_string('header-text'))))
		var_classes = rt.call_function('array_map', [rt.new_string('sanitize_html_class'), var_classes.clone()])
		var_classes = rt.new_string('.' + (rt.call_function('implode', [rt.new_string(', .'), var_classes.clone()])).str())
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(var_classes)
		// unsupported statement: Stmt_InlineHTML
	}
}

fn get_theme_support(feature string, var_args_origin ...rt.PhpVal) bool {
	mut var_args := rt.create_array_from_list(var_args_origin)
	mut var_feature := feature
	mut var__wp_theme_features := rt.new_null()
	if !(var__wp_theme_features.array_isset(rt.new_string(feature))) {
		return false
	}
	if !(var_args.len > 0 && var_args != '0') {
		return (var__wp_theme_features.array_get(rt.new_string(feature))).to_bool()
	}
	mut switch_val_3 := rt.new_string(feature)
	if rt.is_true(rt.equal(switch_val_3, rt.new_string('custom-logo'))) || rt.is_true(rt.equal(switch_val_3, rt.new_string('custom-header'))) || rt.is_true(rt.equal(switch_val_3, rt.new_string('custom-background'))) {
		return (if !(var__wp_theme_features.array_get(rt.new_string(feature)).array_get(rt.new_int(0)).array_get(rt.new_string((var_args).str()).array_get(rt.new_int(0)))).is_null() { var__wp_theme_features.array_get(rt.new_string(feature)).array_get(rt.new_int(0)).array_get(rt.new_string((var_args).str()).array_get(rt.new_int(0))) } else { rt.new_bool(false) }).to_bool()
	} else {
		return (var__wp_theme_features.array_get(rt.new_string(feature))).to_bool()
	}
	return false
}

fn remove_theme_support(var_feature rt.PhpVal) bool {
	if rt.is_true(rt.call_function('in_array', [var_feature.clone(), rt.create_array([rt.ArrayItem{ key: none, val: 'editor-style' }, rt.ArrayItem{ key: none, val: 'widgets' }, rt.ArrayItem{ key: none, val: 'menus' }]), rt.new_bool(true)])) {
		return false
	}
	return _remove_theme_support(var_feature.clone())
}

fn _remove_theme_support(var_feature rt.PhpVal) bool {
	mut var__wp_theme_features := rt.new_null()
	mut var_GLOBALS := rt.new_null()
	mut var_support := rt.new_null()
	mut switch_val_4 := var_feature
	if rt.is_true(rt.equal(switch_val_4, rt.new_string('custom-header-uploads'))) {
		if !(var__wp_theme_features.array_isset(rt.new_string('custom-header'))) {
			return false
		}
		rt.new_bool(add_theme_support('custom-header', rt.create_array([rt.ArrayItem{ key: 'uploads', val: false }])))
		return true
	}
	if !(var__wp_theme_features.array_isset(var_feature)) {
		return false
	}
	mut switch_val_5 := var_feature
	if rt.is_true(rt.equal(switch_val_5, rt.new_string('custom-header'))) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('did_action', [rt.new_string('wp_loaded')]))))) {
		}
		var_support = rt.new_bool(get_theme_support('custom-header'))
		if var_support.array_get(rt.new_int(0)).array_isset(rt.new_string('wp-head-callback')) {
			rt.call_function('remove_action', [rt.new_string('wp_head'), var_support.array_get(rt.new_int(0)).array_get(rt.new_string('wp-head-callback'))])
		}
		if var_GLOBALS.array_isset(rt.new_string('custom_image_header')) {
			rt.call_function('remove_action', [rt.new_string('admin_menu'), rt.create_array([rt.ArrayItem{ key: none, val: var_GLOBALS.array_get(rt.new_string('custom_image_header')) }, rt.ArrayItem{ key: none, val: 'init' }])])
			var_GLOBALS.array_unset(rt.new_string('custom_image_header'))
		}
	} else if rt.is_true(rt.equal(switch_val_5, rt.new_string('custom-background'))) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('did_action', [rt.new_string('wp_loaded')]))))) {
		}
		var_support = rt.new_bool(get_theme_support('custom-background'))
		if var_support.array_get(rt.new_int(0)).array_isset(rt.new_string('wp-head-callback')) {
			rt.call_function('remove_action', [rt.new_string('wp_head'), var_support.array_get(rt.new_int(0)).array_get(rt.new_string('wp-head-callback'))])
		}
		rt.call_function('remove_action', [rt.new_string('admin_menu'), rt.create_array([rt.ArrayItem{ key: none, val: var_GLOBALS.array_get(rt.new_string('custom_background')) }, rt.ArrayItem{ key: none, val: 'init' }])])
		var_GLOBALS.array_unset(rt.new_string('custom_background'))
	}
	var__wp_theme_features.array_unset(var_feature)
	return true
}

fn current_theme_supports(feature string, var_args_origin ...rt.PhpVal) bool {
	mut var_args := rt.create_array_from_list(var_args_origin)
	mut var_feature := feature
	mut var__wp_theme_features := rt.new_null()
	mut var_content_type := rt.new_null()
	mut var_type := rt.new_null()
	if rt.is_true(rt.identical(rt.new_string('custom-header-uploads'), rt.new_string(feature))) {
		return current_theme_supports('custom-header', 'uploads')
	}
	if !(var__wp_theme_features.array_isset(rt.new_string(feature))) {
		return false
	}
	if !(var_args.len > 0 && var_args != '0') {
		return (rt.call_function('apply_filters', [rt.new_string("current_theme_supports-${var_feature}"), rt.new_bool(true), rt.new_string((var_args).str()).clone(), var__wp_theme_features.array_get(rt.new_string(feature))])).to_bool()
	}
	mut switch_val_6 := rt.new_string(feature)
	if rt.is_true(rt.equal(switch_val_6, rt.new_string('post-thumbnails'))) {
		if rt.is_true(rt.identical(rt.new_bool(true), var__wp_theme_features.array_get(rt.new_string(feature)))) {
			return true
		}
		var_content_type = rt.new_string((var_args).str()).array_get(rt.new_int(0))
		return (rt.call_function('in_array', [var_content_type.clone(), var__wp_theme_features.array_get(rt.new_string(feature)).array_get(rt.new_int(0)), rt.new_bool(true)])).to_bool()
	} else if rt.is_true(rt.equal(switch_val_6, rt.new_string('html5'))) || rt.is_true(rt.equal(switch_val_6, rt.new_string('post-formats'))) {
		var_type = rt.new_string((var_args).str()).array_get(rt.new_int(0))
		return (rt.call_function('in_array', [var_type.clone(), var__wp_theme_features.array_get(rt.new_string(feature)).array_get(rt.new_int(0)), rt.new_bool(true)])).to_bool()
	} else if rt.is_true(rt.equal(switch_val_6, rt.new_string('custom-logo'))) || rt.is_true(rt.equal(switch_val_6, rt.new_string('custom-header'))) || rt.is_true(rt.equal(switch_val_6, rt.new_string('custom-background'))) {
		return var__wp_theme_features.array_get(rt.new_string(feature)).array_get(rt.new_int(0)).array_isset(rt.new_string((var_args).str()).array_get(rt.new_int(0))) && rt.is_true(var__wp_theme_features.array_get(rt.new_string(feature)).array_get(rt.new_int(0)).array_get(rt.new_string((var_args).str()).array_get(rt.new_int(0))))
	}
	return (rt.call_function('apply_filters', [rt.new_string("current_theme_supports-${var_feature}"), rt.new_bool(true), rt.new_string((var_args).str()).clone(), var__wp_theme_features.array_get(rt.new_string(feature))])).to_bool()
	return false
}

fn require_if_theme_supports(var_feature rt.PhpVal, var_file rt.PhpVal) bool {
	if rt.is_true(rt.new_bool(current_theme_supports(var_feature.clone()))) {
		rt.include_file((var_file).to_string(), '3')
		return true
	}
	return false
}

fn register_theme_feature(feature string, var_args_arg rt.PhpVal) bool {
	mut var_feature := feature
	mut var_args := var_args_arg
	mut var__wp_registered_theme_features := rt.new_null()
	mut var_defaults := map[string]rt.PhpVal{}
	if !(var__wp_registered_theme_features.clone().is_array()) {
	var__wp_registered_theme_features = rt.new_array()
	}
	var_defaults = { 'type': rt.new_string('boolean'), 'variadic': rt.new_bool(false), 'description': rt.new_string(''), 'show_in_rest': rt.new_bool(false) }
	var_args = rt.call_function('wp_parse_args', [var_args.clone(), rt.create_array_from_native_map(var_defaults)])
	if rt.is_true(rt.identical(rt.new_bool(true), var_args.array_get(rt.new_string('show_in_rest')))) {
		var_args.array_set('show_in_rest', rt.new_array())
	}
	if rt.is_true(rt.new_bool(var_args.array_get(rt.new_string('show_in_rest')).is_array())) {
		var_args.array_set('show_in_rest', rt.call_function('wp_parse_args', [var_args.array_get(rt.new_string('show_in_rest')), rt.create_array([rt.ArrayItem{ key: 'schema', val: rt.new_array() }, rt.ArrayItem{ key: 'name', val: feature }, rt.ArrayItem{ key: 'prepare_callback', val: rt.new_null() }])]))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_args.array_get(rt.new_string('type')), rt.create_array([rt.ArrayItem{ key: none, val: 'string' }, rt.ArrayItem{ key: none, val: 'boolean' }, rt.ArrayItem{ key: none, val: 'integer' }, rt.ArrayItem{ key: none, val: 'number' }, rt.ArrayItem{ key: none, val: 'array' }, rt.ArrayItem{ key: none, val: 'object' }]), rt.new_bool(true)]))))) {
		return (create_wp_error(rt.new_string('invalid_type'), rt.call_function('__', [rt.new_string('The feature "type" is not valid JSON Schema type.')]))).to_bool()
	}
	if rt.is_true(rt.identical(rt.new_bool(true), var_args.array_get(rt.new_string('variadic')))) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('array'), var_args.array_get(rt.new_string('type')))))) {
		return (create_wp_error(rt.new_string('variadic_must_be_array'), rt.call_function('__', [rt.new_string('When registering a "variadic" theme feature, the "type" must be an "array".')]))).to_bool()
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_args.array_get(rt.new_string('show_in_rest')))))) && rt.is_true(rt.call_function('in_array', [var_args.array_get(rt.new_string('type')), rt.create_array([rt.ArrayItem{ key: none, val: 'array' }, rt.ArrayItem{ key: none, val: 'object' }]), rt.new_bool(true)])) {
		if !(var_args.array_get(rt.new_string('show_in_rest')).is_array()) || !rt.is_true(var_args.array_get(rt.new_string('show_in_rest')).array_get(rt.new_string('schema'))) {
			return (create_wp_error(rt.new_string('missing_schema'), rt.call_function('__', [rt.new_string('When registering an "array" or "object" feature to show in the REST API, the feature\'s schema must also be defined.')]))).to_bool()
		}
		if rt.is_true(rt.identical(rt.new_string('array'), var_args.array_get(rt.new_string('type')))) && !(var_args.array_get(rt.new_string('show_in_rest')).array_get(rt.new_string('schema')).array_isset(rt.new_string('items'))) {
			return (create_wp_error(rt.new_string('missing_schema_items'), rt.call_function('__', [rt.new_string('When registering an "array" feature, the feature\'s schema must include the "items" keyword.')]))).to_bool()
		}
		if rt.is_true(rt.identical(rt.new_string('object'), var_args.array_get(rt.new_string('type')))) && !(var_args.array_get(rt.new_string('show_in_rest')).array_get(rt.new_string('schema')).array_isset(rt.new_string('properties'))) {
			return (create_wp_error(rt.new_string('missing_schema_properties'), rt.call_function('__', [rt.new_string('When registering an "object" feature, the feature\'s schema must include the "properties" keyword.')]))).to_bool()
		}
	}
	if rt.is_true(rt.new_bool(var_args.array_get(rt.new_string('show_in_rest')).is_array())) {
		if var_args.array_get(rt.new_string('show_in_rest')).array_isset(rt.new_string('prepare_callback')) && !(rt.call_function('is_callable', [var_args.array_get(rt.new_string('show_in_rest')).array_get(rt.new_string('prepare_callback'))])) {
			return (create_wp_error(rt.new_string('invalid_rest_prepare_callback'), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('The "%s" must be a callable function.')]), rt.new_string('prepare_callback')]))).to_bool()
		}
		var_args.array_get_mut('show_in_rest').array_set('schema', rt.call_function('wp_parse_args', [var_args.array_get(rt.new_string('show_in_rest')).array_get(rt.new_string('schema')), rt.create_array([rt.ArrayItem{ key: 'description', val: var_args.array_get(rt.new_string('description')) }, rt.ArrayItem{ key: 'type', val: var_args.array_get(rt.new_string('type')) }, rt.ArrayItem{ key: 'default', val: false }])]))
		if var_args.array_get(rt.new_string('show_in_rest')).array_get(rt.new_string('schema')).array_get(rt.new_string('default')).is_bool() && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [rt.new_string('boolean'), rt.cast_array(var_args.array_get(rt.new_string('show_in_rest')).array_get(rt.new_string('schema')).array_get(rt.new_string('type'))), rt.new_bool(true)]))))) {
			var_args.array_get_mut('show_in_rest').array_get_mut('schema').array_set('type', rt.cast_array(var_args.array_get(rt.new_string('show_in_rest')).array_get(rt.new_string('schema')).array_get(rt.new_string('type'))))
			rt.call_function('array_unshift', [var_args.array_get(rt.new_string('show_in_rest')).array_get(rt.new_string('schema')).array_get(rt.new_string('type')), rt.new_string('boolean')])
		}
		var_args.array_get_mut('show_in_rest').array_set('schema', rt.call_function('rest_default_additional_properties_to_false', [var_args.array_get(rt.new_string('show_in_rest')).array_get(rt.new_string('schema'))]))
	}
	var__wp_registered_theme_features.array_set(feature, var_args.clone())
	return true
}

fn get_registered_theme_features() rt.PhpVal {
	mut var__wp_registered_theme_features := rt.new_null()
	if !(var__wp_registered_theme_features.clone().is_array()) {
		return rt.new_array()
	}
	return var__wp_registered_theme_features.clone()
}

fn get_registered_theme_feature(var_feature rt.PhpVal) rt.PhpVal {
	mut var__wp_registered_theme_features := rt.new_null()
	if !(var__wp_registered_theme_features.clone().is_array()) {
		return rt.new_null()
	}
	return if !(var__wp_registered_theme_features.array_get(var_feature)).is_null() { var__wp_registered_theme_features.array_get(var_feature) } else { rt.new_null() }
}

fn _delete_attachment_theme_mod(var_id rt.PhpVal) {
	mut var_attachment_image := rt.new_null()
	mut var_header_image := false
	mut var_background_image := rt.new_null()
	mut var_custom_logo_id := rt.new_null()
	mut var_site_logo_id := rt.new_null()
	var_attachment_image = rt.call_function('wp_get_attachment_url', [var_id.clone()])
	var_header_image = get_header_image()
	var_background_image = get_background_image()
	var_custom_logo_id = rt.new_int((get_theme_mod('custom_logo', false)).to_i64())
	var_site_logo_id = rt.new_int((rt.call_function('get_option', [rt.new_string('site_logo')])).to_i64())
	if rt.is_true(var_custom_logo_id) && rt.is_true(rt.identical(var_custom_logo_id, var_id)) {
		remove_theme_mod('custom_logo')
		remove_theme_mod('header_text')
	}
	if rt.is_true(var_site_logo_id) && rt.is_true(rt.identical(var_site_logo_id, var_id)) {
		rt.call_function('delete_option', [rt.new_string('site_logo')])
	}
	if var_header_image && rt.is_true(rt.identical(rt.new_bool(var_header_image), var_attachment_image)) {
		remove_theme_mod('header_image')
		remove_theme_mod('header_image_data')
	}
	if rt.is_true(var_background_image) && rt.is_true(rt.identical(var_background_image, var_attachment_image)) {
		remove_theme_mod('background_image')
	}
}

fn check_theme_switched() {
	mut var_stylesheet := rt.new_null()
	mut var_old_theme := rt.new_null()
	var_stylesheet = rt.call_function('get_option', [rt.new_string('theme_switched')])
	if rt.is_true(var_stylesheet) {
		var_old_theme = wp_get_theme(var_stylesheet.clone(), '')
		if rt.is_true(rt.call_function('get_option', [rt.new_string('theme_switched_via_customizer')])) {
			rt.call_function('remove_action', [rt.new_string('after_switch_theme'), rt.new_string('_wp_menus_changed')])
			rt.call_function('remove_action', [rt.new_string('after_switch_theme'), rt.new_string('_wp_sidebars_changed')])
			rt.call_function('update_option', [rt.new_string('theme_switched_via_customizer'), rt.new_bool(false)])
		}
		if rt.is_true(rt.call_method(var_old_theme, 'exists', []rt.PhpVal{})) {
			rt.call_function('do_action', [rt.new_string('after_switch_theme'), rt.call_method(var_old_theme, 'get', [rt.new_string('Name')]), var_old_theme.clone()])
		} else {
			rt.call_function('do_action', [rt.new_string('after_switch_theme'), var_stylesheet.clone(), var_old_theme.clone()])
		}
		rt.call_function('flush_rewrite_rules', []rt.PhpVal{})
		rt.call_function('update_option', [rt.new_string('theme_switched'), rt.new_bool(false)])
	}
}

fn _wp_customize_include() {
	mut var_GLOBALS := rt.new_null()
	mut var_is_customize_admin_page := false
	mut var_should_include := false
	mut var_keys := []rt.PhpVal{}
	mut var_input_vars := rt.new_null()
	mut var_theme := rt.new_null()
	mut var_autosaved := rt.new_null()
	mut var_messenger_channel := rt.new_null()
	mut var_changeset_uuid := rt.new_null()
	mut var_branching := false
	mut var_is_customize_save_action := false
	mut var_settings_previewed := false
	var_is_customize_admin_page = rt.is_true(rt.call_function('is_admin', []rt.PhpVal{})) && rt.is_true(rt.identical(rt.new_string('customize.php'), rt.call_function('basename', [rt.get_superglobal('_SERVER').array_get(rt.new_string('PHP_SELF'))])))
	var_should_include = var_is_customize_admin_page || (rt.get_superglobal('_REQUEST').array_isset(rt.new_string('wp_customize')) && rt.is_true(rt.identical(rt.new_string('on'), rt.get_superglobal('_REQUEST').array_get(rt.new_string('wp_customize'))))) || !(!rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('customize_changeset_uuid')))) || !(!rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('customize_changeset_uuid'))))
	if !(var_should_include) {
		return
	}
	var_keys = ['changeset_uuid', 'customize_changeset_uuid', 'customize_theme', 'theme', 'customize_messenger_channel', 'customize_autosaved']
	var_input_vars = rt.call_function('array_merge', [rt.call_function('wp_array_slice_assoc', [rt.get_superglobal('_GET').clone(), rt.create_array_from_list(var_keys)]), rt.call_function('wp_array_slice_assoc', [rt.get_superglobal('_POST').clone(), rt.create_array_from_list(var_keys)])])
	var_theme = rt.new_null()
	var_autosaved = rt.new_null()
	var_messenger_channel = rt.new_null()
	var_changeset_uuid = rt.new_bool(false)
	var_branching = false
	if var_is_customize_admin_page && var_input_vars.array_isset(rt.new_string('changeset_uuid')) {
	var_changeset_uuid = rt.call_function('sanitize_key', [var_input_vars.array_get(rt.new_string('changeset_uuid'))])
	} else if !(!rt.is_true(var_input_vars.array_get(rt.new_string('customize_changeset_uuid')))) {
	var_changeset_uuid = rt.call_function('sanitize_key', [var_input_vars.array_get(rt.new_string('customize_changeset_uuid'))])
	}
	if var_is_customize_admin_page && var_input_vars.array_isset(rt.new_string('theme')) {
	var_theme = var_input_vars.array_get(rt.new_string('theme'))
	} else if var_input_vars.array_isset(rt.new_string('customize_theme')) {
	var_theme = var_input_vars.array_get(rt.new_string('customize_theme'))
	}
	if !(!rt.is_true(var_input_vars.array_get(rt.new_string('customize_autosaved')))) {
	var_autosaved = rt.new_bool(true)
	}
	if var_input_vars.array_isset(rt.new_string('customize_messenger_channel')) {
	var_messenger_channel = rt.call_function('sanitize_key', [var_input_vars.array_get(rt.new_string('customize_messenger_channel'))])
	}
	var_is_customize_save_action = rt.is_true(rt.call_function('wp_doing_ajax', []rt.PhpVal{})) && rt.get_superglobal('_REQUEST').array_isset(rt.new_string('action')) && rt.is_true(rt.identical(rt.new_string('customize_save'), rt.call_function('wp_unslash', [rt.get_superglobal('_REQUEST').array_get(rt.new_string('action'))])))
	var_settings_previewed = !(var_is_customize_save_action)
	rt.include_file((rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/class-wp-customize-manager.php', '4')
	var_GLOBALS.array_set('wp_customize', create_wp_customize_manager(rt.call_function('compact', [rt.new_string('changeset_uuid'), rt.new_string('theme'), rt.new_string('messenger_channel'), rt.new_string('settings_previewed'), rt.new_string('autosaved'), rt.new_string('branching')])))
}

fn _wp_customize_publish_changeset(var_new_status rt.PhpVal, var_old_status rt.PhpVal, var_changeset_post rt.PhpVal) {
	mut var_is_publishing_changeset := false
	mut var_wp_customize := rt.new_null()
	var_is_publishing_changeset = rt.is_true(rt.identical(rt.new_string('customize_changeset'), rt.get_property(var_changeset_post, 'post_type'))) && rt.is_true(rt.identical(rt.new_string('publish'), var_new_status)) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('publish'), var_old_status))))
	if !(var_is_publishing_changeset) {
		return
	}
	if !rt.is_true(var_wp_customize) {
		rt.include_file((rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/class-wp-customize-manager.php', '4')
	var_wp_customize = create_wp_customize_manager(rt.create_array([rt.ArrayItem{ key: 'changeset_uuid', val: rt.get_property(var_changeset_post, 'post_name') }, rt.ArrayItem{ key: 'settings_previewed', val: false }]))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('did_action', [rt.new_string('customize_register')]))))) {
		rt.call_function('remove_action', [rt.new_string('customize_register'), rt.create_array([rt.ArrayItem{ key: none, val: var_wp_customize }, rt.ArrayItem{ key: none, val: 'register_controls' }])])
		var_wp_customize.register_controls()
		rt.call_function('do_action', [rt.new_string('customize_register'), var_wp_customize])
	}
	var_wp_customize._publish_changeset_values(rt.get_property(var_changeset_post, 'ID'))
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_revisions_enabled', [var_changeset_post.clone()]))))) {
		var_wp_customize.trash_changeset_post(rt.get_property(var_changeset_post, 'ID'))
	}
}

fn _wp_customize_changeset_filter_insert_post_data(var_post_data rt.PhpVal, var_supplied_post_data rt.PhpVal) rt.PhpVal {
	if var_post_data.array_isset(rt.new_string('post_type')) && rt.is_true(rt.identical(rt.new_string('customize_changeset'), var_post_data['post_type'])) {
		if !rt.is_true(var_post_data['post_name']) && !(!rt.is_true(var_supplied_post_data.array_get(rt.new_string('post_name')))) {
			var_post_data['post_name'] = var_supplied_post_data.array_get(rt.new_string('post_name'))
		}
	}
	return var_post_data.clone()
}

fn _wp_customize_loader_settings() {
	mut var_admin_origin := rt.new_null()
	mut var_home_origin := rt.new_null()
	mut var_cross_domain := rt.new_null()
	mut var_browser := map[string]rt.PhpVal{}
	mut var_settings := map[string]rt.PhpVal{}
	mut var_script := rt.new_null()
	mut var_wp_scripts := rt.new_null()
	mut var_data := rt.new_null()
	var_admin_origin = rt.call_function('parse_url', [rt.call_function('admin_url', []rt.PhpVal{})])
	var_home_origin = rt.call_function('parse_url', [rt.call_function('home_url', []rt.PhpVal{})])
	var_cross_domain = rt.new_bool(var_admin_origin.array_get(rt.new_string('host')).to_string().to_lower() != var_home_origin.array_get(rt.new_string('host')).to_string().to_lower())
	var_browser = { 'mobile': rt.call_function('wp_is_mobile', []rt.PhpVal{}), 'ios': rt.new_bool(rt.is_true(rt.call_function('wp_is_mobile', []rt.PhpVal{})) && rt.is_true(rt.call_function('preg_match', [rt.new_string('/iPad|iPod|iPhone/'), rt.get_superglobal('_SERVER').array_get(rt.new_string('HTTP_USER_AGENT'))]))) }
	var_settings = { 'url': rt.call_function('esc_url', [rt.call_function('admin_url', [rt.new_string('customize.php')])]), 'isCrossDomain': var_cross_domain, 'browser': var_browser, 'l10n': { 'saveAlert': rt.call_function('__', [rt.new_string('The changes you made will be lost if you navigate away from this page.')]), 'mainIframeTitle': rt.call_function('__', [rt.new_string('Customizer')]) } }
	var_script = rt.new_string('var _wpCustomizeLoaderSettings = ' + (rt.call_function('wp_json_encode', [rt.create_array_from_native_map(var_settings), rt.bitwise_or(rt.get_constant('JSON_HEX_TAG'), rt.get_constant('JSON_UNESCAPED_SLASHES'))])).str() + ';')
	var_wp_scripts = rt.call_function('wp_scripts', []rt.PhpVal{})
	var_data = rt.call_method(var_wp_scripts, 'get_data', [rt.new_string('customize-loader'), rt.new_string('data')])
	if rt.is_true(var_data) {
	var_script = rt.new_string("${var_data.to_string()}\n${var_script.to_string()}")
	}
	rt.call_method(var_wp_scripts, 'add_data', [rt.new_string('customize-loader'), rt.new_string('data'), var_script.clone()])
}

fn wp_customize_url(stylesheet string) rt.PhpVal {
	mut var_stylesheet := stylesheet
	mut var_url := rt.new_null()
	var_url = rt.call_function('admin_url', [rt.new_string('customize.php')])
	if var_stylesheet.len > 0 && var_stylesheet != '0' {
	var_url = rt.call_function('add_query_arg', [rt.new_string('theme'), rt.call_function('urlencode', [rt.new_string((var_stylesheet).str())]), var_url.clone()])
	}
	return rt.call_function('esc_url', [var_url.clone()])
}

fn wp_customize_support_script() {
	mut var_admin_origin := rt.new_null()
	mut var_home_origin := rt.new_null()
	mut var_cross_domain := rt.new_null()
	var_admin_origin = rt.call_function('parse_url', [rt.call_function('admin_url', []rt.PhpVal{})])
	var_home_origin = rt.call_function('parse_url', [rt.call_function('home_url', []rt.PhpVal{})])
	var_cross_domain = rt.new_bool(var_admin_origin.array_get(rt.new_string('host')).to_string().to_lower() != var_home_origin.array_get(rt.new_string('host')).to_string().to_lower())
	rt.call_function('ob_start', []rt.PhpVal{})
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(var_cross_domain) {
		// unsupported statement: Stmt_InlineHTML
	} else {
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('wp_print_inline_script_tag', [rt.new_string((rt.call_function('wp_remove_surrounding_empty_script_tags', [rt.call_function('ob_get_clean', []rt.PhpVal{})])).str() + '\n//# sourceURL=' + (rt.call_function('rawurlencode', [rt.new_string(@FN)])).str())])
}

fn is_customize_preview() bool {
	mut var_wp_customize := rt.new_null()
	return true && rt.is_true(var_wp_customize.is_preview())
}

fn _wp_keep_alive_customize_changeset_dependent_auto_drafts(var_new_status rt.PhpVal, var_old_status rt.PhpVal, var_post rt.PhpVal) {
	mut var_wpdb := rt.new_null()
	mut var_data := rt.new_null()
	mut var_post_id := rt.new_null()
	mut var_post_args := map[string]rt.PhpVal{}
	var_old_status = rt.new_null()
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('customize_changeset'), rt.get_property(var_post, 'post_type'))))) || rt.is_true(rt.identical(rt.new_string('publish'), var_new_status)) {
		return
	}
	var_data = rt.call_function('json_decode', [rt.get_property(var_post, 'post_content'), rt.new_bool(true)])
	if !rt.is_true(var_data.array_get(rt.new_string('nav_menus_created_posts')).array_get(rt.new_string('value'))) {
		return
	}
	if rt.is_true(rt.identical(rt.new_string('trash'), var_new_status)) {
		mut iter_23 := var_data.array_get(rt.new_string('nav_menus_created_posts')).array_get(rt.new_string('value')).iterator()
		for {
			item_23 := iter_23.next() or { break }
			mut var_post_id_shadow := item_23.val
			if !(!rt.is_true(var_post_id_shadow)) && rt.is_true(rt.identical(rt.new_string('draft'), rt.call_function('get_post_status', [var_post_id_shadow.clone()]))) {
				rt.call_function('wp_trash_post', [var_post_id_shadow.clone()])
			}
		}
		return
	}
	var_post_args = rt.new_array()
	if rt.is_true(rt.identical(rt.new_string('auto-draft'), var_new_status)) {
		var_post_args['post_date'] = rt.get_property(var_post, 'post_date')
	} else {
		var_post_args['post_status'] = rt.new_string('draft')
	}
	mut iter_24 := var_data.array_get(rt.new_string('nav_menus_created_posts')).array_get(rt.new_string('value')).iterator()
	for {
		item_24 := iter_24.next() or { break }
		mut var_post_id_shadow := item_24.val
		if !rt.is_true(var_post_id_shadow) || rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('auto-draft'), rt.call_function('get_post_status', [var_post_id_shadow.clone()]))))) {
			continue
		}
		rt.call_method(var_wpdb, 'update', [rt.get_property(var_wpdb, 'posts'), rt.create_array_from_native_map(var_post_args), rt.create_array([rt.ArrayItem{ key: 'ID', val: var_post_id_shadow }])])
		rt.call_function('clean_post_cache', [var_post_id_shadow.clone()])
	}
}

fn create_initial_theme_features() {
	rt.new_bool(register_theme_feature('align-wide', rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Whether theme opts in to wide alignment CSS class.')]) }, rt.ArrayItem{ key: 'show_in_rest', val: true }])))
	rt.new_bool(register_theme_feature('automatic-feed-links', rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Whether posts and comments RSS feed links are added to head.')]) }, rt.ArrayItem{ key: 'show_in_rest', val: true }])))
	rt.new_bool(register_theme_feature('block-templates', rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Whether a theme uses block-based templates.')]) }, rt.ArrayItem{ key: 'show_in_rest', val: true }])))
	rt.new_bool(register_theme_feature('block-template-parts', rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Whether a theme uses block-based template parts.')]) }, rt.ArrayItem{ key: 'show_in_rest', val: true }])))
	rt.new_bool(register_theme_feature('custom-background', rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Custom background if defined by the theme.')]) }, rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'show_in_rest', val: rt.create_array([rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: 'default-image', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'format', val: 'uri' }]) }, rt.ArrayItem{ key: 'default-preset', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'enum', val: rt.create_array([rt.ArrayItem{ key: none, val: 'default' }, rt.ArrayItem{ key: none, val: 'fill' }, rt.ArrayItem{ key: none, val: 'fit' }, rt.ArrayItem{ key: none, val: 'repeat' }, rt.ArrayItem{ key: none, val: 'custom' }]) }]) }, rt.ArrayItem{ key: 'default-position-x', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'enum', val: rt.create_array([rt.ArrayItem{ key: none, val: 'left' }, rt.ArrayItem{ key: none, val: 'center' }, rt.ArrayItem{ key: none, val: 'right' }]) }]) }, rt.ArrayItem{ key: 'default-position-y', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'enum', val: rt.create_array([rt.ArrayItem{ key: none, val: 'left' }, rt.ArrayItem{ key: none, val: 'center' }, rt.ArrayItem{ key: none, val: 'right' }]) }]) }, rt.ArrayItem{ key: 'default-size', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'enum', val: rt.create_array([rt.ArrayItem{ key: none, val: 'auto' }, rt.ArrayItem{ key: none, val: 'contain' }, rt.ArrayItem{ key: none, val: 'cover' }]) }]) }, rt.ArrayItem{ key: 'default-repeat', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'enum', val: rt.create_array([rt.ArrayItem{ key: none, val: 'repeat-x' }, rt.ArrayItem{ key: none, val: 'repeat-y' }, rt.ArrayItem{ key: none, val: 'repeat' }, rt.ArrayItem{ key: none, val: 'no-repeat' }]) }]) }, rt.ArrayItem{ key: 'default-attachment', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'enum', val: rt.create_array([rt.ArrayItem{ key: none, val: 'scroll' }, rt.ArrayItem{ key: none, val: 'fixed' }]) }]) }, rt.ArrayItem{ key: 'default-color', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }]) }]) }]) }]) }])))
	rt.new_bool(register_theme_feature('custom-header', rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Custom header if defined by the theme.')]) }, rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'show_in_rest', val: rt.create_array([rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: 'default-image', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'format', val: 'uri' }]) }, rt.ArrayItem{ key: 'random-default', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'boolean' }]) }, rt.ArrayItem{ key: 'width', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'integer' }]) }, rt.ArrayItem{ key: 'height', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'integer' }]) }, rt.ArrayItem{ key: 'flex-height', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'boolean' }]) }, rt.ArrayItem{ key: 'flex-width', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'boolean' }]) }, rt.ArrayItem{ key: 'default-text-color', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }]) }, rt.ArrayItem{ key: 'header-text', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'boolean' }]) }, rt.ArrayItem{ key: 'uploads', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'boolean' }]) }, rt.ArrayItem{ key: 'video', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'boolean' }]) }]) }]) }]) }])))
	rt.new_bool(register_theme_feature('custom-logo', rt.create_array([rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Custom logo if defined by the theme.')]) }, rt.ArrayItem{ key: 'show_in_rest', val: rt.create_array([rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: 'width', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'integer' }]) }, rt.ArrayItem{ key: 'height', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'integer' }]) }, rt.ArrayItem{ key: 'flex-width', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'boolean' }]) }, rt.ArrayItem{ key: 'flex-height', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'boolean' }]) }, rt.ArrayItem{ key: 'header-text', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'array' }, rt.ArrayItem{ key: 'items', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }]) }]) }, rt.ArrayItem{ key: 'unlink-homepage-logo', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'boolean' }]) }]) }]) }]) }])))
	rt.new_bool(register_theme_feature('customize-selective-refresh-widgets', rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Whether the theme enables Selective Refresh for Widgets being managed with the Customizer.')]) }, rt.ArrayItem{ key: 'show_in_rest', val: true }])))
	rt.new_bool(register_theme_feature('dark-editor-style', rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Whether theme opts in to the dark editor style UI.')]) }, rt.ArrayItem{ key: 'show_in_rest', val: true }])))
	rt.new_bool(register_theme_feature('disable-custom-colors', rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Whether the theme disables custom colors.')]) }, rt.ArrayItem{ key: 'show_in_rest', val: true }])))
	rt.new_bool(register_theme_feature('disable-custom-font-sizes', rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Whether the theme disables custom font sizes.')]) }, rt.ArrayItem{ key: 'show_in_rest', val: true }])))
	rt.new_bool(register_theme_feature('disable-custom-gradients', rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Whether the theme disables custom gradients.')]) }, rt.ArrayItem{ key: 'show_in_rest', val: true }])))
	rt.new_bool(register_theme_feature('disable-layout-styles', rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Whether the theme disables generated layout styles.')]) }, rt.ArrayItem{ key: 'show_in_rest', val: true }])))
	rt.new_bool(register_theme_feature('editor-color-palette', rt.create_array([rt.ArrayItem{ key: 'type', val: 'array' }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Custom color palette if defined by the theme.')]) }, rt.ArrayItem{ key: 'show_in_rest', val: rt.create_array([rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: 'items', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: 'name', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }]) }, rt.ArrayItem{ key: 'slug', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }]) }, rt.ArrayItem{ key: 'color', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }]) }]) }]) }]) }]) }])))
	rt.new_bool(register_theme_feature('editor-font-sizes', rt.create_array([rt.ArrayItem{ key: 'type', val: 'array' }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Custom font sizes if defined by the theme.')]) }, rt.ArrayItem{ key: 'show_in_rest', val: rt.create_array([rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: 'items', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: 'name', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }]) }, rt.ArrayItem{ key: 'size', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'number' }]) }, rt.ArrayItem{ key: 'slug', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }]) }]) }]) }]) }]) }])))
	rt.new_bool(register_theme_feature('editor-gradient-presets', rt.create_array([rt.ArrayItem{ key: 'type', val: 'array' }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Custom gradient presets if defined by the theme.')]) }, rt.ArrayItem{ key: 'show_in_rest', val: rt.create_array([rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: 'items', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: 'name', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }]) }, rt.ArrayItem{ key: 'gradient', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }]) }, rt.ArrayItem{ key: 'slug', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }]) }]) }]) }]) }]) }])))
	rt.new_bool(register_theme_feature('editor-spacing-sizes', rt.create_array([rt.ArrayItem{ key: 'type', val: 'array' }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Custom spacing sizes if defined by the theme.')]) }, rt.ArrayItem{ key: 'show_in_rest', val: rt.create_array([rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: 'items', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: 'name', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }]) }, rt.ArrayItem{ key: 'size', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }]) }, rt.ArrayItem{ key: 'slug', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }]) }]) }]) }]) }]) }])))
	rt.new_bool(register_theme_feature('editor-styles', rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Whether theme opts in to the editor styles CSS wrapper.')]) }, rt.ArrayItem{ key: 'show_in_rest', val: true }])))
	rt.new_bool(register_theme_feature('html5', rt.create_array([rt.ArrayItem{ key: 'type', val: 'array' }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Allows use of HTML5 markup for search forms, comment forms, comment lists, gallery, and caption.')]) }, rt.ArrayItem{ key: 'show_in_rest', val: rt.create_array([rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: 'items', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'enum', val: rt.create_array([rt.ArrayItem{ key: none, val: 'search-form' }, rt.ArrayItem{ key: none, val: 'comment-form' }, rt.ArrayItem{ key: none, val: 'comment-list' }, rt.ArrayItem{ key: none, val: 'gallery' }, rt.ArrayItem{ key: none, val: 'caption' }, rt.ArrayItem{ key: none, val: 'script' }, rt.ArrayItem{ key: none, val: 'style' }]) }]) }]) }]) }])))
	closure_6_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_formats := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		var_formats = if var_formats.clone().is_array() { rt.call_function('array_values', [var_formats.array_get(rt.new_int(0))]) } else { rt.new_array() }
		var_formats = rt.call_function('array_merge', [rt.create_array([rt.ArrayItem{ key: none, val: 'standard' }]), var_formats.clone()])
		return
		}
	rt.new_bool(register_theme_feature('post-formats', rt.create_array([rt.ArrayItem{ key: 'type', val: 'array' }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Post formats supported.')]) }, rt.ArrayItem{ key: 'show_in_rest', val: rt.create_array([rt.ArrayItem{ key: 'name', val: 'formats' }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: 'items', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'enum', val: rt.call_function('get_post_format_slugs', []rt.PhpVal{}) }]) }, rt.ArrayItem{ key: 'default', val: rt.create_array([rt.ArrayItem{ key: none, val: 'standard' }]) }]) }, rt.ArrayItem{ key: 'prepare_callback', val: rt.new_closure(closure_6_fn) }]) }])))
	rt.new_bool(register_theme_feature('post-thumbnails', rt.create_array([rt.ArrayItem{ key: 'type', val: 'array' }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('The post types that support thumbnails or true if all post types are supported.')]) }, rt.ArrayItem{ key: 'show_in_rest', val: rt.create_array([rt.ArrayItem{ key: 'type', val: rt.create_array([rt.ArrayItem{ key: none, val: 'boolean' }, rt.ArrayItem{ key: none, val: 'array' }]) }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: 'items', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }]) }]) }]) }])))
	rt.new_bool(register_theme_feature('responsive-embeds', rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Whether the theme supports responsive embedded content.')]) }, rt.ArrayItem{ key: 'show_in_rest', val: true }])))
	rt.new_bool(register_theme_feature('title-tag', rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Whether the theme can manage the document title tag.')]) }, rt.ArrayItem{ key: 'show_in_rest', val: true }])))
	rt.new_bool(register_theme_feature('wp-block-styles', rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Whether theme opts in to default WordPress block styles for viewing.')]) }, rt.ArrayItem{ key: 'show_in_rest', val: true }])))
}

fn wp_is_block_theme() bool {
	mut var_GLOBALS := rt.new_null()
	if !rt.is_true(var_GLOBALS.array_get(rt.new_string('wp_theme_directories'))) {
		rt.call_function('_doing_it_wrong', [rt.new_string(@FN), rt.call_function('__', [rt.new_string('This function should not be called before the theme directory is registered.')]), rt.new_string('6.8.0')])
		return false
	}
	return (rt.call_method(wp_get_theme('', ''), 'is_block_theme', []rt.PhpVal{})).to_bool()
}

fn wp_theme_get_element_class_name(var_element rt.PhpVal) rt.PhpVal {
	mut iife_temp_6 := Class_WP_Theme_JSON{}
	mut iife_result_6 := iife_temp_6.get_element_class_name(var_element.clone())
	return iife_result_6
}

fn _add_default_theme_supports() {
	if !(wp_is_block_theme()) {
		return
	}
	rt.new_bool(add_theme_support('post-thumbnails'))
	rt.new_bool(add_theme_support('responsive-embeds'))
	rt.new_bool(add_theme_support('editor-styles'))
	rt.new_bool(add_theme_support('html5', rt.create_array([rt.ArrayItem{ key: none, val: 'comment-form' }, rt.ArrayItem{ key: none, val: 'comment-list' }, rt.ArrayItem{ key: none, val: 'search-form' }, rt.ArrayItem{ key: none, val: 'gallery' }, rt.ArrayItem{ key: none, val: 'caption' }, rt.ArrayItem{ key: none, val: 'style' }, rt.ArrayItem{ key: none, val: 'script' }])))
	rt.new_bool(add_theme_support('automatic-feed-links'))
	rt.call_function('add_filter', [rt.new_string('should_load_separate_core_block_assets'), rt.new_string('__return_true')])
	rt.call_function('add_filter', [rt.new_string('should_load_block_assets_on_demand'), rt.new_string('__return_true')])
	closure_8_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_active := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_panel := if args.len > 1 { args[1].clone() } else { rt.new_null() }
		if rt.is_true(rt.identical(rt.new_string('nav_menus'), rt.get_property(var_panel, 'id'))) && !(current_theme_supports('menus')) && !(current_theme_supports('widgets')) {
		var_active = rt.new_bool(false)
		}
		return
		}
	rt.call_function('add_filter', [rt.new_string('customize_panel_active'), rt.new_closure(closure_8_fn), rt.new_int(10), rt.new_int(2)])
}

struct Class_WP_Theme {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

struct Class_stdClass {
	rt.PhpObjectBase
}

struct Class_WP_HTML_Tag_Processor {
	rt.PhpObjectBase
}

struct Class_WP_Query {
	rt.PhpObjectBase
}

struct Class_Custom_Image_Header {
	rt.PhpObjectBase
}

struct Class_Custom_Background {
	rt.PhpObjectBase
}

struct Class_WP_Customize_Manager {
	rt.PhpObjectBase
}

struct Class_WP_Theme_JSON {
	rt.PhpObjectBase
}

fn create_wp_theme(_args ...rt.PhpVal) &Class_WP_Theme {
	mut obj := &Class_WP_Theme{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_error(_args ...rt.PhpVal) &Class_WP_Error {
	mut obj := &Class_WP_Error{
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

fn create_wp_html_tag_processor(_args ...rt.PhpVal) &Class_WP_HTML_Tag_Processor {
	mut obj := &Class_WP_HTML_Tag_Processor{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_query(_args ...rt.PhpVal) &Class_WP_Query {
	mut obj := &Class_WP_Query{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_custom_image_header(_args ...rt.PhpVal) &Class_Custom_Image_Header {
	mut obj := &Class_Custom_Image_Header{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_custom_background(_args ...rt.PhpVal) &Class_Custom_Background {
	mut obj := &Class_Custom_Background{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_customize_manager(_args ...rt.PhpVal) &Class_WP_Customize_Manager {
	mut obj := &Class_WP_Customize_Manager{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_theme_json(_args ...rt.PhpVal) &Class_WP_Theme_JSON {
	mut obj := &Class_WP_Theme_JSON{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Theme) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Theme) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Theme) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
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


fn (mut this Class_stdClass) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_stdClass) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_stdClass) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_HTML_Tag_Processor) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_HTML_Tag_Processor) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_HTML_Tag_Processor) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_Query) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Query) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Query) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Custom_Image_Header) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Custom_Image_Header) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Custom_Image_Header) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Custom_Background) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Custom_Background) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Custom_Background) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_Customize_Manager) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Customize_Manager) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Customize_Manager) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_Theme_JSON) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Theme_JSON) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Theme_JSON) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}



fn main() {
	defer {
		rt.shutdown()
	}

}
