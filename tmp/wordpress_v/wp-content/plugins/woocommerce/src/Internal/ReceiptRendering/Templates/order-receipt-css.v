import rt

pub fn init_wp_content_plugins_woocommerce_src_internal_receiptrendering_templates_order_receipt_css_php() {
	mut var_data := map[string]rt.PhpVal{}
	// unsupported statement: Stmt_Nop
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_data.array_get('constants').array_get('font_size'))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_data.array_get('constants').array_get('margin'))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_data.array_get('constants').array_get('title_font_size'))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.div(var_data.array_get('constants').array_get('margin'), rt.new_int(2)))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.div(var_data.array_get('constants').array_get('margin'), rt.new_int(2)))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_data.array_get('constants').array_get('footer_font_size'))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_data.array_get('constants').array_get('margin'))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_data.array_get('constants').array_get('margin'))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_data.array_get('constants').array_get('line_height'))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.div(var_data.array_get('constants').array_get('margin'), rt.new_int(2)))
	// unsupported statement: Stmt_InlineHTML
	if var_data.array_isset(rt.new_string('payment_info')) {
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(var_data.array_get('constants').array_get('icon_width'))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(var_data.array_get('constants').array_get('icon_height'))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(var_data.array_get('payment_info').array_get('card_icon'))
		// unsupported statement: Stmt_InlineHTML
	}
}
