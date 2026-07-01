import rt

struct Class_WordPress_AiClient_Providers_Http_Util_ResponseUtil {
	rt.PhpObjectBase
}

fn Class_WordPress_AiClient_Providers_Http_Util_ResponseUtil.throwifnotsuccessful(mut var_response Class_WordPress_AiClient_Providers_Http_DTO_Response) {
	if rt.is_true(var_response.issuccessful()) {
		return rt.new_null()
	}
	mut var_statusCode := var_response.getstatuscode()
	if rt.is_true(rt.new_bool(rt.is_true(rt.greater_equal(var_statusCode, rt.new_int(300)))
		&& rt.is_true(rt.less(var_statusCode, rt.new_int(400)))))
	{
		rt.throw_exception(fn (arg_0 rt.PhpVal) rt.PhpVal {
			mut temp := Class_WordPress_AiClient_Providers_Http_Exception_RedirectException{}
			return temp.fromredirectresponse(arg_0)
		}(rt.new_object('WordPress_AiClient_Providers_Http_DTO_Response', []string{}, var_response)))
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.greater_equal(var_statusCode, rt.new_int(400)))
		&& rt.is_true(rt.less(var_statusCode, rt.new_int(500)))))
	{
		rt.throw_exception(fn (arg_0 rt.PhpVal) rt.PhpVal {
			mut temp := Class_WordPress_AiClient_Providers_Http_Exception_ClientException{}
			return temp.fromclienterrorresponse(arg_0)
		}(rt.new_object('WordPress_AiClient_Providers_Http_DTO_Response', []string{}, var_response)))
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.greater_equal(var_statusCode, rt.new_int(500)))
		&& rt.is_true(rt.less(var_statusCode, rt.new_int(600)))))
	{
		rt.throw_exception(fn (arg_0 rt.PhpVal) rt.PhpVal {
			mut temp := Class_WordPress_AiClient_Providers_Http_Exception_ServerException{}
			return temp.fromservererrorresponse(arg_0)
		}(rt.new_object('WordPress_AiClient_Providers_Http_DTO_Response', []string{}, var_response)))
	}
	rt.throw_exception(rt.new_object('WordPress_AiClient_Providers_Http_Util_RuntimeException',
		[]string{}, create_wordpress_aiclient_providers_http_util_runtimeexception(rt.call_function('sprintf', [
		rt.new_string('Response returned invalid status code: %s'),
		var_response.getstatuscode(),
	]))))
}

struct Class_WordPress_AiClient_Providers_Http_Exception_RedirectException {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClient_Providers_Http_Exception_ClientException {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClient_Providers_Http_Exception_ServerException {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClient_Providers_Http_Util_RuntimeException {
	rt.PhpObjectBase
}

fn create_wordpress_aiclient_providers_http_util_responseutil() &Class_WordPress_AiClient_Providers_Http_Util_ResponseUtil {
	mut obj := &Class_WordPress_AiClient_Providers_Http_Util_ResponseUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wordpress_aiclient_providers_http_exception_redirectexception() &Class_WordPress_AiClient_Providers_Http_Exception_RedirectException {
	mut obj := &Class_WordPress_AiClient_Providers_Http_Exception_RedirectException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wordpress_aiclient_providers_http_exception_clientexception() &Class_WordPress_AiClient_Providers_Http_Exception_ClientException {
	mut obj := &Class_WordPress_AiClient_Providers_Http_Exception_ClientException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wordpress_aiclient_providers_http_exception_serverexception() &Class_WordPress_AiClient_Providers_Http_Exception_ServerException {
	mut obj := &Class_WordPress_AiClient_Providers_Http_Exception_ServerException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wordpress_aiclient_providers_http_util_runtimeexception() &Class_WordPress_AiClient_Providers_Http_Util_RuntimeException {
	mut obj := &Class_WordPress_AiClient_Providers_Http_Util_RuntimeException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WordPress_AiClient_Providers_Http_Util_ResponseUtil) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'throwIfNotSuccessful' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WordPress_AiClient_Providers_Http_DTO_Response](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			Class_WordPress_AiClient_Providers_Http_Util_ResponseUtil.throwifnotsuccessful(mut dispatch_arg_0)
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WordPress_AiClient_Providers_Http_Util_ResponseUtil) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClient_Providers_Http_Util_ResponseUtil) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WordPress_AiClient_Providers_Http_Exception_RedirectException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WordPress_AiClient_Providers_Http_Exception_RedirectException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClient_Providers_Http_Exception_RedirectException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WordPress_AiClient_Providers_Http_Exception_ClientException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WordPress_AiClient_Providers_Http_Exception_ClientException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClient_Providers_Http_Exception_ClientException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WordPress_AiClient_Providers_Http_Exception_ServerException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WordPress_AiClient_Providers_Http_Exception_ServerException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClient_Providers_Http_Exception_ServerException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WordPress_AiClient_Providers_Http_Util_RuntimeException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WordPress_AiClient_Providers_Http_Util_RuntimeException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClient_Providers_Http_Util_RuntimeException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_includes_php_ai_client_src_providers_http_util_responseutil_php() {
	// unsupported statement: Stmt_Declare
}
