import rt

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_main_header := rt.call_function('__', [
		rt.new_string('What our customers say'),
		rt.new_string('woocommerce'),
	])
	mut var_first_review := rt.call_function('__', [
		rt.new_string('Eclectic finds, ethical delights'),
		rt.new_string('woocommerce'),
	])
	mut var_second_review := rt.call_function('__', [rt.new_string('Sip, Shop, Savor'),
		rt.new_string('woocommerce')])
	mut var_third_review := rt.call_function('__', [rt.new_string('LOCAL LOVE'),
		rt.new_string('woocommerce')])
	mut var_first_description := rt.call_function('__', [
		rt.new_string('Transformed my daily routine with unique, eco-friendly treasures. Exceptional quality and service. Proud to support a store that aligns with my values.'),
		rt.new_string('woocommerce'),
	])
	mut var_second_description := rt.call_function('__', [
		rt.new_string('The organic coffee beans are a revelation. Each sip feels like a journey. Beautifully crafted accessories add a touch of elegance to my home.'),
		rt.new_string('woocommerce'),
	])
	mut var_third_description := rt.call_function('__', [
		rt.new_string('From sustainably sourced teas to chic vases, this store is a treasure trove. Love knowing my purchases contribute to a greener planet.'),
		rt.new_string('woocommerce'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_main_header.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_first_review.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_first_description.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_second_review.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_second_description.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_third_review.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_third_description.clone()]))
	// unsupported statement: Stmt_InlineHTML
}
