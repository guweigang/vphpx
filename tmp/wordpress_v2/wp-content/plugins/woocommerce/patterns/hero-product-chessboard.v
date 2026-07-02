import rt

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_image1 := rt.call_function('plugins_url', [
		rt.new_string('assets/images/pattern-placeholders/plant-white-leaf-flower-vase-green.jpg'),
		rt.get_constant('WC_PLUGIN_FILE'),
	])
	mut var_image2 := rt.call_function('plugins_url', [
		rt.new_string('assets/images/pattern-placeholders/table-wood-house-chair-floor-window.jpg'),
		rt.get_constant('WC_PLUGIN_FILE'),
	])
	mut var_first_title := rt.call_function('__', [rt.new_string('Quality Materials'),
		rt.new_string('woocommerce')])
	mut var_second_title := rt.call_function('__', [rt.new_string('Unique design'),
		rt.new_string('woocommerce')])
	mut var_third_title := rt.call_function('__', [
		rt.new_string('Make your house feel like home'),
		rt.new_string('woocommerce'),
	])
	mut var_first_description := rt.call_function('__', [
		rt.new_string('We use only the highest-quality materials in our products, ensuring that they look great and last for years to come.'),
		rt.new_string('woocommerce'),
	])
	mut var_second_description := rt.call_function('__', [
		rt.new_string('From bold prints to intricate details, our products are a perfect combination of style and function.'),
		rt.new_string('woocommerce'),
	])
	mut var_third_description := rt.call_function('__', [
		rt.new_string('Add a touch of charm and coziness this holiday season with a wide selection of hand-picked decorations — from minimalist vases to designer furniture.'),
		rt.new_string('woocommerce'),
	])
	mut var_button := rt.call_function('__', [rt.new_string('Shop home decor'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [var_image1.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [
		rt.new_string('Placeholder image used to represent a product being showcased in a hero section. 1 out of 2.'),
		rt.new_string('woocommerce'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [var_image1.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_third_title.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_third_description.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [
		rt.call_function('wc_get_page_permalink', [rt.new_string('shop')]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_button.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_first_title.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_first_description.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_second_title.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_second_description.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [var_image2.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [
		rt.new_string('Placeholder image used to represent a product being showcased in a hero section. 2 out of 2.'),
		rt.new_string('woocommerce'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [var_image2.clone()]))
	// unsupported statement: Stmt_InlineHTML
}
