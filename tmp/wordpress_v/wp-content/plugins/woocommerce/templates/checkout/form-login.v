import rt

struct Class_WC_Checkout {
	rt.PhpObjectBase
}

fn create_wc_checkout() &Class_WC_Checkout {
	mut obj := &Class_WC_Checkout{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Checkout) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Checkout) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Checkout) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_templates_checkout_form_login_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
	mut var_registration_at_checkout := rt.call_method(fn () rt.PhpVal { mut temp := Class_WC_Checkout{}; return temp.instance() }(), 'is_registration_enabled', []rt.PhpVal{})
	mut var_login_reminder_at_checkout := (rt.identical(rt.new_string('yes'), rt.call_function('get_option', [rt.new_string('woocommerce_enable_checkout_login_reminder')]))).to_bool()
	if rt.is_true(rt.call_function('is_user_logged_in', []rt.PhpVal{})) {
		return rt.new_null()
	}
	if var_login_reminder_at_checkout {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('wc_print_notice', [(rt.call_function('apply_filters', [rt.new_string('woocommerce_checkout_login_message'), rt.call_function('esc_html__', [rt.new_string('Returning customer?'), rt.new_string('woocommerce')])])).str() + ' <a href="#" class="showlogin">' + (rt.call_function('esc_html__', [rt.new_string('Click here to login'), rt.new_string('woocommerce')])).str() + '</a>', rt.new_string('notice')])
		// unsupported statement: Stmt_InlineHTML
	}
	if rt.is_true(rt.new_bool(rt.is_true(var_registration_at_checkout) || var_login_reminder_at_checkout)) {
		mut var_show_form := rt.new_bool(rt.get_superglobal('_POST').array_isset(rt.new_string('login')))
		rt.call_function('woocommerce_login_form', [rt.create_array([rt.ArrayItem{ key: 'message', val: rt.call_function('esc_html__', [rt.new_string('If you have shopped with us before, please enter your details below. If you are a new customer, please proceed to the Billing section.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'redirect', val: rt.call_function('wc_get_checkout_url', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'hidden', val: !(rt.is_true(var_show_form)) }])])
	}
}
