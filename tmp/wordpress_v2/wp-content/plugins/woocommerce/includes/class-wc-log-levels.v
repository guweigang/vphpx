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
}

fn init_static_wc_log_levels() {
	rt.init_static_prop('WC_Log_Levels', 'level_to_severity', rt.create_array([
		rt.ArrayItem{ key: Class_WC_Log_Levels.emergency(), val: 800 },
		rt.ArrayItem{ key: Class_WC_Log_Levels.alert(), val: 700 },
		rt.ArrayItem{ key: Class_WC_Log_Levels.critical(), val: 600 },
		rt.ArrayItem{ key: Class_WC_Log_Levels.error(), val: 500 },
		rt.ArrayItem{ key: Class_WC_Log_Levels.warning(), val: 400 },
		rt.ArrayItem{ key: Class_WC_Log_Levels.notice(), val: 300 },
		rt.ArrayItem{ key: Class_WC_Log_Levels.info(), val: 200 },
		rt.ArrayItem{ key: Class_WC_Log_Levels.debug(), val: 100 },
	]))
	rt.init_static_prop('WC_Log_Levels', 'severity_to_level', rt.create_array([
		rt.ArrayItem{ key: 800, val: Class_WC_Log_Levels.emergency() },
		rt.ArrayItem{ key: 700, val: Class_WC_Log_Levels.alert() },
		rt.ArrayItem{ key: 600, val: Class_WC_Log_Levels.critical() },
		rt.ArrayItem{ key: 500, val: Class_WC_Log_Levels.error() },
		rt.ArrayItem{ key: 400, val: Class_WC_Log_Levels.warning() },
		rt.ArrayItem{ key: 300, val: Class_WC_Log_Levels.notice() },
		rt.ArrayItem{ key: 200, val: Class_WC_Log_Levels.info() },
		rt.ArrayItem{ key: 100, val: Class_WC_Log_Levels.debug() },
	]))
}

fn Class_WC_Log_Levels.is_valid_level(var_level rt.PhpVal) bool {
	return var_level.clone().is_string()
		&& rt.is_true(rt.new_bool(rt.get_static_prop('WC_Log_Levels', 'level_to_severity').array_isset(rt.new_string(var_level.clone().to_string().to_lower()))))
}

fn Class_WC_Log_Levels.get_level_severity(var_level rt.PhpVal) rt.PhpVal {
	return if rt.is_true(Class_WC_Log_Levels.is_valid_level(var_level.clone())) {
		rt.get_static_prop('WC_Log_Levels', 'level_to_severity').array_get(rt.new_string((var_level.clone().to_string().to_lower()).str()))
	} else {
		rt.new_int(0)
	}
}

fn Class_WC_Log_Levels.get_all_level_severities() rt.PhpVal {
	return rt.get_static_prop('WC_Log_Levels', 'level_to_severity')
}

fn Class_WC_Log_Levels.get_severity_level(var_severity rt.PhpVal) bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.get_static_prop('WC_Log_Levels',
		'severity_to_level').array_isset(var_severity.clone()))))))
	{
		return false
	}
	return (rt.get_static_prop('WC_Log_Levels', 'severity_to_level').array_get(var_severity)).to_bool()
}

fn Class_WC_Log_Levels.get_all_severity_levels() rt.PhpVal {
	return rt.get_static_prop('WC_Log_Levels', 'severity_to_level')
}

fn Class_WC_Log_Levels.get_level_label(var_level rt.PhpVal) string {
	mut var_labels := Class_WC_Log_Levels.get_all_level_labels()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_labels.clone().array_isset(var_level.clone())))))) {
		return ''
	}
	return (var_labels.array_get(var_level)).str()
}

fn Class_WC_Log_Levels.get_all_level_labels() rt.PhpVal {
	return rt.create_array([
		rt.ArrayItem{ key: Class_WC_Log_Levels.emergency(), val: rt.call_function('__', [
			rt.new_string('Emergency'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: Class_WC_Log_Levels.alert(), val: rt.call_function('__', [
			rt.new_string('Alert'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: Class_WC_Log_Levels.critical(), val: rt.call_function('__', [
			rt.new_string('Critical'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: Class_WC_Log_Levels.error(), val: rt.call_function('__', [
			rt.new_string('Error'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: Class_WC_Log_Levels.warning(), val: rt.call_function('__', [
			rt.new_string('Warning'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: Class_WC_Log_Levels.notice(), val: rt.call_function('__', [
			rt.new_string('Notice'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: Class_WC_Log_Levels.info(), val: rt.call_function('__', [
			rt.new_string('Info'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: Class_WC_Log_Levels.debug(), val: rt.call_function('__', [
			rt.new_string('Debug'),
			rt.new_string('woocommerce'),
		]) },
	])
}

fn create_wc_log_levels(_args ...rt.PhpVal) &Class_WC_Log_Levels {
	mut obj := &Class_WC_Log_Levels{
		PhpObjectBase: rt.PhpObjectBase{}
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
		else {
			return none
		}
	}
}

fn (this &Class_WC_Log_Levels) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Log_Levels) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}
