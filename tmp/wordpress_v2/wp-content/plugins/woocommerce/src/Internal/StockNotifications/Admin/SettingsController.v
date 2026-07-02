import rt

struct Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_SettingsController {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_SettingsController) construct() {
	rt.call_function('add_filter', [rt.new_string('woocommerce_get_sections_products'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_StockNotifications_Admin_SettingsController',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'add_customer_stock_notifications_section' },
		]),
		rt.new_int(100), rt.new_int(1)])
	rt.call_function('add_filter', [rt.new_string('woocommerce_get_settings_products'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_StockNotifications_Admin_SettingsController',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'add_customer_stock_notifications_settings' },
		]),
		rt.new_int(100), rt.new_int(2)])
	rt.call_function('add_action', [rt.new_string('admin_notices'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_StockNotifications_Admin_SettingsController',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'output_admin_notices' },
		])])
	rt.call_function('add_action', [
		rt.new_string('woocommerce_product_options_stock_status'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_StockNotifications_Admin_SettingsController',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'add_disable_stock_notifications_checkbox' },
		]),
		rt.new_int(20),
	])
	rt.call_function('add_action', [
		rt.new_string('woocommerce_admin_process_product_object'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_StockNotifications_Admin_SettingsController',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'process_product_object' },
		]),
	])
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_SettingsController) add_customer_stock_notifications_section(var_sections rt.PhpVal) rt.PhpVal {
	mut var_sections_mutated := var_sections
	if !(var_sections_mutated.clone().is_array()) {
		return var_sections_mutated.clone()
	}
	mut var_section_title := rt.call_function('__', [
		rt.new_string('Customer stock notifications'),
		rt.new_string('woocommerce'),
	])
	mut var_inventory_index := rt.call_function('array_search', [
		rt.new_string('inventory'),
		rt.func_array_keys(var_sections_mutated.clone()),
		rt.new_bool(true),
	])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_inventory_index)))) {
		var_sections_mutated = rt.add(rt.add(rt.call_function('array_slice', [
			var_sections_mutated.clone(), rt.new_int(0), rt.add(var_inventory_index, rt.new_int(1)),
			rt.new_bool(true)]), rt.create_array([
			rt.ArrayItem{ key: 'customer_stock_notifications', val: var_section_title },
		])), rt.call_function('array_slice', [var_sections_mutated.clone(),
			rt.add(var_inventory_index, rt.new_int(1)), rt.new_null(),
			rt.new_bool(true)]))
	} else {
		var_sections_mutated.array_set('customer_stock_notifications', var_section_title.clone())
	}
	return var_sections_mutated.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_SettingsController) add_customer_stock_notifications_settings(var_settings rt.PhpVal, var_section_id rt.PhpVal) rt.PhpVal {
	mut var_settings_mutated := var_settings
	if !(var_settings_mutated.clone().is_array()) {
		return var_settings_mutated.clone()
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('customer_stock_notifications'),
		var_section_id))))
	{
		return var_settings_mutated.clone()
	}
	mut iife_temp_0 := Class_Automattic_WooCommerce_Internal_StockNotifications_Config{}
	mut iife_result_0 := iife_temp_0.get_unverified_deletion_days_threshold()
	mut var_stock_notification_settings := rt.call_function('apply_filters', [
		rt.new_string('woocommerce_customer_stock_notifications_settings'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
					rt.new_string('Customer stock notifications'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'title' },
				rt.ArrayItem{ key: 'desc', val: '' },
				rt.ArrayItem{ key: 'id', val: 'product_customer_stock_notifications_options' },
			]) },
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
					rt.new_string('Allow sign-ups'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [
					rt.new_string('Let customers sign up to be notified when products in your store are restocked.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{
					key: 'id'
					val: 'woocommerce_customer_stock_notifications_allow_signups'
				},
				rt.ArrayItem{ key: 'default', val: 'no' },
				rt.ArrayItem{ key: 'type', val: 'checkbox' },
			]) },
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
					rt.new_string('Require double opt-in to sign up'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [
					rt.new_string('To complete the sign-up process, customers must follow a verification link sent to their e-mail after submitting the sign-up form.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{
					key: 'id'
					val: 'woocommerce_customer_stock_notifications_require_double_opt_in'
				},
				rt.ArrayItem{ key: 'default', val: 'no' },
				rt.ArrayItem{ key: 'type', val: 'checkbox' },
			]) },
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
					rt.new_string('Delete unverified notification sign-ups after (in days)'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [
					rt.new_string('Controls how long the plugin will store unverified notification sign-ups in the database. Enter zero, or leave this field empty if you would like to store expired sign-up requests indefinitey.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{
					key: 'id'
					val: 'woocommerce_customer_stock_notifications_unverified_deletions_days_threshold'
				},
				rt.ArrayItem{ key: 'default', val: iife_result_0 },
				rt.ArrayItem{ key: 'type', val: 'number' },
			]) },
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
					rt.new_string('Guest sign-up'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [
					rt.new_string('Customers must be logged in to sign up for stock notifications.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{
					key: 'id'
					val: 'woocommerce_customer_stock_notifications_require_account'
				},
				rt.ArrayItem{ key: 'default', val: 'no' },
				rt.ArrayItem{ key: 'type', val: 'checkbox' },
				rt.ArrayItem{ key: 'desc_tip', val: rt.call_function('__', [
					rt.new_string('When enabled, guests will be redirected to a login page to complete the sign-up process.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'checkboxgroup', val: 'start' },
				rt.ArrayItem{ key: 'hide_if_checked', val: 'option' },
			]) },
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [
					rt.new_string('Create an account when guests sign up for stock notifications.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{
					key: 'id'
					val: 'woocommerce_customer_stock_notifications_create_account_on_signup'
				},
				rt.ArrayItem{ key: 'default', val: 'no' },
				rt.ArrayItem{ key: 'type', val: 'checkbox' },
				rt.ArrayItem{ key: 'checkboxgroup', val: 'end' },
				rt.ArrayItem{ key: 'hide_if_checked', val: 'yes' },
				rt.ArrayItem{ key: 'autoload', val: true },
			]) },
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'sectionend' },
				rt.ArrayItem{ key: 'id', val: 'product_customer_stock_notifications_options' },
			]) },
		]),
	])
	var_settings_mutated = rt.call_function('array_merge', [var_settings_mutated.clone(),
		var_stock_notification_settings.clone()])
	return var_settings_mutated.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_SettingsController) output_admin_notices() {
	mut var_screen := rt.call_function('get_current_screen', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(rt.is_true(var_screen))))
		|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('woocommerce_page_wc-settings'), rt.get_property(var_screen, 'id')))))
		|| !(rt.get_superglobal('_GET').array_isset(rt.new_string('section')))
		|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('customer_stock_notifications'), rt.get_superglobal('_GET').array_get(rt.new_string('section')))))) {
		return
	}
	if rt.is_true(rt.identical(rt.new_string('no'), rt.call_function('get_option', [rt.new_string('woocommerce_registration_generate_password'), rt.new_string('no')])))
		&& rt.is_true(rt.identical(rt.new_string('yes'), rt.call_function('get_option', [rt.new_string('woocommerce_customer_stock_notifications_create_account_on_signup'), rt.new_string('no')]))) {
		rt.call_function('wp_admin_notice', [
			rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('WooCommerce is currently <a href="%s">configured</a> to create new accounts without generating passwords automatically. Guests who sign up to receive stock notifications will need to reset their password before they can log into their new account.'),
					rt.new_string('woocommerce'),
				]),
				rt.call_function('esc_url', [
					rt.call_function('admin_url', [
						rt.new_string('admin.php?page=wc-settings&tab=account'),
					]),
				]),
			]),
			rt.create_array([
				rt.ArrayItem{ key: 'id', val: 'message' },
				rt.ArrayItem{ key: 'type', val: 'warning' },
				rt.ArrayItem{ key: 'dismissible', val: false },
			]),
		])
	}
	mut iife_temp_1 := Class_Automattic_WooCommerce_Internal_StockNotifications_Config{}
	mut iife_result_1 := iife_temp_1.allows_signups()
	if rt.is_true(rt.identical(rt.new_string('yes'), rt.call_function('get_option', [rt.new_string('woocommerce_hide_out_of_stock_items')])))
		&& rt.is_true(iife_result_1) {
		rt.call_function('wp_admin_notice', [
			rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('WooCommerce is currently <a href="%s">configured</a> to hide out-of-stock products from your catalog. Customers will not be able sign up for back-in-stock notifications while this option is enabled.'),
					rt.new_string('woocommerce'),
				]),
				rt.call_function('esc_url', [
					rt.call_function('admin_url', [
						rt.new_string('admin.php?page=wc-settings&tab=products&section=inventory'),
					]),
				]),
			]),
			rt.create_array([
				rt.ArrayItem{ key: 'id', val: 'message' },
				rt.ArrayItem{ key: 'type', val: 'warning' },
				rt.ArrayItem{ key: 'dismissible', val: false },
			]),
		])
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_SettingsController) add_disable_stock_notifications_checkbox() {
	mut var_product_object := rt.new_null()
	mut iife_temp_2 := Class_Automattic_WooCommerce_Internal_StockNotifications_Config{}
	mut iife_result_2 := iife_temp_2.allows_signups()
	if rt.is_true(rt.new_bool(!(rt.is_true(iife_result_2)))) {
		return
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_a', [
		var_product_object.clone(), rt.new_string('WC_Product')])))))
	{
		return
	}
	mut iife_temp_3 := Class_Automattic_WooCommerce_Internal_StockNotifications_Config{}
	mut iife_result_3 := iife_temp_3.get_product_signups_meta_key()
	mut var_enable_signups := rt.new_string((if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('no'), rt.call_method(var_product_object, 'get_meta', [
		iife_result_3,
	])))))
	{ 'yes' } else { 'no' }).str())
	rt.call_function('wp_nonce_field', [
		rt.new_string('woocommerce-customer-stock-notifications-edit-product'),
		rt.new_string('customer_stock_notifications_edit_product_security'),
	])
	mut iife_temp_4 := Class_Automattic_WooCommerce_Internal_StockNotifications_Config{}
	mut iife_result_4 := iife_temp_4.get_product_signups_meta_key()
	closure_6_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_type := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return
	}
	mut iife_temp_6 := Class_Automattic_WooCommerce_Internal_StockNotifications_Config{}
	mut iife_result_6 := iife_temp_6.get_supported_product_types()
	closure_8_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_type := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return
	}
	rt.call_function('woocommerce_wp_checkbox', [
		rt.create_array([rt.ArrayItem{ key: 'id', val: iife_result_4 },
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('Stock notifications'),
				rt.new_string('woocommerce'),
			]) }, rt.ArrayItem{ key: 'value', val: var_enable_signups },
			rt.ArrayItem{ key: 'wrapper_class', val: rt.call_function('implode', [
				rt.new_string(' '),
				rt.call_function('array_map', [rt.new_closure(closure_6_fn), iife_result_6]),
			]) }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Let customers sign up to be notified when this product is restocked'),
				rt.new_string('woocommerce'),
			]) }]),
	])
}

fn Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_SettingsController.process_product_object(var_product rt.PhpVal) {
	mut iife_temp_8 := Class_Automattic_WooCommerce_Internal_StockNotifications_Config{}
	mut iife_result_8 := iife_temp_8.allows_signups()
	if rt.is_true(rt.new_bool(!(rt.is_true(iife_result_8)))) {
		return
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_a', [
		var_product.clone(), rt.new_string('WC_Product')])))))
	{
		return
	}
	mut iife_temp_9 := Class_Automattic_WooCommerce_Internal_StockNotifications_Config{}
	mut iife_result_9 := iife_temp_9.get_supported_product_types()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_product, 'is_type', [
		iife_result_9,
	])))))
	{
		return
	}
	mut iife_temp_10 := Class_Automattic_WooCommerce_Internal_StockNotifications_Config{}
	mut iife_result_10 := iife_temp_10.get_product_signups_meta_key()
	mut var_posted_is_enabled :=
		rt.new_bool(rt.get_superglobal('_POST').array_isset(iife_result_10))
	mut iife_temp_11 := Class_Automattic_WooCommerce_Internal_StockNotifications_Config{}
	mut iife_result_11 := iife_temp_11.get_product_signups_meta_key()
	mut var_current_value := rt.call_method(var_product, 'get_meta', [iife_result_11])
	if (rt.is_true(var_posted_is_enabled)
		&& rt.is_true(rt.identical(rt.new_string('no'), var_current_value)))
		|| (rt.is_true(rt.new_bool(!(rt.is_true(var_posted_is_enabled))))
		&& rt.is_true(rt.identical(rt.new_string('yes'), var_current_value))) {
		rt.call_function('check_admin_referer', [
			rt.new_string('woocommerce-customer-stock-notifications-edit-product'),
			rt.new_string('customer_stock_notifications_edit_product_security'),
		])
		mut iife_temp_12 := Class_Automattic_WooCommerce_Internal_StockNotifications_Config{}
		mut iife_result_12 := iife_temp_12.get_product_signups_meta_key()
		rt.call_method(var_product, 'update_meta_data', [iife_result_12,
			rt.new_string((if rt.is_true(var_posted_is_enabled) { 'yes' } else { 'no' }).str())])
	}
}

struct Class_Automattic_WooCommerce_Internal_StockNotifications_Config {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_stocknotifications_admin_settingscontroller() &Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_SettingsController {
	mut obj := &Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_SettingsController{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	obj.construct()
	return obj
}

fn create_automattic_woocommerce_internal_stocknotifications_config(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_StockNotifications_Config {
	mut obj := &Class_Automattic_WooCommerce_Internal_StockNotifications_Config{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_SettingsController) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'add_customer_stock_notifications_section' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.add_customer_stock_notifications_section(dispatch_arg_0)
		}
		'add_customer_stock_notifications_settings' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.add_customer_stock_notifications_settings(dispatch_arg_0, dispatch_arg_1)
		}
		'output_admin_notices' {
			this.output_admin_notices()
			return rt.new_null()
		}
		'add_disable_stock_notifications_checkbox' {
			this.add_disable_stock_notifications_checkbox()
			return rt.new_null()
		}
		'process_product_object' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_SettingsController.process_product_object(dispatch_arg_0)
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_SettingsController) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_SettingsController) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Config) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_StockNotifications_Config) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Config) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
