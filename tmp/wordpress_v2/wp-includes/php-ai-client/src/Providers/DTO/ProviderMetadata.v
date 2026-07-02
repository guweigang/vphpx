import rt

pub fn Class_WordPress_AiClient_Providers_DTO_ProviderMetadata.key_id() string {
	return 'id'
}
pub fn Class_WordPress_AiClient_Providers_DTO_ProviderMetadata.key_name() string {
	return 'name'
}
pub fn Class_WordPress_AiClient_Providers_DTO_ProviderMetadata.key_description() string {
	return 'description'
}
pub fn Class_WordPress_AiClient_Providers_DTO_ProviderMetadata.key_type() string {
	return 'type'
}
pub fn Class_WordPress_AiClient_Providers_DTO_ProviderMetadata.key_credentials_url() string {
	return 'credentialsUrl'
}
pub fn Class_WordPress_AiClient_Providers_DTO_ProviderMetadata.key_authentication_method() string {
	return 'authenticationMethod'
}
pub fn Class_WordPress_AiClient_Providers_DTO_ProviderMetadata.key_logo_path() string {
	return 'logoPath'
}
struct Class_WordPress_AiClient_Providers_DTO_ProviderMetadata {
	rt.PhpObjectBase
pub mut:
		id string
		name string
		description rt.PhpVal = rt.new_null()
		prop_type rt.PhpVal = rt.new_null()
		credentialsUrl rt.PhpVal = rt.new_null()
		authenticationMethod rt.PhpVal = rt.new_null()
		logoPath rt.PhpVal = rt.new_null()
}

fn (mut this Class_WordPress_AiClient_Providers_DTO_ProviderMetadata) construct(id string, name string, mut var_type Class_WordPress_AiClient_Providers_Enums_ProviderTypeEnum, mut var_credentialsUrl Class_WordPress_AiClient_Providers_DTO_?string, mut var_authenticationMethod Class_WordPress_AiClient_Providers_DTO_?RequestAuthenticationMethod, mut var_description Class_WordPress_AiClient_Providers_DTO_?string, mut var_logoPath Class_WordPress_AiClient_Providers_DTO_?string) {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('preg_match', [rt.new_string('/^[a-z0-9\\-_]+$/'), rt.new_string(id)]))))) {
		rt.throw_exception(rt.new_object('WordPress_AiClient_Common_Exception_InvalidArgumentException', []string{}, create_wordpress_aiclient_common_exception_invalidargumentexception(rt.call_function('sprintf', [rt.new_string('Invalid provider ID "%s". Only lowercase alphanumeric characters, hyphens, and underscores are allowed.'), rt.new_string(id)]))))
	}
	this.id = id
	this.name = name
	this.description = var_description
	this.prop_type = var_type
	this.credentialsUrl = var_credentialsUrl
	this.authenticationMethod = var_authenticationMethod
	this.logoPath = var_logoPath
}

fn (mut this Class_WordPress_AiClient_Providers_DTO_ProviderMetadata) getid() string {
	return this.id
}

fn (mut this Class_WordPress_AiClient_Providers_DTO_ProviderMetadata) getname() string {
	return this.name
}

fn (mut this Class_WordPress_AiClient_Providers_DTO_ProviderMetadata) getdescription() string {
	return (this.description).str()
}

fn (mut this Class_WordPress_AiClient_Providers_DTO_ProviderMetadata) gettype() rt.PhpVal {
	return this.prop_type
}

fn (mut this Class_WordPress_AiClient_Providers_DTO_ProviderMetadata) getcredentialsurl() string {
	return (this.credentialsUrl).str()
}

fn (mut this Class_WordPress_AiClient_Providers_DTO_ProviderMetadata) getauthenticationmethod() rt.PhpVal {
	return this.authenticationMethod
}

fn (mut this Class_WordPress_AiClient_Providers_DTO_ProviderMetadata) getlogopath() string {
	return (this.logoPath).str()
}

fn Class_WordPress_AiClient_Providers_DTO_ProviderMetadata.getjsonschema() rt.PhpVal {
	mut iife_temp_0 := Class_WordPress_AiClient_Providers_Enums_ProviderTypeEnum{}
	mut iife_result_0 := iife_temp_0.getvalues()
	mut iife_temp_1 := Class_WordPress_AiClient_Providers_Http_Enums_RequestAuthenticationMethod{}
	mut iife_result_1 := iife_temp_1.getvalues()
	mut iife_temp_2 := Class_WordPress_AiClient_Providers_Http_Enums_RequestAuthenticationMethod{}
	mut iife_result_2 := iife_temp_2.getvalues()
	return rt.create_array([rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: Class_WordPress_AiClient_Providers_DTO_WordPress_AiClient_Providers_DTO_ProviderMetadata.key_id(), val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'description', val: 'The provider\'s unique identifier.' }]) }, rt.ArrayItem{ key: Class_WordPress_AiClient_Providers_DTO_WordPress_AiClient_Providers_DTO_ProviderMetadata.key_name(), val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'description', val: 'The provider\'s display name.' }]) }, rt.ArrayItem{ key: Class_WordPress_AiClient_Providers_DTO_WordPress_AiClient_Providers_DTO_ProviderMetadata.key_description(), val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'description', val: 'The provider\'s description.' }]) }, rt.ArrayItem{ key: Class_WordPress_AiClient_Providers_DTO_WordPress_AiClient_Providers_DTO_ProviderMetadata.key_type(), val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'enum', val: iife_result_0 }, rt.ArrayItem{ key: 'description', val: 'The provider type (cloud, server, or client).' }]) }, rt.ArrayItem{ key: Class_WordPress_AiClient_Providers_DTO_WordPress_AiClient_Providers_DTO_ProviderMetadata.key_credentials_url(), val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'description', val: 'The URL where users can get credentials.' }]) }, rt.ArrayItem{ key: Class_WordPress_AiClient_Providers_DTO_WordPress_AiClient_Providers_DTO_ProviderMetadata.key_authentication_method(), val: rt.create_array([rt.ArrayItem{ key: 'type', val: rt.create_array([rt.ArrayItem{ key: none, val: 'string' }, rt.ArrayItem{ key: none, val: 'null' }]) }, rt.ArrayItem{ key: 'enum', val: rt.call_function('array_merge', [iife_result_1, rt.create_array([rt.ArrayItem{ key: none, val: rt.new_null() }])]) }, rt.ArrayItem{ key: 'description', val: 'The authentication method.' }]) }, rt.ArrayItem{ key: Class_WordPress_AiClient_Providers_DTO_WordPress_AiClient_Providers_DTO_ProviderMetadata.key_logo_path(), val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'description', val: 'The full path to the provider\'s logo image file.' }]) }]) }, rt.ArrayItem{ key: 'required', val: rt.create_array([rt.ArrayItem{ key: none, val: Class_WordPress_AiClient_Providers_DTO_WordPress_AiClient_Providers_DTO_ProviderMetadata.key_id() }, rt.ArrayItem{ key: none, val: Class_WordPress_AiClient_Providers_DTO_WordPress_AiClient_Providers_DTO_ProviderMetadata.key_name() }, rt.ArrayItem{ key: none, val: Class_WordPress_AiClient_Providers_DTO_WordPress_AiClient_Providers_DTO_ProviderMetadata.key_type() }]) }])
}

fn (mut this Class_WordPress_AiClient_Providers_DTO_ProviderMetadata) toarray() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: Class_WordPress_AiClient_Providers_DTO_WordPress_AiClient_Providers_DTO_ProviderMetadata.key_id(), val: this.id }, rt.ArrayItem{ key: Class_WordPress_AiClient_Providers_DTO_WordPress_AiClient_Providers_DTO_ProviderMetadata.key_name(), val: this.name }, rt.ArrayItem{ key: Class_WordPress_AiClient_Providers_DTO_WordPress_AiClient_Providers_DTO_ProviderMetadata.key_description(), val: this.description }, rt.ArrayItem{ key: Class_WordPress_AiClient_Providers_DTO_WordPress_AiClient_Providers_DTO_ProviderMetadata.key_type(), val: rt.get_property(this.prop_type, 'value') }, rt.ArrayItem{ key: Class_WordPress_AiClient_Providers_DTO_WordPress_AiClient_Providers_DTO_ProviderMetadata.key_credentials_url(), val: this.credentialsUrl }, rt.ArrayItem{ key: Class_WordPress_AiClient_Providers_DTO_WordPress_AiClient_Providers_DTO_ProviderMetadata.key_authentication_method(), val: if rt.is_true(this.authenticationMethod) { rt.get_property(this.authenticationMethod, 'value') } else { rt.new_null() } }, rt.ArrayItem{ key: Class_WordPress_AiClient_Providers_DTO_WordPress_AiClient_Providers_DTO_ProviderMetadata.key_logo_path(), val: this.logoPath }])
}

fn Class_WordPress_AiClient_Providers_DTO_ProviderMetadata.fromarray(mut var_array Class_WordPress_AiClient_Providers_DTO_array) rt.PhpVal {
	mut iife_temp_3 := Class_WordPress_AiClient_Providers_DTO_ProviderMetadata{}
	mut iife_result_3 := iife_temp_3.validatefromarraydata(rt.new_object('WordPress_AiClient_Providers_DTO_array', []string{}, var_array), rt.create_array([rt.ArrayItem{ key: none, val: Class_WordPress_AiClient_Providers_DTO_WordPress_AiClient_Providers_DTO_ProviderMetadata.key_id() }, rt.ArrayItem{ key: none, val: Class_WordPress_AiClient_Providers_DTO_WordPress_AiClient_Providers_DTO_ProviderMetadata.key_name() }, rt.ArrayItem{ key: none, val: Class_WordPress_AiClient_Providers_DTO_WordPress_AiClient_Providers_DTO_ProviderMetadata.key_type() }]))
	mut iife_temp_4 := Class_WordPress_AiClient_Providers_Enums_ProviderTypeEnum{}
	mut iife_result_4 := iife_temp_4.from(var_array.array_get(Class_WordPress_AiClient_Providers_DTO_WordPress_AiClient_Providers_DTO_ProviderMetadata.key_type()))
	mut iife_temp_5 := Class_WordPress_AiClient_Providers_Http_Enums_RequestAuthenticationMethod{}
	mut iife_result_5 := iife_temp_5.from(var_array.array_get(Class_WordPress_AiClient_Providers_DTO_WordPress_AiClient_Providers_DTO_ProviderMetadata.key_authentication_method()))
	return rt.new_object('WordPress_AiClient_Providers_DTO_self', []string{}, create_wordpress_aiclient_providers_dto_self(var_array.array_get(Class_WordPress_AiClient_Providers_DTO_WordPress_AiClient_Providers_DTO_ProviderMetadata.key_id()), var_array.array_get(Class_WordPress_AiClient_Providers_DTO_WordPress_AiClient_Providers_DTO_ProviderMetadata.key_name()), iife_result_4, if !(var_array.array_get(Class_WordPress_AiClient_Providers_DTO_WordPress_AiClient_Providers_DTO_ProviderMetadata.key_credentials_url())).is_null() { var_array.array_get(Class_WordPress_AiClient_Providers_DTO_WordPress_AiClient_Providers_DTO_ProviderMetadata.key_credentials_url()) } else { rt.new_null() }, if var_array.array_isset(Class_WordPress_AiClient_Providers_DTO_WordPress_AiClient_Providers_DTO_ProviderMetadata.key_authentication_method()) { iife_result_5 } else { rt.new_null() }, if !(var_array.array_get(Class_WordPress_AiClient_Providers_DTO_WordPress_AiClient_Providers_DTO_ProviderMetadata.key_description())).is_null() { var_array.array_get(Class_WordPress_AiClient_Providers_DTO_WordPress_AiClient_Providers_DTO_ProviderMetadata.key_description()) } else { rt.new_null() }, if !(var_array.array_get(Class_WordPress_AiClient_Providers_DTO_WordPress_AiClient_Providers_DTO_ProviderMetadata.key_logo_path())).is_null() { var_array.array_get(Class_WordPress_AiClient_Providers_DTO_WordPress_AiClient_Providers_DTO_ProviderMetadata.key_logo_path()) } else { rt.new_null() }))
}

struct Class_WordPress_AiClient_Common_AbstractDataTransferObject {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClient_Common_Exception_InvalidArgumentException {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClient_Providers_Enums_ProviderTypeEnum {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClient_Providers_Http_Enums_RequestAuthenticationMethod {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClient_Providers_DTO_self {
	rt.PhpObjectBase
}

fn create_wordpress_aiclient_providers_dto_providermetadata(id string, name string, arg_2 rt.PhpVal, arg_3 rt.PhpVal, arg_4 rt.PhpVal, arg_5 rt.PhpVal, arg_6 rt.PhpVal) &Class_WordPress_AiClient_Providers_DTO_ProviderMetadata {
	mut obj := &Class_WordPress_AiClient_Providers_DTO_ProviderMetadata{
		PhpObjectBase: rt.PhpObjectBase{}
		id: ''
		name: ''
		description: rt.new_null()
		prop_type: rt.new_null()
		credentialsUrl: rt.new_null()
		authenticationMethod: rt.new_null()
		logoPath: rt.new_null()
	}
	obj.construct(id, name, arg_2, arg_3, arg_4, arg_5, arg_6)
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

fn create_wordpress_aiclient_providers_enums_providertypeenum(_args ...rt.PhpVal) &Class_WordPress_AiClient_Providers_Enums_ProviderTypeEnum {
	mut obj := &Class_WordPress_AiClient_Providers_Enums_ProviderTypeEnum{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wordpress_aiclient_providers_http_enums_requestauthenticationmethod(_args ...rt.PhpVal) &Class_WordPress_AiClient_Providers_Http_Enums_RequestAuthenticationMethod {
	mut obj := &Class_WordPress_AiClient_Providers_Http_Enums_RequestAuthenticationMethod{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wordpress_aiclient_providers_dto_self(_args ...rt.PhpVal) &Class_WordPress_AiClient_Providers_DTO_self {
	mut obj := &Class_WordPress_AiClient_Providers_DTO_self{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WordPress_AiClient_Providers_DTO_ProviderMetadata) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_WordPress_AiClient_Providers_Enums_ProviderTypeEnum](if args.len > 2 { args[2] } else { rt.new_null() })
			mut dispatch_arg_3 := rt.cast_object_ptr[Class_WordPress_AiClient_Providers_DTO_?string](if args.len > 3 { args[3] } else { rt.new_null() })
			mut dispatch_arg_4 := rt.cast_object_ptr[Class_WordPress_AiClient_Providers_DTO_?RequestAuthenticationMethod](if args.len > 4 { args[4] } else { rt.new_null() })
			mut dispatch_arg_5 := rt.cast_object_ptr[Class_WordPress_AiClient_Providers_DTO_?string](if args.len > 5 { args[5] } else { rt.new_null() })
			mut dispatch_arg_6 := rt.cast_object_ptr[Class_WordPress_AiClient_Providers_DTO_?string](if args.len > 6 { args[6] } else { rt.new_null() })
			this.construct(dispatch_arg_0, dispatch_arg_1, mut dispatch_arg_2, mut dispatch_arg_3, mut dispatch_arg_4, mut dispatch_arg_5, mut dispatch_arg_6)
			return rt.new_null()
		}
		'getId' {
			return rt.new_string(this.getid())
		}
		'getName' {
			return rt.new_string(this.getname())
		}
		'getDescription' {
			return rt.new_string(this.getdescription())
		}
		'getType' {
			return this.gettype()
		}
		'getCredentialsUrl' {
			return rt.new_string(this.getcredentialsurl())
		}
		'getAuthenticationMethod' {
			return this.getauthenticationmethod()
		}
		'getLogoPath' {
			return rt.new_string(this.getlogopath())
		}
		'getJsonSchema' {
			return Class_WordPress_AiClient_Providers_DTO_ProviderMetadata.getjsonschema()
		}
		'toArray' {
			return this.toarray()
		}
		'fromArray' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WordPress_AiClient_Providers_DTO_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return Class_WordPress_AiClient_Providers_DTO_ProviderMetadata.fromarray(mut dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_WordPress_AiClient_Providers_DTO_ProviderMetadata) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'id' { return rt.new_string(this.id) }
		'name' { return rt.new_string(this.name) }
		'description' { return this.description }
		'type' { return this.prop_type }
		'credentialsUrl' { return this.credentialsUrl }
		'authenticationMethod' { return this.authenticationMethod }
		'logoPath' { return this.logoPath }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WordPress_AiClient_Providers_DTO_ProviderMetadata) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'id' { this.id = (val).str(); return true }
		'name' { this.name = (val).str(); return true }
		'description' { this.description = val; return true }
		'type' { this.prop_type = val; return true }
		'credentialsUrl' { this.credentialsUrl = val; return true }
		'authenticationMethod' { this.authenticationMethod = val; return true }
		'logoPath' { this.logoPath = val; return true }
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


fn (mut this Class_WordPress_AiClient_Providers_Enums_ProviderTypeEnum) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WordPress_AiClient_Providers_Enums_ProviderTypeEnum) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClient_Providers_Enums_ProviderTypeEnum) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WordPress_AiClient_Providers_Http_Enums_RequestAuthenticationMethod) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WordPress_AiClient_Providers_Http_Enums_RequestAuthenticationMethod) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClient_Providers_Http_Enums_RequestAuthenticationMethod) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WordPress_AiClient_Providers_DTO_self) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WordPress_AiClient_Providers_DTO_self) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClient_Providers_DTO_self) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}



fn main() {
	defer {
		rt.shutdown()
	}

}
