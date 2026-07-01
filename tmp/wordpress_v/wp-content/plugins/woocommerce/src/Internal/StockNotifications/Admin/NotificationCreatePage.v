import rt

struct Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_NotificationCreatePage {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_NotificationCreatePage) output() {
	this.process_create_form()
	rt.include_file(@DIR + '/Templates/html-admin-notification-create.php', '1')
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_NotificationCreatePage) process_create_form() {
	if !rt.is_true(rt.get_superglobal('_POST')) {
		return rt.new_null()
	}
	rt.call_function('check_admin_referer', [
		rt.new_string('woocommerce-customer-stock-notification-create'),
		rt.new_string('customer_stock_notification_create_security'),
	])
	if !(rt.get_superglobal('_POST').array_isset(rt.new_string('save'))) {
		return rt.new_null()
	}
	if !(rt.get_superglobal('_POST').array_isset(rt.new_string('product_id')))
		|| !rt.is_true(rt.get_superglobal('_POST').array_get('product_id')) {
		fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal {
			mut temp :=
				Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_NotificationsPage{}
			return temp.add_notice(arg_0, arg_1)
		}(rt.call_function('__', [rt.new_string('Please select a product.'),
			rt.new_string('woocommerce')]), rt.new_string('error'))
		return rt.new_null()
	}
	if !rt.is_true(rt.get_superglobal('_POST').array_get('user_id'))
		&& !rt.is_true(rt.get_superglobal('_POST').array_get('user_email')) {
		fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal {
			mut temp :=
				Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_NotificationsPage{}
			return temp.add_notice(arg_0, arg_1)
		}(rt.call_function('__', [rt.new_string('Please select a customer.'),
			rt.new_string('woocommerce')]), rt.new_string('error'))
		return rt.new_null()
	}
	mut var_posted_data := rt.new_array()
	var_posted_data.array_set('product_id', rt.call_function('absint', [
		rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get('product_id')]),
	]))
	if rt.get_superglobal('_POST').array_isset(rt.new_string('user_id'))
		&& !(!rt.is_true(rt.get_superglobal('_POST').array_get('user_id'))) {
		var_posted_data.array_set('user_id', rt.call_function('absint', [
			rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get('user_id')]),
		]))
		if rt.is_true(rt.identical(rt.new_int(0), var_posted_data.array_get('user_id'))) {
			fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal {
				mut temp :=
					Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_NotificationsPage{}
				return temp.add_notice(arg_0, arg_1)
			}(rt.call_function('__', [rt.new_string('Please select a customer.'),
				rt.new_string('woocommerce')]), rt.new_string('error'))
			return rt.new_null()
		}
		mut var_user := rt.call_function('get_user_by', [rt.new_string('id'),
			var_posted_data.array_get('user_id')])
		var_posted_data.array_set('user_email', if rt.is_true(rt.call_function('is_a', [
			var_user.dup(),
			rt.new_string('WP_User'),
		]))
		{ rt.get_property(var_user, 'user_email') } else { rt.new_string('') })
	} else if rt.get_superglobal('_POST').array_isset(rt.new_string('user_email'))
		&& !(!rt.is_true(rt.get_superglobal('_POST').array_get('user_email'))) {
		var_posted_data.array_set('user_email', rt.call_function('sanitize_text_field', [
			rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get('user_email')]),
		]))
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('filter_var', [
			var_posted_data.array_get('user_email'),
			rt.get_constant('FILTER_VALIDATE_EMAIL'),
		])))))
		{
			fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal {
				mut temp :=
					Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_NotificationsPage{}
				return temp.add_notice(arg_0, arg_1)
			}(rt.call_function('__', [
				rt.new_string('Please enter a valid email address.'),
				rt.new_string('woocommerce'),
			]), rt.new_string('error'))
			return rt.new_null()
		}
		var_user = rt.call_function('get_user_by', [rt.new_string('email'),
			var_posted_data.array_get('user_email')])
		var_posted_data.array_set('user_id', if rt.is_true(rt.call_function('is_a', [
			var_user.dup(),
			rt.new_string('WP_User'),
		]))
		{ rt.get_property(var_user, 'ID') } else { rt.new_int(0) })
	}
	mut var_notification_ids := rt.call_method(fn (arg_0 rt.PhpVal) rt.PhpVal {
		mut temp := Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_WC_Data_Store{}
		return temp.load(arg_0)
	}(rt.new_string('stock_notification')), 'query', [var_posted_data.dup()])
	if var_notification_ids.dup().array_count() > 0 {
		mut var_notice_message := rt.call_function('sprintf', [
			rt.call_function('__', [
				rt.new_string('A <a href="%s">notification</a> for the same product and customer already exists in your database.'),
				rt.new_string('woocommerce'),
			]),
			rt.call_function('admin_url', [
					(Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_NotificationsPage.page_url()).str() +
					'&notification_action=edit&notification_id=' +
					(var_notification_ids.array_get(0)).str(),
			]),
		])
		fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal {
			mut temp :=
				Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_NotificationsPage{}
			return temp.add_notice(arg_0, arg_1)
		}(var_notice_message.dup(), rt.new_string('error'))
		return rt.new_null()
	}
	mut var_notification := create_automattic_woocommerce_internal_stocknotifications_notification()
	var_notification.set_status(Class_Automattic_WooCommerce_Internal_StockNotifications_Enums_NotificationStatus.active())
	var_notification.set_product_id(var_posted_data.array_get('product_id'))
	var_notification.set_user_id(var_posted_data.array_get('user_id'))
	var_notification.set_user_email(var_posted_data.array_get('user_email'))
	mut var_result := var_notification.save()
	if rt.is_true(rt.call_function('is_wp_error', [var_result.dup()])) {
		var_notice_message = rt.call_method(var_result, 'get_error_message', []rt.PhpVal{})
		fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal {
			mut temp :=
				Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_NotificationsPage{}
			return temp.add_notice(arg_0, arg_1)
		}(var_notice_message.dup(), rt.new_string('error'))
		return rt.new_null()
	} else {
		var_notice_message = rt.call_function('__', [
			rt.new_string('Notification created.'),
			rt.new_string('woocommerce'),
		])
		fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal {
			mut temp :=
				Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_NotificationsPage{}
			return temp.add_notice(arg_0, arg_1)
		}(var_notice_message.dup(), rt.new_string('success'))
		mut var_edit_url := rt.call_function('add_query_arg', [
			rt.create_array([rt.ArrayItem{ key: 'notification_action', val: 'edit' },
				rt.ArrayItem{ key: 'notification_id', val: var_notification.get_id() }]),
			Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_NotificationsPage.page_url(),
		])
		rt.call_function('wp_safe_redirect', [var_edit_url.dup()])
		// unsupported expression: Expr_Exit
	}
}

struct Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_NotificationsPage {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_WC_Data_Store {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_StockNotifications_Notification {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_stocknotifications_admin_notificationcreatepage() &Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_NotificationCreatePage {
	mut obj := &Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_NotificationCreatePage{
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

fn create_automattic_woocommerce_internal_stocknotifications_admin_wc_data_store() &Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_WC_Data_Store {
	mut obj := &Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_WC_Data_Store{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_stocknotifications_notification() &Class_Automattic_WooCommerce_Internal_StockNotifications_Notification {
	mut obj := &Class_Automattic_WooCommerce_Internal_StockNotifications_Notification{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_NotificationCreatePage) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'output' {
			this.output()
			return rt.new_null()
		}
		'process_create_form' {
			this.process_create_form()
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_NotificationCreatePage) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_NotificationCreatePage) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_WC_Data_Store) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_WC_Data_Store) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_WC_Data_Store) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Notification) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_StockNotifications_Notification) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Notification) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_content_plugins_woocommerce_src_internal_stocknotifications_admin_notificationcreatepage_php() {
	// unsupported statement: Stmt_Declare
}
