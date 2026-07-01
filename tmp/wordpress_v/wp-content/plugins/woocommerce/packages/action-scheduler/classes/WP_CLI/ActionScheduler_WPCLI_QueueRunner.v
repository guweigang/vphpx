import rt

struct Class_ActionScheduler_WPCLI_QueueRunner {
	rt.PhpObjectBase
pub mut:
		actions rt.PhpVal = rt.new_null()
		claim rt.PhpVal = rt.new_null()
		progress_bar rt.PhpVal = rt.new_null()
}

fn (mut this Class_ActionScheduler_WPCLI_QueueRunner) construct(mut var_store Class_?ActionScheduler_Store, mut var_monitor Class_?ActionScheduler_FatalErrorMonitor, mut var_cleaner Class_?ActionScheduler_QueueCleaner)  {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('WP_CLI')])) && rt.is_true(rt.get_constant('WP_CLI'))))))) {
		rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('The %s class can only be run within WP CLI.'), rt.new_string('woocommerce')]), rt.new_string(@STRUCT)]))))
	}
	this.Class_ActionScheduler_Abstract_QueueRunner.construct(rt.new_object('?ActionScheduler_Store', []string{}, var_store), rt.new_object('?ActionScheduler_FatalErrorMonitor', []string{}, var_monitor), rt.new_object('?ActionScheduler_QueueCleaner', []string{}, var_cleaner))
}

fn (mut this Class_ActionScheduler_WPCLI_QueueRunner) setup(var_batch_size rt.PhpVal, var_hooks rt.PhpVal, group string, force bool) i64 {
	this.run_cleanup()
	this.add_hooks()
	if rt.is_true(this.has_maximum_concurrent_batches()) {
		if var_force {
			fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WP_CLI{}; return temp.warning(arg_0) }(rt.call_function('__', [rt.new_string('There are too many concurrent batches, but the run is forced to continue.'), rt.new_string('woocommerce')]))
		} else {
			fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WP_CLI{}; return temp.error(arg_0) }(rt.call_function('__', [rt.new_string('There are too many concurrent batches.'), rt.new_string('woocommerce')]))
		}
	}
	this.claim = rt.call_method(rt.get_property(rt.new_object('ActionScheduler_WPCLI_QueueRunner', ['ActionScheduler_Abstract_QueueRunner'], &this), 'store'), 'stake_claim', [var_batch_size.dup(), rt.new_null(), var_hooks.dup(), rt.new_string(group)])
	rt.call_method(rt.get_property(rt.new_object('ActionScheduler_WPCLI_QueueRunner', ['ActionScheduler_Abstract_QueueRunner'], &this), 'monitor'), 'attach', [this.claim])
	this.actions = rt.call_method(this.claim, 'get_actions', []rt.PhpVal{})
	return this.actions.array_count()
}

fn (mut this Class_ActionScheduler_WPCLI_QueueRunner) add_hooks()  {
	rt.call_function('add_action', [rt.new_string('action_scheduler_before_execute'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('ActionScheduler_WPCLI_QueueRunner', ['ActionScheduler_Abstract_QueueRunner'], &this) }, rt.ArrayItem{ key: none, val: 'before_execute' }])])
	rt.call_function('add_action', [rt.new_string('action_scheduler_after_execute'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('ActionScheduler_WPCLI_QueueRunner', ['ActionScheduler_Abstract_QueueRunner'], &this) }, rt.ArrayItem{ key: none, val: 'after_execute' }]), rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_action', [rt.new_string('action_scheduler_failed_execution'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('ActionScheduler_WPCLI_QueueRunner', ['ActionScheduler_Abstract_QueueRunner'], &this) }, rt.ArrayItem{ key: none, val: 'action_failed' }]), rt.new_int(10), rt.new_int(2)])
}

fn (mut this Class_ActionScheduler_WPCLI_QueueRunner) setup_progress_bar()  {
	mut var_count := rt.new_int(rt.new_int(this.actions.array_count()))
	this.progress_bar = create_action_scheduler_wp_cli_progressbar(rt.call_function('sprintf', [rt.call_function('_n', [rt.new_string('Running %d action'), rt.new_string('Running %d actions'), var_count.dup(), rt.new_string('woocommerce')]), var_count.dup()]), var_count.dup())
}

fn (mut this Class_ActionScheduler_WPCLI_QueueRunner) run(context string) rt.PhpVal {
	rt.call_function('do_action', [rt.new_string('action_scheduler_before_process_queue')])
	this.setup_progress_bar()
	{
		mut iter_1 := this.actions.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_action_id := item_1.val
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_action_id.dup(), rt.call_method(rt.get_property(rt.new_object('ActionScheduler_WPCLI_QueueRunner', ['ActionScheduler_Abstract_QueueRunner'], &this), 'store'), 'find_actions_by_claim_id', [rt.call_method(this.claim, 'get_id', []rt.PhpVal{})]), rt.new_bool(true)]))))) {
				fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WP_CLI{}; return temp.warning(arg_0) }(rt.call_function('__', [rt.new_string('The claim has been lost. Aborting current batch.'), rt.new_string('woocommerce')]))
				break
			}
			this.process_action(var_action_id.dup(), rt.new_string(context))
			rt.call_method(this.progress_bar, 'tick', []rt.PhpVal{})
		}
	}
	mut var_completed := rt.call_method(this.progress_bar, 'current', []rt.PhpVal{})
	rt.call_method(this.progress_bar, 'finish', []rt.PhpVal{})
	rt.call_method(rt.get_property(rt.new_object('ActionScheduler_WPCLI_QueueRunner', ['ActionScheduler_Abstract_QueueRunner'], &this), 'store'), 'release_claim', [this.claim])
	rt.call_function('do_action', [rt.new_string('action_scheduler_after_process_queue')])
	return var_completed.dup()
}

fn (mut this Class_ActionScheduler_WPCLI_QueueRunner) before_execute(var_action_id rt.PhpVal)  {
	fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WP_CLI{}; return temp.log(arg_0) }(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Started processing action %s'), rt.new_string('woocommerce')]), var_action_id.dup()]))
}

fn (mut this Class_ActionScheduler_WPCLI_QueueRunner) after_execute(var_action_id rt.PhpVal, var_action rt.PhpVal)  {
	mut var_action_mutated := var_action
	if rt.is_true(rt.identical(rt.new_null(), var_action_mutated)) {
		var_action_mutated = rt.call_method(rt.get_property(rt.new_object('ActionScheduler_WPCLI_QueueRunner', ['ActionScheduler_Abstract_QueueRunner'], &this), 'store'), 'fetch_action', [var_action_id.dup()])
	}
	fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WP_CLI{}; return temp.log(arg_0) }(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Completed processing action %1$s with hook: %2$s'), rt.new_string('woocommerce')]), var_action_id.dup(), rt.call_method(var_action_mutated, 'get_hook', []rt.PhpVal{})]))
}

fn (mut this Class_ActionScheduler_WPCLI_QueueRunner) action_failed(var_action_id rt.PhpVal, var_exception rt.PhpVal)  {
	fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_WP_CLI{}; return temp.error(arg_0, arg_1) }(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Error processing action %1$s: %2$s'), rt.new_string('woocommerce')]), var_action_id.dup(), rt.call_method(var_exception, 'getMessage', []rt.PhpVal{})]), rt.new_bool(false))
}

fn (mut this Class_ActionScheduler_WPCLI_QueueRunner) stop_the_insanity(sleep_time i64)  {
	rt.call_function('_deprecated_function', [rt.new_string('ActionScheduler_WPCLI_QueueRunner::stop_the_insanity'), rt.new_string('3.0.0'), rt.new_string('ActionScheduler_DataController::free_memory')])
	fn () rt.PhpVal { mut temp := Class_ActionScheduler_DataController{}; return temp.free_memory() }()
}

fn (mut this Class_ActionScheduler_WPCLI_QueueRunner) maybe_stop_the_insanity()  {
	mut var_current_iteration := rt.new_int(rt.new_int(rt.new_string(rt.call_method(this.progress_bar, 'current', []rt.PhpVal{}).to_string().trim_space()).to_i64()))
	if rt.is_true(rt.identical(rt.new_int(0), rt.mod_(var_current_iteration, rt.new_int(50)))) {
		this.stop_the_insanity(0)
	}
}

struct Class_ActionScheduler_Abstract_QueueRunner {
	rt.PhpObjectBase
}

struct Class_Exception {
	rt.PhpObjectBase
pub mut:
		message string
		code i64
		file string
		line i64
}

fn (mut this Class_Exception) construct(var_message rt.PhpVal) {
	this.message = var_message.to_string()
}

fn (mut this Class_Exception) getmessage() string {
	return this.message
}

struct Class_WP_CLI {
	rt.PhpObjectBase
}

struct Class_Action_Scheduler_WP_CLI_ProgressBar {
	rt.PhpObjectBase
}

struct Class_ActionScheduler_DataController {
	rt.PhpObjectBase
}

fn create_actionscheduler_wpcli_queuerunner(arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) &Class_ActionScheduler_WPCLI_QueueRunner {
	mut obj := &Class_ActionScheduler_WPCLI_QueueRunner{
		PhpObjectBase: rt.PhpObjectBase{}
		actions: rt.new_null()
		claim: rt.new_null()
		progress_bar: rt.new_null()
	}
	obj.construct(arg_0, arg_1, arg_2)
	return obj
}

fn create_actionscheduler_abstract_queuerunner() &Class_ActionScheduler_Abstract_QueueRunner {
	mut obj := &Class_ActionScheduler_Abstract_QueueRunner{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_exception(arg_0 rt.PhpVal) &Class_Exception {
	mut obj := &Class_Exception{
		PhpObjectBase: rt.PhpObjectBase{}
		message: ''
		code: i64(0)
		file: ''
		line: i64(0)
	}
	obj.construct(arg_0)
	return obj
}

fn create_wp_cli() &Class_WP_CLI {
	mut obj := &Class_WP_CLI{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_action_scheduler_wp_cli_progressbar() &Class_Action_Scheduler_WP_CLI_ProgressBar {
	mut obj := &Class_Action_Scheduler_WP_CLI_ProgressBar{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_actionscheduler_datacontroller() &Class_ActionScheduler_DataController {
	mut obj := &Class_ActionScheduler_DataController{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_ActionScheduler_WPCLI_QueueRunner) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_?ActionScheduler_Store](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_?ActionScheduler_FatalErrorMonitor](if args.len > 1 { args[1] } else { rt.new_null() })
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_?ActionScheduler_QueueCleaner](if args.len > 2 { args[2] } else { rt.new_null() })
			this.construct(mut dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2)
			return rt.new_null()
		}
		'setup' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).to_bool()
			return rt.new_int(this.setup(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3))
		}
		'add_hooks' {
			this.add_hooks()
			return rt.new_null()
		}
		'setup_progress_bar' {
			this.setup_progress_bar()
			return rt.new_null()
		}
		'run' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.run(dispatch_arg_0)
		}
		'before_execute' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.before_execute(dispatch_arg_0)
			return rt.new_null()
		}
		'after_execute' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.after_execute(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'action_failed' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.action_failed(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'stop_the_insanity' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			this.stop_the_insanity(dispatch_arg_0)
			return rt.new_null()
		}
		'maybe_stop_the_insanity' {
			this.maybe_stop_the_insanity()
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_ActionScheduler_WPCLI_QueueRunner) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'actions' { return this.actions }
		'claim' { return this.claim }
		'progress_bar' { return this.progress_bar }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_ActionScheduler_WPCLI_QueueRunner) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'actions' { this.actions = val; return true }
		'claim' { this.claim = val; return true }
		'progress_bar' { this.progress_bar = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_ActionScheduler_Abstract_QueueRunner) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ActionScheduler_Abstract_QueueRunner) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ActionScheduler_Abstract_QueueRunner) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Exception) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'getMessage' {
			return rt.new_string(this.getmessage())
		}
		else { return none }
	}
}

fn (this &Class_Exception) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'message' { return rt.new_string(this.message) }
		'code' { return rt.new_int(this.code) }
		'file' { return rt.new_string(this.file) }
		'line' { return rt.new_int(this.line) }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Exception) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'message' { this.message = (val).str(); return true }
		'code' { this.code = (val).to_i64(); return true }
		'file' { this.file = (val).str(); return true }
		'line' { this.line = (val).to_i64(); return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_WP_CLI) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_CLI) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_CLI) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Action_Scheduler_WP_CLI_ProgressBar) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Action_Scheduler_WP_CLI_ProgressBar) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Action_Scheduler_WP_CLI_ProgressBar) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_ActionScheduler_DataController) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ActionScheduler_DataController) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ActionScheduler_DataController) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_packages_action_scheduler_classes_wp_cli_actionscheduler_wpcli_queuerunner_php() {
}
