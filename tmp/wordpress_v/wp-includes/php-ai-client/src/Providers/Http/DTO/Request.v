import rt

pub fn Class_WordPress_AiClient_Providers_Http_DTO_Request.key_method() string {
	return 'method'
}
pub fn Class_WordPress_AiClient_Providers_Http_DTO_Request.key_uri() string {
	return 'uri'
}
pub fn Class_WordPress_AiClient_Providers_Http_DTO_Request.key_headers() string {
	return 'headers'
}
pub fn Class_WordPress_AiClient_Providers_Http_DTO_Request.key_body() string {
	return 'body'
}
pub fn Class_WordPress_AiClient_Providers_Http_DTO_Request.key_options() string {
	return 'options'
}
struct Class_WordPress_AiClient_Providers_Http_DTO_Request {
	rt.PhpObjectBase
pub mut:
		method rt.PhpVal = rt.new_null()
		uri string
		headers rt.PhpVal = rt.new_null()
		data rt.PhpVal = rt.new_null()
		body rt.PhpVal = rt.new_null()
		options rt.PhpVal = rt.new_null()
}

fn (mut this Class_WordPress_AiClient_Providers_Http_DTO_Request) construct(mut var_method Class_WordPress_AiClient_Providers_Http_Enums_HttpMethodEnum, uri string, mut var_headers Class_WordPress_AiClient_Providers_Http_DTO_array, var_data rt.PhpVal, mut var_options Class_WordPress_AiClient_Providers_Http_DTO_?WordPress_AiClient_Providers_Http_DTO_RequestOptions)  {
	mut var_method_mutated := var_method
	mut uri_mutated := uri
	mut var_headers_mutated := var_headers
	if uri_mutated == '' {
		rt.throw_exception(rt.new_object('WordPress_AiClient_Common_Exception_InvalidArgumentException', []string{}, create_wordpress_aiclient_common_exception_invalidargumentexception(rt.new_string('URI cannot be empty.'))))
	}
	this.method = var_method_mutated.dup()
	this.uri = (rt.new_string(uri_mutated)).str()
	this.headers = create_wordpress_aiclient_providers_http_collections_headerscollection(var_headers_mutated.dup())
	if rt.is_true(rt.new_bool(var_data.dup().is_string())) {
		this.body = var_data.dup()
	} else if rt.is_true(rt.new_bool(var_data.dup().is_array())) {
		this.data = var_data.dup()
	}
	this.options = var_options.dup()
}

fn (mut this Class_WordPress_AiClient_Providers_Http_DTO_Request) magic_clone()  {
	this.headers = // unsupported expression: Expr_Clone
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		this.options = // unsupported expression: Expr_Clone
	}
	// unsupported statement: Stmt_Nop
}

fn (mut this Class_WordPress_AiClient_Providers_Http_DTO_Request) getmethod() rt.PhpVal {
	return this.method
}

fn (mut this Class_WordPress_AiClient_Providers_Http_DTO_Request) geturi() string {
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.identical(this.method, fn () rt.PhpVal { mut temp := Class_WordPress_AiClient_Providers_Http_Enums_HttpMethodEnum{}; return temp.get() }())) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) && !(!rt.is_true(this.data)))) {
		mut var_separator := rt.new_string(if rt.is_true(rt.call_function('str_contains', [this.uri, rt.new_string('?')])) { rt.new_string('&') } else { rt.new_string('?') })
		return this.uri + (var_separator).str() + (rt.call_function('http_build_query', [this.data])).str()
	}
	return this.uri
}

fn (mut this Class_WordPress_AiClient_Providers_Http_DTO_Request) getheaders() rt.PhpVal {
	return rt.call_method(this.headers, 'getAll', []rt.PhpVal{})
}

fn (mut this Class_WordPress_AiClient_Providers_Http_DTO_Request) getheader(name string) rt.PhpVal {
	return rt.call_method(this.headers, 'get', [rt.new_string(name)])
}

fn (mut this Class_WordPress_AiClient_Providers_Http_DTO_Request) getheaderasstring(name string) string {
	return (rt.call_method(this.headers, 'getAsString', [rt.new_string(name)])).str()
}

fn (mut this Class_WordPress_AiClient_Providers_Http_DTO_Request) hasheader(name string) bool {
	return (rt.call_method(this.headers, 'has', [rt.new_string(name)])).to_bool()
}

fn (mut this Class_WordPress_AiClient_Providers_Http_DTO_Request) getbody() string {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(this.method, 'hasBody', []rt.PhpVal{}))))) {
		return (rt.new_null()).str()
	}
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return (this.body).str()
	}
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		mut var_contentType := rt.new_string(this.getcontenttype())
		if rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
			return rt.json_encode(this.data)
		}
		return (rt.call_function('http_build_query', [this.data])).str()
	}
	return (rt.new_null()).str()
}

fn (mut this Class_WordPress_AiClient_Providers_Http_DTO_Request) getcontenttype() string {
	mut var_values := this.getheader('Content-Type')
	return (if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) { var_values.array_get(0) } else { rt.new_null() }).str()
}

fn (mut this Class_WordPress_AiClient_Providers_Http_DTO_Request) withheader(name string, var_value rt.PhpVal) rt.PhpVal {
	mut var_newHeaders := rt.call_method(this.headers, 'withHeader', [rt.new_string(name), var_value.dup()])
	mut var_new := // unsupported expression: Expr_Clone
	rt.set_property(var_new, 'headers', var_newHeaders.dup())
	return var_new.dup()
}

fn (mut this Class_WordPress_AiClient_Providers_Http_DTO_Request) withdata(var_data rt.PhpVal) rt.PhpVal {
	mut var_new := // unsupported expression: Expr_Clone
	if rt.is_true(rt.new_bool(var_data.dup().is_string())) {
		rt.set_property(var_new, 'body', var_data.dup())
		rt.set_property(var_new, 'data', rt.new_null())
	} else if rt.is_true(rt.new_bool(var_data.dup().is_array())) {
		rt.set_property(var_new, 'data', var_data.dup())
		rt.set_property(var_new, 'body', rt.new_null())
	} else {
		rt.set_property(var_new, 'data', rt.new_null())
		rt.set_property(var_new, 'body', rt.new_null())
	}
	return var_new.dup()
}

fn (mut this Class_WordPress_AiClient_Providers_Http_DTO_Request) getdata() rt.PhpVal {
	return this.data
}

fn (mut this Class_WordPress_AiClient_Providers_Http_DTO_Request) getoptions() rt.PhpVal {
	return this.options
}

fn (mut this Class_WordPress_AiClient_Providers_Http_DTO_Request) withoptions(mut var_options Class_WordPress_AiClient_Providers_Http_DTO_?WordPress_AiClient_Providers_Http_DTO_RequestOptions) rt.PhpVal {
	mut var_new := // unsupported expression: Expr_Clone
	rt.set_property(var_new, 'options', var_options.dup())
	return var_new.dup()
}

fn Class_WordPress_AiClient_Providers_Http_DTO_Request.getjsonschema() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: Class_WordPress_AiClient_Providers_Http_DTO_WordPress_AiClient_Providers_Http_DTO_Request.key_method(), val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'description', val: 'The HTTP method.' }]) }, rt.ArrayItem{ key: Class_WordPress_AiClient_Providers_Http_DTO_WordPress_AiClient_Providers_Http_DTO_Request.key_uri(), val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'description', val: 'The request URI.' }]) }, rt.ArrayItem{ key: Class_WordPress_AiClient_Providers_Http_DTO_WordPress_AiClient_Providers_Http_DTO_Request.key_headers(), val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'additionalProperties', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'array' }, rt.ArrayItem{ key: 'items', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }]) }]) }, rt.ArrayItem{ key: 'description', val: 'The request headers.' }]) }, rt.ArrayItem{ key: Class_WordPress_AiClient_Providers_Http_DTO_WordPress_AiClient_Providers_Http_DTO_Request.key_body(), val: rt.create_array([rt.ArrayItem{ key: 'type', val: rt.create_array([rt.ArrayItem{ key: none, val: 'string' }]) }, rt.ArrayItem{ key: 'description', val: 'The request body.' }]) }, rt.ArrayItem{ key: Class_WordPress_AiClient_Providers_Http_DTO_WordPress_AiClient_Providers_Http_DTO_Request.key_options(), val: fn () rt.PhpVal { mut temp := Class_WordPress_AiClient_Providers_Http_DTO_WordPress_AiClient_Providers_Http_DTO_RequestOptions{}; return temp.getjsonschema() }() }]) }, rt.ArrayItem{ key: 'required', val: rt.create_array([rt.ArrayItem{ key: none, val: Class_WordPress_AiClient_Providers_Http_DTO_WordPress_AiClient_Providers_Http_DTO_Request.key_method() }, rt.ArrayItem{ key: none, val: Class_WordPress_AiClient_Providers_Http_DTO_WordPress_AiClient_Providers_Http_DTO_Request.key_uri() }, rt.ArrayItem{ key: none, val: Class_WordPress_AiClient_Providers_Http_DTO_WordPress_AiClient_Providers_Http_DTO_Request.key_headers() }]) }])
}

fn (mut this Class_WordPress_AiClient_Providers_Http_DTO_Request) toarray() rt.PhpVal {
	mut var_array := rt.create_array([rt.ArrayItem{ key: Class_WordPress_AiClient_Providers_Http_DTO_WordPress_AiClient_Providers_Http_DTO_Request.key_method(), val: rt.get_property(this.method, 'value') }, rt.ArrayItem{ key: Class_WordPress_AiClient_Providers_Http_DTO_WordPress_AiClient_Providers_Http_DTO_Request.key_uri(), val: this.geturi() }, rt.ArrayItem{ key: Class_WordPress_AiClient_Providers_Http_DTO_WordPress_AiClient_Providers_Http_DTO_Request.key_headers(), val: rt.call_method(this.headers, 'getAll', []rt.PhpVal{}) }])
	mut var_body := rt.new_string(this.getbody())
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		var_array.array_set(Class_WordPress_AiClient_Providers_Http_DTO_WordPress_AiClient_Providers_Http_DTO_Request.key_body(), var_body.dup())
	}
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		mut var_optionsArray := rt.call_method(this.options, 'toArray', []rt.PhpVal{})
		if !(!rt.is_true(var_optionsArray)) {
			var_array.array_set(Class_WordPress_AiClient_Providers_Http_DTO_WordPress_AiClient_Providers_Http_DTO_Request.key_options(), var_optionsArray.dup())
		}
	}
	return var_array.dup()
}

fn Class_WordPress_AiClient_Providers_Http_DTO_Request.fromarray(mut var_array Class_WordPress_AiClient_Providers_Http_DTO_array) rt.PhpVal {
	mut var_array_mutated := var_array
	fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_WordPress_AiClient_Providers_Http_DTO_Request{}; return temp.validatefromarraydata(arg_0, arg_1) }(rt.new_object('WordPress_AiClient_Providers_Http_DTO_array', []string{}, var_array_mutated), rt.create_array([rt.ArrayItem{ key: none, val: Class_WordPress_AiClient_Providers_Http_DTO_WordPress_AiClient_Providers_Http_DTO_Request.key_method() }, rt.ArrayItem{ key: none, val: Class_WordPress_AiClient_Providers_Http_DTO_WordPress_AiClient_Providers_Http_DTO_Request.key_uri() }, rt.ArrayItem{ key: none, val: Class_WordPress_AiClient_Providers_Http_DTO_WordPress_AiClient_Providers_Http_DTO_Request.key_headers() }]))
	return create_wordpress_aiclient_providers_http_dto_self(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WordPress_AiClient_Providers_Http_Enums_HttpMethodEnum{}; return temp.from(arg_0) }(var_array_mutated.array_get(Class_WordPress_AiClient_Providers_Http_DTO_WordPress_AiClient_Providers_Http_DTO_Request.key_method())), var_array_mutated.array_get(Class_WordPress_AiClient_Providers_Http_DTO_WordPress_AiClient_Providers_Http_DTO_Request.key_uri()), if !(var_array_mutated.array_get(Class_WordPress_AiClient_Providers_Http_DTO_WordPress_AiClient_Providers_Http_DTO_Request.key_headers())).is_null() { var_array_mutated.array_get(Class_WordPress_AiClient_Providers_Http_DTO_WordPress_AiClient_Providers_Http_DTO_Request.key_headers()) } else { rt.new_array() }, if !(var_array_mutated.array_get(Class_WordPress_AiClient_Providers_Http_DTO_WordPress_AiClient_Providers_Http_DTO_Request.key_body())).is_null() { var_array_mutated.array_get(Class_WordPress_AiClient_Providers_Http_DTO_WordPress_AiClient_Providers_Http_DTO_Request.key_body()) } else { rt.new_null() }, if var_array_mutated.array_isset(Class_WordPress_AiClient_Providers_Http_DTO_WordPress_AiClient_Providers_Http_DTO_Request.key_options()) { fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WordPress_AiClient_Providers_Http_DTO_WordPress_AiClient_Providers_Http_DTO_RequestOptions{}; return temp.fromarray(arg_0) }(var_array_mutated.array_get(Class_WordPress_AiClient_Providers_Http_DTO_WordPress_AiClient_Providers_Http_DTO_Request.key_options())) } else { rt.new_null() })
}

fn Class_WordPress_AiClient_Providers_Http_DTO_Request.frompsrrequest(mut var_psrRequest Class_WordPress_AiClientDependencies_Psr_Http_Message_RequestInterface) rt.PhpVal {
	mut var_method := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WordPress_AiClient_Providers_Http_Enums_HttpMethodEnum{}; return temp.from(arg_0) }(var_psrRequest.getmethod())
	mut var_uri := // unsupported expression: Expr_Cast_String
	mut var_headers := var_psrRequest.getheaders()
	mut var_body := rt.call_method(var_psrRequest.getbody(), 'getContents', []rt.PhpVal{})
	mut var_bodyOrData := if !(!rt.is_true(var_body)) { var_body } else { rt.new_null() }
	return create_wordpress_aiclient_providers_http_dto_self(var_method.dup(), var_uri.dup(), var_headers.dup(), var_bodyOrData.dup())
}

struct Class_WordPress_AiClient_Common_AbstractDataTransferObject {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClient_Common_Exception_InvalidArgumentException {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClient_Providers_Http_Collections_HeadersCollection {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClient_Providers_Http_Enums_HttpMethodEnum {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClient_Providers_Http_DTO_WordPress_AiClient_Providers_Http_DTO_RequestOptions {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClient_Providers_Http_DTO_self {
	rt.PhpObjectBase
}

fn create_wordpress_aiclient_providers_http_dto_request(arg_0 rt.PhpVal, uri string, arg_2 rt.PhpVal, arg_3 rt.PhpVal, arg_4 rt.PhpVal) &Class_WordPress_AiClient_Providers_Http_DTO_Request {
	mut obj := &Class_WordPress_AiClient_Providers_Http_DTO_Request{
		PhpObjectBase: rt.PhpObjectBase{}
		method: rt.new_null()
		uri: ''
		headers: rt.new_null()
		data: rt.new_null()
		body: rt.new_null()
		options: rt.new_null()
	}
	obj.construct(arg_0, uri, arg_2, arg_3, arg_4)
	return obj
}

fn create_wordpress_aiclient_common_abstractdatatransferobject() &Class_WordPress_AiClient_Common_AbstractDataTransferObject {
	mut obj := &Class_WordPress_AiClient_Common_AbstractDataTransferObject{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wordpress_aiclient_common_exception_invalidargumentexception() &Class_WordPress_AiClient_Common_Exception_InvalidArgumentException {
	mut obj := &Class_WordPress_AiClient_Common_Exception_InvalidArgumentException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wordpress_aiclient_providers_http_collections_headerscollection() &Class_WordPress_AiClient_Providers_Http_Collections_HeadersCollection {
	mut obj := &Class_WordPress_AiClient_Providers_Http_Collections_HeadersCollection{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wordpress_aiclient_providers_http_enums_httpmethodenum() &Class_WordPress_AiClient_Providers_Http_Enums_HttpMethodEnum {
	mut obj := &Class_WordPress_AiClient_Providers_Http_Enums_HttpMethodEnum{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wordpress_aiclient_providers_http_dto_wordpress_aiclient_providers_http_dto_requestoptions() &Class_WordPress_AiClient_Providers_Http_DTO_WordPress_AiClient_Providers_Http_DTO_RequestOptions {
	mut obj := &Class_WordPress_AiClient_Providers_Http_DTO_WordPress_AiClient_Providers_Http_DTO_RequestOptions{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wordpress_aiclient_providers_http_dto_self() &Class_WordPress_AiClient_Providers_Http_DTO_self {
	mut obj := &Class_WordPress_AiClient_Providers_Http_DTO_self{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WordPress_AiClient_Providers_Http_DTO_Request) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WordPress_AiClient_Providers_Http_Enums_HttpMethodEnum](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_WordPress_AiClient_Providers_Http_DTO_array](if args.len > 2 { args[2] } else { rt.new_null() })
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			mut dispatch_arg_4 := rt.cast_object_ptr[Class_WordPress_AiClient_Providers_Http_DTO_?WordPress_AiClient_Providers_Http_DTO_RequestOptions](if args.len > 4 { args[4] } else { rt.new_null() })
			this.construct(mut dispatch_arg_0, dispatch_arg_1, mut dispatch_arg_2, dispatch_arg_3, mut dispatch_arg_4)
			return rt.new_null()
		}
		'__clone' {
			this.magic_clone()
			return rt.new_null()
		}
		'getMethod' {
			return this.getmethod()
		}
		'getUri' {
			return rt.new_string(this.geturi())
		}
		'getHeaders' {
			return this.getheaders()
		}
		'getHeader' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.getheader(dispatch_arg_0)
		}
		'getHeaderAsString' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(this.getheaderasstring(dispatch_arg_0))
		}
		'hasHeader' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(this.hasheader(dispatch_arg_0))
		}
		'getBody' {
			return rt.new_string(this.getbody())
		}
		'getContentType' {
			return rt.new_string(this.getcontenttype())
		}
		'withHeader' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.withheader(dispatch_arg_0, dispatch_arg_1)
		}
		'withData' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.withdata(dispatch_arg_0)
		}
		'getData' {
			return this.getdata()
		}
		'getOptions' {
			return this.getoptions()
		}
		'withOptions' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WordPress_AiClient_Providers_Http_DTO_?WordPress_AiClient_Providers_Http_DTO_RequestOptions](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.withoptions(mut dispatch_arg_0)
		}
		'getJsonSchema' {
			return Class_WordPress_AiClient_Providers_Http_DTO_Request.getjsonschema()
		}
		'toArray' {
			return this.toarray()
		}
		'fromArray' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WordPress_AiClient_Providers_Http_DTO_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return Class_WordPress_AiClient_Providers_Http_DTO_Request.fromarray(mut dispatch_arg_0)
		}
		'fromPsrRequest' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WordPress_AiClientDependencies_Psr_Http_Message_RequestInterface](if args.len > 0 { args[0] } else { rt.new_null() })
			return Class_WordPress_AiClient_Providers_Http_DTO_Request.frompsrrequest(mut dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_WordPress_AiClient_Providers_Http_DTO_Request) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'method' { return this.method }
		'uri' { return rt.new_string(this.uri) }
		'headers' { return this.headers }
		'data' { return this.data }
		'body' { return this.body }
		'options' { return this.options }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WordPress_AiClient_Providers_Http_DTO_Request) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'method' { this.method = val; return true }
		'uri' { this.uri = (val).str(); return true }
		'headers' { this.headers = val; return true }
		'data' { this.data = val; return true }
		'body' { this.body = val; return true }
		'options' { this.options = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_WordPress_AiClient_Common_AbstractDataTransferObject) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WordPress_AiClient_Common_AbstractDataTransferObject) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClient_Common_AbstractDataTransferObject) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
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


fn (mut this Class_WordPress_AiClient_Providers_Http_Collections_HeadersCollection) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WordPress_AiClient_Providers_Http_Collections_HeadersCollection) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClient_Providers_Http_Collections_HeadersCollection) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WordPress_AiClient_Providers_Http_Enums_HttpMethodEnum) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WordPress_AiClient_Providers_Http_Enums_HttpMethodEnum) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClient_Providers_Http_Enums_HttpMethodEnum) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WordPress_AiClient_Providers_Http_DTO_WordPress_AiClient_Providers_Http_DTO_RequestOptions) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WordPress_AiClient_Providers_Http_DTO_WordPress_AiClient_Providers_Http_DTO_RequestOptions) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClient_Providers_Http_DTO_WordPress_AiClient_Providers_Http_DTO_RequestOptions) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WordPress_AiClient_Providers_Http_DTO_self) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WordPress_AiClient_Providers_Http_DTO_self) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClient_Providers_Http_DTO_self) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_includes_php_ai_client_src_providers_http_dto_request_php() {
	// unsupported statement: Stmt_Declare
}
