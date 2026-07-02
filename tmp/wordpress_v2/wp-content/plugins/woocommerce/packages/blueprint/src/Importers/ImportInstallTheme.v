import rt

struct Class_Automattic_WooCommerce_Blueprint_Importers_ImportInstallTheme {
	rt.PhpObjectBase
pub mut:
	storage rt.PhpVal = rt.new_null()
	result  rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_Importers_ImportInstallTheme) construct(mut var_storage Class_Automattic_WooCommerce_Blueprint_ResourceStorages) {
	mut iife_temp_0 := Class_Automattic_WooCommerce_Blueprint_Steps_InstallTheme{}
	mut iife_result_0 := iife_temp_0.get_step_name()
	mut iife_temp_1 := Class_Automattic_WooCommerce_Blueprint_StepProcessorResult{}
	mut iife_result_1 := iife_temp_1.success(iife_result_0)
	this.result = iife_result_1
	this.storage = var_storage
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_Importers_ImportInstallTheme) process(var_schema rt.PhpVal) rt.PhpVal {
	mut var_schema_mutated := var_schema
	mut var_installed_themes := this.wp_get_themes()
	mut var_theme := rt.get_property(var_schema_mutated, 'themeData')
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('wordpress.org/themes'), rt.get_property(var_theme,
		'resource')))))
	{
		rt.call_method(this.result, 'add_info', [
			rt.new_string("Skipped installing a theme. Unsupported resource type. Only 'wordpress.org/themes' is supported at the moment."),
		])
		return this.result
	}
	if !(!(rt.get_property(var_schema_mutated, 'options')).is_null()) {
		rt.set_property(var_schema_mutated, 'options',
			create_automattic_woocommerce_blueprint_importers_stdclass())
	}
	if var_installed_themes.array_isset(rt.get_property(var_theme, 'slug')) {
		this.activate_theme(var_schema_mutated.clone())
		rt.call_method(this.result, 'add_info', [
			rt.concat(rt.concat(rt.new_string('Skipped installing '), rt.get_property(var_theme,
				'slug')), rt.new_string('. It is already installed.')),
		])
		return this.result
	}
	if rt.is_true(rt.identical(rt.call_method(this.storage, 'is_supported_resource', [
		rt.get_property(var_theme, 'resource'),
	]), rt.new_bool(false)))
	{
		rt.call_method(this.result, 'add_error', [
			rt.concat(rt.new_string('Invalid resource type for '), rt.get_property(var_theme,
				'slug')),
		])
		return this.result
	}
	mut var_downloaded_path := rt.call_method(this.storage, 'download', [
		rt.get_property(var_theme, 'slug'),
		rt.get_property(var_theme, 'resource'),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_downloaded_path)))) {
		rt.call_method(this.result, 'add_error', [
			rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('Unable to download '), rt.get_property(var_theme,
				'slug')), rt.new_string(' with ')), rt.get_property(var_theme, 'resource')),
				rt.new_string(' resource type.')),
		])
		return this.result
	}
	rt.call_method(this.result, 'add_debug', [
		rt.concat(rt.concat(rt.concat(rt.new_string("'"), rt.get_property(var_theme, 'slug')),
			rt.new_string("' has been downloaded in ")), var_downloaded_path),
	])
	mut var_install := rt.new_bool(this.install(var_downloaded_path.clone()))
	if rt.is_true(var_install) {
		rt.call_method(this.result, 'add_debug', [
			rt.concat(rt.concat(rt.new_string("Theme '"), rt.get_property(var_theme, 'slug')),
				rt.new_string("' installed successfully.")),
		])
	} else {
		rt.call_method(this.result, 'add_error', [
			rt.concat(rt.concat(rt.new_string("Failed to install theme '"), rt.get_property(var_theme,
				'slug')), rt.new_string("'.")),
		])
	}
	this.activate_theme(var_schema_mutated.clone())
	return this.result
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_Importers_ImportInstallTheme) activate_theme(var_schema rt.PhpVal) {
	mut var_schema_mutated := var_schema
	mut var_theme := rt.get_property(var_schema_mutated, 'themeData')
	if !(rt.get_property(rt.get_property(var_schema_mutated, 'options'), 'activate')).is_null()
		&& rt.is_true(rt.identical(rt.new_bool(true), rt.get_property(rt.get_property(var_schema_mutated, 'options'), 'activate'))) {
		this.wp_switch_theme(rt.get_property(var_theme, 'slug'))
		mut var_current_theme := rt.call_method(this.wp_get_theme(), 'get_stylesheet',
			[]rt.PhpVal{})
		if rt.is_true(rt.identical(var_current_theme, rt.get_property(var_theme, 'slug'))) {
			rt.call_method(this.result, 'add_info', [
				rt.concat(rt.concat(rt.new_string("Switched theme to '"), rt.get_property(var_theme,
					'slug')), rt.new_string("'.")),
			])
		} else {
			rt.call_method(this.result, 'add_error', [
				rt.concat(rt.concat(rt.new_string("Failed to switch theme to '"), rt.get_property(var_theme,
					'slug')), rt.new_string("'.")),
			])
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_Importers_ImportInstallTheme) install(var_local_path rt.PhpVal) bool {
	mut var_unzip_result := this.wp_unzip_file(var_local_path.clone(), this.wp_get_theme_root())
	if rt.is_true(this.is_wp_error(var_unzip_result.clone())) {
		return false
	}
	return true
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_Importers_ImportInstallTheme) get_step_class() string {
	return (Class_Automattic_WooCommerce_Blueprint_Steps_InstallTheme.class()).str()
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_Importers_ImportInstallTheme) check_step_capabilities(var_schema rt.PhpVal) bool {
	mut var_schema_mutated := var_schema
	return (rt.call_function('current_user_can', [rt.new_string('install_themes')])).to_bool()
}

struct Class_Automattic_WooCommerce_Blueprint_StepProcessorResult {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blueprint_Steps_InstallTheme {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blueprint_Importers_stdClass {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blueprint_importers_importinstalltheme(arg_0 rt.PhpVal) &Class_Automattic_WooCommerce_Blueprint_Importers_ImportInstallTheme {
	mut obj := &Class_Automattic_WooCommerce_Blueprint_Importers_ImportInstallTheme{
		PhpObjectBase: rt.PhpObjectBase{}
		storage:       rt.new_null()
		result:        rt.new_null()
	}
	obj.construct(arg_0)
	return obj
}

fn create_automattic_woocommerce_blueprint_stepprocessorresult(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blueprint_StepProcessorResult {
	mut obj := &Class_Automattic_WooCommerce_Blueprint_StepProcessorResult{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blueprint_steps_installtheme(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blueprint_Steps_InstallTheme {
	mut obj := &Class_Automattic_WooCommerce_Blueprint_Steps_InstallTheme{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blueprint_importers_stdclass(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blueprint_Importers_stdClass {
	mut obj := &Class_Automattic_WooCommerce_Blueprint_Importers_stdClass{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_Importers_ImportInstallTheme) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Blueprint_ResourceStorages](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.construct(mut dispatch_arg_0)
			return rt.new_null()
		}
		'process' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.process(dispatch_arg_0)
		}
		'activate_theme' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.activate_theme(dispatch_arg_0)
			return rt.new_null()
		}
		'install' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.install(dispatch_arg_0))
		}
		'get_step_class' {
			return rt.new_string(this.get_step_class())
		}
		'check_step_capabilities' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.check_step_capabilities(dispatch_arg_0))
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Blueprint_Importers_ImportInstallTheme) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'storage' { return this.storage }
		'result' { return this.result }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_Importers_ImportInstallTheme) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'storage' {
			this.storage = val
			return true
		}
		'result' {
			this.result = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
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

fn (mut this Class_Automattic_WooCommerce_Blueprint_Steps_InstallTheme) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blueprint_Steps_InstallTheme) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_Steps_InstallTheme) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_Importers_stdClass) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blueprint_Importers_stdClass) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_Importers_stdClass) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
