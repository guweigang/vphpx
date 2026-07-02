import rt

struct Class_Automattic_WooCommerce_Utilities_FeaturesUtil {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_utilities_featuresutil(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Utilities_FeaturesUtil {
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

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_order := rt.new_null()
	mut var_sent_to_admin := rt.new_null()
	mut var_plain_text := rt.new_null()
	mut var_email := rt.new_null()
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
	mut iife_temp_0 := Class_Automattic_WooCommerce_Utilities_FeaturesUtil{}
	mut iife_result_0 := iife_temp_0.feature_is_enabled(rt.new_string('email_improvements'))
	mut var_email_improvements_enabled := iife_result_0
	if rt.is_true(var_email_improvements_enabled) {
		rt.call_function('add_filter', [
			rt.new_string('woocommerce_order_shipping_to_display_shipped_via'),
			rt.new_string('__return_false'),
		])
	}
	rt.call_function('do_action', [rt.new_string('woocommerce_email_before_order_table'),
		var_order.clone(), var_sent_to_admin.clone(), var_plain_text.clone(),
		var_email.clone()])
	if rt.is_true((rt.call_function('apply_filters', [
		rt.new_string('woocommerce_email_display_order_number'),
		rt.new_bool(true),
		var_order.clone(),
		var_email.clone(),
	])).to_bool())
	{
		if rt.is_true(var_email_improvements_enabled) {
			print(
				(rt.call_function('wp_kses_post', [rt.call_function('sprintf', [rt.call_function('esc_html__', [rt.new_string('Order #%1$s (%2$s)'), rt.new_string('woocommerce')]), rt.call_method(var_order, 'get_order_number', []rt.PhpVal{}), rt.call_function('wc_format_datetime', [rt.call_method(var_order, 'get_date_created', []rt.PhpVal{})])])])).str() +
				'\n')
			print('\n==========\n')
		} else {
			print(
				(rt.call_function('wp_kses_post', [rt.call_function('wc_strtoupper', [rt.call_function('sprintf', [rt.call_function('esc_html__', [rt.new_string('[Order #%1$s] (%2$s)'), rt.new_string('woocommerce')]), rt.call_method(var_order, 'get_order_number', []rt.PhpVal{}), rt.call_function('wc_format_datetime', [rt.call_method(var_order, 'get_date_created', []rt.PhpVal{})])])])])).str() +
				'\n')
		}
	}
	print('\n' +(rt.call_function('wc_get_email_order_items', [var_order.clone(), rt.create_array([rt.ArrayItem{
		key: 'show_sku'
		val: var_sent_to_admin
	}, rt.ArrayItem{ key: 'show_image', val: false }, rt.ArrayItem{ key: 'image_size', val: rt.create_array([rt.ArrayItem{
		key: none
		val: 32
	}, rt.ArrayItem{ key: none, val: 32 }]) }, rt.ArrayItem{ key: 'plain_text', val: true }, rt.ArrayItem{
		key: 'sent_to_admin'
		val: var_sent_to_admin
	}])])).str())
	print('==========\n\n')
	mut var_item_totals := rt.call_method(var_order, 'get_order_item_totals', []rt.PhpVal{})
	if rt.is_true(var_item_totals) {
		mut iter_1 := var_item_totals.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_total := item_1.val
			if rt.is_true(var_email_improvements_enabled) {
				mut var_label := var_total.array_get(rt.new_string('label'))
				if var_total.array_isset(rt.new_string('meta')) {
					var_label = rt.concat(var_label, rt.new_string(' ' +
						(var_total.array_get(rt.new_string('meta'))).str()))
				}
				rt.echo_val(rt.call_function('wp_kses_post', [
					rt.call_function('str_pad', [
						rt.call_function('wp_kses_post', [var_label.clone()]),
						rt.new_int(40),
					]),
				]))
				print(' ')
				print(
					(rt.call_function('esc_html', [rt.call_function('str_pad', [rt.call_function('wp_kses', [var_total.array_get(rt.new_string('value')), rt.new_array()]), rt.new_int(20), rt.new_string(' '), rt.get_constant('STR_PAD_LEFT')])])).str() +
					'\n')
			} else {
				print(
					(rt.call_function('wp_kses_post', [rt.new_string((var_total.array_get(rt.new_string('label'))).str() +
					'\t ' + (var_total.array_get(rt.new_string('value'))).str())])).str() + '\n')
			}
		}
	}
	if rt.is_true(rt.call_method(var_order, 'get_customer_note', []rt.PhpVal{})) {
		if rt.is_true(var_email_improvements_enabled) {
			print('\n' +
				(rt.call_function('esc_html__', [rt.new_string('Note:'), rt.new_string('woocommerce')])).str() +
				'\n' +
				(rt.call_function('wp_kses', [rt.call_function('wc_wptexturize_order_note', [rt.call_method(var_order, 'get_customer_note', []rt.PhpVal{})]), rt.new_array()])).str() +
				'\n')
		} else {
			print(
				(rt.call_function('esc_html__', [rt.new_string('Note:'), rt.new_string('woocommerce')])).str() +
				'\t ' +
				(rt.call_function('wp_kses', [rt.call_function('wc_wptexturize_order_note', [rt.call_method(var_order, 'get_customer_note', []rt.PhpVal{})]), rt.new_array()])).str() +
				'\n')
		}
	}
	if rt.is_true(var_sent_to_admin) {
		print('\n' +
			(rt.call_function('sprintf', [rt.call_function('esc_html__', [rt.new_string('View order: %s'), rt.new_string('woocommerce')]), rt.call_function('esc_url', [rt.call_method(var_order, 'get_edit_order_url', []rt.PhpVal{})])])).str() +
			'\n')
	}
	rt.call_function('do_action', [rt.new_string('woocommerce_email_after_order_table'),
		var_order.clone(), var_sent_to_admin.clone(), var_plain_text.clone(),
		var_email.clone()])
}
