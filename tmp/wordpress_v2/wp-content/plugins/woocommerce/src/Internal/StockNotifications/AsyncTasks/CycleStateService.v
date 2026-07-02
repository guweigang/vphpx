import rt

pub fn Class_Automattic_WooCommerce_Internal_StockNotifications_AsyncTasks_CycleStateService.state_option_prefix() string {
	return 'wc_stock_notifications_cycle_state_'
}

struct Class_Automattic_WooCommerce_Internal_StockNotifications_AsyncTasks_CycleStateService {
	rt.PhpObjectBase
pub mut:
	logger rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_AsyncTasks_CycleStateService) construct() {
	this.logger = rt.call_function('wc_get_logger', []rt.PhpVal{})
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_AsyncTasks_CycleStateService) get_or_initialize_cycle_state(product_id i64) rt.PhpVal {
	if product_id <= 0 {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Internal_StockNotifications_AsyncTasks_Exception',
			[]string{},
			create_automattic_woocommerce_internal_stocknotifications_asynctasks_exception(rt.new_string('Product ID is required.'))))
	}
	mut var_default_state := rt.create_array([
		rt.ArrayItem{ key: 'cycle_start_time', val: rt.call_function('time', []rt.PhpVal{}) },
		rt.ArrayItem{ key: 'product_ids', val: rt.create_array([
			rt.ArrayItem{ key: none, val: product_id },
		]) },
		rt.ArrayItem{ key: 'total_count', val: 0 },
		rt.ArrayItem{ key: 'skipped_count', val: 0 },
		rt.ArrayItem{ key: 'sent_count', val: 0 },
		rt.ArrayItem{ key: 'failed_count', val: 0 },
		rt.ArrayItem{ key: 'duration', val: 0 },
	])
	mut var_cycle_state := this.get_raw_cycle_state(product_id)
	if !rt.is_true(var_cycle_state) {
		return var_default_state.clone()
	}
	if rt.is_true(rt.call_function('array_diff_key', [var_default_state.clone(), var_cycle_state.clone()]))
		|| !rt.is_true(var_cycle_state.array_get(rt.new_string('cycle_start_time')))
		|| !(var_cycle_state.array_get(rt.new_string('cycle_start_time')).is_long()
		|| var_cycle_state.array_get(rt.new_string('cycle_start_time')).is_double()) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Internal_StockNotifications_AsyncTasks_Exception',
			[]string{},
			create_automattic_woocommerce_internal_stocknotifications_asynctasks_exception(rt.new_string('Invalid cycle state.'))))
	}
	var_cycle_state = rt.call_function('wp_parse_args', [var_cycle_state.clone(),
		var_default_state.clone()])
	return var_cycle_state.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_AsyncTasks_CycleStateService) get_raw_cycle_state(product_id i64) rt.PhpVal {
	mut var_cycle_state := rt.call_function('get_option', [
		rt.new_string(this.get_option_name(product_id)),
		rt.new_bool(false),
	])
	if !(var_cycle_state.clone().is_array()) {
		return rt.new_array()
	}
	return var_cycle_state.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_AsyncTasks_CycleStateService) complete_cycle(product_id i64, mut var_cycle_state Class_Automattic_WooCommerce_Internal_StockNotifications_AsyncTasks_array) {
	mut var_cycle_state_mutated := var_cycle_state
	var_cycle_state_mutated.array_set('duration', rt.sub(rt.call_function('time', []rt.PhpVal{}),
		var_cycle_state_mutated.array_get(rt.new_string('cycle_start_time'))))
	rt.call_method(this.logger, 'info', [
		rt.call_function('sprintf', [
			rt.new_string('Completed cycle for product %d. Sent: %d, Skipped: %d, Failed: %d, Duration: %d seconds. Total notifications processed: %d'),
			rt.new_int(product_id),
			var_cycle_state_mutated.array_get(rt.new_string('sent_count')),
			var_cycle_state_mutated.array_get(rt.new_string('skipped_count')),
			var_cycle_state_mutated.array_get(rt.new_string('failed_count')),
			var_cycle_state_mutated.array_get(rt.new_string('duration')),
			var_cycle_state_mutated.array_get(rt.new_string('total_count')),
		]),
		rt.create_array([
			rt.ArrayItem{ key: 'source', val: 'wc-customer-stock-notifications' },
		]),
	])
	this.save_cycle_state(product_id, mut
		rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_StockNotifications_AsyncTasks_array](rt.new_array()))
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_AsyncTasks_CycleStateService) save_cycle_state(product_id i64, mut var_cycle_state Class_Automattic_WooCommerce_Internal_StockNotifications_AsyncTasks_array) bool {
	mut var_cycle_state_mutated := var_cycle_state
	if product_id <= 0 {
		return false
	}
	mut var_current_cycle_state := this.get_raw_cycle_state(product_id)
	if rt.is_true(rt.identical(var_current_cycle_state, var_cycle_state_mutated)) {
		return false
	}
	if !rt.is_true(var_cycle_state_mutated) {
		mut var_result := rt.call_function('delete_option', [
			rt.new_string(this.get_option_name(product_id)),
		])
	} else {
		var_result = rt.call_function('update_option', [
			rt.new_string(this.get_option_name(product_id)),
			var_cycle_state_mutated,
			rt.new_bool(false),
		])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_result)))) {
		rt.call_method(this.logger, 'error', [
			rt.call_function('sprintf', [
				rt.new_string('Failed to save cycle state for product %d. Cycle state: %s'),
				rt.new_int(product_id),
				rt.call_function('wc_print_r', [var_cycle_state_mutated, rt.new_bool(true)]),
			]),
			rt.create_array([
				rt.ArrayItem{ key: 'source', val: 'wc-customer-stock-notifications' },
			]),
		])
	}
	return var_result.to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_AsyncTasks_CycleStateService) get_option_name(product_id i64) string {
	if product_id <= 0 {
		return ''
	}
	return
		(Class_Automattic_WooCommerce_Internal_StockNotifications_AsyncTasks_Automattic_WooCommerce_Internal_StockNotifications_AsyncTasks_CycleStateService.state_option_prefix()).str() +
		product_id.str()
}

struct Class_Automattic_WooCommerce_Internal_StockNotifications_AsyncTasks_Exception {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_stocknotifications_asynctasks_cyclestateservice() &Class_Automattic_WooCommerce_Internal_StockNotifications_AsyncTasks_CycleStateService {
	mut obj := &Class_Automattic_WooCommerce_Internal_StockNotifications_AsyncTasks_CycleStateService{
		PhpObjectBase: rt.PhpObjectBase{}
		logger:        rt.new_null()
	}
	obj.construct()
	return obj
}

fn create_automattic_woocommerce_internal_stocknotifications_asynctasks_exception(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_StockNotifications_AsyncTasks_Exception {
	mut obj := &Class_Automattic_WooCommerce_Internal_StockNotifications_AsyncTasks_Exception{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_AsyncTasks_CycleStateService) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'get_or_initialize_cycle_state' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			return this.get_or_initialize_cycle_state(dispatch_arg_0)
		}
		'get_raw_cycle_state' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			return this.get_raw_cycle_state(dispatch_arg_0)
		}
		'complete_cycle' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_StockNotifications_AsyncTasks_array](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			this.complete_cycle(dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'save_cycle_state' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_StockNotifications_AsyncTasks_array](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			return rt.new_bool(this.save_cycle_state(dispatch_arg_0, mut dispatch_arg_1))
		}
		'get_option_name' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			return rt.new_string(this.get_option_name(dispatch_arg_0))
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_StockNotifications_AsyncTasks_CycleStateService) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'logger' { return this.logger }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_AsyncTasks_CycleStateService) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'logger' {
			this.logger = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_AsyncTasks_Exception) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_StockNotifications_AsyncTasks_Exception) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_AsyncTasks_Exception) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
