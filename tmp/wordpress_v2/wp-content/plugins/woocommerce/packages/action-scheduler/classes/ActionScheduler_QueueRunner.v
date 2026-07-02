import rt

pub fn Class_ActionScheduler_QueueRunner.wp_cron_hook() string {
	return 'action_scheduler_run_queue'
}
pub fn Class_ActionScheduler_QueueRunner.wp_cron_schedule() string {
	return 'every_minute'
}
struct Class_ActionScheduler_QueueRunner {
	rt.PhpObjectBase
pub mut:
		async_request rt.PhpVal = rt.new_null()
		processed_actions_count i64
}

fn init_static_actionscheduler_queuerunner() {
		rt.init_static_prop('ActionScheduler_QueueRunner', 'runner', rt.new_null())
}

fn Class_ActionScheduler_QueueRunner.instance() rt.PhpVal {
	if !rt.is_true(rt.get_static_prop('ActionScheduler_QueueRunner', 'runner')) {
		mut var_class := rt.call_function('apply_filters', [rt.new_string('action_scheduler_queue_runner_class'), rt.new_string('ActionScheduler_QueueRunner')])
		rt.set_static_prop('ActionScheduler_QueueRunner', 'runner', rt.new_object('', []string{}, rt.create_object_dynamically(var_class, []rt.PhpVal{})))
	}
	return rt.get_static_prop('ActionScheduler_QueueRunner', 'runner')
}

fn (mut this Class_ActionScheduler_QueueRunner) construct(mut var_store Class_?ActionScheduler_Store, mut var_monitor Class_?ActionScheduler_FatalErrorMonitor, mut var_cleaner Class_?ActionScheduler_QueueCleaner, mut var_async_request Class_?ActionScheduler_AsyncRequest_QueueRunner) {
	mut var_async_request_mutated := var_async_request
	this.Class_ActionScheduler_Abstract_QueueRunner.construct(rt.new_object('?ActionScheduler_Store', []string{}, var_store), rt.new_object('?ActionScheduler_FatalErrorMonitor', []string{}, var_monitor), rt.new_object('?ActionScheduler_QueueCleaner', []string{}, var_cleaner))
	if rt.is_true(rt.new_bool(var_async_request_mutated.is_null())) {
	var_async_request_mutated = create_actionscheduler_asyncrequest_queuerunner(rt.get_property(rt.new_object('ActionScheduler_QueueRunner', ['ActionScheduler_Abstract_QueueRunner'], &this), 'store'))
	}
	this.async_request = var_async_request_mutated
}

fn (mut this Class_ActionScheduler_QueueRunner) init() {
	rt.call_function('add_filter', [rt.new_string('cron_schedules'), rt.create_array([rt.ArrayItem{ key: none, val: Class_ActionScheduler_QueueRunner.instance() }, rt.ArrayItem{ key: none, val: 'add_wp_cron_schedule' }])])
	mut var_next_timestamp := rt.call_function('wp_next_scheduled', [rt.new_string(Class_ActionScheduler_QueueRunner.wp_cron_hook())])
	if rt.is_true(var_next_timestamp) {
		rt.call_function('wp_unschedule_event', [var_next_timestamp.clone(), rt.new_string(Class_ActionScheduler_QueueRunner.wp_cron_hook())])
	}
	mut var_cron_context := ['WP Cron']
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_next_scheduled', [rt.new_string(Class_ActionScheduler_QueueRunner.wp_cron_hook()), rt.create_array_from_list(var_cron_context)]))))) {
		mut var_schedule := rt.call_function('apply_filters', [rt.new_string('action_scheduler_run_schedule'), rt.new_string(Class_ActionScheduler_QueueRunner.wp_cron_schedule())])
		rt.call_function('wp_schedule_event', [rt.call_function('time', []rt.PhpVal{}), var_schedule.clone(), rt.new_string(Class_ActionScheduler_QueueRunner.wp_cron_hook()), rt.create_array_from_list(var_cron_context)])
	}
	rt.call_function('add_action', [rt.new_string(Class_ActionScheduler_QueueRunner.wp_cron_hook()), rt.create_array([rt.ArrayItem{ key: none, val: Class_ActionScheduler_QueueRunner.instance() }, rt.ArrayItem{ key: none, val: 'run' }])])
	this.hook_dispatch_async_request()
}

fn (mut this Class_ActionScheduler_QueueRunner) hook_dispatch_async_request() {
	rt.call_function('add_action', [rt.new_string('shutdown'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('ActionScheduler_QueueRunner', ['ActionScheduler_Abstract_QueueRunner'], &this) }, rt.ArrayItem{ key: none, val: 'maybe_dispatch_async_request' }])])
}

fn (mut this Class_ActionScheduler_QueueRunner) unhook_dispatch_async_request() {
	rt.call_function('remove_action', [rt.new_string('shutdown'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('ActionScheduler_QueueRunner', ['ActionScheduler_Abstract_QueueRunner'], &this) }, rt.ArrayItem{ key: none, val: 'maybe_dispatch_async_request' }])])
}

fn (mut this Class_ActionScheduler_QueueRunner) maybe_dispatch_async_request() {
	mut iife_temp_0 := Class_ActionScheduler{}
	mut iife_result_0 := iife_temp_0.lock()
	mut iife_temp_1 := Class_ActionScheduler{}
	mut iife_result_1 := iife_temp_1.lock()
	if rt.is_true(rt.call_function('is_admin', []rt.PhpVal{})) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(iife_result_0, 'is_locked', [rt.new_string('async-request-runner')]))))) && rt.is_true(rt.call_method(iife_result_1, 'set', [rt.new_string('async-request-runner')])) {
		rt.call_method(this.async_request, 'maybe_dispatch', []rt.PhpVal{})
	}
}

fn (mut this Class_ActionScheduler_QueueRunner) run(context string) i64 {
	mut iife_temp_2 := Class_ActionScheduler_Compatibility{}
	mut iife_result_2 := iife_temp_2.raise_memory_limit()
	mut iife_temp_3 := Class_ActionScheduler_Compatibility{}
	mut iife_result_3 := iife_temp_3.raise_time_limit(this.get_time_limit())
	rt.call_function('do_action', [rt.new_string('action_scheduler_before_process_queue')])
	this.run_cleanup()
	this.processed_actions_count = 0
	if rt.is_true(rt.identical(rt.new_bool(false), this.has_maximum_concurrent_batches())) {
		for {
			mut var_batch_size := rt.call_function('apply_filters', [rt.new_string('action_scheduler_queue_runner_batch_size'), rt.new_int(25)])
			mut var_processed_actions_in_batch := this.do_batch((var_batch_size).to_i64(), context)
			this.processed_actions_count = rt.add(this.processed_actions_count, var_processed_actions_in_batch)
			if !(rt.is_true(rt.greater(var_processed_actions_in_batch, rt.new_int(0))) && rt.is_true(rt.new_bool(!(rt.is_true(this.batch_limits_exceeded(rt.new_int(this.processed_actions_count))))))) {
				break
			}
		}
	}
	rt.call_function('do_action', [rt.new_string('action_scheduler_after_process_queue')])
	return this.processed_actions_count
}

fn (mut this Class_ActionScheduler_QueueRunner) do_batch(size i64, context string) rt.PhpVal {
	mut var_claim := rt.call_method(rt.get_property(rt.new_object('ActionScheduler_QueueRunner', ['ActionScheduler_Abstract_QueueRunner'], &this), 'store'), 'stake_claim', [rt.new_int(size)])
	rt.call_method(rt.get_property(rt.new_object('ActionScheduler_QueueRunner', ['ActionScheduler_Abstract_QueueRunner'], &this), 'monitor'), 'attach', [var_claim.clone()])
	mut var_processed_actions := rt.new_int(0)
	mut iter_1 := rt.call_method(var_claim, 'get_actions', []rt.PhpVal{}).iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_action_id := item_1.val
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_action_id.clone(), rt.call_method(rt.get_property(rt.new_object('ActionScheduler_QueueRunner', ['ActionScheduler_Abstract_QueueRunner'], &this), 'store'), 'find_actions_by_claim_id', [rt.call_method(var_claim, 'get_id', []rt.PhpVal{})]), rt.new_bool(true)]))))) {
			break
		}
		this.process_action(var_action_id.clone(), rt.new_string(context))
		rt.post_inc(var_processed_actions)
		if rt.is_true(this.batch_limits_exceeded(rt.add(var_processed_actions, this.processed_actions_count))) {
			break
		}
	}
	rt.call_method(rt.get_property(rt.new_object('ActionScheduler_QueueRunner', ['ActionScheduler_Abstract_QueueRunner'], &this), 'store'), 'release_claim', [var_claim.clone()])
	rt.call_method(rt.get_property(rt.new_object('ActionScheduler_QueueRunner', ['ActionScheduler_Abstract_QueueRunner'], &this), 'monitor'), 'detach', []rt.PhpVal{})
	this.clear_caches()
	return var_processed_actions.clone()
}

fn (mut this Class_ActionScheduler_QueueRunner) clear_caches() {
	mut var_flushing_runtime_cache_explicitly_supported := rt.new_bool(rt.is_true(rt.call_function('function_exists', [rt.new_string('wp_cache_supports')])) && rt.is_true(rt.call_function('wp_cache_supports', [rt.new_string('flush_runtime')])))
	mut var_flushing_runtime_cache_implicitly_supported := rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('wp_cache_supports')]))))) && rt.is_true(rt.call_function('function_exists', [rt.new_string('wp_cache_flush_runtime')])))
	if rt.is_true(var_flushing_runtime_cache_explicitly_supported) || rt.is_true(var_flushing_runtime_cache_implicitly_supported) {
		rt.call_function('wp_cache_flush_runtime', []rt.PhpVal{})
	} else if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_using_ext_object_cache', []rt.PhpVal{}))))) || rt.is_true(rt.call_function('apply_filters', [rt.new_string('action_scheduler_queue_runner_flush_cache'), rt.new_bool(false)])) {
		rt.call_function('wp_cache_flush', []rt.PhpVal{})
	}
}

fn (mut this Class_ActionScheduler_QueueRunner) add_wp_cron_schedule(var_schedules rt.PhpVal) rt.PhpVal {
	mut var_schedules_mutated := var_schedules
	var_schedules_mutated.array_set('every_minute', rt.create_array([rt.ArrayItem{ key: 'interval', val: 60 }, rt.ArrayItem{ key: 'display', val: rt.call_function('__', [rt.new_string('Every minute'), rt.new_string('woocommerce')]) }]))
	return var_schedules_mutated.clone()
}

struct Class_ActionScheduler_Abstract_QueueRunner {
	rt.PhpObjectBase
}

struct Class_ActionScheduler_AsyncRequest_QueueRunner {
	rt.PhpObjectBase
}

struct Class_ActionScheduler {
	rt.PhpObjectBase
}

struct Class_ActionScheduler_Compatibility {
	rt.PhpObjectBase
}

fn create_actionscheduler_queuerunner(arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal, arg_3 rt.PhpVal) &Class_ActionScheduler_QueueRunner {
	mut obj := &Class_ActionScheduler_QueueRunner{
		PhpObjectBase: rt.PhpObjectBase{}
		async_request: rt.new_null()
		processed_actions_count: i64(0)
	}
	obj.construct(arg_0, arg_1, arg_2, arg_3)
	return obj
}

fn create_actionscheduler_abstract_queuerunner(_args ...rt.PhpVal) &Class_ActionScheduler_Abstract_QueueRunner {
	mut obj := &Class_ActionScheduler_Abstract_QueueRunner{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_actionscheduler_asyncrequest_queuerunner(_args ...rt.PhpVal) &Class_ActionScheduler_AsyncRequest_QueueRunner {
	mut obj := &Class_ActionScheduler_AsyncRequest_QueueRunner{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_actionscheduler(_args ...rt.PhpVal) &Class_ActionScheduler {
	mut obj := &Class_ActionScheduler{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_actionscheduler_compatibility(_args ...rt.PhpVal) &Class_ActionScheduler_Compatibility {
	mut obj := &Class_ActionScheduler_Compatibility{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_ActionScheduler_QueueRunner) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'instance' {
			return Class_ActionScheduler_QueueRunner.instance()
		}
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_?ActionScheduler_Store](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_?ActionScheduler_FatalErrorMonitor](if args.len > 1 { args[1] } else { rt.new_null() })
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_?ActionScheduler_QueueCleaner](if args.len > 2 { args[2] } else { rt.new_null() })
			mut dispatch_arg_3 := rt.cast_object_ptr[Class_?ActionScheduler_AsyncRequest_QueueRunner](if args.len > 3 { args[3] } else { rt.new_null() })
			this.construct(mut dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2, mut dispatch_arg_3)
			return rt.new_null()
		}
		'init' {
			this.init()
			return rt.new_null()
		}
		'hook_dispatch_async_request' {
			this.hook_dispatch_async_request()
			return rt.new_null()
		}
		'unhook_dispatch_async_request' {
			this.unhook_dispatch_async_request()
			return rt.new_null()
		}
		'maybe_dispatch_async_request' {
			this.maybe_dispatch_async_request()
			return rt.new_null()
		}
		'run' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_int(this.run(dispatch_arg_0))
		}
		'do_batch' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return this.do_batch(dispatch_arg_0, dispatch_arg_1)
		}
		'clear_caches' {
			this.clear_caches()
			return rt.new_null()
		}
		'add_wp_cron_schedule' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.add_wp_cron_schedule(dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_ActionScheduler_QueueRunner) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'async_request' { return this.async_request }
		'processed_actions_count' { return rt.new_int(this.processed_actions_count) }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_ActionScheduler_QueueRunner) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'async_request' { this.async_request = val; return true }
		'processed_actions_count' { this.processed_actions_count = (val).to_i64(); return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_ActionScheduler_Abstract_QueueRunner) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ActionScheduler_Abstract_QueueRunner) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ActionScheduler_Abstract_QueueRunner) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_ActionScheduler_AsyncRequest_QueueRunner) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ActionScheduler_AsyncRequest_QueueRunner) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ActionScheduler_AsyncRequest_QueueRunner) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_ActionScheduler) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ActionScheduler) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ActionScheduler) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_ActionScheduler_Compatibility) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ActionScheduler_Compatibility) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ActionScheduler_Compatibility) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn init_registry() {
	rt.register_class_factory('ActionScheduler_QueueRunner', fn(args []rt.PhpVal) rt.PhpVal {
		c_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		c_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		c_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
		c_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
		obj := create_actionscheduler_queuerunner(c_arg_0, c_arg_1, c_arg_2, c_arg_3)
		return rt.new_object('ActionScheduler_QueueRunner', ['ActionScheduler_Abstract_QueueRunner'], obj)
	})
	rt.register_class_factory('ActionScheduler_Abstract_QueueRunner', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_actionscheduler_abstract_queuerunner()
		return rt.new_object('ActionScheduler_Abstract_QueueRunner', []string{}, obj)
	})
	rt.register_class_factory('ActionScheduler_AsyncRequest_QueueRunner', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_actionscheduler_asyncrequest_queuerunner()
		return rt.new_object('ActionScheduler_AsyncRequest_QueueRunner', []string{}, obj)
	})
	rt.register_class_factory('ActionScheduler', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_actionscheduler()
		return rt.new_object('ActionScheduler', []string{}, obj)
	})
	rt.register_class_factory('ActionScheduler_Compatibility', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_actionscheduler_compatibility()
		return rt.new_object('ActionScheduler_Compatibility', []string{}, obj)
	})
}

fn init() {
	init_registry()
}


fn main() {
	defer {
		rt.shutdown()
	}

}
