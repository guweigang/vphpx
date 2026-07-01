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




pub fn init_wp_content_plugins_woocommerce_templates_emails_plain_email_order_details_php() {
	mut var_order := rt.new_null()
	mut var_sent_to_admin := rt.new_null()
	mut var_plain_text := rt.new_null()
	mut var_email := rt.new_null()
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
	mut var_email_improvements_enabled := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Utilities_FeaturesUtil{}; return temp.feature_is_enabled(arg_0) }(rt.new_string('email_improvements'))
	if rt.is_true(var_email_improvements_enabled) {
		rt.call_function('add_filter', [rt.new_string('woocommerce_order_shipping_to_display_shipped_via'), rt.new_string('__return_false')])
	}
	rt.call_function('do_action', [rt.new_string('woocommerce_email_before_order_table'), var_order.dup(), var_sent_to_admin.dup(), var_plain_text.dup(), var_email.dup()])
	if rt.is_true(// unsupported expression: Expr_Cast_Bool) {
		if rt.is_true(var_email_improvements_enabled) {
			print((rt.call_function('wp_kses_post', [rt.call_function('sprintf', [rt.call_function('esc_html__', [rt.new_string('Order #%1$s (%2$s)'), rt.new_string('woocommerce')]), rt.call_method(var_order, 'get_order_number', []rt.PhpVal{}), rt.call_function('wc_format_datetime', [rt.call_method(var_order, 'get_date_created', []rt.PhpVal{})])])])).str() + '\n')
			print('\n==========\n')
		} else {
			print((rt.call_function('wp_kses_post', [rt.call_function('wc_strtoupper', [rt.call_function('sprintf', [rt.call_function('esc_html__', [rt.new_string('[Order #%1$s] (%2$s)'), rt.new_string('woocommerce')]), rt.call_method(var_order, 'get_order_number', []rt.PhpVal{}), rt.call_function('wc_format_datetime', [rt.call_method(var_order, 'get_date_created', []rt.PhpVal{})])])])])).str() + '\n')
		}
	}
	print('\n' + (rt.call_function('wc_get_email_order_items', [var_order.dup(), rt.create_array([rt.ArrayItem{ key: 'show_sku', val: var_sent_to_admin }, rt.ArrayItem{ key: 'show_image', val: false }, rt.ArrayItem{ key: 'image_size', val: rt.create_array([rt.ArrayItem{ key: none, val: 32 }, rt.ArrayItem{ key: none, val: 32 }]) }, rt.ArrayItem{ key: 'plain_text', val: true }, rt.ArrayItem{ key: 'sent_to_admin', val: var_sent_to_admin }])])).str())
	print('==========\n\n')
	mut var_item_totals := rt.call_method(var_order, 'get_order_item_totals', []rt.PhpVal{})
	if rt.is_true(var_item_totals) {
		{
			mut iter_1 := var_item_totals.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_total := item_1.val
				if rt.is_true(var_email_improvements_enabled) {
					mut var_label := var_total.array_get('label')
					if var_total.array_isset(rt.new_string('meta')) {
						// unsupported expression: Expr_AssignOp_Concat
					}
					rt.echo_val(rt.call_function('wp_kses_post', [rt.call_function('str_pad', [rt.call_function('wp_kses_post', [var_label.dup()]), rt.new_int(40)])]))
					print(' ')
					print((rt.call_function('esc_html', [rt.call_function('str_pad', [rt.call_function('wp_kses', [var_total.array_get('value'), rt.new_array()]), rt.new_int(20), rt.new_string(' '), rt.get_constant('STR_PAD_LEFT')])])).str() + '\n')
				} else {
					print((rt.call_function('wp_kses_post', [(var_total.array_get('label')).str() + '\t ' + (var_total.array_get('value')).str()])).str() + '\n')
				}
			}
		}
	}
	if rt.is_true(rt.call_method(var_order, 'get_customer_note', []rt.PhpVal{})) {
		if rt.is_true(var_email_improvements_enabled) {
			print('\n' + (rt.call_function('esc_html__', [rt.new_string('Note:'), rt.new_string('woocommerce')])).str() + '\n' + (rt.call_function('wp_kses', [rt.call_function('wc_wptexturize_order_note', [rt.call_method(var_order, 'get_customer_note', []rt.PhpVal{})]), rt.new_array()])).str() + '\n')
		} else {
			print((rt.call_function('esc_html__', [rt.new_string('Note:'), rt.new_string('woocommerce')])).str() + '\t ' + (rt.call_function('wp_kses', [rt.call_function('wc_wptexturize_order_note', [rt.call_method(var_order, 'get_customer_note', []rt.PhpVal{})]), rt.new_array()])).str() + '\n')
		}
	}
	if rt.is_true(var_sent_to_admin) {
		print('\n' + (rt.call_function('sprintf', [rt.call_function('esc_html__', [rt.new_string('View order: %s'), rt.new_string('woocommerce')]), rt.call_function('esc_url', [rt.call_method(var_order, 'get_edit_order_url', []rt.PhpVal{})])])).str() + '\n')
	}
	rt.call_function('do_action', [rt.new_string('woocommerce_email_after_order_table'), var_order.dup(), var_sent_to_admin.dup(), var_plain_text.dup(), var_email.dup()])
}
