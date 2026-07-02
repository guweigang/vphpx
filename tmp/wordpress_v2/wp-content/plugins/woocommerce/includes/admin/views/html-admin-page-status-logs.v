import rt

struct Class_Automattic_WooCommerce_Utilities_LoggingUtil {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_utilities_loggingutil(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Utilities_LoggingUtil {
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

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_logs := rt.new_null()
	mut var_viewed_log := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		exit(0)
	}
	mut iife_temp_0 := Class_Automattic_WooCommerce_Utilities_LoggingUtil{}
	mut iife_result_0 := iife_temp_0.get_log_directory()
	mut var_log_directory := iife_result_0
	if rt.is_true(var_logs) {
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_html', [var_viewed_log.clone()]))
		// unsupported statement: Stmt_InlineHTML
		if !(!rt.is_true(var_viewed_log)) {
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_url', [
				rt.call_function('wp_nonce_url', [
					rt.call_function('add_query_arg', [
						rt.create_array([
							rt.ArrayItem{ key: 'handle', val: rt.call_function('sanitize_title', [
								var_viewed_log.clone(),
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
		mut iter_1 := var_logs.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_log_file := item_1.val
			mut var_log_key := item_1.key
			// unsupported statement: Stmt_InlineHTML
			mut var_timestamp := rt.call_function('filemtime', [
				rt.new_string(var_log_directory.str() + var_log_file.str()),
			])
			mut var_date := rt.call_function('sprintf', [
				rt.call_function('__', [rt.new_string('%1$s at %2$s %3$s'),
					rt.new_string('woocommerce')]),
				rt.call_function('wp_date', [rt.call_function('wc_date_format', []rt.PhpVal{}),
					var_timestamp.clone()]),
				rt.call_function('wp_date', [rt.call_function('wc_time_format', []rt.PhpVal{}),
					var_timestamp.clone()]),
				rt.call_function('wp_date', [rt.new_string('T'),
					var_timestamp.clone()]),
			])
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [var_log_key.clone()]))
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('selected', [
				rt.call_function('sanitize_title', [var_viewed_log.clone()]),
				var_log_key.clone(),
			])
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_html', [var_log_file.clone()]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_html', [var_date.clone()]))
			// unsupported statement: Stmt_InlineHTML
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
				rt.new_string(var_log_directory.str() + var_viewed_log.str()),
			]),
		]))
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
