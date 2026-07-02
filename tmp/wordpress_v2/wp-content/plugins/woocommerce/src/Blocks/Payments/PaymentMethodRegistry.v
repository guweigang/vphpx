import rt

struct Class_Automattic_WooCommerce_Blocks_Payments_PaymentMethodRegistry {
	rt.PhpObjectBase
pub mut:
	registry_identifier rt.PhpVal = rt.new_string('payment_method_type')
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Payments_PaymentMethodRegistry) get_all_active_registered() rt.PhpVal {
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_payment_method := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.call_method(var_payment_method, 'is_active', []rt.PhpVal{})
	}
	return rt.call_function('array_filter', [this.get_all_registered(),
		rt.new_closure(closure_1_fn)])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Payments_PaymentMethodRegistry) get_all_active_payment_method_script_dependencies() rt.PhpVal {
	mut var_script_handles := rt.new_array()
	mut var_payment_methods := this.get_all_active_registered()
	mut iter_1 := var_payment_methods.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_payment_method := item_1.val
		var_script_handles = rt.call_function('array_merge', [
			var_script_handles.clone(), if rt.is_true(rt.call_function('is_admin', []rt.PhpVal{})) {
				rt.call_method(var_payment_method, 'get_payment_method_script_handles_for_admin',
					[]rt.PhpVal{})
			} else {
				rt.call_method(var_payment_method, 'get_payment_method_script_handles',
					[]rt.PhpVal{})
			}])
	}
	return rt.call_function('array_unique', [
		rt.call_function('array_filter', [var_script_handles.clone()]),
	])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Payments_PaymentMethodRegistry) get_all_registered_script_data() rt.PhpVal {
	mut var_script_data := rt.new_array()
	mut var_payment_methods := this.get_all_active_registered()
	mut iter_2 := var_payment_methods.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_payment_method := item_2.val
		var_script_data.array_set(rt.call_method(var_payment_method, 'get_name', []rt.PhpVal{}), rt.call_method(var_payment_method,
			'get_payment_method_data', []rt.PhpVal{}))
	}
	return rt.create_array([
		rt.ArrayItem{ key: 'paymentMethodData', val: rt.call_function('array_filter', [
			var_script_data.clone(),
		]) },
	])
}

struct Class_Automattic_WooCommerce_Blocks_Integrations_IntegrationRegistry {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blocks_payments_paymentmethodregistry(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_Payments_PaymentMethodRegistry {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Payments_PaymentMethodRegistry{
		PhpObjectBase:       rt.PhpObjectBase{}
		registry_identifier: rt.new_string('payment_method_type')
	}
	return obj
}

fn create_automattic_woocommerce_blocks_integrations_integrationregistry(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_Integrations_IntegrationRegistry {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Integrations_IntegrationRegistry{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Payments_PaymentMethodRegistry) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_all_active_registered' {
			return this.get_all_active_registered()
		}
		'get_all_active_payment_method_script_dependencies' {
			return this.get_all_active_payment_method_script_dependencies()
		}
		'get_all_registered_script_data' {
			return this.get_all_registered_script_data()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Blocks_Payments_PaymentMethodRegistry) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'registry_identifier' { return this.registry_identifier }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Payments_PaymentMethodRegistry) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'registry_identifier' {
			this.registry_identifier = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Integrations_IntegrationRegistry) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_Integrations_IntegrationRegistry) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Integrations_IntegrationRegistry) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
