import rt

struct Class_WC_Admin_Status {
	rt.PhpObjectBase
}

fn create_wc_admin_status() &Class_WC_Admin_Status {
	mut obj := &Class_WC_Admin_Status{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Admin_Status) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Admin_Status) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Admin_Status) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_includes_admin_views_html_notice_base_table_missing_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [rt.call_function('wp_nonce_url', [rt.call_function('add_query_arg', [rt.new_string('wc-hide-notice'), rt.new_string('base_tables_missing')]), rt.new_string('woocommerce_hide_notices_nonce'), rt.new_string('_wc_notice_nonce')])]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Dismiss'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Database tables missing'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	mut var_verify_db_tool_available := fn () rt.PhpVal { mut temp := Class_WC_Admin_Status{}; return temp.get_tools() }().array_isset(rt.new_string('verify_db_tables'))
	mut var_missing_tables := rt.call_function('get_option', [rt.new_string('woocommerce_schema_missing_tables')])
	if var_verify_db_tool_available {
		rt.echo_val(rt.call_function('wp_kses_post', [rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('One or more tables required for WooCommerce to function are missing, some features may not work as expected. Missing tables: %1$s. <a href="%2$s">Check again.</a>'), rt.new_string('woocommerce')]), rt.call_function('esc_html', [rt.call_function('implode', [rt.new_string(', '), var_missing_tables.dup()])]), rt.call_function('wp_nonce_url', [rt.call_function('admin_url', [rt.new_string('admin.php?page=wc-status&tab=tools&action=verify_db_tables')]), rt.new_string('debug_action')])])]))
	} else {
		rt.echo_val(rt.call_function('wp_kses_post', [rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('One or more tables required for WooCommerce to function are missing, some features may not work as expected. Missing tables: %1$s.'), rt.new_string('woocommerce')]), rt.call_function('esc_html', [rt.call_function('implode', [rt.new_string(', '), var_missing_tables.dup()])])])]))
	}
	// unsupported statement: Stmt_InlineHTML
}
