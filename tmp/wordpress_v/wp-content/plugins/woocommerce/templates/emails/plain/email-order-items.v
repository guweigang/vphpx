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




pub fn init_wp_content_plugins_woocommerce_templates_emails_plain_email_order_items_php() {
	mut var_items := rt.new_null()
	mut var_order := rt.new_null()
	mut var_show_sku := rt.new_null()
	mut var_plain_text := rt.new_null()
	mut var_show_purchase_note := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))))) {
		// unsupported expression: Expr_Exit
		// unsupported statement: Stmt_Nop
	}
	mut var_email_improvements_enabled := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Utilities_FeaturesUtil{}; return temp.feature_is_enabled(arg_0) }(rt.new_string('email_improvements'))
	{
		mut iter_1 := var_items.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_item := item_1.val
			mut var_item_id := item_1.key
			if rt.is_true(rt.call_function('apply_filters', [rt.new_string('woocommerce_order_item_visible'), rt.new_bool(true), var_item.dup()])) {
				mut var_product := rt.call_method(var_item, 'get_product', []rt.PhpVal{})
				mut var_sku := rt.new_string(rt.new_string(''))
				mut var_purchase_note := rt.new_string(rt.new_string(''))
				if rt.is_true(rt.new_bool(var_product.dup().is_object())) {
					var_sku = rt.call_method(var_product, 'get_sku', []rt.PhpVal{})
					var_purchase_note = rt.call_method(var_product, 'get_purchase_note', []rt.PhpVal{})
				}
				if rt.is_true(var_email_improvements_enabled) {
					mut var_product_name := rt.call_function('apply_filters', [rt.new_string('woocommerce_order_item_name'), rt.call_method(var_item, 'get_name', []rt.PhpVal{}), var_item.dup(), rt.new_bool(false)])
					mut var_quantity := rt.call_function('apply_filters', [rt.new_string('woocommerce_email_order_item_quantity'), rt.call_method(var_item, 'get_quantity', []rt.PhpVal{}), var_item.dup()])
					if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
						// unsupported expression: Expr_AssignOp_Concat
					}
					rt.echo_val(rt.call_function('wp_kses_post', [rt.call_function('str_pad', [rt.call_function('wp_kses_post', [var_product_name.dup()]), rt.new_int(40)])]))
					print(' ')
					print((rt.call_function('esc_html', [rt.call_function('str_pad', [rt.call_function('wp_kses', [rt.call_method(var_order, 'get_formatted_line_subtotal', [var_item.dup()]), rt.new_array()]), rt.new_int(20), rt.new_string(' '), rt.get_constant('STR_PAD_LEFT')])])).str() + '\n')
					if rt.is_true(rt.new_bool(rt.is_true(var_show_sku) && rt.is_true(var_sku))) {
						rt.echo_val(rt.call_function('esc_html', ['(#' + (var_sku).str() + ')\n']))
					}
				} else {
					rt.echo_val(rt.call_function('wp_kses_post', [rt.call_function('apply_filters', [rt.new_string('woocommerce_order_item_name'), rt.call_method(var_item, 'get_name', []rt.PhpVal{}), var_item.dup(), rt.new_bool(false)])]))
					if rt.is_true(rt.new_bool(rt.is_true(var_show_sku) && rt.is_true(var_sku))) {
						print(' (#' + (var_sku).str() + ')')
					}
					var_quantity = rt.call_function('apply_filters', [rt.new_string('woocommerce_email_order_item_quantity'), rt.call_method(var_item, 'get_quantity', []rt.PhpVal{}), var_item.dup()])
					if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
						print(' × ' + (var_quantity).str())
					}
					print(' = ' + (rt.call_method(var_order, 'get_formatted_line_subtotal', [var_item.dup()])).str() + '\n')
					// unsupported statement: Stmt_Nop
				}
				rt.call_function('do_action', [rt.new_string('woocommerce_order_item_meta_start'), var_item_id.dup(), var_item.dup(), var_order.dup(), var_plain_text.dup()])
				rt.echo_val(rt.call_function('strip_tags', [rt.call_function('wc_display_item_meta', [var_item.dup(), rt.create_array([rt.ArrayItem{ key: 'before', val: '\n- ' }, rt.ArrayItem{ key: 'separator', val: '\n- ' }, rt.ArrayItem{ key: 'after', val: '' }, rt.ArrayItem{ key: 'echo', val: false }, rt.ArrayItem{ key: 'autop', val: false }])])]))
				rt.call_function('do_action', [rt.new_string('woocommerce_order_item_meta_end'), var_item_id.dup(), var_item.dup(), var_order.dup(), var_plain_text.dup()])
			}
			if rt.is_true(rt.new_bool(rt.is_true(var_show_purchase_note) && rt.is_true(var_purchase_note))) {
				print('\n' + (rt.call_function('do_shortcode', [rt.call_function('wp_kses_post', [var_purchase_note.dup()])])).str())
			}
			print('\n\n')
		}
	}
}
