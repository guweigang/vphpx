import rt

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_post := rt.new_null()
	mut var_product := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		exit(0)
	}
	if rt.is_true(rt.call_method(var_product, 'is_on_sale', []rt.PhpVal{})) {
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('apply_filters', [
			rt.new_string('woocommerce_sale_flash'),
			rt.new_string('<span class="onsale">' +
				(rt.call_function('esc_html__', [rt.new_string('Sale!'), rt.new_string('woocommerce')])).str() +
				'</span>'),
			var_post.clone(),
			var_product.clone(),
		]))
		// unsupported statement: Stmt_InlineHTML
	}
}
