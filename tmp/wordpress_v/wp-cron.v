import rt

const global_const_doing_cron = true
fn _get_cron_lock() rt.PhpVal {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	mut var_value := rt.new_int(rt.new_int(0))
	if rt.is_true(rt.call_function('wp_using_ext_object_cache', []rt.PhpVal{})) {
		var_value = rt.call_function('wp_cache_get', [rt.new_string('doing_cron'), rt.new_string('transient'), rt.new_bool(true)])
	} else {
		mut var_row := rt.call_method(var_wpdb, 'get_row', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.new_string('SELECT option_value FROM '), rt.get_property(var_wpdb, 'options')), rt.new_string(' WHERE option_name = %s LIMIT 1')), rt.new_string('_transient_doing_cron')])])
		if rt.is_true(rt.new_bool(var_row.dup().is_object())) {
			var_value = rt.get_property(var_row, 'option_value')
		}
	}
	return var_value.dup()
}


fn main() {
	defer {
		rt.shutdown()
	}

	rt.call_function('ignore_user_abort', [rt.new_bool(true)])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('headers_sent', []rt.PhpVal{}))))) {
		rt.call_function('header', [rt.new_string('Expires: Wed, 11 Jan 1984 05:00:00 GMT')])
		rt.call_function('header', [rt.new_string('Cache-Control: no-cache, must-revalidate, max-age=0')])
	}
	if rt.is_true(rt.call_function('function_exists', [rt.new_string('fastcgi_finish_request')])) {
		rt.call_function('fastcgi_finish_request', []rt.PhpVal{})
	} else if rt.is_true(rt.call_function('function_exists', [rt.new_string('litespeed_finish_request')])) {
		rt.call_function('litespeed_finish_request', []rt.PhpVal{})
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(!rt.is_true(rt.get_superglobal('_POST'))) || rt.is_true(rt.call_function('defined', [rt.new_string('DOING_AJAX')])))) || rt.is_true(rt.call_function('defined', [rt.new_string('DOING_CRON')])))) {
		// unsupported expression: Expr_Exit
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))))) {
		rt.include_file(@DIR + '/wp-load.php', '4')
	}
	rt.call_function('wp_raise_memory_limit', [rt.new_string('cron')])
	mut var_crons := rt.call_function('wp_get_ready_cron_jobs', []rt.PhpVal{})
	if !rt.is_true(var_crons) {
		// unsupported expression: Expr_Exit
	}
	mut var_gmt_time := rt.call_function('microtime', [rt.new_bool(true)])
	mut var_doing_cron_transient := rt.call_function('get_transient', [rt.new_string('doing_cron')])
	if !rt.is_true(var_doing_wp_cron) {
		if !rt.is_true(rt.get_superglobal('_GET').array_get('doing_wp_cron')) {
			if rt.is_true(rt.new_bool(rt.is_true(var_doing_cron_transient) && rt.is_true(rt.greater(rt.add(var_doing_cron_transient, rt.get_constant('WP_CRON_LOCK_TIMEOUT')), var_gmt_time)))) {
				return rt.new_null()
			}
			mut var_doing_wp_cron := rt.call_function('sprintf', [rt.new_string('%.22F'), rt.call_function('microtime', [rt.new_bool(true)])])
			var_doing_cron_transient = var_doing_wp_cron.dup()
			rt.call_function('set_transient', [rt.new_string('doing_cron'), var_doing_wp_cron.dup()])
		} else {
			var_doing_wp_cron = rt.get_superglobal('_GET').array_get('doing_wp_cron')
		}
	}
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return rt.new_null()
	}
	{
		mut iter_1 := var_crons.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_cronhooks := item_1.val
			mut var_timestamp := item_1.key
			if rt.is_true(rt.greater(var_timestamp, var_gmt_time)) {
				break
			}
			{
				mut iter_2 := var_cronhooks.iterator()
				for {
					item_2 := iter_2.next() or { break }
					mut var_keys := item_2.val
					mut var_hook := item_2.key
					{
						mut iter_3 := var_keys.iterator()
						for {
							item_3 := iter_3.next() or { break }
							mut var_v := item_3.val
							mut var_k := item_3.key
							mut var_schedule := var_v.array_get('schedule')
							if rt.is_true(var_schedule) {
								mut var_result := rt.call_function('wp_reschedule_event', [var_timestamp.dup(), var_schedule.dup(), var_hook.dup(), var_v.array_get('args'), rt.new_bool(true)])
								if rt.is_true(rt.call_function('is_wp_error', [var_result.dup()])) {
									rt.call_function('error_log', [rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Cron reschedule event error for hook: %1$s, Error code: %2$s, Error message: %3$s, Data: %4$s')]), var_hook.dup(), rt.call_method(var_result, 'get_error_code', []rt.PhpVal{}), rt.call_method(var_result, 'get_error_message', []rt.PhpVal{}), rt.call_function('wp_json_encode', [var_v.dup()])])])
									rt.call_function('do_action', [rt.new_string('cron_reschedule_event_error'), var_result.dup(), var_hook.dup(), var_v.dup()])
								}
							}
							var_result = rt.call_function('wp_unschedule_event', [var_timestamp.dup(), var_hook.dup(), var_v.array_get('args'), rt.new_bool(true)])
							if rt.is_true(rt.call_function('is_wp_error', [var_result.dup()])) {
								rt.call_function('error_log', [rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Cron unschedule event error for hook: %1$s, Error code: %2$s, Error message: %3$s, Data: %4$s')]), var_hook.dup(), rt.call_method(var_result, 'get_error_code', []rt.PhpVal{}), rt.call_method(var_result, 'get_error_message', []rt.PhpVal{}), rt.call_function('wp_json_encode', [var_v.dup()])])])
								rt.call_function('do_action', [rt.new_string('cron_unschedule_event_error'), var_result.dup(), var_hook.dup(), var_v.dup()])
							}
							rt.call_function('do_action_ref_array', [var_hook.dup(), var_v.array_get('args')])
							if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
								return rt.new_null()
							}
						}
					}
				}
			}
		}
	}
	if rt.is_true(rt.identical(_get_cron_lock(), var_doing_wp_cron)) {
		rt.call_function('delete_transient', [rt.new_string('doing_cron')])
	}
	// unsupported expression: Expr_Exit
}
