import rt

struct Class_Automattic_WooCommerce_Blueprint_ResourceStorages_OrgThemeResourceStorage {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_ResourceStorages_OrgThemeResourceStorage) get_download_link(var_slug rt.PhpVal) string {
	mut var_info := this.wp_themes_api(rt.new_string('theme_information'), rt.create_array([
		rt.ArrayItem{ key: 'slug', val: var_slug },
		rt.ArrayItem{ key: 'fields', val: rt.create_array([
			rt.ArrayItem{ key: 'sections', val: false },
		]) },
	]))
	if rt.is_true(rt.call_function('is_wp_error', [var_info.dup()])) {
		return (rt.new_null()).str()
	}
	if !(rt.get_property(var_info, 'download_link')).is_null() {
		return (rt.get_property(var_info, 'download_link')).str()
	}
	return (rt.new_null()).str()
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_ResourceStorages_OrgThemeResourceStorage) get_supported_resource() string {
	return 'wordpress.org/themes'
}

struct Class_Automattic_WooCommerce_Blueprint_ResourceStorages_OrgPluginResourceStorage {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blueprint_resourcestorages_orgthemeresourcestorage() &Class_Automattic_WooCommerce_Blueprint_ResourceStorages_OrgThemeResourceStorage {
	mut obj := &Class_Automattic_WooCommerce_Blueprint_ResourceStorages_OrgThemeResourceStorage{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blueprint_resourcestorages_orgpluginresourcestorage() &Class_Automattic_WooCommerce_Blueprint_ResourceStorages_OrgPluginResourceStorage {
	mut obj := &Class_Automattic_WooCommerce_Blueprint_ResourceStorages_OrgPluginResourceStorage{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_ResourceStorages_OrgThemeResourceStorage) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_download_link' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.get_download_link(dispatch_arg_0))
		}
		'get_supported_resource' {
			return rt.new_string(this.get_supported_resource())
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Blueprint_ResourceStorages_OrgThemeResourceStorage) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_ResourceStorages_OrgThemeResourceStorage) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

pub fn init_wp_content_plugins_woocommerce_packages_blueprint_src_resourcestorages_orgthemeresourcestorage_php() {
}
