import rt

struct Class_WC_WCCOM_Site_Installer {
	rt.PhpObjectBase
pub mut:
		wp_upgrader rt.PhpVal = rt.new_null()
}

fn Class_WC_WCCOM_Site_Installer.get_wporg_plugin_main_file(var_dir rt.PhpVal) bool {
	mut var_dir_mutated := var_dir
	var_dir_mutated = rt.call_function('trailingslashit', [var_dir_mutated.dup()])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('get_plugins')]))))) {
		rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/plugin.php', '4')
	}
	mut var_plugins := rt.call_function('get_plugins', []rt.PhpVal{})
	{
		mut iter_1 := var_plugins.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_plugin := item_1.val
			mut var_path := item_1.key
			if rt.is_true(rt.identical(rt.new_int(0), rt.call_function('strpos', [var_path.dup(), var_dir_mutated.dup()]))) {
				return (var_path).to_bool()
			}
		}
	}
	return false
}

fn Class_WC_WCCOM_Site_Installer.get_plugin_info(var_dir rt.PhpVal) rt.PhpVal {
	mut var_dir_mutated := var_dir
	mut var_plugin_folder := rt.call_function('basename', [var_dir_mutated.dup()])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('get_plugins')]))))) {
		rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/plugin.php', '4')
	}
	mut var_plugins := rt.call_function('get_plugins', []rt.PhpVal{})
	closure_1_fn := fn [var_plugin_folder] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_key := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return rt.identical(rt.call_function('strpos', [var_key.dup(), (var_plugin_folder).str() + '/']), rt.new_int(0))
	}
	mut var_related_plugins := rt.call_function('array_filter', [var_plugins.dup(), rt.new_closure(closure_1_fn), rt.get_constant('ARRAY_FILTER_USE_KEY')])
	if 1 == var_related_plugins.dup().array_count() {
		mut var_plugin_key := rt.func_array_keys(var_related_plugins.dup()).array_get(0)
		mut var_plugin_data := var_plugins.array_get(var_plugin_key)
		return rt.create_array([rt.ArrayItem{ key: 'name', val: var_plugin_data.array_get('Name') }, rt.ArrayItem{ key: 'version', val: var_plugin_data.array_get('Version') }, rt.ArrayItem{ key: 'active', val: rt.call_function('is_plugin_active', [var_plugin_key.dup()]) }])
	}
	return rt.new_bool(false)
}

fn Class_WC_WCCOM_Site_Installer.get_wp_upgrader() rt.PhpVal {
	if !(!rt.is_true(// unsupported expression: Expr_StaticPropertyFetch)) {
		return // unsupported expression: Expr_StaticPropertyFetch
	}
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/file.php', '4')
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/plugin-install.php', '4')
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/class-wp-upgrader.php', '4')
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/plugin.php', '4')
	rt.call_function('WP_Filesystem', []rt.PhpVal{})
	// unsupported assign target: Expr_StaticPropertyFetch
	rt.call_method(// unsupported expression: Expr_StaticPropertyFetch, 'init', []rt.PhpVal{})
	rt.call_function('wp_clean_plugins_cache', []rt.PhpVal{})
	return // unsupported expression: Expr_StaticPropertyFetch
}

fn create_wc_wccom_site_installer() &Class_WC_WCCOM_Site_Installer {
	mut obj := &Class_WC_WCCOM_Site_Installer{
		PhpObjectBase: rt.PhpObjectBase{}
		wp_upgrader: rt.new_null()
	}
	return obj
}

fn (mut this Class_WC_WCCOM_Site_Installer) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_wporg_plugin_main_file' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(Class_WC_WCCOM_Site_Installer.get_wporg_plugin_main_file(dispatch_arg_0))
		}
		'get_plugin_info' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WC_WCCOM_Site_Installer.get_plugin_info(dispatch_arg_0)
		}
		'get_wp_upgrader' {
			return Class_WC_WCCOM_Site_Installer.get_wp_upgrader()
		}
		else { return none }
	}
}

fn (this &Class_WC_WCCOM_Site_Installer) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'wp_upgrader' { return this.wp_upgrader }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_WCCOM_Site_Installer) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'wp_upgrader' { this.wp_upgrader = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}




pub fn init_wp_content_plugins_woocommerce_includes_wccom_site_class_wc_wccom_site_installer_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
