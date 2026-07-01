import rt

struct Class_WordPress_AiClient_Providers_OpenAiCompatibleImplementation_AbstractOpenAiCompatibleTextGenerationModel {
	rt.PhpObjectBase
}

fn (mut this Class_WordPress_AiClient_Providers_OpenAiCompatibleImplementation_AbstractOpenAiCompatibleTextGenerationModel) generatetextresult(mut var_prompt Class_WordPress_AiClient_Providers_OpenAiCompatibleImplementation_array) rt.PhpVal {
	mut var_httpTransporter := this.gethttptransporter()
	mut var_params := this.preparegeneratetextparams(mut var_prompt)
	mut var_request := this.createrequest(mut rt.cast_object_ptr[Class_WordPress_AiClient_Providers_Http_Enums_HttpMethodEnum](fn () rt.PhpVal { mut temp := Class_WordPress_AiClient_Providers_Http_Enums_HttpMethodEnum{}; return temp.post() }()), 'chat/completions', mut rt.cast_object_ptr[Class_WordPress_AiClient_Providers_OpenAiCompatibleImplementation_array](rt.create_array([rt.ArrayItem{ key: 'Content-Type', val: 'application/json' }])), var_params.dup())
	var_request = rt.call_method(this.getrequestauthentication(), 'authenticateRequest', [var_request.dup()])
	mut var_response := rt.call_method(var_httpTransporter, 'send', [var_request.dup()])
	this.throwifnotsuccessful(mut rt.cast_object_ptr[Class_WordPress_AiClient_Providers_Http_DTO_Response](var_response))
	return this.parseresponsetogenerativeairesult(mut rt.cast_object_ptr[Class_WordPress_AiClient_Providers_Http_DTO_Response](var_response))
}

fn (mut this Class_WordPress_AiClient_Providers_OpenAiCompatibleImplementation_AbstractOpenAiCompatibleTextGenerationModel) preparegeneratetextparams(mut var_prompt Class_WordPress_AiClient_Providers_OpenAiCompatibleImplementation_array) rt.PhpVal {
	mut var_config := this.getconfig()
	mut var_params := rt.create_array([rt.ArrayItem{ key: 'model', val: rt.call_method(this.metadata(), 'getId', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'messages', val: this.preparemessagesparam(mut var_prompt, mut rt.cast_object_ptr[Class_WordPress_AiClient_Providers_OpenAiCompatibleImplementation_?string](rt.call_method(var_config, 'getSystemInstruction', []rt.PhpVal{}))) }])
	mut var_outputModalities := rt.call_method(var_config, 'getOutputModalities', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(var_outputModalities.dup().is_array())) {
		this.validateoutputmodalities(mut rt.cast_object_ptr[Class_WordPress_AiClient_Providers_OpenAiCompatibleImplementation_array](var_outputModalities))
		if var_outputModalities.dup().array_count() > 1 {
			var_params.array_set('modalities', this.prepareoutputmodalitiesparam(mut rt.cast_object_ptr[Class_WordPress_AiClient_Providers_OpenAiCompatibleImplementation_array](var_outputModalities)))
		}
	}
	mut var_candidateCount := rt.call_method(var_config, 'getCandidateCount', []rt.PhpVal{})
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		var_params.array_set('n', var_candidateCount.dup())
	}
	mut var_maxTokens := rt.call_method(var_config, 'getMaxTokens', []rt.PhpVal{})
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		var_params.array_set('max_tokens', var_maxTokens.dup())
	}
	mut var_temperature := rt.call_method(var_config, 'getTemperature', []rt.PhpVal{})
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		var_params.array_set('temperature', var_temperature.dup())
	}
	mut var_topP := rt.call_method(var_config, 'getTopP', []rt.PhpVal{})
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		var_params.array_set('top_p', var_topP.dup())
	}
	mut var_stopSequences := rt.call_method(var_config, 'getStopSequences', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(var_stopSequences.dup().is_array())) {
		var_params.array_set('stop', var_stopSequences.dup())
	}
	mut var_presencePenalty := rt.call_method(var_config, 'getPresencePenalty', []rt.PhpVal{})
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		var_params.array_set('presence_penalty', var_presencePenalty.dup())
	}
	mut var_frequencyPenalty := rt.call_method(var_config, 'getFrequencyPenalty', []rt.PhpVal{})
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		var_params.array_set('frequency_penalty', var_frequencyPenalty.dup())
	}
	mut var_logprobs := rt.call_method(var_config, 'getLogprobs', []rt.PhpVal{})
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		var_params.array_set('logprobs', var_logprobs.dup())
	}
	mut var_topLogprobs := rt.call_method(var_config, 'getTopLogprobs', []rt.PhpVal{})
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		var_params.array_set('top_logprobs', var_topLogprobs.dup())
	}
	mut var_functionDeclarations := rt.call_method(var_config, 'getFunctionDeclarations', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(var_functionDeclarations.dup().is_array())) {
		var_params.array_set('tools', this.preparetoolsparam(mut rt.cast_object_ptr[Class_WordPress_AiClient_Providers_OpenAiCompatibleImplementation_array](var_functionDeclarations)))
	}
	mut var_outputMimeType := rt.call_method(var_config, 'getOutputMimeType', []rt.PhpVal{})
	if rt.is_true(rt.identical(rt.new_string('application/json'), var_outputMimeType)) {
		mut var_outputSchema := rt.call_method(var_config, 'getOutputSchema', []rt.PhpVal{})
		var_params.array_set('response_format', this.prepareresponseformatparam(mut rt.cast_object_ptr[Class_WordPress_AiClient_Providers_OpenAiCompatibleImplementation_?array](var_outputSchema)))
	}
	mut var_customOptions := rt.call_method(var_config, 'getCustomOptions', []rt.PhpVal{})
	{
		mut iter_1 := var_customOptions.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_value := item_1.val
			mut var_key := item_1.key
			if var_params.array_isset(var_key) {
				rt.throw_exception(rt.new_object('WordPress_AiClient_Common_Exception_InvalidArgumentException', []string{}, create_wordpress_aiclient_common_exception_invalidargumentexception(rt.call_function('sprintf', [rt.new_string('The custom option "%s" conflicts with an existing parameter.'), var_key.dup()]))))
			}
			var_params.array_set(var_key, var_value.dup())
		}
	}
	return var_params.dup()
}

fn (mut this Class_WordPress_AiClient_Providers_OpenAiCompatibleImplementation_AbstractOpenAiCompatibleTextGenerationModel) preparemessagesparam(mut var_messages Class_WordPress_AiClient_Providers_OpenAiCompatibleImplementation_array, mut var_systemInstruction Class_WordPress_AiClient_Providers_OpenAiCompatibleImplementation_?string) rt.PhpVal {
	closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_message := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	mut var_messageParts := rt.call_method(var_message, 'getParts', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(var_messageParts.dup().array_count() == 1 && rt.is_true(rt.call_method(rt.call_method(var_messageParts.array_get(0), 'getType', []rt.PhpVal{}), 'isFunctionResponse', []rt.PhpVal{})))) {
		mut var_functionResponse := rt.call_method(var_messageParts.array_get(0), 'getFunctionResponse', []rt.PhpVal{})
		if rt.is_true(rt.new_bool(!(rt.is_true(var_functionResponse)))) {
			rt.throw_exception(rt.new_object('WordPress_AiClient_Common_Exception_RuntimeException', []string{}, create_wordpress_aiclient_common_exception_runtimeexception(rt.new_string('The function response typed message part must contain a function response.'))))
		}
		return rt.create_array([rt.ArrayItem{ key: 'role', val: 'tool' }, rt.ArrayItem{ key: 'content', val: rt.json_encode(rt.call_method(var_functionResponse, 'getResponse', []rt.PhpVal{})) }, rt.ArrayItem{ key: 'tool_call_id', val: rt.call_method(var_functionResponse, 'getId', []rt.PhpVal{}) }])
	}
	mut var_messageData := rt.create_array([rt.ArrayItem{ key: 'role', val: this.getmessagerolestring(mut rt.cast_object_ptr[Class_WordPress_AiClient_Messages_Enums_MessageRoleEnum](rt.call_method(var_message, 'getRole', []rt.PhpVal{}))) }, rt.ArrayItem{ key: 'content', val: rt.call_function('array_values', [rt.call_function('array_filter', [rt.call_function('array_map', [rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WordPress_AiClient_Providers_OpenAiCompatibleImplementation_AbstractOpenAiCompatibleTextGenerationModel', ['WordPress_AiClient_Providers_ApiBasedImplementation_AbstractApiBasedModel', 'TextGenerationModelInterface'], &this) }, rt.ArrayItem{ key: none, val: 'getMessagePartContentData' }]), var_messageParts.dup()])])]) }])
	mut var_toolCalls := rt.call_function('array_values', [rt.call_function('array_filter', [rt.call_function('array_map', [rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WordPress_AiClient_Providers_OpenAiCompatibleImplementation_AbstractOpenAiCompatibleTextGenerationModel', ['WordPress_AiClient_Providers_ApiBasedImplementation_AbstractApiBasedModel', 'TextGenerationModelInterface'], &this) }, rt.ArrayItem{ key: none, val: 'getMessagePartToolCallData' }]), var_messageParts.dup()])])])
	if !(!rt.is_true(var_toolCalls)) {
		var_messageData.array_set('tool_calls', var_toolCalls.dup())
	}
	return var_messageData.dup()
	}
	mut var_message := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	mut var_messageParts := rt.call_method(var_message, 'getParts', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(var_messageParts.dup().array_count() == 1 && rt.is_true(rt.call_method(rt.call_method(var_messageParts.array_get(0), 'getType', []rt.PhpVal{}), 'isFunctionResponse', []rt.PhpVal{})))) {
		mut var_functionResponse := rt.call_method(var_messageParts.array_get(0), 'getFunctionResponse', []rt.PhpVal{})
		if rt.is_true(rt.new_bool(!(rt.is_true(var_functionResponse)))) {
			rt.throw_exception(rt.new_object('WordPress_AiClient_Common_Exception_RuntimeException', []string{}, create_wordpress_aiclient_common_exception_runtimeexception(rt.new_string('The function response typed message part must contain a function response.'))))
		}
		return rt.create_array([rt.ArrayItem{ key: 'role', val: 'tool' }, rt.ArrayItem{ key: 'content', val: rt.json_encode(rt.call_method(var_functionResponse, 'getResponse', []rt.PhpVal{})) }, rt.ArrayItem{ key: 'tool_call_id', val: rt.call_method(var_functionResponse, 'getId', []rt.PhpVal{}) }])
	}
	mut var_messageData := rt.create_array([rt.ArrayItem{ key: 'role', val: this.getmessagerolestring(mut rt.cast_object_ptr[Class_WordPress_AiClient_Messages_Enums_MessageRoleEnum](rt.call_method(var_message, 'getRole', []rt.PhpVal{}))) }, rt.ArrayItem{ key: 'content', val: rt.call_function('array_values', [rt.call_function('array_filter', [rt.call_function('array_map', [rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WordPress_AiClient_Providers_OpenAiCompatibleImplementation_AbstractOpenAiCompatibleTextGenerationModel', ['WordPress_AiClient_Providers_ApiBasedImplementation_AbstractApiBasedModel', 'TextGenerationModelInterface'], &this) }, rt.ArrayItem{ key: none, val: 'getMessagePartContentData' }]), var_messageParts.dup()])])]) }])
	mut var_toolCalls := rt.call_function('array_values', [rt.call_function('array_filter', [rt.call_function('array_map', [rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WordPress_AiClient_Providers_OpenAiCompatibleImplementation_AbstractOpenAiCompatibleTextGenerationModel', ['WordPress_AiClient_Providers_ApiBasedImplementation_AbstractApiBasedModel', 'TextGenerationModelInterface'], &this) }, rt.ArrayItem{ key: none, val: 'getMessagePartToolCallData' }]), var_messageParts.dup()])])])
	if !(!rt.is_true(var_toolCalls)) {
		var_messageData.array_set('tool_calls', var_toolCalls.dup())
	}
	return var_messageData.dup()
	}
	mut var_messagesParam := rt.call_function('array_map', [rt.new_closure(closure_1_fn), var_messages])
	if rt.is_true(var_systemInstruction) {
		rt.call_function('array_unshift', [var_messagesParam.dup(), rt.create_array([rt.ArrayItem{ key: 'role', val: 'system' }, rt.ArrayItem{ key: 'content', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'text' }, rt.ArrayItem{ key: 'text', val: var_systemInstruction }]) }]) }])])
	}
	return var_messagesParam.dup()
}

fn (mut this Class_WordPress_AiClient_Providers_OpenAiCompatibleImplementation_AbstractOpenAiCompatibleTextGenerationModel) getmessagerolestring(mut var_role Class_WordPress_AiClient_Messages_Enums_MessageRoleEnum) string {
	mut var_role_mutated := var_role
	if rt.is_true(rt.identical(var_role_mutated, fn () rt.PhpVal { mut temp := Class_WordPress_AiClient_Messages_Enums_MessageRoleEnum{}; return temp.model() }())) {
		return 'assistant'
	}
	return 'user'
}

fn (mut this Class_WordPress_AiClient_Providers_OpenAiCompatibleImplementation_AbstractOpenAiCompatibleTextGenerationModel) getmessagepartcontentdata(mut var_part Class_WordPress_AiClient_Messages_DTO_MessagePart) rt.PhpVal {
	mut var_type := var_part.gettype()
	if rt.is_true(rt.call_method(var_type, 'isText', []rt.PhpVal{})) {
		if rt.is_true(rt.call_method(var_part.getchannel(), 'isThought', []rt.PhpVal{})) {
			return rt.new_null()
		}
		return rt.create_array([rt.ArrayItem{ key: 'type', val: 'text' }, rt.ArrayItem{ key: 'text', val: var_part.gettext() }])
	}
	if rt.is_true(rt.call_method(var_type, 'isFile', []rt.PhpVal{})) {
		mut var_file := var_part.getfile()
		if rt.is_true(rt.new_bool(!(rt.is_true(var_file)))) {
			rt.throw_exception(rt.new_object('WordPress_AiClient_Common_Exception_RuntimeException', []string{}, create_wordpress_aiclient_common_exception_runtimeexception(rt.new_string('The file typed message part must contain a file.'))))
		}
		if rt.is_true(rt.call_method(var_file, 'isRemote', []rt.PhpVal{})) {
			if rt.is_true(rt.call_method(var_file, 'isImage', []rt.PhpVal{})) {
				return rt.create_array([rt.ArrayItem{ key: 'type', val: 'image_url' }, rt.ArrayItem{ key: 'image_url', val: rt.create_array([rt.ArrayItem{ key: 'url', val: rt.call_method(var_file, 'getUrl', []rt.PhpVal{}) }]) }])
			}
			rt.throw_exception(rt.new_object('WordPress_AiClient_Common_Exception_InvalidArgumentException', []string{}, create_wordpress_aiclient_common_exception_invalidargumentexception(rt.call_function('sprintf', [rt.new_string('Unsupported MIME type "%s" for remote file message part.'), rt.call_method(var_file, 'getMimeType', []rt.PhpVal{})]))))
		}
		if rt.is_true(rt.call_method(var_file, 'isImage', []rt.PhpVal{})) {
			return rt.create_array([rt.ArrayItem{ key: 'type', val: 'image_url' }, rt.ArrayItem{ key: 'image_url', val: rt.create_array([rt.ArrayItem{ key: 'url', val: rt.call_method(var_file, 'getDataUri', []rt.PhpVal{}) }]) }])
		}
		if rt.is_true(rt.call_method(var_file, 'isAudio', []rt.PhpVal{})) {
			return rt.create_array([rt.ArrayItem{ key: 'type', val: 'input_audio' }, rt.ArrayItem{ key: 'input_audio', val: rt.create_array([rt.ArrayItem{ key: 'data', val: rt.call_method(var_file, 'getBase64Data', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'format', val: rt.call_method(rt.call_method(var_file, 'getMimeTypeObject', []rt.PhpVal{}), 'toExtension', []rt.PhpVal{}) }]) }])
		}
		rt.throw_exception(rt.new_object('WordPress_AiClient_Common_Exception_InvalidArgumentException', []string{}, create_wordpress_aiclient_common_exception_invalidargumentexception(rt.call_function('sprintf', [rt.new_string('Unsupported MIME type "%s" for inline file message part.'), rt.call_method(var_file, 'getMimeType', []rt.PhpVal{})]))))
	}
	if rt.is_true(rt.call_method(var_type, 'isFunctionCall', []rt.PhpVal{})) {
		return rt.new_null()
	}
	if rt.is_true(rt.call_method(var_type, 'isFunctionResponse', []rt.PhpVal{})) {
		rt.throw_exception(rt.new_object('WordPress_AiClient_Common_Exception_InvalidArgumentException', []string{}, create_wordpress_aiclient_common_exception_invalidargumentexception(rt.new_string('The API only allows a single function response, as the only content of the message.'))))
	}
	rt.throw_exception(rt.new_object('WordPress_AiClient_Common_Exception_InvalidArgumentException', []string{}, create_wordpress_aiclient_common_exception_invalidargumentexception(rt.call_function('sprintf', [, .dup()]))))
	return rt.new_null()
}

fn (mut this Class_WordPress_AiClient_Providers_OpenAiCompatibleImplementation_AbstractOpenAiCompatibleTextGenerationModel) getmessageparttoolcalldata(mut var_part Class_WordPress_AiClient_Messages_DTO_MessagePart) rt.PhpVal {
	mut var_type := .gettype()
	if rt.is_true(rt.call_method(, 'isFunctionCall', []rt.PhpVal{})) {
		
	}
	return 
}

fn (mut this Class_WordPress_AiClient_Providers_OpenAiCompatibleImplementation_AbstractOpenAiCompatibleTextGenerationModel) validateoutputmodalities(mut var_outputModalities Class_WordPress_AiClient_Providers_OpenAiCompatibleImplementation_array)  {
	mut var_outputModalities_mutated := var_outputModalities
}

fn (mut this Class_WordPress_AiClient_Providers_OpenAiCompatibleImplementation_AbstractOpenAiCompatibleTextGenerationModel) prepareoutputmodalitiesparam(mut var_modalities Class_WordPress_AiClient_Providers_OpenAiCompatibleImplementation_array) rt.PhpVal {
}

fn (mut this Class_WordPress_AiClient_Providers_OpenAiCompatibleImplementation_AbstractOpenAiCompatibleTextGenerationModel) preparetoolsparam(mut var_functionDeclarations Class_WordPress_AiClient_Providers_OpenAiCompatibleImplementation_array) rt.PhpVal {
	mut var_functionDeclarations_mutated := var_functionDeclarations
}

fn (mut this Class_WordPress_AiClient_Providers_OpenAiCompatibleImplementation_AbstractOpenAiCompatibleTextGenerationModel) prepareresponseformatparam(mut var_outputSchema Class_WordPress_AiClient_Providers_OpenAiCompatibleImplementation_?array) rt.PhpVal {
	mut var_outputSchema_mutated := var_outputSchema
}

fn (mut this Class_WordPress_AiClient_Providers_OpenAiCompatibleImplementation_AbstractOpenAiCompatibleTextGenerationModel) createrequest(mut var_method Class_WordPress_AiClient_Providers_Http_Enums_HttpMethodEnum, path string, mut var_headers Class_WordPress_AiClient_Providers_OpenAiCompatibleImplementation_array, var_data rt.PhpVal)  {
}

fn (mut this Class_WordPress_AiClient_Providers_OpenAiCompatibleImplementation_AbstractOpenAiCompatibleTextGenerationModel) throwifnotsuccessful(mut var_response Class_WordPress_AiClient_Providers_Http_DTO_Response)  {
	mut var_response_mutated := var_response
}

fn (mut this Class_WordPress_AiClient_Providers_OpenAiCompatibleImplementation_AbstractOpenAiCompatibleTextGenerationModel) parseresponsetogenerativeairesult(mut var_response Class_WordPress_AiClient_Providers_Http_DTO_Response) rt.PhpVal {
	mut var_response_mutated := var_response
}

fn (mut this Class_WordPress_AiClient_Providers_OpenAiCompatibleImplementation_AbstractOpenAiCompatibleTextGenerationModel) parseresponsechoicetocandidate(mut var_choiceData Class_WordPress_AiClient_Providers_OpenAiCompatibleImplementation_array, index i64) rt.PhpVal {
}

fn (mut this Class_WordPress_AiClient_Providers_OpenAiCompatibleImplementation_AbstractOpenAiCompatibleTextGenerationModel) parseresponsechoicemessage(mut var_messageData Class_WordPress_AiClient_Providers_OpenAiCompatibleImplementation_array, index i64) rt.PhpVal {
	mut var_messageData_mutated := var_messageData
}

fn (mut this Class_WordPress_AiClient_Providers_OpenAiCompatibleImplementation_AbstractOpenAiCompatibleTextGenerationModel) parseresponsechoicemessageparts(mut var_messageData Class_WordPress_AiClient_Providers_OpenAiCompatibleImplementation_array, index i64) rt.PhpVal {
	mut var_messageData_mutated := var_messageData
}

fn (mut this Class_WordPress_AiClient_Providers_OpenAiCompatibleImplementation_AbstractOpenAiCompatibleTextGenerationModel) parseresponsechoicemessagetoolcallpart(mut var_toolCallData Class_WordPress_AiClient_Providers_OpenAiCompatibleImplementation_array) rt.PhpVal {
}

struct Class_WordPress_AiClient_Providers_ApiBasedImplementation_AbstractApiBasedModel {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClient_Providers_Http_Enums_HttpMethodEnum {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClient_Common_Exception_InvalidArgumentException {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClient_Common_Exception_RuntimeException {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClient_Messages_Enums_MessageRoleEnum {
	rt.PhpObjectBase
}

fn create_wordpress_aiclient_providers_openaicompatibleimplementation_abstractopenaicompatibletextgenerationmodel() &Class_WordPress_AiClient_Providers_OpenAiCompatibleImplementation_AbstractOpenAiCompatibleTextGenerationModel {
	mut obj := &Class_WordPress_AiClient_Providers_OpenAiCompatibleImplementation_AbstractOpenAiCompatibleTextGenerationModel{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wordpress_aiclient_providers_apibasedimplementation_abstractapibasedmodel() &Class_WordPress_AiClient_Providers_ApiBasedImplementation_AbstractApiBasedModel {
	mut obj := &Class_WordPress_AiClient_Providers_ApiBasedImplementation_AbstractApiBasedModel{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wordpress_aiclient_providers_http_enums_httpmethodenum() &Class_WordPress_AiClient_Providers_Http_Enums_HttpMethodEnum {
	mut obj := &Class_WordPress_AiClient_Providers_Http_Enums_HttpMethodEnum{
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

fn create_wordpress_aiclient_common_exception_runtimeexception() &Class_WordPress_AiClient_Common_Exception_RuntimeException {
	mut obj := &Class_WordPress_AiClient_Common_Exception_RuntimeException{
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

fn (mut this Class_WordPress_AiClient_Providers_OpenAiCompatibleImplementation_AbstractOpenAiCompatibleTextGenerationModel) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'generateTextResult' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WordPress_AiClient_Providers_OpenAiCompatibleImplementation_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.generatetextresult(mut dispatch_arg_0)
		}
		'prepareGenerateTextParams' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WordPress_AiClient_Providers_OpenAiCompatibleImplementation_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.preparegeneratetextparams(mut dispatch_arg_0)
		}
		'prepareMessagesParam' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WordPress_AiClient_Providers_OpenAiCompatibleImplementation_array](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_WordPress_AiClient_Providers_OpenAiCompatibleImplementation_?string](if args.len > 1 { args[1] } else { rt.new_null() })
			return this.preparemessagesparam(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		'getMessageRoleString' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WordPress_AiClient_Messages_Enums_MessageRoleEnum](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_string(this.getmessagerolestring(mut dispatch_arg_0))
		}
		'getMessagePartContentData' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WordPress_AiClient_Messages_DTO_MessagePart](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.getmessagepartcontentdata(mut dispatch_arg_0)
		}
		'getMessagePartToolCallData' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WordPress_AiClient_Messages_DTO_MessagePart](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.getmessageparttoolcalldata(mut dispatch_arg_0)
		}
		'validateOutputModalities' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WordPress_AiClient_Providers_OpenAiCompatibleImplementation_array](if args.len > 0 { args[0] } else { rt.new_null() })
			this.validateoutputmodalities(mut dispatch_arg_0)
			return rt.new_null()
		}
		'prepareOutputModalitiesParam' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WordPress_AiClient_Providers_OpenAiCompatibleImplementation_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.prepareoutputmodalitiesparam(mut dispatch_arg_0)
		}
		'prepareToolsParam' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WordPress_AiClient_Providers_OpenAiCompatibleImplementation_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.preparetoolsparam(mut dispatch_arg_0)
		}
		'prepareResponseFormatParam' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WordPress_AiClient_Providers_OpenAiCompatibleImplementation_?array](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.prepareresponseformatparam(mut dispatch_arg_0)
		}
		'createRequest' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WordPress_AiClient_Providers_Http_Enums_HttpMethodEnum](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_WordPress_AiClient_Providers_OpenAiCompatibleImplementation_array](if args.len > 2 { args[2] } else { rt.new_null() })
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			this.createrequest(mut dispatch_arg_0, dispatch_arg_1, mut dispatch_arg_2, dispatch_arg_3)
			return rt.new_null()
		}
		'throwIfNotSuccessful' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WordPress_AiClient_Providers_Http_DTO_Response](if args.len > 0 { args[0] } else { rt.new_null() })
			this.throwifnotsuccessful(mut dispatch_arg_0)
			return rt.new_null()
		}
		'parseResponseToGenerativeAiResult' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WordPress_AiClient_Providers_Http_DTO_Response](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.parseresponsetogenerativeairesult(mut dispatch_arg_0)
		}
		'parseResponseChoiceToCandidate' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WordPress_AiClient_Providers_OpenAiCompatibleImplementation_array](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			return this.parseresponsechoicetocandidate(mut dispatch_arg_0, dispatch_arg_1)
		}
		'parseResponseChoiceMessage' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WordPress_AiClient_Providers_OpenAiCompatibleImplementation_array](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			return this.parseresponsechoicemessage(mut dispatch_arg_0, dispatch_arg_1)
		}
		'parseResponseChoiceMessageParts' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WordPress_AiClient_Providers_OpenAiCompatibleImplementation_array](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			return this.parseresponsechoicemessageparts(mut dispatch_arg_0, dispatch_arg_1)
		}
		'parseResponseChoiceMessageToolCallPart' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WordPress_AiClient_Providers_OpenAiCompatibleImplementation_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.parseresponsechoicemessagetoolcallpart(mut dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_WordPress_AiClient_Providers_OpenAiCompatibleImplementation_AbstractOpenAiCompatibleTextGenerationModel) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClient_Providers_OpenAiCompatibleImplementation_AbstractOpenAiCompatibleTextGenerationModel) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WordPress_AiClient_Providers_ApiBasedImplementation_AbstractApiBasedModel) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WordPress_AiClient_Providers_ApiBasedImplementation_AbstractApiBasedModel) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClient_Providers_ApiBasedImplementation_AbstractApiBasedModel) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WordPress_AiClient_Providers_Http_Enums_HttpMethodEnum) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WordPress_AiClient_Providers_Http_Enums_HttpMethodEnum) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClient_Providers_Http_Enums_HttpMethodEnum) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_WordPress_AiClient_Common_Exception_RuntimeException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WordPress_AiClient_Common_Exception_RuntimeException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClient_Common_Exception_RuntimeException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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




pub fn init_wp_includes_php_ai_client_src_providers_openaicompatibleimplementation_abstractopenaicompatibletextgenerationmodel_php() {
	// unsupported statement: Stmt_Declare
}
