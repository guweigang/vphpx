import rt

struct Class_WpOrg_Requests_Ipv6 {
	rt.PhpObjectBase
}

fn Class_WpOrg_Requests_Ipv6.uncompress(var_ip rt.PhpVal) rt.PhpVal {
	mut var_ip1 := rt.new_null()
	mut var_ip2 := rt.new_null()
	mut var_ip_mutated := var_ip
	if rt.is_true(rt.identical(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WpOrg_Requests_Utility_InputValidator{}; return temp.is_string_or_stringable(arg_0) }(var_ip_mutated.dup()), rt.new_bool(false))) {
		rt.throw_exception(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal, arg_3 rt.PhpVal) rt.PhpVal { mut temp := Class_WpOrg_Requests_Exception_InvalidArgument{}; return temp.create(arg_0, arg_1, arg_2, arg_3) }(rt.new_int(1), rt.new_string('$ip'), rt.new_string('string|Stringable'), rt.call_function('gettype', [var_ip_mutated.dup()])))
	}
	var_ip_mutated = // unsupported expression: Expr_Cast_String
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return var_ip_mutated.dup()
	}
	// unsupported assign target: Expr_List
	mut var_c1 := if rt.is_true(rt.identical(var_ip1, rt.new_string(''))) { // unsupported expression: Expr_UnaryMinus } else { rt.call_function('substr_count', [var_ip1.dup(), rt.new_string(':')]) }
	mut var_c2 := if rt.is_true(rt.identical(var_ip2, rt.new_string(''))) { // unsupported expression: Expr_UnaryMinus } else { rt.call_function('substr_count', [var_ip2.dup(), rt.new_string(':')]) }
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		rt.post_inc(var_c2)
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.identical(var_c1, // unsupported expression: Expr_UnaryMinus)) && rt.is_true(rt.identical(var_c2, // unsupported expression: Expr_UnaryMinus)))) {
		var_ip_mutated = rt.new_string(rt.new_string('0:0:0:0:0:0:0:0'))
	} else if rt.is_true(rt.identical(var_c1, // unsupported expression: Expr_UnaryMinus)) {
		mut var_fill := rt.call_function('str_repeat', [rt.new_string('0:'), rt.sub(rt.new_int(7), var_c2)])
		var_ip_mutated = rt.call_function('str_replace', [rt.new_string('::'), var_fill.dup(), var_ip_mutated.dup()])
	} else if rt.is_true(rt.identical(var_c2, // unsupported expression: Expr_UnaryMinus)) {
		var_fill = rt.call_function('str_repeat', [rt.new_string(':0'), rt.sub(rt.new_int(7), var_c1)])
		var_ip_mutated = rt.call_function('str_replace', [rt.new_string('::'), var_fill.dup(), var_ip_mutated.dup()])
	} else {
		var_fill = rt.new_string(':' + (rt.call_function('str_repeat', [rt.new_string('0:'), rt.sub(rt.sub(rt.new_int(6), var_c2), var_c1)])).str())
		var_ip_mutated = rt.call_function('str_replace', [rt.new_string('::'), var_fill.dup(), var_ip_mutated.dup()])
	}
	return var_ip_mutated.dup()
}

fn Class_WpOrg_Requests_Ipv6.compress(var_ip rt.PhpVal) rt.PhpVal {
	mut var_matches := rt.new_null()
	mut var_ip_mutated := var_ip
	var_ip_mutated = Class_WpOrg_Requests_Ipv6.uncompress(var_ip_mutated.dup())
	mut var_ip_parts := Class_WpOrg_Requests_Ipv6.split_v6_v4(var_ip_mutated.dup())
	var_ip_parts.array_set(0, rt.call_function('preg_replace', [rt.new_string('/(^|:)0+([0-9])/'), rt.new_string('\\1\\2'), var_ip_parts.array_get(0)]))
	if rt.is_true(rt.call_function('preg_match_all', [rt.new_string('/(?:^|:)(?:0(?::|$))+/'), var_ip_parts.array_get(0), var_matches.dup(), rt.get_constant('PREG_OFFSET_CAPTURE')])) {
		mut var_max := rt.new_int(rt.new_int(0))
		mut var_pos := rt.new_null()
		{
			mut iter_1 := var_matches.array_get(0).iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_match := item_1.val
				if rt.is_true(rt.greater(rt.new_int(var_match.array_get(0).to_string().len), var_max)) {
					var_max = rt.new_int(rt.new_int(var_match.array_get(0).to_string().len))
					var_pos = var_match.array_get(1)
				}
			}
		}
		var_ip_parts.array_set(0, rt.call_function('substr_replace', [var_ip_parts.array_get(0), rt.new_string('::'), var_pos.dup(), var_max.dup()]))
	}
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return rt.call_function('implode', [rt.new_string(':'), var_ip_parts.dup()])
	} else {
		return var_ip_parts.array_get(0)
	}
	return rt.new_null()
}

fn Class_WpOrg_Requests_Ipv6.split_v6_v4(var_ip rt.PhpVal) rt.PhpVal {
	mut var_ip_mutated := var_ip
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		mut var_pos := rt.call_function('strrpos', [var_ip_mutated.dup(), rt.new_string(':')])
		mut var_ipv6_part := rt.call_function('substr', [var_ip_mutated.dup(), rt.new_int(0), var_pos.dup()])
		mut var_ipv4_part := rt.call_function('substr', [var_ip_mutated.dup(), rt.add(var_pos, rt.new_int(1))])
		return rt.create_array([rt.ArrayItem{ key: none, val: var_ipv6_part }, rt.ArrayItem{ key: none, val: var_ipv4_part }])
	} else {
		return rt.create_array([rt.ArrayItem{ key: none, val: var_ip_mutated }, rt.ArrayItem{ key: none, val: '' }])
	}
	return rt.new_null()
}

fn Class_WpOrg_Requests_Ipv6.check_ipv6(var_ip rt.PhpVal) bool {
	mut var_ip_mutated := var_ip
	var_ip_mutated = Class_WpOrg_Requests_Ipv6.uncompress(var_ip_mutated.dup())
	// unsupported assign target: Expr_List
	mut var_ipv6 := rt.call_function('explode', [rt.new_string(':'), var_ipv6.dup()])
	mut var_ipv4 := rt.call_function('explode', [rt.new_string('.'), var_ipv4.dup()])
	if var_ipv6.dup().array_count() == 8 && var_ipv4.dup().array_count() == 1 || var_ipv6.dup().array_count() == 6 && var_ipv4.dup().array_count() == 4 {
		{
			mut iter_1 := var_ipv6.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_ipv6_part := item_1.val
				if rt.is_true(rt.identical(var_ipv6_part, rt.new_string(''))) {
					return false
				}
				if var_ipv6_part.dup().to_string().len > 4 {
					return false
				}
				var_ipv6_part = rt.new_string(rt.new_string(var_ipv6_part.dup().to_string().trim_left(' \t\n\r')))
				if rt.is_true(rt.identical(var_ipv6_part, rt.new_string(''))) {
					var_ipv6_part = rt.new_string(rt.new_string('0'))
				}
				mut var_value := rt.call_function('hexdec', [var_ipv6_part.dup()])
				if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) || rt.is_true(rt.less(var_value, rt.new_int(0))))) || rt.is_true(rt.greater(var_value, rt.new_int(65535))))) {
					return false
				}
			}
		}
		if var_ipv4.dup().array_count() == 4 {
			{
				mut iter_1 := var_ipv4.iterator()
				for {
					item_1 := iter_1.next() or { break }
					mut var_ipv4_part := item_1.val
					mut var_value := // unsupported expression: Expr_Cast_Int
					if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) || rt.is_true(rt.less(var_value, rt.new_int(0))))) || rt.is_true(rt.greater(var_value, rt.new_int(255))))) {
						return false
					}
				}
			}
		}
		return true
	} else {
		return false
	}
	return false
}

struct Class_WpOrg_Requests_Utility_InputValidator {
	rt.PhpObjectBase
}

struct Class_WpOrg_Requests_Exception_InvalidArgument {
	rt.PhpObjectBase
}

fn create_wporg_requests_ipv6() &Class_WpOrg_Requests_Ipv6 {
	mut obj := &Class_WpOrg_Requests_Ipv6{
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

fn (mut this Class_WpOrg_Requests_Ipv6) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'uncompress' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WpOrg_Requests_Ipv6.uncompress(dispatch_arg_0)
		}
		'compress' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WpOrg_Requests_Ipv6.compress(dispatch_arg_0)
		}
		'split_v6_v4' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WpOrg_Requests_Ipv6.split_v6_v4(dispatch_arg_0)
		}
		'check_ipv6' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(Class_WpOrg_Requests_Ipv6.check_ipv6(dispatch_arg_0))
		}
		else { return none }
	}
}

fn (this &Class_WpOrg_Requests_Ipv6) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WpOrg_Requests_Ipv6) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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




pub fn init_wp_includes_requests_src_ipv6_php() {
}
