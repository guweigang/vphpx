import rt

struct Class_WpOrg_Requests_Cookie {
	rt.PhpObjectBase
pub mut:
	name           rt.PhpVal = rt.new_null()
	value          rt.PhpVal = rt.new_null()
	attributes     rt.PhpVal = rt.new_array()
	flags          rt.PhpVal = rt.new_array()
	reference_time rt.PhpVal = rt.new_int(0)
}

fn (mut this Class_WpOrg_Requests_Cookie) construct(var_name rt.PhpVal, var_value rt.PhpVal, var_attributes rt.PhpVal, var_flags rt.PhpVal, var_reference_time rt.PhpVal) {
	mut var_name_mutated := var_name
	mut var_value_mutated := var_value
	mut var_attributes_mutated := var_attributes
	if rt.is_true(rt.identical(rt.new_bool(var_name_mutated.clone().is_string()),
		rt.new_bool(false)))
	{
		mut iife_temp_0 := Class_WpOrg_Requests_Exception_InvalidArgument{}
		mut iife_result_0 := iife_temp_0.create(rt.new_int(1), rt.new_string('$name'),
			rt.new_string('string'), rt.call_function('gettype', [
			var_name_mutated.clone()]))
		rt.throw_exception(iife_result_0)
	}
	if rt.is_true(rt.identical(rt.new_bool(var_value_mutated.clone().is_string()),
		rt.new_bool(false)))
	{
		mut iife_temp_1 := Class_WpOrg_Requests_Exception_InvalidArgument{}
		mut iife_result_1 := iife_temp_1.create(rt.new_int(2), rt.new_string('$value'),
			rt.new_string('string'), rt.call_function('gettype', [
			var_value_mutated.clone()]))
		rt.throw_exception(iife_result_1)
	}
	mut iife_temp_2 := Class_WpOrg_Requests_Utility_InputValidator{}
	mut iife_result_2 := iife_temp_2.has_array_access(var_attributes_mutated.clone())
	mut iife_temp_3 := Class_WpOrg_Requests_Utility_InputValidator{}
	mut iife_result_3 := iife_temp_3.is_iterable(var_attributes_mutated.clone())
	if rt.is_true(rt.identical(iife_result_2, rt.new_bool(false)))
		|| rt.is_true(rt.identical(iife_result_3, rt.new_bool(false))) {
		mut iife_temp_4 := Class_WpOrg_Requests_Exception_InvalidArgument{}
		mut iife_result_4 := iife_temp_4.create(rt.new_int(3), rt.new_string('$attributes'),
			rt.new_string('array|ArrayAccess&Traversable'), rt.call_function('gettype', [
			var_attributes_mutated.clone(),
		]))
		rt.throw_exception(iife_result_4)
	}
	if rt.is_true(rt.identical(rt.new_bool(var_flags.clone().is_array()), rt.new_bool(false))) {
		mut iife_temp_5 := Class_WpOrg_Requests_Exception_InvalidArgument{}
		mut iife_result_5 := iife_temp_5.create(rt.new_int(4), rt.new_string('$flags'),
			rt.new_string('array'), rt.call_function('gettype', [
			var_flags.clone()]))
		rt.throw_exception(iife_result_5)
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_reference_time, rt.new_null()))))
		&& rt.is_true(rt.identical(rt.new_bool(var_reference_time.clone().is_long()), rt.new_bool(false))) {
		mut iife_temp_6 := Class_WpOrg_Requests_Exception_InvalidArgument{}
		mut iife_result_6 := iife_temp_6.create(rt.new_int(5), rt.new_string('$reference_time'),
			rt.new_string('integer|null'), rt.call_function('gettype', [
			var_reference_time.clone()]))
		rt.throw_exception(iife_result_6)
	}
	this.name = var_name_mutated.clone()
	this.value = var_value_mutated.clone()
	this.attributes = var_attributes_mutated.clone()
	mut var_default_flags := rt.create_array([
		rt.ArrayItem{ key: 'creation', val: rt.call_function('time', []rt.PhpVal{}) },
		rt.ArrayItem{ key: 'last-access', val: rt.call_function('time', []rt.PhpVal{}) },
		rt.ArrayItem{ key: 'persistent', val: false },
		rt.ArrayItem{ key: 'host-only', val: true },
	])
	this.flags = rt.call_function('array_merge', [var_default_flags.clone(),
		var_flags.clone()])
	this.reference_time = rt.call_function('time', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_reference_time, rt.new_null())))) {
		this.reference_time = var_reference_time.clone()
	}
	this.normalize()
}

fn (mut this Class_WpOrg_Requests_Cookie) magic_tostring() rt.PhpVal {
	return this.value
}

fn (mut this Class_WpOrg_Requests_Cookie) is_expired() bool {
	if this.attributes.array_isset(rt.new_string('max-age')) {
		mut var_max_age := this.attributes.array_get(rt.new_string('max-age'))
		return (rt.less(var_max_age, this.reference_time)).to_bool()
	}
	if this.attributes.array_isset(rt.new_string('expires')) {
		mut var_expires := this.attributes.array_get(rt.new_string('expires'))
		return (rt.less(var_expires, this.reference_time)).to_bool()
	}
	return false
}

fn (mut this Class_WpOrg_Requests_Cookie) uri_matches(mut var_uri Class_WpOrg_Requests_Iri) bool {
	if !(this.domain_matches(rt.get_property(var_uri, 'host'))) {
		return false
	}
	if !(this.path_matches(rt.get_property(var_uri, 'path'))) {
		return false
	}
	return !rt.is_true(this.attributes.array_get(rt.new_string('secure')))
		|| rt.is_true(rt.identical(rt.get_property(var_uri, 'scheme'), rt.new_string('https')))
}

fn (mut this Class_WpOrg_Requests_Cookie) domain_matches(var_domain rt.PhpVal) bool {
	if rt.is_true(rt.identical(rt.new_bool(var_domain.clone().is_string()), rt.new_bool(false))) {
		return false
	}
	if !(this.attributes.array_isset(rt.new_string('domain'))) {
		return true
	}
	mut var_cookie_domain := this.attributes.array_get(rt.new_string('domain'))
	if rt.is_true(rt.identical(var_cookie_domain, var_domain)) {
		return true
	}
	if rt.is_true(rt.identical(this.flags.array_get(rt.new_string('host-only')), rt.new_bool(true))) {
		return false
	}
	if var_domain.clone().to_string().len <= var_cookie_domain.clone().to_string().len {
		return false
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('substr', [
		var_domain.clone(),
		rt.new_int(-1 * var_cookie_domain.clone().to_string().len),
	]), var_cookie_domain))))
	{
		return false
	}
	mut var_prefix := rt.call_function('substr', [var_domain.clone(),
		rt.new_int(0),
		rt.new_int(var_domain.clone().to_string().len - var_cookie_domain.clone().to_string().len)])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('substr', [
		var_prefix.clone(),
		rt.new_int(-1),
	]), rt.new_string('.')))))
	{
		return false
	}
	return !(rt.is_true(rt.call_function('preg_match', [
		rt.new_string('#^(.+\\.)\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}$#'),
		var_domain.clone(),
	])))
}

fn (mut this Class_WpOrg_Requests_Cookie) path_matches(var_request_path rt.PhpVal) bool {
	mut var_request_path_mutated := var_request_path
	if !rt.is_true(var_request_path_mutated) {
		var_request_path_mutated = rt.new_string('/')
	}
	if !(this.attributes.array_isset(rt.new_string('path'))) {
		return true
	}
	if rt.is_true(rt.identical(rt.call_function('is_scalar', [
		var_request_path_mutated.clone()]), rt.new_bool(false)))
	{
		return false
	}
	mut var_cookie_path := this.attributes.array_get(rt.new_string('path'))
	if rt.is_true(rt.identical(var_cookie_path, var_request_path_mutated)) {
		return true
	}
	if var_request_path_mutated.clone().to_string().len > var_cookie_path.clone().to_string().len
		&& rt.is_true(rt.identical(rt.call_function('substr', [var_request_path_mutated.clone(), rt.new_int(0), rt.new_int(var_cookie_path.clone().to_string().len)]), var_cookie_path)) {
		if rt.is_true(rt.identical(rt.call_function('substr', [
			var_cookie_path.clone(), rt.new_int(-1)]), rt.new_string('/')))
		{
			return true
		}
		if rt.is_true(rt.identical(rt.call_function('substr', [
			var_request_path_mutated.clone(), rt.new_int(var_cookie_path.clone().to_string().len),
			rt.new_int(1)]), rt.new_string('/')))
		{
			return true
		}
	}
	return false
}

fn (mut this Class_WpOrg_Requests_Cookie) normalize() bool {
	mut iter_1 := this.attributes.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_value := item_1.val
		mut var_key := item_1.key
		mut var_orig_value := var_value.clone()
		if rt.is_true(rt.new_bool(var_key.clone().is_string())) {
			var_value = this.normalize_attribute(var_key.clone(), var_value.clone())
		}
		if rt.is_true(rt.identical(var_value, rt.new_null())) {
			this.attributes.array_unset(var_key)
			continue
		}
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_value, var_orig_value)))) {
			this.attributes.array_set(var_key, var_value.clone())
		}
	}
	return true
}

fn (mut this Class_WpOrg_Requests_Cookie) normalize_attribute(var_name rt.PhpVal, var_value rt.PhpVal) rt.PhpVal {
	mut var_name_mutated := var_name
	mut var_value_mutated := var_value
	mut switch_val_1 := rt.new_string(var_name_mutated.clone().to_string().to_lower())
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('expires'))) {
		if rt.is_true(rt.new_bool(var_value_mutated.clone().is_long())) {
			return var_value_mutated.clone()
		}
		mut var_expiry_time := rt.call_function('strtotime', [
			var_value_mutated.clone()])
		if rt.is_true(rt.identical(var_expiry_time, rt.new_bool(false))) {
			return rt.new_null()
		}
		return var_expiry_time.clone()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('max-age'))) {
		if rt.is_true(rt.new_bool(var_value_mutated.clone().is_long())) {
			return var_value_mutated.clone()
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('preg_match', [
			rt.new_string('/^-?\\d+$/'),
			var_value_mutated.clone(),
		])))))
		{
			return rt.new_null()
		}
		mut var_delta_seconds := rt.new_int(var_value_mutated.to_i64())
		if rt.is_true(rt.less_equal(var_delta_seconds, rt.new_int(0))) {
			var_expiry_time = rt.new_int(0)
		} else {
			var_expiry_time = rt.add(this.reference_time, var_delta_seconds)
		}
		return var_expiry_time.clone()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('domain'))) {
		if !rt.is_true(var_value_mutated) {
			return rt.new_null()
		}
		if rt.is_true(rt.identical(var_value_mutated.array_get(rt.new_int(0)), rt.new_string('.'))) {
			var_value_mutated = rt.call_function('substr', [var_value_mutated.clone(),
				rt.new_int(1)])
		}
		return var_value_mutated.clone()
	} else {
		return var_value_mutated.clone()
	}
	return rt.new_null()
}

fn (mut this Class_WpOrg_Requests_Cookie) format_for_header() rt.PhpVal {
	return rt.call_function('sprintf', [rt.new_string('%s=%s'), this.name, this.value])
}

fn (mut this Class_WpOrg_Requests_Cookie) format_for_set_cookie() rt.PhpVal {
	mut var_header_value := this.format_for_header()
	if !(!rt.is_true(this.attributes)) {
		mut var_parts := rt.new_array()
		mut iter_2 := this.attributes.iterator()
		for {
			item_2 := iter_2.next() or { break }
			mut var_value := item_2.val
			mut var_key := item_2.key
			if rt.is_true(rt.new_bool(var_key.clone().is_long() || var_key.clone().is_double())) {
				var_parts.array_push(var_value.clone())
			} else {
				var_parts.array_push(rt.call_function('sprintf', [
					rt.new_string('%s=%s'), var_key.clone(), var_value.clone()]))
			}
		}
		var_header_value = rt.concat(var_header_value, rt.new_string('; ' +
			(rt.call_function('implode', [rt.new_string('; '), var_parts.clone()])).str()))
	}
	return var_header_value.clone()
}

fn Class_WpOrg_Requests_Cookie.parse(var_cookie_header rt.PhpVal, name string, var_reference_time rt.PhpVal) rt.PhpVal {
	mut name_mutated := name
	if rt.is_true(rt.identical(rt.new_bool(var_cookie_header.clone().is_string()),
		rt.new_bool(false)))
	{
		mut iife_temp_7 := Class_WpOrg_Requests_Exception_InvalidArgument{}
		mut iife_result_7 := iife_temp_7.create(rt.new_int(1), rt.new_string('$cookie_header'),
			rt.new_string('string'), rt.call_function('gettype', [
			var_cookie_header.clone()]))
		rt.throw_exception(iife_result_7)
	}
	if rt.is_true(rt.identical(rt.new_bool(rt.new_string(name_mutated).clone().is_string()),
		rt.new_bool(false)))
	{
		mut iife_temp_8 := Class_WpOrg_Requests_Exception_InvalidArgument{}
		mut iife_result_8 := iife_temp_8.create(rt.new_int(2), rt.new_string('$name'),
			rt.new_string('string'), rt.call_function('gettype', [
			rt.new_string(name_mutated).clone()]))
		rt.throw_exception(iife_result_8)
	}
	mut var_parts := rt.call_function('explode', [rt.new_string(';'),
		var_cookie_header.clone()])
	mut var_kvparts := rt.call_function('array_shift', [var_parts.clone()])
	if !(name_mutated == '') {
		mut var_value := var_cookie_header
	} else if rt.is_true(rt.identical(rt.call_function('strpos', [
		var_kvparts.clone(), rt.new_string('=')]), rt.new_bool(false)))
	{
		name_mutated = ''
		var_value = var_kvparts.clone()
	} else {
		mut list_tmp_1 := rt.call_function('explode', [rt.new_string('='),
			var_kvparts.clone(), rt.new_int(2)])
		name_mutated = list_tmp_1.array_get(0)
		var_value = list_tmp_1.array_get(1)
	}
	name_mutated = name_mutated.trim_space()
	var_value = rt.new_string(var_value.clone().to_string().trim_space())
	mut var_attributes := create_wporg_requests_utility_caseinsensitivedictionary()
	if !(!rt.is_true(var_parts)) {
		mut iter_3 := var_parts.iterator()
		for {
			item_3 := iter_3.next() or { break }
			mut var_part := item_3.val
			if rt.is_true(rt.identical(rt.call_function('strpos', [
				var_part.clone(), rt.new_string('=')]), rt.new_bool(false)))
			{
				mut var_part_key := var_part
				mut var_part_value := rt.new_bool(true)
			} else {
				mut list_tmp_2 := rt.call_function('explode', [
					rt.new_string('='), var_part.clone(), rt.new_int(2)])
				var_part_key = list_tmp_2.array_get(0)
				var_part_value = list_tmp_2.array_get(1)
				var_part_value = rt.new_string(var_part_value.clone().to_string().trim_space())
			}
			var_part_key = rt.new_string(var_part_key.clone().to_string().trim_space())
			var_attributes.array_set(var_part_key, var_part_value.clone())
		}
	}
	return rt.new_object('WpOrg_Requests_static', []string{}, create_wporg_requests_static(rt.new_string(name_mutated).clone(),
		var_value.clone(), var_attributes, rt.new_array(), var_reference_time.clone()))
}

fn Class_WpOrg_Requests_Cookie.parse_from_headers(mut var_headers Class_WpOrg_Requests_Response_Headers, var_origin rt.PhpVal, var_time rt.PhpVal) rt.PhpVal {
	mut var_cookie_headers := var_headers.getvalues(rt.new_string('Set-Cookie'))
	if !rt.is_true(var_cookie_headers) {
		return rt.new_array()
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_origin, rt.new_null()))))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_origin, 'WpOrg_Requests_Iri')))))) {
		mut iife_temp_9 := Class_WpOrg_Requests_Exception_InvalidArgument{}
		mut iife_result_9 := iife_temp_9.create(rt.new_int(2), rt.new_string('$origin'), rt.new_string(
			(Class_WpOrg_Requests_Iri.class()).str() + ' or null'), rt.call_function('gettype', [
			var_origin.clone(),
		]))
		rt.throw_exception(iife_result_9)
	}
	mut var_cookies := rt.new_array()
	mut iter_4 := var_cookie_headers.iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_header := item_4.val
		mut var_parsed := Class_WpOrg_Requests_Cookie.parse(var_header.str(), rt.new_string(''),
			var_time.clone())
		if !rt.is_true(rt.get_property(var_parsed, 'attributes').array_get(rt.new_string('domain')))
			&& !(!rt.is_true(var_origin)) {
			rt.get_property(var_parsed, 'attributes').array_set('domain', rt.get_property(var_origin,
				'host'))
			rt.get_property(var_parsed, 'flags').array_set('host-only', true)
		} else {
			rt.get_property(var_parsed, 'flags').array_set('host-only', false)
		}
		mut var_path_is_valid := rt.new_bool(
			!(!rt.is_true(rt.get_property(var_parsed, 'attributes').array_get(rt.new_string('path'))))
			&& rt.is_true(rt.identical(rt.get_property(var_parsed, 'attributes').array_get(rt.new_string('path')).array_get(rt.new_int(0)), rt.new_string('/'))))
		if rt.is_true(rt.new_bool(!(rt.is_true(var_path_is_valid)))) && !(!rt.is_true(var_origin)) {
			mut var_path := rt.get_property(var_origin, 'path')
			if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('substr', [
				var_path.clone(),
				rt.new_int(0),
				rt.new_int(1),
			]), rt.new_string('/')))))
			{
				var_path = rt.new_string('/')
			} else if rt.is_true(rt.identical(rt.call_function('substr_count', [
				var_path.clone(),
				rt.new_string('/'),
			]), rt.new_int(1)))
			{
				var_path = rt.new_string('/')
			} else {
				var_path = rt.call_function('substr', [var_path.clone(),
					rt.new_int(0), rt.call_function('strrpos', [
						var_path.clone(), rt.new_string('/')])])
			}
			rt.get_property(var_parsed, 'attributes').array_set('path', var_path.clone())
		}
		if !(!rt.is_true(var_origin))
			&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_parsed, 'domain_matches', [rt.get_property(var_origin, 'host')]))))) {
			continue
		}
		var_cookies.array_set(rt.get_property(var_parsed, 'name'), var_parsed.clone())
	}
	return var_cookies.clone()
}

struct Class_WpOrg_Requests_Exception_InvalidArgument {
	rt.PhpObjectBase
}

struct Class_WpOrg_Requests_Utility_InputValidator {
	rt.PhpObjectBase
}

struct Class_WpOrg_Requests_Utility_CaseInsensitiveDictionary {
	rt.PhpObjectBase
}

struct Class_WpOrg_Requests_static {
	rt.PhpObjectBase
}

fn create_wporg_requests_cookie(arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal, arg_3 rt.PhpVal, arg_4 rt.PhpVal) &Class_WpOrg_Requests_Cookie {
	mut obj := &Class_WpOrg_Requests_Cookie{
		PhpObjectBase:  rt.PhpObjectBase{}
		name:           rt.new_null()
		value:          rt.new_null()
		attributes:     rt.new_array()
		flags:          rt.new_array()
		reference_time: rt.new_int(0)
	}
	obj.construct(arg_0, arg_1, arg_2, arg_3, arg_4)
	return obj
}

fn create_wporg_requests_exception_invalidargument(_args ...rt.PhpVal) &Class_WpOrg_Requests_Exception_InvalidArgument {
	mut obj := &Class_WpOrg_Requests_Exception_InvalidArgument{
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

fn create_wporg_requests_utility_caseinsensitivedictionary(_args ...rt.PhpVal) &Class_WpOrg_Requests_Utility_CaseInsensitiveDictionary {
	mut obj := &Class_WpOrg_Requests_Utility_CaseInsensitiveDictionary{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wporg_requests_static(_args ...rt.PhpVal) &Class_WpOrg_Requests_static {
	mut obj := &Class_WpOrg_Requests_static{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WpOrg_Requests_Cookie) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			dispatch_arg_4 := if args.len > 4 { args[4] } else { rt.new_null() }
			this.construct(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3,
				dispatch_arg_4)
			return rt.new_null()
		}
		'__toString' {
			return this.magic_tostring()
		}
		'is_expired' {
			return rt.new_bool(this.is_expired())
		}
		'uri_matches' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WpOrg_Requests_Iri](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return rt.new_bool(this.uri_matches(mut dispatch_arg_0))
		}
		'domain_matches' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.domain_matches(dispatch_arg_0))
		}
		'path_matches' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.path_matches(dispatch_arg_0))
		}
		'normalize' {
			return rt.new_bool(this.normalize())
		}
		'normalize_attribute' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.normalize_attribute(dispatch_arg_0, dispatch_arg_1)
		}
		'format_for_header' {
			return this.format_for_header()
		}
		'format_for_set_cookie' {
			return this.format_for_set_cookie()
		}
		'parse' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return Class_WpOrg_Requests_Cookie.parse(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'parse_from_headers' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WpOrg_Requests_Response_Headers](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return Class_WpOrg_Requests_Cookie.parse_from_headers(mut dispatch_arg_0,
				dispatch_arg_1, dispatch_arg_2)
		}
		else {
			return none
		}
	}
}

fn (this &Class_WpOrg_Requests_Cookie) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'name' { return this.name }
		'value' { return this.value }
		'attributes' { return this.attributes }
		'flags' { return this.flags }
		'reference_time' { return this.reference_time }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WpOrg_Requests_Cookie) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'name' {
			this.name = val
			return true
		}
		'value' {
			this.value = val
			return true
		}
		'attributes' {
			this.attributes = val
			return true
		}
		'flags' {
			this.flags = val
			return true
		}
		'reference_time' {
			this.reference_time = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
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

fn (mut this Class_WpOrg_Requests_Utility_InputValidator) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WpOrg_Requests_Utility_InputValidator) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WpOrg_Requests_Utility_InputValidator) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WpOrg_Requests_Utility_CaseInsensitiveDictionary) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WpOrg_Requests_Utility_CaseInsensitiveDictionary) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WpOrg_Requests_Utility_CaseInsensitiveDictionary) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WpOrg_Requests_static) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WpOrg_Requests_static) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WpOrg_Requests_static) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
