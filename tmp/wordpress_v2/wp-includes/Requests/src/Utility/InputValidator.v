import rt

struct Class_WpOrg_Requests_Utility_InputValidator {
	rt.PhpObjectBase
}

fn Class_WpOrg_Requests_Utility_InputValidator.is_string_or_stringable(var_input rt.PhpVal) bool {
	return var_input.clone().is_string()
		|| rt.is_true(Class_WpOrg_Requests_Utility_InputValidator.is_stringable_object(var_input.clone()))
}

fn Class_WpOrg_Requests_Utility_InputValidator.is_numeric_array_key(var_input rt.PhpVal) bool {
	if rt.is_true(rt.new_bool(var_input.clone().is_long())) {
		return true
	}
	if !(var_input.clone().is_string()) {
		return false
	}
	return (rt.call_function('preg_match', [rt.new_string('`^-?[0-9]+$`'),
		var_input.clone()])).to_bool()
}

fn Class_WpOrg_Requests_Utility_InputValidator.is_stringable_object(var_input rt.PhpVal) bool {
	return var_input.clone().is_object()
		&& rt.is_true(rt.call_function('method_exists', [var_input.clone(), rt.new_string('__toString')]))
}

fn Class_WpOrg_Requests_Utility_InputValidator.has_array_access(var_input rt.PhpVal) bool {
	return var_input.clone().is_array()
		|| rt.is_true(rt.new_bool(rt.instance_of(var_input, 'ArrayAccess')))
}

fn Class_WpOrg_Requests_Utility_InputValidator.is_iterable(var_input rt.PhpVal) bool {
	return var_input.clone().is_array()
		|| rt.is_true(rt.new_bool(rt.instance_of(var_input, 'Traversable')))
}

fn Class_WpOrg_Requests_Utility_InputValidator.is_curl_handle(var_input rt.PhpVal) bool {
	if rt.is_true(rt.call_function('is_resource', [var_input.clone()])) {
		return (rt.identical(rt.call_function('get_resource_type', [
			var_input.clone()]), rt.new_string('curl'))).to_bool()
	}
	if rt.is_true(rt.new_bool(var_input.clone().is_object())) {
		return (rt.new_bool(rt.instance_of(var_input, 'CurlHandle'))).to_bool()
	}
	return false
}

fn create_wporg_requests_utility_inputvalidator(_args ...rt.PhpVal) &Class_WpOrg_Requests_Utility_InputValidator {
	mut obj := &Class_WpOrg_Requests_Utility_InputValidator{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WpOrg_Requests_Utility_InputValidator) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'is_string_or_stringable' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(Class_WpOrg_Requests_Utility_InputValidator.is_string_or_stringable(dispatch_arg_0))
		}
		'is_numeric_array_key' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(Class_WpOrg_Requests_Utility_InputValidator.is_numeric_array_key(dispatch_arg_0))
		}
		'is_stringable_object' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(Class_WpOrg_Requests_Utility_InputValidator.is_stringable_object(dispatch_arg_0))
		}
		'has_array_access' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(Class_WpOrg_Requests_Utility_InputValidator.has_array_access(dispatch_arg_0))
		}
		'is_iterable' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(Class_WpOrg_Requests_Utility_InputValidator.is_iterable(dispatch_arg_0))
		}
		'is_curl_handle' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(Class_WpOrg_Requests_Utility_InputValidator.is_curl_handle(dispatch_arg_0))
		}
		else {
			return none
		}
	}
}

fn (this &Class_WpOrg_Requests_Utility_InputValidator) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WpOrg_Requests_Utility_InputValidator) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
