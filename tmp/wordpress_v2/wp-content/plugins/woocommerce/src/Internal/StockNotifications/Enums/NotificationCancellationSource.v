import rt

pub fn Class_Automattic_WooCommerce_Internal_StockNotifications_Enums_NotificationCancellationSource.admin() string {
	return 'admin'
}

pub fn Class_Automattic_WooCommerce_Internal_StockNotifications_Enums_NotificationCancellationSource.user() string {
	return 'user'
}

pub fn Class_Automattic_WooCommerce_Internal_StockNotifications_Enums_NotificationCancellationSource.system() string {
	return 'system'
}

struct Class_Automattic_WooCommerce_Internal_StockNotifications_Enums_NotificationCancellationSource {
	rt.PhpObjectBase
}

fn Class_Automattic_WooCommerce_Internal_StockNotifications_Enums_NotificationCancellationSource.get_valid_cancellation_sources() rt.PhpVal {
	return rt.create_array([
		rt.ArrayItem{
			key: none
			val: Class_Automattic_WooCommerce_Internal_StockNotifications_Enums_Automattic_WooCommerce_Internal_StockNotifications_Enums_NotificationCancellationSource.admin()
		},
		rt.ArrayItem{
			key: none
			val: Class_Automattic_WooCommerce_Internal_StockNotifications_Enums_Automattic_WooCommerce_Internal_StockNotifications_Enums_NotificationCancellationSource.user()
		},
		rt.ArrayItem{
			key: none
			val: Class_Automattic_WooCommerce_Internal_StockNotifications_Enums_Automattic_WooCommerce_Internal_StockNotifications_Enums_NotificationCancellationSource.system()
		},
	])
}

fn create_automattic_woocommerce_internal_stocknotifications_enums_notificationcancellationsource(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_StockNotifications_Enums_NotificationCancellationSource {
	mut obj := &Class_Automattic_WooCommerce_Internal_StockNotifications_Enums_NotificationCancellationSource{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Enums_NotificationCancellationSource) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_valid_cancellation_sources' {
			return Class_Automattic_WooCommerce_Internal_StockNotifications_Enums_NotificationCancellationSource.get_valid_cancellation_sources()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_StockNotifications_Enums_NotificationCancellationSource) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Enums_NotificationCancellationSource) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
