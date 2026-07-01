import rt

struct Class_WC_Log_Handler_DB {
	rt.PhpObjectBase
}

fn (mut this Class_WC_Log_Handler_DB) handle(var_timestamp rt.PhpVal, var_level rt.PhpVal, var_message rt.PhpVal, var_context rt.PhpVal) rt.PhpVal {
	mut var_context_mutated := var_context
	if rt.is_true(rt.new_bool(var_context_mutated.array_isset(rt.new_string('source')) && rt.is_true(var_context_mutated.array_get('source')))) {
		mut var_source := var_context_mutated.array_get('source')
	} else {
		var_source = rt.new_string(this.get_log_source())
	}
	mut var_cached_sources := rt.call_function('get_option', [Class_WC_Admin_Log_Table_List.source_cache_option_key(), rt.new_array()])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_source.dup(), var_cached_sources.dup(), rt.new_bool(true)]))))) {
		rt.call_function('delete_option', [Class_WC_Admin_Log_Table_List.source_cache_option_key()])
	}
	return this.add(var_timestamp.dup(), var_level.dup(), var_message.dup(), var_source.dup(), var_context_mutated.dup())
}

fn Class_WC_Log_Handler_DB.add(var_timestamp rt.PhpVal, var_level rt.PhpVal, var_message rt.PhpVal, var_source rt.PhpVal, var_context rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_source_mutated := var_source
	mut var_context_mutated := var_context
	// unsupported statement: Stmt_Global
	mut var_insert := { 'timestamp': rt.call_function('date', [rt.new_string('Y-m-d H:i:s'), var_timestamp.dup()]), 'level': fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Log_Levels{}; return temp.get_level_severity(arg_0) }(var_level.dup()), 'message': var_message, 'source': var_source_mutated }
	mut var_format := rt.create_array([rt.ArrayItem{ key: none, val: '%s' }, rt.ArrayItem{ key: none, val: '%d' }, rt.ArrayItem{ key: none, val: '%s' }, rt.ArrayItem{ key: none, val: '%s' }, rt.ArrayItem{ key: none, val: '%s' }])
	var_context_mutated.array_unset(rt.new_string('source'))
	if !(!rt.is_true(var_context_mutated)) {
		if rt.is_true(rt.new_bool(var_context_mutated.array_isset(rt.new_string('backtrace')) && rt.is_true(rt.identical(rt.new_bool(true), rt.call_function('filter_var', [var_context_mutated.array_get('backtrace'), rt.get_constant('FILTER_VALIDATE_BOOLEAN')]))))) {
			var_context_mutated.array_set('backtrace', fn () rt.PhpVal { mut temp := Class_WC_Log_Handler_DB{}; return temp.get_backtrace() }())
		}
		var_insert['context'] = rt.call_function('wp_json_encode', [var_context_mutated.dup(), rt.get_constant('JSON_PRETTY_PRINT')])
	}
	return // unsupported expression: Expr_BinaryOp_NotIdentical
}

fn Class_WC_Log_Handler_DB.flush() rt.PhpVal {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	return rt.call_method(var_wpdb, 'query', [rt.concat(rt.concat(rt.new_string('TRUNCATE TABLE '), rt.get_property(var_wpdb, 'prefix')), rt.new_string('woocommerce_log'))])
}

fn (mut this Class_WC_Log_Handler_DB) clear(var_source rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_source_mutated := var_source
	// unsupported statement: Stmt_Global
	return rt.call_method(var_wpdb, 'query', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.new_string('DELETE FROM '), rt.get_property(var_wpdb, 'prefix')), rt.new_string('woocommerce_log WHERE source = %s')), var_source_mutated.dup()])])
}

fn Class_WC_Log_Handler_DB.delete(var_log_ids rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_log_ids_mutated := var_log_ids
	// unsupported statement: Stmt_Global
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_log_ids_mutated.dup().is_array()))))) {
		var_log_ids_mutated = rt.create_array([rt.ArrayItem{ key: none, val: var_log_ids_mutated }])
	}
	mut var_format := rt.call_function('array_fill', [rt.new_int(0), rt.new_int(var_log_ids_mutated.dup().array_count()), rt.new_string('%d')])
	mut var_query_in := rt.new_string('(' + (rt.call_function('implode', [rt.new_string(','), var_format.dup()])).str() + ')')
	mut var_result := rt.call_method(var_wpdb, 'query', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('\n\t\t\t\t\tDELETE FROM '), rt.get_property(var_wpdb, 'prefix')), rt.new_string('woocommerce_log\n\t\t\t\t\tWHERE log_id IN ')), var_query_in), rt.new_string('\n\t\t\t\t')), var_log_ids_mutated.dup()])])
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Cache_Helper{}; return temp.get_transient_version(arg_0, arg_1) }(rt.new_string('logs-db'), rt.new_bool(true))
	}
	return var_result.dup()
}

fn Class_WC_Log_Handler_DB.delete_logs_before_timestamp(timestamp i64)  {
	mut var_wpdb := rt.new_null()
	if !(var_timestamp != 0) {
		return rt.new_null()
	}
	// unsupported statement: Stmt_Global
	rt.call_method(var_wpdb, 'query', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.new_string('DELETE FROM '), rt.get_property(var_wpdb, 'prefix')), rt.new_string('woocommerce_log WHERE timestamp < %s')), rt.call_function('date', [rt.new_string('Y-m-d H:i:s'), rt.new_int(timestamp)])])])
	fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Cache_Helper{}; return temp.get_transient_version(arg_0, arg_1) }(rt.new_string('logs-db'), rt.new_bool(true))
}

fn Class_WC_Log_Handler_DB.get_log_source() string {
	mut var_ignore_files := rt.new_null()
	// unsupported statement: Stmt_Static
	if rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_Jetpack_Constants{}; return temp.is_defined(arg_0) }(rt.new_string('DEBUG_BACKTRACE_IGNORE_ARGS'))) {
		mut var_debug_backtrace_arg := rt.get_constant('DEBUG_BACKTRACE_IGNORE_ARGS')
		// unsupported statement: Stmt_Nop
	} else {
		var_debug_backtrace_arg = rt.new_bool(rt.new_bool(false))
	}
	mut var_trace := rt.call_function('debug_backtrace', [var_debug_backtrace_arg.dup()])
	{
		mut iter_1 := var_trace.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_t := item_1.val
			if var_t.array_isset(rt.new_string('file')) {
				mut var_filename := rt.call_function('pathinfo', [var_t.array_get('file'), rt.get_constant('PATHINFO_FILENAME')])
				if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_filename.dup(), var_ignore_files.dup(), rt.new_bool(true)]))))) {
					return (var_filename).str()
				}
			}
		}
	}
	return ''
}

struct Class_WC_Log_Handler {
	rt.PhpObjectBase
}

struct Class_WC_Log_Levels {
	rt.PhpObjectBase
}

struct Class_WC_Cache_Helper {
	rt.PhpObjectBase
}

struct Class_Automattic_Jetpack_Constants {
	rt.PhpObjectBase
}

fn create_wc_log_handler_db() &Class_WC_Log_Handler_DB {
	mut obj := &Class_WC_Log_Handler_DB{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_log_handler() &Class_WC_Log_Handler {
	mut obj := &Class_WC_Log_Handler{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_log_levels() &Class_WC_Log_Levels {
	mut obj := &Class_WC_Log_Levels{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_cache_helper() &Class_WC_Cache_Helper {
	mut obj := &Class_WC_Cache_Helper{
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

fn (mut this Class_WC_Log_Handler_DB) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'handle' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			return this.handle(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
		}
		'add' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			dispatch_arg_4 := if args.len > 4 { args[4] } else { rt.new_null() }
			return Class_WC_Log_Handler_DB.add(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3, dispatch_arg_4)
		}
		'flush' {
			return Class_WC_Log_Handler_DB.flush()
		}
		'clear' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.clear(dispatch_arg_0)
		}
		'delete' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WC_Log_Handler_DB.delete(dispatch_arg_0)
		}
		'delete_logs_before_timestamp' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			Class_WC_Log_Handler_DB.delete_logs_before_timestamp(dispatch_arg_0)
			return rt.new_null()
		}
		'get_log_source' {
			return rt.new_string(Class_WC_Log_Handler_DB.get_log_source())
		}
		else { return none }
	}
}

fn (this &Class_WC_Log_Handler_DB) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Log_Handler_DB) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_Log_Handler) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Log_Handler) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Log_Handler) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_Log_Levels) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Log_Levels) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Log_Levels) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_Cache_Helper) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Cache_Helper) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Cache_Helper) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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




pub fn init_wp_content_plugins_woocommerce_includes_log_handlers_class_wc_log_handler_db_php() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))))) {
		// unsupported expression: Expr_Exit
		// unsupported statement: Stmt_Nop
	}
}
