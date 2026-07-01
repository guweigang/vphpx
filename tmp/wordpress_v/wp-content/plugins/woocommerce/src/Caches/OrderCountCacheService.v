import rt

pub fn Class_Automattic_WooCommerce_Caches_OrderCountCacheService.background_event_hook() string {
	return 'woocommerce_refresh_order_count_cache'
}

struct Class_Automattic_WooCommerce_Caches_OrderCountCacheService {
	rt.PhpObjectBase
pub mut:
	order_count_cache      rt.PhpVal = rt.new_null()
	order_statuses         rt.PhpVal = rt.new_array()
	initial_order_statuses rt.PhpVal = rt.new_array()
}

fn (mut this Class_Automattic_WooCommerce_Caches_OrderCountCacheService) init() {
	this.order_count_cache = create_automattic_woocommerce_caches_ordercountcache()
	rt.call_function('add_action', [rt.new_string('woocommerce_new_order'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Caches_OrderCountCacheService',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'update_on_new_order' },
		]),
		rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_action', [rt.new_string('woocommerce_order_status_changed'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Caches_OrderCountCacheService',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'update_on_order_status_changed' },
		]),
		rt.new_int(10), rt.new_int(4)])
	rt.call_function('add_action', [rt.new_string('woocommerce_before_trash_order'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Caches_OrderCountCacheService',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'update_on_order_trashed' },
		]),
		rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_action', [rt.new_string('woocommerce_before_delete_order'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Caches_OrderCountCacheService',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'update_on_order_deleted' },
		]),
		rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_action', [
		Class_Automattic_WooCommerce_Caches_Automattic_WooCommerce_Caches_OrderCountCacheService.background_event_hook(),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Caches_OrderCountCacheService',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'prime_cache_if_cold' },
		]),
	])
	rt.call_function('add_action', [
		rt.new_string('action_scheduler_ensure_recurring_actions'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Caches_OrderCountCacheService',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'schedule_background_actions' },
		]),
	])
	if rt.is_true(rt.call_function('defined', [rt.new_string('WC_PLUGIN_BASENAME')])) {
		rt.call_function('add_action', [
			'deactivate_' + (rt.get_constant('WC_PLUGIN_BASENAME')).str(),
			rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Caches_OrderCountCacheService',
					[]string{}, &this) },
				rt.ArrayItem{ key: none, val: 'unschedule_background_actions' },
			]),
		])
	}
}

fn (mut this Class_Automattic_WooCommerce_Caches_OrderCountCacheService) refresh_cache(var_order_type rt.PhpVal) {
	mut var_order_type_mutated := var_order_type
	rt.call_method(this.order_count_cache, 'flush', [var_order_type_mutated.dup()])
	fn (arg_0 rt.PhpVal) rt.PhpVal {
		mut temp := Class_Automattic_WooCommerce_Utilities_OrderUtil{}
		return temp.get_count_for_type(arg_0)
	}(var_order_type_mutated.dup())
}

fn (mut this Class_Automattic_WooCommerce_Caches_OrderCountCacheService) prime_cache_if_cold(var_order_type rt.PhpVal) {
	mut var_order_type_mutated := var_order_type
	if rt.is_true(rt.new_bool(
		rt.is_true(rt.call_function('wp_using_ext_object_cache', []rt.PhpVal{}))
		&& rt.is_true(rt.identical(rt.new_null(), rt.call_method(this.order_count_cache, 'get', [var_order_type_mutated.dup()])))))
	{
		rt.call_method(this.order_count_cache, 'flush', [var_order_type_mutated.dup()])
		fn (arg_0 rt.PhpVal) rt.PhpVal {
			mut temp := Class_Automattic_WooCommerce_Utilities_OrderUtil{}
			return temp.get_count_for_type(arg_0)
		}(var_order_type_mutated.dup())
	}
}

fn (mut this Class_Automattic_WooCommerce_Caches_OrderCountCacheService) schedule_background_actions() {
	mut var_order_types := rt.call_function('wc_get_order_types', [
		rt.new_string('order-count'),
	])
	mut var_frequency := rt.mul(rt.get_constant('HOUR_IN_SECONDS'), rt.new_int(12))
	mut var_timestamp := rt.add(rt.call_function('time', []rt.PhpVal{}), var_frequency)
	{
		mut iter_1 := var_order_types.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_order_type := item_1.val
			rt.call_function('as_schedule_recurring_action', [
				var_timestamp.dup(), var_frequency.dup(),
				Class_Automattic_WooCommerce_Caches_Automattic_WooCommerce_Caches_OrderCountCacheService.background_event_hook(),
				rt.create_array([rt.ArrayItem{ key: none, val: var_order_type }]),
				rt.new_string('count'), rt.new_bool(true)])
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Caches_OrderCountCacheService) unschedule_background_actions() {
	rt.call_method(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'queue', []rt.PhpVal{}),
		'cancel_all', [
		Class_Automattic_WooCommerce_Caches_Automattic_WooCommerce_Caches_OrderCountCacheService.background_event_hook(),
	])
}

fn (mut this Class_Automattic_WooCommerce_Caches_OrderCountCacheService) update_on_new_order(var_order_id rt.PhpVal, var_order rt.PhpVal) {
	mut var_order_type := rt.call_method(var_order, 'get_type', []rt.PhpVal{})
	mut var_order_status := rt.call_method(var_order, 'get_status', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(this.order_count_cache, 'is_cached', [
		var_order_type.dup(),
		this.get_prefixed_status(var_order_status.dup()),
	])))))
	{
		return rt.new_null()
	}
	if this.initial_order_statuses.array_isset(var_order_id) {
		rt.call_method(this.order_count_cache, 'increment', [
			var_order_type.dup(),
			this.get_prefixed_status(this.initial_order_statuses.array_get(var_order_id))])
	}
	if rt.is_true(rt.new_bool(this.order_statuses.array_isset(var_order_id)
		&& rt.is_true(rt.identical(this.order_statuses.array_get(var_order_id), var_order_status))))
	{
		return rt.new_null()
	}
	this.order_statuses.array_set(var_order_id, var_order_status.dup())
	rt.call_method(this.order_count_cache, 'increment', [var_order_type.dup(),
		this.get_prefixed_status(var_order_status.dup())])
}

fn (mut this Class_Automattic_WooCommerce_Caches_OrderCountCacheService) update_on_order_trashed(var_order_id rt.PhpVal, var_order rt.PhpVal) {
	mut var_order_type := rt.call_method(var_order, 'get_type', []rt.PhpVal{})
	mut var_order_status := rt.call_method(var_order, 'get_status', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(
		rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(this.order_count_cache, 'is_cached', [var_order_type.dup(), this.get_prefixed_status(var_order_status.dup())])))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(this.order_count_cache, 'is_cached', [var_order_type.dup(), Class_Automattic_WooCommerce_Enums_OrderStatus.trash()])))))))
	{
		return rt.new_null()
	}
	rt.call_method(this.order_count_cache, 'decrement', [var_order_type.dup(),
		this.get_prefixed_status(var_order_status.dup())])
	rt.call_method(this.order_count_cache, 'increment', [var_order_type.dup(),
		Class_Automattic_WooCommerce_Enums_OrderStatus.trash()])
}

fn (mut this Class_Automattic_WooCommerce_Caches_OrderCountCacheService) update_on_order_deleted(var_order_id rt.PhpVal, var_order rt.PhpVal) {
	mut var_order_type := rt.call_method(var_order, 'get_type', []rt.PhpVal{})
	mut var_order_status := rt.call_method(var_order, 'get_status', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(this.order_count_cache, 'is_cached', [
		var_order_type.dup(),
		this.get_prefixed_status(var_order_status.dup()),
	])))))
	{
		return rt.new_null()
	}
	rt.call_method(this.order_count_cache, 'decrement', [var_order_type.dup(),
		this.get_prefixed_status(var_order_status.dup())])
}

fn (mut this Class_Automattic_WooCommerce_Caches_OrderCountCacheService) update_on_order_status_changed(var_order_id rt.PhpVal, var_previous_status rt.PhpVal, var_next_status rt.PhpVal, var_order rt.PhpVal) {
	mut var_order_type := rt.call_method(var_order, 'get_type', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(
		rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(this.order_count_cache, 'is_cached', [var_order_type.dup(), this.get_prefixed_status(var_next_status.dup())])))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(this.order_count_cache, 'is_cached', [var_order_type.dup(), this.get_prefixed_status(var_previous_status.dup())])))))))
	{
		return rt.new_null()
	}
	if rt.is_true(rt.new_bool(this.order_statuses.array_isset(var_order_id)
		&& rt.is_true(rt.identical(this.order_statuses.array_get(var_order_id), var_next_status))))
	{
		return rt.new_null()
	}
	this.order_statuses.array_set(var_order_id, var_next_status.dup())
	mut var_was_decremented := rt.call_method(this.order_count_cache, 'decrement', [
		var_order_type.dup(),
		this.get_prefixed_status(var_previous_status.dup()),
	])
	rt.call_method(this.order_count_cache, 'increment', [var_order_type.dup(),
		this.get_prefixed_status(var_next_status.dup())])
	if rt.is_true(rt.new_bool(!(this.initial_order_statuses.array_isset(var_order_id))
		&& rt.is_true(var_was_decremented)))
	{
		this.initial_order_statuses.array_set(var_order_id, var_previous_status.dup())
	}
}

fn (mut this Class_Automattic_WooCommerce_Caches_OrderCountCacheService) get_prefixed_status(var_status rt.PhpVal) rt.PhpVal {
	mut var_status_mutated := var_status
	var_status_mutated = rt.new_string('wc-' + var_status_mutated.str())
	mut var_special_statuses := rt.create_array([
		rt.ArrayItem{
			key: 'wc-' + (Class_Automattic_WooCommerce_Enums_OrderStatus.auto_draft()).str()
			val: Class_Automattic_WooCommerce_Enums_OrderStatus.auto_draft()
		},
		rt.ArrayItem{
			key: 'wc-' + (Class_Automattic_WooCommerce_Enums_OrderStatus.trash()).str()
			val: Class_Automattic_WooCommerce_Enums_OrderStatus.trash()
		},
	])
	if var_special_statuses.array_isset(var_status_mutated) {
		return var_special_statuses.array_get(var_status_mutated)
	}
	return var_status_mutated.dup()
}

struct Class_Automattic_WooCommerce_Caches_OrderCountCache {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Utilities_OrderUtil {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_caches_ordercountcacheservice() &Class_Automattic_WooCommerce_Caches_OrderCountCacheService {
	mut obj := &Class_Automattic_WooCommerce_Caches_OrderCountCacheService{
		PhpObjectBase:          rt.PhpObjectBase{}
		order_count_cache:      rt.new_null()
		order_statuses:         rt.new_array()
		initial_order_statuses: rt.new_array()
	}
	return obj
}

fn create_automattic_woocommerce_caches_ordercountcache() &Class_Automattic_WooCommerce_Caches_OrderCountCache {
	mut obj := &Class_Automattic_WooCommerce_Caches_OrderCountCache{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_utilities_orderutil() &Class_Automattic_WooCommerce_Utilities_OrderUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_OrderUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Caches_OrderCountCacheService) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'init' {
			this.init()
			return rt.new_null()
		}
		'refresh_cache' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.refresh_cache(dispatch_arg_0)
			return rt.new_null()
		}
		'prime_cache_if_cold' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.prime_cache_if_cold(dispatch_arg_0)
			return rt.new_null()
		}
		'schedule_background_actions' {
			this.schedule_background_actions()
			return rt.new_null()
		}
		'unschedule_background_actions' {
			this.unschedule_background_actions()
			return rt.new_null()
		}
		'update_on_new_order' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.update_on_new_order(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'update_on_order_trashed' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.update_on_order_trashed(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'update_on_order_deleted' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.update_on_order_deleted(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'update_on_order_status_changed' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			this.update_on_order_status_changed(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2,
				dispatch_arg_3)
			return rt.new_null()
		}
		'get_prefixed_status' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_prefixed_status(dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Caches_OrderCountCacheService) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'order_count_cache' { return this.order_count_cache }
		'order_statuses' { return this.order_statuses }
		'initial_order_statuses' { return this.initial_order_statuses }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Caches_OrderCountCacheService) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'order_count_cache' {
			this.order_count_cache = val
			return true
		}
		'order_statuses' {
			this.order_statuses = val
			return true
		}
		'initial_order_statuses' {
			this.initial_order_statuses = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Caches_OrderCountCache) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Caches_OrderCountCache) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Caches_OrderCountCache) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_OrderUtil) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Utilities_OrderUtil) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_OrderUtil) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_content_plugins_woocommerce_src_caches_ordercountcacheservice_php() {
	// unsupported statement: Stmt_Declare
}
