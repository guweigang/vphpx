import rt

struct Class_Automattic_WooCommerce_Admin_Overrides_Order {
	rt.PhpObjectBase
pub mut:
	refunded_line_items rt.PhpVal = rt.new_null()
	customer_id         rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Admin_Overrides_Order) get_data_without_line_items() rt.PhpVal {
	return rt.call_function('array_merge', [
		rt.create_array([rt.ArrayItem{ key: 'id', val: this.get_id() }]),
		rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_Overrides_Order', [
			'Automattic_WooCommerce_Admin_Overrides_WC_Order'], &this), 'data'),
		rt.create_array([rt.ArrayItem{ key: 'number', val: this.get_order_number() },
			rt.ArrayItem{ key: 'meta_data', val: this.get_meta_data() }]),
	])
}

fn (mut this Class_Automattic_WooCommerce_Admin_Overrides_Order) get_line_item_data(var_type rt.PhpVal) bool {
	mut var_type_to_items := rt.create_array([
		rt.ArrayItem{
			key: 'line_items'
			val: Class_Automattic_WooCommerce_Enums_OrderItemType.line_item()
		},
		rt.ArrayItem{ key: 'tax_lines', val: Class_Automattic_WooCommerce_Enums_OrderItemType.tax() },
		rt.ArrayItem{
			key: 'shipping_lines'
			val: Class_Automattic_WooCommerce_Enums_OrderItemType.shipping()
		},
		rt.ArrayItem{ key: 'fee_lines', val: Class_Automattic_WooCommerce_Enums_OrderItemType.fee() },
		rt.ArrayItem{
			key: 'coupon_lines'
			val: Class_Automattic_WooCommerce_Enums_OrderItemType.coupon()
		},
	])
	if var_type_to_items.array_isset(var_type) {
		return (this.get_items(var_type_to_items.array_get(var_type))).to_bool()
	}
	return false
}

fn Class_Automattic_WooCommerce_Admin_Overrides_Order.add_filters() {
	rt.call_function('add_filter', [rt.new_string('woocommerce_order_class'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'order_class_name' }]),
		rt.new_int(10), rt.new_int(3)])
}

fn Class_Automattic_WooCommerce_Admin_Overrides_Order.order_class_name(var_classname rt.PhpVal, var_order_type rt.PhpVal, var_order_id rt.PhpVal) string {
	if rt.is_true(rt.identical(rt.new_string('WC_Order'), var_classname)) {
		return '\\Automattic\\WooCommerce\\Admin\\Overrides\\Order'
	} else {
		return var_classname.str()
	}
	return ''
}

fn (mut this Class_Automattic_WooCommerce_Admin_Overrides_Order) get_report_customer_id() rt.PhpVal {
	if rt.is_true(rt.new_bool(this.customer_id.is_null())) {
		mut iife_temp_0 := Class_Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore{}
		mut iife_result_0 := iife_temp_0.get_or_create_customer_from_order(rt.new_object('Automattic_WooCommerce_Admin_Overrides_Order',
			[]string{}, this))
		this.customer_id = iife_result_0
	}
	return this.customer_id
}

fn (mut this Class_Automattic_WooCommerce_Admin_Overrides_Order) is_returning_customer() rt.PhpVal {
	mut iife_temp_1 := Class_Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_DataStore{}
	mut iife_result_1 := iife_temp_1.is_returning_customer(rt.new_object('Automattic_WooCommerce_Admin_Overrides_Order',
		[]string{}, this), this.get_report_customer_id())
	return iife_result_1
}

fn (mut this Class_Automattic_WooCommerce_Admin_Overrides_Order) get_customer_first_name() rt.PhpVal {
	if rt.is_true(this.get_user_id()) {
		return rt.call_function('get_user_meta', [this.get_user_id(),
			rt.new_string('first_name'), rt.new_bool(true)])
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''),
		this.get_billing_first_name(rt.new_string('edit'))))))
	{
		return this.get_billing_first_name(rt.new_string('edit'))
	} else {
		return this.get_shipping_first_name(rt.new_string('edit'))
	}
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Admin_Overrides_Order) get_customer_last_name() rt.PhpVal {
	if rt.is_true(this.get_user_id()) {
		return rt.call_function('get_user_meta', [this.get_user_id(),
			rt.new_string('last_name'), rt.new_bool(true)])
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''),
		this.get_billing_last_name(rt.new_string('edit'))))))
	{
		return this.get_billing_last_name(rt.new_string('edit'))
	} else {
		return this.get_shipping_last_name(rt.new_string('edit'))
	}
	return rt.new_null()
}

struct Class_Automattic_WooCommerce_Admin_Overrides_WC_Order {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_DataStore {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_overrides_order(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Overrides_Order {
	mut obj := &Class_Automattic_WooCommerce_Admin_Overrides_Order{
		PhpObjectBase:       rt.PhpObjectBase{}
		refunded_line_items: rt.new_null()
		customer_id:         rt.new_null()
	}
	return obj
}

fn create_automattic_woocommerce_admin_overrides_wc_order(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Overrides_WC_Order {
	mut obj := &Class_Automattic_WooCommerce_Admin_Overrides_WC_Order{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_reports_customers_datastore(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_reports_orders_stats_datastore(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_DataStore {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_DataStore{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_Overrides_Order) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_data_without_line_items' {
			return this.get_data_without_line_items()
		}
		'get_line_item_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.get_line_item_data(dispatch_arg_0))
		}
		'add_filters' {
			Class_Automattic_WooCommerce_Admin_Overrides_Order.add_filters()
			return rt.new_null()
		}
		'order_class_name' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return rt.new_string(Class_Automattic_WooCommerce_Admin_Overrides_Order.order_class_name(dispatch_arg_0,
				dispatch_arg_1, dispatch_arg_2))
		}
		'get_report_customer_id' {
			return this.get_report_customer_id()
		}
		'is_returning_customer' {
			return this.is_returning_customer()
		}
		'get_customer_first_name' {
			return this.get_customer_first_name()
		}
		'get_customer_last_name' {
			return this.get_customer_last_name()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_Overrides_Order) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'refunded_line_items' { return this.refunded_line_items }
		'customer_id' { return this.customer_id }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_Overrides_Order) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'refunded_line_items' {
			this.refunded_line_items = val
			return true
		}
		'customer_id' {
			this.customer_id = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_Overrides_WC_Order) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Overrides_WC_Order) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Overrides_WC_Order) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_DataStore) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_DataStore) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_DataStore) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}
