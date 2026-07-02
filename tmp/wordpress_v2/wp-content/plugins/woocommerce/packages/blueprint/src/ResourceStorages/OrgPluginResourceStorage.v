import rt

struct Class_Automattic_WooCommerce_Blueprint_ResourceStorages_OrgPluginResourceStorage {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_ResourceStorages_OrgPluginResourceStorage) download(var_slug rt.PhpVal) string {
	mut var_download_link := rt.new_string(this.get_download_link(var_slug.clone()))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_download_link)))) {
		return false
	}
	mut var_result := this.download_url(var_download_link.clone())
	if rt.is_true(rt.call_function('is_wp_error', [var_result.clone()])) {
		return false
	}
	return var_result.str()
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_ResourceStorages_OrgPluginResourceStorage) download_url(var_url rt.PhpVal) rt.PhpVal {
	return this.wp_download_url(var_url.clone())
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_ResourceStorages_OrgPluginResourceStorage) get_download_link(var_slug rt.PhpVal) string {
	mut var_info := this.wp_plugins_api(rt.new_string('plugin_information'), rt.create_array([
		rt.ArrayItem{ key: 'slug', val: var_slug },
		rt.ArrayItem{ key: 'fields', val: rt.create_array([
			rt.ArrayItem{ key: 'sections', val: false },
		]) },
	]))
	if rt.is_true(rt.call_function('is_wp_error', [var_info.clone()])) {
		return (rt.new_null()).str()
	}
	if var_info.clone().is_object() && !(rt.get_property(var_info, 'download_link')).is_null() {
		return (rt.get_property(var_info, 'download_link')).str()
	}
	return (rt.new_null()).str()
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_ResourceStorages_OrgPluginResourceStorage) get_supported_resource() string {
	return 'wordpress.org/plugins'
}

fn create_automattic_woocommerce_blueprint_resourcestorages_orgpluginresourcestorage(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blueprint_ResourceStorages_OrgPluginResourceStorage {
	mut obj := &Class_Automattic_WooCommerce_Blueprint_ResourceStorages_OrgPluginResourceStorage{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_ResourceStorages_OrgPluginResourceStorage) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'download' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.download(dispatch_arg_0))
		}
		'download_url' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.download_url(dispatch_arg_0)
		}
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

fn (this &Class_Automattic_WooCommerce_Blueprint_ResourceStorages_OrgPluginResourceStorage) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_ResourceStorages_OrgPluginResourceStorage) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
