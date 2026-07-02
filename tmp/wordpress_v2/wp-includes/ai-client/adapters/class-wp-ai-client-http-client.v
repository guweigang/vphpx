import rt

struct Class_WP_AI_Client_HTTP_Client {
	rt.PhpObjectBase
pub mut:
		response_factory rt.PhpVal = rt.new_null()
		stream_factory rt.PhpVal = rt.new_null()
}

fn (mut this Class_WP_AI_Client_HTTP_Client) construct(mut var_response_factory Class_WordPress_AiClientDependencies_Psr_Http_Message_ResponseFactoryInterface, mut var_stream_factory Class_WordPress_AiClientDependencies_Psr_Http_Message_StreamFactoryInterface) {
	this.response_factory = var_response_factory
	this.stream_factory = var_stream_factory
}

fn (mut this Class_WP_AI_Client_HTTP_Client) sendrequest(mut var_request Class_WordPress_AiClientDependencies_Psr_Http_Message_RequestInterface) rt.PhpVal {
	mut var_args := this.prepare_wp_args(mut var_request, rt.new_null())
	mut var_url := rt.new_string((var_request.geturi()).str())
	mut var_response := rt.call_function('wp_safe_remote_request', [var_url.clone(), var_args.clone()])
	if rt.is_true(rt.call_function('is_wp_error', [var_response.clone()])) {
		mut var_message := rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Network error occurred while sending %1$s request to %2$s: %3$s')]), var_request.getmethod(), var_url.clone(), rt.call_method(var_response, 'get_error_message', []rt.PhpVal{})])
		rt.throw_exception(rt.new_object('WordPress_AiClient_Providers_Http_Exception_NetworkException', []string{}, create_wordpress_aiclient_providers_http_exception_networkexception(var_message.clone())))
	}
	return this.create_psr_response(mut rt.cast_object_ptr[Class_array](var_response))
}

fn (mut this Class_WP_AI_Client_HTTP_Client) sendrequestwithoptions(mut var_request Class_WordPress_AiClientDependencies_Psr_Http_Message_RequestInterface, mut var_options Class_WordPress_AiClient_Providers_Http_DTO_RequestOptions) rt.PhpVal {
	mut var_args := this.prepare_wp_args(mut var_request, mut var_options)
	mut var_url := rt.new_string((var_request.geturi()).str())
	mut var_response := rt.call_function('wp_safe_remote_request', [var_url.clone(), var_args.clone()])
	if rt.is_true(rt.call_function('is_wp_error', [var_response.clone()])) {
		mut var_message := rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Network error occurred while sending request to %1$s: %2$s')]), var_url.clone(), rt.call_method(var_response, 'get_error_message', []rt.PhpVal{})])
		rt.throw_exception(rt.new_object('WordPress_AiClient_Providers_Http_Exception_NetworkException', []string{}, create_wordpress_aiclient_providers_http_exception_networkexception(var_message.clone(), if rt.is_true(rt.call_method(var_response, 'get_error_code', []rt.PhpVal{})) { rt.new_int((rt.call_method(var_response, 'get_error_code', []rt.PhpVal{})).to_i64()) } else { 0 })))
	}
	return this.create_psr_response(mut rt.cast_object_ptr[Class_array](var_response))
}

fn (mut this Class_WP_AI_Client_HTTP_Client) prepare_wp_args(mut var_request Class_WordPress_AiClientDependencies_Psr_Http_Message_RequestInterface, mut var_options Class_?RequestOptions) rt.PhpVal {
	mut var_args := rt.create_array([rt.ArrayItem{ key: 'method', val: var_request.getmethod() }, rt.ArrayItem{ key: 'headers', val: this.prepare_headers(mut var_request) }, rt.ArrayItem{ key: 'body', val: this.prepare_body(mut var_request) }, rt.ArrayItem{ key: 'httpversion', val: var_request.getprotocolversion() }, rt.ArrayItem{ key: 'blocking', val: true }])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_options)))) {
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_options.gettimeout())))) {
			var_args.array_set('timeout', var_options.gettimeout())
		}
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_options.getmaxredirects())))) {
			var_args.array_set('redirection', var_options.getmaxredirects())
		}
	}
	return var_args.clone()
}

fn (mut this Class_WP_AI_Client_HTTP_Client) prepare_headers(mut var_request Class_WordPress_AiClientDependencies_Psr_Http_Message_RequestInterface) rt.PhpVal {
	mut var_headers := rt.new_array()
	mut iter_1 := var_request.getheaders().iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_values := item_1.val
		mut var_name := item_1.key
		var_headers.array_set((var_name).str(), rt.call_function('implode', [rt.new_string(', '), var_values.clone()]))
	}
	return var_headers.clone()
}

fn (mut this Class_WP_AI_Client_HTTP_Client) prepare_body(mut var_request Class_WordPress_AiClientDependencies_Psr_Http_Message_RequestInterface) string {
	mut var_body := var_request.getbody()
	if rt.is_true(rt.identical(rt.call_method(var_body, 'getSize', []rt.PhpVal{}), rt.new_int(0))) {
		return (rt.new_null()).str()
	}
	if rt.is_true(rt.call_method(var_body, 'isSeekable', []rt.PhpVal{})) {
		rt.call_method(var_body, 'rewind', []rt.PhpVal{})
	}
	return (var_body).str()
}

fn (mut this Class_WP_AI_Client_HTTP_Client) create_psr_response(mut var_wp_response Class_array) rt.PhpVal {
	mut var_status_code := rt.call_function('wp_remote_retrieve_response_code', [var_wp_response])
	mut var_reason_phrase := rt.call_function('wp_remote_retrieve_response_message', [var_wp_response])
	mut var_headers := rt.call_function('wp_remote_retrieve_headers', [var_wp_response])
	mut var_body := rt.call_function('wp_remote_retrieve_body', [var_wp_response])
	mut var_response := rt.call_method(this.response_factory, 'createResponse', [rt.new_int((var_status_code).to_i64()), var_reason_phrase.clone()])
	if rt.is_true(rt.new_bool(rt.instance_of(var_headers, 'WP_HTTP_Requests_Response'))) {
	var_headers = rt.call_method(var_headers, 'get_headers', []rt.PhpVal{})
	}
	if var_headers.clone().is_array() || rt.is_true(rt.new_bool(rt.instance_of(var_headers, 'Traversable'))) {
		mut iter_2 := var_headers.iterator()
		for {
			item_2 := iter_2.next() or { break }
			mut var_value := item_2.val
			mut var_name := item_2.key
		var_response = rt.call_method(var_response, 'withHeader', [var_name.clone(), var_value.clone()])
		}
	}
	if !(!rt.is_true(var_body)) {
	mut var_stream := rt.call_method(this.stream_factory, 'createStream', [var_body.clone()])
	var_response = rt.call_method(var_response, 'withBody', [var_stream.clone()])
	}
	return var_response.clone()
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

fn create_wordpress_aiclient_providers_http_exception_networkexception(_args ...rt.PhpVal) &Class_WordPress_AiClient_Providers_Http_Exception_NetworkException {
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



fn main() {
	defer {
		rt.shutdown()
	}

}
