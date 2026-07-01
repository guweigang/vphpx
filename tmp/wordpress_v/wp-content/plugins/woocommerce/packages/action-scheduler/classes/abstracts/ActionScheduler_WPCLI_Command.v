import rt

pub fn Class_ActionScheduler_WPCLI_Command.date_format() string {
	return 'Y-m-d H:i:s O'
}
struct Class_ActionScheduler_WPCLI_Command {
	rt.PhpObjectBase
pub mut:
		args rt.PhpVal = rt.new_null()
		assoc_args rt.PhpVal = rt.new_null()
}

fn (mut this Class_ActionScheduler_WPCLI_Command) construct(mut var_args Class_array, mut var_assoc_args Class_array)  {
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('WP_CLI')]))))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('constant', [rt.new_string('WP_CLI')]))))))) {
		rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('The %s class can only be run within WP CLI.'), rt.new_string('woocommerce')]), rt.call_function('get_class', [rt.new_object('ActionScheduler_WPCLI_Command', ['WP_CLI_Command'], &this)])]))))
	}
	this.args = var_args.dup()
	this.assoc_args = var_assoc_args.dup()
}

fn (mut this Class_ActionScheduler_WPCLI_Command) execute()  {
}

fn (mut this Class_ActionScheduler_WPCLI_Command) get_schedule_display_string(mut var_schedule Class_ActionScheduler_Schedule) string {
	mut var_schedule_display_string := rt.new_string(rt.new_string(''))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_schedule.get_date())))) {
		return '0000-00-00 00:00:00'
	}
	mut var_next_timestamp := rt.call_method(var_schedule.get_date(), 'getTimestamp', []rt.PhpVal{})
	// unsupported expression: Expr_AssignOp_Concat
	return (var_schedule_display_string).str()
}

fn (mut this Class_ActionScheduler_WPCLI_Command) process_csv_arguments_to_arrays()  {
	{
		mut iter_1 := this.assoc_args.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_v := item_1.val
			mut var_k := item_1.key
			if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
				this.assoc_args.array_set(var_k, rt.call_function('explode', [rt.new_string(','), var_v.dup()]))
			}
		}
	}
}

struct Class_WP_CLI_Command {
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

fn create_actionscheduler_wpcli_command(arg_0 rt.PhpVal, arg_1 rt.PhpVal) &Class_ActionScheduler_WPCLI_Command {
	mut obj := &Class_ActionScheduler_WPCLI_Command{
		PhpObjectBase: rt.PhpObjectBase{}
		args: rt.new_null()
		assoc_args: rt.new_null()
	}
	obj.construct(arg_0, arg_1)
	return obj
}

fn create_wp_cli_command() &Class_WP_CLI_Command {
	mut obj := &Class_WP_CLI_Command{
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

fn (mut this Class_ActionScheduler_WPCLI_Command) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_array](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_array](if args.len > 1 { args[1] } else { rt.new_null() })
			this.construct(mut dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'execute' {
			this.execute()
			return rt.new_null()
		}
		'get_schedule_display_string' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_ActionScheduler_Schedule](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_string(this.get_schedule_display_string(mut dispatch_arg_0))
		}
		'process_csv_arguments_to_arrays' {
			this.process_csv_arguments_to_arrays()
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_ActionScheduler_WPCLI_Command) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'args' { return this.args }
		'assoc_args' { return this.assoc_args }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_ActionScheduler_WPCLI_Command) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'args' { this.args = val; return true }
		'assoc_args' { this.assoc_args = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
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




pub fn init_wp_content_plugins_woocommerce_packages_action_scheduler_classes_abstracts_actionscheduler_wpcli_command_php() {
}
