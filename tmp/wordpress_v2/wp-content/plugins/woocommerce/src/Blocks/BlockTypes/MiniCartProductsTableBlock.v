import rt

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_MiniCartProductsTableBlock {
	rt.PhpObjectBase
pub mut:
	block_name rt.PhpVal = rt.new_string('mini-cart-products-table-block')
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_MiniCartProductsTableBlock) render(var_attributes rt.PhpVal, var_content rt.PhpVal, var_block rt.PhpVal) rt.PhpVal {
	mut var_screen_reader_text := rt.call_function('__', [
		rt.new_string('Products in cart'),
		rt.new_string('woocommerce'),
	])
	mut var_remove_item_label := rt.call_function('__', [rt.new_string('Remove item'),
		rt.new_string('woocommerce')])
	mut var_head_product_label := rt.call_function('__', [rt.new_string('Product'),
		rt.new_string('woocommerce')])
	mut var_head_details_label := rt.call_function('__', [rt.new_string('Details'),
		rt.new_string('woocommerce')])
	mut var_head_total_label := rt.call_function('__', [rt.new_string('Total'),
		rt.new_string('woocommerce')])
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_context := rt.call_function('wp_interactivity_get_context', [
			rt.new_string('woocommerce'),
		])
		mut var_cart_state := rt.call_function('wp_interactivity_state', [
			rt.new_string('woocommerce'),
		])
		mut var_item_key :=
			var_context.array_get(rt.new_string('cartItem')).array_get(rt.new_string('key'))
		mut iter_1 :=
			var_cart_state.array_get(rt.new_string('cart')).array_get(rt.new_string('items')).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_item := item_1.val
			if rt.is_true(rt.identical(var_item.array_get(rt.new_string('key')), var_item_key)) {
				return var_item.clone()
			}
		}
		return rt.new_null()
	}
	rt.call_function('wp_interactivity_state', [this.get_full_block_name(),
		rt.create_array([
			rt.ArrayItem{ key: 'cartItem', val: rt.new_closure(closure_1_fn) },
		])])
	mut var_reduce_quantity_label := rt.call_function('__', [
		rt.new_string('Reduce quantity of %s'),
		rt.new_string('woocommerce'),
	])
	mut var_increase_quantity_label := rt.call_function('__', [
		rt.new_string('Increase quantity of %s'),
		rt.new_string('woocommerce'),
	])
	mut var_quantity_description_label := rt.call_function('__', [
		rt.new_string('Quantity of %s in your cart.'),
		rt.new_string('woocommerce'),
	])
	mut var_remove_from_cart_label := rt.call_function('__', [
		rt.new_string('Remove %s from cart'),
		rt.new_string('woocommerce'),
	])
	mut var_save_format := rt.call_function('__', [rt.new_string('Save %s'),
		rt.new_string('woocommerce')])
	mut var_line_item_discount_span :=
		rt.new_string('<span data-wp-text="state.lineItemDiscount" class="wc-block-formatted-money-amount wc-block-components-formatted-money-amount"></span>')
	mut var_line_item_save_badge := rt.call_function('sprintf', [
		var_save_format.clone(), var_line_item_discount_span.clone()])
	mut var_available_on_backorder_label := rt.call_function('__', [
		rt.new_string('Available on backorder'),
		rt.new_string('woocommerce'),
	])
	rt.call_function('wp_interactivity_config', [this.get_full_block_name(),
		rt.create_array([
			rt.ArrayItem{ key: 'reduceQuantityLabel', val: var_reduce_quantity_label },
			rt.ArrayItem{ key: 'increaseQuantityLabel', val: var_increase_quantity_label },
			rt.ArrayItem{ key: 'quantityDescriptionLabel', val: var_quantity_description_label },
			rt.ArrayItem{ key: 'removeFromCartLabel', val: var_remove_from_cart_label },
		])])
	mut var_wrapper_attributes := rt.call_function('get_block_wrapper_attributes', [
		rt.create_array([
			rt.ArrayItem{ key: 'class', val: 'wc-block-mini-cart__products-table' },
			rt.ArrayItem{ key: 'data-wp-interactive', val: this.get_full_block_name() },
		]),
	])
	rt.call_function('ob_start', []rt.PhpVal{})
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_wrapper_attributes)
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_screen_reader_text.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_head_product_label.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_head_details_label.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_head_total_label.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_available_on_backorder_label.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Previous price:'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Discounted price:'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(this.render_product_details_markup(rt.new_string('item_data')))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(this.render_product_details_markup(rt.new_string('variation')))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wp_kses', [var_line_item_save_badge.clone(),
		rt.create_array([
			rt.ArrayItem{ key: 'span', val: rt.create_array([
				rt.ArrayItem{ key: 'data-wp-text', val: true },
				rt.ArrayItem{ key: 'class', val: true },
			]) },
		])]))
	// unsupported statement: Stmt_InlineHTML
	return rt.call_function('ob_get_clean', []rt.PhpVal{})
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_MiniCartProductsTableBlock) render_product_details_markup(var_property rt.PhpVal) rt.PhpVal {
	mut var_context := rt.create_array([
		rt.ArrayItem{ key: 'dataProperty', val: var_property },
	])
	mut var_is_item_data := rt.identical(rt.new_string('item_data'),
		var_context.array_get(rt.new_string('dataProperty')))
	rt.call_function('ob_start', []rt.PhpVal{})
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wp_interactivity_data_wp_context', [
		var_context.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_property.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(this.render_product_details_item_markup(var_is_item_data.to_bool()))
	// unsupported statement: Stmt_InlineHTML
	return rt.call_function('ob_get_clean', []rt.PhpVal{})
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_MiniCartProductsTableBlock) render_product_details_item_markup(is_item_data bool) rt.PhpVal {
	mut is_item_data_mutated := is_item_data
	rt.call_function('ob_start', []rt.PhpVal{})
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.new_bool(is_item_data_mutated)) {
		// unsupported statement: Stmt_InlineHTML
	} else {
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	return rt.call_function('ob_get_clean', []rt.PhpVal{})
}

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractInnerBlock {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blocks_blocktypes_minicartproductstableblock(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_BlockTypes_MiniCartProductsTableBlock {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_MiniCartProductsTableBlock{
		PhpObjectBase: rt.PhpObjectBase{}
		block_name:    rt.new_string('mini-cart-products-table-block')
	}
	return obj
}

fn create_automattic_woocommerce_blocks_blocktypes_abstractinnerblock(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractInnerBlock {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractInnerBlock{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_MiniCartProductsTableBlock) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'render' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.render(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'render_product_details_markup' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.render_product_details_markup(dispatch_arg_0)
		}
		'render_product_details_item_markup' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			return this.render_product_details_item_markup(dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Blocks_BlockTypes_MiniCartProductsTableBlock) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'block_name' { return this.block_name }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_MiniCartProductsTableBlock) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'block_name' {
			this.block_name = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractInnerBlock) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractInnerBlock) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractInnerBlock) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
