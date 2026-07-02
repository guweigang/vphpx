import rt

struct Class_Automattic_WooCommerce_Internal_Email_OrderPriceFormatter {
	rt.PhpObjectBase
}

fn Class_Automattic_WooCommerce_Internal_Email_OrderPriceFormatter.get_formatted_item_subtotal(mut var_order Class_WC_Abstract_Order, mut var_item Class_WC_Order_Item, tax_display string) string {
	mut var_includes_tax := rt.new_bool('excl' != tax_display)
	mut var_item_subtotal := var_order.get_item_subtotal(rt.new_object('WC_Order_Item', []string{},
		var_item), var_includes_tax.clone())
	return (Class_Automattic_WooCommerce_Internal_Email_OrderPriceFormatter.format_price(mut var_order,
		var_item_subtotal.to_f64(), var_includes_tax.to_bool())).str()
}

fn Class_Automattic_WooCommerce_Internal_Email_OrderPriceFormatter.format_price(mut var_order Class_WC_Abstract_Order, amount f64, includes_tax bool) string {
	mut includes_tax_mutated := includes_tax
	return (rt.call_function('wc_price', [rt.new_float(amount),
		rt.create_array([
			rt.ArrayItem{
				key: 'ex_tax_label'
				val: if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(includes_tax_mutated)))))
					&& rt.is_true(var_order.get_prices_include_tax()) {
					1
				} else {
					0
				}
			},
			rt.ArrayItem{ key: 'currency', val: var_order.get_currency() },
		])])).str()
}

fn create_automattic_woocommerce_internal_email_orderpriceformatter(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Email_OrderPriceFormatter {
	mut obj := &Class_Automattic_WooCommerce_Internal_Email_OrderPriceFormatter{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_Email_OrderPriceFormatter) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_formatted_item_subtotal' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Abstract_Order](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_WC_Order_Item](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			return rt.new_string(Class_Automattic_WooCommerce_Internal_Email_OrderPriceFormatter.get_formatted_item_subtotal(mut dispatch_arg_0, mut
				dispatch_arg_1, dispatch_arg_2))
		}
		'format_price' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Abstract_Order](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_f64()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
			return rt.new_string(Class_Automattic_WooCommerce_Internal_Email_OrderPriceFormatter.format_price(mut dispatch_arg_0,
				dispatch_arg_1, dispatch_arg_2))
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Email_OrderPriceFormatter) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Email_OrderPriceFormatter) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
