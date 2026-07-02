import rt

struct Class_Automattic_WooCommerce_Internal_Admin_WCAdminSharedSettings {
	rt.PhpObjectBase
pub mut:
	settings_prefix rt.PhpVal = rt.new_string('admin')
}

fn init_static_automattic_woocommerce_internal_admin_wcadminsharedsettings() {
	rt.init_static_prop('Automattic_WooCommerce_Internal_Admin_WCAdminSharedSettings', 'instance',
		rt.new_null())
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_WCAdminSharedSettings) construct() {
	if rt.is_true(rt.call_function('did_action', [
		rt.new_string('woocommerce_blocks_loaded'),
	]))
	{
		this.on_woocommerce_blocks_loaded()
	} else {
		rt.call_function('add_action', [rt.new_string('woocommerce_blocks_loaded'),
			rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_WCAdminSharedSettings',
					[]string{}, &this) },
				rt.ArrayItem{ key: none, val: 'on_woocommerce_blocks_loaded' },
			]),
			rt.new_int(10)])
	}
}

fn Class_Automattic_WooCommerce_Internal_Admin_WCAdminSharedSettings.get_instance() rt.PhpVal {
	if rt.is_true(rt.identical(rt.new_null(), rt.get_static_prop('Automattic_WooCommerce_Internal_Admin_WCAdminSharedSettings',
		'instance')))
	{
		rt.set_static_prop('Automattic_WooCommerce_Internal_Admin_WCAdminSharedSettings',
			'instance', rt.new_object('Automattic_WooCommerce_Internal_Admin_self', []string{},
			create_automattic_woocommerce_internal_admin_self()))
	}
	return rt.get_static_prop('Automattic_WooCommerce_Internal_Admin_WCAdminSharedSettings',
		'instance')
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_WCAdminSharedSettings) on_woocommerce_blocks_loaded() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_admin', []rt.PhpVal{}))))) {
		return
	}
	if rt.is_true(rt.call_function('class_exists', [
		rt.new_string('\\Automattic\\WooCommerce\\Blocks\\Assets\\AssetDataRegistry'),
	]))
	{
		mut iife_temp_0 :=
			Class_Automattic_WooCommerce_Internal_Admin_Automattic_WooCommerce_Blocks_Package{}
		mut iife_result_0 := iife_temp_0.container()
		closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			return
		}
		rt.call_method(rt.call_method(iife_result_0, 'get', [
			Class_Automattic_WooCommerce_Internal_Admin_Automattic_WooCommerce_Blocks_Assets_AssetDataRegistry.class(),
		]), 'add', [this.settings_prefix, rt.new_closure(closure_2_fn)])
		closure_5_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut iife_temp_3 := Class_Automattic_WooCommerce_Admin_PageController{}
			mut iife_result_3 := iife_temp_3.is_admin_or_embed_page()
			if rt.is_true(rt.new_bool(!(rt.is_true(iife_result_3)))) {
				return
			}
			mut iife_temp_4 := Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets{}
			mut iife_result_4 := iife_temp_4.register_script(rt.new_string('wp-admin-scripts'),
				rt.new_string('wcsettings-deprecation'), rt.new_bool(true))
			return rt.new_null()
		}
		rt.call_function('add_action', [rt.new_string('admin_enqueue_scripts'),
			rt.new_closure(closure_5_fn)])
	}
}

struct Class_Automattic_WooCommerce_Internal_Admin_self {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Admin_Automattic_WooCommerce_Blocks_Package {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_PageController {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_admin_wcadminsharedsettings() &Class_Automattic_WooCommerce_Internal_Admin_WCAdminSharedSettings {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_WCAdminSharedSettings{
		PhpObjectBase:   rt.PhpObjectBase{}
		settings_prefix: rt.new_string('admin')
	}
	obj.construct()
	return obj
}

fn create_automattic_woocommerce_internal_admin_self(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_self {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_self{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_automattic_woocommerce_blocks_package(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_Automattic_WooCommerce_Blocks_Package {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Automattic_WooCommerce_Blocks_Package{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_pagecontroller(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_PageController {
	mut obj := &Class_Automattic_WooCommerce_Admin_PageController{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_wcadminassets(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_WCAdminSharedSettings) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'get_instance' {
			return Class_Automattic_WooCommerce_Internal_Admin_WCAdminSharedSettings.get_instance()
		}
		'on_woocommerce_blocks_loaded' {
			this.on_woocommerce_blocks_loaded()
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_WCAdminSharedSettings) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'settings_prefix' { return this.settings_prefix }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_WCAdminSharedSettings) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'settings_prefix' {
			this.settings_prefix = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_self) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_self) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_self) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Automattic_WooCommerce_Blocks_Package) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Automattic_WooCommerce_Blocks_Package) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Automattic_WooCommerce_Blocks_Package) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Admin_PageController) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_PageController) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_PageController) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}
