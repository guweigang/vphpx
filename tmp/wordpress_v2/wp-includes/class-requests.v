import rt

struct Class_Requests {
	rt.PhpObjectBase
}

fn Class_Requests.autoloader(var_class rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.identical(rt.call_function('class_exists', [
		rt.new_string('WpOrg\\Requests\\Autoload'),
	]), rt.new_bool(false)))
	{
		rt.include_file(@DIR + '/Requests/src/Autoload.php', '4')
	}
	mut iife_temp_0 := Class_WpOrg_Requests_Autoload{}
	mut iife_result_0 := iife_temp_0.load(var_class.clone())
	return iife_result_0
}

fn Class_Requests.register_autoloader() {
	rt.include_file(@DIR + '/Requests/src/Autoload.php', '4')
	mut iife_temp_1 := Class_WpOrg_Requests_Autoload{}
	mut iife_result_1 := iife_temp_1.register()
}

struct Class_WpOrg_Requests_Requests {
	rt.PhpObjectBase
}

struct Class_WpOrg_Requests_Autoload {
	rt.PhpObjectBase
}

fn create_requests(_args ...rt.PhpVal) &Class_Requests {
	mut obj := &Class_Requests{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wporg_requests_requests(_args ...rt.PhpVal) &Class_WpOrg_Requests_Requests {
	mut obj := &Class_WpOrg_Requests_Requests{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wporg_requests_autoload(_args ...rt.PhpVal) &Class_WpOrg_Requests_Autoload {
	mut obj := &Class_WpOrg_Requests_Autoload{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Requests) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'autoloader' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Requests.autoloader(dispatch_arg_0)
		}
		'register_autoloader' {
			Class_Requests.register_autoloader()
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Requests) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Requests) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WpOrg_Requests_Requests) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WpOrg_Requests_Requests) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WpOrg_Requests_Requests) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WpOrg_Requests_Autoload) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WpOrg_Requests_Autoload) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WpOrg_Requests_Autoload) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('REQUESTS_SILENCE_PSR0_DEPRECATIONS')])))))
		|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.get_constant('REQUESTS_SILENCE_PSR0_DEPRECATIONS'), rt.new_bool(true))))) {
		rt.call_function('trigger_error', [
			rt.new_string(
				'The PSR-0 `Requests_...` class names in the Requests library are deprecated.' +
				' Switch to the PSR-4 `WpOrg\\Requests\\...` class names at your earliest convenience.'),
			rt.get_constant('E_USER_DEPRECATED'),
		])
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
			rt.new_string('REQUESTS_SILENCE_PSR0_DEPRECATIONS'),
		])))))
		{
			rt.call_function('define', [
				rt.new_string('REQUESTS_SILENCE_PSR0_DEPRECATIONS'),
				rt.new_bool(true),
			])
		}
	}
	rt.include_file(@DIR + '/Requests/src/Requests.php', '4')
}
