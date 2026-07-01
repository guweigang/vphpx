import rt

pub fn Class_WordPress_AiClient_Providers_Http_Enums_RequestAuthenticationMethod.api_key() string {
	return 'api_key'
}

struct Class_WordPress_AiClient_Providers_Http_Enums_RequestAuthenticationMethod {
	rt.PhpObjectBase
}

fn (mut this Class_WordPress_AiClient_Providers_Http_Enums_RequestAuthenticationMethod) getimplementationclass() string {
	return (Class_WordPress_AiClient_Providers_Http_DTO_ApiKeyRequestAuthentication.class()).str()
}

struct Class_WordPress_AiClient_Common_AbstractEnum {
	rt.PhpObjectBase
}

fn create_wordpress_aiclient_providers_http_enums_requestauthenticationmethod() &Class_WordPress_AiClient_Providers_Http_Enums_RequestAuthenticationMethod {
	mut obj := &Class_WordPress_AiClient_Providers_Http_Enums_RequestAuthenticationMethod{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wordpress_aiclient_common_abstractenum() &Class_WordPress_AiClient_Common_AbstractEnum {
	mut obj := &Class_WordPress_AiClient_Common_AbstractEnum{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WordPress_AiClient_Providers_Http_Enums_RequestAuthenticationMethod) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'getImplementationClass' {
			return rt.new_string(this.getimplementationclass())
		}
		else {
			return none
		}
	}
}

fn (this &Class_WordPress_AiClient_Providers_Http_Enums_RequestAuthenticationMethod) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClient_Providers_Http_Enums_RequestAuthenticationMethod) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

pub fn init_wp_includes_php_ai_client_src_providers_http_enums_requestauthenticationmethod_php() {
	// unsupported statement: Stmt_Declare
}
