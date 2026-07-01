import rt

struct Class_Automattic_WooCommerce_Utilities_LoggingUtil {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_utilities_loggingutil() &Class_Automattic_WooCommerce_Utilities_LoggingUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_LoggingUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Utilities_LoggingUtil) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Utilities_LoggingUtil) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_LoggingUtil) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_content_plugins_woocommerce_includes_admin_views_html_admin_page_status_logs_php() {
	mut var_logs := rt.new_null()
	mut var_viewed_log := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		// unsupported expression: Expr_Exit
	}
	mut var_log_directory := fn () rt.PhpVal {
		mut temp := Class_Automattic_WooCommerce_Utilities_LoggingUtil{}
		return temp.get_log_directory()
	}()
	if rt.is_true(var_logs) {
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_html', [var_viewed_log.dup()]))
		// unsupported statement: Stmt_InlineHTML
		if !(!rt.is_true(var_viewed_log)) {
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_url', [
				rt.call_function('wp_nonce_url', [
					rt.call_function('add_query_arg', [
						rt.create_array([
							rt.ArrayItem{ key: 'handle', val: rt.call_function('sanitize_title', [
								var_viewed_log.dup(),
							]) },
						]),
						rt.call_function('admin_url', [
							rt.new_string('admin.php?page=wc-status&tab=logs'),
						]),
					]),
					rt.new_string('remove_log'),
				]),
			]))
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('esc_html_e', [rt.new_string('Delete log'),
				rt.new_string('woocommerce')])
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_url', [
			rt.call_function('admin_url', [
				rt.new_string('admin.php?page=wc-status&tab=logs'),
			]),
		]))
		// unsupported statement: Stmt_InlineHTML
		{
			mut iter_1 := var_logs.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_log_file := item_1.val
				mut var_log_key := item_1.key
				// unsupported statement: Stmt_InlineHTML
				mut var_timestamp := rt.call_function('filemtime', [
					rt.concat(var_log_directory, var_log_file),
				])
				mut var_date := rt.call_function('sprintf', [
					rt.call_function('__', [rt.new_string('%1$s at %2$s %3$s'),
						rt.new_string('woocommerce')]),
					rt.call_function('wp_date', [rt.call_function('wc_date_format', []rt.PhpVal{}),
						var_timestamp.dup()]),
					rt.call_function('wp_date', [rt.call_function('wc_time_format', []rt.PhpVal{}),
						var_timestamp.dup()]),
					rt.call_function('wp_date', [rt.new_string('T'),
						var_timestamp.dup()]),
				])
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_attr', [var_log_key.dup()]))
				// unsupported statement: Stmt_InlineHTML
				rt.call_function('selected', [
					rt.call_function('sanitize_title', [var_viewed_log.dup()]),
					var_log_key.dup(),
				])
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_html', [var_log_file.dup()]))
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_html', [var_date.dup()]))
				// unsupported statement: Stmt_InlineHTML
			}
		}
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_attr_e', [rt.new_string('View'),
			rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('View'),
			rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_html', [
			rt.call_function('file_get_contents', [
				rt.concat(var_log_directory, var_viewed_log),
			]),
		]))
		// unsupported statement: Stmt_Nop
		// unsupported statement: Stmt_InlineHTML
	} else {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [
			rt.new_string('There are currently no logs to view.'),
			rt.new_string('woocommerce'),
		])
		// unsupported statement: Stmt_InlineHTML
	}
}
