import rt

struct Class_WordPress_AiClient_Providers_OpenAiCompatibleImplementation_AbstractOpenAiCompatibleTextGenerationModel {
	rt.PhpObjectBase
}

fn (mut this Class_WordPress_AiClient_Providers_OpenAiCompatibleImplementation_AbstractOpenAiCompatibleTextGenerationModel) generatetextresult(mut var_prompt Class_WordPress_AiClient_Providers_OpenAiCompatibleImplementation_array) rt.PhpVal {
	mut var_httpTransporter := this.gethttptransporter()
	mut var_params := this.preparegeneratetextparams(mut var_prompt)
	mut iife_temp_0 := Class_WordPress_AiClient_Providers_Http_Enums_HttpMethodEnum{}
	mut iife_result_0 := iife_temp_0.post()
	mut var_request := this.createrequest(mut rt.cast_object_ptr[Class_WordPress_AiClient_Providers_Http_Enums_HttpMethodEnum](iife_result_0), 'chat/completions', mut rt.cast_object_ptr[Class_WordPress_AiClient_Providers_OpenAiCompatibleImplementation_array](rt.create_array([rt.ArrayItem{ key: 'Content-Type', val: 'application/json' }])), var_params.clone())
	var_request = rt.call_method(this.getrequestauthentication(), 'authenticateRequest', [var_request.clone()])
	mut var_response := rt.call_method(var_httpTransporter, 'send', [var_request.clone()])
	this.throwifnotsuccessful(mut rt.cast_object_ptr[Class_WordPress_AiClient_Providers_Http_DTO_Response](var_response))
	return this.parseresponsetogenerativeairesult(mut rt.cast_object_ptr[Class_WordPress_AiClient_Providers_Http_DTO_Response](var_response))
}

fn (mut this Class_WordPress_AiClient_Providers_OpenAiCompatibleImplementation_AbstractOpenAiCompatibleTextGenerationModel) preparegeneratetextparams(mut var_prompt Class_WordPress_AiClient_Providers_OpenAiCompatibleImplementation_array) rt.PhpVal {
	mut var_config := this.getconfig()
	mut var_params := rt.create_array([rt.ArrayItem{ key: 'model', val: rt.call_method(this.metadata(), 'getId', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'messages', val: this.preparemessagesparam(mut var_prompt, mut rt.cast_object_ptr[Class_WordPress_AiClient_Providers_OpenAiCompatibleImplementation_?string](rt.call_method(var_config, 'getSystemInstruction', []rt.PhpVal{}))) }])
	mut var_outputModalities := rt.call_method(var_config, 'getOutputModalities', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(var_outputModalities.clone().is_array())) {
		this.validateoutputmodalities(mut rt.cast_object_ptr[Class_WordPress_AiClient_Providers_OpenAiCompatibleImplementation_array](var_outputModalities))
		if var_outputModalities.clone().array_count() > 1 {
			var_params.array_set('modalities', this.prepareoutputmodalitiesparam(mut rt.cast_object_ptr[Class_WordPress_AiClient_Providers_OpenAiCompatibleImplementation_array](var_outputModalities)))
		}
	}
	mut var_candidateCount := rt.call_method(var_config, 'getCandidateCount', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_candidateCount, rt.new_null())))) {
		var_params.array_set('n', var_candidateCount.clone())
	}
	mut var_maxTokens := rt.call_method(var_config, 'getMaxTokens', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_maxTokens, rt.new_null())))) {
		var_params.array_set('max_tokens', var_maxTokens.clone())
	}
	mut var_temperature := rt.call_method(var_config, 'getTemperature', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_temperature, rt.new_null())))) {
		var_params.array_set('temperature', var_temperature.clone())
	}
	mut var_topP := rt.call_method(var_config, 'getTopP', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_topP, rt.new_null())))) {
		var_params.array_set('top_p', var_topP.clone())
	}
	mut var_stopSequences := rt.call_method(var_config, 'getStopSequences', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(var_stopSequences.clone().is_array())) {
		var_params.array_set('stop', var_stopSequences.clone())
	}
	mut var_presencePenalty := rt.call_method(var_config, 'getPresencePenalty', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_presencePenalty, rt.new_null())))) {
		var_params.array_set('presence_penalty', var_presencePenalty.clone())
	}
	mut var_frequencyPenalty := rt.call_method(var_config, 'getFrequencyPenalty', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_frequencyPenalty, rt.new_null())))) {
		var_params.array_set('frequency_penalty', var_frequencyPenalty.clone())
	}
	mut var_logprobs := rt.call_method(var_config, 'getLogprobs', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_logprobs, rt.new_null())))) {
		var_params.array_set('logprobs', var_logprobs.clone())
	}
	mut var_topLogprobs := rt.call_method(var_config, 'getTopLogprobs', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_topLogprobs, rt.new_null())))) {
		var_params.array_set('top_logprobs', var_topLogprobs.clone())
	}
	mut var_functionDeclarations := rt.call_method(var_config, 'getFunctionDeclarations', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(var_functionDeclarations.clone().is_array())) {
		var_params.array_set('tools', this.preparetoolsparam(mut rt.cast_object_ptr[Class_WordPress_AiClient_Providers_OpenAiCompatibleImplementation_array](var_functionDeclarations)))
	}
	mut var_outputMimeType := rt.call_method(var_config, 'getOutputMimeType', []rt.PhpVal{})
	if rt.is_true(rt.identical(rt.new_string('application/json'), var_outputMimeType)) {
		mut var_outputSchema := rt.call_method(var_config, 'getOutputSchema', []rt.PhpVal{})
		var_params.array_set('response_format', this.prepareresponseformatparam(mut rt.cast_object_ptr[Class_WordPress_AiClient_Providers_OpenAiCompatibleImplementation_?array](var_outputSchema)))
	}
	mut var_customOptions := rt.call_method(var_config, 'getCustomOptions', []rt.PhpVal{})
	mut iter_1 := var_customOptions.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_value := item_1.val
		mut var_key := item_1.key
		if var_params.array_isset(var_key) {
			rt.throw_exception(rt.new_object('WordPress_AiClient_Common_Exception_InvalidArgumentException', []string{}, create_wordpress_aiclient_common_exception_invalidargumentexception(rt.call_function('sprintf', [rt.new_string('The custom option "%s" conflicts with an existing parameter.'), var_key.clone()]))))
		}
		var_params.array_set(var_key, var_value.clone())
	}
	return var_params.clone()
}

fn (mut this Class_WordPress_AiClient_Providers_OpenAiCompatibleImplementation_AbstractOpenAiCompatibleTextGenerationModel) preparemessagesparam(mut var_messages Class_WordPress_AiClient_Providers_OpenAiCompatibleImplementation_array, mut var_systemInstruction Class_WordPress_AiClient_Providers_OpenAiCompatibleImplementation_?string) rt.PhpVal {
	closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_message := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_messageParts := rt.call_method(var_message, 'getParts', []rt.PhpVal{})
		if var_messageParts.clone().array_count() == 1 && rt.is_true(rt.call_method(rt.call_method(var_messageParts.array_get(rt.new_int(0)), 'getType', []rt.PhpVal{}), 'isFunctionResponse', []rt.PhpVal{})) {
			mut var_functionResponse := rt.call_method(var_messageParts.array_get(rt.new_int(0)), 'getFunctionResponse', []rt.PhpVal{})
			if rt.is_true(rt.new_bool(!(rt.is_true(var_functionResponse)))) {
				rt.throw_exception(rt.new_object('WordPress_AiClient_Common_Exception_RuntimeException', []string{}, create_wordpress_aiclient_common_exception_runtimeexception(rt.new_string('The function response typed message part must contain a function response.'))))
			}
			return rt.create_array([rt.ArrayItem{ key: 'role', val: 'tool' }, rt.ArrayItem{ key: 'content', val: rt.json_encode(rt.call_method(var_functionResponse, 'getResponse', []rt.PhpVal{})) }, rt.ArrayItem{ key: 'tool_call_id', val: rt.call_method(var_functionResponse, 'getId', []rt.PhpVal{}) }])
		}
		mut var_messageData := rt.create_array([rt.ArrayItem{ key: 'role', val: this.getmessagerolestring(mut rt.cast_object_ptr[Class_WordPress_AiClient_Messages_Enums_MessageRoleEnum](rt.call_method(var_message, 'getRole', []rt.PhpVal{}))) }, rt.ArrayItem{ key: 'content', val: rt.call_function('array_values', [rt.call_function('array_filter', [rt.call_function('array_map', [rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WordPress_AiClient_Providers_OpenAiCompatibleImplementation_AbstractOpenAiCompatibleTextGenerationModel', ['WordPress_AiClient_Providers_ApiBasedImplementation_AbstractApiBasedModel', 'TextGenerationModelInterface'], &this) }, rt.ArrayItem{ key: none, val: 'getMessagePartContentData' }]), var_messageParts.clone()])])]) }])
		mut var_toolCalls := rt.call_function('array_values', [rt.call_function('array_filter', [rt.call_function('array_map', [rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WordPress_AiClient_Providers_OpenAiCompatibleImplementation_AbstractOpenAiCompatibleTextGenerationModel', ['WordPress_AiClient_Providers_ApiBasedImplementation_AbstractApiBasedModel', 'TextGenerationModelInterface'], &this) }, rt.ArrayItem{ key: none, val: 'getMessagePartToolCallData' }]), var_messageParts.clone()])])])
		if !(!rt.is_true(var_toolCalls)) {
			var_messageData.array_set('tool_calls', var_toolCalls.clone())
		}
		return var_messageData.clone()
		}
	closure_3_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_message := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_messageParts := rt.call_method(var_message, 'getParts', []rt.PhpVal{})
		if var_messageParts.clone().array_count() == 1 && rt.is_true(rt.call_method(rt.call_method(var_messageParts.array_get(rt.new_int(0)), 'getType', []rt.PhpVal{}), 'isFunctionResponse', []rt.PhpVal{})) {
			mut var_functionResponse := rt.call_method(var_messageParts.array_get(rt.new_int(0)), 'getFunctionResponse', []rt.PhpVal{})
			if rt.is_true(rt.new_bool(!(rt.is_true(var_functionResponse)))) {
				rt.throw_exception(rt.new_object('WordPress_AiClient_Common_Exception_RuntimeException', []string{}, create_wordpress_aiclient_common_exception_runtimeexception(rt.new_string('The function response typed message part must contain a function response.'))))
			}
			return rt.create_array([rt.ArrayItem{ key: 'role', val: 'tool' }, rt.ArrayItem{ key: 'content', val: rt.json_encode(rt.call_method(var_functionResponse, 'getResponse', []rt.PhpVal{})) }, rt.ArrayItem{ key: 'tool_call_id', val: rt.call_method(var_functionResponse, 'getId', []rt.PhpVal{}) }])
		}
		mut var_messageData := rt.create_array([rt.ArrayItem{ key: 'role', val: this.getmessagerolestring(mut rt.cast_object_ptr[Class_WordPress_AiClient_Messages_Enums_MessageRoleEnum](rt.call_method(var_message, 'getRole', []rt.PhpVal{}))) }, rt.ArrayItem{ key: 'content', val: rt.call_function('array_values', [rt.call_function('array_filter', [rt.call_function('array_map', [rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WordPress_AiClient_Providers_OpenAiCompatibleImplementation_AbstractOpenAiCompatibleTextGenerationModel', ['WordPress_AiClient_Providers_ApiBasedImplementation_AbstractApiBasedModel', 'TextGenerationModelInterface'], &this) }, rt.ArrayItem{ key: none, val: 'getMessagePartContentData' }]), var_messageParts.clone()])])]) }])
		mut var_toolCalls := rt.call_function('array_values', [rt.call_function('array_filter', [rt.call_function('array_map', [rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WordPress_AiClient_Providers_OpenAiCompatibleImplementation_AbstractOpenAiCompatibleTextGenerationModel', ['WordPress_AiClient_Providers_ApiBasedImplementation_AbstractApiBasedModel', 'TextGenerationModelInterface'], &this) }, rt.ArrayItem{ key: none, val: 'getMessagePartToolCallData' }]), var_messageParts.clone()])])])
		if !(!rt.is_true(var_toolCalls)) {
			var_messageData.array_set('tool_calls', var_toolCalls.clone())
		}
		return var_messageData.clone()
		}
	mut var_messagesParam := rt.call_function('array_map', [rt.new_closure(closure_2_fn), var_messages])
	if rt.is_true(var_systemInstruction) {
		rt.call_function('array_unshift', [var_messagesParam.clone(), rt.create_array([rt.ArrayItem{ key: 'role', val: 'system' }, rt.ArrayItem{ key: 'content', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'text' }, rt.ArrayItem{ key: 'text', val: var_systemInstruction }]) }]) }])])
	}
	return var_messagesParam.clone()
}

fn (mut this Class_WordPress_AiClient_Providers_OpenAiCompatibleImplementation_AbstractOpenAiCompatibleTextGenerationModel) getmessagerolestring(mut var_role Class_WordPress_AiClient_Messages_Enums_MessageRoleEnum) string {
	mut var_role_mutated := var_role
	mut iife_temp_3 := Class_WordPress_AiClient_Messages_Enums_MessageRoleEnum{}
	mut iife_result_3 := iife_temp_3.model()
	if rt.is_true(rt.identical(var_role_mutated, iife_result_3)) {
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
	rt.throw_exception(rt.new_object('WordPress_AiClient_Common_Exception_InvalidArgumentException', []string{}, create_wordpress_aiclient_common_exception_invalidargumentexception(rt.call_function('sprintf', [rt.new_string('Unsupported message part type "%s".'), var_type.clone()]))))
	return rt.new_null()
}

fn (mut this Class_WordPress_AiClient_Providers_OpenAiCompatibleImplementation_AbstractOpenAiCompatibleTextGenerationModel) getmessageparttoolcalldata(mut var_part Class_WordPress_AiClient_Messages_DTO_MessagePart) rt.PhpVal {
	mut var_type := var_part.gettype()
	if rt.is_true(rt.call_method(var_type, 'isFunctionCall', []rt.PhpVal{})) {
		mut var_functionCall := var_part.getfunctioncall()
		if rt.is_true(rt.new_bool(!(rt.is_true(var_functionCall)))) {
			rt.throw_exception(rt.new_object('WordPress_AiClient_Common_Exception_RuntimeException', []string{}, create_wordpress_aiclient_common_exception_runtimeexception(rt.new_string('The function call typed message part must contain a function call.'))))
		}
		mut var_args := rt.call_method(var_functionCall, 'getArgs', []rt.PhpVal{})
		if rt.is_true(rt.identical(var_args, rt.new_null())) || (var_args.clone().is_array() && var_args.clone().array_count() == 0) {
		var_args = create_wordpress_aiclient_providers_openaicompatibleimplementation_stdclass()
		}
		return rt.create_array([rt.ArrayItem{ key: 'type', val: 'function' }, rt.ArrayItem{ key: 'id', val: rt.call_method(var_functionCall, 'getId', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'function', val: rt.create_array([rt.ArrayItem{ key: 'name', val: rt.call_method(var_functionCall, 'getName', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'arguments', val: rt.json_encode(var_args.clone()) }]) }])
	}
	return rt.new_null()
}

fn (mut this Class_WordPress_AiClient_Providers_OpenAiCompatibleImplementation_AbstractOpenAiCompatibleTextGenerationModel) validateoutputmodalities(mut var_outputModalities Class_WordPress_AiClient_Providers_OpenAiCompatibleImplementation_array) {
	mut var_outputModalities_mutated := var_outputModalities
	if var_outputModalities_mutated.array_count() == 0 {
		return
	}
	mut iter_2 := var_outputModalities_mutated.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_modality := item_2.val
		if rt.is_true(rt.call_method(var_modality, 'isText', []rt.PhpVal{})) {
			return
		}
	}
	rt.throw_exception(rt.new_object('WordPress_AiClient_Common_Exception_InvalidArgumentException', []string{}, create_wordpress_aiclient_common_exception_invalidargumentexception(rt.new_string('A text output modality must be present when generating text.'))))
}

fn (mut this Class_WordPress_AiClient_Providers_OpenAiCompatibleImplementation_AbstractOpenAiCompatibleTextGenerationModel) prepareoutputmodalitiesparam(mut var_modalities Class_WordPress_AiClient_Providers_OpenAiCompatibleImplementation_array) rt.PhpVal {
	mut var_prepared := rt.new_array()
	mut iter_3 := var_modalities.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_modality := item_3.val
		if rt.is_true(rt.call_method(var_modality, 'isText', []rt.PhpVal{})) {
			var_prepared.array_push('text')
		} else if rt.is_true(rt.call_method(var_modality, 'isImage', []rt.PhpVal{})) {
			var_prepared.array_push('image')
		} else if rt.is_true(rt.call_method(var_modality, 'isAudio', []rt.PhpVal{})) {
			var_prepared.array_push('audio')
		} else {
			rt.throw_exception(rt.new_object('WordPress_AiClient_Common_Exception_InvalidArgumentException', []string{}, create_wordpress_aiclient_common_exception_invalidargumentexception(rt.call_function('sprintf', [rt.new_string('Unsupported output modality "%s".'), var_modality.clone()]))))
		}
	}
	return var_prepared.clone()
}

fn (mut this Class_WordPress_AiClient_Providers_OpenAiCompatibleImplementation_AbstractOpenAiCompatibleTextGenerationModel) preparetoolsparam(mut var_functionDeclarations Class_WordPress_AiClient_Providers_OpenAiCompatibleImplementation_array) rt.PhpVal {
	mut var_functionDeclarations_mutated := var_functionDeclarations
	mut var_tools := rt.new_array()
	mut iter_4 := var_functionDeclarations_mutated.iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_functionDeclaration := item_4.val
		var_tools.array_push(rt.create_array([rt.ArrayItem{ key: 'type', val: 'function' }, rt.ArrayItem{ key: 'function', val: rt.call_method(var_functionDeclaration, 'toArray', []rt.PhpVal{}) }]))
	}
	return var_tools.clone()
}

fn (mut this Class_WordPress_AiClient_Providers_OpenAiCompatibleImplementation_AbstractOpenAiCompatibleTextGenerationModel) prepareresponseformatparam(mut var_outputSchema Class_WordPress_AiClient_Providers_OpenAiCompatibleImplementation_?array) rt.PhpVal {
	mut var_outputSchema_mutated := var_outputSchema
	if rt.is_true(rt.new_bool(var_outputSchema_mutated.is_array())) {
		return rt.create_array([rt.ArrayItem{ key: 'type', val: 'json_schema' }, rt.ArrayItem{ key: 'json_schema', val: var_outputSchema_mutated }])
	}
	return rt.create_array([rt.ArrayItem{ key: 'type', val: 'json_object' }])
}

fn (mut this Class_WordPress_AiClient_Providers_OpenAiCompatibleImplementation_AbstractOpenAiCompatibleTextGenerationModel) createrequest(mut var_method Class_WordPress_AiClient_Providers_Http_Enums_HttpMethodEnum, path string, mut var_headers Class_WordPress_AiClient_Providers_OpenAiCompatibleImplementation_array, var_data rt.PhpVal) {
}

fn (mut this Class_WordPress_AiClient_Providers_OpenAiCompatibleImplementation_AbstractOpenAiCompatibleTextGenerationModel) throwifnotsuccessful(mut var_response Class_WordPress_AiClient_Providers_Http_DTO_Response) {
	mut var_response_mutated := var_response
mut iife_temp_4 := Class_WordPress_AiClient_Providers_Http_Util_ResponseUtil{}
mut iife_result_4 := iife_temp_4.throwifnotsuccessful(rt.new_object('WordPress_AiClient_Providers_Http_DTO_Response', []string{}, var_response_mutated))
}

fn (mut this Class_WordPress_AiClient_Providers_OpenAiCompatibleImplementation_AbstractOpenAiCompatibleTextGenerationModel) parseresponsetogenerativeairesult(mut var_response Class_WordPress_AiClient_Providers_Http_DTO_Response) rt.PhpVal {
	mut var_response_mutated := var_response
	mut var_responseData := rt.call_method(var_response_mutated, 'getData', []rt.PhpVal{})
	if !(var_responseData.array_isset(rt.new_string('choices'))) || rt.is_true(rt.new_bool(!(rt.is_true(var_responseData.array_get(rt.new_string('choices')))))) {
		mut iife_temp_5 := Class_WordPress_AiClient_Providers_Http_Exception_ResponseException{}
		mut iife_result_5 := iife_temp_5.frommissingdata(rt.call_method(this.providermetadata(), 'getName', []rt.PhpVal{}), rt.new_string('choices'))
		rt.throw_exception(iife_result_5)
	}
	if !(var_responseData.array_get(rt.new_string('choices')).is_array()) {
		mut iife_temp_6 := Class_WordPress_AiClient_Providers_Http_Exception_ResponseException{}
		mut iife_result_6 := iife_temp_6.frominvaliddata(rt.call_method(this.providermetadata(), 'getName', []rt.PhpVal{}), rt.new_string('choices'), rt.new_string('The value must be an array.'))
		rt.throw_exception(iife_result_6)
	}
	mut var_candidates := rt.new_array()
	mut iter_5 := var_responseData.array_get(rt.new_string('choices')).iterator()
	for {
		item_5 := iter_5.next() or { break }
		mut var_choiceData := item_5.val
		mut var_index := item_5.key
		if !(var_choiceData.clone().is_array()) || rt.is_true(rt.call_function('array_is_list', [var_choiceData.clone()])) {
			mut iife_temp_7 := Class_WordPress_AiClient_Providers_Http_Exception_ResponseException{}
			mut iife_result_7 := iife_temp_7.frominvaliddata(rt.call_method(this.providermetadata(), 'getName', []rt.PhpVal{}), rt.new_string("choices[${var_index.to_string()}]"), rt.new_string('The value must be an associative array.'))
			rt.throw_exception(iife_result_7)
		}
		var_candidates.array_push(this.parseresponsechoicetocandidate(mut rt.cast_object_ptr[Class_WordPress_AiClient_Providers_OpenAiCompatibleImplementation_array](var_choiceData), (var_index).to_i64()))
	}
	mut var_id := if var_responseData.array_isset(rt.new_string('id')) && var_responseData.array_get(rt.new_string('id')).is_string() { var_responseData.array_get(rt.new_string('id')) } else { rt.new_string('') }
	if var_responseData.array_isset(rt.new_string('usage')) && var_responseData.array_get(rt.new_string('usage')).is_array() {
	mut var_usage := var_responseData.array_get(rt.new_string('usage'))
	mut var_tokenUsage := create_wordpress_aiclient_results_dto_tokenusage(if !(var_usage.array_get(rt.new_string('prompt_tokens'))).is_null() { var_usage.array_get(rt.new_string('prompt_tokens')) } else { rt.new_int(0) }, if !(var_usage.array_get(rt.new_string('completion_tokens'))).is_null() { var_usage.array_get(rt.new_string('completion_tokens')) } else { rt.new_int(0) }, if !(var_usage.array_get(rt.new_string('total_tokens'))).is_null() { var_usage.array_get(rt.new_string('total_tokens')) } else { rt.new_int(0) })
	} else {
	var_tokenUsage = create_wordpress_aiclient_results_dto_tokenusage(rt.new_int(0), rt.new_int(0), rt.new_int(0))
	}
	mut var_additionalData := var_responseData.clone()
	var_additionalData.array_unset(rt.new_string('id'))
	var_additionalData.array_unset(rt.new_string('choices'))
	var_additionalData.array_unset(rt.new_string('usage'))
	return rt.new_object('WordPress_AiClient_Results_DTO_GenerativeAiResult', []string{}, create_wordpress_aiclient_results_dto_generativeairesult(var_id.clone(), var_candidates.clone(), var_tokenUsage, this.providermetadata(), this.metadata(), var_additionalData.clone()))
}

fn (mut this Class_WordPress_AiClient_Providers_OpenAiCompatibleImplementation_AbstractOpenAiCompatibleTextGenerationModel) parseresponsechoicetocandidate(mut var_choiceData Class_WordPress_AiClient_Providers_OpenAiCompatibleImplementation_array, index i64) rt.PhpVal {
	if !(var_choiceData.array_isset(rt.new_string('message'))) || !(var_choiceData.array_get(rt.new_string('message')).is_array()) || rt.is_true(rt.call_function('array_is_list', [var_choiceData.array_get(rt.new_string('message'))])) {
		mut iife_temp_8 := Class_WordPress_AiClient_Providers_Http_Exception_ResponseException{}
		mut iife_result_8 := iife_temp_8.frommissingdata(rt.call_method(this.providermetadata(), 'getName', []rt.PhpVal{}), rt.new_string("choices[${var_index.str()}].message"))
		rt.throw_exception(iife_result_8)
	}
	if !(var_choiceData.array_isset(rt.new_string('finish_reason'))) || !(var_choiceData.array_get(rt.new_string('finish_reason')).is_string()) {
		mut iife_temp_9 := Class_WordPress_AiClient_Providers_Http_Exception_ResponseException{}
		mut iife_result_9 := iife_temp_9.frommissingdata(rt.call_method(this.providermetadata(), 'getName', []rt.PhpVal{}), rt.new_string("choices[${var_index.str()}].finish_reason"))
		rt.throw_exception(iife_result_9)
	}
	mut var_messageData := var_choiceData.array_get(rt.new_string('message'))
	mut var_message := this.parseresponsechoicemessage(mut rt.cast_object_ptr[Class_WordPress_AiClient_Providers_OpenAiCompatibleImplementation_array](var_messageData), index)
	mut switch_val_1 := var_choiceData.array_get(rt.new_string('finish_reason'))
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('stop'))) {
	mut iife_temp_10 := Class_WordPress_AiClient_Results_Enums_FinishReasonEnum{}
	mut iife_result_10 := iife_temp_10.stop()
	mut var_finishReason := iife_result_10
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('length'))) {
	mut iife_temp_11 := Class_WordPress_AiClient_Results_Enums_FinishReasonEnum{}
	mut iife_result_11 := iife_temp_11.length()
	var_finishReason = iife_result_11
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('content_filter'))) {
	mut iife_temp_12 := Class_WordPress_AiClient_Results_Enums_FinishReasonEnum{}
	mut iife_result_12 := iife_temp_12.contentfilter()
	var_finishReason = iife_result_12
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('tool_calls'))) {
	mut iife_temp_13 := Class_WordPress_AiClient_Results_Enums_FinishReasonEnum{}
	mut iife_result_13 := iife_temp_13.toolcalls()
	var_finishReason = iife_result_13
	} else {
		mut iife_temp_14 := Class_WordPress_AiClient_Providers_Http_Exception_ResponseException{}
		mut iife_result_14 := iife_temp_14.frominvaliddata(rt.call_method(this.providermetadata(), 'getName', []rt.PhpVal{}), rt.new_string("choices[${var_index.str()}].finish_reason"), rt.call_function('sprintf', [rt.new_string('Invalid finish reason "%s".'), var_choiceData.array_get(rt.new_string('finish_reason'))]))
		rt.throw_exception(iife_result_14)
	}
	return rt.new_object('WordPress_AiClient_Results_DTO_Candidate', []string{}, create_wordpress_aiclient_results_dto_candidate(var_message.clone(), var_finishReason.clone()))
}

fn (mut this Class_WordPress_AiClient_Providers_OpenAiCompatibleImplementation_AbstractOpenAiCompatibleTextGenerationModel) parseresponsechoicemessage(mut var_messageData Class_WordPress_AiClient_Providers_OpenAiCompatibleImplementation_array, index i64) rt.PhpVal {
	mut var_messageData_mutated := var_messageData
	mut iife_temp_15 := Class_WordPress_AiClient_Messages_Enums_MessageRoleEnum{}
	mut iife_result_15 := iife_temp_15.user()
	mut iife_temp_16 := Class_WordPress_AiClient_Messages_Enums_MessageRoleEnum{}
	mut iife_result_16 := iife_temp_16.model()
	mut var_role := if var_messageData_mutated.array_isset(rt.new_string('role')) && rt.is_true(rt.identical(rt.new_string('user'), var_messageData_mutated.array_get(rt.new_string('role')))) { iife_result_15 } else { iife_result_16 }
	mut var_parts := this.parseresponsechoicemessageparts(mut var_messageData_mutated, index)
	return rt.new_object('WordPress_AiClient_Messages_DTO_Message', []string{}, create_wordpress_aiclient_messages_dto_message(var_role.clone(), var_parts.clone()))
}

fn (mut this Class_WordPress_AiClient_Providers_OpenAiCompatibleImplementation_AbstractOpenAiCompatibleTextGenerationModel) parseresponsechoicemessageparts(mut var_messageData Class_WordPress_AiClient_Providers_OpenAiCompatibleImplementation_array, index i64) rt.PhpVal {
	mut var_messageData_mutated := var_messageData
	mut var_parts := rt.new_array()
	if var_messageData_mutated.array_isset(rt.new_string('reasoning_content')) && var_messageData_mutated.array_get(rt.new_string('reasoning_content')).is_string() {
		mut iife_temp_17 := Class_WordPress_AiClient_Messages_Enums_MessagePartChannelEnum{}
		mut iife_result_17 := iife_temp_17.thought()
		var_parts.array_push(create_wordpress_aiclient_messages_dto_messagepart(var_messageData_mutated.array_get(rt.new_string('reasoning_content')), iife_result_17))
	}
	if var_messageData_mutated.array_isset(rt.new_string('content')) && var_messageData_mutated.array_get(rt.new_string('content')).is_string() {
		var_parts.array_push(create_wordpress_aiclient_messages_dto_messagepart(var_messageData_mutated.array_get(rt.new_string('content'))))
	}
	if var_messageData_mutated.array_isset(rt.new_string('tool_calls')) && var_messageData_mutated.array_get(rt.new_string('tool_calls')).is_array() {
		mut iter_6 := var_messageData_mutated.array_get(rt.new_string('tool_calls')).iterator()
		for {
			item_6 := iter_6.next() or { break }
			mut var_toolCallData := item_6.val
			mut var_toolCallIndex := item_6.key
			mut var_toolCallPart := this.parseresponsechoicemessagetoolcallpart(mut rt.cast_object_ptr[Class_WordPress_AiClient_Providers_OpenAiCompatibleImplementation_array](var_toolCallData))
			if rt.is_true(rt.new_bool(!(rt.is_true(var_toolCallPart)))) {
				mut iife_temp_18 := Class_WordPress_AiClient_Providers_Http_Exception_ResponseException{}
				mut iife_result_18 := iife_temp_18.frominvaliddata(rt.call_method(this.providermetadata(), 'getName', []rt.PhpVal{}), rt.new_string("choices[${var_index.str()}].message.tool_calls[${var_toolCallIndex.to_string()}]"), rt.new_string('The response includes a tool call of an unexpected type.'))
				rt.throw_exception(iife_result_18)
			}
			var_parts.array_push(var_toolCallPart.clone())
		}
	}
	return var_parts.clone()
}

fn (mut this Class_WordPress_AiClient_Providers_OpenAiCompatibleImplementation_AbstractOpenAiCompatibleTextGenerationModel) parseresponsechoicemessagetoolcallpart(mut var_toolCallData Class_WordPress_AiClient_Providers_OpenAiCompatibleImplementation_array) rt.PhpVal {
	if ((var_toolCallData.array_isset(rt.new_string('type')) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('function'), var_toolCallData.array_get(rt.new_string('type'))))))) || !(var_toolCallData.array_isset(rt.new_string('function')))) || !(var_toolCallData.array_get(rt.new_string('function')).is_array()) {
		return rt.new_null()
	}
	mut var_functionArguments := if var_toolCallData.array_get(rt.new_string('function')).array_get(rt.new_string('arguments')).is_string() { rt.call_function('json_decode', [var_toolCallData.array_get(rt.new_string('function')).array_get(rt.new_string('arguments')), rt.new_bool(true)]) } else { var_toolCallData.array_get(rt.new_string('function')).array_get(rt.new_string('arguments')) }
	mut var_functionCall := create_wordpress_aiclient_tools_dto_functioncall(if var_toolCallData.array_isset(rt.new_string('id')) && var_toolCallData.array_get(rt.new_string('id')).is_string() { var_toolCallData.array_get(rt.new_string('id')) } else { rt.new_null() }, if var_toolCallData.array_get(rt.new_string('function')).array_isset(rt.new_string('name')) && var_toolCallData.array_get(rt.new_string('function')).array_get(rt.new_string('name')).is_string() { var_toolCallData.array_get(rt.new_string('function')).array_get(rt.new_string('name')) } else { rt.new_null() }, var_functionArguments.clone())
	return create_wordpress_aiclient_messages_dto_messagepart(var_functionCall.clone())
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

struct Class_WordPress_AiClient_Providers_OpenAiCompatibleImplementation_stdClass {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClient_Providers_Http_Util_ResponseUtil {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClient_Providers_Http_Exception_ResponseException {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClient_Results_DTO_TokenUsage {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClient_Results_DTO_GenerativeAiResult {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClient_Results_Enums_FinishReasonEnum {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClient_Results_DTO_Candidate {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClient_Messages_DTO_Message {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClient_Messages_DTO_MessagePart {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClient_Messages_Enums_MessagePartChannelEnum {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClient_Tools_DTO_FunctionCall {
	rt.PhpObjectBase
}

fn create_wordpress_aiclient_providers_openaicompatibleimplementation_abstractopenaicompatibletextgenerationmodel(_args ...rt.PhpVal) &Class_WordPress_AiClient_Providers_OpenAiCompatibleImplementation_AbstractOpenAiCompatibleTextGenerationModel {
	mut obj := &Class_WordPress_AiClient_Providers_OpenAiCompatibleImplementation_AbstractOpenAiCompatibleTextGenerationModel{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wordpress_aiclient_providers_apibasedimplementation_abstractapibasedmodel(_args ...rt.PhpVal) &Class_WordPress_AiClient_Providers_ApiBasedImplementation_AbstractApiBasedModel {
	mut obj := &Class_WordPress_AiClient_Providers_ApiBasedImplementation_AbstractApiBasedModel{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wordpress_aiclient_providers_http_enums_httpmethodenum(_args ...rt.PhpVal) &Class_WordPress_AiClient_Providers_Http_Enums_HttpMethodEnum {
	mut obj := &Class_WordPress_AiClient_Providers_Http_Enums_HttpMethodEnum{
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

fn create_wordpress_aiclient_common_exception_runtimeexception(_args ...rt.PhpVal) &Class_WordPress_AiClient_Common_Exception_RuntimeException {
	mut obj := &Class_WordPress_AiClient_Common_Exception_RuntimeException{
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

fn create_wordpress_aiclient_providers_openaicompatibleimplementation_stdclass(_args ...rt.PhpVal) &Class_WordPress_AiClient_Providers_OpenAiCompatibleImplementation_stdClass {
	mut obj := &Class_WordPress_AiClient_Providers_OpenAiCompatibleImplementation_stdClass{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wordpress_aiclient_providers_http_util_responseutil(_args ...rt.PhpVal) &Class_WordPress_AiClient_Providers_Http_Util_ResponseUtil {
	mut obj := &Class_WordPress_AiClient_Providers_Http_Util_ResponseUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wordpress_aiclient_providers_http_exception_responseexception(_args ...rt.PhpVal) &Class_WordPress_AiClient_Providers_Http_Exception_ResponseException {
	mut obj := &Class_WordPress_AiClient_Providers_Http_Exception_ResponseException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wordpress_aiclient_results_dto_tokenusage(_args ...rt.PhpVal) &Class_WordPress_AiClient_Results_DTO_TokenUsage {
	mut obj := &Class_WordPress_AiClient_Results_DTO_TokenUsage{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wordpress_aiclient_results_dto_generativeairesult(_args ...rt.PhpVal) &Class_WordPress_AiClient_Results_DTO_GenerativeAiResult {
	mut obj := &Class_WordPress_AiClient_Results_DTO_GenerativeAiResult{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wordpress_aiclient_results_enums_finishreasonenum(_args ...rt.PhpVal) &Class_WordPress_AiClient_Results_Enums_FinishReasonEnum {
	mut obj := &Class_WordPress_AiClient_Results_Enums_FinishReasonEnum{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wordpress_aiclient_results_dto_candidate(_args ...rt.PhpVal) &Class_WordPress_AiClient_Results_DTO_Candidate {
	mut obj := &Class_WordPress_AiClient_Results_DTO_Candidate{
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

fn create_wordpress_aiclient_messages_dto_messagepart(_args ...rt.PhpVal) &Class_WordPress_AiClient_Messages_DTO_MessagePart {
	mut obj := &Class_WordPress_AiClient_Messages_DTO_MessagePart{
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

fn create_wordpress_aiclient_tools_dto_functioncall(_args ...rt.PhpVal) &Class_WordPress_AiClient_Tools_DTO_FunctionCall {
	mut obj := &Class_WordPress_AiClient_Tools_DTO_FunctionCall{
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


fn (mut this Class_WordPress_AiClient_Providers_OpenAiCompatibleImplementation_stdClass) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WordPress_AiClient_Providers_OpenAiCompatibleImplementation_stdClass) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClient_Providers_OpenAiCompatibleImplementation_stdClass) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WordPress_AiClient_Providers_Http_Util_ResponseUtil) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WordPress_AiClient_Providers_Http_Util_ResponseUtil) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClient_Providers_Http_Util_ResponseUtil) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WordPress_AiClient_Providers_Http_Exception_ResponseException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WordPress_AiClient_Providers_Http_Exception_ResponseException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClient_Providers_Http_Exception_ResponseException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WordPress_AiClient_Results_DTO_TokenUsage) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WordPress_AiClient_Results_DTO_TokenUsage) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClient_Results_DTO_TokenUsage) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WordPress_AiClient_Results_DTO_GenerativeAiResult) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WordPress_AiClient_Results_DTO_GenerativeAiResult) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClient_Results_DTO_GenerativeAiResult) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_WordPress_AiClient_Results_DTO_Candidate) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WordPress_AiClient_Results_DTO_Candidate) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClient_Results_DTO_Candidate) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_WordPress_AiClient_Messages_DTO_MessagePart) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WordPress_AiClient_Messages_DTO_MessagePart) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClient_Messages_DTO_MessagePart) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_WordPress_AiClient_Tools_DTO_FunctionCall) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WordPress_AiClient_Tools_DTO_FunctionCall) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClient_Tools_DTO_FunctionCall) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}



fn main() {
	defer {
		rt.shutdown()
	}

}
