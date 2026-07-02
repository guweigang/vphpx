import rt

struct Class_WpOrg_Requests_Exception_ArgumentCount {
	rt.PhpObjectBase
}

fn Class_WpOrg_Requests_Exception_ArgumentCount.create(var_expected rt.PhpVal, var_received rt.PhpVal, var_type rt.PhpVal) rt.PhpVal {
	mut var_stack := rt.call_function('debug_backtrace', [
		rt.get_constant('DEBUG_BACKTRACE_IGNORE_ARGS'),
		rt.new_int(2),
	])
	return rt.new_object('WpOrg_Requests_Exception_self', []string{}, create_wporg_requests_exception_self(rt.call_function('sprintf', [
		rt.new_string('%s::%s() expects %s, %d given'),
		var_stack.array_get(rt.new_int(1)).array_get(rt.new_string('class')),
		var_stack.array_get(rt.new_int(1)).array_get(rt.new_string('function')),
		var_expected.clone(),
		var_received.clone(),
	]), var_type.clone()))
}

struct Class_WpOrg_Requests_Exception {
	rt.PhpObjectBase
}

struct Class_WpOrg_Requests_Exception_self {
	rt.PhpObjectBase
}

fn create_wporg_requests_exception_argumentcount(_args ...rt.PhpVal) &Class_WpOrg_Requests_Exception_ArgumentCount {
	mut obj := &Class_WpOrg_Requests_Exception_ArgumentCount{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wporg_requests_exception(_args ...rt.PhpVal) &Class_WpOrg_Requests_Exception {
	mut obj := &Class_WpOrg_Requests_Exception{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wporg_requests_exception_self(_args ...rt.PhpVal) &Class_WpOrg_Requests_Exception_self {
	mut obj := &Class_WpOrg_Requests_Exception_self{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WpOrg_Requests_Exception_ArgumentCount) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'create' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return Class_WpOrg_Requests_Exception_ArgumentCount.create(dispatch_arg_0,
				dispatch_arg_1, dispatch_arg_2)
		}
		else {
			return none
		}
	}
}

fn (this &Class_WpOrg_Requests_Exception_ArgumentCount) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WpOrg_Requests_Exception_ArgumentCount) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WpOrg_Requests_Exception) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WpOrg_Requests_Exception) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WpOrg_Requests_Exception) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WpOrg_Requests_Exception_self) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WpOrg_Requests_Exception_self) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WpOrg_Requests_Exception_self) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
