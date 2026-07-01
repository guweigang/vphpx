import rt

pub fn init_wp_content_plugins_woocommerce_includes_admin_settings_views_html_admin_page_shipping_zones_instance_php() {
	mut var_zone := rt.new_null()
	mut var_shipping_method := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		// unsupported expression: Expr_Exit
	}
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('admin_url', [
		rt.new_string('admin.php?page=wc-settings&tab=shipping'),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Shipping zones'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('admin_url', [
		'admin.php?page=wc-settings&tab=shipping&zone_id=' +
			(rt.call_function('absint', [rt.call_method(var_zone, 'get_id', []rt.PhpVal{})])).str(),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [
		rt.call_method(var_zone, 'get_zone_name', []rt.PhpVal{}),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [
		rt.call_method(var_shipping_method, 'get_method_title', []rt.PhpVal{}),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_method(var_shipping_method, 'admin_options', []rt.PhpVal{})
}
