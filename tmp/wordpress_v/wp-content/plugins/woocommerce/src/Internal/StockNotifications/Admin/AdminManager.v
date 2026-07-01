import rt

struct Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_AdminManager {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_AdminManager) construct()  {
	rt.call_function('add_action', [rt.new_string('admin_enqueue_scripts'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_StockNotifications_Admin_AdminManager', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'admin_resources' }]), rt.new_int(11)])
	mut var_container := rt.call_function('wc_get_container', []rt.PhpVal{})
	rt.call_method(var_container, 'get', [Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_MenusController.class()])
	rt.call_method(var_container, 'get', [Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_SettingsController.class()])
}

fn Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_AdminManager.admin_resources()  {
	mut var_screen := rt.call_function('get_current_screen', []rt.PhpVal{})
	mut var_screen_id := if rt.is_true(var_screen) { rt.get_property(var_screen, 'id') } else { rt.new_string('') }
	mut var_suffix := rt.new_string(if rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_Jetpack_Constants{}; return temp.is_true(arg_0) }(rt.new_string('SCRIPT_DEBUG'))) { rt.new_string('') } else { rt.new_string('.min') })
	mut var_version := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_Jetpack_Constants{}; return temp.get_constant(arg_0) }(rt.new_string('WC_VERSION'))
	rt.call_function('wp_register_script', [rt.new_string('wc-admin-customer-stock-notifications'), (rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'plugin_url', []rt.PhpVal{})).str() + '/assets/js/admin/wc-customer-stock-notifications' + (var_suffix).str() + '.js', rt.create_array([rt.ArrayItem{ key: none, val: 'jquery' }]), var_version.dup(), rt.new_bool(true)])
	mut var_params := rt.create_array([rt.ArrayItem{ key: 'i18n_wc_delete_notification_warning', val: rt.call_function('__', [rt.new_string('Delete this notification permanently?'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'i18n_wc_bulk_delete_notifications_warning', val: rt.call_function('__', [rt.new_string('Delete the selected notifications permanently?'), rt.new_string('woocommerce')]) }])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_screen_id.dup(), rt.create_array([rt.ArrayItem{ key: none, val: 'woocommerce_page_wc-customer-stock-notifications' }, rt.ArrayItem{ key: none, val: 'woocommerce_page_wc-settings' }]), rt.new_bool(true)]))))) {
		return rt.new_null()
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('woocommerce_page_wc-settings'), var_screen_id)) && rt.get_superglobal('_GET').array_isset(rt.new_string('section')))) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		return rt.new_null()
	}
	rt.call_function('wp_enqueue_script', [rt.new_string('wc-admin-customer-stock-notifications')])
	rt.call_function('wp_localize_script', [rt.new_string('wc-admin-customer-stock-notifications'), rt.new_string('wc_admin_customer_stock_notifications_params'), var_params.dup()])
}

struct Class_Automattic_Jetpack_Constants {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_stocknotifications_admin_adminmanager() &Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_AdminManager {
	mut obj := &Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_AdminManager{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	obj.construct()
	return obj
}

fn create_automattic_jetpack_constants() &Class_Automattic_Jetpack_Constants {
	mut obj := &Class_Automattic_Jetpack_Constants{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_AdminManager) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'admin_resources' {
			Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_AdminManager.admin_resources()
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_AdminManager) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_AdminManager) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_Jetpack_Constants) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_Jetpack_Constants) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_Jetpack_Constants) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_internal_stocknotifications_admin_adminmanager_php() {
	// unsupported statement: Stmt_Declare
}
