import rt

pub fn Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_NotificationsPage.page_url() string {
	return 'admin.php?page=wc-customer-stock-notifications'
}

pub fn Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_NotificationsPage.admin_notice_option_name() string {
	return 'wc_customer_stock_notifications_admin_notice'
}

struct Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_NotificationsPage {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_NotificationsPage) output() {
	mut var_table := rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [
		Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_ListTable.class(),
	])
	rt.call_method(var_table, 'process_actions', []rt.PhpVal{})
	this.output_admin_notice()
	rt.call_method(var_table, 'prepare_items', []rt.PhpVal{})
	rt.include_file(@DIR + '/Templates/html-admin-notifications.php', '1')
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_NotificationsPage) create() {
	mut var_create_page :=
		create_automattic_woocommerce_internal_stocknotifications_admin_notificationcreatepage()
	var_create_page.output()
	this.output_admin_notice()
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_NotificationsPage) edit() {
	mut var_edit_page :=
		create_automattic_woocommerce_internal_stocknotifications_admin_notificationeditpage()
	var_edit_page.output()
	this.output_admin_notice()
}

fn Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_NotificationsPage.add_notice(var_message rt.PhpVal, type string) {
	mut type_mutated := type
	if !rt.is_true(var_message) {
		return
	}
	mut var_notice_data := rt.call_function('get_option', [
		Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_Automattic_WooCommerce_Internal_StockNotifications_Admin_NotificationsPage.admin_notice_option_name(),
	])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_notice_data)))) {
		return
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
		rt.new_string(type_mutated).clone(),
		rt.create_array([
			rt.ArrayItem{ key: none, val: 'error' },
			rt.ArrayItem{ key: none, val: 'warning' },
			rt.ArrayItem{ key: none, val: 'success' },
			rt.ArrayItem{ key: none, val: 'info' },
		]),
		rt.new_bool(true)])))))
	{
		type_mutated = 'info'
	}
	var_notice_data = rt.create_array([rt.ArrayItem{ key: 'message', val: var_message },
		rt.ArrayItem{ key: 'type', val: type_mutated }])
	rt.call_function('update_option', [
		Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_Automattic_WooCommerce_Internal_StockNotifications_Admin_NotificationsPage.admin_notice_option_name(),
		var_notice_data.clone(),
	])
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_NotificationsPage) output_admin_notice() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('wp_admin_notice'),
	])))))
	{
		return
	}
	mut var_notice_data := rt.call_function('get_option', [
		Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_Automattic_WooCommerce_Internal_StockNotifications_Admin_NotificationsPage.admin_notice_option_name(),
	])
	if rt.is_true(rt.identical(rt.new_bool(false), var_notice_data)) {
		return
	}
	if !rt.is_true(var_notice_data) || !(var_notice_data.clone().is_array())
		|| !rt.is_true(var_notice_data.array_get(rt.new_string('message'))) {
		rt.call_function('delete_option', [
			Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_Automattic_WooCommerce_Internal_StockNotifications_Admin_NotificationsPage.admin_notice_option_name(),
		])
		return
	}
	mut var_type := if rt.is_true(rt.call_function('in_array', [
		var_notice_data.array_get(rt.new_string('type')),
		rt.create_array([rt.ArrayItem{ key: none, val: 'error' },
			rt.ArrayItem{ key: none, val: 'warning' }, rt.ArrayItem{ key: none, val: 'success' },
			rt.ArrayItem{ key: none, val: 'info' }]),
		rt.new_bool(true),
	]))
	{ var_notice_data.array_get(rt.new_string('type')) } else { rt.new_string('info') }
	rt.call_function('wp_admin_notice', [var_notice_data.array_get(rt.new_string('message')),
		rt.create_array([rt.ArrayItem{ key: 'type', val: var_type },
			rt.ArrayItem{
				key: 'id'
				val: Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_Automattic_WooCommerce_Internal_StockNotifications_Admin_NotificationsPage.admin_notice_option_name()
			}, rt.ArrayItem{ key: 'dismissible', val: false }])])
	rt.call_function('delete_option', [
		Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_Automattic_WooCommerce_Internal_StockNotifications_Admin_NotificationsPage.admin_notice_option_name(),
	])
}

struct Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_NotificationCreatePage {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_NotificationEditPage {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_stocknotifications_admin_notificationspage(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_NotificationsPage {
	mut obj := &Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_NotificationsPage{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_stocknotifications_admin_notificationcreatepage(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_NotificationCreatePage {
	mut obj := &Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_NotificationCreatePage{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_stocknotifications_admin_notificationeditpage(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_NotificationEditPage {
	mut obj := &Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_NotificationEditPage{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_NotificationsPage) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'output' {
			this.output()
			return rt.new_null()
		}
		'create' {
			this.create()
			return rt.new_null()
		}
		'edit' {
			this.edit()
			return rt.new_null()
		}
		'add_notice' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_NotificationsPage.add_notice(dispatch_arg_0,
				dispatch_arg_1)
			return rt.new_null()
		}
		'output_admin_notice' {
			this.output_admin_notice()
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_NotificationsPage) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_NotificationsPage) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_NotificationCreatePage) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_NotificationCreatePage) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_NotificationCreatePage) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_NotificationEditPage) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_NotificationEditPage) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_NotificationEditPage) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
