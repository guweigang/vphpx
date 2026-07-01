import rt

struct Class_ActionScheduler_SystemInformation {
	rt.PhpObjectBase
}

fn Class_ActionScheduler_SystemInformation.active_source() rt.PhpVal {
	mut var_plugins := rt.call_function('get_plugins', []rt.PhpVal{})
	mut var_plugin_files := rt.func_array_keys(var_plugins.dup())
	{
		mut iter_1 := var_plugin_files.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_plugin_file := item_1.val
			mut var_plugin_path := rt.new_string(rt.concat(rt.call_function('trailingslashit', [rt.get_constant('WP_PLUGIN_DIR')]), rt.call_function('dirname', [var_plugin_file.dup()])))
			var_plugin_file = rt.new_string(rt.concat(rt.call_function('trailingslashit', [rt.get_constant('WP_PLUGIN_DIR')]), var_plugin_file))
			if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
				continue
			}
			mut var_plugin_data := rt.call_function('get_plugin_data', [var_plugin_file.dup()])
			if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_plugin_data.dup().is_array()))))) || !rt.is_true(var_plugin_data.array_get('Name')))) {
				continue
			}
			return rt.create_array([rt.ArrayItem{ key: 'type', val: 'plugin' }, rt.ArrayItem{ key: 'name', val: var_plugin_data.array_get('Name') }])
		}
	}
	mut var_themes := rt.cast_array(rt.call_function('search_theme_directories', []rt.PhpVal{}))
	{
		mut iter_1 := var_themes.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_data := item_1.val
			mut var_slug := item_1.key
			mut var_needle := rt.new_string((rt.call_function('trailingslashit', [var_data.array_get('theme_root')])).str() + (var_slug).str() + '/')
			if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
				continue
			}
			mut var_theme := rt.call_function('wp_get_theme', [var_slug.dup()])
			if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_theme.dup().is_object()))))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_a', [var_theme.dup(), Class_WP_Theme.class()]))))))) {
				continue
			}
			return rt.create_array([rt.ArrayItem{ key: 'type', val: 'theme' }, rt.ArrayItem{ key: 'name', val: rt.get_property(var_theme, 'Name') }])
		}
	}
	return rt.new_array()
}

fn Class_ActionScheduler_SystemInformation.active_source_path() string {
	return (rt.call_function('trailingslashit', [rt.call_function('dirname', [rt.new_string(@DIR)])])).str()
}

fn Class_ActionScheduler_SystemInformation.get_sources() rt.PhpVal {
	mut var_versions := fn () rt.PhpVal { mut temp := Class_ActionScheduler_Versions{}; return temp.instance() }()
	return if rt.is_true(rt.call_function('method_exists', [var_versions.dup(), rt.new_string('get_sources')])) { rt.call_method(var_versions, 'get_sources', []rt.PhpVal{}) } else { rt.new_array() }
}

struct Class_ActionScheduler_Versions {
	rt.PhpObjectBase
}

fn create_actionscheduler_systeminformation() &Class_ActionScheduler_SystemInformation {
	mut obj := &Class_ActionScheduler_SystemInformation{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_actionscheduler_versions() &Class_ActionScheduler_Versions {
	mut obj := &Class_ActionScheduler_Versions{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_ActionScheduler_SystemInformation) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'active_source' {
			return Class_ActionScheduler_SystemInformation.active_source()
		}
		'active_source_path' {
			return rt.new_string(Class_ActionScheduler_SystemInformation.active_source_path())
		}
		'get_sources' {
			return Class_ActionScheduler_SystemInformation.get_sources()
		}
		else { return none }
	}
}

fn (this &Class_ActionScheduler_SystemInformation) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ActionScheduler_SystemInformation) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_ActionScheduler_Versions) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ActionScheduler_Versions) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ActionScheduler_Versions) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_packages_action_scheduler_classes_actionscheduler_systeminformation_php() {
}
