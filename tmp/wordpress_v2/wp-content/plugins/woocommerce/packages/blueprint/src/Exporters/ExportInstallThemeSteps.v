import rt

struct Class_Automattic_WooCommerce_Blueprint_Exporters_ExportInstallThemeSteps {
	rt.PhpObjectBase
pub mut:
	filter_callback rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_Exporters_ExportInstallThemeSteps) filter(mut var_callback Class_Automattic_WooCommerce_Blueprint_Exporters_callable) {
	this.filter_callback = var_callback
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_Exporters_ExportInstallThemeSteps) export() rt.PhpVal {
	mut var_steps := rt.new_array()
	mut var_themes := this.wp_get_themes()
	if rt.is_true(rt.call_function('is_callable', [this.filter_callback])) {
		var_themes = rt.call_function('call_user_func', [this.filter_callback, var_themes.clone()])
	}
	mut var_active_theme := this.wp_get_theme()
	mut iter_1 := var_themes.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_theme := item_1.val
		mut var_slug := item_1.key
		mut var_is_active := rt.identical(rt.call_method(var_theme, 'get', [
			rt.new_string('Name'),
		]), rt.call_method(var_active_theme, 'get', [rt.new_string('Name')]))
		mut var_info := this.wp_themes_api(rt.new_string('theme_information'), rt.create_array([
			rt.ArrayItem{ key: 'slug', val: var_slug },
			rt.ArrayItem{ key: 'fields', val: rt.create_array([
				rt.ArrayItem{ key: 'sections', val: false },
			]) },
		]))
		if !(rt.get_property(var_info, 'download_link')).is_null() {
			var_steps.array_push(create_automattic_woocommerce_blueprint_steps_installtheme(var_slug.clone(),
				rt.new_string('wordpress.org/themes'), rt.create_array([
				rt.ArrayItem{ key: 'activate', val: var_is_active },
			])))
		}
	}
	return var_steps.clone()
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_Exporters_ExportInstallThemeSteps) get_step_name() rt.PhpVal {
	mut iife_temp_0 := Class_Automattic_WooCommerce_Blueprint_Steps_InstallTheme{}
	mut iife_result_0 := iife_temp_0.get_step_name()
	return iife_result_0
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_Exporters_ExportInstallThemeSteps) check_step_capabilities() bool {
	return (rt.call_function('current_user_can', [rt.new_string('switch_themes')])).to_bool()
}

struct Class_Automattic_WooCommerce_Blueprint_Steps_InstallTheme {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blueprint_exporters_exportinstallthemesteps(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blueprint_Exporters_ExportInstallThemeSteps {
	mut obj := &Class_Automattic_WooCommerce_Blueprint_Exporters_ExportInstallThemeSteps{
		PhpObjectBase:   rt.PhpObjectBase{}
		filter_callback: rt.new_null()
	}
	return obj
}

fn create_automattic_woocommerce_blueprint_steps_installtheme(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blueprint_Steps_InstallTheme {
	mut obj := &Class_Automattic_WooCommerce_Blueprint_Steps_InstallTheme{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_Exporters_ExportInstallThemeSteps) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'filter' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Blueprint_Exporters_callable](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.filter(mut dispatch_arg_0)
			return rt.new_null()
		}
		'export' {
			return this.export()
		}
		'get_step_name' {
			return this.get_step_name()
		}
		'check_step_capabilities' {
			return rt.new_bool(this.check_step_capabilities())
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Blueprint_Exporters_ExportInstallThemeSteps) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'filter_callback' { return this.filter_callback }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_Exporters_ExportInstallThemeSteps) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'filter_callback' {
			this.filter_callback = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
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

fn main() {
	defer {
		rt.shutdown()
	}
}
