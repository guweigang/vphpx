import rt

struct Class_WpOrg_Requests_Cookie_Jar {
	rt.PhpObjectBase
pub mut:
	cookies rt.PhpVal = rt.new_array()
}

fn (mut this Class_WpOrg_Requests_Cookie_Jar) construct(var_cookies rt.PhpVal) {
	mut var_cookies_mutated := var_cookies
	if rt.is_true(rt.identical(rt.new_bool(var_cookies_mutated.dup().is_array()),
		rt.new_bool(false)))
	{
		rt.throw_exception(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal, arg_3 rt.PhpVal) rt.PhpVal {
			mut temp := Class_WpOrg_Requests_Exception_InvalidArgument{}
			return temp.create(arg_0, arg_1, arg_2, arg_3)
		}(rt.new_int(1), rt.new_string('$cookies'), rt.new_string('array'), rt.call_function('gettype', [
			var_cookies_mutated.dup(),
		])))
	}
	this.cookies = var_cookies_mutated.dup()
}

fn (mut this Class_WpOrg_Requests_Cookie_Jar) normalize_cookie(var_cookie rt.PhpVal, key string) rt.PhpVal {
	mut var_cookie_mutated := var_cookie
	if rt.is_true(rt.new_bool(rt.instance_of(var_cookie_mutated, 'WpOrg_Requests_Cookie'))) {
		return var_cookie_mutated.dup()
	}
	return fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal {
		mut temp := Class_WpOrg_Requests_Cookie{}
		return temp.parse(arg_0, arg_1)
	}(var_cookie_mutated.dup(), rt.new_string(key))
}

fn (mut this Class_WpOrg_Requests_Cookie_Jar) offsetexists(var_offset rt.PhpVal) rt.PhpVal {
	return rt.new_bool(this.cookies.array_isset(var_offset))
}

fn (mut this Class_WpOrg_Requests_Cookie_Jar) offsetget(var_offset rt.PhpVal) rt.PhpVal {
	if !(this.cookies.array_isset(var_offset)) {
		return rt.new_null()
	}
	return this.cookies.array_get(var_offset)
}

fn (mut this Class_WpOrg_Requests_Cookie_Jar) offsetset(var_offset rt.PhpVal, var_value rt.PhpVal) {
	if rt.is_true(rt.identical(var_offset, rt.new_null())) {
		rt.throw_exception(rt.new_object('WpOrg_Requests_Exception', []string{}, create_wporg_requests_exception(rt.new_string('Object is a dictionary, not a list'),
			rt.new_string('invalidset'))))
	}
	this.cookies.array_set(var_offset, var_value.dup())
}

fn (mut this Class_WpOrg_Requests_Cookie_Jar) offsetunset(var_offset rt.PhpVal) {
	this.cookies.array_unset(var_offset)
}

fn (mut this Class_WpOrg_Requests_Cookie_Jar) getiterator() rt.PhpVal {
	return create_arrayiterator(this.cookies)
}

fn (mut this Class_WpOrg_Requests_Cookie_Jar) register(mut var_hooks Class_WpOrg_Requests_HookManager) {
	var_hooks.register(rt.new_string('requests.before_request'), rt.create_array([
		rt.ArrayItem{ key: none, val: rt.new_object('WpOrg_Requests_Cookie_Jar', [
			'ArrayAccess',
			'IteratorAggregate',
		], &this) },
		rt.ArrayItem{ key: none, val: 'before_request' },
	]))
	var_hooks.register(rt.new_string('requests.before_redirect_check'), rt.create_array([
		rt.ArrayItem{ key: none, val: rt.new_object('WpOrg_Requests_Cookie_Jar', [
			'ArrayAccess',
			'IteratorAggregate',
		], &this) },
		rt.ArrayItem{ key: none, val: 'before_redirect_check' },
	]))
}

fn (mut this Class_WpOrg_Requests_Cookie_Jar) before_request(var_url rt.PhpVal, var_headers rt.PhpVal, var_data rt.PhpVal, var_type rt.PhpVal, var_options rt.PhpVal) {
	mut var_url_mutated := var_url
	mut var_headers_mutated := var_headers
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_url_mutated,
		'WpOrg_Requests_Iri'))))))
	{
		var_url_mutated = create_wporg_requests_iri(var_url_mutated.dup())
	}
	if !(!rt.is_true(this.cookies)) {
		mut var_cookies := rt.new_array()
		{
			mut iter_1 := this.cookies.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_cookie := item_1.val
				mut var_key := item_1.key
				var_cookie = this.normalize_cookie(var_cookie.dup(), var_key.str())
				if rt.is_true(rt.call_method(var_cookie, 'is_expired', []rt.PhpVal{})) {
					continue
				}
				if rt.is_true(rt.call_method(var_cookie, 'domain_matches', [
					rt.get_property(var_url_mutated, 'host'),
				]))
				{
					var_cookies.array_push(rt.call_method(var_cookie, 'format_for_header',
						[]rt.PhpVal{}))
				}
			}
		}
		var_headers_mutated.array_set('Cookie', rt.call_function('implode', [
			rt.new_string('; '),
			var_cookies.dup(),
		]))
	}
}

fn (mut this Class_WpOrg_Requests_Cookie_Jar) before_redirect_check(mut var_response Class_WpOrg_Requests_Response) {
	mut var_response_mutated := var_response
	mut var_url := rt.get_property(var_response_mutated, 'url')
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_url, 'WpOrg_Requests_Iri')))))) {
		var_url = create_wporg_requests_iri(var_url.dup())
	}
	mut var_cookies := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal {
		mut temp := Class_WpOrg_Requests_Cookie{}
		return temp.parse_from_headers(arg_0, arg_1)
	}(rt.get_property(var_response_mutated, 'headers'), var_url.dup())
	this.cookies = rt.call_function('array_merge', [this.cookies, var_cookies.dup()])
	rt.set_property(var_response_mutated, 'cookies', rt.new_object('WpOrg_Requests_Cookie_Jar', [
		'ArrayAccess',
		'IteratorAggregate',
	], &this).dup())
}

struct Class_WpOrg_Requests_Exception_InvalidArgument {
	rt.PhpObjectBase
}

struct Class_WpOrg_Requests_Cookie {
	rt.PhpObjectBase
}

struct Class_WpOrg_Requests_Exception {
	rt.PhpObjectBase
}

struct Class_ArrayIterator {
	rt.PhpObjectBase
}

struct Class_WpOrg_Requests_Iri {
	rt.PhpObjectBase
}

fn create_wporg_requests_cookie_jar(arg_0 rt.PhpVal) &Class_WpOrg_Requests_Cookie_Jar {
	mut obj := &Class_WpOrg_Requests_Cookie_Jar{
		PhpObjectBase: rt.PhpObjectBase{}
		cookies:       rt.new_array()
	}
	obj.construct(arg_0)
	return obj
}

fn create_wporg_requests_exception_invalidargument() &Class_WpOrg_Requests_Exception_InvalidArgument {
	mut obj := &Class_WpOrg_Requests_Exception_InvalidArgument{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wporg_requests_cookie() &Class_WpOrg_Requests_Cookie {
	mut obj := &Class_WpOrg_Requests_Cookie{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wporg_requests_exception() &Class_WpOrg_Requests_Exception {
	mut obj := &Class_WpOrg_Requests_Exception{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_arrayiterator() &Class_ArrayIterator {
	mut obj := &Class_ArrayIterator{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wporg_requests_iri() &Class_WpOrg_Requests_Iri {
	mut obj := &Class_WpOrg_Requests_Iri{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WpOrg_Requests_Cookie_Jar) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'normalize_cookie' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return this.normalize_cookie(dispatch_arg_0, dispatch_arg_1)
		}
		'offsetExists' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.offsetexists(dispatch_arg_0)
		}
		'offsetGet' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.offsetget(dispatch_arg_0)
		}
		'offsetSet' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.offsetset(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'offsetUnset' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.offsetunset(dispatch_arg_0)
			return rt.new_null()
		}
		'getIterator' {
			return this.getiterator()
		}
		'register' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WpOrg_Requests_HookManager](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.register(mut dispatch_arg_0)
			return rt.new_null()
		}
		'before_request' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			dispatch_arg_4 := if args.len > 4 { args[4] } else { rt.new_null() }
			this.before_request(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3,
				dispatch_arg_4)
			return rt.new_null()
		}
		'before_redirect_check' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WpOrg_Requests_Response](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.before_redirect_check(mut dispatch_arg_0)
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WpOrg_Requests_Cookie_Jar) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'cookies' { return this.cookies }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WpOrg_Requests_Cookie_Jar) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'cookies' {
			this.cookies = val
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

fn (mut this Class_WpOrg_Requests_Cookie) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WpOrg_Requests_Cookie) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WpOrg_Requests_Cookie) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_ArrayIterator) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ArrayIterator) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ArrayIterator) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WpOrg_Requests_Iri) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WpOrg_Requests_Iri) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WpOrg_Requests_Iri) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_includes_requests_src_cookie_jar_php() {
}
