import rt

pub fn Class_WordPress_AiClient_Providers_Http_Enums_HttpMethodEnum.get() string {
	return 'GET'
}

pub fn Class_WordPress_AiClient_Providers_Http_Enums_HttpMethodEnum.post() string {
	return 'POST'
}

pub fn Class_WordPress_AiClient_Providers_Http_Enums_HttpMethodEnum.put() string {
	return 'PUT'
}

pub fn Class_WordPress_AiClient_Providers_Http_Enums_HttpMethodEnum.patch() string {
	return 'PATCH'
}

pub fn Class_WordPress_AiClient_Providers_Http_Enums_HttpMethodEnum.delete() string {
	return 'DELETE'
}

pub fn Class_WordPress_AiClient_Providers_Http_Enums_HttpMethodEnum.head() string {
	return 'HEAD'
}

pub fn Class_WordPress_AiClient_Providers_Http_Enums_HttpMethodEnum.options() string {
	return 'OPTIONS'
}

pub fn Class_WordPress_AiClient_Providers_Http_Enums_HttpMethodEnum.connect() string {
	return 'CONNECT'
}

pub fn Class_WordPress_AiClient_Providers_Http_Enums_HttpMethodEnum.trace() string {
	return 'TRACE'
}

struct Class_WordPress_AiClient_Providers_Http_Enums_HttpMethodEnum {
	rt.PhpObjectBase
}

fn (mut this Class_WordPress_AiClient_Providers_Http_Enums_HttpMethodEnum) isidempotent() bool {
	return (rt.call_function('in_array', [
		rt.get_property(rt.new_object('WordPress_AiClient_Providers_Http_Enums_HttpMethodEnum', [
			'WordPress_AiClient_Common_AbstractEnum',
		], &this), 'value'),
		rt.create_array([
			rt.ArrayItem{
				key: none
				val: Class_WordPress_AiClient_Providers_Http_Enums_WordPress_AiClient_Providers_Http_Enums_HttpMethodEnum.get()
			},
			rt.ArrayItem{
				key: none
				val: Class_WordPress_AiClient_Providers_Http_Enums_WordPress_AiClient_Providers_Http_Enums_HttpMethodEnum.head()
			},
			rt.ArrayItem{
				key: none
				val: Class_WordPress_AiClient_Providers_Http_Enums_WordPress_AiClient_Providers_Http_Enums_HttpMethodEnum.options()
			},
			rt.ArrayItem{
				key: none
				val: Class_WordPress_AiClient_Providers_Http_Enums_WordPress_AiClient_Providers_Http_Enums_HttpMethodEnum.trace()
			},
			rt.ArrayItem{
				key: none
				val: Class_WordPress_AiClient_Providers_Http_Enums_WordPress_AiClient_Providers_Http_Enums_HttpMethodEnum.put()
			},
			rt.ArrayItem{
				key: none
				val: Class_WordPress_AiClient_Providers_Http_Enums_WordPress_AiClient_Providers_Http_Enums_HttpMethodEnum.delete()
			},
		]),
		rt.new_bool(true),
	])).to_bool()
}

fn (mut this Class_WordPress_AiClient_Providers_Http_Enums_HttpMethodEnum) hasbody() bool {
	return (rt.call_function('in_array', [
		rt.get_property(rt.new_object('WordPress_AiClient_Providers_Http_Enums_HttpMethodEnum', [
			'WordPress_AiClient_Common_AbstractEnum',
		], &this), 'value'),
		rt.create_array([
			rt.ArrayItem{
				key: none
				val: Class_WordPress_AiClient_Providers_Http_Enums_WordPress_AiClient_Providers_Http_Enums_HttpMethodEnum.post()
			},
			rt.ArrayItem{
				key: none
				val: Class_WordPress_AiClient_Providers_Http_Enums_WordPress_AiClient_Providers_Http_Enums_HttpMethodEnum.put()
			},
			rt.ArrayItem{
				key: none
				val: Class_WordPress_AiClient_Providers_Http_Enums_WordPress_AiClient_Providers_Http_Enums_HttpMethodEnum.patch()
			},
		]),
		rt.new_bool(true),
	])).to_bool()
}

struct Class_WordPress_AiClient_Common_AbstractEnum {
	rt.PhpObjectBase
}

fn create_wordpress_aiclient_providers_http_enums_httpmethodenum(_args ...rt.PhpVal) &Class_WordPress_AiClient_Providers_Http_Enums_HttpMethodEnum {
	mut obj := &Class_WordPress_AiClient_Providers_Http_Enums_HttpMethodEnum{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wordpress_aiclient_common_abstractenum(_args ...rt.PhpVal) &Class_WordPress_AiClient_Common_AbstractEnum {
	mut obj := &Class_WordPress_AiClient_Common_AbstractEnum{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WordPress_AiClient_Providers_Http_Enums_HttpMethodEnum) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'isIdempotent' {
			return rt.new_bool(this.isidempotent())
		}
		'hasBody' {
			return rt.new_bool(this.hasbody())
		}
		else {
			return none
		}
	}
}

fn (this &Class_WordPress_AiClient_Providers_Http_Enums_HttpMethodEnum) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClient_Providers_Http_Enums_HttpMethodEnum) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WordPress_AiClient_Common_AbstractEnum) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WordPress_AiClient_Common_AbstractEnum) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClient_Common_AbstractEnum) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
