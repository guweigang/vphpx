import rt

struct Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_NotificationEditPage {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_NotificationEditPage) output() {
	mut var_table := create_automattic_woocommerce_internal_stocknotifications_admin_listtable()
	mut var_notification_id := if rt.get_superglobal('_GET').array_isset(rt.new_string('notification_id')) { rt.call_function('absint', [
			rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get('notification_id')]),
		]) } else { rt.new_int(0) }
	if rt.is_true(var_notification_id) {
		mut var_notification := fn (arg_0 rt.PhpVal) rt.PhpVal {
			mut temp := Class_Automattic_WooCommerce_Internal_StockNotifications_Factory{}
			return temp.get_notification(arg_0)
		}(var_notification_id.dup())
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_notification,
		'Automattic_WooCommerce_Internal_StockNotifications_Notification'))))))
	{
		mut var_notice_message := rt.call_function('__', [
			rt.new_string('Notification not found.'),
			rt.new_string('woocommerce'),
		])
		fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal {
			mut temp :=
				Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_NotificationsPage{}
			return temp.add_notice(arg_0, arg_1)
		}(var_notice_message.dup(), rt.new_string('error'))
		rt.call_function('wp_safe_redirect', [
			rt.call_function('admin_url', [
				Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_NotificationsPage.page_url(),
			]),
		])
		// unsupported expression: Expr_Exit
	}
	this.process_edit_form(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_StockNotifications_Notification](var_notification))
	var_table.process_delete_action()
	mut var_signed_up_customers := rt.call_method(rt.get_property(var_table, 'data_store'),
		'query', [
		rt.create_array([
			rt.ArrayItem{ key: 'product_id', val: rt.call_method(var_notification,
				'get_product_id', []rt.PhpVal{}) },
			rt.ArrayItem{ key: 'return', val: 'count' },
		]),
	])
	rt.include_file(@DIR + '/Templates/html-admin-notification-edit.php', '1')
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_NotificationEditPage) process_edit_form(mut var_notification Class_Automattic_WooCommerce_Internal_StockNotifications_Notification) {
	mut var_notification_mutated := var_notification
	if !rt.is_true(rt.get_superglobal('_POST'))
		|| !rt.is_true(rt.get_superglobal('_POST').array_get('wc_customer_stock_notification_action')) {
		return rt.new_null()
	}
	rt.call_function('check_admin_referer', [
		rt.new_string('woocommerce-customer-stock-notification-edit'),
		rt.new_string('customer_stock_notification_edit_security'),
	])
	mut var_action := rt.call_function('wc_clean', [
		rt.call_function('wp_unslash', [
			rt.get_superglobal('_POST').array_get('wc_customer_stock_notification_action'),
		]),
	])
	mut switch_val_1 := var_action
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('activate_notification'))) {
		rt.call_method(var_notification_mutated, 'set_status', [
			Class_Automattic_WooCommerce_Internal_StockNotifications_Enums_NotificationStatus.active(),
		])
		mut var_result := rt.call_method(var_notification_mutated, 'save', []rt.PhpVal{})
		if rt.is_true(rt.call_function('is_wp_error', [var_result.dup()])) {
			mut var_notice_message := rt.call_method(var_result, 'get_error_message', []rt.PhpVal{})
			fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal {
				mut temp :=
					Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_NotificationsPage{}
				return temp.add_notice(arg_0, arg_1)
			}(var_notice_message.dup(), rt.new_string('error'))
		} else {
			var_notice_message = rt.call_function('__', [
				rt.new_string('Notification updated.'),
				rt.new_string('woocommerce'),
			])
			fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal {
				mut temp :=
					Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_NotificationsPage{}
				return temp.add_notice(arg_0, arg_1)
			}(var_notice_message.dup(), rt.new_string('success'))
		}
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('cancel_notification'))) {
		rt.call_method(var_notification_mutated, 'set_status', [
			Class_Automattic_WooCommerce_Internal_StockNotifications_Enums_NotificationStatus.cancelled(),
		])
		rt.call_method(var_notification_mutated, 'set_date_cancelled', [
			rt.call_function('time', []rt.PhpVal{}),
		])
		rt.call_method(var_notification_mutated, 'set_date_notified', [
			Class_Automattic_WooCommerce_Internal_StockNotifications_Enums_NotificationCancellationSource.admin(),
		])
		var_result = rt.call_method(var_notification_mutated, 'save', []rt.PhpVal{})
		if rt.is_true(rt.call_function('is_wp_error', [var_result.dup()])) {
			var_notice_message = rt.call_method(var_result, 'get_error_message', []rt.PhpVal{})
			fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal {
				mut temp :=
					Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_NotificationsPage{}
				return temp.add_notice(arg_0, arg_1)
			}(var_notice_message.dup(), rt.new_string('error'))
		} else {
			var_notice_message = rt.call_function('__', [
				rt.new_string('Notification updated.'),
				rt.new_string('woocommerce'),
			])
			fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal {
				mut temp :=
					Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_NotificationsPage{}
				return temp.add_notice(arg_0, arg_1)
			}(var_notice_message.dup(), rt.new_string('success'))
		}
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('send_notification'))) {
		mut var_product := rt.call_method(var_notification_mutated, 'get_product', []rt.PhpVal{})
		if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_product))))
			|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_product, 'is_in_stock', []rt.PhpVal{})))))))
		{
			var_notice_message = rt.call_function('__', [
				rt.new_string('Failed to send notification. Please make sure that the listed product is available.'),
				rt.new_string('woocommerce'),
			])
			fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal {
				mut temp :=
					Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_NotificationsPage{}
				return temp.add_notice(arg_0, arg_1)
			}(var_notice_message.dup(), rt.new_string('error'))
		} else {
			mut var_email_manager :=
				create_automattic_woocommerce_internal_stocknotifications_emails_emailmanager()
			var_email_manager.send_stock_notification_email(rt.new_object('Automattic_WooCommerce_Internal_StockNotifications_Notification',
				[]string{}, var_notification_mutated))
			rt.call_method(var_notification_mutated, 'set_status', [
				Class_Automattic_WooCommerce_Internal_StockNotifications_Enums_NotificationStatus.sent(),
			])
			rt.call_method(var_notification_mutated, 'set_date_notified', [
				rt.call_function('time', []rt.PhpVal{}),
			])
			rt.call_method(var_notification_mutated, 'save', []rt.PhpVal{})
			var_notice_message = rt.call_function('sprintf', [
				rt.call_function('__', [rt.new_string('Notification sent to "%s".'),
					rt.new_string('woocommerce')]),
				rt.call_method(var_notification_mutated, 'get_user_email', []rt.PhpVal{}),
			])
			fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal {
				mut temp :=
					Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_NotificationsPage{}
				return temp.add_notice(arg_0, arg_1)
			}(var_notice_message.dup(), rt.new_string('success'))
		}
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('send_verification_email'))) {
		var_notice_message = rt.call_function('sprintf', [
			rt.call_function('__', [rt.new_string('Verification email sent to "%s".'),
				rt.new_string('woocommerce')]),
			rt.call_method(var_notification_mutated, 'get_user_email', []rt.PhpVal{}),
		])
		fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal {
			mut temp :=
				Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_NotificationsPage{}
			return temp.add_notice(arg_0, arg_1)
		}(var_notice_message.dup(), rt.new_string('success'))
	}
	mut var_edit_url := rt.call_function('add_query_arg', [
		rt.create_array([rt.ArrayItem{ key: 'notification_action', val: 'edit' },
			rt.ArrayItem{ key: 'notification_id', val: rt.call_method(var_notification_mutated,
				'get_id', []rt.PhpVal{}) }]),
		Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_NotificationsPage.page_url(),
	])
	rt.call_function('wp_safe_redirect', [var_edit_url.dup()])
	// unsupported expression: Expr_Exit
}

struct Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_ListTable {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_StockNotifications_Factory {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_NotificationsPage {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_StockNotifications_Emails_EmailManager {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_stocknotifications_admin_notificationeditpage() &Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_NotificationEditPage {
	mut obj := &Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_NotificationEditPage{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_stocknotifications_admin_listtable() &Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_ListTable {
	mut obj := &Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_ListTable{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_stocknotifications_factory() &Class_Automattic_WooCommerce_Internal_StockNotifications_Factory {
	mut obj := &Class_Automattic_WooCommerce_Internal_StockNotifications_Factory{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_stocknotifications_admin_notificationspage() &Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_NotificationsPage {
	mut obj := &Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_NotificationsPage{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_stocknotifications_emails_emailmanager() &Class_Automattic_WooCommerce_Internal_StockNotifications_Emails_EmailManager {
	mut obj := &Class_Automattic_WooCommerce_Internal_StockNotifications_Emails_EmailManager{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_NotificationEditPage) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'output' {
			this.output()
			return rt.new_null()
		}
		'process_edit_form' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_StockNotifications_Notification](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.process_edit_form(mut dispatch_arg_0)
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_NotificationEditPage) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_NotificationEditPage) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_ListTable) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_ListTable) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_ListTable) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_NotificationsPage) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_NotificationsPage) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_NotificationsPage) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Emails_EmailManager) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_StockNotifications_Emails_EmailManager) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Emails_EmailManager) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_content_plugins_woocommerce_src_internal_stocknotifications_admin_notificationeditpage_php() {
	// unsupported statement: Stmt_Declare
}
