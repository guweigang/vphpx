import rt

struct Class_WC_CLI_REST_Command {
	rt.PhpObjectBase
pub mut:
		routes_with_parent_id rt.PhpVal = rt.new_array()
		name rt.PhpVal = rt.new_null()
		route string
		resource_identifier rt.PhpVal = rt.new_null()
		schema rt.PhpVal = rt.new_null()
		supported_ids rt.PhpVal = rt.new_array()
}

fn (mut this Class_WC_CLI_REST_Command) construct(var_name rt.PhpVal, var_route rt.PhpVal, var_schema rt.PhpVal)  {
	mut var_matches := []rt.PhpVal{}
	mut var_route_mutated := var_route
	this.name = var_name.dup()
	rt.call_function('preg_match_all', [rt.new_string('#\\([^\\)]+\\)#'), var_route_mutated.dup(), var_matches.dup()])
	mut var_first_match := var_matches.array_get(0)
	mut var_resource_id := if !(!rt.is_true(var_matches.array_get(0))) { rt.call_function('array_pop', [var_matches.array_get(0)]) } else { rt.new_null() }
	this.route = var_route_mutated.dup().to_string().trim_right(' \t\n\r')
	this.schema = var_schema.dup()
	this.resource_identifier = var_resource_id.dup()
	if rt.is_true(rt.call_function('in_array', [var_name.dup(), this.routes_with_parent_id, rt.new_bool(true)])) {
		mut var_is_singular := rt.identical(rt.call_function('substr', [this.route, // unsupported expression: Expr_UnaryMinus]), var_resource_id)
		if rt.is_true(rt.new_bool(!(rt.is_true(var_is_singular)))) {
			this.resource_identifier = var_first_match.array_get(0)
		}
	}
}

fn (mut this Class_WC_CLI_REST_Command) set_supported_ids(var_supported_ids rt.PhpVal)  {
	this.supported_ids = var_supported_ids.dup()
}

fn (mut this Class_WC_CLI_REST_Command) get_supported_ids() rt.PhpVal {
	return this.supported_ids
}

fn (mut this Class_WC_CLI_REST_Command) create_item(var_args rt.PhpVal, var_assoc_args rt.PhpVal)  {
	mut var_status := rt.new_null()
	mut var_body := rt.new_null()
	mut var_assoc_args_mutated := var_assoc_args
	var_assoc_args_mutated = fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_CLI_REST_Command{}; return temp.decode_json(arg_0) }(var_assoc_args_mutated.dup())
	// unsupported assign target: Expr_List
	if rt.is_true(rt.call_function('WP_CLI\Utils\get_flag_value', [var_assoc_args_mutated.dup(), rt.new_string('porcelain')])) {
		fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WP_CLI{}; return temp.line(arg_0) }(var_body.array_get('id'))
	} else {
		fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WP_CLI{}; return temp.success(arg_0) }(rt.new_string(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('Created '), this.name), rt.new_string(' ')), var_body.array_get('id')), rt.new_string('.'))))
	}
}

fn (mut this Class_WC_CLI_REST_Command) delete_item(var_args rt.PhpVal, var_assoc_args rt.PhpVal)  {
	mut var_status := rt.new_null()
	mut var_body := rt.new_null()
	mut var_assoc_args_mutated := var_assoc_args
	// unsupported assign target: Expr_List
	mut var_object_id := if var_body.array_isset(rt.new_string('id')) { var_body.array_get('id') } else { rt.new_string('') }
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_object_id)))) && var_body.array_isset(rt.new_string('slug')))) {
		var_object_id = var_body.array_get('slug')
	}
	if rt.is_true(rt.call_function('WP_CLI\Utils\get_flag_value', [var_assoc_args_mutated.dup(), rt.new_string('porcelain')])) {
		fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WP_CLI{}; return temp.line(arg_0) }(var_object_id.dup())
	} else {
		if !rt.is_true(var_assoc_args_mutated.array_get('force')) {
			fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WP_CLI{}; return temp.success(arg_0) }(rt.new_string((rt.call_function('__', [rt.new_string('Trashed'), rt.new_string('woocommerce')])).str() + rt.concat(rt.concat(rt.concat(rt.new_string(' '), this.name), rt.new_string(' ')), var_object_id)))
		} else {
			fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WP_CLI{}; return temp.success(arg_0) }(rt.new_string((rt.call_function('__', [rt.new_string('Deleted'), rt.new_string('woocommerce')])).str() + rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string(' '), this.name), rt.new_string(' ')), var_object_id), rt.new_string('.'))))
		}
	}
}

fn (mut this Class_WC_CLI_REST_Command) get_item(var_args rt.PhpVal, var_assoc_args rt.PhpVal)  {
	mut var_status := rt.new_null()
	mut var_headers := map[string]rt.PhpVal{}
	mut var_assoc_args_mutated := var_assoc_args
	mut var_route := rt.new_string(this.get_filled_route(var_args.dup()))
	// unsupported assign target: Expr_List
	if !(!rt.is_true(var_assoc_args_mutated.array_get('fields'))) {
		mut var_body := Class_WC_CLI_REST_Command.limit_item_to_fields(var_body.dup(), var_assoc_args_mutated.array_get('fields'))
	}
	if !rt.is_true(var_assoc_args_mutated.array_get('format')) {
		var_assoc_args_mutated.array_set('format', 'table')
	}
	if rt.is_true(rt.identical(rt.new_string('headers'), var_assoc_args_mutated.array_get('format'))) {
		rt.echo_val(rt.call_function('wp_json_encode', [var_headers.dup()]))
	} else if rt.is_true(rt.identical(rt.new_string('body'), var_assoc_args_mutated.array_get('format'))) {
		rt.echo_val(rt.call_function('wp_json_encode', [var_body.dup()]))
	} else if rt.is_true(rt.identical(rt.new_string('envelope'), var_assoc_args_mutated.array_get('format'))) {
		rt.echo_val(rt.call_function('wp_json_encode', [rt.create_array([rt.ArrayItem{ key: 'body', val: var_body }, rt.ArrayItem{ key: 'headers', val: var_headers }, rt.ArrayItem{ key: 'status', val: var_status }])]))
	} else {
		mut var_formatter := this.get_formatter(var_assoc_args_mutated.dup())
		rt.call_method(var_formatter, 'display_item', [var_body.dup()])
	}
}

fn (mut this Class_WC_CLI_REST_Command) list_items(var_args rt.PhpVal, var_assoc_args rt.PhpVal)  {
	mut var_status := rt.new_null()
	mut var_body := rt.new_null()
	mut var_headers := map[string]rt.PhpVal{}
	mut var_assoc_args_mutated := var_assoc_args
	if rt.is_true(rt.new_bool(!(!rt.is_true(var_assoc_args_mutated.array_get('format'))) && rt.is_true(rt.identical(rt.new_string('count'), var_assoc_args_mutated.array_get('format'))))) {
		mut var_method := rt.new_string(rt.new_string('HEAD'))
	} else {
		var_method = rt.new_string(rt.new_string('GET'))
	}
	if !(var_assoc_args_mutated.array_isset(rt.new_string('per_page'))) || !rt.is_true(var_assoc_args_mutated.array_get('per_page')) {
		var_assoc_args_mutated.array_set('per_page', '100')
	}
	// unsupported assign target: Expr_List
	if rt.is_true(rt.new_bool(!(!rt.is_true(var_assoc_args_mutated.array_get('format'))) && rt.is_true(rt.identical(rt.new_string('ids'), var_assoc_args_mutated.array_get('format'))))) {
		mut var_items := rt.call_function('array_column', [var_body.dup(), rt.new_string('id')])
	} else {
		var_items = var_body.dup()
	}
	if !(!rt.is_true(var_assoc_args_mutated.array_get('fields'))) {
		{
			mut iter_1 := var_items.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_item := item_1.val
				mut var_key := item_1.key
				var_items.array_set(var_key, Class_WC_CLI_REST_Command.limit_item_to_fields(var_item.dup(), var_assoc_args_mutated.array_get('fields')))
			}
		}
	}
	if !rt.is_true(var_assoc_args_mutated.array_get('format')) {
		var_assoc_args_mutated.array_set('format', 'table')
	}
	if rt.is_true(rt.new_bool(!(!rt.is_true(var_assoc_args_mutated.array_get('format'))) && rt.is_true(rt.identical(rt.new_string('count'), var_assoc_args_mutated.array_get('format'))))) {
		if var_headers.array_isset(rt.new_string('X-WP-Total')) {
			rt.echo_val(// unsupported expression: Expr_Cast_Int)
		} else {
			fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WP_CLI{}; return temp.error(arg_0) }(rt.new_string('Count format not implemented yet.'))
		}
	} else if rt.is_true(rt.identical(rt.new_string('headers'), var_assoc_args_mutated.array_get('format'))) {
		rt.echo_val(rt.call_function('wp_json_encode', [var_headers.dup()]))
	} else if rt.is_true(rt.identical(rt.new_string('body'), var_assoc_args_mutated.array_get('format'))) {
		rt.echo_val(rt.call_function('wp_json_encode', [var_body.dup()]))
	} else if rt.is_true(rt.identical(rt.new_string('envelope'), var_assoc_args_mutated.array_get('format'))) {
		rt.echo_val(rt.call_function('wp_json_encode', [rt.create_array([rt.ArrayItem{ key: 'body', val: var_body }, rt.ArrayItem{ key: 'headers', val: var_headers }, rt.ArrayItem{ key: 'status', val: var_status }, rt.ArrayItem{ key: 'api_url', val: rt.get_property(rt.new_object('WC_CLI_REST_Command', []string{}, &this), 'api_url') }])]))
	} else {
		mut var_formatter := this.get_formatter(var_assoc_args_mutated.dup())
		rt.call_method(var_formatter, 'display_items', [var_items.dup()])
	}
}

fn (mut this Class_WC_CLI_REST_Command) update_item(var_args rt.PhpVal, var_assoc_args rt.PhpVal)  {
	mut var_status := rt.new_null()
	mut var_body := rt.new_null()
	mut var_assoc_args_mutated := var_assoc_args
	var_assoc_args_mutated = fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_CLI_REST_Command{}; return temp.decode_json(arg_0) }(var_assoc_args_mutated.dup())
	// unsupported assign target: Expr_List
	if rt.is_true(rt.call_function('WP_CLI\Utils\get_flag_value', [var_assoc_args_mutated.dup(), rt.new_string('porcelain')])) {
		fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WP_CLI{}; return temp.line(arg_0) }(var_body.array_get('id'))
	} else {
		fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WP_CLI{}; return temp.success(arg_0) }(rt.new_string((rt.call_function('__', [rt.new_string('Updated'), rt.new_string('woocommerce')])).str() + rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string(' '), this.name), rt.new_string(' ')), var_body.array_get('id')), rt.new_string('.'))))
	}
}

fn (mut this Class_WC_CLI_REST_Command) do_request(var_method rt.PhpVal, var_route rt.PhpVal, var_assoc_args rt.PhpVal) rt.PhpVal {
	mut var_GLOBALS := rt.new_null()
	mut var_method_mutated := var_method
	mut var_route_mutated := var_route
	mut var_assoc_args_mutated := var_assoc_args
	rt.call_function('wc_maybe_define_constant', [rt.new_string('REST_REQUEST'), rt.new_bool(true)])
	mut var_request := create_wp_rest_request(var_method_mutated.dup(), var_route_mutated.dup())
	if rt.is_true(rt.call_function('in_array', [var_method_mutated.dup(), rt.create_array([rt.ArrayItem{ key: none, val: 'POST' }, rt.ArrayItem{ key: none, val: 'PUT' }]), rt.new_bool(true)])) {
		var_request.set_body_params(var_assoc_args_mutated.dup())
	} else {
		{
			mut iter_1 := var_assoc_args_mutated.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_value := item_1.val
				mut var_key := item_1.key
				var_request.set_param(var_key.dup(), var_value.dup())
			}
		}
	}
	if rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_Jetpack_Constants{}; return temp.is_true(arg_0) }(rt.new_string('SAVEQUERIES'))) {
		mut var_original_queries := if rt.is_true(rt.new_bool(rt.get_property(var_GLOBALS.array_get('wpdb'), 'queries').is_array())) { rt.func_array_keys(rt.get_property(var_GLOBALS.array_get('wpdb'), 'queries')) } else { rt.new_array() }
	}
	mut var_response := rt.call_function('rest_do_request', [var_request])
	if rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_Jetpack_Constants{}; return temp.is_true(arg_0) }(rt.new_string('SAVEQUERIES'))) {
		mut var_performed_queries := rt.new_array()
		{
			mut iter_1 := rt.cast_array(rt.get_property(var_GLOBALS.array_get('wpdb'), 'queries')).iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_query := item_1.val
				mut var_key := item_1.key
				if rt.is_true(rt.call_function('in_array', [var_key.dup(), var_original_queries.dup(), rt.new_bool(true)])) {
					continue
				}
				var_performed_queries << var_query.dup()
			}
		}
		closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_a := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	mut var_b := if args.len > 1 { args[1].dup() } else { rt.new_null() }
	if rt.is_true(rt.identical(var_a.array_get(1), var_b.array_get(1))) {
		return rt.new_int(0)
	}
	return if rt.is_true(rt.greater(var_a.array_get(1), var_b.array_get(1))) { // unsupported expression: Expr_UnaryMinus } else { rt.new_int(1) }
	}
		rt.call_function('usort', [var_performed_queries.dup(), rt.new_closure(closure_1_fn)])
		mut var_query_count := rt.new_int(rt.new_int(var_performed_queries.len))
		mut var_query_total_time := rt.new_int(rt.new_int(0))
		for var_query in var_performed_queries {
			// unsupported expression: Expr_AssignOp_Plus
		}
		mut var_slow_query_message := rt.new_string(rt.new_string(''))
		if rt.is_true(rt.new_bool(rt.is_true(var_performed_queries) && rt.is_true(rt.identical(rt.new_string('wc'), fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WP_CLI{}; return temp.get_config(arg_0) }(rt.new_string('debug')))))) {
			// unsupported expression: Expr_AssignOp_Concat
			for var_i, var_query in var_performed_queries {
				var_i += 1
				mut var_bits := rt.call_function('explode', [rt.new_string(', '), var_query.array_get(2)])
				mut var_backtrace := rt.call_function('implode', [rt.new_string(', '), rt.call_function('array_slice', [var_bits.dup(), rt.new_int(13)])])
				mut var_seconds := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Utilities_NumberUtil{}; return temp.round(arg_0, arg_1) }(var_query.array_get(1), rt.new_int(6))
				// unsupported expression: Expr_AssignOp_Concat
				// unsupported expression: Expr_AssignOp_Concat
			}
		} else if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
			var_slow_query_message = rt.new_string(rt.new_string('. Use --debug=wc to see all queries.'))
		}
		var_query_total_time = fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Utilities_NumberUtil{}; return temp.round(arg_0, arg_1) }(var_query_total_time.dup(), rt.new_int(6))
		fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_WP_CLI{}; return temp.debug(arg_0, arg_1) }(rt.new_string("wc command executed ${var_query_count.to_string()} queries in ${var_query_total_time.to_string()} seconds${var_slow_query_message.to_string()}"), rt.new_string('wc'))
	}
	mut var_error := rt.call_method(var_response, 'as_error', []rt.PhpVal{})
	if rt.is_true(var_error) {
		if rt.is_true(rt.identical(rt.new_int(401), rt.call_method(var_response, 'get_status', []rt.PhpVal{}))) {
			mut var_errors := rt.call_method(var_error, 'get_error_messages', []rt.PhpVal{})
			var_errors.array_push((rt.call_function('__', [rt.new_string('Make sure to include the --user flag with an account that has permissions for this action.'), rt.new_string('woocommerce')])).str() + ' {"status":401}')
			var_error = rt.call_function('implode', [rt.new_string('\n'), var_errors.dup()])
		}
		fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WP_CLI{}; return temp.error(arg_0) }(var_error.dup())
	}
	return rt.create_array([rt.ArrayItem{ key: none, val: rt.call_method(var_response, 'get_status', []rt.PhpVal{}) }, rt.ArrayItem{ key: none, val: rt.call_method(var_response, 'get_data', []rt.PhpVal{}) }, rt.ArrayItem{ key: none, val: rt.call_method(var_response, 'get_headers', []rt.PhpVal{}) }])
}

fn (mut this Class_WC_CLI_REST_Command) get_formatter(var_assoc_args rt.PhpVal) rt.PhpVal {
	mut var_assoc_args_mutated := var_assoc_args
	if !(!rt.is_true(var_assoc_args_mutated.array_get('fields'))) {
		if rt.is_true(rt.new_bool(var_assoc_args_mutated.array_get('fields').is_string())) {
			mut var_fields := rt.call_function('explode', [rt.new_string(','), var_assoc_args_mutated.array_get('fields')])
		} else {
			var_fields = var_assoc_args_mutated.array_get('fields')
		}
	} else {
		if !(!rt.is_true(var_assoc_args_mutated.array_get('context'))) {
			var_fields = this.get_context_fields(var_assoc_args_mutated.array_get('context'))
		} else {
			var_fields = this.get_context_fields(rt.new_string('view'))
		}
	}
	return create_wp_cli_formatter(var_assoc_args_mutated.dup(), var_fields.dup())
}

fn (mut this Class_WC_CLI_REST_Command) get_context_fields(var_context rt.PhpVal) rt.PhpVal {
	mut var_fields := rt.new_array()
	{
		mut iter_1 := this.schema.array_get('properties').iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_args := item_1.val
			mut var_key := item_1.key
			if rt.is_true(rt.new_bool(!rt.is_true(.array_get()) || rt.is_true(rt.call_function('in_array', [.dup(), , ])))) {
				.array_push(.dup())
			}
		}
	}
	return var_fields.dup()
}

fn (mut this Class_WC_CLI_REST_Command) get_filled_route(var_args rt.PhpVal) string {
	
}

fn Class_WC_CLI_REST_Command.limit_item_to_fields(var_item rt.PhpVal, var_fields rt.PhpVal) rt.PhpVal {
	mut var_fields_mutated := var_fields
}

fn (mut this Class_WC_CLI_REST_Command) decode_json(var_arr rt.PhpVal) rt.PhpVal {
	mut var_arr_mutated := var_arr
}

struct Class_WP_CLI {
	rt.PhpObjectBase
}

struct Class_WP_REST_Request {
	rt.PhpObjectBase
}

struct Class_Automattic_Jetpack_Constants {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Utilities_NumberUtil {
	rt.PhpObjectBase
}

struct Class_WP_CLI_Formatter {
	rt.PhpObjectBase
}

fn create_wc_cli_rest_command(arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) &Class_WC_CLI_REST_Command {
	mut obj := &Class_WC_CLI_REST_Command{
		PhpObjectBase: rt.PhpObjectBase{}
		routes_with_parent_id: rt.new_array()
		name: rt.new_null()
		route: ''
		resource_identifier: rt.new_null()
		schema: rt.new_null()
		supported_ids: rt.new_array()
	}
	obj.construct(arg_0, arg_1, arg_2)
	return obj
}

fn create_wp_cli() &Class_WP_CLI {
	mut obj := &Class_WP_CLI{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_rest_request() &Class_WP_REST_Request {
	mut obj := &Class_WP_REST_Request{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_jetpack_constants() &Class_Automattic_Jetpack_Constants {
	mut obj := &Class_Automattic_Jetpack_Constants{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_utilities_numberutil() &Class_Automattic_WooCommerce_Utilities_NumberUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_NumberUtil{
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

fn (mut this Class_WC_CLI_REST_Command) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			this.construct(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'set_supported_ids' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_supported_ids(dispatch_arg_0)
			return rt.new_null()
		}
		'get_supported_ids' {
			return this.get_supported_ids()
		}
		'create_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.create_item(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'delete_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.delete_item(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'get_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.get_item(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'list_items' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.list_items(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'update_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.update_item(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'do_request' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.do_request(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'get_formatter' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_formatter(dispatch_arg_0)
		}
		'get_context_fields' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_context_fields(dispatch_arg_0)
		}
		'get_filled_route' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.get_filled_route(dispatch_arg_0))
		}
		'limit_item_to_fields' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_WC_CLI_REST_Command.limit_item_to_fields(dispatch_arg_0, dispatch_arg_1)
		}
		'decode_json' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.decode_json(dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_WC_CLI_REST_Command) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'routes_with_parent_id' { return this.routes_with_parent_id }
		'name' { return this.name }
		'route' { return rt.new_string(this.route) }
		'resource_identifier' { return this.resource_identifier }
		'schema' { return this.schema }
		'supported_ids' { return this.supported_ids }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_CLI_REST_Command) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'routes_with_parent_id' { this.routes_with_parent_id = val; return true }
		'name' { this.name = val; return true }
		'route' { this.route = (val).str(); return true }
		'resource_identifier' { this.resource_identifier = val; return true }
		'schema' { this.schema = val; return true }
		'supported_ids' { this.supported_ids = val; return true }
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


fn (mut this Class_WP_REST_Request) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_REST_Request) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_REST_Request) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_Jetpack_Constants) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_Jetpack_Constants) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_Jetpack_Constants) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Utilities_NumberUtil) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Utilities_NumberUtil) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_NumberUtil) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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




pub fn init_wp_content_plugins_woocommerce_includes_cli_class_wc_cli_rest_command_php() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))))) {
		// unsupported expression: Expr_Exit
	}
}
