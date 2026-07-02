import rt

struct Class_ActionScheduler_SystemInformation {
	rt.PhpObjectBase
}

fn Class_ActionScheduler_SystemInformation.active_source() rt.PhpVal {
	mut var_plugins := rt.call_function('get_plugins', []rt.PhpVal{})
	mut var_plugin_files := rt.func_array_keys(var_plugins.clone())
	mut iter_1 := var_plugin_files.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_plugin_file := item_1.val
		mut var_plugin_path := rt.new_string(
			(rt.call_function('trailingslashit', [rt.get_constant('WP_PLUGIN_DIR')])).str() +
			(rt.call_function('dirname', [var_plugin_file.clone()])).str())
		var_plugin_file = rt.new_string(
			(rt.call_function('trailingslashit', [rt.get_constant('WP_PLUGIN_DIR')])).str() +
			var_plugin_file.str())
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int(0), rt.call_function('strpos', [
			rt.call_function('dirname', [rt.new_string(@DIR)]),
			var_plugin_path.clone(),
		])))))
		{
			continue
		}
		mut var_plugin_data := rt.call_function('get_plugin_data', [
			var_plugin_file.clone()])
		if !(var_plugin_data.clone().is_array())
			|| !rt.is_true(var_plugin_data.array_get(rt.new_string('Name'))) {
			continue
		}
		return rt.create_array([rt.ArrayItem{ key: 'type', val: 'plugin' },
			rt.ArrayItem{ key: 'name', val: var_plugin_data.array_get(rt.new_string('Name')) }])
	}
	mut var_themes := rt.cast_array(rt.call_function('search_theme_directories', []rt.PhpVal{}))
	mut iter_2 := var_themes.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_data := item_2.val
		mut var_slug := item_2.key
		mut var_needle := rt.new_string(
			(rt.call_function('trailingslashit', [var_data.array_get(rt.new_string('theme_root'))])).str() +
			var_slug.str() + '/')
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int(0), rt.call_function('strpos', [
			rt.new_string(@FILE),
			var_needle.clone(),
		])))))
		{
			continue
		}
		mut var_theme := rt.call_function('wp_get_theme', [var_slug.clone()])
		if !(var_theme.clone().is_object())
			|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_a', [var_theme.clone(), Class_WP_Theme.class()]))))) {
			continue
		}
		return rt.create_array([rt.ArrayItem{ key: 'type', val: 'theme' },
			rt.ArrayItem{ key: 'name', val: rt.get_property(var_theme, 'Name') }])
	}
	return rt.new_array()
}

fn Class_ActionScheduler_SystemInformation.active_source_path() string {
	return (rt.call_function('trailingslashit', [
		rt.call_function('dirname', [rt.new_string(@DIR)]),
	])).str()
}

fn Class_ActionScheduler_SystemInformation.get_sources() rt.PhpVal {
	mut iife_temp_0 := Class_ActionScheduler_Versions{}
	mut iife_result_0 := iife_temp_0.instance()
	mut var_versions := iife_result_0
	return if rt.is_true(rt.call_function('method_exists', [var_versions.clone(),
		rt.new_string('get_sources')]))
	{ rt.call_method(var_versions, 'get_sources', []rt.PhpVal{}) } else { rt.new_array() }
}

struct Class_ActionScheduler_Versions {
	rt.PhpObjectBase
}

fn create_actionscheduler_systeminformation(_args ...rt.PhpVal) &Class_ActionScheduler_SystemInformation {
	mut obj := &Class_ActionScheduler_SystemInformation{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_actionscheduler_versions(_args ...rt.PhpVal) &Class_ActionScheduler_Versions {
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
		else {
			return none
		}
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

fn main() {
	defer {
		rt.shutdown()
	}
}
