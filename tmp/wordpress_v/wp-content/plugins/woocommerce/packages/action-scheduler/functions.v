import rt

fn as_enqueue_async_action(var_hook rt.PhpVal, var_args rt.PhpVal, group string, unique bool, priority i64) i64 {
	if rt.is_true(rt.new_bool(!(rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ActionScheduler{}; return temp.is_initialized(arg_0) }(rt.new_string(@FN)))))) {
		return 0
	}
	mut var_pre := rt.call_function('apply_filters', [rt.new_string('pre_as_enqueue_async_action'), rt.new_null(), var_hook.dup(), var_args.dup(), rt.new_string(group), rt.new_int(priority), rt.new_bool(unique)])
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return (if rt.is_true(rt.new_bool(var_pre.dup().is_long())) { var_pre } else { rt.new_int(0) }).to_i64()
	}
	return (rt.call_method(fn () rt.PhpVal { mut temp := Class_ActionScheduler{}; return temp.factory() }(), 'create', [rt.create_array([rt.ArrayItem{ key: 'type', val: 'async' }, rt.ArrayItem{ key: 'hook', val: var_hook }, rt.ArrayItem{ key: 'arguments', val: var_args }, rt.ArrayItem{ key: 'group', val: group }, rt.ArrayItem{ key: 'unique', val: unique }, rt.ArrayItem{ key: 'priority', val: priority }])])).to_i64()
}

fn as_schedule_single_action(var_timestamp rt.PhpVal, var_hook rt.PhpVal, var_args rt.PhpVal, group string, unique bool, priority i64) i64 {
	if rt.is_true(rt.new_bool(!(rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ActionScheduler{}; return temp.is_initialized(arg_0) }(rt.new_string(@FN)))))) {
		return 0
	}
	mut var_pre := rt.call_function('apply_filters', [rt.new_string('pre_as_schedule_single_action'), rt.new_null(), var_timestamp.dup(), var_hook.dup(), var_args.dup(), rt.new_string(group), rt.new_int(priority), rt.new_bool(unique)])
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return (if rt.is_true(rt.new_bool(var_pre.dup().is_long())) { var_pre } else { rt.new_int(0) }).to_i64()
	}
	return (rt.call_method(fn () rt.PhpVal { mut temp := Class_ActionScheduler{}; return temp.factory() }(), 'create', [rt.create_array([rt.ArrayItem{ key: 'type', val: 'single' }, rt.ArrayItem{ key: 'hook', val: var_hook }, rt.ArrayItem{ key: 'arguments', val: var_args }, rt.ArrayItem{ key: 'when', val: var_timestamp }, rt.ArrayItem{ key: 'group', val: group }, rt.ArrayItem{ key: 'unique', val: unique }, rt.ArrayItem{ key: 'priority', val: priority }])])).to_i64()
}

fn as_schedule_recurring_action(var_timestamp rt.PhpVal, var_interval_in_seconds rt.PhpVal, var_hook rt.PhpVal, var_args rt.PhpVal, group string, unique bool, priority i64) i64 {
	if rt.is_true(rt.new_bool(!(rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ActionScheduler{}; return temp.is_initialized(arg_0) }(rt.new_string(@FN)))))) {
		return 0
	}
	mut var_interval := // unsupported expression: Expr_Cast_Int
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_interval_in_seconds.dup().is_long() || var_interval_in_seconds.dup().is_double()))))) || rt.is_true(// unsupported expression: Expr_BinaryOp_NotEqual))) {
		rt.call_function('_doing_it_wrong', [rt.new_string(@METHOD), rt.call_function('sprintf', [rt.call_function('esc_html__', [rt.new_string('An integer was expected but "%1$s" (%2$s) was received.'), rt.new_string('woocommerce')]), rt.call_function('esc_html', [var_interval_in_seconds.dup()]), rt.call_function('esc_html', [rt.call_function('gettype', [var_interval_in_seconds.dup()])])]), rt.new_string('3.6.0')])
		return 0
	}
	mut var_pre := rt.call_function('apply_filters', [rt.new_string('pre_as_schedule_recurring_action'), rt.new_null(), var_timestamp.dup(), var_interval_in_seconds.dup(), var_hook.dup(), var_args.dup(), rt.new_string(group), rt.new_int(priority), rt.new_bool(unique)])
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return (if rt.is_true(rt.new_bool(var_pre.dup().is_long())) { var_pre } else { rt.new_int(0) }).to_i64()
	}
	return (rt.call_method(fn () rt.PhpVal { mut temp := Class_ActionScheduler{}; return temp.factory() }(), 'create', [rt.create_array([rt.ArrayItem{ key: 'type', val: 'recurring' }, rt.ArrayItem{ key: 'hook', val: var_hook }, rt.ArrayItem{ key: 'arguments', val: var_args }, rt.ArrayItem{ key: 'when', val: var_timestamp }, rt.ArrayItem{ key: 'pattern', val: var_interval_in_seconds }, rt.ArrayItem{ key: 'group', val: group }, rt.ArrayItem{ key: 'unique', val: unique }, rt.ArrayItem{ key: 'priority', val: priority }])])).to_i64()
}

fn as_schedule_cron_action(var_timestamp rt.PhpVal, var_schedule rt.PhpVal, var_hook rt.PhpVal, var_args rt.PhpVal, group string, unique bool, priority i64) i64 {
	if rt.is_true(rt.new_bool(!(rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ActionScheduler{}; return temp.is_initialized(arg_0) }(rt.new_string(@FN)))))) {
		return 0
	}
	mut var_pre := rt.call_function('apply_filters', [rt.new_string('pre_as_schedule_cron_action'), rt.new_null(), var_timestamp.dup(), var_schedule.dup(), var_hook.dup(), var_args.dup(), rt.new_string(group), rt.new_int(priority), rt.new_bool(unique)])
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return (if rt.is_true(rt.new_bool(var_pre.dup().is_long())) { var_pre } else { rt.new_int(0) }).to_i64()
	}
	return (rt.call_method(fn () rt.PhpVal { mut temp := Class_ActionScheduler{}; return temp.factory() }(), 'create', [rt.create_array([rt.ArrayItem{ key: 'type', val: 'cron' }, rt.ArrayItem{ key: 'hook', val: var_hook }, rt.ArrayItem{ key: 'arguments', val: var_args }, rt.ArrayItem{ key: 'when', val: var_timestamp }, rt.ArrayItem{ key: 'pattern', val: var_schedule }, rt.ArrayItem{ key: 'group', val: group }, rt.ArrayItem{ key: 'unique', val: unique }, rt.ArrayItem{ key: 'priority', val: priority }])])).to_i64()
}

fn as_unschedule_action(var_hook rt.PhpVal, var_args rt.PhpVal, group string) i64 {
	if rt.is_true(rt.new_bool(!(rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ActionScheduler{}; return temp.is_initialized(arg_0) }(rt.new_string(@FN)))))) {
		return 0
	}
	mut var_params := { 'hook': var_hook, 'status': Class_ActionScheduler_Store.status_pending(), 'orderby': rt.new_string('date'), 'order': rt.new_string('ASC'), 'group': rt.new_string(group) }
	if rt.is_true(rt.new_bool(var_args.dup().is_array())) {
		var_params['args'] = var_args.dup()
	}
	mut var_action_id := rt.call_method(fn () rt.PhpVal { mut temp := Class_ActionScheduler{}; return temp.store() }(), 'query_action', [var_params.dup()])
	if rt.is_true(var_action_id) {
		rt.call_method(fn () rt.PhpVal { mut temp := Class_ActionScheduler{}; return temp.store() }(), 'cancel_action', [var_action_id.dup()])
		if rt.has_exception() { unsafe { goto catch_label_1 } }
		unsafe { goto end_label_1 }

catch_label_1:
		mut var_e_1 := rt.get_and_clear_exception()
		if rt.instance_of(var_e_1, 'Exception') {
			mut var_exception := var_e_1.dup()
			rt.call_method(fn () rt.PhpVal { mut temp := Class_ActionScheduler{}; return temp.logger() }(), 'log', [var_action_id.dup(), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Caught exception while cancelling action "%1$s": %2$s'), rt.new_string('woocommerce')]), var_hook.dup(), rt.call_method(var_exception, 'getMessage', []rt.PhpVal{})])])
			var_action_id = rt.new_null()
			unsafe { goto end_label_1 }
		}
		else {
			rt.throw_exception(var_e_1)
			unsafe { goto end_label_1 }
		}

end_label_1:
	}
	return (var_action_id).to_i64()
}

fn as_unschedule_all_actions(var_hook rt.PhpVal, var_args rt.PhpVal, group string) {
	if rt.is_true(rt.new_bool(!(rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ActionScheduler{}; return temp.is_initialized(arg_0) }(rt.new_string(@FN)))))) {
		return rt.new_null()
	}
	if !rt.is_true(var_args) {
		if !(!rt.is_true(var_hook)) && group == '' {
			rt.call_method(fn () rt.PhpVal { mut temp := Class_ActionScheduler_Store{}; return temp.instance() }(), 'cancel_actions_by_hook', [var_hook.dup()])
			return rt.new_null()
		}
		if !(group == '') && !rt.is_true(var_hook) {
			rt.call_method(fn () rt.PhpVal { mut temp := Class_ActionScheduler_Store{}; return temp.instance() }(), 'cancel_actions_by_group', [rt.new_string(group)])
			return rt.new_null()
		}
	}
	for {
		mut var_unscheduled_action := as_unschedule_action(var_hook.dup(), var_args.dup(), group)
		if !(!(var_unscheduled_action == 0)) {
			break
		}
	}
}

fn as_next_scheduled_action(var_hook rt.PhpVal, var_args rt.PhpVal, group string) bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ActionScheduler{}; return temp.is_initialized(arg_0) }(rt.new_string(@FN)))))) {
		return false
	}
	mut var_params := { 'hook': var_hook, 'orderby': rt.new_string('date'), 'order': rt.new_string('ASC'), 'group': rt.new_string(group) }
	if rt.is_true(rt.new_bool(var_args.dup().is_array())) {
		var_params['args'] = var_args.dup()
	}
	var_params['status'] = Class_ActionScheduler_Store.status_running()
	mut var_action_id := rt.call_method(fn () rt.PhpVal { mut temp := Class_ActionScheduler{}; return temp.store() }(), 'query_action', [var_params.dup()])
	if rt.is_true(var_action_id) {
		return true
	}
	var_params['status'] = Class_ActionScheduler_Store.status_pending()
	var_action_id = rt.call_method(fn () rt.PhpVal { mut temp := Class_ActionScheduler{}; return temp.store() }(), 'query_action', [var_params.dup()])
	if rt.is_true(rt.identical(rt.new_null(), var_action_id)) {
		return false
	}
	mut var_action := rt.call_method(fn () rt.PhpVal { mut temp := Class_ActionScheduler{}; return temp.store() }(), 'fetch_action', [var_action_id.dup()])
	mut var_scheduled_date := rt.call_method(rt.call_method(var_action, 'get_schedule', []rt.PhpVal{}), 'get_date', []rt.PhpVal{})
	if rt.is_true(var_scheduled_date) {
		return (// unsupported expression: Expr_Cast_Int).to_bool()
	} else if rt.is_true(rt.identical(rt.new_null(), var_scheduled_date)) {
		return true
	}
	return false
}

fn as_has_scheduled_action(var_hook rt.PhpVal, var_args rt.PhpVal, group string) bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ActionScheduler{}; return temp.is_initialized(arg_0) }(rt.new_string(@FN)))))) {
		return false
	}
	mut var_query_args := { 'hook': var_hook, 'status': map[string]rt.PhpVal{}, 'group': rt.new_string(group), 'orderby': rt.new_string('none') }
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		var_query_args['args'] = var_args.dup()
	}
	mut var_action_id := rt.call_method(fn () rt.PhpVal { mut temp := Class_ActionScheduler{}; return temp.store() }(), 'query_action', [var_query_args.dup()])
	return (// unsupported expression: Expr_BinaryOp_NotIdentical).to_bool()
}

fn as_get_scheduled_actions(var_args rt.PhpVal, var_return_format rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ActionScheduler{}; return temp.is_initialized(arg_0) }(rt.new_string(@FN)))))) {
		return rt.new_array()
	}
	mut var_store := fn () rt.PhpVal { mut temp := Class_ActionScheduler{}; return temp.store() }()
	{
		mut iter_1 := rt.create_array([rt.ArrayItem{ key: none, val: 'date' }, rt.ArrayItem{ key: none, val: 'modified' }]).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_key := item_1.val
			if var_args.array_isset(var_key) {
				var_args.array_set(var_key, as_get_datetime_object(var_args.array_get(var_key), ''))
			}
		}
	}
	mut var_ids := rt.call_method(var_store, 'query_actions', [var_args.dup()])
	if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('ids'), var_return_format)) || rt.is_true(rt.identical(rt.new_string('int'), var_return_format)))) {
		return var_ids.dup()
	}
	mut var_actions := rt.new_array()
	{
		mut iter_1 := var_ids.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_action_id := item_1.val
			var_actions.array_set(var_action_id, rt.call_method(var_store, 'fetch_action', [var_action_id.dup()]))
		}
	}
	if rt.is_true(rt.identical(rt.get_constant('ARRAY_A'), var_return_format)) {
		{
			mut iter_1 := var_actions.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_action_object := item_1.val
				mut var_action_id := item_1.key
				var_actions.array_set(var_action_id, rt.call_function('get_object_vars', [var_action_object.dup()]))
			}
		}
	}
	return var_actions.dup()
}

fn as_get_datetime_object(var_date_string rt.PhpVal, timezone string) rt.PhpVal {
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_date_string.dup().is_object())) && rt.is_true(rt.new_bool(rt.instance_of(var_date_string, 'DateTime'))))) {
		mut var_date := create_actionscheduler_datetime(rt.call_method(var_date_string, 'format', [rt.new_string('Y-m-d H:i:s')]), create_datetimezone(rt.new_string(timezone).dup()))
	} else if rt.is_true(rt.new_bool(var_date_string.dup().is_long() || var_date_string.dup().is_double())) {
		var_date = create_actionscheduler_datetime('@' + (var_date_string).str(), create_datetimezone(rt.new_string(timezone).dup()))
	} else {
		var_date = create_actionscheduler_datetime(if rt.is_true(rt.identical(rt.new_null(), var_date_string)) { rt.new_string('now') } else { var_date_string }, create_datetimezone(rt.new_string(timezone).dup()))
	}
	return mut var_date
}

fn as_supports(feature string) bool {
	mut var_supported_features := ['ensure_recurring_actions_hook']
	return (rt.call_function('in_array', [rt.new_string(feature), var_supported_features.dup(), rt.new_bool(true)])).to_bool()
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

fn create_actionscheduler() &Class_ActionScheduler {
	mut obj := &Class_ActionScheduler{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_actionscheduler_store() &Class_ActionScheduler_Store {
	mut obj := &Class_ActionScheduler_Store{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_actionscheduler_datetime() &Class_ActionScheduler_DateTime {
	mut obj := &Class_ActionScheduler_DateTime{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_datetimezone() &Class_DateTimeZone {
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




pub fn init_wp_content_plugins_woocommerce_packages_action_scheduler_functions_php() {
}
