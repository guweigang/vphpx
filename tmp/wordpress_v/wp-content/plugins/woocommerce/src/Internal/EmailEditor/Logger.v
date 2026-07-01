import rt

struct Class_Automattic_WooCommerce_Internal_EmailEditor_Logger {
	rt.PhpObjectBase
pub mut:
	wc_logger rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_Logger) construct(mut var_wc_logger Class_Automattic_WooCommerce_Internal_EmailEditor_WC_Logger_Interface) {
	this.wc_logger = var_wc_logger.dup()
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_Logger) should_handle(level string) bool {
	mut var_logging_threshold := rt.call_function('apply_filters', [
		rt.new_string('woocommerce_email_editor_logging_threshold'),
		Class_WC_Log_Levels.warning(),
	])
	return (rt.less_equal(fn (arg_0 rt.PhpVal) rt.PhpVal {
		mut temp := Class_WC_Log_Levels{}
		return temp.get_level_severity(arg_0)
	}(var_logging_threshold.dup()), fn (arg_0 rt.PhpVal) rt.PhpVal {
		mut temp := Class_WC_Log_Levels{}
		return temp.get_level_severity(arg_0)
	}(rt.new_string(level)))).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_Logger) emergency(message string, mut var_context Class_Automattic_WooCommerce_Internal_EmailEditor_array) {
	this.log((Class_WC_Log_Levels.emergency()).str(), message, mut var_context)
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_Logger) alert(message string, mut var_context Class_Automattic_WooCommerce_Internal_EmailEditor_array) {
	this.log((Class_WC_Log_Levels.alert()).str(), message, mut var_context)
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_Logger) critical(message string, mut var_context Class_Automattic_WooCommerce_Internal_EmailEditor_array) {
	this.log((Class_WC_Log_Levels.critical()).str(), message, mut var_context)
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_Logger) error(message string, mut var_context Class_Automattic_WooCommerce_Internal_EmailEditor_array) {
	this.log((Class_WC_Log_Levels.error()).str(), message, mut var_context)
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_Logger) warning(message string, mut var_context Class_Automattic_WooCommerce_Internal_EmailEditor_array) {
	this.log((Class_WC_Log_Levels.warning()).str(), message, mut var_context)
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_Logger) notice(message string, mut var_context Class_Automattic_WooCommerce_Internal_EmailEditor_array) {
	this.log((Class_WC_Log_Levels.notice()).str(), message, mut var_context)
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_Logger) info(message string, mut var_context Class_Automattic_WooCommerce_Internal_EmailEditor_array) {
	this.log((Class_WC_Log_Levels.info()).str(), message, mut var_context)
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_Logger) debug(message string, mut var_context Class_Automattic_WooCommerce_Internal_EmailEditor_array) {
	this.log((Class_WC_Log_Levels.debug()).str(), message, mut var_context)
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_Logger) log(level string, message string, mut var_context Class_Automattic_WooCommerce_Internal_EmailEditor_array) {
	if this.should_handle(level) {
		rt.call_method(this.wc_logger, 'log', [rt.new_string(level),
			rt.new_string(message), var_context])
	}
}

struct Class_WC_Log_Levels {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_emaileditor_logger(arg_0 rt.PhpVal) &Class_Automattic_WooCommerce_Internal_EmailEditor_Logger {
	mut obj := &Class_Automattic_WooCommerce_Internal_EmailEditor_Logger{
		PhpObjectBase: rt.PhpObjectBase{}
		wc_logger:     rt.new_null()
	}
	obj.construct(arg_0)
	return obj
}

fn create_wc_log_levels() &Class_WC_Log_Levels {
	mut obj := &Class_WC_Log_Levels{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_Logger) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_EmailEditor_WC_Logger_Interface](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.construct(mut dispatch_arg_0)
			return rt.new_null()
		}
		'should_handle' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(this.should_handle(dispatch_arg_0))
		}
		'emergency' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_EmailEditor_array](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			this.emergency(dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'alert' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_EmailEditor_array](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			this.alert(dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'critical' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_EmailEditor_array](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			this.critical(dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'error' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_EmailEditor_array](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			this.error(dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'warning' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_EmailEditor_array](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			this.warning(dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'notice' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_EmailEditor_array](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			this.notice(dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'info' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_EmailEditor_array](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			this.info(dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'debug' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_EmailEditor_array](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			this.debug(dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'log' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_EmailEditor_array](if args.len > 2 {
				args[2]
			} else {
				rt.new_null()
			})
			this.log(dispatch_arg_0, dispatch_arg_1, mut dispatch_arg_2)
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_EmailEditor_Logger) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'wc_logger' { return this.wc_logger }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_Logger) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'wc_logger' {
			this.wc_logger = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
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

pub fn init_wp_content_plugins_woocommerce_src_internal_emaileditor_logger_php() {
	// unsupported statement: Stmt_Declare
}
