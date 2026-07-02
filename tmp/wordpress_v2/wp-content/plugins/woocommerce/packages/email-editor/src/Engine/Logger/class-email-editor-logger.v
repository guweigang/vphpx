import rt

struct Class_Automattic_WooCommerce_EmailEditor_Engine_Logger_Email_Editor_Logger {
	rt.PhpObjectBase
pub mut:
		logger rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Logger_Email_Editor_Logger) construct(mut var_logger Class_Automattic_WooCommerce_EmailEditor_Engine_Logger_?Email_Editor_Logger_Interface) {
	this.logger = if !(var_logger).is_null() { var_logger } else { create_automattic_woocommerce_emaileditor_engine_logger_default_email_editor_logger() }
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Logger_Email_Editor_Logger) set_logger(mut var_logger Class_Automattic_WooCommerce_EmailEditor_Engine_Logger_Email_Editor_Logger_Interface) {
	this.logger = var_logger
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Logger_Email_Editor_Logger) emergency(message string, mut var_context Class_Automattic_WooCommerce_EmailEditor_Engine_Logger_array) {
	rt.call_method(this.logger, 'emergency', [rt.new_string(message), var_context])
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Logger_Email_Editor_Logger) alert(message string, mut var_context Class_Automattic_WooCommerce_EmailEditor_Engine_Logger_array) {
	rt.call_method(this.logger, 'alert', [rt.new_string(message), var_context])
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Logger_Email_Editor_Logger) critical(message string, mut var_context Class_Automattic_WooCommerce_EmailEditor_Engine_Logger_array) {
	rt.call_method(this.logger, 'critical', [rt.new_string(message), var_context])
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Logger_Email_Editor_Logger) error(message string, mut var_context Class_Automattic_WooCommerce_EmailEditor_Engine_Logger_array) {
	rt.call_method(this.logger, 'error', [rt.new_string(message), var_context])
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Logger_Email_Editor_Logger) warning(message string, mut var_context Class_Automattic_WooCommerce_EmailEditor_Engine_Logger_array) {
	rt.call_method(this.logger, 'warning', [rt.new_string(message), var_context])
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Logger_Email_Editor_Logger) notice(message string, mut var_context Class_Automattic_WooCommerce_EmailEditor_Engine_Logger_array) {
	rt.call_method(this.logger, 'notice', [rt.new_string(message), var_context])
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Logger_Email_Editor_Logger) info(message string, mut var_context Class_Automattic_WooCommerce_EmailEditor_Engine_Logger_array) {
	rt.call_method(this.logger, 'info', [rt.new_string(message), var_context])
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Logger_Email_Editor_Logger) debug(message string, mut var_context Class_Automattic_WooCommerce_EmailEditor_Engine_Logger_array) {
	rt.call_method(this.logger, 'debug', [rt.new_string(message), var_context])
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Logger_Email_Editor_Logger) log(level string, message string, mut var_context Class_Automattic_WooCommerce_EmailEditor_Engine_Logger_array) {
	rt.call_method(this.logger, 'log', [rt.new_string(level), rt.new_string(message), var_context])
}

struct Class_Automattic_WooCommerce_EmailEditor_Engine_Logger_Default_Email_Editor_Logger {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_emaileditor_engine_logger_email_editor_logger(arg_0 rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditor_Engine_Logger_Email_Editor_Logger {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Engine_Logger_Email_Editor_Logger{
		PhpObjectBase: rt.PhpObjectBase{}
		logger: rt.new_null()
	}
	obj.construct(arg_0)
	return obj
}

fn create_automattic_woocommerce_emaileditor_engine_logger_default_email_editor_logger(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditor_Engine_Logger_Default_Email_Editor_Logger {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Engine_Logger_Default_Email_Editor_Logger{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Logger_Email_Editor_Logger) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Logger_?Email_Editor_Logger_Interface](if args.len > 0 { args[0] } else { rt.new_null() })
			this.construct(mut dispatch_arg_0)
			return rt.new_null()
		}
		'set_logger' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Logger_Email_Editor_Logger_Interface](if args.len > 0 { args[0] } else { rt.new_null() })
			this.set_logger(mut dispatch_arg_0)
			return rt.new_null()
		}
		'emergency' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Logger_array](if args.len > 1 { args[1] } else { rt.new_null() })
			this.emergency(dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'alert' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Logger_array](if args.len > 1 { args[1] } else { rt.new_null() })
			this.alert(dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'critical' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Logger_array](if args.len > 1 { args[1] } else { rt.new_null() })
			this.critical(dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'error' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Logger_array](if args.len > 1 { args[1] } else { rt.new_null() })
			this.error(dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'warning' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Logger_array](if args.len > 1 { args[1] } else { rt.new_null() })
			this.warning(dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'notice' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Logger_array](if args.len > 1 { args[1] } else { rt.new_null() })
			this.notice(dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'info' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Logger_array](if args.len > 1 { args[1] } else { rt.new_null() })
			this.info(dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'debug' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Logger_array](if args.len > 1 { args[1] } else { rt.new_null() })
			this.debug(dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'log' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Logger_array](if args.len > 2 { args[2] } else { rt.new_null() })
			this.log(dispatch_arg_0, dispatch_arg_1, mut dispatch_arg_2)
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Engine_Logger_Email_Editor_Logger) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'logger' { return this.logger }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Logger_Email_Editor_Logger) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'logger' { this.logger = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Logger_Default_Email_Editor_Logger) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Engine_Logger_Default_Email_Editor_Logger) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Logger_Default_Email_Editor_Logger) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}



fn main() {
	defer {
		rt.shutdown()
	}

}
