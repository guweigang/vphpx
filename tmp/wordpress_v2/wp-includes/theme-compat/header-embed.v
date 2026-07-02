import rt

fn main() {
	defer {
		rt.shutdown()
	}

	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('headers_sent', []rt.PhpVal{}))))) {
		rt.call_function('header', [rt.new_string('X-WP-embed: true')])
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('language_attributes', []rt.PhpVal{})
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wp_get_document_title', []rt.PhpVal{}))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string('embed_head')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('body_class', []rt.PhpVal{})
	// unsupported statement: Stmt_InlineHTML
}
