import rt

struct Class_WordPress_AiClient_Providers_Http_Exception_ServerException {
	rt.PhpObjectBase
}

fn Class_WordPress_AiClient_Providers_Http_Exception_ServerException.fromservererrorresponse(mut var_response Class_WordPress_AiClient_Providers_Http_DTO_Response) rt.PhpVal {
	mut var_statusCode := var_response.getstatuscode()
	mut var_statusTexts := rt.create_array([
		rt.ArrayItem{ key: 500, val: 'Internal Server Error' },
		rt.ArrayItem{ key: 502, val: 'Bad Gateway' },
		rt.ArrayItem{ key: 503, val: 'Service Unavailable' },
		rt.ArrayItem{ key: 504, val: 'Gateway Timeout' },
		rt.ArrayItem{ key: 507, val: 'Insufficient Storage' },
		rt.ArrayItem{ key: 529, val: 'Overloaded' },
	])
	if var_statusTexts.array_isset(var_statusCode) {
		mut var_errorMessage := rt.call_function('sprintf', [
			rt.new_string('%s (%d)'), var_statusTexts.array_get(var_statusCode),
			var_statusCode.clone()])
	} else {
		var_errorMessage = rt.call_function('sprintf', [
			rt.new_string('Server error (%d): Request was rejected due to server-side issue'),
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
		var_response.getstatuscode()))
}

struct Class_WordPress_AiClient_Common_Exception_RuntimeException {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClient_Providers_Http_Util_ErrorMessageExtractor {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClient_Providers_Http_Exception_self {
	rt.PhpObjectBase
}

fn create_wordpress_aiclient_providers_http_exception_serverexception(_args ...rt.PhpVal) &Class_WordPress_AiClient_Providers_Http_Exception_ServerException {
	mut obj := &Class_WordPress_AiClient_Providers_Http_Exception_ServerException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wordpress_aiclient_common_exception_runtimeexception(_args ...rt.PhpVal) &Class_WordPress_AiClient_Common_Exception_RuntimeException {
	mut obj := &Class_WordPress_AiClient_Common_Exception_RuntimeException{
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

fn (mut this Class_WordPress_AiClient_Providers_Http_Exception_ServerException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'fromServerErrorResponse' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WordPress_AiClient_Providers_Http_DTO_Response](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return Class_WordPress_AiClient_Providers_Http_Exception_ServerException.fromservererrorresponse(mut dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_WordPress_AiClient_Providers_Http_Exception_ServerException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClient_Providers_Http_Exception_ServerException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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
