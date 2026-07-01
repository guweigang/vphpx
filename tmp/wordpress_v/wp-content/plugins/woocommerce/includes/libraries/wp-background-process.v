import rt
import crypto.md5

struct Class_WP_Background_Process {
	rt.PhpObjectBase
pub mut:
		action rt.PhpVal = rt.new_string('background_process')
		start_time rt.PhpVal = rt.new_int(0)
		cron_hook_identifier rt.PhpVal = rt.new_null()
		cron_interval_identifier rt.PhpVal = rt.new_null()
}

fn (mut this Class_WP_Background_Process) construct()  {
	this.Class_WP_Async_Request.construct()
	this.cron_hook_identifier = (rt.get_property(rt.new_object('WP_Background_Process', ['WP_Async_Request'], &this), 'identifier')).str() + '_cron'
	this.cron_interval_identifier = (rt.get_property(rt.new_object('WP_Background_Process', ['WP_Async_Request'], &this), 'identifier')).str() + '_cron_interval'
	rt.call_function('add_action', [this.cron_hook_identifier, rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_Background_Process', ['WP_Async_Request'], &this) }, rt.ArrayItem{ key: none, val: 'handle_cron_healthcheck' }])])
	rt.call_function('add_filter', [rt.new_string('cron_schedules'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_Background_Process', ['WP_Async_Request'], &this) }, rt.ArrayItem{ key: none, val: 'schedule_cron_healthcheck' }])])
}

fn (mut this Class_WP_Background_Process) dispatch() rt.PhpVal {
	this.schedule_event()
	return this.Class_WP_Async_Request.dispatch()
}

fn (mut this Class_WP_Background_Process) push_to_queue(var_data rt.PhpVal) rt.PhpVal {
	rt.get_property(rt.new_object('WP_Background_Process', ['WP_Async_Request'], &this), 'data').array_push(var_data.dup())
	return rt.new_object('WP_Background_Process', []string{}, this)
}

fn (mut this Class_WP_Background_Process) save() rt.PhpVal {
	mut var_key := this.generate_key(0)
	if !(!rt.is_true(rt.get_property(rt.new_object('WP_Background_Process', ['WP_Async_Request'], &this), 'data'))) {
		rt.call_function('update_site_option', [var_key.dup(), rt.get_property(rt.new_object('WP_Background_Process', ['WP_Async_Request'], &this), 'data')])
	}
	return rt.new_object('WP_Background_Process', []string{}, this)
}

fn (mut this Class_WP_Background_Process) update(var_key rt.PhpVal, var_data rt.PhpVal) rt.PhpVal {
	mut var_key_mutated := var_key
	if !(!rt.is_true(var_data)) {
		rt.call_function('update_site_option', [var_key_mutated.dup(), var_data.dup()])
	}
	return rt.new_object('WP_Background_Process', []string{}, this)
}

fn (mut this Class_WP_Background_Process) delete(var_key rt.PhpVal) rt.PhpVal {
	mut var_key_mutated := var_key
	rt.call_function('delete_site_option', [var_key_mutated.dup()])
	return rt.new_object('WP_Background_Process', []string{}, this)
}

fn (mut this Class_WP_Background_Process) generate_key(length i64) rt.PhpVal {
	mut var_unique := rt.new_string(rt.new_string(md5.hexhash((rt.call_function('microtime', []rt.PhpVal{})).str() + (rt.call_function('rand', []rt.PhpVal{})).str())))
	mut var_prepend := rt.new_string((rt.get_property(rt.new_object('WP_Background_Process', ['WP_Async_Request'], &this), 'identifier')).str() + '_batch_')
	return rt.call_function('substr', [rt.concat(var_prepend, var_unique), rt.new_int(0), rt.new_int(length)])
}

fn (mut this Class_WP_Background_Process) maybe_handle()  {
	rt.call_function('session_write_close', []rt.PhpVal{})
	if this.is_process_running() {
		rt.call_function('wp_die', []rt.PhpVal{})
	}
	if this.is_queue_empty() {
		rt.call_function('wp_die', []rt.PhpVal{})
	}
	rt.call_function('check_ajax_referer', [rt.get_property(rt.new_object('WP_Background_Process', ['WP_Async_Request'], &this), 'identifier'), rt.new_string('nonce')])
	this.handle()
	rt.call_function('wp_die', []rt.PhpVal{})
}

fn (mut this Class_WP_Background_Process) is_queue_empty() bool {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	mut var_table := rt.get_property(var_wpdb, 'options')
	mut var_column := rt.new_string(rt.new_string('option_name'))
	if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) {
		var_table = rt.get_property(var_wpdb, 'sitemeta')
		var_column = rt.new_string(rt.new_string('meta_key'))
	}
	mut var_key := rt.new_string((rt.get_property(rt.new_object('WP_Background_Process', ['WP_Async_Request'], &this), 'identifier')).str() + '_batch_%')
	mut var_count := rt.call_method(var_wpdb, 'get_var', [rt.call_method(var_wpdb, 'prepare', [rt.new_string("\n\t\t\tSELECT COUNT(*)\n\t\t\tFROM ${var_table.to_string()}\n\t\t\tWHERE ${var_column.to_string()} LIKE %s\n\t\t"), var_key.dup()])])
	return !(rt.is_true(rt.greater(var_count, rt.new_int(0))))
}

fn (mut this Class_WP_Background_Process) is_process_running() bool {
	if rt.is_true(rt.call_function('get_site_transient', [(rt.get_property(rt.new_object('WP_Background_Process', ['WP_Async_Request'], &this), 'identifier')).str() + '_process_lock'])) {
		return true
	}
	return false
}

fn (mut this Class_WP_Background_Process) lock_process()  {
	this.start_time = rt.call_function('time', []rt.PhpVal{})
	mut var_lock_duration := if rt.is_true(rt.call_function('property_exists', [rt.new_object('WP_Background_Process', ['WP_Async_Request'], &this), rt.new_string('queue_lock_time')])) { rt.get_property(rt.new_object('WP_Background_Process', ['WP_Async_Request'], &this), 'queue_lock_time') } else { rt.new_int(60) }
	var_lock_duration = rt.call_function('apply_filters', [(rt.get_property(rt.new_object('WP_Background_Process', ['WP_Async_Request'], &this), 'identifier')).str() + '_queue_lock_time', var_lock_duration.dup()])
	rt.call_function('set_site_transient', [(rt.get_property(rt.new_object('WP_Background_Process', ['WP_Async_Request'], &this), 'identifier')).str() + '_process_lock', rt.call_function('microtime', []rt.PhpVal{}), var_lock_duration.dup()])
}

fn (mut this Class_WP_Background_Process) unlock_process() rt.PhpVal {
	rt.call_function('delete_site_transient', [(rt.get_property(rt.new_object('WP_Background_Process', ['WP_Async_Request'], &this), 'identifier')).str() + '_process_lock'])
	return rt.new_object('WP_Background_Process', []string{}, this)
}

fn (mut this Class_WP_Background_Process) get_batch() rt.PhpVal {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	mut var_table := rt.get_property(var_wpdb, 'options')
	mut var_column := rt.new_string(rt.new_string('option_name'))
	mut var_key_column := rt.new_string(rt.new_string('option_id'))
	mut var_value_column := rt.new_string(rt.new_string('option_value'))
	if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) {
		var_table = rt.get_property(var_wpdb, 'sitemeta')
		var_column = rt.new_string(rt.new_string('meta_key'))
		var_key_column = rt.new_string(rt.new_string('meta_id'))
		var_value_column = rt.new_string(rt.new_string('meta_value'))
	}
	mut var_key := rt.new_string((rt.get_property(rt.new_object('WP_Background_Process', ['WP_Async_Request'], &this), 'identifier')).str() + '_batch_%')
	mut var_query := rt.call_method(var_wpdb, 'get_row', [rt.call_method(var_wpdb, 'prepare', [rt.new_string("\n\t\t\tSELECT *\n\t\t\tFROM ${var_table.to_string()}\n\t\t\tWHERE ${var_column.to_string()} LIKE %s\n\t\t\tORDER BY ${var_key_column.to_string()} ASC\n\t\t\tLIMIT 1\n\t\t"), var_key.dup()])])
	mut var_batch := create_stdclass()
	rt.set_property(var_batch, 'key', rt.get_property(var_query, '{"nodeType":"Expr_Variable","line":282,"name":"column"}'))
	rt.set_property(var_batch, 'data', rt.call_function('maybe_unserialize', [rt.get_property(var_query, '{"nodeType":"Expr_Variable","line":283,"name":"value_column"}')]))
	return var_batch.dup()
}

fn (mut this Class_WP_Background_Process) handle()  {
	this.lock_process()
	for {
		mut var_batch := this.get_batch()
		{
			mut iter_1 := rt.get_property(var_batch, 'data').iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_value := item_1.val
				mut var_key := item_1.key
				mut var_task := this.task(var_value.dup())
				if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
					rt.get_property(var_batch, 'data').array_set(var_key, var_task.dup())
				} else {
					rt.get_property(var_batch, 'data').array_unset(var_key)
				}
				if rt.is_true(rt.new_bool(rt.is_true(this.time_exceeded()) || rt.is_true(this.memory_exceeded()))) {
					break
				}
			}
		}
		if !(!rt.is_true(rt.get_property(var_batch, 'data'))) {
			this.update(rt.get_property(var_batch, 'key'), rt.get_property(var_batch, 'data'))
		} else {
			this.delete(rt.get_property(var_batch, 'key'))
		}
		if !(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(this.time_exceeded())))) && rt.is_true(rt.new_bool(!(rt.is_true(this.memory_exceeded())))))) && !(this.is_queue_empty())))) {
			break
		}
	}
	this.unlock_process()
	if !(this.is_queue_empty()) {
		this.dispatch()
	} else {
		this.complete()
	}
	rt.call_function('wp_die', []rt.PhpVal{})
}

fn (mut this Class_WP_Background_Process) memory_exceeded() rt.PhpVal {
	mut var_memory_limit := rt.new_float(this.get_memory_limit() * 0.9)
	mut var_current_memory := rt.call_function('memory_get_usage', [rt.new_bool(true)])
	mut var_return := rt.new_bool(rt.new_bool(false))
	if rt.is_true(rt.greater_equal(var_current_memory, var_memory_limit)) {
		var_return = rt.new_bool(rt.new_bool(true))
	}
	return rt.call_function('apply_filters', [(rt.get_property(rt.new_object('WP_Background_Process', ['WP_Async_Request'], &this), 'identifier')).str() + '_memory_exceeded', var_return.dup()])
}

fn (mut this Class_WP_Background_Process) get_memory_limit() rt.PhpVal {
	if rt.is_true(rt.call_function('function_exists', [rt.new_string('ini_get')])) {
		mut var_memory_limit := rt.call_function('ini_get', [rt.new_string('memory_limit')])
	} else {
		var_memory_limit = rt.new_string(rt.new_string('128M'))
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_memory_limit)))) || rt.is_true(rt.identical(// unsupported expression: Expr_UnaryMinus, var_memory_limit)))) {
		var_memory_limit = rt.new_string(rt.new_string('32000M'))
	}
	return rt.call_function('wp_convert_hr_to_bytes', [var_memory_limit.dup()])
}

fn (mut this Class_WP_Background_Process) time_exceeded() rt.PhpVal {
	mut var_finish := rt.add(this.start_time, rt.call_function('apply_filters', [(rt.get_property(rt.new_object('WP_Background_Process', ['WP_Async_Request'], &this), 'identifier')).str() + '_default_time_limit', rt.new_int(20)]))
	mut var_return := rt.new_bool(rt.new_bool(false))
	if rt.is_true(rt.greater_equal(rt.call_function('time', []rt.PhpVal{}), var_finish)) {
		var_return = rt.new_bool(rt.new_bool(true))
	}
	return rt.call_function('apply_filters', [(rt.get_property(rt.new_object('WP_Background_Process', ['WP_Async_Request'], &this), 'identifier')).str() + '_time_exceeded', var_return.dup()])
}

fn (mut this Class_WP_Background_Process) complete()  {
	this.clear_scheduled_event()
}

fn (mut this Class_WP_Background_Process) schedule_cron_healthcheck(var_schedules rt.PhpVal) rt.PhpVal {
	mut var_schedules_mutated := var_schedules
	mut var_interval := rt.call_function('apply_filters', [(rt.get_property(rt.new_object('WP_Background_Process', ['WP_Async_Request'], &this), 'identifier')).str() + '_cron_interval', rt.new_int(5)])
	if rt.is_true(rt.call_function('property_exists', [rt.new_object('WP_Background_Process', ['WP_Async_Request'], &this), rt.new_string('cron_interval')])) {
		var_interval = rt.call_function('apply_filters', [(rt.get_property(rt.new_object('WP_Background_Process', ['WP_Async_Request'], &this), 'identifier')).str() + '_cron_interval', rt.get_property(rt.new_object('WP_Background_Process', ['WP_Async_Request'], &this), 'cron_interval')])
	}
	var_schedules_mutated.array_set((rt.get_property(rt.new_object('WP_Background_Process', ['WP_Async_Request'], &this), 'identifier')).str() + '_cron_interval', rt.create_array([rt.ArrayItem{ key: 'interval', val: rt.mul(rt.get_constant('MINUTE_IN_SECONDS'), var_interval) }, rt.ArrayItem{ key: 'display', val: rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Every %d minutes'), rt.new_string('woocommerce')]), var_interval.dup()]) }]))
	return var_schedules_mutated.dup()
}

fn (mut this Class_WP_Background_Process) handle_cron_healthcheck()  {
	if this.is_process_running() {
		// unsupported expression: Expr_Exit
	}
	if this.is_queue_empty() {
		this.clear_scheduled_event()
		// unsupported expression: Expr_Exit
	}
	this.handle()
	// unsupported expression: Expr_Exit
}

fn (mut this Class_WP_Background_Process) schedule_event()  {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_next_scheduled', [this.cron_hook_identifier]))))) {
		rt.call_function('wp_schedule_event', [rt.call_function('time', []rt.PhpVal{}), this.cron_interval_identifier, this.cron_hook_identifier])
	}
}

fn (mut this Class_WP_Background_Process) clear_scheduled_event()  {
	mut var_timestamp := rt.call_function('wp_next_scheduled', [this.cron_hook_identifier])
	if rt.is_true(var_timestamp) {
		rt.call_function('wp_unschedule_event', [.dup(), ])
	}
}

fn (mut this Class_WP_Background_Process) cancel_process()  {
	if !(this.is_queue_empty()) {
		
	}
}

fn (mut this Class_WP_Background_Process) task(var_item rt.PhpVal)  {
}

struct Class_WP_Async_Request {
	rt.PhpObjectBase
}

struct Class_stdClass {
	rt.PhpObjectBase
}

fn create_wp_background_process() &Class_WP_Background_Process {
	mut obj := &Class_WP_Background_Process{
		PhpObjectBase: rt.PhpObjectBase{}
		action: rt.new_string('background_process')
		start_time: rt.new_int(0)
		cron_hook_identifier: rt.new_null()
		cron_interval_identifier: rt.new_null()
	}
	obj.construct()
	return obj
}

fn create_wp_async_request() &Class_WP_Async_Request {
	mut obj := &Class_WP_Async_Request{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_stdclass() &Class_stdClass {
	mut obj := &Class_stdClass{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Background_Process) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'dispatch' {
			return this.dispatch()
		}
		'push_to_queue' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.push_to_queue(dispatch_arg_0)
		}
		'save' {
			return this.save()
		}
		'update' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.update(dispatch_arg_0, dispatch_arg_1)
		}
		'delete' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.delete(dispatch_arg_0)
		}
		'generate_key' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			return this.generate_key(dispatch_arg_0)
		}
		'maybe_handle' {
			this.maybe_handle()
			return rt.new_null()
		}
		'is_queue_empty' {
			return rt.new_bool(this.is_queue_empty())
		}
		'is_process_running' {
			return rt.new_bool(this.is_process_running())
		}
		'lock_process' {
			this.lock_process()
			return rt.new_null()
		}
		'unlock_process' {
			return this.unlock_process()
		}
		'get_batch' {
			return this.get_batch()
		}
		'handle' {
			this.handle()
			return rt.new_null()
		}
		'memory_exceeded' {
			return this.memory_exceeded()
		}
		'get_memory_limit' {
			return this.get_memory_limit()
		}
		'time_exceeded' {
			return this.time_exceeded()
		}
		'complete' {
			this.complete()
			return rt.new_null()
		}
		'schedule_cron_healthcheck' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.schedule_cron_healthcheck(dispatch_arg_0)
		}
		'handle_cron_healthcheck' {
			this.handle_cron_healthcheck()
			return rt.new_null()
		}
		'schedule_event' {
			this.schedule_event()
			return rt.new_null()
		}
		'clear_scheduled_event' {
			this.clear_scheduled_event()
			return rt.new_null()
		}
		'cancel_process' {
			this.cancel_process()
			return rt.new_null()
		}
		'task' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.task(dispatch_arg_0)
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_WP_Background_Process) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'action' { return this.action }
		'start_time' { return this.start_time }
		'cron_hook_identifier' { return this.cron_hook_identifier }
		'cron_interval_identifier' { return this.cron_interval_identifier }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_Background_Process) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'action' { this.action = val; return true }
		'start_time' { this.start_time = val; return true }
		'cron_hook_identifier' { this.cron_hook_identifier = val; return true }
		'cron_interval_identifier' { this.cron_interval_identifier = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_WP_Async_Request) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Async_Request) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Async_Request) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_stdClass) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_stdClass) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_stdClass) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_includes_libraries_wp_background_process_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
