import rt

struct Class_WC_CLI_Tool_Command {
	rt.PhpObjectBase
}

fn Class_WC_CLI_Tool_Command.register_commands() {
	mut var_wp_rest_server := rt.new_null()
	mut var_command_args := map[string]rt.PhpVal{}
	mut var_request := create_wp_rest_request(rt.new_string('OPTIONS'),
		rt.new_string('/wc/v2/system_status/tools'))
	mut var_response := rt.call_method(var_wp_rest_server, 'dispatch', [var_request])
	mut var_response_data := rt.call_method(var_response, 'get_data', []rt.PhpVal{})
	if !rt.is_true(var_response_data) {
		return
	}
	mut var_parent := rt.new_string('wc tool')
	mut var_supported_commands := ['list', 'run']
	for var_command in var_supported_commands {
		mut var_synopsis := []rt.PhpVal{}
		if rt.is_true(rt.identical(rt.new_string('run'), rt.new_string(command))) {
			var_synopsis << rt.create_array([rt.ArrayItem{ key: 'name', val: 'id' },
				rt.ArrayItem{ key: 'type', val: 'positional' },
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('The id for the resource.'),
					rt.new_string('woocommerce'),
				]) }, rt.ArrayItem{ key: 'optional', val: false }])
			mut var_method := rt.new_string('update_item')
			mut var_route := rt.new_string('/wc/v2/system_status/tools/(?P<id>[\\w-]+)')
		} else if rt.is_true(rt.identical(rt.new_string('list'), rt.new_string(command))) {
			var_synopsis << rt.create_array([rt.ArrayItem{ key: 'name', val: 'fields' },
				rt.ArrayItem{ key: 'type', val: 'assoc' }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Limit response to specific fields. Defaults to all fields.'),
					rt.new_string('woocommerce'),
				]) }, rt.ArrayItem{ key: 'optional', val: true }])
			var_synopsis << rt.create_array([rt.ArrayItem{ key: 'name', val: 'field' },
				rt.ArrayItem{ key: 'type', val: 'assoc' }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Get the value of an individual field.'),
					rt.new_string('woocommerce'),
				]) }, rt.ArrayItem{ key: 'optional', val: true }])
			var_synopsis << rt.create_array([rt.ArrayItem{ key: 'name', val: 'format' },
				rt.ArrayItem{ key: 'type', val: 'assoc' }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Render response in a particular format.'),
					rt.new_string('woocommerce'),
				]) }, rt.ArrayItem{ key: 'optional', val: true },
				rt.ArrayItem{ key: 'default', val: 'table' },
				rt.ArrayItem{ key: 'options', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'table' },
					rt.ArrayItem{ key: none, val: 'json' },
					rt.ArrayItem{ key: none, val: 'csv' },
					rt.ArrayItem{ key: none, val: 'ids' },
					rt.ArrayItem{ key: none, val: 'yaml' },
					rt.ArrayItem{ key: none, val: 'count' },
					rt.ArrayItem{ key: none, val: 'headers' },
					rt.ArrayItem{ key: none, val: 'body' },
					rt.ArrayItem{ key: none, val: 'envelope' },
				]) }])
			var_method = rt.new_string('list_items')
			var_route = rt.new_string('/wc/v2/system_status/tools')
		}
		mut var_before_invoke := rt.new_null()
		mut iife_temp_0 := Class_WP_CLI{}
		mut iife_result_0 := iife_temp_0.get_config(rt.new_string('debug'))
		if !rt.is_true(var_command_args.array_get(rt.new_string('when')))
			&& rt.is_true(iife_result_0) {
			closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
				rt.call_function('wc_maybe_define_constant', [
					rt.new_string('SAVEQUERIES'),
					rt.new_bool(true),
				])
				return rt.new_null()
			}
			var_before_invoke = rt.new_closure(closure_2_fn)
		}
		mut var_rest_command := create_wc_cli_rest_command(rt.new_string('system_status_tool'),
			var_route.clone(), var_response_data.array_get(rt.new_string('schema')))
		mut iife_temp_2 := Class_WP_CLI{}
		mut iife_result_2 := iife_temp_2.add_command(rt.new_string('${var_parent.to_string()} ${var_command}'), rt.create_array([
			rt.ArrayItem{ key: none, val: var_rest_command },
			rt.ArrayItem{ key: none, val: var_method },
		]), rt.create_array([rt.ArrayItem{ key: 'synopsis', val: var_synopsis },
			rt.ArrayItem{
				key: 'when'
				val: if !(!rt.is_true(var_command_args.array_get(rt.new_string('when')))) {
					var_command_args.array_get(rt.new_string('when'))
				} else {
					rt.new_string('')
				}
			}, rt.ArrayItem{ key: 'before_invoke', val: var_before_invoke }]))
	}
}

struct Class_WP_REST_Request {
	rt.PhpObjectBase
}

struct Class_WP_CLI {
	rt.PhpObjectBase
}

struct Class_WC_CLI_REST_Command {
	rt.PhpObjectBase
}

fn create_wc_cli_tool_command(_args ...rt.PhpVal) &Class_WC_CLI_Tool_Command {
	mut obj := &Class_WC_CLI_Tool_Command{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_rest_request(_args ...rt.PhpVal) &Class_WP_REST_Request {
	mut obj := &Class_WP_REST_Request{
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

fn create_wc_cli_rest_command(_args ...rt.PhpVal) &Class_WC_CLI_REST_Command {
	mut obj := &Class_WC_CLI_REST_Command{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_CLI_Tool_Command) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'register_commands' {
			Class_WC_CLI_Tool_Command.register_commands()
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_CLI_Tool_Command) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_CLI_Tool_Command) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WP_REST_Request) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_REST_Request) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_REST_Request) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_WC_CLI_REST_Command) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_CLI_REST_Command) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_CLI_REST_Command) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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
