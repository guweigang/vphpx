import rt

struct Class_WordPress_AiClient_Providers_Http_Exception_ResponseException {
	rt.PhpObjectBase
}

fn Class_WordPress_AiClient_Providers_Http_Exception_ResponseException.frommissingdata(apiName string, fieldName string) rt.PhpVal {
	mut var_message := rt.call_function('sprintf', [
		rt.new_string('Unexpected %s API response: Missing the "%s" key.'),
		rt.new_string(apiName),
		rt.new_string(fieldName),
	])
	return rt.new_object('WordPress_AiClient_Providers_Http_Exception_self', []string{},
		create_wordpress_aiclient_providers_http_exception_self(var_message.clone()))
}

fn Class_WordPress_AiClient_Providers_Http_Exception_ResponseException.frominvaliddata(apiName string, fieldName string, message string) rt.PhpVal {
	mut message_mutated := message
	return rt.new_object('WordPress_AiClient_Providers_Http_Exception_self', []string{}, create_wordpress_aiclient_providers_http_exception_self(rt.call_function('sprintf', [
		rt.new_string('Unexpected %s API response: Invalid "%s" key: %s'),
		rt.new_string(apiName),
		rt.new_string(fieldName),
		rt.new_string(message_mutated).clone(),
	])))
}

struct Class_WordPress_AiClient_Common_Exception_RuntimeException {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClient_Providers_Http_Exception_self {
	rt.PhpObjectBase
}

fn create_wordpress_aiclient_providers_http_exception_responseexception(_args ...rt.PhpVal) &Class_WordPress_AiClient_Providers_Http_Exception_ResponseException {
	mut obj := &Class_WordPress_AiClient_Providers_Http_Exception_ResponseException{
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

fn create_wordpress_aiclient_providers_http_exception_self(_args ...rt.PhpVal) &Class_WordPress_AiClient_Providers_Http_Exception_self {
	mut obj := &Class_WordPress_AiClient_Providers_Http_Exception_self{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WordPress_AiClient_Providers_Http_Exception_ResponseException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'fromMissingData' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return Class_WordPress_AiClient_Providers_Http_Exception_ResponseException.frommissingdata(dispatch_arg_0,
				dispatch_arg_1)
		}
		'fromInvalidData' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			return Class_WordPress_AiClient_Providers_Http_Exception_ResponseException.frominvaliddata(dispatch_arg_0,
				dispatch_arg_1, dispatch_arg_2)
		}
		else {
			return none
		}
	}
}

fn (this &Class_WordPress_AiClient_Providers_Http_Exception_ResponseException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClient_Providers_Http_Exception_ResponseException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn main() {
	defer {
		rt.shutdown()
	}
}
