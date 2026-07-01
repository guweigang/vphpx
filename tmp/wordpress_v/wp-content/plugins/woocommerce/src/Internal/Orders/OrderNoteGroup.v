import rt

pub fn Class_Automattic_WooCommerce_Internal_Orders_OrderNoteGroup.error() string {
	return 'error'
}

pub fn Class_Automattic_WooCommerce_Internal_Orders_OrderNoteGroup.email_notification() string {
	return 'email_notification'
}

pub fn Class_Automattic_WooCommerce_Internal_Orders_OrderNoteGroup.product_stock() string {
	return 'product_stock'
}

pub fn Class_Automattic_WooCommerce_Internal_Orders_OrderNoteGroup.payment() string {
	return 'payment'
}

pub fn Class_Automattic_WooCommerce_Internal_Orders_OrderNoteGroup.order_update() string {
	return 'order_update'
}

pub fn Class_Automattic_WooCommerce_Internal_Orders_OrderNoteGroup.fulfillment() string {
	return 'fulfillment'
}

struct Class_Automattic_WooCommerce_Internal_Orders_OrderNoteGroup {
	rt.PhpObjectBase
}

fn Class_Automattic_WooCommerce_Internal_Orders_OrderNoteGroup.get_default_group_title(group string) string {
	mut switch_val_1 := rt.new_string(group)
	if rt.is_true(rt.equal(switch_val_1,
		Class_Automattic_WooCommerce_Internal_Orders_Automattic_WooCommerce_Internal_Orders_OrderNoteGroup.product_stock()))
	{
		return (rt.call_function('__', [rt.new_string('Product stock'),
			rt.new_string('woocommerce')])).str()
	} else if rt.is_true(rt.equal(switch_val_1,
		Class_Automattic_WooCommerce_Internal_Orders_Automattic_WooCommerce_Internal_Orders_OrderNoteGroup.payment()))
	{
		return (rt.call_function('__', [rt.new_string('Payment'),
			rt.new_string('woocommerce')])).str()
	} else if rt.is_true(rt.equal(switch_val_1,
		Class_Automattic_WooCommerce_Internal_Orders_Automattic_WooCommerce_Internal_Orders_OrderNoteGroup.email_notification()))
	{
		return (rt.call_function('__', [rt.new_string('Email notification'),
			rt.new_string('woocommerce')])).str()
	} else if rt.is_true(rt.equal(switch_val_1,
		Class_Automattic_WooCommerce_Internal_Orders_Automattic_WooCommerce_Internal_Orders_OrderNoteGroup.error()))
	{
		return (rt.call_function('__', [rt.new_string('Error'),
			rt.new_string('woocommerce')])).str()
	} else if rt.is_true(rt.equal(switch_val_1,
		Class_Automattic_WooCommerce_Internal_Orders_Automattic_WooCommerce_Internal_Orders_OrderNoteGroup.fulfillment()))
	{
		return (rt.call_function('__', [rt.new_string('Fulfillment'),
			rt.new_string('woocommerce')])).str()
	} else {
		return (rt.call_function('__', [rt.new_string('Order updated'),
			rt.new_string('woocommerce')])).str()
	}
	return ''
}

fn create_automattic_woocommerce_internal_orders_ordernotegroup() &Class_Automattic_WooCommerce_Internal_Orders_OrderNoteGroup {
	mut obj := &Class_Automattic_WooCommerce_Internal_Orders_OrderNoteGroup{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_Orders_OrderNoteGroup) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_default_group_title' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(Class_Automattic_WooCommerce_Internal_Orders_OrderNoteGroup.get_default_group_title(dispatch_arg_0))
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Orders_OrderNoteGroup) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Orders_OrderNoteGroup) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_content_plugins_woocommerce_src_internal_orders_ordernotegroup_php() {
	// unsupported statement: Stmt_Declare
}
