import rt

pub fn init_wp_content_plugins_woocommerce_patterns_coming_soon_store_only_php() {
	mut var_current_theme := rt.call_method(rt.call_function('wp_get_theme', []rt.PhpVal{}),
		'get_stylesheet', []rt.PhpVal{})
	mut var_inter_font_family := 'inter'
	mut var_cardo_font_family := 'cardo'
	if rt.is_true(rt.identical(rt.new_string('twentytwentyfour'), var_current_theme)) {
		var_inter_font_family = 'body'
		var_cardo_font_family = 'heading'
	}
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.call_function('wp_is_block_theme', []rt.PhpVal{})) {
		print('<!-- wp:template-part {"slug":"header","tagName":"header"} /-->')
	}
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [rt.new_string(var_cardo_font_family).dup()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [rt.new_string(var_cardo_font_family).dup()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html__', [
		rt.new_string('Great things are on the horizon'),
		rt.new_string('woocommerce'),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [rt.new_string(var_inter_font_family).dup()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [rt.new_string(var_inter_font_family).dup()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html__', [
		rt.new_string('Something big is brewing! Our store is in the works and will be launching soon!'),
		rt.new_string('woocommerce'),
	]))
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.call_function('wp_is_block_theme', []rt.PhpVal{})) {
		print('<!-- wp:template-part {"slug":"footer","tagName":"footer"} /-->')
	}
	// unsupported statement: Stmt_InlineHTML
}
