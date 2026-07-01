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




pub fn init_wp_content_plugins_woocommerce_templates_emails_email_order_details_php() {
	mut var_order := rt.new_null()
	mut var_sent_to_admin := rt.new_null()
	mut var_plain_text := rt.new_null()
	mut var_email := rt.new_null()
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
	mut var_email_improvements_enabled := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Utilities_FeaturesUtil{}; return temp.feature_is_enabled(arg_0) }(rt.new_string('email_improvements'))
	mut var_block_email_editor_enabled := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Utilities_FeaturesUtil{}; return temp.feature_is_enabled(arg_0) }(rt.new_string('block_email_editor'))
	mut var_display_section_divider := // unsupported expression: Expr_Cast_Bool
	mut var_heading_class := if rt.is_true(var_email_improvements_enabled) { 'email-order-detail-heading' } else { '' }
	mut var_order_table_class := if rt.is_true(var_email_improvements_enabled) { 'email-order-details' } else { '' }
	mut var_order_total_text_align := if rt.is_true(var_email_improvements_enabled) { 'right' } else { 'left' }
	mut var_order_quantity_text_align := if rt.is_true(var_email_improvements_enabled) { 'right' } else { 'left' }
	if rt.is_true(var_email_improvements_enabled) {
		rt.call_function('add_filter', [rt.new_string('woocommerce_order_shipping_to_display_shipped_via'), rt.new_string('__return_false')])
	}
	rt.call_function('do_action', [rt.new_string('woocommerce_email_before_order_table'), var_order.dup(), var_sent_to_admin.dup(), var_plain_text.dup(), var_email.dup()])
	// unsupported statement: Stmt_InlineHTML
	mut var_order_details_heading := rt.new_string(rt.new_string(''))
	if rt.is_true(var_email_improvements_enabled) {
		var_order_details_heading = rt.call_function('apply_filters', [rt.new_string('woocommerce_email_order_details_heading'), rt.call_function('__', [rt.new_string('Order summary'), rt.new_string('woocommerce')]), var_order.dup(), var_email.dup()])
	}
	mut var_display_order_number := // unsupported expression: Expr_Cast_Bool
	if rt.is_true(rt.new_bool(rt.is_true(var_order_details_heading) || rt.is_true(var_display_order_number))) {
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [rt.new_string(var_heading_class).dup()]))
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(var_order_details_heading) {
			rt.echo_val(rt.call_function('wp_kses_post', [var_order_details_heading.dup()]))
		}
		if rt.is_true(var_display_order_number) {
			if rt.is_true(var_sent_to_admin) {
				mut var_before := rt.new_string('<a class="link" href="' + (rt.call_function('esc_url', [rt.call_method(var_order, 'get_edit_order_url', []rt.PhpVal{})])).str() + '"' + if rt.is_true(var_block_email_editor_enabled) { ' style="text-decoration: none;"' } else { '' } + '>')
				mut var_after := '</a>'
			} else {
				var_before = rt.new_string(rt.new_string(''))
				var_after = ''
			}
			if rt.is_true(var_email_improvements_enabled) {
				if rt.is_true(var_order_details_heading) {
					print('<br><span>')
				} else {
					print('<span>')
				}
			}
			mut var_order_number_string := rt.call_function('__', [rt.new_string('[Order #%s]'), rt.new_string('woocommerce')])
			if rt.is_true(var_email_improvements_enabled) {
				var_order_number_string = rt.call_function('__', [rt.new_string('Order #%s'), rt.new_string('woocommerce')])
			}
			rt.echo_val(rt.call_function('wp_kses_post', [rt.concat(var_before, rt.call_function('sprintf', [(var_order_number_string).str() + var_after + ' (<time datetime="%s">%s</time>)', rt.call_method(var_order, 'get_order_number', []rt.PhpVal{}), rt.call_method(rt.call_method(var_order, 'get_date_created', []rt.PhpVal{}), 'format', [rt.new_string('c')]), rt.call_function('wc_format_datetime', [rt.call_method(var_order, 'get_date_created', []rt.PhpVal{})])]))]))
			if rt.is_true(var_email_improvements_enabled) {
				print('</span>')
			}
		}
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	print(if rt.is_true(var_email_improvements_enabled) { '24px' } else { '40px' })
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [rt.new_string(var_order_table_class).dup()]))
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.new_bool(!(rt.is_true(var_block_email_editor_enabled)))) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Product'), rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [rt.new_string(var_order_quantity_text_align).dup()]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Quantity'), rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [rt.new_string(var_order_total_text_align).dup()]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Price'), rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	mut var_image_size := if rt.is_true(var_email_improvements_enabled) { 48 } else { 32 }
	rt.echo_val(rt.call_function('wc_get_email_order_items', [var_order.dup(), rt.create_array([rt.ArrayItem{ key: 'show_sku', val: var_sent_to_admin }, rt.ArrayItem{ key: 'show_image', val: var_email_improvements_enabled }, rt.ArrayItem{ key: 'image_size', val: rt.create_array([rt.ArrayItem{ key: none, val: var_image_size }, rt.ArrayItem{ key: none, val: var_image_size }]) }, rt.ArrayItem{ key: 'plain_text', val: var_plain_text }, rt.ArrayItem{ key: 'sent_to_admin', val: var_sent_to_admin }])]))
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(var_display_section_divider) {
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [rt.new_string(var_order_table_class).dup()]))
	// unsupported statement: Stmt_InlineHTML
	mut var_item_totals := rt.call_method(var_order, 'get_order_item_totals', []rt.PhpVal{})
	mut var_item_totals_count := var_item_totals.dup().array_count()
	if rt.is_true(var_item_totals) {
		mut var_i := 0
		{
			mut iter_1 := var_item_totals.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_total := item_1.val
				var_i += 1
				mut var_last_class := if var_i == var_item_totals_count { ' order-totals-last' } else { '' }
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_attr', [if !(var_total.array_get('type')).is_null() { var_total.array_get('type') } else { rt.new_string('unknown') }]))
				rt.echo_val(rt.call_function('esc_attr', [rt.new_string(var_last_class).dup()]))
				// unsupported statement: Stmt_InlineHTML
				print(if 1 == var_i { 'border-top-width: 4px;' } else { '' })
				// unsupported statement: Stmt_InlineHTML
				print((rt.call_function('wp_kses_post', [var_total.array_get('label')])).str() + ' ')
				if rt.is_true(var_email_improvements_enabled) {
					rt.echo_val(if var_total.array_isset(rt.new_string('meta')) { rt.call_function('wp_kses_post', [var_total.array_get('meta')]) } else { rt.new_string('') })
				}
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_attr', [rt.new_string(var_order_total_text_align).dup()]))
				// unsupported statement: Stmt_InlineHTML
				print(if 1 == var_i { 'border-top-width: 4px;' } else { '' })
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('wp_kses_post', [var_total.array_get('value')]))
				// unsupported statement: Stmt_InlineHTML
			}
		}
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_method(var_order, 'get_customer_note', []rt.PhpVal{})) && rt.is_true(rt.new_bool(!(rt.is_true(var_email_improvements_enabled)))))) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Note:'), rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('wp_kses', [rt.call_function('nl2br', [rt.call_function('wc_wptexturize_order_note', [rt.call_method(var_order, 'get_customer_note', []rt.PhpVal{})])]), rt.new_array()]))
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_method(var_order, 'get_customer_note', []rt.PhpVal{})) && rt.is_true(var_email_improvements_enabled))) {
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(var_display_section_divider) {
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [rt.new_string(var_order_table_class).dup()]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Customer note'), rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('wp_kses', [rt.call_function('nl2br', [rt.call_function('wc_wptexturize_order_note', [rt.call_method(var_order, 'get_customer_note', []rt.PhpVal{})])]), rt.create_array([rt.ArrayItem{ key: 'br', val: rt.new_array() }])]))
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(var_email_improvements_enabled) {
		rt.call_function('remove_filter', [rt.new_string('woocommerce_order_shipping_to_display_shipped_via'), rt.new_string('__return_false')])
	}
	rt.call_function('do_action', [rt.new_string('woocommerce_email_after_order_table'), var_order.dup(), var_sent_to_admin.dup(), var_plain_text.dup(), var_email.dup()])
}
