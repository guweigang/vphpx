import rt

struct Class_VHttpd_WordPress_Lifecycle {
	rt.PhpObjectBase
}

fn (mut this Class_VHttpd_WordPress_Lifecycle) rootfromenv(envName string) string {
	mut var_root := rt.call_function('getenv', [rt.new_string(envName)])
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_root.dup().is_string()))))) || rt.is_true(rt.identical(var_root, rt.new_string(''))))) {
		rt.throw_exception(rt.new_object('RuntimeException', []string{}, create_runtimeexception(rt.new_string("${var_envName} is required for wordpress runtime"))))
	}
	return var_root.dup().to_string().trim_right(' \t\n\r')
}

fn (mut this Class_VHttpd_WordPress_Lifecycle) wploadpath(root string) string {
	mut root_mutated := root
	mut var_wpLoad := rt.new_string(root_mutated.trim_right(' \t\n\r') + '/wp-load.php')
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_file', [var_wpLoad.dup()]))))) {
		rt.throw_exception(rt.new_object('RuntimeException', []string{}, create_runtimeexception('wp-load.php not found: ' + (var_wpLoad).str())))
	}
	return (var_wpLoad).str()
}

fn (mut this Class_VHttpd_WordPress_Lifecycle) isinstalled(root string) bool {
	mut root_mutated := root
	return (rt.call_function('is_file', [root_mutated.trim_right(' \t\n\r') + '/wp-config.php'])).to_bool()
}

fn (mut this Class_VHttpd_WordPress_Lifecycle) bootstrap(root string)  {
	mut root_mutated := root
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('WP_USE_THEMES')]))))) {
		rt.call_function('define', [rt.new_string('WP_USE_THEMES'), rt.new_bool(true)])
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
	if rt.is_true(rt.new_bool(rt.instance_of(rt.new_object('VHttpd_WordPress_mixed', []string{}, var_requestOrEnvelope), 'VHttpd_WordPress_Psr_Http_Message_ServerRequestInterface'))) {
		mut var_request := var_requestOrEnvelope
		mut var_headers := rt.new_array()
		{
			mut iter_1 := rt.call_method(var_request, 'getHeaders', []rt.PhpVal{}).iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_values := item_1.val
				mut var_name := item_1.key
				var_headers.array_set(var_name, rt.call_function('implode', [rt.new_string(', '), var_values.dup()]))
			}
		}
		mut var_serverParams := rt.call_method(var_request, 'getServerParams', []rt.PhpVal{})
		mut var_method := rt.new_string(rt.new_string(rt.call_method(var_request, 'getMethod', []rt.PhpVal{}).to_string().to_upper()))
		mut var_originalMethod := var_method.dup()
		if rt.is_true(rt.identical(var_method, rt.new_string('HEAD'))) {
			var_method = rt.new_string(rt.new_string('GET'))
		}
		return this.normalizecookiestate(mut rt.cast_object_ptr[Class_VHttpd_WordPress_array](rt.create_array([rt.ArrayItem{ key: 'path', val: rt.call_method(rt.call_method(var_request, 'getUri', []rt.PhpVal{}), 'getPath', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'query_string', val: rt.call_method(rt.call_method(var_request, 'getUri', []rt.PhpVal{}), 'getQuery', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'method', val: var_method }, rt.ArrayItem{ key: 'original_method', val: var_originalMethod }, rt.ArrayItem{ key: 'query', val: rt.call_method(var_request, 'getQueryParams', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'body', val: // unsupported expression: Expr_Cast_String }, rt.ArrayItem{ key: 'headers', val: var_headers }, rt.ArrayItem{ key: 'cookies', val: rt.call_method(var_request, 'getCookieParams', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'server', val: var_serverParams }, rt.ArrayItem{ key: 'host', val: rt.call_method(rt.call_method(var_request, 'getUri', []rt.PhpVal{}), 'getHost', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'port', val: // unsupported expression: Expr_Cast_String }, rt.ArrayItem{ key: 'scheme', val: rt.call_method(rt.call_method(var_request, 'getUri', []rt.PhpVal{}), 'getScheme', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'remote_addr', val: // unsupported expression: Expr_Cast_String }, rt.ArrayItem{ key: 'trace_id', val: if rt.is_true(this.headervalue(mut rt.cast_object_ptr[Class_VHttpd_WordPress_array](var_headers), mut rt.cast_object_ptr[Class_VHttpd_WordPress_array](rt.create_array([rt.ArrayItem{ key: none, val: 'x-vhttpd-trace-id' }, rt.ArrayItem{ key: none, val: 'X-Vhttpd-Trace-Id' }, rt.ArrayItem{ key: none, val: 'X-VHTTPD-TRACE-ID' }])))) { this.headervalue(mut rt.cast_object_ptr[Class_VHttpd_WordPress_array](var_headers), mut rt.cast_object_ptr[Class_VHttpd_WordPress_array](rt.create_array([rt.ArrayItem{ key: none, val: 'x-vhttpd-trace-id' }, rt.ArrayItem{ key: none, val: 'X-Vhttpd-Trace-Id' }, rt.ArrayItem{ key: none, val: 'X-VHTTPD-TRACE-ID' }]))) } else { // unsupported expression: Expr_Cast_String } }, rt.ArrayItem{ key: 'request_id', val: if rt.is_true(this.headervalue(mut rt.cast_object_ptr[Class_VHttpd_WordPress_array](var_headers), mut rt.cast_object_ptr[Class_VHttpd_WordPress_array](rt.create_array([rt.ArrayItem{ key: none, val: 'x-request-id' }, rt.ArrayItem{ key: none, val: 'X-Request-Id' }])))) { this.headervalue(mut rt.cast_object_ptr[Class_VHttpd_WordPress_array](var_headers), mut rt.cast_object_ptr[Class_VHttpd_WordPress_array](rt.create_array([rt.ArrayItem{ key: none, val: 'x-request-id' }, rt.ArrayItem{ key: none, val: 'X-Request-Id' }]))) } else { // unsupported expression: Expr_Cast_String } }])))
	}
	mut var_payload := if rt.is_true(rt.new_bool(var_requestOrEnvelope.is_array())) { var_requestOrEnvelope } else { var_envelope }
	mut var_path := // unsupported expression: Expr_Cast_String
	mut var_queryString := rt.new_string(rt.new_string(''))
	if rt.is_true(rt.call_function('str_contains', [var_path.dup(), rt.new_string('?')])) {
		// unsupported assign target: Expr_List
	}
	mut var_query := if !(var_payload.array_get('query')).is_null() { var_payload.array_get('query') } else { rt.new_array() }
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.identical(var_queryString, rt.new_string(''))) && rt.is_true(rt.new_bool(var_query.dup().is_array())))) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		var_queryString = rt.call_function('http_build_query', [var_query.dup()])
	}
	var_method = rt.new_string(rt.new_string(// unsupported expression: Expr_Cast_String.to_string().to_upper()))
	var_originalMethod = var_method.dup()
	if rt.is_true(rt.identical(var_method, rt.new_string('HEAD'))) {
		var_method = rt.new_string(rt.new_string('GET'))
	}
	return this.normalizecookiestate(mut rt.cast_object_ptr[Class_VHttpd_WordPress_array](rt.create_array([rt.ArrayItem{ key: 'path', val: var_path }, rt.ArrayItem{ key: 'query_string', val: var_queryString }, rt.ArrayItem{ key: 'method', val: var_method }, rt.ArrayItem{ key: 'original_method', val: var_originalMethod }, rt.ArrayItem{ key: 'query', val: if rt.is_true(rt.new_bool(var_query.dup().is_array())) { var_query } else { rt.new_array() } }, rt.ArrayItem{ key: 'body', val: // unsupported expression: Expr_Cast_String }, rt.ArrayItem{ key: 'headers', val: if rt.is_true(rt.new_bool(if !(var_payload.array_get('headers')).is_null() { var_payload.array_get('headers') } else { rt.new_null() }.is_array())) { var_payload.array_get('headers') } else { rt.new_array() } }, rt.ArrayItem{ key: 'cookies', val: if rt.is_true(rt.new_bool(if !(var_payload.array_get('cookies')).is_null() { var_payload.array_get('cookies') } else { rt.new_null() }.is_array())) { var_payload.array_get('cookies') } else { rt.new_array() } }, rt.ArrayItem{ key: 'server', val: if rt.is_true(rt.new_bool(if !(var_payload.array_get('server')).is_null() { var_payload.array_get('server') } else { rt.new_null() }.is_array())) { var_payload.array_get('server') } else { rt.new_array() } }, rt.ArrayItem{ key: 'host', val: // unsupported expression: Expr_Cast_String }, rt.ArrayItem{ key: 'port', val: // unsupported expression: Expr_Cast_String }, rt.ArrayItem{ key: 'scheme', val: this.requestscheme(mut rt.cast_object_ptr[Class_VHttpd_WordPress_array](if rt.is_true(rt.new_bool(if !(var_payload.array_get('headers')).is_null() { var_payload.array_get('headers') } else { rt.new_null() }.is_array())) { var_payload.array_get('headers') } else { rt.new_array() }), (// unsupported expression: Expr_Cast_String).str()) }, rt.ArrayItem{ key: 'remote_addr', val: // unsupported expression: Expr_Cast_String }, rt.ArrayItem{ key: 'trace_id', val: this.requesttraceid(mut rt.cast_object_ptr[Class_VHttpd_WordPress_array](var_payload)) }, rt.ArrayItem{ key: 'request_id', val: this.requestrequestid(mut rt.cast_object_ptr[Class_VHttpd_WordPress_array](var_payload)) }])))
}

fn (mut this Class_VHttpd_WordPress_Lifecycle) prepareenvironment(mut var_request Class_VHttpd_WordPress_array)  {
	mut var_request_mutated := var_request
	mut var_path := // unsupported expression: Expr_Cast_String
	mut var_queryString := // unsupported expression: Expr_Cast_String
	mut var_method := rt.new_string(rt.new_string(// unsupported expression: Expr_Cast_String.to_string().to_upper()))
	mut var_headers := if rt.is_true(rt.new_bool(if !(var_request_mutated.array_get('headers')).is_null() { var_request_mutated.array_get('headers') } else { rt.new_null() }.is_array())) { var_request_mutated.array_get('headers') } else { rt.new_array() }
	mut var_query := if rt.is_true(rt.new_bool(if !(var_request_mutated.array_get('query')).is_null() { var_request_mutated.array_get('query') } else { rt.new_null() }.is_array())) { var_request_mutated.array_get('query') } else { rt.new_array() }
	mut var_cookies := if rt.is_true(rt.new_bool(if !(var_request_mutated.array_get('cookies')).is_null() { var_request_mutated.array_get('cookies') } else { rt.new_null() }.is_array())) { var_request_mutated.array_get('cookies') } else { rt.new_array() }
	mut var_body := // unsupported expression: Expr_Cast_String
	mut var_host := // unsupported expression: Expr_Cast_String
	mut var_port := // unsupported expression: Expr_Cast_String
	mut var_scheme := // unsupported expression: Expr_Cast_String
	mut var_traceId := // unsupported expression: Expr_Cast_String
	mut var_requestId := // unsupported expression: Expr_Cast_String
	rt.get_superglobal('_SERVER').array_set('REQUEST_URI', (var_path).str() + if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) { '?' + (var_queryString).str() } else { '' })
	rt.get_superglobal('_SERVER').array_set('REQUEST_METHOD', var_method.dup())
	rt.get_superglobal('_SERVER').array_set('QUERY_STRING', var_queryString.dup())
	rt.get_superglobal('_SERVER').array_set('HTTP_HOST', this.hostheader((var_host).str(), (var_port).str()))
	rt.get_superglobal('_SERVER').array_set('SERVER_NAME', if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) { var_host } else { rt.new_string('localhost') })
	rt.get_superglobal('_SERVER').array_set('SERVER_PORT', if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) { var_port } else { if rt.is_true(rt.identical(var_scheme, rt.new_string('https'))) { rt.new_string('443') } else { rt.new_string('80') } })
	rt.get_superglobal('_SERVER').array_set('HTTPS', if rt.is_true(rt.identical(var_scheme, rt.new_string('https'))) { 'on' } else { 'off' })
	rt.get_superglobal('_SERVER').array_set('REQUEST_SCHEME', var_scheme.dup())
	rt.get_superglobal('_SERVER').array_set('HTTP_X_FORWARDED_PROTO', var_scheme.dup())
	rt.get_superglobal('_SERVER').array_set('REMOTE_ADDR', if rt.is_true(// unsupported expression: Expr_Cast_String) { // unsupported expression: Expr_Cast_String } else { rt.new_string('127.0.0.1') })
	rt.get_superglobal('_SERVER').array_set('HTTP_COOKIE', // unsupported expression: Expr_Cast_String)
	rt.get_superglobal('_SERVER').array_set('VHTTPD_TRACE_ID', var_traceId.dup())
	rt.get_superglobal('_SERVER').array_set('VHTTPD_REQUEST_ID', var_requestId.dup())
	rt.get_superglobal('_SERVER').array_set('HTTP_X_VHTTPD_TRACE_ID', var_traceId.dup())
	rt.get_superglobal('_SERVER').array_set('HTTP_X_REQUEST_ID', var_requestId.dup())
	rt.call_function('putenv', ['VHTTPD_TRACE_ID=' + (var_traceId).str()])
	rt.call_function('putenv', ['VHTTPD_REQUEST_ID=' + (var_requestId).str()])
	this.refreshdependencyurls((var_scheme).str())
	mut var__GET := var_query.dup()
	mut var__POST := rt.new_array()
	if rt.is_true(rt.identical(var_method, rt.new_string('POST'))) {
		mut var_contentType := if !(var_headers.array_get('content-type')).is_null() { var_headers.array_get('content-type') } else { if !(var_headers.array_get('Content-Type')).is_null() { var_headers.array_get('Content-Type') } else { rt.new_string('') } }
		if rt.is_true(rt.new_bool(var_contentType.dup().is_array())) {
			var_contentType = rt.call_function('implode', [rt.new_string(', '), var_contentType.dup()])
		}
		if rt.is_true(rt.call_function('str_contains', [rt.new_string(// unsupported expression: Expr_Cast_String.to_string().to_lower()), rt.new_string('application/x-www-form-urlencoded')])) {
			rt.call_function('parse_str', [var_body.dup(), rt.get_superglobal('_POST').dup()])
		}
	}
	mut var__COOKIE := var_cookies.dup()
	mut var__REQUEST := rt.call_function('array_merge', [rt.get_superglobal('_GET').dup(), rt.get_superglobal('_POST').dup(), rt.get_superglobal('_COOKIE').dup()])
}

fn (mut this Class_VHttpd_WordPress_Lifecycle) preparebootstrapdefaults()  {
	mut var_scheme := rt.new_string(this.bootstrapscheme())
	rt.get_superglobal('_SERVER').array_set('HTTP_HOST', if !(rt.get_superglobal('_SERVER').array_get('HTTP_HOST')).is_null() { rt.get_superglobal('_SERVER').array_get('HTTP_HOST') } else { rt.new_string('localhost') })
	rt.get_superglobal('_SERVER').array_set('REQUEST_URI', if !(rt.get_superglobal('_SERVER').array_get('REQUEST_URI')).is_null() { rt.get_superglobal('_SERVER').array_get('REQUEST_URI') } else { rt.new_string('/') })
	rt.get_superglobal('_SERVER').array_set('REQUEST_METHOD', if !(rt.get_superglobal('_SERVER').array_get('REQUEST_METHOD')).is_null() { rt.get_superglobal('_SERVER').array_get('REQUEST_METHOD') } else { rt.new_string('GET') })
	rt.get_superglobal('_SERVER').array_set('SERVER_NAME', if !(rt.get_superglobal('_SERVER').array_get('SERVER_NAME')).is_null() { rt.get_superglobal('_SERVER').array_get('SERVER_NAME') } else { rt.new_string('localhost') })
	rt.get_superglobal('_SERVER').array_set('SERVER_PORT', if !(rt.get_superglobal('_SERVER').array_get('SERVER_PORT')).is_null() { rt.get_superglobal('_SERVER').array_get('SERVER_PORT') } else { if rt.is_true(rt.identical(var_scheme, rt.new_string('https'))) { rt.new_string('443') } else { rt.new_string('80') } })
	rt.get_superglobal('_SERVER').array_set('HTTPS', if !(rt.get_superglobal('_SERVER').array_get('HTTPS')).is_null() { rt.get_superglobal('_SERVER').array_get('HTTPS') } else { if rt.is_true(rt.identical(var_scheme, rt.new_string('https'))) { rt.new_string('on') } else { rt.new_string('off') } })
	rt.get_superglobal('_SERVER').array_set('REQUEST_SCHEME', if !(rt.get_superglobal('_SERVER').array_get('REQUEST_SCHEME')).is_null() { rt.get_superglobal('_SERVER').array_get('REQUEST_SCHEME') } else { var_scheme })
	rt.get_superglobal('_SERVER').array_set('HTTP_X_FORWARDED_PROTO', if !(rt.get_superglobal('_SERVER').array_get('HTTP_X_FORWARDED_PROTO')).is_null() { rt.get_superglobal('_SERVER').array_get('HTTP_X_FORWARDED_PROTO') } else { var_scheme })
	rt.get_superglobal('_SERVER').array_set('REMOTE_ADDR', if !(rt.get_superglobal('_SERVER').array_get('REMOTE_ADDR')).is_null() { rt.get_superglobal('_SERVER').array_get('REMOTE_ADDR') } else { rt.new_string('127.0.0.1') })
}

fn (mut this Class_VHttpd_WordPress_Lifecycle) resetrequestruntime()  {
	mut var_wp_styles := rt.new_null()
	mut var_wp_scripts := rt.new_null()
	mut var_wp_script_modules := rt.new_null()
	mut var_GLOBALS := rt.new_null()
	// unsupported statement: Stmt_Global
	// unsupported statement: Stmt_Global
	this.resetwoocommerceruntime()
	if rt.is_true(rt.new_bool(rt.instance_of(var_wp_styles, 'VHttpd_WordPress_WP_Styles'))) {
		this.resetdependencyruntime(mut rt.cast_object_ptr[Class_VHttpd_WordPress_object](var_wp_styles))
		this.setprivateproperty(mut rt.cast_object_ptr[Class_VHttpd_WordPress_object](var_wp_styles), 'all_queued_deps', mut rt.cast_object_ptr[Class_VHttpd_WordPress_mixed](rt.new_null()))
	}
	if rt.is_true(rt.new_bool(rt.instance_of(var_wp_scripts, 'VHttpd_WordPress_WP_Scripts'))) {
		this.resetdependencyruntime(mut rt.cast_object_ptr[Class_VHttpd_WordPress_object](var_wp_scripts))
		this.setprivateproperty(mut rt.cast_object_ptr[Class_VHttpd_WordPress_object](var_wp_scripts), 'all_queued_deps', mut rt.cast_object_ptr[Class_VHttpd_WordPress_mixed](rt.new_null()))
		this.setprivateproperty(mut rt.cast_object_ptr[Class_VHttpd_WordPress_object](var_wp_scripts), 'dependents_map', mut rt.cast_object_ptr[Class_VHttpd_WordPress_mixed](rt.new_array()))
	}
	if rt.is_true(rt.new_bool(!(var_wp_script_modules).is_null() && rt.is_true(rt.new_bool(rt.instance_of(var_wp_script_modules, 'VHttpd_WordPress_WP_Script_Modules'))))) {
		this.setprivateproperty(mut rt.cast_object_ptr[Class_VHttpd_WordPress_object](var_wp_script_modules), 'queue', mut rt.cast_object_ptr[Class_VHttpd_WordPress_mixed](rt.new_array()))
		this.setprivateproperty(mut rt.cast_object_ptr[Class_VHttpd_WordPress_object](var_wp_script_modules), 'done', mut rt.cast_object_ptr[Class_VHttpd_WordPress_mixed](rt.new_array()))
		this.setprivateproperty(mut rt.cast_object_ptr[Class_VHttpd_WordPress_object](var_wp_script_modules), 'dependents_map', mut rt.cast_object_ptr[Class_VHttpd_WordPress_mixed](rt.new_array()))
	}
	mut var_current_user := rt.new_null()
	mut var_user_ID := rt.new_int(rt.new_int(0))
	mut var_user_level := rt.new_int(rt.new_int(0))
	mut var_userdata := 
	
}

fn (mut this Class_VHttpd_WordPress_Lifecycle) preparewoocommerceruntime()  {
}

fn Class_VHttpd_WordPress_Lifecycle.renderadminbar()  {
	mut var_wp_admin_bar := rt.new_null()
	mut var_GLOBALS := rt.new_null()
}

fn (mut this Class_VHttpd_WordPress_Lifecycle) normalizecookiestate(mut var_request Class_VHttpd_WordPress_array) rt.PhpVal {
	mut var_request_mutated := var_request
}

fn (mut this Class_VHttpd_WordPress_Lifecycle) cookieheader(mut var_headers Class_VHttpd_WordPress_array) string {
	mut var_headers_mutated := var_headers
}

fn (mut this Class_VHttpd_WordPress_Lifecycle) requestscheme(mut var_headers Class_VHttpd_WordPress_array, fallback string) string {
	mut var_headers_mutated := var_headers
}

fn (mut this Class_VHttpd_WordPress_Lifecycle) bootstrapscheme() string {
}

fn (mut this Class_VHttpd_WordPress_Lifecycle) requesttraceid(mut var_payload Class_VHttpd_WordPress_array) string {
	mut var_payload_mutated := var_payload
}

fn (mut this Class_VHttpd_WordPress_Lifecycle) requestrequestid(mut var_payload Class_VHttpd_WordPress_array) string {
	mut var_payload_mutated := var_payload
}

fn (mut this Class_VHttpd_WordPress_Lifecycle) headervalue(mut var_headers Class_VHttpd_WordPress_array, mut var_names Class_VHttpd_WordPress_array) string {
	mut var_headers_mutated := var_headers
}

fn (mut this Class_VHttpd_WordPress_Lifecycle) parsecookieheader(header string) rt.PhpVal {
	mut var_value := rt.new_null()
}

fn (mut this Class_VHttpd_WordPress_Lifecycle) hostheader(host string, port string) string {
	mut host_mutated := host
	mut port_mutated := port
}

fn (mut this Class_VHttpd_WordPress_Lifecycle) resetdependencyruntime(mut var_deps Class_VHttpd_WordPress_object)  {
	mut var_deps_mutated := var_deps
}

fn (mut this Class_VHttpd_WordPress_Lifecycle) refreshdependencyurls(scheme string)  {
	mut var_wp_styles := rt.new_null()
	mut var_wp_scripts := rt.new_null()
	mut scheme_mutated := scheme
}

fn (mut this Class_VHttpd_WordPress_Lifecycle) resetwoocommerceruntime()  {
}

fn (mut this Class_VHttpd_WordPress_Lifecycle) setprivateproperty(mut var_object Class_VHttpd_WordPress_object, property string, mut var_value Class_VHttpd_WordPress_mixed)  {
	mut var_value_mutated := var_value
}

fn (mut this Class_VHttpd_WordPress_Lifecycle) finalizeresponse(mut var_request Class_VHttpd_WordPress_array, mut var_response Class_VHttpd_WordPress_array) rt.PhpVal {
	mut var_request_mutated := var_request
	mut var_response_mutated := var_response
}

fn (mut this Class_VHttpd_WordPress_Lifecycle) attachwoocommercecookies(mut var_response Class_VHttpd_WordPress_array) rt.PhpVal {
	mut var_response_mutated := var_response
}

fn (mut this Class_VHttpd_WordPress_Lifecycle) woocommercesessioncookieheader() string {
}

fn (mut this Class_VHttpd_WordPress_Lifecycle) woocommercecartcookieheaders() rt.PhpVal {
}

fn (mut this Class_VHttpd_WordPress_Lifecycle) buildcookieheader(name string, value string, expires i64, secure bool, httpOnly bool) string {
	mut name_mutated := name
	mut value_mutated := value
	mut secure_mutated := secure
	mut httpOnly_mutated := httpOnly
}

fn (mut this Class_VHttpd_WordPress_Lifecycle) appendheader(mut var_headers Class_VHttpd_WordPress_array, name string, value string)  {
	mut var_headers_mutated := var_headers
	mut name_mutated := name
	mut value_mutated := value
}

fn (mut this Class_VHttpd_WordPress_Lifecycle) objectproperty(mut var_object Class_VHttpd_WordPress_object, property string, mut var_default Class_VHttpd_WordPress_mixed) rt.PhpVal {
	return rt.new_null()
}

struct Class_RuntimeException {
	rt.PhpObjectBase
}

fn create_vhttpd_wordpress_lifecycle() &Class_VHttpd_WordPress_Lifecycle {
	mut obj := &Class_VHttpd_WordPress_Lifecycle{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_runtimeexception() &Class_RuntimeException {
	mut obj := &Class_RuntimeException{
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
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_VHttpd_WordPress_mixed](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_VHttpd_WordPress_array](if args.len > 1 { args[1] } else { rt.new_null() })
			return this.normalizerequest(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		'prepareEnvironment' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_VHttpd_WordPress_array](if args.len > 0 { args[0] } else { rt.new_null() })
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
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_VHttpd_WordPress_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.normalizecookiestate(mut dispatch_arg_0)
		}
		'cookieHeader' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_VHttpd_WordPress_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_string(this.cookieheader(mut dispatch_arg_0))
		}
		'requestScheme' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_VHttpd_WordPress_array](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return rt.new_string(this.requestscheme(mut dispatch_arg_0, dispatch_arg_1))
		}
		'bootstrapScheme' {
			return rt.new_string(this.bootstrapscheme())
		}
		'requestTraceId' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_VHttpd_WordPress_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_string(this.requesttraceid(mut dispatch_arg_0))
		}
		'requestRequestId' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_VHttpd_WordPress_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_string(this.requestrequestid(mut dispatch_arg_0))
		}
		'headerValue' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_VHttpd_WordPress_array](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_VHttpd_WordPress_array](if args.len > 1 { args[1] } else { rt.new_null() })
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
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_VHttpd_WordPress_object](if args.len > 0 { args[0] } else { rt.new_null() })
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
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_VHttpd_WordPress_object](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_VHttpd_WordPress_mixed](if args.len > 2 { args[2] } else { rt.new_null() })
			this.setprivateproperty(mut dispatch_arg_0, dispatch_arg_1, mut dispatch_arg_2)
			return rt.new_null()
		}
		'finalizeResponse' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_VHttpd_WordPress_array](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_VHttpd_WordPress_array](if args.len > 1 { args[1] } else { rt.new_null() })
			return this.finalizeresponse(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		'attachWooCommerceCookies' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_VHttpd_WordPress_array](if args.len > 0 { args[0] } else { rt.new_null() })
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
			return rt.new_string(this.buildcookieheader(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3, dispatch_arg_4))
		}
		'appendHeader' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_VHttpd_WordPress_array](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			this.appendheader(mut dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'objectProperty' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_VHttpd_WordPress_object](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_VHttpd_WordPress_mixed](if args.len > 2 { args[2] } else { rt.new_null() })
			return this.objectproperty(mut dispatch_arg_0, dispatch_arg_1, mut dispatch_arg_2)
		}
		else { return none }
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




pub fn init_wp_content_plugins_v_profiler_src_vhttpd_wordpress_lifecycle_php() {
	// unsupported statement: Stmt_Declare
}
