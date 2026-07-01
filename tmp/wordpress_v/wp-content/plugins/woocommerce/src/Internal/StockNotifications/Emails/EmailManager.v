import rt

struct Class_Automattic_WooCommerce_Internal_StockNotifications_Emails_EmailManager {
	rt.PhpObjectBase
pub mut:
		email_ids rt.PhpVal = rt.new_array()
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Emails_EmailManager) init()  {
	rt.call_function('add_filter', [rt.new_string('woocommerce_email_classes'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_StockNotifications_Emails_EmailManager', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'email_classes' }])])
	rt.call_function('add_action', [rt.new_string('woocommerce_email_actions'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_StockNotifications_Emails_EmailManager', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'add_transactional_emails' }])])
	rt.call_function('add_filter', [rt.new_string('woocommerce_email_styles'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_StockNotifications_Emails_EmailManager', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'add_stylesheets' }]), rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_filter', [rt.new_string('woocommerce_prepare_email_for_preview'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_StockNotifications_Emails_EmailManager', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'prepare_email_for_preview' }])])
	rt.call_function('add_filter', [rt.new_string('woocommerce_email_preview_email_content_setting_ids'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_StockNotifications_Emails_EmailManager', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'add_intro_content_to_preview_settings' }]), rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_action', [rt.new_string('woocommerce_email_stock_notification_product'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_StockNotifications_Emails_EmailManager', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'maybe_restore_customer_tax_location_data' }]), rt.new_int(9)])
	mut var_container := rt.call_function('wc_get_container', []rt.PhpVal{})
	rt.call_method(var_container, 'get', [Class_Automattic_WooCommerce_Internal_StockNotifications_Emails_EmailTemplatesController.class()])
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Emails_EmailManager) email_classes(var_emails rt.PhpVal) rt.PhpVal {
	mut var_emails_mutated := var_emails
	var_emails_mutated.array_set('WC_Email_Customer_Stock_Notification', create_automattic_woocommerce_internal_stocknotifications_emails_customerstocknotificationemail())
	var_emails_mutated.array_set('WC_Email_Customer_Stock_Notification_Verify', create_automattic_woocommerce_internal_stocknotifications_emails_customerstocknotificationverifyemail())
	var_emails_mutated.array_set('WC_Email_Customer_Stock_Notification_Verified', create_automattic_woocommerce_internal_stocknotifications_emails_customerstocknotificationverifiedemail())
	return var_emails_mutated.dup()
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Emails_EmailManager) add_transactional_emails(var_actions rt.PhpVal) rt.PhpVal {
	mut var_actions_mutated := var_actions
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_actions_mutated.dup().is_array()))))) {
		return var_actions_mutated.dup()
	}
	var_actions_mutated.array_push('woocommerce_customer_stock_notification_verify')
	var_actions_mutated.array_push('woocommerce_customer_stock_notification_verified')
	return var_actions_mutated.dup()
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Emails_EmailManager) maybe_restore_customer_tax_location_data(var_notification rt.PhpVal)  {
	mut var_notification_mutated := var_notification
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return rt.new_null()
	}
	if !(!rt.is_true(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'customer'))) {
		return rt.new_null()
	}
	mut var_location := rt.call_method(var_notification_mutated, 'get_meta', [rt.new_string('_customer_location_data')])
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!rt.is_true(var_location) || rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_location.dup().is_array()))))))) || rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		return rt.new_null()
	}
	closure_1_fn := fn [var_location] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	return var_location.dup()
	}
	rt.call_function('add_filter', [rt.new_string('woocommerce_get_tax_location'), rt.new_closure(closure_1_fn)])
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Emails_EmailManager) add_stylesheets(var_css rt.PhpVal, var_email rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_email.dup().is_null())) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [rt.get_property(var_email, 'id'), rt.cast_array(rt.call_function('apply_filters', [rt.new_string('woocommerce_email_stock_notification_emails_to_style'), // unsupported expression: Expr_StaticPropertyFetch])), rt.new_bool(true)]))))))) {
		return var_css.dup()
	}
	mut var_text := rt.call_function('get_option', [rt.new_string('woocommerce_email_text_color')])
	mut var_base := rt.call_function('get_option', [rt.new_string('woocommerce_email_base_color')])
	mut var_base_text := // unsupported expression: Expr_Cast_String
	rt.call_function('ob_start', []rt.PhpVal{})
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_text.dup()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_text.dup()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_text.dup()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_text.dup()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_text.dup()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_text.dup()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_base.dup()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_base_text.dup()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_base.dup()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_text.dup()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_text.dup()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_text.dup()]))
	// unsupported statement: Stmt_InlineHTML
	// unsupported expression: Expr_AssignOp_Concat
	return var_css.dup()
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Emails_EmailManager) add_intro_content_to_preview_settings(var_setting_ids rt.PhpVal, var_email_id rt.PhpVal) rt.PhpVal {
	mut var_setting_ids_mutated := var_setting_ids
	if rt.is_true(rt.call_function('in_array', [var_email_id.dup(), // unsupported expression: Expr_StaticPropertyFetch, rt.new_bool(true)])) {
		var_setting_ids_mutated.array_push("woocommerce_${var_email_id.to_string()}_intro_content")
	}
	return var_setting_ids_mutated.dup()
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Emails_EmailManager) prepare_email_for_preview(var_email rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [rt.get_property(var_email, 'id'), // unsupported expression: Expr_StaticPropertyFetch, rt.new_bool(true)]))))) {
		return var_email.dup()
	}
	mut var_notification := fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_StockNotifications_Factory{}; return temp.create_dummy_notification() }()
	rt.call_method(var_email, 'prepare_email', [var_notification.dup()])
	return var_email.dup()
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Emails_EmailManager) send_stock_notification_email(mut var_notification Class_Automattic_WooCommerce_Internal_StockNotifications_Notification)  {
	mut var_notification_mutated := var_notification
	mut var_emails := rt.call_method(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'mailer', []rt.PhpVal{}), 'get_emails', []rt.PhpVal{})
	if var_emails.array_isset(rt.new_string('WC_Email_Customer_Stock_Notification')) {
		rt.call_method(var_emails.array_get('WC_Email_Customer_Stock_Notification'), 'trigger', [var_notification_mutated.dup()])
	}
}

struct Class_Automattic_WooCommerce_Internal_StockNotifications_Emails_CustomerStockNotificationEmail {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_StockNotifications_Emails_CustomerStockNotificationVerifyEmail {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_StockNotifications_Emails_CustomerStockNotificationVerifiedEmail {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_StockNotifications_Factory {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_stocknotifications_emails_emailmanager() &Class_Automattic_WooCommerce_Internal_StockNotifications_Emails_EmailManager {
	mut obj := &Class_Automattic_WooCommerce_Internal_StockNotifications_Emails_EmailManager{
		PhpObjectBase: rt.PhpObjectBase{}
		email_ids: rt.new_array()
	}
	return obj
}

fn create_automattic_woocommerce_internal_stocknotifications_emails_customerstocknotificationemail() &Class_Automattic_WooCommerce_Internal_StockNotifications_Emails_CustomerStockNotificationEmail {
	mut obj := &Class_Automattic_WooCommerce_Internal_StockNotifications_Emails_CustomerStockNotificationEmail{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_stocknotifications_emails_customerstocknotificationverifyemail() &Class_Automattic_WooCommerce_Internal_StockNotifications_Emails_CustomerStockNotificationVerifyEmail {
	mut obj := &Class_Automattic_WooCommerce_Internal_StockNotifications_Emails_CustomerStockNotificationVerifyEmail{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_stocknotifications_emails_customerstocknotificationverifiedemail() &Class_Automattic_WooCommerce_Internal_StockNotifications_Emails_CustomerStockNotificationVerifiedEmail {
	mut obj := &Class_Automattic_WooCommerce_Internal_StockNotifications_Emails_CustomerStockNotificationVerifiedEmail{
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

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Emails_EmailManager) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'init' {
			this.init()
			return rt.new_null()
		}
		'email_classes' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.email_classes(dispatch_arg_0)
		}
		'add_transactional_emails' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.add_transactional_emails(dispatch_arg_0)
		}
		'maybe_restore_customer_tax_location_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.maybe_restore_customer_tax_location_data(dispatch_arg_0)
			return rt.new_null()
		}
		'add_stylesheets' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.add_stylesheets(dispatch_arg_0, dispatch_arg_1)
		}
		'add_intro_content_to_preview_settings' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.add_intro_content_to_preview_settings(dispatch_arg_0, dispatch_arg_1)
		}
		'prepare_email_for_preview' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.prepare_email_for_preview(dispatch_arg_0)
		}
		'send_stock_notification_email' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_StockNotifications_Notification](if args.len > 0 { args[0] } else { rt.new_null() })
			this.send_stock_notification_email(mut dispatch_arg_0)
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_StockNotifications_Emails_EmailManager) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'email_ids' { return this.email_ids }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Emails_EmailManager) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'email_ids' { this.email_ids = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Emails_CustomerStockNotificationEmail) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_StockNotifications_Emails_CustomerStockNotificationEmail) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Emails_CustomerStockNotificationEmail) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Emails_CustomerStockNotificationVerifyEmail) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_StockNotifications_Emails_CustomerStockNotificationVerifyEmail) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Emails_CustomerStockNotificationVerifyEmail) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Emails_CustomerStockNotificationVerifiedEmail) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_StockNotifications_Emails_CustomerStockNotificationVerifiedEmail) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Emails_CustomerStockNotificationVerifiedEmail) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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




pub fn init_wp_content_plugins_woocommerce_src_internal_stocknotifications_emails_emailmanager_php() {
	// unsupported statement: Stmt_Declare
}
