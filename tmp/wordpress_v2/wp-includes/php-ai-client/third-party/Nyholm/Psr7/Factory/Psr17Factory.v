import rt

struct Class_WordPress_AiClientDependencies_Nyholm_Psr7_Factory_Psr17Factory {
	rt.PhpObjectBase
}

fn (mut this Class_WordPress_AiClientDependencies_Nyholm_Psr7_Factory_Psr17Factory) createrequest(method string, var_uri rt.PhpVal) rt.PhpVal {
	return rt.new_object('WordPress_AiClientDependencies_Nyholm_Psr7_Request', []string{}, create_wordpress_aiclientdependencies_nyholm_psr7_request(rt.new_string(method), var_uri.clone()))
}

fn (mut this Class_WordPress_AiClientDependencies_Nyholm_Psr7_Factory_Psr17Factory) createresponse(code i64, reasonPhrase string) rt.PhpVal {
	mut reasonPhrase_mutated := reasonPhrase
	if rt.is_true(rt.greater(rt.new_int(2), rt.call_function('func_num_args', []rt.PhpVal{}))) {
	reasonPhrase_mutated = (none).str()
	}
	return rt.new_object('WordPress_AiClientDependencies_Nyholm_Psr7_Response', []string{}, create_wordpress_aiclientdependencies_nyholm_psr7_response(rt.new_int(code), rt.new_array(), rt.new_null(), rt.new_string('1.1'), rt.new_string(reasonPhrase_mutated).clone()))
}

fn (mut this Class_WordPress_AiClientDependencies_Nyholm_Psr7_Factory_Psr17Factory) createstream(content string) rt.PhpVal {
	mut iife_temp_0 := Class_WordPress_AiClientDependencies_Nyholm_Psr7_Stream{}
	mut iife_result_0 := iife_temp_0.create(rt.new_string(content))
	return iife_result_0
}

fn (mut this Class_WordPress_AiClientDependencies_Nyholm_Psr7_Factory_Psr17Factory) createstreamfromfile(filename string, mode string) rt.PhpVal {
	if rt.is_true(rt.identical(rt.new_string(''), rt.new_string(filename))) {
		rt.throw_exception(rt.new_object('WordPress_AiClientDependencies_Nyholm_Psr7_Factory_RuntimeException', []string{}, create_wordpress_aiclientdependencies_nyholm_psr7_factory_runtimeexception(rt.new_string('Path cannot be empty'))))
	}
	mut var_resource := rt.call_function('fopen', [rt.new_string(filename), rt.new_string(mode)])
	if rt.is_true(rt.identical(rt.new_bool(false), var_resource)) {
		if rt.is_true(rt.identical(rt.new_string(''), rt.new_string(mode))) || rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('in_array', [rt.new_string(mode).array_get(rt.new_int(0)), rt.create_array([rt.ArrayItem{ key: none, val: 'r' }, rt.ArrayItem{ key: none, val: 'w' }, rt.ArrayItem{ key: none, val: 'a' }, rt.ArrayItem{ key: none, val: 'x' }, rt.ArrayItem{ key: none, val: 'c' }]), rt.new_bool(true)]))) {
			rt.throw_exception(rt.new_object('WordPress_AiClientDependencies_Nyholm_Psr7_Factory_InvalidArgumentException', []string{}, create_wordpress_aiclientdependencies_nyholm_psr7_factory_invalidargumentexception(rt.call_function('sprintf', [rt.new_string('The mode "%s" is invalid.'), rt.new_string(mode)]))))
		}
		rt.throw_exception(rt.new_object('WordPress_AiClientDependencies_Nyholm_Psr7_Factory_RuntimeException', []string{}, create_wordpress_aiclientdependencies_nyholm_psr7_factory_runtimeexception(rt.call_function('sprintf', [rt.new_string('The file "%s" cannot be opened: %s'), rt.new_string(filename), if !(rt.call_function('error_get_last', []rt.PhpVal{}).array_get(rt.new_string('message'))).is_null() { rt.call_function('error_get_last', []rt.PhpVal{}).array_get(rt.new_string('message')) } else { rt.new_string('') }]))))
	}
	mut iife_temp_1 := Class_WordPress_AiClientDependencies_Nyholm_Psr7_Stream{}
	mut iife_result_1 := iife_temp_1.create(var_resource.clone())
	return iife_result_1
}

fn (mut this Class_WordPress_AiClientDependencies_Nyholm_Psr7_Factory_Psr17Factory) createstreamfromresource(var_resource rt.PhpVal) rt.PhpVal {
	mut iife_temp_2 := Class_WordPress_AiClientDependencies_Nyholm_Psr7_Stream{}
	mut iife_result_2 := iife_temp_2.create(var_resource.clone())
	return iife_result_2
}

fn (mut this Class_WordPress_AiClientDependencies_Nyholm_Psr7_Factory_Psr17Factory) createuploadedfile(mut var_stream Class_WordPress_AiClientDependencies_Psr_Http_Message_StreamInterface, mut var_size Class_WordPress_AiClientDependencies_Nyholm_Psr7_Factory_?int, error i64, mut var_clientFilename Class_WordPress_AiClientDependencies_Nyholm_Psr7_Factory_?string, mut var_clientMediaType Class_WordPress_AiClientDependencies_Nyholm_Psr7_Factory_?string) rt.PhpVal {
	mut var_size_mutated := var_size
	if rt.is_true(rt.identical(rt.new_null(), var_size_mutated)) {
	var_size_mutated = var_stream.getsize()
	}
	return rt.new_object('WordPress_AiClientDependencies_Nyholm_Psr7_UploadedFile', []string{}, create_wordpress_aiclientdependencies_nyholm_psr7_uploadedfile(var_stream, var_size_mutated, rt.new_int(error), var_clientFilename, var_clientMediaType))
}

fn (mut this Class_WordPress_AiClientDependencies_Nyholm_Psr7_Factory_Psr17Factory) createuri(uri string) rt.PhpVal {
	return rt.new_object('WordPress_AiClientDependencies_Nyholm_Psr7_Uri', []string{}, create_wordpress_aiclientdependencies_nyholm_psr7_uri(rt.new_string(uri)))
}

fn (mut this Class_WordPress_AiClientDependencies_Nyholm_Psr7_Factory_Psr17Factory) createserverrequest(method string, var_uri rt.PhpVal, mut var_serverParams Class_WordPress_AiClientDependencies_Nyholm_Psr7_Factory_array) rt.PhpVal {
	return rt.new_object('WordPress_AiClientDependencies_Nyholm_Psr7_ServerRequest', []string{}, create_wordpress_aiclientdependencies_nyholm_psr7_serverrequest(rt.new_string(method), var_uri.clone(), rt.new_array(), rt.new_null(), rt.new_string('1.1'), var_serverParams))
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

struct Class_WordPress_AiClientDependencies_Nyholm_Psr7_Factory_RuntimeException {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClientDependencies_Nyholm_Psr7_Factory_InvalidArgumentException {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClientDependencies_Nyholm_Psr7_UploadedFile {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClientDependencies_Nyholm_Psr7_Uri {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClientDependencies_Nyholm_Psr7_ServerRequest {
	rt.PhpObjectBase
}

fn create_wordpress_aiclientdependencies_nyholm_psr7_factory_psr17factory(_args ...rt.PhpVal) &Class_WordPress_AiClientDependencies_Nyholm_Psr7_Factory_Psr17Factory {
	mut obj := &Class_WordPress_AiClientDependencies_Nyholm_Psr7_Factory_Psr17Factory{
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

fn create_wordpress_aiclientdependencies_nyholm_psr7_factory_runtimeexception(_args ...rt.PhpVal) &Class_WordPress_AiClientDependencies_Nyholm_Psr7_Factory_RuntimeException {
	mut obj := &Class_WordPress_AiClientDependencies_Nyholm_Psr7_Factory_RuntimeException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wordpress_aiclientdependencies_nyholm_psr7_factory_invalidargumentexception(_args ...rt.PhpVal) &Class_WordPress_AiClientDependencies_Nyholm_Psr7_Factory_InvalidArgumentException {
	mut obj := &Class_WordPress_AiClientDependencies_Nyholm_Psr7_Factory_InvalidArgumentException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wordpress_aiclientdependencies_nyholm_psr7_uploadedfile(_args ...rt.PhpVal) &Class_WordPress_AiClientDependencies_Nyholm_Psr7_UploadedFile {
	mut obj := &Class_WordPress_AiClientDependencies_Nyholm_Psr7_UploadedFile{
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

fn create_wordpress_aiclientdependencies_nyholm_psr7_serverrequest(_args ...rt.PhpVal) &Class_WordPress_AiClientDependencies_Nyholm_Psr7_ServerRequest {
	mut obj := &Class_WordPress_AiClientDependencies_Nyholm_Psr7_ServerRequest{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WordPress_AiClientDependencies_Nyholm_Psr7_Factory_Psr17Factory) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'createRequest' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.createrequest(dispatch_arg_0, dispatch_arg_1)
		}
		'createResponse' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return this.createresponse(dispatch_arg_0, dispatch_arg_1)
		}
		'createStream' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.createstream(dispatch_arg_0)
		}
		'createStreamFromFile' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return this.createstreamfromfile(dispatch_arg_0, dispatch_arg_1)
		}
		'createStreamFromResource' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.createstreamfromresource(dispatch_arg_0)
		}
		'createUploadedFile' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WordPress_AiClientDependencies_Psr_Http_Message_StreamInterface](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_WordPress_AiClientDependencies_Nyholm_Psr7_Factory_?int](if args.len > 1 { args[1] } else { rt.new_null() })
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_i64()
			mut dispatch_arg_3 := rt.cast_object_ptr[Class_WordPress_AiClientDependencies_Nyholm_Psr7_Factory_?string](if args.len > 3 { args[3] } else { rt.new_null() })
			mut dispatch_arg_4 := rt.cast_object_ptr[Class_WordPress_AiClientDependencies_Nyholm_Psr7_Factory_?string](if args.len > 4 { args[4] } else { rt.new_null() })
			return this.createuploadedfile(mut dispatch_arg_0, mut dispatch_arg_1, dispatch_arg_2, mut dispatch_arg_3, mut dispatch_arg_4)
		}
		'createUri' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.createuri(dispatch_arg_0)
		}
		'createServerRequest' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_WordPress_AiClientDependencies_Nyholm_Psr7_Factory_array](if args.len > 2 { args[2] } else { rt.new_null() })
			return this.createserverrequest(dispatch_arg_0, dispatch_arg_1, mut dispatch_arg_2)
		}
		else { return none }
	}
}

fn (this &Class_WordPress_AiClientDependencies_Nyholm_Psr7_Factory_Psr17Factory) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClientDependencies_Nyholm_Psr7_Factory_Psr17Factory) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_WordPress_AiClientDependencies_Nyholm_Psr7_Factory_RuntimeException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WordPress_AiClientDependencies_Nyholm_Psr7_Factory_RuntimeException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClientDependencies_Nyholm_Psr7_Factory_RuntimeException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WordPress_AiClientDependencies_Nyholm_Psr7_Factory_InvalidArgumentException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WordPress_AiClientDependencies_Nyholm_Psr7_Factory_InvalidArgumentException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClientDependencies_Nyholm_Psr7_Factory_InvalidArgumentException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WordPress_AiClientDependencies_Nyholm_Psr7_UploadedFile) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WordPress_AiClientDependencies_Nyholm_Psr7_UploadedFile) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClientDependencies_Nyholm_Psr7_UploadedFile) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_WordPress_AiClientDependencies_Nyholm_Psr7_ServerRequest) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WordPress_AiClientDependencies_Nyholm_Psr7_ServerRequest) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClientDependencies_Nyholm_Psr7_ServerRequest) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}



fn main() {
	defer {
		rt.shutdown()
	}

}
