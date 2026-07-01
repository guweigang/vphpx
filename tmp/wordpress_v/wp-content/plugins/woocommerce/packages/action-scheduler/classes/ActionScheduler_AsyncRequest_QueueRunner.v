import rt

struct Class_ActionScheduler_AsyncRequest_QueueRunner {
	rt.PhpObjectBase
pub mut:
		store rt.PhpVal = rt.new_null()
		prefix rt.PhpVal = rt.new_string('as')
		action rt.PhpVal = rt.new_string('async_request_queue_runner')
}

fn (mut this Class_ActionScheduler_AsyncRequest_QueueRunner) construct(mut var_store Class_ActionScheduler_Store)  {
	this.Class_WP_Async_Request.construct()
	this.store = var_store.dup()
}

fn (mut this Class_ActionScheduler_AsyncRequest_QueueRunner) handle()  {
	rt.call_function('do_action', [rt.new_string('action_scheduler_run_queue'), rt.new_string('Async Request')])
	mut var_sleep_seconds := this.get_sleep_seconds()
	if rt.is_true(var_sleep_seconds) {
		rt.call_function('sleep', [var_sleep_seconds.dup()])
	}
	this.maybe_dispatch()
}

fn (mut this Class_ActionScheduler_AsyncRequest_QueueRunner) maybe_dispatch()  {
	if rt.is_true(rt.new_bool(!(rt.is_true(this.allow())))) {
		return rt.new_null()
	}
	this.dispatch()
	rt.call_method(fn () rt.PhpVal { mut temp := Class_ActionScheduler_QueueRunner{}; return temp.instance() }(), 'unhook_dispatch_async_request', []rt.PhpVal{})
}

fn (mut this Class_ActionScheduler_AsyncRequest_QueueRunner) allow() rt.PhpVal {
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('has_action', [rt.new_string('action_scheduler_run_queue')]))))) || rt.is_true(rt.call_method(fn () rt.PhpVal { mut temp := Class_ActionScheduler{}; return temp.runner() }(), 'has_maximum_concurrent_batches', []rt.PhpVal{})))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(this.store, 'has_pending_actions_due', []rt.PhpVal{}))))))) {
		mut var_allow := rt.new_bool(rt.new_bool(false))
	} else {
		var_allow = rt.new_bool(rt.new_bool(true))
	}
	return rt.call_function('apply_filters', [rt.new_string('action_scheduler_allow_async_request_runner'), var_allow.dup()])
}

fn (mut this Class_ActionScheduler_AsyncRequest_QueueRunner) get_sleep_seconds() rt.PhpVal {
	return rt.call_function('apply_filters', [rt.new_string('action_scheduler_async_request_sleep_seconds'), rt.new_int(5), rt.new_object('ActionScheduler_AsyncRequest_QueueRunner', ['WP_Async_Request'], &this)])
}

struct Class_WP_Async_Request {
	rt.PhpObjectBase
}

struct Class_ActionScheduler_QueueRunner {
	rt.PhpObjectBase
}

struct Class_ActionScheduler {
	rt.PhpObjectBase
}

fn create_actionscheduler_asyncrequest_queuerunner(arg_0 rt.PhpVal) &Class_ActionScheduler_AsyncRequest_QueueRunner {
	mut obj := &Class_ActionScheduler_AsyncRequest_QueueRunner{
		PhpObjectBase: rt.PhpObjectBase{}
		store: rt.new_null()
		prefix: rt.new_string('as')
		action: rt.new_string('async_request_queue_runner')
	}
	obj.construct(arg_0)
	return obj
}

fn create_wp_async_request() &Class_WP_Async_Request {
	mut obj := &Class_WP_Async_Request{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_actionscheduler_queuerunner() &Class_ActionScheduler_QueueRunner {
	mut obj := &Class_ActionScheduler_QueueRunner{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_actionscheduler() &Class_ActionScheduler {
	mut obj := &Class_ActionScheduler{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_ActionScheduler_AsyncRequest_QueueRunner) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_ActionScheduler_Store](if args.len > 0 { args[0] } else { rt.new_null() })
			this.construct(mut dispatch_arg_0)
			return rt.new_null()
		}
		'handle' {
			this.handle()
			return rt.new_null()
		}
		'maybe_dispatch' {
			this.maybe_dispatch()
			return rt.new_null()
		}
		'allow' {
			return this.allow()
		}
		'get_sleep_seconds' {
			return this.get_sleep_seconds()
		}
		else { return none }
	}
}

fn (this &Class_ActionScheduler_AsyncRequest_QueueRunner) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'store' { return this.store }
		'prefix' { return this.prefix }
		'action' { return this.action }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_ActionScheduler_AsyncRequest_QueueRunner) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'store' { this.store = val; return true }
		'prefix' { this.prefix = val; return true }
		'action' { this.action = val; return true }
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


fn (mut this Class_ActionScheduler_QueueRunner) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ActionScheduler_QueueRunner) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ActionScheduler_QueueRunner) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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




pub fn init_wp_content_plugins_woocommerce_packages_action_scheduler_classes_actionscheduler_asyncrequest_queuerunner_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
