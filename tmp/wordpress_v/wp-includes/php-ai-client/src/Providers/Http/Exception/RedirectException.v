import rt

struct Class_WordPress_AiClient_Providers_Http_Exception_RedirectException {
	rt.PhpObjectBase
}

fn Class_WordPress_AiClient_Providers_Http_Exception_RedirectException.fromredirectresponse(mut var_response Class_WordPress_AiClient_Providers_Http_DTO_Response) rt.PhpVal {
	mut var_statusCode := var_response.getstatuscode()
	mut var_statusTexts := rt.create_array([rt.ArrayItem{ key: 300, val: 'Multiple Choices' }, rt.ArrayItem{ key: 301, val: 'Moved Permanently' }, rt.ArrayItem{ key: 302, val: 'Found' }, rt.ArrayItem{ key: 303, val: 'See Other' }, rt.ArrayItem{ key: 304, val: 'Not Modified' }, rt.ArrayItem{ key: 307, val: 'Temporary Redirect' }, rt.ArrayItem{ key: 308, val: 'Permanent Redirect' }])
	if var_statusTexts.array_isset(var_statusCode) {
		mut var_errorMessage := rt.call_function('sprintf', [rt.new_string('%s (%d)'), var_statusTexts.array_get(var_statusCode), var_statusCode.dup()])
	} else {
		var_errorMessage = rt.call_function('sprintf', [rt.new_string('Redirect error (%d): Request needs to be retried at a different location'), var_statusCode.dup()])
	}
	mut var_locationValues := var_response.getheader(rt.new_string('Location'))
	if rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) && !(!rt.is_true(var_locationValues)))) {
		mut var_location := var_locationValues.array_get(0)
		// unsupported expression: Expr_AssignOp_Concat
	}
	return create_wordpress_aiclient_providers_http_exception_self(var_errorMessage.dup(), var_statusCode.dup())
}

struct Class_WordPress_AiClient_Common_Exception_RuntimeException {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClient_Providers_Http_Exception_self {
	rt.PhpObjectBase
}

fn create_wordpress_aiclient_providers_http_exception_redirectexception() &Class_WordPress_AiClient_Providers_Http_Exception_RedirectException {
	mut obj := &Class_WordPress_AiClient_Providers_Http_Exception_RedirectException{
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

fn create_wordpress_aiclient_providers_http_exception_self() &Class_WordPress_AiClient_Providers_Http_Exception_self {
	mut obj := &Class_WordPress_AiClient_Providers_Http_Exception_self{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WordPress_AiClient_Providers_Http_Exception_RedirectException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'fromRedirectResponse' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WordPress_AiClient_Providers_Http_DTO_Response](if args.len > 0 { args[0] } else { rt.new_null() })
			return Class_WordPress_AiClient_Providers_Http_Exception_RedirectException.fromredirectresponse(mut dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_WordPress_AiClient_Providers_Http_Exception_RedirectException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClient_Providers_Http_Exception_RedirectException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_WordPress_AiClient_Providers_Http_Exception_self) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WordPress_AiClient_Providers_Http_Exception_self) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClient_Providers_Http_Exception_self) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_includes_php_ai_client_src_providers_http_exception_redirectexception_php() {
	// unsupported statement: Stmt_Declare
}
