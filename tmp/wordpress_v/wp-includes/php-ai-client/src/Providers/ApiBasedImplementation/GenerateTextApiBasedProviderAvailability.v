import rt

struct Class_WordPress_AiClient_Providers_ApiBasedImplementation_GenerateTextApiBasedProviderAvailability {
	rt.PhpObjectBase
pub mut:
	model rt.PhpVal = rt.new_null()
}

fn (mut this Class_WordPress_AiClient_Providers_ApiBasedImplementation_GenerateTextApiBasedProviderAvailability) construct(mut var_model Class_WordPress_AiClient_Providers_Models_Contracts_ModelInterface) {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(rt.new_object('WordPress_AiClient_Providers_Models_Contracts_ModelInterface',
		[]string{}, var_model),
		'WordPress_AiClient_Providers_Models_TextGeneration_Contracts_TextGenerationModelInterface'))))))
	{
		rt.throw_exception(rt.new_object('Exception', []string{},
			create_exception(rt.new_string('The model class to check provider availability must implement TextGenerationModelInterface.'))))
	}
	this.model = var_model.dup()
}

fn (mut this Class_WordPress_AiClient_Providers_ApiBasedImplementation_GenerateTextApiBasedProviderAvailability) isconfigured() bool {
	mut var_modelConfig := fn (arg_0 rt.PhpVal) rt.PhpVal {
		mut temp := Class_WordPress_AiClient_Providers_Models_DTO_ModelConfig{}
		return temp.fromarray(arg_0)
	}(rt.create_array([
		rt.ArrayItem{
			key: Class_WordPress_AiClient_Providers_Models_DTO_ModelConfig.key_max_tokens()
			val: 1
		},
	]))
	rt.call_method(this.model, 'setConfig', [var_modelConfig.dup()])
	rt.call_method(this.model, 'generateTextResult', [
		rt.create_array([
			rt.ArrayItem{ key: none, val: create_wordpress_aiclient_messages_dto_message(fn () rt.PhpVal {
				mut temp := Class_WordPress_AiClient_Messages_Enums_MessageRoleEnum{}
				return temp.user()
			}(), rt.create_array([
				rt.ArrayItem{
					key: none
					val: create_wordpress_aiclient_messages_dto_messagepart(rt.new_string('a'))
				},
			])) },
		]),
	])
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	return true
	unsafe {
		goto end_label_1
	}
	catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'Exception') {
		mut var_e := var_e_1.dup()
		return false
		unsafe {
			goto end_label_1
		}
	} else {
		rt.throw_exception(var_e_1)
		unsafe {
			goto end_label_1
		}
	}

	end_label_1:
	return false
}

struct Class_Exception {
	rt.PhpObjectBase
pub mut:
	message string
	code    i64
	file    string
	line    i64
}

fn (mut this Class_Exception) construct(var_message rt.PhpVal) {
	this.message = var_message.to_string()
}

fn (mut this Class_Exception) getmessage() string {
	return this.message
}

struct Class_WordPress_AiClient_Providers_Models_DTO_ModelConfig {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClient_Messages_DTO_Message {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClient_Messages_Enums_MessageRoleEnum {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClient_Messages_DTO_MessagePart {
	rt.PhpObjectBase
}

fn create_wordpress_aiclient_providers_apibasedimplementation_generatetextapibasedprovideravailability(arg_0 rt.PhpVal) &Class_WordPress_AiClient_Providers_ApiBasedImplementation_GenerateTextApiBasedProviderAvailability {
	mut obj := &Class_WordPress_AiClient_Providers_ApiBasedImplementation_GenerateTextApiBasedProviderAvailability{
		PhpObjectBase: rt.PhpObjectBase{}
		model:         rt.new_null()
	}
	obj.construct(arg_0)
	return obj
}

fn create_exception(arg_0 rt.PhpVal) &Class_Exception {
	mut obj := &Class_Exception{
		PhpObjectBase: rt.PhpObjectBase{}
		message:       ''
		code:          i64(0)
		file:          ''
		line:          i64(0)
	}
	obj.construct(arg_0)
	return obj
}

fn create_wordpress_aiclient_providers_models_dto_modelconfig() &Class_WordPress_AiClient_Providers_Models_DTO_ModelConfig {
	mut obj := &Class_WordPress_AiClient_Providers_Models_DTO_ModelConfig{
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

fn create_wordpress_aiclient_messages_enums_messageroleenum() &Class_WordPress_AiClient_Messages_Enums_MessageRoleEnum {
	mut obj := &Class_WordPress_AiClient_Messages_Enums_MessageRoleEnum{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wordpress_aiclient_messages_dto_messagepart() &Class_WordPress_AiClient_Messages_DTO_MessagePart {
	mut obj := &Class_WordPress_AiClient_Messages_DTO_MessagePart{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WordPress_AiClient_Providers_ApiBasedImplementation_GenerateTextApiBasedProviderAvailability) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WordPress_AiClient_Providers_Models_Contracts_ModelInterface](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.construct(mut dispatch_arg_0)
			return rt.new_null()
		}
		'isConfigured' {
			return rt.new_bool(this.isconfigured())
		}
		else {
			return none
		}
	}
}

fn (this &Class_WordPress_AiClient_Providers_ApiBasedImplementation_GenerateTextApiBasedProviderAvailability) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'model' { return this.model }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WordPress_AiClient_Providers_ApiBasedImplementation_GenerateTextApiBasedProviderAvailability) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'model' {
			this.model = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_Exception) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'getMessage' {
			return rt.new_string(this.getmessage())
		}
		else {
			return none
		}
	}
}

fn (this &Class_Exception) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'message' { return rt.new_string(this.message) }
		'code' { return rt.new_int(this.code) }
		'file' { return rt.new_string(this.file) }
		'line' { return rt.new_int(this.line) }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Exception) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'message' {
			this.message = val.str()
			return true
		}
		'code' {
			this.code = val.to_i64()
			return true
		}
		'file' {
			this.file = val.str()
			return true
		}
		'line' {
			this.line = val.to_i64()
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_WordPress_AiClient_Providers_Models_DTO_ModelConfig) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WordPress_AiClient_Providers_Models_DTO_ModelConfig) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClient_Providers_Models_DTO_ModelConfig) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_WordPress_AiClient_Messages_Enums_MessageRoleEnum) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WordPress_AiClient_Messages_Enums_MessageRoleEnum) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClient_Messages_Enums_MessageRoleEnum) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

pub fn init_wp_includes_php_ai_client_src_providers_apibasedimplementation_generatetextapibasedprovideravailability_php() {
	// unsupported statement: Stmt_Declare
}
