import rt

pub fn Class_WordPress_AiClient_Messages_DTO_Message.key_role() string {
	return 'role'
}
pub fn Class_WordPress_AiClient_Messages_DTO_Message.key_parts() string {
	return 'parts'
}
struct Class_WordPress_AiClient_Messages_DTO_Message {
	rt.PhpObjectBase
pub mut:
		role rt.PhpVal = rt.new_null()
		parts rt.PhpVal = rt.new_null()
}

fn (mut this Class_WordPress_AiClient_Messages_DTO_Message) construct(mut var_role Class_WordPress_AiClient_Messages_Enums_MessageRoleEnum, mut var_parts Class_WordPress_AiClient_Messages_DTO_array)  {
	mut var_role_mutated := var_role
	mut var_parts_mutated := var_parts
	this.role = var_role_mutated.dup()
	this.parts = var_parts_mutated.dup()
	this.validateparts()
}

fn (mut this Class_WordPress_AiClient_Messages_DTO_Message) getrole() rt.PhpVal {
	return this.role
}

fn (mut this Class_WordPress_AiClient_Messages_DTO_Message) getparts() rt.PhpVal {
	return this.parts
}

fn (mut this Class_WordPress_AiClient_Messages_DTO_Message) withpart(mut var_part Class_WordPress_AiClient_Messages_DTO_WordPress_AiClient_Messages_DTO_MessagePart) rt.PhpVal {
	mut var_newParts := this.parts
	var_newParts.array_push(var_part.dup())
	return create_wordpress_aiclient_messages_dto_wordpress_aiclient_messages_dto_message(this.role, var_newParts.dup())
}

fn (mut this Class_WordPress_AiClient_Messages_DTO_Message) validateparts()  {
	{
		mut iter_1 := this.parts.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_part := item_1.val
			mut var_type := rt.call_method(var_part, 'getType', []rt.PhpVal{})
			if rt.is_true(rt.new_bool(rt.is_true(rt.call_method(this.role, 'isUser', []rt.PhpVal{})) && rt.is_true(rt.call_method(var_type, 'isFunctionCall', []rt.PhpVal{})))) {
				rt.throw_exception(rt.new_object('WordPress_AiClient_Common_Exception_InvalidArgumentException', []string{}, create_wordpress_aiclient_common_exception_invalidargumentexception(rt.new_string('User messages cannot contain function calls.'))))
			}
			if rt.is_true(rt.new_bool(rt.is_true(rt.call_method(this.role, 'isModel', []rt.PhpVal{})) && rt.is_true(rt.call_method(var_type, 'isFunctionResponse', []rt.PhpVal{})))) {
				rt.throw_exception(rt.new_object('WordPress_AiClient_Common_Exception_InvalidArgumentException', []string{}, create_wordpress_aiclient_common_exception_invalidargumentexception(rt.new_string('Model messages cannot contain function responses.'))))
			}
		}
	}
}

fn Class_WordPress_AiClient_Messages_DTO_Message.getjsonschema() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: Class_WordPress_AiClient_Messages_DTO_WordPress_AiClient_Messages_DTO_Message.key_role(), val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'enum', val: fn () rt.PhpVal { mut temp := Class_WordPress_AiClient_Messages_Enums_MessageRoleEnum{}; return temp.getvalues() }() }, rt.ArrayItem{ key: 'description', val: 'The role of the message sender.' }]) }, rt.ArrayItem{ key: Class_WordPress_AiClient_Messages_DTO_WordPress_AiClient_Messages_DTO_Message.key_parts(), val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'array' }, rt.ArrayItem{ key: 'items', val: fn () rt.PhpVal { mut temp := Class_WordPress_AiClient_Messages_DTO_WordPress_AiClient_Messages_DTO_MessagePart{}; return temp.getjsonschema() }() }, rt.ArrayItem{ key: 'minItems', val: 1 }, rt.ArrayItem{ key: 'description', val: 'The parts that make up this message.' }]) }]) }, rt.ArrayItem{ key: 'required', val: rt.create_array([rt.ArrayItem{ key: none, val: Class_WordPress_AiClient_Messages_DTO_WordPress_AiClient_Messages_DTO_Message.key_role() }, rt.ArrayItem{ key: none, val: Class_WordPress_AiClient_Messages_DTO_WordPress_AiClient_Messages_DTO_Message.key_parts() }]) }])
}

fn (mut this Class_WordPress_AiClient_Messages_DTO_Message) toarray() rt.PhpVal {
	closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_part := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return var_part.toarray()
	}
	mut var_part := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return var_part.toarray()
	}
	return rt.create_array([rt.ArrayItem{ key: Class_WordPress_AiClient_Messages_DTO_WordPress_AiClient_Messages_DTO_Message.key_role(), val: rt.get_property(this.role, 'value') }, rt.ArrayItem{ key: Class_WordPress_AiClient_Messages_DTO_WordPress_AiClient_Messages_DTO_Message.key_parts(), val: rt.call_function('array_map', [rt.new_closure(closure_1_fn), this.parts]) }])
}

fn Class_WordPress_AiClient_Messages_DTO_Message.fromarray(mut var_array Class_WordPress_AiClient_Messages_DTO_array) rt.PhpVal {
	fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_WordPress_AiClient_Messages_DTO_Message{}; return temp.validatefromarraydata(arg_0, arg_1) }(rt.new_object('WordPress_AiClient_Messages_DTO_array', []string{}, var_array), rt.create_array([rt.ArrayItem{ key: none, val: Class_WordPress_AiClient_Messages_DTO_WordPress_AiClient_Messages_DTO_Message.key_role() }, rt.ArrayItem{ key: none, val: Class_WordPress_AiClient_Messages_DTO_WordPress_AiClient_Messages_DTO_Message.key_parts() }]))
	mut var_role := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WordPress_AiClient_Messages_Enums_MessageRoleEnum{}; return temp.from(arg_0) }(var_array.array_get(Class_WordPress_AiClient_Messages_DTO_WordPress_AiClient_Messages_DTO_Message.key_role()))
	mut var_partsData := var_array.array_get(Class_WordPress_AiClient_Messages_DTO_WordPress_AiClient_Messages_DTO_Message.key_parts())
	closure_4_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_3_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_partData := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WordPress_AiClient_Messages_DTO_WordPress_AiClient_Messages_DTO_MessagePart{}; return temp.fromarray(arg_0) }(var_partData.dup())
	}
	mut var_partData := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WordPress_AiClient_Messages_DTO_WordPress_AiClient_Messages_DTO_MessagePart{}; return temp.fromarray(arg_0) }(var_partData.dup())
	}
	mut var_parts := rt.call_function('array_map', [rt.new_closure(closure_3_fn), var_partsData.dup()])
	if rt.is_true(rt.call_method(var_role, 'isUser', []rt.PhpVal{})) {
		return create_wordpress_aiclient_messages_dto_wordpress_aiclient_messages_dto_usermessage(var_parts.dup())
	} else if rt.is_true(rt.call_method(var_role, 'isModel', []rt.PhpVal{})) {
		return create_wordpress_aiclient_messages_dto_wordpress_aiclient_messages_dto_modelmessage(var_parts.dup())
	} else {
		rt.throw_exception(rt.new_object('WordPress_AiClient_Common_Exception_InvalidArgumentException', []string{}, create_wordpress_aiclient_common_exception_invalidargumentexception('Invalid message role: ' + (rt.get_property(var_role, 'value')).str())))
	}
	return rt.new_null()
}

fn (mut this Class_WordPress_AiClient_Messages_DTO_Message) magic_clone()  {
	mut var_clonedParts := rt.new_array()
	{
		mut iter_1 := this.parts.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_part := item_1.val
			var_clonedParts.array_push(// unsupported expression: Expr_Clone)
		}
	}
	this.parts = var_clonedParts.dup()
}

struct Class_WordPress_AiClient_Common_AbstractDataTransferObject {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClient_Messages_DTO_WordPress_AiClient_Messages_DTO_Message {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClient_Common_Exception_InvalidArgumentException {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClient_Messages_Enums_MessageRoleEnum {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClient_Messages_DTO_WordPress_AiClient_Messages_DTO_MessagePart {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClient_Messages_DTO_WordPress_AiClient_Messages_DTO_UserMessage {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClient_Messages_DTO_WordPress_AiClient_Messages_DTO_ModelMessage {
	rt.PhpObjectBase
}

fn create_wordpress_aiclient_messages_dto_message(arg_0 rt.PhpVal, arg_1 rt.PhpVal) &Class_WordPress_AiClient_Messages_DTO_Message {
	mut obj := &Class_WordPress_AiClient_Messages_DTO_Message{
		PhpObjectBase: rt.PhpObjectBase{}
		role: rt.new_null()
		parts: rt.new_null()
	}
	obj.construct(arg_0, arg_1)
	return obj
}

fn create_wordpress_aiclient_common_abstractdatatransferobject() &Class_WordPress_AiClient_Common_AbstractDataTransferObject {
	mut obj := &Class_WordPress_AiClient_Common_AbstractDataTransferObject{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wordpress_aiclient_messages_dto_wordpress_aiclient_messages_dto_message() &Class_WordPress_AiClient_Messages_DTO_WordPress_AiClient_Messages_DTO_Message {
	mut obj := &Class_WordPress_AiClient_Messages_DTO_WordPress_AiClient_Messages_DTO_Message{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wordpress_aiclient_common_exception_invalidargumentexception() &Class_WordPress_AiClient_Common_Exception_InvalidArgumentException {
	mut obj := &Class_WordPress_AiClient_Common_Exception_InvalidArgumentException{
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

fn create_wordpress_aiclient_messages_dto_wordpress_aiclient_messages_dto_messagepart() &Class_WordPress_AiClient_Messages_DTO_WordPress_AiClient_Messages_DTO_MessagePart {
	mut obj := &Class_WordPress_AiClient_Messages_DTO_WordPress_AiClient_Messages_DTO_MessagePart{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wordpress_aiclient_messages_dto_wordpress_aiclient_messages_dto_usermessage() &Class_WordPress_AiClient_Messages_DTO_WordPress_AiClient_Messages_DTO_UserMessage {
	mut obj := &Class_WordPress_AiClient_Messages_DTO_WordPress_AiClient_Messages_DTO_UserMessage{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wordpress_aiclient_messages_dto_wordpress_aiclient_messages_dto_modelmessage() &Class_WordPress_AiClient_Messages_DTO_WordPress_AiClient_Messages_DTO_ModelMessage {
	mut obj := &Class_WordPress_AiClient_Messages_DTO_WordPress_AiClient_Messages_DTO_ModelMessage{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WordPress_AiClient_Messages_DTO_Message) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WordPress_AiClient_Messages_Enums_MessageRoleEnum](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_WordPress_AiClient_Messages_DTO_array](if args.len > 1 { args[1] } else { rt.new_null() })
			this.construct(mut dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'getRole' {
			return this.getrole()
		}
		'getParts' {
			return this.getparts()
		}
		'withPart' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WordPress_AiClient_Messages_DTO_WordPress_AiClient_Messages_DTO_MessagePart](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.withpart(mut dispatch_arg_0)
		}
		'validateParts' {
			this.validateparts()
			return rt.new_null()
		}
		'getJsonSchema' {
			return Class_WordPress_AiClient_Messages_DTO_Message.getjsonschema()
		}
		'toArray' {
			return this.toarray()
		}
		'fromArray' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WordPress_AiClient_Messages_DTO_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return Class_WordPress_AiClient_Messages_DTO_Message.fromarray(mut dispatch_arg_0)
		}
		'__clone' {
			this.magic_clone()
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_WordPress_AiClient_Messages_DTO_Message) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'role' { return this.role }
		'parts' { return this.parts }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WordPress_AiClient_Messages_DTO_Message) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'role' { this.role = val; return true }
		'parts' { this.parts = val; return true }
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


fn (mut this Class_WordPress_AiClient_Messages_DTO_WordPress_AiClient_Messages_DTO_Message) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WordPress_AiClient_Messages_DTO_WordPress_AiClient_Messages_DTO_Message) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClient_Messages_DTO_WordPress_AiClient_Messages_DTO_Message) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_WordPress_AiClient_Messages_Enums_MessageRoleEnum) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WordPress_AiClient_Messages_Enums_MessageRoleEnum) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClient_Messages_Enums_MessageRoleEnum) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WordPress_AiClient_Messages_DTO_WordPress_AiClient_Messages_DTO_MessagePart) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WordPress_AiClient_Messages_DTO_WordPress_AiClient_Messages_DTO_MessagePart) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClient_Messages_DTO_WordPress_AiClient_Messages_DTO_MessagePart) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WordPress_AiClient_Messages_DTO_WordPress_AiClient_Messages_DTO_UserMessage) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WordPress_AiClient_Messages_DTO_WordPress_AiClient_Messages_DTO_UserMessage) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClient_Messages_DTO_WordPress_AiClient_Messages_DTO_UserMessage) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WordPress_AiClient_Messages_DTO_WordPress_AiClient_Messages_DTO_ModelMessage) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WordPress_AiClient_Messages_DTO_WordPress_AiClient_Messages_DTO_ModelMessage) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClient_Messages_DTO_WordPress_AiClient_Messages_DTO_ModelMessage) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_includes_php_ai_client_src_messages_dto_message_php() {
	// unsupported statement: Stmt_Declare
}
