import rt

struct Class_WC_CLI_Tracker_Command {
	rt.PhpObjectBase
}

fn Class_WC_CLI_Tracker_Command.register_commands() {
	mut iife_temp_0 := Class_WP_CLI{}
	mut iife_result_0 := iife_temp_0.add_command(rt.new_string('wc tracker snapshot'), rt.create_array([
		rt.ArrayItem{ key: none, val: 'WC_CLI_Tracker_Command' },
		rt.ArrayItem{ key: none, val: 'show_tracker_snapshot' },
	]))
}

fn Class_WC_CLI_Tracker_Command.show_tracker_snapshot(var_args rt.PhpVal, var_assoc_args rt.PhpVal) {
	mut iife_temp_1 := Class_WC_Tracker{}
	mut iife_result_1 := iife_temp_1.get_tracking_data()
	mut var_snapshot_data := iife_result_1
	mut var_formatter := create_wp_cli_formatter(var_assoc_args.clone(),
		rt.func_array_keys(var_snapshot_data.clone()))
	var_formatter.display_items(rt.create_array([
		rt.ArrayItem{ key: none, val: var_snapshot_data },
	]))
}

struct Class_WP_CLI {
	rt.PhpObjectBase
}

struct Class_WC_Tracker {
	rt.PhpObjectBase
}

struct Class_WP_CLI_Formatter {
	rt.PhpObjectBase
}

fn create_wc_cli_tracker_command(_args ...rt.PhpVal) &Class_WC_CLI_Tracker_Command {
	mut obj := &Class_WC_CLI_Tracker_Command{
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

fn create_wc_tracker(_args ...rt.PhpVal) &Class_WC_Tracker {
	mut obj := &Class_WC_Tracker{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_cli_formatter(_args ...rt.PhpVal) &Class_WP_CLI_Formatter {
	mut obj := &Class_WP_CLI_Formatter{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_CLI_Tracker_Command) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'register_commands' {
			Class_WC_CLI_Tracker_Command.register_commands()
			return rt.new_null()
		}
		'show_tracker_snapshot' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			Class_WC_CLI_Tracker_Command.show_tracker_snapshot(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_CLI_Tracker_Command) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_CLI_Tracker_Command) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_WC_Tracker) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Tracker) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Tracker) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn main() {
	defer {
		rt.shutdown()
	}

	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		exit(0)
	}
}
