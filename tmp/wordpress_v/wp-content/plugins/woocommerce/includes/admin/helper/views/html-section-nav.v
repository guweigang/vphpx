import rt

struct Class_WC_Helper_Updater {
	rt.PhpObjectBase
}

fn create_wc_helper_updater() &Class_WC_Helper_Updater {
	mut obj := &Class_WC_Helper_Updater{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Helper_Updater) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Helper_Updater) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Helper_Updater) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_includes_admin_helper_views_html_section_nav_php() {
	mut var_addons_url := rt.call_function('admin_url', [rt.new_string('admin.php?page=wc-admin&path=/extensions&tab=extensions')])
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [var_addons_url.dup()]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Browse Extensions'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	mut var_count_html := fn () rt.PhpVal { mut temp := Class_WC_Helper_Updater{}; return temp.get_updates_count_html() }()
	mut var_menu_title := rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('My Subscriptions %s'), rt.new_string('woocommerce')]), var_count_html.dup()])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [rt.call_function('admin_url', [rt.new_string('admin.php?page=wc-addons&section=helper')])]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wp_kses_post', [var_menu_title.dup()]))
	// unsupported statement: Stmt_InlineHTML
}
