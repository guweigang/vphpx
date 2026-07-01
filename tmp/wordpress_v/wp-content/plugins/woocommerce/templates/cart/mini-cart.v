import rt



pub fn init_wp_content_plugins_woocommerce_templates_cart_mini_cart_php() {
	mut var_args := map[string]rt.PhpVal{}
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
	rt.call_function('do_action', [rt.new_string('woocommerce_before_mini_cart')])
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.new_bool(rt.is_true(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'cart')) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'cart'), 'is_empty', []rt.PhpVal{}))))))) {
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [var_args.array_get('list_class')]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('do_action', [rt.new_string('woocommerce_before_mini_cart_contents')])
		{
			mut iter_1 := rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'cart'), 'get_cart', []rt.PhpVal{}).iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_cart_item := item_1.val
				mut var_cart_item_key := item_1.key
				mut var__product := rt.call_function('apply_filters', [rt.new_string('woocommerce_cart_item_product'), var_cart_item.array_get('data'), var_cart_item.dup(), var_cart_item_key.dup()])
				mut var_product_id := rt.call_function('apply_filters', [rt.new_string('woocommerce_cart_item_product_id'), var_cart_item.array_get('product_id'), var_cart_item.dup(), var_cart_item_key.dup()])
				if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(var__product) && rt.is_true(rt.call_method(var__product, 'exists', []rt.PhpVal{})))) && rt.is_true(rt.greater(var_cart_item.array_get('quantity'), rt.new_int(0))))) && rt.is_true(rt.call_function('apply_filters', [rt.new_string('woocommerce_widget_cart_item_visible'), rt.new_bool(true), var_cart_item.dup(), var_cart_item_key.dup()])))) {
					mut var_product_name := rt.call_function('apply_filters', [rt.new_string('woocommerce_cart_item_name'), rt.call_method(var__product, 'get_name', []rt.PhpVal{}), var_cart_item.dup(), var_cart_item_key.dup()])
					mut var_thumbnail := rt.call_function('apply_filters', [rt.new_string('woocommerce_cart_item_thumbnail'), rt.call_method(var__product, 'get_image', []rt.PhpVal{}), var_cart_item.dup(), var_cart_item_key.dup()])
					mut var_product_price := rt.call_function('apply_filters', [rt.new_string('woocommerce_cart_item_price'), rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'cart'), 'get_product_price', [var__product.dup()]), var_cart_item.dup(), var_cart_item_key.dup()])
					mut var_product_permalink := rt.call_function('apply_filters', [rt.new_string('woocommerce_cart_item_permalink'), if rt.is_true(rt.call_method(var__product, 'is_visible', []rt.PhpVal{})) { rt.call_method(var__product, 'get_permalink', [var_cart_item.dup()]) } else { rt.new_string('') }, var_cart_item.dup(), var_cart_item_key.dup()])
					// unsupported statement: Stmt_InlineHTML
					rt.echo_val(rt.call_function('esc_attr', [rt.call_function('apply_filters', [rt.new_string('woocommerce_mini_cart_item_class'), rt.new_string('mini_cart_item'), var_cart_item.dup(), var_cart_item_key.dup()])]))
					// unsupported statement: Stmt_InlineHTML
					rt.echo_val(rt.call_function('apply_filters', [rt.new_string('woocommerce_cart_item_remove_link'), rt.call_function('sprintf', [rt.new_string('<a role="button" href="%s" class="remove remove_from_cart_button" aria-label="%s" data-product_id="%s" data-cart_item_key="%s" data-product_sku="%s" data-success_message="%s">&times;</a>'), rt.call_function('esc_url', [rt.call_function('wc_get_cart_remove_url', [var_cart_item_key.dup()])]), rt.call_function('esc_attr', [rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Remove %s from cart'), rt.new_string('woocommerce')]), rt.call_function('wp_strip_all_tags', [var_product_name.dup()])])]), rt.call_function('esc_attr', [var_product_id.dup()]), rt.call_function('esc_attr', [var_cart_item_key.dup()]), rt.call_function('esc_attr', [rt.call_method(var__product, 'get_sku', []rt.PhpVal{})]), rt.call_function('esc_attr', [rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('&ldquo;%s&rdquo; has been removed from your cart'), rt.new_string('woocommerce')]), rt.call_function('wp_strip_all_tags', [var_product_name.dup()])])])]), var_cart_item_key.dup()]))
					// unsupported statement: Stmt_InlineHTML
					if !rt.is_true(var_product_permalink) {
						// unsupported statement: Stmt_InlineHTML
						print((var_thumbnail).str() + (rt.call_function('wp_kses_post', [var_product_name.dup()])).str())
						// unsupported statement: Stmt_Nop
						// unsupported statement: Stmt_InlineHTML
					} else {
						// unsupported statement: Stmt_InlineHTML
						rt.echo_val(rt.call_function('esc_url', [var_product_permalink.dup()]))
						// unsupported statement: Stmt_InlineHTML
						print((var_thumbnail).str() + (rt.call_function('wp_kses_post', [var_product_name.dup()])).str())
						// unsupported statement: Stmt_Nop
						// unsupported statement: Stmt_InlineHTML
					}
					// unsupported statement: Stmt_InlineHTML
					rt.echo_val(rt.call_function('wc_get_formatted_cart_item_data', [var_cart_item.dup()]))
					// unsupported statement: Stmt_Nop
					// unsupported statement: Stmt_InlineHTML
					rt.echo_val(rt.call_function('apply_filters', [rt.new_string('woocommerce_widget_cart_item_quantity'), '<span class="quantity">' + (rt.call_function('sprintf', [rt.new_string('%s &times; %s'), var_cart_item.array_get('quantity'), var_product_price.dup()])).str() + '</span>', var_cart_item.dup(), var_cart_item_key.dup()]))
					// unsupported statement: Stmt_Nop
					// unsupported statement: Stmt_InlineHTML
				}
			}
		}
		rt.call_function('do_action', [rt.new_string('woocommerce_mini_cart_contents')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('do_action', [rt.new_string('woocommerce_widget_shopping_cart_total')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('do_action', [rt.new_string('woocommerce_widget_shopping_cart_before_buttons')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('do_action', [rt.new_string('woocommerce_widget_shopping_cart_buttons')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('do_action', [rt.new_string('woocommerce_widget_shopping_cart_after_buttons')])
		// unsupported statement: Stmt_InlineHTML
	} else {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('No products in the cart.'), rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string('woocommerce_after_mini_cart')])
}
