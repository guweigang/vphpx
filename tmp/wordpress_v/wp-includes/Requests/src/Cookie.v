import rt

struct Class_WpOrg_Requests_Cookie {
	rt.PhpObjectBase
pub mut:
		name rt.PhpVal = rt.new_null()
		value rt.PhpVal = rt.new_null()
		attributes rt.PhpVal = rt.new_array()
		flags rt.PhpVal = rt.new_array()
		reference_time rt.PhpVal = rt.new_int(0)
}

fn (mut this Class_WpOrg_Requests_Cookie) construct(var_name rt.PhpVal, var_value rt.PhpVal, var_attributes rt.PhpVal, var_flags rt.PhpVal, var_reference_time rt.PhpVal)  {
	mut var_name_mutated := var_name
	mut var_value_mutated := var_value
	mut var_attributes_mutated := var_attributes
	if rt.is_true(rt.identical(rt.new_bool(var_name_mutated.dup().is_string()), rt.new_bool(false))) {
		rt.throw_exception(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal, arg_3 rt.PhpVal) rt.PhpVal { mut temp := Class_WpOrg_Requests_Exception_InvalidArgument{}; return temp.create(arg_0, arg_1, arg_2, arg_3) }(rt.new_int(1), rt.new_string('$name'), rt.new_string('string'), rt.call_function('gettype', [var_name_mutated.dup()])))
	}
	if rt.is_true(rt.identical(rt.new_bool(var_value_mutated.dup().is_string()), rt.new_bool(false))) {
		rt.throw_exception(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal, arg_3 rt.PhpVal) rt.PhpVal { mut temp := Class_WpOrg_Requests_Exception_InvalidArgument{}; return temp.create(arg_0, arg_1, arg_2, arg_3) }(rt.new_int(2), rt.new_string('$value'), rt.new_string('string'), rt.call_function('gettype', [var_value_mutated.dup()])))
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.identical(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WpOrg_Requests_Utility_InputValidator{}; return temp.has_array_access(arg_0) }(var_attributes_mutated), rt.new_bool(false))) || rt.is_true(rt.identical(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WpOrg_Requests_Utility_InputValidator{}; return temp.is_iterable(arg_0) }(var_attributes_mutated), rt.new_bool(false))))) {
		rt.throw_exception(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal, arg_3 rt.PhpVal) rt.PhpVal { mut temp := Class_WpOrg_Requests_Exception_InvalidArgument{}; return temp.create(arg_0, arg_1, arg_2, arg_3) }(rt.new_int(3), rt.new_string('$attributes'), rt.new_string('array|ArrayAccess&Traversable'), rt.call_function('gettype', [var_attributes_mutated])))
	}
	if rt.is_true(rt.identical(rt.new_bool(var_flags.dup().is_array()), rt.new_bool(false))) {
		rt.throw_exception(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal, arg_3 rt.PhpVal) rt.PhpVal { mut temp := Class_WpOrg_Requests_Exception_InvalidArgument{}; return temp.create(arg_0, arg_1, arg_2, arg_3) }(rt.new_int(4), rt.new_string('$flags'), rt.new_string('array'), rt.call_function('gettype', [var_flags.dup()])))
	}
	if rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) && rt.is_true(rt.identical(rt.new_bool(var_reference_time.dup().is_long()), rt.new_bool(false))))) {
		rt.throw_exception(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal, arg_3 rt.PhpVal) rt.PhpVal { mut temp := Class_WpOrg_Requests_Exception_InvalidArgument{}; return temp.create(arg_0, arg_1, arg_2, arg_3) }(rt.new_int(5), rt.new_string('$reference_time'), rt.new_string('integer|null'), rt.call_function('gettype', [var_reference_time.dup()])))
	}
	this.name = var_name_mutated.dup()
	this.value = var_value_mutated.dup()
	this.attributes = var_attributes_mutated.dup()
	mut var_default_flags := rt.create_array([rt.ArrayItem{ key: 'creation', val: rt.call_function('time', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'last-access', val: rt.call_function('time', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'persistent', val: false }, rt.ArrayItem{ key: 'host-only', val: true }])
	this.flags = rt.call_function('array_merge', [var_default_flags.dup(), var_flags.dup()])
	this.reference_time = rt.call_function('time', []rt.PhpVal{})
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		this.reference_time = var_reference_time.dup()
	}
	this.normalize()
}

fn (mut this Class_WpOrg_Requests_Cookie) magic_tostring() rt.PhpVal {
	return this.value
}

fn (mut this Class_WpOrg_Requests_Cookie) is_expired() bool {
	if this.attributes.array_isset(rt.new_string('max-age')) {
		mut var_max_age := this.attributes.array_get('max-age')
		return (rt.less(var_max_age, this.reference_time)).to_bool()
	}
	if this.attributes.array_isset(rt.new_string('expires')) {
		mut var_expires := this.attributes.array_get('expires')
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
	return !rt.is_true(this.attributes.array_get('secure')) || rt.is_true(rt.identical(rt.get_property(var_uri, 'scheme'), rt.new_string('https')))
}

fn (mut this Class_WpOrg_Requests_Cookie) domain_matches(var_domain rt.PhpVal) bool {
	if rt.is_true(rt.identical(rt.new_bool(var_domain.dup().is_string()), rt.new_bool(false))) {
		return false
	}
	if !(this.attributes.array_isset(rt.new_string('domain'))) {
		return true
	}
	mut var_cookie_domain := this.attributes.array_get('domain')
	if rt.is_true(rt.identical(var_cookie_domain, var_domain)) {
		return true
	}
	if rt.is_true(rt.identical(this.flags.array_get('host-only'), rt.new_bool(true))) {
		return false
	}
	if var_domain.dup().to_string().len <= var_cookie_domain.dup().to_string().len {
		return false
	}
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return false
	}
	mut var_prefix := rt.call_function('substr', [var_domain.dup(), rt.new_int(0), var_domain.dup().to_string().len - var_cookie_domain.dup().to_string().len])
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return false
	}
	return !(rt.is_true(rt.call_function('preg_match', [rt.new_string('#^(.+\\.)\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}$#'), var_domain.dup()])))
}

fn (mut this Class_WpOrg_Requests_Cookie) path_matches(var_request_path rt.PhpVal) bool {
	mut var_request_path_mutated := var_request_path
	if !rt.is_true(var_request_path_mutated) {
		var_request_path_mutated = rt.new_string(rt.new_string('/'))
	}
	if !(this.attributes.array_isset(rt.new_string('path'))) {
		return true
	}
	if rt.is_true(rt.identical(rt.call_function('is_scalar', [var_request_path_mutated.dup()]), rt.new_bool(false))) {
		return false
	}
	mut var_cookie_path := this.attributes.array_get('path')
	if rt.is_true(rt.identical(var_cookie_path, var_request_path_mutated)) {
		return true
	}
	if rt.is_true(rt.new_bool(var_request_path_mutated.dup().to_string().len > var_cookie_path.dup().to_string().len && rt.is_true(rt.identical(rt.call_function('substr', [var_request_path_mutated.dup(), rt.new_int(0), rt.new_int(var_cookie_path.dup().to_string().len)]), var_cookie_path)))) {
		if rt.is_true(rt.identical(rt.call_function('substr', [var_cookie_path.dup(), // unsupported expression: Expr_UnaryMinus]), rt.new_string('/'))) {
			return true
		}
		if rt.is_true(rt.identical(rt.call_function('substr', [var_request_path_mutated.dup(), rt.new_int(var_cookie_path.dup().to_string().len), rt.new_int(1)]), rt.new_string('/'))) {
			return true
		}
	}
	return false
}

fn (mut this Class_WpOrg_Requests_Cookie) normalize() bool {
	{
		mut iter_1 := this.attributes.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_value := item_1.val
			mut var_key := item_1.key
			mut var_orig_value := var_value.dup()
			if rt.is_true(rt.new_bool(var_key.dup().is_string())) {
				var_value = this.normalize_attribute(var_key.dup(), var_value.dup())
			}
			if rt.is_true(rt.identical(var_value, rt.new_null())) {
				this.attributes.array_unset(var_key)
				continue
			}
			if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
				this.attributes.array_set(var_key, var_value.dup())
			}
		}
	}
	return true
}

fn (mut this Class_WpOrg_Requests_Cookie) normalize_attribute(var_name rt.PhpVal, var_value rt.PhpVal)  {
	mut var_name_mutated := var_name
	mut var_value_mutated := var_value
	mut switch_val_1 := rt.new_string(var_name_mutated.dup().to_string().to_lower())
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('expires'))) {
		if rt.is_true(rt.new_bool(var_value_mutated.dup().is_long())) {
			return var_value_mutated.dup()
		}
		mut var_expiry_time := rt.call_function('strtotime', [var_value_mutated.dup()])
		if rt.is_true(rt.identical(var_expiry_time, rt.new_bool(false))) {
			return rt.new_null()
		}
		return var_expiry_time.dup()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('max-age'))) {
		if rt.is_true(rt.new_bool(var_value_mutated.dup().is_long())) {
			return var_value_mutated.dup()
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('preg_match', [rt.new_string('/^-?\\d+$/'), var_value_mutated.dup()]))))) {
			return rt.new_null()
		}
		mut var_delta_seconds := // unsupported expression: Expr_Cast_Int
		if rt.is_true(rt.less_equal(var_delta_seconds, rt.new_int(0))) {
			var_expiry_time = rt.new_int(rt.new_int(0))
		} else {
			var_expiry_time = rt.add(this.reference_time, var_delta_seconds)
		}
		return var_expiry_time.dup()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('domain'))) {
		if !rt.is_true(var_value_mutated) {
			return rt.new_null()
		}
		if rt.is_true(rt.identical(var_value_mutated.array_get(0), rt.new_string('.'))) {
			var_value_mutated = rt.call_function('substr', [var_value_mutated.dup(), rt.new_int(1)])
		}
		return var_value_mutated.dup()
	} else {
		return var_value_mutated.dup()
	}
}

fn (mut this Class_WpOrg_Requests_Cookie) format_for_header() rt.PhpVal {
	return rt.call_function('sprintf', [rt.new_string('%s=%s'), this.name, this.value])
}

fn (mut this Class_WpOrg_Requests_Cookie) format_for_set_cookie() rt.PhpVal {
	mut var_header_value := this.format_for_header()
	if !(!rt.is_true(this.attributes)) {
		mut var_parts := rt.new_array()
		{
			mut iter_1 := this.attributes.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_value := item_1.val
				mut var_key := item_1.key
				if rt.is_true(rt.new_bool(var_key.dup().is_long() || var_key.dup().is_double())) {
					var_parts.array_push(var_value.dup())
				} else {
					var_parts.array_push(rt.call_function('sprintf', [rt.new_string('%s=%s'), var_key.dup(), var_value.dup()]))
				}
			}
		}
		// unsupported expression: Expr_AssignOp_Concat
	}
	return var_header_value.dup()
}

fn Class_WpOrg_Requests_Cookie.parse(var_cookie_header rt.PhpVal, name string, var_reference_time rt.PhpVal) rt.PhpVal {
	mut name_mutated := name
	if rt.is_true(rt.identical(rt.new_bool(var_cookie_header.dup().is_string()), rt.new_bool(false))) {
		rt.throw_exception(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal, arg_3 rt.PhpVal) rt.PhpVal { mut temp := Class_WpOrg_Requests_Exception_InvalidArgument{}; return temp.create(arg_0, arg_1, arg_2, arg_3) }(rt.new_int(1), rt.new_string('$cookie_header'), rt.new_string('string'), rt.call_function('gettype', [var_cookie_header.dup()])))
	}
	if rt.is_true(rt.identical(rt.new_bool(rt.new_string(name_mutated).dup().is_string()), rt.new_bool(false))) {
		rt.throw_exception(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal, arg_3 rt.PhpVal) rt.PhpVal { mut temp := Class_WpOrg_Requests_Exception_InvalidArgument{}; return temp.create(arg_0, arg_1, arg_2, arg_3) }(rt.new_int(2), rt.new_string('$name'), rt.new_string('string'), rt.call_function('gettype', [rt.new_string(name_mutated).dup()])))
	}
	mut var_parts := rt.call_function('explode', [rt.new_string(';'), var_cookie_header.dup()])
	mut var_kvparts := rt.call_function('array_shift', [var_parts.dup()])
	if !(name_mutated == '') {
		mut var_value := var_cookie_header
	} else if rt.is_true(rt.identical(rt.call_function('strpos', [var_kvparts.dup(), rt.new_string('=')]), rt.new_bool(false))) {
		name_mutated = ''
		var_value = var_kvparts.dup()
	} else {
		// unsupported assign target: Expr_List
	}
	name_mutated = name_mutated.trim_space()
	var_value = rt.new_string(rt.new_string(var_value.dup().to_string().trim_space()))
	mut var_attributes := create_wporg_requests_utility_caseinsensitivedictionary()
	if !(!rt.is_true(var_parts)) {
		{
			mut iter_1 := var_parts.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_part := item_1.val
				if rt.is_true(rt.identical(rt.call_function('strpos', [var_part.dup(), rt.new_string('=')]), rt.new_bool(false))) {
					mut var_part_key := var_part
					mut var_part_value := rt.new_bool(rt.new_bool(true))
				} else {
					// unsupported assign target: Expr_List
					var_part_value = rt.new_string(rt.new_string(var_part_value.dup().to_string().trim_space()))
				}
				var_part_key = rt.new_string(rt.new_string(var_part_key.dup().to_string().trim_space()))
				var_attributes.array_set(var_part_key, var_part_value.dup())
			}
		}
	}
	return create_wporg_requests_static(rt.new_string(name_mutated).dup(), var_value.dup(), var_attributes.dup(), rt.new_array(), var_reference_time.dup())
}

fn Class_WpOrg_Requests_Cookie.parse_from_headers(mut var_headers Class_WpOrg_Requests_Response_Headers, var_origin rt.PhpVal, var_time rt.PhpVal) rt.PhpVal {
	mut var_cookie_headers := var_headers.getvalues(rt.new_string('Set-Cookie'))
	if !rt.is_true(var_cookie_headers) {
		return rt.new_array()
	}
	if rt.is_true(rt.new_bool(rt.is_true() && rt.is_true())) {
		
	}
	
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
		PhpObjectBase: rt.PhpObjectBase{}
		name: rt.new_null()
		value: rt.new_null()
		attributes: rt.new_array()
		flags: rt.new_array()
		reference_time: rt.new_int(0)
	}
	obj.construct(arg_0, arg_1, arg_2, arg_3, arg_4)
	return obj
}

fn create_wporg_requests_exception_invalidargument() &Class_WpOrg_Requests_Exception_InvalidArgument {
	mut obj := &Class_WpOrg_Requests_Exception_InvalidArgument{
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

fn create_wporg_requests_utility_caseinsensitivedictionary() &Class_WpOrg_Requests_Utility_CaseInsensitiveDictionary {
	mut obj := &Class_WpOrg_Requests_Utility_CaseInsensitiveDictionary{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wporg_requests_static() &Class_WpOrg_Requests_static {
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
			this.construct(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3, dispatch_arg_4)
			return rt.new_null()
		}
		'__toString' {
			return this.magic_tostring()
		}
		'is_expired' {
			return rt.new_bool(this.is_expired())
		}
		'uri_matches' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WpOrg_Requests_Iri](if args.len > 0 { args[0] } else { rt.new_null() })
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
			this.normalize_attribute(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
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
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WpOrg_Requests_Response_Headers](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return Class_WpOrg_Requests_Cookie.parse_from_headers(mut dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		else { return none }
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
		'name' { this.name = val; return true }
		'value' { this.value = val; return true }
		'attributes' { this.attributes = val; return true }
		'flags' { this.flags = val; return true }
		'reference_time' { this.reference_time = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
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




pub fn init_wp_includes_requests_src_cookie_php() {
}
