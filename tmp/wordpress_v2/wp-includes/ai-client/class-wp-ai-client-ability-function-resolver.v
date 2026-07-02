import rt

pub fn Class_WP_AI_Client_Ability_Function_Resolver.ability_prefix() string {
	return 'wpab__'
}

struct Class_WP_AI_Client_Ability_Function_Resolver {
	rt.PhpObjectBase
pub mut:
	allowed_abilities rt.PhpVal = rt.new_null()
}

fn (mut this Class_WP_AI_Client_Ability_Function_Resolver) construct(var_abilities rt.PhpVal) {
	this.allowed_abilities = rt.new_array()
	mut iter_1 := var_abilities.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_ability := item_1.val
		if rt.is_true(rt.new_bool(rt.instance_of(var_ability, 'WP_Ability'))) {
			this.allowed_abilities.array_set(rt.call_method(var_ability, 'get_name', []rt.PhpVal{}),
				true)
		} else if rt.is_true(rt.new_bool(var_ability.clone().is_string())) {
			this.allowed_abilities.array_set(var_ability, true)
		}
	}
}

fn (mut this Class_WP_AI_Client_Ability_Function_Resolver) is_ability_call(mut var_call Class_WordPress_AiClient_Tools_DTO_FunctionCall) bool {
	mut var_name := var_call.getname()
	if rt.is_true(rt.identical(rt.new_null(), var_name)) {
		return false
	}
	return (rt.call_function('str_starts_with', [var_name.clone(),
		rt.new_string(Class_WP_AI_Client_Ability_Function_Resolver.ability_prefix())])).to_bool()
}

fn (mut this Class_WP_AI_Client_Ability_Function_Resolver) execute_ability(mut var_call Class_WordPress_AiClient_Tools_DTO_FunctionCall) rt.PhpVal {
	mut var_function_name := if !(var_call.getname()).is_null() {
		var_call.getname()
	} else {
		rt.new_string('unknown')
	}
	mut var_function_id := if !(var_call.getid()).is_null() {
		var_call.getid()
	} else {
		rt.new_string('unknown')
	}
	if !(this.is_ability_call(mut var_call)) {
		return rt.new_object('WordPress_AiClient_Tools_DTO_FunctionResponse', []string{}, create_wordpress_aiclient_tools_dto_functionresponse(var_function_id.clone(),
			var_function_name.clone(), rt.create_array([
			rt.ArrayItem{ key: 'error', val: rt.call_function('__', [
				rt.new_string('Not an ability function call'),
			]) },
			rt.ArrayItem{ key: 'code', val: 'invalid_ability_call' },
		])))
	}
	mut var_ability_name :=
		Class_WP_AI_Client_Ability_Function_Resolver.function_name_to_ability_name(var_function_name.str())
	if !(this.allowed_abilities.array_isset(var_ability_name)) {
		return rt.new_object('WordPress_AiClient_Tools_DTO_FunctionResponse', []string{}, create_wordpress_aiclient_tools_dto_functionresponse(var_function_id.clone(),
			var_function_name.clone(), rt.create_array([
			rt.ArrayItem{ key: 'error', val: rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('Ability "%s" was not specified in the allowed abilities list.'),
				]),
				var_ability_name.clone(),
			]) },
			rt.ArrayItem{ key: 'code', val: 'ability_not_allowed' },
		])))
	}
	mut var_ability := rt.call_function('wp_get_ability', [var_ability_name.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_ability, 'WP_Ability')))))) {
		return rt.new_object('WordPress_AiClient_Tools_DTO_FunctionResponse', []string{}, create_wordpress_aiclient_tools_dto_functionresponse(var_function_id.clone(),
			var_function_name.clone(), rt.create_array([
			rt.ArrayItem{ key: 'error', val: rt.call_function('sprintf', [
				rt.call_function('__', [rt.new_string('Ability "%s" not found')]),
				var_ability_name.clone(),
			]) },
			rt.ArrayItem{ key: 'code', val: 'ability_not_found' },
		])))
	}
	mut var_args := var_call.getargs()
	mut var_result := rt.call_method(var_ability, 'execute', [if !(!rt.is_true(var_args)) {
		var_args
	} else {
		rt.new_null()
	}])
	if rt.is_true(rt.call_function('is_wp_error', [var_result.clone()])) {
		return rt.new_object('WordPress_AiClient_Tools_DTO_FunctionResponse', []string{}, create_wordpress_aiclient_tools_dto_functionresponse(var_function_id.clone(),
			var_function_name.clone(), rt.create_array([
			rt.ArrayItem{ key: 'error', val: rt.call_method(var_result, 'get_error_message',
				[]rt.PhpVal{}) },
			rt.ArrayItem{ key: 'code', val: rt.call_method(var_result, 'get_error_code',
				[]rt.PhpVal{}) },
			rt.ArrayItem{ key: 'data', val: rt.call_method(var_result, 'get_error_data',
				[]rt.PhpVal{}) },
		])))
	}
	return rt.new_object('WordPress_AiClient_Tools_DTO_FunctionResponse', []string{}, create_wordpress_aiclient_tools_dto_functionresponse(var_function_id.clone(),
		var_function_name.clone(), var_result.clone()))
}

fn (mut this Class_WP_AI_Client_Ability_Function_Resolver) has_ability_calls(mut var_message Class_WordPress_AiClient_Messages_DTO_Message) bool {
	mut iter_2 := var_message.getparts().iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_part := item_2.val
		if rt.is_true(rt.call_method(rt.call_method(var_part, 'getType', []rt.PhpVal{}),
			'isFunctionCall', []rt.PhpVal{}))
		{
			mut var_function_call := rt.call_method(var_part, 'getFunctionCall', []rt.PhpVal{})
			if rt.is_true(rt.new_bool(rt.instance_of(var_function_call, 'WordPress_AiClient_Tools_DTO_FunctionCall')))
				&& this.is_ability_call(mut rt.cast_object_ptr[Class_WordPress_AiClient_Tools_DTO_FunctionCall](var_function_call)) {
				return true
			}
		}
	}
	return false
}

fn (mut this Class_WP_AI_Client_Ability_Function_Resolver) execute_abilities(mut var_message Class_WordPress_AiClient_Messages_DTO_Message) rt.PhpVal {
	mut var_response_parts := rt.new_array()
	mut iter_3 := var_message.getparts().iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_part := item_3.val
		if rt.is_true(rt.call_method(rt.call_method(var_part, 'getType', []rt.PhpVal{}),
			'isFunctionCall', []rt.PhpVal{}))
		{
			mut var_function_call := rt.call_method(var_part, 'getFunctionCall', []rt.PhpVal{})
			if rt.is_true(rt.new_bool(rt.instance_of(var_function_call,
				'WordPress_AiClient_Tools_DTO_FunctionCall')))
			{
				mut var_function_response :=
					this.execute_ability(mut rt.cast_object_ptr[Class_WordPress_AiClient_Tools_DTO_FunctionCall](var_function_call))
				var_response_parts << create_wordpress_aiclient_messages_dto_messagepart(var_function_response.clone())
			}
		}
	}
	return rt.new_object('WordPress_AiClient_Messages_DTO_UserMessage', []string{},
		create_wordpress_aiclient_messages_dto_usermessage(var_response_parts.clone()))
}

fn Class_WP_AI_Client_Ability_Function_Resolver.ability_name_to_function_name(ability_name string) string {
	mut ability_name_mutated := ability_name
	return Class_WP_AI_Client_Ability_Function_Resolver.ability_prefix() +(rt.call_function('str_replace', [rt.new_string('/'), rt.new_string('__'), rt.new_string(ability_name_mutated).clone()])).str()
}

fn Class_WP_AI_Client_Ability_Function_Resolver.function_name_to_ability_name(function_name string) string {
	mut function_name_mutated := function_name
	mut var_without_prefix := rt.call_function('substr', [rt.new_string(function_name_mutated).clone(),
		rt.new_int(Class_WP_AI_Client_Ability_Function_Resolver.ability_prefix().len)])
	return (rt.call_function('str_replace', [rt.new_string('__'),
		rt.new_string('/'), var_without_prefix.clone()])).str()
}

struct Class_WordPress_AiClient_Tools_DTO_FunctionResponse {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClient_Messages_DTO_MessagePart {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClient_Messages_DTO_UserMessage {
	rt.PhpObjectBase
}

fn create_wp_ai_client_ability_function_resolver(arg_0 rt.PhpVal) &Class_WP_AI_Client_Ability_Function_Resolver {
	mut obj := &Class_WP_AI_Client_Ability_Function_Resolver{
		PhpObjectBase:     rt.PhpObjectBase{}
		allowed_abilities: rt.new_null()
	}
	obj.construct(arg_0)
	return obj
}

fn create_wordpress_aiclient_tools_dto_functionresponse(_args ...rt.PhpVal) &Class_WordPress_AiClient_Tools_DTO_FunctionResponse {
	mut obj := &Class_WordPress_AiClient_Tools_DTO_FunctionResponse{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wordpress_aiclient_messages_dto_messagepart(_args ...rt.PhpVal) &Class_WordPress_AiClient_Messages_DTO_MessagePart {
	mut obj := &Class_WordPress_AiClient_Messages_DTO_MessagePart{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wordpress_aiclient_messages_dto_usermessage(_args ...rt.PhpVal) &Class_WordPress_AiClient_Messages_DTO_UserMessage {
	mut obj := &Class_WordPress_AiClient_Messages_DTO_UserMessage{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_AI_Client_Ability_Function_Resolver) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'is_ability_call' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WordPress_AiClient_Tools_DTO_FunctionCall](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return rt.new_bool(this.is_ability_call(mut dispatch_arg_0))
		}
		'execute_ability' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WordPress_AiClient_Tools_DTO_FunctionCall](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.execute_ability(mut dispatch_arg_0)
		}
		'has_ability_calls' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WordPress_AiClient_Messages_DTO_Message](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return rt.new_bool(this.has_ability_calls(mut dispatch_arg_0))
		}
		'execute_abilities' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WordPress_AiClient_Messages_DTO_Message](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.execute_abilities(mut dispatch_arg_0)
		}
		'ability_name_to_function_name' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(Class_WP_AI_Client_Ability_Function_Resolver.ability_name_to_function_name(dispatch_arg_0))
		}
		'function_name_to_ability_name' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(Class_WP_AI_Client_Ability_Function_Resolver.function_name_to_ability_name(dispatch_arg_0))
		}
		else {
			return none
		}
	}
}

fn (this &Class_WP_AI_Client_Ability_Function_Resolver) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'allowed_abilities' { return this.allowed_abilities }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_AI_Client_Ability_Function_Resolver) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'allowed_abilities' {
			this.allowed_abilities = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_WordPress_AiClient_Tools_DTO_FunctionResponse) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WordPress_AiClient_Tools_DTO_FunctionResponse) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClient_Tools_DTO_FunctionResponse) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
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

fn (mut this Class_WordPress_AiClient_Messages_DTO_UserMessage) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WordPress_AiClient_Messages_DTO_UserMessage) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClient_Messages_DTO_UserMessage) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
