import rt

struct Class_Action_Scheduler_WP_CLI_Action_Get_Command {
	rt.PhpObjectBase
}

fn (mut this Class_Action_Scheduler_WP_CLI_Action_Get_Command) execute() {
	mut var_action_id := rt.get_property(rt.new_object('Action_Scheduler_WP_CLI_Action_Get_Command', ['Action_Scheduler_WP_CLI_Action_ActionScheduler_WPCLI_Command'], &this), 'args').array_get(rt.new_int(0))
	mut iife_temp_0 := Class_Action_Scheduler_WP_CLI_Action_ActionScheduler{}
	mut iife_result_0 := iife_temp_0.store()
	mut var_store := iife_result_0
	mut iife_temp_1 := Class_Action_Scheduler_WP_CLI_Action_ActionScheduler{}
	mut iife_result_1 := iife_temp_1.logger()
	mut var_logger := iife_result_1
	mut var_action := rt.call_method(var_store, 'fetch_action', [var_action_id.clone()])
	if rt.is_true(rt.call_function('is_a', [var_action.clone(), Class_Action_Scheduler_WP_CLI_Action_ActionScheduler_NullAction.class()])) {
	mut iife_temp_2 := Class_Action_Scheduler_WP_CLI_Action_WP_CLI{}
	mut iife_result_2 := iife_temp_2.error(rt.call_function('sprintf', [rt.call_function('esc_html__', [rt.new_string('Unable to retrieve action %d.'), rt.new_string('woocommerce')]), var_action_id.clone()]))
	}
	mut var_only_logs := rt.new_bool(!(!rt.is_true(rt.get_property(rt.new_object('Action_Scheduler_WP_CLI_Action_Get_Command', ['Action_Scheduler_WP_CLI_Action_ActionScheduler_WPCLI_Command'], &this), 'assoc_args').array_get(rt.new_string('field')))) && rt.is_true(rt.identical(rt.new_string('log_entries'), rt.get_property(rt.new_object('Action_Scheduler_WP_CLI_Action_Get_Command', ['Action_Scheduler_WP_CLI_Action_ActionScheduler_WPCLI_Command'], &this), 'assoc_args').array_get(rt.new_string('field')))))
	var_only_logs = rt.new_bool(rt.is_true(var_only_logs) || !(!rt.is_true(rt.get_property(rt.new_object('Action_Scheduler_WP_CLI_Action_Get_Command', ['Action_Scheduler_WP_CLI_Action_ActionScheduler_WPCLI_Command'], &this), 'assoc_args').array_get(rt.new_string('fields')))) && rt.is_true(rt.identical(rt.new_string('log_entries'), rt.get_property(rt.new_object('Action_Scheduler_WP_CLI_Action_Get_Command', ['Action_Scheduler_WP_CLI_Action_ActionScheduler_WPCLI_Command'], &this), 'assoc_args').array_get(rt.new_string('fields')))))
	mut var_log_entries := rt.new_array()
	mut iter_1 := rt.call_method(var_logger, 'get_logs', [var_action_id.clone()]).iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_log_entry := item_1.val
		var_log_entries.array_push(rt.create_array([rt.ArrayItem{ key: 'date', val: rt.call_method(rt.call_method(var_log_entry, 'get_date', []rt.PhpVal{}), 'format', [Class_Action_Scheduler_WP_CLI_Action_static.date_format()]) }, rt.ArrayItem{ key: 'message', val: rt.call_method(var_log_entry, 'get_message', []rt.PhpVal{}) }]))
	}
	if rt.is_true(var_only_logs) {
		mut var_args := rt.create_array([rt.ArrayItem{ key: 'format', val: rt.call_function('WP_CLI\Utils\get_flag_value', [rt.get_property(rt.new_object('Action_Scheduler_WP_CLI_Action_Get_Command', ['Action_Scheduler_WP_CLI_Action_ActionScheduler_WPCLI_Command'], &this), 'assoc_args'), rt.new_string('format'), rt.new_string('table')]) }])
		mut var_formatter := create_action_scheduler_wp_cli_action_wp_cli_formatter(var_args.clone(), rt.create_array([rt.ArrayItem{ key: none, val: 'date' }, rt.ArrayItem{ key: none, val: 'message' }]))
		var_formatter.display_items(var_log_entries.clone())
		return
	}
	mut var_status := rt.call_method(var_store, 'get_status', [var_action_id.clone()])
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	unsafe { goto end_label_1 }

catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'Action_Scheduler_WP_CLI_Action_Exception') {
		mut var_e := var_e_1.clone()
		mut iife_temp_3 := Class_Action_Scheduler_WP_CLI_Action_WP_CLI{}
		mut iife_result_3 := iife_temp_3.error(rt.call_method(var_e, 'getMessage', []rt.PhpVal{}))
		unsafe { goto end_label_1 }
	}
	else {
		rt.throw_exception(var_e_1)
		unsafe { goto end_label_1 }
	}

end_label_1:
	mut var_action_arr := rt.create_array([rt.ArrayItem{ key: 'id', val: rt.get_property(rt.new_object('Action_Scheduler_WP_CLI_Action_Get_Command', ['Action_Scheduler_WP_CLI_Action_ActionScheduler_WPCLI_Command'], &this), 'args').array_get(rt.new_int(0)) }, rt.ArrayItem{ key: 'hook', val: rt.call_method(var_action, 'get_hook', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'status', val: var_status }, rt.ArrayItem{ key: 'args', val: rt.call_method(var_action, 'get_args', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'group', val: rt.call_method(var_action, 'get_group', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'recurring', val: if rt.is_true(rt.call_method(rt.call_method(var_action, 'get_schedule', []rt.PhpVal{}), 'is_recurring', []rt.PhpVal{})) { 'yes' } else { 'no' } }, rt.ArrayItem{ key: 'scheduled_date', val: this.get_schedule_display_string(rt.call_method(var_action, 'get_schedule', []rt.PhpVal{})) }, rt.ArrayItem{ key: 'log_entries', val: var_log_entries }])
	mut var_fields := rt.func_array_keys(var_action_arr.clone())
	if !(!rt.is_true(rt.get_property(rt.new_object('Action_Scheduler_WP_CLI_Action_Get_Command', ['Action_Scheduler_WP_CLI_Action_ActionScheduler_WPCLI_Command'], &this), 'assoc_args').array_get(rt.new_string('fields')))) {
	var_fields = rt.call_function('explode', [rt.new_string(','), rt.get_property(rt.new_object('Action_Scheduler_WP_CLI_Action_Get_Command', ['Action_Scheduler_WP_CLI_Action_ActionScheduler_WPCLI_Command'], &this), 'assoc_args').array_get(rt.new_string('fields'))])
	}
	var_formatter = create_action_scheduler_wp_cli_action_wp_cli_formatter(rt.get_property(rt.new_object('Action_Scheduler_WP_CLI_Action_Get_Command', ['Action_Scheduler_WP_CLI_Action_ActionScheduler_WPCLI_Command'], &this), 'assoc_args'), var_fields.clone())
	var_formatter.display_item(var_action_arr.clone())
}

struct Class_Action_Scheduler_WP_CLI_Action_ActionScheduler_WPCLI_Command {
	rt.PhpObjectBase
}

struct Class_Action_Scheduler_WP_CLI_Action_ActionScheduler {
	rt.PhpObjectBase
}

struct Class_Action_Scheduler_WP_CLI_Action_WP_CLI {
	rt.PhpObjectBase
}

struct Class_Action_Scheduler_WP_CLI_Action_WP_CLI_Formatter {
	rt.PhpObjectBase
}

fn create_action_scheduler_wp_cli_action_get_command(_args ...rt.PhpVal) &Class_Action_Scheduler_WP_CLI_Action_Get_Command {
	mut obj := &Class_Action_Scheduler_WP_CLI_Action_Get_Command{
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

fn create_action_scheduler_wp_cli_action_actionscheduler(_args ...rt.PhpVal) &Class_Action_Scheduler_WP_CLI_Action_ActionScheduler {
	mut obj := &Class_Action_Scheduler_WP_CLI_Action_ActionScheduler{
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

fn create_action_scheduler_wp_cli_action_wp_cli_formatter(_args ...rt.PhpVal) &Class_Action_Scheduler_WP_CLI_Action_WP_CLI_Formatter {
	mut obj := &Class_Action_Scheduler_WP_CLI_Action_WP_CLI_Formatter{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Action_Scheduler_WP_CLI_Action_Get_Command) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'execute' {
			this.execute()
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_Action_Scheduler_WP_CLI_Action_Get_Command) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Action_Scheduler_WP_CLI_Action_Get_Command) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_Action_Scheduler_WP_CLI_Action_ActionScheduler) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Action_Scheduler_WP_CLI_Action_ActionScheduler) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Action_Scheduler_WP_CLI_Action_ActionScheduler) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_Action_Scheduler_WP_CLI_Action_WP_CLI_Formatter) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Action_Scheduler_WP_CLI_Action_WP_CLI_Formatter) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Action_Scheduler_WP_CLI_Action_WP_CLI_Formatter) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}



fn main() {
	defer {
		rt.shutdown()
	}

}
