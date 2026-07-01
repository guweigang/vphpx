import rt

struct Class_WordPress_AiClient_Events_AfterGenerateResultEvent {
	rt.PhpObjectBase
pub mut:
		messages rt.PhpVal = rt.new_null()
		model rt.PhpVal = rt.new_null()
		capability rt.PhpVal = rt.new_null()
		result rt.PhpVal = rt.new_null()
}

fn (mut this Class_WordPress_AiClient_Events_AfterGenerateResultEvent) construct(mut var_messages Class_WordPress_AiClient_Events_array, mut var_model Class_WordPress_AiClient_Providers_Models_Contracts_ModelInterface, mut var_capability Class_WordPress_AiClient_Events_?CapabilityEnum, mut var_result Class_WordPress_AiClient_Results_DTO_GenerativeAiResult)  {
	this.messages = var_messages.dup()
	this.model = var_model.dup()
	this.capability = var_capability.dup()
	this.result = var_result.dup()
}

fn (mut this Class_WordPress_AiClient_Events_AfterGenerateResultEvent) getmessages() rt.PhpVal {
	return this.messages
}

fn (mut this Class_WordPress_AiClient_Events_AfterGenerateResultEvent) getmodel() rt.PhpVal {
	return this.model
}

fn (mut this Class_WordPress_AiClient_Events_AfterGenerateResultEvent) getcapability() rt.PhpVal {
	return this.capability
}

fn (mut this Class_WordPress_AiClient_Events_AfterGenerateResultEvent) getresult() rt.PhpVal {
	return this.result
}

fn (mut this Class_WordPress_AiClient_Events_AfterGenerateResultEvent) magic_clone()  {
	mut var_clonedMessages := rt.new_array()
	{
		mut iter_1 := this.messages.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_message := item_1.val
			var_clonedMessages.array_push(// unsupported expression: Expr_Clone)
		}
	}
	this.messages = var_clonedMessages.dup()
	this.result = // unsupported expression: Expr_Clone
}

fn create_wordpress_aiclient_events_aftergenerateresultevent(arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal, arg_3 rt.PhpVal) &Class_WordPress_AiClient_Events_AfterGenerateResultEvent {
	mut obj := &Class_WordPress_AiClient_Events_AfterGenerateResultEvent{
		PhpObjectBase: rt.PhpObjectBase{}
		messages: rt.new_null()
		model: rt.new_null()
		capability: rt.new_null()
		result: rt.new_null()
	}
	obj.construct(arg_0, arg_1, arg_2, arg_3)
	return obj
}

fn (mut this Class_WordPress_AiClient_Events_AfterGenerateResultEvent) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WordPress_AiClient_Events_array](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_WordPress_AiClient_Providers_Models_Contracts_ModelInterface](if args.len > 1 { args[1] } else { rt.new_null() })
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_WordPress_AiClient_Events_?CapabilityEnum](if args.len > 2 { args[2] } else { rt.new_null() })
			mut dispatch_arg_3 := rt.cast_object_ptr[Class_WordPress_AiClient_Results_DTO_GenerativeAiResult](if args.len > 3 { args[3] } else { rt.new_null() })
			this.construct(mut dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2, mut dispatch_arg_3)
			return rt.new_null()
		}
		'getMessages' {
			return this.getmessages()
		}
		'getModel' {
			return this.getmodel()
		}
		'getCapability' {
			return this.getcapability()
		}
		'getResult' {
			return this.getresult()
		}
		'__clone' {
			this.magic_clone()
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_WordPress_AiClient_Events_AfterGenerateResultEvent) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'messages' { return this.messages }
		'model' { return this.model }
		'capability' { return this.capability }
		'result' { return this.result }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WordPress_AiClient_Events_AfterGenerateResultEvent) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'messages' { this.messages = val; return true }
		'model' { this.model = val; return true }
		'capability' { this.capability = val; return true }
		'result' { this.result = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}




pub fn init_wp_includes_php_ai_client_src_events_aftergenerateresultevent_php() {
	// unsupported statement: Stmt_Declare
}
