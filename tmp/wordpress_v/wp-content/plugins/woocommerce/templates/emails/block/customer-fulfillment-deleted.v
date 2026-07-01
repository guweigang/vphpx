import rt



pub fn init_wp_content_plugins_woocommerce_templates_emails_block_customer_fulfillment_deleted_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
	// unsupported statement: Stmt_Nop
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html__', [rt.new_string('One of your shipments has been removed'), rt.new_string('woocommerce')]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html__', [rt.new_string('We wanted to let you know that one of the previously fulfilled shipments from your order has been removed from our system. This may have been due to a correction or an update in our fulfillment records. Don’t worry — this won’t affect any items you’ve already received.'), rt.new_string('woocommerce')]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [Class_Automattic_WooCommerce_Internal_EmailEditor_BlockEmailRenderer.woo_email_content_placeholder()]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('printf', [rt.call_function('esc_html__', [rt.new_string('Thanks again! If you need any help with your order, please contact us at %s.'), rt.new_string('woocommerce')]), rt.new_string('<!--[woocommerce/store-email]-->')])
	// unsupported statement: Stmt_InlineHTML
}
