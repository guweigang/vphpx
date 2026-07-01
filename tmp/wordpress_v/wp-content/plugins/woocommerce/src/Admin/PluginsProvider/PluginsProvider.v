import rt

struct Class_Automattic_WooCommerce_Admin_PluginsProvider_PluginsProvider {
	rt.PhpObjectBase
pub mut:
		deactivated_plugin_slug rt.PhpVal = rt.new_string('')
}

fn (mut this Class_Automattic_WooCommerce_Admin_PluginsProvider_PluginsProvider) get_active_plugin_slugs() rt.PhpVal {
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_p := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return // unsupported expression: Expr_BinaryOp_NotIdentical
	}
	return rt.call_function('array_filter', [fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_PluginsHelper{}; return temp.get_active_plugin_slugs() }(), rt.new_closure(closure_1_fn)])
}

fn Class_Automattic_WooCommerce_Admin_PluginsProvider_PluginsProvider.set_deactivated_plugin(var_plugin_path rt.PhpVal)  {
	// unsupported assign target: Expr_StaticPropertyFetch
}

fn (mut this Class_Automattic_WooCommerce_Admin_PluginsProvider_PluginsProvider) get_plugin_data(var_plugin rt.PhpVal) rt.PhpVal {
	return fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_PluginsHelper{}; return temp.get_plugin_data(arg_0) }(var_plugin.dup())
}

fn (mut this Class_Automattic_WooCommerce_Admin_PluginsProvider_PluginsProvider) get_plugin_path_from_slug(var_slug rt.PhpVal) rt.PhpVal {
	return fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_PluginsHelper{}; return temp.get_plugin_path_from_slug(arg_0) }(var_slug.dup())
}

struct Class_Automattic_WooCommerce_Admin_PluginsHelper {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_pluginsprovider_pluginsprovider() &Class_Automattic_WooCommerce_Admin_PluginsProvider_PluginsProvider {
	mut obj := &Class_Automattic_WooCommerce_Admin_PluginsProvider_PluginsProvider{
		PhpObjectBase: rt.PhpObjectBase{}
		deactivated_plugin_slug: rt.new_string('')
	}
	return obj
}

fn create_automattic_woocommerce_admin_pluginshelper() &Class_Automattic_WooCommerce_Admin_PluginsHelper {
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
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_PluginsProvider_PluginsProvider) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'deactivated_plugin_slug' { return this.deactivated_plugin_slug }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_PluginsProvider_PluginsProvider) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'deactivated_plugin_slug' { this.deactivated_plugin_slug = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
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




pub fn init_wp_content_plugins_woocommerce_src_admin_pluginsprovider_pluginsprovider_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
