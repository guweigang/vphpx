import rt

struct Class_Automattic_WooCommerce_Internal_StockNotifications_Privacy_PrivacyEraser {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Privacy_PrivacyEraser) construct() {
	this.Class_Automattic_WooCommerce_Internal_StockNotifications_Privacy_WC_Abstract_Privacy.construct()
	rt.call_function('add_action', [rt.new_string('init'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_StockNotifications_Privacy_PrivacyEraser', [
				'Automattic_WooCommerce_Internal_StockNotifications_Privacy_WC_Abstract_Privacy',
			], &this) },
			rt.ArrayItem{ key: none, val: 'register_erasers_exporters' },
		])])
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Privacy_PrivacyEraser) register_erasers_exporters() {
	this.add_eraser(rt.new_string('woocommerce-customer-stock-notifications'), rt.call_function('__', [
		rt.new_string('WooCommerce Customer Stock Notifications'),
		rt.new_string('woocommerce'),
	]), rt.create_array([
		rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_StockNotifications_Privacy_PrivacyEraser', [
			'Automattic_WooCommerce_Internal_StockNotifications_Privacy_WC_Abstract_Privacy',
		], &this) },
		rt.ArrayItem{ key: none, val: 'erase_notification_data' },
	]))
}

fn Class_Automattic_WooCommerce_Internal_StockNotifications_Privacy_PrivacyEraser.erase_notification_data(email_address string) rt.PhpVal {
	mut var_response := rt.create_array([
		rt.ArrayItem{ key: 'items_removed', val: false },
		rt.ArrayItem{ key: 'items_retained', val: false },
		rt.ArrayItem{ key: 'messages', val: rt.new_array() },
		rt.ArrayItem{ key: 'done', val: true },
	])
	mut iife_temp_0 := Class_Automattic_WooCommerce_Internal_StockNotifications_NotificationQuery{}
	mut iife_result_0 := iife_temp_0.get_notifications(rt.create_array([
		rt.ArrayItem{ key: 'user_email', val: email_address },
	]))
	mut var_notifications := iife_result_0
	mut iter_1 := var_notifications.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_notification_id := item_1.val
		mut iife_temp_1 := Class_Automattic_WooCommerce_Internal_StockNotifications_Factory{}
		mut iife_result_1 := iife_temp_1.get_notification(var_notification_id.clone())
		mut var_notification := iife_result_1
		mut var_anonymous_email := rt.call_function('wp_privacy_anonymize_data', [
			rt.new_string('email'),
			rt.new_string(email_address),
		])
		rt.call_method(var_notification, 'set_user_email', [var_anonymous_email.clone()])
		rt.call_method(var_notification, 'set_user_id', [rt.new_int(0)])
		rt.call_method(var_notification, 'set_status', [
			Class_Automattic_WooCommerce_Internal_StockNotifications_Enums_NotificationStatus.cancelled(),
		])
		rt.call_method(var_notification, 'set_cancellation_source', [
			Class_Automattic_WooCommerce_Internal_StockNotifications_Enums_NotificationCancellationSource.user(),
		])
		rt.call_method(var_notification, 'set_date_cancelled', [
			rt.call_function('current_time', [rt.new_string('mysql')]),
		])
		rt.call_method(var_notification, 'update_meta_data', [
			rt.new_string('_anonymized'),
			rt.new_string('yes'),
		])
		rt.call_method(var_notification, 'update_meta_data', [
			rt.new_string('email_link_action_key'),
			rt.new_string(''),
		])
		rt.call_method(var_notification, 'save', []rt.PhpVal{})
		var_response.array_get_mut('messages').array_push(rt.call_function('sprintf', [
			rt.call_function('__', [
				rt.new_string('Removed back-in-stock notification for product id: %d'),
				rt.new_string('woocommerce'),
			]),
			rt.call_method(var_notification, 'get_product_id', []rt.PhpVal{}),
		]))
		var_response.array_set('items_removed', true)
	}
	return var_response.clone()
}

struct Class_Automattic_WooCommerce_Internal_StockNotifications_Privacy_WC_Abstract_Privacy {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_StockNotifications_NotificationQuery {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_StockNotifications_Factory {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_stocknotifications_privacy_privacyeraser() &Class_Automattic_WooCommerce_Internal_StockNotifications_Privacy_PrivacyEraser {
	mut obj := &Class_Automattic_WooCommerce_Internal_StockNotifications_Privacy_PrivacyEraser{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	obj.construct()
	return obj
}

fn create_automattic_woocommerce_internal_stocknotifications_privacy_wc_abstract_privacy(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_StockNotifications_Privacy_WC_Abstract_Privacy {
	mut obj := &Class_Automattic_WooCommerce_Internal_StockNotifications_Privacy_WC_Abstract_Privacy{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_stocknotifications_notificationquery(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_StockNotifications_NotificationQuery {
	mut obj := &Class_Automattic_WooCommerce_Internal_StockNotifications_NotificationQuery{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_stocknotifications_factory(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_StockNotifications_Factory {
	mut obj := &Class_Automattic_WooCommerce_Internal_StockNotifications_Factory{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Privacy_PrivacyEraser) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'register_erasers_exporters' {
			this.register_erasers_exporters()
			return rt.new_null()
		}
		'erase_notification_data' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return Class_Automattic_WooCommerce_Internal_StockNotifications_Privacy_PrivacyEraser.erase_notification_data(dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_StockNotifications_Privacy_PrivacyEraser) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Privacy_PrivacyEraser) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Privacy_WC_Abstract_Privacy) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_StockNotifications_Privacy_WC_Abstract_Privacy) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Privacy_WC_Abstract_Privacy) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_NotificationQuery) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_StockNotifications_NotificationQuery) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_NotificationQuery) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Factory) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_StockNotifications_Factory) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Factory) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
