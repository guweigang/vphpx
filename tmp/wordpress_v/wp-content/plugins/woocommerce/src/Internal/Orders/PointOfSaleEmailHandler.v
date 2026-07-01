import rt

pub fn Class_Automattic_WooCommerce_Internal_Orders_PointOfSaleEmailHandler.suppressed_email_ids() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: none, val: 'customer_processing_order' },
		rt.ArrayItem{ key: none, val: 'customer_completed_order' },
		rt.ArrayItem{ key: none, val: 'customer_on_hold_order' },
		rt.ArrayItem{ key: none, val: 'customer_refunded_order' },
		rt.ArrayItem{ key: none, val: 'customer_partially_refunded_order' },
		rt.ArrayItem{ key: none, val: 'new_order' }])
}

struct Class_Automattic_WooCommerce_Internal_Orders_PointOfSaleEmailHandler {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Internal_Orders_PointOfSaleEmailHandler) register() {
	{
		mut iter_1 :=
			Class_Automattic_WooCommerce_Internal_Orders_Automattic_WooCommerce_Internal_Orders_PointOfSaleEmailHandler.suppressed_email_ids().iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_email_id := item_1.val
			rt.call_function('add_filter', [
				'woocommerce_email_enabled_' + var_email_id.str(),
				rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Orders_PointOfSaleEmailHandler', [
						'RegisterHooksInterface',
					], &this) },
					rt.ArrayItem{ key: none, val: 'maybe_suppress_email' },
				]),
				rt.new_int(10),
				rt.new_int(2),
			])
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Orders_PointOfSaleEmailHandler) maybe_suppress_email(enabled bool, var_order rt.PhpVal) bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_order,
		'WC_Abstract_Order'))))))
	{
		return enabled
	}
	if rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal {
		mut temp := Class_Automattic_WooCommerce_Internal_Orders_PointOfSaleOrderUtil{}
		return temp.is_order_paid_at_pos(arg_0)
	}(var_order.dup()))
	{
		return false
	}
	return enabled
}

struct Class_Automattic_WooCommerce_Internal_Orders_PointOfSaleOrderUtil {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_orders_pointofsaleemailhandler() &Class_Automattic_WooCommerce_Internal_Orders_PointOfSaleEmailHandler {
	mut obj := &Class_Automattic_WooCommerce_Internal_Orders_PointOfSaleEmailHandler{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_orders_pointofsaleorderutil() &Class_Automattic_WooCommerce_Internal_Orders_PointOfSaleOrderUtil {
	mut obj := &Class_Automattic_WooCommerce_Internal_Orders_PointOfSaleOrderUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_Orders_PointOfSaleEmailHandler) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'register' {
			this.register()
			return rt.new_null()
		}
		'maybe_suppress_email' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(this.maybe_suppress_email(dispatch_arg_0, dispatch_arg_1))
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Orders_PointOfSaleEmailHandler) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Orders_PointOfSaleEmailHandler) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Orders_PointOfSaleOrderUtil) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Orders_PointOfSaleOrderUtil) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Orders_PointOfSaleOrderUtil) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_content_plugins_woocommerce_src_internal_orders_pointofsaleemailhandler_php() {
	// unsupported statement: Stmt_Declare
}
