import rt

pub fn Class_WordPress_AiClient_Results_DTO_Candidate.key_message() string {
	return 'message'
}
pub fn Class_WordPress_AiClient_Results_DTO_Candidate.key_finish_reason() string {
	return 'finishReason'
}
struct Class_WordPress_AiClient_Results_DTO_Candidate {
	rt.PhpObjectBase
pub mut:
		message rt.PhpVal = rt.new_null()
		finishReason rt.PhpVal = rt.new_null()
}

fn (mut this Class_WordPress_AiClient_Results_DTO_Candidate) construct(mut var_message Class_WordPress_AiClient_Messages_DTO_Message, mut var_finishReason Class_WordPress_AiClient_Results_Enums_FinishReasonEnum)  {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_message.getrole(), 'isModel', []rt.PhpVal{}))))) {
		rt.throw_exception(rt.new_object('WordPress_AiClient_Common_Exception_InvalidArgumentException', []string{}, create_wordpress_aiclient_common_exception_invalidargumentexception(rt.new_string('Message must be a model message.'))))
	}
	this.message = var_message.dup()
	this.finishReason = var_finishReason.dup()
}

fn (mut this Class_WordPress_AiClient_Results_DTO_Candidate) getmessage() rt.PhpVal {
	return this.message
}

fn (mut this Class_WordPress_AiClient_Results_DTO_Candidate) getfinishreason() rt.PhpVal {
	return this.finishReason
}

fn Class_WordPress_AiClient_Results_DTO_Candidate.getjsonschema() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: Class_WordPress_AiClient_Results_DTO_WordPress_AiClient_Results_DTO_Candidate.key_message(), val: fn () rt.PhpVal { mut temp := Class_WordPress_AiClient_Messages_DTO_Message{}; return temp.getjsonschema() }() }, rt.ArrayItem{ key: Class_WordPress_AiClient_Results_DTO_WordPress_AiClient_Results_DTO_Candidate.key_finish_reason(), val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'enum', val: fn () rt.PhpVal { mut temp := Class_WordPress_AiClient_Results_Enums_FinishReasonEnum{}; return temp.getvalues() }() }, rt.ArrayItem{ key: 'description', val: 'The reason generation stopped.' }]) }]) }, rt.ArrayItem{ key: 'required', val: rt.create_array([rt.ArrayItem{ key: none, val: Class_WordPress_AiClient_Results_DTO_WordPress_AiClient_Results_DTO_Candidate.key_message() }, rt.ArrayItem{ key: none, val: Class_WordPress_AiClient_Results_DTO_WordPress_AiClient_Results_DTO_Candidate.key_finish_reason() }]) }])
}

fn (mut this Class_WordPress_AiClient_Results_DTO_Candidate) toarray() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: Class_WordPress_AiClient_Results_DTO_WordPress_AiClient_Results_DTO_Candidate.key_message(), val: rt.call_method(this.message, 'toArray', []rt.PhpVal{}) }, rt.ArrayItem{ key: Class_WordPress_AiClient_Results_DTO_WordPress_AiClient_Results_DTO_Candidate.key_finish_reason(), val: rt.get_property(this.finishReason, 'value') }])
}

fn Class_WordPress_AiClient_Results_DTO_Candidate.fromarray(mut var_array Class_WordPress_AiClient_Results_DTO_array) rt.PhpVal {
	fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_WordPress_AiClient_Results_DTO_Candidate{}; return temp.validatefromarraydata(arg_0, arg_1) }(rt.new_object('WordPress_AiClient_Results_DTO_array', []string{}, var_array), rt.create_array([rt.ArrayItem{ key: none, val: Class_WordPress_AiClient_Results_DTO_WordPress_AiClient_Results_DTO_Candidate.key_message() }, rt.ArrayItem{ key: none, val: Class_WordPress_AiClient_Results_DTO_WordPress_AiClient_Results_DTO_Candidate.key_finish_reason() }]))
	mut var_messageData := var_array.array_get(Class_WordPress_AiClient_Results_DTO_WordPress_AiClient_Results_DTO_Candidate.key_message())
	return create_wordpress_aiclient_results_dto_self(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WordPress_AiClient_Messages_DTO_Message{}; return temp.fromarray(arg_0) }(var_messageData.dup()), fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WordPress_AiClient_Results_Enums_FinishReasonEnum{}; return temp.from(arg_0) }(var_array.array_get(Class_WordPress_AiClient_Results_DTO_WordPress_AiClient_Results_DTO_Candidate.key_finish_reason())))
}

fn (mut this Class_WordPress_AiClient_Results_DTO_Candidate) magic_clone()  {
	this.message = // unsupported expression: Expr_Clone
}

struct Class_WordPress_AiClient_Common_AbstractDataTransferObject {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClient_Common_Exception_InvalidArgumentException {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClient_Messages_DTO_Message {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClient_Results_Enums_FinishReasonEnum {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClient_Results_DTO_self {
	rt.PhpObjectBase
}

fn create_wordpress_aiclient_results_dto_candidate(arg_0 rt.PhpVal, arg_1 rt.PhpVal) &Class_WordPress_AiClient_Results_DTO_Candidate {
	mut obj := &Class_WordPress_AiClient_Results_DTO_Candidate{
		PhpObjectBase: rt.PhpObjectBase{}
		message: rt.new_null()
		finishReason: rt.new_null()
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

fn create_wordpress_aiclient_common_exception_invalidargumentexception() &Class_WordPress_AiClient_Common_Exception_InvalidArgumentException {
	mut obj := &Class_WordPress_AiClient_Common_Exception_InvalidArgumentException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wordpress_aiclient_messages_dto_message() &Class_WordPress_AiClient_Messages_DTO_Message {
	mut obj := &Class_WordPress_AiClient_Messages_DTO_Message{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wordpress_aiclient_results_enums_finishreasonenum() &Class_WordPress_AiClient_Results_Enums_FinishReasonEnum {
	mut obj := &Class_WordPress_AiClient_Results_Enums_FinishReasonEnum{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wordpress_aiclient_results_dto_self() &Class_WordPress_AiClient_Results_DTO_self {
	mut obj := &Class_WordPress_AiClient_Results_DTO_self{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WordPress_AiClient_Results_DTO_Candidate) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WordPress_AiClient_Messages_DTO_Message](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_WordPress_AiClient_Results_Enums_FinishReasonEnum](if args.len > 1 { args[1] } else { rt.new_null() })
			this.construct(mut dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'getMessage' {
			return this.getmessage()
		}
		'getFinishReason' {
			return this.getfinishreason()
		}
		'getJsonSchema' {
			return Class_WordPress_AiClient_Results_DTO_Candidate.getjsonschema()
		}
		'toArray' {
			return this.toarray()
		}
		'fromArray' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WordPress_AiClient_Results_DTO_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return Class_WordPress_AiClient_Results_DTO_Candidate.fromarray(mut dispatch_arg_0)
		}
		'__clone' {
			this.magic_clone()
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_WordPress_AiClient_Results_DTO_Candidate) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'message' { return this.message }
		'finishReason' { return this.finishReason }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WordPress_AiClient_Results_DTO_Candidate) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'message' { this.message = val; return true }
		'finishReason' { this.finishReason = val; return true }
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


fn (mut this Class_WordPress_AiClient_Messages_DTO_Message) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WordPress_AiClient_Messages_DTO_Message) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClient_Messages_DTO_Message) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WordPress_AiClient_Results_Enums_FinishReasonEnum) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WordPress_AiClient_Results_Enums_FinishReasonEnum) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClient_Results_Enums_FinishReasonEnum) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WordPress_AiClient_Results_DTO_self) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WordPress_AiClient_Results_DTO_self) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClient_Results_DTO_self) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_includes_php_ai_client_src_results_dto_candidate_php() {
	// unsupported statement: Stmt_Declare
}
