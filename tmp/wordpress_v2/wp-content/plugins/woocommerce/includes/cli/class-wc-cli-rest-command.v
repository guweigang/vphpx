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

fn (mut this Class_WC_CLI_REST_Command) construct(var_name rt.PhpVal, var_route rt.PhpVal, var_schema rt.PhpVal) {
	mut var_matches := []rt.PhpVal{}
	mut var_route_mutated := var_route
	this.name = var_name.clone()
	rt.call_function('preg_match_all', [rt.new_string('#\\([^\\)]+\\)#'), var_route_mutated.clone(), rt.create_array_from_list(var_matches)])
	mut var_first_match := var_matches.array_get(rt.new_int(0))
	mut var_resource_id := if !(!rt.is_true(var_matches.array_get(rt.new_int(0)))) { rt.call_function('array_pop', [var_matches.array_get(rt.new_int(0))]) } else { rt.new_null() }
	this.route = var_route_mutated.clone().to_string().trim_right(' \t\n\r')
	this.schema = var_schema.clone()
	this.resource_identifier = var_resource_id.clone()
	if rt.is_true(rt.call_function('in_array', [var_name.clone(), this.routes_with_parent_id, rt.new_bool(true)])) {
		mut var_is_singular := rt.identical(rt.call_function('substr', [rt.new_string(this.route), rt.new_int(-var_resource_id.clone().to_string().len)]), var_resource_id)
		if rt.is_true(rt.new_bool(!(rt.is_true(var_is_singular)))) {
			this.resource_identifier = var_first_match.array_get(rt.new_int(0))
		}
	}
}

fn (mut this Class_WC_CLI_REST_Command) set_supported_ids(var_supported_ids rt.PhpVal) {
	this.supported_ids = var_supported_ids.clone()
}

fn (mut this Class_WC_CLI_REST_Command) get_supported_ids() rt.PhpVal {
	return this.supported_ids
}

fn (mut this Class_WC_CLI_REST_Command) create_item(var_args rt.PhpVal, var_assoc_args rt.PhpVal) {
	mut var_status := rt.new_null()
	mut var_body := rt.new_null()
	mut var_assoc_args_mutated := var_assoc_args
	mut iife_temp_0 := Class_WC_CLI_REST_Command{}
	mut iife_result_0 := iife_temp_0.decode_json(var_assoc_args_mutated.clone())
	var_assoc_args_mutated = iife_result_0
	mut list_tmp_1 := this.do_request(rt.new_string('POST'), rt.new_string(this.get_filled_route(var_args.clone())), var_assoc_args_mutated.clone())
	var_status = (list_tmp_1).array_get(0)
	var_body = (list_tmp_1).array_get(1)
	if rt.is_true(rt.call_function('WP_CLI\Utils\get_flag_value', [var_assoc_args_mutated.clone(), rt.new_string('porcelain')])) {
	mut iife_temp_1 := Class_WP_CLI{}
	mut iife_result_1 := iife_temp_1.line(var_body.array_get(rt.new_string('id')))
	} else {
	mut iife_temp_2 := Class_WP_CLI{}
	mut iife_result_2 := iife_temp_2.success(rt.new_string((rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('Created '), this.name), rt.new_string(' ')), var_body.array_get(rt.new_string('id'))), rt.new_string('.'))).str()))
	}
}

fn (mut this Class_WC_CLI_REST_Command) delete_item(var_args rt.PhpVal, var_assoc_args rt.PhpVal) {
	mut var_status := rt.new_null()
	mut var_body := rt.new_null()
	mut var_assoc_args_mutated := var_assoc_args
	mut list_tmp_2 := this.do_request(rt.new_string('DELETE'), rt.new_string(this.get_filled_route(var_args.clone())), var_assoc_args_mutated.clone())
	var_status = (list_tmp_2).array_get(0)
	var_body = (list_tmp_2).array_get(1)
	mut var_object_id := if var_body.array_isset(rt.new_string('id')) { var_body.array_get(rt.new_string('id')) } else { rt.new_string('') }
	if rt.is_true(rt.new_bool(!(rt.is_true(var_object_id)))) && var_body.array_isset(rt.new_string('slug')) {
	var_object_id = var_body.array_get(rt.new_string('slug'))
	}
	if rt.is_true(rt.call_function('WP_CLI\Utils\get_flag_value', [var_assoc_args_mutated.clone(), rt.new_string('porcelain')])) {
	mut iife_temp_3 := Class_WP_CLI{}
	mut iife_result_3 := iife_temp_3.line(var_object_id.clone())
	} else {
		if !rt.is_true(var_assoc_args_mutated.array_get(rt.new_string('force'))) {
		mut iife_temp_4 := Class_WP_CLI{}
		mut iife_result_4 := iife_temp_4.success(rt.new_string((rt.call_function('__', [rt.new_string('Trashed'), rt.new_string('woocommerce')])).str() + rt.concat(rt.concat(rt.concat(rt.new_string(' '), this.name), rt.new_string(' ')), var_object_id)))
		} else {
		mut iife_temp_5 := Class_WP_CLI{}
		mut iife_result_5 := iife_temp_5.success(rt.new_string((rt.call_function('__', [rt.new_string('Deleted'), rt.new_string('woocommerce')])).str() + rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string(' '), this.name), rt.new_string(' ')), var_object_id), rt.new_string('.'))))
		}
	}
}

fn (mut this Class_WC_CLI_REST_Command) get_item(var_args rt.PhpVal, var_assoc_args rt.PhpVal) {
	mut var_status := rt.new_null()
	mut var_headers := map[string]rt.PhpVal{}
	mut var_assoc_args_mutated := var_assoc_args
	mut var_route := rt.new_string(this.get_filled_route(var_args.clone()))
	mut list_tmp_3 := this.do_request(rt.new_string('GET'), var_route.clone(), var_assoc_args_mutated.clone())
	var_status = (list_tmp_3).array_get(0)
	mut var_body := (list_tmp_3).array_get(1)
	var_headers = (list_tmp_3).array_get(2)
	if !(!rt.is_true(var_assoc_args_mutated.array_get(rt.new_string('fields')))) {
	var_body = Class_WC_CLI_REST_Command.limit_item_to_fields(var_body.clone(), var_assoc_args_mutated.array_get(rt.new_string('fields')))
	}
	if !rt.is_true(var_assoc_args_mutated.array_get(rt.new_string('format'))) {
		var_assoc_args_mutated.array_set('format', 'table')
	}
	if rt.is_true(rt.identical(rt.new_string('headers'), var_assoc_args_mutated.array_get(rt.new_string('format')))) {
		rt.echo_val(rt.call_function('wp_json_encode', [rt.create_array_from_native_map(var_headers)]))
	} else if rt.is_true(rt.identical(rt.new_string('body'), var_assoc_args_mutated.array_get(rt.new_string('format')))) {
		rt.echo_val(rt.call_function('wp_json_encode', [var_body.clone()]))
	} else if rt.is_true(rt.identical(rt.new_string('envelope'), var_assoc_args_mutated.array_get(rt.new_string('format')))) {
		rt.echo_val(rt.call_function('wp_json_encode', [rt.create_array([rt.ArrayItem{ key: 'body', val: var_body }, rt.ArrayItem{ key: 'headers', val: var_headers }, rt.ArrayItem{ key: 'status', val: var_status }])]))
	} else {
		mut var_formatter := this.get_formatter(var_assoc_args_mutated.clone())
		rt.call_method(var_formatter, 'display_item', [var_body.clone()])
	}
}

fn (mut this Class_WC_CLI_REST_Command) list_items(var_args rt.PhpVal, var_assoc_args rt.PhpVal) {
	mut var_status := rt.new_null()
	mut var_body := rt.new_null()
	mut var_headers := map[string]rt.PhpVal{}
	mut var_assoc_args_mutated := var_assoc_args
	if !(!rt.is_true(var_assoc_args_mutated.array_get(rt.new_string('format')))) && rt.is_true(rt.identical(rt.new_string('count'), var_assoc_args_mutated.array_get(rt.new_string('format')))) {
	mut var_method := rt.new_string('HEAD')
	} else {
	var_method = rt.new_string('GET')
	}
	if !(var_assoc_args_mutated.array_isset(rt.new_string('per_page'))) || !rt.is_true(var_assoc_args_mutated.array_get(rt.new_string('per_page'))) {
		var_assoc_args_mutated.array_set('per_page', '100')
	}
	mut list_tmp_4 := this.do_request(var_method.clone(), rt.new_string(this.get_filled_route(var_args.clone())), var_assoc_args_mutated.clone())
	var_status = (list_tmp_4).array_get(0)
	var_body = (list_tmp_4).array_get(1)
	var_headers = (list_tmp_4).array_get(2)
	if !(!rt.is_true(var_assoc_args_mutated.array_get(rt.new_string('format')))) && rt.is_true(rt.identical(rt.new_string('ids'), var_assoc_args_mutated.array_get(rt.new_string('format')))) {
	mut var_items := rt.call_function('array_column', [var_body.clone(), rt.new_string('id')])
	} else {
	var_items = var_body.clone()
	}
	if !(!rt.is_true(var_assoc_args_mutated.array_get(rt.new_string('fields')))) {
		mut iter_1 := var_items.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_item := item_1.val
			mut var_key := item_1.key
			var_items.array_set(var_key, Class_WC_CLI_REST_Command.limit_item_to_fields(var_item.clone(), var_assoc_args_mutated.array_get(rt.new_string('fields'))))
		}
	}
	if !rt.is_true(var_assoc_args_mutated.array_get(rt.new_string('format'))) {
		var_assoc_args_mutated.array_set('format', 'table')
	}
	if !(!rt.is_true(var_assoc_args_mutated.array_get(rt.new_string('format')))) && rt.is_true(rt.identical(rt.new_string('count'), var_assoc_args_mutated.array_get(rt.new_string('format')))) {
		if var_headers.array_isset(rt.new_string('X-WP-Total')) {
			print(rt.new_int((var_headers.array_get(rt.new_string('X-WP-Total'))).to_i64()).str())
		} else {
		mut iife_temp_6 := Class_WP_CLI{}
		mut iife_result_6 := iife_temp_6.error(rt.new_string('Count format not implemented yet.'))
		}
	} else if rt.is_true(rt.identical(rt.new_string('headers'), var_assoc_args_mutated.array_get(rt.new_string('format')))) {
		rt.echo_val(rt.call_function('wp_json_encode', [rt.create_array_from_native_map(var_headers)]))
	} else if rt.is_true(rt.identical(rt.new_string('body'), var_assoc_args_mutated.array_get(rt.new_string('format')))) {
		rt.echo_val(rt.call_function('wp_json_encode', [var_body.clone()]))
	} else if rt.is_true(rt.identical(rt.new_string('envelope'), var_assoc_args_mutated.array_get(rt.new_string('format')))) {
		rt.echo_val(rt.call_function('wp_json_encode', [rt.create_array([rt.ArrayItem{ key: 'body', val: var_body }, rt.ArrayItem{ key: 'headers', val: var_headers }, rt.ArrayItem{ key: 'status', val: var_status }, rt.ArrayItem{ key: 'api_url', val: rt.get_property(rt.new_object('WC_CLI_REST_Command', []string{}, &this), 'api_url') }])]))
	} else {
		mut var_formatter := this.get_formatter(var_assoc_args_mutated.clone())
		rt.call_method(var_formatter, 'display_items', [var_items.clone()])
	}
}

fn (mut this Class_WC_CLI_REST_Command) update_item(var_args rt.PhpVal, var_assoc_args rt.PhpVal) {
	mut var_status := rt.new_null()
	mut var_body := rt.new_null()
	mut var_assoc_args_mutated := var_assoc_args
	mut iife_temp_7 := Class_WC_CLI_REST_Command{}
	mut iife_result_7 := iife_temp_7.decode_json(var_assoc_args_mutated.clone())
	var_assoc_args_mutated = iife_result_7
	mut list_tmp_5 := this.do_request(rt.new_string('POST'), rt.new_string(this.get_filled_route(var_args.clone())), var_assoc_args_mutated.clone())
	var_status = (list_tmp_5).array_get(0)
	var_body = (list_tmp_5).array_get(1)
	if rt.is_true(rt.call_function('WP_CLI\Utils\get_flag_value', [var_assoc_args_mutated.clone(), rt.new_string('porcelain')])) {
	mut iife_temp_8 := Class_WP_CLI{}
	mut iife_result_8 := iife_temp_8.line(var_body.array_get(rt.new_string('id')))
	} else {
	mut iife_temp_9 := Class_WP_CLI{}
	mut iife_result_9 := iife_temp_9.success(rt.new_string((rt.call_function('__', [rt.new_string('Updated'), rt.new_string('woocommerce')])).str() + rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string(' '), this.name), rt.new_string(' ')), var_body.array_get(rt.new_string('id'))), rt.new_string('.'))))
	}
}

fn (mut this Class_WC_CLI_REST_Command) do_request(var_method rt.PhpVal, var_route rt.PhpVal, var_assoc_args rt.PhpVal) rt.PhpVal {
	mut var_GLOBALS := rt.new_null()
	mut var_method_mutated := var_method
	mut var_route_mutated := var_route
	mut var_assoc_args_mutated := var_assoc_args
	rt.call_function('wc_maybe_define_constant', [rt.new_string('REST_REQUEST'), rt.new_bool(true)])
	mut var_request := create_wp_rest_request(var_method_mutated.clone(), var_route_mutated.clone())
	if rt.is_true(rt.call_function('in_array', [var_method_mutated.clone(), rt.create_array([rt.ArrayItem{ key: none, val: 'POST' }, rt.ArrayItem{ key: none, val: 'PUT' }]), rt.new_bool(true)])) {
		var_request.set_body_params(var_assoc_args_mutated.clone())
	} else {
		mut iter_2 := var_assoc_args_mutated.iterator()
		for {
			item_2 := iter_2.next() or { break }
			mut var_value := item_2.val
			mut var_key := item_2.key
			var_request.set_param(var_key.clone(), var_value.clone())
		}
	}
	mut iife_temp_10 := Class_Automattic_Jetpack_Constants{}
	mut iife_result_10 := iife_temp_10.is_true(rt.new_string('SAVEQUERIES'))
	if rt.is_true(iife_result_10) {
	mut var_original_queries := if rt.get_property(var_GLOBALS.array_get(rt.new_string('wpdb')), 'queries').is_array() { rt.func_array_keys(rt.get_property(var_GLOBALS.array_get(rt.new_string('wpdb')), 'queries')) } else { rt.new_array() }
	}
	mut var_response := rt.call_function('rest_do_request', [var_request])
	mut iife_temp_11 := Class_Automattic_Jetpack_Constants{}
	mut iife_result_11 := iife_temp_11.is_true(rt.new_string('SAVEQUERIES'))
	if rt.is_true(iife_result_11) {
		mut var_performed_queries := rt.new_array()
		mut iter_3 := rt.cast_array(rt.get_property(var_GLOBALS.array_get(rt.new_string('wpdb')), 'queries')).iterator()
		for {
			item_3 := iter_3.next() or { break }
			mut var_query := item_3.val
			mut var_key := item_3.key
			if rt.is_true(rt.call_function('in_array', [var_key.clone(), var_original_queries.clone(), rt.new_bool(true)])) {
				continue
			}
			var_performed_queries << var_query.clone()
		}
		closure_13_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_a := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			mut var_b := if args.len > 1 { args[1].clone() } else { rt.new_null() }
			if rt.is_true(rt.identical(var_a.array_get(rt.new_int(1)), var_b.array_get(rt.new_int(1)))) {
				return rt.new_int(0)
			}
			return rt.new_int(if rt.is_true(rt.greater(var_a.array_get(rt.new_int(1)), var_b.array_get(rt.new_int(1)))) { -1 } else { 1 })
			}
		rt.call_function('usort', [rt.create_array_from_list(var_performed_queries), rt.new_closure(closure_13_fn)])
		mut var_query_count := rt.new_int(var_performed_queries.len)
		mut var_query_total_time := rt.new_int(0)
		for var_query in var_performed_queries {
			var_query_total_time = rt.add(var_query_total_time, var_query.array_get(rt.new_int(1)))
		}
		mut var_slow_query_message := rt.new_string('')
		mut iife_temp_13 := Class_WP_CLI{}
		mut iife_result_13 := iife_temp_13.get_config(rt.new_string('debug'))
		if rt.is_true(var_performed_queries) && rt.is_true(rt.identical(rt.new_string('wc'), iife_result_13)) {
			var_slow_query_message = rt.concat(var_slow_query_message, rt.new_string('. Ordered by slowness, the queries are:' + (rt.get_constant('PHP_EOL')).str()))
			for var_i, var_query in var_performed_queries {
				var_i += 1
				mut var_bits := rt.call_function('explode', [rt.new_string(', '), var_query.array_get(rt.new_int(2))])
				mut var_backtrace := rt.call_function('implode', [rt.new_string(', '), rt.call_function('array_slice', [var_bits.clone(), rt.new_int(13)])])
				mut iife_temp_14 := Class_Automattic_WooCommerce_Utilities_NumberUtil{}
				mut iife_result_14 := iife_temp_14.round(var_query.array_get(rt.new_int(1)), rt.new_int(6))
				mut var_seconds := iife_result_14
				var_slow_query_message = rt.concat(var_slow_query_message, rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_int(i), rt.new_string(':\n- ')), var_seconds), rt.new_string(' seconds\n- ')), var_backtrace), rt.new_string('\n- ')), var_query.array_get(rt.new_int(0))))
				var_slow_query_message = rt.concat(var_slow_query_message, rt.get_constant('PHP_EOL'))
			}
		mut iife_temp_15 := Class_WP_CLI{}
		mut iife_result_15 := iife_temp_15.get_config(rt.new_string('debug'))
		} else if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('wc'), iife_result_15)))) {
		var_slow_query_message = rt.new_string('. Use --debug=wc to see all queries.')
		}
	mut iife_temp_16 := Class_Automattic_WooCommerce_Utilities_NumberUtil{}
	mut iife_result_16 := iife_temp_16.round(var_query_total_time.clone(), rt.new_int(6))
	var_query_total_time = iife_result_16
	mut iife_temp_17 := Class_WP_CLI{}
	mut iife_result_17 := iife_temp_17.debug(rt.new_string("wc command executed ${var_query_count.to_string()} queries in ${var_query_total_time.to_string()} seconds${var_slow_query_message.to_string()}"), rt.new_string('wc'))
	}
	mut var_error := rt.call_method(var_response, 'as_error', []rt.PhpVal{})
	if rt.is_true(var_error) {
		if rt.is_true(rt.identical(rt.new_int(401), rt.call_method(var_response, 'get_status', []rt.PhpVal{}))) {
			mut var_errors := rt.call_method(var_error, 'get_error_messages', []rt.PhpVal{})
			var_errors.array_push((rt.call_function('__', [rt.new_string('Make sure to include the --user flag with an account that has permissions for this action.'), rt.new_string('woocommerce')])).str() + ' {"status":401}')
		var_error = rt.call_function('implode', [rt.new_string('\n'), var_errors.clone()])
		}
	mut iife_temp_18 := Class_WP_CLI{}
	mut iife_result_18 := iife_temp_18.error(var_error.clone())
	}
	return rt.create_array([rt.ArrayItem{ key: none, val: rt.call_method(var_response, 'get_status', []rt.PhpVal{}) }, rt.ArrayItem{ key: none, val: rt.call_method(var_response, 'get_data', []rt.PhpVal{}) }, rt.ArrayItem{ key: none, val: rt.call_method(var_response, 'get_headers', []rt.PhpVal{}) }])
}

fn (mut this Class_WC_CLI_REST_Command) get_formatter(var_assoc_args rt.PhpVal) rt.PhpVal {
	mut var_assoc_args_mutated := var_assoc_args
	if !(!rt.is_true(var_assoc_args_mutated.array_get(rt.new_string('fields')))) {
		if rt.is_true(rt.new_bool(var_assoc_args_mutated.array_get(rt.new_string('fields')).is_string())) {
		mut var_fields := rt.call_function('explode', [rt.new_string(','), var_assoc_args_mutated.array_get(rt.new_string('fields'))])
		} else {
		var_fields = var_assoc_args_mutated.array_get(rt.new_string('fields'))
		}
	} else {
		if !(!rt.is_true(var_assoc_args_mutated.array_get(rt.new_string('context')))) {
		var_fields = this.get_context_fields(var_assoc_args_mutated.array_get(rt.new_string('context')))
		} else {
		var_fields = this.get_context_fields(rt.new_string('view'))
		}
	}
	return rt.new_object('WP_CLI_Formatter', []string{}, create_wp_cli_formatter(var_assoc_args_mutated.clone(), var_fields.clone()))
}

fn (mut this Class_WC_CLI_REST_Command) get_context_fields(var_context rt.PhpVal) rt.PhpVal {
	mut var_fields := rt.new_array()
	mut iter_4 := this.schema.array_get(rt.new_string('properties')).iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_args := item_4.val
		mut var_key := item_4.key
		if !rt.is_true(var_args.array_get(rt.new_string('context'))) || rt.is_true(rt.call_function('in_array', [var_context.clone(), var_args.array_get(rt.new_string('context')), rt.new_bool(true)])) {
			var_fields.array_push(var_key.clone())
		}
	}
	return var_fields.clone()
}

fn (mut this Class_WC_CLI_REST_Command) get_filled_route(var_args rt.PhpVal) string {
	mut var_supported_id_matched := rt.new_bool(false)
	mut var_route := rt.new_string(this.route)
	mut iter_5 := this.get_supported_ids().iterator()
	for {
		item_5 := iter_5.next() or { break }
		mut var_id_desc := item_5.val
		mut var_id_name := item_5.key
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('id'), var_id_name)))) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('strpos', [var_route.clone(), rt.new_string('<' + (var_id_name).str() + '>')]), rt.new_bool(false))))) && !(!rt.is_true(var_args)) {
		var_route = rt.call_function('str_replace', [rt.create_array([rt.ArrayItem{ key: none, val: '(?P<' + (var_id_name).str() + '>[\\d]+)' }, rt.ArrayItem{ key: none, val: '(?P<' + (var_id_name).str() + '>\\w[\\w\\s\\-]*)' }]), var_args.array_get(rt.new_int(0)), var_route.clone()])
		var_supported_id_matched = rt.new_bool(true)
		}
	}
	if !(!rt.is_true(var_args)) {
	mut var_id_replacement := if rt.is_true(var_supported_id_matched) && !(!rt.is_true(var_args.array_get(rt.new_int(1)))) { var_args.array_get(rt.new_int(1)) } else { var_args.array_get(rt.new_int(0)) }
	var_route = rt.call_function('str_replace', [rt.create_array([rt.ArrayItem{ key: none, val: '(?P<id>[\\d]+)' }, rt.ArrayItem{ key: none, val: '(?P<id>[\\w-]+)' }]), var_id_replacement.clone(), var_route.clone()])
	}
	return var_route.clone().to_string().trim_right(' \t\n\r')
}

fn Class_WC_CLI_REST_Command.limit_item_to_fields(var_item rt.PhpVal, var_fields rt.PhpVal) rt.PhpVal {
	mut var_fields_mutated := var_fields
	if !rt.is_true(var_fields_mutated) {
		return var_item.clone()
	}
	if rt.is_true(rt.new_bool(var_fields_mutated.clone().is_string())) {
	var_fields_mutated = rt.call_function('explode', [rt.new_string(','), var_fields_mutated.clone()])
	}
	mut iter_6 := var_item.iterator()
	for {
		item_6 := iter_6.next() or { break }
		mut var_field := item_6.val
		mut var_i := item_6.key
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_i.clone(), var_fields_mutated.clone(), rt.new_bool(true)]))))) {
			var_item.array_unset(var_i)
		}
	}
	return var_item.clone()
}

fn (mut this Class_WC_CLI_REST_Command) decode_json(var_arr rt.PhpVal) rt.PhpVal {
	mut var_arr_mutated := var_arr
	mut iter_7 := var_arr_mutated.iterator()
	for {
		item_7 := iter_7.next() or { break }
		mut var_value := item_7.val
		mut var_key := item_7.key
		if rt.is_true(rt.identical(rt.new_string('['), rt.call_function('substr', [var_value.clone(), rt.new_int(0), rt.new_int(1)]))) || rt.is_true(rt.identical(rt.new_string('{'), rt.call_function('substr', [var_value.clone(), rt.new_int(0), rt.new_int(1)]))) {
			var_arr_mutated.array_set(var_key, rt.call_function('json_decode', [var_value.clone(), rt.new_bool(true)]))
		} else {
			continue
		}
	}
	return var_arr_mutated.clone()
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

fn create_wp_cli(_args ...rt.PhpVal) &Class_WP_CLI {
	mut obj := &Class_WP_CLI{
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

fn create_automattic_jetpack_constants(_args ...rt.PhpVal) &Class_Automattic_Jetpack_Constants {
	mut obj := &Class_Automattic_Jetpack_Constants{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_utilities_numberutil(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Utilities_NumberUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_NumberUtil{
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



fn main() {
	defer {
		rt.shutdown()
	}

	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))))) {
		exit(0)
	}
}
