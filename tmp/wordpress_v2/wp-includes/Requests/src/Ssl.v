import rt

struct Class_WpOrg_Requests_Ssl {
	rt.PhpObjectBase
}

fn Class_WpOrg_Requests_Ssl.verify_certificate(var_host rt.PhpVal, var_cert rt.PhpVal) bool {
	mut iife_temp_0 := Class_WpOrg_Requests_Utility_InputValidator{}
	mut iife_result_0 := iife_temp_0.is_string_or_stringable(var_host.clone())
	if rt.is_true(rt.identical(iife_result_0, rt.new_bool(false))) {
		mut iife_temp_1 := Class_WpOrg_Requests_Exception_InvalidArgument{}
		mut iife_result_1 := iife_temp_1.create(rt.new_int(1), rt.new_string('$host'),
			rt.new_string('string|Stringable'), rt.call_function('gettype', [
			var_host.clone()]))
		rt.throw_exception(iife_result_1)
	}
	mut iife_temp_2 := Class_WpOrg_Requests_Utility_InputValidator{}
	mut iife_result_2 := iife_temp_2.has_array_access(var_cert.clone())
	if rt.is_true(rt.identical(iife_result_2, rt.new_bool(false))) {
		mut iife_temp_3 := Class_WpOrg_Requests_Exception_InvalidArgument{}
		mut iife_result_3 := iife_temp_3.create(rt.new_int(2), rt.new_string('$cert'),
			rt.new_string('array|ArrayAccess'), rt.call_function('gettype', [
			var_cert.clone()]))
		rt.throw_exception(iife_result_3)
	}
	mut var_has_dns_alt := rt.new_bool(false)
	if !(!rt.is_true(var_cert.array_get(rt.new_string('extensions')).array_get(rt.new_string('subjectAltName')))) {
		mut var_altnames := rt.call_function('explode', [rt.new_string(','),
			var_cert.array_get(rt.new_string('extensions')).array_get(rt.new_string('subjectAltName'))])
		mut iter_1 := var_altnames.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_altname := item_1.val
			var_altname = rt.new_string(var_altname.clone().to_string().trim_space())
			if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('strpos', [
				var_altname.clone(),
				rt.new_string('DNS:'),
			]), rt.new_int(0)))))
			{
				continue
			}
			var_has_dns_alt = rt.new_bool(true)
			var_altname = rt.new_string(rt.call_function('substr', [
				var_altname.clone(), rt.new_int(4)]).to_string().trim_space())
			if rt.is_true(rt.identical(Class_WpOrg_Requests_Ssl.match_domain(var_host.clone(),
				var_altname.clone()), rt.new_bool(true)))
			{
				return true
			}
		}
		if rt.is_true(rt.identical(var_has_dns_alt, rt.new_bool(true))) {
			return false
		}
	}
	if !(!rt.is_true(var_cert.array_get(rt.new_string('subject')).array_get(rt.new_string('CN')))) {
		return (rt.identical(Class_WpOrg_Requests_Ssl.match_domain(var_host.clone(),
			var_cert.array_get(rt.new_string('subject')).array_get(rt.new_string('CN'))),
			rt.new_bool(true))).to_bool()
	}
	return false
}

fn Class_WpOrg_Requests_Ssl.verify_reference_name(var_reference rt.PhpVal) bool {
	mut iife_temp_4 := Class_WpOrg_Requests_Utility_InputValidator{}
	mut iife_result_4 := iife_temp_4.is_string_or_stringable(var_reference.clone())
	if rt.is_true(rt.identical(iife_result_4, rt.new_bool(false))) {
		mut iife_temp_5 := Class_WpOrg_Requests_Exception_InvalidArgument{}
		mut iife_result_5 := iife_temp_5.create(rt.new_int(1), rt.new_string('$reference'),
			rt.new_string('string|Stringable'), rt.call_function('gettype', [
			var_reference.clone()]))
		rt.throw_exception(iife_result_5)
	}
	if rt.is_true(rt.identical(var_reference, rt.new_string(''))) {
		return false
	}
	if rt.is_true(rt.greater(rt.call_function('preg_match', [
		rt.new_string('`\\s`'), var_reference.clone()]), rt.new_int(0)))
	{
		return false
	}
	mut var_parts := rt.call_function('explode', [rt.new_string('.'),
		var_reference.clone()])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_parts, rt.call_function('array_filter', [
		var_parts.clone(),
	])))))
	{
		return false
	}
	mut var_first := rt.call_function('array_shift', [var_parts.clone()])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('strpos', [
		var_first.clone(),
		rt.new_string('*'),
	]), rt.new_bool(false)))))
	{
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_first, rt.new_string('*'))))) {
			return false
		}
		if var_parts.clone().array_count() < 2 {
			return false
		}
	}
	mut iter_2 := var_parts.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_part := item_2.val
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('strpos', [
			var_part.clone(),
			rt.new_string('*'),
		]), rt.new_bool(false)))))
		{
			return false
		}
	}
	return true
}

fn Class_WpOrg_Requests_Ssl.match_domain(var_host rt.PhpVal, var_reference rt.PhpVal) bool {
	mut iife_temp_6 := Class_WpOrg_Requests_Utility_InputValidator{}
	mut iife_result_6 := iife_temp_6.is_string_or_stringable(var_host.clone())
	if rt.is_true(rt.identical(iife_result_6, rt.new_bool(false))) {
		mut iife_temp_7 := Class_WpOrg_Requests_Exception_InvalidArgument{}
		mut iife_result_7 := iife_temp_7.create(rt.new_int(1), rt.new_string('$host'),
			rt.new_string('string|Stringable'), rt.call_function('gettype', [
			var_host.clone()]))
		rt.throw_exception(iife_result_7)
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(Class_WpOrg_Requests_Ssl.verify_reference_name(var_reference.clone()),
		rt.new_bool(true)))))
	{
		return false
	}
	if rt.is_true(rt.identical(var_host.str(), var_reference.str())) {
		return true
	}
	if rt.is_true(rt.identical(rt.call_function('ip2long', [var_host.clone()]), rt.new_bool(false))) {
		mut var_parts := rt.call_function('explode', [rt.new_string('.'),
			var_host.clone()])
		var_parts.array_set(0, '*')
		mut var_wildcard := rt.call_function('implode', [rt.new_string('.'),
			var_parts.clone()])
		if rt.is_true(rt.identical(var_wildcard, var_reference.str())) {
			return true
		}
	}
	return false
}

struct Class_WpOrg_Requests_Utility_InputValidator {
	rt.PhpObjectBase
}

struct Class_WpOrg_Requests_Exception_InvalidArgument {
	rt.PhpObjectBase
}

fn create_wporg_requests_ssl(_args ...rt.PhpVal) &Class_WpOrg_Requests_Ssl {
	mut obj := &Class_WpOrg_Requests_Ssl{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wporg_requests_utility_inputvalidator(_args ...rt.PhpVal) &Class_WpOrg_Requests_Utility_InputValidator {
	mut obj := &Class_WpOrg_Requests_Utility_InputValidator{
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

fn (mut this Class_WpOrg_Requests_Ssl) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'verify_certificate' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(Class_WpOrg_Requests_Ssl.verify_certificate(dispatch_arg_0,
				dispatch_arg_1))
		}
		'verify_reference_name' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(Class_WpOrg_Requests_Ssl.verify_reference_name(dispatch_arg_0))
		}
		'match_domain' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(Class_WpOrg_Requests_Ssl.match_domain(dispatch_arg_0, dispatch_arg_1))
		}
		else {
			return none
		}
	}
}

fn (this &Class_WpOrg_Requests_Ssl) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WpOrg_Requests_Ssl) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WpOrg_Requests_Utility_InputValidator) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WpOrg_Requests_Utility_InputValidator) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WpOrg_Requests_Utility_InputValidator) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn main() {
	defer {
		rt.shutdown()
	}
}
