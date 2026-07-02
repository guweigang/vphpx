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

	mut var_product_object := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		exit(0)
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('woocommerce_wp_textarea_input', [
		rt.create_array([rt.ArrayItem{ key: 'id', val: '_purchase_note' },
			rt.ArrayItem{ key: 'value', val: rt.call_method(var_product_object,
				'get_purchase_note', [rt.new_string('edit')]) },
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('Purchase note'), rt.new_string('woocommerce')]) },
			rt.ArrayItem{ key: 'desc_tip', val: true }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Enter an optional note to send the customer after purchase.'),
				rt.new_string('woocommerce')]) }]),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('woocommerce_wp_text_input', [
		rt.create_array([rt.ArrayItem{ key: 'id', val: 'menu_order' },
			rt.ArrayItem{ key: 'value', val: rt.call_method(var_product_object, 'get_menu_order', [
				rt.new_string('edit'),
			]) }, rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('Menu order'),
				rt.new_string('woocommerce'),
			]) }, rt.ArrayItem{ key: 'desc_tip', val: true },
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Custom ordering position.'),
				rt.new_string('woocommerce'),
			]) }, rt.ArrayItem{ key: 'type', val: 'number' },
			rt.ArrayItem{ key: 'custom_attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'step', val: '1' },
			]) }]),
	])
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.call_function('post_type_supports', [rt.new_string('product'),
		rt.new_string('comments')]))
	{
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('woocommerce_wp_checkbox', [
			rt.create_array([rt.ArrayItem{ key: 'id', val: 'comment_status' },
				rt.ArrayItem{
					key: 'value'
					val: if rt.is_true(rt.call_method(var_product_object, 'get_reviews_allowed', [
						rt.new_string('edit'),
					]))
					{ 'open' } else { 'closed' }
				}, rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
					rt.new_string('Enable reviews'),
					rt.new_string('woocommerce'),
				]) }, rt.ArrayItem{ key: 'cbvalue', val: 'open' }]),
		])
		rt.call_function('do_action', [
			rt.new_string('woocommerce_product_options_reviews'),
		])
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	mut iife_temp_0 := Class_Automattic_WooCommerce_Utilities_FeaturesUtil{}
	mut iife_result_0 := iife_temp_0.feature_is_enabled(rt.new_string('point_of_sale'))
	if rt.is_true(iife_result_0) {
		// unsupported statement: Stmt_InlineHTML
		mut var_is_pos_supported :=
			rt.is_true(rt.call_method(var_product_object, 'is_type', [rt.create_array([rt.ArrayItem{
			key: none
			val: 'simple'
		}, rt.ArrayItem{ key: none, val: 'variable' }])]))
			&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_product_object, 'is_downloadable', []rt.PhpVal{})))))
		// unsupported statement: Stmt_InlineHTML
		print(if var_is_pos_supported { '' } else { 'style="display: none;"' })
		// unsupported statement: Stmt_InlineHTML
		mut var_visible_in_pos := !(rt.is_true(rt.call_function('has_term', [
			rt.new_string('pos-hidden'),
			rt.new_string('pos_product_visibility'),
			rt.call_method(var_product_object, 'get_id', []rt.PhpVal{}),
		])))
		rt.call_function('woocommerce_wp_checkbox', [
			rt.create_array([rt.ArrayItem{ key: 'id', val: '_visible_in_pos' },
				rt.ArrayItem{
					key: 'value'
					val: if var_visible_in_pos { 'yes' } else { 'no' }
				}, rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
					rt.new_string('Available for POS'),
					rt.new_string('woocommerce'),
				]) }, rt.ArrayItem{ key: 'desc_tip', val: true },
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Controls whether this product appears in the Point of Sale system.'),
					rt.new_string('woocommerce'),
				]) }]),
		])
		// unsupported statement: Stmt_InlineHTML
		print(if var_is_pos_supported { 'style="display: none;"' } else { '' })
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('woocommerce_wp_note', [
			rt.create_array([rt.ArrayItem{ key: 'id', val: '_pos_visibility_note' },
				rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
					rt.new_string('Point of Sale'),
					rt.new_string('woocommerce'),
				]) }, rt.ArrayItem{ key: 'message', val: rt.call_function('__', [
					rt.new_string('This product type is not currently supported.'),
					rt.new_string('woocommerce'),
				]) }]),
		])
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string('woocommerce_product_options_advanced')])
	// unsupported statement: Stmt_InlineHTML
}
