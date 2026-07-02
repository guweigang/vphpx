import rt

struct Class_Automattic_WooCommerce_Internal_CLI_Migrator_Commands_ListCommand {
	rt.PhpObjectBase
pub mut:
		platform_registry rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Commands_ListCommand) init(mut var_platform_registry Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_PlatformRegistry) {
	this.platform_registry = var_platform_registry
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Commands_ListCommand) magic_invoke(mut var_args Class_Automattic_WooCommerce_Internal_CLI_Migrator_Commands_array, mut var_assoc_args Class_Automattic_WooCommerce_Internal_CLI_Migrator_Commands_array) {
	mut var_args_mutated := var_args
	mut var_assoc_args_mutated := var_assoc_args
	var_args_mutated = rt.new_null()
	var_assoc_args_mutated = rt.new_null()
	mut var_platforms := rt.call_method(this.platform_registry, 'get_platforms', []rt.PhpVal{})
	if !rt.is_true(var_platforms) {
		mut iife_temp_0 := Class_WP_CLI{}
		mut iife_result_0 := iife_temp_0.line(rt.new_string('No migration platforms are registered.'))
		return
	}
	mut var_formatted_items := rt.new_array()
	mut var_platform_count := rt.new_int(var_platforms.clone().array_count())
	mut var_current_index := rt.new_int(0)
	mut iter_1 := var_platforms.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_details := item_1.val
		mut var_id := item_1.key
		var_formatted_items.array_push(rt.create_array([rt.ArrayItem{ key: 'id', val: var_id }, rt.ArrayItem{ key: 'name', val: if !(var_details.array_get(rt.new_string('name'))).is_null() { var_details.array_get(rt.new_string('name')) } else { rt.new_string('') } }, rt.ArrayItem{ key: 'fetcher', val: if !(var_details.array_get(rt.new_string('fetcher'))).is_null() { var_details.array_get(rt.new_string('fetcher')) } else { rt.new_string('') } }, rt.ArrayItem{ key: 'mapper', val: if !(var_details.array_get(rt.new_string('mapper'))).is_null() { var_details.array_get(rt.new_string('mapper')) } else { rt.new_string('') } }]))
		rt.pre_inc(var_current_index)
		if rt.is_true(rt.less(var_current_index, var_platform_count)) {
			var_formatted_items.array_push(rt.create_array([rt.ArrayItem{ key: 'id', val: rt.call_function('str_repeat', [rt.new_string('-'), rt.new_int(20)]) }, rt.ArrayItem{ key: 'name', val: rt.call_function('str_repeat', [rt.new_string('-'), rt.new_int(25)]) }, rt.ArrayItem{ key: 'fetcher', val: rt.call_function('str_repeat', [rt.new_string('-'), rt.new_int(30)]) }, rt.ArrayItem{ key: 'mapper', val: rt.call_function('str_repeat', [rt.new_string('-'), rt.new_int(30)]) }]))
		}
	}
	rt.call_function('WP_CLI\Utils\format_items', [rt.new_string('table'), var_formatted_items.clone(), rt.create_array([rt.ArrayItem{ key: none, val: 'id' }, rt.ArrayItem{ key: none, val: 'name' }, rt.ArrayItem{ key: none, val: 'fetcher' }, rt.ArrayItem{ key: none, val: 'mapper' }])])
}

struct Class_WP_CLI {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_cli_migrator_commands_listcommand(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_CLI_Migrator_Commands_ListCommand {
	mut obj := &Class_Automattic_WooCommerce_Internal_CLI_Migrator_Commands_ListCommand{
		PhpObjectBase: rt.PhpObjectBase{}
		platform_registry: rt.new_null()
	}
	return obj
}

fn create_wp_cli(_args ...rt.PhpVal) &Class_WP_CLI {
	mut obj := &Class_WP_CLI{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Commands_ListCommand) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'init' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_PlatformRegistry](if args.len > 0 { args[0] } else { rt.new_null() })
			this.init(mut dispatch_arg_0)
			return rt.new_null()
		}
		'__invoke' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_CLI_Migrator_Commands_array](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_CLI_Migrator_Commands_array](if args.len > 1 { args[1] } else { rt.new_null() })
			this.magic_invoke(mut dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_CLI_Migrator_Commands_ListCommand) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'platform_registry' { return this.platform_registry }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Commands_ListCommand) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'platform_registry' { this.platform_registry = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
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



fn main() {
	defer {
		rt.shutdown()
	}

}
