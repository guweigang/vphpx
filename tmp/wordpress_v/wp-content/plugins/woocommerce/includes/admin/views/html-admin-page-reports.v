import rt



pub fn init_wp_content_plugins_woocommerce_includes_admin_views_html_admin_page_reports_php() {
	mut var_reports := rt.new_null()
	mut var_current_tab := rt.new_null()
	mut var_current_report := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))))) {
		// unsupported expression: Expr_Exit
	}
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'is_wc_admin_active', []rt.PhpVal{})) {
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('wp_kses_post', [rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('With the release of WooCommerce 4.0, these reports are being replaced. There is a new and better Analytics section available for users running WordPress 5.3+. Head on over to the <a href="%1$s">WooCommerce Analytics</a> or learn more about the new experience in the <a href="https://woocommerce.com/document/woocommerce-analytics/" target="_blank">WooCommerce Analytics documentation</a>.'), rt.new_string('woocommerce')]), rt.call_function('esc_url', [rt.call_function('wc_admin_url', [rt.new_string('&path=/analytics/overview')])])])]))
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	{
		mut iter_1 := var_reports.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_report_group := item_1.val
			mut var_key := item_1.key
			print('<a href="' + (rt.call_function('admin_url', ['admin.php?page=wc-reports&tab=' + (rt.call_function('urlencode', [var_key.dup()])).str()])).str() + '" class="nav-tab ')
			if rt.is_true(rt.equal(var_current_tab, var_key)) {
				print('nav-tab-active')
			}
			print('">' + (rt.call_function('esc_html', [var_report_group.array_get('title')])).str() + '</a>')
		}
	}
	rt.call_function('do_action', [rt.new_string('wc_reports_tabs')])
	// unsupported statement: Stmt_InlineHTML
	if var_reports.array_get(var_current_tab).array_get('reports').array_count() > 1 {
		// unsupported statement: Stmt_InlineHTML
		mut var_links := []rt.PhpVal{}
		{
			mut iter_1 := var_reports.array_get(var_current_tab).array_get('reports').iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_report := item_1.val
				mut var_key := item_1.key
				mut var_link := rt.new_string('<a href="admin.php?page=wc-reports&tab=' + (rt.call_function('urlencode', [var_current_tab.dup()])).str() + '&amp;report=' + (rt.call_function('urlencode', [var_key.dup()])).str() + '" class="')
				if rt.is_true(rt.equal(var_key, var_current_report)) {
					// unsupported expression: Expr_AssignOp_Concat
				}
				// unsupported expression: Expr_AssignOp_Concat
				var_links << var_link.dup()
			}
		}
		rt.echo_val(rt.call_function('implode', [rt.new_string(' | </li><li>'), var_links.dup()]))
		// unsupported statement: Stmt_InlineHTML
	}
	if var_reports.array_get(var_current_tab).array_get('reports').array_isset(var_current_report) {
		mut var_report := var_reports.array_get(var_current_tab).array_get('reports').array_get(var_current_report)
		if rt.is_true(rt.new_bool(!(var_report.array_isset(rt.new_string('hide_title'))) || rt.is_true(// unsupported expression: Expr_BinaryOp_NotEqual))) {
			print('<h1>' + (rt.call_function('esc_html', [var_report.array_get('title')])).str() + '</h1>')
		} else {
			print('<h1 class="screen-reader-text">' + (rt.call_function('esc_html', [var_report.array_get('title')])).str() + '</h1>')
		}
		if rt.is_true(var_report.array_get('description')) {
			print('<p>' + (var_report.array_get('description')).str() + '</p>')
		}
		if rt.is_true(rt.new_bool(rt.is_true(var_report.array_get('callback')) && rt.is_true(rt.call_function('is_callable', [var_report.array_get('callback')])))) {
			rt.call_function('call_user_func', [var_report.array_get('callback'), var_current_report.dup()])
		}
	}
	// unsupported statement: Stmt_InlineHTML
}
