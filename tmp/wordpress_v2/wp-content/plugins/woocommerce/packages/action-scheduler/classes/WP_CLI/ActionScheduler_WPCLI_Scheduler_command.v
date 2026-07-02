import rt

struct Class_ActionScheduler_WPCLI_Scheduler_command {
	rt.PhpObjectBase
}

fn (mut this Class_ActionScheduler_WPCLI_Scheduler_command) fix_schema(var_args rt.PhpVal, var_assoc_args rt.PhpVal) {
	mut var_schema_classes := [Class_ActionScheduler_LoggerSchema.class(), Class_ActionScheduler_StoreSchema.class()]
	for var_classname in var_schema_classes {
		if rt.is_true(rt.call_function('is_subclass_of', [var_classname.clone(), Class_ActionScheduler_Abstract_Schema.class()])) {
			mut var_obj := rt.create_object_dynamically(var_classname, []rt.PhpVal{})
			rt.call_method(var_obj, 'init', []rt.PhpVal{})
			rt.call_method(var_obj, 'register_tables', [rt.new_bool(true)])
		mut iife_temp_0 := Class_WP_CLI{}
		mut iife_result_0 := iife_temp_0.success(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Registered schema for %s'), rt.new_string('woocommerce')]), var_classname.clone()]))
		}
	}
}

fn (mut this Class_ActionScheduler_WPCLI_Scheduler_command) run(var_args rt.PhpVal, var_assoc_args rt.PhpVal) {
	mut var_batch := rt.call_function('absint', [rt.call_function('WP_CLI\Utils\get_flag_value', [var_assoc_args.clone(), rt.new_string('batch-size'), rt.new_int(100)])])
	mut var_batches := rt.call_function('absint', [rt.call_function('WP_CLI\Utils\get_flag_value', [var_assoc_args.clone(), rt.new_string('batches'), rt.new_int(0)])])
	mut var_clean := rt.call_function('absint', [rt.call_function('WP_CLI\Utils\get_flag_value', [var_assoc_args.clone(), rt.new_string('cleanup-batch-size'), var_batch.clone()])])
	mut var_hooks := rt.call_function('explode', [rt.new_string(','), rt.call_function('WP_CLI\Utils\get_flag_value', [var_assoc_args.clone(), rt.new_string('hooks'), rt.new_string('')])])
	var_hooks = rt.call_function('array_filter', [rt.call_function('array_map', [rt.new_string('trim'), var_hooks.clone()])])
	mut var_group := rt.call_function('WP_CLI\Utils\get_flag_value', [var_assoc_args.clone(), rt.new_string('group'), rt.new_string('')])
	mut var_exclude_groups := rt.call_function('WP_CLI\Utils\get_flag_value', [var_assoc_args.clone(), rt.new_string('exclude-groups'), rt.new_string('')])
	mut var_free_on := rt.call_function('WP_CLI\Utils\get_flag_value', [var_assoc_args.clone(), rt.new_string('free-memory-on'), rt.new_int(50)])
	mut var_sleep := rt.call_function('WP_CLI\Utils\get_flag_value', [var_assoc_args.clone(), rt.new_string('pause'), rt.new_int(0)])
	mut var_force := rt.call_function('WP_CLI\Utils\get_flag_value', [var_assoc_args.clone(), rt.new_string('force'), rt.new_bool(false)])
	mut iife_temp_1 := Class_ActionScheduler_DataController{}
	mut iife_result_1 := iife_temp_1.set_free_ticks(var_free_on.clone())
	mut iife_temp_2 := Class_ActionScheduler_DataController{}
	mut iife_result_2 := iife_temp_2.set_sleep_time(var_sleep.clone())
	mut var_batches_completed := rt.new_int(0)
	mut var_actions_completed := rt.new_int(0)
	mut var_unlimited := rt.identical(rt.new_int(0), var_batches)
	mut iife_temp_3 := Class_ActionScheduler{}
	mut iife_result_3 := iife_temp_3.store()
	if rt.is_true(rt.call_function('is_callable', [rt.create_array([rt.ArrayItem{ key: none, val: iife_result_3 }, rt.ArrayItem{ key: none, val: 'set_claim_filter' }])])) {
		var_exclude_groups = this.parse_comma_separated_string(var_exclude_groups.clone())
		if !(!rt.is_true(var_exclude_groups)) {
			mut iife_temp_4 := Class_ActionScheduler{}
			mut iife_result_4 := iife_temp_4.store()
			rt.call_method(iife_result_4, 'set_claim_filter', [rt.new_string('exclude-groups'), var_exclude_groups.clone()])
		}
	}
	mut var_cleaner := create_actionscheduler_queuecleaner(rt.new_null(), var_clean.clone())
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	mut var_runner := create_actionscheduler_wpcli_queuerunner(rt.new_null(), rt.new_null(), var_cleaner)
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	mut var_total := var_runner.setup(var_batch.clone(), var_hooks.clone(), var_group.clone(), var_force.clone())
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	for rt.is_true(rt.greater(var_total, rt.new_int(0))) {
		this.print_total_actions(var_total.clone())
		if rt.has_exception() { unsafe { goto catch_label_1 } }
		var_actions_completed = rt.add(var_actions_completed, var_runner.run())
		if rt.has_exception() { unsafe { goto catch_label_1 } }
		rt.post_inc(var_batches_completed)
		if rt.has_exception() { unsafe { goto catch_label_1 } }
		var_total = if rt.is_true(var_unlimited) || rt.is_true(rt.less(var_batches_completed, var_batches)) { var_runner.setup(var_batch.clone(), var_hooks.clone(), var_group.clone(), var_force.clone()) } else { rt.new_int(0) }
		if rt.has_exception() { unsafe { goto catch_label_1 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	unsafe { goto end_label_1 }

catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'Exception') {
		mut var_e := var_e_1.clone()
		this.print_error(mut rt.cast_object_ptr[Class_Exception](var_e))
		unsafe { goto end_label_1 }
	}
	else {
		rt.throw_exception(var_e_1)
		unsafe { goto end_label_1 }
	}

end_label_1:
	this.print_total_batches(var_batches_completed.clone())
	this.print_success(var_actions_completed.clone())
}

fn (mut this Class_ActionScheduler_WPCLI_Scheduler_command) parse_comma_separated_string(var_string rt.PhpVal) rt.PhpVal {
	return rt.call_function('array_filter', [rt.call_function('str_getcsv', [var_string.clone()])])
}

fn (mut this Class_ActionScheduler_WPCLI_Scheduler_command) print_total_actions(var_total rt.PhpVal) {
	mut var_total_mutated := var_total
mut iife_temp_5 := Class_WP_CLI{}
mut iife_result_5 := iife_temp_5.log(rt.call_function('sprintf', [rt.call_function('_n', [rt.new_string('Found %d scheduled task'), rt.new_string('Found %d scheduled tasks'), var_total_mutated.clone(), rt.new_string('woocommerce')]), var_total_mutated.clone()]))
}

fn (mut this Class_ActionScheduler_WPCLI_Scheduler_command) print_total_batches(var_batches_completed rt.PhpVal) {
	mut var_batches_completed_mutated := var_batches_completed
mut iife_temp_6 := Class_WP_CLI{}
mut iife_result_6 := iife_temp_6.log(rt.call_function('sprintf', [rt.call_function('_n', [rt.new_string('%d batch executed.'), rt.new_string('%d batches executed.'), var_batches_completed_mutated.clone(), rt.new_string('woocommerce')]), var_batches_completed_mutated.clone()]))
}

fn (mut this Class_ActionScheduler_WPCLI_Scheduler_command) print_error(mut var_e Class_Exception) {
mut iife_temp_7 := Class_WP_CLI{}
mut iife_result_7 := iife_temp_7.error(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('There was an error running the action scheduler: %s'), rt.new_string('woocommerce')]), var_e.getmessage()]))
}

fn (mut this Class_ActionScheduler_WPCLI_Scheduler_command) print_success(var_actions_completed rt.PhpVal) {
	mut var_actions_completed_mutated := var_actions_completed
mut iife_temp_8 := Class_WP_CLI{}
mut iife_result_8 := iife_temp_8.success(rt.call_function('sprintf', [rt.call_function('_n', [rt.new_string('%d scheduled task completed.'), rt.new_string('%d scheduled tasks completed.'), var_actions_completed_mutated.clone(), rt.new_string('woocommerce')]), var_actions_completed_mutated.clone()]))
}

struct Class_WP_CLI_Command {
	rt.PhpObjectBase
}

struct Class_WP_CLI {
	rt.PhpObjectBase
}

struct Class_ActionScheduler_DataController {
	rt.PhpObjectBase
}

struct Class_ActionScheduler {
	rt.PhpObjectBase
}

struct Class_ActionScheduler_QueueCleaner {
	rt.PhpObjectBase
}

struct Class_ActionScheduler_WPCLI_QueueRunner {
	rt.PhpObjectBase
}

fn create_actionscheduler_wpcli_scheduler_command(_args ...rt.PhpVal) &Class_ActionScheduler_WPCLI_Scheduler_command {
	mut obj := &Class_ActionScheduler_WPCLI_Scheduler_command{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_cli_command(_args ...rt.PhpVal) &Class_WP_CLI_Command {
	mut obj := &Class_WP_CLI_Command{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_cli(_args ...rt.PhpVal) &Class_WP_CLI {
	mut obj := &Class_WP_CLI{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_actionscheduler_datacontroller(_args ...rt.PhpVal) &Class_ActionScheduler_DataController {
	mut obj := &Class_ActionScheduler_DataController{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_actionscheduler(_args ...rt.PhpVal) &Class_ActionScheduler {
	mut obj := &Class_ActionScheduler{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_actionscheduler_queuecleaner(_args ...rt.PhpVal) &Class_ActionScheduler_QueueCleaner {
	mut obj := &Class_ActionScheduler_QueueCleaner{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_actionscheduler_wpcli_queuerunner(_args ...rt.PhpVal) &Class_ActionScheduler_WPCLI_QueueRunner {
	mut obj := &Class_ActionScheduler_WPCLI_QueueRunner{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_ActionScheduler_WPCLI_Scheduler_command) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'fix_schema' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.fix_schema(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'run' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.run(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'parse_comma_separated_string' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.parse_comma_separated_string(dispatch_arg_0)
		}
		'print_total_actions' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.print_total_actions(dispatch_arg_0)
			return rt.new_null()
		}
		'print_total_batches' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.print_total_batches(dispatch_arg_0)
			return rt.new_null()
		}
		'print_error' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Exception](if args.len > 0 { args[0] } else { rt.new_null() })
			this.print_error(mut dispatch_arg_0)
			return rt.new_null()
		}
		'print_success' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.print_success(dispatch_arg_0)
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_ActionScheduler_WPCLI_Scheduler_command) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ActionScheduler_WPCLI_Scheduler_command) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_CLI_Command) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_CLI_Command) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_CLI_Command) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
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


fn (mut this Class_ActionScheduler_DataController) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ActionScheduler_DataController) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ActionScheduler_DataController) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_ActionScheduler_QueueCleaner) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ActionScheduler_QueueCleaner) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ActionScheduler_QueueCleaner) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_ActionScheduler_WPCLI_QueueRunner) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ActionScheduler_WPCLI_QueueRunner) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ActionScheduler_WPCLI_QueueRunner) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn init_registry() {
	rt.register_class_factory('ActionScheduler_WPCLI_Scheduler_command', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_actionscheduler_wpcli_scheduler_command()
		return rt.new_object('ActionScheduler_WPCLI_Scheduler_command', ['WP_CLI_Command'], obj)
	})
	rt.register_class_factory('WP_CLI_Command', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wp_cli_command()
		return rt.new_object('WP_CLI_Command', []string{}, obj)
	})
	rt.register_class_factory('WP_CLI', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wp_cli()
		return rt.new_object('WP_CLI', []string{}, obj)
	})
	rt.register_class_factory('ActionScheduler_DataController', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_actionscheduler_datacontroller()
		return rt.new_object('ActionScheduler_DataController', []string{}, obj)
	})
	rt.register_class_factory('ActionScheduler', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_actionscheduler()
		return rt.new_object('ActionScheduler', []string{}, obj)
	})
	rt.register_class_factory('ActionScheduler_QueueCleaner', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_actionscheduler_queuecleaner()
		return rt.new_object('ActionScheduler_QueueCleaner', []string{}, obj)
	})
	rt.register_class_factory('ActionScheduler_WPCLI_QueueRunner', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_actionscheduler_wpcli_queuerunner()
		return rt.new_object('ActionScheduler_WPCLI_QueueRunner', []string{}, obj)
	})
}

fn init() {
	init_registry()
}


fn main() {
	defer {
		rt.shutdown()
	}

}
