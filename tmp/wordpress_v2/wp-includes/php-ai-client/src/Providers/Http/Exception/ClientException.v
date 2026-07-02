import rt

struct Class_WordPress_AiClient_Providers_Http_Exception_ClientException {
	rt.PhpObjectBase
pub mut:
	request rt.PhpVal = rt.new_null()
}

fn (mut this Class_WordPress_AiClient_Providers_Http_Exception_ClientException) getrequest() rt.PhpVal {
	if rt.is_true(rt.identical(this.request, rt.new_null())) {
		rt.throw_exception(rt.new_object('WordPress_AiClient_Providers_Http_Exception_RuntimeException',
			[]string{}, create_wordpress_aiclient_providers_http_exception_runtimeexception(
			'Request object not available. This exception was directly instantiated. ' +
			'Use a factory method that provides request context.')))
	}
	return this.request
}

fn Class_WordPress_AiClient_Providers_Http_Exception_ClientException.fromclienterrorresponse(mut var_response Class_WordPress_AiClient_Providers_Http_DTO_Response) rt.PhpVal {
	mut var_statusCode := var_response.getstatuscode()
	mut var_statusTexts := rt.create_array([rt.ArrayItem{ key: 400, val: 'Bad Request' },
		rt.ArrayItem{ key: 401, val: 'Unauthorized' }, rt.ArrayItem{ key: 403, val: 'Forbidden' },
		rt.ArrayItem{ key: 404, val: 'Not Found' }, rt.ArrayItem{
			key: 422
			val: 'Unprocessable Entity'
		}, rt.ArrayItem{ key: 429, val: 'Too Many Requests' }])
	if var_statusTexts.array_isset(var_statusCode) {
		mut var_errorMessage := rt.call_function('sprintf', [
			rt.new_string('%s (%d)'), var_statusTexts.array_get(var_statusCode),
			var_statusCode.clone()])
	} else {
		var_errorMessage = rt.call_function('sprintf', [
			rt.new_string('Client error (%d): Request was rejected due to client-side issue'),
			var_statusCode.clone(),
		])
	}
	mut iife_temp_0 := Class_WordPress_AiClient_Providers_Http_Util_ErrorMessageExtractor{}
	mut iife_result_0 := iife_temp_0.extractfromresponsedata(var_response.getdata())
	mut var_extractedError := iife_result_0
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_extractedError, rt.new_null())))) {
		var_errorMessage = rt.concat(var_errorMessage, rt.new_string(' - ' +
			var_extractedError.str()))
	}
	return rt.new_object('WordPress_AiClient_Providers_Http_Exception_self', []string{}, create_wordpress_aiclient_providers_http_exception_self(var_errorMessage.clone(),
		var_statusCode.clone()))
}

struct Class_WordPress_AiClient_Common_Exception_InvalidArgumentException {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClient_Providers_Http_Exception_RuntimeException {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClient_Providers_Http_Util_ErrorMessageExtractor {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClient_Providers_Http_Exception_self {
	rt.PhpObjectBase
}

fn create_wordpress_aiclient_providers_http_exception_clientexception(_args ...rt.PhpVal) &Class_WordPress_AiClient_Providers_Http_Exception_ClientException {
	mut obj := &Class_WordPress_AiClient_Providers_Http_Exception_ClientException{
		PhpObjectBase: rt.PhpObjectBase{}
		request:       rt.new_null()
	}
	return obj
}

fn create_wordpress_aiclient_common_exception_invalidargumentexception(_args ...rt.PhpVal) &Class_WordPress_AiClient_Common_Exception_InvalidArgumentException {
	mut obj := &Class_WordPress_AiClient_Common_Exception_InvalidArgumentException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wordpress_aiclient_providers_http_exception_runtimeexception(_args ...rt.PhpVal) &Class_WordPress_AiClient_Providers_Http_Exception_RuntimeException {
	mut obj := &Class_WordPress_AiClient_Providers_Http_Exception_RuntimeException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wordpress_aiclient_providers_http_util_errormessageextractor(_args ...rt.PhpVal) &Class_WordPress_AiClient_Providers_Http_Util_ErrorMessageExtractor {
	mut obj := &Class_WordPress_AiClient_Providers_Http_Util_ErrorMessageExtractor{
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

fn (mut this Class_WordPress_AiClient_Providers_Http_Exception_ClientException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'getRequest' {
			return this.getrequest()
		}
		'fromClientErrorResponse' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WordPress_AiClient_Providers_Http_DTO_Response](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return Class_WordPress_AiClient_Providers_Http_Exception_ClientException.fromclienterrorresponse(mut dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_WordPress_AiClient_Providers_Http_Exception_ClientException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'request' { return this.request }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WordPress_AiClient_Providers_Http_Exception_ClientException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_WordPress_AiClient_Common_Exception_InvalidArgumentException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WordPress_AiClient_Common_Exception_InvalidArgumentException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClient_Common_Exception_InvalidArgumentException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WordPress_AiClient_Providers_Http_Exception_RuntimeException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WordPress_AiClient_Providers_Http_Exception_RuntimeException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClient_Providers_Http_Exception_RuntimeException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WordPress_AiClient_Providers_Http_Util_ErrorMessageExtractor) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WordPress_AiClient_Providers_Http_Util_ErrorMessageExtractor) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClient_Providers_Http_Util_ErrorMessageExtractor) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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
