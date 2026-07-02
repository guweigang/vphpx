import rt

struct Class_Automattic_WooCommerce_Internal_OrderReviews_Meta {
	rt.PhpObjectBase
}

fn Class_Automattic_WooCommerce_Internal_OrderReviews_Meta.parts_for_order(mut var_order Class_WC_Order) rt.PhpVal {
	mut var_date_created := var_order.get_date_created()
	mut var_customer_name := rt.new_string((var_order.get_billing_first_name()).str() + ' ' +
		(var_order.get_billing_last_name()).str().trim_space())
	mut var_customer_email := var_order.get_billing_email()
	mut var_order_number := var_order.get_order_number()
	mut var_order_date_text := if rt.is_true(var_date_created) { rt.call_function('wc_format_datetime', [
			var_date_created.clone(),
		]) } else { rt.new_string('') }
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), var_order_date_text)))) {
		mut var_order_summary := rt.call_function('sprintf', [
			rt.call_function('__', [rt.new_string('Order #%1$s (%2$s)'),
				rt.new_string('woocommerce')]),
			var_order_number.clone(),
			var_order_date_text.clone(),
		])
	} else {
		var_order_summary = rt.call_function('sprintf', [
			rt.call_function('__', [rt.new_string('Order #%s'),
				rt.new_string('woocommerce')]),
			var_order_number.clone(),
		])
	}
	return rt.call_function('array_values', [
		rt.call_function('array_filter', [
			rt.create_array([rt.ArrayItem{ key: none, val: var_customer_name },
				rt.ArrayItem{ key: none, val: var_customer_email },
				rt.ArrayItem{ key: none, val: var_order_summary }]),
		]),
	])
}

fn create_automattic_woocommerce_internal_orderreviews_meta(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_OrderReviews_Meta {
	mut obj := &Class_Automattic_WooCommerce_Internal_OrderReviews_Meta{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_OrderReviews_Meta) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'parts_for_order' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Order](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return Class_Automattic_WooCommerce_Internal_OrderReviews_Meta.parts_for_order(mut dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_OrderReviews_Meta) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_OrderReviews_Meta) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
