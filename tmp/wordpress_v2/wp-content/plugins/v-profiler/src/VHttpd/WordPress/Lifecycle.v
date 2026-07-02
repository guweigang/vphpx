import rt

struct Class_VHttpd_WordPress_Lifecycle {
	rt.PhpObjectBase
}

fn (mut this Class_VHttpd_WordPress_Lifecycle) rootfromenv(envName string) string {
	mut var_root := rt.call_function('getenv', [rt.new_string(envName)])
	if !(var_root.clone().is_string()) || rt.is_true(rt.identical(var_root, rt.new_string(''))) {
		rt.throw_exception(rt.new_object('RuntimeException', []string{},
			create_runtimeexception(rt.new_string('${var_envName} is required for wordpress runtime'))))
	}
	return var_root.clone().to_string().trim_right(' \t\n\r')
}

fn (mut this Class_VHttpd_WordPress_Lifecycle) wploadpath(root string) string {
	mut root_mutated := root
	mut var_wpLoad := rt.new_string(root_mutated.trim_right(' \t\n\r') + '/wp-load.php')
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_file', [
		var_wpLoad.clone()])))))
	{
		rt.throw_exception(rt.new_object('RuntimeException', []string{}, create_runtimeexception(
			'wp-load.php not found: ' + var_wpLoad.str())))
	}
	return var_wpLoad.str()
}

fn (mut this Class_VHttpd_WordPress_Lifecycle) isinstalled(root string) bool {
	mut root_mutated := root
	return (rt.call_function('is_file', [
		rt.new_string(root_mutated.trim_right(' \t\n\r') + '/wp-config.php'),
	])).to_bool()
}

fn (mut this Class_VHttpd_WordPress_Lifecycle) bootstrap(root string) {
	mut root_mutated := root
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('WP_USE_THEMES'),
	])))))
	{
		rt.call_function('define', [rt.new_string('WP_USE_THEMES'),
			rt.new_bool(true)])
	}
	rt.include_file(this.wploadpath(root_mutated), '4')
}

fn (mut this Class_VHttpd_WordPress_Lifecycle) bootstrapifinstalled(root string) bool {
	mut root_mutated := root
	if !(this.isinstalled(root_mutated)) {
		return false
	}
	this.bootstrap(root_mutated)
	return true
}

fn (mut this Class_VHttpd_WordPress_Lifecycle) normalizerequest(mut var_requestOrEnvelope Class_VHttpd_WordPress_mixed, mut var_envelope Class_VHttpd_WordPress_array) rt.PhpVal {
	if rt.is_true(rt.new_bool(rt.instance_of(rt.new_object('VHttpd_WordPress_mixed', []string{},
		var_requestOrEnvelope), 'VHttpd_WordPress_Psr_Http_Message_ServerRequestInterface')))
	{
		mut var_request := var_requestOrEnvelope
		mut var_headers := rt.new_array()
		mut iter_1 := rt.call_method(var_request, 'getHeaders', []rt.PhpVal{}).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_values := item_1.val
			mut var_name := item_1.key
			var_headers.array_set(var_name, rt.call_function('implode', [
				rt.new_string(', '),
				var_values.clone(),
			]))
		}
		mut var_serverParams := rt.call_method(var_request, 'getServerParams', []rt.PhpVal{})
		mut var_method :=
			rt.new_string(rt.call_method(var_request, 'getMethod', []rt.PhpVal{}).to_string().to_upper())
		mut var_originalMethod := var_method.clone()
		if rt.is_true(rt.identical(var_method, rt.new_string('HEAD'))) {
			var_method = rt.new_string('GET')
		}
		return this.normalizecookiestate(mut rt.cast_object_ptr[Class_VHttpd_WordPress_array](rt.create_array([
			rt.ArrayItem{ key: 'path', val: rt.call_method(rt.call_method(var_request, 'getUri',
				[]rt.PhpVal{}), 'getPath', []rt.PhpVal{}) },
			rt.ArrayItem{ key: 'query_string', val: rt.call_method(rt.call_method(var_request,
				'getUri', []rt.PhpVal{}), 'getQuery', []rt.PhpVal{}) },
			rt.ArrayItem{ key: 'method', val: var_method },
			rt.ArrayItem{ key: 'original_method', val: var_originalMethod },
			rt.ArrayItem{ key: 'query', val: rt.call_method(var_request, 'getQueryParams',
				[]rt.PhpVal{}) },
			rt.ArrayItem{
				key: 'body'
				val: (rt.call_method(var_request, 'getBody', []rt.PhpVal{})).str()
			},
			rt.ArrayItem{ key: 'headers', val: var_headers },
			rt.ArrayItem{ key: 'cookies', val: rt.call_method(var_request, 'getCookieParams',
				[]rt.PhpVal{}) },
			rt.ArrayItem{ key: 'server', val: var_serverParams },
			rt.ArrayItem{ key: 'host', val: rt.call_method(rt.call_method(var_request, 'getUri',
				[]rt.PhpVal{}), 'getHost', []rt.PhpVal{}) },
			rt.ArrayItem{ key: 'port', val: (rt.call_method(rt.call_method(var_request, 'getUri',
				[]rt.PhpVal{}), 'getPort', []rt.PhpVal{})).str() },
			rt.ArrayItem{ key: 'scheme', val: rt.call_method(rt.call_method(var_request, 'getUri',
				[]rt.PhpVal{}), 'getScheme', []rt.PhpVal{}) },
			rt.ArrayItem{ key: 'remote_addr', val: (if !(var_serverParams.array_get(rt.new_string('REMOTE_ADDR'))).is_null() {
				var_serverParams.array_get(rt.new_string('REMOTE_ADDR'))
			} else {
				rt.new_string('')
			}).str() },
			rt.ArrayItem{
				key: 'trace_id'
				val: if rt.is_true(this.headervalue(mut rt.cast_object_ptr[Class_VHttpd_WordPress_array](var_headers), mut rt.cast_object_ptr[Class_VHttpd_WordPress_array](rt.create_array([
					rt.ArrayItem{ key: none, val: 'x-vhttpd-trace-id' },
					rt.ArrayItem{ key: none, val: 'X-Vhttpd-Trace-Id' },
					rt.ArrayItem{ key: none, val: 'X-VHTTPD-TRACE-ID' },
				]))))
				{ this.headervalue(mut rt.cast_object_ptr[Class_VHttpd_WordPress_array](var_headers), mut rt.cast_object_ptr[Class_VHttpd_WordPress_array](rt.create_array([
						rt.ArrayItem{ key: none, val: 'x-vhttpd-trace-id' },
						rt.ArrayItem{ key: none, val: 'X-Vhttpd-Trace-Id' },
						rt.ArrayItem{ key: none, val: 'X-VHTTPD-TRACE-ID' },
					]))) } else { (if !(var_serverParams.array_get(rt.new_string('VHTTPD_TRACE_ID'))).is_null() {
						var_serverParams.array_get(rt.new_string('VHTTPD_TRACE_ID'))
					} else {
						if !(var_serverParams.array_get(rt.new_string('HTTP_X_VHTTPD_TRACE_ID'))).is_null() {
							var_serverParams.array_get(rt.new_string('HTTP_X_VHTTPD_TRACE_ID'))
						} else {
							rt.new_string('')
						}
					}).str()
				 }
			},
			rt.ArrayItem{
				key: 'request_id'
				val: if rt.is_true(this.headervalue(mut rt.cast_object_ptr[Class_VHttpd_WordPress_array](var_headers), mut rt.cast_object_ptr[Class_VHttpd_WordPress_array](rt.create_array([
					rt.ArrayItem{ key: none, val: 'x-request-id' },
					rt.ArrayItem{ key: none, val: 'X-Request-Id' },
				]))))
				{ this.headervalue(mut rt.cast_object_ptr[Class_VHttpd_WordPress_array](var_headers), mut rt.cast_object_ptr[Class_VHttpd_WordPress_array](rt.create_array([
						rt.ArrayItem{ key: none, val: 'x-request-id' },
						rt.ArrayItem{ key: none, val: 'X-Request-Id' },
					]))) } else { (if !(var_serverParams.array_get(rt.new_string('VHTTPD_REQUEST_ID'))).is_null() {
						var_serverParams.array_get(rt.new_string('VHTTPD_REQUEST_ID'))
					} else {
						if !(var_serverParams.array_get(rt.new_string('HTTP_X_REQUEST_ID'))).is_null() {
							var_serverParams.array_get(rt.new_string('HTTP_X_REQUEST_ID'))
						} else {
							rt.new_string('')
						}
					}).str()
				 }
			},
		])))
	}
	mut var_payload := if var_requestOrEnvelope.is_array() {
		var_requestOrEnvelope
	} else {
		var_envelope
	}
	mut var_path := rt.new_string((if !(var_payload.array_get(rt.new_string('path'))).is_null() {
		var_payload.array_get(rt.new_string('path'))
	} else {
		rt.new_string('/')
	}).str())
	mut var_queryString := rt.new_string('')
	if rt.is_true(rt.call_function('str_contains', [var_path.clone(),
		rt.new_string('?')]))
	{
		mut list_tmp_1 := rt.call_function('explode', [rt.new_string('?'),
			var_path.clone(), rt.new_int(2)])
		var_path = list_tmp_1.array_get(0)
		var_queryString = list_tmp_1.array_get(1)
	}
	mut var_query := if !(var_payload.array_get(rt.new_string('query'))).is_null() {
		var_payload.array_get(rt.new_string('query'))
	} else {
		rt.new_array()
	}
	if rt.is_true(rt.identical(var_queryString, rt.new_string(''))) && var_query.clone().is_array()
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_query, rt.new_array())))) {
		var_queryString = rt.call_function('http_build_query', [
			var_query.clone()])
	}
	var_method = rt.new_string((if !(var_payload.array_get(rt.new_string('method'))).is_null() {
		var_payload.array_get(rt.new_string('method'))
	} else {
		rt.new_string('GET')
	}).str().to_upper())
	var_originalMethod = var_method.clone()
	if rt.is_true(rt.identical(var_method, rt.new_string('HEAD'))) {
		var_method = rt.new_string('GET')
	}
	return this.normalizecookiestate(mut rt.cast_object_ptr[Class_VHttpd_WordPress_array](rt.create_array([
		rt.ArrayItem{ key: 'path', val: var_path },
		rt.ArrayItem{ key: 'query_string', val: var_queryString },
		rt.ArrayItem{ key: 'method', val: var_method },
		rt.ArrayItem{ key: 'original_method', val: var_originalMethod },
		rt.ArrayItem{
			key: 'query'
			val: if var_query.clone().is_array() { var_query } else { rt.new_array() }
		},
		rt.ArrayItem{ key: 'body', val: (if !(var_payload.array_get(rt.new_string('body'))).is_null() {
			var_payload.array_get(rt.new_string('body'))
		} else {
			rt.new_string('')
		}).str() },
		rt.ArrayItem{
			key: 'headers'
			val: if if !(var_payload.array_get(rt.new_string('headers'))).is_null() {
				var_payload.array_get(rt.new_string('headers'))
			} else {
				rt.new_null()
			}.is_array()
			{ var_payload.array_get(rt.new_string('headers'))
			 } else { rt.new_array()
			 }
		},
		rt.ArrayItem{
			key: 'cookies'
			val: if if !(var_payload.array_get(rt.new_string('cookies'))).is_null() {
				var_payload.array_get(rt.new_string('cookies'))
			} else {
				rt.new_null()
			}.is_array()
			{ var_payload.array_get(rt.new_string('cookies'))
			 } else { rt.new_array()
			 }
		},
		rt.ArrayItem{
			key: 'server'
			val: if if !(var_payload.array_get(rt.new_string('server'))).is_null() {
				var_payload.array_get(rt.new_string('server'))
			} else {
				rt.new_null()
			}.is_array()
			{ var_payload.array_get(rt.new_string('server'))
			 } else { rt.new_array()
			 }
		},
		rt.ArrayItem{ key: 'host', val: (if !(var_payload.array_get(rt.new_string('host'))).is_null() {
			var_payload.array_get(rt.new_string('host'))
		} else {
			rt.new_string('')
		}).str() },
		rt.ArrayItem{ key: 'port', val: (if !(var_payload.array_get(rt.new_string('port'))).is_null() {
			var_payload.array_get(rt.new_string('port'))
		} else {
			rt.new_string('')
		}).str() },
		rt.ArrayItem{ key: 'scheme', val: this.requestscheme(mut rt.cast_object_ptr[Class_VHttpd_WordPress_array](if if !(var_payload.array_get(rt.new_string('headers'))).is_null() {
			var_payload.array_get(rt.new_string('headers'))
		} else {
			rt.new_null()
		}.is_array()
		{ var_payload.array_get(rt.new_string('headers'))
		 } else { rt.new_array()
		 }), (if !(var_payload.array_get(rt.new_string('scheme'))).is_null() {
			var_payload.array_get(rt.new_string('scheme'))
		} else {
			rt.new_string('http')
		}).str()) },
		rt.ArrayItem{ key: 'remote_addr', val: (if !(var_payload.array_get(rt.new_string('remote_addr'))).is_null() {
			var_payload.array_get(rt.new_string('remote_addr'))
		} else {
			rt.new_string('')
		}).str() },
		rt.ArrayItem{
			key: 'trace_id'
			val: this.requesttraceid(mut rt.cast_object_ptr[Class_VHttpd_WordPress_array](var_payload))
		},
		rt.ArrayItem{
			key: 'request_id'
			val: this.requestrequestid(mut rt.cast_object_ptr[Class_VHttpd_WordPress_array](var_payload))
		},
	])))
}

fn (mut this Class_VHttpd_WordPress_Lifecycle) prepareenvironment(mut var_request Class_VHttpd_WordPress_array) {
	mut var_request_mutated := var_request
	mut var_path := rt.new_string((if !(var_request_mutated.array_get(rt.new_string('path'))).is_null() {
		var_request_mutated.array_get(rt.new_string('path'))
	} else {
		rt.new_string('/')
	}).str())
	mut var_queryString := rt.new_string((if !(var_request_mutated.array_get(rt.new_string('query_string'))).is_null() {
		var_request_mutated.array_get(rt.new_string('query_string'))
	} else {
		rt.new_string('')
	}).str())
	mut var_method := rt.new_string((if !(var_request_mutated.array_get(rt.new_string('method'))).is_null() {
		var_request_mutated.array_get(rt.new_string('method'))
	} else {
		rt.new_string('GET')
	}).str().to_upper())
	mut var_headers := if if !(var_request_mutated.array_get(rt.new_string('headers'))).is_null() {
		var_request_mutated.array_get(rt.new_string('headers'))
	} else {
		rt.new_null()
	}.is_array()
	{ var_request_mutated.array_get(rt.new_string('headers'))
	 } else { rt.new_array()
	 }
	mut var_query := if if !(var_request_mutated.array_get(rt.new_string('query'))).is_null() {
		var_request_mutated.array_get(rt.new_string('query'))
	} else {
		rt.new_null()
	}.is_array()
	{ var_request_mutated.array_get(rt.new_string('query'))
	 } else { rt.new_array()
	 }
	mut var_cookies := if if !(var_request_mutated.array_get(rt.new_string('cookies'))).is_null() {
		var_request_mutated.array_get(rt.new_string('cookies'))
	} else {
		rt.new_null()
	}.is_array()
	{ var_request_mutated.array_get(rt.new_string('cookies'))
	 } else { rt.new_array()
	 }
	mut var_body := rt.new_string((if !(var_request_mutated.array_get(rt.new_string('body'))).is_null() {
		var_request_mutated.array_get(rt.new_string('body'))
	} else {
		rt.new_string('')
	}).str())
	mut var_host := rt.new_string((if !(var_request_mutated.array_get(rt.new_string('host'))).is_null() {
		var_request_mutated.array_get(rt.new_string('host'))
	} else {
		rt.new_string('')
	}).str())
	mut var_port := rt.new_string((if !(var_request_mutated.array_get(rt.new_string('port'))).is_null() {
		var_request_mutated.array_get(rt.new_string('port'))
	} else {
		rt.new_string('')
	}).str())
	mut var_scheme := rt.new_string((if !(var_request_mutated.array_get(rt.new_string('scheme'))).is_null() {
		var_request_mutated.array_get(rt.new_string('scheme'))
	} else {
		rt.new_string('http')
	}).str())
	mut var_traceId := rt.new_string((if !(var_request_mutated.array_get(rt.new_string('trace_id'))).is_null() {
		var_request_mutated.array_get(rt.new_string('trace_id'))
	} else {
		rt.new_string('')
	}).str())
	mut var_requestId := rt.new_string((if !(var_request_mutated.array_get(rt.new_string('request_id'))).is_null() {
		var_request_mutated.array_get(rt.new_string('request_id'))
	} else {
		rt.new_string('')
	}).str())
	rt.get_superglobal('_SERVER').array_set('REQUEST_URI', var_path.str() +
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_queryString, rt.new_string(''))))) { '?' +
		var_queryString.str() } else { '' })
	rt.get_superglobal('_SERVER').array_set('REQUEST_METHOD', var_method.clone())
	rt.get_superglobal('_SERVER').array_set('QUERY_STRING', var_queryString.clone())
	rt.get_superglobal('_SERVER').array_set('HTTP_HOST', this.hostheader(var_host.str(),
		var_port.str()))
	rt.get_superglobal('_SERVER').array_set('SERVER_NAME', if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_host,
		rt.new_string('')))))
	{
		var_host
	} else {
		rt.new_string('localhost')
	})
	rt.get_superglobal('_SERVER').array_set('SERVER_PORT', if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_port,
		rt.new_string('')))))
	{
		var_port
	} else {
		if rt.is_true(rt.identical(var_scheme, rt.new_string('https'))) { '443' } else { '80' }
	})
	rt.get_superglobal('_SERVER').array_set('HTTPS', if rt.is_true(rt.identical(var_scheme,
		rt.new_string('https')))
	{
		'on'
	} else {
		'off'
	})
	rt.get_superglobal('_SERVER').array_set('REQUEST_SCHEME', var_scheme.clone())
	rt.get_superglobal('_SERVER').array_set('HTTP_X_FORWARDED_PROTO', var_scheme.clone())
	rt.get_superglobal('_SERVER').array_set('REMOTE_ADDR', if rt.is_true((if !(var_request_mutated.array_get(rt.new_string('remote_addr'))).is_null() {
		var_request_mutated.array_get(rt.new_string('remote_addr'))
	} else {
		rt.new_string('127.0.0.1')
	}).str())
	{ (if !(var_request_mutated.array_get(rt.new_string('remote_addr'))).is_null() {
			var_request_mutated.array_get(rt.new_string('remote_addr'))
		} else {
			rt.new_string('127.0.0.1')
		}).str()
	 } else { '127.0.0.1'
	 })
	rt.get_superglobal('_SERVER').array_set('HTTP_COOKIE', (if !(var_request_mutated.array_get(rt.new_string('cookie_header'))).is_null() {
		var_request_mutated.array_get(rt.new_string('cookie_header'))
	} else {
		rt.new_string('')
	}).str())
	rt.get_superglobal('_SERVER').array_set('VHTTPD_TRACE_ID', var_traceId.clone())
	rt.get_superglobal('_SERVER').array_set('VHTTPD_REQUEST_ID', var_requestId.clone())
	rt.get_superglobal('_SERVER').array_set('HTTP_X_VHTTPD_TRACE_ID', var_traceId.clone())
	rt.get_superglobal('_SERVER').array_set('HTTP_X_REQUEST_ID', var_requestId.clone())
	rt.call_function('putenv', [rt.new_string('VHTTPD_TRACE_ID=' + var_traceId.str())])
	rt.call_function('putenv', [
		rt.new_string('VHTTPD_REQUEST_ID=' + var_requestId.str()),
	])
	this.refreshdependencyurls(var_scheme.str())
	mut var__GET := var_query.clone()
	mut var__POST := rt.new_array()
	if rt.is_true(rt.identical(var_method, rt.new_string('POST'))) {
		mut var_contentType := if !(var_headers.array_get(rt.new_string('content-type'))).is_null() {
			var_headers.array_get(rt.new_string('content-type'))
		} else {
			if !(var_headers.array_get(rt.new_string('Content-Type'))).is_null() {
				var_headers.array_get(rt.new_string('Content-Type'))
			} else {
				rt.new_string('')
			}
		}
		if rt.is_true(rt.new_bool(var_contentType.clone().is_array())) {
			var_contentType = rt.call_function('implode', [rt.new_string(', '),
				var_contentType.clone()])
		}
		if rt.is_true(rt.call_function('str_contains', [
			rt.new_string(var_contentType.str().to_lower()),
			rt.new_string('application/x-www-form-urlencoded'),
		]))
		{
			rt.call_function('parse_str', [var_body.clone(), rt.get_superglobal('_POST').clone()])
		}
	}
	mut var__COOKIE := var_cookies.clone()
	mut var__REQUEST := rt.call_function('array_merge', [rt.get_superglobal('_GET').clone(),
		rt.get_superglobal('_POST').clone(), rt.get_superglobal('_COOKIE').clone()])
}

fn (mut this Class_VHttpd_WordPress_Lifecycle) preparebootstrapdefaults() {
	mut var_scheme := rt.new_string(this.bootstrapscheme())
	rt.get_superglobal('_SERVER').array_set('HTTP_HOST', if !(rt.get_superglobal('_SERVER').array_get(rt.new_string('HTTP_HOST'))).is_null() {
		rt.get_superglobal('_SERVER').array_get(rt.new_string('HTTP_HOST'))
	} else {
		rt.new_string('localhost')
	})
	rt.get_superglobal('_SERVER').array_set('REQUEST_URI', if !(rt.get_superglobal('_SERVER').array_get(rt.new_string('REQUEST_URI'))).is_null() {
		rt.get_superglobal('_SERVER').array_get(rt.new_string('REQUEST_URI'))
	} else {
		rt.new_string('/')
	})
	rt.get_superglobal('_SERVER').array_set('REQUEST_METHOD', if !(rt.get_superglobal('_SERVER').array_get(rt.new_string('REQUEST_METHOD'))).is_null() {
		rt.get_superglobal('_SERVER').array_get(rt.new_string('REQUEST_METHOD'))
	} else {
		rt.new_string('GET')
	})
	rt.get_superglobal('_SERVER').array_set('SERVER_NAME', if !(rt.get_superglobal('_SERVER').array_get(rt.new_string('SERVER_NAME'))).is_null() {
		rt.get_superglobal('_SERVER').array_get(rt.new_string('SERVER_NAME'))
	} else {
		rt.new_string('localhost')
	})
	rt.get_superglobal('_SERVER').array_set('SERVER_PORT', if !(rt.get_superglobal('_SERVER').array_get(rt.new_string('SERVER_PORT'))).is_null() {
		rt.get_superglobal('_SERVER').array_get(rt.new_string('SERVER_PORT'))
	} else {
		if rt.is_true(rt.identical(var_scheme, rt.new_string('https'))) { '443' } else { '80' }
	})
	rt.get_superglobal('_SERVER').array_set('HTTPS', if !(rt.get_superglobal('_SERVER').array_get(rt.new_string('HTTPS'))).is_null() {
		rt.get_superglobal('_SERVER').array_get(rt.new_string('HTTPS'))
	} else {
		if rt.is_true(rt.identical(var_scheme, rt.new_string('https'))) { 'on' } else { 'off' }
	})
	rt.get_superglobal('_SERVER').array_set('REQUEST_SCHEME', if !(rt.get_superglobal('_SERVER').array_get(rt.new_string('REQUEST_SCHEME'))).is_null() {
		rt.get_superglobal('_SERVER').array_get(rt.new_string('REQUEST_SCHEME'))
	} else {
		var_scheme
	})
	rt.get_superglobal('_SERVER').array_set('HTTP_X_FORWARDED_PROTO', if !(rt.get_superglobal('_SERVER').array_get(rt.new_string('HTTP_X_FORWARDED_PROTO'))).is_null() {
		rt.get_superglobal('_SERVER').array_get(rt.new_string('HTTP_X_FORWARDED_PROTO'))
	} else {
		var_scheme
	})
	rt.get_superglobal('_SERVER').array_set('REMOTE_ADDR', if !(rt.get_superglobal('_SERVER').array_get(rt.new_string('REMOTE_ADDR'))).is_null() {
		rt.get_superglobal('_SERVER').array_get(rt.new_string('REMOTE_ADDR'))
	} else {
		rt.new_string('127.0.0.1')
	})
}

fn (mut this Class_VHttpd_WordPress_Lifecycle) resetrequestruntime() {
	mut var_wp_styles := rt.new_null()
	mut var_wp_scripts := rt.new_null()
	mut var_wp_script_modules := rt.new_null()
	mut var_GLOBALS := rt.new_null()
	mut var_current_user := rt.get_superglobal('current_user')
	mut var_wp_admin_bar := rt.get_superglobal('wp_admin_bar')
	mut var_user_ID := rt.get_superglobal('user_ID')
	mut var_user_level := rt.get_superglobal('user_level')
	mut var_userdata := rt.get_superglobal('userdata')
	mut var_user_login := rt.get_superglobal('user_login')
	mut var_user_email := rt.get_superglobal('user_email')
	mut var_user_url := rt.get_superglobal('user_url')
	mut var_user_identity := rt.get_superglobal('user_identity')
	this.resetwoocommerceruntime()
	if rt.is_true(rt.new_bool(rt.instance_of(var_wp_styles, 'VHttpd_WordPress_WP_Styles'))) {
		this.resetdependencyruntime(mut rt.cast_object_ptr[Class_VHttpd_WordPress_object](var_wp_styles))
		this.setprivateproperty(mut rt.cast_object_ptr[Class_VHttpd_WordPress_object](var_wp_styles),
			'all_queued_deps', mut rt.cast_object_ptr[Class_VHttpd_WordPress_mixed](rt.new_null()))
	}
	if rt.is_true(rt.new_bool(rt.instance_of(var_wp_scripts, 'VHttpd_WordPress_WP_Scripts'))) {
		this.resetdependencyruntime(mut rt.cast_object_ptr[Class_VHttpd_WordPress_object](var_wp_scripts))
		this.setprivateproperty(mut rt.cast_object_ptr[Class_VHttpd_WordPress_object](var_wp_scripts),
			'all_queued_deps', mut rt.cast_object_ptr[Class_VHttpd_WordPress_mixed](rt.new_null()))
		this.setprivateproperty(mut rt.cast_object_ptr[Class_VHttpd_WordPress_object](var_wp_scripts),
			'dependents_map', mut rt.cast_object_ptr[Class_VHttpd_WordPress_mixed](rt.new_array()))
	}
	if !var_wp_script_modules.is_null()
		&& rt.is_true(rt.new_bool(rt.instance_of(var_wp_script_modules, 'VHttpd_WordPress_WP_Script_Modules'))) {
		this.setprivateproperty(mut rt.cast_object_ptr[Class_VHttpd_WordPress_object](var_wp_script_modules),
			'queue', mut rt.cast_object_ptr[Class_VHttpd_WordPress_mixed](rt.new_array()))
		this.setprivateproperty(mut rt.cast_object_ptr[Class_VHttpd_WordPress_object](var_wp_script_modules),
			'done', mut rt.cast_object_ptr[Class_VHttpd_WordPress_mixed](rt.new_array()))
		this.setprivateproperty(mut rt.cast_object_ptr[Class_VHttpd_WordPress_object](var_wp_script_modules),
			'dependents_map', mut rt.cast_object_ptr[Class_VHttpd_WordPress_mixed](rt.new_array()))
	}
	var_current_user = rt.new_null()
	var_user_ID = rt.new_int(0)
	var_user_level = rt.new_int(0)
	var_userdata = rt.new_null()
	var_user_login = rt.new_string('')
	var_user_email = rt.new_string('')
	var_user_url = rt.new_string('')
	var_user_identity = rt.new_string('')
	var_wp_admin_bar = rt.new_null()
	var_GLOBALS.array_unset(rt.new_string('show_admin_bar'))
	var_GLOBALS.array_set('vhttpd_wp_admin_bar_rendered', false)
	if rt.is_true(rt.call_function('function_exists', [rt.new_string('remove_action')])) {
		rt.call_function('remove_action', [rt.new_string('wp_body_open'),
			rt.new_string('wp_admin_bar_render'), rt.new_int(0)])
		rt.call_function('remove_action', [rt.new_string('wp_footer'),
			rt.new_string('wp_admin_bar_render'), rt.new_int(1000)])
	}
	if rt.is_true(rt.call_function('function_exists', [rt.new_string('add_action')])) {
		if rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('has_action', [
			rt.new_string('wp_body_open'),
			rt.create_array([
				rt.ArrayItem{
					key: none
					val: Class_VHttpd_WordPress_VHttpd_WordPress_Lifecycle.class()
				},
				rt.ArrayItem{ key: none, val: 'renderAdminBar' },
			]),
		])))
		{
			rt.call_function('add_action', [rt.new_string('wp_body_open'),
				rt.create_array([
					rt.ArrayItem{
						key: none
						val: Class_VHttpd_WordPress_VHttpd_WordPress_Lifecycle.class()
					},
					rt.ArrayItem{ key: none, val: 'renderAdminBar' },
				]),
				rt.new_int(0)])
		}
		if rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('has_action', [
			rt.new_string('wp_footer'),
			rt.create_array([
				rt.ArrayItem{
					key: none
					val: Class_VHttpd_WordPress_VHttpd_WordPress_Lifecycle.class()
				},
				rt.ArrayItem{ key: none, val: 'renderAdminBar' },
			]),
		])))
		{
			rt.call_function('add_action', [rt.new_string('wp_footer'),
				rt.create_array([
					rt.ArrayItem{
						key: none
						val: Class_VHttpd_WordPress_VHttpd_WordPress_Lifecycle.class()
					},
					rt.ArrayItem{ key: none, val: 'renderAdminBar' },
				]),
				rt.new_int(1000)])
		}
	}
	if rt.is_true(rt.call_function('function_exists', [
		rt.new_string('wp_cache_clear_local'),
	]))
	{
		rt.call_function('wp_cache_clear_local', []rt.PhpVal{})
	}
}

fn (mut this Class_VHttpd_WordPress_Lifecycle) preparewoocommerceruntime() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('WC')])))))
		|| !(rt.call_function('WC', []rt.PhpVal{}).is_object()) {
		return
	}
	mut var_woocommerce := rt.call_function('WC', []rt.PhpVal{})
	if rt.is_true(rt.call_function('function_exists', [
		rt.new_string('wp_get_current_user'),
	]))
	{
		rt.call_function('wp_get_current_user', []rt.PhpVal{})
	}
	if rt.is_true(rt.call_function('method_exists', [var_woocommerce.clone(),
		rt.new_string('initialize_session')]))
	{
		rt.call_method(var_woocommerce, 'initialize_session', []rt.PhpVal{})
	}
	if rt.is_true(rt.call_function('method_exists', [var_woocommerce.clone(),
		rt.new_string('initialize_cart')]))
	{
		rt.call_method(var_woocommerce, 'initialize_cart', []rt.PhpVal{})
	}
	if if !(rt.get_property(var_woocommerce, 'session')).is_null() { rt.get_property(var_woocommerce, 'session') } else { rt.new_null() }.is_object()
		&& rt.is_true(rt.call_function('method_exists', [rt.get_property(var_woocommerce, 'session'), rt.new_string('init_session_cookie')])) {
		rt.call_method(rt.get_property(var_woocommerce, 'session'), 'init_session_cookie',
			[]rt.PhpVal{})
	}
	if if !(rt.get_property(var_woocommerce, 'cart')).is_null() { rt.get_property(var_woocommerce, 'cart') } else { rt.new_null() }.is_object()
		&& if !(rt.get_property(rt.get_property(var_woocommerce, 'cart'), 'session')).is_null() { rt.get_property(rt.get_property(var_woocommerce, 'cart'), 'session') } else { rt.new_null() }.is_object()
		&& rt.is_true(rt.call_function('method_exists', [rt.get_property(rt.get_property(var_woocommerce, 'cart'), 'session'), rt.new_string('get_cart_from_session')])) {
		rt.call_method(rt.get_property(rt.get_property(var_woocommerce, 'cart'), 'session'),
			'get_cart_from_session', []rt.PhpVal{})
	} else if
		if !(rt.get_property(var_woocommerce, 'cart')).is_null() { rt.get_property(var_woocommerce, 'cart') } else { rt.new_null() }.is_object()
		&& rt.is_true(rt.call_function('method_exists', [rt.get_property(var_woocommerce, 'cart'), rt.new_string('get_cart_from_session')])) {
		rt.call_method(rt.get_property(var_woocommerce, 'cart'), 'get_cart_from_session',
			[]rt.PhpVal{})
	}
}

fn Class_VHttpd_WordPress_Lifecycle.renderadminbar() {
	mut var_wp_admin_bar := rt.new_null()
	mut var_GLOBALS := rt.new_null()
	if !(!rt.is_true(var_GLOBALS.array_get(rt.new_string('vhttpd_wp_admin_bar_rendered')))) {
		return
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('is_admin_bar_showing')])))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_admin_bar_showing', []rt.PhpVal{})))))
		|| !(var_wp_admin_bar.clone().is_object()) {
		return
	}
	rt.call_function('do_action_ref_array', [rt.new_string('admin_bar_menu'),
		rt.create_array([rt.ArrayItem{ key: none, val: var_wp_admin_bar }])])
	rt.call_function('do_action', [rt.new_string('wp_before_admin_bar_render')])
	rt.call_method(var_wp_admin_bar, 'render', []rt.PhpVal{})
	rt.call_function('do_action', [rt.new_string('wp_after_admin_bar_render')])
	var_GLOBALS.array_set('vhttpd_wp_admin_bar_rendered', true)
}

fn (mut this Class_VHttpd_WordPress_Lifecycle) normalizecookiestate(mut var_request Class_VHttpd_WordPress_array) rt.PhpVal {
	mut var_request_mutated := var_request
	mut var_headers := if if !(var_request_mutated.array_get(rt.new_string('headers'))).is_null() {
		var_request_mutated.array_get(rt.new_string('headers'))
	} else {
		rt.new_null()
	}.is_array()
	{ var_request_mutated.array_get(rt.new_string('headers'))
	 } else { rt.new_array()
	 }
	mut var_cookies := if if !(var_request_mutated.array_get(rt.new_string('cookies'))).is_null() {
		var_request_mutated.array_get(rt.new_string('cookies'))
	} else {
		rt.new_null()
	}.is_array()
	{ var_request_mutated.array_get(rt.new_string('cookies'))
	 } else { rt.new_array()
	 }
	mut var_cookieHeader :=
		rt.new_string(this.cookieheader(mut rt.cast_object_ptr[Class_VHttpd_WordPress_array](var_headers)))
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_cookieHeader, rt.new_string(''))))) {
		var_cookies = rt.call_function('array_merge', [var_cookies.clone(),
			this.parsecookieheader(var_cookieHeader.str())])
	}
	mut iter_2 := var_cookies.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_value := item_2.val
		mut var_name := item_2.key
		if rt.is_true(rt.new_bool(var_value.clone().is_string())) {
			var_cookies.array_set(var_name, rt.call_function('rawurldecode', [
				var_value.clone()]))
		}
	}
	var_request_mutated.array_set('headers', var_headers.clone())
	var_request_mutated.array_set('cookies', var_cookies.clone())
	var_request_mutated.array_set('cookie_header', var_cookieHeader.clone())
	return rt.new_object('VHttpd_WordPress_array', []string{}, var_request_mutated)
}

fn (mut this Class_VHttpd_WordPress_Lifecycle) cookieheader(mut var_headers Class_VHttpd_WordPress_array) string {
	mut var_headers_mutated := var_headers
	mut iter_3 := rt.create_array([rt.ArrayItem{ key: none, val: 'cookie' },
		rt.ArrayItem{ key: none, val: 'Cookie' }, rt.ArrayItem{ key: none, val: 'COOKIE' },
		rt.ArrayItem{ key: none, val: 'http_cookie' }, rt.ArrayItem{ key: none, val: 'HTTP_COOKIE' }]).iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_name := item_3.val
		mut var_value := if !(var_headers_mutated.array_get(var_name)).is_null() {
			var_headers_mutated.array_get(var_name)
		} else {
			rt.new_string('')
		}
		if rt.is_true(rt.new_bool(var_value.clone().is_array())) {
			var_value = rt.call_function('implode', [rt.new_string('; '),
				var_value.clone()])
		}
		if var_value.clone().is_string()
			&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_value, rt.new_string(''))))) {
			return var_value.str()
		}
	}
	return ''
}

fn (mut this Class_VHttpd_WordPress_Lifecycle) requestscheme(mut var_headers Class_VHttpd_WordPress_array, fallback string) string {
	mut var_headers_mutated := var_headers
	mut iter_4 := rt.create_array([rt.ArrayItem{ key: none, val: 'x-forwarded-proto' },
		rt.ArrayItem{ key: none, val: 'X-Forwarded-Proto' }, rt.ArrayItem{
			key: none
			val: 'HTTP_X_FORWARDED_PROTO'
		}, rt.ArrayItem{ key: none, val: 'x-scheme' }, rt.ArrayItem{ key: none, val: 'X-Scheme' }]).iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_name := item_4.val
		mut var_value := if !(var_headers_mutated.array_get(var_name)).is_null() {
			var_headers_mutated.array_get(var_name)
		} else {
			rt.new_string('')
		}
		if rt.is_true(rt.new_bool(var_value.clone().is_array())) {
			var_value = rt.call_function('reset', [var_value.clone()])
		}
		if var_value.clone().is_string()
			&& rt.is_true(rt.identical(rt.new_string(var_value.clone().to_string().trim_space().to_lower()), rt.new_string('https'))) {
			return 'https'
		}
	}
	return if rt.is_true(rt.identical(rt.new_string(fallback.trim_space().to_lower()),
		rt.new_string('https')))
	{
		'https'
	} else {
		'http'
	}
}

fn (mut this Class_VHttpd_WordPress_Lifecycle) bootstrapscheme() string {
	mut iter_5 := rt.create_array([rt.ArrayItem{ key: none, val: 'VHTTPD_SCHEME' },
		rt.ArrayItem{ key: none, val: 'VHTTPD_REQUEST_SCHEME' },
		rt.ArrayItem{ key: none, val: 'REQUEST_SCHEME' }, rt.ArrayItem{
			key: none
			val: 'HTTP_X_FORWARDED_PROTO'
		}]).iterator()
	for {
		item_5 := iter_5.next() or { break }
		mut var_name := item_5.val
		mut var_value := rt.call_function('getenv', [var_name.clone()])
		if var_value.clone().is_string()
			&& rt.is_true(rt.identical(rt.new_string(var_value.clone().to_string().trim_space().to_lower()), rt.new_string('https'))) {
			return 'https'
		}
	}
	return 'http'
}

fn (mut this Class_VHttpd_WordPress_Lifecycle) requesttraceid(mut var_payload Class_VHttpd_WordPress_array) string {
	mut var_payload_mutated := var_payload
	mut var_headers := if if !(var_payload_mutated.array_get(rt.new_string('headers'))).is_null() {
		var_payload_mutated.array_get(rt.new_string('headers'))
	} else {
		rt.new_null()
	}.is_array()
	{ var_payload_mutated.array_get(rt.new_string('headers'))
	 } else { rt.new_array()
	 }
	mut var_traceId := rt.new_string(this.headervalue(mut rt.cast_object_ptr[Class_VHttpd_WordPress_array](var_headers), mut rt.cast_object_ptr[Class_VHttpd_WordPress_array](rt.create_array([
		rt.ArrayItem{ key: none, val: 'x-vhttpd-trace-id' },
		rt.ArrayItem{ key: none, val: 'X-Vhttpd-Trace-Id' },
		rt.ArrayItem{ key: none, val: 'X-VHTTPD-TRACE-ID' },
		rt.ArrayItem{ key: none, val: 'HTTP_X_VHTTPD_TRACE_ID' },
	]))))
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_traceId, rt.new_string(''))))) {
		return var_traceId.str()
	}
	return (if !(var_payload_mutated.array_get(rt.new_string('trace_id'))).is_null() {
		var_payload_mutated.array_get(rt.new_string('trace_id'))
	} else {
		if !(var_payload_mutated.array_get(rt.new_string('id'))).is_null() {
			var_payload_mutated.array_get(rt.new_string('id'))
		} else {
			rt.new_string('')
		}
	}).str()
}

fn (mut this Class_VHttpd_WordPress_Lifecycle) requestrequestid(mut var_payload Class_VHttpd_WordPress_array) string {
	mut var_payload_mutated := var_payload
	mut var_headers := if if !(var_payload_mutated.array_get(rt.new_string('headers'))).is_null() {
		var_payload_mutated.array_get(rt.new_string('headers'))
	} else {
		rt.new_null()
	}.is_array()
	{ var_payload_mutated.array_get(rt.new_string('headers'))
	 } else { rt.new_array()
	 }
	mut var_requestId := rt.new_string(this.headervalue(mut rt.cast_object_ptr[Class_VHttpd_WordPress_array](var_headers), mut rt.cast_object_ptr[Class_VHttpd_WordPress_array](rt.create_array([
		rt.ArrayItem{ key: none, val: 'x-request-id' },
		rt.ArrayItem{ key: none, val: 'X-Request-Id' },
		rt.ArrayItem{ key: none, val: 'HTTP_X_REQUEST_ID' },
	]))))
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_requestId, rt.new_string(''))))) {
		return var_requestId.str()
	}
	return (if !(var_payload_mutated.array_get(rt.new_string('request_id'))).is_null() {
		var_payload_mutated.array_get(rt.new_string('request_id'))
	} else {
		rt.new_string('')
	}).str()
}

fn (mut this Class_VHttpd_WordPress_Lifecycle) headervalue(mut var_headers Class_VHttpd_WordPress_array, mut var_names Class_VHttpd_WordPress_array) string {
	mut var_headers_mutated := var_headers
	mut iter_6 := var_names.iterator()
	for {
		item_6 := iter_6.next() or { break }
		mut var_name := item_6.val
		mut var_value := if !(var_headers_mutated.array_get(var_name)).is_null() {
			var_headers_mutated.array_get(var_name)
		} else {
			rt.new_string('')
		}
		if rt.is_true(rt.new_bool(var_value.clone().is_array())) {
			var_value = rt.call_function('reset', [var_value.clone()])
		}
		if var_value.clone().is_string()
			&& rt.is_true(rt.new_bool(var_value.clone().to_string().trim_space() != '')) {
			return var_value.clone().to_string().trim_space()
		}
	}
	return ''
}

fn (mut this Class_VHttpd_WordPress_Lifecycle) parsecookieheader(header string) rt.PhpVal {
	mut var_value := rt.new_null()
	mut var_cookies := rt.new_array()
	mut iter_7 := rt.call_function('explode', [rt.new_string(';'),
		rt.new_string(header)]).iterator()
	for {
		item_7 := iter_7.next() or { break }
		mut var_part := item_7.val
		var_part = rt.new_string(var_part.clone().to_string().trim_space())
		if rt.is_true(rt.identical(var_part, rt.new_string('')))
			|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('str_contains', [var_part.clone(), rt.new_string('=')]))))) {
			continue
		}
		mut list_tmp_2 := rt.call_function('explode', [rt.new_string('='),
			var_part.clone(), rt.new_int(2)])
		mut var_name := list_tmp_2.array_get(0)
		var_value = list_tmp_2.array_get(1)
		var_name = rt.new_string(var_name.clone().to_string().trim_space())
		if rt.is_true(rt.identical(var_name, rt.new_string(''))) {
			continue
		}
		var_cookies.array_set(var_name, var_value.clone())
	}
	return var_cookies.clone()
}

fn (mut this Class_VHttpd_WordPress_Lifecycle) hostheader(host string, port string) string {
	mut host_mutated := host
	mut port_mutated := port
	mut var_hostHeader := rt.new_string((if rt.is_true(rt.new_bool(host_mutated != '')) {
		host_mutated
	} else {
		'localhost'
	}).str())
	if rt.is_true(rt.new_bool(port_mutated != '')) && rt.is_true(rt.new_bool(port_mutated != '80'))
		&& rt.is_true(rt.new_bool(port_mutated != '443')) {
		var_hostHeader = rt.concat(var_hostHeader, rt.new_string(':' + port_mutated))
	}
	return var_hostHeader.str()
}

fn (mut this Class_VHttpd_WordPress_Lifecycle) resetdependencyruntime(mut var_deps Class_VHttpd_WordPress_object) {
	mut var_deps_mutated := var_deps
	mut iter_8 := rt.create_array([rt.ArrayItem{ key: none, val: 'queue' },
		rt.ArrayItem{ key: none, val: 'to_do' }, rt.ArrayItem{ key: none, val: 'done' },
		rt.ArrayItem{ key: none, val: 'args' }, rt.ArrayItem{ key: none, val: 'groups' }]).iterator()
	for {
		item_8 := iter_8.next() or { break }
		mut var_property := item_8.val
		if rt.is_true(rt.call_function('property_exists', [var_deps_mutated, var_property.clone()])) {
			rt.set_property(var_deps_mutated,
				'{"nodeType":"Expr_Variable","line":437,"name":"property"}', rt.new_array())
		}
	}
	mut iter_9 := rt.create_array([rt.ArrayItem{ key: none, val: 'concat' },
		rt.ArrayItem{ key: none, val: 'concat_version' }, rt.ArrayItem{ key: none, val: 'print_html' },
		rt.ArrayItem{ key: none, val: 'print_code' }, rt.ArrayItem{ key: none, val: 'ext_handles' },
		rt.ArrayItem{ key: none, val: 'ext_version' }]).iterator()
	for {
		item_9 := iter_9.next() or { break }
		mut var_property := item_9.val
		if rt.is_true(rt.call_function('property_exists', [var_deps_mutated, var_property.clone()])) {
			rt.set_property(var_deps_mutated,
				'{"nodeType":"Expr_Variable","line":442,"name":"property"}', rt.new_string(''))
		}
	}
	if rt.is_true(rt.call_function('property_exists',
		[var_deps_mutated, rt.new_string('do_concat')]))
	{
		rt.set_property(var_deps_mutated, 'do_concat', rt.new_bool(false))
	}
	if rt.is_true(rt.call_function('property_exists',
		[var_deps_mutated, rt.new_string('in_footer')]))
	{
		rt.set_property(var_deps_mutated, 'in_footer', rt.new_array())
	}
}

fn (mut this Class_VHttpd_WordPress_Lifecycle) refreshdependencyurls(scheme string) {
	mut var_wp_styles := rt.new_null()
	mut var_wp_scripts := rt.new_null()
	mut scheme_mutated := scheme
	mut var_baseUrl := if rt.is_true(rt.call_function('function_exists', [
		rt.new_string('site_url'),
	]))
	{
		rt.call_function('site_url', [rt.new_string(''), rt.new_string(scheme_mutated).clone()])
	} else {
		rt.new_string('')
	}
	mut var_contentUrl := if rt.is_true(rt.call_function('function_exists', [
		rt.new_string('content_url'),
	]))
	{ rt.call_function('content_url', []rt.PhpVal{}) } else { rt.new_string('') }
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_contentUrl, rt.new_string('')))))
		&& rt.is_true(rt.call_function('function_exists', [rt.new_string('set_url_scheme')])) {
		var_contentUrl = rt.call_function('set_url_scheme', [
			var_contentUrl.clone(), rt.new_string(scheme_mutated).clone()])
	}
	mut iter_10 := rt.create_array([
		rt.ArrayItem{
			key: none
			val: if !var_wp_styles.is_null() { var_wp_styles } else { rt.new_null() }
		},
		rt.ArrayItem{
			key: none
			val: if !var_wp_scripts.is_null() { var_wp_scripts } else { rt.new_null() }
		},
	]).iterator()
	for {
		item_10 := iter_10.next() or { break }
		mut var_deps := item_10.val
		if !(var_deps.clone().is_object()) {
			continue
		}
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_baseUrl, rt.new_string('')))))
			&& rt.is_true(rt.call_function('property_exists', [var_deps.clone(), rt.new_string('base_url')])) {
			rt.set_property(var_deps, 'base_url', var_baseUrl.clone())
		}
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_contentUrl, rt.new_string('')))))
			&& rt.is_true(rt.call_function('property_exists', [var_deps.clone(), rt.new_string('content_url')])) {
			rt.set_property(var_deps, 'content_url', var_contentUrl.clone())
		}
		if rt.is_true(rt.call_function('property_exists', [var_deps.clone(), rt.new_string('registered')]))
			&& rt.get_property(var_deps, 'registered').is_array()
			&& rt.is_true(rt.call_function('function_exists', [rt.new_string('set_url_scheme')])) {
			mut iter_11 := rt.get_property(var_deps, 'registered').iterator()
			for {
				item_11 := iter_11.next() or { break }
				mut var_handle := item_11.val
				if var_handle.clone().is_object()
					&& rt.is_true(rt.call_function('property_exists', [var_handle.clone(), rt.new_string('src')]))
					&& rt.get_property(var_handle, 'src').is_string()
					&& rt.is_true(rt.identical(rt.call_function('preg_match', [rt.new_string('#^https?://#i'), rt.get_property(var_handle, 'src')]), rt.new_int(1))) {
					rt.set_property(var_handle, 'src', rt.call_function('set_url_scheme', [
						rt.get_property(var_handle, 'src'),
						rt.new_string(scheme_mutated).clone(),
					]))
				}
			}
		}
	}
}

fn (mut this Class_VHttpd_WordPress_Lifecycle) resetwoocommerceruntime() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('WC')])))))
		|| !(rt.call_function('WC', []rt.PhpVal{}).is_object()) {
		return
	}
	mut var_woocommerce := rt.call_function('WC', []rt.PhpVal{})
	mut var_session := if !(rt.get_property(var_woocommerce, 'session')).is_null() {
		rt.get_property(var_woocommerce, 'session')
	} else {
		rt.new_null()
	}
	if rt.is_true(rt.new_bool(var_session.clone().is_object())) {
		rt.call_function('remove_action', [rt.new_string('woocommerce_set_cart_cookies'),
			rt.create_array([rt.ArrayItem{ key: none, val: var_session },
				rt.ArrayItem{ key: none, val: 'set_customer_session_cookie' }]),
			rt.new_int(10)])
		rt.call_function('remove_action', [rt.new_string('wp'),
			rt.create_array([rt.ArrayItem{ key: none, val: var_session },
				rt.ArrayItem{ key: none, val: 'maybe_set_customer_session_cookie' }]),
			rt.new_int(99)])
		rt.call_function('remove_action', [rt.new_string('template_redirect'),
			rt.create_array([rt.ArrayItem{ key: none, val: var_session },
				rt.ArrayItem{ key: none, val: 'destroy_session_if_empty' }]),
			rt.new_int(999)])
		rt.call_function('remove_action', [rt.new_string('shutdown'),
			rt.create_array([rt.ArrayItem{ key: none, val: var_session },
				rt.ArrayItem{ key: none, val: 'save_data' }]),
			rt.new_int(20)])
		rt.call_function('remove_action', [rt.new_string('wp_logout'),
			rt.create_array([rt.ArrayItem{ key: none, val: var_session },
				rt.ArrayItem{ key: none, val: 'destroy_session' }])])
		rt.call_function('remove_filter', [rt.new_string('nonce_user_logged_out'),
			rt.create_array([rt.ArrayItem{ key: none, val: var_session },
				rt.ArrayItem{ key: none, val: 'maybe_update_nonce_user_logged_out' }]),
			rt.new_int(10)])
	}
	mut var_cart := if !(rt.get_property(var_woocommerce, 'cart')).is_null() {
		rt.get_property(var_woocommerce, 'cart')
	} else {
		rt.new_null()
	}
	if rt.is_true(rt.new_bool(var_cart.clone().is_object())) {
		rt.call_function('remove_action', [rt.new_string('woocommerce_add_to_cart'),
			rt.create_array([rt.ArrayItem{ key: none, val: var_cart },
				rt.ArrayItem{ key: none, val: 'calculate_totals' }]),
			rt.new_int(20)])
		rt.call_function('remove_action', [rt.new_string('woocommerce_applied_coupon'),
			rt.create_array([rt.ArrayItem{ key: none, val: var_cart },
				rt.ArrayItem{ key: none, val: 'calculate_totals' }]),
			rt.new_int(20)])
		rt.call_function('remove_action', [rt.new_string('woocommerce_removed_coupon'),
			rt.create_array([rt.ArrayItem{ key: none, val: var_cart },
				rt.ArrayItem{ key: none, val: 'calculate_totals' }]),
			rt.new_int(20)])
		rt.call_function('remove_action', [
			rt.new_string('woocommerce_cart_item_removed'),
			rt.create_array([rt.ArrayItem{ key: none, val: var_cart },
				rt.ArrayItem{ key: none, val: 'calculate_totals' }]),
			rt.new_int(20),
		])
		rt.call_function('remove_action', [
			rt.new_string('woocommerce_cart_item_restored'),
			rt.create_array([rt.ArrayItem{ key: none, val: var_cart },
				rt.ArrayItem{ key: none, val: 'calculate_totals' }]),
			rt.new_int(20),
		])
		rt.call_function('remove_action', [rt.new_string('woocommerce_check_cart_items'),
			rt.create_array([rt.ArrayItem{ key: none, val: var_cart },
				rt.ArrayItem{ key: none, val: 'check_cart_items' }]),
			rt.new_int(1)])
		rt.call_function('remove_action', [rt.new_string('woocommerce_check_cart_items'),
			rt.create_array([rt.ArrayItem{ key: none, val: var_cart },
				rt.ArrayItem{ key: none, val: 'check_cart_coupons' }]),
			rt.new_int(1)])
		rt.call_function('remove_action', [
			rt.new_string('woocommerce_after_checkout_validation'),
			rt.create_array([rt.ArrayItem{ key: none, val: var_cart },
				rt.ArrayItem{ key: none, val: 'check_customer_coupons' }]),
			rt.new_int(1),
		])
		mut var_cartSession := if !(rt.get_property(var_cart, 'session')).is_null() {
			rt.get_property(var_cart, 'session')
		} else {
			rt.new_null()
		}
		if rt.is_true(rt.new_bool(var_cartSession.clone().is_object())) {
			rt.call_function('remove_action', [rt.new_string('wp_loaded'),
				rt.create_array([rt.ArrayItem{ key: none, val: var_cartSession },
					rt.ArrayItem{ key: none, val: 'get_cart_from_session' }])])
			rt.call_function('remove_action', [rt.new_string('woocommerce_cart_emptied'),
				rt.create_array([rt.ArrayItem{ key: none, val: var_cartSession },
					rt.ArrayItem{ key: none, val: 'destroy_cart_session' }])])
			rt.call_function('remove_action', [
				rt.new_string('woocommerce_after_calculate_totals'),
				rt.create_array([rt.ArrayItem{ key: none, val: var_cartSession },
					rt.ArrayItem{ key: none, val: 'set_session' }]),
				rt.new_int(1000),
			])
			rt.call_function('remove_action', [
				rt.new_string('woocommerce_removed_coupon'),
				rt.create_array([rt.ArrayItem{ key: none, val: var_cartSession },
					rt.ArrayItem{ key: none, val: 'set_session' }]),
			])
			rt.call_function('remove_action', [rt.new_string('woocommerce_add_to_cart'),
				rt.create_array([rt.ArrayItem{ key: none, val: var_cartSession },
					rt.ArrayItem{ key: none, val: 'persistent_cart_update' }])])
			rt.call_function('remove_action', [
				rt.new_string('woocommerce_cart_item_removed'),
				rt.create_array([rt.ArrayItem{ key: none, val: var_cartSession },
					rt.ArrayItem{ key: none, val: 'persistent_cart_update' }]),
			])
			rt.call_function('remove_action', [
				rt.new_string('woocommerce_cart_item_restored'),
				rt.create_array([rt.ArrayItem{ key: none, val: var_cartSession },
					rt.ArrayItem{ key: none, val: 'persistent_cart_update' }]),
			])
			rt.call_function('remove_action', [
				rt.new_string('woocommerce_cart_item_set_quantity'),
				rt.create_array([rt.ArrayItem{ key: none, val: var_cartSession },
					rt.ArrayItem{ key: none, val: 'persistent_cart_update' }]),
			])
			rt.call_function('remove_action', [rt.new_string('woocommerce_add_to_cart'),
				rt.create_array([rt.ArrayItem{ key: none, val: var_cartSession },
					rt.ArrayItem{ key: none, val: 'maybe_set_cart_cookies' }])])
			rt.call_function('remove_action', [rt.new_string('wp'),
				rt.create_array([rt.ArrayItem{ key: none, val: var_cartSession },
					rt.ArrayItem{ key: none, val: 'maybe_set_cart_cookies' }]),
				rt.new_int(99)])
			rt.call_function('remove_action', [rt.new_string('shutdown'),
				rt.create_array([rt.ArrayItem{ key: none, val: var_cartSession },
					rt.ArrayItem{ key: none, val: 'maybe_set_cart_cookies' }]),
				rt.new_int(0)])
			rt.call_function('remove_action', [rt.new_string('template_redirect'),
				rt.create_array([rt.ArrayItem{ key: none, val: var_cartSession },
					rt.ArrayItem{ key: none, val: 'clean_up_removed_cart_contents' }])])
		}
	}
	mut var_customer := if !(rt.get_property(var_woocommerce, 'customer')).is_null() {
		rt.get_property(var_woocommerce, 'customer')
	} else {
		rt.new_null()
	}
	if rt.is_true(rt.new_bool(var_customer.clone().is_object())) {
		rt.call_function('remove_action', [rt.new_string('shutdown'),
			rt.create_array([rt.ArrayItem{ key: none, val: var_customer },
				rt.ArrayItem{ key: none, val: 'save' }]),
			rt.new_int(10)])
	}
	rt.set_property(var_woocommerce, 'session', rt.new_null())
	rt.set_property(var_woocommerce, 'cart', rt.new_null())
	rt.set_property(var_woocommerce, 'customer', rt.new_null())
}

fn (mut this Class_VHttpd_WordPress_Lifecycle) setprivateproperty(mut var_object Class_VHttpd_WordPress_object, property string, mut var_value Class_VHttpd_WordPress_mixed) {
	mut var_value_mutated := var_value
	mut var_reflection := create_reflectionobject(var_object)
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_reflection.hasproperty(rt.new_string(property)))))) {
		return
	}
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	mut var_refProperty := var_reflection.getproperty(rt.new_string(property))
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	rt.call_method(var_refProperty, 'setValue', [var_object, var_value_mutated])
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	unsafe {
		goto end_label_1
	}
	catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'Throwable') {
		unsafe {
			goto end_label_1
		}
	} else {
		rt.throw_exception(var_e_1)
		unsafe {
			goto end_label_1
		}
	}

	end_label_1:
}

fn (mut this Class_VHttpd_WordPress_Lifecycle) finalizeresponse(mut var_request Class_VHttpd_WordPress_array, mut var_response Class_VHttpd_WordPress_array) rt.PhpVal {
	mut var_request_mutated := var_request
	mut var_response_mutated := var_response
	var_response_mutated = this.attachwoocommercecookies(mut var_response_mutated)
	mut var_originalMethod := rt.new_string((if !(var_request_mutated.array_get(rt.new_string('original_method'))).is_null() {
		var_request_mutated.array_get(rt.new_string('original_method'))
	} else {
		if !(var_request_mutated.array_get(rt.new_string('method'))).is_null() {
			var_request_mutated.array_get(rt.new_string('method'))
		} else {
			rt.new_string('GET')
		}
	}).str().to_upper())
	if rt.is_true(rt.identical(var_originalMethod, rt.new_string('HEAD'))) {
		var_response_mutated.array_set('body', '')
	}
	return rt.new_object('VHttpd_WordPress_array', []string{}, var_response_mutated)
}

fn (mut this Class_VHttpd_WordPress_Lifecycle) attachwoocommercecookies(mut var_response Class_VHttpd_WordPress_array) rt.PhpVal {
	mut var_response_mutated := var_response
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('WC')])))))
		|| !(rt.call_function('WC', []rt.PhpVal{}).is_object()) {
		return rt.new_object('VHttpd_WordPress_array', []string{}, var_response_mutated)
	}
	mut var_headers := if if !(var_response_mutated.array_get(rt.new_string('headers'))).is_null() {
		var_response_mutated.array_get(rt.new_string('headers'))
	} else {
		rt.new_null()
	}.is_array()
	{ var_response_mutated.array_get(rt.new_string('headers'))
	 } else { rt.new_array()
	 }
	mut var_sessionCookie := rt.new_string(this.woocommercesessioncookieheader())
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_sessionCookie, rt.new_string(''))))) {
		this.appendheader(mut rt.cast_object_ptr[Class_VHttpd_WordPress_array](var_headers),
			'set-cookie', var_sessionCookie.str())
	}
	mut iter_12 := this.woocommercecartcookieheaders().iterator()
	for {
		item_12 := iter_12.next() or { break }
		mut var_cookie := item_12.val
		this.appendheader(mut rt.cast_object_ptr[Class_VHttpd_WordPress_array](var_headers),
			'set-cookie', var_cookie.str())
	}
	var_response_mutated.array_set('headers', var_headers.clone())
	return rt.new_object('VHttpd_WordPress_array', []string{}, var_response_mutated)
}

fn (mut this Class_VHttpd_WordPress_Lifecycle) woocommercesessioncookieheader() string {
	mut var_session := if !(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'session')).is_null() {
		rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'session')
	} else {
		rt.new_null()
	}
	if !(var_session.clone().is_object())
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('method_exists', [var_session.clone(), rt.new_string('get_customer_id')]))))) {
		return ''
	}
	mut var_customerId := rt.new_string((rt.call_method(var_session, 'get_customer_id',
		[]rt.PhpVal{})).str())
	mut var_expiration := rt.new_int((this.objectproperty(mut rt.cast_object_ptr[Class_VHttpd_WordPress_object](var_session),
		'_session_expiration', mut 0)).to_i64())
	mut var_expiring := rt.new_int((this.objectproperty(mut rt.cast_object_ptr[Class_VHttpd_WordPress_object](var_session),
		'_session_expiring', mut 0)).to_i64())
	if rt.is_true(rt.identical(var_customerId, rt.new_string('')))
		|| rt.is_true(rt.less_equal(var_expiration, rt.new_int(0)))
		|| rt.is_true(rt.less_equal(var_expiring, rt.new_int(0))) {
		return ''
	}
	mut var_cookieName := rt.new_string((if rt.is_true(rt.call_function('function_exists', [rt.new_string('apply_filters')])) && rt.is_true(rt.call_function('defined', [rt.new_string('COOKIEHASH')])) { (rt.call_function('apply_filters', [
			rt.new_string('woocommerce_cookie'),
			rt.new_string('wp_woocommerce_session_' + (rt.get_constant('COOKIEHASH')).str()),
		])).str() } else { 'wp_woocommerce_session' }).str())
	mut var_hash := if rt.is_true(rt.call_function('function_exists', [
		rt.new_string('wp_fast_hash'),
	]))
	{
		rt.call_function('wp_fast_hash', [
			rt.new_string(var_customerId.str() + '|' + var_expiration.str()),
		])
	} else {
		if rt.is_true(rt.call_function('function_exists', [rt.new_string('wp_hash')])) { rt.call_function('hash_hmac', [
				rt.new_string('md5'),
				rt.new_string(var_customerId.str() + '|' + var_expiration.str()),
				rt.call_function('wp_hash', [
					rt.new_string(var_customerId.str() + '|' + var_expiration.str()),
				]),
			]) } else { rt.call_function('hash_hmac', [rt.new_string('md5'),
				rt.new_string(var_customerId.str() + '|' + var_expiration.str()),
				rt.new_string('vhttpd')]) }
	}
	mut var_value := rt.new_string(var_customerId.str() + '|' + var_expiration.str() + '|' +
		var_expiring.str() + '|' + var_hash.str())
	mut var_secure := if rt.is_true(rt.call_function('function_exists', [rt.new_string('wc_site_is_https')])) && rt.is_true(rt.call_function('function_exists', [rt.new_string('is_ssl')])) { rt.new_bool(rt.is_true(rt.call_function('wc_site_is_https', []rt.PhpVal{})) && rt.is_true(rt.call_function('is_ssl', []rt.PhpVal{}))) } else { rt.identical((if !(rt.get_superglobal('_SERVER').array_get(rt.new_string('HTTPS'))).is_null() {
			rt.get_superglobal('_SERVER').array_get(rt.new_string('HTTPS'))
		} else {
			rt.new_string('')
		}).str(), rt.new_string('on'))
	 }
	mut var_httpOnly := rt.new_bool(if rt.is_true(rt.call_function('function_exists', [
		rt.new_string('apply_filters'),
	]))
	{ (rt.call_function('apply_filters', [rt.new_string('woocommerce_cookie_httponly'),
			rt.new_bool(true), var_cookieName.clone(), var_value.clone(),
			var_expiration.clone(), var_secure.clone()])).to_bool() } else { true })
	return this.buildcookieheader(var_cookieName.str(), var_value.str(), var_expiration.to_i64(),
		var_secure.to_bool(), var_httpOnly.to_bool())
}

fn (mut this Class_VHttpd_WordPress_Lifecycle) woocommercecartcookieheaders() rt.PhpVal {
	mut var_cart := if !(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'cart')).is_null() {
		rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'cart')
	} else {
		rt.new_null()
	}
	if !(var_cart.clone().is_object())
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('method_exists', [var_cart.clone(), rt.new_string('get_cart_hash')]))))) {
		return rt.new_array()
	}
	mut var_secure := if rt.is_true(rt.call_function('function_exists', [rt.new_string('wc_site_is_https')])) && rt.is_true(rt.call_function('function_exists', [rt.new_string('is_ssl')])) { rt.new_bool(rt.is_true(rt.call_function('wc_site_is_https', []rt.PhpVal{})) && rt.is_true(rt.call_function('is_ssl', []rt.PhpVal{}))) } else { rt.identical((if !(rt.get_superglobal('_SERVER').array_get(rt.new_string('HTTPS'))).is_null() {
			rt.get_superglobal('_SERVER').array_get(rt.new_string('HTTPS'))
		} else {
			rt.new_string('')
		}).str(), rt.new_string('on'))
	 }
	mut var_isEmpty := rt.new_bool(if rt.is_true(rt.call_function('method_exists', [
		var_cart.clone(),
		rt.new_string('is_empty'),
	]))
	{ (rt.call_method(var_cart, 'is_empty', []rt.PhpVal{})).to_bool() } else { false })
	if rt.is_true(var_isEmpty) {
		mut var_expired := rt.sub(rt.call_function('time', []rt.PhpVal{}), rt.new_int(3600))
		return rt.create_array([
			rt.ArrayItem{ key: none, val: this.buildcookieheader('woocommerce_items_in_cart', '0',
				var_expired.to_i64(), var_secure.to_bool(), false) },
			rt.ArrayItem{ key: none, val: this.buildcookieheader('woocommerce_cart_hash', '',
				var_expired.to_i64(), var_secure.to_bool(), false) },
		])
	}
	return rt.create_array([
		rt.ArrayItem{ key: none, val: this.buildcookieheader('woocommerce_items_in_cart', '1', 0,
			var_secure.to_bool(), false) },
		rt.ArrayItem{ key: none, val: this.buildcookieheader('woocommerce_cart_hash', (rt.call_method(var_cart,
			'get_cart_hash', []rt.PhpVal{})).str(), 0, var_secure.to_bool(), false) },
	])
}

fn (mut this Class_VHttpd_WordPress_Lifecycle) buildcookieheader(name string, value string, expires i64, secure bool, httpOnly bool) string {
	mut name_mutated := name
	mut value_mutated := value
	mut secure_mutated := secure
	mut httpOnly_mutated := httpOnly
	mut var_parts := rt.create_array([
		rt.ArrayItem{ key: none, val: name_mutated + '=' +
			(rt.call_function('rawurlencode', [rt.new_string(value_mutated).clone()])).str() },
	])
	if expires > 0 {
		var_parts.array_push('expires=' +
			(rt.call_function('gmdate', [rt.new_string('D, d M Y H:i:s'), rt.new_int(expires)])).str() +
			' GMT')
		var_parts.array_push('Max-Age=' +(rt.call_function('max', [rt.new_int(0), rt.sub(rt.new_int(expires), rt.call_function('time', []rt.PhpVal{}))])).str())
	}
	mut var_path := if rt.is_true(rt.call_function('defined', [rt.new_string('COOKIEPATH')]))
		&& rt.is_true(rt.get_constant('COOKIEPATH')) {
		rt.get_constant('COOKIEPATH')
	} else {
		rt.new_string('/')
	}
	var_parts.array_push('path=' + var_path.str())
	if rt.is_true(rt.call_function('defined', [rt.new_string('COOKIE_DOMAIN')]))
		&& rt.is_true(rt.get_constant('COOKIE_DOMAIN')) {
		var_parts.array_push('domain=' + (rt.get_constant('COOKIE_DOMAIN')).str())
	}
	if rt.is_true(rt.new_bool(secure_mutated)) {
		var_parts.array_push('Secure')
	}
	if rt.is_true(rt.new_bool(httpOnly_mutated)) {
		var_parts.array_push('HttpOnly')
	}
	return (rt.call_function('implode', [rt.new_string('; '),
		var_parts.clone()])).str()
}

fn (mut this Class_VHttpd_WordPress_Lifecycle) appendheader(mut var_headers Class_VHttpd_WordPress_array, name string, value string) {
	mut var_headers_mutated := var_headers
	mut name_mutated := name
	mut value_mutated := value
	mut iter_13 := rt.func_array_keys(var_headers_mutated).iterator()
	for {
		item_13 := iter_13.next() or { break }
		mut var_key := item_13.val
		if rt.is_true(rt.identical(rt.new_string(var_key.str().to_lower()),
			rt.new_string(name_mutated.to_lower())))
		{
			var_headers_mutated.array_set(var_key,

				(var_headers_mutated.array_get(var_key)).str() + '\n' + value_mutated)
			return
		}
	}
	var_headers_mutated.array_set(name_mutated, value_mutated)
}

fn (mut this Class_VHttpd_WordPress_Lifecycle) objectproperty(mut var_object Class_VHttpd_WordPress_object, property string, mut var_default Class_VHttpd_WordPress_mixed) rt.PhpVal {
	mut var_reflection := create_reflectionobject(var_object)
	if rt.has_exception() {
		unsafe {
			goto catch_label_2
		}
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_reflection.hasproperty(rt.new_string(property)))))) {
		return rt.new_object('VHttpd_WordPress_mixed', []string{}, var_default)
	}
	if rt.has_exception() {
		unsafe {
			goto catch_label_2
		}
	}
	return rt.call_method(var_reflection.getproperty(rt.new_string(property)), 'getValue', [
		var_object,
	])
	unsafe {
		goto end_label_2
	}
	catch_label_2:
	mut var_e_2 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_2, 'Throwable') {
		return rt.new_object('VHttpd_WordPress_mixed', []string{}, var_default)
		unsafe {
			goto end_label_2
		}
	} else {
		rt.throw_exception(var_e_2)
		unsafe {
			goto end_label_2
		}
	}

	end_label_2:
	return rt.new_null()
}

struct Class_RuntimeException {
	rt.PhpObjectBase
}

struct Class_ReflectionObject {
	rt.PhpObjectBase
}

fn create_vhttpd_wordpress_lifecycle(_args ...rt.PhpVal) &Class_VHttpd_WordPress_Lifecycle {
	mut obj := &Class_VHttpd_WordPress_Lifecycle{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_runtimeexception(_args ...rt.PhpVal) &Class_RuntimeException {
	mut obj := &Class_RuntimeException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_reflectionobject(_args ...rt.PhpVal) &Class_ReflectionObject {
	mut obj := &Class_ReflectionObject{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_VHttpd_WordPress_Lifecycle) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'rootFromEnv' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(this.rootfromenv(dispatch_arg_0))
		}
		'wpLoadPath' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(this.wploadpath(dispatch_arg_0))
		}
		'isInstalled' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(this.isinstalled(dispatch_arg_0))
		}
		'bootstrap' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			this.bootstrap(dispatch_arg_0)
			return rt.new_null()
		}
		'bootstrapIfInstalled' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(this.bootstrapifinstalled(dispatch_arg_0))
		}
		'normalizeRequest' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_VHttpd_WordPress_mixed](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_VHttpd_WordPress_array](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			return this.normalizerequest(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		'prepareEnvironment' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_VHttpd_WordPress_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.prepareenvironment(mut dispatch_arg_0)
			return rt.new_null()
		}
		'prepareBootstrapDefaults' {
			this.preparebootstrapdefaults()
			return rt.new_null()
		}
		'resetRequestRuntime' {
			this.resetrequestruntime()
			return rt.new_null()
		}
		'prepareWooCommerceRuntime' {
			this.preparewoocommerceruntime()
			return rt.new_null()
		}
		'renderAdminBar' {
			Class_VHttpd_WordPress_Lifecycle.renderadminbar()
			return rt.new_null()
		}
		'normalizeCookieState' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_VHttpd_WordPress_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.normalizecookiestate(mut dispatch_arg_0)
		}
		'cookieHeader' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_VHttpd_WordPress_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return rt.new_string(this.cookieheader(mut dispatch_arg_0))
		}
		'requestScheme' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_VHttpd_WordPress_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return rt.new_string(this.requestscheme(mut dispatch_arg_0, dispatch_arg_1))
		}
		'bootstrapScheme' {
			return rt.new_string(this.bootstrapscheme())
		}
		'requestTraceId' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_VHttpd_WordPress_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return rt.new_string(this.requesttraceid(mut dispatch_arg_0))
		}
		'requestRequestId' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_VHttpd_WordPress_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return rt.new_string(this.requestrequestid(mut dispatch_arg_0))
		}
		'headerValue' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_VHttpd_WordPress_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_VHttpd_WordPress_array](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			return rt.new_string(this.headervalue(mut dispatch_arg_0, mut dispatch_arg_1))
		}
		'parseCookieHeader' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.parsecookieheader(dispatch_arg_0)
		}
		'hostHeader' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return rt.new_string(this.hostheader(dispatch_arg_0, dispatch_arg_1))
		}
		'resetDependencyRuntime' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_VHttpd_WordPress_object](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.resetdependencyruntime(mut dispatch_arg_0)
			return rt.new_null()
		}
		'refreshDependencyUrls' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			this.refreshdependencyurls(dispatch_arg_0)
			return rt.new_null()
		}
		'resetWooCommerceRuntime' {
			this.resetwoocommerceruntime()
			return rt.new_null()
		}
		'setPrivateProperty' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_VHttpd_WordPress_object](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_VHttpd_WordPress_mixed](if args.len > 2 {
				args[2]
			} else {
				rt.new_null()
			})
			this.setprivateproperty(mut dispatch_arg_0, dispatch_arg_1, mut dispatch_arg_2)
			return rt.new_null()
		}
		'finalizeResponse' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_VHttpd_WordPress_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_VHttpd_WordPress_array](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			return this.finalizeresponse(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		'attachWooCommerceCookies' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_VHttpd_WordPress_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.attachwoocommercecookies(mut dispatch_arg_0)
		}
		'wooCommerceSessionCookieHeader' {
			return rt.new_string(this.woocommercesessioncookieheader())
		}
		'wooCommerceCartCookieHeaders' {
			return this.woocommercecartcookieheaders()
		}
		'buildCookieHeader' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_i64()
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).to_bool()
			dispatch_arg_4 := (if args.len > 4 { args[4] } else { rt.new_null() }).to_bool()
			return rt.new_string(this.buildcookieheader(dispatch_arg_0, dispatch_arg_1,
				dispatch_arg_2, dispatch_arg_3, dispatch_arg_4))
		}
		'appendHeader' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_VHttpd_WordPress_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			this.appendheader(mut dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'objectProperty' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_VHttpd_WordPress_object](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_VHttpd_WordPress_mixed](if args.len > 2 {
				args[2]
			} else {
				rt.new_null()
			})
			return this.objectproperty(mut dispatch_arg_0, dispatch_arg_1, mut dispatch_arg_2)
		}
		else {
			return none
		}
	}
}

fn (this &Class_VHttpd_WordPress_Lifecycle) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_VHttpd_WordPress_Lifecycle) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_RuntimeException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_RuntimeException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_RuntimeException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_ReflectionObject) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ReflectionObject) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ReflectionObject) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
