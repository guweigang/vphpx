import rt

struct Class_WC_CLI_Runner {
	rt.PhpObjectBase
}

fn init_static_wc_cli_runner() {
	rt.init_static_prop('WC_CLI_Runner', 'disabled_endpoints', rt.create_array([
		rt.ArrayItem{ key: none, val: 'settings' },
		rt.ArrayItem{ key: none, val: 'settings/(?P<group_id>[\\w-]+)' },
		rt.ArrayItem{ key: none, val: 'settings/(?P<group_id>[\\w-]+)/batch' },
		rt.ArrayItem{ key: none, val: 'settings/(?P<group_id>[\\w-]+)/(?P<id>[\\w-]+)' },
		rt.ArrayItem{ key: none, val: 'system_status' },
		rt.ArrayItem{ key: none, val: 'system_status/tools' },
		rt.ArrayItem{ key: none, val: 'system_status/tools/(?P<id>[\\w-]+)' },
		rt.ArrayItem{ key: none, val: 'reports' },
		rt.ArrayItem{ key: none, val: 'reports/sales' },
		rt.ArrayItem{ key: none, val: 'reports/top_sellers' },
	]))
	rt.init_static_prop('WC_CLI_Runner', 'target_rest_version', rt.new_string('v2'))
}

fn Class_WC_CLI_Runner.after_wp_load() {
	mut var_wp_rest_server := rt.get_superglobal('wp_rest_server')
	var_wp_rest_server = create_wp_rest_server()
	rt.call_function('do_action', [rt.new_string('rest_api_init'), var_wp_rest_server])
	mut var_request := create_wp_rest_request(rt.new_string('GET'), rt.new_string('/'))
	var_request.set_param(rt.new_string('context'), rt.new_string('help'))
	mut var_response := var_wp_rest_server.dispatch(rt.new_object('WP_REST_Request', []string{},
		var_request))
	mut var_response_data := rt.call_method(var_response, 'get_data', []rt.PhpVal{})
	if !rt.is_true(var_response_data) {
		return
	}
	mut iter_1 := var_response_data.array_get(rt.new_string('routes')).iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_route_data := item_1.val
		mut var_route := item_1.key
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('substr', [
			var_route.clone(),
			rt.new_int(0),
			rt.new_int(4 +
				rt.get_static_prop('WC_CLI_Runner', 'target_rest_version').to_string().len),
		]), '/wc/' + (rt.get_static_prop('WC_CLI_Runner', 'target_rest_version')).str()))))
		{
			continue
		}
		if !rt.is_true(var_route_data.array_get(rt.new_string('schema')).array_get(rt.new_string('title'))) {
			mut iife_temp_0 := Class_WP_CLI{}
			mut iife_result_0 := iife_temp_0.debug(rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('No schema title found for %s, skipping REST command registration.'),
					rt.new_string('woocommerce'),
				]),
				var_route.clone(),
			]), rt.new_string('wc'))
			continue
		}
		if rt.is_true(rt.identical(rt.new_string('batch'),
			var_route_data.array_get(rt.new_string('schema')).array_get(rt.new_string('title'))))
		{
			continue
		}
		mut var_route_pieces := rt.call_function('explode', [
			rt.new_string('/'), var_route.clone()])
		mut var_endpoint_piece := rt.call_function('str_replace', [
			rt.new_string('/wc/' + (var_route_pieces.array_get(rt.new_int(2))).str() + '/'),
			rt.new_string(''),
			var_route.clone(),
		])
		if rt.is_true(rt.call_function('in_array', [var_endpoint_piece.clone(),
			rt.get_static_prop('WC_CLI_Runner', 'disabled_endpoints'),
			rt.new_bool(true)]))
		{
			continue
		}
		Class_WC_CLI_Runner.register_route_commands(create_wc_cli_rest_command(var_route_data.array_get(rt.new_string('schema')).array_get(rt.new_string('title')),
			var_route.clone(), var_route_data.array_get(rt.new_string('schema'))),
			var_route.clone(), var_route_data.clone())
	}
}

fn Class_WC_CLI_Runner.register_route_commands(var_rest_command rt.PhpVal, var_route rt.PhpVal, var_route_data rt.PhpVal, var_command_args rt.PhpVal) {
	mut var_matches := rt.new_null()
	mut var_supported_ids := {
		'product_id':   rt.call_function('__', [rt.new_string('Product ID.'),
			rt.new_string('woocommerce')])
		'customer_id':  rt.call_function('__', [rt.new_string('Customer ID.'),
			rt.new_string('woocommerce')])
		'order_id':     rt.call_function('__', [rt.new_string('Order ID.'),
			rt.new_string('woocommerce')])
		'refund_id':    rt.call_function('__', [rt.new_string('Refund ID.'),
			rt.new_string('woocommerce')])
		'attribute_id': rt.call_function('__', [rt.new_string('Attribute ID.'),
			rt.new_string('woocommerce')])
		'zone_id':      rt.call_function('__', [rt.new_string('Zone ID.'),
			rt.new_string('woocommerce')])
		'instance_id':  rt.call_function('__', [rt.new_string('Instance ID.'),
			rt.new_string('woocommerce')])
		'id':           rt.call_function('__', [
			rt.new_string('The ID for the resource.'),
			rt.new_string('woocommerce'),
		])
		'slug':         rt.call_function('__', [
			rt.new_string('The slug for the resource.'),
			rt.new_string('woocommerce'),
		])
	}
	rt.call_method(var_rest_command, 'set_supported_ids', [
		rt.create_array_from_native_map(var_supported_ids),
	])
	mut var_positional_args :=
		rt.func_array_keys(rt.create_array_from_native_map(var_supported_ids))
	mut var_parent := rt.new_string((rt.concat(rt.new_string('wc '),
		var_route_data.array_get(rt.new_string('schema')).array_get(rt.new_string('title')))).str())
	mut var_supported_commands := map[string]rt.PhpVal{}
	mut iter_2 := var_route_data.array_get(rt.new_string('endpoints')).iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_endpoint := item_2.val
		rt.call_function('preg_match_all', [rt.new_string('#\\([^\\)]+\\)#'),
			var_route.clone(), var_matches.clone()])
		mut var_resource_id := if !(!rt.is_true(var_matches.array_get(rt.new_int(0)))) { rt.call_function('array_pop', [
				var_matches.array_get(rt.new_int(0)),
			]) } else { rt.new_null() }
		mut var_trimmed_route := rt.new_string(var_route.clone().to_string().trim_right(' \t\n\r'))
		mut var_is_singular := rt.identical(rt.call_function('substr', [
			var_trimmed_route.clone(),
			rt.new_int(-if !var_resource_id.is_null() {
				var_resource_id
			} else {
				rt.new_string('')
			}.to_string().len)]),
			var_resource_id)
		if rt.is_true(rt.identical(rt.create_array([rt.ArrayItem{ key: none, val: 'GET' }]), var_endpoint.array_get(rt.new_string('methods'))))
			&& rt.is_true(rt.new_bool(!(rt.is_true(var_is_singular)))) {
			var_supported_commands['list'] = if !(!rt.is_true(var_endpoint.array_get(rt.new_string('args')))) {
				var_endpoint.array_get(rt.new_string('args'))
			} else {
				map[string]rt.PhpVal{}
			}
		}
		if rt.is_true(rt.identical(rt.create_array([rt.ArrayItem{ key: none, val: 'POST' }]), var_endpoint.array_get(rt.new_string('methods'))))
			&& rt.is_true(rt.new_bool(!(rt.is_true(var_is_singular)))) {
			var_supported_commands['create'] = if !(!rt.is_true(var_endpoint.array_get(rt.new_string('args')))) {
				var_endpoint.array_get(rt.new_string('args'))
			} else {
				map[string]rt.PhpVal{}
			}
		}
		if rt.is_true(rt.identical(rt.create_array([rt.ArrayItem{ key: none, val: 'GET' }]), var_endpoint.array_get(rt.new_string('methods'))))
			&& rt.is_true(var_is_singular) {
			var_supported_commands['get'] = if !(!rt.is_true(var_endpoint.array_get(rt.new_string('args')))) {
				var_endpoint.array_get(rt.new_string('args'))
			} else {
				map[string]rt.PhpVal{}
			}
		}
		if rt.is_true(rt.call_function('in_array', [rt.new_string('POST'), var_endpoint.array_get(rt.new_string('methods')), rt.new_bool(true)]))
			&& rt.is_true(var_is_singular) {
			var_supported_commands['update'] = if !(!rt.is_true(var_endpoint.array_get(rt.new_string('args')))) {
				var_endpoint.array_get(rt.new_string('args'))
			} else {
				map[string]rt.PhpVal{}
			}
		}
		if rt.is_true(rt.identical(rt.create_array([rt.ArrayItem{ key: none, val: 'DELETE' }]), var_endpoint.array_get(rt.new_string('methods'))))
			&& rt.is_true(var_is_singular) {
			var_supported_commands['delete'] = if !(!rt.is_true(var_endpoint.array_get(rt.new_string('args')))) {
				var_endpoint.array_get(rt.new_string('args'))
			} else {
				map[string]rt.PhpVal{}
			}
		}
	}
	for var_command, var_endpoint_args in var_supported_commands {
		mut var_synopsis := map[string]rt.PhpVal{}
		mut var_arg_regs := map[string]rt.PhpVal{}
		mut var_ids := map[string]rt.PhpVal{}
		for var_id_name, var_id_desc in var_supported_ids {
			if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('strpos', [
				var_route.clone(),
				rt.new_string('<' + id_name + '>'),
			]), rt.new_bool(false)))))
			{
				var_synopsis << rt.create_array([
					rt.ArrayItem{ key: 'name', val: id_name },
					rt.ArrayItem{ key: 'type', val: 'positional' },
					rt.ArrayItem{ key: 'description', val: var_id_desc },
					rt.ArrayItem{ key: 'optional', val: false },
				])
				var_ids << rt.new_string(id_name)
			}
		}
		mut iter_3 := var_endpoint_args.iterator()
		for {
			item_3 := iter_3.next() or { break }
			mut var_args := item_3.val
			mut var_name := item_3.key
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_name.clone(), var_positional_args.clone(), rt.new_bool(true)])))))
				|| rt.is_true(rt.identical(rt.call_function('strpos', [var_route.clone(), rt.new_string('<' + var_id_name.str() + '>')]), rt.new_bool(false))) {
				var_arg_regs << rt.create_array([
					rt.ArrayItem{ key: 'name', val: var_name },
					rt.ArrayItem{ key: 'type', val: 'assoc' },
					rt.ArrayItem{
						key: 'description'
						val: if !(!rt.is_true(var_args.array_get(rt.new_string('description')))) {
							var_args.array_get(rt.new_string('description'))
						} else {
							rt.new_string('')
						}
					},
					rt.ArrayItem{
						key: 'optional'
						val: rt.new_bool(!rt.is_true(var_args.array_get(rt.new_string('required'))))
					},
				])
			}
		}
		for var_arg_reg in var_arg_regs {
			var_synopsis << var_arg_reg.clone()
		}
		if rt.is_true(rt.call_function('in_array', [rt.new_string(command),
			rt.create_array([rt.ArrayItem{ key: none, val: 'list' },
				rt.ArrayItem{ key: none, val: 'get' }]),
			rt.new_bool(true)]))
		{
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
		}
		if rt.is_true(rt.call_function('in_array', [rt.new_string(command),
			rt.create_array([rt.ArrayItem{ key: none, val: 'create' },
				rt.ArrayItem{ key: none, val: 'update' }, rt.ArrayItem{ key: none, val: 'delete' }]),
			rt.new_bool(true)]))
		{
			var_synopsis << rt.create_array([
				rt.ArrayItem{ key: 'name', val: 'porcelain' },
				rt.ArrayItem{ key: 'type', val: 'flag' },
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Output just the id when the operation is successful.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'optional', val: true },
			])
		}
		mut var_methods := rt.create_array([
			rt.ArrayItem{ key: 'list', val: 'list_items' },
			rt.ArrayItem{ key: 'create', val: 'create_item' },
			rt.ArrayItem{ key: 'delete', val: 'delete_item' },
			rt.ArrayItem{ key: 'get', val: 'get_item' },
			rt.ArrayItem{ key: 'update', val: 'update_item' },
		])
		mut var_before_invoke := rt.new_null()
		mut iife_temp_1 := Class_WP_CLI{}
		mut iife_result_1 := iife_temp_1.get_config(rt.new_string('debug'))
		if !rt.is_true(var_command_args.array_get(rt.new_string('when')))
			&& rt.is_true(iife_result_1) {
			closure_3_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
				rt.call_function('wc_maybe_define_constant', [
					rt.new_string('SAVEQUERIES'),
					rt.new_bool(true),
				])
				return rt.new_null()
			}
			var_before_invoke = rt.new_closure(closure_3_fn)
		}
		mut iife_temp_3 := Class_WP_CLI{}
		mut iife_result_3 := iife_temp_3.add_command(rt.new_string('${var_parent.to_string()} ${var_command}'), rt.create_array([
			rt.ArrayItem{ key: none, val: var_rest_command },
			rt.ArrayItem{ key: none, val: var_methods.array_get(rt.new_string(command)) },
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

struct Class_WP_REST_Server {
	rt.PhpObjectBase
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

fn create_wc_cli_runner(_args ...rt.PhpVal) &Class_WC_CLI_Runner {
	mut obj := &Class_WC_CLI_Runner{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_rest_server(_args ...rt.PhpVal) &Class_WP_REST_Server {
	mut obj := &Class_WP_REST_Server{
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

fn (mut this Class_WC_CLI_Runner) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'after_wp_load' {
			Class_WC_CLI_Runner.after_wp_load()
			return rt.new_null()
		}
		'register_route_commands' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			Class_WC_CLI_Runner.register_route_commands(dispatch_arg_0, dispatch_arg_1,
				dispatch_arg_2, dispatch_arg_3)
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_CLI_Runner) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_CLI_Runner) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WP_REST_Server) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_REST_Server) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_REST_Server) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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
