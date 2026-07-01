import rt

struct Class_WordPress_AiClient_Messages_DTO_ModelMessage {
	rt.PhpObjectBase
}

fn (mut this Class_WordPress_AiClient_Messages_DTO_ModelMessage) construct(mut var_parts Class_WordPress_AiClient_Messages_DTO_array) {
	this.Class_WordPress_AiClient_Messages_DTO_WordPress_AiClient_Messages_DTO_Message.construct(fn () rt.PhpVal {
		mut temp := Class_WordPress_AiClient_Messages_Enums_MessageRoleEnum{}
		return temp.model()
	}(), rt.new_object('WordPress_AiClient_Messages_DTO_array', []string{}, var_parts))
}

struct Class_WordPress_AiClient_Messages_DTO_WordPress_AiClient_Messages_DTO_Message {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClient_Messages_Enums_MessageRoleEnum {
	rt.PhpObjectBase
}

fn create_wordpress_aiclient_messages_dto_modelmessage(arg_0 rt.PhpVal) &Class_WordPress_AiClient_Messages_DTO_ModelMessage {
	mut obj := &Class_WordPress_AiClient_Messages_DTO_ModelMessage{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	obj.construct(arg_0)
	return obj
}

fn create_wordpress_aiclient_messages_dto_wordpress_aiclient_messages_dto_message() &Class_WordPress_AiClient_Messages_DTO_WordPress_AiClient_Messages_DTO_Message {
	mut obj := &Class_WordPress_AiClient_Messages_DTO_WordPress_AiClient_Messages_DTO_Message{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wordpress_aiclient_messages_enums_messageroleenum() &Class_WordPress_AiClient_Messages_Enums_MessageRoleEnum {
	mut obj := &Class_WordPress_AiClient_Messages_Enums_MessageRoleEnum{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WordPress_AiClient_Messages_DTO_ModelMessage) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WordPress_AiClient_Messages_DTO_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.construct(mut dispatch_arg_0)
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WordPress_AiClient_Messages_DTO_ModelMessage) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClient_Messages_DTO_ModelMessage) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WordPress_AiClient_Messages_DTO_WordPress_AiClient_Messages_DTO_Message) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WordPress_AiClient_Messages_DTO_WordPress_AiClient_Messages_DTO_Message) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClient_Messages_DTO_WordPress_AiClient_Messages_DTO_Message) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WordPress_AiClient_Messages_Enums_MessageRoleEnum) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WordPress_AiClient_Messages_Enums_MessageRoleEnum) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClient_Messages_Enums_MessageRoleEnum) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_includes_php_ai_client_src_messages_dto_modelmessage_php() {
	// unsupported statement: Stmt_Declare
}
