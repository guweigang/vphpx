import rt

struct Class_WC_Background_Updater {
	rt.PhpObjectBase
}

fn (mut this Class_WC_Background_Updater) construct()  {
	this.dispatch_set_prop('prefix', 'wp_' + (rt.call_function('get_current_blog_id', []rt.PhpVal{})).str())
	this.dispatch_set_prop('action', rt.new_string('wc_updater'))
	this.Class_WC_Background_Process.construct()
}

fn (mut this Class_WC_Background_Updater) dispatch()  {
	mut var_dispatched := this.Class_WC_Background_Process.dispatch()
	mut var_logger := rt.call_function('wc_get_logger', []rt.PhpVal{})
	if rt.is_true(rt.call_function('is_wp_error', [var_dispatched.dup()])) {
		rt.call_method(var_logger, 'error', [rt.call_function('sprintf', [rt.new_string('Unable to dispatch WooCommerce updater: %s'), rt.call_method(var_dispatched, 'get_error_message', []rt.PhpVal{})]), rt.create_array([rt.ArrayItem{ key: 'source', val: 'wc_db_updates' }])])
	}
}

fn (mut this Class_WC_Background_Updater) handle_cron_healthcheck()  {
	if rt.is_true(this.is_process_running()) {
		return rt.new_null()
	}
	if rt.is_true(this.is_queue_empty()) {
		this.clear_scheduled_event()
		return rt.new_null()
	}
	this.handle()
}

fn (mut this Class_WC_Background_Updater) schedule_event()  {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_next_scheduled', [rt.get_property(rt.new_object('WC_Background_Updater', ['WC_Background_Process'], &this), 'cron_hook_identifier')]))))) {
		rt.call_function('wp_schedule_event', [rt.add(rt.call_function('time', []rt.PhpVal{}), rt.new_int(10)), rt.get_property(rt.new_object('WC_Background_Updater', ['WC_Background_Process'], &this), 'cron_interval_identifier'), rt.get_property(rt.new_object('WC_Background_Updater', ['WC_Background_Process'], &this), 'cron_hook_identifier')])
	}
}

fn (mut this Class_WC_Background_Updater) is_updating() rt.PhpVal {
	return rt.identical(rt.new_bool(false), this.is_queue_empty())
}

fn (mut this Class_WC_Background_Updater) task(var_callback rt.PhpVal) rt.PhpVal {
	rt.call_function('wc_maybe_define_constant', [rt.new_string('WC_UPDATING'), rt.new_bool(true)])
	mut var_logger := rt.call_function('wc_get_logger', []rt.PhpVal{})
	rt.include_file((rt.call_function('dirname', [rt.new_string(@FILE)])).str() + '/wc-update-functions.php', '2')
	mut var_result := rt.new_bool(rt.new_bool(false))
	if rt.is_true(rt.call_function('is_callable', [var_callback.dup()])) {
		rt.call_method(var_logger, 'info', [rt.call_function('sprintf', [rt.new_string('Running %s callback'), var_callback.dup()]), rt.create_array([rt.ArrayItem{ key: 'source', val: 'wc_db_updates' }])])
		var_result = // unsupported expression: Expr_Cast_Bool
		if rt.is_true(var_result) {
			rt.call_method(var_logger, 'info', [rt.call_function('sprintf', [rt.new_string('%s callback needs to run again'), var_callback.dup()]), rt.create_array([rt.ArrayItem{ key: 'source', val: 'wc_db_updates' }])])
		} else {
			rt.call_method(var_logger, 'info', [rt.call_function('sprintf', [rt.new_string('Finished running %s callback'), var_callback.dup()]), rt.create_array([rt.ArrayItem{ key: 'source', val: 'wc_db_updates' }])])
		}
	} else {
		rt.call_method(var_logger, 'notice', [rt.call_function('sprintf', [rt.new_string('Could not find %s callback'), var_callback.dup()]), rt.create_array([rt.ArrayItem{ key: 'source', val: 'wc_db_updates' }])])
	}
	return if rt.is_true(var_result) { var_callback } else { rt.new_bool(false) }
}

fn (mut this Class_WC_Background_Updater) complete()  {
	mut var_logger := rt.call_function('wc_get_logger', []rt.PhpVal{})
	rt.call_method(var_logger, 'info', [rt.new_string('Data update complete'), rt.create_array([rt.ArrayItem{ key: 'source', val: 'wc_db_updates' }])])
	fn () rt.PhpVal { mut temp := Class_WC_Install{}; return temp.update_db_version() }()
	this.Class_WC_Background_Process.complete()
}

fn (mut this Class_WC_Background_Updater) is_memory_exceeded() rt.PhpVal {
	return this.memory_exceeded()
}

struct Class_WC_Background_Process {
	rt.PhpObjectBase
}

struct Class_WC_Install {
	rt.PhpObjectBase
}

fn create_wc_background_updater() &Class_WC_Background_Updater {
	mut obj := &Class_WC_Background_Updater{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	obj.construct()
	return obj
}

fn create_wc_background_process() &Class_WC_Background_Process {
	mut obj := &Class_WC_Background_Process{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_install() &Class_WC_Install {
	mut obj := &Class_WC_Install{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Background_Updater) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'dispatch' {
			this.dispatch()
			return rt.new_null()
		}
		'handle_cron_healthcheck' {
			this.handle_cron_healthcheck()
			return rt.new_null()
		}
		'schedule_event' {
			this.schedule_event()
			return rt.new_null()
		}
		'is_updating' {
			return this.is_updating()
		}
		'task' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.task(dispatch_arg_0)
		}
		'complete' {
			this.complete()
			return rt.new_null()
		}
		'is_memory_exceeded' {
			return this.is_memory_exceeded()
		}
		else { return none }
	}
}

fn (this &Class_WC_Background_Updater) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Background_Updater) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_Background_Process) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Background_Process) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Background_Process) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_Install) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Install) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Install) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_includes_class_wc_background_updater_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [rt.new_string('WC_Background_Process'), rt.new_bool(false)]))))) {
		rt.include_file((rt.call_function('dirname', [rt.new_string(@FILE)])).str() + '/abstracts/class-wc-background-process.php', '2')
	}
}
