import rt

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_template_html := rt.call_function('get_the_block_template_html', []rt.PhpVal{})
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('language_attributes', []rt.PhpVal{})
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('bloginfo', [rt.new_string('charset')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('wp_head', []rt.PhpVal{})
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('body_class', []rt.PhpVal{})
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('wp_body_open', []rt.PhpVal{})
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_template_html)
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('wp_footer', []rt.PhpVal{})
	// unsupported statement: Stmt_InlineHTML
}
