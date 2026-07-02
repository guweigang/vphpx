import rt

struct Class_Action_Scheduler_WP_CLI_Action_Next_Command {
	rt.PhpObjectBase
}

fn (mut this Class_Action_Scheduler_WP_CLI_Action_Next_Command) execute() {
	mut var_hook := rt.get_property(rt.new_object('Action_Scheduler_WP_CLI_Action_Next_Command', [
		'Action_Scheduler_WP_CLI_Action_ActionScheduler_WPCLI_Command',
	], &this), 'args').array_get(rt.new_int(0))
	mut var_group := rt.call_function('get_flag_value', [
		rt.get_property(rt.new_object('Action_Scheduler_WP_CLI_Action_Next_Command', [
			'Action_Scheduler_WP_CLI_Action_ActionScheduler_WPCLI_Command',
		], &this), 'assoc_args'),
		rt.new_string('group'),
		rt.new_string(''),
	])
	mut var_callback_args := rt.call_function('get_flag_value', [
		rt.get_property(rt.new_object('Action_Scheduler_WP_CLI_Action_Next_Command', [
			'Action_Scheduler_WP_CLI_Action_ActionScheduler_WPCLI_Command',
		], &this), 'assoc_args'),
		rt.new_string('args'),
		rt.new_null(),
	])
	mut var_raw := rt.new_bool((rt.call_function('get_flag_value', [
		rt.get_property(rt.new_object('Action_Scheduler_WP_CLI_Action_Next_Command', [
			'Action_Scheduler_WP_CLI_Action_ActionScheduler_WPCLI_Command',
		], &this), 'assoc_args'),
		rt.new_string('raw'),
		rt.new_bool(false),
	])).to_bool())
	if !(!rt.is_true(var_callback_args)) {
		var_callback_args = rt.call_function('json_decode', [
			var_callback_args.clone(), rt.new_bool(true)])
	}
	if rt.is_true(var_raw) {
		mut iife_temp_0 := Class_Action_Scheduler_WP_CLI_Action_WP_CLI{}
		mut iife_result_0 := iife_temp_0.line(rt.call_function('as_next_scheduled_action', [
			var_hook.clone(),
			var_callback_args.clone(),
			var_group.clone(),
		]))
		return
	}
	mut var_params := rt.create_array([rt.ArrayItem{ key: 'hook', val: var_hook },
		rt.ArrayItem{ key: 'orderby', val: 'date' }, rt.ArrayItem{ key: 'order', val: 'ASC' },
		rt.ArrayItem{ key: 'group', val: var_group }])
	if rt.is_true(rt.new_bool(var_callback_args.clone().is_array())) {
		var_params.array_set('args', var_callback_args.clone())
	}
	var_params.array_set('status',
		Class_Action_Scheduler_WP_CLI_Action_ActionScheduler_Store.status_running())
	mut iife_temp_1 := Class_Action_Scheduler_WP_CLI_Action_WP_CLI{}
	mut iife_result_1 := iife_temp_1.debug(rt.new_string(
		'ActionScheduler()::store()->query_action( ' +
		(rt.call_function('var_export', [var_params.clone(), rt.new_bool(true)])).str() + ' )'))
	mut iife_temp_2 := Class_Action_Scheduler_WP_CLI_Action_ActionScheduler{}
	mut iife_result_2 := iife_temp_2.store()
	mut var_store := iife_result_2
	mut var_action_id := rt.call_method(var_store, 'query_action', [
		var_params.clone()])
	if rt.is_true(var_action_id) {
		rt.echo_val(var_action_id)
		return
	}
	var_params.array_set('status',
		Class_Action_Scheduler_WP_CLI_Action_ActionScheduler_Store.status_pending())
	mut iife_temp_3 := Class_Action_Scheduler_WP_CLI_Action_WP_CLI{}
	mut iife_result_3 := iife_temp_3.debug(rt.new_string(
		'ActionScheduler()::store()->query_action( ' +
		(rt.call_function('var_export', [var_params.clone(), rt.new_bool(true)])).str() + ' )'))
	var_action_id = rt.call_method(var_store, 'query_action', [
		var_params.clone()])
	if rt.is_true(var_action_id) {
		rt.echo_val(var_action_id)
		return
	}
	mut iife_temp_4 := Class_Action_Scheduler_WP_CLI_Action_WP_CLI{}
	mut iife_result_4 := iife_temp_4.warning(rt.new_string('No matching next action.'))
}

struct Class_Action_Scheduler_WP_CLI_Action_ActionScheduler_WPCLI_Command {
	rt.PhpObjectBase
}

struct Class_Action_Scheduler_WP_CLI_Action_WP_CLI {
	rt.PhpObjectBase
}

struct Class_Action_Scheduler_WP_CLI_Action_ActionScheduler {
	rt.PhpObjectBase
}

fn create_action_scheduler_wp_cli_action_next_command(_args ...rt.PhpVal) &Class_Action_Scheduler_WP_CLI_Action_Next_Command {
	mut obj := &Class_Action_Scheduler_WP_CLI_Action_Next_Command{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_action_scheduler_wp_cli_action_actionscheduler_wpcli_command(_args ...rt.PhpVal) &Class_Action_Scheduler_WP_CLI_Action_ActionScheduler_WPCLI_Command {
	mut obj := &Class_Action_Scheduler_WP_CLI_Action_ActionScheduler_WPCLI_Command{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_action_scheduler_wp_cli_action_wp_cli(_args ...rt.PhpVal) &Class_Action_Scheduler_WP_CLI_Action_WP_CLI {
	mut obj := &Class_Action_Scheduler_WP_CLI_Action_WP_CLI{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_action_scheduler_wp_cli_action_actionscheduler(_args ...rt.PhpVal) &Class_Action_Scheduler_WP_CLI_Action_ActionScheduler {
	mut obj := &Class_Action_Scheduler_WP_CLI_Action_ActionScheduler{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Action_Scheduler_WP_CLI_Action_Next_Command) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'execute' {
			this.execute()
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Action_Scheduler_WP_CLI_Action_Next_Command) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Action_Scheduler_WP_CLI_Action_Next_Command) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Action_Scheduler_WP_CLI_Action_ActionScheduler_WPCLI_Command) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Action_Scheduler_WP_CLI_Action_ActionScheduler_WPCLI_Command) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Action_Scheduler_WP_CLI_Action_ActionScheduler_WPCLI_Command) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Action_Scheduler_WP_CLI_Action_WP_CLI) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Action_Scheduler_WP_CLI_Action_WP_CLI) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Action_Scheduler_WP_CLI_Action_WP_CLI) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Action_Scheduler_WP_CLI_Action_ActionScheduler) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Action_Scheduler_WP_CLI_Action_ActionScheduler) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Action_Scheduler_WP_CLI_Action_ActionScheduler) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
