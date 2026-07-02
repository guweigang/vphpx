import rt

struct Class_Automattic_WooCommerce_Blueprint_BuiltInStepProcessors {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_BuiltInStepProcessors) construct() {
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_BuiltInStepProcessors) get_all() rt.PhpVal {
	return rt.create_array([
		rt.ArrayItem{ key: none, val: this.create_install_plugins_processor() },
		rt.ArrayItem{ key: none, val: this.create_install_themes_processor() },
		rt.ArrayItem{
			key: none
			val: create_automattic_woocommerce_blueprint_importers_importsetsiteoptions()
		},
		rt.ArrayItem{
			key: none
			val: create_automattic_woocommerce_blueprint_importers_importactivateplugin()
		},
		rt.ArrayItem{
			key: none
			val: create_automattic_woocommerce_blueprint_importers_importactivatetheme()
		},
		rt.ArrayItem{
			key: none
			val: create_automattic_woocommerce_blueprint_importers_importrunsql()
		},
	])
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_BuiltInStepProcessors) create_install_plugins_processor() rt.PhpVal {
	mut var_storages := create_automattic_woocommerce_blueprint_resourcestorages()
	var_storages.add_storage(create_automattic_woocommerce_blueprint_resourcestorages_orgpluginresourcestorage())
	return rt.new_object('Automattic_WooCommerce_Blueprint_Importers_ImportInstallPlugin',
		[]string{},
		create_automattic_woocommerce_blueprint_importers_importinstallplugin(var_storages))
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_BuiltInStepProcessors) create_install_themes_processor() rt.PhpVal {
	mut var_storage := create_automattic_woocommerce_blueprint_resourcestorages()
	var_storage.add_storage(create_automattic_woocommerce_blueprint_resourcestorages_orgthemeresourcestorage())
	return rt.new_object('Automattic_WooCommerce_Blueprint_Importers_ImportInstallTheme',
		[]string{},
		create_automattic_woocommerce_blueprint_importers_importinstalltheme(var_storage))
}

struct Class_Automattic_WooCommerce_Blueprint_Importers_ImportSetSiteOptions {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blueprint_Importers_ImportActivatePlugin {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blueprint_Importers_ImportActivateTheme {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blueprint_Importers_ImportRunSql {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blueprint_ResourceStorages {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blueprint_ResourceStorages_OrgPluginResourceStorage {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blueprint_Importers_ImportInstallPlugin {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blueprint_ResourceStorages_OrgThemeResourceStorage {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blueprint_Importers_ImportInstallTheme {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blueprint_builtinstepprocessors() &Class_Automattic_WooCommerce_Blueprint_BuiltInStepProcessors {
	mut obj := &Class_Automattic_WooCommerce_Blueprint_BuiltInStepProcessors{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	obj.construct()
	return obj
}

fn create_automattic_woocommerce_blueprint_importers_importsetsiteoptions(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blueprint_Importers_ImportSetSiteOptions {
	mut obj := &Class_Automattic_WooCommerce_Blueprint_Importers_ImportSetSiteOptions{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blueprint_importers_importactivateplugin(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blueprint_Importers_ImportActivatePlugin {
	mut obj := &Class_Automattic_WooCommerce_Blueprint_Importers_ImportActivatePlugin{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blueprint_importers_importactivatetheme(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blueprint_Importers_ImportActivateTheme {
	mut obj := &Class_Automattic_WooCommerce_Blueprint_Importers_ImportActivateTheme{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blueprint_importers_importrunsql(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blueprint_Importers_ImportRunSql {
	mut obj := &Class_Automattic_WooCommerce_Blueprint_Importers_ImportRunSql{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blueprint_resourcestorages(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blueprint_ResourceStorages {
	mut obj := &Class_Automattic_WooCommerce_Blueprint_ResourceStorages{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blueprint_resourcestorages_orgpluginresourcestorage(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blueprint_ResourceStorages_OrgPluginResourceStorage {
	mut obj := &Class_Automattic_WooCommerce_Blueprint_ResourceStorages_OrgPluginResourceStorage{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blueprint_importers_importinstallplugin(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blueprint_Importers_ImportInstallPlugin {
	mut obj := &Class_Automattic_WooCommerce_Blueprint_Importers_ImportInstallPlugin{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blueprint_resourcestorages_orgthemeresourcestorage(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blueprint_ResourceStorages_OrgThemeResourceStorage {
	mut obj := &Class_Automattic_WooCommerce_Blueprint_ResourceStorages_OrgThemeResourceStorage{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blueprint_importers_importinstalltheme(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blueprint_Importers_ImportInstallTheme {
	mut obj := &Class_Automattic_WooCommerce_Blueprint_Importers_ImportInstallTheme{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_BuiltInStepProcessors) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'get_all' {
			return this.get_all()
		}
		'create_install_plugins_processor' {
			return this.create_install_plugins_processor()
		}
		'create_install_themes_processor' {
			return this.create_install_themes_processor()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Blueprint_BuiltInStepProcessors) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_BuiltInStepProcessors) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_Importers_ImportSetSiteOptions) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blueprint_Importers_ImportSetSiteOptions) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_Importers_ImportSetSiteOptions) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_Importers_ImportActivatePlugin) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blueprint_Importers_ImportActivatePlugin) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_Importers_ImportActivatePlugin) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_Importers_ImportActivateTheme) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blueprint_Importers_ImportActivateTheme) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_Importers_ImportActivateTheme) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_Importers_ImportRunSql) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blueprint_Importers_ImportRunSql) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_Importers_ImportRunSql) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_ResourceStorages) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blueprint_ResourceStorages) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_ResourceStorages) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_ResourceStorages_OrgPluginResourceStorage) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blueprint_ResourceStorages_OrgPluginResourceStorage) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_ResourceStorages_OrgPluginResourceStorage) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_Importers_ImportInstallPlugin) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blueprint_Importers_ImportInstallPlugin) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_Importers_ImportInstallPlugin) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_ResourceStorages_OrgThemeResourceStorage) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blueprint_ResourceStorages_OrgThemeResourceStorage) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_ResourceStorages_OrgThemeResourceStorage) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_Importers_ImportInstallTheme) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blueprint_Importers_ImportInstallTheme) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_Importers_ImportInstallTheme) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
