import rt



pub fn init_wp_content_plugins_woocommerce_templates_emails_plain_email_downloads_php() {
	mut var_downloads := rt.new_null()
	mut var_columns := rt.new_null()
	mut var_plain_text := rt.new_null()
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
	print((rt.call_function('esc_html', [rt.call_function('wc_strtoupper', [rt.call_function('esc_html__', [rt.new_string('Downloads'), rt.new_string('woocommerce')])])])).str() + '\n\n')
	{
		mut iter_1 := var_downloads.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_download := item_1.val
			{
				mut iter_2 := var_columns.iterator()
				for {
					item_2 := iter_2.next() or { break }
					mut var_column_name := item_2.val
					mut var_column_id := item_2.key
					print((rt.call_function('wp_kses_post', [var_column_name.dup()])).str() + ': ')
					if rt.is_true(rt.call_function('has_action', ['woocommerce_email_downloads_column_' + (var_column_id).str()])) {
						rt.call_function('do_action', ['woocommerce_email_downloads_column_' + (var_column_id).str(), var_download.dup(), var_plain_text.dup()])
					} else {
						mut switch_val_1 := var_column_id
						if rt.is_true(rt.equal(switch_val_1, rt.new_string('download-product'))) {
							rt.echo_val(rt.call_function('esc_html', [var_download.array_get('product_name')]))
						} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('download-file'))) {
							print((rt.call_function('esc_html', [var_download.array_get('download_name')])).str() + ' - ' + (rt.call_function('esc_url', [var_download.array_get('download_url')])).str())
						} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('download-expires'))) {
							if !(!rt.is_true(var_download.array_get('access_expires'))) {
								rt.echo_val(rt.call_function('esc_html', [rt.call_function('date_i18n', [rt.call_function('get_option', [rt.new_string('date_format')]), rt.call_function('strtotime', [var_download.array_get('access_expires')])])]))
							} else {
								rt.call_function('esc_html_e', [rt.new_string('Never'), rt.new_string('woocommerce')])
							}
						}
					}
					print('\n')
				}
			}
			print('\n')
		}
	}
	print('=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=')
	print('\n\n')
}
