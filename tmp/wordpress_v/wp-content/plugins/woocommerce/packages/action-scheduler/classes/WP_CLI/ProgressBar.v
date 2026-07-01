import rt

struct Class_Action_Scheduler_WP_CLI_ProgressBar {
	rt.PhpObjectBase
pub mut:
		total_ticks i64
		count rt.PhpVal = rt.new_null()
		interval rt.PhpVal = rt.new_null()
		message rt.PhpVal = rt.new_null()
		progress_bar rt.PhpVal = rt.new_null()
}

fn (mut this Class_Action_Scheduler_WP_CLI_ProgressBar) construct(var_message rt.PhpVal, var_count rt.PhpVal, interval i64)  {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('WP_CLI')])) && rt.is_true(rt.get_constant('WP_CLI'))))))) {
		rt.throw_exception(rt.new_object('Action_Scheduler_WP_CLI_Exception', []string{}, create_action_scheduler_wp_cli_exception(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('The %s class can only be run within WP CLI.'), rt.new_string('woocommerce')]), rt.new_string(@STRUCT)]))))
	}
	this.total_ticks = 0
	this.message = var_message.dup()
	this.count = var_count.dup()
	this.interval = rt.new_int(interval).dup()
}

fn (mut this Class_Action_Scheduler_WP_CLI_ProgressBar) tick()  {
	if rt.is_true(rt.identical(rt.new_null(), this.progress_bar)) {
		this.setup_progress_bar()
	}
	rt.call_method(this.progress_bar, 'tick', []rt.PhpVal{})
	rt.post_inc(this.total_ticks)
	rt.call_function('do_action', [rt.new_string('action_scheduler/progress_tick'), this.total_ticks])
	// unsupported statement: Stmt_Nop
}

fn (mut this Class_Action_Scheduler_WP_CLI_ProgressBar) current() rt.PhpVal {
	return if rt.is_true(this.progress_bar) { rt.call_method(this.progress_bar, 'current', []rt.PhpVal{}) } else { rt.new_int(0) }
}

fn (mut this Class_Action_Scheduler_WP_CLI_ProgressBar) finish()  {
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		rt.call_method(this.progress_bar, 'finish', []rt.PhpVal{})
	}
	this.progress_bar = rt.new_null()
}

fn (mut this Class_Action_Scheduler_WP_CLI_ProgressBar) set_message(var_message rt.PhpVal)  {
	this.message = var_message.dup()
}

fn (mut this Class_Action_Scheduler_WP_CLI_ProgressBar) set_count(var_count rt.PhpVal)  {
	this.count = var_count.dup()
	this.finish()
}

fn (mut this Class_Action_Scheduler_WP_CLI_ProgressBar) setup_progress_bar()  {
	this.progress_bar = rt.call_function('WP_CLI\Utils\make_progress_bar', [this.message, this.count, this.interval])
}

struct Class_Action_Scheduler_WP_CLI_Exception {
	rt.PhpObjectBase
}

fn create_action_scheduler_wp_cli_progressbar(interval i64, arg_1 rt.PhpVal, arg_2 rt.PhpVal) &Class_Action_Scheduler_WP_CLI_ProgressBar {
	mut obj := &Class_Action_Scheduler_WP_CLI_ProgressBar{
		PhpObjectBase: rt.PhpObjectBase{}
		total_ticks: i64(0)
		count: rt.new_null()
		interval: rt.new_null()
		message: rt.new_null()
		progress_bar: rt.new_null()
	}
	obj.construct(interval, arg_1, arg_2)
	return obj
}

fn create_action_scheduler_wp_cli_exception() &Class_Action_Scheduler_WP_CLI_Exception {
	mut obj := &Class_Action_Scheduler_WP_CLI_Exception{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Action_Scheduler_WP_CLI_ProgressBar) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_i64()
			this.construct(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'tick' {
			this.tick()
			return rt.new_null()
		}
		'current' {
			return this.current()
		}
		'finish' {
			this.finish()
			return rt.new_null()
		}
		'set_message' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_message(dispatch_arg_0)
			return rt.new_null()
		}
		'set_count' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_count(dispatch_arg_0)
			return rt.new_null()
		}
		'setup_progress_bar' {
			this.setup_progress_bar()
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_Action_Scheduler_WP_CLI_ProgressBar) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'total_ticks' { return rt.new_int(this.total_ticks) }
		'count' { return this.count }
		'interval' { return this.interval }
		'message' { return this.message }
		'progress_bar' { return this.progress_bar }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Action_Scheduler_WP_CLI_ProgressBar) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'total_ticks' { this.total_ticks = (val).to_i64(); return true }
		'count' { this.count = val; return true }
		'interval' { this.interval = val; return true }
		'message' { this.message = val; return true }
		'progress_bar' { this.progress_bar = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Action_Scheduler_WP_CLI_Exception) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Action_Scheduler_WP_CLI_Exception) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Action_Scheduler_WP_CLI_Exception) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_packages_action_scheduler_classes_wp_cli_progressbar_php() {
}
