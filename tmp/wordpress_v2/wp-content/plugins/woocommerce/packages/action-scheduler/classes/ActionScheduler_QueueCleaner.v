import rt

struct Class_ActionScheduler_QueueCleaner {
	rt.PhpObjectBase
pub mut:
		batch_size rt.PhpVal = rt.new_null()
		store rt.PhpVal = rt.new_null()
		month_in_seconds rt.PhpVal = rt.new_int(2678400)
		default_statuses_to_purge rt.PhpVal = rt.new_array()
}

fn (mut this Class_ActionScheduler_QueueCleaner) construct(mut var_store Class_?ActionScheduler_Store, batch_size i64) {
	mut batch_size_mutated := batch_size
	mut iife_temp_0 := Class_ActionScheduler_Store{}
	mut iife_result_0 := iife_temp_0.instance()
	this.store = if rt.is_true(var_store) { var_store } else { iife_result_0 }
	this.batch_size = rt.new_int(batch_size_mutated).clone()
}

fn (mut this Class_ActionScheduler_QueueCleaner) delete_old_actions() rt.PhpVal {
	mut var_lifespan := rt.call_function('apply_filters', [rt.new_string('action_scheduler_retention_period'), this.month_in_seconds])
	mut var_cutoff := rt.call_function('as_get_datetime_object', [rt.new_string((var_lifespan).str() + ' seconds ago')])
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	unsafe { goto end_label_1 }

catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'Exception') {
		mut var_e := var_e_1.clone()
		rt.call_function('_doing_it_wrong', [rt.new_string(@METHOD), rt.call_function('sprintf', [rt.call_function('esc_html__', [rt.new_string('It was not possible to determine a valid cut-off time: %s.'), rt.new_string('woocommerce')]), rt.call_function('esc_html', [rt.call_method(var_e, 'getMessage', []rt.PhpVal{})])]), rt.new_string('3.5.5')])
		return rt.new_array()
		unsafe { goto end_label_1 }
	}
	else {
		rt.throw_exception(var_e_1)
		unsafe { goto end_label_1 }
	}

end_label_1:
	mut var_statuses_to_purge := rt.cast_array(rt.call_function('apply_filters', [rt.new_string('action_scheduler_default_cleaner_statuses'), this.default_statuses_to_purge]))
	return this.clean_actions(mut rt.cast_object_ptr[Class_array](var_statuses_to_purge), mut rt.cast_object_ptr[Class_DateTime](var_cutoff), this.get_batch_size(), '')
}

fn (mut this Class_ActionScheduler_QueueCleaner) clean_actions(mut var_statuses_to_purge Class_array, mut var_cutoff_date Class_DateTime, var_batch_size rt.PhpVal, context string) rt.PhpVal {
	mut var_statuses_to_purge_mutated := var_statuses_to_purge
	mut var_batch_size_mutated := var_batch_size
	var_batch_size_mutated = if !(var_batch_size_mutated.clone().is_null()) { var_batch_size_mutated } else { this.batch_size }
	mut var_cutoff := if !(var_cutoff_date.is_null()) { var_cutoff_date } else { rt.call_function('as_get_datetime_object', [rt.new_string((this.month_in_seconds).str() + ' seconds ago')]) }
	mut var_lifespan := rt.sub(rt.call_function('time', []rt.PhpVal{}), rt.call_method(var_cutoff, 'getTimestamp', []rt.PhpVal{}))
	if !rt.is_true(var_statuses_to_purge_mutated) {
	var_statuses_to_purge_mutated = this.default_statuses_to_purge
	}
	mut var_deleted_actions := rt.new_array()
	mut iter_1 := var_statuses_to_purge_mutated.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_status := item_1.val
	mut var_actions_to_delete := rt.call_method(this.store, 'query_actions', [rt.create_array([rt.ArrayItem{ key: 'status', val: var_status }, rt.ArrayItem{ key: 'modified', val: var_cutoff }, rt.ArrayItem{ key: 'modified_compare', val: '<=' }, rt.ArrayItem{ key: 'per_page', val: var_batch_size_mutated }, rt.ArrayItem{ key: 'orderby', val: 'none' }])])
	var_deleted_actions = rt.call_function('array_merge', [var_deleted_actions.clone(), this.delete_actions(mut rt.cast_object_ptr[Class_array](var_actions_to_delete), var_lifespan.clone(), context)])
	}
	return var_deleted_actions.clone()
}

fn (mut this Class_ActionScheduler_QueueCleaner) delete_actions(mut var_actions_to_delete Class_array, var_lifespan rt.PhpVal, context string) rt.PhpVal {
	mut var_actions_to_delete_mutated := var_actions_to_delete
	mut var_lifespan_mutated := var_lifespan
	mut var_deleted_actions := rt.new_array()
	if rt.is_true(rt.new_bool(var_lifespan_mutated.clone().is_null())) {
	var_lifespan_mutated = this.month_in_seconds
	}
	mut iter_2 := var_actions_to_delete_mutated.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_action_id := item_2.val
		rt.call_method(this.store, 'delete_action', [var_action_id.clone()])
		if rt.has_exception() { unsafe { goto catch_label_2 } }
		var_deleted_actions.array_push(var_action_id.clone())
		if rt.has_exception() { unsafe { goto catch_label_2 } }
		unsafe { goto end_label_2 }

catch_label_2:
		mut var_e_2 := rt.get_and_clear_exception()
		if rt.instance_of(var_e_2, 'Exception') {
			mut var_e := var_e_2.clone()
			rt.call_function('do_action', [rt.new_string("action_scheduler_failed_${var_context}_action_deletion"), var_action_id.clone(), var_e.clone(), var_lifespan_mutated.clone(), rt.new_int(var_actions_to_delete_mutated.array_count())])
			unsafe { goto end_label_2 }
		}
		else {
			rt.throw_exception(var_e_2)
			unsafe { goto end_label_2 }
		}

end_label_2:
	}
	return var_deleted_actions.clone()
}

fn (mut this Class_ActionScheduler_QueueCleaner) reset_timeouts(time_limit i64) {
	mut var_timeout := rt.call_function('apply_filters', [rt.new_string('action_scheduler_timeout_period'), rt.new_int(time_limit)])
	if rt.is_true(rt.less(var_timeout, rt.new_int(0))) {
		return
	}
	mut var_cutoff := rt.call_function('as_get_datetime_object', [rt.new_string((var_timeout).str() + ' seconds ago')])
	mut var_actions_to_reset := rt.call_method(this.store, 'query_actions', [rt.create_array([rt.ArrayItem{ key: 'status', val: Class_ActionScheduler_Store.status_pending() }, rt.ArrayItem{ key: 'modified', val: var_cutoff }, rt.ArrayItem{ key: 'modified_compare', val: '<=' }, rt.ArrayItem{ key: 'claimed', val: true }, rt.ArrayItem{ key: 'per_page', val: this.get_batch_size() }, rt.ArrayItem{ key: 'orderby', val: 'none' }])])
	mut iter_3 := var_actions_to_reset.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_action_id := item_3.val
		rt.call_method(this.store, 'unclaim_action', [var_action_id.clone()])
		rt.call_function('do_action', [rt.new_string('action_scheduler_reset_action'), var_action_id.clone()])
	}
}

fn (mut this Class_ActionScheduler_QueueCleaner) mark_failures(time_limit i64) {
	mut var_timeout := rt.call_function('apply_filters', [rt.new_string('action_scheduler_failure_period'), rt.new_int(time_limit)])
	if rt.is_true(rt.less(var_timeout, rt.new_int(0))) {
		return
	}
	mut var_cutoff := rt.call_function('as_get_datetime_object', [rt.new_string((var_timeout).str() + ' seconds ago')])
	mut var_actions_to_reset := rt.call_method(this.store, 'query_actions', [rt.create_array([rt.ArrayItem{ key: 'status', val: Class_ActionScheduler_Store.status_running() }, rt.ArrayItem{ key: 'modified', val: var_cutoff }, rt.ArrayItem{ key: 'modified_compare', val: '<=' }, rt.ArrayItem{ key: 'per_page', val: this.get_batch_size() }, rt.ArrayItem{ key: 'orderby', val: 'none' }])])
	mut iter_4 := var_actions_to_reset.iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_action_id := item_4.val
		rt.call_method(this.store, 'mark_failure', [var_action_id.clone()])
		rt.call_function('do_action', [rt.new_string('action_scheduler_failed_action'), var_action_id.clone(), var_timeout.clone()])
	}
}

fn (mut this Class_ActionScheduler_QueueCleaner) clean(time_limit i64) {
	this.delete_old_actions()
	this.reset_timeouts(time_limit)
	this.mark_failures(time_limit)
}

fn (mut this Class_ActionScheduler_QueueCleaner) get_batch_size() rt.PhpVal {
	return rt.call_function('absint', [rt.call_function('apply_filters', [rt.new_string('action_scheduler_cleanup_batch_size'), this.batch_size])])
}

struct Class_ActionScheduler_Store {
	rt.PhpObjectBase
}

fn create_actionscheduler_queuecleaner(arg_0 rt.PhpVal, batch_size i64) &Class_ActionScheduler_QueueCleaner {
	mut obj := &Class_ActionScheduler_QueueCleaner{
		PhpObjectBase: rt.PhpObjectBase{}
		batch_size: rt.new_null()
		store: rt.new_null()
		month_in_seconds: rt.new_int(2678400)
		default_statuses_to_purge: rt.new_array()
	}
	obj.construct(arg_0, batch_size)
	return obj
}

fn create_actionscheduler_store(_args ...rt.PhpVal) &Class_ActionScheduler_Store {
	mut obj := &Class_ActionScheduler_Store{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_ActionScheduler_QueueCleaner) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_?ActionScheduler_Store](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			this.construct(mut dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'delete_old_actions' {
			return this.delete_old_actions()
		}
		'clean_actions' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_array](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_DateTime](if args.len > 1 { args[1] } else { rt.new_null() })
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).str()
			return this.clean_actions(mut dispatch_arg_0, mut dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
		}
		'delete_actions' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_array](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			return this.delete_actions(mut dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'reset_timeouts' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			this.reset_timeouts(dispatch_arg_0)
			return rt.new_null()
		}
		'mark_failures' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			this.mark_failures(dispatch_arg_0)
			return rt.new_null()
		}
		'clean' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			this.clean(dispatch_arg_0)
			return rt.new_null()
		}
		'get_batch_size' {
			return this.get_batch_size()
		}
		else { return none }
	}
}

fn (this &Class_ActionScheduler_QueueCleaner) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'batch_size' { return this.batch_size }
		'store' { return this.store }
		'month_in_seconds' { return this.month_in_seconds }
		'default_statuses_to_purge' { return this.default_statuses_to_purge }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_ActionScheduler_QueueCleaner) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'batch_size' { this.batch_size = val; return true }
		'store' { this.store = val; return true }
		'month_in_seconds' { this.month_in_seconds = val; return true }
		'default_statuses_to_purge' { this.default_statuses_to_purge = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
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



fn main() {
	defer {
		rt.shutdown()
	}

}
