import rt

pub fn init_wp_content_plugins_woocommerce_templates_order_order_downloads_php() {
	mut var_show_title := rt.new_null()
	mut var_downloads := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		// unsupported expression: Expr_Exit
	}
	// unsupported statement: Stmt_InlineHTML
	if !var_show_title.is_null() {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Downloads'),
			rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	{
		mut iter_1 := rt.call_function('wc_get_account_downloads_columns', []rt.PhpVal{}).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_column_name := item_1.val
			mut var_column_id := item_1.key
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [var_column_id.dup()]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_html', [var_column_name.dup()]))
			// unsupported statement: Stmt_InlineHTML
		}
	}
	// unsupported statement: Stmt_InlineHTML
	{
		mut iter_1 := var_downloads.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_download := item_1.val
			// unsupported statement: Stmt_InlineHTML
			{
				mut iter_2 :=
					rt.call_function('wc_get_account_downloads_columns', []rt.PhpVal{}).iterator()
				for {
					item_2 := iter_2.next() or { break }
					mut var_column_name := item_2.val
					mut var_column_id := item_2.key
					// unsupported statement: Stmt_InlineHTML
					rt.echo_val(rt.call_function('esc_attr', [
						var_column_id.dup()]))
					// unsupported statement: Stmt_InlineHTML
					rt.echo_val(rt.call_function('esc_attr', [
						var_column_name.dup()]))
					// unsupported statement: Stmt_InlineHTML
					if rt.is_true(rt.call_function('has_action', [
						'woocommerce_account_downloads_column_' + var_column_id.str(),
					]))
					{
						rt.call_function('do_action', [
							'woocommerce_account_downloads_column_' + var_column_id.str(),
							var_download.dup(),
						])
					} else {
						mut switch_val_1 := var_column_id
						if rt.is_true(rt.equal(switch_val_1, rt.new_string('download-product'))) {
							if rt.is_true(var_download.array_get('product_url')) {
								print('<a href="' +
									(rt.call_function('esc_url', [var_download.array_get('product_url')])).str() +
									'">' +
									(rt.call_function('esc_html', [var_download.array_get('product_name')])).str() +
									'</a>')
							} else {
								rt.echo_val(rt.call_function('esc_html', [
									var_download.array_get('product_name'),
								]))
							}
						} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('download-file'))) {
							print('<a href="' +
								(rt.call_function('esc_url', [var_download.array_get('download_url')])).str() +
								'" class="woocommerce-MyAccount-downloads-file button alt">' +
								(rt.call_function('esc_html', [var_download.array_get('download_name')])).str() +
								'</a>')
						} else if rt.is_true(rt.equal(switch_val_1,
							rt.new_string('download-remaining')))
						{
							rt.echo_val(if rt.is_true(rt.new_bool(var_download.array_get('downloads_remaining').is_long() || var_download.array_get('downloads_remaining').is_double())) { rt.call_function('esc_html', [
									var_download.array_get('downloads_remaining'),
								]) } else { rt.call_function('esc_html__', [
									rt.new_string('&infin;'),
									rt.new_string('woocommerce'),
								]) })
						} else if rt.is_true(rt.equal(switch_val_1,
							rt.new_string('download-expires')))
						{
							if !(!rt.is_true(var_download.array_get('access_expires'))) {
								print('<time datetime="' +
									(rt.call_function('esc_attr', [rt.call_function('date', [rt.new_string('Y-m-d'), rt.call_function('strtotime', [var_download.array_get('access_expires')])])])).str() +
									'" title="' +
									(rt.call_function('esc_attr', [rt.call_function('strtotime', [var_download.array_get('access_expires')])])).str() +
									'">' +
									(rt.call_function('esc_html', [rt.call_function('date_i18n', [rt.call_function('get_option', [rt.new_string('date_format')]), rt.call_function('strtotime', [var_download.array_get('access_expires')])])])).str() +
									'</time>')
							} else {
								rt.call_function('esc_html_e', [
									rt.new_string('Never'), rt.new_string('woocommerce')])
							}
						}
					}
					// unsupported statement: Stmt_InlineHTML
				}
			}
			// unsupported statement: Stmt_InlineHTML
		}
	}
	// unsupported statement: Stmt_InlineHTML
}
