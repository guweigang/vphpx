import rt

struct Class_ActionScheduler_FatalErrorMonitor {
	rt.PhpObjectBase
pub mut:
	claim     rt.PhpVal = rt.new_null()
	store     rt.PhpVal = rt.new_null()
	action_id rt.PhpVal = rt.new_int(0)
}

fn (mut this Class_ActionScheduler_FatalErrorMonitor) construct(mut var_store Class_ActionScheduler_Store) {
	this.store = var_store
}

fn (mut this Class_ActionScheduler_FatalErrorMonitor) attach(mut var_claim Class_ActionScheduler_ActionClaim) {
	this.claim = var_claim
	rt.call_function('add_action', [rt.new_string('shutdown'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('ActionScheduler_FatalErrorMonitor',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'handle_unexpected_shutdown' },
		])])
	rt.call_function('add_action', [rt.new_string('action_scheduler_before_execute'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('ActionScheduler_FatalErrorMonitor',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'track_current_action' },
		]),
		rt.new_int(0), rt.new_int(1)])
	rt.call_function('add_action', [rt.new_string('action_scheduler_after_execute'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('ActionScheduler_FatalErrorMonitor',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'untrack_action' },
		]),
		rt.new_int(0), rt.new_int(0)])
	rt.call_function('add_action', [rt.new_string('action_scheduler_execution_ignored'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('ActionScheduler_FatalErrorMonitor',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'untrack_action' },
		]),
		rt.new_int(0), rt.new_int(0)])
	rt.call_function('add_action', [rt.new_string('action_scheduler_failed_execution'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('ActionScheduler_FatalErrorMonitor',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'untrack_action' },
		]),
		rt.new_int(0), rt.new_int(0)])
}

fn (mut this Class_ActionScheduler_FatalErrorMonitor) detach() {
	this.claim = rt.new_null()
	this.untrack_action()
	rt.call_function('remove_action', [rt.new_string('shutdown'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('ActionScheduler_FatalErrorMonitor',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'handle_unexpected_shutdown' },
		])])
	rt.call_function('remove_action', [rt.new_string('action_scheduler_before_execute'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('ActionScheduler_FatalErrorMonitor',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'track_current_action' },
		]),
		rt.new_int(0)])
	rt.call_function('remove_action', [rt.new_string('action_scheduler_after_execute'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('ActionScheduler_FatalErrorMonitor',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'untrack_action' },
		]),
		rt.new_int(0)])
	rt.call_function('remove_action', [
		rt.new_string('action_scheduler_execution_ignored'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('ActionScheduler_FatalErrorMonitor',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'untrack_action' },
		]),
		rt.new_int(0),
	])
	rt.call_function('remove_action', [
		rt.new_string('action_scheduler_failed_execution'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('ActionScheduler_FatalErrorMonitor',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'untrack_action' },
		]),
		rt.new_int(0),
	])
}

fn (mut this Class_ActionScheduler_FatalErrorMonitor) track_current_action(var_action_id rt.PhpVal) {
	this.action_id = var_action_id.clone()
}

fn (mut this Class_ActionScheduler_FatalErrorMonitor) untrack_action() {
	this.action_id = rt.new_int(0)
}

fn (mut this Class_ActionScheduler_FatalErrorMonitor) handle_unexpected_shutdown() {
	mut var_error := rt.call_function('error_get_last', []rt.PhpVal{})
	if rt.is_true(var_error) {
		if rt.is_true(rt.call_function('in_array', [var_error.array_get(rt.new_string('type')),
			rt.create_array([rt.ArrayItem{ key: none, val: rt.get_constant('E_ERROR') },
				rt.ArrayItem{ key: none, val: rt.get_constant('E_PARSE') },
				rt.ArrayItem{ key: none, val: rt.get_constant('E_COMPILE_ERROR') },
				rt.ArrayItem{ key: none, val: rt.get_constant('E_USER_ERROR') },
				rt.ArrayItem{ key: none, val: rt.get_constant('E_RECOVERABLE_ERROR') }]),
			rt.new_bool(true)]))
		{
			if !(!rt.is_true(this.action_id)) {
				rt.call_method(this.store, 'mark_failure', [this.action_id])
				rt.call_function('do_action', [
					rt.new_string('action_scheduler_unexpected_shutdown'),
					this.action_id,
					var_error.clone(),
				])
			}
		}
		rt.call_method(this.store, 'release_claim', [this.claim])
	}
}

fn create_actionscheduler_fatalerrormonitor(arg_0 rt.PhpVal) &Class_ActionScheduler_FatalErrorMonitor {
	mut obj := &Class_ActionScheduler_FatalErrorMonitor{
		PhpObjectBase: rt.PhpObjectBase{}
		claim:         rt.new_null()
		store:         rt.new_null()
		action_id:     rt.new_int(0)
	}
	obj.construct(arg_0)
	return obj
}

fn (mut this Class_ActionScheduler_FatalErrorMonitor) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_ActionScheduler_Store](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.construct(mut dispatch_arg_0)
			return rt.new_null()
		}
		'attach' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_ActionScheduler_ActionClaim](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.attach(mut dispatch_arg_0)
			return rt.new_null()
		}
		'detach' {
			this.detach()
			return rt.new_null()
		}
		'track_current_action' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.track_current_action(dispatch_arg_0)
			return rt.new_null()
		}
		'untrack_action' {
			this.untrack_action()
			return rt.new_null()
		}
		'handle_unexpected_shutdown' {
			this.handle_unexpected_shutdown()
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_ActionScheduler_FatalErrorMonitor) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'claim' { return this.claim }
		'store' { return this.store }
		'action_id' { return this.action_id }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_ActionScheduler_FatalErrorMonitor) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'claim' {
			this.claim = val
			return true
		}
		'store' {
			this.store = val
			return true
		}
		'action_id' {
			this.action_id = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn main() {
	defer {
		rt.shutdown()
	}
}
