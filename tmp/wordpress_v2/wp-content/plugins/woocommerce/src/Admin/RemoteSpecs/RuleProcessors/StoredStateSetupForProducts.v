import rt

pub fn Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_StoredStateSetupForProducts.async_run_remote_notifications_action_name() string {
	return 'woocommerce_admin/stored_state_setup_for_products/async/run_remote_notifications'
}

struct Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_StoredStateSetupForProducts {
	rt.PhpObjectBase
}

fn Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_StoredStateSetupForProducts.admin_init() {
	rt.call_function('add_action', [rt.new_string('product_page_product_importer'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'run_on_product_importer' }])])
	rt.call_function('add_action', [rt.new_string('transition_post_status'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'run_on_transition_post_status' }]),
		rt.new_int(10), rt.new_int(3)])
}

fn Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_StoredStateSetupForProducts.init() {
	rt.call_function('add_action', [
		Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_StoredStateSetupForProducts.async_run_remote_notifications_action_name(),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'run_remote_notifications' }]),
	])
}

fn Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_StoredStateSetupForProducts.run_remote_notifications() {
	mut iife_temp_0 :=
		Class_Automattic_WooCommerce_Admin_RemoteInboxNotifications_RemoteInboxNotificationsEngine{}
	mut iife_result_0 := iife_temp_0.run()
}

fn Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_StoredStateSetupForProducts.init_stored_state(var_stored_state rt.PhpVal) rt.PhpVal {
	mut var_stored_state_mutated := var_stored_state
	rt.set_property(var_stored_state_mutated, 'there_were_no_products',
		rt.new_bool(!(rt.is_true(Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_StoredStateSetupForProducts.are_there_products()))))
	rt.set_property(var_stored_state_mutated, 'there_are_now_products', rt.new_bool(!(rt.is_true(rt.get_property(var_stored_state_mutated,
		'there_were_no_products')))))
	return var_stored_state_mutated.clone()
}

fn Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_StoredStateSetupForProducts.are_there_products() rt.PhpVal {
	mut var_query := create_automattic_woocommerce_admin_remotespecs_ruleprocessors_wc_product_query(rt.create_array([
		rt.ArrayItem{ key: 'limit', val: 1 },
		rt.ArrayItem{ key: 'paginate', val: true },
		rt.ArrayItem{ key: 'return', val: 'ids' },
		rt.ArrayItem{ key: 'status', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'publish' },
		]) },
	]))
	mut var_products := var_query.get_products()
	mut var_count := rt.get_property(var_products, 'total')
	return rt.greater(var_count, rt.new_int(0))
}

fn Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_StoredStateSetupForProducts.run_on_product_importer() {
	if !(rt.get_superglobal('_REQUEST').array_isset(rt.new_string('step'))) {
		return
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('done'),
		rt.get_superglobal('_REQUEST').array_get(rt.new_string('step'))))))
	{
		return
	}
	Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_StoredStateSetupForProducts.update_stored_state_and_possibly_run_remote_notifications()
}

fn Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_StoredStateSetupForProducts.run_on_transition_post_status(var_new_status rt.PhpVal, var_old_status rt.PhpVal, var_post rt.PhpVal) {
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('product'), rt.get_property(var_post, 'post_type')))))
		|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('publish'), var_new_status)))) {
		return
	}
	Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_StoredStateSetupForProducts.update_stored_state_and_possibly_run_remote_notifications()
}

fn Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_StoredStateSetupForProducts.update_stored_state_and_possibly_run_remote_notifications() {
	mut iife_temp_1 :=
		Class_Automattic_WooCommerce_Admin_RemoteInboxNotifications_RemoteInboxNotificationsEngine{}
	mut iife_result_1 := iife_temp_1.get_stored_state()
	mut var_stored_state := iife_result_1
	if rt.is_true(rt.identical(rt.new_bool(true), rt.get_property(var_stored_state,
		'there_are_now_products')))
	{
		return
	}
	rt.set_property(var_stored_state, 'there_are_now_products', rt.new_bool(true))
	mut iife_temp_2 :=
		Class_Automattic_WooCommerce_Admin_RemoteInboxNotifications_RemoteInboxNotificationsEngine{}
	mut iife_result_2 := iife_temp_2.update_stored_state(var_stored_state.clone())
	rt.call_function('as_enqueue_async_action', [
		Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_StoredStateSetupForProducts.async_run_remote_notifications_action_name(),
	])
}

struct Class_Automattic_WooCommerce_Admin_RemoteInboxNotifications_RemoteInboxNotificationsEngine {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_WC_Product_Query {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_remotespecs_ruleprocessors_storedstatesetupforproducts(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_StoredStateSetupForProducts {
	mut obj := &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_StoredStateSetupForProducts{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_remoteinboxnotifications_remoteinboxnotificationsengine(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_RemoteInboxNotifications_RemoteInboxNotificationsEngine {
	mut obj := &Class_Automattic_WooCommerce_Admin_RemoteInboxNotifications_RemoteInboxNotificationsEngine{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_remotespecs_ruleprocessors_wc_product_query(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_WC_Product_Query {
	mut obj := &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_WC_Product_Query{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_StoredStateSetupForProducts) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'admin_init' {
			Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_StoredStateSetupForProducts.admin_init()
			return rt.new_null()
		}
		'init' {
			Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_StoredStateSetupForProducts.init()
			return rt.new_null()
		}
		'run_remote_notifications' {
			Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_StoredStateSetupForProducts.run_remote_notifications()
			return rt.new_null()
		}
		'init_stored_state' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_StoredStateSetupForProducts.init_stored_state(dispatch_arg_0)
		}
		'are_there_products' {
			return Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_StoredStateSetupForProducts.are_there_products()
		}
		'run_on_product_importer' {
			Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_StoredStateSetupForProducts.run_on_product_importer()
			return rt.new_null()
		}
		'run_on_transition_post_status' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_StoredStateSetupForProducts.run_on_transition_post_status(dispatch_arg_0,
				dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'update_stored_state_and_possibly_run_remote_notifications' {
			Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_StoredStateSetupForProducts.update_stored_state_and_possibly_run_remote_notifications()
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_StoredStateSetupForProducts) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_StoredStateSetupForProducts) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Admin_RemoteInboxNotifications_RemoteInboxNotificationsEngine) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_RemoteInboxNotifications_RemoteInboxNotificationsEngine) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_RemoteInboxNotifications_RemoteInboxNotificationsEngine) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_WC_Product_Query) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_WC_Product_Query) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_WC_Product_Query) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}
