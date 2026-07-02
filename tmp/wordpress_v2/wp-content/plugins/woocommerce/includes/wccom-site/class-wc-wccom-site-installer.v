import rt

struct Class_WC_WCCOM_Site_Installer {
	rt.PhpObjectBase
}

fn init_static_wc_wccom_site_installer() {
	rt.init_static_prop('WC_WCCOM_Site_Installer', 'wp_upgrader', rt.new_null())
}

fn Class_WC_WCCOM_Site_Installer.get_wporg_plugin_main_file(var_dir rt.PhpVal) bool {
	mut var_dir_mutated := var_dir
	var_dir_mutated = rt.call_function('trailingslashit', [var_dir_mutated.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('get_plugins'),
	])))))
	{
		rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/plugin.php', '4')
	}
	mut var_plugins := rt.call_function('get_plugins', []rt.PhpVal{})
	mut iter_1 := var_plugins.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_plugin := item_1.val
		mut var_path := item_1.key
		if rt.is_true(rt.identical(rt.new_int(0), rt.call_function('strpos', [
			var_path.clone(), var_dir_mutated.clone()])))
		{
			return var_path.to_bool()
		}
	}
	return false
}

fn Class_WC_WCCOM_Site_Installer.get_plugin_info(var_dir rt.PhpVal) rt.PhpVal {
	mut var_dir_mutated := var_dir
	mut var_plugin_folder := rt.call_function('basename', [var_dir_mutated.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('get_plugins'),
	])))))
	{
		rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/plugin.php', '4')
	}
	mut var_plugins := rt.call_function('get_plugins', []rt.PhpVal{})
	closure_1_fn := fn [var_plugin_folder] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_key := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.identical(rt.call_function('strpos', [var_key.clone(),
			rt.new_string(var_plugin_folder.str() + '/')]), rt.new_int(0))
	}
	mut var_related_plugins := rt.call_function('array_filter', [
		var_plugins.clone(), rt.new_closure(closure_1_fn), rt.get_constant('ARRAY_FILTER_USE_KEY')])
	if 1 == var_related_plugins.clone().array_count() {
		mut var_plugin_key :=
			rt.func_array_keys(var_related_plugins.clone()).array_get(rt.new_int(0))
		mut var_plugin_data := var_plugins.array_get(var_plugin_key)
		return rt.create_array([
			rt.ArrayItem{ key: 'name', val: var_plugin_data.array_get(rt.new_string('Name')) },
			rt.ArrayItem{ key: 'version', val: var_plugin_data.array_get(rt.new_string('Version')) },
			rt.ArrayItem{ key: 'active', val: rt.call_function('is_plugin_active', [
				var_plugin_key.clone(),
			]) },
		])
	}
	return rt.new_bool(false)
}

fn Class_WC_WCCOM_Site_Installer.get_wp_upgrader() rt.PhpVal {
	if !(!rt.is_true(rt.get_static_prop('WC_WCCOM_Site_Installer', 'wp_upgrader'))) {
		return rt.get_static_prop('WC_WCCOM_Site_Installer', 'wp_upgrader')
	}
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/file.php', '4')
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/plugin-install.php',
		'4')
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/class-wp-upgrader.php',
		'4')
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/plugin.php', '4')
	rt.call_function('WP_Filesystem', []rt.PhpVal{})
	rt.set_static_prop('WC_WCCOM_Site_Installer', 'wp_upgrader', rt.new_object('WP_Upgrader',
		[]string{}, create_wp_upgrader(create_automatic_upgrader_skin())))
	rt.call_method(rt.get_static_prop('WC_WCCOM_Site_Installer', 'wp_upgrader'), 'init',
		[]rt.PhpVal{})
	rt.call_function('wp_clean_plugins_cache', []rt.PhpVal{})
	return rt.get_static_prop('WC_WCCOM_Site_Installer', 'wp_upgrader')
}

struct Class_WP_Upgrader {
	rt.PhpObjectBase
}

struct Class_Automatic_Upgrader_Skin {
	rt.PhpObjectBase
}

fn create_wc_wccom_site_installer(_args ...rt.PhpVal) &Class_WC_WCCOM_Site_Installer {
	mut obj := &Class_WC_WCCOM_Site_Installer{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_upgrader(_args ...rt.PhpVal) &Class_WP_Upgrader {
	mut obj := &Class_WP_Upgrader{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automatic_upgrader_skin(_args ...rt.PhpVal) &Class_Automatic_Upgrader_Skin {
	mut obj := &Class_Automatic_Upgrader_Skin{
		PhpObjectBase: rt.PhpObjectBase{}
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
		else {
			return none
		}
	}
}

fn (this &Class_WC_WCCOM_Site_Installer) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_WCCOM_Site_Installer) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WP_Upgrader) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Upgrader) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Upgrader) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automatic_Upgrader_Skin) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automatic_Upgrader_Skin) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automatic_Upgrader_Skin) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}
