import rt

struct Class_WP_AI_Client_HTTP_Client {
	rt.PhpObjectBase
pub mut:
		response_factory rt.PhpVal = rt.new_null()
		stream_factory rt.PhpVal = rt.new_null()
}

fn (mut this Class_WP_AI_Client_HTTP_Client) construct(mut var_response_factory Class_WordPress_AiClientDependencies_Psr_Http_Message_ResponseFactoryInterface, mut var_stream_factory Class_WordPress_AiClientDependencies_Psr_Http_Message_StreamFactoryInterface)  {
	this.response_factory = var_response_factory.dup()
	this.stream_factory = var_stream_factory.dup()
}

fn (mut this Class_WP_AI_Client_HTTP_Client) sendrequest(mut var_request Class_WordPress_AiClientDependencies_Psr_Http_Message_RequestInterface) rt.PhpVal {
	mut var_args := this.prepare_wp_args(mut var_request, rt.new_null())
	mut var_url := // unsupported expression: Expr_Cast_String
	mut var_response := rt.call_function('wp_safe_remote_request', [var_url.dup(), var_args.dup()])
	if rt.is_true(rt.call_function('is_wp_error', [var_response.dup()])) {
		mut var_message := rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Network error occurred while sending %1$s request to %2$s: %3$s')]), var_request.getmethod(), var_url.dup(), rt.call_method(var_response, 'get_error_message', []rt.PhpVal{})])
		rt.throw_exception(rt.new_object('WordPress_AiClient_Providers_Http_Exception_NetworkException', []string{}, create_wordpress_aiclient_providers_http_exception_networkexception(var_message.dup())))
		// unsupported statement: Stmt_Nop
	}
	return this.create_psr_response(mut rt.cast_object_ptr[Class_array](var_response))
}

fn (mut this Class_WP_AI_Client_HTTP_Client) sendrequestwithoptions(mut var_request Class_WordPress_AiClientDependencies_Psr_Http_Message_RequestInterface, mut var_options Class_WordPress_AiClient_Providers_Http_DTO_RequestOptions) rt.PhpVal {
	mut var_args := this.prepare_wp_args(mut var_request, mut var_options)
	mut var_url := // unsupported expression: Expr_Cast_String
	mut var_response := rt.call_function('wp_safe_remote_request', [var_url.dup(), var_args.dup()])
	if rt.is_true(rt.call_function('is_wp_error', [var_response.dup()])) {
		mut var_message := rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Network error occurred while sending request to %1$s: %2$s')]), var_url.dup(), rt.call_method(var_response, 'get_error_message', []rt.PhpVal{})])
		rt.throw_exception(rt.new_object('WordPress_AiClient_Providers_Http_Exception_NetworkException', []string{}, create_wordpress_aiclient_providers_http_exception_networkexception(var_message.dup(), if rt.is_true(rt.call_method(var_response, 'get_error_code', []rt.PhpVal{})) { // unsupported expression: Expr_Cast_Int } else { rt.new_int(0) })))
	}
	return this.create_psr_response(mut rt.cast_object_ptr[Class_array](var_response))
}

fn (mut this Class_WP_AI_Client_HTTP_Client) prepare_wp_args(mut var_request Class_WordPress_AiClientDependencies_Psr_Http_Message_RequestInterface, mut var_options Class_?RequestOptions) rt.PhpVal {
	mut var_args := rt.create_array([rt.ArrayItem{ key: 'method', val: var_request.getmethod() }, rt.ArrayItem{ key: 'headers', val: this.prepare_headers(mut var_request) }, rt.ArrayItem{ key: 'body', val: this.prepare_body(mut var_request) }, rt.ArrayItem{ key: 'httpversion', val: var_request.getprotocolversion() }, rt.ArrayItem{ key: 'blocking', val: true }])
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
			var_args.array_set('timeout', var_options.gettimeout())
		}
		if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
			var_args.array_set('redirection', var_options.getmaxredirects())
		}
	}
	return var_args.dup()
}

fn (mut this Class_WP_AI_Client_HTTP_Client) prepare_headers(mut var_request Class_WordPress_AiClientDependencies_Psr_Http_Message_RequestInterface) rt.PhpVal {
	mut var_headers := rt.new_array()
	{
		mut iter_1 := var_request.getheaders().iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_values := item_1.val
			mut var_name := item_1.key
			var_headers.array_set(// unsupported expression: Expr_Cast_String, rt.call_function('implode', [rt.new_string(', '), var_values.dup()]))
		}
	}
	return var_headers.dup()
}

fn (mut this Class_WP_AI_Client_HTTP_Client) prepare_body(mut var_request Class_WordPress_AiClientDependencies_Psr_Http_Message_RequestInterface) string {
	mut var_body := var_request.getbody()
	if rt.is_true(rt.identical(rt.call_method(var_body, 'getSize', []rt.PhpVal{}), rt.new_int(0))) {
		return (rt.new_null()).str()
	}
	if rt.is_true(rt.call_method(var_body, 'isSeekable', []rt.PhpVal{})) {
		rt.call_method(var_body, 'rewind', []rt.PhpVal{})
	}
	return (// unsupported expression: Expr_Cast_String).str()
}

fn (mut this Class_WP_AI_Client_HTTP_Client) create_psr_response(mut var_wp_response Class_array) rt.PhpVal {
	mut var_status_code := rt.call_function('wp_remote_retrieve_response_code', [var_wp_response])
	mut var_reason_phrase := rt.call_function('wp_remote_retrieve_response_message', [var_wp_response])
	mut var_headers := rt.call_function('wp_remote_retrieve_headers', [var_wp_response])
	mut var_body := rt.call_function('wp_remote_retrieve_body', [var_wp_response])
	mut var_response := rt.call_method(this.response_factory, 'createResponse', [// unsupported expression: Expr_Cast_Int, var_reason_phrase.dup()])
	if rt.is_true(rt.new_bool(rt.instance_of(var_headers, 'WP_HTTP_Requests_Response'))) {
		var_headers = rt.call_method(var_headers, 'get_headers', []rt.PhpVal{})
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_headers.dup().is_array())) || rt.is_true(rt.new_bool(rt.instance_of(var_headers, 'Traversable'))))) {
		{
			mut iter_1 := var_headers.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_value := item_1.val
				mut var_name := item_1.key
				var_response = rt.call_method(var_response, 'withHeader', [var_name.dup(), var_value.dup()])
			}
		}
	}
	if !(!rt.is_true(var_body)) {
		mut var_stream := rt.call_method(this.stream_factory, 'createStream', [var_body.dup()])
		var_response = rt.call_method(var_response, 'withBody', [var_stream.dup()])
	}
	return var_response.dup()
}

struct Class_WordPress_AiClient_Providers_Http_Exception_NetworkException {
	rt.PhpObjectBase
}

fn create_wp_ai_client_http_client(arg_0 rt.PhpVal, arg_1 rt.PhpVal) &Class_WP_AI_Client_HTTP_Client {
	mut obj := &Class_WP_AI_Client_HTTP_Client{
		PhpObjectBase: rt.PhpObjectBase{}
		response_factory: rt.new_null()
		stream_factory: rt.new_null()
	}
	obj.construct(arg_0, arg_1)
	return obj
}

fn create_wordpress_aiclient_providers_http_exception_networkexception() &Class_WordPress_AiClient_Providers_Http_Exception_NetworkException {
	mut obj := &Class_WordPress_AiClient_Providers_Http_Exception_NetworkException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_AI_Client_HTTP_Client) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WordPress_AiClientDependencies_Psr_Http_Message_ResponseFactoryInterface](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_WordPress_AiClientDependencies_Psr_Http_Message_StreamFactoryInterface](if args.len > 1 { args[1] } else { rt.new_null() })
			this.construct(mut dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'sendRequest' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WordPress_AiClientDependencies_Psr_Http_Message_RequestInterface](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.sendrequest(mut dispatch_arg_0)
		}
		'sendRequestWithOptions' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WordPress_AiClientDependencies_Psr_Http_Message_RequestInterface](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_WordPress_AiClient_Providers_Http_DTO_RequestOptions](if args.len > 1 { args[1] } else { rt.new_null() })
			return this.sendrequestwithoptions(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		'prepare_wp_args' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WordPress_AiClientDependencies_Psr_Http_Message_RequestInterface](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_?RequestOptions](if args.len > 1 { args[1] } else { rt.new_null() })
			return this.prepare_wp_args(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		'prepare_headers' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WordPress_AiClientDependencies_Psr_Http_Message_RequestInterface](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.prepare_headers(mut dispatch_arg_0)
		}
		'prepare_body' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WordPress_AiClientDependencies_Psr_Http_Message_RequestInterface](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_string(this.prepare_body(mut dispatch_arg_0))
		}
		'create_psr_response' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.create_psr_response(mut dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_WP_AI_Client_HTTP_Client) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'response_factory' { return this.response_factory }
		'stream_factory' { return this.stream_factory }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_AI_Client_HTTP_Client) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'response_factory' { this.response_factory = val; return true }
		'stream_factory' { this.stream_factory = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
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




pub fn init_wp_includes_ai_client_adapters_class_wp_ai_client_http_client_php() {
}
