import rt

struct Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_FormHandlerService {
	rt.PhpObjectBase
pub mut:
		signup_service rt.PhpVal = rt.new_null()
		logger rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_FormHandlerService) init(mut var_signup_service Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_SignupService)  {
	this.signup_service = var_signup_service.dup()
	this.logger = rt.call_function('wc_get_logger', []rt.PhpVal{})
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_FormHandlerService) construct()  {
	rt.call_function('add_action', [rt.new_string('template_redirect'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_StockNotifications_Frontend_FormHandlerService', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'handle_signup' }])])
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_FormHandlerService) handle_signup()  {
	if rt.is_true(rt.new_bool(!(rt.is_true(fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_StockNotifications_Config{}; return temp.allows_signups() }())))) {
		return rt.new_null()
	}
	if !(rt.get_superglobal('_POST').array_isset(rt.new_string('wc_bis_register'))) {
		return rt.new_null()
	}
	if rt.is_true(Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_FormHandlerService.requires_nonce_check()) {
		if rt.is_true(rt.new_bool(!(rt.get_superglobal('_POST').array_isset(rt.new_string('wc_bis_nonce'))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_verify_nonce', [rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get('wc_bis_nonce')]), rt.new_string('wc_bis_signup')]))))))) {
			rt.call_function('wc_add_notice', [rt.call_method(this.signup_service, 'get_error_message', [Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_SignupService.error_invalid_request()]), rt.new_string('error')])
			if rt.has_exception() { unsafe { goto catch_label_1 } }
			return rt.new_null()
		}
		if rt.has_exception() { unsafe { goto catch_label_1 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	mut var_data := rt.call_method(this.signup_service, 'parse', [rt.get_superglobal('_POST').dup()])
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	if rt.is_true(rt.call_function('is_wp_error', [var_data.dup()])) {
		rt.call_function('wc_add_notice', [rt.call_method(this.signup_service, 'get_error_message', [rt.call_method(var_data, 'get_error_code', []rt.PhpVal{})]), rt.new_string('error')])
		if rt.has_exception() { unsafe { goto catch_label_1 } }
		return rt.new_null()
	}
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	mut var_result := rt.call_method(this.signup_service, 'signup', [var_data.array_get('product_id'), var_data.array_get('user_id'), var_data.array_get('user_email'), if !(var_data.array_get('posted_attributes')).is_null() { var_data.array_get('posted_attributes') } else { rt.new_array() }])
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	if rt.is_true(rt.call_function('is_wp_error', [var_result.dup()])) {
		rt.call_function('wc_add_notice', [rt.call_method(this.signup_service, 'get_error_message', [rt.call_method(var_result, 'get_error_code', []rt.PhpVal{})]), rt.new_string('error')])
		if rt.has_exception() { unsafe { goto catch_label_1 } }
		return rt.new_null()
	}
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	rt.call_function('wc_add_notice', [rt.call_method(this.signup_service, 'get_signup_user_message', [rt.call_method(var_result, 'get_code', []rt.PhpVal{}), rt.call_method(var_result, 'get_notification', []rt.PhpVal{})]), rt.new_string('success')])
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	unsafe { goto end_label_1 }

catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'Automattic_WooCommerce_Internal_StockNotifications_Frontend_Throwable') {
		mut var_e := var_e_1.dup()
		rt.call_function('wc_add_notice', [rt.call_method(this.signup_service, 'get_error_message', [Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_SignupService.error_failed()]), rt.new_string('error')])
		rt.call_method(this.logger, 'error', [rt.call_method(var_e, 'getMessage', []rt.PhpVal{}), rt.create_array([rt.ArrayItem{ key: 'source', val: 'stock-notifications-signup-errors' }])])
		return rt.new_null()
		unsafe { goto end_label_1 }
	}
	else {
		rt.throw_exception(var_e_1)
		unsafe { goto end_label_1 }
	}

end_label_1:
}

fn Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_FormHandlerService.requires_nonce_check() bool {
	mut var_requires_account := rt.new_bool(rt.new_bool(rt.is_true(fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_ProductPageIntegration{}; return temp.is_personalization_enabled() }()) && rt.is_true(rt.new_bool(rt.is_true(fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_StockNotifications_Config{}; return temp.requires_account() }()) || rt.is_true(rt.call_function('is_user_logged_in', []rt.PhpVal{}))))))
	return (// unsupported expression: Expr_Cast_Bool).to_bool()
}

struct Class_Automattic_WooCommerce_Internal_StockNotifications_Config {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_ProductPageIntegration {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_stocknotifications_frontend_formhandlerservice() &Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_FormHandlerService {
	mut obj := &Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_FormHandlerService{
		PhpObjectBase: rt.PhpObjectBase{}
		signup_service: rt.new_null()
		logger: rt.new_null()
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

fn create_automattic_woocommerce_internal_stocknotifications_frontend_productpageintegration() &Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_ProductPageIntegration {
	mut obj := &Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_ProductPageIntegration{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_FormHandlerService) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'init' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_SignupService](if args.len > 0 { args[0] } else { rt.new_null() })
			this.init(mut dispatch_arg_0)
			return rt.new_null()
		}
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'handle_signup' {
			this.handle_signup()
			return rt.new_null()
		}
		'requires_nonce_check' {
			return rt.new_bool(Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_FormHandlerService.requires_nonce_check())
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_FormHandlerService) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'signup_service' { return this.signup_service }
		'logger' { return this.logger }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_FormHandlerService) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'signup_service' { this.signup_service = val; return true }
		'logger' { this.logger = val; return true }
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


fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_ProductPageIntegration) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_ProductPageIntegration) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_ProductPageIntegration) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_internal_stocknotifications_frontend_formhandlerservice_php() {
	// unsupported statement: Stmt_Declare
}
