import rt

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_product := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		exit(0)
	}
	mut var_image := rt.call_function('wp_get_attachment_image_src', [
		rt.call_method(var_product, 'get_image_id', []rt.PhpVal{}),
		rt.new_string('woocommerce_thumbnail'),
	])
	mut var_image_src := if var_image.clone().is_array() && var_image.array_isset(rt.new_int(0)) {
		var_image.array_get(rt.new_int(0))
	} else {
		rt.new_string('')
	}
	mut var_stock_availability := rt.call_method(var_product, 'get_availability', []rt.PhpVal{})
	mut var_identifier := rt.new_string('#' +
		(rt.call_method(var_product, 'get_id', []rt.PhpVal{})).str())
	if !(!rt.is_true(rt.call_method(var_product, 'get_sku', []rt.PhpVal{}))) {
		var_identifier = rt.call_method(var_product, 'get_sku', []rt.PhpVal{})
	}
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [if rt.is_true(var_image_src) {
		var_image_src
	} else {
		rt.call_function('wc_placeholder_img_src', []rt.PhpVal{})
	}]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [
		rt.call_method(var_product, 'get_name', []rt.PhpVal{}),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [
		rt.call_method(var_product, 'get_name', []rt.PhpVal{}),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('printf', [rt.new_string('(%s)'),
		rt.call_function('esc_html', [var_identifier.clone()])])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [
		rt.call_function('admin_url', [
			rt.call_function('sprintf', [rt.new_string('post.php?post=%d&action=edit'),
				if rt.is_true(rt.call_method(var_product, 'get_parent_id', []rt.PhpVal{})) {
					rt.call_method(var_product, 'get_parent_id', []rt.PhpVal{})
				} else {
					rt.call_method(var_product, 'get_id', []rt.PhpVal{})
				}]),
		]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wp_kses_post', [
		rt.call_method(var_product, 'get_price_html', [rt.new_string('edit')]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr',
		[var_stock_availability.array_get(rt.new_string('class'))]))
	// unsupported statement: Stmt_InlineHTML
	if !rt.is_true(var_stock_availability.array_get(rt.new_string('availability')))
		&& rt.is_true(rt.identical(rt.new_string('in-stock'), var_stock_availability.array_get(rt.new_string('class')))) {
		rt.echo_val(rt.call_function('esc_html__', [rt.new_string('In stock'),
			rt.new_string('woocommerce')]))
	} else {
		rt.echo_val(rt.call_function('esc_html', [
			var_stock_availability.array_get(rt.new_string('availability')),
		]))
	}
	// unsupported statement: Stmt_InlineHTML
}
