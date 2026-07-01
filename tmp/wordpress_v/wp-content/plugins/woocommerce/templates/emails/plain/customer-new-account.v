import rt

struct Class_Automattic_WooCommerce_Utilities_FeaturesUtil {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_utilities_featuresutil() &Class_Automattic_WooCommerce_Utilities_FeaturesUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_FeaturesUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Utilities_FeaturesUtil) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Utilities_FeaturesUtil) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_FeaturesUtil) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_templates_emails_plain_customer_new_account_php() {
	mut var_email_heading := rt.new_null()
	mut var_user_login := rt.new_null()
	mut var_blogname := rt.new_null()
	mut var_password_generated := rt.new_null()
	mut var_set_password_url := rt.new_null()
	mut var_additional_content := rt.new_null()
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
	mut var_email_improvements_enabled := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Utilities_FeaturesUtil{}; return temp.feature_is_enabled(arg_0) }(rt.new_string('email_improvements'))
	print('=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=\n')
	rt.echo_val(rt.call_function('esc_html', [rt.call_function('wp_strip_all_tags', [var_email_heading.dup()])]))
	print('\n=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=\n\n')
	print((rt.call_function('sprintf', [rt.call_function('esc_html__', [rt.new_string('Hi %s,'), rt.new_string('woocommerce')]), rt.call_function('esc_html', [var_user_login.dup()])])).str() + '\n\n')
	if rt.is_true(var_email_improvements_enabled) {
		print((rt.call_function('sprintf', [rt.call_function('esc_html__', [rt.new_string('Thanks for creating an account on %s. Here’s a copy of your user details.'), rt.new_string('woocommerce')]), rt.call_function('esc_html', [var_blogname.dup()])])).str() + '\n\n')
		print('----------------------------------------\n\n')
		print((rt.call_function('sprintf', [rt.call_function('esc_html__', [rt.new_string('Username: %s.'), rt.new_string('woocommerce')]), rt.call_function('esc_html', [var_user_login.dup()])])).str() + '\n\n')
		print('----------------------------------------\n\n')
		print((rt.call_function('esc_html__', [rt.new_string('You can access your account area to view orders, change your password, and more via the link below:'), rt.new_string('woocommerce')])).str() + '\n\n')
		print((rt.call_function('esc_html', [rt.call_function('wc_get_page_permalink', [rt.new_string('myaccount')])])).str() + '\n\n')
	} else {
		print((rt.call_function('sprintf', [rt.call_function('esc_html__', [rt.new_string('Thanks for creating an account on %1$s. Your username is %2$s. You can access your account area to view orders, change your password, and more at: %3$s'), rt.new_string('woocommerce')]), rt.call_function('esc_html', [var_blogname.dup()]), rt.call_function('esc_html', [var_user_login.dup()]), rt.call_function('esc_html', [rt.call_function('wc_get_page_permalink', [rt.new_string('myaccount')])])])).str() + '\n\n')
	}
	if rt.is_true(rt.new_bool(rt.is_true(var_password_generated) && rt.is_true(var_set_password_url))) {
		print((rt.call_function('esc_html__', [rt.new_string('To set your password, visit the following address: '), rt.new_string('woocommerce')])).str() + '\n\n')
		print((rt.call_function('esc_html', [var_set_password_url.dup()])).str() + '\n\n')
	}
	print('\n\n----------------------------------------\n\n')
	if rt.is_true(var_additional_content) {
		rt.echo_val(rt.call_function('esc_html', [rt.call_function('wp_strip_all_tags', [rt.call_function('wptexturize', [var_additional_content.dup()])])]))
		print('\n\n----------------------------------------\n\n')
	}
	rt.echo_val(rt.call_function('wp_kses_post', [rt.call_function('apply_filters', [rt.new_string('woocommerce_email_footer_text'), rt.call_function('get_option', [rt.new_string('woocommerce_email_footer_text')])])]))
}
