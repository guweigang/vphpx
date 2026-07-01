import rt

struct Class_Automattic_WooCommerce_Utilities_FeaturesUtil {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_utilities_featuresutil() &Class_Automattic_WooCommerce_Utilities_FeaturesUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_FeaturesUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Utilities_FeaturesUtil) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Utilities_FeaturesUtil) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_FeaturesUtil) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_templates_emails_email_downloads_php() {
	mut var_columns := rt.new_null()
	mut var_downloads := rt.new_null()
	mut var_plain_text := rt.new_null()
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
	mut var_email_improvements_enabled := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Utilities_FeaturesUtil{}; return temp.feature_is_enabled(arg_0) }(rt.new_string('email_improvements'))
	// unsupported statement: Stmt_InlineHTML
	print(if rt.is_true(var_email_improvements_enabled) { ' email-order-detail-heading' } else { '' })
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Downloads'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	print(if rt.is_true(var_email_improvements_enabled) { ' email-order-details' } else { '' })
	// unsupported statement: Stmt_InlineHTML
	print(if rt.is_true(var_email_improvements_enabled) { '0' } else { '6' })
	// unsupported statement: Stmt_InlineHTML
	print(if rt.is_true(var_email_improvements_enabled) { '0' } else { '1' })
	// unsupported statement: Stmt_InlineHTML
	{
		mut iter_1 := var_columns.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_column_name := item_1.val
			mut var_column_id := item_1.key
			// unsupported statement: Stmt_InlineHTML
			print(if rt.is_true(rt.new_bool(rt.is_true(var_email_improvements_enabled) && rt.is_true(rt.identical(rt.call_function('array_key_last', [var_columns.dup()]), var_column_id)))) { 'text-align-right' } else { 'text-align-left' })
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
				mut iter_2 := var_columns.iterator()
				for {
					item_2 := iter_2.next() or { break }
					mut var_column_name := item_2.val
					mut var_column_id := item_2.key
					// unsupported statement: Stmt_InlineHTML
					mut var_column_alignment_class := if rt.is_true(rt.new_bool(rt.is_true(var_email_improvements_enabled) && rt.is_true(rt.identical(rt.call_function('array_key_last', [var_columns.dup()]), var_column_id)))) { 'text-align-right' } else { 'text-align-left' }
					if rt.is_true(rt.identical(rt.new_string('download-product'), var_column_id)) {
						// unsupported statement: Stmt_InlineHTML
						rt.echo_val(rt.call_function('esc_attr', [rt.new_string(var_column_alignment_class).dup()]))
						// unsupported statement: Stmt_InlineHTML
					} else {
						// unsupported statement: Stmt_InlineHTML
						rt.echo_val(rt.call_function('esc_attr', [rt.new_string(var_column_alignment_class).dup()]))
						// unsupported statement: Stmt_InlineHTML
					}
					// unsupported statement: Stmt_InlineHTML
					if rt.is_true(rt.call_function('has_action', ['woocommerce_email_downloads_column_' + (var_column_id).str()])) {
						rt.call_function('do_action', ['woocommerce_email_downloads_column_' + (var_column_id).str(), var_download.dup(), var_plain_text.dup()])
					} else {
						mut switch_val_1 := var_column_id
						if rt.is_true(rt.equal(switch_val_1, rt.new_string('download-product'))) {
							// unsupported statement: Stmt_InlineHTML
							rt.echo_val(rt.call_function('esc_url', [rt.call_function('get_permalink', [var_download.array_get('product_id')])]))
							// unsupported statement: Stmt_InlineHTML
							rt.echo_val(rt.call_function('wp_kses_post', [var_download.array_get('product_name')]))
							// unsupported statement: Stmt_InlineHTML
						} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('download-file'))) {
							// unsupported statement: Stmt_InlineHTML
							rt.echo_val(rt.call_function('esc_url', [var_download.array_get('download_url')]))
							// unsupported statement: Stmt_InlineHTML
							rt.echo_val(rt.call_function('esc_html', [var_download.array_get('download_name')]))
							// unsupported statement: Stmt_InlineHTML
						} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('download-expires'))) {
							if !(!rt.is_true(var_download.array_get('access_expires'))) {
								// unsupported statement: Stmt_InlineHTML
								rt.echo_val(rt.call_function('esc_attr', [rt.call_function('date', [rt.new_string('Y-m-d'), rt.call_function('strtotime', [var_download.array_get('access_expires')])])]))
								// unsupported statement: Stmt_InlineHTML
								rt.echo_val(rt.call_function('esc_attr', [rt.call_function('strtotime', [var_download.array_get('access_expires')])]))
								// unsupported statement: Stmt_InlineHTML
								rt.echo_val(rt.call_function('esc_html', [rt.call_function('date_i18n', [rt.call_function('get_option', [rt.new_string('date_format')]), rt.call_function('strtotime', [var_download.array_get('access_expires')])])]))
								// unsupported statement: Stmt_InlineHTML
							} else {
								rt.call_function('esc_html_e', [rt.new_string('Never'), rt.new_string('woocommerce')])
							}
						}
					}
					// unsupported statement: Stmt_InlineHTML
					if rt.is_true(rt.identical(rt.new_string('download-product'), var_column_id)) {
						// unsupported statement: Stmt_InlineHTML
					} else {
						// unsupported statement: Stmt_InlineHTML
					}
					// unsupported statement: Stmt_InlineHTML
				}
			}
			// unsupported statement: Stmt_InlineHTML
		}
	}
	// unsupported statement: Stmt_InlineHTML
}
