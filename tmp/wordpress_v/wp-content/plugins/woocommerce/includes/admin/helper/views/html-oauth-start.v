import rt

struct Class_WC_Helper {
	rt.PhpObjectBase
}

fn create_wc_helper() &Class_WC_Helper {
	mut obj := &Class_WC_Helper{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Helper) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Helper) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Helper) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_includes_admin_helper_views_html_oauth_start_php() {
	mut var_connect_url := rt.new_null()
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
	// unsupported statement: Stmt_InlineHTML
	rt.include_file((fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Helper{}; return temp.get_view_filename(arg_0) }(rt.new_string('html-section-nav.php'))).to_string(), '3')
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('WooCommerce Extensions'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.include_file((fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Helper{}; return temp.get_view_filename(arg_0) }(rt.new_string('html-section-notices.php'))).to_string(), '3')
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'plugin_url', []rt.PhpVal{})).str() + '/assets/images/woo-logo.svg']))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('WooCommerce'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.new_bool(!(!rt.is_true(rt.get_superglobal('_GET').array_get('wc-helper-status'))) && rt.is_true(rt.identical(rt.new_string('helper-disconnected'), rt.get_superglobal('_GET').array_get('wc-helper-status'))))) {
		// unsupported statement: Stmt_Nop
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Sorry to see you go.'), rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Feel free to reconnect again using the button below.'), rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Manage your subscriptions, get important product notifications, and updates, all from the convenience of your WooCommerce dashboard'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Once connected, your WooCommerce.com purchases will be listed here.'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [var_connect_url.dup()]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Connect'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
}
