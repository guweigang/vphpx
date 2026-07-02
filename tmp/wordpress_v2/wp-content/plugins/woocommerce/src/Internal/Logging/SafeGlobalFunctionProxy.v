import rt

struct Class_Automattic_WooCommerce_Internal_Logging_SafeGlobalFunctionProxy {
	rt.PhpObjectBase
}

fn Class_Automattic_WooCommerce_Internal_Logging_SafeGlobalFunctionProxy.maybe_load_missing_function(var_name rt.PhpVal) {
	mut var_function_map := rt.create_array([
		rt.ArrayItem{ key: 'wp_parse_url', val:
			(rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/http.php' },
		rt.ArrayItem{
			key: 'home_url'
			val:
				(rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/link-template.php'
		},
		rt.ArrayItem{
			key: 'get_bloginfo'
			val:
				(rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/general-template.php'
		},
		rt.ArrayItem{ key: 'get_option', val:
			(rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/option.php' },
		rt.ArrayItem{ key: 'get_site_transient', val:
			(rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/option.php' },
		rt.ArrayItem{ key: 'set_site_transient', val:
			(rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/option.php' },
		rt.ArrayItem{ key: 'wp_safe_remote_post', val:
			(rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/http.php' },
		rt.ArrayItem{ key: 'is_wp_error', val:
			(rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/load.php' },
		rt.ArrayItem{ key: 'get_plugin_updates', val: rt.create_array([
			rt.ArrayItem{ key: none, val:
				(rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/update.php' },
			rt.ArrayItem{ key: none, val:
				(rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/plugin.php' },
		]) },
		rt.ArrayItem{ key: 'wp_get_environment_type', val:
			(rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/load.php' },
		rt.ArrayItem{ key: 'wp_json_encode', val:
			(rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/functions.php' },
		rt.ArrayItem{ key: 'wc_get_logger', val:
			(rt.get_constant('WC_ABSPATH')).str() + 'includes/class-wc-logger.php' },
		rt.ArrayItem{ key: 'wc_print_r', val:
			(rt.get_constant('WC_ABSPATH')).str() + 'includes/wc-core-functions.php' },
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		var_name.clone(),
	])))))
	{
		if var_function_map.array_isset(var_name) {
			mut var_files := rt.cast_array(var_function_map.array_get(var_name))
			mut iter_1 := var_files.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_file := item_1.val
				rt.include_file(var_file.to_string(), '4')
			}
		} else {
			rt.throw_exception(rt.new_object('Automattic_WooCommerce_Internal_Logging_Exception',
				[]string{}, create_automattic_woocommerce_internal_logging_exception(rt.call_function('sprintf', [
				rt.new_string('Function %s does not exist and could not be loaded.'),
				rt.call_function('esc_html', [var_name.clone()]),
			]))))
		}
	}
}

fn Class_Automattic_WooCommerce_Internal_Logging_SafeGlobalFunctionProxy.magic_callstatic(var_name rt.PhpVal, var_arguments rt.PhpVal) rt.PhpVal {
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_type := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_message := if args.len > 1 { args[1].clone() } else { rt.new_null() }
		mut var_file := if args.len > 2 { args[2].clone() } else { rt.new_null() }
		mut var_line := if args.len > 3 { args[3].clone() } else { rt.new_null() }
		if rt.is_true(rt.identical(rt.new_string(@FILE), var_file)) {
			mut var_trace := rt.call_function('debug_backtrace', [
				rt.get_constant('DEBUG_BACKTRACE_IGNORE_ARGS'),
				rt.new_int(3),
			])
			var_file = if !(var_trace.array_get(rt.new_int(2)).array_get(rt.new_string('file'))).is_null() {
				var_trace.array_get(rt.new_int(2)).array_get(rt.new_string('file'))
			} else {
				var_file
			}
			var_line = if !(var_trace.array_get(rt.new_int(2)).array_get(rt.new_string('line'))).is_null() {
				var_trace.array_get(rt.new_int(2)).array_get(rt.new_string('line'))
			} else {
				var_line
			}
		}
		mut var_sanitized_message := rt.call_function('filter_var', [
			var_message.clone(), rt.get_constant('FILTER_SANITIZE_FULL_SPECIAL_CHARS')])
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Internal_Logging_ErrorException',
			[]string{}, create_automattic_woocommerce_internal_logging_errorexception(var_sanitized_message.clone(),
			rt.new_int(0), var_type.clone(), var_file.clone(), var_line.clone())))
		return rt.new_null()
	}
	closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_type := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_message := if args.len > 1 { args[1].clone() } else { rt.new_null() }
		mut var_file := if args.len > 2 { args[2].clone() } else { rt.new_null() }
		mut var_line := if args.len > 3 { args[3].clone() } else { rt.new_null() }
		if rt.is_true(rt.identical(rt.new_string(@FILE), var_file)) {
			mut var_trace := rt.call_function('debug_backtrace', [
				rt.get_constant('DEBUG_BACKTRACE_IGNORE_ARGS'),
				rt.new_int(3),
			])
			var_file = if !(var_trace.array_get(rt.new_int(2)).array_get(rt.new_string('file'))).is_null() {
				var_trace.array_get(rt.new_int(2)).array_get(rt.new_string('file'))
			} else {
				var_file
			}
			var_line = if !(var_trace.array_get(rt.new_int(2)).array_get(rt.new_string('line'))).is_null() {
				var_trace.array_get(rt.new_int(2)).array_get(rt.new_string('line'))
			} else {
				var_line
			}
		}
		mut var_sanitized_message := rt.call_function('filter_var', [
			var_message.clone(), rt.get_constant('FILTER_SANITIZE_FULL_SPECIAL_CHARS')])
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Internal_Logging_ErrorException',
			[]string{}, create_automattic_woocommerce_internal_logging_errorexception(var_sanitized_message.clone(),
			rt.new_int(0), var_type.clone(), var_file.clone(), var_line.clone())))
		return rt.new_null()
	}
	rt.call_function('set_error_handler', [rt.new_closure(closure_1_fn)])
	Class_Automattic_WooCommerce_Internal_Logging_SafeGlobalFunctionProxy.maybe_load_missing_function(var_name.clone())
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	mut var_results := rt.call_function('call_user_func_array', [
		var_name.clone(), var_arguments.clone()])
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	unsafe {
		goto finally_label_1
	}
	catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'Automattic_WooCommerce_Internal_Logging_Throwable') {
		mut var_e := var_e_1.clone()
		Class_Automattic_WooCommerce_Internal_Logging_SafeGlobalFunctionProxy.log_wrapper_error(var_name.clone(), rt.call_method(var_e,
			'getMessage', []rt.PhpVal{}), var_arguments.clone())
		var_results = rt.new_null()
		unsafe {
			goto finally_label_1
		}
	} else {
		rt.throw_exception(var_e_1)
		unsafe {
			goto finally_label_1
		}
	}

	finally_label_1:
	rt.call_function('restore_error_handler', []rt.PhpVal{})
	if rt.has_exception() { return rt.new_null() }

	end_label_1:
	return var_results.clone()
}

fn Class_Automattic_WooCommerce_Internal_Logging_SafeGlobalFunctionProxy.log_wrapper_error(var_function_name rt.PhpVal, var_error_message rt.PhpVal, var_context rt.PhpVal) {
	Class_Automattic_WooCommerce_Internal_Logging_SafeGlobalFunctionProxy.maybe_load_missing_function(rt.new_string('wc_get_logger'))
	rt.call_method(rt.call_function('wc_get_logger', []rt.PhpVal{}), 'error', [
		rt.new_string('[Wrapper function error] ' +(rt.call_function('sprintf', [rt.new_string('Error in %s: %s'), var_function_name.clone(), var_error_message.clone()])).str()),
		rt.call_function('array_merge', [
			rt.create_array([rt.ArrayItem{ key: 'function', val: var_function_name },
				rt.ArrayItem{ key: 'source', val: 'remote-logging' }]),
			var_context.clone(),
		]),
	])
}

struct Class_Automattic_WooCommerce_Internal_Logging_Exception {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Logging_ErrorException {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_logging_safeglobalfunctionproxy(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Logging_SafeGlobalFunctionProxy {
	mut obj := &Class_Automattic_WooCommerce_Internal_Logging_SafeGlobalFunctionProxy{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_logging_exception(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Logging_Exception {
	mut obj := &Class_Automattic_WooCommerce_Internal_Logging_Exception{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_logging_errorexception(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Logging_ErrorException {
	mut obj := &Class_Automattic_WooCommerce_Internal_Logging_ErrorException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_Logging_SafeGlobalFunctionProxy) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'maybe_load_missing_function' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			Class_Automattic_WooCommerce_Internal_Logging_SafeGlobalFunctionProxy.maybe_load_missing_function(dispatch_arg_0)
			return rt.new_null()
		}
		'__callStatic' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Internal_Logging_SafeGlobalFunctionProxy.magic_callstatic(dispatch_arg_0,
				dispatch_arg_1)
		}
		'log_wrapper_error' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			Class_Automattic_WooCommerce_Internal_Logging_SafeGlobalFunctionProxy.log_wrapper_error(dispatch_arg_0,
				dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Logging_SafeGlobalFunctionProxy) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Logging_SafeGlobalFunctionProxy) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Logging_Exception) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Logging_Exception) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Logging_Exception) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Logging_ErrorException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Logging_ErrorException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Logging_ErrorException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
