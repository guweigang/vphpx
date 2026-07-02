import rt

struct Class_SimplePie_Net_IPv6 {
	rt.PhpObjectBase
}

fn Class_SimplePie_Net_IPv6.uncompress(ip string) rt.PhpVal {
	mut var_ip1 := rt.new_null()
	mut var_ip2 := rt.new_null()
	mut ip_mutated := ip
	mut var_c1 := rt.new_int(-1)
	mut var_c2 := rt.new_int(-1)
	if rt.is_true(rt.identical(rt.call_function('substr_count', [
		rt.new_string(ip_mutated).clone(), rt.new_string('::')]), rt.new_int(1)))
	{
		mut list_tmp_1 := rt.call_function('explode', [rt.new_string('::'),
			rt.new_string(ip_mutated).clone()])
		var_ip1 = list_tmp_1.array_get(0)
		var_ip2 = list_tmp_1.array_get(1)
		if rt.is_true(rt.identical(var_ip1, rt.new_string(''))) {
			var_c1 = rt.new_int(-1)
		} else {
			var_c1 = rt.call_function('substr_count', [var_ip1.clone(),
				rt.new_string(':')])
		}
		if rt.is_true(rt.identical(var_ip2, rt.new_string(''))) {
			var_c2 = rt.new_int(-1)
		} else {
			var_c2 = rt.call_function('substr_count', [var_ip2.clone(),
				rt.new_string(':')])
		}
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('strpos', [
			var_ip2.clone(),
			rt.new_string('.'),
		]), rt.new_bool(false)))))
		{
			rt.post_inc(var_c2)
		}
		if rt.is_true(rt.identical(var_c1, -1)) && rt.is_true(rt.identical(var_c2, -1)) {
			ip_mutated = '0:0:0:0:0:0:0:0'
		} else if rt.is_true(rt.identical(var_c1, -1)) {
			mut var_fill := rt.call_function('str_repeat', [rt.new_string('0:'),
				rt.sub(rt.new_int(7), var_c2)])
			ip_mutated = (rt.call_function('str_replace', [rt.new_string('::'),
				var_fill.clone(), rt.new_string(ip_mutated).clone()])).str()
		} else if rt.is_true(rt.identical(var_c2, -1)) {
			var_fill = rt.call_function('str_repeat', [rt.new_string(':0'),
				rt.sub(rt.new_int(7), var_c1)])
			ip_mutated = (rt.call_function('str_replace', [rt.new_string('::'),
				var_fill.clone(), rt.new_string(ip_mutated).clone()])).str()
		} else {
			var_fill =
				rt.new_string(':' +(rt.call_function('str_repeat', [rt.new_string('0:'), rt.sub(rt.sub(rt.new_int(6), var_c2), var_c1)])).str())
			ip_mutated = (rt.call_function('str_replace', [rt.new_string('::'),
				var_fill.clone(), rt.new_string(ip_mutated).clone()])).str()
		}
	}
	return rt.new_string(ip_mutated)
}

fn Class_SimplePie_Net_IPv6.compress(ip string) rt.PhpVal {
	mut var_matches := rt.new_null()
	mut ip_mutated := ip
	ip_mutated = (Class_SimplePie_Net_IPv6.uncompress(ip_mutated)).str()
	mut var_ip_parts := Class_SimplePie_Net_IPv6.split_v6_v4(ip_mutated)
	var_ip_parts.array_set(0, (rt.call_function('preg_replace', [
		rt.new_string('/(^|:)0+([0-9])/'),
		rt.new_string('\\1\\2'),
		var_ip_parts.array_get(rt.new_int(0)),
	])).str())
	if rt.is_true(rt.call_function('preg_match_all', [
		rt.new_string('/(?:^|:)(?:0(?::|$))+/'),
		var_ip_parts.array_get(rt.new_int(0)),
		var_matches.clone(),
		rt.get_constant('PREG_OFFSET_CAPTURE'),
	]))
	{
		mut var_max := rt.new_int(0)
		mut var_pos := rt.new_null()
		mut iter_1 := var_matches.array_get(rt.new_int(0)).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_match := item_1.val
			if rt.is_true(rt.greater(rt.new_int(var_match.array_get(rt.new_int(0)).to_string().len),
				var_max))
			{
				var_max = rt.new_int(var_match.array_get(rt.new_int(0)).to_string().len)
				var_pos = var_match.array_get(rt.new_int(1))
			}
		}
		rt.call_function('assert', [
			rt.new_bool(!rt.is_true(rt.identical(var_pos, rt.new_null()))),
			rt.new_string('For PHPStan: Since the regex matched, there is at least one match. And because the pattern is non-empty, the loop will always end with $pos ≥ 1.'),
		])
		var_ip_parts.array_set(0, rt.call_function('substr_replace', [
			var_ip_parts.array_get(rt.new_int(0)),
			rt.new_string('::'),
			var_pos.clone(),
			var_max.clone(),
		]))
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_ip_parts.array_get(rt.new_int(1)),
		rt.new_string('')))))
	{
		return rt.call_function('implode', [rt.new_string(':'),
			var_ip_parts.clone()])
	}
	return var_ip_parts.array_get(rt.new_int(0))
}

fn Class_SimplePie_Net_IPv6.split_v6_v4(ip string) rt.PhpVal {
	mut ip_mutated := ip
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('strpos', [
		rt.new_string(ip_mutated).clone(),
		rt.new_string('.'),
	]), rt.new_bool(false)))))
	{
		mut var_pos := rt.call_function('strrpos', [rt.new_string(ip_mutated).clone(),
			rt.new_string(':')])
		rt.call_function('assert', [
			rt.new_bool(!rt.is_true(rt.identical(var_pos, rt.new_bool(false)))),
			rt.new_string('For PHPStan: IPv6 address must contain colon, since split_v6_v4 is only ever called after uncompress.'),
		])
		mut var_ipv6_part := rt.call_function('substr', [rt.new_string(ip_mutated).clone(),
			rt.new_int(0), var_pos.clone()])
		mut var_ipv4_part := rt.call_function('substr', [rt.new_string(ip_mutated).clone(),
			rt.add(var_pos, rt.new_int(1))])
		return rt.create_array([rt.ArrayItem{ key: none, val: var_ipv6_part },
			rt.ArrayItem{ key: none, val: var_ipv4_part }])
	}
	return rt.create_array([rt.ArrayItem{ key: none, val: ip_mutated },
		rt.ArrayItem{ key: none, val: '' }])
}

fn Class_SimplePie_Net_IPv6.check_ipv6(ip string) bool {
	mut ip_mutated := ip
	ip_mutated = (Class_SimplePie_Net_IPv6.uncompress(ip_mutated)).str()
	mut list_tmp_2 := Class_SimplePie_Net_IPv6.split_v6_v4(ip_mutated)
	mut var_ipv6 := list_tmp_2.array_get(0)
	mut var_ipv4 := list_tmp_2.array_get(1)
	var_ipv6 = rt.call_function('explode', [rt.new_string(':'),
		var_ipv6.clone()])
	var_ipv4 = rt.call_function('explode', [rt.new_string('.'),
		var_ipv4.clone()])
	if (var_ipv6.clone().array_count() == 8 && var_ipv4.clone().array_count() == 1)
		|| (var_ipv6.clone().array_count() == 6 && var_ipv4.clone().array_count() == 4) {
		mut iter_2 := var_ipv6.iterator()
		for {
			item_2 := iter_2.next() or { break }
			mut var_ipv6_part := item_2.val
			if rt.is_true(rt.identical(var_ipv6_part, rt.new_string(''))) {
				return false
			}
			if var_ipv6_part.clone().to_string().len > 4 {
				return false
			}
			var_ipv6_part = rt.new_string(var_ipv6_part.clone().to_string().trim_left(' \t\n\r'))
			if rt.is_true(rt.identical(var_ipv6_part, rt.new_string(''))) {
				var_ipv6_part = rt.new_string('0')
			}
			mut var_value := rt.call_function('hexdec', [var_ipv6_part.clone()])
			if rt.is_true(rt.less(var_value, rt.new_int(0)))
				|| rt.is_true(rt.greater(var_value, rt.new_int(65535))) {
				return false
			}
			rt.call_function('assert', [rt.new_bool(var_value.clone().is_long()),
				rt.new_string('For PHPStan: $value is only float when $ipv6_part > PHP_INT_MAX')])
			if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('dechex', [
				var_value.clone(),
			]), rt.new_string(var_ipv6_part.clone().to_string().to_lower())))))
			{
				return false
			}
		}
		if var_ipv4.clone().array_count() == 4 {
			mut iter_3 := var_ipv4.iterator()
			for {
				item_3 := iter_3.next() or { break }
				mut var_ipv4_part := item_3.val
				mut var_value := rt.new_int(var_ipv4_part.to_i64())
				if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_value.str(), var_ipv4_part))))
					|| rt.is_true(rt.less(var_value, rt.new_int(0)))
					|| rt.is_true(rt.greater(var_value, rt.new_int(255))) {
					return false
				}
			}
		}
		return true
	}
	return false
}

fn Class_SimplePie_Net_IPv6.checkipv6(ip string) rt.PhpVal {
	mut ip_mutated := ip
	return Class_SimplePie_Net_IPv6.check_ipv6(ip_mutated)
}

fn create_simplepie_net_ipv6(_args ...rt.PhpVal) &Class_SimplePie_Net_IPv6 {
	mut obj := &Class_SimplePie_Net_IPv6{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_SimplePie_Net_IPv6) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'uncompress' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return Class_SimplePie_Net_IPv6.uncompress(dispatch_arg_0)
		}
		'compress' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return Class_SimplePie_Net_IPv6.compress(dispatch_arg_0)
		}
		'split_v6_v4' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return Class_SimplePie_Net_IPv6.split_v6_v4(dispatch_arg_0)
		}
		'check_ipv6' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(Class_SimplePie_Net_IPv6.check_ipv6(dispatch_arg_0))
		}
		'checkIPv6' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return Class_SimplePie_Net_IPv6.checkipv6(dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_SimplePie_Net_IPv6) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_SimplePie_Net_IPv6) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.call_function('class_alias', [rt.new_string('SimplePie\\Net\\IPv6'),
		rt.new_string('SimplePie_Net_IPv6')])
}
