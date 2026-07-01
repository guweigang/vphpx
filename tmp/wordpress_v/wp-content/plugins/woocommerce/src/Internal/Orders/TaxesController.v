import rt

struct Class_Automattic_WooCommerce_Internal_Orders_TaxesController {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Internal_Orders_TaxesController) calc_line_taxes_via_ajax()  {
	rt.call_function('check_ajax_referer', [rt.new_string('calc-totals'), rt.new_string('security')])
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_shop_orders')]))))) || !(rt.get_superglobal('_POST').array_isset(rt.new_string('order_id')) && rt.get_superglobal('_POST').array_isset(rt.new_string('items'))))) {
		rt.call_function('wp_die', [// unsupported expression: Expr_UnaryMinus])
	}
	mut var_order := this.calc_line_taxes(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Orders_array](rt.get_superglobal('_POST')))
	rt.include_file(@DIR + '/../../../includes/admin/meta-boxes/views/html-order-items.php', '1')
	rt.call_function('wp_die', []rt.PhpVal{})
}

fn (mut this Class_Automattic_WooCommerce_Internal_Orders_TaxesController) calc_line_taxes(mut var_post_variables Class_Automattic_WooCommerce_Internal_Orders_array) rt.PhpVal {
	mut var_order_id := rt.call_function('absint', [var_post_variables.array_get('order_id')])
	mut var_calculate_tax_args := rt.create_array([rt.ArrayItem{ key: 'country', val: if var_post_variables.array_isset(rt.new_string('country')) { rt.call_function('wc_strtoupper', [rt.call_function('wc_clean', [rt.call_function('wp_unslash', [var_post_variables.array_get('country')])])]) } else { rt.new_string('') } }, rt.ArrayItem{ key: 'state', val: if var_post_variables.array_isset(rt.new_string('state')) { rt.call_function('wc_strtoupper', [rt.call_function('wc_clean', [rt.call_function('wp_unslash', [var_post_variables.array_get('state')])])]) } else { rt.new_string('') } }, rt.ArrayItem{ key: 'postcode', val: if var_post_variables.array_isset(rt.new_string('postcode')) { rt.call_function('wc_strtoupper', [rt.call_function('wc_clean', [rt.call_function('wp_unslash', [var_post_variables.array_get('postcode')])])]) } else { rt.new_string('') } }, rt.ArrayItem{ key: 'city', val: if var_post_variables.array_isset(rt.new_string('city')) { rt.call_function('wc_strtoupper', [rt.call_function('wc_clean', [rt.call_function('wp_unslash', [var_post_variables.array_get('city')])])]) } else { rt.new_string('') } }])
	mut var_items := rt.new_array()
	rt.call_function('parse_str', [rt.call_function('wp_unslash', [var_post_variables.array_get('items')]), var_items.dup()])
	rt.call_function('wc_save_order_items', [var_order_id.dup(), var_items.dup()])
	mut var_order := rt.call_function('wc_get_order', [var_order_id.dup()])
	rt.call_method(var_order, 'calculate_taxes', [var_calculate_tax_args.dup()])
	rt.call_method(var_order, 'calculate_totals', [rt.new_bool(false)])
	return var_order.dup()
}

fn create_automattic_woocommerce_internal_orders_taxescontroller() &Class_Automattic_WooCommerce_Internal_Orders_TaxesController {
	mut obj := &Class_Automattic_WooCommerce_Internal_Orders_TaxesController{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_Orders_TaxesController) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'calc_line_taxes_via_ajax' {
			this.calc_line_taxes_via_ajax()
			return rt.new_null()
		}
		'calc_line_taxes' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Orders_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.calc_line_taxes(mut dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Orders_TaxesController) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Orders_TaxesController) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_internal_orders_taxescontroller_php() {
}
