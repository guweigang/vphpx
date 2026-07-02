import rt

struct Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_MenusController {
	rt.PhpObjectBase
pub mut:
	notifications_page rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_MenusController) init(mut var_notifications_page Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_NotificationsPage) {
	this.notifications_page = var_notifications_page
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_MenusController) construct() {
	rt.call_function('add_action', [rt.new_string('admin_menu'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_StockNotifications_Admin_MenusController',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'add_menu' },
		]),
		rt.new_int(10)])
	rt.call_function('add_filter', [rt.new_string('woocommerce_screen_ids'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_StockNotifications_Admin_MenusController',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'add_screen_ids' },
		])])
	rt.call_function('add_filter', [rt.new_string('set-screen-option'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_StockNotifications_Admin_MenusController',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'set_screen_option' },
		]),
		rt.new_int(10), rt.new_int(3)])
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_MenusController) add_menu() bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('manage_woocommerce'),
	])))))
	{
		return false
	}
	mut var_dashboard_page := rt.call_function('add_submenu_page', [
		rt.new_string('woocommerce'),
		rt.call_function('__', [rt.new_string('Stock Notifications'),
			rt.new_string('woocommerce')]),
		rt.call_function('__', [rt.new_string('Notifications'),
			rt.new_string('woocommerce')]),
		rt.new_string('manage_woocommerce'),
		rt.new_string('wc-customer-stock-notifications'),
		rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_StockNotifications_Admin_MenusController',
			[]string{}, &this) }, rt.ArrayItem{ key: none, val: 'notifications_page' }]),
	])
	rt.call_function('add_action', [
		rt.new_string('load-${var_dashboard_page.to_string()}'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_StockNotifications_Admin_MenusController',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'add_screen_options' },
		]),
	])
	return false
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_MenusController) add_screen_options() {
	mut var_screen := rt.call_function('get_current_screen', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(rt.is_true(var_screen)))) {
		return
	}
	rt.call_function('add_screen_option', [rt.new_string('per_page'),
		rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('Notifications per page'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'default', val: 10 },
			rt.ArrayItem{ key: 'option', val: 'stock_notifications_per_page' },
		])])
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_MenusController) set_screen_option(var_status rt.PhpVal, var_option rt.PhpVal, var_value rt.PhpVal) i64 {
	if rt.is_true(rt.identical(rt.new_string('stock_notifications_per_page'), var_option)) {
		return rt.new_int(var_value.to_i64())
	}
	return var_status.to_i64()
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_MenusController) notifications_page() {
	mut var_action := if rt.get_superglobal('_GET').array_isset(rt.new_string('notification_action')) { rt.call_function('sanitize_text_field', [
			rt.call_function('wp_unslash', [
				rt.get_superglobal('_GET').array_get(rt.new_string('notification_action')),
			]),
		]) } else { rt.new_string('') }
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
		var_action.clone(),
		rt.create_array([rt.ArrayItem{ key: none, val: 'create' },
			rt.ArrayItem{ key: none, val: 'edit' }]),
		rt.new_bool(true)])))))
	{
		var_action = rt.new_string('')
	}
	mut switch_val_1 := var_action
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('create'))) {
		rt.call_method(this.notifications_page, 'create', []rt.PhpVal{})
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('edit'))) {
		rt.call_method(this.notifications_page, 'edit', []rt.PhpVal{})
	} else {
		rt.call_method(this.notifications_page, 'output', []rt.PhpVal{})
	}
}

fn Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_MenusController.add_screen_ids(var_screen_ids rt.PhpVal) rt.PhpVal {
	mut var_screen_ids_mutated := var_screen_ids
	var_screen_ids_mutated.array_push('woocommerce_page_wc-customer-stock-notifications')
	return var_screen_ids_mutated.clone()
}

fn create_automattic_woocommerce_internal_stocknotifications_admin_menuscontroller() &Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_MenusController {
	mut obj := &Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_MenusController{
		PhpObjectBase:      rt.PhpObjectBase{}
		notifications_page: rt.new_null()
	}
	obj.construct()
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_MenusController) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'init' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_NotificationsPage](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.init(mut dispatch_arg_0)
			return rt.new_null()
		}
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'add_menu' {
			return rt.new_bool(this.add_menu())
		}
		'add_screen_options' {
			this.add_screen_options()
			return rt.new_null()
		}
		'set_screen_option' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return rt.new_int(this.set_screen_option(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2))
		}
		'notifications_page' {
			this.notifications_page()
			return rt.new_null()
		}
		'add_screen_ids' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_MenusController.add_screen_ids(dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_MenusController) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'notifications_page' { return this.notifications_page }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_MenusController) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'notifications_page' {
			this.notifications_page = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn main() {
	defer {
		rt.shutdown()
	}
}
