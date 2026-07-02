import rt

struct Class_WordPress_AiClient_Builders_PromptBuilder {
	rt.PhpObjectBase
pub mut:
		registry rt.PhpVal = rt.new_null()
		messages rt.PhpVal = rt.new_array()
		model rt.PhpVal = rt.new_null()
		modelPreferenceKeys rt.PhpVal = rt.new_array()
		providerIdOrClassName rt.PhpVal = rt.new_null()
		modelConfig rt.PhpVal = rt.new_null()
		requestOptions rt.PhpVal = rt.new_null()
		eventDispatcher rt.PhpVal = rt.new_null()
}

fn (mut this Class_WordPress_AiClient_Builders_PromptBuilder) construct(mut var_registry Class_WordPress_AiClient_Providers_ProviderRegistry, var_prompt rt.PhpVal, mut var_eventDispatcher Class_WordPress_AiClient_Builders_?EventDispatcherInterface) {
	this.registry = var_registry
	this.modelConfig = create_wordpress_aiclient_providers_models_dto_modelconfig()
	this.eventDispatcher = var_eventDispatcher
	if rt.is_true(rt.identical(var_prompt, rt.new_null())) {
		return
	}
	if this.ismessageslist(var_prompt.clone()) {
		this.messages = var_prompt.clone()
		return
	}
	mut iife_temp_0 := Class_WordPress_AiClient_Messages_Enums_MessageRoleEnum{}
	mut iife_result_0 := iife_temp_0.user()
	mut var_userMessage := this.parsemessage(var_prompt.clone(), mut rt.cast_object_ptr[Class_WordPress_AiClient_Messages_Enums_MessageRoleEnum](iife_result_0))
	this.messages.array_push(var_userMessage.clone())
}

fn (mut this Class_WordPress_AiClient_Builders_PromptBuilder) magic_clone() {
	mut var_clonedMessages := rt.new_array()
	mut iter_1 := this.messages.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_message := item_1.val
		var_clonedMessages.array_push(var_message.dup())
	}
	this.messages = var_clonedMessages.clone()
	this.modelConfig = this.modelConfig.dup()
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(this.requestOptions, rt.new_null())))) {
		this.requestOptions = this.requestOptions.dup()
	}
}

fn (mut this Class_WordPress_AiClient_Builders_PromptBuilder) withtext(text string) rt.PhpVal {
	mut var_part := create_wordpress_aiclient_messages_dto_messagepart(rt.new_string(text))
	this.appendparttomessages(mut var_part)
	return rt.new_object('WordPress_AiClient_Builders_PromptBuilder', []string{}, this)
}

fn (mut this Class_WordPress_AiClient_Builders_PromptBuilder) withfile(var_file rt.PhpVal, mut var_mimeType Class_WordPress_AiClient_Builders_?string) rt.PhpVal {
	mut var_file_mutated := var_file
	var_file_mutated = if rt.is_true(rt.new_bool(rt.instance_of(var_file_mutated, 'WordPress_AiClient_Files_DTO_File'))) { var_file_mutated } else { create_wordpress_aiclient_files_dto_file(var_file_mutated.clone(), var_mimeType) }
	mut var_part := create_wordpress_aiclient_messages_dto_messagepart(var_file_mutated.clone())
	this.appendparttomessages(mut var_part)
	return rt.new_object('WordPress_AiClient_Builders_PromptBuilder', []string{}, this)
}

fn (mut this Class_WordPress_AiClient_Builders_PromptBuilder) withfunctionresponse(mut var_functionResponse Class_WordPress_AiClient_Tools_DTO_FunctionResponse) rt.PhpVal {
	mut var_part := create_wordpress_aiclient_messages_dto_messagepart(var_functionResponse)
	this.appendparttomessages(mut var_part)
	return rt.new_object('WordPress_AiClient_Builders_PromptBuilder', []string{}, this)
}

fn (mut this Class_WordPress_AiClient_Builders_PromptBuilder) withmessageparts(mut var_parts Class_WordPress_AiClient_Messages_DTO_MessagePart) rt.PhpVal {
	mut var_parts_mutated := var_parts
	mut iter_2 := var_parts_mutated.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_part := item_2.val
		this.appendparttomessages(mut rt.cast_object_ptr[Class_WordPress_AiClient_Messages_DTO_MessagePart](var_part))
	}
	return rt.new_object('WordPress_AiClient_Builders_PromptBuilder', []string{}, this)
}

fn (mut this Class_WordPress_AiClient_Builders_PromptBuilder) withhistory(mut var_messages Class_WordPress_AiClient_Messages_DTO_Message) rt.PhpVal {
	this.messages = rt.call_function('array_merge', [var_messages, this.messages])
	return rt.new_object('WordPress_AiClient_Builders_PromptBuilder', []string{}, this)
}

fn (mut this Class_WordPress_AiClient_Builders_PromptBuilder) usingmodel(mut var_model Class_WordPress_AiClient_Providers_Models_Contracts_ModelInterface) rt.PhpVal {
	mut var_model_mutated := var_model
	this.model = var_model_mutated
	mut var_modelConfigArray := rt.call_method(rt.call_method(var_model_mutated, 'getConfig', []rt.PhpVal{}), 'toArray', []rt.PhpVal{})
	mut var_builderConfigArray := rt.call_method(this.modelConfig, 'toArray', []rt.PhpVal{})
	mut var_mergedConfigArray := rt.call_function('array_merge', [var_modelConfigArray.clone(), var_builderConfigArray.clone()])
	mut iife_temp_1 := Class_WordPress_AiClient_Providers_Models_DTO_ModelConfig{}
	mut iife_result_1 := iife_temp_1.fromarray(var_mergedConfigArray.clone())
	this.modelConfig = iife_result_1
	return rt.new_object('WordPress_AiClient_Builders_PromptBuilder', []string{}, this)
}

fn (mut this Class_WordPress_AiClient_Builders_PromptBuilder) usingmodelpreference(var_preferredModels rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.identical(var_preferredModels, rt.new_array())) {
		rt.throw_exception(rt.new_object('WordPress_AiClient_Common_Exception_InvalidArgumentException', []string{}, create_wordpress_aiclient_common_exception_invalidargumentexception(rt.new_string('At least one model preference must be provided.'))))
	}
	mut var_preferenceKeys := rt.new_array()
	mut iter_3 := var_preferredModels.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_preferredModel := item_3.val
		if rt.is_true(rt.new_bool(var_preferredModel.clone().is_array())) {
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('array_is_list', [var_preferredModel.clone()]))))) || rt.is_true(rt.new_bool(var_preferredModel.clone().array_count() != 2)) {
				rt.throw_exception(rt.new_object('WordPress_AiClient_Common_Exception_InvalidArgumentException', []string{}, create_wordpress_aiclient_common_exception_invalidargumentexception(rt.new_string('Model preference tuple must contain model identifier and provider ID.'))))
			}
			mut list_tmp_1 := var_preferredModel
			mut var_providerId := (list_tmp_1).array_get(0)
			mut var_modelId := (list_tmp_1).array_get(1)
		var_modelId = rt.new_string(this.normalizepreferenceidentifier(var_modelId.clone(), ''))
		var_providerId = rt.new_string(this.normalizepreferenceidentifier(var_providerId.clone(), 'Model preference provider identifiers cannot be empty.'))
		mut var_preferenceKey := rt.new_string(this.createprovidermodelpreferencekey((var_providerId).str(), (var_modelId).str()))
		} else if rt.is_true(rt.new_bool(rt.instance_of(var_preferredModel, 'WordPress_AiClient_Providers_Models_Contracts_ModelInterface'))) {
		var_modelId = rt.call_method(rt.call_method(var_preferredModel, 'metadata', []rt.PhpVal{}), 'getId', []rt.PhpVal{})
		var_providerId = rt.call_method(rt.call_method(var_preferredModel, 'providerMetadata', []rt.PhpVal{}), 'getId', []rt.PhpVal{})
		var_preferenceKey = rt.new_string(this.createprovidermodelpreferencekey((var_providerId).str(), (var_modelId).str()))
		} else if rt.is_true(rt.new_bool(var_preferredModel.clone().is_string())) {
		var_modelId = rt.new_string(this.normalizepreferenceidentifier(var_preferredModel.clone(), ''))
		var_preferenceKey = rt.new_string(this.createmodelpreferencekey((var_modelId).str()))
		} else {
			rt.throw_exception(rt.new_object('WordPress_AiClient_Common_Exception_InvalidArgumentException', []string{}, create_wordpress_aiclient_common_exception_invalidargumentexception('Model preferences must be model identifiers, instances of ModelInterface, ' + 'or provider/model tuples.')))
		}
		var_preferenceKeys.array_push(var_preferenceKey.clone())
	}
	this.modelPreferenceKeys = var_preferenceKeys.clone()
	return rt.new_object('WordPress_AiClient_Builders_PromptBuilder', []string{}, this)
}

fn (mut this Class_WordPress_AiClient_Builders_PromptBuilder) usingmodelconfig(mut var_config Class_WordPress_AiClient_Providers_Models_DTO_ModelConfig) rt.PhpVal {
	mut var_builderConfigArray := rt.call_method(this.modelConfig, 'toArray', []rt.PhpVal{})
	mut var_providedConfigArray := var_config.toarray()
	mut var_mergedArray := rt.call_function('array_merge', [var_providedConfigArray.clone(), var_builderConfigArray.clone()])
	mut iife_temp_2 := Class_WordPress_AiClient_Providers_Models_DTO_ModelConfig{}
	mut iife_result_2 := iife_temp_2.fromarray(var_mergedArray.clone())
	this.modelConfig = iife_result_2
	return rt.new_object('WordPress_AiClient_Builders_PromptBuilder', []string{}, this)
}

fn (mut this Class_WordPress_AiClient_Builders_PromptBuilder) usingprovider(providerIdOrClassName string) rt.PhpVal {
	this.providerIdOrClassName = rt.new_string(providerIdOrClassName)
	return rt.new_object('WordPress_AiClient_Builders_PromptBuilder', []string{}, this)
}

fn (mut this Class_WordPress_AiClient_Builders_PromptBuilder) usingsysteminstruction(systemInstruction string) rt.PhpVal {
	rt.call_method(this.modelConfig, 'setSystemInstruction', [rt.new_string(systemInstruction)])
	return rt.new_object('WordPress_AiClient_Builders_PromptBuilder', []string{}, this)
}

fn (mut this Class_WordPress_AiClient_Builders_PromptBuilder) usingmaxtokens(maxTokens i64) rt.PhpVal {
	rt.call_method(this.modelConfig, 'setMaxTokens', [rt.new_int(maxTokens)])
	return rt.new_object('WordPress_AiClient_Builders_PromptBuilder', []string{}, this)
}

fn (mut this Class_WordPress_AiClient_Builders_PromptBuilder) usingtemperature(temperature f64) rt.PhpVal {
	rt.call_method(this.modelConfig, 'setTemperature', [rt.new_float(temperature)])
	return rt.new_object('WordPress_AiClient_Builders_PromptBuilder', []string{}, this)
}

fn (mut this Class_WordPress_AiClient_Builders_PromptBuilder) usingtopp(topP f64) rt.PhpVal {
	rt.call_method(this.modelConfig, 'setTopP', [rt.new_float(topP)])
	return rt.new_object('WordPress_AiClient_Builders_PromptBuilder', []string{}, this)
}

fn (mut this Class_WordPress_AiClient_Builders_PromptBuilder) usingtopk(topK i64) rt.PhpVal {
	rt.call_method(this.modelConfig, 'setTopK', [rt.new_int(topK)])
	return rt.new_object('WordPress_AiClient_Builders_PromptBuilder', []string{}, this)
}

fn (mut this Class_WordPress_AiClient_Builders_PromptBuilder) usingstopsequences(stopSequences string) rt.PhpVal {
	rt.call_method(this.modelConfig, 'setStopSequences', [rt.new_string(stopSequences)])
	return rt.new_object('WordPress_AiClient_Builders_PromptBuilder', []string{}, this)
}

fn (mut this Class_WordPress_AiClient_Builders_PromptBuilder) usingcandidatecount(candidateCount i64) rt.PhpVal {
	rt.call_method(this.modelConfig, 'setCandidateCount', [rt.new_int(candidateCount)])
	return rt.new_object('WordPress_AiClient_Builders_PromptBuilder', []string{}, this)
}

fn (mut this Class_WordPress_AiClient_Builders_PromptBuilder) usingfunctiondeclarations(mut var_functionDeclarations Class_WordPress_AiClient_Tools_DTO_FunctionDeclaration) rt.PhpVal {
	rt.call_method(this.modelConfig, 'setFunctionDeclarations', [var_functionDeclarations])
	return rt.new_object('WordPress_AiClient_Builders_PromptBuilder', []string{}, this)
}

fn (mut this Class_WordPress_AiClient_Builders_PromptBuilder) usingpresencepenalty(presencePenalty f64) rt.PhpVal {
	rt.call_method(this.modelConfig, 'setPresencePenalty', [rt.new_float(presencePenalty)])
	return rt.new_object('WordPress_AiClient_Builders_PromptBuilder', []string{}, this)
}

fn (mut this Class_WordPress_AiClient_Builders_PromptBuilder) usingfrequencypenalty(frequencyPenalty f64) rt.PhpVal {
	rt.call_method(this.modelConfig, 'setFrequencyPenalty', [rt.new_float(frequencyPenalty)])
	return rt.new_object('WordPress_AiClient_Builders_PromptBuilder', []string{}, this)
}

fn (mut this Class_WordPress_AiClient_Builders_PromptBuilder) usingwebsearch(mut var_webSearch Class_WordPress_AiClient_Tools_DTO_WebSearch) rt.PhpVal {
	rt.call_method(this.modelConfig, 'setWebSearch', [var_webSearch])
	return rt.new_object('WordPress_AiClient_Builders_PromptBuilder', []string{}, this)
}

fn (mut this Class_WordPress_AiClient_Builders_PromptBuilder) usingrequestoptions(mut var_requestOptions Class_WordPress_AiClient_Providers_Http_DTO_RequestOptions) rt.PhpVal {
	this.requestOptions = var_requestOptions
	return rt.new_object('WordPress_AiClient_Builders_PromptBuilder', []string{}, this)
}

fn (mut this Class_WordPress_AiClient_Builders_PromptBuilder) usingtoplogprobs(mut var_topLogprobs Class_WordPress_AiClient_Builders_?int) rt.PhpVal {
	rt.call_method(this.modelConfig, 'setLogprobs', [rt.new_bool(true)])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_topLogprobs, rt.new_null())))) {
		rt.call_method(this.modelConfig, 'setTopLogprobs', [var_topLogprobs])
	}
	return rt.new_object('WordPress_AiClient_Builders_PromptBuilder', []string{}, this)
}

fn (mut this Class_WordPress_AiClient_Builders_PromptBuilder) asoutputmimetype(mimeType string) rt.PhpVal {
	rt.call_method(this.modelConfig, 'setOutputMimeType', [rt.new_string(mimeType)])
	return rt.new_object('WordPress_AiClient_Builders_PromptBuilder', []string{}, this)
}

fn (mut this Class_WordPress_AiClient_Builders_PromptBuilder) asoutputschema(mut var_schema Class_WordPress_AiClient_Builders_array) rt.PhpVal {
	rt.call_method(this.modelConfig, 'setOutputSchema', [var_schema])
	return rt.new_object('WordPress_AiClient_Builders_PromptBuilder', []string{}, this)
}

fn (mut this Class_WordPress_AiClient_Builders_PromptBuilder) asoutputmodalities(mut var_modalities Class_WordPress_AiClient_Messages_Enums_ModalityEnum) rt.PhpVal {
	rt.call_method(this.modelConfig, 'setOutputModalities', [var_modalities])
	return rt.new_object('WordPress_AiClient_Builders_PromptBuilder', []string{}, this)
}

fn (mut this Class_WordPress_AiClient_Builders_PromptBuilder) asoutputfiletype(mut var_fileType Class_WordPress_AiClient_Files_Enums_FileTypeEnum) rt.PhpVal {
	rt.call_method(this.modelConfig, 'setOutputFileType', [var_fileType])
	return rt.new_object('WordPress_AiClient_Builders_PromptBuilder', []string{}, this)
}

fn (mut this Class_WordPress_AiClient_Builders_PromptBuilder) asoutputmediaorientation(mut var_orientation Class_WordPress_AiClient_Files_Enums_MediaOrientationEnum) rt.PhpVal {
	rt.call_method(this.modelConfig, 'setOutputMediaOrientation', [var_orientation])
	return rt.new_object('WordPress_AiClient_Builders_PromptBuilder', []string{}, this)
}

fn (mut this Class_WordPress_AiClient_Builders_PromptBuilder) asoutputmediaaspectratio(aspectRatio string) rt.PhpVal {
	rt.call_method(this.modelConfig, 'setOutputMediaAspectRatio', [rt.new_string(aspectRatio)])
	return rt.new_object('WordPress_AiClient_Builders_PromptBuilder', []string{}, this)
}

fn (mut this Class_WordPress_AiClient_Builders_PromptBuilder) asoutputspeechvoice(voice string) rt.PhpVal {
	rt.call_method(this.modelConfig, 'setOutputSpeechVoice', [rt.new_string(voice)])
	return rt.new_object('WordPress_AiClient_Builders_PromptBuilder', []string{}, this)
}

fn (mut this Class_WordPress_AiClient_Builders_PromptBuilder) asjsonresponse(mut var_schema Class_WordPress_AiClient_Builders_?array) rt.PhpVal {
	this.asoutputmimetype('application/json')
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_schema, rt.new_null())))) {
		this.asoutputschema(mut var_schema)
	}
	return rt.new_object('WordPress_AiClient_Builders_PromptBuilder', []string{}, this)
}

fn (mut this Class_WordPress_AiClient_Builders_PromptBuilder) infercapabilityfromoutputmodalities() rt.PhpVal {
	mut var_outputModalities := rt.call_method(this.modelConfig, 'getOutputModalities', []rt.PhpVal{})
	if rt.is_true(rt.identical(var_outputModalities, rt.new_null())) || !rt.is_true(var_outputModalities) {
		mut iife_temp_3 := Class_WordPress_AiClient_Providers_Models_Enums_CapabilityEnum{}
		mut iife_result_3 := iife_temp_3.textgeneration()
		return iife_result_3
	}
	if var_outputModalities.clone().array_count() > 1 {
		mut iife_temp_4 := Class_WordPress_AiClient_Providers_Models_Enums_CapabilityEnum{}
		mut iife_result_4 := iife_temp_4.textgeneration()
		return iife_result_4
	}
	mut var_outputModality := var_outputModalities.array_get(rt.new_int(0))
	if rt.is_true(rt.call_method(var_outputModality, 'isText', []rt.PhpVal{})) {
		mut iife_temp_5 := Class_WordPress_AiClient_Providers_Models_Enums_CapabilityEnum{}
		mut iife_result_5 := iife_temp_5.textgeneration()
		return iife_result_5
	} else if rt.is_true(rt.call_method(var_outputModality, 'isImage', []rt.PhpVal{})) {
		mut iife_temp_6 := Class_WordPress_AiClient_Providers_Models_Enums_CapabilityEnum{}
		mut iife_result_6 := iife_temp_6.imagegeneration()
		return iife_result_6
	} else if rt.is_true(rt.call_method(var_outputModality, 'isAudio', []rt.PhpVal{})) {
		mut iife_temp_7 := Class_WordPress_AiClient_Providers_Models_Enums_CapabilityEnum{}
		mut iife_result_7 := iife_temp_7.speechgeneration()
		return iife_result_7
	} else if rt.is_true(rt.call_method(var_outputModality, 'isVideo', []rt.PhpVal{})) {
		mut iife_temp_8 := Class_WordPress_AiClient_Providers_Models_Enums_CapabilityEnum{}
		mut iife_result_8 := iife_temp_8.videogeneration()
		return iife_result_8
	} else {
		rt.throw_exception(rt.new_object('WordPress_AiClient_Common_Exception_RuntimeException', []string{}, create_wordpress_aiclient_common_exception_runtimeexception(rt.call_function('sprintf', [rt.new_string('Output modality "%s" is not yet supported.'), rt.get_property(var_outputModality, 'value')]))))
	}
	return rt.new_null()
}

fn (mut this Class_WordPress_AiClient_Builders_PromptBuilder) infercapabilityfrommodelinterfaces(mut var_model Class_WordPress_AiClient_Providers_Models_Contracts_ModelInterface) rt.PhpVal {
	mut var_model_mutated := var_model
	if rt.is_true(rt.new_bool(rt.instance_of(var_model_mutated, 'WordPress_AiClient_Providers_Models_TextGeneration_Contracts_TextGenerationModelInterface'))) {
		mut iife_temp_9 := Class_WordPress_AiClient_Providers_Models_Enums_CapabilityEnum{}
		mut iife_result_9 := iife_temp_9.textgeneration()
		return iife_result_9
	}
	if rt.is_true(rt.new_bool(rt.instance_of(var_model_mutated, 'WordPress_AiClient_Providers_Models_ImageGeneration_Contracts_ImageGenerationModelInterface'))) {
		mut iife_temp_10 := Class_WordPress_AiClient_Providers_Models_Enums_CapabilityEnum{}
		mut iife_result_10 := iife_temp_10.imagegeneration()
		return iife_result_10
	}
	if rt.is_true(rt.new_bool(rt.instance_of(var_model_mutated, 'WordPress_AiClient_Providers_Models_TextToSpeechConversion_Contracts_TextToSpeechConversionModelInterface'))) {
		mut iife_temp_11 := Class_WordPress_AiClient_Providers_Models_Enums_CapabilityEnum{}
		mut iife_result_11 := iife_temp_11.texttospeechconversion()
		return iife_result_11
	}
	if rt.is_true(rt.new_bool(rt.instance_of(var_model_mutated, 'WordPress_AiClient_Providers_Models_SpeechGeneration_Contracts_SpeechGenerationModelInterface'))) {
		mut iife_temp_12 := Class_WordPress_AiClient_Providers_Models_Enums_CapabilityEnum{}
		mut iife_result_12 := iife_temp_12.speechgeneration()
		return iife_result_12
	}
	if rt.is_true(rt.new_bool(rt.instance_of(var_model_mutated, 'WordPress_AiClient_Providers_Models_VideoGeneration_Contracts_VideoGenerationModelInterface'))) {
		mut iife_temp_13 := Class_WordPress_AiClient_Providers_Models_Enums_CapabilityEnum{}
		mut iife_result_13 := iife_temp_13.videogeneration()
		return iife_result_13
	}
	return rt.new_null()
}

fn (mut this Class_WordPress_AiClient_Builders_PromptBuilder) issupported(mut var_capability Class_WordPress_AiClient_Builders_?CapabilityEnum) bool {
	mut var_capability_mutated := var_capability
	if rt.is_true(rt.identical(var_capability_mutated, rt.new_null())) {
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(this.model, rt.new_null())))) {
			mut var_inferredCapability := this.infercapabilityfrommodelinterfaces(mut rt.cast_object_ptr[Class_WordPress_AiClient_Providers_Models_Contracts_ModelInterface](this.model))
			if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_inferredCapability, rt.new_null())))) {
			var_capability_mutated = var_inferredCapability.clone()
			}
		}
		if rt.is_true(rt.identical(var_capability_mutated, rt.new_null())) {
		var_capability_mutated = this.infercapabilityfromoutputmodalities()
		}
	}
	mut iife_temp_14 := Class_WordPress_AiClient_Providers_Models_DTO_ModelRequirements{}
	mut iife_result_14 := iife_temp_14.frompromptdata(rt.new_object('WordPress_AiClient_Builders_?CapabilityEnum', []string{}, var_capability_mutated), this.messages, this.modelConfig)
	mut var_requirements := iife_result_14
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(this.model, rt.new_null())))) {
		return (rt.call_method(var_requirements, 'areMetBy', [rt.call_method(this.model, 'metadata', []rt.PhpVal{})])).to_bool()
	}
	mut var_models := rt.call_method(this.registry, 'findModelsMetadataForSupport', [var_requirements.clone()])
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	return !(!rt.is_true(var_models))
	unsafe { goto end_label_1 }

catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'WordPress_AiClient_Common_Exception_InvalidArgumentException') {
		mut var_e := var_e_1.clone()
		return false
		unsafe { goto end_label_1 }
	}
	else {
		rt.throw_exception(var_e_1)
		unsafe { goto end_label_1 }
	}

end_label_1:
	return false
}

fn (mut this Class_WordPress_AiClient_Builders_PromptBuilder) issupportedfortextgeneration() bool {
	mut iife_temp_15 := Class_WordPress_AiClient_Providers_Models_Enums_CapabilityEnum{}
	mut iife_result_15 := iife_temp_15.textgeneration()
	return this.issupported(mut rt.cast_object_ptr[Class_WordPress_AiClient_Builders_?CapabilityEnum](iife_result_15))
}

fn (mut this Class_WordPress_AiClient_Builders_PromptBuilder) issupportedforimagegeneration() bool {
	mut iife_temp_16 := Class_WordPress_AiClient_Providers_Models_Enums_CapabilityEnum{}
	mut iife_result_16 := iife_temp_16.imagegeneration()
	return this.issupported(mut rt.cast_object_ptr[Class_WordPress_AiClient_Builders_?CapabilityEnum](iife_result_16))
}

fn (mut this Class_WordPress_AiClient_Builders_PromptBuilder) issupportedfortexttospeechconversion() bool {
	mut iife_temp_17 := Class_WordPress_AiClient_Providers_Models_Enums_CapabilityEnum{}
	mut iife_result_17 := iife_temp_17.texttospeechconversion()
	return this.issupported(mut rt.cast_object_ptr[Class_WordPress_AiClient_Builders_?CapabilityEnum](iife_result_17))
}

fn (mut this Class_WordPress_AiClient_Builders_PromptBuilder) issupportedforvideogeneration() bool {
	mut iife_temp_18 := Class_WordPress_AiClient_Providers_Models_Enums_CapabilityEnum{}
	mut iife_result_18 := iife_temp_18.videogeneration()
	return this.issupported(mut rt.cast_object_ptr[Class_WordPress_AiClient_Builders_?CapabilityEnum](iife_result_18))
}

fn (mut this Class_WordPress_AiClient_Builders_PromptBuilder) issupportedforspeechgeneration() bool {
	mut iife_temp_19 := Class_WordPress_AiClient_Providers_Models_Enums_CapabilityEnum{}
	mut iife_result_19 := iife_temp_19.speechgeneration()
	return this.issupported(mut rt.cast_object_ptr[Class_WordPress_AiClient_Builders_?CapabilityEnum](iife_result_19))
}

fn (mut this Class_WordPress_AiClient_Builders_PromptBuilder) issupportedformusicgeneration() bool {
	mut iife_temp_20 := Class_WordPress_AiClient_Providers_Models_Enums_CapabilityEnum{}
	mut iife_result_20 := iife_temp_20.musicgeneration()
	return this.issupported(mut rt.cast_object_ptr[Class_WordPress_AiClient_Builders_?CapabilityEnum](iife_result_20))
}

fn (mut this Class_WordPress_AiClient_Builders_PromptBuilder) issupportedforembeddinggeneration() bool {
	mut iife_temp_21 := Class_WordPress_AiClient_Providers_Models_Enums_CapabilityEnum{}
	mut iife_result_21 := iife_temp_21.embeddinggeneration()
	return this.issupported(mut rt.cast_object_ptr[Class_WordPress_AiClient_Builders_?CapabilityEnum](iife_result_21))
}

fn (mut this Class_WordPress_AiClient_Builders_PromptBuilder) generateresult(mut var_capability Class_WordPress_AiClient_Builders_?CapabilityEnum) rt.PhpVal {
	mut var_capability_mutated := var_capability
	this.validatemessages()
	if rt.is_true(rt.identical(var_capability_mutated, rt.new_null())) {
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(this.model, rt.new_null())))) {
			mut var_inferredCapability := this.infercapabilityfrommodelinterfaces(mut rt.cast_object_ptr[Class_WordPress_AiClient_Providers_Models_Contracts_ModelInterface](this.model))
			if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_inferredCapability, rt.new_null())))) {
			var_capability_mutated = var_inferredCapability.clone()
			}
		}
		if rt.is_true(rt.identical(var_capability_mutated, rt.new_null())) {
		var_capability_mutated = this.infercapabilityfromoutputmodalities()
		}
	}
	mut var_model := this.getconfiguredmodel(mut var_capability_mutated)
	this.dispatchevent(mut rt.cast_object_ptr[Class_WordPress_AiClient_Builders_object](create_wordpress_aiclient_events_beforegenerateresultevent(this.messages, var_model.clone(), var_capability_mutated)))
	mut var_result := this.executemodelgeneration(mut rt.cast_object_ptr[Class_WordPress_AiClient_Providers_Models_Contracts_ModelInterface](var_model), mut var_capability_mutated, mut rt.cast_object_ptr[Class_WordPress_AiClient_Builders_array](this.messages))
	this.dispatchevent(mut rt.cast_object_ptr[Class_WordPress_AiClient_Builders_object](create_wordpress_aiclient_events_aftergenerateresultevent(this.messages, var_model.clone(), var_capability_mutated, var_result.clone())))
	return var_result.clone()
}

fn (mut this Class_WordPress_AiClient_Builders_PromptBuilder) executemodelgeneration(mut var_model Class_WordPress_AiClient_Providers_Models_Contracts_ModelInterface, mut var_capability Class_WordPress_AiClient_Providers_Models_Enums_CapabilityEnum, mut var_messages Class_WordPress_AiClient_Builders_array) rt.PhpVal {
	mut var_model_mutated := var_model
	mut var_capability_mutated := var_capability
	if rt.is_true(rt.call_method(var_capability_mutated, 'isTextGeneration', []rt.PhpVal{})) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_model_mutated, 'WordPress_AiClient_Providers_Models_TextGeneration_Contracts_TextGenerationModelInterface')))))) {
			rt.throw_exception(rt.new_object('WordPress_AiClient_Common_Exception_RuntimeException', []string{}, create_wordpress_aiclient_common_exception_runtimeexception(rt.call_function('sprintf', [rt.new_string('Model "%s" does not support text generation.'), rt.call_method(rt.call_method(var_model_mutated, 'metadata', []rt.PhpVal{}), 'getId', []rt.PhpVal{})]))))
		}
		return rt.call_method(var_model_mutated, 'generateTextResult', [var_messages])
	}
	if rt.is_true(rt.call_method(var_capability_mutated, 'isImageGeneration', []rt.PhpVal{})) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_model_mutated, 'WordPress_AiClient_Providers_Models_ImageGeneration_Contracts_ImageGenerationModelInterface')))))) {
			rt.throw_exception(rt.new_object('WordPress_AiClient_Common_Exception_RuntimeException', []string{}, create_wordpress_aiclient_common_exception_runtimeexception(rt.call_function('sprintf', [rt.new_string('Model "%s" does not support image generation.'), rt.call_method(rt.call_method(var_model_mutated, 'metadata', []rt.PhpVal{}), 'getId', []rt.PhpVal{})]))))
		}
		return rt.call_method(var_model_mutated, 'generateImageResult', [var_messages])
	}
	if rt.is_true(rt.call_method(var_capability_mutated, 'isTextToSpeechConversion', []rt.PhpVal{})) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_model_mutated, 'WordPress_AiClient_Providers_Models_TextToSpeechConversion_Contracts_TextToSpeechConversionModelInterface')))))) {
			rt.throw_exception(rt.new_object('WordPress_AiClient_Common_Exception_RuntimeException', []string{}, create_wordpress_aiclient_common_exception_runtimeexception(rt.call_function('sprintf', [rt.new_string('Model "%s" does not support text-to-speech conversion.'), rt.call_method(rt.call_method(var_model_mutated, 'metadata', []rt.PhpVal{}), 'getId', []rt.PhpVal{})]))))
		}
		return rt.call_method(var_model_mutated, 'convertTextToSpeechResult', [var_messages])
	}
	if rt.is_true(rt.call_method(var_capability_mutated, 'isSpeechGeneration', []rt.PhpVal{})) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_model_mutated, 'WordPress_AiClient_Providers_Models_SpeechGeneration_Contracts_SpeechGenerationModelInterface')))))) {
			rt.throw_exception(rt.new_object('WordPress_AiClient_Common_Exception_RuntimeException', []string{}, create_wordpress_aiclient_common_exception_runtimeexception(rt.call_function('sprintf', [rt.new_string('Model "%s" does not support speech generation.'), rt.call_method(rt.call_method(var_model_mutated, 'metadata', []rt.PhpVal{}), 'getId', []rt.PhpVal{})]))))
		}
		return rt.call_method(var_model_mutated, 'generateSpeechResult', [var_messages])
	}
	if rt.is_true(rt.call_method(var_capability_mutated, 'isVideoGeneration', []rt.PhpVal{})) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_model_mutated, 'WordPress_AiClient_Providers_Models_VideoGeneration_Contracts_VideoGenerationModelInterface')))))) {
			rt.throw_exception(rt.new_object('WordPress_AiClient_Common_Exception_RuntimeException', []string{}, create_wordpress_aiclient_common_exception_runtimeexception(rt.call_function('sprintf', [rt.new_string('Model "%s" does not support video generation.'), rt.call_method(rt.call_method(var_model_mutated, 'metadata', []rt.PhpVal{}), 'getId', []rt.PhpVal{})]))))
		}
		return rt.call_method(var_model_mutated, 'generateVideoResult', [var_messages])
	}
	rt.throw_exception(rt.new_object('WordPress_AiClient_Common_Exception_RuntimeException', []string{}, create_wordpress_aiclient_common_exception_runtimeexception(rt.call_function('sprintf', [rt.new_string('Capability "%s" is not yet supported for generation.'), rt.get_property(var_capability_mutated, 'value')]))))
	return rt.new_null()
}

fn (mut this Class_WordPress_AiClient_Builders_PromptBuilder) generatetextresult() rt.PhpVal {
	mut iife_temp_22 := Class_WordPress_AiClient_Messages_Enums_ModalityEnum{}
	mut iife_result_22 := iife_temp_22.text()
	this.includeoutputmodalities(mut rt.cast_object_ptr[Class_WordPress_AiClient_Messages_Enums_ModalityEnum](iife_result_22))
	mut iife_temp_23 := Class_WordPress_AiClient_Providers_Models_Enums_CapabilityEnum{}
	mut iife_result_23 := iife_temp_23.textgeneration()
	return this.generateresult(mut rt.cast_object_ptr[Class_WordPress_AiClient_Builders_?CapabilityEnum](iife_result_23))
}

fn (mut this Class_WordPress_AiClient_Builders_PromptBuilder) generateimageresult() rt.PhpVal {
	mut iife_temp_24 := Class_WordPress_AiClient_Messages_Enums_ModalityEnum{}
	mut iife_result_24 := iife_temp_24.image()
	this.includeoutputmodalities(mut rt.cast_object_ptr[Class_WordPress_AiClient_Messages_Enums_ModalityEnum](iife_result_24))
	mut iife_temp_25 := Class_WordPress_AiClient_Providers_Models_Enums_CapabilityEnum{}
	mut iife_result_25 := iife_temp_25.imagegeneration()
	return this.generateresult(mut rt.cast_object_ptr[Class_WordPress_AiClient_Builders_?CapabilityEnum](iife_result_25))
}

fn (mut this Class_WordPress_AiClient_Builders_PromptBuilder) generatespeechresult() rt.PhpVal {
	mut iife_temp_26 := Class_WordPress_AiClient_Messages_Enums_ModalityEnum{}
	mut iife_result_26 := iife_temp_26.audio()
	this.includeoutputmodalities(mut rt.cast_object_ptr[Class_WordPress_AiClient_Messages_Enums_ModalityEnum](iife_result_26))
	mut iife_temp_27 := Class_WordPress_AiClient_Providers_Models_Enums_CapabilityEnum{}
	mut iife_result_27 := iife_temp_27.speechgeneration()
	return this.generateresult(mut rt.cast_object_ptr[Class_WordPress_AiClient_Builders_?CapabilityEnum](iife_result_27))
}

fn (mut this Class_WordPress_AiClient_Builders_PromptBuilder) converttexttospeechresult() rt.PhpVal {
	mut iife_temp_28 := Class_WordPress_AiClient_Messages_Enums_ModalityEnum{}
	mut iife_result_28 := iife_temp_28.audio()
	this.includeoutputmodalities(mut rt.cast_object_ptr[Class_WordPress_AiClient_Messages_Enums_ModalityEnum](iife_result_28))
	mut iife_temp_29 := Class_WordPress_AiClient_Providers_Models_Enums_CapabilityEnum{}
	mut iife_result_29 := iife_temp_29.texttospeechconversion()
	return this.generateresult(mut rt.cast_object_ptr[Class_WordPress_AiClient_Builders_?CapabilityEnum](iife_result_29))
}

fn (mut this Class_WordPress_AiClient_Builders_PromptBuilder) generatevideoresult() rt.PhpVal {
	mut iife_temp_30 := Class_WordPress_AiClient_Messages_Enums_ModalityEnum{}
	mut iife_result_30 := iife_temp_30.video()
	this.includeoutputmodalities(mut rt.cast_object_ptr[Class_WordPress_AiClient_Messages_Enums_ModalityEnum](iife_result_30))
	mut iife_temp_31 := Class_WordPress_AiClient_Providers_Models_Enums_CapabilityEnum{}
	mut iife_result_31 := iife_temp_31.videogeneration()
	return this.generateresult(mut rt.cast_object_ptr[Class_WordPress_AiClient_Builders_?CapabilityEnum](iife_result_31))
}

fn (mut this Class_WordPress_AiClient_Builders_PromptBuilder) generatetext() string {
	return (rt.call_method(this.generatetextresult(), 'toText', []rt.PhpVal{})).str()
}

fn (mut this Class_WordPress_AiClient_Builders_PromptBuilder) generatetexts(mut var_candidateCount Class_WordPress_AiClient_Builders_?int) rt.PhpVal {
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_candidateCount, rt.new_null())))) {
		this.usingcandidatecount(var_candidateCount)
	}
	return rt.call_method(this.generatetextresult(), 'toTexts', []rt.PhpVal{})
}

fn (mut this Class_WordPress_AiClient_Builders_PromptBuilder) generateimage() rt.PhpVal {
	return rt.call_method(this.generateimageresult(), 'toFile', []rt.PhpVal{})
}

fn (mut this Class_WordPress_AiClient_Builders_PromptBuilder) generateimages(mut var_candidateCount Class_WordPress_AiClient_Builders_?int) rt.PhpVal {
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_candidateCount, rt.new_null())))) {
		this.usingcandidatecount(var_candidateCount)
	}
	return rt.call_method(this.generateimageresult(), 'toFiles', []rt.PhpVal{})
}

fn (mut this Class_WordPress_AiClient_Builders_PromptBuilder) converttexttospeech() rt.PhpVal {
	return rt.call_method(this.converttexttospeechresult(), 'toFile', []rt.PhpVal{})
}

fn (mut this Class_WordPress_AiClient_Builders_PromptBuilder) converttexttospeeches(mut var_candidateCount Class_WordPress_AiClient_Builders_?int) rt.PhpVal {
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_candidateCount, rt.new_null())))) {
		this.usingcandidatecount(var_candidateCount)
	}
	return rt.call_method(this.converttexttospeechresult(), 'toFiles', []rt.PhpVal{})
}

fn (mut this Class_WordPress_AiClient_Builders_PromptBuilder) generatespeech() rt.PhpVal {
	return rt.call_method(this.generatespeechresult(), 'toFile', []rt.PhpVal{})
}

fn (mut this Class_WordPress_AiClient_Builders_PromptBuilder) generatespeeches(mut var_candidateCount Class_WordPress_AiClient_Builders_?int) rt.PhpVal {
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_candidateCount, rt.new_null())))) {
		this.usingcandidatecount(var_candidateCount)
	}
	return rt.call_method(this.generatespeechresult(), 'toFiles', []rt.PhpVal{})
}

fn (mut this Class_WordPress_AiClient_Builders_PromptBuilder) generatevideo() rt.PhpVal {
	return rt.call_method(this.generatevideoresult(), 'toFile', []rt.PhpVal{})
}

fn (mut this Class_WordPress_AiClient_Builders_PromptBuilder) generatevideos(mut var_candidateCount Class_WordPress_AiClient_Builders_?int) rt.PhpVal {
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_candidateCount, rt.new_null())))) {
		this.usingcandidatecount(var_candidateCount)
	}
	return rt.call_method(this.generatevideoresult(), 'toFiles', []rt.PhpVal{})
}

fn (mut this Class_WordPress_AiClient_Builders_PromptBuilder) appendparttomessages(mut var_part Class_WordPress_AiClient_Messages_DTO_MessagePart) {
	mut var_part_mutated := var_part
	mut var_lastMessage := rt.call_function('end', [this.messages])
	if rt.is_true(rt.new_bool(rt.instance_of(var_lastMessage, 'WordPress_AiClient_Messages_DTO_Message'))) && rt.is_true(rt.call_method(rt.call_method(var_lastMessage, 'getRole', []rt.PhpVal{}), 'isUser', []rt.PhpVal{})) {
		rt.call_function('array_pop', [this.messages])
		this.messages.array_push(rt.call_method(var_lastMessage, 'withPart', [var_part_mutated]))
		return
	}
	this.messages.array_push(create_wordpress_aiclient_messages_dto_usermessage(rt.create_array([rt.ArrayItem{ key: none, val: var_part_mutated }])))
}

fn (mut this Class_WordPress_AiClient_Builders_PromptBuilder) getconfiguredmodel(mut var_capability Class_WordPress_AiClient_Providers_Models_Enums_CapabilityEnum) rt.PhpVal {
	mut var_providerId := rt.new_null()
	mut var_modelId := rt.new_null()
	mut var_capability_mutated := var_capability
	mut iife_temp_32 := Class_WordPress_AiClient_Providers_Models_DTO_ModelRequirements{}
	mut iife_result_32 := iife_temp_32.frompromptdata(rt.new_object('WordPress_AiClient_Providers_Models_Enums_CapabilityEnum', []string{}, var_capability_mutated), this.messages, this.modelConfig)
	mut var_requirements := iife_result_32
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(this.model, rt.new_null())))) {
		mut var_model := this.model
		rt.call_method(var_model, 'setConfig', [this.modelConfig])
		rt.call_method(this.registry, 'bindModelDependencies', [var_model.clone()])
		this.bindmodelrequestoptions(mut rt.cast_object_ptr[Class_WordPress_AiClient_Providers_Models_Contracts_ModelInterface](var_model))
		return var_model.clone()
	}
	mut var_candidateMap := this.getcandidatemodelsmap(mut rt.cast_object_ptr[Class_WordPress_AiClient_Providers_Models_DTO_ModelRequirements](var_requirements))
	if !rt.is_true(var_candidateMap) {
		mut var_message := rt.call_function('sprintf', [rt.new_string('No models found that support %s for this prompt.'), rt.get_property(var_capability_mutated, 'value')])
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(this.providerIdOrClassName, rt.new_null())))) {
		var_message = rt.call_function('sprintf', [rt.new_string('No models found for provider "%s" that support %s for this prompt.'), this.providerIdOrClassName, rt.get_property(var_capability_mutated, 'value')])
		}
		rt.throw_exception(rt.new_object('WordPress_AiClient_Common_Exception_InvalidArgumentException', []string{}, create_wordpress_aiclient_common_exception_invalidargumentexception(var_message.clone())))
	}
	if !(!rt.is_true(this.modelPreferenceKeys)) {
		mut var_matchingPreferences := rt.call_function('array_intersect_key', [rt.call_function('array_flip', [this.modelPreferenceKeys]), var_candidateMap.clone()])
		if !(!rt.is_true(var_matchingPreferences)) {
			mut var_firstMatchKey := rt.call_function('key', [var_matchingPreferences.clone()])
			mut list_tmp_2 := var_candidateMap.array_get(var_firstMatchKey)
			var_providerId = (list_tmp_2).array_get(0)
			var_modelId = (list_tmp_2).array_get(1)
			var_model = rt.call_method(this.registry, 'getProviderModel', [var_providerId.clone(), var_modelId.clone(), this.modelConfig])
			this.bindmodelrequestoptions(mut rt.cast_object_ptr[Class_WordPress_AiClient_Providers_Models_Contracts_ModelInterface](var_model))
			return var_model.clone()
		}
	}
	mut list_tmp_3 := rt.call_function('reset', [var_candidateMap.clone()])
	var_providerId = (list_tmp_3).array_get(0)
	var_modelId = (list_tmp_3).array_get(1)
	var_model = rt.call_method(this.registry, 'getProviderModel', [var_providerId.clone(), var_modelId.clone(), this.modelConfig])
	this.bindmodelrequestoptions(mut rt.cast_object_ptr[Class_WordPress_AiClient_Providers_Models_Contracts_ModelInterface](var_model))
	return var_model.clone()
}

fn (mut this Class_WordPress_AiClient_Builders_PromptBuilder) bindmodelrequestoptions(mut var_model Class_WordPress_AiClient_Providers_Models_Contracts_ModelInterface) {
	mut var_model_mutated := var_model
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(this.requestOptions, rt.new_null())))) && rt.is_true(rt.new_bool(rt.instance_of(var_model_mutated, 'WordPress_AiClient_Providers_ApiBasedImplementation_Contracts_ApiBasedModelInterface'))) {
		rt.call_method(var_model_mutated, 'setRequestOptions', [this.requestOptions])
	}
}

fn (mut this Class_WordPress_AiClient_Builders_PromptBuilder) getcandidatemodelsmap(mut var_requirements Class_WordPress_AiClient_Providers_Models_DTO_ModelRequirements) rt.PhpVal {
	mut var_requirements_mutated := var_requirements
	if rt.is_true(rt.identical(this.providerIdOrClassName, rt.new_null())) {
		mut var_providerModelsMetadata := rt.call_method(this.registry, 'findModelsMetadataForSupport', [var_requirements_mutated])
		mut var_candidateMap := rt.new_array()
		mut iter_4 := var_providerModelsMetadata.iterator()
		for {
			item_4 := iter_4.next() or { break }
			mut var_providerModels := item_4.val
		mut var_providerId := rt.call_method(rt.call_method(var_providerModels, 'getProvider', []rt.PhpVal{}), 'getId', []rt.PhpVal{})
		mut var_providerMap := this.generatemapfromcandidates((var_providerId).str(), mut rt.cast_object_ptr[Class_WordPress_AiClient_Builders_array](rt.call_method(var_providerModels, 'getModels', []rt.PhpVal{})))
		var_candidateMap = rt.add(var_candidateMap, var_providerMap)
		}
		return var_candidateMap.clone()
	}
	mut var_modelsMetadata := rt.call_method(this.registry, 'findProviderModelsMetadataForSupport', [this.providerIdOrClassName, var_requirements_mutated])
	mut var_providerId := rt.call_method(this.registry, 'getProviderId', [this.providerIdOrClassName])
	return this.generatemapfromcandidates((var_providerId).str(), mut rt.cast_object_ptr[Class_WordPress_AiClient_Builders_array](var_modelsMetadata))
}

fn (mut this Class_WordPress_AiClient_Builders_PromptBuilder) generatemapfromcandidates(providerId string, mut var_modelsMetadata Class_WordPress_AiClient_Builders_array) rt.PhpVal {
	mut providerId_mutated := providerId
	mut var_modelsMetadata_mutated := var_modelsMetadata
	mut var_map := rt.new_array()
	mut iter_5 := var_modelsMetadata_mutated.iterator()
	for {
		item_5 := iter_5.next() or { break }
		mut var_modelMetadata := item_5.val
		mut var_modelId := rt.call_method(var_modelMetadata, 'getId', []rt.PhpVal{})
		mut var_providerModelKey := rt.new_string(this.createprovidermodelpreferencekey(providerId_mutated, (var_modelId).str()))
		var_map.array_set(var_providerModelKey, rt.create_array([rt.ArrayItem{ key: none, val: providerId_mutated }, rt.ArrayItem{ key: none, val: var_modelId }]))
		mut var_modelKey := rt.new_string(this.createmodelpreferencekey((var_modelId).str()))
		var_map.array_set(var_modelKey, rt.create_array([rt.ArrayItem{ key: none, val: providerId_mutated }, rt.ArrayItem{ key: none, val: var_modelId }]))
	}
	return var_map.clone()
}

fn (mut this Class_WordPress_AiClient_Builders_PromptBuilder) normalizepreferenceidentifier(var_value rt.PhpVal, emptyMessage string) string {
	if !(var_value.clone().is_string()) {
		rt.throw_exception(rt.new_object('WordPress_AiClient_Common_Exception_InvalidArgumentException', []string{}, create_wordpress_aiclient_common_exception_invalidargumentexception(rt.new_string(emptyMessage))))
	}
	mut var_trimmed := rt.new_string(var_value.clone().to_string().trim_space())
	if rt.is_true(rt.identical(var_trimmed, rt.new_string(''))) {
		rt.throw_exception(rt.new_object('WordPress_AiClient_Common_Exception_InvalidArgumentException', []string{}, create_wordpress_aiclient_common_exception_invalidargumentexception(rt.new_string(emptyMessage))))
	}
	return (var_trimmed).str()
}

fn (mut this Class_WordPress_AiClient_Builders_PromptBuilder) createprovidermodelpreferencekey(providerId string, modelId string) string {
	mut providerId_mutated := providerId
	mut modelId_mutated := modelId
	return 'providerModel::' + providerId_mutated + '::' + modelId_mutated
}

fn (mut this Class_WordPress_AiClient_Builders_PromptBuilder) createmodelpreferencekey(modelId string) string {
	mut modelId_mutated := modelId
	return 'model::' + modelId_mutated
}

fn (mut this Class_WordPress_AiClient_Builders_PromptBuilder) parsemessage(var_input rt.PhpVal, mut var_defaultRole Class_WordPress_AiClient_Messages_Enums_MessageRoleEnum) rt.PhpVal {
	if rt.is_true(rt.new_bool(rt.instance_of(var_input, 'WordPress_AiClient_Messages_DTO_Message'))) {
		return var_input.clone()
	}
	if rt.is_true(rt.new_bool(rt.instance_of(var_input, 'WordPress_AiClient_Messages_DTO_MessagePart'))) {
		return rt.new_object('WordPress_AiClient_Messages_DTO_Message', []string{}, create_wordpress_aiclient_messages_dto_message(var_defaultRole, rt.create_array([rt.ArrayItem{ key: none, val: var_input }])))
	}
	if rt.is_true(rt.new_bool(var_input.clone().is_string())) {
		if rt.is_true(rt.identical(rt.new_string(var_input.clone().to_string().trim_space()), rt.new_string(''))) {
			rt.throw_exception(rt.new_object('WordPress_AiClient_Common_Exception_InvalidArgumentException', []string{}, create_wordpress_aiclient_common_exception_invalidargumentexception(rt.new_string('Cannot create a message from an empty string.'))))
		}
		return rt.new_object('WordPress_AiClient_Messages_DTO_Message', []string{}, create_wordpress_aiclient_messages_dto_message(var_defaultRole, rt.create_array([rt.ArrayItem{ key: none, val: create_wordpress_aiclient_messages_dto_messagepart(var_input.clone()) }])))
	}
	if !(var_input.clone().is_array()) {
		rt.throw_exception(rt.new_object('WordPress_AiClient_Common_Exception_InvalidArgumentException', []string{}, create_wordpress_aiclient_common_exception_invalidargumentexception('Input must be a string, MessagePart, MessagePartArrayShape, ' + 'a list of string|MessagePart|MessagePartArrayShape, or a Message instance.')))
	}
	mut iife_temp_33 := Class_WordPress_AiClient_Messages_DTO_Message{}
	mut iife_result_33 := iife_temp_33.isarrayshape(var_input.clone())
	if rt.is_true(iife_result_33) {
		mut iife_temp_34 := Class_WordPress_AiClient_Messages_DTO_Message{}
		mut iife_result_34 := iife_temp_34.fromarray(var_input.clone())
		return iife_result_34
	}
	mut iife_temp_35 := Class_WordPress_AiClient_Messages_DTO_MessagePart{}
	mut iife_result_35 := iife_temp_35.isarrayshape(var_input.clone())
	if rt.is_true(iife_result_35) {
		mut iife_temp_36 := Class_WordPress_AiClient_Messages_DTO_MessagePart{}
		mut iife_result_36 := iife_temp_36.fromarray(var_input.clone())
		return rt.new_object('WordPress_AiClient_Messages_DTO_Message', []string{}, create_wordpress_aiclient_messages_dto_message(var_defaultRole, rt.create_array([rt.ArrayItem{ key: none, val: iife_result_36 }])))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('array_is_list', [var_input.clone()]))))) {
		rt.throw_exception(rt.new_object('WordPress_AiClient_Common_Exception_InvalidArgumentException', []string{}, create_wordpress_aiclient_common_exception_invalidargumentexception(rt.new_string('Array input must be a list array.'))))
	}
	if !rt.is_true(var_input) {
		rt.throw_exception(rt.new_object('WordPress_AiClient_Common_Exception_InvalidArgumentException', []string{}, create_wordpress_aiclient_common_exception_invalidargumentexception(rt.new_string('Cannot create a message from an empty array.'))))
	}
	mut var_parts := rt.new_array()
	mut iter_6 := var_input.iterator()
	for {
		item_6 := iter_6.next() or { break }
		mut var_item := item_6.val
		if rt.is_true(rt.new_bool(var_item.clone().is_string())) {
			var_parts.array_push(create_wordpress_aiclient_messages_dto_messagepart(var_item.clone()))
		} else if rt.is_true(rt.new_bool(rt.instance_of(var_item, 'WordPress_AiClient_Messages_DTO_MessagePart'))) {
			var_parts.array_push(var_item.clone())
		mut iife_temp_37 := Class_WordPress_AiClient_Messages_DTO_MessagePart{}
		mut iife_result_37 := iife_temp_37.isarrayshape(var_item.clone())
		} else if var_item.clone().is_array() && rt.is_true(iife_result_37) {
			mut iife_temp_38 := Class_WordPress_AiClient_Messages_DTO_MessagePart{}
			mut iife_result_38 := iife_temp_38.fromarray(var_item.clone())
			var_parts.array_push(iife_result_38)
		} else {
			rt.throw_exception(rt.new_object('WordPress_AiClient_Common_Exception_InvalidArgumentException', []string{}, create_wordpress_aiclient_common_exception_invalidargumentexception(rt.new_string('Array items must be strings, MessagePart instances, or MessagePartArrayShape.'))))
		}
	}
	return rt.new_object('WordPress_AiClient_Messages_DTO_Message', []string{}, create_wordpress_aiclient_messages_dto_message(var_defaultRole, var_parts.clone()))
}

fn (mut this Class_WordPress_AiClient_Builders_PromptBuilder) validatemessages() {
	if !rt.is_true(this.messages) {
		rt.throw_exception(rt.new_object('WordPress_AiClient_Common_Exception_InvalidArgumentException', []string{}, create_wordpress_aiclient_common_exception_invalidargumentexception(rt.new_string('Cannot generate from an empty prompt. Add content using withText() or similar methods.'))))
	}
	mut var_firstMessage := rt.call_function('reset', [this.messages])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(rt.call_method(var_firstMessage, 'getRole', []rt.PhpVal{}), 'isUser', []rt.PhpVal{}))))) {
		rt.throw_exception(rt.new_object('WordPress_AiClient_Common_Exception_InvalidArgumentException', []string{}, create_wordpress_aiclient_common_exception_invalidargumentexception('The first message must be from a user role, not from ' + (rt.get_property(rt.call_method(var_firstMessage, 'getRole', []rt.PhpVal{}), 'value')).str())))
	}
	mut var_lastMessage := rt.call_function('end', [this.messages])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(rt.call_method(var_lastMessage, 'getRole', []rt.PhpVal{}), 'isUser', []rt.PhpVal{}))))) {
		rt.throw_exception(rt.new_object('WordPress_AiClient_Common_Exception_InvalidArgumentException', []string{}, create_wordpress_aiclient_common_exception_invalidargumentexception('The last message must be from a user role, not from ' + (rt.get_property(rt.call_method(var_lastMessage, 'getRole', []rt.PhpVal{}), 'value')).str())))
	}
	if !rt.is_true(rt.call_method(var_lastMessage, 'getParts', []rt.PhpVal{})) {
		rt.throw_exception(rt.new_object('WordPress_AiClient_Common_Exception_InvalidArgumentException', []string{}, create_wordpress_aiclient_common_exception_invalidargumentexception(rt.new_string('The last message must have content parts. Add content using withText() or similar methods.'))))
	}
}

fn (mut this Class_WordPress_AiClient_Builders_PromptBuilder) ismessageslist(var_value rt.PhpVal) bool {
	if !(var_value.clone().is_array()) || !rt.is_true(var_value) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('array_is_list', [var_value.clone()]))))) {
		return false
	}
	mut iter_7 := var_value.iterator()
	for {
		item_7 := iter_7.next() or { break }
		mut var_item := item_7.val
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_item, 'WordPress_AiClient_Messages_DTO_Message')))))) {
			return false
		}
	}
	return true
}

fn (mut this Class_WordPress_AiClient_Builders_PromptBuilder) includeoutputmodalities(mut var_modalities Class_WordPress_AiClient_Messages_Enums_ModalityEnum) {
	mut var_existing := rt.call_method(this.modelConfig, 'getOutputModalities', []rt.PhpVal{})
	if rt.is_true(rt.identical(var_existing, rt.new_null())) {
		rt.call_method(this.modelConfig, 'setOutputModalities', [var_modalities])
		return
	}
	mut var_existingValues := rt.new_array()
	mut iter_8 := var_existing.iterator()
	for {
		item_8 := iter_8.next() or { break }
		mut var_existingModality := item_8.val
		var_existingValues.array_set(rt.get_property(var_existingModality, 'value'), true)
	}
	mut var_toAdd := rt.new_array()
	mut iter_9 := var_modalities.iterator()
	for {
		item_9 := iter_9.next() or { break }
		mut var_modality := item_9.val
		if !(var_existingValues.array_isset(rt.get_property(var_modality, 'value'))) {
			var_toAdd.array_push(var_modality.clone())
		}
	}
	if !(!rt.is_true(var_toAdd)) {
		rt.call_method(this.modelConfig, 'setOutputModalities', [rt.call_function('array_merge', [var_existing.clone(), var_toAdd.clone()])])
	}
}

fn (mut this Class_WordPress_AiClient_Builders_PromptBuilder) dispatchevent(mut var_event Class_WordPress_AiClient_Builders_object) {
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(this.eventDispatcher, rt.new_null())))) {
		rt.call_method(this.eventDispatcher, 'dispatch', [var_event])
	}
}

struct Class_WordPress_AiClient_Providers_Models_DTO_ModelConfig {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClient_Messages_Enums_MessageRoleEnum {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClient_Messages_DTO_MessagePart {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClient_Files_DTO_File {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClient_Common_Exception_InvalidArgumentException {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClient_Providers_Models_Enums_CapabilityEnum {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClient_Common_Exception_RuntimeException {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClient_Providers_Models_DTO_ModelRequirements {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClient_Events_BeforeGenerateResultEvent {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClient_Events_AfterGenerateResultEvent {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClient_Messages_Enums_ModalityEnum {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClient_Messages_DTO_UserMessage {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClient_Messages_DTO_Message {
	rt.PhpObjectBase
}

fn create_wordpress_aiclient_builders_promptbuilder(arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) &Class_WordPress_AiClient_Builders_PromptBuilder {
	mut obj := &Class_WordPress_AiClient_Builders_PromptBuilder{
		PhpObjectBase: rt.PhpObjectBase{}
		registry: rt.new_null()
		messages: rt.new_array()
		model: rt.new_null()
		modelPreferenceKeys: rt.new_array()
		providerIdOrClassName: rt.new_null()
		modelConfig: rt.new_null()
		requestOptions: rt.new_null()
		eventDispatcher: rt.new_null()
	}
	obj.construct(arg_0, arg_1, arg_2)
	return obj
}

fn create_wordpress_aiclient_providers_models_dto_modelconfig(_args ...rt.PhpVal) &Class_WordPress_AiClient_Providers_Models_DTO_ModelConfig {
	mut obj := &Class_WordPress_AiClient_Providers_Models_DTO_ModelConfig{
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

fn create_wordpress_aiclient_messages_dto_messagepart(_args ...rt.PhpVal) &Class_WordPress_AiClient_Messages_DTO_MessagePart {
	mut obj := &Class_WordPress_AiClient_Messages_DTO_MessagePart{
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

fn create_wordpress_aiclient_common_exception_invalidargumentexception(_args ...rt.PhpVal) &Class_WordPress_AiClient_Common_Exception_InvalidArgumentException {
	mut obj := &Class_WordPress_AiClient_Common_Exception_InvalidArgumentException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wordpress_aiclient_providers_models_enums_capabilityenum(_args ...rt.PhpVal) &Class_WordPress_AiClient_Providers_Models_Enums_CapabilityEnum {
	mut obj := &Class_WordPress_AiClient_Providers_Models_Enums_CapabilityEnum{
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

fn create_wordpress_aiclient_providers_models_dto_modelrequirements(_args ...rt.PhpVal) &Class_WordPress_AiClient_Providers_Models_DTO_ModelRequirements {
	mut obj := &Class_WordPress_AiClient_Providers_Models_DTO_ModelRequirements{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wordpress_aiclient_events_beforegenerateresultevent(_args ...rt.PhpVal) &Class_WordPress_AiClient_Events_BeforeGenerateResultEvent {
	mut obj := &Class_WordPress_AiClient_Events_BeforeGenerateResultEvent{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wordpress_aiclient_events_aftergenerateresultevent(_args ...rt.PhpVal) &Class_WordPress_AiClient_Events_AfterGenerateResultEvent {
	mut obj := &Class_WordPress_AiClient_Events_AfterGenerateResultEvent{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wordpress_aiclient_messages_enums_modalityenum(_args ...rt.PhpVal) &Class_WordPress_AiClient_Messages_Enums_ModalityEnum {
	mut obj := &Class_WordPress_AiClient_Messages_Enums_ModalityEnum{
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

fn create_wordpress_aiclient_messages_dto_message(_args ...rt.PhpVal) &Class_WordPress_AiClient_Messages_DTO_Message {
	mut obj := &Class_WordPress_AiClient_Messages_DTO_Message{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WordPress_AiClient_Builders_PromptBuilder) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WordPress_AiClient_Providers_ProviderRegistry](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_WordPress_AiClient_Builders_?EventDispatcherInterface](if args.len > 2 { args[2] } else { rt.new_null() })
			this.construct(mut dispatch_arg_0, dispatch_arg_1, mut dispatch_arg_2)
			return rt.new_null()
		}
		'__clone' {
			this.magic_clone()
			return rt.new_null()
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
		'withFunctionResponse' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WordPress_AiClient_Tools_DTO_FunctionResponse](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.withfunctionresponse(mut dispatch_arg_0)
		}
		'withMessageParts' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WordPress_AiClient_Messages_DTO_MessagePart](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.withmessageparts(mut dispatch_arg_0)
		}
		'withHistory' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WordPress_AiClient_Messages_DTO_Message](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.withhistory(mut dispatch_arg_0)
		}
		'usingModel' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WordPress_AiClient_Providers_Models_Contracts_ModelInterface](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.usingmodel(mut dispatch_arg_0)
		}
		'usingModelPreference' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.usingmodelpreference(dispatch_arg_0)
		}
		'usingModelConfig' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WordPress_AiClient_Providers_Models_DTO_ModelConfig](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.usingmodelconfig(mut dispatch_arg_0)
		}
		'usingProvider' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.usingprovider(dispatch_arg_0)
		}
		'usingSystemInstruction' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.usingsysteminstruction(dispatch_arg_0)
		}
		'usingMaxTokens' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			return this.usingmaxtokens(dispatch_arg_0)
		}
		'usingTemperature' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_f64()
			return this.usingtemperature(dispatch_arg_0)
		}
		'usingTopP' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_f64()
			return this.usingtopp(dispatch_arg_0)
		}
		'usingTopK' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			return this.usingtopk(dispatch_arg_0)
		}
		'usingStopSequences' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.usingstopsequences(dispatch_arg_0)
		}
		'usingCandidateCount' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			return this.usingcandidatecount(dispatch_arg_0)
		}
		'usingFunctionDeclarations' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WordPress_AiClient_Tools_DTO_FunctionDeclaration](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.usingfunctiondeclarations(mut dispatch_arg_0)
		}
		'usingPresencePenalty' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_f64()
			return this.usingpresencepenalty(dispatch_arg_0)
		}
		'usingFrequencyPenalty' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_f64()
			return this.usingfrequencypenalty(dispatch_arg_0)
		}
		'usingWebSearch' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WordPress_AiClient_Tools_DTO_WebSearch](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.usingwebsearch(mut dispatch_arg_0)
		}
		'usingRequestOptions' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WordPress_AiClient_Providers_Http_DTO_RequestOptions](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.usingrequestoptions(mut dispatch_arg_0)
		}
		'usingTopLogprobs' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WordPress_AiClient_Builders_?int](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.usingtoplogprobs(mut dispatch_arg_0)
		}
		'asOutputMimeType' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.asoutputmimetype(dispatch_arg_0)
		}
		'asOutputSchema' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WordPress_AiClient_Builders_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.asoutputschema(mut dispatch_arg_0)
		}
		'asOutputModalities' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WordPress_AiClient_Messages_Enums_ModalityEnum](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.asoutputmodalities(mut dispatch_arg_0)
		}
		'asOutputFileType' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WordPress_AiClient_Files_Enums_FileTypeEnum](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.asoutputfiletype(mut dispatch_arg_0)
		}
		'asOutputMediaOrientation' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WordPress_AiClient_Files_Enums_MediaOrientationEnum](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.asoutputmediaorientation(mut dispatch_arg_0)
		}
		'asOutputMediaAspectRatio' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.asoutputmediaaspectratio(dispatch_arg_0)
		}
		'asOutputSpeechVoice' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.asoutputspeechvoice(dispatch_arg_0)
		}
		'asJsonResponse' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WordPress_AiClient_Builders_?array](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.asjsonresponse(mut dispatch_arg_0)
		}
		'inferCapabilityFromOutputModalities' {
			return this.infercapabilityfromoutputmodalities()
		}
		'inferCapabilityFromModelInterfaces' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WordPress_AiClient_Providers_Models_Contracts_ModelInterface](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.infercapabilityfrommodelinterfaces(mut dispatch_arg_0)
		}
		'isSupported' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WordPress_AiClient_Builders_?CapabilityEnum](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_bool(this.issupported(mut dispatch_arg_0))
		}
		'isSupportedForTextGeneration' {
			return rt.new_bool(this.issupportedfortextgeneration())
		}
		'isSupportedForImageGeneration' {
			return rt.new_bool(this.issupportedforimagegeneration())
		}
		'isSupportedForTextToSpeechConversion' {
			return rt.new_bool(this.issupportedfortexttospeechconversion())
		}
		'isSupportedForVideoGeneration' {
			return rt.new_bool(this.issupportedforvideogeneration())
		}
		'isSupportedForSpeechGeneration' {
			return rt.new_bool(this.issupportedforspeechgeneration())
		}
		'isSupportedForMusicGeneration' {
			return rt.new_bool(this.issupportedformusicgeneration())
		}
		'isSupportedForEmbeddingGeneration' {
			return rt.new_bool(this.issupportedforembeddinggeneration())
		}
		'generateResult' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WordPress_AiClient_Builders_?CapabilityEnum](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.generateresult(mut dispatch_arg_0)
		}
		'executeModelGeneration' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WordPress_AiClient_Providers_Models_Contracts_ModelInterface](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_WordPress_AiClient_Providers_Models_Enums_CapabilityEnum](if args.len > 1 { args[1] } else { rt.new_null() })
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_WordPress_AiClient_Builders_array](if args.len > 2 { args[2] } else { rt.new_null() })
			return this.executemodelgeneration(mut dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2)
		}
		'generateTextResult' {
			return this.generatetextresult()
		}
		'generateImageResult' {
			return this.generateimageresult()
		}
		'generateSpeechResult' {
			return this.generatespeechresult()
		}
		'convertTextToSpeechResult' {
			return this.converttexttospeechresult()
		}
		'generateVideoResult' {
			return this.generatevideoresult()
		}
		'generateText' {
			return rt.new_string(this.generatetext())
		}
		'generateTexts' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WordPress_AiClient_Builders_?int](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.generatetexts(mut dispatch_arg_0)
		}
		'generateImage' {
			return this.generateimage()
		}
		'generateImages' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WordPress_AiClient_Builders_?int](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.generateimages(mut dispatch_arg_0)
		}
		'convertTextToSpeech' {
			return this.converttexttospeech()
		}
		'convertTextToSpeeches' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WordPress_AiClient_Builders_?int](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.converttexttospeeches(mut dispatch_arg_0)
		}
		'generateSpeech' {
			return this.generatespeech()
		}
		'generateSpeeches' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WordPress_AiClient_Builders_?int](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.generatespeeches(mut dispatch_arg_0)
		}
		'generateVideo' {
			return this.generatevideo()
		}
		'generateVideos' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WordPress_AiClient_Builders_?int](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.generatevideos(mut dispatch_arg_0)
		}
		'appendPartToMessages' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WordPress_AiClient_Messages_DTO_MessagePart](if args.len > 0 { args[0] } else { rt.new_null() })
			this.appendparttomessages(mut dispatch_arg_0)
			return rt.new_null()
		}
		'getConfiguredModel' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WordPress_AiClient_Providers_Models_Enums_CapabilityEnum](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.getconfiguredmodel(mut dispatch_arg_0)
		}
		'bindModelRequestOptions' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WordPress_AiClient_Providers_Models_Contracts_ModelInterface](if args.len > 0 { args[0] } else { rt.new_null() })
			this.bindmodelrequestoptions(mut dispatch_arg_0)
			return rt.new_null()
		}
		'getCandidateModelsMap' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WordPress_AiClient_Providers_Models_DTO_ModelRequirements](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.getcandidatemodelsmap(mut dispatch_arg_0)
		}
		'generateMapFromCandidates' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_WordPress_AiClient_Builders_array](if args.len > 1 { args[1] } else { rt.new_null() })
			return this.generatemapfromcandidates(dispatch_arg_0, mut dispatch_arg_1)
		}
		'normalizePreferenceIdentifier' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return rt.new_string(this.normalizepreferenceidentifier(dispatch_arg_0, dispatch_arg_1))
		}
		'createProviderModelPreferenceKey' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return rt.new_string(this.createprovidermodelpreferencekey(dispatch_arg_0, dispatch_arg_1))
		}
		'createModelPreferenceKey' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(this.createmodelpreferencekey(dispatch_arg_0))
		}
		'parseMessage' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_WordPress_AiClient_Messages_Enums_MessageRoleEnum](if args.len > 1 { args[1] } else { rt.new_null() })
			return this.parsemessage(dispatch_arg_0, mut dispatch_arg_1)
		}
		'validateMessages' {
			this.validatemessages()
			return rt.new_null()
		}
		'isMessagesList' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.ismessageslist(dispatch_arg_0))
		}
		'includeOutputModalities' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WordPress_AiClient_Messages_Enums_ModalityEnum](if args.len > 0 { args[0] } else { rt.new_null() })
			this.includeoutputmodalities(mut dispatch_arg_0)
			return rt.new_null()
		}
		'dispatchEvent' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WordPress_AiClient_Builders_object](if args.len > 0 { args[0] } else { rt.new_null() })
			this.dispatchevent(mut dispatch_arg_0)
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_WordPress_AiClient_Builders_PromptBuilder) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'registry' { return this.registry }
		'messages' { return this.messages }
		'model' { return this.model }
		'modelPreferenceKeys' { return this.modelPreferenceKeys }
		'providerIdOrClassName' { return this.providerIdOrClassName }
		'modelConfig' { return this.modelConfig }
		'requestOptions' { return this.requestOptions }
		'eventDispatcher' { return this.eventDispatcher }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WordPress_AiClient_Builders_PromptBuilder) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'registry' { this.registry = val; return true }
		'messages' { this.messages = val; return true }
		'model' { this.model = val; return true }
		'modelPreferenceKeys' { this.modelPreferenceKeys = val; return true }
		'providerIdOrClassName' { this.providerIdOrClassName = val; return true }
		'modelConfig' { this.modelConfig = val; return true }
		'requestOptions' { this.requestOptions = val; return true }
		'eventDispatcher' { this.eventDispatcher = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
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


fn (mut this Class_WordPress_AiClient_Files_DTO_File) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WordPress_AiClient_Files_DTO_File) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClient_Files_DTO_File) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_WordPress_AiClient_Providers_Models_Enums_CapabilityEnum) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WordPress_AiClient_Providers_Models_Enums_CapabilityEnum) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClient_Providers_Models_Enums_CapabilityEnum) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_WordPress_AiClient_Providers_Models_DTO_ModelRequirements) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WordPress_AiClient_Providers_Models_DTO_ModelRequirements) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClient_Providers_Models_DTO_ModelRequirements) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WordPress_AiClient_Events_BeforeGenerateResultEvent) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WordPress_AiClient_Events_BeforeGenerateResultEvent) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClient_Events_BeforeGenerateResultEvent) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WordPress_AiClient_Events_AfterGenerateResultEvent) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WordPress_AiClient_Events_AfterGenerateResultEvent) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClient_Events_AfterGenerateResultEvent) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WordPress_AiClient_Messages_Enums_ModalityEnum) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WordPress_AiClient_Messages_Enums_ModalityEnum) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClient_Messages_Enums_ModalityEnum) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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
