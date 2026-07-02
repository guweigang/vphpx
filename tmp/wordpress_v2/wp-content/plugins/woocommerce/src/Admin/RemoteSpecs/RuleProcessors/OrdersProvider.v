import rt

struct Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_OrdersProvider {
	rt.PhpObjectBase
pub mut:
	allowed_statuses rt.PhpVal = rt.new_array()
}

fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_OrdersProvider) get_order_count() rt.PhpVal {
	mut var_status_counts := rt.call_function('array_map', [
		rt.new_string('wc_orders_count'),
		this.allowed_statuses,
	])
	mut var_orders_count := rt.call_function('array_sum', [var_status_counts.clone()])
	return var_orders_count.clone()
}

fn create_automattic_woocommerce_admin_remotespecs_ruleprocessors_ordersprovider(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_OrdersProvider {
	mut obj := &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_OrdersProvider{
		PhpObjectBase:    rt.PhpObjectBase{}
		allowed_statuses: rt.new_array()
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_OrdersProvider) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_order_count' {
			return this.get_order_count()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_OrdersProvider) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'allowed_statuses' { return this.allowed_statuses }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_OrdersProvider) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'allowed_statuses' {
			this.allowed_statuses = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}
