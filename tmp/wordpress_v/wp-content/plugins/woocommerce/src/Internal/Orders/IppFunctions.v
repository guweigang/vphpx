import rt

struct Class_Automattic_WooCommerce_Internal_Orders_IppFunctions {
	rt.PhpObjectBase
}

fn Class_Automattic_WooCommerce_Internal_Orders_IppFunctions.is_order_in_person_payment_eligible(mut var_order Class_WC_Order) bool {
	mut var_has_status := rt.call_function('in_array', [var_order.get_status(),
		rt.create_array([rt.ArrayItem{ key: none, val: 'pending' },
			rt.ArrayItem{ key: none, val: 'on-hold' }, rt.ArrayItem{ key: none, val: 'processing' }]),
		rt.new_bool(true)])
	mut var_has_payment_method := rt.call_function('in_array', [
		var_order.get_payment_method(),
		rt.create_array([
			rt.ArrayItem{ key: none, val: Class_WC_Gateway_COD.id() },
			rt.ArrayItem{ key: none, val: 'woocommerce_payments' },
			rt.ArrayItem{ key: none, val: 'none' },
		]),
		rt.new_bool(true)])
	mut var_order_is_not_paid := rt.identical(rt.new_null(), var_order.get_date_paid())
	mut var_order_is_not_refunded := rt.new_bool(!rt.is_true(var_order.get_refunds()))
	mut var_order_has_no_subscription_products := rt.new_bool(rt.new_bool(true))
	{
		mut iter_1 := var_order.get_items().iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_item := item_1.val
			mut var_product := rt.call_method(var_item, 'get_product', []rt.PhpVal{})
			if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_product.dup().is_object()))
				&& rt.is_true(rt.call_method(var_product, 'is_type', [rt.new_string('subscription')]))))
			{
				var_order_has_no_subscription_products = rt.new_bool(rt.new_bool(false))
				break
			}
		}
	}
	return
		rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(var_has_status)
		&& rt.is_true(var_has_payment_method))) && rt.is_true(var_order_is_not_paid)))
		&& rt.is_true(var_order_is_not_refunded)))
		&& rt.is_true(var_order_has_no_subscription_products)
}

fn Class_Automattic_WooCommerce_Internal_Orders_IppFunctions.is_store_in_person_payment_eligible() bool {
	mut var_is_store_usa_based := Class_Automattic_WooCommerce_Internal_Orders_IppFunctions.has_store_specified_country_currency('US',
		'USD')
	mut var_is_store_canada_based := Class_Automattic_WooCommerce_Internal_Orders_IppFunctions.has_store_specified_country_currency('CA',
		'CAD')
	return rt.is_true(var_is_store_usa_based) || rt.is_true(var_is_store_canada_based)
}

fn Class_Automattic_WooCommerce_Internal_Orders_IppFunctions.has_store_specified_country_currency(country string, currency string) bool {
	return
		rt.is_true(rt.identical(rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'countries'), 'get_base_country', []rt.PhpVal{}), rt.new_string(country)))
		&& rt.is_true(rt.identical(rt.call_function('get_woocommerce_currency', []rt.PhpVal{}), rt.new_string(currency)))
}

fn create_automattic_woocommerce_internal_orders_ippfunctions() &Class_Automattic_WooCommerce_Internal_Orders_IppFunctions {
	mut obj := &Class_Automattic_WooCommerce_Internal_Orders_IppFunctions{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_Orders_IppFunctions) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'is_order_in_person_payment_eligible' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Order](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return rt.new_bool(Class_Automattic_WooCommerce_Internal_Orders_IppFunctions.is_order_in_person_payment_eligible(mut dispatch_arg_0))
		}
		'is_store_in_person_payment_eligible' {
			return rt.new_bool(Class_Automattic_WooCommerce_Internal_Orders_IppFunctions.is_store_in_person_payment_eligible())
		}
		'has_store_specified_country_currency' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return rt.new_bool(Class_Automattic_WooCommerce_Internal_Orders_IppFunctions.has_store_specified_country_currency(dispatch_arg_0,
				dispatch_arg_1))
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Orders_IppFunctions) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Orders_IppFunctions) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_content_plugins_woocommerce_src_internal_orders_ippfunctions_php() {
}
