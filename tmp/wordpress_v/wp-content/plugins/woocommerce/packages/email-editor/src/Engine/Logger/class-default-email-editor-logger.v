import rt

pub fn Class_Automattic_WooCommerce_EmailEditor_Engine_Logger_Default_Email_Editor_Logger.emergency() string {
	return 'emergency'
}

pub fn Class_Automattic_WooCommerce_EmailEditor_Engine_Logger_Default_Email_Editor_Logger.alert() string {
	return 'alert'
}

pub fn Class_Automattic_WooCommerce_EmailEditor_Engine_Logger_Default_Email_Editor_Logger.critical() string {
	return 'critical'
}

pub fn Class_Automattic_WooCommerce_EmailEditor_Engine_Logger_Default_Email_Editor_Logger.error() string {
	return 'error'
}

pub fn Class_Automattic_WooCommerce_EmailEditor_Engine_Logger_Default_Email_Editor_Logger.warning() string {
	return 'warning'
}

pub fn Class_Automattic_WooCommerce_EmailEditor_Engine_Logger_Default_Email_Editor_Logger.notice() string {
	return 'notice'
}

pub fn Class_Automattic_WooCommerce_EmailEditor_Engine_Logger_Default_Email_Editor_Logger.info() string {
	return 'info'
}

pub fn Class_Automattic_WooCommerce_EmailEditor_Engine_Logger_Default_Email_Editor_Logger.debug() string {
	return 'debug'
}

struct Class_Automattic_WooCommerce_EmailEditor_Engine_Logger_Default_Email_Editor_Logger {
	rt.PhpObjectBase
pub mut:
	log_file rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Logger_Default_Email_Editor_Logger) construct() {
	if rt.is_true(rt.call_function('defined', [rt.new_string('WP_DEBUG_LOG')])) {
		if rt.is_true(rt.identical(rt.new_bool(true), rt.get_constant('WP_DEBUG_LOG'))) {
			this.log_file = (rt.get_constant('WP_CONTENT_DIR')).str() + '/debug.log'
		} else if rt.is_true(rt.new_bool(
			rt.is_true(rt.new_bool(rt.get_constant('WP_DEBUG_LOG').is_string()))
			&& !(!rt.is_true(rt.get_constant('WP_DEBUG_LOG')))))
		{
			this.log_file = rt.get_constant('WP_DEBUG_LOG')
		} else {
			this.log_file = rt.new_string('')
		}
	} else {
		this.log_file = rt.new_string('')
	}
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Logger_Default_Email_Editor_Logger) emergency(message string, mut var_context Class_Automattic_WooCommerce_EmailEditor_Engine_Logger_array) {
	this.log((Class_Automattic_WooCommerce_EmailEditor_Engine_Logger_Automattic_WooCommerce_EmailEditor_Engine_Logger_Default_Email_Editor_Logger.emergency()).str(),
		message, mut var_context)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Logger_Default_Email_Editor_Logger) alert(message string, mut var_context Class_Automattic_WooCommerce_EmailEditor_Engine_Logger_array) {
	this.log((Class_Automattic_WooCommerce_EmailEditor_Engine_Logger_Automattic_WooCommerce_EmailEditor_Engine_Logger_Default_Email_Editor_Logger.alert()).str(),
		message, mut var_context)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Logger_Default_Email_Editor_Logger) critical(message string, mut var_context Class_Automattic_WooCommerce_EmailEditor_Engine_Logger_array) {
	this.log((Class_Automattic_WooCommerce_EmailEditor_Engine_Logger_Automattic_WooCommerce_EmailEditor_Engine_Logger_Default_Email_Editor_Logger.critical()).str(),
		message, mut var_context)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Logger_Default_Email_Editor_Logger) error(message string, mut var_context Class_Automattic_WooCommerce_EmailEditor_Engine_Logger_array) {
	this.log((Class_Automattic_WooCommerce_EmailEditor_Engine_Logger_Automattic_WooCommerce_EmailEditor_Engine_Logger_Default_Email_Editor_Logger.error()).str(),
		message, mut var_context)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Logger_Default_Email_Editor_Logger) warning(message string, mut var_context Class_Automattic_WooCommerce_EmailEditor_Engine_Logger_array) {
	this.log((Class_Automattic_WooCommerce_EmailEditor_Engine_Logger_Automattic_WooCommerce_EmailEditor_Engine_Logger_Default_Email_Editor_Logger.warning()).str(),
		message, mut var_context)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Logger_Default_Email_Editor_Logger) notice(message string, mut var_context Class_Automattic_WooCommerce_EmailEditor_Engine_Logger_array) {
	this.log((Class_Automattic_WooCommerce_EmailEditor_Engine_Logger_Automattic_WooCommerce_EmailEditor_Engine_Logger_Default_Email_Editor_Logger.notice()).str(),
		message, mut var_context)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Logger_Default_Email_Editor_Logger) info(message string, mut var_context Class_Automattic_WooCommerce_EmailEditor_Engine_Logger_array) {
	this.log((Class_Automattic_WooCommerce_EmailEditor_Engine_Logger_Automattic_WooCommerce_EmailEditor_Engine_Logger_Default_Email_Editor_Logger.info()).str(),
		message, mut var_context)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Logger_Default_Email_Editor_Logger) debug(message string, mut var_context Class_Automattic_WooCommerce_EmailEditor_Engine_Logger_array) {
	this.log((Class_Automattic_WooCommerce_EmailEditor_Engine_Logger_Automattic_WooCommerce_EmailEditor_Engine_Logger_Default_Email_Editor_Logger.debug()).str(),
		message, mut var_context)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Logger_Default_Email_Editor_Logger) log(level string, message string, mut var_context Class_Automattic_WooCommerce_EmailEditor_Engine_Logger_array) {
	if rt.is_true(rt.new_bool(!(rt.is_true(this.log_file)))) {
		return rt.new_null()
	}
	mut var_entry := rt.call_function('sprintf', [rt.new_string('[%s] %s: %s %s'),
		rt.call_function('gmdate', [rt.new_string('Y-m-d H:i:s')]),
		rt.new_string(level.to_upper()), rt.new_string(message), if !(!rt.is_true(var_context)) { rt.call_function('wp_json_encode', [
				var_context]) } else { rt.new_string('') }])
	rt.call_function('error_log', [rt.concat(var_entry, rt.get_constant('PHP_EOL')),
		rt.new_int(3), this.log_file])
}

fn create_automattic_woocommerce_emaileditor_engine_logger_default_email_editor_logger() &Class_Automattic_WooCommerce_EmailEditor_Engine_Logger_Default_Email_Editor_Logger {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Engine_Logger_Default_Email_Editor_Logger{
		PhpObjectBase: rt.PhpObjectBase{}
		log_file:      rt.new_null()
	}
	obj.construct()
	return obj
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Logger_Default_Email_Editor_Logger) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'emergency' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Logger_array](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			this.emergency(dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'alert' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Logger_array](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			this.alert(dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'critical' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Logger_array](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			this.critical(dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'error' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Logger_array](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			this.error(dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'warning' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Logger_array](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			this.warning(dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'notice' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Logger_array](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			this.notice(dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'info' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Logger_array](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			this.info(dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'debug' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Logger_array](if args.len > 1 {
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
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Logger_array](if args.len > 2 {
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

fn (this &Class_Automattic_WooCommerce_EmailEditor_Engine_Logger_Default_Email_Editor_Logger) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'log_file' { return this.log_file }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Logger_Default_Email_Editor_Logger) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'log_file' {
			this.log_file = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

pub fn init_wp_content_plugins_woocommerce_packages_email_editor_src_engine_logger_class_default_email_editor_logger_php() {
	// unsupported statement: Stmt_Declare
}
