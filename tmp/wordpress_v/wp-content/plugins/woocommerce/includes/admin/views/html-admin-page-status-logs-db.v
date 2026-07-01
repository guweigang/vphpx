import rt

pub fn init_wp_content_plugins_woocommerce_includes_admin_views_html_admin_page_status_logs_db_php() {
	mut var_log_table_list := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		// unsupported expression: Expr_Exit
	}
	mut var_delete_confirmation_js := rt.call_function('sprintf', [
		rt.new_string("return window.confirm( '%s' )"),
		rt.call_function('esc_js', [
			rt.call_function('__', [
				rt.new_string('Are you sure you want to clear all logs from the database?'),
				rt.new_string('woocommerce'),
			]),
		]),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_method(var_log_table_list, 'search_box', [
		rt.call_function('__', [rt.new_string('Search logs'),
			rt.new_string('woocommerce')]),
		rt.new_string('log'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_method(var_log_table_list, 'display', []rt.PhpVal{})
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('submit_button', [
		rt.call_function('__', [rt.new_string('Flush all logs'),
			rt.new_string('woocommerce')]),
		rt.new_string('delete'),
		rt.new_string('flush-logs'),
		rt.new_bool(true),
		rt.create_array([rt.ArrayItem{ key: 'onclick', val: rt.call_function('esc_attr', [
			var_delete_confirmation_js.dup(),
		]) }]),
	])
	// unsupported statement: Stmt_InlineHTML
}
