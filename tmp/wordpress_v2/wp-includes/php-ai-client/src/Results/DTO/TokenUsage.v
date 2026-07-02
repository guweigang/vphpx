import rt

pub fn Class_WordPress_AiClient_Results_DTO_TokenUsage.key_prompt_tokens() string {
	return 'promptTokens'
}
pub fn Class_WordPress_AiClient_Results_DTO_TokenUsage.key_completion_tokens() string {
	return 'completionTokens'
}
pub fn Class_WordPress_AiClient_Results_DTO_TokenUsage.key_total_tokens() string {
	return 'totalTokens'
}
pub fn Class_WordPress_AiClient_Results_DTO_TokenUsage.key_thought_tokens() string {
	return 'thoughtTokens'
}
struct Class_WordPress_AiClient_Results_DTO_TokenUsage {
	rt.PhpObjectBase
pub mut:
		promptTokens i64
		completionTokens i64
		totalTokens i64
		thoughtTokens rt.PhpVal = rt.new_null()
}

fn (mut this Class_WordPress_AiClient_Results_DTO_TokenUsage) construct(promptTokens i64, completionTokens i64, totalTokens i64, mut var_thoughtTokens Class_WordPress_AiClient_Results_DTO_?int) {
	this.promptTokens = promptTokens
	this.completionTokens = completionTokens
	this.totalTokens = totalTokens
	this.thoughtTokens = var_thoughtTokens
}

fn (mut this Class_WordPress_AiClient_Results_DTO_TokenUsage) getprompttokens() i64 {
	return this.promptTokens
}

fn (mut this Class_WordPress_AiClient_Results_DTO_TokenUsage) getcompletiontokens() i64 {
	return this.completionTokens
}

fn (mut this Class_WordPress_AiClient_Results_DTO_TokenUsage) gettotaltokens() i64 {
	return this.totalTokens
}

fn (mut this Class_WordPress_AiClient_Results_DTO_TokenUsage) getthoughttokens() i64 {
	return (this.thoughtTokens).to_i64()
}

fn Class_WordPress_AiClient_Results_DTO_TokenUsage.getjsonschema() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: Class_WordPress_AiClient_Results_DTO_WordPress_AiClient_Results_DTO_TokenUsage.key_prompt_tokens(), val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'integer' }, rt.ArrayItem{ key: 'description', val: 'Number of tokens in the prompt.' }]) }, rt.ArrayItem{ key: Class_WordPress_AiClient_Results_DTO_WordPress_AiClient_Results_DTO_TokenUsage.key_completion_tokens(), val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'integer' }, rt.ArrayItem{ key: 'description', val: 'Number of tokens in the completion, including any thought tokens.' }]) }, rt.ArrayItem{ key: Class_WordPress_AiClient_Results_DTO_WordPress_AiClient_Results_DTO_TokenUsage.key_total_tokens(), val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'integer' }, rt.ArrayItem{ key: 'description', val: 'Total number of tokens used.' }]) }, rt.ArrayItem{ key: Class_WordPress_AiClient_Results_DTO_WordPress_AiClient_Results_DTO_TokenUsage.key_thought_tokens(), val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'integer' }, rt.ArrayItem{ key: 'description', val: 'Number of tokens used for thinking, as a subset of completion tokens.' }]) }]) }, rt.ArrayItem{ key: 'required', val: rt.create_array([rt.ArrayItem{ key: none, val: Class_WordPress_AiClient_Results_DTO_WordPress_AiClient_Results_DTO_TokenUsage.key_prompt_tokens() }, rt.ArrayItem{ key: none, val: Class_WordPress_AiClient_Results_DTO_WordPress_AiClient_Results_DTO_TokenUsage.key_completion_tokens() }, rt.ArrayItem{ key: none, val: Class_WordPress_AiClient_Results_DTO_WordPress_AiClient_Results_DTO_TokenUsage.key_total_tokens() }]) }])
}

fn (mut this Class_WordPress_AiClient_Results_DTO_TokenUsage) toarray() rt.PhpVal {
	mut var_data := rt.create_array([rt.ArrayItem{ key: Class_WordPress_AiClient_Results_DTO_WordPress_AiClient_Results_DTO_TokenUsage.key_prompt_tokens(), val: this.promptTokens }, rt.ArrayItem{ key: Class_WordPress_AiClient_Results_DTO_WordPress_AiClient_Results_DTO_TokenUsage.key_completion_tokens(), val: this.completionTokens }, rt.ArrayItem{ key: Class_WordPress_AiClient_Results_DTO_WordPress_AiClient_Results_DTO_TokenUsage.key_total_tokens(), val: this.totalTokens }])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(this.thoughtTokens, rt.new_null())))) {
		var_data.array_set(Class_WordPress_AiClient_Results_DTO_WordPress_AiClient_Results_DTO_TokenUsage.key_thought_tokens(), this.thoughtTokens)
	}
	return var_data.clone()
}

fn Class_WordPress_AiClient_Results_DTO_TokenUsage.fromarray(mut var_array Class_WordPress_AiClient_Results_DTO_array) rt.PhpVal {
	mut iife_temp_0 := Class_WordPress_AiClient_Results_DTO_TokenUsage{}
	mut iife_result_0 := iife_temp_0.validatefromarraydata(rt.new_object('WordPress_AiClient_Results_DTO_array', []string{}, var_array), rt.create_array([rt.ArrayItem{ key: none, val: Class_WordPress_AiClient_Results_DTO_WordPress_AiClient_Results_DTO_TokenUsage.key_prompt_tokens() }, rt.ArrayItem{ key: none, val: Class_WordPress_AiClient_Results_DTO_WordPress_AiClient_Results_DTO_TokenUsage.key_completion_tokens() }, rt.ArrayItem{ key: none, val: Class_WordPress_AiClient_Results_DTO_WordPress_AiClient_Results_DTO_TokenUsage.key_total_tokens() }]))
	return rt.new_object('WordPress_AiClient_Results_DTO_self', []string{}, create_wordpress_aiclient_results_dto_self(var_array.array_get(Class_WordPress_AiClient_Results_DTO_WordPress_AiClient_Results_DTO_TokenUsage.key_prompt_tokens()), var_array.array_get(Class_WordPress_AiClient_Results_DTO_WordPress_AiClient_Results_DTO_TokenUsage.key_completion_tokens()), var_array.array_get(Class_WordPress_AiClient_Results_DTO_WordPress_AiClient_Results_DTO_TokenUsage.key_total_tokens()), if !(var_array.array_get(Class_WordPress_AiClient_Results_DTO_WordPress_AiClient_Results_DTO_TokenUsage.key_thought_tokens())).is_null() { var_array.array_get(Class_WordPress_AiClient_Results_DTO_WordPress_AiClient_Results_DTO_TokenUsage.key_thought_tokens()) } else { rt.new_null() }))
}

struct Class_WordPress_AiClient_Common_AbstractDataTransferObject {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClient_Results_DTO_self {
	rt.PhpObjectBase
}

fn create_wordpress_aiclient_results_dto_tokenusage(promptTokens i64, completionTokens i64, totalTokens i64, arg_3 rt.PhpVal) &Class_WordPress_AiClient_Results_DTO_TokenUsage {
	mut obj := &Class_WordPress_AiClient_Results_DTO_TokenUsage{
		PhpObjectBase: rt.PhpObjectBase{}
		promptTokens: i64(0)
		completionTokens: i64(0)
		totalTokens: i64(0)
		thoughtTokens: rt.new_null()
	}
	obj.construct(promptTokens, completionTokens, totalTokens, arg_3)
	return obj
}

fn create_wordpress_aiclient_common_abstractdatatransferobject(_args ...rt.PhpVal) &Class_WordPress_AiClient_Common_AbstractDataTransferObject {
	mut obj := &Class_WordPress_AiClient_Common_AbstractDataTransferObject{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wordpress_aiclient_results_dto_self(_args ...rt.PhpVal) &Class_WordPress_AiClient_Results_DTO_self {
	mut obj := &Class_WordPress_AiClient_Results_DTO_self{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WordPress_AiClient_Results_DTO_TokenUsage) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_i64()
			mut dispatch_arg_3 := rt.cast_object_ptr[Class_WordPress_AiClient_Results_DTO_?int](if args.len > 3 { args[3] } else { rt.new_null() })
			this.construct(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, mut dispatch_arg_3)
			return rt.new_null()
		}
		'getPromptTokens' {
			return rt.new_int(this.getprompttokens())
		}
		'getCompletionTokens' {
			return rt.new_int(this.getcompletiontokens())
		}
		'getTotalTokens' {
			return rt.new_int(this.gettotaltokens())
		}
		'getThoughtTokens' {
			return rt.new_int(this.getthoughttokens())
		}
		'getJsonSchema' {
			return Class_WordPress_AiClient_Results_DTO_TokenUsage.getjsonschema()
		}
		'toArray' {
			return this.toarray()
		}
		'fromArray' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WordPress_AiClient_Results_DTO_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return Class_WordPress_AiClient_Results_DTO_TokenUsage.fromarray(mut dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_WordPress_AiClient_Results_DTO_TokenUsage) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'promptTokens' { return rt.new_int(this.promptTokens) }
		'completionTokens' { return rt.new_int(this.completionTokens) }
		'totalTokens' { return rt.new_int(this.totalTokens) }
		'thoughtTokens' { return this.thoughtTokens }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WordPress_AiClient_Results_DTO_TokenUsage) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'promptTokens' { this.promptTokens = (val).to_i64(); return true }
		'completionTokens' { this.completionTokens = (val).to_i64(); return true }
		'totalTokens' { this.totalTokens = (val).to_i64(); return true }
		'thoughtTokens' { this.thoughtTokens = val; return true }
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


fn (mut this Class_WordPress_AiClient_Results_DTO_self) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WordPress_AiClient_Results_DTO_self) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClient_Results_DTO_self) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}



fn main() {
	defer {
		rt.shutdown()
	}

}
