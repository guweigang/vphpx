import rt

struct Class_Action_Scheduler_WP_CLI_Action_Command {
	rt.PhpObjectBase
}

fn (mut this Class_Action_Scheduler_WP_CLI_Action_Command) cancel(mut var_args Class_Action_Scheduler_WP_CLI_array, mut var_assoc_args Class_Action_Scheduler_WP_CLI_array) {
	rt.include_file('Action/Cancel_Command.php', '4')
	mut var_command := create_action_scheduler_wp_cli_action_cancel_command(var_args.dup(),
		var_assoc_args.dup())
	rt.call_method(var_command, 'execute', []rt.PhpVal{})
}

fn (mut this Class_Action_Scheduler_WP_CLI_Action_Command) create(mut var_args Class_Action_Scheduler_WP_CLI_array, mut var_assoc_args Class_Action_Scheduler_WP_CLI_array) {
	rt.include_file('Action/Create_Command.php', '4')
	mut var_command := create_action_scheduler_wp_cli_action_create_command(var_args.dup(),
		var_assoc_args.dup())
	rt.call_method(var_command, 'execute', []rt.PhpVal{})
}

fn (mut this Class_Action_Scheduler_WP_CLI_Action_Command) delete(mut var_args Class_Action_Scheduler_WP_CLI_array, mut var_assoc_args Class_Action_Scheduler_WP_CLI_array) {
	rt.include_file('Action/Delete_Command.php', '4')
	mut var_command := create_action_scheduler_wp_cli_action_delete_command(var_args.dup(),
		var_assoc_args.dup())
	rt.call_method(var_command, 'execute', []rt.PhpVal{})
}

fn (mut this Class_Action_Scheduler_WP_CLI_Action_Command) generate(mut var_args Class_Action_Scheduler_WP_CLI_array, mut var_assoc_args Class_Action_Scheduler_WP_CLI_array) {
	rt.include_file('Action/Generate_Command.php', '4')
	mut var_command := create_action_scheduler_wp_cli_action_generate_command(var_args.dup(),
		var_assoc_args.dup())
	rt.call_method(var_command, 'execute', []rt.PhpVal{})
}

fn (mut this Class_Action_Scheduler_WP_CLI_Action_Command) get(mut var_args Class_Action_Scheduler_WP_CLI_array, mut var_assoc_args Class_Action_Scheduler_WP_CLI_array) {
	rt.include_file('Action/Get_Command.php', '4')
	mut var_command := create_action_scheduler_wp_cli_action_get_command(var_args.dup(),
		var_assoc_args.dup())
	rt.call_method(var_command, 'execute', []rt.PhpVal{})
}

fn (mut this Class_Action_Scheduler_WP_CLI_Action_Command) subcommand_list(mut var_args Class_Action_Scheduler_WP_CLI_array, mut var_assoc_args Class_Action_Scheduler_WP_CLI_array) {
	rt.include_file('Action/List_Command.php', '4')
	mut var_command := create_action_scheduler_wp_cli_action_list_command(var_args.dup(),
		var_assoc_args.dup())
	rt.call_method(var_command, 'execute', []rt.PhpVal{})
}

fn (mut this Class_Action_Scheduler_WP_CLI_Action_Command) logs(mut var_args Class_Action_Scheduler_WP_CLI_array) {
	mut var_command := rt.call_function('sprintf', [
		rt.new_string('action-scheduler action get %d --field=log_entries'),
		var_args.array_get(0),
	])
	fn (arg_0 rt.PhpVal) rt.PhpVal {
		mut temp := Class_Action_Scheduler_WP_CLI_WP_CLI{}
		return temp.runcommand(arg_0)
	}(var_command.dup())
}

fn (mut this Class_Action_Scheduler_WP_CLI_Action_Command) next(mut var_args Class_Action_Scheduler_WP_CLI_array, mut var_assoc_args Class_Action_Scheduler_WP_CLI_array) {
	rt.include_file('Action/Next_Command.php', '4')
	mut var_command := create_action_scheduler_wp_cli_action_next_command(var_args.dup(),
		var_assoc_args.dup())
	rt.call_method(var_command, 'execute', []rt.PhpVal{})
}

fn (mut this Class_Action_Scheduler_WP_CLI_Action_Command) run(mut var_args Class_Action_Scheduler_WP_CLI_array, mut var_assoc_args Class_Action_Scheduler_WP_CLI_array) {
	rt.include_file('Action/Run_Command.php', '4')
	mut var_command := create_action_scheduler_wp_cli_action_run_command(var_args.dup(),
		var_assoc_args.dup())
	rt.call_method(var_command, 'execute', []rt.PhpVal{})
}

struct Class_Action_Scheduler_WP_CLI_WP_CLI_Command {
	rt.PhpObjectBase
}

struct Class_Action_Scheduler_WP_CLI_Action_Cancel_Command {
	rt.PhpObjectBase
}

struct Class_Action_Scheduler_WP_CLI_Action_Create_Command {
	rt.PhpObjectBase
}

struct Class_Action_Scheduler_WP_CLI_Action_Delete_Command {
	rt.PhpObjectBase
}

struct Class_Action_Scheduler_WP_CLI_Action_Generate_Command {
	rt.PhpObjectBase
}

struct Class_Action_Scheduler_WP_CLI_Action_Get_Command {
	rt.PhpObjectBase
}

struct Class_Action_Scheduler_WP_CLI_Action_List_Command {
	rt.PhpObjectBase
}

struct Class_Action_Scheduler_WP_CLI_WP_CLI {
	rt.PhpObjectBase
}

struct Class_Action_Scheduler_WP_CLI_Action_Next_Command {
	rt.PhpObjectBase
}

struct Class_Action_Scheduler_WP_CLI_Action_Run_Command {
	rt.PhpObjectBase
}

fn create_action_scheduler_wp_cli_action_command() &Class_Action_Scheduler_WP_CLI_Action_Command {
	mut obj := &Class_Action_Scheduler_WP_CLI_Action_Command{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_action_scheduler_wp_cli_wp_cli_command() &Class_Action_Scheduler_WP_CLI_WP_CLI_Command {
	mut obj := &Class_Action_Scheduler_WP_CLI_WP_CLI_Command{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_action_scheduler_wp_cli_action_cancel_command() &Class_Action_Scheduler_WP_CLI_Action_Cancel_Command {
	mut obj := &Class_Action_Scheduler_WP_CLI_Action_Cancel_Command{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_action_scheduler_wp_cli_action_create_command() &Class_Action_Scheduler_WP_CLI_Action_Create_Command {
	mut obj := &Class_Action_Scheduler_WP_CLI_Action_Create_Command{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_action_scheduler_wp_cli_action_delete_command() &Class_Action_Scheduler_WP_CLI_Action_Delete_Command {
	mut obj := &Class_Action_Scheduler_WP_CLI_Action_Delete_Command{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_action_scheduler_wp_cli_action_generate_command() &Class_Action_Scheduler_WP_CLI_Action_Generate_Command {
	mut obj := &Class_Action_Scheduler_WP_CLI_Action_Generate_Command{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_action_scheduler_wp_cli_action_get_command() &Class_Action_Scheduler_WP_CLI_Action_Get_Command {
	mut obj := &Class_Action_Scheduler_WP_CLI_Action_Get_Command{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_action_scheduler_wp_cli_action_list_command() &Class_Action_Scheduler_WP_CLI_Action_List_Command {
	mut obj := &Class_Action_Scheduler_WP_CLI_Action_List_Command{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_action_scheduler_wp_cli_wp_cli() &Class_Action_Scheduler_WP_CLI_WP_CLI {
	mut obj := &Class_Action_Scheduler_WP_CLI_WP_CLI{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_action_scheduler_wp_cli_action_next_command() &Class_Action_Scheduler_WP_CLI_Action_Next_Command {
	mut obj := &Class_Action_Scheduler_WP_CLI_Action_Next_Command{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_action_scheduler_wp_cli_action_run_command() &Class_Action_Scheduler_WP_CLI_Action_Run_Command {
	mut obj := &Class_Action_Scheduler_WP_CLI_Action_Run_Command{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Action_Scheduler_WP_CLI_Action_Command) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'cancel' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Action_Scheduler_WP_CLI_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Action_Scheduler_WP_CLI_array](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			this.cancel(mut dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'create' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Action_Scheduler_WP_CLI_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Action_Scheduler_WP_CLI_array](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			this.create(mut dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'delete' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Action_Scheduler_WP_CLI_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Action_Scheduler_WP_CLI_array](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			this.delete(mut dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'generate' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Action_Scheduler_WP_CLI_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Action_Scheduler_WP_CLI_array](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			this.generate(mut dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'get' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Action_Scheduler_WP_CLI_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Action_Scheduler_WP_CLI_array](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			this.get(mut dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'subcommand_list' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Action_Scheduler_WP_CLI_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Action_Scheduler_WP_CLI_array](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			this.subcommand_list(mut dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'logs' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Action_Scheduler_WP_CLI_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.logs(mut dispatch_arg_0)
			return rt.new_null()
		}
		'next' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Action_Scheduler_WP_CLI_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Action_Scheduler_WP_CLI_array](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			this.next(mut dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'run' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Action_Scheduler_WP_CLI_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Action_Scheduler_WP_CLI_array](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			this.run(mut dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Action_Scheduler_WP_CLI_Action_Command) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Action_Scheduler_WP_CLI_Action_Command) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Action_Scheduler_WP_CLI_WP_CLI_Command) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Action_Scheduler_WP_CLI_WP_CLI_Command) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Action_Scheduler_WP_CLI_WP_CLI_Command) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Action_Scheduler_WP_CLI_Action_Cancel_Command) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Action_Scheduler_WP_CLI_Action_Cancel_Command) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Action_Scheduler_WP_CLI_Action_Cancel_Command) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Action_Scheduler_WP_CLI_Action_Create_Command) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Action_Scheduler_WP_CLI_Action_Create_Command) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Action_Scheduler_WP_CLI_Action_Create_Command) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Action_Scheduler_WP_CLI_Action_Delete_Command) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Action_Scheduler_WP_CLI_Action_Delete_Command) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Action_Scheduler_WP_CLI_Action_Delete_Command) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Action_Scheduler_WP_CLI_Action_Generate_Command) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Action_Scheduler_WP_CLI_Action_Generate_Command) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Action_Scheduler_WP_CLI_Action_Generate_Command) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Action_Scheduler_WP_CLI_Action_Get_Command) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Action_Scheduler_WP_CLI_Action_Get_Command) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Action_Scheduler_WP_CLI_Action_Get_Command) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Action_Scheduler_WP_CLI_Action_List_Command) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Action_Scheduler_WP_CLI_Action_List_Command) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Action_Scheduler_WP_CLI_Action_List_Command) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Action_Scheduler_WP_CLI_WP_CLI) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Action_Scheduler_WP_CLI_WP_CLI) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Action_Scheduler_WP_CLI_WP_CLI) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Action_Scheduler_WP_CLI_Action_Next_Command) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Action_Scheduler_WP_CLI_Action_Next_Command) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Action_Scheduler_WP_CLI_Action_Next_Command) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Action_Scheduler_WP_CLI_Action_Run_Command) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Action_Scheduler_WP_CLI_Action_Run_Command) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Action_Scheduler_WP_CLI_Action_Run_Command) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_content_plugins_woocommerce_packages_action_scheduler_classes_wp_cli_action_command_php() {
}
