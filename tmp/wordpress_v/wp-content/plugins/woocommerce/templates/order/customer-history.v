import rt



pub fn init_wp_content_plugins_woocommerce_templates_order_customer_history_php() {
	mut var_tooltip := rt.new_null()
	mut var_orders_count := rt.new_null()
	mut var_total_spend := rt.new_null()
	mut var_avg_order_value := rt.new_null()
	// unsupported statement: Stmt_Declare
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
	// unsupported statement: Stmt_Nop
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Total orders'), rt.new_string('woocommerce')])
	rt.echo_val(rt.call_function('wp_kses_post', [rt.call_function('wc_help_tip', [var_tooltip.dup()])]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_orders_count.dup()]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Total revenue'), rt.new_string('woocommerce')])
	rt.echo_val(rt.call_function('wp_kses_post', [rt.call_function('wc_help_tip', [rt.call_function('__', [rt.new_string('This is the Customer Lifetime Value, or the total amount you have earned from this customer\'s orders.'), rt.new_string('woocommerce')])])]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wp_kses_post', [rt.call_function('wc_price', [var_total_spend.dup()])]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Average order value'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wp_kses_post', [rt.call_function('wc_price', [var_avg_order_value.dup()])]))
	// unsupported statement: Stmt_InlineHTML
}
