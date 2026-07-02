import rt

struct Class_WP_Http_Cookie {
	rt.PhpObjectBase
pub mut:
	name      rt.PhpVal = rt.new_null()
	value     rt.PhpVal = rt.new_null()
	expires   rt.PhpVal = rt.new_null()
	path      rt.PhpVal = rt.new_null()
	domain    rt.PhpVal = rt.new_null()
	port      rt.PhpVal = rt.new_null()
	host_only rt.PhpVal = rt.new_null()
}

fn (mut this Class_WP_Http_Cookie) construct(var_data rt.PhpVal, requested_url string) {
	if var_requested_url.len > 0 && var_requested_url != '0' {
		mut var_parsed_url := rt.call_function('parse_url', [
			rt.new_string(requested_url),
		])
	}
	if var_parsed_url.array_isset(rt.new_string('host')) {
		this.domain = var_parsed_url.array_get(rt.new_string('host'))
	}
	this.path = if !(var_parsed_url.array_get(rt.new_string('path'))).is_null() {
		var_parsed_url.array_get(rt.new_string('path'))
	} else {
		rt.new_string('/')
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('str_ends_with', [this.path,
		rt.new_string('/')])))))
	{
		this.path = (rt.call_function('dirname', [this.path])).str() + '/'
	}
	if rt.is_true(rt.new_bool(var_data.clone().is_string())) {
		mut var_pairs := rt.call_function('explode', [rt.new_string(';'),
			var_data.clone()])
		mut var_name := rt.new_string(rt.call_function('substr', [
			var_pairs.array_get(rt.new_int(0)),
			rt.new_int(0),
			rt.call_function('strpos', [var_pairs.array_get(rt.new_int(0)),
				rt.new_string('=')]),
		]).to_string().trim_space())
		mut var_value := rt.call_function('substr', [var_pairs.array_get(rt.new_int(0)),
			rt.add(rt.call_function('strpos', [var_pairs.array_get(rt.new_int(0)),
				rt.new_string('=')]), rt.new_int(1))])
		this.name = var_name.clone()
		this.value = rt.call_function('urldecode', [var_value.clone()])
		rt.call_function('array_shift', [var_pairs.clone()])
		mut iter_1 := var_pairs.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_pair := item_1.val
			var_pair = rt.new_string(var_pair.clone().to_string().trim_right(' \t\n\r'))
			if !rt.is_true(var_pair) {
				continue
			}
			mut list_tmp_1 := if rt.is_true(rt.call_function('strpos', [
				var_pair.clone(), rt.new_string('=')]))
			{ rt.call_function('explode', [rt.new_string('='),
					var_pair.clone()]) } else { rt.create_array([
					rt.ArrayItem{ key: none, val: var_pair },
					rt.ArrayItem{ key: none, val: '' },
				]) }
			mut var_key := list_tmp_1.array_get(0)
			mut var_val := list_tmp_1.array_get(1)
			var_key = rt.new_string(var_key.clone().to_string().trim_space().to_lower())
			if rt.is_true(rt.identical(rt.new_string('expires'), var_key)) {
				var_val = rt.call_function('strtotime', [var_val.clone()])
			}
			this.dispatch_set_prop('{"nodeType":"Expr_Variable","line":149,"name":"key"}',
				var_val.clone())
		}
	} else {
		if !(var_data.array_isset(rt.new_string('name'))) {
			return
		}
		mut iter_2 := rt.create_array([rt.ArrayItem{ key: none, val: 'name' },
			rt.ArrayItem{ key: none, val: 'value' }, rt.ArrayItem{ key: none, val: 'path' },
			rt.ArrayItem{ key: none, val: 'domain' }, rt.ArrayItem{ key: none, val: 'port' },
			rt.ArrayItem{ key: none, val: 'host_only' }]).iterator()
		for {
			item_2 := iter_2.next() or { break }
			mut var_field := item_2.val
			if var_data.array_isset(var_field) {
				this.dispatch_set_prop('{"nodeType":"Expr_Variable","line":159,"name":"field"}',
					var_data.array_get(var_field))
			}
		}
		if var_data.array_isset(rt.new_string('expires')) {
			this.expires = if var_data.array_get(rt.new_string('expires')).is_long() { var_data.array_get(rt.new_string('expires')) } else { rt.call_function('strtotime', [
					var_data.array_get(rt.new_string('expires')),
				]) }
		} else {
			this.expires = rt.new_null()
		}
	}
}

fn (mut this Class_WP_Http_Cookie) test(var_url rt.PhpVal) bool {
	mut var_url_mutated := var_url
	if rt.is_true(rt.new_bool(this.name.is_null())) {
		return false
	}
	if !(this.expires).is_null()
		&& rt.is_true(rt.greater(rt.call_function('time', []rt.PhpVal{}), this.expires)) {
		return false
	}
	var_url_mutated = rt.call_function('parse_url', [var_url_mutated.clone()])
	var_url_mutated.array_set('port', if !(var_url_mutated.array_get(rt.new_string('port'))).is_null() {
		var_url_mutated.array_get(rt.new_string('port'))
	} else {
		if rt.is_true(rt.identical(rt.new_string('https'),
			var_url_mutated.array_get(rt.new_string('scheme'))))
		{
			443
		} else {
			80
		}
	})
	var_url_mutated.array_set('path', if !(var_url_mutated.array_get(rt.new_string('path'))).is_null() {
		var_url_mutated.array_get(rt.new_string('path'))
	} else {
		rt.new_string('/')
	})
	mut var_path := if !(this.path).is_null() { this.path } else { rt.new_string('/') }
	mut var_port := if !(this.port).is_null() { this.port } else { rt.new_null() }
	mut var_domain := rt.new_string((if !(this.domain).is_null() {
		this.domain.to_string().to_lower()
	} else {
		var_url_mutated.array_get(rt.new_string('host')).to_string().to_lower()
	}).str())
	if rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('stripos', [
		var_domain.clone(),
		rt.new_string('.'),
	])))
	{
		var_domain = rt.concat(var_domain, rt.new_string('.local'))
	}
	var_domain = if rt.is_true(rt.call_function('str_starts_with', [
		var_domain.clone(), rt.new_string('.')]))
	{ rt.call_function('substr', [var_domain.clone(), rt.new_int(1)]) } else { var_domain }
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('str_ends_with', [
		var_url_mutated.array_get(rt.new_string('host')),
		var_domain.clone(),
	])))))
	{
		return false
	}
	if !(!rt.is_true(var_port))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_url_mutated.array_get(rt.new_string('port')), rt.call_function('array_map', [rt.new_string('intval'), rt.call_function('explode', [rt.new_string(','), var_port.clone()])]), rt.new_bool(true)]))))) {
		return false
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('str_starts_with', [
		var_url_mutated.array_get(rt.new_string('path')),
		var_path.clone(),
	])))))
	{
		return false
	}
	return true
}

fn (mut this Class_WP_Http_Cookie) getheadervalue() string {
	if !(!(this.name).is_null()) || !(!(this.value).is_null()) {
		return ''
	}
	return (this.name).str() + '=' +(rt.call_function('apply_filters', [rt.new_string('wp_http_cookie_value'), this.value, this.name])).str()
}

fn (mut this Class_WP_Http_Cookie) getfullheader() string {
	return 'Cookie: ' + this.getheadervalue()
}

fn (mut this Class_WP_Http_Cookie) get_attributes() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: 'expires', val: this.expires },
		rt.ArrayItem{ key: 'path', val: this.path }, rt.ArrayItem{ key: 'domain', val: this.domain }])
}

fn create_wp_http_cookie(requested_url string, arg_1 rt.PhpVal) &Class_WP_Http_Cookie {
	mut obj := &Class_WP_Http_Cookie{
		PhpObjectBase: rt.PhpObjectBase{}
		name:          rt.new_null()
		value:         rt.new_null()
		expires:       rt.new_null()
		path:          rt.new_null()
		domain:        rt.new_null()
		port:          rt.new_null()
		host_only:     rt.new_null()
	}
	obj.construct(requested_url, arg_1)
	return obj
}

fn (mut this Class_WP_Http_Cookie) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			this.construct(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'test' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.test(dispatch_arg_0))
		}
		'getHeaderValue' {
			return rt.new_string(this.getheadervalue())
		}
		'getFullHeader' {
			return rt.new_string(this.getfullheader())
		}
		'get_attributes' {
			return this.get_attributes()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WP_Http_Cookie) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'name' { return this.name }
		'value' { return this.value }
		'expires' { return this.expires }
		'path' { return this.path }
		'domain' { return this.domain }
		'port' { return this.port }
		'host_only' { return this.host_only }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_Http_Cookie) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'name' {
			this.name = val
			return true
		}
		'value' {
			this.value = val
			return true
		}
		'expires' {
			this.expires = val
			return true
		}
		'path' {
			this.path = val
			return true
		}
		'domain' {
			this.domain = val
			return true
		}
		'port' {
			this.port = val
			return true
		}
		'host_only' {
			this.host_only = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn main() {
	defer {
		rt.shutdown()
	}
}
