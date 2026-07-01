import rt

fn wp_get_themes(var_args rt.PhpVal) rt.PhpVal {
	mut var_wp_theme_directories := rt.new_null()
	mut var__themes := map[string]rt.PhpVal{}
	// unsupported statement: Stmt_Global
	mut var_defaults := { 'errors': rt.new_bool(false), 'allowed': rt.new_null(), 'blog_id': rt.new_int(0) }
	var_args = rt.call_function('wp_parse_args', [var_args.dup(), var_defaults.dup()])
	mut var_theme_directories := rt.new_bool(rt.new_bool(search_theme_directories(false)))
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_wp_theme_directories.dup().is_array())) && var_wp_theme_directories.dup().array_count() > 1)) {
		mut var_current_theme := get_stylesheet()
		if var_theme_directories.array_isset(var_current_theme) {
			mut var_root_of_current_theme := rt.new_string(rt.new_string(get_raw_theme_root(var_current_theme.dup(), false)))
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_root_of_current_theme.dup(), var_wp_theme_directories.dup(), rt.new_bool(true)]))))) {
				var_root_of_current_theme = rt.new_string(rt.concat(rt.get_constant('WP_CONTENT_DIR'), var_root_of_current_theme))
			}
			var_theme_directories.array_get_mut(var_current_theme).array_set('theme_root', var_root_of_current_theme.dup())
		}
	}
	if !rt.is_true(var_theme_directories) {
		return rt.new_array()
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		mut var_allowed := var_args.array_get('allowed')
		if rt.is_true(rt.identical(rt.new_string('network'), var_allowed)) {
			var_theme_directories = rt.call_function('array_intersect_key', [var_theme_directories.dup(), fn () rt.PhpVal { mut temp := Class_WP_Theme{}; return temp.get_allowed_on_network() }()])
		} else if rt.is_true(rt.identical(rt.new_string('site'), var_allowed)) {
			var_theme_directories = rt.call_function('array_intersect_key', [var_theme_directories.dup(), fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WP_Theme{}; return temp.get_allowed_on_site(arg_0) }(var_args.array_get('blog_id'))])
		} else if rt.is_true(var_allowed) {
			var_theme_directories = rt.call_function('array_intersect_key', [var_theme_directories.dup(), fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WP_Theme{}; return temp.get_allowed(arg_0) }(var_args.array_get('blog_id'))])
		} else {
			var_theme_directories = rt.call_function('array_diff_key', [var_theme_directories.dup(), fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WP_Theme{}; return temp.get_allowed(arg_0) }(var_args.array_get('blog_id'))])
		}
	}
	mut var_themes := rt.new_array()
	// unsupported statement: Stmt_Static
	{
		mut iter_1 := var_theme_directories.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_theme_root := item_1.val
			mut var_theme := item_1.key
			if var__themes.array_isset((var_theme_root.array_get('theme_root')).str() + '/' + (var_theme).str()) {
				var_themes.array_set(var_theme, var__themes.array_get((var_theme_root.array_get('theme_root')).str() + '/' + (var_theme).str()))
			} else {
				var_themes.array_set(var_theme, create_wp_theme(var_theme.dup(), var_theme_root.array_get('theme_root')))
				var__themes[(var_theme_root.array_get('theme_root')).str() + '/' + (var_theme).str()] = var_themes.array_get(var_theme)
			}
		}
	}
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		{
			mut iter_1 := var_themes.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_wp_theme := item_1.val
				mut var_theme := item_1.key
				if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
					var_themes.array_unset(var_theme)
				}
			}
		}
	}
	return var_themes.dup()
}

fn wp_get_theme(stylesheet string, theme_root string) rt.PhpVal {
	mut var_wp_theme_directories := rt.new_null()
	// unsupported statement: Stmt_Global
	if stylesheet == '' {
		stylesheet = (get_stylesheet()).str()
	}
	if theme_root == '' {
		theme_root = get_raw_theme_root(stylesheet)
		if rt.is_true(rt.identical(rt.new_bool(false), rt.new_string(theme_root))) {
			theme_root = (rt.get_constant('WP_CONTENT_DIR')).str() + '/themes'
		} else if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [rt.new_string(theme_root), rt.cast_array(var_wp_theme_directories), rt.new_bool(true)]))))) {
			theme_root = (rt.get_constant('WP_CONTENT_DIR')).str() + theme_root
		}
	}
	return create_wp_theme(rt.new_string(stylesheet).dup(), rt.new_string(theme_root).dup())
}

fn wp_clean_themes_cache(clear_update_cache bool) {
	if var_clear_update_cache {
		rt.call_function('delete_site_transient', [rt.new_string('update_themes')])
	}
	rt.new_bool(search_theme_directories(true))
	{
		mut iter_1 := wp_get_themes(rt.create_array([rt.ArrayItem{ key: 'errors', val: rt.new_null() }])).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_theme := item_1.val
			rt.call_method(var_theme, 'cache_delete', []rt.PhpVal{})
		}
	}
}

fn is_child_theme() rt.PhpVal {
	mut var_wp_stylesheet_path := rt.new_null()
	mut var_wp_template_path := rt.new_null()
	// unsupported statement: Stmt_Global
	return // unsupported expression: Expr_BinaryOp_NotIdentical
}

fn get_stylesheet() rt.PhpVal {
	return rt.call_function('apply_filters', [rt.new_string('stylesheet'), rt.call_function('get_option', [rt.new_string('stylesheet')])])
}

fn get_stylesheet_directory() rt.PhpVal {
	mut var_stylesheet := get_stylesheet()
	mut var_theme_root := get_theme_root(var_stylesheet.dup())
	mut var_stylesheet_dir := "${var_theme_root.to_string()}/${var_stylesheet.to_string()}"
	return rt.call_function('apply_filters', [rt.new_string('stylesheet_directory'), rt.new_string(var_stylesheet_dir).dup(), var_stylesheet.dup(), var_theme_root.dup()])
}

fn get_stylesheet_directory_uri() rt.PhpVal {
	mut var_stylesheet := rt.call_function('str_replace', [rt.new_string('%2F'), rt.new_string('/'), rt.call_function('rawurlencode', [get_stylesheet()])])
	mut var_theme_root_uri := get_theme_root_uri(var_stylesheet.dup(), '')
	mut var_stylesheet_dir_uri := "${var_theme_root_uri.to_string()}/${var_stylesheet.to_string()}"
	return rt.call_function('apply_filters', [rt.new_string('stylesheet_directory_uri'), rt.new_string(var_stylesheet_dir_uri).dup(), var_stylesheet.dup(), var_theme_root_uri.dup()])
}

fn get_stylesheet_uri() rt.PhpVal {
	mut var_stylesheet_dir_uri := get_stylesheet_directory_uri()
	mut var_stylesheet_uri := rt.new_string((var_stylesheet_dir_uri).str() + '/style.css')
	return rt.call_function('apply_filters', [rt.new_string('stylesheet_uri'), var_stylesheet_uri.dup(), var_stylesheet_dir_uri.dup()])
}

fn get_locale_stylesheet_uri() rt.PhpVal {
	mut var_wp_locale := rt.new_null()
	// unsupported statement: Stmt_Global
	mut var_stylesheet_dir_uri := get_stylesheet_directory_uri()
	mut var_dir := get_stylesheet_directory()
	mut var_locale := rt.call_function('get_locale', []rt.PhpVal{})
	if rt.is_true(rt.call_function('file_exists', [rt.new_string("${var_dir.to_string()}/${var_locale.to_string()}.css")])) {
		mut var_stylesheet_uri := "${var_stylesheet_dir_uri.to_string()}/${var_locale.to_string()}.css"
	} else if rt.is_true(rt.new_bool(!(!rt.is_true(rt.get_property(var_wp_locale, 'text_direction'))) && rt.is_true(rt.call_function('file_exists', [rt.concat(rt.concat(rt.concat(var_dir, rt.new_string('/')), rt.get_property(var_wp_locale, 'text_direction')), rt.new_string('.css'))])))) {
		var_stylesheet_uri = rt.concat(rt.concat(rt.concat(var_stylesheet_dir_uri, rt.new_string('/')), rt.get_property(var_wp_locale, 'text_direction')), rt.new_string('.css'))
	} else {
		var_stylesheet_uri = ''
	}
	return rt.call_function('apply_filters', [rt.new_string('locale_stylesheet_uri'), rt.new_string(var_stylesheet_uri).dup(), var_stylesheet_dir_uri.dup()])
}

fn get_template() rt.PhpVal {
	return rt.call_function('apply_filters', [rt.new_string('template'), rt.call_function('get_option', [rt.new_string('template')])])
}

fn get_template_directory() rt.PhpVal {
	mut var_template := get_template()
	mut var_theme_root := get_theme_root(var_template.dup())
	mut var_template_dir := "${var_theme_root.to_string()}/${var_template.to_string()}"
	return rt.call_function('apply_filters', [rt.new_string('template_directory'), rt.new_string(var_template_dir).dup(), var_template.dup(), var_theme_root.dup()])
}

fn get_template_directory_uri() rt.PhpVal {
	mut var_template := rt.call_function('str_replace', [rt.new_string('%2F'), rt.new_string('/'), rt.call_function('rawurlencode', [get_template()])])
	mut var_theme_root_uri := get_theme_root_uri(var_template.dup(), '')
	mut var_template_dir_uri := "${var_theme_root_uri.to_string()}/${var_template.to_string()}"
	return rt.call_function('apply_filters', [rt.new_string('template_directory_uri'), rt.new_string(var_template_dir_uri).dup(), var_template.dup(), var_theme_root_uri.dup()])
}

fn get_theme_roots() string {
	mut var_wp_theme_directories := rt.new_null()
	// unsupported statement: Stmt_Global
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_wp_theme_directories.dup().is_array()))))) || var_wp_theme_directories.dup().array_count() <= 1)) {
		return '/themes'
	}
	mut var_theme_roots := rt.call_function('get_site_transient', [rt.new_string('theme_roots')])
	if rt.is_true(rt.identical(rt.new_bool(false), var_theme_roots)) {
		rt.new_bool(search_theme_directories(true))
		var_theme_roots = rt.call_function('get_site_transient', [rt.new_string('theme_roots')])
	}
	return (var_theme_roots).str()
}

fn register_theme_directory(var_directory rt.PhpVal) bool {
	// unsupported statement: Stmt_Global
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('file_exists', [var_directory.dup()]))))) {
		var_directory = rt.new_string((rt.get_constant('WP_CONTENT_DIR')).str() + '/' + (var_directory).str())
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('file_exists', [var_directory.dup()]))))) {
			return false
		}
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_wp_theme_directories.dup().is_array()))))) {
		mut var_wp_theme_directories := rt.new_array()
	}
	mut var_untrailed := rt.call_function('untrailingslashit', [var_directory.dup()])
	if rt.is_true(rt.new_bool(!(!rt.is_true(var_untrailed)) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_untrailed.dup(), var_wp_theme_directories.dup(), rt.new_bool(true)]))))))) {
		var_wp_theme_directories.array_push(var_untrailed.dup())
	}
	return true
}

fn search_theme_directories(force bool) bool {
	// unsupported statement: Stmt_Global
	// unsupported statement: Stmt_Static
	if !rt.is_true(var_wp_theme_directories) {
		return false
	}
	if !(var_force) && !(var_found_themes).is_null() {
		return (var_found_themes).to_bool()
	}
	mut var_found_themes := rt.new_array()
	mut var_wp_theme_directories := rt.cast_array()
	mut var_relative_theme_roots := 
	{
		mut iter_1 := .iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_theme_root := item_1.val
		}
	}
}

struct Class_WP_Theme {
	rt.PhpObjectBase
}

fn create_wp_theme() &Class_WP_Theme {
	mut obj := &Class_WP_Theme{
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




pub fn init_wp_includes_theme_php() {
}
