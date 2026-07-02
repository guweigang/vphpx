import rt

struct Class_SimplePie_HTTP_Psr18Client {
	rt.PhpObjectBase
pub mut:
	httpClient       rt.PhpVal = rt.new_null()
	requestFactory   rt.PhpVal = rt.new_null()
	uriFactory       rt.PhpVal = rt.new_null()
	allowedRedirects rt.PhpVal = rt.new_int(5)
}

fn (mut this Class_SimplePie_HTTP_Psr18Client) construct(mut var_httpClient Class_Psr_Http_Client_ClientInterface, mut var_requestFactory Class_Psr_Http_Message_RequestFactoryInterface, mut var_uriFactory Class_Psr_Http_Message_UriFactoryInterface) {
	this.httpClient = var_httpClient
	this.requestFactory = var_requestFactory
	this.uriFactory = var_uriFactory
}

fn (mut this Class_SimplePie_HTTP_Psr18Client) gethttpclient() rt.PhpVal {
	return this.httpClient
}

fn (mut this Class_SimplePie_HTTP_Psr18Client) getrequestfactory() rt.PhpVal {
	return this.requestFactory
}

fn (mut this Class_SimplePie_HTTP_Psr18Client) geturifactory() rt.PhpVal {
	return this.uriFactory
}

fn (mut this Class_SimplePie_HTTP_Psr18Client) request(method string, url string, mut var_headers Class_SimplePie_HTTP_array) rt.PhpVal {
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(method),
		Class_SimplePie_HTTP_SimplePie_HTTP_Psr18Client.method_get()))))
	{
		rt.throw_exception(rt.new_object('InvalidArgumentException', []string{}, create_invalidargumentexception(rt.call_function('sprintf', [
			rt.new_string('%s(): Argument #1 ($method) only supports method "%s".'),
			rt.new_string(@METHOD),
			Class_SimplePie_HTTP_SimplePie_HTTP_Psr18Client.method_get(),
		]), rt.new_int(1))))
	}
	if rt.is_true(rt.call_function('preg_match', [rt.new_string('/^http(s)?:\\/\\//i'),
		rt.new_string(url)]))
	{
		return this.requesturl(method, url, mut var_headers)
	}
	return this.requestlocalfile(url)
}

fn (mut this Class_SimplePie_HTTP_Psr18Client) requesturl(method string, url string, mut var_headers Class_SimplePie_HTTP_array) rt.PhpVal {
	mut var_permanentUrl := rt.new_string(url)
	mut var_requestedUrl := rt.new_string(url)
	mut var_remainingRedirects := this.allowedRedirects
	mut var_request := rt.call_method(this.requestFactory, 'createRequest', [
		rt.new_string(method),
		rt.call_method(this.uriFactory, 'createUri', [var_requestedUrl.clone()]),
	])
	mut iter_1 := var_headers.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_value := item_1.val
		mut var_name := item_1.key
		var_request = rt.call_method(var_request, 'withHeader', [
			var_name.clone(), var_value.clone()])
	}
	for {
		mut var_followRedirect := rt.new_bool(false)
		mut var_response := rt.call_method(this.httpClient, 'sendRequest', [
			var_request.clone()])
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
		unsafe {
			goto end_label_1
		}
		catch_label_1:
		mut var_e_1 := rt.get_and_clear_exception()
		if rt.instance_of(var_e_1, 'Psr_Http_Client_ClientExceptionInterface') {
			mut var_th := var_e_1.clone()
			rt.throw_exception(rt.new_object('SimplePie_HTTP_ClientException', []string{}, create_simplepie_http_clientexception(rt.call_method(var_th,
				'getMessage', []rt.PhpVal{}), rt.call_method(var_th, 'getCode', []rt.PhpVal{}),
				var_th.clone())))
			unsafe {
				goto end_label_1
			}
		} else {
			rt.throw_exception(var_e_1)
			unsafe {
				goto end_label_1
			}
		}

		end_label_1:
		mut var_statusCode := rt.call_method(var_response, 'getStatusCode', []rt.PhpVal{})
		if rt.is_true(rt.call_function('in_array', [var_statusCode.clone(), rt.create_array([rt.ArrayItem{
			key: none
			val: 300
		}, rt.ArrayItem{ key: none, val: 301 }, rt.ArrayItem{ key: none, val: 302 }, rt.ArrayItem{
			key: none
			val: 303
		}, rt.ArrayItem{ key: none, val: 307 }])]))
			&& rt.is_true(rt.call_method(var_response, 'hasHeader', [rt.new_string('Location')])) {
			if rt.is_true(rt.less_equal(var_remainingRedirects, rt.new_int(0))) {
				break
			}
			rt.post_dec(var_remainingRedirects)
			var_followRedirect = rt.new_bool(true)
			var_requestedUrl = rt.call_method(var_response, 'getHeaderLine', [
				rt.new_string('Location'),
			])
			if rt.is_true(rt.identical(var_statusCode, rt.new_int(301))) {
				var_permanentUrl = var_requestedUrl.clone()
			}
			var_request = rt.call_method(var_request, 'withUri', [
				rt.call_method(this.uriFactory, 'createUri', [
					var_requestedUrl.clone()]),
			])
		}
		if !(rt.is_true(var_followRedirect)) {
			break
		}
	}
	return rt.new_object('SimplePie_HTTP_Psr7Response', []string{}, create_simplepie_http_psr7response(var_response.clone(),
		var_permanentUrl.clone(), var_requestedUrl.clone()))
}

fn (mut this Class_SimplePie_HTTP_Psr18Client) requestlocalfile(path string) rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_readable', [
		rt.new_string(path),
	])))))
	{
		rt.throw_exception(rt.new_object('SimplePie_HTTP_ClientException', []string{}, create_simplepie_http_clientexception(rt.call_function('sprintf', [
			rt.new_string('file "%s" is not readable'),
			rt.new_string(path),
		]))))
	}
	mut var_raw := rt.call_function('file_get_contents', [rt.new_string(path)])
	if rt.has_exception() {
		unsafe {
			goto catch_label_2
		}
	}
	unsafe {
		goto end_label_2
	}
	catch_label_2:
	mut var_e_2 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_2, 'Throwable') {
		mut var_th := var_e_2.clone()
		rt.throw_exception(rt.new_object('SimplePie_HTTP_ClientException', []string{}, create_simplepie_http_clientexception(rt.call_method(var_th,
			'getMessage', []rt.PhpVal{}), rt.call_method(var_th, 'getCode', []rt.PhpVal{}),
			var_th.clone())))
		unsafe {
			goto end_label_2
		}
	} else {
		rt.throw_exception(var_e_2)
		unsafe {
			goto end_label_2
		}
	}

	end_label_2:
	if rt.is_true(rt.identical(var_raw, rt.new_bool(false))) {
		rt.throw_exception(rt.new_object('SimplePie_HTTP_ClientException', []string{}, create_simplepie_http_clientexception(rt.new_string('file_get_contents() could not read the file'),
			rt.new_int(1))))
	}
	return rt.new_object('SimplePie_HTTP_RawTextResponse', []string{}, create_simplepie_http_rawtextresponse(var_raw.clone(),
		rt.new_string(path)))
}

struct Class_InvalidArgumentException {
	rt.PhpObjectBase
}

struct Class_SimplePie_HTTP_ClientException {
	rt.PhpObjectBase
}

struct Class_SimplePie_HTTP_Psr7Response {
	rt.PhpObjectBase
}

struct Class_SimplePie_HTTP_RawTextResponse {
	rt.PhpObjectBase
}

fn create_simplepie_http_psr18client(arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) &Class_SimplePie_HTTP_Psr18Client {
	mut obj := &Class_SimplePie_HTTP_Psr18Client{
		PhpObjectBase:    rt.PhpObjectBase{}
		httpClient:       rt.new_null()
		requestFactory:   rt.new_null()
		uriFactory:       rt.new_null()
		allowedRedirects: rt.new_int(5)
	}
	obj.construct(arg_0, arg_1, arg_2)
	return obj
}

fn create_invalidargumentexception(_args ...rt.PhpVal) &Class_InvalidArgumentException {
	mut obj := &Class_InvalidArgumentException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_simplepie_http_clientexception(_args ...rt.PhpVal) &Class_SimplePie_HTTP_ClientException {
	mut obj := &Class_SimplePie_HTTP_ClientException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_simplepie_http_psr7response(_args ...rt.PhpVal) &Class_SimplePie_HTTP_Psr7Response {
	mut obj := &Class_SimplePie_HTTP_Psr7Response{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_simplepie_http_rawtextresponse(_args ...rt.PhpVal) &Class_SimplePie_HTTP_RawTextResponse {
	mut obj := &Class_SimplePie_HTTP_RawTextResponse{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_SimplePie_HTTP_Psr18Client) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Psr_Http_Client_ClientInterface](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Psr_Http_Message_RequestFactoryInterface](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Psr_Http_Message_UriFactoryInterface](if args.len > 2 {
				args[2]
			} else {
				rt.new_null()
			})
			this.construct(mut dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2)
			return rt.new_null()
		}
		'getHttpClient' {
			return this.gethttpclient()
		}
		'getRequestFactory' {
			return this.getrequestfactory()
		}
		'getUriFactory' {
			return this.geturifactory()
		}
		'request' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_SimplePie_HTTP_array](if args.len > 2 {
				args[2]
			} else {
				rt.new_null()
			})
			return this.request(dispatch_arg_0, dispatch_arg_1, mut dispatch_arg_2)
		}
		'requestUrl' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_SimplePie_HTTP_array](if args.len > 2 {
				args[2]
			} else {
				rt.new_null()
			})
			return this.requesturl(dispatch_arg_0, dispatch_arg_1, mut dispatch_arg_2)
		}
		'requestLocalFile' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.requestlocalfile(dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_SimplePie_HTTP_Psr18Client) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'httpClient' { return this.httpClient }
		'requestFactory' { return this.requestFactory }
		'uriFactory' { return this.uriFactory }
		'allowedRedirects' { return this.allowedRedirects }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_SimplePie_HTTP_Psr18Client) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'httpClient' {
			this.httpClient = val
			return true
		}
		'requestFactory' {
			this.requestFactory = val
			return true
		}
		'uriFactory' {
			this.uriFactory = val
			return true
		}
		'allowedRedirects' {
			this.allowedRedirects = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_InvalidArgumentException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_InvalidArgumentException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_InvalidArgumentException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_SimplePie_HTTP_ClientException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_SimplePie_HTTP_ClientException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_SimplePie_HTTP_ClientException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_SimplePie_HTTP_Psr7Response) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_SimplePie_HTTP_Psr7Response) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_SimplePie_HTTP_Psr7Response) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_SimplePie_HTTP_RawTextResponse) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_SimplePie_HTTP_RawTextResponse) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_SimplePie_HTTP_RawTextResponse) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
