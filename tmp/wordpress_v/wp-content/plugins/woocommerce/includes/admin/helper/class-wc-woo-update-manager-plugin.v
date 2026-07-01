import rt

pub fn Class_WC_Woo_Update_Manager_Plugin.woo_update_manager_plugin_main_file() string {
	return 'woo-update-manager/woo-update-manager.php'
}

pub fn Class_WC_Woo_Update_Manager_Plugin.woo_update_manager_download_url() string {
	return 'https://woocommerce.com/product-download/woo-update-manager'
}

pub fn Class_WC_Woo_Update_Manager_Plugin.woo_update_manager_slug() string {
	return 'woo-update-manager'
}

struct Class_WC_Woo_Update_Manager_Plugin {
	rt.PhpObjectBase
}

fn Class_WC_Woo_Update_Manager_Plugin.load() {
	rt.call_function('add_action', [rt.new_string('admin_notices'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'show_woo_update_manager_install_notice' }])])
}

fn Class_WC_Woo_Update_Manager_Plugin.is_plugin_active() bool {
	return
		rt.is_true(rt.call_function('is_plugin_active_for_network', [Class_WC_Woo_Update_Manager_Plugin.woo_update_manager_plugin_main_file()]))
		|| rt.is_true(rt.call_function('is_plugin_active', [Class_WC_Woo_Update_Manager_Plugin.woo_update_manager_plugin_main_file()]))
}

fn Class_WC_Woo_Update_Manager_Plugin.is_plugin_installed() bool {
	return (rt.call_function('file_exists', [
		(rt.get_constant('WP_PLUGIN_DIR')).str() + '/' +
			Class_WC_Woo_Update_Manager_Plugin.woo_update_manager_plugin_main_file(),
	])).to_bool()
}

fn Class_WC_Woo_Update_Manager_Plugin.generate_install_url() string {
	mut var_install_url := rt.new_string((fn () rt.PhpVal {
		mut temp := Class_WC_Helper{}
		return temp.get_install_base_url()
	}()).str() + Class_WC_Woo_Update_Manager_Plugin.woo_update_manager_slug() + '/')
	return (fn (arg_0 rt.PhpVal) rt.PhpVal {
		mut temp := Class_WC_Helper_API{}
		return temp.add_auth_parameters(arg_0)
	}(var_install_url.dup())).str()
}

fn Class_WC_Woo_Update_Manager_Plugin.get_plugin_slug() string {
	return Class_WC_Woo_Update_Manager_Plugin.woo_update_manager_slug()
}

fn Class_WC_Woo_Update_Manager_Plugin.show_woo_update_manager_install_notice() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('install_plugins'),
	])))))
	{
		return rt.new_null()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(fn () rt.PhpVal {
		mut temp := Class_WC_Helper{}
		return temp.is_site_connected()
	}()))))
	{
		return rt.new_null()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(fn () rt.PhpVal {
		mut temp := Class_Automattic_WooCommerce_Admin_PageController{}
		return temp.is_admin_or_embed_page()
	}()))))
	{
		return rt.new_null()
	}
	if rt.is_true(rt.new_bool(rt.is_true(Class_WC_Woo_Update_Manager_Plugin.is_plugin_installed())
		&& rt.is_true(Class_WC_Woo_Update_Manager_Plugin.is_plugin_active())))
	{
		return rt.new_null()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(Class_WC_Woo_Update_Manager_Plugin.is_plugin_installed())))) {
		if rt.is_true(Class_WC_Woo_Update_Manager_Plugin.install_admin_notice_dismissed()) {
			return rt.new_null()
		}
		rt.include_file(@DIR + '/views/html-notice-woo-updater-not-installed.php', '1')
		return rt.new_null()
	}
	if rt.is_true(Class_WC_Woo_Update_Manager_Plugin.activate_admin_notice_dismissed()) {
		return rt.new_null()
	}
	rt.include_file(@DIR + '/views/html-notice-woo-updater-not-activated.php', '1')
}

fn Class_WC_Woo_Update_Manager_Plugin.install_admin_notice_dismissed() bool {
	return (rt.call_function('get_user_meta', [
		rt.call_function('get_current_user_id', []rt.PhpVal{}),
		rt.new_string('dismissed_woo_updater_not_installed_notice'),
		rt.new_bool(true),
	])).to_bool()
}

fn Class_WC_Woo_Update_Manager_Plugin.activate_admin_notice_dismissed() bool {
	return (rt.call_function('get_user_meta', [
		rt.call_function('get_current_user_id', []rt.PhpVal{}),
		rt.new_string('dismissed_woo_updater_not_activated_notice'),
		rt.new_bool(true),
	])).to_bool()
}

struct Class_WC_Helper {
	rt.PhpObjectBase
}

struct Class_WC_Helper_API {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_PageController {
	rt.PhpObjectBase
}

fn create_wc_woo_update_manager_plugin() &Class_WC_Woo_Update_Manager_Plugin {
	mut obj := &Class_WC_Woo_Update_Manager_Plugin{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_helper() &Class_WC_Helper {
	mut obj := &Class_WC_Helper{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_helper_api() &Class_WC_Helper_API {
	mut obj := &Class_WC_Helper_API{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_pagecontroller() &Class_Automattic_WooCommerce_Admin_PageController {
	mut obj := &Class_Automattic_WooCommerce_Admin_PageController{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Woo_Update_Manager_Plugin) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'load' {
			Class_WC_Woo_Update_Manager_Plugin.load()
			return rt.new_null()
		}
		'is_plugin_active' {
			return rt.new_bool(Class_WC_Woo_Update_Manager_Plugin.is_plugin_active())
		}
		'is_plugin_installed' {
			return rt.new_bool(Class_WC_Woo_Update_Manager_Plugin.is_plugin_installed())
		}
		'generate_install_url' {
			return rt.new_string(Class_WC_Woo_Update_Manager_Plugin.generate_install_url())
		}
		'get_plugin_slug' {
			return rt.new_string(Class_WC_Woo_Update_Manager_Plugin.get_plugin_slug())
		}
		'show_woo_update_manager_install_notice' {
			Class_WC_Woo_Update_Manager_Plugin.show_woo_update_manager_install_notice()
			return rt.new_null()
		}
		'install_admin_notice_dismissed' {
			return rt.new_bool(Class_WC_Woo_Update_Manager_Plugin.install_admin_notice_dismissed())
		}
		'activate_admin_notice_dismissed' {
			return rt.new_bool(Class_WC_Woo_Update_Manager_Plugin.activate_admin_notice_dismissed())
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_Woo_Update_Manager_Plugin) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Woo_Update_Manager_Plugin) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_WC_Helper_API) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Helper_API) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Helper_API) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

pub fn init_wp_content_plugins_woocommerce_includes_admin_helper_class_wc_woo_update_manager_plugin_php() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		// unsupported expression: Expr_Exit
	}
	Class_WC_Woo_Update_Manager_Plugin.load()
}
