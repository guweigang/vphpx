import rt

struct Class_WC_Log_Handler {
	rt.PhpObjectBase
}

fn Class_WC_Log_Handler.format_time(var_timestamp rt.PhpVal) rt.PhpVal {
	return rt.call_function('gmdate', [rt.new_string('c'), var_timestamp.dup()])
}

fn Class_WC_Log_Handler.format_entry(var_timestamp rt.PhpVal, var_level rt.PhpVal, var_message rt.PhpVal, var_context rt.PhpVal) rt.PhpVal {
	mut var_time_string := Class_WC_Log_Handler.format_time(var_timestamp.dup())
	mut var_level_string := rt.new_string(rt.new_string(var_level.dup().to_string().to_upper()))
	mut var_entry :=
		rt.new_string(rt.new_string('${var_time_string.to_string()} ${var_level_string.to_string()} ${var_message.to_string()}'))
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_format_log_entry'),
		var_entry.dup(),
		rt.create_array([rt.ArrayItem{ key: 'timestamp', val: var_timestamp },
			rt.ArrayItem{ key: 'level', val: var_level }, rt.ArrayItem{
				key: 'message'
				val: var_message
			}, rt.ArrayItem{ key: 'context', val: var_context }]),
	])
}

fn Class_WC_Log_Handler.get_backtrace() rt.PhpVal {
	closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_class := if args.len > 0 { args[0].dup() } else { rt.new_null() }
			mut var_reflector := create_reflectionclass(var_class.dup())
			if rt.has_exception() {
				unsafe {
					goto catch_label_1
				}
			}
			return rt.call_method(var_reflector, 'getFileName', []rt.PhpVal{})
			unsafe {
				goto end_label_1
			}
			catch_label_1:
			mut var_e_1 := rt.get_and_clear_exception()
			if rt.instance_of(var_e_1, 'Exception') {
				mut var_exception := var_e_1.dup()
				return rt.new_null()
				unsafe {
					goto end_label_1
				}
			} else {
				rt.throw_exception(var_e_1)
				unsafe {
					goto end_label_1
				}
			}

			end_label_1:
			return rt.new_null()
		}
		mut var_class := if args.len > 0 { args[0].dup() } else { rt.new_null() }
		mut var_reflector := create_reflectionclass(var_class.dup())
		if rt.has_exception() {
			unsafe {
				goto catch_label_2
			}
		}
		return rt.call_method(var_reflector, 'getFileName', []rt.PhpVal{})
		unsafe {
			goto end_label_2
		}
		catch_label_2:
		mut var_e_2 := rt.get_and_clear_exception()
		if rt.instance_of(var_e_2, 'Exception') {
			mut var_exception := var_e_2.dup()
			return rt.new_null()
			unsafe {
				goto end_label_2
			}
		} else {
			rt.throw_exception(var_e_2)
			unsafe {
				goto end_label_2
			}
		}

		end_label_2:
		return rt.new_null()
	}
	mut var_ignore_files := rt.call_function('array_map', [rt.new_closure(closure_1_fn),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.call_function('wc_get_logger', []rt.PhpVal{}) },
			rt.ArrayItem{ key: none, val: Class_WC_Log_Handler.class() },
			rt.ArrayItem{ key: none, val: Class_static.class() },
		])])
	mut var_backtrace := rt.call_function('debug_backtrace', [
		rt.get_constant('DEBUG_BACKTRACE_IGNORE_ARGS'),
	])
	closure_3_fn := fn [var_ignore_files] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_frame := if args.len > 0 { args[0].dup() } else { rt.new_null() }
		mut var_ignore := rt.new_bool(rt.new_bool(var_frame.array_isset(rt.new_string('file'))
			&& rt.is_true(rt.call_function('in_array', [var_frame.array_get('file'), var_ignore_files.dup(), rt.new_bool(true)]))))
		return rt.new_bool(!(rt.is_true(var_ignore)))
	}
	mut var_filtered_backtrace := rt.call_function('array_filter', [
		var_backtrace.dup(), rt.new_closure(closure_3_fn)])
	return rt.call_function('array_values', [var_filtered_backtrace.dup()])
}

struct Class_ReflectionClass {
	rt.PhpObjectBase
}

fn create_wc_log_handler() &Class_WC_Log_Handler {
	mut obj := &Class_WC_Log_Handler{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_reflectionclass() &Class_ReflectionClass {
	mut obj := &Class_ReflectionClass{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Log_Handler) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'format_time' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WC_Log_Handler.format_time(dispatch_arg_0)
		}
		'format_entry' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			return Class_WC_Log_Handler.format_entry(dispatch_arg_0, dispatch_arg_1,
				dispatch_arg_2, dispatch_arg_3)
		}
		'get_backtrace' {
			return Class_WC_Log_Handler.get_backtrace()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_Log_Handler) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Log_Handler) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_ReflectionClass) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ReflectionClass) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ReflectionClass) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_content_plugins_woocommerce_includes_abstracts_abstract_wc_log_handler_php() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		// unsupported expression: Expr_Exit
		// unsupported statement: Stmt_Nop
	}
}
