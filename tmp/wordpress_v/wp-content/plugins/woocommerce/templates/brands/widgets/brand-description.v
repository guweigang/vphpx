import rt

pub fn init_wp_content_plugins_woocommerce_templates_brands_widgets_brand_description_php() {
	mut var_woocommerce := rt.new_null()
	mut var_thumbnail := rt.new_null()
	mut var_brand := rt.new_null()
	// unsupported statement: Stmt_Declare
	// unsupported statement: Stmt_Global
	if rt.is_true(var_thumbnail) {
		rt.echo_val(rt.call_function('wc_get_brand_thumbnail_image', [
			var_brand.dup()]))
	}
	rt.echo_val(rt.call_function('wp_kses_post', [
		rt.call_function('wpautop', [
			rt.call_function('wptexturize', [
				rt.call_function('term_description', []rt.PhpVal{}),
			]),
		]),
	]))
}
