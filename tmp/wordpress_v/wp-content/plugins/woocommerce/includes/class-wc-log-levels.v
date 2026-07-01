import rt

pub fn Class_WC_Log_Levels.emergency() string {
	return 'emergency'
}
pub fn Class_WC_Log_Levels.alert() string {
	return 'alert'
}
pub fn Class_WC_Log_Levels.critical() string {
	return 'critical'
}
pub fn Class_WC_Log_Levels.error() string {
	return 'error'
}
pub fn Class_WC_Log_Levels.warning() string {
	return 'warning'
}
pub fn Class_WC_Log_Levels.notice() string {
	return 'notice'
}
pub fn Class_WC_Log_Levels.info() string {
	return 'info'
}
pub fn Class_WC_Log_Levels.debug() string {
	return 'debug'
}
struct Class_WC_Log_Levels {
	rt.PhpObjectBase
pub mut:
		level_to_severity rt.PhpVal = rt.new_array()
		severity_to_level rt.PhpVal = rt.new_array()
}

fn Class_WC_Log_Levels.is_valid_level(var_level rt.PhpVal) bool {
	return rt.is_true(rt.new_bool(var_level.dup().is_string())) && rt.is_true(rt.new_bool(// unsupported expression: Expr_StaticPropertyFetch.array_isset(rt.new_string(var_level.dup().to_string().to_lower()))))
}

fn Class_WC_Log_Levels.get_level_severity(var_level rt.PhpVal) rt.PhpVal {
	return if rt.is_true(Class_WC_Log_Levels.is_valid_level(var_level.dup())) { // unsupported expression: Expr_StaticPropertyFetch.array_get(var_level.dup().to_string().to_lower()) } else { rt.new_int(0) }
}

fn Class_WC_Log_Levels.get_all_level_severities() rt.PhpVal {
	return // unsupported expression: Expr_StaticPropertyFetch
}

fn Class_WC_Log_Levels.get_severity_level(var_severity rt.PhpVal) bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(// unsupported expression: Expr_StaticPropertyFetch.array_isset(var_severity.dup())))))) {
		return false
	}
	return (// unsupported expression: Expr_StaticPropertyFetch.array_get(var_severity)).to_bool()
}

fn Class_WC_Log_Levels.get_all_severity_levels() rt.PhpVal {
	return // unsupported expression: Expr_StaticPropertyFetch
}

fn Class_WC_Log_Levels.get_level_label(var_level rt.PhpVal) string {
	mut var_labels := Class_WC_Log_Levels.get_all_level_labels()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_labels.dup().array_isset(var_level.dup())))))) {
		return ''
	}
	return (var_labels.array_get(var_level)).str()
}

fn Class_WC_Log_Levels.get_all_level_labels() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: Class_WC_Log_Levels.emergency(), val: rt.call_function('__', [rt.new_string('Emergency'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: Class_WC_Log_Levels.alert(), val: rt.call_function('__', [rt.new_string('Alert'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: Class_WC_Log_Levels.critical(), val: rt.call_function('__', [rt.new_string('Critical'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: Class_WC_Log_Levels.error(), val: rt.call_function('__', [rt.new_string('Error'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: Class_WC_Log_Levels.warning(), val: rt.call_function('__', [rt.new_string('Warning'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: Class_WC_Log_Levels.notice(), val: rt.call_function('__', [rt.new_string('Notice'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: Class_WC_Log_Levels.info(), val: rt.call_function('__', [rt.new_string('Info'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: Class_WC_Log_Levels.debug(), val: rt.call_function('__', [rt.new_string('Debug'), rt.new_string('woocommerce')]) }])
}

fn create_wc_log_levels() &Class_WC_Log_Levels {
	mut obj := &Class_WC_Log_Levels{
		PhpObjectBase: rt.PhpObjectBase{}
		level_to_severity: rt.new_array()
		severity_to_level: rt.new_array()
	}
	return obj
}

fn (mut this Class_WC_Log_Levels) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'is_valid_level' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(Class_WC_Log_Levels.is_valid_level(dispatch_arg_0))
		}
		'get_level_severity' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WC_Log_Levels.get_level_severity(dispatch_arg_0)
		}
		'get_all_level_severities' {
			return Class_WC_Log_Levels.get_all_level_severities()
		}
		'get_severity_level' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(Class_WC_Log_Levels.get_severity_level(dispatch_arg_0))
		}
		'get_all_severity_levels' {
			return Class_WC_Log_Levels.get_all_severity_levels()
		}
		'get_level_label' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(Class_WC_Log_Levels.get_level_label(dispatch_arg_0))
		}
		'get_all_level_labels' {
			return Class_WC_Log_Levels.get_all_level_labels()
		}
		else { return none }
	}
}

fn (this &Class_WC_Log_Levels) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'level_to_severity' { return this.level_to_severity }
		'severity_to_level' { return this.severity_to_level }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_Log_Levels) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'level_to_severity' { this.level_to_severity = val; return true }
		'severity_to_level' { this.severity_to_level = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}




pub fn init_wp_content_plugins_woocommerce_includes_class_wc_log_levels_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
