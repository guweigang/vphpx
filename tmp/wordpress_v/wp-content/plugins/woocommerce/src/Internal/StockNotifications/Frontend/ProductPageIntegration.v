import rt

struct Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_ProductPageIntegration {
	rt.PhpObjectBase
pub mut:
		rendered rt.PhpVal = rt.new_array()
		eligibility_service rt.PhpVal = rt.new_null()
		signup_service rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_ProductPageIntegration) init(mut var_eligibility_service Class_Automattic_WooCommerce_Internal_StockNotifications_Utilities_EligibilityService, mut var_signup_service Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_SignupService)  {
	this.eligibility_service = var_eligibility_service.dup()
	this.signup_service = var_signup_service.dup()
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_ProductPageIntegration) construct()  {
	rt.call_function('add_action', [rt.new_string('woocommerce_simple_add_to_cart'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_StockNotifications_Frontend_ProductPageIntegration', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'maybe_render_form' }]), rt.new_int(30)])
	rt.call_function('add_action', [rt.new_string('woocommerce_after_add_to_cart_form'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_StockNotifications_Frontend_ProductPageIntegration', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'maybe_render_form' }]), rt.new_int(30)])
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_ProductPageIntegration) maybe_render_form()  {
	mut var_product := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_StockNotifications_Config{}; return temp.allows_signups() }())))) {
		return rt.new_null()
	}
	// unsupported statement: Stmt_Global
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_product', []rt.PhpVal{}))))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_a', [var_product.dup(), rt.new_string('WC_Product')]))))))) {
		return rt.new_null()
	}
	if this.rendered.array_isset(rt.call_method(var_product, 'get_id', []rt.PhpVal{})) {
		return rt.new_null()
	}
	this.rendered.array_set(rt.call_method(var_product, 'get_id', []rt.PhpVal{}), true)
	mut var_is_variable := rt.call_method(var_product, 'is_type', [rt.new_string('variable')])
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_is_variable)))) && rt.is_true(rt.call_method(this.eligibility_service, 'is_stock_status_eligible', [rt.call_method(var_product, 'get_stock_status', []rt.PhpVal{})])))) {
		return rt.new_null()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(this.eligibility_service, 'is_product_eligible', [var_product.dup()]))))) {
		return rt.new_null()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(this.eligibility_service, 'product_allows_signups', [var_product.dup()]))))) {
		return rt.new_null()
	}
	rt.call_function('wp_enqueue_script', [rt.new_string('wc-back-in-stock-form')])
	this.render_form(mut rt.cast_object_ptr[Class_WC_Product](var_product))
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_ProductPageIntegration) render_form(mut var_product Class_WC_Product)  {
	if rt.is_true(rt.new_bool(rt.is_true(fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_StockNotifications_Config{}; return temp.requires_account() }()) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_user_logged_in', []rt.PhpVal{}))))))) {
		this.display_account_required(mut var_product)
		return rt.new_null()
	}
	if rt.is_true(rt.new_bool(this.is_personalization_enabled() && rt.is_true(rt.call_function('is_user_logged_in', []rt.PhpVal{})))) {
		mut var_user := rt.call_function('get_user_by', [rt.new_string('id'), rt.call_function('get_current_user_id', []rt.PhpVal{})])
		mut var_notification := rt.call_method(this.signup_service, 'is_already_signed_up', [var_product.get_id(), rt.get_property(var_user, 'ID'), rt.get_property(var_user, 'user_email')])
		if rt.is_true(rt.new_bool(rt.instance_of(var_notification, 'Automattic_WooCommerce_Internal_StockNotifications_Notification'))) {
			this.display_already_signed_up(mut var_product, mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_StockNotifications_Notification](var_notification))
			return rt.new_null()
		}
	}
	this.display_form(mut var_product)
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_ProductPageIntegration) display_account_required(mut var_product Class_WC_Product)  {
	mut var_pre := rt.call_function('apply_filters', [rt.new_string('woocommerce_customer_stock_notifications_account_required_message_html'), rt.new_null(), var_product])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_pre.dup().is_null()))))) {
		rt.echo_val(rt.call_function('wp_kses_post', [var_pre.dup()]))
		return rt.new_null()
	}
	mut var_text := rt.call_function('__', [rt.new_string('Please {login_link} to sign up for stock notifications.'), rt.new_string('woocommerce')])
	var_text = rt.call_function('str_replace', [rt.new_string('{login_link}'), '<a href="' + (rt.call_function('wc_get_account_endpoint_url', [rt.new_string('my-account')])).str() + '">' + (rt.call_function('_x', [rt.new_string('log in'), rt.new_string('back in stock form'), rt.new_string('woocommerce')])).str() + '</a>', var_text.dup()])
	rt.call_function('wc_print_notice', [var_text.dup(), rt.new_string('notice')])
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_ProductPageIntegration) display_already_signed_up(mut var_product Class_WC_Product, mut var_notification Class_Automattic_WooCommerce_Internal_StockNotifications_Notification)  {
	mut var_notification_mutated := var_notification
	mut var_pre := rt.call_function('apply_filters', [rt.new_string('woocommerce_customer_stock_notifications_already_signed_up_message_html'), rt.new_null(), var_product, var_notification_mutated.dup()])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_pre.dup().is_null()))))) {
		rt.echo_val(rt.call_function('wp_kses_post', [var_pre.dup()]))
		return rt.new_null()
	}
	mut var_text := rt.call_function('__', [rt.new_string('You have already joined the waitlist! Click {manage_account_link} to manage your notifications.'), rt.new_string('woocommerce')])
	var_text = rt.call_function('str_replace', [rt.new_string('{manage_account_link}'), '<a href="' + (rt.call_function('wc_get_account_endpoint_url', [rt.new_string('stock-notifications')])).str() + '">' + (rt.call_function('_x', [rt.new_string('here'), rt.new_string('back in stock form'), rt.new_string('woocommerce')])).str() + '</a>', var_text.dup()])
	rt.call_function('wc_print_notice', [var_text.dup(), rt.new_string('notice')])
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_ProductPageIntegration) display_form(mut var_product Class_WC_Product)  {
	mut var_button_class := rt.call_function('implode', [rt.new_string(' '), rt.call_function('array_filter', [rt.create_array([rt.ArrayItem{ key: none, val: 'button' }, rt.ArrayItem{ key: none, val: rt.call_function('wc_wp_theme_get_element_class_name', [rt.new_string('button')]) }, rt.ArrayItem{ key: none, val: 'wc_bis_form__button' }])])])
	mut var_is_visible := rt.new_bool(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_product.is_type(rt.new_string('variable')))))) || rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('yes'), rt.call_function('get_option', [rt.new_string('woocommerce_hide_out_of_stock_items')]))) && rt.is_true(rt.new_bool(!(rt.is_true(var_product.has_purchasable_variations()))))))))
	rt.call_function('wc_get_template', [rt.new_string('single-product/back-in-stock-form.php'), rt.create_array([rt.ArrayItem{ key: 'product_id', val: if rt.is_true(var_product.get_parent_id()) { var_product.get_parent_id() } else { var_product.get_id() } }, rt.ArrayItem{ key: 'show_checkbox', val: rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_user_logged_in', []rt.PhpVal{}))))) && rt.is_true(fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_StockNotifications_Config{}; return temp.creates_account_on_signup() }()))) && rt.is_true(rt.new_bool(!(rt.is_true(fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_StockNotifications_Config{}; return temp.requires_account() }())))) }, rt.ArrayItem{ key: 'show_email_field', val: rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_user_logged_in', []rt.PhpVal{}))))) && rt.is_true(rt.new_bool(!(rt.is_true(fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_StockNotifications_Config{}; return temp.requires_account() }())))) }, rt.ArrayItem{ key: 'button_class', val: var_button_class }, rt.ArrayItem{ key: 'is_visible', val: var_is_visible }])])
}

fn Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_ProductPageIntegration.is_personalization_enabled() bool {
	return (// unsupported expression: Expr_Cast_Bool).to_bool()
}

struct Class_Automattic_WooCommerce_Internal_StockNotifications_Config {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_stocknotifications_frontend_productpageintegration() &Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_ProductPageIntegration {
	mut obj := &Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_ProductPageIntegration{
		PhpObjectBase: rt.PhpObjectBase{}
		rendered: rt.new_array()
		eligibility_service: rt.new_null()
		signup_service: rt.new_null()
	}
	obj.construct()
	return obj
}

fn create_automattic_woocommerce_internal_stocknotifications_config() &Class_Automattic_WooCommerce_Internal_StockNotifications_Config {
	mut obj := &Class_Automattic_WooCommerce_Internal_StockNotifications_Config{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_ProductPageIntegration) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'init' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_StockNotifications_Utilities_EligibilityService](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_SignupService](if args.len > 1 { args[1] } else { rt.new_null() })
			this.init(mut dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'maybe_render_form' {
			this.maybe_render_form()
			return rt.new_null()
		}
		'render_form' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Product](if args.len > 0 { args[0] } else { rt.new_null() })
			this.render_form(mut dispatch_arg_0)
			return rt.new_null()
		}
		'display_account_required' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Product](if args.len > 0 { args[0] } else { rt.new_null() })
			this.display_account_required(mut dispatch_arg_0)
			return rt.new_null()
		}
		'display_already_signed_up' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Product](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_StockNotifications_Notification](if args.len > 1 { args[1] } else { rt.new_null() })
			this.display_already_signed_up(mut dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'display_form' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Product](if args.len > 0 { args[0] } else { rt.new_null() })
			this.display_form(mut dispatch_arg_0)
			return rt.new_null()
		}
		'is_personalization_enabled' {
			return rt.new_bool(Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_ProductPageIntegration.is_personalization_enabled())
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_ProductPageIntegration) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'rendered' { return this.rendered }
		'eligibility_service' { return this.eligibility_service }
		'signup_service' { return this.signup_service }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_ProductPageIntegration) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'rendered' { this.rendered = val; return true }
		'eligibility_service' { this.eligibility_service = val; return true }
		'signup_service' { this.signup_service = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
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




pub fn init_wp_content_plugins_woocommerce_src_internal_stocknotifications_frontend_productpageintegration_php() {
	// unsupported statement: Stmt_Declare
}
