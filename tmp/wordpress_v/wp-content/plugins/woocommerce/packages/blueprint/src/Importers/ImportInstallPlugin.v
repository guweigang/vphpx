import rt

struct Class_Automattic_WooCommerce_Blueprint_Importers_ImportInstallPlugin {
	rt.PhpObjectBase
pub mut:
		storage rt.PhpVal = rt.new_null()
		installed_plugin_paths rt.PhpVal = rt.new_array()
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_Importers_ImportInstallPlugin) construct(mut var_storage Class_Automattic_WooCommerce_Blueprint_ResourceStorages)  {
	this.storage = var_storage.dup()
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_Importers_ImportInstallPlugin) process(var_schema rt.PhpVal) rt.PhpVal {
	mut var_result := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Blueprint_StepProcessorResult{}; return temp.success(arg_0) }(fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Blueprint_Steps_InstallPlugin{}; return temp.get_step_name() }())
	mut var_installed_plugins := this.get_installed_plugins_paths()
	mut var_plugin := rt.get_property(var_schema, 'pluginData')
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		rt.call_method(var_result, 'add_info', [rt.new_string('Skipped installing a plugin. Unsupported resource type. Only \'wordpress.org/plugins\' is supported at the moment.')])
		return var_result.dup()
	}
	if var_installed_plugins.array_isset(rt.get_property(var_plugin, 'slug')) {
		rt.call_method(var_result, 'add_info', [rt.concat(rt.concat(rt.new_string('Skipped installing '), rt.get_property(var_plugin, 'slug')), rt.new_string('. It is already installed.'))])
		return var_result.dup()
	}
	if rt.is_true(rt.identical(rt.call_method(this.storage, 'is_supported_resource', [rt.get_property(var_plugin, 'resource')]), rt.new_bool(false))) {
		rt.call_method(var_result, 'add_error', [rt.concat(rt.concat(rt.new_string('Invalid resource type for '), rt.get_property(var_plugin, 'slug')), rt.new_string('.'))])
		return var_result.dup()
	}
	mut var_downloaded_path := rt.call_method(this.storage, 'download', [rt.get_property(var_plugin, 'slug'), rt.get_property(var_plugin, 'resource')])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_downloaded_path)))) {
		rt.call_method(var_result, 'add_error', [rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('Unable to download '), rt.get_property(var_plugin, 'slug')), rt.new_string(' with ')), rt.get_property(var_plugin, 'resource')), rt.new_string(' resource type.'))])
		return var_result.dup()
	}
	mut var_install := this.install(var_downloaded_path.dup())
	if rt.is_true(rt.call_function('is_wp_error', [var_install.dup()])) {
		rt.call_method(var_result, 'add_error', [rt.concat(rt.concat(rt.new_string('Failed to install '), rt.get_property(var_plugin, 'slug')), rt.new_string('.'))])
		return var_result.dup()
	}
	rt.call_method(var_result, 'add_info', [rt.concat(rt.concat(rt.new_string('Installed '), rt.get_property(var_plugin, 'slug')), rt.new_string('.'))])
	mut var_should_activate := rt.new_bool(rt.new_bool(!(rt.get_property(var_schema, 'options')).is_null() && !(rt.get_property(rt.get_property(var_schema, 'options'), 'activate')).is_null() && rt.is_true(rt.identical(rt.new_bool(true), rt.get_property(rt.get_property(var_schema, 'options'), 'activate')))))
	if rt.is_true(var_should_activate) {
		mut var_activate := this.activate(rt.get_property(var_plugin, 'slug'))
		if rt.is_true(rt.new_bool(rt.instance_of(var_activate, 'Automattic_WooCommerce_Blueprint_Importers_WP_Error'))) {
			rt.call_method(var_result, 'add_error', [rt.concat(rt.concat(rt.new_string('Failed to activate '), rt.get_property(var_plugin, 'slug')), rt.new_string('.'))])
			return var_result.dup()
		}
		rt.call_method(var_result, 'add_info', [rt.concat(rt.concat(rt.new_string('Activated '), rt.get_property(var_plugin, 'slug')), rt.new_string('.'))])
	}
	return var_result.dup()
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_Importers_ImportInstallPlugin) install(var_local_plugin_path rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [rt.new_string('Plugin_Upgrader')]))))) {
		rt.include_file((rt.get_constant('ABSPATH')).str() + '/wp-admin/includes/class-wp-upgrader.php', '2')
		rt.include_file((rt.get_constant('ABSPATH')).str() + '/wp-admin/includes/class-plugin-upgrader.php', '2')
	}
	mut var_upgrader := create_plugin_upgrader(create_automattic_woocommerce_blueprint_importers_automatic_upgrader_skin())
	return var_upgrader.install(var_local_plugin_path.dup())
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_Importers_ImportInstallPlugin) activate(var_slug rt.PhpVal) rt.PhpVal {
	mut var_slug_mutated := var_slug
	if !rt.is_true(this.installed_plugin_paths) {
		this.installed_plugin_paths = this.get_installed_plugins_paths()
	}
	mut var_path := if !(this.installed_plugin_paths.array_get(var_slug_mutated)).is_null() { this.installed_plugin_paths.array_get(var_slug_mutated) } else { rt.new_bool(false) }
	if rt.is_true(rt.new_bool(!(rt.is_true(var_path)))) {
		return create_automattic_woocommerce_blueprint_importers_wp_error(rt.new_string('plugin_not_installed'), rt.new_string("Plugin ${var_slug.to_string()} is not installed."))
	}
	return this.wp_activate_plugin(var_path.dup())
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_Importers_ImportInstallPlugin) get_installed_plugins_paths() rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('get_plugins')]))))) {
		rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/plugin.php', '4')
	}
	mut var_plugins := rt.call_function('get_plugins', []rt.PhpVal{})
	mut var_installed_plugins := rt.new_array()
	{
		mut iter_1 := var_plugins.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_plugin := item_1.val
			mut var_path := item_1.key
			mut var_path_parts := rt.call_function('explode', [rt.new_string('/'), var_path.dup()])
			mut var_slug := var_path_parts.array_get(0)
			var_installed_plugins.array_set(var_slug, var_path.dup())
		}
	}
	return var_installed_plugins.dup()
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_Importers_ImportInstallPlugin) get_step_class() string {
	return (Class_Automattic_WooCommerce_Blueprint_Steps_InstallPlugin.class()).str()
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_Importers_ImportInstallPlugin) check_step_capabilities(var_schema rt.PhpVal) bool {
	return (rt.call_function('current_user_can', [rt.new_string('install_plugins')])).to_bool()
}

struct Class_Automattic_WooCommerce_Blueprint_StepProcessorResult {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blueprint_Steps_InstallPlugin {
	rt.PhpObjectBase
}

struct Class_Plugin_Upgrader {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blueprint_Importers_Automatic_Upgrader_Skin {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blueprint_Importers_WP_Error {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blueprint_importers_importinstallplugin(arg_0 rt.PhpVal) &Class_Automattic_WooCommerce_Blueprint_Importers_ImportInstallPlugin {
	mut obj := &Class_Automattic_WooCommerce_Blueprint_Importers_ImportInstallPlugin{
		PhpObjectBase: rt.PhpObjectBase{}
		storage: rt.new_null()
		installed_plugin_paths: rt.new_array()
	}
	obj.construct(arg_0)
	return obj
}

fn create_automattic_woocommerce_blueprint_stepprocessorresult() &Class_Automattic_WooCommerce_Blueprint_StepProcessorResult {
	mut obj := &Class_Automattic_WooCommerce_Blueprint_StepProcessorResult{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blueprint_steps_installplugin() &Class_Automattic_WooCommerce_Blueprint_Steps_InstallPlugin {
	mut obj := &Class_Automattic_WooCommerce_Blueprint_Steps_InstallPlugin{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_plugin_upgrader() &Class_Plugin_Upgrader {
	mut obj := &Class_Plugin_Upgrader{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blueprint_importers_automatic_upgrader_skin() &Class_Automattic_WooCommerce_Blueprint_Importers_Automatic_Upgrader_Skin {
	mut obj := &Class_Automattic_WooCommerce_Blueprint_Importers_Automatic_Upgrader_Skin{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blueprint_importers_wp_error() &Class_Automattic_WooCommerce_Blueprint_Importers_WP_Error {
	mut obj := &Class_Automattic_WooCommerce_Blueprint_Importers_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_Importers_ImportInstallPlugin) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Blueprint_ResourceStorages](if args.len > 0 { args[0] } else { rt.new_null() })
			this.construct(mut dispatch_arg_0)
			return rt.new_null()
		}
		'process' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.process(dispatch_arg_0)
		}
		'install' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.install(dispatch_arg_0)
		}
		'activate' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.activate(dispatch_arg_0)
		}
		'get_installed_plugins_paths' {
			return this.get_installed_plugins_paths()
		}
		'get_step_class' {
			return rt.new_string(this.get_step_class())
		}
		'check_step_capabilities' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.check_step_capabilities(dispatch_arg_0))
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Blueprint_Importers_ImportInstallPlugin) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'storage' { return this.storage }
		'installed_plugin_paths' { return this.installed_plugin_paths }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_Importers_ImportInstallPlugin) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'storage' { this.storage = val; return true }
		'installed_plugin_paths' { this.installed_plugin_paths = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_WooCommerce_Blueprint_StepProcessorResult) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blueprint_StepProcessorResult) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_StepProcessorResult) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
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


fn (mut this Class_Plugin_Upgrader) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Plugin_Upgrader) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Plugin_Upgrader) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Blueprint_Importers_Automatic_Upgrader_Skin) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blueprint_Importers_Automatic_Upgrader_Skin) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_Importers_Automatic_Upgrader_Skin) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Blueprint_Importers_WP_Error) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blueprint_Importers_WP_Error) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_Importers_WP_Error) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_packages_blueprint_src_importers_importinstallplugin_php() {
}
