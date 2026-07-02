import rt

struct Class_WC_Woo_Update_Manager_Plugin {
	rt.PhpObjectBase
}

fn create_wc_woo_update_manager_plugin(_args ...rt.PhpVal) &Class_WC_Woo_Update_Manager_Plugin {
	mut obj := &Class_WC_Woo_Update_Manager_Plugin{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Woo_Update_Manager_Plugin) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Woo_Update_Manager_Plugin) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Woo_Update_Manager_Plugin) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [
		rt.call_function('wp_nonce_url', [
			rt.call_function('add_query_arg', [rt.new_string('wc-hide-notice'),
				rt.new_string('woo_updater_not_installed')]),
			rt.new_string('woocommerce_hide_notices_nonce'),
			rt.new_string('_wc_notice_nonce'),
		]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Dismiss'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	mut iife_temp_0 := Class_WC_Woo_Update_Manager_Plugin{}
	mut iife_result_0 := iife_temp_0.generate_install_url()
	mut iife_temp_1 := Class_WC_Woo_Update_Manager_Plugin{}
	mut iife_result_1 := iife_temp_1.generate_install_url()
	mut iife_temp_2 := Class_WC_Woo_Update_Manager_Plugin{}
	mut iife_result_2 := iife_temp_2.generate_install_url()
	mut iife_temp_3 := Class_WC_Woo_Update_Manager_Plugin{}
	mut iife_result_3 := iife_temp_3.generate_install_url()
	rt.echo_val(rt.call_function('wp_kses_post', [
		rt.call_function('sprintf', [
			rt.call_function('__', [
				rt.new_string('Please <a href="%1$s">Install the WooCommerce.com Update Manager</a> to continue receiving the updates and streamlined support included in your WooCommerce.com subscriptions. Alternatively, you can <a href="%2$s">download</a> and install it manually.'),
				rt.new_string('woocommerce'),
			]),
			rt.call_function('esc_url', [
				iife_result_0,
			]),
			rt.call_function('esc_url', [
				Class_WC_Woo_Update_Manager_Plugin.woo_update_manager_download_url(),
			]),
		]),
	]))
	// unsupported statement: Stmt_InlineHTML
}
