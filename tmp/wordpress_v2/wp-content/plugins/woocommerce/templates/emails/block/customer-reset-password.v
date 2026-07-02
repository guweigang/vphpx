import rt

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html__', [rt.new_string('Reset your password'),
		rt.new_string('woocommerce')]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('printf', [
		rt.call_function('esc_html__', [rt.new_string('Hi %s,'),
			rt.new_string('woocommerce')]),
		rt.new_string('<!--[woocommerce/customer-username]-->'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('printf', [
		rt.call_function('esc_html__', [
			rt.new_string('Someone has requested a new password for the following account on %s:'),
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
	rt.echo_val(rt.call_function('esc_html__', [
		rt.new_string('If you didn’t make this request, just ignore this email. If you’d like to proceed, reset your password via the link below:'),
		rt.new_string('woocommerce'),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [
		Class_Automattic_WooCommerce_Internal_EmailEditor_BlockEmailRenderer.woo_email_content_placeholder(),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html__', [rt.new_string('Thanks for reading.'),
		rt.new_string('woocommerce')]))
	// unsupported statement: Stmt_InlineHTML
}
