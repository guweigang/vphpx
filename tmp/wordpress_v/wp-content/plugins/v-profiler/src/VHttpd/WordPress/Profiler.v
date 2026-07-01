import rt
import crypto.md5

struct Class_VHttpd_WordPress_Profiler {
	rt.PhpObjectBase
pub mut:
		startTime rt.PhpVal = rt.new_float(0)
		logs rt.PhpVal = rt.new_array()
		errors rt.PhpVal = rt.new_array()
		timeline rt.PhpVal = rt.new_array()
		hookCounts rt.PhpVal = rt.new_array()
		started rt.PhpVal = rt.new_bool(false)
		active rt.PhpVal = rt.new_bool(false)
		footerInjected rt.PhpVal = rt.new_bool(false)
		currentRequestId rt.PhpVal = rt.new_string('')
		errorHandlersRegistered rt.PhpVal = rt.new_bool(false)
		startMemory rt.PhpVal = rt.new_int(0)
		externalRequests rt.PhpVal = rt.new_array()
		tempRequestTimes rt.PhpVal = rt.new_array()
		queryStacks rt.PhpVal = rt.new_array()
		prevErrorHandler rt.PhpVal = rt.new_null()
		prevExceptionHandler rt.PhpVal = rt.new_null()
}

fn Class_VHttpd_WordPress_Profiler.reset()  {
	mut var_wpdb := rt.new_null()
	// unsupported assign target: Expr_StaticPropertyFetch
	// unsupported assign target: Expr_StaticPropertyFetch
	// unsupported assign target: Expr_StaticPropertyFetch
	// unsupported assign target: Expr_StaticPropertyFetch
	// unsupported assign target: Expr_StaticPropertyFetch
	// unsupported expression: Expr_StaticPropertyFetch.array_set('start', // unsupported expression: Expr_StaticPropertyFetch)
	// unsupported assign target: Expr_StaticPropertyFetch
	// unsupported assign target: Expr_StaticPropertyFetch
	// unsupported assign target: Expr_StaticPropertyFetch
	// unsupported assign target: Expr_StaticPropertyFetch
	// unsupported assign target: Expr_StaticPropertyFetch
	// unsupported statement: Stmt_Global
	if rt.is_true(rt.new_bool(!(var_wpdb).is_null() && rt.is_true(rt.new_bool(var_wpdb.dup().is_object())))) {
		rt.set_property(var_wpdb, 'queries', rt.new_array())
	}
}

fn Class_VHttpd_WordPress_Profiler.start()  {
	mut var_requestId := if rt.is_true(rt.call_function('getenv', [rt.new_string('VHTTPD_REQUEST_ID')])) { rt.call_function('getenv', [rt.new_string('VHTTPD_REQUEST_ID')]) } else { if !(rt.get_superglobal('_SERVER').array_get('VHTTPD_REQUEST_ID')).is_null() { rt.get_superglobal('_SERVER').array_get('VHTTPD_REQUEST_ID') } else { rt.new_string('unknown') } }
	if rt.is_true(rt.new_bool(rt.is_true(rt.identical(// unsupported expression: Expr_StaticPropertyFetch, var_requestId)) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		return rt.new_null()
	}
	// unsupported assign target: Expr_StaticPropertyFetch
	Class_VHttpd_WordPress_Profiler.reset()
	// unsupported assign target: Expr_StaticPropertyFetch
	if rt.is_true(rt.new_bool(!(rt.is_true(// unsupported expression: Expr_StaticPropertyFetch)))) {
		// unsupported assign target: Expr_StaticPropertyFetch
		// unsupported assign target: Expr_StaticPropertyFetch
		rt.call_function('register_shutdown_function', [rt.create_array([rt.ArrayItem{ key: none, val: Class_VHttpd_WordPress_VHttpd_WordPress_Profiler.class() }, rt.ArrayItem{ key: none, val: 'handleShutdown' }])])
		// unsupported assign target: Expr_StaticPropertyFetch
		if rt.is_true(rt.call_function('function_exists', [rt.new_string('add_action')])) {
			rt.call_function('add_action', [rt.new_string('all'), rt.create_array([rt.ArrayItem{ key: none, val: Class_VHttpd_WordPress_VHttpd_WordPress_Profiler.class() }, rt.ArrayItem{ key: none, val: 'countHook' }])])
		}
	}
}

fn Class_VHttpd_WordPress_Profiler.activate()  {
	if rt.is_true(rt.new_bool(!(rt.is_true(// unsupported expression: Expr_StaticPropertyFetch)))) {
		Class_VHttpd_WordPress_Profiler.start()
	}
	// unsupported assign target: Expr_StaticPropertyFetch
	// unsupported expression: Expr_StaticPropertyFetch.array_set('init', rt.call_function('microtime', [rt.new_bool(true)]))
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('SAVEQUERIES')]))))) {
		rt.call_function('define', [rt.new_string('SAVEQUERIES'), rt.new_bool(true)])
	}
	if rt.is_true(rt.call_function('function_exists', [rt.new_string('add_action')])) {
		closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	// unsupported expression: Expr_StaticPropertyFetch.array_set('template_redirect', rt.call_function('microtime', [rt.new_bool(true)]))
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

fn Class_VHttpd_WordPress_Profiler.stopanddeactivate()  {
	if rt.is_true(rt.new_bool(!(rt.is_true(// unsupported expression: Expr_StaticPropertyFetch)))) {
		return rt.new_null()
	}
	// unsupported assign target: Expr_StaticPropertyFetch
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		rt.call_function('set_error_handler', [// unsupported expression: Expr_StaticPropertyFetch])
	} else {
		rt.call_function('restore_error_handler', []rt.PhpVal{})
	}
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		rt.call_function('set_exception_handler', [// unsupported expression: Expr_StaticPropertyFetch])
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

fn Class_VHttpd_WordPress_Profiler.log(mut var_var Class_VHttpd_WordPress_mixed, label string, level string)  {
	if rt.is_true(rt.new_bool(!(rt.is_true(// unsupported expression: Expr_StaticPropertyFetch)))) {
		return rt.new_null()
	}
	// unsupported expression: Expr_StaticPropertyFetch.array_push(rt.create_array([rt.ArrayItem{ key: 'label', val: label }, rt.ArrayItem{ key: 'level', val: level }, rt.ArrayItem{ key: 'data', val: if rt.is_true(rt.call_function('is_scalar', [var_var])) { var_var } else { println(var_var.to_string()) } }, rt.ArrayItem{ key: 'timestamp', val: rt.call_function('microtime', [rt.new_bool(true)]) }]))
}

fn Class_VHttpd_WordPress_Profiler.counthook(tag string)  {
	if rt.is_true(rt.new_bool(!(rt.is_true(// unsupported expression: Expr_StaticPropertyFetch)))) {
		return rt.new_null()
	}
	// unsupported expression: Expr_StaticPropertyFetch.array_set(tag, rt.add(if !(// unsupported expression: Expr_StaticPropertyFetch.array_get(tag)).is_null() { // unsupported expression: Expr_StaticPropertyFetch.array_get(tag) } else { rt.new_int(0) }, rt.new_int(1)))
}

fn Class_VHttpd_WordPress_Profiler.capturequerystack(query string) string {
	if rt.is_true(// unsupported expression: Expr_StaticPropertyFetch) {
		mut var_stack := rt.call_function('debug_backtrace', [rt.get_constant('DEBUG_BACKTRACE_IGNORE_ARGS'), rt.new_int(12)])
		mut var_filtered := rt.new_array()
		{
			mut iter_1 := var_stack.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_frame := item_1.val
				if var_frame.array_isset(rt.new_string('file')) {
					mut var_file := Class_VHttpd_WordPress_Profiler.cleanpath((var_frame.array_get('file')).str())
					if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.call_function('str_contains', [var_file.dup(), rt.new_string('Profiler.php')])) || rt.is_true(rt.call_function('str_contains', [var_file.dup(), rt.new_string('wp-db.php')])))) || rt.is_true(rt.call_function('str_contains', [var_file.dup(), rt.new_string('db.php')])))) {
						continue
					}
					mut var_func := if !(var_frame.array_get('function')).is_null() { var_frame.array_get('function') } else { rt.new_string('') }
					mut var_class := if !(var_frame.array_get('class')).is_null() { var_frame.array_get('class') } else { rt.new_string('') }
					var_filtered.array_push(rt.create_array([rt.ArrayItem{ key: 'file', val: var_file }, rt.ArrayItem{ key: 'line', val: if !(var_frame.array_get('line')).is_null() { var_frame.array_get('line') } else { rt.new_int(0) } }, rt.ArrayItem{ key: 'caller', val: if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) { rt.new_string("${var_class.to_string()}::${var_func.to_string()}") } else { var_func } }]))
				}
			}
		}
		// unsupported expression: Expr_StaticPropertyFetch.array_push(var_filtered.dup())
	}
	return query
}

fn Class_VHttpd_WordPress_Profiler.logexternalrequeststart(mut var_pre Class_VHttpd_WordPress_mixed, mut var_args Class_VHttpd_WordPress_array, url string) rt.PhpVal {
	if rt.is_true(// unsupported expression: Expr_StaticPropertyFetch) {
		mut var_key := rt.new_string(rt.new_string(md5.hexhash(url + (rt.call_function('serialize', [var_args])).str())))
		// unsupported expression: Expr_StaticPropertyFetch.array_set(var_key, rt.call_function('microtime', [rt.new_bool(true)]))
	}
	return rt.new_object('VHttpd_WordPress_mixed', []string{}, var_pre)
}

fn Class_VHttpd_WordPress_Profiler.logexternalrequestend(mut var_response Class_VHttpd_WordPress_mixed, context string, class string, mut var_args Class_VHttpd_WordPress_array, url string)  {
	mut var_queryParams := rt.new_null()
	mut var_response_mutated := var_response
	mut class_mutated := class
	if rt.is_true(rt.new_bool(!(rt.is_true(// unsupported expression: Expr_StaticPropertyFetch)))) {
		return rt.new_null()
	}
	mut var_key := rt.new_string(rt.new_string(md5.hexhash(url + (rt.call_function('serialize', [var_args])).str())))
	mut var_startTime := if !(// unsupported expression: Expr_StaticPropertyFetch.array_get(var_key)).is_null() { // unsupported expression: Expr_StaticPropertyFetch.array_get(var_key) } else { rt.new_null() }
	mut var_durationMs := rt.new_float(rt.new_float(0))
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		var_durationMs = rt.call_function('round', [rt.mul(rt.sub(rt.call_function('microtime', [rt.new_bool(true)]), var_startTime), rt.new_int(1000)), rt.new_int(2)])
		// unsupported expression: Expr_StaticPropertyFetch.array_unset(var_key)
	}
	mut var_parsedUrl := rt.call_function('parse_url', [rt.new_string(url)])
	mut var_cleanUrl := rt.new_string(rt.new_string(url))
	if var_parsedUrl.array_isset(rt.new_string('query')) {
		rt.call_function('parse_str', [var_parsedUrl.array_get('query'), var_queryParams.dup()])
		mut var_maskedQuery := Class_VHttpd_WordPress_Profiler.masksensitivedata(mut rt.cast_object_ptr[Class_VHttpd_WordPress_array](var_queryParams))
		var_parsedUrl.array_set('query', rt.call_function('http_build_query', [var_maskedQuery.dup()]))
		var_cleanUrl = rt.new_string(if var_parsedUrl.array_isset(rt.new_string('scheme')) { (var_parsedUrl.array_get('scheme')).str() + '://' } else { '' } + (if var_parsedUrl.array_isset(rt.new_string('host')) { var_parsedUrl.array_get('host') } else { rt.new_string('') }).str() + if var_parsedUrl.array_isset(rt.new_string('port')) { ':' + (var_parsedUrl.array_get('port')).str() } else { '' } + (if var_parsedUrl.array_isset(rt.new_string('path')) { var_parsedUrl.array_get('path') } else { rt.new_string('') }).str() + if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) { '?' + (var_parsedUrl.array_get('query')).str() } else { '' })
	}
	mut var_statusCode := rt.new_string(rt.new_string('unknown'))
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_response_mutated.dup().is_array())) && var_response_mutated.array_get('response').array_isset(rt.new_string('code')))) {
		var_statusCode = // unsupported expression: Expr_Cast_Int
	} else if rt.is_true(rt.new_bool(rt.instance_of(var_response_mutated, 'VHttpd_WordPress_WP_Error'))) {
		var_statusCode = rt.new_string('error: ' + (rt.call_method(var_response_mutated, 'get_error_message', []rt.PhpVal{})).str())
	}
	mut var_callStack := rt.new_array()
	mut var_stack := rt.call_function('debug_backtrace', [rt.get_constant('DEBUG_BACKTRACE_IGNORE_ARGS'), rt.new_int(12)])
	{
		mut iter_1 := var_stack.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_frame := item_1.val
			if var_frame.array_isset(rt.new_string('file')) {
				mut var_file := Class_VHttpd_WordPress_Profiler.cleanpath((var_frame.array_get('file')).str())
				if rt.is_true(rt.call_function('str_contains', [var_file.dup(), rt.new_string('Profiler.php')])) {
					continue
				}
				mut var_func := if !(var_frame.array_get('function')).is_null() { var_frame.array_get('function') } else { rt.new_string('') }
				class_mutated = (if !(var_frame.array_get('class')).is_null() { var_frame.array_get('class') } else { rt.new_string('') }).str()
				var_callStack.array_push(rt.create_array([rt.ArrayItem{ key: 'file', val: var_file }, rt.ArrayItem{ key: 'line', val: if !(var_frame.array_get('line')).is_null() { var_frame.array_get('line') } else { rt.new_int(0) } }, rt.ArrayItem{ key: 'caller', val: if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) { rt.new_string("${var_class.to_string()}::${var_func.to_string()}") } else { var_func } }]))
			}
		}
	}
	// unsupported expression: Expr_StaticPropertyFetch.array_push(rt.create_array([rt.ArrayItem{ key: 'url', val: var_cleanUrl }, rt.ArrayItem{ key: 'method', val: if !(var_args.array_get('method')).is_null() { var_args.array_get('method') } else { rt.new_string('GET') } }, rt.ArrayItem{ key: 'status', val: var_statusCode }, rt.ArrayItem{ key: 'duration_ms', val: var_durationMs }, rt.ArrayItem{ key: 'timestamp', val: rt.call_function('microtime', [rt.new_bool(true)]) }, rt.ArrayItem{ key: 'call_stack', val: var_callStack }]))
}

fn Class_VHttpd_WordPress_Profiler.handleerror(errno i64, errstr string, errfile string, errline i64) bool {
	mut errstr_mutated := errstr
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.bitwise_and(rt.call_function('error_reporting', []rt.PhpVal{}), rt.new_int(errno)))))) {
		if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
			return (// unsupported expression: Expr_Cast_Bool).to_bool()
		}
		return false
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(// unsupported expression: Expr_StaticPropertyFetch)))) {
		if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
			return (// unsupported expression: Expr_Cast_Bool).to_bool()
		}
		return false
	}
	mut match_val_1 := rt.new_int(errno)
	mut var_errorType := if rt.is_true(rt.equal(match_val_1, rt.get_constant('E_ERROR'))) || rt.is_true(rt.equal(match_val_1, rt.get_constant('E_CORE_ERROR'))) || rt.is_true(rt.equal(match_val_1, rt.get_constant('E_COMPILE_ERROR'))) || rt.is_true(rt.equal(match_val_1, rt.get_constant('E_USER_ERROR'))) { rt.new_string('Error') } else if rt.is_true(rt.equal(match_val_1, rt.get_constant('E_WARNING'))) || rt.is_true(rt.equal(match_val_1, rt.get_constant('E_CORE_WARNING'))) || rt.is_true(rt.equal(match_val_1, rt.get_constant('E_COMPILE_WARNING'))) || rt.is_true(rt.equal(match_val_1, rt.get_constant('E_USER_WARNING'))) { rt.new_string('Warning') } else if rt.is_true(rt.equal(match_val_1, rt.get_constant('E_PARSE'))) { rt.new_string('Parse Error') } else if rt.is_true(rt.equal(match_val_1, rt.get_constant('E_NOTICE'))) || rt.is_true(rt.equal(match_val_1, rt.get_constant('E_USER_NOTICE'))) { rt.new_string('Notice') } else if rt.is_true(rt.equal(match_val_1, rt.get_constant('E_DEPRECATED'))) || rt.is_true(rt.equal(match_val_1, rt.get_constant('E_USER_DEPRECATED'))) { rt.new_string('Deprecated') } else { rt.new_string('Unknown Error') }
	// unsupported expression: Expr_StaticPropertyFetch.array_push(rt.create_array([rt.ArrayItem{ key: 'level', val: var_errorType }, rt.ArrayItem{ key: 'message', val: errstr_mutated }, rt.ArrayItem{ key: 'file', val: Class_VHttpd_WordPress_Profiler.cleanpath(errfile) }, rt.ArrayItem{ key: 'line', val: errline }, rt.ArrayItem{ key: 'timestamp', val: rt.call_function('microtime', [rt.new_bool(true)]) }]))
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return (// unsupported expression: Expr_Cast_Bool).to_bool()
	}
	return false
}

fn Class_VHttpd_WordPress_Profiler.handleexception(mut var_exception Class_VHttpd_WordPress_Throwable)  {
	if rt.is_true(// unsupported expression: Expr_StaticPropertyFetch) {
		
	}
	if rt.is_true() {
	}
}

fn Class_VHttpd_WordPress_Profiler.injectwidget()  {
	if rt.is_true() {
	}
	
}

fn Class_VHttpd_WordPress_Profiler.handleshutdown()  {
}

fn Class_VHttpd_WordPress_Profiler.registerrestroute()  {
}

fn Class_VHttpd_WordPress_Profiler.getrestreport(mut var_request Class_VHttpd_WordPress_WP_REST_Request) rt.PhpVal {
}

fn Class_VHttpd_WordPress_Profiler.cleanpath(path string) string {
}

fn Class_VHttpd_WordPress_Profiler.cleantrace(trace string) string {
}

fn Class_VHttpd_WordPress_Profiler.getadminsocketpath() string {
}

fn Class_VHttpd_WordPress_Profiler.fetchdbpoolstats() rt.PhpVal {
	return rt.new_null()
}

fn Class_VHttpd_WordPress_Profiler.fetchvhttpdstats() rt.PhpVal {
	return rt.new_null()
}

fn Class_VHttpd_WordPress_Profiler.fetchexecutors() rt.PhpVal {
	return rt.new_null()
}

fn Class_VHttpd_WordPress_Profiler.masksensitivedata(mut var_data Class_VHttpd_WordPress_array) rt.PhpVal {
}

fn Class_VHttpd_WordPress_Profiler.getpluginslug(file string) string {
	mut file_mutated := file
}

fn Class_VHttpd_WordPress_Profiler.buildreport() rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_wp_object_cache := rt.new_null()
	mut var_wp_filter := rt.new_null()
	mut var_GLOBALS := rt.new_null()
}

fn Class_VHttpd_WordPress_Profiler.getcachebypassreasons() rt.PhpVal {
}

fn Class_VHttpd_WordPress_Profiler.getsecuritydiagnostics() rt.PhpVal {
}

fn Class_VHttpd_WordPress_Profiler.getwccartsummary() rt.PhpVal {
}

fn Class_VHttpd_WordPress_Profiler.getwcsessionsummary() rt.PhpVal {
}

fn Class_VHttpd_WordPress_Profiler.getwchposstatus() string {
}

fn Class_VHttpd_WordPress_Profiler.getwcsettingssummary() rt.PhpVal {
}

fn create_vhttpd_wordpress_profiler() &Class_VHttpd_WordPress_Profiler {
	mut obj := &Class_VHttpd_WordPress_Profiler{
		PhpObjectBase: rt.PhpObjectBase{}
		startTime: rt.new_float(0)
		logs: rt.new_array()
		errors: rt.new_array()
		timeline: rt.new_array()
		hookCounts: rt.new_array()
		started: rt.new_bool(false)
		active: rt.new_bool(false)
		footerInjected: rt.new_bool(false)
		currentRequestId: rt.new_string('')
		errorHandlersRegistered: rt.new_bool(false)
		startMemory: rt.new_int(0)
		externalRequests: rt.new_array()
		tempRequestTimes: rt.new_array()
		queryStacks: rt.new_array()
		prevErrorHandler: rt.new_null()
		prevExceptionHandler: rt.new_null()
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
	match prop_name {
		'startTime' { return this.startTime }
		'logs' { return this.logs }
		'errors' { return this.errors }
		'timeline' { return this.timeline }
		'hookCounts' { return this.hookCounts }
		'started' { return this.started }
		'active' { return this.active }
		'footerInjected' { return this.footerInjected }
		'currentRequestId' { return this.currentRequestId }
		'errorHandlersRegistered' { return this.errorHandlersRegistered }
		'startMemory' { return this.startMemory }
		'externalRequests' { return this.externalRequests }
		'tempRequestTimes' { return this.tempRequestTimes }
		'queryStacks' { return this.queryStacks }
		'prevErrorHandler' { return this.prevErrorHandler }
		'prevExceptionHandler' { return this.prevExceptionHandler }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_VHttpd_WordPress_Profiler) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'startTime' { this.startTime = val; return true }
		'logs' { this.logs = val; return true }
		'errors' { this.errors = val; return true }
		'timeline' { this.timeline = val; return true }
		'hookCounts' { this.hookCounts = val; return true }
		'started' { this.started = val; return true }
		'active' { this.active = val; return true }
		'footerInjected' { this.footerInjected = val; return true }
		'currentRequestId' { this.currentRequestId = val; return true }
		'errorHandlersRegistered' { this.errorHandlersRegistered = val; return true }
		'startMemory' { this.startMemory = val; return true }
		'externalRequests' { this.externalRequests = val; return true }
		'tempRequestTimes' { this.tempRequestTimes = val; return true }
		'queryStacks' { this.queryStacks = val; return true }
		'prevErrorHandler' { this.prevErrorHandler = val; return true }
		'prevExceptionHandler' { this.prevExceptionHandler = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}




pub fn init_wp_content_plugins_v_profiler_src_vhttpd_wordpress_profiler_php() {
	// unsupported statement: Stmt_Declare
}
