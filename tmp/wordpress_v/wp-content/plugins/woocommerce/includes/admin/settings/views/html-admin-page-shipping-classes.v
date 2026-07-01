import rt

pub fn init_wp_content_plugins_woocommerce_includes_admin_settings_views_html_admin_page_shipping_classes_php() {
	mut var_shipping_class_columns := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		// unsupported expression: Expr_Exit
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Shipping classes'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Add shipping class'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [
		rt.new_string('Use shipping classes to customize the shipping rates for different groups of products, such as heavy items that require higher postage fees.'),
		rt.new_string('woocommerce'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Learn more'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	{
		mut iter_1 := var_shipping_class_columns.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_heading := item_1.val
			mut var_class := item_1.key
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [var_class.dup()]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_html', [var_heading.dup()]))
			// unsupported statement: Stmt_InlineHTML
		}
	}
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('absint', [var_shipping_class_columns.dup().array_count() + 1]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [
		rt.new_string('No shipping classes have been created.'),
		rt.new_string('woocommerce'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Add shipping class'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Close modal panel'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	{
		mut iter_1 := var_shipping_class_columns.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_heading := item_1.val
			mut var_class := item_1.key
			print('<div class="wc-shipping-class-modal-input ' +
				(rt.call_function('esc_attr', [var_class.dup()])).str() + '">')
			mut switch_val_1 := var_class
			if rt.is_true(rt.equal(switch_val_1, rt.new_string('wc-shipping-class-name'))) {
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_html', [var_heading.dup()]))
				// unsupported statement: Stmt_InlineHTML
				rt.call_function('esc_attr_e', [rt.new_string('e.g. Heavy'),
					rt.new_string('woocommerce')])
				// unsupported statement: Stmt_InlineHTML
				rt.call_function('esc_html_e', [
					rt.new_string('Give your shipping class a name for easy identification'),
					rt.new_string('woocommerce'),
				])
				// unsupported statement: Stmt_InlineHTML
			} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('wc-shipping-class-slug'))) {
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_html', [var_heading.dup()]))
				// unsupported statement: Stmt_InlineHTML
				rt.call_function('esc_attr_e', [rt.new_string('e.g. heavy-packages'),
					rt.new_string('woocommerce')])
				// unsupported statement: Stmt_InlineHTML
				rt.call_function('esc_html_e', [
					rt.new_string('Slug (unique identifier) can be left blank and auto-generated, or you can enter one'),
					rt.new_string('woocommerce'),
				])
				// unsupported statement: Stmt_InlineHTML
			} else if rt.is_true(rt.equal(switch_val_1,
				rt.new_string('wc-shipping-class-description')))
			{
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_html', [var_heading.dup()]))
				// unsupported statement: Stmt_InlineHTML
				rt.call_function('esc_attr_e', [
					rt.new_string('e.g. For heavy items requiring higher postage'),
					rt.new_string('woocommerce'),
				])
				// unsupported statement: Stmt_InlineHTML
			} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('wc-shipping-class-count'))) {
			} else {
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_html', [var_heading.dup()]))
				// unsupported statement: Stmt_InlineHTML
				rt.call_function('do_action', [
					'woocommerce_shipping_classes_column_' + var_class.str(),
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
		mut iter_1 := var_shipping_class_columns.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_heading := item_1.val
			mut var_class := item_1.key
			print('<td class="' + (rt.call_function('esc_attr', [var_class.dup()])).str() + '">')
			mut switch_val_2 := var_class
			if rt.is_true(rt.equal(switch_val_2, rt.new_string('wc-shipping-class-name'))) {
				// unsupported statement: Stmt_InlineHTML
			} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('wc-shipping-class-slug'))) {
				// unsupported statement: Stmt_InlineHTML
			} else if rt.is_true(rt.equal(switch_val_2,
				rt.new_string('wc-shipping-class-description')))
			{
				// unsupported statement: Stmt_InlineHTML
			} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('wc-shipping-class-count'))) {
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_url', [
					rt.call_function('admin_url', [
						rt.new_string('edit.php?post_type=product&product_shipping_class='),
					]),
				]))
				// unsupported statement: Stmt_InlineHTML
			} else {
				rt.call_function('do_action', [
					'woocommerce_shipping_classes_column_' + var_class.str(),
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
