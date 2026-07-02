import rt

pub fn Class_WordPress_AiClient_Messages_Enums_ModalityEnum.text() string {
	return 'text'
}

pub fn Class_WordPress_AiClient_Messages_Enums_ModalityEnum.document() string {
	return 'document'
}

pub fn Class_WordPress_AiClient_Messages_Enums_ModalityEnum.image() string {
	return 'image'
}

pub fn Class_WordPress_AiClient_Messages_Enums_ModalityEnum.audio() string {
	return 'audio'
}

pub fn Class_WordPress_AiClient_Messages_Enums_ModalityEnum.video() string {
	return 'video'
}

struct Class_WordPress_AiClient_Messages_Enums_ModalityEnum {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClient_Common_AbstractEnum {
	rt.PhpObjectBase
}

fn create_wordpress_aiclient_messages_enums_modalityenum(_args ...rt.PhpVal) &Class_WordPress_AiClient_Messages_Enums_ModalityEnum {
	mut obj := &Class_WordPress_AiClient_Messages_Enums_ModalityEnum{
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

fn (mut this Class_WordPress_AiClient_Messages_Enums_ModalityEnum) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WordPress_AiClient_Messages_Enums_ModalityEnum) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClient_Messages_Enums_ModalityEnum) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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
