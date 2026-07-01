import rt

pub fn init_wp_content_plugins_woocommerce_includes_admin_importers_views_html_csv_import_footer_php() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		// unsupported expression: Expr_Exit
	}
	// unsupported statement: Stmt_InlineHTML
}
