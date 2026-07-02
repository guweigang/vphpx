import rt

struct Class_WC_CLI_COM_Extension_Command {
	rt.PhpObjectBase
}

fn Class_WC_CLI_COM_Extension_Command.register_commands() {
mut iife_temp_0 := Class_WP_CLI{}
mut iife_result_0 := iife_temp_0.add_command(rt.new_string('wc com extension'), rt.new_string('WC_CLI_COM_Extension_Command'))
}

fn (mut this Class_WC_CLI_COM_Extension_Command) install(var_args rt.PhpVal, var_assoc_args rt.PhpVal) {
	mut iife_temp_1 := Class_WC_Helper_Updater{}
	mut iife_result_1 := iife_temp_1.get_available_extensions_downloads_data()
	mut var_subscriptions := iife_result_1
	mut var_extension := rt.call_function('reset', [var_args.clone()])
	mut var_extension_package_url := rt.new_null()
	var_assoc_args.array_unset(rt.new_string('version'))
	mut iter_1 := var_subscriptions.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_subscription := item_1.val
		if rt.is_true(rt.identical(var_subscription.array_get(rt.new_string('slug')), var_extension)) && !(var_subscription.array_get(rt.new_string('package')).is_null()) {
			var_extension_package_url = var_subscription.array_get(rt.new_string('package'))
			break
		}
	}
	if rt.is_true(rt.new_bool(var_extension_package_url.clone().is_null())) {
		mut iife_temp_2 := Class_WP_CLI{}
		mut iife_result_2 := iife_temp_2.warning(rt.call_function('sprintf', [rt.new_string('We couldn\'t find a Subscription for \'%s\''), var_extension.clone()]))
		rt.call_function('WP_CLI\Utils\report_batch_operation_results', [rt.get_property(rt.new_object('WC_CLI_COM_Extension_Command', ['Plugin_Command'], &this), 'item_type'), rt.new_string('install'), rt.new_int(var_args.clone().array_count()), rt.new_int(0), rt.new_int(1)])
		return
	}
	this.Class_Plugin_Command.install(rt.create_array([rt.ArrayItem{ key: none, val: var_extension_package_url }]), var_assoc_args.clone())
}

struct Class_Plugin_Command {
	rt.PhpObjectBase
}

struct Class_WP_CLI {
	rt.PhpObjectBase
}

struct Class_WC_Helper_Updater {
	rt.PhpObjectBase
}

fn create_wc_cli_com_extension_command(_args ...rt.PhpVal) &Class_WC_CLI_COM_Extension_Command {
	mut obj := &Class_WC_CLI_COM_Extension_Command{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_plugin_command(_args ...rt.PhpVal) &Class_Plugin_Command {
	mut obj := &Class_Plugin_Command{
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

fn create_wc_helper_updater(_args ...rt.PhpVal) &Class_WC_Helper_Updater {
	mut obj := &Class_WC_Helper_Updater{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_CLI_COM_Extension_Command) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'register_commands' {
			Class_WC_CLI_COM_Extension_Command.register_commands()
			return rt.new_null()
		}
		'install' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.install(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_WC_CLI_COM_Extension_Command) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_CLI_COM_Extension_Command) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Plugin_Command) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Plugin_Command) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Plugin_Command) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_WC_Helper_Updater) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Helper_Updater) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Helper_Updater) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}



fn main() {
	defer {
		rt.shutdown()
	}

	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))))) {
		exit(0)
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [rt.new_string('Plugin_Command')]))))) {
		exit(0)
	}
}
