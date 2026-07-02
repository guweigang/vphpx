import rt

struct Class_Automattic_WooCommerce_Blueprint_Exporters_ExportInstallPluginSteps {
	rt.PhpObjectBase
pub mut:
		filter_callback rt.PhpVal = rt.new_null()
		include_private_plugins rt.PhpVal = rt.new_bool(false)
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_Exporters_ExportInstallPluginSteps) include_private_plugins(boolean bool) {
	this.include_private_plugins = rt.new_bool(boolean)
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_Exporters_ExportInstallPluginSteps) filter(mut var_callback Class_Automattic_WooCommerce_Blueprint_Exporters_callable) {
	this.filter_callback = var_callback
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_Exporters_ExportInstallPluginSteps) export() rt.PhpVal {
	mut var_plugins := this.sort_plugins_by_dep(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Blueprint_Exporters_array](this.wp_get_plugins()))
	if rt.is_true(rt.call_function('is_callable', [this.filter_callback])) {
	var_plugins = rt.call_function('call_user_func', [this.filter_callback, var_plugins.clone()])
	}
	mut var_exclude := rt.create_array([rt.ArrayItem{ key: none, val: 'WooCommerce Beta Tester' }])
	mut var_steps := rt.new_array()
	mut iter_1 := var_plugins.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_plugin := item_1.val
		mut var_path := item_1.key
		if rt.is_true(rt.call_function('in_array', [var_plugin.array_get(rt.new_string('Name')), var_exclude.clone(), rt.new_bool(true)])) {
			continue
		}
		mut var_slug := rt.call_function('dirname', [var_path.clone()])
		if rt.is_true(rt.identical(rt.new_string('.'), var_slug)) {
		var_slug = rt.call_function('pathinfo', [var_path.clone()]).array_get(rt.new_string('filename'))
		}
		mut var_info := this.wp_plugins_api(rt.new_string('plugin_information'), rt.create_array([rt.ArrayItem{ key: 'slug', val: var_slug }, rt.ArrayItem{ key: 'fields', val: rt.create_array([rt.ArrayItem{ key: 'sections', val: false }]) }]))
		mut var_has_download_link := rt.new_bool(!(rt.get_property(var_info, 'download_link')).is_null())
		if rt.is_true(rt.identical(rt.new_bool(false), this.include_private_plugins)) && rt.is_true(rt.new_bool(!(rt.is_true(var_has_download_link)))) {
			continue
		}
		mut var_resource := rt.new_string((if rt.is_true(var_has_download_link) { 'wordpress.org/plugins' } else { 'self/plugins' }).str())
		var_steps.array_push(create_automattic_woocommerce_blueprint_steps_installplugin(var_slug.clone(), var_resource.clone(), rt.create_array([rt.ArrayItem{ key: 'activate', val: true }])))
	}
	return var_steps.clone()
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_Exporters_ExportInstallPluginSteps) sort_plugins_by_dep(mut var_plugins Class_Automattic_WooCommerce_Blueprint_Exporters_array) rt.PhpVal {
	mut var_plugins_mutated := var_plugins
	mut var_sorted := rt.new_array()
	mut var_visited := rt.new_array()
	closure_1_fn := fn [var_plugins] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_carry := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_key := if args.len > 1 { args[1].clone() } else { rt.new_null() }
		mut var_title := rt.new_string(if !(var_plugins_mutated.array_get(var_key).array_get(rt.new_string('Title'))).is_null() { var_plugins_mutated.array_get(var_key).array_get(rt.new_string('Title')) } else { rt.new_string('') }.to_string().to_lower())
		if rt.is_true(var_title) {
			var_carry.array_set(var_title, var_key.clone())
		}
		return var_carry.clone()
		}
	mut var_title_map := rt.call_function('array_reduce', [rt.func_array_keys(var_plugins_mutated), rt.new_closure(closure_1_fn), rt.new_array()])
	closure_2_fn := fn [mut var_visit, mut var_sorted, mut var_visited, var_plugins, var_title_map] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_plugin_key := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		if var_visited.array_isset(var_plugin_key) {
			return rt.new_null()
		}
		var_visited.array_set(var_plugin_key, true)
		mut var_requires := if !(var_plugins_mutated.array_get(var_plugin_key).array_get(rt.new_string('RequiresPlugins'))).is_null() { var_plugins_mutated.array_get(var_plugin_key).array_get(rt.new_string('RequiresPlugins')) } else { rt.new_array() }
		mut iter_2 := rt.cast_array(var_requires).iterator()
		for {
			item_2 := iter_2.next() or { break }
			mut var_dependency := item_2.val
			mut var_dependency_key := if !(var_title_map.array_get(rt.new_string((var_dependency.clone().to_string().to_lower()).str()))).is_null() { var_title_map.array_get(rt.new_string((var_dependency.clone().to_string().to_lower()).str())) } else { rt.new_null() }
			if rt.is_true(var_dependency_key) {
				rt.call_callable(var_visit, [var_dependency_key.clone()])
			}
		}
		var_sorted.array_set(var_plugin_key, var_plugins_mutated.array_get(var_plugin_key))
		return rt.new_null()
		}
	mut var_visit := rt.new_closure(closure_2_fn)
	mut iter_3 := rt.func_array_keys(var_plugins_mutated).iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_plugin_key := item_3.val
		rt.call_callable(var_visit, [var_plugin_key.clone()])
	}
	return var_sorted.clone()
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_Exporters_ExportInstallPluginSteps) get_step_name() rt.PhpVal {
	mut iife_temp_2 := Class_Automattic_WooCommerce_Blueprint_Steps_InstallPlugin{}
	mut iife_result_2 := iife_temp_2.get_step_name()
	return iife_result_2
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_Exporters_ExportInstallPluginSteps) check_step_capabilities() bool {
	return (rt.call_function('current_user_can', [rt.new_string('activate_plugins')])).to_bool()
}

struct Class_Automattic_WooCommerce_Blueprint_Steps_InstallPlugin {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blueprint_exporters_exportinstallpluginsteps(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blueprint_Exporters_ExportInstallPluginSteps {
	mut obj := &Class_Automattic_WooCommerce_Blueprint_Exporters_ExportInstallPluginSteps{
		PhpObjectBase: rt.PhpObjectBase{}
		filter_callback: rt.new_null()
		include_private_plugins: rt.new_bool(false)
	}
	return obj
}

fn create_automattic_woocommerce_blueprint_steps_installplugin(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blueprint_Steps_InstallPlugin {
	mut obj := &Class_Automattic_WooCommerce_Blueprint_Steps_InstallPlugin{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_Exporters_ExportInstallPluginSteps) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'include_private_plugins' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			this.include_private_plugins(dispatch_arg_0)
			return rt.new_null()
		}
		'filter' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Blueprint_Exporters_callable](if args.len > 0 { args[0] } else { rt.new_null() })
			this.filter(mut dispatch_arg_0)
			return rt.new_null()
		}
		'export' {
			return this.export()
		}
		'sort_plugins_by_dep' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Blueprint_Exporters_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.sort_plugins_by_dep(mut dispatch_arg_0)
		}
		'get_step_name' {
			return this.get_step_name()
		}
		'check_step_capabilities' {
			return rt.new_bool(this.check_step_capabilities())
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Blueprint_Exporters_ExportInstallPluginSteps) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'filter_callback' { return this.filter_callback }
		'include_private_plugins' { return this.include_private_plugins }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_Exporters_ExportInstallPluginSteps) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'filter_callback' { this.filter_callback = val; return true }
		'include_private_plugins' { this.include_private_plugins = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_WooCommerce_Blueprint_Steps_InstallPlugin) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blueprint_Steps_InstallPlugin) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_Steps_InstallPlugin) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn init_registry() {
}

fn init() {
	init_registry()
}


fn main() {
	defer {
		rt.shutdown()
	}

}
