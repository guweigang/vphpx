import rt



pub fn init_wp_content_plugins_woocommerce_templates_cart_cart_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
	rt.call_function('do_action', [rt.new_string('woocommerce_before_cart')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [rt.call_function('wc_get_cart_url', []rt.PhpVal{})]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string('woocommerce_before_cart_table')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Remove item'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Thumbnail image'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Product'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Price'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Quantity'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Subtotal'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string('woocommerce_before_cart_contents')])
	// unsupported statement: Stmt_InlineHTML
	{
		mut iter_1 := rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'cart'), 'get_cart', []rt.PhpVal{}).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_cart_item := item_1.val
			mut var_cart_item_key := item_1.key
			mut var__product := rt.call_function('apply_filters', [rt.new_string('woocommerce_cart_item_product'), var_cart_item.array_get('data'), var_cart_item.dup(), var_cart_item_key.dup()])
			mut var_product_id := rt.call_function('apply_filters', [rt.new_string('woocommerce_cart_item_product_id'), var_cart_item.array_get('product_id'), var_cart_item.dup(), var_cart_item_key.dup()])
			mut var_visible := rt.call_function('apply_filters', [rt.new_string('woocommerce_cart_item_visible'), rt.new_bool(true), var_cart_item.dup(), var_cart_item_key.dup()])
			if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.instance_of(var__product, 'WC_Product'))) && rt.is_true(rt.call_method(var__product, 'exists', []rt.PhpVal{})))) && rt.is_true(rt.greater(var_cart_item.array_get('quantity'), rt.new_int(0))))) && rt.is_true(var_visible))) {
				mut var_product_name := rt.call_function('apply_filters', [rt.new_string('woocommerce_cart_item_name'), rt.call_method(var__product, 'get_name', []rt.PhpVal{}), var_cart_item.dup(), var_cart_item_key.dup()])
				mut var_product_permalink := rt.call_function('apply_filters', [rt.new_string('woocommerce_cart_item_permalink'), if rt.is_true(rt.call_method(var__product, 'is_visible', []rt.PhpVal{})) { rt.call_method(var__product, 'get_permalink', [var_cart_item.dup()]) } else { rt.new_string('') }, var_cart_item.dup(), var_cart_item_key.dup()])
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_attr', [rt.call_function('apply_filters', [rt.new_string('woocommerce_cart_item_class'), rt.new_string('cart_item'), var_cart_item.dup(), var_cart_item_key.dup()])]))
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('apply_filters', [rt.new_string('woocommerce_cart_item_remove_link'), rt.call_function('sprintf', [rt.new_string('<a role="button" href="%s" class="remove" aria-label="%s" data-product_id="%s" data-product_sku="%s">&times;</a>'), rt.call_function('esc_url', [rt.call_function('wc_get_cart_remove_url', [var_cart_item_key.dup()])]), rt.call_function('esc_attr', [rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Remove %s from cart'), rt.new_string('woocommerce')]), rt.call_function('wp_strip_all_tags', [var_product_name.dup()])])]), rt.call_function('esc_attr', [var_product_id.dup()]), rt.call_function('esc_attr', [rt.call_method(var__product, 'get_sku', []rt.PhpVal{})])]), var_cart_item_key.dup()]))
				// unsupported statement: Stmt_InlineHTML
				mut var_thumbnail := rt.call_function('apply_filters', [rt.new_string('woocommerce_cart_item_thumbnail'), rt.call_method(var__product, 'get_image', []rt.PhpVal{}), var_cart_item.dup(), var_cart_item_key.dup()])
				if rt.is_true(rt.new_bool(!(rt.is_true(var_product_permalink)))) {
					rt.echo_val(var_thumbnail)
					// unsupported statement: Stmt_Nop
				} else {
					rt.call_function('printf', [rt.new_string('<a href="%s">%s</a>'), rt.call_function('esc_url', [var_product_permalink.dup()]), var_thumbnail.dup()])
					// unsupported statement: Stmt_Nop
				}
				// unsupported statement: Stmt_InlineHTML
				rt.call_function('esc_attr_e', [rt.new_string('Product'), rt.new_string('woocommerce')])
				// unsupported statement: Stmt_InlineHTML
				if rt.is_true(rt.new_bool(!(rt.is_true(var_product_permalink)))) {
					rt.echo_val(rt.call_function('wp_kses_post', [(var_product_name).str() + '&nbsp;']))
				} else {
					rt.echo_val(rt.call_function('wp_kses_post', [rt.call_function('apply_filters', [rt.new_string('woocommerce_cart_item_name'), rt.call_function('sprintf', [rt.new_string('<a href="%s">%s</a>'), rt.call_function('esc_url', [var_product_permalink.dup()]), rt.call_method(var__product, 'get_name', []rt.PhpVal{})]), var_cart_item.dup(), var_cart_item_key.dup()])]))
				}
				rt.call_function('do_action', [rt.new_string('woocommerce_after_cart_item_name'), var_cart_item.dup(), var_cart_item_key.dup()])
				rt.echo_val(rt.call_function('wc_get_formatted_cart_item_data', [var_cart_item.dup()]))
				if rt.is_true(rt.new_bool(rt.is_true(rt.call_method(var__product, 'backorders_require_notification', []rt.PhpVal{})) && rt.is_true(rt.call_method(var__product, 'is_on_backorder', [var_cart_item.array_get('quantity')])))) {
					rt.echo_val(rt.call_function('wp_kses_post', [rt.call_function('apply_filters', [rt.new_string('woocommerce_cart_item_backorder_notification'), '<p class="backorder_notification">' + (rt.call_function('esc_html__', [rt.new_string('Available on backorder'), rt.new_string('woocommerce')])).str() + '</p>', var_product_id.dup()])]))
				}
				// unsupported statement: Stmt_InlineHTML
				rt.call_function('esc_attr_e', [rt.new_string('Price'), rt.new_string('woocommerce')])
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('apply_filters', [rt.new_string('woocommerce_cart_item_price'), rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'cart'), 'get_product_price', [var__product.dup()]), var_cart_item.dup(), var_cart_item_key.dup()]))
				// unsupported statement: Stmt_Nop
				// unsupported statement: Stmt_InlineHTML
				rt.call_function('esc_attr_e', [rt.new_string('Quantity'), rt.new_string('woocommerce')])
				// unsupported statement: Stmt_InlineHTML
				if rt.is_true(rt.call_method(var__product, 'is_sold_individually', []rt.PhpVal{})) {
					mut var_min_quantity := 1
					mut var_max_quantity := rt.new_int(rt.new_int(1))
				} else {
					var_min_quantity = 0
					var_max_quantity = rt.call_method(var__product, 'get_max_purchase_quantity', []rt.PhpVal{})
				}
				mut var_product_quantity := rt.call_function('woocommerce_quantity_input', [rt.create_array([rt.ArrayItem{ key: 'input_name', val: "cart[${var_cart_item_key.to_string()}][qty]" }, rt.ArrayItem{ key: 'input_value', val: var_cart_item.array_get('quantity') }, rt.ArrayItem{ key: 'max_value', val: var_max_quantity }, rt.ArrayItem{ key: 'min_value', val: var_min_quantity }, rt.ArrayItem{ key: 'product_name', val: var_product_name }]), var__product.dup(), rt.new_bool(false)])
				rt.echo_val(rt.call_function('apply_filters', [rt.new_string('woocommerce_cart_item_quantity'), var_product_quantity.dup(), var_cart_item_key.dup(), var_cart_item.dup()]))
				// unsupported statement: Stmt_Nop
				// unsupported statement: Stmt_InlineHTML
				rt.call_function('esc_attr_e', [rt.new_string('Subtotal'), rt.new_string('woocommerce')])
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('apply_filters', [rt.new_string('woocommerce_cart_item_subtotal'), rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'cart'), 'get_product_subtotal', [var__product.dup(), var_cart_item.array_get('quantity')]), var_cart_item.dup(), var_cart_item_key.dup()]))
				// unsupported statement: Stmt_Nop
				// unsupported statement: Stmt_InlineHTML
			}
		}
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string('woocommerce_cart_contents')])
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.call_function('wc_coupons_enabled', []rt.PhpVal{})) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Coupon:'), rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_attr_e', [rt.new_string('Coupon code'), rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [if rt.is_true(rt.call_function('wc_wp_theme_get_element_class_name', [rt.new_string('button')])) { ' ' + (rt.call_function('wc_wp_theme_get_element_class_name', [rt.new_string('button')])).str() } else { rt.new_string('') }]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_attr_e', [rt.new_string('Apply coupon'), rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Apply coupon'), rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('do_action', [rt.new_string('woocommerce_cart_coupon')])
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [if rt.is_true(rt.call_function('wc_wp_theme_get_element_class_name', [rt.new_string('button')])) { ' ' + (rt.call_function('wc_wp_theme_get_element_class_name', [rt.new_string('button')])).str() } else { rt.new_string('') }]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('Update cart'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Update cart'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string('woocommerce_cart_actions')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('wp_nonce_field', [rt.new_string('woocommerce-cart'), rt.new_string('woocommerce-cart-nonce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string('woocommerce_after_cart_contents')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string('woocommerce_after_cart_table')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string('woocommerce_before_cart_collaterals')])
	// unsupported statement: Stmt_InlineHTML
	
}
