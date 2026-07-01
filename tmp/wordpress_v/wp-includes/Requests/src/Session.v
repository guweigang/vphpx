import rt

struct Class_WpOrg_Requests_Session {
	rt.PhpObjectBase
pub mut:
		url rt.PhpVal = rt.new_null()
		headers rt.PhpVal = rt.new_array()
		data rt.PhpVal = rt.new_array()
		options rt.PhpVal = rt.new_array()
}

fn (mut this Class_WpOrg_Requests_Session) construct(var_url rt.PhpVal, var_headers rt.PhpVal, var_data rt.PhpVal, var_options rt.PhpVal)  {
	mut var_options_mutated := var_options
	if rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) && rt.is_true(rt.identical(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WpOrg_Requests_Utility_InputValidator{}; return temp.is_string_or_stringable(arg_0) }(var_url.dup()), rt.new_bool(false))))) {
		rt.throw_exception(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal, arg_3 rt.PhpVal) rt.PhpVal { mut temp := Class_WpOrg_Requests_Exception_InvalidArgument{}; return temp.create(arg_0, arg_1, arg_2, arg_3) }(rt.new_int(1), rt.new_string('$url'), rt.new_string('string|Stringable|null'), rt.call_function('gettype', [var_url.dup()])))
	}
	if rt.is_true(rt.identical(rt.new_bool(var_headers.dup().is_array()), rt.new_bool(false))) {
		rt.throw_exception(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal, arg_3 rt.PhpVal) rt.PhpVal { mut temp := Class_WpOrg_Requests_Exception_InvalidArgument{}; return temp.create(arg_0, arg_1, arg_2, arg_3) }(rt.new_int(2), rt.new_string('$headers'), rt.new_string('array'), rt.call_function('gettype', [var_headers.dup()])))
	}
	if rt.is_true(rt.identical(rt.new_bool(var_data.dup().is_array()), rt.new_bool(false))) {
		rt.throw_exception(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal, arg_3 rt.PhpVal) rt.PhpVal { mut temp := Class_WpOrg_Requests_Exception_InvalidArgument{}; return temp.create(arg_0, arg_1, arg_2, arg_3) }(rt.new_int(3), rt.new_string('$data'), rt.new_string('array'), rt.call_function('gettype', [var_data.dup()])))
	}
	if rt.is_true(rt.identical(rt.new_bool(var_options_mutated.dup().is_array()), rt.new_bool(false))) {
		rt.throw_exception(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal, arg_3 rt.PhpVal) rt.PhpVal { mut temp := Class_WpOrg_Requests_Exception_InvalidArgument{}; return temp.create(arg_0, arg_1, arg_2, arg_3) }(rt.new_int(4), rt.new_string('$options'), rt.new_string('array'), rt.call_function('gettype', [var_options_mutated.dup()])))
	}
	this.url = var_url.dup()
	this.headers = var_headers.dup()
	this.data = var_data.dup()
	this.options = var_options_mutated.dup()
	if !rt.is_true(this.options.array_get('cookies')) {
		this.options.array_set('cookies', create_wporg_requests_cookie_jar())
	}
}

fn (mut this Class_WpOrg_Requests_Session) magic_get(var_name rt.PhpVal) rt.PhpVal {
	if this.options.array_isset(var_name) {
		return this.options.array_get(var_name)
	}
	return rt.new_null()
}

fn (mut this Class_WpOrg_Requests_Session) magic_set(var_name rt.PhpVal, var_value rt.PhpVal)  {
	this.options.array_set(var_name, var_value.dup())
}

fn (mut this Class_WpOrg_Requests_Session) magic_isset(var_name rt.PhpVal) rt.PhpVal {
	return rt.new_bool(this.options.array_isset(var_name))
}

fn (mut this Class_WpOrg_Requests_Session) magic_unset(var_name rt.PhpVal)  {
	this.options.array_unset(var_name)
}

fn (mut this Class_WpOrg_Requests_Session) get(var_url rt.PhpVal, var_headers rt.PhpVal, var_options rt.PhpVal) rt.PhpVal {
	mut var_options_mutated := var_options
	return this.request(var_url.dup(), var_headers.dup(), rt.new_null(), Class_WpOrg_Requests_Requests.get(), var_options_mutated.dup())
}

fn (mut this Class_WpOrg_Requests_Session) head(var_url rt.PhpVal, var_headers rt.PhpVal, var_options rt.PhpVal) rt.PhpVal {
	mut var_options_mutated := var_options
	return this.request(var_url.dup(), var_headers.dup(), rt.new_null(), Class_WpOrg_Requests_Requests.head(), var_options_mutated.dup())
}

fn (mut this Class_WpOrg_Requests_Session) delete(var_url rt.PhpVal, var_headers rt.PhpVal, var_options rt.PhpVal) rt.PhpVal {
	mut var_options_mutated := var_options
	return this.request(var_url.dup(), var_headers.dup(), rt.new_null(), Class_WpOrg_Requests_Requests.delete(), var_options_mutated.dup())
}

fn (mut this Class_WpOrg_Requests_Session) post(var_url rt.PhpVal, var_headers rt.PhpVal, var_data rt.PhpVal, var_options rt.PhpVal) rt.PhpVal {
	mut var_options_mutated := var_options
	return this.request(var_url.dup(), var_headers.dup(), var_data.dup(), Class_WpOrg_Requests_Requests.post(), var_options_mutated.dup())
}

fn (mut this Class_WpOrg_Requests_Session) put(var_url rt.PhpVal, var_headers rt.PhpVal, var_data rt.PhpVal, var_options rt.PhpVal) rt.PhpVal {
	mut var_options_mutated := var_options
	return this.request(var_url.dup(), var_headers.dup(), var_data.dup(), Class_WpOrg_Requests_Requests.put(), var_options_mutated.dup())
}

fn (mut this Class_WpOrg_Requests_Session) patch(var_url rt.PhpVal, var_headers rt.PhpVal, var_data rt.PhpVal, var_options rt.PhpVal) rt.PhpVal {
	mut var_options_mutated := var_options
	return this.request(var_url.dup(), var_headers.dup(), var_data.dup(), Class_WpOrg_Requests_Requests.patch(), var_options_mutated.dup())
}

fn (mut this Class_WpOrg_Requests_Session) request(var_url rt.PhpVal, var_headers rt.PhpVal, var_data rt.PhpVal, var_type rt.PhpVal, var_options rt.PhpVal) rt.PhpVal {
	mut var_options_mutated := var_options
	mut var_request := this.merge_request(rt.call_function('compact', [rt.new_string('url'), rt.new_string('headers'), rt.new_string('data'), rt.new_string('options')]), false)
	return fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal, arg_3 rt.PhpVal, arg_4 rt.PhpVal) rt.PhpVal { mut temp := Class_WpOrg_Requests_Requests{}; return temp.request(arg_0, arg_1, arg_2, arg_3, arg_4) }(var_request.array_get('url'), var_request.array_get('headers'), var_request.array_get('data'), var_type.dup(), var_request.array_get('options'))
}

fn (mut this Class_WpOrg_Requests_Session) request_multiple(var_requests rt.PhpVal, var_options rt.PhpVal) rt.PhpVal {
	mut var_requests_mutated := var_requests
	mut var_options_mutated := var_options
	if rt.is_true(rt.new_bool(rt.is_true(rt.identical(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WpOrg_Requests_Utility_InputValidator{}; return temp.has_array_access(arg_0) }(var_requests_mutated.dup()), rt.new_bool(false))) || rt.is_true(rt.identical(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WpOrg_Requests_Utility_InputValidator{}; return temp.is_iterable(arg_0) }(var_requests_mutated.dup()), rt.new_bool(false))))) {
		rt.throw_exception(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal, arg_3 rt.PhpVal) rt.PhpVal { mut temp := Class_WpOrg_Requests_Exception_InvalidArgument{}; return temp.create(arg_0, arg_1, arg_2, arg_3) }(rt.new_int(1), rt.new_string('$requests'), rt.new_string('array|ArrayAccess&Traversable'), rt.call_function('gettype', [var_requests_mutated.dup()])))
	}
	if rt.is_true(rt.identical(rt.new_bool(var_options_mutated.dup().is_array()), rt.new_bool(false))) {
		rt.throw_exception(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal, arg_3 rt.PhpVal) rt.PhpVal { mut temp := Class_WpOrg_Requests_Exception_InvalidArgument{}; return temp.create(arg_0, arg_1, arg_2, arg_3) }(rt.new_int(2), rt.new_string('$options'), rt.new_string('array'), rt.call_function('gettype', [var_options_mutated.dup()])))
	}
	{
		mut iter_1 := var_requests_mutated.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_request := item_1.val
			mut var_key := item_1.key
			var_requests_mutated.array_set(var_key, this.merge_request(var_request.dup(), false))
		}
	}
	var_options_mutated = rt.call_function('array_merge', [this.options, var_options_mutated.dup()])
	var_options_mutated.array_unset(rt.new_string('type'))
	return fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_WpOrg_Requests_Requests{}; return temp.request_multiple(arg_0, arg_1) }(var_requests_mutated.dup(), var_options_mutated.dup())
}

fn (mut this Class_WpOrg_Requests_Session) magic_wakeup()  {
	rt.throw_exception(rt.new_object('WpOrg_Requests_LogicException', []string{}, create_wporg_requests_logicexception(@STRUCT + ' should never be unserialized')))
}

fn (mut this Class_WpOrg_Requests_Session) merge_request(var_request rt.PhpVal, merge_options bool) rt.PhpVal {
	mut var_request_mutated := var_request
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		var_request_mutated.array_set('url', fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_WpOrg_Requests_Iri{}; return temp.absolutize(arg_0, arg_1) }(this.url, var_request_mutated.array_get('url')))
		var_request_mutated.array_set('url', rt.get_property(var_request_mutated.array_get('url'), 'uri'))
	}
	if !rt.is_true(var_request_mutated.array_get('headers')) {
		var_request_mutated.array_set('headers', rt.new_array())
	}
	var_request_mutated.array_set('headers', rt.call_function('array_merge', [this.headers, var_request_mutated.array_get('headers')]))
	if !rt.is_true(var_request_mutated.array_get('data')) {
		if rt.is_true(rt.new_bool(this.data.is_array())) {
			var_request_mutated.array_set('data', this.data)
		}
	} else if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_request_mutated.array_get('data').is_array())) && rt.is_true(rt.new_bool(this.data.is_array())))) {
		var_request_mutated.array_set('data', rt.call_function('array_merge', [this.data, var_request_mutated.array_get('data')]))
	}
	if rt.is_true(rt.identical(rt.new_bool(merge_options), rt.new_bool(true))) {
		var_request_mutated.array_set('options', rt.call_function('array_merge', [this.options, var_request_mutated.array_get('options')]))
		var_request_mutated.array_get('options').array_unset(rt.new_string('type'))
	}
	return var_request_mutated.dup()
}

struct Class_WpOrg_Requests_Utility_InputValidator {
	rt.PhpObjectBase
}

struct Class_WpOrg_Requests_Exception_InvalidArgument {
	rt.PhpObjectBase
}

struct Class_WpOrg_Requests_Cookie_Jar {
	rt.PhpObjectBase
}

struct Class_WpOrg_Requests_Requests {
	rt.PhpObjectBase
}

struct Class_WpOrg_Requests_LogicException {
	rt.PhpObjectBase
}

struct Class_WpOrg_Requests_Iri {
	rt.PhpObjectBase
}

fn create_wporg_requests_session(arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal, arg_3 rt.PhpVal) &Class_WpOrg_Requests_Session {
	mut obj := &Class_WpOrg_Requests_Session{
		PhpObjectBase: rt.PhpObjectBase{}
		url: rt.new_null()
		headers: rt.new_array()
		data: rt.new_array()
		options: rt.new_array()
	}
	obj.construct(arg_0, arg_1, arg_2, arg_3)
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

fn create_wporg_requests_cookie_jar() &Class_WpOrg_Requests_Cookie_Jar {
	mut obj := &Class_WpOrg_Requests_Cookie_Jar{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wporg_requests_requests() &Class_WpOrg_Requests_Requests {
	mut obj := &Class_WpOrg_Requests_Requests{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wporg_requests_logicexception() &Class_WpOrg_Requests_LogicException {
	mut obj := &Class_WpOrg_Requests_LogicException{
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

fn (mut this Class_WpOrg_Requests_Session) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			this.construct(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
			return rt.new_null()
		}
		'__get' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.magic_get(dispatch_arg_0)
		}
		'__set' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.magic_set(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'__isset' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.magic_isset(dispatch_arg_0)
		}
		'__unset' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.magic_unset(dispatch_arg_0)
			return rt.new_null()
		}
		'get' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.get(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'head' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.head(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'delete' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.delete(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'post' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			return this.post(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
		}
		'put' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			return this.put(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
		}
		'patch' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			return this.patch(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
		}
		'request' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			dispatch_arg_4 := if args.len > 4 { args[4] } else { rt.new_null() }
			return this.request(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3, dispatch_arg_4)
		}
		'request_multiple' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.request_multiple(dispatch_arg_0, dispatch_arg_1)
		}
		'__wakeup' {
			this.magic_wakeup()
			return rt.new_null()
		}
		'merge_request' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			return this.merge_request(dispatch_arg_0, dispatch_arg_1)
		}
		else { return none }
	}
}

fn (this &Class_WpOrg_Requests_Session) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'url' { return this.url }
		'headers' { return this.headers }
		'data' { return this.data }
		'options' { return this.options }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WpOrg_Requests_Session) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'url' { this.url = val; return true }
		'headers' { this.headers = val; return true }
		'data' { this.data = val; return true }
		'options' { this.options = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
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


fn (mut this Class_WpOrg_Requests_Cookie_Jar) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WpOrg_Requests_Cookie_Jar) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WpOrg_Requests_Cookie_Jar) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WpOrg_Requests_Requests) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WpOrg_Requests_Requests) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WpOrg_Requests_Requests) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WpOrg_Requests_LogicException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WpOrg_Requests_LogicException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WpOrg_Requests_LogicException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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




pub fn init_wp_includes_requests_src_session_php() {
}
