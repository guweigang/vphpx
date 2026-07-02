import rt

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_email_heading := rt.new_null()
	mut var_username := rt.new_null()
	mut var_gateway_title := rt.new_null()
	mut var_gateway_settings_url := rt.new_null()
	mut var_admin_email := rt.new_null()
	mut var_additional_content := rt.new_null()
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
	print('=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=\n')
	rt.echo_val(rt.call_function('esc_html', [
		rt.call_function('wp_strip_all_tags', [var_email_heading.clone()]),
	]))
	print('\n=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=\n\n')
	print(
		(rt.call_function('sprintf', [rt.call_function('esc_html__', [rt.new_string('Howdy %s,'), rt.new_string('woocommerce')]), rt.call_function('esc_html', [var_username.clone()])])).str() +
		'\n\n')
	print(
		(rt.call_function('sprintf', [rt.call_function('esc_html__', [rt.new_string('The payment gateway "%1$s" was just enabled on this site: %2$s'), rt.new_string('woocommerce')]), rt.call_function('esc_html', [var_gateway_title.clone()]), rt.call_function('esc_html', [rt.call_function('home_url', []rt.PhpVal{})])])).str() +
		'\n\n')
	print(
		(rt.call_function('esc_html__', [rt.new_string('If you did not enable this payment gateway, please log in to your site and consider disabling it here:'), rt.new_string('woocommerce')])).str() +
		'\n')
	print((rt.call_function('esc_url', [var_gateway_settings_url.clone()])).str() + '\n\n')
	print(
		(rt.call_function('sprintf', [rt.call_function('esc_html__', [rt.new_string('This email has been sent to %s'), rt.new_string('woocommerce')]), rt.call_function('esc_html', [var_admin_email.clone()])])).str() +
		'\n\n')
	print('\n----------------------------------------\n\n')
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
