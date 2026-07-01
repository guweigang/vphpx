import rt

struct Class_WordPress_AiClientDependencies_Nyholm_Psr7_ServerRequest {
	rt.PhpObjectBase
pub mut:
		attributes rt.PhpVal = rt.new_array()
		cookieParams rt.PhpVal = rt.new_array()
		parsedBody rt.PhpVal = rt.new_null()
		queryParams rt.PhpVal = rt.new_array()
		serverParams rt.PhpVal = rt.new_null()
		uploadedFiles rt.PhpVal = rt.new_array()
}

fn (mut this Class_WordPress_AiClientDependencies_Nyholm_Psr7_ServerRequest) construct(method string, var_uri rt.PhpVal, mut var_headers Class_WordPress_AiClientDependencies_Nyholm_Psr7_array, var_body rt.PhpVal, version string, mut var_serverParams Class_WordPress_AiClientDependencies_Nyholm_Psr7_array)  {
	mut var_uri_mutated := var_uri
	this.serverParams = var_serverParams.dup()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(rt.new_object('WordPress_AiClientDependencies_Nyholm_Psr7_Uri', []string{}, var_uri_mutated), 'WordPress_AiClientDependencies_Psr_Http_Message_UriInterface')))))) {
		var_uri_mutated = create_wordpress_aiclientdependencies_nyholm_psr7_uri(var_uri_mutated.dup())
	}
	this.dispatch_set_prop('method', rt.new_string(method))
	this.dispatch_set_prop('uri', var_uri_mutated.dup())
	this.setheaders(rt.new_object('WordPress_AiClientDependencies_Nyholm_Psr7_array', []string{}, var_headers))
	this.dispatch_set_prop('protocol', rt.new_string(version))
	rt.call_function('parse_str', [var_uri_mutated.getquery(), this.queryParams])
	if rt.is_true(rt.new_bool(!(rt.is_true(this.hasheader(rt.new_string('Host')))))) {
		this.updatehostfromuri()
	}
	if rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		this.dispatch_set_prop('stream', fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WordPress_AiClientDependencies_Nyholm_Psr7_Stream{}; return temp.create(arg_0) }(var_body.dup()))
	}
}

fn (mut this Class_WordPress_AiClientDependencies_Nyholm_Psr7_ServerRequest) getserverparams() rt.PhpVal {
	return this.serverParams
}

fn (mut this Class_WordPress_AiClientDependencies_Nyholm_Psr7_ServerRequest) getuploadedfiles() rt.PhpVal {
	return this.uploadedFiles
}

fn (mut this Class_WordPress_AiClientDependencies_Nyholm_Psr7_ServerRequest) withuploadedfiles(mut var_uploadedFiles Class_WordPress_AiClientDependencies_Nyholm_Psr7_array) rt.PhpVal {
	mut var_new := // unsupported expression: Expr_Clone
	rt.set_property(var_new, 'uploadedFiles', var_uploadedFiles.dup())
	return var_new.dup()
}

fn (mut this Class_WordPress_AiClientDependencies_Nyholm_Psr7_ServerRequest) getcookieparams() rt.PhpVal {
	return this.cookieParams
}

fn (mut this Class_WordPress_AiClientDependencies_Nyholm_Psr7_ServerRequest) withcookieparams(mut var_cookies Class_WordPress_AiClientDependencies_Nyholm_Psr7_array) rt.PhpVal {
	mut var_new := // unsupported expression: Expr_Clone
	rt.set_property(var_new, 'cookieParams', var_cookies.dup())
	return var_new.dup()
}

fn (mut this Class_WordPress_AiClientDependencies_Nyholm_Psr7_ServerRequest) getqueryparams() rt.PhpVal {
	return this.queryParams
}

fn (mut this Class_WordPress_AiClientDependencies_Nyholm_Psr7_ServerRequest) withqueryparams(mut var_query Class_WordPress_AiClientDependencies_Nyholm_Psr7_array) rt.PhpVal {
	mut var_new := // unsupported expression: Expr_Clone
	rt.set_property(var_new, 'queryParams', var_query.dup())
	return var_new.dup()
}

fn (mut this Class_WordPress_AiClientDependencies_Nyholm_Psr7_ServerRequest) getparsedbody() rt.PhpVal {
	return this.parsedBody
}

fn (mut this Class_WordPress_AiClientDependencies_Nyholm_Psr7_ServerRequest) withparsedbody(var_data rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_data.dup().is_array()))))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_data.dup().is_object()))))))) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		rt.throw_exception(rt.new_object('WordPress_AiClientDependencies_Nyholm_Psr7_InvalidArgumentException', []string{}, create_wordpress_aiclientdependencies_nyholm_psr7_invalidargumentexception(rt.new_string('First parameter to withParsedBody MUST be object, array or null'))))
	}
	mut var_new := // unsupported expression: Expr_Clone
	rt.set_property(var_new, 'parsedBody', var_data.dup())
	return var_new.dup()
}

fn (mut this Class_WordPress_AiClientDependencies_Nyholm_Psr7_ServerRequest) getattributes() rt.PhpVal {
	return this.attributes
}

fn (mut this Class_WordPress_AiClientDependencies_Nyholm_Psr7_ServerRequest) getattribute(var_attribute rt.PhpVal, var_default rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_attribute.dup().is_string()))))) {
		rt.throw_exception(rt.new_object('WordPress_AiClientDependencies_Nyholm_Psr7_InvalidArgumentException', []string{}, create_wordpress_aiclientdependencies_nyholm_psr7_invalidargumentexception(rt.new_string('Attribute name must be a string'))))
	}
	if rt.is_true(rt.identical(rt.new_bool(false), rt.new_bool(this.attributes.array_isset(var_attribute.dup())))) {
		return var_default.dup()
	}
	return this.attributes.array_get(var_attribute)
}

fn (mut this Class_WordPress_AiClientDependencies_Nyholm_Psr7_ServerRequest) withattribute(var_attribute rt.PhpVal, var_value rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_attribute.dup().is_string()))))) {
		rt.throw_exception(rt.new_object('WordPress_AiClientDependencies_Nyholm_Psr7_InvalidArgumentException', []string{}, create_wordpress_aiclientdependencies_nyholm_psr7_invalidargumentexception(rt.new_string('Attribute name must be a string'))))
	}
	mut var_new := // unsupported expression: Expr_Clone
	rt.get_property(var_new, 'attributes').array_set(var_attribute, var_value.dup())
	return var_new.dup()
}

fn (mut this Class_WordPress_AiClientDependencies_Nyholm_Psr7_ServerRequest) withoutattribute(var_attribute rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_attribute.dup().is_string()))))) {
		rt.throw_exception(rt.new_object('WordPress_AiClientDependencies_Nyholm_Psr7_InvalidArgumentException', []string{}, create_wordpress_aiclientdependencies_nyholm_psr7_invalidargumentexception(rt.new_string('Attribute name must be a string'))))
	}
	if rt.is_true(rt.identical(rt.new_bool(false), rt.new_bool(this.attributes.array_isset(var_attribute.dup())))) {
		return rt.new_object('WordPress_AiClientDependencies_Nyholm_Psr7_ServerRequest', []string{}, this)
	}
	mut var_new := // unsupported expression: Expr_Clone
	rt.get_property(var_new, 'attributes').array_unset(var_attribute)
	return var_new.dup()
}

struct Class_WordPress_AiClientDependencies_Nyholm_Psr7_Uri {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClientDependencies_Nyholm_Psr7_Stream {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClientDependencies_Nyholm_Psr7_InvalidArgumentException {
	rt.PhpObjectBase
}

fn create_wordpress_aiclientdependencies_nyholm_psr7_serverrequest(method string, arg_1 rt.PhpVal, arg_2 rt.PhpVal, version string, arg_4 rt.PhpVal, arg_5 rt.PhpVal) &Class_WordPress_AiClientDependencies_Nyholm_Psr7_ServerRequest {
	mut obj := &Class_WordPress_AiClientDependencies_Nyholm_Psr7_ServerRequest{
		PhpObjectBase: rt.PhpObjectBase{}
		attributes: rt.new_array()
		cookieParams: rt.new_array()
		parsedBody: rt.new_null()
		queryParams: rt.new_array()
		serverParams: rt.new_null()
		uploadedFiles: rt.new_array()
	}
	obj.construct(method, arg_1, arg_2, version, arg_4, arg_5)
	return obj
}

fn create_wordpress_aiclientdependencies_nyholm_psr7_uri() &Class_WordPress_AiClientDependencies_Nyholm_Psr7_Uri {
	mut obj := &Class_WordPress_AiClientDependencies_Nyholm_Psr7_Uri{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wordpress_aiclientdependencies_nyholm_psr7_stream() &Class_WordPress_AiClientDependencies_Nyholm_Psr7_Stream {
	mut obj := &Class_WordPress_AiClientDependencies_Nyholm_Psr7_Stream{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wordpress_aiclientdependencies_nyholm_psr7_invalidargumentexception() &Class_WordPress_AiClientDependencies_Nyholm_Psr7_InvalidArgumentException {
	mut obj := &Class_WordPress_AiClientDependencies_Nyholm_Psr7_InvalidArgumentException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WordPress_AiClientDependencies_Nyholm_Psr7_ServerRequest) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_WordPress_AiClientDependencies_Nyholm_Psr7_array](if args.len > 2 { args[2] } else { rt.new_null() })
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			dispatch_arg_4 := (if args.len > 4 { args[4] } else { rt.new_null() }).str()
			mut dispatch_arg_5 := rt.cast_object_ptr[Class_WordPress_AiClientDependencies_Nyholm_Psr7_array](if args.len > 5 { args[5] } else { rt.new_null() })
			this.construct(dispatch_arg_0, dispatch_arg_1, mut dispatch_arg_2, dispatch_arg_3, dispatch_arg_4, mut dispatch_arg_5)
			return rt.new_null()
		}
		'getServerParams' {
			return this.getserverparams()
		}
		'getUploadedFiles' {
			return this.getuploadedfiles()
		}
		'withUploadedFiles' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WordPress_AiClientDependencies_Nyholm_Psr7_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.withuploadedfiles(mut dispatch_arg_0)
		}
		'getCookieParams' {
			return this.getcookieparams()
		}
		'withCookieParams' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WordPress_AiClientDependencies_Nyholm_Psr7_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.withcookieparams(mut dispatch_arg_0)
		}
		'getQueryParams' {
			return this.getqueryparams()
		}
		'withQueryParams' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WordPress_AiClientDependencies_Nyholm_Psr7_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.withqueryparams(mut dispatch_arg_0)
		}
		'getParsedBody' {
			return this.getparsedbody()
		}
		'withParsedBody' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.withparsedbody(dispatch_arg_0)
		}
		'getAttributes' {
			return this.getattributes()
		}
		'getAttribute' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.getattribute(dispatch_arg_0, dispatch_arg_1)
		}
		'withAttribute' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.withattribute(dispatch_arg_0, dispatch_arg_1)
		}
		'withoutAttribute' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.withoutattribute(dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_WordPress_AiClientDependencies_Nyholm_Psr7_ServerRequest) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'attributes' { return this.attributes }
		'cookieParams' { return this.cookieParams }
		'parsedBody' { return this.parsedBody }
		'queryParams' { return this.queryParams }
		'serverParams' { return this.serverParams }
		'uploadedFiles' { return this.uploadedFiles }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WordPress_AiClientDependencies_Nyholm_Psr7_ServerRequest) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'attributes' { this.attributes = val; return true }
		'cookieParams' { this.cookieParams = val; return true }
		'parsedBody' { this.parsedBody = val; return true }
		'queryParams' { this.queryParams = val; return true }
		'serverParams' { this.serverParams = val; return true }
		'uploadedFiles' { this.uploadedFiles = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
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


fn (mut this Class_WordPress_AiClientDependencies_Nyholm_Psr7_Stream) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WordPress_AiClientDependencies_Nyholm_Psr7_Stream) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClientDependencies_Nyholm_Psr7_Stream) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WordPress_AiClientDependencies_Nyholm_Psr7_InvalidArgumentException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WordPress_AiClientDependencies_Nyholm_Psr7_InvalidArgumentException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClientDependencies_Nyholm_Psr7_InvalidArgumentException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_includes_php_ai_client_third_party_nyholm_psr7_serverrequest_php() {
	// unsupported statement: Stmt_Declare
}
