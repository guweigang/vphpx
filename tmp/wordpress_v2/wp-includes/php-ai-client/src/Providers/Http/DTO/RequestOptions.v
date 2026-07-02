import rt

pub fn Class_WordPress_AiClient_Providers_Http_DTO_RequestOptions.key_timeout() string {
	return 'timeout'
}
pub fn Class_WordPress_AiClient_Providers_Http_DTO_RequestOptions.key_connect_timeout() string {
	return 'connectTimeout'
}
pub fn Class_WordPress_AiClient_Providers_Http_DTO_RequestOptions.key_max_redirects() string {
	return 'maxRedirects'
}
struct Class_WordPress_AiClient_Providers_Http_DTO_RequestOptions {
	rt.PhpObjectBase
pub mut:
		timeout rt.PhpVal = rt.new_null()
		connectTimeout rt.PhpVal = rt.new_null()
		maxRedirects rt.PhpVal = rt.new_null()
}

fn (mut this Class_WordPress_AiClient_Providers_Http_DTO_RequestOptions) settimeout(mut var_timeout Class_WordPress_AiClient_Providers_Http_DTO_?float) {
	this.validatetimeout(mut var_timeout, (Class_WordPress_AiClient_Providers_Http_DTO_WordPress_AiClient_Providers_Http_DTO_RequestOptions.key_timeout()).str())
	this.timeout = var_timeout
}

fn (mut this Class_WordPress_AiClient_Providers_Http_DTO_RequestOptions) setconnecttimeout(mut var_timeout Class_WordPress_AiClient_Providers_Http_DTO_?float) {
	this.validatetimeout(mut var_timeout, (Class_WordPress_AiClient_Providers_Http_DTO_WordPress_AiClient_Providers_Http_DTO_RequestOptions.key_connect_timeout()).str())
	this.connectTimeout = var_timeout
}

fn (mut this Class_WordPress_AiClient_Providers_Http_DTO_RequestOptions) setmaxredirects(mut var_maxRedirects Class_WordPress_AiClient_Providers_Http_DTO_?int) {
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_maxRedirects, rt.new_null())))) && rt.is_true(rt.less(var_maxRedirects, rt.new_int(0))) {
		rt.throw_exception(rt.new_object('WordPress_AiClient_Common_Exception_InvalidArgumentException', []string{}, create_wordpress_aiclient_common_exception_invalidargumentexception(rt.new_string('Request option "maxRedirects" must be greater than or equal to 0.'))))
	}
	this.maxRedirects = var_maxRedirects
}

fn (mut this Class_WordPress_AiClient_Providers_Http_DTO_RequestOptions) gettimeout() f64 {
	return (this.timeout).to_f64()
}

fn (mut this Class_WordPress_AiClient_Providers_Http_DTO_RequestOptions) getconnecttimeout() f64 {
	return (this.connectTimeout).to_f64()
}

fn (mut this Class_WordPress_AiClient_Providers_Http_DTO_RequestOptions) allowsredirects() bool {
	if rt.is_true(rt.identical(this.maxRedirects, rt.new_null())) {
		return (rt.new_null()).to_bool()
	}
	return (rt.greater(this.maxRedirects, rt.new_int(0))).to_bool()
}

fn (mut this Class_WordPress_AiClient_Providers_Http_DTO_RequestOptions) getmaxredirects() i64 {
	return (this.maxRedirects).to_i64()
}

fn (mut this Class_WordPress_AiClient_Providers_Http_DTO_RequestOptions) toarray() rt.PhpVal {
	mut var_data := rt.new_array()
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(this.timeout, rt.new_null())))) {
		var_data.array_set(Class_WordPress_AiClient_Providers_Http_DTO_WordPress_AiClient_Providers_Http_DTO_RequestOptions.key_timeout(), this.timeout)
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(this.connectTimeout, rt.new_null())))) {
		var_data.array_set(Class_WordPress_AiClient_Providers_Http_DTO_WordPress_AiClient_Providers_Http_DTO_RequestOptions.key_connect_timeout(), this.connectTimeout)
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(this.maxRedirects, rt.new_null())))) {
		var_data.array_set(Class_WordPress_AiClient_Providers_Http_DTO_WordPress_AiClient_Providers_Http_DTO_RequestOptions.key_max_redirects(), this.maxRedirects)
	}
	return var_data.clone()
}

fn Class_WordPress_AiClient_Providers_Http_DTO_RequestOptions.fromarray(mut var_array Class_WordPress_AiClient_Providers_Http_DTO_array) rt.PhpVal {
	mut var_instance := create_wordpress_aiclient_providers_http_dto_self()
	if var_array.array_isset(Class_WordPress_AiClient_Providers_Http_DTO_WordPress_AiClient_Providers_Http_DTO_RequestOptions.key_timeout()) {
		var_instance.settimeout(rt.new_float((var_array.array_get(Class_WordPress_AiClient_Providers_Http_DTO_WordPress_AiClient_Providers_Http_DTO_RequestOptions.key_timeout())).to_f64()))
	}
	if var_array.array_isset(Class_WordPress_AiClient_Providers_Http_DTO_WordPress_AiClient_Providers_Http_DTO_RequestOptions.key_connect_timeout()) {
		var_instance.setconnecttimeout(rt.new_float((var_array.array_get(Class_WordPress_AiClient_Providers_Http_DTO_WordPress_AiClient_Providers_Http_DTO_RequestOptions.key_connect_timeout())).to_f64()))
	}
	if var_array.array_isset(Class_WordPress_AiClient_Providers_Http_DTO_WordPress_AiClient_Providers_Http_DTO_RequestOptions.key_max_redirects()) {
		var_instance.setmaxredirects(rt.new_int((var_array.array_get(Class_WordPress_AiClient_Providers_Http_DTO_WordPress_AiClient_Providers_Http_DTO_RequestOptions.key_max_redirects())).to_i64()))
	}
	return mut var_instance
}

fn Class_WordPress_AiClient_Providers_Http_DTO_RequestOptions.getjsonschema() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: Class_WordPress_AiClient_Providers_Http_DTO_WordPress_AiClient_Providers_Http_DTO_RequestOptions.key_timeout(), val: rt.create_array([rt.ArrayItem{ key: 'type', val: rt.create_array([rt.ArrayItem{ key: none, val: 'number' }, rt.ArrayItem{ key: none, val: 'null' }]) }, rt.ArrayItem{ key: 'minimum', val: 0 }, rt.ArrayItem{ key: 'description', val: 'Maximum duration in seconds to wait for the full response.' }]) }, rt.ArrayItem{ key: Class_WordPress_AiClient_Providers_Http_DTO_WordPress_AiClient_Providers_Http_DTO_RequestOptions.key_connect_timeout(), val: rt.create_array([rt.ArrayItem{ key: 'type', val: rt.create_array([rt.ArrayItem{ key: none, val: 'number' }, rt.ArrayItem{ key: none, val: 'null' }]) }, rt.ArrayItem{ key: 'minimum', val: 0 }, rt.ArrayItem{ key: 'description', val: 'Maximum duration in seconds to wait for the initial connection.' }]) }, rt.ArrayItem{ key: Class_WordPress_AiClient_Providers_Http_DTO_WordPress_AiClient_Providers_Http_DTO_RequestOptions.key_max_redirects(), val: rt.create_array([rt.ArrayItem{ key: 'type', val: rt.create_array([rt.ArrayItem{ key: none, val: 'integer' }, rt.ArrayItem{ key: none, val: 'null' }]) }, rt.ArrayItem{ key: 'minimum', val: 0 }, rt.ArrayItem{ key: 'description', val: 'Maximum redirects to follow. 0 disables, null is unspecified.' }]) }]) }, rt.ArrayItem{ key: 'additionalProperties', val: false }])
}

fn (mut this Class_WordPress_AiClient_Providers_Http_DTO_RequestOptions) validatetimeout(mut var_value Class_WordPress_AiClient_Providers_Http_DTO_?float, fieldName string) {
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_value, rt.new_null())))) && rt.is_true(rt.less(var_value, rt.new_int(0))) {
		rt.throw_exception(rt.new_object('WordPress_AiClient_Common_Exception_InvalidArgumentException', []string{}, create_wordpress_aiclient_common_exception_invalidargumentexception(rt.call_function('sprintf', [rt.new_string('Request option "%s" must be greater than or equal to 0.'), rt.new_string(fieldName)]))))
	}
}

struct Class_WordPress_AiClient_Common_AbstractDataTransferObject {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClient_Common_Exception_InvalidArgumentException {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClient_Providers_Http_DTO_self {
	rt.PhpObjectBase
}

fn create_wordpress_aiclient_providers_http_dto_requestoptions(_args ...rt.PhpVal) &Class_WordPress_AiClient_Providers_Http_DTO_RequestOptions {
	mut obj := &Class_WordPress_AiClient_Providers_Http_DTO_RequestOptions{
		PhpObjectBase: rt.PhpObjectBase{}
		timeout: rt.new_null()
		connectTimeout: rt.new_null()
		maxRedirects: rt.new_null()
	}
	return obj
}

fn create_wordpress_aiclient_common_abstractdatatransferobject(_args ...rt.PhpVal) &Class_WordPress_AiClient_Common_AbstractDataTransferObject {
	mut obj := &Class_WordPress_AiClient_Common_AbstractDataTransferObject{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wordpress_aiclient_common_exception_invalidargumentexception(_args ...rt.PhpVal) &Class_WordPress_AiClient_Common_Exception_InvalidArgumentException {
	mut obj := &Class_WordPress_AiClient_Common_Exception_InvalidArgumentException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wordpress_aiclient_providers_http_dto_self(_args ...rt.PhpVal) &Class_WordPress_AiClient_Providers_Http_DTO_self {
	mut obj := &Class_WordPress_AiClient_Providers_Http_DTO_self{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WordPress_AiClient_Providers_Http_DTO_RequestOptions) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'setTimeout' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WordPress_AiClient_Providers_Http_DTO_?float](if args.len > 0 { args[0] } else { rt.new_null() })
			this.settimeout(mut dispatch_arg_0)
			return rt.new_null()
		}
		'setConnectTimeout' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WordPress_AiClient_Providers_Http_DTO_?float](if args.len > 0 { args[0] } else { rt.new_null() })
			this.setconnecttimeout(mut dispatch_arg_0)
			return rt.new_null()
		}
		'setMaxRedirects' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WordPress_AiClient_Providers_Http_DTO_?int](if args.len > 0 { args[0] } else { rt.new_null() })
			this.setmaxredirects(mut dispatch_arg_0)
			return rt.new_null()
		}
		'getTimeout' {
			return rt.new_float(this.gettimeout())
		}
		'getConnectTimeout' {
			return rt.new_float(this.getconnecttimeout())
		}
		'allowsRedirects' {
			return rt.new_bool(this.allowsredirects())
		}
		'getMaxRedirects' {
			return rt.new_int(this.getmaxredirects())
		}
		'toArray' {
			return this.toarray()
		}
		'fromArray' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WordPress_AiClient_Providers_Http_DTO_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return Class_WordPress_AiClient_Providers_Http_DTO_RequestOptions.fromarray(mut dispatch_arg_0)
		}
		'getJsonSchema' {
			return Class_WordPress_AiClient_Providers_Http_DTO_RequestOptions.getjsonschema()
		}
		'validateTimeout' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WordPress_AiClient_Providers_Http_DTO_?float](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			this.validatetimeout(mut dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_WordPress_AiClient_Providers_Http_DTO_RequestOptions) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'timeout' { return this.timeout }
		'connectTimeout' { return this.connectTimeout }
		'maxRedirects' { return this.maxRedirects }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WordPress_AiClient_Providers_Http_DTO_RequestOptions) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'timeout' { this.timeout = val; return true }
		'connectTimeout' { this.connectTimeout = val; return true }
		'maxRedirects' { this.maxRedirects = val; return true }
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


fn (mut this Class_WordPress_AiClient_Providers_Http_DTO_self) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WordPress_AiClient_Providers_Http_DTO_self) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClient_Providers_Http_DTO_self) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}



fn main() {
	defer {
		rt.shutdown()
	}

}
