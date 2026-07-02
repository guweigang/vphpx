import rt

struct Class_Automattic_WooCommerce_Internal_Caches_OrdersVersionStringInvalidator {
	rt.PhpObjectBase
pub mut:
	pre_save_customer_ids rt.PhpVal = rt.new_array()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Caches_OrdersVersionStringInvalidator) init() {
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('yes'), rt.call_function('get_option', [
		rt.new_string('woocommerce_feature_rest_api_caching_enabled'),
	])))))
	{
		return
	}
	if rt.is_true(rt.identical(rt.new_string('yes'), rt.call_function('get_option', [
		rt.new_string('woocommerce_rest_api_enable_backend_caching'),
		rt.new_string('no'),
	])))
	{
		this.register_hooks()
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Caches_OrdersVersionStringInvalidator) register_hooks() {
	rt.call_function('add_action', [
		rt.new_string('woocommerce_before_order_object_save'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Caches_OrdersVersionStringInvalidator',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'handle_before_order_save' },
		]),
		rt.new_int(10),
		rt.new_int(1),
	])
	rt.call_function('add_action', [rt.new_string('woocommerce_new_order'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Caches_OrdersVersionStringInvalidator',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'handle_woocommerce_new_order' },
		]),
		rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_action', [rt.new_string('woocommerce_update_order'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Caches_OrdersVersionStringInvalidator',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'handle_woocommerce_update_order' },
		]),
		rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_action', [rt.new_string('woocommerce_before_delete_order'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Caches_OrdersVersionStringInvalidator',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'handle_woocommerce_before_delete_order' },
		]),
		rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_action', [rt.new_string('woocommerce_trash_order'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Caches_OrdersVersionStringInvalidator',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'handle_woocommerce_trash_order' },
		]),
		rt.new_int(10), rt.new_int(1)])
	rt.call_function('add_action', [rt.new_string('woocommerce_untrash_order'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Caches_OrdersVersionStringInvalidator',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'handle_woocommerce_untrash_order' },
		]),
		rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_action', [rt.new_string('woocommerce_order_status_changed'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Caches_OrdersVersionStringInvalidator',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'handle_woocommerce_order_status_changed' },
		]),
		rt.new_int(10), rt.new_int(4)])
	rt.call_function('add_action', [rt.new_string('woocommerce_order_refunded'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Caches_OrdersVersionStringInvalidator',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'handle_woocommerce_order_refunded' },
		]),
		rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_action', [rt.new_string('woocommerce_refund_deleted'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Caches_OrdersVersionStringInvalidator',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'handle_woocommerce_refund_deleted' },
		]),
		rt.new_int(10), rt.new_int(2)])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Caches_OrdersVersionStringInvalidator) handle_before_order_save(var_order rt.PhpVal) {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_order, 'Automattic_WooCommerce_Internal_Caches_WC_Order'))))))
		|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('shop_order'), rt.call_method(var_order, 'get_type', []rt.PhpVal{}))))) {
		return
	}
	mut var_order_id := rt.call_method(var_order, 'get_id', []rt.PhpVal{})
	if rt.is_true(rt.greater(var_order_id, rt.new_int(0))) {
		this.pre_save_customer_ids.array_set(var_order_id, rt.new_int((rt.call_method(var_order,
			'get_data', []rt.PhpVal{}).array_get(rt.new_string('customer_id'))).to_i64()))
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Caches_OrdersVersionStringInvalidator) handle_woocommerce_new_order(var_order_id rt.PhpVal, var_order rt.PhpVal) {
	mut var_order_id_mutated := var_order_id
	this.invalidate(rt.new_int(var_order_id_mutated.to_i64()))
	this.invalidate_orders_list()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Caches_OrdersVersionStringInvalidator) handle_woocommerce_update_order(var_order_id rt.PhpVal, var_order rt.PhpVal) {
	mut var_order_id_mutated := var_order_id
	var_order_id_mutated = rt.new_int(var_order_id_mutated.to_i64())
	this.invalidate(var_order_id_mutated.to_i64())
	if this.did_customer_change(var_order_id_mutated.to_i64(), var_order.clone()) {
		this.invalidate_orders_list()
	}
	this.pre_save_customer_ids.array_unset(var_order_id_mutated)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Caches_OrdersVersionStringInvalidator) did_customer_change(order_id i64, var_order rt.PhpVal) bool {
	mut order_id_mutated := order_id
	if !(this.pre_save_customer_ids.array_isset(rt.new_int(order_id_mutated))) {
		return false
	}
	mut var_old_customer_id := this.pre_save_customer_ids.array_get(rt.new_int(order_id_mutated))
	mut var_new_customer_id := rt.new_int(if rt.is_true(rt.new_bool(rt.instance_of(var_order,
		'Automattic_WooCommerce_Internal_Caches_WC_Order')))
	{
		rt.new_int((rt.call_method(var_order, 'get_customer_id', []rt.PhpVal{})).to_i64())
	} else {
		0
	})
	return rt.new_bool(!rt.is_true(rt.identical(var_old_customer_id, var_new_customer_id)))
}

fn (mut this Class_Automattic_WooCommerce_Internal_Caches_OrdersVersionStringInvalidator) handle_woocommerce_before_delete_order(var_order_id rt.PhpVal, var_order rt.PhpVal) {
	mut var_order_id_mutated := var_order_id
	this.invalidate(rt.new_int(var_order_id_mutated.to_i64()))
	this.invalidate_orders_list()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Caches_OrdersVersionStringInvalidator) handle_woocommerce_trash_order(var_order_id rt.PhpVal) {
	mut var_order_id_mutated := var_order_id
	this.invalidate(rt.new_int(var_order_id_mutated.to_i64()))
	this.invalidate_orders_list()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Caches_OrdersVersionStringInvalidator) handle_woocommerce_untrash_order(var_order_id rt.PhpVal, var_previous_status rt.PhpVal) {
	mut var_order_id_mutated := var_order_id
	this.invalidate(rt.new_int(var_order_id_mutated.to_i64()))
	this.invalidate_orders_list()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Caches_OrdersVersionStringInvalidator) handle_woocommerce_order_status_changed(var_order_id rt.PhpVal, var_from_status rt.PhpVal, var_to_status rt.PhpVal, var_order rt.PhpVal) {
	mut var_order_id_mutated := var_order_id
	this.invalidate(rt.new_int(var_order_id_mutated.to_i64()))
	this.invalidate_orders_list()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Caches_OrdersVersionStringInvalidator) handle_woocommerce_order_refunded(var_order_id rt.PhpVal, var_refund_id rt.PhpVal) {
	mut var_order_id_mutated := var_order_id
	mut var_refund_id_mutated := var_refund_id
	var_order_id_mutated = rt.new_int(var_order_id_mutated.to_i64())
	var_refund_id_mutated = rt.new_int(var_refund_id_mutated.to_i64())
	this.invalidate(var_order_id_mutated.to_i64())
	this.invalidate_refund(var_refund_id_mutated.to_i64())
	this.invalidate_order_refunds_list(var_order_id_mutated.to_i64())
	this.invalidate_refunds_list()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Caches_OrdersVersionStringInvalidator) handle_woocommerce_refund_deleted(var_refund_id rt.PhpVal, var_order_id rt.PhpVal) {
	mut var_refund_id_mutated := var_refund_id
	mut var_order_id_mutated := var_order_id
	var_order_id_mutated = rt.new_int(var_order_id_mutated.to_i64())
	var_refund_id_mutated = rt.new_int(var_refund_id_mutated.to_i64())
	this.invalidate(var_order_id_mutated.to_i64())
	this.invalidate_refund(var_refund_id_mutated.to_i64())
	this.invalidate_order_refunds_list(var_order_id_mutated.to_i64())
	this.invalidate_refunds_list()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Caches_OrdersVersionStringInvalidator) invalidate(order_id i64) {
	mut order_id_mutated := order_id
	rt.call_method(rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [
		Class_Automattic_WooCommerce_Internal_Caches_VersionStringGenerator.class(),
	]), 'delete_version', [rt.new_string('order_${var_order_id.to_string()}')])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Caches_OrdersVersionStringInvalidator) invalidate_refund(refund_id i64) {
	mut refund_id_mutated := refund_id
	rt.call_method(rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [
		Class_Automattic_WooCommerce_Internal_Caches_VersionStringGenerator.class(),
	]), 'delete_version', [rt.new_string('refund_${var_refund_id.to_string()}')])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Caches_OrdersVersionStringInvalidator) invalidate_orders_list() {
	rt.call_method(rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [
		Class_Automattic_WooCommerce_Internal_Caches_VersionStringGenerator.class(),
	]), 'delete_version', [rt.new_string('list_orders')])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Caches_OrdersVersionStringInvalidator) invalidate_refunds_list() {
	rt.call_method(rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [
		Class_Automattic_WooCommerce_Internal_Caches_VersionStringGenerator.class(),
	]), 'delete_version', [rt.new_string('list_refunds')])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Caches_OrdersVersionStringInvalidator) invalidate_order_refunds_list(order_id i64) {
	mut order_id_mutated := order_id
	if order_id_mutated > 0 {
		rt.call_method(rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [
			Class_Automattic_WooCommerce_Internal_Caches_VersionStringGenerator.class(),
		]), 'delete_version', [
			rt.new_string('list_order_refunds_${var_order_id.to_string()}'),
		])
	}
}

fn create_automattic_woocommerce_internal_caches_ordersversionstringinvalidator(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Caches_OrdersVersionStringInvalidator {
	mut obj := &Class_Automattic_WooCommerce_Internal_Caches_OrdersVersionStringInvalidator{
		PhpObjectBase:         rt.PhpObjectBase{}
		pre_save_customer_ids: rt.new_array()
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_Caches_OrdersVersionStringInvalidator) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'init' {
			this.init()
			return rt.new_null()
		}
		'register_hooks' {
			this.register_hooks()
			return rt.new_null()
		}
		'handle_before_order_save' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.handle_before_order_save(dispatch_arg_0)
			return rt.new_null()
		}
		'handle_woocommerce_new_order' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.handle_woocommerce_new_order(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'handle_woocommerce_update_order' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.handle_woocommerce_update_order(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'did_customer_change' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(this.did_customer_change(dispatch_arg_0, dispatch_arg_1))
		}
		'handle_woocommerce_before_delete_order' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.handle_woocommerce_before_delete_order(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'handle_woocommerce_trash_order' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.handle_woocommerce_trash_order(dispatch_arg_0)
			return rt.new_null()
		}
		'handle_woocommerce_untrash_order' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.handle_woocommerce_untrash_order(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'handle_woocommerce_order_status_changed' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			this.handle_woocommerce_order_status_changed(dispatch_arg_0, dispatch_arg_1,
				dispatch_arg_2, dispatch_arg_3)
			return rt.new_null()
		}
		'handle_woocommerce_order_refunded' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.handle_woocommerce_order_refunded(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'handle_woocommerce_refund_deleted' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.handle_woocommerce_refund_deleted(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'invalidate' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			this.invalidate(dispatch_arg_0)
			return rt.new_null()
		}
		'invalidate_refund' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			this.invalidate_refund(dispatch_arg_0)
			return rt.new_null()
		}
		'invalidate_orders_list' {
			this.invalidate_orders_list()
			return rt.new_null()
		}
		'invalidate_refunds_list' {
			this.invalidate_refunds_list()
			return rt.new_null()
		}
		'invalidate_order_refunds_list' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			this.invalidate_order_refunds_list(dispatch_arg_0)
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Caches_OrdersVersionStringInvalidator) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'pre_save_customer_ids' { return this.pre_save_customer_ids }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Caches_OrdersVersionStringInvalidator) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'pre_save_customer_ids' {
			this.pre_save_customer_ids = val
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
}
