import rt

pub fn Class_WordPress_AiClient_Providers_Enums_ProviderTypeEnum.cloud() string {
	return 'cloud'
}

pub fn Class_WordPress_AiClient_Providers_Enums_ProviderTypeEnum.server() string {
	return 'server'
}

pub fn Class_WordPress_AiClient_Providers_Enums_ProviderTypeEnum.client() string {
	return 'client'
}

struct Class_WordPress_AiClient_Providers_Enums_ProviderTypeEnum {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClient_Common_AbstractEnum {
	rt.PhpObjectBase
}

fn create_wordpress_aiclient_providers_enums_providertypeenum() &Class_WordPress_AiClient_Providers_Enums_ProviderTypeEnum {
	mut obj := &Class_WordPress_AiClient_Providers_Enums_ProviderTypeEnum{
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

fn (mut this Class_WordPress_AiClient_Providers_Enums_ProviderTypeEnum) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WordPress_AiClient_Providers_Enums_ProviderTypeEnum) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClient_Providers_Enums_ProviderTypeEnum) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

pub fn init_wp_includes_php_ai_client_src_providers_enums_providertypeenum_php() {
	// unsupported statement: Stmt_Declare
}
