import rt

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_item_data := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		exit(0)
	}
	// unsupported statement: Stmt_InlineHTML
	mut iter_1 := var_item_data.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_data := item_1.val
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('sanitize_html_class', [
			rt.new_string('variation-' + (var_data.array_get(rt.new_string('key'))).str()),
		]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('wp_kses_post', [var_data.array_get(rt.new_string('key'))]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('sanitize_html_class', [
			rt.new_string('variation-' + (var_data.array_get(rt.new_string('key'))).str()),
		]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('wp_kses_post', [
			rt.call_function('wpautop', [var_data.array_get(rt.new_string('display'))]),
		]))
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
}
