import rt

struct Class_Automattic_WooCommerce_Blueprint_BuiltInExporters {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_BuiltInExporters) get_all() rt.PhpVal {
	return rt.create_array([
		rt.ArrayItem{
			key: none
			val: create_automattic_woocommerce_blueprint_exporters_exportinstallpluginsteps()
		},
		rt.ArrayItem{
			key: none
			val: create_automattic_woocommerce_blueprint_exporters_exportinstallthemesteps()
		},
	])
}

struct Class_Automattic_WooCommerce_Blueprint_Exporters_ExportInstallPluginSteps {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blueprint_Exporters_ExportInstallThemeSteps {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blueprint_builtinexporters() &Class_Automattic_WooCommerce_Blueprint_BuiltInExporters {
	mut obj := &Class_Automattic_WooCommerce_Blueprint_BuiltInExporters{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blueprint_exporters_exportinstallpluginsteps() &Class_Automattic_WooCommerce_Blueprint_Exporters_ExportInstallPluginSteps {
	mut obj := &Class_Automattic_WooCommerce_Blueprint_Exporters_ExportInstallPluginSteps{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blueprint_exporters_exportinstallthemesteps() &Class_Automattic_WooCommerce_Blueprint_Exporters_ExportInstallThemeSteps {
	mut obj := &Class_Automattic_WooCommerce_Blueprint_Exporters_ExportInstallThemeSteps{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_BuiltInExporters) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_all' {
			return this.get_all()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Blueprint_BuiltInExporters) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_BuiltInExporters) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_Exporters_ExportInstallPluginSteps) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blueprint_Exporters_ExportInstallPluginSteps) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_Exporters_ExportInstallPluginSteps) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_Exporters_ExportInstallThemeSteps) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blueprint_Exporters_ExportInstallThemeSteps) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_Exporters_ExportInstallThemeSteps) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_content_plugins_woocommerce_packages_blueprint_src_builtinexporters_php() {
}
