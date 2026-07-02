import rt

pub fn Class_WpOrg_Requests_Port.acap() i64 {
	return 674
}

pub fn Class_WpOrg_Requests_Port.dict() i64 {
	return 2628
}

pub fn Class_WpOrg_Requests_Port.http() i64 {
	return 80
}

pub fn Class_WpOrg_Requests_Port.https() i64 {
	return 443
}

struct Class_WpOrg_Requests_Port {
	rt.PhpObjectBase
}

fn Class_WpOrg_Requests_Port.get(var_type rt.PhpVal) rt.PhpVal {
	mut var_type_mutated := var_type
	if !(var_type_mutated.clone().is_string()) {
		mut iife_temp_0 := Class_WpOrg_Requests_Exception_InvalidArgument{}
		mut iife_result_0 := iife_temp_0.create(rt.new_int(1), rt.new_string('$type'),
			rt.new_string('string'), rt.call_function('gettype', [
			var_type_mutated.clone()]))
		rt.throw_exception(iife_result_0)
	}
	var_type_mutated = rt.new_string(var_type_mutated.clone().to_string().to_upper())
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('self::${var_type.to_string()}'),
	])))))
	{
		mut var_message := rt.call_function('sprintf', [
			rt.new_string('Invalid port type (%s) passed'),
			var_type_mutated.clone(),
		])
		rt.throw_exception(rt.new_object('WpOrg_Requests_Exception', []string{}, create_wporg_requests_exception(var_message.clone(),
			rt.new_string('portnotsupported'))))
	}
	return rt.call_function('constant', [rt.new_string('self::${var_type.to_string()}')])
}

struct Class_WpOrg_Requests_Exception_InvalidArgument {
	rt.PhpObjectBase
}

struct Class_WpOrg_Requests_Exception {
	rt.PhpObjectBase
}

fn create_wporg_requests_port(_args ...rt.PhpVal) &Class_WpOrg_Requests_Port {
	mut obj := &Class_WpOrg_Requests_Port{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wporg_requests_exception_invalidargument(_args ...rt.PhpVal) &Class_WpOrg_Requests_Exception_InvalidArgument {
	mut obj := &Class_WpOrg_Requests_Exception_InvalidArgument{
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

fn (mut this Class_WpOrg_Requests_Port) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WpOrg_Requests_Port.get(dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_WpOrg_Requests_Port) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WpOrg_Requests_Port) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WpOrg_Requests_Exception_InvalidArgument) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WpOrg_Requests_Exception_InvalidArgument) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WpOrg_Requests_Exception_InvalidArgument) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn main() {
	defer {
		rt.shutdown()
	}
}
