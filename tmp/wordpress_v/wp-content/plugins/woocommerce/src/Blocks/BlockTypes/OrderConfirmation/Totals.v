import rt

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_Totals {
	rt.PhpObjectBase
pub mut:
		block_name rt.PhpVal = rt.new_string('order-confirmation-totals')
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_Totals) render_content(var_order rt.PhpVal, permission bool, var_attributes rt.PhpVal, content string) string {
	if !(var_permission) {
		return (this.render_content_fallback()).str()
	}
	mut var_classes_and_styles := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils{}; return temp.get_classes_and_styles_by_attributes(arg_0, arg_1) }(var_attributes.dup(), rt.create_array([rt.ArrayItem{ key: none, val: 'border_color' }, rt.ArrayItem{ key: none, val: 'border_radius' }, rt.ArrayItem{ key: none, val: 'border_width' }, rt.ArrayItem{ key: none, val: 'border_style' }, rt.ArrayItem{ key: none, val: 'background_color' }, rt.ArrayItem{ key: none, val: 'text_color' }]))
	return (this.get_hook_content(rt.new_string('woocommerce_order_details_before_order_table'), rt.create_array([rt.ArrayItem{ key: none, val: var_order }]))).str() + '\n\t\t\t<table cellspacing="0" class="wc-block-order-confirmation-totals__table ' + (rt.call_function('esc_attr', [var_classes_and_styles.array_get('classes')])).str() + '" style="' + (rt.call_function('esc_attr', [var_classes_and_styles.array_get('styles')])).str() + '">\n\t\t\t\t<thead>\n\t\t\t\t\t<tr>\n\t\t\t\t\t\t<th class="wc-block-order-confirmation-totals__product">' + (rt.call_function('esc_html__', [rt.new_string('Product'), rt.new_string('woocommerce')])).str() + '</th>\n\t\t\t\t\t\t<th class="wc-block-order-confirmation-totals__total">' + (rt.call_function('esc_html__', [rt.new_string('Total'), rt.new_string('woocommerce')])).str() + '</th>\n\t\t\t\t\t</tr>\n\t\t\t\t</thead>\n\t\t\t\t<tbody>\n\t\t\t\t\t' + (this.get_hook_content(rt.new_string('woocommerce_order_details_before_order_table_items'), rt.create_array([rt.ArrayItem{ key: none, val: var_order }]))).str() + '\n\t\t\t\t\t' + (this.render_order_details_table_items(var_order.dup())).str() + '\n\t\t\t\t\t' + (this.get_hook_content(rt.new_string('woocommerce_order_details_after_order_table_items'), rt.create_array([rt.ArrayItem{ key: none, val: var_order }]))).str() + '\n\t\t\t\t</tbody>\n\t\t\t\t<tfoot>\n\t\t\t\t\t' + (this.render_order_details_table_totals(var_order.dup())).str() + '\n\t\t\t\t\t</tfoot>\n\t\t\t\t\t</table>\n\t\t\t' + this.render_order_details_customer_note(var_order.dup()) + '\n\t\t\t' + (this.get_hook_content(rt.new_string('woocommerce_order_details_after_order_table'), rt.create_array([rt.ArrayItem{ key: none, val: var_order }]))).str() + '\n\t\t\t' + (this.get_hook_content(rt.new_string('woocommerce_after_order_details'), rt.create_array([rt.ArrayItem{ key: none, val: var_order }]))).str() + '\n\t\t'
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_Totals) get_inline_styles(mut var_attributes Class_Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_array) string {
	mut var_link_classes_and_styles := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils{}; return temp.get_link_color_class_and_style(arg_0) }(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_array', []string{}, var_attributes))
	mut var_link_hover_classes_and_styles := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils{}; return temp.get_link_hover_color_class_and_style(arg_0) }(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_array', []string{}, var_attributes))
	mut var_border_classes_and_styles := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils{}; return temp.get_classes_and_styles_by_attributes(arg_0, arg_1) }(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_array', []string{}, var_attributes), rt.create_array([rt.ArrayItem{ key: none, val: 'border_color' }, rt.ArrayItem{ key: none, val: 'border_radius' }, rt.ArrayItem{ key: none, val: 'border_width' }, rt.ArrayItem{ key: none, val: 'border_style' }]))
	return '\n\t\t\t.wc-block-order-confirmation-totals__table a {' + (var_link_classes_and_styles.array_get('style')).str() + '}\n\t\t\t.wc-block-order-confirmation-totals__table a:hover, .wc-block-order-confirmation-totals__table a:focus {' + (var_link_hover_classes_and_styles.array_get('style')).str() + '}\n\t\t\t.wc-block-order-confirmation-totals__table {' + (var_border_classes_and_styles.array_get('styles')).str() + '}\n\t\t\t.wc-block-order-confirmation-totals__table th, .wc-block-order-confirmation-totals__table td {' + (var_border_classes_and_styles.array_get('styles')).str() + '}\n\t\t'
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_Totals) enqueue_assets(mut var_attributes Class_Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_array, var_content rt.PhpVal, var_block rt.PhpVal)  {
	this.Class_Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_AbstractOrderConfirmationBlock.enqueue_assets(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_array', []string{}, var_attributes), var_content.dup(), var_block.dup())
	mut var_styles := rt.new_string(this.get_inline_styles(mut var_attributes))
	rt.call_function('wp_add_inline_style', [rt.new_string('wc-blocks-style'), var_styles.dup()])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_Totals) render_order_details_table_items(var_order rt.PhpVal) rt.PhpVal {
	mut var_return := rt.new_string(rt.new_string(''))
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_item := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_order_item_visible'), rt.new_bool(true), var_item.dup()])
	}
	mut var_order_items := rt.call_function('array_filter', [rt.call_method(var_order, 'get_items', [rt.call_function('apply_filters', [rt.new_string('woocommerce_purchase_order_item_types'), Class_Automattic_WooCommerce_Enums_OrderItemType.line_item()])]), rt.new_closure(closure_1_fn)])
	{
		mut iter_1 := var_order_items.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_item := item_1.val
			mut var_item_id := item_1.key
			mut var_product := rt.call_method(var_item, 'get_product', []rt.PhpVal{})
			// unsupported expression: Expr_AssignOp_Concat
		}
	}
	return var_return.dup()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_Totals) render_order_details_table_item(var_order rt.PhpVal, var_item_id rt.PhpVal, var_item rt.PhpVal, var_product rt.PhpVal) string {
	mut var_product_mutated := var_product
	mut var_is_visible := rt.new_bool(rt.new_bool(rt.is_true(var_product_mutated) && rt.is_true(rt.call_method(var_product_mutated, 'is_visible', []rt.PhpVal{}))))
	mut var_row_class := rt.call_function('apply_filters', [rt.new_string('woocommerce_order_item_class'), rt.new_string('woocommerce-table__line-item order_item'), var_item.dup(), var_order.dup()])
	mut var_product_permalink := rt.call_function('apply_filters', [rt.new_string('woocommerce_order_item_permalink'), if rt.is_true(var_is_visible) { rt.call_method(var_product_mutated, 'get_permalink', [var_item.dup()]) } else { rt.new_string('') }, var_item.dup(), var_order.dup()])
	mut var_item_name := rt.call_function('apply_filters', [rt.new_string('woocommerce_order_item_name'), if rt.is_true(var_product_permalink) { rt.call_function('sprintf', [rt.new_string('<a href="%s">%s</a>'), var_product_permalink.dup(), rt.call_method(var_item, 'get_name', []rt.PhpVal{})]) } else { rt.call_method(var_item, 'get_name', []rt.PhpVal{}) }, var_item.dup(), var_is_visible.dup()])
	mut var_qty := rt.call_method(var_item, 'get_quantity', []rt.PhpVal{})
	mut var_refunded_qty := rt.call_method(var_order, 'get_qty_refunded_for_item', [var_item_id.dup()])
	mut var_qty_display := if rt.is_true(var_refunded_qty) { '<del>' + (rt.call_function('esc_html', [var_qty.dup()])).str() + '</del> <ins>' + (rt.call_function('esc_html', [rt.sub(var_qty, rt.mul(var_refunded_qty, // unsupported expression: Expr_UnaryMinus))])).str() + '</ins>' } else { rt.call_function('esc_html', [var_qty.dup()]) }
	mut var_item_qty := rt.call_function('apply_filters', [rt.new_string('woocommerce_order_item_quantity_html'), '<strong class="product-quantity">' + (rt.call_function('sprintf', [rt.new_string('&times;&nbsp;%s'), var_qty_display.dup()])).str() + '</strong>', var_item.dup()])
	return '\n\t\t\t<tr class="' + (rt.call_function('esc_attr', [var_row_class.dup()])).str() + '">\n\t\t\t\t<td class="wc-block-order-confirmation-totals__product">\n\t\t\t\t\t' + (rt.call_function('wp_kses_post', [var_item_name.dup()])).str() + '&nbsp;\n\t\t\t\t\t' + (rt.call_function('wp_kses_post', [var_item_qty.dup()])).str() + '\n\t\t\t\t\t' + (this.get_hook_content(rt.new_string('woocommerce_order_item_meta_start'), rt.create_array([rt.ArrayItem{ key: none, val: var_item_id }, rt.ArrayItem{ key: none, val: var_item }, rt.ArrayItem{ key: none, val: var_order }, rt.ArrayItem{ key: none, val: false }]))).str() + '\n\t\t\t\t\t' + (rt.call_function('wc_display_item_meta', [var_item.dup(), rt.create_array([rt.ArrayItem{ key: 'echo', val: false }])])).str() + '\n\t\t\t\t\t' + (this.get_hook_content(rt.new_string('woocommerce_order_item_meta_end'), rt.create_array([rt.ArrayItem{ key: none, val: var_item_id }, rt.ArrayItem{ key: none, val: var_item }, rt.ArrayItem{ key: none, val: var_order }, rt.ArrayItem{ key: none, val: false }]))).str() + '\n\t\t\t\t\t' + this.render_order_details_table_item_purchase_note(var_order.dup(), var_product_mutated.dup()) + '\n\t\t\t\t</td>\n\t\t\t\t<td class="wc-block-order-confirmation-totals__total">\n\t\t\t\t\t' + (rt.call_function('wp_kses_post', [rt.call_method(var_order, 'get_formatted_line_subtotal', [var_item.dup()])])).str() + '\n\t\t\t\t</td>\n\t\t\t</tr>\n\t\t'
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_Totals) render_order_details_table_item_purchase_note(var_order rt.PhpVal, var_product rt.PhpVal) string {
	mut var_product_mutated := var_product
	mut var_show_purchase_note := rt.call_method(var_order, 'has_status', [rt.call_function('apply_filters', [rt.new_string('woocommerce_purchase_note_order_statuses'), rt.create_array([rt.ArrayItem{ key: none, val: 'completed' }, rt.ArrayItem{ key: none, val: 'processing' }])])])
	mut var_purchase_note := if rt.is_true(var_product_mutated) { rt.call_method(var_product_mutated, 'get_purchase_note', []rt.PhpVal{}) } else { rt.new_string('') }
	return if rt.is_true(rt.new_bool(rt.is_true(var_show_purchase_note) && rt.is_true(var_purchase_note))) { '<div class="product-purchase-note">' + (rt.call_function('wp_kses_post', [var_purchase_note.dup()])).str() + '</div>' } else { '' }
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_Totals) render_order_details_table_totals(var_order rt.PhpVal) rt.PhpVal {
	rt.call_function('add_filter', [rt.new_string('woocommerce_order_shipping_to_display_shipped_via'), rt.new_string('__return_empty_string')])
	mut var_return := rt.new_string(rt.new_string(''))
	mut var_total_rows := rt.call_function('array_diff_key', [rt.call_method(var_order, 'get_order_item_totals', []rt.PhpVal{}), rt.create_array([rt.ArrayItem{ key: 'cart_subtotal', val: '' }, rt.ArrayItem{ key: 'payment_method', val: '' }])])
	{
		mut iter_1 := var_total_rows.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_total := item_1.val
			// unsupported expression: Expr_AssignOp_Concat
		}
	}
	return var_return.dup()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_Totals) render_order_details_customer_note(var_order rt.PhpVal) string {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_order, 'get_customer_note', []rt.PhpVal{}))))) {
		return ''
	}
	return '<div class="wc-block-order-confirmation-order-note">' + '<p class="wc-block-order-confirmation-order-note__label">' + (rt.call_function('esc_html__', [rt.new_string('Note:'), rt.new_string('woocommerce')])).str() + '</p>' + '<p>' + (rt.call_function('wp_kses', [rt.call_function('nl2br', [rt.call_function('wptexturize', [rt.call_method(var_order, 'get_customer_note', []rt.PhpVal{})])]), rt.create_array([rt.ArrayItem{ key: 'br', val: rt.new_array() }])])).str() + '</p>' + '</div>'
}

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_AbstractOrderConfirmationBlock {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blocks_blocktypes_orderconfirmation_totals() &Class_Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_Totals {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_Totals{
		PhpObjectBase: rt.PhpObjectBase{}
		block_name: rt.new_string('order-confirmation-totals')
	}
	return obj
}

fn create_automattic_woocommerce_blocks_blocktypes_orderconfirmation_abstractorderconfirmationblock() &Class_Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_AbstractOrderConfirmationBlock {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_AbstractOrderConfirmationBlock{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_utils_styleattributesutils() &Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_Totals) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'render_content' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).str()
			return rt.new_string(this.render_content(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3))
		}
		'get_inline_styles' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_string(this.get_inline_styles(mut dispatch_arg_0))
		}
		'enqueue_assets' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_array](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			this.enqueue_assets(mut dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'render_order_details_table_items' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.render_order_details_table_items(dispatch_arg_0)
		}
		'render_order_details_table_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			return rt.new_string(this.render_order_details_table_item(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3))
		}
		'render_order_details_table_item_purchase_note' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_string(this.render_order_details_table_item_purchase_note(dispatch_arg_0, dispatch_arg_1))
		}
		'render_order_details_table_totals' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.render_order_details_table_totals(dispatch_arg_0)
		}
		'render_order_details_customer_note' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.render_order_details_customer_note(dispatch_arg_0))
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_Totals) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'block_name' { return this.block_name }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_Totals) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'block_name' { this.block_name = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_AbstractOrderConfirmationBlock) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_AbstractOrderConfirmationBlock) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_AbstractOrderConfirmationBlock) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_blocks_blocktypes_orderconfirmation_totals_php() {
}
