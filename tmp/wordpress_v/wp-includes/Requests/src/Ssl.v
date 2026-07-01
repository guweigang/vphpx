import rt

struct Class_WpOrg_Requests_Ssl {
	rt.PhpObjectBase
}

fn Class_WpOrg_Requests_Ssl.verify_certificate(var_host rt.PhpVal, var_cert rt.PhpVal) bool {
	if rt.is_true(rt.identical(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WpOrg_Requests_Utility_InputValidator{}; return temp.is_string_or_stringable(arg_0) }(var_host.dup()), rt.new_bool(false))) {
		rt.throw_exception(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal, arg_3 rt.PhpVal) rt.PhpVal { mut temp := Class_WpOrg_Requests_Exception_InvalidArgument{}; return temp.create(arg_0, arg_1, arg_2, arg_3) }(rt.new_int(1), rt.new_string('$host'), rt.new_string('string|Stringable'), rt.call_function('gettype', [var_host.dup()])))
	}
	if rt.is_true(rt.identical(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WpOrg_Requests_Utility_InputValidator{}; return temp.has_array_access(arg_0) }(var_cert.dup()), rt.new_bool(false))) {
		rt.throw_exception(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal, arg_3 rt.PhpVal) rt.PhpVal { mut temp := Class_WpOrg_Requests_Exception_InvalidArgument{}; return temp.create(arg_0, arg_1, arg_2, arg_3) }(rt.new_int(2), rt.new_string('$cert'), rt.new_string('array|ArrayAccess'), rt.call_function('gettype', [var_cert.dup()])))
	}
	mut var_has_dns_alt := rt.new_bool(rt.new_bool(false))
	if !(!rt.is_true(var_cert.array_get('extensions').array_get('subjectAltName'))) {
		mut var_altnames := rt.call_function('explode', [rt.new_string(','), var_cert.array_get('extensions').array_get('subjectAltName')])
		{
			mut iter_1 := var_altnames.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_altname := item_1.val
				var_altname = rt.new_string(rt.new_string(var_altname.dup().to_string().trim_space()))
				if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
					continue
				}
				var_has_dns_alt = rt.new_bool(rt.new_bool(true))
				var_altname = rt.new_string(rt.new_string(rt.call_function('substr', [var_altname.dup(), rt.new_int(4)]).to_string().trim_space()))
				if rt.is_true(rt.identical(Class_WpOrg_Requests_Ssl.match_domain(var_host.dup(), var_altname.dup()), rt.new_bool(true))) {
					return true
				}
			}
		}
		if rt.is_true(rt.identical(var_has_dns_alt, rt.new_bool(true))) {
			return false
		}
	}
	if !(!rt.is_true(var_cert.array_get('subject').array_get('CN'))) {
		return (rt.identical(Class_WpOrg_Requests_Ssl.match_domain(var_host.dup(), var_cert.array_get('subject').array_get('CN')), rt.new_bool(true))).to_bool()
	}
	return false
}

fn Class_WpOrg_Requests_Ssl.verify_reference_name(var_reference rt.PhpVal) bool {
	if rt.is_true(rt.identical(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WpOrg_Requests_Utility_InputValidator{}; return temp.is_string_or_stringable(arg_0) }(var_reference.dup()), rt.new_bool(false))) {
		rt.throw_exception(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal, arg_3 rt.PhpVal) rt.PhpVal { mut temp := Class_WpOrg_Requests_Exception_InvalidArgument{}; return temp.create(arg_0, arg_1, arg_2, arg_3) }(rt.new_int(1), rt.new_string('$reference'), rt.new_string('string|Stringable'), rt.call_function('gettype', [var_reference.dup()])))
	}
	if rt.is_true(rt.identical(var_reference, rt.new_string(''))) {
		return false
	}
	if rt.is_true(rt.greater(rt.call_function('preg_match', [rt.new_string('`\\s`'), var_reference.dup()]), rt.new_int(0))) {
		return false
	}
	mut var_parts := rt.call_function('explode', [rt.new_string('.'), var_reference.dup()])
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return false
	}
	mut var_first := rt.call_function('array_shift', [var_parts.dup()])
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
			return false
		}
		if var_parts.dup().array_count() < 2 {
			return false
		}
	}
	{
		mut iter_1 := var_parts.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_part := item_1.val
			if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
				return false
			}
		}
	}
	return true
}

fn Class_WpOrg_Requests_Ssl.match_domain(var_host rt.PhpVal, var_reference rt.PhpVal) bool {
	if rt.is_true(rt.identical(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WpOrg_Requests_Utility_InputValidator{}; return temp.is_string_or_stringable(arg_0) }(var_host.dup()), rt.new_bool(false))) {
		rt.throw_exception(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal, arg_3 rt.PhpVal) rt.PhpVal { mut temp := Class_WpOrg_Requests_Exception_InvalidArgument{}; return temp.create(arg_0, arg_1, arg_2, arg_3) }(rt.new_int(1), rt.new_string('$host'), rt.new_string('string|Stringable'), rt.call_function('gettype', [var_host.dup()])))
	}
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return false
	}
	if rt.is_true(rt.identical(// unsupported expression: Expr_Cast_String, // unsupported expression: Expr_Cast_String)) {
		return true
	}
	if rt.is_true(rt.identical(rt.call_function('ip2long', [var_host.dup()]), rt.new_bool(false))) {
		mut var_parts := rt.call_function('explode', [rt.new_string('.'), var_host.dup()])
		var_parts.array_set(0, '*')
		mut var_wildcard := rt.call_function('implode', [rt.new_string('.'), var_parts.dup()])
		if rt.is_true(rt.identical(var_wildcard, // unsupported expression: Expr_Cast_String)) {
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

fn create_wporg_requests_ssl() &Class_WpOrg_Requests_Ssl {
	mut obj := &Class_WpOrg_Requests_Ssl{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wporg_requests_utility_inputvalidator() &Class_WpOrg_Requests_Utility_InputValidator {
	mut obj := &Class_WpOrg_Requests_Utility_InputValidator{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wporg_requests_exception_invalidargument() &Class_WpOrg_Requests_Exception_InvalidArgument {
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
			return rt.new_bool(Class_WpOrg_Requests_Ssl.verify_certificate(dispatch_arg_0, dispatch_arg_1))
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
		else { return none }
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




pub fn init_wp_includes_requests_src_ssl_php() {
}
