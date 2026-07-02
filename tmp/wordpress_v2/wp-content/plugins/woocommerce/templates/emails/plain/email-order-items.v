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

	mut var_items := rt.new_null()
	mut var_order := rt.new_null()
	mut var_show_sku := rt.new_null()
	mut var_plain_text := rt.new_null()
	mut var_show_purchase_note := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		exit(0)
	}
	mut iife_temp_0 := Class_Automattic_WooCommerce_Utilities_FeaturesUtil{}
	mut iife_result_0 := iife_temp_0.feature_is_enabled(rt.new_string('email_improvements'))
	mut var_email_improvements_enabled := iife_result_0
	mut iter_1 := var_items.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_item := item_1.val
		mut var_item_id := item_1.key
		if rt.is_true(rt.call_function('apply_filters', [
			rt.new_string('woocommerce_order_item_visible'),
			rt.new_bool(true),
			var_item.clone(),
		]))
		{
			mut var_product := rt.call_method(var_item, 'get_product', []rt.PhpVal{})
			mut var_sku := rt.new_string('')
			mut var_purchase_note := rt.new_string('')
			if rt.is_true(rt.new_bool(var_product.clone().is_object())) {
				var_sku = rt.call_method(var_product, 'get_sku', []rt.PhpVal{})
				var_purchase_note = rt.call_method(var_product, 'get_purchase_note', []rt.PhpVal{})
			}
			if rt.is_true(var_email_improvements_enabled) {
				mut var_product_name := rt.call_function('apply_filters', [
					rt.new_string('woocommerce_order_item_name'),
					rt.call_method(var_item, 'get_name', []rt.PhpVal{}),
					var_item.clone(),
					rt.new_bool(false),
				])
				mut var_quantity := rt.call_function('apply_filters', [
					rt.new_string('woocommerce_email_order_item_quantity'),
					rt.call_method(var_item, 'get_quantity', []rt.PhpVal{}),
					var_item.clone(),
				])
				if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), var_quantity)))) {
					var_product_name = rt.concat(var_product_name, rt.new_string(' × ' +
						var_quantity.str()))
				}
				rt.echo_val(rt.call_function('wp_kses_post', [
					rt.call_function('str_pad', [
						rt.call_function('wp_kses_post', [var_product_name.clone()]),
						rt.new_int(40),
					]),
				]))
				print(' ')
				print(
					(rt.call_function('esc_html', [rt.call_function('str_pad', [rt.call_function('wp_kses', [rt.call_method(var_order, 'get_formatted_line_subtotal', [var_item.clone()]), rt.new_array()]), rt.new_int(20), rt.new_string(' '), rt.get_constant('STR_PAD_LEFT')])])).str() +
					'\n')
				if rt.is_true(var_show_sku) && rt.is_true(var_sku) {
					rt.echo_val(rt.call_function('esc_html', [
						rt.new_string('(#' + var_sku.str() + ')\n'),
					]))
				}
			} else {
				rt.echo_val(rt.call_function('wp_kses_post', [
					rt.call_function('apply_filters', [
						rt.new_string('woocommerce_order_item_name'),
						rt.call_method(var_item, 'get_name', []rt.PhpVal{}),
						var_item.clone(),
						rt.new_bool(false),
					]),
				]))
				if rt.is_true(var_show_sku) && rt.is_true(var_sku) {
					print(' (#' + var_sku.str() + ')')
				}
				var_quantity = rt.call_function('apply_filters', [
					rt.new_string('woocommerce_email_order_item_quantity'),
					rt.call_method(var_item, 'get_quantity', []rt.PhpVal{}),
					var_item.clone(),
				])
				if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), var_quantity)))) {
					print(' × ' + var_quantity.str())
				}
				print(' = ' +
					(rt.call_method(var_order, 'get_formatted_line_subtotal', [var_item.clone()])).str() +
					'\n')
			}
			rt.call_function('do_action', [
				rt.new_string('woocommerce_order_item_meta_start'),
				var_item_id.clone(),
				var_item.clone(),
				var_order.clone(),
				var_plain_text.clone(),
			])
			rt.echo_val(rt.call_function('strip_tags', [
				rt.call_function('wc_display_item_meta', [var_item.clone(),
					rt.create_array([rt.ArrayItem{ key: 'before', val: '\n- ' },
						rt.ArrayItem{ key: 'separator', val: '\n- ' },
						rt.ArrayItem{ key: 'after', val: '' },
						rt.ArrayItem{ key: 'echo', val: false },
						rt.ArrayItem{ key: 'autop', val: false }])]),
			]))
			rt.call_function('do_action', [
				rt.new_string('woocommerce_order_item_meta_end'),
				var_item_id.clone(),
				var_item.clone(),
				var_order.clone(),
				var_plain_text.clone(),
			])
		}
		if rt.is_true(var_show_purchase_note) && rt.is_true(var_purchase_note) {
			print('\n' +(rt.call_function('do_shortcode', [rt.call_function('wp_kses_post', [var_purchase_note.clone()])])).str())
		}
		print('\n\n')
	}
}
