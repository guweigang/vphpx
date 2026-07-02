import rt

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_woocommerce := rt.new_null()
	mut var_thumbnail := rt.new_null()
	mut var_brand := rt.new_null()
	if rt.is_true(var_thumbnail) {
		rt.echo_val(rt.call_function('wc_get_brand_thumbnail_image', [
			var_brand.clone()]))
	}
	rt.echo_val(rt.call_function('wp_kses_post', [
		rt.call_function('wpautop', [
			rt.call_function('wptexturize', [
				rt.call_function('term_description', []rt.PhpVal{}),
			]),
		]),
	]))
}
