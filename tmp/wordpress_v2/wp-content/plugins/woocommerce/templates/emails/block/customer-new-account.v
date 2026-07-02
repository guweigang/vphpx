import rt

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('printf', [
		rt.call_function('esc_html__', [rt.new_string('Welcome to %s'),
			rt.new_string('woocommerce')]),
		rt.new_string('<!--[woocommerce/site-title]-->'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('printf', [
		rt.call_function('esc_html__', [rt.new_string('Hi %s,'),
			rt.new_string('woocommerce')]),
		rt.new_string('<!--[woocommerce/customer-first-name]-->'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('printf', [
		rt.call_function('esc_html__', [
			rt.new_string('Thanks for creating an account on %s. Here’s a copy of your user details.'),
			rt.new_string('woocommerce'),
		]),
		rt.new_string('<!--[woocommerce/site-title]-->'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wp_kses', [
		rt.call_function('sprintf', [
			rt.call_function('__', [rt.new_string('Username: <b>%s</b>'),
				rt.new_string('woocommerce')]),
			rt.new_string('<!--[woocommerce/customer-username]-->'),
		]),
		rt.create_array([
			rt.ArrayItem{ key: 'b', val: rt.new_array() },
		]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [
		Class_Automattic_WooCommerce_Internal_EmailEditor_BlockEmailRenderer.woo_email_content_placeholder(),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html__', [
		rt.new_string('You can access your account area to view orders, change your password, and more via the link below:'),
		rt.new_string('woocommerce'),
	]))
	// unsupported statement: Stmt_InlineHTML
	mut var_link_template := '<a data-link-href="%1$s" contenteditable="false" style="text-decoration: underline;">%2$s</a>'
	rt.call_function('printf', [rt.new_string('%s'),
		rt.call_function('wp_kses_post', [
			rt.call_function('sprintf', [rt.new_string(var_link_template.str()).clone(),
				rt.call_function('esc_attr', [
					rt.new_string('[woocommerce/my-account-url]'),
				]),
				rt.call_function('esc_html__', [
					rt.new_string('My account'),
					rt.new_string('woocommerce'),
				])]),
		])])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html__', [
		rt.new_string('We look forward to seeing you soon.'),
		rt.new_string('woocommerce'),
	]))
	// unsupported statement: Stmt_InlineHTML
}
