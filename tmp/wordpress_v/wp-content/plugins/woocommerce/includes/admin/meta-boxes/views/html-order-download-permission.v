import rt

pub fn init_wp_content_plugins_woocommerce_includes_admin_meta_boxes_views_html_order_download_permission_php() {
	mut var_download := rt.new_null()
	mut var_product := rt.new_null()
	mut var_file_count := rt.new_null()
	mut var_loop := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		// unsupported expression: Expr_Exit
	}
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [
		rt.call_method(var_download, 'get_id', []rt.PhpVal{}),
	]))
	// unsupported statement: Stmt_InlineHTML
	print(
		(rt.call_function('esc_attr', [rt.call_method(var_download, 'get_product_id', []rt.PhpVal{})])).str() +
		',' +(rt.call_function('esc_attr', [rt.call_method(var_download, 'get_download_id', []rt.PhpVal{})])).str())
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Revoke access'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('Click to toggle'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('printf', [rt.new_string('#%s &mdash; %s &mdash; %s: %s &mdash; '),
		rt.call_function('esc_html', [
			rt.call_method(var_product, 'get_id', []rt.PhpVal{}),
		]),
		rt.call_function('esc_html', [
			rt.call_function('apply_filters', [
				rt.new_string('woocommerce_admin_download_permissions_title'),
				rt.call_method(var_product, 'get_name', []rt.PhpVal{}),
				rt.call_method(var_download, 'get_product_id', []rt.PhpVal{}),
				rt.call_method(var_download, 'get_order_id', []rt.PhpVal{}),
				rt.call_method(var_download, 'get_order_key', []rt.PhpVal{}),
				rt.call_method(var_download, 'get_download_id', []rt.PhpVal{}),
			]),
		]),
		rt.call_function('esc_html', [
			var_file_count.dup(),
		]),
		rt.call_function('esc_html', [
			rt.call_function('wc_get_filename_from_url', [
				rt.call_method(var_product, 'get_file_download_path', [
					rt.call_method(var_download, 'get_download_id', []rt.PhpVal{}),
				]),
			]),
		])])
	rt.call_function('printf', [
		rt.call_function('_n', [rt.new_string('Downloaded %s time'),
			rt.new_string('Downloaded %s times'),
			rt.call_method(var_download, 'get_download_count',
				[]rt.PhpVal{}),
			rt.new_string('woocommerce')]),
		rt.call_function('esc_html', [rt.call_method(var_download, 'get_download_count',
			[]rt.PhpVal{})]),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Downloads remaining'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_loop.dup()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [
		rt.call_method(var_download, 'get_id', []rt.PhpVal{}),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_loop.dup()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [
		rt.call_method(var_download, 'get_downloads_remaining', []rt.PhpVal{}),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('Unlimited'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Access expires'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_loop.dup()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.call_method(var_download, 'get_access_expires', []rt.PhpVal{}).is_null()))))) { rt.call_function('esc_attr', [
			rt.call_function('date_i18n', [rt.new_string('Y-m-d'),
				rt.call_method(rt.call_method(var_download, 'get_access_expires', []rt.PhpVal{}), 'getTimestamp', []rt.PhpVal{})]),
		]) } else { rt.new_string('') })
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('Never'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [
		rt.call_function('apply_filters', [
			rt.new_string('woocommerce_date_input_html_pattern'),
			rt.new_string('[0-9]{4}-(0[1-9]|1[012])-(0[1-9]|1[0-9]|2[0-9]|3[01])'),
		]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Customer download link'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	mut var_download_link := rt.call_function('add_query_arg', [
		rt.create_array([
			rt.ArrayItem{ key: 'download_file', val: rt.call_method(var_download, 'get_product_id',
				[]rt.PhpVal{}) },
			rt.ArrayItem{ key: 'order', val: rt.call_method(var_download, 'get_order_key',
				[]rt.PhpVal{}) },
			rt.ArrayItem{ key: 'email', val: rt.call_function('urlencode', [
				rt.call_method(var_download, 'get_user_email', []rt.PhpVal{}),
			]) },
			rt.ArrayItem{ key: 'key', val: rt.call_method(var_download, 'get_download_id',
				[]rt.PhpVal{}) },
		]),
		rt.call_function('trailingslashit', [
			rt.call_function('home_url', []rt.PhpVal{}),
		]),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [var_download_link.dup()]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('Copied!'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [
		rt.new_string('Copying to clipboard failed. You should be able to right-click the button and copy.'),
		rt.new_string('woocommerce'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Copy link'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Customer download log'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	mut var_report_url := rt.call_function('add_query_arg', [
		rt.new_string('permission_id'),
		rt.call_function('rawurlencode', [
			rt.call_method(var_download, 'get_id', []rt.PhpVal{}),
		]),
		rt.call_function('admin_url', [
			rt.new_string('admin.php?page=wc-reports&tab=orders&report=downloads'),
		]),
	])
	print('<a class="button" href="' + (rt.call_function('esc_url', [var_report_url.dup()])).str() +
		'">')
	rt.call_function('esc_html_e', [rt.new_string('View report'),
		rt.new_string('woocommerce')])
	print('</a>')
	// unsupported statement: Stmt_InlineHTML
}
