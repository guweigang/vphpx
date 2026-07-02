import rt

struct Class_WordPress_AiClient_Providers_Http_Exception_NetworkException {
	rt.PhpObjectBase
pub mut:
	request rt.PhpVal = rt.new_null()
}

fn (mut this Class_WordPress_AiClient_Providers_Http_Exception_NetworkException) getrequest() rt.PhpVal {
	if rt.is_true(rt.identical(this.request, rt.new_null())) {
		rt.throw_exception(rt.new_object('WordPress_AiClient_Common_Exception_RuntimeException',
			[]string{}, create_wordpress_aiclient_common_exception_runtimeexception(
			'Request object not available. This exception was directly instantiated. ' +
			'Use a factory method that provides request context.')))
	}
	return this.request
}

fn Class_WordPress_AiClient_Providers_Http_Exception_NetworkException.frompsr18networkexception(mut var_psrRequest Class_WordPress_AiClientDependencies_Psr_Http_Message_RequestInterface, mut var_networkException Class_WordPress_AiClient_Providers_Http_Exception_Throwable) rt.PhpVal {
	mut iife_temp_0 := Class_WordPress_AiClient_Providers_Http_DTO_Request{}
	mut iife_result_0 := iife_temp_0.frompsrrequest(rt.new_object('WordPress_AiClientDependencies_Psr_Http_Message_RequestInterface',
		[]string{}, var_psrRequest))
	mut var_request := iife_result_0
	mut var_message := rt.call_function('sprintf', [
		rt.new_string('Network error occurred while sending request to %s: %s'),
		rt.call_method(var_request, 'getUri', []rt.PhpVal{}),
		var_networkException.getmessage(),
	])
	mut var_exception := create_wordpress_aiclient_providers_http_exception_self(var_message.clone(),
		rt.new_int(0), var_networkException)
	rt.set_property(var_exception, 'request', var_request.clone())
	return mut var_exception
}

struct Class_WordPress_AiClient_Common_Exception_RuntimeException {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClient_Providers_Http_DTO_Request {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClient_Providers_Http_Exception_self {
	rt.PhpObjectBase
}

fn create_wordpress_aiclient_providers_http_exception_networkexception(_args ...rt.PhpVal) &Class_WordPress_AiClient_Providers_Http_Exception_NetworkException {
	mut obj := &Class_WordPress_AiClient_Providers_Http_Exception_NetworkException{
		PhpObjectBase: rt.PhpObjectBase{}
		request:       rt.new_null()
	}
	return obj
}

fn create_wordpress_aiclient_common_exception_runtimeexception(_args ...rt.PhpVal) &Class_WordPress_AiClient_Common_Exception_RuntimeException {
	mut obj := &Class_WordPress_AiClient_Common_Exception_RuntimeException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wordpress_aiclient_providers_http_dto_request(_args ...rt.PhpVal) &Class_WordPress_AiClient_Providers_Http_DTO_Request {
	mut obj := &Class_WordPress_AiClient_Providers_Http_DTO_Request{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wordpress_aiclient_providers_http_exception_self(_args ...rt.PhpVal) &Class_WordPress_AiClient_Providers_Http_Exception_self {
	mut obj := &Class_WordPress_AiClient_Providers_Http_Exception_self{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WordPress_AiClient_Providers_Http_Exception_NetworkException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'getRequest' {
			return this.getrequest()
		}
		'fromPsr18NetworkException' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WordPress_AiClientDependencies_Psr_Http_Message_RequestInterface](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_WordPress_AiClient_Providers_Http_Exception_Throwable](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			return Class_WordPress_AiClient_Providers_Http_Exception_NetworkException.frompsr18networkexception(mut dispatch_arg_0, mut
				dispatch_arg_1)
		}
		else {
			return none
		}
	}
}

fn (this &Class_WordPress_AiClient_Providers_Http_Exception_NetworkException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'request' { return this.request }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WordPress_AiClient_Providers_Http_Exception_NetworkException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'request' {
			this.request = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
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

fn (mut this Class_WordPress_AiClient_Providers_Http_DTO_Request) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WordPress_AiClient_Providers_Http_DTO_Request) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClient_Providers_Http_DTO_Request) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WordPress_AiClient_Providers_Http_Exception_self) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WordPress_AiClient_Providers_Http_Exception_self) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClient_Providers_Http_Exception_self) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
