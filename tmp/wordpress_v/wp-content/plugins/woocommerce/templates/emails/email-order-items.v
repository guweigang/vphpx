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




pub fn init_wp_content_plugins_woocommerce_templates_emails_email_order_items_php() {
	mut var_items := rt.new_null()
	mut var_image_size := rt.new_null()
	mut var_order := rt.new_null()
	mut var_show_image := rt.new_null()
	mut var_show_sku := rt.new_null()
	mut var_plain_text := rt.new_null()
	mut var_show_purchase_note := rt.new_null()
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
	mut var_margin_side := if rt.is_true(rt.call_function('is_rtl', []rt.PhpVal{})) { 'left' } else { 'right' }
	mut var_email_improvements_enabled := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Utilities_FeaturesUtil{}; return temp.feature_is_enabled(arg_0) }(rt.new_string('email_improvements'))
	mut var_price_text_align := if rt.is_true(var_email_improvements_enabled) { 'right' } else { 'left' }
	mut var_block_email_editor_enabled := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Utilities_FeaturesUtil{}; return temp.feature_is_enabled(arg_0) }(rt.new_string('block_email_editor'))
	{
		mut iter_1 := var_items.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_item := item_1.val
			mut var_item_id := item_1.key
			mut var_product := rt.call_method(var_item, 'get_product', []rt.PhpVal{})
			mut var_sku := rt.new_string(rt.new_string(''))
			mut var_purchase_note := rt.new_string(rt.new_string(''))
			mut var_image := rt.new_string(rt.new_string(''))
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('apply_filters', [rt.new_string('woocommerce_order_item_visible'), rt.new_bool(true), var_item.dup()]))))) {
				continue
			}
			if rt.is_true(rt.new_bool(var_product.dup().is_object())) {
				var_sku = rt.call_method(var_product, 'get_sku', []rt.PhpVal{})
				var_purchase_note = rt.call_method(var_product, 'get_purchase_note', []rt.PhpVal{})
				var_image = rt.call_method(var_product, 'get_image', [var_image_size.dup()])
			}
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [rt.call_function('apply_filters', [rt.new_string('woocommerce_order_item_class'), rt.new_string('order_item'), var_item.dup(), var_order.dup()])]))
			// unsupported statement: Stmt_InlineHTML
			print(if rt.is_true(var_block_email_editor_enabled) { 'top' } else { 'middle' })
			// unsupported statement: Stmt_InlineHTML
			if rt.is_true(var_email_improvements_enabled) {
				// unsupported statement: Stmt_InlineHTML
				if rt.is_true(var_show_image) {
					print('<td style="vertical-align: top;">' + (rt.call_function('wp_kses_post', [rt.call_function('apply_filters', [rt.new_string('woocommerce_order_item_thumbnail'), var_image.dup(), var_item.dup()])])).str() + '</td>')
				}
				// unsupported statement: Stmt_InlineHTML
				mut var_order_item_name := rt.call_function('apply_filters', [rt.new_string('woocommerce_order_item_name'), rt.call_method(var_item, 'get_name', []rt.PhpVal{}), var_item.dup(), rt.new_bool(false)])
				rt.echo_val(rt.call_function('wp_kses_post', [rt.new_string("<h3 style='font-size: inherit;font-weight: inherit;'>${var_order_item_name.to_string()}</h3>")]))
				if rt.is_true(rt.new_bool(rt.is_true(var_show_sku) && rt.is_true(var_sku))) {
					rt.echo_val(rt.call_function('wp_kses_post', [' (#' + (var_sku).str() + ')']))
				}
				rt.call_function('do_action', [rt.new_string('woocommerce_order_item_meta_start'), var_item_id.dup(), var_item.dup(), var_order.dup(), var_plain_text.dup()])
				mut var_item_meta := rt.call_function('wc_display_item_meta', [var_item.dup(), rt.create_array([rt.ArrayItem{ key: 'before', val: '' }, rt.ArrayItem{ key: 'after', val: '' }, rt.ArrayItem{ key: 'separator', val: '<br>' }, rt.ArrayItem{ key: 'echo', val: false }, rt.ArrayItem{ key: 'label_before', val: '<span>' }, rt.ArrayItem{ key: 'label_after', val: ':</span> ' }])])
				print('<div class="email-order-item-meta">')
				rt.echo_val(rt.call_function('wp_kses', [var_item_meta.dup(), rt.create_array([rt.ArrayItem{ key: 'br', val: rt.new_array() }, rt.ArrayItem{ key: 'span', val: rt.new_array() }, rt.ArrayItem{ key: 'a', val: rt.create_array([rt.ArrayItem{ key: 'href', val: true }, rt.ArrayItem{ key: 'target', val: true }, rt.ArrayItem{ key: 'rel', val: true }, rt.ArrayItem{ key: 'title', val: true }]) }])]))
				print('</div>')
				rt.call_function('do_action', [rt.new_string('woocommerce_order_item_meta_end'), var_item_id.dup(), var_item.dup(), var_order.dup(), var_plain_text.dup()])
				// unsupported statement: Stmt_InlineHTML
			} else {
				if rt.is_true(var_show_image) {
					rt.echo_val(rt.call_function('wp_kses_post', [rt.call_function('apply_filters', [rt.new_string('woocommerce_order_item_thumbnail'), var_image.dup(), var_item.dup()])]))
				}
				rt.echo_val(rt.call_function('wp_kses_post', [rt.call_function('apply_filters', [rt.new_string('woocommerce_order_item_name'), rt.call_method(var_item, 'get_name', []rt.PhpVal{}), var_item.dup(), rt.new_bool(false)])]))
				if rt.is_true(rt.new_bool(rt.is_true(var_show_sku) && rt.is_true(var_sku))) {
					rt.echo_val(rt.call_function('wp_kses_post', [' (#' + (var_sku).str() + ')']))
				}
				rt.call_function('do_action', [rt.new_string('woocommerce_order_item_meta_start'), var_item_id.dup(), var_item.dup(), var_order.dup(), var_plain_text.dup()])
				rt.call_function('wc_display_item_meta', [var_item.dup(), rt.create_array([rt.ArrayItem{ key: 'label_before', val: '<strong class="wc-item-meta-label" style="float: ' + if rt.is_true(rt.call_function('is_rtl', []rt.PhpVal{})) { 'right' } else { 'left' } + '; margin-' + (rt.call_function('esc_attr', [rt.new_string(var_margin_side).dup()])).str() + ': .25em; clear: both">' }])])
				rt.call_function('do_action', [rt.new_string('woocommerce_order_item_meta_end'), var_item_id.dup(), var_item.dup(), var_order.dup(), var_plain_text.dup()])
			}
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [rt.new_string(var_price_text_align).dup()]))
			// unsupported statement: Stmt_InlineHTML
			mut var_qty := rt.call_method(var_item, 'get_quantity', []rt.PhpVal{})
			mut var_refunded_qty := rt.call_method(var_order, 'get_qty_refunded_for_item', [var_item_id.dup()])
			if rt.is_true(var_refunded_qty) {
				mut var_qty_display := rt.new_string('<del>' + (rt.call_function('esc_html', [var_qty.dup()])).str() + '</del> <ins>' + (rt.call_function('esc_html', [rt.sub(var_qty, rt.mul(var_refunded_qty, // unsupported expression: Expr_UnaryMinus))])).str() + '</ins>')
			} else {
				var_qty_display = rt.call_function('esc_html', [var_qty.dup()])
			}
			mut var_quantity := rt.call_function('apply_filters', [rt.new_string('woocommerce_email_order_item_quantity'), var_qty_display.dup(), var_item.dup()])
			if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
				mut var_quantity_prefix := if rt.is_true(var_email_improvements_enabled) { '&times;' } else { '' }
				rt.echo_val(rt.call_function('wp_kses_post', [var_quantity_prefix + (var_quantity).str()]))
			}
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [rt.new_string(var_price_text_align).dup()]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('wp_kses_post', [rt.call_method(var_order, 'get_formatted_line_subtotal', [var_item.dup()])]))
			// unsupported statement: Stmt_InlineHTML
			if rt.is_true(rt.new_bool(rt.is_true(var_show_purchase_note) && rt.is_true(var_purchase_note))) {
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('wp_kses_post', [rt.call_function('wpautop', [rt.call_function('do_shortcode', [var_purchase_note.dup()])])]))
				// unsupported statement: Stmt_InlineHTML
			}
			// unsupported statement: Stmt_InlineHTML
		}
	}
}
