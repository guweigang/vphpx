import rt

fn main() {
	defer {
		rt.shutdown()
	}

	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html__', [rt.new_string('Related products'),
		rt.new_string('woocommerce')]))
	// unsupported statement: Stmt_InlineHTML
}
