import rt

pub fn Class_WordPress_AiClient_Providers_Http_DTO_Response.key_status_code() string {
	return 'statusCode'
}
pub fn Class_WordPress_AiClient_Providers_Http_DTO_Response.key_headers() string {
	return 'headers'
}
pub fn Class_WordPress_AiClient_Providers_Http_DTO_Response.key_body() string {
	return 'body'
}
struct Class_WordPress_AiClient_Providers_Http_DTO_Response {
	rt.PhpObjectBase
pub mut:
		statusCode i64
		headers rt.PhpVal = rt.new_null()
		body rt.PhpVal = rt.new_null()
}

fn (mut this Class_WordPress_AiClient_Providers_Http_DTO_Response) construct(statusCode i64, mut var_headers Class_WordPress_AiClient_Providers_Http_DTO_array, mut var_body Class_WordPress_AiClient_Providers_Http_DTO_?string)  {
	if statusCode < 100 || statusCode >= 600 {
		rt.throw_exception(rt.new_object('WordPress_AiClient_Common_Exception_InvalidArgumentException', []string{}, create_wordpress_aiclient_common_exception_invalidargumentexception('Invalid HTTP status code: ' + statusCode.str())))
	}
	this.statusCode = statusCode
	this.headers = create_wordpress_aiclient_providers_http_collections_headerscollection(var_headers.dup())
	this.body = var_body.dup()
}

fn (mut this Class_WordPress_AiClient_Providers_Http_DTO_Response) magic_clone()  {
	this.headers = // unsupported expression: Expr_Clone
}

fn (mut this Class_WordPress_AiClient_Providers_Http_DTO_Response) getstatuscode() i64 {
	return this.statusCode
}

fn (mut this Class_WordPress_AiClient_Providers_Http_DTO_Response) getheaders() rt.PhpVal {
	return rt.call_method(this.headers, 'getAll', []rt.PhpVal{})
}

fn (mut this Class_WordPress_AiClient_Providers_Http_DTO_Response) getheader(name string) rt.PhpVal {
	return rt.call_method(this.headers, 'get', [rt.new_string(name)])
}

fn (mut this Class_WordPress_AiClient_Providers_Http_DTO_Response) getheaderasstring(name string) string {
	return (rt.call_method(this.headers, 'getAsString', [rt.new_string(name)])).str()
}

fn (mut this Class_WordPress_AiClient_Providers_Http_DTO_Response) getbody() string {
	return (this.body).str()
}

fn (mut this Class_WordPress_AiClient_Providers_Http_DTO_Response) hasheader(name string) bool {
	return (rt.call_method(this.headers, 'has', [rt.new_string(name)])).to_bool()
}

fn (mut this Class_WordPress_AiClient_Providers_Http_DTO_Response) issuccessful() bool {
	return this.statusCode >= 200 && this.statusCode < 300
}

fn (mut this Class_WordPress_AiClient_Providers_Http_DTO_Response) getdata() rt.PhpVal {
	if rt.is_true(rt.new_bool(rt.is_true(rt.identical(this.body, rt.new_null())) || rt.is_true(rt.identical(this.body, rt.new_string(''))))) {
		return rt.new_null()
	}
	mut var_data := rt.call_function('json_decode', [this.body, rt.new_bool(true)])
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return rt.new_null()
	}
	return if rt.is_true(rt.new_bool(var_data.dup().is_array())) { var_data } else { rt.new_null() }
}

fn Class_WordPress_AiClient_Providers_Http_DTO_Response.getjsonschema() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: Class_WordPress_AiClient_Providers_Http_DTO_WordPress_AiClient_Providers_Http_DTO_Response.key_status_code(), val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'integer' }, rt.ArrayItem{ key: 'minimum', val: 100 }, rt.ArrayItem{ key: 'maximum', val: 599 }, rt.ArrayItem{ key: 'description', val: 'The HTTP status code.' }]) }, rt.ArrayItem{ key: Class_WordPress_AiClient_Providers_Http_DTO_WordPress_AiClient_Providers_Http_DTO_Response.key_headers(), val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'additionalProperties', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'array' }, rt.ArrayItem{ key: 'items', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }]) }]) }, rt.ArrayItem{ key: 'description', val: 'The response headers.' }]) }, rt.ArrayItem{ key: Class_WordPress_AiClient_Providers_Http_DTO_WordPress_AiClient_Providers_Http_DTO_Response.key_body(), val: rt.create_array([rt.ArrayItem{ key: 'type', val: rt.create_array([rt.ArrayItem{ key: none, val: 'string' }, rt.ArrayItem{ key: none, val: 'null' }]) }, rt.ArrayItem{ key: 'description', val: 'The response body.' }]) }]) }, rt.ArrayItem{ key: 'required', val: rt.create_array([rt.ArrayItem{ key: none, val: Class_WordPress_AiClient_Providers_Http_DTO_WordPress_AiClient_Providers_Http_DTO_Response.key_status_code() }, rt.ArrayItem{ key: none, val: Class_WordPress_AiClient_Providers_Http_DTO_WordPress_AiClient_Providers_Http_DTO_Response.key_headers() }]) }])
}

fn (mut this Class_WordPress_AiClient_Providers_Http_DTO_Response) toarray() rt.PhpVal {
	mut var_data := rt.create_array([rt.ArrayItem{ key: Class_WordPress_AiClient_Providers_Http_DTO_WordPress_AiClient_Providers_Http_DTO_Response.key_status_code(), val: this.statusCode }, rt.ArrayItem{ key: Class_WordPress_AiClient_Providers_Http_DTO_WordPress_AiClient_Providers_Http_DTO_Response.key_headers(), val: rt.call_method(this.headers, 'getAll', []rt.PhpVal{}) }])
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		var_data.array_set(Class_WordPress_AiClient_Providers_Http_DTO_WordPress_AiClient_Providers_Http_DTO_Response.key_body(), this.body)
	}
	return var_data.dup()
}

fn Class_WordPress_AiClient_Providers_Http_DTO_Response.fromarray(mut var_array Class_WordPress_AiClient_Providers_Http_DTO_array) rt.PhpVal {
	fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_WordPress_AiClient_Providers_Http_DTO_Response{}; return temp.validatefromarraydata(arg_0, arg_1) }(rt.new_object('WordPress_AiClient_Providers_Http_DTO_array', []string{}, var_array), rt.create_array([rt.ArrayItem{ key: none, val: Class_WordPress_AiClient_Providers_Http_DTO_WordPress_AiClient_Providers_Http_DTO_Response.key_status_code() }, rt.ArrayItem{ key: none, val: Class_WordPress_AiClient_Providers_Http_DTO_WordPress_AiClient_Providers_Http_DTO_Response.key_headers() }]))
	return create_wordpress_aiclient_providers_http_dto_self(var_array.array_get(Class_WordPress_AiClient_Providers_Http_DTO_WordPress_AiClient_Providers_Http_DTO_Response.key_status_code()), var_array.array_get(Class_WordPress_AiClient_Providers_Http_DTO_WordPress_AiClient_Providers_Http_DTO_Response.key_headers()), if !(var_array.array_get(Class_WordPress_AiClient_Providers_Http_DTO_WordPress_AiClient_Providers_Http_DTO_Response.key_body())).is_null() { var_array.array_get(Class_WordPress_AiClient_Providers_Http_DTO_WordPress_AiClient_Providers_Http_DTO_Response.key_body()) } else { rt.new_null() })
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

struct Class_WordPress_AiClient_Providers_Http_DTO_self {
	rt.PhpObjectBase
}

fn create_wordpress_aiclient_providers_http_dto_response(statusCode i64, arg_1 rt.PhpVal, arg_2 rt.PhpVal) &Class_WordPress_AiClient_Providers_Http_DTO_Response {
	mut obj := &Class_WordPress_AiClient_Providers_Http_DTO_Response{
		PhpObjectBase: rt.PhpObjectBase{}
		statusCode: i64(0)
		headers: rt.new_null()
		body: rt.new_null()
	}
	obj.construct(statusCode, arg_1, arg_2)
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

fn create_wordpress_aiclient_providers_http_dto_self() &Class_WordPress_AiClient_Providers_Http_DTO_self {
	mut obj := &Class_WordPress_AiClient_Providers_Http_DTO_self{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WordPress_AiClient_Providers_Http_DTO_Response) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_WordPress_AiClient_Providers_Http_DTO_array](if args.len > 1 { args[1] } else { rt.new_null() })
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_WordPress_AiClient_Providers_Http_DTO_?string](if args.len > 2 { args[2] } else { rt.new_null() })
			this.construct(dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2)
			return rt.new_null()
		}
		'__clone' {
			this.magic_clone()
			return rt.new_null()
		}
		'getStatusCode' {
			return rt.new_int(this.getstatuscode())
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
		'getBody' {
			return rt.new_string(this.getbody())
		}
		'hasHeader' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(this.hasheader(dispatch_arg_0))
		}
		'isSuccessful' {
			return rt.new_bool(this.issuccessful())
		}
		'getData' {
			return this.getdata()
		}
		'getJsonSchema' {
			return Class_WordPress_AiClient_Providers_Http_DTO_Response.getjsonschema()
		}
		'toArray' {
			return this.toarray()
		}
		'fromArray' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WordPress_AiClient_Providers_Http_DTO_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return Class_WordPress_AiClient_Providers_Http_DTO_Response.fromarray(mut dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_WordPress_AiClient_Providers_Http_DTO_Response) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'statusCode' { return rt.new_int(this.statusCode) }
		'headers' { return this.headers }
		'body' { return this.body }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WordPress_AiClient_Providers_Http_DTO_Response) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'statusCode' { this.statusCode = (val).to_i64(); return true }
		'headers' { this.headers = val; return true }
		'body' { this.body = val; return true }
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


fn (mut this Class_WordPress_AiClient_Providers_Http_DTO_self) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WordPress_AiClient_Providers_Http_DTO_self) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClient_Providers_Http_DTO_self) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_includes_php_ai_client_src_providers_http_dto_response_php() {
	// unsupported statement: Stmt_Declare
}
