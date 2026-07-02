import rt

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_product := rt.new_null()
	mut var_args := rt.new_null()
	mut var_show_rating := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		exit(0)
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_a', [
		var_product.clone(), rt.new_string('WC_Product')])))))
	{
		return rt.new_null()
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [
		rt.new_string('woocommerce_widget_product_item_start'),
		var_args.clone(),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [
		rt.call_method(var_product, 'get_permalink', []rt.PhpVal{}),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_method(var_product, 'get_image', []rt.PhpVal{}))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wp_kses_post', [
		rt.call_method(var_product, 'get_name', []rt.PhpVal{}),
	]))
	// unsupported statement: Stmt_InlineHTML
	if !(!rt.is_true(var_show_rating)) {
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('wc_get_rating_html', [
			rt.call_method(var_product, 'get_average_rating', []rt.PhpVal{}),
		]))
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_method(var_product, 'get_price_html', []rt.PhpVal{}))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string('woocommerce_widget_product_item_end'),
		var_args.clone()])
	// unsupported statement: Stmt_InlineHTML
}
