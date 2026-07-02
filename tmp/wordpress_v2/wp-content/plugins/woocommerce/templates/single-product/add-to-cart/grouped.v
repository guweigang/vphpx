import rt

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_product := rt.new_null()
	mut var_grouped_products := rt.new_null()
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
	mut var_post := rt.get_superglobal('post')
	rt.call_function('do_action', [rt.new_string('woocommerce_before_add_to_cart_form')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [
		rt.call_function('apply_filters', [
			rt.new_string('woocommerce_add_to_cart_form_action'),
			rt.call_method(var_product, 'get_permalink', []rt.PhpVal{}),
		]),
	]))
	// unsupported statement: Stmt_InlineHTML
	mut var_quantites_required := false
	mut var_previous_post := var_post.clone()
	mut var_grouped_product_columns := rt.call_function('apply_filters', [
		rt.new_string('woocommerce_grouped_product_columns'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'quantity' },
			rt.ArrayItem{ key: none, val: 'label' }, rt.ArrayItem{ key: none, val: 'price' }]),
		var_product.clone(),
	])
	mut var_show_add_to_cart_button := false
	rt.call_function('do_action', [
		rt.new_string('woocommerce_grouped_product_list_before'),
		var_grouped_product_columns.clone(),
		rt.new_bool(var_quantites_required).clone(),
		var_product.clone(),
	])
	mut iter_1 := var_grouped_products.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_grouped_product_child := item_1.val
		mut var_post_object := rt.call_function('get_post', [
			rt.call_method(var_grouped_product_child, 'get_id', []rt.PhpVal{}),
		])
		var_quantites_required = var_quantites_required
			|| rt.is_true(rt.call_method(var_grouped_product_child, 'is_purchasable', []rt.PhpVal{}))
			&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_grouped_product_child, 'has_options', []rt.PhpVal{})))))
		var_post = var_post_object.clone()
		rt.call_function('setup_postdata', [var_post.clone()])
		if rt.is_true(rt.call_method(var_grouped_product_child, 'is_in_stock', []rt.PhpVal{})) {
			var_show_add_to_cart_button = true
		}
		print('<tr id="product-' +
			(rt.call_function('esc_attr', [rt.call_method(var_grouped_product_child, 'get_id', []rt.PhpVal{})])).str() +
			'" class="woocommerce-grouped-product-list-item ' +
			(rt.call_function('esc_attr', [rt.call_function('implode', [rt.new_string(' '), rt.call_function('wc_get_product_class', [rt.new_string(''), var_grouped_product_child.clone()])])])).str() +
			'">')
		mut iter_2 := var_grouped_product_columns.iterator()
		for {
			item_2 := iter_2.next() or { break }
			mut var_column_id := item_2.val
			rt.call_function('do_action', [
				rt.new_string('woocommerce_grouped_product_list_before_' + var_column_id.str()),
				var_grouped_product_child.clone(),
			])
			mut switch_val_1 := var_column_id
			if rt.is_true(rt.equal(switch_val_1, rt.new_string('quantity'))) {
				rt.call_function('ob_start', []rt.PhpVal{})
				if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_grouped_product_child, 'is_purchasable', []rt.PhpVal{})))))
					|| rt.is_true(rt.call_method(var_grouped_product_child, 'has_options', []rt.PhpVal{}))
					|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_grouped_product_child, 'is_in_stock', []rt.PhpVal{}))))) {
					rt.call_function('woocommerce_template_loop_add_to_cart', []rt.PhpVal{})
				} else if rt.is_true(rt.call_method(var_grouped_product_child,
					'is_sold_individually', []rt.PhpVal{}))
				{
					print('<input type="checkbox" name="' +
						(rt.call_function('esc_attr', [rt.new_string('quantity[' + (rt.call_method(var_grouped_product_child, 'get_id', []rt.PhpVal{})).str() +
						']')])).str() +
						'" value="1" class="wc-grouped-product-add-to-cart-checkbox" id="' +
						(rt.call_function('esc_attr', [rt.new_string('quantity-' + (rt.call_method(var_grouped_product_child, 'get_id', []rt.PhpVal{})).str())])).str() +
						'" />')
					print('<label for="' +
						(rt.call_function('esc_attr', [rt.new_string('quantity-' + (rt.call_method(var_grouped_product_child, 'get_id', []rt.PhpVal{})).str())])).str() +
						'" class="screen-reader-text">')
					if rt.is_true(rt.call_method(var_grouped_product_child, 'is_on_sale',
						[]rt.PhpVal{}))
					{
						rt.call_function('printf', [
							rt.call_function('esc_html__', [
								rt.new_string('Buy one of %1$s on sale for %2$s, original price was %3$s'),
								rt.new_string('woocommerce'),
							]),
							rt.call_function('esc_html', [
								rt.call_method(var_grouped_product_child, 'get_name', []rt.PhpVal{}),
							]),
							rt.call_function('esc_html', [
								rt.call_function('wp_strip_all_tags', [
									rt.call_function('wc_price', [
										rt.call_method(var_grouped_product_child, 'get_price',
											[]rt.PhpVal{}),
									]),
								]),
							]),
							rt.call_function('esc_html', [
								rt.call_function('wp_strip_all_tags', [
									rt.call_function('wc_price', [
										rt.call_method(var_grouped_product_child,
											'get_regular_price', []rt.PhpVal{}),
									]),
								]),
							]),
						])
					} else {
						rt.call_function('printf', [
							rt.call_function('esc_html__', [
								rt.new_string('Buy one of %1$s for %2$s'),
								rt.new_string('woocommerce'),
							]),
							rt.call_function('esc_html', [
								rt.call_method(var_grouped_product_child, 'get_name', []rt.PhpVal{}),
							]),
							rt.call_function('esc_html', [
								rt.call_function('wp_strip_all_tags', [
									rt.call_function('wc_price', [
										rt.call_method(var_grouped_product_child, 'get_price',
											[]rt.PhpVal{}),
									]),
								]),
							]),
						])
					}
					print('</label>')
				} else {
					rt.call_function('do_action', [
						rt.new_string('woocommerce_before_add_to_cart_quantity'),
					])
					rt.call_function('woocommerce_quantity_input', [
						rt.create_array([
							rt.ArrayItem{ key: 'input_name', val: 'quantity[' +
								(rt.call_method(var_grouped_product_child, 'get_id', []rt.PhpVal{})).str() +
								']' },
							rt.ArrayItem{
								key: 'input_value'
								val: if rt.get_superglobal('_POST').array_get(rt.new_string('quantity')).array_isset(rt.call_method(var_grouped_product_child, 'get_id', []rt.PhpVal{})) { rt.call_function('wc_stock_amount', [
										rt.call_function('wc_clean', [
											rt.call_function('wp_unslash', [
												rt.get_superglobal('_POST').array_get(rt.new_string('quantity')).array_get(rt.call_method(var_grouped_product_child, 'get_id', []rt.PhpVal{})),
											]),
										]),
									]) } else { rt.new_string('') }
							},
							rt.ArrayItem{ key: 'min_value', val: rt.call_function('apply_filters', [
								rt.new_string('woocommerce_quantity_input_min'),
								rt.new_int(0),
								var_grouped_product_child.clone(),
							]) },
							rt.ArrayItem{ key: 'max_value', val: rt.call_method(var_grouped_product_child,
								'get_max_purchase_quantity', []rt.PhpVal{}) },
							rt.ArrayItem{ key: 'placeholder', val: '0' },
						]),
					])
					rt.call_function('do_action', [
						rt.new_string('woocommerce_after_add_to_cart_quantity'),
					])
				}
				mut var_value := rt.call_function('ob_get_clean', []rt.PhpVal{})
			} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('label'))) {
				var_value = rt.new_string('<label for="product-' +
					(rt.call_function('esc_attr', [rt.call_method(var_grouped_product_child, 'get_id', []rt.PhpVal{})])).str() +
					'">')
				var_value = rt.concat(var_value, if rt.is_true(rt.call_method(var_grouped_product_child,
					'is_visible', []rt.PhpVal{}))
				{
					'<a href="' +
						(rt.call_function('esc_url', [rt.call_function('apply_filters', [rt.new_string('woocommerce_grouped_product_list_link'), rt.call_method(var_grouped_product_child, 'get_permalink', []rt.PhpVal{}), rt.call_method(var_grouped_product_child, 'get_id', []rt.PhpVal{})])])).str() +
						'">' +
						(rt.call_method(var_grouped_product_child, 'get_name', []rt.PhpVal{})).str() +
						'</a>'
				} else {
					rt.call_method(var_grouped_product_child, 'get_name', []rt.PhpVal{})
				})
				var_value = rt.concat(var_value, rt.new_string('</label>'))
			} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('price'))) {
				var_value = rt.new_string(
					(rt.call_method(var_grouped_product_child, 'get_price_html', []rt.PhpVal{})).str() +(rt.call_function('wc_get_stock_html', [var_grouped_product_child.clone()])).str())
			} else {
				var_value = rt.new_string('')
			}
			print('<td class="woocommerce-grouped-product-list-item__' +
				(rt.call_function('esc_attr', [var_column_id.clone()])).str() + '">' +
				(rt.call_function('apply_filters', [rt.new_string('woocommerce_grouped_product_list_column_' + var_column_id.str()), var_value.clone(), var_grouped_product_child.clone()])).str() +
				'</td>')
			rt.call_function('do_action', [
				rt.new_string('woocommerce_grouped_product_list_after_' + var_column_id.str()),
				var_grouped_product_child.clone(),
			])
		}
		print('</tr>')
	}
	var_post = var_previous_post.clone()
	rt.call_function('setup_postdata', [var_post.clone()])
	rt.call_function('do_action', [
		rt.new_string('woocommerce_grouped_product_list_after'),
		var_grouped_product_columns.clone(),
		rt.new_bool(var_quantites_required).clone(),
		var_product.clone(),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [
		rt.call_method(var_product, 'get_id', []rt.PhpVal{}),
	]))
	// unsupported statement: Stmt_InlineHTML
	if var_quantites_required && var_show_add_to_cart_button {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('do_action', [
			rt.new_string('woocommerce_before_add_to_cart_button'),
		])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [
			rt.new_string((if rt.is_true(rt.call_function('wc_wp_theme_get_element_class_name', [
				rt.new_string('button'),
			]))
			{
				' ' +(rt.call_function('wc_wp_theme_get_element_class_name', [rt.new_string('button')])).str()
			} else {
				''
			}).str()),
		]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_html', [
			rt.call_method(var_product, 'single_add_to_cart_text', []rt.PhpVal{}),
		]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('do_action', [
			rt.new_string('woocommerce_after_add_to_cart_button'),
		])
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string('woocommerce_after_add_to_cart_form')])
}
