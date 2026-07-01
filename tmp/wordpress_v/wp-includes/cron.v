module wp_includes

import rt
import crypto.md5

fn wp_schedule_single_event(var_timestamp rt.PhpVal, var_hook rt.PhpVal, var_args rt.PhpVal, wp_error bool) bool {
	mut var_event := rt.new_null()
	mut var_pre := rt.new_null()
	mut var_crons := rt.new_null()
	mut var_key := ''
	mut var_duplicate := false
	mut var_min_timestamp := rt.new_null()
	mut var_max_timestamp := rt.new_null()
	mut var_cron := rt.new_null()
	mut var_event_timestamp := rt.new_null()
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_timestamp.dup().is_long() || var_timestamp.dup().is_double()))))) || rt.is_true(rt.less_equal(var_timestamp, rt.new_int(0))))) {
		if var_wp_error {
			return (create_wp_error(rt.new_string('invalid_timestamp'), rt.call_function('__', [rt.new_string('Event timestamp must be a valid Unix timestamp.')]))).to_bool()
		}
		return false
	}
	var_event = // unsupported expression: Expr_Cast_Object
	var_pre = rt.call_function('apply_filters', [rt.new_string('pre_schedule_event'), rt.new_null(), var_event.dup(), rt.new_bool(wp_error)])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_pre)))) {
		if rt.is_true(rt.new_bool(var_wp_error && rt.is_true(rt.identical(rt.new_bool(false), var_pre)))) {
			return (create_wp_error(rt.new_string('pre_schedule_event_false'), rt.call_function('__', [rt.new_string('A plugin prevented the event from being scheduled.')]))).to_bool()
		}
		if rt.is_true(rt.new_bool(!(var_wp_error) && rt.is_true(rt.call_function('is_wp_error', [var_pre.dup()])))) {
			return false
		}
		return (var_pre).to_bool()
	}
	var_crons = _get_cron_array()
	var_key = md5.hexhash(rt.call_function('serialize', [rt.get_property(var_event, 'args')]).to_string())
	var_duplicate = false
	if rt.is_true(rt.less(rt.get_property(var_event, 'timestamp'), rt.add(rt.call_function('time', []rt.PhpVal{}), rt.mul(rt.new_int(10), rt.get_constant('MINUTE_IN_SECONDS'))))) {
		var_min_timestamp = rt.new_int(0)
	} else {
		var_min_timestamp = rt.sub(rt.get_property(var_event, 'timestamp'), rt.mul(rt.new_int(10), rt.get_constant('MINUTE_IN_SECONDS')))
	}
	if rt.is_true(rt.less(rt.get_property(var_event, 'timestamp'), rt.call_function('time', []rt.PhpVal{}))) {
		var_max_timestamp = rt.add(rt.call_function('time', []rt.PhpVal{}), rt.mul(rt.new_int(10), rt.get_constant('MINUTE_IN_SECONDS')))
	} else {
		var_max_timestamp = rt.add(rt.get_property(var_event, 'timestamp'), rt.mul(rt.new_int(10), rt.get_constant('MINUTE_IN_SECONDS')))
	}
	{
		mut iter_1 := var_crons.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_cron_shadow := item_1.val
			mut var_event_timestamp_shadow := item_1.key
			if rt.is_true(rt.less(var_event_timestamp_shadow, var_min_timestamp)) {
				continue
			}
			if rt.is_true(rt.greater(var_event_timestamp_shadow, var_max_timestamp)) {
				break
			}
			if var_cron_shadow.array_get(rt.get_property(var_event, 'hook')).array_isset(rt.new_string(var_key)) {
				var_duplicate = true
				break
			}
		}
	}
	if var_duplicate {
		if var_wp_error {
			return (create_wp_error(rt.new_string('duplicate_event'), rt.call_function('__', [rt.new_string('A duplicate event already exists.')]))).to_bool()
		}
		return false
	}
	var_event = rt.call_function('apply_filters', [rt.new_string('schedule_event'), var_event.dup()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_event)))) {
		if var_wp_error {
			return (create_wp_error(rt.new_string('schedule_event_false'), rt.call_function('__', [rt.new_string('A plugin disallowed this event.')]))).to_bool()
		}
		return false
	}
	var_crons.array_get_mut(rt.get_property(var_event, 'timestamp')).array_get_mut(rt.get_property(var_event, 'hook')).array_set(var_key, rt.create_array([rt.ArrayItem{ key: 'schedule', val: rt.get_property(var_event, 'schedule') }, rt.ArrayItem{ key: 'args', val: rt.get_property(var_event, 'args') }]))
	rt.call_function('uksort', [var_crons.dup(), rt.new_string('strnatcasecmp')])
	return (_set_cron_array(var_crons.dup(), wp_error)).to_bool()
}

fn wp_schedule_event(var_timestamp rt.PhpVal, var_recurrence rt.PhpVal, var_hook rt.PhpVal, var_args rt.PhpVal, wp_error bool) bool {
	mut var_schedules := rt.new_null()
	mut var_event := rt.new_null()
	mut var_pre := rt.new_null()
	mut var_key := ''
	mut var_crons := rt.new_null()
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_timestamp.dup().is_long() || var_timestamp.dup().is_double()))))) || rt.is_true(rt.less_equal(var_timestamp, rt.new_int(0))))) {
		if var_wp_error {
			return (create_wp_error(rt.new_string('invalid_timestamp'), rt.call_function('__', [rt.new_string('Event timestamp must be a valid Unix timestamp.')]))).to_bool()
		}
		return false
	}
	var_schedules = wp_get_schedules()
	if !(var_schedules.array_isset(var_recurrence)) {
		if var_wp_error {
			return (create_wp_error(rt.new_string('invalid_schedule'), rt.call_function('__', [rt.new_string('Event schedule does not exist.')]))).to_bool()
		}
		return false
	}
	var_event = // unsupported expression: Expr_Cast_Object
	var_pre = rt.call_function('apply_filters', [rt.new_string('pre_schedule_event'), rt.new_null(), var_event.dup(), rt.new_bool(wp_error)])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_pre)))) {
		if rt.is_true(rt.new_bool(var_wp_error && rt.is_true(rt.identical(rt.new_bool(false), var_pre)))) {
			return (create_wp_error(rt.new_string('pre_schedule_event_false'), rt.call_function('__', [rt.new_string('A plugin prevented the event from being scheduled.')]))).to_bool()
		}
		if rt.is_true(rt.new_bool(!(var_wp_error) && rt.is_true(rt.call_function('is_wp_error', [var_pre.dup()])))) {
			return false
		}
		return (var_pre).to_bool()
	}
	var_event = rt.call_function('apply_filters', [rt.new_string('schedule_event'), var_event.dup()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_event)))) {
		if var_wp_error {
			return (create_wp_error(rt.new_string('schedule_event_false'), rt.call_function('__', [rt.new_string('A plugin disallowed this event.')]))).to_bool()
		}
		return false
	}
	var_key = md5.hexhash(rt.call_function('serialize', [rt.get_property(var_event, 'args')]).to_string())
	var_crons = _get_cron_array()
	var_crons.array_get_mut(rt.get_property(var_event, 'timestamp')).array_get_mut(rt.get_property(var_event, 'hook')).array_set(var_key, rt.create_array([rt.ArrayItem{ key: 'schedule', val: rt.get_property(var_event, 'schedule') }, rt.ArrayItem{ key: 'args', val: rt.get_property(var_event, 'args') }, rt.ArrayItem{ key: 'interval', val: rt.get_property(var_event, 'interval') }]))
	rt.call_function('uksort', [var_crons.dup(), rt.new_string('strnatcasecmp')])
	return (_set_cron_array(var_crons.dup(), wp_error)).to_bool()
}

fn wp_reschedule_event(var_timestamp rt.PhpVal, var_recurrence rt.PhpVal, var_hook rt.PhpVal, var_args rt.PhpVal, wp_error bool) bool {
	mut var_schedules := rt.new_null()
	mut var_interval := rt.new_null()
	mut var_scheduled_event := rt.new_null()
	mut var_event := rt.new_null()
	mut var_pre := rt.new_null()
	mut var_now := rt.new_null()
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_timestamp.dup().is_long() || var_timestamp.dup().is_double()))))) || rt.is_true(rt.less_equal(var_timestamp, rt.new_int(0))))) {
		if var_wp_error {
			return (create_wp_error(rt.new_string('invalid_timestamp'), rt.call_function('__', [rt.new_string('Event timestamp must be a valid Unix timestamp.')]))).to_bool()
		}
		return false
	}
	var_schedules = wp_get_schedules()
	var_interval = rt.new_int(0)
	if var_schedules.array_isset(var_recurrence) {
		var_interval = var_schedules.array_get(var_recurrence).array_get('interval')
	}
	if rt.is_true(rt.identical(rt.new_int(0), var_interval)) {
		var_scheduled_event = rt.new_bool(wp_get_scheduled_event(var_hook.dup(), var_args.dup(), var_timestamp.dup()))
		if rt.is_true(rt.new_bool(rt.is_true(var_scheduled_event) && !(rt.get_property(var_scheduled_event, 'interval')).is_null())) {
			var_interval = rt.get_property(var_scheduled_event, 'interval')
		}
	}
	var_event = // unsupported expression: Expr_Cast_Object
	var_pre = rt.call_function('apply_filters', [rt.new_string('pre_reschedule_event'), rt.new_null(), var_event.dup(), rt.new_bool(wp_error)])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_pre)))) {
		if rt.is_true(rt.new_bool(var_wp_error && rt.is_true(rt.identical(rt.new_bool(false), var_pre)))) {
			return (create_wp_error(rt.new_string('pre_reschedule_event_false'), rt.call_function('__', [rt.new_string('A plugin prevented the event from being rescheduled.')]))).to_bool()
		}
		if rt.is_true(rt.new_bool(!(var_wp_error) && rt.is_true(rt.call_function('is_wp_error', [var_pre.dup()])))) {
			return false
		}
		return (var_pre).to_bool()
	}
	if rt.is_true(rt.identical(rt.new_int(0), var_interval)) {
		if var_wp_error {
			return (create_wp_error(rt.new_string('invalid_schedule'), rt.call_function('__', [rt.new_string('Event schedule does not exist.')]))).to_bool()
		}
		return false
	}
	var_now = rt.call_function('time', []rt.PhpVal{})
	if rt.is_true(rt.greater_equal(var_timestamp, var_now)) {
		var_timestamp = rt.add(var_now, var_interval)
	} else {
		var_timestamp = rt.add(var_now, rt.sub(var_interval, rt.mod_(rt.sub(var_now, var_timestamp), var_interval)))
	}
	return wp_schedule_event(var_timestamp.dup(), var_recurrence.dup(), var_hook.dup(), var_args.dup(), wp_error)
}

fn wp_unschedule_event(var_timestamp rt.PhpVal, var_hook rt.PhpVal, var_args rt.PhpVal, wp_error bool) bool {
	mut var_pre := rt.new_null()
	mut var_crons := rt.new_null()
	mut var_key := ''
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_timestamp.dup().is_long() || var_timestamp.dup().is_double()))))) || rt.is_true(rt.less_equal(var_timestamp, rt.new_int(0))))) {
		if var_wp_error {
			return (create_wp_error(rt.new_string('invalid_timestamp'), rt.call_function('__', [rt.new_string('Event timestamp must be a valid Unix timestamp.')]))).to_bool()
		}
		return false
	}
	var_pre = rt.call_function('apply_filters', [rt.new_string('pre_unschedule_event'), rt.new_null(), var_timestamp.dup(), var_hook.dup(), var_args.dup(), rt.new_bool(wp_error)])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_pre)))) {
		if rt.is_true(rt.new_bool(var_wp_error && rt.is_true(rt.identical(rt.new_bool(false), var_pre)))) {
			return (create_wp_error(rt.new_string('pre_unschedule_event_false'), rt.call_function('__', [rt.new_string('A plugin prevented the event from being unscheduled.')]))).to_bool()
		}
		if rt.is_true(rt.new_bool(!(var_wp_error) && rt.is_true(rt.call_function('is_wp_error', [var_pre.dup()])))) {
			return false
		}
		return (var_pre).to_bool()
	}
	var_crons = _get_cron_array()
	var_key = md5.hexhash(rt.call_function('serialize', [var_args.dup()]).to_string())
	var_crons.array_get(var_timestamp).array_get(var_hook).array_unset(rt.new_string(var_key))
	if !rt.is_true(var_crons.array_get(var_timestamp).array_get(var_hook)) {
		var_crons.array_get(var_timestamp).array_unset(var_hook)
	}
	if !rt.is_true(var_crons.array_get(var_timestamp)) {
		var_crons.array_unset(var_timestamp)
	}
	return (_set_cron_array(var_crons.dup(), wp_error)).to_bool()
}

fn wp_clear_scheduled_hook(var_hook rt.PhpVal, var_args rt.PhpVal, wp_error bool) rt.PhpVal {
	mut var_pre := rt.new_null()
	mut var_crons := rt.new_null()
	mut var_results := rt.new_null()
	mut var_key := ''
	mut var_cron := rt.new_null()
	mut var_timestamp := rt.new_null()
	mut var_errors := rt.new_null()
	mut var_error := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_args.dup().is_array()))))) {
		rt.call_function('_deprecated_argument', [rt.new_string(@FN), rt.new_string('3.0.0'), rt.call_function('__', [rt.new_string('This argument has changed to an array to match the behavior of the other cron functions.')])])
		var_args = rt.call_function('array_slice', [rt.call_function('func_get_args', []rt.PhpVal{}), rt.new_int(1)])
		wp_error = false
	}
	var_pre = rt.call_function('apply_filters', [rt.new_string('pre_clear_scheduled_hook'), rt.new_null(), var_hook.dup(), var_args.dup(), rt.new_bool(wp_error)])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_pre)))) {
		if rt.is_true(rt.new_bool(var_wp_error && rt.is_true(rt.identical(rt.new_bool(false), var_pre)))) {
			return create_wp_error(rt.new_string('pre_clear_scheduled_hook_false'), rt.call_function('__', [rt.new_string('A plugin prevented the hook from being cleared.')]))
		}
		if rt.is_true(rt.new_bool(!(var_wp_error) && rt.is_true(rt.call_function('is_wp_error', [var_pre.dup()])))) {
			return rt.new_bool(false)
		}
		return var_pre.dup()
	}
	var_crons = _get_cron_array()
	if !rt.is_true(var_crons) {
		return rt.new_int(0)
	}
	var_results = rt.new_array()
	var_key = md5.hexhash(rt.call_function('serialize', [var_args.dup()]).to_string())
	{
		mut iter_1 := var_crons.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_cron_shadow := item_1.val
			mut var_timestamp_shadow := item_1.key
			if var_cron_shadow.array_get(var_hook).array_isset(rt.new_string(var_key)) {
				var_results.array_push(wp_unschedule_event(var_timestamp_shadow.dup(), var_hook.dup(), var_args.dup(), true))
			}
		}
	}
	var_errors = rt.call_function('array_filter', [var_results.dup(), rt.new_string('is_wp_error')])
	var_error = create_wp_error()
	if rt.is_true(var_errors) {
		if var_wp_error {
			rt.call_function('array_walk', [var_errors.dup(), rt.create_array([rt.ArrayItem{ key: none, val: var_error }, rt.ArrayItem{ key: none, val: 'merge_from' }])])
			return rt.new_object('WP_Error', []string{}, var_error)
		}
		return rt.new_bool(false)
	}
	return rt.new_int(var_results.dup().array_count())
}

fn wp_unschedule_hook(var_hook rt.PhpVal, wp_error bool) rt.PhpVal {
	mut var_pre := rt.new_null()
	mut var_crons := rt.new_null()
	mut var_results := rt.new_null()
	mut var_args := rt.new_null()
	mut var_timestamp := rt.new_null()
	mut var_set := rt.new_null()
	var_pre = rt.call_function('apply_filters', [rt.new_string('pre_unschedule_hook'), rt.new_null(), var_hook.dup(), rt.new_bool(wp_error)])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_pre)))) {
		if rt.is_true(rt.new_bool(var_wp_error && rt.is_true(rt.identical(rt.new_bool(false), var_pre)))) {
			return create_wp_error(rt.new_string('pre_unschedule_hook_false'), rt.call_function('__', [rt.new_string('A plugin prevented the hook from being cleared.')]))
		}
		if rt.is_true(rt.new_bool(!(var_wp_error) && rt.is_true(rt.call_function('is_wp_error', [var_pre.dup()])))) {
			return rt.new_bool(false)
		}
		return var_pre.dup()
	}
	var_crons = _get_cron_array()
	if !rt.is_true(var_crons) {
		return rt.new_int(0)
	}
	var_results = rt.new_array()
	{
		mut iter_1 := var_crons.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_args_shadow := item_1.val
			mut var_timestamp_shadow := item_1.key
			if !(!rt.is_true(var_crons.array_get(var_timestamp_shadow).array_get(var_hook))) {
				var_results.array_push(var_crons.array_get(var_timestamp_shadow).array_get(var_hook).array_count())
			}
			var_crons.array_get(var_timestamp_shadow).array_unset(var_hook)
			if !rt.is_true(var_crons.array_get(var_timestamp_shadow)) {
				var_crons.array_unset(var_timestamp_shadow)
			}
		}
	}
	if !rt.is_true(var_results) {
		return rt.new_int(0)
	}
	var_set = _set_cron_array(var_crons.dup(), wp_error)
	if rt.is_true(rt.identical(rt.new_bool(true), var_set)) {
		return rt.call_function('array_sum', [var_results.dup()])
	}
	return var_set.dup()
}

fn wp_get_scheduled_event(var_hook rt.PhpVal, var_args rt.PhpVal, var_timestamp rt.PhpVal) bool {
	mut var_pre := rt.new_null()
	mut var_crons := rt.new_null()
	mut var_key := ''
	mut var_next := rt.new_null()
	mut var_cron := rt.new_null()
	mut var_event := rt.new_null()
	var_pre = rt.call_function('apply_filters', [rt.new_string('pre_get_scheduled_event'), rt.new_null(), var_hook.dup(), var_args.dup(), var_timestamp.dup()])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_pre)))) {
		return (var_pre).to_bool()
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_timestamp)))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_timestamp.dup().is_long() || var_timestamp.dup().is_double()))))))) {
		return false
	}
	var_crons = _get_cron_array()
	if !rt.is_true(var_crons) {
		return false
	}
	var_key = md5.hexhash(rt.call_function('serialize', [var_args.dup()]).to_string())
	if rt.is_true(rt.new_bool(!(rt.is_true(var_timestamp)))) {
		var_next = rt.new_bool(false)
		{
			mut iter_1 := var_crons.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_cron_shadow := item_1.val
				mut var_timestamp_shadow := item_1.key
				if var_cron_shadow.array_get(var_hook).array_isset(rt.new_string(var_key)) {
					var_next = var_timestamp_shadow.dup()
					break
				}
			}
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(var_next)))) {
			return false
		}
		var_timestamp = var_next.dup()
	} else if !(var_crons.array_get(var_timestamp).array_get(var_hook).array_isset(rt.new_string(var_key))) {
		return false
	}
	var_event = // unsupported expression: Expr_Cast_Object
	if var_crons.array_get(var_timestamp).array_get(var_hook).array_get(var_key).array_isset(rt.new_string('interval')) {
		rt.set_property(var_event, 'interval', var_crons.array_get(var_timestamp).array_get(var_hook).array_get(var_key).array_get('interval'))
	}
	return (var_event).to_bool()
}

fn wp_next_scheduled(var_hook rt.PhpVal, var_args rt.PhpVal) bool {
	mut var_next_event := false
	var_next_event = wp_get_scheduled_event(var_hook.dup(), var_args.dup())
	if !(var_next_event) {
		return false
	}
	return (rt.call_function('apply_filters', [rt.new_string('wp_next_scheduled'), rt.get_property(rt.new_bool(var_next_event), 'timestamp'), rt.new_bool(var_next_event).dup(), var_hook.dup(), var_args.dup()])).to_bool()
}

fn spawn_cron(gmt_time i64) bool {
	mut var_lock := rt.new_null()
	mut var_crons := rt.new_null()
	mut var_keys := rt.new_null()
	mut var_doing_wp_cron := rt.new_null()
	mut var_cron_request := rt.new_null()
	mut var_result := rt.new_null()
	if !(var_gmt_time != 0) {
		gmt_time = (rt.call_function('microtime', [rt.new_bool(true)])).to_i64()
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('DOING_CRON')])) || rt.get_superglobal('_GET').array_isset(rt.new_string('doing_wp_cron')))) {
		return false
	}
	var_lock = rt.new_float((rt.call_function('get_transient', [rt.new_string('doing_cron')])).to_f64())
	if rt.is_true(rt.greater(var_lock, rt.add(rt.new_int(gmt_time), rt.mul(rt.new_int(10), rt.get_constant('MINUTE_IN_SECONDS'))))) {
		var_lock = rt.new_int(0)
	}
	if rt.is_true(rt.greater(rt.add(var_lock, rt.get_constant('WP_CRON_LOCK_TIMEOUT')), rt.new_int(gmt_time))) {
		return false
	}
	var_crons = wp_get_ready_cron_jobs()
	if !rt.is_true(var_crons) {
		return false
	}
	var_keys = rt.func_array_keys(var_crons.dup())
	if rt.is_true(rt.new_bool(var_keys.array_isset(rt.new_int(0)) && rt.is_true(rt.greater(var_keys.array_get(0), rt.new_int(gmt_time))))) {
		return false
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ALTERNATE_WP_CRON')])) && rt.is_true(rt.get_constant('ALTERNATE_WP_CRON')))) {
		if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('GET'), rt.get_superglobal('_SERVER').array_get('REQUEST_METHOD'))))) || rt.is_true(rt.call_function('defined', [rt.new_string('DOING_AJAX')])))) || rt.is_true(rt.call_function('defined', [rt.new_string('XMLRPC_REQUEST')])))) {
			return false
		}
		var_doing_wp_cron = rt.call_function('sprintf', [rt.new_string('%.22F'), rt.new_int(gmt_time)])
		rt.call_function('set_transient', [rt.new_string('doing_cron'), var_doing_wp_cron.dup()])
		rt.call_function('ob_start', []rt.PhpVal{})
		rt.call_function('wp_redirect', [rt.call_function('add_query_arg', [rt.new_string('doing_wp_cron'), var_doing_wp_cron.dup(), rt.call_function('wp_unslash', [rt.get_superglobal('_SERVER').array_get('REQUEST_URI')])])])
		print(' ')
		rt.call_function('wp_ob_end_flush_all', []rt.PhpVal{})
		rt.call_function('flush', []rt.PhpVal{})
		rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-cron.php', '4')
		return true
	}
	var_doing_wp_cron = rt.call_function('sprintf', [rt.new_string('%.22F'), rt.new_int(gmt_time)])
	rt.call_function('set_transient', [rt.new_string('doing_cron'), var_doing_wp_cron.dup()])
	var_cron_request = rt.call_function('apply_filters', [rt.new_string('cron_request'), rt.create_array([rt.ArrayItem{ key: 'url', val: rt.call_function('add_query_arg', [rt.new_string('doing_wp_cron'), var_doing_wp_cron.dup(), rt.call_function('site_url', [rt.new_string('wp-cron.php')])]) }, rt.ArrayItem{ key: 'key', val: var_doing_wp_cron }, rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'timeout', val: 0.01 }, rt.ArrayItem{ key: 'blocking', val: false }, rt.ArrayItem{ key: 'sslverify', val: rt.call_function('apply_filters', [rt.new_string('https_local_ssl_verify'), rt.new_bool(false)]) }]) }]), var_doing_wp_cron.dup()])
	var_result = rt.call_function('wp_remote_post', [var_cron_request.array_get('url'), var_cron_request.array_get('args')])
	return !(rt.is_true(rt.call_function('is_wp_error', [var_result.dup()])))
}

fn wp_cron() {
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ALTERNATE_WP_CRON')])) && rt.is_true(rt.get_constant('ALTERNATE_WP_CRON')))) {
		if rt.is_true(rt.call_function('did_action', [rt.new_string('wp_loaded')])) {
			_wp_cron()
		} else {
			rt.call_function('add_action', [rt.new_string('wp_loaded'), rt.new_string('_wp_cron'), rt.new_int(20)])
		}
	} else if rt.is_true(rt.call_function('doing_action', [rt.new_string('shutdown')])) {
		_wp_cron()
	} else {
		rt.call_function('add_action', [rt.new_string('shutdown'), rt.new_string('_wp_cron')])
	}
}

fn _wp_cron() rt.PhpVal {
	mut var_crons := rt.new_null()
	mut var_gmt_time := rt.new_null()
	mut var_keys := rt.new_null()
	mut var_schedules := rt.new_null()
	mut var_results := rt.new_null()
	mut var_cronhooks := rt.new_null()
	mut var_timestamp := rt.new_null()
	mut var_args := rt.new_null()
	mut var_hook := rt.new_null()
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('str_contains', [rt.get_superglobal('_SERVER').array_get('REQUEST_URI'), rt.new_string('/wp-cron.php')])) || rt.is_true(rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('DISABLE_WP_CRON')])) && rt.is_true(rt.get_constant('DISABLE_WP_CRON')))))) {
		return rt.new_int(0)
	}
	var_crons = wp_get_ready_cron_jobs()
	if !rt.is_true(var_crons) {
		return rt.new_int(0)
	}
	var_gmt_time = rt.call_function('microtime', [rt.new_bool(true)])
	var_keys = rt.func_array_keys(var_crons.dup())
	if rt.is_true(rt.new_bool(var_keys.array_isset(rt.new_int(0)) && rt.is_true(rt.greater(var_keys.array_get(0), var_gmt_time)))) {
		return rt.new_int(0)
	}
	var_schedules = wp_get_schedules()
	var_results = rt.new_array()
	{
		mut iter_1 := var_crons.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_cronhooks_shadow := item_1.val
			mut var_timestamp_shadow := item_1.key
			if rt.is_true(rt.greater(var_timestamp_shadow, var_gmt_time)) {
				break
			}
			{
				mut iter_2 := rt.cast_array(var_cronhooks_shadow).iterator()
				for {
					item_2 := iter_2.next() or { break }
					mut var_args_shadow := item_2.val
					mut var_hook_shadow := item_2.key
					if rt.is_true(rt.new_bool(var_schedules.array_get(var_hook_shadow).array_isset(rt.new_string('callback')) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('call_user_func', [var_schedules.array_get(var_hook_shadow).array_get('callback')]))))))) {
						continue
					}
					var_results.array_push(spawn_cron(var_gmt_time.dup()))
					break
				}
			}
		}
	}
	if rt.is_true(rt.call_function('in_array', [rt.new_bool(false), var_results.dup(), rt.new_bool(true)])) {
		return rt.new_bool(false)
	}
	return rt.new_int(var_results.dup().array_count())
}

fn wp_get_schedules() rt.PhpVal {
	mut var_schedules := rt.new_null()
	var_schedules = rt.create_array([rt.ArrayItem{ key: 'hourly', val: rt.create_array([rt.ArrayItem{ key: 'interval', val: rt.get_constant('HOUR_IN_SECONDS') }, rt.ArrayItem{ key: 'display', val: rt.call_function('__', [rt.new_string('Once Hourly')]) }]) }, rt.ArrayItem{ key: 'twicedaily', val: rt.create_array([rt.ArrayItem{ key: 'interval', val: rt.mul(rt.new_int(12), rt.get_constant('HOUR_IN_SECONDS')) }, rt.ArrayItem{ key: 'display', val: rt.call_function('__', [rt.new_string('Twice Daily')]) }]) }, rt.ArrayItem{ key: 'daily', val: rt.create_array([rt.ArrayItem{ key: 'interval', val: rt.get_constant('DAY_IN_SECONDS') }, rt.ArrayItem{ key: 'display', val: rt.call_function('__', [rt.new_string('Once Daily')]) }]) }, rt.ArrayItem{ key: 'weekly', val: rt.create_array([rt.ArrayItem{ key: 'interval', val: rt.get_constant('WEEK_IN_SECONDS') }, rt.ArrayItem{ key: 'display', val: rt.call_function('__', [rt.new_string('Once Weekly')]) }]) }])
	return rt.call_function('array_merge', [rt.call_function('apply_filters', [rt.new_string('cron_schedules'), rt.new_array()]), var_schedules.dup()])
}

fn wp_get_schedule(var_hook rt.PhpVal, var_args rt.PhpVal) rt.PhpVal {
	mut var_schedule := rt.new_null()
	mut var_event := false
	var_schedule = rt.new_bool(false)
	var_event = wp_get_scheduled_event(var_hook.dup(), var_args.dup())
	if var_event {
		var_schedule = rt.get_property(rt.new_bool(var_event), 'schedule')
	}
	return rt.call_function('apply_filters', [rt.new_string('get_schedule'), var_schedule.dup(), var_hook.dup(), var_args.dup()])
}

fn wp_get_ready_cron_jobs() rt.PhpVal {
	mut var_pre := rt.new_null()
	mut var_crons := rt.new_null()
	mut var_gmt_time := rt.new_null()
	mut var_results := rt.new_null()
	mut var_cronhooks := rt.new_null()
	mut var_timestamp := rt.new_null()
	var_pre = rt.call_function('apply_filters', [rt.new_string('pre_get_ready_cron_jobs'), rt.new_null()])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_pre)))) {
		return var_pre.dup()
	}
	var_crons = _get_cron_array()
	var_gmt_time = rt.call_function('microtime', [rt.new_bool(true)])
	var_results = rt.new_array()
	{
		mut iter_1 := var_crons.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_cronhooks_shadow := item_1.val
			mut var_timestamp_shadow := item_1.key
			if rt.is_true(rt.greater(var_timestamp_shadow, var_gmt_time)) {
				break
			}
			var_results.array_set(var_timestamp_shadow, var_cronhooks_shadow.dup())
		}
	}
	return var_results.dup()
}

fn _get_cron_array() rt.PhpVal {
	mut var_cron := rt.new_null()
	var_cron = rt.call_function('get_option', [rt.new_string('cron')])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_cron.dup().is_array()))))) {
		return rt.new_array()
	}
	if !(var_cron.array_isset(rt.new_string('version'))) {
		var_cron = _upgrade_cron_array(var_cron.dup())
	}
	var_cron.array_unset(rt.new_string('version'))
	return var_cron.dup()
}

fn _set_cron_array(var_cron rt.PhpVal, wp_error bool) rt.PhpVal {
	mut var_result := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_cron.dup().is_array()))))) {
		var_cron = rt.new_array()
	}
	var_cron.array_set('version', 2)
	var_result = rt.call_function('update_option', [rt.new_string('cron'), var_cron.dup(), rt.new_bool(true)])
	if rt.is_true(rt.new_bool(var_wp_error && rt.is_true(rt.new_bool(!(rt.is_true(var_result)))))) {
		return create_wp_error(rt.new_string('could_not_set'), rt.call_function('__', [rt.new_string('The cron event list could not be saved.')]))
	}
	return var_result.dup()
}

fn _upgrade_cron_array(var_cron rt.PhpVal) rt.PhpVal {
	mut var_new_cron := rt.new_null()
	mut var_hooks := rt.new_null()
	mut var_timestamp := rt.new_null()
	mut var_args := rt.new_null()
	mut var_hook := rt.new_null()
	mut var_key := ''
	if rt.is_true(rt.new_bool(var_cron.array_isset(rt.new_string('version')) && rt.is_true(rt.identical(rt.new_int(2), var_cron.array_get('version'))))) {
		return var_cron.dup()
	}
	var_new_cron = rt.new_array()
	{
		mut iter_1 := rt.cast_array(var_cron).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_hooks_shadow := item_1.val
			mut var_timestamp_shadow := item_1.key
			{
				mut iter_2 := rt.cast_array(var_hooks_shadow).iterator()
				for {
					item_2 := iter_2.next() or { break }
					mut var_args_shadow := item_2.val
					mut var_hook_shadow := item_2.key
					var_key = md5.hexhash(rt.call_function('serialize', [var_args_shadow.array_get('args')]).to_string())
					var_new_cron.array_get_mut(var_timestamp_shadow).array_get_mut(var_hook_shadow).array_set(var_key, var_args_shadow.dup())
				}
			}
		}
	}
	var_new_cron.array_set('version', 2)
	rt.call_function('update_option', [rt.new_string('cron'), var_new_cron.dup(), rt.new_bool(true)])
	return var_new_cron.dup()
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

fn create_wp_error() &Class_WP_Error {
	mut obj := &Class_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Error) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Error) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Error) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_includes_cron_php() {
}
