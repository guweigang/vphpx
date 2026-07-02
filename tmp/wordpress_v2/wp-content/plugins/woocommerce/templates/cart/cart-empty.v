import rt

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
	rt.call_function('do_action', [rt.new_string('woocommerce_cart_is_empty')])
	if rt.is_true(rt.greater(rt.call_function('wc_get_page_id', [
		rt.new_string('shop')]), rt.new_int(0)))
	{
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [
			rt.new_string((if rt.is_true(rt.call_function('wc_wp_theme_get_element_class_name', [
				rt.new_string('button'),
			]))
			{
				' ' +(rt.call_function('wc_wp_theme_get_element_class_name', [rt.new_string('button')])).str()
			} else {
				''
			}).str()),
		]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_url', [
			rt.call_function('apply_filters', [
				rt.new_string('woocommerce_return_to_shop_redirect'),
				rt.call_function('wc_get_page_permalink', [rt.new_string('shop')]),
			]),
		]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_html', [
			rt.call_function('apply_filters', [
				rt.new_string('woocommerce_return_to_shop_text'),
				rt.call_function('__', [rt.new_string('Return to shop'),
					rt.new_string('woocommerce')]),
			]),
		]))
		// unsupported statement: Stmt_InlineHTML
	}
}
