import rt

struct Class_WC_Logger {
	rt.PhpObjectBase
pub mut:
		handlers rt.PhpVal = rt.new_null()
		threshold rt.PhpVal = rt.new_null()
}

fn (mut this Class_WC_Logger) construct(var_handlers rt.PhpVal, var_threshold rt.PhpVal)  {
	mut var_handlers_mutated := var_handlers
	mut var_threshold_mutated := var_threshold
	if rt.is_true(rt.new_bool(var_handlers_mutated.dup().is_array())) {
		this.handlers = var_handlers_mutated.dup()
	}
	if rt.is_true(rt.new_bool(var_threshold_mutated.dup().is_string())) {
		this.threshold = var_threshold_mutated.dup()
	}
}

fn (mut this Class_WC_Logger) get_handlers() rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(this.handlers.is_null()))))) {
		mut var_handlers := this.handlers
	} else {
		mut var_default_handler := fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Utilities_LoggingUtil{}; return temp.get_default_handler() }()
		mut var_handler_instance := rt.create_object_dynamically(var_default_handler, []rt.PhpVal{})
		var_handlers = rt.call_function('apply_filters', [rt.new_string('woocommerce_register_log_handlers'), rt.create_array([rt.ArrayItem{ key: none, val: var_handler_instance }])])
	}
	mut var_registered_handlers := []rt.PhpVal{}
	if rt.is_true(rt.new_bool(!(!rt.is_true(var_handlers)) && rt.is_true(rt.new_bool(var_handlers.dup().is_array())))) {
		{
			mut iter_1 := var_handlers.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_handler := item_1.val
				if rt.is_true(rt.new_bool(rt.instance_of(var_handler, 'WC_Log_Handler_Interface'))) {
					var_registered_handlers << var_handler.dup()
				} else {
					rt.call_function('wc_doing_it_wrong', [rt.new_string(@METHOD), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('The provided handler %1$s does not implement %2$s.'), rt.new_string('woocommerce')]), '<code>' + (rt.call_function('esc_html', [if rt.is_true(rt.new_bool(var_handler.dup().is_object())) { rt.call_function('get_class', [var_handler.dup()]) } else { var_handler }])).str() + '</code>', rt.new_string('<code>WC_Log_Handler_Interface</code>')]), rt.new_string('3.0')])
				}
			}
		}
	}
	return var_registered_handlers.dup()
}

fn (mut this Class_WC_Logger) get_threshold() rt.PhpVal {
	mut var_threshold := this.threshold
	if rt.is_true(rt.new_bool(!(rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Log_Levels{}; return temp.is_valid_level(arg_0) }(var_threshold.dup()))))) {
		var_threshold = fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Utilities_LoggingUtil{}; return temp.get_level_threshold() }()
	}
	return fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Log_Levels{}; return temp.get_level_severity(arg_0) }(var_threshold.dup())
}

fn (mut this Class_WC_Logger) should_handle(var_level rt.PhpVal) bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Utilities_LoggingUtil{}; return temp.logging_is_enabled() }())))) {
		return false
	}
	mut var_threshold := this.get_threshold()
	return (rt.less_equal(var_threshold, fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Log_Levels{}; return temp.get_level_severity(arg_0) }(var_level.dup()))).to_bool()
}

fn (mut this Class_WC_Logger) add(var_handle rt.PhpVal, var_message rt.PhpVal, var_level rt.PhpVal) bool {
	mut var_message_mutated := var_message
	var_message_mutated = rt.call_function('apply_filters', [rt.new_string('woocommerce_logger_add_message'), var_message_mutated.dup(), var_handle.dup()])
	this.log(var_level.dup(), var_message_mutated.dup(), rt.create_array([rt.ArrayItem{ key: 'source', val: var_handle }, rt.ArrayItem{ key: '_legacy', val: true }]))
	rt.call_function('wc_do_deprecated_action', [rt.new_string('woocommerce_log_add'), rt.create_array([rt.ArrayItem{ key: none, val: var_handle }, rt.ArrayItem{ key: none, val: var_message_mutated }]), rt.new_string('3.0'), rt.new_string('This action has been deprecated with no alternative.')])
	return true
}

fn (mut this Class_WC_Logger) log(var_level rt.PhpVal, var_message rt.PhpVal, var_context rt.PhpVal)  {
	mut var_message_mutated := var_message
	if rt.is_true(rt.new_bool(!(rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Log_Levels{}; return temp.is_valid_level(arg_0) }(var_level.dup()))))) {
		rt.call_function('wc_doing_it_wrong', [rt.new_string(@METHOD), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('%1$s was called with an invalid level "%2$s".'), rt.new_string('woocommerce')]), rt.new_string('<code>WC_Logger::log</code>'), var_level.dup()]), rt.new_string('3.0')])
	}
	if this.should_handle(var_level.dup()) {
		mut var_timestamp := rt.call_function('time', []rt.PhpVal{})
		for var_handler in this.get_handlers() {
			mut var_filtered_message := rt.call_function('apply_filters', [rt.new_string('woocommerce_logger_log_message'), var_message_mutated.dup(), var_level.dup(), var_context.dup(), var_handler.dup()])
			if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
				rt.call_method(var_handler, 'handle', [var_timestamp.dup(), var_level.dup(), var_filtered_message.dup(), var_context.dup()])
			}
		}
	}
}

fn (mut this Class_WC_Logger) emergency(var_message rt.PhpVal, var_context rt.PhpVal)  {
	mut var_message_mutated := var_message
	this.log(Class_WC_Log_Levels.emergency(), var_message_mutated.dup(), var_context.dup())
}

fn (mut this Class_WC_Logger) alert(var_message rt.PhpVal, var_context rt.PhpVal)  {
	mut var_message_mutated := var_message
	this.log(Class_WC_Log_Levels.alert(), var_message_mutated.dup(), var_context.dup())
}

fn (mut this Class_WC_Logger) critical(var_message rt.PhpVal, var_context rt.PhpVal)  {
	mut var_message_mutated := var_message
	this.log(Class_WC_Log_Levels.critical(), var_message_mutated.dup(), var_context.dup())
}

fn (mut this Class_WC_Logger) error(var_message rt.PhpVal, var_context rt.PhpVal)  {
	mut var_message_mutated := var_message
	this.log(Class_WC_Log_Levels.error(), var_message_mutated.dup(), var_context.dup())
}

fn (mut this Class_WC_Logger) warning(var_message rt.PhpVal, var_context rt.PhpVal)  {
	mut var_message_mutated := var_message
	this.log(Class_WC_Log_Levels.warning(), var_message_mutated.dup(), var_context.dup())
}

fn (mut this Class_WC_Logger) notice(var_message rt.PhpVal, var_context rt.PhpVal)  {
	mut var_message_mutated := var_message
	this.log(Class_WC_Log_Levels.notice(), var_message_mutated.dup(), var_context.dup())
}

fn (mut this Class_WC_Logger) info(var_message rt.PhpVal, var_context rt.PhpVal)  {
	mut var_message_mutated := var_message
	this.log(Class_WC_Log_Levels.info(), var_message_mutated.dup(), var_context.dup())
}

fn (mut this Class_WC_Logger) debug(var_message rt.PhpVal, var_context rt.PhpVal)  {
	mut var_message_mutated := var_message
	this.log(Class_WC_Log_Levels.debug(), var_message_mutated.dup(), var_context.dup())
}

fn (mut this Class_WC_Logger) clear(source string, quiet bool) bool {
	if !(var_source.len > 0 && var_source != '0') {
		return false
	}
	for var_handler in this.get_handlers() {
		if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.instance_of(var_handler, 'WC_Log_Handler'))) && rt.is_true(rt.call_function('is_callable', [rt.create_array([rt.ArrayItem{ key: none, val: var_handler }, rt.ArrayItem{ key: none, val: 'clear' }])])))) {
			rt.call_method(var_handler, 'clear', [rt.new_string(source), rt.new_bool(quiet)])
		}
	}
	return true
}

fn (mut this Class_WC_Logger) clear_expired_logs()  {
	mut var_days := fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Utilities_LoggingUtil{}; return temp.get_retention_period() }()
	mut var_timestamp := rt.call_function('strtotime', [rt.new_string("-${var_days.to_string()} days")])
	for var_handler in this.get_handlers() {
		if rt.is_true(rt.call_function('is_callable', [rt.create_array([rt.ArrayItem{ key: none, val: var_handler }, rt.ArrayItem{ key: none, val: 'delete_logs_before_timestamp' }])])) {
			rt.call_method(var_handler, 'delete_logs_before_timestamp', [var_timestamp.dup()])
		}
	}
}

struct Class_Automattic_WooCommerce_Utilities_LoggingUtil {
	rt.PhpObjectBase
}

struct Class_WC_Log_Levels {
	rt.PhpObjectBase
}

fn create_wc_logger(arg_0 rt.PhpVal, arg_1 rt.PhpVal) &Class_WC_Logger {
	mut obj := &Class_WC_Logger{
		PhpObjectBase: rt.PhpObjectBase{}
		handlers: rt.new_null()
		threshold: rt.new_null()
	}
	obj.construct(arg_0, arg_1)
	return obj
}

fn create_automattic_woocommerce_utilities_loggingutil() &Class_Automattic_WooCommerce_Utilities_LoggingUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_LoggingUtil{
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

fn (mut this Class_WC_Logger) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.construct(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'get_handlers' {
			return this.get_handlers()
		}
		'get_threshold' {
			return this.get_threshold()
		}
		'should_handle' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.should_handle(dispatch_arg_0))
		}
		'add' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return rt.new_bool(this.add(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2))
		}
		'log' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			this.log(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'emergency' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.emergency(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'alert' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.alert(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'critical' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.critical(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'error' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.error(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'warning' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.warning(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'notice' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.notice(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'info' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.info(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'debug' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.debug(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'clear' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			return rt.new_bool(this.clear(dispatch_arg_0, dispatch_arg_1))
		}
		'clear_expired_logs' {
			this.clear_expired_logs()
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_WC_Logger) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'handlers' { return this.handlers }
		'threshold' { return this.threshold }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_Logger) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'handlers' { this.handlers = val; return true }
		'threshold' { this.threshold = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_WooCommerce_Utilities_LoggingUtil) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Utilities_LoggingUtil) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_LoggingUtil) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn init_registry() {
	rt.register_class_factory('WC_Logger', fn(args []rt.PhpVal) rt.PhpVal {
		c_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		c_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		obj := create_wc_logger(c_arg_0, c_arg_1)
		return rt.new_object('WC_Logger', ['WC_Logger_Interface'], obj)
	})
	rt.register_class_factory('Automattic_WooCommerce_Utilities_LoggingUtil', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_utilities_loggingutil()
		return rt.new_object('Automattic_WooCommerce_Utilities_LoggingUtil', []string{}, obj)
	})
	rt.register_class_factory('WC_Log_Levels', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wc_log_levels()
		return rt.new_object('WC_Log_Levels', []string{}, obj)
	})
}

fn init() {
	init_registry()
}



pub fn init_wp_content_plugins_woocommerce_includes_class_wc_logger_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
