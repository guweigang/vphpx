import rt

struct Class_Snoopy {
	rt.PhpObjectBase
pub mut:
			host rt.PhpVal = rt.new_string('www.php.net')
			port rt.PhpVal = rt.new_int(80)
			proxy_host rt.PhpVal = rt.new_string('')
			proxy_port rt.PhpVal = rt.new_string('')
			proxy_user rt.PhpVal = rt.new_string('')
			proxy_pass rt.PhpVal = rt.new_string('')
			agent rt.PhpVal = rt.new_string('Snoopy v1.2.4')
			referer rt.PhpVal = rt.new_string('')
			cookies rt.PhpVal = rt.new_array()
			rawheaders rt.PhpVal = rt.new_array()
			maxredirs rt.PhpVal = rt.new_int(5)
			lastredirectaddr rt.PhpVal = rt.new_string('')
			offsiteok rt.PhpVal = rt.new_bool(true)
			maxframes rt.PhpVal = rt.new_int(0)
			expandlinks rt.PhpVal = rt.new_bool(true)
			passcookies rt.PhpVal = rt.new_bool(true)
			user rt.PhpVal = rt.new_string('')
			pass rt.PhpVal = rt.new_string('')
			accept rt.PhpVal = rt.new_string('image/gif, image/x-xbitmap, image/jpeg, image/pjpeg, */*')
			results rt.PhpVal = rt.new_string('')
			error string
			response_code rt.PhpVal = rt.new_string('')
			headers rt.PhpVal = rt.new_array()
			maxlength rt.PhpVal = rt.new_int(500000)
			read_timeout rt.PhpVal = rt.new_int(0)
			timed_out bool
			status rt.PhpVal = rt.new_int(0)
			temp_dir rt.PhpVal = rt.new_string('/tmp')
			curl_path rt.PhpVal = rt.new_string('/usr/local/bin/curl')
			_maxlinelen rt.PhpVal = rt.new_int(4096)
			_httpmethod rt.PhpVal = rt.new_string('GET')
			_httpversion rt.PhpVal = rt.new_string('HTTP/1.0')
			_submit_method rt.PhpVal = rt.new_string('POST')
			_submit_type string
			_mime_boundary rt.PhpVal = rt.new_string('')
			_redirectaddr rt.PhpVal = rt.new_bool(false)
			_redirectdepth rt.PhpVal = rt.new_int(0)
			_frameurls rt.PhpVal = rt.new_array()
			_framedepth rt.PhpVal = rt.new_int(0)
			_isproxy bool
			_fp_timeout rt.PhpVal = rt.new_int(30)
}

fn (mut this Class_Snoopy) fetch(var_URI rt.PhpVal) bool {
	mut var_fp := rt.new_null()
	mut var_URI_mutated := var_URI
	mut var_URI_PARTS := rt.call_function('parse_url', [var_URI_mutated.dup()])
	if !(!rt.is_true(var_URI_PARTS.array_get('user'))) {
		this.user = var_URI_PARTS.array_get('user')
	}
	if !(!rt.is_true(var_URI_PARTS.array_get('pass'))) {
		this.pass = var_URI_PARTS.array_get('pass')
	}
	if !rt.is_true(var_URI_PARTS.array_get('query')) {
		var_URI_PARTS.array_set('query', '')
	}
	if !rt.is_true(var_URI_PARTS.array_get('path')) {
		var_URI_PARTS.array_set('path', '')
	}
	mut switch_val_1 := rt.new_string(var_URI_PARTS.array_get('scheme').to_string().to_lower())
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('http'))) {
		this.host = var_URI_PARTS.array_get('host')
		if !(!rt.is_true(var_URI_PARTS.array_get('port'))) {
			this.port = var_URI_PARTS.array_get('port')
		}
		if this._connect(var_fp.dup()) {
			if rt.is_true(this._isproxy) {
				this._httprequest(var_URI_mutated.dup(), var_fp.dup(), var_URI_mutated.dup(), this._httpmethod, '', '')
			} else {
				mut var_path := rt.new_string((var_URI_PARTS.array_get('path')).str() + if rt.is_true(var_URI_PARTS.array_get('query')) { '?' + (var_URI_PARTS.array_get('query')).str() } else { '' })
				this._httprequest(var_path.dup(), var_fp.dup(), var_URI_mutated.dup(), this._httpmethod, '', '')
			}
			this._disconnect(var_fp.dup())
			if rt.is_true(this._redirectaddr) {
				if rt.is_true(rt.greater(this.maxredirs, this._redirectdepth)) {
					if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('preg_match', ['|^http://' + (rt.call_function('preg_quote', [this.host])).str() + '|i', this._redirectaddr])) || rt.is_true(this.offsiteok))) {
						rt.post_inc(this._redirectdepth)
						this.lastredirectaddr = this._redirectaddr
						this.fetch(this._redirectaddr)
					}
				}
			}
			if rt.is_true(rt.new_bool(rt.is_true(rt.less(this._framedepth, this.maxframes)) && this._frameurls.array_count() > 0)) {
				mut var_frameurls := this._frameurls
				this._frameurls = rt.new_array()
				{
					mut iter_1 := var_frameurls.iterator()
					for {
						item_1 := iter_1.next() or { break }
						mut var_frameurl := item_1.val
						if rt.is_true(rt.less(this._framedepth, this.maxframes)) {
							this.fetch(var_frameurl.dup())
							rt.post_inc(this._framedepth)
						} else {
							break
						}
					}
				}
			}
		} else {
			return false
		}
		return true
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('https'))) {
		if rt.is_true(rt.new_bool(!(rt.is_true(this.curl_path)))) {
			return false
		}
		if rt.is_true(rt.call_function('function_exists', [rt.new_string('is_executable')])) {
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_executable', [this.curl_path]))))) {
				return false
			}
		}
		this.host = var_URI_PARTS.array_get('host')
		if !(!rt.is_true(var_URI_PARTS.array_get('port'))) {
			this.port = var_URI_PARTS.array_get('port')
		}
		if rt.is_true(this._isproxy) {
			this._httpsrequest(var_URI_mutated.dup(), var_URI_mutated.dup(), this._httpmethod, '', '')
		} else {
			var_path = rt.new_string((var_URI_PARTS.array_get('path')).str() + if rt.is_true(var_URI_PARTS.array_get('query')) { '?' + (var_URI_PARTS.array_get('query')).str() } else { '' })
			this._httpsrequest(var_path.dup(), var_URI_mutated.dup(), this._httpmethod, '', '')
		}
		if rt.is_true(this._redirectaddr) {
			if rt.is_true(rt.greater(this.maxredirs, this._redirectdepth)) {
				if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('preg_match', ['|^http://' + (rt.call_function('preg_quote', [this.host])).str() + '|i', this._redirectaddr])) || rt.is_true(this.offsiteok))) {
					rt.post_inc(this._redirectdepth)
					this.lastredirectaddr = this._redirectaddr
					this.fetch(this._redirectaddr)
				}
			}
		}
		if rt.is_true(rt.new_bool(rt.is_true(rt.less(this._framedepth, this.maxframes)) && this._frameurls.array_count() > 0)) {
			var_frameurls = this._frameurls
			this._frameurls = rt.new_array()
			{
				mut iter_1 := var_frameurls.iterator()
				for {
					item_1 := iter_1.next() or { break }
					mut var_frameurl := item_1.val
					if rt.is_true(rt.less(this._framedepth, this.maxframes)) {
						this.fetch(var_frameurl.dup())
						rt.post_inc(this._framedepth)
					} else {
						break
					}
				}
			}
		}
		return true
	} else {
		this.error = 'Invalid protocol "' + (var_URI_PARTS.array_get('scheme')).str() + '"\\n'
		return false
	}
	return true
}

fn (mut this Class_Snoopy) submit(var_URI rt.PhpVal, formvars string, formfiles string) bool {
	mut var_fp := rt.new_null()
	mut var_URI_mutated := var_URI
	var_postdata = rt.new_null()
	mut var_postdata := this._prepare_post_body(rt.new_string(formvars), rt.new_string(formfiles))
	mut var_URI_PARTS := rt.call_function('parse_url', [var_URI_mutated.dup()])
	if !(!rt.is_true(var_URI_PARTS.array_get('user'))) {
		this.user = var_URI_PARTS.array_get('user')
	}
	if !(!rt.is_true(var_URI_PARTS.array_get('pass'))) {
		this.pass = var_URI_PARTS.array_get('pass')
	}
	if !rt.is_true(var_URI_PARTS.array_get('query')) {
		var_URI_PARTS.array_set('query', '')
	}
	if !rt.is_true(var_URI_PARTS.array_get('path')) {
		var_URI_PARTS.array_set('path', '')
	}
	mut switch_val_2 := rt.new_string(var_URI_PARTS.array_get('scheme').to_string().to_lower())
	if rt.is_true(rt.equal(switch_val_2, rt.new_string('http'))) {
		this.host = var_URI_PARTS.array_get('host')
		if !(!rt.is_true(var_URI_PARTS.array_get('port'))) {
			this.port = var_URI_PARTS.array_get('port')
		}
		if this._connect(var_fp.dup()) {
			if rt.is_true(this._isproxy) {
				this._httprequest(var_URI_mutated.dup(), var_fp.dup(), var_URI_mutated.dup(), this._submit_method, this._submit_type, (var_postdata).str())
			} else {
				mut var_path := rt.new_string((var_URI_PARTS.array_get('path')).str() + if rt.is_true(var_URI_PARTS.array_get('query')) { '?' + (var_URI_PARTS.array_get('query')).str() } else { '' })
				this._httprequest(var_path.dup(), var_fp.dup(), var_URI_mutated.dup(), this._submit_method, this._submit_type, (var_postdata).str())
			}
			this._disconnect(var_fp.dup())
			if rt.is_true(this._redirectaddr) {
				if rt.is_true(rt.greater(this.maxredirs, this._redirectdepth)) {
					if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('preg_match', ['|^' + (var_URI_PARTS.array_get('scheme')).str() + '://|', this._redirectaddr]))))) {
						this._redirectaddr = this._expandlinks(this._redirectaddr, rt.new_string((var_URI_PARTS.array_get('scheme')).str() + '://' + (var_URI_PARTS.array_get('host')).str()))
					}
					if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('preg_match', ['|^http://' + (rt.call_function('preg_quote', [this.host])).str() + '|i', this._redirectaddr])) || rt.is_true(this.offsiteok))) {
						rt.post_inc(this._redirectdepth)
						this.lastredirectaddr = this._redirectaddr
						if rt.is_true(rt.greater(rt.call_function('strpos', [this._redirectaddr, rt.new_string('?')]), rt.new_int(0))) {
							this.fetch(this._redirectaddr)
						} else {
							this.submit(this._redirectaddr, formvars, formfiles)
						}
					}
				}
			}
			if rt.is_true(rt.new_bool(rt.is_true(rt.less(this._framedepth, this.maxframes)) && this._frameurls.array_count() > 0)) {
				mut var_frameurls := this._frameurls
				this._frameurls = rt.new_array()
				{
					mut iter_1 := var_frameurls.iterator()
					for {
						item_1 := iter_1.next() or { break }
						mut var_frameurl := item_1.val
						if rt.is_true(rt.less(this._framedepth, this.maxframes)) {
							this.fetch(var_frameurl.dup())
							rt.post_inc(this._framedepth)
						} else {
							break
						}
					}
				}
			}
		} else {
			return false
		}
		return true
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('https'))) {
		if rt.is_true(rt.new_bool(!(rt.is_true(this.curl_path)))) {
			return false
		}
		if rt.is_true(rt.call_function('function_exists', [rt.new_string('is_executable')])) {
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_executable', [this.curl_path]))))) {
				return false
			}
		}
		this.host = var_URI_PARTS.array_get('host')
		if !(!rt.is_true(var_URI_PARTS.array_get('port'))) {
			this.port = var_URI_PARTS.array_get('port')
		}
		if rt.is_true(this._isproxy) {
			this._httpsrequest(var_URI_mutated.dup(), var_URI_mutated.dup(), this._submit_method, this._submit_type, (var_postdata).str())
		} else {
			var_path = rt.new_string((var_URI_PARTS.array_get('path')).str() + if rt.is_true(var_URI_PARTS.array_get('query')) { '?' + (var_URI_PARTS.array_get('query')).str() } else { '' })
			this._httpsrequest(var_path.dup(), var_URI_mutated.dup(), this._submit_method, this._submit_type, (var_postdata).str())
		}
		if rt.is_true(this._redirectaddr) {
			if rt.is_true(rt.greater(this.maxredirs, this._redirectdepth)) {
				if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('preg_match', ['|^' + (var_URI_PARTS.array_get('scheme')).str() + '://|', this._redirectaddr]))))) {
					this._redirectaddr = this._expandlinks(this._redirectaddr, rt.new_string((var_URI_PARTS.array_get('scheme')).str() + '://' + (var_URI_PARTS.array_get('host')).str()))
				}
				if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('preg_match', ['|^http://' + (rt.call_function('preg_quote', [this.host])).str() + '|i', this._redirectaddr])) || rt.is_true(this.offsiteok))) {
					rt.post_inc(this._redirectdepth)
					this.lastredirectaddr = this._redirectaddr
					if rt.is_true(rt.greater(rt.call_function('strpos', [this._redirectaddr, rt.new_string('?')]), rt.new_int(0))) {
						this.fetch(this._redirectaddr)
					} else {
						this.submit(this._redirectaddr, formvars, formfiles)
					}
				}
			}
		}
		if rt.is_true(rt.new_bool(rt.is_true(rt.less(this._framedepth, this.maxframes)) && this._frameurls.array_count() > 0)) {
			var_frameurls = this._frameurls
			this._frameurls = rt.new_array()
			{
				mut iter_1 := var_frameurls.iterator()
				for {
					item_1 := iter_1.next() or { break }
					mut var_frameurl := item_1.val
					if rt.is_true(rt.less(this._framedepth, this.maxframes)) {
						this.fetch(var_frameurl.dup())
						rt.post_inc(this._framedepth)
					} else {
						break
					}
				}
			}
		}
		return true
	} else {
		this.error = 'Invalid protocol "' + (var_URI_PARTS.array_get('scheme')).str() + '"\\n'
		return false
	}
	return true
}

fn (mut this Class_Snoopy) fetchlinks(var_URI rt.PhpVal) bool {
	mut var_URI_mutated := var_URI
	if this.fetch(var_URI_mutated.dup()) {
		if rt.is_true(this.lastredirectaddr) {
			var_URI_mutated = this.lastredirectaddr
		}
		if rt.is_true(rt.new_bool(this.results.is_array())) {
			{
				mut var_x := rt.new_int()
				for {
					if !(rt.is_true(rt.less(, ))) { break }
					
					
				}
			}
		} else {
		}
		if rt.is_true() {
		}
		return 
	} else {
	}
	return false
}

fn (mut this Class_Snoopy) fetchform(var_URI rt.PhpVal) bool {
	mut var_URI_mutated := var_URI
	if rt.is_true() {
	} else {
	}
	return false
}

fn (mut this Class_Snoopy) fetchtext(var_URI rt.PhpVal) bool {
	mut var_URI_mutated := var_URI
	if rt.is_true() {
	} else {
	}
	return false
}

fn (mut this Class_Snoopy) submitlinks(var_URI rt.PhpVal, formvars string, formfiles string) bool {
	mut var_URI_mutated := var_URI
	if rt.is_true() {
	} else {
	}
	return false
}

fn (mut this Class_Snoopy) submittext(var_URI rt.PhpVal, formvars string, formfiles string) bool {
	mut var_URI_mutated := var_URI
	if rt.is_true() {
	} else {
	}
	return false
}

fn (mut this Class_Snoopy) set_submit_multipart()  {
	
}

fn (mut this Class_Snoopy) set_submit_normal()  {
}

fn (mut this Class_Snoopy) _striplinks(var_document rt.PhpVal) rt.PhpVal {
	mut var_links := []rt.PhpVal{}
	mut var_match := rt.new_null()
}

fn (mut this Class_Snoopy) _stripform(var_document rt.PhpVal) rt.PhpVal {
	mut var_elements := []rt.PhpVal{}
}

fn (mut this Class_Snoopy) _striptext(var_document rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_Snoopy) _expandlinks(var_links rt.PhpVal, var_URI rt.PhpVal) rt.PhpVal {
	mut var_URI_mutated := var_URI
}

fn (mut this Class_Snoopy) _httprequest(var_url rt.PhpVal, var_fp rt.PhpVal, var_URI rt.PhpVal, var_http_method rt.PhpVal, content_type string, body string) bool {
	mut var_matches := []rt.PhpVal{}
	mut var_status := []rt.PhpVal{}
	mut var_match := rt.new_null()
	mut var_url_mutated := var_url
	mut var_fp_mutated := var_fp
	mut var_URI_mutated := var_URI
}

fn (mut this Class_Snoopy) _httpsrequest(var_url rt.PhpVal, var_URI rt.PhpVal, var_http_method rt.PhpVal, content_type string, body string) bool {
	mut var_return := rt.new_null()
	mut var_matches := []rt.PhpVal{}
	mut var_match := rt.new_null()
	mut var_url_mutated := var_url
	mut var_URI_mutated := var_URI
}

fn (mut this Class_Snoopy) setcookies()  {
	mut var_match := rt.new_null()
}

fn (mut this Class_Snoopy) _check_timeout(var_fp rt.PhpVal) bool {
	mut var_fp_mutated := var_fp
}

fn (mut this Class_Snoopy) _connect(var_fp rt.PhpVal) bool {
	mut var_errno := rt.new_null()
	mut var_errstr := rt.new_null()
	mut var_fp_mutated := var_fp
	return false
}

fn (mut this Class_Snoopy) _disconnect(var_fp rt.PhpVal) rt.PhpVal {
	mut var_fp_mutated := var_fp
}

fn (mut this Class_Snoopy) _prepare_post_body(var_formvars rt.PhpVal, var_formfiles rt.PhpVal) rt.PhpVal {
}

fn create_snoopy() &Class_Snoopy {
	mut obj := &Class_Snoopy{
		PhpObjectBase: rt.PhpObjectBase{}
		host: rt.new_string('www.php.net')
		port: rt.new_int(80)
		proxy_host: rt.new_string('')
		proxy_port: rt.new_string('')
		proxy_user: rt.new_string('')
		proxy_pass: rt.new_string('')
		agent: rt.new_string('Snoopy v1.2.4')
		referer: rt.new_string('')
		cookies: rt.new_array()
		rawheaders: rt.new_array()
		maxredirs: rt.new_int(5)
		lastredirectaddr: rt.new_string('')
		offsiteok: rt.new_bool(true)
		maxframes: rt.new_int(0)
		expandlinks: rt.new_bool(true)
		passcookies: rt.new_bool(true)
		user: rt.new_string('')
		pass: rt.new_string('')
		accept: rt.new_string('image/gif, image/x-xbitmap, image/jpeg, image/pjpeg, */*')
		results: rt.new_string('')
		error: ''
		response_code: rt.new_string('')
		headers: rt.new_array()
		maxlength: rt.new_int(500000)
		read_timeout: rt.new_int(0)
		timed_out: false
		status: rt.new_int(0)
		temp_dir: rt.new_string('/tmp')
		curl_path: rt.new_string('/usr/local/bin/curl')
		_maxlinelen: rt.new_int(4096)
		_httpmethod: rt.new_string('GET')
		_httpversion: rt.new_string('HTTP/1.0')
		_submit_method: rt.new_string('POST')
		_submit_type: ''
		_mime_boundary: rt.new_string('')
		_redirectaddr: rt.new_bool(false)
		_redirectdepth: rt.new_int(0)
		_frameurls: rt.new_array()
		_framedepth: rt.new_int(0)
		_isproxy: false
		_fp_timeout: rt.new_int(30)
	}
	return obj
}

fn (mut this Class_Snoopy) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'fetch' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.fetch(dispatch_arg_0))
		}
		'submit' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			return rt.new_bool(this.submit(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2))
		}
		'fetchlinks' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.fetchlinks(dispatch_arg_0))
		}
		'fetchform' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.fetchform(dispatch_arg_0))
		}
		'fetchtext' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.fetchtext(dispatch_arg_0))
		}
		'submitlinks' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			return rt.new_bool(this.submitlinks(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2))
		}
		'submittext' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			return rt.new_bool(this.submittext(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2))
		}
		'set_submit_multipart' {
			this.set_submit_multipart()
			return rt.new_null()
		}
		'set_submit_normal' {
			this.set_submit_normal()
			return rt.new_null()
		}
		'_striplinks' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this._striplinks(dispatch_arg_0)
		}
		'_stripform' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this._stripform(dispatch_arg_0)
		}
		'_striptext' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this._striptext(dispatch_arg_0)
		}
		'_expandlinks' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this._expandlinks(dispatch_arg_0, dispatch_arg_1)
		}
		'_httprequest' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			dispatch_arg_4 := (if args.len > 4 { args[4] } else { rt.new_null() }).str()
			dispatch_arg_5 := (if args.len > 5 { args[5] } else { rt.new_null() }).str()
			return rt.new_bool(this._httprequest(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3, dispatch_arg_4, dispatch_arg_5))
		}
		'_httpsrequest' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).str()
			dispatch_arg_4 := (if args.len > 4 { args[4] } else { rt.new_null() }).str()
			return rt.new_bool(this._httpsrequest(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3, dispatch_arg_4))
		}
		'setcookies' {
			this.setcookies()
			return rt.new_null()
		}
		'_check_timeout' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this._check_timeout(dispatch_arg_0))
		}
		'_connect' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this._connect(dispatch_arg_0))
		}
		'_disconnect' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this._disconnect(dispatch_arg_0)
		}
		'_prepare_post_body' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this._prepare_post_body(dispatch_arg_0, dispatch_arg_1)
		}
		else { return none }
	}
}

fn (this &Class_Snoopy) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'host' { return this.host }
		'port' { return this.port }
		'proxy_host' { return this.proxy_host }
		'proxy_port' { return this.proxy_port }
		'proxy_user' { return this.proxy_user }
		'proxy_pass' { return this.proxy_pass }
		'agent' { return this.agent }
		'referer' { return this.referer }
		'cookies' { return this.cookies }
		'rawheaders' { return this.rawheaders }
		'maxredirs' { return this.maxredirs }
		'lastredirectaddr' { return this.lastredirectaddr }
		'offsiteok' { return this.offsiteok }
		'maxframes' { return this.maxframes }
		'expandlinks' { return this.expandlinks }
		'passcookies' { return this.passcookies }
		'user' { return this.user }
		'pass' { return this.pass }
		'accept' { return this.accept }
		'results' { return this.results }
		'error' { return rt.new_string(this.error) }
		'response_code' { return this.response_code }
		'headers' { return this.headers }
		'maxlength' { return this.maxlength }
		'read_timeout' { return this.read_timeout }
		'timed_out' { return rt.new_bool(this.timed_out) }
		'status' { return this.status }
		'temp_dir' { return this.temp_dir }
		'curl_path' { return this.curl_path }
		'_maxlinelen' { return this._maxlinelen }
		'_httpmethod' { return this._httpmethod }
		'_httpversion' { return this._httpversion }
		'_submit_method' { return this._submit_method }
		'_submit_type' { return rt.new_string(this._submit_type) }
		'_mime_boundary' { return this._mime_boundary }
		'_redirectaddr' { return this._redirectaddr }
		'_redirectdepth' { return this._redirectdepth }
		'_frameurls' { return this._frameurls }
		'_framedepth' { return this._framedepth }
		'_isproxy' { return rt.new_bool(this._isproxy) }
		'_fp_timeout' { return this._fp_timeout }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Snoopy) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'host' { this.host = val; return true }
		'port' { this.port = val; return true }
		'proxy_host' { this.proxy_host = val; return true }
		'proxy_port' { this.proxy_port = val; return true }
		'proxy_user' { this.proxy_user = val; return true }
		'proxy_pass' { this.proxy_pass = val; return true }
		'agent' { this.agent = val; return true }
		'referer' { this.referer = val; return true }
		'cookies' { this.cookies = val; return true }
		'rawheaders' { this.rawheaders = val; return true }
		'maxredirs' { this.maxredirs = val; return true }
		'lastredirectaddr' { this.lastredirectaddr = val; return true }
		'offsiteok' { this.offsiteok = val; return true }
		'maxframes' { this.maxframes = val; return true }
		'expandlinks' { this.expandlinks = val; return true }
		'passcookies' { this.passcookies = val; return true }
		'user' { this.user = val; return true }
		'pass' { this.pass = val; return true }
		'accept' { this.accept = val; return true }
		'results' { this.results = val; return true }
		'error' { this.error = (val).str(); return true }
		'response_code' { this.response_code = val; return true }
		'headers' { this.headers = val; return true }
		'maxlength' { this.maxlength = val; return true }
		'read_timeout' { this.read_timeout = val; return true }
		'timed_out' { this.timed_out = (val).to_bool(); return true }
		'status' { this.status = val; return true }
		'temp_dir' { this.temp_dir = val; return true }
		'curl_path' { this.curl_path = val; return true }
		'_maxlinelen' { this._maxlinelen = val; return true }
		'_httpmethod' { this._httpmethod = val; return true }
		'_httpversion' { this._httpversion = val; return true }
		'_submit_method' { this._submit_method = val; return true }
		'_submit_type' { this._submit_type = (val).str(); return true }
		'_mime_boundary' { this._mime_boundary = val; return true }
		'_redirectaddr' { this._redirectaddr = val; return true }
		'_redirectdepth' { this._redirectdepth = val; return true }
		'_frameurls' { this._frameurls = val; return true }
		'_framedepth' { this._framedepth = val; return true }
		'_isproxy' { this._isproxy = (val).to_bool(); return true }
		'_fp_timeout' { this._fp_timeout = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}




pub fn init_wp_includes_class_snoopy_php() {
	rt.call_function('_deprecated_file', [rt.call_function('basename', [rt.new_string(@FILE)]), rt.new_string('3.0.0'), (rt.get_constant('WPINC')).str() + '/http.php'])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [rt.new_string('Snoopy'), rt.new_bool(false)]))))) {
	}
}
