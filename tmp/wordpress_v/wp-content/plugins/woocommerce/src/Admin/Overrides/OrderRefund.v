import rt

struct Class_Automattic_WooCommerce_Admin_Overrides_OrderRefund {
	rt.PhpObjectBase
pub mut:
		customer_id rt.PhpVal = rt.new_null()
}

fn Class_Automattic_WooCommerce_Admin_Overrides_OrderRefund.add_filters()  {
	rt.call_function('add_filter', [rt.new_string('woocommerce_order_class'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'order_class_name' }]), rt.new_int(10), rt.new_int(3)])
}

fn Class_Automattic_WooCommerce_Admin_Overrides_OrderRefund.order_class_name(var_classname rt.PhpVal, var_order_type rt.PhpVal, var_order_id rt.PhpVal) string {
	if rt.is_true(rt.identical(rt.new_string('WC_Order_Refund'), var_classname)) {
		return '\\Automattic\\WooCommerce\\Admin\\Overrides\\OrderRefund'
	} else {
		return (var_classname).str()
	}
	return ''
}

fn (mut this Class_Automattic_WooCommerce_Admin_Overrides_OrderRefund) get_report_customer_id() rt.PhpVal {
	if rt.is_true(rt.new_bool(this.customer_id.is_null())) {
		mut var_parent_order := rt.call_function('wc_get_order', [this.get_parent_id()])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_parent_order)))) {
			this.customer_id = rt.new_bool(false)
		}
		this.customer_id = fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore{}; return temp.get_or_create_customer_from_order(arg_0) }(var_parent_order.dup())
	}
	return this.customer_id
}

fn (mut this Class_Automattic_WooCommerce_Admin_Overrides_OrderRefund) is_returning_customer() rt.PhpVal {
	return rt.new_null()
}

struct Class_Automattic_WooCommerce_Admin_Overrides_WC_Order_Refund {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_overrides_orderrefund() &Class_Automattic_WooCommerce_Admin_Overrides_OrderRefund {
	mut obj := &Class_Automattic_WooCommerce_Admin_Overrides_OrderRefund{
		PhpObjectBase: rt.PhpObjectBase{}
		customer_id: rt.new_null()
	}
	return obj
}

fn create_automattic_woocommerce_admin_overrides_wc_order_refund() &Class_Automattic_WooCommerce_Admin_Overrides_WC_Order_Refund {
	mut obj := &Class_Automattic_WooCommerce_Admin_Overrides_WC_Order_Refund{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_reports_customers_datastore() &Class_Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_Overrides_OrderRefund) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'add_filters' {
			Class_Automattic_WooCommerce_Admin_Overrides_OrderRefund.add_filters()
			return rt.new_null()
		}
		'order_class_name' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return rt.new_string(Class_Automattic_WooCommerce_Admin_Overrides_OrderRefund.order_class_name(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2))
		}
		'get_report_customer_id' {
			return this.get_report_customer_id()
		}
		'is_returning_customer' {
			return this.is_returning_customer()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_Overrides_OrderRefund) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'customer_id' { return this.customer_id }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_Overrides_OrderRefund) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'customer_id' { this.customer_id = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_WooCommerce_Admin_Overrides_WC_Order_Refund) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Overrides_WC_Order_Refund) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Overrides_WC_Order_Refund) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_admin_overrides_orderrefund_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
