import rt

struct Class_Automattic_WooCommerce_Internal_StockNotifications_Emails_EmailTemplatesController {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Emails_EmailTemplatesController) init() {
	rt.call_function('add_action', [rt.new_string('init'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_StockNotifications_Emails_EmailTemplatesController',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'register_template_hooks' },
		])])
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Emails_EmailTemplatesController) register_template_hooks() {
	rt.call_function('add_action', [
		rt.new_string('woocommerce_email_stock_notification_product'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_StockNotifications_Emails_EmailTemplatesController',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'email_product_image' },
		]),
		rt.new_int(10),
		rt.new_int(3),
	])
	rt.call_function('add_action', [
		rt.new_string('woocommerce_email_stock_notification_product'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_StockNotifications_Emails_EmailTemplatesController',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'email_product_title' },
		]),
		rt.new_int(20),
		rt.new_int(3),
	])
	rt.call_function('add_action', [
		rt.new_string('woocommerce_email_stock_notification_product'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_StockNotifications_Emails_EmailTemplatesController',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'email_product_attributes' },
		]),
		rt.new_int(30),
		rt.new_int(3),
	])
	rt.call_function('add_action', [
		rt.new_string('woocommerce_email_stock_notification_product'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_StockNotifications_Emails_EmailTemplatesController',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'email_product_price' },
		]),
		rt.new_int(40),
		rt.new_int(3),
	])
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Emails_EmailTemplatesController) email_product_image(var_product rt.PhpVal, var_notification rt.PhpVal, plain_text bool) {
	if var_plain_text {
		return
	}
	mut var_image := rt.call_function('wp_get_attachment_image_src', [
		rt.call_method(var_product, 'get_image_id', []rt.PhpVal{}),
		rt.new_string('woocommerce_thumbnail'),
	])
	mut var_image_src := if var_image.clone().is_array() && var_image.array_isset(rt.new_int(0)) {
		var_image.array_get(rt.new_int(0))
	} else {
		rt.new_string('')
	}
	rt.call_function('ob_start', []rt.PhpVal{})
	if rt.is_true(var_image_src) {
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [var_image_src.clone()]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [
			rt.call_method(var_product, 'get_title', []rt.PhpVal{}),
		]))
		// unsupported statement: Stmt_InlineHTML
	}
	mut var_html := rt.call_function('ob_get_clean', []rt.PhpVal{})
	rt.echo_val(rt.call_function('wp_kses_post', [var_html.clone()]))
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Emails_EmailTemplatesController) email_product_title(var_product rt.PhpVal, var_notification rt.PhpVal, plain_text bool) {
	if var_plain_text {
		return
	}
	rt.call_function('ob_start', []rt.PhpVal{})
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [
		rt.call_method(var_product, 'get_name', []rt.PhpVal{}),
	]))
	// unsupported statement: Stmt_InlineHTML
	mut var_html := rt.call_function('ob_get_clean', []rt.PhpVal{})
	rt.echo_val(rt.call_function('wp_kses_post', [var_html.clone()]))
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Emails_EmailTemplatesController) email_product_attributes(var_product rt.PhpVal, var_notification rt.PhpVal, plain_text bool) {
	if var_plain_text {
		return
	}
	mut var_formatted_variation_list := rt.call_method(var_notification,
		'get_product_formatted_variation_list', [rt.new_bool(false)])
	if !rt.is_true(var_formatted_variation_list) {
		return
	}
	var_formatted_variation_list = rt.call_function('strtr', [
		var_formatted_variation_list.clone(),
		rt.create_array([
			rt.ArrayItem{ key: '<dl', val: '<table' },
			rt.ArrayItem{ key: '<dd', val: '<tr><th' },
			rt.ArrayItem{ key: '<dt', val: '<tr><td' },
			rt.ArrayItem{ key: 'dl>', val: 'table>' },
			rt.ArrayItem{ key: 'dd>', val: 'th></tr>' },
			rt.ArrayItem{ key: 'dt>', val: 'td></tr>' },
		])])
	rt.call_function('ob_start', []rt.PhpVal{})
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wp_kses_post', [var_formatted_variation_list.clone()]))
	// unsupported statement: Stmt_InlineHTML
	mut var_html := rt.call_function('ob_get_clean', []rt.PhpVal{})
	rt.echo_val(rt.call_function('wp_kses_post', [var_html.clone()]))
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Emails_EmailTemplatesController) email_product_price(var_product rt.PhpVal, var_notification rt.PhpVal, plain_text bool) {
	if var_plain_text {
		return
	}
	rt.call_function('ob_start', []rt.PhpVal{})
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wp_kses_post', [
		rt.call_method(var_product, 'get_price_html', []rt.PhpVal{}),
	]))
	// unsupported statement: Stmt_InlineHTML
	mut var_html := rt.call_function('ob_get_clean', []rt.PhpVal{})
	rt.echo_val(rt.call_function('wp_kses_post', [var_html.clone()]))
}

fn create_automattic_woocommerce_internal_stocknotifications_emails_emailtemplatescontroller(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_StockNotifications_Emails_EmailTemplatesController {
	mut obj := &Class_Automattic_WooCommerce_Internal_StockNotifications_Emails_EmailTemplatesController{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Emails_EmailTemplatesController) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'init' {
			this.init()
			return rt.new_null()
		}
		'register_template_hooks' {
			this.register_template_hooks()
			return rt.new_null()
		}
		'email_product_image' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
			this.email_product_image(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'email_product_title' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
			this.email_product_title(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'email_product_attributes' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
			this.email_product_attributes(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'email_product_price' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
			this.email_product_price(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_StockNotifications_Emails_EmailTemplatesController) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Emails_EmailTemplatesController) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
