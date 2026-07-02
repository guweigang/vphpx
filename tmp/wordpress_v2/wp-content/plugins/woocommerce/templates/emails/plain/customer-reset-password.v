import rt

struct Class_Automattic_WooCommerce_Utilities_FeaturesUtil {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_utilities_featuresutil(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Utilities_FeaturesUtil {
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

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_email_heading := rt.new_null()
	mut var_user_login := rt.new_null()
	mut var_blogname := rt.new_null()
	mut var_reset_key := rt.new_null()
	mut var_user_id := rt.new_null()
	mut var_additional_content := rt.new_null()
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
	mut iife_temp_0 := Class_Automattic_WooCommerce_Utilities_FeaturesUtil{}
	mut iife_result_0 := iife_temp_0.feature_is_enabled(rt.new_string('email_improvements'))
	mut var_email_improvements_enabled := iife_result_0
	print('=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=\n')
	rt.echo_val(rt.call_function('esc_html', [
		rt.call_function('wp_strip_all_tags', [var_email_heading.clone()]),
	]))
	print('\n=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=\n\n')
	print(
		(rt.call_function('sprintf', [rt.call_function('esc_html__', [rt.new_string('Hi %s,'), rt.new_string('woocommerce')]), rt.call_function('esc_html', [var_user_login.clone()])])).str() +
		'\n\n')
	print(
		(rt.call_function('sprintf', [rt.call_function('esc_html__', [rt.new_string('Someone has requested a new password for the following account on %s:'), rt.new_string('woocommerce')]), rt.call_function('esc_html', [var_blogname.clone()])])).str() +
		'\n\n')
	if rt.is_true(var_email_improvements_enabled) {
		print('----------------------------------------\n\n')
	}
	print(
		(rt.call_function('sprintf', [rt.call_function('esc_html__', [rt.new_string('Username: %s'), rt.new_string('woocommerce')]), rt.call_function('esc_html', [var_user_login.clone()])])).str() +
		'\n\n')
	if rt.is_true(var_email_improvements_enabled) {
		print('----------------------------------------\n\n')
		print(
			(rt.call_function('esc_html__', [rt.new_string('If you didn’t make this request, just ignore this email. If you’d like to proceed, reset your password via the link below:'), rt.new_string('woocommerce')])).str() +
			'\n\n')
	} else {
		print(
			(rt.call_function('esc_html__', [rt.new_string("If you didn't make this request, just ignore this email. If you'd like to proceed:"), rt.new_string('woocommerce')])).str() +
			'\n\n')
	}
	print(
		(rt.call_function('esc_url', [rt.call_function('add_query_arg', [rt.create_array([rt.ArrayItem{
		key: 'key'
		val: var_reset_key
	}, rt.ArrayItem{ key: 'id', val: var_user_id }, rt.ArrayItem{
		key: 'login'
		val: rt.call_function('rawurlencode', [var_user_login.clone()])
	}]), rt.call_function('wc_get_endpoint_url', [rt.new_string('lost-password'), rt.new_string(''), rt.call_function('wc_get_page_permalink', [rt.new_string('myaccount')])])])])).str() +
		'\n\n')
	print('\n\n----------------------------------------\n\n')
	if rt.is_true(var_additional_content) {
		rt.echo_val(rt.call_function('esc_html', [
			rt.call_function('wp_strip_all_tags', [
				rt.call_function('wptexturize', [var_additional_content.clone()]),
			]),
		]))
		print('\n\n----------------------------------------\n\n')
	}
	rt.echo_val(rt.call_function('wp_kses_post', [
		rt.call_function('apply_filters', [
			rt.new_string('woocommerce_email_footer_text'),
			rt.call_function('get_option', [
				rt.new_string('woocommerce_email_footer_text'),
			]),
		]),
	]))
}
