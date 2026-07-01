import rt

pub fn Class_Action_Scheduler_WP_CLI_Action_List_Command.parameters() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: none, val: 'hook' },
		rt.ArrayItem{ key: none, val: 'args' }, rt.ArrayItem{ key: none, val: 'date' },
		rt.ArrayItem{ key: none, val: 'date_compare' }, rt.ArrayItem{ key: none, val: 'modified' },
		rt.ArrayItem{ key: none, val: 'modified_compare' }, rt.ArrayItem{ key: none, val: 'group' },
		rt.ArrayItem{ key: none, val: 'status' }, rt.ArrayItem{ key: none, val: 'claimed' },
		rt.ArrayItem{ key: none, val: 'per_page' }, rt.ArrayItem{ key: none, val: 'offset' },
		rt.ArrayItem{ key: none, val: 'orderby' }, rt.ArrayItem{ key: none, val: 'order' }])
}

struct Class_Action_Scheduler_WP_CLI_Action_List_Command {
	rt.PhpObjectBase
}

fn (mut this Class_Action_Scheduler_WP_CLI_Action_List_Command) execute() {
	mut var_store := fn () rt.PhpVal {
		mut temp := Class_Action_Scheduler_WP_CLI_Action_ActionScheduler{}
		return temp.store()
	}()
	mut var_logger := fn () rt.PhpVal {
		mut temp := Class_Action_Scheduler_WP_CLI_Action_ActionScheduler{}
		return temp.logger()
	}()
	mut var_fields := rt.create_array([rt.ArrayItem{ key: none, val: 'id' },
		rt.ArrayItem{ key: none, val: 'hook' }, rt.ArrayItem{ key: none, val: 'status' },
		rt.ArrayItem{ key: none, val: 'group' }, rt.ArrayItem{ key: none, val: 'recurring' },
		rt.ArrayItem{ key: none, val: 'scheduled_date' }])
	this.process_csv_arguments_to_arrays()
	if !(!rt.is_true(rt.get_property(rt.new_object('Action_Scheduler_WP_CLI_Action_List_Command', [
		'Action_Scheduler_WP_CLI_Action_ActionScheduler_WPCLI_Command',
	], &this), 'assoc_args').array_get('fields'))) {
		var_fields = rt.get_property(rt.new_object('Action_Scheduler_WP_CLI_Action_List_Command', [
			'Action_Scheduler_WP_CLI_Action_ActionScheduler_WPCLI_Command',
		], &this), 'assoc_args').array_get('fields')
	}
	mut var_formatter := create_action_scheduler_wp_cli_action_wp_cli_formatter(rt.get_property(rt.new_object('Action_Scheduler_WP_CLI_Action_List_Command', [
		'Action_Scheduler_WP_CLI_Action_ActionScheduler_WPCLI_Command',
	], &this), 'assoc_args'), var_fields.dup())
	mut var_query_args := rt.get_property(rt.new_object('Action_Scheduler_WP_CLI_Action_List_Command', [
		'Action_Scheduler_WP_CLI_Action_ActionScheduler_WPCLI_Command',
	], &this), 'assoc_args')
	if rt.is_true(rt.new_bool(
		rt.is_true(rt.new_bool(var_query_args.dup().array_isset(rt.new_string('claimed'))))
		&& rt.is_true(rt.identical(rt.new_string('false'), rt.new_string(var_query_args.array_get('claimed').to_string().to_lower())))))
	{
		var_query_args.array_set('claimed', false)
	}
	mut var_return_format := rt.new_string(rt.new_string('OBJECT'))
	if rt.is_true(rt.call_function('in_array', [rt.get_property(var_formatter, 'format'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'ids' },
			rt.ArrayItem{ key: none, val: 'count' }]),
		rt.new_bool(true)]))
	{
		var_return_format = rt.new_string(rt.new_string("'ids'"))
	}
	mut var_params := rt.call_function('var_export', [var_query_args.dup(),
		rt.new_bool(true)])
	if !rt.is_true(var_query_args) {
		var_params = rt.new_string(rt.new_string('array()'))
	}
	fn (arg_0 rt.PhpVal) rt.PhpVal {
		mut temp := Class_Action_Scheduler_WP_CLI_Action_WP_CLI{}
		return temp.debug(arg_0)
	}(rt.call_function('sprintf', [rt.new_string('as_get_scheduled_actions( %s, %s )'),
		var_params.dup(), var_return_format.dup()]))
	if !(!rt.is_true(var_query_args.array_get('args'))) {
		var_query_args.array_set('args', rt.call_function('json_decode', [
			var_query_args.array_get('args'),
			rt.new_bool(true),
		]))
	}
	mut switch_val_1 := rt.get_property(var_formatter, 'format')
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('ids'))) {
		mut var_actions := rt.call_function('as_get_scheduled_actions', [
			var_query_args.dup(), rt.new_string('ids')])
		rt.echo_val(rt.call_function('implode', [rt.new_string(' '),
			var_actions.dup()]))
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('count'))) {
		var_actions = rt.call_function('as_get_scheduled_actions', [
			var_query_args.dup(), rt.new_string('ids')])
		var_formatter.display_items(var_actions.dup())
	} else {
		var_actions = rt.call_function('as_get_scheduled_actions', [
			var_query_args.dup(), rt.get_constant('OBJECT')])
		mut var_actions_arr := rt.new_array()
		{
			mut iter_1 := var_actions.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_action := item_1.val
				mut var_action_id := item_1.key
				mut var_action_arr := rt.create_array([
					rt.ArrayItem{ key: 'id', val: var_action_id },
					rt.ArrayItem{ key: 'hook', val: rt.call_method(var_action, 'get_hook',
						[]rt.PhpVal{}) },
					rt.ArrayItem{ key: 'status', val: rt.call_method(var_store, 'get_status', [
						var_action_id.dup(),
					]) },
					rt.ArrayItem{ key: 'args', val: rt.call_method(var_action, 'get_args',
						[]rt.PhpVal{}) },
					rt.ArrayItem{ key: 'group', val: rt.call_method(var_action, 'get_group',
						[]rt.PhpVal{}) },
					rt.ArrayItem{
						key: 'recurring'
						val: if rt.is_true(rt.call_method(rt.call_method(var_action,
							'get_schedule', []rt.PhpVal{}), 'is_recurring', []rt.PhpVal{}))
						{
							'yes'
						} else {
							'no'
						}
					},
					rt.ArrayItem{ key: 'scheduled_date', val: this.get_schedule_display_string(rt.call_method(var_action,
						'get_schedule', []rt.PhpVal{})) },
					rt.ArrayItem{ key: 'log_entries', val: rt.new_array() },
				])
				{
					mut iter_2 := rt.call_method(var_logger, 'get_logs', [
						var_action_id.dup()]).iterator()
					for {
						item_2 := iter_2.next() or { break }
						mut var_log_entry := item_2.val
						var_action_arr.array_get_mut('log_entries').array_push(rt.create_array([
							rt.ArrayItem{ key: 'date', val: rt.call_method(rt.call_method(var_log_entry,
								'get_date', []rt.PhpVal{}), 'format', [
								Class_Action_Scheduler_WP_CLI_Action_static.date_format(),
							]) },
							rt.ArrayItem{ key: 'message', val: rt.call_method(var_log_entry,
								'get_message', []rt.PhpVal{}) },
						]))
					}
				}
				var_actions_arr.array_push(var_action_arr.dup())
			}
		}
		var_formatter.display_items(var_actions_arr.dup())
	}
}

struct Class_Action_Scheduler_WP_CLI_Action_ActionScheduler_WPCLI_Command {
	rt.PhpObjectBase
}

struct Class_Action_Scheduler_WP_CLI_Action_ActionScheduler {
	rt.PhpObjectBase
}

struct Class_Action_Scheduler_WP_CLI_Action_WP_CLI_Formatter {
	rt.PhpObjectBase
}

struct Class_Action_Scheduler_WP_CLI_Action_WP_CLI {
	rt.PhpObjectBase
}

fn create_action_scheduler_wp_cli_action_list_command() &Class_Action_Scheduler_WP_CLI_Action_List_Command {
	mut obj := &Class_Action_Scheduler_WP_CLI_Action_List_Command{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_action_scheduler_wp_cli_action_actionscheduler_wpcli_command() &Class_Action_Scheduler_WP_CLI_Action_ActionScheduler_WPCLI_Command {
	mut obj := &Class_Action_Scheduler_WP_CLI_Action_ActionScheduler_WPCLI_Command{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_action_scheduler_wp_cli_action_actionscheduler() &Class_Action_Scheduler_WP_CLI_Action_ActionScheduler {
	mut obj := &Class_Action_Scheduler_WP_CLI_Action_ActionScheduler{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_action_scheduler_wp_cli_action_wp_cli_formatter() &Class_Action_Scheduler_WP_CLI_Action_WP_CLI_Formatter {
	mut obj := &Class_Action_Scheduler_WP_CLI_Action_WP_CLI_Formatter{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_action_scheduler_wp_cli_action_wp_cli() &Class_Action_Scheduler_WP_CLI_Action_WP_CLI {
	mut obj := &Class_Action_Scheduler_WP_CLI_Action_WP_CLI{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Action_Scheduler_WP_CLI_Action_List_Command) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
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

fn (this &Class_Action_Scheduler_WP_CLI_Action_List_Command) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Action_Scheduler_WP_CLI_Action_List_Command) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_Action_Scheduler_WP_CLI_Action_WP_CLI_Formatter) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Action_Scheduler_WP_CLI_Action_WP_CLI_Formatter) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Action_Scheduler_WP_CLI_Action_WP_CLI_Formatter) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

pub fn init_wp_content_plugins_woocommerce_packages_action_scheduler_classes_wp_cli_action_list_command_php() {
}
