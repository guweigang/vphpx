import rt

struct Class_Automattic_WooCommerce_Blueprint_ResourceStorages_LocalThemeResourceStorage {
	rt.PhpObjectBase
pub mut:
	suffix rt.PhpVal = rt.new_string('themes')
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_ResourceStorages_LocalThemeResourceStorage) get_supported_resource() string {
	return 'self/themes'
}

struct Class_Automattic_WooCommerce_Blueprint_ResourceStorages_LocalPluginResourceStorage {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blueprint_resourcestorages_localthemeresourcestorage() &Class_Automattic_WooCommerce_Blueprint_ResourceStorages_LocalThemeResourceStorage {
	mut obj := &Class_Automattic_WooCommerce_Blueprint_ResourceStorages_LocalThemeResourceStorage{
		PhpObjectBase: rt.PhpObjectBase{}
		suffix:        rt.new_string('themes')
	}
	return obj
}

fn create_automattic_woocommerce_blueprint_resourcestorages_localpluginresourcestorage() &Class_Automattic_WooCommerce_Blueprint_ResourceStorages_LocalPluginResourceStorage {
	mut obj := &Class_Automattic_WooCommerce_Blueprint_ResourceStorages_LocalPluginResourceStorage{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_ResourceStorages_LocalThemeResourceStorage) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_supported_resource' {
			return rt.new_string(this.get_supported_resource())
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Blueprint_ResourceStorages_LocalThemeResourceStorage) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'suffix' { return this.suffix }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_ResourceStorages_LocalThemeResourceStorage) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'suffix' {
			this.suffix = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_ResourceStorages_LocalPluginResourceStorage) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blueprint_ResourceStorages_LocalPluginResourceStorage) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_ResourceStorages_LocalPluginResourceStorage) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_content_plugins_woocommerce_packages_blueprint_src_resourcestorages_localthemeresourcestorage_php() {
}
