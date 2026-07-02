import rt

pub fn Class_WordPress_AiClient_Providers_Http_DTO_ApiKeyRequestAuthentication.key_api_key() string {
	return 'apiKey'
}

struct Class_WordPress_AiClient_Providers_Http_DTO_ApiKeyRequestAuthentication {
	rt.PhpObjectBase
pub mut:
	apiKey string
}

fn (mut this Class_WordPress_AiClient_Providers_Http_DTO_ApiKeyRequestAuthentication) construct(apiKey string) {
	this.apiKey = apiKey
}

fn (mut this Class_WordPress_AiClient_Providers_Http_DTO_ApiKeyRequestAuthentication) authenticaterequest(mut var_request Class_WordPress_AiClient_Providers_Http_DTO_WordPress_AiClient_Providers_Http_DTO_Request) rt.PhpVal {
	return var_request.withheader(rt.new_string('Authorization'), rt.new_string('Bearer ' +
		this.apiKey))
}

fn (mut this Class_WordPress_AiClient_Providers_Http_DTO_ApiKeyRequestAuthentication) getapikey() string {
	return this.apiKey
}

fn (mut this Class_WordPress_AiClient_Providers_Http_DTO_ApiKeyRequestAuthentication) toarray() rt.PhpVal {
	return rt.create_array([
		rt.ArrayItem{
			key: Class_WordPress_AiClient_Providers_Http_DTO_WordPress_AiClient_Providers_Http_DTO_ApiKeyRequestAuthentication.key_api_key()
			val: this.apiKey
		},
	])
}

fn Class_WordPress_AiClient_Providers_Http_DTO_ApiKeyRequestAuthentication.fromarray(mut var_array Class_WordPress_AiClient_Providers_Http_DTO_array) rt.PhpVal {
	mut iife_temp_0 := Class_WordPress_AiClient_Providers_Http_DTO_ApiKeyRequestAuthentication{}
	mut iife_result_0 := iife_temp_0.validatefromarraydata(rt.new_object('WordPress_AiClient_Providers_Http_DTO_array',
		[]string{}, var_array), rt.create_array([
		rt.ArrayItem{
			key: none
			val: Class_WordPress_AiClient_Providers_Http_DTO_WordPress_AiClient_Providers_Http_DTO_ApiKeyRequestAuthentication.key_api_key()
		},
	]))
	return rt.new_object('WordPress_AiClient_Providers_Http_DTO_self', []string{},
		create_wordpress_aiclient_providers_http_dto_self(var_array.array_get(Class_WordPress_AiClient_Providers_Http_DTO_WordPress_AiClient_Providers_Http_DTO_ApiKeyRequestAuthentication.key_api_key())))
}

fn Class_WordPress_AiClient_Providers_Http_DTO_ApiKeyRequestAuthentication.getjsonschema() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: 'type', val: 'object' },
		rt.ArrayItem{ key: 'properties', val: rt.create_array([
			rt.ArrayItem{
				key: Class_WordPress_AiClient_Providers_Http_DTO_WordPress_AiClient_Providers_Http_DTO_ApiKeyRequestAuthentication.key_api_key()
				val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'title', val: 'API Key' },
					rt.ArrayItem{ key: 'description', val: 'The API key used for authentication.' }])
			},
		]) }, rt.ArrayItem{ key: 'required', val: rt.create_array([
			rt.ArrayItem{
				key: none
				val: Class_WordPress_AiClient_Providers_Http_DTO_WordPress_AiClient_Providers_Http_DTO_ApiKeyRequestAuthentication.key_api_key()
			},
		]) }])
}

struct Class_WordPress_AiClient_Common_AbstractDataTransferObject {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClient_Providers_Http_DTO_self {
	rt.PhpObjectBase
}

fn create_wordpress_aiclient_providers_http_dto_apikeyrequestauthentication(apiKey string) &Class_WordPress_AiClient_Providers_Http_DTO_ApiKeyRequestAuthentication {
	mut obj := &Class_WordPress_AiClient_Providers_Http_DTO_ApiKeyRequestAuthentication{
		PhpObjectBase: rt.PhpObjectBase{}
		apiKey:        ''
	}
	obj.construct(apiKey)
	return obj
}

fn create_wordpress_aiclient_common_abstractdatatransferobject(_args ...rt.PhpVal) &Class_WordPress_AiClient_Common_AbstractDataTransferObject {
	mut obj := &Class_WordPress_AiClient_Common_AbstractDataTransferObject{
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

fn (mut this Class_WordPress_AiClient_Providers_Http_DTO_ApiKeyRequestAuthentication) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'authenticateRequest' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WordPress_AiClient_Providers_Http_DTO_WordPress_AiClient_Providers_Http_DTO_Request](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.authenticaterequest(mut dispatch_arg_0)
		}
		'getApiKey' {
			return rt.new_string(this.getapikey())
		}
		'toArray' {
			return this.toarray()
		}
		'fromArray' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WordPress_AiClient_Providers_Http_DTO_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return Class_WordPress_AiClient_Providers_Http_DTO_ApiKeyRequestAuthentication.fromarray(mut dispatch_arg_0)
		}
		'getJsonSchema' {
			return Class_WordPress_AiClient_Providers_Http_DTO_ApiKeyRequestAuthentication.getjsonschema()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WordPress_AiClient_Providers_Http_DTO_ApiKeyRequestAuthentication) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'apiKey' { return rt.new_string(this.apiKey) }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WordPress_AiClient_Providers_Http_DTO_ApiKeyRequestAuthentication) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'apiKey' {
			this.apiKey = val.str()
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
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
