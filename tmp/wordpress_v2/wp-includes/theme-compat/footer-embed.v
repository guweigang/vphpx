import rt

fn main() {
	defer {
		rt.shutdown()
	}

	rt.call_function('do_action', [rt.new_string('embed_footer')])
	// unsupported statement: Stmt_InlineHTML
}
