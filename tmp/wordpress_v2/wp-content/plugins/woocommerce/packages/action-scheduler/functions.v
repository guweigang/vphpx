import rt

fn as_enqueue_async_action(var_hook rt.PhpVal, var_args rt.PhpVal, group string, unique bool, priority i64) i64 {
	mut var_group := group
	mut var_unique := unique
	mut var_priority := priority
	mut var_pre := rt.new_null()
	mut iife_temp_0 := Class_ActionScheduler{}
	mut iife_result_0 := iife_temp_0.is_initialized(rt.new_string(@FN))
	if rt.is_true(rt.new_bool(!(rt.is_true(iife_result_0)))) {
		return 0
	}
	var_pre = rt.call_function('apply_filters', [
		rt.new_string('pre_as_enqueue_async_action'),
		rt.new_null(),
		var_hook.clone(),
		var_args.clone(),
		rt.new_string(group),
		rt.new_int(priority),
		rt.new_bool(unique),
	])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_pre)))) {
		return (if var_pre.clone().is_long() {
			var_pre
		} else {
			rt.new_int(0)
		}).to_i64()
	}
	mut iife_temp_1 := Class_ActionScheduler{}
	mut iife_result_1 := iife_temp_1.factory()
	return (rt.call_method(iife_result_1, 'create', [
		rt.create_array([rt.ArrayItem{ key: 'type', val: 'async' },
			rt.ArrayItem{ key: 'hook', val: var_hook }, rt.ArrayItem{
				key: 'arguments'
				val: var_args
			}, rt.ArrayItem{ key: 'group', val: group }, rt.ArrayItem{ key: 'unique', val: unique },
			rt.ArrayItem{ key: 'priority', val: priority }]),
	])).to_i64()
}

fn as_schedule_single_action(var_timestamp rt.PhpVal, var_hook rt.PhpVal, var_args rt.PhpVal, group string, unique bool, priority i64) i64 {
	mut var_group := group
	mut var_unique := unique
	mut var_priority := priority
	mut var_pre := rt.new_null()
	mut iife_temp_2 := Class_ActionScheduler{}
	mut iife_result_2 := iife_temp_2.is_initialized(rt.new_string(@FN))
	if rt.is_true(rt.new_bool(!(rt.is_true(iife_result_2)))) {
		return 0
	}
	var_pre = rt.call_function('apply_filters', [
		rt.new_string('pre_as_schedule_single_action'),
		rt.new_null(),
		var_timestamp.clone(),
		var_hook.clone(),
		var_args.clone(),
		rt.new_string(group),
		rt.new_int(priority),
		rt.new_bool(unique),
	])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_pre)))) {
		return (if var_pre.clone().is_long() {
			var_pre
		} else {
			rt.new_int(0)
		}).to_i64()
	}
	mut iife_temp_3 := Class_ActionScheduler{}
	mut iife_result_3 := iife_temp_3.factory()
	return (rt.call_method(iife_result_3, 'create', [
		rt.create_array([rt.ArrayItem{ key: 'type', val: 'single' },
			rt.ArrayItem{ key: 'hook', val: var_hook }, rt.ArrayItem{
				key: 'arguments'
				val: var_args
			}, rt.ArrayItem{ key: 'when', val: var_timestamp },
			rt.ArrayItem{ key: 'group', val: group }, rt.ArrayItem{ key: 'unique', val: unique },
			rt.ArrayItem{ key: 'priority', val: priority }]),
	])).to_i64()
}

fn as_schedule_recurring_action(var_timestamp rt.PhpVal, var_interval_in_seconds rt.PhpVal, var_hook rt.PhpVal, var_args rt.PhpVal, group string, unique bool, priority i64) i64 {
	mut var_group := group
	mut var_unique := unique
	mut var_priority := priority
	mut var_interval := rt.new_null()
	mut var_pre := rt.new_null()
	mut iife_temp_4 := Class_ActionScheduler{}
	mut iife_result_4 := iife_temp_4.is_initialized(rt.new_string(@FN))
	if rt.is_true(rt.new_bool(!(rt.is_true(iife_result_4)))) {
		return 0
	}
	var_interval = rt.new_int(var_interval_in_seconds.to_i64())
	if !(var_interval_in_seconds.clone().is_long() || var_interval_in_seconds.clone().is_double())
		|| rt.is_true(rt.new_bool(!rt.is_true(rt.equal(var_interval_in_seconds, var_interval)))) {
		rt.call_function('_doing_it_wrong', [rt.new_string(@METHOD),
			rt.call_function('sprintf', [
				rt.call_function('esc_html__', [
					rt.new_string('An integer was expected but "%1$s" (%2$s) was received.'),
					rt.new_string('woocommerce'),
				]),
				rt.call_function('esc_html', [
					var_interval_in_seconds.clone(),
				]),
				rt.call_function('esc_html', [
					rt.call_function('gettype', [var_interval_in_seconds.clone()]),
				]),
			]),
			rt.new_string('3.6.0')])
		return 0
	}
	var_pre = rt.call_function('apply_filters', [
		rt.new_string('pre_as_schedule_recurring_action'),
		rt.new_null(),
		var_timestamp.clone(),
		var_interval_in_seconds.clone(),
		var_hook.clone(),
		var_args.clone(),
		rt.new_string(group),
		rt.new_int(priority),
		rt.new_bool(unique),
	])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_pre)))) {
		return (if var_pre.clone().is_long() {
			var_pre
		} else {
			rt.new_int(0)
		}).to_i64()
	}
	mut iife_temp_5 := Class_ActionScheduler{}
	mut iife_result_5 := iife_temp_5.factory()
	return (rt.call_method(iife_result_5, 'create', [
		rt.create_array([rt.ArrayItem{ key: 'type', val: 'recurring' },
			rt.ArrayItem{ key: 'hook', val: var_hook }, rt.ArrayItem{
				key: 'arguments'
				val: var_args
			}, rt.ArrayItem{ key: 'when', val: var_timestamp },
			rt.ArrayItem{ key: 'pattern', val: var_interval_in_seconds },
			rt.ArrayItem{ key: 'group', val: group }, rt.ArrayItem{ key: 'unique', val: unique },
			rt.ArrayItem{ key: 'priority', val: priority }]),
	])).to_i64()
}

fn as_schedule_cron_action(var_timestamp rt.PhpVal, var_schedule rt.PhpVal, var_hook rt.PhpVal, var_args rt.PhpVal, group string, unique bool, priority i64) i64 {
	mut var_group := group
	mut var_unique := unique
	mut var_priority := priority
	mut var_pre := rt.new_null()
	mut iife_temp_6 := Class_ActionScheduler{}
	mut iife_result_6 := iife_temp_6.is_initialized(rt.new_string(@FN))
	if rt.is_true(rt.new_bool(!(rt.is_true(iife_result_6)))) {
		return 0
	}
	var_pre = rt.call_function('apply_filters', [
		rt.new_string('pre_as_schedule_cron_action'),
		rt.new_null(),
		var_timestamp.clone(),
		var_schedule.clone(),
		var_hook.clone(),
		var_args.clone(),
		rt.new_string(group),
		rt.new_int(priority),
		rt.new_bool(unique),
	])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_pre)))) {
		return (if var_pre.clone().is_long() {
			var_pre
		} else {
			rt.new_int(0)
		}).to_i64()
	}
	mut iife_temp_7 := Class_ActionScheduler{}
	mut iife_result_7 := iife_temp_7.factory()
	return (rt.call_method(iife_result_7, 'create', [
		rt.create_array([rt.ArrayItem{ key: 'type', val: 'cron' },
			rt.ArrayItem{ key: 'hook', val: var_hook }, rt.ArrayItem{
				key: 'arguments'
				val: var_args
			}, rt.ArrayItem{ key: 'when', val: var_timestamp },
			rt.ArrayItem{ key: 'pattern', val: var_schedule },
			rt.ArrayItem{ key: 'group', val: group }, rt.ArrayItem{ key: 'unique', val: unique },
			rt.ArrayItem{ key: 'priority', val: priority }]),
	])).to_i64()
}

fn as_unschedule_action(var_hook rt.PhpVal, var_args rt.PhpVal, group string) i64 {
	mut var_group := group
	mut var_params := map[string]rt.PhpVal{}
	mut var_action_id := rt.new_null()
	mut var_exception := rt.new_null()
	mut iife_temp_8 := Class_ActionScheduler{}
	mut iife_result_8 := iife_temp_8.is_initialized(rt.new_string(@FN))
	if rt.is_true(rt.new_bool(!(rt.is_true(iife_result_8)))) {
		return 0
	}
	var_params = {
		'hook':    var_hook
		'status':  Class_ActionScheduler_Store.status_pending()
		'orderby': rt.new_string('date')
		'order':   rt.new_string('ASC')
		'group':   rt.new_string(group)
	}
	if rt.is_true(rt.new_bool(var_args.clone().is_array())) {
		var_params['args'] = var_args.clone()
	}
	mut iife_temp_9 := Class_ActionScheduler{}
	mut iife_result_9 := iife_temp_9.store()
	var_action_id = rt.call_method(iife_result_9, 'query_action', [
		rt.create_array_from_native_map(var_params),
	])
	if rt.is_true(var_action_id) {
		mut iife_temp_10 := Class_ActionScheduler{}
		mut iife_result_10 := iife_temp_10.store()
		rt.call_method(iife_result_10, 'cancel_action', [var_action_id.clone()])
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
		unsafe {
			goto end_label_1
		}
		catch_label_1:
		mut var_e_1 := rt.get_and_clear_exception()
		if rt.instance_of(var_e_1, 'Exception') {
			var_exception = var_e_1.clone()
			mut iife_temp_11 := Class_ActionScheduler{}
			mut iife_result_11 := iife_temp_11.logger()
			rt.call_method(iife_result_11, 'log', [var_action_id.clone(),
				rt.call_function('sprintf', [
					rt.call_function('__', [
						rt.new_string('Caught exception while cancelling action "%1$s": %2$s'),
						rt.new_string('woocommerce'),
					]),
					var_hook.clone(),
					rt.call_method(var_exception, 'getMessage', []rt.PhpVal{}),
				])])
			var_action_id = rt.new_null()
			unsafe {
				goto end_label_1
			}
		} else {
			rt.throw_exception(var_e_1)
			unsafe {
				goto end_label_1
			}
		}

		end_label_1:
	}
	return var_action_id.to_i64()
}

fn as_unschedule_all_actions(var_hook rt.PhpVal, var_args rt.PhpVal, group string) {
	mut var_group := group
	mut var_unscheduled_action := i64(0)
	mut iife_temp_12 := Class_ActionScheduler{}
	mut iife_result_12 := iife_temp_12.is_initialized(rt.new_string(@FN))
	if rt.is_true(rt.new_bool(!(rt.is_true(iife_result_12)))) {
		return
	}
	if !rt.is_true(var_args) {
		if !(!rt.is_true(var_hook)) && group == '' {
			mut iife_temp_13 := Class_ActionScheduler_Store{}
			mut iife_result_13 := iife_temp_13.instance()
			rt.call_method(iife_result_13, 'cancel_actions_by_hook', [
				var_hook.clone()])
			return
		}
		if !(group == '') && !rt.is_true(var_hook) {
			mut iife_temp_14 := Class_ActionScheduler_Store{}
			mut iife_result_14 := iife_temp_14.instance()
			rt.call_method(iife_result_14, 'cancel_actions_by_group', [
				rt.new_string(group),
			])
			return
		}
	}
	for {
		var_unscheduled_action = as_unschedule_action(var_hook.clone(), var_args.clone(), group)
		if !(!(var_unscheduled_action == 0)) {
			break
		}
	}
}

fn as_next_scheduled_action(var_hook rt.PhpVal, var_args rt.PhpVal, group string) rt.PhpVal {
	mut var_group := group
	mut var_params := map[string]rt.PhpVal{}
	mut var_action_id := rt.new_null()
	mut var_action := rt.new_null()
	mut var_scheduled_date := rt.new_null()
	mut iife_temp_15 := Class_ActionScheduler{}
	mut iife_result_15 := iife_temp_15.is_initialized(rt.new_string(@FN))
	if rt.is_true(rt.new_bool(!(rt.is_true(iife_result_15)))) {
		return rt.new_bool(false)
	}
	var_params = {
		'hook':    var_hook
		'orderby': rt.new_string('date')
		'order':   rt.new_string('ASC')
		'group':   rt.new_string(group)
	}
	if rt.is_true(rt.new_bool(var_args.clone().is_array())) {
		var_params['args'] = var_args.clone()
	}
	var_params['status'] = Class_ActionScheduler_Store.status_running()
	mut iife_temp_16 := Class_ActionScheduler{}
	mut iife_result_16 := iife_temp_16.store()
	var_action_id = rt.call_method(iife_result_16, 'query_action', [
		rt.create_array_from_native_map(var_params),
	])
	if rt.is_true(var_action_id) {
		return rt.new_bool(true)
	}
	var_params['status'] = Class_ActionScheduler_Store.status_pending()
	mut iife_temp_17 := Class_ActionScheduler{}
	mut iife_result_17 := iife_temp_17.store()
	var_action_id = rt.call_method(iife_result_17, 'query_action', [
		rt.create_array_from_native_map(var_params),
	])
	if rt.is_true(rt.identical(rt.new_null(), var_action_id)) {
		return rt.new_bool(false)
	}
	mut iife_temp_18 := Class_ActionScheduler{}
	mut iife_result_18 := iife_temp_18.store()
	var_action = rt.call_method(iife_result_18, 'fetch_action', [
		var_action_id.clone()])
	var_scheduled_date = rt.call_method(rt.call_method(var_action, 'get_schedule', []rt.PhpVal{}),
		'get_date', []rt.PhpVal{})
	if rt.is_true(var_scheduled_date) {
		return rt.new_int((rt.call_method(var_scheduled_date, 'format', [
			rt.new_string('U'),
		])).to_i64())
	} else if rt.is_true(rt.identical(rt.new_null(), var_scheduled_date)) {
		return rt.new_bool(true)
	}
	return rt.new_bool(false)
}

fn as_has_scheduled_action(var_hook rt.PhpVal, var_args rt.PhpVal, group string) bool {
	mut var_group := group
	mut var_query_args := map[string]rt.PhpVal{}
	mut var_action_id := rt.new_null()
	mut iife_temp_19 := Class_ActionScheduler{}
	mut iife_result_19 := iife_temp_19.is_initialized(rt.new_string(@FN))
	if rt.is_true(rt.new_bool(!(rt.is_true(iife_result_19)))) {
		return false
	}
	var_query_args = {
		'hook':    var_hook
		'status':  map[string]rt.PhpVal{}
		'group':   rt.new_string(group)
		'orderby': rt.new_string('none')
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_args)))) {
		var_query_args['args'] = var_args.clone()
	}
	mut iife_temp_20 := Class_ActionScheduler{}
	mut iife_result_20 := iife_temp_20.store()
	var_action_id = rt.call_method(iife_result_20, 'query_action', [
		rt.create_array_from_native_map(var_query_args),
	])
	return rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_action_id)))
}

fn as_get_scheduled_actions(var_args rt.PhpVal, var_return_format rt.PhpVal) rt.PhpVal {
	mut var_store := rt.new_null()
	mut var_key := rt.new_null()
	mut var_ids := rt.new_null()
	mut var_actions := rt.new_null()
	mut var_action_id := rt.new_null()
	mut var_action_object := rt.new_null()
	mut iife_temp_21 := Class_ActionScheduler{}
	mut iife_result_21 := iife_temp_21.is_initialized(rt.new_string(@FN))
	if rt.is_true(rt.new_bool(!(rt.is_true(iife_result_21)))) {
		return rt.new_array()
	}
	mut iife_temp_22 := Class_ActionScheduler{}
	mut iife_result_22 := iife_temp_22.store()
	var_store = iife_result_22
	mut iter_1 := rt.create_array([rt.ArrayItem{ key: none, val: 'date' },
		rt.ArrayItem{ key: none, val: 'modified' }]).iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_key_shadow := item_1.val
		if var_args.array_isset(var_key_shadow) {
			var_args.array_set(var_key_shadow, as_get_datetime_object(var_args.array_get(var_key_shadow),
				''))
		}
	}
	var_ids = rt.call_method(var_store, 'query_actions', [var_args.clone()])
	if rt.is_true(rt.identical(rt.new_string('ids'), var_return_format))
		|| rt.is_true(rt.identical(rt.new_string('int'), var_return_format)) {
		return var_ids.clone()
	}
	var_actions = rt.new_array()
	mut iter_2 := var_ids.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_action_id_shadow := item_2.val
		var_actions.array_set(var_action_id_shadow, rt.call_method(var_store, 'fetch_action', [
			var_action_id_shadow.clone(),
		]))
	}
	if rt.is_true(rt.identical(rt.get_constant('ARRAY_A'), var_return_format)) {
		mut iter_3 := var_actions.iterator()
		for {
			item_3 := iter_3.next() or { break }
			mut var_action_object_shadow := item_3.val
			mut var_action_id_shadow := item_3.key
			var_actions.array_set(var_action_id_shadow, rt.call_function('get_object_vars', [
				var_action_object_shadow.clone(),
			]))
		}
	}
	return var_actions.clone()
}

fn as_get_datetime_object(var_date_string rt.PhpVal, timezone string) rt.PhpVal {
	mut var_timezone := timezone
	mut var_date := rt.new_null()
	if var_date_string.clone().is_object()
		&& rt.is_true(rt.new_bool(rt.instance_of(var_date_string, 'DateTime'))) {
		var_date = create_actionscheduler_datetime(rt.call_method(var_date_string, 'format', [
			rt.new_string('Y-m-d H:i:s'),
		]), create_datetimezone(rt.new_string(timezone)))
	} else if rt.is_true(rt.new_bool(var_date_string.clone().is_long()
		|| var_date_string.clone().is_double()))
	{
		var_date = create_actionscheduler_datetime('@' + var_date_string.str(),
			create_datetimezone(rt.new_string(timezone)))
	} else {
		var_date = create_actionscheduler_datetime(if rt.is_true(rt.identical(rt.new_null(),
			var_date_string))
		{
			rt.new_string('now')
		} else {
			var_date_string
		}, create_datetimezone(rt.new_string(timezone)))
	}
	return mut var_date
}

fn as_supports(feature string) bool {
	mut var_feature := feature
	mut var_supported_features := []rt.PhpVal{}
	var_supported_features = ['ensure_recurring_actions_hook']
	return (rt.call_function('in_array', [rt.new_string(feature),
		rt.create_array_from_list(var_supported_features), rt.new_bool(true)])).to_bool()
}

struct Class_ActionScheduler {
	rt.PhpObjectBase
}

struct Class_ActionScheduler_Store {
	rt.PhpObjectBase
}

struct Class_ActionScheduler_DateTime {
	rt.PhpObjectBase
}

struct Class_DateTimeZone {
	rt.PhpObjectBase
}

fn create_actionscheduler(_args ...rt.PhpVal) &Class_ActionScheduler {
	mut obj := &Class_ActionScheduler{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_actionscheduler_store(_args ...rt.PhpVal) &Class_ActionScheduler_Store {
	mut obj := &Class_ActionScheduler_Store{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_actionscheduler_datetime(_args ...rt.PhpVal) &Class_ActionScheduler_DateTime {
	mut obj := &Class_ActionScheduler_DateTime{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_datetimezone(_args ...rt.PhpVal) &Class_DateTimeZone {
	mut obj := &Class_DateTimeZone{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
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

fn (mut this Class_ActionScheduler_Store) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ActionScheduler_Store) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ActionScheduler_Store) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_ActionScheduler_DateTime) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ActionScheduler_DateTime) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ActionScheduler_DateTime) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_DateTimeZone) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_DateTimeZone) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_DateTimeZone) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
