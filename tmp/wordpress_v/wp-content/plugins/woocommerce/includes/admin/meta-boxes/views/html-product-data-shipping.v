import rt

struct Class_Automattic_WooCommerce_Utilities_I18nUtil {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_utilities_i18nutil() &Class_Automattic_WooCommerce_Utilities_I18nUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_I18nUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Utilities_I18nUtil) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Utilities_I18nUtil) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_I18nUtil) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_content_plugins_woocommerce_includes_admin_meta_boxes_views_html_product_data_shipping_php() {
	mut var_product_object := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		// unsupported expression: Expr_Exit
	}
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.call_function('wc_product_weight_enabled', []rt.PhpVal{})) {
		rt.call_function('woocommerce_wp_text_input', [
			rt.create_array([rt.ArrayItem{ key: 'id', val: '_weight' },
				rt.ArrayItem{ key: 'value', val: rt.call_method(var_product_object, 'get_weight', [
					rt.new_string('edit'),
				]) }, rt.ArrayItem{ key: 'label', val: rt.call_function('sprintf', [
					rt.call_function('__', [rt.new_string('Weight (%s)'),
						rt.new_string('woocommerce')]),
					fn (arg_0 rt.PhpVal) rt.PhpVal {
						mut temp := Class_Automattic_WooCommerce_Utilities_I18nUtil{}
						return temp.get_weight_unit_label(arg_0)
					}(rt.call_function('get_option', [rt.new_string('woocommerce_weight_unit'),
						rt.new_string('kg')])),
				]) }, rt.ArrayItem{ key: 'placeholder', val: rt.call_function('wc_format_localized_decimal', [
					rt.new_int(0),
				]) }, rt.ArrayItem{ key: 'desc_tip', val: true },
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Weight in decimal form'),
					rt.new_string('woocommerce'),
				]) }, rt.ArrayItem{ key: 'type', val: 'text' },
				rt.ArrayItem{ key: 'data_type', val: 'decimal' }]),
		])
	}
	if rt.is_true(rt.call_function('wc_product_dimensions_enabled', []rt.PhpVal{})) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('printf', [
			rt.call_function('esc_html__', [rt.new_string('Dimensions (%s)'),
				rt.new_string('woocommerce')]),
			rt.call_function('esc_html', [fn (arg_0 rt.PhpVal) rt.PhpVal {
				mut temp := Class_Automattic_WooCommerce_Utilities_I18nUtil{}
				return temp.get_dimensions_unit_label(arg_0)
			}(rt.call_function('get_option', [
				rt.new_string('woocommerce_dimension_unit'),
			]))]),
		])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_attr_e', [rt.new_string('Length'),
			rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [
			rt.call_function('wc_format_localized_decimal', [
				rt.call_method(var_product_object, 'get_length', [
					rt.new_string('edit')]),
			]),
		]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_attr_e', [rt.new_string('Width'),
			rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [
			rt.call_function('wc_format_localized_decimal', [
				rt.call_method(var_product_object, 'get_width', [
					rt.new_string('edit')]),
			]),
		]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_attr_e', [rt.new_string('Height'),
			rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [
			rt.call_function('wc_format_localized_decimal', [
				rt.call_method(var_product_object, 'get_height', [
					rt.new_string('edit')]),
			]),
		]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('wc_help_tip', [
			rt.call_function('__', [rt.new_string('LxWxH in decimal form'),
				rt.new_string('woocommerce')]),
		]))
		// unsupported statement: Stmt_InlineHTML
	}
	rt.call_function('do_action', [
		rt.new_string('woocommerce_product_options_dimensions'),
	])
	// unsupported statement: Stmt_InlineHTML
	mut var_args := {
		'taxonomy':         rt.new_string('product_shipping_class')
		'hide_empty':       rt.new_int(0)
		'show_option_none': rt.call_function('__', [rt.new_string('No shipping class'),
			rt.new_string('woocommerce')])
		'name':             rt.new_string('product_shipping_class')
		'id':               rt.new_string('product_shipping_class')
		'selected':         rt.call_method(var_product_object, 'get_shipping_class_id', [
			rt.new_string('edit'),
		])
		'class':            rt.new_string('select short')
		'orderby':          rt.new_string('name')
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Shipping class'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('wp_dropdown_categories', [var_args.dup()])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wc_help_tip', [
		rt.call_function('__', [
			rt.new_string('Shipping classes are used by certain shipping methods to group similar products.'),
			rt.new_string('woocommerce'),
		]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string('woocommerce_product_options_shipping')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [
		rt.new_string('woocommerce_product_options_shipping_product_data'),
	])
	// unsupported statement: Stmt_InlineHTML
}
