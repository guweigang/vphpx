import rt

struct Class_WordPress_AiClient_Providers_Http_HttpTransporter {
	rt.PhpObjectBase
pub mut:
		requestFactory rt.PhpVal = rt.new_null()
		streamFactory rt.PhpVal = rt.new_null()
		client rt.PhpVal = rt.new_null()
}

fn (mut this Class_WordPress_AiClient_Providers_Http_HttpTransporter) construct(mut var_client Class_WordPress_AiClient_Providers_Http_?ClientInterface, mut var_requestFactory Class_WordPress_AiClient_Providers_Http_?RequestFactoryInterface, mut var_streamFactory Class_WordPress_AiClient_Providers_Http_?StreamFactoryInterface)  {
	this.client = if rt.is_true(var_client) { var_client } else { fn () rt.PhpVal { mut temp := Class_WordPress_AiClientDependencies_Http_Discovery_Psr18ClientDiscovery{}; return temp.find() }() }
	this.requestFactory = if rt.is_true(var_requestFactory) { var_requestFactory } else { fn () rt.PhpVal { mut temp := Class_WordPress_AiClientDependencies_Http_Discovery_Psr17FactoryDiscovery{}; return temp.findrequestfactory() }() }
	this.streamFactory = if rt.is_true(var_streamFactory) { var_streamFactory } else { fn () rt.PhpVal { mut temp := Class_WordPress_AiClientDependencies_Http_Discovery_Psr17FactoryDiscovery{}; return temp.findstreamfactory() }() }
}

fn (mut this Class_WordPress_AiClient_Providers_Http_HttpTransporter) send(mut var_request Class_WordPress_AiClient_Providers_Http_DTO_Request, mut var_options Class_WordPress_AiClient_Providers_Http_?RequestOptions) rt.PhpVal {
	mut var_psr7Request := this.converttopsr7request(mut var_request)
	mut var_mergedOptions := this.mergeoptions(mut rt.cast_object_ptr[Class_WordPress_AiClient_Providers_Http_?RequestOptions](var_request.getoptions()), mut var_options)
	mut var_hasOptions := // unsupported expression: Expr_BinaryOp_NotIdentical
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	if rt.is_true(rt.new_bool(rt.is_true(var_hasOptions) && rt.is_true(rt.new_bool(rt.instance_of(this.client, 'WordPress_AiClient_Providers_Http_Contracts_ClientWithOptionsInterface'))))) {
		mut var_psr7Response := rt.call_method(this.client, 'sendRequestWithOptions', [var_psr7Request.dup(), var_mergedOptions.dup()])
		if rt.has_exception() { unsafe { goto catch_label_1 } }
	} else if rt.is_true(rt.new_bool(rt.is_true(var_hasOptions) && this.isguzzleclient(mut rt.cast_object_ptr[Class_WordPress_AiClientDependencies_Psr_Http_Client_ClientInterface](this.client)))) {
		var_psr7Response = this.sendwithguzzle(mut rt.cast_object_ptr[Class_WordPress_AiClientDependencies_Psr_Http_Message_RequestInterface](var_psr7Request), mut rt.cast_object_ptr[Class_WordPress_AiClient_Providers_Http_DTO_RequestOptions](var_mergedOptions))
		if rt.has_exception() { unsafe { goto catch_label_1 } }
	} else {
		var_psr7Response = rt.call_method(this.client, 'sendRequest', [var_psr7Request.dup()])
		if rt.has_exception() { unsafe { goto catch_label_1 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	unsafe { goto end_label_1 }

catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'WordPress_AiClient_Providers_Http_WordPress_AiClientDependencies_Psr_Http_Client_NetworkExceptionInterface') {
		mut var_e := var_e_1.dup()
		rt.throw_exception(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_WordPress_AiClient_Providers_Http_Exception_NetworkException{}; return temp.frompsr18networkexception(arg_0, arg_1) }(var_psr7Request.dup(), var_e.dup()))
		unsafe { goto end_label_1 }
	}
	else if rt.instance_of(var_e_1, 'WordPress_AiClient_Providers_Http_WordPress_AiClientDependencies_Psr_Http_Client_ClientExceptionInterface') {
		mut var_e := var_e_1.dup()
		rt.throw_exception(rt.new_object('WordPress_AiClient_Common_Exception_RuntimeException', []string{}, create_wordpress_aiclient_common_exception_runtimeexception(rt.call_function('sprintf', [rt.new_string('HTTP client error occurred while sending request to %s: %s'), var_request.geturi(), rt.call_method(var_e, 'getMessage', []rt.PhpVal{})]), rt.new_int(0), var_e.dup())))
		unsafe { goto end_label_1 }
	}
	else {
		rt.throw_exception(var_e_1)
		unsafe { goto end_label_1 }
	}

end_label_1:
	return this.convertfrompsr7response(mut rt.cast_object_ptr[Class_WordPress_AiClientDependencies_Psr_Http_Message_ResponseInterface](var_psr7Response))
}

fn (mut this Class_WordPress_AiClient_Providers_Http_HttpTransporter) mergeoptions(mut var_requestOptions Class_WordPress_AiClient_Providers_Http_?RequestOptions, mut var_parameterOptions Class_WordPress_AiClient_Providers_Http_?RequestOptions) rt.PhpVal {
	if rt.is_true(rt.new_bool(rt.is_true(rt.identical(var_requestOptions, rt.new_null())) && rt.is_true(rt.identical(var_parameterOptions, rt.new_null())))) {
		return rt.new_null()
	}
	if rt.is_true(rt.identical(var_requestOptions, rt.new_null())) {
		return rt.new_object('WordPress_AiClient_Providers_Http_?RequestOptions', []string{}, var_parameterOptions)
	}
	if rt.is_true(rt.identical(var_parameterOptions, rt.new_null())) {
		return rt.new_object('WordPress_AiClient_Providers_Http_?RequestOptions', []string{}, var_requestOptions)
	}
	mut var_merged := create_wordpress_aiclient_providers_http_dto_requestoptions()
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		var_merged.settimeout(var_requestOptions.gettimeout())
	}
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		var_merged.setconnecttimeout(var_requestOptions.getconnecttimeout())
	}
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		var_merged.setmaxredirects(var_requestOptions.getmaxredirects())
	}
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		var_merged.settimeout(var_parameterOptions.gettimeout())
	}
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		var_merged.setconnecttimeout(var_parameterOptions.getconnecttimeout())
	}
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		var_merged.setmaxredirects(var_parameterOptions.getmaxredirects())
	}
	return rt.new_object('WordPress_AiClient_Providers_Http_DTO_RequestOptions', []string{}, var_merged)
}

fn (mut this Class_WordPress_AiClient_Providers_Http_HttpTransporter) isguzzleclient(mut var_client Class_WordPress_AiClientDependencies_Psr_Http_Client_ClientInterface) bool {
	mut var_reflection := create_wordpress_aiclient_providers_http_reflectionobject(var_client.dup())
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_callable', [rt.create_array([rt.ArrayItem{ key: none, val: var_client }, rt.ArrayItem{ key: none, val: 'send' }])]))))) {
		return false
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_reflection.hasmethod(rt.new_string('send')))))) {
		return false
	}
	mut var_method := var_reflection.getmethod(rt.new_string('send'))
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_method, 'isPublic', []rt.PhpVal{}))))) || rt.is_true(rt.call_method(var_method, 'isStatic', []rt.PhpVal{})))) {
		return false
	}
	mut var_parameters := rt.call_method(var_method, 'getParameters', []rt.PhpVal{})
	if var_parameters.dup().array_count() < 2 {
		return false
	}
	mut var_firstParameter := rt.call_method(var_parameters.array_get(0), 'getType', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_firstParameter, 'WordPress_AiClient_Providers_Http_ReflectionNamedType')))))) || rt.is_true(rt.call_method(var_firstParameter, 'isBuiltin', []rt.PhpVal{})))) {
		return false
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_a', [rt.call_method(var_firstParameter, 'getName', []rt.PhpVal{}), Class_WordPress_AiClientDependencies_Psr_Http_Message_RequestInterface.class(), rt.new_bool(true)]))))) {
		return false
	}
	mut var_secondParameter := var_parameters.array_get(1)
	mut var_secondType := rt.call_method(var_secondParameter, 'getType', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_secondType, 'WordPress_AiClient_Providers_Http_ReflectionNamedType')))))) || rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		return false
	}
	return true
}

fn (mut this Class_WordPress_AiClient_Providers_Http_HttpTransporter) sendwithguzzle(mut var_request Class_WordPress_AiClientDependencies_Psr_Http_Message_RequestInterface, mut var_options Class_WordPress_AiClient_Providers_Http_DTO_RequestOptions) rt.PhpVal {
	mut var_guzzleOptions := this.buildguzzleoptions(mut var_options)
	mut var_callable := rt.create_array([rt.ArrayItem{ key: none, val: this.client }, rt.ArrayItem{ key: none, val: 'send' }])
	mut var_response := rt.call_callable(var_callable, [var_request, var_guzzleOptions.dup()])
	return var_response.dup()
}

fn (mut this Class_WordPress_AiClient_Providers_Http_HttpTransporter) buildguzzleoptions(mut var_options Class_WordPress_AiClient_Providers_Http_DTO_RequestOptions) rt.PhpVal {
	mut var_guzzleOptions := rt.new_array()
	mut var_timeout := var_options.gettimeout()
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		var_guzzleOptions.array_set('timeout', var_timeout.dup())
	}
	mut var_connectTimeout := var_options.getconnecttimeout()
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		var_guzzleOptions.array_set('connect_timeout', var_connectTimeout.dup())
	}
	mut var_allowRedirects := var_options.allowsredirects()
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		if rt.is_true(var_allowRedirects) {
			mut var_redirectOptions := rt.new_array()
			mut var_maxRedirects := var_options.getmaxredirects()
			if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
				var_redirectOptions.array_set('max', var_maxRedirects.dup())
			}
			var_guzzleOptions.array_set('allow_redirects', if !(!rt.is_true(var_redirectOptions)) { var_redirectOptions } else { rt.new_bool(true) })
		} else {
			var_guzzleOptions.array_set('allow_redirects', false)
		}
	}
	return var_guzzleOptions.dup()
}

fn (mut this Class_WordPress_AiClient_Providers_Http_HttpTransporter) converttopsr7request(mut var_request Class_WordPress_AiClient_Providers_Http_DTO_Request) rt.PhpVal {
	mut var_psr7Request := rt.call_method(this.requestFactory, 'createRequest', [rt.get_property(var_request.getmethod(), 'value'), var_request.geturi()])
	{
		mut iter_1 := var_request.getheaders().iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_values := item_1.val
			mut var_name := item_1.key
			{
				mut iter_2 := var_values.iterator()
				for {
					item_2 := iter_2.next() or { break }
					mut var_value := item_2.val
					var_psr7Request = rt.call_method(var_psr7Request, 'withAddedHeader', [var_name.dup(), var_value.dup()])
				}
			}
		}
	}
	mut var_body := var_request.getbody()
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		mut var_stream := rt.call_method(this.streamFactory, 'createStream', [var_body.dup()])
		var_psr7Request = rt.call_method(var_psr7Request, 'withBody', [var_stream.dup()])
	}
	return var_psr7Request.dup()
}

fn (mut this Class_WordPress_AiClient_Providers_Http_HttpTransporter) convertfrompsr7response(mut var_psr7Response Class_WordPress_AiClientDependencies_Psr_Http_Message_ResponseInterface) rt.PhpVal {
	mut var_psr7Response_mutated := var_psr7Response
	mut var_body := // unsupported expression: Expr_Cast_String
	return create_wordpress_aiclient_providers_http_dto_response(rt.call_method(var_psr7Response_mutated, 'getStatusCode', []rt.PhpVal{}), rt.call_method(var_psr7Response_mutated, 'getHeaders', []rt.PhpVal{}), if rt.is_true(rt.identical(var_body, rt.new_string(''))) { rt.new_null() } else { var_body })
}

struct Class_WordPress_AiClientDependencies_Http_Discovery_Psr18ClientDiscovery {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClientDependencies_Http_Discovery_Psr17FactoryDiscovery {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClient_Providers_Http_Exception_NetworkException {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClient_Common_Exception_RuntimeException {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClient_Providers_Http_DTO_RequestOptions {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClient_Providers_Http_ReflectionObject {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClient_Providers_Http_DTO_Response {
	rt.PhpObjectBase
}

fn create_wordpress_aiclient_providers_http_httptransporter(arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) &Class_WordPress_AiClient_Providers_Http_HttpTransporter {
	mut obj := &Class_WordPress_AiClient_Providers_Http_HttpTransporter{
		PhpObjectBase: rt.PhpObjectBase{}
		requestFactory: rt.new_null()
		streamFactory: rt.new_null()
		client: rt.new_null()
	}
	obj.construct(arg_0, arg_1, arg_2)
	return obj
}

fn create_wordpress_aiclientdependencies_http_discovery_psr18clientdiscovery() &Class_WordPress_AiClientDependencies_Http_Discovery_Psr18ClientDiscovery {
	mut obj := &Class_WordPress_AiClientDependencies_Http_Discovery_Psr18ClientDiscovery{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wordpress_aiclientdependencies_http_discovery_psr17factorydiscovery() &Class_WordPress_AiClientDependencies_Http_Discovery_Psr17FactoryDiscovery {
	mut obj := &Class_WordPress_AiClientDependencies_Http_Discovery_Psr17FactoryDiscovery{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wordpress_aiclient_providers_http_exception_networkexception() &Class_WordPress_AiClient_Providers_Http_Exception_NetworkException {
	mut obj := &Class_WordPress_AiClient_Providers_Http_Exception_NetworkException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wordpress_aiclient_common_exception_runtimeexception() &Class_WordPress_AiClient_Common_Exception_RuntimeException {
	mut obj := &Class_WordPress_AiClient_Common_Exception_RuntimeException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wordpress_aiclient_providers_http_dto_requestoptions() &Class_WordPress_AiClient_Providers_Http_DTO_RequestOptions {
	mut obj := &Class_WordPress_AiClient_Providers_Http_DTO_RequestOptions{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wordpress_aiclient_providers_http_reflectionobject() &Class_WordPress_AiClient_Providers_Http_ReflectionObject {
	mut obj := &Class_WordPress_AiClient_Providers_Http_ReflectionObject{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wordpress_aiclient_providers_http_dto_response() &Class_WordPress_AiClient_Providers_Http_DTO_Response {
	mut obj := &Class_WordPress_AiClient_Providers_Http_DTO_Response{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WordPress_AiClient_Providers_Http_HttpTransporter) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WordPress_AiClient_Providers_Http_?ClientInterface](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_WordPress_AiClient_Providers_Http_?RequestFactoryInterface](if args.len > 1 { args[1] } else { rt.new_null() })
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_WordPress_AiClient_Providers_Http_?StreamFactoryInterface](if args.len > 2 { args[2] } else { rt.new_null() })
			this.construct(mut dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2)
			return rt.new_null()
		}
		'send' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WordPress_AiClient_Providers_Http_DTO_Request](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_WordPress_AiClient_Providers_Http_?RequestOptions](if args.len > 1 { args[1] } else { rt.new_null() })
			return this.send(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		'mergeOptions' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WordPress_AiClient_Providers_Http_?RequestOptions](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_WordPress_AiClient_Providers_Http_?RequestOptions](if args.len > 1 { args[1] } else { rt.new_null() })
			return this.mergeoptions(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		'isGuzzleClient' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WordPress_AiClientDependencies_Psr_Http_Client_ClientInterface](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_bool(this.isguzzleclient(mut dispatch_arg_0))
		}
		'sendWithGuzzle' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WordPress_AiClientDependencies_Psr_Http_Message_RequestInterface](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_WordPress_AiClient_Providers_Http_DTO_RequestOptions](if args.len > 1 { args[1] } else { rt.new_null() })
			return this.sendwithguzzle(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		'buildGuzzleOptions' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WordPress_AiClient_Providers_Http_DTO_RequestOptions](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.buildguzzleoptions(mut dispatch_arg_0)
		}
		'convertToPsr7Request' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WordPress_AiClient_Providers_Http_DTO_Request](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.converttopsr7request(mut dispatch_arg_0)
		}
		'convertFromPsr7Response' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WordPress_AiClientDependencies_Psr_Http_Message_ResponseInterface](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.convertfrompsr7response(mut dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_WordPress_AiClient_Providers_Http_HttpTransporter) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'requestFactory' { return this.requestFactory }
		'streamFactory' { return this.streamFactory }
		'client' { return this.client }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WordPress_AiClient_Providers_Http_HttpTransporter) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'requestFactory' { this.requestFactory = val; return true }
		'streamFactory' { this.streamFactory = val; return true }
		'client' { this.client = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_WordPress_AiClientDependencies_Http_Discovery_Psr18ClientDiscovery) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WordPress_AiClientDependencies_Http_Discovery_Psr18ClientDiscovery) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClientDependencies_Http_Discovery_Psr18ClientDiscovery) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WordPress_AiClientDependencies_Http_Discovery_Psr17FactoryDiscovery) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WordPress_AiClientDependencies_Http_Discovery_Psr17FactoryDiscovery) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClientDependencies_Http_Discovery_Psr17FactoryDiscovery) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WordPress_AiClient_Providers_Http_Exception_NetworkException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WordPress_AiClient_Providers_Http_Exception_NetworkException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClient_Providers_Http_Exception_NetworkException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WordPress_AiClient_Common_Exception_RuntimeException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WordPress_AiClient_Common_Exception_RuntimeException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClient_Common_Exception_RuntimeException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WordPress_AiClient_Providers_Http_DTO_RequestOptions) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WordPress_AiClient_Providers_Http_DTO_RequestOptions) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClient_Providers_Http_DTO_RequestOptions) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WordPress_AiClient_Providers_Http_ReflectionObject) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WordPress_AiClient_Providers_Http_ReflectionObject) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClient_Providers_Http_ReflectionObject) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WordPress_AiClient_Providers_Http_DTO_Response) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WordPress_AiClient_Providers_Http_DTO_Response) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClient_Providers_Http_DTO_Response) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn init_registry() {
}

fn init() {
	init_registry()
}



pub fn init_wp_includes_php_ai_client_src_providers_http_httptransporter_php() {
	// unsupported statement: Stmt_Declare
}
