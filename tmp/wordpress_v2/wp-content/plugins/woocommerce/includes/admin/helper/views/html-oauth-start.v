import rt

struct Class_WC_Helper {
	rt.PhpObjectBase
}

fn create_wc_helper(_args ...rt.PhpVal) &Class_WC_Helper {
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

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_connect_url := rt.new_null()
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
	// unsupported statement: Stmt_InlineHTML
	mut iife_temp_0 := Class_WC_Helper{}
	mut iife_result_0 := iife_temp_0.get_view_filename(rt.new_string('html-section-nav.php'))
	rt.include_file(iife_result_0.to_string(), '3')
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('WooCommerce Extensions'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	mut iife_temp_1 := Class_WC_Helper{}
	mut iife_result_1 := iife_temp_1.get_view_filename(rt.new_string('html-section-notices.php'))
	rt.include_file(iife_result_1.to_string(), '3')
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [
		rt.new_string(
			(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'plugin_url', []rt.PhpVal{})).str() +
			'/assets/images/woo-logo.svg'),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('WooCommerce'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	if !(!rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('wc-helper-status'))))
		&& rt.is_true(rt.identical(rt.new_string('helper-disconnected'), rt.get_superglobal('_GET').array_get(rt.new_string('wc-helper-status')))) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Sorry to see you go.'),
			rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [
			rt.new_string('Feel free to reconnect again using the button below.'),
			rt.new_string('woocommerce'),
		])
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [
		rt.new_string('Manage your subscriptions, get important product notifications, and updates, all from the convenience of your WooCommerce dashboard'),
		rt.new_string('woocommerce'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [
		rt.new_string('Once connected, your WooCommerce.com purchases will be listed here.'),
		rt.new_string('woocommerce'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [var_connect_url.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Connect'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
}
