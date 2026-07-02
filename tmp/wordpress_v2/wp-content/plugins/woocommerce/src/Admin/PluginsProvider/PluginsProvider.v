import rt

struct Class_Automattic_WooCommerce_Admin_PluginsProvider_PluginsProvider {
	rt.PhpObjectBase
}

fn init_static_automattic_woocommerce_admin_pluginsprovider_pluginsprovider() {
	rt.init_static_prop('Automattic_WooCommerce_Admin_PluginsProvider_PluginsProvider',
		'deactivated_plugin_slug', rt.new_string(''))
}

fn (mut this Class_Automattic_WooCommerce_Admin_PluginsProvider_PluginsProvider) get_active_plugin_slugs() rt.PhpVal {
	mut iife_temp_0 := Class_Automattic_WooCommerce_Admin_PluginsHelper{}
	mut iife_result_0 := iife_temp_0.get_active_plugin_slugs()
	closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_p := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.new_bool(!rt.is_true(rt.identical(var_p, rt.get_static_prop('Automattic_WooCommerce_Admin_PluginsProvider_PluginsProvider',
			'deactivated_plugin_slug'))))
	}
	mut iife_temp_2 := Class_Automattic_WooCommerce_Admin_PluginsHelper{}
	mut iife_result_2 := iife_temp_2.get_active_plugin_slugs()
	return rt.call_function('array_filter', [iife_result_0, rt.new_closure(closure_2_fn)])
}

fn Class_Automattic_WooCommerce_Admin_PluginsProvider_PluginsProvider.set_deactivated_plugin(var_plugin_path rt.PhpVal) {
	rt.set_static_prop('Automattic_WooCommerce_Admin_PluginsProvider_PluginsProvider',
		'deactivated_plugin_slug', rt.call_function('explode', [
		rt.new_string('/'), var_plugin_path.clone()]).array_get(rt.new_int(0)))
}

fn (mut this Class_Automattic_WooCommerce_Admin_PluginsProvider_PluginsProvider) get_plugin_data(var_plugin rt.PhpVal) rt.PhpVal {
	mut iife_temp_3 := Class_Automattic_WooCommerce_Admin_PluginsHelper{}
	mut iife_result_3 := iife_temp_3.get_plugin_data(var_plugin.clone())
	return iife_result_3
}

fn (mut this Class_Automattic_WooCommerce_Admin_PluginsProvider_PluginsProvider) get_plugin_path_from_slug(var_slug rt.PhpVal) rt.PhpVal {
	mut iife_temp_4 := Class_Automattic_WooCommerce_Admin_PluginsHelper{}
	mut iife_result_4 := iife_temp_4.get_plugin_path_from_slug(var_slug.clone())
	return iife_result_4
}

struct Class_Automattic_WooCommerce_Admin_PluginsHelper {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_pluginsprovider_pluginsprovider(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_PluginsProvider_PluginsProvider {
	mut obj := &Class_Automattic_WooCommerce_Admin_PluginsProvider_PluginsProvider{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_pluginshelper(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_PluginsHelper {
	mut obj := &Class_Automattic_WooCommerce_Admin_PluginsHelper{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_PluginsProvider_PluginsProvider) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_active_plugin_slugs' {
			return this.get_active_plugin_slugs()
		}
		'set_deactivated_plugin' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			Class_Automattic_WooCommerce_Admin_PluginsProvider_PluginsProvider.set_deactivated_plugin(dispatch_arg_0)
			return rt.new_null()
		}
		'get_plugin_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_plugin_data(dispatch_arg_0)
		}
		'get_plugin_path_from_slug' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_plugin_path_from_slug(dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_PluginsProvider_PluginsProvider) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_PluginsProvider_PluginsProvider) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Admin_PluginsHelper) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_PluginsHelper) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_PluginsHelper) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}
