import rt

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_show_title := rt.new_null()
	mut var_downloads := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		exit(0)
	}
	// unsupported statement: Stmt_InlineHTML
	if !var_show_title.is_null() {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Downloads'),
			rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	mut iter_1 := rt.call_function('wc_get_account_downloads_columns', []rt.PhpVal{}).iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_column_name := item_1.val
		mut var_column_id := item_1.key
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [var_column_id.clone()]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_html', [var_column_name.clone()]))
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	mut iter_2 := var_downloads.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_download := item_2.val
		// unsupported statement: Stmt_InlineHTML
		mut iter_3 := rt.call_function('wc_get_account_downloads_columns', []rt.PhpVal{}).iterator()
		for {
			item_3 := iter_3.next() or { break }
			mut var_column_name := item_3.val
			mut var_column_id := item_3.key
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [var_column_id.clone()]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [var_column_name.clone()]))
			// unsupported statement: Stmt_InlineHTML
			if rt.is_true(rt.call_function('has_action', [
				rt.new_string('woocommerce_account_downloads_column_' + var_column_id.str()),
			]))
			{
				rt.call_function('do_action', [
					rt.new_string('woocommerce_account_downloads_column_' + var_column_id.str()),
					var_download.clone(),
				])
			} else {
				mut switch_val_1 := var_column_id
				if rt.is_true(rt.equal(switch_val_1, rt.new_string('download-product'))) {
					if rt.is_true(var_download.array_get(rt.new_string('product_url'))) {
						print('<a href="' +
							(rt.call_function('esc_url', [var_download.array_get(rt.new_string('product_url'))])).str() +
							'">' +
							(rt.call_function('esc_html', [var_download.array_get(rt.new_string('product_name'))])).str() +
							'</a>')
					} else {
						rt.echo_val(rt.call_function('esc_html', [
							var_download.array_get(rt.new_string('product_name')),
						]))
					}
				} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('download-file'))) {
					print('<a href="' +
						(rt.call_function('esc_url', [var_download.array_get(rt.new_string('download_url'))])).str() +
						'" class="woocommerce-MyAccount-downloads-file button alt">' +
						(rt.call_function('esc_html', [var_download.array_get(rt.new_string('download_name'))])).str() +
						'</a>')
				} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('download-remaining'))) {
					rt.echo_val(if var_download.array_get(rt.new_string('downloads_remaining')).is_long() || var_download.array_get(rt.new_string('downloads_remaining')).is_double() { rt.call_function('esc_html', [
							var_download.array_get(rt.new_string('downloads_remaining')),
						]) } else { rt.call_function('esc_html__', [
							rt.new_string('&infin;'),
							rt.new_string('woocommerce'),
						]) })
				} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('download-expires'))) {
					if !(!rt.is_true(var_download.array_get(rt.new_string('access_expires')))) {
						print('<time datetime="' +
							(rt.call_function('esc_attr', [rt.call_function('date', [rt.new_string('Y-m-d'), rt.call_function('strtotime', [var_download.array_get(rt.new_string('access_expires'))])])])).str() +
							'" title="' +
							(rt.call_function('esc_attr', [rt.call_function('strtotime', [var_download.array_get(rt.new_string('access_expires'))])])).str() +
							'">' +
							(rt.call_function('esc_html', [rt.call_function('date_i18n', [rt.call_function('get_option', [rt.new_string('date_format')]), rt.call_function('strtotime', [var_download.array_get(rt.new_string('access_expires'))])])])).str() +
							'</time>')
					} else {
						rt.call_function('esc_html_e', [rt.new_string('Never'),
							rt.new_string('woocommerce')])
					}
				}
			}
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
}
