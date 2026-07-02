import rt

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_args := rt.new_null()
	mut var_comment := rt.new_null()
	mut var_product := rt.new_null()
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [
		rt.new_string('woocommerce_widget_product_review_item_start'),
		var_args.clone(),
	])
	// unsupported statement: Stmt_InlineHTML
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [
		rt.call_function('get_comment_link', [rt.get_property(var_comment, 'comment_ID')]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_method(var_product, 'get_image', []rt.PhpVal{}))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wp_kses_post', [
		rt.call_method(var_product, 'get_name', []rt.PhpVal{}),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wc_get_rating_html', [
		rt.new_int(rt.call_function('get_comment_meta', [
			rt.get_property(var_comment, 'comment_ID'),
			rt.new_string('rating'),
			rt.new_bool(true),
		]).to_i64()),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('sprintf', [
		rt.call_function('esc_html__', [rt.new_string('by %s'),
			rt.new_string('woocommerce')]),
		rt.call_function('get_comment_author', [rt.get_property(var_comment, 'comment_ID')]),
	]))
	// unsupported statement: Stmt_InlineHTML
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [
		rt.new_string('woocommerce_widget_product_review_item_end'),
		var_args.clone(),
	])
	// unsupported statement: Stmt_InlineHTML
}
