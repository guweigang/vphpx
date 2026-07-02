import rt

struct Class_WC_Background_Process {
	rt.PhpObjectBase
}

fn (mut this Class_WC_Background_Process) is_queue_empty() bool {
	mut var_wpdb := rt.new_null()
	mut var_table := rt.get_property(var_wpdb, 'options')
	mut var_column := rt.new_string('option_name')
	if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) {
		var_table = rt.get_property(var_wpdb, 'sitemeta')
		var_column = rt.new_string('meta_key')
	}
	mut var_key := rt.new_string(
		(rt.call_method(var_wpdb, 'esc_like', [rt.new_string((rt.get_property(rt.new_object('WC_Background_Process', ['WP_Background_Process'], &this), 'identifier')).str() +
		'_batch_')])).str() + '%')
	mut var_count := rt.call_method(var_wpdb, 'get_var', [
		rt.call_method(var_wpdb, 'prepare', [
			rt.new_string('SELECT COUNT(*) FROM ${var_table.to_string()} WHERE ${var_column.to_string()} LIKE %s'),
			var_key.clone(),
		]),
	])
	return !(rt.is_true(rt.greater(var_count, rt.new_int(0))))
}

fn (mut this Class_WC_Background_Process) get_batch() rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_table := rt.get_property(var_wpdb, 'options')
	mut var_column := rt.new_string('option_name')
	mut var_key_column := rt.new_string('option_id')
	mut var_value_column := rt.new_string('option_value')
	if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) {
		var_table = rt.get_property(var_wpdb, 'sitemeta')
		var_column = rt.new_string('meta_key')
		var_key_column = rt.new_string('meta_id')
		var_value_column = rt.new_string('meta_value')
	}
	mut var_key := rt.new_string(
		(rt.call_method(var_wpdb, 'esc_like', [rt.new_string((rt.get_property(rt.new_object('WC_Background_Process', ['WP_Background_Process'], &this), 'identifier')).str() +
		'_batch_')])).str() + '%')
	mut var_query := rt.call_method(var_wpdb, 'get_row', [
		rt.call_method(var_wpdb, 'prepare', [
			rt.new_string('SELECT * FROM ${var_table.to_string()} WHERE ${var_column.to_string()} LIKE %s ORDER BY ${var_key_column.to_string()} ASC LIMIT 1'),
			var_key.clone(),
		]),
	])
	mut var_batch := create_stdclass()
	rt.set_property(var_batch, 'key', rt.get_property(var_query,
		'{"nodeType":"Expr_Variable","line":74,"name":"column"}'))
	rt.set_property(var_batch, 'data', rt.call_function('array_filter', [
		rt.cast_array(rt.call_function('maybe_unserialize', [
			rt.get_property(var_query,
				'{"nodeType":"Expr_Variable","line":75,"name":"value_column"}'),
		])),
	]))
	return var_batch.clone()
}

fn (mut this Class_WC_Background_Process) batch_limit_exceeded() bool {
	return rt.is_true(this.time_exceeded()) || rt.is_true(this.memory_exceeded())
}

fn (mut this Class_WC_Background_Process) handle() {
	this.lock_process()
	for {
		mut var_batch := this.get_batch()
		mut iter_1 := rt.get_property(var_batch, 'data').iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_value := item_1.val
			mut var_key := item_1.key
			mut var_task := this.task(var_value.clone())
			if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_task)))) {
				rt.get_property(var_batch, 'data').array_set(var_key, var_task.clone())
			} else {
				rt.get_property(var_batch, 'data').array_unset(var_key)
			}
			if this.batch_limit_exceeded() {
				break
			}
		}
		if !(!rt.is_true(rt.get_property(var_batch, 'data'))) {
			this.update(rt.get_property(var_batch, 'key'), rt.get_property(var_batch, 'data'))
		} else {
			this.delete(rt.get_property(var_batch, 'key'))
		}
		if !(!(this.batch_limit_exceeded()) && !(this.is_queue_empty())) {
			break
		}
	}
	this.unlock_process()
	if !(this.is_queue_empty()) {
		this.dispatch()
	} else {
		this.complete()
	}
}

fn (mut this Class_WC_Background_Process) get_memory_limit() rt.PhpVal {
	if rt.is_true(rt.call_function('function_exists', [rt.new_string('ini_get')])) {
		mut var_memory_limit := rt.call_function('ini_get', [
			rt.new_string('memory_limit'),
		])
	} else {
		var_memory_limit = rt.new_string('128M')
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_memory_limit))))
		|| -1 == var_memory_limit.clone().to_i64() {
		var_memory_limit = rt.new_string('32G')
	}
	return rt.call_function('wp_convert_hr_to_bytes', [var_memory_limit.clone()])
}

fn (mut this Class_WC_Background_Process) schedule_cron_healthcheck(var_schedules rt.PhpVal) rt.PhpVal {
	mut var_schedules_mutated := var_schedules
	mut var_interval := rt.call_function('apply_filters', [
		rt.new_string(
			(rt.get_property(rt.new_object('WC_Background_Process', ['WP_Background_Process'], &this), 'identifier')).str() +
			'_cron_interval'),
		rt.new_int(5),
	])
	if rt.is_true(rt.call_function('property_exists', [
		rt.new_object('WC_Background_Process', ['WP_Background_Process'], &this),
		rt.new_string('cron_interval'),
	]))
	{
		var_interval = rt.call_function('apply_filters', [
			rt.new_string(
				(rt.get_property(rt.new_object('WC_Background_Process', ['WP_Background_Process'], &this), 'identifier')).str() +
				'_cron_interval'),
			rt.get_property(rt.new_object('WC_Background_Process', [
				'WP_Background_Process',
			], &this), 'cron_interval'),
		])
	}
	var_schedules_mutated.array_set(
		(rt.get_property(rt.new_object('WC_Background_Process', ['WP_Background_Process'], &this), 'identifier')).str() +
		'_cron_interval', rt.create_array([
		rt.ArrayItem{ key: 'interval', val: rt.mul(rt.get_constant('MINUTE_IN_SECONDS'),
			var_interval) },
		rt.ArrayItem{ key: 'display', val: rt.call_function('sprintf', [
			rt.call_function('__', [rt.new_string('Every %d minutes'),
				rt.new_string('woocommerce')]),
			var_interval.clone(),
		]) },
	]))
	return var_schedules_mutated.clone()
}

fn (mut this Class_WC_Background_Process) delete_all_batches() rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_table := rt.get_property(var_wpdb, 'options')
	mut var_column := rt.new_string('option_name')
	if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) {
		var_table = rt.get_property(var_wpdb, 'sitemeta')
		var_column = rt.new_string('meta_key')
	}
	mut var_key := rt.new_string(
		(rt.call_method(var_wpdb, 'esc_like', [rt.new_string((rt.get_property(rt.new_object('WC_Background_Process', ['WP_Background_Process'], &this), 'identifier')).str() +
		'_batch_')])).str() + '%')
	rt.call_method(var_wpdb, 'query', [
		rt.call_method(var_wpdb, 'prepare', [
			rt.new_string('DELETE FROM ${var_table.to_string()} WHERE ${var_column.to_string()} LIKE %s'),
			var_key.clone(),
		]),
	])
	return rt.new_object('WC_Background_Process', []string{}, this)
}

fn (mut this Class_WC_Background_Process) kill_process() {
	if !(this.is_queue_empty()) {
		this.delete_all_batches()
		rt.call_function('wp_clear_scheduled_hook', [
			rt.get_property(rt.new_object('WC_Background_Process', [
				'WP_Background_Process',
			], &this), 'cron_hook_identifier'),
		])
	}
}

struct Class_WP_Background_Process {
	rt.PhpObjectBase
}

struct Class_stdClass {
	rt.PhpObjectBase
}

fn create_wc_background_process(_args ...rt.PhpVal) &Class_WC_Background_Process {
	mut obj := &Class_WC_Background_Process{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_background_process(_args ...rt.PhpVal) &Class_WP_Background_Process {
	mut obj := &Class_WP_Background_Process{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_stdclass(_args ...rt.PhpVal) &Class_stdClass {
	mut obj := &Class_stdClass{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Background_Process) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'is_queue_empty' {
			return rt.new_bool(this.is_queue_empty())
		}
		'get_batch' {
			return this.get_batch()
		}
		'batch_limit_exceeded' {
			return rt.new_bool(this.batch_limit_exceeded())
		}
		'handle' {
			this.handle()
			return rt.new_null()
		}
		'get_memory_limit' {
			return this.get_memory_limit()
		}
		'schedule_cron_healthcheck' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.schedule_cron_healthcheck(dispatch_arg_0)
		}
		'delete_all_batches' {
			return this.delete_all_batches()
		}
		'kill_process' {
			this.kill_process()
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_Background_Process) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Background_Process) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WP_Background_Process) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Background_Process) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Background_Process) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [
		rt.new_string('WP_Async_Request'),
		rt.new_bool(false),
	])))))
	{
		rt.include_file((rt.call_function('dirname', [rt.get_constant('WC_PLUGIN_FILE')])).str() +
			'/includes/libraries/wp-async-request.php', '2')
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [
		rt.new_string('WP_Background_Process'),
		rt.new_bool(false),
	])))))
	{
		rt.include_file((rt.call_function('dirname', [rt.get_constant('WC_PLUGIN_FILE')])).str() +
			'/includes/libraries/wp-background-process.php', '2')
	}
}
