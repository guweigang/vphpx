import rt

struct Class_WordPress_AiClient_Builders_MessageBuilder {
	rt.PhpObjectBase
pub mut:
		role rt.PhpVal = rt.new_null()
		parts rt.PhpVal = rt.new_array()
}

fn (mut this Class_WordPress_AiClient_Builders_MessageBuilder) construct(var_input rt.PhpVal, mut var_role Class_WordPress_AiClient_Builders_?MessageRoleEnum) {
	mut var_role_mutated := var_role
	this.role = var_role_mutated
	if rt.is_true(rt.identical(var_input, rt.new_null())) {
		return
	}
	if rt.is_true(rt.new_bool(rt.instance_of(var_input, 'WordPress_AiClient_Messages_DTO_MessagePart'))) {
		this.parts.array_push(var_input.clone())
	} else if rt.is_true(rt.new_bool(var_input.clone().is_string())) {
		this.withtext((var_input).str())
	} else if rt.is_true(rt.new_bool(rt.instance_of(var_input, 'WordPress_AiClient_Files_DTO_File'))) {
		this.withfile(var_input.clone(), rt.new_null())
	} else if rt.is_true(rt.new_bool(rt.instance_of(var_input, 'WordPress_AiClient_Tools_DTO_FunctionCall'))) {
		this.withfunctioncall(mut rt.cast_object_ptr[Class_WordPress_AiClient_Tools_DTO_FunctionCall](var_input))
	} else if rt.is_true(rt.new_bool(rt.instance_of(var_input, 'WordPress_AiClient_Tools_DTO_FunctionResponse'))) {
		this.withfunctionresponse(mut rt.cast_object_ptr[Class_WordPress_AiClient_Tools_DTO_FunctionResponse](var_input))
	mut iife_temp_0 := Class_WordPress_AiClient_Messages_DTO_MessagePart{}
	mut iife_result_0 := iife_temp_0.isarrayshape(var_input.clone())
	} else if var_input.clone().is_array() && rt.is_true(iife_result_0) {
		mut iife_temp_1 := Class_WordPress_AiClient_Messages_DTO_MessagePart{}
		mut iife_result_1 := iife_temp_1.fromarray(var_input.clone())
		this.parts.array_push(iife_result_1)
	} else {
		rt.throw_exception(rt.new_object('InvalidArgumentException', []string{}, create_invalidargumentexception(rt.new_string('Input must be a string, MessagePart, MessagePartArrayShape, File, FunctionCall, or FunctionResponse.'))))
	}
}

fn (mut this Class_WordPress_AiClient_Builders_MessageBuilder) magic_clone() {
	mut var_clonedParts := rt.new_array()
	mut iter_1 := this.parts.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_part := item_1.val
		var_clonedParts.array_push(var_part.dup())
	}
	this.parts = var_clonedParts.clone()
}

fn (mut this Class_WordPress_AiClient_Builders_MessageBuilder) usingrole(mut var_role Class_WordPress_AiClient_Messages_Enums_MessageRoleEnum) rt.PhpVal {
	mut var_role_mutated := var_role
	this.role = var_role_mutated
	return rt.new_object('WordPress_AiClient_Builders_MessageBuilder', []string{}, this)
}

fn (mut this Class_WordPress_AiClient_Builders_MessageBuilder) usinguserrole() rt.PhpVal {
	mut iife_temp_2 := Class_WordPress_AiClient_Messages_Enums_MessageRoleEnum{}
	mut iife_result_2 := iife_temp_2.user()
	return this.usingrole(mut rt.cast_object_ptr[Class_WordPress_AiClient_Messages_Enums_MessageRoleEnum](iife_result_2))
}

fn (mut this Class_WordPress_AiClient_Builders_MessageBuilder) usingmodelrole() rt.PhpVal {
	mut iife_temp_3 := Class_WordPress_AiClient_Messages_Enums_MessageRoleEnum{}
	mut iife_result_3 := iife_temp_3.model()
	return this.usingrole(mut rt.cast_object_ptr[Class_WordPress_AiClient_Messages_Enums_MessageRoleEnum](iife_result_3))
}

fn (mut this Class_WordPress_AiClient_Builders_MessageBuilder) withtext(text string) rt.PhpVal {
	if rt.is_true(rt.identical(rt.new_string(text.trim_space()), rt.new_string(''))) {
		rt.throw_exception(rt.new_object('InvalidArgumentException', []string{}, create_invalidargumentexception(rt.new_string('Text content cannot be empty.'))))
	}
	this.parts.array_push(create_wordpress_aiclient_messages_dto_messagepart(rt.new_string(text)))
	return rt.new_object('WordPress_AiClient_Builders_MessageBuilder', []string{}, this)
}

fn (mut this Class_WordPress_AiClient_Builders_MessageBuilder) withfile(var_file rt.PhpVal, mut var_mimeType Class_WordPress_AiClient_Builders_?string) rt.PhpVal {
	mut var_file_mutated := var_file
	var_file_mutated = if rt.is_true(rt.new_bool(rt.instance_of(var_file_mutated, 'WordPress_AiClient_Files_DTO_File'))) { var_file_mutated } else { create_wordpress_aiclient_files_dto_file(var_file_mutated.clone(), var_mimeType) }
	this.parts.array_push(create_wordpress_aiclient_messages_dto_messagepart(var_file_mutated.clone()))
	return rt.new_object('WordPress_AiClient_Builders_MessageBuilder', []string{}, this)
}

fn (mut this Class_WordPress_AiClient_Builders_MessageBuilder) withfunctioncall(mut var_functionCall Class_WordPress_AiClient_Tools_DTO_FunctionCall) rt.PhpVal {
	this.parts.array_push(create_wordpress_aiclient_messages_dto_messagepart(var_functionCall))
	return rt.new_object('WordPress_AiClient_Builders_MessageBuilder', []string{}, this)
}

fn (mut this Class_WordPress_AiClient_Builders_MessageBuilder) withfunctionresponse(mut var_functionResponse Class_WordPress_AiClient_Tools_DTO_FunctionResponse) rt.PhpVal {
	this.parts.array_push(create_wordpress_aiclient_messages_dto_messagepart(var_functionResponse))
	return rt.new_object('WordPress_AiClient_Builders_MessageBuilder', []string{}, this)
}

fn (mut this Class_WordPress_AiClient_Builders_MessageBuilder) withmessageparts(mut var_parts Class_WordPress_AiClient_Messages_DTO_MessagePart) rt.PhpVal {
	mut iter_2 := var_parts.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_part := item_2.val
		this.parts.array_push(var_part.clone())
	}
	return rt.new_object('WordPress_AiClient_Builders_MessageBuilder', []string{}, this)
}

fn (mut this Class_WordPress_AiClient_Builders_MessageBuilder) get() rt.PhpVal {
	if !rt.is_true(this.parts) {
		rt.throw_exception(rt.new_object('InvalidArgumentException', []string{}, create_invalidargumentexception(rt.new_string('Cannot build an empty message. Add content using withText() or similar methods.'))))
	}
	if rt.is_true(rt.identical(this.role, rt.new_null())) {
		rt.throw_exception(rt.new_object('InvalidArgumentException', []string{}, create_invalidargumentexception(rt.new_string('Cannot build a message with no role. Set a role using usingRole() or similar methods.'))))
	}
	mut var_role := this.role
	return rt.new_object('WordPress_AiClient_Messages_DTO_Message', []string{}, create_wordpress_aiclient_messages_dto_message(var_role.clone(), this.parts))
}

struct Class_WordPress_AiClient_Messages_DTO_MessagePart {
	rt.PhpObjectBase
}

struct Class_InvalidArgumentException {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClient_Messages_Enums_MessageRoleEnum {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClient_Files_DTO_File {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClient_Messages_DTO_Message {
	rt.PhpObjectBase
}

fn create_wordpress_aiclient_builders_messagebuilder(arg_0 rt.PhpVal, arg_1 rt.PhpVal) &Class_WordPress_AiClient_Builders_MessageBuilder {
	mut obj := &Class_WordPress_AiClient_Builders_MessageBuilder{
		PhpObjectBase: rt.PhpObjectBase{}
		role: rt.new_null()
		parts: rt.new_array()
	}
	obj.construct(arg_0, arg_1)
	return obj
}

fn create_wordpress_aiclient_messages_dto_messagepart(_args ...rt.PhpVal) &Class_WordPress_AiClient_Messages_DTO_MessagePart {
	mut obj := &Class_WordPress_AiClient_Messages_DTO_MessagePart{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_invalidargumentexception(_args ...rt.PhpVal) &Class_InvalidArgumentException {
	mut obj := &Class_InvalidArgumentException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wordpress_aiclient_messages_enums_messageroleenum(_args ...rt.PhpVal) &Class_WordPress_AiClient_Messages_Enums_MessageRoleEnum {
	mut obj := &Class_WordPress_AiClient_Messages_Enums_MessageRoleEnum{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wordpress_aiclient_files_dto_file(_args ...rt.PhpVal) &Class_WordPress_AiClient_Files_DTO_File {
	mut obj := &Class_WordPress_AiClient_Files_DTO_File{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wordpress_aiclient_messages_dto_message(_args ...rt.PhpVal) &Class_WordPress_AiClient_Messages_DTO_Message {
	mut obj := &Class_WordPress_AiClient_Messages_DTO_Message{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WordPress_AiClient_Builders_MessageBuilder) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_WordPress_AiClient_Builders_?MessageRoleEnum](if args.len > 1 { args[1] } else { rt.new_null() })
			this.construct(dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'__clone' {
			this.magic_clone()
			return rt.new_null()
		}
		'usingRole' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WordPress_AiClient_Messages_Enums_MessageRoleEnum](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.usingrole(mut dispatch_arg_0)
		}
		'usingUserRole' {
			return this.usinguserrole()
		}
		'usingModelRole' {
			return this.usingmodelrole()
		}
		'withText' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.withtext(dispatch_arg_0)
		}
		'withFile' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_WordPress_AiClient_Builders_?string](if args.len > 1 { args[1] } else { rt.new_null() })
			return this.withfile(dispatch_arg_0, mut dispatch_arg_1)
		}
		'withFunctionCall' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WordPress_AiClient_Tools_DTO_FunctionCall](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.withfunctioncall(mut dispatch_arg_0)
		}
		'withFunctionResponse' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WordPress_AiClient_Tools_DTO_FunctionResponse](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.withfunctionresponse(mut dispatch_arg_0)
		}
		'withMessageParts' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WordPress_AiClient_Messages_DTO_MessagePart](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.withmessageparts(mut dispatch_arg_0)
		}
		'get' {
			return this.get()
		}
		else { return none }
	}
}

fn (this &Class_WordPress_AiClient_Builders_MessageBuilder) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'role' { return this.role }
		'parts' { return this.parts }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WordPress_AiClient_Builders_MessageBuilder) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'role' { this.role = val; return true }
		'parts' { this.parts = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_WordPress_AiClient_Messages_DTO_MessagePart) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WordPress_AiClient_Messages_DTO_MessagePart) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClient_Messages_DTO_MessagePart) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_InvalidArgumentException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_InvalidArgumentException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_InvalidArgumentException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_WordPress_AiClient_Files_DTO_File) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WordPress_AiClient_Files_DTO_File) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClient_Files_DTO_File) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WordPress_AiClient_Messages_DTO_Message) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WordPress_AiClient_Messages_DTO_Message) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClient_Messages_DTO_Message) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}



fn main() {
	defer {
		rt.shutdown()
	}

}
