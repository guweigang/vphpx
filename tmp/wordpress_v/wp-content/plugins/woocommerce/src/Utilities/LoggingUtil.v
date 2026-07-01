import rt

struct Class_Automattic_WooCommerce_Utilities_LoggingUtil {
	rt.PhpObjectBase
}

fn Class_Automattic_WooCommerce_Utilities_LoggingUtil.get_logs_tab_url() string {
	return (rt.call_method(rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Utilities_PageController.class()]), 'get_logs_tab_url', []rt.PhpVal{})).str()
}

fn Class_Automattic_WooCommerce_Utilities_LoggingUtil.logging_is_enabled() bool {
	return (rt.call_method(rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Utilities_Settings.class()]), 'logging_is_enabled', []rt.PhpVal{})).to_bool()
}

fn Class_Automattic_WooCommerce_Utilities_LoggingUtil.get_default_handler() string {
	return (rt.call_method(rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Utilities_Settings.class()]), 'get_default_handler', []rt.PhpVal{})).str()
}

fn Class_Automattic_WooCommerce_Utilities_LoggingUtil.get_retention_period() i64 {
	return (rt.call_method(rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Utilities_Settings.class()]), 'get_retention_period', []rt.PhpVal{})).to_i64()
}

fn Class_Automattic_WooCommerce_Utilities_LoggingUtil.get_level_threshold() string {
	return (rt.call_method(rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Utilities_Settings.class()]), 'get_level_threshold', []rt.PhpVal{})).str()
}

fn Class_Automattic_WooCommerce_Utilities_LoggingUtil.generate_log_file_id(source string, mut var_rotation Class_Automattic_WooCommerce_Utilities_?int, created i64) string {
	return (fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Utilities_File{}; return temp.generate_file_id(arg_0, arg_1, arg_2) }(rt.new_string(source), rt.new_object('Automattic_WooCommerce_Utilities_?int', []string{}, var_rotation), rt.new_int(created))).str()
}

fn Class_Automattic_WooCommerce_Utilities_LoggingUtil.generate_log_file_hash(file_id string) string {
	return (fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Utilities_File{}; return temp.generate_hash(arg_0) }(rt.new_string(file_id))).str()
}

fn Class_Automattic_WooCommerce_Utilities_LoggingUtil.get_log_directory(create_dir bool) string {
	return (fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Utilities_Settings{}; return temp.get_log_directory(arg_0) }(rt.new_bool(create_dir))).str()
}

fn Class_Automattic_WooCommerce_Utilities_LoggingUtil.get_log_directory_size() i64 {
	return (rt.call_method(rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Utilities_FileController.class()]), 'get_log_directory_size', []rt.PhpVal{})).to_i64()
}

struct Class_Automattic_WooCommerce_Utilities_File {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Utilities_Settings {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_utilities_loggingutil() &Class_Automattic_WooCommerce_Utilities_LoggingUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_LoggingUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_utilities_file() &Class_Automattic_WooCommerce_Utilities_File {
	mut obj := &Class_Automattic_WooCommerce_Utilities_File{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_utilities_settings() &Class_Automattic_WooCommerce_Utilities_Settings {
	mut obj := &Class_Automattic_WooCommerce_Utilities_Settings{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Utilities_LoggingUtil) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_logs_tab_url' {
			return rt.new_string(Class_Automattic_WooCommerce_Utilities_LoggingUtil.get_logs_tab_url())
		}
		'logging_is_enabled' {
			return rt.new_bool(Class_Automattic_WooCommerce_Utilities_LoggingUtil.logging_is_enabled())
		}
		'get_default_handler' {
			return rt.new_string(Class_Automattic_WooCommerce_Utilities_LoggingUtil.get_default_handler())
		}
		'get_retention_period' {
			return rt.new_int(Class_Automattic_WooCommerce_Utilities_LoggingUtil.get_retention_period())
		}
		'get_level_threshold' {
			return rt.new_string(Class_Automattic_WooCommerce_Utilities_LoggingUtil.get_level_threshold())
		}
		'generate_log_file_id' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Utilities_?int](if args.len > 1 { args[1] } else { rt.new_null() })
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_i64()
			return rt.new_string(Class_Automattic_WooCommerce_Utilities_LoggingUtil.generate_log_file_id(dispatch_arg_0, mut dispatch_arg_1, dispatch_arg_2))
		}
		'generate_log_file_hash' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(Class_Automattic_WooCommerce_Utilities_LoggingUtil.generate_log_file_hash(dispatch_arg_0))
		}
		'get_log_directory' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			return rt.new_string(Class_Automattic_WooCommerce_Utilities_LoggingUtil.get_log_directory(dispatch_arg_0))
		}
		'get_log_directory_size' {
			return rt.new_int(Class_Automattic_WooCommerce_Utilities_LoggingUtil.get_log_directory_size())
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Utilities_LoggingUtil) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_LoggingUtil) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Utilities_File) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Utilities_File) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_File) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Utilities_Settings) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Utilities_Settings) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_Settings) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_utilities_loggingutil_php() {
	// unsupported statement: Stmt_Declare
	// unsupported statement: Stmt_GroupUse
	// unsupported statement: Stmt_GroupUse
}
