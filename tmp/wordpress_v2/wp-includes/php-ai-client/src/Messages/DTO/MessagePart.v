import rt

pub fn Class_WordPress_AiClient_Messages_DTO_MessagePart.key_channel() string {
	return 'channel'
}
pub fn Class_WordPress_AiClient_Messages_DTO_MessagePart.key_type() string {
	return 'type'
}
pub fn Class_WordPress_AiClient_Messages_DTO_MessagePart.key_thought_signature() string {
	return 'thoughtSignature'
}
pub fn Class_WordPress_AiClient_Messages_DTO_MessagePart.key_text() string {
	return 'text'
}
pub fn Class_WordPress_AiClient_Messages_DTO_MessagePart.key_file() string {
	return 'file'
}
pub fn Class_WordPress_AiClient_Messages_DTO_MessagePart.key_function_call() string {
	return 'functionCall'
}
pub fn Class_WordPress_AiClient_Messages_DTO_MessagePart.key_function_response() string {
	return 'functionResponse'
}
struct Class_WordPress_AiClient_Messages_DTO_MessagePart {
	rt.PhpObjectBase
pub mut:
		channel rt.PhpVal = rt.new_null()
		prop_type rt.PhpVal = rt.new_null()
		thoughtSignature rt.PhpVal = rt.new_null()
		text rt.PhpVal = rt.new_null()
		file rt.PhpVal = rt.new_null()
		functionCall rt.PhpVal = rt.new_null()
		functionResponse rt.PhpVal = rt.new_null()
}

fn (mut this Class_WordPress_AiClient_Messages_DTO_MessagePart) construct(var_content rt.PhpVal, mut var_channel Class_WordPress_AiClient_Messages_DTO_?MessagePartChannelEnum, mut var_thoughtSignature Class_WordPress_AiClient_Messages_DTO_?string) {
	mut var_channel_mutated := var_channel
	mut var_thoughtSignature_mutated := var_thoughtSignature
	mut iife_temp_0 := Class_WordPress_AiClient_Messages_Enums_MessagePartChannelEnum{}
	mut iife_result_0 := iife_temp_0.content()
	this.channel = if !(var_channel_mutated).is_null() { var_channel_mutated } else { iife_result_0 }
	this.thoughtSignature = var_thoughtSignature_mutated
	if rt.is_true(rt.new_bool(var_content.clone().is_string())) {
		mut iife_temp_1 := Class_WordPress_AiClient_Messages_Enums_MessagePartTypeEnum{}
		mut iife_result_1 := iife_temp_1.text()
		this.prop_type = iife_result_1
		this.text = var_content.clone()
	} else if rt.is_true(rt.new_bool(rt.instance_of(var_content, 'WordPress_AiClient_Files_DTO_File'))) {
		mut iife_temp_2 := Class_WordPress_AiClient_Messages_Enums_MessagePartTypeEnum{}
		mut iife_result_2 := iife_temp_2.file()
		this.prop_type = iife_result_2
		this.file = var_content.clone()
	} else if rt.is_true(rt.new_bool(rt.instance_of(var_content, 'WordPress_AiClient_Tools_DTO_FunctionCall'))) {
		mut iife_temp_3 := Class_WordPress_AiClient_Messages_Enums_MessagePartTypeEnum{}
		mut iife_result_3 := iife_temp_3.functioncall()
		this.prop_type = iife_result_3
		this.functionCall = var_content.clone()
	} else if rt.is_true(rt.new_bool(rt.instance_of(var_content, 'WordPress_AiClient_Tools_DTO_FunctionResponse'))) {
		mut iife_temp_4 := Class_WordPress_AiClient_Messages_Enums_MessagePartTypeEnum{}
		mut iife_result_4 := iife_temp_4.functionresponse()
		this.prop_type = iife_result_4
		this.functionResponse = var_content.clone()
	} else {
		mut var_type := if var_content.clone().is_object() { rt.call_function('get_class', [var_content.clone()]) } else { rt.call_function('gettype', [var_content.clone()]) }
		rt.throw_exception(rt.new_object('WordPress_AiClient_Common_Exception_InvalidArgumentException', []string{}, create_wordpress_aiclient_common_exception_invalidargumentexception(rt.call_function('sprintf', [rt.new_string('Unsupported content type %s. Expected string, File, ' + 'FunctionCall, or FunctionResponse.'), var_type.clone()]))))
	}
}

fn (mut this Class_WordPress_AiClient_Messages_DTO_MessagePart) getchannel() rt.PhpVal {
	return this.channel
}

fn (mut this Class_WordPress_AiClient_Messages_DTO_MessagePart) gettype() rt.PhpVal {
	return this.prop_type
}

fn (mut this Class_WordPress_AiClient_Messages_DTO_MessagePart) getthoughtsignature() string {
	return (this.thoughtSignature).str()
}

fn (mut this Class_WordPress_AiClient_Messages_DTO_MessagePart) gettext() string {
	return (this.text).str()
}

fn (mut this Class_WordPress_AiClient_Messages_DTO_MessagePart) getfile() rt.PhpVal {
	return this.file
}

fn (mut this Class_WordPress_AiClient_Messages_DTO_MessagePart) getfunctioncall() rt.PhpVal {
	return this.functionCall
}

fn (mut this Class_WordPress_AiClient_Messages_DTO_MessagePart) getfunctionresponse() rt.PhpVal {
	return this.functionResponse
}

fn Class_WordPress_AiClient_Messages_DTO_MessagePart.getjsonschema() rt.PhpVal {
	mut iife_temp_5 := Class_WordPress_AiClient_Messages_Enums_MessagePartChannelEnum{}
	mut iife_result_5 := iife_temp_5.getvalues()
	mut var_channelSchema := rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'enum', val: iife_result_5 }, rt.ArrayItem{ key: 'description', val: 'The channel this message part belongs to.' }])
	mut var_thoughtSignatureSchema := rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'description', val: 'Thought signature for extended thinking.' }])
	mut iife_temp_6 := Class_WordPress_AiClient_Messages_Enums_MessagePartTypeEnum{}
	mut iife_result_6 := iife_temp_6.text()
	mut iife_temp_7 := Class_WordPress_AiClient_Messages_Enums_MessagePartTypeEnum{}
	mut iife_result_7 := iife_temp_7.file()
	mut iife_temp_8 := Class_WordPress_AiClient_Files_DTO_File{}
	mut iife_result_8 := iife_temp_8.getjsonschema()
	mut iife_temp_9 := Class_WordPress_AiClient_Messages_Enums_MessagePartTypeEnum{}
	mut iife_result_9 := iife_temp_9.functioncall()
	mut iife_temp_10 := Class_WordPress_AiClient_Tools_DTO_FunctionCall{}
	mut iife_result_10 := iife_temp_10.getjsonschema()
	mut iife_temp_11 := Class_WordPress_AiClient_Messages_Enums_MessagePartTypeEnum{}
	mut iife_result_11 := iife_temp_11.functionresponse()
	mut iife_temp_12 := Class_WordPress_AiClient_Tools_DTO_FunctionResponse{}
	mut iife_result_12 := iife_temp_12.getjsonschema()
	return rt.create_array([rt.ArrayItem{ key: 'oneOf', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: Class_WordPress_AiClient_Messages_DTO_WordPress_AiClient_Messages_DTO_MessagePart.key_channel(), val: var_channelSchema }, rt.ArrayItem{ key: Class_WordPress_AiClient_Messages_DTO_WordPress_AiClient_Messages_DTO_MessagePart.key_type(), val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'const', val: rt.get_property(iife_result_6, 'value') }]) }, rt.ArrayItem{ key: Class_WordPress_AiClient_Messages_DTO_WordPress_AiClient_Messages_DTO_MessagePart.key_text(), val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'description', val: 'Text content.' }]) }, rt.ArrayItem{ key: Class_WordPress_AiClient_Messages_DTO_WordPress_AiClient_Messages_DTO_MessagePart.key_thought_signature(), val: var_thoughtSignatureSchema }]) }, rt.ArrayItem{ key: 'required', val: rt.create_array([rt.ArrayItem{ key: none, val: Class_WordPress_AiClient_Messages_DTO_WordPress_AiClient_Messages_DTO_MessagePart.key_type() }, rt.ArrayItem{ key: none, val: Class_WordPress_AiClient_Messages_DTO_WordPress_AiClient_Messages_DTO_MessagePart.key_text() }]) }, rt.ArrayItem{ key: 'additionalProperties', val: false }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: Class_WordPress_AiClient_Messages_DTO_WordPress_AiClient_Messages_DTO_MessagePart.key_channel(), val: var_channelSchema }, rt.ArrayItem{ key: Class_WordPress_AiClient_Messages_DTO_WordPress_AiClient_Messages_DTO_MessagePart.key_type(), val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'const', val: rt.get_property(iife_result_7, 'value') }]) }, rt.ArrayItem{ key: Class_WordPress_AiClient_Messages_DTO_WordPress_AiClient_Messages_DTO_MessagePart.key_file(), val: iife_result_8 }, rt.ArrayItem{ key: Class_WordPress_AiClient_Messages_DTO_WordPress_AiClient_Messages_DTO_MessagePart.key_thought_signature(), val: var_thoughtSignatureSchema }]) }, rt.ArrayItem{ key: 'required', val: rt.create_array([rt.ArrayItem{ key: none, val: Class_WordPress_AiClient_Messages_DTO_WordPress_AiClient_Messages_DTO_MessagePart.key_type() }, rt.ArrayItem{ key: none, val: Class_WordPress_AiClient_Messages_DTO_WordPress_AiClient_Messages_DTO_MessagePart.key_file() }]) }, rt.ArrayItem{ key: 'additionalProperties', val: false }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: Class_WordPress_AiClient_Messages_DTO_WordPress_AiClient_Messages_DTO_MessagePart.key_channel(), val: var_channelSchema }, rt.ArrayItem{ key: Class_WordPress_AiClient_Messages_DTO_WordPress_AiClient_Messages_DTO_MessagePart.key_type(), val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'const', val: rt.get_property(iife_result_9, 'value') }]) }, rt.ArrayItem{ key: Class_WordPress_AiClient_Messages_DTO_WordPress_AiClient_Messages_DTO_MessagePart.key_function_call(), val: iife_result_10 }, rt.ArrayItem{ key: Class_WordPress_AiClient_Messages_DTO_WordPress_AiClient_Messages_DTO_MessagePart.key_thought_signature(), val: var_thoughtSignatureSchema }]) }, rt.ArrayItem{ key: 'required', val: rt.create_array([rt.ArrayItem{ key: none, val: Class_WordPress_AiClient_Messages_DTO_WordPress_AiClient_Messages_DTO_MessagePart.key_type() }, rt.ArrayItem{ key: none, val: Class_WordPress_AiClient_Messages_DTO_WordPress_AiClient_Messages_DTO_MessagePart.key_function_call() }]) }, rt.ArrayItem{ key: 'additionalProperties', val: false }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: Class_WordPress_AiClient_Messages_DTO_WordPress_AiClient_Messages_DTO_MessagePart.key_channel(), val: var_channelSchema }, rt.ArrayItem{ key: Class_WordPress_AiClient_Messages_DTO_WordPress_AiClient_Messages_DTO_MessagePart.key_type(), val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'const', val: rt.get_property(iife_result_11, 'value') }]) }, rt.ArrayItem{ key: Class_WordPress_AiClient_Messages_DTO_WordPress_AiClient_Messages_DTO_MessagePart.key_function_response(), val: iife_result_12 }, rt.ArrayItem{ key: Class_WordPress_AiClient_Messages_DTO_WordPress_AiClient_Messages_DTO_MessagePart.key_thought_signature(), val: var_thoughtSignatureSchema }]) }, rt.ArrayItem{ key: 'required', val: rt.create_array([rt.ArrayItem{ key: none, val: Class_WordPress_AiClient_Messages_DTO_WordPress_AiClient_Messages_DTO_MessagePart.key_type() }, rt.ArrayItem{ key: none, val: Class_WordPress_AiClient_Messages_DTO_WordPress_AiClient_Messages_DTO_MessagePart.key_function_response() }]) }, rt.ArrayItem{ key: 'additionalProperties', val: false }]) }]) }])
}

fn (mut this Class_WordPress_AiClient_Messages_DTO_MessagePart) toarray() rt.PhpVal {
	mut var_data := rt.create_array([rt.ArrayItem{ key: Class_WordPress_AiClient_Messages_DTO_WordPress_AiClient_Messages_DTO_MessagePart.key_channel(), val: rt.get_property(this.channel, 'value') }, rt.ArrayItem{ key: Class_WordPress_AiClient_Messages_DTO_WordPress_AiClient_Messages_DTO_MessagePart.key_type(), val: rt.get_property(this.prop_type, 'value') }])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(this.text, rt.new_null())))) {
		var_data.array_set(Class_WordPress_AiClient_Messages_DTO_WordPress_AiClient_Messages_DTO_MessagePart.key_text(), this.text)
	} else if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(this.file, rt.new_null())))) {
		var_data.array_set(Class_WordPress_AiClient_Messages_DTO_WordPress_AiClient_Messages_DTO_MessagePart.key_file(), rt.call_method(this.file, 'toArray', []rt.PhpVal{}))
	} else if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(this.functionCall, rt.new_null())))) {
		var_data.array_set(Class_WordPress_AiClient_Messages_DTO_WordPress_AiClient_Messages_DTO_MessagePart.key_function_call(), rt.call_method(this.functionCall, 'toArray', []rt.PhpVal{}))
	} else if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(this.functionResponse, rt.new_null())))) {
		var_data.array_set(Class_WordPress_AiClient_Messages_DTO_WordPress_AiClient_Messages_DTO_MessagePart.key_function_response(), rt.call_method(this.functionResponse, 'toArray', []rt.PhpVal{}))
	} else {
		rt.throw_exception(rt.new_object('WordPress_AiClient_Common_Exception_RuntimeException', []string{}, create_wordpress_aiclient_common_exception_runtimeexception('MessagePart requires one of: text, file, functionCall, or functionResponse. ' + 'This should not be a possible condition.')))
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(this.thoughtSignature, rt.new_null())))) {
		var_data.array_set(Class_WordPress_AiClient_Messages_DTO_WordPress_AiClient_Messages_DTO_MessagePart.key_thought_signature(), this.thoughtSignature)
	}
	return var_data.clone()
}

fn Class_WordPress_AiClient_Messages_DTO_MessagePart.fromarray(mut var_array Class_WordPress_AiClient_Messages_DTO_array) rt.PhpVal {
	if var_array.array_isset(Class_WordPress_AiClient_Messages_DTO_WordPress_AiClient_Messages_DTO_MessagePart.key_channel()) {
	mut iife_temp_13 := Class_WordPress_AiClient_Messages_Enums_MessagePartChannelEnum{}
	mut iife_result_13 := iife_temp_13.from(var_array.array_get(Class_WordPress_AiClient_Messages_DTO_WordPress_AiClient_Messages_DTO_MessagePart.key_channel()))
	mut var_channel := iife_result_13
	} else {
	var_channel = rt.new_null()
	}
	mut var_thoughtSignature := if !(var_array.array_get(Class_WordPress_AiClient_Messages_DTO_WordPress_AiClient_Messages_DTO_MessagePart.key_thought_signature())).is_null() { var_array.array_get(Class_WordPress_AiClient_Messages_DTO_WordPress_AiClient_Messages_DTO_MessagePart.key_thought_signature()) } else { rt.new_null() }
	if var_array.array_isset(Class_WordPress_AiClient_Messages_DTO_WordPress_AiClient_Messages_DTO_MessagePart.key_text()) {
		return rt.new_object('WordPress_AiClient_Messages_DTO_self', []string{}, create_wordpress_aiclient_messages_dto_self(var_array.array_get(Class_WordPress_AiClient_Messages_DTO_WordPress_AiClient_Messages_DTO_MessagePart.key_text()), var_channel.clone(), var_thoughtSignature.clone()))
	} else if var_array.array_isset(Class_WordPress_AiClient_Messages_DTO_WordPress_AiClient_Messages_DTO_MessagePart.key_file()) {
		mut iife_temp_14 := Class_WordPress_AiClient_Files_DTO_File{}
		mut iife_result_14 := iife_temp_14.fromarray(var_array.array_get(Class_WordPress_AiClient_Messages_DTO_WordPress_AiClient_Messages_DTO_MessagePart.key_file()))
		return rt.new_object('WordPress_AiClient_Messages_DTO_self', []string{}, create_wordpress_aiclient_messages_dto_self(iife_result_14, var_channel.clone(), var_thoughtSignature.clone()))
	} else if var_array.array_isset(Class_WordPress_AiClient_Messages_DTO_WordPress_AiClient_Messages_DTO_MessagePart.key_function_call()) {
		mut iife_temp_15 := Class_WordPress_AiClient_Tools_DTO_FunctionCall{}
		mut iife_result_15 := iife_temp_15.fromarray(var_array.array_get(Class_WordPress_AiClient_Messages_DTO_WordPress_AiClient_Messages_DTO_MessagePart.key_function_call()))
		return rt.new_object('WordPress_AiClient_Messages_DTO_self', []string{}, create_wordpress_aiclient_messages_dto_self(iife_result_15, var_channel.clone(), var_thoughtSignature.clone()))
	} else if var_array.array_isset(Class_WordPress_AiClient_Messages_DTO_WordPress_AiClient_Messages_DTO_MessagePart.key_function_response()) {
		mut iife_temp_16 := Class_WordPress_AiClient_Tools_DTO_FunctionResponse{}
		mut iife_result_16 := iife_temp_16.fromarray(var_array.array_get(Class_WordPress_AiClient_Messages_DTO_WordPress_AiClient_Messages_DTO_MessagePart.key_function_response()))
		return rt.new_object('WordPress_AiClient_Messages_DTO_self', []string{}, create_wordpress_aiclient_messages_dto_self(iife_result_16, var_channel.clone(), var_thoughtSignature.clone()))
	} else {
		rt.throw_exception(rt.new_object('WordPress_AiClient_Common_Exception_InvalidArgumentException', []string{}, create_wordpress_aiclient_common_exception_invalidargumentexception(rt.new_string('MessagePart requires one of: text, file, functionCall, or functionResponse.'))))
	}
	return rt.new_null()
}

fn (mut this Class_WordPress_AiClient_Messages_DTO_MessagePart) magic_clone() {
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(this.file, rt.new_null())))) {
		this.file = this.file.dup()
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(this.functionCall, rt.new_null())))) {
		this.functionCall = this.functionCall.dup()
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(this.functionResponse, rt.new_null())))) {
		this.functionResponse = this.functionResponse.dup()
	}
}

struct Class_WordPress_AiClient_Common_AbstractDataTransferObject {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClient_Messages_Enums_MessagePartChannelEnum {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClient_Messages_Enums_MessagePartTypeEnum {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClient_Common_Exception_InvalidArgumentException {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClient_Files_DTO_File {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClient_Tools_DTO_FunctionCall {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClient_Tools_DTO_FunctionResponse {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClient_Common_Exception_RuntimeException {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClient_Messages_DTO_self {
	rt.PhpObjectBase
}

fn create_wordpress_aiclient_messages_dto_messagepart(arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) &Class_WordPress_AiClient_Messages_DTO_MessagePart {
	mut obj := &Class_WordPress_AiClient_Messages_DTO_MessagePart{
		PhpObjectBase: rt.PhpObjectBase{}
		channel: rt.new_null()
		prop_type: rt.new_null()
		thoughtSignature: rt.new_null()
		text: rt.new_null()
		file: rt.new_null()
		functionCall: rt.new_null()
		functionResponse: rt.new_null()
	}
	obj.construct(arg_0, arg_1, arg_2)
	return obj
}

fn create_wordpress_aiclient_common_abstractdatatransferobject(_args ...rt.PhpVal) &Class_WordPress_AiClient_Common_AbstractDataTransferObject {
	mut obj := &Class_WordPress_AiClient_Common_AbstractDataTransferObject{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wordpress_aiclient_messages_enums_messagepartchannelenum(_args ...rt.PhpVal) &Class_WordPress_AiClient_Messages_Enums_MessagePartChannelEnum {
	mut obj := &Class_WordPress_AiClient_Messages_Enums_MessagePartChannelEnum{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wordpress_aiclient_messages_enums_messageparttypeenum(_args ...rt.PhpVal) &Class_WordPress_AiClient_Messages_Enums_MessagePartTypeEnum {
	mut obj := &Class_WordPress_AiClient_Messages_Enums_MessagePartTypeEnum{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wordpress_aiclient_common_exception_invalidargumentexception(_args ...rt.PhpVal) &Class_WordPress_AiClient_Common_Exception_InvalidArgumentException {
	mut obj := &Class_WordPress_AiClient_Common_Exception_InvalidArgumentException{
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

fn create_wordpress_aiclient_tools_dto_functioncall(_args ...rt.PhpVal) &Class_WordPress_AiClient_Tools_DTO_FunctionCall {
	mut obj := &Class_WordPress_AiClient_Tools_DTO_FunctionCall{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wordpress_aiclient_tools_dto_functionresponse(_args ...rt.PhpVal) &Class_WordPress_AiClient_Tools_DTO_FunctionResponse {
	mut obj := &Class_WordPress_AiClient_Tools_DTO_FunctionResponse{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wordpress_aiclient_common_exception_runtimeexception(_args ...rt.PhpVal) &Class_WordPress_AiClient_Common_Exception_RuntimeException {
	mut obj := &Class_WordPress_AiClient_Common_Exception_RuntimeException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wordpress_aiclient_messages_dto_self(_args ...rt.PhpVal) &Class_WordPress_AiClient_Messages_DTO_self {
	mut obj := &Class_WordPress_AiClient_Messages_DTO_self{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WordPress_AiClient_Messages_DTO_MessagePart) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_WordPress_AiClient_Messages_DTO_?MessagePartChannelEnum](if args.len > 1 { args[1] } else { rt.new_null() })
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_WordPress_AiClient_Messages_DTO_?string](if args.len > 2 { args[2] } else { rt.new_null() })
			this.construct(dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2)
			return rt.new_null()
		}
		'getChannel' {
			return this.getchannel()
		}
		'getType' {
			return this.gettype()
		}
		'getThoughtSignature' {
			return rt.new_string(this.getthoughtsignature())
		}
		'getText' {
			return rt.new_string(this.gettext())
		}
		'getFile' {
			return this.getfile()
		}
		'getFunctionCall' {
			return this.getfunctioncall()
		}
		'getFunctionResponse' {
			return this.getfunctionresponse()
		}
		'getJsonSchema' {
			return Class_WordPress_AiClient_Messages_DTO_MessagePart.getjsonschema()
		}
		'toArray' {
			return this.toarray()
		}
		'fromArray' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WordPress_AiClient_Messages_DTO_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return Class_WordPress_AiClient_Messages_DTO_MessagePart.fromarray(mut dispatch_arg_0)
		}
		'__clone' {
			this.magic_clone()
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_WordPress_AiClient_Messages_DTO_MessagePart) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'channel' { return this.channel }
		'type' { return this.prop_type }
		'thoughtSignature' { return this.thoughtSignature }
		'text' { return this.text }
		'file' { return this.file }
		'functionCall' { return this.functionCall }
		'functionResponse' { return this.functionResponse }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WordPress_AiClient_Messages_DTO_MessagePart) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'channel' { this.channel = val; return true }
		'type' { this.prop_type = val; return true }
		'thoughtSignature' { this.thoughtSignature = val; return true }
		'text' { this.text = val; return true }
		'file' { this.file = val; return true }
		'functionCall' { this.functionCall = val; return true }
		'functionResponse' { this.functionResponse = val; return true }
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


fn (mut this Class_WordPress_AiClient_Messages_Enums_MessagePartChannelEnum) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WordPress_AiClient_Messages_Enums_MessagePartChannelEnum) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClient_Messages_Enums_MessagePartChannelEnum) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
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


fn (mut this Class_WordPress_AiClient_Common_Exception_InvalidArgumentException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WordPress_AiClient_Common_Exception_InvalidArgumentException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClient_Common_Exception_InvalidArgumentException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_WordPress_AiClient_Tools_DTO_FunctionCall) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WordPress_AiClient_Tools_DTO_FunctionCall) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClient_Tools_DTO_FunctionCall) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
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


fn (mut this Class_WordPress_AiClient_Common_Exception_RuntimeException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WordPress_AiClient_Common_Exception_RuntimeException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClient_Common_Exception_RuntimeException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WordPress_AiClient_Messages_DTO_self) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WordPress_AiClient_Messages_DTO_self) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClient_Messages_DTO_self) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}



fn main() {
	defer {
		rt.shutdown()
	}

}
