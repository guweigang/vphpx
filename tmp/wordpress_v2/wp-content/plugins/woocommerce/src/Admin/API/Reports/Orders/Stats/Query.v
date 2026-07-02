import rt

struct Class_Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_Query {
	rt.PhpObjectBase
pub mut:
	name rt.PhpVal = rt.new_string('orders-stats')
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_Query) get_default_query_vars() rt.PhpVal {
	return rt.create_array([
		rt.ArrayItem{ key: 'fields', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'net_revenue' },
			rt.ArrayItem{ key: none, val: 'avg_order_value' },
			rt.ArrayItem{ key: none, val: 'orders_count' },
			rt.ArrayItem{ key: none, val: 'avg_items_per_order' },
			rt.ArrayItem{ key: none, val: 'num_items_sold' },
			rt.ArrayItem{ key: none, val: 'coupons' },
			rt.ArrayItem{ key: none, val: 'coupons_count' },
			rt.ArrayItem{ key: none, val: 'total_customers' },
		]) },
	])
}

struct Class_Automattic_WooCommerce_Admin_API_Reports_GenericQuery {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_api_reports_orders_stats_query(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_Query {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_Query{
		PhpObjectBase: rt.PhpObjectBase{}
		name:          rt.new_string('orders-stats')
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_reports_genericquery(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_API_Reports_GenericQuery {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_GenericQuery{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_Query) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_default_query_vars' {
			return this.get_default_query_vars()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_Query) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'name' { return this.name }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_Query) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'name' {
			this.name = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_GenericQuery) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_API_Reports_GenericQuery) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_GenericQuery) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}
