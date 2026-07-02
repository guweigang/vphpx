import rt
import crypto.md5

struct Class_VHttpd_WordPress_Profiler {
	rt.PhpObjectBase
}

fn init_static_vhttpd_wordpress_profiler() {
		rt.init_static_prop('VHttpd_WordPress_Profiler', 'startTime', rt.new_float(0))
		rt.init_static_prop('VHttpd_WordPress_Profiler', 'logs', rt.new_array())
		rt.init_static_prop('VHttpd_WordPress_Profiler', 'errors', rt.new_array())
		rt.init_static_prop('VHttpd_WordPress_Profiler', 'timeline', rt.new_array())
		rt.init_static_prop('VHttpd_WordPress_Profiler', 'hookCounts', rt.new_array())
		rt.init_static_prop('VHttpd_WordPress_Profiler', 'started', rt.new_bool(false))
		rt.init_static_prop('VHttpd_WordPress_Profiler', 'active', rt.new_bool(false))
		rt.init_static_prop('VHttpd_WordPress_Profiler', 'footerInjected', rt.new_bool(false))
		rt.init_static_prop('VHttpd_WordPress_Profiler', 'currentRequestId', rt.new_string(''))
		rt.init_static_prop('VHttpd_WordPress_Profiler', 'errorHandlersRegistered', rt.new_bool(false))
		rt.init_static_prop('VHttpd_WordPress_Profiler', 'startMemory', rt.new_int(0))
		rt.init_static_prop('VHttpd_WordPress_Profiler', 'externalRequests', rt.new_array())
		rt.init_static_prop('VHttpd_WordPress_Profiler', 'tempRequestTimes', rt.new_array())
		rt.init_static_prop('VHttpd_WordPress_Profiler', 'queryStacks', rt.new_array())
		rt.init_static_prop('VHttpd_WordPress_Profiler', 'prevErrorHandler', rt.new_null())
		rt.init_static_prop('VHttpd_WordPress_Profiler', 'prevExceptionHandler', rt.new_null())
}

fn Class_VHttpd_WordPress_Profiler.reset() {
	mut var_wpdb := rt.new_null()
	rt.set_static_prop('VHttpd_WordPress_Profiler', 'startMemory', rt.call_function('memory_get_usage', []rt.PhpVal{}))
	rt.set_static_prop('VHttpd_WordPress_Profiler', 'startTime', rt.call_function('microtime', [rt.new_bool(true)]))
	rt.set_static_prop('VHttpd_WordPress_Profiler', 'logs', rt.new_array())
	rt.set_static_prop('VHttpd_WordPress_Profiler', 'errors', rt.new_array())
	rt.set_static_prop('VHttpd_WordPress_Profiler', 'timeline', rt.new_array())
	rt.get_static_prop('VHttpd_WordPress_Profiler', 'timeline').array_set('start', rt.get_static_prop('VHttpd_WordPress_Profiler', 'startTime'))
	rt.set_static_prop('VHttpd_WordPress_Profiler', 'hookCounts', rt.new_array())
	rt.set_static_prop('VHttpd_WordPress_Profiler', 'footerInjected', rt.new_bool(false))
	rt.set_static_prop('VHttpd_WordPress_Profiler', 'externalRequests', rt.new_array())
	rt.set_static_prop('VHttpd_WordPress_Profiler', 'tempRequestTimes', rt.new_array())
	rt.set_static_prop('VHttpd_WordPress_Profiler', 'queryStacks', rt.new_array())
	if !(var_wpdb).is_null() && var_wpdb.clone().is_object() {
		rt.set_property(var_wpdb, 'queries', rt.new_array())
	}
}

fn Class_VHttpd_WordPress_Profiler.start() {
	mut var_requestId := if rt.is_true(rt.call_function('getenv', [rt.new_string('VHTTPD_REQUEST_ID')])) { rt.call_function('getenv', [rt.new_string('VHTTPD_REQUEST_ID')]) } else { if !(rt.get_superglobal('_SERVER').array_get(rt.new_string('VHTTPD_REQUEST_ID'))).is_null() { rt.get_superglobal('_SERVER').array_get(rt.new_string('VHTTPD_REQUEST_ID')) } else { rt.new_string('unknown') } }
	if rt.is_true(rt.identical(rt.get_static_prop('VHttpd_WordPress_Profiler', 'currentRequestId'), var_requestId)) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_requestId, rt.new_string('unknown'))))) {
		return
	}
	rt.set_static_prop('VHttpd_WordPress_Profiler', 'currentRequestId', var_requestId.clone())
	Class_VHttpd_WordPress_Profiler.reset()
	rt.set_static_prop('VHttpd_WordPress_Profiler', 'started', rt.new_bool(true))
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.get_static_prop('VHttpd_WordPress_Profiler', 'errorHandlersRegistered'))))) {
		rt.set_static_prop('VHttpd_WordPress_Profiler', 'prevErrorHandler', rt.call_function('set_error_handler', [rt.create_array([rt.ArrayItem{ key: none, val: Class_VHttpd_WordPress_VHttpd_WordPress_Profiler.class() }, rt.ArrayItem{ key: none, val: 'handleError' }])]))
		rt.set_static_prop('VHttpd_WordPress_Profiler', 'prevExceptionHandler', rt.call_function('set_exception_handler', [rt.create_array([rt.ArrayItem{ key: none, val: Class_VHttpd_WordPress_VHttpd_WordPress_Profiler.class() }, rt.ArrayItem{ key: none, val: 'handleException' }])]))
		rt.call_function('register_shutdown_function', [rt.create_array([rt.ArrayItem{ key: none, val: Class_VHttpd_WordPress_VHttpd_WordPress_Profiler.class() }, rt.ArrayItem{ key: none, val: 'handleShutdown' }])])
		rt.set_static_prop('VHttpd_WordPress_Profiler', 'errorHandlersRegistered', rt.new_bool(true))
		if rt.is_true(rt.call_function('function_exists', [rt.new_string('add_action')])) {
			rt.call_function('add_action', [rt.new_string('all'), rt.create_array([rt.ArrayItem{ key: none, val: Class_VHttpd_WordPress_VHttpd_WordPress_Profiler.class() }, rt.ArrayItem{ key: none, val: 'countHook' }])])
		}
	}
}

fn Class_VHttpd_WordPress_Profiler.activate() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.get_static_prop('VHttpd_WordPress_Profiler', 'started'))))) {
		Class_VHttpd_WordPress_Profiler.start()
	}
	rt.set_static_prop('VHttpd_WordPress_Profiler', 'active', rt.new_bool(true))
	rt.get_static_prop('VHttpd_WordPress_Profiler', 'timeline').array_set('init', rt.call_function('microtime', [rt.new_bool(true)]))
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('SAVEQUERIES')]))))) {
		rt.call_function('define', [rt.new_string('SAVEQUERIES'), rt.new_bool(true)])
	}
	if rt.is_true(rt.call_function('function_exists', [rt.new_string('add_action')])) {
		closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			rt.get_static_prop('VHttpd_WordPress_Profiler', 'timeline').array_set('template_redirect', rt.call_function('microtime', [rt.new_bool(true)]))
			return rt.new_null()
			}
		rt.call_function('add_action', [rt.new_string('template_redirect'), rt.new_closure(closure_1_fn)])
		rt.call_function('add_action', [rt.new_string('wp_footer'), rt.create_array([rt.ArrayItem{ key: none, val: Class_VHttpd_WordPress_VHttpd_WordPress_Profiler.class() }, rt.ArrayItem{ key: none, val: 'injectWidget' }]), rt.new_int(9999)])
		rt.call_function('add_action', [rt.new_string('admin_footer'), rt.create_array([rt.ArrayItem{ key: none, val: Class_VHttpd_WordPress_VHttpd_WordPress_Profiler.class() }, rt.ArrayItem{ key: none, val: 'injectWidget' }]), rt.new_int(9999)])
		rt.call_function('add_action', [rt.new_string('rest_api_init'), rt.create_array([rt.ArrayItem{ key: none, val: Class_VHttpd_WordPress_VHttpd_WordPress_Profiler.class() }, rt.ArrayItem{ key: none, val: 'registerRestRoute' }])])
	}
	if rt.is_true(rt.call_function('function_exists', [rt.new_string('add_filter')])) {
		rt.call_function('add_filter', [rt.new_string('query'), rt.create_array([rt.ArrayItem{ key: none, val: Class_VHttpd_WordPress_VHttpd_WordPress_Profiler.class() }, rt.ArrayItem{ key: none, val: 'captureQueryStack' }])])
		rt.call_function('add_filter', [rt.new_string('pre_http_request'), rt.create_array([rt.ArrayItem{ key: none, val: Class_VHttpd_WordPress_VHttpd_WordPress_Profiler.class() }, rt.ArrayItem{ key: none, val: 'logExternalRequestStart' }]), rt.new_int(10), rt.new_int(3)])
	}
	if rt.is_true(rt.call_function('function_exists', [rt.new_string('add_action')])) {
		rt.call_function('add_action', [rt.new_string('http_api_debug'), rt.create_array([rt.ArrayItem{ key: none, val: Class_VHttpd_WordPress_VHttpd_WordPress_Profiler.class() }, rt.ArrayItem{ key: none, val: 'logExternalRequestEnd' }]), rt.new_int(10), rt.new_int(5)])
	}
}

fn Class_VHttpd_WordPress_Profiler.stopanddeactivate() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.get_static_prop('VHttpd_WordPress_Profiler', 'started'))))) {
		return
	}
	rt.set_static_prop('VHttpd_WordPress_Profiler', 'active', rt.new_bool(false))
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.get_static_prop('VHttpd_WordPress_Profiler', 'prevErrorHandler'), rt.new_null())))) {
		rt.call_function('set_error_handler', [rt.get_static_prop('VHttpd_WordPress_Profiler', 'prevErrorHandler')])
	} else {
		rt.call_function('restore_error_handler', []rt.PhpVal{})
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.get_static_prop('VHttpd_WordPress_Profiler', 'prevExceptionHandler'), rt.new_null())))) {
		rt.call_function('set_exception_handler', [rt.get_static_prop('VHttpd_WordPress_Profiler', 'prevExceptionHandler')])
	} else {
		rt.call_function('restore_exception_handler', []rt.PhpVal{})
	}
	if rt.is_true(rt.call_function('function_exists', [rt.new_string('remove_action')])) {
		rt.call_function('remove_action', [rt.new_string('all'), rt.create_array([rt.ArrayItem{ key: none, val: Class_VHttpd_WordPress_VHttpd_WordPress_Profiler.class() }, rt.ArrayItem{ key: none, val: 'countHook' }])])
		rt.call_function('remove_action', [rt.new_string('http_api_debug'), rt.create_array([rt.ArrayItem{ key: none, val: Class_VHttpd_WordPress_VHttpd_WordPress_Profiler.class() }, rt.ArrayItem{ key: none, val: 'logExternalRequestEnd' }]), rt.new_int(10)])
	}
	if rt.is_true(rt.call_function('function_exists', [rt.new_string('remove_filter')])) {
		rt.call_function('remove_filter', [rt.new_string('query'), rt.create_array([rt.ArrayItem{ key: none, val: Class_VHttpd_WordPress_VHttpd_WordPress_Profiler.class() }, rt.ArrayItem{ key: none, val: 'captureQueryStack' }])])
		rt.call_function('remove_filter', [rt.new_string('pre_http_request'), rt.create_array([rt.ArrayItem{ key: none, val: Class_VHttpd_WordPress_VHttpd_WordPress_Profiler.class() }, rt.ArrayItem{ key: none, val: 'logExternalRequestStart' }]), rt.new_int(10)])
	}
}

fn Class_VHttpd_WordPress_Profiler.log(mut var_var Class_VHttpd_WordPress_mixed, label string, level string) {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.get_static_prop('VHttpd_WordPress_Profiler', 'active'))))) {
		return
	}
	rt.get_static_prop('VHttpd_WordPress_Profiler', 'logs').array_push(rt.create_array([rt.ArrayItem{ key: 'label', val: label }, rt.ArrayItem{ key: 'level', val: level }, rt.ArrayItem{ key: 'data', val: if rt.is_true(rt.call_function('is_scalar', [var_var])) { var_var } else { println(var_var.to_string()) } }, rt.ArrayItem{ key: 'timestamp', val: rt.call_function('microtime', [rt.new_bool(true)]) }]))
}

fn Class_VHttpd_WordPress_Profiler.counthook(tag string) {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.get_static_prop('VHttpd_WordPress_Profiler', 'active'))))) {
		return
	}
	rt.get_static_prop('VHttpd_WordPress_Profiler', 'hookCounts').array_set(tag, rt.add(if !(rt.get_static_prop('VHttpd_WordPress_Profiler', 'hookCounts').array_get(rt.new_string(tag))).is_null() { rt.get_static_prop('VHttpd_WordPress_Profiler', 'hookCounts').array_get(rt.new_string(tag)) } else { rt.new_int(0) }, rt.new_int(1)))
}

fn Class_VHttpd_WordPress_Profiler.capturequerystack(query string) string {
	if rt.is_true(rt.get_static_prop('VHttpd_WordPress_Profiler', 'active')) {
		mut var_stack := rt.call_function('debug_backtrace', [rt.get_constant('DEBUG_BACKTRACE_IGNORE_ARGS'), rt.new_int(12)])
		mut var_filtered := rt.new_array()
		mut iter_1 := var_stack.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_frame := item_1.val
			if var_frame.array_isset(rt.new_string('file')) {
				mut var_file := Class_VHttpd_WordPress_Profiler.cleanpath((var_frame.array_get(rt.new_string('file'))).str())
				if rt.is_true(rt.call_function('str_contains', [var_file.clone(), rt.new_string('Profiler.php')])) || rt.is_true(rt.call_function('str_contains', [var_file.clone(), rt.new_string('wp-db.php')])) || rt.is_true(rt.call_function('str_contains', [var_file.clone(), rt.new_string('db.php')])) {
					continue
				}
				mut var_func := if !(var_frame.array_get(rt.new_string('function'))).is_null() { var_frame.array_get(rt.new_string('function')) } else { rt.new_string('') }
				mut var_class := if !(var_frame.array_get(rt.new_string('class'))).is_null() { var_frame.array_get(rt.new_string('class')) } else { rt.new_string('') }
				var_filtered.array_push(rt.create_array([rt.ArrayItem{ key: 'file', val: var_file }, rt.ArrayItem{ key: 'line', val: if !(var_frame.array_get(rt.new_string('line'))).is_null() { var_frame.array_get(rt.new_string('line')) } else { rt.new_int(0) } }, rt.ArrayItem{ key: 'caller', val: if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_class, rt.new_string(''))))) { rt.new_string("${var_class.to_string()}::${var_func.to_string()}") } else { var_func } }]))
			}
		}
		rt.get_static_prop('VHttpd_WordPress_Profiler', 'queryStacks').array_push(var_filtered.clone())
	}
	return query
}

fn Class_VHttpd_WordPress_Profiler.logexternalrequeststart(mut var_pre Class_VHttpd_WordPress_mixed, mut var_args Class_VHttpd_WordPress_array, url string) rt.PhpVal {
	if rt.is_true(rt.get_static_prop('VHttpd_WordPress_Profiler', 'active')) {
		mut var_key := rt.new_string(md5.hexhash(url + (rt.call_function('serialize', [var_args])).str()))
		rt.get_static_prop('VHttpd_WordPress_Profiler', 'tempRequestTimes').array_set(var_key, rt.call_function('microtime', [rt.new_bool(true)]))
	}
	return rt.new_object('VHttpd_WordPress_mixed', []string{}, var_pre)
}

fn Class_VHttpd_WordPress_Profiler.logexternalrequestend(mut var_response Class_VHttpd_WordPress_mixed, context string, class string, mut var_args Class_VHttpd_WordPress_array, url string) {
	mut var_queryParams := rt.new_null()
	mut var_response_mutated := var_response
	mut class_mutated := class
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.get_static_prop('VHttpd_WordPress_Profiler', 'active'))))) {
		return
	}
	mut var_key := rt.new_string(md5.hexhash(url + (rt.call_function('serialize', [var_args])).str()))
	mut var_startTime := if !(rt.get_static_prop('VHttpd_WordPress_Profiler', 'tempRequestTimes').array_get(var_key)).is_null() { rt.get_static_prop('VHttpd_WordPress_Profiler', 'tempRequestTimes').array_get(var_key) } else { rt.new_null() }
	mut var_durationMs := rt.new_float(0)
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_startTime, rt.new_null())))) {
		var_durationMs = rt.call_function('round', [rt.mul(rt.sub(rt.call_function('microtime', [rt.new_bool(true)]), var_startTime), rt.new_int(1000)), rt.new_int(2)])
		rt.get_static_prop('VHttpd_WordPress_Profiler', 'tempRequestTimes').array_unset(var_key)
	}
	mut var_parsedUrl := rt.call_function('parse_url', [rt.new_string(url)])
	mut var_cleanUrl := rt.new_string(url)
	if var_parsedUrl.array_isset(rt.new_string('query')) {
		rt.call_function('parse_str', [var_parsedUrl.array_get(rt.new_string('query')), var_queryParams.clone()])
		mut var_maskedQuery := Class_VHttpd_WordPress_Profiler.masksensitivedata(mut rt.cast_object_ptr[Class_VHttpd_WordPress_array](var_queryParams))
		var_parsedUrl.array_set('query', rt.call_function('http_build_query', [var_maskedQuery.clone()]))
	var_cleanUrl = rt.new_string((if var_parsedUrl.array_isset(rt.new_string('scheme')) { (var_parsedUrl.array_get(rt.new_string('scheme'))).str() + '://' } else { '' } + (if var_parsedUrl.array_isset(rt.new_string('host')) { var_parsedUrl.array_get(rt.new_string('host')) } else { rt.new_string('') }).str() + if var_parsedUrl.array_isset(rt.new_string('port')) { ':' + (var_parsedUrl.array_get(rt.new_string('port'))).str() } else { '' } + (if var_parsedUrl.array_isset(rt.new_string('path')) { var_parsedUrl.array_get(rt.new_string('path')) } else { rt.new_string('') }).str() + if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_parsedUrl.array_get(rt.new_string('query')), rt.new_string(''))))) { '?' + (var_parsedUrl.array_get(rt.new_string('query'))).str() } else { '' }).str())
	}
	mut var_statusCode := rt.new_string('unknown')
	if var_response_mutated.is_array() && var_response_mutated.array_get(rt.new_string('response')).array_isset(rt.new_string('code')) {
	var_statusCode = rt.new_int((var_response_mutated.array_get(rt.new_string('response')).array_get(rt.new_string('code'))).to_i64())
	} else if rt.is_true(rt.new_bool(rt.instance_of(var_response_mutated, 'VHttpd_WordPress_WP_Error'))) {
	var_statusCode = rt.new_string('error: ' + (rt.call_method(var_response_mutated, 'get_error_message', []rt.PhpVal{})).str())
	}
	mut var_callStack := rt.new_array()
	mut var_stack := rt.call_function('debug_backtrace', [rt.get_constant('DEBUG_BACKTRACE_IGNORE_ARGS'), rt.new_int(12)])
	mut iter_2 := var_stack.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_frame := item_2.val
		if var_frame.array_isset(rt.new_string('file')) {
			mut var_file := Class_VHttpd_WordPress_Profiler.cleanpath((var_frame.array_get(rt.new_string('file'))).str())
			if rt.is_true(rt.call_function('str_contains', [var_file.clone(), rt.new_string('Profiler.php')])) {
				continue
			}
			mut var_func := if !(var_frame.array_get(rt.new_string('function'))).is_null() { var_frame.array_get(rt.new_string('function')) } else { rt.new_string('') }
			class_mutated = (if !(var_frame.array_get(rt.new_string('class'))).is_null() { var_frame.array_get(rt.new_string('class')) } else { rt.new_string('') }).str()
			var_callStack.array_push(rt.create_array([rt.ArrayItem{ key: 'file', val: var_file }, rt.ArrayItem{ key: 'line', val: if !(var_frame.array_get(rt.new_string('line'))).is_null() { var_frame.array_get(rt.new_string('line')) } else { rt.new_int(0) } }, rt.ArrayItem{ key: 'caller', val: if rt.is_true(rt.new_bool(class_mutated != '')) { rt.new_string("${var_class.to_string()}::${var_func.to_string()}") } else { var_func } }]))
		}
	}
	rt.get_static_prop('VHttpd_WordPress_Profiler', 'externalRequests').array_push(rt.create_array([rt.ArrayItem{ key: 'url', val: var_cleanUrl }, rt.ArrayItem{ key: 'method', val: if !(var_args.array_get(rt.new_string('method'))).is_null() { var_args.array_get(rt.new_string('method')) } else { rt.new_string('GET') } }, rt.ArrayItem{ key: 'status', val: var_statusCode }, rt.ArrayItem{ key: 'duration_ms', val: var_durationMs }, rt.ArrayItem{ key: 'timestamp', val: rt.call_function('microtime', [rt.new_bool(true)]) }, rt.ArrayItem{ key: 'call_stack', val: var_callStack }]))
}

fn Class_VHttpd_WordPress_Profiler.handleerror(errno i64, errstr string, errfile string, errline i64) bool {
	mut errstr_mutated := errstr
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.bitwise_and(rt.call_function('error_reporting', []rt.PhpVal{}), rt.new_int(errno)))))) {
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.get_static_prop('VHttpd_WordPress_Profiler', 'prevErrorHandler'), rt.new_null())))) {
			return (rt.call_function('call_user_func', [rt.get_static_prop('VHttpd_WordPress_Profiler', 'prevErrorHandler'), rt.new_int(errno), rt.new_string(errstr_mutated).clone(), rt.new_string(errfile), rt.new_int(errline)])).to_bool()
		}
		return false
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.get_static_prop('VHttpd_WordPress_Profiler', 'active'))))) {
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.get_static_prop('VHttpd_WordPress_Profiler', 'prevErrorHandler'), rt.new_null())))) {
			return (rt.call_function('call_user_func', [rt.get_static_prop('VHttpd_WordPress_Profiler', 'prevErrorHandler'), rt.new_int(errno), rt.new_string(errstr_mutated).clone(), rt.new_string(errfile), rt.new_int(errline)])).to_bool()
		}
		return false
	}
	mut match_val_1 := rt.new_int(errno)
	mut var_errorType := if rt.is_true(rt.equal(match_val_1, rt.get_constant('E_ERROR'))) || rt.is_true(rt.equal(match_val_1, rt.get_constant('E_CORE_ERROR'))) || rt.is_true(rt.equal(match_val_1, rt.get_constant('E_COMPILE_ERROR'))) || rt.is_true(rt.equal(match_val_1, rt.get_constant('E_USER_ERROR'))) { rt.new_string('Error') } else if rt.is_true(rt.equal(match_val_1, rt.get_constant('E_WARNING'))) || rt.is_true(rt.equal(match_val_1, rt.get_constant('E_CORE_WARNING'))) || rt.is_true(rt.equal(match_val_1, rt.get_constant('E_COMPILE_WARNING'))) || rt.is_true(rt.equal(match_val_1, rt.get_constant('E_USER_WARNING'))) { rt.new_string('Warning') } else if rt.is_true(rt.equal(match_val_1, rt.get_constant('E_PARSE'))) { rt.new_string('Parse Error') } else if rt.is_true(rt.equal(match_val_1, rt.get_constant('E_NOTICE'))) || rt.is_true(rt.equal(match_val_1, rt.get_constant('E_USER_NOTICE'))) { rt.new_string('Notice') } else if rt.is_true(rt.equal(match_val_1, rt.get_constant('E_DEPRECATED'))) || rt.is_true(rt.equal(match_val_1, rt.get_constant('E_USER_DEPRECATED'))) { rt.new_string('Deprecated') } else { rt.new_string('Unknown Error') }
	rt.get_static_prop('VHttpd_WordPress_Profiler', 'errors').array_push(rt.create_array([rt.ArrayItem{ key: 'level', val: var_errorType }, rt.ArrayItem{ key: 'message', val: errstr_mutated }, rt.ArrayItem{ key: 'file', val: Class_VHttpd_WordPress_Profiler.cleanpath(errfile) }, rt.ArrayItem{ key: 'line', val: errline }, rt.ArrayItem{ key: 'timestamp', val: rt.call_function('microtime', [rt.new_bool(true)]) }]))
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.get_static_prop('VHttpd_WordPress_Profiler', 'prevErrorHandler'), rt.new_null())))) {
		return (rt.call_function('call_user_func', [rt.get_static_prop('VHttpd_WordPress_Profiler', 'prevErrorHandler'), rt.new_int(errno), rt.new_string(errstr_mutated).clone(), rt.new_string(errfile), rt.new_int(errline)])).to_bool()
	}
	return false
}

fn Class_VHttpd_WordPress_Profiler.handleexception(mut var_exception Class_VHttpd_WordPress_Throwable) {
	if rt.is_true(rt.get_static_prop('VHttpd_WordPress_Profiler', 'active')) {
		rt.get_static_prop('VHttpd_WordPress_Profiler', 'errors').array_push(rt.create_array([rt.ArrayItem{ key: 'level', val: 'Exception' }, rt.ArrayItem{ key: 'message', val: var_exception.getmessage() }, rt.ArrayItem{ key: 'file', val: Class_VHttpd_WordPress_Profiler.cleanpath((var_exception.getfile()).str()) }, rt.ArrayItem{ key: 'line', val: var_exception.getline() }, rt.ArrayItem{ key: 'timestamp', val: rt.call_function('microtime', [rt.new_bool(true)]) }, rt.ArrayItem{ key: 'trace', val: Class_VHttpd_WordPress_Profiler.cleantrace((var_exception.gettraceasstring()).str()) }]))
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.get_static_prop('VHttpd_WordPress_Profiler', 'prevExceptionHandler'), rt.new_null())))) {
		rt.call_function('call_user_func', [rt.get_static_prop('VHttpd_WordPress_Profiler', 'prevExceptionHandler'), var_exception])
	}
}

fn Class_VHttpd_WordPress_Profiler.injectwidget() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.get_static_prop('VHttpd_WordPress_Profiler', 'active'))))) || rt.is_true(rt.get_static_prop('VHttpd_WordPress_Profiler', 'footerInjected')) {
		return
	}
	rt.set_static_prop('VHttpd_WordPress_Profiler', 'footerInjected', rt.new_bool(true))
	mut var_report := Class_VHttpd_WordPress_Profiler.buildreport()
	mut var_reportJson := rt.new_string(rt.json_encode(var_report.clone()))
	mut var_jsCode := rt.new_string('')
	mut var_pluginDir := rt.new_null()
	mut var_dir := rt.call_function('dirname', [rt.new_string(@DIR), rt.new_int(3)])
	if rt.is_true(rt.call_function('is_file', [rt.new_string((var_dir).str() + '/v-profiler.php')])) {
	var_pluginDir = var_dir.clone()
	} else if rt.is_true(rt.call_function('is_file', [rt.new_string((var_dir).str() + '/wordpress/v-profiler.php')])) {
	var_pluginDir = rt.new_string((var_dir).str() + '/wordpress')
	}
	mut var_candidates := rt.new_array()
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_pluginDir, rt.new_null())))) {
		var_candidates.array_push((var_pluginDir).str() + '/v-profiler/v-profiler-ui.js')
		var_candidates.array_push((var_pluginDir).str() + '/v-profiler-ui.js')
	}
	if rt.is_true(rt.call_function('defined', [rt.new_string('WP_PLUGIN_DIR')])) {
		var_candidates.array_push((rt.get_constant('WP_PLUGIN_DIR')).str() + '/v-profiler/v-profiler/v-profiler-ui.js')
		var_candidates.array_push((rt.get_constant('WP_PLUGIN_DIR')).str() + '/v-profiler/v-profiler-ui.js')
	}
	if rt.is_true(rt.call_function('defined', [rt.new_string('WPMU_PLUGIN_DIR')])) {
		var_candidates.array_push((rt.get_constant('WPMU_PLUGIN_DIR')).str() + '/v-profiler/v-profiler/v-profiler-ui.js')
		var_candidates.array_push((rt.get_constant('WPMU_PLUGIN_DIR')).str() + '/v-profiler-ui.js')
	}
	mut iter_3 := var_candidates.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_candidate := item_3.val
		if rt.is_true(rt.call_function('is_file', [var_candidate.clone()])) {
			var_jsCode = rt.call_function('file_get_contents', [var_candidate.clone()])
			if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_jsCode, rt.new_string(''))))) {
				break
			}
		}
	}
	print('\n<!-- v-Profiler Start -->\n')
	print('<script>\n')
	print('window.vProfilerData = ' + (var_reportJson).str() + ';\n')
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_jsCode, rt.new_string(''))))) {
		print((var_jsCode).str() + '\n')
	}
	print('</script>\n')
	print('<v-profiler-widget></v-profiler-widget>\n')
	print('<!-- v-Profiler End -->\n')
}

fn Class_VHttpd_WordPress_Profiler.handleshutdown() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.get_static_prop('VHttpd_WordPress_Profiler', 'active'))))) {
		return
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.get_static_prop('VHttpd_WordPress_Profiler', 'footerInjected'))))) {
		mut var_report := Class_VHttpd_WordPress_Profiler.buildreport()
		if rt.is_true(rt.call_function('function_exists', [rt.new_string('wp_cache_set')])) {
			rt.call_function('wp_cache_set', [rt.new_string('report:' + (var_report.array_get(rt.new_string('request_id'))).str()), var_report.clone(), rt.new_string('vprofiler'), rt.new_int(300)])
		}
	}
}

fn Class_VHttpd_WordPress_Profiler.registerrestroute() {
	closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		return
		}
	rt.call_function('register_rest_route', [rt.new_string('v-profiler/v1'), rt.new_string('/report'), rt.create_array([rt.ArrayItem{ key: 'methods', val: 'GET' }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: Class_VHttpd_WordPress_VHttpd_WordPress_Profiler.class() }, rt.ArrayItem{ key: none, val: 'getRestReport' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.new_closure(closure_2_fn) }])])
}

fn Class_VHttpd_WordPress_Profiler.getrestreport(mut var_request Class_VHttpd_WordPress_WP_REST_Request) rt.PhpVal {
	mut var_requestId := var_request.get_param(rt.new_string('request_id'))
	if !rt.is_true(var_requestId) {
		return rt.new_object('VHttpd_WordPress_WP_REST_Response', []string{}, create_vhttpd_wordpress_wp_rest_response(rt.create_array([rt.ArrayItem{ key: 'error', val: 'request_id is required' }]), rt.new_int(400)))
	}
	if rt.is_true(rt.call_function('function_exists', [rt.new_string('wp_cache_get')])) {
		mut var_report := rt.call_function('wp_cache_get', [rt.new_string('report:' + (var_requestId).str()), rt.new_string('vprofiler')])
		if rt.is_true(rt.new_bool(var_report.clone().is_array())) {
			return rt.new_object('VHttpd_WordPress_WP_REST_Response', []string{}, create_vhttpd_wordpress_wp_rest_response(var_report.clone(), rt.new_int(200)))
		}
	}
	return rt.new_object('VHttpd_WordPress_WP_REST_Response', []string{}, create_vhttpd_wordpress_wp_rest_response(rt.create_array([rt.ArrayItem{ key: 'error', val: 'Report not found or expired' }]), rt.new_int(404)))
}

fn Class_VHttpd_WordPress_Profiler.cleanpath(path string) string {
	if rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) {
		return (rt.call_function('str_replace', [rt.get_constant('ABSPATH'), rt.new_string(''), rt.new_string(path)])).str()
	}
	return path
}

fn Class_VHttpd_WordPress_Profiler.cleantrace(trace string) string {
	if rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) {
		return (rt.call_function('str_replace', [rt.get_constant('ABSPATH'), rt.new_string(''), rt.new_string(trace)])).str()
	}
	return trace
}

fn Class_VHttpd_WordPress_Profiler.getadminsocketpath() string {
	mut var_socket := if rt.is_true(rt.call_function('getenv', [rt.new_string('VHTTPD_INTERNAL_ADMIN_SOCKET')])) { rt.call_function('getenv', [rt.new_string('VHTTPD_INTERNAL_ADMIN_SOCKET')]) } else { if !(rt.get_superglobal('_SERVER').array_get(rt.new_string('VHTTPD_INTERNAL_ADMIN_SOCKET'))).is_null() { rt.get_superglobal('_SERVER').array_get(rt.new_string('VHTTPD_INTERNAL_ADMIN_SOCKET')) } else { if !(rt.get_superglobal('_ENV').array_get(rt.new_string('VHTTPD_INTERNAL_ADMIN_SOCKET'))).is_null() { rt.get_superglobal('_ENV').array_get(rt.new_string('VHTTPD_INTERNAL_ADMIN_SOCKET')) } else { rt.new_string('') } } }
	if var_socket.clone().is_string() && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_socket, rt.new_string(''))))) && rt.is_true(rt.call_function('file_exists', [var_socket.clone()])) {
		return (var_socket).str()
	}
	mut var_files := rt.call_function('array_merge', [if rt.is_true(rt.call_function('glob', [rt.new_string('/tmp/vhttpd_admin_*.sock')])) { rt.call_function('glob', [rt.new_string('/tmp/vhttpd_admin_*.sock')]) } else { rt.new_array() }, if rt.is_true(rt.call_function('glob', [rt.new_string('/private/tmp/vhttpd_admin_*.sock')])) { rt.call_function('glob', [rt.new_string('/private/tmp/vhttpd_admin_*.sock')]) } else { rt.new_array() }])
	if var_files.clone().array_count() > 0 {
		closure_3_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_a := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			mut var_b := if args.len > 1 { args[1].clone() } else { rt.new_null() }
			return (rt.new_null()).str()
			}
		rt.call_function('usort', [var_files.clone(), rt.new_closure(closure_3_fn)])
		mut iter_4 := var_files.iterator()
		for {
			item_4 := iter_4.next() or { break }
			mut var_file := item_4.val
			if rt.is_true(rt.call_function('file_exists', [var_file.clone()])) && rt.is_true(rt.call_function('is_readable', [var_file.clone()])) {
				return (var_file).str()
			}
		}
	}
	return ''
}

fn Class_VHttpd_WordPress_Profiler.fetchdbpoolstats() rt.PhpVal {
	mut var_socket := Class_VHttpd_WordPress_Profiler.getadminsocketpath()
	if rt.is_true(rt.identical(var_socket, rt.new_string(''))) {
		return rt.create_array([rt.ArrayItem{ key: 'error', val: 'Internal admin socket not available: empty' }])
	}
	mut var_client := create_vhttpd_wire_jsonclient(var_socket.clone(), rt.new_string('admin'))
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	mut var_response := var_client.request(rt.create_array([rt.ArrayItem{ key: 'mode', val: 'vhttpd_admin' }, rt.ArrayItem{ key: 'method', val: 'GET' }, rt.ArrayItem{ key: 'path', val: '/runtime/db' }, rt.ArrayItem{ key: 'query', val: rt.array_to_object(rt.new_array()) }, rt.ArrayItem{ key: 'body', val: '' }]))
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	if var_response.array_isset(rt.new_string('error')) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_response.array_get(rt.new_string('error')), rt.new_string(''))))) {
		return rt.create_array([rt.ArrayItem{ key: 'error', val: var_response.array_get(rt.new_string('error')) }])
	}
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	if var_response.array_isset(rt.new_string('body')) {
		mut var_body := rt.call_function('json_decode', [rt.new_string((var_response.array_get(rt.new_string('body'))).str()), rt.new_bool(true)])
		if rt.has_exception() { unsafe { goto catch_label_1 } }
		if rt.is_true(rt.new_bool(var_body.clone().is_array())) {
			return var_body.clone()
		}
		if rt.has_exception() { unsafe { goto catch_label_1 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	return rt.create_array([rt.ArrayItem{ key: 'error', val: 'Invalid admin socket response' }])
	unsafe { goto end_label_1 }

catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'VHttpd_WordPress_Throwable') {
		mut var_e := var_e_1.clone()
		return rt.create_array([rt.ArrayItem{ key: 'error', val: 'Failed to query admin socket: ' + (rt.call_method(var_e, 'getMessage', []rt.PhpVal{})).str() }])
		unsafe { goto end_label_1 }
	}
	else {
		rt.throw_exception(var_e_1)
		unsafe { goto end_label_1 }
	}

end_label_1:
	return rt.new_null()
}

fn Class_VHttpd_WordPress_Profiler.fetchvhttpdstats() rt.PhpVal {
	mut var_socket := Class_VHttpd_WordPress_Profiler.getadminsocketpath()
	if rt.is_true(rt.identical(var_socket, rt.new_string(''))) {
		mut var_globTmp := rt.call_function('glob', [rt.new_string('/tmp/vhttpd_admin_*.sock')])
		mut var_globPrivate := rt.call_function('glob', [rt.new_string('/private/tmp/vhttpd_admin_*.sock')])
		mut var_envSocket := if rt.is_true(rt.call_function('getenv', [rt.new_string('VHTTPD_INTERNAL_ADMIN_SOCKET')])) { rt.call_function('getenv', [rt.new_string('VHTTPD_INTERNAL_ADMIN_SOCKET')]) } else { if !(rt.get_superglobal('_SERVER').array_get(rt.new_string('VHTTPD_INTERNAL_ADMIN_SOCKET'))).is_null() { rt.get_superglobal('_SERVER').array_get(rt.new_string('VHTTPD_INTERNAL_ADMIN_SOCKET')) } else { if !(rt.get_superglobal('_ENV').array_get(rt.new_string('VHTTPD_INTERNAL_ADMIN_SOCKET'))).is_null() { rt.get_superglobal('_ENV').array_get(rt.new_string('VHTTPD_INTERNAL_ADMIN_SOCKET')) } else { rt.new_string('empty') } } }
		return rt.create_array([rt.ArrayItem{ key: 'error', val: rt.call_function('sprintf', [rt.new_string('Socket not found. Env: %s | Glob(/tmp): %s | Glob(/private/tmp): %s'), var_envSocket.clone(), if var_globTmp.clone().is_array() { rt.call_function('implode', [rt.new_string(', '), var_globTmp.clone()]) } else { rt.new_string('false') }, if var_globPrivate.clone().is_array() { rt.call_function('implode', [rt.new_string(', '), var_globPrivate.clone()]) } else { rt.new_string('false') }]) }])
	}
	mut var_client := create_vhttpd_wire_jsonclient(var_socket.clone(), rt.new_string('admin'))
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	mut var_response := var_client.request(rt.create_array([rt.ArrayItem{ key: 'mode', val: 'vhttpd_admin' }, rt.ArrayItem{ key: 'method', val: 'GET' }, rt.ArrayItem{ key: 'path', val: '/runtime' }, rt.ArrayItem{ key: 'query', val: rt.array_to_object(rt.new_array()) }, rt.ArrayItem{ key: 'body', val: '' }]))
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	if var_response.array_isset(rt.new_string('error')) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_response.array_get(rt.new_string('error')), rt.new_string(''))))) {
		return rt.create_array([rt.ArrayItem{ key: 'error', val: var_response.array_get(rt.new_string('error')) }])
	}
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	if var_response.array_isset(rt.new_string('body')) {
		mut var_body := rt.call_function('json_decode', [rt.new_string((var_response.array_get(rt.new_string('body'))).str()), rt.new_bool(true)])
		if rt.has_exception() { unsafe { goto catch_label_2 } }
		if rt.is_true(rt.new_bool(var_body.clone().is_array())) {
			return var_body.clone()
		}
		if rt.has_exception() { unsafe { goto catch_label_2 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	return rt.create_array([rt.ArrayItem{ key: 'error', val: 'Invalid admin socket response' }])
	unsafe { goto end_label_2 }

catch_label_2:
	mut var_e_2 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_2, 'VHttpd_WordPress_Throwable') {
		mut var_e := var_e_2.clone()
		return rt.create_array([rt.ArrayItem{ key: 'error', val: 'Failed to query admin socket: ' + (rt.call_method(var_e, 'getMessage', []rt.PhpVal{})).str() }])
		unsafe { goto end_label_2 }
	}
	else {
		rt.throw_exception(var_e_2)
		unsafe { goto end_label_2 }
	}

end_label_2:
	return rt.new_null()
}

fn Class_VHttpd_WordPress_Profiler.fetchexecutors() rt.PhpVal {
	mut var_socket := Class_VHttpd_WordPress_Profiler.getadminsocketpath()
	if rt.is_true(rt.identical(var_socket, rt.new_string(''))) {
		return rt.new_array()
	}
	mut var_client := create_vhttpd_wire_jsonclient(var_socket.clone(), rt.new_string('admin'))
	if rt.has_exception() { unsafe { goto catch_label_3 } }
	mut var_response := var_client.request(rt.create_array([rt.ArrayItem{ key: 'mode', val: 'vhttpd_admin' }, rt.ArrayItem{ key: 'method', val: 'GET' }, rt.ArrayItem{ key: 'path', val: '/executors' }, rt.ArrayItem{ key: 'query', val: rt.array_to_object(rt.new_array()) }, rt.ArrayItem{ key: 'body', val: '' }]))
	if rt.has_exception() { unsafe { goto catch_label_3 } }
	if var_response.array_isset(rt.new_string('error')) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_response.array_get(rt.new_string('error')), rt.new_string(''))))) {
		return rt.new_array()
	}
	if rt.has_exception() { unsafe { goto catch_label_3 } }
	if var_response.array_isset(rt.new_string('body')) {
		mut var_body := rt.call_function('json_decode', [rt.new_string((var_response.array_get(rt.new_string('body'))).str()), rt.new_bool(true)])
		if rt.has_exception() { unsafe { goto catch_label_3 } }
		if rt.is_true(rt.new_bool(var_body.clone().is_array())) {
			return var_body.clone()
		}
		if rt.has_exception() { unsafe { goto catch_label_3 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_3 } }
	return rt.new_array()
	unsafe { goto end_label_3 }

catch_label_3:
	mut var_e_3 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_3, 'VHttpd_WordPress_Throwable') {
		mut var_e := var_e_3.clone()
		return rt.new_array()
		unsafe { goto end_label_3 }
	}
	else {
		rt.throw_exception(var_e_3)
		unsafe { goto end_label_3 }
	}

end_label_3:
	return rt.new_null()
}

fn Class_VHttpd_WordPress_Profiler.masksensitivedata(mut var_data Class_VHttpd_WordPress_array) rt.PhpVal {
	mut var_sensitiveKeys := rt.create_array([rt.ArrayItem{ key: none, val: 'password' }, rt.ArrayItem{ key: none, val: 'password_referer' }, rt.ArrayItem{ key: none, val: 'pwd' }, rt.ArrayItem{ key: none, val: 'secret' }, rt.ArrayItem{ key: none, val: 'token' }, rt.ArrayItem{ key: none, val: 'key' }, rt.ArrayItem{ key: none, val: 'auth' }, rt.ArrayItem{ key: none, val: 'authorization' }, rt.ArrayItem{ key: none, val: 'cookie' }])
	mut var_masked := rt.new_array()
	mut iter_5 := var_data.iterator()
	for {
		item_5 := iter_5.next() or { break }
		mut var_v := item_5.val
		mut var_k := item_5.key
		mut var_lowK := rt.new_string((var_k).str().to_lower())
		mut var_isSensitive := rt.new_bool(false)
		mut iter_6 := var_sensitiveKeys.iterator()
		for {
			item_6 := iter_6.next() or { break }
			mut var_sk := item_6.val
			if rt.is_true(rt.call_function('str_contains', [var_lowK.clone(), var_sk.clone()])) {
				var_isSensitive = rt.new_bool(true)
				break
			}
		}
		if rt.is_true(var_isSensitive) {
			var_masked.array_set(var_k, '******')
		} else if rt.is_true(rt.new_bool(var_v.clone().is_array())) {
			var_masked.array_set(var_k, Class_VHttpd_WordPress_Profiler.masksensitivedata(mut rt.cast_object_ptr[Class_VHttpd_WordPress_array](var_v)))
		} else {
			var_masked.array_set(var_k, var_v.clone())
		}
	}
	return var_masked.clone()
}

fn Class_VHttpd_WordPress_Profiler.getpluginslug(file string) string {
	mut file_mutated := file
	file_mutated = (rt.call_function('str_replace', [rt.new_string('\\'), rt.new_string('/'), rt.new_string(file_mutated).clone()])).str()
	mut var_pluginDir := if rt.is_true(rt.call_function('defined', [rt.new_string('WP_PLUGIN_DIR')])) { rt.call_function('str_replace', [rt.new_string('\\'), rt.new_string('/'), rt.get_constant('WP_PLUGIN_DIR')]) } else { rt.new_string('') }
	mut var_muPluginDir := if rt.is_true(rt.call_function('defined', [rt.new_string('WPMU_PLUGIN_DIR')])) { rt.call_function('str_replace', [rt.new_string('\\'), rt.new_string('/'), rt.get_constant('WPMU_PLUGIN_DIR')]) } else { rt.new_string('') }
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_pluginDir, rt.new_string(''))))) && rt.is_true(rt.call_function('str_starts_with', [rt.new_string(file_mutated).clone(), var_pluginDir.clone()])) {
		mut var_relative := rt.new_string(rt.call_function('substr', [rt.new_string(file_mutated).clone(), rt.new_int(var_pluginDir.clone().to_string().len)]).to_string().trim_left(' \t\n\r'))
		mut var_parts := rt.call_function('explode', [rt.new_string('/'), var_relative.clone()])
		return (if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_parts.array_get(rt.new_int(0)), rt.new_string(''))))) { var_parts.array_get(rt.new_int(0)) } else { rt.new_null() }).str()
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_muPluginDir, rt.new_string(''))))) && rt.is_true(rt.call_function('str_starts_with', [rt.new_string(file_mutated).clone(), var_muPluginDir.clone()])) {
		var_relative = rt.new_string(rt.call_function('substr', [rt.new_string(file_mutated).clone(), rt.new_int(var_muPluginDir.clone().to_string().len)]).to_string().trim_left(' \t\n\r'))
		var_parts = rt.call_function('explode', [rt.new_string('/'), var_relative.clone()])
		return (if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_parts.array_get(rt.new_int(0)), rt.new_string(''))))) { var_parts.array_get(rt.new_int(0)) } else { rt.new_null() }).str()
	}
	return (rt.new_null()).str()
}

fn Class_VHttpd_WordPress_Profiler.buildreport() rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_wp_object_cache := rt.new_null()
	mut var_wp_filter := rt.new_null()
	mut var_GLOBALS := rt.new_null()
	mut var_timeline := rt.get_static_prop('VHttpd_WordPress_Profiler', 'timeline')
	var_timeline.array_set('shutdown', rt.call_function('microtime', [rt.new_bool(true)]))
	mut var_totalDurationMs := rt.call_function('round', [rt.mul(rt.sub(var_timeline.array_get(rt.new_string('shutdown')), rt.get_static_prop('VHttpd_WordPress_Profiler', 'startTime')), rt.new_int(1000)), rt.new_int(2)])
	mut var_checkpoints := rt.new_array()
	mut var_prevTime := rt.get_static_prop('VHttpd_WordPress_Profiler', 'startTime')
	mut iter_7 := var_timeline.iterator()
	for {
		item_7 := iter_7.next() or { break }
		mut var_time := item_7.val
		mut var_name := item_7.key
		var_checkpoints.array_push(rt.create_array([rt.ArrayItem{ key: 'name', val: var_name }, rt.ArrayItem{ key: 'time_ms', val: rt.call_function('round', [rt.mul(rt.sub(var_time, rt.get_static_prop('VHttpd_WordPress_Profiler', 'startTime')), rt.new_int(1000)), rt.new_int(2)]) }, rt.ArrayItem{ key: 'duration_ms', val: rt.call_function('round', [rt.mul(rt.sub(var_time, var_prevTime), rt.new_int(1000)), rt.new_int(2)]) }]))
	var_prevTime = var_time
	}
	mut var_queries := rt.new_array()
	mut var_slowQueryThresholdMs := rt.new_float(50)
	mut var_totalSqlDurationMs := rt.new_float(0)
	mut var_slowQueriesCount := rt.new_int(0)
	mut var_wcQueries := rt.new_array()
	mut var_wcSqlDurationMs := rt.new_float(0)
	mut var_wcKeywords := rt.create_array([rt.ArrayItem{ key: none, val: 'wp_wc_' }, rt.ArrayItem{ key: none, val: 'woocommerce_' }, rt.ArrayItem{ key: none, val: 'product' }, rt.ArrayItem{ key: none, val: 'line_item' }, rt.ArrayItem{ key: none, val: 'order' }, rt.ArrayItem{ key: none, val: 'coupon' }, rt.ArrayItem{ key: none, val: 'checkout' }])
	mut var_pluginSqlStats := rt.new_array()
	if !(rt.get_property(var_wpdb, 'queries')).is_null() && rt.get_property(var_wpdb, 'queries').is_array() {
		mut iter_8 := rt.get_property(var_wpdb, 'queries').iterator()
		for {
			item_8 := iter_8.next() or { break }
			mut var_q := item_8.val
			mut var_idx := item_8.key
			mut var_sql := rt.new_string((var_q.array_get(rt.new_int(0))).str())
			mut var_durationMs := rt.call_function('round', [rt.new_float((var_q.array_get(rt.new_int(1))).to_f64()) * 1000, rt.new_int(2)])
			mut var_caller := rt.new_string((if !(var_q.array_get(rt.new_int(2))).is_null() { var_q.array_get(rt.new_int(2)) } else { rt.new_string('') }).str())
			var_totalSqlDurationMs = rt.add(var_totalSqlDurationMs, var_durationMs)
			if rt.is_true(rt.greater(var_durationMs, var_slowQueryThresholdMs)) {
				rt.post_inc(var_slowQueriesCount)
			}
			mut var_callStack := if !(rt.get_static_prop('VHttpd_WordPress_Profiler', 'queryStacks').array_get(var_idx)).is_null() { rt.get_static_prop('VHttpd_WordPress_Profiler', 'queryStacks').array_get(var_idx) } else { rt.new_array() }
			mut var_pluginSlug := rt.new_null()
			mut iter_9 := var_callStack.iterator()
			for {
				item_9 := iter_9.next() or { break }
				mut var_frame := item_9.val
				if var_frame.array_isset(rt.new_string('file')) {
					mut var_slug := Class_VHttpd_WordPress_Profiler.getpluginslug((var_frame.array_get(rt.new_string('file'))).str())
					if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_slug, rt.new_null())))) {
						var_pluginSlug = var_slug.clone()
						break
					}
				}
			}
			if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_pluginSlug, rt.new_null())))) {
				if !(var_pluginSqlStats.array_isset(var_pluginSlug)) {
					var_pluginSqlStats.array_set(var_pluginSlug, rt.create_array([rt.ArrayItem{ key: 'duration_ms', val: 0 }, rt.ArrayItem{ key: 'count', val: 0 }]))
				}
				var_pluginSqlStats.array_get(var_pluginSlug).array_get(rt.new_string('duration_ms')) = rt.add(var_pluginSqlStats.array_get(var_pluginSlug).array_get(rt.new_string('duration_ms')), var_durationMs)
				rt.post_inc(var_pluginSqlStats.array_get(var_pluginSlug).array_get(rt.new_string('count')))
			}
			mut var_optimizationTip := rt.new_string('')
			mut var_sqlLower := rt.new_string(var_sql.clone().to_string().to_lower())
			if rt.is_true(rt.call_function('str_contains', [var_sqlLower.clone(), rt.new_string('select option_value from wp_options where option_name =')])) {
			var_optimizationTip = rt.new_string('💡 提示：该查询正检索单个 option。建议使用 wp_cache_get 缓存该选项，或将其设为 autoload，避免频繁直查 DB。')
			} else if rt.is_true(rt.call_function('str_contains', [var_sqlLower.clone(), rt.new_string('select')])) && rt.is_true(rt.call_function('str_contains', [var_sqlLower.clone(), rt.new_string('wp_posts')])) && rt.is_true(rt.call_function('str_contains', [var_sqlLower.clone(), rt.new_string('post_name in')])) {
			var_optimizationTip = rt.new_string('💡 提示：按 slug 查询 wp_posts。请确保 wp_posts 的 post_name 字段存在合理索引，并启用 Object Cache 缓存查询结果。')
			} else if rt.is_true(rt.call_function('str_contains', [var_sqlLower.clone(), rt.new_string('insert into')])) && rt.is_true(rt.call_function('str_contains', [var_sqlLower.clone(), rt.new_string('wp_woocommerce_sessions')])) {
			var_optimizationTip = rt.new_string('💡 提示：写入 WooCommerce session 数据。高并发下可能引起表锁，建议在 WooCommerce 中开启外部 Cache 会话处理器，或使用 Redis 进行会话托管。')
			}
			mut var_queryItem := rt.create_array([rt.ArrayItem{ key: 'sql', val: var_sql }, rt.ArrayItem{ key: 'duration_ms', val: var_durationMs }, rt.ArrayItem{ key: 'caller', val: var_caller }, rt.ArrayItem{ key: 'slow', val: rt.greater(var_durationMs, var_slowQueryThresholdMs) }, rt.ArrayItem{ key: 'call_stack', val: var_callStack }, rt.ArrayItem{ key: 'optimization_tip', val: var_optimizationTip }])
			var_queries.array_push(var_queryItem.clone())
			mut var_isWcQuery := rt.new_bool(false)
			mut iter_10 := var_wcKeywords.iterator()
			for {
				item_10 := iter_10.next() or { break }
				mut var_kw := item_10.val
				if rt.is_true(rt.call_function('str_contains', [rt.new_string(var_sql.clone().to_string().to_lower()), var_kw.clone()])) {
					var_isWcQuery = rt.new_bool(true)
					break
				}
			}
			if rt.is_true(var_isWcQuery) {
				var_wcSqlDurationMs = rt.add(var_wcSqlDurationMs, var_durationMs)
				var_wcQueries.array_push(var_queryItem.clone())
			}
		}
	}
	mut var_pluginHttpStats := rt.new_array()
	mut iter_11 := rt.get_static_prop('VHttpd_WordPress_Profiler', 'externalRequests').iterator()
	for {
		item_11 := iter_11.next() or { break }
		mut var_req := item_11.val
		mut var_durationMs := if !(var_req.array_get(rt.new_string('duration_ms'))).is_null() { var_req.array_get(rt.new_string('duration_ms')) } else { rt.new_float(0) }
		mut var_callStack := if !(var_req.array_get(rt.new_string('call_stack'))).is_null() { var_req.array_get(rt.new_string('call_stack')) } else { rt.new_array() }
		mut var_pluginSlug := rt.new_null()
		mut iter_12 := var_callStack.iterator()
		for {
			item_12 := iter_12.next() or { break }
			mut var_frame := item_12.val
			if var_frame.array_isset(rt.new_string('file')) {
				mut var_slug := Class_VHttpd_WordPress_Profiler.getpluginslug((var_frame.array_get(rt.new_string('file'))).str())
				if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_slug, rt.new_null())))) {
					var_pluginSlug = var_slug.clone()
					break
				}
			}
		}
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_pluginSlug, rt.new_null())))) {
			if !(var_pluginHttpStats.array_isset(var_pluginSlug)) {
				var_pluginHttpStats.array_set(var_pluginSlug, rt.create_array([rt.ArrayItem{ key: 'duration_ms', val: 0 }, rt.ArrayItem{ key: 'count', val: 0 }]))
			}
			var_pluginHttpStats.array_get(var_pluginSlug).array_get(rt.new_string('duration_ms')) = rt.add(var_pluginHttpStats.array_get(var_pluginSlug).array_get(rt.new_string('duration_ms')), var_durationMs)
			rt.post_inc(var_pluginHttpStats.array_get(var_pluginSlug).array_get(rt.new_string('count')))
		}
	}
	mut var_slowestPluginSql := rt.new_string('none')
	if !(!rt.is_true(var_pluginSqlStats)) {
		closure_4_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_a := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			mut var_b := if args.len > 1 { args[1].clone() } else { rt.new_null() }
			return rt.new_null()
			}
		rt.call_function('uasort', [var_pluginSqlStats.clone(), rt.new_closure(closure_4_fn)])
	mut var_firstSlug := rt.call_function('array_key_first', [var_pluginSqlStats.clone()])
	mut var_firstData := var_pluginSqlStats.array_get(var_firstSlug)
	var_slowestPluginSql = rt.call_function('sprintf', [rt.new_string('%s (%s ms / %s queries)'), var_firstSlug.clone(), rt.call_function('round', [var_firstData.array_get(rt.new_string('duration_ms')), rt.new_int(1)]), var_firstData.array_get(rt.new_string('count'))])
	}
	mut var_slowestPluginHttp := rt.new_string('none')
	if !(!rt.is_true(var_pluginHttpStats)) {
		closure_5_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_a := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			mut var_b := if args.len > 1 { args[1].clone() } else { rt.new_null() }
			return rt.new_null()
			}
		rt.call_function('uasort', [var_pluginHttpStats.clone(), rt.new_closure(closure_5_fn)])
	var_firstSlug = rt.call_function('array_key_first', [var_pluginHttpStats.clone()])
	var_firstData = var_pluginHttpStats.array_get(var_firstSlug)
	var_slowestPluginHttp = rt.call_function('sprintf', [rt.new_string('%s (%s ms / %s calls)'), var_firstSlug.clone(), rt.call_function('round', [var_firstData.array_get(rt.new_string('duration_ms')), rt.new_int(1)]), var_firstData.array_get(rt.new_string('count'))])
	}
	mut var_local := rt.new_int(0)
	mut var_remote := rt.new_int(0)
	mut var_misses := rt.new_int(0)
	mut var_cacheStats := rt.create_array([rt.ArrayItem{ key: 'local_hits', val: 0 }, rt.ArrayItem{ key: 'remote_hits', val: 0 }, rt.ArrayItem{ key: 'misses', val: 0 }, rt.ArrayItem{ key: 'total', val: 0 }, rt.ArrayItem{ key: 'ratio', val: 0 }, rt.ArrayItem{ key: 'global_keys', val: rt.new_array() }, rt.ArrayItem{ key: 'global_key_count', val: 0 }, rt.ArrayItem{ key: 'bypass_reasons', val: Class_VHttpd_WordPress_Profiler.getcachebypassreasons() }])
	if !(var_wp_object_cache).is_null() {
		if rt.is_true(rt.call_function('property_exists', [var_wp_object_cache.clone(), rt.new_string('local_hits')])) {
		var_local = rt.new_int((rt.get_property(var_wp_object_cache, 'local_hits')).to_i64())
		var_remote = rt.new_int((rt.get_property(var_wp_object_cache, 'remote_hits')).to_i64())
		var_misses = rt.new_int((rt.get_property(var_wp_object_cache, 'cache_misses')).to_i64())
		} else if rt.is_true(rt.call_function('property_exists', [var_wp_object_cache.clone(), rt.new_string('cache_hits')])) {
		var_local = rt.new_int((rt.get_property(var_wp_object_cache, 'cache_hits')).to_i64())
		var_remote = rt.new_int(0)
		var_misses = rt.new_int((rt.get_property(var_wp_object_cache, 'cache_misses')).to_i64())
		}
	mut var_total := rt.add(rt.add(var_local, var_remote), var_misses)
	mut var_ratio := if rt.is_true(rt.greater(var_total, rt.new_int(0))) { rt.call_function('round', [rt.mul(rt.div(rt.add(var_local, var_remote), var_total), rt.new_int(100)), rt.new_int(2)]) } else { rt.new_float(0) }
	var_cacheStats = rt.create_array([rt.ArrayItem{ key: 'local_hits', val: var_local }, rt.ArrayItem{ key: 'remote_hits', val: var_remote }, rt.ArrayItem{ key: 'misses', val: var_misses }, rt.ArrayItem{ key: 'total', val: var_total }, rt.ArrayItem{ key: 'ratio', val: var_ratio }, rt.ArrayItem{ key: 'global_keys', val: rt.new_array() }, rt.ArrayItem{ key: 'global_key_count', val: 0 }, rt.ArrayItem{ key: 'bypass_reasons', val: Class_VHttpd_WordPress_Profiler.getcachebypassreasons() }])
	}
	if rt.is_true(rt.call_function('class_exists', [Class_VHttpd_WordPress_VHttpd_Cache_Client.class()])) {
		mut iife_temp_5 := Class_VHttpd_WordPress_VHttpd_Cache_Client{}
		mut iife_result_5 := iife_temp_5.fromenv()
		mut var_cacheClient := iife_result_5
		if rt.has_exception() { unsafe { goto catch_label_4 } }
		mut var_gKeys := rt.call_method(var_cacheClient, 'keys', []rt.PhpVal{})
		if rt.has_exception() { unsafe { goto catch_label_4 } }
		var_cacheStats.array_set('global_keys', var_gKeys.clone())
		if rt.has_exception() { unsafe { goto catch_label_4 } }
		var_cacheStats.array_set('global_key_count', var_gKeys.clone().array_count())
		if rt.has_exception() { unsafe { goto catch_label_4 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_4 } }
	unsafe { goto end_label_4 }

catch_label_4:
	mut var_e_4 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_4, 'VHttpd_WordPress_Throwable') {
		mut var_e := var_e_4.clone()
		unsafe { goto end_label_4 }
	}
	else {
		rt.throw_exception(var_e_4)
		unsafe { goto end_label_4 }
	}

end_label_4:
	rt.call_function('arsort', [rt.get_static_prop('VHttpd_WordPress_Profiler', 'hookCounts')])
	mut var_topHooks := rt.new_array()
	mut var_count := rt.new_int(0)
	mut iter_13 := rt.get_static_prop('VHttpd_WordPress_Profiler', 'hookCounts').iterator()
	for {
		item_13 := iter_13.next() or { break }
		mut var_num := item_13.val
		mut var_tag := item_13.key
		mut var_hasCallbacks := rt.new_bool(var_wp_filter.array_isset(var_tag) && rt.is_true(rt.new_bool(rt.instance_of(var_wp_filter.array_get(var_tag), 'VHttpd_WordPress_WP_Hook'))) && !(!rt.is_true(rt.get_property(var_wp_filter.array_get(var_tag), 'callbacks'))))
		if rt.is_true(rt.new_bool(!(rt.is_true(var_hasCallbacks)))) {
			continue
		}
		if rt.is_true(rt.greater_equal(var_count, rt.new_int(30))) {
			break
		}
		mut var_callbacks := rt.new_array()
		mut iter_14 := rt.get_property(var_wp_filter.array_get(var_tag), 'callbacks').iterator()
		for {
			item_14 := iter_14.next() or { break }
			mut var_priorityCallbacks := item_14.val
			mut var_priority := item_14.key
			mut iter_15 := var_priorityCallbacks.iterator()
			for {
				item_15 := iter_15.next() or { break }
				mut var_cbInfo := item_15.val
				mut var_function := var_cbInfo.array_get(rt.new_string('function'))
				mut var_name := rt.new_string('unknown')
				mut var_location := rt.new_string('unknown')
				if rt.is_true(rt.new_bool(var_function.clone().is_string())) {
					var_name = var_function.clone()
					if rt.has_exception() { unsafe { goto catch_label_5 } }
					if rt.is_true(rt.call_function('function_exists', [var_function.clone()])) {
						mut var_ref := create_vhttpd_wordpress_reflectionfunction(var_function.clone())
						if rt.has_exception() { unsafe { goto catch_label_5 } }
						var_location = rt.new_string((Class_VHttpd_WordPress_Profiler.cleanpath((rt.call_method(var_ref, 'getFileName', []rt.PhpVal{})).str())).str() + ':' + (rt.call_method(var_ref, 'getStartLine', []rt.PhpVal{})).str())
						if rt.has_exception() { unsafe { goto catch_label_5 } }
					}
					if rt.has_exception() { unsafe { goto catch_label_5 } }
				} else if var_function.clone().is_array() && var_function.clone().array_count() == 2 {
					mut var_class := var_function.array_get(rt.new_int(0))
					if rt.has_exception() { unsafe { goto catch_label_5 } }
					mut var_method := var_function.array_get(rt.new_int(1))
					if rt.has_exception() { unsafe { goto catch_label_5 } }
					mut var_className := if var_class.clone().is_object() { rt.call_function('get_class', [var_class.clone()]) } else { var_class }
					if rt.has_exception() { unsafe { goto catch_label_5 } }
					var_name = rt.new_string("${var_className.to_string()}::${var_method.to_string()}")
					if rt.has_exception() { unsafe { goto catch_label_5 } }
					if rt.is_true(rt.call_function('method_exists', [var_class.clone(), var_method.clone()])) {
						var_ref = create_vhttpd_wordpress_reflectionmethod(var_class.clone(), var_method.clone())
						if rt.has_exception() { unsafe { goto catch_label_5 } }
						var_location = rt.new_string((Class_VHttpd_WordPress_Profiler.cleanpath((rt.call_method(var_ref, 'getFileName', []rt.PhpVal{})).str())).str() + ':' + (rt.call_method(var_ref, 'getStartLine', []rt.PhpVal{})).str())
						if rt.has_exception() { unsafe { goto catch_label_5 } }
					}
					if rt.has_exception() { unsafe { goto catch_label_5 } }
				} else if rt.is_true(rt.new_bool(rt.instance_of(var_function, 'VHttpd_WordPress_Closure'))) {
					var_name = rt.new_string('Closure')
					if rt.has_exception() { unsafe { goto catch_label_5 } }
					var_ref = create_vhttpd_wordpress_reflectionfunction(var_function.clone())
					if rt.has_exception() { unsafe { goto catch_label_5 } }
					var_location = rt.new_string((Class_VHttpd_WordPress_Profiler.cleanpath((rt.call_method(var_ref, 'getFileName', []rt.PhpVal{})).str())).str() + ':' + (rt.call_method(var_ref, 'getStartLine', []rt.PhpVal{})).str())
					if rt.has_exception() { unsafe { goto catch_label_5 } }
				} else if rt.is_true(rt.new_bool(var_function.clone().is_object())) {
					var_className = rt.call_function('get_class', [var_function.clone()])
					if rt.has_exception() { unsafe { goto catch_label_5 } }
					var_name = rt.new_string("${var_className.to_string()}::__invoke")
					if rt.has_exception() { unsafe { goto catch_label_5 } }
					if rt.is_true(rt.call_function('method_exists', [var_function.clone(), rt.new_string('__invoke')])) {
						var_ref = create_vhttpd_wordpress_reflectionmethod(var_function.clone(), rt.new_string('__invoke'))
						if rt.has_exception() { unsafe { goto catch_label_5 } }
						var_location = rt.new_string((Class_VHttpd_WordPress_Profiler.cleanpath((rt.call_method(var_ref, 'getFileName', []rt.PhpVal{})).str())).str() + ':' + (rt.call_method(var_ref, 'getStartLine', []rt.PhpVal{})).str())
						if rt.has_exception() { unsafe { goto catch_label_5 } }
					}
					if rt.has_exception() { unsafe { goto catch_label_5 } }
				}
				if rt.has_exception() { unsafe { goto catch_label_5 } }
				unsafe { goto end_label_5 }

catch_label_5:
				mut var_e_5 := rt.get_and_clear_exception()
				if rt.instance_of(var_e_5, 'VHttpd_WordPress_Throwable') {
					var_e = var_e_5.clone()
					var_location = rt.new_string('reflection failed')
					unsafe { goto end_label_5 }
				}
				else {
					rt.throw_exception(var_e_5)
					unsafe { goto end_label_5 }
				}

end_label_5:
				var_callbacks.array_push(rt.create_array([rt.ArrayItem{ key: 'name', val: var_name }, rt.ArrayItem{ key: 'priority', val: var_priority }, rt.ArrayItem{ key: 'location', val: var_location }]))
			}
		}
		var_topHooks.array_push(rt.create_array([rt.ArrayItem{ key: 'tag', val: var_tag }, rt.ArrayItem{ key: 'count', val: var_num }, rt.ArrayItem{ key: 'callbacks', val: var_callbacks }]))
		rt.post_inc(var_count)
	}
	mut var_dbPool := Class_VHttpd_WordPress_Profiler.fetchdbpoolstats()
	mut var_isWpdbOverride := rt.new_bool(!(var_wpdb).is_null() && rt.is_true(rt.new_bool(rt.instance_of(var_wpdb, 'VHttpd_WordPress_VHttpd_WordPress_Wpdb'))))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_isWpdbOverride)))) {
		var_dbPool.array_set('pool_ready', false)
	}
	var_dbPool.array_set('db_class', if !(var_wpdb).is_null() { rt.call_function('get_class', [var_wpdb.clone()]) } else { rt.new_string('unknown') })
	if var_dbPool.array_isset(rt.new_string('pool_ready')) && rt.is_true(rt.identical(var_dbPool.array_get(rt.new_string('pool_ready')), rt.new_bool(true))) {
		var_dbPool.array_set('multiplexing_savings_ms', 12.5)
	} else {
		var_dbPool.array_set('multiplexing_savings_ms', 0)
	}
	mut var_vhttpdStats := Class_VHttpd_WordPress_Profiler.fetchvhttpdstats()
	mut var_executors := Class_VHttpd_WordPress_Profiler.fetchexecutors()
	var_vhttpdStats.array_set('executors', var_executors.clone())
	mut var_requestId := if rt.is_true(rt.call_function('getenv', [rt.new_string('VHTTPD_REQUEST_ID')])) { rt.call_function('getenv', [rt.new_string('VHTTPD_REQUEST_ID')]) } else { if !(rt.get_superglobal('_SERVER').array_get(rt.new_string('VHTTPD_REQUEST_ID'))).is_null() { rt.get_superglobal('_SERVER').array_get(rt.new_string('VHTTPD_REQUEST_ID')) } else { rt.new_string('unknown') } }
	mut var_traceId := if rt.is_true(rt.call_function('getenv', [rt.new_string('VHTTPD_TRACE_ID')])) { rt.call_function('getenv', [rt.new_string('VHTTPD_TRACE_ID')]) } else { if !(rt.get_superglobal('_SERVER').array_get(rt.new_string('VHTTPD_TRACE_ID'))).is_null() { rt.get_superglobal('_SERVER').array_get(rt.new_string('VHTTPD_TRACE_ID')) } else { rt.new_string('unknown') } }
	mut var_requestHeaders := if rt.is_true(rt.call_function('function_exists', [rt.new_string('getallheaders')])) { rt.call_function('getallheaders', []rt.PhpVal{}) } else { rt.new_array() }
	if !rt.is_true(var_requestHeaders) {
		mut iter_16 := rt.get_superglobal('_SERVER').iterator()
		for {
			item_16 := iter_16.next() or { break }
			mut var_value := item_16.val
			mut var_key := item_16.key
			if rt.is_true(rt.call_function('str_starts_with', [var_key.clone(), rt.new_string('HTTP_')])) {
				mut var_name := rt.call_function('str_replace', [rt.new_string('_'), rt.new_string('-'), rt.call_function('substr', [var_key.clone(), rt.new_int(5)])])
				var_requestHeaders.array_set(var_name, var_value.clone())
			}
		}
	}
	mut var_importantServerVars := rt.create_array([rt.ArrayItem{ key: none, val: 'SERVER_SOFTWARE' }, rt.ArrayItem{ key: none, val: 'SERVER_NAME' }, rt.ArrayItem{ key: none, val: 'SERVER_ADDR' }, rt.ArrayItem{ key: none, val: 'SERVER_PORT' }, rt.ArrayItem{ key: none, val: 'REMOTE_ADDR' }, rt.ArrayItem{ key: none, val: 'REMOTE_PORT' }, rt.ArrayItem{ key: none, val: 'DOCUMENT_ROOT' }, rt.ArrayItem{ key: none, val: 'PHP_SELF' }, rt.ArrayItem{ key: none, val: 'SCRIPT_FILENAME' }, rt.ArrayItem{ key: none, val: 'REQUEST_TIME_FLOAT' }, rt.ArrayItem{ key: none, val: 'HTTPS' }])
	mut var_serverVarsFiltered := rt.new_array()
	mut iter_17 := var_importantServerVars.iterator()
	for {
		item_17 := iter_17.next() or { break }
		mut var_v := item_17.val
		if rt.get_superglobal('_SERVER').array_isset(var_v) {
			var_serverVarsFiltered.array_set(var_v, rt.get_superglobal('_SERVER').array_get(var_v))
		}
	}
	mut iter_18 := rt.get_superglobal('_SERVER').iterator()
	for {
		item_18 := iter_18.next() or { break }
		mut var_v := item_18.val
		mut var_k := item_18.key
		if rt.is_true(rt.call_function('str_starts_with', [var_k.clone(), rt.new_string('VHTTPD_')])) {
			var_serverVarsFiltered.array_set(var_k, var_v.clone())
		}
	}
	mut var_peakMemory := rt.call_function('memory_get_peak_usage', []rt.PhpVal{})
	mut var_memoryDiffBytes := rt.sub(rt.call_function('memory_get_usage', []rt.PhpVal{}), rt.get_static_prop('VHttpd_WordPress_Profiler', 'startMemory'))
	mut var_memoryDiffFormatted := rt.new_string((if rt.is_true(rt.greater_equal(var_memoryDiffBytes, rt.new_int(0))) { '+' } else { '-' } + (if rt.is_true(rt.call_function('function_exists', [rt.new_string('size_format')])) { rt.call_function('size_format', [rt.call_function('abs', [var_memoryDiffBytes.clone()])]) } else { (rt.call_function('abs', [var_memoryDiffBytes.clone()])).str() + ' B' }).str()).str())
	mut var_envDiagnostics := rt.create_array([rt.ArrayItem{ key: 'php_version', val: rt.get_constant('PHP_VERSION') }, rt.ArrayItem{ key: 'wp_version', val: if !(var_GLOBALS.array_get(rt.new_string('wp_version'))).is_null() { var_GLOBALS.array_get(rt.new_string('wp_version')) } else { rt.new_string('unknown') } }, rt.ArrayItem{ key: 'included_files_count', val: rt.call_function('get_included_files', []rt.PhpVal{}).array_count() }, rt.ArrayItem{ key: 'peak_memory_bytes', val: var_peakMemory }, rt.ArrayItem{ key: 'peak_memory_formatted', val: if rt.is_true(rt.call_function('function_exists', [rt.new_string('size_format')])) { rt.call_function('size_format', [var_peakMemory.clone()]) } else { (var_peakMemory).str() + ' B' } }, rt.ArrayItem{ key: 'request_method', val: if !(rt.get_superglobal('_SERVER').array_get(rt.new_string('REQUEST_METHOD'))).is_null() { rt.get_superglobal('_SERVER').array_get(rt.new_string('REQUEST_METHOD')) } else { rt.new_string('GET') } }, rt.ArrayItem{ key: 'request_uri', val: if !(rt.get_superglobal('_SERVER').array_get(rt.new_string('REQUEST_URI'))).is_null() { rt.get_superglobal('_SERVER').array_get(rt.new_string('REQUEST_URI')) } else { rt.new_string('') } }, rt.ArrayItem{ key: 'request_id', val: var_requestId }, rt.ArrayItem{ key: 'trace_id', val: var_traceId }, rt.ArrayItem{ key: 'executor', val: if rt.is_true(rt.identical(rt.get_constant('PHP_SAPI'), rt.new_string('cli'))) { 'php (long-running worker)' } else { 'php-cgi (CGI)' } }, rt.ArrayItem{ key: 'get_params', val: Class_VHttpd_WordPress_Profiler.masksensitivedata(mut rt.cast_object_ptr[Class_VHttpd_WordPress_array](rt.get_superglobal('_GET'))) }, rt.ArrayItem{ key: 'post_params', val: Class_VHttpd_WordPress_Profiler.masksensitivedata(mut rt.cast_object_ptr[Class_VHttpd_WordPress_array](rt.get_superglobal('_POST'))) }, rt.ArrayItem{ key: 'cookies', val: Class_VHttpd_WordPress_Profiler.masksensitivedata(mut rt.cast_object_ptr[Class_VHttpd_WordPress_array](rt.get_superglobal('_COOKIE'))) }, rt.ArrayItem{ key: 'session', val: if !(rt.get_superglobal('_SESSION')).is_null() { Class_VHttpd_WordPress_Profiler.masksensitivedata(mut rt.cast_object_ptr[Class_VHttpd_WordPress_array](rt.get_superglobal('_SESSION'))) } else { rt.new_array() } }, rt.ArrayItem{ key: 'request_headers', val: var_requestHeaders }, rt.ArrayItem{ key: 'response_headers', val: rt.call_function('headers_list', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'server_variables', val: Class_VHttpd_WordPress_Profiler.masksensitivedata(mut rt.cast_object_ptr[Class_VHttpd_WordPress_array](var_serverVarsFiltered)) }])
	mut var_isWcPage := rt.new_bool(false)
	mut var_woocommerceData := rt.new_null()
	if rt.is_true(rt.call_function('class_exists', [rt.new_string('WooCommerce')])) {
		var_isWcPage = rt.new_bool(((((((rt.is_true(rt.call_function('function_exists', [rt.new_string('is_woocommerce')])) && rt.is_true(rt.call_function('is_woocommerce', []rt.PhpVal{}))) || (rt.is_true(rt.call_function('function_exists', [rt.new_string('is_cart')])) && rt.is_true(rt.call_function('is_cart', []rt.PhpVal{})))) || (rt.is_true(rt.call_function('function_exists', [rt.new_string('is_checkout')])) && rt.is_true(rt.call_function('is_checkout', []rt.PhpVal{})))) || (rt.is_true(rt.call_function('function_exists', [rt.new_string('is_account_page')])) && rt.is_true(rt.call_function('is_account_page', []rt.PhpVal{})))) || (rt.is_true(rt.call_function('function_exists', [rt.new_string('is_wc_endpoint_url')])) && rt.is_true(rt.call_function('is_wc_endpoint_url', []rt.PhpVal{})))) || rt.get_superglobal('_GET').array_isset(rt.new_string('wc-ajax'))) || rt.get_superglobal('_POST').array_isset(rt.new_string('wc-ajax')) || rt.get_superglobal('_SERVER').array_isset(rt.new_string('REQUEST_URI')) && rt.is_true(rt.call_function('str_contains', [rt.get_superglobal('_SERVER').array_get(rt.new_string('REQUEST_URI')), rt.new_string('/wp-json/wc/')])) || rt.is_true(rt.call_function('str_contains', [rt.get_superglobal('_SERVER').array_get(rt.new_string('REQUEST_URI')), rt.new_string('wc-ajax')])))
		if rt.is_true(var_isWcPage) {
			mut var_speedGrade := rt.new_string('A')
			mut var_speedSuggestions := rt.new_array()
			if rt.is_true(rt.less(var_totalDurationMs, rt.new_float(300))) {
			var_speedGrade = rt.new_string('A (Excellent)')
			} else if rt.is_true(rt.less(var_totalDurationMs, rt.new_float(600))) {
			var_speedGrade = rt.new_string('B (Good)')
			} else if rt.is_true(rt.less(var_totalDurationMs, rt.new_float(1000))) {
				var_speedGrade = rt.new_string('C (Slow)')
				var_speedSuggestions.array_push('结账流页面耗时已达 ' + (var_totalDurationMs).str() + ' ms，接近 1 秒，可能引起部分订单流失。')
			} else {
				var_speedGrade = rt.new_string('D (Critical)')
				var_speedSuggestions.array_push('警告：结账流加载耗时高达 ' + (var_totalDurationMs).str() + ' ms，转化率存在极高流失风险！')
			}
			if rt.is_true(rt.greater(var_totalSqlDurationMs, rt.new_float(300))) {
				var_speedSuggestions.array_push('数据库查询总耗时达 ' + (rt.call_function('round', [var_totalSqlDurationMs.clone(), rt.new_int(2)])).str() + ' ms，其中 WooCommerce SQL 占了 ' + (rt.call_function('round', [var_wcSqlDurationMs.clone(), rt.new_int(2)])).str() + ' ms，建议优化相关电商慢查询。')
			}
			mut var_extTotalMs := rt.new_float(0)
			mut iter_19 := rt.get_static_prop('VHttpd_WordPress_Profiler', 'externalRequests').iterator()
			for {
				item_19 := iter_19.next() or { break }
				mut var_req := item_19.val
				var_extTotalMs = rt.add(var_extTotalMs, if !(var_req.array_get(rt.new_string('duration_ms'))).is_null() { var_req.array_get(rt.new_string('duration_ms')) } else { rt.new_float(0) })
			}
			if rt.is_true(rt.greater(var_extTotalMs, rt.new_float(100))) {
				var_speedSuggestions.array_push('外部第三方 API 请求耗时总计达 ' + (rt.call_function('round', [var_extTotalMs.clone(), rt.new_int(2)])).str() + ' ms，这严重阻塞了页面输出，请检查运费/支付插件。')
			}
			mut var_hposStatus := Class_VHttpd_WordPress_Profiler.getwchposstatus()
			if rt.is_true(rt.call_function('str_contains', [var_hposStatus.clone(), rt.new_string('Legacy')])) {
				var_speedSuggestions.array_push('检测到当前仍在使用 Postmeta 存储订单。建议在 WooCommerce 设置中开启高性能订单表 (HPOS) 以优化数据库并发吞吐量。')
			}
			if !rt.is_true(var_speedSuggestions) {
				var_speedSuggestions.array_push('您的电商页面性能表现完美，继续保持！')
			}
		var_woocommerceData = rt.create_array([rt.ArrayItem{ key: 'is_wc_page', val: true }, rt.ArrayItem{ key: 'version', val: if !(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'version')).is_null() { rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'version') } else { rt.new_string('unknown') } }, rt.ArrayItem{ key: 'cart', val: Class_VHttpd_WordPress_Profiler.getwccartsummary() }, rt.ArrayItem{ key: 'session', val: Class_VHttpd_WordPress_Profiler.getwcsessionsummary() }, rt.ArrayItem{ key: 'hpos_enabled', val: var_hposStatus }, rt.ArrayItem{ key: 'settings', val: Class_VHttpd_WordPress_Profiler.getwcsettingssummary() }, rt.ArrayItem{ key: 'queries', val: var_wcQueries }, rt.ArrayItem{ key: 'sql_duration_ms', val: rt.call_function('round', [var_wcSqlDurationMs.clone(), rt.new_int(2)]) }, rt.ArrayItem{ key: 'sql_count', val: var_wcQueries.clone().array_count() }, rt.ArrayItem{ key: 'speed_grade', val: var_speedGrade }, rt.ArrayItem{ key: 'speed_suggestions', val: var_speedSuggestions }])
		}
	}
	mut var_enhancedErrors := rt.new_array()
	mut iter_20 := rt.get_static_prop('VHttpd_WordPress_Profiler', 'errors').iterator()
	for {
		item_20 := iter_20.next() or { break }
		mut var_err := item_20.val
		mut var_errstr := if !(var_err.array_get(rt.new_string('message'))).is_null() { var_err.array_get(rt.new_string('message')) } else { rt.new_string('') }
		mut var_optimizationTip := rt.new_string('')
		mut var_errstrLower := rt.new_string(var_errstr.clone().to_string().to_lower())
		if rt.is_true(rt.call_function('str_contains', [var_errstrLower.clone(), rt.new_string('deprecated')])) || rt.is_true(rt.call_function('str_contains', [var_errstrLower.clone(), rt.new_string('creation of dynamic property')])) {
		var_optimizationTip = rt.new_string('💡 诊断：该报错由 PHP 8.x 对动态属性声明的废弃引起。可修改对应插件显式声明属性，或在 wp-config.php 中关闭 WP_DEBUG_DISPLAY 降低对界面干扰。')
		} else if rt.is_true(rt.call_function('str_contains', [var_errstrLower.clone(), rt.new_string('undefined array key')])) || rt.is_true(rt.call_function('str_contains', [var_errstrLower.clone(), rt.new_string('undefined variable')])) {
		var_optimizationTip = rt.new_string('💡 诊断：代码直接读取了未定义变量或数组键。可能导致潜在逻辑漏洞，建议在读取前使用 isset() 检查或赋初始值。')
		}
		var_err.array_set('optimization_tip', var_optimizationTip.clone())
		var_enhancedErrors.array_push(var_err.clone())
	}
	mut var_pluginOverview := rt.new_array()
	mut iter_21 := var_pluginSqlStats.iterator()
	for {
		item_21 := iter_21.next() or { break }
		mut var_data := item_21.val
		mut var_slug := item_21.key
		if !(var_pluginOverview.array_isset(var_slug)) {
			var_pluginOverview.array_set(var_slug, rt.create_array([rt.ArrayItem{ key: 'sql_duration_ms', val: 0 }, rt.ArrayItem{ key: 'sql_count', val: 0 }, rt.ArrayItem{ key: 'http_duration_ms', val: 0 }, rt.ArrayItem{ key: 'http_count', val: 0 }, rt.ArrayItem{ key: 'total_duration_ms', val: 0 }]))
		}
		var_pluginOverview.array_get_mut(var_slug).array_set('sql_duration_ms', rt.call_function('round', [var_data.array_get(rt.new_string('duration_ms')), rt.new_int(2)]))
		var_pluginOverview.array_get_mut(var_slug).array_set('sql_count', var_data.array_get(rt.new_string('count')))
		var_pluginOverview.array_get(var_slug).array_get(rt.new_string('total_duration_ms')) = rt.add(var_pluginOverview.array_get(var_slug).array_get(rt.new_string('total_duration_ms')), var_data.array_get(rt.new_string('duration_ms')))
	}
	mut iter_22 := var_pluginHttpStats.iterator()
	for {
		item_22 := iter_22.next() or { break }
		mut var_data := item_22.val
		mut var_slug := item_22.key
		if !(var_pluginOverview.array_isset(var_slug)) {
			var_pluginOverview.array_set(var_slug, rt.create_array([rt.ArrayItem{ key: 'sql_duration_ms', val: 0 }, rt.ArrayItem{ key: 'sql_count', val: 0 }, rt.ArrayItem{ key: 'http_duration_ms', val: 0 }, rt.ArrayItem{ key: 'http_count', val: 0 }, rt.ArrayItem{ key: 'total_duration_ms', val: 0 }]))
		}
		var_pluginOverview.array_get_mut(var_slug).array_set('http_duration_ms', rt.call_function('round', [var_data.array_get(rt.new_string('duration_ms')), rt.new_int(2)]))
		var_pluginOverview.array_get_mut(var_slug).array_set('http_count', var_data.array_get(rt.new_string('count')))
		var_pluginOverview.array_get(var_slug).array_get(rt.new_string('total_duration_ms')) = rt.add(var_pluginOverview.array_get(var_slug).array_get(rt.new_string('total_duration_ms')), var_data.array_get(rt.new_string('duration_ms')))
	}
	closure_7_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_a := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_b := if args.len > 1 { args[1].clone() } else { rt.new_null() }
		return rt.new_null()
		}
	rt.call_function('uasort', [var_pluginOverview.clone(), rt.new_closure(closure_7_fn)])
	mut var_pluginStatsList := rt.new_array()
	mut iter_23 := var_pluginOverview.iterator()
	for {
		item_23 := iter_23.next() or { break }
		mut var_data := item_23.val
		mut var_slug := item_23.key
		var_pluginStatsList.array_push(rt.call_function('array_merge', [rt.create_array([rt.ArrayItem{ key: 'slug', val: var_slug }]), var_data.clone()]))
	}
	return rt.create_array([rt.ArrayItem{ key: 'request_id', val: var_requestId }, rt.ArrayItem{ key: 'trace_id', val: var_traceId }, rt.ArrayItem{ key: 'timestamp', val: rt.call_function('time', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'overview', val: rt.create_array([rt.ArrayItem{ key: 'total_duration_ms', val: var_totalDurationMs }, rt.ArrayItem{ key: 'sql_duration_ms', val: rt.call_function('round', [var_totalSqlDurationMs.clone(), rt.new_int(2)]) }, rt.ArrayItem{ key: 'sql_count', val: var_queries.clone().array_count() }, rt.ArrayItem{ key: 'slow_queries_count', val: var_slowQueriesCount }, rt.ArrayItem{ key: 'peak_memory', val: if rt.is_true(rt.call_function('function_exists', [rt.new_string('size_format')])) { rt.call_function('size_format', [var_peakMemory.clone()]) } else { (var_peakMemory).str() + ' B' } }, rt.ArrayItem{ key: 'memory_diff', val: var_memoryDiffFormatted }, rt.ArrayItem{ key: 'cache_ratio', val: var_cacheStats.array_get(rt.new_string('ratio')) }, rt.ArrayItem{ key: 'slowest_plugin_sql', val: var_slowestPluginSql }, rt.ArrayItem{ key: 'slowest_plugin_http', val: var_slowestPluginHttp }]) }, rt.ArrayItem{ key: 'checkpoints', val: var_checkpoints }, rt.ArrayItem{ key: 'queries', val: var_queries }, rt.ArrayItem{ key: 'cache', val: var_cacheStats }, rt.ArrayItem{ key: 'hooks', val: var_topHooks }, rt.ArrayItem{ key: 'logs', val: rt.get_static_prop('VHttpd_WordPress_Profiler', 'logs') }, rt.ArrayItem{ key: 'errors', val: var_enhancedErrors }, rt.ArrayItem{ key: 'env', val: var_envDiagnostics }, rt.ArrayItem{ key: 'db_pool', val: var_dbPool }, rt.ArrayItem{ key: 'vhttpd', val: var_vhttpdStats }, rt.ArrayItem{ key: 'external_requests', val: rt.get_static_prop('VHttpd_WordPress_Profiler', 'externalRequests') }, rt.ArrayItem{ key: 'woocommerce', val: var_woocommerceData }, rt.ArrayItem{ key: 'security', val: Class_VHttpd_WordPress_Profiler.getsecuritydiagnostics() }, rt.ArrayItem{ key: 'plugin_stats', val: var_pluginStatsList }])
}

fn Class_VHttpd_WordPress_Profiler.getcachebypassreasons() rt.PhpVal {
	mut var_reasons := rt.new_array()
	mut var_method := if !(rt.get_superglobal('_SERVER').array_get(rt.new_string('REQUEST_METHOD'))).is_null() { rt.get_superglobal('_SERVER').array_get(rt.new_string('REQUEST_METHOD')) } else { rt.new_string('GET') }
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_method, rt.new_string('GET'))))) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_method, rt.new_string('HEAD'))))) {
		var_reasons.array_push("请求方法为 ${var_method.to_string()}，vhttpd 默认只缓存 GET/HEAD 请求以确保安全。")
	}
	mut var_hasLoginCookie := rt.new_bool(false)
	mut iter_24 := rt.func_array_keys(rt.get_superglobal('_COOKIE').clone()).iterator()
	for {
		item_24 := iter_24.next() or { break }
		mut var_cookieName := item_24.val
		if rt.is_true(rt.call_function('str_starts_with', [rt.new_string((var_cookieName).str()), rt.new_string('wordpress_logged_in_')])) {
			var_hasLoginCookie = rt.new_bool(true)
			break
		}
	}
	if rt.is_true(var_hasLoginCookie) {
		var_reasons.array_push('检测到已登录用户的 Cookie，vhttpd 旁路了缓存以呈现个性化的后台或用户内容。')
	}
	mut var_hasWcSession := rt.new_bool(false)
	mut var_hasWcCart := rt.new_bool(false)
	mut iter_25 := rt.func_array_keys(rt.get_superglobal('_COOKIE').clone()).iterator()
	for {
		item_25 := iter_25.next() or { break }
		mut var_cookieName := item_25.val
		if rt.is_true(rt.call_function('str_starts_with', [rt.new_string((var_cookieName).str()), rt.new_string('wp_woocommerce_session_')])) {
		var_hasWcSession = rt.new_bool(true)
		}
		if rt.is_true(rt.call_function('str_contains', [rt.new_string((var_cookieName).str()), rt.new_string('woocommerce_items_in_cart')])) {
		var_hasWcCart = rt.new_bool(true)
		}
	}
	if rt.is_true(var_hasWcSession) {
		var_reasons.array_push('检测到 WooCommerce 活跃会话 Cookie，为了防止购物车数据或会话发生串线，vhttpd 旁路了全局缓存。')
	}
	if rt.is_true(var_hasWcCart) && rt.get_superglobal('_COOKIE').array_isset(rt.new_string('woocommerce_items_in_cart')) && rt.new_int((rt.get_superglobal('_COOKIE').array_get(rt.new_string('woocommerce_items_in_cart'))).to_i64()) > 0 {
		var_reasons.array_push('检测到购物车内已有商品，vhttpd 旁路了静态缓存以保证结账流程的准确性。')
	}
	if rt.is_true(rt.call_function('function_exists', [rt.new_string('is_admin')])) && rt.is_true(rt.call_function('is_admin', []rt.PhpVal{})) {
		var_reasons.array_push('当前处于 WordPress 后台管理界面，默认不进行页面缓存。')
	}
	mut var_headers := if rt.is_true(rt.call_function('function_exists', [rt.new_string('getallheaders')])) { rt.call_function('getallheaders', []rt.PhpVal{}) } else { rt.new_array() }
	mut var_cacheControl := rt.new_string('')
	mut iter_26 := var_headers.iterator()
	for {
		item_26 := iter_26.next() or { break }
		mut var_v := item_26.val
		mut var_k := item_26.key
		if rt.is_true(rt.identical(rt.new_string((var_k).str().to_lower()), rt.new_string('cache-control'))) {
			var_cacheControl = rt.new_string((var_v).str().to_lower())
			break
		}
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_cacheControl, rt.new_string(''))))) && rt.is_true(rt.call_function('str_contains', [var_cacheControl.clone(), rt.new_string('no-cache')])) || rt.is_true(rt.call_function('str_contains', [var_cacheControl.clone(), rt.new_string('no-store')])) {
		var_reasons.array_push("客户端发起了强制刷新头 (Cache-Control: ${var_cacheControl.to_string()})，旁路了 vhttpd 缓存。")
	}
	return var_reasons.clone()
}

fn Class_VHttpd_WordPress_Profiler.getsecuritydiagnostics() rt.PhpVal {
	mut var_headersStatus := rt.create_array([rt.ArrayItem{ key: 'Content-Security-Policy', val: false }, rt.ArrayItem{ key: 'X-Frame-Options', val: false }, rt.ArrayItem{ key: 'X-Content-Type-Options', val: false }, rt.ArrayItem{ key: 'Referrer-Policy', val: false }, rt.ArrayItem{ key: 'Permissions-Policy', val: false }])
	mut var_sentHeaders := rt.call_function('headers_list', []rt.PhpVal{})
	mut iter_27 := var_sentHeaders.iterator()
	for {
		item_27 := iter_27.next() or { break }
		mut var_headerLine := item_27.val
		mut var_parts := rt.call_function('explode', [rt.new_string(':'), var_headerLine.clone(), rt.new_int(2)])
		if var_parts.clone().array_count() == 2 {
			mut var_name := rt.new_string(var_parts.array_get(rt.new_int(0)).to_string().trim_space())
			mut var_lowName := rt.new_string(var_name.clone().to_string().to_lower())
			mut iter_28 := rt.func_array_keys(var_headersStatus.clone()).iterator()
			for {
				item_28 := iter_28.next() or { break }
				mut var_secHeader := item_28.val
				if rt.is_true(rt.identical(rt.new_string(var_secHeader.clone().to_string().to_lower()), var_lowName)) {
					var_headersStatus.array_set(var_secHeader, true)
				}
			}
		}
	}
	mut var_suggestedToml := rt.new_string('')
	mut var_missingHeaders := rt.new_array()
	mut iter_29 := var_headersStatus.iterator()
	for {
		item_29 := iter_29.next() or { break }
		mut var_configured := item_29.val
		mut var_secHeader := item_29.key
		if rt.is_true(rt.new_bool(!(rt.is_true(var_configured)))) {
			if rt.is_true(rt.identical(var_secHeader, rt.new_string('Content-Security-Policy'))) {
				var_missingHeaders.array_push('Content-Security-Policy = "default-src \'self\' \'unsafe-inline\' \'unsafe-eval\' https:;"')
			} else if rt.is_true(rt.identical(var_secHeader, rt.new_string('X-Frame-Options'))) {
				var_missingHeaders.array_push('X-Frame-Options = "SAMEORIGIN"')
			} else if rt.is_true(rt.identical(var_secHeader, rt.new_string('X-Content-Type-Options'))) {
				var_missingHeaders.array_push('X-Content-Type-Options = "nosniff"')
			} else if rt.is_true(rt.identical(var_secHeader, rt.new_string('Referrer-Policy'))) {
				var_missingHeaders.array_push('Referrer-Policy = "strict-origin-when-cross-origin"')
			} else if rt.is_true(rt.identical(var_secHeader, rt.new_string('Permissions-Policy'))) {
				var_missingHeaders.array_push('Permissions-Policy = "geolocation=(), microphone=()"')
			}
		}
	}
	if !(!rt.is_true(var_missingHeaders)) {
	var_suggestedToml = rt.new_string('# 建议在 vhttpd.toml 的 [http.headers] 段中添加以下配置以加固站点安全：\n[http.headers]\n' + (rt.call_function('implode', [rt.new_string('\n'), var_missingHeaders.clone()])).str() + '\n')
	}
	mut var_rateLimitLimit := if rt.is_true(rt.call_function('getenv', [rt.new_string('VHTTPD_RATELIMIT_LIMIT')])) { rt.call_function('getenv', [rt.new_string('VHTTPD_RATELIMIT_LIMIT')]) } else { if !(rt.get_superglobal('_SERVER').array_get(rt.new_string('VHTTPD_RATELIMIT_LIMIT'))).is_null() { rt.get_superglobal('_SERVER').array_get(rt.new_string('VHTTPD_RATELIMIT_LIMIT')) } else { rt.new_string('600') } }
	mut var_rateLimitRemaining := if rt.is_true(rt.call_function('getenv', [rt.new_string('VHTTPD_RATELIMIT_REMAINING')])) { rt.call_function('getenv', [rt.new_string('VHTTPD_RATELIMIT_REMAINING')]) } else { if !(rt.get_superglobal('_SERVER').array_get(rt.new_string('VHTTPD_RATELIMIT_REMAINING'))).is_null() { rt.get_superglobal('_SERVER').array_get(rt.new_string('VHTTPD_RATELIMIT_REMAINING')) } else { rt.new_string('588') } }
	return rt.create_array([rt.ArrayItem{ key: 'headers_status', val: var_headersStatus }, rt.ArrayItem{ key: 'rate_limit_limit', val: var_rateLimitLimit }, rt.ArrayItem{ key: 'rate_limit_remaining', val: var_rateLimitRemaining }, rt.ArrayItem{ key: 'is_https', val: rt.get_superglobal('_SERVER').array_isset(rt.new_string('HTTPS')) && rt.is_true(rt.identical(rt.get_superglobal('_SERVER').array_get(rt.new_string('HTTPS')), rt.new_string('on'))) }, rt.ArrayItem{ key: 'suggested_toml', val: var_suggestedToml }])
}

fn Class_VHttpd_WordPress_Profiler.getwccartsummary() rt.PhpVal {
	if !(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'cart')).is_null() && rt.is_true(rt.new_bool(rt.instance_of(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'cart'), 'VHttpd_WordPress_WC_Cart'))) {
		return rt.create_array([rt.ArrayItem{ key: 'contents_count', val: rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'cart'), 'get_cart_contents_count', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'subtotal', val: rt.call_function('html_entity_decode', [rt.call_function('strip_tags', [rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'cart'), 'get_cart_subtotal', []rt.PhpVal{})])]) }, rt.ArrayItem{ key: 'total', val: rt.call_function('html_entity_decode', [rt.call_function('strip_tags', [rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'cart'), 'get_cart_total', []rt.PhpVal{})])]) }, rt.ArrayItem{ key: 'needs_shipping', val: rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'cart'), 'needs_shipping', []rt.PhpVal{}) }])
		unsafe { goto end_label_6 }

catch_label_6:
		mut var_e_6 := rt.get_and_clear_exception()
		if rt.instance_of(var_e_6, 'VHttpd_WordPress_Throwable') {
			mut var_e := var_e_6.clone()
			return rt.create_array([rt.ArrayItem{ key: 'error', val: 'failed to read cart: ' + (rt.call_method(var_e, 'getMessage', []rt.PhpVal{})).str() }])
			unsafe { goto end_label_6 }
		}
		else {
			rt.throw_exception(var_e_6)
			unsafe { goto end_label_6 }
		}

end_label_6:
	}
	return rt.create_array([rt.ArrayItem{ key: 'contents_count', val: 0 }, rt.ArrayItem{ key: 'subtotal', val: 'N/A' }, rt.ArrayItem{ key: 'total', val: 'N/A' }, rt.ArrayItem{ key: 'needs_shipping', val: false }])
}

fn Class_VHttpd_WordPress_Profiler.getwcsessionsummary() rt.PhpVal {
	if !(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'session')).is_null() && rt.is_true(rt.new_bool(rt.instance_of(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'session'), 'VHttpd_WordPress_WC_Session'))) {
		mut var_cookieName := rt.new_string('wp_woocommerce_session_' + (rt.get_constant('COOKIEHASH')).str())
		if rt.has_exception() { unsafe { goto catch_label_7 } }
		mut var_hasSessionCookie := rt.new_bool(rt.get_superglobal('_COOKIE').array_isset(var_cookieName))
		if rt.has_exception() { unsafe { goto catch_label_7 } }
		return rt.create_array([rt.ArrayItem{ key: 'customer_id', val: rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'session'), 'get_customer_id', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'has_cookie', val: var_hasSessionCookie }, rt.ArrayItem{ key: 'session_cookie_name', val: if rt.is_true(var_hasSessionCookie) { var_cookieName } else { rt.new_string('none') } }, rt.ArrayItem{ key: 'session_expiration', val: rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'session'), 'get_session_expiration', []rt.PhpVal{}) }])
		unsafe { goto end_label_7 }

catch_label_7:
		mut var_e_7 := rt.get_and_clear_exception()
		if rt.instance_of(var_e_7, 'VHttpd_WordPress_Throwable') {
			mut var_e := var_e_7.clone()
			return rt.create_array([rt.ArrayItem{ key: 'error', val: 'failed to read session: ' + (rt.call_method(var_e, 'getMessage', []rt.PhpVal{})).str() }])
			unsafe { goto end_label_7 }
		}
		else {
			rt.throw_exception(var_e_7)
			unsafe { goto end_label_7 }
		}

end_label_7:
	}
	return rt.create_array([rt.ArrayItem{ key: 'customer_id', val: 0 }, rt.ArrayItem{ key: 'has_cookie', val: false }])
}

fn Class_VHttpd_WordPress_Profiler.getwchposstatus() string {
	if rt.is_true(rt.call_function('class_exists', [Class_VHttpd_WordPress_Automattic_WooCommerce_Internal_DataStores_Orders_CustomOrdersTableController.class()])) {
		mut var_controller := Class_VHttpd_WordPress_Automattic_WooCommerce_Internal_DataStores_Orders_CustomOrdersTableController.class()
		if rt.has_exception() { unsafe { goto catch_label_8 } }
		mut iife_temp_7 := Class_VHttpd_WordPress_{"nodeType":"Expr_Variable","line":1252,"name":"controller"}{}
		mut iife_result_7 := iife_temp_7.is_active_and_enabled()
		if rt.is_true(rt.call_function('method_exists', [var_controller.clone(), rt.new_string('is_active_and_enabled')])) && rt.is_true(iife_result_7) {
			return 'HPOS Enabled (High-Performance)'
		}
		if rt.has_exception() { unsafe { goto catch_label_8 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_8 } }
	unsafe { goto end_label_8 }

catch_label_8:
	mut var_e_8 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_8, 'VHttpd_WordPress_Throwable') {
		mut var_e := var_e_8.clone()
		unsafe { goto end_label_8 }
	}
	else {
		rt.throw_exception(var_e_8)
		unsafe { goto end_label_8 }
	}

end_label_8:
	return 'Legacy Postmeta (Slow)'
}

fn Class_VHttpd_WordPress_Profiler.getwcsettingssummary() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: 'calc_taxes', val: rt.identical(rt.call_function('get_option', [rt.new_string('woocommerce_calc_taxes')]), rt.new_string('yes')) }, rt.ArrayItem{ key: 'calc_shipping', val: rt.identical(rt.call_function('get_option', [rt.new_string('woocommerce_calc_shipping')]), rt.new_string('yes')) }, rt.ArrayItem{ key: 'template_debug', val: rt.is_true(rt.call_function('defined', [rt.new_string('WC_TEMPLATE_DEBUG')])) && rt.is_true(rt.get_constant('WC_TEMPLATE_DEBUG')) }, rt.ArrayItem{ key: 'checkout_pay_page', val: rt.is_true(rt.call_function('function_exists', [rt.new_string('is_checkout')])) && rt.is_true(rt.call_function('is_checkout', []rt.PhpVal{})) && rt.get_superglobal('_GET').array_isset(rt.new_string('pay_for_order')) }, rt.ArrayItem{ key: 'ajax_endpoint', val: if rt.get_superglobal('_GET').array_isset(rt.new_string('wc-ajax')) { rt.get_superglobal('_GET').array_get(rt.new_string('wc-ajax')) } else { if rt.get_superglobal('_POST').array_isset(rt.new_string('wc-ajax')) { rt.get_superglobal('_POST').array_get(rt.new_string('wc-ajax')) } else { rt.new_string('none') } } }])
}

struct Class_VHttpd_WordPress_WP_REST_Response {
	rt.PhpObjectBase
}

struct Class_VHttpd_Wire_JsonClient {
	rt.PhpObjectBase
}

struct Class_VHttpd_WordPress_VHttpd_Cache_Client {
	rt.PhpObjectBase
}

struct Class_VHttpd_WordPress_ReflectionFunction {
	rt.PhpObjectBase
}

struct Class_VHttpd_WordPress_ReflectionMethod {
	rt.PhpObjectBase
}

struct Class_VHttpd_WordPress_{"nodeType":"Expr_Variable","line":1252,"name":"controller"} {
	rt.PhpObjectBase
}

fn create_vhttpd_wordpress_profiler(_args ...rt.PhpVal) &Class_VHttpd_WordPress_Profiler {
	mut obj := &Class_VHttpd_WordPress_Profiler{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_vhttpd_wordpress_wp_rest_response(_args ...rt.PhpVal) &Class_VHttpd_WordPress_WP_REST_Response {
	mut obj := &Class_VHttpd_WordPress_WP_REST_Response{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_vhttpd_wire_jsonclient(_args ...rt.PhpVal) &Class_VHttpd_Wire_JsonClient {
	mut obj := &Class_VHttpd_Wire_JsonClient{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_vhttpd_wordpress_vhttpd_cache_client(_args ...rt.PhpVal) &Class_VHttpd_WordPress_VHttpd_Cache_Client {
	mut obj := &Class_VHttpd_WordPress_VHttpd_Cache_Client{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_vhttpd_wordpress_reflectionfunction(_args ...rt.PhpVal) &Class_VHttpd_WordPress_ReflectionFunction {
	mut obj := &Class_VHttpd_WordPress_ReflectionFunction{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_vhttpd_wordpress_reflectionmethod(_args ...rt.PhpVal) &Class_VHttpd_WordPress_ReflectionMethod {
	mut obj := &Class_VHttpd_WordPress_ReflectionMethod{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_vhttpd_wordpress_{"nodetype":"expr_variable","line":1252,"name":"controller"}(_args ...rt.PhpVal) &Class_VHttpd_WordPress_{"nodeType":"Expr_Variable","line":1252,"name":"controller"} {
	mut obj := &Class_VHttpd_WordPress_{"nodeType":"Expr_Variable","line":1252,"name":"controller"}{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_VHttpd_WordPress_Profiler) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'reset' {
			Class_VHttpd_WordPress_Profiler.reset()
			return rt.new_null()
		}
		'start' {
			Class_VHttpd_WordPress_Profiler.start()
			return rt.new_null()
		}
		'activate' {
			Class_VHttpd_WordPress_Profiler.activate()
			return rt.new_null()
		}
		'stopAndDeactivate' {
			Class_VHttpd_WordPress_Profiler.stopanddeactivate()
			return rt.new_null()
		}
		'log' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_VHttpd_WordPress_mixed](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			Class_VHttpd_WordPress_Profiler.log(mut dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'countHook' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			Class_VHttpd_WordPress_Profiler.counthook(dispatch_arg_0)
			return rt.new_null()
		}
		'captureQueryStack' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(Class_VHttpd_WordPress_Profiler.capturequerystack(dispatch_arg_0))
		}
		'logExternalRequestStart' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_VHttpd_WordPress_mixed](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_VHttpd_WordPress_array](if args.len > 1 { args[1] } else { rt.new_null() })
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			return Class_VHttpd_WordPress_Profiler.logexternalrequeststart(mut dispatch_arg_0, mut dispatch_arg_1, dispatch_arg_2)
		}
		'logExternalRequestEnd' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_VHttpd_WordPress_mixed](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			mut dispatch_arg_3 := rt.cast_object_ptr[Class_VHttpd_WordPress_array](if args.len > 3 { args[3] } else { rt.new_null() })
			dispatch_arg_4 := (if args.len > 4 { args[4] } else { rt.new_null() }).str()
			Class_VHttpd_WordPress_Profiler.logexternalrequestend(mut dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, mut dispatch_arg_3, dispatch_arg_4)
			return rt.new_null()
		}
		'handleError' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).to_i64()
			return rt.new_bool(Class_VHttpd_WordPress_Profiler.handleerror(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3))
		}
		'handleException' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_VHttpd_WordPress_Throwable](if args.len > 0 { args[0] } else { rt.new_null() })
			Class_VHttpd_WordPress_Profiler.handleexception(mut dispatch_arg_0)
			return rt.new_null()
		}
		'injectWidget' {
			Class_VHttpd_WordPress_Profiler.injectwidget()
			return rt.new_null()
		}
		'handleShutdown' {
			Class_VHttpd_WordPress_Profiler.handleshutdown()
			return rt.new_null()
		}
		'registerRestRoute' {
			Class_VHttpd_WordPress_Profiler.registerrestroute()
			return rt.new_null()
		}
		'getRestReport' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_VHttpd_WordPress_WP_REST_Request](if args.len > 0 { args[0] } else { rt.new_null() })
			return Class_VHttpd_WordPress_Profiler.getrestreport(mut dispatch_arg_0)
		}
		'cleanPath' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(Class_VHttpd_WordPress_Profiler.cleanpath(dispatch_arg_0))
		}
		'cleanTrace' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(Class_VHttpd_WordPress_Profiler.cleantrace(dispatch_arg_0))
		}
		'getAdminSocketPath' {
			return rt.new_string(Class_VHttpd_WordPress_Profiler.getadminsocketpath())
		}
		'fetchDbPoolStats' {
			return Class_VHttpd_WordPress_Profiler.fetchdbpoolstats()
		}
		'fetchVHttpdStats' {
			return Class_VHttpd_WordPress_Profiler.fetchvhttpdstats()
		}
		'fetchExecutors' {
			return Class_VHttpd_WordPress_Profiler.fetchexecutors()
		}
		'maskSensitiveData' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_VHttpd_WordPress_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return Class_VHttpd_WordPress_Profiler.masksensitivedata(mut dispatch_arg_0)
		}
		'getPluginSlug' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(Class_VHttpd_WordPress_Profiler.getpluginslug(dispatch_arg_0))
		}
		'buildReport' {
			return Class_VHttpd_WordPress_Profiler.buildreport()
		}
		'getCacheBypassReasons' {
			return Class_VHttpd_WordPress_Profiler.getcachebypassreasons()
		}
		'getSecurityDiagnostics' {
			return Class_VHttpd_WordPress_Profiler.getsecuritydiagnostics()
		}
		'getWcCartSummary' {
			return Class_VHttpd_WordPress_Profiler.getwccartsummary()
		}
		'getWcSessionSummary' {
			return Class_VHttpd_WordPress_Profiler.getwcsessionsummary()
		}
		'getWcHposStatus' {
			return rt.new_string(Class_VHttpd_WordPress_Profiler.getwchposstatus())
		}
		'getWcSettingsSummary' {
			return Class_VHttpd_WordPress_Profiler.getwcsettingssummary()
		}
		else { return none }
	}
}

fn (this &Class_VHttpd_WordPress_Profiler) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_VHttpd_WordPress_Profiler) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_VHttpd_WordPress_WP_REST_Response) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_VHttpd_WordPress_WP_REST_Response) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_VHttpd_WordPress_WP_REST_Response) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_VHttpd_Wire_JsonClient) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_VHttpd_Wire_JsonClient) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_VHttpd_Wire_JsonClient) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_VHttpd_WordPress_VHttpd_Cache_Client) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_VHttpd_WordPress_VHttpd_Cache_Client) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_VHttpd_WordPress_VHttpd_Cache_Client) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_VHttpd_WordPress_ReflectionFunction) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_VHttpd_WordPress_ReflectionFunction) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_VHttpd_WordPress_ReflectionFunction) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_VHttpd_WordPress_ReflectionMethod) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_VHttpd_WordPress_ReflectionMethod) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_VHttpd_WordPress_ReflectionMethod) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_VHttpd_WordPress_{"nodeType":"Expr_Variable","line":1252,"name":"controller"}) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_VHttpd_WordPress_{"nodeType":"Expr_Variable","line":1252,"name":"controller"}) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_VHttpd_WordPress_{"nodeType":"Expr_Variable","line":1252,"name":"controller"}) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}



fn main() {
	defer {
		rt.shutdown()
	}

}
