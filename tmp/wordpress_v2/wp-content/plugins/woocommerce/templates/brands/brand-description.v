import rt

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_thumbnail := rt.new_null()
	mut var_image_size := rt.call_function('wc_get_image_size', [
		rt.new_string('shop_catalog'),
	])
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(var_thumbnail) {
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_url', [var_thumbnail.clone()]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [var_image_size.array_get(rt.new_string('width'))]))
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('do_shortcode', [
		rt.call_function('wpautop', [
			rt.call_function('wptexturize', [
				rt.call_function('term_description', []rt.PhpVal{}),
			]),
		]),
	]))
	// unsupported statement: Stmt_InlineHTML
}
