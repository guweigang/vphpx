import rt

pub fn Class_WordPress_AiClient_Messages_Enums_MessagePartTypeEnum.text() string {
	return 'text'
}

pub fn Class_WordPress_AiClient_Messages_Enums_MessagePartTypeEnum.file() string {
	return 'file'
}

pub fn Class_WordPress_AiClient_Messages_Enums_MessagePartTypeEnum.function_call() string {
	return 'function_call'
}

pub fn Class_WordPress_AiClient_Messages_Enums_MessagePartTypeEnum.function_response() string {
	return 'function_response'
}

struct Class_WordPress_AiClient_Messages_Enums_MessagePartTypeEnum {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClient_Common_AbstractEnum {
	rt.PhpObjectBase
}

fn create_wordpress_aiclient_messages_enums_messageparttypeenum(_args ...rt.PhpVal) &Class_WordPress_AiClient_Messages_Enums_MessagePartTypeEnum {
	mut obj := &Class_WordPress_AiClient_Messages_Enums_MessagePartTypeEnum{
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

fn (mut this Class_WordPress_AiClient_Messages_Enums_MessagePartTypeEnum) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WordPress_AiClient_Messages_Enums_MessagePartTypeEnum) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClient_Messages_Enums_MessagePartTypeEnum) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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
