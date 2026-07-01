import rt

pub fn Class_WordPress_AiClient_Providers_Models_Enums_CapabilityEnum.text_generation() string {
	return 'text_generation'
}

pub fn Class_WordPress_AiClient_Providers_Models_Enums_CapabilityEnum.image_generation() string {
	return 'image_generation'
}

pub fn Class_WordPress_AiClient_Providers_Models_Enums_CapabilityEnum.text_to_speech_conversion() string {
	return 'text_to_speech_conversion'
}

pub fn Class_WordPress_AiClient_Providers_Models_Enums_CapabilityEnum.speech_generation() string {
	return 'speech_generation'
}

pub fn Class_WordPress_AiClient_Providers_Models_Enums_CapabilityEnum.music_generation() string {
	return 'music_generation'
}

pub fn Class_WordPress_AiClient_Providers_Models_Enums_CapabilityEnum.video_generation() string {
	return 'video_generation'
}

pub fn Class_WordPress_AiClient_Providers_Models_Enums_CapabilityEnum.embedding_generation() string {
	return 'embedding_generation'
}

pub fn Class_WordPress_AiClient_Providers_Models_Enums_CapabilityEnum.chat_history() string {
	return 'chat_history'
}

struct Class_WordPress_AiClient_Providers_Models_Enums_CapabilityEnum {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClient_Common_AbstractEnum {
	rt.PhpObjectBase
}

fn create_wordpress_aiclient_providers_models_enums_capabilityenum() &Class_WordPress_AiClient_Providers_Models_Enums_CapabilityEnum {
	mut obj := &Class_WordPress_AiClient_Providers_Models_Enums_CapabilityEnum{
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

fn (mut this Class_WordPress_AiClient_Providers_Models_Enums_CapabilityEnum) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WordPress_AiClient_Providers_Models_Enums_CapabilityEnum) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClient_Providers_Models_Enums_CapabilityEnum) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

pub fn init_wp_includes_php_ai_client_src_providers_models_enums_capabilityenum_php() {
	// unsupported statement: Stmt_Declare
}
