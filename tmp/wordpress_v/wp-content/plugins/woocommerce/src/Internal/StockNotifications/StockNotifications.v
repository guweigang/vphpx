import rt

struct Class_Automattic_WooCommerce_Internal_StockNotifications_StockNotifications {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_StockNotifications) construct() {
	rt.call_function('add_action', [rt.new_string('plugins_loaded'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_StockNotifications_StockNotifications',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'init_hooks' },
		])])
	rt.call_function('add_action', [rt.new_string('woocommerce_installed'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_StockNotifications_StockNotifications',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'on_install_or_update' },
		])])
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_StockNotifications) on_install_or_update() {
	rt.call_method(rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [
		Class_Automattic_WooCommerce_Internal_StockNotifications_DataRetentionController.class(),
	]), 'on_woo_install_or_update', []rt.PhpVal{})
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_StockNotifications) init_hooks() {
	rt.call_function('add_filter', [rt.new_string('woocommerce_data_stores'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_StockNotifications_StockNotifications',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'register_data_stores' },
		])])
	mut var_container := rt.call_function('wc_get_container', []rt.PhpVal{})
	rt.call_method(var_container, 'get', [
		Class_Automattic_WooCommerce_Internal_StockNotifications_Emails_EmailManager.class(),
	])
	rt.call_method(var_container, 'get', [
		Class_Automattic_WooCommerce_Internal_StockNotifications_StockSyncController.class(),
	])
	rt.call_method(var_container, 'get', [
		Class_Automattic_WooCommerce_Internal_StockNotifications_AsyncTasks_NotificationsProcessor.class(),
	])
	rt.call_method(var_container, 'get', [
		Class_Automattic_WooCommerce_Internal_StockNotifications_Privacy_PrivacyEraser.class(),
	])
	rt.call_method(var_container, 'get', [
		Class_Automattic_WooCommerce_Internal_StockNotifications_DataRetentionController.class(),
	])
	rt.call_method(var_container, 'get', [
		Class_Automattic_WooCommerce_Internal_StockNotifications_Emails_EmailActionController.class(),
	])
	rt.call_method(var_container, 'get', [
		Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_ProductPageIntegration.class(),
	])
	rt.call_method(var_container, 'get', [
		Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_FormHandlerService.class(),
	])
	if rt.is_true(rt.call_function('is_admin', []rt.PhpVal{})) {
		rt.call_method(var_container, 'get', [
			Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_AdminManager.class(),
		])
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_StockNotifications) register_data_stores(var_data_stores rt.PhpVal) rt.PhpVal {
	mut var_data_stores_mutated := var_data_stores
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_data_stores_mutated.dup().is_array()))))) {
		return var_data_stores_mutated.dup()
	}
	var_data_stores_mutated.array_set('stock_notification', rt.call_method(rt.call_function('wc_get_container',
		[]rt.PhpVal{}), 'get', [
		Class_Automattic_WooCommerce_Internal_DataStores_StockNotifications_StockNotificationsDataStore.class(),
	]))
	return var_data_stores_mutated.dup()
}

fn create_automattic_woocommerce_internal_stocknotifications_stocknotifications() &Class_Automattic_WooCommerce_Internal_StockNotifications_StockNotifications {
	mut obj := &Class_Automattic_WooCommerce_Internal_StockNotifications_StockNotifications{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	obj.construct()
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_StockNotifications) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'on_install_or_update' {
			this.on_install_or_update()
			return rt.new_null()
		}
		'init_hooks' {
			this.init_hooks()
			return rt.new_null()
		}
		'register_data_stores' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.register_data_stores(dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_StockNotifications_StockNotifications) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_StockNotifications) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_content_plugins_woocommerce_src_internal_stocknotifications_stocknotifications_php() {
	// unsupported statement: Stmt_Declare
}
