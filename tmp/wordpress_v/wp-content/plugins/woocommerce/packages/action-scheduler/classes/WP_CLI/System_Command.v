import rt

struct Class_Action_Scheduler_WP_CLI_System_Command {
	rt.PhpObjectBase
pub mut:
		store rt.PhpVal = rt.new_null()
}

fn (mut this Class_Action_Scheduler_WP_CLI_System_Command) construct()  {
	this.store = fn () rt.PhpVal { mut temp := Class_Action_Scheduler_WP_CLI_ActionScheduler{}; return temp.store() }()
}

fn (mut this Class_Action_Scheduler_WP_CLI_System_Command) datastore(mut var_args Class_Action_Scheduler_WP_CLI_array, mut var_assoc_args Class_Action_Scheduler_WP_CLI_array)  {
	mut var_args_mutated := var_args
	rt.echo_val(this.get_current_datastore())
}

fn (mut this Class_Action_Scheduler_WP_CLI_System_Command) runner(mut var_args Class_Action_Scheduler_WP_CLI_array, mut var_assoc_args Class_Action_Scheduler_WP_CLI_array)  {
	mut var_args_mutated := var_args
	rt.echo_val(this.get_current_runner())
}

fn (mut this Class_Action_Scheduler_WP_CLI_System_Command) status(mut var_args Class_Action_Scheduler_WP_CLI_array, mut var_assoc_args Class_Action_Scheduler_WP_CLI_array)  {
	mut var_args_mutated := var_args
	mut var_runner_enabled := rt.call_function('has_action', [rt.new_string('action_scheduler_run_queue'), rt.create_array([rt.ArrayItem{ key: none, val: fn () rt.PhpVal { mut temp := Class_Action_Scheduler_WP_CLI_ActionScheduler{}; return temp.runner() }() }, rt.ArrayItem{ key: none, val: 'run' }])])
	fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WP_CLI{}; return temp.line(arg_0) }(rt.call_function('sprintf', [rt.new_string('Data store: %s'), this.get_current_datastore()]))
	fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WP_CLI{}; return temp.line(arg_0) }(rt.call_function('sprintf', [rt.new_string('Runner: %s%s'), this.get_current_runner(), if rt.is_true(var_runner_enabled) { rt.new_string('') } else { rt.new_string(' (disabled)') }]))
	fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WP_CLI{}; return temp.line(arg_0) }(rt.call_function('sprintf', [rt.new_string('Version: %s'), this.get_latest_version(rt.new_null())]))
	mut var_rows := rt.new_array()
	mut var_action_counts := rt.call_method(this.store, 'action_counts', []rt.PhpVal{})
	mut var_oldest_and_newest := this.get_oldest_and_newest(rt.func_array_keys(var_action_counts.dup()))
	{
		mut iter_1 := var_action_counts.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_count := item_1.val
			mut var_status := item_1.key
			var_rows.array_push(rt.create_array([rt.ArrayItem{ key: 'status', val: var_status }, rt.ArrayItem{ key: 'count', val: var_count }, rt.ArrayItem{ key: 'oldest', val: var_oldest_and_newest.array_get(var_status).array_get('oldest') }, rt.ArrayItem{ key: 'newest', val: var_oldest_and_newest.array_get(var_status).array_get('newest') }]))
		}
	}
	mut var_formatter := create_wp_cli_formatter(var_assoc_args.dup(), rt.create_array([rt.ArrayItem{ key: none, val: 'status' }, rt.ArrayItem{ key: none, val: 'count' }, rt.ArrayItem{ key: none, val: 'oldest' }, rt.ArrayItem{ key: none, val: 'newest' }]))
	var_formatter.display_items(var_rows.dup())
}

fn (mut this Class_Action_Scheduler_WP_CLI_System_Command) version(mut var_args Class_Action_Scheduler_WP_CLI_array, mut var_assoc_args Class_Action_Scheduler_WP_CLI_array)  {
	mut var_args_mutated := var_args
	mut var_all := // unsupported expression: Expr_Cast_Bool
	mut var_latest := this.get_latest_version(rt.new_null())
	if rt.is_true(rt.new_bool(!(rt.is_true(var_all)))) {
		rt.echo_val(var_latest)
		fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WP_CLI{}; return temp.halt(arg_0) }(rt.new_int(0))
	}
	mut var_instance := fn () rt.PhpVal { mut temp := Class_Action_Scheduler_WP_CLI_ActionScheduler_Versions{}; return temp.instance() }()
	mut var_versions := rt.call_method(var_instance, 'get_versions', []rt.PhpVal{})
	mut var_rows := rt.new_array()
	{
		mut iter_1 := var_versions.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_callback := item_1.val
			mut var_version := item_1.key
			mut var_active := rt.identical(var_version, var_latest)
			var_rows.array_set(var_version, rt.create_array([rt.ArrayItem{ key: 'version', val: var_version }, rt.ArrayItem{ key: 'callback', val: var_callback }, rt.ArrayItem{ key: 'active', val: if rt.is_true(var_active) { 'yes' } else { 'no' } }]))
		}
	}
	rt.call_function('uksort', [var_rows.dup(), rt.new_string('version_compare')])
	mut var_formatter := create_wp_cli_formatter(var_assoc_args.dup(), rt.create_array([rt.ArrayItem{ key: none, val: 'version' }, rt.ArrayItem{ key: none, val: 'callback' }, rt.ArrayItem{ key: none, val: 'active' }]))
	var_formatter.display_items(var_rows.dup())
}

fn (mut this Class_Action_Scheduler_WP_CLI_System_Command) source(mut var_args Class_Action_Scheduler_WP_CLI_array, mut var_assoc_args Class_Action_Scheduler_WP_CLI_array)  {
	mut var_args_mutated := var_args
	mut var_all := // unsupported expression: Expr_Cast_Bool
	mut var_fullpath := // unsupported expression: Expr_Cast_Bool
	mut var_source := fn () rt.PhpVal { mut temp := Class_ActionScheduler_SystemInformation{}; return temp.active_source_path() }()
	mut var_path := var_source.dup()
	if rt.is_true(rt.new_bool(!(rt.is_true(var_fullpath)))) {
		var_path = rt.call_function('str_replace', [rt.get_constant('ABSPATH'), rt.new_string(''), var_path.dup()])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_all)))) {
		rt.echo_val(var_path)
		fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WP_CLI{}; return temp.halt(arg_0) }(rt.new_int(0))
	}
	mut var_sources := fn () rt.PhpVal { mut temp := Class_ActionScheduler_SystemInformation{}; return temp.get_sources() }()
	if !rt.is_true(var_sources) {
		fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WP_CLI{}; return temp.log(arg_0) }(rt.call_function('__', [rt.new_string('Detailed information about registered sources is not currently available.'), rt.new_string('woocommerce')]))
		return rt.new_null()
	}
	mut var_rows := rt.new_array()
	{
		mut iter_1 := var_sources.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_version := item_1.val
			mut var_check_source := item_1.key
			mut var_active := rt.identical(rt.call_function('dirname', [var_check_source.dup()]), var_source)
			var_path = var_check_source
			if rt.is_true(rt.new_bool(!(rt.is_true(var_fullpath)))) {
				var_path = rt.call_function('str_replace', [rt.get_constant('ABSPATH'), rt.new_string(''), var_path.dup()])
			}
			var_rows.array_set(var_check_source, rt.create_array([rt.ArrayItem{ key: 'source', val: var_path }, rt.ArrayItem{ key: 'version', val: var_version }, rt.ArrayItem{ key: 'active', val: if rt.is_true(var_active) { 'yes' } else { 'no' } }]))
		}
	}
	rt.call_function('ksort', [var_rows.dup()])
	fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WP_CLI{}; return temp.log(arg_0) }(rt.new_string((rt.get_constant('PHP_EOL')).str() + 'Please note there can only be one unique registered instance of Action Scheduler per ' + (rt.get_constant('PHP_EOL')).str() + 'version number, so this list may not include all the currently present copies of ' + (rt.get_constant('PHP_EOL')).str() + 'Action Scheduler.' + (rt.get_constant('PHP_EOL')).str()))
	mut var_formatter := create_wp_cli_formatter(var_assoc_args.dup(), rt.create_array([rt.ArrayItem{ key: none, val: 'source' }, rt.ArrayItem{ key: none, val: 'version' }, rt.ArrayItem{ key: none, val: 'active' }]))
	var_formatter.display_items(var_rows.dup())
}

fn (mut this Class_Action_Scheduler_WP_CLI_System_Command) get_current_datastore() rt.PhpVal {
	return rt.call_function('get_class', [this.store])
}

fn (mut this Class_Action_Scheduler_WP_CLI_System_Command) get_latest_version(var_instance rt.PhpVal) rt.PhpVal {
	mut var_instance_mutated := var_instance
	if rt.is_true(rt.new_bool(var_instance_mutated.dup().is_null())) {
		var_instance_mutated = fn () rt.PhpVal { mut temp := Class_Action_Scheduler_WP_CLI_ActionScheduler_Versions{}; return temp.instance() }()
	}
	return rt.call_method(var_instance_mutated, 'latest_version', []rt.PhpVal{})
}

fn (mut this Class_Action_Scheduler_WP_CLI_System_Command) get_current_runner() rt.PhpVal {
	return rt.call_function('get_class', [fn () rt.PhpVal { mut temp := Class_Action_Scheduler_WP_CLI_ActionScheduler{}; return temp.runner() }()])
}

fn (mut this Class_Action_Scheduler_WP_CLI_System_Command) get_oldest_and_newest(var_status_keys rt.PhpVal) rt.PhpVal {
	mut var_oldest_and_newest := rt.new_array()
	{
		mut iter_1 := var_status_keys.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_status := item_1.val
			var_oldest_and_newest.array_set(var_status, rt.create_array([rt.ArrayItem{ key: 'oldest', val: '&ndash;' }, rt.ArrayItem{ key: 'newest', val: '&ndash;' }]))
			if rt.is_true(rt.identical(rt.new_string('in-progress'), var_status)) {
				continue
			}
			var_oldest_and_newest.array_get_mut(var_status).array_set('oldest', this.get_action_status_date(var_status.dup(), 'oldest'))
			var_oldest_and_newest.array_get_mut(var_status).array_set('newest', this.get_action_status_date(var_status.dup(), 'newest'))
		}
	}
	return var_oldest_and_newest.dup()
}

fn (mut this Class_Action_Scheduler_WP_CLI_System_Command) get_action_status_date(var_status rt.PhpVal, date_type string) rt.PhpVal {
	mut var_order := rt.new_string(if rt.is_true(rt.identical(rt.new_string('oldest'), rt.new_string(date_type))) { rt.new_string('ASC') } else { rt.new_string('DESC') })
	mut var_args := rt.create_array([rt.ArrayItem{ key: 'status', val: var_status }, rt.ArrayItem{ key: 'per_page', val: 1 }, rt.ArrayItem{ key: 'order', val: var_order }])
	mut var_action := rt.call_method(this.store, 'query_actions', [var_args.dup()])
	if !(!rt.is_true(var_action)) {
		mut var_date_object := rt.call_method(this.store, 'get_date', [var_action.array_get(0)])
		mut var_action_date := rt.call_method(var_date_object, 'format', [rt.new_string('Y-m-d H:i:s O')])
	} else {
		var_action_date = rt.new_string(rt.new_string('&ndash;'))
	}
	return var_action_date.dup()
}

struct Class_Action_Scheduler_WP_CLI_ActionScheduler {
	rt.PhpObjectBase
}

struct Class_WP_CLI {
	rt.PhpObjectBase
}

struct Class_WP_CLI_Formatter {
	rt.PhpObjectBase
}

struct Class_Action_Scheduler_WP_CLI_ActionScheduler_Versions {
	rt.PhpObjectBase
}

struct Class_ActionScheduler_SystemInformation {
	rt.PhpObjectBase
}

fn create_action_scheduler_wp_cli_system_command() &Class_Action_Scheduler_WP_CLI_System_Command {
	mut obj := &Class_Action_Scheduler_WP_CLI_System_Command{
		PhpObjectBase: rt.PhpObjectBase{}
		store: rt.new_null()
	}
	obj.construct()
	return obj
}

fn create_action_scheduler_wp_cli_actionscheduler() &Class_Action_Scheduler_WP_CLI_ActionScheduler {
	mut obj := &Class_Action_Scheduler_WP_CLI_ActionScheduler{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_cli() &Class_WP_CLI {
	mut obj := &Class_WP_CLI{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_cli_formatter() &Class_WP_CLI_Formatter {
	mut obj := &Class_WP_CLI_Formatter{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_action_scheduler_wp_cli_actionscheduler_versions() &Class_Action_Scheduler_WP_CLI_ActionScheduler_Versions {
	mut obj := &Class_Action_Scheduler_WP_CLI_ActionScheduler_Versions{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_actionscheduler_systeminformation() &Class_ActionScheduler_SystemInformation {
	mut obj := &Class_ActionScheduler_SystemInformation{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Action_Scheduler_WP_CLI_System_Command) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'datastore' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Action_Scheduler_WP_CLI_array](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Action_Scheduler_WP_CLI_array](if args.len > 1 { args[1] } else { rt.new_null() })
			this.datastore(mut dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'runner' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Action_Scheduler_WP_CLI_array](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Action_Scheduler_WP_CLI_array](if args.len > 1 { args[1] } else { rt.new_null() })
			this.runner(mut dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'status' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Action_Scheduler_WP_CLI_array](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Action_Scheduler_WP_CLI_array](if args.len > 1 { args[1] } else { rt.new_null() })
			this.status(mut dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'version' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Action_Scheduler_WP_CLI_array](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Action_Scheduler_WP_CLI_array](if args.len > 1 { args[1] } else { rt.new_null() })
			this.version(mut dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'source' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Action_Scheduler_WP_CLI_array](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Action_Scheduler_WP_CLI_array](if args.len > 1 { args[1] } else { rt.new_null() })
			this.source(mut dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'get_current_datastore' {
			return this.get_current_datastore()
		}
		'get_latest_version' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_latest_version(dispatch_arg_0)
		}
		'get_current_runner' {
			return this.get_current_runner()
		}
		'get_oldest_and_newest' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_oldest_and_newest(dispatch_arg_0)
		}
		'get_action_status_date' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return this.get_action_status_date(dispatch_arg_0, dispatch_arg_1)
		}
		else { return none }
	}
}

fn (this &Class_Action_Scheduler_WP_CLI_System_Command) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'store' { return this.store }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Action_Scheduler_WP_CLI_System_Command) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'store' { this.store = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Action_Scheduler_WP_CLI_ActionScheduler) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Action_Scheduler_WP_CLI_ActionScheduler) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Action_Scheduler_WP_CLI_ActionScheduler) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_WP_CLI_Formatter) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_CLI_Formatter) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_CLI_Formatter) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Action_Scheduler_WP_CLI_ActionScheduler_Versions) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Action_Scheduler_WP_CLI_ActionScheduler_Versions) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Action_Scheduler_WP_CLI_ActionScheduler_Versions) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_ActionScheduler_SystemInformation) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ActionScheduler_SystemInformation) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ActionScheduler_SystemInformation) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_packages_action_scheduler_classes_wp_cli_system_command_php() {
}
