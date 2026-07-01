import rt

pub fn init_wp_content_plugins_woocommerce_includes_admin_settings_views_html_admin_page_shipping_providers_php() {
	mut var_shipping_provider_columns := rt.new_null()
	// unsupported statement: Stmt_Declare
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		// unsupported expression: Expr_Exit
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Shipping providers'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Add shipping provider'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [
		rt.new_string('Add custom shipping providers so they appear in the fulfillment form when creating shipments. Use the tracking URL template to auto-generate tracking links.'),
		rt.new_string('woocommerce'),
	])
	// unsupported statement: Stmt_InlineHTML
	{
		mut iter_1 := var_shipping_provider_columns.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_heading := item_1.val
			mut var_class := item_1.key
			// unsupported statement: Stmt_Nop
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [var_class.dup()]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_html', [var_heading.dup()]))
			// unsupported statement: Stmt_InlineHTML
		}
	}
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('absint', [var_shipping_provider_columns.dup().array_count() + 1]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [
		rt.new_string('No custom shipping providers have been created.'),
		rt.new_string('woocommerce'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Add shipping provider'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Close modal panel'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	{
		mut iter_1 := var_shipping_provider_columns.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_heading := item_1.val
			mut var_class := item_1.key
			print('<div class="wc-shipping-class-modal-input ' +
				(rt.call_function('esc_attr', [var_class.dup()])).str() + '">')
			mut switch_val_1 := var_class
			if rt.is_true(rt.equal(switch_val_1, rt.new_string('wc-shipping-provider-name'))) {
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_html', [var_heading.dup()]))
				// unsupported statement: Stmt_InlineHTML
				rt.call_function('esc_attr_e', [rt.new_string('e.g. My Local Courier'),
					rt.new_string('woocommerce')])
				// unsupported statement: Stmt_InlineHTML
				rt.call_function('esc_html_e', [
					rt.new_string('The display name for this shipping provider.'),
					rt.new_string('woocommerce'),
				])
				// unsupported statement: Stmt_InlineHTML
			} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('wc-shipping-provider-slug'))) {
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_html', [var_heading.dup()]))
				// unsupported statement: Stmt_InlineHTML
				rt.call_function('esc_attr_e', [rt.new_string('e.g. my-local-courier'),
					rt.new_string('woocommerce')])
				// unsupported statement: Stmt_InlineHTML
				rt.call_function('esc_html_e', [
					rt.new_string('Unique identifier (auto-generated if left blank).'),
					rt.new_string('woocommerce'),
				])
				// unsupported statement: Stmt_InlineHTML
			} else if rt.is_true(rt.equal(switch_val_1,
				rt.new_string('wc-shipping-provider-tracking-url-template')))
			{
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_html', [var_heading.dup()]))
				// unsupported statement: Stmt_InlineHTML
				rt.call_function('esc_attr_e', [
					rt.new_string('e.g. https://example.com/track?id=__PLACEHOLDER__'),
					rt.new_string('woocommerce'),
				])
				// unsupported statement: Stmt_InlineHTML
				rt.call_function('esc_html_e', [
					rt.new_string('Use __PLACEHOLDER__ where the tracking number should appear in the URL.'),
					rt.new_string('woocommerce'),
				])
				// unsupported statement: Stmt_InlineHTML
			} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('wc-shipping-provider-icon'))) {
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_html', [var_heading.dup()]))
				// unsupported statement: Stmt_InlineHTML
				rt.call_function('esc_attr_e', [
					rt.new_string('e.g. https://example.com/icon.png'),
					rt.new_string('woocommerce'),
				])
				// unsupported statement: Stmt_InlineHTML
				rt.call_function('esc_html_e', [
					rt.new_string('Optional URL for the provider icon.'),
					rt.new_string('woocommerce'),
				])
				// unsupported statement: Stmt_InlineHTML
			} else {
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_html', [var_heading.dup()]))
				// unsupported statement: Stmt_InlineHTML
				rt.call_function('do_action', [
					'woocommerce_shipping_providers_column_' + var_class.str(),
				])
			}
			print('</div>')
		}
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Create'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Save'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	{
		mut iter_1 := var_shipping_provider_columns.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_heading := item_1.val
			mut var_class := item_1.key
			print('<td class="' + (rt.call_function('esc_attr', [var_class.dup()])).str() + '">')
			mut switch_val_2 := var_class
			if rt.is_true(rt.equal(switch_val_2, rt.new_string('wc-shipping-provider-name'))) {
				// unsupported statement: Stmt_InlineHTML
			} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('wc-shipping-provider-slug'))) {
				// unsupported statement: Stmt_InlineHTML
			} else if rt.is_true(rt.equal(switch_val_2,
				rt.new_string('wc-shipping-provider-tracking-url-template')))
			{
				// unsupported statement: Stmt_InlineHTML
			} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('wc-shipping-provider-icon'))) {
				// unsupported statement: Stmt_InlineHTML
			} else {
				rt.call_function('do_action', [
					'woocommerce_shipping_providers_column_' + var_class.str(),
				])
			}
			print('</td>')
		}
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Edit'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Delete'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
}
