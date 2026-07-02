import rt

pub fn Class_Automattic_WooCommerce_Internal_Admin_RemoteFreeExtensions_RemoteFreeExtensionsDataSourcePoller.id() string {
	return 'remote_free_extensions'
}

pub fn Class_Automattic_WooCommerce_Internal_Admin_RemoteFreeExtensions_RemoteFreeExtensionsDataSourcePoller.data_sources() rt.PhpVal {
	return rt.new_array()
}

struct Class_Automattic_WooCommerce_Internal_Admin_RemoteFreeExtensions_RemoteFreeExtensionsDataSourcePoller {
	rt.PhpObjectBase
}

fn init_static_automattic_woocommerce_internal_admin_remotefreeextensions_remotefreeextensionsdatasourcepoller() {
	rt.init_static_prop('Automattic_WooCommerce_Internal_Admin_RemoteFreeExtensions_RemoteFreeExtensionsDataSourcePoller',
		'instance', rt.new_null())
}

fn Class_Automattic_WooCommerce_Internal_Admin_RemoteFreeExtensions_RemoteFreeExtensionsDataSourcePoller.get_instance() rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.get_static_prop('Automattic_WooCommerce_Internal_Admin_RemoteFreeExtensions_RemoteFreeExtensionsDataSourcePoller',
		'instance')))))
	{
		rt.set_static_prop('Automattic_WooCommerce_Internal_Admin_RemoteFreeExtensions_RemoteFreeExtensionsDataSourcePoller',
			'instance', rt.new_object('Automattic_WooCommerce_Internal_Admin_RemoteFreeExtensions_self',
			[]string{}, create_automattic_woocommerce_internal_admin_remotefreeextensions_self(Class_Automattic_WooCommerce_Internal_Admin_RemoteFreeExtensions_Automattic_WooCommerce_Internal_Admin_RemoteFreeExtensions_RemoteFreeExtensionsDataSourcePoller.id(),
			Class_Automattic_WooCommerce_Internal_Admin_RemoteFreeExtensions_RemoteFreeExtensionsDataSourcePoller.get_data_sources(), rt.create_array([
			rt.ArrayItem{ key: 'spec_key', val: 'key' },
		]))))
	}
	return rt.get_static_prop('Automattic_WooCommerce_Internal_Admin_RemoteFreeExtensions_RemoteFreeExtensionsDataSourcePoller',
		'instance')
}

fn Class_Automattic_WooCommerce_Internal_Admin_RemoteFreeExtensions_RemoteFreeExtensionsDataSourcePoller.get_data_sources() rt.PhpVal {
	mut iife_temp_0 := Class_WC_Helper{}
	mut iife_result_0 := iife_temp_0.get_woocommerce_com_base_url()
	return rt.create_array([
		rt.ArrayItem{ key: none, val: iife_result_0.str() +
			'wp-json/wccom/obw-free-extensions/4.0/extensions.json' },
	])
}

struct Class_Automattic_WooCommerce_Admin_RemoteSpecs_DataSourcePoller {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Admin_RemoteFreeExtensions_self {
	rt.PhpObjectBase
}

struct Class_WC_Helper {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_admin_remotefreeextensions_remotefreeextensionsdatasourcepoller(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_RemoteFreeExtensions_RemoteFreeExtensionsDataSourcePoller {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_RemoteFreeExtensions_RemoteFreeExtensionsDataSourcePoller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_remotespecs_datasourcepoller(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_RemoteSpecs_DataSourcePoller {
	mut obj := &Class_Automattic_WooCommerce_Admin_RemoteSpecs_DataSourcePoller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_remotefreeextensions_self(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_RemoteFreeExtensions_self {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_RemoteFreeExtensions_self{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_helper(_args ...rt.PhpVal) &Class_WC_Helper {
	mut obj := &Class_WC_Helper{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_RemoteFreeExtensions_RemoteFreeExtensionsDataSourcePoller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_instance' {
			return Class_Automattic_WooCommerce_Internal_Admin_RemoteFreeExtensions_RemoteFreeExtensionsDataSourcePoller.get_instance()
		}
		'get_data_sources' {
			return Class_Automattic_WooCommerce_Internal_Admin_RemoteFreeExtensions_RemoteFreeExtensionsDataSourcePoller.get_data_sources()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_RemoteFreeExtensions_RemoteFreeExtensionsDataSourcePoller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_RemoteFreeExtensions_RemoteFreeExtensionsDataSourcePoller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_DataSourcePoller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_RemoteSpecs_DataSourcePoller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_DataSourcePoller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_RemoteFreeExtensions_self) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_RemoteFreeExtensions_self) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_RemoteFreeExtensions_self) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_Helper) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Helper) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Helper) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
