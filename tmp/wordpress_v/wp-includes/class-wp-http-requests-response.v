import rt

struct Class_WP_HTTP_Requests_Response {
	rt.PhpObjectBase
pub mut:
	response rt.PhpVal = rt.new_null()
	filename rt.PhpVal = rt.new_null()
}

fn (mut this Class_WP_HTTP_Requests_Response) construct(mut var_response Class_WpOrg_Requests_Response, filename string) {
	this.response = var_response.dup()
	this.filename = rt.new_string(filename).dup()
}

fn (mut this Class_WP_HTTP_Requests_Response) get_response_object() rt.PhpVal {
	return this.response
}

fn (mut this Class_WP_HTTP_Requests_Response) get_headers() rt.PhpVal {
	mut var_converted := create_wporg_requests_utility_caseinsensitivedictionary()
	{
		mut iter_1 := rt.call_method(rt.get_property(this.response, 'headers'), 'getAll',
			[]rt.PhpVal{}).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_value := item_1.val
			mut var_key := item_1.key
			if var_value.dup().array_count() == 1 {
				var_converted.array_set(var_key, var_value.array_get(0))
			} else {
				var_converted.array_set(var_key, var_value.dup())
			}
		}
	}
	return var_converted.dup()
}

fn (mut this Class_WP_HTTP_Requests_Response) set_headers(var_headers rt.PhpVal) {
	rt.set_property(this.response, 'headers',
		create_wporg_requests_response_headers(var_headers.dup()))
}

fn (mut this Class_WP_HTTP_Requests_Response) header(var_key rt.PhpVal, var_value rt.PhpVal, replace bool) {
	if var_replace {
		rt.get_property(this.response, 'headers').array_unset(var_key)
	}
	rt.get_property(this.response, 'headers').array_set(var_key, var_value.dup())
}

fn (mut this Class_WP_HTTP_Requests_Response) get_status() rt.PhpVal {
	return rt.get_property(this.response, 'status_code')
}

fn (mut this Class_WP_HTTP_Requests_Response) set_status(var_code rt.PhpVal) {
	rt.set_property(this.response, 'status_code', rt.call_function('absint', [
		var_code.dup()]))
}

fn (mut this Class_WP_HTTP_Requests_Response) get_data() rt.PhpVal {
	return rt.get_property(this.response, 'body')
}

fn (mut this Class_WP_HTTP_Requests_Response) set_data(var_data rt.PhpVal) {
	rt.set_property(this.response, 'body', var_data.dup())
}

fn (mut this Class_WP_HTTP_Requests_Response) get_cookies() rt.PhpVal {
	mut var_cookies := []rt.PhpVal{}
	{
		mut iter_1 := rt.get_property(this.response, 'cookies').iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_cookie := item_1.val
			var_cookies << create_wp_http_cookie(rt.create_array([
				rt.ArrayItem{ key: 'name', val: rt.get_property(var_cookie, 'name') },
				rt.ArrayItem{ key: 'value', val: rt.call_function('urldecode', [
					rt.get_property(var_cookie, 'value'),
				]) },
				rt.ArrayItem{
					key: 'expires'
					val: if !(rt.get_property(var_cookie, 'attributes').array_get('expires')).is_null() {
						rt.get_property(var_cookie, 'attributes').array_get('expires')
					} else {
						rt.new_null()
					}
				},
				rt.ArrayItem{
					key: 'path'
					val: if !(rt.get_property(var_cookie, 'attributes').array_get('path')).is_null() {
						rt.get_property(var_cookie, 'attributes').array_get('path')
					} else {
						rt.new_null()
					}
				},
				rt.ArrayItem{
					key: 'domain'
					val: if !(rt.get_property(var_cookie, 'attributes').array_get('domain')).is_null() {
						rt.get_property(var_cookie, 'attributes').array_get('domain')
					} else {
						rt.new_null()
					}
				},
				rt.ArrayItem{
					key: 'host_only'
					val: if !(rt.get_property(var_cookie, 'flags').array_get('host-only')).is_null() {
						rt.get_property(var_cookie, 'flags').array_get('host-only')
					} else {
						rt.new_null()
					}
				},
			]))
		}
	}
	return var_cookies.dup()
}

fn (mut this Class_WP_HTTP_Requests_Response) to_array() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: 'headers', val: this.get_headers() },
		rt.ArrayItem{ key: 'body', val: this.get_data() }, rt.ArrayItem{ key: 'response', val: rt.create_array([
			rt.ArrayItem{ key: 'code', val: this.get_status() },
			rt.ArrayItem{ key: 'message', val: rt.call_function('get_status_header_desc', [
				this.get_status(),
			]) },
		]) }, rt.ArrayItem{ key: 'cookies', val: this.get_cookies() },
		rt.ArrayItem{ key: 'filename', val: this.filename }])
}

struct Class_WP_HTTP_Response {
	rt.PhpObjectBase
}

struct Class_WpOrg_Requests_Utility_CaseInsensitiveDictionary {
	rt.PhpObjectBase
}

struct Class_WpOrg_Requests_Response_Headers {
	rt.PhpObjectBase
}

struct Class_WP_Http_Cookie {
	rt.PhpObjectBase
}

fn create_wp_http_requests_response(arg_0 rt.PhpVal, filename string) &Class_WP_HTTP_Requests_Response {
	mut obj := &Class_WP_HTTP_Requests_Response{
		PhpObjectBase: rt.PhpObjectBase{}
		response:      rt.new_null()
		filename:      rt.new_null()
	}
	obj.construct(arg_0, filename)
	return obj
}

fn create_wp_http_response() &Class_WP_HTTP_Response {
	mut obj := &Class_WP_HTTP_Response{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wporg_requests_utility_caseinsensitivedictionary() &Class_WpOrg_Requests_Utility_CaseInsensitiveDictionary {
	mut obj := &Class_WpOrg_Requests_Utility_CaseInsensitiveDictionary{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wporg_requests_response_headers() &Class_WpOrg_Requests_Response_Headers {
	mut obj := &Class_WpOrg_Requests_Response_Headers{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_http_cookie() &Class_WP_Http_Cookie {
	mut obj := &Class_WP_Http_Cookie{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_HTTP_Requests_Response) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WpOrg_Requests_Response](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			this.construct(mut dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'get_response_object' {
			return this.get_response_object()
		}
		'get_headers' {
			return this.get_headers()
		}
		'set_headers' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_headers(dispatch_arg_0)
			return rt.new_null()
		}
		'header' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
			this.header(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'get_status' {
			return this.get_status()
		}
		'set_status' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_status(dispatch_arg_0)
			return rt.new_null()
		}
		'get_data' {
			return this.get_data()
		}
		'set_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_data(dispatch_arg_0)
			return rt.new_null()
		}
		'get_cookies' {
			return this.get_cookies()
		}
		'to_array' {
			return this.to_array()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WP_HTTP_Requests_Response) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'response' { return this.response }
		'filename' { return this.filename }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_HTTP_Requests_Response) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'response' {
			this.response = val
			return true
		}
		'filename' {
			this.filename = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_WP_HTTP_Response) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_HTTP_Response) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_HTTP_Response) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WpOrg_Requests_Utility_CaseInsensitiveDictionary) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WpOrg_Requests_Utility_CaseInsensitiveDictionary) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WpOrg_Requests_Utility_CaseInsensitiveDictionary) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WpOrg_Requests_Response_Headers) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WpOrg_Requests_Response_Headers) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WpOrg_Requests_Response_Headers) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WP_Http_Cookie) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Http_Cookie) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Http_Cookie) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_includes_class_wp_http_requests_response_php() {
}
