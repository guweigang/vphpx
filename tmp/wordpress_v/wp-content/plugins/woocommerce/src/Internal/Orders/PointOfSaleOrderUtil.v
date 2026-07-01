import rt

struct Class_Automattic_WooCommerce_Internal_Orders_PointOfSaleOrderUtil {
	rt.PhpObjectBase
}

fn Class_Automattic_WooCommerce_Internal_Orders_PointOfSaleOrderUtil.is_pos_order(mut var_order Class_WC_Abstract_Order) bool {
	return (rt.identical(rt.new_string('pos-rest-api'), var_order.get_created_via())).to_bool()
}

fn Class_Automattic_WooCommerce_Internal_Orders_PointOfSaleOrderUtil.is_order_paid_at_pos(mut var_order Class_WC_Abstract_Order) bool {
	if rt.is_true(Class_Automattic_WooCommerce_Internal_Orders_PointOfSaleOrderUtil.is_pos_order(mut var_order)) {
		return true
	}
	if rt.is_true(rt.identical(rt.new_string('mobile_pos'), var_order.get_meta(rt.new_string('_wcpay_ipp_channel')))) {
		return true
	}
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return true
	}
	return false
}

fn create_automattic_woocommerce_internal_orders_pointofsaleorderutil() &Class_Automattic_WooCommerce_Internal_Orders_PointOfSaleOrderUtil {
	mut obj := &Class_Automattic_WooCommerce_Internal_Orders_PointOfSaleOrderUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_Orders_PointOfSaleOrderUtil) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'is_pos_order' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Abstract_Order](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_bool(Class_Automattic_WooCommerce_Internal_Orders_PointOfSaleOrderUtil.is_pos_order(mut dispatch_arg_0))
		}
		'is_order_paid_at_pos' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Abstract_Order](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_bool(Class_Automattic_WooCommerce_Internal_Orders_PointOfSaleOrderUtil.is_order_paid_at_pos(mut dispatch_arg_0))
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Orders_PointOfSaleOrderUtil) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Orders_PointOfSaleOrderUtil) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_internal_orders_pointofsaleorderutil_php() {
	// unsupported statement: Stmt_Declare
}
