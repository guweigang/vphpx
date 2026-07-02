import rt

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_notices := rt.new_null()
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
	// unsupported statement: Stmt_InlineHTML
	mut iter_1 := var_notices.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_notice := item_1.val
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('sanitize_html_class', [
			var_notice.array_get(rt.new_string('type')),
		]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('wpautop', [var_notice.array_get(rt.new_string('message'))]))
		// unsupported statement: Stmt_InlineHTML
	}
}
