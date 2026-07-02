import rt

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
	rt.call_function('get_header', [rt.new_string('shop')])
	rt.call_function('do_action', [rt.new_string('woocommerce_before_main_content')])
	rt.call_function('do_action', [rt.new_string('woocommerce_shop_loop_header')])
	if rt.is_true(rt.call_function('woocommerce_product_loop', []rt.PhpVal{})) {
		rt.call_function('do_action', [rt.new_string('woocommerce_before_shop_loop')])
		rt.call_function('woocommerce_product_loop_start', []rt.PhpVal{})
		if rt.is_true(rt.call_function('wc_get_loop_prop', [rt.new_string('total')])) {
			for rt.is_true(rt.call_function('have_posts', []rt.PhpVal{})) {
				rt.call_function('the_post', []rt.PhpVal{})
				rt.call_function('do_action', [rt.new_string('woocommerce_shop_loop')])
				rt.call_function('wc_get_template_part', [rt.new_string('content'),
					rt.new_string('product')])
			}
		}
		rt.call_function('woocommerce_product_loop_end', []rt.PhpVal{})
		rt.call_function('do_action', [rt.new_string('woocommerce_after_shop_loop')])
	} else {
		rt.call_function('do_action', [rt.new_string('woocommerce_no_products_found')])
	}
	rt.call_function('do_action', [rt.new_string('woocommerce_after_main_content')])
	rt.call_function('do_action', [rt.new_string('woocommerce_sidebar')])
	rt.call_function('get_footer', [rt.new_string('shop')])
}
