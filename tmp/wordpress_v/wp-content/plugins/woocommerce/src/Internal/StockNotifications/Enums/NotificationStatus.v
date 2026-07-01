import rt

pub fn Class_Automattic_WooCommerce_Internal_StockNotifications_Enums_NotificationStatus.pending() string {
	return 'pending'
}

pub fn Class_Automattic_WooCommerce_Internal_StockNotifications_Enums_NotificationStatus.active() string {
	return 'active'
}

pub fn Class_Automattic_WooCommerce_Internal_StockNotifications_Enums_NotificationStatus.sent() string {
	return 'sent'
}

pub fn Class_Automattic_WooCommerce_Internal_StockNotifications_Enums_NotificationStatus.cancelled() string {
	return 'cancelled'
}

struct Class_Automattic_WooCommerce_Internal_StockNotifications_Enums_NotificationStatus {
	rt.PhpObjectBase
}

fn Class_Automattic_WooCommerce_Internal_StockNotifications_Enums_NotificationStatus.get_valid_statuses() rt.PhpVal {
	return rt.create_array([
		rt.ArrayItem{
			key: none
			val: Class_Automattic_WooCommerce_Internal_StockNotifications_Enums_Automattic_WooCommerce_Internal_StockNotifications_Enums_NotificationStatus.pending()
		},
		rt.ArrayItem{
			key: none
			val: Class_Automattic_WooCommerce_Internal_StockNotifications_Enums_Automattic_WooCommerce_Internal_StockNotifications_Enums_NotificationStatus.active()
		},
		rt.ArrayItem{
			key: none
			val: Class_Automattic_WooCommerce_Internal_StockNotifications_Enums_Automattic_WooCommerce_Internal_StockNotifications_Enums_NotificationStatus.sent()
		},
		rt.ArrayItem{
			key: none
			val: Class_Automattic_WooCommerce_Internal_StockNotifications_Enums_Automattic_WooCommerce_Internal_StockNotifications_Enums_NotificationStatus.cancelled()
		},
	])
}

fn create_automattic_woocommerce_internal_stocknotifications_enums_notificationstatus() &Class_Automattic_WooCommerce_Internal_StockNotifications_Enums_NotificationStatus {
	mut obj := &Class_Automattic_WooCommerce_Internal_StockNotifications_Enums_NotificationStatus{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Enums_NotificationStatus) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_valid_statuses' {
			return Class_Automattic_WooCommerce_Internal_StockNotifications_Enums_NotificationStatus.get_valid_statuses()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_StockNotifications_Enums_NotificationStatus) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Enums_NotificationStatus) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_content_plugins_woocommerce_src_internal_stocknotifications_enums_notificationstatus_php() {
	// unsupported statement: Stmt_Declare
}
