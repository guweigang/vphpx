import rt

interface IntegrationInterface {
	get_id() rt.PhpVal
	register_hooks() rt.PhpVal
	activate() rt.PhpVal
	deactivate() rt.PhpVal
	get_product_feed_query_args() rt.PhpVal
	create_feed() rt.PhpVal
	get_product_mapper() rt.PhpVal
	get_feed_validator() rt.PhpVal
}

pub fn init_wp_content_plugins_woocommerce_src_internal_productfeed_integrations_integrationinterface_php() {
	// unsupported statement: Stmt_Declare
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		// unsupported expression: Expr_Exit
	}
}
