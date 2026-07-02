import rt

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_msg := rt.new_null()
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [
		rt.call_function('wp_nonce_url', [
			rt.call_function('add_query_arg', [rt.new_string('wc-hide-notice'),
				rt.get_constant('WC_PHP_MIN_REQUIREMENTS_NOTICE')]),
			rt.new_string('woocommerce_hide_notices_nonce'),
			rt.new_string('_wc_notice_nonce'),
		]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Dismiss'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wp_kses_post', [
		rt.call_function('sprintf', [
			rt.new_string(var_msg.str() + '<p><a href="%s" class="button button-primary">' +
				(rt.call_function('__', [rt.new_string('Learn how to upgrade'), rt.new_string('woocommerce')])).str() +
				'</a></p>'),
			rt.call_function('add_query_arg', [
				rt.create_array([
					rt.ArrayItem{ key: 'utm_source', val: 'wpphpupdatebanner' },
					rt.ArrayItem{ key: 'utm_medium', val: 'product' },
					rt.ArrayItem{ key: 'utm_campaign', val: 'woocommerceplugin' },
					rt.ArrayItem{ key: 'utm_content', val: 'docs' },
				]),
				rt.new_string('https://woocommerce.com/document/update-php-wordpress/'),
			]),
		]),
	]))
	// unsupported statement: Stmt_InlineHTML
}
