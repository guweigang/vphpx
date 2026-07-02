import rt

pub fn Class_WordPress_AiClientDependencies_Nyholm_Psr7_Uri.schemes() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: 'http', val: 80 },
		rt.ArrayItem{ key: 'https', val: 443 }])
}

pub fn Class_WordPress_AiClientDependencies_Nyholm_Psr7_Uri.char_unreserved() string {
	return 'a-zA-Z0-9_\\-\\.~'
}

pub fn Class_WordPress_AiClientDependencies_Nyholm_Psr7_Uri.char_sub_delims() string {
	return "!\\$&'\\(\\)\\*\\+,;="
}

pub fn Class_WordPress_AiClientDependencies_Nyholm_Psr7_Uri.char_gen_delims() string {
	return ':\\/\\?#\\[\\]@'
}

struct Class_WordPress_AiClientDependencies_Nyholm_Psr7_Uri {
	rt.PhpObjectBase
pub mut:
	scheme   rt.PhpVal = rt.new_string('')
	userInfo rt.PhpVal = rt.new_string('')
	host     rt.PhpVal = rt.new_string('')
	port     rt.PhpVal = rt.new_null()
	path     rt.PhpVal = rt.new_string('')
	query    rt.PhpVal = rt.new_string('')
	fragment rt.PhpVal = rt.new_string('')
}

fn (mut this Class_WordPress_AiClientDependencies_Nyholm_Psr7_Uri) construct(uri string) {
	mut uri_mutated := uri
	if rt.is_true(rt.new_bool('' != uri_mutated)) {
		mut var_parts := rt.call_function('parse_url', [rt.new_string(uri_mutated).clone()])
		if rt.is_true(rt.identical(rt.new_bool(false), var_parts)) {
			rt.throw_exception(rt.new_object('WordPress_AiClientDependencies_Nyholm_Psr7_InvalidArgumentException',
				[]string{}, create_wordpress_aiclientdependencies_nyholm_psr7_invalidargumentexception(rt.call_function('sprintf', [
				rt.new_string('Unable to parse URI: "%s"'),
				rt.new_string(uri_mutated).clone(),
			]))))
		}
		this.scheme = if var_parts.array_isset(rt.new_string('scheme')) { rt.call_function('strtr', [
				var_parts.array_get(rt.new_string('scheme')),
				rt.new_string('ABCDEFGHIJKLMNOPQRSTUVWXYZ'),
				rt.new_string('abcdefghijklmnopqrstuvwxyz'),
			]) } else { rt.new_string('') }
		this.userInfo = if !(var_parts.array_get(rt.new_string('user'))).is_null() {
			var_parts.array_get(rt.new_string('user'))
		} else {
			rt.new_string('')
		}
		this.host = if var_parts.array_isset(rt.new_string('host')) { rt.call_function('strtr', [
				var_parts.array_get(rt.new_string('host')),
				rt.new_string('ABCDEFGHIJKLMNOPQRSTUVWXYZ'),
				rt.new_string('abcdefghijklmnopqrstuvwxyz'),
			]) } else { rt.new_string('') }
		this.port = if var_parts.array_isset(rt.new_string('port')) {
			this.filterport(var_parts.array_get(rt.new_string('port')))
		} else {
			rt.new_null()
		}
		this.path = if var_parts.array_isset(rt.new_string('path')) {
			this.filterpath(var_parts.array_get(rt.new_string('path')))
		} else {
			''
		}
		this.query = if var_parts.array_isset(rt.new_string('query')) {
			this.filterqueryandfragment(var_parts.array_get(rt.new_string('query')))
		} else {
			''
		}
		this.fragment = if var_parts.array_isset(rt.new_string('fragment')) {
			this.filterqueryandfragment(var_parts.array_get(rt.new_string('fragment')))
		} else {
			''
		}
		if var_parts.array_isset(rt.new_string('pass')) {
			this.userInfo = rt.concat(this.userInfo, rt.new_string(':' +
				(var_parts.array_get(rt.new_string('pass'))).str()))
		}
	}
}

fn (mut this Class_WordPress_AiClientDependencies_Nyholm_Psr7_Uri) magic_tostring() string {
	return (Class_WordPress_AiClientDependencies_Nyholm_Psr7_Uri.createuristring((this.scheme).str(),
		this.getauthority(), (this.path).str(), (this.query).str(), (this.fragment).str())).str()
}

fn (mut this Class_WordPress_AiClientDependencies_Nyholm_Psr7_Uri) getscheme() string {
	return (this.scheme).str()
}

fn (mut this Class_WordPress_AiClientDependencies_Nyholm_Psr7_Uri) getauthority() string {
	if rt.is_true(rt.identical(rt.new_string(''), this.host)) {
		return ''
	}
	mut var_authority := this.host
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), this.userInfo)))) {
		var_authority = rt.new_string((this.userInfo).str() + '@' + var_authority.str())
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), this.port)))) {
		var_authority = rt.concat(var_authority, rt.new_string(':' + (this.port).str()))
	}
	return var_authority.str()
}

fn (mut this Class_WordPress_AiClientDependencies_Nyholm_Psr7_Uri) getuserinfo() string {
	return (this.userInfo).str()
}

fn (mut this Class_WordPress_AiClientDependencies_Nyholm_Psr7_Uri) gethost() string {
	return (this.host).str()
}

fn (mut this Class_WordPress_AiClientDependencies_Nyholm_Psr7_Uri) getport() i64 {
	return (this.port).to_i64()
}

fn (mut this Class_WordPress_AiClientDependencies_Nyholm_Psr7_Uri) getpath() string {
	mut var_path := this.path
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), var_path))))
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('/'), var_path.array_get(rt.new_int(0)))))) {
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), this.host)))) {
			var_path = rt.new_string('/' + var_path.str())
		}
	} else if var_path.array_isset(rt.new_int(1))
		&& rt.is_true(rt.identical(rt.new_string('/'), var_path.array_get(rt.new_int(1)))) {
		var_path = rt.new_string('/' + var_path.clone().to_string().trim_left(' \t\n\r'))
	}
	return var_path.str()
}

fn (mut this Class_WordPress_AiClientDependencies_Nyholm_Psr7_Uri) getquery() string {
	return (this.query).str()
}

fn (mut this Class_WordPress_AiClientDependencies_Nyholm_Psr7_Uri) getfragment() string {
	return (this.fragment).str()
}

fn (mut this Class_WordPress_AiClientDependencies_Nyholm_Psr7_Uri) withscheme(var_scheme rt.PhpVal) rt.PhpVal {
	if !(var_scheme.clone().is_string()) {
		rt.throw_exception(rt.new_object('WordPress_AiClientDependencies_Nyholm_Psr7_InvalidArgumentException',
			[]string{},
			create_wordpress_aiclientdependencies_nyholm_psr7_invalidargumentexception(rt.new_string('Scheme must be a string'))))
	}
	var_scheme = rt.call_function('strtr', [var_scheme.clone(),
		rt.new_string('ABCDEFGHIJKLMNOPQRSTUVWXYZ'), rt.new_string('abcdefghijklmnopqrstuvwxyz')])
	if rt.is_true(rt.identical(this.scheme, var_scheme)) {
		return rt.new_object('WordPress_AiClientDependencies_Nyholm_Psr7_Uri', []string{}, this)
	}
	mut var_new := rt.new_object('WordPress_AiClientDependencies_Nyholm_Psr7_Uri', [
		'UriInterface',
	], &this).dup()
	rt.set_property(var_new, 'scheme', var_scheme.clone())
	rt.set_property(var_new, 'port', rt.call_method(var_new, 'filterPort', [
		rt.get_property(var_new, 'port'),
	]))
	return var_new.clone()
}

fn (mut this Class_WordPress_AiClientDependencies_Nyholm_Psr7_Uri) withuserinfo(var_user rt.PhpVal, var_password rt.PhpVal) rt.PhpVal {
	if !(var_user.clone().is_string()) {
		rt.throw_exception(rt.new_object('WordPress_AiClientDependencies_Nyholm_Psr7_InvalidArgumentException',
			[]string{},
			create_wordpress_aiclientdependencies_nyholm_psr7_invalidargumentexception(rt.new_string('User must be a string'))))
	}
	mut var_info := rt.call_function('preg_replace_callback', [
		rt.new_string('/[' +
			(Class_WordPress_AiClientDependencies_Nyholm_Psr7_WordPress_AiClientDependencies_Nyholm_Psr7_Uri.char_gen_delims()).str() + (Class_WordPress_AiClientDependencies_Nyholm_Psr7_WordPress_AiClientDependencies_Nyholm_Psr7_Uri.char_sub_delims()).str() + ']++/'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'rawurlencodeMatchZero' }]),
		var_user.clone(),
	])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_password))))
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), var_password)))) {
		if !(var_password.clone().is_string()) {
			rt.throw_exception(rt.new_object('WordPress_AiClientDependencies_Nyholm_Psr7_InvalidArgumentException',
				[]string{},
				create_wordpress_aiclientdependencies_nyholm_psr7_invalidargumentexception(rt.new_string('Password must be a string'))))
		}
		var_info = rt.concat(var_info, rt.new_string(':' +
			(rt.call_function('preg_replace_callback', [rt.new_string('/[' +
			(Class_WordPress_AiClientDependencies_Nyholm_Psr7_WordPress_AiClientDependencies_Nyholm_Psr7_Uri.char_gen_delims()).str() +
			(Class_WordPress_AiClientDependencies_Nyholm_Psr7_WordPress_AiClientDependencies_Nyholm_Psr7_Uri.char_sub_delims()).str() +
			']++/'), rt.create_array([rt.ArrayItem{
			key: none
			val: @STRUCT
		}, rt.ArrayItem{ key: none, val: 'rawurlencodeMatchZero' }]), var_password.clone()])).str()))
	}
	if rt.is_true(rt.identical(this.userInfo, var_info)) {
		return rt.new_object('WordPress_AiClientDependencies_Nyholm_Psr7_Uri', []string{}, this)
	}
	mut var_new := rt.new_object('WordPress_AiClientDependencies_Nyholm_Psr7_Uri', [
		'UriInterface',
	], &this).dup()
	rt.set_property(var_new, 'userInfo', var_info.clone())
	return var_new.clone()
}

fn (mut this Class_WordPress_AiClientDependencies_Nyholm_Psr7_Uri) withhost(var_host rt.PhpVal) rt.PhpVal {
	if !(var_host.clone().is_string()) {
		rt.throw_exception(rt.new_object('WordPress_AiClientDependencies_Nyholm_Psr7_InvalidArgumentException',
			[]string{},
			create_wordpress_aiclientdependencies_nyholm_psr7_invalidargumentexception(rt.new_string('Host must be a string'))))
	}
	var_host = rt.call_function('strtr', [var_host.clone(), rt.new_string('ABCDEFGHIJKLMNOPQRSTUVWXYZ'),
		rt.new_string('abcdefghijklmnopqrstuvwxyz')])
	if rt.is_true(rt.identical(this.host, var_host)) {
		return rt.new_object('WordPress_AiClientDependencies_Nyholm_Psr7_Uri', []string{}, this)
	}
	mut var_new := rt.new_object('WordPress_AiClientDependencies_Nyholm_Psr7_Uri', [
		'UriInterface',
	], &this).dup()
	rt.set_property(var_new, 'host', var_host.clone())
	return var_new.clone()
}

fn (mut this Class_WordPress_AiClientDependencies_Nyholm_Psr7_Uri) withport(var_port rt.PhpVal) rt.PhpVal {
	mut var_port_mutated := var_port
	var_port_mutated = rt.new_int(this.filterport(var_port_mutated.clone()))
	if rt.is_true(rt.identical(this.port, var_port_mutated)) {
		return rt.new_object('WordPress_AiClientDependencies_Nyholm_Psr7_Uri', []string{}, this)
	}
	mut var_new := rt.new_object('WordPress_AiClientDependencies_Nyholm_Psr7_Uri', [
		'UriInterface',
	], &this).dup()
	rt.set_property(var_new, 'port', var_port_mutated.clone())
	return var_new.clone()
}

fn (mut this Class_WordPress_AiClientDependencies_Nyholm_Psr7_Uri) withpath(var_path rt.PhpVal) rt.PhpVal {
	mut var_path_mutated := var_path
	var_path_mutated = rt.new_string(this.filterpath(var_path_mutated.clone()))
	if rt.is_true(rt.identical(this.path, var_path_mutated)) {
		return rt.new_object('WordPress_AiClientDependencies_Nyholm_Psr7_Uri', []string{}, this)
	}
	mut var_new := rt.new_object('WordPress_AiClientDependencies_Nyholm_Psr7_Uri', [
		'UriInterface',
	], &this).dup()
	rt.set_property(var_new, 'path', var_path_mutated.clone())
	return var_new.clone()
}

fn (mut this Class_WordPress_AiClientDependencies_Nyholm_Psr7_Uri) withquery(var_query rt.PhpVal) rt.PhpVal {
	var_query = rt.new_string(this.filterqueryandfragment(var_query.clone()))
	if rt.is_true(rt.identical(this.query, var_query)) {
		return rt.new_object('WordPress_AiClientDependencies_Nyholm_Psr7_Uri', []string{}, this)
	}
	mut var_new := rt.new_object('WordPress_AiClientDependencies_Nyholm_Psr7_Uri', [
		'UriInterface',
	], &this).dup()
	rt.set_property(var_new, 'query', var_query.clone())
	return var_new.clone()
}

fn (mut this Class_WordPress_AiClientDependencies_Nyholm_Psr7_Uri) withfragment(var_fragment rt.PhpVal) rt.PhpVal {
	var_fragment = rt.new_string(this.filterqueryandfragment(var_fragment.clone()))
	if rt.is_true(rt.identical(this.fragment, var_fragment)) {
		return rt.new_object('WordPress_AiClientDependencies_Nyholm_Psr7_Uri', []string{}, this)
	}
	mut var_new := rt.new_object('WordPress_AiClientDependencies_Nyholm_Psr7_Uri', [
		'UriInterface',
	], &this).dup()
	rt.set_property(var_new, 'fragment', var_fragment.clone())
	return var_new.clone()
}

fn Class_WordPress_AiClientDependencies_Nyholm_Psr7_Uri.createuristring(scheme string, authority string, path string, query string, fragment string) string {
	mut authority_mutated := authority
	mut path_mutated := path
	mut var_uri := rt.new_string('')
	if rt.is_true(rt.new_bool('' != scheme)) {
		var_uri = rt.concat(var_uri, rt.new_string(scheme + ':'))
	}
	if rt.is_true(rt.new_bool('' != authority_mutated)) {
		var_uri = rt.concat(var_uri, rt.new_string('//' + authority_mutated))
	}
	if rt.is_true(rt.new_bool('' != path_mutated)) {
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('/'),
			rt.new_string(path_mutated).array_get(rt.new_int(0))))))
		{
			if rt.is_true(rt.new_bool('' != authority_mutated)) {
				path_mutated = '/' + path_mutated
			}
		} else if rt.new_string(path_mutated).array_isset(rt.new_int(1))
			&& rt.is_true(rt.identical(rt.new_string('/'), rt.new_string(path_mutated).array_get(rt.new_int(1)))) {
			if rt.is_true(rt.identical(rt.new_string(''), rt.new_string(authority_mutated))) {
				path_mutated = '/' + path_mutated.trim_left(' \t\n\r')
			}
		}
		var_uri = rt.concat(var_uri, rt.new_string(path_mutated))
	}
	if rt.is_true(rt.new_bool('' != query)) {
		var_uri = rt.concat(var_uri, rt.new_string('?' + query))
	}
	if rt.is_true(rt.new_bool('' != fragment)) {
		var_uri = rt.concat(var_uri, rt.new_string('#' + fragment))
	}
	return var_uri.str()
}

fn Class_WordPress_AiClientDependencies_Nyholm_Psr7_Uri.isnonstandardport(scheme string, port i64) bool {
	mut port_mutated := port
	return
		!(Class_WordPress_AiClientDependencies_Nyholm_Psr7_WordPress_AiClientDependencies_Nyholm_Psr7_Uri.schemes().array_isset(rt.new_string(scheme)))
		|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int(port_mutated), Class_WordPress_AiClientDependencies_Nyholm_Psr7_WordPress_AiClientDependencies_Nyholm_Psr7_Uri.schemes().array_get(rt.new_string(scheme))))))
}

fn (mut this Class_WordPress_AiClientDependencies_Nyholm_Psr7_Uri) filterport(var_port rt.PhpVal) i64 {
	mut var_port_mutated := var_port
	if rt.is_true(rt.identical(rt.new_null(), var_port_mutated)) {
		return (rt.new_null()).to_i64()
	}
	var_port_mutated = rt.new_int(var_port_mutated.to_i64())
	if rt.is_true(rt.greater(rt.new_int(0), var_port_mutated))
		|| rt.is_true(rt.less(rt.new_int(65535), var_port_mutated)) {
		rt.throw_exception(rt.new_object('WordPress_AiClientDependencies_Nyholm_Psr7_InvalidArgumentException',
			[]string{}, create_wordpress_aiclientdependencies_nyholm_psr7_invalidargumentexception(rt.call_function('sprintf', [
			rt.new_string('Invalid port: %d. Must be between 0 and 65535'),
			var_port_mutated.clone(),
		]))))
	}
	return (if rt.is_true(Class_WordPress_AiClientDependencies_Nyholm_Psr7_Uri.isnonstandardport((this.scheme).str(),
		var_port_mutated.to_i64()))
	{
		var_port_mutated
	} else {
		rt.new_null()
	}).to_i64()
}

fn (mut this Class_WordPress_AiClientDependencies_Nyholm_Psr7_Uri) filterpath(var_path rt.PhpVal) string {
	mut var_path_mutated := var_path
	if !(var_path_mutated.clone().is_string()) {
		rt.throw_exception(rt.new_object('WordPress_AiClientDependencies_Nyholm_Psr7_InvalidArgumentException',
			[]string{},
			create_wordpress_aiclientdependencies_nyholm_psr7_invalidargumentexception(rt.new_string('Path must be a string'))))
	}
	return (rt.call_function('preg_replace_callback', [
		rt.new_string('/(?:[^' +
			(Class_WordPress_AiClientDependencies_Nyholm_Psr7_WordPress_AiClientDependencies_Nyholm_Psr7_Uri.char_unreserved()).str() + (Class_WordPress_AiClientDependencies_Nyholm_Psr7_WordPress_AiClientDependencies_Nyholm_Psr7_Uri.char_sub_delims()).str() + '%:@\\/]++|%(?![A-Fa-f0-9]{2}))/'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'rawurlencodeMatchZero' }]),
		var_path_mutated.clone(),
	])).str()
}

fn (mut this Class_WordPress_AiClientDependencies_Nyholm_Psr7_Uri) filterqueryandfragment(var_str rt.PhpVal) string {
	if !(var_str.clone().is_string()) {
		rt.throw_exception(rt.new_object('WordPress_AiClientDependencies_Nyholm_Psr7_InvalidArgumentException',
			[]string{},
			create_wordpress_aiclientdependencies_nyholm_psr7_invalidargumentexception(rt.new_string('Query and fragment must be a string'))))
	}
	return (rt.call_function('preg_replace_callback', [
		rt.new_string('/(?:[^' +
			(Class_WordPress_AiClientDependencies_Nyholm_Psr7_WordPress_AiClientDependencies_Nyholm_Psr7_Uri.char_unreserved()).str() + (Class_WordPress_AiClientDependencies_Nyholm_Psr7_WordPress_AiClientDependencies_Nyholm_Psr7_Uri.char_sub_delims()).str() + '%:@\\/\\?]++|%(?![A-Fa-f0-9]{2}))/'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'rawurlencodeMatchZero' }]),
		var_str.clone(),
	])).str()
}

fn Class_WordPress_AiClientDependencies_Nyholm_Psr7_Uri.rawurlencodematchzero(mut var_match Class_WordPress_AiClientDependencies_Nyholm_Psr7_array) string {
	return (rt.call_function('rawurlencode', [var_match.array_get(rt.new_int(0))])).str()
}

struct Class_WordPress_AiClientDependencies_Nyholm_Psr7_InvalidArgumentException {
	rt.PhpObjectBase
}

fn create_wordpress_aiclientdependencies_nyholm_psr7_uri(uri string) &Class_WordPress_AiClientDependencies_Nyholm_Psr7_Uri {
	mut obj := &Class_WordPress_AiClientDependencies_Nyholm_Psr7_Uri{
		PhpObjectBase: rt.PhpObjectBase{}
		scheme:        rt.new_string('')
		userInfo:      rt.new_string('')
		host:          rt.new_string('')
		port:          rt.new_null()
		path:          rt.new_string('')
		query:         rt.new_string('')
		fragment:      rt.new_string('')
	}
	obj.construct(uri)
	return obj
}

fn create_wordpress_aiclientdependencies_nyholm_psr7_invalidargumentexception(_args ...rt.PhpVal) &Class_WordPress_AiClientDependencies_Nyholm_Psr7_InvalidArgumentException {
	mut obj := &Class_WordPress_AiClientDependencies_Nyholm_Psr7_InvalidArgumentException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WordPress_AiClientDependencies_Nyholm_Psr7_Uri) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'__toString' {
			return rt.new_string(this.magic_tostring())
		}
		'getScheme' {
			return rt.new_string(this.getscheme())
		}
		'getAuthority' {
			return rt.new_string(this.getauthority())
		}
		'getUserInfo' {
			return rt.new_string(this.getuserinfo())
		}
		'getHost' {
			return rt.new_string(this.gethost())
		}
		'getPort' {
			return rt.new_int(this.getport())
		}
		'getPath' {
			return rt.new_string(this.getpath())
		}
		'getQuery' {
			return rt.new_string(this.getquery())
		}
		'getFragment' {
			return rt.new_string(this.getfragment())
		}
		'withScheme' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.withscheme(dispatch_arg_0)
		}
		'withUserInfo' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.withuserinfo(dispatch_arg_0, dispatch_arg_1)
		}
		'withHost' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.withhost(dispatch_arg_0)
		}
		'withPort' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.withport(dispatch_arg_0)
		}
		'withPath' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.withpath(dispatch_arg_0)
		}
		'withQuery' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.withquery(dispatch_arg_0)
		}
		'withFragment' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.withfragment(dispatch_arg_0)
		}
		'createUriString' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).str()
			dispatch_arg_4 := (if args.len > 4 { args[4] } else { rt.new_null() }).str()
			return rt.new_string(Class_WordPress_AiClientDependencies_Nyholm_Psr7_Uri.createuristring(dispatch_arg_0,
				dispatch_arg_1, dispatch_arg_2, dispatch_arg_3, dispatch_arg_4))
		}
		'isNonStandardPort' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			return rt.new_bool(Class_WordPress_AiClientDependencies_Nyholm_Psr7_Uri.isnonstandardport(dispatch_arg_0,
				dispatch_arg_1))
		}
		'filterPort' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_int(this.filterport(dispatch_arg_0))
		}
		'filterPath' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.filterpath(dispatch_arg_0))
		}
		'filterQueryAndFragment' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.filterqueryandfragment(dispatch_arg_0))
		}
		'rawurlencodeMatchZero' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WordPress_AiClientDependencies_Nyholm_Psr7_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return rt.new_string(Class_WordPress_AiClientDependencies_Nyholm_Psr7_Uri.rawurlencodematchzero(mut dispatch_arg_0))
		}
		else {
			return none
		}
	}
}

fn (this &Class_WordPress_AiClientDependencies_Nyholm_Psr7_Uri) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'scheme' { return this.scheme }
		'userInfo' { return this.userInfo }
		'host' { return this.host }
		'port' { return this.port }
		'path' { return this.path }
		'query' { return this.query }
		'fragment' { return this.fragment }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WordPress_AiClientDependencies_Nyholm_Psr7_Uri) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'scheme' {
			this.scheme = val
			return true
		}
		'userInfo' {
			this.userInfo = val
			return true
		}
		'host' {
			this.host = val
			return true
		}
		'port' {
			this.port = val
			return true
		}
		'path' {
			this.path = val
			return true
		}
		'query' {
			this.query = val
			return true
		}
		'fragment' {
			this.fragment = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_WordPress_AiClientDependencies_Nyholm_Psr7_InvalidArgumentException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WordPress_AiClientDependencies_Nyholm_Psr7_InvalidArgumentException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClientDependencies_Nyholm_Psr7_InvalidArgumentException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
