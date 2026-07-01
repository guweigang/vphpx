import rt

pub fn init_wp_content_plugins_woocommerce_templates_single_product_review_php() {
	mut var_comment := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		// unsupported expression: Expr_Exit
		// unsupported statement: Stmt_Nop
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('comment_class', []rt.PhpVal{})
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('comment_ID', []rt.PhpVal{})
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('comment_ID', []rt.PhpVal{})
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string('woocommerce_review_before'),
		var_comment.dup()])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [
		rt.new_string('woocommerce_review_before_comment_meta'),
		var_comment.dup(),
	])
	rt.call_function('do_action', [rt.new_string('woocommerce_review_meta'),
		var_comment.dup()])
	rt.call_function('do_action', [
		rt.new_string('woocommerce_review_before_comment_text'),
		var_comment.dup(),
	])
	rt.call_function('do_action', [rt.new_string('woocommerce_review_comment_text'),
		var_comment.dup()])
	rt.call_function('do_action', [
		rt.new_string('woocommerce_review_after_comment_text'),
		var_comment.dup(),
	])
	// unsupported statement: Stmt_InlineHTML
}
