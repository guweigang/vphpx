import rt

struct Class_WordPress_AiClientDependencies_Nyholm_Psr7_Factory_HttplugFactory {
	rt.PhpObjectBase
}

fn (mut this Class_WordPress_AiClientDependencies_Nyholm_Psr7_Factory_HttplugFactory) createrequest(var_method rt.PhpVal, var_uri rt.PhpVal, mut var_headers Class_WordPress_AiClientDependencies_Nyholm_Psr7_Factory_array, var_body rt.PhpVal, protocolVersion string) rt.PhpVal {
	return rt.new_object('WordPress_AiClientDependencies_Nyholm_Psr7_Request', []string{}, create_wordpress_aiclientdependencies_nyholm_psr7_request(var_method.clone(),
		var_uri.clone(), var_headers, var_body.clone(), rt.new_string(protocolVersion)))
}

fn (mut this Class_WordPress_AiClientDependencies_Nyholm_Psr7_Factory_HttplugFactory) createresponse(statusCode i64, var_reasonPhrase rt.PhpVal, mut var_headers Class_WordPress_AiClientDependencies_Nyholm_Psr7_Factory_array, var_body rt.PhpVal, version string) rt.PhpVal {
	return rt.new_object('WordPress_AiClientDependencies_Nyholm_Psr7_Response', []string{}, create_wordpress_aiclientdependencies_nyholm_psr7_response(statusCode,
		var_headers, var_body.clone(), rt.new_string(version), var_reasonPhrase.clone()))
}

fn (mut this Class_WordPress_AiClientDependencies_Nyholm_Psr7_Factory_HttplugFactory) createstream(var_body rt.PhpVal) rt.PhpVal {
	mut iife_temp_0 := Class_WordPress_AiClientDependencies_Nyholm_Psr7_Stream{}
	mut iife_result_0 := iife_temp_0.create(if !var_body.is_null() {
		var_body
	} else {
		rt.new_string('')
	})
	return iife_result_0
}

fn (mut this Class_WordPress_AiClientDependencies_Nyholm_Psr7_Factory_HttplugFactory) createuri(uri string) rt.PhpVal {
	if rt.is_true(rt.new_bool(rt.instance_of(rt.new_string(uri),
		'WordPress_AiClientDependencies_Psr_Http_Message_UriInterface')))
	{
		return rt.new_string(uri)
	}
	return rt.new_object('WordPress_AiClientDependencies_Nyholm_Psr7_Uri', []string{},
		create_wordpress_aiclientdependencies_nyholm_psr7_uri(rt.new_string(uri)))
}

struct Class_WordPress_AiClientDependencies_Nyholm_Psr7_Factory_LogicException {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClientDependencies_Nyholm_Psr7_Request {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClientDependencies_Nyholm_Psr7_Response {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClientDependencies_Nyholm_Psr7_Stream {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClientDependencies_Nyholm_Psr7_Uri {
	rt.PhpObjectBase
}

fn create_wordpress_aiclientdependencies_nyholm_psr7_factory_httplugfactory(_args ...rt.PhpVal) &Class_WordPress_AiClientDependencies_Nyholm_Psr7_Factory_HttplugFactory {
	mut obj := &Class_WordPress_AiClientDependencies_Nyholm_Psr7_Factory_HttplugFactory{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wordpress_aiclientdependencies_nyholm_psr7_factory_logicexception(_args ...rt.PhpVal) &Class_WordPress_AiClientDependencies_Nyholm_Psr7_Factory_LogicException {
	mut obj := &Class_WordPress_AiClientDependencies_Nyholm_Psr7_Factory_LogicException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wordpress_aiclientdependencies_nyholm_psr7_request(_args ...rt.PhpVal) &Class_WordPress_AiClientDependencies_Nyholm_Psr7_Request {
	mut obj := &Class_WordPress_AiClientDependencies_Nyholm_Psr7_Request{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wordpress_aiclientdependencies_nyholm_psr7_response(_args ...rt.PhpVal) &Class_WordPress_AiClientDependencies_Nyholm_Psr7_Response {
	mut obj := &Class_WordPress_AiClientDependencies_Nyholm_Psr7_Response{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wordpress_aiclientdependencies_nyholm_psr7_stream(_args ...rt.PhpVal) &Class_WordPress_AiClientDependencies_Nyholm_Psr7_Stream {
	mut obj := &Class_WordPress_AiClientDependencies_Nyholm_Psr7_Stream{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wordpress_aiclientdependencies_nyholm_psr7_uri(_args ...rt.PhpVal) &Class_WordPress_AiClientDependencies_Nyholm_Psr7_Uri {
	mut obj := &Class_WordPress_AiClientDependencies_Nyholm_Psr7_Uri{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WordPress_AiClientDependencies_Nyholm_Psr7_Factory_HttplugFactory) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'createRequest' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_WordPress_AiClientDependencies_Nyholm_Psr7_Factory_array](if args.len > 2 {
				args[2]
			} else {
				rt.new_null()
			})
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			dispatch_arg_4 := (if args.len > 4 { args[4] } else { rt.new_null() }).str()
			return this.createrequest(dispatch_arg_0, dispatch_arg_1, mut dispatch_arg_2,
				dispatch_arg_3, dispatch_arg_4)
		}
		'createResponse' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_WordPress_AiClientDependencies_Nyholm_Psr7_Factory_array](if args.len > 2 {
				args[2]
			} else {
				rt.new_null()
			})
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			dispatch_arg_4 := (if args.len > 4 { args[4] } else { rt.new_null() }).str()
			return this.createresponse(dispatch_arg_0, dispatch_arg_1, mut dispatch_arg_2,
				dispatch_arg_3, dispatch_arg_4)
		}
		'createStream' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.createstream(dispatch_arg_0)
		}
		'createUri' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.createuri(dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_WordPress_AiClientDependencies_Nyholm_Psr7_Factory_HttplugFactory) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClientDependencies_Nyholm_Psr7_Factory_HttplugFactory) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WordPress_AiClientDependencies_Nyholm_Psr7_Factory_LogicException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WordPress_AiClientDependencies_Nyholm_Psr7_Factory_LogicException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClientDependencies_Nyholm_Psr7_Factory_LogicException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WordPress_AiClientDependencies_Nyholm_Psr7_Request) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WordPress_AiClientDependencies_Nyholm_Psr7_Request) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClientDependencies_Nyholm_Psr7_Request) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WordPress_AiClientDependencies_Nyholm_Psr7_Response) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WordPress_AiClientDependencies_Nyholm_Psr7_Response) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClientDependencies_Nyholm_Psr7_Response) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WordPress_AiClientDependencies_Nyholm_Psr7_Stream) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WordPress_AiClientDependencies_Nyholm_Psr7_Stream) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClientDependencies_Nyholm_Psr7_Stream) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WordPress_AiClientDependencies_Nyholm_Psr7_Uri) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WordPress_AiClientDependencies_Nyholm_Psr7_Uri) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClientDependencies_Nyholm_Psr7_Uri) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('interface_exists', [
		Class_WordPress_AiClientDependencies_Http_Message_MessageFactory.class(),
	])))))
	{
		rt.throw_exception(rt.new_object('WordPress_AiClientDependencies_Nyholm_Psr7_Factory_LogicException',
			[]string{},
			create_wordpress_aiclientdependencies_nyholm_psr7_factory_logicexception(rt.new_string('You cannot use "Nyholm\\Psr7\\Factory\\HttplugFactory" as the "php-http/message-factory" package is not installed. Try running "composer require php-http/message-factory". Note that this package is deprecated, use "psr/http-factory" instead'))))
	}
	rt.call_function('trigger_error', [
		rt.new_string('Class "Nyholm\\Psr7\\Factory\\HttplugFactory" is deprecated since version 1.8, use "Nyholm\\Psr7\\Factory\\Psr17Factory" instead.'),
		rt.get_constant('E_USER_DEPRECATED'),
	])
}
